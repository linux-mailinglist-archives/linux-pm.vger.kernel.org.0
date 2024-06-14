Return-Path: <linux-pm+bounces-9160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02EF908852
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EB228C42E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDED19B5B5;
	Fri, 14 Jun 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVa1hpJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715D19AD97
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358418; cv=none; b=lAP0mPkWPvn9drpQ9nqlS0fRud65SP+BC3D8dAsGk9YIJhwvoagATgSg9f1RCntcOdtT/uFVibOIUcbmlmxbgfaQvlX5RFZ2q4uYh6vSBOju8F0oL/wLNS6dHFVih12h7m7D8sD33ANZcyWkEvcVHj1U4ko3jncszWWukD8wDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358418; c=relaxed/simple;
	bh=jB2+cyp+yRXAC1kEJneqPidsgt5m2Yc648gFgXnaUQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3wglux1X9+RFVzt2kKymhO1YGJDkQ+elOV9Z8Pll29EvmZlR+U6pOuGTwEhORmWdKt4NHMBjNRi73tgPSR3mmHkc30XUXzKloWjBu8c3KlngxxxzfB/yZz7cQeigL64yrq78iYaOWNznwr6O9HgZ/UXYCwWt5HYMZ1lJzo03h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qVa1hpJ3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a63359aaaa6so282256366b.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718358415; x=1718963215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diVITPG+U69FAXsrkSDgST1dz3g86H5cCTlmEO3M2Y0=;
        b=qVa1hpJ36Dl4MsRo7zxBHSXmWEfo2Y9PtQnWog8tqKlOUYgLBlnc40f2pG1//pxGp7
         SNT0ygYK4/C1jeeKRhQgh+cIXRxtxFNjKTe2286WHvGp+HfxuFSZWlr+It5yOmyCdBGA
         f31ZIPBhpAEvTWq6NrujmVL8dDYfEGKbalDHRMwl0NKpBqsURX6fTyUUr57BXowXTMkc
         DNV7wglwSKgvos8DuIX93hyv2gG3JSprq+e9PFb7rlYrXfsOOUbBjEuq5kcKTCZwoDjP
         4FnSvA/8Fi8y9OzvhCoRMeFsou8FI1k6hhHrWcTqtzM5KKeUh2/YWx3OehVyRuHTToa9
         t74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358415; x=1718963215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diVITPG+U69FAXsrkSDgST1dz3g86H5cCTlmEO3M2Y0=;
        b=IZg2mMuPIDpDGrzL/Ffg8pyjbaJRF2+Gy0lEm0reKKA5S8ziMO6BGRhNtwidVluMRi
         4oXEbrIt7Xw0NxmM5TeSZkRoeXAF2/tiVjRb6vxlVIv1h4zvFYzgVdWHUdMS8Yk0GTPD
         Qhigd81OBQrzL0FUtVhLGsO2IOFjVVo8NqnzcLjTIBkyJ9yjZjfvAFH8wvdQimCyVl6W
         m6s3bcrJNnzNL9VEq8ydt9NtHQ2srK2vTiLJHuX4b0GLm98X2tk8kbc929bu8KknuuHD
         qlfH8OcpmdN8wYIcjHbzvLbOni6m1DcDjou44WV86xJtO/zUE3tx3wsC8LsV1d1krUvD
         Mqfg==
X-Gm-Message-State: AOJu0Yy2qlafHNAkecZLsjLqaewlJ5mUsWMJD5AeAk1WXqXPnWYH+QId
	UU3mEy2XKgBqXOAdnCuAeYYOW4v9FmXCr6yk4SVG7nJp353oQjIFaHd6fVZSRdI=
X-Google-Smtp-Source: AGHT+IHJ6VKC+ZkUX4MCXp1favByLfYG9oZTKz0ACNCe0nG6dZyT+4BsvOgaSIyYvgyK5lQOJfvA2w==
X-Received: by 2002:a17:906:474b:b0:a6f:5698:ab5b with SMTP id a640c23a62f3a-a6f60cf42c9mr137428866b.8.1718358414729;
        Fri, 14 Jun 2024 02:46:54 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.206.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9c84csm164966366b.222.2024.06.14.02.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:46:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Jun 2024 11:46:09 +0200
Subject: [PATCH 10/22] dt-bindings: thermal: qcom-spmi-adc-tm5: reference
 thermal-sensor schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-dt-bindings-thermal-allof-v1-10-30b25a6ae24e@linaro.org>
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Heiko Stuebner <heiko@sntech.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pascal Paillet <p.paillet@foss.st.com>, Keerthy <j-keerthy@ti.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 zhanghongchen <zhanghongchen@loongson.cn>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jB2+cyp+yRXAC1kEJneqPidsgt5m2Yc648gFgXnaUQM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmbBFoG4sG/rVZZvZJjTVo1CtsKCtX5+KMs+5/J
 dgwcbTI/rCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmwRaAAKCRDBN2bmhouD
 19jgD/4/vdImKhsyvj7NutFzdYuDLc3MmZZRzV1Bx/8qnErij8h1xHD4AUvt9F2XLx4A3qZINwB
 lmU65j1fTCGzPT0EG1+2D7ELqbVjbRFQ85c1g7k1rOvdKtRIo/Y9/3yfcZiPhfxQa5QABBEhwac
 IJhhIdDloNQoDbWl7uUtbsGlnS6wBTAbbG5t7vDADAKsZ9d92kgywFkFs3V8JxsKSMp6fQNN6QA
 XA3jj0lBOBrwPD/N2Va+Qe3+V9b38tv7ZUGj4Kv+lj7QVTWUjwbgotWPyDTmIPOJAkySV7Y/DL0
 Q8cBedpthXfOfDuXHxKMiifT6dR7uGc5+KswALA3EFjbGgEv8A+2tKLdS5KptJUSn/BHKZ7Ptg6
 FyHqBSxjm4eWRDYR4vJAEL/djuEO/EnKCy36L89Oc3/77UkgXf2dni37nvycFZPO/QIHIHEshmd
 jXIrPFKs/QS3wl2R88x8rXQsTbkJOWZEfBoZVV6CDfJTaFyZiZb1lLCVqunfZPt0Dg3Gk/tfOdJ
 9dBVNN6Ysj27oo3vF+3jRxMz3B07uDHOIsfal9gZD3Dha4vPzeQwCCozZ4uOBIQ6jm4y/hHGneB
 VFXVIuS7YD/ltb50a4FOKkepYaOrsZKC6nsKQKnDbkBrPp5DjH85REssabsCUq4d1uq/TcC6vfw
 wIr2ahlO5CKwxSg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device is a thermal sensor and it requires '#thermal-sensor-cells', so
reference the thermal-sensor.yaml to simplify it and bring the
common definition of '#thermal-sensor-cells' property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index d9d2657287cb..4470a5942fb2 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -8,6 +8,8 @@ title: Qualcomm's SPMI PMIC ADC Thermal Monitoring
 maintainers:
   - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
 
+$ref: thermal-sensor.yaml#
+
 properties:
   compatible:
     enum:
@@ -23,9 +25,6 @@ properties:
 
   "#thermal-sensor-cells":
     const: 1
-    description:
-      Number of cells required to uniquely identify the thermal sensors. Since
-      we have multiple sensors this is set to 1
 
   "#address-cells":
     const: 1
@@ -159,9 +158,8 @@ required:
   - interrupts
   - "#address-cells"
   - "#size-cells"
-  - "#thermal-sensor-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0


