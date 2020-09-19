Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04816270E59
	for <lists+linux-pm@lfdr.de>; Sat, 19 Sep 2020 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgISOEm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Sep 2020 10:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgISOEi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Sep 2020 10:04:38 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5376821D43;
        Sat, 19 Sep 2020 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524278;
        bh=22njGzYbgVLmqZwKMutr7y/CtPsY/fcDoav/iUVMvtk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H+vLyMxeyYECtqIstFTAEVcYMVxLLUGWmOnDIg4GXGuxFW1vJxBK098ltm2HfV7v+
         nQ9BqSeEW4/Vsnns7z8JsXZyHJfY9q2EXB+FhB6V+oyQahkyUDfPFm1QZQJHntoAkH
         MeqNgQbLVvrXMjLeiVL5mFjgLL0x8/YQREYywY2s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] power: supply: bq27xxx: adjust whitespace and use BIT() for bitflags
Date:   Sat, 19 Sep 2020 16:04:15 +0200
Message-Id: <20200919140418.3705-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200919140418.3705-1-krzk@kernel.org>
References: <20200919140418.3705-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

BIT() is a preferred way to toggle bit-like flags: no problems with 32/64
bit systems, less chances for mistakes.  Remove also unneeded
whitespace.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 65806f668b1f..e971af43dd45 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -76,7 +76,7 @@
 
 /* BQ27Z561 has different layout for Flags register */
 #define BQ27Z561_FLAG_FDC	BIT(4) /* Battery fully discharged */
-#define BQ27Z561_FLAG_FC		BIT(5) /* Battery fully charged */
+#define BQ27Z561_FLAG_FC	BIT(5) /* Battery fully charged */
 #define BQ27Z561_FLAG_DIS_CH	BIT(6) /* Battery is discharging */
 
 /* control register params */
@@ -847,13 +847,14 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 
 #define bq27z561_dm_regs 0
 #define bq28z610_dm_regs 0
-
-#define BQ27XXX_O_ZERO	0x00000001
-#define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
-#define BQ27XXX_O_UTOT  0x00000004 /* has OT overtemperature flag */
-#define BQ27XXX_O_CFGUP	0x00000008
-#define BQ27XXX_O_RAM	0x00000010
-#define BQ27Z561_O_BITS	0x00000020
+#define bq34z100_dm_regs 0
+
+#define BQ27XXX_O_ZERO		BIT(0)
+#define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
+#define BQ27XXX_O_UTOT		BIT(2) /* has OT overtemperature flag */
+#define BQ27XXX_O_CFGUP		BIT(3)
+#define BQ27XXX_O_RAM		BIT(4)
+#define BQ27Z561_O_BITS		BIT(5)
 
 #define BQ27XXX_DATA(ref, key, opt) {		\
 	.opts = (opt),				\
-- 
2.17.1

