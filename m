Return-Path: <linux-pm+bounces-7702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2B8C19F0
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 01:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4661283494
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D291112FF6B;
	Thu,  9 May 2024 23:31:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DB12D776
	for <linux-pm@vger.kernel.org>; Thu,  9 May 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715297518; cv=none; b=T6uIT9OJUUi6EAFS8mq+qeJNBJCX510qWprkfzksgKqRold0/QXrTnpMPhNl+TwfE/b+YvhPgE+e4SLsNmyFdVnOzUGji3FUMC8zxGv5eZPMQZRbnWeLfF8H36wexn38m/W8qyCjZj5HS8sGFT88/LxGpmVcoJPjgo69LPeSpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715297518; c=relaxed/simple;
	bh=V+rCr67uHkl0wFx0HPMuybpjVQOyY8Iy1PgN91wLt/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsJs3Ckl7FiX671TPlYkfavtDntlojZgDARrDe50R+4dkXsAMOFFZwT+JMrburovyRYWA+RXAMN65YIt9x6mLiYgPmpBvovA9MGsMi0UW7KdbcwxDgWQ1c8HEgOH6NePsh5JRUv22wHID7Vy1e8vWu/qLj9zfuncZ2yJF8NlthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.62])
	by sina.com (10.75.12.45) with ESMTP
	id 663D5B9E00002727; Thu, 10 May 2024 07:26:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 90088931457849
X-SMAIL-UIID: EC1BAA6034F24FC3BF2264438E715D3A-20240510-072626-1
From: Hillf Danton <hdanton@sina.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
Date: Fri, 10 May 2024 07:26:13 +0800
Message-Id: <20240509232613.2459-1-hdanton@sina.com>
In-Reply-To: <CAOQ4uxg8karas=5JxmCg0P5Wxhfzn41evgs_OUxd1GxBRpb4zQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 9 May 2024 17:52:21 +0300 Amir Goldstein <amir73il@gmail.com>
> On Thu, May 9, 2024 at 1:49 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > The correct locking order is
> >
> >                 sb_writers
> 
> This is sb of overlayfs
> 
> >                 inode lock
> 
> This is real inode
> 
WRT sb_writers the order

	lock inode parent
	lock inode kid

becomes
	lock inode kid
	sb_writers
	lock inode parent 

given call trace

> -> #2 (sb_writers#4){.+.+}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1664 [inline]
>        sb_start_write+0x4d/0x1c0 include/linux/fs.h:1800
>        mnt_want_write+0x3f/0x90 fs/namespace.c:409
>        ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
>        lookup_open fs/namei.c:3497 [inline]
>        open_last_lookups fs/namei.c:3566 [inline]

and code snippet [1]

	if (open_flag & O_CREAT)
		inode_lock(dir->d_inode);
	else
		inode_lock_shared(dir->d_inode);
	dentry = lookup_open(nd, file, op, got_write);

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/namei.c?id=dccb07f2914c#n3566

