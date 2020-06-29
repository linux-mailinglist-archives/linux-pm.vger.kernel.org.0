Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353DF20E43F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbgF2VWq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:22:46 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56115 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729599AbgF2Sv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 14:51:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4180D5805B9;
        Mon, 29 Jun 2020 11:10:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Jun 2020 11:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Hxhkhq+OJaiV71iJYRzqwDQRWMP
        lO3tU/YNo9PNyFWw=; b=L59tg5R5bevKZc84RIvc0helt7vmNIAEH38i2QB1XMT
        b+bvaQ9CmUPwo3kdql/EBZ4VCtVV1QnqMvxyUjCYjpaz78RcMv8miXu7ORnmnUtv
        L8zfbg7fUydU40GNBkWUxnjPn8+kH4yHQAR8cVTkT1vJludnJdbQ+joYW6Z/HQE7
        GRXur2g4BN77wqZ7NtPGeTrDfR0UsZu2iklA51UfqC7ExQyQQO3W7pklcmbM41AI
        C6O1ics0CTGT6isbqj8aRbp4FP89ys+HTBTLbflQ/8vsMfFqC8l8aa6HY8I0yG04
        Bpxg0GWa1dhlrJpDwgz50rPVMaK46pxn+uV0AY55u2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Hxhkhq
        +OJaiV71iJYRzqwDQRWMPlO3tU/YNo9PNyFWw=; b=nAkF6yhg3rQUDL/mCU5jnu
        8UPqsE7wUfX7V3uGL3rr4mPX6whwDnfrRqwbh24M11e5HdpLUVb8T2dH094VSvp2
        PiiDhZUtiwg1OJD1h5nLNgo9w7AIJzT3e3f2apisRR3qMMFf1SB//vcluirG0ihq
        NwdD5/waaeKkQ3jSzNgXI9y4rCl7YjbyW4uE5oY6cFJ8iZ/w7FtHvPuR7hYU2NyV
        PNz3+f9Basv2n0Hz59i3hc1U5SUH1zmRSiqOlu30OMILDXwQa9XLniGmywJ6vIUD
        4HL6TOGVX3TVMVnZylKUIobz1RiIMNe8AyzAgOoT+4pRuFban4XMPP/PeHh/Viyg
        ==
X-ME-Sender: <xms:XwT6XtGAgBPd66aW1ODh3bC86gKgq77_QlvHMJXeULQbYFpfTpJQBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudelledgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XwT6XiW7FAivTiFvb3h20qdKxf2QJtljVBlnkl1xOne5QCs7GPWNNQ>
    <xmx:XwT6XvJEc6Tom1XR59v0Yx4tYDbAjWTn_qMDNvGm9abYFecs3V3diw>
    <xmx:XwT6XjEzAUUf3suWBkgCWhg5zVSj3jT6oCAiLOU8dS6hMBt8lAGlHg>
    <xmx:YgT6XpFXQ5Vpr9ZxMb2KKD5heeJbV2_CcxnA0X1o3-1TUcPoUWmNFw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B04F3067CA9;
        Mon, 29 Jun 2020 11:10:23 -0400 (EDT)
Date:   Mon, 29 Jun 2020 17:10:22 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, srinivas.kandagatla@linaro.org,
        linus.walleij@linaro.org, anarsoul@gmail.com,
        tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        p.zabel@pengutronix.de, clabbe@baylibre.com, icenowy@aosc.io,
        megous@megous.com, karlp@tweak.net.au, bage@linutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com
Subject: Re: [PATCH v2 08/11] thermal: sun8i: Add A100's THS controller
 support
Message-ID: <20200629151022.e23hqixsx3b5vsxd@gilmour.lan>
References: <20200622025907.32574-1-frank@allwinnertech.com>
 <20200622025907.32574-9-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ylwydmatvahcimwd"
Content-Disposition: inline
In-Reply-To: <20200622025907.32574-9-frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ylwydmatvahcimwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 10:59:04AM +0800, Frank Lee wrote:
> This patch add thermal sensor controller support for A100,
> which is similar to the previous ones.
>=20
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

This SoB is weird. If Yangtao Li is the author, then they should be
credited, and if they're not then their SoB shouldn't be here
(especially in the latest position which is usually the person that
committed / sent the patch).

Either way, something is off here.

Maxime

--ylwydmatvahcimwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvoEXgAKCRDj7w1vZxhR
xTEIAP4vwQRHMN634gqK3ztUkKWqQlYv9RetPxwmfazpSwD72AD+MYVlV4xv3h5Z
Imn9dR7VTpA1168kL+XF4l5MfCZMEg0=
=IJGI
-----END PGP SIGNATURE-----

--ylwydmatvahcimwd--
