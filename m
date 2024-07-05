Return-Path: <linux-pm+bounces-10657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA99283A7
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 10:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF57EB2205D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE5B145B18;
	Fri,  5 Jul 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p72nLYYa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248613D276;
	Fri,  5 Jul 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168101; cv=none; b=CVbec5DwoVpJ004Q3OcoReQRjQw3w8p3WDvNdbmDfcRba/65Kmycwh6OSLYvn5pV7f3ApO0Nq6AwvPoolZLn+qrs0EFhWIgR0BqLLCgqcC39lMubRT9K++r5DqKBpTKOJYdOO0je0aqy35bEXAcyjQ/R9zQupHTLHZHXrlO5tB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168101; c=relaxed/simple;
	bh=scqZPC5wO4m0aCmMMW3d4hxG0BVZgv+1Scylw50NJeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTO5jYEoMV3VLGmgZlvI45UeR/lKmtETNUBwW5wb5+hU1WvaWivnrwISh7iZxlUrkMRxSCTn6jjWmZ8MuGpgv7eQICC/O6VT9l/ym7eLBsmmFzpuKZKBxsxKocA7O1O1ySSaH15ktdhOx0vDOFLJTkij+GuG+OXaMSijBF59Cwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p72nLYYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E61C4AF0C;
	Fri,  5 Jul 2024 08:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720168100;
	bh=scqZPC5wO4m0aCmMMW3d4hxG0BVZgv+1Scylw50NJeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p72nLYYaqrTeBYJpENa6BI2NQ4zdl6osq7j38dmH3D02nPdiSHuwPLfQApA09Yih1
	 aW92hvslFgm6IXq3MBklRLigB1mZF/8rK5NBAwMS3cXTJDIPhuhB1Mw/jje8lU1Uf+
	 8d38d9/xFQo82+69IWdQ90NWSw6fvuUJp2YpOYoVvCTdiDWZLqn6XpPPFmS6MwVRFC
	 Fqj+HFzaQzJIk+ZjNX5SukLm0yGBrCYF5YPW1QjamXCJy9ebgXBEyAG8oUV289wKw9
	 buDsNRlSjsbIWq2W2gY+bmFAhZI4Nh2QI4xgagtP7F4yomEA+Cx8t+niD1ytEVkwys
	 dXebjxeE4+TvQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77abe5c709so168897866b.2;
        Fri, 05 Jul 2024 01:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmLeG2zOVlE4XEcRMICaBxLtD9giCk/XheKfybMxVXFH/8sqhaPbStsvkjPok2dsF1HLuvsTT9EBuvzQ6X4rXMYe3WTxbs6aV3RpBS7TMyB7j1kofui17eKJvs110GqlGuLBzFrcI=
X-Gm-Message-State: AOJu0YyyANeWqUnSY1uz+0Loaa6UnSjvs+F8tR2NwhpQ0p4XfJAnivGz
	hjk4A6WDPVP3RPTB9bLD5o19jJjnPgGuIdczEnmLAc+/tAGKqMdQuFMKsifEyLbECMO7AdCoP3H
	+90Dw1JxiBmmCQTZDBflgjhNvozE=
X-Google-Smtp-Source: AGHT+IGah1K+v5YHUGFSEIZOI8yyQ+ZJW4cZA61Xt/1RDCkQrBl8XYkuZYWtxCGtiwzPHsVLtaGQKFNuzSvcrSOJohk=
X-Received: by 2002:a17:906:1c13:b0:a77:c002:e4ac with SMTP id
 a640c23a62f3a-a77c002eafbmr204243166b.0.1720168099392; Fri, 05 Jul 2024
 01:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060650.243497-1-chenhuacai@loongson.cn>
 <20240705060650.243497-3-chenhuacai@loongson.cn> <20240705071313.ddl6geg72t4n7j3s@vireshk-i7>
 <CAAhV-H5q5hv2sA7EAm1D1nmbG-VGPzc4kpTnHMDSFuFiTKEH7A@mail.gmail.com> <20240705081723.6y23ts757aunwyhi@vireshk-i7>
In-Reply-To: <20240705081723.6y23ts757aunwyhi@vireshk-i7>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 5 Jul 2024 16:28:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H47OkbiA9awcCVwj4Jz-_o65rCSx++gU+OARhM+XSqLtQ@mail.gmail.com>
Message-ID: <CAAhV-H47OkbiA9awcCVwj4Jz-_o65rCSx++gU+OARhM+XSqLtQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 4:17=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 05-07-24, 15:34, Huacai Chen wrote:
> > It seems except changing mutex_init to devm_mutex_init, all other
> > changes are line breaks? If so, I think additional tests are
> > unnecessary. :)
>
> Yeah, I just wanted to make sure the build passes and I have not
> introduced a stupid bug.
>
> > But now long lines (> 80 columns) are accepted by checkpatch.pl. Even
> > with --strict, only > 100 columns are warned.
> >
> > Especially for the change in loongson3_cpufreq_cpu_exit(), there is
> > only 82 columns and I think that line can keep as the original state.
> > And if possible, I also want the devm_kzalloc() line keep as original.
>
> Fair enough. I am still hung on 80 columns I believe, but I shouldn't
> be as the kernel has moved on :)
>
> New diff (Prototype of exit() callback has changed in my tree, so a
> change for that too).
>
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongs=
on3_cpufreq.c
> index a530e4a56b78..5f79b6de127c 100644
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
> @@ -230,7 +230,8 @@ static int loongson3_cpufreq_target(struct cpufreq_po=
licy *policy, unsigned int
>  {
>         int ret;
>
> -       ret =3D do_service_request(cpu_data[policy->cpu].core, FREQ_INFO_=
TYPE_LEVEL, CMD_SET_FREQ_INFO, index, 0);
> +       ret =3D do_service_request(cpu_data[policy->cpu].core,
> +                                FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO,=
 index, 0);
>
>         return (ret >=3D 0) ? 0 : ret;
>  }
> @@ -310,13 +311,11 @@ static int loongson3_cpufreq_cpu_init(struct cpufre=
q_policy *policy)
>         return 0;
>  }
>
> -static int loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +static void loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>         int cpu =3D policy->cpu;
>
>         loongson3_cpufreq_target(policy, per_cpu(freq_data, cpu)->def_fre=
q_level);
> -
> -       return 0;
>  }
>
>  static int loongson3_cpufreq_cpu_online(struct cpufreq_policy *policy)
> @@ -348,13 +347,14 @@ static int loongson3_cpufreq_probe(struct platform_=
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
> Applied the patch. You need to take 1/2 through the arch specific
> tree. Thanks.
OK, thank you very much.

Huacai
>
> --
> viresh
>

