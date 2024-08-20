Return-Path: <linux-pm+bounces-12510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B3B957D0A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995CF1F235F7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797E14B96F;
	Tue, 20 Aug 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aNGZzngp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79D146592;
	Tue, 20 Aug 2024 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133462; cv=none; b=DqxOq37XXRcq9MR99hOfCH/m3Ssmd6tj+gOa3rGXbF3To9GzZmBaY0sjai1scVp0HgGwiI7KZ/6TgI4cXFPXcZF7ujoA+G6Ub3Mc7CKGiKtEb0vV/tBHZ0YvaI/5Prox/7tbxonBJsNACR70tLdZO1Qu2EAPje2timCZv9vtE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133462; c=relaxed/simple;
	bh=91epV0YrD2KID9k9n2lK9yycvdPbSbJ9b37tZA2rhRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RF0eOFBV9MdXrKtMB+Qj1x580fpBT8uxc/IwrxzvjeU5nlrK8AHY0vKk8AG5F9OLeCWfg65/g2Lk4FRS7z/WmUMgYawEPFmwQVzJ5Il5mqdvQwXTwgPfyDdByRmihl/xgsaHeRKfhN6JvGXxOXjeISJUpTZsdzmiilfkMWoTsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aNGZzngp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K4CBJn003639;
	Tue, 20 Aug 2024 05:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sUnGEdO6hbsOu7bGqhWkGx
	aAvvMXqOl1eWN2LREwe2M=; b=aNGZzngpU8PIhLqF6XQoUrRKXuII8QJG0cKZfV
	4kD8xetat2cMpX15TrypD4fmM4qk+GSrfp7CjsTYwpNOKPRE+9m/ALAp/MvFbeTD
	YjzlZ6WE3avsOcfQUJQkj8tkablkV0Tu831MCbfKUvsm/5gDHRQq9jM5OpKhKg6J
	SR4NMjwe9ioH2F4We63d2DSyo6xGzZ8UwLRVE8jONFnnkKBRatBYIBYKIMXuL9x8
	0XQFlsiNl9cVpRtifszsXWzq80Fo7JCLx4fd3tI3H7TRambZU9Ndz4eqHpSThKct
	kE6AfujDXUT19u5Q5kaRCvql0CcsI9OVfwqhFNqpfKOE7wrQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4145ywa8cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 05:57:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47K5vOIV005003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 05:57:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 22:57:19 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v7 0/7] Enable CPR for IPQ9574
Date: Tue, 20 Aug 2024 11:26:58 +0530
Message-ID: <20240820055705.3922754-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: HahLJWQ5ZF5wL7oZ0uEYWI-kUAcBw0Nw
X-Proofpoint-GUID: HahLJWQ5ZF5wL7oZ0uEYWI-kUAcBw0Nw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200044

This series tries to enable CPR on IPQ9574 based on the drivers
posted in [1] - Add support for Core Power Reduction v3, v4 and Hardened.

dt_binding_check and dtbs_check passed.

Depends:
	[1] https://lore.kernel.org/lkml/20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org/T/
	[2] https://lore.kernel.org/linux-arm-msm/20240703091651.2820236-10-quic_varada@quicinc.com/

v7: Remove RPMPD per https://lore.kernel.org/linux-arm-msm/iy3l3ybmvllqxtyqq7fifiokxaaedrs22davveel4ikjoqivdm@dinswoc52qpz/
    Add rangeuV values
    Fix IRQ handler 'argument'

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

Praveenkumar I (1):
  soc: qcom: cpr3: Add IPQ9574 definitions

Varadarajan Narayanan (6):
  soc: qcom: cpr3: Fix 'acc_desc' usage
  cpufreq: qcom-nvmem: Add support for IPQ9574
  dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
  dt-bindings: clock: Add CPR clock defines for IPQ9574
  clk: qcom: gcc-ipq9574: Add CPR clock definition
  arm64: dts: qcom: ipq9574: Enable CPR

 .../bindings/soc/qcom/qcom,cpr3.yaml          |  35 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 234 ++++++++++++++++--
 drivers/clk/qcom/gcc-ipq9574.c                |  39 +++
 drivers/cpufreq/qcom-cpufreq-nvmem.c          |   7 +-
 drivers/pmdomain/qcom/cpr3.c                  | 151 ++++++++++-
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   2 +
 6 files changed, 445 insertions(+), 23 deletions(-)

-- 
2.34.1


