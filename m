Return-Path: <linux-pm+bounces-25650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6DAA9236F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960C25A190E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0097254AF9;
	Thu, 17 Apr 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YFH4n0xb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78071B6CE5;
	Thu, 17 Apr 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909686; cv=none; b=D8vs31RC+bqnf6Cl/BdzeUPr0jHCWLAmMwMYSaB3KzM2gqRkDytOd7W6e6ZUaxvammJHsZWct8RQ5EsUvDtCW9QdVm341Y5Jlc1bZwE4BIiPRtXn5a319TuWZzvwge/EZ1dQNzjiLynt7G/YuiFEvw5s+LKoiG6HGTPw0jfTCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909686; c=relaxed/simple;
	bh=P6WoVi4ryTfmG7rzbEbizit9HWFl+3mgjgEU9XKwk84=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Ja972g356s+rxHU/xtpG57MA6LH4pHECh3HJ5TvBDJK3IucShwiG2P8BBufCT82UdMuGKjmARFDjfWuEDRUZMTtCEalUs+sK8LqNyzslK3GuwSspYziiKSytRwlqp10aUds4yzcel9nLQyUtS98qZgaOmok7zWnXdEqNXv07gDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YFH4n0xb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClKIE014436;
	Thu, 17 Apr 2025 17:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+6ES9yVqy0rpTR+mjru3bG
	JLqoJwMupw2CdCmzfVYWU=; b=YFH4n0xbtY2Rn/9zc8lFdJCQc8jCLntoZx85y2
	z1N+ztyOjOgxGpLT0DGymVm+WyYGFfSjrtq7cMcUiE8qQTwWPR9LOs+sC68wlqpz
	cv3H5ZPTOJfOudrgO8uGYNgvGTWFQsDusOF8nd07XmY9iSS5hCyNbxy/pNaI6Rht
	AqRkuqI/zx8qiDFgVgMaNhY8zfDSzSpVwrTG/yputTdG6KiEsyC2UUtmdFFSRnKc
	6wzVHn0rU1tBzqeIsdNqzGcKYV00aEeKQ1vmMiPdIMB1Av/RyplJR5XxpWQlPyzj
	yyt3cpWMbtqT6F4pg0CKWM0ZXjPQE/ERtg0BPvg1tax2EPiA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6qrww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 17:07:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53HH7w3E024374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 17:07:59 GMT
Received: from hu-ajipan-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 10:07:54 -0700
From: Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH 0/3] pmdomain: qcom: rpmhpd: Add SM4450 power domains
Date: Thu, 17 Apr 2025 22:37:38 +0530
Message-ID: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFo1AWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0Nz3eJcExNTg/iigtyMghRds0RzE3NLkxSD5MQkJaCegqLUtMwKsHn
 RsbW1AOLFRH1fAAAA
X-Change-ID: 20250417-sm4450_rpmhpd-6a74794d0cab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yYaou16QsglqcelIR8jYYhxhjpn14VUU
X-Proofpoint-GUID: yYaou16QsglqcelIR8jYYhxhjpn14VUU
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=6801356f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=DN_wUKf7fpAkojsRBh4A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=685 suspectscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170125

This series add power domains exposed by RPMh in the Qualcomm SM4450 platform.

Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
---
Ajit Pandey (3):
      dt-bindings: power: qcom,rpmpd: Add SM4450 compatible
      pmdomain: qcom: rpmhpd: Add SM4450 power domains
      arm64: dts: qcom: sm4450: Add RPMh power domains support

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 arch/arm64/boot/dts/qcom/sm4450.dtsi               | 68 ++++++++++++++++++++++
 drivers/pmdomain/qcom/rpmhpd.c                     | 16 +++++
 3 files changed, 85 insertions(+)
---
base-commit: f660850bc246fef15ba78c81f686860324396628
change-id: 20250417-sm4450_rpmhpd-6a74794d0cab

Best regards,
-- 
Ajit Pandey <quic_ajipan@quicinc.com>


