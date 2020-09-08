Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D366C2620A4
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgIHUNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgIHUNg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 16:13:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2605120936;
        Tue,  8 Sep 2020 20:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599596015;
        bh=G1rBETN5Htd6dGPg5Ma1dHWDGClo+P7ZqLA4Y4JKMW4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kHVa7NspCaBfKbJYvTF6xCHEcZYas6hLZDVQoWl0jXEoLlqWbA5/XM91+kVjb0c5X
         wrt8HNNPXjipBPc8AgkMyYGY8pyny80M0nMQORV2hbMrQN73GpppOcCb15Rm28NAg6
         B3Pb5zXg99rF/+FqvHyfLK01mMM7N1kSYNo9vU+s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] power: supply: bq27xxx: add separate flag for single SoC register
Date:   Tue,  8 Sep 2020 22:13:17 +0200
Message-Id: <20200908201319.3567-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908201319.3567-1-krzk@kernel.org>
References: <20200908201319.3567-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
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

