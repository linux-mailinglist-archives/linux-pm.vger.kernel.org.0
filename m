Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD5270E5C
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgISOEq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Sep 2020 10:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISOEm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Sep 2020 10:04:42 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0359421707;
        Sat, 19 Sep 2020 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524281;
        bh=G1rBETN5Htd6dGPg5Ma1dHWDGClo+P7ZqLA4Y4JKMW4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mct18cNMGz1DOsX6T2NsZg+aCRVHuh14skQESopDPlN3pj3+XQSSMy0VSmxj+HW5V
         mzOrM1S49k/rViDGj95PXIhFP+FVGsFOrqLRHJrAX5f8+DPQRg8uiBY0qdNWXeYmPu
         v0TJx+K4j4D8aMYPptAci8jjmQVyV7zc9DEXlrxE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] power: supply: bq27xxx: add separate flag for single SoC register
Date:   Sat, 19 Sep 2020 16:04:16 +0200
Message-Id: <20200919140418.3705-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200919140418.3705-1-krzk@kernel.org>
References: <20200919140418.3705-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

bq27000, bq27010 and upcoming bq34z100 have a single byte SoC
register.  However except this similarity, bq34z100 is quite different
than bq27000/bq27010, so flag BQ27XXX_O_ZERO cannot be reused here.  Add
a new bit flag describing that SoC is a single byte register.

No functional change for bq27000 and bq27010.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index e971af43dd45..88cdad0ecb08 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -855,6 +855,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #define BQ27XXX_O_CFGUP		BIT(3)
 #define BQ27XXX_O_RAM		BIT(4)
 #define BQ27Z561_O_BITS		BIT(5)
+#define BQ27XXX_O_SOC_SI	BIT(6) /* SoC is single register */
 
 #define BQ27XXX_DATA(ref, key, opt) {		\
 	.opts = (opt),				\
@@ -872,8 +873,8 @@ static struct {
 	enum power_supply_property *props;
 	size_t props_size;
 } bq27xxx_chip_data[] = {
-	[BQ27000]   = BQ27XXX_DATA(bq27000,   0         , BQ27XXX_O_ZERO),
-	[BQ27010]   = BQ27XXX_DATA(bq27010,   0         , BQ27XXX_O_ZERO),
+	[BQ27000]   = BQ27XXX_DATA(bq27000,   0         , BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI),
+	[BQ27010]   = BQ27XXX_DATA(bq27010,   0         , BQ27XXX_O_ZERO | BQ27XXX_O_SOC_SI),
 	[BQ2750X]   = BQ27XXX_DATA(bq2750x,   0         , BQ27XXX_O_OTDC),
 	[BQ2751X]   = BQ27XXX_DATA(bq2751x,   0         , BQ27XXX_O_OTDC),
 	[BQ2752X]   = BQ27XXX_DATA(bq2752x,   0         , BQ27XXX_O_OTDC),
@@ -1420,7 +1421,7 @@ static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
 {
 	int soc;
 
-	if (di->opts & BQ27XXX_O_ZERO)
+	if (di->opts & BQ27XXX_O_SOC_SI)
 		soc = bq27xxx_read(di, BQ27XXX_REG_SOC, true);
 	else
 		soc = bq27xxx_read(di, BQ27XXX_REG_SOC, false);
-- 
2.17.1

