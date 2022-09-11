Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC2B5B4D83
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIKKh6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Sep 2022 06:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIKKh5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2022 06:37:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96321C2A
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 03:37:55 -0700 (PDT)
Received: from mercury (unknown [77.241.232.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A9ECC6601F07;
        Sun, 11 Sep 2022 11:37:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662892673;
        bh=LHY5dd3fLZeanI3jeehHYlqdTMk21IhwnLjhcb9N3s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZcPfyAm+P0QS8fiL7Sq6D1IrlrnLq8crJBBUQlP9kOVHgHr+hdM+f/TFVMOqxSjFk
         TUAvY8n/bo78ghQ64foctV/bkfdrihW7e7UBJkcc+82z3y0Oq2qqCdn5QsGyIdDqLG
         b1LUg9k00sV5jNBBmR4BkAqV9CICDtEzyI+UHEp/+yA8UiFoAIgxOPSX3fG+HYK0p2
         aOwsWtX3pfFWEmIiKA3uqKUFEsTfQeqUmpkmwe5EFS8GiDTiekeDAjM19Gu4PRipNw
         B+63qwg7RYsrL7Jurgy2+LT2+d1KlpdznfDGtodtsWesu4SUpzfRXosyr2t2n62ktU
         3feASG6Qf3Zrg==
Received: by mercury (Postfix, from userid 1000)
        id 395F61063348; Sun, 11 Sep 2022 10:58:11 +0200 (CEST)
Date:   Sun, 11 Sep 2022 10:58:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittineen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] power: supply: Explain maintenance charging
Message-ID: <20220911085811.cz6xkcpxgbn34ygs@mercury.elektranox.org>
References: <20220719114131.62470-1-linus.walleij@linaro.org>
 <CACRpkdbYeCqJd1pqtEMb7oTFvYU+D5kJpE9OKnL7XGL8Ywiftg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3eict4lcxtpxn7w"
Content-Disposition: inline
In-Reply-To: <CACRpkdbYeCqJd1pqtEMb7oTFvYU+D5kJpE9OKnL7XGL8Ywiftg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--r3eict4lcxtpxn7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sat, Sep 10, 2022 at 09:01:38PM +0200, Linus Walleij wrote:
> On Tue, Jul 19, 2022 at 1:43 PM Linus Walleij <linus.walleij@linaro.org> =
wrote:
>=20
> > In order for everyone to understand clearly why we want to use
> > maintenance charging for batteries, expand the description with two
> > diagrams and some text.
> >
> > Cc: Matti Vaittineen <matti.vaittinen@fi.rohmeurope.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Sebastian, could you apply this patch?
>=20
> I think I sent it in the merge window, so easily missed.

Yes, merged now. FWIW I did not miss it, but I was busy the last
weeks and did not yet collect power-supply patches.

-- Sebastian

--r3eict4lcxtpxn7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMdox8ACgkQ2O7X88g7
+ppKtg//Vlq79Lq+TUauocLgSQfXNuf55lf0e6k9ofPShyhLSDvHaC++No8191EL
znarJTWYDsGliuZ8F7qNBWnK/wZZjBkLd5+2YmIAveX12FHBk9fs9j277EOpPDCL
GwIcCRNXa0nIra8bkaOwG65qiHAaCtgrzHArrXZJvFWUhoeAk0wOZgkm/e9RUKNy
DMBGzK1Zv7/83HCRNk0KRyt933I4hne1Eq29fcDOZcxQhdLUEDQ1vcLeNFshHJQa
FZrq1aIvVVXU+OiM0H5DnTF+atF+7mjPnU5EoeZ2CewUVloO+qhbLNYRKvTfn3g3
5qpucsC72aaeuOmojSfHQ6+vtUzEko/ACljBB+IRREs9oOLdoFaWS7yE6cWtsgOi
gfNIyjI0h1WjR+YPqk7hNS1Ht5DnKGnZ4tWJZuymrvpAp0Hipnda1Lsfe5r7TThs
NyE7ayzfIiojUYE8N4ntMfH4BvNg9bCKkvFNv7nbPcCKrEn2mmmHzAR3SRgPSU8z
vYcIPvC57rrXwypOus1R/AqjfpQk0WsQmaQsOeziXEAriQMDnMjhJYTveqOjw6c1
rGT6BK0lPWb3vwTEOIUE3YuTxwB6YJys4jZXvZH9IrByuhVoQPIUdD24wd0JCe96
48L9G7kjqJDjnHSCjCUzVQZgu+fPwTF0FyImK8a9oKCIS8LR2VI=
=qVv3
-----END PGP SIGNATURE-----

--r3eict4lcxtpxn7w--
