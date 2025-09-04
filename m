Return-Path: <linux-pm+bounces-33840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F1BB43D3C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 15:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B0A03E4C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510872EC54A;
	Thu,  4 Sep 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLw0um75"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242FB14AA9;
	Thu,  4 Sep 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992715; cv=none; b=qj36El9s081Pb9JWlRkGCsVZOTrAOQnUaZCD3z/3TvVLugXe8i1n0U587LDbbfdP+BPsVkpNU5CfawDfzZO2rUi7cvn8CtXdVsSx9pYa/NImtyCI661KORe364NzVb128hL6ubwPuD94bG5PA5WFt4BJRWIKJ1e+ZvO0mJLpY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992715; c=relaxed/simple;
	bh=0Hp1bTwqzrclDWQutkJWOBnGlUdjHEwBxDG3UFmgWpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndmShrCJhXSm0pUfsuiJwKmLvHrW9eQTqd4tNsZnOfdrcmZQgXcbvlNTmiEaunI7ODNnABFlPNsYeMWbKGkmTiDMDcnD1Vy8vjv2x8nx297dvjzvDNg5GOkGUFLmkv7MdxcAhfVJwZ31VPViCaJs4wu5qcktDBbVkGRB9Sm4oMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLw0um75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9ABC4CEF8;
	Thu,  4 Sep 2025 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756992714;
	bh=0Hp1bTwqzrclDWQutkJWOBnGlUdjHEwBxDG3UFmgWpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PLw0um75nAZ1ff0lmLQ9c0xkT2opk2xVmZQnv7zz92aeACCG0YyGPDzgdnvXhcbDD
	 RsPiW2fwpZNGaeHS4N5HKL4qOnBVdQUBE8ZfODaFYH/ovQL8p5IfyHqkB1EeQR0sci
	 hoFaIWbKeUn9xHY3IX6AbcsVWYwX22aVfgKj+YgvD0Qwe6kF0Cm3/qtEclM1vYsHI4
	 rQKR+hh1sJ0yVa94NYHRDzHKVDoa9zzzuVqJvn+GV9q4hd+DNGyhgy/b5hX9jdD/be
	 Gm8+WT/z0PqMxIi7wlpvCrlSXRNVXpdbLdPW6VZJN3DmGBQgWeNFHG+JrU8Cks1BjV
	 GGkK9qXzGucuw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74543fea20dso987249a34.0;
        Thu, 04 Sep 2025 06:31:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4FUYpthQoWtG1HgcZf3qs0g5jfyEtZuhxWN9RZX/0RsHfozaaNahYGQGlGw0o7IZjwxqLXkw/CV459/w=@vger.kernel.org, AJvYcCX6JLOv53DBPidyzxGbxTGh7jR+weqlNNVICxoQBg/l6Eqznh36KuNeriWAKTOCCHf3TVDJQI0vmdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJlEMQGuVmIGckKMquord5ZtWzxZDqyzW4hNaIA9ADFBV6uBj
	xz15BIuSBe+0VHXNXEjSNixQ+p1aPIhNcml/GnmSX3Gai3lgla28KXGPQs6/0+jWdtlAOYFrmAH
	ideLnsmjdDZM5JWMFJj8rrFbitiRdL3c=
X-Google-Smtp-Source: AGHT+IGKMQV/N9IW7UcNcGVF0ayJJuv6BZu6Wo7P5OnPk1Mb0GMCVJELd8/B2GAaZKVqR1Ow6POYXNLHmqVa/k7LNXM=
X-Received: by 2002:a05:6830:370a:b0:745:a08d:cbc8 with SMTP id
 46e09a7af769-745a08dd15cmr1973579a34.24.1756992713892; Thu, 04 Sep 2025
 06:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn> <20250904032210.92978-2-zhangzihuan@kylinos.cn>
In-Reply-To: <20250904032210.92978-2-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 15:31:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcnqD39OAjFfscCnQ2ZGu9Z1gP5WAPfu3jbeEWr6rGwQ@mail.gmail.com>
X-Gm-Features: Ac12FXyuK6vz8uprUsIuOHqkFOeYQLhed9a2HKRuy5bXFejStPe6_CqPrpWL6JA
Message-ID: <CAJZ5v0hcnqD39OAjFfscCnQ2ZGu9Z1gP5WAPfu3jbeEWr6rGwQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] cpufreq: Drop redundant freq_table parameter
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 5:22=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.cn=
> wrote:
>
> Since commit e0b3165ba521 ("cpufreq: add 'freq_table' in struct
> cpufreq_policy"),
> freq_table has been stored in struct cpufreq_policy instead of being
> maintained separately.
>
> However, several helpers in freq_table.c still take both policy and
> freq_table as parameters, even though policy->freq_table can always be
> used. This leads to redundant function arguments and increases the chance
> of inconsistencies.
>
> This patch removes the unnecessary freq_table argument from these functio=
ns
> and updates their callers to only pass policy. This makes the code simple=
r,
> more consistent, and avoids duplication.
>
> V2:
>  - Merge three patches into one to fix compile error
>  - simple the check suggested by Viresh Kumar
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Do I think correctly that this is a resend of
https://lore.kernel.org/all/20250902073323.48330-1-zhangzihuan@kylinos.cn/
?

There's no need to resend it.

If you want to make new changes on top of it, just say in their
changelogs that they depend on it.

OTOH, if the new patch is not a resend, you should have listed the
differences between it and the old one.

> ---
>  drivers/cpufreq/cpufreq.c         |  2 +-
>  drivers/cpufreq/freq_table.c      | 14 ++++++--------
>  drivers/cpufreq/sh-cpufreq.c      |  6 ++----
>  drivers/cpufreq/virtual-cpufreq.c |  2 +-
>  include/linux/cpufreq.h           |  7 +++----
>  5 files changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a615c98d80ca..5fcc99f768d2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2793,7 +2793,7 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *pol=
icy, int state)
>         if (!policy->freq_table)
>                 return -ENXIO;
>
> -       ret =3D cpufreq_frequency_table_cpuinfo(policy, policy->freq_tabl=
e);
> +       ret =3D cpufreq_frequency_table_cpuinfo(policy);
>         if (ret) {
>                 pr_err("%s: Policy frequency update failed\n", __func__);
>                 return ret;
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 35de513af6c9..d5111ee56e38 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -28,10 +28,9 @@ static bool policy_has_boost_freq(struct cpufreq_polic=
y *policy)
>         return false;
>  }
>
> -int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
> -                                   struct cpufreq_frequency_table *table=
)
> +int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>  {
> -       struct cpufreq_frequency_table *pos;
> +       struct cpufreq_frequency_table *pos, *table =3D policy->freq_tabl=
e;
>         unsigned int min_freq =3D ~0;
>         unsigned int max_freq =3D 0;
>         unsigned int freq;
> @@ -65,10 +64,9 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_pol=
icy *policy,
>                 return 0;
>  }
>
> -int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
> -                                  struct cpufreq_frequency_table *table)
> +int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy)
>  {
> -       struct cpufreq_frequency_table *pos;
> +       struct cpufreq_frequency_table *pos, *table =3D policy->freq_tabl=
e;
>         unsigned int freq, prev_smaller =3D 0;
>         bool found =3D false;
>
> @@ -110,7 +108,7 @@ int cpufreq_generic_frequency_table_verify(struct cpu=
freq_policy_data *policy)
>         if (!policy->freq_table)
>                 return -ENODEV;
>
> -       return cpufreq_frequency_table_verify(policy, policy->freq_table)=
;
> +       return cpufreq_frequency_table_verify(policy);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
>
> @@ -354,7 +352,7 @@ int cpufreq_table_validate_and_sort(struct cpufreq_po=
licy *policy)
>                 return 0;
>         }
>
> -       ret =3D cpufreq_frequency_table_cpuinfo(policy, policy->freq_tabl=
e);
> +       ret =3D cpufreq_frequency_table_cpuinfo(policy);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 9c0b01e00508..642ddb9ea217 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -89,11 +89,9 @@ static int sh_cpufreq_target(struct cpufreq_policy *po=
licy,
>  static int sh_cpufreq_verify(struct cpufreq_policy_data *policy)
>  {
>         struct clk *cpuclk =3D &per_cpu(sh_cpuclk, policy->cpu);
> -       struct cpufreq_frequency_table *freq_table;
>
> -       freq_table =3D cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
> -       if (freq_table)
> -               return cpufreq_frequency_table_verify(policy, freq_table)=
;
> +       if (policy->freq_table)
> +               return cpufreq_frequency_table_verify(policy);
>
>         cpufreq_verify_within_cpu_limits(policy);
>
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-=
cpufreq.c
> index 7dd1b0c263c7..6ffa16d239b2 100644
> --- a/drivers/cpufreq/virtual-cpufreq.c
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -250,7 +250,7 @@ static int virt_cpufreq_offline(struct cpufreq_policy=
 *policy)
>  static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *policy=
)
>  {
>         if (policy->freq_table)
> -               return cpufreq_frequency_table_verify(policy, policy->fre=
q_table);
> +               return cpufreq_frequency_table_verify(policy);
>
>         cpufreq_verify_within_cpu_limits(policy);
>         return 0;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 95f3807c8c55..40966512ea18 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -780,11 +780,10 @@ struct cpufreq_frequency_table {
>                 else
>
>
> -int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
> -                                   struct cpufreq_frequency_table *table=
);
> +int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy);
> +
> +int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy);
>
> -int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
> -                                  struct cpufreq_frequency_table *table)=
;
>  int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *p=
olicy);
>
>  int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
> --
> 2.25.1
>

