Return-Path: <linux-pm+bounces-7716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C15F8C23AB
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 13:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C8B1F23F7D
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 11:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0217089A;
	Fri, 10 May 2024 11:33:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B616F29C
	for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340822; cv=none; b=uZCYK8e9UTNvWdRnAmQ82N7wwlI1nQYk4+RuqIRpq5e+lM7pS1az+p2yDIW34prNaq++9ydQMFSB0+zangO0mqKKfT/uTdTzYIPYm6lynKxsaFhZgcdpLaah8QZ8LNXp0V4X0F+F2Zi/s54rb+IvkIfOWWjeJ5kU3VonX6ooKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340822; c=relaxed/simple;
	bh=kWpB3hlt/N31SYsdYtQFsLZZ1ccECn5dZ0BwMIjrR7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+JU0f06Qvm1IVhSHCXvqIgu3yI6kgK6hvFKZ1t3F7zhDXu2q0IeX+L8w7MCGEEGPDfoFrgqDmFbb3VT4QpuABwwLJaTjYGYFnfLuhjR1WqBfd5ATOLhXk9XpV/oORcFqYLt3fI+jpu1Z8wNdDt0Voa0bEn14wEQ399aYc1/+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.62])
	by sina.com (172.16.235.24) with ESMTP
	id 663E060600000C3E; Fri, 10 May 2024 19:33:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 73734345089264
X-SMAIL-UIID: A9B4E614A6134A958D504D06E0FA46DC-20240510-193328-1
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
Date: Fri, 10 May 2024 19:33:17 +0800
Message-Id: <20240510113317.2573-1-hdanton@sina.com>
In-Reply-To: <20240509232613.2459-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 May 2024 07:26:13 +0800 Hillf Danton <hdanton@sina.com> wrote:
> On Thu, 9 May 2024 17:52:21 +0300 Amir Goldstein <amir73il@gmail.com>
> > On Thu, May 9, 2024 at 1:49 PM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > The correct locking order is
> > >
> > >                 sb_writers
> > 
> > This is sb of overlayfs
> > 
> > >                 inode lock
> > 
> > This is real inode
> > 
> WRT sb_writers the order
> 
> 	lock inode parent
> 	lock inode kid
> 
> becomes
> 	lock inode kid
> 	sb_writers
> 	lock inode parent 
> 
> given call trace
> 
> > -> #2 (sb_writers#4){.+.+}-{0:0}:
> >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> >        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
> >        __sb_start_write include/linux/fs.h:1664 [inline]
> >        sb_start_write+0x4d/0x1c0 include/linux/fs.h:1800
> >        mnt_want_write+0x3f/0x90 fs/namespace.c:409
> >        ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
> >        lookup_open fs/namei.c:3497 [inline]
> >        open_last_lookups fs/namei.c:3566 [inline]
> 
> and code snippet [1]
> 
> 	if (open_flag & O_CREAT)
> 		inode_lock(dir->d_inode);
> 	else
> 		inode_lock_shared(dir->d_inode);
> 	dentry = lookup_open(nd, file, op, got_write);
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/namei.c?id=dccb07f2914c#n3566

JFYI simply cutting off mnt_want_write() in ovl_create_object() survived
the syzpot repro [2], so acquiring sb_writers with inode locked at least
in the lookup path makes trouble.

[2] https://lore.kernel.org/lkml/000000000000975906061817416b@google.com/

