Return-Path: <linux-pm+bounces-28132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49EACE5E6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 22:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6291B7A75D5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 20:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D9321147D;
	Wed,  4 Jun 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClgTW4ji"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35E20D517;
	Wed,  4 Jun 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070556; cv=none; b=ANiW5itIJ1nin5l4+xh7jPkSQx/6NrdiPGt6OOYARaE5NjmXEaa/ds4VX8A7lvApK/y8XKU9NGTQCEIswGlaLSJc7hGP5hQQVPIB9HRNQzlbxW7nNuWs+Wg44bkjiWDPNcZG+g8ikrMFjjC8Ow813lUM/wGPk1eCQahMyFaqqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070556; c=relaxed/simple;
	bh=fJ7W2Jhm9In4ZzNI3KHiAfyyy5/u0+EISkIDVxqJym0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOZfUPE84kLgTX6ZQKXL8/VdV9yvIXwg2iqFsR6D7Qpg0j8Gv5KhbBJ1V2ViVGy5j0auqudoj5T12uWrI0oDn0tBjNtGWyh5SL8ZpY4AjFyYH8fAVnX18jIk/RdkBZIUje1ijILRsNaPZF7TbBxtMkpxrXGjsap1gaewcf8LScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClgTW4ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65774C4CEF1;
	Wed,  4 Jun 2025 20:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749070556;
	bh=fJ7W2Jhm9In4ZzNI3KHiAfyyy5/u0+EISkIDVxqJym0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ClgTW4ji5NnqTDZQbjowv+QWXSREyOoaT2qUEkJpVGubZY8GrySl0h99ZauPTW5kN
	 pKQd2zbeN/FAxyQNjbHXYpxChDWQ9xGUbs+hkDm5RF8UhY78qnS4sEoeAWbkolq8hQ
	 3tnKlklt02ZbjuCOgSJLb+jmhdhdRuhaDRUcn31QxQ9tO5nDQ/ASSyVXAWdPgMsR8c
	 UslvyJ/lKwHc095N50q4FWlphIjMFyxrN/ZbBstdQEFSYXAcwTlwabGWtCDEcBAYxK
	 RbUc7H6j1svbak030ly69DfuSZkhd5TBfdzhaCy5WKkns6JanmN+qhtNzEcwr6u7b6
	 p8EkD7YdeWb1A==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2db2149ffceso302156fac.1;
        Wed, 04 Jun 2025 13:55:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/jTmsa/X01Ro2VtyHEK6hyqoFwlsbSKcobVASJOcNU9FkX8fob7OOME/2h0s4mThARvIpbGh65sM=@vger.kernel.org, AJvYcCUzFeLpcB0ZN46uISJp8XfUsQoy160NftPnNuNEPHf/l+Hq3+Xt91pWRoisrly7Fl6/50T0Rg20NGV1qXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYgKdWu8+TwN5WZ9SCFXXO6DNQnzSU9K36GfLBgUNo3OoleWP
	99g5K4wAszofvotM24ZaMueZ+QxYwHdFaX2n81tqSzsBbN5MJF4QLE22SwHlG6LspcVi8pp6Tib
	wLq0DkH+13TI0JEypPH5W+joqZpT9KkM=
X-Google-Smtp-Source: AGHT+IFH/PUGgZzNanlrokbbWC1BR6otjetW/JCtRHX44j/FArtn4zMoBWYLllGPE6fth83PvK88/AnMTZKi8abR9b0=
X-Received: by 2002:a05:6870:a10d:b0:2c2:b85b:71ff with SMTP id
 586e51a60fabf-2e9bf33225dmr2840645fac.8.1749070555675; Wed, 04 Jun 2025
 13:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Jun 2025 22:55:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgK+B1j6=M+Sx1+jC4d1n3GZfcpLtZJ_j58xdMXweTPA@mail.gmail.com>
X-Gm-Features: AX0GCFujXlhVZkRITbOaGVrUP4f3nAQPAHqjC3FnMC0JSolk2fTOOO98TnJSdNQ
Message-ID: <CAJZ5v0hgK+B1j6=M+Sx1+jC4d1n3GZfcpLtZJ_j58xdMXweTPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: intel: int340x: Add performance control for
 platform temperature control
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, daniel.lezcano@linaro.org, rafael@kernel.org, 
	lukasz.luba@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:35=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add additional attribute to control performance of platform temperature
> control feature. Two attributes are added:

It would be good to explain why they are needed.

> gain: 0-7 levels, with 0 being most aggressive.
>         7 =E2=80=93 graceful, favors performance at the expense of temper=
ature
>         overshoots
>         0 =E2=80=93 aggressive, favors tight regulation over performance
>
> min_performance_level: A value from 0-255. Specifies minimum Performance
>         level below which the there will be no throttling.
>         0 - all levels of throttling allowed including survivability
>         actions.
>         255 - no throttling allowed.

The description of min_performance_level above doesn't seem to be
consistent to me.  Specifically, the descriptions of the 0 and 255
values appear to indicate that this really is about what kind of
throttling can be applied.

Also, I gather that the units of this number are arbitrary and it is
not tied to anything specific.  I mean, 127 doesn't mean 50% of CPU
performance, for instance.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/driver-api/thermal/intel_dptf.rst   | 10 ++++++++++
>  .../platform_temperature_control.c                | 15 ++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentat=
ion/driver-api/thermal/intel_dptf.rst
> index ec5769accae0..794f5cce548e 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -206,6 +206,16 @@ All these controls needs admin privilege to update.
>         Update a new temperature target in milli degree celsius for hardw=
are to
>         use for the temperature control.
>
> +``gain`` (RW)
> +       A value in the range 0-7. Sets the aggressiveness of control loop=
.
> +       7 =E2=80=93 graceful, favors performance at the expense of temper=
ature overshoots.
> +       0 =E2=80=93 aggressive, favors tight regulation over performance.
> +
> +``min_performance_level`` (RW)
> +       Minimum Performance level below which the there will be no thrott=
ling.
> +       0 - all levels of throttling allowed including survivability acti=
ons.
> +       256 - no throttling allowed.
> +
>  Given that this is platform temperature control, it is expected that a
>  single user-level manager owns and manages the controls. If multiple
>  user-level software applications attempt to write different targets, it
> diff --git a/drivers/thermal/intel/int340x_thermal/platform_temperature_c=
ontrol.c b/drivers/thermal/intel/int340x_thermal/platform_temperature_contr=
ol.c
> index 2d6504514893..6cd05783a52d 100644
> --- a/drivers/thermal/intel/int340x_thermal/platform_temperature_control.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/platform_temperature_control.=
c
> @@ -49,7 +49,7 @@ struct mmio_reg {
>  };
>
>  #define MAX_ATTR_GROUP_NAME_LEN        32
> -#define PTC_MAX_ATTRS          3
> +#define PTC_MAX_ATTRS          5
>
>  struct ptc_data {
>         u32 offset;
> @@ -57,6 +57,8 @@ struct ptc_data {
>         struct attribute *ptc_attrs[PTC_MAX_ATTRS];
>         struct device_attribute temperature_target_attr;
>         struct device_attribute enable_attr;
> +       struct device_attribute gain_attr;
> +       struct device_attribute min_performance_level_attr;
>         char group_name[MAX_ATTR_GROUP_NAME_LEN];
>  };
>
> @@ -78,6 +80,8 @@ static u32 ptc_offsets[PTC_MAX_INSTANCES] =3D {0x5B20, =
0x5B28, 0x5B30};
>  static const char * const ptc_strings[] =3D {
>         "temperature_target",
>         "enable",
> +       "gain",
> +       "min_performance_level",
>         NULL
>  };
>
> @@ -177,6 +181,11 @@ PTC_SHOW(temperature_target);
>  PTC_STORE(temperature_target);
>  PTC_SHOW(enable);
>  PTC_STORE(enable);
> +PTC_SHOW(gain);
> +PTC_STORE(gain);
> +PTC_SHOW(min_performance_level);
> +PTC_STORE(min_performance_level);
> +
>
>  #define ptc_init_attribute(_name)\
>         do {\
> @@ -193,9 +202,13 @@ static int ptc_create_groups(struct pci_dev *pdev, i=
nt instance, struct ptc_data
>
>         ptc_init_attribute(temperature_target);
>         ptc_init_attribute(enable);
> +       ptc_init_attribute(gain);
> +       ptc_init_attribute(min_performance_level);
>
>         data->ptc_attrs[index++] =3D &data->temperature_target_attr.attr;
>         data->ptc_attrs[index++] =3D &data->enable_attr.attr;
> +       data->ptc_attrs[index++] =3D &data->gain_attr.attr;
> +       data->ptc_attrs[index++] =3D &data->min_performance_level_attr.at=
tr;
>         data->ptc_attrs[index] =3D NULL;
>
>         snprintf(data->group_name, MAX_ATTR_GROUP_NAME_LEN,
> --
> 2.49.0
>

