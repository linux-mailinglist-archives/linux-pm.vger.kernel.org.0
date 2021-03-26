Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3B34AC6C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 17:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCZQUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 12:20:17 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:42447 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhCZQUP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 12:20:15 -0400
Date:   Fri, 26 Mar 2021 16:20:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1616775613;
        bh=CcH0rrv6ICKSLNLF1sxiChOceJEI2Qlg0grV7Totep8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=c30bEGTy62ExKen3AwiddvrcXMRkPby5SCVlQBmzNqKMCUKyX2XHVrobyX3fdRzpk
         8XrzAlXWPqyinIgRvmJyRi0NzWml17hMFA7SAXV/rmB532ZoUVLTt5L50m3imh/WnX
         Cs4uV6zPDC+r9uXUKjVtTmvROyM/EKJskPyPcq40=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Timon Baetz <timon.baetz@protonmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH 3/3] power: supply: max8997_charger: Switch to new binding
Message-ID: <20210326171956.7d1d9624@focal-fossa>
In-Reply-To: <20210130172747.2022977-4-timon.baetz@protonmail.com>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com> <20210130172747.2022977-4-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 30 Jan 2021 17:30:14 +0000, Timon Baetz wrote:
> Get regulator from parent device's node and extcon by name.
>
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  drivers/power/supply/max8997_charger.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/suppl=
y/max8997_charger.c
> index 321bd6b8ee41..625d8cc4312a 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -168,6 +168,7 @@ static int max8997_battery_probe(struct platform_devi=
ce *pdev)
>  =09int ret =3D 0;
>  =09struct charger_data *charger;
>  =09struct max8997_dev *iodev =3D dev_get_drvdata(pdev->dev.parent);
> +=09struct device_node *np =3D pdev->dev.of_node;
>  =09struct i2c_client *i2c =3D iodev->i2c;
>  =09struct max8997_platform_data *pdata =3D iodev->pdata;
>  =09struct power_supply_config psy_cfg =3D {};
> @@ -237,20 +238,23 @@ static int max8997_battery_probe(struct platform_de=
vice *pdev)
>  =09=09return PTR_ERR(charger->battery);
>  =09}
>
> +=09// grab regulator from parent device's node
> +=09pdev->dev.of_node =3D iodev->dev->of_node;
>  =09charger->reg =3D devm_regulator_get_optional(&pdev->dev, "charger");
> +=09pdev->dev.of_node =3D np;
>  =09if (IS_ERR(charger->reg)) {
>  =09=09if (PTR_ERR(charger->reg) =3D=3D -EPROBE_DEFER)
>  =09=09=09return -EPROBE_DEFER;
>  =09=09dev_info(&pdev->dev, "couldn't get charger regulator\n");
>  =09}
> -=09charger->edev =3D extcon_get_edev_by_phandle(&pdev->dev, 0);
> -=09if (IS_ERR(charger->edev)) {
> -=09=09if (PTR_ERR(charger->edev) =3D=3D -EPROBE_DEFER)
> +=09charger->edev =3D extcon_get_extcon_dev("max8997-muic");
> +=09if (IS_ERR_OR_NULL(charger->edev)) {
> +=09=09if (!charger->edev)
>  =09=09=09return -EPROBE_DEFER;
>  =09=09dev_info(charger->dev, "couldn't get extcon device\n");
>  =09}
>
> -=09if (!IS_ERR(charger->reg) && !IS_ERR(charger->edev)) {
> +=09if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
>  =09=09INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker=
);
>  =09=09ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_sto=
p_work, charger);
>  =09=09if (ret) {


Hello, I am not sure if I am missing something here. The other 2
patches of the series already made it into linux-next but this is still
pending. Do I have to resubmit? The patch still applies without
conflicts. Any help would be appreciated.

Thanks, Timon

