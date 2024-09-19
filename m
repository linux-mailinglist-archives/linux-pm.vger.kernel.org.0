Return-Path: <linux-pm+bounces-14487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC197CD84
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 20:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFED284627
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D41CD1F;
	Thu, 19 Sep 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JccF2kx/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885B18C3B;
	Thu, 19 Sep 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770085; cv=none; b=GG3WHLbdcEzXNDCwbAbDRnZJfZ4Xp9i+v5l0yDvW/6vQE3vmNQsBYvHfat1KXlPtpDSc9xnkNSr58OXcPym5eFfmMWq7uSXOaLXtlXprUgq1KWc/GZZoPUn5NMyjgs0xCGUzYSJyb+/LGyGlJLX+dD9ZIrm2C527BQDvV2jI7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770085; c=relaxed/simple;
	bh=tVdW+YS/15p5QfR0bbmmx60ovpITjJVJpY3Swduqmlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEMXipDKL+/VWtLAQ8cYELWF6MeMVzCm5kT2fGwUKG0ej2wGQJn+YA/YnK5aZ+4xKv3bhHp6eHpX17X2AW0ihC+GMx/KyIh5M5ruv6MQ0jslr1tJLAtjFUFGNibVWKzq/TvrG/H/UDimI0VR4r5VgyTLwzTSYKpma8DhgC55gCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JccF2kx/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d88a8c66b7so188180a91.1;
        Thu, 19 Sep 2024 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770083; x=1727374883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MrYY6KXrN1UOAxqtI8px2dOYmvL0jSPY/p2rOj/QCs=;
        b=JccF2kx/K505ONDiYMj7nSB3hCJgjrC4rywkV5N4ibgBMR6BGR3Ln3rwle1ThyyMIC
         /zJqWUawSS1KoPmN0QjgTgvnXq9Z0YcVBAZJjUJ1NB0vKq7DYXHhZBhlyNiKqV34el6T
         cGqeWCJF7JlIxK68yrPZz+l+1FQ0SNPtNzCHpwscOm3QlM1iPPoVvFMtH8NmzA6hTb8f
         JPZh3GsA00b/degqUtPro9/Ivsf9TgeIIEXOyftklCwVqL1dMWCyeFYPiDpkS6C0UKXK
         U12Jk+Or8xqOnHMEwaAhsx/ozPj56QorJyzWhAjJ6jdWzJF9XAWigu1QiTE3AAu04Tmi
         Vw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770083; x=1727374883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MrYY6KXrN1UOAxqtI8px2dOYmvL0jSPY/p2rOj/QCs=;
        b=Oj4aH4aP1qaqCWicn9CPDQDKTjAOPURKBVCYnFRGY1d2wCma16NC9TqAXeXlwYW28e
         WXvQkr6KHhlANIDr1e6jmqebuIqblsotyP1CZTHmInigaTGrLSC7bHU99DOefcqqvlzY
         JLsnvAdK/IKu2HEEUMvPjqOSbfwki6BHxaGtwhQElHL8WqwYL7xFPUCqRUjz/0a7rM0V
         pq2NL4K2swcxhwTaDXrSZsLN2/N/FA5db8PaCsPRrcnR4TdhmF4cxtoOXODEDGUgyzss
         CQNCGad28TxPcqEZch/mbC+FqKgPTqj+bT4ATjOa4+Db+vvu/yPHJ6myXG8Y/rvtKF8Z
         Dw7w==
X-Forwarded-Encrypted: i=1; AJvYcCUnwl6EsUDVugFFgTWMhGqsVexrhLAO7Ja8S3g/p/Ten113amvSPs/LBPsm68cW2yvV9ylkX74Q7k98b7PmrIxlTZGpWg==@vger.kernel.org, AJvYcCUt8Tr0sscaQxgo8rQvhJzZgPX7vCcYh7PooA1qaZwEmFM7WIS2B0scTVRwegsGaMCVC6VSfTTGhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6P2wQDPvwINIgl9W7GuUDkLR4D33FEQ6+Xjkken+/uS6xEbAl
	QFWk64Be4BoboBs3P9hMSDYwRuu4ldayputft/DSHZEGqiRfMhBYNQrA9XaJN/RWzFMwCRZ/Yp/
	dLZ4nd4EYL38NVzDvh5aYIfm2LY4=
X-Google-Smtp-Source: AGHT+IEXXeIM8dNWFS4VPSURU5IYVIU2PDmNudByY32B+86hWDh8xiL2RTOEsF12kexHYet16PlAcE3UBN3xeJ+F2Lg=
X-Received: by 2002:a17:90a:fa4b:b0:2da:6fc9:1a52 with SMTP id
 98e67ed59e1d1-2dd7f17bb60mr186649a91.0.1726770083232; Thu, 19 Sep 2024
 11:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919171952.403745-1-lkml@antheas.dev> <20240919171952.403745-3-lkml@antheas.dev>
 <1cbc0cda-549a-4333-9045-470c51981af5@amd.com>
In-Reply-To: <1cbc0cda-549a-4333-9045-470c51981af5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Sep 2024 14:21:11 -0400
Message-ID: <CADnq5_N63ncHDdr+=xB5RqYZXnMjjrVCgqTDz0zmPdSP98ip-A@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] acpi/x86: s2idle: handle screen off/on calls
 outside of suspend sequence
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, linux-pm@vger.kernel.org, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org, 
	luke@ljones.dev, me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 1:35=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> +dri-devel
>
> For those joining late; this is the full series for context.
>
> https://lore.kernel.org/linux-pm/20240919171952.403745-1-lkml@antheas.dev=
/T/#maee308be5349d8df25c8ccf12144ea96bbd4cbbd
>
> On 9/19/2024 12:19, Antheas Kapenekakis wrote:
> > Currently, the screen off/on calls are handled within the suspend
> > sequence, which is a deviation from Windows. This causes issues with
> > certain devices, such as the ROG Ally, which expects this call to be
> > executed with the kernel fully awake. The subsequent half-suspended
> > state makes the controller of the device to fail to suspend properly.
> >
> > This patch calls the screen off/on callbacks before entering the suspen=
d
> > sequence, which fixes this issue. In addition, it opens the possibility
> > of modelling a state such as "Screen Off" that mirrors Windows, as the
> > callbacks will be accessible and validated to work outside of the
> > suspend sequence.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   kernel/power/suspend.c | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 19734b297527..afa95271ef00 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -507,6 +507,19 @@ int suspend_devices_and_enter(suspend_state_t stat=
e)
> >
> >       pm_suspend_target_state =3D state;
> >
> > +     /*
> > +      * Linux does not have the concept of a "Screen Off" state, so ca=
ll
> > +      * the platform functions for screen off prior to beginning the s=
uspend
> > +      * sequence, mirroring Windows which calls them outside of it as =
well.
> > +      *
> > +      * If Linux ever gains a "Screen Off" state, the following callba=
cks can
> > +      * be replaced with a call that checks if we are in "Screen Off",=
 in which
> > +      * case they will NOOP and if not call them as a fallback.
> > +      */
> > +     error =3D platform_suspend_screen_off();
>
> It's a bit muddy; but I wonder if calling
> drm_atomic_helper_disable_all() makes sense here.

I think we either want to call this after devices have suspended or
it's something the drm drivers would call themselves once they have
turned off the displays as part of their suspend handling.

>
> > +     if (error)
> > +             goto Screen_on;
> > +
> >       if (state =3D=3D PM_SUSPEND_TO_IDLE)
> >               pm_set_suspend_no_platform();
> >
> > @@ -540,6 +553,9 @@ int suspend_devices_and_enter(suspend_state_t state=
)
> >    Close:
> >       platform_resume_end(state);
> >       pm_suspend_target_state =3D PM_SUSPEND_ON;
> > +
> > + Screen_on:
> > +     platform_suspend_screen_on();
>
> The problem with my suggestion above is what would you put here for
> symmetry?  drm_atomic_helper_resume() doesn't look right to me.
>
> Maybe it's a no-op from DRM perspective and the drivers handle it.

if suspend is aborted, this should be called after devices resume or
from the relevant drm drivers.

The question is whether platforms with multiple GPUs care whether all
GPUs have their displays off or if just the integrated GPU matters.
Maybe after all PCI display class devices have suspended?

Alex

>
> >       return error;
> >
> >    Recover_platform:
>

