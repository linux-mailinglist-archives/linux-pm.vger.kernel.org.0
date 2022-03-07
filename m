Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17B4CF052
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 04:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiCGDiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Mar 2022 22:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiCGDiF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Mar 2022 22:38:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFDA5EBF8
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 19:37:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 190-20020a2505c7000000b00629283fec72so2974821ybf.5
        for <linux-pm@vger.kernel.org>; Sun, 06 Mar 2022 19:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ARpa6zPvm9PZGcuhaMPlpvBKRkuGs23E2qbxbopfbZE=;
        b=MCCElJilTvr7B+pD7gKcvQr3ZDXAlzmXGgob1nCokYBs+kB9L9gbZZcowbYbvdwNX8
         2ea0s2xtzpM00b2h1SF+GNyA2hOZidBC0B5tFnW0Foojz2QhIVyc5nv2yQFk9Rd7tfkg
         pJPK2LGns7HIOwY3SKlwazz6YMfXHZsw+Omj+Tt9ZnjqkP4xbTo/aD7odi4qKS5JJHY+
         bhanhrsRkzChc23du1M8OFUaXclZVPfqjBe6umiBZs4I/BNVY/OVUF9huoJf58CCnTC0
         UymJ3wYRkn+hrd7zNq5laZI3suCMgJM9ipS2dLOcaa3+A/PmgD3wOHNwmtkpmLW2HIJh
         9a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ARpa6zPvm9PZGcuhaMPlpvBKRkuGs23E2qbxbopfbZE=;
        b=4wmi8NonJfVbe13jHPE1dpUJX5wI7kZTtk21pFhxLTslP6geHCFA9RGuM6MXhJitm0
         wnwNoXcPXCOAWSbLSrAjn2bbQfUZ9QIQuGNkdY0CX4kaOvD1wjauYEhN7UjRTap4JaDl
         blWf7cEhGpkK/qLbNhiMDyNyqmzSh/awRbUsOZcPKdl04Z1OlHLax3NZmz2AnHBRfpKH
         jtyAR1dFXv0P1D/ab7VcDY+/KlpX9RkLUhnNd0NJ8WEEtUcYyvWmAA+R+NHyVvrgCvEM
         oUnsNjkCKqYHO7W0sQpECeYtEVN87povGgMBF3iw/QK+5yfgIQ9Rom3hIwqDctoqScXF
         NeDw==
X-Gm-Message-State: AOAM530U3vJO8wF+YpoBVdjazm1vuU8msBPKcGDJy7QZKUHbU9v5i/aU
        xADqcRFIeEzQa+1HH+jncawiJEmbJg==
X-Google-Smtp-Source: ABdhPJy1CbjnoFeTL/HWc58+lRRM4BCd1WNPaT1xh27NXWX5WTgImWN4e5HS6Yq2RCMg/Y19e6ct8oySSg==
X-Received: from wjack.tao.corp.google.com ([2401:fa00:fd:203:309f:cb85:fb3d:7ae0])
 (user=wjack job=sendgmr) by 2002:a81:5545:0:b0:2db:effc:f88a with SMTP id
 j66-20020a815545000000b002dbeffcf88amr7072121ywb.370.1646624228824; Sun, 06
 Mar 2022 19:37:08 -0800 (PST)
Date:   Mon,  7 Mar 2022 11:31:08 +0800
Message-Id: <20220307033110.283379-1-wjack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v1] power: supply: add dock type
From:   Jack Wu <wjack@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jack Wu <wjack@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dock power_supply_type for the drivers which supports dock can
register a power supply class device with POWER_SUPPLY_TYPE_DOCK.

Signed-off-by: Jack Wu <wjack@google.com>
---
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..53494b56bbb4 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] = {
 	[POWER_SUPPLY_TYPE_USB_PD_DRP]		= "USB_PD_DRP",
 	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
 	[POWER_SUPPLY_TYPE_WIRELESS]		= "Wireless",
+	[POWER_SUPPLY_TYPE_DOCK]		= "Dock",
 };
 
 static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..fa80eaa54242 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -187,6 +187,7 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
+	POWER_SUPPLY_TYPE_DOCK,			/* Dock Charging */
 };
 
 enum power_supply_usb_type {
-- 
2.34.1.173.g76aa8bc2d0-goog

