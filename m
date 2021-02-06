Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D5F311C49
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 09:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBFIvg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Feb 2021 03:51:36 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39098 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFIvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Feb 2021 03:51:36 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0B62C1C0B77; Sat,  6 Feb 2021 09:50:38 +0100 (CET)
Date:   Sat, 6 Feb 2021 09:50:37 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Adam Ford <aford173@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] thermal: ti-soc-thermal: Use non-inverted define for
 omap4
Message-ID: <20210206085037.GA15736@amd>
References: <20210205134534.49200-1-tony@atomide.com>
 <20210205134534.49200-5-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20210205134534.49200-5-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When we set bit 10 high we use continuous mode and not single
> mode. Let's correct this to avoid confusion. No functional
> changes here, the code does the right thing with bit 10.

Seems okay to me. 1/4:

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
							Pavel

--=20
http://www.livejournal.com/~pavelmachek

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAeWF0ACgkQMOfwapXb+vJXogCggf/PATmsqQj9afp1RX5Ex5UE
tekAn1oRdjaJiDARyjDlQRp33SU5l8s/
=nyzP
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
