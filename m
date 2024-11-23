Return-Path: <linux-pm+bounces-17989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F59D6C18
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 00:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A360A281682
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4BC1AC44D;
	Sat, 23 Nov 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="cOKhxZfg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541A157A48;
	Sat, 23 Nov 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732403630; cv=none; b=flXl6jV4YYIroQUk0JV+4mYcIeYAAqu5CJuObcePILHMB1j50grfrmjDH2+94ONVuxzDSU69AXWpUFZFfYK2beiFYA7kZO7K39aKUP4BlxMFgRWuPKH+OyWdFcp8PjxFVyKjeAIWM4DxYGONNfIVGZyVQVdaTDEuJ8J1pLv7vlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732403630; c=relaxed/simple;
	bh=hmKsj1Kmoig7skxnuCJnziJWFkrnNUegWisx4nPcWxw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TMds6sPXWLIsy7qtr3fvXbtAJlApG8kxBLAWCMnM+8SYMDq+LuqhhZLgzpgP1+exFRbhPHR7HDs1AlvYYFSk1pDgDXZOXZJERiheWi9jMOiVhAIqoXc6k9v1IKTDPPfPwMy0wDBYsp+gAGGJkB/pePXZ0XuEWiHYkz0cisfxUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=cOKhxZfg; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.149.162] (254C22A6.nat.pool.telekom.hu [37.76.34.166])
	by mail.mainlining.org (Postfix) with ESMTPSA id 5995AE47FC;
	Sat, 23 Nov 2024 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1732403618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A1IjIuzmePlBChypxgkUHW8StKqlREwLvjwJVP3i4Ek=;
	b=cOKhxZfgFJojLAMDVs/awBa7CV5zJr4zsoYskwrXwpPwfBOsdZT/2GSVQhTxVak9o4e90t
	u6a8ICRiArSNd31wWh3ziYzP5iyT41jIMmtZCONuB3C+VgDGhaIwG5ToeafRrhttjr/VjW
	XZEjcRyKKG3FU5iJ5LJ2qep1DCU3cUBYhJCJx09f7Pt5/FSe+EeI5FCn9usNapgQdPkbeB
	eX/MELP1orenFn54unnOpu3JJRsJltsx9y9PSlodbMHBsiFsujaF7d5N+rNBDLBuaezHO8
	MzWPJFSDSRurkPBwuk1UdZYKeN0RAb8hZM7iWgs/B2hakjFP+g34GPP3c8SeVA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v7 0/8] Add MSM8917/PM8937/Redmi 5A
Date: Sun, 24 Nov 2024 00:13:18 +0100
Message-Id: <20241124-msm8917-v7-0-612729834656@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI9hQmcC/23Py27DIBAF0F+JWJeK4WGYrvofUReYh4NU2xVUV
 qrI/16cDUjx8o44d5gHKSGnUMjH5UFy2FJJ61KDfrsQd7PLFGjyNRPOuAQGSOcyGwRNQTvhWYz
 SKk7q658cYro/m65fNd9S+V3z37N4g2P62rEBZTRCFM6CNyaoz9mm5TstaZne1zyRo2jjHRbQM
 K/YWKZVtNbgCKdYNAxMNywqHrx3yjqP2oynWPa4+7Y8No8BkUmN3J5j1WHgDauK68FCeiEA4Rw
 PPRYNDxU7IU0cFWIM8QXv+/4PAKU0CtQBAAA=
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
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732403617; l=3512;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=hmKsj1Kmoig7skxnuCJnziJWFkrnNUegWisx4nPcWxw=;
 b=vA+xSz4h4tyFicz58+tYzZHvNNNw0ti/c9/hgSTBLLzGxjWONwTmdsJA7ERGqgAyC+StMCrko
 QcQHAYPLAESBQY0V7d8XAa0/XJ+F9Riq1E291IPlthiOxPZ+6nn85rd
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v7:
- msm8917-xiaomi-riva:
  - Add pinctrls for used GPIO pins.
  - Use interrupts-extend for charger.
  - Order properies.
- Link to v6: https://lore.kernel.org/r/20241113-msm8917-v6-0-c348fb599fef@mainlining.org

Changes in v6:
- msm8917:
  - Consolidate SDC pins, remove sdc2-cd-on/off pins.
  - Remove cluster-sleep-0 and cluster-sleep-1
  and rename cluster-sleep-2 to cluster-sleep-0.
  - Fix spi, i2c and related pinctrl namings.
- msm8917-xiaomi-riva: follow i2c name changes.
- Link to v5: https://lore.kernel.org/r/20241112-msm8917-v5-0-3ca34d33191b@mainlining.org

Changes in v5:
- msm8917:
  - Remove aliases.
  - Rename spi, i2c labels and pins.
  - Remove clock-frequency from timers
  - Remove unused mpss_mem region.
  - Use mboxes where it can be used, only smd-edge uses qcom,ipc.
- msm8917-xiaomi-riva: Follow i2c label changes.
- Link to v4: https://lore.kernel.org/r/20241109-msm8917-v4-0-8be9904792ab@mainlining.org

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
Barnabás Czémán (5):
      dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
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
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts   |  335 ++++
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1946 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  152 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
 11 files changed, 4230 insertions(+)
---
base-commit: cfba9f07a1d6aeca38f47f1f472cfb0ba133d341
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


