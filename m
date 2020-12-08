Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488A52D3422
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 21:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgLHUaS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 15:30:18 -0500
Received: from cmta17.telus.net ([209.171.16.90]:50436 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbgLHUaS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 15:30:18 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id miRZk7Fszm62rmiRakESsv; Tue, 08 Dec 2020 12:14:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1607454880; bh=cjeXmSSc2tCRBmt6xapT5IwcYBqI1AcxtK+LuUehyIA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=5ZI3NdnPf1Rik4TxgG+mX/qkq1P/Z8eZoPemnHDeRjyKA/qxgNBUogcitopo05YgM
         gYVet+DPnE2o5StkufEN28JXhqV1NYplwCjAM2KRQfPtBpQeBqZFr1tOnY4xnwEhDU
         HYSM5DnM7Yn5F4R+IOyxqNqI2jila1n48YbEuQZX5rSUuc29/N758LrqlfluxK8HXa
         nAddANFqjNFNl4UPIRSyhqmJufs6s1tvOfrl5Y16blCSjeZ4iiOwk1lXMEpUA4GfPT
         CGlTXtUZ0Ox8Q2CLHEFNMcirtgBNjp0K5cWlxIvn0sF4daAJYlYC0l/y3Ozc0bFPJ8
         Wk7Gx+3TJ91EQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=D4iCltdj c=1 sm=1 tr=0 ts=5fcfd0a0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8
 a=VwQbUJbxAAAA:8 a=gu6fZOg2AAAA:8 a=4Jbuw8ktRrBCy4-7u88A:9 a=QEXdDO2ut3YA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=AjGcO6oz07-iQ99wixmX:22 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.com>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>
References: <20360841.iInq7taT2Z@kreacher> <1607445035.2673.64.camel@suse.com> <CAJZ5v0j2u7MrO82+ubx01kvyhDUKo11mfyofF-TAqdSLx_i3Ng@mail.gmail.com>
In-Reply-To: <CAJZ5v0j2u7MrO82+ubx01kvyhDUKo11mfyofF-TAqdSLx_i3Ng@mail.gmail.com>
Subject: RE: [PATCH v1 0/4] cpufreq: Allow drivers to receive more information from the governor
Date:   Tue, 8 Dec 2020 11:14:36 -0800
Message-ID: <001d01d6cd96$601c8a80$20559f80$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdbNhYnI6l7ez4eQRjiDzyQ3pYiW9QABrdRQ
X-CMAE-Envelope: MS4xfNLEs3/CV44UYR9bsW93NdqFMR+RW4quJlygVKVFVpB5RDrMwtMRZYFzkYB3ZHLBn1hacK2BsqpbgPEIG1PMiHSucXp7eOQ5jtb0FC6lj0ADxBMFRQ/2
 4cktii8b1D761lCAdEwBYg+u/FaQadeq+lkzeIBvzQ6jDTlOB/q/JT+ytcRjToCCvHz+d6vUdduf+k3+/RxhEA10ZKxbbOi9t1EN1IV8K4zV7p+9QrLWvH0/
 vnNOpwGQXKsEt/43yMJPc+pnO9d/RHredhLq0yYXk7tmaMEjE8Rpb5s7SZGxddqF3U5B3Zgeq0H9GLYNmkbFQkYPMznDQA+EO6ofHOGnFRNhHDiiqBUU4j5/
 R6/nK2lL5UTWz8RFuuQrH6LE7QmgaijYbttsrEo2WsZL/zfd10pp3Z/UJjssVcjY8tN+rcclBwnW4xeehYVQa4Htd5PjvA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.12.08 09:14 Rafael J. Wysocki wrote: 
> On Tue, Dec 8, 2020 at 5:31 PM Giovanni Gherdovich <ggherdovich@suse.com> wrote:
>> On Mon, 2020-12-07 at 17:25 +0100, Rafael J. Wysocki wrote:
>>> Hi,
>>>
>>> This is based on the RFC posted a few days ago:
>>>
>>> https://lore.kernel.org/linux-pm/1817571.2o5Kk4Ohv2@kreacher/
>>>
>>> The majority of the original cover letter still applies, so let me quote it
>>> here:
>>> [...]
>>
>> Hello Rafael,
>>
>> I'd like to test this patch, as I have concerns on how it performs against the
>> current intel_pstate passive + HWP + schedutil (which leaves HWP.REQ.DESIRED
>> untouched).
> 
>The performance will be worse in some cases, which is to be expected,

Agreed. More further below.

>but the point here is to counter the problem that in some cases the
>frequency is excessive now.

Agreed.

I retested with this new version with my load sweep test,
and my results were the pretty similar to previously reported, [1].
If anything, there might be a perceptible difference between the RFC
version and this version as a function of work/sleep frequency.

73 Hertz: RFC was 0.8% less power
113 Hertz: RFC was 1.5% less power
211 Hertz: RFC was 0.8% less power
347 Hertz: RFC was 1.2% more power
401 Hertz: RFC was 1.6% more power

Of course, let us not lose site of the original gains that were in the 13 to 17% range.

Now, for the "worse in some cases, which is to be expected" part:

At least on my system, it is most evident for some of the pipe type tests,
where the schedutil governor has never really known what to do. This patch
set seems to add enough of a downward bias that this version of the schedutil
governor now behaves much like the other versions

Here is an example (no forced CPU affinity, 2 pipes):

Legend:
hwp: Kernel 5.10-rc6, HWP enabled; intel_cpufreq; schedutil (always)
rjw: Kernel 5.10-rc6 + this patch set, HWP enabled; intel_cpu-freq; schedutil
no-hwp: Kernel 5.10-rc6, HWP disabled; intel_cpu-freq; schedutil
acpi-cpufreq (or just acpi): Kernel 5.10-rc6, HWP disabled; acpi-cpufreq; schedutil
patch: Kernel 5.10-rc7 + the non RFC 4 patch version of this is patch set, HWP enabled; intel_cpu-freq; schedutil

hwp: 3.295 uSec/loop (steady); average power: 62.78 Watts (steady); freq: 4.60GHz (steady).
rjw: 3.6 uSec/loop (noisey) (9.3% worse); average power: 44.13 Watts (noisey); freq: ?.??GHz (noisey).
no-hwp: 3.35 uSec/loop (noisey); average power: 59.17 Watts (noisey); freq: ?.??GHz (much less noisey).
acpi-cpufreq: 3.4 uSec/loop (noisey); average power: 56.93 Watts (noisey); freq: ?.??GHz (less noisey).
patch: 3.6 uSec/loop (noisey) (9.3% worse); average power: 43.36 Watts (noisey); freq: ?.??GHz (noisey).

One could argue that this patch set might be driving the frequency down a little too hard in this case,
but this is one of those difficult rotating through the CPUs cases anyhow.
As a side note, all other governors (well, not powersave) pin the CPU frequency at max (4.6 GHz).

For my version of the "Alex" pipe test (a token is passed around and around via 6 named pipes,
with a bit of work to do per token stop)
I get (more power = better performance):

hwp: average power: 17.16 Watts (very noisey)
rjw: average power: 3.18 (noisey)
no-hwp: average power: 2.45 (less noisey)
acpi-cpufreq: average power: 2.46 (less noisey)
patch: average power: 2.47 (less noisey)

The "hwp" case is misleading. It is really bouncing around at about 0.2 hertz
and can't seem to make up its mind. If nothing else, all the other versions
are a little more deterministic in their response.

> 
>> I'll get results within a week. Do you mind holding back the merge until then?

On my system that git "make test" is broken, so I can not do the high PIDs per second test that way.
My own PIDs per second test also has issues on this computer.
I am not sure when I'll get these type of tests working, but will try for within a week.

... Doug

References:

[1] https://marc.info/?l=linux-kernel&m=160692480907696&w=2

My tests results graphs (updated):
Note: I have to code the web site, or I get hammered by bots.
Note: it is .com only because it was less expensive than .org

73 Hertz (10 samples per second):
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su73/ 
113 Hertz (10 samples per second):
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su113/
211 Hertz (10 samples per second):
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su211/
347 Hertz (10 samples per second):
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su347/
401 Hertz (10 samples per second):
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/su401/

Note: The below graphs are mislabelled, because I made hacker use of a tool dedicated
to graphing, and HTML wrapping, the load sweep test. The test conditions are steady state
operation, no variable changes.

pipe-test (5 seconds per sample):
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/pipe/
Alex test (5 seconds per sample):
Double u double u double u dot smythies dot .com/~doug/linux/s18/hwp/k510-rc6/alex/


