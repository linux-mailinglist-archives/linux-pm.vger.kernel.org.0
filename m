Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD773EBA26
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhHMQdn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 12:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237469AbhHMQdm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Aug 2021 12:33:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E011610E9;
        Fri, 13 Aug 2021 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628872394;
        bh=RsV8b7RStf2aqBJP+j/Ai99xGWXWnGgnyJ6Mj4v1/4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UA6Ffbs4QUyvRzsMPdO7rMhcGsOFpNMxceFWbpvL8FZ9RVpBNCt6EDoHuLdVEjzmg
         tXqSFeABDp+bCfql/5Gt25nfVPJwqsotFphDY15t9zmicU/g9VbLfs+4SP0nNTwcGM
         kyVp3rOEIZ9yuRhn5VzWvhVuMIHQU8wX4Oh1pFri0cdiPH+RA+UwYCooL1fHjJuvWt
         UQnUUW6cfMSbqSLPVDvUy4QdpwGdWBWbIBgSD+5o/HBgjSL0Ucn9LuheyxTt6TgoB4
         FHvj6ywBn8d1Dff8cch3kZnO6ouhIwGfDOxiyeIZycGZUKwouvZrPjmut+8uykNZGb
         ILANYOViAGq2A==
Date:   Fri, 13 Aug 2021 17:32:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH resend v6 0/3] power: supply: mt6360_charger: add MT6360
 charger support
Message-ID: <20210813163254.GF5209@sirena.org.uk>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
 <20210813155438.4ssph6deqksob2uv@earth.universe>
 <20210813155858.GD5209@sirena.org.uk>
 <20210813162029.q5slrkubelfy3mvh@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <20210813162029.q5slrkubelfy3mvh@earth.universe>
X-Cookie: E Pluribus Unix
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 13, 2021 at 06:20:29PM +0200, Sebastian Reichel wrote:
> On Fri, Aug 13, 2021 at 04:58:58PM +0100, Mark Brown wrote:

> > We're still waiting for review from Matti on the linear ranges bit -
> > normally that goes through the regulator tree, do you have a tag to pull
> > in case of merge conflicts?

> He actually already provided his Rb in v5, Gene did not carry it
> over properly (I added it) and the patch looks simple enough, that
> Linus will know what to do in case of a conflict. But if you insist
> I can unroll my tree and create a topic branch for this.

It would be better, the issues I'm worrying about are more general
refactorings or whatever that create actual dependencies rather than
just trivial add/add type issues - it can make doing some kinds of work
really painful if things go via a different tree.

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEWnrUACgkQJNaLcl1U
h9CcoQf/Winqb6RX4ilu9FDNU8XLNiJFX2+ApqvxEDI72rwph0/OJ5DfJ2sbXltf
EQaGfnmUSWRlGRsGnuE/QdnmgJ++HwfaA6NL4BmYalIAsRZvg/+bGxRLwEDLZZpz
grdaGitjklhn3vrT00339tbQcPn4gOSMxvnO0gCMtRnGd1MWYenRg02Dptq60v2K
xF+i06p+PQX2aIHk+Xnyo9QCap1y+6A2Yjd8z/BEuQ+0hJBLXpzeNAxltd5DsbGA
DjFDEokCy+9eZ6gvjnU9/T2Dl6rn7iNIP3NA0CJZcesIFLgx9i/bmfhbdVXsXDGS
ggSqbh8TenBgdCiK/riOYOLQ7nOCDQ==
=InBg
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
