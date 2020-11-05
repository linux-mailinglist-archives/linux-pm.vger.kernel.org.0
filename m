Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D82A8459
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgKERAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 12:00:45 -0500
Received: from foss.arm.com ([217.140.110.172]:37504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgKERAp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 12:00:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EC5D142F;
        Thu,  5 Nov 2020 09:00:45 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A80833F719;
        Thu,  5 Nov 2020 09:00:44 -0800 (PST)
Date:   Thu, 5 Nov 2020 17:00:43 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com, morten.rasmussen@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] cppc_cpufreq: replace per-cpu structures with lists
Message-ID: <20201105170043.GA28398@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-5-ionela.voinescu@arm.com>
 <e568847d-b15c-970c-6ad5-b431c81c811c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e568847d-b15c-970c-6ad5-b431c81c811c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jeremy,

On Thursday 05 Nov 2020 at 09:50:30 (-0600), Jeremy Linton wrote:
> Hi,
> 
> On 11/5/20 6:55 AM, Ionela Voinescu wrote:
> > The cppc_cpudata per-cpu storage was inefficient (1) additional to causing
> > functional issues (2) when CPUs are hotplugged out, due to per-cpu data
> > being improperly initialised.
> > 
> > (1) The amount of information needed for CPPC performance control in its
> >      cpufreq driver depends on the domain (PSD) coordination type:
> > 
> >      ANY:    One set of CPPC control and capability data (e.g desired
> >              performance, highest/lowest performance, etc) applies to all
> >              CPUs in the domain.
> > 
> >      ALL:    Same as ANY. To be noted that this type is not currently
> >              supported. When supported, information about which CPUs
> >              belong to a domain is needed in order for frequency change
> >              requests to be sent to each of them.
> > 
> >      HW:     It's necessary to store CPPC control and capability
> >              information for all the CPUs. HW will then coordinate the
> >              performance state based on their limitations and requests.
> > 
> >      NONE:   Same as HW. No HW coordination is expected.
> > 
> >      Despite this, the previous initialisation code would indiscriminately
> >      allocate memory for all CPUs (all_cpu_data) and unnecessarily
> >      duplicate performance capabilities and the domain sharing mask and type
> >      for each possible CPU.
> 
> I should have mentioned this on the last set.
> 
> If the common case on arm/acpi machines is a single core per _PSD (which I
> believe it is), then you are actually increasing the overhead doing this.
> 

Thanks for taking another look and pointing this out.

Yes, that would be quite inefficient as I'd be holding both CPU and domain
information uselessly, for that case. I could drop the domain
information without actually losing anything (shared type and shared cpu
map have no purpose for single CPUs in a domain).

Also, I don't actually need a list of CPUs in the domain, an array will
work just as well, as I know the number of CPUs when I allocate the
domain - that will allow me to remove the node from cppc_cpudata and
save me some pointers.

Also, I now remember I wanted to get rid of cpu and cur_policy from
cppc_cpudata as well, as they serve no purpose. Let me know if you guys
see a reason against this.

All of this should at least bring things on par for HW and NONE types,
while improving ANY and ALL types. Thanks again for bringing this up.

Regards,
Ionela.
