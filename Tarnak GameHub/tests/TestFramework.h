#pragma once

#include <iostream>
#include <string>
#include <vector>
#include <functional>
#include <chrono>
#include <sstream>

// Simple test framework
namespace Tarnak::Test {

class TestFramework {
public:
    struct TestCase {
        std::string name;
        std::function<void()> test;
        bool passed = false;
        std::string error;
    };
    
    static TestFramework& Instance() {
        static TestFramework instance;
        return instance;
    }
    
    void RegisterTest(const std::string& name, std::function<void()> test) {
        m_tests.push_back({name, test, false, ""});
    }
    
    int RunAll() {
        std::cout << "\n========== Running Tests ==========\n" << std::endl;
        
        int passed = 0;
        int failed = 0;
        
        auto start = std::chrono::high_resolution_clock::now();
        
        for (auto& test : m_tests) {
            std::cout << "Running: " << test.name << " ... ";
            try {
                test.test();
                test.passed = true;
                passed++;
                std::cout << "[PASS]" << std::endl;
            } catch (const std::exception& e) {
                test.passed = false;
                test.error = e.what();
                failed++;
                std::cout << "[FAIL] - " << e.what() << std::endl;
            }
        }
        
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
        
        std::cout << "\n========== Test Summary ==========" << std::endl;
        std::cout << "Total:  " << m_tests.size() << std::endl;
        std::cout << "Passed: " << passed << std::endl;
        std::cout << "Failed: " << failed << std::endl;
        std::cout << "Time:   " << duration.count() << "ms" << std::endl;
        std::cout << "==================================\n" << std::endl;
        
        return failed;
    }
    
private:
    std::vector<TestCase> m_tests;
};

// Assertion macros
#define TEST_ASSERT(condition) \
    if (!(condition)) { \
        std::stringstream ss; \
        ss << "Assertion failed: " << #condition << " at " << __FILE__ << ":" << __LINE__; \
        throw std::runtime_error(ss.str()); \
    }

#define TEST_ASSERT_EQ(expected, actual) \
    if ((expected) != (actual)) { \
        std::stringstream ss; \
        ss << "Expected " << (expected) << " but got " << (actual) << " at " << __FILE__ << ":" << __LINE__; \
        throw std::runtime_error(ss.str()); \
    }

#define TEST_ASSERT_TRUE(condition) TEST_ASSERT(condition)
#define TEST_ASSERT_FALSE(condition) TEST_ASSERT(!(condition))
#define TEST_ASSERT_NULL(ptr) TEST_ASSERT((ptr) == nullptr)
#define TEST_ASSERT_NOT_NULL(ptr) TEST_ASSERT((ptr) != nullptr)

// Test registration macro
#define TEST(name) \
    void test_##name(); \
    struct test_##name##_registrar { \
        test_##name##_registrar() { \
            Tarnak::Test::TestFramework::Instance().RegisterTest(#name, test_##name); \
        } \
    } test_##name##_instance; \
    void test_##name()

} // namespace Tarnak::Test

// Main function for tests
int main() {
    return Tarnak::Test::TestFramework::Instance().RunAll();
}
