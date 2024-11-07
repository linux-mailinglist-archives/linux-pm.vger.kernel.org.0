Return-Path: <linux-pm+bounces-17126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C89C0C1D
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 18:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E2283B06
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA91216E03;
	Thu,  7 Nov 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="q/tns1f+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC920FAA1;
	Thu,  7 Nov 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998981; cv=none; b=Cpg58O/GZAvRurXSYgV+/DDh3i8db1dfHS4d83/cFxigRn41BgBzapgvKWDzP+wjUBKeXxoDLRHsfpaK+Gf/2j4VrHb7i78K9sUPtZTQiHRnOz2uEvQXiUqcXnLWqV9O3xGc11oqXTo2l56Owtq1cavqVSPYj1M/dA4WUs5bvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998981; c=relaxed/simple;
	bh=sWowJxNGrnVM2AVICTZnLfr261T7nk89aqIuCGrDuOE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=klUmxGB/oR9OeU/ziYFyqPqPOwVvKlPT0M4ZqRPMQA5M03s1hBY3cDxK1yc0YDp+tM+hBp0eUEUp1na9PFqmevFkzJcmcxXh0aJOWtnVANEmd/0nkbJ4owabQbHxXyxqop6J6yVLuFALr40Ced+S0VI60f6Q4jVba7RVK52DRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=q/tns1f+; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2715.nat.pool.telekom.hu [37.76.39.21])
	by mail.mainlining.org (Postfix) with ESMTPSA id 50F47E45BA;
	Thu,  7 Nov 2024 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1730998971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z8L0WOA8oUOrV1RaIivpMP+QvLSVaus+xjKsdJ38WrE=;
	b=q/tns1f+0ZOZq3TQkNTThU+YACL1GeXJvEAOmyMoetebQCVf1cwBWEQmiXxpx6apLgM5YE
	Fur6Jpg/zEOe3MF69WCHkPUO+jP26QDisGWeRKOGe8vd0Jw14fQh19GHyUTvMWzIK/Jr7B
	bnWTZhjkJFwxfWL6wJuIkcXMf53c3F4Rm9EYiYRrbhIRNDOKXpOY8RFTqcSlDeE9Bu5ntx
	BOZD771mVC8TYB9Z2hnsZu+xuiYQ7jgB/++OxCT1P+Bdtx2Yeq3XavKyj1yv0a2+2F4fBi
	cbgAqsqfjd/dKis7F2nC+3oG9DOpviP7rR9Yn3hbia+4RmOLsg3ePUxphexTdg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v3 00/14] Add MSM8917/PM8937/Redmi 5A
Date: Thu, 07 Nov 2024 18:02:41 +0100
Message-Id: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALHyLGcC/2WMQQ6CMBBFr0JmbU2nhVBceQ/jYoQWJpFCWtNoC
 He3sNGE5fv57y0QbWAb4VIsEGziyJPPoE8FtAP53gruMoOSqkSJjRjjaBqsBdat7qRzJVUK8ns
 O1vF7L93umQeOryl89nDCbT02EgopHDrdEnbG2Oo6Evsne/b9eQo9bKGk/mSNP1ll2ZCsK0dkm
 gce5HVdv8ggGCzgAAAA
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Dang Huynh <danct12@riseup.net>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730998969; l=3029;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=sWowJxNGrnVM2AVICTZnLfr261T7nk89aqIuCGrDuOE=;
 b=lrq/NpJWxQngDNkabbUmfryvThLywtOn6/VUppCCwfShY5BK40F0UxYqIKvW6czXrhPE58fUv
 7awH/2+qr2sDIteGWPNiQGnpPC4tqi03RhvVDYR1CUWrB2Nx9UWtdFD
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
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
Barnabás Czémán (11):
      dt-bindings: pinctrl: qcom,pmic-gpio: Add PM8937
      pinctrl: qcom-pmic-gpio: Add support for PM8937
      dt-bindings: pinctrl: qcom,pmic-mpp: Add PM8937
      pinctrl: qcom: spmi-mpp: Add PM8937 compatible
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
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |    3 +
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |    2 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts   |  297 +++
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 2007 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  152 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    2 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |    1 +
 drivers/thermal/qcom/tsens-v1.c                    |   13 +
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 19 files changed, 4279 insertions(+), 1 deletion(-)
---
base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


