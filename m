Return-Path: <linux-pm+bounces-17519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188AE9C7C3A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 20:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D881F23371
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C2205120;
	Wed, 13 Nov 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C59Wf2IN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F621203712
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526425; cv=none; b=cDXX58SDJntGEZFi2bckMjYdQqNl6F3kWttlseB5s83ECynDxzxjgK66En+Y6pih9JcpaXOHsZvQ874MarLvd7AZV+54BWs8aXdAxC8sxe15luo7Sr1IdQGSB9xEt+I06DzQXV66WKhucFNrudcs69a+d0szZie1kTchE+RlJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526425; c=relaxed/simple;
	bh=ZNt+55ygYc8dI/t3lXHMZ2acaDsSYO8rTpDWpCaqO8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdiZ1jNdUa4wf2+WXewq3zfoEgvoXp5RRTrpLF73dIi+fTJqrgxYYAysYqdz2MYNS/2KAkoAB9p+xT+LMhUkGlpNbC7mmTcJ5erRm4huujcGjR35bvdQF9+GXyDs/dZw+VBC/g15EeQbbA9zmW0BwELG9hn897b0D6uofKQnUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C59Wf2IN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C11DC4CEC3
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 19:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731526425;
	bh=ZNt+55ygYc8dI/t3lXHMZ2acaDsSYO8rTpDWpCaqO8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C59Wf2INsjjSrQB3cSQkBLu19APxvns6J+4+BQsJvSHJdJJ4JJYf3P4iH1uOVG5pF
	 Wm36OvoJVscNdExxHwqh49LGLnoBssLsuw1OcRNY3LMRB9DzWeiYH1tVmWv07bi3oc
	 sLwHRtZ7P7nmm9z8YU3vC2n27JHqTTGJa0Yl3bYHUWhnGjZ0qiRrQneZdPFUqs3ASw
	 8e58fZBuatiCfLxn5PWxVNRpyBhM397PMyySWorWC6sYY+yte+w6sbMejA6q6fvZBZ
	 cfGLCLAZsHU78ld6qA71fRV7WA18xy98AV9vOUTgZeieU/L2dsIXdAoMShTqhsn0gT
	 h1xtGKOWGrt+Q==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-290d8d5332cso3523206fac.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 11:33:45 -0800 (PST)
X-Gm-Message-State: AOJu0YywpFycHvHtNAU8et/0asuLVDGpMUP7m1xp7RsbzV0vrvarKj74
	k9CBeHcZHbY6a1/rBvoJcqnOlfCRiBV1yWB30WKb7cH7AJ3qOVVVMC4BMEUPKYi4jmTcmXSKoKr
	h2NM3oBmRNeE/DaFNW4i/GsG3vFE=
X-Google-Smtp-Source: AGHT+IHxa4ZwdrzfGfpecpiz4ajGuiA7ZAe/EJVQrmSdg4UzYf7YxQhlVdvIos8eU0QE8mKZ3uRsztUoP61/ex9s83A=
X-Received: by 2002:a05:6870:1d12:b0:27b:4f51:d73a with SMTP id
 586e51a60fabf-29560180f68mr20644951fac.21.1731526424479; Wed, 13 Nov 2024
 11:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e3092234617e8479d3020e5fed7ff47ac750014.1731522552.git.len.brown@intel.com>
 <CAJZ5v0gTPoH3hwR2yyi2uLdX_-ykwaEyyRSAxz2omG34PzGQEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gTPoH3hwR2yyi2uLdX_-ykwaEyyRSAxz2omG34PzGQEA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 20:33:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hdWaVtXscEB9Ou0DXD2hSWYqSLtQC4skhgGvhy0Su4sg@mail.gmail.com>
Message-ID: <CAJZ5v0hdWaVtXscEB9Ou0DXD2hSWYqSLtQC4skhgGvhy0Su4sg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:23=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Nov 13, 2024 at 7:35=E2=80=AFPM Len Brown <lenb@kernel.org> wrote=
:
> >
> > From: Len Brown <len.brown@intel.com>
> >
> > Drivers commonly return non-zero values from their suspend()
> > callbacks due to transient errors, not realizing that doing so
> > aborts system-wide suspend.
> >
> > Ignore those return values.
> >
> > Both before and after this patch, the correct method for a
> > device driver to abort system-wide suspend is to invoke
> > pm_system_wakeup() during the suspend flow.
> >
> > Legacy behaviour can be restored by adding this line to your .config:
> > CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=3Dy
> >
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---
> >  drivers/base/power/main.c |  4 ++++
> >  kernel/power/Kconfig      | 14 ++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 4a67e83300e1..56b7c9c752b4 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1678,7 +1678,11 @@ static int device_suspend(struct device *dev, pm=
_message_t state, bool async)
> >                 callback =3D pm_op(dev->driver->pm, state);
> >         }
> >
> > +#if CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT
> >         error =3D dpm_run_callback(callback, dev, state, info);
> > +#else
> > +       dpm_run_callback(callback, dev, state, info);
> > +#endif
> >
> >   End:
> >         if (!error) {
>
> I would prefer something like:
>
>     error =3D dpm_run_callback(callback, dev, state, info);
>
>  End:
>     if (!IS_ENABLED(PM_SLEEP_LEGACY_CALLBACK_ABORT)
>             error =3D 0;
>
>     if (!error ) {
>         dev->power.is_suspended =3D true;
>         if (device_may_wakeup(dev))
>             dev->power.wakeup_path =3D true;
>
>         dpm_propagate_wakeup_to_parent(dev);
>         dpm_clear_superiors_direct_complete(dev);
>     }
>
> and analogously in _noirq() and _late().

Or even

    error =3D dpm_run_callback(callback, dev, state, info);

 End:
    if (!error || !IS_ENABLED(PM_SLEEP_LEGACY_CALLBACK_ABORT)) {
        dev->power.is_suspended =3D true;
        if (device_may_wakeup(dev))
            dev->power.wakeup_path =3D true;

        dpm_propagate_wakeup_to_parent(dev);
        dpm_clear_superiors_direct_complete(dev);
    }

    device_unlock(dev);
    dpm_watchdog_clear(&wd);

 Complete:
    if (error) {
        dpm_save_failed_dev(dev_name(dev));
        pm_dev_err(dev, state, async ? " async" : "", error);
    }

    complete_all(&dev->power.completion);
    TRACE_SUSPEND(error);
    if (IS_ENABLED(PM_SLEEP_LEGACY_CALLBACK_ABORT) {
        async_error =3D error;
        return error;
    }

    return 0;

So I want the error messages to be printed and TRACE_SUSPEND() to
record the error, but to return 0 in the end if the new option is not
set.

Also please CC the next version to the LKML.

