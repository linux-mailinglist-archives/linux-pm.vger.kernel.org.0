Return-Path: <linux-pm+bounces-27832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C4AC88FE
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27793A5FD7
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F882116F4;
	Fri, 30 May 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsbzZg8D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC391E520B;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590540; cv=none; b=Y8ZEpi2LE1pM8X1lrzAQKta0G5I7qqbcxAutwFbTAmEGDGgTbRChjdIf0ulmS3t9PTetysCP7bZEEXr4mU8feiUcShVdKCIbpvBon2hycZsIJOC+hZfmPEuJLP1oMF6rvgkflzDDYQxr7xPNeKJLVlaCYhkR/RnZ3sgyX7olAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590540; c=relaxed/simple;
	bh=5HxqNMeD1/f7YQnN7xhf+npL6xt1LWEI9PtEr8GuJRs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a3QKn22aXOfnqSspSHuJ8Tvb+dfr8+M4EttIvGkFTbtcY4VXnGS614Zti6VStnkHnT9X106AhN5s0MLEzOGF2y6QbOpINZmZ4dUhL9QaBcVkPIgNkqYSeKC/S+ZmQJG/7feMADZW6drk1pzFRDJjfY8PTuaJ0kaaNAr/9iP16cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsbzZg8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2827FC4CEE9;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748590540;
	bh=5HxqNMeD1/f7YQnN7xhf+npL6xt1LWEI9PtEr8GuJRs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hsbzZg8DhpT7FQpI+c5O6BTIwVA/TpzlfNRtllXwtkVwWbpxTa7zMIxSgqp1PDFhW
	 SGyH4XCwsJK3UnpNcCYsEKK1weIuf30GYVLXTkyRiyQ5SbcmtHSV0mLkRYg7dikcU9
	 ejk1eL7NcM7FT5sIIow8d0rSiDyXwq6AF3HpP5vBtKPgRFQ2OhNtJd9DD1Cn8JUYKR
	 rxmhhHsMZMDA9Z0rCkQk3YnrmpkeKc4iLCY//lrCeQ51FFxs/XRzOXL1ULD+xlWxFB
	 5KZcAY8pQTsHucLpLbQp55w95xJnu2FKGiSbpWMCSwHYJY9RRVwnARSfVeM18Rqeto
	 fpghZ45zY/T+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4BFC3ABB2;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/8] power: supply: Add several features support in
 qcom-battmgr driver
Date: Fri, 30 May 2025 15:35:05 +0800
Message-Id: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlfOWgC/22NywqDMBBFf0Vm3UgSmyy66n8UkTymGqhGkxgs4
 r83FbrrZuBc7j2zQ8TgMMKt2iFgdtH5qQC/VGAGNfVInC0MnHJBBadkMX7stEpp7EO3zlYlJI2
 QzBrBpaECynIO+HTbaX20hQcXkw/v80lm3/Tna/76MiOUcK2lvSJVQuLdx1gvq3qV8liXA+1xH
 B9fkFb7vQAAAA==
X-Change-ID: 20250520-qcom_battmgr_update-3561dc526c05
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748590538; l=3179;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=5HxqNMeD1/f7YQnN7xhf+npL6xt1LWEI9PtEr8GuJRs=;
 b=hSy5b3n5jlNd/kBYUZ6n/phnURJVIB+JxwC6vo/qUrAwrhgsODUlTHSxJc7W9F0InrD/xTjvh
 CXxmRPTdk/yAsgwmuk4UXFkgVQriEH+2NbQ/9eyZl4mZS2kWgssyRIc
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
qcom/linux.git for-next commit f8d04825b12f42ec8198dee1ab4654792f9ac231.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
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
      power: supply: qcom_battmgr: Add charge control support
      dt-bindings: soc: qcom: pmic-glink: Move X1E80100 out of fallbacks
      usb: typec: ucsi_glink: Add UCSI quirk for X1E80100 platform
      arm64: dts: qcom: x1*: Remove qcom,sm8550-pmic-glink fallback

 Documentation/ABI/testing/sysfs-class-power        |  20 ++
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   4 +-
 arch/arm64/boot/dts/qcom/x1-crd.dtsi               |   1 -
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts       |   1 -
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |   1 -
 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   |   1 -
 .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     |   1 -
 .../boot/dts/qcom/x1e80100-hp-omnibook-x14.dts     |   1 -
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |   1 -
 .../boot/dts/qcom/x1e80100-microsoft-romulus.dtsi  |   1 -
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          |   1 -
 drivers/power/supply/power_supply_sysfs.c          |   2 +
 drivers/power/supply/qcom_battmgr.c                | 275 ++++++++++++++++++++-
 drivers/usb/typec/ucsi/ucsi_glink.c                |   1 +
 include/linux/power_supply.h                       |   2 +
 15 files changed, 295 insertions(+), 18 deletions(-)
---
base-commit: abbf1025002e4966bfcbf8a069234e485d49edf1
change-id: 20250520-qcom_battmgr_update-3561dc526c05

Best regards,
-- 
Fenglin Wu <fenglin.wu@oss.qualcomm.com>



