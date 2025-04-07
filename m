Return-Path: <linux-pm+bounces-24897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BFAA7EC75
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 21:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621841884ABE
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA2265CAF;
	Mon,  7 Apr 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJe6Z253"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861D265CAA;
	Mon,  7 Apr 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051719; cv=none; b=ua7afTlOpq0KIi1n+f4B6rtdJ0f0A+5ornRtujzJKFbmH4QeC2tViz3bZePXVs7K+7dESLp9iuvn6VXpNjthdY2EiuGRXiwi3M+j8chIqY8VF0v1ny2sgPlbtUkdz93jhNm1HH7p8CRNt25O0+Sxxryn7ZHG+wjFVT0+KB1yiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051719; c=relaxed/simple;
	bh=BLCsZfMlmMhyQ/8BEjb8uHOKjFKoD5yX+WqdA4NIZ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDKsfa9KtSVGQBvVq0G+Yc9X56lSCKtj8xM0M8PgiJMmaNVvRsU35xcLLdQdT2rU31Ae0UsmmsMuOzmpYUed7Q9FaB090Cz6HrwJwEI4UZak0Bq+oUWdinIWJFRtwA/4u8Uc/Xrw03umUWaUE9ja5BhkRQR569o0awAZI1C0Bnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJe6Z253; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246DAC4CEDD;
	Mon,  7 Apr 2025 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051719;
	bh=BLCsZfMlmMhyQ/8BEjb8uHOKjFKoD5yX+WqdA4NIZ/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EJe6Z253AA/oSHZLuPl/J6JKpsmnk+AzVN/N793dskIFALKNAJwpmE7CAlA4wCn6H
	 mpfrn/09SS9/uCN8t9ewYdJc7qT/zWUoULKuGrTCW1K5Hc8ul6nbFVZdyrhEk0Acre
	 k5IgujQ15xryG5GlS6Wb9N8TtmSTWgtNoLvWBeh3GT6XY0Y0/tyJlNIhv1gJsOfFwg
	 NSTlmrj0bhIckM0u8FDMy+tkDoCwixx7HTthQJnUAWHrrBjuksbQ5OnH0D7ehCjiHv
	 17nv+eG/lFmw4Mx1Tj3TUxsAvb22LV2tCzhy+vuNwDftIOheoYgzvWVHNFOLK6gJZ/
	 U7XtJWgS9Qjkg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c7b2c14455so3192429fac.2;
        Mon, 07 Apr 2025 11:48:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV12ZzyXm3FqhPYGVOlDSTFd940wDQXd1nMyDWOIvxuweSMB6fJrggTF5sjwIw9XZlCyufbURtGTeGX6KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMEnsuGcFusgOHMTsVfQWGVn09vbx4mxpUXH9Xrga52oMifTdb
	fKInnc1E9zDQF1YxHfFbnB4nFdKrEzdb8wtPN3JzJkZ+vW1D+BVd9TbFOEH/RU/QWF1aeaeOIDn
	5mGaeApR8VUTHmqoG5sSckgBIsLk=
X-Google-Smtp-Source: AGHT+IFrqlHqRYH87UcQwF4jmAs00nMOADUhfEmbJ0+JBk41kaHnZhqMrZQ7+hARpldminEFJC2jf/8TlhdhVZVtJMo=
X-Received: by 2002:a05:6870:ecab:b0:2bd:456c:923 with SMTP id
 586e51a60fabf-2cc9e59c5fcmr7891241fac.11.1744051718492; Mon, 07 Apr 2025
 11:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4651448.LvFx2qVVIh@rjwysocki.net> <8560367.NyiUUSuA9g@rjwysocki.net>
In-Reply-To: <8560367.NyiUUSuA9g@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Apr 2025 20:48:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMYSTnX9mkZb8aEmtbKxWOgsshNJ_AqnB9Mn27y8jzeQ@mail.gmail.com>
X-Gm-Features: ATxdqUH1BaGEagIbW7krbv_XHndcRweKBMxNf5P6IVT2_wOv-gox_ZQ12i4ef3E
Message-ID: <CAJZ5v0iMYSTnX9mkZb8aEmtbKxWOgsshNJ_AqnB9Mn27y8jzeQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] cpufreq: Pass policy pointer to ->update_limits()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 9:49=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since cpufreq_update_limits() obtains a cpufreq policy pointer for the
> given CPU and reference counts the corresponding policy object, it may
> as well pass the policy pointer to the cpufreq driver's ->update_limits()
> callback which allows that callback to avoid invoking cpufreq_cpu_get()
> for the same CPU.
>
> Accordingly, redefine ->update_limits() to take a policy pointer instead
> of a CPU number and update both drivers implementing it, intel_pstate
> and amd-pstate, as needed.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Hi Srinivas,

If you have any concerns regarding this patch, please let me know
(note that it is based on the [05/10]).

> ---
>  drivers/cpufreq/amd-pstate.c   |    7 ++-----
>  drivers/cpufreq/cpufreq.c      |    2 +-
>  drivers/cpufreq/intel_pstate.c |   29 ++++++++++++++++++-----------
>  include/linux/cpufreq.h        |    2 +-
>  4 files changed, 22 insertions(+), 18 deletions(-)
>
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -821,19 +821,16 @@
>         schedule_work(&sched_prefcore_work);
>  }
>
> -static void amd_pstate_update_limits(unsigned int cpu)
> +static void amd_pstate_update_limits(struct cpufreq_policy *policy)
>  {
> -       struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpuf=
req_cpu_get(cpu);
>         struct amd_cpudata *cpudata;
>         u32 prev_high =3D 0, cur_high =3D 0;
>         bool highest_perf_changed =3D false;
> +       unsigned int cpu =3D policy->cpu;
>
>         if (!amd_pstate_prefcore)
>                 return;
>
> -       if (!policy)
> -               return;
> -
>         if (amd_get_highest_perf(cpu, &cur_high))
>                 return;
>
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2741,7 +2741,7 @@
>                 return;
>
>         if (cpufreq_driver->update_limits)
> -               cpufreq_driver->update_limits(cpu);
> +               cpufreq_driver->update_limits(policy);
>         else
>                 cpufreq_policy_refresh(policy);
>  }
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1353,14 +1353,9 @@
>                 cpufreq_update_policy(cpu);
>  }
>
> -static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
> +static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy=
,
> +                                          struct cpudata *cpudata)
>  {
> -       struct cpufreq_policy *policy __free(put_cpufreq_policy);
> -
> -       policy =3D cpufreq_cpu_get(cpudata->cpu);
> -       if (!policy)
> -               return false;
> -
>         guard(cpufreq_policy_write)(policy);
>
>         if (hwp_active)
> @@ -1370,16 +1365,28 @@
>                         cpudata->pstate.max_freq : cpudata->pstate.turbo_=
freq;
>
>         refresh_frequency_limits(policy);
> +}
> +
> +static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
> +{
> +       struct cpufreq_policy *policy __free(put_cpufreq_policy);
> +
> +       policy =3D cpufreq_cpu_get(cpudata->cpu);
> +       if (!policy)
> +               return false;
> +
> +       __intel_pstate_update_max_freq(policy, cpudata);
>
>         return true;
>  }
>
> -static void intel_pstate_update_limits(unsigned int cpu)
> +static void intel_pstate_update_limits(struct cpufreq_policy *policy)
>  {
> -       struct cpudata *cpudata =3D all_cpu_data[cpu];
> +       struct cpudata *cpudata =3D all_cpu_data[policy->cpu];
> +
> +       __intel_pstate_update_max_freq(policy, cpudata);
>
> -       if (intel_pstate_update_max_freq(cpudata))
> -               hybrid_update_capacity(cpudata);
> +       hybrid_update_capacity(cpudata);
>  }
>
>  static void intel_pstate_update_limits_for_all(void)
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -399,7 +399,7 @@
>         unsigned int    (*get)(unsigned int cpu);
>
>         /* Called to update policy limits on firmware notifications. */
> -       void            (*update_limits)(unsigned int cpu);
> +       void            (*update_limits)(struct cpufreq_policy *policy);
>
>         /* optional */
>         int             (*bios_limit)(int cpu, unsigned int *limit);
>
>
>
>

