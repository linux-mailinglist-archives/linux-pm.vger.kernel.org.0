Return-Path: <linux-pm+bounces-34019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAB4B4635B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 21:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2923B1E65
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E308283121;
	Fri,  5 Sep 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEluLA7I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79214277804
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099693; cv=none; b=p6DYFCiDtoUzt9aHtbkgyDSEE6Z6Q/6bSlGOxE3KeiK9vGkiJ9ae70nEZOiwAfoLAHO2MPirFkpzKaISSLJX0mNcfseu+Rg+aTkLTmocvNK3edN95/3ryc/y+PBnQkKkEFRNLkzA1tDLbzT/tsSJJOTBGF1qjIFiWe82lXA3aOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099693; c=relaxed/simple;
	bh=YMYQZL0IPHcYll8nM6VwMyaMpAI3Ez8h+R4x42hS8vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCDkz93bsfQHbP0+PIB6ywb6ym3KvwQV6Y2U3s2dg7jMOwFuMyWsZyRPbKisOtFaQMEPUpSE7+bsZ+/kgFIY1aih0vO+8mD5COsAfJtBqYSbWlqV5ZF0CYCzH69lQgw6NCZQfh/VV4yATvGMPUTJauRFAAS5OUnQV1jeY8VGgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEluLA7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B045C4CEF1
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757099693;
	bh=YMYQZL0IPHcYll8nM6VwMyaMpAI3Ez8h+R4x42hS8vc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uEluLA7IqcDu+Mb/xpHHBgebWpFs2TOQhSOEoLIE/zDIC2IWb2+6zOSObOJiNPeCv
	 cURFj3kBw27X4H3q7oxK1iWD6yN+nlCX/ciOBzoTbGJLOYy5DP1x7Z9eXmBUOzqjnn
	 ZKvx98t6v6Rq2axvAvZHHNWimvBL9A05874kWUrEun03tyyun6fOQ0lvzQ4dIUfuBm
	 5GLve5x/xRDkJpXz38az5eySDN3eJsMb8smxphQx7uLbYHS9SuhQX47Ms5xfuOrplQ
	 56RfiYUSpPcQ5hMuORF03u1f8G6+/QU+jmRnIhhdTznj8cu+ODn6zkpOfopcYA5Wqq
	 VQSkf+f/BajjA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61e4c824615so1074099eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 12:14:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg+tMPb27dOpr8lGYGyAr5drC6u+a2tiompT1l+zR/8hF4EUpP/rmOAKOSp2UdiYxC7H+ofhU+CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+qNPRrl5aq/BPe+Jw3D3nNE66S8p+PhfV+JjTHAc55WtjPao
	XxgQq0WobZ21u5UvSH6jfEMNckAXryrZLEPxjaHkrmkkTJhgUmvxZ9t2JoOJsYjdX6vqAqk83Qp
	YVS8mQMCEsrv0M4Y+uQSlJ1utbndIoAU=
X-Google-Smtp-Source: AGHT+IFpJE6LMLax7Cb2FmOkiAAfdu3KT0g+fjf4H9zTsnGB5yeCsXV6+Y1LbVR/Ef4eE57/I0gKsW/MB/fJtn/2KUQ=
X-Received: by 2002:a05:6820:1acb:b0:61e:168b:defd with SMTP id
 006d021491bc7-61e33728681mr11540495eaf.5.1757099692346; Fri, 05 Sep 2025
 12:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904081600.2706572-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250904081600.2706572-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 21:14:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iBdmzD2ansm34HQhXQE+Q6_qUkjW1XC9xK_G8Aw_0ubQ@mail.gmail.com>
X-Gm-Features: Ac12FXxcpH8ycBrtpBaPvCn-AIAK-cnOlQKKdspXrSqsJoOnkHfaxCJ90PGCNiA
Message-ID: <CAJZ5v0iBdmzD2ansm34HQhXQE+Q6_qUkjW1XC9xK_G8Aw_0ubQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: Optimize SMP calls in drv_write() function
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:17=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> The current drv_write() implementation performs redundant work by calling
> do_drv_write() on the current CPU and then issuing smp_call_function_many=
()
> to all CPUs in the mask, including the current CPU again. This results in
> duplicate MSR writes on the current CPU and unnecessary IPI overhead.

But smp_call_function_many() doesn't run func() on the local CPU, does it?

So what do you really do in this patch?

> Optimize the function by:
> - Executing do_drv_write() locally when current CPU is
>   in the target mask
> - Use a temporary mask to exclude the current CPU from
>   smp_call_function_many.
> - Falling back to smp_call_function_many() for the target
>   CPUs when current CPU is not in the target mask
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 4f7f9201598d..081d2d8a13da 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -330,6 +330,7 @@ static void drv_write(struct acpi_cpufreq_data *data,
>                       const struct cpumask *mask, u32 val)
>  {
>         struct acpi_processor_performance *perf =3D to_perf_data(data);
> +       struct cpumask tmp_mask;
>         struct drv_cmd cmd =3D {
>                 .reg =3D &perf->control_register,
>                 .val =3D val,
> @@ -338,10 +339,14 @@ static void drv_write(struct acpi_cpufreq_data *dat=
a,
>         int this_cpu;
>
>         this_cpu =3D get_cpu();
> -       if (cpumask_test_cpu(this_cpu, mask))
> +       if (cpumask_test_cpu(this_cpu, mask)) {
>                 do_drv_write(&cmd);
> +               cpumask_andnot(&tmp_mask, mask, cpumask_of(this_cpu));
> +               smp_call_function_many(&tmp_mask, do_drv_write, &cmd, 1);
> +       } else {
> +               smp_call_function_many(mask, do_drv_write, &cmd, 1);
> +       }
>
> -       smp_call_function_many(mask, do_drv_write, &cmd, 1);
>         put_cpu();
>  }
>
> --

