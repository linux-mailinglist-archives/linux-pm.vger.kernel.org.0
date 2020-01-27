Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB4714A12D
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 10:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgA0Jr7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 04:47:59 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:55939 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbgA0Jr6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 04:47:58 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EA8158706;
        Mon, 27 Jan 2020 04:47:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 27 Jan 2020 04:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=D0agDfMES+f5sz8FtNMBMOC9b25
        uS9ZmYckjSQrkMEY=; b=gFSDjyyDFqLlM+dXDPSJzHdThqw7dWggT6q+A1hAOP4
        3fqxBj0kpgkLKVADimwtkVpZY58c1YQM6eErFprywq/epCUxIDkl57xPLbb8A6w/
        kqCfKSkkDQYZxTn4wdqc+iX3SRCBZ2MC3jfX2U7xwMJgHHqDhK0QSDyxY8Q9v22G
        fcR1tiaZoFYj01G0gYWyTr5iZtonLlWaKueMQc+kOBt1k3s9gwz5PVQlejQtKBfh
        Nyp+3ZzZN162bwtzzbo++WNTKh8S/3/pImX0mbCLzJ3cGAhn3EBUzHgOjCGlVCQv
        16aSuE0eX3wC7vT1TH0xrARXYbD73VLKC6JD/13PezQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=D0agDf
        MES+f5sz8FtNMBMOC9b25uS9ZmYckjSQrkMEY=; b=JzwOaY8RsRV8d4XIhFGIjJ
        5NSPq5SFXo9HTN5iCOzdgz/jSyz/Ig55R/QgZ2cYSvn85exPDBKF6SDzuIOWH/XC
        5n6+Ol4Yrw53jY/mJWxdLFf6Kfoa/Tb28Ml1SCvu7/372X9knABHudBfmeeFmXZX
        P7rQx8O+r04pK6fDgTl2FwNlDinVXGezBAn5zwy/0K8+Xtruf6cVQYsqClX/8oNh
        RmeMCQkHMSDTdNnDz+ONEpkS5PrPXD0u+pzMEvpH9P5jQHf1YcXbKVcTuCIgiIi9
        8PgZXddrb1qMI8+F6iZYTWgXo3oqTe+jRs0IBllXVkg2DhXwpn/nXmBAvMk7NXcQ
        ==
X-ME-Sender: <xms:zLEuXgfgLnl7eE_v9KdkAxCwQoLe0tOmhPu_1z8qaJtcoI5PbfCAaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zLEuXoUcdZjzaRZOlDnmLuWWcZU6sLbIr7GqNbs-CDCX6J-mPCzz8Q>
    <xmx:zLEuXofHOipnjLbf6s1xGS7a1c7sSiguq0meZO8keXkeOYSBr-HtFg>
    <xmx:zLEuXtG75JtN5G42Cw4EVRkP5t0nadXYv14t4lYDdw7B4iIYs8WiSA>
    <xmx:zbEuXj_a599ETY-xBwnSAxkuC2vh8ZgvguKfy1WWPZwWQr2gHdLjpg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 96D40306965C;
        Mon, 27 Jan 2020 04:47:56 -0500 (EST)
Date:   Mon, 27 Jan 2020 10:47:54 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: sun8i-r40: Add thermal sensor and
 thermal zones
Message-ID: <20200127094754.w4wacqgtdodxayln@gilmour.lan>
References: <20200106174639.20862-1-tiny.windzz@gmail.com>
 <20200106174639.20862-2-tiny.windzz@gmail.com>
 <20200107075816.ly6exfd4qtvfxxua@gilmour.lan>
 <662e157a-603f-7423-0491-f26f0fc8d7b6@linaro.org>
 <20200109131343.mjyuj5ed2xwvmwd4@gilmour.lan>
 <af4bca3b-ba95-aa10-5601-753f1c5275b3@linaro.org>
 <CAEExFWtmUtzBje-DKt71W46rs3PTF_Di_x3YQCz+tg8+W1kyAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rh4ccto7d4lp6y3i"
Content-Disposition: inline
In-Reply-To: <CAEExFWtmUtzBje-DKt71W46rs3PTF_Di_x3YQCz+tg8+W1kyAA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rh4ccto7d4lp6y3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Jan 26, 2020 at 09:01:01PM +0800, Frank Lee wrote:
> HI Chen-Yu and Maxime,
>
> Can you pick this up again?

Sorry, I'm not quite sure what happened to this patch... I've picked
it up for 5.7 (for real this time, hopefully).

Maxime

--rh4ccto7d4lp6y3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXi6xygAKCRDj7w1vZxhR
xUkmAP9DgDEkdFW+faazJdPD1Gp2sjOOP/a14Whm0wZv6t0dYgD/fPBVqAvI3326
HCBqMcPz39j+iwdM+UuywN8uLjHD2Ag=
=E275
-----END PGP SIGNATURE-----

--rh4ccto7d4lp6y3i--
