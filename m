Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A033E3020
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbhHFUKh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 16:10:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51734 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbhHFUKh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 16:10:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0E8001F44D9E
Received: by earth.universe (Postfix, from userid 1000)
        id CDB293C0C99; Fri,  6 Aug 2021 22:10:17 +0200 (CEST)
Date:   Fri, 6 Aug 2021 22:10:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andrejus Basovas <cpp@gcc.lt>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 00/10] power: supply: axp288_fuel_gauge: Reduce number
 of register accesses + cleanups
Message-ID: <20210806201017.oqmxi2ll25adnbxr@earth.universe>
References: <20210801133105.101761-1-hdegoede@redhat.com>
 <20210805171951.xkvndkzpx3od2nki@earth.universe>
 <8b43afbb-918a-9a88-5a0d-a6d1f3509a97@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ag5x3tcfassbj2yw"
Content-Disposition: inline
In-Reply-To: <8b43afbb-918a-9a88-5a0d-a6d1f3509a97@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ag5x3tcfassbj2yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Fri, Aug 06, 2021 at 01:36:31PM +0200, Hans de Goede wrote:
> Hi Sebastian,
>=20
> > The double goto from the last patch is a bit ugly and can be
> > avoided by switching the driver to devm_*(). Do you mind doing
> > so?
>=20
> No I can take care of this, the problem is finding some time for
> it though. I've added this to my to do list, but there is a bunch
> of higher priority items above it.
>=20
> Still I will try to get around to doing some clean-up by switching
> to devm_... eventually.

Thanks, please take your time.

-- Sebastian

--ag5x3tcfassbj2yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENlyEACgkQ2O7X88g7
+powrg//ePjBtvEVFMGntMWHkJPOAiqZASnzUqXn/5s7s66+9v06775HA2F+BFdQ
bAWusinsm1i9nM9oYMJlJbywt4kFHhZ3F2lMNoCcs2eEpol6AdqSsumREHixZF6M
omhdqFYvSsmNP3h7UnFXFt/6XHx8VBxHMx7tZZUrx5PyLsN0VaUCZcaHVvQeCcRA
Oqo6L4xMatVzaGeQVQ1ab/ycwUmFQgGuxl858OIvDrFSGc1+wfAROIBlb15vkNuE
CjPCdTeMUAs0fpP+H0SLml9OTl/AqDFQTagep4ye9cmJ9DTBF00ATSGRsLEIUtcy
CKxwHB3MZ9FMsfejXm35nF1Bij7rfgXEAM/0OqXDEa8BPIXwrNnmQF7xZsavs8L5
FNiXj8OsWUeT/8IGcLqhZrg15Mbjw/4khpmxR+MVdYRue1+9nwkTEMtzCcDI/piT
mZ7LoLKsHlVlujgMjufTSTOzvS9KQgAH+IZh+Rw1qpK4ph6yOJ9Ieg3ESDDHhoTl
sHKxs9Wp/lsxcxiKGMFON2/WuAfGIq/QbG6Y9acSi7VXUS1vJDmDBEQBHx7WyhWm
FpIl1fkprktOuSDZpI/n6hMiLOWcEpTM6Xc9khZOB6jaOUD8fWbIe0i6VAsHIkvi
hjpG6Hht13fkkfZgX5FthOK30mMjqC05Gwro1sIHqjDCRwN2Luo=
=+vj2
-----END PGP SIGNATURE-----

--ag5x3tcfassbj2yw--
