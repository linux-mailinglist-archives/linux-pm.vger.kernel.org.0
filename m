Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D6CDD9A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfJGIqr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 04:46:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbfJGIqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 04:46:47 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x978gb7N040005
        for <linux-pm@vger.kernel.org>; Mon, 7 Oct 2019 04:46:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vg1h996e4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 04:46:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 7 Oct 2019 09:46:43 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 09:46:36 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x978kZKf54853744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 08:46:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A765EA405F;
        Mon,  7 Oct 2019 08:46:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42FC1A4066;
        Mon,  7 Oct 2019 08:46:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.220])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 08:46:32 +0000 (GMT)
Subject: Re: [Discussion v2] Usecases for the per-task latency-nice attribute
To:     David Laight <David.Laight@ACULAB.COM>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "pjt@google.com" <pjt@google.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "dhaval.giani@oracle.com" <dhaval.giani@oracle.com>,
        "quentin.perret@arm.com" <quentin.perret@arm.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        "ggherdovich@suse.cz" <ggherdovich@suse.cz>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
References: <2bd46086-43ff-f130-8720-8eec694eb55b@linux.ibm.com>
 <9645e7c625a84bfabac001fd6ef35559@AcuMS.aculab.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Mon, 7 Oct 2019 14:16:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <9645e7c625a84bfabac001fd6ef35559@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100708-0016-0000-0000-000002B4C146
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0017-0000-0000-00003315D717
Message-Id: <133845e8-bdad-c0c0-a14b-a511ebb88fd4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070091
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/2/19 9:41 PM, David Laight wrote:
> From: Parth Shah
>> Sent: 30 September 2019 11:44
> ...
>> 5> Separating AVX512 tasks and latency sensitive tasks on separate cores
>> ( -Tim Chen )
>> ===========================================================================
>> Another usecase we are considering is to segregate those workload that will
>> pull down core cpu frequency (e.g. AVX512) from workload that are latency
>> sensitive. There are certain tasks that need to provide a fast response
>> time (latency sensitive) and they are best scheduled on cpu that has a
>> lighter load and not have other tasks running on the sibling cpu that could
>> pull down the cpu core frequency.
>>
>> Some users are running machine learning batch tasks with AVX512, and have
>> observed that these tasks affect the tasks needing a fast response.  They
>> have to rely on manual CPU affinity to separate these tasks.  With
>> appropriate latency hint on task, the scheduler can be taught to separate them.
> 
> Has this been diagnosed properly?
> I can't really see how the frequency drop from AVX512 significantly affects latency.
> Most tasks that require low latency probably don't do a lot of work.
> It is much more likely that the latency issues happen because the AVX512 tasks
> are doing very few system calls so can't be pre-empted even by a high priority task.> This 'feature' is hinted by this:
>> 2> TurboSched
>> ( -Parth Shah )
>> ====================
>> TurboSched [2] tries to minimize the number of active cores in a socket by
>> packing an un-important and low-utilization (named jitter) task on an
>> already active core and thus refrains from waking up of a new core if
>> possible.
> 

You are correct as both approach contradict each other in some sense.
But what TurboSched tried to achieve is doing task packing only for the
tasks classified by user as *latency in-sensitive*. Whereas, IIUC, what Tim
proposes here is to not pack *latency sensitive* tasks and I guess that
align with the TurboSched approach as well, isn't it?

Probably @Tim can throw some light on this for better clarification?

> Consider this example of a process that requires low latency (sub 1ms would be good):
> - A hardware interrupt (or timer interrupt) wakes up on thread.
> - When that thread wakes it wakes up other threads that are sleeping.
> - All the threads 'beaver away' for a few ms (processing RTP and other audio).
> - They all sleep for the rest of a 10ms period.
> 
> The affinities are set so each thread runs on a separate cpu, and all are SCHED_RR.
> Now loop all the cpus in userspace (run: while :; do :; done) and see what happens to the latencies.
> You really want the SCHED_RR threads to immediately pre-empt the running processes.
> But I suspect nothing happens until a timer interrupt to the target cpu.
> 

This is a good corner case where scheduler can be optimized further, and
the per-task attribute like the latency-nice can be of some help. Maybe we
can reduce the vslice of a task not having any latency constraints in the
time when any RR/RT tasks are present.

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

