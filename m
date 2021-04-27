Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1652136C111
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhD0IiL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbhD0IiK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 04:38:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B138DC061574;
        Tue, 27 Apr 2021 01:37:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 125B81F420C0
Received: by earth.universe (Postfix, from userid 1000)
        id 47EB63C0C96; Tue, 27 Apr 2021 10:37:21 +0200 (CEST)
Date:   Tue, 27 Apr 2021 10:37:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     skakit@codeaurora.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 3/4] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
Message-ID: <20210427083721.heavcdadeb4ajkk2@earth.universe>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
 <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
 <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
 <322cbdbb022fec3f43c1cbe13c532dd3@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2rgim6enrvdoc4yo"
Content-Disposition: inline
In-Reply-To: <322cbdbb022fec3f43c1cbe13c532dd3@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2rgim6enrvdoc4yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 27, 2021 at 11:45:44AM +0530, skakit@codeaurora.org wrote:
> Hi Sebastian,
>=20
> On 2021-04-09 13:48, skakit@codeaurora.org wrote:
> > Hi Sebastian,
> >=20
> > On 2021-04-08 18:30, Sebastian Reichel wrote:
> > > Hi,
> > >=20
> > > On Thu, Apr 08, 2021 at 05:01:08PM +0530, satya priya wrote:
> > > > Convert qcom PON binding from .txt to .yaml format.
> > > >=20
> > > > Signed-off-by: satya priya <skakit@codeaurora.org>
> > > > ---
> > >=20
> > > Thanks for doing this.
> > >=20
> > > > Changes in V2:
> > > >  - As per Rob's comments, converted the main PON binding and
> > > > added in V2.
> > > >=20
> [...]
> > > > +  reg:
> > > > +    description: Specifies the physical address of the pon register
> > >=20
> > > That description is obvious and pointless. Instead add
> > >=20
> > > maxItems: 1
> > >=20
> >=20
> > Okay.
> >=20
> > > > +  pwrkey:
> > > > +    type: object
> > > > +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
> > > > +
> > > > +  resin:
> > > > +    type: object
> > > > +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: true
> > >=20
> > > Instead of allowing arbitrary properties, only valid modes
> > > should be allowed. So drop additionalProperties and do this
> > > instead:
> > >=20
> > > allOf:
> > >   - $ref: reboot-mode.yaml#
> > >=20
> > > unevaluatedProperties: false
> > >=20
> >=20
> > Okay.
>=20
> I am not able to use 'allOf' to refer reboot-mode.yaml as some of the
> properties do not match with reboot-mode.yaml properties. Can we use oneOf
> like below?
>=20
> oneOf:
>   - $ref: "reboot-mode.yaml#"
>   - $ref: "../../input/qcom,pm8941-pwrkey.yaml#"

That does not make sense.

The reference to reboot-mode.yaml is needed because it adds valid
mode properties, so that you can set unevaluatedProperties to false.
You need it at the root of the PON binding. They are not added to
the required list, so it's fine if not all of them are used. Also
there can (and usually is) more than one mode, so using oneOf is not
ok.

Last but not least the pwrkey reference is needed to describe
specific nodes (resin, pwrkey) and should not appear at the root
of the PON binding.

> Also, If I drop additionalProperties I am getting below error.
>=20
> kernel/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml:
> 'additionalProperties' is a required property

You need to add 'unevaluatedProperties: false'. It is basically
the same as 'additionalProperties: false', but also accepts
properties from the referenced bindings.

Thanks,

-- Sebastian

--2rgim6enrvdoc4yo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCHzTkACgkQ2O7X88g7
+prPrg//efsuw8HLbsVcR6nNH4YV+LTidTL+eexOC+TERQ3PzNJ5WhgZVIIhoC2w
Pw+rJB4cpECMQmzAWXRu1/epxDLTJHaXpTXcKbTBiSqOpymHH2ank79oPULvXUVC
Dp87HiVHuRdWxHMSkjI6Qk+LT+IDFzSq5yoLlWz+WNbPi9W6zdTTEyLE8y3Dbl8w
8IPgXbKvrBOKXn5l9crp+3e10Uj9b0V8yS7l59ktl/vDN+v+5gUp/TgD+72EI0ki
R7pndz39RW0SuYtMhvPBwSapTf01584iXv7DVrqgWXg35ZKrjmZoSG8RzjHedMV1
Humx7DA8j6/EKT+4zKJbR1T4OD2bpseEUlNscinPgxwZQSu1jgJmCU/BUM/unJd1
kmo44QrDvu4SyLAi6WCZN8Q0tL/Bmq6+i1x9lPqBXJQl92I1Ih00nu03PRxa7pIo
X0WJY14bz4v85L2v1G9pDyxWddNYWNGALmATtCgI+NefkRBYWG6fEtfQ19gphssV
qG799/zp7pJ4L/4DFsAWowJiYqLQd2efA+hX7P2WONxd2GzzqOrEb1yePgDBd/d0
Lzd/TcVF2vuSDi6uqUhfU7s3goM2bJjSyyUL6b7IchM1hpYdyBW8QVnzPENSzsgf
1vK+pUoc+AKCO/t73Ye0EWs3hjMuoINFlhE1Tzz0nxi+5bPN9YM=
=TXUJ
-----END PGP SIGNATURE-----

--2rgim6enrvdoc4yo--
