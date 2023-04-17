Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC80A6E4303
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDQI7l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDQI7h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 04:59:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B561FC3;
        Mon, 17 Apr 2023 01:59:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50672fbf83eso13745144a12.0;
        Mon, 17 Apr 2023 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681721974; x=1684313974;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJafEGZLilXLck6GAd9V/sVhueR55spEo7I/YbebiPc=;
        b=qfM932Zhr03+ycfBEcHVAQFqxldOI5utfQfmvV4OKB+GLgVI/Dhm4xkbQ2pHvpE2Gl
         ikQtFMtQt3w6/hALMzB75albvSzCrfmVEGlR4osSuoM2SOPQSyHJOzk48iZ5E+l6AjAC
         c47OoVO94sgR3sHKh2mVm7dWmAuloaSXXp93QJrhzmGukDm7PzSi211vL8PueM9L5FMR
         bjJBNOapEyTPyiLi2rIVXsVRQtdZV7OhKaI8gwEGmYYNacJUxKm5GVB5c2fyfpCpsDGu
         pvJbVqhWV2St4iipY3cjvj6QCJhW9aecJL56EYLAFWTJk57wY1sOiQ4/jBtPGywt/jRS
         l4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681721974; x=1684313974;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJafEGZLilXLck6GAd9V/sVhueR55spEo7I/YbebiPc=;
        b=IfspAeYXvw47otxE04CBQ9+50z032uY7SJLiV5cj/b+pKoVWjhrpiAxjya9XAwaLyb
         dC8BBI2cUTmwCPd4o1/UfeCx8FwkIpMN00rSVnbQyXqqHxRD3lUKQm0copAjoMoHSdE5
         eAM1sm44SRMM/PocXrZbfwkZm42+L9WTvruiApOMVSBRApdJw7T74Xc+Db5pSSRHYo/m
         0dfUV4Bl68yaPB0082RQeDQ4kQHZaa5hP+tWJZODmWjCdUwttSPGheUWAai2BmOylW4y
         o5siycZTaUvABpxcUwiFurVSYJJwUaQr32NK+GMVRkAg7LWval/7ojCsOrt8SaYmPiIm
         J3KA==
X-Gm-Message-State: AAQBX9dXwXMWMqos33dlhFrl/WBfEEBAjshvn8Wdt7pBr/wL0q50VPwX
        Sr/UXKTKNNgoPRUHsqyZu/+WjWMTgy4=
X-Google-Smtp-Source: AKy350aa7Tqk9acCyMU93oK0d8443WM/hwBWH+1CqkPHUMe5MUiqGivxZLO5vsLKd771bc0fAATA9w==
X-Received: by 2002:a05:6402:4413:b0:4af:7bdc:188e with SMTP id y19-20020a056402441300b004af7bdc188emr16893868eda.16.1681721974297;
        Mon, 17 Apr 2023 01:59:34 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c9-20020a056402100900b0050508605c1dsm5536595edu.37.2023.04.17.01.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:59:33 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:59:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: thermal: tegra: Document throttle
 temperature
Message-ID: <ZD0KdAXyi0Ex1JOU@orome>
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
 <20230414125721.1043589-2-thierry.reding@gmail.com>
 <187d51b3-6fec-7a25-e472-3d9020c12db5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8oRERorzIEJ3aCU"
Content-Disposition: inline
In-Reply-To: <187d51b3-6fec-7a25-e472-3d9020c12db5@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n8oRERorzIEJ3aCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 11:47:56PM +0200, Krzysztof Kozlowski wrote:
> On 14/04/2023 14:57, Thierry Reding wrote:
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
> >  .../bindings/thermal/nvidia,tegra124-soctherm.yaml         | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-=
soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-s=
octherm.yaml
> > index 4677ad6645a5..37dac851f486 100644
> > --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-socther=
m.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-socther=
m.yaml
>=20
> File does not exist in next and no dependency is mentioned, so tricky to
> review and figure out context. Without context the comment is:

Apologies, I have a conversion series for these thermal bindings. I'll
send those out first.

> > @@ -120,6 +120,13 @@ properties:
> >                # high (85%, TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
> >                - 3
> > =20
> > +          temperature:
> > +            $ref: /schemas/types.yaml#/definitions/int32
>=20
> Use -millicelsius suffix instead:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pr=
operty-units.yaml

Okay.

> > +            minimum: -273000
> > +            maximum: 200000
> > +            description: The temperature threshold (in millicelsius) t=
hat,
> > +              when crossed, will trigger the configured automatic thro=
ttling.
>=20
> Don't you want some hysteresis? Or is it already using trips binding?
> But in that case you should skip the $ref and maximum - they come from
> thermal-zones, don't they?

We don't use a hysteresis at the moment, but checking the register
documentation, there's indeed "up" and "down" thresholds, so we can add
another property for that.

This doesn't use the trips binding and in fact, one of the reasons for
this change is because we want to make this separate from trip points.
Trip points are usually associated with cooling devices and this
throttling mechanism doesn't really fit that concept because it is an
automatic mechanism that is triggered when a given temperature threshold
is crossed, rather than a manually activated mechanism, which is what a
cooling device would be.

Thierry

--n8oRERorzIEJ3aCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ9CnEACgkQ3SOs138+
s6Hwgg//ej6HrQF29/A2wofCJYWnXGuIdDPJB6IthVMjhGD9+DzNne9c0CVxslRH
5faMpw7E5yVvfE93O3sj35mmHcTxQacv1zKan6/4L8DL0kTEqPgB3I69zLCku1PH
PHzxD/r+q+29GExtN0ZlWpyf1aNnHFfUR/xh2e2kXR2C8XqHmEJ56ZMx/2cDJs5x
hCubIxoKaqu1XUABb/0l7Z/Q/3ng4jtioiuYcc+YIgROW9ag32QuEgeXjpOi2q+1
zlgBYgRpGe0FD2LaIvusviJOQ9X/mj78gKBwoy5Oh5qZOU2BXLYvF5tLRIRgzaPC
HEhBenV8ED0+DrisncOKH60pxAvGV0BPmPNr2mijH8iItyu6D9dTJLyYE6GTqR9i
zBShzFhdjfHA+ETbjkIeA9+ca0vX5+o5ABMG9QR2Cdet/79H9oIR1pO7RJbE6Lz/
oAz/gusDS55E8Fz09vPSInPI7gj8AD/FYnrKdALKd8GbY1C7ERn4H/LRcUEP+9Te
JxvvBiKNovT3l4BprfflGFmkfP0iPDKhbDJT3AJl0fiy631VzkEN37LtwSZc8IQj
cOYQcH6tQaldVNUNLVKesAL3xH51y1hGymNrDUpIqdB/OV6QloXjl9I+ZvE5vjuJ
NjVkj+OS6NENoGVWJQz4WgMUdxJZMhCI8JjJBb2Xd6AYaljYiZo=
=CWGp
-----END PGP SIGNATURE-----

--n8oRERorzIEJ3aCU--
