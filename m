Return-Path: <linux-pm+bounces-19249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021899F234E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D5C165B13
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C81714A1;
	Sun, 15 Dec 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="tUKwtUL8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320231FDD;
	Sun, 15 Dec 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734261342; cv=none; b=APPya0XhOrn2p/IxC3gCWPQ40IzVjVHGYgvfoIhnkJ8lcWyKCj9iFyLiG2uBM5y1RNawf8zcCbM6SYmt9EtMAb5+XTmA5ea1CIZDXAP/Wg//W7d4eOr03ccwIdqDsF/4rP6f/ToR6olSa15BmqdLWQrORYZ2RvN7i4ZYXQcf85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734261342; c=relaxed/simple;
	bh=ueQt5GwccAwwxJiXpF97XX3QBwSEJKPeC0KGi9CgjIM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e/BnV2XQ6Iiop7cY90xraKKFcpRNHbXwGRFe1DcI06Z/sYf1asmt+HKw5G5N76ezOzLkKlRJ4qePw3lJYP8iE28cCMJoOo3guM9RsL7S70WLlHLTQTMoqxiHYD9bW7ZYwZnZKDCK1XP8x6RaikJ5cLMv1ZdfRKzv2O+G+0CMO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=tUKwtUL8; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.0.220] (catv-176-63-31-221.catv.fixed.vodafone.hu [176.63.31.221])
	by mail.mainlining.org (Postfix) with ESMTPSA id E53C4E450C;
	Sun, 15 Dec 2024 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1734261331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+yiA/1ghe5hls2YFXRWo/fisaXESDHjsJbo7HIiQ4wI=;
	b=tUKwtUL87+qNhrSB2H7rGx3H1UJ3DvbUMs9ZSnSHsI98MiMTacxpYONGYFufmfVDrAXloG
	4EcWZ2Fs5f05s6S46oVfdgjNM38eW5qvvs7NHmSrd2uKboOfkEvNZw+i/y+FlDDzCYrv/G
	cjZ407M5/X4r/1l776ZPhHxk6FJ7gqGKCzF1mfC0ZgU/XLUeg4tVo+dC78YfQbUpNvuSH3
	rweqphol2fUWn3PLj61x82SjriB0OV6l2YTdhHqO4DoByvXKeVYEzX2K6BAU/mtfMkGxNv
	pa5+4dhkIK6o8AXN6RVwwHpp5N/MJ2VUZ/MetzTegZ/lroeJFA4jCfpEFD4w8w==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v9 0/8] Add MSM8917/PM8937/Redmi 5A
Date: Sun, 15 Dec 2024 12:14:55 +0100
Message-Id: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC+6XmcC/23QTW7EIAwF4KuMWDcVtiHgrnqPqgvCTwapk1RJF
 bUa5e4lswFpsnyI74F9F2tcclzF2+UulrjlNc9TCfxyEf7qpjF2OZQsUKICCdzd1ptlMB0YT0G
 mpJxGUW5/LzHl30fTx2fJ17z+zMvfo3iD4/S5Y4NOdgkSeQfB2qjfby5PX3nK0/g6L6M4ijZsM
 EHFWLB10ujknOUBTjFVDNJUTAX3IXjtfGBjh1OsWtx8Wx0vD5FZKsPozrFuMGDFuuAyMKlABAz
 nuG8xVdwX7EnZNGjmFNMpNg1GVbE5ZgY0yJZUr/tTbCtGaLZtCwY2znupUNIz3vf9H/XZzC9OA
 gAA
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734261329; l=3901;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=ueQt5GwccAwwxJiXpF97XX3QBwSEJKPeC0KGi9CgjIM=;
 b=JhHMPr0XuLwNjNgZJzMxdMA9wdY0yX8FIeM1K4zaedAMGucxz4G4eRF06Np3FkhElNgxw0s1U
 iLoiGhUAseCCKE91Xe86atdO2sSSS/kvtXlBzCxSIBkAPoR4T2/1yjd
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v9:
- msm8917:
 - add some empty lines for separating pins more
 - order compatible, reg, ranges properties
- Link to v8: https://lore.kernel.org/r/20241211-msm8917-v8-0-197acc042036@mainlining.org

Changes in v8:
- pm8937, msm8917, msm8917-xiaomi-riva: remove unused includes
- Link to v7: https://lore.kernel.org/r/20241124-msm8917-v7-0-612729834656@mainlining.org

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
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts   |  333 ++++
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1954 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  150 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
 11 files changed, 4234 insertions(+)
---
base-commit: 1b2ab8149928c1cea2d7eca30cd35bb7fe014053
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


