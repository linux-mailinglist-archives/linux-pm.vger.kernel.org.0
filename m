Return-Path: <linux-pm+bounces-14542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C8D97E2DC
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 20:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3913281148
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FF2940B;
	Sun, 22 Sep 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ehu4Voxg"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F77E1;
	Sun, 22 Sep 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727028046; cv=none; b=q+gafc2XiRUle/1QGQnLjiOc1CD3y86a6WzWDwxDzlq65e1Ov6PQm1DF7nvWgU7eslxGZ7hnQGIjrJYfS3XZ/cE5iQ51FWotKeiL9Mmqn/7ZsK+T6kmcHJsCPA+kQsGrpUN/3gWJM+ZFPEdcyu86oju+/YG0yq2ycDLiRuLlQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727028046; c=relaxed/simple;
	bh=RZ9KLVpf4ADGH013tt9u5NLP5QomeEy93KEp5eAkk5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EERqn+wyyHY4jxQJ6X82e/tHDzYCdLptklUjUpn05h1uyCe6EJaw5OFM/vAEeXF9vmiL4oyycnDADaw9s1EQaegQxl28MN5nXmotNhNeZXdml3CE/HCvoXCBuC9te2eiUQfK2K4uPwpgJatLtl+8T7aU0JPW9cIS1sWPf8BTZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ehu4Voxg; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 095682E00722;
	Sun, 22 Sep 2024 21:00:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727028040;
	bh=w/ggT9ZxKvzCRMxL9ehd9vX/f4T/NuWR6Bsd0A4U+aY=;
	h=Received:From:Subject:To;
	b=ehu4VoxgxTPbZOCH/v/NLotQi31CUKJUSmKtvmgj93Ko3Ivv1EAbZZOCLrUpc3H1K
	 rGn2z4xzKhtNWF8XEjy5+uIGoSklGkbJHDCS//P3kIORXC3LyMUMUMDTfah6Pxb28Q
	 NwLieTVZz4rxtvQh0FbVCXYz6pOFuBPHJ6RXNth4=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f173.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2f759b87f83so36945651fa.2;
        Sun, 22 Sep 2024 11:00:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUPMw/DOl9rqk1x6WvyDaTOOv/wrQtGA06KNWMhkK96hbfzqwLxqoMBb0xireyZ7GnW/WDuTVd4chkvPZ461JZCmCIX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HoXCau66sXe8sWsAfF0wVuaqwn0c/zb3Exa4InEGc6OZX6Xb
	Y682kba//5BpxsgEWqHueazfT4B1K22WigdBb4Wla9eF3ZpWUOz+jJZ7qzmTBLJNpJLVnLdp/XX
	F5Ybbuo2VU2TGTgsM5vhBKSIiKqY=
X-Google-Smtp-Source: 
 AGHT+IGeb0ItAazBjkpogYanFDl+qCsIabjUIAU4lRhzvIkL5lsxxRDXiCligFcBU7nfI+7WGZbcuySLvYpJZmf/NA8=
X-Received: by 2002:a2e:a587:0:b0:2f5:806:5cee with SMTP id
 38308e7fff4ca-2f7cc365d59mr41597321fa.11.1727028039262; Sun, 22 Sep 2024
 11:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-4-lkml@antheas.dev>
 <9b47ee96-f789-4e96-890f-f3dcf9da2e02@gmail.com>
In-Reply-To: <9b47ee96-f789-4e96-890f-f3dcf9da2e02@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 22 Sep 2024 20:00:27 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFe9c8a3Ji1kmGkPzDjEQTK7kCORT_d4otyqK7Jq+B2rA@mail.gmail.com>
Message-ID: 
 <CAGwozwFe9c8a3Ji1kmGkPzDjEQTK7kCORT_d4otyqK7Jq+B2rA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] acpi/x86: s2idle: add quirk table for modern
 standby delays
To: Denis Benato <benato.denis96@gmail.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <172702804035.29934.5535946841316481679@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Denis,
I did not add a Tested-by for this reason. The Report-by is to credit
you for bringing this into my attention, I thought you were ok with
this. If not, I will remove it in the next revision.

Best,
Antheas

On Sun, 22 Sept 2024 at 19:55, Denis Benato <benato.denis96@gmail.com> wrot=
e:
>
> On 22/09/24 19:22, Antheas Kapenekakis wrote:
> > Unfortunately, some modern standby systems, including the ROG Ally, rel=
y
> > on a delay between modern standby transitions. Add a quirk table for
> > introducing delays between modern standby transitions, and quirk the
> > ROG Ally on "Display Off", which needs a bit of time to turn off its
> > controllers prior to suspending (i.e., entering DRIPS).
> >
> > Reported-by: Denis Benato <benato.denis96@gmail.com>
>
> I told you privately that as stated here: https://www.kernel.org/doc/html=
/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewe=
d-by-suggested-by-and-fixes
> Reported-By tags are to be followed by a Closes tag stating that the issu=
e is solved.
>
> What has been presented to me today was not about solving bugs, but chang=
ing how they manifests and therefore permission was not granted to you to r=
epresent me as satisfied with the work as it would be wrong to assume issue=
s are solved and this is worth merging.
>
> Furthermore everybody can see my answers to your v1 patch and there is no=
 need to attach a Reported-by when the issue has been reported publicly and=
 is not resolved.
>
> I will add my Tested-off-by by myself whenever I will be fully satisfied =
by work presented: in the current state I am not.
>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  include/linux/suspend.h |  5 +++++
> >  kernel/power/suspend.c  | 41 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index 8f33249cc067..d7e2a4d8ab0c 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -144,6 +144,11 @@ struct platform_s2idle_ops {
> >       int (*display_on)(void);
> >  };
> >
> > +struct platform_s2idle_quirks {
> > +     int delay_display_off;
> > +     int delay_display_on;
> > +};
> > +
> >  #ifdef CONFIG_SUSPEND
> >  extern suspend_state_t pm_suspend_target_state;
> >  extern suspend_state_t mem_sleep_current;
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 610f8ecaeebd..af2abdd2f8c3 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -11,6 +11,7 @@
> >
> >  #include <linux/string.h>
> >  #include <linux/delay.h>
> > +#include <linux/dmi.h>
> >  #include <linux/errno.h>
> >  #include <linux/init.h>
> >  #include <linux/console.h>
> > @@ -61,6 +62,30 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
> >  enum s2idle_states __read_mostly s2idle_state;
> >  static DEFINE_RAW_SPINLOCK(s2idle_lock);
> >
> > +// The ROG Ally series disconnects its controllers on Display Off, wit=
hout
> > +// holding a lock, introducing a race condition. Add a delay to allow =
the
> > +// controller to disconnect cleanly prior to suspend.
> > +static const struct platform_s2idle_quirks rog_ally_quirks =3D {
> > +     .delay_display_off =3D 500,
> > +};
> > +
> > +static const struct dmi_system_id platform_s2idle_quirks[] =3D {
> > +     {
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> > +             },
> > +             .driver_data =3D (void *)&rog_ally_quirks
> > +     },
> > +     {
> > +             .matches =3D {
> > +                     DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> > +             },
> > +             .driver_data =3D (void *)&rog_ally_quirks
> > +     },
> > +     {}
> > +};
> > +
> > +
> >  /**
> >   * pm_suspend_default_s2idle - Check if suspend-to-idle is the default=
 suspend.
> >   *
> > @@ -589,12 +614,26 @@ static int enter_state(suspend_state_t state)
> >       if (state =3D=3D PM_SUSPEND_TO_IDLE)
> >               s2idle_begin();
> >
> > +     /*
> > +      * Windows transitions between Modern Standby states slowly, over=
 multiple
> > +      * seconds. Certain manufacturers may rely on this, introducing r=
ace
> > +      * conditions. Until Linux can support modern standby, add the re=
levant
> > +      * delays between transitions here.
> > +      */
> > +     const struct dmi_system_id *s2idle_sysid =3D dmi_first_match(
> > +             platform_s2idle_quirks
> > +     );
> > +     const struct platform_s2idle_quirks *s2idle_quirks =3D s2idle_sys=
id ?
> > +             s2idle_sysid->driver_data : NULL;
> > +
> >       /*
> >        * Linux does not have the concept of a "Screen Off" state, so ca=
ll
> >        * the platform functions for Display On/Off prior to the suspend
> >        * sequence, mirroring Windows which calls them outside of it as =
well.
> >        */
> >       platform_suspend_display_off();
> > +     if (s2idle_quirks && s2idle_quirks->delay_display_off)
> > +             msleep(s2idle_quirks->delay_display_off);
> >
> >       if (sync_on_suspend_enabled) {
> >               trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> > @@ -624,6 +663,8 @@ static int enter_state(suspend_state_t state)
> >   Unlock:
> >       mutex_unlock(&system_transition_mutex);
> >
> > +     if (s2idle_quirks && s2idle_quirks->delay_display_on)
> > +             msleep(s2idle_quirks->delay_display_on);
> >       platform_suspend_display_on();
> >       return error;
> >  }
>

