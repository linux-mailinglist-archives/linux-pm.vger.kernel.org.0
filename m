Return-Path: <linux-pm+bounces-22575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058AA3E53C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D554213CD
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61482641CA;
	Thu, 20 Feb 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9SMbXV1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DA2641C3;
	Thu, 20 Feb 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080421; cv=none; b=c4YTbgceMwidREEhee/finkUEY97jLAA+z4whHRJO8szkuUaaKo7DS0c+yGrH6oqWK/BXRlgFpEIGPtDIbqcCl1dcybp+U9X36az6rHyDIiG05/xrdlL91w7oN4jppukrtkAnJbfF+RjMuKS3drOGcibn0ME0QYcCkZGhEe3w5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080421; c=relaxed/simple;
	bh=hqCoKjej+HHeQWhag6pZZ21Tn6VeD1hPTK2ajP5mzTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH6Ox4skaNaEcNFSksUJfp5RHM3zA6cBpvEAAj1WP7C5be35INFFhZ9wLdkDt8NWgGIRz66HY4B24u38NbK8XK67GlmamteW1ocRiFPKfbrniPA6YEStXNAm0R1ngFsCZbWZU9K2JTAIHG7l7MZPiOEfqq2oipPCn/uilRPHHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9SMbXV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED810C4CEE3;
	Thu, 20 Feb 2025 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080421;
	bh=hqCoKjej+HHeQWhag6pZZ21Tn6VeD1hPTK2ajP5mzTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E9SMbXV13/O+n+JHVn3ZkQ6zLRpO/zX/ETt6+LiplteEaHOcsB/bqV9VXtWzvQzm8
	 sHjae1t4GnUgBo7yta3DnWo/n/kC2IAn1pGHpAndsUO5MtHzbKqBj1Ggvq5SyS3U1x
	 gk2jTtUTVmKqKC3qmMeuQcqX4/U/SGesE0qYDiMTvntCKaBgOb7U83WvsUtHFkiZbk
	 RzpwJMBzBgoYF5exMQba4dIS23u/OZLE/NwymQJYL4+8mciajZ1AZeoyEkDrf1sexc
	 H/Oy2HbY8JMImsa9AU7qAQlVjRqAp1OKCbIz06xbbjKFUnS+XphhSY3QxPg8V8n4j6
	 M+CJdO83ujn7g==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f3fa7ba7f4so1328500b6e.0;
        Thu, 20 Feb 2025 11:40:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6bWU7ESTWi09oEslKpcLZ5BogGFtpPKwywPDaf2Ax6g+0MKXJ5qMzO7iSotpmjy+UR0Y8zHk/Vj4=@vger.kernel.org, AJvYcCV9n1ZiMUbpwf0WFMaG3OfWQTYCzL/brXm4+wMs+8VOSFuWy2fbW53GaUMZXwhc7piRv8Eg2gY4v5D7KNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BLHsCcxYcrN0ylDRqVEXRvzGSRHDrU4a5q3anlz3Lenczvnj
	S++IuWY2WSRxmBgSY26Bf9uW9BY3M/qqcqWlaUrJ9mfI9q4mC5M7A8l1DGWHXgVptV8Ua7KsZkJ
	8cwUEqOnbC1aI1HvaTUKdtLSV5N8=
X-Google-Smtp-Source: AGHT+IHWV2RVedyag4xEq/eZocEihT21AL0l6xxWtsJ3G+q055XmaMvqdtKSX60qspfED8kb5ejbpgVxWsGX3lwcS6U=
X-Received: by 2002:a05:6808:3987:b0:3f4:9e6:fb7 with SMTP id
 5614622812f47-3f424c163c7mr457397b6e.1.1740080420264; Thu, 20 Feb 2025
 11:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-power-allocator-weight-v1-1-79b1a99e94eb@chromium.org>
In-Reply-To: <20250219-fix-power-allocator-weight-v1-1-79b1a99e94eb@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 20:40:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h8MyqEgC8Hf1_s4=kCj2W3Y0TWdVnbhwAiVLqED7WPow@mail.gmail.com>
X-Gm-Features: AWEUYZmMyp9vg4hoThN2tGblMv8_mn1f8LkJzK_odRUXDFoN5MveJJKCYiPo29Y
Message-ID: <CAJZ5v0h8MyqEgC8Hf1_s4=kCj2W3Y0TWdVnbhwAiVLqED7WPow@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Update total_weight on bind
 and cdev updates
To: Yu-Che Cheng <giver@chromium.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:07=E2=80=AFAM Yu-Che Cheng <giver@chromium.org> w=
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
> Update total_weight when bind and cdev updates to ensure total_weight is
> correct.
>
> Fixes: a3cd6db4cc2e ("thermal: gov_power_allocator: Support new update ca=
llback of weights")
> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> ---
>  drivers/thermal/gov_power_allocator.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 3b644de3292e..600cb0e367c3 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -656,11 +656,10 @@ static void power_allocator_update_tz(struct therma=
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

This is basically fine, but I would add a new function, say
power_allocator_update_weight(), for updating the weight.

>         case THERMAL_INSTANCE_WEIGHT_CHANGED:

And I'd call it from here and from power_allocator_bind() below.

>                 params->total_weight =3D 0;
>                 list_for_each_entry(instance, &td->thermal_instances, tri=
p_node)
> @@ -731,6 +730,8 @@ static int power_allocator_bind(struct thermal_zone_d=
evice *tz)
>
>         tz->governor_data =3D params;
>
> +       power_allocator_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED);

Because this is kind of confusing (although it will work AFAICS).

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

