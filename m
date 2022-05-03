Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B745188A9
	for <lists+linux-pm@lfdr.de>; Tue,  3 May 2022 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiECPjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 May 2022 11:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiECPjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 11:39:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EB42CCBF
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 08:35:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2EC1E1F4426F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651592131;
        bh=pjyzp+R74znsxiMCnsabT2Lt7s5vniGL1wQ/aYk4ItE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PN69FYsncL8YhlC+c8JjmfFYWXIozvxeW5BF8oKicYkaCwWY9qmaChPoxluAmxb7O
         zSQn0FUwpDGo0EdCd/HTGgEyu8Cicrpb0T/k6MzYF/taGFGPvAGAh/jwOLFziF42qZ
         Vv0Ocr8hgrWak4NJJr+8SGrPfTgGaiYvsM8tsLeGQ+UqVj+zZAkkognmuWEQNOZA5B
         y9HgXLNAWclhY1qLP8sU0B6im7egyk9L35MJsxm0WSM4UVs0TdvXdIbbb3gVVsed6b
         XaFG4b50J5wtqtCtLZh1unVCaT9r8Io9Tzj8T5+WXWENBuI+IWLU70P7/lild3KLCX
         9/WGGuFzdgWuA==
Received: by mercury (Postfix, from userid 1000)
        id 35FB21060430; Tue,  3 May 2022 17:35:29 +0200 (CEST)
Date:   Tue, 3 May 2022 17:35:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: axp288_fuel_gauge: Drop BIOS version
 check from "T3 MRD" DMI quirk
Message-ID: <20220503153529.l7zgpqrdqg4yh6nv@mercury.elektranox.org>
References: <20220502111235.331877-1-hdegoede@redhat.com>
 <20220502111235.331877-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zf7gj5dwdiy3cwdu"
Content-Disposition: inline
In-Reply-To: <20220502111235.331877-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zf7gj5dwdiy3cwdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 02, 2022 at 01:12:35PM +0200, Hans de Goede wrote:
> Some "T3 MRD" mini-PCs / HDMI-sticks without a battery use a different
> value then "5.11" for their DMI BIOS version field.
>=20
> Drop the BIOS version check so that the no-battery "T3 MRD" DMI quirk
> applies to these too.
>=20
> Fixes: 3a06b912a5ce ("power: supply: axp288_fuel_gauge: Make "T3 MRD" no_=
battery_list DMI entry more generic")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued to my fixes branch.

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index 5b8aa4a980cd..8e6f8a655079 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -609,7 +609,6 @@ static const struct dmi_system_id axp288_quirks[] =3D=
 {
>  			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
>  			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
>  			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
> -			DMI_MATCH(DMI_BIOS_VERSION, "5.11"),
>  		},
>  		.driver_data =3D (void *)AXP288_QUIRK_NO_BATTERY,
>  	},
> --=20
> 2.36.0
>=20

--zf7gj5dwdiy3cwdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJxS8AACgkQ2O7X88g7
+prB8w//UGCLJhQMVnxKBNLrrMzORVdg5YQLINYxP+e5gymbzk42IkYHOBjrXh0U
16g5ktpMOQjyccqSBlmYLw10kC2+7FAChXj4YTUkSByqVSNkayjQnhAI1Vp50LrT
xwwBVMYXsnkMsmbxgnhFQyNV2QRom6xgd/E46wWbJMK41X3RTG3csJlmVpYx/h1B
LA6XXFxyIKM51wMdd8Xb5F1LEvTzEYxPuj9MQyydszofvWOQWKDZMYNsJ8KIP0ef
JYCphZhcYSN92//3tPE7XBIaB2VGchGvrNp/5ZmFc/0J9w4Z5HyRyVPluEh4gOmC
Ql0L72HBvp/1SZf4ve7xkDdAps0aQMHt+rd5HOANDTAgnEkPoyzZObuHJkU04RNZ
NhWZrN0K6iImxEWweEVq/Lvkb7rFmVATqmbgQZV+KdavujDvQ/MTJ8crb4AGiREV
VaDq1gUcFN5xgrcxGrUNKiD6r/CTKbVvEFik1/ER63QzEtX8MX4eFl+R62pKtOmz
LbJxBXSm6gZN1mhjaa8Swg67YRtEPkEa4JqEIr/uLmZM3yVbQmH4JitwRZV2yJqy
iyKbPkGMxZQncStTbRJvT/pPs2kSPv9/obGbHpYurr3s5bdp6noDG/7vTYXASFC+
ZmALMsEnCZkoMThIjSnKWDPVPdm7IYatzunAZUsqS3/sWzCJAaM=
=M/id
-----END PGP SIGNATURE-----

--zf7gj5dwdiy3cwdu--
