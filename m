Return-Path: <linux-pm+bounces-28990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C057DADF35B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E04189FE74
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEF2E8E0B;
	Wed, 18 Jun 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmPUEkiS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23B285CAC;
	Wed, 18 Jun 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266263; cv=none; b=RQDuzTW8X7D0eWRzMJyqqb2oUOAp+y+Ur9mrPCoiHbSja2NG/UaINMTllXUMM02fK5qmoUAxqiWodU3Pociu2zb6PCHgJxg7YTPfKj6WK7QFUjyvyHMKA7CTd4Il5yNHXXihs2gWwiTlbDCeV09jkau3xM3NCNSseYSx8/Saudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266263; c=relaxed/simple;
	bh=Ypa9nVjCfR8sFxcmmQL7ktbIc+Kj3T4zssOI+MEeCKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFNQRVquyVwndz2b3jHJvlVkXPfcjPDPi3JQuFq7I5knfYgw9VxNabjOmOJf+p7X8fuUrLNmVroSeoiSySpk5EYhNvITaz89qNtl6peApsUHGst38jFkagNvniLL6DjAJy0X8S6TGIflHx7bCDNAzlWYN8Sha+tkX7t8yG4qDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmPUEkiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3293FC4CEE7;
	Wed, 18 Jun 2025 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750266263;
	bh=Ypa9nVjCfR8sFxcmmQL7ktbIc+Kj3T4zssOI+MEeCKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pmPUEkiS0zzUQ4vB90YERSrSlA8aXa/7N9mvpbOrgmu8p3KxaWBKr0be4yh1RXqd/
	 OPtmUb2bp/Rut9ZbE204gDZlBkwPYhdj1pq/12QR+9Pz430tPLu7tiG7XvIMVNptIH
	 JB8j59E9BXFdnUAstjLDkXRM2wejwpwb9mnIHVyY7ueSt3A1XArY8Ht4+lSYM2r8md
	 ZjK1fmL00NFGhBn+wm0+7XNewl13u+L1gan4Pw2bc9ui9c6stO/43r3z1DVYINVdbL
	 XJwIhehGdPzvM01NigFzBNNtciidHJRkyz07yzBMovN52A7GR8HDNJxh6tlRChhPOT
	 bMUTNeusgwwDg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-404a5f4cdedso1855586b6e.0;
        Wed, 18 Jun 2025 10:04:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsliSpJZ52Z3iq6Lg7c7zbugfy0BR2RObQZKvPlGIM0M5K+VfBa0apsx1jR7p+yoKLwh1VXfeL79E=@vger.kernel.org, AJvYcCW8odEs4GpybgugjY6hIirFTLWbT2icW7ZcIZwjy/gnbTmsWzQ35fNkKWb6NDhn8lGtnuZ/VhpoXg3ogAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZEF33ZpABOXkES4PQ4vTIBuRsu2a+NWP05Y+8ot4on/RSBGSN
	wHGPBqg+uMihFUCU+YPLIHUl+eb+EqyOiH8UXNMJbDp1Nwvq51NlyUfqdER53HrveNZvCeh7wkx
	XNjS/S4l9OCk0ZXVgPFCiv89R2DRCejI=
X-Google-Smtp-Source: AGHT+IE12ZLGrHLWweS0eNyUCqVVO1yNtfh2NFQQPVPSHgxx4DFygcG82d5jk4gcHao0pqFoS6PwMuJfaiEHvzOgpV8=
X-Received: by 2002:a05:6808:11c7:b0:40a:557e:cd8 with SMTP id
 5614622812f47-40a7c18bf8amr10317748b6e.33.1750266261646; Wed, 18 Jun 2025
 10:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618030330.279410-1-rui.zhang@intel.com>
In-Reply-To: <20250618030330.279410-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 19:04:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gY7Rp8C8AFzgRzMs+Gq-1rcgKmrG4+nJWB=bGpcKkU2A@mail.gmail.com>
X-Gm-Features: AX0GCFsH011RolEPzGDwyRcryBdBS2AIzPybZjn9NhYa19DB14Z0OmFDrscKWKM
Message-ID: <CAJZ5v0gY7Rp8C8AFzgRzMs+Gq-1rcgKmrG4+nJWB=bGpcKkU2A@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Do not change CLAMPING bit if
 ENABLE bit cannot be changed
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:03=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wro=
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
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

If this is a fix, I would appreciate a Fixes: tag.

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
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
> 2.43.0
>
>

