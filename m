Return-Path: <linux-pm+bounces-15243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4862499242B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED10280CF4
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98F1741C9;
	Mon,  7 Oct 2024 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oC7+oUCz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C916131A;
	Mon,  7 Oct 2024 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281272; cv=none; b=lzeNLTUe0ROjps4NuvDEsLWDa+obPiP17l6nQ0D7xKG1AcyXq6IV1X+q0Wp1iIGU0mMbYZokjpLRUnZ3bSy2wsPfC1xzqoQ3wzP69EC6c1ytGkDiyLm36l87/4p9g0qsG9R1Vls3PaSVc2/h09Fpq4JJn3eDO19wPmUl+gkEHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281272; c=relaxed/simple;
	bh=S58hrxJcpmNi+Jq0WvzvgeXizhzyqfE/1ugjuKzqLJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4i5XqYCl9kRLx5MgQ9CTZwUOkUrDxLHEgyse6BEoZ40Vi948yILltvLEMkYWXvu6fgcXT3jUl7z02KmafTG+2jG97Mt119uXMylId+9YPEQpTnA2QLGVYEn60xrG9b6IPtg6anG4xr4uMCQSQKHOO/uOWsqHOofXClN9iR0lQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oC7+oUCz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974Sn3A015093;
	Mon, 7 Oct 2024 06:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mjTyoWMSNmI92qQkX8St8oeAHiTPVO/enkB9xX+DiCk=; b=oC7+oUCzXI25RTXV
	nCYenqanS1R7oBOxlWHYkwxJM5T9lQNQi/opoQQAGDDm6s6QN4XYqzOBi6w2qbP6
	tT56M9r8D+iPwGRQmyH8JA5vuq+EcFgKrIMxnx18v0c8RRQKBN89jLA9ZHNkhB/1
	hoxkQPjg5dm0bTUr5cu4hrbucEM6hA2F6Yuc53pBNPIOBnHfgyX9h0IFJCYYK3p2
	pkjPzSsSX8uKIhhAN79TKx3I9iDcLPSaZinIPoQWryf546h1UED9fByKN6xxBTnr
	rsXhVLknErcTUorl14yw1hECcjG0eNxFqrhE29/HRZ+g0FqTPhXp5KpkzCfJrE5U
	2kEIgQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs735bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 06:07:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49767dra025606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 06:07:39 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 6 Oct 2024 23:07:35 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <johan@kernel.org>, <konradybcio@kernel.org>,
        <linux-pm@vger.kernel.org>, <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>
Subject: [PATCH V3 4/4] mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag
Date: Mon, 7 Oct 2024 11:36:42 +0530
Message-ID: <20241007060642.1978049-5-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007060642.1978049-1-quic_sibis@quicinc.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: cFOQsPJODioytTC0j0JhSxo5sSMs7haL
X-Proofpoint-GUID: cFOQsPJODioytTC0j0JhSxo5sSMs7haL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070041

The qcom-cpucp mailbox irq is expected to function during suspend-resume
cycle particularly when the scmi cpufreq driver can query the current
frequency using the get_level message after the cpus are brought up during
resume. Hence mark the irq with IRQF_NO_SUSPEND flag to fix the do_xfer
failures we see during resume.

Err Logs:
arm-scmi firmware:scmi: timed out in resp(caller:do_xfer+0x164/0x568)
cpufreq: cpufreq_online: ->get() failed

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZtgFj1y5ggipgEOS@hovoldconsulting.com/
Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/mailbox/qcom-cpucp-mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
index e5437c294803..44f4ed15f818 100644
--- a/drivers/mailbox/qcom-cpucp-mbox.c
+++ b/drivers/mailbox/qcom-cpucp-mbox.c
@@ -138,7 +138,7 @@ static int qcom_cpucp_mbox_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = devm_request_irq(dev, irq, qcom_cpucp_mbox_irq_fn,
-			       IRQF_TRIGGER_HIGH, "apss_cpucp_mbox", cpucp);
+			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, "apss_cpucp_mbox", cpucp);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to register irq: %d\n", irq);
 
-- 
2.34.1


