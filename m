Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612A04533EC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 15:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhKPOSv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 09:18:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37224 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbhKPOSh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 09:18:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 330B11F45718
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637072131; bh=XF191G7jqx54v8b86pNMrwokFonDq6edmtqC06RnQ6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUZunm7ALX1sAtYSe40S2jkJg3sTiTYT3Yd/0hmgcu8Zk+5kIjXtah+8vDfqWAivi
         MRrcg2m9ydK71l0OgKgdw+twNg+yqT+Ei9KVqYoLLp1MoeITVqhop/SP761VmwnfY6
         1lWl47tTHYzo7a7YIVp/BHtLKYZcDXxAEvsROchA+smeNIwD287JKFcwYbpcwoRBoz
         drwPhes3dP6mFqFj/hmre7W9suXCq96wADJH8KHuKW/F/31Asp1KgQZNGd9Jd+Xp4O
         UMDjayJxmB5Ce1Bvy5yEyIR1AwHT3mYLY6fDYNdg3JwyNPJUOpRRBaByeYwe9izzn0
         qgx69zQdw5SBA==
Received: by earth.universe (Postfix, from userid 1000)
        id E03F73C0F95; Tue, 16 Nov 2021 15:15:28 +0100 (CET)
Date:   Tue, 16 Nov 2021 15:15:28 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, ~okias/devicetree@lists.sr.ht
Subject: Re: [PATCH v3] dt-bindings: power: reset: gpio-poweroff: Convert txt
 bindings to yaml
Message-ID: <20211116141528.lqpjhkegbpa2i6mo@earth.universe>
References: <20211028165009.76641-1-david@ixit.cz>
 <YYF4kXX9HWaef33N@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v3cccwclzxw4wugx"
Content-Disposition: inline
In-Reply-To: <YYF4kXX9HWaef33N@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--v3cccwclzxw4wugx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 02, 2021 at 12:42:41PM -0500, Rob Herring wrote:
> On Thu, 28 Oct 2021 18:50:08 +0200, David Heidelberg wrote:
> > Convert power-off action connected to the GPIO documentation to the YAM=
L syntax.
> >=20
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> > v3:
> >  - incorporated Sebastian notes
> > v2:
> >  - remove driver specific note about WARN_ON
> >=20
> >  .../bindings/power/reset/gpio-poweroff.txt    | 41 -------------
> >  .../bindings/power/reset/gpio-poweroff.yaml   | 59 +++++++++++++++++++
> >  2 files changed, 59 insertions(+), 41 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-=
poweroff.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-=
poweroff.yaml
> >=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--v3cccwclzxw4wugx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGTvPsACgkQ2O7X88g7
+pqxNA/+Iix4QVCRfdvenOmF70JUzvJVVRb1RNSzqOeF+dIt7Hg+1tp9/uwYNA9o
JfTgjPJJYLDHQEf4kPunG/hewM0UU5nrDNY0uNNyM57oPHqf5y+nXQ+eX15u3X7/
CVQXaKlGteTXSqq/wpF4As7DDpgNTAJ6Pjht/GNNFGZuDMd04LSWBJz5qbx9x02u
kAnASbagtOYDBVORLpxc4SPlJuhkbkOqelxBIPYlyfirCJhGNouQTo7syrYkkh96
hEGe8xITeNcz2op3NkjHpTVAcGU2CGI101lsrklDqPip4/1BE6r3ohVB8gVwJ1x6
6iOtTu6Vck+BQr+KI8J6uys6z/KJYUwwXu6ciHZDjILALbN+Fw2y3GLkqqIEuSv3
YrIP7QNRsWLi3TqM3bObWcgS8HgYn9HZO3YbEwcAItaz/S5z0Iyobxj5sN9Awqt9
nZ1AxpPUcNB7KgxU1Js4RXcOFg2uTi9mRDlfa4du8st0376NRm7ZSxfufwGJ1XZ7
kMVMAAtELcK1mZ1DoLHIqmwG4Rt0bL9El3MkYoNU7MdPI4SRkFdiNOzsZLipDcLa
DDYw0Q86Ynnjuj5E+3/0wYaOQfU97hcirsWRjzUlDvIHtOEo4lvAit9sfOxIFeJr
OVOEUcdC4BNlZTgy4UvfdHHg0BjFXyeFW0BE72JWSLsntYYg6cY=
=rL1W
-----END PGP SIGNATURE-----

--v3cccwclzxw4wugx--
