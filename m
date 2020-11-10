Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662732AD2E7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 10:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgKJJze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 04:55:34 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59477 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgKJJze (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 04:55:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 36AFD5C022C;
        Tue, 10 Nov 2020 04:55:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Nov 2020 04:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=pHiBX4Kik4d9Y0A9fn/Izssf5DO
        CvwXScDBk9KIrtXE=; b=NUqcrtsLGfV3SKVznwvfbUZgzyW+Q+hImDS50AS2t5y
        ctrS2poIeQtqpBweVbXYRQzYN9ARWeexJ0DV22IrTr9ypQcGtdWUfF+jzxna+9Ss
        m0YuA+/rmFbr3o+f3njmVZSzQZYf1Lzj/dQiXTKU29rpvgibr+597vi39HTpJzj/
        i4/DiBAXK3IYk3e2gBcBolJMg55+ezu7juQGJPjYFb2oxK9IOtX+N0VL66ETFz8T
        jRYXWWAUFrLlhcnPg00xm3rvgsZrFbsdRzu/BOAqFkYT0lrHAX1jIBXAFxFG0A0g
        ufwIT9t/BUedvLiByRU6b6O38dd0bF26dXwDZ/Jh09w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pHiBX4
        Kik4d9Y0A9fn/Izssf5DOCvwXScDBk9KIrtXE=; b=OIMT2B3boyg+gr4nleWgG6
        2gDZyYA0nwBzFKXpLYRGt7Oi9RQGUqBrQJ6nhUO00nXx16noTN2jQkeo97zyfFRb
        vtpqykJvyzW+yD+/YhYB0//wSk/W2df2vwI4MVOvhD/IuHWHqdMuFoaRMMmWM/PL
        hKWrOJT1q+8r0MIA11lF/UmGE1Ps7m7zUndrL5YxZlEAEjeS9zLNlYDzzoH/PuEv
        ks2MgjBAusBpdz8SZvy++eMZFiJlooSBiPyJ6ahqvyfBnLDLEX5LnBcaNY9Ic/CI
        pmW0urKiWvdFwqEkLEX1hxlnYAiwLh2QoCiMoKKHO/Nm7WxQM4a17fpkROlHjINQ
        ==
X-ME-Sender: <xms:lGOqX4xaE0JjflLgFyAJIvFd6NtFmUgUlBw1aGtp2pWkO4gp4uPEgA>
    <xme:lGOqX8Rxna5_43uYuzW6OBi6ZOA4VhIxBlJqV0fcmJFxCJ2zZGyA_EEDLFe9BcUbe
    tFwBCqO7neQ8lUoFNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lGOqX6XgT529fWl_NkwBRHiuS9cEaQps5DsCaY_k7zfSrGz1mm3Eaw>
    <xmx:lGOqX2hQ1jHRpI91e1Cjoelv-5eYUhTLACCyLC0kTIi1lDCZEKJbVw>
    <xmx:lGOqX6BwoVADx34YvYVxBUrCfUuVWHixofDkxNWVf6ghJbLTW2xqIw>
    <xmx:lWOqXwD1FpD-nnDGtqEnvxIu4-6wWXc0AXITiaj7AVOQLV4Qj0jVQQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EDD243280060;
        Tue, 10 Nov 2020 04:55:31 -0500 (EST)
Date:   Tue, 10 Nov 2020 10:55:29 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, wens@csie.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: sun8i: Use bitmap API instead of open code
Message-ID: <20201110095529.4cytycdnmot5nrqa@gilmour.lan>
References: <20201109114624.23035-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3iveov6p2mot6krw"
Content-Disposition: inline
In-Reply-To: <20201109114624.23035-1-frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3iveov6p2mot6krw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 07:46:24PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> The bitmap_* API is the standard way to access data in the bitfield.
> So convert irq_ack to return an unsigned long, and make things to use
> bitmap API.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--3iveov6p2mot6krw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6pjkQAKCRDj7w1vZxhR
xbwQAQDv52GWPWVj92U0PmN1VvHzhNVme4nMj7siFLiUAK0JeQEAm52+AOn/eXCj
2qNqQuk9zHkqj5g0nzIvGtSrrROgYgQ=
=BUnU
-----END PGP SIGNATURE-----

--3iveov6p2mot6krw--
