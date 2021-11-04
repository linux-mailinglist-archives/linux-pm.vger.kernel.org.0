Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8054944575C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhKDQnD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 12:43:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40132 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhKDQnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 12:43:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6766E212BD;
        Thu,  4 Nov 2021 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636044022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hqx6hPjb5UsQEKNOCxBNDFPVPXc90YaNI/3P5QXlBLk=;
        b=OV72E6gBVERF/10S/CKKEeonC1AKRQzLbzXq7Qy5iDeBVuoJQiUFJP4ix1y2IKIqU7MDEt
        WK43et0DsyiR1WBLpdYoVM+rcTE+SktIaOdCIgTEpWtmw6PMsrMEJxQfichzIgkmp7nOwW
        XEI2Qz8vDqzizuQMQ5DYjNlZKrK9CT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636044022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hqx6hPjb5UsQEKNOCxBNDFPVPXc90YaNI/3P5QXlBLk=;
        b=hwQYe0ep0zyEc04YHiU+fNBbXv8hRHUb3x1Liof7EsGldMAEuIU6e66rSTcC+HR+fAkpzj
        FOXbqfKPkoF2lqDg==
Received: from ggherdovich.udp.ovpn2.nue.suse.de (ggherdovich.udp.ovpn2.nue.suse.de [10.163.44.102])
        by relay2.suse.de (Postfix) with ESMTP id 18FB6A3B88;
        Thu,  4 Nov 2021 16:40:22 +0000 (UTC)
Message-ID: <a0e932477e9b826c0781dda1d0d2953e57f904cc.camel@suse.cz>
Subject: Re: [PATCH v3 00/21] cpufreq: introduce a new AMD CPU frequency
 control mechanism
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
Date:   Thu, 04 Nov 2021 17:40:18 +0100
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-10-29 at 21:02 +0800, Huang Rui wrote:
> Hi all,
> 
> We would like to introduce a new AMD CPU frequency control mechanism as the
> "amd-pstate" driver for modern AMD Zen based CPU series in Linux Kernel.
> 
> ..snip..

Hello,

I've tested this driver and it seems the results are a little underwhelming.
The test machine is a two sockets server with two AMD EPYC 7713,
family:model:stepping 25:1:1, 128 cores/256 threads, 256G of memory and SSD
storage. On this system, the amd-pstate driver works only in "shared memory
support", not in "full MSR support", meaning that frequency switches are
triggered from a workqueue instead of scheduler context (!fast_switch).

Dbench sees some ludicrous improvements in both performance and performance
per watt; likewise netperf sees some modest improvements, but that's about
the only good news. Schedutil/ondemand on tbench and hackbench do worse
with amd-pstate than acpi-cpufreq. I don't have data for
ondemand/amd-pstate on kernbench and gitsource, but schedutil regresses on
both.

Here the tables, then some questions & discussion points.

Tilde (~) means the result is the same as baseline (which is, the ratio is close to 1).
"Sugov" means "schedutil governor", "perfgov" means "performance governor".

             :        acpi-cpufreq          :        amd-pstate          :
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
             :  ondemand  sugov  perfgov    :  ondemand  sugov  perfgov  :  better if
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                                       PERFORMANCE RATIOS
dbench       :  1.00      ~      0.33       :  0.37      0.35   0.36     :  lower
netperf      :  1.00      0.97   ~          :  1.03      1.04   ~        :  higher
tbench       :  1.00      1.04   1.06       :  0.83      0.40   1.05     :  higher
hackbench    :  1.00      ~      1.03       :  1.09      1.42   1.03     :  lower
kernbench    :  1.00      0.96   0.97       :  N/A       1.08   ~        :  lower
gitsource    :  1.00      0.67   0.69       :  N/A       0.79   0.67     :  lower
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                                  PERFORMANCE-PER-WATT RATIOS
dbench4      :  1.00      ~      3.37       :  2.68      3.12   3.03     :  higher
netperf      :  1.00      0.96   ~          :  1.09      1.06   ~        :  higher
tbench4      :  1.00      1.03   1.06       :  0.76      0.34   1.04     :  higher
hackbench    :  1.00      ~      0.95       :  0.88      0.65   0.96     :  higher
kernbench    :  1.00      1.06   1.05       :  N/A       0.93   1.05     :  higher
gitsource    :  1.00      1.53   1.50       :  N/A       1.33   1.55     :  higher


How to read the table: all numbers are ratios of the results of some
governor/driver combination and ondemand/acpi-cpufreq, which is the
baseline (first column). When the "better if" column says "higher", a ratio
larger than 1 indicates an improvement; otherwise it's a regression.
Example: hackbench with sugov/amd-pstate is 42% slower than with
ondemand/acpi-cpufreq (top table). At the same time, it's also 35% less
efficient (bottom table).

Now, some questions / possible troubleshooting directions:

- ACPI-CPUFREQ DRIVER: REQUESTS ARE HINTS OR MANDATES?
  When using acpi-cpufreq, and the OS requests some frequency (one of the
  three allowed P-States), does the hardware underneath stick to it? Or
  does it do some ulterior adjustment based on the load?
  This would tell if a machine using acpi-cpufreq is less dumb than it
  seems, and can in principle do fine-grain adjustments all the same.

- PROCESSING CPPC DOORBELL REQUESTS: HOW FAST IS THAT?
  How long does it take the hardware to process the CPPC doorbell
  request to change frequency? What happens to outstanding requests, if
  they're not processed in a timely manner? Is there any queue of requests,
  and if so, how long is it? Could it be that if requests come in too quickly
  the CPU ends up playing catch-up on freq switches that are obsoletes or
  redundant?

- LIKE-FOR-LIKE: TRY BENCHMARKING WITH AMD-PSTATE LIMITED TO 3 P-STATES?
  Could it be that to study the performance of the "shared memory support"
  system against acpi-cpufreq a more like-to-like comparison would be to limit
  amd-pstate to only the 3 P-States available to acpi-cpufreq? That would be
  for experimental/benchmarking purposes only. Eg: on my machines acpi-cpufreq
  sees 1.5GHz, 1.7GHz and 2GHz. Given that max boost is 3.72GHz, and the CPPC
  range is the abstract interval 0..255, I could limit amd-pstate to only set
  performance level of 68, 102 and 137, and see what it gives against the old
  driver. What do you think?

- PROCESSING CPPC DOORBELL REQS IS SLOW. BUT /MAKING/ A REQUEST, SLOW TOO?
  Looks to me that with the "shared memory support" the frequency update
  process is doubly asynchronous: first we have the ->target() callback
  deferred to a workqueue, then when it's eventually executed, it calls
  cppc_update_perf() which again just asks the firmware to do work at a
  later time. Are we sure that cppc_update_perf() is actually so slow to
  warrant !fast_switch?

- HOW MANY P-STATES ARE TOO MANY?
  I've always believed the contrary, but what if having too many P-States is
  harmful for both performance and efficiency? Maybe the governor is
  requesting many updates in small increments where less (and larger) updates
  would be more appropriate?


Thanks,
Giovanni

