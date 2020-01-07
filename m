Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CBA1320C7
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 08:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgAGH6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 02:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgAGH6U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 02:58:20 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C7D1206DB;
        Tue,  7 Jan 2020 07:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578383899;
        bh=BrMst+617zI2r0EV/C2/idlDkHdiIWRQ7d0v8t0JnTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMWhpUTRkILxE437ZjGrHk0iYhEMN41iXnqwZp3LRy4DayzOebYwBTEqLp551LhM7
         HJZOEbAXzZJ86KBFe7Bi6F7bhUZBRC06QEGk4cY6eW3R8TF9FfD5YgG2bXrxu5Bzne
         nNh3jRXpJdGdQpZNedC6HyDRi76Phbhr8F4XFouY=
Date:   Tue, 7 Jan 2020 08:58:16 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        anarsoul@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, megous@megous.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: sun8i-r40: Add thermal sensor and
 thermal zones
Message-ID: <20200107075816.ly6exfd4qtvfxxua@gilmour.lan>
References: <20200106174639.20862-1-tiny.windzz@gmail.com>
 <20200106174639.20862-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5t4fa76ybjlyh7kw"
Content-Disposition: inline
In-Reply-To: <20200106174639.20862-2-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5t4fa76ybjlyh7kw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 05:46:39PM +0000, Yangtao Li wrote:
> There are two sensors, sensor0 for CPU, sensor1 for GPU.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Tested-on: sun8i-r40-bananapi-m2-ultra

As far as I know, tested-on is not documented anywhere (and isn't
really used either). I've removed it and applied, thanks!

Maxime

--5t4fa76ybjlyh7kw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhQ6GAAKCRDj7w1vZxhR
xbGQAP9yQNlWUHCxeJLJY+QLchOERPxO2NAHR5SR2rfghslKJgD+IvXRJyi8oysC
I7xj6LiyyRFoZJuhQtVur1R+BTN6MwA=
=Upf1
-----END PGP SIGNATURE-----

--5t4fa76ybjlyh7kw--
