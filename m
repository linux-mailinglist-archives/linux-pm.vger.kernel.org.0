Return-Path: <linux-pm+bounces-23983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62934A5F897
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE3C3BB952
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC2269AF4;
	Thu, 13 Mar 2025 14:32:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C3267738;
	Thu, 13 Mar 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876377; cv=none; b=r8IaWsq8X3U6JIwbIGqRsEcw6Ac883wVpCqgl3R+Ckr1/ecm7V0jA41Jdab+cZ7u1ggA75yqVFQWjVt9o5ZZH5vDEqITllvuaW8ZiLCjQrSjJA9kuUf6ThioGA1yoVHhgfOwxIFMaBoSXbZe9KDnfjNgjKAhYeDZf+rcRT0wx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876377; c=relaxed/simple;
	bh=iX3cA2HK76pcwOvRpz8gubtaOjLb8n2WVMacaAiM/9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNjvzo5qU5IzWpJXADCqQPr7mlhFi7mbKbDcTwKtjTw8VsN3e4OLSyKiVeJ0hdvAl8FjBlK9CPl5QlkAIQ1mHPpCe7Wgcwmn1/A5S/8JeXQVdTvOgWiSl++ZiXwbm2ATZoCYzwIAlolctdxTbE606uLA5MhK4x3TmjCKsPUvD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e6c082eac0so10373626d6.0;
        Thu, 13 Mar 2025 07:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876373; x=1742481173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BH4etTF8KwRmanIMJ5g8gQ5kEM3Izri0CoFiYQLuMU=;
        b=oUpzPPvQpuj5CD/Po3w1Wha49Vr3BamHWm9Da5vUNaBNveNBXWmhdumZK988KlvbH8
         qM/b6fq4j6cl0di8NY3pbH+nZzAp63+buu7JqjYUL+og7OD1ZmfKKwx527mgxPouiy9r
         d1CAkWBIHMMvZxuOTedHzIOhyH1hItBLICTg8jPrUN2nF7X3XZq7l7atIwn1uypz/Dif
         26oiXer+IkG1ZmgVM/xgl5kO229Hgl14HKb99MuJdT2kSAXaJXB6H/uRYTZVze9+jocy
         dn5xgAyOvFTSsyHOZXpNe5z2okr4G/KCpIVGeVPo7QquZV88CzQ3zM2v6kDKRx54qt46
         t/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFoIdc3HTl4yuUgFCortND/WwoFez6/J8Drem8apppDHsxdUV3FsptM67ZbiBs8zSGVzCE82tE4/P91MDZvXTg/w0=@vger.kernel.org, AJvYcCW7dV2yzBz62Uy2+Wq2QPRZKpodMOBxmXwOWLQhAWv60f0itB1RD0C+wlEtPzV6HPzjNxf2NfITww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDh4U2z/4o6JM9mLZb/qPYVwIU8CpzJeSr3wr+/rgSZFEKjwTr
	yl5vyjIlojDFD1ZOuMTRv7WunDrpGS690l+nitN4XrJa0HUrKYMDwoopW+QZ
X-Gm-Gg: ASbGncu93E+bzZUHoXZzdB4kt74BowPdx4js1yjKp1PgJaVCnm2sQICtM0wsssrn4PK
	TNlorto52FdDKiRVxnm5e+yVemn61rWaARxUWb179ipZaVsQWtp35JV0fGWyfpUupR50PB+u0ZO
	f6Q/OwxWCmRJrM7PsWnNC3Guq7vtUuZC8H5MmL0g+RsyLaXh1TNHpb11o8D8wUL+mOYfPNm6bQs
	SWuFa5JP+QN4FkfkknU9WokmFsy1JMHFVOVQzQg2M0o2UDD6GWj+YFUNft6+CR62Lr9wHIXVjax
	dguFzvo6raKx28Jqsqd2xNN8UVM2rGLsZcNbRd3tx6pzNirrKbiapvUVzxeXrjbgyooM3MR7DFJ
	lvx3rAms=
X-Google-Smtp-Source: AGHT+IGXUDZGLO18qnFS8eLFX3OxpujVPl/gkaZNhJDUtyc9xGs8Lnw9ZCeDCqW3yBxrvT3FfBOm2A==
X-Received: by 2002:a05:6214:1bcc:b0:6ea:d629:f47d with SMTP id 6a1803df08f44-6ead629f57dmr73323506d6.44.1741876372546;
        Thu, 13 Mar 2025 07:32:52 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90d68eb2sm211401241.7.2025.03.13.07.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:32:51 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-868da0af0fcso448171241.2;
        Thu, 13 Mar 2025 07:32:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2IUm/DrRYI4Etgw1aQ5bXGQLH4WD1UNseZcvqLeRMsW5leGvrvz9OOWhm+f9boQtQSENNRXKTGD5MuX6d9imSxM8=@vger.kernel.org, AJvYcCX5UTqpWpRXB4wWh9AYQLhoKDtBK3sa/tGXKcjECZKc+6iK/V6s92uYLffyFL1EovsNRZTWC2HQHw==@vger.kernel.org
X-Received: by 2002:a05:6102:d8f:b0:4bb:e6bc:e16d with SMTP id
 ada2fe7eead31-4c30a6b1f28mr19722590137.20.1741876371022; Thu, 13 Mar 2025
 07:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXN9A-1P_qe=BwKjLaoqxU8iJUQK6h8=s-apR4Y0em_0Q@mail.gmail.com>
 <CAMuHMdXXWH0Do5zXWJ1Uc6dyEb9o1chGSyeyzgDrX+v1wZ7e_A@mail.gmail.com>
 <CAGETcx_wA9RB9QhMPqsLHDFZ4cwOFgE8dBL9ssFkT=J6DEgjGg@mail.gmail.com> <CAMuHMdUCXJkg3rkngXf7cqa50u-TEAOntV6O=Nvg33Q9diPJPw@mail.gmail.com>
In-Reply-To: <CAMuHMdUCXJkg3rkngXf7cqa50u-TEAOntV6O=Nvg33Q9diPJPw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2025 15:32:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLEHwjaNnysDZ_Unqj-SwmUdwRao_oJvYvVsQ9SCn06A@mail.gmail.com>
X-Gm-Features: AQ5f1JpJVmaxOlX9uCCFjKjL22U0WLUrpcwd4rJdfdEnxO1oQRAp4pCBKMVxjFU
Message-ID: <CAMuHMdWLEHwjaNnysDZ_Unqj-SwmUdwRao_oJvYvVsQ9SCn06A@mail.gmail.com>
Subject: Re: s2idle blocked on dev->power.completion
To: Saravana Kannan <saravanak@google.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Thu, 13 Feb 2025 at 11:26, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> On Thu, 13 Feb 2025 at 09:31, Saravana Kannan <saravanak@google.com> wrot=
e:
> > On Mon, Feb 10, 2025 at 2:24=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Fri, 7 Feb 2025 at 16:08, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> > > > Instrumenting all dev->power.completion accesses in
> > > > drivers/base/power/main.c reveals that resume is blocked in dpm_wai=
t()
> > > > in the call to wait_for_completion() for regulator-1p2v, which is
> > > > indeed a dependency for the SN65DSI86 DSI-DP bridge.  Comparing
> > >
> > > [...]
> > >
> > > > Looking at /sys/devices/virtual/devlink, the non-working case has t=
he
> > > > following extra entries:
> > >
> > > Note that the SN65DSI86 DSI-DP bridge driver uses the auxiliary bus
> > > to create four subdevices:
> > >   - ti_sn65dsi86.aux.0,
> > >   - ti_sn65dsi86.bridge.0,
> > >   - ti_sn65dsi86.gpio.0,
> > >   - ti_sn65dsi86.pwm.0.
> > > None of them have supplier:* symlinks in sysfs, so perhaps that is
> > > the root cause of the issue?
> >
> > Sorry, I haven't had time to look into this closely. Couple of
> > questions/suggestions that might give you some answers.
> >
> > Is this an issue only happening for s2idle or for s2ram too? I'd guess
> > both, but if not, that might tell you something?
>
> The two (very similar) boards I could reproduce the issue on do not
> support s2ram yet.
>
> > The only reason the wait_for_completion() wouldn't work is because the
> > supplier is not "completing"?
>
> Yes, the diff shows ca. 70 additional calls to "complete_all()" in the
> good case.
>
> > There's some weird direct_complete logic
> > that I haven't fully understood. You can look at that to see if some
> > of the devices are skipping their resumes and hence the "completes"
> > too? Also, runtime PM and some flag can cause some lazy resume or
> > avoid suspending already suspended devices behavior. Check that too.
>
> Thanks, will give it a try...

More findings:

1. The issue does not happen with "fw_devlink=3Doff".
   It does happen with all of "fw_devlink=3D(permissive|on|rpm)".

2. Looking at differences in direct_complete state didn't help.

3. When the issue happens, two more dependency cycle fixes are printed:

       /soc/dsi-encoder@fed80000: Fixed dependency cycle(s) with
/soc/i2c@e6508000/bridge@2c
       /soc/i2c@e6508000/bridge@2c: Fixed dependency cycle(s) with
/soc/dsi-encoder@fed80000

     These are not new: the first one is printed 4 instead of 3 times,
     the second one is printed 3 instead of 2 times.

  4. When the issue happens, /sys/devices/virtual/devlink shows 3
     more links:
       A. platform:feb00000.display is a supplier of
platform:fed80000.dsi-encoder
       B. platform:fed80000.dsi-encoder is a supplier of
platform:feb00000.display
       C. i2c:1-002c is a supplier of platform:fed80000.dsi-encoder

     A and B are due to endpoint links between ports of the display
     and dsi-encoder nodes.
     C is due to the endpoint links between ports1 of the bridge and
     dsi-encoder nodes. However, I'd expect platform:fed80000.dsi-encoder
     being a supplier of i2c:1-002c, too?

     Note that feb00000.display is one of the devices that
     were probe deferred, due no driver for fed80000.dsi-encoder
     being available.
     The other device that was probe-deferred is
     ti_sn65dsi86.bridge.1068, which is an auxiliary-bus subdevice of
     i2c:1-002c.

  5. What happens in dpm_noirq_resume_devices()?

       /*
        * Trigger the resume of "async" devices upfront so they don't have =
to
        * wait for the "non-async" ones they don't depend on.
        */
        i2c-1 (i2c bus) and 1-002c (bridge device) are async,
        thus triggered first.
        After that, the remaining devices are resumed.

     In the bad case:

       device_resume_noirq(fed80000.dsi-encoder, async=3Dfalse)
         dpm_wait_for_superior()
           parent soc: skipping wait_for_completion()
           dpm_wait_for_suppliers()
             supplier feb00000.display: skipped, DL_STATE_DORMANT
             ^^^^^^^^^^^^^^^^^^^^^^^^^
Cfr. extra link A above (harmless)

             supplier e6150000.clock-controller: skipping wait_for_completi=
on()
             supplier 1-002c: wait_for_completion() =3D> BLOCKED
             ^^^^^^^^^^^^^^^
Cfr. extra link C above, but the bridge device hasn't been resumed yet.

Then it continues resuming async devices:

       device_resume_noirq(i2c-1, async=3Dtrue)
         dpm_wait_for_superior()
           parent e6508000.i2c: wait_for_completion(), completed
           dpm_wait_for_suppliers()
             (none)
         complete_all()

       device_resume_noirq(1-002c, async=3Dtrue)
         dpm_wait_for_superior()
           parent i2c-1: wait_for_completion(), completed
           dpm_wait_for_suppliers
             supplier e6050000.pinctrl: wait_for_completion(), completed
             supplier regulator-1p2v: wait_for_completion() =3D> BLOCKED
             ^^^^^^^^^^^^^^^^^^^^^^^
The regulator hasn't been resumed yet.

     In the good case:

       device_resume_noirq(fed80000.dsi-encoder, async=3Dfalse)
         dpm_wait_for_superior()
           parent soc: skipping wait_for_completion()
           dpm_wait_for_suppliers()
             supplier e6150000.clock-controller: skipping wait_for_completi=
on()
         complete_all()
         ^^^^^^^^^^^^
As feb00000.display and 1-002c are not suppliers, fed80000.dsi-encoder
does not have to wait for them.

       [...]

       device_resume_noirq(regulator-1p2v, async=3Dfalse)
                           ^^^^^^^^^^^^^^^
After a while, the regulator is resumed...

         dpm_wait_for_superior()
           parent platform: wait_for_completion()
           dpm_wait_for_suppliers()
             (none)
         complete_all()

       [...]

       device_resume_noirq(regulator.1, async=3Dfalse)
                           ^^^^^^^^^^^^^^^
followed by the virtual counterpart.
         dpm_wait_for_superior()
           parent regulator-1p2v: skipping wait_for_completion()
           dpm_wait_for_suppliers ()
             (none)
         complete_all()

       [...]

       device_resume_noirq(1-002c, async=3Dtrue)
                           ^^^^^^
The bridge is resumed much later...

         dpm_wait_for_superior()
           parent i2c-1: wait_for_completion(), completed
           dpm_wait_for_suppliers
             supplier e6050000.pinctrl: wait_for_completion(), completed
             supplier regulator-1p2v: wait_for_completion(), completed
             ^^^^^^^^^^^^^^^^^^^^^^^
             supplier regulator-1p8v: wait_for_completion(), completed
             supplier e6050980.gpio: wait_for_completion(), completed
             supplier e61c0000.interrupt-controller:
wait_for_completion(), completed
             supplier regulator.1: wait_for_completion(), completed
             ^^^^^^^^^^^^^^^^^^^^
... after the regulators were resumed
             supplier regulator.2: wait_for_completion(), completed
         complete_all()

So the issue seems to be the creation of link C
(i2c:1-002c is a supplier of platform:fed80000.dsi-encoder).
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

