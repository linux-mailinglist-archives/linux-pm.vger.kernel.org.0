Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797D45DCDE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 16:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhKYPJN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 10:09:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35160 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhKYPHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 10:07:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BC3C82193C;
        Thu, 25 Nov 2021 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637852640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77jlTeIrtkwCzy1kBCLb2SkHLxssS+UT50zrqiIuDCE=;
        b=nB6wG5CTmkack7MIOO4HUjUSBi9EmPoIG+CyFjR6tLSnoSiMpX20EM+91hF71rKprFrPbu
        DxcaHI7RN3xAstWtvfIR/CNhxu8zzIv2NyBpuIVN5qbIuFM3pcWzi6uWNjGyOxpWD7oWJ3
        sF+T3fZGsiOoBkeznRXYFLLaojXE4iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637852640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77jlTeIrtkwCzy1kBCLb2SkHLxssS+UT50zrqiIuDCE=;
        b=0H+ysMseQxltEVifW5+dcWbngxRFEsXHDOIOqUkzKUIrGrcWiIl7vGRIm87TBmGRj3hEDX
        oseRP/AwU3S9LsDg==
Received: from [10.163.29.78] (unknown [10.163.29.78])
        by relay2.suse.de (Postfix) with ESMTP id 0D15DA3B87;
        Thu, 25 Nov 2021 15:04:00 +0000 (UTC)
Message-ID: <dbb61b3a2602150aa091d3b456c1866a580e3c53.camel@suse.cz>
Subject: Re: [PATCH v4 06/22] cpufreq: amd: introduce a new amd pstate
 driver to support future processors
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
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Thu, 25 Nov 2021 16:03:58 +0100
In-Reply-To: <20211119103102.88124-7-ray.huang@amd.com>
References: <20211119103102.88124-1-ray.huang@amd.com>
         <20211119103102.88124-7-ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-11-19 at 18:30 +0800, Huang Rui wrote:
> <snip>
>
> Performance Per Watt (PPW) Calculation:
> 
> The PPW calculation is referred by below paper:
> https://software.intel.com/content/dam/develop/external/us/en/documents/performance-per-what-paper.pdf
> 
> Below formula is referred from below spec to measure the PPW:
> 
> (F / t) / P = F * t / (t * E) = F / E,
> 
> "F" is the number of frames per second.
> "P" is power measured in watts.
> "E" is energy measured in joules.

Hello, I'd appreciate if you can remove the reference to the above paper and
formula, because it is not really relevant to this context, and ends up being
confusing.

It describes performance per watt tailored to graphics benchmarks, in the form
of frames per joule. Nothing wrong with that, but it only works for tests that
measure frames per second, and none of the tests below is of that type.

You have:

- tbench measures throughput (MB/sec)
- gitsource, aka run the git test suite, measures elapsed time
- speedometer, a web browser test that gives "runs per minute"

If you want performance per watt, you need to express your result as
"operations per second", where "operations" is up to you to define. For
tbench, one "operation" is moving a MB of data. For speedometer, one
"operation" is one "run", as defined in the benchmark. Once you have op/sec
(aka performance), divide by the average power measured over the entire
duration of the benchmark.

In cases like gitsource, where you have elapsed_time as a result, performance
per watt is 1 / (elapsed_time * average_power).

> We use the RAPL interface with "perf" tool to get the energy data of the
> package power.
> 
> The data comparisons between amd-pstate and acpi-freq module are tested on
> AMD Cezanne processor:
> 
> 1) TBench CPU benchmark:
> 
> +---------------------------------------------------------------------+
> >                                                                     |
> >               TBench (Performance Per Watt)                         |
> >                                                    Higher is better |
> +-------------------+------------------------+------------------------+
> >                   |  Performance Per Watt  |  Performance Per Watt  |
> >   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
> >                   |  Unit: MB / (s * J)    |  Unit: MB / (s * J)    |

The unit "MB / (s * J)" doesn't really work, it should be "MB / (sec * watt)".
Can you double check that you divided the performance result by the average
power? Same for the other tests.

It is also relevant to show performance, alongside with perf-per-watt.


Thanks!
Giovanni

