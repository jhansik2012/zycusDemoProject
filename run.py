from robot.api import SuiteVisitor
import robot.model.testcase


class run(SuiteVisitor):

    def __init__(self, filename=''):
        self.testFile = filename

    def start_suite(self, suite):
        with open(self.testFile) as f:
            content = f.readlines()
        rowIndex = 0
        for line in content:
            if rowIndex == 0:
                rowIndex = 1
                continue
            testdata = line.strip().split("|")
            t = suite.tests.create(testdata[0].strip(), tags=["testid:" + testdata[0].strip(), testdata[0].strip()])
            t.keywords.create('Customer OnBoaring',args=[rowIndex])
            #t.keywords.create('Verify Entry in EDB',args=[rowIndex])
            #t.keywords.create('Reset TestData',args=[rowIndex])
            rowIndex = rowIndex + 1

    def end_suite(self, suite):
        pass

    def visit_test(self, test):
        pass