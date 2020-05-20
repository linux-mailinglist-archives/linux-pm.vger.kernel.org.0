Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE13F1DB338
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETMbi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 08:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETMbi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 08:31:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191D320756;
        Wed, 20 May 2020 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589977897;
        bh=rL8WkukpYlQE2FvyEL1Ca998vF4yjcYjdKtcskbOga4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoxEWlrzY++Y0BFWiabgMwjNGX/nvadbakyFaRZq89IjX/nhET64+AAldhU56uv4y
         /N2F8Ge6zCrPiaYs24N4AeJZ8C+ZXyDCJWLD1XynAuUuEF6n7NdU/UlXGv8qQP01VQ
         yNqJhM8BUg7QoFPleCnp2BaLZ0B5zDCzVNny15Vs=
Date:   Wed, 20 May 2020 13:31:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 09/12] devfreq: add mediatek cci devfreq
Message-ID: <20200520123135.GD4823@sirena.org.uk>
References: <20200520034307.20435-1-andrew-sh.cheng@mediatek.com>
 <20200520034307.20435-10-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20200520034307.20435-10-andrew-sh.cheng@mediatek.com>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2020 at 11:43:04AM +0800, Andrew-sh.Cheng wrote:

> +	cci_df->proc_reg = devm_regulator_get_optional(cci_dev, "proc");
> +	ret = PTR_ERR_OR_ZERO(cci_df->proc_reg);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cci_dev, "failed to get regulator for CCI: %d\n",
> +				ret);
> +		return ret;
> +	}
> +	ret = regulator_enable(cci_df->proc_reg);

The code appears to require a regulator (and I'm guessing the device
needs power) so why is this using regulator_get_optional()?

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7FIyYACgkQJNaLcl1U
h9D0kAf/f2yyGL/KhJ2Y+J/Xvk72EFz2UdjxlDjJo9wXYf3J4HWB9sgTXydoZoRj
bPlZzQtBeUPNmvX60Nczzt1V0KYNXns6mOfBOTueIAlSLeOnWBLV2+IUedCAVOJw
NX2i3pZdZ2p7yOO9QGU2s8hxc3uwCHKETMa5U/B6ENwkQkkOlJCNkjVYYiuoAJn+
9mIq1Ko2yfPHqJPyh/wP/CTC7AqXyPnQmO+rAlua+v8ua7RXRqAlkI/LpWhhpe1U
PAdhYsvKa9TiyafrrUPW1TPbTBRnWpHd1s2gjhpiGuuDhJyEaGjxsm0dz82gs5ml
aut3SlENmvhhRkfxSKh8LBYpjvJ0hA==
=vHQ8
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
