Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F59959E6F4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiHWQWE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbiHWQVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:21:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6105C333D75
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:41 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a7F3P8c969ignjPXRDCGiGRv2IqAV+C+1sVbc0uk4+Q=;
        b=dCot5nB/bBwibhOeGjhMSJTjFp0Le1mrpXVgy7uiEQA01EBI6ylnHgFUm4CzJ6KpGMjmn+
        N/k1PlOhttdr5Npfk0EswEZugjNAM9z3P++pjMfXbHoM6sZengflJeicQv8jWJHZ1FdtZI
        m6o5Yh0tcvuOGJ9UXMjF/84gwpm7QoS9CY5j0MSwSd7uLVBME5RworWNdKqEHihClpTLoR
        RoPJOaLio9McoavXNcPY4/hS7SDFdhqwdawUnair3YaeV9xVbpeU6CpdoEgpR3WE79QC9q
        PjiDruyOUQINgi+/xwj8n4qPAebxRJEQ1ihx40wXfcodFpq2hLTnm2dVuSJpqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a7F3P8c969ignjPXRDCGiGRv2IqAV+C+1sVbc0uk4+Q=;
        b=P696XdjTqdq8kEXMiPPd5YE13rifDoV0wI3VoFlKEbAxq8A0FDLHNPMiJbr6ujPsBMUFRl
        JBwu08hHTr22GPBw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Fix lockdep_assert() warning
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        rui.zhang@intel.com, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <166125855850.401.12486120367006542290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     2f9d142c93c293b2526d63e4e75716945edf0cd2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2f9d142c93c293b2526d63e4e75716945edf0cd2
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 12 Aug 2022 15:07:43 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:39 +02:00

thermal/core: Fix lockdep_assert() warning

The function thermal_zone_device_is_enabled() must be called with the
thermal zone lock held. In the resume path, it is called without.

As the thermal_zone_device_is_enabled() is also checked in
thermal_zone_device_update(), do the check in resume() function is
pointless, except for saving an extra initialization which does not
hurt if it is done in all the cases.

Fixes: ca48ad71717dd ("thermal/core: Move the mutex inside the thermal_zone_device_update() function")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/thermal/thermal_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4812170..99c0c19 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1438,9 +1438,6 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
-			if (!thermal_zone_device_is_enabled(tz))
-				continue;
-
 			thermal_zone_device_init(tz);
 			thermal_zone_device_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
