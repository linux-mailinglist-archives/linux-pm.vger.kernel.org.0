Return-Path: <linux-pm+bounces-34382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9761AB51B82
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C83B7ADD
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE631AF37;
	Wed, 10 Sep 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqHbgIX9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCA311944
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517852; cv=none; b=LcuE+Ur8+2uK5Y6BERXIuloC5vGKa6h4tSgbE38PJISXF8vTO6ujn4bT5PiVxnRWmCBAUGiDdlq1q0CSrAuw9oFm0GzQ4t6faCV0cne303CoTRLZ5n/RdlQp4oZwdwpzUggwvCBosAjsmdFuVNOq2Ljm5MKFumInqE0ziWcm/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517852; c=relaxed/simple;
	bh=iiw06wgl+p4NfUCoi92iJwzwIpiHapGdLTCxziJrQ2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyuThM1r0yz8+cliiAJ8uUa6X2BF6tcv0pVidDAmmTsjRUEd37L+kr3ubEzCDDwxODkQfoRoxuC9Ug0Eqwfi8UtEkziVq7cBIEPNhZ35TL2a9KH6i90RRooZuMPV/RXvYjOqY9fIQpUVXgxa0om8QVu7TxvA+LlYMJ9CvEpRprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqHbgIX9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61ed6eeaff9so7309a12.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757517849; x=1758122649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLzimIwCrnqvV3j5sA3GYOxbGdhxDlHB4mZ0xdr+3d4=;
        b=jqHbgIX9rmmTigVnLvQ1FA74phLOJRD9iGMuvs69TKzA2gbjGL6/ORUTrtbMbI5jvl
         ekSTwnPt4DG7CO+lzJ47PAtKCU6vtfdhsMnFufXvxAicnMpOQb03ymgZp8Lg7x0FbaLG
         NZ+nucc8gEVskQzkjHGU5FUUbIo1Wt9YYiM6sakvf7rqVQ6xXtrKz16uSiz/Rv4vKA2T
         VqBHAQeLlGaAaN1NINwfNvpO+c38M+71a4MWfFojmBEGYbKRnF8zfVmFtK5jERyWAUjq
         u/kK30f3to3WTurkcP31dCidc0AiTu987aj7NpGKyL2/w7u+kbpgMos0/G5q4ntNaZsw
         lU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517849; x=1758122649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLzimIwCrnqvV3j5sA3GYOxbGdhxDlHB4mZ0xdr+3d4=;
        b=sKkiAqVzGP9ApyOR3aSAjj4yPzBpcwJca146RBQN9S5dndkGAtt7x5V5Ng+mmC2A92
         Ifv8JRpNfZksoJ0x9d83vyHQalGaTBfBTp7Zh0PKUCGuTchui+k1zX1ZGOsfon/BQKgu
         xomahvXkMQ6MJpMi8JBHFD6Ko+81W/rK+/yqV4ndEZe353X5agNYRSgtazFIRLfbr1pA
         61mWU2klpqb1d33hdWlG8GdrL7bH9oKqN94j2EQs8O2VinONH7eD0lENMlp3gOVoaUJt
         ydQJAdph/9bS+u9zmGi3jqGlpV/Np4wHP1bi0IOIGqf7ZDZ0zi5ce9Xx02FiC+RuQjoP
         E+og==
X-Forwarded-Encrypted: i=1; AJvYcCUXle7oSVf5/OAcBHRUEvW/WwDqIdCCR90XNh/wL1YeqsikJ1rQash0ks9A3I+K8YabSnHSPAibqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUCZYIRMl2dq6TIO0+qJvhawL0fv4IbSeIuDMPtukiB1JgjX3
	m56FWOeAK/fEaqI92NfBmyQpKRFvdoat8whkNCODkhFy9N/D3y4Q947GaECtIdb1rCqH/eIutLp
	OMul3XwXdCZmaPIGlKZMa8wpw1QoauwuPBEyFpZS2
X-Gm-Gg: ASbGncsvHbP6as/vDlyvdnO6kJ3dh5ND2Lbew0PEemPpKojaldFBgM/o5tcM+XzUgbJ
	WcC8BLALcVlrEnOTL/sx4YHJ5EJQKQIL9Kj74Z283rFaGMxI+gNzvMC5kkiaectDNZes8z/vKtc
	2NmUJgvOFpmLUJX/utNK1aQUx0lX0RHcZPadN6gqC0IQG5icP1myavdMkhT1Ok93lXWaEqAHjyL
	ldOoxG91COgnRb5sYUK3iAiCH5NMYXXKHjRSNM+OSw=
X-Google-Smtp-Source: AGHT+IF5Ohw+Igdpiqfr2NaLOCuYq2aGHC6zAz0SPaARab0f2dpehIyUKQUWFW1zcPOADAw5vISpP/RgxkTdWGpY8YI=
X-Received: by 2002:aa7:d5cc:0:b0:61c:32fb:999b with SMTP id
 4fb4d7f45d1cf-62d4e5c8ed1mr83463a12.1.1757517848839; Wed, 10 Sep 2025
 08:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910143726.19905-1-zhongjinji@honor.com> <20250910143726.19905-2-zhongjinji@honor.com>
 <aMGWAg5jIitYCXdZ@tiehlicka>
In-Reply-To: <aMGWAg5jIitYCXdZ@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Sep 2025 08:23:56 -0700
X-Gm-Features: AS18NWAJ45hQ9B-n7p6XQn7GBwUVm3h_aYmSoIZyWzjk4e_caUPvzXaPHJVMs7E
Message-ID: <CAJuCfpEu_pq5kDgQ2jDnWVNuzVPrMKz2Gw0EeoPU6WD38aBXVA@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] mm/oom_kill: Thaw the entire OOM victim process
To: Michal Hocko <mhocko@suse.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, tglx@linutronix.de, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, lenb@kernel.org, rafael@kernel.org, 
	pavel@kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liulu.liu@honor.com, feng.han@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 10-09-25 22:37:25, zhongjinji wrote:
> > OOM killer is a mechanism that selects and kills processes when the sys=
tem
> > runs out of memory to reclaim resources and keep the system stable. But=
 the
> > oom victim cannot terminate on its own when it is frozen, even if the O=
OM
> > victim task is thawed through __thaw_task(). This is because __thaw_tas=
k() can
> > only thaw a single OOM victim thread, and cannot thaw the entire OOM vi=
ctim
> > process.
> >
> > Also, freezing_slow_path() decides whether a task is an OOM victim by c=
hecking
> > the task's TIF_MEMDIE flag. When a task is thawed, the freezer bypasses=
 PM
> > freezing and cgroup freezing states to thaw it. But TIF_MEMDIE is not a=
 thread
> > group shared flag, and only one thread is marked with TIF_MEMDIE. If ot=
her
> > threads are thawed, they may still remain frozen due to PM freezing and=
 cgroup
> > freezing states.
> >
> > To solve this, thaw_process() is introduced to thaw all threads of the =
victim,
> > ensuring every thread in the victim process can be thawed. The freezer =
uses
> > tsk_is_oom_victim() to determine whether a task is an OOM victim, becau=
se
> > tsk->signal->oom_mm is data shared by all threads. This allows all vict=
im threads
> > to rely on it to be thawed.
>
> A history detour for future reference.
> TIF_MEMDIE was a "this is the oom victim & it has access to memory
> reserves" flag in the past. It has that thread vs. process problems and
> tsk_is_oom_victim was introduced later to get rid of them and other
> issues as well as the guarantee that we can identify the oom victim's mm =
reliably
> for other oom_reaper. I recommend reading git log of mm/oom_kill.c to
> get hairy history of that area and how tricky it is due all the subtle
> interaction with process exit paths etc.
>
> >
> > This change will thaw the entire victim process when OOM occurs,
> > ensuring that the oom victim can terminate on its own.
> >
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  include/linux/freezer.h |  2 ++
> >  kernel/freezer.c        | 20 +++++++++++++++++++-
> >  mm/oom_kill.c           | 10 +++++-----
> >  3 files changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> > index b303472255be..32884c9721e5 100644
> > --- a/include/linux/freezer.h
> > +++ b/include/linux/freezer.h
> > @@ -47,6 +47,7 @@ extern int freeze_processes(void);
> >  extern int freeze_kernel_threads(void);
> >  extern void thaw_processes(void);
> >  extern void thaw_kernel_threads(void);
> > +extern void thaw_process(struct task_struct *p);
> >
> >  static inline bool try_to_freeze(void)
> >  {
> > @@ -80,6 +81,7 @@ static inline int freeze_processes(void) { return -EN=
OSYS; }
> >  static inline int freeze_kernel_threads(void) { return -ENOSYS; }
> >  static inline void thaw_processes(void) {}
> >  static inline void thaw_kernel_threads(void) {}
> > +static inline void thaw_process(struct task_struct *p) {}
> >
> >  static inline bool try_to_freeze(void) { return false; }
> >
> > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > index 6a96149aede9..ddc11a8bd2ea 100644
> > --- a/kernel/freezer.c
> > +++ b/kernel/freezer.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/export.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/freezer.h>
> > +#include <linux/oom.h>
> >  #include <linux/kthread.h>
> >
> >  /* total number of freezing conditions in effect */
> > @@ -40,7 +41,7 @@ bool freezing_slow_path(struct task_struct *p)
> >       if (p->flags & (PF_NOFREEZE | PF_SUSPEND_TASK))
> >               return false;
> >
> > -     if (test_tsk_thread_flag(p, TIF_MEMDIE))
> > +     if (tsk_is_oom_victim(p))
> >               return false;
> >
> >       if (pm_nosig_freezing || cgroup_freezing(p))
> > @@ -206,6 +207,23 @@ void __thaw_task(struct task_struct *p)
> >               wake_up_state(p, TASK_FROZEN);
> >  }
> >
> > +/*
> > + * thaw_process - Thaw a frozen process
> > + * @p: the process to be thawed
> > + *
> > + * Iterate over all threads of @p and call __thaw_task() on each.
> > + */
> > +void thaw_process(struct task_struct *p)
> > +{
> > +     struct task_struct *t;
> > +
> > +     rcu_read_lock();
> > +     for_each_thread(p, t) {
> > +             __thaw_task(t);
> > +     }
> > +     rcu_read_unlock();
> > +}
> > +
> >  /**
> >   * set_freezable - make %current freezable
> >   *
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 25923cfec9c6..88356b66cc35 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -772,12 +772,12 @@ static void mark_oom_victim(struct task_struct *t=
sk)
> >               mmgrab(tsk->signal->oom_mm);
> >
> >       /*
> > -      * Make sure that the task is woken up from uninterruptible sleep
> > -      * if it is frozen because OOM killer wouldn't be able to free
> > -      * any memory and livelock. freezing_slow_path will tell the free=
zer
> > -      * that TIF_MEMDIE tasks should be ignored.
> > +      * Make sure that the process is woken up from uninterruptible sl=
eep
> > +      * if it is frozen because OOM killer wouldn't be able to free an=
y
> > +      * memory and livelock. The freezer will thaw the tasks that are =
OOM
> > +      * victims regardless of the PM freezing and cgroup freezing stat=
es.
> >        */
> > -     __thaw_task(tsk);
> > +     thaw_process(tsk);
> >       atomic_inc(&oom_victims);
> >       cred =3D get_task_cred(tsk);
> >       trace_mark_victim(tsk, cred->uid.val);
> > --
> > 2.17.1
>
> --
> Michal Hocko
> SUSE Labs
>

