Return-Path: <linux-pm+bounces-37811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D0CC51AD8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE301884F5D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3830FC07;
	Wed, 12 Nov 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXNJleC5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068B30E830
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943365; cv=none; b=gYAI80Y28MBuRD4CszhFkjcTqs/5hyzKrf1g/KbwOvQxnR2oHNNfFZeKnJqo9mcHEVKYOJsOc0pqIEWv6s26c5MZTRzjFtKpJZDqOFVzu/U2rWBlhJpq9+Vf7jmOkLOSxSfZ/Yxb1weFzSCSIJu82HVncYjg+E8vscPPRgU78qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943365; c=relaxed/simple;
	bh=nbwVZd1B/0VhFu7wCpDEX+Xq7qXUW4QXmwaphM2p2IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dq8e5gzeMRxEaizbTc9YKbiWTplklwCk/IY0Ux8E+tO9cbehI63Os2IKGFPQpk8JMjIDtepDENXBjJXMM640x8ktj/PKB5UC+Bx8Da8mL0//FDp8/I9eAsNwgji6imztfSevaKyKa3oLvoZDHelC7wI6iRWH27ZLV9aQPX4Lzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XXNJleC5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471d83da4d1so169265e9.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 02:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762943361; x=1763548161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsvFfAvlWLWUNByqNFGDgf521DahJAyf+bE64GmioBo=;
        b=XXNJleC5qKSNtvmIEAkGOLxGDmq3jFud4he9epG4tSDPUS/BaAsJZfI0ShwvsWT3mD
         e1oLw8ucPt7CnuwflacurAAAeUKuN42fY3PxyWX99NlwcIymhFDb1Ax99lmFTRO4U7NX
         HpRarxQaBWFbjmPe9nh1W8CQSFgxzZZzMTmVgt1+moogPtFsdG8OCz/LdzFKxNL+tFwp
         CBMvk5q0qTb+NqhtPf7I2XKuGxoXVruE0FGfnbGd+7ewGokwoZs8RiG7xpPx4oo+EThX
         K1U7EK6DxF+n0n9UwupPTaV4BD6bjnObrm62Zb4c+Dvelfu6XyESHbuvV6zcnKi5g+Gt
         M30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943361; x=1763548161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CsvFfAvlWLWUNByqNFGDgf521DahJAyf+bE64GmioBo=;
        b=mHID3b9KrOaWQ1ZorNpA3elLCtUnsTah3XB0j6GoHK8HYFr63KuRfkcxvu3Gmho9vB
         cge638xblR1i/y98TFvRdjcCVmeFJXBjwebeL7adqhsCg8uJ3Fx/yRpY8TCe0yTTradV
         9bwocjb3mPQdBq1M5dbAyIRwWRtptiK2meTsleRy2x4H7VUpJaTWBRdB08zOH/DP9bwb
         XM5djObUtye+EEsq6rOnxNKJ+H2sVFIN9Z0Ji6SgBh+CJrAE3StsmYoUVjcwSfn3C1GT
         96H6tk2Za5+K610pcZHE+yYpykf2ytlomiWerTwH5BBfdgRKLoqsIezB5p5tWfPnXv07
         h76Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq4YmJ4DY/X1ybfKHgjRtWbnmUaMszwQl4xnv5kxdvyPx67XXQOEDsYzO8HjWBITNat41ZgMhnKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCyqhhNQsoMLhsondxe8XrywI2qPYhWUipZZa+Gzk2o7dpQ9d
	zuoRwvzNZtZ2hpJrojSuoIRfFz7WJdkypv7Kn9dR600X6KQA1CVBlj5nm1IjofRzKcY=
X-Gm-Gg: ASbGncuDxEJ+DTRKGZTkE8o6gvRZ7bg4+Xg/bm5Cl9XVcep/WuZh4L+/t2kXlcP1ZXj
	ojK+XhO8PmQskUZPKuHnGRUwWvF0/yPzUt7h7fyGk6+Ko5ZlBHtIzxqAb67fx+j9fsHHqUR9K8X
	Jw0QcavIuFcq0NdEuMUwcLepyi94+mksc0gvjc7deZJEmng/6M0rTBKz5xCR7/ggiufblY4Zrw3
	BtqogEZJX9XixAqbJMFeVyYlP3gQx8jG/CzfdVf1N7IPAyADVKO5DgM8Sm8hrH4otsLuvEkgdrF
	Emxw1DwIvAyGHz0mn1QpPrLtSXMa3oKb9ehE1s3CY0fkiYGbf2uTAFFqY10GomGFtLs2rgzttJd
	UpeckyG7yWfKKAz/RnUqVrQsI9pvJohmIpttqLAD498tXia1TJ2WqCShA02xt+gpHutLV0SQPB5
	cj6xkzhT//8d/1AKkVx9LbDp+AlbE=
X-Google-Smtp-Source: AGHT+IHAInGs1fY6MhYk+BOaIQN6jWgnuAcNUMCj8asWuYpXZLP7gT6bSs36V8+DqD/oHKzLuMjE9A==
X-Received: by 2002:a05:600c:458d:b0:468:7a5a:14cc with SMTP id 5b1f17b1804b1-477870a634fmr13473095e9.3.1762943360967;
        Wed, 12 Nov 2025 02:29:20 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm22020001f8f.45.2025.11.12.02.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:29:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 11:28:53 +0100
Subject: [PATCH v2 08/11] platform: surface: Simplify with
 of_machine_get_match_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251112-b4-of-match-matchine-data-v2-8-d46b72003fd6@linaro.org>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=nbwVZd1B/0VhFu7wCpDEX+Xq7qXUW4QXmwaphM2p2IQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFGFqdZoAVmnIlbNdcg1Y+7nkfxGC6i0n15Upq
 K4jKAztwCqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRRhagAKCRDBN2bmhouD
 16TrD/9AMI5SrOqJWRLQ7jKUbUsOysXBLyuiMqQn38xIXkce16vSkar8aQIikXJi255w8BCbJN5
 XpoXeQslytCRS2CvSCYzSnwLKm2jyAZ/UJ1eYLlbnFgA+bS/tLQ+ZxexHjt9zLRFy5y/asoQ9P5
 T9ql1bh7o1gtWYg/4FFEWUimNr9blWrvDirnEFXFokhYDjS3gC7o+PuR2zOwO1cDK1KeZJJNkxN
 4siZTPlGWjvimJMhb9MFFIaD1FGMjk8Oo9RuC38wtEQu+3Qnfv/pidmsMkt9EOEP0qyuk39qX97
 K0bF8PhZ0HlmSGHSqBDDnZ7h6TT47NdxsBFm6VztA4UBwafUt0laGgFVTbdjsPh9eLldIzc6gX4
 qd98n+HB0L0CRvu5lEA4fuApN250SBVNphKHTRCHH4rvm+c92d9Rviz27WVVP6aXK0lXrLRvuSQ
 a/h5NgHZvUsRgGR6F+KsWkKyMqs82BCAQMm3hAXYKGAHaMWvvL+CBlqoakEF16kOlukPZ2PeyBx
 +LBG4qy8sQRRamg1wPYLUZkGifRetG7z45hjdPYQwpEltgLy0irZZM9ct+2IGITcZjmMnULegw4
 nTMQ+fbC0RPtlIJPjVmVA3X+PhxBpo1um9dL60Lwd6bft0tS+sEppobeeBlN0d0Kr9qBJ5OTrXg
 yG81W0MnFMi2LXg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node, matching against it and getting
the match data with new of_machine_get_match_data() helper.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first OF patch.
---
 drivers/platform/surface/surface_aggregator_registry.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index a594d5fcfcfd..78ac3a8fbb73 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -491,24 +491,13 @@ static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
 static int ssam_platform_hub_probe(struct platform_device *pdev)
 {
 	const struct software_node **nodes;
-	const struct of_device_id *match;
-	struct device_node *fdt_root;
 	struct ssam_controller *ctrl;
 	struct fwnode_handle *root;
 	int status;
 
 	nodes = (const struct software_node **)acpi_device_get_match_data(&pdev->dev);
 	if (!nodes) {
-		fdt_root = of_find_node_by_path("/");
-		if (!fdt_root)
-			return -ENODEV;
-
-		match = of_match_node(ssam_platform_hub_of_match, fdt_root);
-		of_node_put(fdt_root);
-		if (!match)
-			return -ENODEV;
-
-		nodes = (const struct software_node **)match->data;
+		nodes = (const struct software_node **)of_machine_get_match_data(ssam_platform_hub_of_match);
 		if (!nodes)
 			return -ENODEV;
 	}

-- 
2.48.1


