Return-Path: <linux-pm+bounces-43029-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJsHB+hEnGk7CgQAu9opvQ
	(envelope-from <linux-pm+bounces-43029-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:15:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E2175F9B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1CBA300A76A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BE93659EA;
	Mon, 23 Feb 2026 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyxU4bjc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3A364E99;
	Mon, 23 Feb 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848789; cv=none; b=MLVXqTSzbJbTUXPahr4l5q9boES0uZgqfTxTsCLc4nyEqhmt8Dq04EjgRe2zOGJVhIyCVGLHxA8oP65hGHPij0RrY6m2LagGCDD7QLzizoOOU8p3Us6C9yW56Q2ZNHzU3vpQubIhdPDSXal7O+E2DoDkANLSwJGST1eWD8yzrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848789; c=relaxed/simple;
	bh=3n9HI5ycnkli5W6BGGU+azDBkZ+AMvJ95kVejaXce4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4zc20roBHiLedq6YoXNeXqaFypy6wCTSrWy/zc/vTqSoDznKEK56f9ZBMrzeIJWLW93d5GfX4y2pc6FsEaWcqhBZALlKRCpTmGIP561uR3KTwV64WA8NdYju6G2bs6OymJLZhHoePB7hOygDImPBknRvDs5tFDJJRZmmSIU3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyxU4bjc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771848788; x=1803384788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3n9HI5ycnkli5W6BGGU+azDBkZ+AMvJ95kVejaXce4U=;
  b=EyxU4bjcae4lQFq0yqLlBCyreZmL3VzMpGEypt7fUTu4HUpFelgMrUUj
   RB9bf4Tv3tJUHDu+MlNw8H2y/ztU6+TYZQN36PfVq8nWyVYDG8BRoRzp7
   WU/NoqqqZAAj2SO5m7mauF31Nb71wbd7mAXyCv98MCcFaMEhFLlaJk4Hb
   q4PUrdBGeWo45qdAtqsrXpuYm+vXLn/XivBsI4rOlkpSIe8SAdyy1fTna
   EGH62ZPqJrakkgzTlayF913oieXc0RtcyMjYUyDXiV1nBXL8bFKtCnuPk
   xsayOjyTHW4wWDaxOfLR42dBoSXp4hKfPL8zjC/Okj2S7y1+TZXRZp0qO
   g==;
X-CSE-ConnectionGUID: AJlWH8HxSNW05S4jXJTXcQ==
X-CSE-MsgGUID: u+kVcbOAQaCcsoA3Fk9lMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="90247546"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="90247546"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:13:08 -0800
X-CSE-ConnectionGUID: K2itwqXdR8a5WDW9LgYZPw==
X-CSE-MsgGUID: 63CQjMeZR761DzImy1sYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="220091804"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:13:02 -0800
Date: Mon, 23 Feb 2026 14:12:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lee Jones <lee@kernel.org>,
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
Message-ID: <aZxES35K3hSX4KEx@smile.fi.intel.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
 <aZwWMiYEvr3DXi3E@smile.fi.intel.com>
 <9dd377f6-3565-4c0c-8c98-1b5ac4982f5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd377f6-3565-4c0c-8c98-1b5ac4982f5b@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linaro.org,collabora.com,chromium.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-43029-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 871E2175F9B
X-Rspamd-Action: no action

+Cc: devm-helpers maintainers/reviewers

On Mon, Feb 23, 2026 at 12:52:14PM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2026 09:56, Andy Shevchenko wrote:
> > On Mon, Feb 23, 2026 at 08:27:29AM +0100, Krzysztof Kozlowski wrote:
> >> Add a Resource-managed version of alloc_workqueue() to fix common
> >> problem of drivers mixing devm() calls with destroy_workqueue.  Such
> >> naive and discouraged driver approach leads to difficult to debug bugs
> >> when the driver:
> >>
> >> 1. Allocates workqueue in standard way and destroys it in driver
> >>    remove() callback,
> >> 2. Sets work struct with devm_work_autocancel(),
> >> 3. Registers interrupt handler with devm_request_threaded_irq().
> >>
> >> Which leads to following unbind/removal path:
> >>
> >> 1. destroy_workqueue() via driver remove(),
> >>    Any interrupt coming now would still execute the interrupt handler,
> >>    which queues work on destroyed workqueue.
> >> 2. devm_irq_release(),
> >> 3. devm_work_drop() -> cancel_work_sync() on destroyed workqueue.
> >>
> >> devm_alloc_workqueue() has two benefits:
> >> 1. Solves above problem of mix-and-match devres and non-devres code in
> >>    driver,
> >> 2. Simplify any sane drivers which were correctly using
> >>    alloc_workqueue() + devm_add_action_or_reset().
> > 
> >>  include/linux/workqueue.h                        | 32 ++++++++++++++++++++++++
> >>  kernel/workqueue.c                               | 32 ++++++++++++++++++++++++
> > 
> > Hmm... We have devm-helpers.h. Why the new one is in workqueue.h?
> > Can we have some consistency here?
> 
> Answering with update:
> I don't think this should go to devm-helpers.h. The definition is in
> workqueue.c, thus the declaration should be in corresponding header.
> It's logical and consistent.
> 
> Otherwise, I could move it entirely - definition and declaration - to
> devm-helpers.h, but then the release (devm_destroy_workqueue()) will be
> essentially exported to everyone through the header.
> 
> So kind of conflicting choices.

Hmm... An alternative I see is more intrusive but should make it less
inconsistent: Treat the devm-helpers as devres like header for workqueue
and collect there all devm_*wq* related stuff with maybe something putting
back to / holding in the c-file.

OTOH we may leave devm_destroy_workqueue() visible for now with a comment
saying do not use, it's internal or something like that.

Hans, what would be your opinion as you IIRC is the author of devm-helpers.h?

Matti, I also Cc'ed to you, you have usually non-standard thinkig and
insightful solutions (besides being reviewer of devm-helpers).

-- 
With Best Regards,
Andy Shevchenko



