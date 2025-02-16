Return-Path: <linux-pm+bounces-22175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1BA37759
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 21:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF27A34DE
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3F1A3177;
	Sun, 16 Feb 2025 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF1VzXQJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60901A316C;
	Sun, 16 Feb 2025 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735978; cv=none; b=u52piIa9XyFKvMoYnkA9SaxANtIThkFeqtxxP12xBep1X/RzJ3+gZ1NmtpsttVNF+I2tVQLn+VRY9DXtBLP61cls8fF/4/5N1t22JJZpZM5G0EBnKrTyOy2QSepZD6YbXPRYkuqMfkEthostDRJ0q7TDednskqGMo/XoLaJ7Kts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735978; c=relaxed/simple;
	bh=rFYxO4KAK6OwMLCt9qwk8e3vWgD+XTOr5kF7g0ZxShA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLT4VVsxgOZBldMSsW/rIWHVosleVGPC/P5d52wMLEtJrTH56pUAPmzgJtccnP8M0kDmYrR7NkN5lMzaeU/gx1G1kOrvAsvAan16WEATNG0FBWPBQQ7WJMjiyRWNOeBF+mqbLqLGYKddZ7LMmY5P9B+R/IO7WSASEzYSrQH6jKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF1VzXQJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so6958095a91.1;
        Sun, 16 Feb 2025 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739735976; x=1740340776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHP5M3yeaCi7IF7vXp1agOw6DIq9vLMPFGh0uk4OOmc=;
        b=dF1VzXQJ/5wWW2/r+0zvhnm2N3NnaKAg3MtLKms0SP9T0n2u9qp37Fjnfjrc5edyee
         xl13KqLyqylPDHLCf5OrA1Xyq6BTYLeOe4sIrW4aQ6ikw0gjuDz4tc/f2/BNvD2v24rP
         GKZJLIHDaCuCqXOrZ5nywK0PssGD3kt88E4O598RQwe040KmSnXu23w2mSK2x6OBulKn
         lvq37bvqGlWyHZURNv+NfZBQ4LOGjpSxkAqfdPv+23AZVJw2B6EHH29D+u2PpmgCPIEv
         HxvWYibA2GcQw25Ln9IMR1VQF1dMO7p0Qo1EWaSlCzufS12Miw2OP1DSMVvplOo1ZhYm
         3REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739735976; x=1740340776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHP5M3yeaCi7IF7vXp1agOw6DIq9vLMPFGh0uk4OOmc=;
        b=UVsUVkEHVG9EUwAOIab23GRzVsSIG/DghjMLahJdIvZIcTO6R6lYLiDzFlZiy1Dg0G
         Sk9C3cK0ASlYEke0eWCdEkGT856SLQulQLaikPCpNDptcwl+MDS8tVYZeDo8PNCoEqgy
         b6KlxmEivS6xrz+Wi/SC2V08/FAPyVZRb4fbEymtzyseYL8agiH1SQDCywHdsPddqD4O
         sfvX6OvGv033MTy1EiJbUAEDK5tuLGGfGf8vxFGIgvwzR7sAcJ1LKP6dXigjGrOCNPZ8
         xuVqou5vkEVFWuTk3EF0p/MLJq97u5uPUip7n8CnYgjokXURN/WglQZGDH71vhEpGXGv
         XFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl6mxlRg9yVAemGlRfRbVK/aZqe1LqX+kOQ6NbSiFhIcunZ6ukYu4Oyl+OJFCQgRnaOROdZmhA81tVpIO5gT5Xcjw=@vger.kernel.org, AJvYcCWzNcsTiYYSIy+rCaZMS00I4lv6EhyYU4rLiRNCnclhlZQgtopGS6MiYIwBpwJWfPDOKEmmF1p+GSM=@vger.kernel.org, AJvYcCXYFaXS7smMtPQuTqbqPnUBHBGPLSHVLgbo8KJT4wZsQWbHl99qGijo7KhjcTYlUEHAx9bYF29b2pVWH3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8z2l6hzFMHHh8tufyRiF7AMTiUKFvw3+U5Pq6PmaR9qya5mhA
	Shji/0m/QnOtjIqynGc8rkQN7zc2SYd+6mM1xBqPNswg2f3Zn6In
X-Gm-Gg: ASbGncv3or75baG8rqh8wkiqsCcVlL/GhSGrewdYBwgbfOMVqMN6FXphI+ybqYBu5ZW
	rYfpxFFhVSVzL7xLpPxhym48LR8i8octUIUSMzG5t6LsJqhX2g9vZiVeJbsdtkC7bBeQxIr3KUA
	VAEG3SOYMUXuyJl6BgH/iU/5I05jqwBWQ2NjiJp2lpln/6cXgFtQlF8cNLW582QnKniQWVNeHnV
	Ob1OkMEq8TJlPRduuejXPbKhBdtEKJNr/xgHeD9RjtqyasiNvC9EEgP1KJGDJrybD0JPaRPj7NO
	pTjpj7MYvqxZA/oldi3hDLm8AwD9fw==
X-Google-Smtp-Source: AGHT+IHBlw/ULOY6wy1JfyENVCkx1GmwQZMDVZZdLPpzLlvKhW8EBtZbG/71OUMbBtVJDDU3RGHmAA==
X-Received: by 2002:a05:6a00:2d0b:b0:72a:9ddf:55ab with SMTP id d2e1a72fcca58-732617b5545mr9505891b3a.10.1739735975841;
        Sun, 16 Feb 2025 11:59:35 -0800 (PST)
Received: from localhost.localdomain ([110.44.101.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265098570sm3023559b3a.22.2025.02.16.11.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 11:59:35 -0800 (PST)
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
Subject: [PATCH v3 4/4] drivers/thermal/exymos: Use guard notation when acquiring mutex
Date: Mon, 17 Feb 2025 01:28:37 +0530
Message-ID: <20250216195850.5352-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216195850.5352-1-linux.amoon@gmail.com>
References: <20250216195850.5352-1-linux.amoon@gmail.com>
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
v3: new patch
---
 drivers/thermal/samsung/exynos_tmu.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index fe090c1a93ab..a34ba3858d64 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -256,7 +256,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	unsigned int status;
 	int ret = 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 	clk_enable(data->clk_sec);
 
@@ -270,7 +270,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	clk_disable(data->clk_sec);
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -292,13 +291,12 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
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
@@ -325,12 +323,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
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
@@ -645,7 +642,7 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 		 */
 		return -EAGAIN;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 
 	value = data->tmu_read(data);
@@ -655,7 +652,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 		*temp = code_to_temp(data, value) * MCELSIUS;
 
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -720,11 +716,10 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
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
@@ -760,14 +755,13 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 
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
@@ -987,7 +981,7 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	clk_enable(data->clk);
 
 	if (low > INT_MIN)
@@ -1000,7 +994,6 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
 		data->tmu_disable_high(data);
 
 	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
 
 	return 0;
 }
-- 
2.48.1


