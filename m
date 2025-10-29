Return-Path: <linux-pm+bounces-37070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BFCC1D379
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 21:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47AE1888186
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5E2314D0A;
	Wed, 29 Oct 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1MmPlY5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924E2773F0
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770141; cv=none; b=DOP1xeAetzbgDW99ULfF8EHJcM2jOxc+N8gKSeKrpzBpe1/mMHpdhVgqs51DBE6zOMVEk1/zDVfixJIC076NvyoDhZtTCJfK57bfh1aShyBs6to5MhDBt1bXr6QE8+GUc+pwlUqU4Dq5DJTnOfP0VfeyEtCLpIVOgUAbrlu9r+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770141; c=relaxed/simple;
	bh=lYD0muXFu9fggdu87VY6CF+5BTZQ2OUkE9xGyXbV8Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XStLNmYJX0VsI9G3NWa1Bk4F5hv2vLiyypJJCjbJ63bJxIOPz0VchuM3ORAh/myVl1BgUIoqhV5A3Gjrlab8WSYmlai9ElXX7K5HMt9gypz5MXCH5jOeZt6w7bi3+RHorGR/AhXz8UWrdetpqWHErHzb1cpGD/osS8ygaWL/7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1MmPlY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3021AC116D0
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761770141;
	bh=lYD0muXFu9fggdu87VY6CF+5BTZQ2OUkE9xGyXbV8Vc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X1MmPlY5o2VbkE0S75tTCpdthU5ybWfKqePEfp52gvDWiZFVzBWSJDzNm2vZYw5VP
	 fysHPzqHX9gKxfKo1Y5L57s+p2kk+xRv938lhV2lnS1WbnX7Co5+vdcml4M7QjBz+D
	 pfq0TetxgKjpKgFzYnwF+5sr/pPxfm6pnslZQFDKO+dbTLEYzT+Nu16Y4ALeK3W3pS
	 mhM2hhqO3tKHrToNuQ+NvCfFUaMp709Ld+PkAznWX/2BgbZlHa4LSt3OLrAkGl8Eeq
	 kuDW3m4SFVl9GtP8E9EFDI21LpoVPPmT0q7Eg5aL5qPNPz6Fm01MDJyq7Vo1ofBNLD
	 G2sQtKnGCp2eA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-44f6c663452so186132b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 13:35:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8FnzHilkcr6+dbC98sjZXIICeihTOOe4YgU+4RlXYiZ0zFe/J8SDDvzCrfXAlmx4l9CKNhEmEgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1xDH+UomZDw+HAeKJ2KZDzXMNDckdAZVhpxScLGW1Us85BCD
	otKX6SEoHB8tSsJG+xiv3J1a1IjF900y/uUbpW1ZY/Td5s5Ge4oeCa/fRETaMiRSw/hi5cHo8rE
	N2KCWxtZO0YpgeFExH1LJ2OQtfNyTIFs=
X-Google-Smtp-Source: AGHT+IFbVxi7LbsX5YUUfQ1aT5pnE/KDuR8YytDX/7ChhJDUz+pyYC60KiLVJJhi8rQ2OM8j3vjPwGLR7TACFHK8M9E=
X-Received: by 2002:a05:6808:2e4e:b0:437:eb1d:cdde with SMTP id
 5614622812f47-44f89e61cf1mr307471b6e.33.1761770140410; Wed, 29 Oct 2025
 13:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017233907.2305303-1-wusamuel@google.com> <CAJZ5v0g37NNj3inHcrZG8NHeTAGAncLAY7t9Yj3bTAv7GgAQJQ@mail.gmail.com>
 <CAGETcx8ZL3jAwFRxO1B8SFSWmC2jCitc9_61hBG-N2AvzRQv7w@mail.gmail.com>
 <CAJZ5v0jiLzMvwBfcXKJEOMqa_U=6OeWymnBCBdxYfcgU+7P1Aw@mail.gmail.com>
 <CAJZ5v0hpG19Tj9qmTkXQ_6N+wTSBD4Lzx9UvFwTh3WtUagCOGQ@mail.gmail.com> <CAG2KctqoOPg4E6dN0UCjkTF8w0hC7FUwfYOWkw+i37G8OxcttQ@mail.gmail.com>
In-Reply-To: <CAG2KctqoOPg4E6dN0UCjkTF8w0hC7FUwfYOWkw+i37G8OxcttQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 21:35:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i_is4JZFGZcZhc3oiCzeUygKziPEtw5MwF5aZZxdPdvA@mail.gmail.com>
X-Gm-Features: AWmQ_blOrHFIHQp7OefqbbO1cKs3vHtaUIUrw5h3o2TrZ7nKp3yKIFOibyMnnKE
Message-ID: <CAJZ5v0i_is4JZFGZcZhc3oiCzeUygKziPEtw5MwF5aZZxdPdvA@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:13=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> On Wed, Oct 29, 2025 at 6:23=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Oct 24, 2025 at 10:37=E2=80=AFAM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > On Fri, Oct 24, 2025 at 12:47=E2=80=AFAM Saravana Kannan <saravanak@g=
oogle.com> wrote:
> > > >
> > > > On Thu, Oct 23, 2025 at 12:43=E2=80=AFPM Rafael J. Wysocki <rafael@=
kernel.org> wrote:
> > > > >
> > > > > On Sat, Oct 18, 2025 at 1:39=E2=80=AFAM Samuel Wu <wusamuel@googl=
e.com> wrote:
> > > > > >
> >
> > [cut]
> >
> > > > >
> > > > > If I'm not mistaken, the mechanism by which one more sync is star=
ted
> > > > > right after completing the previous one (that was in progress whe=
n
> > > > > suspend started) can be designed differently.
> > > > >
> > > > > 1. Use a dedicated ordered workqueue for the sync work items.
> > > > > 2. Use a counter instead of the two boolean vars for synchronizat=
ion.
> > > > > 3. In pm_sleep_fs_sync(), if the counter is less than 2, incremen=
t the
> > > > > counter and queue up a sync work item.
> > > > > 4. In sync_filesystems_fn(), decrement the counter.
> > > >
> > > > The problem with this is that we can't reuse the same work item. We=
'll
> > > > have to allocate one each time. Otherwise, we'll be queuing one tha=
t's
> > > > already queued. Right?
> > >
> > > Of course you can't queue up an already queued work, but there may be
> > > two of them and then in 3 above use work0 when the counter is 0 and
> > > use work1 when the counter is 1.  No big deal.
> >
> > Moreover, sync_filesystems_fn() doesn't use its work argument, so the
> > work can be requeued as soon as it is not pending.
> >
> > Now, when it is not pending, it has not been queued yet or the work
> > function is running, which is exactly when you want it to be queued:
> >
> > 1. Use a dedicated ordered workqueue for the sync work items.
> > 2. Use a counter instead of the two boolean vars for synchronization.
> > 3. In pm_sleep_fs_sync(), if the work is not pending, queue it up and
> > increment the counter.
> > 4. In sync_filesystems_fn(), decrement the counter (after carrying out
> > the fs sync) and complete the completion if the counter is 0.
>
> Thank you for the thoughtful feedback Rafael.
>
> I agree with these points and will incorporate it in v6; this approach
> seems more elegant.
>
> > Of course, the above requires locking, but I don't think that the lock
> > needs to be spinlock.  A mutex would work just as well AFAICS.
> >
> > Thanks!
>
> I'm still thinking this needs to be spin_lock_irqsave(), since
> pm_stop_waiting_for_fs_sync() is called in an interrupt context and
> needs the lock such that the abort signals don't get lost.

OK, I see.  __pm_stay_awake() will call it under a spinlock, for one exampl=
e.

Yes, you need a spinlock, but in thread context it is sufficient to
use spin_lock_irq() (no need to save the flags).

