Return-Path: <linux-pm+bounces-33834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D46B43C9D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701211645FF
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CF32ED170;
	Thu,  4 Sep 2025 13:09:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F32701B6;
	Thu,  4 Sep 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991341; cv=none; b=hQ3xq+CpSUrqKwsRJ3Qhe/CXQ7ZmA7si5W/pwxeDl+OrL/oyxnfAVbHYgYhip6Azs/v5ltME0RBeRcpuMqzxeTnfeiyk5kqykG3zYAjSYr+RSqdEOpGNMefOwJt9bIWeklbBmauoU4hQfMD/5cC6EtzjPsqwgVRxBTmcFF5fy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991341; c=relaxed/simple;
	bh=RTdTMtnkOXP1b30MfGMTK0toQKysQeW31T0tvUEJJpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfYcrPyjh8NePbN5y2GUwCGatigJ/MsVvGN3MP3iNfPM3fQB+p++YA8shhu1yugWhc9Hdp+a60wrWTpLTFtxzeEwr7GR3Y4EVCfic04RfwwLi668KiUZgV5n1Ghffy+bk7yf+nQZnlLwePF3mntBqfMihTcVnzRt1MmWPHNCmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cHftL2qLnzYl5WR;
	Thu,  4 Sep 2025 21:08:26 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 21:08:49 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 21:08:48 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <liulu.liu@honor.com>, <lorenzo.stoakes@oracle.com>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <surenb@google.com>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>, <rafael@kernel.org>,
	<pavel@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] mm/oom_kill: Thaw victim on a per-process basis instead of per-thread
Date: Thu, 4 Sep 2025 21:08:44 +0800
Message-ID: <20250904130844.28447-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aLg0QZQ5kXNJgDMF@tiehlicka>
References: <aLg0QZQ5kXNJgDMF@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a018.hihonor.com
 (10.68.17.250)

> > OOM killer is a mechanism that selects and kills processes when the system
> > runs out of memory to reclaim resources and keep the system stable.
> > However, the oom victim cannot terminate on its own when it is frozen,
> > because __thaw_task() only thaws one thread of the victim, while
> > the other threads remain in the frozen state.
> > 
> > This change will thaw the entire victim process when OOM occurs,
> > ensuring that the oom victim can terminate on its own.
> > 
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > ---
> >  mm/oom_kill.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 25923cfec9c6..3caaafc896d4 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -747,6 +747,19 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
> >  }
> >  #endif /* CONFIG_MMU */
> >  
> > +static void thaw_oom_process(struct task_struct *tsk)
> > +{
> > +	struct task_struct *t;
> > +
> > +	/* protects against  __exit_signal() */
> > +	read_lock(&tasklist_lock);
> > +	for_each_thread(tsk, t) {
> > +		set_tsk_thread_flag(t, TIF_MEMDIE);
> > +		__thaw_task(t);
> > +	}
> > +	read_unlock(&tasklist_lock);
> > +}
> > +
> 
> Sorry, I was probably not clear enough. I meant thaw_process should live
> in the freezer proper kernel/freezer.c and oom should be just user.
> Please make sure that freezer maintainers are involved and approve the
> change.

Thank you, I got it, It would indeed be better to have thaw_process in
kernel/freezer.c. Let me CC the freezer maintainers before updating
with the new changes; maybe they will have other suggestions as well.

> 
> -- 
> Michal Hocko
> SUSE Labs


