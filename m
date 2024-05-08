Return-Path: <linux-pm+bounces-7613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1778BF436
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 03:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B0CB21914
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB98F5B;
	Wed,  8 May 2024 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gM+fwaD4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60D1A2C2C;
	Wed,  8 May 2024 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132752; cv=none; b=OR1OWbcHQ04hRVz+kL9ubD7hgYkYdvWNSoBJOWxcZnPjTKwBPyPpKYnjCDMtabYQWTuMakFtaLnCAOOXboMJrPVq4KvdBQR/s0HISkvpwrCHne96QV06hVG7o/ze6g4g1JgpFRPsSHElN4NfnyuaVZp0p4NaTlex1M/qPA9j0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132752; c=relaxed/simple;
	bh=4xlj5SmF8Y4YtN11odRrshnX4/XsOJ/kKNfAOIt7Q18=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBBLzhWOhmIGeZGcL0+6Vp4uh3qyGRSM0YZWUPN5Jqe+mDlZFGv9E4WrZMa4EfOZHEXED37gHN2xOB0mlwmfDRccDCQv/gBE+akvBUCVM62IS6S0hVIJXbHOmfmJP+2hK0a4aT7Uz99EvRRB/1JuA4Bn1i1dynm4VG+44HxY8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gM+fwaD4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4480ifnH026818;
	Wed, 8 May 2024 01:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=gG/Mg01aPwawcgX1ZVQCj
	4coaePzrbjJoyz1wJasTvE=; b=gM+fwaD4tM0RjtfcYP1LWQ1VSIkhBTZNNANjy
	Sptr9LGGs/PtP8gR2bUulFwbKfVWwD3YOYgBJdBY8+oyIDFUUgN43qdi0M2MHSHv
	pByZCJJ/wnFTKK3Vb9eYePJjfw3luxta1AhHMALayDeigr0wRktauvnCpKKX/DVV
	9fDDmhZZxQvbZbEk4MCLkUwIuxG4Tc0q8ZeC9mxWM82/yLpWcwXq/KL0QugtcL7U
	6Ucs81QnVhWzBgI7HdbCsdvHrjd1B0xiL2PdQ+ePlU6bTJFliV5SSzgTianFLfVD
	EE+eXS6A01iICRXHu0BInZm/KnWenljpuwr7bKOYosSJJeIXA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysg9gqfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 01:45:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4481jVtg012762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 01:45:31 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 May 2024 18:45:31 -0700
Date: Tue, 7 May 2024 18:45:30 -0700
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
Subject: Re: [PATCH 4/4] interconnect: qcom: icc-rpm: Remodel how QoS
 settings are stored
Message-ID: <20240508014530.GB25316@hu-mdtipton-lv.qualcomm.com>
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
 <20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OLkM26eJWXmNATBEUBk8KNyTob3b5lWa
X-Proofpoint-ORIG-GUID: OLkM26eJWXmNATBEUBk8KNyTob3b5lWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080011

Hi Konrad,

On Tue, Mar 26, 2024 at 08:42:35PM +0100, Konrad Dybcio wrote:
> Currently, the QoS settings are stored in the node data, even though
> they're a property of the bus/provider instead. Moreover, they are only
> needed during the probe step, so they can be easily moved into struct
> qcom_icc_desc.

The QoS settings *are* fundamentally a property of the node. The nodes
are 1:1 with the NOC ports. And the QoS settings tune the priority of
the data coming out of those ports. So, logically speaking, the QoS data
does belong in the node structs along with the rest of the data for that
node and port.

Only a subset of NOC ports support configurable QoS, but for those ports
that do it's a property of the port itself. Those settings impact just
that specific port and nothing else.

The current method of directly embedding the qcom_icc_qos_data struct
into qcom_icc_node isn't optimal, since that data is irrelevant for
ports that don't support it. So, the size could be optimized by
converting qcom_icc_node::qos into a pointer instead. But I don't think
we should separate the QoS settings from node struct entirely. It makes
it very difficult to understand which QoS settings are impacting which
port.

For example...

>  
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index 788131400cd1..96c8ea8edd7a 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -43,11 +43,7 @@ static struct qcom_icc_node mas_pcie_0 = {
>  	.buswidth = 8,
>  	.mas_rpm_id = 65,
>  	.slv_rpm_id = -1,
> -	.qos.ap_owned = true,
> -	.qos.qos_mode = NOC_QOS_MODE_FIXED,
> -	.qos.areq_prio = 1,
> -	.qos.prio_level = 1,
> -	.qos.qos_port = 0,
> +	.ap_owned = true,
>  	.num_links = ARRAY_SIZE(mas_a0noc_common_links),
>  	.links = mas_a0noc_common_links
>  };

[...]

>  
> +static const struct qcom_icc_qos_data a0noc_qos_data[] = {
> +	{
> +		.qos_port = 0,
> +		.qos_mode = NOC_QOS_MODE_FIXED,
> +		.areq_prio = 1,
> +		.prio_level = 1,
> +		.urg_fwd_en = false,
> +		.limit_commands = false,
> +	}, {

How can I tell that these a0noc_qos_data[0] settings are for the
mas_pcie_0 port? It's not possible from the code anymore. *We* could
figure it out internally by looking at the NOC SWI to determine the
qos_port index. But this should be obvious from the code itself.

> +		.qos_port = 1,
> +		.qos_mode = NOC_QOS_MODE_FIXED,
> +		.areq_prio = 1,
> +		.prio_level = 1,
> +		.urg_fwd_en = false,
> +		.limit_commands = false,
> +	}, {
> +		.qos_port = 2,
> +		.qos_mode = NOC_QOS_MODE_FIXED,
> +		.areq_prio = 1,
> +		.prio_level = 1,
> +		.urg_fwd_en = false,
> +		.limit_commands = false,
> +	},
> +};
> +

