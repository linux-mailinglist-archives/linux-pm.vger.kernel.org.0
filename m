Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7E620E438
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbgF2VWp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:22:45 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58681 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729596AbgF2Sv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 14:51:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 805C058035E;
        Mon, 29 Jun 2020 11:07:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jun 2020 11:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WE1PSDJ6UR5jIFS55riBxt9LPeJ
        Xh4U7NigTPnNX65A=; b=l8oEpc8ou0b31MaSG3xJyMa7ni1mk3WLjAf0+QKHhjs
        AVpZBfZIOMlIwpRfzUZ14GCy22hl/ny7wF6EPd/RmE10onf4Ip8tNfeqRwOPe/KF
        gPA9Mojv1xbR1GKjCgVa8zHPvuXzX/L9FcWYOtdSddgGtn8h1eG9jBxj75YJbHTK
        AANJop2cVs8dOOdN/3CdbzUDXLfYiXtQNsQYaSDjYw02qjx1HRJeF5WHzMmAyjXS
        3KhOuwB1qhHBpETNlNr2Wcj3pOWH0N/xGG6lycaJauSm7B8zbUUSEZMMBd+GhU53
        6JgTxPN4HoKR9TklVbYstBJUuXqO1J9mbgHbuVlFbiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WE1PSD
        J6UR5jIFS55riBxt9LPeJXh4U7NigTPnNX65A=; b=jvAnAfyGaqUn/08ZHsSqLO
        uW19B9zLVT4SoApSBBkRM437Kkyd5+RLGxYcTd9L/oNbS6MJbqab7VsM98DbsCWO
        4d+n8RBYK/BF0fHr9iBnrIaiiVmQvnFV3zkFgHUJ5uXQbG6usHTFF8bzNilFUc7u
        VHSM1KJiVUTLlVmNRTKoIFa+4KuOnlVlYMVDSkofqAXPutOIj/pnE21k7/gu3pBQ
        daqivTY5w3AmuBudK+2x1qoXFuOwCBazHChG9faFssJKqFPAI7ckWQyHm9tFFwxU
        pbbe+PLQsGexmH8opjSu/KNzsplx1vR5KknkeXSlJ597pWOeC+sjwaFee54Bzuew
        ==
X-ME-Sender: <xms:wwP6XqWvknOfJkcPQBXZIqW8UorMwaNBI5C1ODdyBwTlMY09xUHPxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudelledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wwP6XmkjVUmeiEdlJgUfigxWgJQVaqJmvthVxhwDQFDiMykoEnTrdA>
    <xmx:wwP6XubBPGGFyYHtXHWC-1pZWDOV_FPhqmC25ASqd2-PXgI2_RfGwg>
    <xmx:wwP6XhWf_nU3-9dDRfPGYtrX-iylRBw_6x4z_SVVOUOMQWduDd8qGA>
    <xmx:xgP6XmWAWQwhFI3MhZjhHXi92Prz-GT5C9njmChD_WUolvvNS1KtFw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E01A3280060;
        Mon, 29 Jun 2020 11:07:47 -0400 (EDT)
Date:   Mon, 29 Jun 2020 17:07:45 +0200
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
Subject: Re: [PATCH v2 06/11] nvmem: sunxi-sid: add support for A100's SID
 controller
Message-ID: <20200629150745.ettjdggv55gfxs5s@gilmour.lan>
References: <20200622025907.32574-1-frank@allwinnertech.com>
 <20200622025907.32574-7-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qt3qjbwfvcqzuc6s"
Content-Disposition: inline
In-Reply-To: <20200622025907.32574-7-frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qt3qjbwfvcqzuc6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 10:59:02AM +0800, Frank Lee wrote:
> Add support for A100's SID controller.
>=20
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  drivers/nvmem/sunxi_sid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index e26ef1b..8ac074b 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -189,6 +189,11 @@ static int sunxi_sid_probe(struct platform_device *p=
dev)
>  	.need_register_readout =3D true,
>  };
> =20
> +static const struct sunxi_sid_cfg sun50i_a100_cfg =3D {
> +	.value_offset =3D 0x200,
> +	.size =3D 0x100,
> +};
> +

It looks like it's the same tha nthe H3 / A64 then?

If so, you can just reuse their compatible as fallback

Maxime

--qt3qjbwfvcqzuc6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvoDwQAKCRDj7w1vZxhR
xR1+AQDUmJ2eKxkSAKY8N3oAYv2RkDrEZNTRivNZeW/rTDtt1gD/fIJbT8KdkTtN
Oq4B49fJoiJYQc72b1d+sdbscb9XAw4=
=7lp0
-----END PGP SIGNATURE-----

--qt3qjbwfvcqzuc6s--
