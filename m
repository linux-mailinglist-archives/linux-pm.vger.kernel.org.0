Return-Path: <linux-pm+bounces-43007-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPWdOD8WnGkq/gMAu9opvQ
	(envelope-from <linux-pm+bounces-43007-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:56:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6361517357D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D6383014766
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357D34DB52;
	Mon, 23 Feb 2026 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATXOXq1H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630E34DB7E;
	Mon, 23 Feb 2026 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836988; cv=none; b=B1tDSZn3Lbkveytk6PKDtDgfkQrmOPxugug389IeIec82tdYKBLhxoKRiSvWJEcZt9VeABIdiT36KAJGgBntWC8YSxgTFlANJIwjPOtsVsTl1osYiUcNv0rS5J6OIhuiT8tDzSjsI7TecvOR3g+3p+PvA/Yy9PrD7B3tAjl7FVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836988; c=relaxed/simple;
	bh=vTxb26YHC2bRnF15WcUVg9+N/0yuey9uzbRSyk1F6sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA9kB7o4HSJI/IjPDQFPwJ4B99NVjCIPUPKS2JNyNOlcUFIDmP9gEREAuI4m3Ns/zsp//kudJ5QLUV47ptHiNjVukTlxc0D42T6jsmgktbkevuQlOTv6c4U8BD6OzdDqVywdb6XvqPyBgpl99P64tKEHzWZ8Aiukgf001OkTIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATXOXq1H; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771836987; x=1803372987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vTxb26YHC2bRnF15WcUVg9+N/0yuey9uzbRSyk1F6sA=;
  b=ATXOXq1H1TOD6UVAt9Sf2dRR4dvxSkt4SyiUwtPGQXf6xP632Nnt0ScS
   u5kdpTD9t973BBI8IpdGrdWQY/u+gv4pJUpII+DCadhTkue2RWysLL4OK
   m7YVbwGT40WgY2VdXdLhCN3/TwE/ghgb2fPfJXPdqK6cHVIGnAL4454/Y
   //KmCTUUusHWpGhcXKVvZpBSAo+3aivVCYi6IxYBfL+oFCTmfNJ8wVEDM
   dWV6C457DQSsNa1+4VRO7EmS0D2qrF597aM2aVi3Yi1YImYQ8yYJYM1FX
   C4NdUsvRtsaj8IOS8OQOWpHzhERg8Mpvbg0gg2WphVHQtrNhGlLcW8Rxr
   A==;
X-CSE-ConnectionGUID: yRDa/9+5RX+naFRNWs6prw==
X-CSE-MsgGUID: dotElPPDTDK9kTYnPEIzvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="95443372"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="95443372"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:56:26 -0800
X-CSE-ConnectionGUID: ChybxgAWQCaFwtRmsXad8A==
X-CSE-MsgGUID: weYH3rz0QoGnqBoexHAGNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="214581172"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:56:21 -0800
Date: Mon, 23 Feb 2026 10:56:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, driver-core@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH 1/9] workqueue: devres: Add device-managed allocate
 workqueue
Message-ID: <aZwWMiYEvr3DXi3E@smile.fi.intel.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linaro.org,collabora.com,chromium.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-43007-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 6361517357D
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:27:29AM +0100, Krzysztof Kozlowski wrote:
> Add a Resource-managed version of alloc_workqueue() to fix common
> problem of drivers mixing devm() calls with destroy_workqueue.  Such
> naive and discouraged driver approach leads to difficult to debug bugs
> when the driver:
> 
> 1. Allocates workqueue in standard way and destroys it in driver
>    remove() callback,
> 2. Sets work struct with devm_work_autocancel(),
> 3. Registers interrupt handler with devm_request_threaded_irq().
> 
> Which leads to following unbind/removal path:
> 
> 1. destroy_workqueue() via driver remove(),
>    Any interrupt coming now would still execute the interrupt handler,
>    which queues work on destroyed workqueue.
> 2. devm_irq_release(),
> 3. devm_work_drop() -> cancel_work_sync() on destroyed workqueue.
> 
> devm_alloc_workqueue() has two benefits:
> 1. Solves above problem of mix-and-match devres and non-devres code in
>    driver,
> 2. Simplify any sane drivers which were correctly using
>    alloc_workqueue() + devm_add_action_or_reset().

>  include/linux/workqueue.h                        | 32 ++++++++++++++++++++++++
>  kernel/workqueue.c                               | 32 ++++++++++++++++++++++++

Hmm... We have devm-helpers.h. Why the new one is in workqueue.h?
Can we have some consistency here?

...

> +	ptr = devres_alloc(devm_destroy_workqueue, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return NULL;
> +
> +	va_start(args, max_active);
> +	wq = alloc_workqueue(fmt, flags, max_active, args);
> +	va_end(args);
> +	if (wq) {
> +		*ptr = wq;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}

Why not using devm_add_action_or_reset()?

...

> +void devm_destroy_workqueue(struct device *dev, void *res)
> +{
> +	destroy_workqueue(*(struct workqueue_struct **)res);
> +}
> +EXPORT_SYMBOL_GPL(devm_destroy_workqueue);

Is this going to be used?

-- 
With Best Regards,
Andy Shevchenko



