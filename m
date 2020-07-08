Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5E0218732
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgGHMZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 08:25:48 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:59449 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728681AbgGHMZr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 08:25:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1B3E4BDC;
        Wed,  8 Jul 2020 08:25:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 08:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=W
        GeLdZevEHRYXhgk2QETUtSKHCbJuo1sBlmhw+I+6SM=; b=ZjjGbP96DMyvdd6x4
        HmJTMz6u3VBpaq/DrQc64LPyEYenL3og8ol5UevLG3Hjlwr7d+VEAghNB1EJGpo0
        EnJl/zAiEdcOhJZ9xSq4+Yt6DMkamTVpbR09zulKv59rQloSJ1F4p9cU95XWAs96
        BIsEiX0a79p/ZbFDL14NtGsXH90mXDO7NGScW6z/1zD46lsfQVd8IxE47n8Z00nH
        Jgm2DR22vp8LMo91X8Wk9r7nPxRSwBSIv9n1sFsMlwSE1V1ox7TELtR+kfFBpCHg
        srUQ1/rRY8vQAkXKNS5z9BZKTHMKz42TKZHwLC+ouqaV66uAFb1AuHiedZD2oQfP
        oYvzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=WGeLdZevEHRYXhgk2QETUtSKHCbJuo1sBlmhw+I+6
        SM=; b=NO5deZoxpXKh4YytPuG5YffAbtm/zU7P3iKkyn9F7NJIUuFvPHCW2Oemy
        O6BFSOtewPk41lTxckKysh6L0m3sbUMj7ps8SQnf4MHIuy7FoN8Y0qx8DW+cHJ/D
        rVuPnBXQVA4Qk0DGy2u/OVCtoIV6fKiXnle93YPUlxnq2cDGddwrRyOnYBvhc4KT
        oznAEa2hYXHOkNqaTqBk5YMKJvfBDhF51PsKHqoKGWDZjgqWNnNHWRgs769QNSBv
        B1NKaLGnkuxjGWvje3z3ysT7Y6is9bBPpoWxIzIkgoG+aCYOyaocbnG0G32AOzCq
        zUCFaCw1XCL4tZR7DMDfizTmgWz9Q==
X-ME-Sender: <xms:SLsFXyLOvLkdkAy5uyKf7e6X6is93D0Ks9sPA8IfqSsAcyrJCy7uGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:SLsFX6Js5IFFY6GQtYg9RGjtBFkceXwpfiildcW4SRbTYduO4Elttg>
    <xmx:SLsFXysllCDMSTHy74Q1CTzqDowUqvZea67-uqG7CNZTLQkoNPSvKA>
    <xmx:SLsFX3bh_8oOt7Rn96Zv71VlWoc6qToaw7JrEodyGtkov_d5Cc2bWA>
    <xmx:SbsFX15jqq9xsm4atcXFywdF0Lc1-_Q_JJKQIRt0X5y7xK3HtTUTZYwkGik>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 150273280059;
        Wed,  8 Jul 2020 08:25:43 -0400 (EDT)
Date:   Wed, 8 Jul 2020 14:25:42 +0200
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
Message-ID: <20200708122542.73o3lbhgvbdw5c4z@gilmour.lan>
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

Hi,

On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> I noticed several mobile Linux distributions failing to enable the
> thermal regulation correctly, because the kernel is silent
> when thermal driver fails to probe. Add enough error reporting
> to debug issues and warn users in case thermal sensor is failing
> to probe.
>=20
> Failing to notify users means, that SoC can easily overheat under
> load.
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 74d73be16496..9065e79ae743 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_device *tm=
dev)
> =20
>  	calcell =3D devm_nvmem_cell_get(dev, "calibration");
>  	if (IS_ERR(calcell)) {
> +		dev_err(dev, "Failed to get calibration nvmem cell (%ld)\n",
> +			PTR_ERR(calcell));
> +
>  		if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> +

The rest of the patch makes sense, but we should probably put the error
message after the EPROBE_DEFER return so that we don't print any extra
noise that isn't necessarily useful

Maxime
