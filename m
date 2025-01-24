Return-Path: <linux-pm+bounces-20940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2784A1B509
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 12:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1485616CCB9
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C0E219E82;
	Fri, 24 Jan 2025 11:53:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016E4A1D;
	Fri, 24 Jan 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737719600; cv=none; b=ZlHlE+nA4E8IenqZIFecUnsTjPKY7rHy53Ys8QLse+tIVjFw6tpGxlqtuR3gU/9ngSml0yeZ9dXh9mQHiF0ECTorParXNsYFZz/zaqARjEszOfT3PrBD4NWjrobhhLCYP/32O81QEnqGqmAQG/cNHQVUDO7JGUDo5CIB08MbZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737719600; c=relaxed/simple;
	bh=nukl0AS0H3HcVJPLvvuFUjSXOWJ8ZHCgAEM1ia0cFWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLlVqdce1RX8ZdgDMHjCXQJ9Mq6tebL8ET4olLWdXxnxqIgcvK8PWiTayFJCASXVGpGTKlMHor/3lusRQt0hNADQV2j0XyWoc8IlGpA15w1zoYtU8PqorBHLzKdU6bdRc9QcP1X57IQ1J1OM1Hq2bADCIpg1iUb6b53jxGpKkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85c436db302so1027527241.0;
        Fri, 24 Jan 2025 03:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737719596; x=1738324396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqDzgxf1kvCyI/cu6hM536XE35QQW+U62tk2dF7KKTM=;
        b=EJ9odGkqQoWhkSOW51TGNKgNkg4sqza+0buW2WOd+3zdueGhWbhXn1ybqclazhzMWB
         MSzSFVveq+Ky/cHXN9DLU1T5ZEdhVE5E1afTqNR9FxGtl2Z9qIJbaaEfrNZSXkjVDPIG
         dp2i6uect2UocZWm2mXGQ+vk99y0fXT4jQBO8ihEG3+DvjCuAXRL9StAk2As7gLxQHVy
         Pai8VhLp81u7BnN6WHb+oVpoEncQggAibfdbogAMeof8Si8iJeI4bOM0ruBnz6sSmkRh
         UE+PM/h/XVnI0/1QztTNkuZrAjPeU6UAWGwgzFEPNLJ6iNLlNxk0mgJ8t2FNSChTk1Y2
         AK6A==
X-Forwarded-Encrypted: i=1; AJvYcCV7Bx9+xqf2Iga8xUPAnYBi5NQQqZ37o1P8xiHcEllz9cfFJ3grMJpzV2uo2tnY6m21IKcnXR65uf4=@vger.kernel.org, AJvYcCXJ+YJWm0T6D2gqMBB2Xk+iXDS82bDVcenO7SBgUeBP3OlEy7tm4eLlBGn06lY6Sjq6axBTASRQgjVf225Bj0vVMt0=@vger.kernel.org, AJvYcCXjuR/T6e/v56JRlc/9nTnqkVbtMWyXihA1z4tpiB0eqdBUkqLCoQ8KsXglvu1XBSXl0K5j19HA2X6W@vger.kernel.org
X-Gm-Message-State: AOJu0YyexskRtsWiQTJHuLnslbeaiq0FYsMGd9hR3bvUSqHqeRTgi/Bg
	lQV+Bnz4pnvw7kUflY3z+87WodDcqtAVB20eecu8oRcvWyVvJXZ9pFqM1F26
X-Gm-Gg: ASbGncucX+9Nnb+XOkj96jYoC8rKZPGOHfZvUBXDCj39rcATce6UIkpWROjELgXi+Bw
	NVGpOw5jzw/JzRnHXYQ47afcbz18zBGGhuVbh7i3mdEfhWnYCZxheaEFT6SXaP3rixiF4+4Knsf
	TUJSNi6iiKRlkn6xYVnPqU9qqWPcay013jcCbv4jTHGfXfJ7q/oeTpEuJOxMiMrFwOuVM+1KGeG
	g4in9eJeF59U9FWdbVOipDkwDSXZ0h/lYCVTvMzqJZfufJHb2r5nxZdR+1LS085XgRNr1tkEUGj
	E/QmlDz+u/A0kMecdSRBlfJ0v5zb9HRFZ8D3dI5CI2M=
X-Google-Smtp-Source: AGHT+IH6efQPim/4GXer4SJAkTTE3rxMTt6G/fvb6D44Gf1ydYJVFZs0PdOCi0+VM8qunIg0lvuR3A==
X-Received: by 2002:a05:6102:1085:b0:4af:f1c6:af04 with SMTP id ada2fe7eead31-4b709cd1cc4mr2254013137.8.1737719596354;
        Fri, 24 Jan 2025 03:53:16 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b709996756sm376536137.26.2025.01.24.03.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 03:53:16 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4aff04f17c7so1937273137.0;
        Fri, 24 Jan 2025 03:53:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpIr5TFvYWB9KH7H8j5pMavkYRY6z/1WOHN7TbWf/1CVeaGc4r10kuTI5lB/g5MtzvWAaNO0/2OFtpZJtD7tKevBw=@vger.kernel.org, AJvYcCUvJdX2vGkNxOOb2Ny81sQKzpI4Q3zJuoaN7eKI7uvsLupUYP9dCR6eqiy0LSmAEN7Hp53/2gxwvdQ=@vger.kernel.org, AJvYcCWzaKhDvfznjIi8TUqvOLyBKX1SbASLsSidD+xTwrb1HmtC/jIE9eZdhpsNzS79ECSP/NF4H0KUuDv7@vger.kernel.org
X-Received: by 2002:a67:e2ca:0:b0:4af:57df:8697 with SMTP id
 ada2fe7eead31-4b709d0b4f6mr2410290137.10.1737719595958; Fri, 24 Jan 2025
 03:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728377971.git.geert+renesas@glider.be> <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
 <b273599f-8653-4e98-ac64-09c91b0a1592@arm.com> <CAMuHMdUYnTRDHRdWYHBdJ3hNBKOXBtRMOsu1NiJFET7P-+zc4g@mail.gmail.com>
 <96d1f356-b36b-4c14-bdd5-c38836bac418@arm.com> <CAMuHMdW25MC-RoCw72_EJ22e4Ae36N1CM8a-r=r7e=kA2-AgHA@mail.gmail.com>
 <CAMuHMdUoEA0W_1jmUPZ48Zi7N1wbo435-LvAf35O=EvYvO6KDQ@mail.gmail.com> <CAMuHMdXUhqdSCvsDbqu0To8psuBuWpnZtqy+PRTcVqdFeQ2rYQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXUhqdSCvsDbqu0To8psuBuWpnZtqy+PRTcVqdFeQ2rYQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Jan 2025 12:53:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWXJuTg-B9tboCgWCjot3iWj-HdLLNot2kRL2bTc-8UBw@mail.gmail.com>
X-Gm-Features: AWEUYZn2aZ5H9gU6vNkj9rT5bd5uwgOy5qONQEwhzWJT4eBOQW7AUPGaRnyNv0w
Message-ID: <CAMuHMdWXJuTg-B9tboCgWCjot3iWj-HdLLNot2kRL2bTc-8UBw@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Dec 10, 2024 at 3:28=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, Nov 13, 2024 at 5:58=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Mon, Nov 4, 2024 at 4:15=E2=80=AFPM Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:
> > > On Mon, Oct 28, 2024 at 2:41=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.=
com> wrote:
> > > > On 10/28/24 11:34, Geert Uytterhoeven wrote:
> > > > > On Fri, Oct 25, 2024 at 5:40=E2=80=AFPM Lukasz Luba <lukasz.luba@=
arm.com> wrote:
> > > > >> On 10/22/24 14:36, Geert Uytterhoeven wrote:
> > > > >>> On Tue, Oct 8, 2024 at 11:14=E2=80=AFAM Geert Uytterhoeven
> > > > >>> <geert+renesas@glider.be> wrote:
> > > > >>>> When CONFIG_ENERGY_MODEL=3Dy, an error is printed on RZ/G2E an=
d R-Car E3:
> > > > >>>>
> > > > >>>>       cpu cpu0: EM: invalid perf. state: -22
> > > > >>>>
> > > > >>>> This happens because the Operating Points Parameters tables do=
 not list
> > > > >>>> voltages, as they are all identical.  Previously, it was assum=
ed they
> > > > >>>> were optional, and unused, when none of the CPU nodes is tied =
to a
> > > > >>>> regulator using the "cpu-supply" property.  This assumption tu=
rned out
> > > > >>>> to be incorrect, causing the reported error message.
> > > > >>>>
> > > > >>>> This RFC patch series fixes this by adding the missing voltage=
s.
> > > > >>>>
> > > > >>>> Note that the Energy Model calculates energy efficiency by div=
iding the
> > > > >>>> (estimated) CPU power consumption by CPU core clock frequency.=
  When all
> > > > >>>> voltages have the same value, the former is proportional to cl=
ock
> > > > >>>> frequency, and energy efficiency becomes a constant.  Hence al=
l
> > > > >>>> operating points are considered to have the same efficiency, a=
nd the
> > > > >>>> Energy Model always picks the one with the highest clock rate =
(see also
> > > > >>>> [1]).
> > > > >>>>
> > > > >>>> Alternatively, the Energy Model could be changed to silently i=
gnore OPP
> > > > >>>> tables with missing frequencies.  IMHO this is not an unusual =
case.
> > > > >>>>
> > > > >>>> Which approach should be taken?
> > > > >>>> Thanks for your comments!
> > > > >>>
> > > > >>> Any comments from the Energy Model and PM people?
> > > > >>
> > > > >> My apologies for delay.
> > > > >>
> > > > >> So you had issue with bogus Voltage values and removed them.
> > > > >>
> > > > >> There is another way to setup EM properly, via DT:
> > > > >> "opp-microwatt" [1].
> > > > >>
> > > > >> That micro watt value won't confuse other subsystems, like
> > > > >> your regulator fwk. It will only be used by the EM fwk.
> > > > >>
> > > > >> This would be an alternative to your voltage values.
> > > > >> Sounds better to you?
> > > > >
> > > > > For opp-microwatt, I do need to know the actual power consumption
> > > > > of the core, right?
> > > >
> > > > Correct. You can try to derived that in a way you did and put below=
.
> > > > Although, Dhrystone is a synthetic micro-benchmark with small
> > > > impact to data caches, so it will not use much power.
> > >
> > > Do you have a suggestion for a better load test? stress-ng?
> > >
> > > > > Full system power consumption while running the in-kernel
> > > > > Dhrystones benchmark:
> > > > >
> > > > > 800 MHz: avg 4972,55 mW, stdef 20,474 mW
> > > > > 1000 MHz: avg 5025,93 mW, stdef 18,644 mW
> > > > > 1200 MHz: avg 5059,63 mW, stdef 15,425 mW
> > > >
> > > > Right. From those power values can be try to derive the
> > > > 'CPU only power' values - assuming only one core was
> > > > running the test.
> > > >
> > > > AFAIU you don't have proper DVFS due to missing voltage scaling.
> > >
> > > Indeed.
> > >
> > > > Therefore...
> > > > Out of that I got these CPU power values:
> > > > 800MHz -> 174mW
> > >
> > > =3D> 217.5 =C2=B5W/MHz
> > >
> > > > 1000MHz -> 212mW
> > >
> > > =3D> 212 =C2=B5W/MHz
> > >
> > > > 1200MHz -> 261mW
> >
> > BTW, how did you get from my avg mW values above to your CPU power mW
> > values? I seem to be missing something...
>
> Ping...

Gentle ping.
Thanks!

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

