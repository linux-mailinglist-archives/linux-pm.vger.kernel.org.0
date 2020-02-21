Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C10167D91
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgBUMiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 07:38:17 -0500
Received: from foss.arm.com ([217.140.110.172]:38454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgBUMiQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 07:38:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF8230E;
        Fri, 21 Feb 2020 04:38:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 780EA3F68F;
        Fri, 21 Feb 2020 04:38:15 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:38:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] regulator: max14577: Add proper dt-compatible strings
Message-ID: <20200221123813.GB5546@sirena.org.uk>
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
 <20200220145127.21273-1-m.szyprowski@samsung.com>
 <20200220165614.GD3926@sirena.org.uk>
 <964b8c4c-36ca-203d-e62b-4a8fc970e23d@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <964b8c4c-36ca-203d-e62b-4a8fc970e23d@samsung.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 11:44:03AM +0100, Marek Szyprowski wrote:
> On 20.02.2020 17:56, Mark Brown wrote:

> > Why would we want to encode the particular way Linux happens to
> > represent regulators on a MFD into the DT binding?  It's not clear that
> > this is a generic thing (another OS might choose to have a separate
> > object for each regulator with no parent for example) and the compatible
> > isn't adding any information we didn't have already knowing about the
> > parent device.

> Well, that's how the bindings for max14577/max77836 are defined:

> Documentation/devicetree/bindings/mfd/max14577.txt

> I've only fixed regulator, charger and extcon drivers to match the cells=
=20
> created by the current mfd driver.

We could just remove the compatible strings from the binding
documentation, they won't do any harm if we don't use them.

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5PzzUACgkQJNaLcl1U
h9A8Ngf/SfRefh9o1XBTE2v/15NpjtrE65kGU09QEQ1tkHy4YEO5itYQeNBOU92n
mwdRrsqe1dh5P303HYqqLL6NPr85ZRfH5dSAVrUVEymN8kmBbjDnRlk5erYMqWUo
ZGqe1H85+7ncnoVN+p9OhazcrhGgDYiOI0Jh2W8xmoOkkdnEIfsE+izIpEK/qyhS
Xa3M0XrzGs2NKZxn9l3Cd6/2V/5sKuAuwT3nt65q5LZ1Qciz2Yt+Iuj2g3+ig37/
oiVbnUIP2/vtkHxO9ofdoaTTTkx2yXT4SXXaMWioB0OHLd3vxM26LY/F6CWtAMMF
phTmMf8zdhw7NSHZpCFFEdHiuy+9ww==
=AD14
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
