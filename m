Return-Path: <linux-pm+bounces-21758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6576A2FF03
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4522318890CD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD31EA65;
	Tue, 11 Feb 2025 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MrR22n2P"
X-Original-To: linux-pm@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AF914A82;
	Tue, 11 Feb 2025 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233396; cv=none; b=J0hqqZ9UUhL3AF6Qt0QWpeJ+EkP1NXFXrxnZPidP+Tc/kqMu1Qcmo8RO25uiQKimSPMVA8lbzcGW+z6Qew56r48/qRC2Fl2dCU1tL4ASi2/VIi8cnFDXP6R4f5pHcUq4sbQaUfQEhAIuyqXfyZ9sVONsBIObakKnYa2lJT1NflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233396; c=relaxed/simple;
	bh=mRA1cmlIzeoIX7wF5rfgohB3epABVAJ4qc6TtgGETj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/H1paJzG9UC5AQiLPX20yRTZDyTOe7gR6aNRS4eDFOfqZaU7t5Fy1bUJS8XaN5FDNDenHwm6vZ9Rsv4aAtORImNPFokeLufdqTnQUmDUYbfynRqnbsdd/YH0pNV+7RdVoU+azI2Qoeq6HAIYqBb/h+q3CmDpWbBEqwF3aMXBLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MrR22n2P; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hxh+YLiePD6ZgxfNUFuR9y84+we8TJD73uUNEi8TGDs=; b=MrR22n2P22D9bKN+nX+/5LZZhQ
	FAtHYT48N+Fn8jooEN1ucJkh4AftyWb3IdWm2cg06+2HpESEtYWOT6VcD6PdBcr4ANQwzvMQ4KLEt
	ut/LnVp11xNuKE3YKdIpJh3wfMcZqrSQHWmAZo10o2G60vFt3AVM2AgJvu7CfO3KGcke13JcVa7ln
	wzw/ncNbh163hZYncIssruF2UBNhlIF+uvl/rBCEJIJszWeC8Fl8gyUOTNCEVdDtnJym4EVnjyDJB
	52r569/UsEHnhWApqEWBmn8UMzctbdk5OrrEDZJbXDUxqPLl22lbYe4al+nqkzJ4DlHybyF85/gIY
	u3La6uRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1the3Q-00000009zX0-2Tt6;
	Tue, 11 Feb 2025 00:23:08 +0000
Date: Tue, 11 Feb 2025 00:23:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Zicheng Qu <quzicheng@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, jlayton@kernel.org,
	axboe@kernel.dk, joel.granados@kernel.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, hch@lst.de, len.brown@intel.com,
	pavel@ucw.cz, pengfei.xu@intel.com, rafael@kernel.org,
	syzkaller-bugs@googlegroups.com, linux-pm@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH] acct: Prevent NULL pointer dereference when writing to
 sysfs
Message-ID: <20250211002308.GG1977892@ZenIV>
References: <20250127091811.3183623-1-quzicheng@huawei.com>
 <20250210131719.528717-1-quzicheng@huawei.com>
 <20250210-unordnung-petersilie-90e37411db18@brauner>
 <20250210152146.GC1977892@ZenIV>
 <20250210-erstsemester-eckpunkte-f2f0d922ed01@brauner>
 <20250210181902.GE1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210181902.GE1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 10, 2025 at 06:19:02PM +0000, Al Viro wrote:
> On Mon, Feb 10, 2025 at 05:02:35PM +0100, Christian Brauner wrote:
> > On Mon, Feb 10, 2025 at 03:21:46PM +0000, Al Viro wrote:
> > > On Mon, Feb 10, 2025 at 04:12:54PM +0100, Christian Brauner wrote:
> > > 
> > > > One fix would be to move exit_fs() past exit_task_work(). It looks like
> > > > that this should be doable without much of a problem and it would fix
> > > > the path_init() problem.
> > > > 
> > > > There should hopefully be nothing relying on task->fs == NULL in
> > > > exit_task_work().
> > > 
> > > There's a question of the task_work_add() issued by exit_task_fs(),
> > > though.
> > 
> > Can't we simply remove the pins on the mounts of fs->root and fs->pwd in
> > exit_fs() explicitly? If that works I think that's a fair enough
> > compromise for this shite.
> 
> I'd rather go for a simpler approach...  Why do we need those writes
> to be done in context of exiting process in the first place?  It's
> not as if they needed to go out before it terminates, so what's to
> stop us from having a kernel thread in background and queue the data
> to be written for it to pick up?
> 
> Does anybody see problems with that approach?

Note, BTW, that games with rlimit and creds switching disappear if done
that way.  

FWIW, I wonder if we should simply allocate a page worth of buffer,
occupied by acct_t array, with count + pointer to buffer kept in acct,
with acct->mutex used to protect the entire thing, so that do_acct_process()
would add a record to that sucker and wake the kthread up, with kthread
handling actual writes and emptying the buffer.  No need for exit(2)
to wait unless the buffer is full...

