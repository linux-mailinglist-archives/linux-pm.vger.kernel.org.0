Return-Path: <linux-pm+bounces-36287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A19BE46A6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 688E4508317
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8461F36CDEE;
	Thu, 16 Oct 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcyYNosJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C47369965
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630336; cv=none; b=Ji1XhqapgvlYbJENQAQ7KBm86pPQY+6K8pUk5lsleHdg7qR3rsQ8kLqlGiClIy4V/oVtFDerDgsm5KqqUssHwMG91VghLfuy6/DElUO1XTdJbOC1FCOGJr+ECw2eEdecPEW1VCZEqtKgp6u/f/fYEZ/jn+GGv//4mC1troZdeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630336; c=relaxed/simple;
	bh=Fd87VBZVE3t1XdL1M5TOtbrUL4Nhx964dcSf7oJuDP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XtqS2D/Ie30zcDhb0vv6AGKmAPIJ3ljXGVlKTE3ysNIujDKuA+Xtl7W7Ju3tsVcRcDe6idrXPeV+Ubf8RAkl1WXV4D3mM2luQbBWRkAbZY1SDVyVR8H49eF+0p/Tf2dDmuYnEHZEJxSaI9jEKAsECO/GuIBTyowceq03ak7vfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QcyYNosJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso1673974a12.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630331; x=1761235131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AiSVlBoay/rNWhpOjfQNUl48vUimN757HYzsRqcO8g=;
        b=QcyYNosJ2XqJqTociiw/mwfLg3izOLLGeYVG5xfxTFZsjIrc7oItjvyEjW2bz9SCLT
         vvCeXLm30mz3F2qeJCQKfX9Yldbh/7Z0s6R8zFYSuDiJ6UYOerReojxBMomzwOsEZQss
         xgXmscTsca9BihgTFoEFXWBkIhhp+bmf1/G4DTGw9YyNLn5sV3P4v7oQ8Q/so+FoVmpo
         j1lJHQDh4XP0QYYd+Ye9oNUSNBMe/7liAnv/NavKuVdUuIUynaH9RTgNZ0ENSmWs4eFv
         ThtT3j80SMqFOyAoGKjKSZDTdcdX+shXwjh8mRgQ5nxWORBwH5qepcprVDqO8LEFB1n4
         3wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630331; x=1761235131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AiSVlBoay/rNWhpOjfQNUl48vUimN757HYzsRqcO8g=;
        b=VNyx4ik/cDA2ZRE/A5P1RX2T+/2IF1NbNHYL3MS98TqHySFO1JFOCAGcgZupLKUofH
         SJIWYzh81+5RavdT6oWMsWSsF3+ycdMqL0IkhiSM1btA5d5D8GbJ9nEt21eXEnFmjsNe
         ZFlTtI8k8FTsJ7m+56SwsSlwybAKuvwuu7M2i4lmpIqQi87XZe3bQrZu0s1HGu2eC9Xm
         1KjIigXypU7JNd+tAcUG/EdA7DBPwws2IOWA+wjRtE98KxgdBgN3NaCcNJ16k9Jjx7m5
         EXialURJFXmyWMabj7Bkgb2gOeXm9Kqv0jiVniGxogEilchI7kb7Dodz7VGGqgwsQ4cb
         nDJg==
X-Forwarded-Encrypted: i=1; AJvYcCWR8qZMVBx3qH2jTxZELbL1fB5aUpuU9oHKh4bYYVGUviKb6RlbdRjM/TUWlXwfLNz4WSEr4q+b7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BXoiOne1kq7dhoE1v86sawjbp+SOvExrzPrq8M9tgnKRnaMi
	SuGNCXZdNkUoHB0CWxEAHD/+bspm4gkiitrx002s1Sk4X8iM28p9AUty5DRN6GOAvGg=
X-Gm-Gg: ASbGncsT2zIwTtkUdN2nQirI54Uyne8B6xlodI3e9M9gQ6NEy4ZotUH59vb19TIdWVV
	otlChCVX/7Ad0YHsXPxfFtuFcPV/YwNrP9UVfV3alCd5gzqIGYC285LT/fce/Pp56Ahf1YR+INS
	NsextxtL05S+yTaaRTC6jz7CSfBw5IiJQgzoFhpNzpb4wJ2VJT5mBKyzed0qS2ejynMpgR9RIk6
	N6YqtH/dVR2d1Xe9TUC6uL6tgmiZhsE0jzIUoYnKwoJ10f9qNcM3sZ3Xe1hsXRB0iEUbcQbO1HP
	jatfwE1tajEAydPOjDhqyz3MjnQ/5/yH+C9YmUwQcfzi7Z9cKSo6A4AcDKsGfEMBLDdAwP3C8wj
	2cUNK8wzdYAVApFSQVERrIK3DWRC06YQVvCmXkBSCS9Pfbg8Y0iMA1ksK4FlaF9MzhdsijJGfzL
	WmYI/Cj80zWELeQHeF8KdA8nWrHtIRVOyCimB8uxP5T/QD6YqKkbRHZaktwVv/
X-Google-Smtp-Source: AGHT+IGPO+2Zewf0zB4l3rydvFCKk2iYa8qO/BfCMfzqYngcvlnWd8aJbjMUPzhsP0bqvo/AOWVLUg==
X-Received: by 2002:a17:907:728d:b0:b3f:f6d:1daa with SMTP id a640c23a62f3a-b647443cf06mr45875966b.37.1760630330042;
        Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:49 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:40 +0100
Subject: [PATCH v3 07/10] pmdomain: samsung: don't hardcode offset for
 registers to 0 and 4
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-7-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On platforms such as Google gs101, direct mmio register access to the
PMU registers doesn't necessarily work and access must happen via a
(syscon) regmap created by the PMU driver instead.

When such a regmap is used it will cover the complete PMU memory region
rather than individual power domains. This means the register offsets
for the configuration and status registers will have to take the power
domain offsets into account, rather than unconditionally hardcoding 0
and 4 respectively.

Update the code to allow that.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 431548ad9a7e40c0a77ac6672081b600c90ddd4e..638d286b57f716140b2401092415644a6805870e 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -29,6 +29,8 @@ struct exynos_pm_domain {
 	struct regmap *regmap;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
+	u32 configuration_reg;
+	u32 status_reg;
 };
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
@@ -41,11 +43,11 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	err = regmap_write(pd->regmap, 0, pwr);
+	err = regmap_write(pd->regmap, pd->configuration_reg, pwr);
 	if (err)
 		return err;
 
-	err = regmap_read_poll_timeout(pd->regmap, 0x4, val,
+	err = regmap_read_poll_timeout(pd->regmap, pd->status_reg, val,
 				       (val & pd->local_pwr_cfg) == pwr,
 				       100, 1 * USEC_PER_MSEC);
 	if (err)
@@ -146,8 +148,10 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
+	pd->configuration_reg += 0;
+	pd->status_reg += 4;
 
-	ret = regmap_read(pd->regmap, 0x4, &val);
+	ret = regmap_read(pd->regmap, pd->status_reg, &val);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to read status");
 

-- 
2.51.0.788.g6d19910ace-goog


