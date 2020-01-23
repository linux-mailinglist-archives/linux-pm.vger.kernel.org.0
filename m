Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC450146201
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 07:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgAWGgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 01:36:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgAWGgG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 01:36:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N6WOJ2103498
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 01:36:05 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp93qftx4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 01:36:05 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 23 Jan 2020 06:36:03 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Jan 2020 06:35:59 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00N6ZwVq53149826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 06:35:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FEB74C040;
        Thu, 23 Jan 2020 06:35:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45DA04C046;
        Thu, 23 Jan 2020 06:35:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.18.124])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jan 2020 06:35:53 +0000 (GMT)
Subject: Re: [RFC v6 1/5] sched: Introduce switch to enable TurboSched for
 task packing
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        qperret@google.com
References: <20200121063307.17221-1-parth@linux.ibm.com>
 <20200121063307.17221-2-parth@linux.ibm.com>
 <0fb8fa5c-0edd-913d-912f-df383a3d4007@linux.intel.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 23 Jan 2020 12:05:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0fb8fa5c-0edd-913d-912f-df383a3d4007@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012306-0020-0000-0000-000003A334D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012306-0021-0000-0000-000021FACCA8
Message-Id: <1f99c7cc-223c-302d-2c42-a3933e2d8877@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230055
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/23/20 3:07 AM, Tim Chen wrote:
> On 1/20/20 10:33 PM, Parth Shah wrote:
>> Create a static key which allows to enable or disable TurboSched feature at
>> runtime.
>>
>> This key is added in order to enable the TurboSched feature only when
>> required. This helps in optimizing the scheduler fast-path when the
>> TurboSched feature is disabled.
>>
>> Also provide get/put methods to keep track of the tasks using the
>> TurboSched feature and also refcount classified background tasks. This
>> allows to enable the feature on setting first task classified as background
>> noise, similarly disable the feature on unsetting of such last task.
>>
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>> ---
>>  kernel/sched/core.c  | 25 +++++++++++++++++++++++++
>>  kernel/sched/sched.h | 12 ++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a9e5d157b1a5..dfbb52d66b29 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -73,6 +73,31 @@ __read_mostly int scheduler_running;
>>   */
>>  int sysctl_sched_rt_runtime = 950000;
>>  
>> +#ifdef CONFIG_SCHED_SMT
>> +DEFINE_STATIC_KEY_FALSE(__turbo_sched_enabled);
>> +static DEFINE_MUTEX(turbo_sched_lock);
>> +static int turbo_sched_count;
>> +
>> +void turbo_sched_get(void)
>> +{
>> +	mutex_lock(&turbo_sched_lock);
>> +	if (!turbo_sched_count++)
>> +		static_branch_enable(&__turbo_sched_enabled);
> 
> If you use static_branch_inc(&__turbo_sched_enabled) and
> static_branch_dec(&__turbo_sched_enabled),  you don't have
> to define turbo_sched_count. And turbo_sched_lock is
> also unnecessary as static_branch_inc/dec are atomic.
> 

That's a good suggestion. I will make those changes in the next version.

>> +	mutex_unlock(&turbo_sched_lock);
>> +}
>> +
>> +void turbo_sched_put(void)
>> +{
>> +	mutex_lock(&turbo_sched_lock);
>> +	if (!--turbo_sched_count)
>> +		static_branch_disable(&__turbo_sched_enabled);
>> +	mutex_unlock(&turbo_sched_lock);
>> +}
>> +#else
>> +void turbo_sched_get(void) { return ; }
>> +void turbo_sched_get(void) { return ; }
> 
> Double definition of turbo_sched_get.
> You probably meant turbo_sched_put in the second definition.

yes, my bad. I meant turbo_sched_put() instead.


Thanks,
Parth

> 
> Tim
> 

