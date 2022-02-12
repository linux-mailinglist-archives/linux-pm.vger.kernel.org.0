Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8324B34B9
	for <lists+linux-pm@lfdr.de>; Sat, 12 Feb 2022 12:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiBLLgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 06:36:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiBLLfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 06:35:50 -0500
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 03:35:47 PST
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711626AF3
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 03:35:47 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B797F1C0B80; Sat, 12 Feb 2022 12:29:17 +0100 (CET)
Date:   Sat, 12 Feb 2022 12:29:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     trix@redhat.com
Cc:     rafael@kernel.org, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: cleanup comments
Message-ID: <20220212112917.GD20866@duo.ucw.cz>
References: <20220211161027.2516447-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20220211161027.2516447-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-02-11 08:10:27, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>=20
> Remove the second 'the'.
> Replace the second 'of' with 'the'.
> Replace 'couter' with 'counter'.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgeaDQAKCRAw5/Bqldv6
8szcAJ9se8Q+P0aWXEYHR6dFnSEfI8hXegCeIYNeGJ2Sb1BCbaS5ho75AB/wNiA=
=5YzR
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
