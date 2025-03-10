Return-Path: <linux-pm+bounces-23775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F4A59A93
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 17:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C2A18880DD
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908622371A;
	Mon, 10 Mar 2025 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZEvc9GA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C829A29;
	Mon, 10 Mar 2025 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622510; cv=none; b=XjlMAZDHT2KstNN7Ep/p/OLHn/zJC3vRH/kIbU5Pwk/G+gonJj4JKvkoI7pNcDL1X6V0h/id7Ji1umyqp0XvynLtXBkvbctDFAPfVwS5i5ErzyniiK06TkrXHNzJvhOhP0LzO9Z6jxapn+yHwTYxd55eYH/TC/NQe8Qq3FX0E+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622510; c=relaxed/simple;
	bh=mqBXqjlVmhomvFbTex1Fuk/DW/hR4kbX8x9xFHLmTAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SE1lN95E7tEnr7ZYBYGsTzF2cjVVB7kcCWcf6/ZwErRZ2JK9bn+SYgkVVvFpfaKQ2XCYm1uP7CAeOe+MNYr/ggbQEADbmxV24oXuGyuSPfv4AUdU3Cwtoyvb17nnw0U30oRqPGAgDP48p4QjXfAJJRwpEn7UHnMxeHhwHrrJ+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZEvc9GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31DAC4CEEE;
	Mon, 10 Mar 2025 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741622509;
	bh=mqBXqjlVmhomvFbTex1Fuk/DW/hR4kbX8x9xFHLmTAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XZEvc9GANYPdICMpXDD3qOBgROJyZeYvqYf5tsCihhDqk1stckOl4S2UrtTxF6V1C
	 JivBaco8lWZmRiz2pECQqJcoOBPwY4ziEx9TpUY77TJjwa//XmXQ7lY+04/C2AGWZ+
	 HJzA/Txu+2VoBq/IFTOjkm/0BjbAy0bjaSw+wjge5QU6FwgWroRn6nvThBgS6LxA9f
	 OdAYtH/eClhmTbntargzvdaxna9+KLcLr0v/MYOWsHMTwKvhZfdAX3HR5z7h/gblhv
	 H1kvKUnswjuYYTKkWNYZybHQGVVKqbCsTgzsR+z1mkxqEJe0lgmuOkyXNI0RLShoPV
	 +vQR929kn/o8w==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso1311672fac.1;
        Mon, 10 Mar 2025 09:01:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtTzGGhK8jthAWzL/qC967tfA5Q0AAOpuEwoEeaXc/5ll+uLiDflwIo4Km/sHrSaLTEOP/r9BbeA4=@vger.kernel.org, AJvYcCXF72IPEQz0wGUZ7hIP1lz4VsHqmBA98TjfyJKiHnmavzb4z0jRsqXdw55UegKe/nQwhNa9hXWN7qC6/KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzir95xoRQXZ9D6cSFr5W7reiO4Nw81bIPvbG9fZtihdkqKVuN+
	GZJ3c0ukVCZznKVS8JOUIjFzhjk9gshjSEWPB0/qrSO2bYikqlCFICdUy0bDV4ifCCykFRsrciS
	6kbv4Qi3+m8HgPG6XzXQgzj49jT4=
X-Google-Smtp-Source: AGHT+IFwGvUc4Tp7kR6y9fTJze0Y92I2Yu8TbnbXDoZHpz0CWvJxxKW5lztZnATqgBlP4ijhJFYR2vhCdDXTfnjI3Fs=
X-Received: by 2002:a05:6870:c87:b0:29e:7d35:2319 with SMTP id
 586e51a60fabf-2c2e86a10e9mr102664fac.4.1741622509128; Mon, 10 Mar 2025
 09:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <CAGETcx-ow3T_R_Lj1s3sjp6nQz6Wv7T3dQdP3HJHd+E8nkh6rw@mail.gmail.com>
 <CAJZ5v0g3qOvESqvqiCnwVz2BYGHzrG8=nRQ8j36Qd_LC0io_Tw@mail.gmail.com> <CAGETcx82sLvG19eUN1ATrL5RzEKJjOeWP+kdYJdQX9O=ck7q2Q@mail.gmail.com>
In-Reply-To: <CAGETcx82sLvG19eUN1ATrL5RzEKJjOeWP+kdYJdQX9O=ck7q2Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Mar 2025 17:01:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0guoA-xp-yyr7Fb7ikmE9rjt8xwDPcxU52sd0UP_u=2jA@mail.gmail.com>
X-Gm-Features: AQ5f1JoUs4xvOWLvABy9PgNqRj_ZLqrO_B7qa6QzolnUbKfXtStzMfX9DtMd0t4
Message-ID: <CAJZ5v0guoA-xp-yyr7Fb7ikmE9rjt8xwDPcxU52sd0UP_u=2jA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 11:38=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Thu, Feb 27, 2025 at 8:23=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Feb 27, 2025 at 4:45=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwyso=
cki.net> wrote:
> > > >
> > > > Hi Everyone,
> > > >
> > > > Initially, this was an attempt to address the problems described by
> > > > Saravana related to spawning async work for any async device upfron=
t
> > > > in the resume path:
> > > >
> > > > https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak=
@google.com/
> > > >
> > > > but then I realized that it could be extended to the suspend path a=
nd
> > > > used for speeding it up, which it really does.
> > >
> > > Btw, maybe I didn't  word it correctly, but my patch series was meant
> > > to speed up the non-async case too.
> >
> > If "the non-async case" means the case with "async" suspend/resume
> > disabled entirely, I don't think that the ordering in which devices
> > are processed can be changed just because there are no known
> > dependencies.
> >
> > > I was going to get around sending a v2 of my series, but was caught u=
p
> > > with some other work. But I'm okay if you want to finish up my effort
> > > -- less work for me and I can focus on the other aspects of suspend :=
)
> > >
> > > Maybe add a Suggested-by: to the patches?
> >
> > Yeah, I can do that.
> >
> > > I definitely want to review the series, but very busy this week with
> > > some other work. I'll get to this next week for sure.
> >
> > That should be fine.
>
> Hi Rafael,
>
> I looked at the full series and it has at least one bug and a few gaps
> that I address in mine.

What bug?

You need to tell me specifically because I'm not aware of any bugs in
this series and unless you tell me what it is and I agree that it is a
bug, I have no reason to believe that there are any.

As for the gaps, there are obvious differences between this patch
series and your work and it would be kind of nice to explain why they
matter in practice, in your view.

> And those are what make my patches have a
> higher diff. Can we just continue with my series instead?

Of course you are free to send a new version of it, but it is unlikely
to be a sufficient replacement for constructive feedback.

