Return-Path: <linux-pm+bounces-19056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A1D9ED462
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFC16727F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 18:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01174202F9D;
	Wed, 11 Dec 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="O7k1Zazs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAEC1DE4C8;
	Wed, 11 Dec 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940287; cv=none; b=HUZpFtIGqToAGdBoXRtMus4Rh5XHmJG7V7zTakaDGeqLKHs/7lNnB+r10V+335yr0weRn25hFvRD8wue9UI1D1b7TVcB0Ax2OlDmPABx93JL3p00VN/OvUIbxi5NxIyiurJYwBmYJrO12EdkkXEtCRsy7ODiY98HTqOVXPDRlG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940287; c=relaxed/simple;
	bh=l94BK7mrqrW7wfB86W1pvJPZMlYxTL4bfJJgI4EhRVQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D737FP4bGt//0vnxDeNMCUNConCof1L/YVXtxpR5m3nknAAey7tUWQgvKikYBtRd4I4tXbeltOtnakalkrHIUtNeXfA3H9kCeOjsLiFC0tRpyhliuPAtc1TnUowfZkv2d+w1IFQ5Qd4Cc+TBmqe7+pWsyE1WbthrM2a3h9Z6r7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=O7k1Zazs; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.118.162] (254C2319.nat.pool.telekom.hu [37.76.35.25])
	by mail.mainlining.org (Postfix) with ESMTPSA id BFA8CE44CE;
	Wed, 11 Dec 2024 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1733939950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AQb1l6P2tQO5E8YgADPihN0HvZV+3EZDBO65HMerFUg=;
	b=O7k1ZazsmnVW8KqgLQWR1tYndN87ZMRb1G6rvZLqC7AWNO1TblfK3J2aJ3rCdFQg1w7I43
	Z09r/5fmOZfTznjhJtgbqQa+Woi9pgX1A5uPyRjxdHHvRj5Tv7MOgStJbbWrJmgpauht5e
	V9tAzk932GZHrDbx5EeuMLtrCZg+PEKmgtVeCgF7E+mhJtI2dpjjm13aYqm/Y+t7majLfL
	gcq9bE+pqWsBOlMfCB4GK40wSOKugig5+JpUTgaEwYohQdJWPerRXoxUv/L3hXCel/Qh33
	lYu8hN5s8STLx/3fczhgC2ph6t+IRBxOyhtB5q2i7UM0vndKiTUTh9yiAx4/Xw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v8 0/8] Add MSM8917/PM8937/Redmi 5A
Date: Wed, 11 Dec 2024 18:59:04 +0100
Message-Id: <20241211-msm8917-v8-0-197acc042036@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOjSWWcC/23PTW7DIBAF4KtErOuKYcAwXfUeUReYHweptitTW
 aki3704G5Di5RvxvWEeLIc1hcw+Lg+2hi3ltMwlmLcLczc7j6FLvmQmuJDAgbopT4ZAd6Adeh6
 jtEqw8vpnDTHdn03Xr5JvKf8u69+zeINj+tqxQce7CBGdBW9MUJ+TTfN3mtM8vi/ryI6iTTQYo
 WJRsLFcq2itoQFOMVYMXFeMBffeO2WdJ22GUyxb3HxbHpuHQMSlJmHPsWowiIpVweVglB4RCM5
 x32KsuC/YoTRxUEQxxFOsGyxkxfq4GYQWZFD2qn/B+77/A+i7qgMRAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939948; l=3685;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=l94BK7mrqrW7wfB86W1pvJPZMlYxTL4bfJJgI4EhRVQ=;
 b=R633mGFXByhKcb6oYnzij7wzGsygYNA9ivAfglNKI0x1s9HqtWuDx2IWw8tx9a1zMvvCxc3Sa
 IyqzwT7Ae7qAFZYq90Vw5wSb0ga8bUwu+ovbvbdQkRUMcZUbaOVkkOw
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
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
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1944 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  150 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
 11 files changed, 4224 insertions(+)
---
base-commit: 1b2ab8149928c1cea2d7eca30cd35bb7fe014053
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


