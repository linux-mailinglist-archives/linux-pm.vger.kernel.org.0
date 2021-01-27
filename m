Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961683066EC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbhA0V75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 16:59:57 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:36062 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhA0V74 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 16:59:56 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E514B1C0B8E; Wed, 27 Jan 2021 22:58:57 +0100 (CET)
Date:   Wed, 27 Jan 2021 22:58:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] drivers: base: power: Fix resposible -> responsible in
 runtime.c
Message-ID: <20210127215857.GB23419@amd>
References: <20210120143312.3229181-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20210120143312.3229181-1-unixbhaskar@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-01-20 20:03:12, Bhaskar Chowdhury wrote:
> s/resposible/responsible/
>=20
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
http://www.livejournal.com/~pavelmachek

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAR4iEACgkQMOfwapXb+vIrbgCfdAXVQ5esM8uUona2ZK1AXRy6
S4sAoMKrqp+AlgXyJ88BNZr8d8ra972J
=jVZx
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
