Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3843A8426
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFOPlA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 11:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbhFOPlA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Jun 2021 11:41:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DB176148E;
        Tue, 15 Jun 2021 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623771536;
        bh=rgNd9ro+iBH4rkbur/bO3RZ1IPlfddRdvzaAQ0tXikI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwaiRsjbWTGMIssNvtI9JLxTpQHjMn2x0fKMGqUyKPhjfPnFMsKkSFoECeoh4urJT
         tjeKB6mrgDHxo6SSsM+z9my6O2ndRYHrPX4CJMfWlJGlt8lBSkzmlzuDSOO9AFNQQL
         ywt8bbZI06OUCKTa3rQLjpBLJrf8lz4w0bTrm6019yLrmY1tI54JgzPb5963tOyT2N
         xBlsaCHaw+dsws0vA8W9hW/QbwEkrmO2CIg+R4ijTFDYGw9vbeTx9KPZdEUiTmzcBC
         Q/rhLf9k1tue4WXGQ8dToIG/bC5+trFyINrvAFFAwagOPff0IOA4nE3o9fnq1BFMRt
         AcKlcCZ3HF+Bw==
Date:   Tue, 15 Jun 2021 16:38:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
Message-ID: <20210615153837.GL5149@sirena.org.uk>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org>
 <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <20210615111012.GA5149@sirena.org.uk>
 <CAPDyKFreV-RPzweG8SqFQtvZMOyFbaG2+tMFKc2JkbEj+erb=g@mail.gmail.com>
 <20210615152620.GH5149@sirena.org.uk>
 <CAPDyKFrthc_6rXt1UscKTQnctFXw0XjReEF5bqCGot2n=ChKaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrthc_6rXt1UscKTQnctFXw0XjReEF5bqCGot2n=ChKaA@mail.gmail.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 05:35:01PM +0200, Ulf Hansson wrote:

> Let's see where we end up with this. My concern at this point is that
> it could spread to more users, which would make it even more difficult
> to remove.

Perhaps mark it as deprecated while people figure out how to fix the
existing user?

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDIyXwACgkQJNaLcl1U
h9APSAf+Lh/u48cE9uongDESh5JQD2/iXrn4MOo798Ceppgqi1iB0LraDdA4iuAW
0MBMsG8o/GnMWLrXu7BOpJWY9lwFYITVBCkkU4dbgDU7fQszhmf/VQFcpjg1t5YQ
N4lynsK7DMT93LDEYQN1y6uboeaxQcHVxeIGSPBe1NfGmRmrL1HB+oaEu6nmZ3of
eA0heoYUKz0Cn/Jxzychpn0AzqridSm0KlyMcCNIuOf4BU7yDhPQNFqerQEqnf8J
1JipyDj+xfJ2Ufss+cUHwduRG/Il9lbyy8CuL+y0iNtm1f65EZ0AL+caM6R2M4BR
2refhB9vPMwyBtrY1fZgaM5ttZm/qQ==
=gCbi
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--
