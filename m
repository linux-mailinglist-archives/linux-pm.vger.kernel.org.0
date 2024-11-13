Return-Path: <linux-pm+bounces-17513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4F9C7970
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 17:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C31F2821F4
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11041EF955;
	Wed, 13 Nov 2024 16:58:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014570829;
	Wed, 13 Nov 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517107; cv=none; b=afXDNf38iF2qiaT4HTh3623rL6+RrvkNaTrJVc0v9Yo+CrS6yxqb2IzRYex4bL1TPQ1yWIcQZHf0jwPo+CHLBylLDDACFhsMK43SRSexICy6joYQgVR/O3+6W7y+591StQe+SAF5s0Ib5/gdKVTOC3w6WnXqlfQgeHw9mQTJC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517107; c=relaxed/simple;
	bh=gD/sP2apq312NCyFdt+mOE929V1VWqMCLhc5GAaFiOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cs1I7gVGDWL2npjYzx4r0ujq9w8B1L64Uqj0iKhFrmQmT0LCth7Fv2VD+wlPe3aJBlCVCj4Vp2w0R98sdKgYKLWo83USg4hRXcILAhVZLkMVg0Lm5rkSNh9j9sd60ogUdKp7MW8IDO9gohehXZmWtD/Sei2iVYH8vJB1CT1WXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea7c9227bfso72139207b3.2;
        Wed, 13 Nov 2024 08:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517104; x=1732121904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90S5lqnEohvVcnB+BzdzmQ6LdpwxbZFL3C+GHVFnOiE=;
        b=tJcmZ6WCKv4fN9IFh0f6pKOxbaxmz1hJxkbYFrW3H14kyOAAe46/lhnihO2WUyBvBT
         RkGjgbwttDR1YxIbyalGWffxvI0gSQvx12C3p/AgE/0onzMHNWTsKWJK5JLfm14v1Iir
         6PgQ6Vea5w8pRA5sd3E95rbM5wMMb71vCXENPth2B7yHD/t64XiPl5n2loAmoke/eOQk
         jzgKfbblHDcmNXic+43h9tIaqlNEEH9vhNzv69s4PYrtqGrjPbaHHPTNHkGhRCaWJTwK
         DXo6lD+KJKvbwtKSlb1Zoa3fpRY4Df/eFyq8eCB6nDgdo/v2i37apBg78GJW1ThUl84o
         6KpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUzcaLrXcEUMFLC+gsxGP3aW4sunWdoIMvkf/X6s9NcFYRk6Qx9bR8bPvyox4nmvZ2gYpirIsf+IoW@vger.kernel.org, AJvYcCUabd+eC+58ubvEi77I0tlfBcLAjPYr1c8oa91VlA2/JDy1zJCgS6lNLytqOe5a8Na/wCB6Y/ajNYCLUXIk5IEgYto=@vger.kernel.org, AJvYcCX8r2VTGoKJ4pmLhdUE5MN9Bo7oErMPlx8tbIQcvRe15hmCtMmMVF04+cSEySi0rDLg+15AgKF3ppk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQQ56GqBsS57EOVcULZuNfptLvmzat/z3/9UeePiM55MO85zB
	ez9+KuaC4eHzRFQe7fHXdwtKUx4DrqiD/P3gIu0NwsIOPOMOC7LtOQiz0clI
X-Google-Smtp-Source: AGHT+IECvKMKdp5KOHb0o5AH7X/YtcLJVvFuwFvrv8YKePwghXkIC2Y9EGGEX7htYwuw7eImtLdpVA==
X-Received: by 2002:a05:690c:6408:b0:6e2:f61e:8c9 with SMTP id 00721157ae682-6eaddf9751cmr231768527b3.30.1731517103361;
        Wed, 13 Nov 2024 08:58:23 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb6562fsm32169657b3.84.2024.11.13.08.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:58:23 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e292926104bso6430940276.0;
        Wed, 13 Nov 2024 08:58:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9Cm6WH/U257tsu5sWSXnvxqF2zB8UGM1Xi7otN3F4dvAim3/UKk2V9Nq/AoeOcSzZIxwqTGbQWyE=@vger.kernel.org, AJvYcCX1gVL47iw0g4dZ8jMjl4iLB8K38q4yr/vX2rf0MuJls8SBdh/izTuy0lO1TKOQK06og/Jl4XWg991j@vger.kernel.org, AJvYcCXFjGNDC+LXjNN/3MgNIhZxtKRDVwHhMPnQJY0juzCXfBIn/j6RJrq4NKA2IZj3AORZoXrQuWFiODuI6mBGGT6TIm0=@vger.kernel.org
X-Received: by 2002:a05:690c:6603:b0:652:5838:54ef with SMTP id
 00721157ae682-6eaddfd41ccmr221610017b3.37.1731517102600; Wed, 13 Nov 2024
 08:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728377971.git.geert+renesas@glider.be> <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
 <b273599f-8653-4e98-ac64-09c91b0a1592@arm.com> <CAMuHMdUYnTRDHRdWYHBdJ3hNBKOXBtRMOsu1NiJFET7P-+zc4g@mail.gmail.com>
 <96d1f356-b36b-4c14-bdd5-c38836bac418@arm.com> <CAMuHMdW25MC-RoCw72_EJ22e4Ae36N1CM8a-r=r7e=kA2-AgHA@mail.gmail.com>
In-Reply-To: <CAMuHMdW25MC-RoCw72_EJ22e4Ae36N1CM8a-r=r7e=kA2-AgHA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 17:58:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUoEA0W_1jmUPZ48Zi7N1wbo435-LvAf35O=EvYvO6KDQ@mail.gmail.com>
Message-ID: <CAMuHMdUoEA0W_1jmUPZ48Zi7N1wbo435-LvAf35O=EvYvO6KDQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Nov 4, 2024 at 4:15=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
> On Mon, Oct 28, 2024 at 2:41=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com>=
 wrote:
> > On 10/28/24 11:34, Geert Uytterhoeven wrote:
> > > On Fri, Oct 25, 2024 at 5:40=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.=
com> wrote:
> > >> On 10/22/24 14:36, Geert Uytterhoeven wrote:
> > >>> On Tue, Oct 8, 2024 at 11:14=E2=80=AFAM Geert Uytterhoeven
> > >>> <geert+renesas@glider.be> wrote:
> > >>>> When CONFIG_ENERGY_MODEL=3Dy, an error is printed on RZ/G2E and R-=
Car E3:
> > >>>>
> > >>>>       cpu cpu0: EM: invalid perf. state: -22
> > >>>>
> > >>>> This happens because the Operating Points Parameters tables do not=
 list
> > >>>> voltages, as they are all identical.  Previously, it was assumed t=
hey
> > >>>> were optional, and unused, when none of the CPU nodes is tied to a
> > >>>> regulator using the "cpu-supply" property.  This assumption turned=
 out
> > >>>> to be incorrect, causing the reported error message.
> > >>>>
> > >>>> This RFC patch series fixes this by adding the missing voltages.
> > >>>>
> > >>>> Note that the Energy Model calculates energy efficiency by dividin=
g the
> > >>>> (estimated) CPU power consumption by CPU core clock frequency.  Wh=
en all
> > >>>> voltages have the same value, the former is proportional to clock
> > >>>> frequency, and energy efficiency becomes a constant.  Hence all
> > >>>> operating points are considered to have the same efficiency, and t=
he
> > >>>> Energy Model always picks the one with the highest clock rate (see=
 also
> > >>>> [1]).
> > >>>>
> > >>>> Alternatively, the Energy Model could be changed to silently ignor=
e OPP
> > >>>> tables with missing frequencies.  IMHO this is not an unusual case=
.
> > >>>>
> > >>>> Which approach should be taken?
> > >>>> Thanks for your comments!
> > >>>
> > >>> Any comments from the Energy Model and PM people?
> > >>
> > >> My apologies for delay.
> > >>
> > >> So you had issue with bogus Voltage values and removed them.
> > >>
> > >> There is another way to setup EM properly, via DT:
> > >> "opp-microwatt" [1].
> > >>
> > >> That micro watt value won't confuse other subsystems, like
> > >> your regulator fwk. It will only be used by the EM fwk.
> > >>
> > >> This would be an alternative to your voltage values.
> > >> Sounds better to you?
> > >
> > > For opp-microwatt, I do need to know the actual power consumption
> > > of the core, right?
> >
> > Correct. You can try to derived that in a way you did and put below.
> > Although, Dhrystone is a synthetic micro-benchmark with small
> > impact to data caches, so it will not use much power.
>
> Do you have a suggestion for a better load test? stress-ng?
>
> > > Full system power consumption while running the in-kernel
> > > Dhrystones benchmark:
> > >
> > > 800 MHz: avg 4972,55 mW, stdef 20,474 mW
> > > 1000 MHz: avg 5025,93 mW, stdef 18,644 mW
> > > 1200 MHz: avg 5059,63 mW, stdef 15,425 mW
> >
> > Right. From those power values can be try to derive the
> > 'CPU only power' values - assuming only one core was
> > running the test.
> >
> > AFAIU you don't have proper DVFS due to missing voltage scaling.
>
> Indeed.
>
> > Therefore...
> > Out of that I got these CPU power values:
> > 800MHz -> 174mW
>
> =3D> 217.5 =C2=B5W/MHz
>
> > 1000MHz -> 212mW
>
> =3D> 212 =C2=B5W/MHz
>
> > 1200MHz -> 261mW

BTW, how did you get from my avg mW values above to your CPU power mW
values? I seem to be missing something...

>
> =3D> 217.5 =C2=B5W/MHz.
>
> So 1000 MHz seems to be the most power-efficient.
>
> > > The system also has test points across a 0.005 Ohm sense resistor in
> > > the DVFS power supply line, but no on-board measurement sensor (like
> > > the MAX9611 on Salvator-X(S)), so I haven't measured anything
> > > there yet.
>
> I'll try to do some measurements at these test points.

So I measured the voltage across the sense resistor, and used that to
calculate the actual power draw:
  A. Idle (1 or 2 CPU cores online doesn't seem to matter):
      -  765 mW @  800 MHz,
      -  786 mW @ 1000 MHz,
      -  807 mW @ 1200 MHz.
  B. Maximum seen during "stress-ng -c 10" with 1 CPU core online:
      -  993 mW @  800 MHz,
      - 1055 mW @ 1000 MHz,
      - 1096 mW @ 1200 MHz.
  C. Maximum seen during "stress-ng -c 10" with 2 CPU cores online:
      - 1179 mW @  800 MHz,
      - 1303 mW @ 1000 MHz,
      - 1386 mW @ 1200 MHz.

As expected, the A-C increase is about the double of the A-B increase,
due to the use of 2 CPU cores.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

