Return-Path: <linux-pm+bounces-10904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A4F92CA74
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 08:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C91F239BC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 06:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D557880;
	Wed, 10 Jul 2024 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lmNM1aI4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A73FB30;
	Wed, 10 Jul 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591913; cv=none; b=fQJtcIqdkoMRjo5luijPPU5hAHA5MCUp5AGgTC93u5Fjm0cz291dcn85Qunvii4wLbBtKE4Er00LNHSShc44057T/3gHro+taiurKHRf9H3rnp0khtEnZgRihXNTN5xkJLDCpTt60nM8ru21cVVydVGgdMqTvKr5IgY5IQafpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591913; c=relaxed/simple;
	bh=vFRk7/rTQDrTZ8HK/TrY2TGAPfKllCdDSB87qCjJ2fo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQvu6k6jLqRZ9L/7rALEg6+HFdozBLpBnKQSnkBjZ7ysaJnKUEaV1+5oKfqNoMYdgFQx5ysRvGoOGyZORgpU0p6eXh8wZfu58cZyEaLNPRmvKQai9TmNOqxREnfu8dFUiXawSfJycbpgUWJ7wYz5wA1b6h+cxIQsl00yRv9Endg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lmNM1aI4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4aA9J024317;
	Wed, 10 Jul 2024 06:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1MvwAaE9Ic1qgTdPu5/tkjDHPI+KygVcOLxNMwan3Rs=; b=lmNM1aI4NKjzbUYX
	Z0ovK8fYtmKp2A9/TCQ/wO0mokyz03BNrf0fl05sIvCwO9LCpT2UHnDgw/wt4tbf
	UCbCwvFifXQ5LlKi4z+nh5p1j0AcJNtlR9WCvzg/OwW0D1m9kerxiXJ8yFyX9Q1N
	1ab7mK3hRev4HtfE6GkJ38w2DTx7ZF6fwzE4H7SYU+k/ihJDhn8XXQoLQ+ZbFhUG
	HRSltAn+CprJtp2mC4GDj8BW4JmfDMtlbl4tYVZXksD8BPzgENuB0IO+y6Z/KwMj
	qxuFhN2fqvJGBHfGpIgq1Y4Y015FBKWN/kFfOCwYSUnGCDXw2e9ZboBgE7V5LiqT
	zos+jw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409kdtg53t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:11:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6BUG2025378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:11:30 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 23:11:22 -0700
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
Subject: [PATCH v6 1/9] soc: qcom: cpr3: Fix 'acc_desc' usage
Date: Wed, 10 Jul 2024 11:40:54 +0530
Message-ID: <20240710061102.1323550-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710061102.1323550-1-quic_varada@quicinc.com>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JlH7gqpMAYf1YCXz-0G8v0DbAN2Qoo5C
X-Proofpoint-GUID: JlH7gqpMAYf1YCXz-0G8v0DbAN2Qoo5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=782 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100046

cpr3 code assumes that 'acc_desc' is available for SoCs
implementing CPR version 4 or less. However, IPQ9574 SoC
implements CPRv4 without ACC. This causes NULL pointer accesses
resulting in crashes. Hence, check if 'acc_desc' is populated
before using it.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6: Changes done in the previous version of this patch got squashed
    into Konrad's V15
	- https://lore.kernel.org/lkml/20240708-topic-cpr3h-v15-9-5bc8b8936489@linaro.org/

    In v14, cpr_set_acc() was invoked from cpr_pre_voltage() or
    cpr_post_voltage(). Both of those functions invoked cpr_set_acc()
    only if drv->tcsr was not NULL (and that implied acc_desc != NULL).
    In v15, cpr_pre_voltage() & cpr_post_voltage() have been
    removed and cpr_set_acc() is called even though acc_desc
    is NULL resulting in NULL pointer access.
    Hence allow cpr_set_acc() to proceed only if acc_desc is set.

v5: Add acc_desc check in a different way without breaking other SoC

v4: Undo the acc_desc validation in probe function as that could
    affect other SoC.
---
 drivers/pmdomain/qcom/cpr3.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr3.c b/drivers/pmdomain/qcom/cpr3.c
index de24973978b7..d594bc79be1c 100644
--- a/drivers/pmdomain/qcom/cpr3.c
+++ b/drivers/pmdomain/qcom/cpr3.c
@@ -536,12 +536,15 @@ static void cpr_corner_restore(struct cpr_thread *thread,
 static void cpr_set_acc(struct cpr_drv *drv, int f)
 {
 	const struct acc_desc *desc = drv->acc_desc;
-	struct reg_sequence *s = desc->settings;
-	int n = desc->num_regs_per_fuse;
+	struct reg_sequence *s;
+	int n;
 
-	if (!drv->tcsr)
+	if (!desc || !drv->tcsr)
 		return;
 
+	s = desc->settings;
+	n = desc->num_regs_per_fuse;
+
 	if (!s || f == drv->fuse_level_set)
 		return;
 
-- 
2.34.1


