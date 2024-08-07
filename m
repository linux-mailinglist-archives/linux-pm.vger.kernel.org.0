Return-Path: <linux-pm+bounces-11961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A152894A181
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 09:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E81281638
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50091C7B9F;
	Wed,  7 Aug 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pWdftYaN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F801C7B93;
	Wed,  7 Aug 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014974; cv=none; b=kCw6II1eVGh36PrFGlbP1zgONgbE+kHxQoDRnVltvmyXI4fIM/mpLitcVN7K7F9oXgNZsMOyPtQ2iePmsJTIpiCr8IXwvXpR5/3aeDvtDocShn3M+zc1MZ0Ae97zJaZW6A044EWqUZ9deNITp361c4HU033EDZZpWLA8Om3WiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014974; c=relaxed/simple;
	bh=+7i/mvK4BO4EMLBary6X/275tjfAShPzIcCzHahTn+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oTSJC00EbZfDGYhDnFD+KwUeJzZ9dfpvo5nbPWpRZpFZGEmFaPbNIQfomUInzVE70DZaxwPJrSxcM89l/yZ/z92yWCWLt6l777BTLuJAzZW8mgQJ1EG35Su0kTE3VMcT1EdWEQC2vY8L2u/61YAXAqK8N2nTQyTAYNAz05ZDp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pWdftYaN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476Nm9kG001515;
	Wed, 7 Aug 2024 07:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=YZm05wKfpUPfrH6+CM0Xd1DQY1Cb9vjcNUETxPetjZQ=; b=pW
	dftYaNCCtlQfhS74HHB+9Erha+OjBv0lB8cPPiNN0KOUrn/6d+EhXhi2wbsZweOs
	gH3lcBUQnErOom5x0nDfgHLLGQnxnajnjCIyzq+OAQLyIOYNov+7K+fx6/z6PSrr
	sUZK1O33AH8ejd8RFJpxcezHydnvmgW4Ba0/Nqp5Uq3Sm5OARFvJsUahSk+6eZKX
	R4CfANhqqzfvKhmuENmHaFh+mKEZ83ULHAoHGwRPI3Buk/dvzOLuCWr61AtIU9wl
	CWZpM8pXFThkDCWv5/bt9295EweVTbZCkZc/hnjn7lBwDaZTDXlLTYYlaQ9lsuK0
	15bB3BiLyqK3Yp4d9s+A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40tuhvxhvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 07:16:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 4777DP9j026468;
	Wed, 7 Aug 2024 07:16:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40sdmkv9a5-1;
	Wed, 07 Aug 2024 07:16:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4777Ctc6025881;
	Wed, 7 Aug 2024 07:16:00 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4777G0fF030042;
	Wed, 07 Aug 2024 07:16:00 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 4881225A4; Wed,  7 Aug 2024 12:45:59 +0530 (+0530)
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
Subject: [PATCH v2 2/2] media: venus: use device managed APIs for power domains
Date: Wed,  7 Aug 2024 12:45:47 +0530
Message-Id: <1723014947-15571-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SgZoCq7e7buS78MgL-eVbRoHv6jXx-aj
X-Proofpoint-GUID: SgZoCq7e7buS78MgL-eVbRoHv6jXx-aj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_04,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070048
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


