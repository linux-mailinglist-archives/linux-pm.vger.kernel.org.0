Return-Path: <linux-pm+bounces-37551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39089C3D2D0
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19C724E9605
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E3035770A;
	Thu,  6 Nov 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfExgVGo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929673570A7
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456105; cv=none; b=A5rqkrbRQyrvYNB5H72CjinoUHkmrK0z0IQFyAeywg61ityCRNGRVHGS4AObfGkIc9TGiHiL+JAgmjoxjtXYvl/GnxS5Cd3V02dC+Bii5Wzn+xPrqqnvc0PZI9Na99JLppUqYIbfgEzl35cHvhkaqs05dvgBiWyiFr1tCTClKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456105; c=relaxed/simple;
	bh=81jTJshG5U8dunGjPlokrsbh1X84C4sADnDFTx0hch0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFrOMX0c/1FqG3xGsJDq4IANzg6xdFBaDUeMDCWxXKKNb4LeBK7b6g71GyZbSemJ+RB51DKU5iYzE7oYOIcJGBHu7N227sLfPaGt6gUSvUjOkobkwOOxqqliQDhtPrF2T15LQD+aWjy6TlJtcIJtebYTDduvqrogld1QHPCpqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfExgVGo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7128683174so19878966b.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456102; x=1763060902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTTwfl+8zqu4m1wm1arK7XbgGiT9bQGfagDjMk+wU6o=;
        b=gfExgVGoR0CvieH+m00Kt7fq0MYscqUT44fyulx0J2fTLwmGiezKl97T6NxRDf31n5
         HFq3Oux8L5qDoyttP1BbxUdD6eiOIU4s6osY3r47xk0eEN7tW4cewFRqA26Kru6izK+I
         fbvYtJaPTLiCO1nOcbnWt279JAdSGJ//ESUsCDGItTGGKitxm8NgDWqkfUbV2m/MGvkz
         CDVNd8cvwuzvwLiOvkyAL/k+74Agvh4ZPNmv+s+JT0Hf6Le0FeGaaVIQiAk4CJqp2+mc
         vkKuUE595e4cgO/XxCUFjyb1jHauuITajvDXdOXt+d8o/EXsrfIb+QOLPffbsebYox9O
         1ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456102; x=1763060902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lTTwfl+8zqu4m1wm1arK7XbgGiT9bQGfagDjMk+wU6o=;
        b=L2MnU1Wx74Vv0jS4mZInem8d7jFnRwWqSDkgoP/+cvKvzcYXcZQRAfeKcjOUdQ+DnH
         2PpZAJwCItK67gA34w3YFr1N/6jRZRz20Ytg17BvVPl4TRTYkz0utFWwPbUFOrk7+GqQ
         ugu+0hyHLBfigPNgXpVGdBWsGlPHU33eCdxVlefMkcaoyeZWVryJczSLAKQGOsSWb5qf
         +5DwV6cu2dY5nKDxQMdgbkyn1dFZOmJqCTkCfPC04EzOtaUYiU6Wjmi/MMbJbijVFS8m
         taE2dvVkEpF90VnqFy2UPKyHxFRB/iiCduxrTTlEo8ti+hlGlzczrT/JenVgWpgjt2ed
         mTlA==
X-Forwarded-Encrypted: i=1; AJvYcCUVB3YgvJwBB/AHQW8j4g7DBpPxJkF0rUscdyRJ5hWdFIkA4ikZiyebvRbgt6yxUZbj5NpPfVMhNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvO1ersVmFhV+LxEW9Bq95sxlyj97fxFuH4CYon6TmugCMRWel
	FoJBqFlWWoUVknRzavyUX41QOvXhIIODOuEfPXrix0JV15VAxvVBBjgggcnz4UohjZQ=
X-Gm-Gg: ASbGncuEFW3/lsOWAarY8v22CISByyCIFQNN8lMqxv9s1gY0pTd2PabiSdBZGFt5tF0
	52aLdTr7pxueCGYGuap6ZI68AFUPgAdhnrbRTE8HBlbU4lf8PC8HTOrJDUpfxy985pwh15N0wbs
	3VV6rUOecO7oUiAfBl9gnuutRGVrYRvUia/Xy6tYvi+mqVAMKKKPkYSYMRSa/y7zdVw97IQ1bIf
	z+mtK7gCyvs6RbxJ1srq3+6LryTm3BGj9kpW6sy9DdicRN56BSyI5a0yg/k6+KrpYSGjJRsKV8v
	VjO4fG3FGf57VOPr1m1v1ky1W8Zj/NqSdI7fyVzuEDsSc/8EZCxyWyChphJR9NKs1AEmWogFqPv
	k0Og4m+z8f4vU/uH7xK4I1OUjpMTt5X3zWXZbo9ckWatrsrCZDqfIrgH2iUxMPtwTBNTjDUnlbF
	J3yjHIsGCbXsBXi8l+
X-Google-Smtp-Source: AGHT+IEf35hi/Mvu2pqQNB6ZUXhOFjK+2PFxyy+sVLCuTD++/QgA8I/C3DT2L72+VZdgncmFcO3C8w==
X-Received: by 2002:a17:907:60d5:b0:b6d:6d44:d255 with SMTP id a640c23a62f3a-b72c085b9ffmr22301066b.1.1762456101774;
        Thu, 06 Nov 2025 11:08:21 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:13 +0100
Subject: [PATCH 06/13] cpuidle: big_little: Simplify with
 of_machine_device_match()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-6-d780ea1780c2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=81jTJshG5U8dunGjPlokrsbh1X84C4sADnDFTx0hch0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIOPVy2nJb9/aZGGihJZJb6YzWNYbITaU/JD
 /wAIbe0weqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyDgAKCRDBN2bmhouD
 1+/5D/4twhEWhy32a6SbzdPRfB3gSy75fyN8B5lREUBuB3lg+/Q20TtmadU87drCAs82yGBNucd
 GykHkO6pu4SM+UwePyZ6VPEVv6ZgXHrJNtRFG1XlIm8Q/AygPPl4xucn/naHXrWq/XnN4qNsWF+
 iGgGwG1JycizeDM8lsEpLS1ye5J7N4pEAShKgxBG9AsQrGb8cNPu+z3DWBof+lyhu3vH5GYwFtn
 /taEpeXS1kk4gbPvr0LKInH3SS1fTM25K6LO+6Kzi3XpXKh6UecpyRHpCSRf4HXlWEF+UF0uaZw
 dY3a+MdF3zn6XyR/fHaodAF/27kNp1Aljz5kVFWIj9yTeNHgGeDhatQboZaGfFLmuHGj2jOv8H1
 jo1n3AR+1hWN95bLIMnN9g7c+SOivA1B5Vvy6VyEZvPHTxHMFxkgAXobBCeHn9UzjInGlL3A8fF
 QHbTzdUu3RYgvk9eI6qB1FRWjuUcd3KOVQIkZBXZ0nX+uq6xrDyqNtxf3EeigO5HIZwGh0pAg3b
 KDdcUP8N3WzU053nG6pPCIEb4H/hKU4OPtn+SrP9g2R+QnS9X235mO91RycPcBKIBE1kRGwMlTr
 fuLMetgh3RS7x/PKnyAnqE8rGVJZamVvtwkEbRsgJocNyDBnYes1oTn4ozkObw33ys20kFRMJzc
 q3b4Z2KUE6y+epg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node and matching against it with
new of_machine_device_match() helper.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first OF patch.
---
 drivers/cpuidle/cpuidle-big_little.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index 4abba42fcc31..08f6bf2f6409 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -166,20 +166,11 @@ static const struct of_device_id compatible_machine_match[] = {
 static int __init bl_idle_init(void)
 {
 	int ret;
-	struct device_node *root = of_find_node_by_path("/");
-	const struct of_device_id *match_id;
-
-	if (!root)
-		return -ENODEV;
 
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	match_id = of_match_node(compatible_machine_match, root);
-
-	of_node_put(root);
-
-	if (!match_id)
+	if (!of_machine_device_match(compatible_machine_match))
 		return -ENODEV;
 
 	if (!mcpm_is_available())

-- 
2.48.1


