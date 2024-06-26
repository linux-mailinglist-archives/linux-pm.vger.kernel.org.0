Return-Path: <linux-pm+bounces-10037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5C917E5D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A9428AA4F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30135171E7F;
	Wed, 26 Jun 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W3QMCs7G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220821662F2;
	Wed, 26 Jun 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398450; cv=none; b=Rn0MUAzz3dXwbTpIY6mDohlUHgZ+PeQ+hBOKJm2ZXZTicUpsFzdsWEgu2ZZ4tYy2VRTixbMKXmpDEnmZH5ihRbSrPtIvafILNk21mQYl8n5kMT+Ipxh2Ljxp9nnAeXPMxwJc9BRBEmqITZjGeSLlV4ZGvr+f5mLHnVrEXJk3TAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398450; c=relaxed/simple;
	bh=zCRL9/gXXtpPFsNeeqMdUUs3CU4qGSxZACUdLNNnGtw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ua8+RqLlW5v8UWbLGnDiH7+J/5s6yP8z3v8s+NsEn7UgZlpCC1S/PLdwuPnjJ5gmBvB0c6v8jsjG5thuG/IUhqI4kC5svdI/mxrrkyoQQAUo4iumQdsemhmEwdIABvPqk+DYfF3EcC/ap0fcHmfFGHxUImzPNq2GGj4x5dWP3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W3QMCs7G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q6j2a6020260;
	Wed, 26 Jun 2024 10:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dboRyQmNRvfH2Gc3HMujl+
	eIW25tKRzlWNS6UNEYayw=; b=W3QMCs7Gl2a9x3bVIUo1DB8ACr/3MJGWap43c2
	eXtakJSB/lskHAt0dp0VRCsYjLIF+qeo2TuDYyyESpELgfdIC70L8AyCO/YjLg47
	s4nHqFFSC4IufzcphyBk5Kg0VMyk1pIP3HMU7jGRo+f3kxa09b2IJaQ/0BP7YEG5
	ZbX7UU6kWomoeXJ/8flSTJbYh1PR7ml8JAy+8JHPRBzDdA7CRGtCfUFM4WqjPRvb
	ZRMuLnr/wG92ZHnxrWoytHReqhBw4sosOiXwYmn09D4gqe6uWo2Nid+yIY0Z9WEA
	AprVBprhshqxnWSRfyiqookSzN4rkO5inevqpjwjZGjpz2dQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6ys9dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:40:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QAeXQL029081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:40:33 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 03:40:26 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>,
        <neil.armstrong@linaro.org>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <danila@jiaxyga.com>, <quic_varada@quicinc.com>,
        <quic_ipkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v3 0/9] Enable CPR for IPQ9574
Date: Wed, 26 Jun 2024 16:09:53 +0530
Message-ID: <20240626104002.420535-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 3bOWaSWhFbyXxF5Olo9uPfalRHmYkpnj
X-Proofpoint-ORIG-GUID: 3bOWaSWhFbyXxF5Olo9uPfalRHmYkpnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260081

This series tries to enable CPR on IPQ9574, that implements
CPRv4. Since [1] is older, faced few minor issues. Those are
addressed in [2].

dt_binding_check and dtbs_check passed.

Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/tree/4de50be55a89eb29ab0d40d3fcfe9aa7a9ccf910

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
  cpufreq: qcom-nvmem: Add genpd names to match_data_kryo
  dt-bindings: power: rpmpd: Add IPQ9574 power domains
  dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
  dt-bindings: clock: Add CPR clock defines for IPQ9574
  clk: qcom: gcc-ipq9574: Add CPR clock definition
  dts: arm64: qcom: ipq9574: Enable CPR

 .../devicetree/bindings/power/qcom,rpmpd.yaml |   1 +
 .../bindings/soc/qcom/qcom,cpr3.yaml          |  35 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 269 ++++++++++++++++--
 drivers/clk/qcom/gcc-ipq9574.c                |  39 +++
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   1 +
 drivers/pmdomain/qcom/cpr3.c                  | 145 +++++++++-
 drivers/pmdomain/qcom/rpmpd.c                 |  19 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   2 +
 include/dt-bindings/power/qcom-rpmpd.h        |   3 +
 9 files changed, 493 insertions(+), 21 deletions(-)

-- 
2.34.1


