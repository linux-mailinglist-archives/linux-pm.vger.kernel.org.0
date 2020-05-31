Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0B51E98E6
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgEaQjR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 12:39:17 -0400
Received: from cmta17.telus.net ([209.171.16.90]:45563 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgEaQjQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 12:39:16 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id fQzNjZNf2mjwffQzPjwNmb; Sun, 31 May 2020 10:39:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1590943153; bh=mOjtN4QZqTJpXjKUD52ih7DUKc1k6BOTmEDBq1SoJbM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=B+AmNtW8kGqctMS3jv0yao82wAYrBwF9VXt3cRvvpUsNi8Ed8Z2jByOavIEMsj6wB
         OfCsa4hQnPd8M5KLb87VLY9FyOBp5fSmSYmSDO8LIX4aGfigktMpuhsTt9iZ6s8TB9
         4bHMMeMpLC4bveL6kMpvvuBTaRA3DPGh08r87hTe4Y/Ncj06z0iNzPr5WPKXV2LNkd
         5lZCpRUtSIbVbtcd8JRuDNUVyy0IP/k8MYLpvVR5qfYdLHqMBZIpv/AuppUPBk7U8d
         jTT9EqLyJoLbJiUTPfbTjBsP/vxoYVRP6WglbIoBRKRb2GIZjr9VAsuQxfbusu8dQ7
         7CvPhW2z1EFdA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ea5DgIMH c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=p-nOP-kxAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=hxffAu8r3hVsHahDOMEA:9 a=CjuIK1q_8ugA:10
 a=XN2wCei03jY4uMu7D0Wg:22 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2931539.RsFqoHxarq@kreacher>
In-Reply-To: <2931539.RsFqoHxarq@kreacher>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode with HWP enabled
Date:   Sun, 31 May 2020 09:39:08 -0700
Message-ID: <000001d6376a$03bbaae0$0b3300a0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYzimEBSb+8wZd2QXK6gu6IWqSeRQBbEZjA
X-CMAE-Envelope: MS4wfCfrh1gkTLLruzDPLHfTdicqLPMAo9DFEe4XgPWE11jwRj4YXduReh9BxikijCLAcdG3O2PtHisO529tZ2Rc8pQWGxXiwVsQA9kWE+0eaSfPZ8C/C+po
 ojzGGTl/fFz2rv7HM4WnxxlIe/wpWyu3iEMgqn2SW+fgEdhGXhX0+3RrXaxbSjewV1R12El1/+43P74E+Pl40ndZ6H6hMhzAZhAV7a+LXFVaiEI2etaa0CeV
 vzxm2vKpzskURl0Eb81cUhS1yeaQcaMpBiV/x3P9w4XYbwDwC3WI2kWnKSAyiacn8lPfQDDwA3iQDScRWxl53RhKzT8DXPysp9E3+Dlsh7Zd+3v65h28ssfB
 cD6Dbw+/tyMJFvd+ZnuIIdiOqVb0sgT5Cu39h5q+o4XifIzsam8DDGkJG1DoScJhdAUSSILd
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The content of this e-mail is also at [1],
with annotated graphs.

Hi Rafael,

Hmmm... I think the most important takeaway from
my previous e-mail might have been missed!

HWP does not work properly on my i5-9600K test computer.

For those that don't have to read all this, my upgraded
assertion is:

With HWP enabled, if idle state 2 is used, there is a probability
that the CPU frequency might unexpectedly drop significantly.

Detail (see [1] for supporting graphs and links):

I can not proceed with testing this.
Why not?
Because I do not have a stable good system on top of which to add this patch.
I do not know what is wrong such that HWP appears broken.

For my part of it, I had to stop and dig into
why HWP doesn't seem to work properly on my newer test computer.

Notes:
I have never used HWP before, and have had it disabled so far on this
newer test computer. This patch seemed like a great opportunity to try it.
Why (in addition to helping via review/test)? Because trace now works,
whereas it doesn't in active mode with HWP.

It is on my list to explore viability of a mode for trace where it monitors
what the processor is doing via HWP, rather than reporting what the
processor is being told to do. However, in the meantime, this is great.

Example of what is wrong on my system (repeated, but new example trace data,
from earlier e-mail):

Kernel: 5.7-rc6 and + this version of patch when trace data required.
Patch config: DELAY_HWP 10000 ; 87.5% fraction (7/8).
Keep in mind that the trace entry is the scaled min value, not the target p-state.

Load:
Single thread, forced CPU affinity.
fixed work packet per work period, i.e. the amount of work to do is independent of CPU frequency.
347 hertz work / sleep frequency.
To reveal any hysteresis (i.e. with conservative governor) load ramps up from none
to 100% and then back down to none at 3 seconds per step (step size is uncalibrated).

Processor:
Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz

What do I see?

Unexpected frequency drops at around 70% load.
Example, from trace:

Event begins at 17.456 seconds elapsed time.
Previous event was about 107 milliseconds ago.

Old min ; new min ; freq GHz; load % ; duration mS
27      ; 28      ; 4.60    ; 68.17  ; 10.226
28      ; 26      ; 4.53    ; 57.47  ; 10.005
26      ; 40      ; 2.87    ; 100.00 ; 10.996  <<<< What? Why freq down? (note: it is always above old min)
40      ; 29      ; 4.25    ; 69.67  ; 10.002  <<<< O.K. recovering, but damage done.
29      ; 26      ; 4.60    ; 59.14  ; 10.652  <<<< Event ends. Next event in 128 milliseconds.

I can not think of any reason why the frequency would have been reduced so far by HWP.

O.K., the above had to be done with the patch so that trace could be used.
Ondemand was the governor, because its response curve looks the same as
active/powersave in the area of concern.

The below was done with kernel 5.7-rc6 and only turbostat, at a low sample rate of 15 seconds per,
in addition to the test load. 100 seconds each:

intel_pstate/powersave hwp:

Overruns: 11327
Ave. work percent: 77.952091
Processor package power: ~13 watts.
Average CPU frequency: 3.8 gigahertz 

intel_pstate/powersave no-hwp:

Overruns: 7 (task start ramp up related. I have trace proof.)
Ave. work percent: 74.932603
Processor package power: ~11.5 watts.
Average CPU frequency: 4.0 gigahertz

Question: What is the relevance of the 347 hertz and
the >=70% load for this issue? Why does it appear
to be such a sharp works/fine doesn't work issue?

Answer: The issue seems to be related to when the
sleep portion of a work/sleep periodic workflow
approaches and goes below 1 millisecond (1 jiffy).

some tests were done, varying the work/sleep frequency,
and idle states and overruns and such, the web version
of this e-mail has graphs.

Notes:

The breakpoint between no-overruns/overruns is around 950 microseconds.

A 250 hertz kernel was tested, and it did not have this issue in this area.
Perhaps elsewhere, I didn't look.

1000 hertz kernels were tested back to kernel 5.2, all failed.

If the issue is jiffy related (a race condition?) then a work/sleep frequency
of 333.3333 hertz should behave in binary way, either lots of overruns or none
as a function of the task start time. (Preliminary) It does.

If the issue is jiffy related (a race condition?) then a work/sleep frequency
of 500.00 hertz should behave in binary way, either lots of overruns or none
as a function of the task start time. It does. There are occurrences when idle
state 2 is used somewhat without overruns.

Both teo and menu idle governors were tested, and while both suffer from
unexpected CPU frequency drop, teo seems much worse. However failure points
for both governors are repeatable.

There was new BIOS for this test computer a week ago.
System now upgraded and tested with default BIOS settings (by accident)
and my settings. (Note: slight changes in processor package power for
system idle and one CPU loaded with new BIOS, and earlier tests NOT re-done).

Is the processor using the latest microcode? Currently 0xcc. Can not figure out if there is anything newer.

Leaving out the details, but all the tests and results are available, a mess but available, the summary is:

With HWP enabled, if idle state 2 is used, there is a probability that the CPU frequency might unexpectedly drop significantly.
If the processor does this by itself, or by being told to via sources outside of the intel_pstate CPU frequency driver, I don't
know.

The load sweep test was run at 6 seconds per step during increasing load and 3 seconds per step decreasing
(by mistake, if you must know), while monitoring the idle statistics.
The test was done in a hurry, so many above/below statistics are 0%, due to insufficient sample size.
The overruns and use of idle state 0 are exactly correlated.
There are a lot of graphs on the idle statistics web page, but the idle state 2 usage correlates exactly with
undesired low CPU frequency and overruns.

Side note: Even in the areas where HWP appears to behave, the no-hwp power use is much better.

O.K., so now, do a couple of more turbostat samples:

intel_pstate/powersave hwp idle state 2 disabled:

Overruns: 3
Ave. work percent: 66.647895
Processor package power: ~16.8 watts.
Average CPU frequency: 4.6 gigahertz

intel_pstate/powersave hwp idle state 3 disabled:

Overruns: 22
Ave. work percent: 66.647895
Processor package power: ~16.2 watts.
Average CPU frequency: 4.6 gigahertz

To prevent all the bots that burden my site, the link is coded:
[1] double u double u double u dot smythies dot com /~doug/linux/s18/hwp/index.html 

... Doug

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: May 26, 2020 11:21 AM
> To: Linux PM; Doug Smythies
> Cc: LKML; Len Brown; Srinivas Pandruvada; Peter Zijlstra; Giovanni Gherdovich; Francisco Jerez
> Subject: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode with HWP enabled
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Allow intel_pstate to work in the passive mode with HWP enabled and
> make it set the HWP minimum performance limit to 75% of the P-state
> value corresponding to the target frequency supplied by the cpufreq
> governor, so as to prevent the HWP algorithm and the CPU scheduler
> from working against each other at least when the schedutil governor
> is in use.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a replacement for https://patchwork.kernel.org/patch/11563615/ that
> uses the HWP floor (minimum performance limit) as the feedback to the HWP
> algorithm (instead of the EPP).
> 
> The INTEL_CPUFREQ_TRANSITION_DELAY_HWP is still 5000 and the previous comments
> still apply to it.
> 
> In addition to that, the 75% fraction used in intel_cpufreq_adjust_hwp() can be
> adjusted too, but I would like to use a value with a power-of-2 denominator for
> that (so the next candidate would be 7/8).
> 
> Everyone who can do that is kindly requested to test this and let me know
> the outcome.


