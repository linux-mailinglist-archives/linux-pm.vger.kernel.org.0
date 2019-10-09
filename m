Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36461D14AE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfJIQzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 12:55:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730546AbfJIQzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 12:55:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x99GjbPf100532
        for <linux-pm@vger.kernel.org>; Wed, 9 Oct 2019 12:55:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhjdkjgnk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 12:55:37 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 9 Oct 2019 17:55:35 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 17:55:29 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x99GtTWv45220108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 16:55:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF22A4C050;
        Wed,  9 Oct 2019 16:55:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61EBF4C044;
        Wed,  9 Oct 2019 16:55:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.75.123])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 16:55:24 +0000 (GMT)
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Quentin Perret <qperret@qperret.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20191007083051.4820-1-parth@linux.ibm.com>
 <20191008132842.6612-1-hdanton@sina.com>
 <d4c936d9-c99f-e50d-95c9-0732ae45d1b9@linux.ibm.com>
 <CAKfTPtDghQrjK=4Pd0RbvwbQTU1SP88nVp6NLkNitk+07UfadA@mail.gmail.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Wed, 9 Oct 2019 22:25:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDghQrjK=4Pd0RbvwbQTU1SP88nVp6NLkNitk+07UfadA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100916-0012-0000-0000-000003568EB5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100916-0013-0000-0000-0000219194CD
Message-Id: <24b07842-1770-13b9-8182-8dcf4f0a28fa@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090147
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/9/19 5:04 PM, Vincent Guittot wrote:
> On Wed, 9 Oct 2019 at 11:23, Parth Shah <parth@linux.ibm.com> wrote:
>>
>>
>>
>> On 10/8/19 6:58 PM, Hillf Danton wrote:
>>>
>>> On Mon,  7 Oct 2019 14:00:49 +0530 Parth Shah wrote:
>>>> +/*
>>>> + * Try to find a non idle core in the system  based on few heuristics:
>>>> + * - Keep track of overutilized (>80% util) and busy (>12.5% util) CPUs
>>>> + * - If none CPUs are busy then do not select the core for task packing
>>>> + * - If atleast one CPU is busy then do task packing unless overutilized CPUs
>>>> + *   count is < busy/2 CPU count
>>>> + * - Always select idle CPU for task packing
>>>> + */
>>>> +static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
>>>> +{
>>>> +    struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
>>>> +    int iter_cpu, sibling;
>>>> +
>>>> +    cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
>>>> +
>>>> +    for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
>>>> +            int idle_cpu_count = 0, non_idle_cpu_count = 0;
>>>> +            int overutil_cpu_count = 0;
>>>> +            int busy_cpu_count = 0;
>>>> +            int best_cpu = iter_cpu;
>>>> +
>>>> +            for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
>>>> +                    __cpumask_clear_cpu(sibling, cpus);
>>>> +                    if (idle_cpu(iter_cpu)) {
>>>
>>> Would you please elaborate the reasons that the iter cpu is checked idle
>>> more than once for finding a busy core?
>>>
>>
>> Thanks for looking at the patches.
>> Could you please point me out where iter_cpu is checked more than once?
> 
> I think that point is that you have a sibling that there is
> for_each_cpu(sibling, cpu_smt_mask(iter_cpu) but you never use sibling
> in the loop except for clearing it on the cpumask cpus
> All the tests are done with iter_cpu so you will test several time
> iter_cpus but never the other sibling
> Should you use sibling instead ?
> 

oh got it. it was unintentional here, my bad.
good find

I did s/iter_cpu/sibling/ at required places:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4a1b6474338..a75c2b382771 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6001,14 +6001,14 @@ static int select_non_idle_core(struct task_struct
*p, int prev_cpu, int target)

                for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
                        __cpumask_clear_cpu(sibling, cpus);
-                       if (idle_cpu(iter_cpu)) {
+                       if (idle_cpu(sibling)) {
                                idle_cpu_count++;
-                               best_cpu = iter_cpu;
+                               best_cpu = sibling;
                        } else {
                                non_idle_cpu_count++;
-                               if (cpu_overutilized(iter_cpu))
+                               if (cpu_overutilized(sibling))
                                        overutil_cpu_count++;
-                               if (is_cpu_busy(cpu_util(iter_cpu)))
+                               if (is_cpu_busy(cpu_util(sibling)))
                                        busy_cpu_count++;
                        }
                }

and the took the results again to see functionality changes.
Results are still within the bounds with maximum of 15% gain in performance
and <2% of regression.

		Frequency benefit of TurboSched w.r.t. CFS
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
20 +-+ + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + +-+
   |                                      Frequency benefit in %         |
   |                    **                                               |
15 +-+        * * **    ******                                         +-+
   |          * * ************                                           |
   |       ** * * ************ *                                         |
10 +-+     ** * * ************ *                                       +-+
   |       ** * * ************ * * ****                                  |
   |     **** * * ************ * * ****                                  |
 5 +-+ ****** * * ************ * * ******                              +-+
   |   ****** * * ************ * * **********                            |
 0 +-******** * * ************ * * ************ * * * ********** * * * **+
   |                                                                     |
   |                                                                     |
-5 +-+                                                                 +-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
     0 1 2 3  4 5 6 7 8 91011 1213141516171819 2021222324252627 28293031
                           No. of workload threads

		 Performance benefit of TurboSched w.r.t. CFS
20 +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   |                                    Performance benefit in %         |
15 +-+                    **                                           +-+
   |                      **                                             |
   |                  ******** *                                         |
10 +-+                ******** *   **                                  +-+
   |                  ******** * * **                                    |
   |                  ******** * * **                                    |
 5 +-+              ********** * * ******                              +-+
   |                ********** * * **********                            |
   |              ************ * * **********   *       **               |
 0 +-******** * * ************ * * ************ * * * ********** * * * **+
   | ******** *                                                          |
   |                                                                     |
-5 +-+                                                                 +-+
   | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |
   +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+
     0 1 2 3  4 5 6 7 8 91011 1213141516171819 2021222324252627 28293031
                           No. of workload threads

Thanks,
Parth

> 
>>
>>>> +                            idle_cpu_count++;
>>>> +                            best_cpu = iter_cpu;
>>>> +                    } else {
>>>> +                            non_idle_cpu_count++;
>>>> +                            if (cpu_overutilized(iter_cpu))
>>>> +                                    overutil_cpu_count++;
>>>> +                            if (is_cpu_busy(cpu_util(iter_cpu)))
>>>> +                                    busy_cpu_count++;
>>>> +                    }
>>>> +            }
>>>> +
>>>
>>

