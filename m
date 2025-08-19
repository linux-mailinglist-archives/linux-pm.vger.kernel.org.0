Return-Path: <linux-pm+bounces-32658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E0B2CCBB
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 21:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01071BA7185
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24526A1C9;
	Tue, 19 Aug 2025 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k09xLxyy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317720110B;
	Tue, 19 Aug 2025 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630315; cv=none; b=N6dVW87lqhEsUUUn2z49kccqB9CQG8Qf87c+oTFepfhcEqF/51hyE+BagRm6TOIuHdZn+ilLz9lnehziI/2FCA+YeN81jQS1GvuPMIPCDpDSEl5NGjtuf7Qk32tTMn+3bbB8lVsJIYAT09+yhD8mLBBDHv2GYLxqR9ui7Ts0afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630315; c=relaxed/simple;
	bh=hH8kgjEs7iIoOTPeQ6hvydKPNSJyjDJ0KoTwQYPWWas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/z/BiEovmyzURhC44Qw34dtYtJ17YHTOAtPNX7R1DcMCFIAJanBhrAA93CxX3b/she5DYaTAN0qHbdHPogfOPgRIM9iQwpPC9w8cT9DDFpX6QupIJu/Io2tZObxm+i27IX1xREJxOQaa8MEBzQTDhZ8Kc3LgLKDYnTRriLCQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k09xLxyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561F6C4CEF1;
	Tue, 19 Aug 2025 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755630315;
	bh=hH8kgjEs7iIoOTPeQ6hvydKPNSJyjDJ0KoTwQYPWWas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k09xLxyysD/DsegmAfwTYLbN2/mHu+yn/N3p4sUGb+4PSEKsg+HK4efteVqZ7slNJ
	 TYHdNsvLCr2Gy7YnK11cWkmm9UN4T7Dris/uROgdmEl7wzn5oGtswPZiMF1tnxZujc
	 Sc9r40626B8G8tty8YQcrDswRHwS3pPQgbI1SBdhMD2oj8RSfg2VEqYWfYaZt6Yqx8
	 4VclDf1t2aEnp/55WrilmZ+/U7Zn1DI84jloAzTseQBvD0PZ4lBqhdr58x7ngKA6zW
	 bP3vpsAk6LE+XvdKUpAGjaDyal8tftPw1UD96HAwlSqDHMRm/jH5ofaOv+MfeBKuIC
	 KaT5wA18tltKA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-435de7d6d05so3198226b6e.2;
        Tue, 19 Aug 2025 12:05:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXROKDNFMxFjYoVmzEfpsIWNlYFvUiI2ev794hRvS2Tw7vMR7FqfKH6s4IJn5HWOr09jyYx4jJ2d412aBc=@vger.kernel.org, AJvYcCXZH1UFTOdxtwHkbQsh5aU4hoUBP42xbdfrah5D4zgVzACcpI4VwE9U7MSQf6As2SYXwoUOGR7pfZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDfAziGGKzBIcbXGrzRe4JF17yfeu4OumWcKMzfkMuDdJORLj
	IjVjX3AtR/zqmS+/babSFHKqDqxeCakWXYFmjtYWI+cAeXFaJRbu+sNeJSF1/a/ci7jYRjeEQxG
	yDNFLweZHwYjNJapZz/qfbeWf6/L3nj8=
X-Google-Smtp-Source: AGHT+IGF/QT6e+pPhr1vLC3u2wJscJaUaLx01cqlV8pGMBaGHX6Rgoz7+QdefM8/iqEj0jRNYPJhUpY4V7SPrG1DX7A=
X-Received: by 2002:a05:6808:1529:b0:40b:2566:9569 with SMTP id
 5614622812f47-437720b2a8cmr61845b6e.24.1755630314655; Tue, 19 Aug 2025
 12:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819072931.1647431-1-zhenglifeng1@huawei.com> <20250819072931.1647431-3-zhenglifeng1@huawei.com>
In-Reply-To: <20250819072931.1647431-3-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Aug 2025 21:05:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i7g8i8m9GPi9=-Y0x36491Ng3akUfVP2vPOBS-OAEg=w@mail.gmail.com>
X-Gm-Features: Ac12FXyJaJYG2BakKB5SaG8-BG8-_3YJyJ3PnymO2pmfxbIOo-svJG1t7kHKvdM
Message-ID: <CAJZ5v0i7g8i8m9GPi9=-Y0x36491Ng3akUfVP2vPOBS-OAEg=w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] cpufreq: Add a new function to get cpufreq policy
 without checking if the CPU is online
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, beata.michalska@arm.com, sudeep.holla@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org, 
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:30=E2=80=AFAM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> cpufreq_cpu_get_raw() gets cpufreq policy only if the CPU is in
> policy->cpus mask, which means the CPU is already online. But in some
> cases, the policy is needed before the CPU is added to cpus mask. Add a
> function to get the policy in these cases.

I'd prefer the subject to be somewhat shorter.  For instance, something lik=
e

cpufreq: Add new helper function returning cpufreq policy

would suffice because the changelog explains the details.

With that addressed

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ++++++
>  include/linux/cpufreq.h   | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..78ca68ea754d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -198,6 +198,12 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned =
int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
>
> +struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu)
> +{
> +       return per_cpu(cpufreq_cpu_data, cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_cpu_policy);
> +
>  unsigned int cpufreq_generic_get(unsigned int cpu)
>  {
>         struct cpufreq_policy *policy =3D cpufreq_cpu_get_raw(cpu);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 95f3807c8c55..26b3c3310d5b 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -205,6 +205,7 @@ struct cpufreq_freqs {
>
>  #ifdef CONFIG_CPU_FREQ
>  struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
> +struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu);
>  struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
>  void cpufreq_cpu_put(struct cpufreq_policy *policy);
>  #else
> @@ -212,6 +213,10 @@ static inline struct cpufreq_policy *cpufreq_cpu_get=
_raw(unsigned int cpu)
>  {
>         return NULL;
>  }
> +static inline struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu=
)
> +{
> +       return NULL;
> +}
>  static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>  {
>         return NULL;
> --
> 2.33.0
>
>

