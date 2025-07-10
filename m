Return-Path: <linux-pm+bounces-30566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA44B001C1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED32D1C87878
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B42566E2;
	Thu, 10 Jul 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GzTf6/3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCE22550D4;
	Thu, 10 Jul 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150552; cv=none; b=altKuJvHd+RK63Oj2FqFF3pOEF6x15C6MhqoRYB2h2vx1jArOqBO//q0DUwZh+mks9UD8sGooXREXSsFba3g5x7in3g2SGNUv4GjqG37tDfmVwuHrpHgqYtJOPNQBepf24TlbxZD0Df6btlrdTaECoIpPlb2kSd9LbSRVI0lHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150552; c=relaxed/simple;
	bh=pWaO5geNSreV600Rx0hjBu7mGN87uYUH+24U8VHcJM0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ZSpQ6HCVnXpodkDnb7VNjXHIaPkfvLNkXFQeH9EM0Tkl4Y1eBhxxviehOaUHrjzO3z2iDQS0DqgZftmttCPG9nGbP/dq06qycv5Q12ZlNjIK5S/zNonOGrFzkz4fIbVyRUg1NxHDGOFZjyvmTZ1rSmB1jL+GdgX6JFCszRLoMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GzTf6/3h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9BGOQ016188;
	Thu, 10 Jul 2025 12:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qa1D7gPrbr0C8OGyX6yK+C
	w8/NyA02M+BLg/teZhpGQ=; b=GzTf6/3heO09vYFttUaXv1FXroFpvvrEbp9d75
	/5kx/B27LLgZYfY50spFbR9Ri5NJI0h52SU6fWF1ngoSYRCJOo792UPK3wrPB4Mg
	2tZ8zTUP9WdFvU5EdLPy80YrJrpREgZUWAc/7h7PXknTzSBzeI6vBfZ31Fl5vnDe
	LFVomQqKQdyeDzJsKBs4K3S0CxR04ypoHyTdfVLC634fwb1bQ4gLwUFh5lVyPhi+
	1kQOJ6YhBXZ5q6nE2TQQxxyLUyWZNmHwZIVG87d4Kx5FPKLtiG1U2dezIh4TOVwG
	AhhRjLMWYyUY8mtV+MlaeqqzlA/50qFcUlIyxmA20K3Tlajg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefrcre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:28:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56ACStfD019536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:28:55 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 10 Jul 2025 05:28:49 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v3 00/10] Add Network Subsystem (NSS) clock controller
 support for IPQ5424 SoC
Date: Thu, 10 Jul 2025 20:28:08 +0800
Message-ID: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANuxb2gC/22OzWrDMBCEX8XoXBVpFVmWT32PEoJ+1s1CLNuSa
 xpC3j1KfCiFHmeY+WZurGAmLKxvbizjRoWmVIV6a1g4u/SFnGLVDARoYYTlS5jGE82LPsDhlEo
 JgavORiWsMV56VotzxoF+XtDPY9VnKuuUr6+NDZ7ujmvB/IfbgAveRWVhaLUU4D6WbwqUwnvNs
 uN9X8hY3ULrPvN7tm92thR/2WFM8+XCATwo8F52Q+w39bzrXUFeoyOtfePBhNCCQiE92ohSdwK
 ds1Jp0dWqccbZ1qj64/4AwcJ3oz0BAAA=
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Anusha Rao
	<quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_suruchia@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752150527; l=4745;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=pWaO5geNSreV600Rx0hjBu7mGN87uYUH+24U8VHcJM0=;
 b=U73YlciETJ4Wm51C3w25MNXcv+FI+KBfZHDjJSzBPjK5MFGEJViq4p9DM1mKyfQ4/nxDxi/8P
 9WVaSybuJ5ACaYU5LbrnAq2iAMwEz9tQIo/1RspJOG6fqDXbxtTl4P5
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX2RVBxV7SAulN
 9PM9qKYKKspfd7rhasVMbsFS9on+7iVhanwdCgzQWEAi5H+RQs90DhKLscd2ACXxVZZ3WkSDsbX
 4TGc0lqSvOQGcr/XeuZa543naxleFJCfgpsgiRYBcOS+2VnP4wL8PaOJCSP0DyNWbu3pKiOp3ou
 FljAAkp6dLjmWreEOev8HEWLBWCUnqCA6/YPPzSCiSEQDHJmupVUlspaElXbUIzzz+KZxzPoPDe
 iD9bAM4WGFgkKq/UOrouIAnkpTeBhyTtf6Egl08HpNSCdKiGjzjORaJRT7kWoJU5QddTZ64JRdl
 4tQCUfRoMPKIbzJ/9VL1NE6F8FbTfPfHwmYXwa+eGiVD2QHvub8u1pmLMmYdhGF0XTi0LZ1DyCd
 hHsW7F5wpa3UPZo5Kaetl92ZqVFpy61w2Ym3fPTTnCANbq+pZdqLdqRTTuhlDXMJBNx1jPRs
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686fb208 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=7tda8KZc5G6-a3B2-a8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=IawgGOuG5U0WyFbmm1f5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: bZ1Sv2IkGXKCUo3ESIsYbqcGGYEIrnAR
X-Proofpoint-ORIG-GUID: bZ1Sv2IkGXKCUo3ESIsYbqcGGYEIrnAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100106

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

To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Anusha Rao <quic_anusha@quicinc.com>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: quic_kkumarcs@quicinc.com
Cc: quic_linchen@quicinc.com
Cc: quic_leiwei@quicinc.com
Cc: quic_pavir@quicinc.com
Cc: quic_suruchia@quicinc.com

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
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
      dt-bindings: interconnect: Add Qualcomm IPQ5424 NSSNOC IDs
      clk: qcom: ipq5424: Enable NSS NoC clocks to use icc-clk
      dt-bindings: clock: gcc-ipq5424: Add definition for GPLL0_OUT_AUX
      clock: qcom: gcc-ipq5424: Add gpll0_out_aux clock
      dt-bindings: clock: ipq9574: Rename NSS CC source clocks to drop rate
      arm64: dts: qcom: ipq9574: Rename NSSCC source clock names to drop rate
      dt-bindings: clock: qcom: Add NSS clock controller for IPQ5424 SoC
      clk: qcom: Add NSS clock controller driver for IPQ5424
      arm64: dts: qcom: ipq5424: Add NSS clock controller node
      arm64: defconfig: Build NSS clock controller driver for IPQ5424

 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |   26 +-
 arch/arm64/boot/dts/qcom/ipq5424.dtsi              |   30 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |    4 +-
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/qcom/Kconfig                           |   11 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq5424.c                     |   21 +-
 drivers/clk/qcom/nsscc-ipq5424.c                   | 1340 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5424-gcc.h       |    3 +-
 include/dt-bindings/clock/qcom,ipq5424-nsscc.h     |   65 +
 include/dt-bindings/interconnect/qcom,ipq5424.h    |   19 +
 include/dt-bindings/reset/qcom,ipq5424-nsscc.h     |   46 +
 12 files changed, 1553 insertions(+), 14 deletions(-)
---
base-commit: b27cc623e01be9de1580eaa913508b237a7a9673
change-id: 20250709-qcom_ipq5424_nsscc-389d30977b1b
prerequisite-change-id: 20250610-qcom_ipq5424_cmnpll-22b232bb18fd:v3
prerequisite-patch-id: dc3949e10baf58f8c28d24bb3ffd347a78a1a2ee
prerequisite-patch-id: da645619780de3186a3cccf25beedd4fefab36df
prerequisite-patch-id: c7fbe69bfd80fc41c3f76104e36535ee547583db
prerequisite-patch-id: 541f835fb279f83e6eb2405c531bd7da9aacf4bd

Best regards,
-- 
Luo Jie <quic_luoj@quicinc.com>


