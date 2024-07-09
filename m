Return-Path: <linux-pm+bounces-10824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD5292B2EE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8201F1F23186
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 09:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6015444F;
	Tue,  9 Jul 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RuDJyog+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286E42058;
	Tue,  9 Jul 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515729; cv=none; b=KooTBoLJ9R053aq7dQ6leNrT26PkEzUY1XxHEzdfWqM3ZicR2Yrzbp82qmsAOQ+CNaE5gwFKd4TQGKCUZujk8n8Yy/kaTo9InPXhQg4/WdG+WWSEthIuZ/+jm6UHqYdQtQA0ldSPUnAlCp5+ByjwaIPSKQMpIsEvQbGepSquf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515729; c=relaxed/simple;
	bh=xPZKDO1rBdxEtfpVAXK5ct854brW6RyqgECqcptbiF4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oCFGJo/vjKghoNX/2iftncFlToeHcZtBgAvBecex+a5mER9LhY2xNE8lSSm3/bu5kar9eQdFf0fVvCHoUGwAqWg3nzYN4Q40jicK7Uj3k7XeNv8e+oGG3+q/FalYYkxXYiaZgYNI+dauHvGU55Dirzg7Y2WMNET6zgXqJy0/VOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RuDJyog+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468Mo2uY015544;
	Tue, 9 Jul 2024 09:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t4ItbgcS6sb44X3LFsdLAj
	gu1Or45UdpeGhQsybDCZI=; b=RuDJyog+N6D4ej4l2CPitwav1gw7qfvyzhmFFI
	j6gcB1m0E9vIO09T+hs2meZt67YswgrvZOk72/+Oetq2jk9sAF0wpIly4TYaaWus
	eE1KubixNESOrfku2ZgU0TyGEkZf3ydmTT/HA+B3pybwlMPIhZZZhuZCaeeWIfrp
	Z3bPRD6/pVeTY7D4f9W7pG99YL0ticX/QEdkXRmCEQ2hJO6h+2Yxqlyc5FzGGS8G
	0VqpkKWF0TXUBoj/leRtTMqQHStW9PZTqKbnIvUGH45RRYK5amkk9cB1x86yVa59
	EQwiq+Z8lkP5C1Cc6T8bWB6TieeWJVt4nPUquYOF8wWcwXYQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8wtjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:01:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46991qSD008919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 09:01:52 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 02:01:44 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_rjendra@quicinc.com>, <otto.pflueger@abscue.de>,
        <luca@z3ntu.xyz>, <danila@jiaxyga.com>, <quic_ipkumar@quicinc.com>,
        <stephan.gerhold@kernkonzept.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v5 0/9] Enable CPR for IPQ9574
Date: Tue, 9 Jul 2024 14:31:23 +0530
Message-ID: <20240709090132.117077-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Yvry-qDnF5gN3HvHP_iIkLxXvdKShS3Q
X-Proofpoint-GUID: Yvry-qDnF5gN3HvHP_iIkLxXvdKShS3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090060

This series tries to enable CPR on IPQ9574, that implements
CPRv4. Since [1] is older, faced few minor issues. Those are
addressed in [2].

dt_binding_check and dtbs_check passed.

Depends:
	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
	[2] https://github.com/quic-varada/cpr/tree/4de50be55a89eb29ab0d40d3fcfe9aa7a9ccf910
	[3] https://lore.kernel.org/linux-arm-msm/20240703091651.2820236-10-quic_varada@quicinc.com/

v5: Drop 'dt-bindings: opp: v2-qcom-level: Update minItems for oloop-vadj & cloop-vadj',
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
  dts: arm64: qcom: ipq9574: Enable CPR

 .../devicetree/bindings/power/qcom,rpmpd.yaml |   1 +
 .../bindings/soc/qcom/qcom,cpr3.yaml          |  35 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 269 ++++++++++++++++--
 drivers/clk/qcom/gcc-ipq9574.c                |  39 +++
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   7 +-
 drivers/pmdomain/qcom/cpr3.c                  | 146 +++++++++-
 drivers/pmdomain/qcom/rpmpd.c                 |  19 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   2 +
 include/dt-bindings/power/qcom-rpmpd.h        |   3 +
 9 files changed, 499 insertions(+), 22 deletions(-)

-- 
2.34.1


