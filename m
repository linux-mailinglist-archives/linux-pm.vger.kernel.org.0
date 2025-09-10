Return-Path: <linux-pm+bounces-34353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A604B51416
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 12:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967C87BD5D3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939643164D1;
	Wed, 10 Sep 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxlXJBtZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A23164C0;
	Wed, 10 Sep 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500018; cv=none; b=kQHt3Tbf/1yAJCH4UlS2oSrhe0u+vdNyzwlCPA2IgE3BW/xUFzaryaG23yUVoKCUR0EXLu6bKOIhU4kyAZZl9V2s9d9ni7ytImUZ+v63oO4dmypOHv/PbVmqNwWUMMugkTXC8ngarEGhuah689vnc/mWNUUTJrdZWpSpTSR5d58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500018; c=relaxed/simple;
	bh=bDfRAQYYJeFwDu+iCdyQBIBE3rcoxBIvTJMBJoSMxKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYGpTXgaWsA4Rv7fMi8CElh2auFbtoaEX2sUH09BG7T6JWJ+lFb95jox6h0uAIQqSIKSO9zAoXb1N14pn5U1xublzV6jh5hnyPbipryDS7uB5d/Xvl1gjKHI7xjILdX3HgZRdAogCW+v33YFPBHtp1juQtcxSYrt0JmBIseHe2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxlXJBtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01037C4CEF0;
	Wed, 10 Sep 2025 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757500018;
	bh=bDfRAQYYJeFwDu+iCdyQBIBE3rcoxBIvTJMBJoSMxKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uxlXJBtZXrPyR0/fdSiywoBa+aXpaOXLPreyDaSCg6mirW8FPDPWRMHMkpY0THeI3
	 6FwUI2Jhsg3WaNZYYSXf7vcICsFhtQ8SwZGCdkZ5r3NXOv9Kl4F/n/Hupv0dC/98D9
	 tBChFGwLy3vjBO6hQ7y+1mpKac7Uq9dtyYx6AefQAMTieHqPJ4LDG6bVWhhAf8QUc/
	 wLXUPp/8nkbPfsMQBcDJdrsR5rCAULH2iy45POzhQaXl6lc8hUjVMvygo/IKr2kaXo
	 L8GBTReFj7keYV8Lk5wcy5EHrl98F15kTQVDgGus3qw9CifonPDc9EhHqxJgGlpgYo
	 ka0zKxrFTdIww==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-62182f350ddso2289041eaf.3;
        Wed, 10 Sep 2025 03:26:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUES53T9ZOUMD9L5J30rh+NT31GgNZr1gwr8xo47SacdpWG9S6Qyph6q/LpMc/8gnF3bQKhIgiEc54=@vger.kernel.org, AJvYcCULs7h3kIYWf7Cb4K/m7CLkLwbW51Us4YDlmr8ItYwd+xTtdiB+6Lfp6mlRLxwmM3gH7X6yErBRHL/QaFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37dCUu4P/Qo+gwvDLo6uaQ9WMjM1k6nreoOK9c8dShw0obV6V
	EsaG2XCaRjlP29H17FAZWDjCxnhbNHJApWexG4th/qz9msV/krsQY4IekkjgGdbNyN9plH/AhxM
	kUxiEXmVbsnNYo/u9ri+xfdlaS3IQXPY=
X-Google-Smtp-Source: AGHT+IEW1ZMJYmF6fePsBwm2GCT1JKTtlATrU+IU3wp5hSKaQdIZweJd49rKiN9bwXqO9xNq7YIri6kNCsNL4ZS3CAg=
X-Received: by 2002:a05:6820:2293:b0:621:71a0:5b67 with SMTP id
 006d021491bc7-62178a9c5b3mr6831201eaf.7.1757500012941; Wed, 10 Sep 2025
 03:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908230655.2562440-1-sohil.mehta@intel.com>
In-Reply-To: <20250908230655.2562440-1-sohil.mehta@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 12:26:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i3B9LQmU-o5Reh6T+sVEPeGqMvEf7f_3Wdh6jc+sRBeA@mail.gmail.com>
X-Gm-Features: Ac12FXyY-gpWX307z-g_sZf8fnXHzp98YH9CeYGgxf7ItUtBMs4z60VBBzSvkHI
Message-ID: <CAJZ5v0i3B9LQmU-o5Reh6T+sVEPeGqMvEf7f_3Wdh6jc+sRBeA@mail.gmail.com>
Subject: Re: [PATCH v4] cpufreq: ondemand: Update the efficient idle check for
 Intel extended Families
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	x86@kernel.org, Tony Luck <tony.luck@intel.com>, Zhao Liu <zhao1.liu@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:08=E2=80=AFAM Sohil Mehta <sohil.mehta@intel.com> =
wrote:
>
> IO time is considered busy by default for modern Intel processors. The
> current check covers recent Family 6 models but excludes the brand new
> Families 18 and 19.
>
> According to Arjan van de Ven, the model check was mainly due to a lack
> of testing on systems before INTEL_CORE2_MEROM. He suggests considering
> all Intel processors as having an efficient idle.
>
> Extend the IO busy classification to all Intel processors starting with
> Family 6, including Family 15 (Pentium 4s) and upcoming Families 18/19.
>
> Use an x86 VFM check and move the function to the header file to avoid
> using arch-specific #ifdefs in the C file.
>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Applied (with a minor whitespace adjustment) as 6.18 material, thanks!

> ---
> v4:
>  - Move the function check to the header file as an inline function.
>  - Combine x86 specific #ifdefs.
>
> v3: https://lore.kernel.org/lkml/20250826183644.220093-1-sohil.mehta@inte=
l.com/
>  - Posting this patch separately since the core family cleanup series
>    was merged without it.
>  - Improve commit message and code comments.
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 25 +------------------------
>  drivers/cpufreq/cpufreq_ondemand.h | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq=
_ondemand.c
> index 0e65d37c9231..a6ecc203f7b7 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -29,29 +29,6 @@ static struct od_ops od_ops;
>
>  static unsigned int default_powersave_bias;
>
> -/*
> - * Not all CPUs want IO time to be accounted as busy; this depends on ho=
w
> - * efficient idling at a higher frequency/voltage is.
> - * Pavel Machek says this is not so for various generations of AMD and o=
ld
> - * Intel systems.
> - * Mike Chan (android.com) claims this is also not true for ARM.
> - * Because of this, whitelist specific known (series) of CPUs by default=
, and
> - * leave all others up to the user.
> - */
> -static int should_io_be_busy(void)
> -{
> -#if defined(CONFIG_X86)
> -       /*
> -        * For Intel, Core 2 (model 15) and later have an efficient idle.
> -        */
> -       if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
> -                       boot_cpu_data.x86 =3D=3D 6 &&
> -                       boot_cpu_data.x86_model >=3D 15)
> -               return 1;
> -#endif
> -       return 0;
> -}
> -
>  /*
>   * Find right freq to be set now with powersave_bias on.
>   * Returns the freq_hi to be used right now and will set freq_hi_delay_u=
s,
> @@ -377,7 +354,7 @@ static int od_init(struct dbs_data *dbs_data)
>         dbs_data->sampling_down_factor =3D DEF_SAMPLING_DOWN_FACTOR;
>         dbs_data->ignore_nice_load =3D 0;
>         tuners->powersave_bias =3D default_powersave_bias;
> -       dbs_data->io_is_busy =3D should_io_be_busy();
> +       dbs_data->io_is_busy =3D od_should_io_be_busy();
>
>         dbs_data->tuners =3D tuners;
>         return 0;
> diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq=
_ondemand.h
> index 1af8e5c4b86f..eb35ec19fa86 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.h
> +++ b/drivers/cpufreq/cpufreq_ondemand.h
> @@ -24,3 +24,25 @@ static inline struct od_policy_dbs_info *to_dbs_info(s=
truct policy_dbs_info *pol
>  struct od_dbs_tuners {
>         unsigned int powersave_bias;
>  };
> +
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +/*
> + * Not all CPUs want IO time to be accounted as busy; this depends on
> + * how efficient idling at a higher frequency/voltage is.
> + *
> + * Pavel Machek says this is not so for various generations of AMD and
> + * old Intel systems. Mike Chan (android.com) claims this is also not
> + * true for ARM.
> + *
> + * Because of this, select a known series of Intel CPUs (Family 6 and
> + * later) by default, and leave all others up to the user.
> + */
> +static inline bool od_should_io_be_busy(void)
> +{
> +       return (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
> +               boot_cpu_data.x86_vfm >=3D INTEL_PENTIUM_PRO);
> +}
> +#else
> +static inline bool od_should_io_be_busy(void) { return false; }
> +#endif
> --
> 2.43.0
>

