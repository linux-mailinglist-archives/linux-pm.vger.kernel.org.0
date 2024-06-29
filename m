Return-Path: <linux-pm+bounces-10242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A7991CD8C
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 16:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21361C2177B
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F882485;
	Sat, 29 Jun 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMHV45bI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E381ACA;
	Sat, 29 Jun 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719670505; cv=none; b=tLKrSkQDkgcECT8GY9e9UDpq12uOT+OtQ5+vLnJeCmYQKlQEjD7iCvnIW17VYHAIBvPrwoiegII91eLMLjvmw5nSELJ8xwMqnz1+wAYq7V/OgyvId4fqTOYtyWEsdE2zsdGV0UYNSYwELXMT3UQrFO7h4RNqMLhhbzxAmIHLAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719670505; c=relaxed/simple;
	bh=epYT1KYOeo+9DEO2Wh7JSvWwbz4Khg6kGVFeFfeg8EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEqe+FbP9kytMWj6NXb9jA1DPFejX+lPibfpmufx1IxDK+kPPsQUsW5jpYyaQyTEJAsQrl5fcmz1O4UohqDPvXTk7J519rU/q+pT2nESUj2XPXT/XsuzLpk7VYvjtSUAgZo/Y8c4mWRp/DumuaYfQWF/JmljpE8L/HKIkr7+a6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMHV45bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8CDC2BBFC;
	Sat, 29 Jun 2024 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719670504;
	bh=epYT1KYOeo+9DEO2Wh7JSvWwbz4Khg6kGVFeFfeg8EI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZMHV45bIvaT6PCEzqYTlew+I6EPD6m7N2oZvqIonAdiOZIBJaVuyn7o4eyAd4Ld96
	 iF5dgIRWwqxl087Ekdo3DOFGBMdq69cGm5cSTy0vegXL67H6wcBihqx8IrWI+1gVjU
	 56l6tBv3+e0cBd2Q9a+q/QXWqduU5OzZl409VhHAK1GlshJBTJb4nh5qrhkYfj3ADv
	 uVqbJdFAXIbmw5By2GCaNB6ZKzBtizPiP606espuLE0CFrPv5/Qoj+rmZzlj7Dv3gh
	 A9BoIs+WZ6eIcxim67eVbc9OGVEeETY/SVBQEPqUBni0inNsMT3sOg1zTYitXQ8rc9
	 UQCM+4zvwRFZA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a70c0349b64so199480066b.1;
        Sat, 29 Jun 2024 07:15:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfWKEAIGONmK1FTsYBggnAOstz0RfGbo16W8gsxbBR2qQj/5d8kgpxcn3Ajc4dmlN5Pv5zCP7wLCjMXisqSL5lsrALs3dX9bva0lJrMMxPEAGQLWl7CLF2ZbrH1sT8q13lR4z6OPQ=
X-Gm-Message-State: AOJu0YxDXnLs44WQLOvPdBhiWcju8g+pfL654BL8Gh5D1+R3B20iPbTY
	5vIiK+raFKHiFYrwH7c6malLn8sdMPL5Tg037fu48/ngmDwFDhuJnVul+btFrgvndfKpJS/iQHs
	mK5GaGcffthK3FDubLKHaE3TYkEM=
X-Google-Smtp-Source: AGHT+IHrEAX6O1hqTSCfHbjN4hul8PEEH9sq2Meu/MgSeLUOyXmmkKo2S18VAc453oGHk01kg0hXfrgh6GC/wBIZ7Z8=
X-Received: by 2002:a17:906:ca5b:b0:a72:52f0:900a with SMTP id
 a640c23a62f3a-a751441da57mr79003266b.19.1719670503228; Sat, 29 Jun 2024
 07:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612064205.2041548-1-chenhuacai@loongson.cn>
 <20240612064205.2041548-3-chenhuacai@loongson.cn> <20240625075645.m372bpbe7m2dozil@vireshk-i7>
 <CAAhV-H5wSzhD373L61Mxvu-7ZUSGh9LmC4yBoaHm_5rAxsu-5w@mail.gmail.com> <20240626043441.tsmvhzw4mmf6xjzj@vireshk-i7>
In-Reply-To: <20240626043441.tsmvhzw4mmf6xjzj@vireshk-i7>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 29 Jun 2024 22:14:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4jwxxg9uzy3rFEunj6_fnSmRSqkAv8JQT1uMgWNN=2fA@mail.gmail.com>
Message-ID: <CAAhV-H4jwxxg9uzy3rFEunj6_fnSmRSqkAv8JQT1uMgWNN=2fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:34=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 26-06-24, 11:51, Huacai Chen wrote:
> > On Tue, Jun 25, 2024 at 3:56=E2=80=AFPM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> > > On 12-06-24, 14:42, Huacai Chen wrote:
> > > > +struct loongson3_freq_data {
> > > > +     unsigned int cur_cpu_freq;
> > >
> > > You never use it. Remove it.
> > Emm, it is used in loongson3_cpufreq_get().
>
> Yeah, you are just filling it there and reading immediately after
> that, which can be done directly too. But you don't use it anywhere
> else.
OK, I will remove this field.

>
> > > > +static int loongson3_cpufreq_target(struct cpufreq_policy *policy,=
 unsigned int index)
> > > > +{
> > > > +     unsigned int cpu =3D policy->cpu;
> > > > +     unsigned int package =3D cpu_data[cpu].package;
> > > > +
> > > > +     if (!cpu_online(cpu))
> > > > +             return -ENODEV;
> > > > +
> > > > +     /* setting the cpu frequency */
> > > > +     mutex_lock(&cpufreq_mutex[package]);
> > >
> > > No locking required here. Core doesn't call them in parallel.
>
> s/Core/CPUFreq core/
>
> > I'm a bit confused, I think different cores may call .target() in
> > parallel.
>
> Not for same policy, but for different yes.
>
> > Cores in the same package share the same
> > LOONGARCH_IOCSR_SMCMBX register, so I think the lock is required.
>
> If that is the access you are protecting, then you better move the
> lock to do_service_request() instead, which gets called from other
> places too.
>
> What exactly is a package here though ? A group of CPUs doing DVFS
> together ? Governed by the same policy structure ? In that case, you
> don't need a lock as the cpufreq core guarantees to not call multiple
> target_index() routines in parallel for the same policy.
A package here is a group of CPUs sharing the same control register,
not a group sharing the same policy. And yes, it is better to move the
lock to do_service_request().


>
> > > > +     msg.id          =3D cpu;
> > > > +     msg.cmd         =3D CMD_GET_FREQ_LEVEL_NUM;
> > > > +     msg.extra       =3D 0;
> > > > +     msg.complete    =3D 0;
> > > > +     ret =3D do_service_request(&msg);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +     max_level =3D msg.val;
> > > > +
> > >
> > >
> > > > +     msg.id          =3D cpu;
> > > > +     msg.cmd         =3D CMD_GET_FREQ_BOOST_LEVEL;
> > > > +     msg.extra       =3D 0;
> > > > +     msg.complete    =3D 0;
> > > > +     ret =3D do_service_request(&msg);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +     boost_level =3D msg.val;
> > >
> > > This stuff is repeated a lot, maybe create a generic function for thi=
s
> > > ?
> > Do you means move the msg filling into do_service_request()?
>
> Yeah, the filling of the msg structure, the call to
> do_service_request() and returning msg.val.
OK, I will do in the next version.

>
> > > > +static int __init cpufreq_init(void)
> > > > +{
> > > > +     int i, ret;
> > > > +
> > > > +     ret =3D platform_driver_register(&loongson3_platform_driver);
> > > > +     if (ret)
> > > > +             return ret;
> > >
> > > What is the use of this platform driver ? I thought the whole purpose
> > > of the platform device/driver in your case was to probe this driver.
> > > In that case cpufreq_init() should only be doing above and not the
> > > below part. The rest should be handled in the probe() function of the
> > > driver.
> > This driver file is now a very basic version, in future it will be a
> > little like intel_pstate that has more than one cpufreq_drivers
> > (active/passive, hwp/nohwp, etc.), so it will register different
> > cpufreq_drivers depends on the result of configure_cpufreq_info().
>
> At this moment we can only review the current version on its merit.
> For the current version, the way things are done is simply wrong. We
> can review later once you have more things to add to this. So simplify
> it to the best of our understanding for now and make as many changes
> later as you need.
OK, I will accept your suggestion.

>
> > > > +     ret =3D cpufreq_register_driver(&loongson3_cpufreq_driver);
> > > > +     if (ret)
> > > > +             goto err;
> > > > +
> > > > +     pr_info("cpufreq: Loongson-3 CPU frequency driver.\n");
> > >
> > > Make this pr_debug if you want.. There is not much use of this for th=
e
> > > user.
> > Emm, I just want to see a line in dmesg.
>
> Yeah, a debug message is what you need then. We don't want to print
> too much unnecessarily on the console, unless there is an error.
Emm, the initialization print isn't very noisy, I will keep this line.
But all other issues will be addressed.

Huacai
>
> --
> viresh
>

