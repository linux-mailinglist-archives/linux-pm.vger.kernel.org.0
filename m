Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21D6D0A67
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfJII5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 04:57:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbfJII5g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 04:57:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x998vWf3083309
        for <linux-pm@vger.kernel.org>; Wed, 9 Oct 2019 04:57:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhbpd9q9d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 04:57:32 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 9 Oct 2019 09:57:23 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 09:57:18 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x998vH2L26214522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 08:57:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9B5842041;
        Wed,  9 Oct 2019 08:57:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93A954204B;
        Wed,  9 Oct 2019 08:57:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.210])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 08:57:15 +0000 (GMT)
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Quentin Perret <qperret@qperret.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20191007083051.4820-1-parth@linux.ibm.com>
 <20191007083051.4820-5-parth@linux.ibm.com>
 <CAKfTPtCgoTJXxbYyza1W55ayw9QeM7fue2e91Xpt804sL9GQWA@mail.gmail.com>
 <80bb34ec-6358-f4dc-d20d-cde6c9d7e197@linux.ibm.com>
 <d55c593d-af8e-c8ba-cc0e-c9917df5d593@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Wed, 9 Oct 2019 14:27:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d55c593d-af8e-c8ba-cc0e-c9917df5d593@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100908-0020-0000-0000-000003776260
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100908-0021-0000-0000-000021CD67E2
Message-Id: <86dc25e4-9f19-627f-9581-d74608b7f20c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090085
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/8/19 10:22 PM, Dietmar Eggemann wrote:
> [- Quentin Perret <quentin.perret@arm.com>]
> [+ Quentin Perret <qperret@qperret.net>]
> 
> See commit c193a3ffc282 ("mailmap: Update email address for Quentin Perret")
> 

noted. thanks for notifying me.

> On 07/10/2019 18:53, Parth Shah wrote:
>>
>>
>> On 10/7/19 5:49 PM, Vincent Guittot wrote:
>>> On Mon, 7 Oct 2019 at 10:31, Parth Shah <parth@linux.ibm.com> wrote:
>>>>
>>>> The algorithm finds the first non idle core in the system and tries to
>>>> place a task in the idle CPU in the chosen core. To maintain
>>>> cache hotness, work of finding non idle core starts from the prev_cpu,
>>>> which also reduces task ping-pong behaviour inside of the core.
>>>>
>>>> Define a new method to select_non_idle_core which keep tracks of the idle
>>>> and non-idle CPUs in the core and based on the heuristics determines if the
>>>> core is sufficiently busy to place the incoming backgroung task. The
>>>> heuristic further defines the non-idle CPU into either busy (>12.5% util)
>>>> CPU and overutilized (>80% util) CPU.
>>>> - The core containing more idle CPUs and no busy CPUs is not selected for
>>>>   packing
>>>> - The core if contains more than 1 overutilized CPUs are exempted from
>>>>   task packing
>>>> - Pack if there is atleast one busy CPU and overutilized CPUs count is <2
>>>>
>>>> Value of 12.5% utilization for busy CPU gives sufficient heuristics for CPU
>>>> doing enough work an
> 
> [...]
> 
>>>> @@ -6483,7 +6572,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>>>>         } else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
>>>>                 /* Fast path */
>>>>
>>>> -               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>>>> +               if (is_turbosched_enabled() && unlikely(is_background_task(p)))
>>>> +                       new_cpu = turbosched_select_non_idle_core(p, prev_cpu,
>>>> +                                                                 new_cpu);
>>>
>>> Could you add turbosched_select_non_idle_core() similarly to
>>> find_energy_efficient_cpu() ?
>>> Add it at the beg select_task_rq_fair()
>>> Return immediately with theCPU if you have found one
>>> Or let the normal path select a CPU if the
>>> turbosched_select_non_idle_core() has not been able to find a suitable
>>> CPU for packing
>>>
>>
>> of course. I can do that.
>> I was just not aware about the effect of wake_affine and so was waiting for
>> such comments to be sure of. Thanks for this.
>> Maybe I can add just below the sched_energy_present(){...} construct giving
>> precedence to EAS? I'm asking this because I remember Patrick telling me to
>> leverage task packing for android as well?
> 
> I have a hard time imaging that Turbosched will be used in Android next
> to EAS in the foreseeable future.
> 
> First of all, EAS provides task packing already on Performance Domain
> (PD) level (a.k.a. as cluster on traditional 2-cluster Arm/Arm64
> big.LITTLE or DynamIQ (with Phantom domains (out of tree solution)).
> This is where we can safe energy without harming latency.
> 
> See the tests results under '2.1 Energy test case' in
> 
> https://lore.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com
> 
> There are 10 to 50 small (classified solely by task utilization) tasks
> per test case and EAS shows an effect on energy consumption by packing
> them onto the PD (cluster) of the small CPUs.
> 
> And second, the CPU supported topology is different to the one you're
> testing on.
> 

cool. I was just keeping in mind the following quote
" defining a generic spread-vs-pack wakeup policy which is something
Android also could benefit from " (https://lkml.org/lkml/2019/6/28/628)

BTW, IIUC that does task consolidation only on single CPU unless
rd->overload is set, right?

> [...]
> 

