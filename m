Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206FE12AB3F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 10:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfLZJ0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 04:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfLZJ0c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Dec 2019 04:26:32 -0500
Received: from localhost (lfbn-lyo-1-633-204.w90-119.abo.wanadoo.fr [90.119.206.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C6E20882;
        Thu, 26 Dec 2019 09:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577352391;
        bh=CkarfyCauXn8wfEDBs9qybSmPYfMeIjIMe3oVYoPHVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaOnm7esK2ROl3hesRkx1Q9V+CUBQ9D7tRemrBSlQGoakMaVb7IYQ9996xNiLvtd7
         Kcq+cqu892ies3iBcFxDtBxMcKAQG7yNJn4jqHFs/eRo71GLMzscQGHCuAOerG6MeC
         YkoRtkj5QT259JCKnYIMP/nBijTXHD4uwXgsn+iw=
Date:   Thu, 26 Dec 2019 10:27:51 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/7] add thermal sensor driver for A64, A83T, H3, H5,
 H6, R40
Message-ID: <20191226092751.dc3boaxsaeivuhw4@hendrix.home>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <20191219173321.bni4tbrhfkkphv7k@gilmour.lan>
 <4015380d-33ef-312c-a886-6e8bf65c976a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rog6f2soycavkabo"
Content-Disposition: inline
In-Reply-To: <4015380d-33ef-312c-a886-6e8bf65c976a@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rog6f2soycavkabo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 24, 2019 at 07:30:55PM +0100, Daniel Lezcano wrote:
> On 19/12/2019 18:33, Maxime Ripard wrote:
> > Hi,
> >
> > On Thu, Dec 19, 2019 at 09:28:16AM -0800, Vasily Khoruzhick wrote:
> >> This patchset adds driver for thermal sensor in A64, A83T, H3, H5,
> >> H6 and R40 SoCs.
> >
> > Thanks again for working on this.
> >
> > I'll merge the DT patches when the driver will have been merged.
>
> I've applied patches 1 & 2.
>
> They are in the testing branch and will go to the linux-next branch as
> soon as the kernelci passes.

I just merged all the other patches (except the patch 6, for the H6,
as requested by Vasily on IRC).

Thanks to everyone involved!
Maxime

--rog6f2soycavkabo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXgR9FwAKCRDj7w1vZxhR
xbdXAPsGHYwewHWWZwWJLF/9xp5VSraGYyM5zFe9REMEM+rRYwD/VjwfBOp0ldc4
8dHM5uzYOaKYBLrqF1yORYBeEDtCYQw=
=MvoE
-----END PGP SIGNATURE-----

--rog6f2soycavkabo--
