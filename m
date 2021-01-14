Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71102F6EF7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 00:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbhANXc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 18:32:57 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58112 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbhANXc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 18:32:57 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B4D631C0B82; Fri, 15 Jan 2021 00:31:59 +0100 (CET)
Date:   Fri, 15 Jan 2021 00:31:59 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel@collabora.com,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] power: supply: cpcap-battery: constify psy_desc
Message-ID: <20210114233159.GA18332@duo.ucw.cz>
References: <20210114223617.313588-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20210114223617.313588-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2021-01-14 23:36:17, Sebastian Reichel wrote:
> There is no dynamic information in cpcap-battery's
> power-supply description struct, so let's make it
> static const.
>=20
> Cc: Arthur Demchenkov <spinal.by@gmail.com>
> Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> Cc: Merlijn Wajer <merlijn@wizzup.org>

Acked-by: Pavel Machek <pavel@ucw.cz>
--=20
http://www.livejournal.com/~pavelmachek

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYADUbwAKCRAw5/Bqldv6
8svuAJ9rVnPw9RU42KJajlrbY3gOK06PrgCeIpqx53rI19NOZnW20WCbSiw80F4=
=84wH
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
