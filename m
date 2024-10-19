Return-Path: <linux-pm+bounces-16004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2679A4D3A
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 13:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9CAEB21BB5
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747AA1E00A1;
	Sat, 19 Oct 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qgmcqSq5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817821BDAB3;
	Sat, 19 Oct 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338650; cv=none; b=s34caBVWmf/3r4I1PqwRAnhMvAE756FeD8d22q86mX8bU/Shz+714X1Xz0dAk3eGXiMnKVqNaj9tcLiwoEtZu9XLOKoZp7uQ1k5OgkI/KD8k3SwCsB7r6QHX4Ssn37e+e6bZtaKXuoQeupxUEUc4K3vzRAw8S+nFqKnnvW8C/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338650; c=relaxed/simple;
	bh=ALf1wUJN+0Fpqn4qKACsZmuH0gCwBAlL/6YKtoXClYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T5XAsswTJP/53kAwQKS3rNICnlIcsHOcAW/xzYSN1hXSG4QhH5/l20/Kr+I/xn+XSAQ9K9vqdRNZ8yJJwD1XJT9Pzfuz5tTtwMngjvE6JsbAxry2lOSZpMvAgECIavBKgGw+qbinUCsrnsVYIJ5Ttw2eZMSnSL2XVgb/yc/Qy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qgmcqSq5; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (51B6DD9D.dsl.pool.telekom.hu [81.182.221.157])
	by mail.mainlining.org (Postfix) with ESMTPSA id 8A16CE4205;
	Sat, 19 Oct 2024 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1729338641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w5/Ny1lSvVpnnZjsjk77MC94wGjYZgVT23cJY+JO8UE=;
	b=qgmcqSq5Xj804Q6kJVeqDFLbV2owDZQFILwAoWxkpX8O07AdxeLX+NZIh14802cQ3UIYMz
	tevodF2arg8Gbw4JJc9xQLhUXUH21ROZuG255M/MWFzqEaTXbTdEeo2LqFSddg4KrSYDEX
	M5JSClxYShOteVa7Vnws4ZxE2WL0+9Eb9ia7HrnqXLh6g0NF8p4xhVJwjz4XIK2LpMnXUc
	ZSCV2AhMZdbTC+uzBXIxg03KwYqFdaTNh7AJRCZKodzGxicpSQspNQfJt9TNDH0z+E/GoO
	pfbrkRAYSetQQ5kDF5P3jsyvRaIgzI1LCribvu7/H8SEz5zIsivc0jACVSQQjg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH RFC 00/14] Add MSM8917/PM8937/Redmi 5A
Date: Sat, 19 Oct 2024 13:50:37 +0200
Message-Id: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA2dE2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0NL3dziXAtLQ3NdQ/Nk4xSDtDSTRFMjJaDqgqLUtMwKsEnRSkFuzkq
 xtbUAZhhrRl4AAAA=
X-Change-ID: 20241019-msm8917-17c3d0ff4a52
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Dang Huynh <danct12@riseup.net>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729338640; l=2491;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=ALf1wUJN+0Fpqn4qKACsZmuH0gCwBAlL/6YKtoXClYM=;
 b=//sMc2I0RKJ4/BL5T24JEig0g4tJgPwPviUpFku/VIpxRCbYlfRs9Kf7YA4Gtfc7uqHS8gBG1
 2a53R/G22z5Bog8X97Aer/qVcSS5rD2E3dgYmwseZmXvUI4V5zSHjCW
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Barnabás Czémán (11):
      dt-bindings: pinctrl: qcom,pmic-gpio: add PM8937
      pinctrl: qcom-pmic-gpio: add support for PM8937
      dt-bindings: pinctrl: qcom,pmic-mpp: Document PM8937 compatible
      pinctrl: qcom: spmi-mpp: Add PM8937 compatible
      dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl bindings
      dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8917
      dt-bindings: thermal: tsens: Add MSM8917 compatible
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
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../bindings/pinctrl/qcom,msm8917-pinctrl.yaml     |  155 ++
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    3 +
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |    2 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/msm8917-pins.dtsi         |  344 +++++
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts   |  295 ++++
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1557 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |    9 +-
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  216 +++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1622 ++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    2 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |    1 +
 19 files changed, 4224 insertions(+), 1 deletion(-)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


