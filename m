Return-Path: <linux-pm+bounces-10889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1BF92BF24
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34FBB2712E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3373A19F469;
	Tue,  9 Jul 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXIyipxv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56B19F461;
	Tue,  9 Jul 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541213; cv=none; b=kiODDIKuowPWPGPZOdwHfUbJIpcnhJDE6WCgZv6doLCLZdk0S5tlaI0Cced38/UszOQXHLudNVtrC3BrUb7wYDdXQIMCFpiGfEvuvaNV244t6aZ4y97FJz0I3r/CqDl/8NZIhHvyv6IS+tr3MFeKXD6W5oNKI4jWGdDFbrB9oTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541213; c=relaxed/simple;
	bh=CC2PHQNnrsdYgFYaV6OamdCWY/YV/JF9+Qkm60FkWTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXTHRsjhbNjvfCH4hOUx0p0yNi+jasi7rrITGVdFXQulsIPXKSHCw0L/BKzmf1vOymRuWjxzv1L0biOWt4wIm8a9mNd9a9AtroXsy45YmdTVYKsBY38MYaXrMhjVs/28JlEvsRLnnV5Ms4Ju+oP1w77ndUY6HKAx5Lr6OGSbCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXIyipxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96083C3277B;
	Tue,  9 Jul 2024 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541212;
	bh=CC2PHQNnrsdYgFYaV6OamdCWY/YV/JF9+Qkm60FkWTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cXIyipxv1ymkxMtR9Mf1qaTzVQ4H57kdVUmNyJLKn8fq8Xq0fpLs3LEx/NRaMh+S+
	 A3r5nTaBKBdndAXz5A4dtKWCIrdzumsifF9AlSsfwKHbJGLY9Z1EXLTN5k0kpNlNaR
	 BU0NKE//YStAqDboENA4Vt4eHIxUGTmzM+lIMtbGo8hMQUWXLhDZdV6y5RIBPHSRNv
	 6esWX+gFcDD7CumrbfBy9XZE/5xjMN7FYlZPpzihNyfqidpshcUFQjTUjOong30V/v
	 rHVdrzgVNr/ScNQLeJpv27JXTuay6yjsRzWwITsaC/GoenSHyb5wk9yWePwAPAz03J
	 W0TOy8q7NkuZQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25e14bf05e5so199615fac.1;
        Tue, 09 Jul 2024 09:06:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUZV776I2PuZqgGXST6QjkXmaYdr2hgErLDG/45iyPZyrYtNZw5cO2pzeODZstoMi/OBtB9l5Bja5WYUG3xV7fQRNHkDkfd7ZvGu512XbhfTpRNBFshRnTL9iLW/cGST4=
X-Gm-Message-State: AOJu0YwCTsnjgSktxnyzqOXXVs4lz9bnc9bKRDLgfol7hhuN4tRWmTsl
	RDjk9LlE/vidg0Z0VjT1Zb475JC58s554jDky5tJu+ieyMbhoAH+6hSOHPPBSX3/A4VzxYJZJvA
	ReKwqd8kuTpMioKKTLt0iXwV9xcE=
X-Google-Smtp-Source: AGHT+IFqiW5QZHZ9ZUza/Bt2hsVzHJKzpK259ONyXwKp9f5S4cEObEvF7s+/kF8vvJ1iTZfp8Qop48dz9aT1ch/wwcU=
X-Received: by 2002:a05:6871:24da:b0:25e:2624:eb5f with SMTP id
 586e51a60fabf-25eae764acbmr2293933fac.1.1720541211853; Tue, 09 Jul 2024
 09:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719849427.git.petrm@nvidia.com> <a9b97ecf80c722b42eceac1800f78ba57027af48.1719849427.git.petrm@nvidia.com>
In-Reply-To: <a9b97ecf80c722b42eceac1800f78ba57027af48.1719849427.git.petrm@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jul 2024 18:06:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAN0Csd6Qnc=2hNGafpbEGRVGX41LC8qrmUkoCk=whrw@mail.gmail.com>
Message-ID: <CAJZ5v0hAN0Csd6Qnc=2hNGafpbEGRVGX41LC8qrmUkoCk=whrw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] mlxsw: core_thermal: Report valid current
 state during cooling device registration
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com, linux-pm@vger.kernel.org, 
	Vadim Pasternak <vadimp@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 6:45=E2=80=AFPM Petr Machata <petrm@nvidia.com> wrot=
e:
>
> From: Ido Schimmel <idosch@nvidia.com>
>
> Commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to
> thermal_debug_cdev_add()") changed the thermal core to read the current
> state of the cooling device as part of the cooling device's
> registration. This is incompatible with the current implementation of
> the cooling device operations in mlxsw, leading to initialization
> failure with errors such as:
>
> mlxsw_spectrum 0000:01:00.0: Failed to register cooling device
> mlxsw_spectrum 0000:01:00.0: cannot register bus device
>
> The reason for the failure is that when the get current state operation
> is invoked the driver tries to derive the index of the cooling device by
> walking a per thermal zone array and looking for the matching cooling
> device pointer. However, the pointer is returned from the registration
> function and therefore only set in the array after the registration.
>
> The issue was later fixed by commit 1af89dedc8a5 ("thermal: core: Do not
> fail cdev registration because of invalid initial state") by not failing
> the registration of the cooling device if it cannot report a valid
> current state during registration, although drivers are responsible for
> ensuring that this will not happen.
>
> Therefore, make sure the driver is able to report a valid current state
> for the cooling device during registration by passing to the
> registration function a per cooling device private data that already has
> the cooling device index populated.
>
> Cc: linux-pm@vger.kernel.org
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  .../ethernet/mellanox/mlxsw/core_thermal.c    | 50 ++++++++++---------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers=
/net/ethernet/mellanox/mlxsw/core_thermal.c
> index 5c511e1a8efa..eee3e37983ca 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> @@ -100,6 +100,12 @@ static const struct mlxsw_cooling_states default_coo=
ling_states[] =3D {
>
>  struct mlxsw_thermal;
>
> +struct mlxsw_thermal_cooling_device {
> +       struct mlxsw_thermal *thermal;
> +       struct thermal_cooling_device *cdev;
> +       unsigned int idx;
> +};
> +
>  struct mlxsw_thermal_module {
>         struct mlxsw_thermal *parent;
>         struct thermal_zone_device *tzdev;
> @@ -123,7 +129,7 @@ struct mlxsw_thermal {
>         const struct mlxsw_bus_info *bus_info;
>         struct thermal_zone_device *tzdev;
>         int polling_delay;
> -       struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
> +       struct mlxsw_thermal_cooling_device cdevs[MLXSW_MFCR_PWMS_MAX];
>         struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
>         struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIP=
S];
>         struct mlxsw_thermal_area line_cards[];
> @@ -147,7 +153,7 @@ static int mlxsw_get_cooling_device_idx(struct mlxsw_=
thermal *thermal,
>         int i;
>
>         for (i =3D 0; i < MLXSW_MFCR_PWMS_MAX; i++)
> -               if (thermal->cdevs[i] =3D=3D cdev)
> +               if (thermal->cdevs[i].cdev =3D=3D cdev)
>                         return i;
>
>         /* Allow mlxsw thermal zone binding to an external cooling device=
 */
> @@ -352,17 +358,14 @@ static int mlxsw_thermal_get_cur_state(struct therm=
al_cooling_device *cdev,
>                                        unsigned long *p_state)
>
>  {
> -       struct mlxsw_thermal *thermal =3D cdev->devdata;
> +       struct mlxsw_thermal_cooling_device *mlxsw_cdev =3D cdev->devdata=
;
> +       struct mlxsw_thermal *thermal =3D mlxsw_cdev->thermal;
>         struct device *dev =3D thermal->bus_info->dev;
>         char mfsc_pl[MLXSW_REG_MFSC_LEN];
> -       int err, idx;
>         u8 duty;
> +       int err;
>
> -       idx =3D mlxsw_get_cooling_device_idx(thermal, cdev);
> -       if (idx < 0)
> -               return idx;
> -
> -       mlxsw_reg_mfsc_pack(mfsc_pl, idx, 0);
> +       mlxsw_reg_mfsc_pack(mfsc_pl, mlxsw_cdev->idx, 0);
>         err =3D mlxsw_reg_query(thermal->core, MLXSW_REG(mfsc), mfsc_pl);
>         if (err) {
>                 dev_err(dev, "Failed to query PWM duty\n");
> @@ -378,22 +381,19 @@ static int mlxsw_thermal_set_cur_state(struct therm=
al_cooling_device *cdev,
>                                        unsigned long state)
>
>  {
> -       struct mlxsw_thermal *thermal =3D cdev->devdata;
> +       struct mlxsw_thermal_cooling_device *mlxsw_cdev =3D cdev->devdata=
;
> +       struct mlxsw_thermal *thermal =3D mlxsw_cdev->thermal;
>         struct device *dev =3D thermal->bus_info->dev;
>         char mfsc_pl[MLXSW_REG_MFSC_LEN];
> -       int idx;
>         int err;
>
>         if (state > MLXSW_THERMAL_MAX_STATE)
>                 return -EINVAL;
>
> -       idx =3D mlxsw_get_cooling_device_idx(thermal, cdev);
> -       if (idx < 0)
> -               return idx;
> -
>         /* Normalize the state to the valid speed range. */
>         state =3D max_t(unsigned long, MLXSW_THERMAL_MIN_STATE, state);
> -       mlxsw_reg_mfsc_pack(mfsc_pl, idx, mlxsw_state_to_duty(state));
> +       mlxsw_reg_mfsc_pack(mfsc_pl, mlxsw_cdev->idx,
> +                           mlxsw_state_to_duty(state));
>         err =3D mlxsw_reg_write(thermal->core, MLXSW_REG(mfsc), mfsc_pl);
>         if (err) {
>                 dev_err(dev, "Failed to write PWM duty\n");
> @@ -753,17 +753,21 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
>         }
>         for (i =3D 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
>                 if (pwm_active & BIT(i)) {
> +                       struct mlxsw_thermal_cooling_device *mlxsw_cdev;
>                         struct thermal_cooling_device *cdev;
>
> +                       mlxsw_cdev =3D &thermal->cdevs[i];
> +                       mlxsw_cdev->thermal =3D thermal;
> +                       mlxsw_cdev->idx =3D i;
>                         cdev =3D thermal_cooling_device_register("mlxsw_f=
an",
> -                                                              thermal,
> +                                                              mlxsw_cdev=
,
>                                                                &mlxsw_coo=
ling_ops);
>                         if (IS_ERR(cdev)) {
>                                 err =3D PTR_ERR(cdev);
>                                 dev_err(dev, "Failed to register cooling =
device\n");
>                                 goto err_thermal_cooling_device_register;
>                         }
> -                       thermal->cdevs[i] =3D cdev;
> +                       mlxsw_cdev->cdev =3D cdev;
>                 }
>         }
>
> @@ -824,8 +828,8 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
>  err_thermal_zone_device_register:
>  err_thermal_cooling_device_register:
>         for (i =3D 0; i < MLXSW_MFCR_PWMS_MAX; i++)
> -               if (thermal->cdevs[i])
> -                       thermal_cooling_device_unregister(thermal->cdevs[=
i]);
> +               if (thermal->cdevs[i].cdev)
> +                       thermal_cooling_device_unregister(thermal->cdevs[=
i].cdev);
>  err_reg_write:
>  err_reg_query:
>         kfree(thermal);
> @@ -848,10 +852,8 @@ void mlxsw_thermal_fini(struct mlxsw_thermal *therma=
l)
>         }
>
>         for (i =3D 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
> -               if (thermal->cdevs[i]) {
> -                       thermal_cooling_device_unregister(thermal->cdevs[=
i]);
> -                       thermal->cdevs[i] =3D NULL;
> -               }
> +               if (thermal->cdevs[i].cdev)
> +                       thermal_cooling_device_unregister(thermal->cdevs[=
i].cdev);
>         }
>
>         kfree(thermal);
> --
> 2.45.0
>
>

