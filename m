Return-Path: <linux-pm+bounces-7483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974D8BB000
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 17:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105691F2329D
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F181553A6;
	Fri,  3 May 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GzCEau9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04415534D
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750524; cv=none; b=FuUfvyqcpYpH0sQoqsQQ9sQT+bhsBCYB0c3pWlHUXc97EydXwkMsODYV06tiDVcU8NB7HdQ487yte1jplWs1x+0lMVljI3n3+1byOuSrJlDue9OUyQK70BytdBZcsXh9XW6J3MxjAqW7CAJUexK1nhc5vPYYCJzpdryIMD/ERgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750524; c=relaxed/simple;
	bh=b1HL/jZPMQHwvdCggBwYWudLG2vrv1+NFKL1uOCOUv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sY+biq3UUSJclbegJiNRNo6+CMyA6EVJzAqrrm+bidjx9Y5fbpssKa1dTI5y7NQ6vpvVgg1rQ/HrdcxJVBEx4R6Q2XAdn7HFZfCUd1U1CxcpEI0/GV0lFlJJq9McGvV9YpbhNQP0Pamt9QfheyO9O7cyilAOllLHFf3HUHSR7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GzCEau9T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so71390395e9.1
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2024 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714750522; x=1715355322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ii2L9a7LgGm5B2lSyJXyTDrVlYtG8HCf76CxmpWEszg=;
        b=GzCEau9TwPYZIwusilKf+Xq+9JY2ar5GgObYOqhAY/FNx/OvlmASrn5nxxJVd7Wh2c
         HLm/JK+bLYxt5DwSbGKW00hBHadv1Q03KfIjyEu2Zcyq7sS2Tueh5V9E9qibEB2wEied
         21F6vkHnAEazOyGMv6lT/oosGY+11BAxZfdhutSlMTbLX0EfMACRB7bfo+XUXhWhIdUo
         JSneGPv/0qx/356mzQZ+lzkt332k7QFxFV/6C2whYCuFd5Qa6Jb49EMFb1AgIiHJFkPv
         YORjoacQLoXsEmxDOZ8HvqNvmLYXSEMWkTSE4EwHhtpFLO/1Ro3Q9WrWHsQdKCGmeHYV
         uXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750522; x=1715355322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii2L9a7LgGm5B2lSyJXyTDrVlYtG8HCf76CxmpWEszg=;
        b=Ffwvyk8WRwo6PxLaYJ9Zkt61bxCY99oUCkE8nCdrnz5nL400JynR2JxDgst+DDtfwK
         N9Miszb212zRBTheFRos4Ft/7yWJOQXN/ejAQAvJ62A97ogW5LSSI+MJB5ltIBvCZjrZ
         /nW+1E0vS77tXLSfp7wBfs9QEHmqj5ZCAqKCm2Hq2lY9/ujeOujRnkrchbrJZwAiSrxY
         /B4pAdN+woABZAm2DAGK/k2f+ofNpoQkVHYGuy1mVCYMVGDmQTg1Cjk31g89i5iglmN0
         kdV5taBkTAr1SL4IRPdjmhMSVg70cKg79OV5Sw/IrBuoUHRCLLi+Aao1IoPKrKvYvV1J
         aHHQ==
X-Gm-Message-State: AOJu0Yxe1FRnctwdsD28cla5lhdosHbECglUT4oTdjJmNc29s71kzaCf
	JaYOAYzENZNFOYVCP1O2sbMG5/9hxpp997gOJkcxWG/R7uYlKQMJjsmega5NM/A=
X-Google-Smtp-Source: AGHT+IFm2aMinKAIGlz3LTlYrkDzfhhW4AooIKgnWvrQaOqMrThwAfJaBbSv81s4fUC5wecGUrxU0w==
X-Received: by 2002:a05:600c:35d2:b0:41b:82ba:7997 with SMTP id r18-20020a05600c35d200b0041b82ba7997mr2371381wmq.3.1714750521731;
        Fri, 03 May 2024 08:35:21 -0700 (PDT)
Received: from [127.0.1.1] ([79.87.205.120])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00418e4cc9de7sm9702373wms.7.2024.05.03.08.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:35:21 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 03 May 2024 17:35:14 +0200
Subject: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Fix wrong
 lvts_ctrl index
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714750518; l=3124;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=b1HL/jZPMQHwvdCggBwYWudLG2vrv1+NFKL1uOCOUv0=;
 b=A72Gw9WaUfJAIEbb5OzwO7zSEFc7tittIF0gO7OlcYnX0Sb6YIs8fYiU2z6GTT4ehRCuZ4n7z
 ENc0i8f2dlNCwBbG3HHLq21ntVhchbfbc9kuWKwJ80892zxwGXzagrT
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

In 'lvts_should_update_thresh()' and 'lvts_ctrl_start()' functions,
the parameter passed to 'lvts_for_each_valid_sensor()' macro is always
'lvts_ctrl->lvts_data->lvts_ctrl'. In other words, the array index 0
is systematically passed as 'struct lvts_ctrl_data' type item, even
when another item should be consumed instead.

Hence, the 'valid_sensor_mask' value which is selected can be wrong
because unrelated to the 'struct lvts_ctrl_data' type item that should
be used. Hence, some thermal zone can be registered for a sensor 'i'
that does not actually exist. Because of the invalid address used
as 'lvts_sensor[i].msr', this situation ends up with a crash in
'lvts_get_temp()' function, where this 'msr' pointer is passed to
'readl_poll_timeout()' function. The following message is output:
"Unable to handle kernel NULL pointer dereference at virtual
address <msr>", with <msr> = 0.

This patch fixes the issue.

Fixes: 11e6f4c31447 ("thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor slots")
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 18a796386cd0..d7df6f09938b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -116,9 +116,9 @@ struct lvts_ctrl_data {
 			      ((s2) ? BIT(2) : 0) | \
 			      ((s3) ? BIT(3) : 0))
 
-#define lvts_for_each_valid_sensor(i, lvts_ctrl_data) \
+#define lvts_for_each_valid_sensor(i, lvts_ctrl) \
 	for ((i) = 0; (i) < LVTS_SENSOR_MAX; (i)++) \
-		if (!((lvts_ctrl_data)->valid_sensor_mask & BIT(i))) \
+		if (!((lvts_ctrl)->valid_sensor_mask & BIT(i))) \
 			continue; \
 		else
 
@@ -145,6 +145,7 @@ struct lvts_ctrl {
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
 	u32 hw_tshut_raw_temp;
+	u8 valid_sensor_mask;
 	int mode;
 	void __iomem *base;
 	int low_thresh;
@@ -356,7 +357,7 @@ static bool lvts_should_update_thresh(struct lvts_ctrl *lvts_ctrl, int high)
 	if (high > lvts_ctrl->high_thresh)
 		return true;
 
-	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl)
+	lvts_for_each_valid_sensor(i, lvts_ctrl)
 		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
 		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
 			return false;
@@ -617,6 +618,8 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 		lvts_sensor[i].high_thresh = INT_MIN;
 	};
 
+	lvts_ctrl->valid_sensor_mask = lvts_ctrl_data->valid_sensor_mask;
+
 	return 0;
 }
 
@@ -1112,7 +1115,7 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	u32 *sensor_bitmap = lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE ?
 			     sensor_imm_bitmap : sensor_filt_bitmap;
 
-	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl) {
 
 		int dt_id = lvts_sensors[i].dt_id;
 

-- 
2.37.3


