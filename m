Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15956D14C5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 19:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfJIRCu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 13:02:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730546AbfJIRCu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 13:02:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x99H1Zs3110365
        for <linux-pm@vger.kernel.org>; Wed, 9 Oct 2019 13:02:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhk6rgwda-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2019 13:02:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 9 Oct 2019 18:02:46 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 18:02:41 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x99H2eUi19464206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 17:02:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 549C84C044;
        Wed,  9 Oct 2019 17:02:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3727B4C050;
        Wed,  9 Oct 2019 17:02:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.75.123])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 17:02:35 +0000 (GMT)
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
 <86dc25e4-9f19-627f-9581-d74608b7f20c@linux.ibm.com>
 <eef32b9e-1f24-e8a9-cd91-dcc6546a636f@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Wed, 9 Oct 2019 22:32:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <eef32b9e-1f24-e8a9-cd91-dcc6546a636f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100917-0028-0000-0000-000003A88AF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100917-0029-0000-0000-0000246A9081
Message-Id: <0ee8052e-e7fb-83cb-bf70-3c4855ccca8e@linux.ibm.com>
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



On 10/9/19 7:56 PM, Dietmar Eggemann wrote:
> On 09/10/2019 10:57, Parth Shah wrote:
> 
> [...]
> 
>>> On 07/10/2019 18:53, Parth Shah wrote:
>>>>
>>>>
>>>> On 10/7/19 5:49 PM, Vincent Guittot wrote:
>>>>> On Mon, 7 Oct 2019 at 10:31, Parth Shah <parth@linux.ibm.com> wrote:
> 
> [...]
> 
>>>> Maybe I can add just below the sched_energy_present(){...} construct giving
>>>> precedence to EAS? I'm asking this because I remember Patrick telling me to
>>>> leverage task packing for android as well?
>>>
>>> I have a hard time imaging that Turbosched will be used in Android next
>>> to EAS in the foreseeable future.
>>>
>>> First of all, EAS provides task packing already on Performance Domain
>>> (PD) level (a.k.a. as cluster on traditional 2-cluster Arm/Arm64
>>> big.LITTLE or DynamIQ (with Phantom domains (out of tree solution)).
>>> This is where we can safe energy without harming latency.
>>>
>>> See the tests results under '2.1 Energy test case' in
>>>
>>> https://lore.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com
>>>
>>> There are 10 to 50 small (classified solely by task utilization) tasks
>>> per test case and EAS shows an effect on energy consumption by packing
>>> them onto the PD (cluster) of the small CPUs.
>>>
>>> And second, the CPU supported topology is different to the one you're
>>> testing on.
>>>
>>
>> cool. I was just keeping in mind the following quote
>> " defining a generic spread-vs-pack wakeup policy which is something
>> Android also could benefit from " (https://lkml.org/lkml/2019/6/28/628)
> 
> The main thing is that in case we want to introduce a new functionality
> into CFS, we should try hard to use existing infrastructure (or
> infrastructure there is agreement on that we'll need it) as much as
> possible.
> 
> If I understand Patrick here correctly, he suggested not to use uclamp
> but the task latency nice approach. There is agreement that we would
> need something like this as infrastructure:
> 
> https://lore.kernel.org/r/20190830174944.21741-1-subhra.mazumdar@oracle.com
> 

got it.

> So p->latency_nice is suitable to include your p->flags |=
> PF_CAN_BE_PACKED concept nicely.

yeah, I'm working on that part too as a bigger goal.

> 
>>
>> BTW, IIUC that does task consolidation only on single CPU unless
>> rd->overload is set, right?
> 
> Task consolidation on Performance Domains (PDs) w/ multiple CPUs (e.g.
> on a per-cluster PD big.LITTLE system) only works when the system is not
> overutilized:
> 
> 6326 int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> 6327 {
> ...
> 6337         if (!pd || *READ_ONCE(rd->overutilized)*)
> 6338                 goto fail;
> ...

ok. so does that mean TurboSched can still do some good in such systems as
well ?
I mean save energy even when rd->overutilized==1 by not waking user
classified bg tasks on idle core.

> 
> [...]
> 

Thanks,
Parth

