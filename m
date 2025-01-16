Return-Path: <linux-pm+bounces-20528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F0A1349F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 09:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C86166CF9
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E7198850;
	Thu, 16 Jan 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbpmaubP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468019343E;
	Thu, 16 Jan 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014688; cv=none; b=V6w2Gxu/hrxhGIpkM9EJGbaDFpZ7bPT1F5OR1LdEqfE2cQ9NszEM0ErzNO/M71H8dmhduZPMcM1BLFYJ55qsg9FPG8PotCYSEkE9wB5kO+NpyZfo9A4qDjoJabHsnJc1sPLczJz4PK95my9HRtHftwjcZeGuj4M+Ts2F6iGz1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014688; c=relaxed/simple;
	bh=uvB1h+87siG9diTP5RB8Hj+24Ej2g94Oj7tqxT4bTjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qIK9KiTuChNck0Nad0tCnzGYuKghp0hxJVHo9HyMf7Z9Fvs8Tx5tFoewZ8Amc+8AVYo0mwpyu6yyk93Vq+Wk0K3cGEc4Ajax8I+T6l/I0+MIMwG4H56wDXhni7VKL8s/jfK9gtNfUsDC2a1jAiWFQpAOY7o4alheYeASzPgeDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbpmaubP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18713C4CED6;
	Thu, 16 Jan 2025 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737014688;
	bh=uvB1h+87siG9diTP5RB8Hj+24Ej2g94Oj7tqxT4bTjY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SbpmaubPgJkIACL3DRWqXWdfc1xPo5ZkXxBUElln9GlXw8mS10jZZc9oR4zNjloUl
	 /0MfopnEtu9hgU0kP/qNCkH9vxoROLyI/NPFNfUS6hBIeQ1p+l6V5e5tUiaP1WTKm8
	 RJWenFUEN/skGQ1qNnJyYOP4eGymRQ8ojxvQO/Se8lmoU5sQbIQzx82vOJH6XXcUvd
	 DY1JfJAxaTC4p8pY2gW/fOpPyvOKZU3J1jBphS1oDMBpFivNDzIWjxeJy5Nvav1pSw
	 g3MZG7vQbinhqVrqHyQxjuqEBUSrFXl6BmUdXDm/IwZ5iMpWid4u/7dO0cUaT/nIeO
	 6VNRsL0Hj57zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07870C02180;
	Thu, 16 Jan 2025 08:04:48 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 16 Jan 2025 09:04:29 +0100
Subject: [PATCH v2] power: supply: max1720x: add support for reading
 internal and thermistor temperatures
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-max1720x-temperature-v2-1-9638969d091a@liebherr.com>
X-B4-Tracking: v=1; b=H4sIAIy9iGcC/4WNTQ6CMBBGr0JmbU2nqA2uuIdhAe0gk8hPpthgS
 O9u5QIu30u+9+0QSJgC3IsdhCIHnqcM5lSAG9rpSYp9ZjDaXDViqcZ2Q2v0plYaF5J2fQspR+5
 m++6isbKQp4tQz9uRfTSZBw7rLJ/jJeLP/glGVKicr7wvu8obtPWLqRtI5OzmEZqU0heKtsJSu
 wAAAA==
X-Change-ID: 20250113-max1720x-temperature-cec67fb40197
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Thomas Antoine <t.antoine@uclouvain.be>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737014687; l=5333;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=fn4u6JBkLe9ziUbn1gD/a8EhRkjnGm3GtfEWO+TsGa8=;
 b=dAkFeQoN0VmR3Y+MbdFqyhxNmqSOMwbGpepG68DabcRXlIGiMeTUQZQAuwTaWt8V8q9Yl68f7
 60z7AXnRf3/AG60eHn5owQcyl0nhQPaN+tDcXKjfg3FSqc4UKOliR9R
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
Changes in v2:
- Rename device attribute temp1 to temp_ain1
- Rename device attribute temp2 to temp_ain2
- Rename device attribute int_temp to temp_int
- Add documentation to max1720x to Documentation/ABI/testing/
- Link to v1: https://lore.kernel.org/r/20250113-max1720x-temperature-v1-1-cd9dd3b9d217@liebherr.com
---
 .../ABI/testing/sysfs-class-power-max1720x         | 32 ++++++++++++
 drivers/power/supply/max1720x_battery.c            | 60 +++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-max1720x b/Documentation/ABI/testing/sysfs-class-power-max1720x
new file mode 100644
index 0000000000000000000000000000000000000000..7d895bfda9ced2ba089723065b3ec27d1d3204ee
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-max1720x
@@ -0,0 +1,32 @@
+What:		/sys/class/power_supply/max1720x/temp_ain1
+Date:		January 2025
+KernelVersion:	6.14
+Contact:	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
+Description:
+		Reports the current temperature reading from AIN1 thermistor.
+
+		Access: Read
+
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/max1720x/temp_ain2
+Date:		January 2025
+KernelVersion:	6.14
+Contact:	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
+Description:
+		Reports the current temperature reading from AIN2 thermistor.
+
+		Access: Read
+
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/max1720x/temp_int
+Date:		January 2025
+KernelVersion:	6.14
+Contact:	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
+Description:
+		Reports the current temperature reading from internal die.
+
+		Access: Read
+
+		Valid values: Represented in 1/10 Degrees Celsius
diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index 9c7e14d2c7b87b8194511f36ade16e774281333e..11580e414713b7f42354a8bf4e4ef7bee6e33f36 100644
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
+static ssize_t temp_ain1_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return max1720x_read_temp(dev, MAX172XX_TEMP1, buf);
+}
+
+static ssize_t temp_ain2_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return max1720x_read_temp(dev, MAX172XX_TEMP2, buf);
+}
+
+static ssize_t temp_int_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return max1720x_read_temp(dev, MAX172XX_INT_TEMP, buf);
+}
+
+static DEVICE_ATTR_RO(temp_ain1);
+static DEVICE_ATTR_RO(temp_ain2);
+static DEVICE_ATTR_RO(temp_int);
+
+static struct attribute *max1720x_attrs[] = {
+	&dev_attr_temp_ain1.attr,
+	&dev_attr_temp_ain2.attr,
+	&dev_attr_temp_int.attr,
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
base-commit: 260d7c5e5392ac41c94152005d416172ba0a906d
change-id: 20250113-max1720x-temperature-cec67fb40197

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



