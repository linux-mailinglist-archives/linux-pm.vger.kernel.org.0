Return-Path: <linux-pm+bounces-12419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B2795688C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662161C21F03
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFC71662F7;
	Mon, 19 Aug 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="poQCGpxn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A6165EFA;
	Mon, 19 Aug 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063374; cv=none; b=gyszPKpOSubgjrQxYgQKTBfSRELtbVXlyrgSJt59vTSWs6gUwJR6w0Rklijhy5u1I/FIg80DRNNs7Z098UjwUlDfOA/pfQ17LtuVgswLPwK7hGFklklEwzykJXF4wETI+JxbEqg4UgLdDSH6sd4lDMR7y1V1RZvmuMsAWSBvO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063374; c=relaxed/simple;
	bh=X4FazFzXFBrFIDymNcE3aAJDAA/4gZxS51gkJ3YUXjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AnRYehdL8bHBxzq5g6QNbp3D8RHpacwhW68SHHo9AvBUQCAKvLhJkQb9py8ATlPwDVVwE9EUp5wJzoF2y9UhW0f7P9+nHi1UwUaBUdBpTsX/dRnR2xI9fRNoRJYhPRNCfXJaVEyqZwhAhXtP4DkSfo6xJOLcJFDV2CrHUAvBgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=poQCGpxn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JARZAL032383;
	Mon, 19 Aug 2024 10:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=MepeBszfSDfXc0P295OU6NN7o0ZjiJbyQfKnN+7BT0w=; b=po
	QCGpxnrJuC8Uz1L4CKQE1sHaHpG6jOuzAUN1NC+//lnhfsOS2G5tkfQ18erYo3on
	cPUBXLILxUY5S1gBlZQZ3VWAO8YfDjVqDsR/m0O1R13TiVHWhPCP9CuDTGNzH71U
	1FUFTMHVW5ajjasZqcFr7PPwOQcVwTeXXQWeHz2NNTdV5mAvRcUgaWIwnqhjEfLy
	VJ6rA7xFmklWl1BNHcxyM4LXeSxGVzItUhvV2vdYKsV7nCubWdcxllHHGKQk/Qnt
	K53poxd9NaAZ+xRCO1iXb2F1PUmPKFpCvlRzEBThkfrBh/VNaqQ8cm4KFz8i03Uw
	Iw5+xJTGgUA0rcI5jUDA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412m873tmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 10:29:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JATIo8015723;
	Mon, 19 Aug 2024 10:29:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 412mxkbftb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Aug 2024 10:29:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47JATFMo015305;
	Mon, 19 Aug 2024 10:29:17 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 47JATHIh015713;
	Mon, 19 Aug 2024 10:29:17 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id C42F43474; Mon, 19 Aug 2024 15:59:16 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v4 2/2] media: venus: use device managed APIs for power domains
Date: Mon, 19 Aug 2024 15:59:10 +0530
Message-Id: <1724063350-11993-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1724063350-11993-1-git-send-email-quic_dikshita@quicinc.com>
References: <1724063350-11993-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uiiew0fyT4wHdUV9RoCkr1jDPExags_1
X-Proofpoint-ORIG-GUID: uiiew0fyT4wHdUV9RoCkr1jDPExags_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_10,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190069
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Use devres-enabled version of power domain attach APIs.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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


