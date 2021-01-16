Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C02F8CC4
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 11:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbhAPKNX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 05:13:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47138 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAPKNV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 05:13:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7E51A1F4604D
Received: by earth.universe (Postfix, from userid 1000)
        id 73B7C3C0C94; Sat, 16 Jan 2021 11:12:37 +0100 (CET)
Date:   Sat, 16 Jan 2021 11:12:37 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v3 2/2] power: supply: mt6360_charger: add MT6360 charger
 support
Message-ID: <20210116101237.vktppv2ec7kvtz3v@earth.universe>
References: <1608796084-29418-1-git-send-email-gene.chen.richtek@gmail.com>
 <1608796084-29418-3-git-send-email-gene.chen.richtek@gmail.com>
 <20210106201654.lkmqorlgcecgqqkf@earth.universe>
 <CAE+NS37t-Gf7fjK0crZ+9qxWxfxm3k8hoEvwystdNP4CjM=KXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ochbwuxpqessdn2a"
Content-Disposition: inline
In-Reply-To: <CAE+NS37t-Gf7fjK0crZ+9qxWxfxm3k8hoEvwystdNP4CjM=KXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ochbwuxpqessdn2a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 11, 2021 at 08:15:33PM +0800, Gene Chen wrote:
> Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2021=E5=B9=
=B41=E6=9C=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:16=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > +static int mt6360_charger_get_ichg(struct mt6360_chg_info *mci,
> > > +                                union power_supply_propval *val)
> > > +{
> > > +     int ret;
> > > +     unsigned int regval;
> > > +
> > > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_CHG_CTRL7, &regval);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     regval =3D (regval & MT6360_ICHG_MASK) >> MT6360_ICHG_SHFT;
> > > +     val->intval =3D mt6360_map_real_val(regval,
> > > +                                       MT6360_ICHG_MIN,
> > > +                                       MT6360_ICHG_MAX,
> > > +                                       MT6360_ICHG_STEP);
> > > +     return 0;
> > > +}
> >
> > It's unusual, that you do not need any scaling. Does the hardware
> > really report voltages in =C2=B5V and currents in =C2=B5A?
> >
>=20
> Should I replace MT6360_ICHG_MIN by MT6360_ICHG_MINUA?

I just noticed, that you already have uA/uV comments above the
#defines. Should be good enough. Just keep it the way it is.

[...]
=20
> > > +     last_usb_type =3D mci->psy_usb_type;
> > > +     /* Plug in */
> > > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_USB_STATUS1, &usb_s=
tatus);
> > > +     if (ret < 0)
> > > +             goto out;
> > > +     usb_status &=3D MT6360_USB_STATUS_MASK;
> > > +     usb_status >>=3D MT6360_USB_STATUS_SHFT;
> > > +     switch (usb_status) {
> > > +     case MT6360_CHG_TYPE_UNDER_GOING:
> > > +             dev_info(mci->dev, "%s: under going...\n", __func__);
> > > +             goto out;
> >
> > IDK what this is supposed to tell me. Do you mean "detection in
> > progress"? Also why is this info level? I would expect either
> > debug (assuming it happens regularly and is normal) or warning
> > (assuming it should not happen).
> >
>=20
> When handling attach interrupt and cable plug out at the same
> time, HW change register status. So we don' need to handle this
> attach interrupt at this case.

So this is basically for debouncing? I suggest adding a comment:

/* Received attach IRQ followed by detach event, so nothing to do */
dev_dbg(mci->dev, "under going...\n");
goto out;

[...]

> > > +     config.dev =3D &pdev->dev;
> > > +     config.regmap =3D mci->regmap;
> > > +     mci->otg_rdev =3D devm_regulator_register(&pdev->dev, &mt6360_o=
tg_rdesc,
> > > +                                             &config);
> > > +     if (IS_ERR(mci->otg_rdev))
> > > +             return PTR_ERR(mci->otg_rdev);
> > > +
> > > +     ret =3D mt6360_sysfs_create_group(mci);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev,
> > > +                     "%s: Failed to create sysfs attrs\n", __func__);
> > > +             return ret;
> > > +     }
> >
> > Use charger_cfg.attr_grp to register custom sysfs group for
> > power-supply devices. Otherwise your code is racy (udev may not pick
> > up the sysfs attributes). Also custom sysfs attributes need to be
> > documented in Documentation/ABI/testing/sysfs-class-power-<driver>.
> >
> > Looking at the attributes you are planning to expose, I don't think they
> > are suitable for sysfs anyways. Looks more like a debug interface, which
> > should go into debugfs instead. But it's hard to tell without any docum=
entation
> > being provided :)
>=20
> ACK, I will change to charger_cfg.attr_grp.
> I assumed the charger algorithm thread is in user space, and take
> control by sysfs node from charger device, like bq24190.c.
> Should I change to debugfs?

It's hard to tell without knowing more about the attributes
your are trying to expose. In debugfs we have relaxed ABI rules,
so it's easier to adopt naming e.t.c. later.

-- Sebastian

--ochbwuxpqessdn2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmACvAsACgkQ2O7X88g7
+pp1TBAApwZbiBR41pqeQofuNzK3+gUsuqMvf/I6MR24aWvXAqxlkuihN4oHY4uk
VqlPBlH2+KFEOkn0JedYY+e19KV+9vmI/2ph+KTd3FkS3WToUWMIoBH3yuHqoeZ2
ZkNIwXX3H/CNYw1nXYky4sdHWKn2vYdN5RFeJ4gAzMvv6JI/ziaKemcLPL1n7jE1
jylQxYKVhA4ABFpjBfUk3eXv7cytmT4H64UPSt8cppPuGIfaz6ZPYwsRZ9PCMdy2
pWg3VGKhc7v+jgXymTe8OlhTA0xaaOuolfFHdquJrNRGUkF3bt94AECtB95IWXQH
s+dnHL7wbi79JSuK9Wl03u5e3dGOlwr5j/U2J0JHpS9uGMpkyTsQbB+BPh8MDSql
CCextokIZqIwvWWic+LXH9Oc5lSJud8ZXLaqy9fDoc8mR2/bFF3k9acEwo9GDBMq
rI//a/D7YMKs2h1fecm574yCTxchgSN5sJhHCa8tU/oHXRIg382pp/gF+uCoSQW7
07/lDzOes62QcRQf+gSLo0BjlJ5hGfRjFdQcVFlaGEw4HAAvhtSLNl+BjSDkQLD5
kFof8kWnX+CrczibZLyfuzucXbCiN7KHjrltaYwD1MvA1n0lRUT4S3xfc8SS3+YV
NubNmRQNmiOiOv0JA7ieE6KTma6F2AQI0ggnDQQUH9+tK5OwASw=
=r4DG
-----END PGP SIGNATURE-----

--ochbwuxpqessdn2a--
