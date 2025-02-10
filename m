Return-Path: <linux-pm+bounces-21722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97FCA2F6C2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720DE188AE27
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE82566F6;
	Mon, 10 Feb 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a1C5nVOZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C37255E29;
	Mon, 10 Feb 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211549; cv=none; b=CVqpR7wjR0TYwfTFZXEP5n+IUrbOVn8hjCygwnCF5RoD7RjGPLD+KzWZ7uKd6hVEms/MKZL7qdolI9dG39VZXHHo/rxG3fluQUee5mazT5g57Byd94Ubx4NHy+2Fm7HJHwdV2isRGO4d14JUWzPaH3yzcIHp9Q3XvJHAZI4se7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211549; c=relaxed/simple;
	bh=UfE+rMQNmgA+sHSmDsa1hZh19rbUWEQL6BbCIF3zKHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZRchDduzkNbteO5STuhh0d8CMd8hdznY6zse3lB/MXF6GesE381BQP9q8L826Wg+N0qo69mGCnJvs4/D1o+6dtASm4LqjkLPfqrI7c43kMh7mRDMROi9iqz6fS4v8k+flAdvW7XSmeRi1NaIm9WsO0cXbPaUM9XnZ+IATCR1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a1C5nVOZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DgHnzerLbExQSTgDRSZcWE+bzYwaMHRj1ZVldrd4BcY=; b=a1C5nVOZxfPSMkaxdQWzmd35Xw
	mCZ8IvPhTl3nJmjWrmW8A0ln4EiewDN5GHFeSSWXcAW5lIdAaRIST6j9HwL6BV9VpM6LvFdT4L+4l
	7sqZxc4bntJteAQ4RKwdlAM2hPyeIc6dkTpQ+fwyuAd0BpmYjk1vG6b28111XpDfuMugKXahYjRVf
	MS+ys4/jEUrIsoHZ+J79bQpz5GzAbf12fV21klsYeq5fyy+Vql5iJLGWCjaSl+vyYAFrYTAgc6jBQ
	RS+dtzNB5CYd3BWlikVBaBroBLWaCyUPtxtZSoC8OLdAjmoPXQT1mv/gPc8kJtBQQQci0QH+Ylkqx
	ipPO/y9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thYN4-00000009hZz-1FaM;
	Mon, 10 Feb 2025 18:19:02 +0000
Date: Mon, 10 Feb 2025 18:19:02 +0000
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
Message-ID: <20250210181902.GE1977892@ZenIV>
References: <20250127091811.3183623-1-quzicheng@huawei.com>
 <20250210131719.528717-1-quzicheng@huawei.com>
 <20250210-unordnung-petersilie-90e37411db18@brauner>
 <20250210152146.GC1977892@ZenIV>
 <20250210-erstsemester-eckpunkte-f2f0d922ed01@brauner>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-erstsemester-eckpunkte-f2f0d922ed01@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 10, 2025 at 05:02:35PM +0100, Christian Brauner wrote:
> On Mon, Feb 10, 2025 at 03:21:46PM +0000, Al Viro wrote:
> > On Mon, Feb 10, 2025 at 04:12:54PM +0100, Christian Brauner wrote:
> > 
> > > One fix would be to move exit_fs() past exit_task_work(). It looks like
> > > that this should be doable without much of a problem and it would fix
> > > the path_init() problem.
> > > 
> > > There should hopefully be nothing relying on task->fs == NULL in
> > > exit_task_work().
> > 
> > There's a question of the task_work_add() issued by exit_task_fs(),
> > though.
> 
> Can't we simply remove the pins on the mounts of fs->root and fs->pwd in
> exit_fs() explicitly? If that works I think that's a fair enough
> compromise for this shite.

I'd rather go for a simpler approach...  Why do we need those writes
to be done in context of exiting process in the first place?  It's
not as if they needed to go out before it terminates, so what's to
stop us from having a kernel thread in background and queue the data
to be written for it to pick up?

Does anybody see problems with that approach?

