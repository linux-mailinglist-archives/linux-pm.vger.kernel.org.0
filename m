Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC0453225
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhKPMaX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:30:23 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:37670 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbhKPMaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:30:13 -0500
Received: by mail-lf1-f50.google.com with SMTP id c32so52765827lfv.4;
        Tue, 16 Nov 2021 04:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aalC5ofyXPHijBiHsgoqrQ/kcLW/eBv0HeQgHcvpoB4=;
        b=sUsbHyFqbILu2PLv6BuodPqDxhACAzW4ZqAdWF2IoTZ0iMLu9NWj2LWGkjSi/lmDYw
         RPXcbpTd+OhJhPOXv6vEZa8tX+QtzX9xwJcMcIWdB5qziqQQGVxusVyH4kBQTKtbk2kG
         utphzmrhi/r0fBEgxRrn0hlv5eKxXIcNfhz0RYVrPqtZfIik67gimWqIKDgooYuREkCc
         wpTDuaNG2n3NiCR6hYwRdqrWaBDri2VEu7Y0c4TVgw/cOxLwMm/SXJKSoB2h6PnBnz8G
         ZRjli3lxTUMwaPHEjUo1a47xO5P5oR91dlpZYO2VzBeAHRECg4/JgpfxSocaBXoLT5tz
         Jadg==
X-Gm-Message-State: AOAM531ahVOnqPdnrgX+JYDmB9MxdU5fMHob5E8poZDZDWyWZ41mfaqT
        qOAIvljqsI1NEpFbv/1d9ng=
X-Google-Smtp-Source: ABdhPJyulYjgXMfFelFdLJhLdwJWeX4lZBvTVo8ytXzSPMqyLcKBq8uKSLyz09uWLSILfxHjBI/hkQ==
X-Received: by 2002:a05:6512:3f87:: with SMTP id x7mr6109171lfa.5.1637065634734;
        Tue, 16 Nov 2021 04:27:14 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id t15sm1745407lfp.181.2021.11.16.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:27:14 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:27:07 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH v3 5/9] power: supply: Add constant battery aging
 degradation to batinfo
Message-ID: <bb0b356c62c6f3460ce77b29ada02443c73c7545.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IgY2wZq3Ky+lhnqF"
Content-Disposition: inline
In-Reply-To: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--IgY2wZq3Ky+lhnqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Few batteries can be modelled to degrade at constant rate for each
increased cycle. Add degradation constant for such simple model to
batinfo.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
RFCv3: New patch
---
 drivers/power/supply/power_supply_core.c | 3 +++
 include/linux/power_supply.h             | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index 47176ed2570b..ebc961b5aa45 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -639,6 +639,7 @@ int power_supply_dev_get_battery_info(struct device *de=
v,
 	info->resist_table =3D NULL;
 	info->temp_dgrd_values =3D 0;
 	info->temp_dgrd =3D NULL;
+	info->degrade_cycle_uah =3D 0;
=20
 	for (index =3D 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
 		info->ocv_table[index]       =3D NULL;
@@ -689,6 +690,8 @@ int power_supply_dev_get_battery_info(struct device *de=
v,
 			dev_warn(dev, "%s unknown battery type\n", value);
 	}
=20
+	fwnode_property_read_u32(battery_node, "degrade-cycle-microamp-hours",
+			     &info->degrade_cycle_uah);
 	fwnode_property_read_u32(battery_node, "energy-full-design-microwatt-hour=
s",
 			     &info->energy_full_design_uwh);
 	fwnode_property_read_u32(battery_node, "charge-full-design-microamp-hours=
",
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ef7db73a5bd1..c5118265b3ab 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -403,6 +403,7 @@ struct power_supply_battery_info {
 	int resist_table_size;
 	int temp_dgrd_values;
 	struct power_supply_temp_degr *temp_dgrd;
+	int degrade_cycle_uah;
 };
=20
 extern struct atomic_notifier_head power_supply_notifier;
--=20
2.31.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--IgY2wZq3Ky+lhnqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGTo5sACgkQeFA3/03a
ocUYGQf+Kv5VRahcwlJ8Sh+jXLh9aFrECMvUx7+rclW34icocREQhwVhKPbpafER
JckMVw3U3vScEEQlVP4AifhyaipNmDvwIM6hd44NvYSa+2q0rVZmMXrO52RnH65y
YgFlp7/FHyVRecZFAeCSn8PE8K+vt+8q3QfEKVXnjJxjalMMqsV6iGWCWYy5PxgQ
/lqFht6r8iDyuvI81ou5Dgzk+34C+h116jI5d5T7CAjR6pAZI6P6eV/3aDyWEyvw
F7/d/puNwJAKYx4jbqnq8BEMjtmuJq/RUYT8K/cfgbY0LKoYBQiOOKScZ1vvzNtV
dILAq2JGNDW6O6exMWdHmW0fd/UIVg==
=iyvR
-----END PGP SIGNATURE-----

--IgY2wZq3Ky+lhnqF--
