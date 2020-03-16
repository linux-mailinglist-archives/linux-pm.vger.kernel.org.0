Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F03186C9F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 14:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbgCPNzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 09:55:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731110AbgCPNzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 09:55:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GDr9qB027543
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 09:55:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yrudfspp1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 09:55:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <psampat@linux.ibm.com>;
        Mon, 16 Mar 2020 13:54:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Mar 2020 13:54:57 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02GDsvs036896812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 13:54:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02E54AE053;
        Mon, 16 Mar 2020 13:54:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5DC2AE051;
        Mon, 16 Mar 2020 13:54:55 +0000 (GMT)
Received: from [9.85.92.169] (unknown [9.85.92.169])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Mar 2020 13:54:55 +0000 (GMT)
Subject: Re: [PATCH] Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu
 frequency to policy->cur on unthrottling")
To:     Daniel Axtens <dja@axtens.net>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com, ego@linux.vnet.ibm.com
References: <20200306110549.25517-1-psampat@linux.ibm.com>
 <87v9n4o3fk.fsf@dja-thinkpad.axtens.net>
From:   Pratik Sampat <psampat@linux.ibm.com>
Date:   Mon, 16 Mar 2020 19:24:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87v9n4o3fk.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20031613-0016-0000-0000-000002F200DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031613-0017-0000-0000-000033557CD8
Message-Id: <30ee9ce2-b27b-785d-21bf-890047b4b64d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-16_03:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160067
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Sure thing I'll re-send them. Rookie mistake, my bad.
Thanks for pointing it out!

Regards,
Pratik

On 16/03/20 6:35 pm, Daniel Axtens wrote:
> Hi Pratik,
>
> Please could you resend this with a more meaningful subject line and
> move the Fixes: line to immediately above your signed-off-by?
>
> Thanks!
>
> Regards,
> Daniel
>
>> The patch avoids allocating cpufreq_policy on stack hence fixing frame
>> size overflow in 'powernv_cpufreq_work_fn'
>>
>> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
>> ---
>>   drivers/cpufreq/powernv-cpufreq.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index 56f4bc0d209e..20ee0661555a 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -902,6 +902,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>>   void powernv_cpufreq_work_fn(struct work_struct *work)
>>   {
>>   	struct chip *chip = container_of(work, struct chip, throttle);
>> +	struct cpufreq_policy *policy;
>>   	unsigned int cpu;
>>   	cpumask_t mask;
>>   
>> @@ -916,12 +917,14 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
>>   	chip->restore = false;
>>   	for_each_cpu(cpu, &mask) {
>>   		int index;
>> -		struct cpufreq_policy policy;
>>   
>> -		cpufreq_get_policy(&policy, cpu);
>> -		index = cpufreq_table_find_index_c(&policy, policy.cur);
>> -		powernv_cpufreq_target_index(&policy, index);
>> -		cpumask_andnot(&mask, &mask, policy.cpus);
>> +		policy = cpufreq_cpu_get(cpu);
>> +		if (!policy)
>> +			continue;
>> +		index = cpufreq_table_find_index_c(policy, policy->cur);
>> +		powernv_cpufreq_target_index(policy, index);
>> +		cpumask_andnot(&mask, &mask, policy->cpus);
>> +		cpufreq_cpu_put(policy);
>>   	}
>>   out:
>>   	put_online_cpus();
>> -- 
>> 2.17.1

