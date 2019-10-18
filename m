Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A2DC420
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 13:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442649AbfJRLmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 07:42:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390948AbfJRLmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 07:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bxQ3oNa0TABOgDWBQ/9ale8vMQAfpMYiyrwn8aMjqW4=; b=PmMLrwSRB9YtHzgtZKWC6wq1G
        G6wEOmkUGjj2wW5IUTNTKz9PkS2LYcKQuYVfZNb7Bh1Ziq9f/zs5b3wwx75SGVHd0ixGaqAAA2k/O
        hefo7LXmBJcbXisZs+d0fDw4Kql6wiN5ifU4awYoCNtBXJHth1T9tahzZ/hMdGigxW64k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iLQe4-0003Sm-Rt; Fri, 18 Oct 2019 11:42:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 057342741DEA; Fri, 18 Oct 2019 12:42:11 +0100 (BST)
Date:   Fri, 18 Oct 2019 12:42:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] opp: core: Revert "add regulators enable and disable"
Message-ID: <20191018114211.GA4828@sirena.co.uk>
References: <CGME20191017102843eucas1p164993b3644d006481fb041e36175eebe@eucas1p1.samsung.com>
 <20191017102758.8104-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20191017102758.8104-1-m.szyprowski@samsung.com>
X-Cookie: Smear the road with a runner!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2019 at 12:27:58PM +0200, Marek Szyprowski wrote:
> All the drivers, which use the OPP framework control regulators, which
> are already enabled. Typically those regulators are also system critical,
> due to providing power to CPU core or system buses. It turned out that
> there are cases, where calling regulator_enable() on such boot-enabled
> regulator has side-effects and might change its initial voltage due to
> performing initial voltage balancing without all restrictions from the
> consumers. Until this issue becomes finally solved in regulator core,
> avoid calling regulator_enable()/disable() from the OPP framework.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ppRMACgkQJNaLcl1U
h9AQ0Qf/YJW+4sFCOojivciJSSqs/v5S0eCBH3F74e648ET8wW+lGP6d7Wabk09w
lkvEnfxTqHUbDCKBN9GqkOKINxccWUlw4iSlPh24Z0J90Z/jXq0WpnzIxLyviQJh
J0mDFLrAO1TU7Bu8Hq0qnjA9TFVL7ZtBJS4ShzCgTWzIZAa02VbIDYzE3sC3YhT1
JJpkMq76noTi2LW9Rb6gsO+WXkDYrWxf9s3PKCkEyrVqRas+l01sYed8YQ/X4doW
D6tb542gwAIlCEu7QM+XU3Gkdi3a/h3t0RM/SW4cMifuWlcXndcApzsmtslwfQSx
dRCApMxr2BQbuHDWW3uWdE9VIk8Wow==
=PYPe
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
