Return-Path: <linux-pm+bounces-35744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3EBBEB23
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 18:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F251895609
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70352DECB2;
	Mon,  6 Oct 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foZG/4ac"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05522DD5EB
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769013; cv=none; b=DTLL2GN1n/iU7MR5D+9qtOrUVnYxTgFmoCmLp3mxIIFhRXezurAXY8RurdzXTKKGKTWJg5GiMjYpXdW9Kdte5SSDzwXmqOBvNjG4HE4exoRZVkiVIxqP7ItYK44LXbIi59qpix6WTgZ+W79rASiUyJsnitmXpnE4rrnwlMWBMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769013; c=relaxed/simple;
	bh=N12UH+jph8ILpPyH5wUhl5Cae7bjK4ZW+ZRkQnlfLXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiTS2kfRiKb1N7GNT5qSjpgCQvlB1gmy+4lJEBVS+XLn7UVVGMv29xlRZwxpNYZ0bRLDvMJrITNCKlfvaSqmTGEkvKo1vN9gVREzxQp0bNocoH4R9X145Fc4AwKL96hevbOjJ1NP0GxinSu53ribPHegS96FoEcIwvtG3/sq7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=foZG/4ac; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso846658366b.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769010; x=1760373810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpB7AuKalXwpl/RbLMZ5nDUUEYNNft2mby5//un8yy4=;
        b=foZG/4acFSo8tjII9p83nnmmHQ43/8rHlxdnafsnLeeug5KYhYCvCqZUCABT9iXfMu
         JHRolp8ppzrvtzR2Ud0X+srdJu9wFn5jlrC8MLiyU9DuOeD5maxI0NSMzVA048Qgmttg
         yhVnH00guNl0Mkz5J8WOLf2obxoAVZbF984zkWWChWOODaZNhlpJrptlmeeb45fRdRDb
         W9uNAolvkrBs8o8IeS1rvXQBKX1Y14rD4Bzmgk2Tr6iDtJ2++8+ypeyjAJNrbvA69lz7
         tD3rgI3CU7my2narx1ba6OIshr5+yK8CUss28jaf1pus1us7pqaculR/yjVhbwONbZIC
         PCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769010; x=1760373810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpB7AuKalXwpl/RbLMZ5nDUUEYNNft2mby5//un8yy4=;
        b=oPndAoRib9cIQn/Xdl2RoQFNO13JCW7utyh2K+tGIJgLVK1CbeRUk/2FRDbAoagJgK
         p9FRQnN8hDC3xxnzjcbdh/s+eUrhtAhupYh0kzX+61xVlNKelmWZ0UmVLt5a+xZdciBD
         GRZq2fMRSDRW0T8siQBOjDdwkGWeQHcb/AuB1iqsrfXMr/p4shpPuFelaK1DhYY1C9iM
         bUgZ/yKffTlywaPVpN/wB8IuEGjJ8Yq7RlJBU8mRyc5yvgW5ZFi5j1TdEWDxTsOHRbpD
         y0Hyw55prnO3Txtz0BMINKffzQodpfeo1mnPglxl4aVR3ysDYaM+hlUxH0DIWyJ1X028
         nnWA==
X-Forwarded-Encrypted: i=1; AJvYcCWC/U6ir5hyG8PJoBU++8oDNZYi8QWcgTvbiDpGctL+WGohfH6gYzr6zSwpPtYPRjsXnCL4TydxXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQXtJSK4iWg6JwEvk4HUk8sBADooauOHqhMosPidTLAY/06Mu
	foszpoyNz1PoA4LsnqJZ++XUSs7oVi4zdp3LjAeumA6rE9PYvZBIINOG9fIlEqBCikk=
X-Gm-Gg: ASbGncuxrL7Y1sGn7XRIg9NYSX+tBwzVrntARsvz1OG2140KbKDEwSCUeHHSTQizyMx
	20kRLgNq/T1XsjrgR3msE3S92EQLL4HQQJhFHiYWABS9CpTzJ+MAqecEjihBJcUQzM/gQohWSs9
	/8pjQn0HgxS0Wpe18/59/XAYoM2nvdgysRmMRkBmg7SflQjcwxFIoXdmHhCxAtARSh0TFJXF6A8
	RVjgv7eVsVkN/rabPvGXfx9/nc3L6Feba6sceYWOj7VmgJ4HX3ya5YexVEpKlAJzw92VJG/qzED
	1SLDQT8gG0jdqEMz1YhZub+YPeYCOLWtd3wAQ6xm5cr5wVa+kqyQVtc41r5w+r9OitF84qr+oau
	qdubfCJDcwHHmn5Gr6jsIFZhyCP4qVAltzo4qAv/m3VDXxEqAbwh2wsseyZl/r6LzzcxTlyFnlG
	brNUY4s5bFGEVGdB5xOa+9qSJi99vv7F3/MbDxSkU4fBEcVJE6HZQ=
X-Google-Smtp-Source: AGHT+IHBkJ6T+XP8HkZDYRjvyUd2ghQ/PYqM+/0Cceabo1BsPtNMlQLAkihUvoTvqsgb4eUlM6RIwA==
X-Received: by 2002:a17:907:3da0:b0:b48:44bc:44f2 with SMTP id a640c23a62f3a-b49c393a608mr1526934466b.43.1759769009794;
        Mon, 06 Oct 2025 09:43:29 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:29 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:29 +0100
Subject: [PATCH 03/10] pmdomain: samsung: use to devm_kstrdup_const() to
 simplify error handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
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

Convert to using devm_kstrdup_const() so as to simplify cleanup during
error handling.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 5d478bb37ad68afc7aed7c6ae19b5fefc94a9035..f53e1bd2479807988f969774b4b7b4c5739c1aba 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -92,13 +92,14 @@ static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{ },
 };
 
-static const char *exynos_get_domain_name(struct device_node *node)
+static const char *exynos_get_domain_name(struct device *dev,
+					  struct device_node *node)
 {
 	const char *name;
 
 	if (of_property_read_string(node, "label", &name) < 0)
 		name = kbasename(node->full_name);
-	return kstrdup_const(name, GFP_KERNEL);
+	return devm_kstrdup_const(dev, name, GFP_KERNEL);
 }
 
 static int exynos_pd_probe(struct platform_device *pdev)
@@ -115,15 +116,13 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
-	pd->pd.name = exynos_get_domain_name(np);
+	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;
 
 	pd->base = of_iomap(np, 0);
-	if (!pd->base) {
-		kfree_const(pd->pd.name);
+	if (!pd->base)
 		return -ENODEV;
-	}
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;

-- 
2.51.0.618.g983fd99d29-goog


