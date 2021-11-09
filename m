Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFB44AE1F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 13:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbhKIM5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 07:57:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:15258 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237847AbhKIM5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 07:57:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232682281"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="232682281"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 04:54:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="503491344"
Received: from na1-mobl.gar.corp.intel.com ([10.213.108.242])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 04:54:12 -0800
Message-ID: <a69360a65739ba068ff21e266638c41aeb936870.camel@linux.intel.com>
Subject: Re: [PATCH 5/7] thermal: intel: hfi: Enable notification interrupt
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Nov 2021 04:54:08 -0800
In-Reply-To: <YYo1x8YLozBZbqwC@hirez.programming.kicks-ass.net>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
         <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
         <YYjo3Jx6JosHhoHM@hirez.programming.kicks-ass.net>
         <20211109022613.GA16930@ranerica-svr.sc.intel.com>
         <YYo1x8YLozBZbqwC@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-11-09 at 09:48 +0100, Peter Zijlstra wrote:
> On Mon, Nov 08, 2021 at 06:26:13PM -0800, Ricardo Neri wrote:
> > On Mon, Nov 08, 2021 at 10:07:40AM +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 05, 2021 at 06:33:10PM -0700, Ricardo Neri wrote:
> 
> > > > +static void hfi_update_work_fn(struct work_struct *work)
> > > > +{
> > > > +       struct hfi_instance *hfi_instance;
> > > > +
> > > > +       hfi_instance = container_of(to_delayed_work(work),
> > > > struct hfi_instance,
> > > > +                                   update_work);
> > > > +       if (!hfi_instance)
> > > > +               return;
> > > > +
> > > > +       /* TODO: Consume update here. */
> > > 
> > >         // this here uses ->event_lock to serialize against the
> > >         // interrupt below changing the data...
> > 
> > Anyone reading the HFI table would need to take ->event_lock.
> 
> Right.. that implies ->event_lock can be taken while there is no
> interrupt active, which then necessitates the additional lock.
> 
Correct.
With the raw_spin_trylock() optimization, we will need additional lock.
So need another lock to protect hfi_instance->table_base.

> > > > +}
> > > > +
> > > > +void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> > > > +{
> > > > +       struct hfi_instance *hfi_instance;
> > > > +       int cpu = smp_processor_id();
> > > > +       struct hfi_cpu_info *info;
> > > > +       unsigned long flags;
> > > > +       u64 timestamp;
> > > > +
> > > > +       if (!pkg_therm_status_msr_val)
> > > > +               return;
> > > > +
> > > > +       info = &per_cpu(hfi_cpu_info, cpu);
> > > > +       if (!info)
> > > > +               return;
> > > > 

[...]

> > > > +       memcpy(hfi_instance->table_base, hfi_instance-
> > > > >hw_table,
> > > > +              hfi_features.nr_table_pages << PAGE_SHIFT);
> 
> I think we actually need to release ->interrupt_lock here, *before*
> the
> WRMSR that ACKs the HFI update. Because I think the moment that WRMSR
> goes through we can get another interrupt, and that *must* not find
> ->interrupt_lock taken, otherwise it will not process the update
> etc..
> leading to lost interrupts.

Correct.
Once we use raw_spin_trylock() change suggested above, then we need to
release lock here.

Thanks,
Srinivas

> 

> > > > +       /*
> > > > +        * Let hardware and other CPUs know that we are done
> > > > reading the HFI
> > > > +        * table and it is free to update it again.
> > > > +        */
> > > > +       pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK
> > > > &
> > > > +                                  
> > > > ~PACKAGE_THERM_STATUS_HFI_UPDATED;
> > > > +       wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
> > > > pkg_therm_status_msr_val);
> > > > +       schedule_delayed_work(&hfi_instance->update_work,
> > > > HFI_UPDATE_INTERVAL);
> > > > +
> > > > +unlock_spinlock:
> > > > +       raw_spin_unlock_irqrestore(&hfi_instance->event_lock,
> > > > flags);
> > > 
> > >         raw_spin_unlock(&hfi_instance->interrupt_lock);
> > 
> > ... and here we release both locks.
> 
> See above.


