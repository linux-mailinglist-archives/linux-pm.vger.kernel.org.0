Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064B928D419
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgJMSzb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 14:55:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:41279 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgJMSzb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 14:55:31 -0400
IronPort-SDR: q1qF5AkRN96vkbIGJRaEi4FjFVM0XOqpQ7/JqhOBu45U/R7PfYVHqp3ZD6qsI2eqrpXxnRTcou
 RPUKDVXqtKpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="183455545"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="183455545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 11:55:30 -0700
IronPort-SDR: Z0d2FdRUxpn9Lo2WjHT52tkOlQLSWbPftrqdZdlgk70MJqqCt06VSAjSo820hJEtDSQv43AdwV
 BqRQ7TchRVzQ==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="463603361"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.131.190]) ([10.249.131.190])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 11:55:28 -0700
Subject: Re: ACPI _CST introduced performance regresions on Haswll
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <20201006083639.GJ3227@techsingularity.net>
 <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net>
 <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net>
 <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
 <20201008090909.GP3227@techsingularity.net>
 <dcf4266a-5769-8a6b-d8e1-e77553126861@intel.com>
 <20201008173436.GQ3227@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <f6b04376-4214-ff5d-1069-890449a923e2@intel.com>
Date:   Tue, 13 Oct 2020 20:55:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201008173436.GQ3227@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/8/2020 7:34 PM, Mel Gorman wrote:
> On Thu, Oct 08, 2020 at 07:15:46PM +0200, Rafael J. Wysocki wrote:
>>> Force enabling C6
>>>
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:0
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/disable:0
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/disable:1
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/disable:0
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/default_status:enabled
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/default_status:enabled
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/default_status:enabled
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/default_status:disabled
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/default_status:enabled
>>>
>>> Note that as expected, C3 remains disabled when only C6 is forced (state3
>>> == c3, state4 == c6). While this particular workload does not appear to
>>> care as it does not remain idle for long, the exit latency difference
>>> between c3 and c6 is large so potentially a workload that idles for short
>>> durations that are somewhere between c1e and c3 exit latency might take
>>> a larger penalty exiting from c6 state if the deeper c-state is selected
>>> for idling.
>>>
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state0/residency:0
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state1/residency:2
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state2/residency:20
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state3/residency:100
>>> ./5.9.0-rc8-enable-c6/iter-0/sys/devices/system/cpu/cpu0/cpuidle/state4/residency:400
>>>
>> If you are worried that C6 might be used instead of C3 in some cases, this
>> is not going to happen.
>>
> Ok, so it goes in the C1E direction instead. I lost track of how C-state
> is selected based on predictions about the future. It's changed a bit
> over time.
>   
>> I all cases in which C3 would have been used had it not been disabled, C1E
>> will be used instead.
>>
>> Which BTW indicates that using C1E more often adds a lot of latency to the
>> workload (if C3 and C6 are both disabled, C1E is used in all cases in which
>> one of them would have been used).
> Which is weird. From the exit latency alone, I'd think it would be faster
> to use C1E instead of C3. It implies that using C1E instead of C3/C6 has
> some other side-effect on Haswell. At one point, there was plenty of advice
> on disabling C1E but very little concrete information on what impact it
> has exactly and why it might cause problems that other c-states avoid.
>
>> With C6 enabled, that state is used at
>> least sometimes (so C1E is used less often), but PC6 doesn't seem to be
>> really used - it looks like core C6 only is entered and which may be why C6
>> adds less latency than C1E (and analogously for C3).
>>
> At the moment, I'm happy with either solution but mostly because I can't
> tell what other trade-offs should be considered :/
>
I talked to Len and Srinivas about this and my theory above didn't survive.

The most likely reason why you see a performance drop after enabling the 
ACPI support (which effectively causes C3 and C6 to be disabled by 
default on the affected machines) is because the benchmarks in question 
require sufficiently high one-CPU performance and the CPUs cannot reach 
high enough one-core turbo P-states without the other CPUs going into C6.

Inspection of the ACPI tables you sent me indicates that there is a BIOS 
switch in that system allowing C6 to be enabled.  Would it be possible 
to check whether or not there is a BIOS setup option to change that setting?

Also, I need to know what happens if that system is started with 
intel_idle disabled.  That is, what idle states are visible in sysfs in 
that configuration (what their names and descriptions are in particular) 
and whether or not the issue is still present then.

In addition to that, can you please run the benchmark on that system 
under turbostat both with unmodified intel_idle and with intel_idle 
disabled and post the turbostat output in each of those cases?

Cheers!


