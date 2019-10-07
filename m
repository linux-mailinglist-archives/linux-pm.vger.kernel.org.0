Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E9CEA16
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfJGRGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 13:06:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:51863 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfJGRGg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Oct 2019 13:06:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 10:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="205136707"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by orsmga002.jf.intel.com with ESMTP; 07 Oct 2019 10:06:34 -0700
To:     David Laight <David.Laight@ACULAB.COM>,
        'Parth Shah' <parth@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "qais.yousef@arm.com" <qais.yousef@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
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
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Subject: Re: [Discussion v2] Usecases for the per-task latency-nice attribute
Message-ID: <db23de7c-e9d9-33cc-50f5-08245744c4c4@linux.intel.com>
Date:   Mon, 7 Oct 2019 10:06:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9645e7c625a84bfabac001fd6ef35559@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/2/19 9:11 AM, David Laight wrote:
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
> are doing very few system calls so can't be pre-empted even by a high priority task.

This problem was conveyed to us by several customers.  The issue is not
that you are slow to preempt an AVX512 task on the same logical cpu thread, but the AVX512
tasks on the sibling CPU thread is dropping the CPU frequency and lowering the performance and
response.  Let's say that you make the latency sensitive task a real time task
with high priority so it will immediately run on a cpu after being woken.
But it will be slower if there's an AVX512 running on the sibling versus if other
kind of tasks are running on sibling.

This is the noisy neighbor effect. So it is better to isolate the latency
sensitive tasks on cores that AVX512 tasks don't run on.

Tim

> This 'feature' is hinted by this:
>> 2> TurboSched
>> ( -Parth Shah )
>> ====================
>> TurboSched [2] tries to minimize the number of active cores in a socket by
>> packing an un-important and low-utilization (named jitter) task on an
>> already active core and thus refrains from waking up of a new core if
>> possible.
> 
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
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

