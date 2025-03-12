Return-Path: <linux-pm+bounces-23936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034CA5E546
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 21:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F8B3B2B12
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0151EDA01;
	Wed, 12 Mar 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDAFKdy3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A151D5CD4;
	Wed, 12 Mar 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811145; cv=none; b=THu4CnO9Mxmo8KsWGbwsg/lmPUhu9pbsO2JzBo2tvL+Se55VHstq77r4XE0whfIxusRZO+2tSqUdV9YSiAEhmhBu2U81vzy2iRDMSmlSvqWlk16SwGh3vKGGF+S5OGoR7ovpsZxLiIN/y09amSg781ivqDFPgAxYJn5080VZU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811145; c=relaxed/simple;
	bh=2erZqr/W3QduZMjOC5WU572uCwoDQMxKcwDo0RrSWR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPVGhXNgPObbQLdnQm93JGymJ8YVDa44uu6YsHynFF5+maslcq/uIi831LKpyjx+VxLWSbC5CHHRX2FgBp1lCUFGQtjALk3rkP2wpmEDSX14qDPHrTn7bUDG2SsHsS8/czti1VNdS3cea0PIdOaYh8Uff26c8Cy1OO4qe/HYZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDAFKdy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBD2C4AF09;
	Wed, 12 Mar 2025 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811143;
	bh=2erZqr/W3QduZMjOC5WU572uCwoDQMxKcwDo0RrSWR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LDAFKdy3Js5OxzpKyXlDOdXGj2v5RAb4QnIglbNfQiooaXBoILh59UAUMBIOrOzGZ
	 64+ypWE5Bib31/lbvdy2MCR6fnWmAxIQqPr4fzfK9o+4EN571jnsUshTZA9f/0eGu9
	 z5LcmUuMUffHhHDXDP9PoTSd8LC1RNoXXB8F8H8VwH0E0DD5eBAbyn8mtxEKyb4J7e
	 txO/fGpJTSpnRoTe6uew0CieqdaBDp/4TEGtmhocKd7oQyz2lRW07gqQ5Fqds3iYAU
	 Yc6tGp2gXSvR3Qaj21o2vwc64igXmw0GL9sqxAessP7qHJKSk5C2MkSMXKU5yNWYwt
	 YmmqinV6wDNwA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so90657fac.2;
        Wed, 12 Mar 2025 13:25:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVb0qo9nEKvm/JFYns9/ikWEi4AgGGGgxA6C2Y+35/7qZ4nNw4ismD/kZHvEVT8mnS6cc6zABl6N6t15pk=@vger.kernel.org, AJvYcCW1xLPBVcjX9ERxXjC46WLDEHpSRs1a9F1FvML/+j+9K1JB18Vx34GBTOiRTLwX+gvTGpFPGUCmej4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysdqYvRL+lLRODNr10S7LBvlUyo+hOGS5dnTnYmP3eljHMTkNW
	Py7WLDDOERLsXkSnaSjZpOp1rLKyuHyv2azROUN84WBz8286cqonnuhT7ixhNFy0xIajnz6/qWc
	dZV3YvRn9p0T0T7KSbrknMK+3NjU=
X-Google-Smtp-Source: AGHT+IEopPL8RcPBLApat/oJd2K1QqqiJCagIaz/iQNtTHnVBeGTy+oWSzopeH8WB0YX9u5ibevC/wIg2NbTa3zbWec=
X-Received: by 2002:a05:6870:4f02:b0:2c2:4e19:1cd4 with SMTP id
 586e51a60fabf-2c2e869ebf2mr4735014fac.1.1741811142855; Wed, 12 Mar 2025
 13:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-thermal-sysfs-race-v1-1-8a3d4d4ac9c4@intel.com>
In-Reply-To: <20250307-thermal-sysfs-race-v1-1-8a3d4d4ac9c4@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 21:25:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gYSKWJySx+KC7=zhu4xw3eNrn-LRPrMViz2KSYvJ6dKA@mail.gmail.com>
X-Gm-Features: AQ5f1JoiDoBtYIP2a0KuGHL0RiRuWh0pNywLGO1KFaWjywr69Y_Mjrc7J6MGn8U
Message-ID: <CAJZ5v0gYSKWJySx+KC7=zhu4xw3eNrn-LRPrMViz2KSYvJ6dKA@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Delay exposing sysfs interface
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 2:02=E2=80=AFAM Lucas De Marchi <lucas.demarchi@inte=
l.com> wrote:
>
> There's a race between initializing the governor and userspace accessing
> the sysfs interface. From time to time the Intel graphics CI shows this
> signature:
>
>         <1>[] #PF: error_code(0x0000) - not-present page
>         <6>[] PGD 0 P4D 0
>         <4>[] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>         <4>[] CPU: 3 UID: 0 PID: 562 Comm: thermald Not tainted 6.14.0-rc=
4-CI_DRM_16208-g7e37396f86d8+ #1
>         <4>[] Hardware name: Intel Corporation Twin Lake Client Platform/=
AlderLake-N LP5 RVP, BIOS TWLNFWI1.R00.5222.A01.2405290634 05/29/2024
>         <4>[] RIP: 0010:policy_show+0x1a/0x40
>
> thermald tries to read the policy file between the sysfs files being
> created and the governor set by thermal_set_governor(), which causes the
> NULL pointer dereference.
>
> Similarly to the hwmon interface, delay exposing the sysfs files to when
> the governor is already set.
>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13655
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
> The race window is not that big. I could reproduce it and confirm
> the fix by doing this:
>
> 1) Add a udelay() in thermal_zone_device_register_with_trips
> 2) A busy loop cat'ing the file
>
>         $ while [ 1 ]; do
>                 cat /sys/devices/virtual/thermal/thermal_zone0/policy > /=
dev/null 2>&1
>           done
> 3) rebind processor_thermal_device_pci
> ---
>  drivers/thermal/thermal_core.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2328ac0d8561b..f96ca27109288 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1589,26 +1589,26 @@ thermal_zone_device_register_with_trips(const cha=
r *type,
>
>         tz->state =3D TZ_STATE_FLAG_INIT;
>
> +       result =3D dev_set_name(&tz->device, "thermal_zone%d", tz->id);
> +       if (result)
> +               goto remove_id;
> +
> +       thermal_zone_device_init(tz);
> +
> +       result =3D thermal_zone_init_governor(tz);
> +       if (result)
> +               goto remove_id;
> +
>         /* sys I/F */
>         /* Add nodes that are always present via .groups */
>         result =3D thermal_zone_create_device_groups(tz);
>         if (result)
>                 goto remove_id;
>
> -       result =3D dev_set_name(&tz->device, "thermal_zone%d", tz->id);
> -       if (result) {
> -               thermal_zone_destroy_device_groups(tz);
> -               goto remove_id;
> -       }
> -       thermal_zone_device_init(tz);
>         result =3D device_register(&tz->device);
>         if (result)
>                 goto release_device;
>
> -       result =3D thermal_zone_init_governor(tz);
> -       if (result)
> -               goto unregister;
> -
>         if (!tz->tzp || !tz->tzp->no_hwmon) {
>                 result =3D thermal_add_hwmon_sysfs(tz);
>                 if (result)
>
> ---

Applied as 6.15 material, thanks!

