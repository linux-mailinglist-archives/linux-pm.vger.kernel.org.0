Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14215A5A5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgBLKIN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:08:13 -0500
Received: from foss.arm.com ([217.140.110.172]:58456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgBLKIN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:08:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D3930E;
        Wed, 12 Feb 2020 02:08:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC6E3F68F;
        Wed, 12 Feb 2020 02:08:11 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:08:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 24/28] sound: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Message-ID: <20200212100810.GA4028@sirena.org.uk>
References: <1654227.8mz0SueHsU@kreacher>
 <197693303.hiACyxC3Vm@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <197693303.hiACyxC3Vm@kreacher>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rwEMma7ioTxnRzrJ
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

What's the story with dependencies here, I only have this patch and not
the cover letter?

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5DzocACgkQJNaLcl1U
h9CdQwf/Q2e/vTZXZOGkQc4SmmLKO8vWdGP403zQCNWSaKnp8IbFP281lmCkdON+
JzyFvlSUWFUEE8U7sSIuzWo7dLQurQkEq1O2klXl8W4HXo0W+8MZtsfFWQHt48ST
vCwe03qod15tZiXHwCfZzIxrwpM5/GfyX9EvFpa7BXCrHPkYs6R9Nr6W6txlwVQC
2Ase3vHCV8SycxbO7t5i4IYkKbjqhy9w/tw0SC+CtUVYCPKwnNXOMESjAnlKeec+
lpaW2Csy6UPWrWTPI8+03haZjxWMAk1zeL3F1ke8jYRCJly/2msG2px7DU1fKXRM
4mHpdaPzJIFLlB4tZFcse46+9ckXyQ==
=Qcri
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
