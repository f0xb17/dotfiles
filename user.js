/****************************************************************************************
 * OPTION: SHARPEN SCROLLING                                                           *
 ****************************************************************************************/
user_pref('apz.overscroll.enabled', true);
user_pref('general.smoothScroll', true);
user_pref('mousewheel.min_line_scroll_amount', 10);
user_pref('general.smoothScroll.mouseWheel.durationMinMS', 80);
user_pref('general.smoothScroll.currentVelocityWeighting', '0.15');
user_pref('general.smoothScroll.stopDecelerationWeighting', '0.6');
user_pref('general.smoothScroll.msdPhysics.enabled', false);

/****************************************************************************************
 * OPTION: INSTANT SCROLLING (SIMPLE ADJUSTMENT)                                       *
 ****************************************************************************************/
user_pref('mousewheel.default.delta_multiplier_y', 275);
user_pref('general.smoothScroll.msdPhysics.enabled', false);

/****************************************************************************
 * SECTION: MOZILLA UI                                                      *
 ****************************************************************************/
user_pref('browser.aboutConfig.showWarning', false);
user_pref('extensions.getAddons.showPane', false);
user_pref('extensions.htmlaboutaddons.recommendations.enabled', false);
user_pref('browser.discovery.enabled', false);
user_pref('browser.shell.checkDefaultBrowser', false);
user_pref('browser.preferences.moreFromMozilla', false);

/****************************************************************************
 * SECTION: AI                                                              *
 ****************************************************************************/
user_pref('browser.ai.control.default', 'blocked');
user_pref('browser.ml.enable', false);
user_pref('browser.tabs.groups.smart.enabled', false);
user_pref('browser.ml.linkPreview.enabled', false);
user_pref('browser.ml.chat.enabled', false);
user_pref('browser.ml.chat.menu', false);

/****************************************************************************
 * SECTION: TRANSLATIONS                                                    *
 ****************************************************************************/
user_pref('browser.translations.enable', false);
user_pref('browser.translations.autoTranslate', false);

/****************************************************************************
 * SECTION: NEW TAB PAGE                                                    *
 ****************************************************************************/
user_pref('browser.newtabpage.activity-stream.showSponsoredTopSites', false);
user_pref('browser.newtabpage.activity-stream.feeds.section.topstories', false);
user_pref('browser.newtabpage.activity-stream.system.showSponsored', false);
user_pref('browser.newtabpage.activity-stream.showSponsoredCheckboxes', false);
user_pref('browser.newtabpage.activity-stream.default.sites', '');
user_pref('browser.newtabpage.activity-stream.showWeather', 'false');

/****************************************************************************
 * SECTION: Security                                                        *
 ****************************************************************************/
user_pref('privacy.globalprivacycontrol.enabled', true);
user_pref('security.OCSP.enabled', 0);
