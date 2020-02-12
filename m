Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A215A61B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBLKSn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:18:43 -0500
Received: from foss.arm.com ([217.140.110.172]:58620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLKSn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:18:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98DE430E;
        Wed, 12 Feb 2020 02:18:42 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ABC23F68F;
        Wed, 12 Feb 2020 02:18:41 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:18:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 24/28] sound: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Message-ID: <20200212101840.GB4028@sirena.org.uk>
References: <1654227.8mz0SueHsU@kreacher>
 <197693303.hiACyxC3Vm@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <197693303.hiACyxC3Vm@kreacher>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 12:34:15AM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Call cpu_latency_qos_add/update/remove_request() and
> cpu_latency_qos_request_active() instead of
> pm_qos_add/update/remove_request() and pm_qos_request_active(),
> respectively, because the latter are going to be dropped.

Acked-by: Mark Brown <broonie@kernel.org>

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D0P8ACgkQJNaLcl1U
h9CgHgf/de8VX0qZLzWqsoXRYFv/Ub+0hQ+gIGqbmNRetv4BnJtPs/r5iHjph/Mf
HaeVov3QuSDOIJD4LteXPJDp1G1uZ3RBWRL3AkyZXyf35rHj6+U1Oz1cNfaWLPHv
pCO1L3RWlRgTUj/YNaqcI4tK0IYqFF4rXlk9cnVENJHL/vpQkxn8jwLruqQWt3Og
sPIrICP+U+suiVp4Hv2k98QP4Vdwm3AHBMsn0vA+O/XL7PGHY6sAvx3a9wKm9zo/
bpfcwY0n6WPYHCV/8aZNhHAD1A+VYeTN7kzcSO1Dtq1k393wG99w4ZKX04f/5HJ3
q3W/2Zg9vOog8DmwveUAYD2Faa5/nw==
=BiO6
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
