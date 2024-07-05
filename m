Return-Path: <linux-pm+bounces-10654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1F9282C2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 09:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EB51C22EAB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAF513D8A8;
	Fri,  5 Jul 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrJSJj86"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6A132111;
	Fri,  5 Jul 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720164858; cv=none; b=XIUggb48LVyThUOBrQzhtHYoMvOg9mZZWacpINGdcSES/GhEbsXrVNZ3HPEenbeR5uwhhrmQ6iJM0yeBfBA4/G0RvBqBbR4wkleWnaDckl3BMCjmA36SE5wctSjEw2FBAmdV1d7uk4hA7bVusASm9r4GmSvBzSv98P/Gv5c9R+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720164858; c=relaxed/simple;
	bh=BHfl/H4utgDSGPe89jxXBrs1DUBNrzQD0UaGIZfZ8uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDjhDLwxUHgW4vrIjP338pXDpbPML4OlDLWfyXJE8/M+VxJOHtvka6WO1x3duawMQjsAkCKhwzb4U8Msf9itpp8AGo+PbzmnNCSuQXq4cKptxwiairZA3DiTBmClZdXw2ZlogC370tniEeL3tdKwFrvzuiy45zuPJqzlkAs9HUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrJSJj86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235E2C4AF0D;
	Fri,  5 Jul 2024 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720164858;
	bh=BHfl/H4utgDSGPe89jxXBrs1DUBNrzQD0UaGIZfZ8uo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qrJSJj86DXIXqU3H+Fn1N4QOEOKsAeINpffJcSISKHCpdMMfSWRahBJOVmLEnJCKF
	 wsHGqsWV+84SjF3zlApPnnLPWIitk3wVO1/2HBXd+mh/nYFBSObmASUu33hOMXGKxw
	 9sKSEFTL6opqS7boDiTqs9jE1qvUUUZCHiwN472GHgibQjM4Yh1gf1IN73oUXLwn4u
	 xueWn1dxeNnrI8g5EjYQV8EPqJ0h9cUpgTRDX5kwWGdOCfG/uzOzKpAEbnsIg1wP3e
	 123V2Vv/RjqeqQpOqwvfP6cC7ueBVbo2N2/BerbllpEwu+lCcxjVn0/BQFCn8x2XQS
	 R1ytyVTqXeX9g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso110331366b.0;
        Fri, 05 Jul 2024 00:34:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyp3BCeCUIjTPPlhl1L3SlHaomaG51rgrDuRpxh/CnE2A3alHqTJTi0WgGdtGvjUKnbAERNGQo+S3ClZSbns5vw5kQKwhmUHf9A7wL6LDHds+XsXSuwQIvJDCnE28+aHft2HzO0fA=
X-Gm-Message-State: AOJu0YxRwAtSsUg1cR4TdfFNJDKFE7uAMNhf35gvj3Oo5gvGmwrpULTC
	5D/SDurDWubt/E1L5bJNdXdF7JE+r7JsbaE4wmwqB9XWHQvOQ9r54DdRLltJoypODCqzXRWSwGp
	1Dl2OKLSKKPvxaX5KVSH/HNyaVcw=
X-Google-Smtp-Source: AGHT+IF/eBN0vyUo4OIC8k707QcyExW5K/WQzeKGFnL7+LV0rs6bWLrkRRkYsYPzaUUzV5DmXoLsqXJ3YjHCJTD+tiw=
X-Received: by 2002:a17:906:e1b:b0:a72:48dd:46a4 with SMTP id
 a640c23a62f3a-a77b9ddd4b9mr228152166b.0.1720164856482; Fri, 05 Jul 2024
 00:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060650.243497-1-chenhuacai@loongson.cn>
 <20240705060650.243497-3-chenhuacai@loongson.cn> <20240705071313.ddl6geg72t4n7j3s@vireshk-i7>
In-Reply-To: <20240705071313.ddl6geg72t4n7j3s@vireshk-i7>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 5 Jul 2024 15:34:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5q5hv2sA7EAm1D1nmbG-VGPzc4kpTnHMDSFuFiTKEH7A@mail.gmail.com>
Message-ID: <CAAhV-H5q5hv2sA7EAm1D1nmbG-VGPzc4kpTnHMDSFuFiTKEH7A@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Viresh,

On Fri, Jul 5, 2024 at 3:13=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 05-07-24, 14:06, Huacai Chen wrote:
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
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  MAINTAINERS                         |   1 +
> >  drivers/cpufreq/Kconfig             |  12 +
> >  drivers/cpufreq/Makefile            |   1 +
> >  drivers/cpufreq/loongson3_cpufreq.c | 395 ++++++++++++++++++++++++++++
> >  4 files changed, 409 insertions(+)
> >  create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
>
> I have made some changes while applying, can you please test these ?
Thank you for your effort.

It seems except changing mutex_init to devm_mutex_init, all other
changes are line breaks? If so, I think additional tests are
unnecessary. :)

But now long lines (> 80 columns) are accepted by checkpatch.pl. Even
with --strict, only > 100 columns are warned.

Especially for the change in loongson3_cpufreq_cpu_exit(), there is
only 82 columns and I think that line can keep as the original state.
And if possible, I also want the devm_kzalloc() line keep as original.

Others are OK.

Huacai

>
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongs=
on3_cpufreq.c
> index a530e4a56b78..cd3efdeeddd9 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -31,10 +31,10 @@ union smc_message {
>  };
>
>  /* Command return values */
> -#define CMD_OK                         0  /* No error */
> -#define CMD_ERROR                      1  /* Regular error */
> -#define CMD_NOCMD                      2  /* Command does not support */
> -#define CMD_INVAL                      3  /* Invalid Parameter */
> +#define CMD_OK                         0 /* No error */
> +#define CMD_ERROR                      1 /* Regular error */
> +#define CMD_NOCMD                      2 /* Command does not support */
> +#define CMD_INVAL                      3 /* Invalid Parameter */
>
>  /* Version commands */
>  /*
> @@ -173,7 +173,8 @@ static struct mutex cpufreq_mutex[MAX_PACKAGES];
>  static struct cpufreq_driver loongson3_cpufreq_driver;
>  static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
>
> -static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val,=
 u32 extra)
> +static inline int
> +do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 extra)
>  {
>         int retries;
>         unsigned int cpu =3D smp_processor_id();
> @@ -226,11 +227,13 @@ static unsigned int loongson3_cpufreq_get(unsigned =
int cpu)
>         return ret * KILO;
>  }
>
> -static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsig=
ned int index)
> +static int
> +loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int ind=
ex)
>  {
>         int ret;
>
> -       ret =3D do_service_request(cpu_data[policy->cpu].core, FREQ_INFO_=
TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
> +       ret =3D do_service_request(cpu_data[policy->cpu].core,
> +                       FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0=
);
>
>         return (ret >=3D 0) ? 0 : ret;
>  }
> @@ -255,14 +258,16 @@ static int configure_freq_table(int cpu)
>         boost_level =3D ret;
>
>         freq_level =3D min(max_level, FREQ_MAX_LEVEL);
> -       data =3D devm_kzalloc(&pdev->dev, struct_size(data, table, freq_l=
evel + 1), GFP_KERNEL);
> +       data =3D devm_kzalloc(&pdev->dev, struct_size(data, table, freq_l=
evel + 1),
> +                           GFP_KERNEL);
>         if (!data)
>                 return -ENOMEM;
>
>         data->def_freq_level =3D boost_level - 1;
>
>         for (i =3D 0; i < freq_level; i++) {
> -               ret =3D do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_=
GET_FREQ_LEVEL_INFO, i, 0);
> +               ret =3D do_service_request(cpu, FREQ_INFO_TYPE_FREQ,
> +                                        CMD_GET_FREQ_LEVEL_INFO, i, 0);
>                 if (ret < 0) {
>                         devm_kfree(&pdev->dev, data);
>                         return ret;
> @@ -290,6 +295,7 @@ static int loongson3_cpufreq_cpu_init(struct cpufreq_=
policy *policy)
>
>         policy->cpuinfo.transition_latency =3D 10000;
>         policy->freq_table =3D per_cpu(freq_data, cpu)->table;
> +
>         policy->suspend_freq =3D policy->freq_table[per_cpu(freq_data, cp=
u)->def_freq_level].frequency;
>         cpumask_copy(policy->cpus, topology_sibling_cpumask(cpu));
>
> @@ -314,7 +320,8 @@ static int loongson3_cpufreq_cpu_exit(struct cpufreq_=
policy *policy)
>  {
>         int cpu =3D policy->cpu;
>
> -       loongson3_cpufreq_target(policy, per_cpu(freq_data, cpu)->def_fre=
q_level);
> +       loongson3_cpufreq_target(policy, per_cpu(freq_data,
> +                                cpu)->def_freq_level);
>
>         return 0;
>  }
> @@ -348,13 +355,14 @@ static int loongson3_cpufreq_probe(struct platform_=
device *pdev)
>         int i, ret;
>
>         for (i =3D 0; i < MAX_PACKAGES; i++)
> -               mutex_init(&cpufreq_mutex[i]);
> +               devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
>
>         ret =3D do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
>         if (ret <=3D 0)
>                 return -EPERM;
>
> -       ret =3D  do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE, FEA=
TURE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
> +       ret =3D do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE,
> +                                FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST=
, 0);
>         if (ret < 0)
>                 return -EPERM;
>
>
> --
> viresh

