Return-Path: <linux-pm+bounces-17460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B89C64EC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 00:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E0EB30F8B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 20:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB8219E4D;
	Tue, 12 Nov 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC0JGiMH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33A219E3B;
	Tue, 12 Nov 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444301; cv=none; b=FAQ23H5ttoqVOFABHtrENrNRYmKZnoialykZZ6CTYg3AUdMjCUPgGt7IoMnS9Hctwz8u/KkA97luwim2Y2qjMEw6FTbin90WudyOJJ6+ceaQKZ6E8+wx+So5QlF6tdvrzR2owNUC0q/WVL+crnMKC4QyWJlHhzuexK9vmjTZsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444301; c=relaxed/simple;
	bh=5Cr1eflZL/DZBklAvj4490Qwo7UzjE+LNfqVpmLwH3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI/IT/yXhRRqeooKH7Cia/Tepv4wOv/q/6yj2NPXFlQe73SOU6NsoNU182cH0aBFFLIHa7a2HS1MssC9uN3/dbUC56KOXV7IYojJ/xfgIHusPVcrhSa7YyfaNCFKKfGAGxtviiwHoLp9C5HP5N+tbS5beFfiMu/aJDlXj9OiV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC0JGiMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B83C4CECD;
	Tue, 12 Nov 2024 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731444301;
	bh=5Cr1eflZL/DZBklAvj4490Qwo7UzjE+LNfqVpmLwH3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BC0JGiMH/ZHQFoX3rZkYj/3LNH7KBd9Ngoa0iZVzIQN0tP/F1lYjrJFXZN52pI2/T
	 Dba3FM/wYJyChsZWb+ztVSmWdEp5GbS8uMgzCsgevWnMNS6R8EIZGvzOYfjcGtL3C0
	 /Trr2XVaYzY/XjLy8kCXPFqKqb/5R7SQXXOyGrB3W1TD7tV95VEmT8AI3C8d5+GBhV
	 Ai3gYWTrzxWFla+eJupcUzhO3cgDfzEMIsP8YY2xcCz4xwVlluesOuu3S/8jC8SZba
	 /HVOsPdKcz2VEnx/HMF3nM2uCgsrYEcgADKXMcbKyaPLHvpUYHA5M2/6FuGnyxxW/P
	 JgLy4xLp790uQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5edf76cd843so2637298eaf.1;
        Tue, 12 Nov 2024 12:45:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDtzfeaCh1ylb1RHk6onuopcEYlrNbZghvQ3a9VUEnQCKU1S2MwqSTOAGxMm30uIxcfCV9NZWpykBD9qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WZqa/Jpi7xGb2YNYH827xavjJPxu9ppBcKYXoV4dwrieNEZE
	9tGQk11tjildEVom3m0q3nT3ZBzAr4zQM12b/LabfN68yAHzYKOVaskdN6Hm6XkL83r1USDssC7
	rRRYOMGRDB5D/BLxmUbLz2SK2ELU=
X-Google-Smtp-Source: AGHT+IFFUv+UXSZpj6AZrcz8sjUknYP9yAYvqYYxkKZ+/ktlSq0IY3A8veW/V9Zs5kVkgClznWbbLZcbxg6HP7n40ao=
X-Received: by 2002:a05:6820:179a:b0:5ed:feae:d5bd with SMTP id
 006d021491bc7-5ee57cc4966mr12177544eaf.3.1731444300628; Tue, 12 Nov 2024
 12:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e9afefb7-3c4e-48ee-aab1-2f338c4e989d@intel.com> <20241106182313.165297-1-chang.seok.bae@intel.com>
In-Reply-To: <20241106182313.165297-1-chang.seok.bae@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 21:44:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i0nf_8BGqbuFRQ6byxM9cPU4A37hiW10LZ57FTqDgO8w@mail.gmail.com>
Message-ID: <CAJZ5v0i0nf_8BGqbuFRQ6byxM9cPU4A37hiW10LZ57FTqDgO8w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Simplify MSR read on the boot CPU
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, dave.hansen@intel.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 7:23=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.c=
om> wrote:
>
> Replace the 32-bit MSR access function with a 64-bit variant to simplify
> the call site, eliminating unnecessary 32-bit value manipulations.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
> I've received feedback to use rdmsrl_on_cpu() instead of rdmsr_on_cpu()
> for similar code in my feature-enabling series [1]. While auditing the
> tree, I found this case as well, so here's another cleanup.
>
> [1] https://lore.kernel.org/lkml/e9afefb7-3c4e-48ee-aab1-2f338c4e989d@int=
el.com/
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 0f04feb6cafa..b942cd11e179 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -73,20 +73,17 @@ static unsigned int acpi_pstate_strict;
>
>  static bool boost_state(unsigned int cpu)
>  {
> -       u32 lo, hi;
>         u64 msr;
>
>         switch (boot_cpu_data.x86_vendor) {
>         case X86_VENDOR_INTEL:
>         case X86_VENDOR_CENTAUR:
>         case X86_VENDOR_ZHAOXIN:
> -               rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
> -               msr =3D lo | ((u64)hi << 32);
> +               rdmsrl_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &msr);
>                 return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
>         case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
> -               rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
> -               msr =3D lo | ((u64)hi << 32);
> +               rdmsrl_on_cpu(cpu, MSR_K7_HWCR, &msr);
>                 return !(msr & MSR_K7_HWCR_CPB_DIS);
>         }
>         return false;
> --

Applied as 6.13 material, thanks!

