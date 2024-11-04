Return-Path: <linux-pm+bounces-16966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293B9BB8B9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 16:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC901F23510
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F8A1BD027;
	Mon,  4 Nov 2024 15:15:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C841607AB;
	Mon,  4 Nov 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733323; cv=none; b=WYEK2u4x2ZvOo//I7yTea68x8uuTPG2XEHC9vpBa4NDyTUOBwjRasoljPe/sY4EeXOvSrFvj8bfKk6SfKC0dsgyU5SenCrWD8VraKsMceN5nFkiaMgKKC+yd2n9/091FJO40dz9qpfm2mqjMZxMLKmDU0H7e46Bya0Avpt9AWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733323; c=relaxed/simple;
	bh=7MDgdNcgeM0JW++D9IN9F54sKWG6uhg/1ucBF0jsyZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAxPxK2wwdKA94mROl/yRKvwGSlV2Dgd4/l8RKu2dO9IZnWMedBGkVRdEmIulqo9+WuKLATl+zLjJQCUdBcKp9Vpim1K0/HN8FFAD84NR2KZuZMIRsyUhe/DAVZy2Qc+2tLilBZqrW5uori0da/iFKdRD+DacNKnRma9UGZd9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2974743675so3590336276.1;
        Mon, 04 Nov 2024 07:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733316; x=1731338116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjUBGXA+dTgYIQmg8Ha4hBZ5iFdRXgWCy64IbL+d1MA=;
        b=ZMwO7IaitCYthCESSxr7AwAPGQ65pCOQ1AhPyZ5ezTBIvlUpSu4r8o2zcCZXdXI7vp
         zltRrYoKODUa9FDNQI+7bZIF2DFYxlosb/iqxa0GW+ZyRxu6vczRGnfjG/7a0PWzo/qU
         NdKZNfWMB+eUT8A4/iRhNpuAPLsXtc2BNvyJ96J92vkFC7/BsK9gIlbhmafZthRyc7/J
         sHDi4SPBykPgp3CcGBmABzBo6RRaoxRC1pfv27xt73q8D02WKSysjH41jfDPoVuiQfcR
         KyFeq1LbZ/lb4Nj0z7tXwV+wCXd+Wzk3GjNDhXcIIVNHj05ZBQRsBsOejfPnXERYsjLv
         WcMw==
X-Forwarded-Encrypted: i=1; AJvYcCUKeoJqQ4pCd73JdLUbGyFp29nTMg8fwpEqKND9fxBHBY1JBL+RHT3SgjxwdlCPGsnnii3i0ytHPRHP@vger.kernel.org, AJvYcCUxQJXAfkxI88z/+ZorPPddOTIx6MZCBKABHPFxRGx5gwWHLG74yGLphOLVkY79mairW2O2jN4y7aLgwJQkFRON7M8=@vger.kernel.org, AJvYcCVt1AnnoktMS3G6XhxGTWAC6TitxkxFkeyn5ku0kUsQSnEdI289SzhpPL/tsSkGZUFrQBX4856syPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdtuq8x4EZdFGiPmCnI3KR2ZHwY+3lMWRat+sIXYnBMSgRGzV
	w2EHifMoC6bxoZ05QRFrxCc6ixTlaw2mTGmbLcNbIojmmc2flkEng9hQBt3P
X-Google-Smtp-Source: AGHT+IE9xqZfvmks6ZpsVYt+gZIXFsimr6euXdmoF6blTkWwKxNeELn/xCannjlEO93D3rki1WsOZQ==
X-Received: by 2002:a05:6902:2b10:b0:e33:16fe:ddd0 with SMTP id 3f1490d57ef6-e3316fede72mr5734671276.47.1730733316244;
        Mon, 04 Nov 2024 07:15:16 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a63368sm1966048276.4.2024.11.04.07.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:15:15 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea15a72087so33626197b3.1;
        Mon, 04 Nov 2024 07:15:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHQFa+M6uz/FZbTBf1GOkHlu/CnLATMkmn/65MNRUd6wo0VVI5vy9b0oWTQGFDbCprt0viN35ATxo1@vger.kernel.org, AJvYcCVfoc3zWsWhG6oXzJ5h6fK7Wyl4S1/p653SFdod6DKk6pi+Bo3tkINAik4GGDPyPHUND/S5yeosfmM=@vger.kernel.org, AJvYcCXIsNWyZjHJDxRM4tAYCzAIMREGsdKIy8Uvb8RtS/Hgc8G9qD8DdC8LleV1Pdo9XEOWmgws5hQxcTMLwnuwr5uD5ZY=@vger.kernel.org
X-Received: by 2002:a05:690c:6910:b0:6e2:1090:af31 with SMTP id
 00721157ae682-6ea52323524mr154829247b3.3.1730733315562; Mon, 04 Nov 2024
 07:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728377971.git.geert+renesas@glider.be> <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
 <b273599f-8653-4e98-ac64-09c91b0a1592@arm.com> <CAMuHMdUYnTRDHRdWYHBdJ3hNBKOXBtRMOsu1NiJFET7P-+zc4g@mail.gmail.com>
 <96d1f356-b36b-4c14-bdd5-c38836bac418@arm.com>
In-Reply-To: <96d1f356-b36b-4c14-bdd5-c38836bac418@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Nov 2024 16:15:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW25MC-RoCw72_EJ22e4Ae36N1CM8a-r=r7e=kA2-AgHA@mail.gmail.com>
Message-ID: <CAMuHMdW25MC-RoCw72_EJ22e4Ae36N1CM8a-r=r7e=kA2-AgHA@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Oct 28, 2024 at 2:41=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
> On 10/28/24 11:34, Geert Uytterhoeven wrote:
> > On Fri, Oct 25, 2024 at 5:40=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >> On 10/22/24 14:36, Geert Uytterhoeven wrote:
> >>> On Tue, Oct 8, 2024 at 11:14=E2=80=AFAM Geert Uytterhoeven
> >>> <geert+renesas@glider.be> wrote:
> >>>> When CONFIG_ENERGY_MODEL=3Dy, an error is printed on RZ/G2E and R-Ca=
r E3:
> >>>>
> >>>>       cpu cpu0: EM: invalid perf. state: -22
> >>>>
> >>>> This happens because the Operating Points Parameters tables do not l=
ist
> >>>> voltages, as they are all identical.  Previously, it was assumed the=
y
> >>>> were optional, and unused, when none of the CPU nodes is tied to a
> >>>> regulator using the "cpu-supply" property.  This assumption turned o=
ut
> >>>> to be incorrect, causing the reported error message.
> >>>>
> >>>> This RFC patch series fixes this by adding the missing voltages.
> >>>>
> >>>> Note that the Energy Model calculates energy efficiency by dividing =
the
> >>>> (estimated) CPU power consumption by CPU core clock frequency.  When=
 all
> >>>> voltages have the same value, the former is proportional to clock
> >>>> frequency, and energy efficiency becomes a constant.  Hence all
> >>>> operating points are considered to have the same efficiency, and the
> >>>> Energy Model always picks the one with the highest clock rate (see a=
lso
> >>>> [1]).
> >>>>
> >>>> Alternatively, the Energy Model could be changed to silently ignore =
OPP
> >>>> tables with missing frequencies.  IMHO this is not an unusual case.
> >>>>
> >>>> Which approach should be taken?
> >>>> Thanks for your comments!
> >>>
> >>> Any comments from the Energy Model and PM people?
> >>
> >> My apologies for delay.
> >>
> >> So you had issue with bogus Voltage values and removed them.
> >>
> >> There is another way to setup EM properly, via DT:
> >> "opp-microwatt" [1].
> >>
> >> That micro watt value won't confuse other subsystems, like
> >> your regulator fwk. It will only be used by the EM fwk.
> >>
> >> This would be an alternative to your voltage values.
> >> Sounds better to you?
> >
> > For opp-microwatt, I do need to know the actual power consumption
> > of the core, right?
>
> Correct. You can try to derived that in a way you did and put below.
> Although, Dhrystone is a synthetic micro-benchmark with small
> impact to data caches, so it will not use much power.

Do you have a suggestion for a better load test? stress-ng?

> > Full system power consumption while running the in-kernel
> > Dhrystones benchmark:
> >
> > 800 MHz: avg 4972,55 mW, stdef 20,474 mW
> > 1000 MHz: avg 5025,93 mW, stdef 18,644 mW
> > 1200 MHz: avg 5059,63 mW, stdef 15,425 mW
>
> Right. From those power values can be try to derive the
> 'CPU only power' values - assuming only one core was
> running the test.
>
> AFAIU you don't have proper DVFS due to missing voltage scaling.

Indeed.

> Therefore...
> Out of that I got these CPU power values:
> 800MHz -> 174mW

=3D> 217.5 =C2=B5W/MHz

> 1000MHz -> 212mW

=3D> 212 =C2=B5W/MHz

> 1200MHz -> 261mW

=3D> 217.5 =C2=B5W/MHz.

So 1000 MHz seems to be the most power-efficient.

> > The system also has test points across a 0.005 Ohm sense resistor in
> > the DVFS power supply line, but no on-board measurement sensor (like
> > the MAX9611 on Salvator-X(S)), so I haven't measured anything
> > there yet.

I'll try to do some measurements at these test points.

> >> Do you know from /sys/kernel/debug/energy_model/
> >> the current power values?
> >
> > With this series applied:
> >
> > root@ebisu:~# grep -r . /sys/kernel/debug/energy_model/
> > /sys/kernel/debug/energy_model/cpu0/ps:1200000/inefficient:0
> > /sys/kernel/debug/energy_model/cpu0/ps:1200000/performance:1024
> > /sys/kernel/debug/energy_model/cpu0/ps:1200000/cost:3443
> > /sys/kernel/debug/energy_model/cpu0/ps:1200000/power:352643
> > /sys/kernel/debug/energy_model/cpu0/ps:1200000/frequency:1200000
> > /sys/kernel/debug/energy_model/cpu0/ps:1000000/inefficient:1
> > /sys/kernel/debug/energy_model/cpu0/ps:1000000/performance:853
> > /sys/kernel/debug/energy_model/cpu0/ps:1000000/cost:3445
> > /sys/kernel/debug/energy_model/cpu0/ps:1000000/power:293869
> > /sys/kernel/debug/energy_model/cpu0/ps:1000000/frequency:1000000
> > /sys/kernel/debug/energy_model/cpu0/ps:800000/inefficient:1
> > /sys/kernel/debug/energy_model/cpu0/ps:800000/performance:682
> > /sys/kernel/debug/energy_model/cpu0/ps:800000/cost:3447
> > /sys/kernel/debug/energy_model/cpu0/ps:800000/power:235095
> > /sys/kernel/debug/energy_model/cpu0/ps:800000/frequency:800000
> > /sys/kernel/debug/energy_model/cpu0/flags:0x3
> > /sys/kernel/debug/energy_model/cpu0/cpus:0-1
>
> Those power values listed above look a bit higher, but they
> could be more related to a benchmark which utilized caches
> and more parts of the CPU. I don't know if you had chance to
> see some of my presentations on Linux conferences, where
> I show how much power can vary in different scenarios at
> the same frequency...

Thanks, I will have a look...

> TLDR; it can be even 1.8x comparing to Dhrystone.
>
> So would say it's OK for you to put either your Dhrystone
> power results, or these one from EM dump (probably from
> some more heavy benchmark then set into DT coefficient
> to derive them in OPP fwk).

Given the figures above (212 =C2=B5W/MHz vs. 217.5 =C2=B5W/MHz) using rathe=
r
coarse measurements are already close or identical, they might end up
being identical, and then we're back at square zero, where EM cannot
do anything?

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

