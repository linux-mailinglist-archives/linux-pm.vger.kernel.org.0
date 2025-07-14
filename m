Return-Path: <linux-pm+bounces-30814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEAAB046F9
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D04A16B19C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15BC269830;
	Mon, 14 Jul 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNjhsoZZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843E189F43;
	Mon, 14 Jul 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515887; cv=none; b=DafLrwaDj/ROexkozzaUau16PRARUn/x9L0ENaUZFR7WZW4T+hxpfvjIz+lfSNWwlImq4Lp5bPS2bAWXPR+RY4c7SX4GnvLls6QjAa3ux0DJvIHfrtUgWCXzkBc63tkR88zLMUn9dzBypsH7YaoRVSL4WR3/zi1ECR/PZGwzbcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515887; c=relaxed/simple;
	bh=LX84ZA8u4OqGM7/QO9Mt0UfyOk1ThAVKqbVZns8igMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPvoylp5TQncakxi/9M9iBVcbkCxsg82EcPmJqO3kYEU0OiN4/8ziVklNmCMOtTGf4ppqdnj2hX3V0nPhHINoiGfJ4sjrcT7jDtHe3tkO1/ToIC7tXckztcLglzV5eKK+2HFnOGuOPw36Y9ZDin96ZV0BYuWUjAUIQ6G/1FLEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNjhsoZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98722C4CEF0;
	Mon, 14 Jul 2025 17:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752515887;
	bh=LX84ZA8u4OqGM7/QO9Mt0UfyOk1ThAVKqbVZns8igMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sNjhsoZZ934e3XKkIGFIigPtyvMK+vIt4UZNlSZshsIwM8vsSSRGcW2C77QnHqjF3
	 gLTOzbOGnBlnKSY5gra/vgP8pUCfIQdQRwEwBPDo05T4EK2c94iKgATFYz3OapdMV0
	 e4Rz53woiqMauCcyQWY+//Pdm4SdTh5vQs/15kNVnzaA1Hw9h54Bb1BUco1cV0Cnu/
	 BHDR9eFNjpsJlel0YeW3d5XnpTnaw/sAjRbxHH7CrtkeFVoT9/GcjmQZ2Svu3JypOc
	 1ELhOB14zGh4lxWp6ivFOSg6xs9TPcp5qCPYHSCJVIELvFqwRaQg5L6Z/k5UFLWa9m
	 h8316+GsfEOdg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-41b1a0a683dso192946b6e.3;
        Mon, 14 Jul 2025 10:58:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3RJOj3kLyZrqiaxQ6K0CLdNrujYFjSpBWs+pLtd4bHNQucwe9DQLA7XK4ux2O+DesZ3TuTCDGPYw=@vger.kernel.org, AJvYcCXpuWvF3z9C0utdhR9RcWCjx2ila5/Z7pd4QkD91Jx2+GnvMxeLmIHAaCmiMmjqNCimgixX00jy9UmMvFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVvJ6jvSeo1m8XnSmZecVCivCBAZI3tI4ZbrNpbsuq3JsOnPa
	13klnxo0eYapq0dEjIgQHDW9KrRTOpd1SJckBtct9AKgTFNR61zmyCJa8vf0Pmtnl4gX68wMy7G
	bnZbla243YXlSql1iJwamgzXJKqfAtMs=
X-Google-Smtp-Source: AGHT+IEd/J1V+d+F8GB9l8q5kBT2zsuto+qQqfPOnB+R8HudNkOwTTzbCFmG8Wm1Ds0hRnrNhC6ASd6MhUcf4x1+moU=
X-Received: by 2002:a05:6808:18a8:b0:401:e98b:ee41 with SMTP id
 5614622812f47-4151161962fmr10287764b6e.21.1752515886799; Mon, 14 Jul 2025
 10:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712030824.81474-1-zhangzihuan@kylinos.cn> <9d35035d-c63e-4d11-a403-54c50e8b35c1@kylinos.cn>
In-Reply-To: <9d35035d-c63e-4d11-a403-54c50e8b35c1@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Jul 2025 19:57:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g22fMDc21yV2svePf_4BWZRrcy+b3-efpbfAGLpa2=Lw@mail.gmail.com>
X-Gm-Features: Ac12FXylHZiUKH1htuCl5RLqzGZL7BWvLpsSu7vXn9CbZ6lwLl1K9bZZK1zT1vk
Message-ID: <CAJZ5v0g22fMDc21yV2svePf_4BWZRrcy+b3-efpbfAGLpa2=Lw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: suspend: clean up redundant filesystems_freeze/thaw
 handling
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 14, 2025 at 10:44=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.=
cn> wrote:
>
> Hi Rafael,
>
> Just a gentle ping on this patch.

I've lost track of it for some reason, sorry.

> I realized I forgot to mention an important motivation in the changelog:
> calling filesystems_freeze() twice (from both suspend_prepare() and
> enter_state()) lead to a black screen and make the system unable to resum=
e..
>
> This patch avoids the duplicate call and resolves that issue.

Now applied as a fix for 6.16-rc7, thank you!

> =E5=9C=A8 2025/7/12 11:08, Zihuan Zhang =E5=86=99=E9=81=93:
> > The recently introduced support for freezing filesystems during system
> > suspend included calls to filesystems_freeze() in both suspend_prepare(=
)
> > and enter_state(), as well as calls to filesystems_thaw() in both
> > suspend_finish() and the Unlock path in enter_state(). These are
> > redundant.
> >
> > - filesystems_freeze() is already called in suspend_prepare(), which is
> >    the proper and consistent place to handle pre-suspend operations. Th=
e
> > second call in enter_state() is unnecessary and removed.
> >
> > - filesystems_thaw() is invoked in suspend_finish(), which covers
> >    successful suspend/resume paths. In the failure case , we add a call
> > to filesystems_thaw() only when needed, avoiding the duplicate call in
> > the general Unlock path.
> >
> > This change simplifies the suspend code and avoids repeated freeze/thaw
> > calls, while preserving correct ordering and behavior.
> >
> > Fixes: eacfbf74196f91e4c26d9f8c78e1576c1225cd8c ("power: freeze filesys=
tems during suspend/resume")
> > Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> > ---
> >   kernel/power/suspend.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index bb608b68fb30..8f3e4c48d5cd 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -384,6 +384,7 @@ static int suspend_prepare(suspend_state_t state)
> >               return 0;
> >
> >       dpm_save_failed_step(SUSPEND_FREEZE);
> > +     filesystems_thaw();
> >       pm_notifier_call_chain(PM_POST_SUSPEND);
> >    Restore:
> >       pm_restore_console();
> > @@ -593,8 +594,6 @@ static int enter_state(suspend_state_t state)
> >               ksys_sync_helper();
> >               trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> >       }
> > -     if (filesystem_freeze_enabled)
> > -             filesystems_freeze();
> >
> >       pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[s=
tate]);
> >       pm_suspend_clear_flags();
> > @@ -614,7 +613,6 @@ static int enter_state(suspend_state_t state)
> >       pm_pr_dbg("Finishing wakeup.\n");
> >       suspend_finish();
> >    Unlock:
> > -     filesystems_thaw();
> >       mutex_unlock(&system_transition_mutex);
> >       return error;
> >   }
> Thanks,
> Zihuan Zhang

