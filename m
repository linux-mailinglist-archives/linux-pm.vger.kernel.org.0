Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505BA32E29D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 07:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCEG5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 01:57:01 -0500
Received: from mail-eopbgr70112.outbound.protection.outlook.com ([40.107.7.112]:31950
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229458AbhCEG5B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 01:57:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4AN5WbPIN9n+Gd6C00MA75kOj3NU72NwIiHd+w7B7WgIW643UtpftmNFmJ7cyKhRUUhP4F/WFvwE4Yxos3eaUzwmI9eeXik9UI62CPuFpWAOIosHWhEqjygBmjC2OEJL8OOlatflpabes6vGLcPj/eD3chu6jHM7FKfoGgyOc3vzcFQCEq1bwyIXNqz5qesFAL4AOP/7uQOGOLtmnRdURgbMhXuZ4UN+l7/laMSQL0xgxtQ5pMAAb24MgIt/FtmDbsflXuKj+8BSwHucnB7Eqg0EXbcwSlrh2pwjkzS37xgw7AOyr316SToWSIRMv54WMRw7BtMmb7BGVpGLcxbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWX9tiZkBtWrqUCZ0DHFBiGiD3NzrjtLwhhi1lGCSdQ=;
 b=iRola3GDFmBnT5owJpXrAa7SAbPOxMdDBKasynwuRbN7sPLtl9C9dhXMbnBwEGxFdRNmnfI/Y5DDvut9flfQh6WHWxTB4ZBSl80QPu1p3iLxl3TGFNYJ4vD5VMkt1PeeYqFh5Jrpnu59NH8nWP7PKe451shf6YxzNcrKNf7sn4ky3JIhUBrZfewdrApQ+NawwqbsWznYRRvseAeuuYRnyBhRW0nOEYGQ/4nns2sYAg0fvMWhGlpEcgfYnqCw3CecbMqlsJ9FbAHpiNfP54KGYI/c8g+8OeinKKB9nRbm1NpTaYu+y30lKSheRPHFWtP8+juOgL9tIMEVTrHyfxvDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWX9tiZkBtWrqUCZ0DHFBiGiD3NzrjtLwhhi1lGCSdQ=;
 b=HEKQ6jSIw3/zCwHmEBFrGTfsBNjTwB7LzSsCWMX/40zii8clI+Te81E7y+kIFMfhCZlA8Z+q54mjCv8zVC07uyqQtLkPbwi9jwSXiB8pIKF8Ja/zsgvnDzXMLOp/RmOwaWW9Yi36OW5dba8q8CNRIHwlgqtAu6y+kg7+hezFW1o=
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com (2603:10a6:10:70::20)
 by DB7PR06MB5979.eurprd06.prod.outlook.com (2603:10a6:10:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 06:56:44 +0000
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee]) by DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee%3]) with mapi id 15.20.3890.023; Fri, 5 Mar 2021
 06:56:43 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: RE: [PATCH V4 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Thread-Topic: [PATCH V4 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Thread-Index: AQHW+43zF4rTN+6HvEyXTT7OkSUGsKpxCUKAgAQXcsA=
Date:   Fri, 5 Mar 2021 06:56:42 +0000
Message-ID: <DB7PR06MB457181BA40EF557AB916DD75D7969@DB7PR06MB4571.eurprd06.prod.outlook.com>
References: <20210205071004.26317-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210205071004.26317-3-Qing-wu.Li@leica-geosystems.com.cn>
 <20210302162205.c3ovl3egujx67gmw@earth.universe>
In-Reply-To: <20210302162205.c3ovl3egujx67gmw@earth.universe>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none
 header.from=leica-geosystems.com.cn;
x-originating-ip: [140.207.15.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b96b2013-b956-4c00-0f9e-08d8dfa3d63d
x-ms-traffictypediagnostic: DB7PR06MB5979:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR06MB5979F33D43F7E44E88D9599BD7969@DB7PR06MB5979.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5/6+xMttAxS4MwTEJEXrQptI7wZRoC+YL7aGjGu0t93fcS6eTl4vVb7FfKldnH9euEiR1k2KU9r9ZvFUtCe0Nfu2re0Tv2XkV28YlS94PKzgP5QQ/7hglKDOhqIcks8P6L3uL2dFSWQlhfvJJzH3jKcAMftzSZp3/uE6GZ55eL8JhRrLZfYKUz9tIV86KLmtnYORCoMYQT6mu/u3V8zCwpt3ux06G6gIKws71Vmu7u/QgYatPlGycgZsy4Ohbtd2a8ZoCEBKjNSe1htgto/+pWzZvzzVbvZmt2ubN+JDnFuNRiMZ8AqS1agzJx+i+L7gjfgUYRhv+hr048GLB412IbLDmLpXccgf1pDRL6fbNvaR9EF0IHouuI4TmwLNZBIL9xiTJ/lNHQU1q7HdhX8JZyj3hwa8nUyM1EG4XrfWnZVi2Ib52h8GyGFcB+NQlOeqD+rSKsRunHBPyFaWcdq2hs1uI2ljkAdauWruLXwjxKF33jEWtlJOxtRlGgz75hV7KKQrrVBYFf649k6bm6qTnIx+bP1GggeCsRKlBmKx1OX+uwDSZyC9+/Sv3e4zRPhUPPtDNuacWGOjGM+w3WyD07Gu+dt/OXFyr9W20B8E1c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB4571.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(346002)(376002)(366004)(396003)(5660300002)(966005)(71200400001)(8676002)(8936002)(4326008)(33656002)(66476007)(107886003)(66556008)(64756008)(76116006)(66946007)(54906003)(66446008)(9686003)(83380400001)(52536014)(86362001)(186003)(7696005)(2906002)(26005)(53546011)(316002)(6506007)(55016002)(6916009)(478600001)(15974865002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?V6+tHLiW4GJtmAzf4ncgwm+j3QSTUJk8j6H4W/2zyyqcOa8FCovknyREjd2i?=
 =?us-ascii?Q?23Yd9zyInPRucqzGNmTp9OTc3l/Oh9CUYGfFdEpcuQGQ4lQhog6VzHPTuTsX?=
 =?us-ascii?Q?GDR/fyGbrIc+2+6ULlHIFTvo9yvfs8uyTqLAhdvPexiGHm9pVLeOHKtF4/zR?=
 =?us-ascii?Q?w800WsPFUw8VofvGHWM6FG5cArul3GMrPvxipck7WquY2cHH6I3Qf3AiIMos?=
 =?us-ascii?Q?vA3BOEOi4TSWRjdDXMbRnrB9dpzieM0qZoVdUU51CTFeV66mid6sKayI2XkH?=
 =?us-ascii?Q?s0YCks/3dlAJHCoetqZn2SKUD0zb8E4/8MDhFseIrKzuH5WcogihwDqyEGvQ?=
 =?us-ascii?Q?ppf+fz2tLvaKhSkLinQLQGi7PIZMWlu5GW9xdB9aLVZPGAG4ve9/9x9fNo43?=
 =?us-ascii?Q?dvAiduv05cB89n945ucjvJXTcU0p39LO/G/o+L2reNHcOXE6EVdVWggC3dLY?=
 =?us-ascii?Q?C3f0v6YnDfqz2lAiv0nF4jtm9OgEUw+hz33K+UP8q+1bFqOj6AwV3qW4GZPp?=
 =?us-ascii?Q?wc/FtwZl5F7eYcuthkPHCNaJpt7wCETowgOuOAMJSCZ4xVtMMaj5v008b/U2?=
 =?us-ascii?Q?Y/9B6UCMJi9puQk9bMsVWPIyVYbCP0OW2tSkPHlXIXHviSq4xcYf7wZ8PTM2?=
 =?us-ascii?Q?jafspxA/p3CHnRQoeW3A+fW1JwVHnExSyjmxEBwDAacYK/tMnZFc0FDV4vk+?=
 =?us-ascii?Q?H+Hqcq90NnBy0JPPudizhKMVR8E2/Asjpd5ampuFzbkTq5jyQbBUN5oonCUx?=
 =?us-ascii?Q?molowpToy5alDhfqoM9kCI8Etet0wbLzGv6iI+A28bEUQdaFcqbgWWc2zTcY?=
 =?us-ascii?Q?sr1RKaY6wsxGIBzwWPbRtSTlQ+v3Ck+bOXGvsbyptSAfrCpWL5rrDJIhXUiz?=
 =?us-ascii?Q?RWJMClxpmSwAt6r2RlVkMGvu42aun/27N7LiSbNIvm706Tge7q3huyPaTAWy?=
 =?us-ascii?Q?Ev1LI4WOBfm8hgYyWt4cbFhtXIVRtnfcAmVUj43Zc1AEcP0RfPnO0ADr6DP+?=
 =?us-ascii?Q?C/NHv60HTFCPEwcoEZNUEjJkdv9WV6/0F6Q8zDSwbpapujmhYY4ZKvMgC13M?=
 =?us-ascii?Q?hgBDiED610TjjZ80Yn/hTIoGBHL9+x1xmEmzKPwX/9OukvXbnWDSButJq6Ig?=
 =?us-ascii?Q?YtsBwv6pbRhfscxB2JCAyQTnxuo40GRfNRe64d9nJ3aJ8Pv+KbQy7g04ukLo?=
 =?us-ascii?Q?DuyvX+FO07K0nBvw3k8uoSnVuKN4mX5weW1CZg1iMb3+Z2vBgGwvGh9RKutQ?=
 =?us-ascii?Q?rsVqRKWMRaSxNQXBOaqdtGGbTYHHdLcUa5uUkiaPRNTa/fPqF7ybXaqp0sN4?=
 =?us-ascii?Q?DNrHgdZOv8RXTu5O/IAQFpWL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB4571.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96b2013-b956-4c00-0f9e-08d8dfa3d63d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 06:56:43.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENaHCjLgrTJ5mpDqO0AlNStutp1YzJZTkUv8chqOgkYCtCP5gt12RasHKFNxmLJL7dmsS3KcUWFq98hFwa2LDv9EfmdpFxR/qrQMHdrUEcVsjTFX7kltBcpr+r3g7abr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5979
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

Thanks a lot for your input, I changed according your input in PATCH V5, pl=
ease review.
About "why 0x00000000 instead of just '0' like in the other entries?", sinc=
e I got an error from checkpatch.pl.

ERROR: space prohibited before that ',' (ctx:WxW)
#100: FILE: drivers/power/supply/bq27xxx_battery.c:1015:
+       [BQ78Z100]  =3D BQ27XXX_DATA(bq78z100,  0         , BQ27Z561_O_BITS=
),
                                                        ^




Best Regards

**********************************************
Li Qingwu (Terry)
Senior Embedded Software Engineer=20
Leica Geosystems(Shanghai)Co.,Limited
(Tel): +86 21 61061036
(FAX): +86 21 61061008
(Mobile): +86 187 0185 9600
E-mail: Qing-wu.Li@leica-geosystems.com.cn
Http: www.leica-geosystems.com.cn
**********************************************

-----Original Message-----
From: Sebastian Reichel <sebastian.reichel@collabora.com>=20
Sent: Wednesday, March 3, 2021 12:22 AM
To: LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc: robh+dt@kernel.org; dmurphy@ti.com; pali@kernel.org; krzk@kernel.org; l=
inux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kern=
el.org; TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>; ZHI=
ZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH V4 2/2] power: supply: bq27xxx: Add support for BQ78Z10=
0

Hi,

On Fri, Feb 05, 2021 at 07:10:04AM +0000, LI Qingwu wrote:
> Add support for TI BQ78Z100, I2C interface gas gauge.
> It provides a fully integrated safety protection and authentication=20
> for 1 to 2-series cell Li-Ion and Li-Polymer battery packs.
>=20
> The patch was tested with BQ78Z100 equipment.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 46 +++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c=20
> b/drivers/power/supply/bq27xxx_battery.c
> index 315e0909e6a4..c8579ec7a4f8 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -39,6 +39,7 @@
>   * https://www.ti.com/product/bq27z561
>   * https://www.ti.com/product/bq28z610
>   * https://www.ti.com/product/bq34z100-g1
> + * https://www.ti.com/product/bq78z100
>   */
> =20
>  #include <linux/device.h>
> @@ -497,7 +498,27 @@ static u8
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D 0x22,
>  		BQ27XXX_DM_REG_ROWS,
> -	};
> +	},
> +	bq78z100_regs[BQ27XXX_REG_MAX] =3D {
> +		[BQ27XXX_REG_CTRL] =3D 0x00,
> +		[BQ27XXX_REG_TEMP] =3D 0x06,
> +		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> +		[BQ27XXX_REG_VOLT] =3D 0x08,
> +		[BQ27XXX_REG_AI] =3D 0x14,
> +		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> +		[BQ27XXX_REG_TTE] =3D 0x16,
> +		[BQ27XXX_REG_TTF] =3D 0x18,
> +		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,

Datasheet states StandbyTimeToEmpty =3D 0x1C?

> +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,

missing BQ27XXX_REG_RC. Looks like chip has support for it at address 0x10.

> +		[BQ27XXX_REG_FCC] =3D 0x12,
> +		[BQ27XXX_REG_CYCT] =3D 0x2a,
> +		[BQ27XXX_REG_AE] =3D 0x22,

REG_AE is available energy. REG_AP is average power. Obviously two completl=
ey different things and cannot be the same register.
A quick glance at the datasheet suggests AE does not exist.

> +		[BQ27XXX_REG_SOC] =3D 0x2c,
> +		[BQ27XXX_REG_DCAP] =3D 0x3c,
> +		[BQ27XXX_REG_AP] =3D 0x22,
> +		BQ27XXX_DM_REG_ROWS,
> +};

Please fix indention of };

> =20
>  static enum power_supply_property bq27000_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -792,6 +813,27 @@ static enum power_supply_property bq34z100_props[] =
=3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> +static enum power_supply_property bq78z100_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,

You are not providing data for this? (BQ27XXX_REG_TTECP is not set).
Please revisit the list of exposed properties and provide a dump of /sys/cl=
ass/power_supply/<your_battery>/uevent in your submission.
Currently you should see some -ENODATA.

> +	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_POWER_AVG,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
>  struct bq27xxx_dm_reg {
>  	u8 subclass_id;
>  	u8 offset;
> @@ -890,6 +932,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D { =
=20
> #define bq27z561_dm_regs 0  #define bq28z610_dm_regs 0  #define=20
> bq34z100_dm_regs 0
> +#define bq78z100_dm_regs 0
> =20
>  #define BQ27XXX_O_ZERO		BIT(0)
>  #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
> @@ -948,6 +991,7 @@ static struct {
>  	[BQ28Z610]  =3D BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
>  	[BQ34Z100]  =3D BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ=
27XXX_O_SOC_SI | \
>  							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
> +	[BQ78Z100]  =3D BQ27XXX_DATA(bq78z100,  0x00000000, BQ27Z561_O_BITS),

why 0x00000000 instead of just '0' like in the other entries?

>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock); diff --git=20
> a/drivers/power/supply/bq27xxx_battery_i2c.c=20
> b/drivers/power/supply/bq27xxx_battery_i2c.c
> index eb4f4284982f..46f078350fd3 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -248,6 +248,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_tabl=
e[] =3D {
>  	{ "bq27z561", BQ27Z561 },
>  	{ "bq28z610", BQ28Z610 },
>  	{ "bq34z100", BQ34Z100 },
> +	{ "bq78z100", BQ78Z100 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table); @@ -284,6 +285,7 @@=20
> static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] =3D=
 {
>  	{ .compatible =3D "ti,bq27z561" },
>  	{ .compatible =3D "ti,bq28z610" },
>  	{ .compatible =3D "ti,bq34z100" },
> +	{ .compatible =3D "ti,bq78z100" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
> diff --git a/include/linux/power/bq27xxx_battery.h=20
> b/include/linux/power/bq27xxx_battery.h
> index 111a40d0d3d5..ac17618043b1 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -33,6 +33,7 @@ enum bq27xxx_chip {
>  	BQ27Z561,
>  	BQ28Z610,
>  	BQ34Z100,
> +	BQ78Z100,
>  };
> =20
>  struct bq27xxx_device_info;

Thanks,

-- Sebastian
