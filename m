Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F019C1CAF5E
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgEHNRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgEHNRW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 09:17:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E92A206B8;
        Fri,  8 May 2020 13:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588943842;
        bh=3afVTxvPGGedmPH0V3XdskRZC6TaovubqNcaoRvIw84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wljXzPmztGYalAoA9rpHKhIthnbvDxCDuUWxhLA7Ux6IyXHMuyVvipCwDeUZASH4v
         1EK455Sr8j9CcqPSrL15a0cT9Rl1QmpaJSoZaLPajRbx8xwhrmS8SK2e0ceK4sTUz4
         UN42bI9PAZGXE3IEkKsserK4lyePSkv2+6GHkAhQ=
Date:   Fri, 8 May 2020 14:17:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lgirdwood@gmail.com, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/11] Support ROHM BD99954 charger IC
Message-ID: <20200508131719.GJ4820@sirena.org.uk>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline
In-Reply-To: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2020 at 09:03:06AM +0300, Matti Vaittinen wrote:
> Sorry folks for excessive amount of emails. I am resending this once
> more (I already resent v10 and v11 has no changes but was just rebased)
> because I am afraid the previous version did not reach Mark. If this is
> true - I am the one to blame. I see I sent original v10 to all other

You probably should've mentioned in this mail something about applying
on a shared branch - I had seen the mail about that and was planning to
handle these this week but if I'd missed Sebastian's mail from earlier
in the week I'd probably just look at this and realise I'd reviewed
everything relevant in it.

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61W98ACgkQJNaLcl1U
h9AkfQf/e/9GJz9qTkXY5cZVnaFer3RazGsHnLxJrdUop24aL0otGQdqY/HW1box
mUooQnGc65yBNG12MO4fNjeylRqJEzLpmnawWYXmxCChD1OJDPC+kaHFOdddPGaO
WGIviYxXXH5nOqF1nOgX65ZhnGwMv+LXMG8wUd6Gj4s0lbxWfgDV7A3LkQ+fTssK
iVIAc0X0cmA/YYSpgyBERUM1GlBcve0ep1HGk1VUlvcgKyHOerCWfSatpt2Wy8Rx
Ilory7thQ+weCvjC3y++s1kSSI46bKw+em0pr9nyfQVKjB2qTx6mhe/uKOT/YX3k
VmPQuOnH4KQyGi1ea88uKzN+fK1VZQ==
=7/MS
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--
