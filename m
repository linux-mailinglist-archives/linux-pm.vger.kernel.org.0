Return-Path: <linux-pm+bounces-20339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702DA0B97B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B15E18834C9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A08B2451F4;
	Mon, 13 Jan 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owjwjl2E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594B22CF01;
	Mon, 13 Jan 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778476; cv=none; b=ou9gifinuNJNDp6FHTO8vKsS30q7OXn/06yZ59A97NjRgPrIl8CiAEjew63ozzLobIqNsGK/3SkPNOm6mNSAgVuwFVmYlhcoL/iQ57bTy6moQGXZSakH6y9du8WSxEVlsndScNzChMlB9eGtR4A/HAEk2snpl9IUfg66+I05Gqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778476; c=relaxed/simple;
	bh=zBNJvirkPbZH39sD+0xO80qgqTxIPVW47QJm1g5Czyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=unz7vrZERCh4C+/4GPvHsqxMeKCAxU7abc4Lxm9FuLKKJNxGNMvzTkc6XVJTCMArCmFOxwEX+10e3k0uI5RIbmLNb5CEZK1veXyos+9Uf1N19V6E6yuoL9Vh+5qiDgG97ov2JEE/PiOa3jb4N/3dvDtSKU99P8lN96VFo5U/dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owjwjl2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61227C4CED6;
	Mon, 13 Jan 2025 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736778476;
	bh=zBNJvirkPbZH39sD+0xO80qgqTxIPVW47QJm1g5Czyo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=owjwjl2E2fTXmoz5SNecmt8lPIO0WE9KOQVgXDvzu1pjIZyv9JGpoXWp60sS5/i4v
	 3Nlt5iTSgzz0ORh26APGvqVovjsp/z64uN3uLEtk7LIhXf61+Gz29PxkTrqEcq7P3q
	 N1uqeupxi9SUPD0c/Gxosh8mX4kvnR5hDMVnVY7vr0tcBSFpZBH7lKLp7WLlD1fylI
	 zv41Mo64X+tsnPc7mOoEXUqp90+DYUbPHQ1DrJQAUdWoG1VDi13/bPmlpW2TcMnWWd
	 WysjhHt/4VopEc5iqNbOZ1auWULNxyRwY9Q6K/LsuqJhOMVPF20+TsJob1w73hbd29
	 hvZx4hdVYesNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44094C02183;
	Mon, 13 Jan 2025 14:27:56 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 13 Jan 2025 15:27:49 +0100
Subject: [PATCH] power: supply: max1720x: add support for reading internal
 and thermistor temperatures
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-max1720x-temperature-v1-1-cd9dd3b9d217@liebherr.com>
X-B4-Tracking: v=1; b=H4sIAOQihWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0Nj3dzECkNzI4MK3ZLU3ILUosSS0qJU3eTUZDPztCQTA0NLcyWg1oK
 i1LTMCrCx0bG1tQDu4qTGZgAAAA==
X-Change-ID: 20250113-max1720x-temperature-cec67fb40197
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Thomas Antoine <t.antoine@uclouvain.be>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736778475; l=3626;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=tNnvcuGqUPla8DNfaallDP1bxLQokRFOjPTqUVR0Mxw=;
 b=Lu8XUfc0fR497Q9YVIzekkwSitpFZ/FrVQRxujx3bT3TnNcALNSk0s78BwNIM2AHyLCbuRJN7
 Z1d6C+AkzEECzMZx0ztrYeCCwKCe6WWxQg+4ZwWiEldlEEY0IhHKrn7
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

If enabled in the nPackCfg register, the Temp1, Temp2 and IntTemp registers
contain the temperature readings from the AIN1 thermistor, AIN2 thermistor
and internal die temperature respectively. Registers are shared between SBS
and normal IC functions and are always readable regardless of IC settings.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/power/supply/max1720x_battery.c | 60 ++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index 9c7e14d2c7b87b8194511f36ade16e774281333e..e237528df29d2cac87361b75d71c576c0ed2b530 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -16,6 +16,11 @@
 
 #include <linux/unaligned.h>
 
+/* SBS compliant registers */
+#define MAX172XX_TEMP1			0x34
+#define MAX172XX_INT_TEMP		0x35
+#define MAX172XX_TEMP2			0x3B
+
 /* Nonvolatile registers */
 #define MAX1720X_NXTABLE0		0x80
 #define MAX1720X_NRSENSE		0xCF	/* RSense in 10^-5 Ohm */
@@ -113,11 +118,15 @@ static const struct regmap_config max1720x_regmap_cfg = {
 };
 
 static const struct regmap_range max1720x_nvmem_allow[] = {
+	regmap_reg_range(MAX172XX_TEMP1, MAX172XX_INT_TEMP),
+	regmap_reg_range(MAX172XX_TEMP2, MAX172XX_TEMP2),
 	regmap_reg_range(MAX1720X_NXTABLE0, MAX1720X_NDEVICE_NAME4),
 };
 
 static const struct regmap_range max1720x_nvmem_deny[] = {
-	regmap_reg_range(0x00, 0x7F),
+	regmap_reg_range(0x00, 0x33),
+	regmap_reg_range(0x36, 0x3A),
+	regmap_reg_range(0x3C, 0x7F),
 	regmap_reg_range(0xE0, 0xFF),
 };
 
@@ -388,6 +397,54 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static int max1720x_read_temp(struct device *dev, u8 reg, char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct max1720x_device_info *info = power_supply_get_drvdata(psy);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(info->regmap_nv, reg, &val);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Temperature in degrees Celsius starting at absolute zero, -273C or
+	 * 0K with an LSb of 0.1C
+	 */
+	return sysfs_emit(buf, "%d\n", val - 2730);
+}
+
+static
+ssize_t temp1_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return max1720x_read_temp(dev, MAX172XX_TEMP1, buf);
+}
+
+static
+ssize_t temp2_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return max1720x_read_temp(dev, MAX172XX_TEMP2, buf);
+}
+
+static
+ssize_t int_temp_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return max1720x_read_temp(dev, MAX172XX_INT_TEMP, buf);
+}
+
+static DEVICE_ATTR_RO(temp1);
+static DEVICE_ATTR_RO(temp2);
+static DEVICE_ATTR_RO(int_temp);
+
+static struct attribute *max1720x_attrs[] = {
+	&dev_attr_temp1.attr,
+	&dev_attr_temp2.attr,
+	&dev_attr_int_temp.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(max1720x);
+
 static
 int max1720x_nvmem_reg_read(void *priv, unsigned int off, void *val, size_t len)
 {
@@ -488,6 +545,7 @@ static int max1720x_probe(struct i2c_client *client)
 
 	psy_cfg.drv_data = info;
 	psy_cfg.fwnode = dev_fwnode(dev);
+	psy_cfg.attr_grp = max1720x_groups;
 	i2c_set_clientdata(client, info);
 	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
 	if (IS_ERR(info->regmap))

---
base-commit: a3a8799165ff83bb764fd800c6559c3cba0ddac3
change-id: 20250113-max1720x-temperature-cec67fb40197

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



