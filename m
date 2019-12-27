Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1064212B5A9
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 16:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfL0Pfy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 10:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0Pfy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Dec 2019 10:35:54 -0500
Received: from localhost (lfbn-lyo-1-633-204.w90-119.abo.wanadoo.fr [90.119.206.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FAC720740;
        Fri, 27 Dec 2019 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577460953;
        bh=7r56deXllU1oGrb23gXCZ4pIfhEB/Z0xwJCja1MXEL4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ycFG5d8GqzOqg09g3YY78naztjMaftPaJseNHozA9qOdVLhpzmJayZr5yMvzdQGkD
         FJ+zXXFFgeMuKtTlgCxENE2LDnqVqslEdmYK4XG+W2l9PBwhuZ8jkoTlR8vKV0K8ZU
         MRjVrRKwrch2A7BuGUTX+BaXagKluHzmx+7UyZA8=
Date:   Fri, 27 Dec 2019 16:37:15 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20191227153715.m7o6h6lniwg2456h@hendrix.home>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <20191219173321.bni4tbrhfkkphv7k@gilmour.lan>
 <4015380d-33ef-312c-a886-6e8bf65c976a@linaro.org>
 <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
 <20191226103739.bz3i73gjmn5q5veu@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gfd3qq7a2xnbetqt"
Content-Disposition: inline
In-Reply-To: <20191226103739.bz3i73gjmn5q5veu@core.my.home>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gfd3qq7a2xnbetqt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2019 at 11:37:39AM +0100, Ond=C5=99ej Jirman wrote:
> On Thu, Dec 26, 2019 at 10:27:51AM +0100, Maxime Ripard wrote:
> > On Tue, Dec 24, 2019 at 07:30:55PM +0100, Daniel Lezcano wrote:
> > > On 19/12/2019 18:33, Maxime Ripard wrote:
> > > > Hi,
> > > >
> > > > On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> > > >> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> > > >> H6 and R40 SoCs.
> > > >
> > > > Thanks again for working on this.
> > > >
> > > > I'll merge the DT patches when the driver will have been merged.
> > >
> > > I've applied patches 1 & 2.
> > >
> > > They are in the testing branch and will go to the linux-next branch as
> > > soon as the kernelci passes.
> >
> > I just merged all the other patches (except the patch 6, for the H6,
> > as requested by Vasily on IRC).
>
> Hello,
>
> I think you can apply H6 patch. This was just some misunderstanding
> and H6 is working.

Done, thanks!
Maxime

--gfd3qq7a2xnbetqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXgYlKwAKCRDj7w1vZxhR
xQkMAQC/ZoYUxPX5yzTlvbMxIWHNJ1u1lQvxfppZLauJ5rHWxgD8Cx+nXvhe72Cl
ka9ZcT3Up4uJM95blHhx4KnSXMipwgQ=
=Fewg
-----END PGP SIGNATURE-----

--gfd3qq7a2xnbetqt--
