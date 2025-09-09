Return-Path: <linux-pm+bounces-34286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F7B5029A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390815E4E5D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB8352FCB;
	Tue,  9 Sep 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdbFqIsh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92A32BF3D
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435291; cv=none; b=iH7DPBRsDIfZm75AoXsw8qVQjy65ryzndw7ghF/ikkMWYU/lt5dggqeOxwGIKHTFJVbsDqOJDNuT3XKyR9pnJ6figf2IAyZSiZtq6oAur9lEY1eH8d6xuG6afLTd46fMaUHympZ7vWLlwk9vYPm6+K3SEvi3dk1OZwAC3xzEa1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435291; c=relaxed/simple;
	bh=Bfu/q70g4qkXvJ+aCWtK5cFxXwa5r13U7ZdrkTR/tDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hg3MGDc+cYlb9xmQSnfDDDJeGZtDw0hjUDDos0LdpGpkvYz+tpWXNhd0COWgzPL8aUD+1JThxVDTOBKVedYDM3+MkAXxsGJUT/xa1orw5ZuM9BClcyUqnDfaTZ7VYi/iQIm84uKBGSpgfOgptJ9cRUQ6XOc17XC7GM4MNV3nYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdbFqIsh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so29932a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757435287; x=1758040087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R024uDMeRukjQhwtWzFLUPKWOeALqxj2j0IhsvQc40=;
        b=QdbFqIshFCJqNv/waZI6kdYKxMq9T1+N5eY+9rK9QxYGd2twyD/aCdSCKx2Xd8GBiQ
         FSWaoTZo5423okKruxv2apORE4NV621bBhQGXPfy+g2F6dd0nTiP4sjpiMPle6Kborzn
         BubARwS9FpLpFh7jfLsrYETNIoppNBnC7ku8ZxTp+FhjU5uNgnh4GlHEpQsUDM3kwUeT
         Vta36UUQQVcvG7hqa/m/4mK06HesMC3or2/6+oBuuEKxVTlLf6sXUlhbW3qJ1MAX8urP
         AhNDvJV5QTH/xqhzgK3rSF44yebSusfOaUiG9iHy3GI+uBvXHT2WbHExa7/0pzXigu15
         cI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435287; x=1758040087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R024uDMeRukjQhwtWzFLUPKWOeALqxj2j0IhsvQc40=;
        b=q0413+Pu+0J3wVra+PYiMllXaK4UwNjMp38jMq7IElnpV9QfYSpAk0I537YhMBqlC0
         WAqQJlhi7jbYDoAxVWM8s2zPXZGhEsoD5fpGsYTWxKcp2TxmVFRUHbhF1EEe7AUzI1YZ
         QiFN/OFcogt7hIqt1QRC6XSSDD8osiu2Sp858PhfovKphXW67eEOIyfWd6eLXL+3IxkN
         zvr0Mf9bbFF1f/n1gaKzBPv0xms2qrxFRW7vlxKjjqEkhYdGJCXpRCKpq/VxrkVh2jrI
         szzFMVb8ikyCtVxDR14IwrchhHC93amNie0lXjAQkIfRvTdVvn+j7uLL90MWfJnmtPZN
         HTZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJU0ly+T1ErmkpsMxmSw4BLVERZbie6rP3ghpTR3VpceeSJuXpQ8NZWd7n2YGd+cNhxyNHLvlGvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXZr+ILUK3yZ2gzjdhW3bITUsZp1XBiur3wD/uqY2QhqF11nF
	FJvO2NgEc2sQTEiq8QP9cK+VrVgLxzJuyXieayKI0yED1PrfHnZuTBnN5aVV5M+KucP73kt+y8V
	vZTDrEpts1EsT/6WRZoAdDQZuNWTJoMjNSD8FY2xG
X-Gm-Gg: ASbGnctssyoQHzEP4h6cKk1UIvrGiIcr0aZe72v8pTngZFl7SzEzb98TW6ROe5/oLuw
	Nk/oesIbN186lv137Mli+XYXxC97oa3iSnn08lf9tCFV3WRff1KttCgVmnD583KZZFgeoHSG6jv
	BieHr9IlVoRuVPQEDSeAzKyP12UsPkMqJa9AeA1+H/8z3zGqEGWsUqKBxiEho6+IS0EhOY6nLbs
	MZc8ajHyYgMKhxAX/+xRbOq6WrboVdEf5oBn/4zVxha2osBBNG/eCbVvX4Udvks3A==
X-Google-Smtp-Source: AGHT+IH1Uhhf5BBfeDF4zGZtlC1s5NP0l7OWMVfHhYq8xDWfI1CfOUPWiiaKNAZGIlKbmXINaHykxfFIYVTCl7rGdqk=
X-Received: by 2002:aa7:c507:0:b0:61c:d709:ce04 with SMTP id
 4fb4d7f45d1cf-623d9478b3fmr319884a12.7.1757435287275; Tue, 09 Sep 2025
 09:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909090659.26400-1-zhongjinji@honor.com> <20250909090659.26400-2-zhongjinji@honor.com>
 <aL_wLqsy7nzP_bRF@tiehlicka>
In-Reply-To: <aL_wLqsy7nzP_bRF@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:27:54 -0700
X-Gm-Features: AS18NWDWAZ00qKFjmQMW4k7CpwsD03ZtkPqLFv7mxnsJUQMHeeHkz3WbdPRJr34
Message-ID: <CAJuCfpFCARoMJ8eniYdZ3hSaM_E3GvfRBV1VD1OohOfJpP87Hg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for
 thawing OOM victims
To: Michal Hocko <mhocko@suse.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, tglx@linutronix.de, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, lenb@kernel.org, rafael@kernel.org, 
	pavel@kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liulu.liu@honor.com, feng.han@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > OOM killer is a mechanism that selects and kills processes when the sys=
tem
> > runs out of memory to reclaim resources and keep the system stable.
> > However, the oom victim cannot terminate on its own when it is frozen,
> > because __thaw_task() only thaws one thread of the victim, while
> > the other threads remain in the frozen state.
> >
> > Since __thaw_task did not fully thaw the OOM victim for self-terminatio=
n,
> > introduce thaw_oom_process() to properly thaw OOM victims.
>
> You will need s@thaw_oom_process@thaw_processes@

Do you suggest renaming thaw_oom_process() into thaw_processes()
(s/thaw_oom_process/thaw_processes)? If so, I don't think that's a
better name considering the function sets TIF_MEMDIE flag. From that
perspective less generic thaw_oom_process() seems appropriate, no?

>
> I would also add the caller in this patch.
>
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
>
> Other than that looks good to me. With the above fixed feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >  include/linux/freezer.h |  2 ++
> >  kernel/freezer.c        | 19 +++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> > index b303472255be..19a4b57950cd 100644
> > --- a/include/linux/freezer.h
> > +++ b/include/linux/freezer.h
> > @@ -47,6 +47,7 @@ extern int freeze_processes(void);
> >  extern int freeze_kernel_threads(void);
> >  extern void thaw_processes(void);
> >  extern void thaw_kernel_threads(void);
> > +extern void thaw_oom_process(struct task_struct *p);
> >
> >  static inline bool try_to_freeze(void)
> >  {
> > @@ -80,6 +81,7 @@ static inline int freeze_processes(void) { return -EN=
OSYS; }
> >  static inline int freeze_kernel_threads(void) { return -ENOSYS; }
> >  static inline void thaw_processes(void) {}
> >  static inline void thaw_kernel_threads(void) {}
> > +static inline void thaw_oom_process(struct task_struct *p) {}
> >
> >  static inline bool try_to_freeze(void) { return false; }
> >
> > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > index 6a96149aede9..17970e0be8a7 100644
> > --- a/kernel/freezer.c
> > +++ b/kernel/freezer.c
> > @@ -206,6 +206,25 @@ void __thaw_task(struct task_struct *p)
> >               wake_up_state(p, TASK_FROZEN);
> >  }
> >
> > +/*
> > + * thaw_oom_process - thaw the OOM victim process
> > + * @p: process to be thawed
> > + *
> > + * Sets TIF_MEMDIE for all threads in the process group and thaws them=
.
> > + * Threads with TIF_MEMDIE are ignored by the freezer.
> > + */
> > +void thaw_oom_process(struct task_struct *p)
> > +{
> > +     struct task_struct *t;
> > +
> > +     rcu_read_lock();
> > +     for_each_thread(p, t) {
> > +             set_tsk_thread_flag(t, TIF_MEMDIE);
> > +             __thaw_task(t);
> > +     }
> > +     rcu_read_unlock();
> > +}
> > +
> >  /**
> >   * set_freezable - make %current freezable
> >   *
> > --
> > 2.17.1
>
> --
> Michal Hocko
> SUSE Labs

