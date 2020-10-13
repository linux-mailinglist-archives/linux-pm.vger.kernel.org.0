Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8548328C8B5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 08:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbgJMGnP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 02:43:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:51882 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389493AbgJMGnO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 02:43:14 -0400
IronPort-SDR: q8eCrC4X5cOKUWA4CV97VwWNVZsrGiQV+zCIT+HepgHg3/qAiTiwvqCbv2/ZvSMy+PCulvfrk5
 +PpqzCCazH8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="145177398"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="145177398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 23:43:13 -0700
IronPort-SDR: UrQi1LWaZMKfgcFs5IclXvK2HEsLSBivZCrR3hrlP6tUsCFm0VJ6KIXL7F8Y3wrCYZnwYwQwfy
 A6zc86KG9rmw==
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="313700061"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 23:43:10 -0700
Date:   Tue, 13 Oct 2020 14:44:52 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wendy Wang <wendy.wang@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cpufreq: intel_pstate: Delete intel_pstate sysfs if
 failed to register the driver
Message-ID: <20201013064452.GA17226@chenyu-office.sh.intel.com>
References: <20201009033038.23157-1-yu.c.chen@intel.com>
 <ae351673692472b5ff5a482debc2de9060ffdd5e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae351673692472b5ff5a482debc2de9060ffdd5e.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,
On Mon, Oct 12, 2020 at 06:22:40AM -0700, srinivas pandruvada wrote:
> On Fri, 2020-10-09 at 11:30 +0800, Chen Yu wrote:
> > There is a corner case that if the intel_pstate driver failed to be
> > registered(might be due to invalid MSR access) 
> Do you have logs why it is not loaded? On supported platforms MSRs
> should be invalid.
Unfortunately we don't have the boot up log for now, as it is
a pre-production platform and the low-level simulation(for MSR)
might be unstable.( And there seems to be some environment issue
on pre-production platform to reproduce this issue).
But we can hack the code in intel_pstate to make the driver failed
to be loaded and the issue was reproduced.
> It may be a case when we are trying to bring up pre-production systems
> where some instability in MSRs on certain CPUs. 
> 
> But the patch is correct. We can't have invalid folder when
> intel_pstate is not used. 
> 
> > and with the acpi_cpufreq
> > loaded, the intel_pstate sysfs might still be created, which makes
> > the
> > user confusing(turbostat for example):
> > 
> > grep . /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
> > acpi-cpufreq
> > 
> > grep . /sys/devices/system/cpu/intel_pstate/*
> > /sys/devices/system/cpu/intel_pstate/max_perf_pct:0
> > /sys/devices/system/cpu/intel_pstate/min_perf_pct:0
> > grep: /sys/devices/system/cpu/intel_pstate/no_turbo: Resource
> > temporarily unavailable
> > grep: /sys/devices/system/cpu/intel_pstate/num_pstates: Resource
> > temporarily unavailable
> > /sys/devices/system/cpu/intel_pstate/status:off
> > grep: /sys/devices/system/cpu/intel_pstate/turbo_pct: Resource
> > temporarily unavailable
> > 
> > The existing of intel_pstate sysfs does not mean that the
> > intel_pstate driver
> > has been successfully loaded(for example, echo off to status), but
> > the
> > intel_pstate sysfs should not co-exist when acpi-cpufreq is also
> > present.
> > Fix this issue by deleting the intel_pstate sysfs if the driver
> > failed
> > to be loaded during bootup.
> > 
> > Reported-by: Wendy Wang <wendy.wang@intel.com>
> > Suggested-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com
Thanks!


Best,
Chenyu
