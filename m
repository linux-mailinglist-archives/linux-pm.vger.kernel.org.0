Return-Path: <linux-pm+bounces-43023-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HHIKKw+nGnKCAQAu9opvQ
	(envelope-from <linux-pm+bounces-43023-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:49:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CF175ACD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 926953028F45
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA435BDBC;
	Mon, 23 Feb 2026 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAM9XX84"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD522538F;
	Mon, 23 Feb 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847335; cv=none; b=cl6QOEmgkh25HGJjRqvoi5XF5L0CWl7G74/xTmt/poHjktcNprxaGo0ADrVkzMo5DLIBjX76pvdVQ+FQeepBvFzV0kXJK4ZxOdAeJLiuE7YkMaqwbS6qKn3/CycpaaDIu18Knw+tFNIVdlNLbMX1CgH9jYHwDD6yKGTpywIYt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847335; c=relaxed/simple;
	bh=M88SYq6Q+APDm889xmB2pur2+3zyfmnqVy+OHhkNYfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJSmvajjUhno4xko0HyrIL/FNvSbY0LOlD6fN1RqwveUmtAwpj8Yz4fIvvr7sB1WG7ZzkkMC0r2TPb1rxtgAKqKzV/NnUBXq+T5xs2RHvx+DshBfwuYLk0QJyqFx7juQdQAcTvxMG8dXkhOTbe6oJHuZ2UvbDX/Msiy1EqupYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAM9XX84; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771847334; x=1803383334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M88SYq6Q+APDm889xmB2pur2+3zyfmnqVy+OHhkNYfA=;
  b=nAM9XX84NjWFgWO2sHI4B0tV9oRU7zftSWcqLbqlm/RupcAKmaDcwbSz
   Bu7lhLDwlDw5B4X6WGYCNP5R1YGg2JutC5/pQlP1U2llrxgfKTatMyLpx
   zcfwyRT49n43d1PPmof6OLcPMu0HJZY7drwMW+azTipsxj0dAd8rlx8gu
   Iz6uzI+3GB3K51B509QveUi8TiWllNOludDaCzhUq4TbFBP0zQBTrIOSs
   pTjrRQ8vzD8BXWU1Buvp9NS6f8Fnfszb8BH5g82nd7w5J7xvXfi/2Z8jb
   1Da9kXRYXbdliqF3lavdQRQiWUcQXxjxr460fvDhIk6bTl7naMitg0jZV
   w==;
X-CSE-ConnectionGUID: w0Dd+SkZQmWbFEuUnXMP0A==
X-CSE-MsgGUID: 1xUVKSobQXyRfUQT2lNvew==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72817832"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72817832"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:48:53 -0800
X-CSE-ConnectionGUID: rOo1Ih6ERIe7QfxvtUCToQ==
X-CSE-MsgGUID: ch/fVF9uSQK1lIAFQdR+gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="220535346"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:48:48 -0800
Date: Mon, 23 Feb 2026 13:48:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Message-ID: <aZw-nTtz9WzWHzUh@smile.fi.intel.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
 <aZwWMiYEvr3DXi3E@smile.fi.intel.com>
 <534a9d0f-600e-4162-a48c-f9797241dacd@kernel.org>
 <aZw7NJOhkq6DlyZA@smile.fi.intel.com>
 <2a15919b-6473-49c5-b409-07e63b13d2a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a15919b-6473-49c5-b409-07e63b13d2a6@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linaro.org,collabora.com,chromium.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-43023-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 1C5CF175ACD
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:43:42PM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2026 12:34, Andy Shevchenko wrote:
> > On Mon, Feb 23, 2026 at 11:18:41AM +0100, Krzysztof Kozlowski wrote:
> >> On 23/02/2026 09:56, Andy Shevchenko wrote:
> >>> On Mon, Feb 23, 2026 at 08:27:29AM +0100, Krzysztof Kozlowski wrote:

...

> >>>> +	ptr = devres_alloc(devm_destroy_workqueue, sizeof(*ptr), GFP_KERNEL);
> >>>> +	if (!ptr)
> >>>> +		return NULL;
> >>>> +
> >>>> +	va_start(args, max_active);
> >>>> +	wq = alloc_workqueue(fmt, flags, max_active, args);
> >>>> +	va_end(args);
> >>>> +	if (wq) {
> >>>> +		*ptr = wq;
> >>>> +		devres_add(dev, ptr);
> >>>> +	} else {
> >>>> +		devres_free(ptr);
> >>>> +	}
> >>>
> >>> Why not using devm_add_action_or_reset()?
> >>
> >> Where? Here? How the code would be simpler, exactly?
> > 
> > static void devm_workqueue_release(void *wq)
> > {
> > 	destroy_workqueue(wq);
> > }
> > ...
> > {
> > 	...
> > 
> > 	va_start(args, max_active);
> > 	wq = alloc_workqueue(fmt, flags, max_active, args);
> > 	va_end(args);
> > 	if (!wq)
> > 		return NULL; // or ERR_PTR(-ENOMEM) on your choice
> > 
> > 	ret = devm_add_action_or_reset(dev, devm_workqueue_release, wq);
> > 	if (ret)
> > 		return NULL; // ERR_PTR(ret) on your choice
> > 
> > 	return wq;
> > }
> > 
> > Compare to yours :-)
> 
> Ah, so dropping the devres_alloc()? Yeah, that would be simpler.

Yep! The side effect is dropping that ugly casting in _release() along with
unused dev.

-- 
With Best Regards,
Andy Shevchenko



