Return-Path: <linux-pm+bounces-3159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A4845890
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 14:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964EB288F12
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC655CDC8;
	Thu,  1 Feb 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S10ePGPs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E435338C;
	Thu,  1 Feb 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793068; cv=none; b=Oz7kHlnOwnG6dacmC2tvXFPBuFpGqZ4qfYCHajCHWR4aJ4iMal20+t8Amhtq6TrQdDMy3aNULmTv8otzKFMpRIolZjgwaN6IQStv/UoLNNJnsSjnL4Is7yrUum7xDXfrAIZgST3J4qAV5CTeSE1aUFn2i8ouNtBnsUr6FOQHzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793068; c=relaxed/simple;
	bh=ls+9RFNzMOW0liv757p99+kmzNTODKha4qA4iMAm7yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+0w9oVSe5b5hyAEBC1dABvQ3Bxqvc7I8OF2KUsxwl7xj2hMLKsYoBlBgVTaF8dr5KGeN6APW0ap6lHmHuZ5NtA1S9EDf8ejyg96nzYXIE22QJwC6ZXzfWyAp7sB+CZo395YyD57yNVv+snL//d6zMs/2HADd0RI+U1pf+fAhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S10ePGPs; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706793063; x=1738329063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ls+9RFNzMOW0liv757p99+kmzNTODKha4qA4iMAm7yQ=;
  b=S10ePGPs7WXKAMIuSq/8DAPdnLCvZlm5XxI61/HXgF3g8xhYMu5sz/4s
   72u7lpWmRtwmcoBHEU5BtNGBibkKbXAgVB3Ie41SXa8I+Fp4BwrpK1DqH
   p+IMrs6shAYN9XgNO1r3lAXxV4i1TYkiScYpNP95FfCxJoxYakv63Kr81
   agfa09o7tdd6Lw5pJEJkTHvTXu9EO3WioC7yvFmbraiD7Hg1oRRR8ABCJ
   eYka1cauoikkZoYezY1XwYO6Op24q3QImP5OPehwOMpd3HdXXMkXIE+SC
   8NlmCC4bv1kHvotyKfhA5Ws/h0/KbTpG+PR5zwnh8edPWHxyhC/GWPBOC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="468123506"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="468123506"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:11:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="30587141"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:10:59 -0800
Date: Thu, 1 Feb 2024 14:10:56 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] netlink: Add notifier when changing netlink socket
 membership
Message-ID: <ZbuYYMvihYxEbQ/p@linux.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
 <20240131120535.933424-2-stanislaw.gruszka@linux.intel.com>
 <20240131174056.23b43f12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131174056.23b43f12@kernel.org>

On Wed, Jan 31, 2024 at 05:40:56PM -0800, Jakub Kicinski wrote:
> On Wed, 31 Jan 2024 13:05:33 +0100 Stanislaw Gruszka wrote:
> > Add notification when adding/removing multicast group to/from
> > client socket via setsockopt() syscall.
> > 
> > It can be used with conjunction with netlink_has_listeners() to check
> > if consumers of netlink multicast messages emerge or disappear.
> > 
> > A client can call netlink_register_notifier() to register a callback.
> > In the callback check for state NETLINK_CHANGE and NETLINK_URELEASE to
> > get notification for change in the netlink socket membership.
> > 
> > Thus, a client can now send events only when there are active consumers,
> > preventing unnecessary work when none exist.
> 
> Can we plumb thru the existing netlink_bind / netlink_unbind callbacks?
>
> Add similar callbacks to the genl family struct to plumb it thru to
> thermal. Then thermal can do what it wants with it (also add driver
> callbacks or notifiers).

Yes, sure, can be done this way and make sense. Going to do this.

> Having a driver listen to a core AF_NETLINK notifier to learn about
> changes to a genl family it registers with skips too many layers to
> easily reason about. At least for my taste.
> 
> When you repost please CC Florian W, Johannes B and Jiri P, off the top
> of my head. Folks who most often work on netlink internals..

Ok.

Regards
Stanislaw
> 

