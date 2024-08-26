Return-Path: <linux-pm+bounces-12882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E809D95F416
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FBE1C21DDC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAE118E058;
	Mon, 26 Aug 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e93xdW4l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200C18D65F;
	Mon, 26 Aug 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683204; cv=none; b=aIh9CZkAZk+wBTCIJS4OCtgvHB7HBBEjoRiJPC7GhftrviOCw+BMn0Xy62zUxMy3wF4Tc7QucQgftorbay+Q7bFJ4qqIYGIVxXkJRvyRQxfml9arSikv33pGa+AnA1LKJV9KPXRwOSji8fO5c2U6oyl6dyWqqMHWirldiMsjne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683204; c=relaxed/simple;
	bh=Ctct7FhOs5kvIU3l+geYiyju1k7Vdf2JX22/VaOv1s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXxLdq9fVGfiO/RimaL5Diq3wCW1oTkh/kkJWxZk59cB/P333yrGnyvlEAZUC2S9V02Uljmm8bTF2PXpzbnRupGUAl4Ff/LWToSYbRU0rUrak+Zuq2ofgu3TDsSIZ0AaZP23eI/cb8n7QTGs5nGgZrhBXDF55m6PzFGZmpEhhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e93xdW4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFD8C4FEEA;
	Mon, 26 Aug 2024 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683204;
	bh=Ctct7FhOs5kvIU3l+geYiyju1k7Vdf2JX22/VaOv1s0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e93xdW4lf/xARfE/fKOh1ecqWXkiWjWHpeT485k2IxR50E8Ew79/4Ox56K7w0LknY
	 dqggeO2X/rgdsxvNi4JQywdJpxPtjODsmro7RyQuCRZPrR3NPB7/AuzF5bP3K/jR6M
	 WQVv/vhCdeSRZJFY1lODVfuO450ih5bY45dUwqR2pMlQo05yRLhfytu8JzF+6Nx9lt
	 c027X1eU3DVhNjXFqxonEe6dHfoctc4CUppxIpkcY/Ax0Ocent09oF3BVWnq8hyxW7
	 LYo4X2l7H3bIHknXRvp7s3If7jOD4wNcRdOwZ9ZnSnJHD40z/FWuexR0r/ATc0nRPY
	 Wze390frhtcRg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53343bf5eddso5822439e87.1;
        Mon, 26 Aug 2024 07:40:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIetJaDqMQaiRE4JU8Y1Li0LmaWHvtYc+6WN7kMbP3QK9TUGg+AhSCWeVo0QN9rz8aPT/EpuWrJOM=@vger.kernel.org, AJvYcCXEgHgIY6znXNvC+EHBH57WAJKhFTwgxpuglS4HKy71/I+JHf6//2UrCLc4Sw96R/47aRul25Ay1QoRNKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWU4AdNX+4V3lq7+0c1WG+Y1zbKtlQ6LZyrgKmrged2e+/cvZU
	q/w88679KA+61+0nGN/36O1g14DjGnv57Z5hYxp8RUvBb9JCb8B7+SeDbxZy1CKukBbODHWKkKH
	HWGLmaIWW0Z64Jh8x5To1xw3bOCs=
X-Google-Smtp-Source: AGHT+IHkY48E2J1ziCxSk4TW9jvAO3h5i0fOHdu6Vfipe6wUWjDPVLV6c7P4ja0mzcQlVn8KnOjsmpNBxG4FBueFISs=
X-Received: by 2002:a05:6512:3ca4:b0:52e:767a:ada3 with SMTP id
 2adb3069b0e04-534387be485mr6059328e87.47.1724683202677; Mon, 26 Aug 2024
 07:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060650.243497-1-chenhuacai@loongson.cn>
 <20240705060650.243497-3-chenhuacai@loongson.cn> <4ad634a1b16285b4d83e7c320a5657b548fd6e22.camel@xry111.site>
In-Reply-To: <4ad634a1b16285b4d83e7c320a5657b548fd6e22.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 26 Aug 2024 22:39:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6W7PdxsnPzgd=C3=RVRr-4RefZXiXDNt4TJLsd7Ktf0Q@mail.gmail.com>
Message-ID: <CAAhV-H6W7PdxsnPzgd=C3=RVRr-4RefZXiXDNt4TJLsd7Ktf0Q@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Fri, Aug 23, 2024 at 2:34=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Fri, 2024-07-05 at 14:06 +0800, Huacai Chen wrote:
> > Some of LoongArch processors (Loongson-3 series) support DVFS, their
> > IOCSR.FEATURES has IOCSRF_FREQSCALE set. And they has a micro-core in
> > the package called SMC (System Management Controller), which can be
> > used to detect temperature, control fans, scale frequency and voltage,
> > etc.
> >
> > The Loongson-3 CPUFreq driver is very simple now, it communicate with
> > SMC, get DVFS info, set target frequency from CPUFreq core, and so on.
> >
> > There is a command list to interact with SMC, widely-used commands in
> > the CPUFreq driver include:
> >
> > CMD_GET_VERSION: Get SMC firmware version.
> >
> > CMD_GET_FEATURE: Get enabled SMC features.
> >
> > CMD_SET_FEATURE: Enable SMC features, such as basic DVFS, BOOST.
> >
> > CMD_GET_FREQ_LEVEL_NUM: Get the number of all frequency levels.
> >
> > CMD_GET_FREQ_BOOST_LEVEL: Get the first boost frequency level.
> >
> > CMD_GET_FREQ_LEVEL_INFO: Get the detail info of a frequency level.
> >
> > CMD_GET_FREQ_INFO: Get the current frequency.
> >
> > CMD_SET_FREQ_INFO: Set the target frequency.
> >
> > In future we will add automatic frequency scaling, which is similar to
> > Intel's HWP (HardWare P-State).
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn
>
> Hi Huacai,
>
> I got some error with the driver enabled:
>
> [    6.650403] BUG: using smp_processor_id() in preemptible [00000000] co=
de: (udev-worker)/208
> [    6.658719] caller is loongson3_cpufreq_probe+0x5c/0x250 [loongson3_cp=
ufreq]
>
> and the driver failed to probe.
>
> It seems the caller of smp_processor_id is actually do_service_request,
> which is inlined into loongson3_cpufreq_probe.
Emm, it seems we should use raw_smp_processor_id() instead of
smp_processor_id(), but I don't know why we haven't met this problem.


Huacai
>
> The .config file is attached.
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

