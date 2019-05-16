Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474A720D99
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 19:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfEPRCP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 13:02:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727354AbfEPRCP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 13:02:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GH20ZK098386
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 13:02:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2shahrbv2a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 13:02:13 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 16 May 2019 18:02:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 18:02:08 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GH26Md22413422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 17:02:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7B5C5247B;
        Thu, 16 May 2019 16:12:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.91.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B8D895246D;
        Thu, 16 May 2019 16:12:36 +0000 (GMT)
Subject: Re: [RFCv2 1/6] sched/core: Add manual jitter classification from
 cgroup interface
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-2-parth@linux.ibm.com>
 <20190515162924.GT2589@hirez.programming.kicks-ass.net>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 16 May 2019 21:42:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190515162924.GT2589@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051617-0016-0000-0000-0000027C7239
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051617-0017-0000-0000-000032D94A6B
Message-Id: <00950713-f386-a91e-d1e2-17db26e8e487@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160108
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/15/19 9:59 PM, Peter Zijlstra wrote:
> On Wed, May 15, 2019 at 07:23:17PM +0530, Parth Shah wrote:
> 
>> Subject: [RFCv2 1/6] sched/core: Add manual jitter classification from cgroup interface
> 
> How can this be v2 ?! I've never seen v1.
> 

Actually, I sent out v1 on linux-pm@vger.kernel.org mailing list. This patch set
is then refined and re-organized to get better comments from larger audience.
You can find v1 at https://lwn.net/Articles/783959/

>> Jitter tasks are usually of less important in terms of performance
>> and are short/bursty in characteristics. TurboSched uses this jitter
>> classification to pack jitters into the already running busy cores to
>> keep the total idle core count high.
>>
>> The patch describes the use of UCLAMP mechanism to classify tasks. Patrick
>> Bellasi came up with a mechanism to classify tasks from the userspace
>> https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com/
> 
> The canonical form is:
> 
> 	https://lkml.kernel.org/r/$MSGID
> 

Thanks for pointing out. I will use the above form from next time onwards

>> This UCLAMP mechanism can be useful in classifying tasks as jitter. Jitters
>> can be classified for the cgroup by keeping util.max of the tasks as the
>> least(=0). This also provides benefit of giving the least frequency to
>> those jitter tasks, which is useful if all jitters are packed onto a
>> separate core.
>>
>> Use Case with UCLAMP
>> ===================
>> To create a cgroup with all the tasks classified as jitters;
>>
>> ```
>> mkdir -p /sys/fs/cgroup/cpu/jitter
>> echo 0 > /proc/sys/kernel/sched_uclamp_util_min;
>> echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.min;
>> echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.max;
>> i=8;
>> ./turbo_bench -t 30 -h $i -n $i &
>> ./turbo_bench -t 30 -h 0 -n $i &
>> echo $! > /sys/fs/cgroup/cpu/jitter/cgroup.procs;
>> ```
>>
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>> ---
>>  kernel/sched/core.c  | 9 +++++++++
>>  kernel/sched/sched.h | 1 +
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index d42c0f5eefa9..77aa4aee4478 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -7192,6 +7192,15 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
>>  	tg->uclamp_req[UCLAMP_MAX].value = max_value;
>>  	tg->uclamp_req[UCLAMP_MAX].bucket_id = uclamp_bucket_id(max_value);
>>  
>> +	/*
>> +	 * Classify the tasks belonging to the last bucket of MAX UCLAMP as
>> +	 * jitters
>> +	 */
>> +	if (uclamp_bucket_id(max_value) == 0)
>> +		tg->turbo_sched_enabled = 1;
>> +	else if (tg->turbo_sched_enabled)
>> +		tg->turbo_sched_enabled = 0;
>> +
>>  	/* Update effective clamps to track the most restrictive value */
>>  	cpu_util_update_eff(css, UCLAMP_MAX);
>>  
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index b4019012d84b..e75ffaf3ff34 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -407,6 +407,7 @@ struct task_group {
>>  	struct uclamp_se	uclamp[UCLAMP_CNT];
>>  #endif
>>  
>> +	bool			turbo_sched_enabled;
>>  };
> 
> Your simple patch has 3 problems:
> 
>  - it limits itself; for no apparent reason; to the cgroup interface.

Maybe I can add other interfaces like syscall to allow per-entity classification.

> 
>  - it is inconsistent in the terminology; pick either jitter or
>    turbo-sched, and I think the latter is a horrid name, it wants to be
>    'pack' or something similar. Also, jitter really doesn't make sense
>    given the classification.
> 

Yes, I will be happy to re-name any variables/function to enhance readability.

>  - you use '_Bool' in a composite type.
> 

Maybe I can switch to int.


Thanks,
Parth

