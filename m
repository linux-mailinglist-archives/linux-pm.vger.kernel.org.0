Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E817F1CAD4A
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgEHNA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgEHNAZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 09:00:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55B722054F;
        Fri,  8 May 2020 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942824;
        bh=3ugVuzvwFtqN4lGuBubM/XH50ivcbeAlmpyOW5SFS1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwOfJxS6p5AMxuoLBvf85YymZxEcLp5cUNT/O1vYkKjewm56/dLYzT/cb4ElHvd56
         l9GjoGzaZYb0ABVYuIErbj03xGk1HHZc+N1XZzkyUFCER6L0L7MyTKt8qXWz4l8ZTD
         fL0sN5LXjV8QzwmfGvi3raL84qYXCePEhQgJ+OMs=
Date:   Fri, 8 May 2020 14:00:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lgirdwood@gmail.com, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 02/11] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Message-ID: <20200508130022.GI4820@sirena.org.uk>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
 <7e91212b3990ce503508bc1c83e13dc793b73668.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline
In-Reply-To: <7e91212b3990ce503508bc1c83e13dc793b73668.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2020 at 09:06:08AM +0300, Matti Vaittinen wrote:
>     Add a KUnit test for the linear_ranges helper.

This fails to build an x86 allmodconfig:

ERROR: modpost: "linear_range_values_in_range_array" [lib/test_linear_ranges.ko] undefined!
ERROR: modpost: "linear_range_get_selector_high" [lib/test_linear_ranges.ko] undefined!
ERROR: modpost: "linear_range_get_selector_low_array" [lib/test_linear_ranges.ko] undefined!
ERROR: modpost: "linear_range_get_value_array" [lib/test_linear_ranges.ko] undefined!
make[2]: *** [/mnt/kernel/scripts/Makefile.modpost:94: __modpost] Error 1
make[1]: *** [/mnt/kernel/Makefile:1319: modules] Error 2
make: *** [Makefile:180: sub-make] Error 2

The test code needs to select the library.

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61V+UACgkQJNaLcl1U
h9D+Iwf9GfagiDxyLur1Rf4F30//I9/4ueaSGe3kM7uIASZwPlxmL+uk8zfwgstc
BdBocDIS/rEaXq+n7rtNKLTy8zXmydK7PEXJFz9wC4TQqiDGxeEAykOmw3alyCh/
unQtZ3tlOyQJsOTFvAiyuS2GXN1oP8/Kw7mtsSyhFGiYcmlHijjAyvtgWx/RYHay
Kg+UyFUCBpEBvOoG+bOWBiJhnY1yf1pMNmgCEqzD5dwDLJwYraA/r40/AUWTq8xj
hn6/fCceYAOAQSa6njAMthZLXTC45ztVUFLKDf8CCh4h6sTjP5oaoDHuJ06EUYa0
CjPFz0VFuJGFQI8wTBIruaZxhR9nvQ==
=SeuK
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--
