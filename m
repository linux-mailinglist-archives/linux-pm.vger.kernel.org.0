Return-Path: <linux-pm+bounces-31870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A55B1A06D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2AD7AC828
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E6624EA8D;
	Mon,  4 Aug 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oP8HVySu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591624677E;
	Mon,  4 Aug 2025 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306468; cv=none; b=Go3xosUhyouoOJt6BR4tBLF/RzlDM9zr8S/wiA8L+4GkM6kI8XURkxOOa9LfJbGHMeDQDdwyf1MUcRCVUxT0f3nJqhTsYJ6x4v7MMLiN/6vLytStbI0J/UdBuiuGCjTjdHbACq2mSxzvtNdGLENSRXJlhfode2hgqtY2ZEkn3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306468; c=relaxed/simple;
	bh=SAdLQJkP47dg//ubxixAgCH9dU/7dK2i43UHTUN+y/4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jyNXH62wR/j4Uy8nwdsol1aRxKRTaeXgYFjIDo/NdwnxVimFGgVFCKFMcdufPFu3cD7NsKllOJQveBaqgtWpWbMPBi2VwQg2NtbzEo2JmZX7tdh7jP/tB+unac44X1XVEvzalla4RTNTts2zQY2RLAy8dX71sZ2mtNtwdPjDuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oP8HVySu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5746rIT9016967;
	Mon, 4 Aug 2025 11:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Uk7BUdFrghiLA6PKoiX45Y
	2FyI3R5r85ZEDxLTH0GtE=; b=oP8HVySu2c4BWKwsSkHRw6jsoc4lenR3qP37cp
	MqrWSjd/S942G3olgX914LNUn0lb48Sy90SnVd2NMyJnv/lM+rz7OObPHtQPZEkR
	fp2eOTOhXUUVNX1pT0AvZyPQqC5UK+tTWoWWtvHTt/eYFWOlCPgeIOxqlRWl94KJ
	BrXEvfSgIH9clKyHxsyYOsqZ7Ph9TWCywaKjNIrG5e0s3kMB4qOAonA4qmvPii0q
	9eOQv/JT+0l9Lqa6DsJClivDIFMZnjvN8erkqsfq+S0SVJhCGilDFl+ZfI6W9wqa
	Xy9mZaptg8nDoXTU4uZ5iV1oezEcWFOYFMeuA79eS4tBNHIw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48aqyv0xtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:21:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 574BL1ju016842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 11:21:01 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 4 Aug 2025 04:20:56 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v5 0/4] Enable cpufreq for IPQ5424
Date: Mon, 4 Aug 2025 16:50:37 +0530
Message-ID: <20250804112041.845135-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 6ObymlFvXV3M7SEa2m_-jqDM-xmYK-hw
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6890979e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=hYIGFNv7twnpuLpzv7MA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6ObymlFvXV3M7SEa2m_-jqDM-xmYK-hw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2MiBTYWx0ZWRfX0Q5HEuK3HpYl
 7Oq+7ApaGtcYMAddIa5/8uay+jXpCtyTZ5b7JGG1My8MLLFeq/PB/KOBkgvDMkLjErT4Ldt+/+x
 D0EdqyPYi2MdQFQuKGU7Rnv8dBSfikWq3fNlEYFELyao7gRQyblBfupplsAvKP2dEMK4seWK7pp
 ExyVa7Jq5B37vPCmBjFBg2hcO3EC4P0eZrYOYNeGnwcMPotL4MnNLDjgP2nHg922ei9EcMAZ3wa
 BCnjgnhmOO8m8x1QhW7bM9gnyWsVxFxTCw66YyvW2XHavaKwJKitR2gFZqDZGslXKO6p1URHoZm
 Am1N0qYmZMTfI2VX0HndFjz67S2tiGsA2qf/wqGLmztDOGj1bPJ5FQmQRkbIMVmVyhEkJOm6sWk
 BOWQ1U4YqlHxccCQ0pjGon+UPrGZ0DO26/CatEg4T93cSKiIaQ6NhbkSPCrDmajfxlsb/9JL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=770 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040062

CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
Add support for the APSS PLL, RCG and clock enable for ipq5424.
The PLL, RCG register space are clubbed. Hence adding new APSS driver
for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
modeled as ICC clock. The L3 pll needs to be scaled along with the CPU.

v5:	* Remove previous maintainers from bindings file
	* Use enums instead of clock names in clock struct
	* Add '.sync_state = icc_sync_state'
	* Add opp-816000000

v4: https://lore.kernel.org/linux-arm-msm/20250730081316.547796-1-quic_varada@quicinc.com/
	* Address bindings related comments

v3: https://lore.kernel.org/linux-arm-msm/20250724102540.3762358-1-quic_varada@quicinc.com/
	* Use the qcom_cc_driver_data framework to trim down apss_ipq5424_probe

v2: https://lore.kernel.org/linux-arm-msm/20250723110815.2865403-1-quic_varada@quicinc.com/
	* Use icc-clk framework for l3 pll

v1: https://lore.kernel.org/linux-arm-msm/20250127093128.2611247-1-quic_srichara@quicinc.com/

Md Sadre Alam (1):
  cpufreq: qcom-nvmem: Enable cpufreq for ipq5424

Sricharan Ramabadhran (3):
  dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock
    controller
  clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller
  arm64: dts: qcom: ipq5424: Enable cpufreq

 .../bindings/clock/qcom,ipq5424-apss-clk.yaml |  63 +++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         |  71 +++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/apss-ipq5424.c               | 267 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   5 +
 include/dt-bindings/clock/qcom,apss-ipq.h     |   6 +
 .../dt-bindings/interconnect/qcom,ipq5424.h   |   3 +
 9 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c


base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
-- 
2.34.1


