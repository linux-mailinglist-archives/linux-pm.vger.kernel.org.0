Return-Path: <linux-pm+bounces-28527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098EEAD682B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 08:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD53517C451
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C828C1FBC90;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHiQthmz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890581E5B7A;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710810; cv=none; b=Gx60V14BqCCP3yhrTc6379yCK4R2jo5OHM66iNFUWVmUvdpSGDEkGwsiv3HT7nFn1FP1cLu3SXEmE3RDm3cRfMixpzcQcjuZlgkVzlSRFW57EDfBPPabfUVQUE53E1EvBWWWTsF422qYMEKT8QFDB67X3z4cwh+cBAIdjyY+SHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710810; c=relaxed/simple;
	bh=Qhrm6Yqf09Uhu8mGMYsjgqSJmKMNkYbsTliS5amUUQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ro3UW8sjo2AutK6Jn2Ja6tWNkIvF+iX/QuQ4BREa9cEaiI4K84ZHA2Z+7xiS6IyZ7a+RSYo9509r+7T6jVtZ6Y/ARf87J4RTyi0fgMmSuNBMDhM71VS3o1Lt991z1+GuC4YcJ1byNQmsgDSQevDaXK6N2TXe/RQLoIfRfCeEeoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHiQthmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05C4BC4CEEA;
	Thu, 12 Jun 2025 06:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749710810;
	bh=Qhrm6Yqf09Uhu8mGMYsjgqSJmKMNkYbsTliS5amUUQU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qHiQthmznmSnyemAPmy0Coqq29H4vIa+gJtqedVH2yEvamK0CvaUVyTDXSvm2g0Z9
	 Y5SSXc7BR3OCgAC/NZ4bWi/69I87ouUSjjY4lWDQ8rZF3EXf39wIUm7M9+x/8d20cO
	 HaMCScNIpJiEFAr/SvS53hwagosXDowGIaZ9FAWBy+zY24uj5ROtQXaqmEgDS9HRfS
	 77oLCkIhYfP4D7kViJC7cmIPlyCH3K3qL0/+WhnCWsqUPNBiMltD1cscJekMIvtyLK
	 QQiljFwH2XKNJ+CscqHlVv3JYpp+bKaQngzcpXvlp7EA+mnkrgqYu/z7cVArlDXUi8
	 QENnsfwkdYRfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130CC61CE8;
	Thu, 12 Jun 2025 06:46:49 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v13 0/2] Add support for IPQ5018 tsens
Date: Thu, 12 Jun 2025 10:46:12 +0400
Message-Id: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALR3SmgC/53TS2vcMBAH8K8SfK7MzOjd0/p5K5T2WEpR1nYis
 n6s7d22hP3ulQ1tsri0bECXEfr/9GD0HE316Ospen/3HI312U++70KB/N1dtH903UPNfBUmIgK
 SIEAwPxwloGHzVHcTU+K+sbKpOEcdhcww1o3/sYJfvob60U9zP/5c/TMusxEqy4PFQTNjERiyB
 z+zoFWsbp0/sOPJ779Now/7j263VL7bx/u+jRbxTKsSzsPBokTCcK7YgFKagvWfMH8VJsKQRxW
 TFsaEqyH7E/zuOzYc3Nz0Y8tOwzSPtWsB4+PJHQLWvohiFfPP+uMntB9SYwxPC24ySiVADpyQa
 6ETm2eadlfL4s61w1ihjYexr+L+NB/6/ulFlluZyrzIlcl5kaZQFLqwtnyDrLZyGDyDhKdlxjN
 dZsLgIsONst7KqEiUy0srK2SmuABYZLpRNlu5MGRJFUIUAIAatF5fI79Rtls5yRMhuTYcEtDCS
 m71Imc3ygi/202CCq1+/XfOa/Nzh+CkIyVov9sK+FrAjYAMGCkllbpvKlTuLwL9W6AgOLU0qZM
 SdXUtXC6XX//nKdUkBAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749710807; l=5823;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=Qhrm6Yqf09Uhu8mGMYsjgqSJmKMNkYbsTliS5amUUQU=;
 b=qD0XD9VUfnORyj8ViKGVs7gEFaZa0jcmJ9EFimDy5qEhsqDn8rLdTwJpluY/0lNKh1A1h0wv5
 HYUjQBxEMQ1Ao3HO3mJZqiCQhZYlgCic4n/1YsT1s+tmS6D1fkYWzld
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
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              | 178 +++++++++++++++++++++
 2 files changed, 184 insertions(+), 1 deletion(-)
---
base-commit: afc582fb6563b8eb5cd73f9eca52e55da827567f
change-id: 20250404-ipq5018-tsens-64bf95fd3317

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



