Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8EB42C639
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJMQZS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 12:25:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36888 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhJMQZR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 12:25:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8110C21988;
        Wed, 13 Oct 2021 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634142193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nPcIplaoGvH31gOQ95S7B2c3INXp/ouUNVo+cSmQx8=;
        b=YMHHVl3cr9EtLo3Nl3VOlIpw+GV/qA4dYUKR+YzSnn89ZfYx2mTpx/21mgLb+t6sE68Fkl
        xQz3kh6Xp5XeP7FC+X9+yVK+XIYgUoX6mNJC2oMCStQL0iA/e1/2bRrqA6T6WvX5jQpY++
        M7B5exJenS+0t3/bhL0YFioeWAV2Doc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634142193;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nPcIplaoGvH31gOQ95S7B2c3INXp/ouUNVo+cSmQx8=;
        b=VTInzAx92ZYzhW3mm5ZlW5exFihn41Xe/qGB5WjLhqY0eBd8ZawXqMxYS81nqgUDcEAicl
        746VMzFqYOMd9jBw==
Received: from [10.163.29.78] (unknown [10.163.29.78])
        by relay2.suse.de (Postfix) with ESMTP id 103DBA3B89;
        Wed, 13 Oct 2021 16:23:13 +0000 (UTC)
Message-ID: <85664630200925cd75fba523adf5e78e295a3945.camel@suse.cz>
Subject: Re: [PATCH v2 21/21] Documentation: amd-pstate: add amd-pstate
 driver introduction
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Wed, 13 Oct 2021 18:23:11 +0200
In-Reply-To: <20210926090605.3556134-22-ray.huang@amd.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
         <20210926090605.3556134-22-ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2021-09-26 at 17:06 +0800, Huang Rui wrote:
> Introduce the amd-pstate driver design and implementation.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  Documentation/admin-guide/pm/amd_pstate.rst   | 377 ++++++++++++++++++
>

[... snip ...]

> +
> +AMD CPPC Performance Capability
> +--------------------------------
> +
> +Highest Performance (RO)
> +.........................
> +
> +It is the absolute maximum performance an individual processor may reach,
> +assuming ideal conditions. This performance level may not be sustainable
> +for long durations and may only be achievable if other platform components
> +are in a specific state; for example, it may require other processors be in
> +an idle state. This would be equivalent to the highest frequencies
> +supported by the processor.
> +
> +Nominal (Guaranteed) Performance (RO)
> +......................................
> +
> +It is the maximum sustained performance level of the processor, assuming
> +ideal operating conditions. In absence of an external constraint (power,
> +thermal, etc.) this is the performance level the processor is expected to
> +be able to maintain continuously. All cores/processors are expected to be
> +able to sustain their nominal performance state simultaneously.
> +
> +Lowest non-linear Performance (RO)
> +...................................
> +
> +It is the lowest performance level at which nonlinear power savings are
> +achieved, for example, due to the combined effects of voltage and frequency
> +scaling. Above this threshold, lower performance levels should be generally
> +more energy efficient than higher performance levels. This register
> +effectively conveys the most efficient performance level to ``amd-pstate``.
> +
> +Lowest Performance (RO)
> +........................
> +
> +It is the absolute lowest performance level of the processor. Selecting a
> +performance level lower than the lowest nonlinear performance level may
> +cause an efficiency penalty but should reduce the instantaneous power
> +consumption of the processor.
> +

Those above are the CPPC capabilities. All good so far. They're Read Only, and
for each capability you have a file in sysfs. It makes sense to describe them
in this Documentation folder ("admin-guide"). But the following section...

> +AMD CPPC Performance Control
> +------------------------------
> +
> +``amd-pstate`` passes performance goals through these registers. The
> +register drives the behavior of the desired performance target.
> +
> +Minimum requested performance (RW)
> +...................................
> +
> +``amd-pstate`` specifies the minimum allowed performance level.
> +
> +Maximum requested performance (RW)
> +...................................
> +
> +``amd-pstate`` specifies a limit the maximum performance that is expected
> +to be supplied by the hardware.
> +
> +Desired performance target (RW)
> +...................................
> +
> +``amd-pstate`` specifies a desired target in the CPPC performance scale as
> +a relative number. This can be expressed as percentage of nominal
> +performance (infrastructure max). Below the nominal sustained performance
> +level, desired performance expresses the average performance level of the
> +processor subject to hardware. Above the nominal performance level,
> +processor must provide at least nominal performance requested and go higher
> +if current operating conditions allow.
> +
> +Energy Performance Preference (EPP) (RW)
> +.........................................
> +
> +Provides a hint to the hardware if software wants to bias toward performance
> +(0x0) or energy efficiency (0xff).

The section above describes the CPPC "performance controls". They're marked
"Read/Write", but you don't expose them to the user via sysfs, am I right?

Do I understand correctly that with this driver, the AMD System Management
Unit (SMU -- is it the right name?) is *not* working in autonomous mode, but
is almost entirely under the OS control?

By "autonomous mode" I mean: you run a workload, the driver doesn't select any
desired frequency, and the SMU does its thing and selects the CPU clock freq
on its own. That's not what's happing here, AFAIU. I tried using amd-pstate
using the "userspace" governor (very useful for testing ;), and set
frequencies like

  echo 1200000 > /sys/devices/system/cpu/cpufreq/policy11/scaling_setspeed

and then, whatever the load on CPU#11, "cpupower monitor" would show me a
constant clock of ~1.2GHz.

Don't get me wrong, this is a very good driver! I'm super happy that the
kernel can finally see all the P-States, instead of just 3.

I'm just trying to clarify that we're using CPPC with autonomous selection
disabled, so I don't think the documentation in admin-guide should describe
features like the R/W "performance controls" that don't make sense in this
context. Especially the "Energy Performance Preference (EPP)", that you would
use to tell the SMU "do what you want, just push a little on the performance
side".

I can see that the driver, internally, is sending "lowest nonlinear" as
minimum perf, 255 as maximum perf, and whatever the governor wants as desired
perf. It just isn't exposed in sysfs so there isn't much point in documenting
that.

> [...]
> Full MSR Support
> -----------------
> 
> Some new Zen3 processors such as Cezanne provide the MSR registers directly
> while the :c:macro:`X86_FEATURE_AMD_CPPC_EXT` CPU feature flag is set.
> ``amd-pstate`` can handle the MSR register to implement the fast switch
> function in ``CPUFreq`` that can shrink latency of frequency control on the
> interrupt context.

A-ha! Cezanne. I have an EPYC Milan, so that's probably why I can't get the
"Full MSR Support". I'll test the "Shared Memory Support" then, and report my
data.


Thanks!
Giovanni

