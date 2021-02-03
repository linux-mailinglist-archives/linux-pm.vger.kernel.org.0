Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0930D5A7
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 09:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhBCIzq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 03:55:46 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:60535 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233001AbhBCIzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 03:55:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 73FAF7EC;
        Wed,  3 Feb 2021 03:54:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Feb 2021 03:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=GaOLsyDn+K9t8Cmz3jhQ2iNqP2j
        HmQT4/mycnVeQRqg=; b=mgFuVZJE93uHPKSj61GuzGt4ANRzWWeMaeLQOkqzUhl
        +s2crr4ey2bHX1EdFQkQe8COHz3isCJglC9GrOmScYvozYhU+nZBu5JvJnznzLMF
        wtdBz5txM1qGa8NQWCf2OTTHQYMEft8jX/uCNgIOiFDSNXfPJ5NssTG0Tenav0MU
        Boi5OqXzh2PZrobyFMNIS8cI+dnX/dEGcnvGDj2o8V1DE32uxY0J0eke2x9V2COR
        k8ZEflNz2JivX6nKZTwfyCuf06EeJ5lZvLqDnX4n0+02N7+0RQ5c8oCGeNUPtFwJ
        RLe8tVz+PdPpOp7RFugpN5QMG7Z6hbD4IapzD8PAj+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=GaOLsy
        Dn+K9t8Cmz3jhQ2iNqP2jHmQT4/mycnVeQRqg=; b=V8S9lzqykEqQdNrk+fUE3D
        8ZyRgSzxeyu4wDt2UhPn31WPyEuHi8zqxqXjHZF+CngILjcnda34f8EZ0DvIHoLn
        gYplq67zIH4HRptquAkqIctfsVqEJmJRYdwEprlc5/c2AjBIfB+y4wKthYlL0U/F
        v5qIA3GZSiWjyEcowyoWfOBTE6CuOjfrbi2Hblko7A2HSEg5VOAUasIc3l2107Fb
        utj8v+hj5Dh+/eRIC7k8wfglkRklU7DezStVsaqaXFPfHjRdMLRlYTS/rWQurgMj
        WMnPRuhsv+EkfBHod6OyVegq5pUJ49QHCJsT1ShCWLniMj3IXoy4mEJwod91Hfaw
        ==
X-ME-Sender: <xms:y2QaYNuVwRXCbUP8B_-oVw1vXQeoviuJzeKvtesSPsAX6kPh7Z6zFg>
    <xme:y2QaYGes6Yf2hdUw91rn5RlGqTBfnk3ROgFAfYDuV_tebLF5ckXII4KKB61p2ShvO
    CqZtoAKBEZRVAPKw6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zGQaYAxKtwfeEBuREydjmikFi1JldJAYQLXfe6Gbm4PCLIq7G328Uw>
    <xmx:zGQaYEO7hOUy7LcZ03L3D0pkcDICfmw9HNNB0N3GZdHMzL48A3HO-Q>
    <xmx:zGQaYN-xyfEnKOK8Sk21yQjGrq7i1m7bD04VmcedojckcZiCHjIooA>
    <xmx:zWQaYJTNPKlb7_nHGO8qV24jIrJn_YeYLT-15CZrHZrJVjw9QQnfE6v1vg4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB09024005A;
        Wed,  3 Feb 2021 03:54:35 -0500 (EST)
Date:   Wed, 3 Feb 2021 09:54:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: sun8i: Fix misplaced schema
 keyword in compatible strings
Message-ID: <20210203085434.pbbefshqhhbglqz6@gilmour>
References: <20210202181538.3936235-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nnfikiw6pmkhcc66"
Content-Disposition: inline
In-Reply-To: <20210202181538.3936235-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nnfikiw6pmkhcc66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 12:15:38PM -0600, Rob Herring wrote:
> A compatible string 'enum' mistakenly has 'const: ' in the compatible
> strings. Remove these.
>=20
> Fixes: 0b28594d67a8 ("dt-bindings: thermal: Add YAML schema for sun8i-the=
rmal driver bindings")
> Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--nnfikiw6pmkhcc66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBpkygAKCRDj7w1vZxhR
xU7JAQDuw/6tE0iP0CW3MelQJEwaxJ7DWKlM2Cle0Hdwvm3cEQEA4DBO+XcqrZD/
KLlCf7KWMOpSK5M1foiS5bJj42ph1A8=
=VC9f
-----END PGP SIGNATURE-----

--nnfikiw6pmkhcc66--
