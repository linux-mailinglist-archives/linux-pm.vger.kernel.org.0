Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADD44A4C5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 03:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhKICay (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 21:30:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:16061 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhKICav (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 21:30:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232311894"
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="232311894"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 18:27:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,219,1631602800"; 
   d="scan'208";a="451708892"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2021 18:26:59 -0800
Date:   Mon, 8 Nov 2021 18:26:13 -0800
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
Subject: Re: [PATCH 5/7] thermal: intel: hfi: Enable notification interrupt
Message-ID: <20211109022613.GA16930@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
 <YYjo3Jx6JosHhoHM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYjo3Jx6JosHhoHM@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 08, 2021 at 10:07:40AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 05, 2021 at 06:33:10PM -0700, Ricardo Neri wrote:
> 
> > @@ -72,6 +78,9 @@ struct hfi_instance {
> >  	u16			die_id;
> >  	struct cpumask		*cpus;
> >  	void			*hw_table;
> > +	struct delayed_work	update_work;
> > +	raw_spinlock_t		event_lock;
>   +	raw_spinlock_t		interrupt_lock;

Thank you very much for your feedback Peter!

I would like to confirm that I understand your feedback correctly: you are
suggesting to use to spinlocks...


> > +	u64			timestamp;
> >  	bool			initialized;
> >  };
> >  
> > @@ -114,6 +123,75 @@ static struct hfi_instance *hfi_instances;
> >  static struct hfi_features hfi_features;
> >  static DEFINE_MUTEX(hfi_lock);
> >  
> > +#define HFI_UPDATE_INTERVAL	HZ
> > +
> > +static void hfi_update_work_fn(struct work_struct *work)
> > +{
> > +	struct hfi_instance *hfi_instance;
> > +
> > +	hfi_instance = container_of(to_delayed_work(work), struct hfi_instance,
> > +				    update_work);
> > +	if (!hfi_instance)
> > +		return;
> > +
> > +	/* TODO: Consume update here. */
> 
> 	// this here uses ->event_lock to serialize against the
> 	// interrupt below changing the data...

Anyone reading the HFI table would need to take ->event_lock.

> 
> > +}
> > +
> > +void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> > +{
> > +	struct hfi_instance *hfi_instance;
> > +	int cpu = smp_processor_id();
> > +	struct hfi_cpu_info *info;
> > +	unsigned long flags;
> > +	u64 timestamp;
> > +
> > +	if (!pkg_therm_status_msr_val)
> > +		return;
> > +
> > +	info = &per_cpu(hfi_cpu_info, cpu);
> > +	if (!info)
> > +		return;
> > +
> > +	/*
> > +	 * It is possible that we get an HFI thermal interrupt on this CPU
> > +	 * before its HFI instance is initialized. This is not a problem. The
> > +	 * CPU that enabled the interrupt for this package will also get the
> > +	 * interrupt and is fully initialized.
> > +	 */
> > +	hfi_instance = info->hfi_instance;
> > +	if (!hfi_instance)
> > +		return;
> > +
> 
> 	/*
> 	 * If someone is already handling the interrupt, we shouldn't be
> 	 * burning time waiting for them to then do more nothing.
> 	 */
> 	if (!raw_spin_trylock(&hfi_instance->interrupt_lock))
> 		return;
> 
> 
> > +	raw_spin_lock_irqsave(&hfi_instance->event_lock, flags);

The CPU who acquired ->interrupt_lock successfully now will acquire
->event_lock to serialize writes and reads to the HFI table.

> > +
> > +	/*
> > +	 * On most systems, all CPUs in the package receive a package-level
> > +	 * thermal interrupt when there is an HFI update. Since they all are
> > +	 * dealing with the same update (as indicated by the update timestamp),
> > +	 * it is sufficient to let a single CPU to acknowledge the update and
> > +	 * schedule work to process it.
> > +	 */
> > +	timestamp = *(u64 *)hfi_instance->hw_table;
> > +	if (hfi_instance->timestamp >= timestamp)
> > +		goto unlock_spinlock;
> 
> This can go the way of the dodo.

(I guess I can still check the timestamp in case buggy firmware triggers
updates with the same timestamp, right?)

> 
> > +
> > +	hfi_instance->timestamp = timestamp;
> > +
> > +	memcpy(hfi_instance->table_base, hfi_instance->hw_table,
> > +	       hfi_features.nr_table_pages << PAGE_SHIFT);
> > +	/*
> > +	 * Let hardware and other CPUs know that we are done reading the HFI
> > +	 * table and it is free to update it again.
> > +	 */
> > +	pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
> > +				    ~PACKAGE_THERM_STATUS_HFI_UPDATED;
> > +	wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, pkg_therm_status_msr_val);
> > +	schedule_delayed_work(&hfi_instance->update_work, HFI_UPDATE_INTERVAL);
> > +
> > +unlock_spinlock:
> > +	raw_spin_unlock_irqrestore(&hfi_instance->event_lock, flags);
> 
> 	raw_spin_unlock(&hfi_instance->interrupt_lock);

... and here we release both locks.

Thanks and BR,
Ricardo
