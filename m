Return-Path: <linux-pm+bounces-11322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F71939D17
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051B41C21DBC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FCB14BFB4;
	Tue, 23 Jul 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PvXmxeZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308DD13B2AF;
	Tue, 23 Jul 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725419; cv=none; b=pjWtU6fNUErMAe24qQIk1yOXoiRDZ/mCAeqz/6uBnYpfDsO7/Sl9TeTlYXhRxmoJel8LME5uZQSSiPfz5Ffe53dnKN+K/CriQGcBm/JiQ16wSIavoRsI3YOw88hBbgra3gK7N+OHJt7RFTJPgZYLQUpk3FSdFLH1O77A/4VLfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725419; c=relaxed/simple;
	bh=IKDGW+S1M4rIGjWSyUzdgq3EqCJJHUgPhJCnriCxPNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQPEl7VD6WPDGG3Cmf7Q5He9/rJxbgOuEspHty6IaaWel2U+vQZR+JK8ubVcEK8PBZaa1H8di1C7mVy8BZZ0c2zKma5zuPN89PWSV/nXcONdmWKVCYTGZH+UvKgyMxnUszHDd8XQaznQkpLjLqSzQq0EiWRjNXA/LzaNN53GD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PvXmxeZK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N1qb75009577;
	Tue, 23 Jul 2024 09:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=s4vojYXQW1c42hLl+9O/4V
	8X2J5pFmtzAFiQxNZveXY=; b=PvXmxeZKKMVAWWI++VDe644bE8MZhRtJ1wMAC5
	dk1EIVSVyVnINS9Bh5eGyjCQbAk5yDP/GQJgdMuSQ01FUzsdT5yKMgfgCv1HBeoE
	/Q+vnVhuBXAHF11ALs/Ue9weZHuqJuV3k9/9KYLwLnZMY1WxvXEHrqj28ERxuQib
	rxWfz5COVqcDIIr8ekBMA0P2mAINRHTN2Vo3xRz6827IGWVGDnXrRaV8EJJ1IIjC
	qUMTwMbF+PI26TdaiW2GLq7F95Gc4OAN2gN9XmMPFo7eJX7/u93DdvZIkk24VTkb
	H1OI3eBDT9nj7Z0aKOlX3rmgrc3xsPF/MjcNe3So+DjegDGw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g60jx1bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:03:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46N93Uc1007366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:03:30 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Jul 2024 02:03:24 -0700
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
Subject: [PATCH v4 0/5] Add interconnect driver for IPQ5332 SoC
Date: Tue, 23 Jul 2024 14:32:59 +0530
Message-ID: <20240723090304.336428-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: m7w9_XRbnz9pq9ySm6dEjvdax0bzGqc0
X-Proofpoint-GUID: m7w9_XRbnz9pq9ySm6dEjvdax0bzGqc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=712
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230067

Enable icc-clk based interconnect driver for IPQ5332. This is
similar to IPQ9574's icc-clk based driver.

dt_bindings_check and dtbs_check passed.

Ensured that icc_sync_state is called and relevant clocks are
disabled.

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
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 17 ++++++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  7 ++-
 drivers/clk/qcom/gcc-ipq5332.c                | 36 ++++++++++-----
 .../dt-bindings/interconnect/qcom,ipq5332.h   | 46 +++++++++++++++++++
 5 files changed, 94 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/interconnect/qcom,ipq5332.h

-- 
2.34.1


