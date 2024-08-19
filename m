Return-Path: <linux-pm+bounces-12404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D049563AE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 08:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B1E1F21F76
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 06:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5398156C5F;
	Mon, 19 Aug 2024 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vw3k8iUf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2115575B;
	Mon, 19 Aug 2024 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048631; cv=none; b=pV2J1w5O6X9hTkfYCILfdW1iruZYwqXkC/YzEY8O93Tfcl7CU8E6Mdt9Y04JsBAPqN3CNKAwwSgp0x6FjjAst2zJxTPhbdLKfX8NWhUVZJr9nheRHveWJikwRWfX6CvTQ8gn/TYMT4OFEzW/JSSNeRQZzVsmrOjnLUL4LFYoYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048631; c=relaxed/simple;
	bh=X4FazFzXFBrFIDymNcE3aAJDAA/4gZxS51gkJ3YUXjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CEo/hH7B4jiV0AVXLWjzKE/iMN98ekBFv5n1wnLljAwY+EKLpjSWmHwGTuPMQDl81NIaWOkl6R9Avt3tdLFK8yzx0wAzAIGq12Yr7J5uONC1uOpbqweMJrJtZ6NNoziVeyHSvoIQ+Npi70TEfIYxHVwkpiro77OTYCiVKVHMZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vw3k8iUf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J0BEgw014847;
	Mon, 19 Aug 2024 06:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=MepeBszfSDfXc0P295OU6NN7o0ZjiJbyQfKnN+7BT0w=; b=Vw
	3k8iUf9UluNi1ckP9UfjnWxnVS4uyPjRcPg7uJCpx7wgPpqajqH2qZArGp7HPrc+
	A8CtOTGXI6iahHfbqkUXgBMrWUKQnaQKGoOlcrYAgNVHH3HqPxgLNFSx8nZgvGo1
	74kvBIaomXW8MMfXNJv+kaUNQEw4sTfyF+4jBUPbWiLBzOB1Fq47sC7VCPKObTgL
	5/N5xLvKBT5R1bJjZHnk6k8swmB0DcfrYoEslManIog/qwiPXHmilDTY+ZCOe4i5
	qiK9wge6pv4Muymbiia3P+vrZfcyf94PrEAIFrT9Km3fj/vgvo39c2Q7l2gEVxeo
	ZplNtZZXTPzOZkgrJnOQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412k6gb76c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 06:23:41 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47J6FiPG003844;
	Mon, 19 Aug 2024 06:23:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 412mxkaptd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Aug 2024 06:23:38 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47J6Nc64009859;
	Mon, 19 Aug 2024 06:23:38 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 47J6NcGv009858;
	Mon, 19 Aug 2024 06:23:38 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 688C4359D; Mon, 19 Aug 2024 11:53:37 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
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
Subject: [PATCH v3 2/2] media: venus: use device managed APIs for power domains
Date: Mon, 19 Aug 2024 11:52:46 +0530
Message-Id: <1724048566-5035-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1724048566-5035-1-git-send-email-quic_dikshita@quicinc.com>
References: <1724048566-5035-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sSpyHwyu4kpPH5l06zD9M0TZaty3ic8I
X-Proofpoint-GUID: sSpyHwyu4kpPH5l06zD9M0TZaty3ic8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_02,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190045
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


