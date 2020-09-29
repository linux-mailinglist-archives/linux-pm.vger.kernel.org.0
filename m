Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7627DC90
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 01:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgI2XRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 19:17:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgI2XRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 19:17:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 94E6329B618
Received: by earth.universe (Postfix, from userid 1000)
        id 0D4C03C0C84; Wed, 30 Sep 2020 01:17:46 +0200 (CEST)
Date:   Wed, 30 Sep 2020 01:17:46 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/2] power: bq25890: IBAT compensation support
Message-ID: <20200929231746.ismdhwsjspoajccv@earth.universe>
References: <cover.1601146802.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iwejtfvpsbziusc3"
Content-Disposition: inline
In-Reply-To: <cover.1601146802.git.mirq-linux@rere.qmqm.pl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iwejtfvpsbziusc3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 26, 2020 at 09:05:31PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> These two patches add support for IBAT compensation feature of bq2589x
> chargers.

Thanks, queued.

-- Sebastian

> v4 fixed property names for the features and dropped other applied or rej=
ected
>    patches
>=20
> Micha=C5=82 Miros=C5=82aw (2):
>   power: bq25890: document IBAT compensation DT properties
>   power: bq25890: support IBAT compensation
>=20
>  .../devicetree/bindings/power/supply/bq25890.txt  |  4 ++++
>  drivers/power/supply/bq25890_charger.c            | 15 +++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.20.1
>=20

--iwejtfvpsbziusc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9zwJYACgkQ2O7X88g7
+pqDvg/7BwNRj0SzIruPKzHngoEYQIoulSraVhAf4B6oDUPzEVBoydvYX+suzolS
cXVAbn6QhK4gcjPhhyC/noRQ5CGnpvfz/S25o4hhBuR3s+JyWL3RNAAsoqodZCG9
dJKeF7FZOyLWbwTGHu/vvHc2Q/ZAAPR2O56/RqDl/PYdIfledxYutLZj0rsUJX2A
9Egqp7XrzmuLUKoIFoexndILzqszJ5xyyrxRQdZGVMDh22ujKmLs9NPetEog435w
Awb0/a+HbX2pr1QJ9oAnoOb16GOlsObFIUkX7euls7CtS1d3uP5hH5F1HZhMcH9R
Tm7uwl/cfYo2EtmjpQgYaCSkZGkAWhsfLYZ6V3b+bfx3D+0mAciEdSegRNLo8kkg
RsUtd8XTa2mKOJvOWuHxxasRj2Cs7cuZbfVMODrAMUN/KjCrLE1knwSnOXAoobI9
gCjOX3fyq6A7f0C3DxVEvFGKSeMyWhj2Wpj90tqi+sRd+FDpiMlc1LKMq/YEgzry
JMRRSkLYL9W+tBK9d9S6NJYuyESmaK5IWassgnMDjE9F9kwgJ4SHg/xZio8kVXSM
VsB+iQqrFfciEG3FzIZLB5rsrTTmzESN+dCNK2V+Zwa7ryP3th+Kh5wSJC1oiodd
DGiXxsGg1F22bTq64CVTgbk8SOQ7VrxtwtSKRgIYCb36o5owaUU=
=P4At
-----END PGP SIGNATURE-----

--iwejtfvpsbziusc3--
