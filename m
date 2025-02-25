Return-Path: <linux-pm+bounces-22880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBDEA43DC3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACB5168E35
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B2526772C;
	Tue, 25 Feb 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1rIo7+8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095662BB13;
	Tue, 25 Feb 2025 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483369; cv=none; b=eeOJWY9f5IHOMn2n43QIbzm090f6XoUXKcPcZcUNUZYHzy+fTiTBOyJlrp+5bfDwUKZnmW1+E+Qal6nFh/rT9Zuw3nhB6Okh1SctN0QSPJAm5PIJkxwjZFDOfVHpIzlmgWmWdnUietXQgeieeJ58Q+O2zBV+3xVdgwoTvD9BibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483369; c=relaxed/simple;
	bh=cNaDwmrEv6sij+shyxxOONkjZ/Hm4EVw5YyJ5dSac7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLx3EczhVKjyNJpveMkUUTH2RtpZRg5Hhw7c3ljuqPwgkj60s1cQM2qedDFud0HOgXFGLll+Sti/j8w7B/xKyy6AoRGjoeFudYsOzibQx07tRIXIoIc1vle4Mln/riDHDuTh4p8OyOtQxd/+YKui8ItYD1ut9qnKByXnaENrw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1rIo7+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA26C4AF0B;
	Tue, 25 Feb 2025 11:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740483368;
	bh=cNaDwmrEv6sij+shyxxOONkjZ/Hm4EVw5YyJ5dSac7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c1rIo7+8LDbiQVBkf6uk0fq5q+3rU7ITI5yu+ayYhZxGM7JgO3oMIbF0rabADYGSd
	 HniElXSjqZwW7s0SvcPgjLv/wWPkiaG4hW3h8vgYawhJnIpdftrbPsERpbbQzhE0QK
	 q2t9AoPlg8y7NRHw16rsX3xIzoGf+4wx7UefNV+lvQ4ydpCHmCy8jmAu/vspjeci2f
	 /gtQQSvg7SVTh4aRxZBeevy3aYYUqoeTubTl8Lah+YOoMccnqWxd3bix7SXhlHkvjn
	 8V5hlcY+uWMGfNRivY6HXcCIW9Y93DqTZNC0BA/puC4xAgbbZpMN8zQ37Tm3NsNKy/
	 nct0ALyuXtFVw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso319254fac.2;
        Tue, 25 Feb 2025 03:36:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1AudZyDne2GEJWCNZHnNm3isn3FeAIYN4J1MgKKeuOxupuNqv8MyZTIbDHWqfj7/dzGUtKnD4MyPyR58=@vger.kernel.org, AJvYcCXO5Jk7PWJLHH3YxUaa6K5nHhEiB0ue8CehQGTNs41Et234QQpffa6pxgmk7i64IaduFiHDKHu7feI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WSjPOgduxO2a1vhUnPBbkmt/W4zjjYhfeB7h6nXp9uKn5SOK
	Q1Ekwzi+rg6tPWzmltZWSyWrrYgtK0V7an021PDib9zhzNi8FwLEljjk72xpXkqgOv2CgNTQboe
	/VwD8v4nK3M5d4jFRKMpacfxzsMw=
X-Google-Smtp-Source: AGHT+IFVGGAkUM284iTSA3/t0PI+bMHWA0H1rbFlk+Klm8SMVQDJCYOxM5DpJ+mKstRoDgqq9EYdXbJxp4ruyXZ9x5A=
X-Received: by 2002:a05:6870:3d95:b0:29e:4346:7fb9 with SMTP id
 586e51a60fabf-2c10f2f4926mr1903269fac.22.1740483367837; Tue, 25 Feb 2025
 03:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222-fix-power-allocator-weight-v2-1-a94de86b685a@chromium.org>
In-Reply-To: <20250222-fix-power-allocator-weight-v2-1-a94de86b685a@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Feb 2025 12:35:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgRXoqx4g=iHSUteXs99ageQmcQDQfjp6eSqnVo9Ty8Q@mail.gmail.com>
X-Gm-Features: AWEUYZmA7nwechv4pvf6_WVVUsYE1ArXZyTG8fbiZap43TSXuj_tprWQ1ctgh48
Message-ID: <CAJZ5v0jgRXoqx4g=iHSUteXs99ageQmcQDQfjp6eSqnVo9Ty8Q@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: gov_power_allocator: Update total_weight on
 bind and cdev updates
To: Yu-Che Cheng <giver@chromium.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 4:20=E2=80=AFAM Yu-Che Cheng <giver@chromium.org> w=
rote:
>
> params->total_weight is not initialized during bind and not updated when
> the bound cdev changes. The cooling device weight will not be used due
> to the uninitialized total_weight, until we trigger an update via sysfs.
>
> The bound cdev update will be triggered during thermal zone registration,
> where each cooling device will be bound to the thermal zone one by one.
>
> The power_allocator_bind can be called without additional cdev update
> when manually changing the policy of a thermal zone via sysfs.
>
> Add a new function to handle weight update logic, including updating
> total_weight, and call it when bind, weight changes, and cdev updates to
> ensure total_weight is always correct.
>
> Fixes: a3cd6db4cc2e ("thermal: gov_power_allocator: Support new update ca=
llback of weights")
> Signed-off-by: Yu-Che Cheng <giver@chromium.org>

Applied as 6.14-rc material with some minor edits in the changelog.

Lukasz, if you have any objections, please let me know.

Thanks!

> ---
> Changes in v2:
> - Move the total_weight update to a new function for clarity.
> - Found v1 may cause crash when there are thermal zones without any
>   active or passive trip points.
>   Check trip_max before accessing its trip_desc.
> - Link to v1: https://lore.kernel.org/r/20250219-fix-power-allocator-weig=
ht-v1-1-79b1a99e94eb@chromium.org
> ---
>  drivers/thermal/gov_power_allocator.c | 30 ++++++++++++++++++++++-------=
-
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 3b644de3292e..126452fb470e 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -641,6 +641,22 @@ static int allocate_actors_buffer(struct power_alloc=
ator_params *params,
>         return ret;
>  }
>
> +static void power_allocator_update_weight(struct power_allocator_params =
*params)
> +{
> +       const struct thermal_trip_desc *td;
> +       struct thermal_instance *instance;
> +
> +       if (!params->trip_max)
> +               return;
> +
> +       td =3D trip_to_trip_desc(params->trip_max);
> +
> +       params->total_weight =3D 0;
> +       list_for_each_entry(instance, &td->thermal_instances, trip_node)
> +               if (power_actor_is_valid(instance))
> +                       params->total_weight +=3D instance->weight;
> +}
> +
>  static void power_allocator_update_tz(struct thermal_zone_device *tz,
>                                       enum thermal_notify_event reason)
>  {
> @@ -656,16 +672,12 @@ static void power_allocator_update_tz(struct therma=
l_zone_device *tz,
>                         if (power_actor_is_valid(instance))
>                                 num_actors++;
>
> -               if (num_actors =3D=3D params->num_actors)
> -                       return;
> +               if (num_actors !=3D params->num_actors)
> +                       allocate_actors_buffer(params, num_actors);
>
> -               allocate_actors_buffer(params, num_actors);
> -               break;
> +               fallthrough;
>         case THERMAL_INSTANCE_WEIGHT_CHANGED:
> -               params->total_weight =3D 0;
> -               list_for_each_entry(instance, &td->thermal_instances, tri=
p_node)
> -                       if (power_actor_is_valid(instance))
> -                               params->total_weight +=3D instance->weigh=
t;
> +               power_allocator_update_weight(params);
>                 break;
>         default:
>                 break;
> @@ -731,6 +743,8 @@ static int power_allocator_bind(struct thermal_zone_d=
evice *tz)
>
>         tz->governor_data =3D params;
>
> +       power_allocator_update_weight(params);
> +
>         return 0;
>
>  free_params:
>
> ---
> base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
> change-id: 20250218-fix-power-allocator-weight-5dac6d4b5797
>
> Best regards,
> --
> Yu-Che Cheng <giver@chromium.org>
>

