Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AB6302D08
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 21:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbhAYUxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 15:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732420AbhAYUxW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 15:53:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72BAC22513;
        Mon, 25 Jan 2021 20:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611607961;
        bh=HrLqwMmB9QuqNykshbTVTHa1+DOc0VDy8lIvxe0ein4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUrhbj4NkDNkKT2HAYy1gJVIVwG9cmrdRiq/CBDD+1u9APLW3FIvcO58emXryQ5B1
         XJ0LujBQV8y2Yhkgc0yU9o2xhseQbkp1nZ5LMN0axfTUKIFtUc3GWpRqBzbwAwf+Ut
         0VeXc5Vl0yq7u3ViiiTq4XHR+ZlJy8jMoty2bqfp9Ya3BQLTFEjkyt4/WFCvCvx6Dl
         0oJtZaCFc3aeoebZjIshf7uFWib6h0t9dGyVB7eUJ76WLyeVeQ+3v4OJZz3yRCpRPC
         Pjks6Za8uWS6rW+N/hX+sPOYmfueNcjzwNA4Y+/MENuhZRVRkITGEwm0LHIiXSuClG
         /6w2crhu2Rb6w==
Date:   Mon, 25 Jan 2021 20:51:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/7] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20210125205159.GD4510@sirena.org.uk>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
 <3f48e9f8114cac0557abca88d4437849423793bb.1611165200.git.cristian.ciocaltea@gmail.com>
 <20210125192311.GC4510@sirena.org.uk>
 <20210125205048.GA1066705@BV030612LT>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20210125205048.GA1066705@BV030612LT>
X-Cookie: Drive defensively.  Buy a tank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 25, 2021 at 10:50:48PM +0200, Cristian Ciocaltea wrote:
> On Mon, Jan 25, 2021 at 07:23:11PM +0000, Mark Brown wrote:

> > Please do not submit new versions of already applied patches, please
> > submit incremental updates to the existing code.  Modifying existing

> The patches applied to 'for-next' branches were not modified, but I have
> (wrongly) assumed I need to keep them in the series until they are
> eventually merged into master.

> So, if I understand correctly, I should have dropped them from the patch
> series as soon as they had been queued, and only if they need some
> additional work, I can re-add them as incremental updates.

Yes, once something is applied it shouldn't need sending again.

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAPL24ACgkQJNaLcl1U
h9CuhQf/TXNo5eKpTUo+pUm9d26vwESEP6romcQrnmFmNyU4ZhIcsHgis10aABRt
ye8Itsor1mzv4phDC78NaXtr+TD/wF9Fg4Yg+N83rgUIcFXPPSFD5E4UzXoFB5Mt
Mr0zuijpaYRfNKSiXKfKzNEKZB0wGiG3YjvEbVJRvuXkhL8LCGlW0T2xZGRCodbH
wiiT4RXVB9kHIm2mcmoQdjGQHHi9bBpgu6UWPpP2MEq6gF6CWw1/uLWg9CtXnt9l
8OaAt70Obju+Ea1E6dKjQxAQIUTd/UOh6Rs0aQAbYrrmRDJZDbSa1IfyMF243rEm
SrF9cful63vaauj5Nx6PODc7Rr+vjQ==
=90r4
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
