Return-Path: <linux-pm+bounces-21803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D0DA30848
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 11:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DA51888435
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40891F3FD1;
	Tue, 11 Feb 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmLoEzmG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23226BDA9;
	Tue, 11 Feb 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269035; cv=none; b=ZeZDij32gergkxDYO++Y308qDLMrBZGJ4rNqgTaWYv+FOW3+ge3+TbmFJtRRzkxWbVct2OeRjkUQJQjrayruG9C8sfaClJ7+lSS0ye2D26fyVyX3rzWoFER+VlnJMYSoOzGh3YJpdZRYxor/agv9Qw6/B1Lb7iA6cTVV6n4CGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269035; c=relaxed/simple;
	bh=pcADtuRlu6BZw4eXznSk/MgH09vrV1zqcaWCmhUVR4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUGO6HueguVogcfwSi07pauUIyPg755JidS9ngDZRHCc/6t01jDwdKmfo2d33VKCfryv1CQWUvpCLmRx1PlMH3INTBKccRJzB1VGdmYnH0ivolbjCGzL53spJNf7euXhOSJxuN0PepUSzuNgOAJXw1cd6ZC09/OBYs/wNlG9tOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmLoEzmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41594C4CEDD;
	Tue, 11 Feb 2025 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739269034;
	bh=pcADtuRlu6BZw4eXznSk/MgH09vrV1zqcaWCmhUVR4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmLoEzmGW8nPqdBqkVkymo86D7XEXRXJwhHr+zMECwpZNrYvWDWKQ1nO5BgkItKsp
	 Zz89SRnKEsEMbRCiGrOuC8mvLDIgZg4fIwM8cRTqcSnlESdcz6+pGYhk3wIG3eKK8J
	 aJ5G44kTbtBIUGL/Lt1nMv6YyhrWyyZ1wuWSfaOZie7GnXQF5KsstHkYpE77hfpDjy
	 du3AEdiEGX3NgKTr0xeaubuX4peEa0qqDWxjG2uZf9F8ojr3Fewk48tBcwjxVzG1wf
	 Cd9KVDBEBp6E86vVOsQm1HS3d6U1qf67eVZ6c8ODvPdp2nPD+eNixUjg8/Grm+vh2J
	 HKeRHg3cnd+4A==
Date: Tue, 11 Feb 2025 11:17:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Zicheng Qu <quzicheng@huawei.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, jlayton@kernel.org, axboe@kernel.dk, joel.granados@kernel.org, 
	tglx@linutronix.de, linux-kernel@vger.kernel.org, hch@lst.de, len.brown@intel.com, 
	pavel@ucw.cz, pengfei.xu@intel.com, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-pm@vger.kernel.org, tanghui20@huawei.com, 
	zhangqiao22@huawei.com, judy.chenhui@huawei.com
Subject: Re: [PATCH] acct: Prevent NULL pointer dereference when writing to
 sysfs
Message-ID: <20250211-anschaffen-leiht-9e803cc9b087@brauner>
References: <20250127091811.3183623-1-quzicheng@huawei.com>
 <20250210131719.528717-1-quzicheng@huawei.com>
 <20250210-unordnung-petersilie-90e37411db18@brauner>
 <20250210152146.GC1977892@ZenIV>
 <20250210-erstsemester-eckpunkte-f2f0d922ed01@brauner>
 <20250210181902.GE1977892@ZenIV>
 <20250211002308.GG1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211002308.GG1977892@ZenIV>

On Tue, Feb 11, 2025 at 12:23:08AM +0000, Al Viro wrote:
> On Mon, Feb 10, 2025 at 06:19:02PM +0000, Al Viro wrote:
> > On Mon, Feb 10, 2025 at 05:02:35PM +0100, Christian Brauner wrote:
> > > On Mon, Feb 10, 2025 at 03:21:46PM +0000, Al Viro wrote:
> > > > On Mon, Feb 10, 2025 at 04:12:54PM +0100, Christian Brauner wrote:
> > > > 
> > > > > One fix would be to move exit_fs() past exit_task_work(). It looks like
> > > > > that this should be doable without much of a problem and it would fix
> > > > > the path_init() problem.
> > > > > 
> > > > > There should hopefully be nothing relying on task->fs == NULL in
> > > > > exit_task_work().
> > > > 
> > > > There's a question of the task_work_add() issued by exit_task_fs(),
> > > > though.
> > > 
> > > Can't we simply remove the pins on the mounts of fs->root and fs->pwd in
> > > exit_fs() explicitly? If that works I think that's a fair enough
> > > compromise for this shite.
> > 
> > I'd rather go for a simpler approach...  Why do we need those writes
> > to be done in context of exiting process in the first place?  It's
> > not as if they needed to go out before it terminates, so what's to
> > stop us from having a kernel thread in background and queue the data
> > to be written for it to pick up?
> > 
> > Does anybody see problems with that approach?
> 
> Note, BTW, that games with rlimit and creds switching disappear if done
> that way.  
> 
> FWIW, I wonder if we should simply allocate a page worth of buffer,
> occupied by acct_t array, with count + pointer to buffer kept in acct,
> with acct->mutex used to protect the entire thing, so that do_acct_process()
> would add a record to that sucker and wake the kthread up, with kthread
> handling actual writes and emptying the buffer.  No need for exit(2)
> to wait unless the buffer is full...

I had thought about it but both LTP and the selftests want the buffer to
be filled after the process exits.

So let's not overly complicate this. I want this to be as simple as
possible and then start deprecating this api asap.

I have a patch that just moves the final write into the workqueue. But
let's keep the cred override because who knows what security hole we
open up if we skip the override cred.

