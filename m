Return-Path: <linux-pm+bounces-13035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9496296A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42C41C238DA
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C7188CBE;
	Wed, 28 Aug 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkFtZd0n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59B166F12;
	Wed, 28 Aug 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853339; cv=none; b=OeGzzUmb7PPyQIsPf1ICuMemHdT80JUJQkdLtd5aBgnfsQ7ciyUPsF+b1ljwM+n6GAYWwajWmMehOY6fNtKMBbZ6msqpYJeOfDSvYesifGpCAIt/XLHyyHw56j1hVm0fepBU4csshNzACCmLMcsWs8gZxDNG6F00ZHJqNaajyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853339; c=relaxed/simple;
	bh=XPnV2y397bnwaQIkVwHIh9HfScBqThbJLAAWw27aJoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxp0SbFiqudenqg1Ss0sc0Wyy8XEkebWiIbZpOF3tV3iwqF3cipdLvkBraFx7Ef8AmrhRAZSJFEsytbKQhPpsPHoK/ukyu8iGR7L8b7kgidPGIRV1Kzci0PBc07e6jwbh8GvC7UtEHVAmcQh468n0OzFE7oFPE39O5vbE1oTNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkFtZd0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEDAC98EFC;
	Wed, 28 Aug 2024 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724853339;
	bh=XPnV2y397bnwaQIkVwHIh9HfScBqThbJLAAWw27aJoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RkFtZd0nSOGPjPPL0w82lNvzvVhgGxt8eIRZtEwr2W/jEP5Dvr0Kp69F3whNYPN23
	 hqM4tPZKFEY6oOZ/877HcfgDd06vnIMLOhjRX8F3s1BvKFrRx9gAHfQPF3wbf5mq11
	 EuL2QejJ2wn0fGq1vPzOyIPUI7iYzAhWFKnWnDGQ4OmOK1XsP36HITZf3Y60llLlFf
	 iA+g3dkupLST5DGQTsDHytrnmfeZQMbspVGGmqaAI1trgLfyNI4GVd98/HMSqjvqO7
	 FaXgwdHBdlRc3LHkHuvdolKcZNKee/YRyHWds2EeeGBOQ0Izgpxk5pfWr8j2poDFkf
	 JPWqwgrEUu+cg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f4f8742138so60512921fa.0;
        Wed, 28 Aug 2024 06:55:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEtjhzYlF2qWIYLr2KyffL2NATSO9YJLFnb548ijjFTVaLTRZ/RyUi91fGXtgZULUDKFapuwia/dY=@vger.kernel.org, AJvYcCWedejcBN9+RI9yOsgTaCUk77NFyZsih11ora05XHmEb8qXPP+mDmscX2TXF+qejpdlICaP/Z/ps+rAnOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjakbggA0d8MJlw3zQoSCvyk1FM0+yMhNLMg4uAgh+qJl7y0z
	KvGnENIRtbu864zFZOFPgsSOqG85cYgqss0T9L1/WXe5gWJzxQaJowPmZh2dMTw4iNm3vJdUSId
	RvrRF03LZQQfuaF+pIr5rFtqbhCA=
X-Google-Smtp-Source: AGHT+IEJDAXBA+iaue0q6nY+jIMRbruOFUVlx4qN/oBUPi/hURj/WS4u3WLNB+19/PGQ1yiDx1LnN06Y2NMpEdMiJuU=
X-Received: by 2002:a05:651c:511:b0:2ef:2bb4:45d with SMTP id
 38308e7fff4ca-2f55b63aa9emr15733131fa.9.1724853337335; Wed, 28 Aug 2024
 06:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828062459.1853837-1-chenhuacai@loongson.cn> <affff6410e681152c3fdcf3512df76d734f29aeb.camel@xry111.site>
In-Reply-To: <affff6410e681152c3fdcf3512df76d734f29aeb.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 28 Aug 2024 21:55:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6YLg1ipUf-45-0zF6HRcCfkVikwQM5cAD7_VSYyAsfoQ@mail.gmail.com>
Message-ID: <CAAhV-H6YLg1ipUf-45-0zF6HRcCfkVikwQM5cAD7_VSYyAsfoQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: loongson3: Use raw_smp_processor_id() in do_service_request()
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 7:59=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Wed, 2024-08-28 at 14:24 +0800, Huacai Chen wrote:
> > Use raw_smp_processor_id() instead of plain smp_processor_id() in
> > do_service_request(), otherwise we may get some errors with the driver
> > enabled:
> >
> >  BUG: using smp_processor_id() in preemptible [00000000] code: (udev-
> > worker)/208
> >  caller is loongson3_cpufreq_probe+0x5c/0x250 [loongson3_cpufreq]
> >
> > Reported-by: Xi Ruoyao <xry111@xry111.site>
> > Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
>
> After this patch the BUG() message is gone, but I still get
>
> [    6.610357] loongson3_cpufreq loongson3_cpufreq: probe with driver loo=
ngson3_cpufreq failed with error -1
>
> -1 is EPERM and there are several "return -EPERM;" in the code.  Not
> sure which one.
>
> Do I need to modify some firmware setting to make it work?
You should update your firmware.

>
> FWIW I'm building it as a module.  Should I try building it as a part of
> vmlinux?
No need.

Huacai

>
> > ---
> >  drivers/cpufreq/loongson3_cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/loongson3_cpufreq.c
> > b/drivers/cpufreq/loongson3_cpufreq.c
> > index 5f79b6de127c..6b5e6798d9a2 100644
> > --- a/drivers/cpufreq/loongson3_cpufreq.c
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -176,7 +176,7 @@ static DEFINE_PER_CPU(struct loongson3_freq_data
> > *, freq_data);
> >  static inline int do_service_request(u32 id, u32 info, u32 cmd, u32
> > val, u32 extra)
> >  {
> >       int retries;
> > -     unsigned int cpu =3D smp_processor_id();
> > +     unsigned int cpu =3D raw_smp_processor_id();
> >       unsigned int package =3D cpu_data[cpu].package;
> >       union smc_message msg, last;
> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

