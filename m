Return-Path: <linux-pm+bounces-23565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63995A54BE6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 14:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD04D1664CA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08720E00B;
	Thu,  6 Mar 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFRVQW4Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB120CCEF;
	Thu,  6 Mar 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267111; cv=none; b=hyiKaY3yJLGocDWwN0ORV++vhNuiy8F0J5pWqt0M4qR+7acPxPbH8NUSf2xD71AoADF88CaN0mjc7lMHSprN2BzCI1KFiiPVJg2RGi8b7NZXPp+zsNvkJa59vhIR34J9jw7ftTzHjOwm89XK1rk9/TUzwfBBAexf3mtJnZacKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267111; c=relaxed/simple;
	bh=NRAmMlaST99PuE29h0Bw96V9IXafkYUp84trtPBfjh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBiHuen/6EvuFaoLLW0aqyaOMmj1CIpajKM8cYmWRwVgcTMsOJOjlizU7pvbMNdPykHvuIncqUgEUSgrkFZyfNLEsz4NTFM5/HyCZrZIJDMvnwaIMj1GbcRP/rvUmMq88/8oa4PYqpb19OI9ZpqLQNlL9/QqV0TO0r+ZpjbTZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFRVQW4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0247EC4CEE0;
	Thu,  6 Mar 2025 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741267110;
	bh=NRAmMlaST99PuE29h0Bw96V9IXafkYUp84trtPBfjh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GFRVQW4ZW3PGSi4JPFIqGI0MwARrwxBZFx63xCwoJ5OhEPrg5lMCAjp4AlkKWAU2E
	 LeBI7HccZQq3P374H1TonJbQtqg4xIFMwKetdk1U3IdAD26hVaMeLaHqFmABgotnyn
	 VWOf7EcbHQAgHdjdFpKOHabt0wexqS+W+0M6hrbyBscywpsSrGsoAXQy9V68yVSf0v
	 ztymC0Gftqbjo2Qc8je0B7Z6k76MkIM65GokkmHaNjkwkH5+Hph045nm288ZHWSgTq
	 PPSHApjXVN5fyHU3nTghyde6aFzeOyKO4QrWyyzNILmUH8kKGARPPj/8A7gx1auFmA
	 lcX59UDw/lGBA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60018b29f51so431971eaf.1;
        Thu, 06 Mar 2025 05:18:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVk3jGREOcKBZtEok+zETEcgercbGB1WvowR/lV8vi5P0JcesnCrxmyfTKUiZ8RslH4zr7AD+McF48=@vger.kernel.org, AJvYcCX+ecBZR+vymSm0XISpW4dcGIGneIE+Xr5VCV8UmEzBVvnRWZVSE0E2YG099Z4XBGjxi2pK1jrNlanMvCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9fVk4TQITl830KIAwS1wutPwcw8HwWihhrFwaT9c5V/zZcSkN
	uOaVbab/MIwt9Ri/oujvfsfSeZ5hDp2RTkhqHbAO9dEEBDN2V//Xns/xGJbwB8tnKTDnxS2CUjW
	NlZAnIhxU4aZJKtLkoyfxxX1ZRCs=
X-Google-Smtp-Source: AGHT+IH3oEcVmbsFOsBmKMsof78yBUJz6WhIFBnZDb8x6rX363SbDrl3Pb/36Y6XTPMbr5wNRn70whh4hwc+eirkwHE=
X-Received: by 2002:a4a:ee07:0:b0:5f3:4c09:55e7 with SMTP id
 006d021491bc7-6003eba4c53mr1847338eaf.3.1741267109305; Thu, 06 Mar 2025
 05:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306113549.796524-1-ulf.hansson@linaro.org> <20250306113549.796524-3-ulf.hansson@linaro.org>
In-Reply-To: <20250306113549.796524-3-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Mar 2025 14:18:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hF_am9DsuwEUmmgpUp=1ZuAG8fdjYfQ5XxFmS_Y1pMog@mail.gmail.com>
X-Gm-Features: AQ5f1JqAwyTNs4ZBM0f52Gc4g0dPgvb0TMPdtOuexc8yStCGdnp_mg1UZuJLuuw
Message-ID: <CAJZ5v0hF_am9DsuwEUmmgpUp=1ZuAG8fdjYfQ5XxFmS_Y1pMog@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: s2idle: Avoid holding the s2idle_lock when
 calling pm_wakeup_pending()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:36=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> There's no reason to hold the s2idle_lock longer than necessary. Let's
> instead acquire it when really needed in s2idle_enter().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  kernel/power/suspend.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index e7aca4e40561..ca09f26cbf4e 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -91,10 +91,10 @@ static void s2idle_enter(void)
>  {
>         trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, =
true);
>
> -       raw_spin_lock_irq(&s2idle_lock);

This is to prevent missing a wakeup event when pm_system_wakeup() runs
at this point on a different CPU.

If you move the locking, it may run as a whole between the
pm_wakeup_pending() check below and the s2idle_state update, so the
wakeup event will be missed.

With the locking in place, the pm_abort_suspend update in
pm_system_wakeup() may still happen at any time, but the code under
the lock in s2idle_wake() after it can only run before the lock is
acquired above or after it is released.

If s2idle_wake() in pm_system_wakeup() runs before the
raw_spin_lock_irq() above, the pm_wakeup_pending() check below will
notice the pm_abort_suspend set and return true, so the suspend will
be aborted (and the pm_abort_suspend update in pm_system_wakeup()
cannot be reordered entirely after the s2idle_wake() call because of
the locking there).

Now, if s2idle_wake() in pm_system_wakeup() runs after the
raw_spin_unlock_irq() below, it will notice the s2idle_state change
and it will update it to S2IDLE_STATE_WAKE, so the suspend will be
aborted.

I guess it would have helped if there had been a comment describing this ..=
.

>         if (pm_wakeup_pending())
>                 goto out;
>
> +       raw_spin_lock_irq(&s2idle_lock);
>         s2idle_state =3D S2IDLE_STATE_ENTER;
>         raw_spin_unlock_irq(&s2idle_lock);
>
> @@ -111,11 +111,10 @@ static void s2idle_enter(void)
>         wake_up_all_idle_cpus();
>
>         raw_spin_lock_irq(&s2idle_lock);
> -
> - out:
>         s2idle_state =3D S2IDLE_STATE_NONE;
>         raw_spin_unlock_irq(&s2idle_lock);
>
> + out:
>         trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, =
false);
>  }
>
> --

