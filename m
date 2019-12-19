Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617811258E2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLSAwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:52:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39258 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSAwy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 19:52:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0C8972911A3
Received: by earth.universe (Postfix, from userid 1000)
        id BD5683C0C7B; Thu, 19 Dec 2019 01:52:50 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:52:50 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] power: supply: MAX17040: Add IRQ for low level
 and alert SOC changes
Message-ID: <20191219005250.w3m7pbjisykxx7iz@earth.universe>
References: <20191205154410.29462-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ugpk52tsjhp7lo2r"
Content-Disposition: inline
In-Reply-To: <20191205154410.29462-1-matheus@castello.eng.br>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ugpk52tsjhp7lo2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 05, 2019 at 12:44:05PM -0300, Matheus Castello wrote:
> This series add IRQ handler for low level SOC alert, define a devicetree
> binding attribute to configure the alert level threshold and check for
> changes in SOC and power supply status for send uevents.
>=20
> Max17043/17044 have a pin for alert host about low level state of charge =
and
> this alert can be configured in a threshold from 1% up to 32% of SOC.
>=20
> Thanks Krzysztof Kozlowski, Lee Jones, Rob Herring and Sebastian Reichel =
for
> your time reviewing it.

Thanks, I queued all but the MFD patch to power-supply's for-next
branch.

-- Sebastian

> Changes since v7:
> (Suggested by Sebastian Reichel)
> - Fix unrelated change
> - Use device_property_read_u32() and simplify the code
> - Check the irq and of_device_is_compatible in the first patch
>=20
> Changes since v6:
> (Suggested by Lee Jones)
> - Use relative paths in documentation
>=20
> Matheus Castello (5):
>   power: supply: max17040: Add IRQ handler for low SOC alert
>   dt-bindings: power: supply: Max17040: Add DT bindings for max17040
>     fuel gauge
>   devicetree: mfd: max14577: Add reference to max14040_battery.txt
>     descriptions
>   power: supply: max17040: Config alert SOC low level threshold from FDT
>   power: supply: max17040: Send uevent in SOC and status change
>=20
>  .../devicetree/bindings/mfd/max14577.txt      |   2 +
>  .../power/supply/max17040_battery.txt         |  33 +++++
>  drivers/power/supply/max17040_battery.c       | 130 +++++++++++++++++-
>  3 files changed, 161 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max170=
40_battery.txt
>=20
> --
> 2.24.0.rc2
>=20

--ugpk52tsjhp7lo2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36ydQACgkQ2O7X88g7
+pri/g/+Ncf5+pXnEljw4cOfiOwJYP3ql2z9N6VHTMixItWe1QQ/Mn5qKFj9O5AT
ZM0Pexo7JBmu4oH9DtulNXULSathw25iSoQmJAGZakM/CcBYbkJBafbXWQF+ls2v
6bZcKLgYMzOFWHyjLtnYkfV1pHjmiCG7A5Mqln056/WgJLzTuxT3cW5pczskddvL
3DlFaRQHs113/aqFCXWg6NvMkzuf+XUM11SmAmezuwwjj0JTsGpf7Gz1//uXJ+Ml
G/N2SKne4/tDB61ce6N8sxEofDjqqV1KIk3Wdz/O/Cqmq6+gORs3NF9KIdlE0RCZ
U4pPCUfKWPyWr0+uP+XHwj/Ggv0bIlKYEVi/lvEb6NklZ3X4tZ+7K6j75YMQ0qRY
wtUayqr45ZmcPUKLkrDOC6Bj2+37dLIBy2Sl7Ft24yXf3BfQHoMS/RM8h8mhwHQB
kkvM2O1tm3zfciSxn2N5EL3BWyHAX6FJnU6vVayjvDvEMKPJSK85M8wyyc1gCZzV
pTzCI/zViWnfiVfEG+Ai3UEZO4cjHxt5u4U8l7iygQK1BZBdZhxaVaQr3qcsvpSW
XfVQjmcXPKBjzU4BUvrJUNrt/rNH4ytfWfZfaEUCCa01FT9WNqffCXtgni/W4VY+
U8oR272gljb4hwr6SRyqpvc46eZa+nNjNwWtoXpk6UNMMyRNaUE=
=Py50
-----END PGP SIGNATURE-----

--ugpk52tsjhp7lo2r--
