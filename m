Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCE227DC98
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 01:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgI2XUA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 19:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgI2XUA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 19:20:00 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6579D20773;
        Tue, 29 Sep 2020 23:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601421599;
        bh=WPXNf1ElVSRNw3/GmB0unSeJlPq69xRHSvqa12iVl8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFaDLFU5o5Aa0pzYqkKAhtfOSr1ssPQ6UUGMBnCf5x9pTvjnJVZCrEUiiJgZDybmd
         7pbbsgjmjF+pfl8mn2c4b+eyQbt6z6lbDBNj8a4l28eiOtoW6otjOqhN4xZ1qBvOdP
         cTr1sF1lWfwWX4s0TXg+X4JAZK7bSzztQRWHRWmM=
Received: by earth.universe (Postfix, from userid 1000)
        id 440ED3C0C84; Wed, 30 Sep 2020 01:19:57 +0200 (CEST)
Date:   Wed, 30 Sep 2020 01:19:57 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, sumit.semwal@linaro.org,
        linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove Andrew F Davis from list
Message-ID: <20200929231957.fx2dchbky6wvyy4j@earth.universe>
References: <20200917193702.31347-1-dmurphy@ti.com>
 <CAJKOXPc_K-T95MY84qGX6ERi4OmVVGXSkH3XCKqF84qvak_Eqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2ktrx6pnhubyryv"
Content-Disposition: inline
In-Reply-To: <CAJKOXPc_K-T95MY84qGX6ERi4OmVVGXSkH3XCKqF84qvak_Eqg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--h2ktrx6pnhubyryv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 24, 2020 at 02:01:06PM +0200, Krzysztof Kozlowski wrote:
> On Thu, 17 Sep 2020 at 22:02, Dan Murphy <dmurphy@ti.com> wrote:
> >
> > Andrews TI email is no longer valid and he indicated that it is
> > OK to remove him from the MAINTAINERS file for the DMA HEAPS FRAMEWORK.
> >
> > For the BQ27xxx list I replaced Andrews email with mine.
> >
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, queued.

-- Sebastian

--h2ktrx6pnhubyryv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9zwR0ACgkQ2O7X88g7
+poD4A//Y/1rJNuF837cToE8LUnfayGAlHY6IKS77LoK0DvSCZBKxXLnSF++h/fZ
rIcDgFZ6hzNm09Gj6WrY0pgVdv4e+IEHcke45dEmv3XR4qF7d3T2XGTft3aSGyak
gkrk01D/gD1zinyGk5X5mSRyvp/v8CGKak0VEUTA83iUyccQY0ckLpOxvJw7WDRV
CTZ5ALTNUgAUMlmZVzUB+SOH/9KQ3Az0t1YhZqfYyXidF3PgaU1XGdYWTGnVAo64
i06OqguNqZ8cRFOeXXUnZMtL7DIUYXnouCf5Vu44/g4BKfPtDWfLVBWkb1x0D1iC
jTNH1stbndht1so4Dc3GMbvcVIRI3Dl5fc/BXNaxuzmo5cK23EdRmNKXgNzjs2FL
hsuDsEUZSTI3k6H75kwX2ZApxyEU3OLfx1GZwwJa6fG23Y1JOA7xTye97SOPxHKF
5jkgxVgAU5NZlXcMpAsFI2LtK8ZlY+jwoNt0tGbUF3TQ+wjs3yyQi0kafrBAYL0R
NOOt/KBme+edMC9rUuKP8gV/Pu2cKvestktFtH2b3gvgFmLf3Ic1jI3fYb4k36nU
PQL+U8UissAqyAAzq/OmJeqSjDkBg6FFOpj05CqAxu0kp4etH0Yz/GQzr5N3U63I
8RSbguqOItdrhDabnzhsipinFJdUAx6cLKB5QTMKHhG9Y8+5yZ0=
=qhXO
-----END PGP SIGNATURE-----

--h2ktrx6pnhubyryv--
