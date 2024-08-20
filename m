Return-Path: <linux-pm+bounces-12512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EA6957D17
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3322C285980
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C264158541;
	Tue, 20 Aug 2024 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iRYuDQgo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852EB156F46;
	Tue, 20 Aug 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133467; cv=none; b=u6rzeCKrbZ61NkPSx92grV4XMlRnjhk+zdxhj/7wt86f+3a5vPsjiwx6h+O7tqTSP1LWufhjV5y4vdS83L7FNuMUKUnTuLBJnMBL92981WNFkBSu1tu3hOZjlrU505tELJfXBJ8JIydaxG36z/88Af6quwpyWcssXTcZCJfEvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133467; c=relaxed/simple;
	bh=vFRk7/rTQDrTZ8HK/TrY2TGAPfKllCdDSB87qCjJ2fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAZ3NvLFYPq/cl6rFv/j3e2MWQ1qeX5d6lOoScMPy+2ns11oJ0W/QtpN7nsykVZ/1caEsEFhiA3LV/NULkPBKBcpnVq3Qh9jwz6mdiFDzEORigF/fN2T3daIbT21sixAOCwp/csjtMvvJ37VNNvL7I3bAQ+ImZQmnnefJuXTk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iRYuDQgo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K0jEJx007676;
	Tue, 20 Aug 2024 05:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1MvwAaE9Ic1qgTdPu5/tkjDHPI+KygVcOLxNMwan3Rs=; b=iRYuDQgoB6jDer/U
	aeskgrC5vNfxSlQtjACwZxBb1CoqYNPnKreS8SNWZRHKtlk49nTP2BB4ll4u2UZe
	OMagLlsNfWfnvmOn7TOhNqaeiSx9SUJ4+OLdCshJfXEcq/AzbqFOy2JQLhNayFKZ
	0SaUH9utuWBL3w5BF0EYAGdX9G/GFbGA6px6dNj0vKQdFSzA5HclDhGLUEPtgx6o
	ntegMQymb1ylJryEOgY/Do5U3A/7RsPNrKmOj4WU4E/9SqfItHC7D2h6bnl3GWwn
	HRH9Cls3FzCe9VOoRfqC7gVWTs2L4WCtbtJVedun5u7xQLMZPY90fB3AO9AD+vMe
	c7o44Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412mmepau2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 05:57:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47K5vTg3005046
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 05:57:29 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 22:57:24 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v7 1/7] soc: qcom: cpr3: Fix 'acc_desc' usage
Date: Tue, 20 Aug 2024 11:26:59 +0530
Message-ID: <20240820055705.3922754-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820055705.3922754-1-quic_varada@quicinc.com>
References: <20240820055705.3922754-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: D0TeAvaiLQabh_lLSPkxPT9lW6rsNuH8
X-Proofpoint-ORIG-GUID: D0TeAvaiLQabh_lLSPkxPT9lW6rsNuH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=780 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200044

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


