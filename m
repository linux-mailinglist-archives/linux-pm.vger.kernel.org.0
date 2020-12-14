Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651132D95C3
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404657AbgLNKEE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 05:04:04 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42269 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727860AbgLNKDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 05:03:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DFBEF5C00D4;
        Mon, 14 Dec 2020 05:02:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 05:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=+6hgTtQ1G+/Xs+uY2Rz4ZOY80qy
        9K3UxTBdA7H+vn28=; b=CcqlFTVPOnNe62eURGM4fCToiXOO2wrP1dDG9DklIc3
        hyzq42vRJEEFSBAL9X3cC7qtxi1KZ2OvL4GPypA64Sp4rETkYO5cfuuPlTKnpkwX
        L4ysEXNqyJlxyGFi+LZCBoRIBS/XBFTK8DMZB8muBgS4drynUWWvgbrgsrqmuYOG
        bk+aQX5bJ5cbtUD9xLg7NMDYNIjJ3jlYPQzRD/sNrip1+w34Wfpnzm6jrmk9kMQr
        0kpzd5FY+I1bU0sfAf7yGFY3TOX22WqfYciVpXBD83C/HFl2aoqtlQD0briraaA6
        N9/sU6ZMisciHrJ/jdSoIJOI24kkL1AZCdLrcsBCwiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+6hgTt
        Q1G+/Xs+uY2Rz4ZOY80qy9K3UxTBdA7H+vn28=; b=fS9mJFOt4vb88c+X4p/TP5
        osr6tMtwZZvrcE6MpoY2Sqp/bU8TEf4wJA9Cmuly0785wj0ALRmT+o0RnRDda5uX
        BGHqP/SNRYGQ7Pw5PGLnhJso4nQI7Qp5em7kOYS+dQCYK/4Yury/i91RntMuZXdX
        yb3ndcHoN9uRzhewMIb8QGGDJjcTz9xi/RwVm1QoTPWNkO77i/Ri0a4F+F8QUnfA
        GqyKs9xL93HQg2rVg0G7vZ1QousAMxvGukX4SG/yth9xcGYdnrux1Zy8ddKcqRcI
        x/AHXzqaScYs/QXLQ5TvyjkO5DPCcJh00vMKozieg7mSzZn/TdnUxJvEOLjcL/4A
        ==
X-ME-Sender: <xms:NTjXX7Y1l3xs4F-7LYLv8n4aekMEd4HQBIfrC0jQdyDN68E1vnkRUw>
    <xme:NTjXX6Z-YYbAk34jIPISUJdBqBgJ3J4JDChrVforw7e9y01B7kzB4s4hTuUKo1ZxZ
    0fKmakgY9AqM6e-ReQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:NTjXX99otHuqzcKW6_LyoJ8lw2EUevzSMBge5q0teNkogFTHY0VZpA>
    <xmx:NTjXXxptgBaLgW9TMxYtog03oN9Iu_B8KvKEFe69_B7rp8xzZeOS9A>
    <xmx:NTjXX2qU71IpbxnJ_upfEZfw3W5YNVeFz70a3-v9mGQF919aZPXshg>
    <xmx:NTjXX3d0tRIoFOEY6zFQ1VTgPUmYxPVH_1FSYeInNUm423VTrh8xKw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E85424005B;
        Mon, 14 Dec 2020 05:02:29 -0500 (EST)
Date:   Mon, 14 Dec 2020 11:02:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 poweroff node
Message-ID: <20201214100228.ywal5v5xyzw25hmw@gilmour>
References: <20201211151445.115943-1-michael@fossekall.de>
 <20201211151445.115943-4-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f4xdeddqbje4hsbx"
Content-Disposition: inline
In-Reply-To: <20201211151445.115943-4-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--f4xdeddqbje4hsbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 04:14:45PM +0100, Michael Klein wrote:
> Add add devicetree information for the regulator-poweroff driver.
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>

Queued for 5.12, thanks!
Maxime

--f4xdeddqbje4hsbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9c4NAAKCRDj7w1vZxhR
xSxwAP9WB0bbihmJWLWLOsFNtIXErh+AjrGYdeFdrnuWmXgFzwD+OnDMyEmnjmJm
cTuMw4B4s3aogPo23zUqUxvw8wgt9Ak=
=o2H6
-----END PGP SIGNATURE-----

--f4xdeddqbje4hsbx--
