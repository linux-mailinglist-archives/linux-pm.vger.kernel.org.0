Return-Path: <linux-pm+bounces-10536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C39925EA8
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C320DB3A513
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505FD184132;
	Wed,  3 Jul 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LfoeD012"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8C17966F;
	Wed,  3 Jul 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004891; cv=none; b=YKJMv5+m7mibKgHiqfxmbcWp9Yr4rvm3+sxp/ihNp4sKRu3V2RcIW5w3UtPBpLuoyN6jMmaxiceBo0FnYDuOkzUdNUmR2rEHlYXO2pJFvaT7UV8q5PJ6Pq7ajc+jNrkojDqeo73+52Rft/At8JxB82rSVIkl6FGXsTji6jwTrcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004891; c=relaxed/simple;
	bh=aAHcNpB1IgwcUueaEiNMzohiIzC+NF8WBCUgS5jLNsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZAgqwPWAsUE7RSNhq3VfBV+lcglvlutTXb3r4o23HjzBtlOxmxrKC5r6/29yyJFLhPu6fc1TQpGUKRH1JvqB3OFdgsxVK0rOLjLwqUt+ioYuia54QPzjUu9T+5PSXU5pCPqDZFJu1BjS/t+Kn4isYPVKMUkCXeKm4zRX1xVx7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LfoeD012; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4632V650028807;
	Wed, 3 Jul 2024 11:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OWQnYlzEmKvztF5hGmcsCG
	k86Zr1SRLYRcSYeQnokE0=; b=LfoeD0120dDRx0lxahbziBRdMh1rByTWw5vmHM
	OKBQLO+Y2p+bv4aDKXD0dmCEqIqWKJMGxi/uVRmfiqLW58MTp8j2svlGoemfKYOq
	rGTNFab+bRJp6PfayhAhb0sSqG2RIKxVCOBptxVrE5hV9zxSM00oNLyqV+Rua0T9
	bIz2jAu0b+9gSWBbwH42k9FpCSt+6Ye+tc0iK6NTtjCPQ6PWiUp5KEFyWDHebTra
	QWhHjCAMNAuFwJzeg0ITai7SfN/VO/Acv9UZMK3zJB4xcnBSv4arIXYeJ/waE/Ax
	j+vQzvb/pvJ2lVwqdlMkYiY1yKXlU1Vf9Podv7DE4qMlHR3A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404kctjus0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 11:08:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 463B7xWu002896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 11:07:59 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 04:07:55 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <ulf.hansson@linaro.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <johan@kernel.org>
Subject: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Date: Wed, 3 Jul 2024 16:37:41 +0530
Message-ID: <20240703110741.2668800-1-quic_sibis@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cv0fOm5Kl8mxrnMeudx36UyMankDpKtK
X-Proofpoint-ORIG-GUID: Cv0fOm5Kl8mxrnMeudx36UyMankDpKtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=673 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030082

The domain attributes returned by the perf protocol can end up
reporting identical names across domains, resulting in debugfs
node creation failure. Fix this duplication by appending the
domain-id to the domain name.

Logs:
debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
debugfs: Directory 'NCC' with parent 'pm_genpd' already present!

Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/pmdomain/arm/scmi_perf_domain.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index d7ef46ccd9b8..0af5dc941349 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -18,6 +18,7 @@ struct scmi_perf_domain {
 	const struct scmi_perf_proto_ops *perf_ops;
 	const struct scmi_protocol_handle *ph;
 	const struct scmi_perf_domain_info *info;
+	char domain_name[SCMI_MAX_STR_SIZE];
 	u32 domain_id;
 };
 
@@ -123,7 +124,12 @@ static int scmi_perf_domain_probe(struct scmi_device *sdev)
 		scmi_pd->domain_id = i;
 		scmi_pd->perf_ops = perf_ops;
 		scmi_pd->ph = ph;
-		scmi_pd->genpd.name = scmi_pd->info->name;
+
+		/* Domain attributes can report identical names across domains */
+		snprintf(scmi_pd->domain_name, sizeof(scmi_pd->domain_name), "%s-%d",
+			 scmi_pd->info->name, scmi_pd->domain_id);
+
+		scmi_pd->genpd.name = scmi_pd->domain_name;
 		scmi_pd->genpd.flags = GENPD_FLAG_ALWAYS_ON |
 				       GENPD_FLAG_OPP_TABLE_FW;
 		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
-- 
2.34.1


