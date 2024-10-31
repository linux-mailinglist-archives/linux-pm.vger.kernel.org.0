Return-Path: <linux-pm+bounces-16793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661609B71E0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 02:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768571C235A0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 01:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C591823AC;
	Thu, 31 Oct 2024 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qwu/xyiT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C02F855;
	Thu, 31 Oct 2024 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338187; cv=none; b=e0GuR2bxPocFKi9/IXt79lz537bnSw35PKQXH4WT1GRMMBXChh37mAaqiXqvFktQ14oROye8rmW7vaXvQ6owb6YOdhLUML4nN+qQpVpYFmC7QgaNMUQYFXCg0228z7/n7DGeXw1cOi/uF3/7xBczH27+RuE70TleoWcE4T9oKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338187; c=relaxed/simple;
	bh=7dZsRjpgvzq99Vps+KUUhV2OvVoGHjcdAvRBEnYJXzY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=meLMLBEboq1XkJ4LjaQlZmrvV/WRR5GmtaRn2WU9B4IYgFwIf6ee50xfCIelTdnv9bxgrIyWfZ2wpMjiqlDQQEI1yOBcgIj86aLy1nT/Ovjo4fZ5QPnw1P/r0Rw4osx0nTQ2CBWq9TgmxaAZCDkbwppgh8kgJyUfsYFJqAsLwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qwu/xyiT; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.162] (BC24936A.dsl.pool.telekom.hu [188.36.147.106])
	by mail.mainlining.org (Postfix) with ESMTPSA id EACCEE45AB;
	Thu, 31 Oct 2024 01:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730337586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AkP+23CR80b6ke8LAz2t64yf9SpQeLZtdkWj6Uov1LA=;
	b=qwu/xyiTEmQ9n3KZMkdcThGxtDFFh72Sd1GRz0N88ogDbTRLabHaHE5tO+jrFBC+DcYEbl
	tIYwUwdTmgJRiJZ/c8f88cGLoagu2C+9bnt6RLZ/BL7+JG1SgR2UTMY1CZd9TuxqBEUIQ6
	hBbfuqksyrIBBlJW+NkGmFlvzQNucrlE1ti4UAHrbAHA4AIjc0ScMfwQ7eB7taySGPl0Cn
	m9MxVB6iKApz5e+SXaQPTZ/fsOqj7mqPbItAjJNsm/J62rs23gpacOWBKVAFkNJVXJKs6z
	wNSv3AH54SDD7qC3/Cx3S1askxV4nCY5Li6xrZ5CvIXeX09s6vOw0IIj97o8gQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v2 00/15] Add MSM8917/PM8937/Redmi 5A
Date: Thu, 31 Oct 2024 02:19:41 +0100
Message-Id: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC3bImcC/2XMSwrDIBSF4a2EO67FaxJiOso+SgbiKxeqKVqkJ
 bj32kw7/A+H74BsE9kMt+6AZAtl2mMLcelAbyp6y8i0BsHFgBxnFnKQM04MJ90b7tygRgHt/Uz
 W0fuU7mvrjfJrT58TLvhb/42CjDOHrtcKjZR2XIKi+KBI0V/35GGttX4BfzZofKMAAAA=
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Dang Huynh <danct12@riseup.net>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730337585; l=2793;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=7dZsRjpgvzq99Vps+KUUhV2OvVoGHjcdAvRBEnYJXzY=;
 b=9V77oYZF4/Yq2CmGGYxDC4tV2KWT0Qjwd8/v7772iNZBLftlgJaU3Ou++pPOO03sCx3VQRTUk
 UoyDmDj6YOKDO/g6oLATh1XgTg2pHFqZXIWb3gs15cNuvqrJm63cvfM
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v2:
- Add msm8937 tsens support.
- Fix issues addressed by reviews.
- Link to v1: https://lore.kernel.org/r/20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org

---
Barnabás Czémán (12):
      dt-bindings: pinctrl: qcom,pmic-gpio: add PM8937
      pinctrl: qcom-pmic-gpio: add support for PM8937
      dt-bindings: pinctrl: qcom,pmic-mpp: Document PM8937 compatible
      pinctrl: qcom: spmi-mpp: Add PM8937 compatible
      dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl bindings
      dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8917
      dt-bindings: thermal: tsens: Add MSM8937 compatible
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
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../bindings/pinctrl/qcom,msm8917-pinctrl.yaml     |  155 ++
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    3 +
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |    2 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts   |  293 +++
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1999 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  216 +++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    2 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |    1 +
 drivers/thermal/qcom/tsens-v1.c                    |   13 +
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 20 files changed, 4327 insertions(+), 1 deletion(-)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


