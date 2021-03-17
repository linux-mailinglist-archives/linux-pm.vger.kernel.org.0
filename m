Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357C733ED60
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCQJru (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 05:47:50 -0400
Received: from mail-eopbgr140103.outbound.protection.outlook.com ([40.107.14.103]:21916
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229748AbhCQJrY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Mar 2021 05:47:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtMCqvb/nvlkhSwEJIV5DVo4vsh6z1wovnM2cDA/jl60WImYeSWIMpWU/eGkPHFNqAOe9wYUC+AOszwzrFVve84t5i7Tr0XhR38TPeQBzWUrMfINQ8FTp3kCS+ORckO5rZRc4kTL7DUFhEKVjsVfo1bS6DIRMLtaGOVVy7KlYciPYXVJR8fpB0zLhMkOcscn6ixTgUl5BCF5QwNAlPpXA7XA2oITNSQCGkiPlCOwBjMApKA51LsHMz+q0Oan7wjyNLvtsiqT/boanx76h1j7Yokt4UWwgqNaayCK8DY6DqdXHOvghkDqgk5yCIGDJ97VI/yesmYowU5upMYwIHXVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVEtPKaWrDjuQhjpLfjXDeXXaM8dzjV+CNs928wXN74=;
 b=B9KlZDHrki3K7sD9Pg3VO07qvQi2DJYC3YwaShtEbe0jBFKJ55hp+PxFuzVEiJOXsL1ylxfpvuj6Szk0XRCoC5guXcJMF1VMHCMSxl2y9L3qFVDlDL28uxH/i78gt+iPsy2b5JzbDjWbXUUqr0lchWOSv62JJQTnfbVjo8TukvWwu7AoyWYOTzDYOLbHCgnoKlMHuV8MUEXjOD0VLiRVjcYiupHot7QlzBLI4hMeEbZXZA0l4GGJKVnqZwt96qiNnwmwlja3PvufhdGBPhWiCZcLXJHlWr1HnqLP857yFBoin/siKwMO2xNCC2CWwS8RT0jOy7QJpRwWR7T7J8+EvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVEtPKaWrDjuQhjpLfjXDeXXaM8dzjV+CNs928wXN74=;
 b=k54pQcRlHYBik7Fev75WMfqWs+wELVkrgi67OWixU2AvKnnPaMXTX7l+z4gXGgmuF3nh7Xm0ANmL8PZqllk1Su1tQePZg+bfTMg0x0Mp4JWFvxog4Y+a9e46su2Oh1y2jFphDlTgXtdxdTpbJZyhxRlXCiCeQB5tMl4WC1jPGeA=
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com (2603:10a6:10:70::20)
 by DB6PR0601MB2408.eurprd06.prod.outlook.com (2603:10a6:4:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 09:47:21 +0000
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee]) by DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee%3]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 09:47:21 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Sebastian Reichel <sre@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>, "afd@ti.com" <afd@ti.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: RE: [PATCH V5 0/2] power: bq27xxx: add bq78z100
Thread-Topic: [PATCH V5 0/2] power: bq27xxx: add bq78z100
Thread-Index: AQHXEYvBE1Tk4NaU40mHgN1zwl9D2aqENCwAgAOpFuA=
Date:   Wed, 17 Mar 2021 09:47:21 +0000
Message-ID: <DB7PR06MB45716430341BB83DAD60B01AD76A9@DB7PR06MB4571.eurprd06.prod.outlook.com>
References: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210314234202.xijndjgltdcyuggh@earth.universe>
In-Reply-To: <20210314234202.xijndjgltdcyuggh@earth.universe>
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
x-ms-office365-filtering-correlation-id: 0ca88166-a908-4b68-7b36-08d8e929a953
x-ms-traffictypediagnostic: DB6PR0601MB2408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0601MB240860DDC948F02D9252171AD76A9@DB6PR0601MB2408.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhP/pnNwHa4o0VgJLa/WN/9hJYbhgZ99W3TiHtfGwQ/Q9mDmhNeAxsW+r04HsY5x7QpCwCVFnpLUAO6+pp+53dj1XLNqXNRmFQOHsUqIbpqSpl4GJ6daBMTkG2LmKG6S00+rVyo5qwYe26LZ3XjVMs8hsL08FZunfgABB68KuAcjZFH8YPkf8kHmTKsjb3Rx8keAdxhw1xqZlJk6CHgycJTbdlvrsTPkVR6wLHZdALv8vTcbZ2pm7eWw7UBUTn7YMVP1x78NvlKWsm7gvNM7aMVARq26Y2g3h4erHgaXBVzHw9PuirosPPifQvs9VI4bQoL9bLBbLiF5fabiaw1sUQiHs1vicEEZSYPJZaqu8daiJTDrX0EYIOgfM9a1AVz1vAk9kdRRv8LDJ/cBpTyxjLLB5PXn3P/jHvcTrPXI0pqFKfert+RRRharGMFHrNDMTC193XhejoJBA8BvPt8luMQZBle5LrO7DMf7E9pV7L5/nS4B7pMye4MtkzEAk8SiPvPVWcmZ1cLMz5X8AfP9NDWjQVeoLGS1sCb7k3iF7hHrpuJVxlW9HUmnZIelb9dXiX9HoFbpswd8iK2BP1dLfrX3Q2yRiEy8RtjWV+N/Nkobxpr4wLjcl3Sx60K3e1Ba
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB4571.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(86362001)(53546011)(55016002)(52536014)(66946007)(76116006)(66476007)(7696005)(54906003)(8676002)(66556008)(2906002)(186003)(33656002)(6506007)(4326008)(9686003)(8936002)(6916009)(107886003)(66446008)(64756008)(5660300002)(26005)(71200400001)(316002)(83380400001)(478600001)(138113003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fS0XgdGpXf/ecl1+PlEcGDhorMa9S+gwwznBSo/Uf4f0MyE5js8I92JqP+Kr?=
 =?us-ascii?Q?LdOgXfZQGrS78pLsXxG7oX0Pr5ZH5CNHE5Zuxz6cviqS37BDvoZZsxlYXHG8?=
 =?us-ascii?Q?rORAArnmwmBN+llWUh/zPQEVXQQoig9K4xsTz0urK4HAKQtkjRn4ooGndYeU?=
 =?us-ascii?Q?8EcvJz0rO9piev59RMJkVxXesYYFKn0zxNiheh5VHC53dcQyOBHkAcuwjptD?=
 =?us-ascii?Q?UIcfZ1L0O6t58vkjjnDGveMYXzuGHAgRipIUDIGOx87YvyNso+aZHZseWQHP?=
 =?us-ascii?Q?dATgpq7SqxUiT6jryaPq8GUcvud8IsMJuuWIz/XACs45nvDuAWXKzFN5Yywk?=
 =?us-ascii?Q?p+/KKZS9Oumgi/wKSL2bOtdUf2MsggxpJJXPPIvU6ruCHLh97YU6tDo2MVPD?=
 =?us-ascii?Q?h+kHtnwr+sAMSiEK6SqZkEB8kYVM3RhiOBPaqgkrwX7etFymY6BuOMNIiiB/?=
 =?us-ascii?Q?cDUag+qWZbBvuXQy8TyikoixPkTy0S82i7C3wY7P6UMSb1giAGuMySBUPKp5?=
 =?us-ascii?Q?+eHSOOQvLPe9FBlFXtjFXFzTGX0gy1YFj7gC3uhQXxqp0uEQrqXhnSWcCfSI?=
 =?us-ascii?Q?hAMcKW/DxMaLhGY8XU3kXMSKG2xRatgo915bQx/Rjy5s0BmZIwxVjKP5XB17?=
 =?us-ascii?Q?MeSQ/sshrRn25W6TxnvnHIpUwoSozFMKbtci3CkNXJIOcOQQWPpSYIBOUPcw?=
 =?us-ascii?Q?jYvKxXNGI6rcUPPPykWBTdLymq4C8OwQzMv8J3bfC3nnVLay59McuHjgXcBi?=
 =?us-ascii?Q?E4N98SX5NXpB2rnqxRpBptY6NX4+QspyyJqOQ2HdrmV/T5dOu9+rtsuJYDjQ?=
 =?us-ascii?Q?Zg4paC9cO6RX7Orw5tGk5pCL6nijFHiUlW/3GvjnKb7+7MFVZ+d4flRgE75h?=
 =?us-ascii?Q?b+Kc0YuS73sj2D+M155h1KIQ/BpKEUllwRwFyA+nSZLtb9eJx0xxf4oL0kzR?=
 =?us-ascii?Q?byFqskxCE0I4PExLlG6s0PkF/GG9ys8F83mfbRvrIaxmVXE0SaGFXBd8MKXT?=
 =?us-ascii?Q?d6fRu0Lth/zlh2TfPRC4fY5PnVfGkh5GnWmEEGic3L5tShgiuj4jlqwI99EH?=
 =?us-ascii?Q?08aV7l8ZN8W5sAG48C9JT2OyLuS1u1qZP5WQuMmL89f0fdk9MYNcb4CZOKLA?=
 =?us-ascii?Q?hXPnncMUon4k3jTvc+owtTF56d7soWvUoS8yGNLefrw5sHe4GDWvWhbeqKZw?=
 =?us-ascii?Q?4FnlZisS+T8eT0UBq96+bfZjy47RlE+78HmFOhPrmjP9IU9EKutsu3e23dsY?=
 =?us-ascii?Q?4bxnMrIlv+HFWgiUF5hf4NRz3QOXrSYaQllEFHmIKg7YGpKwXmFsOhQ1I+GJ?=
 =?us-ascii?Q?PGX3eN+Dntei6ixKsqEwr0S+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB4571.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca88166-a908-4b68-7b36-08d8e929a953
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 09:47:21.5017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e79epFi2DVK29164+70UqaRhTxDBdc3l/AfUUeviC4wr6L5b3PdaxyqQ4qrOO1oDkxFt0dM/2ZllAow+bnpG0abhdcodyE26moCG4qaaNC/43JG0/5wXyVAbmij8OQ0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2408
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

Here is the dump of the "uevent", I tested two cases, discharging current >=
0 and discharging current =3D0.
If discharging current=3D0:
    POWER_SUPPLY_TIME_TO_EMPTY_NOW and POWER_SUPPLY_TIME_TO_FULL_NOW are di=
sappear,=20
    the value is "-ENODATA"
If discharging current>0:
    POWER_SUPPLY_TIME_TO_FULL_NOW is disappear,=20
    the value is "-ENODATA"
Since I can't test charging on our hardware, I think "POWER_SUPPLY_TIME_TO_=
FULL_NOW" will show up during charging, since the value is given by registe=
r 0x18 with index "BQ27XXX_REG_TTF".

TEST CASE I:  discharging current >0:
    POWER_SUPPLY_NAME=3Dbq78z100-0
    POWER_SUPPLY_STATUS=3DDischarging
    POWER_SUPPLY_PRESENT=3D1
    POWER_SUPPLY_VOLTAGE_NOW=3D3405000
    POWER_SUPPLY_CURRENT_NOW=3D4000
    POWER_SUPPLY_CAPACITY=3D28
    POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
    POWER_SUPPLY_TEMP=3D259
    POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D1611000
    POWER_SUPPLY_TECHNOLOGY=3DLi-ion
    POWER_SUPPLY_CHARGE_FULL=3D6494000
    POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
    POWER_SUPPLY_CYCLE_COUNT=3D1
    POWER_SUPPLY_ENERGY_NOW=3D0
    POWER_SUPPLY_POWER_AVG=3D65535
    POWER_SUPPLY_HEALTH=3DGood
    POWER_SUPPLY_MANUFACTURER=3DTexas Instruments

TEST CASE II : discharging current =3D0:
    POWER_SUPPLY_NAME=3Dbq78z100-0
    POWER_SUPPLY_STATUS=3DDischarging
    POWER_SUPPLY_PRESENT=3D1
    POWER_SUPPLY_VOLTAGE_NOW=3D3405000
    POWER_SUPPLY_CURRENT_NOW=3D0
    POWER_SUPPLY_CAPACITY=3D28
    POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
    POWER_SUPPLY_TEMP=3D260
    POWER_SUPPLY_TECHNOLOGY=3DLi-ion
    POWER_SUPPLY_CHARGE_FULL=3D6494000
    POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
    POWER_SUPPLY_CYCLE_COUNT=3D1
    POWER_SUPPLY_ENERGY_NOW=3D0
    POWER_SUPPLY_POWER_AVG=3D0
    POWER_SUPPLY_HEALTH=3DGood
    POWER_SUPPLY_MANUFACTURER=3DTexas Instruments



Best Regards

Li Qingwu (Terry)


Best Regards

Li Qingwu (Terry)




-----Original Message-----
From: Sebastian Reichel <sre@kernel.org>=20
Sent: Monday, March 15, 2021 7:42 AM
To: LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc: robh+dt@kernel.org; pali@kernel.org; krzk@kernel.org; afd@ti.com; linux=
-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>; ZHIZHIK=
IN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH V5 0/2] power: bq27xxx: add bq78z100

Hi,

On Fri, Mar 05, 2021 at 06:49:47AM +0000, LI Qingwu wrote:
> Changes in V5:
>=20
> 1. Change [BQ27XXX_REG_TTES] from INVALID_REG_ADDR to 0x1c, the=20
> StandbyTimeToEmpty command of bq78z100.
> 2. Add [BQ27XXX_REG_RC] =3D 0x10. the RemainingCapacity command of=20
> bq78z100.
> 3. Set [BQ27XXX_REG_AE] to INVALID_REG_ADDR, support by bq78z100.
> 4. Delete property POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, not support by=20
> bq78z100

I also asked to check other exposed properties and to provide a dump of the=
 power-supply uevent in commit message or cover letter to verify chip works=
 as expected. I cannot see the dump and you are exposing at least one prope=
rty that always reports -ENODATA. I intentionally will not point out the ex=
act property, so that you have to properly test your patch before submittin=
g.

Thanks,

-- Sebastian

> LI Qingwu (2):
>   dt-bindings: power: bq27xxx: add bq78z100
>   power: supply: bq27xxx: Add support for BQ78Z100
>=20
>  .../bindings/power/supply/bq27xxx.yaml        |  1 +
>  drivers/power/supply/bq27xxx_battery.c        | 44 +++++++++++++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
>  include/linux/power/bq27xxx_battery.h         |  1 +
>  4 files changed, 48 insertions(+)
>=20
> --
> 2.17.1
>=20
