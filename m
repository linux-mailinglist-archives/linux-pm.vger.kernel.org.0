Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34839B894
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFDMAE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 08:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhFDMAE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 08:00:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA8A96140C;
        Fri,  4 Jun 2021 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622807897;
        bh=sreDTshW6uS9V/gqE3EfDqr8/k4FapToRpAXZMM2Edg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfjCVP9fqtEgq9ZDLG6YSJ1c19Lo//4JNbdfkW62EACH6RLypdugWLlBYhKd+WuSm
         22uF/RnoqWuHi6UcVSi0tceWEIyOK82GTHK1Pzfq6M1ol/PIB3h+fXjJ+o01vyY53B
         pb0XYCKw0X6/5SAcillKsbxrZEzvVOFUsQsciwjyT6Wk250L4oM/DMZqXkPJB9E5Od
         dGZJ/ur1qqp9/QBUZNFi2wbdsg++ry9qBHztCrvK7BfJKrUIkJwMXzQycoVsMoEAmU
         5NphvX+8AizQoMI2Ax6SgfHPNBxvXKzdvHUPtIdiG80YYIshUpSc3hkcMapGYJq3EO
         fp2o+DgQQqVJQ==
Received: by earth.universe (Postfix, from userid 1000)
        id DBF553C0C95; Fri,  4 Jun 2021 13:58:15 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:58:15 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     skakit@codeaurora.org
Cc:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20210604115815.q7a6orp4ksbbvmmz@earth.universe>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-6-git-send-email-skakit@codeaurora.org>
 <20210510162506.GA234174@robh.at.kernel.org>
 <20210604110917.zbrjzpl23ujqclyf@earth.universe>
 <0e1471d4522d1356e354c4653e8e0b42@codeaurora.org>
 <f3ea0212f4122099e0e35d1aaf5e9e07@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mzxelsrfu5vobxie"
Content-Disposition: inline
In-Reply-To: <f3ea0212f4122099e0e35d1aaf5e9e07@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mzxelsrfu5vobxie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 04, 2021 at 05:15:17PM +0530, skakit@codeaurora.org wrote:
> On 2021-06-04 17:12, skakit@codeaurora.org wrote:
> > Hi,
> >=20
> > On 2021-06-04 16:39, Sebastian Reichel wrote:
> > > Hi,
> > >=20
> > > On Mon, May 10, 2021 at 11:25:06AM -0500, Rob Herring wrote:
> > > > On Mon, 10 May 2021 12:31:04 +0530, satya priya wrote:
> > > > > Convert qcom PON binding from .txt to .yaml format.
> > > > >
> > > > > The example has been removed in favour of full example being
> > > > > available in the qcom,pm8941-pwrkey binding.
> > > > >
> > > > > Signed-off-by: satya priya <skakit@codeaurora.org>
> > > > > ---
> > > > > Changes in V2:
> > > > >  - As per Rob's comments, converted the main PON binding and adde=
d in V2.
> > > > >
> > > > > Changes in V3:
> > > > >  - As per Sebastian's comments, added allOf to refer reboot-mode.=
yaml and
> > > > >    used unevaluatedProperties =3D false. Added maxItems for reg.
> > > > >
> > > > >  .../devicetree/bindings/power/reset/qcom,pon.txt   | 49 --------=
--------------
> > > > >  .../devicetree/bindings/power/reset/qcom,pon.yaml  | 44 ++++++++=
+++++++++++
> > > > >  2 files changed, 44 insertions(+), 49 deletions(-)
> > > > >  delete mode 100644 Documentation/devicetree/bindings/power/reset=
/qcom,pon.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/power/reset=
/qcom,pon.yaml
> > > > >
> > > >=20
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >=20
> > > Acked-by: Sebastian Reichel <sre@kernel.org>
> > >=20
> >=20
> > There is a V4 for this.
> > https://lore.kernel.org/patchwork/patch/1425638/
> >=20
> Seems like you already reviewed the V4.

Ack, just ignore this :)

-- Sebastian

--mzxelsrfu5vobxie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6FVcACgkQ2O7X88g7
+pq+hw//YanRG6Tp4qk+FvYLQnRPkDDtf4b1Y1Xx69mo59laADLznK0e/0XCN7H2
3g8ZnVt8P3jd3BMIz6X7PKoRj5tN+N8d1i8WOWiFwg0RsSm1p1xSCZ40dKRdAZ8Z
qRIqIOXRi/cVPS6w6SH191kaxcdKnIzqx6/Ed1QWfkYiiz614YavjkjGx2b7Ad8g
JpFxzClUw6mw9qUce/FHGloWkztNfcBNJ3ncIsUqk6kheFFlUXBwl5XiDc9coNvS
UT69JOEcYckft/RalCtLUL7bJZXSh4gAZbjf9Zsgkrb2i7AaqiP4NvFOVMePgCs8
ppL4Z4xi5gEVc+d+fdNwjv8yLfNRfOX8d5W64BK810DF4MrCaqhZyi2X+7Of8iSo
9dTvQN/S5uBBSgOXFh/ZhEAUHoHF+ojjDHYmCRlu19Q2+dD+wxv5eduaCTEBdHrm
QXeHR61zTbB27McJSgfxlVCTOgUgcTR2vl/I8Y8Yb5vOKNLwqiDRJtYlSxoFlINF
9ZP9nklUNnVPL5PqD8B+olZ2f7G4Wr6Wy5E518KoGg3gq/YimtJm+QRrHSAKuj2H
pYlEY0E1PG7DuHKd9YTZ7eTCQ0jyhjgwd0bQ3aCSo6jLaTfVHU38jOur9K8emfA0
Mo7Lntx75liRr9mMbY82ewVQ33OvEyBqfx2XQJLSPfnwHTI2dxs=
=Zlip
-----END PGP SIGNATURE-----

--mzxelsrfu5vobxie--
