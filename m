Return-Path: <linux-pm+bounces-28891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C715DADCA6F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 14:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6612616836A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDE2DBF5A;
	Tue, 17 Jun 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gkp24C0j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8E1DE4F3;
	Tue, 17 Jun 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162022; cv=none; b=c2F4ZiDScp0MEWl7Rn9cMaYc+fYOzu0Lfa1NrjAvWXEPaiJdYjmMwtFyfk96J0fNdPT3rTgCxSJcFPJlMgToJG65uhromf3LqNV2ohev2dmDPfH2gkfYnxwvnUL5zv3KJAwADzomrhffpKKRi2XjMdZ8uWgpxP9by8gFqUKvMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162022; c=relaxed/simple;
	bh=ejyYasJsmgb5qBJBa9C81c/8fpkD6XRpqUOUR61PHWE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GztX8CMSrtyQfFXhmZyiPIkXvzTmAM4t0KLSfOrmw5L/KGcYkoiAeJeLgdJ8CXuw6TCQ9GwW4HHKNRgd/85jlaf3CW0VwzOsVA3KIQWqDBccNz6zhh2ynaZ+odFn6F10Fw9Vvvlu4ZvxUnL/dnCd5xcz1jhVZyJiJn5yQn7xijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Gkp24C0j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H5rfO3019132;
	Tue, 17 Jun 2025 12:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HCCUU3wP6S4LZTsvCJcY/s
	3u/z0/aDlpIyZpbBe8JIw=; b=Gkp24C0jtKbgYyxL/rzo7ofzzT7QcODyp4ytKS
	Dwtc0Q/eRDVtzK5NhQB/6LRXDGAdIR0PnLoCr+O+cgI3t3iN4L5gWZ2XYbsTBTdB
	7NUTQHBcVx27lr18Tlu0E8/XJsG7/rnaZ3wwQu+Ywtl2ikQ6Kj9ghADunhrzXiLS
	5fqxgJxebKL1w+GtMC4oUid/udSYtblnajY50Hwyihy/jhQpFUwVCWrJWPX69nOE
	vkqISMXK1XLtRojZ3E3oaK5HOe1++6Zx944wIzu3SM8WXe+5cBpeNXljPo8zhKfl
	2ORvs0JtunOsxAbddD/JstwuMr1fQWz5/dCS1rLD+N32lYyw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791eng550-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:06:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55HC6iAR001750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:06:44 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Jun 2025 05:06:39 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH 0/8] Add Network Subsystem (NSS) clock controller support
 for IPQ5424 SoC
Date: Tue, 17 Jun 2025 20:06:31 +0800
Message-ID: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEdaUWgC/1XM7wqDIBSH4VsJP0/QY1p2KyNC7bQJ/dUWg+je5
 9Zg7ON7OL9nJxGDx0iqbCcBNx/9NKbgl4y4uxlvSH2bmgADyRRXdHHT0Ph5kTnkzRijc9SVGjo
 jEbTKSRrOATv//KDX+uyAyyPZ63n80VX2hdk/7IZx7nsKYEGAtbzs2moTb9yaiDS9Dn6tMguFc
 woEMm5Rt8hlydAYzYVkZZoWpjBaFYLUx/ECW1elqOsAAAA=
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750161998; l=2679;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=ejyYasJsmgb5qBJBa9C81c/8fpkD6XRpqUOUR61PHWE=;
 b=WOfKOs8odSt68MBeBx/UGzqFHmIwFHs3h8YcMqz1dLq38Jqgz2yg7paEBCgvJw9pxny5vtBv3
 LHi3wYneWgrCzvoGrAYBoKc0Q/NoRA7atv5f2tRycfqi07Ec3aDrMZB
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OUy5VCs7FXPAkqop9nqOv4sujHCLfY1s
X-Authority-Analysis: v=2.4 cv=D6RHKuRj c=1 sm=1 tr=0 ts=68515a55 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=CFAC2Q-qzzUekMXSCDgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OUy5VCs7FXPAkqop9nqOv4sujHCLfY1s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA5NiBTYWx0ZWRfX7zTIWtxmcQgd
 qRersaDtiJXBR52o8zOwlptdiEDjUxiRYvh0/LuhVOmYgyJerd6s6vamoDVS2+6pLX0xTmQzAOX
 4IF/+OtbookSZDlhDrER9p3xvdeC80ZBSnfJTC+/x9gJXL6a2VJl6g2NCBLhD+0vHIyjO5a3T0g
 m86AbBH/OVwuMkpK4YXbgtOqLQ+GW5HLFGVW3InRc8T0FOCkZvfgw2Yp39aBzU13P1Siwxhbih9
 AjnddYTbMkpjRBk0oP13LIEFCRuF+axqAnHnNv28R58Qk5qDQuLSjSLTzUJgdqLPY9HBrPa9zC0
 2swsJG6q2VsRimIvDX9qRCW3x6n2qdEp8pgG9WuohktiQmu9yIq6wf+F2tmAE5sh0TfOl6MIBMc
 YTsk7a0aThDeGYlJ9vnDw087kTxvxgcMK/9SEkFhzmbF4aSEuur2msrEBRiw6tXIa14g1IzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170096

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
Luo Jie (8):
      dt-bindings: interconnect: Add Qualcomm IPQ5424 NSSNOC IDs
      clk: qcom: ipq5424: Enable NSS NoC clocks to use icc-clk
      dt-bindings: clock: gcc-ipq5424: Add definition for GPLL0_OUT_AUX
      clock: qcom: gcc-ipq5424: Add gpll0_out_aux clock
      dt-bindings: clock: qcom: Add NSS clock controller for IPQ5424 SoC
      clk: qcom: Add NSS clock controller driver for IPQ5424
      arm64: dts: qcom: ipq5424: Add NSS clock controller node
      arm64: defconfig: Build NSS clock controller driver for IPQ5424

 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |   66 +-
 arch/arm64/boot/dts/qcom/ipq5424.dtsi              |   30 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/qcom/Kconfig                           |   11 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq5424.c                     |   21 +-
 drivers/clk/qcom/nsscc-ipq5424.c                   | 1340 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5424-gcc.h       |    3 +-
 include/dt-bindings/clock/qcom,ipq5424-nsscc.h     |   65 +
 include/dt-bindings/interconnect/qcom,ipq5424.h    |   19 +
 include/dt-bindings/reset/qcom,ipq5424-nsscc.h     |   46 +
 11 files changed, 1593 insertions(+), 10 deletions(-)
---
base-commit: b27cc623e01be9de1580eaa913508b237a7a9673
change-id: 20250616-qcom_ipq5424_nsscc-c892fa5e2964
prerequisite-change-id: 20250610-qcom_ipq5424_cmnpll-22b232bb18fd:v3
prerequisite-patch-id: dc3949e10baf58f8c28d24bb3ffd347a78a1a2ee
prerequisite-patch-id: da645619780de3186a3cccf25beedd4fefab36df
prerequisite-patch-id: c7fbe69bfd80fc41c3f76104e36535ee547583db
prerequisite-patch-id: 541f835fb279f83e6eb2405c531bd7da9aacf4bd

Best regards,
-- 
Luo Jie <quic_luoj@quicinc.com>


