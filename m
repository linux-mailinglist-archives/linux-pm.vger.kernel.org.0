Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486EC3419BD
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 11:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCSKRI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 06:17:08 -0400
Received: from mail-db8eur05on2131.outbound.protection.outlook.com ([40.107.20.131]:46945
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229975AbhCSKQx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Mar 2021 06:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll+ldTS4LtxDq3CxgnBOmPK2+mBdHXIsaKHKwsrDkx51Q+YsOtHWR5yRUWBRoI8QwwpDCgpZDds4pOmzDcJIndcrvHANtO2nhUHoIGJQEfIz5F4HAiRDVayj22GqeYlURxqgExdEt+YwiPELn7T3z06fb7iyouuvJ5KML9Tjjil+6mVupUxTm/tTR85Sij2RicPagBFedOJq6L/LI9EDrFVvQRJTDe3HwZ7bXkapTdiClWKy2Ow6KXLrCxUqPUiSKeryMLNRMQxcEzjMEkXudMXON4vF8MLyiUAzIUTxm3C+goUICsIokMjtcVDGVh+3CEunxPIsMnQ3Ibke4vFORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp7MqrnnPKFF4ArtaUgRY3SwVlulOTADuOLoCOFC0jI=;
 b=PpaI6Z1TwNKs1dL3oL3RAAjea+qKI+k99d7Of9FErF2D0UiAyBvSIwcOoFW3U5kVAo/VG97El87DjQG3foBJzZMfdklOvaTNh+tPcAXb6cdjNlmIGAOh9FO5Y6A8zh9vJqTctlzCLdPMD4Y6WVjNCOW9S4l/8b7b16Q0K50Mj5E4yEAtQZF1Rs0Xfh2gsU+resziQN8SOM2XSszOg6YSXgyO37lc/+UxUTHsg6BUH/YDhqqHd4bFXY4xv55pfh3zjAl7WUeMG8bjEjT+hCOWmXoG0v2nGZzYV/8E3BrNYcyb/EOgrobdQSp9yE8FsBJDD2FSKSjPvCz8G/xQKtbqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp7MqrnnPKFF4ArtaUgRY3SwVlulOTADuOLoCOFC0jI=;
 b=Z+NeSG4LkBoyoJFpaWd2e1zicA5rJ5Ch8x+QZ0RWdFZxWrGFJi2/+zB49xj2G9/wG8he9/b/vroeLw9pi37EFQi51FM2O3pCF8S1kfh69LrLpKbWg9bF/ewDFvF7rsLbVv6VhnI7vE3jDWWIbSO9uPbFi4KmQHDHIJIAF9E4Qd0=
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com (2603:10a6:10:70::20)
 by DB6PR0602MB3336.eurprd06.prod.outlook.com (2603:10a6:6:4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 19 Mar
 2021 10:16:51 +0000
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee]) by DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee%3]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 10:16:51 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Sebastian Reichel <sre@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: RE: [PATCH V6 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Thread-Topic: [PATCH V6 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Thread-Index: AQHXGxsxmxnGSu+XJk+tGqT75Haq9KqILbIAgALs4RA=
Date:   Fri, 19 Mar 2021 10:16:51 +0000
Message-ID: <DB7PR06MB4571FB9071EA8EC176C85755D7689@DB7PR06MB4571.eurprd06.prod.outlook.com>
References: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210317104918.12323-3-Qing-wu.Li@leica-geosystems.com.cn>
 <20210317133220.sv2nlyyiw4nnai4t@earth.universe>
In-Reply-To: <20210317133220.sv2nlyyiw4nnai4t@earth.universe>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=leica-geosystems.com.cn;
x-originating-ip: [140.207.15.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b401b2b-6d17-451d-29ee-08d8eac01ce4
x-ms-traffictypediagnostic: DB6PR0602MB3336:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0602MB3336117F1BE6E4EFEE111F1DD7689@DB6PR0602MB3336.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DB15nki8+0tvwBfXWU7jyq7lUceqATkrIkOt9eONsvoPre1wcyN2rdCYEbmxKbBFRndMkbFeyE8O0Zi3x5So0vg2F91NOlnB0IZu3HhnghNPZWbfA6p4Z/MPFUNxDMyobBmwyqoEISkMENXN9cDy+7PkOgzidUdfZrWvUSoDT5gsC5sV8mX7oikMUlSIEOHl6aiNpY7QJLWfhDRFQV3Xl8i+Gs5BglGFLk+v2bxTuqDpCWlC3FKNaw+1iw2xj66z5MfqXwIbvwTmviNiMjm1FQ7fCpJPLcayuN+RBPfXSkr6mX7FT5LTigp5DN2xeTBSWzlyqQr+trJZqt3z6IP1FCUm1x/gCitAbLroYoD9lGSajIJM3wa1IIJeD/S2B9e+zk/lkNdKD49cUBLUzNdX7s5Y6+MxdCusAe2V6KvJ+bfivIAqIg1hD5FwrRXjmG0+ifv2HbPjLg35mdYgDvacp9t33Vf63wxBEAHch5aOzsd8X1UZtiqr1uTbEfGgt/E0L6U0NKGYTeK0CNOl4ubWOW1ZApy3HcAF2sYfrqsP8131yHm5oTiW0Y1SSIwJJEgJ2sDZ5bL+ukJxjofckyTHbvuMhHAZrXEYz6UjW3yyhwccZfqqioKJUu1Unqo9mThFqKK9YDPVIXNxHqHXEU8uIrL/9l8v6V0jp4qUMiQW6WrzHwcPAOf8xcN0FJ9xLByW/8mcJH+TjB6hsa0NpBmXspwEFmtjb/B7dho4T4L1tfoJ8TWH5Z39BQQQ4AUlqChS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB4571.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(54906003)(186003)(53546011)(26005)(8676002)(4326008)(76116006)(478600001)(8936002)(966005)(64756008)(9686003)(5660300002)(316002)(33656002)(2906002)(55016002)(83380400001)(66476007)(7696005)(52536014)(107886003)(66446008)(6506007)(86362001)(71200400001)(6916009)(66556008)(66946007)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MrOO1tk6yNhDquPiW62nnWUObYSrDoOYbQ7m83pPYJ7k1vVoa0b1s+G6eKy5?=
 =?us-ascii?Q?RPejuG0dFhcYVzgAs6wzjDYMsy9/O/fo+IUVM5fVo+LWgf299NlY70wLKYPH?=
 =?us-ascii?Q?4qMfJtMAsDdhLvV4fANjH50EKCmgoFZx8jmC3w1QAlOzdVTjfifRiDOKdiyI?=
 =?us-ascii?Q?85eGX7cItKmLtiAbnOQ70OQmkPng44S2YHEQhsrYN+gK3/ZppSvHHMp4MQEU?=
 =?us-ascii?Q?Rov1MtmH3Vapr8hc+WaoCy1TWhxnFAK5GpI2ycyf1cj0yOULDtLilVKQ747R?=
 =?us-ascii?Q?/88+KtOk0JUcitt/iqkGD+mM44eENj0FFqUK76v+HazwG0oUfVnPjqcIbtHp?=
 =?us-ascii?Q?yUJyaTjqnplQ26QKQgT7NaVv2puMp/JcapRlc0dKkqJgA6tMQ8yppPk2wPEy?=
 =?us-ascii?Q?7RM36Mpjqkgxq3M/rZ+OCySu63pDCRf64dlL81C4EQow/7gc9QBfd2dTLqWD?=
 =?us-ascii?Q?s+fNNzoRg6kAIgnin5eaths1qOOytbTOhxjTPDzu7RM09ZpCjw3qVgnQVhVn?=
 =?us-ascii?Q?mLhCFufNAsOkTCql0woYu7eFNK8ZD0Fy44YyQ8NmzfzFo3b/r8Chmyi76zW2?=
 =?us-ascii?Q?rPVt/k0clxisJqBmVedodW9Y33zPjInxUxOuWeeUXyTT0hLQO73Q66Ri1T9u?=
 =?us-ascii?Q?T9Js1WXrFD9kQB2EidYEdO8D8PoQHjm3DcJe9T/gwC47id+cpypFYITwxSP9?=
 =?us-ascii?Q?nZKNWIR7c01g7HVhuL6zqFuW7fLNf2euEfv8l/2KaMmwRqiWsWDIvavYCbOE?=
 =?us-ascii?Q?oLjorr43Pne9Ez3PQnWXdnF5mpPDx96UP9CaY4nISSQfVWi7C3OeaT50sM9g?=
 =?us-ascii?Q?2bkXR+hN9pD8Mxzv7xC6oo/wxWBRDmfu4TNAfsHjaHo1wWmVGhoB9m6khwWD?=
 =?us-ascii?Q?2y5C2FWhaTLldQPQILXBshYaTfuwlgTJOMsvcEJZqQyq6pKb31S/ehoA0KtW?=
 =?us-ascii?Q?7NWIOhwf5NQOAVIfyEeaWcNuafe1Q+Gp2jYStYQH76g38dZXpDVEYfSz2iWu?=
 =?us-ascii?Q?JbSvZquEdR0Oo7sMp4gfvk7iCtW3NEKYJpnwiVb7cWp5q6oJcBThd1PPHpm0?=
 =?us-ascii?Q?uGWwPtom6uKyEvFpww0NKtSzTO7LHqns+ED21yuwFASBq/7lnCUYarl+gzyF?=
 =?us-ascii?Q?rxwYnhqAhL4oDyJ3iFUrvoV477Fy74mAErhUd59B8bsteTGn6MOVld8eaRPb?=
 =?us-ascii?Q?UaHMQ87eXuoFOTkjFTtPBitdVVBFyZ8FocjWPvQnqW1MTCZqTDZVGmwNknqf?=
 =?us-ascii?Q?A0dy2ms1WrnI7vjTaP2D3VqB6aieVgFUCRI9KHYlB2d4D4E8OKNtC3M5jgbl?=
 =?us-ascii?Q?lD5GlrGCHSiQbG8div6QVo8U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB4571.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b401b2b-6d17-451d-29ee-08d8eac01ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 10:16:51.1331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hC3v2B58yMlqGOalZqonjkOU9cl9o1TaNt0WxfhHSs7zs7KVWbEjLlcqbKnnKLznMJIVKXvCIz87YXfWuEN5FgF2WncgutyX638+LOE++vY0tUOkYzBQAuRdYNolbVnU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0602MB3336
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,


About 4mA current, it's not the expected current, since we are working remo=
tely, the instrument was unattended.
With the real current, the battery will be empty in a working day, so we ju=
st connect a dummy load for test for a while,
You mentioned the POWER_AVG looks suspicious, yes, it's due to I didn't pic=
k the all the commits from master into my code, after pick it's looks corre=
ct.
About " Discharging " for idle battery, I picked you change, and it is "Not=
 Charging", yes fixed by you!
One question, after I pick all the commits, the current goes to negative du=
ring discharging, is this correct?

POWER_SUPPLY_NAME=3Dbq78z100-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3386000
POWER_SUPPLY_CURRENT_NOW=3D-5000
POWER_SUPPLY_CAPACITY=3D27
POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
POWER_SUPPLY_TEMP=3D269
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D1249920
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D6494000
POWER_SUPPLY_CHARGE_NOW=3D1736000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
POWER_SUPPLY_CYCLE_COUNT=3D1
POWER_SUPPLY_POWER_AVG=3D-20000
POWER_SUPPLY_HEALTH=3DGood
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments




Best Regards
Li Qingwu (Terry)




-----Original Message-----
From: Sebastian Reichel <sre@kernel.org>=20
Sent: Wednesday, March 17, 2021 9:32 PM
To: LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc: robh+dt@kernel.org; pali@kernel.org; krzk@kernel.org; linux-pm@vger.ker=
nel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; TERTYCHN=
YI Grygorii <grygorii.tertychnyi@leica-geosystems.com>; ZHIZHIKIN Andrey <a=
ndrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH V6 2/2] power: supply: bq27xxx: Add support for BQ78Z10=
0

Hi,

On Wed, Mar 17, 2021 at 10:49:18AM +0000, LI Qingwu wrote:
> Add support for TI BQ78Z100, I2C interface gas gauge.
> It provides a fully integrated safety protection and authentication=20
> for 1 to 2-series cell Li-Ion and Li-Polymer battery packs.
>=20
> The patch was tested with BQ78Z100 equipment.
>=20
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> result of cat "/sys/class/power_supply/<bat_name>/uevent"
>=20
> CASE I:  Discharging current>0:
>     POWER_SUPPLY_NAME=3Dbq78z100-0
>     POWER_SUPPLY_STATUS=3DDischarging
>     POWER_SUPPLY_PRESENT=3D1
>     POWER_SUPPLY_VOLTAGE_NOW=3D3405000
>     POWER_SUPPLY_CURRENT_NOW=3D4000

4mA @ 3.4V is 13.6 mW, which seems really small to me.
Is this what you expect for your hardware?

>     POWER_SUPPLY_CAPACITY=3D28
>     POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
>     POWER_SUPPLY_TEMP=3D259
>     POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D1611000

I guess 18 days TTE is expected with such a small discharge rate.

>     POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>     POWER_SUPPLY_CHARGE_FULL=3D6494000
>     POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
>     POWER_SUPPLY_CYCLE_COUNT=3D1
>     POWER_SUPPLY_ENERGY_NOW=3D0

You are not feeding ENERGY_NOW with data, so do not expose it.

>     POWER_SUPPLY_POWER_AVG=3D65535

That's a signed int16 -1 and looks suspicious. Especially since expected po=
wer average is around 13.6 mW. Is something wrong with the handling of BQ27=
XXX_REG_AP for your chip?

>     POWER_SUPPLY_HEALTH=3DGood
>     POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>=20
> CASE II : No discharging current:
>     POWER_SUPPLY_NAME=3Dbq78z100-0
>     POWER_SUPPLY_STATUS=3DDischarging

That should actually be "Not Charging" for an idle battery. I suppose recen=
t changes to bq27000, which I applied in the last few days to my for-next b=
ranch, might fix this.

>     POWER_SUPPLY_PRESENT=3D1
>     POWER_SUPPLY_VOLTAGE_NOW=3D3405000
>     POWER_SUPPLY_CURRENT_NOW=3D0
>     POWER_SUPPLY_CAPACITY=3D28
>     POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
>     POWER_SUPPLY_TEMP=3D260
>     POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>     POWER_SUPPLY_CHARGE_FULL=3D6494000
>     POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
>     POWER_SUPPLY_CYCLE_COUNT=3D1
>     POWER_SUPPLY_ENERGY_NOW=3D0
>     POWER_SUPPLY_POWER_AVG=3D0
>     POWER_SUPPLY_HEALTH=3DGood
>     POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
> ---

You should expose POWER_SUPPLY_PROP_CHARGE_NOW for exposing BQ27XXX_REG_RC =
info, which is more precise than CAPACITY.

Thanks,

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c     | 44 ++++++++++++++++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c=20
> b/drivers/power/supply/bq27xxx_battery.c
> index 4c4a7b1c64c5..05a4f9190160 100644
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
> @@ -515,6 +516,27 @@ static u8
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D 0x22,
>  		BQ27XXX_DM_REG_ROWS,
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
> +		[BQ27XXX_REG_TTES] =3D 0x1c,
> +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_RC] =3D 0x10,
> +		[BQ27XXX_REG_FCC] =3D 0x12,
> +		[BQ27XXX_REG_CYCT] =3D 0x2a,
> +		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_SOC] =3D 0x2c,
> +		[BQ27XXX_REG_DCAP] =3D 0x3c,
> +		[BQ27XXX_REG_AP] =3D 0x22,
> +		BQ27XXX_DM_REG_ROWS,
>  	};
> =20
>  static enum power_supply_property bq27000_props[] =3D { @@ -813,6=20
> +835,26 @@ static enum power_supply_property bq34z100_props[] =3D {
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
> @@ -911,6 +953,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D { =
=20
> #define bq27z561_dm_regs 0  #define bq28z610_dm_regs 0  #define=20
> bq34z100_dm_regs 0
> +#define bq78z100_dm_regs 0
> =20
>  #define BQ27XXX_O_ZERO		BIT(0)
>  #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
> @@ -969,6 +1012,7 @@ static struct {
>  	[BQ28Z610]  =3D BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
>  	[BQ34Z100]  =3D BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ=
27XXX_O_SOC_SI | \
>  							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
> +	[BQ78Z100]  =3D BQ27XXX_DATA(bq78z100,  0x00000000, BQ27Z561_O_BITS),
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
> --
> 2.17.1
>=20
