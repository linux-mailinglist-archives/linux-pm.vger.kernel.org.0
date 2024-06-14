Return-Path: <linux-pm+bounces-9152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692BB908817
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9051B25AF9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62942194C71;
	Fri, 14 Jun 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qhb+Iroa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9A194AC5
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358399; cv=none; b=nkMQCQWnFZbmPuTA/vJ/aY6mByLpt0m1Foi9W0du4z+3C7RfitiZ9XvoGCTzH3G3KfEXB1ZJ4WhEzt59GmTqdIBJlqGRBeX1HOd+np6efvUWP9rV3hBS/+Hsp3R1jYzOvzsB4d/4l//ZtWnBPV1p2jM2vW8fYLNCH5eTxxe6/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358399; c=relaxed/simple;
	bh=OL1bThiSTDRnxDnX7dUSElkuAerpOnM4wbDcCD9Dzlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjIvcUson3I0T3I+gH4oGpanWFP0BAbj1d55Pn4w92TJ4ZI7OQ4Z+t5N2gb+5Nl11Ow+R87HW8YTj2xLVHQJPSB1zvSQfTcdD1lxQJ9JXgbvSWhGM3apP+GnXPIUACV5Waxb/5tOSyHGSJc8p6/L8kzSFlAY+mCjnykJpGORqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qhb+Iroa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6266ffdba8so231525566b.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718358395; x=1718963195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rccL2DhMpg13ts9Hqjm/6zzy9zUKGOuodol16mwTeU=;
        b=Qhb+IroazVKAZqP43c8r3si5rTD3cJu8gBozAl5y7TQJcwm5l+LiyIXZpJiwKx/5NT
         LGGMperyZgbpJrgJ/xyJ6k+BRjH8QOtcLzW4QnDtnuM3NonHy50lH7V7o16fN29xbA8w
         fJmL9NaKxcQA3bonNZTiMF8yRXupPUSI6rm90xlA7BKoMkHRQNX0FALAlK/X0cSaHke4
         fiLUOEkseNSht7IHmIajbnjVGxvok3Tk4yfkXxnTTsgXoxVkWUcN6eqpVLZXGiWCs5Mc
         2htMxOrD4TMvNbQbYB4N8gB9YYuZ1FuMxUyt/SbkHYmM99j1oweSB22ajt2F9O1Qp9Xu
         o7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358395; x=1718963195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rccL2DhMpg13ts9Hqjm/6zzy9zUKGOuodol16mwTeU=;
        b=pgFSo06t4LF/41dJcqECRGPU9sdlBHWbyBgDc2FLI3ijAw+DsqgvhMp+sIxAfxQ1TM
         INscNi/LCJs7oXero8mvOkqvmm8H8N7NJV3SexVdJHKcNskQPu79Xfm6d2etT+VDA/uv
         EygDPlW+Fl7qS0uT8hNJcJVb2oWfatGu0wOkmSr5k9YUyi3NcV5De/B5W9qtCrBeB5ue
         VPEeYO9h6/wApTOKOZ+GyC2q5KPeoKfmjEfE3H0fTwUcq0IY/qjzN2Z11TCTE4EVyl4r
         cCntCOn9vmjnn4WlMm9Bjs47iuCPfslMpF7aKEEh5yP4fBL1QqPIFpV0wdt3KztjfewD
         3chQ==
X-Gm-Message-State: AOJu0YyWiw3p88dqLGFVsR8qjxFyx95vnp/MgPh9ZP2YzNkFFJp+g0LY
	sw4ThQEzMJM16xfI0/HIxOdNVyoatRhr38yh00LjKepyh9Fis1jZ0dwyL4ie4UY=
X-Google-Smtp-Source: AGHT+IEIIi7f/khX+DL0ElnKeXbkTkqu3Do2h2qNKYCQfUhMKe+WvRGDBSKEB/3Hlft5tLx5w1488Q==
X-Received: by 2002:a17:906:ecb8:b0:a6e:fb9b:6769 with SMTP id a640c23a62f3a-a6f60de5fd6mr154292066b.75.1718358395585;
        Fri, 14 Jun 2024 02:46:35 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.206.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9c84csm164966366b.222.2024.06.14.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:46:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Jun 2024 11:46:01 +0200
Subject: [PATCH 02/22] dt-bindings: thermal: amlogic: reference
 thermal-sensor schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-dt-bindings-thermal-allof-v1-2-30b25a6ae24e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=OL1bThiSTDRnxDnX7dUSElkuAerpOnM4wbDcCD9Dzlo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmbBFhz93LdRptZhTU1GW4iGarOwOO5EBiFYLFd
 wFDJHK7K/qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmwRYQAKCRDBN2bmhouD
 18s9D/9LP9unfX0MSkgXF8TFjscV8gcBK408X/8oxDWBhIrJxkLZCwMssuTlysHZ2OYfyKJHsGx
 G6Y1+icUV6gklZsPxjJ03/jABHwNj3xRb9AQPOwWQ62xpX/+zxQNNaEcW6AKyNmY90EgCBRRrwx
 +zhCuMur8Gg6isM+gl3qHVZsMSALb5gwAMQDe3KP7A2Sno1hJw+giAAb3KI6FtfvevD2XtkMgab
 x1xdWHM5YlOGmNi6acFw/2dtzcokVRiNbkNGuBpupXWq+vZL0n0mPr26qRUOIGhKqt/t5xQsemZ
 L+Mr4ASMWruC2cyuxRkPN6WXiOqU2PWSej9kVH8O1xuNjE4e/PQHH91KA761ii2PhPs/7y+OwqF
 pctdv1ol8AqI0F3yHRz/o1pCSJ8swPRC9vEXoLIwXfRYvwqouz1kVDofMzUcA302kDb5yZk+EgG
 9KCfyKlubN63juUO4jfkwe2WzfAcEXpi7GKMv5Gky8SLAPPRYoGewIbSvc/Zog++OvMxg+kMDGp
 +C9mjIWV+rrT6bt6c5KjBkE/42bqZ5THaEoLUfgzGuhP/PUHKyI5JxC3F+owxWNpfB7kDtFeA3z
 Yk0Am2y1AAsjqTGzDLnMJpNuFIZZoghdpcYJXcGJPZk+cauVsVa4n9fxRsSpvMdZFo6Fl7Qrb8i
 h+5fgjivCVGsZIw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device is a thermal sensor and all in-tree DTS provide
'#thermal-sensor-cells', so reference the thermal-sensor.yaml to
simplify it, bring the common definition of '#thermal-sensor-cells'
property and require it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 01fccdfc4178..e52fc40e215d 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -11,6 +11,8 @@ maintainers:
 
 description: Binding for Amlogic Thermal
 
+$ref: thermal-sensor.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -44,7 +46,7 @@ required:
   - clocks
   - amlogic,ao-secure
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0


