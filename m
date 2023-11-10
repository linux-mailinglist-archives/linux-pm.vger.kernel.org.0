Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FAE7E80B1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Nov 2023 19:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbjKJSRY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Nov 2023 13:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345363AbjKJSPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2023 13:15:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80150171B;
        Fri, 10 Nov 2023 05:58:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e62b14c9eeso108572666b.2;
        Fri, 10 Nov 2023 05:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699624699; x=1700229499; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNjbt0EtWa2A1C+JeS9QVXzbju/y/OeX+qJLYHRr0y4=;
        b=TMF8ZURBzTgVMbTf9asmaZtswCAe/1pIpUjReXju+AoOSQc11qdRC5l9HFnB18M6L1
         VCsTOijD6AeLUTigjeRkiQVfMs2ndwxkYBykZNOkOJAhNnDzBmjl6wZWpvuQvpp3JBDp
         /4HDVhB2tqLg944+gesA33ledsuNfj92DSff4PWatqWcrCQdcsF3PKd3GVT6j9Q9ujn9
         R0IAD4qxesr+WE3mzNNK+shdGvl6J/mnxxQv46E1B9wppLGeBM3ru1zr2mFDI6hDAneg
         X7JFhApP/7JwqMR3hQm8e3nYVmwEE+Z9xuL/dEvudELM3ExQ6EkKXH6c6M5OkXLAmXV/
         0aDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624699; x=1700229499;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNjbt0EtWa2A1C+JeS9QVXzbju/y/OeX+qJLYHRr0y4=;
        b=fE+jDHwfgk0gfd6uiQm8xfjm6Z2WVsGSqXZdF9ZHgBARy1UjrnGSkryvKKUySpVZX8
         UfPZr3uHqJo59o+4mVVpAZ/ROOy5DSenqJ03Qamib/EJIDJ2o9v0zQtJcsi7PY725Vns
         Mosdvb6iFK9qzSct4VN+WgDp7GLb0bTWF/7eP6x9lxCKXDxpHbx5xT5eraTmuzQJgZ8I
         otII6IQX1ud53a34wxfdcjO/qQhH44OriBX+9xI+q8juLNwWcqS9YOHUYeyICGeC1Ab+
         vqX050Kv9nscRFV8f6QrR3MTepYLxtdGsbeUDsi4d6qbAFZEg69wY9fTYgSngw8jagWa
         3orQ==
X-Gm-Message-State: AOJu0YxcheMQiNgprOqqPLy2yXb4ItXDZ2DGCyBCyoKGRuRteSMN9bFI
        SKO4gdtXRXfDfx9SiuKTtn4=
X-Google-Smtp-Source: AGHT+IGVQ1Y1WUrgKjE0Ruzh3iRLkcjv8OxVq2OuRdMai07SfdEZi65obyfpOC0335sUnZnRwKjZVA==
X-Received: by 2002:a17:907:9802:b0:9de:32bb:fa96 with SMTP id ji2-20020a170907980200b009de32bbfa96mr7549574ejc.9.1699624698722;
        Fri, 10 Nov 2023 05:58:18 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906038400b0099bc8bd9066sm3988035eja.150.2023.11.10.05.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:58:18 -0800 (PST)
Date:   Fri, 10 Nov 2023 14:58:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 02/13] dt-bindings: thermal: tegra: Document throttle
 temperature
Message-ID: <ZU42-H6Lk6kOPuKS@orome.fritz.box>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <20231012175836.3408077-3-thierry.reding@gmail.com>
 <20231016140249.GA2655027-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IL1DOl7t2BE0L6Kx"
Content-Disposition: inline
In-Reply-To: <20231016140249.GA2655027-robh@kernel.org>
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


--IL1DOl7t2BE0L6Kx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 09:02:49AM -0500, Rob Herring wrote:
> On Thu, Oct 12, 2023 at 07:58:23PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Each throttling configuration needs to specify the temperature threshold
> > at which it should start throttling. Previously this was tied to a given
> > trip point as a cooling device and used the temperature specified for
> > that trip point. This doesn't work well because the throttling mechanism
> > is not a cooling device in the traditional sense.
> >=20
> > Instead, allow device trees to specify the throttle temperature in the
> > throttle configuration directly so that the throttle doesn't need to be
> > exposed as a cooling device.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v2:
> > - rename temperature to temperature-millicelsius and drop $ref
> > - add hysteresis-millicelsius property
> >=20
> >  .../bindings/thermal/nvidia,tegra124-soctherm.yaml | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-=
soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-s=
octherm.yaml
> > index 04a2ba1aa946..0eb6277082fe 100644
> > --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-socther=
m.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-socther=
m.yaml
> > @@ -121,6 +121,20 @@ properties:
> >                # high (85%, TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
> >                - 3
> > =20
> > +          temperature-millicelsius:
>=20
> 'temperature' is redundant since we have units. Perhaps=20
> 'throttle-millicelsius' or 'auto-throttle-millicelsius' instead to say=20
> what the temperature is for.

Okay, will do.

>=20
> > +            minimum: -273000
> > +            maximum: 200000
>=20
> Quite impressive operating range.

Yeah, I don't actually know where these come from. Looking at the manual
these sensors are actually limited to -127=C2=B0C - 127=C2=B0C. I'll fix th=
at up.

Thierry

--IL1DOl7t2BE0L6Kx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVONvgACgkQ3SOs138+
s6Fqfg//Wrvd1xbopW4sXoP86ueodfIy1oZbQEWuPK1X0QLTbougyvBWkAu0qFmS
ztxjspB29ruwaGAYju4ShhMuORc+4W8co5TIpmGZUXrtHzzNGaIxqlmYbypsQQGR
JlOrOdui73QlAkyV/Avu5s+UQ1CP+7t2Nlx5iTVJECygoF/msZQ05K0iRrl2J3B4
/KNMecnCoosxnQz5baPVfWPqOqjMtGStwcBqOh/LOlToYn7JLV5VJDRFLDH3vTY5
mSk4jij0pMo+RLmKQZwIYUwKN/kITXLZ9k/Toy7nfnvT/ScJCXwBaK5e4beGLNDf
s+OPGn4IVZixIsMb87lJsZeMFslHm4qwuPhEUEYjFYzUvfryVE4A8xowsINLQ9D5
C9MMr2grhQ/hpTpuFRfWD0r7Eo7nB/fJYFNiWidCb7WhLpEfa9fIjJGa12ivbQzE
5ywBHAG1cmil0kXCRfYxzr3Aa9VuQ6UA52mEGXtmuxH1PfNzjP/CH0U9w+U62F6m
sQdu3tCFZj0w4IWFUZ5ripF3sRtKwBu/xaDCMy+K92ThnHv1q24QrqR05pueniwJ
XSDbsB9TOBNmTdVaUkn/JVXtH16C5ko+Jgzdgn6ElKtguV0UwfbZNpXRX+uwDkmE
w4uuQcP/wP2tCP8IWiLWxkgjgkfSH+OoqxywPXfMjvV4diSbjCg=
=cB6H
-----END PGP SIGNATURE-----

--IL1DOl7t2BE0L6Kx--
