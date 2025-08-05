Return-Path: <linux-pm+bounces-31964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA9AB1B3DD
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 14:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495AB189DE01
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46327146E;
	Tue,  5 Aug 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjqhAvNu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CC241103;
	Tue,  5 Aug 2025 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398651; cv=none; b=CGniy4r85S7XlTPkMapU514Vjr8WZj2qhM8SDSyW/Pzvcl/oHcq/zgaRovy5c5nIFEteeK0eqV9CQdjelsW59f9Ci/ajG/3ZKerHBuWKERtEhZheYSmbxxBerMzsnYmHqmcFcHDyyP/E95KdbNcm5BTGqt8Onb5dHOXjOdsojiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398651; c=relaxed/simple;
	bh=/Q154M5fKuJcthmk/dvqUU0hQH0vyCaiY74Qs2fJRZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJg7HY0L2t20+4c6D7xyHenR5a7YtDuq59nWg5ePt09SD06X4pBA4ArR5L5JQtCAlPRBxO0+sC5yLc73o3kMHwhjWvJR11PYfenDhgWqYjLDnXpgyr5m0OJyQv3vOQfu2sYlO9fTW5HH5/Todh66FHWJ2nd42asbeAkAXgKrmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjqhAvNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C49C4CEF7;
	Tue,  5 Aug 2025 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754398651;
	bh=/Q154M5fKuJcthmk/dvqUU0hQH0vyCaiY74Qs2fJRZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fjqhAvNu6oOujJJPY0OdviGQKVb3TNu2d//ilddXsZp4FBOBpAtlYXxGw98C+HxHZ
	 wKhSDzHsXGDcAXRIbL5n6A4fx8LiwVsOKGFY9D4AQvVwvQZZdFyTgZiGXVUIqAs65Y
	 k83ET/LcdINebn86n086KqwVlSvNq3dlZ/XNebjrSJ7NllWqnb8RS4YW/ByjeTCqeW
	 KUaa9pk9HOhCvyqM3T2Iq9qsFWcHzRsRaZpweEx8BhDYpQyFbAV9bGgAAy5YlxBxJS
	 gEIcPDRacEaq8xsP/Av7AIivlNiN8aF5yS8BAYZbUxqFqxPZVBTG1QyCK2h5IteTMs
	 bxA1qDKsW9zMQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30b7448b777so2142617fac.0;
        Tue, 05 Aug 2025 05:57:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsTc8ZI8IbyRA+BtZdTUVW6J0DYyUaPVNr03ozSWIJO7uwxxTPSmB/ElS7Mc08HTkhS3FX4Jjhz3/EEcY=@vger.kernel.org, AJvYcCV2LtwtxPDAoP8kG2o97xp6AAxTMVyLZNY/lDwdKl3aTWdTN0ijFxnA1it9O0y8NPJI9dGCYgbBKcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7yXYNR5tq28nm86Kvjgr24YEnAKXId8a2BC6j5UEyF4rBRt2
	ZyI75sTKo15+jhuWV5mXMyu+Z6QOCxzZfbs/+/QmufXqetKwzs32YAYne9FwIhGnAZ8559kJBVR
	icURVO2Z8zQrsgoK8H01gtCS+Awq5fpY=
X-Google-Smtp-Source: AGHT+IFPAZyhywgLQvoskIOmz2VU+10EYz63YwRwlyu84oAH2UchHeV7tpu0Rg/EeQb9g6axbf5sa7qF+zrfyTHq6AA=
X-Received: by 2002:a05:6870:b001:b0:2ff:9224:b1c8 with SMTP id
 586e51a60fabf-30b67a46c62mr7931975fac.36.1754398650648; Tue, 05 Aug 2025
 05:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805093330.3715444-1-zhenglifeng1@huawei.com> <20250805093330.3715444-3-zhenglifeng1@huawei.com>
In-Reply-To: <20250805093330.3715444-3-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Aug 2025 14:57:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h3XKXAGHSrx50vt1Aho3uchiJ2kjQa7qCM8jCr03YKTA@mail.gmail.com>
X-Gm-Features: Ac12FXz_6f4R8OhJ2KEpzWPYtfA52SizmFoqZrcEiv1xQxt4mcznPwed7XSItvs
Message-ID: <CAJZ5v0h3XKXAGHSrx50vt1Aho3uchiJ2kjQa7qCM8jCr03YKTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cpufreq: Add a new function to get cpufreq policy
 without checking if the CPU is online
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, beata.michalska@arm.com, sudeep.holla@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org, 
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 11:34=E2=80=AFAM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> cpufreq_cpu_get_raw() gets cpufreq policy only if the CPU is in
> policy->cpus mask, which means the CPU is already online. But in some
> cases, the policy is needed before the CPU is added to cpus mask. Add a
> function to get the policy in these cases.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++++++++
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..2de76a072893 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -198,6 +198,17 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned =
int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
>
> +struct cpufreq_policy *cpufreq_cpu_get_raw_no_check(unsigned int cpu)

This is not a particularly nice name.  Maybe call it cpufreq_cpu_policy()?

> +{
> +       struct cpufreq_policy *policy =3D per_cpu(cpufreq_cpu_data, cpu);
> +
> +       if (policy)
> +               return policy;
> +
> +       return NULL;

This could just be a one-liner with this statement in the function body:

  return per_cpu(cpufreq_cpu_data, cpu);

Can't it?

In which case it can be called in all places reading cpufreq_cpu_data
for a given CPU.

> +}
> +EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw_no_check);
> +
>  unsigned int cpufreq_generic_get(unsigned int cpu)
>  {
>         struct cpufreq_policy *policy =3D cpufreq_cpu_get_raw(cpu);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 95f3807c8c55..02ad8173dc10 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -205,6 +205,7 @@ struct cpufreq_freqs {
>
>  #ifdef CONFIG_CPU_FREQ
>  struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
> +struct cpufreq_policy *cpufreq_cpu_get_raw_no_check(unsigned int cpu);
>  struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
>  void cpufreq_cpu_put(struct cpufreq_policy *policy);
>  #else
> --

