Return-Path: <linux-pm+bounces-39443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19833CB69BD
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 18:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18993016DD3
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9509626E165;
	Thu, 11 Dec 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ID/b+v8K"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713F1E9B1A;
	Thu, 11 Dec 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472520; cv=none; b=tGiDjcq7vZNxLZUjb4ga0FLAwryCcl3ENPt/BKBPcvWzHhM9wD6URkK4ikGPRLWZvzQbjHWdIbjjZkr+OY4YXCW33d65FfZigLJccUmbMZiqQNdQ9o1q/dEkhc/7LKrsemc0sCX4vLTVpO51f+JSmoTOp4aPFb7jPHh+s8W01J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472520; c=relaxed/simple;
	bh=FjocHFtCJkM5sWBuZpTKHUovSw+YwPx+EnDRRwVm8H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJRq+2HwAZGOsvUbEtS4Ijh5hqcUHdEnhdQgSJT30PXAnBkvGlE/QmtbXU2OpqJo4nXf9SX4Pn5X7NX5jNbkNu47c8xQW3CFlgrGUPRfcJi10hTF8+f9uhRJSBbTuT+QBpnDOkZ6BaKubNwvZ5kyzjdrpFko65REuFj9hof75R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ID/b+v8K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ry1eEt85dBpW/TZGAB2h+IjJdeqHxvVZFxsaCGnlrzI=; b=ID/b+v8K2IaUfj05CNeY62iaR8
	i5t3tpWbHx6o11Dmiz10jCOz1L8WW6cUe9HInpybIu+jbfTtYMLnxWwXe7bq+Az6LVPfq8aRQG6mt
	EpMxZAEfosu4QO4pcHDgwBAdZB6zoAymPX+5OFonGLw8nmFKb8bNB0H0lgEIm5M+9LtY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vTk36-00GfL8-SM; Thu, 11 Dec 2025 18:01:52 +0100
Date: Thu, 11 Dec 2025 18:01:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Concerns with em.yaml YNL spec
Message-ID: <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>

On Thu, Dec 11, 2025 at 03:54:53PM +0000, Donald Hunter wrote:
> Hi,
> 
> I just spotted the new em.yaml YNL spec that got merged in
> bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
> because it introduced new yamllint reports:
> 
> make -C tools/net/ynl/ lint
> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
> yamllint ../../../Documentation/netlink/specs
> ../../../Documentation/netlink/specs/em.yaml
>   3:1       warning  missing document start "---"  (document-start)
>   107:13    error    wrong indentation: expected 10 but found 12  (indentation)
> 
> I guess the patch series was never cced to netdev or the YNL
> maintainers so this is my first opportunity to review it.
> 
> Other than the lint messages, there are a few concerns with the
> content of the spec:
> 
> - pds, pd and ps might be meaningful to energy model experts but they
> are pretty meaningless to the rest of us. I see they are spelled out
> in the energy model header file so it would be better to use
> perf-domain, perf-table and perf-state here.

We also need to watch out for other meaning of these letters. In the
context of networking and Power over Ethernet, PD means Powered
Device. We generally don't need to enumerate the PD, we are more
interested in the Power Sourcing Equipment, PSE.

And a dumb question. What is an energy model? A PSE needs some level
of energy model, it needs to know how much energy each PD can consume
in order that it is not oversubscribed. Is the energy model generic
enough that it could be used for this? Or should this energy model get
a prefix to limit its scope to a performance domain? The suggested
name of this file would then become something like
performance-domain-energy-model.yml?

	Andrew


