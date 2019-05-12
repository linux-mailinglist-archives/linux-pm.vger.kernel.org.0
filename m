Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83C1AC60
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2019 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfELN0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 09:26:09 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39597 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfELN0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 09:26:09 -0400
X-Originating-IP: 109.190.253.16
Received: from localhost (unknown [109.190.253.16])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7E9D0FF803;
        Sun, 12 May 2019 13:26:00 +0000 (UTC)
Date:   Sun, 12 May 2019 15:25:58 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: defconfig: add allwinner sid support
Message-ID: <20190512132558.745wbonxn6qrwvke@flea>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbhyzlowgxdvkbq7"
Content-Disposition: inline
In-Reply-To: <20190512082614.9045-2-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lbhyzlowgxdvkbq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 12, 2019 at 04:26:12AM -0400, Yangtao Li wrote:
> Sid contains speedbin information and temperature sensor
> calibration information and more, which are important for SOC.
>
> This patch enables CONFIG_NVMEM_SUNXI_SID by default.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied for 5.3, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lbhyzlowgxdvkbq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNge5gAKCRDj7w1vZxhR
xeJXAP0WWHx9kGrJrvMvq9Mm+3L1Sd+z+4KFnlWWGuQScu8bXwD/d3EK/qKg46B+
ztgYKIXbsBFk0dYQ8tOvMmeB84JBkQw=
=kR0R
-----END PGP SIGNATURE-----

--lbhyzlowgxdvkbq7--
