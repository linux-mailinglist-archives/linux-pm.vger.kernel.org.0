Return-Path: <linux-pm+bounces-16731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BD49B6389
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27D01F22481
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877041F131C;
	Wed, 30 Oct 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WfslGTfO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E21EABB7;
	Wed, 30 Oct 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292972; cv=none; b=WpQUVQqnyVPz7pBnCHqAEMBsdPJ+JL1G085+bdiE4cNFmfy+gorD+2UH4gE38ur1SzRRcaVVLeROThJ1sgTaoBN70fjc2KvSym1CX2T3PYJStE9QXYqt3VjM4YfkJnD555QQL0Iu4dg2x+YJaReRR2yLTg4h1N272TFkOait5Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292972; c=relaxed/simple;
	bh=E6K+0tsVDAgt4hw0AvwoxIRQh9stKXfTj7ctPQreTIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQzQz9t1Sf+QVvcjINJleM+R63wTTgIbL4RfyW0w8M8H2yRc2h8nvvuNwz6d4/XIJBjUjVnNkuEU6OMkPq1wZ2spweFAy5URGEN7jeMUrtvCtqB6Ce1FHkgji9sIaefcTO5jUMNw0Gaw1bonohV0a4hfGwXSGoqYve3TKhLIzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WfslGTfO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U8u59u001503;
	Wed, 30 Oct 2024 12:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aWt2d4vJ4hdwE1HZC8EXwL3lO009NGDuGTQoVWKlbao=; b=WfslGTfOCvw4qa7C
	HypG3pR1sx8T13A9mfUvHJLHHbmymxmcmbo6rkWXk2DjGcVU29FCHwkDX2T+zDO+
	VfZKEZu4sKzqUNcyppRYr2p0g1HQZaS4dU1B2sD2Lt0sXhaWbTwW6zX69t7w6V2V
	gSJQcIszkaKDPecuRxPEA/ILi3wmVEnsf2IaQyZP60QZC/gGkncZd/1X3Cb4HoKj
	q4kBUPSL1D5WR6eCOuf+mlX/YuRq2HQfmI8x3GKh8uSXD6y1t98M28jptxb8eiRp
	TCC+e+sqwGF57HB95hEGAvnKjvsf2TD61T6mtGKfCMY1oBNMFQbDhwFTZtkTs3MX
	lbuZBg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grgum3jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCtwRW006365
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:58 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 05:55:53 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <johan@kernel.org>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <konradybcio@kernel.org>, <linux-pm@vger.kernel.org>,
        <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V5 5/6] pmdomain: arm: Use FLAG_DEV_NAME_FW to ensure unique names
Date: Wed, 30 Oct 2024 18:25:11 +0530
Message-ID: <20241030125512.2884761-6-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030125512.2884761-1-quic_sibis@quicinc.com>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lMVoRFqHth7yu-xw4iG9IrnX4g8SzSpv
X-Proofpoint-GUID: lMVoRFqHth7yu-xw4iG9IrnX4g8SzSpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=849 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410300101

The domain attributes returned by the perf protocol can end up reporting
identical names across domains, resulting in debugfs node creation failure.
Use the GENPD_FLAG_DEV_NAME_FW to ensure the genpd providers end up with an
unique name.

Logs: [X1E reports 'NCC' for all its scmi perf domains]
debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
debugfs: Directory 'NCC' with parent 'pm_genpd' already present!

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/pmdomain/arm/scmi_perf_domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index d7ef46ccd9b8..3693423459c9 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -125,7 +125,8 @@ static int scmi_perf_domain_probe(struct scmi_device *sdev)
 		scmi_pd->ph = ph;
 		scmi_pd->genpd.name = scmi_pd->info->name;
 		scmi_pd->genpd.flags = GENPD_FLAG_ALWAYS_ON |
-				       GENPD_FLAG_OPP_TABLE_FW;
+				       GENPD_FLAG_OPP_TABLE_FW |
+				       GENPD_FLAG_DEV_NAME_FW;
 		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
 		scmi_pd->genpd.attach_dev = scmi_pd_attach_dev;
 		scmi_pd->genpd.detach_dev = scmi_pd_detach_dev;
-- 
2.34.1


