Return-Path: <linux-pm+bounces-7614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF78BF445
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 03:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689581F23AD5
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 01:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5008F5D;
	Wed,  8 May 2024 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GXKOWuht"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414668F5B;
	Wed,  8 May 2024 01:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133458; cv=none; b=Wr5ap4RJNVNNAWQkG7d7kbActjcTLb3Rr8QkcSOJDOhvyVEwUKpwb7d5J/AVDUAQvsPUvNfM+950wSBfCRYmAxcdkawOG6ivXDCGgwUPRTn/WyomgcBeqsIq2FC64Qi/6K52ax+MM948gUwNBBvslp0OYwm9RYnsuKqdWqBqUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133458; c=relaxed/simple;
	bh=HcDPoxwMQd5aL1/Y+9hVU+0sr3rIr4L2JMYSTKUkfu4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwHb4bEiCntWZgaVnG2zeHjGUnH8yd9S+QITCfUIardnNwV8n6LAHl9iOi7GxgwxmqaOTfQQCPvV/K6mP0PCG+hdKUUFXuuyfS3dTb1Ki1WaFo1FNMufVy17+u59DM0XOHFh5GCzCJ3aIWPpoED3XwVbdDLL/wg8g6KcNplPVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GXKOWuht; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4481VYiR006544;
	Wed, 8 May 2024 01:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=SmUaCm+lO5/m6trar7GNY
	UV5v+xucRFrgeFiKiolHnc=; b=GXKOWuhtnjKabGKiNVt17Y4Rf9JLMss1cY4Fx
	YndQkmqedHFpBGhVJdSoMw4yGWy2fD7edFs2w3uw0iFgj1spNOfTET8iFySCwjeI
	3SfXDzoLHIkwQe250Bxrd+lGHXOgT0euNTZtlJyRv9XQhkoJHgEzdmzZUy4M6CAA
	Ewxxn2bXNs1dj5YFJg10sk7i97AS5LWH8MFeX2SsuPpOAb6eblCYSqY/hgcaopVI
	oCugZ1lfMGzf4B14nf9NDZxrAkLJeiayrv7xU1vfguxXcWi76J0ZMnLuno46aKeF
	wNhen6zWYwugdU0DE+SLX7oICaUAXWVXlmhB0vpFct8veSAEA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyspr0pj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 01:57:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4481vQhd028314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 01:57:26 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 May 2024 18:57:26 -0700
Date: Tue, 7 May 2024 18:57:24 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Stephan Gerhold
	<stephan@gerhold.net>,
        <quic_okukatla@quicinc.com>
Subject: Re: [PATCH 3/4] interconnect: qcom: icc-rpm: Make simple functions
 return void
Message-ID: <20240508015724.GC25316@hu-mdtipton-lv.qualcomm.com>
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
 <20240326-topic-rpm_icc_qos_cleanup-v1-3-357e736792be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-3-357e736792be@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b2lNbMb76KSIVE28Q5SkNa_-WNSCSK2d
X-Proofpoint-GUID: b2lNbMb76KSIVE28Q5SkNa_-WNSCSK2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 mlxlogscore=928 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080012

On Tue, Mar 26, 2024 at 08:42:34PM +0100, Konrad Dybcio wrote:
> Register accesses can't just randomly fail. Change the return type of
> functions that only do that to void.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 110 +++++++++++++++---------------------
>  1 file changed, 47 insertions(+), 63 deletions(-)
> 

[...]

> @@ -115,48 +111,42 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src)
>  	 * only if we are NOT in Bypass Mode.
>  	 */
>  	if (mode != NOC_QOS_MODE_BYPASS) {
> -		for (i = 3; i >= 0; i--) {
> -			rc = qcom_icc_bimc_set_qos_health(qp,
> -							  &qn->qos, i);
> -			if (rc)
> -				return rc;
> -		}
> +		qcom_icc_bimc_set_qos_health(qp, &qn->qos, 3);
> +		qcom_icc_bimc_set_qos_health(qp, &qn->qos, 2);
> +		qcom_icc_bimc_set_qos_health(qp, &qn->qos, 1);
> +		qcom_icc_bimc_set_qos_health(qp, &qn->qos, 0);

Not sure I see the point of unrolling this loop. With the error checking
removed, the loop could be reduced to just two lines, which is shorter
than the unrolled version and isn't really any more complicated:

	for (i = 3; i >= 0; i--)
		qcom_icc_bimc_set_qos_health(qp, &qn->qos, i);

Unrolling the loop is also slightly out-of-scope for this patch that
claims to just change the return types.

Otherwise, patch looks good to me.

