Return-Path: <linux-pm+bounces-31324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0E9B0F0C1
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699031C838F8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 11:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619872DBF5E;
	Wed, 23 Jul 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pphmrJId"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24029E0E8;
	Wed, 23 Jul 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268925; cv=none; b=s4HLU+xUCyfpoV6671JJ9B8fPpVnNEUhsU3UpVmKRNWPhP0+cA4R8MA7QhIFf29x+psCDtHvMLYLl0EVeSrCHqjk0D2DcRCrlsutvxqjj7XiO6b9ddohssa2KQGnLnBoRLoxpUCM23rwZr7q5ObYpfjxukDy1f/oMVVUCxkVW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268925; c=relaxed/simple;
	bh=K3w6uW7+FkG9Ji2qt8oJ24ueGeZk9Jaai+N9sMm+7xA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kvc4l+muYEGQA9yTzcOHVRtNRIhZ2+GDapfKepEbOCD3x9nhVN2qpFRMP3elthGalLCRdNR+vHQEBGqVxGay0qxrIuR/1oQN4EpMZY61zj9noULQQBeaoQRd9jtGwzarO0Amru0Vj0UqFvkT542N2cTRqRBSCOqSwrkg4CGeyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pphmrJId; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9WF6l011562;
	Wed, 23 Jul 2025 11:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GiH4Z/1nBBDNEtWTVbil1x
	vmT/ysuluJja5uRWPK2xI=; b=pphmrJId1Q/xNV9jXA6KhX8cM/atpaZkqQlQrX
	eTYDy3qVKPDY+PXxTTVaR/SuPiZpQIK2AknftTeKcPAahITxIyHVZHX64Yk8L7XQ
	216mL8m3VemY7tChIsL0aRFd4VvblTn14yZ3kuPQqVn8fmvqtErQ2fA8gsc74Sn/
	J9AGuh8b0vm/6UroOy27E5aWdnSMJbKLKJVlYmniPGcGjxOEFussSA/qECBiA/3Y
	7RTG/zOSKq9ZfXZkO/tE+BIpG66uy2mNAB+ctSg1ott1uPwtM2xCwf6B0mM7F/lA
	k2VEO/0sjLPdivGw0/DjoGMjkINhzC4S6sTrKxaQ4U3HEJzA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qcw7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:08:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56NB8Z5c021774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:08:35 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 23 Jul 2025 04:08:30 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 0/4] Enable cpufreq for IPQ5424
Date: Wed, 23 Jul 2025 16:38:11 +0530
Message-ID: <20250723110815.2865403-1-quic_varada@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfX30q8AyqSj+cx
 GH37qbvFuKIHdfCSP1B9xxbg17QTv+uR+zPEn+UyVNYC9TD/z4nRTa82lSNRFjVsXanbRpJDE0u
 ZR6CgjoPhD3PygiFIhp6kHF0e7zlgB5NdumEuLavJNYiILgQRlLc31vGWqnLZ1kN9/s3ueMlrck
 pVkT6WOEMDb65bB8R9ud84LYcPIGU5tMkDhGusSYZNbTuTocbVtRbupzwCJ/R7h4qDXZhfTOf10
 7w20eZmQW/Ajdlo7BoAdzRLFqhtCD/Knp7RCr2+8Zv/iDy6zZC6tQpwRrv4YAI13vg6hc5rXxOt
 1TaKZjDJWHcPFp0gD7dXrIMGFcGk6+t5iUA7dIVEk5prvShog1L7fYf/0zDIkmeePOYIDg+FFiY
 9unDgSiX3pZ9U9nEpv1gxZcRyQ1crDOY9s7cYu61WW/tjgfuxWnPwnrnt/gXxV0IEKCuac2C
X-Proofpoint-ORIG-GUID: znyQuB2L7GNzK_l9r-E8rVfzm3XBI4Mz
X-Proofpoint-GUID: znyQuB2L7GNzK_l9r-E8rVfzm3XBI4Mz
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=6880c2b4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=j41EFXsdaNRYK4k_7XoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=832 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230094

CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
Add support for the APSS PLL, RCG and clock enable for ipq5424.
The PLL, RCG register space are clubbed. Hence adding new APSS driver
for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
modeled as ICC clock. The L3 pll needs to be scaled along with the CPU.

Md Sadre Alam (1):
  cpufreq: qcom-nvmem: Enable cpufreq for ipq5424

Sricharan Ramabadhran (3):
  dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock
    controller
  clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller
  arm64: dts: qcom: ipq5424: Enable cpufreq

 .../bindings/clock/qcom,ipq5424-apss-clk.yaml |  61 ++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         |  65 ++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/apss-ipq5424.c               | 282 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   5 +
 include/dt-bindings/clock/qcom,apss-ipq.h     |   6 +
 .../dt-bindings/interconnect/qcom,ipq5424.h   |   3 +
 9 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c

-- 
2.34.1


