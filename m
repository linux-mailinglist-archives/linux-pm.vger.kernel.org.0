Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00D6FC105
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjEIHzs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 03:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjEIHzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 03:55:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440B3100D8
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 00:54:33 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F9B56603276;
        Tue,  9 May 2023 08:54:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683618863;
        bh=fa0orNCQbdWnMh/CgkjAqe9Q8G4tEY0NpX/qhNkaGBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arLVw8qtUnA+2cpRnk+mCEjF19r9hXHcqxUhNctCOrXQOcCHyP47WKG5toaL361b/
         huoItxtDCdoMX0uIUXp8jKZ1yDyoEJj2mA0tL8O0OLMpyh0rtYXgrlwO4FjXXUPK3I
         eMCRP0xR/2iU8RqyU0KKmf2LwJZZhCb2ljm4J/A75BSnGboBGZongpt2UMQrt2YgQt
         BLwTumCezfRCdvJDXXp1hZ0X7dphdvWwArmEB/bxJHFMNdJZi7tVRgDlDE3L+TUxEC
         HD0mjp36NU1O6IFBGm/ydsib0ewZIMRblexPv0Rpuzjk08Ld4Km5xAsB/xNaObIiuB
         uXn/USIjfR62w==
Received: by mercury (Postfix, from userid 1000)
        id 7ABA61066FA2; Tue,  9 May 2023 09:54:20 +0200 (CEST)
Date:   Tue, 9 May 2023 09:54:20 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     chenhuacai@kernel.org, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] power: supply: Fix power_supply_get_battery_info() if
 parent is NULL
Message-ID: <20230509075420.nvv4j6patiibbmer@mercury.elektranox.org>
References: <20230509024448.1322898-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ukqottstepv4mtj"
Content-Disposition: inline
In-Reply-To: <20230509024448.1322898-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7ukqottstepv4mtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 09, 2023 at 10:44:48AM +0800, Huacai Chen wrote:
> After commit 27a2195efa8d26447c ("power: supply: core: auto-exposure
> of simple-battery data") we call power_supply_get_battery_info() in
> __power_supply_register(), but it causes test_battery crash with NULL
> pointer:
>=20
> [    7.524846] __power_supply_register: Expected proper parent device for=
 'test_battery'
> [    7.524856] CPU 3 Unable to handle kernel paging request at virtual ad=
dress 0000000000000278, era =3D=3D 9000000002fb279c, ra =3D=3D 900000000317=
3434
> [    7.524862] Oops[#1]:
> [    7.524866] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.3.0+ #524
> [    7.524870] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loon=
gson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/=
2022
> [    7.524872] pc 9000000002fb279c ra 9000000003173434 tp 90000001001f000=
0 sp 90000001001f3c00
> [    7.524875] a0 0000000000000000 a1 0000000000000000 a2 000000000000000=
0 a3 9000000004553e13
> [    7.524878] a4 9000000004553e16 a5 ffffffffffffffff a6 9000000003fd094=
8 a7 0000000000000030
> [    7.524881] t0 9000000003173434 t1 90000000035e2c00 t2 000000000000000=
1 t3 00000000fffff2b0
> [    7.524883] t4 0000000000000007 t5 fffffffffffffffe t6 000000000000000=
0 t7 0000000000000010
> [    7.524886] t8 00000000000000b4 u0 00000001c0840c76 s9 000000000000000=
0 s0 0000000000000000
> [    7.524889] s1 900000000370c458 s2 0000000000000001 s3 9000000101f8100=
0 s4 9000000101f81038
> [    7.524891] s5 9000000101f813a0 s6 900000000370c398 s7 9000000003eebd1=
8 s8 90000000037c0070
> [    7.524894]    ra: 9000000003173434 power_supply_get_battery_info+0xe4=
/0x710
> [    7.591224]   ERA: 9000000002fb279c __dev_fwnode+0x8/0x20
> [    7.853583]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -WE)
> [    7.859740]  PRMD: 00000004 (PPLV0 +PIE -PWE)
> [    7.864073]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> [    7.868839]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> [    7.873430] ESTAT: 00010000 [PIL] (IS=3D ECode=3D1 EsubCode=3D0)
> [    7.878884]  BADV: 0000000000000278
> [    7.882346]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
> [    7.888056] Modules linked in:
> [    7.891088] Process swapper/0 (pid: 1, threadinfo=3D0000000091357ee8, =
task=3D00000000313d98cb)
> [    7.899307] Stack : 00000000000000b4 900000000279aca8 0000000000000001=
 0000000000000000
> [    7.907274]         0000000000000049 0000000000000408 9000000100008c00=
 90000000035b6370
> [    7.915238]         900000000b801080 90000000029a440c 9000000003eb4680=
 9000000003eb4680
> [    7.923202]         9000000101f81038 900000000357cdcc 0000000000000001=
 900000000370c458
> [    7.931166]         9000000101f81000 90000000037c0070 9000000003eebd18=
 900000000370c398
> [    7.939131]         90000000045f4530 9000000101f81038 0000000000000000=
 0000000000000001
> [    7.947095]         900000000370c458 9000000101f81000 0000000000000000=
 9000000003173e64
> [    7.955059]         0000000000000026 9000000003de3880 9000000100562040=
 900000000357e07c
> [    7.963023]         000000000000026f 0000000000000001 90000001001f3d68=
 fffffffffffffff5
> [    7.970987]         90000000036d2ca8 90000000027429d8 90000000037c0030=
 0000000000000001
> [    7.978951]         ...
> [    7.981379] Call Trace:
> [    7.981382] [<9000000002fb279c>] __dev_fwnode+0x8/0x20
> [    7.988916] [<9000000003173434>] power_supply_get_battery_info+0xe4/0x=
710
> [    7.995666] [<9000000003173e64>] __power_supply_register+0x404/0x580
> [    8.001984] [<900000000379d368>] test_power_init+0x6c/0x124
> [    8.007527] [<90000000026e08f8>] do_one_initcall+0x58/0x1ec
> [    8.013066] [<9000000003761614>] kernel_init_freeable+0x290/0x310
> [    8.019127] [<90000000035b40e8>] kernel_init+0x24/0x11c
> [    8.024324] [<90000000026e2048>] ret_from_kernel_thread+0xc/0xa4
> [    8.030295]
> [    8.031769] Code: 4c000020  0015002c  03400000 <28c9e08c> 40000d80  02=
c06184  4c000020  28ca0084  4c000020
>=20
> Root cause: psy->dev.parent is NULL in power_supply_get_battery_info(),
> so change the else branch to be 'else if (psy->dev.parent)' and return
> -ENOENT if psy->dev.parent is NULL.
>=20
> Fixes: 27a2195efa8d26447c ("power: supply: core: auto-exposure of simple-=
battery data")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

Thanks, queued to power-supply's fixes branch.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index ab986dbace16..d1b19027f53b 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -573,7 +573,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  	struct power_supply_battery_info *info;
>  	struct device_node *battery_np =3D NULL;
>  	struct fwnode_reference_args args;
> -	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *fwnode =3D NULL;
>  	const char *value;
>  	int err, len, index;
>  	const __be32 *list;
> @@ -585,7 +585,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  			return -ENODEV;
> =20
>  		fwnode =3D fwnode_handle_get(of_fwnode_handle(battery_np));
> -	} else {
> +	} else if (psy->dev.parent) {
>  		err =3D fwnode_property_get_reference_args(
>  					dev_fwnode(psy->dev.parent),
>  					"monitored-battery", NULL, 0, 0, &args);
> @@ -595,6 +595,9 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		fwnode =3D args.fwnode;
>  	}
> =20
> +	if (!fwnode)
> +		return -ENOENT;
> +
>  	err =3D fwnode_property_read_string(fwnode, "compatible", &value);
>  	if (err)
>  		goto out_put_node;
> --=20
> 2.39.1
>=20

--7ukqottstepv4mtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRZ/CcACgkQ2O7X88g7
+prqpg/+OIQ4ewvcuU5PP7h03iMilUcAbdQGXw70UPZ3BU8Lz6aCRRYrkH3JpCKF
NLYILKudUldlknOa+zIVNe6FenVNaFhPbO+W0Gb/oJiWoRIuBS3miPTh7jG+TMVU
bLuI1HN1Mozis+fj8Q0KOAf6mwqkTi5HRDaVc5vN/qt8UtI3f1tVm2rc9dExxoaV
k9+izJ13gHJIKvrjFfxxKM3OHy+lY+CJ14o/JbZflLjw9Lm+P1Zjux8T7aCGOM6F
VQnQ2OR+AzS1dZ2ppZi6ITEqh3+HBmNzfP97Hgw7Ns00JImtPErzeJresGJUaPD4
WqYdVPg+5H16apvf622/OSe5FFdKjeaYI5DGd30u9mnt1lLPQJv2pWYlK8Ab/j8G
Q4+1nTt4T1rocd4zhbcPkJ8eNdkcLPXpp1JdKpBL777VE8rzT9Pva4rRbUImTYBs
nOw2lEKNc2qxWD78CfyiI8lZTTYGRPv9DNkKP9Q9ANJG3S5ohPNhKqAG4xyH89d8
PZ12ijwYWMIRw68sA5AEYLp/8VTOQK6W3HBwEAbhUbubz6ocALwj2oaFzF0jQpgJ
/4GV2MdvCz5jdLKFcTzgpY2Jz0ZmFGGfpqh/ASen3ZBf+8hd8p3iolqWBh0iNFH1
XUtd9T2u/GMUj/TY7nW4TR+JVfmxo/FmE7Aw2MoOvIp1t73SxNk=
=iQXH
-----END PGP SIGNATURE-----

--7ukqottstepv4mtj--
