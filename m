Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DBDED3C0
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfKCP7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 10:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfKCP7F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 Nov 2019 10:59:05 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FA920578;
        Sun,  3 Nov 2019 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572796744;
        bh=STPgCcvb19pfRf+vnfbC1wTtiEh0IBWfIryoTNEJMEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWHerJGBCwtOqQStSNzF3VL2JaGGK3XHgLAfZDlqRHGVbSHM0qWqvmIZ2JO8gIlyQ
         iHIR2oY9pr5KRvDKjNBx3SjgjbhL+vrRCscsJa17npYGIOwVYksL1rkf27GNCjQRUI
         eq9YtHm10ACDH+EykS5F4Je1V8NqYfScJwHW9WFo=
Date:   Sun, 3 Nov 2019 16:59:01 +0100
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
Subject: Re: [PATCH v2] cpufreq: sun50i: Fix CPU speed bin detection
Message-ID: <20191103155901.GC7001@gilmour>
References: <20191101164152.445067-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20191101164152.445067-1-megous@megous.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2019 at 05:41:51PM +0100, Ondrej Jirman wrote:
> I have observed failures to boot on Orange Pi 3, because this driver
> determined that my SoC is from the normal bin, but my SoC only works
> reliably with the OPP values for the slowest bin.
>
> By querying H6 owners, it was found that e-fuse values found in the wild
> are in the range of 1-3, value of 7 was not reported, yet. From this and
> from unused defines in BSP code, it can be assumed that meaning of efuse
> values on H6 actually is:
>
> - 1 = slowest bin
> - 2 = normal bin
> - 3 = fastest bin
>
> Vendor code actually treats 0 and 2 as invalid efuse values, but later
> treats all invalid values as a normal bin. This looks like a mistake in
> bin detection code, that was plastered over by a hack in cpufreq code,
> so let's not repeat it here. It probably only works because there are no
> SoCs in the wild with efuse value of 0, and fast bin SoCs are made to
> use normal bin OPP tables, which is also safe.
>
> Let's play it safe and interpret 0 as the slowest bin, but fix detection
> of other bins to match this research. More research will be done before
> actual OPP tables are merged.
>
> Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXb75RQAKCRDj7w1vZxhR
xWJzAQDSTsPAfe3tzFoFc8OXfLqCONSQW6Y7iTt9VnVtov6sNwEAuBQWjBl3soHJ
5L0MFRa27tIkr2hh5oVbQSGj6vO5rAw=
=0Y7o
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
