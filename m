Return-Path: <linux-pm+bounces-37066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6ABC1CE33
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4D8734C246
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DA23590C6;
	Wed, 29 Oct 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR7s+4cs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1D358D07
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764619; cv=none; b=eeMTyZ/nvVjq1W76jF7oRyTSSjMQu/u3JcDi7uroHmX3pE1YEwaGlyfOVVPnJF3e8bKS9P+NpaQcP57bWfJhKctMOICiR6tXLClRSMlCf7ynGFGSu2ZK37y6eEIm6dIocfw3dgYi4//JiMLBJ8nVll+ucu+wfWSJGfbbGkhs+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764619; c=relaxed/simple;
	bh=ayz5uJhUWek64cO1TfANoi2EbNkkgYCklsEjCvThEwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFIXfKAGUyycfVzwsYZUUwvxZfQptB8mW5nEcgFVZFQhioFXSyL5DFTHUQfcGRGic2rSguErx7BLz99P76ZpVnoxIDw9+lktYFgwTDcRBPqCo5pq+N5mTKfFyuLJPBVgyifZtVsKYJkGAG7eS5VSNsKgGVK2P16YlF2s2qxBphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pR7s+4cs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d6c11f39aso35619366b.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761764616; x=1762369416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMbXoANbxtJaPshR9Dxm5UKMGamPxpzGctgh5KcznPU=;
        b=pR7s+4csT0Krx+MIucU++jucYQhwF8BR4TSNmDlgFr1L2ZtyUccjyQtRgYfcfAFUjN
         ows+TpWZBP2ILHXvq8ut6whNFbElcAgphk7dl7ZowluMF7aqwYr0SCw1ZzjBaGG4B2dQ
         5IQkFxs46EuMMkgius0iebc/PH2bygKVPHwp0PaVhWfe7Wm+woxNI5woOu3dZogf1s0m
         Jxfwm/KEykGx4IlZe9oLkBVlTnrHJCdpuy3DlsCwPINT4aMF34umLQYQQnLSsSz5jY9K
         PB+gR2PTbLulFNgtDFd4nqlC4xvdVg+97bVZCyjm8EKTWiCYooS890yKhWL6pnifq0ok
         wATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761764616; x=1762369416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMbXoANbxtJaPshR9Dxm5UKMGamPxpzGctgh5KcznPU=;
        b=OTd22Yr9gldnaxbkczdmriCT9afvsYpTnwRSl73B8/xp989UIZtVv/l72QXI1Lot9G
         7A5lKVa3+UYbOZFd7gv2ie7W3sDl2NOVWVDaR66c8MWRSrh//oLe3nE4II6tnSj5mzMd
         ci9K68QxwSRcxsxcPYZc7GstxeJz5FyPMP20KGgFatfAQnxhp/WCPrOEoOWTrWomtFTt
         ngqGYuz7uIdkyn6/ZqUFy8dWrkIxZGlULEjUH36viRJ0cCrm2t9XpnZ48olfge8XTCvT
         5S6DXeiIgT8m2Di5QjrD9LK1eFdRoEo1E9r48qWJiBt3rUNAC9OdcULFDx4A4KEalrlE
         nLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbjQWTEkv76oWJSxin7T9Xn9yb6cYVIrWkm3h4TE5bmPH22okgGeRcq9CPJkRyakmLrMRTv63Lig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYJMue1/sudDstSURrh1LxHib4+/I/HZcMXeT9JU5YAfz+KCv
	lW7Co0cqv3Eser1oRxErVNtmucqekX1PXSGA6AlLNqUjBW0hxqHJPe7Pvg0tWWY1+v81gp6hwNC
	lwV9I0MGKhZJK0wgFELiyRULlOIpIG0dJ/RX1wJCZ
X-Gm-Gg: ASbGnctQ17kLSW0GKHfHQUFv4dSOH9HJ0kOOqf/nZhO4ejJZirEh3V8l+BmbihsU8si
	YrCP6P/txFd/D955ZSOXSupATkw/IwWM72dxc3oTfgcw/mL6Q6h1fIdYw37hOEatRrlDwX3wfC7
	JftNQu9zkRp17xL3OwHT9i0Ll2sTz/h0NcNQ53U66RTSp3NUQgbDhd+FyuBVenrHqkIX/9YVZwb
	nBSK06jPjZlmU+6ZgftgDdo46fZl6GOJz01PZE6W/K+vcLKTwjFT/bdUXyMKQ0mYNCmiGd73Emi
	Z2p6bjsu64PeOqaUG4xBD351
X-Google-Smtp-Source: AGHT+IHfciFTAoDkjpZYU12r/OGQA3CcjFHDRIHS9vPorWUYQf+f9y/eBGvAocvloUc+tpJPBBnlYyO8NS5eEoCs9PI=
X-Received: by 2002:a17:907:26c3:b0:b6d:c7e0:9da6 with SMTP id
 a640c23a62f3a-b703d31ffd6mr454751366b.16.1761764615731; Wed, 29 Oct 2025
 12:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctoJ+1x61KNmDj_52J1_Y3vyox7UNceFw6_WtbRMA_1vYA@mail.gmail.com>
 <20251022223218.8664-1-hdanton@sina.com>
In-Reply-To: <20251022223218.8664-1-hdanton@sina.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 29 Oct 2025 12:03:22 -0700
X-Gm-Features: AWmQ_bnM1ll6As3Oe3-EnkwU_1r2qyB_MB-idXfls2oX12W7nVYN07mZwD0v-6g
Message-ID: <CAG2Kcto4XPWMqf_ALZht9wivKki7bNKgCwijLruTsj8CDHaCgA@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: Hillf Danton <hdanton@sina.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:32=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Wed, 22 Oct 2025 11:41:37 -0700 Samuel Wu wrote:
> > On Tue, Oct 21, 2025 at 6:16=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> > > On Tue, 21 Oct 2025 13:13:39 -0700 Samuel Wu wrote:
> > > > On Fri, Oct 17, 2025 at 5:17=E2=80=AFPM Hillf Danton <hdanton@sina.=
com> wrote:
> > > > > On Fri, 17 Oct 2025 23:39:06 +0000 Samuel Wu wrote:
> > > > > > +/**
> > > > > > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > > > > > + *
> > > > > > + * Return 0 on successful file system sync, otherwise returns =
-EBUSY if file
> > > > > > + * system sync was aborted.
> > > > > > + */
> > > > > > +int pm_sleep_fs_sync(void)
> > > > > > +{
> > > > > > +     bool need_pm_sleep_fs_sync_requeue;
> > > > > > +     unsigned long flags;
> > > > > > +
> > > > > > +     do {
> > > > > > +             spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > > > > +             reinit_completion(&pm_sleep_fs_sync_complete);
> > > > >
> > > > > Given difficulty following up here, can you specify why reinit is=
 needed?
> > > >
> > > > There are two possibilities that make reinit_completion() necessary=
:
> > > > 1. Suspend abort triggers completion, but is canceled before
> > > > pm_wakeup_pending(), so need reinit to restart the
> > > > wait_for_completion() process.
> > > > 2. Handling back-to-back suspend attempts: after a subsequent suspe=
nd
> > > > attempt finishes waiting for a previous suspend's fs_sync to finish=
,
> > > > we need the reinit to start the wait_for_completion() process of th=
e
> > > > subsequent suspend's fs_sync.
> > > >
> > > If 1. and 2. matches the comment for wait_for_completion() below,
> > >
> > >         static DECLARE_COMPLETION(foo);
> > >
> > >         waiter          waker1          waker2
> > >         ---             ---             ---
> > >         for (;;) {
> > >           reinit_completion(&foo)
> > >           do anything
> > >           wait_for_completion(&foo)
> > >                         do bar1         do bar2
> > >                         complete(&foo)  complete(&foo)
> > >           if (end)
> > >                 break;
> > >         }
> > >
> > > the chance for reinit to drop one wakeup is not zero.
> > > If drop makes sense, for what do you wait after receiving two wakeups=
?
> > >
> >
> > If I understand correctly, you are referring to the case where
> > multiple wakers trigger wait_for_complete() simultaneously, hence
> > having at least one waker's complete() being ignored?
> >
> > If so, I see two possibilities with multiple wakers:
> > 1. fs_sync finishing + suspend abort1 + ... + suspend abortN
> > 2. suspend abort1 + ... + suspend abortN
> >
> > Simplifying, if two wakers come in simultaneously, while one of the
> > wakers may have its complete() ignored, the state of that waker is
> > still checked after wait_for_completion(), with
> > if(pm_wakeup_pending()) and while(need_pm_sleep_fs_sync_requeue) for
> > suspend aborts and fs_sync finishing respectively.
> >
> Note one of the two wakeups may come after the two checks.
>
>        reinit_completion(&foo)
>        do anything
>        wait_for_completion(&foo)
>                 complete(&foo) from waker1
>        check1
>        check2
>                 complete(&foo) from waker2 // dropped by reinit
>

Thank you Hillf for the foresight and feedback! I'm thinking v6 needs
this structure to address that scenario:

lock
do
        reinit_completion
        // bookkeeping, queue fs_sync
        unlock
        wait_for_completion
        lock
        checks
while
unlock

