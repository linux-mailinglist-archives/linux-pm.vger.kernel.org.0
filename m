Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D491295A6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 12:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLWLoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 06:44:39 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47076 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLWLoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 06:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1577101475; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVdlO9cJhU3uZR9PsalU+9sk35dl6Zqn8751jyDz6hE=;
        b=jX9LJcjWIqPnnuyZly5BdZOoj2/inQqbVjiES4HFwhniV6JNaGO+ALAE433xhQmOf7hoHr
        74R9G8HAr3LeKzr0sbxjFJVOggyg28MPxpD0DHH9YfttM3lvpC+gmVq6n3+Ac/2Iy0eHBk
        VXMTWUiAs8EHGfFQgFmRp6lvylZSZUE=
Date:   Mon, 23 Dec 2019 12:44:26 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/9] memory: jz4780_nemc: convert to
 devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     ssantosh@kernel.org, matthias.bgg@gmail.com, rogerq@ti.com,
        tony@atomide.com, lukasz.luba@arm.com, kgene@kernel.org,
        krzk@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        allison@lohutok.net, tglx@linutronix.de, yong.wu@mediatek.com,
        jroedel@suse.de, evgreen@chromium.org, rfontana@redhat.com,
        digetx@gmail.com, pdeschrijver@nvidia.com, john@phrozen.org,
        alexios.zavras@intel.com, sboyd@kernel.org,
        kstewart@linuxfoundation.org, info@metux.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Message-Id: <1577101466.3.0@crapouillou.net>
In-Reply-To: <20191222185034.4665-2-tiny.windzz@gmail.com>
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
        <20191222185034.4665-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,


Le dim., d=E9c. 22, 2019 at 18:50, Yangtao Li <tiny.windzz@gmail.com> a=20
=E9crit :
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul


> ---
>  drivers/memory/jz4780-nemc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/memory/jz4780-nemc.c=20
> b/drivers/memory/jz4780-nemc.c
> index b232ed279fc3..857a9fa5cba5 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -269,7 +269,6 @@ static int jz4780_nemc_probe(struct=20
> platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct jz4780_nemc *nemc;
> -	struct resource *res;
>  	struct device_node *child;
>  	const __be32 *prop;
>  	unsigned int bank;
> @@ -287,8 +286,7 @@ static int jz4780_nemc_probe(struct=20
> platform_device *pdev)
>  	spin_lock_init(&nemc->lock);
>  	nemc->dev =3D dev;
>=20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	nemc->base =3D devm_ioremap_resource(dev, res);
> +	nemc->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(nemc->base)) {
>  		dev_err(dev, "failed to get I/O memory\n");
>  		return PTR_ERR(nemc->base);
> --
> 2.17.1
>=20

=

