Return-Path: <linux-pm+bounces-3237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC4784712C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 14:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93A928527C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D96B46448;
	Fri,  2 Feb 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNwaRQEp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875F47772;
	Fri,  2 Feb 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880610; cv=none; b=nGVsZeWLmx5EDloBOoCBfcxhoo6bYT2lo3RIEVnuCj0fzK5gpEyePWG8Hl3hZHtHcoDquOqLVzqHmVGfrY4xxaryY3t4+iCAFXuzWitXK82JfQsc/3jRugY1E0UGXrdrT9NVJwOrEQDi5zp834yIf+VZTaz52sQ2hnZh3N8cIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880610; c=relaxed/simple;
	bh=dakj+8/YDKrgFqMkE8JqXt+7c3Xphn1UZs2Lv3Mv6RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIzOmpC8WbJqoUtwKLw9OdoRuDl3ZixZM2eYy15YIGQvk//2ZDlW2fV2aJZeyj1mprD241quhkIaFZ/5rpR6oKjFZTMctGtlHZ+5Rs8JSF0JP6WJG9qVZUQ7yf2o3f01HpMXI9VO8bbccf3ZfpgaGpf+b7Ft5kntca0Qo8H+EaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNwaRQEp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706880608; x=1738416608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dakj+8/YDKrgFqMkE8JqXt+7c3Xphn1UZs2Lv3Mv6RI=;
  b=UNwaRQEp7JzUXzhNrQY5YSHA8R4hY0OZE20aF35fe+lqbP5wBiU9ulfI
   Y4YqGZZ3xZ91tl5IXdjkZDei8Sqm8bmvIIoIPRT9j6yk7vpWs5YhCl8x0
   wKaggY8HVdyMzQcxgyXxAJr133etuglqjC4KZZGiM02G0CDHN6ZCF2Pz5
   wzTAaCrZWIyO4oDTfGP3ys/RfdZZUGHswSpP92lrUljvha7t741wDkJPv
   UHDZc/3beuhnQ1dHYdZH7+sZE9MulS6e4lqd4lEIxA7K9Vs3iVGAb4hDf
   KEzRUPYmgdxZwE8gZLXjgBQ3i9hWxy+YJvTyh7K7gE0PKOJLeqo7AnhYm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="66956"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="66956"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:30:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4824879"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.157])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:30:05 -0800
Date: Fri, 2 Feb 2024 14:00:46 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: intel: hfi: Enable interface only when
 required
Message-ID: <Zbznft0x7DRWjUTQ@linux.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
 <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
 <ZbzhuXbuejM1VLE3@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbzhuXbuejM1VLE3@nanopsycho>

On Fri, Feb 02, 2024 at 01:36:09PM +0100, Jiri Pirko wrote:
> Wed, Jan 31, 2024 at 01:05:35PM CET, stanislaw.gruszka@linux.intel.com wrote:
> 
> [...]
> 
> 
> >+static int hfi_netlink_notify(struct notifier_block *nb, unsigned long state,
> >+			      void *_notify)
> >+{
> >+	struct netlink_notify *notify = _notify;
> >+	struct hfi_instance *hfi_instance;
> >+	smp_call_func_t func;
> >+	unsigned int cpu;
> >+	int i;
> >+
> >+	if (notify->protocol != NETLINK_GENERIC)
> >+		return NOTIFY_DONE;
> >+
> >+	switch (state) {
> >+	case NETLINK_CHANGE:
> >+	case NETLINK_URELEASE:
> >+		mutex_lock(&hfi_instance_lock);
> >+
> 
> What's stopping other thread from mangling the listeners here?

Nothing. But if the listeners will be changed, we will get next notify.
Serialization by the mutex is needed to assure that the last setting will win,
so we do not end with HFI disabled when there are listeners or vice versa.

> >+		if (thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
> >+			func = hfi_do_enable;
> >+		else
> >+			func = hfi_do_disable;
> >+
> >+		for (i = 0; i < max_hfi_instances; i++) {
> >+			hfi_instance = &hfi_instances[i];
> >+			if (cpumask_empty(hfi_instance->cpus))
> >+				continue;
> >+
> >+			cpu = cpumask_any(hfi_instance->cpus);
> >+			smp_call_function_single(cpu, func, hfi_instance, true);
> >+		}
> >+
> >+		mutex_unlock(&hfi_instance_lock);
> >+		return NOTIFY_OK;
> >+	}
> >+
> >+	return NOTIFY_DONE;
> >+}
> 
> [...]

