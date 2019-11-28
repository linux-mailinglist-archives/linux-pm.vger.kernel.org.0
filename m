Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5010CFD1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 23:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfK1Wsh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 17:48:37 -0500
Received: from cmta20.telus.net ([209.171.16.93]:46547 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfK1Wsh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Nov 2019 17:48:37 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id aSaKiIsVnN5I9aSaLiqyaf; Thu, 28 Nov 2019 15:48:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1574981315; bh=CPFK3woqfG6ZOimrL1hyYBRtHBi0+2WkWsR2eHMBihE=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=obgBs6BWp7aVFKj+IDbPc4DbdD6QYY5DDjRyWx21zRHHYN1AolGuUV42JFQASN6p6
         87g2EkjmH/4gVEPYwBYqW2yceFZ2fNOzr1o0d4lOtvTcogeClfhOUVx4ZfHe/1X6SO
         kugz9rVgeI/CqX8+5nyY/HBTX1/GYDO92FHUgH95fm/8lN1CaFcoyBr25Uk1/HT6Dw
         rpsBqnsMC+lMtKHyLirTyFkEH1pgat/Wbvd+A9nOiOLv76TbQPK1G9JV1lbhY6ilCK
         qrsv8lYLgSK63HPh7tsA9hdOTg0TQZyTHi8hsNxYvC7zMWqUrqXVY7N0JUIHsmzN+V
         pQXdSzWYRS3pg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=siDWz7SyTkNVcnO4k2gA:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Mel Gorman'" <mgorman@techsingularity.net>,
        "'Matt Fleming'" <matt@codeblueprint.co.uk>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Juri Lelli'" <juri.lelli@redhat.com>,
        "'Paul Turner'" <pjt@google.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        "'Quentin Perret'" <qperret@qperret.net>,
        "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Borislav Petkov'" <bp@suse.de>, "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz>                 <20191113124654.18122-2-ggherdovich@suse.cz>                 <000001d5a29b$c944fd70$5bcef850$@net> <1574697961.16378.5.camel@suse.cz>         <000801d5a41e$a7fce2c0$f7f6a840$@net> <1574781600.7677.2.camel@suse.cz> <001d01d5a4f4$d96b21b0$8c416510$@net>
In-Reply-To: <001d01d5a4f4$d96b21b0$8c416510$@net>
Subject: RE: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Date:   Thu, 28 Nov 2019 14:48:27 -0800
Message-ID: <003d01d5a63d$f6ab3950$e401abf0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWkbC8LB/SpP9sCRCWbwO3FO+l3UwAhVS2wAEbrT1A=
X-CMAE-Envelope: MS4wfOtRsfbZnTQ5Z2TeTXge1GkRx76NgDeB6Idj4Im7L8yxQYgF202u0DBMVSNoWZSRA184sTQcvdhfQTMZRqjm83yLiNYr7mi+r5B71b7H5gKcDmwyhPKz
 YPpQGfo857MCu3WE+JalTWJ4pBObDzwNn/l12OWiQq9g3e7YROVQ9J9Q42vIJ0ETSG/z5Zp8i6FXpJUTcv287q4WIBzxoNm5KQWagwLCTT3Yb8acVnu5rXs4
 fKQ1xFAFzXsewHb0L0G+y7FxkxzQq50q8YvEnOLhAIB8hI8B0xJg+YEKmKoYIfsGV6Vi003OVWNYcJOQitKBpbUYvgtPEFpFofN1TanLtiWvvmgRCVas3S6x
 UTpOMF5GCtEcIY9lrf/Fee4UBQDaJ6KhGqWkRcQJW+MeKngOvGNbds2W2PehqUfeajE4lrUNzDHX9s1BRFHUJpFdp01XDw7Voujxx6jmz3iMwZe1zaL18nj1
 Wri7NoVppwX5iJCltMdaaR7ATanz7Bhve2vI6keDBkC1pthBVMm3Zp2ZyIdWeSDmuD22EYWA8mI0JFykWIBa8AfFbxs3gNhQ601CQDPgFOQ10DSB+/+rt8HY
 TwyjYpmGimfhRPkf2Wgeo1pUeNJ5qTT0eiLj0VBaDmp7NWDmxKMwhbyiI3LjmXWvFWN9/+N4B1wkyvtib4ayVW2FEJpDl/8tpUqsI02mBNBNJnKSnrc0EXlt
 EIeiSs8c8tnKcfqvXIA4LFGNlzdBJAN7268FmshEVm0EEhi/H9S7vQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Summary: There never was an issue here.

Sorry for the noise of this thread, and the resulting waste of time.

On 2019.11.26 23:33 Doug Smythies wrote:
> On 2019.11.26 07:20 Giovanni Gherdovich wrote:
>> On Mon, 2019-11-25 at 21:59 -0800, Doug Smythies wrote:
>>> [...]
>>> The issue with the schedutil governor not working properly in the 5.4 RC series
>>> appears to be hardware dependant.

No it 's not.

Issues with my Sandy Bridge, i7-2600K, test computer and kernel 5.4
seem to be because it is running an older Ubuntu server version,
apparently somewhat dependant on cgroup V1 and their cgmanager package.
I am unable to remove the package to test further because I do use VMs
that seem to depend on it.

In the kernel configuration when CONFIG_UCLAMP_TASK_GROUP=y
the computer behaves as though the new parameter "cpu.uclamp.min"
is set to max rather than 0, but I can not prove it.

>>> My test computer is Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz., Sandy Bridge.
>>> On a temporary basis, I acquired a computer with an
>>> Intel(R) Core(TM) i5-4460 CPU @ 3.20GHz, Haswell,
>>> and schedutil governor behaviour with the exact same kernels is fine:

I failed to mention that was brand new Ubuntu server 20.04 development version
installation, which turns out to have been an important omission.

>>> 
>>> That "gitsource" test, "make test" 6 times, first run thrown out:
>>> 
>>> Kernel 5.4 intel_cpufreq/schedutil: 3411.8 seconds
>>> Kernel 5.4 + gg 6 intel_cpufreq/schedutil: 1696.7 seconds
>>> Ratio: 0.49
>>> Recall you got a ratio of 0.49 with 5th generation, Broadwell.

I took the disk from the Haswell computer and put it in the Sandy Bridge
computer, and then everything was fine:

Kernel 5.4 intel_cpufreq/schedutil: 3636 seconds
Kernel 5.4 + gg 6 intel_cpufreq/schedutil: 2427.6 seconds
Ratio: 0.67 which is consistent with previous Sandy Bridge results

...

Those above kernels included:

CONFIG_UCLAMP_TASK_GROUP=y

Which cause my older Ubuntu server edition using the 
intel_cpufreq/schedutil to respond much like the performance
governor, as reported the other day and above.

I also booted the Sandy Bridge computer, with its original disk,
with the kernel command line containing:

cgroup_no_v1=all

and, while it complained during boot, it did work as expected
using the intel_cpufreq/schedutil driver/governor.

... Doug


