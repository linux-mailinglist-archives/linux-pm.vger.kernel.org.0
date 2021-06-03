Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D839A972
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFCRqE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 13:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhFCRqD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 13:46:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92919C06174A;
        Thu,  3 Jun 2021 10:44:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 344531F41AFC
Received: by earth.universe (Postfix, from userid 1000)
        id C13B13C0C95; Thu,  3 Jun 2021 19:44:14 +0200 (CEST)
Date:   Thu, 3 Jun 2021 19:44:14 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 0/2] power: supply: rn5t618: Add more properties
Message-ID: <20210603174414.qjhpkgqqr34hk6nv@earth.universe>
References: <20210528213006.3695-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ehqhr7eslopubode"
Content-Disposition: inline
In-Reply-To: <20210528213006.3695-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ehqhr7eslopubode
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 28, 2021 at 11:30:04PM +0200, Andreas Kemnade wrote:
> Add charger type detection for devices which support it. Add also
> current limits.
>=20
> Andreas Kemnade (2):
>   power: supply: rn5t618: Add charger type detection
>   power: supply: rn5t618: Add input current limit
>=20
>  drivers/power/supply/rn5t618_power.c | 235 +++++++++++++++++++++++++++
>  1 file changed, 235 insertions(+)

Thanks, queued.

-- Sebastian

--ehqhr7eslopubode
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5FOcACgkQ2O7X88g7
+ppG7g//ZmwB8q4Uh0Ah5wB8ACBsxUrXmS6lrPNYFt5P6YWuhHeMXO1WBNhxzC7I
ikae5dziTPAzzaTmnhrhYYQ28hi6YOP3rW0j/zlhn4dVbqx5l0oLYrSUl9pZakDU
ft2kAe3ZezOWD8M6u2i7H805tUu9eIiGfRfB/giyt8Uvu1gLjYYAt1wNA9e6vvK8
gD+axVmnyHaJEhuo8UDaWzZlm9/40kPie1/efwcMaDC1gH4xCevfC7OtuTFJkXKL
kiGW34LGHeY26uUcy/eRwwagwUAJ3EoThDm9WfmvIYybiiX/xzUCafoqJaaAE1oc
bzUR+u4xcDilJkg7DCC76GfeERgHuduKp1YmYf9OkA0ZH2Lfg2QJTQJ919OU/1YD
QvFDU+kUf/0PFwZC3qlcQ62QV+SpOVTaiFdTrjRCYY7ITacoM8Mubc+s01JTUWCC
CwsfTlKJ2zlEW570kiBt3FAfuf8fDDHfLtZ3nSn0YBgINhv7TQJbpZEQWCw9LSSI
hJKSFANmXMB6wmLwlBa4Ql4EXpdtMtePMgtHDqdEQ+aGlyTyuUJKtBuaVNp3Z2qE
IOjbelkczWLUJ+pc7Bq39JS5wEk6/R5QPGqd+snkz1zT6DxVKXX/iw9EjWeCLvGK
zfCpBXKGN9RN6QH+DGaFWL1m06EZjGrfilMYspnVrEFCFnTlw8I=
=gtcb
-----END PGP SIGNATURE-----

--ehqhr7eslopubode--
