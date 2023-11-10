Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5487E7FAB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Nov 2023 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKJR4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Nov 2023 12:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjKJR4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2023 12:56:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3D39CF5;
        Fri, 10 Nov 2023 06:52:07 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e5dd91b0acso169383266b.1;
        Fri, 10 Nov 2023 06:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699627925; x=1700232725; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUEzrt6LnSYKVuLiy7Ui5TbYUeY2rCJFWs9eh21yfSQ=;
        b=N459vG7Lw0zP4FERRd9c5HrSTv1DgCxlMg5Yva0Vj4vfxwmGJ9iR3XkXIstez9Qc9T
         gbLozGPz0p2W2zP9wSPNpedzsV5MtnWI0lw7y3DWZxLDjJtIhhS9PxPBR7cBsJ6f4qqT
         Os5Mgg+zxHZ+jPq9gqHmcTYSni7WOe5Hn25NgS7E4gzxbWiQW49UceF3KE/ncOznbzKk
         biI91hE1pdBaWHFoRgjgKoIckcSlmKegupCMoIe64Iv7luiV9AlPfsgFQvsHz806qIO2
         CBNtHpn+cf5uocMbEImeNAwPiK2uuqolOVlLBGb+TZFWv0RKTK3OKQvsKUSJXrC1J7LK
         9EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627925; x=1700232725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUEzrt6LnSYKVuLiy7Ui5TbYUeY2rCJFWs9eh21yfSQ=;
        b=wQxRGK77gSyC6dGn112nW+v5BF7GOPWbfGhLsnc05KtuXTuoQcKP0Zr7xhZj+WvDhc
         shHfI8iuN//jmemtItbXdvfRS84oPnrtUbUeuhS4OoUYXJ1xdH4VO9frefpNcn6r98IO
         bYNET9O9rLfVHbSLxbA5YN+7GMdLtjsRVGD+Nt0X78rNhS1hCNdhttK+nlFeL5nXZ12J
         uqP5CWHtihMf/K8BVRdMMSUGoJsbs1HtYhH/3pAMYmtrWDrGQqtuu1D1BbMX2XLOwtOe
         iKCzy9i2gsRSu5/8sPfqcaj6FAugmcw11+4yScA/gO+ctY/G41+q4cpgXO3qKRng8cD4
         StHA==
X-Gm-Message-State: AOJu0Yw4rfRmFNXxTekwKcIMZcbg36jgCkbAEL/mQeXhVVu93W1VjZm/
        y3PGEisSGiUyf6zoys7Jmwc=
X-Google-Smtp-Source: AGHT+IESaXlUINHGuDXQaH0aNuCKd4f12GL8A8lvqxsxSuyNg3jrVz+dUUX7L52wthxGmDaz3sfDvQ==
X-Received: by 2002:a17:906:6ad2:b0:9e3:b1e5:aec3 with SMTP id q18-20020a1709066ad200b009e3b1e5aec3mr6851814ejs.0.1699627925167;
        Fri, 10 Nov 2023 06:52:05 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w21-20020a50d795000000b0053de19620b9sm1258895edi.2.2023.11.10.06.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:52:04 -0800 (PST)
Date:   Fri, 10 Nov 2023 15:52:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 06/13] thermal: tegra: Do not register cooling device
Message-ID: <ZU5Dk6IAcCr7Yk94@orome.fritz.box>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <20231012175836.3408077-7-thierry.reding@gmail.com>
 <ea6c4056-9e7c-4aa3-b207-a97436682b8e@linaro.org>
 <ZU42Qx0TbtEswEuA@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uiM2cXXv5cXnyflD"
Content-Disposition: inline
In-Reply-To: <ZU42Qx0TbtEswEuA@orome.fritz.box>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uiM2cXXv5cXnyflD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 02:55:15PM +0100, Thierry Reding wrote:
> On Fri, Oct 13, 2023 at 05:57:13PM +0200, Daniel Lezcano wrote:
> > On 12/10/2023 19:58, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > The SOCTHERM's built-in throttling mechanism doesn't map well to the
> > > concept of a cooling device because it will automatically start to
> > > throttle when the programmed temperature threshold is crossed.
> > >=20
> > > Remove the cooling device implementation and instead unconditionally
> > > program the throttling for the CPU and GPU thermal zones.
> > >=20
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> >=20
> > [ ... ]
> >=20
> > > +	ret =3D of_property_read_u32(np, "temperature-millicelsius",
> > > +				   &stc->temperature);
> > > +	if (ret < 0)
> > > +		goto err;
> > > +
> > > +	ret =3D of_property_read_u32(np, "hysteresis-millicelsius",
> > > +				   &stc->hysteresis);
> > > +	if (ret < 0)
> > > +		goto err;
> > > +
> > > +	stc->num_zones =3D of_count_phandle_with_args(np, "nvidia,thermal-z=
ones",
> > > +						    NULL);
> > > +	if (stc->num_zones > 0) {
> > > +		struct device_node *zone;
> > > +		unsigned int i;
> > > +
> > > +		stc->zones =3D devm_kcalloc(ts->dev, stc->num_zones, sizeof(zone),
> > > +					  GFP_KERNEL);
> > > +		if (!stc->zones)
> > > +			return -ENOMEM;
> > > +
> > > +		for (i =3D 0; i < stc->num_zones; i++) {
> > > +			zone =3D of_parse_phandle(np, "nvidia,thermal-zones", i);
> > > +			stc->zones[i] =3D zone;
> > > +		}
> > > +	}
> >=20
> > What is the connection between the temperature sensor and the hardware
> > limiter?
> >=20
> > I mean, one hand there is the hardware limiter which is not connected t=
o the
> > sensor neither a thermal zone and it could be self contained in a separ=
ate
> > driver. And then there is the temperature sensor.
> >=20
> > The thermal zone phandle things connected with the throttling bindings
> > sounds like strange to me.
> >=20
> > What prevents to split the throttling and the sensor into separate code?
>=20
> Both the temperature sensor and the hardware throttle mechanism are part
> of the same IP block, so it would be quite difficult (and unnecessary)
> to split them into separate drivers.
>=20
> The hardware throttler uses the temperature sensor's data to initiate
> throttling automatically when certain (programmable) temperature
> thresholds are reached.
>=20
> The reason why we need to reference the thermal zone is because the
> registers needed to program the throttler are contained within the
> sensor group (which are effectively mapped to thermal zones).
>=20
> I suppose there are a number of other ways how this could be described.
> The thermal zones could be extended with extra information about the
> throttling, or we could use just the sensor group ID instead of a full
> phandle to reference this.
>=20
> I was sort of trying to keep things somewhat aligned with the concept of
> thermal zones and not rewrite the entire thing, but perhaps I should go
> back to the drawing board and think about whether there's an even better
> way to describe this in DT.

I've looked at the documentation in a bit more details and here's an
high-level overview of what SOCTHERM is.

We have four groups (CPU, GPU, MEM and PLLX), each of which can be
programmed at four different levels (each level is an identical set of
registers to program temperature thresholds, throttling and enable or
disable). For temperature thresholds an interrupt can be configured.

There's an additional "thermtrip" level, which only has a threshold
that, when reached, will cause an emergency, hardware-induced shutdown
of the system.

Any of the generic levels can be used in whatever way we want. The
convention currently is to program the thermal zone trip points using
level 0. So for each group we create a thermal zone and level 0 for each
of the zones is programmed with the low and high thresholds for a given
trip point.

Currently we also use levels 1 and 2 to program the "light" and "heavy"
throttling "indicators". These will in turn be used to generate outputs
to the actual throttling mechanisms (CPU-light, CPU-heavy, GPU-light and
GPU-heavy).

There are a few other things that can be done, but I don't fully
understand how they would be useful and I don't think they've ever been
used, so I'll skip those for now.

Given the above, the thermal zone trip points are fairly clear. They are
fine as they are implemented. For the throttling mechanism we could do
something that maps more explicitly to the above groups and levels
concepts, but I think that could easily conflict with the trip points
programming, so keeping with the current conventions seems good and
designing the device tree bindings accordingly would help avoid any
conflicts.

So I think keeping the throttle-cfgs node is a good fit. We don't really
need to establish a connection between the thermal zone and the throttle
mechanism, though. We can derive the level from the indicator (light or
heavy) and for the group we only need an ID. The reason why I proposed a
link to the thermal-zone is because that thermal zone contains that ID
already, but we could equally well just add an nvidia,group property or
something along those lines so we know which group to use rather than
try and get it from a thermal zone.

I'll revise the bindings to see if I can come up with something.

Thierry

--uiM2cXXv5cXnyflD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVOQ5AACgkQ3SOs138+
s6Epgg//e56A3BC6nklcLSQfJlb8LMfKw7cfhKBYvPOVwtl9lpTKHYwtIUzVTxj6
MCgXB3YxP0xn7LkcS35YSw3+BQSqvNbGhrSIxRXe2U5RIyYUYxZMUpKHq77Oud6h
/YZWH7KP8XLwmEvUcJXk7FHvrKX2NffbA8SCs6vK1xO8YAtZGF6SoJfZJMp9LinJ
1JdUT6YNLAH9onFNqsd9HvN91M1ogMqoSHVQ8xEhbPMggBuv8FJYeAOgo3fFSZRD
0ckvdpvS0ysegRWQ5Z2iBvUiAhwWGoVf6AMdJC3ekRJwQdr2qdyZwOPygteHtj7c
nXGLoYtM0Ylm78vrceVQ7nbgP3pXPhyAiDPY+IjaB8LNtLTedNgEk2WzVdpWTGpM
vNaPJVi3iKwNJ9cTIOu8Dzh40pAaYEqBsYpTicFXsxTqqO0YkFncLcQzzl6I0Ksj
YQMztE8YMz5oj78mxbMsxiUEZ5rzcPF1SaVZK4xwcyFoyVn2BAS+GO0B6noSd/e6
KRqcPyeoSzAJl1aL5f46qz/a/8O6/CFcU0FzST3NVS9gm0o1ZKHnd0gRHk2T9yVo
ZaIrjSi2B+SvvJ5ESL7A3qOjkjqaT8idGQSd+uqXTsJJcPrhTtZBsSIe3qhQberr
rM6xiL0fR2TndClqxK1CYeozWiQHZbRzg8/2b1f34M4MXf78eAs=
=Ne01
-----END PGP SIGNATURE-----

--uiM2cXXv5cXnyflD--
