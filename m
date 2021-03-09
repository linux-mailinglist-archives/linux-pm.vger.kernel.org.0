Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DE332008
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 08:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhCIHrd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 02:47:33 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:61866 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCIHrT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 02:47:19 -0500
Date:   Tue, 09 Mar 2021 07:47:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1615276032;
        bh=+ZlcTZnrhrZ8o7M1JrptlxBInGQYHsPbgf1Nr0uMsQ0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TxKn1Jcnp1F8jZez32EQsOrCPDgvTGtkRoJCDS1vmcYP8iX4xUP5r12Mf323ZS9re
         uZQS704MUiB1voO6Gn4s/ELYUmkOa5o5uXmSkQ+Q/Omc8gy0yb6MB800FMdSa3dSBv
         Za0jyyJxQK/td48v87cqCAZOUCd7oqnV49DUDD7w=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH 3/3] power: supply: max8997_charger: Switch to new binding
Message-ID: <20210309084658.4a140b92@focal-fossa>
In-Reply-To: <20210201180335.rrsqfvbcmxvx64gf@kozik-lap>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com> <20210130172747.2022977-4-timon.baetz@protonmail.com> <20210131172840.fxaadhhsafa4aeex@kozik-lap> <20210201083128.18499ffd.timon.baetz@protonmail.com> <20210201180335.rrsqfvbcmxvx64gf@kozik-lap>
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

On Mon, 1 Feb 2021 19:03:35 +0100, Krzysztof Kozlowski wrote:
> On Mon, Feb 01, 2021 at 09:26:42AM +0000, Timon Baetz wrote:
> > On Sun, 31 Jan 2021 18:28:40 +0100, Krzysztof Kozlowski wrote:
> > > On Sat, Jan 30, 2021 at 05:30:14PM +0000, Timon Baetz wrote:
> > > > Get regulator from parent device's node and extcon by name.
> > > >
> > > > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > > > ---
> > > >  drivers/power/supply/max8997_charger.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power=
/supply/max8997_charger.c
> > > > index 321bd6b8ee41..625d8cc4312a 100644
> > > > --- a/drivers/power/supply/max8997_charger.c
> > > > +++ b/drivers/power/supply/max8997_charger.c
> > > > @@ -168,6 +168,7 @@ static int max8997_battery_probe(struct platfor=
m_device *pdev)
> > > >  =09int ret =3D 0;
> > > >  =09struct charger_data *charger;
> > > >  =09struct max8997_dev *iodev =3D dev_get_drvdata(pdev->dev.parent)=
;
> > > > +=09struct device_node *np =3D pdev->dev.of_node;
> > > >  =09struct i2c_client *i2c =3D iodev->i2c;
> > > >  =09struct max8997_platform_data *pdata =3D iodev->pdata;
> > > >  =09struct power_supply_config psy_cfg =3D {};
> > > > @@ -237,20 +238,23 @@ static int max8997_battery_probe(struct platf=
orm_device *pdev)
> > > >  =09=09return PTR_ERR(charger->battery);
> > > >  =09}
> > > >
> > > > +=09// grab regulator from parent device's node
> > > > +=09pdev->dev.of_node =3D iodev->dev->of_node;
> > > >  =09charger->reg =3D devm_regulator_get_optional(&pdev->dev, "charg=
er");
> > > > +=09pdev->dev.of_node =3D np;
> > >
> > > I think the device does not have its own node anymore. Or did I miss
> > > something?
> >
> > The idea is to reset of_node to whatever it was before (NULL) and basic=
ally
> > leave the device unchanged. Probe might run again because of deferral.
>
> Good point.
>
> >
> > > >  =09if (IS_ERR(charger->reg)) {
> > > >  =09=09if (PTR_ERR(charger->reg) =3D=3D -EPROBE_DEFER)
> > > >  =09=09=09return -EPROBE_DEFER;
> > > >  =09=09dev_info(&pdev->dev, "couldn't get charger regulator\n");
> > > >  =09}
> > > > -=09charger->edev =3D extcon_get_edev_by_phandle(&pdev->dev, 0);
> > > > -=09if (IS_ERR(charger->edev)) {
> > > > -=09=09if (PTR_ERR(charger->edev) =3D=3D -EPROBE_DEFER)
> > > > +=09charger->edev =3D extcon_get_extcon_dev("max8997-muic");
> > > > +=09if (IS_ERR_OR_NULL(charger->edev)) {
> > > > +=09=09if (!charger->edev)
> > >
> > > Isn't NULL returned when there is simply no extcon? It's different th=
an
> > > deferred probe. Returning here EPROBE_DEFER might lead to infinite pr=
obe
> > > tries (on every new device probe) instead of just failing it.
> >
> > extcon_get_extcon_dev() just loops through all registered extcon device=
s
> > and compared names. It will return NULL when "max8997-muic" isn't
> > registered yet. extcon_get_extcon_dev() never returns EPROBE_DEFER so
> > checking for NULL seems to be the only way. Other drivers using that
> > function also do NULL check and return EPROBE_DEFER.
>
> Indeed, thanks for clarification. Looks good:
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Is something blocking this from being accepted?

Timon


