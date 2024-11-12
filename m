Return-Path: <linux-pm+bounces-17429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CB9C5C51
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A2F28415F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C0520370C;
	Tue, 12 Nov 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="HLWjNDjm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328C202652;
	Tue, 12 Nov 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426588; cv=none; b=Mx17NHtX0r7ZHp0buGWd8yYzIhvJNPVj7jjag21OYwaUTnIfoi6zEzZYb3gzXLHFF9dtK7oDldf5l6qxfaNKwWju07TJNZ2k32VF0IYlzpTLUyrEvYPeCh2HKz1+mBM4Ag3FC75lEy3PrggrO3WoZrXwi0piHJ+PeTYbIVe6EZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426588; c=relaxed/simple;
	bh=o+bLyPhu3w+N/hvDM9vKce7HeWdpAdo8lJzvKMuwlo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wt80F5IgoEsIEKsxa2JWjXRK2LDvzOY8EyU4XdSizHmPnygbRRLus5SDf5eSfCWiJXd2fn+APHLtOg2WNtMFxQleEwXgYieZ8Z3nvPX19G4Hd9SaMTVAC0tIRP8SsNEHy7p+k3yqTXMtiZG+YzUyxKK8GuEQ9nu9WQwqAmJuHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=HLWjNDjm; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.93.162] (254C22F6.nat.pool.telekom.hu [37.76.34.246])
	by mail.mainlining.org (Postfix) with ESMTPSA id A5115E45C8;
	Tue, 12 Nov 2024 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1731426578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qu//iSPzUBdNgP61SB2krwbvYfULdUWHcbv4ONQcf7g=;
	b=HLWjNDjmV+4OZmWRSvsccwf5+xCS4gY7x1pmYvSnCJy7LiQfsFGDmsdeRlnx+gnSRmJq9G
	1xnScc6RDaoyP2rtZtOx+lGsyb9kb7PTsESyXpr4o92BdTv0r379jfKnnCqIKFGfDRRILi
	okSVHlRFtUsVX06grOQhPXNlv9MKrDsNZK8QdqyksRT6H92CXdauRT9ryAxqAkgc3x8hLv
	J0rSR7ikiFFYDT0AbLkeABwOJievzJUiSse6y8MhLaIK5ZDGdgXYsJF6YAdnIq7ncQYDZr
	kz3NwpPBHgzCeW9Jb7RVnKuDqgjI9JoUQg9u0wuihhGSg39yD0xr4viw9533yg==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v5 00/10] Add MSM8917/PM8937/Redmi 5A
Date: Tue, 12 Nov 2024 16:49:30 +0100
Message-Id: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAp5M2cC/23Oy2rDMBAF0F8JWldFo0clddX/KF2M9XAGajlIx
 SQE/3vlbGxIlneYc2furKVKqbHP053VtFCjufRg3k4snLGMiVPsmUkhNQjwfGqT82A52KCiyFm
 jkaxvX2rKdH00ff/0fKb2N9fbo3iBbfrcsQAXPENWASE6l8zXhFR+qVAZ3+c6sq1okQesYMeyY
 4fCmozo/AAvsdoxCLtj1fFHjMFgiN664SXWR3x4W2+Xh+S90NZLfMbruv4DZvkLZFoBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731426576; l=3290;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=o+bLyPhu3w+N/hvDM9vKce7HeWdpAdo8lJzvKMuwlo8=;
 b=Pu1mi9W2VcF8ZrGc4N9x0/wzvJt5pszAXQYfcfDZ3zIqNAGK0UVo0o9JufythIXzVUmEUY7ym
 WhG27o9DB/9Duh/GwJTet/kyXprt+HVIUkfz3vOmt6ZdwgTrUhJB3Y6
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
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
 arch/arm64/boot/dts/qcom/msm8917.dtsi              | 1974 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi               |  152 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    6 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c             | 1620 ++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c                    |   21 +-
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 15 files changed, 4239 insertions(+), 8 deletions(-)
---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


