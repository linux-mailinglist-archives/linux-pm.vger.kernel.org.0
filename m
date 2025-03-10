Return-Path: <linux-pm+bounces-23769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305FA597B5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 15:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB2A188F43B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C4B22D7B3;
	Mon, 10 Mar 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzSkuC0R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90D22D799;
	Mon, 10 Mar 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617327; cv=none; b=sQXwFQ6l1+k1K1Pw802cWuW7HGQg8R3YE4g6EEGZbvEZid0zlfhExgKMNi2iEELChdnOPNusOlJonOiggty5Z2M9nznypb0zJrinB5G/KW4HO/5RYGkuQJEmmeOI5qxg8/v/MtpuUxGmwbZ9fv/FtwOZ0qJZzYErkhxwgPwlLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617327; c=relaxed/simple;
	bh=Rgk1KHQBs1SxsiATAGYhTal7QoOm4Z7AqmiLmcjUZ00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlTQJkjE5ipP+VsZ9zXQUvauoF5ahbWw8HMCzOSgqsQXcfyHkqZRajurrDOIqbMftA6C+koshQexGhU99+L9iQ+0tUKW3Y9WZVH6X2lr64QCYg+D78C9WoYGgcSE/kfFO/2Vda3zGWrlQRBgaaWP6TQ04NaD1IqgJL3BXEnfPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzSkuC0R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22337bc9ac3so81816175ad.1;
        Mon, 10 Mar 2025 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741617325; x=1742222125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPurFq/fNhKB6tsK5KqiD0Uogf6Ze1eS/AV3KtY1Z/8=;
        b=IzSkuC0Rx4VKC8WqeBZ7gKoRP+giHexitGt9iRW2B2tZ0AKBG/eDd12lBTkFVNjXfU
         dIVnUHBJuLr0mw1U1WWqO3LWPkFI5fjyIrHG61CfwNCzgLYFwiFV/p2YRa4wNIRZ6WYY
         A5qbmzb+3elABYEw46xOROZ+5lkQG9XI9vjW5wChG76GukJao24VCnRuCQhJqMCi8lDV
         2aeO7KVS84OAXh63J36UuEwxMt+Bn+nMWr0ZxV6OGdgsDFY/CxAN+eehrMl9ctS/fNd9
         LQZgByKAeP3qOmXoR/LoEyyHupWCZ4GhH4JnF61YSqtNQ8cS+ghTJZGcdVSsGKUJog9n
         wu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617325; x=1742222125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPurFq/fNhKB6tsK5KqiD0Uogf6Ze1eS/AV3KtY1Z/8=;
        b=P7fWmoqAkQrq2tXtrfXSiaqIEcOiGn9HEAKtNBKGzuMnQwg4KhHbRGsohX1yT6Fka6
         FZ7kqiY2tkFJTg4vFP2jLaZxesggUIscFtbw4ZzS9bfhK6WPUmKpVERstANBG1Xh+x4R
         gCLoLLTTDoG7jHQqlKkzvgRoG5wVNrTc8MgL+AnGIIwoQTasN4hI5b67mwLqy7HZ0jzN
         rNwNv3FPO8296Hk6kxNXpZVl6wBFoYnZUkUirRUfE+Z+AW+SIlBnh22/SFhnApmBtrUC
         h2ViUNuk2a8ooT+e3TLcmVytJmSn9D8d20Orhu/rbFout1DWEhTBLOLzgn3AMeeiKvmu
         tAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9HmdS6bGzXnCQR6nq09SuBx3AlaindFFUfFVXLpZkYQy0OIBbd/tNgWcZPCL7nnzFeZ6h8DVHVzBnGpI=@vger.kernel.org, AJvYcCV/zz58CJCAe11eeTwYUsy0y50bBy/BhBqioCw3togSEn6uZDcRMJUSDa/bM4pk3Rc9dWUC7SWYoESBw9Yr6FWwo+M=@vger.kernel.org, AJvYcCWhZEC7kOAXX54pE94sLuqfRPX4W7PihLhI0L2bsgw3veR3Q/wEfTLTUO6eiJ7cqM5JUe9nAVJ0zmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCr6QiLBWCc1RxF7c2wrKDe7NXepiqvS7BUPra6YDaPskiSSO
	SgVDydUoR4OAODjL+OjpKHf9B6GYo6bPoKn7tM9nmdZ9zpNcdG2t
X-Gm-Gg: ASbGnctVALVBe66l6ajkC9ypqLtvJRsJ+kPnoFD56opYYi/kxaXhRldT9y8FTEhUblg
	10qaFNVPdus5nYFrTce5em2ODrPxE2DhdK2pyWrQvtnEKcz/3Nu83fKNflcBidAQtaeyhJs71lk
	ZOnMX4gOitHtmFU/cAr92VETWeOmoogZgZisyYzWywZDCjNLyNfIEIBGgXmDGVMG9G1Pb69x2cd
	HVyVaukXFdVobsco1KUZPWueyo8VB2S6HhaMX7sI/BDlrcH48dLYpRaKipc+J/gFnGgEBvn62hE
	2zbF1i4DcMhNRgXi5GHmXtNkUVWtTEcaM8Hgjt31++uBPbnXu0DZMYqIxjky4If1aslHAg==
X-Google-Smtp-Source: AGHT+IFlxn30vbYNMpCGqOkZQC/33f6L8EuwlU4MuG+cJmyHdrmp3tS4C+2fi8L46Nfo+WlDit4hVA==
X-Received: by 2002:a05:6a21:618f:b0:1f5:6b36:f574 with SMTP id adf61e73a8af0-1f58cbdd3e9mr5565637.38.1741617324889;
        Mon, 10 Mar 2025 07:35:24 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281096763sm7785900a12.30.2025.03.10.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:35:24 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v4 4/4] drivers/thermal/exymos: Use guard notation when acquiring mutex
Date: Mon, 10 Mar 2025 20:04:45 +0530
Message-ID: <20250310143450.8276-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310143450.8276-1-linux.amoon@gmail.com>
References: <20250310143450.8276-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using guard notation makes the code more compact and error handling
more robust by ensuring that mutexes are released in all code paths
when control leaves critical section.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: used DEFINE_GUARD macro to guard exynos_tmu_data structure.
    However, incorporating guard(exynos_tmu_data)(data); results
    in a recursive deadlock with the mutex during initialization, as this
    data structure is common to all the code configurations of Exynos TMU
v3: New patch
---
 drivers/thermal/samsung/exynos_tmu.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a71cde0a4b17e..85f88c5e0f11c 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/cleanup.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -199,6 +200,9 @@ struct exynos_tmu_data {
 	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
 };
 
+DEFINE_GUARD(exynos_tmu_data, struct exynos_tmu_data *,
+	     mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
+
 /*
  * TMU treats temperature as a mapped temperature code.
  * The temperature is converted differently depending on the calibration type.
@@ -256,7 +260,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	unsigned int status;
 	int ret = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 	clk_enable(data->clk_sec);
 
@@ -270,7 +274,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	clk_disable(data->clk_sec);
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -292,13 +295,12 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
 		return ret;
 	}
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 
 	data->tmu_set_crit_temp(data, temp / MCELSIUS);
 
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 
 	return 0;
 }
@@ -325,12 +327,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 	data->tmu_control(pdev, on);
 	data->enabled = on;
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 }
 
 static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
@@ -645,7 +646,7 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 		 */
 		return -EAGAIN;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 
 	value = data->tmu_read(data);
@@ -655,7 +656,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 		*temp = code_to_temp(data, value) * MCELSIUS;
 
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -720,11 +720,10 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
 	if (temp && temp < MCELSIUS)
 		goto out;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 	data->tmu_set_emulation(data, temp);
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 	return 0;
 out:
 	return ret;
@@ -760,14 +759,13 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 
 	/* TODO: take action based on particular interrupt */
 	data->tmu_clear_irqs(data);
 
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 
 	return IRQ_HANDLED;
 }
@@ -987,7 +985,7 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 
 	if (low > INT_MIN)
@@ -1000,7 +998,6 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
 		data->tmu_disable_high(data);
 
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 
 	return 0;
 }
-- 
2.48.1


