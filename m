Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1BEA040
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfJ3Pyp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:54:45 -0400
Received: from cmta20.telus.net ([209.171.16.93]:37592 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbfJ3Pyo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Oct 2019 11:54:44 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id PqIvi7EwiN5I9PqIxinjBg; Wed, 30 Oct 2019 09:54:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1572450882; bh=va9ZeCOWgJyIDlEFl6M6pjvQjVeC+2/miiQxAuzQXuw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=mui5mngII4Cr08aLE2TSnBe18qLGzj3Fnl/1mXH8xr9mxl2aeaNJCe/YJNrWZ0iRi
         9WKxVSZ3TV/nlfKTECXjQfiFmgo5HPtIrJPc9KE2od8lk4XjuTlYhKtxQKQ5NrlH9U
         dpfcqu7AdjSuhKTueaUNHI78y9FZ2aVSjOKLAG5Epr/3biHkt1L98EPBLyX5EtHg9z
         TOP58PpoAX/TOX4+fYZCZS+8GCcoOiHJhbqpsXPOjoDZ6aMVy/NbWRThXg5N1gKaZ7
         QcbTfz7UjBNBOdiN5s+kI2yjTPIW5QTZFbpXnakvUVxlwU8KcpGIyZQ6vU4MwhekpJ
         jVLyq/R/myTkg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=eBx6XaJ-_6BMZ4NUrjMA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        <vincent.guittot@linaro.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Ingo Molnar'" <mingo@kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>, <sargun@sargun.me>,
        <tj@kernel.org>, <xiexiuqi@huawei.com>, <xiezhipeng1@huawei.com>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>       <10eef14e434375ef4bb7cf23ecb987b3591064a6.camel@linux.intel.com> <f13946cfc3f6f57230df7d0c2aad860940826148.camel@linux.intel.com>
In-Reply-To: <f13946cfc3f6f57230df7d0c2aad860940826148.camel@linux.intel.com>
Subject: RE: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load balancing path"
Date:   Wed, 30 Oct 2019 08:54:35 -0700
Message-ID: <000101d58f3a$56ab4e00$0401ea00$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWOk25ZLh1n5QSOSl6606YjpTTIPAAHXaFw
X-CMAE-Envelope: MS4wfAK0Ix1CXAhs4CHrotliPBpoRLO6Z9SD182WqfbxwzU3/Cy65szMFlj3C3QQ9vXIP6/O0EGZ8N4PHtb+f5GZOjJZAhvFA6I6Jyts4Y3myZCuNJ3VxEGJ
 5LQ35PKieM/L40Dvp8IoxAa4KpmhZ/ZH19GcMUD94LnzX1ACqNmT4Ntfk70BmjmWE19db53VCwkyWfjLTTvaSpHy/tKDVJnPRWIMzYLG205WUmQYERLXITrr
 9F5BVkTyaTikxmoWOkxECGXWRZj+OuW/xCWSW7Lw2HDeYFO1mwtBCfN94BT5StgJYMIgW6lBHIDNXtXDTylRl+ckgAiK3BvnrdGldSZiJaXNcMZZitdkOYF8
 KL3GRq/4GWtsJFOIofF5I7Vm9I2skbtHNd9+iyqDuYfwa9K+qcesMT4qP+t0BxuItrC4TIv3GjUint2eJDI0bMnptSODNwgbCvsfDNXnmGgoB1tIRnkYgv/o
 Km4Jjcf4/xh7knpn59SsSjEzcsKNiN/nz/Mg5ZInG2GTHv4nYH/2a7KUVsAMF4ABb8JUcQv/1S+LJmjf
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.29 13:00 Srinivas Pandruvada wrote:
> On Tue, 2019-10-29 at 12:34 -0700, Srinivas Pandruvada wrote:
>> On Fri, 2019-10-25 at 08:55 -0700, Doug Smythies wrote:
>> 
>> [...]
>> 
>>> Experiment method:
>>> 
>>> enable only idle state 1
>> Dountil stopped
>>>   apply a 100% load (all CPUs)
>>>   after awhile (about 50 seconds) remove the load.
>>>   allow a short transient delay (1 second).
>>>   measure the processor package joules used over the next 149
>>> seconds.
>>> Enduntil
>>> 
>>> Kernel k5.4-rc2 + reversion (this method)
>>> Average processor package power: 9.148 watts (128 samples, > 7
>>> hours)
>>> Minimum: 9.02 watts
>>> Maximum: 9.29 watts
>>> Note: outlyer data point group removed, as it was assumed the
>>> computer
>>> had something to do and wasn't actually "idle".
>>> 
>>> Kernel 5.4-rc2:
>>> Average processor package power: 9.969 watts (150 samples, > 8
>>> hours)
>>> Or 9% more energy for the idle phases of the work load.
>>> Minimum: 9.15 watts
>>> Maximum: 13.79 watts (51% more power)

>>  Hi Doug,

Hi Srinivas,

>> 
>> Do you have intel_pstate_tracer output?

Yes, I have many many runs of intel_pstate_tracer.py
and many plots of pstate and CPU frequency lingering high
for a very very long time after the load is removed.
Here is one example (my reference: results/teo041):

The load is removed at test time 539.047 seconds,
and requested pstates do start to fall. Example,
cpu 4 at time 539.052, pstate request goes from
38 (the max for an i7-2600K) to 32. The last CPU
to reduce the pstate request is CPU 0 at time
539.714, but only to 25.

Then, CPU 4 doesn't run the driver for another
5.9 seconds, and even then only reduces its request
to pstate 21.

CPU 4 remains the defining CPU, and doesn't run the
driver again until time 577.235 seconds, at which time
its pstate request drops to 18, even with 0 load.
So, 38 seconds, and still only at pstate 18.

>> I guess that when started
>> request to measure the measure joules, it started at higher P-state
>> without revert.

No, not really. The main difference is in the time it takes to fully
drop to the lowest pstate.

>> Other way is check by fixing the max and min scaling frequency to
>> some frequency, then we shouldn't see power difference.

Yes, I did that, to learn the numbers.

> I mean not significant power difference.

For idle state 1, at least for my processor (i7-2600K), the difference
is huge. Keep in mind that (at least for my processor) a CPU in idle
state 1 does not relinquish its vote into the CPU frequency PLL, thus
the highest request dictates the CPU frequency.

Here are the idle state 1 powers (42 percent is the minimum for my
processor. For reference, with all idle state enabled, the idle
power is 3.68 watts and the processor package temperature is about
25 degrees, independent of the requested pstate):

Min-percent watts	temp
42		8.7	35
50		10.0	36
60		12.0	37
70		14.4	38
80		17.3	41
90		21	43
100		21	43

Note that the 90 (pstate 35) and 100 (pstate 38)
powers are the same due to this (I assume):

cpu5: MSR_TURBO_RATIO_LIMIT: 0x23242526
35 * 100.0 = 3500.0 MHz max turbo 4 active cores
36 * 100.0 = 3600.0 MHz max turbo 3 active cores
37 * 100.0 = 3700.0 MHz max turbo 2 active cores
38 * 100.0 = 3800.0 MHz max turbo 1 active cores

And can be verified by looking at the request
And granted MSRs directly:

At 100% min percent:

Requested:
doug@s15:~/temp-k-git/linux$ sudo rdmsr --bitfield 15:8 -d -a 0x199
38
38
38
38
38
38
38
38

Granted:
doug@s15:~/temp-k-git/linux$ sudo rdmsr --bitfield 15:8 -d -a 0x198
35
35
35
35
35
35
35
35

> Also to get real numbers, need
> to use some power meter measuring CPU power.

Well, I have one, but for the box AC only. It just didn't seem
worth the overhead. Yes, I used the joules MSR directly. I also
do a sanity check by checking that the processor package temperature
makes sense for the calculated processor package watts. I added a
temperature column above.

> If I can get your script,
> I may be able to measure that.

Hmmm... This was actually a saga all by itself, mainly my own
fault. I am running a bit of a mess here so that I could minimize 
the time between the multiple load drops from 100% to 0% so as
to make it easier to follow via the intel_pstate_tracer data.
Load methods aside, the rest is pretty simple:

doug@s15:~/idle$ cat load-no-load-forever2
#!/bin/dash

#
# load-no-load-forever2. Smyhies 2019.10.21
#       Just trying to get some debug data.
#       apply load (real, not via disabling all idle
#       states) then no load. loop forever.
#       load version 2.

echo "load-no-load-forever2. Start. Doug Smythies 2019.10.21"

while [ 1 ];
do
  ~/c/waiter 9 2 4 2000000000 0 1 > /dev/null
  sleep 1
  sudo ~/c/measure_energy 149
done

Where "measure_energy.c" just samples the
joules MSR over an interval, sometimes a longer
interval than turbostat will allow (with full
accuracy), because I know that the joules counter
did not wrap around.
In a separate e-mail I'll send you the c programs,
although I seem to recall that Intel strips out
attached c programs from e-mails.

Hope this helps.

... Doug


