Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6D756CC4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jul 2023 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGQTHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jul 2023 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGQTHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2023 15:07:05 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60CDA;
        Mon, 17 Jul 2023 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689620817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUbYZ8pSTKDyookB+Z63SW+UrzvlNrmn7Cc06biQ1RY=;
        b=Vy1ZpdaCi5k3cwLDqwOtFWg7A3zS5kYwD68mlYCpmulFhmikPGznp1UU+O/FzmpYurkTQU
        dE1B9mWihM5B463eQv1jcypFaAEP/zRd2Wqcerui3nFeqrtlJnmHBxpmHHYUQq6LE2xUnR
        df3C1TFbJNELgy4uN2FVXJBkJfK6YxA=
Message-ID: <f48a35d596694839665bc5883260cbae3ae01d9c.camel@crapouillou.net>
Subject: Re: [PATCH v2 07/10] pinctrl: mediatek: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Date:   Mon, 17 Jul 2023 21:06:54 +0200
In-Reply-To: <20230717172821.62827-8-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-8-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andy,


Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 5 +----
> =C2=A0drivers/pinctrl/mediatek/pinctrl-paris.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 9 +++------
> =C2=A02 files changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 665dec419e7c..2bf5082d3aa9 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -922,10 +922,7 @@ static int mtk_eint_resume(struct device
> *device)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return mtk_eint_do_resume=
(pctl->eint);
> =C2=A0}
> =C2=A0
> -const struct dev_pm_ops mtk_eint_pm_ops =3D {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.suspend_noirq =3D mtk_eint_su=
spend,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.resume_noirq =3D mtk_eint_res=
ume,
> -};
> +DEFINE_NOIRQ_DEV_PM_OPS(mtk_eint_pm_ops, mtk_eint_suspend,
> mtk_eint_resume);
> =C2=A0
> =C2=A0static int mtk_pctrl_build_state(struct platform_device *pdev)
> =C2=A0{
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c
> b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index 33d6c3fb7908..b1cbd5bafa2e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -1119,24 +1119,21 @@ int mtk_paris_pinctrl_probe(struct
> platform_device *pdev)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(mtk_paris_pinctrl_probe);
> =C2=A0
> -static int mtk_paris_pinctrl_suspend(struct device *device)
> +static int mtk_paris_suspend(struct device *device)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mtk_pinctrl *pctl =
=3D dev_get_drvdata(device);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return mtk_eint_do_suspen=
d(pctl->eint);
> =C2=A0}
> =C2=A0
> -static int mtk_paris_pinctrl_resume(struct device *device)
> +static int mtk_paris_resume(struct device *device)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mtk_pinctrl *pctl =
=3D dev_get_drvdata(device);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return mtk_eint_do_resume=
(pctl->eint);
> =C2=A0}
> =C2=A0
> -const struct dev_pm_ops mtk_paris_pinctrl_pm_ops =3D {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.suspend_noirq =3D mtk_paris_p=
inctrl_suspend,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.resume_noirq =3D mtk_paris_pi=
nctrl_resume,
> -};
> +DEFINE_NOIRQ_DEV_PM_OPS(mtk_paris_pinctrl_pm_ops, mtk_paris_suspend,
> mtk_paris_resume);

It's a bit more work, but I think you should use EXPORT_GPL_DEV_PM_OPS
(or even better, EXPORT_NS_GPL_DEV_PM_OPS) so that the dev_pm_ops is
conditionally exported. All callers would have to be updated to use
pm_ptr().

Cheers,
-Paul

> =C2=A0
> =C2=A0MODULE_LICENSE("GPL v2");
> =C2=A0MODULE_DESCRIPTION("MediaTek Pinctrl Common Driver V2 Paris");

