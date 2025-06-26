Return-Path: <linux-pm+bounces-29613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78175AEA630
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 21:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7101898778
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730422A1D5;
	Thu, 26 Jun 2025 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdeRN5Hl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B32CCA9;
	Thu, 26 Jun 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965333; cv=none; b=K7nzbksOEzXns53iYKQoAILyuZxrfF0rxGExriPMljKUUP50e5JueWW4ja7BxqOj2OvzjtLZ7BGPiJWqL825itFZzCaSd8z/1rG3E91otqwnXx5Tj84H+erA6OJ+RkLbpNVfdU/U7+h48xiBdl1mJ4u4UwARrbZHxlkgWqf4Ih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965333; c=relaxed/simple;
	bh=GVTVZKAcmUFrxnDCM5D1GDi3JRVk55utZxoEDR6QU+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nbooe41m8NeGu5hOkAQd1uUQZSqPwM9nYhHW+ySzxkCZ1oV5R1v/Vuq46JJ7g/kSxRJjcy3MeRtY+yQAakQjCQhZPXepxiknYGq2tv6i0NeXeJ31xbfaiRADdUxElpmJtcz9Jau7DPnINkwGUy9dm0UoV8WUvDtxFgzgePuDdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdeRN5Hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86560C4AF09;
	Thu, 26 Jun 2025 19:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750965332;
	bh=GVTVZKAcmUFrxnDCM5D1GDi3JRVk55utZxoEDR6QU+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BdeRN5Hl8XOH+v0XpP96wSL+JU4vbDSfi0H1r3RDkvdoC6WAB+/pUvVt94HnLJ9dP
	 MDTs4oYtq4/76SEN3QF5RSfRt2O3XuwcJkO3eX6PezWoAvTTK5LtKv59oiu4gbU3Bg
	 OD4I9rKo1/EoEP4ZjGY5a2yZHi8pMH75nQlwVjzbm4pP4SRXmePRPPCyUfI1shHmYG
	 N8BdqTadbVA+aIrB6WyzpBltNRNLKKjHn3oAJOZYid7WxIlyPjs16uAios+mBTUnOF
	 QvZYpvqgG1meoGDjJygywTuM5/WPNeaXMsxXruS5qWcLqCLNPj1RNesgyurK6GvFO7
	 KH4PP6RIi78WA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2d09d495c6cso379891fac.3;
        Thu, 26 Jun 2025 12:15:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+D/1cnWS6T93Hrld5Us1G3No86VNLz4Dmm5h0Arz6ccroahPcfKKKS3GSqdp6HTEw9wa+JuUA6b/y9kc=@vger.kernel.org, AJvYcCVEZXGhPyKcDArH6QPtdO0+PoEqUnaUcSiKVpxtv9/Bgp6YoeQzQEG/g6XyEaQKeucE4/zvUrz8@vger.kernel.org, AJvYcCW9HBTRkhrobq5xFpO5CXkWByjj/7Pi/qIxS7a4jEhESjGpajHrHvK/AjeRYpDNHvUiqR/hMZbj+qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbT7EvJerfgsthntmExK7JJMB0yPlKR4YN5yI+LLTFxEQsm/0
	X/sPK+q8FtttefbXKso1v/6cf1zFhrENlXw7A+dusmIYXX6pJ+lvDGaCehQkIjqia7YdIawsYAi
	0HndHKtHefwAHOu8XvUDp2fZC/VPGdx8=
X-Google-Smtp-Source: AGHT+IHF9pqM5Ydclvi+iFU8TmSmeOmdqu4oVPUqgHbDY7h2PY1K/BE4yM1Tsg43GYzwGgNnIRIujkcAM4w7hZ2UsvQ=
X-Received: by 2002:a05:6870:3511:b0:2cc:3d66:b6ea with SMTP id
 586e51a60fabf-2efed795392mr158783fac.34.1750965331752; Thu, 26 Jun 2025
 12:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619071340.384782-1-rui.zhang@intel.com>
In-Reply-To: <20250619071340.384782-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 21:15:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hfO6eSbwYo2iD4JuqHth0AUQY3cG2109Yhyz-=RNaVWQ@mail.gmail.com>
X-Gm-Features: Ac12FXzJ7BuhzTdUQAYlDXdtcJzEQvwlFR3N2p_d41kJUWcGANG9wZIpsJco93c
Message-ID: <CAJZ5v0hfO6eSbwYo2iD4JuqHth0AUQY3cG2109Yhyz-=RNaVWQ@mail.gmail.com>
Subject: Re: [PATCH V2] powercap: intel_rapl: Do not change CLAMPING bit if
 ENABLE bit cannot be changed
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:13=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> PL1 cannot be disabled on some platforms. The ENABLE bit is still set
> after software clears it. This behavior leads to a scenario where, upon
> user request to disable the Power Limit through the powercap sysfs, the
> ENABLE bit remains set while the CLAMPING bit is inadvertently cleared.
>
> According to the Intel Software Developer's Manual, the CLAMPING bit,
> "When set, allows the processor to go below the OS requested P states in
> order to maintain the power below specified Platform Power Limit value."
>
> Thus this means the system may operate at higher power levels than
> intended on such platforms.
>
> Enhance the code to check ENABLE bit after writing to it, and stop
> further processing if ENABLE bit cannot be changed.
>
> Cc: stable@vger.kernel.org
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Fixes: 2d281d8196e3 ("PowerCap: Introduce Intel RAPL power capping driver=
")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> Changes since V1:
> - Add Fixes tag
> - CC stable kernel
> ---
>  drivers/powercap/intel_rapl_common.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index e3be40adc0d7..602f540cbe15 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -341,12 +341,27 @@ static int set_domain_enable(struct powercap_zone *=
power_zone, bool mode)
>  {
>         struct rapl_domain *rd =3D power_zone_to_rapl_domain(power_zone);
>         struct rapl_defaults *defaults =3D get_defaults(rd->rp);
> +       u64 val;
>         int ret;
>
>         cpus_read_lock();
>         ret =3D rapl_write_pl_data(rd, POWER_LIMIT1, PL_ENABLE, mode);
> -       if (!ret && defaults->set_floor_freq)
> +       if (ret)
> +               goto end;
> +
> +       ret =3D rapl_read_pl_data(rd, POWER_LIMIT1, PL_ENABLE, false, &va=
l);
> +       if (ret)
> +               goto end;
> +
> +       if (mode !=3D val) {
> +               pr_debug("%s cannot be %s\n", power_zone->name, mode ? "e=
nabled" : "disabled");
> +               goto end;
> +       }
> +
> +       if (defaults->set_floor_freq)
>                 defaults->set_floor_freq(rd, mode);
> +
> +end:
>         cpus_read_unlock();
>
>         return ret;
> --

Applied as 6.16-rc material, thanks!

