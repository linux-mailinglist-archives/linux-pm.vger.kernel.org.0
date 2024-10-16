Return-Path: <linux-pm+bounces-15814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0E9A1639
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 01:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DB01C21E04
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 23:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CF81D4326;
	Wed, 16 Oct 2024 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U8r9mTNo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4804282FA;
	Wed, 16 Oct 2024 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122329; cv=none; b=iedt/Zy8DB7WbTgI4SxdPU7AgfHP6Zodspdt/I3ZfWO8gCPspVv+s5UQlSZiTYHsN7YemKg5rkZahSEhIv0MYuwqonDSY/3i3oIgxApq+F2dw2XnFlH6Evkv86+Iugt9xCUpB+tfelB65qE+N5qwiJqG5kFyLmqYgFsjzuQOAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122329; c=relaxed/simple;
	bh=rOMnaHFbyrqkDa3kCV5cdJC9ZJsY+QGyGyxmU8Hs3fs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJwvB5GzGPvO4TzGIpjLHcnY7R0MWd/5e/6g4uGbXq2j+j3jvGCwUWO7J3NG3ND9DacCE9jaX0oa5Yadd10h6DUqVLN9IJL44XuXnwZcIc1Dmv1Gx4EbFu9ru5EU3toz4X5nGb8nlPx+ox/+6giXo6xTAb4S2rS05qwLKBnS95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U8r9mTNo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GIFv6J001733;
	Wed, 16 Oct 2024 23:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FQhUz+ODVS1Mtj88e10qGXt5
	mYqZRtinSKk8mKi1F+s=; b=U8r9mTNoVCTaX1/2abgmh3pNN4WpCxK0sdUFW/oB
	sNX5wBIjq13ZXDwTELI6uPSaDItbHT1qrm92Vbk4xAIHkkAvLhC/1ICuzADM0N+1
	L9aahHfyr47HXhwXGSvqZHYcjqyjcxlXBJwfBqcOa3ND2ZwYFLxhjkPafmNV7v+z
	r8cd6DfUTsoBGUfEZtcFdX4aOT81rFB7b3QSVCA2IGjgpz1vOPQtQ0QhbajOjNOA
	6vucz+poZa8FYXbKlp2a40bn1YBW837slTBrSgNK8tAI39s4vq4Hj+4A9u1ePsOI
	Eq2MYH++iqK1vIXogQLGwCdmh1P52Ww5bWUmnI6peAUaQg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ajm58nks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 23:45:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GNjGQi031586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 23:45:16 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 16:45:16 -0700
Date: Wed, 16 Oct 2024 16:45:15 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <vincent.guittot@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH V5 1/1] cpufreq: scmi: Register for limit change
 notifications
Message-ID: <20241016234514.GA17864@hu-mdtipton-lv.qualcomm.com>
References: <20240603192654.2167620-1-quic_sibis@quicinc.com>
 <20240603192654.2167620-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240603192654.2167620-2-quic_sibis@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7_7Zy98waBdmcNbs49DXZjcvcob6oB9b
X-Proofpoint-ORIG-GUID: 7_7Zy98waBdmcNbs49DXZjcvcob6oB9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1011 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160152

On Tue, Jun 04, 2024 at 12:56:54AM +0530, Sibi Sankar wrote:
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v5:
> * Drop patch 1 and use pm_qos to update constraints. [Vincent]
> * Use sdev instead of cpu_dev in dev_warn. [Christian]
> * Pass sdev directly through private data. [Christian]
> * Dropping Rb's for now.
> 
>  drivers/cpufreq/scmi-cpufreq.c | 36 ++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Tested-by: Mike Tipton <quic_mdtipton@quicinc.com>

> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index b87fd127aa43..0edfa55d8e49 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/types.h>
> @@ -25,7 +26,9 @@ struct scmi_data {
>  	int domain_id;
>  	int nr_opp;
>  	struct device *cpu_dev;
> +	struct cpufreq_policy *policy;
>  	cpumask_var_t opp_shared_cpus;
> +	struct notifier_block limit_notify_nb;
>  };
>  
>  static struct scmi_protocol_handle *ph;
> @@ -174,6 +177,25 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>  	NULL,
>  };
>  
> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
> +	struct scmi_perf_limits_report *limit_notify = data;
> +	struct cpufreq_policy *policy = priv->policy;
> +	unsigned int limit_freq_khz;
> +	int ret;
> +
> +	limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
> +
> +	policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
> +
> +	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> +	if (ret < 0)
> +		pr_warn("failed to update freq constraint: %d\n", ret);

This would be better as a dev_warn() with the cpu device. Other than
that, looks good to me.

