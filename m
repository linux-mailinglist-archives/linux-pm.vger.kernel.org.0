Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7166A37F55A
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhEMKLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 06:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhEMKLP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 06:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F941AFF6;
        Thu, 13 May 2021 10:10:05 +0000 (UTC)
Message-ID: <bb90b6cac2f4adcc6c80b7fddf54dbe0a6b8ff66.camel@suse.cz>
Subject: Re: [PATCH] cpufreq: intel_pstate: Force intel_pstate to load when
 HWP disabled in firmware
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 12:10:04 +0200
In-Reply-To: <3fdc70c267d40561bed10fc722a8223a0b161200.camel@linux.intel.com>
References: <20210513075930.22657-1-ggherdovich@suse.cz>
         <3fdc70c267d40561bed10fc722a8223a0b161200.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-05-13 at 02:24 -0700, Srinivas Pandruvada wrote:
> On Thu, 2021-05-13 at 09:59 +0200, Giovanni Gherdovich wrote:
> > On CPUs succeeding SKX, eg. ICELAKE_X, intel_pstate doesn't load
> > unless
> > CPUID advertises support for the HWP feature. Some OEMs, however, may
> > offer
> > users the possibility to disable HWP from the BIOS config utility by
> > altering the output of CPUID.
>
> Is someone providing a utility? What is the case for broken HWP?

Yes, I know of at least one server manufacturer that ships a BIOS config
utility where the user can disable HWP.

On such server machine, which has an ICELAKE_X CPU, if the user unchecks HWP
via BIOS then intel_pstate will refuse to load saying:

    intel_pstate: CPU model not supported

because ICELAKE_X is not in the list intel_pstate_cpu_ids (defined in
intel_pstate.c) of CPUs that intel_pstate supports when HWP is absent from
CPUID; that list ends at SKYLAKE_X.

An alternative approach to register intel_pstate in the case I'm describing
would be to add ICELAKE_X (and every CPU model after that, forever?) to the
list intel_pstate_cpu_ids.

> It is possible that some user don't want to use HWP, because there
> workloads works better without HWP. But that doesn't mean HWP is
> broken.

That's true, a user may legitimate want to disable HWP, and we have the
intel_pstate=no_hwp option for that. But for that option to work CPUID must
still show that the CPU is HWP-capable; when disablement happens in BIOS, it's
not the case.

The wording "hwp_broken_firmware" deliberately has a negative connotation (the
intended meaning is: "firmware is broken, regarding HWP"), carrying the
not-so-subtle message "OEM folks, please don't do this". My understanding is
that the preferred way to disable HWP is with intel_pstate=no_hwp, the
firmware should stay out of it.

I hope this clarifies the problem (there is an ICELAKE_X somewhere out there
that can't load intel_pstate, which is not nice) and the intention
(discouraging disablement of HWP via firmware).


Giovanni

