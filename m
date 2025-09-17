Return-Path: <linux-pm+bounces-34835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CEEB7E441
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81542188F5BD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9672309EE3;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XghI0ZQL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7E285C95;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104130; cv=none; b=gTpqzD3og4XbhI3YIpr2mfqDuaPyYw0Xik+/C21/+Yf70qIXTRhwsqqElZAp1xF53eArlEE8rhOtQ/XTZHy6VJQc8MJEpzWeg+oClCf48kURJtT8xMJplralEqYSoi9Sm6CH5KGv0em/ypaoKGutAtYKfdNy0aa6p5p39ZWpSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104130; c=relaxed/simple;
	bh=ZEnkXHy+D2pPVN64d5day3gowva0PIG2y1SCGiTVoKw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=adH7tRtLN2po7BUuaccULrlRPS2QqlCESoTgs8vN9XuKwNcRZ2LbrT9OGzoaLDa0NdiqGXu7PQ1yvuf9kjxZdzWWCMgUu6IanITPdrp++36XPTGUKoBuF6U4LeqlZUDuCVl//aVRI5aRi7zFHRdGVQX1fTe3riBcM3FfySJQH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XghI0ZQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D180C4CEF0;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104130;
	bh=ZEnkXHy+D2pPVN64d5day3gowva0PIG2y1SCGiTVoKw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XghI0ZQLdAcMkNG+JgIiuxdN681EQGTU6G883fg0O5PzovIw5IOMDhxDVGCxk3aX2
	 KSkJjmvWfNHabLOv3FodKu+kWe9FCE3MVdWM52A+DHLmoQmFbomN2eHFJ39wIWeeWr
	 /uXTGUPt+0BgQKBoVPL+EiHtHKq5hB7hW2Aph76Tg1VGMYmDAlGoSmlV1lwoC4gVwL
	 029TGr7rSoGSIrK7z4iiWvcyneir/LWSPeE+WewRlJDBN+RNuvghyPyzOqPYZGRW71
	 XSyDQ207zeWTuA+OutqQaIirVfIvDg/4CgS8AM2DA6AZmNcnktGdzeqIJoLc2C2zaA
	 S9KZcHxzvZe2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B80CAC599;
	Wed, 17 Sep 2025 10:15:29 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Subject: [PATCH v5 0/9] power: supply: Add several features support in
 qcom-battmgr driver
Date: Wed, 17 Sep 2025 18:15:13 +0800
Message-Id: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADGKymgC/3XP3arCMAwH8FeRXlvpV7Kzc3XeQ0S6LdOCc9rOo
 sje3SiI56LeBP4l+aW5i0QxUBK/i7uIlEMK45EDLBei3fvjjmToOAujDCgwSp7bcdg2fpqGXdx
 eTp2fSFpA3bVgsFUgePIUqQ/Xl7recN6HNI3x9lqS9fP17dmil7VU0jQNdo6UB6S/MaXV+eIP3
 DysuIgnm80/ypa/lg1TNdmq0rX1CPiFsh/qx2CZskxVjrzTinrtvlHuQ9UaypRjCnt06Fjzfen
 AeZ4ff3Hm654BAAA=
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
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758104128; l=5183;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=ZEnkXHy+D2pPVN64d5day3gowva0PIG2y1SCGiTVoKw=;
 b=qxXGMJXxZy+hCtgMrFU4SHoAp7V5nwY1XnWi2RSWLemLiTNfO+bzgwbl3XIPPPo32Qon/uC81
 GSnHrNQa7EdBUlLR7+08gTx34JtT8dU1Lsak2uUf5Z3AR+CE+O5+h6R
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
Changes in v5:
- Added additional explanation for "state_of_health" in ABI document as Sebastian suggested.
- Removed "Tested-by" trailers in the patches unrelated to charge control feature.
- Updated the copyright statement in qcom_battmgr.c according to the latest guidelines.
- In [PATCH v4 5/8], add "X1E80100" in the "if" variant checks to ensure
  the correctness even if only this patch is applied.
- Format the entries for "nvmem-cells" DT properties.
- Add a new change at last to fix the error messages for unsupported notifications
- Link to v4: https://lore.kernel.org/r/20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com

Changes in v4:
- Address review comments from Maud and Konrad in [PATCH v3 8/8]:
  - Fix the address typo in nvmem cell node name "charge-limit-delta@75"
  - Add a blank line after the nvmem cell DT assignments
- Retrieve code-review trailers
- Link to v3: https://lore.kernel.org/r/20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com

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
Fenglin Wu (9):
      power: supply: core: Add resistance power supply property
      power: supply: core: Add state_of_health power supply property
      power: supply: qcom_battmgr: Add resistance power supply property
      power: supply: qcom_battmgr: Add state_of_health property
      power: supply: qcom_battmgr: update compats for SM8550 and X1E80100
      dt-bindings: soc: qcom,pmic-glink: Add charge limit nvmem properties
      power: supply: qcom_battmgr: Add charge control support
      arm64: dts: qcom: x1e80100-crd: Add charge limit nvmem
      power: supply: qcom_battmgr: handle charging state change notifications

 Documentation/ABI/testing/sysfs-class-power        |  37 +++
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |  14 +
 arch/arm64/boot/dts/qcom/x1-crd.dtsi               |   7 +
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi       |  20 ++
 drivers/power/supply/power_supply_sysfs.c          |   2 +
 drivers/power/supply/qcom_battmgr.c                | 321 ++++++++++++++++++++-
 include/linux/power_supply.h                       |   2 +
 7 files changed, 393 insertions(+), 10 deletions(-)
---
base-commit: abbf1025002e4966bfcbf8a069234e485d49edf1
change-id: 20250520-qcom_battmgr_update-3561dc526c05

Best regards,
-- 
Fenglin Wu <fenglin.wu@oss.qualcomm.com>



