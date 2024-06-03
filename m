Return-Path: <linux-pm+bounces-8538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A48D88DE
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 20:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D64B23C12
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3863D137C31;
	Mon,  3 Jun 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MtO6To6f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690DF9E9;
	Mon,  3 Jun 2024 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440523; cv=none; b=aDHpVOIEPYXoFQ3rA9hL13+d1WXWgvQWRHaez7cxofq3DmaGACd7gt/3Y8oHUhSicPqY2ddfLDofiA/Iuo3SDwPv3Rr0U4RpbbN4wb1k1rJr8+3D//G/8EuKzayCE//BKBG/NJmrrluKM2PXiwSKHz/FEzncG72z6V+wrLBZK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440523; c=relaxed/simple;
	bh=K3G21/24zzUUViCEIjLWZ1Tg2KRYA6Z2/ct1+J+l1fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bK1JqL0RW8ussHMfz+ESJPEUIoWfxfJTBtIctWIWPmk2hb744AoG7iqlin6TQHqtcdllSGJzq3VqlZqaWiXGWXBwLRS/33sIKxcXBzT6sECyahwBYvc5AWiT0Wgqlhas01HYiI6qGq0Aq42flO3cd32ejE5QybNaZTOZTbNYOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MtO6To6f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4538vsuB011909;
	Mon, 3 Jun 2024 18:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	efodBSu3WxBGbSpwkD4Q7QpyR//IjG3Ok/8+uKaU8ww=; b=MtO6To6fZUGKErfC
	CHSOBNLAgpY0uWUiuN5DLkrMZPjhRQ8pz9zkG2Mf1nAPlRF74wyuIP3Xa82FbIKf
	f47WOqBzCP90ddsXWRqEFOyKvDldTI4nxozmjXsOSLSayhTdH/OEIae9jCj9HIsO
	GdwMYPoVYsMmfxje7L+xdJitZeuFncna0fuZLbSiJxrIAXPc/IxCE+NnXMm9jwjk
	GcAaGwgtvUbVyNxEFwehuSHNl/O6utzCBngb0FCsDUskEZteeGNjHF8KSWF8Q3pN
	L8MH8+NLE3yYXNmDBCuShZ7HUM0q/3hjdl/oodQyW6sDV1h9PaquskWAry9Uv2fM
	f+CLZA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4bcqrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 18:48:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453ImNlo021742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 18:48:23 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 11:48:18 -0700
Message-ID: <89a56998-51f2-0dc3-54e8-2bc2217d265d@quicinc.com>
Date: Tue, 4 Jun 2024 00:18:14 +0530
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
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>
References: <20240328074131.2839871-1-quic_sibis@quicinc.com>
 <20240328074131.2839871-3-quic_sibis@quicinc.com>
 <CAKfTPtDtnCm2NqhiXZLODXH5A9Hc9ryP==3LFZUcNnKE4J+PEg@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAKfTPtDtnCm2NqhiXZLODXH5A9Hc9ryP==3LFZUcNnKE4J+PEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qDl1N6TAfhcADbzTCjj104iEoB-_YvRp
X-Proofpoint-GUID: qDl1N6TAfhcADbzTCjj104iEoB-_YvRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406030154



On 5/28/24 14:38, Vincent Guittot wrote:
> Hi Sibi,
> 

Hey Vincent,
Thanks for taking time to review the series :)

> On Thu, 28 Mar 2024 at 08:42, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> Register for limit change notifications if supported and use the throttled
>> frequency from the notification to apply HW pressure.
>>
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
>> +       struct scmi_device *sdev;
>> +       const struct scmi_handle *handle;
>> +};
>> +
>>   struct scmi_data {
>>          int domain_id;
>>          int nr_opp;
>>          struct device *cpu_dev;
>> +       struct cpufreq_policy *policy;
>>          cpumask_var_t opp_shared_cpus;
>> +       struct notifier_block limit_notify_nb;
>>   };
>>
>>   static struct scmi_protocol_handle *ph;
>> @@ -174,6 +181,22 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>>          NULL,
>>   };
>>
>> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
>> +{
>> +       struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
>> +       struct scmi_perf_limits_report *limit_notify = data;
>> +       struct cpufreq_policy *policy = priv->policy;
>> +       unsigned int limit_freq_khz;
>> +
>> +       limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
>> +
>> +       policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
>> +
>> +       cpufreq_update_pressure(policy);
> 
> I noticed your patch while looking for other things in the archive but
> I don't think this is the right way to do it.
> 
> cpufreq_update_pressure() aims to set to the scheduler the aggregation
> of all cappings set to cpufreq through the pm_qos and
> freq_qos_add_request(). Calling this function directly in scmi
> notification callback will overwrite the pm_qos aggregation. And at
> the opposite, any update of a pm_qos constraint will overwrite scmi
> notification. Instead you should better set a pm_qos constraint like
> others

Sure, I'll drop update_pressue and use the freq_qos_update_request to
update the policy->max_freq_req with the new policy->max.

-Sibi

> 
>> +
>> +       return NOTIFY_OK;
>> +}
>> +
>>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>          int ret, nr_opp, domain;
>> @@ -181,6 +204,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>          struct device *cpu_dev;
>>          struct scmi_data *priv;
>>          struct cpufreq_frequency_table *freq_table;
>> +       struct scmi_cpufreq_driver_data *data = cpufreq_get_driver_data();
>>
>>          cpu_dev = get_cpu_device(policy->cpu);
>>          if (!cpu_dev) {
>> @@ -294,6 +318,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>                  }
>>          }
>>
>> +       priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
>> +       ret = data->handle->notify_ops->devm_event_notifier_register(data->sdev, SCMI_PROTOCOL_PERF,
>> +                                                       SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
>> +                                                       &domain,
>> +                                                       &priv->limit_notify_nb);
>> +       if (ret)
>> +               dev_warn(cpu_dev,
>> +                        "failed to register for limits change notifier for domain %d\n", domain);
>> +
>> +       priv->policy = policy;
>> +
>>          return 0;
>>
>>   out_free_opp:
>> @@ -366,12 +401,21 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>>          int ret;
>>          struct device *dev = &sdev->dev;
>>          const struct scmi_handle *handle;
>> +       struct scmi_cpufreq_driver_data *data;
>>
>>          handle = sdev->handle;
>>
>>          if (!handle)
>>                  return -ENODEV;
>>
>> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +
>> +       data->sdev = sdev;
>> +       data->handle = handle;
>> +       scmi_cpufreq_driver.driver_data = data;
>> +
>>          perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
>>          if (IS_ERR(perf_ops))
>>                  return PTR_ERR(perf_ops);
>> --
>> 2.34.1
>>
>>

