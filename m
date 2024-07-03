Return-Path: <linux-pm+bounces-10503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF2D92564A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142871F21BCE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1713D529;
	Wed,  3 Jul 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h2y/H188"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016B13D2B7;
	Wed,  3 Jul 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998269; cv=none; b=HwQS54isXSbL90faFgMI/LWmxtiIKJz49twanCr526olcPa4cdhQULJzcJG3LwdsVdtmxSE0UUPDGXtVZoO52WZXTnRtWjaQchQkf9qdGo0M1njNBDCkDYsGtzJhZrAi5P1hSYSkZgqyWhlkSmklORiNbDhDSqzmlDmrAipIhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998269; c=relaxed/simple;
	bh=Giq0YZ8UqpivqKH5CEyQKPNid4kcnWD78n3S1MlXmbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lesE7cd5vw9wFO0MmnOrQPnCdQmS7ZG6djAHFuUfE6jWJyEiVtL2SWef2aj4Jkwno/Lhjd6iR4Wk7IDfDTpU0qBQl6jegEglfnNH+Y0Ty1MneSd8XEacst01WXXwMAQCN3+BE2PFTWcPqiZC3DvtRSQo/5Xo2Amua5ydih1NXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h2y/H188; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4637DYa9017281;
	Wed, 3 Jul 2024 09:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4f5DlQItyyZlA7LId3xN7drZuYBh2CJ4GP6ktbkqadA=; b=h2y/H188MfjIhh+s
	rfuIhenZbn5mUj/gQwVpnxsU2F0NM4YAkJqTY4aNUTBMvs2mwFt0IAD4bfJK3l8z
	J5qU7oAQiYSJy184QrqenyiSxc5Ohw47cEuLPpXdayTSUrFaL8SCIDYogvEo7U7b
	GQPd9zFLiBB4EFa4ZQHHEtjBFdH+m0eCq+sK6zrjxee/usJxepB1fuixxp+1Z98W
	KFJG3C3x5gXPFOUCjxbUfAE1MwGtCaI8ScWdHWdusrcK8rDjsLlkviaxedr5lcC2
	K2lk5dP2RIap1dDtuWRASeD0eRO0NyhkOBwtR7ZXN8V1BC1UlMiTdTvSoIIVqoAI
	LaFJoQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402an78axe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:17:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639HXUF017611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:17:33 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 02:17:25 -0700
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
Subject: [PATCH v4 01/10] soc: qcom: cpr3: Fix 'acc_desc' usage
Date: Wed, 3 Jul 2024 14:46:42 +0530
Message-ID: <20240703091651.2820236-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703091651.2820236-1-quic_varada@quicinc.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: WLONT5ZvO0_rSTIEmWnqTtM1RORZSecx
X-Proofpoint-ORIG-GUID: WLONT5ZvO0_rSTIEmWnqTtM1RORZSecx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=718 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030068

cpr3 code assumes that 'acc_desc' is available for SoCs
implementing CPR version 4 or less. However, IPQ9574 SoC
implements CPRv4 without ACC. This causes NULL pointer accesses
resulting in crashes. Hence, check if 'acc_desc' is populated
before using it.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: Undo the acc_desc validation in probe function as that could
    affect other SoC.
---
 drivers/pmdomain/qcom/cpr3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
index c7790a71e74f..6ceb7605f84d 100644
--- a/drivers/pmdomain/qcom/cpr3.c
+++ b/drivers/pmdomain/qcom/cpr3.c
@@ -2399,12 +2399,12 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 		if (ret)
 			goto exit;
 
-		if (acc_desc->config)
+		if (acc_desc && acc_desc->config)
 			regmap_multi_reg_write(drv->tcsr, acc_desc->config,
 					       acc_desc->num_regs_per_fuse);
 
 		/* Enable ACC if required */
-		if (acc_desc->enable_mask)
+		if (acc_desc && acc_desc->enable_mask)
 			regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
 					   acc_desc->enable_mask,
 					   acc_desc->enable_mask);
-- 
2.34.1


