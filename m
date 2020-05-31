Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC901E991D
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgEaQy0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 12:54:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:6476 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgEaQy0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 12:54:26 -0400
IronPort-SDR: 035EA0oyN/qBCv6UFaFwANDNjw2KQXvbdkr1Cxghv9ezECBKIBm/Tb8hEv9+JojI4t31UiWDUX
 2BV6imbHDItg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 09:54:23 -0700
IronPort-SDR: BtRy7OUmw+Tq1CC+q4LLQP9157FYBmDID61EKLs+a4LmXoQ8WllfpUwoJp7zPQVwmq3X+onKEL
 JYW5/ua1o9qg==
X-IronPort-AV: E=Sophos;i="5.73,457,1583222400"; 
   d="scan'208";a="470046594"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 09:54:23 -0700
Message-ID: <b624a148cdb91340dd8d8831c7b033017cab737e.camel@linux.intel.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode
 with HWP enabled
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     'LKML' <linux-kernel@vger.kernel.org>,
        'Len Brown' <len.brown@intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Francisco Jerez' <francisco.jerez.plata@intel.com>,
        'Linux PM' <linux-pm@vger.kernel.org>
Date:   Sun, 31 May 2020 09:54:23 -0700
In-Reply-To: <000001d6376a$03bbaae0$0b3300a0$@net>
References: <2931539.RsFqoHxarq@kreacher>
         <000001d6376a$03bbaae0$0b3300a0$@net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Doug,

On Sun, 2020-05-31 at 09:39 -0700, Doug Smythies wrote:
> The content of this e-mail is also at [1],
> with annotated graphs.
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
> Detail (see [1] for supporting graphs and links):
> 
> I can not proceed with testing this.
> Why not?
> Because I do not have a stable good system on top of which to add
> this patch.
> I do not know what is wrong such that HWP appears broken.
> 
> For my part of it, I had to stop and dig into
> why HWP doesn't seem to work properly on my newer test computer.
> 
> Notes:
> I have never used HWP before, and have had it disabled so far on this
> newer test computer. This patch seemed like a great opportunity to
> try it.
> Why (in addition to helping via review/test)? Because trace now
> works,
> whereas it doesn't in active mode with HWP.
> 
> It is on my list to explore viability of a mode for trace where it
> monitors
> what the processor is doing via HWP, rather than reporting what the
> processor is being told to do. However, in the meantime, this is
> great.
> 
> Example of what is wrong on my system (repeated, but new example
> trace data,
> from earlier e-mail):
> 
> Kernel: 5.7-rc6 and + this version of patch when trace data required.
> Patch config: DELAY_HWP 10000 ; 87.5% fraction (7/8).
> Keep in mind that the trace entry is the scaled min value, not the
> target p-state.
> 
> Load:
> Single thread, forced CPU affinity.
> fixed work packet per work period, i.e. the amount of work to do is
> independent of CPU frequency.
> 347 hertz work / sleep frequency.
> To reveal any hysteresis (i.e. with conservative governor) load ramps
> up from none
> to 100% and then back down to none at 3 seconds per step (step size
> is uncalibrated).
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

Seems you hit power/thermal limit

Is this some Lenovo system?

If you disable HWP you don't see that?

What is the value of
cat /sys/bus/pci/devices/0000\:00\:04.0/tcc_offset_degree_celsius
cat /sys/class/powercap/intel-rapl-mmio/intel-rapl-
mmio:0/constraint_0_power_limit_uw
 
You may want to run 
Try running dptfxtract once.

Then try to get again

cat /sys/bus/pci/devices/0000\:00\:04.0/tcc_offset_degree_celsius
cat /sys/class/powercap/intel-rapl-mmio/intel-rapl-
mmio:0/constraint_0_power_limit_uw


Thanks,
Srinivas

> 26      ; 40      ; 2.87    ; 100.00 ; 10.996  <<<< What? Why freq
> down? (note: it is always above old min)
> 40      ; 29      ; 4.25    ; 69.67  ; 10.002  <<<< O.K. recovering,
> but damage done.
> 29      ; 26      ; 4.60    ; 59.14  ; 10.652  <<<< Event ends. Next
> event in 128 milliseconds.
> 
> I can not think of any reason why the frequency would have been
> reduced so far by HWP.
> 
> O.K., the above had to be done with the patch so that trace could be
> used.
> Ondemand was the governor, because its response curve looks the same
> as
> active/powersave in the area of concern.
> 
> The below was done with kernel 5.7-rc6 and only turbostat, at a low
> sample rate of 15 seconds per,
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
> The breakpoint between no-overruns/overruns is around 950
> microseconds.
> 
> A 250 hertz kernel was tested, and it did not have this issue in this
> area.
> Perhaps elsewhere, I didn't look.
> 
> 1000 hertz kernels were tested back to kernel 5.2, all failed.
> 
> If the issue is jiffy related (a race condition?) then a work/sleep
> frequency
> of 333.3333 hertz should behave in binary way, either lots of
> overruns or none
> as a function of the task start time. (Preliminary) It does.
> 
> If the issue is jiffy related (a race condition?) then a work/sleep
> frequency
> of 500.00 hertz should behave in binary way, either lots of overruns
> or none
> as a function of the task start time. It does. There are occurrences
> when idle
> state 2 is used somewhat without overruns.
> 
> Both teo and menu idle governors were tested, and while both suffer
> from
> unexpected CPU frequency drop, teo seems much worse. However failure
> points
> for both governors are repeatable.
> 
> There was new BIOS for this test computer a week ago.
> System now upgraded and tested with default BIOS settings (by
> accident)
> and my settings. (Note: slight changes in processor package power for
> system idle and one CPU loaded with new BIOS, and earlier tests NOT
> re-done).
> 
> Is the processor using the latest microcode? Currently 0xcc. Can not
> figure out if there is anything newer.
> 
> Leaving out the details, but all the tests and results are available,
> a mess but available, the summary is:
> 
> With HWP enabled, if idle state 2 is used, there is a probability
> that the CPU frequency might unexpectedly drop significantly.
> If the processor does this by itself, or by being told to via sources
> outside of the intel_pstate CPU frequency driver, I don't
> know.
> 
> The load sweep test was run at 6 seconds per step during increasing
> load and 3 seconds per step decreasing
> (by mistake, if you must know), while monitoring the idle statistics.
> The test was done in a hurry, so many above/below statistics are 0%,
> due to insufficient sample size.
> The overruns and use of idle state 0 are exactly correlated.
> There are a lot of graphs on the idle statistics web page, but the
> idle state 2 usage correlates exactly with
> undesired low CPU frequency and overruns.
> 
> Side note: Even in the areas where HWP appears to behave, the no-hwp
> power use is much better.
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
> [1] double u double u double u dot smythies dot com
> /~doug/linux/s18/hwp/index.html 
> 
> ... Doug
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: May 26, 2020 11:21 AM
> > To: Linux PM; Doug Smythies
> > Cc: LKML; Len Brown; Srinivas Pandruvada; Peter Zijlstra; Giovanni
> > Gherdovich; Francisco Jerez
> > Subject: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive
> > mode with HWP enabled
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Allow intel_pstate to work in the passive mode with HWP enabled and
> > make it set the HWP minimum performance limit to 75% of the P-state
> > value corresponding to the target frequency supplied by the cpufreq
> > governor, so as to prevent the HWP algorithm and the CPU scheduler
> > from working against each other at least when the schedutil
> > governor
> > is in use.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > This is a replacement for 
> > https://patchwork.kernel.org/patch/11563615/ that
> > uses the HWP floor (minimum performance limit) as the feedback to
> > the HWP
> > algorithm (instead of the EPP).
> > 
> > The INTEL_CPUFREQ_TRANSITION_DELAY_HWP is still 5000 and the
> > previous comments
> > still apply to it.
> > 
> > In addition to that, the 75% fraction used in
> > intel_cpufreq_adjust_hwp() can be
> > adjusted too, but I would like to use a value with a power-of-2
> > denominator for
> > that (so the next candidate would be 7/8).
> > 
> > Everyone who can do that is kindly requested to test this and let
> > me know
> > the outcome.
> 
> 

