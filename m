Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F032C797
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfE1NPg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 09:15:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53090 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1NPg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 09:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BblpOpFREi2nfI7PrhAnSrsLHFooqML/drjwmo5tWZw=; b=ccqw3W6F00V3/DVzf6rsqL1qw
        unZI8FfF9dGo5mfzG31+24CCFTPT/z8Jv2dEJx7l9maiaMOoW3VDlw55OB++aE7jsLHZ1FrsYbjcl
        Uuyvx6Qrz/vomXuypGN9VLvd7LpNThJ/gfXFMZ66Q7dLNfGUVV8eo3XI1zpECkHO7XjUI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hVbwY-0002T8-2f; Tue, 28 May 2019 13:15:06 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 9E733440046; Tue, 28 May 2019 14:15:04 +0100 (BST)
Date:   Tue, 28 May 2019 14:15:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matt Hart <matthew.hart@linaro.org>, mgalka@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on
 rk3288-veyron-jaq
Message-ID: <20190528131504.GI2456@sirena.org.uk>
References: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com>
 <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
 <CAMuHMdUF1Csi1ZMccOj=kurijMLcA6G+TP_spsE+fnMvZR71Vw@mail.gmail.com>
 <de92e3bd-70e8-fcba-3c88-c04170704e7b@collabora.com>
 <CACRpkdb-Dv614V7STLRMpiLkmb_7NVyKnh2oUi=7Rx366tmZ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G3juXO9GfR42w+sw"
Content-Disposition: inline
In-Reply-To: <CACRpkdb-Dv614V7STLRMpiLkmb_7NVyKnh2oUi=7Rx366tmZ-A@mail.gmail.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--G3juXO9GfR42w+sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2019 at 10:45:13AM +0200, Linus Walleij wrote:
> On Tue, May 28, 2019 at 10:36 AM Guillaume Tucker

> > Not really, so I've disabled bisections in the linux-gpio tree
> > and a few other maintainers' trees for now.  I'll see if we can
> > come up with a more systematic way of suppressing bisections in
> > similar cases (i.e. the issue has been fixed in mainline later
> > than the base commit for the branch being tested).

> I think this is what the zeroday autobuilder does because
> they never seem to show this problem. Thanks for looking
> into it!

I've got a feeling they do this by deduping after doing the bisection;
they also used to have a system where they'd merge a bunch of trees
together and do the bisect on that to save repeating bisects.

--G3juXO9GfR42w+sw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlztNFQACgkQJNaLcl1U
h9CnRwf/ee3CvNVsnpAeOOZn7++IRM1ltd0gFGJR8JS1aeptgeYX4Iy+LiyjV8CO
ocs2H9W1CPO8oNd45rV709U1T5MzUpy8dPN306+3dPtB+etG8MXvBGSfoSx3oX0t
wCZJaDgS/eakIS3nyhwsm4kYrFbOmG8hEjN22pcXugB6++1JPKXDQEC6bVxdJUVo
meiYp9AR6PrYDDALwLSw+Hr5PJxOchP/x0azRWqDQ8xqICHaNkhYo2kV1uTF2nBg
Y83I4nrNv4JOj+BSH+52Bys+uA8lT2daypGmuX3LVB/mILWA22w9R4uogPNk5uEg
hcNuHlAgis5PMVLlC8S8D6U3j4wUIw==
=/CjW
-----END PGP SIGNATURE-----

--G3juXO9GfR42w+sw--
