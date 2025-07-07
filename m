Return-Path: <linux-pm+bounces-30252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB4AFAECF
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE573B50E0
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A91928C021;
	Mon,  7 Jul 2025 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="As5udUkk"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880028BAB1;
	Mon,  7 Jul 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877744; cv=none; b=bY5s6Sre4slSxWVTxz6DN7CSY0glO5N39+ojJrDxvHzuy/gSIkimC2lewPR+b0ShL6uLhzwrTEwFZFpVwQ/bSZrrLUIj7LFbg1u/dRWqWZjKH3M3/rftFIYazdxBOGtL+4OYUQtNblJJm32NbUl72AtZCKOD5lz01AXyBEhbssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877744; c=relaxed/simple;
	bh=ecvnWjDs6rHGQNSELOd1WnhXoUc1cYs4DlZY2AAw8nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pox/B0bsF/QW/Q0URSKdwuGVNk0JZK3683zBRA07W7Loy33WlUegyYR/8fDyR0HDg7mfB3iWKn9WmbV1uhErl7vFw/HZjhXOqnU0iAOAYWxvKEgug9xasSpIJoPNIuCdqzH8cMJzJ5Idv7GyO9AHgRl4Teb/SyuMuJZK+QfiQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=As5udUkk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TTouOHxjRQpAGzsi8stU4ElD0h3yn0qT6ATOrQoRPxg=; b=As5udUkkgrFjaRppQlcm07WCnc
	j44IVoEpB+m42ag1j8NFPdUsuvvGdnUFT02o/hImA9CkJfKn6+Nw4Ll35W0wxAVn/U55cbH6RZ/LZ
	CGYIPhOHw/lG4PF9BzHKGqcNn5kejcaqboiMO9NrbOW1TNIkFECXZ664f6nAcF8/DbOg/5KX+NYZs
	lr9QHzJ3CUimXXbEtLqUIMS2S/NH/9pvE/00b3zu4epzx7JAKEmKFfjlixIeKzOWqmDlHQ6eaw5l0
	9hiQGOB32Mz+sPjgY5an+2yOVtvR54MSzCYteNou5faBlqFU7+fdUKtv9a28ozLVvrP1zozleTX64
	cXhCkNBw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYhQV-0000000CE5p-0TiR;
	Mon, 07 Jul 2025 08:42:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 455E0300212; Mon, 07 Jul 2025 10:42:14 +0200 (CEST)
Date: Mon, 7 Jul 2025 10:42:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, pavel@kernel.org,
	len.brown@intel.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
Message-ID: <20250707084214.GD1613200@noisy.programming.kicks-ass.net>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
 <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
 <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
 <20250704081941.GC2001818@noisy.programming.kicks-ass.net>
 <67997bdd-d00a-413a-a565-188c4b06f385@kylinos.cn>
 <20250704092144.GH2001818@noisy.programming.kicks-ass.net>
 <de7e327a-202c-4b28-b372-2d648c680dbe@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de7e327a-202c-4b28-b372-2d648c680dbe@kylinos.cn>

On Mon, Jul 07, 2025 at 09:00:12AM +0800, Zihuan Zhang wrote:
> 
> 在 2025/7/4 17:21, Peter Zijlstra 写道:
> > You're missing the obvious. How about we 'fix' the PF_NOFREEZE handling
> > and help all cases that set that and not only zombies?　　　 　 　 　　 　 　 　 　 　 　 　 　 　 　　
> 
> It sounds like a good idea, but there’s a potential risk in relying solely
> on PF_NOFREEZE: it’s a mutable flag that can be set or cleared dynamically
> during runtime, even within the freeze window.

> If a task changes its PF_NOFREEZE state after passing the early check in
> try_to_freeze_task(), we might skip freezing it incorrectly, leading to
> inconsistent behavior or unexpected task escapes. This is particularly
> tricky for some kernel threads or exit paths where PF_NOFREEZE is
> manipulated as part of cleanup or teardown.

A quick browse through the code seems to suggest that for user tasks,
PF_NOFREEZE is set just like exit_state, once at death.

For kernel threads the situation is a little more complex; but typically
a kthread is spawned with PF_NOFREEZE set, and then some will clear it
again, but always before then calling a TASK_FREEZABLE wait.

The only thing I didn't fully investigate is this
{,un}lock_system_sleep() thing. But that would appear to need at least
the below fixlet.

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3d484630505a..a415e7d30a2c 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -52,8 +52,8 @@ void pm_restrict_gfp_mask(void)
 unsigned int lock_system_sleep(void)
 {
 	unsigned int flags = current->flags;
-	current->flags |= PF_NOFREEZE;
 	mutex_lock(&system_transition_mutex);
+	current->flags |= PF_NOFREEZE;
 	return flags;
 }
 EXPORT_SYMBOL_GPL(lock_system_sleep);


Anyway, this seems to suggest something relatively simple like this here
should do:

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 8d530d0949ff..8b7cecd17564 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -162,20 +162,22 @@ static bool __freeze_task(struct task_struct *p)
  */
 bool freeze_task(struct task_struct *p)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&freezer_lock, flags);
-	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
-		spin_unlock_irqrestore(&freezer_lock, flags);
+	/*
+	 * User tasks get NOFREEZE in do_task_dead().
+	 */
+	if ((p->flags & (PF_NOFREEZE | PF_KTHREAD)) == PF_NOFREEZE)
 		return false;
-	}
 
-	if (!(p->flags & PF_KTHREAD))
-		fake_signal_wake_up(p);
-	else
-		wake_up_state(p, TASK_NORMAL);
+	scoped_guard (spinlock_irqsave, &freezer_lock) {
+		if (!freezing(p) || frozen(p) || __freeze_task(p))
+			return false;
+
+		if (!(p->flags & PF_KTHREAD))
+			fake_signal_wake_up(p);
+		else
+			wake_up_state(p, TASK_NORMAL);
+	}
 
-	spin_unlock_irqrestore(&freezer_lock, flags);
 	return true;
 }
 

