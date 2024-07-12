Return-Path: <linux-pm+bounces-11024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D170E92F529
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 07:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868F61F226F7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E981B28D;
	Fri, 12 Jul 2024 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CM6nTm65"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DC18037;
	Fri, 12 Jul 2024 05:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763360; cv=none; b=miykWwrO81DkHH6x6QJOZUW9jhfN1wVFtuTEE5cycYlnrWPfQqAooHeJJ7u1cQqduTz+wm4hwkdnXjhpYe52v8VNiFqZIjJ5vWC4ExlsY43OiI9yQOH7W4+mfgTSUa6gAObkEPvnhSKIEnwsyo8POoO8fblveTQggY0EPha4LJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763360; c=relaxed/simple;
	bh=+7i/mvK4BO4EMLBary6X/275tjfAShPzIcCzHahTn+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dF/15rSIJB/kROZSb5J19IJa5aqlesurQeF6+08dIadjRJlZBBmDleN2g3aLSV65tED55O0UNA+qdKUMjCQwikwWt1MQEh4mxgus0Lk73a8Q10gWGRVTOuKoSDGgpzkv9CICTv4NsErOQwxCIZAJC2Qcc6vi4LMMu+DzLBkbi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CM6nTm65; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFmjKq000963;
	Fri, 12 Jul 2024 05:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=YZm05wKfpUPfrH6+CM0Xd1DQY1Cb9vjcNUETxPetjZQ=; b=CM
	6nTm65X/kTmy6Nl0AeH4Kyg33kAIuvmM7jXXY0cf5SMzskfe+8h0NwqMFMWQaq/c
	viPDErLvWwSpmvdSKiaHJkcOb3g4cgKq1dHzrxuZffqJgy6Z48+n2+Nw1Mm51Pr+
	AWs1zkuk5R9o2O5lbKTOFOiMkKLU5ThNBAT4GevUwm/a8u22Wst6r9o86u+0XlhD
	0ZI8Y6KdJ9eZN8iFh8aUFu6mWBsMyjTzqPQyYw/in95+Xs90oCUmj16tOurzY5zK
	vkI7EMvuxQ4hpDeUOYomEjAZBUUvaOMYcw2AQPjjT3MHvxtN73dCS00FkghuWbMc
	NAT3eFl2KTIK80S2M9vQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ajbqscq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 05:49:08 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C5n5Ya020472;
	Fri, 12 Jul 2024 05:49:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 407g4fvapw-1;
	Fri, 12 Jul 2024 05:49:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46C5n5AW020459;
	Fri, 12 Jul 2024 05:49:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 46C5n4Lf020415;
	Fri, 12 Jul 2024 05:49:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 076BD1B38; Fri, 12 Jul 2024 11:19:03 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] media: venus: use device managed APIs for power domains
Date: Fri, 12 Jul 2024 11:18:31 +0530
Message-Id: <1720763312-13018-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9kE_piSDuUtR_aKSGxwXWGlckeaNex5t
X-Proofpoint-ORIG-GUID: 9kE_piSDuUtR_aKSGxwXWGlckeaNex5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120037
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Use devres-enabled version of power domain attach APIs.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 5028220..86221e0 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -869,7 +869,7 @@ static int vcodec_domains_get(struct venus_core *core)
 	if (!res->vcodec_pmdomains_num)
 		goto skip_pmdomains;
 
-	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
+	ret = devm_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
 	if (ret < 0)
 		return ret;
 
@@ -895,14 +895,11 @@ static int vcodec_domains_get(struct venus_core *core)
 	return 0;
 
 opp_attach_err:
-	dev_pm_domain_detach_list(core->pmdomains);
 	return ret;
 }
 
 static void vcodec_domains_put(struct venus_core *core)
 {
-	dev_pm_domain_detach_list(core->pmdomains);
-
 	if (!core->has_opp_table)
 		return;
 
-- 
2.7.4


