Return-Path: <linux-pm+bounces-16732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E69B638C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC0F1F220C9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C31EABD4;
	Wed, 30 Oct 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RSpCOr9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4021EABC3;
	Wed, 30 Oct 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292978; cv=none; b=XedOUiRV77nJxn0zwZzfIlpNZ/IlgQP0jFkBtX7cMYjoP+sRjtmruswBWp6cIc1hd12iMyqv7lRtSSrRz1yuJVv3cxMxxO6YfhAnw8C/NDYBLGsK++THwxzxkLstttXXADCVLMAZWjNECZofETwvE0Q46tV/mcSsuoWqL53brxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292978; c=relaxed/simple;
	bh=TTbZTgxsgRBeIxBiTInMycZl6KL5fNcvnFtG4GHCUF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNdJCtEzlsth43s+iJjtAkGxcailBN401i1QqUtTJtdp0XCxDHqNAn02kH99wTGLvJ19eV4+wmp+bN4uh6j7PNJQBbMtTq4rthDQiAFMlTTj4kik6yN9llFhv8Sbhn4sAeDzNU9nJiSoM6WLbeCOI/mQuRJYJQUu8M4wb8XURYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RSpCOr9E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U9E2bC024838;
	Wed, 30 Oct 2024 12:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	alo6836guK9Z7mPFvjT64sRa9W903VDVoN5vz/mAGHc=; b=RSpCOr9ElFidAP15
	UHizGXCXqN1M4ZRVjScUm235KWbHLwuTesSzROCD5pR2HlZYmzz+lxigckGmmsM0
	Ja3DFi3ZlgUR6h8gXKtou8+59Sy2Z2lOOcfIcXOliDRiR5cvRzMkIXhqctDE7bTU
	dmhU2jqjirO1pSwoV2JJT4iLeBzpP7t2ZoMDyvX4n9eNJNthXkkLiEU+nmxXHeyG
	3YiO0aopU8NpKfsExgaK46puR1rElIuQEqRGSTY3xct3rV7HQeKa2s7JTpcneZOG
	rFbSg+Xvwa5dkUzB9IeDSvnG19ApAIEPRVkkgE4Opylo63E6vp2VktVG9kzBSoSI
	/GNfog==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grgum3jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:56:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCu4rt013707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:56:04 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 05:55:58 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <johan@kernel.org>,
        <ulf.hansson@linaro.org>, <jassisinghbrar@gmail.com>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <konradybcio@kernel.org>, <linux-pm@vger.kernel.org>,
        <tstrudel@google.com>, <rafael@kernel.org>,
        "Johan Hovold" <johan+linaro@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V5 6/6] mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag
Date: Wed, 30 Oct 2024 18:25:12 +0530
Message-ID: <20241030125512.2884761-7-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: YgF8uCwzqQqGLY_Gmzqa2YJ5_RqWZM8x
X-Proofpoint-GUID: YgF8uCwzqQqGLY_Gmzqa2YJ5_RqWZM8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410300101

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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
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


