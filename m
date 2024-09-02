Return-Path: <linux-pm+bounces-13359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 687BD968A33
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D991F21A6D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C41A2644;
	Mon,  2 Sep 2024 14:43:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E31A263E;
	Mon,  2 Sep 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288197; cv=none; b=MlIzI3pIHVe14nEwrw7RmhmeUj4CNLIy2wMF7tz+xRDHnW+1G8tkIurRZdUW1uXC76jJGuwk3bMaAd727wadJAomO30VaEYdPehXAD0jIWXqmbHicecY/kNNrwHzfTD9poHPAgDKrxkCWMQIBt4hgEfUUbGedMKxEUlzMwh3PVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288197; c=relaxed/simple;
	bh=1QsvRZPsbUtInZWprJeCMReKLKwUDzy1CVFK+e51Ehw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daa63iTcVywbdTxzFeyiDrlyMnIpd3pJLz99uNXbzzSGYav7IcWVTTro6Cp+PnaweOjVhnPipBioWIpWn8Zno4iNKMGq7oLVu7OjvrVcd22bdJHHQJt9ecYmqBo61+eXMd8SD7DAU9FJ8BwiU84FdbKsNjjwBqnbAM+xOeXRabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690aabe2600so35055387b3.0;
        Mon, 02 Sep 2024 07:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725288193; x=1725892993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dv4mKq/aci7xE5SWjH3tcrLRVVBdtWwRIP4tHhTb83s=;
        b=MSoxpQMDtByPWiXRIfllVn1MbOKnCl6AbPYap9UuqGgZ+kX9vUBq2JFPnaALtlKvJq
         WcHLdLqN97e5/yDZtxd5etCUQdYz6dbleUpQw8B6RcwwGGqtI6dx+aTalxJRNO4m8A2S
         JWp/aIXdIrpvZyiVLlDkdPeUCKyWp89+hnWZI2Y2apD0Y0toYEb69dS9XRgJB38BOk62
         E4gdPH1PFVIHJsYt10/RwrCQ3bGXPcF7atQN/GlPvpqG3rld7DZDF7gcExrsf5FDU5vQ
         j6+9hi8ny0xXiDhE0ib3vs6GWRnnkalNMBAP9IOQ4cZKhoiaD9EQag3V4SpqIbvkfj9u
         Z4yg==
X-Forwarded-Encrypted: i=1; AJvYcCUvs6F1l8X/Q7xmokoY4W5dniE8ARrDpnbbjmktlKi4ISrkOWNwKQxvcmjOkZJb4ZN0aLNkrRZFKF0d6ZQ=@vger.kernel.org, AJvYcCV/vIEiwKGayFxga6WHS/hBcIHvLLWB15KFQBJdN+gAIIloA4OhYas7GjTCUZzPvhKONOhcUHSs8/251k6Rjhs=@vger.kernel.org, AJvYcCXCIHAJ92s7VXZko/crhnax2tLS8hSthuOKtAqY9ZfgEL1oMtx1fXaZKDndvcTkWVEDAhpg6G6zaF8=@vger.kernel.org, AJvYcCXuJAdCezQYvBWI4Jm2QrvR6Mv719wPLA9NAtt8IXlUkgFFFDVwcxBsqCL241YyLUK4+Hi1/c6NcAN36g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvatIyThrxGGnxB99rTK4Wb3N+n3TZuWQPqxltFbNwieckpPA
	dYmhobYjT/7aXLQV6r9G8xg7HcC0enrYR5YXMz2jOH7BMpNKLX1VKNTpaoCK
X-Google-Smtp-Source: AGHT+IHE7KMq2vuwYqHIzsubXSUphR2zdCVZm0cwpCl19BOSXbZ7mfcj6+OkqFaQlK6/BdPWmlBK8w==
X-Received: by 2002:a05:690c:428c:b0:63b:df6e:3f6d with SMTP id 00721157ae682-6d411193e4fmr96372977b3.37.1725288193139;
        Mon, 02 Sep 2024 07:43:13 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d3abf883sm16086877b3.13.2024.09.02.07.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:43:11 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so2779063276.3;
        Mon, 02 Sep 2024 07:43:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3se31yG47oOPqxlhR/ucK8Y+UUt0V1jfH1Wwrdp5WnILffyg4EkCkhbzaBX5S5S+kfITwY0HewEN2bQ==@vger.kernel.org, AJvYcCUcK6JchS0/g7TIOiz0zhGRCan8qEF3d4pKrcPJsicUlgj870Z5scfqnuRwvFpmO+f/4PCrHH5eZkAYVYU=@vger.kernel.org, AJvYcCWMEQ/++mtJpyR848Axg1T2b2GfvqLgiqyWYIXTH6KCXBXorOIhJtinEG5DTxk1BvETIicJBbt1mdY=@vger.kernel.org, AJvYcCWVyPniYFu9tKsgz6gTZInxpJZRnHqaoLe4KEnvjbqG25bNpfGYZIsPI+P4QvuJIykg8Fjlqtfsu+f9nIIKkzE=@vger.kernel.org
X-Received: by 2002:a05:690c:64c8:b0:6d5:1b7:ab81 with SMTP id
 00721157ae682-6d501b7af55mr99049107b3.22.1725288190742; Mon, 02 Sep 2024
 07:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-4-ulf.hansson@linaro.org> <CAMuHMdUoZBJewA6nQZLhnbebZuoZo85UCCfwuOv8or_N_e-0qg@mail.gmail.com>
 <CAPDyKFqcpxUJWL7FoRSXLXVhS5B9PjcTY5ryG8HAY_E1Btgwag@mail.gmail.com> <CAMuHMdWB2zjF1jajkQzFpt2=4oj25myG1CJ5i6450gkUVX19+g@mail.gmail.com>
In-Reply-To: <CAMuHMdWB2zjF1jajkQzFpt2=4oj25myG1CJ5i6450gkUVX19+g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Sep 2024 16:42:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXM2qHGzcLDfZQNC1Zqj_vh72S9+rV6-xuM+p=w7-oHyQ@mail.gmail.com>
Message-ID: <CAMuHMdXM2qHGzcLDfZQNC1Zqj_vh72S9+rV6-xuM+p=w7-oHyQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] pmdomain: core: Use dev_name() instead of
 kobject_get_path() in debugfs
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Fri, Aug 30, 2024 at 5:50=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Aug 20, 2024 at 10:58=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > On Tue, 20 Aug 2024 at 10:55, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > > On Mon, May 27, 2024 at 4:27=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > > Using kobject_get_path() means a dynamic memory allocation gets don=
e, which
> > > > doesn't work on a PREEMPT_RT based configuration while holding genp=
d's raw
> > > > spinlock.
> > > >
> > > > To fix the problem, let's convert into using the simpler dev_name()=
. This
> > > > means the information about the path doesn't get presented in debug=
fs, but
> > > > hopefully this shouldn't be an issue.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > > Changes in v2:
> > > >         - New patch.
> > >
> > > Thanks for your patch, which is now commit 9094e53ff5c86ebe ("pmdomai=
n:
> > > core: Use dev_name() instead of kobject_get_path() in debugfs")
> > > in pmdomain/next.
> > >
> > > > --- a/drivers/pmdomain/core.c
> > > > +++ b/drivers/pmdomain/core.c
> > > > @@ -3215,16 +3214,9 @@ static int genpd_summary_one(struct seq_file=
 *s,
> > > >         }
> > > >
> > > >         list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
> > > > -               kobj_path =3D kobject_get_path(&pm_data->dev->kobj,
> > > > -                               genpd_is_irq_safe(genpd) ?
> > > > -                               GFP_ATOMIC : GFP_KERNEL);
> > > > -               if (kobj_path =3D=3D NULL)
> > > > -                       continue;
> > > > -
> > > > -               seq_printf(s, "\n    %-50s  ", kobj_path);
> > > > +               seq_printf(s, "\n    %-50s  ", dev_name(pm_data->de=
v));
> > >
> > > While some of the old names didn't even fit in 50 characters, the new
> > > names need much less space, so perhaps this is a good opportunity to
> > > decrease the table width?
> >
> > Sure, it seems reasonable! Do you want to send a patch?
>
> I started looking into it.  Then I noticed that on some systems
> (e.g. TI am335x) the device names may have a longer format than
> the typical <unit-address>.<nodename>. So I wanted to verify on
> BeagleBone Black, but recent kernels crash during early boot.
> Apparently that platform was broken between v6.8 and v6.9-rc1.
> And during bisection, I encountered 3 different failure modes...
>
> To be continued...

The longest generic node names documented in the Devicetree
Specification are "air-pollution-sensor" and "interrupt-controller"
(both counting 20 characters), so a typical device name needs 8
(32-bit unit address) + 1 (dot) + 20 =3D 29 characters.
However, I assume some devices lie outside the 32-bit address space,
and thus need more space?

With the BeagleBone Black boot issue fixed:
"/devices/platform/ocp/5600fe00.target-module"
resp. "/devices/platform/ocp/44c00000.interconnect/44c00000.interconnect:se=
gment@200000/44e3e074.target-module"
are now shortened to "5600fe00.target-module" resp. "44e3e074.target-module=
".
However, "/devices/platform/ocp/48000000.interconnect/48000000.interconnect=
:segment@200000/48000000.interconnect:segment@200000:target-module@0"
is shortened to "48000000.interconnect:segment@200000:target-module@0",
which is still longer than the old column width...

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

