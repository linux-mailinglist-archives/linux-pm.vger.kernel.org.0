Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A7639B79C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFDLLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhFDLLF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 07:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1142E61405;
        Fri,  4 Jun 2021 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622804959;
        bh=zGfRw6Pf04NGsknfLueHgOatwjn05KjyhSpQcX8PvjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsPJYx8wdcNgUWPypk5ZTc89j/TkeW/p+WLgV8Vjuv9SFdCRy72MAHARAC4JcNEOo
         2yNDsiow2Oc3dwJcQwydWQ6lXnM5FPdrkO3moddi2eq+DguJiZyb5DAoL9SwOMtaFD
         pwsDZzfUcx83AvplGYSE1a3GXBD/rsj8GajI+rGfV5FFyx8W3I0qKaNl9MapLju6EF
         xm9gfXGH8yG0kYnvXV259ccg8Zf89My4+cRO4jojfcoFDNvEx3+WxuZP+GngEVb1EZ
         gFwIeK3cuDLwXOIf3mAmK/tvFm40gBQiD1W9OnVYL/80aR1YcZ1ewr3qe97/L/mMd9
         8tfmMWHAR2sDQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 6A4A63C0C95; Fri,  4 Jun 2021 13:09:17 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:09:17 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     satya priya <skakit@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        kgunda@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 5/5] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
Message-ID: <20210604110917.zbrjzpl23ujqclyf@earth.universe>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-6-git-send-email-skakit@codeaurora.org>
 <20210510162506.GA234174@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gm6knzvk5amrbryk"
Content-Disposition: inline
In-Reply-To: <20210510162506.GA234174@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gm6knzvk5amrbryk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 10, 2021 at 11:25:06AM -0500, Rob Herring wrote:
> On Mon, 10 May 2021 12:31:04 +0530, satya priya wrote:
> > Convert qcom PON binding from .txt to .yaml format.
> >=20
> > The example has been removed in favour of full example being
> > available in the qcom,pm8941-pwrkey binding.
> >=20
> > Signed-off-by: satya priya <skakit@codeaurora.org>
> > ---
> > Changes in V2:
> >  - As per Rob's comments, converted the main PON binding and added in V=
2.
> >=20
> > Changes in V3:
> >  - As per Sebastian's comments, added allOf to refer reboot-mode.yaml a=
nd
> >    used unevaluatedProperties =3D false. Added maxItems for reg.
> >=20
> >  .../devicetree/bindings/power/reset/qcom,pon.txt   | 49 --------------=
--------
> >  .../devicetree/bindings/power/reset/qcom,pon.yaml  | 44 ++++++++++++++=
+++++
> >  2 files changed, 44 insertions(+), 49 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/reset/qcom,=
pon.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,=
pon.yaml
> >=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--gm6knzvk5amrbryk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6Cd0ACgkQ2O7X88g7
+povLg/+KvOofQBtGWbCowBLj71YD7KEXvwoIAAlQAbYo2BLJSuKSZYDC2XTuIQW
YJuJskFEb5JxzPfLWmEzjX/T8Zudc3xLw3UoYIqboJUQgmt24tYxViO3jxx/c6X1
7XtCbUfwAtwVy4PodxxMVOV2YVhKHAqIv4BJVuCtwEcn95wyB7Wu99qIn5r8Dr1C
DySkk2B4RbFtS5Ldlxjgsg1w04r3ideXyM2JQAiZqIOWKknTFAPTkzRpw1tYbU/u
Nsn9dtVtIioTUkIWG60+0aSe/zroQXTPd5COKQpILWoQ1Nrv1XiNwrSH1Cnylr+i
v2q9kEF+dUGIcA+HVff5T4y/RZ7w0SFpl7klgTBS8lN6eRnkNjIgbwr7LAWmlGtl
c+N4D33gE8bIEGXThwskgi/Jh8K8vB47WNIs/BwCGIMSS6YjrjQVlHVStUJhXgu4
0mpTZlTrrWj+XVXIXhW5BPmtuBrORTkInC80GYff2ndkn4/yzg4+AKrgnPiXBLyI
b0eh9y/IODkIegCreQZogJaBA2Ych/UUR7jrGfGIHVui11d7xNGvXRLxWSn4283Y
tDPkMIxBJ571kPWE0Z5cKRO28qhvcAaCVYcpKCQQ8mukKRnfuhcd/sPeK8kg4on7
Uf7/N0RQikbdupmhnvPCVyKkDE0C/HKTd9PCYCSIsDSaXThiq7s=
=jGi0
-----END PGP SIGNATURE-----

--gm6knzvk5amrbryk--
