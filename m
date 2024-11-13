Return-Path: <linux-pm+bounces-17486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686139C75C1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A4328652E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6C314EC47;
	Wed, 13 Nov 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ITqZFWFH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4F143744;
	Wed, 13 Nov 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510710; cv=none; b=LYz/AY9Ztz0Tuba3mL46qYQVO8ZDGqvyQz80VK/31HQ9mspKmkxvMPlJ0BVZNUHOaaAg8zCn/0Xg/0JOS95sBrwpHVs+1U5XbKzgO+9/3sXq8nGF5eizjQOd6JIfL77qzVKS55vCscXp9eOKZc9uDPNeRX7xmRhw8l/7Ojn/JFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510710; c=relaxed/simple;
	bh=SxPeim2Wg91I0hqTjDSKvwB21t0C5xwCY7RnDmywC0k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=msK0v9oUSb2NEpqNhFIwVVwNxqxIak54SSQ6nCChoaNcCsuGvTYYDsW+mQxv3aIP7+Hi4d/zBN/PLg6+OIL3ulybF8x3N5j1TcK26j4NECQZ3/DIn/X8Yzz41qSoOymmAjbugIoXHEPUG2nmXxOmBNRfeQduJuB6/9Jt/M1kvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ITqZFWFH; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.93.162] (254C230F.nat.pool.telekom.hu [37.76.35.15])
	by mail.mainlining.org (Postfix) with ESMTPSA id 472E4E44EA;
	Wed, 13 Nov 2024 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731510706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d7uPVLGK6p97SLzdxgBRA3CM2p919mN7k2z2OJuofo0=;
	b=ITqZFWFHGmwWtdqrODcX9xYU4wvfkZyTog62NSL2IZ5rItZwnRO6UTDVKc9ainPUegJHSe
	KoKIvmpCUPKobU/TAP37SgaUXaGd8oqR/UtP6JOyoKqjt8Ll2Bhedc89obzuuSTVWmV89j
	+OJybl01ZXgUYRrtauRHnQqyg56vOMAsy2zrGG0ugRv97piwC9DtB4t1gdIr+NZdncroZT
	nvHpU8i5FHKxVa2sEJ9Yg13OlISEBTc1v5AcynpiDw5y3q0RdNV915JxYVJ0X07w1XoDf3
	iFUJUl/fM15CPb1YbagEi74jU3EvV3rLp9WsBb2ShAJSW2OFj9MUlIQboZniGA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v6 00/10] Add MSM8917/PM8937/Redmi 5A
Date: Wed, 13 Nov 2024 16:11:41 +0100
Message-Id: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK3BNGcC/23Py27EIAwF0F8ZsS4V5jFAV/2PqguHR8ZSQyqoo
 laj/HvJbBJpsrwW5xrfWUuVUmNvlzuraaFGc+nh+nJh4YZlTJxiz0wKqUGA51ObnAfLwQYVRc4
 ajWT99XdNmX4fTR+fPd+o/cz171G8wDZ97liAC54hq4AQnUvmfUIqX1SojK9zHdlWtMgDVrBj2
 bFDYU1GdH6AU6x2DMLuWHV8jTEYDNFbN5xifcSHb+tt85C8F9p6iefYHDDIHZuO+8FKR6XAwzN
 e1/UfKZZnk5cBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731510705; l=3660;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=SxPeim2Wg91I0hqTjDSKvwB21t0C5xwCY7RnDmywC0k=;
 b=R6SP5fDM9Iq8w0TzGSCCXC0A59sc1Hj5Bz9dYklvds64AQNDYoOGdXVK9uvTbANLUtMbuhLQv
 F8XNXn6PRiPC0ZelfOEklcbPtVyWDx2S5gkH5pH6yn0Pcz1nggTZWvM
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
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
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1946 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  152 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c                    |   21 +-
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 15 files changed, 4211 insertions(+), 8 deletions(-)
---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


