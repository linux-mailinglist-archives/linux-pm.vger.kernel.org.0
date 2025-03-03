Return-Path: <linux-pm+bounces-23331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B88A4CD37
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 22:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784713AC57A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 21:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D423717F;
	Mon,  3 Mar 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D9NKe91/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2E22F3AB;
	Mon,  3 Mar 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036178; cv=none; b=mqXHQ+Hpkpp0zNnkcMcMipfdIAlJKns9KFpYQ4jMxMs7RvrtggA8BAjuwSCbHiVxE6e8urHMef1NQz4HwrtMPWso5ZTVoJG0vNJW/EiSFJZ3mc2UHDmtHx5bUwgEylp/KtRnrrY8X50/HtSe+PonfX76BHYr6IlzksvHovZQzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036178; c=relaxed/simple;
	bh=VVV+C1MhWMZtWrSSt+g1IrvMbUXiEztZY3qDVStiZKE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=m5FyvH/VxZNCWOS8XQ7xtkmbQuw+7jx+pxosvLElwyQ85pTwYNZSBWrtFI+ssu2uNgUCEvpfhHwIGatdBqprqZO8dq13NRD42SR+xwc3RWN59HcI66Qa6VglAKcm7xtroDCvAt9hbdNr5HhYWYKbze8ZXwv7Xw6C4t1YOJzjxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D9NKe91/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AbM8V003941;
	Mon, 3 Mar 2025 21:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bl9bPRcUABcsynBLoqWarU
	eiwfgNhyam7E3ICj35E54=; b=D9NKe91/Nn/0oJY8SGosNGoOprTnwaPM0uTpVO
	t5KL6iTYrgk2gFBawE2Uarv91DfIBmgmNLmk2WERSbLO88htMbb+4z7KYnkYlNDR
	z8oRDaFJgG9lBMC1YNiUUyohrrGk63Z1b9CFWsjIyDU14ZE6KC6fPJY3oWv9ExWq
	VzHZ2sycfua9kROZLuNOPIWaA9j5gaaRcGbBI16pwQsNcEl8s34V38N8ZTgabksb
	xcKqo6t8n+pC1dsLKs4bhdJtpcAskDroB8gJK6vNIBexPh6ZKkF5q5KZpdpFN55G
	5GE4L2MJkSzwBl091XB++1V7cRVc7G3pZGliGPGMeqagk7Cw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hx38u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 21:09:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523L9Fwh025482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 21:09:15 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Mar 2025 13:09:14 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v9 0/5] Implement vendor resets for PSCI SYSTEM_RESET2
Date: Mon, 3 Mar 2025 13:08:29 -0800
Message-ID: <20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0axmcC/5XSy27CMBAF0F9BWdfVjN/pqv9RVZU9dooXEGqnU
 RHi3+vQByCyCMvx4tyZKx+aEnOKpXlaHZocx1RSv61D+7BqaO2275GlUOeGAxcIqJnLG7YrlFj
 ZlyFu3nIsceBsjNvQZ5aj7/uhMCLhglSawEBTrV2OXfo65by81nmdytDn/Sl2xOn1N4HLhQkjM
 mCg0RtD0KKE54/PRGlLj9RvpsgfT8A9XqAQtBCKu4CzHqK5az9BUiNHJSK/8qYORv53twSJi+/
 m056udaCU09J2t644uwrVUldUF3UIsmsJnJe3rjy7GnGpK6vb2q5u64x00d666tJd3K+a+rW6V
 dBpBTTj6n+3/ly71NXVrZ6P1npwfKYHc+Hyxa6prpMkwUP0pGZce3YRFvdgqxutQdU5rcira/d
 4PH4DcpMRb+QDAAA=
X-Change-ID: 20231016-arm-psci-system_reset2-vendor-reboots-cc3ad456c070
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
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Satya Durga
 Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, Elliot Berman
	<elliotb317@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Elliot
 Berman" <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DeTx5hTeANAUY6axUEYreTWdozumd778
X-Proofpoint-ORIG-GUID: DeTx5hTeANAUY6axUEYreTWdozumd778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=775 clxscore=1011 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030163

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

Previous discussions around SYSTEM_RESET2:
- https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
- https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Changes in v9:
- Don't fallback to architecturally defined resets from Lorenzo.
- Link to v8: https://lore.kernel.org/r/20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com

Changes in v8:
- Code style nits from Stephen
- Add rb3gen2
- Link to v7: https://lore.kernel.org/r/20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com

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
      dt-bindings: arm: Document reboot mode magic
      firmware: psci: Read and use vendor reset types
      arm64: dts: qcom: qcm6490-idp: Add PSCI SYSTEM_RESET2 types
      arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI SYSTEM_RESET2 types
      arm64: dts: qcom: sa8775p-ride: Add PSCI SYSTEM_RESET2 types

 Documentation/devicetree/bindings/arm/psci.yaml |  43 ++++++++++
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts        |   7 ++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts    |   7 ++
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi      |   7 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi           |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi            |   2 +-
 drivers/firmware/psci/psci.c                    | 105 ++++++++++++++++++++++++
 7 files changed, 171 insertions(+), 2 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20231016-arm-psci-system_reset2-vendor-reboots-cc3ad456c070

Best regards,
-- 
Elliot Berman <elliot.berman@oss.qualcomm.com>


