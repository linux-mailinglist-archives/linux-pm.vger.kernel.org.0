Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DCA3DFF8D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 12:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhHDKop (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 06:44:45 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60311 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbhHDKoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 06:44:38 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4A23D20005;
        Wed,  4 Aug 2021 10:44:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / sleep: check RTC features instead of ops in suspend_test
Date:   Wed,  4 Aug 2021 12:44:07 +0200
Message-Id: <20210804104407.5600-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Test RTC_FEATURE_ALARM instead of relying on ops->set_alarm to know whether
alarms are available.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 kernel/power/suspend_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index e1ed58adb69e..d20526c5be15 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -129,7 +129,7 @@ static int __init has_wakealarm(struct device *dev, const void *data)
 {
 	struct rtc_device *candidate = to_rtc_device(dev);
 
-	if (!candidate->ops->set_alarm)
+	if (!test_bit(RTC_FEATURE_ALARM, candidate->features))
 		return 0;
 	if (!device_may_wakeup(candidate->dev.parent))
 		return 0;
-- 
2.31.1

