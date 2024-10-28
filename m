Return-Path: <linux-pm+bounces-16616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CCB9B397C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C25B212B9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0021E0B7C;
	Mon, 28 Oct 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X+wcFRTa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709171DFE0F;
	Mon, 28 Oct 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141133; cv=none; b=PRF89pDpvrmSCEReZ8ufRvhbniEMxYuGqGMCUfKLAbidnecmkRSFzGWfxMtjTKenxkHZi5GieqrT7yGRzAMbNCzSd3/MHO5ci5kBaNy8rczmErA40yPBExxYDrbYZ7NgNOoFLP6DJmPFWqLTvbEDA86GKMUe866J4Ob2ye9sMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141133; c=relaxed/simple;
	bh=wjj0nMQXZXeyrVopf59kt9QNb4zQY+SAdnub3j9nJA4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=j8pZj3xrK9qrlKJ7UgjFqneVfvI2GpO7ckmFuPZ2yTwrhTiXQaaQXObbjoCSyhRcepn78oOrgM3Kkcjkc6E0hA+YM+wOGSJwH72JfzoZrT3pgRnl8uAsTdBSrdU2VzPxgzHVzYSPPmgeW7FDBlO4SKAoN+WxqKtghTYFMeUq6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X+wcFRTa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBF3WQ027649;
	Mon, 28 Oct 2024 18:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FFpEevja3y6wKaFfcKqCGL
	7fQ+TPELn6XQKMoqKg3lA=; b=X+wcFRTa4tKDvCkFYHarNO/3VoVRxILlDjfvl1
	dvkoQGp0Kh3y93VIYcGSNWdte4wDHuzaQdlF0ovsKRaFBRZFQyv6YpYxjsbqA0Ty
	XALNCH2Xi3cv+lrMT3EcQxAJGumaUjHhS/DFKp7pgj+DHcC8+c6Elx7V17PyWd2V
	gW4WfQO5A3b1EsxOYfNdwMehCqZY82HFOLuQ/6Fnmy2JKVabuwtt4DyGXkPhe4vg
	vt9dWcSr3jtiuzR+cqtAasV+01iEE/fSn0xuPEO8i6DTzrDEwRkgl5LTZCWZMv6k
	bJNLjDeSCp3aIhEKb/95r1EjVw8G17W1+S5AbyfUEbpfXxKw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqcqp3qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 18:45:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49SIj1wf012515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 18:45:01 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 28 Oct 2024 11:45:00 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v7 0/5] Implement vendor resets for PSCI SYSTEM_RESET2
Date: Mon, 28 Oct 2024 11:44:54 -0700
Message-ID: <20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfbH2cC/5XSy07DMBAF0F+pssZoxq84XfEfCCFnPKFeNCl2i
 Kiq/jtOeRRoF+lyvDh35sqHKnOKnKv16lAlnmKOQ1+G+m5V0cb3LyxiKHMlQSoEtMKnrdhliiL
 v88jb58SZRykm7sOQROJ2GMYsiJQP2liCGqpi7RJ38f2U8/hU5k3M45D2p9gJ59evBKkXJkwoQ
 IDFtq4JGtTw8PoWKfZ0T8N2jvz0FNziBQrBKmWkD3jVQ6xv2k+RtijRKJZ/vLmDSX7frUHj4rv
 lvKdvPBjjrXbdpavOrkGz1FXFRRuC7hoC3+pLV59di7jU1cVtXFe29bX27C5d89td3K+Z+3W2M
 dBZA3TFtT9u+bluqWuLW7yWnWvBy389HI/HDzELh7M0AwAA
To: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, "Olof
 Johansson" <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will
 Deacon" <will@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: szCmzW5AzBZvPNpUoWbl-H_bOCqMtg17
X-Proofpoint-GUID: szCmzW5AzBZvPNpUoWbl-H_bOCqMtg17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 mlxlogscore=809 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280147

The PSCI SYSTEM_RESET2 call allows vendor firmware to define additional
reset types which could be mapped to the reboot argument.

Setting up reboot on Qualcomm devices can be inconsistent from chipset
to chipset. Generally, there is a PMIC register that gets written to
decide the reboot type. There is also sometimes a cookie that can be
written to indicate that the bootloader should behave differently than a
regular boot. These knobs evolve over product generations and require 
more drivers. Qualcomm firmwares are beginning to expose vendor
SYSTEM_RESET2 types to simplify driver requirements from Linux.

Add support in PSCI to statically wire reboot mode commands from
userspace to a vendor reset and cookie value using the device tree. The
DT bindings are similar to reboot mode framework except that 2
integers are accepted (the type and cookie). Also, reboot mode framework
is intended to program the cookies, but not actually reboot the host.
PSCI SYSTEM_RESET2 does both. I've not added support for reading ACPI
tables since I don't have any device which provides them + firmware that
supports vendor SYSTEM_RESET2 types.

Lorenzo and I are also looking for some feedback on whether it is safe
to perform a vendor SYSTEM_RESET2 irrespective of the enum reboot_mode:

https://lore.kernel.org/all/Zw5ffeYW5uRpsaG3@lpieralisi/

Previous discussions around SYSTEM_RESET2:
- https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
- https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Changes in v7:
- Code style nits from Stephen
- Dropped unnecessary hunk from the sa8775p-ride patch
- Link to v6: https://lore.kernel.org/r/20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com

Changes in v6:
- Rebase to v6.11 and fix trivial conflicts in qcm6490-idp
- Add sa8775p-ride support (same as qcm6490-idp)
- Link to v5: https://lore.kernel.org/r/20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com

Changes in v5:
- Drop the nested "items" in prep for future dtschema tools
- Link to v4: https://lore.kernel.org/r/20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com

Changes in v4:
- Change mode- properties from uint32-matrix to uint32-array
- Restructure the reset-types node so only the restriction is in the
  if/then schemas and not the entire definition
- Link to v3: https://lore.kernel.org/r/20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com

Changes in v3:
- Limit outer number of items to 1 for mode-* properties
- Move the reboot-mode for psci under a subnode "reset-types"
- Fix the DT node in qcm6490-idp so it doesn't overwrite the one from
  sc7820.dtsi
- Link to v2: https://lore.kernel.org/r/20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com

Changes in v2:
- Fixes to schema as suggested by Rob and Krzysztof
- Add qcm6490 idp as first Qualcomm device to support
- Link to v1: https://lore.kernel.org/r/20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com

Changes in v1:
- Reference reboot-mode bindings as suggeted by Rob.
- Link to RFC: https://lore.kernel.org/r/20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com

---
Elliot Berman (5):
      dt-bindings: power: reset: Convert mode-.* properties to array
      dt-bindings: arm: Document reboot mode magic
      firmware: psci: Read and use vendor reset types
      arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for qcm6490-idp
      arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for sa8775p-ride

 Documentation/devicetree/bindings/arm/psci.yaml    |  43 +++++++++
 .../bindings/power/reset/nvmem-reboot-mode.yaml    |   4 +
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |   7 ++
 .../bindings/power/reset/reboot-mode.yaml          |   4 +-
 .../bindings/power/reset/syscon-reboot-mode.yaml   |   4 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |   7 ++
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi         |   7 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +-
 drivers/firmware/psci/psci.c                       | 104 +++++++++++++++++++++
 10 files changed, 180 insertions(+), 4 deletions(-)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20231016-arm-psci-system_reset2-vendor-reboots-cc3ad456c070

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


