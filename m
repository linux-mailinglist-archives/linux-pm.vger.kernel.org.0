Return-Path: <linux-pm+bounces-35482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB2BA4A86
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A270617BC25
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F92F2618;
	Fri, 26 Sep 2025 16:34:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69626CE0C;
	Fri, 26 Sep 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904475; cv=none; b=AxnjINWSzOjMs2uozQI4jbm6moWspPsPs2q4G6GwcHY4z7UEtBa2GTjN44eNnLYbIQMrbGHwrLKzcxofrY3arJRBoX9xQa0tciVLBrNgSe7cxea6eoaxwPJgJ8r1/xuEL8e5amKwG9js9AylTSwoQBeT7gkNmPj/gircnP7mpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904475; c=relaxed/simple;
	bh=O5aJKIVrAbTQR2ETxQmeGB5vf+e0C6aBqzUs+KBSS5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sq4JwTPtnhIjPPnieI4IcT6rXfBgf1FAaK1GvqTdr8nScNUbReXGmCsyj6hndtX7lAoKJyMJYXB/5i+4TgVx/svHdhdovG3r4V2Ij3MApTZ7IX/BnIJbQZhocNYof2hg1rcleMnQIOjg2VA36ASmFfLrSvATpGqoIBgBCohMK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 1D4761C2505;
	Fri, 26 Sep 2025 18:27:09 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf8:0:ec51:b786:a581:3dd1])
	by srv01.abscue.de (Postfix) with ESMTPSA id 4AB671C250A;
	Fri, 26 Sep 2025 18:27:08 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Fri, 26 Sep 2025 18:23:27 +0200
Subject: [PATCH 5/5] power: reset: sc27xx: Add reboot support for SC2730
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250926-sc2730-reboot-v1-5-62ebfd3d31bb@abscue.de>
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
In-Reply-To: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Unlike SC2731, the SC2730 PMIC also provides dedicated registers for
resetting the hardware. Use them to implement reboot support.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/power/reset/sc27xx-poweroff.c | 89 +++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 5937f40021817ea38453705fcef6485ce79ac14c..1dfa54675b3e7b8b79212dc9950d97b726dd5acc 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -18,16 +18,42 @@
 #define SC2730_SLP_CTRL		0x1a48
 #define SC2730_LDO_XTL_EN	BIT(2)
 
+#define SC2730_SOFT_RST_HW	0x1824
+#define SC2730_RST_STATUS	0x1bac
+#define SC2730_SWRST_CTRL0	0x1bf8
+
 #define SC2731_PWR_PD_HW	0xc2c
 #define SC2731_SLP_CTRL		0xdf0
 #define SC2731_LDO_XTL_EN	BIT(3)
 
 #define SC27XX_PWR_OFF_EN	BIT(0)
+#define SC27XX_SOFT_RST_EN	BIT(4)
+#define SC27XX_RESET		BIT(0)
+
+#define HWRST_STATUS_SECURITY		0x02
+#define HWRST_STATUS_RECOVERY		0x20
+#define HWRST_STATUS_NORMAL		0x40
+#define HWRST_STATUS_ALARM		0x50
+#define HWRST_STATUS_SLEEP		0x60
+#define HWRST_STATUS_FASTBOOT		0x30
+#define HWRST_STATUS_SPECIAL		0x70
+#define HWRST_STATUS_PANIC		0x80
+#define HWRST_STATUS_CFTREBOOT		0x90
+#define HWRST_STATUS_AUTODLOADER	0xa0
+#define HWRST_STATUS_IQMODE		0xb0
+#define HWRST_STATUS_SPRDISK		0xc0
+#define HWRST_STATUS_FACTORYTEST	0xe0
+#define HWRST_STATUS_WATCHDOG		0xf0
+#define HWRST_STATUS_MASK		0xf0
 
 struct sc27xx_poweroff_reg_info {
 	u32 poweroff_reg;
 	u32 slp_ctrl_reg;
 	u32 ldo_xtl_en;
+
+	u32 reset_reg;
+	u32 rst_sts_reg;
+	u32 swrst_ctrl_reg;
 };
 
 struct sc27xx_poweroff_data {
@@ -78,9 +104,59 @@ static int sc27xx_poweroff_do_poweroff(struct sys_off_data *off_data)
 	return NOTIFY_DONE;
 }
 
+static int sc27xx_restart(struct sys_off_data *off_data)
+{
+	struct sc27xx_poweroff_data *data = off_data->cb_data;
+	u32 reboot_mode = 0;
+
+	if (!off_data->cmd)
+		reboot_mode = HWRST_STATUS_NORMAL;
+	else if (!strcmp(off_data->cmd, "recovery"))
+		reboot_mode = HWRST_STATUS_RECOVERY;
+	else if (!strcmp(off_data->cmd, "alarm"))
+		reboot_mode = HWRST_STATUS_ALARM;
+	else if (!strcmp(off_data->cmd, "fastsleep"))
+		reboot_mode = HWRST_STATUS_SLEEP;
+	else if (!strcmp(off_data->cmd, "bootloader"))
+		reboot_mode = HWRST_STATUS_FASTBOOT;
+	else if (!strcmp(off_data->cmd, "panic"))
+		reboot_mode = HWRST_STATUS_PANIC;
+	else if (!strcmp(off_data->cmd, "special"))
+		reboot_mode = HWRST_STATUS_SPECIAL;
+	else if (!strcmp(off_data->cmd, "cftreboot"))
+		reboot_mode = HWRST_STATUS_CFTREBOOT;
+	else if (!strcmp(off_data->cmd, "autodloader"))
+		reboot_mode = HWRST_STATUS_AUTODLOADER;
+	else if (!strcmp(off_data->cmd, "iqmode"))
+		reboot_mode = HWRST_STATUS_IQMODE;
+	else if (!strcmp(off_data->cmd, "sprdisk"))
+		reboot_mode = HWRST_STATUS_SPRDISK;
+	else if (!strcmp(off_data->cmd, "tospanic"))
+		reboot_mode = HWRST_STATUS_SECURITY;
+	else if (!strcmp(off_data->cmd, "factorytest"))
+		reboot_mode = HWRST_STATUS_FACTORYTEST;
+	else
+		reboot_mode = HWRST_STATUS_NORMAL;
+
+	regmap_update_bits(data->regmap, data->regs->rst_sts_reg,
+			   HWRST_STATUS_MASK, reboot_mode);
+
+	regmap_set_bits(data->regmap, data->regs->swrst_ctrl_reg,
+			SC27XX_SOFT_RST_EN);
+
+	regmap_write(data->regmap, data->regs->reset_reg, SC27XX_RESET);
+
+	mdelay(1000);
+
+	pr_emerg("Unable to restart system\n");
+
+	return NOTIFY_DONE;
+}
+
 static int sc27xx_poweroff_probe(struct platform_device *pdev)
 {
 	struct sc27xx_poweroff_data *data;
+	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -96,6 +172,15 @@ static int sc27xx_poweroff_probe(struct platform_device *pdev)
 
 	register_syscore_ops(&poweroff_syscore_ops);
 
+	if (data->regs->reset_reg) {
+		ret = devm_register_sys_off_handler(&pdev->dev,
+						    SYS_OFF_MODE_RESTART,
+						    192, sc27xx_restart,
+						    data);
+		if (ret)
+			return ret;
+	}
+
 	return devm_register_sys_off_handler(&pdev->dev,
 					     SYS_OFF_MODE_POWER_OFF,
 					     SYS_OFF_PRIO_DEFAULT,
@@ -107,6 +192,10 @@ static const struct sc27xx_poweroff_reg_info sc2730_pwr_regs = {
 	.poweroff_reg = SC2730_PWR_PD_HW,
 	.slp_ctrl_reg = SC2730_SLP_CTRL,
 	.ldo_xtl_en = SC2730_LDO_XTL_EN,
+
+	.reset_reg = SC2730_SOFT_RST_HW,
+	.rst_sts_reg = SC2730_RST_STATUS,
+	.swrst_ctrl_reg = SC2730_SWRST_CTRL0,
 };
 
 static const struct sc27xx_poweroff_reg_info sc2731_pwr_regs = {

-- 
2.50.0


