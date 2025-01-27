Return-Path: <linux-pm+bounces-20963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB84A1D368
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 10:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0603A2596
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297001FCD16;
	Mon, 27 Jan 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TDrtoiZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E61FC10C;
	Mon, 27 Jan 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970313; cv=none; b=AxR9kwDkSYVVX0ukw9NQUizqFQQJDMVhVm72xUK053S0vqPRoo7dMrAsokeIGCWrPZlvyerIcKYdhH+nYADgCKinNGI0vuuG30b9jKC6ClQGYE8IpPQNAJaOdzqdDnCjIMMKX+Ne2Ipe6DDce+WGnZW9DXiYGJ7GqsTQufjrSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970313; c=relaxed/simple;
	bh=XumFyZdHKitDhVwJJi/+ptumS5SFZLM4peBBzi3mGHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rJWUFIrtEO2L5yTrCfcRh1uJea+45ur2XHowBzwFVGK2lo4+2w3BnOONPnJgAOlPKQkVPwCQeCLzXSBZgTpk4B4e9P9pJWMlbLsmfTc1FW8f4fSgIXvJ873TJWT2E+PZTxGX02mRMeniI3OMl0ZVqsiOzzX/y3w2z+sJNxdKeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TDrtoiZV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R3UEnC004273;
	Mon, 27 Jan 2025 09:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UBra8mNAmYWR1KMdp/rIqu
	yimsV+tW5VhTmFxCJg1AM=; b=TDrtoiZVmbgapyVPLLzDQGaK+QmV3RVEv5TlBx
	d0VNiQ0TjpwNtG942ANVJNLaB90+J8JBdC5xBqKDwxM2p7GCITeiUL9rdrznzOvb
	y2+w8TcD8RBZatrK8qU0od/fdFs8SPvwu+J5MUyQpnPMOJ4T5AXKd2naAj21V5nj
	JSJNqTEcmbidLeeF8wLo8Au93QDKMWHwMynTzprYTReCViiYaCUl3b41bqLxHJZn
	V9USaAl8eP+gciyzh5/8NqW91LtTjoYVFSLK31KBVkYNRpuEoWjWkG4AdVGRS+7s
	FGKgIytAP4rCGXReRKYnjHo3O5u1qGZK4zWgFChncMWsPyLg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e2988nw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:31:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50R9Vk0l025469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:31:46 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 01:31:41 -0800
From: Sricharan R <quic_srichara@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>
Subject: [PATCH 0/4] Enable cpufreq for IPQ5424
Date: Mon, 27 Jan 2025 15:01:24 +0530
Message-ID: <20250127093128.2611247-1-quic_srichara@quicinc.com>
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
X-Proofpoint-GUID: Fd-RkSoCo2bLlY0AvCE5_Rlf9FpKj4DB
X-Proofpoint-ORIG-GUID: Fd-RkSoCo2bLlY0AvCE5_Rlf9FpKj4DB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=692 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270076

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
Add support for the APSS PLL, RCG and clock enable for ipq5424.
The PLL, RCG register space are clubbed. Hence adding new APSS driver
for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
and needs to be scaled along with the CPU.

Md Sadre Alam (1):
  cpufreq: qcom-nvmem: Enable cpufreq for ipq5424

Sricharan Ramabadhran (3):
  dt-bindings: clock: ipq5424-apss-clk: Add ipq5424 apss clock
    controller
  clk: qcom: apss-ipq5424: Add ipq5424 apss clock controller
  arm64: dts: qcom: ipq5424: Enable cpufreq support

 .../bindings/clock/qcom,ipq5424-apss-clk.yaml |  57 +++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         |  71 ++++
 drivers/clk/qcom/Kconfig                      |   7 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/apss-ipq5424.c               | 373 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   5 +
 include/dt-bindings/clock/qcom,apss-ipq.h     |   6 +
 8 files changed, 521 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c

-- 
2.34.1


