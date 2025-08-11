Return-Path: <linux-pm+bounces-32141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876DFB202D0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DFA3AB4F9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F122DD60E;
	Mon, 11 Aug 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dm8MHntZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36862727F0;
	Mon, 11 Aug 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903417; cv=none; b=BT3Z6tEHl8lhTiPMiN4n1iv173jRiz/n6GA7NK3f3LSPaGN13gJ8EPioLeCsl9U8g6JuAfe7gXcDGC3a+l7eE+lnFKmQwf5ODglpxn1w6iSRRfcJXACCCIZ3tuP0hJwssyKIMA+iTcgDWDiHVtUk08BZxDIBSzb4DWWdgS/bKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903417; c=relaxed/simple;
	bh=mRPuDW1POS5navBdn5cGBjeHKYfFRTFsma8UM+B5Tjg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jK+untjHfeHA8aqmBeSA1u9o+jcW8H68X/wFVSP0Ok4KllXKFfoSCTxWoCziCv5qS3k8FEbO/iWaDmax2Oqt7X3ffubU4lPp+nCHOzS3sU+Gux3Ug6hYsbw7eG3OcqQ4j/rO/+13J+W1kXShZTMB+wXRsR/QQl+WzLGJ0D/01eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dm8MHntZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ANbeZN013661;
	Mon, 11 Aug 2025 09:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wfZkKVWw+QGYZpgYNTNBzT
	z65WYXCAXZrb5tpWem0Gs=; b=Dm8MHntZEfyOdFzpiGSs2bz6J8JuudP1NQ4d5R
	SenbdhOFoThDPnVPv7m3Vb8xoXL7W9IeOMYiTLTcMSSiqklgvDT3HtHp5J4ja9bA
	gF1s3pFWrp2DwvGL24K+jCpwFiwXLwxtmp2Wmnq801pVWH8bAv98B10apSMTTb+r
	ETsm8nyzdYT3GSAjqYN/z8FSifSgifqewdIhzIOR+u+DnaLEAQFV9hV3blt+B4ME
	7O2lxTMMiWKp0RjBHIPcvWwOSZSeJP1KUyClJqwRzkIBBLabcsCqVIObZemtqrAJ
	NDSDJcPk6hN8O1lEbhs/TRR3VoVjnoKc0kkFpUNHXNdRXheQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmkw12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:10:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57B9AAEc030857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:10:10 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 02:10:05 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v7 0/4] Enable cpufreq for IPQ5424
Date: Mon, 11 Aug 2025 14:39:50 +0530
Message-ID: <20250811090954.2854440-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=6899b373 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=hYIGFNv7twnpuLpzv7MA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sFHpyX3I2x_d94MywZen8ieP1iWyYyTx
X-Proofpoint-ORIG-GUID: sFHpyX3I2x_d94MywZen8ieP1iWyYyTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX8ZoeiyyypaHB
 Zeh9SDQk+Z+LJ6BDp0feuuMiBOmoBwXg2pKnRLNahw+YYFkCFapiyr5mBpTriU2Db1AV/Kw7dkI
 E4Au+bNPfSkw6a34mALdomedaGNNIIsJ6vw8ciE09qOUb7gdXUFTzgwLB91mZEXP1T6tu9oS/0R
 Hx+86S4GiJLdi0Ll3FeUStw/5lKfercJU+82OgBorEphU3c4r6lC5UlA+WQ3+4n2QsD7jU8pjTa
 IvAu2tc0KjicjdYL5DawZy12BIdwu9fz42xIjZn+3Z2TwHUyHVXMtEUPvcyMm6Kb07yHXC9ucNX
 F1Ad3CJOPypOcUH2ouTTHLwpFakYMHFu3ITjkOWduM79xcc54mHHKs7dr+xsYnTD0SpfDYvqtvo
 BNEZF8zR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000

CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
Add support for the APSS PLL, RCG and clock enable for ipq5424.
The PLL, RCG register space are clubbed. Hence adding new APSS driver
for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
modeled as ICC clock. The L3 pll needs to be scaled along with the CPU.

v7: Fix 'Reviewed-by' placement for bindings patch
    Use enum instead of clock names for l3 pll
    Select IPQ_APSS_5424 if IPQ_GCC_5424 is enabled

v6: https://lore.kernel.org/linux-arm-msm/20250806112807.2726890-1-quic_varada@quicinc.com/
	* Drop clock-names in bindings, dts and driver and use index instead
	* Fix 'opp-microvolt'

v5: https://lore.kernel.org/linux-arm-msm/20250804112041.845135-1-quic_varada@quicinc.com/
	* Remove previous maintainers from bindings file
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

 .../bindings/clock/qcom,ipq5424-apss-clk.yaml |  55 ++++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         |  69 +++++
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/apss-ipq5424.c               | 265 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   5 +
 include/dt-bindings/clock/qcom,apss-ipq.h     |   6 +
 .../dt-bindings/interconnect/qcom,ipq5424.h   |   3 +
 9 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq5424.c


base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
-- 
2.34.1


