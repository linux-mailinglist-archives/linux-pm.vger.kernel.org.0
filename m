Return-Path: <linux-pm+bounces-26233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69804A9CE2B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 18:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0A54C5EB9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B1194C86;
	Fri, 25 Apr 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOfzTKB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68320146D6A;
	Fri, 25 Apr 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598648; cv=none; b=G/V+UEDNmwucNnkr0Lhhjgv7EcWIU9JOSz7RWzKSfd017ZnTntafT6//CnVjfZezLuUTYIUfj7nxFQ1Ncta/NcleqI2swyNBpt+0uFTvbaE8EDz3Al+Tbxu4nPsfYsqGWhhZw29Vta4mIWgR2vQ9zPaK9VSgtObPkSCv3fvTI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598648; c=relaxed/simple;
	bh=ZVOH0fGJ+NNMBDhLqyv661QsoghbN4nluN8aYFDUn3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFMRaBO5cd6Ptuj9JzPMSvHPULvxxqj2sDkBvLnz1JFnACp4ZGnoxDiOeu/BH0XJhO1vWc/M/2oybbBfNbyD3CWohjP5In6D9j5gdtft2fuSc4ZBWBIYe+rXLflM64kkH+xMmZ5ngaupUdTSfQKyFj5Nbs8FNwzMYdACJ08x45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOfzTKB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A45C4CEE8;
	Fri, 25 Apr 2025 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745598647;
	bh=ZVOH0fGJ+NNMBDhLqyv661QsoghbN4nluN8aYFDUn3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TOfzTKB2E/ncXeGCdcTniBwqJXhvGy+Zda87lmuRV9ujRJ1yUwrf+PKm3uQVz0OrV
	 4HcCaqlq1GSnSn/YUCHwIkSrawS6KIVuwDu8dg1WGNHVanNfaEGm933paX8yNAoV4x
	 ES9/dNf4rcSZ5sGKReNMxRa6stiU2OjlyRbnCnDkwDxYJOtRcDHBQL1/pWDJjJd5jp
	 hSVLknGVq+JqAIjD02qee2EgaVJIgKvwjhmQFcYEwaiiCQX3k8B7GYoqXWLn6aG7cj
	 z2ZZbzf37JrjX4V4Z10VVk9gQ5diPOzsEk6m/ZE8zydicfw3gVcXhCylLodwE6Oa60
	 oZVzQV/jVjy4A==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-401e77e5443so1534096b6e.3;
        Fri, 25 Apr 2025 09:30:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhuTy+fFPnAyO7afR3Decebupa9snveVsm3xfXZkHNtDtPjEmIcvqtYjkS8RbfGqcTCHghYEeGFPM=@vger.kernel.org, AJvYcCVBMnN+GYawl+VM3VBHJsidCz11yntvPhKiv5fVWrXV/AhfSlynm7UxLbCK39O3+67MykDIUbuS0BtaSJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7J9gP3Ddsq/+/1iKvupiofhlPCMxJ+bD0oZm7rZuAssUcWXuU
	rI2UKXgjeKIrGalVDtpRZqjlo1wSA0L96lvsaxeh54HNsUCD42X1549XStIj1hsEVDF1B79HSIz
	tYI5w2zSSriwZpRb1YwosyEFU3/0=
X-Google-Smtp-Source: AGHT+IHIIywKL5CeFQsvH24NdW1NI0V/XAkgf7084BRpxorSkIfA89Z5n/cX/UPU3V8arOottYtsMIvsy1kXs+mVaxU=
X-Received: by 2002:a05:6870:b156:b0:2d4:ef88:97bb with SMTP id
 586e51a60fabf-2d99d7520c7mr1872783fac.1.1745598647182; Fri, 25 Apr 2025
 09:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745511526.git.viresh.kumar@linaro.org> <9c7de55fb06015c1b77e7dafd564b659838864e0.1745511526.git.viresh.kumar@linaro.org>
In-Reply-To: <9c7de55fb06015c1b77e7dafd564b659838864e0.1745511526.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Apr 2025 18:30:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jW+ivsWjMgwaQKmhNxxz2wByYuLQL7i-hRamjH2We+8g@mail.gmail.com>
X-Gm-Features: ATxdqUFKf17uuUP6FxDVeRUPULk3MU-swqAjg0ZkDyVNq3xjwkmwUX6IuG3OyJg
Message-ID: <CAJZ5v0jW+ivsWjMgwaQKmhNxxz2wByYuLQL7i-hRamjH2We+8g@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] cpufreq: acpi: Re-sync CPU boost state on system resume
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Nicholas Chin <nic.c3.14@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:20=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> During CPU hotunplug events (such as those occurring during
> suspend/resume cycles), platform firmware may modify the CPU boost
> state.
>
> If boost was disabled prior to CPU removal, it correctly remains
> disabled upon re-plug. However, if firmware re-enables boost while the
> CPU is offline, the CPU may return with boost enabled=E2=80=94even if it =
was
> originally disabled=E2=80=94once it is hotplugged back in. This leads to
> inconsistent behavior and violates user or kernel policy expectations.
>
> To maintain consistency, ensure the boost state is re-synchronized with
> the kernel policy when a CPU is hotplugged back in.
>
> Note: This re-synchronization is not necessary during the initial call
> to ->init() for a CPU, as the cpufreq core handles it via
> cpufreq_online(). At that point, acpi_cpufreq_driver.boost_enabled is
> initialized to the value returned by boost_state(0).
>
> Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu=
_init()")
> Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220013
> Tested-by: Nicholas Chin <nic.c3.14@gmail.com>
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I gather that this patch is for 6.15 and the rest of the series is for
6.16, so applied accordingly.

> ---
>  drivers/cpufreq/acpi-cpufreq.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 924314cdeebc..d26b610e4f24 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -909,8 +909,19 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_poli=
cy *policy)
>         if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].freq=
uency)
>                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
>
> -       if (acpi_cpufreq_driver.set_boost)
> -               policy->boost_supported =3D true;
> +       if (acpi_cpufreq_driver.set_boost) {
> +               if (policy->boost_supported) {
> +                       /*
> +                        * The firmware may have altered boost state whil=
e the
> +                        * CPU was offline (for example during a suspend-=
resume
> +                        * cycle).
> +                        */
> +                       if (policy->boost_enabled !=3D boost_state(cpu))
> +                               set_boost(policy, policy->boost_enabled);
> +               } else {
> +                       policy->boost_supported =3D true;
> +               }
> +       }
>
>         return result;
>
> --
> 2.31.1.272.g89b43f80a514
>

