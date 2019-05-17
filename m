Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE2214B7
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfEQHoA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 03:44:00 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40767 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfEQHn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 03:43:59 -0400
X-Originating-IP: 80.215.154.25
Received: from localhost (unknown [80.215.154.25])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 37CA020009;
        Fri, 17 May 2019 07:43:51 +0000 (UTC)
Date:   Fri, 17 May 2019 09:43:50 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] add thermal driver for h6
Message-ID: <20190517074350.m4wtxn5rgiqkjgnz@flea>
References: <20190516172633.12607-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uiqnaa7feozmkfnb"
Content-Disposition: inline
In-Reply-To: <20190516172633.12607-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uiqnaa7feozmkfnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, May 16, 2019 at 01:26:31PM -0400, Yangtao Li wrote:
> This patchset supprt H6 thermal controller.

The discussion is still ongoing on the v1, it would have been better
to wait a bit on it to settle before sending a new version.

Anyway, some comment made there still apply.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--uiqnaa7feozmkfnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN5mNgAKCRDj7w1vZxhR
xdGaAQDw2HatyDwe99md5xjAb+SPPeYer/Zb4obBMYGlhQuO9AEAkn/HI2qNYsxw
/7OQTPnikOxNibnfTB1JZq1yrq3HeAs=
=fhoH
-----END PGP SIGNATURE-----

--uiqnaa7feozmkfnb--
