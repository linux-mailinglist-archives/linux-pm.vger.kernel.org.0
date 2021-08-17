Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E161D3EED24
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhHQNQl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 09:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhHQNQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 09:16:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E45C061764
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 06:16:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0CF121F433B5
Received: by earth.universe (Postfix, from userid 1000)
        id 47B6B3C08DB; Tue, 17 Aug 2021 15:16:02 +0200 (CEST)
Date:   Tue, 17 Aug 2021 15:16:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas Marangoni <thomas@marangoni.cc>
Cc:     linux-pm@vger.kernel.org
Subject: Re: Define own attributes in power supply driver
Message-ID: <20210817131602.yotgm5kfjldtxc72@earth.universe>
References: <95324fdb-20c1-3286-0223-09ff62d8957d@marangoni.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ui5hgdffi6tzslqy"
Content-Disposition: inline
In-Reply-To: <95324fdb-20c1-3286-0223-09ff62d8957d@marangoni.cc>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ui5hgdffi6tzslqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 17, 2021 at 08:33:50AM +0200, Thomas Marangoni wrote:
> Hello,
> I'm new to developing kernel drivers and want to improve the driver of the
> axp209 battery driver. I've read the documentation about the Linux power
> supply class
> (https://www.kernel.org/doc/html/latest/power/power_supply_class.html) and
> there it says: "Power supply class is extensible, and allows to define
> drivers own attributes.". The problem is I couldn't find any documentation
> or example of how to add own attributes. My goal is to have an own attrib=
ute
> showing up at /sys/class/power_supply/axp20x-battery/
>=20
> Is there any example on how to do that or any documentation I didn't foun=
d?
>=20
> Thanks for your help!

Custom attributes are registered via the attr_grp member of
'struct power_supply_config' when registering the power-supply.
See for example drivers/power/supply/surface_battery.c:

---------------------------------------------------------------------------=
---
static ssize_t alarm_show(struct device *dev, struct device_attribute *attr=
, char *buf)
{
    ...
}

static ssize_t alarm_store(struct device *dev, struct device_attribute *att=
r, const char *buf,
                           size_t count)
{
    ...
}

static DEVICE_ATTR_RW(alarm);
=20
static struct attribute *spwr_battery_attrs[] =3D {
        &dev_attr_alarm.attr,
        NULL,
};
ATTRIBUTE_GROUPS(spwr_battery);


static int spwr_battery_register(struct spwr_battery_device *bat)
{
    ...
    psy_cfg.attr_grp =3D spwr_battery_groups;
    bat->psy =3D devm_power_supply_register(&bat->sdev->dev, &bat->psy_desc=
, &psy_cfg);
    ...
}
---------------------------------------------------------------------------=
---

-- Sebastian

--ui5hgdffi6tzslqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEbtowACgkQ2O7X88g7
+praSRAAlfzmGcYapWwT7RZUvai8UMLbwqAhkgogYWD3mjDhgJo05OldZyjHERSn
2XY7QpCLH+3D0Fzinu4fFC5HbgRQHgM4Bbs666oZa/+uZ/w8yLwtOfkukZabtecW
QifrYrdRyo2+/jRvSwa/ITcBA432oiiSh1TPpT7hXzkAkJXzTw7I7Q0yHPCEbQ3/
MKgtp0HklXMPZ6RPJYXCsAHBfzU9ouqLT2w93VZffcwSUDQu6UG8VLTxtstY7JnT
JdfWNh1lxxFkKtz7G3C1YXgL+0S2EY5uv1lGEkNDGgGadrtw+/cpnRaoshgs+I9w
uZ1YeL2SxfjWFzHR4SnlEycj66N1opfoQm2PTj+NSFNSJBuEVQ/eDTyDnDjgdqB4
MsvRHU2x2N1J3JlTDxbIauG0QfcwYHUHR5Sq56rjaj3Ddrk5Wg7M96dnSB5I18Qe
BvJhpQmYfSV3UrrJDtl4y0ywO3ekka19K19VUZ7d7It9FbRRLWIC4ofnl583k2U+
9H7MjwaSA12UebWpEqUetMpm4VRNOVRw/XZ6laSgeX2bzOJBIBalOSK76f/APjzK
hIWWcWZeAkn0qwAsk6sDYAUFDNMYH9IgAmZt9nmdXaweJ1+V/CG+eL6sa5Avscx8
N9TX/FXV0TBvP9aE4HQtkYecToHoSPtBglmZTS7uD/uFyOk6Y4U=
=vCak
-----END PGP SIGNATURE-----

--ui5hgdffi6tzslqy--
