Return-Path: <linux-pm+bounces-35750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A3ABBEB62
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF58A3BFC43
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0CB2DEA9B;
	Mon,  6 Oct 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYfm8Zk0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041032DECCB
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769017; cv=none; b=cLpvSeCNoARp5F6T8Mvb0kEn+NeaPqgiIbFXjFI4Db5kTbn/F3qfgHgX36RsNdzFuUTlkpPpu16yX4VVJCC8yIH9xxeH2H3+/JUutrfCtjvYwUOveSZvZWQCaxq3nbwx3mzWvISBM8O3lSIp4uxigYAHGzq+dF3PVXHy/nOsW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769017; c=relaxed/simple;
	bh=dNOLUQevSwifZ6dPtrx27CYPt5ZcaJvQ++oKkFXtwgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGoGRsoeFsKhJYwDrs4nv7ICI2t9igOMxTHJVQUNqYQn6kwwMK1idu1V7tcA4Nd3YMF1awYqJ5dqo8Ae1R7Ibqfw7cHGgAB+Sti0mQY/0u4tNzyBrWN3XFpV2gVTQOnuh/0+tG/xiRmlwbvrDFzY1Y0Zvn7WYg1l6TG7NXEmiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYfm8Zk0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso2442829a12.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769013; x=1760373813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVFnz052bxUssLjPn/irFYLe8FvTO4x2oRG7kChOyXg=;
        b=mYfm8Zk0HBfFZ6+50Vg/Q77S3tdE2BDbSixWHnwLK3nvtF9zTo4+DfA1uDtSMvsCJe
         sd4Yajywpx4dAvdETu4vxIJV7rHBoJMYbJlqJuToVCeb9uFCIRrQQVGfH1K6ylgU9SCq
         9UhwPTLVEjCV3WP46hbWa5PTQseCbn1tnFtbfoaEjQhBxY6EStx59k9zNoGXjgxf3eh7
         iS0VLUdAt1uzHc0wNP7qgG/rVZBJqIg1uBu5HmXzOHXR+4TiXTzYhvUT6BuC7i+5Wx2y
         ZUXazbEO3YbfVtfcq/jwdrvfy357294hu4aYPrLTIjlfspiVgNQ/kXKGw8ZU13rzeg8A
         1nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769013; x=1760373813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVFnz052bxUssLjPn/irFYLe8FvTO4x2oRG7kChOyXg=;
        b=EWogmQUkDVtdhNYwzQJ2vpoSsBBedTvXsmxNCcyRJf0FvV5dR8c+kjE7bnSYnjNMhX
         1BXvn6IesvZuUq06g+7IWVnoKXwu5Ta8sWwzRGypWll47aZ5A9ph8mIXXjxEkDj20+4s
         iP3mqsTFmRijgwL+sGQ0eNwGKOeOB7DXWnans+KCoNYbN3LAZl2nZH7gkHZWKz8a7teo
         Bgl80om+y5tAcan6Vq2+TTsUb7d2+/jzGxPDsjtSrlHWBk4T5Y8MSzSIQS5m/JTJR5eZ
         X83DwrVFGByL5Leo6EhM0uV7fjDM1z4Q4ckzcPjw4BRe+aBB1jvwamAzfM89SnCn3xhd
         JSGw==
X-Forwarded-Encrypted: i=1; AJvYcCXnTPSc2zWJeLadGpkqEczodjXWy2GmzBG2QNv6VSDjHdNwmz5mXSxDpWiAouENKz1RMYpk5pAuOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwihzOUWWL+h5jLw+p5cf+UnPxtOJei4RwCB0wggdJjxnT+Afky
	sRTII4/rjVgp6UHrQ0qIIZvYikKip5zim04i3BOKYsKHAVPJpjDBOyO/rZjKansaYsA=
X-Gm-Gg: ASbGnctSQamkb2qCHR6+UvWqzyoHnKbPmPb92D9exGAzMEQDjrDypfCVjhOVeNTIOK6
	ipyUTqhQJI7V7XGIXPFRcl4fEkyzrqPhZldOH/rap9AGzW6oShski76ac9TZYdrib6mxT5xpcPP
	1cWg6skM7DTU92ywxak0MmYAmfnAT4mFSbEj2pTYNFYWR9TpTvGhlQBGDb+x5X9lj8e/eQ+M59M
	Jt67cUFgmvAaaRPG/9u4N0slhMrqMKCRwV/vp42L6KQofiIgzuwp/fzmRI2gQ0NlakT7XPsiz2D
	icBFJQ/AEetdUe3IRRC75t5bQ/oF+l9Zv2fEMTdtti35r4NPF0tx9MpjBJIffPvApwyCo8RGq15
	ElBhy7gNMo/YeO29kekyRttxchS1zAFyXKEoWIPWtQPtsvpYQo6KG5t/XBuTD7PsHeRII3E3J4e
	eJpMg9Yom6SejOcf+jQvbmN8Zfh4A1Rs7peKI+xLU2Uw7d0IBUiQk=
X-Google-Smtp-Source: AGHT+IFsGub9LAc6/mBjGGGSdlVFrrBBzCQQUOCqnEH/i741mIaqZ3IINkZ5oqZ8jsa69BC1Q2QS0Q==
X-Received: by 2002:a17:907:3d9f:b0:b3e:b226:5bba with SMTP id a640c23a62f3a-b49c23431famr1629117766b.15.1759769012661;
        Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:32 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:35 +0100
Subject: [PATCH 09/10] pmdomain: samsung: use dev_err() instead of pr_err()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-9-f0cb0c01ea7b@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

dev_err() gives us more consistent error messages, which include the
device. Switch to using dev_err().

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index c1b5830b2ad3e8b272dcc8ebc364be49aa7fda7c..06e1b0eaca18205a549c8e8136ee15279eb3089d 100644
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
@@ -116,6 +118,8 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
+	pd->dev = dev;
+
 	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;

-- 
2.51.0.618.g983fd99d29-goog


