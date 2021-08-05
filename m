Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6153E1ABF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhHERtZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 13:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236276AbhHERtZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Aug 2021 13:49:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9177960EEA;
        Thu,  5 Aug 2021 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628185750;
        bh=hgh8n/mlJ2BWgXVr9IEapn30lUSRxQYBbXEgYVfExsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4dR9GzVij9XR2qNakG0ENKTKKely4MQG5DFuH95wJ67k62Pdes6YwV4oUx5fKqX4
         bW/mIC7UmNY/rq2bHtfrYvyHBjt/4BG9oq25K/MtRfRoIbipwY9HAQyqX+YrY+RqCw
         N3U3LxnIda1nantkXBMivAMJSqJHT8I5Ri2dqKSHmKhjE4C4dUAN2vkIC2liQ7p246
         4uDUbLZ70gbtQy85TBWjM/7h9IO3etzRFXzEMiYw+3t1wscYta3MGLElWFx++gYBpG
         2YxfotWf/tbPB6f6jCRkoQ67eB4WmwSti3EU5Nt89Ort8YOclXwUNsgbm+7awJwNfl
         AFq2gLeht/mwA==
Received: by earth.universe (Postfix, from userid 1000)
        id 959BF3C0C9B; Thu,  5 Aug 2021 19:49:08 +0200 (CEST)
Date:   Thu, 5 Aug 2021 19:49:08 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Li Tuo <islituo@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, "Jett.Zhou" <jtzhou@marvell.com>
Subject: Re: [BUG] power: supply: 88pm860x_battery: possible
 uninitialized-variable access in measure_vbatt()
Message-ID: <20210805174908.ctg6n5iwmg5izap3@earth.universe>
References: <e2080eb9-bbe2-5077-761d-b5594edb6006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwujtqsremn5py5a"
Content-Disposition: inline
In-Reply-To: <e2080eb9-bbe2-5077-761d-b5594edb6006@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zwujtqsremn5py5a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[adding Jett Zhou to Cc who introduced the driver]

Hi,

On Wed, Jul 28, 2021 at 06:24:12PM +0800, Li Tuo wrote:
> Our static analysis tool finds a possible uninitialized-variable access in
> the 88pm860x_battery driver in Linux 5.14.0-rc3:
>=20
> In calc_soc():
> 369:=A0=A0=A0 int ocv;
> 376:=A0=A0=A0 switch (state) {
> 380:=A0=A0=A0 case OCV_MODE_SLEEP:
> 381:=A0=A0=A0=A0=A0=A0=A0 ret =3D measure_vbatt(info, OCV_MODE_SLEEP, &oc=
v);
>=20
> In measure_vbatt(struct pm860x_battery_info *info, int state, int *data)
> 176:=A0=A0=A0 switch (state) {
> 184:=A0=A0=A0 case OCV_MODE_SLEEP:
> 201:=A0=A0=A0=A0=A0=A0=A0 *data =3D ((*data & 0xff) * 27 * 25) >> 9;
>=20
> If the variable state is OCV_MODE_SLEEP, the function measure_vbatt() is
> called with the argument &ocv, and the corresponding parameter is data.
> Thus *data is uninitialized but it is used at line 201.
>=20
> I am not quite sure whether this possible uninitialized-variable access is
> real and how to fix it if it is real.
> Any feedback would be appreciated, thanks!
>=20
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

I suppose the code is suppose to look like this:

201:=A0=A0=A0=A0=A0=A0=A0 *data =3D ((ret & 0xff) * 27 * 25) >> 9;

Considering quite some code is spent before to setup ret, which is
never used. I don't have the device (nor datasheets) though. Considering
the driver has only seen trivial cleanups over the last 9 years, maybe
it can just be removed?

-- Sebastian

--zwujtqsremn5py5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEMJI4ACgkQ2O7X88g7
+poT7g//cufoD1ZEZiJECh7O3127FFRZoHWb8mwwyL0inJP58K532Nb0i6r3bq2u
muv8YJmrgTynrMdvWx1tlZwoD6GaYmCUE9c0h4v9j9m782XGJIH0KLx8RrlkxXii
b461y9Bj1SHE6jwxy4p7BML3ensp/zGJb7GS2RZnhpZqwVURYctl8zasAnyTff8N
i00EH4G8ehrl2fcT5V1WzK0AxB3DVX205DPGqNLLijHBRcS8P/wxNQZP5S79C5fO
DUikpsVmg4DGR5btCQo2Oh7axWAPpKfgUGOlDQUT1vYJzxciOCWinv/4GMRT31uC
JiMjeeiaGXaLXSGTA1lZe25U0XLt1RSieGhns+jgrLke2x9B3NSklJBo087cZyJ8
e3XavBvLPXg2Ttz2pgRmq3UdmzkYTBpLVEBb4p9WIb9w95LNI8fSqZJVu+YszCN/
KKkUWxRzK6469nYdsp0Wq+y9eUU35lesn7EKIes6OGGclapAEy013ndyUW01mKm5
nq1dK8GWarCIOpVBT09EvhZp6tbFHVL19om+TGJ8POFnKUigI/mLA6O4mJLltiqd
7TMgY4VF3FOWzAhimxakMvy3Innst/gy7D4+JiJttbtDG92M9yoW1MN4O1GX+H+c
ffWJjRlxzajLhDEwAJeG/J4uhGosT1TjuF7HnCoysB9/gUIUfBQ=
=TU6k
-----END PGP SIGNATURE-----

--zwujtqsremn5py5a--
