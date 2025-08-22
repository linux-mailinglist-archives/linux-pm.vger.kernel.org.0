Return-Path: <linux-pm+bounces-32902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA568B3158B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 12:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C4BA043F0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324E2E1F11;
	Fri, 22 Aug 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FqrCBxl3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA92D7DFA;
	Fri, 22 Aug 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858721; cv=none; b=Dfv/Jqw0g+UoQayE9txPxaaJAoFOyV1EsW7eC6y6OgDb6SvKSmIhHi+i2ev/pYDu73E2n4TPvrMTYQL57wTYzP545U/Hlw2+nxB3y9BKZ9+IUxm2DmYIoHJ78ZmhukrmJSa84dHrK+zd9XoNYZmf07kbji4MGDTtsG/Fj/4H4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858721; c=relaxed/simple;
	bh=tjba+1GpAesrrqMS4KoUunQwa1u2tl4QeEPRqEXmx0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F204qMUZS37wVZ8wa5gyazyentgsTCIljPEneRhJkUIKqPANUfs/n4FHrATybtJjIle5cQlHA6kQ4wNjEsmnTk0QLBtnhUrgK7gOrx+ytUepFuVZT6TNfrchfUy/2woMmFmfhZbwZYnx5PfcmOzeQZgwHnqyOZ7ie5XO32ywORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FqrCBxl3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UIuu027215;
	Fri, 22 Aug 2025 10:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oasFw8I/ANKFSsQetpBeb0kT/smlUz8pHNmupegs/eU=; b=FqrCBxl3W964mf+B
	/P0L4i6TdPoHgOASjx/LBi8fJbkUg4tFmxeq4bN1cFEAO3KY0cGb0EeGdSG79syF
	DKZKCPnKFemLhDiTw4gaydGc2iuqDl0dpLP4AqM3RfNe3OMPKf5uGYTApBr9APu9
	sZPS1ufVGhgvb3YtcOcp8f6/0+J43Ycs4Wyx4q2XsUEfaVJlUc1qeMgyRkrLmwoT
	btQEKmAi00U4AW1MnSx+5qF4lC/JIxkC88yS28+SMH+deszxYrp/4BN09dk9E9LF
	LM2sDqpkQ8lQmAxbeV2B5BTbuadVPcxeIbKPTZPSiaxTsjj1ksRImjPeKK3bq4ga
	Gjg+pw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298w03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 10:31:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57MAVoX9011063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 10:31:50 GMT
Received: from [10.133.33.129] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 Aug
 2025 03:31:47 -0700
Message-ID: <0887d67c-b041-4456-be8a-696b444cdedf@quicinc.com>
Date: Fri, 22 Aug 2025 18:31:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] PM: QoS: Add support for CPU affinity latency PM
 QoS
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <pavel@kernel.org>, <tony.luck@intel.com>,
        <reinette.chatre@intel.com>, <Dave.Martin@arm.com>,
        <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>, <christian.loehle@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhongqiu Han <quic_zhonhan@quicinc.com>,
        <zhongqiu.han@oss.qualcomm.com>
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <20250721124104.806120-2-quic_zhonhan@quicinc.com>
 <CAJZ5v0heLbA5Bfa2NqAGeOn_=N2+CMEQ8HWRgp25Ob0bGYDLZQ@mail.gmail.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <CAJZ5v0heLbA5Bfa2NqAGeOn_=N2+CMEQ8HWRgp25Ob0bGYDLZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a84717 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=4OJ7usud0d8f_mqJBCgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: EfgiEkjWAxaOnqLc5lHootIhe1uye4RC
X-Proofpoint-GUID: EfgiEkjWAxaOnqLc5lHootIhe1uye4RC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1MX/rV/sl/oY
 NOg1KM9eq772NvwEeRVGIXJnZ6C8sT4bs/KlOkSVbXmumQOySFpAwUujjN/sG1gZx5EObqnPQjf
 KRw9oMP4fdRZuwLEuzc+os27O93M5CRMTpMmHmf6Q9bNzwloftTvVe61Xyo4slgkyV4P9HFI6aS
 FDxPurYP05cYdevofBCXJuWMu8ioqasoiWxlZTBf0QYlcBbCJDhNvKqwQ5t2mi8e/X+OLAhEOJ1
 ePiFGb/5i8icmR5TvGvK+ow8ETVBiXEj5VgzdeMrgWGtRJWzPBDta/hLWQRSunlwM47dRU1lNJx
 G9Qbmy0/CS7y36r0ay4u5HIKjItNOLmhEcH9h3N7VM83bXfF7e98ufi7GQS2/a+y4OVuqgf7nIv
 3NzsiXQCqbBuMLRCRqYE6aVpeQ0npA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 8/21/2025 6:37 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 21, 2025 at 2:41 PM Zhongqiu Han <quic_zhonhan@quicinc.com> wrote:
>>
>> Currently, the PM QoS framework supports global CPU latency QoS and
>> per-device CPU latency QoS requests. An example of using global CPU
>> latency QoS is a commit 2777e73fc154 ("scsi: ufs: core: Add CPU latency
>> QoS support for UFS driver") that improved random io performance by 15%
>> for ufs on specific device platform.
>>
>> However, this prevents all CPUs in the system from entering C states.
>> Typically, some threads or drivers know which specific CPUs they are
>> interested in. For example, drivers with IRQ affinity only want interrupts
>> to wake up and be handled on specific CPUs. Similarly, kernel thread bound
>> to specific CPUs through affinity only care about the latency of those
>> particular CPUs.
>>
>> This patch introduces support for partial CPUs PM QoS using a CPU affinity
>> mask, allowing flexible and more precise latency QoS settings for specific
>> CPUs. This can help save power, especially on heterogeneous platforms with
>> big and little cores, as well as some power-conscious embedded systems for
>> example:
>>
>>                          driver A       rt kthread B      module C
>>    CPU IDs (mask):         0-3              2-5              6-7
>>    target latency(us):     20               30               100
>>                            |                |                |
>>                            v                v                v
>>                            +---------------------------------+
>>                            |        PM  QoS  Framework       |
>>                            +---------------------------------+
>>                            |                |                |
>>                            v                v                v
>>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>>    runtime latency(us):   20             20, 30             100
>>
>> Implement this support based on per-device CPU latency PM QoS.

Hi Rafael,
Thanks for your review~

> 
> I have a few concerns regarding this patch.
> 
> The first one is the naming.
> 
> You want to be able to set wakeup latency QoS limits for multiple CPUs
> at the same time.  Fair enough, but what does it have to do with
> affinity of any sort?
> 
> Why don't you call the functions cpu_latency_qos_add_multiple() and so on?

My original intention was to bind a specific request to a specific group
of CPUs. But you're right — the essence here is really just adding QoS
to multiple CPUs. I will rename it accordingly.


> 
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>>   include/linux/pm_qos.h |  40 +++++++++++
>>   kernel/power/qos.c     | 160 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 200 insertions(+)
>>
>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
>> index 4a69d4af3ff8..2dbad825f8bd 100644
>> --- a/include/linux/pm_qos.h
>> +++ b/include/linux/pm_qos.h
>> @@ -131,6 +131,15 @@ enum pm_qos_req_action {
>>          PM_QOS_REMOVE_REQ       /* Remove an existing request */
>>   };
>>
>> +/* cpu affinity pm latency qos request handle */
>> +struct cpu_affinity_qos_req {
>> +       struct list_head list;
> 
> Is the list really an adequate data structure here?
> 
> The number of CPUs in the mask is known at the request addition time
> and it fails completely if the request cannot be added for one CPU
> IIUC, so why don't you use an array of requests instead?

Yes, using an array is sufficient. the list tend to cause poor cache
locality and other issues. Thanks for your sharing.

> 
>> +       union {
>> +               struct dev_pm_qos_request req;
>> +               void *req_ptr;
>> +       };
> 
> Why do you need the union here?
> 
> Checking if the request is active only requires inspecting one CPU
> involved in it AFAICS.

yes, I can find an anchor point to determine whether it's active, for
example by reusing dev_pm_qos_request_active to check one of the CPUs
instead of using such obscure and complex data structures.

> 
>> +};
>> +
>>   static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
>>   {
>>          return req->dev != NULL;
>> @@ -208,6 +217,13 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
>>                  PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
>>                  pm_qos_read_value(&dev->power.qos->resume_latency);
>>   }
>> +
>> +int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_req *pm_req,
>> +                                 const cpumask_t *affinity_mask, s32 latency_value);
>> +int cpu_affinity_latency_qos_remove(struct cpu_affinity_qos_req *pm_req);
>> +int cpu_affinity_latency_qos_release(struct cpu_affinity_qos_req *pm_req);
> 
> Why is a separate release function needed?

You're right, that part was redundant. I feel a bit awkward about it.


> 
> Also, why don't you think that a separate function for updating an
> existing request would be useful?

Yes, exactly, I also think it's needed. However, as I mentioned in the
cover letter, I haven't found actual users for it at the moment. This
patch series is intended to help reduce power consumption, so either I
or other developers can submit a request to use the update function when
it's needed in the future. As for me, I already plan to propose a patch
that uses the update interface in the UFS module. Since UFS is not my
technical focus, there are still some pending items on that from my
collaborator.

> 
>> +bool cpu_affinity_latency_qos_active(struct cpu_affinity_qos_req *pm_req);
>> +void wakeup_qos_affinity_idle_cpu(int cpu);
>>   #else
>>   static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
>>                                                            s32 mask)
>> @@ -289,6 +305,30 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
>>   {
>>          return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>>   }
>> +
>> +static inline int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_req *pm_req,
>> +                                               const cpumask_t *affinity_mask,
>> +                                               s32 latency_value)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline int cpu_affinity_latency_qos_remove(
>> +                  struct cpu_affinity_qos_req *pm_req)
>> +{
>> +       return 0;
>> +}
>> +static inline int cpu_affinity_latency_qos_release(
>> +                  struct cpu_affinity_qos_req *pm_req)
>> +{
>> +       return 0;
>> +}
>> +static inline bool cpu_affinity_latency_qos_active(
>> +                   struct cpu_affinity_qos_req *pm_req)
>> +{
>> +       return false;
>> +}
>> +static inline void wakeup_qos_affinity_idle_cpu(int cpu) {}
>>   #endif
>>
>>   static inline int freq_qos_request_active(struct freq_qos_request *req)
>> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
>> index 4244b069442e..5e507ed8d077 100644
>> --- a/kernel/power/qos.c
>> +++ b/kernel/power/qos.c
>> @@ -335,6 +335,166 @@ void cpu_latency_qos_remove_request(struct pm_qos_request *req)
>>   }
>>   EXPORT_SYMBOL_GPL(cpu_latency_qos_remove_request);
>>
>> +#ifdef CONFIG_PM
>> +
>> +/**
>> + * wakeup_qos_affinity_idle_cpu - break one specific cpu out of idle.
>> + * @cpu: the CPU to be woken up from idle.
>> + */
>> +void wakeup_qos_affinity_idle_cpu(int cpu)
>> +{
>> +       preempt_disable();
>> +       if (cpu != smp_processor_id() && cpu_online(cpu))
>> +               wake_up_if_idle(cpu);
>> +       preempt_enable();
>> +}
> 
> This duplicates code from wake_up_all_idle_cpus() that duplication is
> easily avoidable.

Sorry about that. I'll explore a cleaner solution, possibly by wrapping
it as an function and integrating the change into
sched module func wake_up_all_idle_cpus().

> 
>> +
>> +/**
>> + * cpu_affinity_latency_qos_add - Add new CPU affinity latency QoS request.
>> + * @pm_req: Pointer to a preallocated handle.
>> + * @affinity_mask: Mask to determine which CPUs need latency QoS.
>> + * @latency_value: New requested constraint value.
>> + *
>> + * Use @latency_value to initialize the request handle pointed to by @pm_req,
>> + * insert it as a new entry to the CPU latency QoS list and recompute the
>> + * effective QoS constraint for that list, @affinity_mask determine which CPUs
>> + * need the latency QoS.
>> + *
>> + * Callers need to save the handle for later use in updates and removal of the
>> + * QoS request represented by it.
>> + *
> 
> It would be good to also say that callers are responsible for
> synchronizing the calls to add and remove functions for the same
> request.

Thanks for pointing that out.The active api check alone can't really
prevent misuse by users.
I might also need to review the code and documentation of the
cpu_latency_qos_add_request interface, and include the fix in the next
patch version.


> 
>> + * Returns 0 or a positive value on success, or a negative error code on failure.
>> + */
>> +int cpu_affinity_latency_qos_add(struct cpu_affinity_qos_req *pm_req,
>> +                                 const cpumask_t *affinity_mask,
>> +                                 s32 latency_value)
>> +{
>> +       int cpu;
>> +       cpumask_t actual_mask;
>> +       struct cpu_affinity_qos_req *cpu_pm_req;
>> +       int ret = 0;
>> +
>> +       if (!pm_req) {
>> +               pr_err("%s: invalid PM Qos request\n", __func__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (cpu_affinity_latency_qos_active(pm_req)) {
>> +               WARN(1, "%s called for already added request\n", __func__);
>> +               return -EBUSY;
>> +       }
> 
> The usual pattern for checks like this is
> 
> if (WARN(cpu_affinity_latency_qos_active(pm_req), message))
>           return error;

Got it, Thanks, will fix it~

> 
> And, which is not related to the above, if a function is defined in
> the same file as its caller, I prefer it to be defined before its
> caller.

Got it, that makes sense. I'll fix it~

> 
>> +
>> +       INIT_LIST_HEAD(&pm_req->list);
>> +
>> +       if (!affinity_mask || cpumask_empty(affinity_mask) ||
>> +           latency_value < 0) {
>> +               pr_err("%s: invalid PM Qos request value\n", __func__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       for_each_cpu(cpu, affinity_mask) {
>> +               cpu_pm_req = kzalloc(sizeof(struct cpu_affinity_qos_req),
>> +                                    GFP_KERNEL);
>> +               if (!cpu_pm_req) {
>> +                       ret = -ENOMEM;
>> +                       goto out_err;
>> +               }
>> +               ret = dev_pm_qos_add_request(get_cpu_device(cpu),
>> +                                            &cpu_pm_req->req,
>> +                                            DEV_PM_QOS_RESUME_LATENCY,
>> +                                            latency_value);
>> +               if (ret < 0) {
>> +                       pr_err("failed to add latency req for cpu%d", cpu);
> 
> Why do you want to print an error message here?  Is this anything that
> the sysadmin should know about?  If not, then maybe dev_dbg() should
> be sufficient?

Fair point. I initially considered a failure to set PM QoS as a
significant, rare, and hard-to-reproduce issue. However, it seems that
such debugging concerns are more relevant to developers than to system
administrators. I will fix it.


> 
>> +                       kfree(cpu_pm_req);
>> +                       goto out_err;
>> +               } else if (ret > 0) {
>> +                       wakeup_qos_affinity_idle_cpu(cpu);
>> +               }
>> +
>> +               cpumask_set_cpu(cpu, &actual_mask);
>> +               list_add(&cpu_pm_req->list, &pm_req->list);
>> +       }
>> +
>> +       pr_info("PM Qos latency: %d added on cpus %*pb\n", latency_value,
>> +               cpumask_pr_args(&actual_mask));
> 
> I'm not sure why the actual_mask variable is needed.  AFAICS, the
> function fails anyway if the request cannot be added for any CPU in
> the original mask.

This is because I'm concerned that the mask passed by the user might
contain invalid values, which could result in some CPUs not being
traversed at all. (Please note, this isn't a PM QoS failure — it's that
the loop doesn't even get entered.) Users might be confused about what's
going wrong, so I wanted to give them a hint. That said, I’m also open
to dropping this idea if it seems odd or unnecessary.


> 
>> +       pm_req->req_ptr = pm_req;
>> +       return ret;
>> +
>> +out_err:
>> +       cpu_affinity_latency_qos_release(pm_req);
>> +       pr_err("failed to add PM QoS latency req, removed all added requests\n");
> 
> A message about this has already been printed.  Why print another one?

yes, one should be enough and maybe just in out_err: .

> 
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_add);
>> +
>> +
>> +/**
>> + * cpu_affinity_latency_qos_remove - Remove an existing CPU affinity latency QoS.
>> + * @pm_req: Handle to the QoS request to be removed.
>> + *
>> + * Remove the CPU latency QoS request represented by @pm_req from the CPU latency
>> + * QoS list. This handle must have been previously initialized and added via
>> + * cpu_affinity_latency_qos_add().
>> + */
>> +int cpu_affinity_latency_qos_remove(struct cpu_affinity_qos_req *pm_req)
>> +{
>> +       if (!pm_req) {
>> +               pr_err("%s: invalid PM Qos request value\n", __func__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!cpu_affinity_latency_qos_active(pm_req)) {
>> +               WARN(1, "%s called for unknown object\n", __func__);
>> +               return -EINVAL;
>> +       }
> 
> Same pattern comment as above applies here.

Got it~

> 
>> +
>> +       return cpu_affinity_latency_qos_release(pm_req);
>> +}
>> +EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_remove);
>> +
>> +/**
>> + * cpu_affinity_latency_qos_release - Release pm_reqs latency QoS resource.
>> + * @pm_req: QoS request to be released.
>> + *
>> + * Release pm_reqs managed CPU affinity latency QoS resource.
>> + *
>> + * Returns a negative value indicates failure.
>> + */
>> +int cpu_affinity_latency_qos_release(struct cpu_affinity_qos_req *pm_req)
>> +{
>> +       int ret = 0;
>> +       struct cpu_affinity_qos_req *cpu_pm_req, *next;
>> +
>> +       list_for_each_entry_safe(cpu_pm_req, next, &pm_req->list, list) {
>> +               ret = dev_pm_qos_remove_request(&cpu_pm_req->req);
>> +               if (ret < 0)
>> +                       pr_err("failed to remove qos request for %s\n",
>> +                              dev_name(cpu_pm_req->req.dev));
>> +               list_del(&cpu_pm_req->list);
>> +               kfree(cpu_pm_req);
>> +               cpu_pm_req = NULL;
>> +       }
>> +
>> +       memset(pm_req, 0, sizeof(*pm_req));
>> +       return ret;
>> +}
>> +
>> +/**
>> + * cpu_affinity_latency_qos_active - Check if a CPU affinity latency QoS
>> + * request is active.
>> + * @pm_req: Handle to the QoS request.
>> + *
>> + * Return: 'true' if @pm_req has been added to the CPU latency QoS list,
>> + * 'false' otherwise.
>> + */
>> +bool cpu_affinity_latency_qos_active(struct cpu_affinity_qos_req *pm_req)
>> +{
>> +       return pm_req->req_ptr == pm_req;
>> +}
>> +EXPORT_SYMBOL_GPL(cpu_affinity_latency_qos_active);
>> +
>> +#endif /* CONFIG_PM */
>> +
>>   /* User space interface to the CPU latency QoS via misc device. */
>>
>>   static int cpu_latency_qos_open(struct inode *inode, struct file *filp)
>> --
> 
> I'll look at the rest of the series whey all of my comments on this
> patch have been addressed.

Thanks a lot for the review~

> 
> Thanks!


-- 
Thx and BRs,
Zhongqiu Han

