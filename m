Return-Path: <linux-pm+bounces-37807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0B6C51AA8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900D5188387F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6283330AD12;
	Wed, 12 Nov 2025 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNPLOnAT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0D3081BE
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943358; cv=none; b=nUDQJa+e5VxueyYOA/Sn40uNiz5/QEQIL9l9OKIq7s/zQ0uoyQml4NSjl1lPSOgUTJ4G+wRX1uEDytl3cVTgG2a7QEYbNkLR1CH39FbYVagO4EJfFm3cJe2umuLjvUm4uUNyMRQcfH2/j9t6Tqrz2aB4sqpQnbtgEWwz/1VcG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943358; c=relaxed/simple;
	bh=NtaVRn5fOdSnDL05sWEjwQYKJh+onKYC0wteYH9Ybhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QuMRZiGqoN7EXaJ/XHzLZndbotAPPxqIukEjQPeOgfHywIbvnTEL30Kb9mQTUQQW1fz3vUgmUMMeCpmfFE/nFrDvHTovbnwwVn80+zhlIDLLvgbXa27lNpSwPoIekqfFptblhQsfgQpRXIpqL5mc1GrRbFr8Lm4hvsuEDSiU4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNPLOnAT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775c4197e1so174025e9.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 02:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762943353; x=1763548153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uEWFCapL3xuNBc2CPMG4t/kBRPzDDIx7Zzq9T/LZFs=;
        b=VNPLOnATZbtR6f9w8LW5AUXK1f+iEPZjtetGuCB5NC0u5PMKEt8cO4I12WdequMuCp
         nLK0BGxU/0Jz6LhUHKXUNpmEy58PWztDi3v5eCHtuhqnijSUd1Fbwz0OfeP6KpVSyBwz
         hueXCtboPLrNhUB8izlSamSAJKIGOWGueeSYHbyLmMuUKJLzUgIX0A0epCfic5ya5Ts4
         I25fMcpvbezomqD5NxCP6gPhj3BxA9tzZa31oEKpTyujOJskdcbfugBlZsXHNRWfqkaj
         n5vLh3ICMTJ//hhwfVfKNT2CsKo189EK7ztyyq5gEmR/DtIAHZPO80u32ZGeqazZh5uW
         szlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943353; x=1763548153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3uEWFCapL3xuNBc2CPMG4t/kBRPzDDIx7Zzq9T/LZFs=;
        b=IZaZy0AihDMMWuQsCJny1/AUt5k4jN4xSNj+Y8sHuUkyF8MYUZNSfPPxw13dkXVs5T
         PMaFBKFl7p7eb0tAP/+VFGZc3oMhFDbbi8l5rnckLH3uhqZjJgvrTvmiiyM7OSfGvWGs
         /AMudaZcfXYu9lKUSRIw2nq2zWbsJPale5A2PQMPWHtrCeSnmDfTzXVeHgOffhMhzymT
         Qg68Pbl8JTvExxwHTAW3X1z/j7snqMVNc5Q583h2Eqb2n6AnjQJXJykBPxCScsVDBZkn
         KREGZORvEtZD8uS3Z7xsNmC4rszZ4XGofzYyqKdK53rM0N/B3WFRdQceApUdHn0cxhWm
         JiMg==
X-Forwarded-Encrypted: i=1; AJvYcCX1vaHvc0TuWVrRPxM7DYNOMl9ABoRj530V7eYVcMIu6tJQ9qdRWpMPBvOZkYXnd5R4qGj3C+Ruww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jxq6zYf7uRfE/RmyrKIGtHuBY0j+O2pWwMp5CTJMwR3jzAyK
	MWw5hZtC0bp0iwnWp49Aj74uPDl2d6mX1p+2yOGYR9zIbxWmAsdc+H+4DXCEr1fOK8U=
X-Gm-Gg: ASbGncvRjllZ56Isxss/ZlyYT+u5wwnQ3/2pKiTG/Zc0PUArRwiAMWcDnLKgZTicwgA
	nyM1wUgzTKWimyViyVjKHhUXZlQhsGZOdP35hfTLHDOyiAh/RksuNvk3CJho2y5Gw3N+Eg0eYjk
	EMJQOc7BBBI7+W3Vmj7RnEm1gy/eC+ISgDR3KyK3KiKLaAM9Ju5IPpwzxmg35SRh5KuEENxf0nz
	mN3VIRLZQI/2AZ1UzDlw6RsWbdaYlU03/IwRBEhKU2K5gUR+9fXJlfUxmsJBLUvgSvf7N5nEKgb
	kaF2t0NcxxUvBC/z4TiUzE9TxIQwz/25jvqAOQbnp0BcDAmmcQcR2721WbBgdKpTgJC7D0H5lQu
	VcVX2izZV2fAB2PuSahcoHOYjbdFwIAUiJzeFpzlr2XM1SzNCrwHN9d7ZSfGoaQP8NIr0Q2WwY9
	bhalcp3A0U7HFPA5DA
X-Google-Smtp-Source: AGHT+IEZxhWPWikCbrAnGfoelUubQn+zumXi8NTKXDPb/rrgk5SQKq+1ZC5MQQVGOw/Dnv2a3nat5w==
X-Received: by 2002:a05:600c:4fd2:b0:477:7ae0:cd93 with SMTP id 5b1f17b1804b1-477870b44b1mr12471145e9.5.1762943352640;
        Wed, 12 Nov 2025 02:29:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm22020001f8f.45.2025.11.12.02.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:29:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 11:28:49 +0100
Subject: [PATCH v2 04/11] cpufreq: sun50i: Simplify with
 of_machine_device_match()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-b4-of-match-matchine-data-v2-4-d46b72003fd6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NtaVRn5fOdSnDL05sWEjwQYKJh+onKYC0wteYH9Ybhg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFGFn6/m9j+vXfhwgQcvMShnjjZfSHkT4opZZX
 DHqGi3TBpSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRRhZwAKCRDBN2bmhouD
 1/86D/9xLSU8geMKbGZqQqq+gpYJEvoD+GGEeh6cjW5htbTvlWOfvwgeOsv7EMHmjZb4EAEHORs
 AFvbHIO29KrO50mOR6LWzHeEtoMbjKRxpPpeFHL0WAJ0zeaGgYFQkVDLFTHb+tcJKZNzaQcfTOr
 A/gX0qt9wWyZUy483xKQSHzNencn4A5qm2KeTLjezWyjKRMqOxNcCqFmbGX38K43Am3QmMZ3AL7
 YVFre1EJbT91zoN7MCGE2vUscm7rpE/mljuHR5i/gJ7Uj7Q23emhpxMeTD7QmdYvYP7F83LsCQ3
 unLQR73BO8Pgm/+aNS4AhAvH7IWEn7REYkZFdGDYLzeC/G/Vg42R0QVo8NUdZTWL7mXelmpdG9Z
 DjmAXvVA1Ymxjfo8gNJ6YeKeB2voZyM98mtlwcgr354wN8V9DFoAwZeRx3p6bzqQhucTooTlrrD
 vuLisnyvxIeghESp180iNmZsCzRaiVM1DxQhnA40Tqs88QUKVirgWolnf+3SF0XEwMmOieEsmRk
 XbUoyC0vCzl6+Niz43jJgm1/yNSkFfgG1QJySFurCg0aI7Xrc8Jmbn46/FHPTNSkiwFP7sqbyX1
 uqHFTQ1d+BsJkhEW5yJDhqAYf8W0lvrmTtejmDepIdVQovzVNtHxSFWyrfn2LltV3ysYc0VIw33
 YpwPc5aDBmI/CNA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node and matching against it with
new of_machine_device_match() helper.

Acked-by: Chen-Yu Tsai <wens@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first OF patch.
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 744312a44279..4fffc8e83692 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -332,13 +332,6 @@ static const struct of_device_id sun50i_cpufreq_match_list[] = {
 };
 MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
 
-static const struct of_device_id *sun50i_cpufreq_match_node(void)
-{
-	struct device_node *np __free(device_node) = of_find_node_by_path("/");
-
-	return of_match_node(sun50i_cpufreq_match_list, np);
-}
-
 /*
  * Since the driver depends on nvmem drivers, which may return EPROBE_DEFER,
  * all the real activity is done in the probe, which may be defered as well.
@@ -346,11 +339,9 @@ static const struct of_device_id *sun50i_cpufreq_match_node(void)
  */
 static int __init sun50i_cpufreq_init(void)
 {
-	const struct of_device_id *match;
 	int ret;
 
-	match = sun50i_cpufreq_match_node();
-	if (!match)
+	if (!of_machine_device_match(sun50i_cpufreq_match_list))
 		return -ENODEV;
 
 	ret = platform_driver_register(&sun50i_cpufreq_driver);

-- 
2.48.1


