Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD63168497
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 18:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBURNp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 12:13:45 -0500
Received: from foss.arm.com ([217.140.110.172]:44062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgBURNp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 12:13:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0986E30E;
        Fri, 21 Feb 2020 09:13:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B143F68F;
        Fri, 21 Feb 2020 09:13:44 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:13:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] regulator: max14577: Add proper dt-compatible strings
Message-ID: <20200221171342.GI5546@sirena.org.uk>
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
 <20200220145127.21273-1-m.szyprowski@samsung.com>
 <20200220165614.GD3926@sirena.org.uk>
 <964b8c4c-36ca-203d-e62b-4a8fc970e23d@samsung.com>
 <20200221123813.GB5546@sirena.org.uk>
 <b52332cd-1dec-fdfe-51fc-8605d94abe7d@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <b52332cd-1dec-fdfe-51fc-8605d94abe7d@samsung.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 02:23:57PM +0100, Marek Szyprowski wrote:
> On 21.02.2020 13:38, Mark Brown wrote:

> > We could just remove the compatible strings from the binding
> > documentation, they won't do any harm if we don't use them.

> Frankly I have no strong opinion on this. I've just wanted to fix the=20
> broken autoloading of the drivers compiled as modules.

Shouldn't adding the relevant module table for the platform devices work
just as well for that?  Possibly also deleting the of_compatible bits in
the MFD as well, ISTR that's needed to make the platform device work.

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5QD8YACgkQJNaLcl1U
h9Bw3Qf+ICypwgqpOfbViorwhsNd3hYeovxUVDcqxnxihICh9+jgxBTl7heRL5hd
QsO0mgj65HXPtElBIxhBtE7WZiKbT/WavCR8EHVpoST/q00zg4FKMWlVfbiP3Nqm
2NcRBzx43XUlji4hEiwq4c4FI22PwMw84dqqWczq47rU7AdDX/vTfJEJzgs3jRDb
LcZRK/8ShQjhv8nTDfNIm57atMXTraRQmnRLCH21RkhRo652Pz2oLnWhYamUJvtj
WR/yFEXF20EkD1hAaHYwy2KnaQG5dJuBW9nvD+iFcOq9rQm+IlK+FHb3lG44wAAy
nkIA9S0bNtrAzcebaglfcs3wtVORAA==
=vq2s
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
