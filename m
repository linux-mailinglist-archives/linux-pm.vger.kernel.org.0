Return-Path: <linux-pm+bounces-36498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A4BF2DDA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 20:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 519F34E557B
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E952C0F92;
	Mon, 20 Oct 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEevJ9h2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82F28DB46
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983731; cv=none; b=mk7Ulbuo9e/rnLqE+1Em+lSbiCJY163DxNQWKIrhqlMXyAi5y26rn7Um4BW1N/txSysHw3GqtuYA3G4hBRJM0w+DSZCJJ0Fxyl4QPKlXwUmB2Jqe4i4tUaP0SuqOQRUO54yD3nThDuZi1KbzyYvLfWG7X31IVxvt7gs9fiVw3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983731; c=relaxed/simple;
	bh=N1WA1B/++B9dBsW4DUV4V1OFij7Palh+7DF4vorc9NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJ5CNY+HXPid+xTa9Oe8AeLx6W+Yg7+tz0UnQel8wZo6yxYAmG2RnQu3KDss8z0bZZUVwAlNMWtwL5Uh/jz0KUBCtm5CzvbnYK6e6vZbKLIgnWYiF+eVk9CeotVIWeiinKCmZnKIJlQ5nxnLkAGbe3m2FJS9YNeFanhpgDyYT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEevJ9h2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3568AC116B1
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983731;
	bh=N1WA1B/++B9dBsW4DUV4V1OFij7Palh+7DF4vorc9NQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZEevJ9h2GA3K0cNIaP1Cmq8VmK+Bwf4O1KRjP/cOcx9UCT97GJfpcqCXddzTsvmmS
	 nDgxcYRD6wLr/8DSqB3tCX9N+dbLR66CMbEQyHCLRgV3REU4FVWavbpsD8KeZGO/OT
	 OVjN2aHY8JUNi+wXU1f2AhX3+6JaG5HIXe5Rf8RXXetzFcJOafn8+uPQgY+vofqq44
	 +uZ97Rrekoz3tYMTOxq/aMSvmZz68cBiBxkwJEXlHq/kpVq5B7edRwidH6Mh7b8Pm1
	 CgkpyoZIQPzwQwMdMcpBpT3+qwa7L8tR8JNw2VpwtYTwi8UucKddIcDZ/gGwH6GhrT
	 w1a0zrVv6o8ag==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-443a2689160so2058386b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 11:08:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMJX5HqXwNbM92VrxnfLifCr+lA00luJM5SJIRYRb1AZ7WnbXpeLG7TK99DXY8ZSLHqDewjIOqTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwatnLQqfTzLDCKFx6xoRCGsXO7gMuFlPwBGoKyZW0vVIHVj1lh
	jslghspmAtcDe0ugvMiExksZ3awPleR02UDn7xpiuYNt74TwpPX94QYwMm/OZbldJGVQvHqvSeF
	qmOPM67V+nuyfgDemdMor9QN83Sbu248=
X-Google-Smtp-Source: AGHT+IFz9WByM47omjWy2vhrJ1sSbtY7aDQ9Hq8M//aUANLjGQ7Ci6EvcJPBHzmBXzgGirC2hX/uXvCqQiPjAobXrNs=
X-Received: by 2002:a05:6808:1b0d:b0:441:8f74:fd3 with SMTP id
 5614622812f47-443a30c38b7mr6161560b6e.64.1760983730567; Mon, 20 Oct 2025
 11:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007063551.3147937-1-senozhatsky@chromium.org> <CAAFQd5DxxPTH08MJGKzaDkgzcChArvN6pEQtmX63zytKn0C58w@mail.gmail.com>
In-Reply-To: <CAAFQd5DxxPTH08MJGKzaDkgzcChArvN6pEQtmX63zytKn0C58w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 20:08:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hzSowdZBC2_SV79BUgPMZSRM9ObD8wyssgMFw9A9LHTA@mail.gmail.com>
X-Gm-Features: AS18NWBisJ4phsvo4q-93bPN4oR0a5usnjXljqq8higN2fMtPm4--e23LDfwIa0
Message-ID: <CAJZ5v0hzSowdZBC2_SV79BUgPMZSRM9ObD8wyssgMFw9A9LHTA@mail.gmail.com>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
To: Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:51=E2=80=AFAM Tomasz Figa <tfiga@chromium.org> wro=
te:
>
> On Tue, Oct 7, 2025 at 3:36=E2=80=AFPM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Add dpm_watchdog_all_cpu_backtrace module parameter which
> > controls all CPU backtrace dump before DPM panics the system.
> > This is expected to help understanding what might have caused
> > device timeout.
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/base/power/main.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index e83503bdc1fd..7a8807ec9a5d 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/cpufreq.h>
> >  #include <linux/devfreq.h>
> >  #include <linux/timer.h>
> > +#include <linux/nmi.h>
> >
> >  #include "../base.h"
> >  #include "power.h"
> > @@ -515,6 +516,11 @@ struct dpm_watchdog {
> >  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
> >         struct dpm_watchdog wd
> >
> > +static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
> > +module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> > +MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> > +                "Backtrace all CPUs on DPM watchdog timeout");
> > +
> >  /**
> >   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
> >   * @t: The timer that PM watchdog depends on.
> > @@ -530,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list=
 *t)
> >         unsigned int time_left;
> >
> >         if (wd->fatal) {
> > +               unsigned int this_cpu =3D smp_processor_id();
> > +
> >                 dev_emerg(wd->dev, "**** DPM device timeout ****\n");
> >                 show_stack(wd->tsk, NULL, KERN_EMERG);
> > +               if (dpm_watchdog_all_cpu_backtrace)
> > +                       trigger_allbutcpu_cpu_backtrace(this_cpu);
> >                 panic("%s %s: unrecoverable failure\n",
> >                         dev_driver_string(wd->dev), dev_name(wd->dev));
> >         }
> > --
> > 2.51.0.618.g983fd99d29-goog
> >
>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Applied as 6.19 material with some edits in the subject and changelog, than=
ks!

