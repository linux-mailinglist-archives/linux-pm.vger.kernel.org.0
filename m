Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A76405994
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbhIIOsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbhIIOru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E90C0698DA
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:40 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=np9W1rxo1d7pOrc4tYTJbmiesY68gCXYFLZP863RU6Y=;
        b=AHZcx0Yj2yNOipU5Ny0xBg6d6BIxKuBmiSwBrX/7yC+iYKsw88IhfRTRb1KrEOeAMqiVmo
        gi+eCCC5pO+XDL673H37gIX5RfpboeH+e5HIPSNqBHJQ1RuT4Rsjm3WptaY+NXVzrxvtgn
        Krkl9dNIe57fBqXjAjx9e1N6lRs8zGGkEMxANL880Z2PionWf9iWag0pCxjfbjNw08gqbG
        lX/Olh4rrpB2w8ya51+jMp+mOct/9TIq+IJeuqMQC1sy45PezrNTS7DRDdt35i4Xv1HBND
        X1PM+V5j24EJg6JDTZrZB7189uwJPnVGqjwSw+hSC/fctMXB9ROApArAtAD/Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=np9W1rxo1d7pOrc4tYTJbmiesY68gCXYFLZP863RU6Y=;
        b=YlBjFeD81wFXXZ+rXsxbdyOxzz5PtmnlTQTH7hve3nSylsn9X4awbtth6vnHkjurDloD+x
        GCM/CNG142uJFHDA==
From:   "thermal-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Fix
 thermal_cooling_device_register() prototype
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210722090717.1116748-1-arnd@kernel.org>
References: <20210722090717.1116748-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <163119831849.25758.10697845946417166312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     fb83610762dd5927212aa62a468dd3b756b57a88
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//fb83610762dd5927212aa62a468dd3b756b57a88
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 22 Jul 2021 11:06:44 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 15:40:26 +02:00

thermal/core: Fix thermal_cooling_device_register() prototype

There are two pairs of declarations for thermal_cooling_device_register()
and thermal_of_cooling_device_register(), and only one set was changed
in a recent patch, so the other one now causes a compile-time warning:

drivers/net/wireless/mediatek/mt76/mt7915/init.c: In function 'mt7915_thermal_init':
drivers/net/wireless/mediatek/mt76/mt7915/init.c:134:48: error: passing argument 1 of 'thermal_cooling_device_register' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  134 |         cdev = thermal_cooling_device_register(wiphy_name(wiphy), phy,
      |                                                ^~~~~~~~~~~~~~~~~
In file included from drivers/net/wireless/mediatek/mt76/mt7915/init.c:7:
include/linux/thermal.h:407:39: note: expected 'char *' but argument is of type 'const char *'
  407 | thermal_cooling_device_register(char *type, void *devdata,
      |                                 ~~~~~~^~~~

Change the dummy helper functions to have the same arguments as the
normal version.

Fixes: f991de53a8ab ("thermal: make device_register's type argument const")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210722090717.1116748-1-arnd@kernel.org
---
 include/linux/thermal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d296f3b..8050d92 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -404,12 +404,13 @@ static inline void thermal_zone_device_unregister(
 	struct thermal_zone_device *tz)
 { }
 static inline struct thermal_cooling_device *
-thermal_cooling_device_register(char *type, void *devdata,
+thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
-	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
+	const char *type, void *devdata,
+	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
 devm_thermal_of_cooling_device_register(struct device *dev,
