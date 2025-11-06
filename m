Return-Path: <linux-pm+bounces-37556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 610ECC3D32D
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFBE94E75CC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5564358D34;
	Thu,  6 Nov 2025 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eunwizOC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD63587C8
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456118; cv=none; b=OHUv/TmSr8Brj08KSKfbqFxjP83Y0wjsQ2BMEdoy8UyItpt2MiI06R0+FhZPFhye0O3ip8O7yMCqSEm6tOwsdCWVp7VP45Dga7aD+x3un+mD1iPBIZhUwNBdH1gHGKCwkB3PWi0yRNq0ejus4GCKPUC0a++WnX95Mexct5ozNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456118; c=relaxed/simple;
	bh=/yzRWwVIXgMTXi61dZTgBV9kK1Wc2gDXywBs5UcM6J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OP9r3xIIL3yD2twrxyyya0ovOAMPJXKWdDVGEwwaIMtLHeb8UNquoODg/4z13ICTSFK8IdxjbX+qCHLDSc37GvpIgDxCeKg+Gg84mg/h+NJIODOdxuGVBFgzqfkJHdtpbPrbeIJ+P+LCldYECwB42Qrn4BpkFABMhYYXKM/jH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eunwizOC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b70b40e0284so15708366b.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456114; x=1763060914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muHNa/g+OI3fM/6qd0mUiU8Bz7ahY8JnmPu7Z+aL7Rc=;
        b=eunwizOCr82iLTpye7Cac4rGggzmsxtu5HjVr6pxSn1KSol9PyHr29+nR5oNE3MVMd
         JoUZwNeqpRf/Dru0EkdWf9LB7NBV+6nwnWMxIVgaFACPhboTjjV3kd1akAiWKFCU/8x/
         r2V0J6nlKtlYdBjMkm+oYvu5v/zc25TBTCcMB2NOEPo9S1CPfcR/3Nc6vgBMT1VkPTQ7
         rTXkDQEQzQpo9RVmMPoYz5yUOOp4sqc4vi5cqe29veJ9v5zoYwwlXCtwXhRvmNQQBD6n
         yAqEIEQBrCCZVjokI+fd1YEoteZkwi0xzOkW5x0KAD8INJMJ1w+RsSGJxeHTA6ORlTvl
         gxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456114; x=1763060914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=muHNa/g+OI3fM/6qd0mUiU8Bz7ahY8JnmPu7Z+aL7Rc=;
        b=hsoTCnoY5MtE81zpTDsb9xBnmrpDV7YGTn7zdzOthDwHTM3OzIR7fR+KOJjW0xXvZp
         wdKm8ArvQ8HuFbbpREx4tyh3pabc5VAcbnv/hcXIEUaT/inSlALRfhhoXJw7jZs7TN01
         u5HJ4sx1bbZIUETBdn0zKzTPmNQvHDA43IdxUJkzMvuPArRVZjcLv1YeiYswh5jUiQcz
         j43Bu9gtQSZDcd5FYbz5J6pwnoYe04u84NWYFvaBOGQ5+tWmE2Ln+xXil3uUakrGDnbu
         BuykkMPcePEzJspED8GUeiKa57+9Y4gqSRz8Xps/BoHYoDGUcQuucbtduFvzF/yKwtUp
         UMAw==
X-Forwarded-Encrypted: i=1; AJvYcCWSZR1+iek72kVXK2yFAFQdS9c/JfdvSYlvJYKxmex20tX6kRgQFwZH6smnlB+cxkwKtYXFJWxDbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzITGlEfVEJ6ElxMixZTlf1PdR4PSnPo/PLsPQqBZAJLwjZU/md
	clKn5hDKuk3JYMFRsCh26ks6lEZmpmJTWtHUJH3Ud+yTWF+IXcVc4oUox9mcgrkNbZw=
X-Gm-Gg: ASbGnctWKi6hTK5qcHl9c9EVRd6XKfOS/wGdyZ13nO6ETqcS4gHAF9Dhkfxv0WMpEq8
	txiywN9JaIEp7mfUeDTK+jxWsMyYiECBoXzQ8zkbVMydbNvxBud3Gfw47EuXz5jXOsuxLfaqCXe
	Fw+KOtKJGWgGXlN7Qbs4exofnTnBELd0qcpJipLF+69zf4jTdAD2rVurfXW9FTU7fif+stLHCLg
	CjrPQ32MKlDp0NFayYVUXlNM7fsCnLf8hB8YmCXrIpLAV9O4zDOhONnoxc3PCQWFrdML+laYpnY
	nJM/9FPEvswv7Y5Vi5PKvuN4Ddsf9+8YgmH6tKPx8zEBPSXiEOrwB8Wk3KojPVfN4oFM4FyBJh5
	3dsv5giUKhX2nFmFSUoucKFNuojzZaRT9TxriDxgTmpfSQ/w5/uye/YhiCCDKkgRstkDFAXUE8u
	BcIcnipWPbKp68ExC2
X-Google-Smtp-Source: AGHT+IE8YuEiK+Zfb/KePNrKoWBUDj6LEo4NOy/SwvD7jjkTn21cZNP/+8sVmFG2eqOfE4KV5Ochsw==
X-Received: by 2002:a17:907:9614:b0:b72:5375:12a1 with SMTP id a640c23a62f3a-b72c096b055mr19793166b.2.1762456113840;
        Thu, 06 Nov 2025 11:08:33 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:18 +0100
Subject: [PATCH 11/13] soc: qcom: Simplify with of_machine_get_match_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-11-d780ea1780c2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/yzRWwVIXgMTXi61dZTgBV9kK1Wc2gDXywBs5UcM6J8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPISQ5D0Sf9n1OrwLQgvE3GYjGuU2ct+njIDv
 jBQi2g+WJyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyEgAKCRDBN2bmhouD
 10suD/0Sda8mQq3Am4mP8/8RROtOsjW4BdT3uUIH6bBRs5zGPcOfOfa01RIWooqINqRTgM3kRP+
 GEfgH5VZhTAbhgaiMzxUTrbCR/3HjSKTBMCVQZzAVOqh6UN/p5eokZpmHXvtyEBU/MJqGzRlP+a
 6l+T2RkycuvLcNCNLtLgin+NLEeps3cQaf1kM3AuCl/cu0PqGRNRiKAIIb4HwqAI6M0YkSLYCy3
 E94u97SOssK1qs0tTOA2J5zNSWBhIp5u4CuuXLsPW4M2L5f4+jvVCexNmPlyoKvLjeKAmHwkaQa
 HP1E5+Ql7DAyDSKNKTkkRYybpAECIIOII6ib1t9BLrwGY2CyPBt8XiHkunFH1fm0aJx+pZaeNXR
 fpp1P67ni3gW5pIgRQh6ofX/QSEL/XnFNj7QD+I/DT8RtEHPUjuZBEsbk7YZYPDdvFfzWQGzSgN
 OOss/zZpWF8EUDYqKpYA+Cu0INYZbZzBGgSLOIBxGy3XBAQEQIQLgAOiysuOeojC7kyGsc/8TU+
 lzEcJiiv5X59CjJhJViLN2t1jZX4wryPr5HXwc0L7ZALSkxyV2kATV/hpoySJzLe10JBt8qHjU0
 eZx6SaG+f/clYYpS6dI1TegdwRpBvqsFfFFv9cmj5EJUuCUHDSqgehR6GEPctAsJowIa0LQBOns
 gTL09ogpzJ56Omg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node, matching against it and getting
the match data with new of_machine_get_match_data() helper.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first OF patch.
---
 drivers/soc/qcom/qcom_pd_mapper.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index 1bcbe69688d2..07198d44b559 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -613,25 +613,12 @@ static void qcom_pdm_stop(struct qcom_pdm_data *data)
 static struct qcom_pdm_data *qcom_pdm_start(void)
 {
 	const struct qcom_pdm_domain_data * const *domains;
-	const struct of_device_id *match;
 	struct qcom_pdm_data *data;
-	struct device_node *root;
 	int ret, i;
 
-	root = of_find_node_by_path("/");
-	if (!root)
-		return ERR_PTR(-ENODEV);
-
-	match = of_match_node(qcom_pdm_domains, root);
-	of_node_put(root);
-	if (!match) {
-		pr_notice("PDM: no support for the platform, userspace daemon might be required.\n");
-		return ERR_PTR(-ENODEV);
-	}
-
-	domains = match->data;
+	domains = of_machine_get_match_data(qcom_pdm_domains);
 	if (!domains) {
-		pr_debug("PDM: no domains\n");
+		pr_notice("PDM: no support for the platform or no domains, userspace daemon might be required.\n");
 		return ERR_PTR(-ENODEV);
 	}
 

-- 
2.48.1


