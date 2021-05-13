Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4764C37F64D
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhEMLFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 07:05:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:46125 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233141AbhEMLEU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 07:04:20 -0400
IronPort-SDR: VWZHYe/Mby7l9kYCgwMNb5LXK7kcpliPZRPMmi6UDGQ+N65iqCHict60jQX86NxKdviwv5Mrjc
 JN2CzJ8FGC0Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199604403"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199604403"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:03:10 -0700
IronPort-SDR: 5ZvYE7JmNv7POUpBdNaWg80CNzrqnSkCAqnpGBTkv91x4ckpoG9eFBH3cnV4eXYRSLNvF1xQJk
 47fpWqJRm5aA==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="623583353"
Received: from adithyav-mobl.amr.corp.intel.com ([10.212.100.160])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:03:06 -0700
Message-ID: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Force intel_pstate to load when
 HWP disabled in firmware
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 04:03:02 -0700
In-Reply-To: <bb90b6cac2f4adcc6c80b7fddf54dbe0a6b8ff66.camel@suse.cz>
References: <20210513075930.22657-1-ggherdovich@suse.cz>
         <3fdc70c267d40561bed10fc722a8223a0b161200.camel@linux.intel.com>
         <bb90b6cac2f4adcc6c80b7fddf54dbe0a6b8ff66.camel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-05-13 at 12:10 +0200, Giovanni Gherdovich wrote:
> On Thu, 2021-05-13 at 02:24 -0700, Srinivas Pandruvada wrote:
> > On Thu, 2021-05-13 at 09:59 +0200, Giovanni Gherdovich wrote:
> > > On CPUs succeeding SKX, eg. ICELAKE_X, intel_pstate doesn't load
> > > unless
> > > CPUID advertises support for the HWP feature. Some OEMs, however,
> > > may
> > > offer
> > > users the possibility to disable HWP from the BIOS config utility
> > > by
> > > altering the output of CPUID.
> > 
> > Is someone providing a utility? What is the case for broken HWP?
> 
> Yes, I know of at least one server manufacturer that ships a BIOS
> config
> utility where the user can disable HWP.
> 
> On such server machine, which has an ICELAKE_X CPU, if the user
> unchecks HWP
> via BIOS then intel_pstate will refuse to load saying:
> 
>     intel_pstate: CPU model not supported
> 
> because ICELAKE_X is not in the list intel_pstate_cpu_ids (defined in
> intel_pstate.c) of CPUs that intel_pstate supports when HWP is absent
> from
> CPUID; that list ends at SKYLAKE_X.
> 
> An alternative approach to register intel_pstate in the case I'm
> describing
> would be to add ICELAKE_X (and every CPU model after that, forever?)
> to the
> list intel_pstate_cpu_ids.
This is not nice, but unlike client server CPUs don't get released
often. There is couple of years in between.

> 
> > It is possible that some user don't want to use HWP, because there
> > workloads works better without HWP. But that doesn't mean HWP is
> > broken.
> 
> That's true, a user may legitimate want to disable HWP, and we have
> the
> intel_pstate=no_hwp option for that. But for that option to work
> CPUID must
> still show that the CPU is HWP-capable; when disablement happens in
> BIOS, it's
> not the case.
Correct.

> 
> The wording "hwp_broken_firmware" deliberately has a negative
> connotation (the
> intended meaning is: "firmware is broken, regarding HWP"), carrying
> the
> not-so-subtle message "OEM folks, please don't do this". My
> understanding is
> that the preferred way to disable HWP is with intel_pstate=no_hwp,
> the
> firmware should stay out of it.
For me "broken" means that Intel has some bug, which is not the case,
even if the intention is to carry message to OEM.

no_hwp is for disabling HWP even if the HWP is supported.

The problem is that if we override the supported CPU list using some
kernel command line, some users may crash the system running on some
old hardware where some of the MSRs we rely are not present. We don't
read MSR in failsafe mode, so they will fault. We are checking some
MSRs but not all. Also what will be default struct pstate_funcs *)id-
>driver_data if the cpu model doesn't match.

I think better to add CPU model instead. We did that for SKX on user
requests.

Thanks,
Srinivas

> 
> I hope this clarifies the problem (there is an ICELAKE_X somewhere
> out there
> that can't load intel_pstate, which is not nice) and the intention
> (discouraging disablement of HWP via firmware).
> 
> 
> Giovanni
> 


