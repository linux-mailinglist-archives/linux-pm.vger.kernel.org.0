Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0265F259F3A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 21:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgIATaf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 15:30:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:6791 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIATaf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 15:30:35 -0400
IronPort-SDR: hrAFSJwAbHBl36TZ6/NXGQBOMAUKsJkmUY+eAHTfu0Ki9PD4yk5cyIAHW6ESWSTPzEdIWc+PuC
 TUyi1EB71HeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="154765952"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="154765952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:30:34 -0700
IronPort-SDR: rqYIF/HVs26EZIapXEMNNIkMYKjSvHuhZfsVivCY62htXEzUfYChvdOKTSfpIWTU3lE0gM2nyK
 AUQblAx4kjmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="283494169"
Received: from bochuanx-mobl1.ccr.corp.intel.com ([10.209.107.108])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2020 12:30:33 -0700
Message-ID: <4a9665fc0656a20a94539a0a9c6a576c2a0d0d36.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max()
 for turbo disabled cases.
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Callaway, Caleb" <caleb.callaway@intel.com>,
        Francisco Jerez <currojerez@riseup.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Date:   Tue, 01 Sep 2020 12:30:33 -0700
In-Reply-To: <BYAPR11MB3496426018632CA8BF51FEC6842E0@BYAPR11MB3496.namprd11.prod.outlook.com>
References: <20200901030250.495928-1-currojerez@riseup.net>
         <81b98c58eab0bf075d9ded2154a7a88020628c80.camel@linux.intel.com>
         <87k0xdwead.fsf@riseup.net>
         <BYAPR11MB3496426018632CA8BF51FEC6842E0@BYAPR11MB3496.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-09-01 at 18:56 +0000, Callaway, Caleb wrote:
> Hi folks,
> 
> Thanks for working on this! It's possible my system is still clocking
> up to max turbo, but I didn't explicitly test this.
This is unlikely that will clock to turbo. Better to test that.
But since the frequency limits can't be set correctly, the patch is
still valid.

Thanks,
Srinivas

>  My goal was to fix the CPU frequency at 2.8 GHz on a CFL-S platform
> using the following script:
> 
> 	_cpufreq=<frequency in Khz>
> 	cpu_sysfs="/sys/devices/system/cpu/cpufreq"
> 	for cpu in $cpu_sysfs/*; do
> 		echo "Setting frequency for $cpu..."
> 		echo "performance" > $cpu/scaling_governor
> 		echo $_cpufreq > $cpu/scaling_max_freq
> 		echo $_cpufreq > $cpu/scaling_min_freq
> 	done
> 
> To get the desired fixed frequency, I had to set _cpufreq==2100000
> when Turbo was disabled in the BIOS; with Turbo enabled, I had to use
> the value 2800000. I observed the result with:
> 
> 	watch "cat /proc/cpuinfo | grep 'cpu MHz'"
> 
> With Francisco's patch, I could use the value 2800000 for both Turbo
> enabled and Turbo disabled.
> 
> I'm not well-acquainted with the moving parts here, but if there's an
> additional supporting experiment I can run, just let me know.
> 
> HTH,
> -Caleb
> 
> -----Original Message-----
> From: Francisco Jerez <currojerez@riseup.net> 
> Sent: Tuesday, September 1, 2020 11:19 AM
> To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>; 
> linux-pm@vger.kernel.org
> Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Callaway, Caleb <
> caleb.callaway@intel.com>
> Subject: Re: [PATCH] cpufreq: intel_pstate: Fix
> intel_pstate_get_hwp_max() for turbo disabled cases.
> 
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
> 
> > On Mon, 2020-08-31 at 20:02 -0700, Francisco Jerez wrote:
> > > This fixes the behavior of the scaling_max_freq and
> > > scaling_min_freq 
> > > sysfs files in systems which had turbo disabled by the BIOS.
> > > 
> > > Caleb noticed that the HWP is programmed to operate in the wrong 
> > > P-state range on his system when the CPUFREQ policy min/max
> > > frequency 
> > > is set via sysfs.  This seems to be because in his system
> > > intel_pstate_get_hwp_max() is returning the maximum turbo P-
> > > state 
> > > even though turbo was disabled by the BIOS, which causes
> > > intel_pstate 
> > > to scale kHz frequencies incorrectly e.g. setting the maximum
> > > turbo 
> > > frequency whenever the maximum guaranteed frequency is requested
> > > via 
> > > sysfs.
> > 
> > When  turbo is disabled via MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> > (From 
> > BIOS), then no matter what we write to HWP. max, the hardware will 
> > clip to HWP_GUARANTEED_PERF.
> > 
> > But it looks like this is some issue on properly disabling turbo
> > from 
> > BIOS, since you observe turbo frequencies (via aperf, mperf) not
> > just 
> > sysfs display issue.
> > 
> 
> Caleb should be able to confirm that, but my understanding is that
> his system was still clocking up to the max turbo frequency despite
> turbo being disabled in the BIOS and the maximum guaranteed frequency
> having been specified in scaling_max_freq.
> 
> However there is a bug even in systems where the clipping you
> describe is working correctly, the conversion from kHz frequency to
> P-state uses a bogus scaling factor without this patch applied.
> 
> > 
> > > Tested-by: Caleb Callaway <caleb.callaway@intel.com>
> > > Signed-off-by: Francisco Jerez <currojerez@riseup.net>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> 
> Thanks!
> 
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cpufreq/intel_pstate.c 
> > > b/drivers/cpufreq/intel_pstate.c index
> > > e0220a6fbc69..7eb7b62bd5c4 
> > > 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -825,7 +825,7 @@ static void intel_pstate_get_hwp_max(unsigned
> > > int 
> > > cpu, int *phy_max,
> > >  
> > >  	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
> > >  	WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
> > > -	if (global.no_turbo)
> > > +	if (global.no_turbo || global.turbo_disabled)
> > >  		*current_max = HWP_GUARANTEED_PERF(cap);
> > >  	else
> > >  		*current_max = HWP_HIGHEST_PERF(cap);

