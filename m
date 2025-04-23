Return-Path: <linux-pm+bounces-26049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6ADA98CFE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEEA3BC805
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6505627CB35;
	Wed, 23 Apr 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI4RAf3j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD0B143736;
	Wed, 23 Apr 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418411; cv=none; b=qEy4LNuQq4dXEIhgq5xRPU3kijjeKF0ifkVFt8rrcEvn5LfHbi573tB5pVaw6IyN336DLQzzR0GfllDSKtDYRVG9g1o7Bj5Oy2oWzPN+/KMktgaO0t2OkucFesLuRs04QuiZAnGB+40Fr/xY+xiw+RvzPlGXT9ZIusDvOOGHhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418411; c=relaxed/simple;
	bh=YQYhn8HZx7ubPYTlNSiK99ntMYepg0AMRX7OXqpob3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqBA5RbjzZEyrKeL3Q/GwUxGjT46AIOIIIJtURmHaNaEsSCHMOQjAv7B7cgga9jiDMTMYkpfRCICMBklcCWYe34aCu3NWDRiVBNjsks1cYkoU10HzrTG5iNXv/I1eZSyNN89CZlPO72Og5UEJjj37KYxK1nwH77VNs7YFkV8Peo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI4RAf3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7652C4CEE3;
	Wed, 23 Apr 2025 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418410;
	bh=YQYhn8HZx7ubPYTlNSiK99ntMYepg0AMRX7OXqpob3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oI4RAf3j4M1r2VV6NRgs1xBOJEm2flOIoypXVAMl1a1YvNUbGNE84IEzxCTuVm6GU
	 pW+qYfhxnSaHqbWYoPkJrnTod7niNrZtYOcDI5DauZVoXHqrvGintx4D9IPYZaXj8G
	 OP4amihUP6Q21gQMpm2qrKvzwPYHAzII5oWrvNL5ygDMED+N8owCNRs/Vj0/PS0oBW
	 j45EJfKEzEuvL0kQcipUPF3FrbQKU6DkiQ33rQFPaKpB7zQuEtX5FjSt/RJYx6wwAv
	 2hYXwW5Tb1aj3rKPirsgIpgoMnqaX5GnhFUPV2Uce62CwkiIjyCNCSXkwuY8BlcgU+
	 6bZriRBFBABJw==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f6a92f234dso4069163b6e.3;
        Wed, 23 Apr 2025 07:26:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVHT6NKQngTyRf+MS+TjRgMKzP0Z5hrWWPaghlasHX3WPdmbliJW40WCWhNIUwHDretu+7Oa3V9paLX8E=@vger.kernel.org, AJvYcCVr2A60j0M7y/7s/DfO/sWT0HE6kbwk7RtikCxj78I5WB5IM6Ms+OLFJw7+l3ZgubpnN1RfD90PoOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wNduIhZYHVvtvWLW2AKxcPWXtPiNv6CITUXJ27jUuMujewAH
	Ih08+W1AdMzzojiUplGfFLAugD895Os6HlfEff2Ugk9uFbnUbdWUxEBquylZbKgreOIfRNUy9sh
	nF/LgjYsTAf0cyYHQ0paxxjkO8wo=
X-Google-Smtp-Source: AGHT+IF86QSYcG4iBnR8KfUoSgrDuxUjBg1Hhrec5DRZmfTgDqFoRXL12KcMeRoA1Yl8dkNcre81jhSzAziC3JcdFNc=
X-Received: by 2002:a05:6871:741d:b0:2d4:e101:13dd with SMTP id
 586e51a60fabf-2d526979cc4mr12643088fac.1.1745418410039; Wed, 23 Apr 2025
 07:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745315548.git.viresh.kumar@linaro.org> <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
In-Reply-To: <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 16:26:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hWUdRdbPL2=qybaEsNfPzAqdxW+xBrjwy4HaBXnTwD0g@mail.gmail.com>
X-Gm-Features: ATxdqUGtzCcRuzs8_RMtDyNBoI0AmDx05VZ1ZJDD6JW5HMnWEgCwZuUfEuq10rY
Message-ID: <CAJZ5v0hWUdRdbPL2=qybaEsNfPzAqdxW+xBrjwy4HaBXnTwD0g@mail.gmail.com>
Subject: Re: [PATCH 2/6] cpufreq: acpi: Re-sync CPU boost state on system resume
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Nicholas Chin <nic.c3.14@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:54=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> During suspend/resume cycles, platform firmware may alter the CPU boost
> state.
>
> If boost is disabled before suspend, it correctly remains off after
> resume. However, if firmware re-enables boost during suspend, the system
> may resume with boost frequencies enabled=E2=80=94even when the boost fla=
g was
> originally disabled. This violates expected behavior.
>
> Ensure the boost state is re-synchronized with the kernel policy during
> system resume to maintain consistency.
>
> Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu=
_init()")
> Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220013
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 7002e8de8098..0ffabf740ff5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -893,8 +893,19 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_poli=
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

IIUC policy->boost_enabled is false at this point, so say that
boost_state(cpu) returns true and say cpufreq_boost_enabled() returns
false.

cpufreq_online() will see policy->boost_enabled =3D=3D
cpufreq_boost_enabled(), so it won't do anything regarding boost, and
say that this happens for all online CPUs.

cpufreq_boost_enabled() will be false, policy->boost_enabled will be
false for every policy, but boost will be effectively enabled AFAICS.

> +               }
> +       }
>
>         return result;
>
> --

