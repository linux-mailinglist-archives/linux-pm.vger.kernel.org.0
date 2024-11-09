Return-Path: <linux-pm+bounces-17252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9341A9C2C6F
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B6CB21A40
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D818CC0B;
	Sat,  9 Nov 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RYlsWQ5e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C5233D95;
	Sat,  9 Nov 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731154094; cv=none; b=RRhRN21E7FqHa+vZL7aB06LlQNyOVfRJDBGGHAewXKDQ6rl6TIpU0Exri94LlS2T1Ok1RNAVR44K7LtM3ie/HO+3nirU24F5kQOB+OKYGcRQwnd1urQWKvRFD856mM4cN2ocDyKLoGXtMemkEkGjcFiTP9WF4PpBWvUNkd3FnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731154094; c=relaxed/simple;
	bh=1BgLXWAmX3G7znUFGLxBN+mI14pIHmJN0CK3Mxdvj/I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IVmofH5zj4EIHiXzzTGlOFkRc0zsN/soilEWxmr6gsZaphyqPksyms5+dhzJjQupllmelhBOERGZSJyYiwzVu14UMVpDSpo3FVVEGxdgilR+xQw5555J7aFPT5wbg2ju2Z8m65E3yplHXyJZelfQ0vYH+uop4z5/Tznoj+V/lXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RYlsWQ5e; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C229A.nat.pool.telekom.hu [37.76.34.154])
	by mail.mainlining.org (Postfix) with ESMTPSA id 908C6E45BA;
	Sat,  9 Nov 2024 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731154090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ALn3Z6S5KweSjpqd/ggrf98xa9odAbF4IbVQaYpxzsM=;
	b=RYlsWQ5efct9YiCvRwNtLtljS7JOS+jFzoYlkcIC3mQH4RUSQEsv4QlOBN+GuvgYDyePsj
	R1F/bG2AhH8IOhoH/FABiuPiXEeKPRMV3Qe714GL5HxI9ml3CMvx03o+YK6WAui+BMdmY8
	QoreMUoFwBkAOiXJT7i+6vpXBl/Cv7BCTHV9hNjUn6KAK6TH1k7W3hfAjoCHhpIDMMXHgY
	j92byct8HjS75L5cWio8t+7E+4lE86C2ZZN1JKQKQhhA9mB9VtJ27HyhP5E0MVKUibT4vJ
	WeIGYyhb56lERv0Mzwl8HK+l48/TME2rLaR5jyjyMNk4fpiH3/caCbi1+tx+xA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v4 00/10] Add MSM8917/PM8937/Redmi 5A
Date: Sat, 09 Nov 2024 13:08:02 +0100
Message-Id: <20241109-msm8917-v4-0-8be9904792ab@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKJQL2cC/23MTQ7CIBCG4asY1mIYKEJdeQ/jgvLTTmKpAdNom
 t5d2k1N6vKbzPNOJPuEPpPLYSLJj5hxiGVUxwOxnYmtp+jKJpzxChjUtM+9rkFRUFY4FkJlJCf
 l+5l8wPdaut3L7jC/hvRZwyMs131jBMpogCCsAae1l9feYHxgxNiehtSSJTTyHyxgw7xgbZiSw
 RhdN/AXiw0DUxsWBZ+ds9JYVyvd7PA8z19gt3eIHQEAAA==
X-Change-ID: 20241019-msm8917-17c3d0ff4a52
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Dang Huynh <danct12@riseup.net>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731154089; l=2917;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=1BgLXWAmX3G7znUFGLxBN+mI14pIHmJN0CK3Mxdvj/I=;
 b=Zyd/xEIQ2in3xhrUCvbShhWTFEmjjUu32jv88TkIBnFHNhmb3e0gMXDCkUiMOd/kzu0MHTKwg
 9EDuvZX0ddTBWK1aeUqI2FALwuywpUEq6/Cb7GqPjiHr3RCMHl9B/cr
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v4:
- msm8917 pinctrl: Fix gpio regexp in the schema.
- msm8937 tsens: Rename ops_msm8976 to ops_common and use it for msm8937.
- msm8917: fix address padding, naming and ordering, remove polling-delays.
- Remove applied patches from the series.
- Link to v3: https://lore.kernel.org/r/20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org

Changes in v3:
- msm8917-xiaomi-riva: Fix issues addressed by Konrad.
- msm8917: Fix node addresses, orders of some properties.
- pm8937: simplify vadc channels.
- msm8917 pinctrl: Fix schema issues addressed by Krzysztof. 
- Remove applied tcsr patch from this series.
- Reword some commit title.
- Link to v2: https://lore.kernel.org/r/20241031-msm8917-v2-0-8a075faa89b1@mainlining.org

Changes in v2:
- Add msm8937 tsens support.
- Fix issues addressed by reviews.
- Link to v1: https://lore.kernel.org/r/20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org

---
Barnabás Czémán (7):
      dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
      dt-bindings: thermal: tsens: Add MSM8937
      thermal/drivers/qcom/tsens-v1: Add support for MSM8937 tsens
      dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU to SMMUv1 compatibles
      dt-bindings: nvmem: Add compatible for MS8917
      dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
      arm64: dts: qcom: Add Xiaomi Redmi 5A

Dang Huynh (1):
      arm64: dts: qcom: Add PM8937 PMIC

Otto Pflüger (2):
      pinctrl: qcom: Add MSM8917 tlmm pinctrl driver
      arm64: dts: qcom: Add initial support for MSM8917

 Documentation/devicetree/bindings/arm/qcom.yaml    |    7 +
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../bindings/pinctrl/qcom,msm8917-pinctrl.yaml     |  160 ++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts   |  297 +++
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1997 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  152 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c                    |   21 +-
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 15 files changed, 4262 insertions(+), 8 deletions(-)
---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


