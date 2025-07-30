Return-Path: <linux-pm+bounces-31578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E7B15A43
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A6B7A0726
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87391266562;
	Wed, 30 Jul 2025 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bcMj8F0A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4725F994;
	Wed, 30 Jul 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863239; cv=none; b=u3gRe1J7Xu6Hmat2ZeR+GPFGc8xczUhT8sIu34AHYZcaLrT8EpxnRwgnXYToHDUtr+M+A+cbnOD2QgUL/m/x5A+sFfyon3pYXIr8rfHF4WZS9xATzOhj/ptRfiGGrz1k+EjxeFaKCu+zb2jIwxt9Z/+FEDPc+p+JLePPtbQqWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863239; c=relaxed/simple;
	bh=cQSf+owQxXu2p+iqR0+m6HUWpv6t4PzHfUDkybA8rpI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPDwUuYS6T6eVitsjWKjaZUK/seOCEp3XTCgSIF8x87u3LoWRaUUmaJ5hVn/IEJrCseWtyteuehtgIJWSpFQoXwAymR3zhFWqW/ShF+03B3r0cbn5zkWVZthhQavp2e0cciB1rloe1rdTs6HPLXQZ+WJWRfUnrFl4jp56cyuq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bcMj8F0A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5ElXG003999;
	Wed, 30 Jul 2025 08:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9ApHrDba3t2E4T6JziyhJ0
	G3MCwEmrfTub2e9gHFkVk=; b=bcMj8F0AQcsAgEKfRvMJwhl/36V4Imt9OXXG3z
	b9RIaDZSi2/Yu7uLmJKhdWnESz9u2Qpz/6AGYl2fm1+Mx+eDidKSMJc+H21pJGue
	i1LB6zcNIcLgcYDx977Y0m9uRDhqylgEAL+pe590m2qEFo3BmsYAM+83e629JX/O
	2dJGUSM8LfmBnOComzI0f/uTWzHRIr4Sb6q3V0MgiJAaBXSdAT/w22LTRusPoiRY
	LKjAyIdb3dDdIGcxYWufCBKl8dsToM7msvXHp8wjBs2KNhTruQGo8I+zbG8+Cqcm
	UYOzbqEFeFO8/IEbKzJkWme/oV9H5JLDFxenFZKkOg3uCfXA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2jv0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:13:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56U8Dq1r017204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:13:52 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 30 Jul 2025 01:13:47 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v4 0/4] Enable cpufreq for IPQ5424
Date: Wed, 30 Jul 2025 13:43:12 +0530
Message-ID: <20250730081316.547796-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 960EdhSM7DCAqDe8uhM8eGApBTKLXZfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1NSBTYWx0ZWRfXxCyp7cxp5ahL
 owdl4WKi/sFoHUkwuAeNQ4ZljvMcMWMPzYyCpWIhwQK8HslOVN5AHIn866juoQhnCFEnkEoai2B
 TgluQkK7/ujJLELecTLKRLXqlF9OvRQCKl6AXVuNHeEZ4BVYd/zbPm9I/MA/fNFWUAQ3gI1FGlH
 Fkxfk99rFrWHMRju5vp3z1W3d6skoH9EwHOnJXYInTV/IO2e+L4pSz14WzIlG+qpShVSQqLn6xG
 Ph4IT+/WtIsIgntcUClRCxVGNmuOSfvL3JJ/uWaviAYz4/GCO1VguBXdfojpVgokkkXWuYM1l9C
 cJN99BfnKqe2zvTw5cnpohf7PZR6QGky05edH9PKMYsZUssqbvxpaOOueH1z5XjazVcSbKd8Swl
 3qZ0AvhUHpUNgN1jAonrA5gHA+IepTpdC/aQ7D3On/vKGElsaG7yHfgRHkDpoyBzGoLWnIDq
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6889d441 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=j41EFXsdaNRYK4k_7XoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 960EdhSM7DCAqDe8uhM8eGApBTKLXZfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=701 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300055

CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
Add support for the APSS PLL, RCG and clock enable for ipq5424.
The PLL, RCG register space are clubbed. Hence adding new APSS driver
for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
modeled as ICC clock. The L3 pll needs to be scaled along with the CPU.

v4:	* Address bindings related comments

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
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         |  61 ++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/apss-ipq5424.c               | 260 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   5 +
 include/dt-bindings/clock/qcom,apss-ipq.h     |   6 +
 .../dt-bindings/interconnect/qcom,ipq5424.h   |   3 +
 9 files changed, 407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c


base-commit: 79fb37f39b77bbf9a56304e9af843cd93a7a1916
-- 
2.34.1


