Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64E0287E7D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 00:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgJHWEe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 18:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHWEe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 18:04:34 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B22122241;
        Thu,  8 Oct 2020 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602194674;
        bh=wfh+nroqWjxQUfMFwjrN4gyOzugrtztkrV/QzYyaOEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yNibCQb4SPylXaObnwGuj2e+f2bbFPPYTtJkGlzQPu829m/Bxx9IglcxgDjyl2cnl
         6nouCGpZiv0Hzv4+7Ya7FgvwsLOrAcj4lG1CiW+KlWNXUjHc0jMqS4GX9HOjXzY+Gl
         2nF+T8wOXndBYWnrNxDl9x9/Zn2a741vhcnONJZA=
Received: by earth.universe (Postfix, from userid 1000)
        id 990453C0C87; Fri,  9 Oct 2020 00:04:31 +0200 (CEST)
Date:   Fri, 9 Oct 2020 00:04:31 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Colin Ian King <colin.king@canonical.com>, linux-pm@vger.kernel.org
Subject: Re: power: supply: bq25980: Add support for the BQ259xx family
Message-ID: <20201008220431.kv4kwh3vz5zkfdp4@earth.universe>
References: <af1a1044-5f45-ecaf-244e-90650f17ff17@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ptjf4mkn3tbyogwr"
Content-Disposition: inline
In-Reply-To: <af1a1044-5f45-ecaf-244e-90650f17ff17@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ptjf4mkn3tbyogwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Can you please look into this:

On Tue, Oct 06, 2020 at 06:59:22PM +0100, Colin Ian King wrote:
> Hi
>=20
> Static analysis with Coverity has detected a potential out-of-bounds
> read issue in the following commit:
>=20
> commit 5069185fc18e810715a91d80fcd075e03add600c
> Author: Dan Murphy <dmurphy@ti.com>
> Date:   Mon Aug 31 11:48:49 2020 -0500
>
> [...]

TLDR: In the following code bq25980_watchdog_time[i + 1] might
access invalid bq25980_watchdog_time[4] when i reaches 3:

#define BQ25980_NUM_WD_VAL 4
static int bq25980_watchdog_time[BQ25980_NUM_WD_VAL] =3D {5000, 10000, 5000=
0,
                                                        300000};

for (i =3D 0; i < BQ25980_NUM_WD_VAL; i++) {
        if (bq->watchdog_timer > bq25980_watchdog_time[i] &&
            bq->watchdog_timer < bq25980_watchdog_time[i + 1]) {
                wd_reg_val =3D i;
                break;
        }
}

Thanks,

-- Sebastian

--ptjf4mkn3tbyogwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/jOkACgkQ2O7X88g7
+pqSNQ//QXvx+ieyRCuzlytfUpKoI1U2x7lOnnNHqzQY0xmH3jXnDtOTLV6GEiOs
bDDTxLwf1GT38Cle2tjV8jQvQxv+xX2VBHXGdmDNFBqY5v3tg7wZ0iK3Hac0BbTl
ZMf8BpVkUP8/WXklhMpit67eJ/qhABg5f1Ru6pGzE/WkV61SJiwpiVuGhWSyBYej
ym7r1xJcr8rp4nEfm1P4mUnrmWH+6OJrbLeX9om+Mvjp7w0Wt8tgml0kMcJpYlth
T84M7r2YBlOJvcSFdYh6nZHjfi2Et1ta3Zyg1RpKYwKDmaLC0Ppg9YFldRBhM5+5
065TSsgALtdZMcM9Z9MDiiCWn9V1IRzVKHWip49AHCmxPMm+UqrZjFYH0HzG/oVp
Oj18QKk/rEl+EvT4r8mqKSG+xvFVn3MPpjB+x/t9sbdt840ofxY8AjgJqRDsjChE
nWkqX0TKrghHzNOb8g8VoW/+7F7lfUyJN1WtEl6e27BzsaykZs3IuwNdFxCZ+QWZ
+DrQIDxU5Te8YuPlNImur2FxkGkmQ6VSmVIYoVCx2Tql9Uz+EaFptCl4Cke8heUY
OFyl2vliosjj1h7OZkcuqwrE8M0nbI8tx1bByuJD9msZGonZQEYtuBPthAw+M5aV
tCqe2o8kGjmTV3iq/H6XFtyuX81w/4ybbeotBS/GRdSdz7/JXHU=
=Zj6B
-----END PGP SIGNATURE-----

--ptjf4mkn3tbyogwr--
