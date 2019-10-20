Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613DBDE074
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2019 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfJTUft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 16:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfJTUfs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 16:35:48 -0400
Received: from earth.universe (cust-west-pareq2-46-193-15-226.wb.wifirst.net [46.193.15.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D927121928;
        Sun, 20 Oct 2019 20:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571603748;
        bh=gIyQJ9nxmVz8oDzGR+U8BzX4oXoQvuwbzMgyFA2XsAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCV9O6M/m1vYckWDVH4mnnMlPoAXdSBaBYH2RTxFhPnPDebFJeRBCqcDTnxYhB7VL
         NyQiNHfzxSCg+KqC7XZ9Tfr/poSLFgleKNtopixgVX8MjQkl2oiYRly1bQp9hehemN
         W7ITgVSQeoFAzpQdoflESxDikzI7kbsWfl2zgXNg=
Received: by earth.universe (Postfix, from userid 1000)
        id 2765A3C0CA0; Sun, 20 Oct 2019 22:35:46 +0200 (CEST)
Date:   Sun, 20 Oct 2019 22:35:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3 0/2] cpcap charger and battery changes to deal with
 dropped voltage
Message-ID: <20191020203546.vjrbv3hm2c6kob4r@earth.universe>
References: <20191016224122.10126-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zaz5h3axnegm4ilg"
Content-Disposition: inline
In-Reply-To: <20191016224122.10126-1-tony@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zaz5h3axnegm4ilg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 16, 2019 at 03:41:20PM -0700, Tony Lindgren wrote:
> Hi,
>=20
> Here are the changes for v5.5 merge window to optionally allow reconfigur=
ing the
> charge voltage if folks want to do that.
>=20
> These depend on v5.3 + [PATCH] power: supply: cpcap-charger: Limit voltag=
e to 4.2V
> for battery merged into v5.4-rc1 so we can keep the 4.2V fix usable for e=
arlier
> kernels as needed.
>=20
> Regards,
>=20
> Tony
>=20
>=20
> Changes since v2:
>=20
> - Fix up typo for 4.1V spotted by Pavel
>=20
> Changes since v1:
>=20
> - Sent the 4.2V charger change separately as a fix
>=20
> Tony Lindgren (2):
>   power: supply: cpcap-battery: Fix handling of lowered charger voltage
>   power: supply: cpcap-charger: Allow changing constant charge voltage
>=20
>  drivers/power/supply/cpcap-battery.c | 85 +++++++++++++++++++++++++---
>  drivers/power/supply/cpcap-charger.c | 83 +++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+), 7 deletions(-)

Thanks, queued.

-- Sebastian

--zaz5h3axnegm4ilg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sxSEACgkQ2O7X88g7
+prZ4A//WE9hpZiyBQxiyru2Tt3VzUKORclzuCyVGApgEYy3BPB4QnX1930aongw
xibHblO/fjFOk431702hOZntu8+nnglWOSfVyujNH/b7mmB9jAvxTyVwif0AGA0j
5TP66ogdXgcBbofbJK+13niuMz7HC38y0HBOpCqEhsaQkrCOHPTg3+jSZTdJ04/h
joFGV1JYIIWpCR6Y70fL71rxz3I+E0GnWpJXPxVMkN/nd9j+HtJVqDbZc59TM/Ld
akNw/2ivWdTA7zmT3A2o+EV8GH7Ukm+AVkYKfnfrrL4cRrOG0u0mbCpvuPDeyugQ
OILcWgB7EuSHY+dVUOKbRABl6d5vNtkT5ojYz19YDo3IwZfC57yrIKyY4OZ514JS
qc0ewTjFOYj65qCqCRuKEDT78URJUIf6g1JevuRRZNCi35tcwEQ/yQtOc/avQe6o
oJzVa/aAh8WdGwCl4PpvjjBD+s1d/u0yTSJDHWJNdPmF0ZZhX3tuXmO32GaZK1dH
IQRDR0DfcEU02sSX2VVxYjwylYo8c0RziGJVcXa+szzlcNTL1O4NNqA1AJjGl8YW
gBLxfQDvYk148q/v7KNHs/fGQPJHfGD8UB+t6loIDt1VTTyNyQ1jxHC2CfOsFit0
WqIJGLuh1iCJBMG1NI4c5FJqCS1HctQ/FtkD6Xv9I+rSwG6HD/Q=
=PNPs
-----END PGP SIGNATURE-----

--zaz5h3axnegm4ilg--
