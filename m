Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2332A5A04E9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Aug 2022 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiHYABo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Aug 2022 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHYABo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2022 20:01:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB16069E
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2022 17:01:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 1so10854841pfu.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2022 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cdr7at1JKYghQI6R9z9Yx/NyQLGaOoj2bGc1GYX1bNY=;
        b=RRvKHw4LUKco0SHOXZXJG1qxTBfs8v/+p4NOXkWiBLOGy2DYdd1bTko348pkBAOZuU
         rTR5cXb9a4cUwPY3f5Mnv6DoumO/Fuils4rznox87NT6VcBhytwgSj5iDSPVksxXDq3r
         8GwkGB0CRB0bntZPsXsO7migfnnOmqIB50kCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cdr7at1JKYghQI6R9z9Yx/NyQLGaOoj2bGc1GYX1bNY=;
        b=V/sXGEGNS8d4IKcbQkLnBrhOziIOml6/NiCQsrkI4AKfpuxWrfQyozulSmTaHspWOR
         BJGuXQiNKHLuXLvFZjrDeKn2zgvhQAgkGemHaaKezdYKYuKP1EobFq4oqRdRK6EGY4x0
         67fGpo79LXnXonq9ytn/H5LKP4PF2VC+soXqCFuVNBecfJfp0zscdRU2DxUu/d0YeqG/
         P4RtCwMi7r8vmauLtlWALjmhuDxBhIdnftmz/VEDas8Fmb/AplkTTqOoG0HfTm5UzTnI
         jDY/5w8bJAaufaj/a9hk66/2kfgpmGXajPGbEAz5s5/i5GPpeZflHuQ/4NR9lC9wXIt/
         uaBQ==
X-Gm-Message-State: ACgBeo0j/9thvrAWFfa5XnFxJjicufFVHjdlN5U3m1LKcQLD6YN4kCAe
        mcbRgpV0moo2K9XxRHopC6gaCA==
X-Google-Smtp-Source: AA6agR4mdAgn0jg48tyxv8lanPqDyqHWn5RocBGofm5s8bQ6cmEO8Bf3uZGf6UDp9/UMTaXoIsOjIQ==
X-Received: by 2002:a63:5fc2:0:b0:429:fe35:1bd6 with SMTP id t185-20020a635fc2000000b00429fe351bd6mr1064159pgb.315.1661385692501;
        Wed, 24 Aug 2022 17:01:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b7d8:1c85:ef67:47be])
        by smtp.gmail.com with UTF8SMTPSA id y1-20020a17090a2b4100b001f8aee0d826sm1956055pjc.53.2022.08.24.17.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:01:31 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] power: supply: core: Ignore -EIO for uevent
Date:   Wed, 24 Aug 2022 16:57:20 -0700
Message-Id: <20220824165459.1.I059ae712dd6d324897162ee9f37c22849aa22745@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For uevents, we enumerate all properties. Some battery implementations
don't implement all standard properties, and may return -EIO for
properties that aren't recognized. This means we never report uevents
for such batteries.

It's better to ignore these errors and skip the property, as we do with
ENODATA and ENODEV.

Example battery implementation: Acer Chromebook Tab 10 (a.k.a. Google
Gru-Scarlet) has a virtual "SBS" battery implementation in its Embedded
Controller on top of an otherwise non-SBS battery.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/power/supply/power_supply_sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 4239591e1522..36fce572a213 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -439,10 +439,12 @@ static int add_prop_uevent(struct device *dev, struct kobj_uevent_env *env,
 	dev_attr = &pwr_attr->dev_attr;
 
 	ret = power_supply_show_property(dev, dev_attr, prop_buf);
-	if (ret == -ENODEV || ret == -ENODATA) {
+	if (ret == -ENODEV || ret == -ENODATA || ret == -EIO) {
 		/*
 		 * When a battery is absent, we expect -ENODEV. Don't abort;
-		 * send the uevent with at least the the PRESENT=0 property
+		 * send the uevent with at least the PRESENT=0 property. Some
+		 * batteries also report EIO, even for some standard
+		 * properties.
 		 */
 		return 0;
 	}
-- 
2.37.2.672.g94769d06f0-goog

