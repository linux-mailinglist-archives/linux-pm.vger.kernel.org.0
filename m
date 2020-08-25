Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195412519C4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHYNgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 09:36:21 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:54433 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbgHYNgJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 09:36:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8E1B1C3F;
        Tue, 25 Aug 2020 09:36:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=zIntnBuXpSaR3WFttpC6Z14pmK0
        kj+KtCt/Fp/W1l5Y=; b=lGWpth+a8r/ZvS7rtzWVn9X0gS8TO+csaGZXXkrlcfa
        mj1BQz9G3duhMcmGVb8b8CNVEqOoLQw/kEzaRVjtvJ26RSHOZuc+Nqabs6LnXIN6
        +76QGjnXKpnoTwqwBV/EpQX1fZ44WmhhCy1JWEbvIK712Z4b6DlOmM5yCLwud28t
        bHd3wMwGN+6B4s/CW4zkoPLfELmqx1PboJuDPldNI6bfA7AOzElkgmcsQ22JaT2j
        r5s3gjFxU8GRLB5FiTETGIcOwYnnMvj40fnEgPypgyKyBAZLmj7IQN935MnJ7fEZ
        VaXwdBZ9Yo31//4UuAc5nt5x7LMhql7EWHH81siEjzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zIntnB
        uXpSaR3WFttpC6Z14pmK0kj+KtCt/Fp/W1l5Y=; b=Sz0AYd5GZIofWgsXVWunT4
        7C2x3rRtrodahcssA4o50ODgTN9LQ5JAxK6wAwwroXETMluH2YrwCsdR0cYIqOuZ
        FetGbtUEwk1exx5bemtdxTGFZ4ORY+IY2FVfX9L2T9tLgE28c773PprywJetrWMc
        Y4RzZHPT06Tr1UcEpj8SIuCwbTxmzmLiz3hQNjRVVX+itGtiv4FRMQK8gCe0vHdd
        mCgoQVjcE26HI6w7dmuaM3Pa8d3YINN1zWBKA42Z3QygIARxJBlfhkBWycXSFn3I
        uu5QicyICAay8X/wVLRag92+WjUesjLCMkDNW7QAr30p8tSX+IyrK80UMpFUqAEQ
        ==
X-ME-Sender: <xms:xxNFX70lvcFM3fLIKcBW1UaDrsY-pAJt7OlBnCd2N5FJDqnicHvQUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xxNFX6H7omXavv2gD_Bxs4Sk5cGKPZgswA-UZWPoSkxNCbPsGw3TPw>
    <xmx:xxNFX74hREJYwgUv3l9HegXmWYpbWG1rE9BOlRDOhCCjXFm5IsaGlg>
    <xmx:xxNFXw1-XpF8oeVbkfPMYvXdzsPyh2FAH5KHidbQCrFl9jJ9fFnBGQ>
    <xmx:xxNFX2_qGKAorNi0f_WqSrCf8pmEphkvN_A2Y_NzUPHpXaGk1p-8cpU67Bc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DAC1F306005F;
        Tue, 25 Aug 2020 09:36:06 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:46:29 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, wens@csie.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com
Subject: Re: [PATCH v5 09/16] thermal: sun8i: Add A100's THS controller
 support
Message-ID: <20200825084629.e6y27bz7ot33ychu@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <48cc75920b5c69027134626157089d8b94942711.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="josxa6guw2ghbxyp"
Content-Disposition: inline
In-Reply-To: <48cc75920b5c69027134626157089d8b94942711.1595572867.git.frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--josxa6guw2ghbxyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:11:43PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> This patch add thermal sensor controller support for A100,
> which is similar to the previous ones.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--josxa6guw2ghbxyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TP5QAKCRDj7w1vZxhR
xWG7AP9ycCoJEEoU3y3szHM+UrV64jwpMJbJkqSRhWjjkX8F9QD+K2RIXAF7clKR
QdTaqcpDsiiVINawzQ9tHkIRczGUvw0=
=DZKj
-----END PGP SIGNATURE-----

--josxa6guw2ghbxyp--
