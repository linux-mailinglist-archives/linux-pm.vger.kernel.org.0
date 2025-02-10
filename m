Return-Path: <linux-pm+bounces-21707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B18A2F15A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0A23A7FD3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80924204863;
	Mon, 10 Feb 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="isLI5Xei"
X-Original-To: linux-pm@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8D1F8BAA;
	Mon, 10 Feb 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200913; cv=none; b=U4ODdxDsDPByIWtc8TrXq/6GjLsCmEjRyc7R8FNSzFhN3GGwsilRwJJuKrrzPiGu3vMNKP/RgMT0V3x2Hd5PsK1IL1EHW7S9TgGeMl4nbTb+5+72SYr9RgFsMWxh09nGY2iIP0lgzk/v+qftQ0myx4MKqat21MpxRE/vhuWHepM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200913; c=relaxed/simple;
	bh=N63rckgu7YeDTlrGdY7I3EdEqqfoWORrX4kM0S+DqCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLtKncLRmrDswKhSyQ0UhRUcQZvAjH1nqyRyVzgB9aDGy6QVCjlTU47kdyjKd0cW2622APbRh7/mG2bJ49QMmokQEBQ+4Wqc2ffCmk38VzhHuPvg2kv12zHUOB9eipAvDpUvhN9a9n6PoA+uCvz6081vMc2sntc/C8HDlxCpUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=isLI5Xei; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5BedQmLPBz9afnm1+iT7TqMQZbizbYk99w/2/R5v3u4=; b=isLI5XeidOfAWirauz3ns+uxKa
	xRoG9Z+LubhDuEU4ARf21hoHGXf1RxJa9mQlvZ3tMggMAER4O9IFl0BKPgOWIA1Xs+4kk7+/nVR3B
	nFgf7N6IvZyKj2aiws24GkMI7S7PuLbmGnsMliUJpL+tz67s5T7r7O1Gkgb+KGrCD3KujpdNTobRX
	R/AVDtXqxIWQVISgs6e9dKnZLN+4W+GJ3gaTJ8V+AYSVTKibYMbRB/V0+tvI4URXL/luM25zn1P2V
	mPIqHXw1ZmXlAi2AYotg0pOU5x/5v5sXNSuE93KzzFsSAGqA2BpIkqsqDyuYNcmVbmFn/KkQoB9i6
	fJxK36MA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thVbW-00000009YZ9-11Ku;
	Mon, 10 Feb 2025 15:21:46 +0000
Date: Mon, 10 Feb 2025 15:21:46 +0000
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
Message-ID: <20250210152146.GC1977892@ZenIV>
References: <20250127091811.3183623-1-quzicheng@huawei.com>
 <20250210131719.528717-1-quzicheng@huawei.com>
 <20250210-unordnung-petersilie-90e37411db18@brauner>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-unordnung-petersilie-90e37411db18@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 10, 2025 at 04:12:54PM +0100, Christian Brauner wrote:

> One fix would be to move exit_fs() past exit_task_work(). It looks like
> that this should be doable without much of a problem and it would fix
> the path_init() problem.
> 
> There should hopefully be nothing relying on task->fs == NULL in
> exit_task_work().

There's a question of the task_work_add() issued by exit_task_fs(),
though.

