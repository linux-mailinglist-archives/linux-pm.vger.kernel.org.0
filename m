Return-Path: <linux-pm+bounces-30117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90424AF8E76
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 11:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B304A2BC6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673EA2E9EC7;
	Fri,  4 Jul 2025 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B4Ihd6tS"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752A2E8E03;
	Fri,  4 Jul 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620912; cv=none; b=OxGrpGihiFeBw9qlKkd2s3O2mOBhDjhOujnrSBCwlA+8KZYxiKXed6NkO3DvN87zkgLUVuIXeEGKUL2yhZvXuCcRGlQZd4XwCzkN4jPfftiQkyAbZMIBVSUewqPDtbWDWs4UUhbG0RosQHEv0o4J3jyFgRUjfblE/jNjDEPBFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620912; c=relaxed/simple;
	bh=5fQ2aJ1Vlww6hWXndwKGXGvH3xXglf+mXhPexqO8tT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNXe+qkyzV++UE+OP5JQ0haVkn/OQZfxteXlvG3zMxW5TvA0wfnjYwm5G+sjhgpktCaaLnqM4E0dMabDBM4Lko/On2A+VQYQ5XRtDBZXS0MdX4kGkVyzm0gfHWqgakIoz7FRNB8tVS25wo+WPYJZi34niXUJxLL24XuFm9YX/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B4Ihd6tS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3SFTAh+HHF7FmDoKMgoLwPkFCo2t6Gk4A/qXJ6c1fak=; b=B4Ihd6tSv/vfplUG9x5JCVXAlC
	RWWQO3uBKWfScdqwOWwFfptl7+B+Iu8oKw4Ifq7XBKY4oXCZ0pHi+C2dKB+b5S3jZ33q7Rokcq5QV
	SoyGEC5M98dWxQpta9gQlOCcSJwJge8RbEQlhcitU46IOSoe+hUhludaurJGrOo1Mv0Zw3cKMqmg/
	IUO/AVD6Zha8HhANF1MmOs48mxkhMq6MDDIX/YBxe84WOfJhbVu58zNFTgR58DcCYqnVRvrwhvl90
	pwmf91fy1ZvpKc4BY+3n9xDcyQ/l+o7stGkWhe1jM3Jn9L9Vs+ekygaA7kIjlZsBNJzSII1sAICRV
	yxKimoNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXcc5-00000007u6P-2Qhu;
	Fri, 04 Jul 2025 09:21:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1DC04300212; Fri, 04 Jul 2025 11:21:45 +0200 (CEST)
Date: Fri, 4 Jul 2025 11:21:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, pavel@kernel.org,
	len.brown@intel.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
Message-ID: <20250704092144.GH2001818@noisy.programming.kicks-ass.net>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
 <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
 <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
 <20250704081941.GC2001818@noisy.programming.kicks-ass.net>
 <67997bdd-d00a-413a-a565-188c4b06f385@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67997bdd-d00a-413a-a565-188c4b06f385@kylinos.cn>

On Fri, Jul 04, 2025 at 04:48:20PM +0800, Zihuan Zhang wrote:
> Hi Peter,
> 
> Thanks for the feedback.
> 
> ??? 2025/7/4 16:19, Peter Zijlstra ??????:
> > ????????? ??? ??? ?????? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??????
> > Depending on where they wait (I can't seem to find in a hurry) it might
> > make sense to make that wait FREEZABLE anyway.
> > 
> > For example, AFAICT it wouldn't hurt, and might even help some, to make
> > kernel/exit.c:do_wait() TASK_FREEZABLE.
> > 
> > So where do ZOMBIEs sleep? Don't they simply pass through do_task_dead()
> > and never get scheduled again? Notably, do_task_dead() already marks the
> > tasks as PF_NOFREEZE.
> > 
> > Anyway, yes, the condition it adds is relatively simple, but I really
> > don't see why we should complicate things *at*all*.
> 
> You???re absolutely right ??? zombie processes won???t be frozen in
> practice, since PF_NOFREEZE is already set in do_task_dead(). However, if we
> don???t explicitly skip them early in try_to_freeze_task(), they still go
> through the freezer logic path, including calls like freeze_task() ???
> freezing() before eventually returning without freezing.
> 
> This not only introduces unnecessary code path traversal, but also involves
> locking (e.g., spin_lock_irqsave/restore()), which could be avoided
> altogether if we bail out earlier.
> 
> Additionally, skipping zombies directly helps reduce the list traversal
> overhead in freeze_processes(), especially on systems with a large number of
> tasks, where zombies can account for a non-trivial fraction.
> 
> So while the practical effect might be small, the gain is low-risk and helps
> streamline the freezer logic a bit more.

You're missing the obvious. How about we 'fix' the PF_NOFREEZE handling
and help all cases that set that and not only zombies?

