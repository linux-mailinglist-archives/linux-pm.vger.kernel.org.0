Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC5EC5DD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 16:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKAPtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 11:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfKAPtk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 11:49:40 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C625721734;
        Fri,  1 Nov 2019 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572623379;
        bh=wdIW0/QLcRnGZarqavMjg3f1Q6gO9y6P1i5x8XnrKC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chJsFqRrFQAkIuvN3HeWEC/ZgBqGFyB54Lohux3DUr9V3T7pnBow3Tn11j/JLpRD/
         Wndm4HzwQJtvJF9DPGrJnTaDkiSwbsEdo3IgooYz2kh/PXILxPniKykE3XC/kUKQux
         AcI32uRZ3U1IV1D52C0TtrTxa+gQaGz6FvqY87HA=
Date:   Fri, 1 Nov 2019 16:07:01 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: sun50i: Fix CPU speed bin detection
Message-ID: <20191101150701.fgke7hoad5zn3vn2@hendrix>
References: <20191031181359.282617-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cxmms35ejqeprbv6"
Content-Disposition: inline
In-Reply-To: <20191031181359.282617-1-megous@megous.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cxmms35ejqeprbv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2019 at 07:13:58PM +0100, Ondrej Jirman wrote:
> I have failures to boot on Orange Pi 3, because this driver determined
> that my SoC is from the normal bin, but my SoC only works reliably with
> the OPP values for the slowest bin.
>
> Looking at BSP code, I found that efuse values have following meanings
> on H6:
>
> - 0b000 invalid (interpreted in vendor's BSP as normal bin)
> - 0b001 slowest bin
> - 0b011 normal bin
> - 0b111 fastest bin
>
> Let's play it safe and interpret 0 as the slowest bin, but fix detection
> of other bins to match vendor code.
>
> Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Out of curiosity, which OPP table is being used? I guess it's one of
the dozens of patches sitting there...

Maxime

--cxmms35ejqeprbv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbxKFQAKCRDj7w1vZxhR
xfcRAQDCSZvITYVU4ONlpersX7CkPXMk47yfFv5qPasvorZbCAD8DOHH9GG8dEHE
Q0G94TyC+NiQEhK6W0kM+D5jpHiE0gg=
=Z6U9
-----END PGP SIGNATURE-----

--cxmms35ejqeprbv6--
