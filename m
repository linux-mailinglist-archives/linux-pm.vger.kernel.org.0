Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16602180AC6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 22:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgCJVqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 17:46:23 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49172 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJVqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 17:46:23 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48cTDt3K6CzFf4g;
        Tue, 10 Mar 2020 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583876782; bh=O5+NjN6hGYqQ8zt6klZcMvOoagUZx5TzRHwqC4TnZ+A=;
        h=From:To:Cc:Subject:Date:From;
        b=c4r/5+v5XyJo5L99TJH//nPYIDT9uYB5/eSgIaGslsbllbZdzHilWDFLtEwwEMNgQ
         9vKAh3EA71v6n3qw3R2uSOWMpHWKwoQB3aA+DfZ+qQh+SEGRXnEiNmxZGRxRPZzrgL
         6vXE8XjJYZxezDRoCsG49jpm/W475z0Tv7kYosXk=
X-Riseup-User-ID: 4BCCD02C88EA505C44278F96B11C2B57C95CC107B9A24E6EB5454AFBA229E47C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48cTDs6tfPzJrlc;
        Tue, 10 Mar 2020 14:46:21 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC] GPU-bound energy efficiency improvements for the intel_pstate driver (v2).
Date:   Tue, 10 Mar 2020 14:41:53 -0700
Message-Id: <20200310214203.26459-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is my second take on improving the energy efficiency of the
intel_pstate driver under IO-bound conditions.  The problem and
approach to solve it are roughly the same as in my previous series [1]
at a high level:

In IO-bound scenarios (by definition) the throughput of the system
doesn't improve with increasing CPU frequency beyond the threshold
value at which the IO device becomes the bottleneck, however with the
current governors (whether HWP is in use or not) the CPU frequency
tends to oscillate with the load, often with an amplitude far into the
turbo range, leading to severely reduced energy efficiency, which is
particularly problematic when a limited TDP budget is shared among a
number of cores running some multithreaded workload, or among a CPU
core and an integrated GPU.

Improving the energy efficiency of the CPU improves the throughput of
the system in such TDP-limited conditions.  See [4] for some
preliminary benchmark results from a Razer Blade Stealth 13 Late
2019/LY320 laptop with an Intel ICL processor and integrated graphics,
including throughput results that range up to a ~15% improvement and
performance-per-watt results up to a ~43% improvement (estimated via
RAPL).  Particularly the throughput results may vary substantially
from one platform to another depending on the TDP budget and the
balance of load between CPU and GPU.

One of the main differences relative to my previous version is that
the trade-off between energy efficiency and frequency ramp-up latency
is now exposed to device drivers through a new PM QoS class [It would
make sense to expose it to userspace too eventually but that's beyond
the purpose of this series].  The new PM QoS class provides a latency
target to CPUFREQ governors which gives them permission to filter out
CPU frequency oscillations with a period significantly shorter than
the specified target, whenever doing so leads to improved energy
efficiency.

This series takes advantage of the new PM QoS class from the i915
driver whenever the driver determines that the GPU has become a
bottleneck for an extended period of time.  At that point it places a
PM QoS ramp-up latency target which causes CPUFREQ to limit the CPU to
a reasonably energy-efficient frequency able to at least achieve the
required amount of work in a time window approximately equal to the
ramp-up latency target (since any longer-term energy efficiency
optimization would potentially violate the latency target).  This
seems more effective than clamping the CPU frequency to a fixed value
directly from various subsystems, since the CPU is a shared resource,
so the frequency bound needs to consider the load and latency
requirements of all independent workloads running on the same CPU core
in order to avoid performance degradation in a multitasking, possibly
virtualized environment.

The main limitation of this PM QoS approach is that whenever multiple
clients request different ramp-up latency targets, only the strictest
(lowest latency) one will apply system-wide, potentially leading to
suboptimal energy efficiency for the less latency-sensitive clients,
(though it won't artificially limit the CPU throughput of the most
latency-sensitive clients as a result of the PM QoS requests placed by
less latency-sensitive ones).  In order to address this limitation I'm
working on a more complicated solution which integrates with the task
scheduler in order to provide response latency control with process
granularity (pretty much in the spirit of PELT).  One of the
alternatives Rafael and I were discussing was to expose that through a
third cgroup clamp on top of the MIN and MAX utilization clamps, but
I'm open to any other possibilities regarding what the interface
should look like.  Either way the current (scheduling-unaware) PM
QoS-based interface should provide most of the benefit except in
heavily multitasking environments.

A branch with this series in testable form can be found here [2],
based on linux-next from a few days ago.  Another important difference
with respect to my previous revision is that the present one targets
HWP systems (though for the moment it's only enabled by default on
ICL, even though that can be overridden through the kernel command
line).  I have WIP code that uses the same governor in order to
provide a similar benefit on non-HWP systems (like my previous
revision), which can be found in this branch for reference [3] -- I'm
planning to finish that up and send it as follow-up to this series
assuming people are happy with the overall approach.

Thanks in advance for any review feed-back and test reports.

[PATCH 01/10] PM: QoS: Add CPU_RESPONSE_FREQUENCY global PM QoS limit.
[PATCH 02/10] drm/i915: Adjust PM QoS response frequency based on GPU load.
[PATCH 03/10] OPTIONAL: drm/i915: Expose PM QoS control parameters via debugfs.
[PATCH 04/10] Revert "cpufreq: intel_pstate: Drop ->update_util from pstate_funcs"
[PATCH 05/10] cpufreq: intel_pstate: Implement VLP controller statistics and status calculation.
[PATCH 06/10] cpufreq: intel_pstate: Implement VLP controller target P-state range estimation.
[PATCH 07/10] cpufreq: intel_pstate: Implement VLP controller for HWP parts.
[PATCH 08/10] cpufreq: intel_pstate: Enable VLP controller based on ACPI FADT profile and CPUID.
[PATCH 09/10] OPTIONAL: cpufreq: intel_pstate: Add tracing of VLP controller status.
[PATCH 10/10] OPTIONAL: cpufreq: intel_pstate: Expose VLP controller parameters via debugfs.

[1] https://marc.info/?l=linux-pm&m=152221943320908&w=2
[2] https://github.com/curro/linux/commits/intel_pstate-vlp-v2-hwp-only
[3] https://github.com/curro/linux/commits/intel_pstate-vlp-v2
[4] http://people.freedesktop.org/~currojerez/intel_pstate-vlp-v2/benchmark-comparison-ICL.log

