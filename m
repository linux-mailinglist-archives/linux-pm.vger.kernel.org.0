Return-Path: <linux-pm+bounces-34279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ABBB4FFEF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20848166014
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869E24167A;
	Tue,  9 Sep 2025 14:47:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857621323C;
	Tue,  9 Sep 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429265; cv=none; b=DWwovnNgOPnVWhX+XSLg13kfUhOC9oYufSF50MB1Zl6n+WIhWgWrOoxi9o30v/18NGV1KmgODsfs4zXPpwOdxArOIIYY33nvMtHuyvFqkKseZl87OHc41kxIIijKim1ccRdghm6PDhoXFU6NYwqCEg0lLWL2KIq1GOFZCpYHD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429265; c=relaxed/simple;
	bh=0fGRb6AXdpQw9S8Sy3BAcuqQEjUyKwC9HyYR5gjbJL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXEU4z65ZTH32l2GOSnS4blDEn3qD75FuMp/DRX2i8YdRth6+8TTkOnaSA7Fns+mNRmErPecmeQhlSfMRVaaV9vDn/OUKzzGmZIxNa3M2IgYZxxray0u1XBm1Oa+S1IXwuDQjJSmS1dVo7oCGGNFYChJXwH6Ez8IaYopgX3SAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cLmr15WXTzYl9B5;
	Tue,  9 Sep 2025 22:47:13 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 22:47:40 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 22:47:39 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>, <lenb@kernel.org>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-pm@vger.kernel.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <pavel@kernel.org>, <rafael@kernel.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <surenb@google.com>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for thawing OOM victims
Date: Tue, 9 Sep 2025 22:47:35 +0800
Message-ID: <20250909144735.6166-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aMAzkQQ4XAFh9xlm@tiehlicka>
References: <aMAzkQQ4XAFh9xlm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a018.hihonor.com
 (10.68.17.250)

> > > On Tue 09-09-25 19:41:31, zhongjinji wrote:
> > > > > On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > > > > > OOM killer is a mechanism that selects and kills processes when the system
> > > > > > runs out of memory to reclaim resources and keep the system stable.
> > > > > > However, the oom victim cannot terminate on its own when it is frozen,
> > > > > > because __thaw_task() only thaws one thread of the victim, while
> > > > > > the other threads remain in the frozen state.
> > > > > > 
> > > > > > Since __thaw_task did not fully thaw the OOM victim for self-termination,
> > > > > > introduce thaw_oom_process() to properly thaw OOM victims.
> > > > > 
> > > > > You will need s@thaw_oom_process@thaw_processes@
> > > > 
> > > > The reason for using thaw_oom_process is that the TIF_MEMDIE flag of the
> > > > thawed thread will be set, which means this function can only be used to
> > > > thaw processes terminated by the OOM killer.
> > > 
> > > Just do not set the flag inside the function. I would even say do not
> > > set TIF_MEMDIE to the rest of the thread group at all. More on that
> > > below
> > > 
> > > > thaw_processes has already been defined in kernel/power/process.c.
> > > > Would it be better to use thaw_process instead?
> > > 
> > > Sorry I meant thaw_process as thaw_processes is handling all the
> > > processes.
> > > 
> > > > I am concerned that others might misunderstand the thaw_process function.
> > > > thaw_process sets all threads to the TIF_MEMDIE state, so it can only be
> > > > used to thaw processes killed by the OOM killer.
> > > 
> > > And that is the reason why it shouldn't be doing that. It should thaw
> > > the whole thread group. That's it.
> > >  
> > > > If the TIF_MEMDIE flag of a thread is not set, the thread cannot be thawed
> > > > regardless of the cgroup state.
> > > 
> > > Why would that be the case. TIF_MEMDIE should only denote the victim
> > > should be able to access memory reserves. Why the whole thread group
> > > needs that? While more threads could be caught in the allocation path
> > > this is a sort of boost at best. It cannot guarantee any forward
> > > progress and we have kept marking only the first thread that way without
> > > any issues.
> > 
> > When a process is frozen, all its threads enter __refrigerator() (in kernel/freezer.c). 
> > When __thaw_task is called, the threads are woken up and check the freezing(current) 
> > state (in __refrigerator). The freezing check is implemented via freezing_slow_path. 
> > When TIF_MEMDIE is set for a thread, freezing_slow_path will return false, allowing 
> > the thread to exit the infinite loop in __refrigerator(), and thus the thread will 
> > be thawed.
> > 
> > The following code can explain how TIF_MEMDIE works in thread thawing.
> > __refrigerator
> >   for (;;) {
> >     freezing = freezing(current)
> >       freezing_slow_path
> >         if (test_tsk_thread_flag(p, TIF_MEMDIE))
> >           return false;
> >     if (!freezing)
> >       break;
> >     schedule();
> >   }
> 
> OK, I see. We could deal with that by checking tsk_is_oom_victim()
> instead of TIF_MEMDIE

Thank you, this looks great. It seems that oom_reserves_allowed implies
that tsk_is_oom_victim is not always effective (in page_alloc.c).
I will check it.

