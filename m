Return-Path: <linux-pm+bounces-10194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D132D91C00C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513E81F211E6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD41BE876;
	Fri, 28 Jun 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKIAxit7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E21BE86A;
	Fri, 28 Jun 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582976; cv=none; b=WSg4Ul6vitmUW6KH2lEvjf0stZmsfh+Iv2u3KKc6wRIttcD6CYzosyi6WBYrfZFz98oqgzqAsjRPDggCXMwObtiKO0RVc54yGKKDHXaHrGVVejQOwG0tKConf4tFA+jZRxUnvDJJNpo7U+71UAg78CgNTuse0VSEZIDKLoYutk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582976; c=relaxed/simple;
	bh=uuGfVhtrSJSncGQAm5FKxyqOUX2TvLhYQc+8uxapyfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dx9rTsBzdBONs9+E5MggAWcogsGO8wRqUxDwf+4dlcKs3aJcg8Gy0HcB9lG7/JLA8IL3w8Q+sH0BUpH/hbvLvf+0Lyq73qpr1IaPdvle5sfmUKHswMdJlvTA40fGm8S0ub+mfvB3R4vgtOflHjZTmgasZwkK/1sHPhtYKQY2070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKIAxit7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA40C4AF0B;
	Fri, 28 Jun 2024 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719582976;
	bh=uuGfVhtrSJSncGQAm5FKxyqOUX2TvLhYQc+8uxapyfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pKIAxit7mEekCWoFMhO0TwG4DQDi45J3e1COQO25+Uz2iUJqJEaY7bK+Ofho19Blr
	 IiJpgfngUpxuoa9appozhqnxuy2+gWOojLRFRqQRtSCWHGtPUhpXnUuJ4e78MRPaIn
	 Zb6tz0Ujczlsb5Ft2yA8jfOVsMOqzSORg8QChg0ZCV8tqeb6PhqNM33F3tJ+3hQsoE
	 chlXUHrz1Nd85YUgWD6w66P1hsR11nJlXSIqQORocHUbVi1HCz2wM8tJSWu+Gt5p7w
	 m3LUUs1yfEYDKnKRPP9iv12zVXu8EIJo34PByfK5F42awDbSNO+V3DyzQV78wKAe+n
	 dL9gWCrPGtvgw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24c5ec50da1so105158fac.3;
        Fri, 28 Jun 2024 06:56:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwbnSpLDuBOFEuRpuuHEW1IXpPuSm1tX9VBli58zONsOMPwfOH9R6bWS8yLc77DcvHawzo7LUsboN2ELcUvrfPjdPjfO6wpgXRROOl0yRSei1Gm06YAsrM1KYB3Qt2AFYAp/F1bv3z1eQWvVwsG4+8Uob0hGy8ULEJuXVWx6Qx+zQn
X-Gm-Message-State: AOJu0YxdNB3fv20VRBtbnAw4syP58bmP3XjDvdrxJO7DRXCWeBPeoNMI
	v20UgYUjlqmwrzaZVbpECJfIo2pdSTFq9cyqEC6dqIFW8qZ2BJabL5FdVryPRA90UoqJwvztCO9
	CESWV4+iyE02UwG0RCwew9IxrlC0=
X-Google-Smtp-Source: AGHT+IEX7rPoas1TpLj5qVxI/aiEo+17h38Ck3qE1izpJ/wb83v/fdSxe/MggSfJin1xMq2xJL9+GZHmqGCS3QzwsuQ=
X-Received: by 2002:a05:6870:5589:b0:250:826d:5202 with SMTP id
 586e51a60fabf-25cf3f2d0bbmr19118740fac.3.1719582975158; Fri, 28 Jun 2024
 06:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
In-Reply-To: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 15:56:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iO6MrX3QxAu4Wj4grUL2g7gPPXO3f8PFmZBot-Ud32TQ@mail.gmail.com>
Message-ID: <CAJZ5v0iO6MrX3QxAu4Wj4grUL2g7gPPXO3f8PFmZBot-Ud32TQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:55=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Currently the thermal framework has 4 trip point types:
>
> - active : basically for fans (or anything requiring energy to cool
>   down)
>
> - passive : a performance limiter
>
> - hot : for a last action before reaching critical
>
> - critical : a without return threshold leading to a system shutdown
>
> A thermal zone monitors the temperature regarding these trip
> points. The old way to do that is actively polling the temperature
> which is very bad for embedded systems, especially mobile and it is
> even worse today as we can have more than fifty thermal zones. The
> modern way is to rely on the driver to send an interrupt when the trip
> points are crossed, so the system can sleep while the temperature
> monitoring is offloaded to a dedicated hardware.
>
> However, the thermal aspect is also managed from userspace to protect
> the user, especially tracking down the skin temperature sensor. The
> logic is more complex than what we found in the kernel because it
> needs multiple sources indicating the thermal situation of the entire
> system.
>
> For this reason it needs to setup trip points at different levels in
> order to get informed about what is going on with some thermal zones
> when running some specific application.
>
> For instance, the skin temperature must be limited to 43=C2=B0C on a long
> run but can go to 48=C2=B0C for 10 minutes, or 60=C2=B0C for 1 minute.
>
> The thermal engine must then rely on trip points to monitor those
> temperatures. Unfortunately, today there is only 'active' and
> 'passive' trip points which has a specific meaning for the kernel, not
> the userspace. That leads to hacks in different platforms for mobile
> and embedded systems where 'active' trip points are used to send
> notification to the userspace. This is obviously not right because
> these trip are handled by the kernel.
>
> This patch introduces the 'user' trip point type where its semantic is
> simple: do nothing at the kernel level, just send a notification to
> the user space.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml        | 1 +
>  drivers/thermal/thermal_core.c                            | 8 ++++++++
>  drivers/thermal/thermal_of.c                              | 1 +
>  drivers/thermal/thermal_trace.h                           | 4 +++-
>  drivers/thermal/thermal_trip.c                            | 1 +
>  include/uapi/linux/thermal.h                              | 1 +
>  6 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml=
 b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 68398e7e8655..cb9ea54a192e 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -153,6 +153,7 @@ patternProperties:
>                type:
>                  $ref: /schemas/types.yaml#/definitions/string
>                  enum:
> +                  - user     # enable user notification
>                    - active   # enable active cooling e.g. fans
>                    - passive  # enable passive cooling e.g. throttling cp=
u
>                    - hot      # send notification to driver
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2aa04c46a425..506f880d9aa9 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -734,6 +734,14 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_de=
vice *tz,
>         if (tz !=3D pos1 || cdev !=3D pos2)
>                 return -EINVAL;
>
> +       /*
> +        * It is not allowed to bind a cooling device with a trip
> +        * point user type because no mitigation should happen from
> +        * the kernel with these trip points
> +        */
> +       if (trip->type =3D=3D THERMAL_TRIP_USER)
> +               return -EINVAL;

Maybe print a debug message when bailing out here?

A check for "user" trips would need to be added to
thermal_governor_trip_crossed() and to the .manage() callbacks in the
power allocator, step-wise and fair-share governors, if I'm not
mistaken.  Especially fair-share and power allocator should not take
them into account IMV.

> +
>         /* lower default 0, upper default max_state */
>         lower =3D lower =3D=3D THERMAL_NO_LIMIT ? 0 : lower;
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index aa34b6e82e26..f6daf921a136 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -60,6 +60,7 @@ static const char * const trip_types[] =3D {
>         [THERMAL_TRIP_PASSIVE]  =3D "passive",
>         [THERMAL_TRIP_HOT]      =3D "hot",
>         [THERMAL_TRIP_CRITICAL] =3D "critical",
> +       [THERMAL_TRIP_USER]     =3D "user",
>  };
>
>  /**
> diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_tr=
ace.h
> index df8f4edd6068..739228ecc2e2 100644
> --- a/drivers/thermal/thermal_trace.h
> +++ b/drivers/thermal/thermal_trace.h
> @@ -15,13 +15,15 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
> +TRACE_DEFINE_ENUM(THERMAL_TRIP_USER);
>
>  #define show_tzt_type(type)                                    \
>         __print_symbolic(type,                                  \
>                          { THERMAL_TRIP_CRITICAL, "CRITICAL"},  \
>                          { THERMAL_TRIP_HOT,      "HOT"},       \
>                          { THERMAL_TRIP_PASSIVE,  "PASSIVE"},   \
> -                        { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
> +                        { THERMAL_TRIP_ACTIVE,   "ACTIVE"}),   \
> +                        { THERMAL_TRIP_USER,     "USER"})
>
>  TRACE_EVENT(thermal_temperature,
>
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_tri=
p.c
> index 2a876d3b93aa..a0780bb4ff0d 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -10,6 +10,7 @@
>  #include "thermal_core.h"
>
>  static const char *trip_type_names[] =3D {
> +       [THERMAL_TRIP_USER] =3D "user",
>         [THERMAL_TRIP_ACTIVE] =3D "active",
>         [THERMAL_TRIP_PASSIVE] =3D "passive",
>         [THERMAL_TRIP_HOT] =3D "hot",
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index fc78bf3aead7..84e556ace5f5 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -14,6 +14,7 @@ enum thermal_trip_type {
>         THERMAL_TRIP_PASSIVE,
>         THERMAL_TRIP_HOT,
>         THERMAL_TRIP_CRITICAL,
> +       THERMAL_TRIP_USER,
>  };
>
>  /* Adding event notification support elements */
> --
> 2.43.0
>

