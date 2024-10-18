Return-Path: <linux-pm+bounces-15982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3C9A43EC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A9F1C23A23
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ACD202F9F;
	Fri, 18 Oct 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I54s75ab"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C0202F8E;
	Fri, 18 Oct 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269399; cv=none; b=mnAqhnQxFj+IpvsliE7ZVU0YW6h+EmdEKbvq9pB3KHJ5g2lVG58rn+YvTlVFNtrmQheIwMTFKsITvCH/iHrp2SVaSSz21mBFfeDAo/f2Cm5fE6NujuC2sfAwyFSX647w8/F8pc+N+lXOtUaBvKLiaaePzkwewf+lQihmcD9YjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269399; c=relaxed/simple;
	bh=jq7Y7/frNkQWdKn6/pE62Zi+RO0e0r/Z5zuFlEysqj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFwAMp7gPkcPVQ5paOW6yJu9nQThQvd5AKSrI3Xzuqvg7RSFvORm0rPMK49sajV6De/NOBKqrCLD9CQdL2WhqLp0BFIVxVhDV+eUB3XMDHpNPnSHFsvz5tDv+a5Igi4vCgUF7JscDW56S0I0ZzQ/O9+cU/FNszhIoSucWQ7k4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I54s75ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ED5C4CED2;
	Fri, 18 Oct 2024 16:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729269398;
	bh=jq7Y7/frNkQWdKn6/pE62Zi+RO0e0r/Z5zuFlEysqj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I54s75ab423OKHdT4qZEmxInLP1Stn4BTpeGesyteaCQGb+0Mrh2gTD9v6Pt4ola/
	 1jYN1BWEIkKK5Mpz3DTgh110hZhUOV8+pX3dfWMnvDIDWi9t5+7apjfj0RhsyDRfou
	 6yHdojYXAfQEgpxrK2pJGCEfZxNjdj/OSAgAPPA4UesViFH/E/vrWW3ZDudcqn1jH/
	 C70gufEGp4Z42suCNypxF3BSecmzI1l6KTY55ZJh/ZYzWOR2754uRAy6waivDq1dgG
	 z6WF0yV730QReLMl4yiXY4PFjM+DkwilEFpmXxl8Ehdge1ZeXO5gAL1nmuZe08BmuA
	 KWy6dRoIb4Pow==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27d0e994ae3so1067858fac.3;
        Fri, 18 Oct 2024 09:36:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVF8lA4Ul3XBrnRFPT39ALwWLXcvtr06K2VQMuBYO+XG5jH9SwbUEiG77VN5XJ5VfXKbDK1sfaeFak=@vger.kernel.org, AJvYcCWaNr8lT6K8Q3AnIOxR9+882AxW3vraH9arLoJCO7X3PRT5SmKNKpeAeTF0DamYk9h6FTUCmB5pgEej9FM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6IAw1Y4DKd46Ea7Kx9w9PiymvGhLZmuOcKNe7fqm1RP8DaCLa
	wdq7B6kNwg111yRUsSD0gptISwYp3th21G91Jke8N+/Pi4rM4h57C9eK1n7LvW0BPtu2+BAWP1C
	JeQV2H80zYHqeC57/ip0OyLM4at0=
X-Google-Smtp-Source: AGHT+IF/9GJqtgMfEJw36ojuns+DX+VC12ggt1IRZE7FcP/Z+sN2K2q6OqZVUcCj0lDRDIR1nrTiGTo2/XYmlcO1fzI=
X-Received: by 2002:a05:6870:c0ce:b0:260:e3fa:ab8d with SMTP id
 586e51a60fabf-2892c562e82mr2714739fac.37.1729269398081; Fri, 18 Oct 2024
 09:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018073139.1268995-1-wenst@chromium.org>
In-Reply-To: <20241018073139.1268995-1-wenst@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Oct 2024 18:36:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5B_h0BudqnHKRD0GL5-xpiwp21=Hx+dH-FaRXD6yu8g@mail.gmail.com>
Message-ID: <CAJZ5v0g5B_h0BudqnHKRD0GL5-xpiwp21=Hx+dH-FaRXD6yu8g@mail.gmail.com>
Subject: Re: [PATCH v4] thermal/of: support thermal zones w/o trips subnode
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Icenowy Zheng <uwu@icenowy.me>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 9:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> From: Icenowy Zheng <uwu@icenowy.me>
>
> Although the current device tree binding of thermal zones require the
> trips subnode, the binding in kernel v5.15 does not require it, and many
> device trees shipped with the kernel, for example,
> allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
> comply to the old binding and contain no trips subnode.
>
> Allow the code to successfully register thermal zones w/o trips subnode
> for DT binding compatibility now.
>
> Furtherly, the inconsistency between DTs and bindings should be resolved
> by either adding empty trips subnode or dropping the trips subnode
> requirement.
>
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> [wenst@chromium.org: Reworked logic and kernel log messages]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> This patch is based on Krzysztof's cleanup patches
>   - thermal: of: Use scoped memory and OF handling to simplify thermal_of=
_trips_init() [1]
>
> Changes since v3:
>   - Set *ntrips =3D 0 and return NULL from thermal_of_trips_init() if
>     no trip points are found in the device tree (Rafael)
>   - Dropped log level of "no trip points found" message to INFO
>   - Reworded new "failed to find trip points" message to "no trip points
>     found"
>   - Reworded existing "failed to find trip points" message to "failed to
>     parse trip points"
>
> I dropped Mark's reviewed-by because of the new changes.
>
> Changes since v2:
> - Stacked on top of Krzysztof's cleanup patches
>   - thermal: of: Use scoped memory and OF handling to simplify thermal_of=
_trips_init() [1]
> - Adjusted to account for eliminated error path
>
> [1] https://lore.kernel.org/all/20241010-b4-cleanup-h-of-node-put-thermal=
-v4-2-bfbe29ad81f4@linaro.org/
>
> Changes since v1:
> - set *ntrips at beginning of thermal_of_trips_init()
> - Keep goto out_of_node_put in of_get_child_count(trips) =3D=3D 0 branch
> - Check return value of thermal_of_trips_init(), if it is -ENXIO, print
>   warning and clear |trips| pointer
> - Drop |mask| change, as the variable was removed
>
> ---
>  drivers/thermal/thermal_of.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 93f7c6f8d06d..abafce22c91f 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -99,14 +99,16 @@ static struct thermal_trip *thermal_of_trips_init(str=
uct device_node *np, int *n
>
>         struct device_node *trips __free(device_node) =3D of_get_child_by=
_name(np, "trips");
>         if (!trips) {
> -               pr_err("Failed to find 'trips' node\n");
> -               return ERR_PTR(-EINVAL);
> +               pr_debug("Failed to find 'trips' node\n");
> +               *ntrips =3D 0;
> +               return NULL;
>         }
>
>         count =3D of_get_child_count(trips);
>         if (!count) {
> -               pr_err("No trip point defined\n");
> -               return ERR_PTR(-EINVAL);
> +               pr_debug("No trip point defined\n");
> +               *ntrips =3D 0;
> +               return NULL;
>         }
>
>         struct thermal_trip *tt __free(kfree) =3D kzalloc(sizeof(*tt) * c=
ount, GFP_KERNEL);
> @@ -386,11 +388,14 @@ static struct thermal_zone_device *thermal_of_zone_=
register(struct device_node *
>
>         trips =3D thermal_of_trips_init(np, &ntrips);
>         if (IS_ERR(trips)) {
> -               pr_err("Failed to find trip points for %pOFn id=3D%d\n", =
sensor, id);
> +               pr_err("Failed to parse trip points for %pOFn id=3D%d\n",=
 sensor, id);
>                 ret =3D PTR_ERR(trips);
>                 goto out_of_node_put;
>         }
>
> +       if (!trips)
> +               pr_info("No trip points found for %pOFn id=3D%d\n", senso=
r, id);
> +
>         ret =3D thermal_of_monitor_init(np, &delay, &pdelay);
>         if (ret) {
>                 pr_err("Failed to initialize monitoring delays from %pOFn=
\n", np);
> --

