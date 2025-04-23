Return-Path: <linux-pm+bounces-26044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E50A98C90
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 16:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FF217B4A1
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD34279914;
	Wed, 23 Apr 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbKle2jl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604C262801;
	Wed, 23 Apr 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417711; cv=none; b=huqvml/ebFkO/kzofaENYa5o9whPbxwHBNYg1u5gy+0giF1Ztp+WN5EreHpVWqYDSlcEvzX3cCCI9GAVs3pcBVD4i+o2j7ACwjnzF5X7k4f+vrbpuENhpZMMag+J6uidVWJPWsaZ7lH4D6rL7Tm7aqS6VKNdZdJLxrek8lPH7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417711; c=relaxed/simple;
	bh=lZLc+0iQ0egQpFZzpGN61kWRDoQqmUE5Dgwzx88gqNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIoGro7eYMKIosRSRQkFWwyrzweKzDWX1ehZ//pw1yXcwcs3ZmYIieUQp5vqwCsyk2uPD8IO0V50ClybZE1WDc2ObS6e/PoqYPxiqAGukQkW+Zca40RWa0mmH9ib8qENeIv4mnjRRE3OoOACwQEfsv2D6/O5tB4VT83fC07XnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbKle2jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3454C4CEEB;
	Wed, 23 Apr 2025 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745417710;
	bh=lZLc+0iQ0egQpFZzpGN61kWRDoQqmUE5Dgwzx88gqNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fbKle2jl0QErU8ghTbj3sYn7CPDYSzV7RWs0s1cNIP9d5Q0EtDg2ooaFWjGzVL84t
	 jnQQJEztSxO5Is0L8uAMdKwBmnQq8BId7lazA1Z3plJM45E29XftxtDGERqrDr/ZTZ
	 I7kJSea7R1h+Q6db7wlqZlWg+yaHnW8E9TOShNxrjIhrsdJ2/UOCQZfa13ykIq2ZIF
	 48L0aBklhq4gMXZ4bCrMsehMZvY2rGUZfbc464bbZFyGIxwSoq1xXriOwXeKvZT/eS
	 8AnvML/cCKW1XcVCVQMJprXIweoiWSf2ORWa+pYxYW66DAgm2gCSGRoOPdH6IIEwfG
	 kj2+kpEm+2eDQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so1741769fac.2;
        Wed, 23 Apr 2025 07:15:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV456AS0enbezTXD/MlTVUeViMfT3+jrg2AL1Qcg6FKxVII1dYJuSc/9vwObuR81pkA9cD03HuHDM8=@vger.kernel.org, AJvYcCWBDxaWP07qgAzq1q5MwWlRQ/NX4+r2avl/OHDKqcqzbcgWcQ9QK4y8lkdGDJ62seHsrv67z0m/X0UEw8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8oiSLiifX1uWBtMLvVDPzI20Mf8dq5UK4QdMrww4AZYjGbJ+
	vCiHfULRI19IRpk8ztDOFZxOKmWdjiE+5eeiT5SAmMu+v4rRWZuKuXOWMIRwwaqugr8XjWABvKG
	suZ2yIT+86NqoNiJ0hQs66+JZNsc=
X-Google-Smtp-Source: AGHT+IFttgT2cMzJ7Q/jyjhyBdMlJ6r4LNKEGwvkEg1MSYOwmaGGPnBPqqiXRNbn1Ybe+h0ttBpAz7iPzOrDBOQ3SUM=
X-Received: by 2002:a05:6870:451:b0:29e:433f:aa4f with SMTP id
 586e51a60fabf-2d526d6952bmr11393439fac.30.1745417709199; Wed, 23 Apr 2025
 07:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745315548.git.viresh.kumar@linaro.org> <7ce4ffb166beef83cf1bd703a41bf91622011585.1745315548.git.viresh.kumar@linaro.org>
In-Reply-To: <7ce4ffb166beef83cf1bd703a41bf91622011585.1745315548.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 16:14:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCrQeKs=4S-x83Fgf-W4u=2JYLA5VmgKPaLCvYAkNpig@mail.gmail.com>
X-Gm-Features: ATxdqUFjSCZMsgE0COHebVl5-LQCwtzGxnUc_24h28YU6lomS4arrllqkqRn0Wk
Message-ID: <CAJZ5v0iCrQeKs=4S-x83Fgf-W4u=2JYLA5VmgKPaLCvYAkNpig@mail.gmail.com>
Subject: Re: [PATCH 1/6] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Nicholas Chin <nic.c3.14@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:54=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> The boost-related code in cpufreq has undergone several changes over the
> years, but this particular piece remained unchanged and is now outdated.
>
> The cpufreq core currently manages boost settings during initialization,
> and only when necessary. As such, there's no longer a need to enable
> boost explicitly when entering system suspend.
>
> Previously, this wasn=E2=80=99t causing issues because boost settings wer=
e
> force-updated during policy initialization. However, commit 2b16c631832d
> ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()") changed
> that behavior=E2=80=94correctly=E2=80=94by avoiding unnecessary updates.
>
> As a result of this change, if boost was disabled prior to suspend, it
> remains disabled on resume as expected. But due to the current code
> forcibly enabling boost at suspend time, the system ends up with boost
> frequencies enabled after resume, even if the global boost flag was
> disabled. This contradicts the intended behavior.
>
> Don't enable boost on policy exit.

Even after commit 2b16c631832d, the code removed by this patch does a
useful thing.  Namely, it clears the boost-disable bit in the MSR so
that the offline CPU doesn't prevent online CPUs from getting the
boost (in case the boost settings change after it has been taken
offline).  It doesn't actually touch policy->boost_enabled etc, just
that particular bit in the MSR.

I'm not sure how this useful thing will be done after the $subject patch.

Moreover, without the $subject patch, the change made by the next one
will cause the boost setting in the MSR to get back in sync with
policy->boost_enabled during online AFAICS, so why exactly is the
$subject patch needed?

> Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu=
_init()")
> Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220013
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> This was sent separately earlier. No changes from that.
>
>  drivers/cpufreq/acpi-cpufreq.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 924314cdeebc..7002e8de8098 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -89,8 +89,9 @@ static bool boost_state(unsigned int cpu)
>         return false;
>  }
>
> -static int boost_set_msr(bool enable)
> +static void boost_set_msr_each(void *p_en)
>  {
> +       bool enable =3D (bool)p_en;
>         u32 msr_addr;
>         u64 msr_mask, val;
>
> @@ -107,7 +108,7 @@ static int boost_set_msr(bool enable)
>                 msr_mask =3D MSR_K7_HWCR_CPB_DIS;
>                 break;
>         default:
> -               return -EINVAL;
> +               return;
>         }
>
>         rdmsrl(msr_addr, val);
> @@ -118,14 +119,6 @@ static int boost_set_msr(bool enable)
>                 val |=3D msr_mask;
>
>         wrmsrl(msr_addr, val);
> -       return 0;
> -}
> -
> -static void boost_set_msr_each(void *p_en)
> -{
> -       bool enable =3D (bool) p_en;
> -
> -       boost_set_msr(enable);
>  }
>
>  static int set_boost(struct cpufreq_policy *policy, int val)
> @@ -532,15 +525,6 @@ static void free_acpi_perf_data(void)
>         free_percpu(acpi_perf_data);
>  }
>
> -static int cpufreq_boost_down_prep(unsigned int cpu)
> -{
> -       /*
> -        * Clear the boost-disable bit on the CPU_DOWN path so that
> -        * this cpu cannot block the remaining ones from boosting.
> -        */
> -       return boost_set_msr(1);
> -}
> -
>  /*
>   * acpi_cpufreq_early_init - initialize ACPI P-States library
>   *
> @@ -931,7 +915,6 @@ static void acpi_cpufreq_cpu_exit(struct cpufreq_poli=
cy *policy)
>
>         pr_debug("%s\n", __func__);
>
> -       cpufreq_boost_down_prep(policy->cpu);
>         policy->fast_switch_possible =3D false;
>         policy->driver_data =3D NULL;
>         acpi_processor_unregister_performance(data->acpi_perf_cpu);
> --
> 2.31.1.272.g89b43f80a514
>

