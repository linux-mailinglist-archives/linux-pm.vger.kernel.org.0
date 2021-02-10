Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A5316981
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 15:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBJOzL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 09:55:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45259 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBJOzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 09:55:10 -0500
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1l9qso-0004t6-UH
        for linux-pm@vger.kernel.org; Wed, 10 Feb 2021 14:54:23 +0000
Received: by mail-ed1-f70.google.com with SMTP id i13so2764056edq.19
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 06:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version;
        bh=nfyFoWCo/Kwfnzk1yyKEOTaVVVvNSCCjdge8fEx/uvs=;
        b=TTWD6cK5ha/1NcDYK84zfwO0fvExmrIGLl6RLpY65RRKpRBTGu78BUU8yPXeVS9+8m
         oj+svPoVSaUTQv+uqRQpM44XS4u23p9Fsy2XakSMwvJmsQpeGWvyuaj3RU/UqXvhAj1A
         Pzf4bB+lyo+ITmQLmB12NrgxBioPx4BjTgidgmFpPljqaoiTo8w/CelkLNtI0Me0pUL9
         DZAPLMyZelbayr9YXDjsG1IvCnelHxWUaMRrmaoMMQQKBGHHO/z7faS+tT7DfzrGZdXG
         sSZ5Jg+ngogzZSRHThulR+bKPC/0CxOPKvNJ52YTbhgzEDtKAMdDF7w79SR+Uo7YjO3x
         30qA==
X-Gm-Message-State: AOAM533ocleAcVFYHPedc+1veMmpguoKMMWg36ol3CWG+K9iKFOnZ/5i
        TyWpmLeQonVKsHFq+S+auKko1zLLebDb7ONhfv2cciwv50Bh00lSfyX99OPgCJaoVw3d27MrU/n
        w9XnVedvCUKIyh8GWHVwGybKXzTJUPGi9gZxk
X-Received: by 2002:a05:6402:12d6:: with SMTP id k22mr3430295edx.368.1612968862602;
        Wed, 10 Feb 2021 06:54:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwB1wNGDpBQH7qGVzBocSaL3ap1jQHZUbQIWRVhCk5kTUttR+gb3tPKdAUH5WNSc9q1ie/uLg==
X-Received: by 2002:a05:6402:12d6:: with SMTP id k22mr3430282edx.368.1612968862366;
        Wed, 10 Feb 2021 06:54:22 -0800 (PST)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id m22sm1199482edp.63.2021.02.10.06.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 06:54:21 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
Date:   Wed, 10 Feb 2021 15:54:19 +0100
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.con>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous
 SError Interrupt
Message-ID: <20210210155419.629c18c7@gollum>
In-Reply-To: <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
References: <20210210114829.2915de78@gollum>
        <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
Organization: Canonical Ltd
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QK_IdScLWFGHcLwGytf2dc6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/QK_IdScLWFGHcLwGytf2dc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Feb 2021 14:15:46 +0100
Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:

> [ Add Robin, Catalin and Florian in case they want to chime in ]
>=20
> Hi Juerg, thanks for the report!
>=20
> On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote:
> > Trying to dump the BCM2711 registers kills the kernel:
> >=20
> > # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
> > 0-efc
> > # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers=20
> >=20
> > [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError =20
>=20
> So ESR's IDS (bit 24) is set, which means it's an 'Implementation Defined
> SError,' hence IIUC the rest of the error code is meaningless to anyone o=
utside
> of Broadcom/RPi.
>=20
> The regmap is created through the following syscon device:
>=20
> 	avs_monitor: avs-monitor@7d5d2000 {
> 		compatible =3D "brcm,bcm2711-avs-monitor",
> 			     "syscon", "simple-mfd";
> 		reg =3D <0x7d5d2000 0xf00>;
>=20
> 		thermal: thermal {
> 			compatible =3D "brcm,bcm2711-thermal";
> 			#thermal-sensor-cells =3D <0>;
> 		};
> 	};
>=20
> I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> range =
is
> full of addresses that trigger this same error. Also note that as per Flo=
rian's
> comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But from what=
 I can
> tell, at least 0x7d5d22b0 seems to be faulty too.
>=20
> Any ideas/comments? My guess is that those addresses are marked somehow as
> secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ultimate=
ly,
> the solution is to narrow the register range exposed by avs-monitor to wh=
atever
> bcm2711-thermal needs (which is ATM a single 32bit register).

Yeah, that's what I tried but wasn't sure if that's the correct approach or
if there was something wrong with the DTB (which I know virtually nothing
about).

With [1] I get seemingly the correct behavior:

# cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2200/range=20
0-0
# cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2200/registers=20
0: 000106fa
# cat /sys/class/thermal/thermal_zone0/temp=20
39433

On a different note, how did you come up with that address range in the DTB?
Is that public information?

...Juerg


[1]
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 4847dd305317..a7059967aab1 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -65,10 +65,10 @@ gicv2: interrupt-controller@40041000 {
                                                 IRQ_TYPE_LEVEL_HIGH)>;
                };
=20
-               avs_monitor: avs-monitor@7d5d2000 {
+               avs_monitor: avs-monitor@7d5d2200 {
                        compatible =3D "brcm,bcm2711-avs-monitor",
                                     "syscon", "simple-mfd";
-                       reg =3D <0x7d5d2000 0xf00>;
+                       reg =3D <0x7d5d2200 0x4>;
=20
                        thermal: thermal {
                                compatible =3D "brcm,bcm2711-thermal";
diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/b=
roadcom/bcm2711_thermal.c
index 67c2a737bc9d..3b5a84402b89 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -22,7 +22,7 @@
=20
 #include "../thermal_hwmon.h"
=20
-#define AVS_RO_TEMP_STATUS             0x200
+#define AVS_RO_TEMP_STATUS             0x0 /* address 0x7d5d2200 */
 #define AVS_RO_TEMP_STATUS_VALID_MSK   (BIT(16) | BIT(10))
 #define AVS_RO_TEMP_STATUS_DATA_MSK    GENMASK(9, 0)




> Regards,
> Nicolas
>=20
> [1] https://lore.kernel.org/linux-pm/82125042-684a-b4e2-fbaa-45a393b2ce5e=
@gmx.net/
>=20
> > [   62.857671] CPU: 1 PID: 478 Comm: cat Not tainted 5.11.0-rc7 #4
> > [   62.857674] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> > [   62.857676] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=3D--)
> > [   62.857679] pc : regmap_mmio_read32le+0x1c/0x34
> > [   62.857681] lr : regmap_mmio_read+0x50/0x80
> > [   62.857682] sp : ffff8000105c3c00
> > [   62.857685] x29: ffff8000105c3c00 x28: 0000000000000014=20
> > [   62.857694] x27: 0000000000000014 x26: ffffd2ea1c2060b0=20
> > [   62.857699] x25: ffff4e34408ecc00 x24: 0000000000000efc=20
> > [   62.857704] x23: ffff8000105c3e20 x22: ffff8000105c3d3c=20
> > [   62.857710] x21: ffff8000105c3d3c x20: 0000000000000014=20
> > [   62.857715] x19: ffff4e344037a900 x18: 0000000000000020=20
> > [   62.857720] x17: 0000000000000000 x16: 0000000000000000=20
> > [   62.857725] x15: ffff4e3447ac40f0 x14: 0000000000000003=20
> > [   62.857730] x13: ffff4e34422c0000 x12: ffff4e34422a0046=20
> > [   62.857735] x11: ffffd2ea1c8765e0 x10: 0000000000000000=20
> > [   62.857741] x9 : ffffd2ea1b9495a0 x8 : ffff4e34429ef980=20
> > [   62.857746] x7 : 000000000000000f x6 : ffff4e34422a004b=20
> > [   62.857751] x5 : 00000000fffffff9 x4 : 0000000000000000=20
> > [   62.857757] x3 : ffffd2ea1b949550 x2 : ffffd2ea1b949330=20
> > [   62.857761] x1 : 0000000000000014 x0 : 0000000000000000=20
> > [   62.857767] Kernel panic - not syncing: Asynchronous SError Interrupt
> > [   62.857770] CPU: 1 PID: 478 Comm: cat Not tainted 5.11.0-rc7 #4
> > [   62.857773] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> > [   62.857775] Call trace:
> > [   62.857777]  dump_backtrace+0x0/0x1e0
> > [   62.857778]  show_stack+0x24/0x70
> > [   62.857780]  dump_stack+0xd0/0x12c
> > [   62.857782]  panic+0x168/0x370
> > [   62.857783]  nmi_panic+0x98/0xa0
> > [   62.857786]  arm64_serror_panic+0x8c/0x98
> > [   62.857787]  do_serror+0x3c/0x6c
> > [   62.857789]  el1_error+0x78/0xf0
> > [   62.857791]  regmap_mmio_read32le+0x1c/0x34
> > [   62.857793]  _regmap_bus_reg_read+0x24/0x30
> > [   62.857795]  _regmap_read+0x6c/0x17c
> > [   62.857797]  regmap_read+0x58/0x84
> > [   62.857799]  regmap_read_debugfs+0x138/0x3f4
> > [   62.857801]  regmap_map_read_file+0x34/0x40
> > [   62.857803]  full_proxy_read+0x6c/0xc0
> > [   62.857805]  vfs_read+0xb8/0x1e4
> > [   62.857807]  ksys_read+0x78/0x10c
> > [   62.857809]  __arm64_sys_read+0x28/0x34
> > [   62.857811]  el0_svc_common.constprop.0+0x7c/0x194
> > [   62.857813]  do_el0_svc+0x30/0x9c
> > [   62.857814]  el0_svc+0x20/0x30
> > [   62.857816]  el0_sync_handler+0x1a4/0x1b0
> > [   62.857818]  el0_sync+0x174/0x180
> > [   62.857842] SMP: stopping secondary CPUs
> > [   62.857845] Kernel Offset: 0x52ea0b080000 from 0xffff800010000000
> > [   62.857847] PHYS_OFFSET: 0xffffb1cc00000000
> > [   62.857849] CPU features: 0x00240022,61806000
> > [   62.857851] Memory Limit: none
> >=20
> > Sprinkling printks around regmap_read [1] shows that reading from 0x14 =
(20)
> > seems to cause the issue:
> >=20
> >=20
> > [   40.456230] map=3Dffff020a069c9c00, from=3D0, to=3D3836, count=3D131=
072
> > [   40.462520] map=3Dffff020a069c9c00, i=3D0
> > [   40.466319] ret=3D0, val=3D0
> > [   40.468922] map=3Dffff020a069c9c00, i=3D4
> > [   40.472684] ret=3D0, val=3D0
> > [   40.475292] map=3Dffff020a069c9c00, i=3D8
> > [   40.479048] ret=3D0, val=3D0
> > [   40.481649] map=3Dffff020a069c9c00, i=3D12
> > [   40.485492] ret=3D0, val=3D0
> > [   40.488080] map=3Dffff020a069c9c00, i=3D16
> > [   40.491922] ret=3D0, val=3D0
> > [   40.494523] map=3Dffff020a069c9c00, i=3D20
> > [   40.498497] SError Interrupt on CPU0, code 0xbf000002 -- SError
> > [   40.498499] CPU: 0 PID: 486 Comm: cat Not tainted 5.11.0-rc7+ #8
> > [   40.498501] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> >=20
> >=20
> > ...Juerg
> >=20
> > [1]
> > diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap=
/regmap-debugfs.c
> > index ff2ee87987c7..9465f5a2f3b8 100644
> > --- a/drivers/base/regmap/regmap-debugfs.c
> > +++ b/drivers/base/regmap/regmap-debugfs.c
> > @@ -229,6 +229,7 @@ static ssize_t regmap_read_debugfs(struct regmap *m=
ap, unsigned int from,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (count > (PAGE_SIZE =
<< (MAX_ORDER - 1)))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0count =3D PAGE_SIZE << (MAX_ORDER - 1);
> > =C2=A0
> >=20
> > +       printk("map=3D%px, from=3D%d, to=3D%d, count=3D%ld\n", map, fro=
m, to, count);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buf =3D kmalloc(count, =
GFP_KERNEL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!buf)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > @@ -253,7 +254,9 @@ static ssize_t regmap_read_debugfs(struct regmap *m=
ap, unsigned int from,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
buf_pos +=3D map->debugfs_reg_len + 2;
> > =C2=A0
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
/* Format the value, write all X if we can't read */
> > +                       printk("map=3D%px, i=3D%d\n", map, i);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ret =3D regmap_read(map, i, &val);
> > +                       printk("ret=3D%ld, val=3D%x\n", ret, val);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (ret =3D=3D 0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(buf + buf_pos, cou=
nt - buf_pos,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0"%.*x", map->debugfs_val_len, val);
> >  =20
>=20
>=20
>=20


--Sig_/QK_IdScLWFGHcLwGytf2dc6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmAj85sACgkQD9OLCQum
QreFGA/8DG+tfhEqw1PfjIJFLFWhYyFCc+fo9hCSKuhCbGsHBYb+MeQTMgpgRJum
Vm8jhIU1v9H98G+ZNXz+irgcr6lkGbQ9uo64bMr3UzITOVeYf72uzQbC8TBM5Qix
azgj3Rt68fniwsIAghz47TUZtzr4TA8FSjNn31pt9NiH3KTVUp5ezsxOH3baBa2z
zCv+sumdQb8Hx7GPAWTfIaWyaCbUo95sVi4kR2Thu7AvJumN4aCL1LpjJTP9wanj
STSOE5Bmxy9RCGY9HDKwKSUrNgbG/bjmQefXMXbpJGfUjH89z1izhEZy9qSoa006
n3VYiGbmD/l6AbrN5A+UicP7EuIprQQXStDpfvf7WAQXGGM4CZNj65N8hII5N/x+
3+nPh6H/qWTyFKUXr1WQoeSioMgynYwaqAaFz6QKkFrAFoZETOzWpQWGuVXtRF/E
yWqMAqx1UaaltKV2DCsa0V8hARc+gW7ttsAFQVEo1GNJERrxoHtZe5Cf9BkzVdq/
kELc3jTYAlmsRffUpdTLLwhGbUWbviuFwN58hCv442lvLwnn+anuC8eudYnajT/c
bRfAXRrR51Wl80aXqRWBSpEBpivBSuN2HevGGn2iVQozjjLfeJDdrsfJs7SRRLRT
yXhsQjIZdQcry8C7psU99onf0C+oI56zDDbZYIhl+o9iOm5BKX0=
=JdOS
-----END PGP SIGNATURE-----

--Sig_/QK_IdScLWFGHcLwGytf2dc6--
