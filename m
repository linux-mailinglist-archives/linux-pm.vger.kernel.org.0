Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206BD7E800E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Nov 2023 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjKJSEM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Nov 2023 13:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjKJSC6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2023 13:02:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCA43821E;
        Fri, 10 Nov 2023 05:55:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54366784377so3339096a12.3;
        Fri, 10 Nov 2023 05:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699624518; x=1700229318; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UswF9wK9RxveNOhJEzFqGZeqyG/2CbmNW7YwWxlNx9Y=;
        b=kObNMqbFoSq+C9Z+y0630uHbW7gg1XxcTO9LwxelRoqse/+iFLBl9PuYr26Rcuqt1z
         TXWPnkteSPzr+enLFU0TDXG6sNy3eBqN/6hZp0IklKqAeiSc09V08wtkGmpnMdfOhprF
         pmDXdAHYIhxrS9pkudCID5z5cYA8HF4EoY8A8dWgBHm23mtXgjgWV3zgvLNHxM8/ePZK
         p1KozMuor5efO6Q/shOyyaE38V31uWMr1rHM+JjGeoo25hLmLTXlaV5XqHUmIUSv6ly0
         +ZsTQ2o4mrr4jDtTmPLvEJEKfw6FqOJYHKIAL3ovY8wUaguyCJ8x0ADAaJrnLuh6d6Ud
         n1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624518; x=1700229318;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UswF9wK9RxveNOhJEzFqGZeqyG/2CbmNW7YwWxlNx9Y=;
        b=I/o+yVMNL69iv31ZDjT+QTzrHwI1wAlBKqCoOajqv1rPpRxROTSSIgdws9wl5Q5Ukk
         Y4RXEmusV6Ltjl8hbZlCosWnU25VctjSUenMoOfXmJ9vxU1tYJDaB5LtAv12T7yT/cYn
         2U/04FWBH9Ohi3Lsw5mQap9DLK5iVtwLfMhaWbCvaXwtlz8+bVpMFIip31dVafk6ys7J
         x+S3V/xNyu3hQamOKjDbr8YHsPFLbRgi6HXknh4/bbKxo/9TmBAXeFGANhPy6MRaYjH7
         Wk9pfzxDfij4MkcWW6SFgn38M0zWiatPpRCA/e2aDcvXEY3Yz74/77yY8CLI4bkE3WPQ
         lGpw==
X-Gm-Message-State: AOJu0Yx5Gzj4iD8+d02Hncnp+VhgkHoIe1hEA4YQpfI044rFHLdtV3SP
        mAkA4RiPfASJzCVc+YDv3WI=
X-Google-Smtp-Source: AGHT+IEkxvsbJHesJxJKfEdDzxhg4FI5naEHpbkF9lSpoTT7SFYoAjys9SfU2a4kKs4y9A8VgVxhpQ==
X-Received: by 2002:a50:c050:0:b0:543:74e6:9da2 with SMTP id u16-20020a50c050000000b0054374e69da2mr7671284edd.0.1699624517451;
        Fri, 10 Nov 2023 05:55:17 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a2-20020a50ff02000000b0053e8f1f79afsm1165989edu.30.2023.11.10.05.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:55:16 -0800 (PST)
Date:   Fri, 10 Nov 2023 14:55:15 +0100
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
Message-ID: <ZU42Qx0TbtEswEuA@orome.fritz.box>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <20231012175836.3408077-7-thierry.reding@gmail.com>
 <ea6c4056-9e7c-4aa3-b207-a97436682b8e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ifyYy2hSJpHxEx3"
Content-Disposition: inline
In-Reply-To: <ea6c4056-9e7c-4aa3-b207-a97436682b8e@linaro.org>
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


--2ifyYy2hSJpHxEx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 05:57:13PM +0200, Daniel Lezcano wrote:
> On 12/10/2023 19:58, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The SOCTHERM's built-in throttling mechanism doesn't map well to the
> > concept of a cooling device because it will automatically start to
> > throttle when the programmed temperature threshold is crossed.
> >=20
> > Remove the cooling device implementation and instead unconditionally
> > program the throttling for the CPU and GPU thermal zones.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
>=20
> [ ... ]
>=20
> > +	ret =3D of_property_read_u32(np, "temperature-millicelsius",
> > +				   &stc->temperature);
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	ret =3D of_property_read_u32(np, "hysteresis-millicelsius",
> > +				   &stc->hysteresis);
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	stc->num_zones =3D of_count_phandle_with_args(np, "nvidia,thermal-zon=
es",
> > +						    NULL);
> > +	if (stc->num_zones > 0) {
> > +		struct device_node *zone;
> > +		unsigned int i;
> > +
> > +		stc->zones =3D devm_kcalloc(ts->dev, stc->num_zones, sizeof(zone),
> > +					  GFP_KERNEL);
> > +		if (!stc->zones)
> > +			return -ENOMEM;
> > +
> > +		for (i =3D 0; i < stc->num_zones; i++) {
> > +			zone =3D of_parse_phandle(np, "nvidia,thermal-zones", i);
> > +			stc->zones[i] =3D zone;
> > +		}
> > +	}
>=20
> What is the connection between the temperature sensor and the hardware
> limiter?
>=20
> I mean, one hand there is the hardware limiter which is not connected to =
the
> sensor neither a thermal zone and it could be self contained in a separate
> driver. And then there is the temperature sensor.
>=20
> The thermal zone phandle things connected with the throttling bindings
> sounds like strange to me.
>=20
> What prevents to split the throttling and the sensor into separate code?

Both the temperature sensor and the hardware throttle mechanism are part
of the same IP block, so it would be quite difficult (and unnecessary)
to split them into separate drivers.

The hardware throttler uses the temperature sensor's data to initiate
throttling automatically when certain (programmable) temperature
thresholds are reached.

The reason why we need to reference the thermal zone is because the
registers needed to program the throttler are contained within the
sensor group (which are effectively mapped to thermal zones).

I suppose there are a number of other ways how this could be described.
The thermal zones could be extended with extra information about the
throttling, or we could use just the sensor group ID instead of a full
phandle to reference this.

I was sort of trying to keep things somewhat aligned with the concept of
thermal zones and not rewrite the entire thing, but perhaps I should go
back to the drawing board and think about whether there's an even better
way to describe this in DT.

Thierry

--2ifyYy2hSJpHxEx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVONkAACgkQ3SOs138+
s6FLgQ/+L/ArqQGbn+pd8w9dyyEkvK0jYYuf2nmQyyj/6o01UxsJoBNFREXDlBt7
2Qwd8eHD1hTkPrphvBX1BbO03pxG/wUk7nYesjGTEKot9CdEDdIpIgx5j8CnONxu
BYiIwOLCYiaGG46H5eEMM9fVfqNmU7zLf1zLERUEDbPNY2dpGKRRrBnsTT1KzChy
6ynwh+Yvbtohnw3I9OFsDKRf/8y+X8aqnXFLHRf3pbiZFEIShuJFflKbwidfincl
QY8pFOA9W3avFbykVPU6i3pH5JB6Z7D+3Xq5G92PCjcoIP0H3QRMw/Ai9PJY0FYv
YZj8JOmHdEKJfzh0DtFICAKFdBTUzQDgZPjOcmJ9LuCDt8SLQwbiloDxuJBb8Q9j
BsSJckkWZ4I2AcxSpgkHWYYH+uW4q4vCkRSVGpzCovUtT5Mz1zOKJeTANTbonXT5
zKdpCDTuyNIYdzj5F5Xnw/tRf9yNBqXsc9P9gDecY7Hgsu4iAcQnUCjm5CBpDRoJ
tTgzsfFl72WaAgLnMqSGQ6uOwFPLJM8rgsUfi0K5L3X6ufoWziz62YZGxAyTroVi
0weQCtzTwiYoij9sem3NuLyIi0FdtQPEVCMFMuWw0TdiPDLiTDpOJlSTK24AsJQR
r+tRXyeLmY98I1s5EoEHaLScLDBdqgBxjIlah8xQNBf3tuMlu+M=
=XD6k
-----END PGP SIGNATURE-----

--2ifyYy2hSJpHxEx3--
