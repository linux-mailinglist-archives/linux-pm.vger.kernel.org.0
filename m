Return-Path: <linux-pm+bounces-33233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A711DB39A17
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2DC1B24B69
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023EF30BBB9;
	Thu, 28 Aug 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MeHwN8uS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11730BBA8;
	Thu, 28 Aug 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377228; cv=none; b=mB3UCmJBXvwunKX6ni7kgPU2Gb4iV17RVvqWbwxqLJAqLxJXDPqoc/M7XZRcnCFjv7z9ns69Sxv67UkYF+N2puYxzGNG/FIndhjvaMJWVu0onfQXUsqMw2JnuW+EgrseniLclTg3Ht7TqyYIZhuCPN4cyNE00oLa7JA1+Nbnmww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377228; c=relaxed/simple;
	bh=MhPp0E8GAK6XgStwG5PDlGz3Zw2vqeVeyufst9jkIU4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ArBPEXomjB/BpUJJiNfKvg8DGmLv+sXNuniUAYRgReyjy+4l1rCV6D8xf8LHLRFxVtaDM8h7mFPgV/hsA5TUJNpGAKjn+jsIDXwWTTXSr7L1+7H+7gCgZ32w6keXhNxeMG0Smp/jSK276qAd93v+KSiNSqS/Ev5AOFp23YQWIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MeHwN8uS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S61Y0K030523;
	Thu, 28 Aug 2025 10:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vBORKHFMFQPe5YE8uowsFj
	516zPwEeopCjZ9uksuwxc=; b=MeHwN8uSsa1coqBwg5u13ObdJnoxBjNZW7QM2L
	OGKlHt5qCO8gTrm5A3xXDvshKHdhUtabB6VC8+Qz4rpU7J5Abu7e/rDpEamZddTy
	wzG83ffMcCG4AVCr6py00EhhoxeudD7g9XA4FmHIrEw0HvGvyBxeTExdFXpJ0oy/
	d0naEWed9UWWcESzC3+fj4u6mhZyWSg46+I0wXmwRRTLqeB7hgVgYRz7zRjh0AkB
	qGayVacXgkB0M9sD8O1SqluTPRfwegMDDKfDqtpXzuqBQcgd2reDFpRgEvmxs/Cc
	tevERN9XLBBdSAWSEidPpIqaFjVWpULEPBaGjec/XUIcOALg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unyqua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:33:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SAXWKL028490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:33:32 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 03:33:25 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v4 00/10] Add Network Subsystem (NSS) clock controller
 support for IPQ5424 SoC
Date: Thu, 28 Aug 2025 18:32:13 +0800
Message-ID: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC0wsGgC/22NwQ6CMBBEf4Xs2Zp2aQU8+R+GELK0sgcLtNpoC
 P9uxavHN5l5s0K0gW2Ec7FCsIkjTz6DPhRAY+9vVvCQGVCikTXWYqHp3vG8GI268zESiaFx2vY
 OVdUYyMM5WMevXXptM48cH1N47x+p/KY/XaXkP10qhRRO6WYgfVKo8LI8mdjTMXeh3bbtA06pj
 pK2AAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>, Luo Jie
	<quic_luoj@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756377204; l=4160;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=MhPp0E8GAK6XgStwG5PDlGz3Zw2vqeVeyufst9jkIU4=;
 b=+5yN60bgQIacxzrdiBqo5/d4l33dt7i6MqI8Xc04becaPKPCPqjDumKEQLZaBo3KkTGDBAWdT
 5xIhOkyZO8NCHzHqRkjwDdKC2pC3wQh/o11P/v1ragWW82SgTe9JyBp
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kRrxKGSfxNk2O4nvjIx_z8W9OT4zqNwt
X-Proofpoint-ORIG-GUID: kRrxKGSfxNk2O4nvjIx_z8W9OT4zqNwt
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b0307d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=7tda8KZc5G6-a3B2-a8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX2ZhB+ufFPxbG
 7YzO3s7NkfAmQxbE/w48UpwJQc5wXP8zKRb0rxs9dlrdX8yht6Rni3wR8rF/+qnEZbgIo2Iu0my
 5pMByBHLgrKjlX5vSjS0iaxitLFQKUp1wZ4zp8RkM8+Jw4pGn87VpX6e3+8VG0mk0HqKLy0uUmn
 r/lZTd9xrI8b1IRMEvWuASDCBMlWOFQ7dFLm3LFLsBve+IQtNeZF4pln5RXNrANnzxSLt4LuhU5
 aBRXMK2Lfgb5UzCb3mNpz5I+y8TB86Hu39Q8HuAWWnIASiHW8chIAqpK4TSo4DhlyAP934gc/IL
 rlAImAX2FssglXRs6sMPdB1D4+J9o1PfU9h8stSZDn0W3K8ul+JoecB1yfHmZXPI/sux7XsvpdL
 ipwSIKr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

The NSS clock controller on the IPQ5424 SoC provides clocks and resets
to the networking related hardware blocks such as the Packet Processing
Engine (PPE) and UNIPHY (PCS). Its parent clocks are sourced from the
GCC, CMN PLL, and UNIPHY blocks.

Additionally, register the gpll0_out_aux GCC clock, which serves as one
of the parent clocks for some of the NSS clocks.

The NSS NoC clocks are also enabled to use the icc-clk framework, enabling
the creation of interconnect paths for the network subsystem’s connections
with these NoCs.

The NSS clock controller receives its input clocks from the CMN PLL outputs.
The related patch series which adds support for IPQ5424 SoC in the CMN PLL
driver is listed below.
https://lore.kernel.org/all/20250610-qcom_ipq5424_cmnpll-v3-0-ceada8165645@quicinc.com/

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
Changes in v4:
- Add new, generic clock names "nss" and "ppe" in DT bindings to support
  the newer SoC such as IPQ5424 SoC, while retaining existing clock names
  for IPQ9574.
- Register all necessary NoC clocks as interconnect paths.
- Separate the fix for correcting icc_first_node_id into its own patch.
- Separate the fix requiring the "#interconnect-cells" property for NSS
  clock controller node.
- Update commit titles from "clock:" to "clk:" for consistency.
- Update copyright to remove year as per guidelines in all driver files.
- Remove the Acked-by tag from the "Add Qualcomm IPQ5424 NSSNOC IDs" patch"
  as the new NOC IDs are added.
- Link to v3: https://lore.kernel.org/r/20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com

Changes in v3:
- Remove frequency suffix from clock names for PPE and NSS clocks in
  IPQ9574 DT binding and DTS.
- Update IPQ5424 DT bindings and DTS to as per new PPE and NSS clock names.
- Expand the register region of IPQ5424 NSSCC to utilize the entire 0x100_000
  address range, ensuring inclusion of the wrapper region.
- Collect the reviewed-by tags.
- Link to v2: https://lore.kernel.org/r/20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com

Changes in v2:
- Add new, separate clock names "nss" and "ppe" in dtbindings to support
  the IPQ5424 SoC.
- Wrap the commit message body at 75 columns.
- Fix the indentation issue in the `IPQ_NSSCC_5424` Kconfig entry.
- Enhance the commit message for the defconfig patch to clarify the requirement
  for enabling `IPQ_NSSCC_5424`.
- Link to v1: https://lore.kernel.org/r/20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com

---
Luo Jie (10):
      clk: qcom: gcc-ipq5424: Correct the icc_first_node_id
      dt-bindings: interconnect: Add Qualcomm IPQ5424 NSSNOC IDs
      clk: qcom: gcc-ipq5424: Enable NSS NoC clocks to use icc-clk
      dt-bindings: clock: gcc-ipq5424: Add definition for GPLL0_OUT_AUX
      clk: qcom: gcc-ipq5424: Add gpll0_out_aux clock
      dt-bindings: clock: Add required "interconnect-cells" property
      dt-bindings: clock: qcom: Add NSS clock controller for IPQ5424 SoC
      clk: qcom: Add NSS clock controller driver for IPQ5424
      arm64: dts: qcom: ipq5424: Add NSS clock controller node
      arm64: defconfig: Build NSS clock controller driver for IPQ5424

 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |   64 +-
 arch/arm64/boot/dts/qcom/ipq5424.dtsi              |   32 +-
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/qcom/Kconfig                           |   11 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq5424.c                     |   28 +-
 drivers/clk/qcom/nsscc-ipq5424.c                   | 1340 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5424-gcc.h       |    3 +-
 include/dt-bindings/clock/qcom,ipq5424-nsscc.h     |   65 +
 include/dt-bindings/interconnect/qcom,ipq5424.h    |   33 +
 include/dt-bindings/reset/qcom,ipq5424-nsscc.h     |   46 +
 11 files changed, 1613 insertions(+), 11 deletions(-)
---
base-commit: 8cd53fb40a304576fa86ba985f3045d5c55b0ae3
change-id: 20250828-qcom_ipq5424_nsscc-d9f4eaf21795

Best regards,
-- 
Luo Jie <quic_luoj@quicinc.com>


