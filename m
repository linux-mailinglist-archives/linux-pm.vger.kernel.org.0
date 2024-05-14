Return-Path: <linux-pm+bounces-7799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524EE8C4EF1
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D438B20A4F
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664F12FF86;
	Tue, 14 May 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nUybUr9i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ABC41C92;
	Tue, 14 May 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679650; cv=none; b=Lv4J2ojccTtVx2ia+DxcyHCPfnt5mJjmFgvlNUoDWn8bFN3yaSyt4wcdLMxdMSQlsS2eTO0qnAo9Y3HwY+GPrnJTWJCfHniISuouT6fZMwq3WN2xo4APqaAqcagCW1P99x9yX3HD8ZWcPfKxaQtUZMOlUAVInu0lvu7p6z4dP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679650; c=relaxed/simple;
	bh=fUsD6LUTdjE3pAPXHLqyl5dRHGqYcANQ1LUVv9dUdZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EXKrTFBYwD2P4DiotIOY5a11tZvs0Ugplwh/GKizdle0Qq2uYYttHVhVvQpHD1gruV1JDNZs1pNE4VAHGdnYs14zfFWKtueqEg9dOg7GIBAxrG5/ydsnOiIe9nNDQkf38cUqJt27JsKEsSzPuwZMPzZQo3YR9tlERBjDnuCFvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nUybUr9i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44E7tsc4027298;
	Tue, 14 May 2024 09:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mi2RdJrkmKsN8ltJ5aUEwLAREuBftGQxjpo5hXDRxgg=; b=nU
	ybUr9iEsxZRQjD1S24T59fGP4OSgAcKLjwUywOCertkq9k7S2Vzjav+5/AgN1DWD
	hsufoytciMEqmICSQKMR1cV+ehP1L+b3WACSYxc2VkLMIZQC6xeI5fML6PEvioW8
	wTub8zgwarkgFS+BNkkZqvLIq4zRbWYxj7BJct0yFN9PR0AHY1JIdr9x+CpcNfES
	9gg3I9w408tgQ5+kSTG5v5KYNwizQ2EoEzc5Q4c42BV5QzxLapi7ftDdwxivaw6s
	YddBaXql/yzxj153u2fkE8+YOk7TIQ/miRHfKi6m1yFTam3Pzaw+9rlg2Y1Zd6gv
	jn78Je17KqUsBtohO3dw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1y9mdy6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 09:40:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44E9eZfl030697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 09:40:35 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 02:40:31 -0700
Message-ID: <d7fbc261-39a1-57a3-6891-ae2de63368d0@quicinc.com>
Date: Tue, 14 May 2024 15:10:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 2/2] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <sudeep.holla@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <morten.rasmussen@arm.com>, <dietmar.eggemann@arm.com>,
        <lukasz.luba@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20240328074131.2839871-1-quic_sibis@quicinc.com>
 <20240328074131.2839871-3-quic_sibis@quicinc.com> <ZjH7hWnKFcpQ-TXH@pluto>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZjH7hWnKFcpQ-TXH@pluto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7BftsmZAxynvjVdMmba2KZ8pb45XmQ0V
X-Proofpoint-ORIG-GUID: 7BftsmZAxynvjVdMmba2KZ8pb45XmQ0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_04,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140068



On 5/1/24 13:51, Cristian Marussi wrote:
> On Thu, Mar 28, 2024 at 01:11:31PM +0530, Sibi Sankar wrote:
>> Register for limit change notifications if supported and use the throttled
>> frequency from the notification to apply HW pressure.
>>
> 
> Hi Sibi,
> 
> a bit late on this, sorry.
> 
> Just a couple of nitpicks down below.
> 
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v4:
>> * Use a interim variable to show the khz calc. [Lukasz]
>> * Use driver_data to pass on the handle and scmi_dev instead of using
>>    global variables. Dropped Lukasz's Rb due to adding these minor
>>    changes.
>>
>>   drivers/cpufreq/scmi-cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 3b4f6bfb2f4c..d946b7a08258 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -21,11 +21,18 @@
>>   #include <linux/types.h>
>>   #include <linux/units.h>
>>   
>> +struct scmi_cpufreq_driver_data {
>> +	struct scmi_device *sdev;
>> +	const struct scmi_handle *handle;
>> +};
>> +
>>   struct scmi_data {
>>   	int domain_id;
>>   	int nr_opp;
>>   	struct device *cpu_dev;
>> +	struct cpufreq_policy *policy;
>>   	cpumask_var_t opp_shared_cpus;
>> +	struct notifier_block limit_notify_nb;
>>   };
>>   
>>   static struct scmi_protocol_handle *ph;
>> @@ -174,6 +181,22 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>>   	NULL,
>>   };
>>   
>> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
>> +{
>> +	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
>> +	struct scmi_perf_limits_report *limit_notify = data;
>> +	struct cpufreq_policy *policy = priv->policy;
>> +	unsigned int limit_freq_khz;
>> +
>> +	limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
>> +
>> +	policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
>> +
>> +	cpufreq_update_pressure(policy);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>   	int ret, nr_opp, domain;
>> @@ -181,6 +204,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   	struct device *cpu_dev;
>>   	struct scmi_data *priv;
>>   	struct cpufreq_frequency_table *freq_table;
>> +	struct scmi_cpufreq_driver_data *data = cpufreq_get_driver_data();
>>   
>>   	cpu_dev = get_cpu_device(policy->cpu);
>>   	if (!cpu_dev) {
>> @@ -294,6 +318,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   		}
>>   	}
>>   
>> +	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
>> +	ret = data->handle->notify_ops->devm_event_notifier_register(data->sdev, SCMI_PROTOCOL_PERF,
>> +							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
>> +							&domain,
>> +							&priv->limit_notify_nb);
>> +	if (ret)
>> +		dev_warn(cpu_dev,
> 
> or &data->sdev->dev which refers to this driver ? which is more informational ? no strong opinion just a question...

Pointing to the driver is better given that we already pass on domain
info.

> 
>> +			 "failed to register for limits change notifier for domain %d\n", domain);
>> +
>> +	priv->policy = policy;
>> +
>>   	return 0;
>>   
>>   out_free_opp:
>> @@ -366,12 +401,21 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>>   	int ret;
>>   	struct device *dev = &sdev->dev;
>>   	const struct scmi_handle *handle;
>> +	struct scmi_cpufreq_driver_data *data;
>>   
>>   	handle = sdev->handle;
> 
> 	^^^ ....
>>   
>>   	if (!handle)
>>   		return -ENODEV;
>>   
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->sdev = sdev;
>> +	data->handle = handle;
> 
> 	^^^ ... you dont need to pass around handle AND sdev really
>                  since you can access the handle from sdev.
> 
>> +	scmi_cpufreq_driver.driver_data = data;

Ack setting sdev as driver data would suffice. Will fix it in the next
re-spin.

-Sibi

> 
> This is slightly better, but, as said, does not solve the multi-instance issue...
> ...the scmi cpufreq driver remains a driver that works only if instantiated (probed)
> once, given how the CPUFreq core handles cpufreq_driver registration itself...
> 
> ...just a note about something to work on in the future...NOT a concern for this series.
> 
> In general,
> 
> LGTM.
> 
> Thanks,
> Cristian
> 

