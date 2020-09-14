Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC5268B05
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 14:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgINMdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 08:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgINMc5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Sep 2020 08:32:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2636F20709;
        Mon, 14 Sep 2020 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600086771;
        bh=xFSDw8//5wJ8dFfNNw4BsdqTVRi7fxPIg8Of2LQJ/j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIBVPOh3DWEDLqP8H6eDP3hQf8byFbaCVkE4ZnVykam1Kjx1Z53p0OTqlrTbEgyCa
         Z3MDeth+eNr7mpjp0uDcV2ZEmoM3pmi3le9tA2h3wxoJJMcm5Q23rI3tx2KHEApyen
         KRZDFFGRpP7fNuCPUxWRlN7VrU80dJPk14bL8kxI=
Date:   Mon, 14 Sep 2020 13:32:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 14/17] dt-bindings: regulator: add DVFSRC regulator
 dt-bindings
Message-ID: <20200914123202.GD4821@sirena.org.uk>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
 <1600052684-21198-15-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <1600052684-21198-15-git-send-email-henryc.chen@mediatek.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2020 at 11:04:41AM +0800, Henry Chen wrote:

>  		clocks = <&infracfg CLK_INFRA_DVFSRC>;
>  		clock-names = "dvfsrc";
>  		#interconnect-cells = <1>;
> +		dvfsrc-regulator {
> +			compatible = "mediatek,mt8183-dvfsrc-regulator";

This device has only one possible parent, why does it need a compatible
string?

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9fYsIACgkQJNaLcl1U
h9CGAwf+NdDwxcGz6vK2nMoZx0OSox6fapvguwKcIXo6+F97ItlNsR1WVQBnDgnb
203sE6MD8JOg6WSkRP7PnGf1oZP6C5df/tB80kqV22bPc11sqWE1i2bqiM/LQwq+
wVLFlxVYsCHQbpq0HdRBPG0fSrzkDlE3ShgUMMD2hAn94apWUL5U1cVs9SuY3oRi
3fSngH9WbCL1X7o/whxg5Ogq38X0Z2xahcNz8G8MNRJoqazFTMRrFHvgpI8fKcsT
vQ6WyeukDlkXErJnCxbl47PAOdSmpuZ0z27L2NGlUPQEkzcH3FvGYRv6MEbwFr+N
GCwB3F0SHfonZ0Sd7JobMcHzFzPKnw==
=miPV
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
