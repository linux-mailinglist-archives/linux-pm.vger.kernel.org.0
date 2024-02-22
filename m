Return-Path: <linux-pm+bounces-4287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FDB85FE7D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 17:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF11F28297
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921C154C14;
	Thu, 22 Feb 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsAYKguc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72B153BC9;
	Thu, 22 Feb 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620810; cv=none; b=o1XUrtn4IOj5ONruiW8/9DMfrH1UmgtLfgbV9fnFmbc7Cwg07ebO4OieRfiAHdPH4HZsj1u+E0BJudyZULu8m2bQ0OBpKpVOgKDluzhGKszwuAYDVW7L4TxFsOwzn5pMgnilfDkvH0e5S/e7FdUUG5ydJtYxvaSr7oShhDJNMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620810; c=relaxed/simple;
	bh=GgB+0sR+hVs/OpW1fVcFMH3VWjcA3C9BjntTmlpSW5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7bizM0hXDyuduaKvn2ntUT9aHq+HnUI+BiwsIbhonCKr5tNedGp1TVni8tCZB2ElUv7Z31URnNenKzqfQGA2XllCb/g2XipoDukAORUssc8T57qcIbr4qKetr/64cG4/sK5oNPK0qKDGRT6FTe3ro0L+HNFxQBdz+mFvuAYtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsAYKguc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708620808; x=1740156808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GgB+0sR+hVs/OpW1fVcFMH3VWjcA3C9BjntTmlpSW5w=;
  b=OsAYKguc32xbp+GXovAD25ZtSLVZpmnbvZkv+58q12K1nvuYF9MwOiVm
   JzuEu0aTOUOzixFRPb8O7xQTIrBol/Q7HtQXM9YrPx4drhRYgmaTVa+f+
   CkIm7xZdJxvLmv8EDyOVXc6Vk7kY/+RGnITQrljBziZv02jnBtqeQThCI
   1N4Hz+Ckwf9qCvj8vohWfE87mZKVFszhp+PkMFzyRJbJa1yJyTpARoanH
   uQUwiC9sgM6CKKDJwyQgv94bc6PENgz+KKlx3njMv0gwux4pCZNuLXzjg
   L+gZr0wNAu+7yOzPkJsbSxvDwJK7Y9hLIMYnTQHPCgFZPR2xqQ9HbFKcn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6639348"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6639348"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10126866"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.46.166])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:53:24 -0800
Date: Thu, 22 Feb 2024 17:53:21 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 3/3] thermal: intel: hfi: Enable interface only when
 required
Message-ID: <Zdd8AT5+6oLX4eCk@linux.intel.com>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
 <20240212161615.161935-4-stanislaw.gruszka@linux.intel.com>
 <CAJZ5v0jr4Z=ffm9E+eR7p7rQwbCWEP=YHxNbR9VAEwb8-3e3GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jr4Z=ffm9E+eR7p7rQwbCWEP=YHxNbR9VAEwb8-3e3GA@mail.gmail.com>

On Tue, Feb 13, 2024 at 02:59:10PM +0100, Rafael J. Wysocki wrote:
> > -static void hfi_do_enable(void)
> > +/*
> > + * HFI enable/disable run in non-concurrent manner on boot CPU in syscore
> > + * callbacks or under protection of hfi_instance_lock.
> > + */
> 
> In the comment above I would say "If concurrency is not prevented by
> other means, the HFI enable/disable routines must be called under
> hfi_instance_lock." 

Ok. Will reword this way.

> and I would retain the comments below (they don't
> hurt IMO).

I found those comments somewhat confusing. FWICT at worst
what can happen when enable/resume race CPU online and
disable/suspend race with CPU offline is enable twice
or disable twice. What I think is fine, though plan to
check this (see below).

> > +static void hfi_do_enable(void *ptr)
> 
> I would call this hfi_enable_instance().
> 
> > +{
> > +       struct hfi_instance *hfi_instance = ptr;
> 
> Why is this variable needed ro even useful?  prt can be passed
> directly to hfi_set_hw_table().

Ok, will remove it.

> > +
> > +       hfi_set_hw_table(hfi_instance);
> > +       hfi_enable();
> > +}
> > +
> > +static void hfi_do_disable(void *ptr)
> 
> And I'd call this hfi_disable_instance().

Ok.

> > +static int hfi_thermal_notify(struct notifier_block *nb, unsigned long state,
> > +                             void *_notify)
> > +{
> > +       struct thermal_genl_notify *notify = _notify;
> > +       struct hfi_instance *hfi_instance;
> > +       smp_call_func_t func;
> > +       unsigned int cpu;
> > +       int i;
> > +
> > +       if (notify->mcgrp != THERMAL_GENL_EVENT_GROUP)
> > +               return NOTIFY_DONE;
> > +
> > +       if (state != THERMAL_NOTIFY_BIND && state != THERMAL_NOTIFY_UNBIND)
> > +               return NOTIFY_DONE;
> > +
> > +       mutex_lock(&hfi_instance_lock);
> > +
> > +       switch (state) {
> > +       case THERMAL_NOTIFY_BIND:
> > +               hfi_thermal_clients_num++;
> > +               break;
> > +
> > +       case THERMAL_NOTIFY_UNBIND:
> > +               hfi_thermal_clients_num--;
> > +               break;
> > +       }
> > +
> > +       if (hfi_thermal_clients_num > 0)
> > +               func = hfi_do_enable;
> > +       else
> > +               func = hfi_do_disable;
> > +
> > +       for (i = 0; i < max_hfi_instances; i++) {
> > +               hfi_instance = &hfi_instances[i];
> > +               if (cpumask_empty(hfi_instance->cpus))
> > +                       continue;
> > +
> > +               cpu = cpumask_any(hfi_instance->cpus);
> > +               smp_call_function_single(cpu, func, hfi_instance, true);
> > +       }
> > +
> > +       mutex_unlock(&hfi_instance_lock);
> 
> So AFAICS, one instance can be enabled multiple times because of this.
>   I guess that's OK?  In any case, it would be kind of nice to leave a
> note regarding it somewhere here.

It's write the same values to the same registers. So I think this 
should be fine. However after your comment I start to think there
perhaps could be some side-effect of writing the registers.
I'll double check (previously I verified that double enable works,
but only on MTL) or eventually rearrange code to do not enable already
enabled interface.

> > +
> > +       return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block hfi_thermal_nb = {
> > +       .notifier_call = hfi_thermal_notify,
> >  };
> >
> >  void __init intel_hfi_init(void)
> > @@ -628,10 +697,16 @@ void __init intel_hfi_init(void)
> >         if (!hfi_updates_wq)
> >                 goto err_nomem;
> >
> > +       if (thermal_genl_register_notifier(&hfi_thermal_nb))
> > +               goto err_nl_notif;
> 
> Is it possible for any clients to be there before the notifier is
> registered?  If not, it would be good to add a comment about it.

HFI is build-in so it's started before any user space. I added note about that
in the cover letter but indeed it should be comment in the code. Will fix.  

Regards
Stanislaw

