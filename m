Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2710C463
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 08:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfK1HmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 02:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfK1HmV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Nov 2019 02:42:21 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607442154A;
        Thu, 28 Nov 2019 07:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574926940;
        bh=j0Tz96Fkl28s6zX+DlYzNGtrex6eFQbYospBRTigaKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qi6fI/4PWQ2IEoHYlgo1pPyMok3HEHinsu6q5lLtbK/TaSl4hKDZOwg4iadRNEZO
         XTAVgHapTKp9dmOOVsGC2P/MUuxpot1Zo7v07gxQnLg8wDcHSGeru3xENxgCntlo2j
         RhCp+WavYVqGTBzXjhvxdgZaAoSD/Cy8nYmzZbBs=
Date:   Thu, 28 Nov 2019 08:42:18 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Frank Lee <tiny.windzz@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/7] thermal: sun8i: add thermal driver for
 H6/H5/H3/A64/A83T/R40
Message-ID: <20191128074218.6ctvumauyyerujqe@gilmour.lan>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
 <20191127052935.1719897-2-anarsoul@gmail.com>
 <20191127111419.z5hfu5soxceiivg6@core.my.home>
 <20191127173547.ch3pcv3lxgdcrfnu@gilmour.lan>
 <CAEExFWvG-Af4qtUrxQV4ssNQCVQAmpXfxB+92wX+6ZxUNfX-Jw@mail.gmail.com>
 <CA+E=qVcdwQO3Y8ismmBN-gRVNMs1Thx+TPLqstKM9fYf2_0qFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4x5ug6mtkmdsnllw"
Content-Disposition: inline
In-Reply-To: <CA+E=qVcdwQO3Y8ismmBN-gRVNMs1Thx+TPLqstKM9fYf2_0qFQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4x5ug6mtkmdsnllw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2019 at 11:48:32AM -0800, Vasily Khoruzhick wrote:
> On Wed, Nov 27, 2019 at 11:44 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > Hello Vasily,
> >
> > Thank you very much for your work on this.
> > This looks good to me.
>
> Thanks!
>
> > By the way, I would like to ask comments about adding the following code.
>
> Can we add it as follow up patch? I don't think that I have a device
> with working suspend to test it and I'm hesitant to add any code that
> I can't test.

Yeah, this should be a followup patch, otherwise this will never get
merged.

Maxime

--4x5ug6mtkmdsnllw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXd96UwAKCRDj7w1vZxhR
xWArAP9j8E1Vrf+8eJ4RgagjWjZ1+t05fXcWABrdX7WGAt2zgAEAoM/FkxgwTVNQ
+PjXhrnAxqUcH3tDMorB60UQ+gYj2wo=
=/Deg
-----END PGP SIGNATURE-----

--4x5ug6mtkmdsnllw--
