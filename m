Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBDF2188FE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 15:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgGHN3w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 09:29:52 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:59809 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728148AbgGHN3w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 09:29:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 75059B4A;
        Wed,  8 Jul 2020 09:29:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 09:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=J
        gqM+l7NWg3T7iC7VFNhEk0S3/jtNUOXIDLh0bXRuPI=; b=kewKNCCYBt56UwdbX
        zn044rAYxmzBJCeLQQNYNx/m9SG5nut+WSWsNX5vxS8FTmHXC3SeY4ER3oj9d9h9
        xe2O07Y5Wu7UDKJpEATK8NOUkxjXDjx7TpIwtlhnDVhgoZ4qUB+I9gnrtGECiYK5
        bqWFvgVUYXW+G/+O+fbnE7BsUFDmfBXRZCm61cQh+fUmjXueVLS/J/73h7OueIDw
        wsid/eB3Q8o11vx6tcvAsiOHr1rV/CTlIXYzUM+ChdtyvsX1wqN1pRITjPDKRZkR
        uU+615lNx1XSRjxaLPjfra8VuSB7Fhe0DRi+6ecallrGWm2LIy2uCZvDVje360tB
        s/YPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=JgqM+l7NWg3T7iC7VFNhEk0S3/jtNUOXIDLh0bXRu
        PI=; b=fOf9EPcxN5J7ynthXkbJPdNJO/1BGgVihQjEkUiqzXckLxoaUEj5sDbVT
        /BNC1wdMsuj4lB4X/rBAbhWAg10DN5y6xyHpRAxYboL6LhZJj38KG0+CyVobLVKT
        nH6XnWQjQ4x/C04NHL/HF8PEr7XN9zzEnMMr2z5hmh85Up/EswW1V6iG0C9bKmF3
        KyplaGdTlBbwFLsAKXgII4t2Ryll2RsNQ4p/tgvNAreohqZeQmukmsSt4zsAcTPV
        d+ciO/VxoMb9oVWbAlzoBAAMuf3GCSrgnGvuwz4YVRjm8lAq7gS2vY0gD8cDqPkA
        5asGg7vcEt4Xy7un0vr/l2ueER5uw==
X-ME-Sender: <xms:TcoFX-dzCiiMKARQniK_Gw03jjY1aIF51uZ4yRzPGoz52M6e6G1eyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:TcoFX4P_fuOmUd6qlOAcZlEDBZV08JYlRqf6-1xo0FrfdgoKwgnBRw>
    <xmx:TcoFX_jUxhRXpkQIlw5JpcTEMC9iqk462LdouhftMmQJ8wYY1Mq5EA>
    <xmx:TcoFX7_pgiWplmI427ydtAcQKaGQ4G1J3WpzSHsO_3th5f22jDaEOw>
    <xmx:TsoFX39wA5uCrKhSFtWpjEP_v7gfnYoxNTyHw1MYManT7Pp9lKu42U9i9Ag>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F3E61328006A;
        Wed,  8 Jul 2020 09:29:48 -0400 (EDT)
Date:   Wed, 8 Jul 2020 15:29:47 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
Message-ID: <20200708132947.6rsgsqychmtzvuhr@gilmour.lan>
References: <20200708105527.868987-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200708105527.868987-1-megous@megous.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> @@ -523,10 +547,17 @@ static int sun8i_ths_probe(struct platform_device *=
pdev)
>  	ret =3D devm_request_threaded_irq(dev, irq, NULL,
>  					sun8i_irq_thread,
>  					IRQF_ONESHOT, "ths", tmdev);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		dev_err(dev, "Failed to request irq (%d)\n", ret);
> +		goto err_out;
> +	}
> =20
> +	dev_info(dev, "Thermal sensor ready!\n");
>  	return 0;

I missed that in my first mail, but I'm not sure we want to print
anything on success. This doesn't bring any value and that will only
make it harder to find errors in other drivers.

Maxime
