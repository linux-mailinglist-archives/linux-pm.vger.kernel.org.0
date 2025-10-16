Return-Path: <linux-pm+bounces-36290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6721BE469A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9421A64C42
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C47393DC8;
	Thu, 16 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IytOev9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC536998F
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630337; cv=none; b=Zywr9qTv/P0EdV1i/PZ4sgHDxSR4fsoB8RCEYTVxzltuAafLAA4CBQ7W/pKIC2FlQYvF06JucncBFACLM26F3hR4qlKPWfw9kdtyuPveln66IQionzv48m0t8qkWPA6v2hAa3ohtQfoUrXSM/uWr4JvLAPbYb476fPWqnOJprp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630337; c=relaxed/simple;
	bh=ngrM+eWn9xbaRjAU/VwFL/GK16Xs8solvHiQs5E/TVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bf2MTqzBpm/HyCyzZ52Y+ZzUCY/v5rJFkLIxkfEEHqudDM/skquQNLF76hG0U8DN4On/mOQ8LhwcKYBmu7viadPs6EMfChxrCkEyEda40enXN6rerRZM4EcSPNJNdBAzrqttvd/ShBN8UvscZalgluV+PLFhXGAWiIsvAeFlk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IytOev9E; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07d4d24d09so147526366b.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630332; x=1761235132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRtuCWl6DsZm6id43RaQ+ggcTZIQA9X1wHdBvSFgFgY=;
        b=IytOev9E/QILIygCo15TlnAtXJvDl/fxruSM9RvNvnlOI8jIDle3TDO5NIAkByMiqE
         6NmYGg80GCs7+B3JHJbw44EggHlnKxkKG23u9Ic2oW16pcZBWRHcm1JXsckVC+sClPtx
         HSI1YuQJVyA9EJxd8Yd8mPQP47O6kDCDgX0zkU+6qceGCKa6CAWSLYJdTDNJcJqJu34U
         7T7p4Dai//Dx8kYQBoRKLPNbXGL4qVYCyCT+SZkFH+/jyCTbDt5A3PssNgacCRpTiLXr
         bwIX42Z0B9nly1KS50SKujx+HeKWqU/zmafuTY69FtlMLlEoA80E5qPMkM0D/Myr60+N
         t2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630332; x=1761235132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRtuCWl6DsZm6id43RaQ+ggcTZIQA9X1wHdBvSFgFgY=;
        b=DsE5HC02mCE9J8k7qEu1AtJR7f9OiSdCYZ2NVA4CAaRFu8IVwjRdcmaeiTjkPFfTU6
         PDpdsAmaqaLzcz+wICIA/JkK+Clrki6lUo60N1RxgwkyeXjRqju8fmwWHSW7hnGUglQA
         nunDoeEgJ9X+UYTnv6UlYu63WVFtJwaU7dld2gl1uAQSVZyHaTwTwbF/Q8NXxdcbqJ8A
         xq8mK+Pz+H3/vuNUydWNChM31Hg3HcpHi54Myq4N/WOg3OE3GbGSZfZEHtPkhJQ8A/sQ
         JirgEuhY2gShNwRcuaHeRDfR/B1/wwT/kOOP6yeqvalXo2ER2U17lt+XaruarUkSqSik
         1dCw==
X-Forwarded-Encrypted: i=1; AJvYcCUlQrzKN35VEhBtD30dK1NRVeNpH87zHAuft1D8Q2/kd/U31Z5ObAvMjZIxs6IiD27HzKvT1aqkvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoNtf8CjR9VTIrC2ES8RPSjxD/Rp0udAw/Oqox/G0zrOgB3y6
	yMvm8Oe+c+LdcjrvzX97WVB4JFAKZgtsbtV9AV8QZBWq4mupBll2G5y/UmFdOTR6v0g=
X-Gm-Gg: ASbGncujyaihieoEKbBxA20hLbSKc220osvZOjtupq3LaHfdEYwe21BAb+TJFlEBQ4u
	x3BRZUiE2ZOKs9sn/Ks91qshJc3kwltAMEeo53jMSWSLRytlMA1shiNyYXZqre8JN/xNhG4cbM8
	bSOdG79bkI7IQ4PGLX9iD5kIasL/KVN/KwSgzHLYXpCGySPw2x1aTQ/1qFmHLOCDkG/08A7fwIg
	b8h1kibO+B2kLdIwwDMPfu8OiZe6dxq3c473irlpwKJYlkFNBg8i93YBUIRFg/aPO+AEvTWbXIR
	T6bh3wYtnElYBb4e1L1wr1g3XQIwDZAM00rxMe30DqMxB+tWBIuaidEFr5jAhqTT/ohAmlapLa0
	UvvcKJlbAwsmz8JsYHw8JctkJqy2uMX060tz0yoEbb3LGS6hsOM2EnRo0Ejqj34VYFq7SHBfRwA
	/TJ4s1OHtHzzirGykFmfU3CMFwSJsbw1WcyifhgPQq4f6w+Crzy5xn1WkxmOsD
X-Google-Smtp-Source: AGHT+IEbUoUcanooKZDlk5mEzvgz5a6q2790fxYwvUg/eU6pRWdoDgf3AvUevu67xFJRES2YBilqRw==
X-Received: by 2002:a17:906:4899:b0:b4f:f6ff:a82f with SMTP id a640c23a62f3a-b6474b371e4mr39583466b.32.1760630332293;
        Thu, 16 Oct 2025 08:58:52 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:43 +0100
Subject: [PATCH v3 10/10] pmdomain: samsung: use dev_err() instead of
 pr_err()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-10-7b30797396e7@linaro.org>
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
2.51.0.788.g6d19910ace-goog


