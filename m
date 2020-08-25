Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5D2519ED
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHYNjY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 09:39:24 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:47361 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbgHYNgG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 09:36:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 184A1CBD;
        Tue, 25 Aug 2020 09:36:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=gR3pweVv8Px8rFqGtFTwA22x2JV
        zhJpDs8kjnfvQrwU=; b=ZKthbNBZD5TqTReje9//nICE81ovQp6WKQ7Y+fkpX0r
        342iOhR96x763J39eXLcp7DI1mlD3YDZhDLJATm4gLEsLe/RNUoCaI9NeaYsvGLZ
        0zlkVOeB1kkv4PxAtLZo9u7Qj4JLJ8iczPcWJDqiVuTtxggRY9oMSl7gg2lTvBAd
        oLNJ3rJ+TyBzvy8JnYqkAS1Ixz4kt+IyMs+6wnTTyLmC+4HQqeXt/eE8EpuQ1LHB
        dPBWtkO5q5YdFUd/YtS9ZtuZf1eCgccExUR5TgdAJvhHVL0G8l+Rpt01L1kqO3ez
        G11749iSX9SO+7KvmVlo7N4gKahSgFmy2YRlZJFIj/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gR3pwe
        Vv8Px8rFqGtFTwA22x2JVzhJpDs8kjnfvQrwU=; b=XeouHkmSMaPgZGgkwK9gBE
        UNk2kjv0ZMQZ2Fr/KgSKzkdqDaPRWGYFmg4lLN/tpy8/x8TCJiGOpnGUhoIeWjZ1
        oXKim7/EoCdZKIdHUCsJmdEjDN59vQPwXhKWOtCTfnZwZIodjq+DEzHZe6Urw54Z
        AVM62ScUqZq3e4oSqkajrSkywskehZdcqEEKQwEtraWbFWsIA/a+b9DGUQtP7xeS
        EfK3tcq6IB1o0tiWeu4c8soUqh1YG5Exe7SHSSPFe/10lKi+LGWix+r7Cyg5nQvK
        6VoIkcw5CnZ/ZwQ522Hs+g17LZl2iCJ2iYJ2vCMBs39H1IEAvALOATEGePYpCmCQ
        ==
X-ME-Sender: <xms:xBNFX-GTizd1cJM1xroLOltRl634NIUAvifSBznZOzNHqiQtNi1iGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xBNFX_U4rMYrAkLqnBfQTY0RMlnEj1Qh37H7CKzSwosC8p_-pfrG6g>
    <xmx:xBNFX4K2vEGqg2mVktNWhMEBQTreRrbm7KAhpc2GJsmiLPL4w3LoBQ>
    <xmx:xBNFX4HtDcqV4TQ3LcRfY7CLwE2J9YphicWvZBcxR-Bmu8juqzJzNA>
    <xmx:xBNFXzOfOYUySZsapVxWYa_Lou44xH7I27efKX-UM8Rlmr95B_CRmkxyzZk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 070873060067;
        Tue, 25 Aug 2020 09:36:03 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:45:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, wens@csie.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 07/16] dt-bindings: thermal: sun8i: Add binding for
 A100's THS controller
Message-ID: <20200825084554.rdml64n6qofjfzaa@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <8280af8ad82ed340c0ef1c171684aaad91600679.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mi2ra6dsuvemjwu"
Content-Disposition: inline
In-Reply-To: <8280af8ad82ed340c0ef1c171684aaad91600679.1595572867.git.frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2mi2ra6dsuvemjwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:10:57PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Add a binding for A100's ths controller.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--2mi2ra6dsuvemjwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TPwgAKCRDj7w1vZxhR
xVXvAQCVS2UqbwhCN/0iWdJ29Re42njcjQn+u6Um4jTsFzJ4/gEA27LfAfTDUWdz
xfaa1CgE73i2sYEqd69AtcBdh3AJPgo=
=/qrb
-----END PGP SIGNATURE-----

--2mi2ra6dsuvemjwu--
