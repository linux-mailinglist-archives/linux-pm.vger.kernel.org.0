Return-Path: <linux-pm+bounces-11621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE19407C1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292891F235C3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 05:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1621167DBD;
	Tue, 30 Jul 2024 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fPRqSEi8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6F8C0B;
	Tue, 30 Jul 2024 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318523; cv=none; b=lua+NRUBg0tYhWmX9FE/V6MjxuPXDA1qGyK+zx1tuSxKmi4JRTknuDqwgnoeGR86H7w0214Sk1zy7WgMSp0TuuYmqIzhoznkFFwU0gGBukKrgPrSbhd3j1GtjYQPemZoYMH1qc4ptPz+YLc5nt6a4W9auF085W7h8UlYapqGmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318523; c=relaxed/simple;
	bh=brHnm/9A7Z7JSV0j+IuxNueSmVSJxVotZmag9ZVxQuc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJ3zo3xY091cFVC9JvU90PBv6djG3twy2WaLx6/KUNgVxFsvp0uBEUi6OwQbWjUhyRS5cogpd/W6NyTJvogapH2cXkSzQL4LRoqqsxdg4nR2wROvytbRJTs7D4rO91yWv/Gjve1athTINwLu6njI/1/L3IPo+MqiMdmwIryftEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fPRqSEi8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TN6qus007410;
	Tue, 30 Jul 2024 05:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2GOa1/VtiTA+MKq3C0LlFF
	4qEEVP+YdLklKtCnR4ZB8=; b=fPRqSEi8vnV4Ylk04/bxU2gMt+yeuJmxl0ibBO
	tYKj/tXUR2SAs0Mzek+tGoMCnDzm83pQEc6DlzSBYPXsS3uk4Pg5OXCU6sbC29iR
	7mBv3HRbQWu2mOfg9SfhtPeAnj5MeqUbGOXeFn7B6DiWCJSPxstqeMIWjqSgAb8p
	N75QKPesLiWrX9ZXOmhKabH0AywFFbIg4/0JgWAiFRABnBrNGqJtWBbrpKcFoMv2
	PrmruTU2rr5y6IWYBvj0zZP65xO45TYq4Ol+XilE5k+EQTq9aqlVxu/rZAhSIe/J
	//xe/BZiZZuGkmY0mI+7DRP3vcRhUIMPndxVR9S5DNVe65RA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mr7gpb3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U5mYc7030515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:34 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 22:48:29 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v6 0/5] Add interconnect driver for IPQ5332 SoC
Date: Tue, 30 Jul 2024 11:18:12 +0530
Message-ID: <20240730054817.1915652-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eH9Tq3Usju5clXq-ExNpUKOiqm8FcNkZ
X-Proofpoint-GUID: eH9Tq3Usju5clXq-ExNpUKOiqm8FcNkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_05,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=834 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407300042

Enable icc-clk based interconnect driver for IPQ5332. This is
similar to IPQ9574's icc-clk based driver.

dt_bindings_check and dtbs_check passed.

Ensured that icc_sync_state is called and relevant clocks are
disabled.

v6: Update commit log for the 2nd patch and add Reviewed-By tag

v5: Fix dt-bindings entry in 'dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details'

v4: Add Reviewed-By for the first patch
    Move the gpll4_main change to next patch as suggested in review

v3: Not taking Reviewed-By: Krzysztof, due to minor change in file

    Add 'clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src' to fix
    gpll4_main's CLK_IGNORE_UNUSED issue.

v2: Removed dependency as it is merged
    dt-bindings update to accommodate USB clock names change
    Use icc-clk for USB also

v1:
Dependency:
[1] https://lore.kernel.org/linux-arm-msm/20240430064214.2030013-1-quic_varada@quicinc.com/


Varadarajan Narayanan (5):
  dt-bindings: interconnect: Add Qualcomm IPQ5332 support
  dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details
  clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src
  clk: qcom: ipq5332: Use icc-clk for enabling NoC related clocks
  arm64: dts: qcom: ipq5332: Add icc provider ability to gcc

 .../bindings/clock/qcom,ipq5332-gcc.yaml      |  2 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  2 +-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  7 ++-
 drivers/clk/qcom/gcc-ipq5332.c                | 36 ++++++++++-----
 .../dt-bindings/interconnect/qcom,ipq5332.h   | 46 +++++++++++++++++++
 5 files changed, 79 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5332.h

-- 
2.34.1


