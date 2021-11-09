Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38244A4C9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 03:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhKICcV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 21:32:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:24758 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhKICcV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 21:32:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="293197374"
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="293197374"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 18:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="491476852"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2021 18:29:27 -0800
Date:   Mon, 8 Nov 2021 18:28:41 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
Message-ID: <20211109022841.GB16930@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-4-ricardo.neri-calderon@linux.intel.com>
 <YYjkOkFmDG9IMPHu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYjkOkFmDG9IMPHu@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 08, 2021 at 09:47:54AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 05, 2021 at 06:33:08PM -0700, Ricardo Neri wrote:
> > +static __init int hfi_parse_features(void)
> > +{
> > +	unsigned int nr_capabilities, reg;
> > +
> 
> > +	/*
> > +	 * If we are here we know that CPUID_HFI_LEAF exists. Parse the
> > +	 * supported capabilities and the size of the HFI table.
> > +	 */
> > +	reg = cpuid_edx(CPUID_HFI_LEAF);
> > +
> > +	hfi_features.capabilities = reg & HFI_CAPABILITIES_MASK;
> > +	if (!(hfi_features.capabilities & HFI_CAPABILITIES_PERFORMANCE)) {
> > +		pr_err("Performance reporting not supported! Not using HFI\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* The number of 4KB pages required by the table */
> > +	hfi_features.nr_table_pages = ((reg & CPUID_HFI_TABLE_SIZE_MASK) >>
> > +				      CPUID_HFI_TABLE_SIZE_SHIFT) + 1;
> > +
> 
> > +/* Hardware Feedback Interface Enumeration */
> > +#define CPUID_HFI_LEAF			6
> > +#define CPUID_HFI_CAP_MASK		0xff
> > +#define CPUID_HFI_TABLE_SIZE_MASK	0x0f00
> > +#define CPUID_HFI_TABLE_SIZE_SHIFT	8
> > +#define CPUID_HFI_CPU_INDEX_MASK	0xffff0000
> 
> Also, *if* you're going to do something like this, then at least write
> out the masks in full so you can easily see how they relate. The above
> is crap.
> 
> > +#define CPUID_HFI_CPU_INDEX_SHIFT	16
> > +
> > +/* Hardware Feedback Interface Pointer */
> > +#define HFI_PTR_VALID_BIT		BIT(0)
> > +#define HFI_PTR_ADDR_SHIFT		12
> > +
> > +/* Hardware Feedback Interface Configuration */
> > +#define HFI_CONFIG_ENABLE_BIT		BIT(0)
> > +
> > +/* Hardware Feedback Interface Capabilities */
> > +#define HFI_CAPABILITIES_MASK		0xff
> > +#define HFI_CAPABILITIES_NR		8
> > +#define HFI_CAPABILITIES_PERFORMANCE	BIT(0)
> > +#define HFI_CAPABILITIES_ENERGY_EFF	BIT(1)
> 
> 
> So personally I prefer a bitfield union a-la cpuid10_eax, cpuid10_ebx
> cpuid10_edx etc.. Barring that, the above can also be written more
> concise using FIELD_GET() from bitfields.
> 
> union cpuid6_edx {
> 	struct {
> 		unsigned int capabilities :  8;
> 		unsigned int table_size   :  4;
> 		unsigned int __reserved   :  4;
> 		unsigned int cpu_index    : 16;
> 	};
> 	unsigned int full;
> };

Sure Peter. This looks more readable. I'll implement it like this.

Thanks and BR,
Ricardo
