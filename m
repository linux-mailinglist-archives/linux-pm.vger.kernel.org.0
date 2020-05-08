Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D551CB633
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHRoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 13:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbgEHRoJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 13:44:09 -0400
Received: from earth.universe (dyndsl-037-138-187-059.ewe-ip-backbone.de [37.138.187.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FDB208CA;
        Fri,  8 May 2020 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588959848;
        bh=4UYeO0qyEtD4knQ5iIGMA1jOB8Onqgq8lqWUo7oBasw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0OG+NGYN1jtt6d0KABKC2oxJnu/6Z0z/iodf/dOBShz9MCQ/DkhN51CBDecEx8/t
         imK0yeelRD/3vED8wnlEo2bZ1e+ozX9QfmOOf6hydokt9ZQgsOZ9eITIlh4ywemrJH
         h3ZRg5sa1cvw07kxjEBOX2mtKPv+9NVhz8cvOayI=
Received: by earth.universe (Postfix, from userid 1000)
        id 639E23C08C6; Fri,  8 May 2020 19:44:06 +0200 (CEST)
Date:   Fri, 8 May 2020 19:44:06 +0200
From:   "sre@kernel.org" <sre@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v12 09/11] power: supply: Support ROHM bd99954 charger
Message-ID: <20200508174406.s7ijef67roaoutkx@earth.universe>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
 <6d2f82459c5331fa7d27f41e6645a55cc1e44837.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
 <7a6c4afc9caf5437567c520d5f50ecf540d1c303.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2n64qp3gm6ara7d"
Content-Disposition: inline
In-Reply-To: <7a6c4afc9caf5437567c520d5f50ecf540d1c303.camel@fi.rohmeurope.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n2n64qp3gm6ara7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 08, 2020 at 03:59:18PM +0000, Vaittinen, Matti wrote:
> On Fri, 2020-05-08 at 18:50 +0300, Matti Vaittinen wrote:
> > The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
> > secondary battery intended to be used in space-constraint equipment
> > such
> > as Low profile Notebook PC, Tablets and other applications. BD99954
> > provides a Dual-source Battery Charger, two port BC1.2 detection and
> > a
> > Battery Monitor.
> >=20
> > Support ROHM BD99954 Charger IC.
> >=20
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Huh. I shouldn't do work at the Friday evenings... It seems I did
> accidentally send this patch twice. Hopefully it does not mess up the
> series for you - I'd rather not resend this anymore... Please let me
> know if I should do some corrective actions.

My mail system automatically drops mails with same Message-IDs :)

-- Sebastian

--n2n64qp3gm6ara7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl61mlMACgkQ2O7X88g7
+pqhvg//WO/Jg8dJ5AymeVFgGWRbClG2POO3n0bcU9wHFcA3nz/oMjprXvB+AKmx
+gQ8Ilr8a6TOaRSfiQbTmY5M4ylRicrTv5+0yNTT9t4Uw4W2xror4pmlhhxTyc9F
MK/2RBQkLoGo8uOs9eLp2DMA8z6YVMdhT9Q1y5Me5jQloOHtA8Hn7pcxgVwGj2uT
SEmwKpBP0uoMhhxVer8hoTG8Xv27elpx0mC/vmxfOSRbaWIs60xrk1f4X8N4P+nn
7O2p+PT4W7LMOcEAcnSFD/SJe2Adtb46V6F646DhZFCG2w6+sllBt7yN1uVD9TtU
z0D8Y846dBtAcJ+XczzFwInssYrTr98QxEXBFRtW36IcmoSdjaANs3KMfyqupG90
wijpueDSN7TlQ4G4aO0z9f24p5fv08TkzrY1EyHG3w9M4o4ncQV0OjWN50TpRrRY
hNSa4e0/6kUCM2ium62IYqd7MQmeBmkFJnh0Y3XEB6kSlk/YVyRdsms9QupE3Pdn
MOpEQJvwhFnFuUzUPiRR/IpOb1vqLUN31ankZNDza5AeK/g78iMQ9jEoVxNzAQIK
F+0bm0dTrab6kU/8DA0X5RwPnjF730SsK2puRSgeP4oy0bk8k2Egnsq7m37ZHQY/
jr08qOAdb1XgtpeCPKok5HpFHKjoWbK3vv7gtXP5hjTOzQPkVIA=
=qAKx
-----END PGP SIGNATURE-----

--n2n64qp3gm6ara7d--
