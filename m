Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86183EBB67
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhHMR0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 13:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhHMR0M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Aug 2021 13:26:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4D1060F36;
        Fri, 13 Aug 2021 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628875545;
        bh=bmfn7HbaaCItG5D2XO6GaE2puQJLN9rvaABOzoYwYRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwgXXRq72gtd4nZHWuZoh7lOvyjwD50w3KX0bd//GnWIV0vc1ulSzvI/Tnc/M/pk9
         a0m+QuNF0RSxm/QTGyMWyeY4Aeli4trKm6bGJfTNsqC3HLPdthQXE4fHjyg0gU9aTR
         K0VzwueqE0tGHRfClLzJp1hpzipICxLVX+wbGJ8AIB9I9o9sMKuq4K5PqcMrRepXwR
         pXnbFz0d0zaAT7p1gK4rdG2ESVJM6v5sH2aelEdVoZfHfm6AIMCyR9nWdfsRVBSB/d
         E3EJ2UPCDbXbL7cZDdgKR7GnAChJ22fQ3OjVGxfhqOCLbl8EyDPohfhLRxNKXTufl7
         h6MdWyntVwWmQ==
Date:   Fri, 13 Aug 2021 18:25:24 +0100
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
Message-ID: <20210813172524.GG5209@sirena.org.uk>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
 <20210813155438.4ssph6deqksob2uv@earth.universe>
 <20210813155858.GD5209@sirena.org.uk>
 <20210813162029.q5slrkubelfy3mvh@earth.universe>
 <20210813163254.GF5209@sirena.org.uk>
 <20210813171106.entpro4b6dstho4s@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
In-Reply-To: <20210813171106.entpro4b6dstho4s@earth.universe>
X-Cookie: E Pluribus Unix
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 13, 2021 at 07:11:06PM +0200, Sebastian Reichel wrote:
> On Fri, Aug 13, 2021 at 05:32:54PM +0100, Mark Brown wrote:

> > It would be better, the issues I'm worrying about are more general
> > refactorings or whatever that create actual dependencies rather than
> > just trivial add/add type issues - it can make doing some kinds of work
> > really painful if things go via a different tree.

> There you go:

Thanks!

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEWqwQACgkQJNaLcl1U
h9B8MQf/SabFhXiu82blgagfCOLQoxiKYIr+aSGYjCQoWyz9Zvt1gSq1HULJmgc1
ofKQVgValsxqtpU6UYzPMVBIPhqpZ/TIbgYHvlLMSrpD07Nt3tddjDr/g6fYGyj7
dwfQAa5QrxXz3uRPWpszlgQtkas3tpTM4lNF/ytOHWq1Lk9Mz3CmujN9qsbPKf/U
DBVVEsV+oBCVG1atIOrKqZQCUrOkhG/KxhTrw1DquIN4IL6ygGUbhNVxi7nbRgu1
z0TtqU54hgl3ALZZ1jxS3ehe/9zNP4zMZKk1qG+T6pj2kYwRmmDPVD9VFntbP1lP
0KOZoYGZKBO8aBs6x06t78BGFwd42w==
=KFpM
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
