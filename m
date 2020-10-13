Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FFF28D63F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 23:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgJMVkN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 17:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgJMVkN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 17:40:13 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC58A21582;
        Tue, 13 Oct 2020 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602625213;
        bh=mHiysqJkcsaVHBb3pBlRG17I+HxL8BTZ42A6v8iuD/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwfQ/KkhOQBTWfMQuvnvf1aUYSygb3PDm+bbzE3nPXUNlBm8mHKVzzpYL3xF5u1c9
         lvWVH2+higZrwdskAgYH1O3Jtop5lvdIQPhhSUkBzNucgVwpHdpbnjOT/cEPrNOB1y
         37xxab+5k7bLkIqPLISASLrVTCq7Dgb6Fo3sAfbU=
Received: by earth.universe (Postfix, from userid 1000)
        id D282F3C0C87; Tue, 13 Oct 2020 23:40:10 +0200 (CEST)
Date:   Tue, 13 Oct 2020 23:40:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq25980: Fix uninitialized wd_reg_val and
 overrun
Message-ID: <20201013214010.2qulyhqo2x6lebwl@earth.universe>
References: <20201009121205.28178-1-dmurphy@ti.com>
 <f75856b4-88b5-38af-8d31-a7c19c978f26@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kitil4vbe2z42uf6"
Content-Disposition: inline
In-Reply-To: <f75856b4-88b5-38af-8d31-a7c19c978f26@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kitil4vbe2z42uf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Tue, Oct 13, 2020 at 01:03:13PM -0500, Dan Murphy wrote:
> On 10/9/20 7:12 AM, Dan Murphy wrote:
> > Fix the issue when 'i' is equal to array size then array index over
> > runs the array when checking for the watch dog value.
> >=20
> > This also fixes the uninitialized wd_reg_val if the for..loop was not
> > successful in finding an appropriate match.
>=20
> Might want to pull this into next as well this is a 0-day bug fix

Yes, merged now. I did not take it directly, since I had to rebase
it first. Please always send power-supply patches based on the
for-next branch, which already contained a fix for the uninitialized
wd_reg_val.

(also no need to Cc DT people for this patch :))

-- Sebastian

--kitil4vbe2z42uf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl+GHroACgkQ2O7X88g7
+poGPg/9FmY39emByDrWFBKDPkT2LQISCw8Uw0buqcEFvi6KWjzFwVGE/EdlaIeu
0eDp1/B34sYIAVfSdaDK8J7a57UpHC8c3ReuEz2TcJxbNSjyWy9V1O9OzVfYCfvA
e31m7t2VdB7sjArMBkxgGdvjIkWsaDZKhIhImb5Zw9OOcSmuVBPO6w6x5SkY+hKb
PPTZfbZspPdYYshVjQQGDRttU+FjPsoNqrxBq+2sT1Q1r+orKM6Hf+0iB5mgNleE
28P1bFcdSaYgsSSskaVxSJvG15uGHHvkbi634WOdfnH6QcTvOEcqgPu7l5FhxAd8
365QdowHxbII7p3ViknriVAMbm+hHkVSlqR/R4HffND8o6fhUCdgsp9gQb7epcsQ
7rN7z5vwH/URsF6hu3Aej/6FQ6kSVTIFTmoIv/C92v9xtt2DOtgOv/68rZeVNUpC
tZMJjjGJOFT5JmLeYvtsG9YxCsAdCbBTuOmTaufMhL1DVA+3Uj/ft/2li0FKRgfX
JfyRD/d+pQDzfjf2CEJnPtKfMQffOnW3xf0Ki87Zh+ouBWiirTC1S4Bf6dyFoGld
sl8dKHXOXmVYDNJMRBye4c2RDcXE1GcuCctOVbQEm7+7qNE/nKWWT0F/QaiMvYKM
RimhDvoMPA0mLCfWW5cTH3/4fAD7hp983e2mFkdZyD1O0SWrzc4=
=MQmv
-----END PGP SIGNATURE-----

--kitil4vbe2z42uf6--
