Return-Path: <linux-pm+bounces-19432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09D9F691E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C906C188C024
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4D1C5CA5;
	Wed, 18 Dec 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlE8WdHN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056E1C5CDD;
	Wed, 18 Dec 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533453; cv=none; b=gb3sJGAj8k8m+j1kWuGzyy8JJoxQThltt5FY0hivMZiubEA+4NpV7vfbYam99vnUjqjOUJNUue5fNYrbh8WnKlmkodQ0KiphZdVt41gGwsDwT+p0U0WHImDs4lHxoO7/wtB1GTmMjD9JU3Q7P8/aPxB6AFFFoPDqFmyqJNMeo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533453; c=relaxed/simple;
	bh=/50/8IJJMmFHD8jKVgG7p2IUzFRamEPAHKtLqItSCXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsWT0oSKHoGEavu+2A2wTYXvuEXH/gNTyY0kLoHt9ipPxH1d7u9dxGnJk8Jn6Fzr3Nb4HiC9Tk+IZ1UY/PyQtFqZSCVhrnIg0ATa2kdKbZOqeQ9JrNZ1xhICzLYPgo9HJ2F365Nh7Pxbz/LnKEl+5oeOlOivlJbx5EzVQBCnB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlE8WdHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAB9C4CED4;
	Wed, 18 Dec 2024 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734533453;
	bh=/50/8IJJMmFHD8jKVgG7p2IUzFRamEPAHKtLqItSCXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OlE8WdHN0K68rijgdk7aDjrrROyP81rnI2jEzAkWYFsi8mXn5RY+WE4wvOorMxj18
	 at12MIxV3fSwwSGtPCdmM5793hpALulRYGzxdKuTgNHMMFVPkOEuIEPBTQznJP8+jh
	 9h0ruEy5StOxIcKG6HcwTQyZ59tKO2iuonkCjFX1kxSzn8BQoMWLED4dSevzaA5F76
	 3BkLBQWJ+qeVt+qns8kGfoVLejeVXsdG9tOvfOBMFPVWde4OTA5GCA279a9T65UOEO
	 q6H42hFKg+ouVLfVw+1ZIFxHUOa/Yli3IMwGwxX2DItsNn3Q7ZvwxXyX2clfuig24d
	 I0vI7h6sKkohQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ebb1652729so2532625b6e.3;
        Wed, 18 Dec 2024 06:50:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV977B3BxQ3DVE0SbyfnTKzIBHmSs52X7L9N+U/3DLvo+vX6J7HNvlCoqsi0B50PzJkg359xBebiM4=@vger.kernel.org, AJvYcCXUoRTKIGkiH+jgk/NQO9gIUeDOlzZTIytEFcwMM5GPXyOJs/HXnKGmPl+FTqEOY2SCZBrDY2bYbt+ndbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cqB1I3WiF4bQi9mUYwIpuza3+MYn1Z44UQBm3lysYYNVb/be
	Cjz0CKPFwKifLiOVvUF4leIbLHYsfz1WWJdzHaGTVD9QIUCjeAzXu7cn+fAa3eL08ehPogwoS3P
	f24sFJR4It0C23iy6/loiUnMEJ6k=
X-Google-Smtp-Source: AGHT+IEb3v8xzJWz0cDA5UTfguQZVSfREyEsVHxI+q0zbg4uzQR0p0+grFjag3fHcdBSMhFJCisrbkFwLcEtgTaQWls=
X-Received: by 2002:a05:6808:191a:b0:3eb:7529:ad00 with SMTP id
 5614622812f47-3eccc055b40mr2114135b6e.31.1734533452668; Wed, 18 Dec 2024
 06:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211122605.3048503-1-christian.loehle@arm.com> <20241211122605.3048503-3-christian.loehle@arm.com>
In-Reply-To: <20241211122605.3048503-3-christian.loehle@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 15:50:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hyaMVwiXMa3MvVR9auHwnLvs5BrL17eABtC9KzwZx7-A@mail.gmail.com>
Message-ID: <CAJZ5v0hyaMVwiXMa3MvVR9auHwnLvs5BrL17eABtC9KzwZx7-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Use CPUFREQ_POLICY_UNKNOWN
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:26=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> epp_policy uses the same values as cpufreq_policy.policy and resets
> to CPUFREQ_POLICY_UNKNOWN during offlining. Be consistent about
> it and initialize to CPUFREQ_POLICY_UNKNOWN instead of 0, too.
>
> No functional change intended.
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index b8e2396a708a..5dacd9d26879 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2709,7 +2709,7 @@ static int intel_pstate_init_cpu(unsigned int cpunu=
m)
>         }
>
>         cpu->epp_powersave =3D -EINVAL;
> -       cpu->epp_policy =3D 0;
> +       cpu->epp_policy =3D CPUFREQ_POLICY_UNKNOWN;
>
>         intel_pstate_get_cpu_pstates(cpu);
>
> --

Applied as 6.14 material, thanks!

