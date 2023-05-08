Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D036FB547
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjEHQhs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjEHQhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:37:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3166E9B
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:37:35 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6DCBB6605639;
        Mon,  8 May 2023 17:37:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563852;
        bh=ALDX0UWtMOObiDcp3CIAv40iG7XrAk/TI8UyrJ94KTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YT6annC2Q6eocy44PJnL/X8fxUvnoizovMPRuhXtTYIJL8Ury5ZvMDMhKsMJecS5F
         TnYkqh5/DbDt23wd/3zYsS8pAKW3Eea0U9TCIhbVxyluSO7FShiwa8xAhf2BGSbtKM
         jv5NP/toMNHCn/m1Ih02qkx24PnDmK94QMbUEfJ1U+elzGOZbIpvm7cquoed5zpUs9
         Dpxm+qxy+MzGI9eJnXx/Nnl3SvQjjOQM1DfwkIxTKjAv/9EAMJyJb7dFWbPmJdEwOb
         iQ0ihig6SYHiSFqsDQL2KhDJVoeX054WDAfSsYHclrEDiy9ws1gEUP3pWlPwUFUWjj
         iOZL6e7tSZZGQ==
Received: by mercury (Postfix, from userid 1000)
        id AB0EA1066FB3; Mon,  8 May 2023 14:11:40 +0200 (CEST)
Date:   Mon, 8 May 2023 14:11:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     linux-pm@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] power: supply: Get battery info only if
 psy->battery_info is not NULL
Message-ID: <20230508121140.ojwcrptgsz7de3jf@mercury.elektranox.org>
References: <20230504120636.2443331-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfzrlen7tinwg7md"
Content-Disposition: inline
In-Reply-To: <20230504120636.2443331-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mfzrlen7tinwg7md
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 04, 2023 at 08:06:36PM +0800, Huacai Chen wrote:
> After commit 27a2195efa8d26447c ("power: supply: core: auto-exposure
> of simple-battery data") we call power_supply_get_battery_info() in
> __power_supply_register(), but it causes test_battery crash with NULL
> pointer:
>=20
> [    7.524846] __power_supply_register: Expected proper parent device for=
 'test_battery'

So there is no parent device. That means the following will crash:

power_supply_get_battery_info()
  fwnode_property_get_reference_args
    dev_fwnode(psy->dev.parent)

Since there is no parent that translates to dev_fwnode(NULL) and that
crashes.

The proper fix is to change the else branch in
power_supply_get_battery_info() to be 'else if (psy->dev.parent)'.
Since that will leave fwnode uninitialized, it also needs to be
initialized to NULL at declaration time.

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
> Fix this by getting battery info only if psy->battery_info is not NULL.
>=20
> Fixes: 27a2195efa8d26447c ("power: supply: core: auto-exposure of simple-=
battery data")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/power/supply/power_supply_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index ab986dbace16..5da1b48a1477 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1392,7 +1394,7 @@ __power_supply_register(struct device *parent,
>  	 * some chargers accessing constant battery data, we only want to
>  	 * expose battery data to userspace for battery devices.
>  	 */
> -	if (desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY) {
> +	if (desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY && psy->battery_info) {

power_supply_get_battery_info() allocates the required memory
itself. NULL is the expected value at this point and your
patch is the same as removing the power_supply_get_battery_info()
call.

Greetings,

-- Sebastian

>  		rc =3D power_supply_get_battery_info(psy, &psy->battery_info);
>  		if (rc && rc !=3D -ENODEV && rc !=3D -ENOENT)
>  			goto check_supplies_failed;
> --=20
> 2.39.1
>=20

--mfzrlen7tinwg7md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY5vUACgkQ2O7X88g7
+pruxw/+J7+3LoSGanLwT5VLc1cxLJdYn+FElcLk83sBd/20h77+l/tR6wxoComj
5jFoLaRjELRE4SjUrNJxVvdxVY54kk0cavZnCJvHxbC4bH/BxMCSbWtUvFOssLyk
BWmtvjQM19RNoR3XL/XeUQdYSFJcKJoRSwnZBgBOO44tHpxqi4SPfKjlRA1t/Cw/
zPlTghR13qNIgt7wnzlsgIsnQb4NIurQJO6x8onfTWNfxnWElnYMmrJcIAkIzhqb
1mVY+MKP7Ia7n9wM/0XzHdydkzfuvR+ImG8IwKK1YGuFxv6uRorsw121lxvclSoF
HpSfDpxP8SxfhyN4xxotn3dTN7A9kTECS+PnI/Am0lNItGVxB8+kJUEB6me16PZh
pBY0h+OHnrdSlEv0OcPr6l2SME1S8ueJkSTB+FqeCjhXTp5fCH4sVfxMAt35xNNj
/QM793+CgTfCTvQgC4wRCpHIlqYyO5X/zxb1bKMhS4QqRSb/IFA/ewGGSIRwF4ig
7AfvqEmWMIY1QBZVsihsS454pcHqJf7tYdHv3mlYqP4sBxDOIiDqThX3hPR7Ij2q
MMX5E4S9WGmOc43XLk1ERDpXJRS3ZEdiXuH0GM29TcMBi4PpSaF+VYZaKG2Uqz1e
Rn8wS0A3XN9GMSIkmatYyJaP8IAej3RHawGre5lq0moU46VlOZA=
=HKW2
-----END PGP SIGNATURE-----

--mfzrlen7tinwg7md--
