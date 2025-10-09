Return-Path: <linux-pm+bounces-35855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3ACBC9C8D
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830123A46D8
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB192ECE96;
	Thu,  9 Oct 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Af1yyeZA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0F204096
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023517; cv=none; b=eol6vd91/n2v811C3m/Z9fK5CgAs/vObAskwGJgIy0aTov7sGRaXdbOVpcSl9o7yrmccjKNqAbb2QDygOA7HdBM2Gmi3stvqo6zmZOFWdGOj0Eg8oRWDwXzVpi8iBCLulX1joLX2xf1atXn2twkcdYjv2zzIJ6h5OEVVs6Gd2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023517; c=relaxed/simple;
	bh=QW41kS606/q0M1jPNHEOuZDX62lb/ReQ5t7lhOrXCD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJSt2vzvQMPvas5eXx5xi+C3sFfe9PTEBLjnM1jzeicAnNdd6nDklEyVoANhEMRE9lMLE0jOpWNRAA070B77k+pgYdb/GuouLTw5PLCf1o+MCl9d+4zEANGNpAuQdBuvUzbSSx46ezlE3Unr5Ii3J/cwdryA7ncQEsyt7qJfu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Af1yyeZA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae31caso183223666b.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023511; x=1760628311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MC3uJwytBymNcNNUBl3ACIVe5vrNsKsuMCXz3oqIuhI=;
        b=Af1yyeZAOAqEbOeGgYTym0mDHmPAwMGaoPz1O7eyYQz+Th0zjj+ivDHa0RsntCB4tL
         wEFlq6qBrVa+eld8SXbwd/ccrNfz9gJt9fPyzShxT9XgMfXKjQkE7lnqvpbX4I8aaNUQ
         uJeeP/2qDVl2yBHK359MBgqYBescyCVvLFXaL/FWBSYFmVs1smoyfBzcX3Z56QLc5gcM
         RPlyf+1ZFuEChLJ1shNdr3K8sL8ZvTNiS3Tk90dN4bDLoyNvO4flR9o64PPBMfUXGbYa
         dVbaFiejbNnYeErTt7svvejGNY983fv0l/z5i1D2YNvJnxZYkcUYUgtRM+Hh/I+0SGtA
         HqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023511; x=1760628311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MC3uJwytBymNcNNUBl3ACIVe5vrNsKsuMCXz3oqIuhI=;
        b=SRRGcS13zCCByVs1bXthoeTYE+FO1DLTicbC2qBDmAjLxM5DBVygLpLr72LM+JsmwJ
         cluyPtkh0eabUGOQhfV7V758OiSF+QLhhvmva3QFlCzWII4S1kgOkD9QUZcLep2zMkOY
         hw4cmfsxjad7Fcs2RMbs6mXYsUdUFh+LE7Rp93+4Lx4bHQzhnO5t9vVh/maf1S9oB2D3
         tpPGjpZOnDa4nzJVT4IBakjjGGVq/AL0WBwLVB3Pi2J8TVg7/pkZeI98Gmhqku423sbC
         R7zoIIC4r24NgJz7Wf8OPqYHvuX3DBD72SePP9HcdqdPwN2ZsaGKbTfCHGNBRXYEmF7S
         b2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUKAe1d4fykqyWO9IhFI8H4zzqJML16W2goFmvNHEX0U2FlOuSWFvk/9Zo3MGNkL/P1eU5nmEMeTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFaXcu2JG2hLsHTlV/yxhA4vPiq2UhPDrRffENNlqgjRJRQ8V
	54W+IdH7cx6/kSVzfTaozE7bhniPQmZEFymZqb864Cn0nELYcAGbh4uCgRR5K7kjJHw=
X-Gm-Gg: ASbGnctom3V6JrBHzzPcAMtcdyxNpHZgxJMb3TIBU9xkxtPPFiLDotOF6fngsxyJo8f
	jFHVag8xT82PtAN2mSOkNgbKEnTm5eaSjqwMMvo9hwcUHipq2TF8EykIWv0p72tu2/2sSQmk49N
	SqzxH3Mx75V/5im7CfQ02ZDTSeYjUU6pQ4PAFgL0VqU0EoqVOgRc1hYzZlmJH9/A/kiz7sXJ9u7
	AhEg5gPx/9xamckRZDyqyLh6M1cvIyqS1KUSba1F4nT3+3ByKoMw5lzzu0Ds1uAMvfK1APridxf
	c8RFAe5vJw6RKnxiG4pc9dBDEG2SUWk+cgNjN1k+7YOm5SkuNj5xJzx3sSRLJb6mPzLK43wVkRw
	UzdH8ka+wupyomVASyZAQ4YDmGrxxLuAEdLoGAkA+U/spGckqbwF45Ue55mchA70OWWWMULvrRw
	lZVdM5N9ZQ6apPcGWlphwWecRI0SnPzWWfLuu7DAXa
X-Google-Smtp-Source: AGHT+IGUCw5TbDsbNDU12n89wz1xnvXjoWKEOoQfEfCs7xti4zjASJ6sSLgSUPyBLFyQO2HMcf/P7g==
X-Received: by 2002:a17:907:6e8a:b0:b3d:5088:213d with SMTP id a640c23a62f3a-b50abfd4902mr890576066b.42.1760023511315;
        Thu, 09 Oct 2025 08:25:11 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:10 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:12 +0100
Subject: [PATCH v2 10/10] pmdomain: samsung: use dev_err() instead of
 pr_err()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-10-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

dev_err() gives us more consistent error messages, which include the
device. Switch to using dev_err().

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index a7e55624728a62545eac049c9a51012a229f44c2..387ee1c91caeae4519237af2ec659f56782e7bd7 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -29,6 +29,7 @@ struct exynos_pm_domain_config {
  */
 struct exynos_pm_domain {
 	struct regmap *regmap;
+	struct device *dev;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 	u32 configuration_reg;
@@ -53,8 +54,9 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 				       (val & pd->local_pwr_cfg) == pwr,
 				       100, 1 * USEC_PER_MSEC);
 	if (err)
-		pr_err("Power domain %s %sable failed: %d (%#.2x)\n",
-		       domain->name, power_on ? "en" : "dis", err, val);
+		dev_err(pd->dev,
+			"Power domain %s %sable failed: %d (%#.2x)\n",
+			domain->name, power_on ? "en" : "dis", err, val);
 
 	return err;
 }
@@ -123,6 +125,8 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
+	pd->dev = dev;
+
 	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;

-- 
2.51.0.710.ga91ca5db03-goog


