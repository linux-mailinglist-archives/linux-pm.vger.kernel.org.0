Return-Path: <linux-pm+bounces-30108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F89CAF8BDA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F65763491
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57CD328AED;
	Fri,  4 Jul 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cp/Izux0"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B0328AE2;
	Fri,  4 Jul 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617188; cv=none; b=uba/m+SNs7C8/eSeYdolzJq4VOuvqBdNcBlghHA47gyvVt8FkmayO92ArVzFdAuv7wVLzQFUtpYYF/2rJHjizSUH9DMjHSmHOjMQf6vg7B6RG9Z4MMOmaxvzYEiYXSY7dpI6eMdPVNdyEP46kuGvKgpTiXX7acDpvg0iASRHxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617188; c=relaxed/simple;
	bh=VHIyHPlNOQeT6o0Q7/lTbW2qpwThrxju/2z1cp6yEp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foKT6Wbc+jVry/bkD6VDgAyuPT2/Q/07C6V4rTTT5eJsxiP7FEG/npAqUy2ZZY48CEyU/NhTJiwZi7sB+mC6cCzZ0zjcLTyvCzzGE8kr9EqsojoPT1c+kLX9ZPHyVFhvS0VJZvk3/FlRWnf1jiOFmoGNt4uF6p/YFusPcQYED/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cp/Izux0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SqogGBv3noXgQBHxR8ZXgnX75dr040YudpVBo7oMuJA=; b=cp/Izux0mgOZm7QOhcJ0Wf/ZoP
	GBaSdVbzfJVCO1fp90vBFkoXwQltZ3ygZDenVmeERDV1/fWrchohnYvnzr8HgXV7Ouz+OZsuNr/Ww
	1jekU1qF1WQunz+hgPGwBjViGt7xLCOxtaNiQCvmkiRAJSQLgyXy2Xgt4neHGdiAW5sZ0Uxg/lBRa
	KyF85BMe2kvnUGNSVNqobSLXWiAgjZEYYst2KlGCygU+v2MtHAztv7G/5EaONxpyrha4RPo3+B1Nr
	uKUfj4SoonlkLqCMfmu/BOTguzSHQufyna5sA3GswxfBGCOvMWHbvPGGPXzFcSNTlsHeXoYsv9sYD
	JF/FLVog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXbe1-00000007qxR-3QaJ;
	Fri, 04 Jul 2025 08:19:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5F08A300212; Fri, 04 Jul 2025 10:19:41 +0200 (CEST)
Date: Fri, 4 Jul 2025 10:19:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zihuan Zhang <zhangzihuan@kylinos.cn>, pavel@kernel.org,
	len.brown@intel.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
Message-ID: <20250704081941.GC2001818@noisy.programming.kicks-ass.net>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
 <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
 <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>

On Thu, Jul 03, 2025 at 07:15:23PM +0200, Rafael J. Wysocki wrote:

> > How realistic is it to have a significant amount of zombies when
> > freezing? This seems like an artificial corner case at best.
> >
> > Zombie tasks are stuck waiting on their parent to consume their exit
> > state or something, right? And those parents being frozen, they pretty
> > much stay there.
> >
> > So I suppose the logic holds, but urgh, do we really need this?
> 
> Unlikely in practice, but the code change is small and it would be
> prudent to get this addressed IMV (at least so we don't need to
> revisit it).
> 
> But I would ask for a comment above this check to explain that zombies
> need not be frozen.

Depending on where they wait (I can't seem to find in a hurry) it might
make sense to make that wait FREEZABLE anyway.

For example, AFAICT it wouldn't hurt, and might even help some, to make
kernel/exit.c:do_wait() TASK_FREEZABLE.

So where do ZOMBIEs sleep? Don't they simply pass through do_task_dead()
and never get scheduled again? Notably, do_task_dead() already marks the
tasks as PF_NOFREEZE.

Anyway, yes, the condition it adds is relatively simple, but I really
don't see why we should complicate things *at*all*.

