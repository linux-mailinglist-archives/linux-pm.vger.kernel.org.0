Return-Path: <linux-pm+bounces-31367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E1B107AC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3FAA83CB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC63264624;
	Thu, 24 Jul 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U9RvXXnC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE87255240;
	Thu, 24 Jul 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352769; cv=none; b=qvqfWt3w9eDUZXgfeVGOZga90o7I/O53n41DN0HMmtMUdOFQlg/XFLQEy9f+Ab7NsWNK0dv4cNqKBCASJy1R+bP+LAPb46XSbpq8LEyXlu3aQnLp0vCemvUwSwZ8c0T4ZS2xdBMsY2o9djyMs3kweyzqPtVz9KuOrpR7Zv6O4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352769; c=relaxed/simple;
	bh=sRT244IkQ0tYXStuykJe0c48+IvQAc1Bl05UCzBNzNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u5vkbBy/uu9lp66Kz6AdueFipghK8hwQs/HEj+d6d9iZyIqSjSz53xURGJ15O7/xG9LWHKgy8GeOtZa4oJg4zr3+Ct4qMvsWwe4gGlU2Vp4h7JQpeP7UlGTL9SHzsIVv4+9K/HWYhSQHg8KGgMq9q/SX+OSvIzOI+Rt7vFnKV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U9RvXXnC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9XKwY005792;
	Thu, 24 Jul 2025 10:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WRbumihgKERFzBKjky6Ot/
	L/I5Z9KXzz7OQbAxSdRZA=; b=U9RvXXnCEK+vdi7lkgtyRhRW2kMn6SjdpRPw1i
	3BDP72qpNCVwc39Ks+epD6lRZhczl2EUX6h1sbZj0tUnt8SsdjT1STLqOFjVga3w
	DZH7/iPz6oe8xBzAw3n5fYSKsxSrpo8QUCDwVqR03nVnlZ9J8vh9bMpLpzoz9KBI
	JBuGCEEyajovUAL3FVy2KWjjO2gfIGdr5XYFP9r1iJalNu+VFN+GgF/bBsstJY6M
	bVyJQQdeU/OUbVSC5lPpDl0Fpn0007V6z658BeaytEBurTnIJ9qdLnDMTWsq9xTs
	7kJpZDnIXG9VOF0//mXoYsKLC+/vR03dGNb1PLaLryU4Ug9g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qgcc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:26:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56OAQ1Tm012797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:26:01 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 03:25:56 -0700
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
Subject: [PATCH v3 0/4] Enable cpufreq for IPQ5424
Date: Thu, 24 Jul 2025 15:55:36 +0530
Message-ID: <20250724102540.3762358-1-quic_varada@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3NyBTYWx0ZWRfX8ClMStHB7IBD
 Yq7mrBh91yFhbX9UXhQGh/RIkD9w2u80hzpBaULRFWqlOPl6KPFB9qOrmFSK+r+hqqViCpVxsqC
 XQn2fQSWGblbJYFWTWIJN8dQPLnygSPUj+ycN4wqyc/w/AEcDM2lqVVtG3XmFCOTvy1xUqEiF6w
 XFAp28/PzZ8AR3/KKLRofKvGlU4ims031bc/aWndlfu/b5SvGmHNAB8eCpzn+Fch1179Pb4xDan
 TB+vESKBuf+QtludRJocHXDrJKcE1v1InAkrMA0EQJZef5cGzqUP70up3298Bq6Za0eNKewcQwF
 UkZ0DJfXxPza5lGKt03a//c5DU5clgL9SoC4mSjaIEuS1slJudxLf6VJdfDyvOTzVNfal+e1D03
 zpKiVsLZeIamKO1EeZXDOoyAz7tLmyaJAltVUBY4VyeD5QAyWaeC5naeswm2oblSk0usdz/m
X-Proofpoint-ORIG-GUID: y3VH-pjkPY29ZqCiBbWCcIVAS3OFTmrs
X-Proofpoint-GUID: y3VH-pjkPY29ZqCiBbWCcIVAS3OFTmrs
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=68820a3a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=j41EFXsdaNRYK4k_7XoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=743 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240077

CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
Add support for the APSS PLL, RCG and clock enable for ipq5424.
The PLL, RCG register space are clubbed. Hence adding new APSS driver
for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
modeled as ICC clock. The L3 pll needs to be scaled along with the CPU.

v2: https://lore.kernel.org/linux-arm-msm/20250723110815.2865403-1-quic_varada@quicinc.com/

v1: https://lore.kernel.org/linux-arm-msm/20250127093128.2611247-1-quic_srichara@quicinc.com/

Md Sadre Alam (1):
  cpufreq: qcom-nvmem: Enable cpufreq for ipq5424

Sricharan Ramabadhran (3):
  dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock
    controller
  clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller
  arm64: dts: qcom: ipq5424: Enable cpufreq

 .../bindings/clock/qcom,ipq5424-apss-clk.yaml |  61 ++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         |  61 ++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/apss-ipq5424.c               | 260 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   5 +
 include/dt-bindings/clock/qcom,apss-ipq.h     |   6 +
 .../dt-bindings/interconnect/qcom,ipq5424.h   |   3 +
 9 files changed, 405 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c

-- 
2.34.1


