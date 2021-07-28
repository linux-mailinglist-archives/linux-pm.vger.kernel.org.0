Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F53D8C0D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhG1Kkb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 06:40:31 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58284 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbhG1KkZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 06:40:25 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2EE921C0B7C; Wed, 28 Jul 2021 12:40:23 +0200 (CEST)
Date:   Wed, 28 Jul 2021 12:40:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: PM: add two device managed helpers
Message-ID: <20210728104022.GB31304@amd>
References: <20210727210202.717181-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20210727210202.717181-1-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-07-28 00:02:00, Dmitry Baryshkov wrote:
> Qualcomm clock controller code (and most probably other drivers) would
> benefit from having devres helpers for pm_runtime_enable() and
> pm_clk_create(). Add those two helpers.

Yes, please. We have quite a lot of drivers getting this wrong.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEBNBYACgkQMOfwapXb+vJPXwCbBU4QqImzDBmscO9GOU9rHtir
w1kAoLWoLLHV8QiNUbgOzfck4H7CKqV1
=fSgd
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
