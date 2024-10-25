Return-Path: <linux-pm+bounces-16449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99B9B01E2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C841B21EEC
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EE0203706;
	Fri, 25 Oct 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ADpfPwrb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD298202648
	for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857921; cv=none; b=SXO40tE2xWiuYEmTeRkkzzZJRaLy4pn1j1xVLKPq8uYDkt+lF6pmh3uR9U606J0Xt2N1+FJnm3i7A1p6k7QfiHphYmMaPugZK9alvtGqyuLgqwgum0te2/ijNi+RPrUXOZnP+FTYMLz7dFgJkKlBbK5YetunJqJsOFX92COCYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857921; c=relaxed/simple;
	bh=+Wfgnk2y+8thlkLyvzLM2U7F941dQQ/SYTkJwIlFwEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X9pLkJS9MJK8qdyeZolU1PIPAOSO3/uC6n3dEXqfFlUybHSp+ucioXQ3nIlE3fcYUP593zoYlL1PM1AnE0kC688w5Mrl1CcrZDoRcEdpFPb7C4x22mD+RdEhM7BsVwaFUAsA/bwYQ2u2TIRFIG14uQOd9PpMqjX/Xk+3DE9cmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ADpfPwrb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c767a9c50so16227575ad.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729857917; x=1730462717; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8yKR4BVLvMBogTBQ5uhZAmMCQQBIAWiGqlkb0ku774=;
        b=ADpfPwrbbdTwE3HT6iLYNnSBpb1kvR7vXdqqR8qquCG5VpKc3O8/PhfF1Mk7qkSfsa
         Fw+doCeJxo12yf+Br3dLmfNLUVMfR1irkqSrjxjRhB+Rftu9rL/MRrVGsQkJvr5uOVfN
         R/nx9kDHS+Pvr9n6vGVV72GSpWOnk5YE7/cqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729857917; x=1730462717;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8yKR4BVLvMBogTBQ5uhZAmMCQQBIAWiGqlkb0ku774=;
        b=oLS/k+DAIFr93hHNPFDWbHZSNp4RXRmn5IajPjiO3hH/kGlULolOswuVlIcMtwzdhg
         wDfSVi0g+W7WJQwlnSxHeqTWsz64gSnxvPKRtzxVDgGk/O1XBjlK/uarxO0NW09HxQIS
         RmAxpAnI3tuVWlhS4NdT7QmvDnC3fZtWn+DdJO6I7lSg10o0DURzv8/a4kIhflotQQh0
         jDtcQiA/jHKAxNUXECQMbCzMVUE0gxq/aA1EqWTSkly1D1MUpY9cnMljjAcVbO0/c6oX
         Q2Y3TdDT6MIVsvwLgBntjatxEY3ZSuIWoDC0N78KOJZxWFJvFjQSi2X0zwxCgRXmyDsc
         5JYA==
X-Gm-Message-State: AOJu0Yy4ToSPwypZmaUuSR3K9GfLs7800rlqO6hrj8fMkCIHGVcjBv3j
	O6gVeX/gPzckWFANLbRMVJe+bgoxQKeWaBPEMXfTvlfVIAQkKWuGEZSpoztl/Q==
X-Google-Smtp-Source: AGHT+IFgd+gptg43VdhIDSdk7mGqoF3jpDKUK7U7sWb9MrqLl4Aed6DcyNuNHfI9LnX+jfuduFQLJA==
X-Received: by 2002:a17:903:2341:b0:20c:62e1:6361 with SMTP id d9443c01a7336-20fa9e77fd7mr131727475ad.25.1729857916917;
        Fri, 25 Oct 2024 05:05:16 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02eb3fsm8309495ad.202.2024.10.25.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:05:16 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 25 Oct 2024 12:05:12 +0000
Subject: [PATCH v14] thermal/drivers/mediatek/auxadc_thermal: expose all
 thermal sensors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-auxadc_thermal-v14-1-96ab5b60c02e@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHeJG2cC/3XP0W7CMAwF0F+p8kxQHKdZyxP/gdCUug6NtLYoh
 apT1X8nRdMEgz3a1j1XnsXAMfAgdtksIo9hCH2XBjCbTFDjuhPLUKeF0EobVahSuuvkavq8NBx
 b9yXLihELpqICEil0juzDdBcPxzQ3Ybj08fteMAKs63+tdJcgnUdL9GE8OtxTE/s2XNttH09i9
 UbQvwYoBa+GToauCkuqNN4b+2xssp8o2PdRUgaRS2/B+Xf1+FCv81cD1xdyjUC5romqP8ayLDc
 EV8lqdQEAAA==
X-Change-ID: 20240809-auxadc_thermal-9be338ec8b1c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 James Lo <james.lo@mediatek.com>, Michael Kao <michael.kao@mediatek.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Ben Tseng <ben.tseng@mediatek.com>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

From: James Lo <james.lo@mediatek.com>

Previously, the driver only supported reading the temperature from all
sensors and returning the maximum value. This update adds another
get_temp ops to support reading the temperature from each sensor
separately.

Especially, some thermal zones registered by this patch are needed by
MT8183 since those thermal zones are necessary for mtk-svs driver.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
Signed-off-by: James Lo <james.lo@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v14:
- Remove redundant error message.
- Link to v13: https://lore.kernel.org/r/20241025-auxadc_thermal-v13-1-a5231c52dccb@chromium.org

Changes in v13:
- Make subject and commit message more clear.
- Make error message more clear.
- Link to v12: https://lore.kernel.org/r/20241016-auxadc_thermal-v12-1-c0433e9f61af@chromium.org

Changes in v12:
- Remove unnecessary check and unused variable assignment in mtk_read_sensor_temp.
- Add more about what this patch achieves in the commit message.
- Link to v11: https://lore.kernel.org/r/20240809-auxadc_thermal-v11-1-af36cc74f3a3@chromium.org

Changes in V11:
    - Rebase on kernel v6.11-rc2
    - Use mtk_thermal_temp_is_valid in mtk_read_sensor_temp just like
      mtk_thermal_bank_temperature
    - Change the error handling of devm_thermal_of_zone_register return
      value
    - link to V10: https://lore.kernel.org/lkml/20220519101044.16765-1-james.lo@mediatek.com/

Changes in V10:
    - Rebase to kernel-v5.18-rc7
    - Resend

Changes in V9:
    - Rebase to kernel-v5.14-rc1
    - Bind raw_to_mcelsius_v1 or raw_to_mcelsius_v2 to compatible
      data of struct mtk_thermal_data
    - Remove duplicate struct 'mtk_thermal_bank'
    - Remove unnecessary if condition check
    - Return error if any thermal zone fail to register

Changes in V8:
    - Rebase to kernel-v5.13-rc1
    - Resend

Changes in v7:
    - Fix build error in v6.

Changes in v6:
    - Rebase to kernel-5.11-rc1.
    - [1/3]
        - add interrupts property.
    - [2/3]
        - add the Tested-by in the commit message.
    - [3/3]
        - use the mt->conf->msr[id] instead of conf->msr[id] in the
          _get_sensor_temp and mtk_thermal_bank_temperature.
        - remove the redundant space in _get_sensor_temp and
          mtk_read_sensor_temp.
        - change kmalloc to dev_kmalloc in mtk_thermal_probe.

Changes in v5:
    - Rebase to kernel-5.9-rc1.
    - Revise the title of cover letter.
    - Drop "[v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL"
    - [2/2]
        -  Add the judgement to the version of raw_to_mcelsius.

Changes in v4:
    - Rebase to kernel-5.6-rc1.
    - [1/7]
        - Squash thermal zone settings in the dtsi from [v3,5/8]
          arm64: dts: mt8183: Increase polling frequency for CPU thermal zone.
        - Remove the property of interrupts and mediatek,hw-reset-temp.
    - [2/7]
        - Correct commit message.
    - [4/7]
        - Change the target temperature to the 80C and change the commit message.
    - [6/7]
        - Adjust newline alignment.
        - Fix the judgement on the return value of registering thermal zone.

Changes in v3:
    - Rebase to kernel-5.5-rc1.
    - [1/8]
        - Update sustainable power of cpu, tzts1~5 and tztsABB.
    - [7/8]
        - Bypass the failure that non cpu_thermal sensor is not find in thermal-zones
          in dts, which is normal for mt8173, so prompt a warning here instead of
          failing.

    Return -EAGAIN instead of -EACCESS on the first read of sensor that
        often are bogus values. This can avoid following warning on boot:

          thermal thermal_zone6: failed to read out thermal zone (-13)

Changes in v2:
    - [1/8]
        - Add the sustainable-power,trips,cooling-maps to the tzts1~tztsABB.
    - [4/8]
        - Add the min opp of cpu throttle.
---

---
 drivers/thermal/mediatek/auxadc_thermal.c | 70 +++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 9ee2e7283435acfcbb1a956303b6122a08affecc..9a9079d559a3abe9e3823f744d4c9a159a8666bd 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -847,7 +847,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 
 static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 {
-	struct mtk_thermal *mt = thermal_zone_device_priv(tz);
+	struct mtk_thermal_bank *bank = thermal_zone_device_priv(tz);
+	struct mtk_thermal *mt = bank->mt;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -866,10 +867,41 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 	return 0;
 }
 
+static int mtk_read_sensor_temp(struct thermal_zone_device *tz, int *temperature)
+{
+	struct mtk_thermal_bank *bank = thermal_zone_device_priv(tz);
+	struct mtk_thermal *mt = bank->mt;
+	const struct mtk_thermal_data *conf = mt->conf;
+	int id = bank->id - 1;
+	int temp = INT_MIN;
+	u32 raw;
+
+	raw = readl(mt->thermal_base + conf->msr[id]);
+
+	temp = mt->raw_to_mcelsius(mt, id, raw);
+
+	/*
+	 * The first read of a sensor often contains very high bogus
+	 * temperature value. Filter these out so that the system does
+	 * not immediately shut down.
+	 */
+
+	if (unlikely(!mtk_thermal_temp_is_valid(temp)))
+		return -EAGAIN;
+
+	*temperature = temp;
+
+	return 0;
+}
+
 static const struct thermal_zone_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
+static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
+	.get_temp = mtk_read_sensor_temp,
+};
+
 static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 				  u32 apmixed_phys_base, u32 auxadc_phys_base,
 				  int ctrl_id)
@@ -1199,6 +1231,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	u64 auxadc_phys_base, apmixed_phys_base;
 	struct thermal_zone_device *tzdev;
 	void __iomem *apmixed_base, *auxadc_base;
+	struct mtk_thermal_bank *tz;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -1285,14 +1318,35 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
 					      auxadc_phys_base, ctrl_id);
 
-	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
-					      &mtk_thermal_ops);
-	if (IS_ERR(tzdev))
-		return PTR_ERR(tzdev);
+	for (i = 0; i <= mt->conf->num_sensors; i++) {
+		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
+		if (!tz)
+			return -ENOMEM;
+
+		tz->mt = mt;
+		tz->id = i;
+
+		tzdev = devm_thermal_of_zone_register(&pdev->dev, i,
+						      tz, (i == 0) ?
+						      &mtk_thermal_ops
+						      : &mtk_thermal_sensor_ops);
+
+		if (IS_ERR(tzdev)) {
+			ret = PTR_ERR(tzdev);
+			if (ret == -ENODEV) {
+				dev_warn(&pdev->dev,
+					 "Can't find thermal zone for sensor %d; sensor skipped.\n", i);
+				continue;
+			}
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to register thermal zone %d.\n", i);
+		}
 
-	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
-	if (ret)
-		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
+		ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "Sensor %d: Error in thermal_add_hwmon_sysfs: %d\n", i, ret);
+	}
 
 	return 0;
 }

---
base-commit: b589839414be04b2b37e4bf6f84af576c99faf64
change-id: 20240809-auxadc_thermal-9be338ec8b1c

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


