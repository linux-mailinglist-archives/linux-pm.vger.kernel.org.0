Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8F1F074B
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgFFPVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jun 2020 11:21:18 -0400
Received: from cmta16.telus.net ([209.171.16.89]:42225 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgFFPVM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 6 Jun 2020 11:21:12 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id had5jYF0p2DNIhad7jqGR3; Sat, 06 Jun 2020 09:21:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1591456869; bh=uOxn5FNAbjgCIjHRF/u6CYwICtWoh+9aGnyj2hCy6cg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=OnrHi8/dJr2Il/xdNnPgV2NEwHQiewPLYG7UuKi+SuX4Zj0E1VZCQcyWurFVdcZid
         GkbUiWfejW0lPjjcUCIXIwTO/RAJOoXpIrZ3IUosJNpVP1mHE19oHyL3+KOvJThZ0w
         6XQ0ZG4k7jZFkUS2wJTUC2IL1piLyCA7lna4cOenGWf+McB3WiA8XglC2hmpqEbJkz
         ds1i5V6z0GnHEfhKVf4l/mLDiq1zYIvAQ4UKGYwD+Sd4KvS2FqyndPymYxLgdULaVs
         BbfQNzTlkVrSCvN8+/wDeOLSQJ+QdiudLATRtNp2Z/+mUIBUjrZGuNCRNz5D2eEBrP
         W9G8Dg1gzpSrA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=H+qlPNQi c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=p-nOP-kxAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Rq_R0krhRepCojYYGuIA:9 a=CjuIK1q_8ugA:10
 a=XN2wCei03jY4uMu7D0Wg:22 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2931539.RsFqoHxarq@kreacher> <000001d6376a$03bbaae0$0b3300a0$@net>
In-Reply-To: <000001d6376a$03bbaae0$0b3300a0$@net>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode with HWP enabled
Date:   Sat, 6 Jun 2020 08:21:03 -0700
Message-ID: <000001d63c16$1a972b30$4fc58190$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdYzimEBSb+8wZd2QXK6gu6IWqSeRQBbEZjAAcSKPdA=
Content-Language: en-ca
X-CMAE-Envelope: MS4wfBtxeAR0RLMY6azxvE5hSY4lybZhOGVvERAE2KGLwLoa7o6ZXIt1zgn5aE5aJqrpPzwvLw2hbXBalAO5Im04Rs1DThCivuqna1EB//zfTxJVGz5+IO+h
 mSdHM2XPxbEbQ6D9BbGIpW8ADYIUvzbqSbJOSJEY4YNPHWwKj2Sgq/QSFlWuoSOBzAKZD+3/axZ6uxaqATRimqvJuc2HNi1xGcxtNIdxbHh6GpNYCxBv4QUE
 NmzKZ6FRDVi+V3y07QeuTQRp/R1P9jBQH2IwK/7MfhFYikDhT/SxYCShdGdKy/qJmRyBGm2doa99Oj6xOSsz4/IJmInesyWso9ASANg7EEmoB1CrHoyv3KeG
 Av0C0QNtssD6IfHbabEK99RHzaWmS8Fm30upNdtVFh1QCEzceDXFPc1jgwPZdcHCdR8eAlCN
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Note 1: I have gone back a few e-mails in the thread for this reply.
Note 2: Srinivas and I have exchanged several e-mails off-list. Thanks.

On 2020.05.31 09:39 Doug wrote:

> 
> The content of this e-mail is also at [1],
> with annotated graphs.

That reference is now a few days out of date.

> 
> Hi Rafael,
> 
> Hmmm... I think the most important takeaway from
> my previous e-mail might have been missed!
> 
> HWP does not work properly on my i5-9600K test computer.
> 
> For those that don't have to read all this, my upgraded
> assertion is:
> 
> With HWP enabled, if idle state 2 is used, there is a probability
> that the CPU frequency might unexpectedly drop significantly.
> 

After another week of investigation, my refined assertion is:

For any workload from periodic to 100% busy but with infrequent small gaps,
there is a significant probability that the processor will lock
at minimum CPU frequency for a period of up to 30 milliseconds.

Gap definition:
lower limit not known, but < 747 uSeconds.
Upper limit is between 952 and 955 uSeconds (there will be some overhead uncertainties).
Must be preceded by busy time spanning a couple of HWP sampling boundaries
or jiffy boundaries or something (I don't actually know how HWP does stuff).

My long e-mail from last week was entirely based on periodic work in the 347 hertz area.
This e-mail is about the same fundamental issue, but a completely different approach.

Workflow: long busy, short gap, busy but taking loop time samples so as to estimate CPU frequency.
I am calling it an inverse impulse response test.

Results:

If 747 uSec < gap < 950 uSeconds then there is approximately a 17% probability
that upon exit from the gap back to busy the CPU will be held at 800 Mhz (or whatever minimum)
for about 30 milliseconds before ramping up. The expectation is that the CPU frequency
ramp up time would even be detectable by my test program, and that is the case for
the other 83% of test runs.

Sanity check (842 uSec gap time):

O.K. so I should be able to observe this with the workflow running in
a loop if I run turbostat at the same time. If I use a 3 second sample time,
sometimes a frequency drop from 4600 MHz to 4573 is shown. If there is an
event during a turbostat sample, there can be only one. So let's reverse
calculate the frequency from the data:

ave mhz = (time at 4600 + time at 0 + time at 800 Mhz)/3
let the time at 800 MHz be Y.

4573 = (4600 * ((3 Sec - gap) - Y) + 800 * Y)/3
4573 = (13796.1268 - 3800 Y)/3
13719 = 13796.1268 -  3800 Y
Y = 20.3 milliseconds.

Note: the transition time from 800 MHz to 4600 MHz
Is not really 0, so the real Y should be longer.

Real data:

Test runs: 511
Bad runs: 86 (17%)
Average time at suppressed CPU frequency: ~ 29.8 milliseconds.

Overall I have run this test about 6,500 times.
So far, nohwp, passive, schedutil has failed the test 0 times
out of 361 runs.

Note: under these condition this computer should never
throttle back from 4600 MHz, because (from turbostat):

cpu2: MSR_TURBO_RATIO_LIMIT: 0x2b2b2e2e2e2e2e2e
43 * 100.0 = 4300.0 MHz max turbo 8 active cores << I don't have 8 cores
43 * 100.0 = 4300.0 MHz max turbo 7 active cores << I don't have 7 cores
46 * 100.0 = 4600.0 MHz max turbo 6 active cores << I do have 6
46 * 100.0 = 4600.0 MHz max turbo 5 active cores
46 * 100.0 = 4600.0 MHz max turbo 4 active cores
46 * 100.0 = 4600.0 MHz max turbo 3 active cores
46 * 100.0 = 4600.0 MHz max turbo 2 active cores
46 * 100.0 = 4600.0 MHz max turbo 1 active cores

> Detail (see [1] for supporting graphs and links):
> 
> I can not proceed with testing this.
> Why not?
> Because I do not have a stable good system on top of which to add this patch.
> I do not know what is wrong such that HWP appears broken.
> 
> For my part of it, I had to stop and dig into
> why HWP doesn't seem to work properly on my newer test computer.
> 
> Notes:
> I have never used HWP before, and have had it disabled so far on this
> newer test computer. This patch seemed like a great opportunity to try it.
> Why (in addition to helping via review/test)? Because trace now works,
> whereas it doesn't in active mode with HWP.
> 
> It is on my list to explore viability of a mode for trace where it monitors
> what the processor is doing via HWP, rather than reporting what the
> processor is being told to do. However, in the meantime, this is great.
> 
> Example of what is wrong on my system (repeated, but new example trace data,
> from earlier e-mail):
> 
> Kernel: 5.7-rc6 and + this version of patch when trace data required.
> Patch config: DELAY_HWP 10000 ; 87.5% fraction (7/8).
> Keep in mind that the trace entry is the scaled min value, not the target p-state.
> 
> Load:
> Single thread, forced CPU affinity.
> fixed work packet per work period, i.e. the amount of work to do is independent of CPU frequency.
> 347 hertz work / sleep frequency.
> To reveal any hysteresis (i.e. with conservative governor) load ramps up from none
> to 100% and then back down to none at 3 seconds per step (step size is uncalibrated).
> 
> Processor:
> Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
> 
> What do I see?
> 
> Unexpected frequency drops at around 70% load.
> Example, from trace:
> 
> Event begins at 17.456 seconds elapsed time.
> Previous event was about 107 milliseconds ago.
> 
> Old min ; new min ; freq GHz; load % ; duration mS
> 27      ; 28      ; 4.60    ; 68.17  ; 10.226
> 28      ; 26      ; 4.53    ; 57.47  ; 10.005
> 26      ; 40      ; 2.87    ; 100.00 ; 10.996  <<<< What? Why freq down? (note: it is always above old
> min)
> 40      ; 29      ; 4.25    ; 69.67  ; 10.002  <<<< O.K. recovering, but damage done.
> 29      ; 26      ; 4.60    ; 59.14  ; 10.652  <<<< Event ends. Next event in 128 milliseconds.
> 
> I can not think of any reason why the frequency would have been reduced so far by HWP.
> 
> O.K., the above had to be done with the patch so that trace could be used.
> Ondemand was the governor, because its response curve looks the same as
> active/powersave in the area of concern.
> 
> The below was done with kernel 5.7-rc6 and only turbostat, at a low sample rate of 15 seconds per,
> in addition to the test load. 100 seconds each:
> 
> intel_pstate/powersave hwp:
> 
> Overruns: 11327
> Ave. work percent: 77.952091
> Processor package power: ~13 watts.
> Average CPU frequency: 3.8 gigahertz
> 
> intel_pstate/powersave no-hwp:
> 
> Overruns: 7 (task start ramp up related. I have trace proof.)
> Ave. work percent: 74.932603
> Processor package power: ~11.5 watts.
> Average CPU frequency: 4.0 gigahertz
> 
> Question: What is the relevance of the 347 hertz and
> the >=70% load for this issue? Why does it appear
> to be such a sharp works/fine doesn't work issue?
> 
> Answer: The issue seems to be related to when the
> sleep portion of a work/sleep periodic workflow
> approaches and goes below 1 millisecond (1 jiffy).
> 
> some tests were done, varying the work/sleep frequency,
> and idle states and overruns and such, the web version
> of this e-mail has graphs.
> 
> Notes:
> 
> The breakpoint between no-overruns/overruns is around 950 microseconds.
> 
> A 250 hertz kernel was tested, and it did not have this issue in this area.
> Perhaps elsewhere, I didn't look.
> 
> 1000 hertz kernels were tested back to kernel 5.2, all failed.
> 
> If the issue is jiffy related (a race condition?) then a work/sleep frequency
> of 333.3333 hertz should behave in binary way, either lots of overruns or none
> as a function of the task start time. (Preliminary) It does.
> 
> If the issue is jiffy related (a race condition?) then a work/sleep frequency
> of 500.00 hertz should behave in binary way, either lots of overruns or none
> as a function of the task start time. It does. There are occurrences when idle
> state 2 is used somewhat without overruns.
> 
> Both teo and menu idle governors were tested, and while both suffer from
> unexpected CPU frequency drop, teo seems much worse. However failure points
> for both governors are repeatable.
> 
> There was new BIOS for this test computer a week ago.
> System now upgraded and tested with default BIOS settings (by accident)
> and my settings. (Note: slight changes in processor package power for
> system idle and one CPU loaded with new BIOS, and earlier tests NOT re-done).
> 
> Is the processor using the latest microcode? Currently 0xcc. Can not figure out if there is anything
> newer.
> 
> Leaving out the details, but all the tests and results are available, a mess but available, the
> summary is:
> 
> With HWP enabled, if idle state 2 is used, there is a probability that the CPU frequency might
> unexpectedly drop significantly.
> If the processor does this by itself, or by being told to via sources outside of the intel_pstate CPU
> frequency driver, I don't
> know.
> 
> The load sweep test was run at 6 seconds per step during increasing load and 3 seconds per step
> decreasing
> (by mistake, if you must know), while monitoring the idle statistics.
> The test was done in a hurry, so many above/below statistics are 0%, due to insufficient sample size.
> The overruns and use of idle state 0 are exactly correlated.
> There are a lot of graphs on the idle statistics web page, but the idle state 2 usage correlates
> exactly with
> undesired low CPU frequency and overruns.
> 
> Side note: Even in the areas where HWP appears to behave, the no-hwp power use is much better.
> 
> O.K., so now, do a couple of more turbostat samples:
> 
> intel_pstate/powersave hwp idle state 2 disabled:
> 
> Overruns: 3
> Ave. work percent: 66.647895
> Processor package power: ~16.8 watts.
> Average CPU frequency: 4.6 gigahertz
> 
> intel_pstate/powersave hwp idle state 3 disabled:
> 
> Overruns: 22
> Ave. work percent: 66.647895
> Processor package power: ~16.2 watts.
> Average CPU frequency: 4.6 gigahertz
> 
> To prevent all the bots that burden my site, the link is coded:
> [1] double u double u double u dot smythies dot com /~doug/linux/s18/hwp/index.html
> 
> ... Doug
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: May 26, 2020 11:21 AM
> > To: Linux PM; Doug Smythies
> > Cc: LKML; Len Brown; Srinivas Pandruvada; Peter Zijlstra; Giovanni Gherdovich; Francisco Jerez
> > Subject: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode with HWP enabled
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Allow intel_pstate to work in the passive mode with HWP enabled and
> > make it set the HWP minimum performance limit to 75% of the P-state
> > value corresponding to the target frequency supplied by the cpufreq
> > governor, so as to prevent the HWP algorithm and the CPU scheduler
> > from working against each other at least when the schedutil governor
> > is in use.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is a replacement for https://patchwork.kernel.org/patch/11563615/ that
> > uses the HWP floor (minimum performance limit) as the feedback to the HWP
> > algorithm (instead of the EPP).
> >
> > The INTEL_CPUFREQ_TRANSITION_DELAY_HWP is still 5000 and the previous comments
> > still apply to it.
> >
> > In addition to that, the 75% fraction used in intel_cpufreq_adjust_hwp() can be
> > adjusted too, but I would like to use a value with a power-of-2 denominator for
> > that (so the next candidate would be 7/8).
> >
> > Everyone who can do that is kindly requested to test this and let me know
> > the outcome.


