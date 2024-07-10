Return-Path: <linux-pm+bounces-10903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10C92CA6E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 08:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602F51C22096
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 06:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B154BD8;
	Wed, 10 Jul 2024 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nFvQghFT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE73FB30;
	Wed, 10 Jul 2024 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591903; cv=none; b=R60DbrfjyC5Vzr0NwX9CP/PEIGSGMN6u7BpeVHXBvPVhXhHn7hnb+lcvJVFr9vjemWFYZSbsb815m7w+8NVUy5NOap4rLC59Qt+g8NRSnlTIqmFQ+mu+wQlItmi1Ni8Siwa4uveMr/MFje98RtsQ5YXso6hwmFFsG2w83oNi0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591903; c=relaxed/simple;
	bh=Eehj/qZchMn3DSNCSl4U5jLyqPH35iunz5MxV895HTI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CblmJYR++/Hf02+dZkSH3Ep4dvzp/X7vI70oQcRjfQ7wcx79RTSDPsxHbP0BBBHIdSwhOBiPEYwZBR8OugLEDE+IGzxZby2y3H9mP3WT2Emkp7Me4RJFDOGdW6yqgxLBg35tbXkjeRIQh83zW7g+7Ue+ASnFtI2iU+jVhHYL9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nFvQghFT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469J6FOT019368;
	Wed, 10 Jul 2024 06:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QB9JUyvbnuDaOmcNoe4mKX
	FWB92oreA2hqkTX9DQOg8=; b=nFvQghFTGjZH25Qd83EnPWWOEhZCR/VPaejCr0
	Qq5SOscY1pFupEc3+6LObesOESwG5osAz6Ve9Y9Bo0FKNsvzErQVdGB0MzU51YBh
	AJkw4Ph0OnB3PRVsH9R8YCK5y21Bk9m/F64BLyERAEu/fHVTYk0U4hyFwGA0+6DX
	QLdDQ5fUIhtzMFdOb1RCthPfkiVk0awV5s+jV4Ouy32NM27X5mCR3vOQQiGsmdPV
	hKE+xewWOT6OyJnUZ+THP69Uk4mh7kylF4HS1cILmZtcYDq3OlHmLF9uq5tG98qB
	7uv2ZoQfu4yy5PDn9u4yAtgDR26nZNAbSiYtEM0NrLVJLBRw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg40kmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:11:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6BMgo030726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:11:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 23:11:15 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <ilia.lin@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <neil.armstrong@linaro.org>,
        <otto.pflueger@abscue.de>, <abel.vesa@linaro.org>, <luca@z3ntu.xyz>,
        <geert+renesas@glider.be>, <stephan.gerhold@kernkonzept.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v6 0/9] Enable CPR for IPQ9574
Date: Wed, 10 Jul 2024 11:40:53 +0530
Message-ID: <20240710061102.1323550-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: knK5xCGET52fXBUMaEU4Qlwp0x1ZmuSn
X-Proofpoint-GUID: knK5xCGET52fXBUMaEU4Qlwp0x1ZmuSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100046

This series tries to enable CPR on IPQ9574 based on the drivers
posted in [1] - Add support for Core Power Reduction v3, v4 and Hardened.

dt_binding_check and dtbs_check passed.

Depends:
	[1] https://lore.kernel.org/lkml/20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org/T/
	[2] https://lore.kernel.org/linux-arm-msm/20240703091651.2820236-10-quic_varada@quicinc.com/

v6: Update depends to Konrad's V15
    Rebase on top of V15
    Change 'acc_desc' check to accomodate v15 changes

v5:
This series tries to enable CPR on IPQ9574, that implements
CPRv4. Since [1] is older, faced few minor issues. Those are
addressed in [2].

Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/tree/4de50be55a89eb29ab0d40d3fcfe9aa7a9ccf910
	[3] https://lore.kernel.org/linux-arm-msm/20240703091651.2820236-10-quic_varada@quicinc.com/

    Drop 'dt-bindings: opp: v2-qcom-level: Update minItems for oloop-vadj & cloop-vadj',
    the [3] dependency listed above. It should be squashed into [1]
    Add acc_desc is not NULL check in one more place in cpr_probe
    Update one commit message and add acked-by, reviewd-by

v4: s/cprh/cpr4/
    Create new match data for ipq9574 that includes genpd_names
    Update cloop-vadj & oloop-vadj with minItems

v3: Fix patch authorship for 2 patches
    Include CPR3 file changes done to Konrad's patches in https://github.com/quic-varada/cpr/commits/konrad/
    Change url for [2] to skip the cpr3 file changes

v2: Fix Signed-off-by order in 2 patches
    Update constraints in qcom,cpr3.yaml
    Add rbcpr_clk_src registration
    Add Reviewed-by to one of the patches
    Not adding Acked-by as the file has changed

Praveenkumar I (2):
  pmdomain: qcom: rpmpd: Add IPQ9574 power domains
  soc: qcom: cpr3: Add IPQ9574 definitions

Varadarajan Narayanan (7):
  soc: qcom: cpr3: Fix 'acc_desc' usage
  cpufreq: qcom-nvmem: Add support for IPQ9574
  dt-bindings: power: rpmpd: Add IPQ9574 power domains
  dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
  dt-bindings: clock: Add CPR clock defines for IPQ9574
  clk: qcom: gcc-ipq9574: Add CPR clock definition
  arm64: dts: qcom: ipq9574: Enable CPR

 .../devicetree/bindings/power/qcom,rpmpd.yaml |   1 +
 .../bindings/soc/qcom/qcom,cpr3.yaml          |  35 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 269 ++++++++++++++++--
 drivers/clk/qcom/gcc-ipq9574.c                |  39 +++
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   7 +-
 drivers/pmdomain/qcom/cpr3.c                  | 149 +++++++++-
 drivers/pmdomain/qcom/rpmpd.c                 |  19 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   2 +
 include/dt-bindings/power/qcom-rpmpd.h        |   3 +
 9 files changed, 502 insertions(+), 22 deletions(-)

-- 
2.34.1


