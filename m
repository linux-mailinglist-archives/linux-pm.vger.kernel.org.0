Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1218920D2AC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 20:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgF2Sva (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 14:51:30 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:44623 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729333AbgF2Sv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 14:51:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 260DD5805B0;
        Mon, 29 Jun 2020 11:01:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Jun 2020 11:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sNYlobJ1pS1Ohf9R4+0abgm6IJT
        CYCd2l6ZmNPrPlSA=; b=DWMlBHcziyoD7n2VBoKBMQ/YxDyKWpVBlvyx6I0Mh63
        9N3BYcQcc0AXHNTyweL/38j0GtymQRJm/vEQIt0+ziKTYvGkfa456jewfOWYASdP
        jQiCa8q3bughoOLiDZFN6fYcTjU/poinnWr3fL+yeeDASlUK4Tr8glC3Xx9d8yNZ
        N92nANai38bPo9EBImtsSSEoElKxUTshUTkEmVNwQYKPLK94VGhppl7WLVessYkq
        9Hd8OjLDSxi3/Vz1FOKjl7MLMFg4g5sw3uZAnoraTTqEv7Mn4vczwQ3WJIgN8YCi
        Jbe+Hcf31HBgrmGrDLk3F6QlpBxeSRYcaRrkLMPrrqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sNYlob
        J1pS1Ohf9R4+0abgm6IJTCYCd2l6ZmNPrPlSA=; b=pm9xGVSBedaUZC8oTh1pIw
        BAJKleBBLVtKXvw2ZwfMWlr2Ht1mPO3POhWB4W+Ov7G3UOPsfew6wqB/hQIrwRBm
        DLf9TAupo0jFjX7rVSg/niGfVU19fDrPcCiKC5ORpz3RMW8EGzJz2T+RGhQW9uE6
        /PApegkh6ToIaBA7Mpq/HIVofzkT/bHpCcIW25Kkw7p1pSTFYptL0KC6WJp3Fxgf
        dflOU+XzFNIv5laQKx21gzjz7MHce1LmKaJlOym8MYdE9fGA1xvyucQVjv2pC2CQ
        m7qiqbbxp0dRfnT9DJTozlJot7vlwaBZoXwpjwvsxHt/jp2Xa/5dEfaXUp5RSDxA
        ==
X-ME-Sender: <xms:MwL6Xsj4Z9FZANkSVU2BdsHxlYDSvHYVhWy2MCECAneZHrUs6WoLcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudelledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MwL6XlC5HqPkQ1Qsk95QLIv424Hp8uj956i4iB1kuXfKnZLq9-ZB_Q>
    <xmx:MwL6XkEfszsWkaT_duTnZcLDtDklBuk0iDiCCdY7b5ArpyNn_VCReQ>
    <xmx:MwL6XtQgKMx5Bj1CM_uV4higUE98YYcjMRQvOVXszmAIikdbb2V3Cg>
    <xmx:NwL6XggX8VHAbnft1ZLigEObaHapWQkinOTPI8r1N7R4-gUZ3WQ7Yg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE1DE3067CA7;
        Mon, 29 Jun 2020 11:01:06 -0400 (EDT)
Date:   Mon, 29 Jun 2020 17:01:05 +0200
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
Subject: Re: [PATCH v2 03/11] dt-bindings: pinctrl: sunxi: Add A100 pinctrl
 bindings
Message-ID: <20200629150105.5yisonmm34qlk4jh@gilmour.lan>
References: <20200622025907.32574-1-frank@allwinnertech.com>
 <20200622025907.32574-4-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ksr2pme4uhjoiziv"
Content-Disposition: inline
In-Reply-To: <20200622025907.32574-4-frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ksr2pme4uhjoiziv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 22, 2020 at 10:58:59AM +0800, Frank Lee wrote:
> Add device tree binding Documentation details for A100 pinctrl driver,
> whic has an r pin controller and a pin controller with more irq lines.
>=20
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       | 72 +++++++++++++---=
------
>  1 file changed, 43 insertions(+), 29 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a1=
0-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-=
a10-pinctrl.yaml
> index bfefd09..2ac5eb5 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinct=
rl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinct=
rl.yaml
> @@ -48,6 +48,8 @@ properties:
>        - allwinner,sun9i-a80-r-pinctrl
>        - allwinner,sun50i-a64-pinctrl
>        - allwinner,sun50i-a64-r-pinctrl
> +      - allwinner,sun50i-a100-pinctrl
> +      - allwinner,sun50i-a100-r-pinctrl
>        - allwinner,sun50i-h5-pinctrl
>        - allwinner,sun50i-h6-pinctrl
>        - allwinner,sun50i-h6-r-pinctrl
> @@ -144,75 +146,87 @@ allOf:
>    # FIXME: We should have the pin bank supplies here, but not a lot of
>    # boards are defining it at the moment so it would generate a lot of
>    # warnings.
> -
>    - if:
>        properties:
>          compatible:
>            enum:
> -            - allwinner,sun9i-a80-pinctrl
> +            - allwinner,sun50i-a100-pinctrl
> =20
>      then:
>        properties:
>          interrupts:
> -          minItems: 5
> -          maxItems: 5
> +          minItems: 7
> +          maxItems: 7
> =20
>      else:
>        if:
>          properties:
>            compatible:
>              enum:
> -              - allwinner,sun6i-a31-pinctrl
> -              - allwinner,sun6i-a31s-pinctrl
> -              - allwinner,sun50i-h6-pinctrl
> +              - allwinner,sun9i-a80-pinctrl

The diff is a bit of a mess here. I guess you just added a new if with
the A100 pinctrl compatible?

Also, since it's a new SoC and we don't really have to care about the
existing DT for boards, it would be great if you could make the gpio
banks supplies required.

Thanks!
Maxime

--ksr2pme4uhjoiziv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvoCMQAKCRDj7w1vZxhR
xWPvAP9LZcafd4D2lCpgUabz+vBQk/jZ4yIiOaajI+Es0NedYwEAhxAGjP80TFrZ
RAkD8uwHBQ+s2kLx229O2zmQ1CeFoQo=
=jflY
-----END PGP SIGNATURE-----

--ksr2pme4uhjoiziv--
