Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7D52F8E01
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 18:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbhAPRKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 12:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbhAPRKo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 12:10:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15CC061796;
        Sat, 16 Jan 2021 05:05:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C33431F44A76
Received: by earth.universe (Postfix, from userid 1000)
        id 5E2923C0C94; Sat, 16 Jan 2021 14:05:16 +0100 (CET)
Date:   Sat, 16 Jan 2021 14:05:16 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Benson Leung <bleung@google.com>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>, vpalatin@chromium.org,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Alex Levin <levinale@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] power: supply: PCHG: Peripheral device charger
Message-ID: <20210116130516.j3fumvkajdzh2bdq@earth.universe>
References: <20201216163416.2969209-1-dnojiri@chromium.org>
 <YACLQBf4KA4uJ6rW@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7sanakdvwjl2car"
Content-Disposition: inline
In-Reply-To: <YACLQBf4KA4uJ6rW@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--t7sanakdvwjl2car
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benson,

On Thu, Jan 14, 2021 at 10:19:44AM -0800, Benson Leung wrote:
> On Wed, Dec 16, 2020 at 08:34:15AM -0800, Daisuke Nojiri wrote:
> > This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a
> > framework managing power supplies for peripheral devices.
> >=20
> > This driver creates a sysfs node for each peripheral charge port:
> >=20
> > 	/sys/class/power_supply/PCHGn
> >=20
> > where <n> is the index of a charge port.
> >=20
> > For example, when a stylus is connected to a NFC/WLC port, the node
> > prints:
> >=20
> > 	/sys/class/power_supply/PCHG0/
> > 		capacity=3D50
> > 		status=3DCharging
> > 		type=3DWireless
> >=20
> > Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
>=20
> This change seems reasonable to me. I've reviewed the cros_ec_commands he=
ader,
> and it looks good.
>=20
> Sebastian, do you have any comments on this? I can merge this through the
> chrome/platform tree if we have your Acked-By.

There is an unresolved feedback from Guenter Roeck. I wanted to
provide a link to lore, but it looks like it did not made it
through. I guess that's why there was no further reply to his
mail.

-- Sebastian

--t7sanakdvwjl2car
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAC5IcACgkQ2O7X88g7
+prrPg/9HiYBDf1G/Ys7TuHrXlHtclDGe96/qX12OSqQFyAhRAvoS+910jV9Wi3I
w2NG2o/RqVtqZdcGa3ybw0eNsefAF3/Em4oWOKRLf+cxvs2rflwIdevgMeNI85TP
b+QOM38e2JuGs19vT3QL/qZLAQmK1oAXk9V35LYfmRfhZtAmWXGVKR6JJlQA0vac
fZZ/55FvTkQblDIv6JSuLKIk18FooXKbrlTFAtxMEOCg7Mda56ffTnskjArQ1xKU
giFmlx+KaGY+4vP449a8iFVLzOK8QXCApeKtIC+lcva9cC/6k2kmbDNTmHdXswGQ
8Xqmngjd09aLpvXlA+UAOpN0zFqwzJKG8GPft3ZTCp12qmOY9OMhACuduhHXhJD0
J1FEfhuF2fwjQqUKWj2fEVpIhbgFJyjdmMAzzTf2RLrOjeHXU9zdMKRYKUvXP5ki
YKNZ8rmqrpPuxumU83Nc4J6mm5Mo5r0jSSq27hAvfqF7K+/Is8DZAn5SXLufaeqh
NNs6bll/Gf11T6yXNPBpOhVGQGvdcXRGcZen9LYU1YaY0gC1xoNdtjJRYEPWZsvU
Xz29PlxtwkveF+UMGLS1g4K7hTntemZPhGrr0xA7KPRAWjum2yAC5suwySb7Mq/H
mfiv5JW4gLVzxlbU/9rZm92xacIq2OMPKv0HCadV0fh+y13EgkA=
=TAyM
-----END PGP SIGNATURE-----

--t7sanakdvwjl2car--
