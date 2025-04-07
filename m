Return-Path: <linux-pm+bounces-24896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC6DA7EC79
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADD34472BB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5919256C9A;
	Mon,  7 Apr 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQEyrUFe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AF22256D;
	Mon,  7 Apr 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051609; cv=none; b=NB+BfaMIDcINsDnsRyY+6P/63GSnk97ClGL5Wj8BoNjcfXoXXnmyxbqdP0jHqJ/sbG5ovpadmEWcJhx2LX/mrkzslD5tzTebBqyR31EysOAYNnQLJI3cWeokfFICSfUOiZ0vhNEx5ey7LNTMQH/jmNi+nNJ15f+W0oOjpLzDi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051609; c=relaxed/simple;
	bh=mHnRQrUz+4kvAeo6aGycQsGqtBT2rI2fecmfh3LmTuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgvYTFtXyrd7tPvDyiwzgUyEAe0d/wxJpyDoAgbE+8wu2iH0toS1k9OSR5RW19rJ6P7NaaXj+0Lz1NRQnEE/y/olX7vheMt/8UZJzUU6YrgVxLhHKrCCWQ7j+Cn8ox4NUT4DVyKD9rB+IvNoJ7BZkDErq1X0J8WuKzGdEyFMUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQEyrUFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379F0C4CEEA;
	Mon,  7 Apr 2025 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051609;
	bh=mHnRQrUz+4kvAeo6aGycQsGqtBT2rI2fecmfh3LmTuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aQEyrUFejFBWiX5MQ+KtqSGSPBlyke8cXqyPg/yuXyoUWQW0178hMqT4lxEGazPr1
	 9w+A5ywp0zwyStwhXpn5lhJsxcqNaRbhCvn++ylSA26D5maUCgZN7nRgALGveuE1dy
	 hj2xrnQSw/L05YObx5q0ztufrLBZ+aD1654LCHJzjI4ogc2SaBmZuhM00psF/vcuYA
	 4Jt9LtK2JH4ATYTBzuykDhav0Ps8Fzu8smP0zHAEWD0/vxDtn+bi6e6BuMWt/kOoND
	 Y/u5FlIO4hm2ux9HJB85ItrM+ux8N9jUdiRsrljLyjkesC3EJ9/OT20z806QxEcPPj
	 pu5DJ3cDMxWjA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c12b7af278so3317181fac.0;
        Mon, 07 Apr 2025 11:46:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXE+YbBhQxtD5OhUW4w7Ia3pMHVG7w+7g4o8T1NPDlpq1WXvcVZq/pV/Wcp9wF1FjqObhxhjLnYnYoFNwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ztj2dRqG2RqNiE7KQVIWXWDmDWzsrfd8t7N0Fuczmfm7sV/X
	aurkh6eHYuOPtWkNoeAfyCwoAls8Jz3Zop5pKcFSbQLgynobJ504LipoY2IOJBZEkkUMO8g3Jjc
	wkc5Z8tvPmsTfl2siy+cqM3e6tF0=
X-Google-Smtp-Source: AGHT+IE2+vBTKe9EtPxXIZLDGFxhC67FMH7CpylNJaJ36uL2RJ7DxAR/F+bFIuPqDcZ+XNZbR2fTHA5JxJSyBht8Oek=
X-Received: by 2002:a05:6871:6183:b0:29e:5152:dab1 with SMTP id
 586e51a60fabf-2d064a73137mr318273fac.13.1744051608521; Mon, 07 Apr 2025
 11:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4651448.LvFx2qVVIh@rjwysocki.net> <2315023.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <2315023.iZASKD2KPV@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Apr 2025 20:46:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gSVd05e+Wtx9WuxW1ETAt=_z9pAyyg7oQzKD4LhrA89Q@mail.gmail.com>
X-Gm-Features: ATxdqUEtRSlzKEHxWBODwox92YuYeZYMboEOwjqSX-wnx9jwOv8J7S5FBu5R-6c
Message-ID: <CAJZ5v0gSVd05e+Wtx9WuxW1ETAt=_z9pAyyg7oQzKD4LhrA89Q@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] cpufreq: intel_pstate: Rearrange max frequency
 updates handling code
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 9:58=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Rename __intel_pstate_update_max_freq() to intel_pstate_update_max_freq()
> and move the cpufreq policy reference counting and locking into it (and
> implement the locking with the recently introduced cpufreq policy "write"
> locking guard).
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Hi Srinivas,

If you have any concerns regarding this patch, please let me know.

> ---
>  drivers/cpufreq/intel_pstate.c |   52 +++++++++++++---------------------=
-------
>  1 file changed, 17 insertions(+), 35 deletions(-)
>
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1353,9 +1353,16 @@
>                 cpufreq_update_policy(cpu);
>  }
>
> -static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
> -                                          struct cpufreq_policy *policy)
> +static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
>  {
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy);
> +
> +       policy =3D cpufreq_cpu_get(cpudata->cpu);
> +       if (!policy)
> +               return false;
> +
> +       guard(cpufreq_policy_write)(policy);
> +
>         if (hwp_active)
>                 intel_pstate_get_hwp_cap(cpudata);
>
> @@ -1363,44 +1370,24 @@
>                         cpudata->pstate.max_freq : cpudata->pstate.turbo_=
freq;
>
>         refresh_frequency_limits(policy);
> +
> +       return true;
>  }
>
>  static void intel_pstate_update_limits(unsigned int cpu)
>  {
> -       struct cpufreq_policy *policy =3D cpufreq_cpu_acquire(cpu);
> -       struct cpudata *cpudata;
> -
> -       if (!policy)
> -               return;
> -
> -       cpudata =3D all_cpu_data[cpu];
> -
> -       __intel_pstate_update_max_freq(cpudata, policy);
> -
> -       /* Prevent the driver from being unregistered now. */
> -       mutex_lock(&intel_pstate_driver_lock);
> +       struct cpudata *cpudata =3D all_cpu_data[cpu];
>
> -       cpufreq_cpu_release(policy);
> -
> -       hybrid_update_capacity(cpudata);
> -
> -       mutex_unlock(&intel_pstate_driver_lock);
> +       if (intel_pstate_update_max_freq(cpudata))
> +               hybrid_update_capacity(cpudata);
>  }
>
>  static void intel_pstate_update_limits_for_all(void)
>  {
>         int cpu;
>
> -       for_each_possible_cpu(cpu) {
> -               struct cpufreq_policy *policy =3D cpufreq_cpu_acquire(cpu=
);
> -
> -               if (!policy)
> -                       continue;
> -
> -               __intel_pstate_update_max_freq(all_cpu_data[cpu], policy)=
;
> -
> -               cpufreq_cpu_release(policy);
> -       }
> +       for_each_possible_cpu(cpu)
> +               intel_pstate_update_max_freq(all_cpu_data[cpu]);
>
>         mutex_lock(&hybrid_capacity_lock);
>
> @@ -1840,13 +1827,8 @@
>  {
>         struct cpudata *cpudata =3D
>                 container_of(to_delayed_work(work), struct cpudata, hwp_n=
otify_work);
> -       struct cpufreq_policy *policy =3D cpufreq_cpu_acquire(cpudata->cp=
u);
> -
> -       if (policy) {
> -               __intel_pstate_update_max_freq(cpudata, policy);
> -
> -               cpufreq_cpu_release(policy);
>
> +       if (intel_pstate_update_max_freq(cpudata)) {
>                 /*
>                  * The driver will not be unregistered while this functio=
n is
>                  * running, so update the capacity without acquiring the =
driver
>
>
>
>

