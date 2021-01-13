Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311992F5489
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 22:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbhAMVUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 16:20:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38548 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbhAMVTS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 16:19:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 410901F44F75
Received: by earth.universe (Postfix, from userid 1000)
        id E1E673C0C94; Wed, 13 Jan 2021 22:19:50 +0100 (CET)
Date:   Wed, 13 Jan 2021 22:19:50 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] power: supply: Constify static struct attribute_group
Message-ID: <20210113211950.vjqo5vywpsysxo3t@earth.universe>
References: <20210113203243.20146-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kukvvetchmjri4zq"
Content-Disposition: inline
In-Reply-To: <20210113203243.20146-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kukvvetchmjri4zq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jan 13, 2021 at 09:32:41PM +0100, Rikard Falkeborn wrote:
> Constify two static struct attribute_group. The only place they are
> used is to put their address in an array of pointers to const struct
> attribute_group. With these patches applied, all static attribute_group
> structs in drivers/power are const.

Thanks, I queued both to power-supply's for-next branch.

-- Sebastian

--kukvvetchmjri4zq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl//Y/MACgkQ2O7X88g7
+pq7UQ/6A6k4wZbdEVwjlFsNLTPuQQ6LHAHisbRopf4kAurq/N0e4uLvl5Q0K0HM
c2pqHqGj41X+o8/CvsULdgYnkexGGVFOO/mUSSawq1grvsaheL9bbOpMlWKYSuKM
wQHIPqBGN6S8CvF7Tl9JxcKYwVAe1JuR5tj7o+C6S2gE/vmBRtCXMlETvSyYF9vN
a0JUidWZAMW3M4xQ9IVSqFRd6VhxiISpNRcvKoUvmw8Tvfv4Gd3KFLuW4cjPvVTX
pL+JfYv0cknikUXDG1t+GkBFsRR9mxASHC3u4sRZgBXnrqznjakHUdQpp4zjlwVe
zKV6Una/1GK4G26xjsX3ANKGgLyMzBJOKtHWRPJzr6/o5kA2nNb2GdBolQFljIhe
QbLcl7sJ6pnWe/FCYvMIXrNx2bexGW2UqyD1N33/f2nMHZS1VbXL1cNUOWEMa/ht
s9F5R0UUC50oxwKlmV5aSaIhQu+L79ccE/9bwwtTh7pRj65uDMQGqbVpFLp+iCNh
Pyj7eTiGWI1QLtOa/TIQWIDAjl4IeONIMVDRLaR1azJ1E21adWe7V1aiJ0FSpvyH
hbZ79toyHT/2m7IDDIv0LLZhOC7Aj0FlNPBq7SI05X5ZZ0/o744bhnEi+8srP+27
8CpomsiWrgRIwu/f2h6PWhiHurO1kM5TXqqgHt8TyQSa56zWRxo=
=u/mS
-----END PGP SIGNATURE-----

--kukvvetchmjri4zq--
