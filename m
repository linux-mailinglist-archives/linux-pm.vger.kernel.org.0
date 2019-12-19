Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1ACE12682D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLSRcn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfLSRcm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 12:32:42 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62FF221655;
        Thu, 19 Dec 2019 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576776761;
        bh=k50cd5B88xhBvXY5ZkbJXqjGZEzoE+Hb2bzMFriQpZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+pkf4mWOw9JhNDQ7HH184KSQ2rLXHpRDxLiDMXneBjcfNPsiqN9pwBDqncxUqp3y
         02V9/Hy5Xt7Ba71s2LypscPsGoMfVn7kl28ZVRnwLrByw9Peto+nA532n1Y8Fgg0hZ
         gS09GGMTJWITcGexVVTd9FY8vVCbldDv++OTw5tQ=
Date:   Thu, 19 Dec 2019 18:32:38 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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
Subject: Re: [PATCH v8 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
Message-ID: <20191219173238.zfcpfac46bs2gejk@gilmour.lan>
References: <20191219172823.1652600-1-anarsoul@gmail.com>
 <20191219172823.1652600-3-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qvpkkhg37mvl6gwe"
Content-Disposition: inline
In-Reply-To: <20191219172823.1652600-3-anarsoul@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qvpkkhg37mvl6gwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2019 at 09:28:18AM -0800, Vasily Khoruzhick wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
>
> sun8i-thermal driver supports thermal sensor in wide range of Allwinner
> SoCs. Add YAML schema for its bindings.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--qvpkkhg37mvl6gwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfu0NgAKCRDj7w1vZxhR
xTsHAP4pjKvGwYzFATi3ZRZ9Icy+5en/9wH9EXDxgCLFt/7Z2gD/WbLkhcAZQUIg
h4Q76OJzfvYCKvCdvc/BVGFPYmKwQwU=
=TiK5
-----END PGP SIGNATURE-----

--qvpkkhg37mvl6gwe--
