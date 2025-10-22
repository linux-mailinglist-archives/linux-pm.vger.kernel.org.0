Return-Path: <linux-pm+bounces-36669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4157BFDEA8
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 20:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FB43A8FFA
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0262E34DCCE;
	Wed, 22 Oct 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4ABvbj4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2634D4CC
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158512; cv=none; b=M1Q0wRqN2vyJFGgFN73SeIm6YpHHjJHQ9YOyXPvz5jTBsKlM/PNue6ee0LwABBovrBkvB0LQun4y/yuQay7Xpwz2/acZQxsuAHTDdb+Or67FB/ZbWczNiG2TnuKTbi5XP9FiPU5KjmBd1qEo3PlWsEh/PBZ9cPJDk7pE1DqL+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158512; c=relaxed/simple;
	bh=4SsgFy3W8i6VYi5migZylUtx9+LlsgxxkwCdOCuq1ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O02Uf5Jx5TcUhKLSEp+s6IMNjn5wcMttB+fkjIpYu6djymTmm/vD4jjz5LGDOCC8Amudeli649CXgbOFIT2QlGUyljQbFvpIMI72JmiPWFz/ZVSXu+YTBlJ3eE5q4aWIAjtZT2C/ziS2yKrcI8afhe8IGaKxjte+xw3c2mkvaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4ABvbj4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso1373567966b.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761158509; x=1761763309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBSNtwt1hqivpMpQtmcSf95eEecb17MZgEpr3DvvZp8=;
        b=C4ABvbj4hEYyxN0hqadq04T0CTTUoZmxChgIpTw13E21PH2Mqw7qmXdxamV1Pm8HaE
         T/JkCy+a1EACehR0AwlaDvnOA1bs/DGiZRt68+TMKfe9nc3Q5oBCgqUh+ejDPQ8eWrgm
         XzV+lEwxAgLjWOKoBLXyaOpVN8wxLeiAvD8yOKaEpI3+VRUgEmBmK1kZq9/7n3FtSuSy
         dYcu+nhRt2OK3+gNbjJkTrcrUhFUwUqQIOdDTIf5vqPrVhW+Ib/nNGPqHtP9xdkmI9VB
         EQbRQ8LzUL/wI2TIa47+/WdMW1dTt0bm3KXcXyBMz6QSgbKIKkOA4sTyaidCpRG65C26
         LWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158509; x=1761763309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBSNtwt1hqivpMpQtmcSf95eEecb17MZgEpr3DvvZp8=;
        b=DkLoQGoTd9EI57m5tplPUw5ArZJhhAmegiGXs9sIpc9ks1zc0vpMINOOL0VD+9nSaR
         Ol7Ya61SXG6UZzVYadyrtcsy+mLj6wzqZeQhHdqeK4PKqUFtRvVTlIGRk15YIWmNUzdb
         qymSWI8GcosDH/UXzyu9BEbMtwTO/tvbHtk/AImwK8RfnPcy19ti4WP56rT9jpOlfXpo
         EHFVxg7Su+Qcc6mRRilJMs1ql9OECyHdXszcUlomy3+qx/kV5eKwiUalqyvK3nLXY0wK
         8LKdBTw4nb8/C2ADEJxBvPKjdqOMwdah/jUJbqvbmSVr9010diPjIUUt53s4sAAXrx9d
         aQJA==
X-Forwarded-Encrypted: i=1; AJvYcCUEptpVwvycammACP/fKDlalr1Yi5/1f8izi2lbSRwjz7L2M5yiOjYs3yWFdhzQGJxu9IsXS/+ydQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAF/xenNL0ENuvYB1B8R/nw/KkMlNX3w/ADWMwuqrZvDPxHLN
	FspdMRbh2ic7Xa0C3DJBWaMj1PxgOAJKONH8MPsUMJZiSZOvp8e3wWOOB3tAaku4TdroWY/pZty
	82L091OZUY649hKWN18GdCvbVpHtRXnqWcW1BVONC
X-Gm-Gg: ASbGncvbm1oz1zxp9QJBVVFWE2aQgo7QuaeYyA6ITYnaNRgJrf/K1nNuJhHii2ow4fp
	0zftP2KK4oNNctY16xg0U/xt3a/eGPnoQVttZwl8VYr490HEKYO2a8B/mPIoko2EM85JtrOp1r9
	Lbs+hXKw1clnysfnA5eAYvkFF7HB44mXfOMaTatebXvnsIjgVGRgyNbibG4DF7DYg4ULLjXy/kk
	AyL/Kr9ZQJFfH4/u5fVmbTobpkk9tzZwNpXWi/Uh/IMViNkxRKk2kFwVjy3q68Q2F+ctLIUcE0b
	jvpx1pSDUIUAqgY2FL7rR48B
X-Google-Smtp-Source: AGHT+IG9QOCvLGRlm2L1hQvr/syZxkOWJ3YGHVm/KAKKxfnnsFMCKtjyaFKcnKslc2naOE06t43sSnnXWGnsfmQWWbQ=
X-Received: by 2002:a17:907:bb49:b0:b4b:4f7:7a51 with SMTP id
 a640c23a62f3a-b6475706fc2mr2674087066b.62.1761158508815; Wed, 22 Oct 2025
 11:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctpHA+L=xh-VQ8SVDSRcqyL+ch=WMVrKS+pckLmC6uJwvw@mail.gmail.com>
 <20251022011547.8648-1-hdanton@sina.com>
In-Reply-To: <20251022011547.8648-1-hdanton@sina.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 22 Oct 2025 11:41:37 -0700
X-Gm-Features: AS18NWBw4EAoALtfgytkbkwkbw8Bd9QzC3V--BUqEq20Lf9R4DR6aXlMdo7JRKk
Message-ID: <CAG2KctoJ+1x61KNmDj_52J1_Y3vyox7UNceFw6_WtbRMA_1vYA@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: Hillf Danton <hdanton@sina.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:16=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Tue, 21 Oct 2025 13:13:39 -0700 Samuel Wu wrote:
> > On Fri, Oct 17, 2025 at 5:17=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> > > On Fri, 17 Oct 2025 23:39:06 +0000 Samuel Wu wrote:
> > > > +/**
> > > > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > > > + *
> > > > + * Return 0 on successful file system sync, otherwise returns -EBU=
SY if file
> > > > + * system sync was aborted.
> > > > + */
> > > > +int pm_sleep_fs_sync(void)
> > > > +{
> > > > +     bool need_pm_sleep_fs_sync_requeue;
> > > > +     unsigned long flags;
> > > > +
> > > > +     do {
> > > > +             spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > > +             reinit_completion(&pm_sleep_fs_sync_complete);
> > >
> > > Given difficulty following up here, can you specify why reinit is nee=
ded?
> >
> > There are two possibilities that make reinit_completion() necessary:
> > 1. Suspend abort triggers completion, but is canceled before
> > pm_wakeup_pending(), so need reinit to restart the
> > wait_for_completion() process.
> > 2. Handling back-to-back suspend attempts: after a subsequent suspend
> > attempt finishes waiting for a previous suspend's fs_sync to finish,
> > we need the reinit to start the wait_for_completion() process of the
> > subsequent suspend's fs_sync.
> >
> If 1. and 2. matches the comment for wait_for_completion() below,
>
>         static DECLARE_COMPLETION(foo);
>
>         waiter          waker1          waker2
>         ---             ---             ---
>         for (;;) {
>           reinit_completion(&foo)
>           do anything
>           wait_for_completion(&foo)
>                         do bar1         do bar2
>                         complete(&foo)  complete(&foo)
>           if (end)
>                 break;
>         }
>
> the chance for reinit to drop one wakeup is not zero.
> If drop makes sense, for what do you wait after receiving two wakeups?
>

If I understand correctly, you are referring to the case where
multiple wakers trigger wait_for_complete() simultaneously, hence
having at least one waker's complete() being ignored?

If so, I see two possibilities with multiple wakers:
1. fs_sync finishing + suspend abort1 + ... + suspend abortN
2. suspend abort1 + ... + suspend abortN

Simplifying, if two wakers come in simultaneously, while one of the
wakers may have its complete() ignored, the state of that waker is
still checked after wait_for_completion(), with
if(pm_wakeup_pending()) and while(need_pm_sleep_fs_sync_requeue) for
suspend aborts and fs_sync finishing respectively.

> > > > +             /*
> > > > +              * Handle the case where a sleep immediately follows =
a previous
> > > > +              * sleep that was aborted during fs_sync. In this cas=
e, wait for
> > > > +              * the previous filesystem sync to finish. Then do an=
other
> > > > +              * filesystem sync so any subsequent filesystem chang=
es are
> > > > +              * synced before sleeping.
> > > > +              */
> > > > +             if (pm_sleep_fs_sync_queued) {
> > > > +                     need_pm_sleep_fs_sync_requeue =3D true;
> > > > +             } else {
> > > > +                     need_pm_sleep_fs_sync_requeue =3D false;
> > > > +                     pm_sleep_fs_sync_queued =3D true;
> > > > +                     schedule_work(&sync_filesystems);
> > > > +             }
> > > > +             spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags)=
;
> > > > +
> > > > +             /*
> > > > +              * Completion is triggered by fs_sync finishing or an=
 abort sleep
> > > > +              * signal, whichever comes first
> > > > +              */
> > > > +             wait_for_completion(&pm_sleep_fs_sync_complete);
> > > > +             if (pm_wakeup_pending())
> > > > +                     return -EBUSY;
> > > > +     } while (need_pm_sleep_fs_sync_requeue);
> > > > +
> > > > +     return 0;
> > > > +}
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

