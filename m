Return-Path: <linux-pm+bounces-30572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C0B001EA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D133BDA81
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759325DB0B;
	Thu, 10 Jul 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iSz+mp4o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1025BEF2;
	Thu, 10 Jul 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150581; cv=none; b=P4BO3CS2QjCSYHHy25BM5k/VddwErWBrTgC6Mk4xhHqcQb6LhkrmZpL0ekpW1rCnLa0K0L3OoRO+OycyvnyFsEuZwkWgdqdOHxQD4dLV2Gfb/sGWSMBNr2qPXSPmq3OUI3IfnvrNoUwL0vju+bScXQ3SFgTfu3OamiiRKFZN+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150581; c=relaxed/simple;
	bh=MzkNWeKQXleReteIY9Pyf8mQ2sPO9bnV+r0Adsusb8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jDm6oX+DXtTjLpFz5eEk7U6WP7UGDEoCA+FDpn+efwsh+gRS34TxUnyHndXsOxAv3Lyp4JP2vXOsP8DniAAfq56G7lfrnXoaEFDJ7NM1/34OmUBh6ydM0nCEcwFS1AXnzPekC/Ggn4aunZbZVFF0FJajIMe06uQCDyW7/pKPxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iSz+mp4o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8w8EX012568;
	Thu, 10 Jul 2025 12:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7rR+chSCrFJdpBVKuDkp5p5VzWvvKaqLmf5YL07XTDk=; b=iSz+mp4oGe1pfdIb
	cx2vVaZs8fHwrwjCaDtezXiEd1T+HhBPKwnhtm5V+0sCoquUHOFPHr8KtO3BUxnk
	HeQ4tNr9GGtOFEjeNfsELGr+0obZtz1rfm5VF0YnobR4wITJZxX4X9ccTvjyZ1/L
	jkbHBxJ92Up5Wsbwk5BATaxK9x4V1V15CGEUnG+rk8kHc0JRUAsADXNYG7YBIeqv
	t2gg0iVdxs9yZ92vzx58Fht1Y6mGcWyPLpvbdYZPpKVOvtv+j0MVyd/mIxFfyXw4
	1lkUT4djVewt19ykKuD2pBMnlyUOCjW1ctN0+FHXXbp1INkVDuVl5qvdLM4CIT2o
	Q9S8Mg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn8ef6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56ACTR71020394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:27 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 10 Jul 2025 05:29:21 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 10 Jul 2025 20:28:14 +0800
Subject: [PATCH v3 06/10] arm64: dts: qcom: ipq9574: Rename NSSCC source
 clock names to drop rate
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250710-qcom_ipq5424_nsscc-v3-6-f149dc461212@quicinc.com>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
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
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752150528; l=891;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=MzkNWeKQXleReteIY9Pyf8mQ2sPO9bnV+r0Adsusb8g=;
 b=sSGp8gp4aow7WO4vaGNmZl7pWPmZqKgkFenRBhsQVa7v2L7xL99K30cvbaZVEacwmnv6MEFjp
 YJ7tdNWnuPaC3tYZUVB6vNDUvLdG11ovAumfvAB4Tnp4okMLwUxPwJ/
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686fb228 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=3nWwevN04WxPzTAsgCYA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: TZfG1MXHeyS0EQfpP7dLU7xk1UTiusvy
X-Proofpoint-ORIG-GUID: TZfG1MXHeyS0EQfpP7dLU7xk1UTiusvy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX/3jvJa/VVYVX
 0raMEyCQNwBn1S0SBha9NI620E/hePb3fzq7A0kRBNSMPAI4UJPrUHjAiMxKl05CDWWDOnLrvyl
 cmzYB5fTv4mvI1xCptjt+/Vife4Qk6nvhX3RBQ06ei5PBIjXnQ88KWaOa0ns4OL3IrdJaIJuepy
 dJ4gzuAOZzuv7rvok8yBmLADDT/lGDvmqyYrYCAEJoM+PbhkkxJ8E1mLWOoLcReqyPtTazLf2bD
 ZvQX3iAEujiT2XZDyFOSMrcwgJ68wCMgJzUIN1ovvQ4nXUjXmBFSgMhlgAauQB80yPYH67QJfiW
 eqGE3pY+2weaG7zctwA8V7Z3NuC7xLC+xuHVGIenTe9E1q76fO8z0EQnMOTRSVWs+jsaz5m29ds
 J8GL+ovdMue5h34grWOENjRbIhIH2Mn0zb1DKEud0B9GHqQzJzl0VUZ9v/y4IHlz5AP7mByb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=853 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100106

Drop the clock rate suffix from the NSS Clock Controller source clock
names for PPE and NSS clocks. A generic name allows for easier extension
of support to additional SoCs that utilize same hardware design.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 815b5f9540b8..a2c6a5e0599c 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -1261,8 +1261,8 @@ nsscc: clock-controller@39b00000 {
 				 <0>,
 				 <&gcc GCC_NSSCC_CLK>;
 			clock-names = "xo",
-				      "nss_1200",
-				      "ppe_353",
+				      "nss",
+				      "ppe",
 				      "gpll0_out",
 				      "uniphy0_rx",
 				      "uniphy0_tx",

-- 
2.34.1


