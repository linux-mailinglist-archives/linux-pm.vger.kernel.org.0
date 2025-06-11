Return-Path: <linux-pm+bounces-28455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C191AD4FE9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BB53A420C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C72528F3;
	Wed, 11 Jun 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1sBmeGv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55E482EB;
	Wed, 11 Jun 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634409; cv=none; b=aKDVpDApF/y2JMXWKCF5UjUwhZToPM9YftJJKHNaCQ/BmOtPmyq17zARVvsG83QcCTvedKd4DkNxtbClHxG724wb3Zd3Y47OURvRqX9/RK7XZ5dEdrACKleaRvYdtpdEvTMmVQSZggaaSVqq/PgjWmFzL90OxpbDt0dIzL0P6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634409; c=relaxed/simple;
	bh=5DRr7AZHrJWUPaFLYxjMOWvjVddxzI7+L7NjuR+7jGo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XSAIL3grzcNgmNzNHhw4KROHn+P/3e27k1Pk+4Lvsw2/gXJ9KIla9U4seeigTK/I2+7VCcgdcxinB2zay5uhbuDY7L1IWAuhnSjcc4rzQEd3kyJqGA063LTliQBKlEjOxZGm7IRpTV7sZtr7o7hGHTg1I09mTQwY6TCqFu/aOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1sBmeGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6435AC4CEEE;
	Wed, 11 Jun 2025 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749634408;
	bh=5DRr7AZHrJWUPaFLYxjMOWvjVddxzI7+L7NjuR+7jGo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=R1sBmeGvdBbjIJ/sw/Pdh8rlSG0t1cUd6nAIvn5HHcf62POzcP+NegXzyChT41tJ9
	 d7DrmfLYp7jYPcBcihIFr78bocm4ehfYkPh4otovQamPjODRult4mRze3DH27CL58k
	 0RRXQan4Q9xV36t1nk+baYGxAFbMEQSmwgt3eymhET9R73YMxfAZh6JMvn0VxtzBpY
	 bgsuoM7EaH4SxVkWslyMPIk7fjA62hPfi8kOECnAwKAB/DumZyBQ2yufIzB+6uAz9+
	 b4P/rKVTCZ1uJopSqwqBO/lmlbDwVhaKnrrdlrLOXIegZC5+/pezSH59aZoGLCnRN5
	 3r2ePzt0XGc8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD69C677C4;
	Wed, 11 Jun 2025 09:33:28 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v12 0/2] Add support for IPQ5018 tsens
Date: Wed, 11 Jun 2025 13:33:20 +0400
Message-Id: <20250611-ipq5018-tsens-v12-0-a61374a5517d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGBNSWgC/53TyYrcMBAG4FcZfI5MVWnPqb3eAiE5hhA0XmZE2
 kvb7k7C0O8e2ZDMND6EDuhSQv+nhdJLNDeTb+bo/cNLNDUXP/uhDwXSu4eoenb9U8N8HSYiApI
 gQDA/niSgYcvc9DNT4rG1sq05Rx2FzDg1rf+5gV++hvrZz8sw/dr8C66zESrLg8VBM2MRGLInv
 7Cg1azpnD+y09lX3+bJh/0nd1gr31dxNXTRKl5oU8J5OFiUSBjOFRtQSlOw/hHmb8JEGPKoYtL
 CmHA1ZH+DP3zPxqNb2mHq2Hmcl6lxHWB8OrtjwLpXUWxi/ll//IT2Q2qM4WnBTUapBMiBE3Itd
 GLzTNPhZlncu26carTxOA11PJyX4zB8f5XlXqYyL3Jlcl6kKRSFLqwt/0NWezkMnkHC0zLjmS4
 zYXCV4U5Z72VUJMr1pZUVMlNcAKwy3SmbvVwYsqQKIQoAQA1ab6+R3ynbvZzkiZBcGw4JaGElt
 3qVsztlhD/tJkGFVr/9O5et+blDcNKRElQd9gK+FXAnIANGSkmlHtsalbsVrtfrbyjagcLiAwA
 A
X-Change-ID: 20250404-ipq5018-tsens-64bf95fd3317
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749634406; l=5550;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=5DRr7AZHrJWUPaFLYxjMOWvjVddxzI7+L7NjuR+7jGo=;
 b=LQ92VY71wz/3CBE0OlMOMUiKu9St8Jew4FoMS0Aa9+D91/f0s2dI7x5WAwilKyqzQ2hcv2IZY
 Vt/woT5NhYNA2wK5AyD2uS9d0rWbHr8EqeEpjPyqCeBOdbW1azkZLkk
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
and 1 interrupt. There is no RPM present in the soc to do tsens early
enable. Adding support for the same here.

Last patch series sent by Qualcomm dates back to Sep 22, 2023.
Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
confirmed this SoC is still active, I'm continuing the efforts to send
patches upstream for Linux kernel support.
https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Changes in v12:
- Updated description in dt bindings for IP v1 without RPM
- Added Fixes tag as this this version of tsens needs to be explicitly
  reset and enabled in the driver, introduced as part of:
  commit: 19f9b02ebc8f ("thermal/drivers/qcom/tsens: Add support for tsens v1 without RPM")
- Link to v11: https://lore.kernel.org/r/20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com

Changes in v11:
- Dropped polling-delay property as its value of 0 is the default value
- Removed comments for TM and SROT in tsens node
- Replace underscore by hyphen in node name of top-glue-critical trip
- Added cooling device using CPU freq scaling making use of the passive
  trip defined under the CPU trips
- Make qcom,ipq5018-tsens a standalone compatible in the bindings as it
  should not use qcom,tsens-v1 as a fallback. This also fixes the issue
  reported by Rob's bot

Changes in v10:
- Rebased onto updated pull of master to resolve merge conflicts in the
  DTS patch
- Link to v9: https://lore.kernel.org/all/DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com/

Changes in v9:
- Updated checks in tsens to more strictly evaluate for v2+ upon enabling
  v2 features as suggsted by Dmitry.
- Split patch 3 into two, one to update conditional statements as
  mentioned above and the other to implement tsens IP v1 without RPM.
- Added back Dmitry's RB tag on patch 6 which wasn't carried over
  from v7 to v8
- Link to v8: https://lore.kernel.org/all/DS7PR19MB88833F7A9C8F4FC484977BA69DCD2@DS7PR19MB8883.namprd19.prod.outlook.com/

Changes in v8:
- Tsens V1 uses v1 interrupts and watchdog is not present (only on v2.3+).
  As such, replaced VER_1_X with VER_1_X_NO_RPM in conditons to ensure
  v1 interrupts are set and watchdog isn't enabled.
- Tested on Linksys MX2000 and SPNMX56
- Link to v7: https://lore.kernel.org/all/DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com/

Changes in v7:
- Updated cover letter
- Replaced patch 3 with a new one to add support for tsens v1.0 with
  no RPM and removed Dmitry's 'Reviewed-by tag
- Refactored patch 4 and split support for IPQ5018 from support for
  tsens v1.0 without RPM. As such, also removed Dmitry's RB tag.
- Depends on patch 1 and 2 from patch series to add support for
  IQP5332 and IPQ5424 applied on Feb 11 2025:
  https://patchwork.kernel.org/project/linux-arm-msm/cover/20250210120436.821684-1-quic_mmanikan@quicinc.com/
- Link to v6: https://lore.kernel.org/all/DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com/

Changes in v6:
- Include (this) cover letter
- Picked up Dmitry's Reviewed-by tag on patch 5
- Link to v5: https://lore.kernel.org/all/DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

Changes in v5:
- Adjusted commit messages to indicate IPQ5018 has 5 sensors of
  which 4 are described and in use as per downstream driver and dts.
- Padded addresses of tsens and qfprom nodes with leading zeros.
- Link to v4: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

Changes in v4:
- Documented ipq5018 in qcom,qfprom bindings
- Constrained ipq5018-tsens to one interrupt with description
- Added Rob's Acked-by tag
- Added Dmitry's Reviewed-by tag
- Fixed modpost warning: added __init to init_common
- Sorted tsens nodes by address
- Sorted thermal-zones nodes by name
- Link to v3: https://lore.kernel.org/all/20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com/

Changes in v3:
- Added the tsens-ipq5018 as  new binding without rpm
- Added Dmitry's Reviewed tag
- Fixed Dmitry's comments for error checks in init_ipq5018
- Ordered the qfprom device node properties
- Link to v2: https://lore.kernel.org/all/20230915121504.806672-1-quic_srichara@quicinc.com/

Changes in v2:
- Sorted the compatible and removed example
- Fixed the name for new tsens_feature
- Used tsend_calibrate_common instead of legacy
  and addressed comments from Dmitry.
- Squashed patch 3 & 4
- Fixed node names, order and added qfprom cells
  for points seprately
- Squashed patch 6 & 7
- Link to v1: https://lore.kernel.org/all/1693250307-8910-1-git-send-email-quic_srichara@quicinc.com/

---
George Moussalem (1):
      dt-bindings: thermal: qcom-tsens: make ipq5018 tsens standalone compatible

Sricharan Ramabadhran (1):
      arm64: dts: qcom: ipq5018: Add tsens node

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   7 +-
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              | 182 +++++++++++++++++++++
 2 files changed, 188 insertions(+), 1 deletion(-)
---
base-commit: afc582fb6563b8eb5cd73f9eca52e55da827567f
change-id: 20250404-ipq5018-tsens-64bf95fd3317

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



