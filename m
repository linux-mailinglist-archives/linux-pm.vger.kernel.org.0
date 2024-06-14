Return-Path: <linux-pm+bounces-9157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDB908839
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA7428B7BB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ECD1993BA;
	Fri, 14 Jun 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="df5Vo1oR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296A1991B3
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358411; cv=none; b=YW3H0jfu92h4hYT0X5Kp3MscAv8aaaUoifRACw0kg7cgOcYy9u7MAj539yetSuK4mzo4hewD4DUZefsI+YZQIJkMANjbLxmO5PxQD6+tONAkIsbv+1Z/M0EHAKtHMAjeMfHgZzVEF8hInxkis0W13XW7O34NpEjFfLb8VBXcze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358411; c=relaxed/simple;
	bh=fPJBLqgC7318fFf2Al8T2+5gAe2h9ujfD/RlTMTvaWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omqqD0yGW4U0ZQW8ZHdmQVXMH/3xXPLt4IRwFG5DKr/Y4bcyms1mjdK3H03eUf+2IlnBIYuCEWkwAsJUaxymwztIC9BahAxzsXn2BqtSAf3PgqZnEmoni27zo7YFVUs1Au8qF3sw+m1FXukzqkRHX260wVzrHJCyb42A5i77gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=df5Vo1oR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a63359aaacaso290902666b.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718358407; x=1718963207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKBoYa2/x1W/F2+Gsm9S8Q8Wa9Z25/AVKvuUTKGCttQ=;
        b=df5Vo1oRbtNSwx0n5ZLyexak0dgewRy114kozxRzVdQ18VKbTXnk+sl3Wcw+GtJP7N
         g3ffeIcE6a9Drl7Jn0zRTcplXsQBysrlsycFx4Dzy8cSYtbIlgH8f1I10Jvi3mkkL2SR
         nwO7z0m2qsDhBe4LPNjtQ0uVsl39NAQETye+21BinXpLNPwedK5nKvQsM2JYt8IiOEhR
         SEOBU9JacMkLBLFJcTv1DTxWPIWIkRYUwFMx+BNbM/q8w5Y1bu/QNDyIHlbOWFobb4Lc
         XY/jndFC1k17TT6bd5WCh6RactLSSBllXgqK22f1R+xnv305FghhW7OVtO8JSVWATToC
         engg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358407; x=1718963207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKBoYa2/x1W/F2+Gsm9S8Q8Wa9Z25/AVKvuUTKGCttQ=;
        b=SObLG7XDmN6JhCpn9Rzt/5pwv4xAE0kUVo/ZI0EkNOea42mNkQAXnGV2pRBIpUOJsw
         sPoymqh9TsddHQosAw7+7QAqk3OAqBJhV8VYzZ9x1D4IErleHxLTtnsa3opUEEPENxny
         TloFx6jP5knXJXVU4jkrH7/QI2wIWZsOPfuFFYqhhEBQdsQfJzz95ZLqERW5I93PhlNT
         nSCo4MH1ERL8rMtoFY7VYM3LZxgbnyWT7pTyUGDJajR2Q6t1p+p+V5oMy0xbCrpj6lM8
         g9LzYmW6VxNNSw+IMB5ZGIvavlYQ91wNgfuHjJz5rL4h2lew9vC2Azl4buCq6gaSJkRU
         ceTA==
X-Gm-Message-State: AOJu0YyePHR8YWc8EvK96LG5z6UR3BWVwZ7y0RpFiGVjcqJBGx2F7Qvt
	9nlA8WShrmhV1VktcwA6BRXvXOTOmll0LFa3QSLigtXAJPuHbaXNfKFBn/H/lf0=
X-Google-Smtp-Source: AGHT+IGNlFyay8kOem24vdynFYgywyyZVSux+W6+RqwMfDi8eHKZ4ApmtC0R5UYkH/YsJbtiKWjL8g==
X-Received: by 2002:a17:906:c24c:b0:a6f:5c34:34e3 with SMTP id a640c23a62f3a-a6f60dc8a06mr152321866b.62.1718358407588;
        Fri, 14 Jun 2024 02:46:47 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.206.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9c84csm164966366b.222.2024.06.14.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:46:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Jun 2024 11:46:06 +0200
Subject: [PATCH 07/22] dt-bindings: thermal: nvidia,tegra186-bpmp:
 reference thermal-sensor schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-dt-bindings-thermal-allof-v1-7-30b25a6ae24e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fPJBLqgC7318fFf2Al8T2+5gAe2h9ujfD/RlTMTvaWw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmbBFmNf1yVZUqHe6ObrZYM4xsaIvMyiTnGv16X
 8eLBmKrFhKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmwRZgAKCRDBN2bmhouD
 10HqD/9YU2o2Db6RJtFXb6VGo0dUKqGzbKYA3Mdmk1MVN+dZ7Wy6EUb989MBdxWjjNljpO44Du2
 UknQbF1FcW19LKcDSAIX0ES2dU3P4VWocs8UO6zgFVOQBHWGUa26u9u68RmEyBP1ilQsqwVpjco
 kPJM7HbNEWxxbVMRrrx8TNpz9QGSWje4itnmiFUrw/wOWdqhi7fMij1Ru5a9Uw9SNRDmpiEExUE
 8aFQ8gO/dkIQOxdGbdhTMQNBwhud8tdMaNjnplec9i2iO246I6sde5KAJGmMlCwj5FAYu1edvv7
 fGe9B97J/X2ZrqPYYGInyYquT4lmEwgS1aEBcff0AK3RXm7LqQrzMOSnCUvf4xIMWo/eS5kY37v
 yBHyqQ3+B96ONbFWpXUsCJc9xFQS2ECzvbW+v0HM+ieI5tN/TAOZUDbLK/cnM18QhISO5H8U92q
 ej2R0T1/+55GLp6ZgOPU5yX+RZgzFthAc3eRibixzjFvCldYJUGQXIDWcKVfq4aOI2YVugjpyVZ
 s7Dfk491xtZzep9zpwKR4UTrMcEHdjcIH0aiMy0zxq1SKo0H9+bXWE11SZgA1DD9Rp6OPdK60+I
 09YqIgW6C799e75K2VYN6K/uDMmrQmys7pmrtJfEIJIdU3hcXV9mlxNLyPGUEEn7jEgq6ZpAvsg
 PTevguPNxftPhXw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device is a thermal sensor and it requires '#thermal-sensor-cells', so
reference the thermal-sensor.yaml to simplify it and bring the
common definition of '#thermal-sensor-cells' property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/thermal/nvidia,tegra186-bpmp-thermal.yaml       | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.yaml
index c91fd07e4061..978b9e6ab8a3 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.yaml
@@ -20,11 +20,7 @@ description: |
   node. See ../firmware/nvidia,tegra186-bpmp.yaml for details of the
   BPMP binding.
 
-  This node represents a thermal sensor. See
-
-    Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
-
-  for details of the core thermal binding.
+$ref: thermal-sensor.yaml#
 
 properties:
   compatible:
@@ -33,10 +29,6 @@ properties:
       - nvidia,tegra194-bpmp-thermal
 
   '#thermal-sensor-cells':
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: Number of cells needed in the phandle specifier to
-      identify a given sensor. Must be 1 and the single cell specifies
-      the sensor index.
     const: 1
 
-additionalProperties: false
+unevaluatedProperties: false

-- 
2.43.0


