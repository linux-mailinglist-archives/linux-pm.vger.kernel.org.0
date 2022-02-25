Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA94C4BB5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiBYRNH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 12:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243516AbiBYRNE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 12:13:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B5739BAD
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 09:12:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AA9FF1F464DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645809150;
        bh=7oSi5ixpTTdfbwJkiXTsGeE1a5aBRIE6jzy4sxLVzm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qbmb8xTn3fpnnj09OPE6fj1dC09DICEEr11eCe+MGWgxymW1I1RBkXVsjZo9LFGXG
         2SZX/gclf7eE+jJfWF9sCDrL9C1XJDWNRRTJ2mirWtFJRhW3PtEpaaJ3Ut6MgcX2zr
         uHeCDfmqYKImpwcltBJ+klgGeCseIDngLsE4fD+aw1XqT12siV4FIn+eEwChP6YWKJ
         JceSNSoZNXnwDtpm5nnLlfcI7baQD/PTWqvFSNlc3RJ7PpH4s71S7D0W0SQBBE2vnc
         EmLgAIpuCyntFx4YAAO5SQdgju1caSjucKKFi/5mjvY9Echsb7gBsZ2KQpyMSVehRw
         F+RxRNV28g0UA==
Received: by mercury (Postfix, from userid 1000)
        id 58B44106049B; Fri, 25 Feb 2022 18:12:28 +0100 (CET)
Date:   Fri, 25 Feb 2022 18:12:28 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] power: supply: axp288_*: Use
 acpi_quirk_skip_acpi_ac_and_battery()
Message-ID: <20220225171228.4xn7ek2bwju6fyfo@mercury.elektranox.org>
References: <20220224222805.1689234-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzjoa3rewwzecdtl"
Content-Disposition: inline
In-Reply-To: <20220224222805.1689234-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qzjoa3rewwzecdtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Thu, Feb 24, 2022 at 11:28:03PM +0100, Hans de Goede wrote:
> Normally the native AXP288 fg/charger drivers are preferred but one some
> devices the ACPI drivers should be used instead.
>=20
> The ACPI AC and battery drivers used to both have their own detection if
> a PMIC on which native drivers should be preffered was present as well as
> their own list of exceptions for devices like the ECS EF20EA, which has
> an AXP288 PMIC but uses a separate fuel-gauge.
>=20
> And the axp288_fuel_guage driver also has a dmi_system_id table entry
> for the ECS EF20EA to avoid loading on this board. Where as for
> the axp288_charger code it was decided that it was ok to have both
> a /sys/class/power_supply/ADP1 from ACPI as well as a /axp288_charger .
>=20
> So that is 3 separate "ECS EF20EA" dmi_system_id table entries in
> 3 different drivers (which should really be 4). In 5.17-rc1 a patch
> adding a new acpi_quirk_skip_acpi_ac_and_battery() helper was merged
> to remove the code duplication for this from the ACPI AC and battery
> drivers:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D57a18322227134e37b693ef8ef216ed7ce7ba7d6
>=20
> This series makes the AXP288 charger and fuelgauge drivers also use
> this helper. This allows removing the "ECS EF20EA" dmi_system_id table
> entry from the fuel-gauge code and fixes the duplicate
> /sys/class/power_supply/axp288_charger power_supply device on these
> boards.
>=20
> This also gives us a single place to add further exceptions if
> necessary, rather then needing to do this in 4 different places.

Thanks, queued.

-- Sebastian

--qzjoa3rewwzecdtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIZDfIACgkQ2O7X88g7
+ppqTA/+PhAYVJcBKcAuNM3ACOpHXWm+UiPARyblkhMqg/5jkrCWXJLDI/KfXSeX
tCx07pPc92I4P+khjoDSEhNjv+uO4epBjxsXdRZ26EdR0uMDWeZSy2n2P+/k7JAk
1vNoOUFZOCpGceQFrP0OgT5ry4qFn0ibd4BIbjK4hZKhfQ7sVypy0edQMx50Wi+d
qXiRMRL4f4yTEyJEuvTaLL+DdabRRfcJZBXI5iSZxoOAdX54S28KR3H2m0S6ERaJ
6HtL/RRDoNBRC/4o6UwdIWCL0BUgXH6CSgkfHtyh3Z19BiW5qAgx8ZfQ/Er4JEtl
LparVGxhNGSI01wPyujoVnL1HuCOy6Frw9VuLcv+0bWO6aisFp0FgRzUYaq/Clx/
KrnYE4eJuCAl7Dq6ouYkYaJMWfIwkMnWTinKoJCrlUPUReYsZaMoIF7vp9ZsxtAj
FqKO+0O1lSO2i+yhDZuuUdjEsGMdy3uRvUQmP02IqQxhk0CBuVtf3EYOE19Ko/4a
g5FTo0uio0qI+RaRoEkwrqxyn+oazIa+ldXHEyyzvea3RUsqFAZPCsQkqXc/hwZ0
aSD4oFHwQcyXqOSshBZ2Amukx2cGTGE35TmxN3a+SAQQhpcpKRgbAurtr3ZUgNbI
5kuKgIYMY13kb73JtxDOVuSxf9Ng20KaTDtNB+clQnmDLeSo6Ic=
=yZdi
-----END PGP SIGNATURE-----

--qzjoa3rewwzecdtl--
