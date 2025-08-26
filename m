Return-Path: <linux-pm+bounces-33084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1BB3552E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 09:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CC8167703
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA82D0629;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us5ImE58"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614B23D2BF;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192717; cv=none; b=jxIkXyuy+NElj1oP5b/7S5XssNlNk//igRioCh0sukaqA5HHHjgcpREZoGwjxJk1L5VEYl7e8vNoicP5MuWCbI5x91z7au/bCHbYHdOn9OcDA0/HB1sedtIVYNTO4JwGPymhYk0qkk6BbMroyFHLy/pwpflVDkjTS7B+9JML9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192717; c=relaxed/simple;
	bh=1bEUIqbwLDzhfj/xPCZr0TVilOMdMwgwUhKvUU4pTss=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YKxCdf4mdynEkwrKEzq78YcLm9MlBZOHylj2bzXOgcjPX+Jz0Mh7Grj4UblvhzhAZdpFRcczHRoLdLyo07Gpm1g4rLT20nEbp5pGqTXCt/3fKg1iWt23QF2Mw8zNZO1h4jli0BKTL6dxJGYKT2VvifAQS6y2AIv346fhbKwk/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us5ImE58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AF87C4CEF1;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756192717;
	bh=1bEUIqbwLDzhfj/xPCZr0TVilOMdMwgwUhKvUU4pTss=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Us5ImE58r+yUHGD5UrDEyiu7vqiYuSWbaPrrzBilohfwRGfWLsnlo6lDPPijWXHnJ
	 pDL5SxIYmlhrO7lrJbqomfs/YkLy18zVFjeVCH3g3D95Nmolbdc7kFoEj1K/m3tFaD
	 5U4sfybcUwI9xqmdJTQAYoTuhnMD3VQLl/dWqw0baFZzXddckhWbNsE5EzYiS1v6Xq
	 +9wb1qjr+vQp/BnG0xt/oQwd9Qub3bSZdVpGrYox7GKKNGw0ngUyUuFAg46elexYr+
	 Gl9vRuoVDe1zkbbKwNc6xNt8qdMCyvvvcQYrZjwKq570gINouZO+ad6HY3U0wvd3QU
	 X2FH7UhI8MpdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D77CA0FE9;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Subject: [PATCH v3 0/8] power: supply: Add several features support in
 qcom-battmgr driver
Date: Tue, 26 Aug 2025 15:18:27 +0800
Message-Id: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMNfrWgC/23OzQqDMAwH8FeRnlfpx1pxp73HGFLbTAtz1baWD
 fHdV4XBDl4C/5D8kgUF8BYCuhQL8pBssO6VAz8VSPfq1QG2JmfECBNEMIIn7YamVTEOnW/m0ag
 ImAtJjRZMaiJQ3hw9POx7V2/3nHsbovOf/UiiW/fn8UMvUUwwa1tpzkCUkHB1IZTTrJ55eChzQ
 Rub2B/Fj19LLFM18KqiNVdSyANqXdcvQAWPLAgBAAA=
X-Change-ID: 20250520-qcom_battmgr_update-3561dc526c05
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756192715; l=4089;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=1bEUIqbwLDzhfj/xPCZr0TVilOMdMwgwUhKvUU4pTss=;
 b=wO/b1NhAiQ3HkyQBnOSotfw2AX4bRBUPRQDCyNksFGTYEuFDK8o3eGTobVg2J6MMmZL5CHmj2
 /DoJKOJCjIeBy4megS9gfXWqPR5x+hs3WQa4jOW2mTI09eJ6OvCwyyT
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

Add following features in qcom-battmgr drivers as the battery management
firmware has provided such capabilities:
 - Add resistance power supply property in core driver and qcom-battmgr
   driver to get battery resistance
 - Add state_of_health power supply property in core driver and
   qcom-battmgr driver to get battery health percentage
 - Add charge control start/end threshold control by using
   charge_control_start_threshold and charge_control_end_threshold power
   supply properties

The changes have been tested on QRD8650 and X1E80100-CRD devices based on
qcom/linux.git for-next commit a679f3f6931cdb0c2ef5dc0c26f895ae3f6c1ddc.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
Changes in v3:
- Change power supply property "RESISTANCE" to "INTERNAL_RESISTANCE" and
  update the ABI document accordingly.
- Update the ABI document for "STATE_OF_HEALTH" property to explain it
  better.
- Drop following patches, as they were made due to my misunderstanding of
  the compats fallback behavior. Thank you to Krzysztof for the correction
  with patience.
    [PATCH v2 6/8] dt-bindings: soc: qcom: pmic-glink: Move X1E80100 out of fallbacks
    [PATCH v2 7/8] usb: typec: ucsi_glink: Add UCSI quirk for X1E80100 platform
    [PATCH v2 8/8] arm64: dts: qcom: x1*: Remove qcom,sm8550-pmic-glink fallback
- Addressed several comments in [PATCH v2 5/8]:
   - Separated the compat string addition change
   - Fixed the coding style issues in several places to address this
     checkpatch error:
       "CHECK: Alignment should match open parenthesis"
   - Add logic to read charge control thresholds from SDAM registers in driver
     probe. It addresses the issue on X1E80100, where there is no interface
     to retrieve the thresholds from the battery management firmware after
     boot-up.
- Add a DT binding change for charge_limit_xx "nvmem" DT properties.
- Add a DT change to specifiy charge_limit_xx "nvmem" properties for X1E80100
  devices.
- Link to v2: https://lore.kernel.org/r/20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com

Changes in v2:
- Corrected "qcom-battmgr" to "qcom_battmgr" in the commit subject of
  patch 4/5.
- Added charge control support for X1E80100 platform in patch 5.
- X1E80100 is no longer a fallback of SM8550 in pmic-glink battmgr support,
  hence added patch 6 in the pmic-glink binding to move X1E80100 out of the
  fallbacks.
- Added patch 7 in glink-ucsi driver to include UCSI quirk for X1E80100
  platform
- Added patch 8 to remove "qcom,sm8550-pmic-glink" compatible string in
  x1* board files.
- Rebased the changes on qcom/linux.git for-next commit 44ef9ab4baaf496d227ab98d368016700f0b9300.
- Link to v1: https://lore.kernel.org/r/20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com

---
Fenglin Wu (8):
      power: supply: core: Add resistance power supply property
      power: supply: core: Add state_of_health power supply property
      power: supply: qcom_battmgr: Add resistance power supply property
      power: supply: qcom_battmgr: Add state_of_health property
      power: supply: qcom_battmgr: update compats for SM8550 and X1E80100
      dt-bindings: soc: qcom,pmic-glink: Add charge limit nvmem properties
      power: supply: qcom_battmgr: Add charge control support
      arm64: dts: qcom: x1e80100-crd: Add charge limit nvmem

 Documentation/ABI/testing/sysfs-class-power        |  31 ++
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |  14 +
 arch/arm64/boot/dts/qcom/x1-crd.dtsi               |   2 +
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi       |  20 ++
 drivers/power/supply/power_supply_sysfs.c          |   2 +
 drivers/power/supply/qcom_battmgr.c                | 316 ++++++++++++++++++++-
 include/linux/power_supply.h                       |   2 +
 7 files changed, 378 insertions(+), 9 deletions(-)
---
base-commit: abbf1025002e4966bfcbf8a069234e485d49edf1
change-id: 20250520-qcom_battmgr_update-3561dc526c05

Best regards,
-- 
Fenglin Wu <fenglin.wu@oss.qualcomm.com>



