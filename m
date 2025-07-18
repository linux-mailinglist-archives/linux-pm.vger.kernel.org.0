Return-Path: <linux-pm+bounces-31049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E627B09CC0
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 09:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DA47A7C7D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC63B26A0D0;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfaiKTLw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB722153D8;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824293; cv=none; b=cAP7QHaIyV0qOsG+gHi/aA0+rWB0So3Sc2MnkXVyYWBmhPu+K8phdGj+e282ulaqjkXlVR2qaC4tAVNfhhQ662RpSuzXJYH7Wav5g9ona3ThMoNPY4YEku8ABhd7vv75BhEieY3BiojsFo11sM6ch7S+nF+LKMqMvGLJ4fiQ6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824293; c=relaxed/simple;
	bh=P5txPSNDOE/YGhW5KPbJFZ9L6FeNs8dC9z7RC4rk83M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZQuYaX+iSrz9KAKkp29fwhmctTUPw+rA9JtM0UVryMtq0S/h9nqV+SOFcwG5W2SWgIoCwmxfO9jPl9zSTsqQeAj7KnL6JEbMNsuiNB0smaJKiGBE1mnbPhGfC06tON4GG0JjQZeGt4BklS4I6j9y3llWR0XOpbvLwB6SvNbsKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfaiKTLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A2C9C4CEED;
	Fri, 18 Jul 2025 07:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752824293;
	bh=P5txPSNDOE/YGhW5KPbJFZ9L6FeNs8dC9z7RC4rk83M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DfaiKTLwIloIqQaaH/Ldf3rjfqQeTMXfDZ4y78IpEcGGFGGscgqwnVzXWrgOBEywU
	 iE2TumhHWVL5BjIUszEvabqfpGs4B6L/rUfsrSN3cHHPmvw6d89cpTMX0r8ynt+anL
	 1W36EyArKEc4m997kAU1v+XuPvwMTzf0owL0h6IvhmufWnQAbQiGxlyqeObQ77yEYe
	 +MszqrajOv9ydRGGtFuGnZlYhsjabqi5rlzgqptw+cSEyXhgjauvdmYp5F5dq2+fi/
	 9wYsvTeUQehWICctqibgV5mZFKK8WMe47dJwa0Dxwj69ZQSZoIcjgdRnT0gQF8oB19
	 x2/YKuO6cuxQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EAC83F17;
	Fri, 18 Jul 2025 07:38:12 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v14 0/2] Add support for IPQ5018 tsens
Date: Fri, 18 Jul 2025 11:38:02 +0400
Message-Id: <20250718-ipq5018-tsens-v14-0-28d8a2472418@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANr5eWgC/53Ty2rbQBQG4FcJWnfEOWfuWVk37wqlXZZSJpaUD
 LEulmS3JfjdOxK0sVFocUCbM+j/NDP8eonGavDVGN3fvURDdfKj79owoPhwF+2eXPtYMV+GhYi
 AJAgQzPcHCWjYNFbtyJR4qK2sS85RRyHTD1Xtfy7g129hfvLj1A2/Fv+E82qEyvJgcdDMWASG7
 NFPLGglqxrn9+xw9Lvv4+DD9we3mSff7uJd10SzeKJFCfvhYFEiYdhXbEApTcH6T5hfhIkw5FH
 FpIUx4WjI/gZ/+Jb1ezfV3dCwYz9OQ+UawPhwdPuANa+iWMT8i/70Ge3H1BjD04KbjFIJkAMn5
 FroxOaZps3Va3Hrmn4o0cb90JVxd5z2Xff8Ksu1TNu8yJXJeZGmUBS6sHb7Dlmt5fDwDBKebjO
 e6W0mDM4y3CjrtYyKxHa+aWWFzBQXALNMN8pmLReGLKlCiAIAUIPWy23kN8p2LSd5IiTXhkMCW
 ljJrZ7l7EYZ4U/dJKhQ9et/57SUnzsEJx0pQbvNWsBLAVcCMmCklFTqoS5RuTcE+rdAQXBqLqm
 TEnX5hsAvBVoJfBYIoeYqNFTAtXA+n38DDavYkWYEAAA=
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
 Dmitry Baryshkov <lumag@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752824290; l=6162;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=P5txPSNDOE/YGhW5KPbJFZ9L6FeNs8dC9z7RC4rk83M=;
 b=AEDiYPOxvelkAPXiX9vxxV0NZ0KIo3w1JJylt3Sz5aTcuGhEYQpSUrUlYerRnoekT5/qAbqSX
 7325jb4j3WuBz0uRaYoOWdH2C8xhAWXATxRDLL1nfYhvmQtzCPXpWIa
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
Changes in v14:
- Rebased on tip of master since v9 was merged even though it was
  superseded by v13. No changes, this is merely the delta between the
  two versions addressing the feedback and fixes in between.
- Link to v13: https://lore.kernel.org/r/20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com

Changes in v13:
- Dropped polling-delay-passive property as its value of 0 is the
  default value
- Updated hysterssis value to 1000 milicelsius in line with other boards
- Link to v12: https://lore.kernel.org/r/20250611-ipq5018-tsens-v12-0-a61374a5517d@outlook.com

Changes in v12:
- Updated description in dt bindings for IP v1 without RPM
- Added Fixes tag as this this version of tsens needs to be explicitly
  reset and enabled in the driver, introduced as part of:
  commit: 19f9b02ebc8f ("thermal/drivers/qcom/tsens: Add support for tsens v1 without RPM")
- Link to v11: https://lore.kernel.org/r/20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com

Changes in v11:
- Dropped polling-delay property as its value of 0 is the default value
- Removed comments for TM and SROT in tsens node
- Replaced underscore by hyphen in node name of top-glue-critical trip
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
      arm64: dts: qcom: ipq5018: Update tsens node and thermal zones

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  7 +++-
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              | 41 +++++++++++++---------
 2 files changed, 31 insertions(+), 17 deletions(-)
---
base-commit: 680a7813b2bf707824e74b48e5c1f2674a516838
change-id: 20250404-ipq5018-tsens-64bf95fd3317

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



