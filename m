Return-Path: <linux-pm+bounces-30078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A66AF7E77
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407AF7B6A53
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD469283CAF;
	Thu,  3 Jul 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZLojwzK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFF283FE9;
	Thu,  3 Jul 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562939; cv=none; b=Jtm+vX21eki1CzU7scjg97ctGjPTEHJwvMigrIT2bRnBcfgVlgI1nRKjwDIal0j6FFnv7fD1mPWyF+ZqKMEt1Q1HUwfuQBOOgp2LHp7KWFP9OPO4qsh+u3OnKjJ3bOsmxKSRQuHiHJ6dMiav2SRk9ljn7QT0BXo1VsciGYydZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562939; c=relaxed/simple;
	bh=Uj5bkWtXtQIbvR4+Cyjubp71UGpdlL9kRH9NmZs+kbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO8fEZRctmQpiEgxpsL23m34dwDM2Q0bkGMOk9ljiMDqeKuSE36pX5YRknfa+7pOMSKmGTye6BCMmuthK60dBt0iS5V/DUpiYYPo3fMdT4kiJbTc70opD4depCo7ClrYpHbDTzctyB07P0bLowFGJOX6UEq4RuDmM7HqBrYzTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZLojwzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FE8C4CEF1;
	Thu,  3 Jul 2025 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751562935;
	bh=Uj5bkWtXtQIbvR4+Cyjubp71UGpdlL9kRH9NmZs+kbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EZLojwzKYfWSJypQ4Gpc+9FErnZQt383Xc0tS6o0odBayeAhe8N7NE0DOq1G+qI85
	 nzS6OvngMwZjqo/EFqtHblUOxCQQNls5KRSrjDdJ6GO0vuVby1MnCjtV+qEtk2h+Hn
	 Dt2PA3aDN5t0OPPUq1PaxmQPTXL9kwrhQ4R6jHmkHWuQMuz3dL4iUhp/9K26AxdM12
	 5JZxyotIi2g9e09qfbSfMapzLpgfzhiIQcUC6GwzVIaP0JAE/cUzsxPtJ3aVnwpIVo
	 Vn3H6PJj/5ZevypHhiSK6ashwWNyxrnJquqBvNFmRG4lf/p705QBckb7Cw4jrJHXzo
	 XCjKoUcg6+VDw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ef493de975so135416fac.1;
        Thu, 03 Jul 2025 10:15:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIAIJWJXtveWHLXvMkIxsCPR1eDakRh2e0G9o7aHob5LKwB6Vlv1Hb60wOa53jNaIYze9MTx+1J4ZUKFw=@vger.kernel.org, AJvYcCXYD98jSCxwaG+aJvQMch8WHzKD2liLwZx3agWp8DHvqx0LD/VTiT1vy22K5prW3Z4Nf/RVUerlses=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iK7JRpwlqt5jtzMBZJQLjOhC7OxPokZrk8l6TZNdYX/NK1/H
	botSIhI3qx5pOWgZS+nTt1vzqyfJmHf3u2TjXcvUAd6N6zddZuNYScLWRgLrxLBGtJFje13pcDU
	cPWUkwWWmAoItZ7sR543BHPTAFSGfhDQ=
X-Google-Smtp-Source: AGHT+IEYlj3vLW+c4XkEkv8B/bM6r36a2ahFcGIyezWBMmDPT1obgS5xRySJi42SiXgxBLmD36WUq/fUlJrmXUn3ljQ=
X-Received: by 2002:a05:6808:1c06:b0:40b:af9:b32d with SMTP id
 5614622812f47-40b887479eemr5537857b6e.2.1751562935126; Thu, 03 Jul 2025
 10:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn> <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
 <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
In-Reply-To: <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 19:15:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
X-Gm-Features: Ac12FXz93EwlKd-IAkIsLjDKdeUgrASdjeyJ_SQspgR1S8NicQ73UFbiFIo8y24
Message-ID: <CAJZ5v0j29Nu2nitmj6tPhOQYuSaHBtXQVR21ikDtrxpejPdW8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zihuan Zhang <zhangzihuan@kylinos.cn>, pavel@kernel.org, 
	len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 6:40=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Jul 03, 2025 at 04:15:10PM +0200, Rafael J. Wysocki wrote:
> > The patch subject appears to be incomplete.
> >
> > On Wed, Jun 11, 2025 at 12:13=E2=80=AFPM Zihuan Zhang <zhangzihuan@kyli=
nos.cn> wrote:
> > >
> > > When freezing user space during suspend or hibernation, the freezer
> > > iterates over all tasks and attempts to freeze them via
> > > try_to_freeze_tasks().
> > >
> > > However, zombie processes (i.e., tasks in EXIT_ZOMBIE state) are no
> > > longer running and will never enter the refrigerator. Trying to freez=
e
> > > them is meaningless and causes extra overhead, especially when there =
are
> > > thousands of zombies created during stress conditions such as fork
> > > storms.
> > >
> > > This patch skips zombie processes during the freezing phase.
> > >
> > > In our testing with ~30,000 user processes (including many zombies), =
the
> > > average freeze time during suspend (S3) dropped from ~43 ms to ~16 ms=
:
> > >
> > >     - Without the patch: ~43 ms average freeze latency
> > >     - With the patch:    ~16 ms average freeze latency
> > >     - Improvement:       ~62%
> >
> > And what's the total suspend time on the system in question?
> >
> > > This confirms that skipping zombies significantly speeds up the freez=
ing
> > > process when the system is under heavy load with many short-lived tas=
ks.
> > >
> > > Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> > >
> > > Changes in v3:
> > > - Added performance test
> > >
> > > Changes in v2:
> > > - Simplified code, added judgment of dead processes
> > > - Rewrite changelog
> > > ---
> > >  kernel/power/process.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > > index a6f7ba2d283d..2bbe22610522 100644
> > > --- a/kernel/power/process.c
> > > +++ b/kernel/power/process.c
> > > @@ -51,7 +51,7 @@ static int try_to_freeze_tasks(bool user_only)
> > >                 todo =3D 0;
> > >                 read_lock(&tasklist_lock);
> > >                 for_each_process_thread(g, p) {
> > > -                       if (p =3D=3D current || !freeze_task(p))
> > > +                       if (p =3D=3D current || p->exit_state || !fre=
eze_task(p))
> > >                                 continue;
> > >
> > >                         todo++;
> > > --
> >
> > This is basically fine by me, but I wonder what other people think.
> >
> > Peter?
>
> How realistic is it to have a significant amount of zombies when
> freezing? This seems like an artificial corner case at best.
>
> Zombie tasks are stuck waiting on their parent to consume their exit
> state or something, right? And those parents being frozen, they pretty
> much stay there.
>
> So I suppose the logic holds, but urgh, do we really need this?

Unlikely in practice, but the code change is small and it would be
prudent to get this addressed IMV (at least so we don't need to
revisit it).

But I would ask for a comment above this check to explain that zombies
need not be frozen.

