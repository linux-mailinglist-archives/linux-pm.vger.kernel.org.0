Return-Path: <linux-pm+bounces-3142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A49844EC3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 02:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707C11C25DD6
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0C946B3;
	Thu,  1 Feb 2024 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut5ZeGQw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85ED442D;
	Thu,  1 Feb 2024 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751661; cv=none; b=O3AW9w7EPoW1OS/BxX0rK9c/1bXURLPEsJ+9Mk0jLaOk3i0aNUFpcMZSwwOp3Ba1pVe6LKDUB4krHaEbvZbuJWApzobF/iz2bKyA5tnbVlAcRO5Uf81gD5DnzUP9vxTeuMt3UvLG2XGixukMsiumuH5au9xkDzmy76RtftCvgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751661; c=relaxed/simple;
	bh=R1iOxBRSgblu2PxialypgPvhbR5u2Pq/URgpTXRfgW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0orLXwfgmBKsCXIrT7wjgTXModOg0utcj1ZOvFLbpNxo9UmsUf/UXaQM0ZAoErCqJaZVFpIPd2QBe+5zZTbDtzv33HjBxvRNclQy/VJ1eOyzxhasc9NTkPYyAThr8GDQ9EfI1xUaOYqR8XYzYSqUvCKa1WM82VqmVBRcceM6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut5ZeGQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E94C433C7;
	Thu,  1 Feb 2024 01:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706751661;
	bh=R1iOxBRSgblu2PxialypgPvhbR5u2Pq/URgpTXRfgW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ut5ZeGQwPhRuonncPL1w4QOm3zujgl67NhucRtJptnmXRtjwGK0Dcde060afBQGPM
	 Q9NbX+gvIhf38JQio0/rf2jyp16J6wah3rKPoIDRMo4Hfen+SzlHeiK5BoBsBU1zCX
	 6UNDXDOCdCgKFphpxt5nWwBZecACS/Izdz4a7nSrd6iRUf02M5fARB6uct7YZYBd0B
	 jKjeNLijC0hteM9zgbTDJ/ROQEeSq2nM2D/DDIh/wHg7sFTKBpEsVAbcSiUO45Vuel
	 t7di7PgnwZ94DKbtAHG3fg36xv4uRj+wiwcmX/prO+Ulf6nvFJRviQo73LRUPWF1ai
	 vWNwHCmiA19Kw==
Date: Wed, 31 Jan 2024 17:40:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] netlink: Add notifier when changing netlink socket
 membership
Message-ID: <20240131174056.23b43f12@kernel.org>
In-Reply-To: <20240131120535.933424-2-stanislaw.gruszka@linux.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
	<20240131120535.933424-2-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 13:05:33 +0100 Stanislaw Gruszka wrote:
> Add notification when adding/removing multicast group to/from
> client socket via setsockopt() syscall.
> 
> It can be used with conjunction with netlink_has_listeners() to check
> if consumers of netlink multicast messages emerge or disappear.
> 
> A client can call netlink_register_notifier() to register a callback.
> In the callback check for state NETLINK_CHANGE and NETLINK_URELEASE to
> get notification for change in the netlink socket membership.
> 
> Thus, a client can now send events only when there are active consumers,
> preventing unnecessary work when none exist.

Can we plumb thru the existing netlink_bind / netlink_unbind callbacks?
Add similar callbacks to the genl family struct to plumb it thru to
thermal. Then thermal can do what it wants with it (also add driver
callbacks or notifiers).

Having a driver listen to a core AF_NETLINK notifier to learn about
changes to a genl family it registers with skips too many layers to
easily reason about. At least for my taste.

When you repost please CC Florian W, Johannes B and Jiri P, off the top
of my head. Folks who most often work on netlink internals..

