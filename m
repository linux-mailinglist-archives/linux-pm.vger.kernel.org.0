Return-Path: <linux-pm+bounces-28438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF5AD4A52
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B494E17B306
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73037225413;
	Wed, 11 Jun 2025 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T60vkEcj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361892236F7;
	Wed, 11 Jun 2025 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618785; cv=none; b=Np8jKnhH1/UvOu7BLPWi9QBs0KTqqETlQ4wuup2aJiH9NM52GVSgXHZyOc7DbZhG8wqAXN4l0Pe9wYayPR9aLijUYdgkdD/VaWBgvepFUfIS7ad+5///h+qRCbGpBNg1WNnu9uFVDsR2MQRTlg0f9SwqHuuHUmnWVQYasuzB2Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618785; c=relaxed/simple;
	bh=FZ77rZmKrowroBjfFiCTpiqeBpzxShU0u3fUrllz5rc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gPmiVrY51MrsL8eRYg/BDHFuYjNKGRMzSaQ3kl1hD7ru7jrTz/jhILrMMqtdnq1hPuB6B9RD31lVMdd5mz/4O1C9qpcnTGTo2+m3Y8gBhV/o+zzDjX87hvb/m/M2Igk52+VhhzQBaZMFucGvTNgDYNSgZmti9sSlZGYSzA1Tjj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T60vkEcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2860C4CEEE;
	Wed, 11 Jun 2025 05:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749618784;
	bh=FZ77rZmKrowroBjfFiCTpiqeBpzxShU0u3fUrllz5rc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=T60vkEcjW3Ji7yHb76wuCLVsfLYxkVTT7KQ1I3TEr8FD//G/Vi46FxOFREMNcsb9/
	 6Tik4xQQpUhWWfdH0rETrQu8gJ8c+3PWAFXsf8v6pyS6HPftowdxBd3CrIgMSpZGi6
	 61shhB2OZJ7ElPC+YEM9XjlhFodlduSo6WIt2gb0VBWaE+LuR9Nc0b4VhWh4k8atRi
	 c99taU0qb2b9CavoXohjQWGcSiaBkZC2HqlSYZAFVjH6S9kD7XsVXHfprhUDBQpDBr
	 SI15vnMT6yhAoWB3mn09uLlDI/itdQog5L6EU41biLEXcUq9WGr4fmSSMkZSQuEsHm
	 I5UTRXgbOHZUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A0C677C4;
	Wed, 11 Jun 2025 05:13:04 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v11 0/2] Add support for IPQ5018 tsens
Date: Wed, 11 Jun 2025 09:12:44 +0400
Message-Id: <20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwQSWgC/12PwQ6CMBBEf8X0bEm30EI9EcCjidGj8VChSKNQb
 NFoDP9uxYt6nN3ZN7NP5JTVyqHF7ImsummnTecFwHyGykZ2R4V15QeIEspIRCKs+wsjkODBqc5
 hHh1qweoqDCFG/qa3qtb3Cbjbe11b0+KhsUpOlGIbrzcgVlmSJCEvci44Y8CWQIuYZBnNRZHnN
 P2xBZ1se1uBCHprqsBch7Mxp6A07Tuw0W4w9jE9cAPyzv105UD+uvo1BhxKIJJJyiNapt+w/Ti
 OL7VNnDcQAQAA
X-Change-ID: 20250404-ipq5018-tsens-64bf95fd3317
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749618782; l=5954;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=FZ77rZmKrowroBjfFiCTpiqeBpzxShU0u3fUrllz5rc=;
 b=YiF93byp3tuckD8J//y9zG+sqcwWVOio+dOVJ+6UNAF9EyQs/Dr56aLYcmPkQsSwQ4gnE9Nve
 GXJhWEew1rJCa49XjkxxENVjyLcEi1jDaa5CEn6UUXfsvhjCsOZ9814
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

[v11]
	*) Dropped polling-delay property as its value of 0 is the default value
	*) Removed comments for TM and SROT in tsens node
	*) Replace underscore by hyphen in node name of top-glue-critical trip
	*) Added cooling device using CPU freq scaling making use of the passive
	   trip defined under the CPU trips
	*) Make qcom,ipq5018-tsens a standalone compatible in the bindings as it
	   should not use qcom,tsens-v1 as a fallback. This also fixes the issue
	   reported by Rob's bot

[v10]
	*) Rebased onto updated pull of master to resolve merge conflicts in the
	   DTS patch
	*) Link to v9: https://lore.kernel.org/all/DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com/

[v9]
	*) Updated checks in tsens to more strictly evaluate for v2+ upon enabling
	   v2 features as suggsted by Dmitry.
	*) Split patch 3 into two, one to update conditional statements as
	   mentioned above and the other to implement tsens IP v1 without RPM.
	*) Added back Dmitry's RB tag on patch 6 which wasn't carried over
	   from v7 to v8
	*) Link to v8: https://lore.kernel.org/all/DS7PR19MB88833F7A9C8F4FC484977BA69DCD2@DS7PR19MB8883.namprd19.prod.outlook.com/

[v8]
	*) Tsens V1 uses v1 interrupts and watchdog is not present (only on v2.3+).
	   As such, replaced VER_1_X with VER_1_X_NO_RPM in conditons to ensure
	   v1 interrupts are set and watchdog isn't enabled.
	*) Tested on Linksys MX2000 and SPNMX56
	*) Link to v7: https://lore.kernel.org/all/DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com/

[v7]
	*) Updated cover letter
	*) Replaced patch 3 with a new one to add support for tsens v1.0 with
	   no RPM and removed Dmitry's 'Reviewed-by tag
	*) Refactored patch 4 and split support for IPQ5018 from support for
	   tsens v1.0 without RPM. As such, also removed Dmitry's RB tag.
	*) Depends on patch 1 and 2 from patch series to add support for
	   IQP5332 and IPQ5424 applied on Feb 11 2025:
	   https://patchwork.kernel.org/project/linux-arm-msm/cover/20250210120436.821684-1-quic_mmanikan@quicinc.com/
	*) Link to v6: https://lore.kernel.org/all/DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com/

[v6]
	*) Include (this) cover letter
	*) Picked up Dmitry's Reviewed-by tag on patch 5
	*) Link to v5: https://lore.kernel.org/all/DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v5]
	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
	   which 4 are described and in use as per downstream driver and dts.
	*) Padded addresses of tsens and qfprom nodes with leading zeros.
	*) Link to v4: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v4]
	*) Documented ipq5018 in qcom,qfprom bindings
	*) Constrained ipq5018-tsens to one interrupt with description
	*) Added Rob's Acked-by tag
	*) Added Dmitry's Reviewed-by tag
	*) Fixed modpost warning: added __init to init_common
	*) Sorted tsens nodes by address
	*) Sorted thermal-zones nodes by name
	*) Link to v3: https://lore.kernel.org/all/20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com/

[v3]
	*) Added the tsens-ipq5018 as  new binding without rpm
	*) Added Dmitry's Reviewed tag
	*) Fixed Dmitry's comments for error checks in init_ipq5018
	*) Ordered the qfprom device node properties
	*) Link to v2: https://lore.kernel.org/all/20230915121504.806672-1-quic_srichara@quicinc.com/

[v2]
	*) Sorted the compatible and removed example
	*) Fixed the name for new tsens_feature
	*) Used tsend_calibrate_common instead of legacy
	   and addressed comments from Dmitry.
	*) Squashed patch 3 & 4
	*) Fixed node names, order and added qfprom cells
            for points seprately
	*) Squashed patch 6 & 7
	*) Link to v1: https://lore.kernel.org/all/1693250307-8910-1-git-send-email-quic_srichara@quicinc.com/

George Moussalem (2):
  thermal: qcom: tsens: update conditions to strictly evaluate for IP
    v2+
  thermal: qcom: tsens: add support for tsens v1 without RPM

Sricharan Ramabadhran (4):
  dt-bindings: nvmem: Add compatible for IPQ5018
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal: qcom: tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  62 +++++++
 drivers/thermal/qcom/tsens.c                  |  27 ++-
 drivers/thermal/qcom/tsens.h                  |   4 +
 6 files changed, 256 insertions(+), 9 deletions(-)

--
2.48.1

---
---
George Moussalem (1):
      dt-bindings: thermal: qcom-tsens: make ipq5018 tsens standalone compatible

Sricharan Ramabadhran (1):
      arm64: dts: qcom: ipq5018: Add tsens node

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   5 +-
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              | 182 +++++++++++++++++++++
 2 files changed, 186 insertions(+), 1 deletion(-)
---
base-commit: afc582fb6563b8eb5cd73f9eca52e55da827567f
change-id: 20250404-ipq5018-tsens-64bf95fd3317

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



