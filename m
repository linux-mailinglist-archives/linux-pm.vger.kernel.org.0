Return-Path: <linux-pm+bounces-10661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F3928583
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA4B283F23
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8BD146D76;
	Fri,  5 Jul 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJksSF8t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4ED146D45
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173118; cv=none; b=A3DIb0YXQHk7RflifECRri7rnXXukrAqJ/IBz9/ECI3Qs2P+2dn1uEJyjGBvSTS41omszqEATakvp2oIt70F9UvwMZqo3vl+rJk7DrXFtFWSw5CWm7uUoHIB0X1muba+pLuFso0r5/Mgzg3PQo9J3gUy2c8zqZ9voq/lO8E4/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173118; c=relaxed/simple;
	bh=e0XnXkSS2UbFWN0Enj/RykHQGyKigRvVK0Ae2vPy69Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HdCPqPW9DYsCnSDqbVoeF3Oda3vlMVprUB8Tu5WthzHYjvQerpj9MSg0lVVX1/rDqj8UQIgrfgelJ1pbtWFZFskXSxjWgm025CEONQL1zGijRCtUf2sxRxbu8rHyr66pEOqaJCUkQaAyHqGbUMLWZPAs86AGZJHoj8Y29Apz+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iJksSF8t; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367963ea053so1100706f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720173115; x=1720777915; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kJu1vmWUxTKY4ACFv7SXUQFPNZpjog7M5wGF280T4yg=;
        b=iJksSF8tH+siIX7cytno/G3Off4WTLYpQiwWaVDJhmRLTCgdRlGFPoB/vrGtO0aQhv
         huOPqrEB4lhu2DqvWDiPh/JXwbpdSaCR38mX2HUlLMRJhtT/ySuvkJQvhebLKsj0CwZW
         nhc2JqHsyVlxo/fxQ5nlZDbZ0en5uZ/hmJ+IVOkpq1S6oW0xgWQFwGnaJ4nLT67YETML
         05nO3dne6iwz5tb2OjqL+/3EZ9p3XT3db7EHYswrhDmI422n6ot8pz9JHCv0u+v+xXkn
         Y1HrQVNuh6Jk2WIqWYlPFyIlVUXjc7Jo4jeuKoqWxOyMAsZ3SI2Yfwc5XqLMGKx62Z2G
         /E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720173115; x=1720777915;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJu1vmWUxTKY4ACFv7SXUQFPNZpjog7M5wGF280T4yg=;
        b=lvD84NBHlB33j5HLpzognp1BW+5D9uFSl5rBiYIgoT8OXMe/Qo0fDJsAFhACr1PYWP
         Am6RuK1HxkakfGRwmFUF37Fg9SH46T69Ol+GVSAaYVct+NqOFZ3sKGLDF6klRTCVmRQ4
         /g1HGpT9aGLIwM2fRwY3jLV/BWcL+EPkYjZbOJKBF9JRqvEctNezmvY1yR6sI8mMUGI5
         X+lLOjmnZxA+m3jA3dcbduc3qNwqnSMsfSGTWrxnGxDbGY/5WQnuRVZwDO9V3Hk0iPpe
         xkpENMb47tAWn1QgRlQlzjtvBxzsATib1RXfvwBVydwBDAmKDlJ9AaLD3cD8fFeNCxwb
         1XwA==
X-Gm-Message-State: AOJu0YyQbrdlGBgV/FDoHbC3cLwrSp+/+N1dXpwiFN3r67SqMZfnUPx2
	MMoXaWo7rcKVkoDn7DDFkxnmeqd8/uBozst1RiY/SwNikb9Ra0MfKXAqqJOeNRc=
X-Google-Smtp-Source: AGHT+IH8V0hkcfYPUlBscK7rDTKJum3Y/kp1D4wfK5gH6s/Rm3xSZgQUyKRbc81OqnK8GjQSgcWNiw==
X-Received: by 2002:a5d:62c4:0:b0:367:957d:b46d with SMTP id ffacd0b85a97d-3679dd71ef8mr3422417f8f.66.1720173114610;
        Fri, 05 Jul 2024 02:51:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1650sm55528995e9.2.2024.07.05.02.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:51:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND 00/22] dt-bindings: thermal: few cleanups
Date: Fri, 05 Jul 2024 11:51:19 +0200
Message-Id: <20240705-dt-bindings-thermal-allof-v1-0-554061b52fbc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjCh2YC/42NwQ6CMBBEf4Xs2TVtLRw8eZCrBz0aDgUW2KS2Z
 kuIhvDvNnyBxzeTebNCImFKcC5WEFo4cQwZ9KGAbnJhJOQ+MxhlrKq0xX7GlkPPYUw4TyQv59F
 5Hwe0SnelokrTYCDv30IDf3b3E+71o75docn5xGmO8t0vF723f9gXjQpPqjWlqxwZSxfPwUk8R
 hmh2bbtB1q92lvLAAAA
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Heiko Stuebner <heiko@sntech.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3987;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=e0XnXkSS2UbFWN0Enj/RykHQGyKigRvVK0Ae2vPy69Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh8IhQOLA3YgiesM3X3PsNvQ88/UNWP+TTpAnV
 HPEl13fLgmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofCIQAKCRDBN2bmhouD
 16lHEACAIqQ6rJ+IssE7c+6Byc/DFWCacf2uYgdbCx9SEJkdhTd2FBmqtuIGorS7GWv7sQjWxUw
 s0tkl2uvy1SLpEwSsjDX8jifZyU9Isz2koX+MPKaBiaM/l+shANrL9Ub8nkbK2VdKHVoqlBJ1jx
 CRViJ5HwLCQ+xul2EKAI8qfZdiBhLCvCWXiWyqNVOzGla8SXM2b07zV+Akza3BDZPfw42QEbgVE
 ZCAP2eYkIe0ZJiHNJ6PwjIb94/46R44k0NevaC/FRcinUnaHRNaKcUJ+fkPQ5XZjFH9sg8TCkxV
 vRMnI7NYrYrvYIOgRBa2T0QfbAP2dnxqo1gMdxQy0kJowh61zrLfLKAbYNJvlRh/r0AYziRZHrc
 U8k2+NDtbOPfp0vKsIvEtEC3qnpVHB8LTlfPNK+cpvv8uj0wWe+H0kJ/DCxIhbCjYZk/63YOAl8
 P4xRXaf/fFVZy+HxPYFCNrvf4MYBSg2XOhwvfprdm8AZXX3yR3YyZGVJ3UoGlbYvSkJDxTmP3Ii
 J1lsr1ay4TULQcqQNg3uiC5RLHxzMo/USu2p/M0FBbi2TJ/OlJynDRAO8z0Ox8Ggk1eiruF+q83
 92qWVFjKIhRWyHIkXpUcZhNw7GNERqxdsj6jrNJBa1nRCBdhobA/n7B8PPeqcsgzie6AEOHo9Ji
 h+HUlL/i4jtZxAA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Resending (with added tags) because patchset was still not applied.
Daniel, can you pick it up?

Few cleanups witout practical impact, except maybe the Amlogic schema
(bringing required cells).

Link to v1: https://lore.kernel.org/r/20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org

Best regards,
Krzysztof

---
Krzysztof Kozlowski (22):
      dt-bindings: thermal: samsung,exynos: specify cells
      dt-bindings: thermal: amlogic: reference thermal-sensor schema
      dt-bindings: thermal: allwinner,sun8i-a83t-ths: reference thermal-sensor schema
      dt-bindings: thermal: brcm,avs-ro: reference thermal-sensor schema
      dt-bindings: thermal: generic-adc: reference thermal-sensor schema
      dt-bindings: thermal: imx8mm: reference thermal-sensor schema
      dt-bindings: thermal: nvidia,tegra186-bpmp: reference thermal-sensor schema
      dt-bindings: thermal: nvidia,tegra30-tsensor: reference thermal-sensor schema
      dt-bindings: thermal: qcom-spmi-adc-tm-hc: reference thermal-sensor schema
      dt-bindings: thermal: qcom-spmi-adc-tm5: reference thermal-sensor schema
      dt-bindings: thermal: qcom-tsens: reference thermal-sensor schema
      dt-bindings: thermal: qoriq: reference thermal-sensor schema
      dt-bindings: thermal: rcar-gen3: reference thermal-sensor schema
      dt-bindings: thermal: rockchip: reference thermal-sensor schema
      dt-bindings: thermal: rzg2l: reference thermal-sensor schema
      dt-bindings: thermal: socionext,uniphier: reference thermal-sensor schema
      dt-bindings: thermal: sprd: reference thermal-sensor schema
      dt-bindings: thermal: st,stm32: reference thermal-sensor schema
      dt-bindings: thermal: ti,am654: reference thermal-sensor schema
      dt-bindings: thermal: ti,j72xx: reference thermal-sensor schema
      dt-bindings: thermal: simplify few bindings
      dt-bindings: thermal: cleanup examples indentation

 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  6 +-
 .../bindings/thermal/amlogic,thermal.yaml          | 22 ++---
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 22 ++---
 .../devicetree/bindings/thermal/brcm,avs-tmon.yaml | 17 ++--
 .../bindings/thermal/brcm,bcm2835-thermal.yaml     |  1 -
 .../bindings/thermal/fsl,scu-thermal.yaml          |  1 -
 .../bindings/thermal/generic-adc-thermal.yaml      |  5 +-
 .../bindings/thermal/imx8mm-thermal.yaml           |  5 +-
 .../bindings/thermal/loongson,ls2k-thermal.yaml    |  1 -
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |  1 -
 .../bindings/thermal/nvidia,tegra124-soctherm.yaml |  1 -
 .../thermal/nvidia,tegra186-bpmp-thermal.yaml      | 12 +--
 .../bindings/thermal/nvidia,tegra30-tsensor.yaml   |  9 +-
 .../bindings/thermal/qcom,spmi-temp-alarm.yaml     |  1 -
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |  8 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |  8 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    | 96 ++++++++++------------
 .../devicetree/bindings/thermal/qoriq-thermal.yaml |  5 +-
 .../bindings/thermal/rcar-gen3-thermal.yaml        | 69 ++++++++--------
 .../devicetree/bindings/thermal/rcar-thermal.yaml  | 60 +++++++-------
 .../bindings/thermal/rockchip-thermal.yaml         |  5 +-
 .../devicetree/bindings/thermal/rzg2l-thermal.yaml | 41 ++++-----
 .../bindings/thermal/samsung,exynos-thermal.yaml   |  3 +-
 .../thermal/socionext,uniphier-thermal.yaml        |  5 +-
 .../devicetree/bindings/thermal/sprd-thermal.yaml  | 47 +++++------
 .../bindings/thermal/st,stm32-thermal.yaml         |  5 +-
 .../bindings/thermal/ti,am654-thermal.yaml         | 15 ++--
 .../bindings/thermal/ti,j72xx-thermal.yaml         |  5 +-
 28 files changed, 230 insertions(+), 246 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240614-dt-bindings-thermal-allof-401c50e61ef2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


