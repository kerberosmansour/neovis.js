puppeteer = require('puppeteer');
require 'fluentnode'

describe 'puppeteer-test', ->
  xit 'should take screenthos of neo4j graph', ->

    target_Folder = (wallaby.localProjectDir || ".").path_Combine("_screenshots")
    target_File = target_Folder.path_Combine('neo4j.png')

    browser = await puppeteer.launch();
    page = await browser.newPage();
    await page.goto('http://localhost:3000/neo4j/');
    await page.screenshot({path: target_File});
    await browser.close();

