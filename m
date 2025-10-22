Return-Path: <linux-pm+bounces-36681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B51BFE6B6
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 00:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05133A5107
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE852D739C;
	Wed, 22 Oct 2025 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="MKj3miII"
X-Original-To: linux-pm@vger.kernel.org
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DC1D798E
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172395; cv=none; b=hyJWnkD7xtC1cN6ToVFt6NzNalIjaf7jDpV5HEtLhzoVFHJdPTvKvr10X12obf096ixVDxj6wI7QgVbIFu5b1lc6vBNUFTu9izQm2URBwXvu9j3gSa+NicTJDSMPXVXe2MW7Z1+hC8I6tRv7GpLZzMtgbu0cYkwiTS5HCSmkovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172395; c=relaxed/simple;
	bh=dVfgEu9qcwOKno5SLXpEJ3JiPhsTPxK/YObQhXDy+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+ijNsZuGQlWXILrDyHBpsXkyGHoBYAaip087OJ5MHSudpK2vlCcq+0F9e9ycIU8LCFS4mwHYPTX8Q/M+XLM/QHeNyqZunoRE0IaVN35WKcwaC7oQDAInODv4l5Pyvt+vhy5z2oVBeeRN9ikoul2L/+XbLmIDd1sMzIrzQFRxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=MKj3miII; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1761172391;
	bh=b+8CUta4WIQPuZ+O6n5HcqH79h8cLw/nbd8oqpi9Oss=;
	h=From:Subject:Date:Message-ID;
	b=MKj3miII1ZF8dh6v3N2JMATJ4HLn9mdthnjA3aHwjJ+ueHFt8YgmA91V+YWuLsqio
	 ++BBIGTU5AvfY77abXaqtTKiGToA6on1v1GqdTYqX3ZTGKKtKf25nPTQFyLbWvScqH
	 jhaSJeiowLiXCyFu+4bEOkv+MWuFR9b/kATHpvas=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68F95B7C00006FD8; Wed, 23 Oct 2025 06:32:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9169206816204
X-SMAIL-UIID: E56726089A0E4746A66BEF4CFBB6559C-20251023-063229-1
From: Hillf Danton <hdanton@sina.com>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	kernel-team@android.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
Date: Thu, 23 Oct 2025 06:32:16 +0800
Message-ID: <20251022223218.8664-1-hdanton@sina.com>
In-Reply-To: <CAG2KctoJ+1x61KNmDj_52J1_Y3vyox7UNceFw6_WtbRMA_1vYA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 22 Oct 2025 11:41:37 -0700 Samuel Wu wrote:
> On Tue, Oct 21, 2025 at 6:16 PM Hillf Danton <hdanton@sina.com> wrote:
> > On Tue, 21 Oct 2025 13:13:39 -0700 Samuel Wu wrote:
> > > On Fri, Oct 17, 2025 at 5:17 PM Hillf Danton <hdanton@sina.com> wrote:
> > > > On Fri, 17 Oct 2025 23:39:06 +0000 Samuel Wu wrote:
> > > > > +/**
> > > > > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > > > > + *
> > > > > + * Return 0 on successful file system sync, otherwise returns -EBUSY if file
> > > > > + * system sync was aborted.
> > > > > + */
> > > > > +int pm_sleep_fs_sync(void)
> > > > > +{
> > > > > +     bool need_pm_sleep_fs_sync_requeue;
> > > > > +     unsigned long flags;
> > > > > +
> > > > > +     do {
> > > > > +             spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > > > +             reinit_completion(&pm_sleep_fs_sync_complete);
> > > >
> > > > Given difficulty following up here, can you specify why reinit is needed?
> > >
> > > There are two possibilities that make reinit_completion() necessary:
> > > 1. Suspend abort triggers completion, but is canceled before
> > > pm_wakeup_pending(), so need reinit to restart the
> > > wait_for_completion() process.
> > > 2. Handling back-to-back suspend attempts: after a subsequent suspend
> > > attempt finishes waiting for a previous suspend's fs_sync to finish,
> > > we need the reinit to start the wait_for_completion() process of the
> > > subsequent suspend's fs_sync.
> > >
> > If 1. and 2. matches the comment for wait_for_completion() below,
> >
> >         static DECLARE_COMPLETION(foo);
> >
> >         waiter          waker1          waker2
> >         ---             ---             ---
> >         for (;;) {
> >           reinit_completion(&foo)
> >           do anything
> >           wait_for_completion(&foo)
> >                         do bar1         do bar2
> >                         complete(&foo)  complete(&foo)
> >           if (end)
> >                 break;
> >         }
> >
> > the chance for reinit to drop one wakeup is not zero.
> > If drop makes sense, for what do you wait after receiving two wakeups?
> >
> 
> If I understand correctly, you are referring to the case where
> multiple wakers trigger wait_for_complete() simultaneously, hence
> having at least one waker's complete() being ignored?
> 
> If so, I see two possibilities with multiple wakers:
> 1. fs_sync finishing + suspend abort1 + ... + suspend abortN
> 2. suspend abort1 + ... + suspend abortN
> 
> Simplifying, if two wakers come in simultaneously, while one of the
> wakers may have its complete() ignored, the state of that waker is
> still checked after wait_for_completion(), with
> if(pm_wakeup_pending()) and while(need_pm_sleep_fs_sync_requeue) for
> suspend aborts and fs_sync finishing respectively.
> 
Note one of the two wakeups may come after the two checks.

       reinit_completion(&foo)
       do anything
       wait_for_completion(&foo)
       		complete(&foo) from waker1
       check1
       check2
       		complete(&foo) from waker2 // dropped by reinit

> > > > > +             /*
> > > > > +              * Handle the case where a sleep immediately follows a previous
> > > > > +              * sleep that was aborted during fs_sync. In this case, wait for
> > > > > +              * the previous filesystem sync to finish. Then do another
> > > > > +              * filesystem sync so any subsequent filesystem changes are
> > > > > +              * synced before sleeping.
> > > > > +              */
> > > > > +             if (pm_sleep_fs_sync_queued) {
> > > > > +                     need_pm_sleep_fs_sync_requeue = true;
> > > > > +             } else {
> > > > > +                     need_pm_sleep_fs_sync_requeue = false;
> > > > > +                     pm_sleep_fs_sync_queued = true;
> > > > > +                     schedule_work(&sync_filesystems);
> > > > > +             }
> > > > > +             spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > > > > +
> > > > > +             /*
> > > > > +              * Completion is triggered by fs_sync finishing or an abort sleep
> > > > > +              * signal, whichever comes first
> > > > > +              */
> > > > > +             wait_for_completion(&pm_sleep_fs_sync_complete);
> > > > > +             if (pm_wakeup_pending())
> > > > > +                     return -EBUSY;
> > > > > +     } while (need_pm_sleep_fs_sync_requeue);
> > > > > +
> > > > > +     return 0;
> > > > > +}

