Return-Path: <linux-pm+bounces-16729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EBC9B6382
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBF61F22342
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884891EF94D;
	Wed, 30 Oct 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XWFahIOE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5A1EF088;
	Wed, 30 Oct 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292961; cv=none; b=FwVqsQ4wPCEqfSriRyQRQd+pBCrLw3v+4IQDBqkiHvqP54V8E6d8VDAHzImxlAzKzLFYcZm+LDFI/C6HW3+pNi3yX3tNpbhuDuGNlsEZMhcCfEkXXynCwlYaalEPwQCmVdSpLmuHX01Dasq50qggJWLm13l3Q5JkDAWaJ2geNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292961; c=relaxed/simple;
	bh=N7BVauoGxgJjg7iYXTAvkgAKCu5ZXqQfjOqtqd+9rI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGzFEcjNIv2Ti2rM3MKzLE3ry3MzBrZfjGWO95nC8S2J42V1ZbAQm77QpALS52jTlHHF5/w0BEeSDhUCpRR/Q5t18cYKZ3by2mMOCCL+HmPUoSbZLJLzffn6bBumgbW/cQLWfSTEOVoPA8b30Dtpi0fDQ7lKIofTtF7WRGM5nBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XWFahIOE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UALnDJ019075;
	Wed, 30 Oct 2024 12:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WfHH1RHqUXE17Tc0K73Iyht1P2KaZRSGyXPS2z2U9BI=; b=XWFahIOEnKI7gH28
	88bkvqDhKfh9FVwu84ymxT/RNNAGv8HiiEFR3gc+S+ct/phCsiM8OFY+SnQww9Rx
	cPZcgaJwpVrNpaAJHQTJClwKNN2A1gtt5ZVWqDo5PxcToowYhB/fwE3P55XfRv+J
	wLkl7GEJs9R2R39W0Wp2RDiq2jNBndbA2Ev3zIE2LuIMmCmeyHhPu7NXRnP/jZkF
	y0h7+n0Glh/0TXNyChvBrBTfI4y8s9zRxvhAtC+E6tBAyOhu/wlDBc01tN6COiq8
	MA/12RkCdfd/dauVVrF85U0BtLkkhbRXrBZwRmmEOueWDLcVQfHqr8W7YXZqQtv4
	s9tgug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gp4e4868-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCtlbu012132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:55:47 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 05:55:42 -0700
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
Subject: [PATCH V5 3/6] firmware: arm_scmi: Report duplicate opps as firmware bugs
Date: Wed, 30 Oct 2024 18:25:09 +0530
Message-ID: <20241030125512.2884761-4-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: h4l24jaRJINMx_Wx4KtLorsJvGl9SFlE
X-Proofpoint-GUID: h4l24jaRJINMx_Wx4KtLorsJvGl9SFlE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300101

Duplicate opps reported by buggy SCP firmware currently show up
as warnings even though the only functional impact is that the
level/index remain inaccessible. Make it less scary for the end
user by using dev_info instead, along with FW_BUG tag.

Suggested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/arm_scmi/perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 32f9a9acd3e9..c7e5a34b254b 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -387,7 +387,7 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
 	if (ret) {
-		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
+		dev_info(dev, FW_BUG "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
 			 opp->perf, dom->info.name, ret);
 		return ret;
 	}
@@ -409,7 +409,7 @@ process_response_opp_v4(struct device *dev, struct perf_dom_info *dom,
 
 	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
 	if (ret) {
-		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
+		dev_info(dev, FW_BUG "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
 			 opp->perf, dom->info.name, ret);
 		return ret;
 	}
-- 
2.34.1


