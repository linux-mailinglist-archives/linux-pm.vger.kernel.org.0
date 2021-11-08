Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D30447C8E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 10:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbhKHJNC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 04:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhKHJNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 04:13:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A94C061570;
        Mon,  8 Nov 2021 01:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6kFwcxFlghaveiSSQY0wrstHS8UlMyex4OH/fX8J/BQ=; b=jDNtCcjnm19Ux79R+GQy7jB/Ut
        7Jy3g2lSySdPVWvnZxpKQHxMgM2eIHLN8KqxNyqEklBY95MhpvZlK++YZQyNOmscDhGm6aHZ1Fut/
        t3izt9PtdNSXY0aKQ7LAeAzi9AaRzJlqzot7DVwYw8alZRnSuS7YMMgRs2o5ZgIcehefGBEFIEknP
        mHt1DquJ8BeVb1ttIu2iYkuq6NcFmwTt9OdWfY4M6udiaoWrteORaju3BnDXfCOZPwWxACwOZsEBY
        Row4Zd62arpJ6SNnn9r4kaCUEFUqfCq1p5Mrtejzp7EGqUjuDE2ZgJDCyC3xekLWfJUr3us1vRw3E
        8AhuiPIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk0cv-008Ihl-RE; Mon, 08 Nov 2021 09:08:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D99183000A3;
        Mon,  8 Nov 2021 10:07:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0F012671B8AF; Mon,  8 Nov 2021 10:07:40 +0100 (CET)
Date:   Mon, 8 Nov 2021 10:07:40 +0100
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
Message-ID: <YYjo3Jx6JosHhoHM@hirez.programming.kicks-ass.net>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 05, 2021 at 06:33:10PM -0700, Ricardo Neri wrote:

> @@ -72,6 +78,9 @@ struct hfi_instance {
>  	u16			die_id;
>  	struct cpumask		*cpus;
>  	void			*hw_table;
> +	struct delayed_work	update_work;
> +	raw_spinlock_t		event_lock;
  +	raw_spinlock_t		interrupt_lock;
> +	u64			timestamp;
>  	bool			initialized;
>  };
>  
> @@ -114,6 +123,75 @@ static struct hfi_instance *hfi_instances;
>  static struct hfi_features hfi_features;
>  static DEFINE_MUTEX(hfi_lock);
>  
> +#define HFI_UPDATE_INTERVAL	HZ
> +
> +static void hfi_update_work_fn(struct work_struct *work)
> +{
> +	struct hfi_instance *hfi_instance;
> +
> +	hfi_instance = container_of(to_delayed_work(work), struct hfi_instance,
> +				    update_work);
> +	if (!hfi_instance)
> +		return;
> +
> +	/* TODO: Consume update here. */

	// this here uses ->event_lock to serialize against the
	// interrupt below changing the data...

> +}
> +
> +void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> +{
> +	struct hfi_instance *hfi_instance;
> +	int cpu = smp_processor_id();
> +	struct hfi_cpu_info *info;
> +	unsigned long flags;
> +	u64 timestamp;
> +
> +	if (!pkg_therm_status_msr_val)
> +		return;
> +
> +	info = &per_cpu(hfi_cpu_info, cpu);
> +	if (!info)
> +		return;
> +
> +	/*
> +	 * It is possible that we get an HFI thermal interrupt on this CPU
> +	 * before its HFI instance is initialized. This is not a problem. The
> +	 * CPU that enabled the interrupt for this package will also get the
> +	 * interrupt and is fully initialized.
> +	 */
> +	hfi_instance = info->hfi_instance;
> +	if (!hfi_instance)
> +		return;
> +

	/*
	 * If someone is already handling the interrupt, we shouldn't be
	 * burning time waiting for them to then do more nothing.
	 */
	if (!raw_spin_trylock(&hfi_instance->interrupt_lock))
		return;


> +	raw_spin_lock_irqsave(&hfi_instance->event_lock, flags);
> +
> +	/*
> +	 * On most systems, all CPUs in the package receive a package-level
> +	 * thermal interrupt when there is an HFI update. Since they all are
> +	 * dealing with the same update (as indicated by the update timestamp),
> +	 * it is sufficient to let a single CPU to acknowledge the update and
> +	 * schedule work to process it.
> +	 */
> +	timestamp = *(u64 *)hfi_instance->hw_table;
> +	if (hfi_instance->timestamp >= timestamp)
> +		goto unlock_spinlock;

This can go the way of the dodo.

> +
> +	hfi_instance->timestamp = timestamp;
> +
> +	memcpy(hfi_instance->table_base, hfi_instance->hw_table,
> +	       hfi_features.nr_table_pages << PAGE_SHIFT);
> +	/*
> +	 * Let hardware and other CPUs know that we are done reading the HFI
> +	 * table and it is free to update it again.
> +	 */
> +	pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
> +				    ~PACKAGE_THERM_STATUS_HFI_UPDATED;
> +	wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, pkg_therm_status_msr_val);
> +	schedule_delayed_work(&hfi_instance->update_work, HFI_UPDATE_INTERVAL);
> +
> +unlock_spinlock:
> +	raw_spin_unlock_irqrestore(&hfi_instance->event_lock, flags);

	raw_spin_unlock(&hfi_instance->interrupt_lock);

> +}
