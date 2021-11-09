Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D344A9AD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 09:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbhKIIvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 03:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhKIIvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Nov 2021 03:51:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85115C061764;
        Tue,  9 Nov 2021 00:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GGuZB0RVdPrXN4n7lBWpU1GjFO22hMBYCHctpSGrxoU=; b=e/sSyCn6ln4c+tGO1J45vHh9fT
        yUEDqIbElO9i+rnIv0GsR9Tw1+hVZ/1MHgOCsWDnnwyZXgg/MmVEflUXifcolTv6B8eXOD55ckpXF
        QdZZCcgH8PWhM+JVmPhyQauv3rgLUpWLO/JucGxcgxBcYRAH7KpdGf8jjZ0ea7/BFhy7o29zgTJPn
        aEtWrgG277FhMr6if8djoZ59xQyvzOrGaCVDHgLsBCoRch+jy6QtN2ODysuxUIy0f4BjQBwMfWy1R
        j7u9+dGRhcSFxknF6RsNmJOQvggtpNxFWpnnMeRD95mq4o0OrGqhZNB2t8577LoMVogd5R9gHPQEC
        Qvedx83w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMnZ-00F1xD-KZ; Tue, 09 Nov 2021 08:48:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46C253001C7;
        Tue,  9 Nov 2021 09:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E449E206D9951; Tue,  9 Nov 2021 09:48:07 +0100 (CET)
Date:   Tue, 9 Nov 2021 09:48:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Message-ID: <YYo1x8YLozBZbqwC@hirez.programming.kicks-ass.net>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
 <YYjo3Jx6JosHhoHM@hirez.programming.kicks-ass.net>
 <20211109022613.GA16930@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109022613.GA16930@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 08, 2021 at 06:26:13PM -0800, Ricardo Neri wrote:
> On Mon, Nov 08, 2021 at 10:07:40AM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 05, 2021 at 06:33:10PM -0700, Ricardo Neri wrote:

> > > +static void hfi_update_work_fn(struct work_struct *work)
> > > +{
> > > +	struct hfi_instance *hfi_instance;
> > > +
> > > +	hfi_instance = container_of(to_delayed_work(work), struct hfi_instance,
> > > +				    update_work);
> > > +	if (!hfi_instance)
> > > +		return;
> > > +
> > > +	/* TODO: Consume update here. */
> > 
> > 	// this here uses ->event_lock to serialize against the
> > 	// interrupt below changing the data...
> 
> Anyone reading the HFI table would need to take ->event_lock.

Right.. that implies ->event_lock can be taken while there is no
interrupt active, which then necessitates the additional lock.

> > > +}
> > > +
> > > +void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> > > +{
> > > +	struct hfi_instance *hfi_instance;
> > > +	int cpu = smp_processor_id();
> > > +	struct hfi_cpu_info *info;
> > > +	unsigned long flags;
> > > +	u64 timestamp;
> > > +
> > > +	if (!pkg_therm_status_msr_val)
> > > +		return;
> > > +
> > > +	info = &per_cpu(hfi_cpu_info, cpu);
> > > +	if (!info)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * It is possible that we get an HFI thermal interrupt on this CPU
> > > +	 * before its HFI instance is initialized. This is not a problem. The
> > > +	 * CPU that enabled the interrupt for this package will also get the
> > > +	 * interrupt and is fully initialized.
> > > +	 */
> > > +	hfi_instance = info->hfi_instance;
> > > +	if (!hfi_instance)
> > > +		return;
> > > +
> > 
> > 	/*
> > 	 * If someone is already handling the interrupt, we shouldn't be
> > 	 * burning time waiting for them to then do more nothing.
> > 	 */
> > 	if (!raw_spin_trylock(&hfi_instance->interrupt_lock))
> > 		return;
> > 
> > 
> > > +	raw_spin_lock_irqsave(&hfi_instance->event_lock, flags);
> 
> The CPU who acquired ->interrupt_lock successfully now will acquire
> ->event_lock to serialize writes and reads to the HFI table.

Right, so ->interrupt_lock is purely used to serialize interrupts, and
only one interrupt gets to do the update, while the others can exit and
resume with what they were doing asap, without wasting cycles spinning
on ->event_lock only to then not do anything.

> > > +	/*
> > > +	 * On most systems, all CPUs in the package receive a package-level
> > > +	 * thermal interrupt when there is an HFI update. Since they all are
> > > +	 * dealing with the same update (as indicated by the update timestamp),
> > > +	 * it is sufficient to let a single CPU to acknowledge the update and
> > > +	 * schedule work to process it.
> > > +	 */
> > > +	timestamp = *(u64 *)hfi_instance->hw_table;
> > > +	if (hfi_instance->timestamp >= timestamp)
> > > +		goto unlock_spinlock;
> > 
> > This can go the way of the dodo.
> 
> (I guess I can still check the timestamp in case buggy firmware triggers
> updates with the same timestamp, right?)

Sure..

> > 
> > > +
> > > +	hfi_instance->timestamp = timestamp;
> > > +
> > > +	memcpy(hfi_instance->table_base, hfi_instance->hw_table,
> > > +	       hfi_features.nr_table_pages << PAGE_SHIFT);

I think we actually need to release ->interrupt_lock here, *before* the
WRMSR that ACKs the HFI update. Because I think the moment that WRMSR
goes through we can get another interrupt, and that *must* not find
->interrupt_lock taken, otherwise it will not process the update etc..
leading to lost interrupts.

> > > +	/*
> > > +	 * Let hardware and other CPUs know that we are done reading the HFI
> > > +	 * table and it is free to update it again.
> > > +	 */
> > > +	pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
> > > +				    ~PACKAGE_THERM_STATUS_HFI_UPDATED;
> > > +	wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, pkg_therm_status_msr_val);
> > > +	schedule_delayed_work(&hfi_instance->update_work, HFI_UPDATE_INTERVAL);
> > > +
> > > +unlock_spinlock:
> > > +	raw_spin_unlock_irqrestore(&hfi_instance->event_lock, flags);
> > 
> > 	raw_spin_unlock(&hfi_instance->interrupt_lock);
> 
> ... and here we release both locks.

See above.
