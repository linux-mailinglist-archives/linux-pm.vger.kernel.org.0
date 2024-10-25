Return-Path: <linux-pm+bounces-16446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6322D9B0090
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847E61C22844
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 10:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A036C1F6688;
	Fri, 25 Oct 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XnqHj4eb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028351E766B
	for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853578; cv=none; b=PDijwL11NKM/r4MCYah9DvLJn5MRDrVYFEPsRN1VV+pzdGarnz/RaAw15+mtPH4YXpIgFyf1nL/bzHrDhvjPvm4NGMtIeEd2yDcEHShAdyhUH360ertlU/4qE+LawtndiYgCyBqDvbOCBnsBKAm02dbUOmzBt0fdq6zFo2+qj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853578; c=relaxed/simple;
	bh=DgKF4BjdQJEGFkoe7RckaZnVN6EKH3DF+7wTV4b5as8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P0ipDC/VvNVEVNBZm13j/PSnl9LcbrrzghIrkBmDjmz3+tctAfKc7Bk1DKOcor7IhTI17A4kJdEzHhMVuqItz+0fsVbmoJLI12HNUC5n10LYaPtG+c/HurWXelPYCM6KA+4ng+mcRQHVa+Oy+Aunx6xpo/qZmASahfvKFO+YbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XnqHj4eb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c9978a221so18843175ad.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729853575; x=1730458375; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAt6KZ2pcfQy1Q7Rf4LRIXYYKzgia9CxnAXXiCJCkII=;
        b=XnqHj4ebikHdwsxLNxcjzo6ETdB5Pa8VbcJlPwJSka0+a/ULbNsNSbjBMsuxi5QdBE
         p8gA+nVRve3Zht0Ms9MOOcumKQtAOx1w1urWpQfsMetkBk2gFWTj7CIojbTpdfYu51sF
         BH7nC6ebZ8G99VSADLngjjnQCtX78IyrYzOqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729853575; x=1730458375;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAt6KZ2pcfQy1Q7Rf4LRIXYYKzgia9CxnAXXiCJCkII=;
        b=kSHpWjsu0TN6Wv75joBOMTp6Vmt8NEXDHLzzFBrMuDEwP10fJlt96hQW2e1TaP689b
         XqV/o6PYOmL2fOU747uX1XS+dRAqRIO5QUasiOYkbsF0nYMZWNTpQ9uFvPyWaYj0W0JZ
         atteRzzmPXk+wb4DJ9LEcV1Az1ly0tH9wuYpgeIxn1pqR0yLTkE7esW7DmxeklcXjQ9G
         s0ZGjrUSX29xUH92T4xqc58xbxJmwlJG9gd69C5Xzj0zWT4ASc+Z9hzGrW1wBVZfIHxp
         mMKjqmIh2rV51zBkICIe7yIWly2eLw/wA9NL5MEfIszq3oc6ZtjjlwNrF6+sO3AwSz7y
         +H/A==
X-Gm-Message-State: AOJu0Yy0QPNVz+nx/tatpBRJYTiqbXt9MR7BZ/LGJHPNBHAHWN6duPKx
	rOLPeoCwcLqfH+Fhhgf29HD5Bm86Lq/PsCe7cvgicNtosKyBLuAXJOKYkJ+MsQ==
X-Google-Smtp-Source: AGHT+IG9X1lMdE2CHaDjkcTeXOKM/Gxm5oeIssvu8bLQJ/WsfELPrdu9PDORMYQ1aCw+SrJH6uZIVw==
X-Received: by 2002:a17:902:ce04:b0:20b:9f8c:e9d3 with SMTP id d9443c01a7336-20fb9a57581mr69168945ad.55.1729853575328;
        Fri, 25 Oct 2024 03:52:55 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02ea58sm7276935ad.196.2024.10.25.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:52:54 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 25 Oct 2024 10:52:50 +0000
Subject: [PATCH v13] thermal/drivers/mediatek/auxadc_thermal: expose all
 thermal sensors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-auxadc_thermal-v13-1-a5231c52dccb@chromium.org>
X-B4-Tracking: v=1; b=H4sIAIF4G2cC/3XNTQrCMBAF4KuUrI1kkhAbV95DRNJxYgLWSqqlU
 np30yKCf8v3hvfNwFpKkVq2LgaWqIttbM45gFoUDIM7H4nHQy6YFFKLUljubr074P4aKNXuxG1
 FSpWEZQXI8uiSyMd+Fre7nENsr026zw86gKn+a+U7B+68Mogr7ZVTGwypqeOtXjbpyCavA/kyQ
 Aj4NmQ2ZFUaFFZ7r827sSieUzC/pyi0UmS9Aec/3o/j+ABrmLH2MQEAAA==
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
index 9ee2e7283435acfcbb1a956303b6122a08affecc..85cd26bfcc111b8a2ddcf76c697ac60b69d16354 100644
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
+				dev_warn(&pdev->dev, "Can't find thermal zone for sensor %d; sensor skipped.\n", i);
+				continue;
+			}
+			dev_err(&pdev->dev,
+				"Error: Failed to register thermal zone %d, ret = %d\n",
+				i, ret);
+			return dev_err_probe(&pdev->dev, ret, "Failed to register thermal zone %d.\n", i);
+		}
 
-	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
-	if (ret)
-		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
+		ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
+		if (ret)
+			dev_warn(&pdev->dev, "Sensor %d: Error in thermal_add_hwmon_sysfs: %d\n", i, ret);
+	}
 
 	return 0;
 }

---
base-commit: b589839414be04b2b37e4bf6f84af576c99faf64
change-id: 20240809-auxadc_thermal-9be338ec8b1c

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


