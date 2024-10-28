Return-Path: <linux-pm+bounces-16566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3F9B2EF9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7568B1F22F2F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0C71D5ACF;
	Mon, 28 Oct 2024 11:34:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B21D416E;
	Mon, 28 Oct 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115267; cv=none; b=qwzv8SLLpic8nvWNkHoUH6gCLXkp9JYRgvXiPsYReGfzNXPNzOMKbjUXQbBrA8/EAfoWEdq4+fzERMnG8GjF5dqdKMy/aBD0om6OLTPYm+Yc5SEdOGaEDrkqwOsEu02vuo8QMnGkT48bKUkBAzczVJ1tzY20rjiVs54KZmE75sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115267; c=relaxed/simple;
	bh=KrH6+eJQySVsEhrWkWFPrMNDivVyXqOIftdLXt1wFAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awIIolqadUqn2RGuVvEIA9KBAW2rde2jFF/5hpcyjE1xsBxLoPQH7KdFiTpid5d9KQZLa2xiqQPjwzej/gKsIVSHQOCuygRh6yEJ/BIXlLlzwukUI2vkmmsdqVHtK5+SfRmuLQrK+W09l4wS/7mv3tgYymmF9TQPIoplmqlAOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e9f69cc576so7492757b3.0;
        Mon, 28 Oct 2024 04:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115262; x=1730720062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69mkGzGWZ4HjcxbU9YnVxGfvuhB+rVcGc1RChpmV04w=;
        b=IG5DTCov6igFWZ208MGlbjjG2+/H400sMuIhaqKk4YC0eURkXM9d5XDvbDWHcjemha
         pDr/W+MpztYszKyBoJSBrn625LOH06VYgBzOtjXWxUAPtXjuF6FLyePcrwcEvdOBG9Sp
         f1T5D1CSpyl5k7cbQlqmHrPCPIKfq6emr18F9avYQzavYGJdkm0jtjjWniqI+yXaMWd2
         5zki0f0kpREPP52jmBglIbc4DE/mjKKeVeicaGF8rjqZXqQ55Y7Ii8b00h+l4q8VOIIO
         H9r7K1L+jegwRDdm0i2qk+Ri9t4/YnHFIZKAjeUQbnzyTZDz3igqiPDGIHyxQyYtEYie
         8byQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT6IBUv/awjmwCaTj4L8+vk3L+BA+xlEoK0V5NkT2rCO6diUPlePu0pEvSXeGIbXtsWOkwzqhc8lZj6wEKh2AGiuE=@vger.kernel.org, AJvYcCWtkWUxebb+8Kx/7Bsi72tsWLzq/zo6F73vbWmWoKmVXc9IH5uO88eA6IbLh/EziGeUOySn2jL7lvA=@vger.kernel.org, AJvYcCXbQOKiTNAcnPI7BrlTueF4PvbMFe0YyoT4b3sWCdT7TullN5StQ08Qa/jbtdzBQWOpkreTvTL7YvxD@vger.kernel.org
X-Gm-Message-State: AOJu0YxabY9W9ISxZblvd9NXymew6G6pvK0AIKxaMmCO3mQiHZwMxP2W
	wiE2WI90ao2Pt8adXh3H/hVCf8GbKdnD2lrMNMxcL2Gj50tiEjRvihHIhtK5
X-Google-Smtp-Source: AGHT+IEbhblhQj7oheoKut8SttryfCh9TQx6Sk4rdw5ZGkSSnWTznjtJYFS5VIo0gWtYaElawM8Y2Q==
X-Received: by 2002:a05:690c:6209:b0:6de:b23:f2a1 with SMTP id 00721157ae682-6e9d89b9719mr71664187b3.15.1730115262492;
        Mon, 28 Oct 2024 04:34:22 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c7ac1bsm13505017b3.102.2024.10.28.04.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:34:22 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e35f08e23eso37582157b3.2;
        Mon, 28 Oct 2024 04:34:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQjA5EzJxrFwIhdpRnXjrWLCtih9yM9SxS2fHrM4FJfe/33bxBMSFwetntyZU87w4CgncIAWL5tVhCCH6iDg/syuA=@vger.kernel.org, AJvYcCW+GjDvWTSna/z5aLElbS25r8DL1CitAgjgFLV+Rbr+ZGyKu+8t0giZANSbouAYO4T4l4mSPuzLsMI=@vger.kernel.org, AJvYcCXJBxslq8GbWykTkN8QG6TSF2ldBcM5dMe61wEGkYrwXtKK2+1cqeH2xV1f/P3DX4E8H3ePUasFcGh+@vger.kernel.org
X-Received: by 2002:a05:690c:660a:b0:6e7:e009:183e with SMTP id
 00721157ae682-6e9d8961fffmr65940387b3.8.1730115261774; Mon, 28 Oct 2024
 04:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728377971.git.geert+renesas@glider.be> <CAMuHMdXsmAqQL+2+D_y+u1z4nn8JO+xF-mq6wWJ0pAH58n5Wiw@mail.gmail.com>
 <b273599f-8653-4e98-ac64-09c91b0a1592@arm.com>
In-Reply-To: <b273599f-8653-4e98-ac64-09c91b0a1592@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Oct 2024 12:34:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUYnTRDHRdWYHBdJ3hNBKOXBtRMOsu1NiJFET7P-+zc4g@mail.gmail.com>
Message-ID: <CAMuHMdUYnTRDHRdWYHBdJ3hNBKOXBtRMOsu1NiJFET7P-+zc4g@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Fri, Oct 25, 2024 at 5:40=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
> On 10/22/24 14:36, Geert Uytterhoeven wrote:
> > On Tue, Oct 8, 2024 at 11:14=E2=80=AFAM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> >> When CONFIG_ENERGY_MODEL=3Dy, an error is printed on RZ/G2E and R-Car =
E3:
> >>
> >>      cpu cpu0: EM: invalid perf. state: -22
> >>
> >> This happens because the Operating Points Parameters tables do not lis=
t
> >> voltages, as they are all identical.  Previously, it was assumed they
> >> were optional, and unused, when none of the CPU nodes is tied to a
> >> regulator using the "cpu-supply" property.  This assumption turned out
> >> to be incorrect, causing the reported error message.
> >>
> >> This RFC patch series fixes this by adding the missing voltages.
> >>
> >> Note that the Energy Model calculates energy efficiency by dividing th=
e
> >> (estimated) CPU power consumption by CPU core clock frequency.  When a=
ll
> >> voltages have the same value, the former is proportional to clock
> >> frequency, and energy efficiency becomes a constant.  Hence all
> >> operating points are considered to have the same efficiency, and the
> >> Energy Model always picks the one with the highest clock rate (see als=
o
> >> [1]).
> >>
> >> Alternatively, the Energy Model could be changed to silently ignore OP=
P
> >> tables with missing frequencies.  IMHO this is not an unusual case.
> >>
> >> Which approach should be taken?
> >> Thanks for your comments!
> >
> > Any comments from the Energy Model and PM people?
>
> My apologies for delay.
>
> So you had issue with bogus Voltage values and removed them.
>
> There is another way to setup EM properly, via DT:
> "opp-microwatt" [1].
>
> That micro watt value won't confuse other subsystems, like
> your regulator fwk. It will only be used by the EM fwk.
>
> This would be an alternative to your voltage values.
> Sounds better to you?

For opp-microwatt, I do need to know the actual power consumption
of the core, right?

Full system power consumption while running the in-kernel
Dhrystones benchmark:

800 MHz: avg 4972,55 mW, stdef 20,474 mW
1000 MHz: avg 5025,93 mW, stdef 18,644 mW
1200 MHz: avg 5059,63 mW, stdef 15,425 mW

The system also has test points across a 0.005 Ohm sense resistor in
the DVFS power supply line, but no on-board measurement sensor (like
the MAX9611 on Salvator-X(S)), so I haven't measured anything
there yet.

> Do you know from /sys/kernel/debug/energy_model/
> the current power values?

With this series applied:

root@ebisu:~# grep -r . /sys/kernel/debug/energy_model/
/sys/kernel/debug/energy_model/cpu0/ps:1200000/inefficient:0
/sys/kernel/debug/energy_model/cpu0/ps:1200000/performance:1024
/sys/kernel/debug/energy_model/cpu0/ps:1200000/cost:3443
/sys/kernel/debug/energy_model/cpu0/ps:1200000/power:352643
/sys/kernel/debug/energy_model/cpu0/ps:1200000/frequency:1200000
/sys/kernel/debug/energy_model/cpu0/ps:1000000/inefficient:1
/sys/kernel/debug/energy_model/cpu0/ps:1000000/performance:853
/sys/kernel/debug/energy_model/cpu0/ps:1000000/cost:3445
/sys/kernel/debug/energy_model/cpu0/ps:1000000/power:293869
/sys/kernel/debug/energy_model/cpu0/ps:1000000/frequency:1000000
/sys/kernel/debug/energy_model/cpu0/ps:800000/inefficient:1
/sys/kernel/debug/energy_model/cpu0/ps:800000/performance:682
/sys/kernel/debug/energy_model/cpu0/ps:800000/cost:3447
/sys/kernel/debug/energy_model/cpu0/ps:800000/power:235095
/sys/kernel/debug/energy_model/cpu0/ps:800000/frequency:800000
/sys/kernel/debug/energy_model/cpu0/flags:0x3
/sys/kernel/debug/energy_model/cpu0/cpus:0-1

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

