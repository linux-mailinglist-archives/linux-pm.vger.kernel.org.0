Return-Path: <linux-pm+bounces-16828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A879B7B96
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 14:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3AA1C20A85
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C319DFA7;
	Thu, 31 Oct 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b3eR2NzH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EED19D8A4;
	Thu, 31 Oct 2024 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380933; cv=none; b=r6eodj+ktwVu0wvTIZr1fYRiKP1sMumW7in4kMElwH6Z6A4Z1oeUJERfaOvB0LRCKyf0EHqoOMJ5+LyjLA+ym9gTEo6jVKqHtptn1CTpjWkOdFUUYU87r4cCQqHaa/gmJg0HXSx6/QT7cEpi5C2H4D0P91frz4FGPrNRMKow7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380933; c=relaxed/simple;
	bh=bEX7yh2cwypWn9C3C3NRc8g7pmrhNLGlVF6xD6Y9DcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l2xoiV/gSed4M2uFgs7+PbHe4P/62JSqoXnFXjB0Thq+h0UkHkMzScwxb5XtrRVtKjWY4/kroBCk7LFjazMgeMkPNmF20OZZGopCsTOz/mcLjmHEqx5id6SgJWaky2sDvhpZTKiUvkOwgmc1bWMnPt7251J+h5HE7g3nq923m8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b3eR2NzH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VBdjJF021342;
	Thu, 31 Oct 2024 13:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cZt4248Xr+mK1uGXInWk0qtIq4noEBsMMZcX4IL0cV8=; b=b3eR2NzHbbrmBZdl
	SReYd3nsIkQipF7SqdxH0ratiqM4/wQPrdlj1aBGz9Ha4Ri08BYJQXK9fItBd37T
	knmE5IP7on+yIzAz4GvPP8ZcA8KhkO1xB5yugTLNX1nrKDv9pyfDz3AMIJ70R5kE
	1621XXnks4/9dW5FXvfdQV/jVIUsAtKLu8ys1AV0lX+LDLc3+tQjUugrNpv6jvtM
	pDAONJiIA+TvHty7SiSq26Sw866FA9rmaazWTQLz0/JLpOpmM3z7EWqLbzdnNmcd
	zdo8mcgzMof3L6neIwdIz+FJCytyX5IWJR3HdWzdbJ2WRQpAEN2fL97CPRmNLk3X
	9cnosw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42m1rphqgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:21:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VDLqFj004290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 13:21:52 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 31 Oct
 2024 06:21:47 -0700
Message-ID: <e759ecad-9533-a294-9ee0-1b42effe5b82@quicinc.com>
Date: Thu, 31 Oct 2024 18:51:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V6 1/1] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>
References: <20241030133133.2932722-1-quic_sibis@quicinc.com>
 <20241030133133.2932722-2-quic_sibis@quicinc.com>
 <CAKfTPtDY965+8wbF-fgFyD4Br-2obQQjJTONwJoPpyYBrdN_VA@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAKfTPtDY965+8wbF-fgFyD4Br-2obQQjJTONwJoPpyYBrdN_VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LwaUcYsn0WYh8vch3bW6wAVW8n5eR-0S
X-Proofpoint-ORIG-GUID: LwaUcYsn0WYh8vch3bW6wAVW8n5eR-0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310102



On 10/30/24 20:17, Vincent Guittot wrote:
> On Wed, 30 Oct 2024 at 14:32, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> Register for limit change notifications if supported and use the throttled
>> frequency from the notification to apply HW pressure.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Tested-by: Mike Tipton <quic_mdtipton@quicinc.com>
>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>
>> v6:
>> * Unregister the notifier in the exit path to make sure
>>    the cpus work across suspend/resume cycles.
>>
>>   drivers/cpufreq/scmi-cpufreq.c | 38 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 5892c73e129d..fb3534eae722 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/export.h>
>>   #include <linux/module.h>
>>   #include <linux/pm_opp.h>
>> +#include <linux/pm_qos.h>
>>   #include <linux/slab.h>
>>   #include <linux/scmi_protocol.h>
>>   #include <linux/types.h>
>> @@ -25,7 +26,9 @@ struct scmi_data {
>>          int domain_id;
>>          int nr_opp;
>>          struct device *cpu_dev;
>> +       struct cpufreq_policy *policy;
>>          cpumask_var_t opp_shared_cpus;
>> +       struct notifier_block limit_notify_nb;
>>   };
>>
>>   static struct scmi_protocol_handle *ph;
>> @@ -174,6 +177,25 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>>          NULL,
>>   };
>>
>> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
>> +{
>> +       struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
>> +       struct scmi_perf_limits_report *limit_notify = data;
>> +       struct cpufreq_policy *policy = priv->policy;
>> +       unsigned int limit_freq_khz;
>> +       int ret;
>> +
>> +       limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
>> +
>> +       policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
>> +
>> +       ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> 
> If I don't get it wrong, you are using policy->max_freq_req which is
> also used by the sysfs scaling_max_freq
> 
> This means that your request will be overwritten by the next write
> into scaling_max_freq and/or you will overwrite a constraint set by
> userspace.
> 
> You have to create your own freq_qos_request and add it to the list of
> cpufreq qos request

Thanks for catching this. Will get it fixed in the next re-spin.

-Sibi

> 
> 
> 
>> +       if (ret < 0)
>> +               pr_warn("failed to update freq constraint: %d\n", ret);
>> +
>> +       return NOTIFY_OK;
>> +}
>> +
>>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>          int ret, nr_opp, domain;
>> @@ -181,6 +203,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>          struct device *cpu_dev;
>>          struct scmi_data *priv;
>>          struct cpufreq_frequency_table *freq_table;
>> +       struct scmi_device *sdev = cpufreq_get_driver_data();
>>
>>          cpu_dev = get_cpu_device(policy->cpu);
>>          if (!cpu_dev) {
>> @@ -294,6 +317,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>                  }
>>          }
>>
>> +       priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
>> +       ret = sdev->handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_PERF,
>> +                                                       SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
>> +                                                       &domain,
>> +                                                       &priv->limit_notify_nb);
>> +       if (ret)
>> +               dev_warn(&sdev->dev,
>> +                        "failed to register for limits change notifier for domain %d\n", domain);
>> +
>> +       priv->policy = policy;
>> +
>>          return 0;
>>
>>   out_free_opp:
>> @@ -310,8 +344,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>
>>   static void scmi_cpufreq_exit(struct cpufreq_policy *policy)
>>   {
>> +       struct scmi_device *sdev = cpufreq_get_driver_data();
>>          struct scmi_data *priv = policy->driver_data;
>>
>> +       sdev->handle->notify_ops->devm_event_notifier_unregister(sdev, &priv->limit_notify_nb);
>>          dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>>          dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
>>          free_cpumask_var(priv->opp_shared_cpus);
>> @@ -370,6 +406,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>>          if (!handle)
>>                  return -ENODEV;
>>
>> +       scmi_cpufreq_driver.driver_data = sdev;
>> +
>>          perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
>>          if (IS_ERR(perf_ops))
>>                  return PTR_ERR(perf_ops);
>> --
>> 2.34.1
>>

