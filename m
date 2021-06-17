Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22303AAD31
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFQHTs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 03:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhFQHTr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 03:19:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5838C061574;
        Thu, 17 Jun 2021 00:17:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so1220983pjo.3;
        Thu, 17 Jun 2021 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6kcZM1AuUHKoJf07Jbs5/QblaBEoUa9v/xeJVHYHGUA=;
        b=RYw47Yu7cF8r6MO9Ypc1ZR7oq+oEGMs1VjF0UKu2PEJmplPQz1S363LMYeCIzn7cob
         yiWdnVkGCT387nMCnkVCjVRUeYDOIRG3521hEOEo+T6PHqio31L8k7ntYpXdsnwwyzp0
         yizRykObD8XGmJwiE2FcV6hvRg0My6JmxaI4fm3t5mKG9F4xvx62uZk+GPMa8YH+aPAW
         gDqtqVS+PI8tjV7e5kVdQnF230UB6yvbwCd6/cp3NkUAOm915wStaEbrhCxVt61dDYIB
         Khts+vf4cXEY0niHjItqWyNdriEOtPNPw5ePpMg6oWc2zlLRmOjoKp+IxKaZ8raiaMpC
         cF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6kcZM1AuUHKoJf07Jbs5/QblaBEoUa9v/xeJVHYHGUA=;
        b=bxe1qSJaZrN3F7DDVhaX0ewVkZDlN8vI2NVEifr/E7HKHQSIhpRihLCexQzhR2K0T3
         APfKq0DXxeu7NDRxUOF4VtC0WAV8Z4Jti6ymadprZivIjpnHlhHDJGDwKQvNhRVfwcV9
         4ipwmxdkXaFlcdAiBV6NS//MFrP89iT+9X/dKqq3MDjAXCWdDc5rJY7bpRJW5oSTnntT
         HuQ1gf4B8IIixmYGlPihvi3GW0AyfvFMMLvoRtDYX4PbCLC2vbsp92f/o2mOhblZSHG8
         4T88apu6bWPojsmAV+oi1azekie8KFevX6ZBOV1Ne2bm/HP3MbAVBWVKfr+0IaRR2/pp
         Muag==
X-Gm-Message-State: AOAM532QYXNhhCDcPE/N/PGjjR2wM1ZTmOEBy5tvnYMJyZQb2pqe1qDo
        XIvhKg42doie726xYA7qdlo=
X-Google-Smtp-Source: ABdhPJzxtGPSlMGvuZxn6tzh0yol5JOA4lulk6EnhYMT5MJFhiVOfnq2k3x0G6C2LgUkovBqSoAbwQ==
X-Received: by 2002:a17:90a:9910:: with SMTP id b16mr4090833pjp.94.1623914259266;
        Thu, 17 Jun 2021 00:17:39 -0700 (PDT)
Received: from localhost ([223.184.24.109])
        by smtp.gmail.com with ESMTPSA id r6sm7161741pjm.12.2021.06.17.00.17.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jun 2021 00:17:38 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:47:32 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     pali@kernel.org
Cc:     dmurphy@ti.com, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanjanasrinidhi1810@gmail.com
Subject: [PATCH] drivers: power: supply: bq27xxx_battery.c: Remove spaces
 before tabs
Message-ID: <20210617071732.vbsn2okr2ed3l4dk@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Removed extra spaces before ','
Added blank line after declaration
Spaces have been replaced with tabs
This is done to maintain uniformity in coding style

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 50 +++++++++++++-------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 4c4a7b1c64c5..bf090b7ebcec 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -938,26 +938,26 @@ static struct {
 	enum power_supply_property *props;
 	size_t props_size;
 } bq27xxx_chip_data[] = {
-	[BQ27000]   = BQ27XXX_DATA(bq27000,   0         , BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI | BQ27XXX_O_HAS_CI),
-	[BQ27010]   = BQ27XXX_DATA(bq27010,   0         , BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI | BQ27XXX_O_HAS_CI),
-	[BQ2750X]   = BQ27XXX_DATA(bq2750x,   0         , BQ27XXX_O_OTDC),
-	[BQ2751X]   = BQ27XXX_DATA(bq2751x,   0         , BQ27XXX_O_OTDC),
-	[BQ2752X]   = BQ27XXX_DATA(bq2752x,   0         , BQ27XXX_O_OTDC),
+	[BQ27000]   = BQ27XXX_DATA(bq27000,   0, BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI | BQ27XXX_O_HAS_CI),
+	[BQ27010]   = BQ27XXX_DATA(bq27010,   0, BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI | BQ27XXX_O_HAS_CI),
+	[BQ2750X]   = BQ27XXX_DATA(bq2750x,   0, BQ27XXX_O_OTDC),
+	[BQ2751X]   = BQ27XXX_DATA(bq2751x,   0, BQ27XXX_O_OTDC),
+	[BQ2752X]   = BQ27XXX_DATA(bq2752x,   0, BQ27XXX_O_OTDC),
 	[BQ27500]   = BQ27XXX_DATA(bq27500,   0x04143672, BQ27XXX_O_OTDC),
-	[BQ27510G1] = BQ27XXX_DATA(bq27510g1, 0         , BQ27XXX_O_OTDC),
-	[BQ27510G2] = BQ27XXX_DATA(bq27510g2, 0         , BQ27XXX_O_OTDC),
-	[BQ27510G3] = BQ27XXX_DATA(bq27510g3, 0         , BQ27XXX_O_OTDC),
-	[BQ27520G1] = BQ27XXX_DATA(bq27520g1, 0         , BQ27XXX_O_OTDC),
-	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, 0         , BQ27XXX_O_OTDC),
-	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, 0         , BQ27XXX_O_OTDC),
-	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, 0         , BQ27XXX_O_OTDC),
-	[BQ27521]   = BQ27XXX_DATA(bq27521,   0         , 0),
-	[BQ27530]   = BQ27XXX_DATA(bq27530,   0         , BQ27XXX_O_UTOT),
-	[BQ27531]   = BQ27XXX_DATA(bq27531,   0         , BQ27XXX_O_UTOT),
-	[BQ27541]   = BQ27XXX_DATA(bq27541,   0         , BQ27XXX_O_OTDC),
-	[BQ27542]   = BQ27XXX_DATA(bq27542,   0         , BQ27XXX_O_OTDC),
-	[BQ27546]   = BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
-	[BQ27742]   = BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
+	[BQ27510G1] = BQ27XXX_DATA(bq27510g1, 0, BQ27XXX_O_OTDC),
+	[BQ27510G2] = BQ27XXX_DATA(bq27510g2, 0, BQ27XXX_O_OTDC),
+	[BQ27510G3] = BQ27XXX_DATA(bq27510g3, 0, BQ27XXX_O_OTDC),
+	[BQ27520G1] = BQ27XXX_DATA(bq27520g1, 0, BQ27XXX_O_OTDC),
+	[BQ27520G2] = BQ27XXX_DATA(bq27520g2, 0, BQ27XXX_O_OTDC),
+	[BQ27520G3] = BQ27XXX_DATA(bq27520g3, 0, BQ27XXX_O_OTDC),
+	[BQ27520G4] = BQ27XXX_DATA(bq27520g4, 0, BQ27XXX_O_OTDC),
+	[BQ27521]   = BQ27XXX_DATA(bq27521,   0, 0),
+	[BQ27530]   = BQ27XXX_DATA(bq27530,   0, BQ27XXX_O_UTOT),
+	[BQ27531]   = BQ27XXX_DATA(bq27531,   0, BQ27XXX_O_UTOT),
+	[BQ27541]   = BQ27XXX_DATA(bq27541,   0, BQ27XXX_O_OTDC),
+	[BQ27542]   = BQ27XXX_DATA(bq27542,   0, BQ27XXX_O_OTDC),
+	[BQ27546]   = BQ27XXX_DATA(bq27546,   0, BQ27XXX_O_OTDC),
+	[BQ27742]   = BQ27XXX_DATA(bq27742,   0, BQ27XXX_O_OTDC),
 	[BQ27545]   = BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
 	[BQ27411]   = BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27421]   = BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
@@ -965,9 +965,9 @@ static struct {
 	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
-	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
-	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
-	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
+	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0, BQ27Z561_O_BITS),
+	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0, BQ27Z561_O_BITS),
+	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0, BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
 							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
 };
 
@@ -1304,6 +1304,7 @@ static int bq27xxx_battery_cfgupdate_priv(struct bq27xxx_device_info *di, bool a
 static inline int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di)
 {
 	int ret = bq27xxx_battery_cfgupdate_priv(di, true);
+
 	if (ret < 0 && ret != -EINVAL)
 		dev_err(di->dev, "bus error on set_cfgupdate: %d\n", ret);
 
@@ -1313,6 +1314,7 @@ static inline int bq27xxx_battery_set_cfgupdate(struct bq27xxx_device_info *di)
 static inline int bq27xxx_battery_soft_reset(struct bq27xxx_device_info *di)
 {
 	int ret = bq27xxx_battery_cfgupdate_priv(di, false);
+
 	if (ret < 0 && ret != -EINVAL)
 		dev_err(di->dev, "bus error on soft_reset: %d\n", ret);
 
@@ -1332,7 +1334,6 @@ static int bq27xxx_battery_write_dm_block(struct bq27xxx_device_info *di,
 		ret = bq27xxx_battery_set_cfgupdate(di);
 		if (ret < 0)
 			return ret;
-	}
 
 	ret = bq27xxx_write(di, BQ27XXX_DM_CTRL, 0, true);
 	if (ret < 0)
@@ -1407,6 +1408,7 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
 
 	if (info->voltage_min_design_uv != -EINVAL) {
 		bool same = bd.class == bt.class && bd.block == bt.block;
+
 		if (!same)
 			bq27xxx_battery_read_dm_block(di, &bt);
 		bq27xxx_battery_update_dm_block(di, same ? &bd : &bt,
@@ -1689,7 +1691,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 {
 	if (di->opts & BQ27XXX_O_OTDC)
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
-        if (di->opts & BQ27XXX_O_UTOT)
+	if (di->opts & BQ27XXX_O_UTOT)
 		return flags & BQ27XXX_FLAG_OT;
 
 	return false;
-- 
2.17.1

