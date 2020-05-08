Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C731CB5B0
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHRRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 13:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEHRRy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 13:17:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACA721775;
        Fri,  8 May 2020 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588958274;
        bh=lq+hciLkQOEXzR19lHNCP9/llUqPt28NPxqL6V+Mcfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2QVgicUlkn7SVE8LGZRa4qr6We0w4yt+xQ33GESPaZVQ5hc4vmYEpFd+TJD5C3f0I
         alhXtrjE96VsPM094OdaHAxi0twP1bHFMzW6QoRYSa12PBbojtDH01uED5eoFcr9iS
         Xt7eVLk6qWAQv6+eXD9GZKHt5TP+biMPQnuT8yN0=
Date:   Fri, 8 May 2020 18:17:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lgirdwood@gmail.com, sre@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 02/11] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Message-ID: <20200508171751.GM4820@sirena.org.uk>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
 <311fea741bafdcd33804d3187c1642e24275e3e5.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
Content-Disposition: inline
In-Reply-To: <311fea741bafdcd33804d3187c1642e24275e3e5.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2020 at 06:40:43PM +0300, Matti Vaittinen wrote:
>     Add a KUnit test for the linear_ranges helper.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

This now generates:

WARNING: modpost: missing MODULE_LICENSE() in lib/linear_ranges.o
see include/linux/module.h for more information

when the tests are built as a module and select the library.

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61lD4ACgkQJNaLcl1U
h9C4Lgf6AvdLJ8FQbtRP9+zEn6eqGAFhqIsuHJQMSO3Rfo4qyuCka5btjjUo24P8
AZgvCw0fu23Ci2MURx/9ZWaI86NnBibPBYqSkpJrv4xiA4+hL14zILqUkuwwEzkt
IcBwT9je+SM9rTnInZ+LhU3CKckEKXL+5GLPwwYEtBRkdwn1yS6IRTVIcZV71sgD
6hqpVk9oI7J8y5phD0R7W5oIXHumr7sXVQT4PEuwEYFLm4PSdsOjno/GC9OE7BdK
Tr9fMkMUVEOb/rCxVaOCqOw1TmEVDqTq+hY+r1GueiFLm4kH4NRfiCrkOd1GAIqO
fU9BUK5FXn+1K9KTiaQACd3xRUn0XA==
=XB6r
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--
