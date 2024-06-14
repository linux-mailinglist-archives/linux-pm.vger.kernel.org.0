Return-Path: <linux-pm+bounces-9166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B0790887D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D0B28E1EB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E526F19FA8B;
	Fri, 14 Jun 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhK17m4P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD6192B8C
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358432; cv=none; b=S0IQo6Hef/uX1rZvk9cVPAxiQ6cwN2Ew8V3XnBzIBbwsf9fTnhlN5vSgYhb7bf0TZl2W8Y65/3F81zLOLfRfTwAQwcQMCyO0OUUdRSOWLOCEHqDvihBWjVX8rVOfCZcs8vl7FpuxwoSayWsW2jERwnTnQvisCFamSUlg3mqyuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358432; c=relaxed/simple;
	bh=mIeSyvnLon2ygamBuRDffzz4itb60m44w9O1qvVSAt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvY6xUNZDcI9Ps+Re9W7as2BIhrrwPgEG9nLOJyRjzaNZqfl6ABcsGPBSrEfy+Swgo051O02135Vmpi7ZYiC4AeaioTO4cRrImH19k4nXYQCNlf5rZzlfeaTFTwby9hrjQXbxDgs2CpWl+r4VHFpr8MbZ9jnTWQiLFnhxsLRx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhK17m4P; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f3efa1cc7so522602566b.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718358429; x=1718963229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ruyCgMrPfekzht/5WAzVWTMLmXSUd2VwxGSvpZZrV0=;
        b=nhK17m4PWhnYDfkyM2gYzloIsuO6CpWpkbmyut14OdHX1moX6zavbXl6/CKrRnf5M3
         YMLHP/LQNvFgFAOr+9WmQVJhN041xskO8S8p6/N9xNxXh1PvAtbvjA2LG8CK0sAaxYWp
         sHLYG9v3kHGexvKkI+P5GdWyYLWvE2FExcS/4NGSaNjByOcOO5kGcx3BcB8ddHSr9OZa
         w6wQWkNGX6rysQDT1T9Kxj2vhdrQYaHtowt5vEMK6JRcRbfGHUfgXJg5Ce49YZgTiHBX
         uoEG7sxpv/eO5K9E/NBCBycBRXM5IQmdAlNblS/jVa1oRDG/6BvmvFhAHMOMxynHFja4
         ZMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358429; x=1718963229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ruyCgMrPfekzht/5WAzVWTMLmXSUd2VwxGSvpZZrV0=;
        b=vJbCHiofqnC5cgoM6F97gG8bv2bCXKWmHmxQgyEgrJyXfmGPlehW9dn7eFPenScEKF
         XFrF9YnwnWNN4reil0kjR6AM9UZomnb1sVjVgUutDQ9bkSisE5+E5xQg7D5V5GWbxq5f
         Ufjuvh2sZHKQWZrDlbUKzkjuTBtbrXXWIbPTpn7OoL7DLWTVMC4iXx5NaGJLLEUjWTaC
         zv3Cs3OIsSrp70hdndjxwwYD0CRSyp1UKMB6AxXp7UunWAKXoiXvVZsXmAnVr/+Pl/n9
         uCBqsMH/51BVD5CPndUWmx2usSywIGm4ra1YPPiYHQjNWiOUFJQmr7gvosP1T8h2gLSM
         Q63Q==
X-Gm-Message-State: AOJu0Yx4inx2vHULqRUiYLVMhUtM38uTr0rK3KY0VyNLfo5HE9LpKLI1
	FXGKPDr3h4xzeOi3uPrn0D7RA5fqB8OYWA4enEfXRhHMNo6P8SkqsedouaGXQFg=
X-Google-Smtp-Source: AGHT+IGIKghrlULYLHsfLKde8CcadgZJW0YzgNbewj72+XW0ql1TiGTPFflVpMsUJxAghmYfIehKqg==
X-Received: by 2002:a17:907:9406:b0:a6f:1727:cf4b with SMTP id a640c23a62f3a-a6f608a7945mr189043266b.23.1718358428993;
        Fri, 14 Jun 2024 02:47:08 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.206.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9c84csm164966366b.222.2024.06.14.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:47:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Jun 2024 11:46:15 +0200
Subject: [PATCH 16/22] dt-bindings: thermal: socionext,uniphier: reference
 thermal-sensor schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-dt-bindings-thermal-allof-v1-16-30b25a6ae24e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=mIeSyvnLon2ygamBuRDffzz4itb60m44w9O1qvVSAt8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmbBFuGs5Jr4iu4ztVMLTV5UrKA/VmvClhsc3Nu
 /DgeeOEc3WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmwRbgAKCRDBN2bmhouD
 10rZD/9/pL5MAXa4cu08LXfwwna/wMuGScuABTPKkAA5rLndGvqQlFBBRMSephHRwgqXqp3Ifsy
 5/CCaVDAhKCkQSZ7NO0c7N/nnrmVH6VumgINouVuooUF/4kkzOqHy0Ps7bPuuX9QpkT3RY9wRLE
 46OwqjthHWuZc//DYekmQaF/L0qSJEk3SSJKGFVansCiaRvv0vLvluIIputqAPE+5A70K37ZVNR
 /Frtg4VKlW2yjKKwAjwvEmnU/KSO1gx5pg4fCsJwfJKoMqJbVrjPQgjH/08LIcfE4HCFesRhr01
 753qIZ+Zsp8tvJJ0I5W4fBh2Ycur+VCwGfHZNQN/D58/eRl64Rdlfriw2/Uns8Tt6gsabgnorj+
 mkIBO0w9/zygKNIJWRaL4AJTgYVLViyH5x9axMJvhcl4pNb5zE/ddX0PGivIvwblBrQcWTgdG4A
 FSTY2l4LvCmP1li68LdkKwt/pFW+2nj5LqhjXkXWLfUU8MAK+fO6ZuRILsYXJQX+5H6+Me5YoZH
 JMvprdk7NXkgNJa2Xcbrfq6/eTGzZypopRcxFn4T2nWjQ0SzNVZj4tetdcp8HOVXRUjb/j+JNW3
 42jZg3DaQZdvo7oUunA54ox/aRO7TB0R4xS7pxtdbMgf/pgqWTbfWEFsWnhgItUJjpazn9rqRnQ
 e9qS9o8tU4rOHag==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device is a thermal sensor and it requires '#thermal-sensor-cells', so
reference the thermal-sensor.yaml to simplify it and bring the
common definition of '#thermal-sensor-cells' property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/thermal/socionext,uniphier-thermal.yaml      | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
index 6f975821fa5e..8210b7079721 100644
--- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
@@ -14,6 +14,8 @@ description: |
 maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
+$ref: thermal-sensor.yaml#
+
 properties:
   compatible:
     enum:
@@ -38,9 +40,8 @@ properties:
 required:
   - compatible
   - interrupts
-  - "#thermal-sensor-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0


