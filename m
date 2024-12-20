Return-Path: <linux-pm+bounces-19613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A29F9D20
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 00:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CC518927A0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 23:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF88227B8E;
	Fri, 20 Dec 2024 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="h6A/XROA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256F2253EE;
	Fri, 20 Dec 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738071; cv=none; b=scidBKcAYhaQQT7gOQG1oZMwiAIsnkG8HwFv+CvmnC64k9LMDx0NLZerhtdhTJoksZKSLdvxBa8mxUraOWAzam+qozJ7AF2IIhenuUDJjDLLTSbjz/HDmIUUSg4ZITh0PBII0ZWfsuo0VZTFP+R26JSxkaM25z34D91gE0Gh3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738071; c=relaxed/simple;
	bh=sCXu2gmOdDmbBFG2lCJY1mdmHIob9H6tgLAI1ct5784=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OjyP11OMfIytwW0z3lvFpmNiF1fnwjYx8qXheWN+6dbXaQyzMOObu7Ck1l39KtZUchPNkwOSZtcicPw72LwJtxK3gh/82oHaK633zoXvvC59y/Dz9MOGOIJezbwz6jgTnITNQnv9ibWD3rvB9LbtTukFBwaG7KA8q/JHPI5QBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=h6A/XROA; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.30.162] (254C14D2.nat.pool.telekom.hu [37.76.20.210])
	by mail.mainlining.org (Postfix) with ESMTPSA id ECF22E450C;
	Fri, 20 Dec 2024 23:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1734738066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ppnPh7QXZxj5t1x0IJTETaaoJaoVwNkQB1J6Xh3LMLA=;
	b=h6A/XROApXQH93eEbOYiw3GxRCkH9rNMLv8bK4++Z5kuMsKX6UPoq99CWH3X+dyveaTL41
	K2v7fVf+o8pcLqRQ9xR+I94YtAZ+hTSU3k6VPxCQosFRS8ZVyAw1i27tG3onRwdK8PTrcU
	H+F7rcn9u+T51h1S1vBcgEaXo3reWiCSWYGHNQJVnjxq9Upo2HI/TVSzvGCoPe4qgemyTr
	VZsX2GDG4Vised+UdNCuIm04bMeMvJKSA8QQg19MKA4+TzZZ672Z8y4TvThnqHuNmXk/vA
	ptpgYE2u2raHA1196VftZBbrfUlB8EaVchZYJER3oOMjkKjK9RgO9pa/PM5mPQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v11 0/4] Add MSM8917/PM8937/Redmi 5A
Date: Sat, 21 Dec 2024 00:40:47 +0100
Message-Id: <20241221-msm8917-v11-0-901a74db4805@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH8AZmcC/3XSzW7DIAwA4FepOC8TtiHATnuPaQeHnxZpTatki
 jZVffeRXkAqO9ri85+4iTUuOa7i7XATS9zymi9zCQBeDsKfeD7GIYeSEChRgQQ3nNezdWAGMJ6
 CTEmxRlFeX5eY8s+j1MdniU95/b4sv4/KG+zZ5xobDHJIkMgzBGujfj9znr/ynOfj62U5ir3Qh
 g0mqBgLtiyNTszWTdDFVDFIUzEVPIbgNfvgjJ26WLW4GVvtnafonFTGIfexbjBgxbrgsjCpQAQ
 O+nhsMVU8FuxJ2TRp51JMXWwajKpis+8MaNBZUqMeu9hWjNBc2xYMzrD3UqGkPnYt1hW7gif2z
 Dgmiv+MDbLRKJtfIveTBW1IReuJn3vf7/c/QL8kSssCAAA=
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734738064; l=3702;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=sCXu2gmOdDmbBFG2lCJY1mdmHIob9H6tgLAI1ct5784=;
 b=QCWVBYLdt3QvrsE5+KfOkicwOiW0qnMskDZ0SiAZ2/8EcVKyDkMh4BnJydOaWPqobK7F/tbeH
 3G9875JKZfZCSgJAgq41T3ZucCKBt8rM9uqjfiJrJQ8kw8yb7klMZ5S
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

This patch series add support for MSM8917 soc with PM8937 and
Xiaomi Redmi 5A (riva).

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v11:
- msm8917:
  - pll_opp_table: fix indentation
  - gpu_opp_table: change to ascending order
- Remove applied patches.
- Link to v10: https://lore.kernel.org/r/20241220-msm8917-v10-0-3d5734e8c3a6@mainlining.org

Changes in v10:
- msm8917: sdc1 cmd_on, cmd_off change bias-disable to bias-pull-up
- Remove applied patches.
- Link to v9: https://lore.kernel.org/r/20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org

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
Barnabás Czémán (2):
      dt-bindings: arm: qcom: Add Xiaomi Redmi 5A
      arm64: dts: qcom: Add Xiaomi Redmi 5A

Dang Huynh (1):
      arm64: dts: qcom: Add PM8937 PMIC

Otto Pflüger (1):
      arm64: dts: qcom: Add initial support for MSM8917

 Documentation/devicetree/bindings/arm/qcom.yaml  |    7 +
 arch/arm64/boot/dts/qcom/Makefile                |    1 +
 arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts |  333 ++++
 arch/arm64/boot/dts/qcom/msm8917.dtsi            | 1954 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8937.dtsi             |  150 ++
 5 files changed, 2445 insertions(+)
---
base-commit: 8503810115fbff903f626adc0788daa048302bc0
change-id: 20241019-msm8917-17c3d0ff4a52

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


