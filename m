Return-Path: <linux-pm+bounces-21710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB1A2F270
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189E47A35E9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61079244195;
	Mon, 10 Feb 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeMzVvs8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A981E283C;
	Mon, 10 Feb 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203364; cv=none; b=hWJAAJRdFh12pVp/WYfrR8J/b5VyEoXlpk8QlahN3nCU5FrzLCWluzrhDKfRd5zlLmt6PSkbrSgOyhQhV7Tnw6r1X9fzKVkfvTbjoltvs0KPVNX0uLnLJLkJjUOQGrb8B+kBspsEcmbLPLXhyrKtT3AjLbzlEHFRmD6scLEKZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203364; c=relaxed/simple;
	bh=4LZebtsJjVMW3bL1G3KYxi2tJi8LyA0u74DrAcHXvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oObT2vHjLcdJ8WX2B256yxgERWxjkx2Ewnkd8mJkWuxzW6/A6ALWjowvLIrofEZPJJ7n7S2bY3GnUjSHwoI917qW1AsLXZ6w0J3OiVABtCVHE3C5Nf8mHgyALgpXPb9kw6EU+XHAWB/pmD7Tu/BETlL1Pc6qlR10ts9rAZhpMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeMzVvs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AA1C4CED1;
	Mon, 10 Feb 2025 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739203362;
	bh=4LZebtsJjVMW3bL1G3KYxi2tJi8LyA0u74DrAcHXvRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YeMzVvs8+hTty3Lx8I6BS397VLwtvDy1llw7EVUaX4CthnLUWbfz4RQ+IFANuQCfz
	 UBzl6oUse9WDty/wk4yMX7+HLIN52Hka4wL4WJwhYCe006DB0pZr4owYQ5a0Ij2LGH
	 kB7ciLFZO3luWqgtBYDZHLbURONxPKGRdCdvaGXCrITm1nQXsKbaO9U4/UEIEoJN0f
	 EGkKdO0uk0MpVtSxSn8jsTvHm+3Jj3ipc4rES5kLfUlcMruYX9B2xT0GDf32G4Mp07
	 hrTQ8VvXe0reD55UEhCMu6pLujDZu5pyE3d5WnaDUI+ZObqkc4jN2Zto6NI+7RDut9
	 TwpCyyCvrcldQ==
Date: Mon, 10 Feb 2025 17:02:35 +0100
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
Message-ID: <20250210-erstsemester-eckpunkte-f2f0d922ed01@brauner>
References: <20250127091811.3183623-1-quzicheng@huawei.com>
 <20250210131719.528717-1-quzicheng@huawei.com>
 <20250210-unordnung-petersilie-90e37411db18@brauner>
 <20250210152146.GC1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210152146.GC1977892@ZenIV>

On Mon, Feb 10, 2025 at 03:21:46PM +0000, Al Viro wrote:
> On Mon, Feb 10, 2025 at 04:12:54PM +0100, Christian Brauner wrote:
> 
> > One fix would be to move exit_fs() past exit_task_work(). It looks like
> > that this should be doable without much of a problem and it would fix
> > the path_init() problem.
> > 
> > There should hopefully be nothing relying on task->fs == NULL in
> > exit_task_work().
> 
> There's a question of the task_work_add() issued by exit_task_fs(),
> though.

Can't we simply remove the pins on the mounts of fs->root and fs->pwd in
exit_fs() explicitly? If that works I think that's a fair enough
compromise for this shite.

