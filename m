Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6601A3436EE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 04:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCVC7a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Mar 2021 22:59:30 -0400
Received: from mail-eopbgr20127.outbound.protection.outlook.com ([40.107.2.127]:53200
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229548AbhCVC7I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Mar 2021 22:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b128aBhA68xaZ9+YcYaw3bGFTNt208yjvw1hG/QlY0AWGC1aPw+qhpzEWvwFeG5Mj+PVY3i5alWRULMrz4zBOTiTHoVx0AuFT7I14mA/q8jPTgDt4789Dv44bqULiAi6X0Zmp2Fh1FVgd6tm8yNQ/oiDCP9XfYKevO5cw983uLOnxbdRM1+7VdM3xrHu1ZES7D6cjmtTzrKEkjrjjDSRg5XTZy2aqjoTGBRehcPj09snjIjK6jKOYM7svia/F1NOEV7OsmbPUOMAA2Q4zXncGidktjwB/7hst13EPOfP3s8WwGeBXqaPxUCaKDyo+6foIPdehiC78abkjeXILKTF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlkoySX4abdovOcHZI9zIhowNH/OFOIRUnJzMfiY/Pc=;
 b=a3pG9BOxeE+qCv/zP+TgQwN2qqbHHRCvqhc7k9EHwDrfBOdR2sab4jQ/pvKdoXv2u1iR08kwHqfsRtftENPwxdgfQuxw83m/AQkbEcFgrDBS1D1TbxfkLJ4MI4hSJM+f+mh68sAC0vdvjcxWJ+fSwkGRr2fd5LsgASENYX7N3fNZy6gxcFNX13Mcv87cODFVFJwk42VQm/6h8lMcTa/oddZ662kf90Q3/60hSNwvH0InViBVaOASrXj92VtU8ogRWTKYfZxK09ImgSEgsLk8WX8qGp0kFBMQ19rpk1jAg+wLeIu3vB5frU85X4Ensq7Dj/FkQXircrvRST4J4u/OUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlkoySX4abdovOcHZI9zIhowNH/OFOIRUnJzMfiY/Pc=;
 b=HnNRAdgoNIksq4AqCevRNLNuYbdY7DlcmX7iR1SMfTIlGbbBQgEc4+qkoHIHt7Fjt9Eys2F2DkWsfuOuF4MzkPlicWhXAQihwBvpXgz23BC4T2cy3Fv1PdEo+y0JHzOvmb9cNyFveGpUFHMF9OjQLT2DxYQFbKb6nu7Pkx3uuOI=
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com (2603:10a6:10:70::20)
 by DB7PR06MB5515.eurprd06.prod.outlook.com (2603:10a6:10:8b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 02:59:05 +0000
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee]) by DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee%3]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 02:59:05 +0000
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
Thread-Index: AQHXGxsxmxnGSu+XJk+tGqT75Haq9KqILbIAgALs4RCAABSygIAEJZGw
Date:   Mon, 22 Mar 2021 02:59:05 +0000
Message-ID: <DB7PR06MB4571F9AAC636E06763DEEA00D7659@DB7PR06MB4571.eurprd06.prod.outlook.com>
References: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210317104918.12323-3-Qing-wu.Li@leica-geosystems.com.cn>
 <20210317133220.sv2nlyyiw4nnai4t@earth.universe>
 <DB7PR06MB4571FB9071EA8EC176C85755D7689@DB7PR06MB4571.eurprd06.prod.outlook.com>
 <20210319112645.dpooltu32etdqz5v@earth.universe>
In-Reply-To: <20210319112645.dpooltu32etdqz5v@earth.universe>
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
x-ms-office365-filtering-correlation-id: 5d775d93-f821-4148-c69a-08d8ecde7475
x-ms-traffictypediagnostic: DB7PR06MB5515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR06MB551539891E88DBB62B96CA1BD7659@DB7PR06MB5515.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2APkJPMEgm55LLC5o0ee1FkRYLVap7u1Mzu0NI3odDIxN4H9NQjTnap964+W3fGy0XT6e8+uD0zhin2ygNs4YNvHd05oVEPHGF+8LEMO9GHDMIY0eANM/lrblj8IU+SwrSdEIfk0N75/Ok3LCCAVJznzHu3SfnVKYvNySvAGt9qFl+1mvt+WORnjEMmPBFm+pY2iDJLieL8tbJXk4db9Qnri9KSKWso/JgesdNtFOH4fxSE/ya/czA4+DF8EIcZIryfIAvGT+ceAlSCPooDe5us7dHmgeSeEqACPEHpydBeKSoF7xQgwxwkxkcNat0K8m7A+VFtmJZjqyi1IMUuGwMgQKMNKCr9kpQwdWH7w92Bycr2uO4w1mj/WexmJg17pMEUqgSoAMa06/Pj49+/Ewpv7bvLOcWzoQCULj/PJr73oWu2K54K67O/QQ1PVRTzyz8tGi4eJFzRo971mAX32wwZe305JCh2idM+p/+U0w3SQlAyqlcl7IUDqNUyvRvgYonXOQhxjq5b7269sixHyPPNxb0Us/gt7Aev/m6HMPm4ot5KURH8EoFNiKBWNID6p2osOv7vlUp4kwXZ2abazBEKyCwGJwJSSGIZQ0dVVmBB6LldMBSSRRAhz0+o0zYZnHbMOLUYNRm9YugyxeqsZi6l9o/D4rZhHF4IOE4DxOotYhnQSveVySTWormPrwFIT6fjSNLt2oczslopGuT8SJaCwpWXyOPtFRBwFb7ksGoPbaRl0g4faFHuf/+sU0E3D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB4571.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(53546011)(8676002)(6506007)(26005)(186003)(33656002)(9686003)(7696005)(66476007)(66446008)(38100700001)(107886003)(64756008)(52536014)(966005)(316002)(54906003)(66946007)(76116006)(6916009)(66556008)(8936002)(4326008)(71200400001)(55016002)(83380400001)(86362001)(5660300002)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t1OmehGo7htqI97D8ckqqxctHnlQ50GpMdUZtwmjYaQcyw0sO4OZd/bdXPhe?=
 =?us-ascii?Q?Wzr4b0byBoNRQPErjMHotd43VgWsKk4aqiAbYFNNj38J3TkD5r2ZAtzXpQ5q?=
 =?us-ascii?Q?q6jXfCYaQq/BrbRfgI5E6knzFUzQ6vHXkWd3XDg+c0r5bILqjq3Fe2xxOS10?=
 =?us-ascii?Q?fUq+Y1HkLku8GjZCqWkfFUrn8HTE+6Oxr4bdw2/HHIGW3ZsB3oeOl0Ue7xEm?=
 =?us-ascii?Q?GKNEi5fjGScZGjAz9tkECERusSwW8kGj66fkkUP59gwuZCC/R5faHpSuS4jj?=
 =?us-ascii?Q?2vhz6AleFT2Y8MA8P9kXQMnN4C3UAyamSWWLR7e53HSL9KWMXWh60i/kHguM?=
 =?us-ascii?Q?bEMV+59sgve4zBsNvc9IvM2/A4I6lJZNWtzqgKCIwBrbFCH99CHb5cgiIqIy?=
 =?us-ascii?Q?xF55DwK+Gdp8ClSa0Sld3GmPO/XFqTZJtvRfWR4m9VdLEgyMkAMv5cDFAplp?=
 =?us-ascii?Q?Dft6jG2zNw4hizD1ve6wcJa9gPZiBn/pFBus7oh3WZx/ftkMoFLIcKwLN7I7?=
 =?us-ascii?Q?G+cYXb4ZYd0XYYmn2e+L2ILz9VK6FRmT0O4GiUyWGDeqP/69DhtenOi8Otxi?=
 =?us-ascii?Q?FDqnIWVaYoksvfRel8HNXg3re04tmZZ5R4fqUFSGs3RGhqPrSLg0ioTz9yS7?=
 =?us-ascii?Q?2IFMDdi9WlOXZE/rV5EML1BaEfX5pNnUgI/hdoNZvK5qwcBhyIxGQBbXeEhP?=
 =?us-ascii?Q?Ylah9of4EA7+MQ4SaUQNIhFHN+UehtA2pHAAdZfqB4FiGRWy0eI6tP41nMUw?=
 =?us-ascii?Q?aBccAWRrWxHJEW+A5mXkMvh+BhmWcncngKlq/iD3FFCT1bYEJ2AmLOKb6pI9?=
 =?us-ascii?Q?ZjyER93A1iW4ul7P92p0mjQoRCjUzPAQT2aWO6dBtiI7/2RoIHynrup031uE?=
 =?us-ascii?Q?l2/kpqm4A0xMKmYv1z7NQIYFIuwN73YnIshGnSrte0BSlqob2gJpPN/sMdQg?=
 =?us-ascii?Q?uDtKTsW14KahcN1dfE0hzAIsoL3T4/CWMrVBdt6TxmYhbngZTlgicrOrJZzi?=
 =?us-ascii?Q?ahpHWfqCLqauWemMY9/xblN+1WgIbiGQO/57kQh7pfNbHshDCKClEo7hIG69?=
 =?us-ascii?Q?VBObGdWCHj/gtHfZKvJygJPQHkp83jmYxkZ3Jjz46Yml8fwQJskEm8IMPU4D?=
 =?us-ascii?Q?h8eCEcx5fzQrRm+c4n9O4GvAOmIw59FPhVCCc9mgsxsLNUwpgNIH+kMeJtms?=
 =?us-ascii?Q?wxngFkRI5xeo2vfoY+ilGxnex6DFkpnHiHSwMjEopkozSjWdOtxhiTF3gX9e?=
 =?us-ascii?Q?y6CzR9WwQYj4Nuc4MHZW6Z+4xw4Wd5AM5YdxSmlTN0uj8f9R87vmFUxfew6Y?=
 =?us-ascii?Q?BxcfQqTU0vh+YDgOUcN59vKm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB4571.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d775d93-f821-4148-c69a-08d8ecde7475
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 02:59:05.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pH+bgbvoF8PgwM/3Nl4QdK6xfk9ctmdql2XW5tCQ6j7FbITm/OXan2ScEzDuPw203IXETVEqH7P+4GmkNK/YKX1rIgVVYzcPuTXHBMWoX8A/91qEbhnZOK2zpsuh517L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5515
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,



On Friday, March 19, 2021 7:27 PM Sebastian Reichel wrote:
> Hi,
>=20
> On Fri, Mar 19, 2021 at 10:16:51AM +0000, LI Qingwu wrote:
> > About 4mA current, it's not the expected current, since we are working
> > remotely, the instrument was unattended. With the real current, the
> > battery will be empty in a working day, so we just connect a dummy
> > load for test for a while,
>=20
> IIUIC 4-5 mA is the expected current for your dummy load and the test dat=
a
> looks ok?

Yes, the data is correct, we tested several different current and data are =
correct,
confirmed by our electronics engineer.

>=20
> > You mentioned the POWER_AVG looks suspicious, yes, it's due to I
> > didn't pick the all the commits from master into my code, after pick
> > it's looks correct.
>=20
> Ok.
>=20
> > About " Discharging " for idle battery, I picked you change, and it is
> > "Not Charging", yes fixed by you!
>=20
> Great.
>=20
> > One question, after I pick all the commits, the current goes to
> > negative during discharging, is this correct?
>=20
> Yes, as documented in 05f94eb98907 ("power: supply: document current
> direction") the current should be negative when battery discharges and po=
sitive
> when it charges.

Thanks!

>=20
> > POWER_SUPPLY_NAME=3Dbq78z100-0
> > POWER_SUPPLY_STATUS=3DDischarging
> > POWER_SUPPLY_PRESENT=3D1
> > POWER_SUPPLY_VOLTAGE_NOW=3D3386000
> > POWER_SUPPLY_CURRENT_NOW=3D-5000
> > POWER_SUPPLY_CAPACITY=3D27
> > POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> > POWER_SUPPLY_TEMP=3D269
> > POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D1249920
> > POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> > POWER_SUPPLY_CHARGE_FULL=3D6494000
> > POWER_SUPPLY_CHARGE_NOW=3D1736000
> > POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
> > POWER_SUPPLY_CYCLE_COUNT=3D1
> > POWER_SUPPLY_POWER_AVG=3D-20000
> > POWER_SUPPLY_HEALTH=3DGood
> > POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>=20
> That data looks consistent to me now.
>=20
> Last but not least: Please don't top-post in kernel mailing lists and use=
 inline style
> instead, as stated in
> Documentation/process/howto.rst:

Noted down, I will follow the documents, thanks.
=20
> > Remember to keep the context and the attribution of your replies
> > intact, keep the "John Kernelhacker wrote ...:" lines at the top of
> > your reply, and add your statements between the individual quoted
> > sections instead of writing at the top of the mail.
>=20
> Thanks,
>=20
> -- Sebastian
>=20
> > -----Original Message-----
> > Hi,
> >
> > On Wed, Mar 17, 2021 at 10:49:18AM +0000, LI Qingwu wrote:
> > > Add support for TI BQ78Z100, I2C interface gas gauge.
> > > It provides a fully integrated safety protection and authentication
> > > for 1 to 2-series cell Li-Ion and Li-Polymer battery packs.
> > >
> > > The patch was tested with BQ78Z100 equipment.
> > >
> > > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > result of cat "/sys/class/power_supply/<bat_name>/uevent"
> > >
> > > CASE I:  Discharging current>0:
> > >     POWER_SUPPLY_NAME=3Dbq78z100-0
> > >     POWER_SUPPLY_STATUS=3DDischarging
> > >     POWER_SUPPLY_PRESENT=3D1
> > >     POWER_SUPPLY_VOLTAGE_NOW=3D3405000
> > >     POWER_SUPPLY_CURRENT_NOW=3D4000
> >
> > 4mA @ 3.4V is 13.6 mW, which seems really small to me.
> > Is this what you expect for your hardware?
> >
> > >     POWER_SUPPLY_CAPACITY=3D28
> > >     POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> > >     POWER_SUPPLY_TEMP=3D259
> > >     POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D1611000
> >
> > I guess 18 days TTE is expected with such a small discharge rate.
> >
> > >     POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> > >     POWER_SUPPLY_CHARGE_FULL=3D6494000
> > >     POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
> > >     POWER_SUPPLY_CYCLE_COUNT=3D1
> > >     POWER_SUPPLY_ENERGY_NOW=3D0
> >
> > You are not feeding ENERGY_NOW with data, so do not expose it.
> >
> > >     POWER_SUPPLY_POWER_AVG=3D65535
> >
> > That's a signed int16 -1 and looks suspicious. Especially since expecte=
d power
> average is around 13.6 mW. Is something wrong with the handling of
> BQ27XXX_REG_AP for your chip?
> >
> > >     POWER_SUPPLY_HEALTH=3DGood
> > >     POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
> > >
> > > CASE II : No discharging current:
> > >     POWER_SUPPLY_NAME=3Dbq78z100-0
> > >     POWER_SUPPLY_STATUS=3DDischarging
> >
> > That should actually be "Not Charging" for an idle battery. I suppose r=
ecent
> changes to bq27000, which I applied in the last few days to my for-next b=
ranch,
> might fix this.
> >
> > >     POWER_SUPPLY_PRESENT=3D1
> > >     POWER_SUPPLY_VOLTAGE_NOW=3D3405000
> > >     POWER_SUPPLY_CURRENT_NOW=3D0
> > >     POWER_SUPPLY_CAPACITY=3D28
> > >     POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> > >     POWER_SUPPLY_TEMP=3D260
> > >     POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> > >     POWER_SUPPLY_CHARGE_FULL=3D6494000
> > >     POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
> > >     POWER_SUPPLY_CYCLE_COUNT=3D1
> > >     POWER_SUPPLY_ENERGY_NOW=3D0
> > >     POWER_SUPPLY_POWER_AVG=3D0
> > >     POWER_SUPPLY_HEALTH=3DGood
> > >     POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
> > > ---
> >
> > You should expose POWER_SUPPLY_PROP_CHARGE_NOW for exposing
> BQ27XXX_REG_RC info, which is more precise than CAPACITY.
> >
> > Thanks,
> >
> > -- Sebastian
> >
> > >  drivers/power/supply/bq27xxx_battery.c     | 44
> ++++++++++++++++++++++
> > >  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
> > >  include/linux/power/bq27xxx_battery.h      |  1 +
> > >  3 files changed, 47 insertions(+)
> > >
> > > diff --git a/drivers/power/supply/bq27xxx_battery.c
> > > b/drivers/power/supply/bq27xxx_battery.c
> > > index 4c4a7b1c64c5..05a4f9190160 100644
> > > --- a/drivers/power/supply/bq27xxx_battery.c
> > > +++ b/drivers/power/supply/bq27xxx_battery.c
> > > @@ -39,6 +39,7 @@
> > >   * https://www.ti.com/product/bq27z561
> > >   * https://www.ti.com/product/bq28z610
> > >   * https://www.ti.com/product/bq34z100-g1
> > > + * https://www.ti.com/product/bq78z100
> > >   */
> > >
> > >  #include <linux/device.h>
> > > @@ -515,6 +516,27 @@ static u8
> > >  		[BQ27XXX_REG_DCAP] =3D 0x3c,
> > >  		[BQ27XXX_REG_AP] =3D 0x22,
> > >  		BQ27XXX_DM_REG_ROWS,
> > > +	},
> > > +	bq78z100_regs[BQ27XXX_REG_MAX] =3D {
> > > +		[BQ27XXX_REG_CTRL] =3D 0x00,
> > > +		[BQ27XXX_REG_TEMP] =3D 0x06,
> > > +		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> > > +		[BQ27XXX_REG_VOLT] =3D 0x08,
> > > +		[BQ27XXX_REG_AI] =3D 0x14,
> > > +		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> > > +		[BQ27XXX_REG_TTE] =3D 0x16,
> > > +		[BQ27XXX_REG_TTF] =3D 0x18,
> > > +		[BQ27XXX_REG_TTES] =3D 0x1c,
> > > +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_RC] =3D 0x10,
> > > +		[BQ27XXX_REG_FCC] =3D 0x12,
> > > +		[BQ27XXX_REG_CYCT] =3D 0x2a,
> > > +		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> > > +		[BQ27XXX_REG_SOC] =3D 0x2c,
> > > +		[BQ27XXX_REG_DCAP] =3D 0x3c,
> > > +		[BQ27XXX_REG_AP] =3D 0x22,
> > > +		BQ27XXX_DM_REG_ROWS,
> > >  	};
> > >
> > >  static enum power_supply_property bq27000_props[] =3D { @@ -813,6
> > > +835,26 @@ static enum power_supply_property bq34z100_props[] =3D {
> > >  	POWER_SUPPLY_PROP_MANUFACTURER,
> > >  };
> > >
> > > +static enum power_supply_property bq78z100_props[] =3D {
> > > +	POWER_SUPPLY_PROP_STATUS,
> > > +	POWER_SUPPLY_PROP_PRESENT,
> > > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > > +	POWER_SUPPLY_PROP_CAPACITY,
> > > +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> > > +	POWER_SUPPLY_PROP_TEMP,
> > > +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> > > +	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> > > +	POWER_SUPPLY_PROP_TECHNOLOGY,
> > > +	POWER_SUPPLY_PROP_CHARGE_FULL,
> > > +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> > > +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> > > +	POWER_SUPPLY_PROP_ENERGY_NOW,
> > > +	POWER_SUPPLY_PROP_POWER_AVG,
> > > +	POWER_SUPPLY_PROP_HEALTH,
> > > +	POWER_SUPPLY_PROP_MANUFACTURER,
> > > +};
> > > +
> > >  struct bq27xxx_dm_reg {
> > >  	u8 subclass_id;
> > >  	u8 offset;
> > > @@ -911,6 +953,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[]
> =3D
> > > { #define bq27z561_dm_regs 0  #define bq28z610_dm_regs 0  #define
> > > bq34z100_dm_regs 0
> > > +#define bq78z100_dm_regs 0
> > >
> > >  #define BQ27XXX_O_ZERO		BIT(0)
> > >  #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD
> overtemperature flags */
> > > @@ -969,6 +1012,7 @@ static struct {
> > >  	[BQ28Z610]  =3D BQ27XXX_DATA(bq28z610,  0         ,
> BQ27Z561_O_BITS),
> > >  	[BQ34Z100]  =3D BQ27XXX_DATA(bq34z100,  0         ,
> BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
> > >  							  BQ27XXX_O_HAS_CI |
> BQ27XXX_O_MUL_CHEM),
> > > +	[BQ78Z100]  =3D BQ27XXX_DATA(bq78z100,  0x00000000,
> > > +BQ27Z561_O_BITS),
> > >  };
> > >
> > >  static DEFINE_MUTEX(bq27xxx_list_lock); diff --git
> > > a/drivers/power/supply/bq27xxx_battery_i2c.c
> > > b/drivers/power/supply/bq27xxx_battery_i2c.c
> > > index eb4f4284982f..46f078350fd3 100644
> > > --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> > > +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> > > @@ -248,6 +248,7 @@ static const struct i2c_device_id
> bq27xxx_i2c_id_table[] =3D {
> > >  	{ "bq27z561", BQ27Z561 },
> > >  	{ "bq28z610", BQ28Z610 },
> > >  	{ "bq34z100", BQ34Z100 },
> > > +	{ "bq78z100", BQ78Z100 },
> > >  	{},
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table); @@ -284,6 +285,7
> @@
> > > static const struct of_device_id bq27xxx_battery_i2c_of_match_table[]=
 =3D {
> > >  	{ .compatible =3D "ti,bq27z561" },
> > >  	{ .compatible =3D "ti,bq28z610" },
> > >  	{ .compatible =3D "ti,bq34z100" },
> > > +	{ .compatible =3D "ti,bq78z100" },
> > >  	{},
> > >  };
> > >  MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
> > > diff --git a/include/linux/power/bq27xxx_battery.h
> > > b/include/linux/power/bq27xxx_battery.h
> > > index 111a40d0d3d5..ac17618043b1 100644
> > > --- a/include/linux/power/bq27xxx_battery.h
> > > +++ b/include/linux/power/bq27xxx_battery.h
> > > @@ -33,6 +33,7 @@ enum bq27xxx_chip {
> > >  	BQ27Z561,
> > >  	BQ28Z610,
> > >  	BQ34Z100,
> > > +	BQ78Z100,
> > >  };
> > >
> > >  struct bq27xxx_device_info;
> > > --
> > > 2.17.1
> > >
