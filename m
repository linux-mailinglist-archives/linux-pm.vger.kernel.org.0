Return-Path: <linux-pm+bounces-37549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0CC3D288
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED25B352273
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E473559FA;
	Thu,  6 Nov 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oxPG+PMz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544A35580D
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456101; cv=none; b=BQ599OHwDRQHK8BFYxziSWDEICXkxS/uJo20i9TzKgcN4BdwS1fhpziqn/OviKw9ZHPyDqF+IXW4kA66GbFp0h3DQDhT4oog059xj5jn7IatnUev3E0t+kKOGe4pvVeXGFe7RaTWiZungxSLD+7faWskr0BYxRgnO80CBXBvmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456101; c=relaxed/simple;
	bh=VJX4q1mmI2ou2O4fS/+roMRPBdhrTr0mfp9hVrUEt3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8iW+H62Ij8N6WMVjZzika2jyQefJ8HIyLsBs81pF4h1r49YvN8xmVeWsLYSxKSXKAkLVPEThqDlua2ifgUgCR8suxHS1QkuduIqENeuN7vHCWfes6FsvVHTD+uitVeYN5EHYdd1QneuFonq73frOW+L3in7DPyejv7/uy+bPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oxPG+PMz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b72a88397f3so12741866b.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456097; x=1763060897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4JMGsObTs14isSyw/2HDk5qr9bB4dzim7Xxg/79G90=;
        b=oxPG+PMzCudnRvNQHTNgmenQfoJbuUn9LCXdHNOi4zkbhgf7Z2RZLfMfGreNy1jfIy
         37MHa9Tz8XILwak6miMhbgWTKCxyNXpp9x/VQOfv9WH+s6LPCFU65AKNwhAWrRZGtpmq
         PeIeBGS6ckK3aNnFEsXiEFntnUB+S6kP5QEt7JfvNmTFZWLn0svGxE69//RnYon47Ihd
         iV/IzU8gt9yH1tTTKaUVayeCMFY/84gH8QQBxDbY7zBSLwGWupr/VfAZEvwPamHI2KI2
         m1PDo6GCK+B1JzRqGc07LaS7THJSHgGdnau0w0h8+3fYHZ8aUoq5XLCg0xb8Jj1OClD3
         +/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456097; x=1763060897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l4JMGsObTs14isSyw/2HDk5qr9bB4dzim7Xxg/79G90=;
        b=jf3/lril6qebv2UOMTOp2bbmLV1JqCyW/fumJv9SyRkNPhm0hI1/jWUl8EyO9/j/Sf
         WY/Umyinne4pj9L7kfB14OGl35W70YywaPlFjUJc4IXPs+Q6NLSmD5sjR2nk20Q28wJJ
         fdZtzIThJ2NrkSLn6FePaiZvtpnbIeBdB57aIxtF6GUumi0RDelyPgikWyy1SEf9EWjF
         3lxllzHRv4UK7oVHvkvlY7tBjHBtrOEtubDAk4TaNRWK3ErqorlvwdF+FL06rv60JSEP
         UehSLJUV7X7EdtUA+s0cVNigOuN+IE3qoyXM5tg1do3BJaqCgaaEkmGIN+GEpYNnIlF7
         oyjg==
X-Forwarded-Encrypted: i=1; AJvYcCVWtAS40IfjOeacW4UcHNooTo0iM4kTN2pib6jnXhd6+tm7bJm5kS78CQLeC11ZbFHujTWuyy3kXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycQLtT8BK09Zm/HAxAqrz8JG0U0/+kTNSuAanMMO3urjmE9jXD
	dm5TGpLnoWZiTc1tt9gq9Ihdlt/o169gKeAJTd7uVFoUHO3691fgXEv21Uc+pIiNE8Y=
X-Gm-Gg: ASbGncuC363zVzHntJoRreUDvT8cuXrgEWuySNdp58Y+vJPX9/CJiy7S++aByCgpawj
	xclYiWRJo/ua7SQeneTYi4+8rpMCIDd8mVhfUL2tci8zJONHt9T63JULDr15q1TckxzO5rIlxF1
	Qq33x4UKtW+wRYgvrCJkgVfmMvTTFiPl72yXxcaao4W4uZf9DtRvdsy0vhRyEw1GQMLjTxNeqXz
	3MO9FIKfV7/DBAQfdznvOsIQ7lQOs7C9R1Pv6Yi+ODOR3hU7ZG3gu0UW7U9G4wl0/cM4illVDqU
	/LreY3f/MensvIt81scviGJusYEazXv3nVKR8WzaUCmKyHVtSuHxvrhZeb8rHoL6aWkw2J2X8IZ
	aPiO2F3kExLaOKBSypJPTlqSfMt0EqdpXQtIfNOGWaf8u2G9sBy6fbezh+hN5se7AHrXYQDbazx
	ogEAvyxK5ZYKAZnZRU
X-Google-Smtp-Source: AGHT+IFk+bNY3frZKV9s/ojuNfqyzPuYp51TMnp260XUevSmM92K38NtOvI6xgFcbZ7/Qd6kA8xBlA==
X-Received: by 2002:a17:907:7b8f:b0:b5f:d4db:731 with SMTP id a640c23a62f3a-b72c04ee049mr25494066b.0.1762456097132;
        Thu, 06 Nov 2025 11:08:17 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:11 +0100
Subject: [PATCH 04/13] cpufreq: sun50i: Simplify with
 of_machine_device_match()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-4-d780ea1780c2@linaro.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=VJX4q1mmI2ou2O4fS/+roMRPBdhrTr0mfp9hVrUEt3U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIMHFyxNlu4T2drLcnz2sjdbxNslTCnq8MD7
 ICJBBochkeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyDAAKCRDBN2bmhouD
 12JLD/9wxXcPWvHWK1TxOFBiNFBChyh3nSefla4W1FxvqtSjyYx7Ic6ZAWJQq0liz3u1ImNOUdW
 RKYq8vLm8PFRV/zuG8GhaamOHTAWvffbvpspD6tSO1JtKEBAbU+Y0mfF2l0okz/5XURUV/Azqoh
 IOKkU4s8fPs+1SeHX3dmJNLMD6iW7SredyCcNbRemCu2s692b7Z4Jjx8HsCIkSqsBYFEHDf3jA9
 Vt7uKrTHEExDkXxgTy6tCEIyYLknTaHZt0p//RhYPbOWa0Mkt1SUPC4TxwzZ8D4Sq1VcNmncG4t
 o6ZjpoF2Ina0n0SZ1iXnJwtgr/L51tqs3iDrxvgy9MOj/OYA3efvHNhODve5eNJYdvOwEhw82pT
 wYLVt2p7e/E+JSrkn4fzwQchUWkcVUqKs+NVqHiMMmR24G5PrP1PoWDUKivHZaqmla1XplHxF+H
 YjavMrtr0DiOkMnh7lQYhVSzQgQuGKY6qRZnLxIMh2ygHZx/MxcQkDtNOS1Xd8yowtDli1z5P5R
 SoRdK0Yb0Rnj4Ey/uypxoBDFFBeGBYfaszQAimrcw5t7lgmV6RRU19VFs47jOLkmj/o9g2Uiuf5
 XN6FX0JUwwkVHnhIr3f5NuPFaWZrkoYtGJsGbAj46rhCogv/a3exsmBhboYP4WWG/zB8RU+0ppz
 cKXKSifLH8r8STw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node and matching against it with
new of_machine_device_match() helper.

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


