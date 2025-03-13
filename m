Return-Path: <linux-pm+bounces-23954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5570A5EB6E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 07:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E9169571
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF71FAC42;
	Thu, 13 Mar 2025 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KqlYV7i1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51D41AAC;
	Thu, 13 Mar 2025 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741845838; cv=none; b=JYIoR73kunuad91i40tw5IkQ9G+FYFfVA72kNjXZBs/zFi1soTa2v6kZegBpq9VM0w5S1JFVyWA1rKtIiDmbyxAn/YJYujINf2cCwl60pyF5EkC5wshpbEiyjobjJN9MTvm+kiDoaPpV1XSkPc/XB6Bn10DH2Ze5B/2zeI436n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741845838; c=relaxed/simple;
	bh=sBxebX+/Br9VVujF+As+JjAC+0rgul4iZ+Mw0seP8FY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=lRJAt1mwa6e79kAbv1ZL7VcUi/wkh2Qr67AZpyyh/tosffd3ASi8td7uJrMtdfxcaJy/uC3CCzaLhWQj/zeaVSrLjsyX36MSO/dcRTn7ejCIsc5kul9fl9Lko7Bzrhads6r1KGya/ghU73qNxe1LbpL8908b0+I308OC2c/bSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KqlYV7i1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CMvLnL031304;
	Thu, 13 Mar 2025 06:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eqNj9qijiBYrG8OOvp5pMa
	Rj/2wvemLIREsZ5gX6peE=; b=KqlYV7i1N0OU6dOF4XmCCCCsFe3l2cpKQmX1U5
	yC49h+e14VLkv6VhdfHOktwohXFkWYs39dLWUxN0lCbVIxe738d+yuNU1t/llepg
	G9lQw6M85EaP1/l5kPgj3WxtkI+zdNOQ59mIcGWMKnO/BOfWMu++sawZCMDnHUZa
	bCdNQx/bPnGydEYhOnw0o7gjKnxMu2djtH+LW4ZE131EynBBMz14ZHEnqfeXIPhv
	t0Gaj4Up09RFZbLPiv8z8aM/3o+H7aNMfgNb+dEMrLtrLjH8HIgEqbEObNZETnSD
	63IrRKahcPJTD8Up0nSIb9FSF0wl3slfJf7dDDc6LigOLvvA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2qmsad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 06:03:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D63pNs010382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 06:03:51 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 23:03:46 -0700
From: Imran Shaik <quic_imrashai@quicinc.com>
Subject: [PATCH 0/2] Add support for cpufreq scaling on QCS8300
Date: Thu, 13 Mar 2025 11:33:38 +0530
Message-ID: <20250313-qcs8300-cpufreq-scaling-v1-0-d4cd3bd9c018@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADp10mcC/x3MQQqEMAxA0atI1gbaBkXmKoOLUKMGpGqDIoh3t
 7h8i/9vMMkqBr/qhiynmq6pwNcVxJnTJKhDMQQXGkeecI/WkXMYt2PMsqNFXjRNKNR65tBQywS
 l3rKMen3nf/88L72KNdVpAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BxV6SwvuZjBJ9EnvMemdsq6lV-j5Da-0
X-Proofpoint-GUID: BxV6SwvuZjBJ9EnvMemdsq6lV-j5Da-0
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=67d27548 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=Z8OjjQeRuBHFSbpv-LYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=755 mlxscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130046

Add cpufreq-hw node to support cpufreq scaling on QCS8300.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
Imran Shaik (2):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS8300 compatible
      arm64: dts: qcom: qcs8300: Add cpufreq scaling node

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |  2 ++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi              | 26 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
---
base-commit: 9fbcd7b32bf7c0a5bda0f22c25df29d00a872017
change-id: 20250313-qcs8300-cpufreq-scaling-e361aa2536a3

Best regards,
-- 
Imran Shaik <quic_imrashai@quicinc.com>


