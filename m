Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3016F2D1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 23:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgBYW7q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 17:59:46 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39825 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgBYW7q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 17:59:46 -0500
Received: by mail-yw1-f66.google.com with SMTP id x184so1280766ywd.6
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverware.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QwgvnVVSM2HNW/2taa70j85B+ilLFW/7LyX5niEjqGo=;
        b=MWY7Qe5g64auBP/Uj54YZJS7+Hjs+Gzd4BCqJLf5/HLi7zyx2rTRTkFLclrZ0xlApF
         BXS1e93EfgFSmV0FUISXKHdz+7sOT89v423iijm6vTeOi81W6V4B+d0G1xD0ztRTmp2p
         i3YF6QQqwPdqfm6hhFhjM14OYgzxYrHWebW3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QwgvnVVSM2HNW/2taa70j85B+ilLFW/7LyX5niEjqGo=;
        b=VO9fPgFLdXhpX0pUsrzdjPWULWAJHywyqpIrZpk/IBbdQoCboNmwUSFDYK53B3YuoI
         6CD5GX93vh/rlmE02KHGo73QgE9SeA7MVy93En3Go2XOZJHZXqn2GIYVGSjJBvVrAzrG
         08RVw2UJjC573M+TtLc2JLpDN0YXcJfqDW0QZDRAfZWGfhUDTleITa2jT0Ee9uwJFvQP
         j8OP7f1qu0cvunqQItSKZv1j3kAW57Z4Ex/v5pQEgo1IvJ/7bCTvNuTWMwltq7iBVfkU
         QuB3fJSoPoqAPIGBHZb9zg83WwzfiNsrd1lDyUHMTBt3N4762Q/4sNsGe55CVxKNvCQj
         tykQ==
X-Gm-Message-State: APjAAAVFKsrh4oQ91GDo0j2yxML72zJmhkvq9qIwFX6uGBAWflMgjow9
        YsKZxM359lnb7wr0Zd1aSTScFTd1eude5g==
X-Google-Smtp-Source: APXvYqyq6wfe9rIZnl8NQeBxMBhVMLWlw47LJQMnfcQZhgR8ma2gVtY9Ykibafi8tmyYd54ehbzjYg==
X-Received: by 2002:a0d:ddd7:: with SMTP id g206mr111603ywe.321.1582671584924;
        Tue, 25 Feb 2020 14:59:44 -0800 (PST)
Received: from localhost.localdomain (c-73-36-144-145.hsd1.il.comcast.net. [73.36.144.145])
        by smtp.gmail.com with ESMTPSA id j72sm45031ywj.60.2020.02.25.14.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 14:59:44 -0800 (PST)
From:   Jeffery Miller <jmiller@neverware.com>
To:     linux-pm@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, jefferym@gmail.com,
        Jeffery Miller <jmiller@neverware.com>
Subject: [PATCH] power: supply: axp288_fuel_gauge: Broaden vendor check for Intel Compute Sticks.
Date:   Tue, 25 Feb 2020 16:59:41 -0600
Message-Id: <20200225225941.2038378-1-jmiller@neverware.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Intel Compute Stick `STK1A32SC` can have a system vendor of
"Intel(R) Client Systems".
Broaden the Intel Compute Stick DMI checks so that they match "Intel
Corporation" as well as "Intel(R) Client Systems".

This fixes an issue where the STK1A32SC compute sticks were still
exposing a battery with the existing blacklist entry.

Signed-off-by: Jeffery Miller <jmiller@neverware.com>
---

I've tested this primarily with a 4.19 kernel on Intel Compute Sticks
with the "Intel(R) Client Systems" vendor.

 drivers/power/supply/axp288_fuel_gauge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index e1bc4e6e6f30..f40fa0e63b6e 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -706,14 +706,14 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 	{
 		/* Intel Cherry Trail Compute Stick, Windows version */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "STK1AW32SC"),
 		},
 	},
 	{
 		/* Intel Cherry Trail Compute Stick, version without an OS */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
 		},
 	},
-- 
2.24.1

