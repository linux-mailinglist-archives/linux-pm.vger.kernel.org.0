Return-Path: <linux-pm+bounces-10502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8F9925646
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0829B21995
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33B13C8EE;
	Wed,  3 Jul 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CHaFFAMF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1516E136649;
	Wed,  3 Jul 2024 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998266; cv=none; b=BTh4evJRWdohubpkFd6I9ZRuGyr4TNf0mUFk0huptLR7So+qA5kDG48e4JqeJT+iAAgT4PWo9MonffJw02ne/M9JASgCy+H5bBnMQ+goxOpmIw50/npU1Etf6JosF2wTQn8zqA7V6QySlgLM+Zi5YZ+9OyG8fqs/hmx7z1ruVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998266; c=relaxed/simple;
	bh=oE6/q3bTRtR3dW9baI0zUJRzXNi1NNKxb3kn55LGhe8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnJJlEmSxcfB1LRZJJFVkSYr0C9/Fa/PwJY5ULdtchVv7/quiRO5LsdTFvRizPMKNg1IgZ8IslM5dKn1KiYMyBpn8Ugl6o3BYk3FLcn3vbGaEonXlhgyQTzLoqucIkoTWsMB1s1Re4ffHUYp73oLdwtQC6OevzHLaQU1hb4oWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CHaFFAMF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463002d3025449;
	Wed, 3 Jul 2024 09:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OeG8x0o9x2boiA+S+aRCwa
	pAdprouPAYd76jDKf7wuM=; b=CHaFFAMFl8sbdV2KfVe9XaqKm+2eRmEyjV5YXt
	AWJXB33/eIGCYXpGd+MXz+AibOY2sqGJPy5LsRnQw9FzVk3v9c7B1tX9HjyV38Ds
	8yywvefhTUMKFp2/ffhpQr41+ECD7i2b9pE5VwB3LT4pdFXlsBK+aNhtj04pnT3f
	j+U2Edy6ZzXUsZ2XmO0bNOGpEoWn2QodjY6faOnizTwkAWnWt5kz6zrWkKLEMl/e
	2JO4a0BbzlbaecdmRYqJWVxQcnMQ8axRxLgbA2AKcfUuJl6Gxaczq1OnAXdQlbD1
	3yvH4TtnTbp2KmIsVa9/6Ra1YNC7XCNsh3OGK/axBi1EoP6Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402an78ax8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:17:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639HPeT027670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:17:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 02:17:17 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_rohiagar@quicinc.com>, <abel.vesa@linaro.org>,
        <otto.pflueger@abscue.de>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <quic_ipkumar@quicinc.com>,
        <luca@z3ntu.xyz>, <stephan.gerhold@kernkonzept.com>, <nks@flawful.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v4 00/10] Enable CPR for IPQ9574
Date: Wed, 3 Jul 2024 14:46:41 +0530
Message-ID: <20240703091651.2820236-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: k6Gqw8JX5179wjP76TTAYDCv3AAjd4GY
X-Proofpoint-ORIG-GUID: k6Gqw8JX5179wjP76TTAYDCv3AAjd4GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1011 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030068

This series tries to enable CPR on IPQ9574, that implements
CPRv4. Since [1] is older, faced few minor issues. Those are
addressed in [2].

dt_binding_check and dtbs_check passed.

Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/tree/4de50be55a89eb29ab0d40d3fcfe9aa7a9ccf910

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

Varadarajan Narayanan (8):
  soc: qcom: cpr3: Fix 'acc_desc' usage
  cpufreq: qcom-nvmem: Add support for IPQ9574
  dt-bindings: power: rpmpd: Add IPQ9574 power domains
  dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
  dt-bindings: clock: Add CPR clock defines for IPQ9574
  clk: qcom: gcc-ipq9574: Add CPR clock definition
  dt-bindings: opp: v2-qcom-level: Update minItems for oloop-vadj &
    cloop-vadj
  dts: arm64: qcom: ipq9574: Enable CPR

 .../bindings/opp/opp-v2-qcom-level.yaml       |   2 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml |   1 +
 .../bindings/soc/qcom/qcom,cpr3.yaml          |  35 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 269 ++++++++++++++++--
 drivers/clk/qcom/gcc-ipq9574.c                |  39 +++
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   7 +-
 drivers/pmdomain/qcom/cpr3.c                  | 147 +++++++++-
 drivers/pmdomain/qcom/rpmpd.c                 |  19 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   2 +
 include/dt-bindings/power/qcom-rpmpd.h        |   3 +
 10 files changed, 502 insertions(+), 22 deletions(-)

-- 
2.34.1


