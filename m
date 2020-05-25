Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4941E11BD
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404066AbgEYPaa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 11:30:30 -0400
Received: from cmta19.telus.net ([209.171.16.92]:60186 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403999AbgEYPa3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 May 2020 11:30:29 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id dF3WjNOWAFblkdF3XjFDIL; Mon, 25 May 2020 09:30:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1590420628; bh=YFBnT3cGSz/EedwVITIk0pujpFazc/XxkUBV2VpUSjU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=pYw+007PX3HUEACWo4O2bURpk8ukbQ2edU/976Qw95T4LVLFySuAqkWssu1Y/A8b6
         3wI5MayP3+AyncSzHakBeFzOCBCvdk5kHo6D2dZTYXYuDhbTNvVZK0fHaZcBdDikGt
         RQ8kRYJNpUkq6OhjVR5k6N/9HJZxj6wDP3i8h8wG1tj9//u/OqBW8U1eDpofRew9kY
         s9MyzIxHRIaVKnSl0xqhiFV2ax/YMOBtO8ZxOL/UU3q6QzcireNnbQr0DsJqqxeFNF
         JUfCac9ML3xm7AMZiLaj1PWSuJlNGKiPt/wvOiUCqa3nVdt+VR4juo6qEF/vI0uBQr
         7iRI/NBQaTOLg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=BNTNU2YG c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=FGbulvE0AAAA:8 a=LOdWmadk-Bv_ydi_8LsA:9 a=CjuIK1q_8ugA:10
 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>
References: <3169564.ZRsPWhXyMD@kreacher>
In-Reply-To: <3169564.ZRsPWhXyMD@kreacher>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with HWP enabled
Date:   Mon, 25 May 2020 08:30:21 -0700
Message-ID: <000801d632a9$6a586c90$3f0945b0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYvk3X5bnwqpX6hRwi7ciAthJfS0ADBo0fw
X-CMAE-Envelope: MS4wfFuRNo80j7dNtT7zbfWm+8Rcw42GEVPnNcML71lgl6AtF//khuUFrDTKDwB/byt4oVvWEuN+UxgnYUMSmi23whqhW48hrCb4w4yAU5XGIUBm/s3uwqkc
 lzGctV2l3IkrqGQ5QtyvvZn1p2M29fGs1n4MNJf9WlHlmdSduRGr7lKz3P5VIinzEiAt6HCI2oqM8i9Fu7m5RrHxBLxuGXMjaRiqc6VCjO7yiZLUWOmUfQlX
 kq/JoMA6vcRz+Y9JkX7TSJxSgTbxR3D11LDRv5jXYr6PcETwrpNGRJsTDOJ+QdFU7zX6ld3mBdDd6CiZvAucS++SUXd5UGOxIRPVPPNSK8d7gaXTutUrnFA0
 Eb/KGBy7WegbLAQe9CymBW1NzVopcVUU5oOGGOiLJDq4RoA2/tA26ULWigTRDgyCxSdc0HXz
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.05.21 10:16 Rafael J. Wysocki wrote:

> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Allow intel_pstate to work in the passive mode with HWP enabled and
> make it translate the target frequency supplied by the cpufreq
> governor in use into an EPP value to be written to the HWP request
> MSR (high frequencies are mapped to low EPP values that mean more
> performance-oriented HWP operation) as a hint for the HWP algorithm
> in the processor, so as to prevent it and the CPU scheduler from
> working against each other at least when the schedutil governor is
> in use.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a prototype not intended for production use (based on linux-next).
> 
> Please test it if you can (on HWP systems, of course) and let me know the
> results.
> 
> The INTEL_CPUFREQ_TRANSITION_DELAY_HWP value has been guessed and it very well
> may turn out to be either too high or too low for the general use, which is one
> reason why getting as much testing coverage as possible is key here.
> 
> If you can play with different INTEL_CPUFREQ_TRANSITION_DELAY_HWP values,
> please do so and let me know the conclusions.

Hi all,

It is way too early for me to reply to this, as my tests are incomplete.
However, I saw the other e-mails and will chime in now.

Note before: I have been having difficulties with this test computer,
results may be suspect.

The default INTEL_CPUFREQ_TRANSITION_DELAY_HWP is definitely too short.
I do not know what an optimal value is, but I have made it the same as
INTEL_CPUFREQ_TRANSITION_LATENCY for now, and because it makes for great
test comparisons.

I have only done the simplest of tests so far, single thread, forced
CPU affinity load ramp up/down.

Load:
fixed work packet per work period, i.e. the amount of work to do is independent of CPU frequency.
347 hertz work / sleep frequency. Why? No reason. Because it is what I used last time.

To reveal any hysteresis (i.e. with conservative governor) load ramps up from none
to 100% and then back down to none at 3 seconds per step (step size is uncalibrated).

Processor:
Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz

Modes:
intel_cpufreq (i_)
intel_pstate (p_)
acpi-cpufreq (a_)

Kernel:

b955f2f4a425 (HEAD -> k57-hwp) cpufreq: intel_pstate: Work in passive mode with HWP enabled
faf93d5c9da1 cpufreq: intel_pstate: Use passive mode by default without HWP
b9bbe6ed63b2 (tag: v5.7-rc6) Linux 5.7-rc6

Graph notes: The ramp up and ramp down are folded back on the graphs. These tests
were launched manually in two terminals, so the timing was not exact.
I'll fix this moving forward. 

Legend - ondemand graph [1] (minor annotation added):

i_onde_stock : intel-cpufreq, ondemand, stock kernel (5.7-rc6), hwp disabled.
i_onde_hwp : intel-cpufreq, ondemand, patched kernel (5.7-rc6), DELAY_HWP 5000.
i_onde_hwp2 : intel-cpufreq, ondemand, patched kernel (5.7-rc6), DELAY_HWP 20000.
a_onde: acpi-cpufreq, stock kernel (5.7-rc6), intel_pstate disabled.

Conclusion:
DELAY_HWP 20000 matches the pre-patch response almost exactly.
DELAY_HWP 5000 goes too far (my opinion), but does look promising.

Legend - intel_pstate - powersave graph [2].

What? Why is there such a graph, unrelated to this patch?
Well, because there is a not yet understood effect.

p_powe_stock : intel_pstate, powersave, stock kernel (5.7-rc6), hwp disabled.
P_powe_hwp : intel_pstate, powersave, patched kernel (5.7-rc6), DELAY_HWP 5000.
P_powe_hwp2 : intel_pstate, powersave, patched kernel (5.7-rc6), DELAY_HWP 20000.

Conclusion: ??

Note: That I merely made a stupid mistake is a real possibility.
Repeat test pending.

Legend - schedutil graph [3]:

i_sche_stock : intel-cpufreq, ondemand, stock kernel (5.7-rc6), hwp disabled.
i_sche_hwp : intel-cpufreq, ondemand, patched kernel (5.7-rc6), DELAY_HWP 5000.
i_sche_hwp2 : intel-cpufreq, ondemand, patched kernel (5.7-rc6), DELAY_HWP 20000.
a_sche: acpi-cpufreq, stock kernel (5.7-rc6), intel_pstate disabled.

Conclusion: ?? I don't know, always had schedutil issues on this computer.
Expected more like typical from my older test server (i7-2600K) [4]:

[1] http://www.smythies.com/~doug/linux/intel_pstate/passive-hwp/passive-hwp-ondemand.png
[2] http://www.smythies.com/~doug/linux/intel_pstate/passive-hwp/passive-hwp-but-active-powersave.png
[3] http://www.smythies.com/~doug/linux/intel_pstate/passive-hwp/passive-hwp-schedutil.png
[4] http://www.smythies.com/~doug/linux/intel_pstate/cpu-freq-scalers/fixed-work-packet-folded-schedutil.png


> 
>  #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
> +#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP	5000

For now, while trying to prove nothing is busted,
suggest 20000.

> +/**
> + * intel_cpufreq_adjust_hwp_request - Adjust the HWP reuqest register.

request.

> +static void intel_cpufreq_adjust_hwp_request(struct cpudata *cpu, s64 max_freq,
> +					     unsigned int target_freq)
> +{
> +	s64 epp_fp = div_fp(255 * (max_freq - target_freq), max_freq);
> +

I would have thought this:

	s64 epp_fp = div_fp(255 * (max_freq - target_freq), (max_freq - min_freq));

but tested the original only, so far.

... Doug


