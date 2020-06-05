Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2621EF52F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 12:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgFEKUW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 06:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgFEKUV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jun 2020 06:20:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC01206A2;
        Fri,  5 Jun 2020 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591352420;
        bh=0Lc6LV1qscUeMNvN13MORO4Kv4mAyEfjM/eifugNtFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1SZirs580058Yb5bxxi3nJl7rNYeahVvgVpSXuzblma3gX4fn0wVFptYysjT0c2f
         3eMs4Fo8k8i9mYI4rV4s8I2ymtCjfa9qPuBGHXGbq3ZoICdJAApmGwljY4x5jR4sWy
         iECn4Q0jATRDn3ibmRvew7qUCYa7+gmF8vWaolVg=
Date:   Fri, 5 Jun 2020 11:20:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] regulator: do not balance 'boot-on' coupled regulators
 without constraints
Message-ID: <20200605102018.GA5413@sirena.org.uk>
References: <CGME20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6@eucas1p2.samsung.com>
 <20200605063724.9030-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20200605063724.9030-1-m.szyprowski@samsung.com>
X-Cookie: Air is water with holes in it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 08:37:24AM +0200, Marek Szyprowski wrote:

> Balancing of the 'boot-on' coupled regulators must wait until the clients
> set their constraints, otherwise the balancing code might change the

No, this is not what boot-on means at all.  It is there for cases where
we can't read the enable status from the hardware.  Trying to infer
*anything* about the runtime behaviour from it being present or absent
is very badly broken.

Saravana (CCed) was working on some patches which tried to deal with
some stuff around this for enables using the sync_state() callback.
Unfortunately there's quite a few problems with the current approach
(the biggest one from my point of view being that it's implemented so
that it requires every single consumer of every device on the PMIC to
come up but there's others at more of an implementation level).

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aHGEACgkQJNaLcl1U
h9BpIAf/buuk5QSHSM+OJ3DcfZlFFgTR5AHmHfgy3qRK3tKYJpoam0zxq52MR8uj
G9uLVi/6d2ZhnWOPxO1es+6UqilwyeoXNB3e7SLrjjXAahAzqLBfb+67N3dW/+Ur
th8CghZ79LKGJtoPYFfRdrF3lKQhnyRORbkkVewJa1suMR+HdN8GeS5bI1RVeI9D
Kasg0AZ06GEvn1sNFbT9H8B93xJ0MKJnvRmZPcorUQaWPPzzGqQEsuYfjQ+5rj8K
H9gn9mU9v7Fqn5iGaOtzCKYUc15GOIIx2VxTGb4ogTvNJ7B0HJ9BnqRD5ZTWeGSt
fgLY83QgpD/CzcRDtXCj+PmvSBD2Dg==
=exUj
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
