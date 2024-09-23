Return-Path: <linux-pm+bounces-14582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03F97EEFD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 18:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4108281EF8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE4146A86;
	Mon, 23 Sep 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="uWO/aCSJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194D7DA81;
	Mon, 23 Sep 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108132; cv=none; b=ivUMfOmVUOnG8KoLTAxZ2CdbZtNDQd77bZc2yFTDPRJG4VRPPSY2pxbtu08YUdX+Qn5MOhKp/5wK1uIdPl9iio9QY6XwgBkk6IOyLCOcL+/s2vYsH9tjfH8v3kegxOKQF+Ry27xjnngTIO1xDALgF08pONw3ZIFhbCLKQid+uFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108132; c=relaxed/simple;
	bh=L40ikmPqwa9pSrC17GqjzGQXqBPxu/HVqgcMX7iPnEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STmANvk7RP5Ur6AcgBJTV1kAtEaq/QEYryH4y/qA1oRmSTFAhDi/YoIRutPqRmk+K/ssbmK4OUGsNmCjxIaKMejkiwMdukf4ozneDKj7cK2PxKC8nKRw39QWDiiCEyW1f5rCC/WGG1ktiPgnT8QQFjlLTtwvdnSWdo7VA8CKOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=uWO/aCSJ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 563C62E05EEA;
	Mon, 23 Sep 2024 19:15:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727108126;
	bh=fiBDYqLO9vwTDa0kENC/H8tsARqBxWrgVq2JSqvU140=;
	h=Received:From:Subject:To;
	b=uWO/aCSJoZvT9QiMcRAc5emQMKoX1xDFb7Y+7ba1B4pLai8uGPkA54FtKtjpvDmL4
	 svqVwLEZBTL+smD9+/l+HT19SvijzmV3mwiWG95kzidBrcXv2qi4AjRJOlztidKTEN
	 7f6CgvPm3smn8wLnEvq7i9FVnHSk/C0lxJtseqOo=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2f75aaaade6so46910411fa.1;
        Mon, 23 Sep 2024 09:15:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUdL2oN4bjr9DirNI11ZH6hb+CYmkOgHTb8dEXikYDpVuw/XLr2nT/RJURDwVjR1daVnP4QB1oda+h1cp1ZdKCdgeiU@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9i3Qm6XR93jNIqQlqLIL9CdezZSpadCDLTOJXEOQlseyFmYN
	C6G1zwm2q6OlF3UEtnLsjMEu4WcB4B2v576ek0ZcSY5W5J1pAC0+EnPjjt902py3Q/02Fk2lMwz
	SlrUXCC30qEAEamreLWOPt8BPvdY=
X-Google-Smtp-Source: 
 AGHT+IFUSrYAetKzeKuNKxEW2XhzLTyBMU/I5sk722yjfHe0+ieu8kH1srSVCZGjB2iBMY4KO+h2hVIrpq3CDi3d2Zw=
X-Received: by 2002:a05:651c:221b:b0:2f6:5f0a:9d00 with SMTP id
 38308e7fff4ca-2f7cc3578ffmr58494731fa.1.1727108125682; Mon, 23 Sep 2024
 09:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-3-lkml@antheas.dev>
 <1a9b611c-51f0-4c3d-8bc2-62c6b6104fd2@amd.com>
In-Reply-To: <1a9b611c-51f0-4c3d-8bc2-62c6b6104fd2@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 18:15:14 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFwU=KMgDUmKsYRu323dsuUfQYa8e-aXV3JGGSkgF-RkQ@mail.gmail.com>
Message-ID: 
 <CAGwozwFwU=KMgDUmKsYRu323dsuUfQYa8e-aXV3JGGSkgF-RkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] acpi/x86: s2idle: handle Display On/Off calls
 outside of suspend sequence
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	luke@ljones.dev, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172710812674.31882.5644276653664857231@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Does DRM core handle virtual displays like VNC?

As mentioned in the cover letter, the _DSM specifies both virtual and
actual displays.

Also, Windows behavior is like a lockscreen. 5 seconds after screen
turns off after inactivity, instantly when you press the power button.

I tend towards making a sysfs entry. Not sure.

Antheas

On Mon, 23 Sept 2024 at 18:03, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/22/2024 12:22, Antheas Kapenekakis wrote:
> > Currently, the Display On/Off calls are handled within the suspend
> > sequence, which is a deviation from Windows. This causes issues with
> > certain devices, where the notification interacts with a USB device
> > that expects the kernel to be fully awake.
> >
> > This patch calls the Display On/Off callbacks before entering the suspend
> > sequence, which fixes this issue. In addition, it opens the possibility
> > of modelling a state such as "Screen Off" that mirrors Windows, as the
> > callbacks will be accessible and validated to work outside of the
> > suspend sequence.
> >
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   kernel/power/suspend.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index c527dc0ae5ae..610f8ecaeebd 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -589,6 +589,13 @@ static int enter_state(suspend_state_t state)
> >       if (state == PM_SUSPEND_TO_IDLE)
> >               s2idle_begin();
> >
> > +     /*
> > +      * Linux does not have the concept of a "Screen Off" state, so call
> > +      * the platform functions for Display On/Off prior to the suspend
> > +      * sequence, mirroring Windows which calls them outside of it as well.
> > +      */
> > +     platform_suspend_display_off();
> > +
>
> I thought about it some more over the weekend and if moving the screen
> on/off _DSM at all I don't feel this is the right place for triggering it.
>
> IMO it should be called by DRM core.  That is when the number of CRTCs
> active goes 1+ -> 0 call screen off and when it goes 0->1+ call screen on.
>
> There could be an argument made only for eDP this happens, but I think
> that's a slippery slope if you end up with an AIO design that uses DP
> instead of eDP or a desktop for example.  So the safest policy should be
> across all CRTCs of all GPUs.  During the suspend sequence any that were
> left on will get turned off, and then it could be triggered at that time
> instead.
>
> By making such a change then when the compositor turns off all displays
> at runtime you can potentially support dark screen background downloads
> that have specifically called this _DSM and any actions that are taken
> from doing so.
>
> >       if (sync_on_suspend_enabled) {
> >               trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> >               ksys_sync_helper();
> > @@ -616,6 +623,8 @@ static int enter_state(suspend_state_t state)
> >       suspend_finish();
> >    Unlock:
> >       mutex_unlock(&system_transition_mutex);
> > +
> > +     platform_suspend_display_on();
> >       return error;
> >   }
> >
>

