Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC7648514
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiLIP0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLIP03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C68BD2B
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:27 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cgeCRvlLqgjQY1aLRBMU8wIgfvaVWMNeSB1dAbow240=;
        b=WV28B3P2+ThX5Q1I6BGNhokiTdQcwD5JdZwM/r79O088TwsSDbHBQfe86IhMMZfydk/bLi
        KGFlY424xuFGNAtkfQTOVUtAlN8iom7l91Jt7qjI/l0Up38YOuzfHCY0yQeRbvJ0Ghky3q
        sIZimcGs920kFPWzdDZ27rWmCZu7ZykIL1BK1io720ickZQkROEw/1atTy2WchkpqwKU7P
        PhAAj+lB92Xbx/swKcdIstr575sjewQ2r6+rVo9gITT76/qD9g3YifR3VuS/3Aoa78w2iu
        UdxQ+mPTyyaXho+aBIgFVToBTubcGRnhBedI5Jf6WG+Q8qn89MFqJM3a8fxeeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cgeCRvlLqgjQY1aLRBMU8wIgfvaVWMNeSB1dAbow240=;
        b=TIcGHUEfAM4jT6MxE+JCdFcGmngSV2Wr988g7iUXhDpwjzAQF0u/7STReWpeqVL9R5sQ0c
        YsaCaY7kasjf7SBg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] Revert "thermal/sysfs: Remove unnecessary
 check in trip_point_hyst_show()"
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059958500.4906.5675491872553769249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f3ce48d06440a712de3c5ef1d26003c1e77afd74
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f3ce48d06440a712de3c5ef1d26003c1e77afd74
Author:        Daniel Lezcano <daniel.lezcano@kernel.org>
AuthorDate:    Thu, 08 Dec 2022 21:03:41 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 09 Dec 2022 16:23:16 +01:00

Revert "thermal/sysfs: Remove unnecessary check in trip_point_hyst_show()"

With the commit 05eeee2b51b44c, the assertion is no longer true. The
'ret' variable can contain an error.

This reverts commit 1627cd2f820ad90d3249e6b4e6f1dbadfbed0d33.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index d37133a..cef860d 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -226,7 +226,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 
 	mutex_unlock(&tz->lock);
 
-	return sprintf(buf, "%d\n", trip.hysteresis);
+	return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
 }
 
 static ssize_t
