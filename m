Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E533CFD23
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhGTOcM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 10:32:12 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:39567 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233834AbhGTORl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 10:17:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id F02382B00098;
        Tue, 20 Jul 2021 10:46:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Jul 2021 10:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=JQ7dL4Jy0EGO6kUdYQlXq0cbld5
        RjOtqdlBNzkW45wE=; b=dpA3z5HuGcw6wPGwzRseO8UtRiM6C5u6hgaimt45bT4
        sLQ+4fcxt/7pfzueqgDy2yWC4jqHu7FR+ld0LGW3GILMzXhi3g/O2NTlPEJrupmb
        APf3Qb0ZqdQGa6MVGUljTiuD3wdQ0dnTIS8KBfpaVqg6XVFnuG6kRXD1ei5DsYpN
        48dUPzoK5Rgd8ruduI6syvQXNysi40tPL4knwGzjZKfU7hSVVhxAlpNxvG3YtNHj
        SRGVBUmVH8/dubF9I4O+clmvvIaaK027DfSc6Zd+SsJHlPjQIZxfRy/IqDS0WieN
        K9mXr8cu0ouer6rMVVtNv61TSMgvQ2c8cugpHsDCTHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JQ7dL4
        Jy0EGO6kUdYQlXq0cbld5RjOtqdlBNzkW45wE=; b=rWCcre49+pR5m+NUoZEwBf
        niuqZ3csoSTSvjA5+d0BEAqumf3S4p/ETDrgLYSZY0Di9PnWB2Mfyqxk3a/swn4Z
        KvTqnrcOJ6FigBytPWxLvQ2ycoabGJon7cT+pPOeNqcHk7QH8Bzh/2web5AVi8+X
        EzIb79BXjHZMnF3yksrYn7ukSlT8i4g1JJS+7IdMrFb1seMguqKylT72dw5IEvjx
        LGjymgYlth0POLxXETiSVpnTw6VQ5OFI70zYnqqGZ90GyAloGmdchFSchvFGOW2z
        AWdSdOm9OF8iqOSf6ge2NLpWW1yIMoaTfeZbTY4G0D5WAOK0W7oEoGjI/8LnjNUw
        ==
X-ME-Sender: <xms:wuH2YIivU5LAMih6k1LjCNYgNsfrYViBlF-Z98k3WOPei2pifpQLKA>
    <xme:wuH2YBAJrIZ90nYxhWA346SoPng9x5kO9fLBUxRcbEUkGg1ugV7L4G9EFgD6aqkZw
    1wpbYhQOJo-xOP-adY>
X-ME-Received: <xmr:wuH2YAGUhBk2XJR65Gcd9X2wm2W3GHM_7wyehV0rHp1Kbcf72-WNnw6MdewfyIMsOIlCe17YiaQp-MLbI34ARwZ78WEoJzFmoURA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wuH2YJRWO44t2gOP54wr2ZwYjuc9WQcBUebfC0pUGnbRf5JIbwPojg>
    <xmx:wuH2YFyZwEPj1pnAu4HRzH-_vwkm3vYZdBMi6PDVgwGkxsHzF6c8Qw>
    <xmx:wuH2YH6QgIymgXjbR1FN_mfKqX0viGfX-OZ8eiQEHzRHWDKmEqPVyw>
    <xmx:w-H2YL6-c6WsgqyjZ4JhIoPR3IlM_SvI78Ul2rTcD-NmS8vo_v0h1dk25fo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 10:46:26 -0400 (EDT)
Date:   Tue, 20 Jul 2021 16:46:24 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] dt-bindings: opp: Convert to DT schema
Message-ID: <20210720144624.aieivojs2a5tayhb@gilmour>
References: <20210720144121.66713-1-robh@kernel.org>
 <20210720144121.66713-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fhrdjgohnlbn6yyp"
Content-Disposition: inline
In-Reply-To: <20210720144121.66713-3-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fhrdjgohnlbn6yyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 2021 at 08:41:21AM -0600, Rob Herring wrote:
> Convert the OPP v1 and v2 bindings to DT schema format. As the OPPv2 bind=
ing
> can be extended by vendors, we need to split the common part out from the
> "operating-points-v2" conforming compatible.
>=20
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime@cerno.tech>

I spent some time a couple of weeks ago trying to figure it out, I'm
glad you ended up doing it :)

Thanks!

Maxime

--fhrdjgohnlbn6yyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYPbhwAAKCRDj7w1vZxhR
xQkDAPoDnHTLxRhV8i4mtobLgzhetkwTkMwDAg1c5YcpjoXXPwD+NlKUek5wdjdK
8P4B8eTnm8/IcbKMNmb1Y48nlptVIAE=
=DFjy
-----END PGP SIGNATURE-----

--fhrdjgohnlbn6yyp--
