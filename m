Return-Path: <linux-pm+bounces-10580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3C09270B9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 09:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DC91C22093
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E92A1A08B5;
	Thu,  4 Jul 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntFiyolL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A13156679;
	Thu,  4 Jul 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078659; cv=none; b=itIVDZEo5GvfCdKpwhdUBh5r3IOrj7Mb5fy0QEvtXYkSE1oTpr1hiKSATEvQESnybsY0UYX66sidKqSPBvm1I630F5TIo1+/j7BH2aBf6sZ6H6eDVwDvIHXROoKmGTZ79cFqh24745e37WjJWUZjJIk6lavljg+AsS09sV6q4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078659; c=relaxed/simple;
	bh=4b8M2Kr1D8wWFbEG11gulaaYlKoocvWNkaRYNPG4rX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtxxDukI1Edl1vcUPiq+CiJS0ythIh4owQ201zZQIrGVoVyL+d5lDG3mriEg1SKaC/N+qcN6gH8ItlHRlsnhMdveEp9gK+qmRjhytphzv9gKuI5llOUNHmpO6mkWu97NVjEbpzxkqDOZn0vPcqqmX9tsYZjMdVqExMm/B2B2Lpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntFiyolL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FADC4AF13;
	Thu,  4 Jul 2024 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720078658;
	bh=4b8M2Kr1D8wWFbEG11gulaaYlKoocvWNkaRYNPG4rX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ntFiyolL4XzVk9jl29/9X3ioFhy4aeS69BJzLHxmKM/29sWYFvI2vTFnsI8o4mqyj
	 ZPNqrXzLt4rkKhmngB1hgLYUhrxQls1mPTk7Ehf14SZRE0MSxd1A89GQsKDWwrBLm6
	 5iGMyyT73zEJhd1Kt4jdvQQP0VTKacAEuhS6XBTq4lZx0EzJbx4KUOIFP8jCfMd3rx
	 i3F4v1fp2tiO1ECJDQddvHpa24cnLtPDtBQlOWlx9R1aemTSP70gyiiO1DEH+7Zcsg
	 xUC1tisL/dJQ5hyG7lYzZxOp3xt2n2j4z3Iebeul7Rzyhs1A0KhKrkIEFa5S8bIJWL
	 umr8qUZe+HCYA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so370936a12.3;
        Thu, 04 Jul 2024 00:37:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbJ3tEJ5uGLL0YDCADzvzGsmABTQa9vHNg5ZTqoNbAH3n9bKPOo2iuJ3yLxYuz7O7vY5r8VVzHrVEsUr16fatGSFnCJ+dbdQWiCiJWCqVmCKaIezd2aXgw10yCoLoninlgYc4+JEE=
X-Gm-Message-State: AOJu0YwMl3FfIviaDm5zvReCENhm5ZgrJf/X4bbSsuz0rCnbGVQ3aqCd
	V8ykQKp/h8wlzGOZJ5QDLHikwXgFJgPwDyUrKZ8/uKQvfdNozSmg365St4hgCn3K4S5we2OLKtL
	4o8ftUvPsECxnH3aZ1Rv3Ku4DJio=
X-Google-Smtp-Source: AGHT+IGv5wn4a6TI1CPUD8KsvqfV8JNoexVkDkXwdzMRAPLV8uUZztDLHe8kJIUE6xbMcSQzf7IFTkDSXG2N/w0LFVg=
X-Received: by 2002:a17:906:5acd:b0:a77:b052:877e with SMTP id
 a640c23a62f3a-a77ba46af61mr57544066b.19.1720078657344; Thu, 04 Jul 2024
 00:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702152737.1184244-1-chenhuacai@loongson.cn>
 <20240702152737.1184244-3-chenhuacai@loongson.cn> <20240703101850.dtck223pleiiwfxp@vireshk-i7>
 <CAAhV-H74HJr0=8g0GtHj=zZH5nJijRpc90zLLRY_sXJfKFVtHA@mail.gmail.com> <20240704031532.5bkh4nr7d3vcvzwq@vireshk-i7>
In-Reply-To: <20240704031532.5bkh4nr7d3vcvzwq@vireshk-i7>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Jul 2024 15:37:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4HbZ02BdtE47gVyZGdNKj4QWzMSuZgHR6d9RHE36Nv=A@mail.gmail.com>
Message-ID: <CAAhV-H4HbZ02BdtE47gVyZGdNKj4QWzMSuZgHR6d9RHE36Nv=A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 11:15=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 03-07-24, 22:37, Huacai Chen wrote:
> > On Wed, Jul 3, 2024 at 6:18=E2=80=AFPM Viresh Kumar <viresh.kumar@linar=
o.org> wrote:
> > > > +static int loongson3_cpufreq_target(struct cpufreq_policy *policy,=
 unsigned int index)
> > > > +{
> > > > +     /* setting the cpu frequency */
> > > > +     return loongson3_cpufreq_set(policy, index);
> > >
> > > Why use a separate function for calling do_service_request() ? Just
> > > open code it here.
> > Hmm, there is a loongson3_cpufreq_get() function, so I make a
> > loongson3_cpufreq_set() function, too.
>
> The counterpart of _get is _target and so a separate set function
> isn't required at all. Just get rid of it.
OK, will do.

>
> > > > +static int loongson3_cpufreq_get_freq_table(int cpu)
> > > > +{
> > > > +     int i, ret, boost_level, max_level, freq_level;
> > > > +     struct cpufreq_frequency_table *table;
> > > > +
> > > > +     if (per_cpu(freq_table, cpu))
> > > > +             return 0;
> > > > +
> > > > +     ret =3D do_service_request(cpu, 0, CMD_GET_FREQ_LEVEL_NUM, 0,=
 0);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +     max_level =3D ret;
> > > > +
> > > > +     ret =3D do_service_request(cpu, 0, CMD_GET_FREQ_BOOST_LEVEL, =
0, 0);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +     boost_level =3D ret;
> > > > +
> > > > +     freq_level =3D min(max_level, FREQ_MAX_LEVEL);
> > > > +     table =3D kzalloc(sizeof(struct cpufreq_frequency_table) * (f=
req_level + 1), GFP_KERNEL);
> > >
> > > devm_kcalloc(pdev, ...) instead ?
> > I remember you told me this in V1, but devm_kalloc() needs a pdev
> > instance, which doesn't exist here, so I keep kzalloc().
>
> See how drivers/cpufreq/brcmstb-avs-cpufreq.c stores the pdev in
> cpufreq_driver's driver_data and reuses later on.
OK, I have learned that devm_kzalloc() allocated memory will be
automatically freed at driver dettach.
But I have another question: can the "kfree(table)" after
do_service_request() fail be removed?  Because I think in this case
the probe will fail, then no driver detach happens.

Huacai

>
> --
> viresh

