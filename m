Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDA2E937E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 11:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbhADKkv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 05:40:51 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:54350
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbhADKku (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 05:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxuw8Zsi75Yj5yBs3cSJ1PEbDvXcRTm9Dc2j3GD/+wQ=;
 b=JcLhZCUwYaeT3oqvqMd5qEPKkdwEVg249+nfoJqwmGAM8STU0+EFSTWQ5a3f9z+PULay89NEa0Wl3KfR+mASO5n+hG38YzHU5tAeE/xT3aBGcP7fi1M3ABsrut8xUnxIFveVB6sCOWq2VJ8n4IjR4JimcQOL2x4CEBR5zSAGL4I=
Received: from AS8PR04CA0250.eurprd04.prod.outlook.com (2603:10a6:20b:330::15)
 by DB6PR04MB2984.eurprd04.prod.outlook.com (2603:10a6:6:b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.23; Mon, 4 Jan 2021 10:39:51 +0000
Received: from HE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:330:cafe::bc) by AS8PR04CA0250.outlook.office365.com
 (2603:10a6:20b:330::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Mon, 4 Jan 2021 10:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT016.mail.protection.outlook.com (10.152.0.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 10:39:51 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.50) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 04 Jan 2021 10:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaZlWn/knlAp1LiOfuYpT3h0P7tJbEeN1jOspvF20vdQZqo6Nv/lxtyqUn0WvChXGAqM9KyaXoSlMGvjIlMYqt4p6nKvHmmGSxJP4Pt9lJqqUfsvUUiGRXkDihBj2jJZsHZVDpk12DOQqB/EgqcbAC4sPwn0Oma5GkxtnyBlITxbrZxj6g22QBQJAPhk15Wm9x2fV0REmrzJtz4qL19US051BxH7i8de9eH2UylPRtcAay3tQuN9g2er9gh1k+LU/LjYVgn06lWARbWeSzUz34gegEvz7j9ODKUa+Pqj5veq2rf56NBTaar4HM5dLHUA70zcegd5/7IaK8fWg7v+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVvLNnvzefs+9ftk5itRzaIGbqt8ckYHq7oufpBCLck=;
 b=JX3NiFnfzsCwUjQfKLvJCALkWIPLrWaDv3qCmhl2NZ0WYZacwLcooEQoberTPhRUOs6aq2NFto1G4TiJPMnp05VtR2RR1sEgW2oMdNI6ZybwlQqDXXNNvfSjnTESECB75PBefqNVq1txrMPs0tv78YOG+2zGejGkQbIIGP3kCABkwSlcjaLeQ2dKuffq57xdfAvyCleUG4sZRpFdNe5Q05SulPBi7QkZp0/Ey59hBEjht1T+QgxGqLgwrgBnhYjmgw5kPPDt3Rzrwvs3i5LE6rOLtmWOaP9J5tk9oHQKIwUESGpTRJ1lVlVRjCHsd3f9g3AU0xGnnI5KmVVmp0rE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DBBPR04MB7532.eurprd04.prod.outlook.com (2603:10a6:10:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22; Mon, 4 Jan
 2021 10:39:45 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::29a8:2ae5:def6:f92b]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::29a8:2ae5:def6:f92b%7]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 10:39:45 +0000
Subject: Re: [PATCH v3] power/supply: Add ltc4162-l-charger
To:     Sebastian Reichel <sre@kernel.org>
CC:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201102092131.16604-1-mike.looijmans@topic.nl>
 <20201229145728.ghxgqiyzid7l2w2y@earth.universe>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.6d795c58-8569-4176-9caa-5b8521f5a78e@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.611c02c0-860c-415d-839f-06ce7775bc6a@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <3060e3c8-db71-c142-510e-4ce9c878f164@topic.nl>
Date:   Mon, 4 Jan 2021 11:39:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201229145728.ghxgqiyzid7l2w2y@earth.universe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [83.128.90.119]
X-ClientProxiedBy: AM0P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::28) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 10:39:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f33d089d-fd18-438e-391e-08d8b09d10dd
X-MS-TrafficTypeDiagnostic: DBBPR04MB7532:|DB6PR04MB2984:
X-Microsoft-Antispam-PRVS: <DB6PR04MB29840BBFE0E03B48EB99D9C996D20@DB6PR04MB2984.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: n+2vPh1arNak4rl9gfRHrpTxCFTM8Xdz/JMM1tF7cAQJnz2aVD8SiYk9RV0pD5hNIuAOeBkiumrY89JH5SthJtYRDySwaQcz9b1twRg+n/UlyhjIL8YdLxNlPiS3gi55VLrF5RVoy/kTDtn/YYaNnVSrllbmKVkZXzZbVS+9F7ydaqIRstO3dI8nA3EVYp5dLyWj9SHQUa8plaC7tBcPGLH/FLNlHYmXXhWLoF9n0NLCy0Rwc94J8Cn52ej+GbRPRJfw15XIALoQPkYyF1vBXFMW7mmwCSOkskjcEwhRYEI1ZOdJpiMs2Q6h5n/j0Ht4QAxo0DLWcw713T6K6U5/nIOQxDKX23+UHXk5vHoQjRI8oaphfTUgoHDQJ7lOguKX1solEgGT3mpwb4EnuZqFh6nCyECYfys+Sfb5FdCEiEZnUVHpo1gayJGNGhpEz6s1ZTLzPnoPyoZUsJX6l0TWyvFB7QESwtSuCqvAdkd4rpQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(366004)(136003)(396003)(346002)(31686004)(4326008)(53546011)(6916009)(31696002)(83170400001)(5660300002)(83380400001)(66946007)(36756003)(36916002)(44832011)(42882007)(52116002)(6486002)(8936002)(316002)(66476007)(66556008)(186003)(16526019)(478600001)(2906002)(16576012)(26005)(30864003)(2616005)(956004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FtYybcLOPU8q1FxbcqJXtw5/HQOIGYUHDrFkGx6MABCG62oxJvUALUUURKIz?=
 =?us-ascii?Q?ZC+eXK9X1XoXMzdMpHQO1daiKHuYJJ1tE2SYlnVKPywGerLM6N9pMXyzvDDT?=
 =?us-ascii?Q?KQlRPAdinh2LcEA0iusMtngC95dKY0f9sFuUxyF1p22rYnWvZGbfd14Qe7oD?=
 =?us-ascii?Q?1ben2pU/jT83IcdXMsUY6Ha+T/8EywlpeKvSkOVjZPx/FZR6i2zQ56jMCXBU?=
 =?us-ascii?Q?b8VIeBX3t8uO23CEWXymVLahHkvxSMdh/aFiG0utc3aUrpaG4PKhp4Ev6Imv?=
 =?us-ascii?Q?07vEK/1tEySuO6pnOaNXVhroAEl4mHfgeCfPjUwJASZkSnVuG5Dpygajr/zu?=
 =?us-ascii?Q?qCfu9xw5+T3XJE0d+/DwvO3GI9hT7/Gynh/ygeWIClJUWhIq/qDemSmgcflC?=
 =?us-ascii?Q?c4XANsNQzzXMvUfHoLthMJIQKK7up9uPewOv1NMYOZwB6irRgg4ledv609np?=
 =?us-ascii?Q?/LvoZkedFKXa5Pi8Aqw5033LLPggXPVhfboMNIfKX8mCHS945L4R+wh4ZBdd?=
 =?us-ascii?Q?S9wQXhsN73Moynla5sC2T1jQvCifzMa3Hda8mluqnc2nvZy3EjsSMzH9VW5v?=
 =?us-ascii?Q?5EdxnUfbhAAEblABWZw6ZkP/ni37fMGtGxa9Fz3EmppLlYbE63fFOeCdFXQJ?=
 =?us-ascii?Q?tFsWxtkmWL24gYAqM30J6gLoq6sn0QJCTxNzv12gWC5Pz9F4yI0UTi2zjhX1?=
 =?us-ascii?Q?ksAtwm9I1uYgnnX8LXkgvwZQtueU51L2fDuyKOPP6SfCBpH+8R+47tXVQnhA?=
 =?us-ascii?Q?tR/E1SjZokSgwbLXncGMPjgFEKmr1t0b6Z6kxsRvBbCfbBd4PE+E9BbW32GY?=
 =?us-ascii?Q?fchtTi6ZIWIjTFmVT7u3kN8/c+jAs+hQSOh3MvoLAsYaryTNfjqsdN+OXnY7?=
 =?us-ascii?Q?9YW2zhffGS8LGnD/QkAipNYmJ6DV2aRRBpPuHn/LK8RZ/sH4yEjfkuM/bzJ+?=
 =?us-ascii?Q?7//aH/iqoALAUsXKc6ncN3s4sHJVSXNsMvSLv73BIl6Xp8gOclg711z+zuKt?=
 =?us-ascii?Q?pYNn?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7532
X-CodeTwo-MessageID: 58652ba7-ec89-4e90-95ad-3d1661a2d23d.20210104103948@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2ea2b873-95ab-42d8-202d-08d8b09d0d60
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9kduhnh4MjvtaEWftv+RkACTOwrjrvCmVadGLVhojXvHHwzai+WVfBz0m662NLM5V3AYDN8+eTBq5WSzngf1iJh/K1ZCdxPoaU6GVaEwobNwsTwES/lHqVmr9ZQGtrv6Jbr/17SCmoQhmIKIUYFFDsVHNuwe1i9bzd8cyNQ60vOHNpZdVPpazpgti6/u7oHUt6J2m69oU9jqogaRguwQ8q9cDMEMmD7nMs3iPysD+/YA4FkmxqwskDLSG97N9M6IiX1GgutpU0JifxKFh9VvhOtrOpXojZ0V6YIEi/Xo6zb0/s8DUDeaOP4HM4r09YUow31qEgswr5z73CjeQSEAdgYfIVNLrEV2QJYj/i+rqUnI01cKt28fKSJC/H4djT4KGXHsmb5RvrADex8EwZwuXoJzuzT2DSF3vJ0gBv0LeluNLBGkTsz1OTinKkhWOW7u3nYAzLyNPhmyZBeRyGfkuFtj8Vq5KCZpMVlyak4WZzbtAGe5QorJMrbEGvyf2+IrwszKQ36fJ35OlOru0x6Nji13ciBK5dfRdeam/iTYtvLFe6YJug6GvjKut0MW4KF
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(396003)(346002)(39840400004)(136003)(376002)(46966006)(83170400001)(6916009)(356005)(42882007)(7636003)(7596003)(5660300002)(336012)(8936002)(30864003)(31696002)(83380400001)(44832011)(15974865002)(2906002)(70206006)(70586007)(36756003)(6486002)(82310400003)(4326008)(16576012)(53546011)(478600001)(8676002)(186003)(316002)(31686004)(16526019)(36916002)(2616005)(47076005)(26005)(956004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 10:39:51.1063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33d089d-fd18-438e-391e-08d8b09d10dd
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2984
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

No worries on processing time. Only drawback is that since the project=20
ended, I may no longer have access to the actual hardware for testing.

Further inline comments below.


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 29-12-2020 15:57, Sebastian Reichel wrote:
> Hi,
>
> Sorry for slow processing of this. Driver looks mostly fine, but I
> do have some comments.
>
> On Mon, Nov 02, 2020 at 10:21:31AM +0100, Mike Looijmans wrote:
>> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
>> reading back telemetry and to set some charging options like the input
>> current limit.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> v2: Use microohm units instead of milliohm
>>      Add interrupt support using smbalert
>>      Support obtaining cell-count from devicetree
>> v3: Fix overflows in calculations involving resistor values
>> resent, mail bounced
>>
>>   drivers/power/supply/Kconfig             |   8 +
>>   drivers/power/supply/Makefile            |   1 +
>>   drivers/power/supply/ltc4162-l-charger.c | 898 +++++++++++++++++++++++
>>   3 files changed, 907 insertions(+)
>>   create mode 100644 drivers/power/supply/ltc4162-l-charger.c
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index eec646c568b7..23000976cb42 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -513,6 +513,14 @@ config CHARGER_LT3651
>>   	  Say Y to include support for the Analog Devices (Linear Technology)
>>   	  LT3651 battery charger which reports its status via GPIO lines.
>>  =20
>> +config CHARGER_LTC4162L
>> +	tristate "LTC4162-L charger"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	help
>> +	  Say Y to include support for the Analog Devices (Linear Technology)
>> +	  LTC4162-L battery charger connected to I2C.
>> +
>>   config CHARGER_MAX14577
>>   	tristate "Maxim MAX14577/77836 battery charger driver"
>>   	depends on MFD_MAX14577
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefi=
le
>> index dd4b86318cd9..17b1cf921c44 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -70,6 +70,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
>>   obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
>>   obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
>>   obj-$(CONFIG_CHARGER_LT3651)	+=3D lt3651-charger.o
>> +obj-$(CONFIG_CHARGER_LTC4162L)	+=3D ltc4162-l-charger.o
>>   obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>>   obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector=
.o
>>   obj-$(CONFIG_CHARGER_MAX77650)	+=3D max77650-charger.o
>> diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/su=
pply/ltc4162-l-charger.c
>> new file mode 100644
>> index 000000000000..b2f666113125
>> --- /dev/null
>> +++ b/drivers/power/supply/ltc4162-l-charger.c
>> @@ -0,0 +1,898 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *  Driver for Analog Devices (Linear Technology) LTC4162-L charger IC.
>> + *  Copyright (C) 2020, Topic Embedded Products
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +
>> +/* Registers (names based on what datasheet uses) */
>> +#define LTC4162L_EN_LIMIT_ALERTS_REG		0x0D
>> +#define LTC4162L_EN_CHARGER_STATE_ALERTS_REG	0x0E
>> +#define LTC4162L_EN_CHARGE_STATUS_ALERTS_REG	0x0F
>> +#define LTC4162L_CONFIG_BITS_REG		0x14
>> +#define LTC4162L_IIN_LIMIT_TARGET		0x15
>> +#define LTC4162L_ARM_SHIP_MODE			0x19
>> +#define LTC4162L_CHARGE_CURRENT_SETTING		0X1A
>> +#define LTC4162L_VCHARGE_SETTING		0X1B
>> +#define LTC4162L_C_OVER_X_THRESHOLD		0x1C
>> +#define LTC4162L_MAX_CV_TIME			0X1D
>> +#define LTC4162L_MAX_CHARGE_TIME		0X1E
>> +#define LTC4162L_CHARGER_CONFIG_BITS		0x29
>> +#define LTC4162L_CHARGER_STATE			0x34
>> +#define LTC4162L_CHARGE_STATUS			0x35
>> +#define LTC4162L_LIMIT_ALERTS_REG		0x36
>> +#define LTC4162L_CHARGER_STATE_ALERTS_REG	0x37
>> +#define LTC4162L_CHARGE_STATUS_ALERTS_REG	0x38
>> +#define LTC4162L_SYSTEM_STATUS_REG		0x39
>> +#define LTC4162L_VBAT				0x3A
>> +#define LTC4162L_VIN				0x3B
>> +#define LTC4162L_VOUT				0x3C
>> +#define LTC4162L_IBAT				0x3D
>> +#define LTC4162L_IIN				0x3E
>> +#define LTC4162L_DIE_TEMPERATURE		0x3F
>> +#define LTC4162L_THERMISTOR_VOLTAGE		0x40
>> +#define LTC4162L_BSR				0x41
>> +#define LTC4162L_JEITA_REGION			0x42
>> +#define LTC4162L_CHEM_CELLS_REG			0x43
>> +#define LTC4162L_ICHARGE_DAC			0x44
>> +#define LTC4162L_VCHARGE_DAC			0x45
>> +#define LTC4162L_IIN_LIMIT_DAC			0x46
>> +#define LTC4162L_VBAT_FILT			0x47
>> +#define LTC4162L_INPUT_UNDERVOLTAGE_DAC		0x4B
>> +
>> +/* Enumeration as in datasheet. Individual bits are mutually exclusive.=
 */
>> +enum ltc4162l_state {
>> +	battery_detection =3D 2048,
>> +	charger_suspended =3D 256,
>> +	precharge =3D 128,   /* trickle on low bat voltage */
>> +	cc_cv_charge =3D 64, /* normal charge */
>> +	ntc_pause =3D 32,
>> +	timer_term =3D 16,
>> +	c_over_x_term =3D 8, /* battery is full */
>> +	max_charge_time_fault =3D 4,
>> +	bat_missing_fault =3D 2,
>> +	bat_short_fault =3D 1
>> +};
>> +
>> +/* Individual bits are mutually exclusive. Only active in charging stat=
es.*/
>> +enum ltc4162l_charge_status {
>> +	ilim_reg_active =3D 32,
>> +	thermal_reg_active =3D 16,
>> +	vin_uvcl_active =3D 8,
>> +	iin_limit_active =3D 4,
>> +	constant_current =3D 2,
>> +	constant_voltage =3D 1,
>> +	charger_off =3D 0
>> +};
> +use BIT(0), BIT(1), ...

I'm okay with that. This was actually a copy&paste job from the=20
datasheet, and though these look like bit fields, only one bit is ever=20
set. So BIT(x) might be misleading in that respect. Hence I preferred=20
keeping it as the datasheet listed it.

>
>> +/* Magic number to write to ARM_SHIP_MODE register */
>> +#define LTC4162L_ARM_SHIP_MODE_MAGIC 21325
>> +
>> +struct ltc4162l_info {
>> +	struct i2c_client	*client;
>> +	struct regmap		*regmap;
>> +	struct power_supply	*charger;
>> +	u32 rsnsb;	/* Series resistor that sets charge current, microOhm */
>> +	u32 rsnsi;	/* Series resistor to measure input current, microOhm */
>> +	u8 cell_count;	/* Number of connected cells, 0 while unknown */
>> +};
>> +
>> +static u8 ltc4162l_get_cell_count(struct ltc4162l_info *info)
>> +{
>> +	int ret;
>> +	unsigned int val;
>> +
>> +	/* Once read successfully */
>> +	if (info->cell_count)
>> +		return info->cell_count;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_CHEM_CELLS_REG, &val);
>> +	if (ret)
>> +		return 0;
>> +
>> +	/* Lower 4 bits is the cell count, or 0 if the chip doesn't know yet *=
/
>> +	val &=3D 0x0f;
>> +	if (!val)
>> +		return 0;
>> +
>> +	/* Once determined, keep the value */
>> +	info->cell_count =3D val;
>> +
>> +	return val;
>> +};
>> +
>> +/* Convert enum value to POWER_SUPPLY_STATUS value */
>> +static int ltc4162l_state_decode(enum ltc4162l_state value)
>> +{
>> +	switch (value) {
>> +	case precharge:
>> +	case cc_cv_charge:
>> +		return POWER_SUPPLY_STATUS_CHARGING;
>> +	case c_over_x_term:
>> +		return POWER_SUPPLY_STATUS_FULL;
>> +	case bat_missing_fault:
>> +	case bat_short_fault:
>> +		return POWER_SUPPLY_STATUS_UNKNOWN;
>> +	default:
>> +		return POWER_SUPPLY_STATUS_NOT_CHARGING;
>> +	}
>> +};
>> +
>> +static int ltc4162l_get_status(struct ltc4162l_info *info,
>> +			       union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGER_STATE, &regval);
>> +	if (ret) {
>> +		dev_err(&info->client->dev, "Failed to read CHARGER_STATE\n");
>> +		return ret;
>> +	}
>> +
>> +	val->intval =3D ltc4162l_state_decode(regval);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_charge_status_decode(enum ltc4162l_charge_status va=
lue)
>> +{
>> +	if (!value)
>> +		return POWER_SUPPLY_CHARGE_TYPE_NONE;
>> +
>> +	/* constant voltage/current and input_current limit are "fast" modes *=
/
>> +	if (value <=3D iin_limit_active)
>> +		return POWER_SUPPLY_CHARGE_TYPE_FAST;
>> +
>> +	/* Anything that's not fast we'll return as trickle */
>> +	return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
>> +}
>> +
>> +static int ltc4162l_get_charge_type(struct ltc4162l_info *info,
>> +				    union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGE_STATUS, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val->intval =3D ltc4162l_charge_status_decode(regval);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_state_to_health(enum ltc4162l_state value)
>> +{
>> +	switch (value) {
>> +	case ntc_pause:
>> +		return POWER_SUPPLY_HEALTH_OVERHEAT;
>> +	case timer_term:
>> +		return POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
>> +	case max_charge_time_fault:
>> +		return POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE;
>> +	case bat_missing_fault:
>> +		return POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>> +	case bat_short_fault:
>> +		return POWER_SUPPLY_HEALTH_DEAD;
>> +	default:
>> +		return POWER_SUPPLY_HEALTH_GOOD;
>> +	}
>> +}
>> +
>> +static int ltc4162l_get_health(struct ltc4162l_info *info,
>> +			       union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGER_STATE, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val->intval =3D ltc4162l_state_to_health(regval);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_get_online(struct ltc4162l_info *info,
>> +			       union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_SYSTEM_STATUS_REG, &regval)=
;
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* BIT(2) indicates if input voltage is sufficient to charge */
>> +	val->intval =3D !!(regval & BIT(2));
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +static int ltc4162l_get_vbat(struct ltc4162l_info *info,
>> +				  unsigned int reg,
>> +				  union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, reg, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* cell_count =C3=97 192.4=CE=BCV/LSB */
>> +	regval *=3D 1924;
>> +	regval *=3D ltc4162l_get_cell_count(info);
>> +	regval /=3D 10;
>> +	val->intval =3D regval;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_get_ibat(struct ltc4162l_info *info,
>> +			     union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_IBAT, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Signed 16-bit number, 1.466=CE=BCV / RSNSB amperes/LSB. */
>> +	ret =3D (s16)(regval & 0xFFFF);
>> +	val->intval =3D 100 * mult_frac(ret, 14660, (int)info->rsnsb);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_get_icharge(struct ltc4162l_info *info,
>> +				unsigned int reg,
>> +				union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, reg, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
>> +
>> +	/* The charge current servo level: (icharge_dac + 1) =C3=97 1mV/RSNSB =
*/
>> +	++regval;
>> +	val->intval =3D 10000u * mult_frac(regval, 100000u, info->rsnsb);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_set_icharge(struct ltc4162l_info *info,
>> +				unsigned int reg,
>> +				unsigned int value)
>> +{
>> +	value =3D mult_frac(value, info->rsnsb, 100000u);
>> +	value /=3D 10000u;
>> +
>> +	/* Round to lowest possible */
>> +	if (value)
>> +		--value;
>> +
>> +	if (value > 31)
>> +		return -EINVAL;
>> +
>> +	return regmap_write(info->regmap, reg, value);
>> +}
>> +
>> +
>> +static int ltc4162l_get_vcharge(struct ltc4162l_info *info,
>> +				unsigned int reg,
>> +				union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +	u32 voltage;
>> +
>> +	ret =3D regmap_read(info->regmap, reg, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
>> +
>> +	/*
>> +	 * charge voltage setting can be computed from
>> +	 * cell_count =C3=97 (vcharge_setting =C3=97 12.5mV + 3.8125V)
>> +	 * where vcharge_setting ranges from 0 to 31 (4.2V max).
>> +	 */
>> +	voltage =3D 3812500 + (regval * 12500);
>> +	voltage *=3D ltc4162l_get_cell_count(info);
>> +	val->intval =3D voltage;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_set_vcharge(struct ltc4162l_info *info,
>> +				unsigned int reg,
>> +				unsigned int value)
>> +{
>> +	u8 cell_count =3D ltc4162l_get_cell_count(info);
>> +
>> +	if (!cell_count)
>> +		return -EBUSY; /* Not available yet, try again later */
>> +
>> +	value /=3D cell_count;
>> +
>> +	if (value < 3812500)
>> +		return -EINVAL;
>> +
>> +	value -=3D 3812500;
>> +	value /=3D 12500;
>> +
>> +	if (value > 31)
>> +		return -EINVAL;
>> +
>> +	return regmap_write(info->regmap, reg, value);
>> +}
>> +
>> +static int ltc4162l_get_iin_limit_dac(struct ltc4162l_info *info,
>> +				     union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_IIN_LIMIT_DAC, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval &=3D BIT(6) - 1; /* Only 6 bits */
>> +
>> +	/* (iin_limit_dac + 1) =C3=97 500=CE=BCV / RSNSI */
>> +	++regval;
>> +	regval *=3D 5000000u;
>> +	regval /=3D info->rsnsi;
>> +	val->intval =3D 100u * regval;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_set_iin_limit(struct ltc4162l_info *info,
>> +				  unsigned int value)
>> +{
>> +	unsigned int regval;
>> +
>> +	regval =3D mult_frac(value, info->rsnsi, 50000u);
>> +	regval /=3D 10000u;
>> +	if (regval)
>> +		--regval;
>> +	if (regval > 63)
>> +		regval =3D 63;
>> +
>> +	return regmap_write(info->regmap, LTC4162L_IIN_LIMIT_TARGET, regval);
>> +}
>> +
>> +static int ltc4162l_get_die_temp(struct ltc4162l_info *info,
>> +				 union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_DIE_TEMPERATURE, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* die_temp =C3=97 0.0215=C2=B0C/LSB - 264.4=C2=B0C */
>> +	ret =3D (s16)(regval & 0xFFFF);
>> +	ret *=3D 215;
>> +	ret /=3D 100; /* Centidegrees scale */
>> +	ret -=3D 26440;
>> +	val->intval =3D ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_get_term_current(struct ltc4162l_info *info,
>> +				     union power_supply_propval *val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGER_CONFIG_BITS, &regva=
l);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Check if C_OVER_X_THRESHOLD is enabled */
>> +	if (!(regval & BIT(2))) {
>> +		val->intval =3D 0;
>> +		return 0;
>> +	}
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_C_OVER_X_THRESHOLD, &regval=
);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* 1.466=CE=BCV / RSNSB amperes/LSB */
>> +	regval *=3D 14660u;
>> +	regval /=3D info->rsnsb;
>> +	val->intval =3D 100 * regval;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_set_term_current(struct ltc4162l_info *info,
>> +				     unsigned int value)
>> +{
>> +	int ret;
>> +	unsigned int regval;
>> +
>> +	if (!value) {
>> +		/* Disable en_c_over_x_term when set to zero */
>> +		return regmap_update_bits(info->regmap,
>> +					  LTC4162L_CHARGER_CONFIG_BITS,
>> +					  BIT(2), 0);
>> +	}
>> +
>> +	regval =3D mult_frac(value, info->rsnsb, 14660u);
>> +	regval /=3D 100u;
>> +
>> +	ret =3D  regmap_write(info->regmap, LTC4162L_C_OVER_X_THRESHOLD, regva=
l);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set en_c_over_x_term after changing the threshold value */
>> +	return regmap_update_bits(info->regmap, LTC4162L_CHARGER_CONFIG_BITS,
>> +				  BIT(2), BIT(2));
>> +}
>> +
>> +/* Custom properties */
>> +static const char * const ltc4162l_charge_status_name[] =3D {
>> +	"ilim_reg_active", /* 32 */
>> +	"thermal_reg_active",
>> +	"vin_uvcl_active",
>> +	"iin_limit_active",
>> +	"constant_current",
>> +	"constant_voltage",
>> +	"charger_off" /* 0 */
>> +};
>> +
>> +static ssize_t charge_status_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +	const char *result =3D ltc4162l_charge_status_name[
>> +				ARRAY_SIZE(ltc4162l_charge_status_name) - 1];
>> +	unsigned int regval;
>> +	unsigned int mask;
>> +	unsigned int index;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGE_STATUS, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Only one bit is set according to datasheet, let's be safe here */
>> +	for (mask =3D 32, index =3D 0; mask !=3D 0; mask >>=3D 1, ++index) {
>> +		if (regval & mask) {
>> +			result =3D ltc4162l_charge_status_name[index];
>> +			break;
>> +		}
>> +	}
>> +
>> +	return sprintf(buf, "%s\n", result);
>> +}
>> +static DEVICE_ATTR_RO(charge_status);
>> +
>> +static ssize_t input_voltage_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_VIN, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* 1.649mV/LSB */
>> +	regval *=3D 1694;
>> +
>> +	return sprintf(buf, "%u\n", regval);
>> +}
>> +static DEVICE_ATTR_RO(input_voltage);
>> +
>> +static ssize_t input_current_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_IIN, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Signed 16-bit number, 1.466=CE=BCV / RSNSI amperes/LSB. */
>> +	ret =3D (s16)(regval & 0xFFFF);
>> +	ret *=3D 14660;
>> +	ret /=3D info->rsnsi;
>> +	ret *=3D 100;
>> +
>> +	return sprintf(buf, "%d\n", ret);
>> +}
>> +static DEVICE_ATTR_RO(input_current);
>> +
>> +static ssize_t force_telemetry_show(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_CONFIG_BITS_REG, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sprintf(buf, "%u\n", regval & BIT(2) ? 1 : 0);
>> +}
>> +
>> +static ssize_t force_telemetry_store(struct device *dev,
>> +	struct device_attribute *attr,
>> +	const char *buf,
>> +	size_t count)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +	int ret;
>> +	unsigned int value;
>> +
>> +	ret =3D kstrtouint(buf, 0, &value);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D regmap_update_bits(info->regmap, LTC4162L_CONFIG_BITS_REG,
>> +				 BIT(2), value ? BIT(2) : 0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(force_telemetry);
>> +
>> +static ssize_t arm_ship_mode_show(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	ret =3D regmap_read(info->regmap, LTC4162L_ARM_SHIP_MODE, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return sprintf(buf, "%u\n",
>> +		regval =3D=3D LTC4162L_ARM_SHIP_MODE_MAGIC ? 1 : 0);
>> +}
>> +
>> +static ssize_t arm_ship_mode_store(struct device *dev,
>> +	struct device_attribute *attr,
>> +	const char *buf,
>> +	size_t count)
>> +{
>> +	struct power_supply *psy =3D to_power_supply(dev);
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +	int ret;
>> +	unsigned int value;
>> +
>> +	ret =3D kstrtouint(buf, 0, &value);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D regmap_write(info->regmap, LTC4162L_ARM_SHIP_MODE,
>> +				value ? LTC4162L_ARM_SHIP_MODE_MAGIC : 0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(arm_ship_mode);
>> +
>> +static struct attribute *ltc4162l_sysfs_entries[] =3D {
>> +	&dev_attr_charge_status.attr,
>> +	&dev_attr_input_voltage.attr,
>> +	&dev_attr_input_current.attr,
>> +	&dev_attr_force_telemetry.attr,
>> +	&dev_attr_arm_ship_mode.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group ltc4162l_attr_group =3D {
>> +	.name	=3D NULL,	/* put in device directory */
>> +	.attrs	=3D ltc4162l_sysfs_entries,
>> +};
>> +
>> +static int ltc4162l_get_property(struct power_supply *psy,
>> +				 enum power_supply_property psp,
>> +				 union power_supply_propval *val)
>> +{
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		return ltc4162l_get_status(info, val);
>> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
>> +		return ltc4162l_get_charge_type(info, val);
>> +	case POWER_SUPPLY_PROP_HEALTH:
>> +		return ltc4162l_get_health(info, val);
>> +	case POWER_SUPPLY_PROP_ONLINE:
>> +		return ltc4162l_get_online(info, val);
>> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +		return ltc4162l_get_vbat(info, LTC4162L_VBAT, val);
>> +	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
>> +		return ltc4162l_get_vbat(info, LTC4162L_VBAT_FILT, val);
>> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
>> +		return ltc4162l_get_ibat(info, val);
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>> +		return ltc4162l_get_icharge(info,
>> +				LTC4162L_ICHARGE_DAC, val);
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>> +		return ltc4162l_get_icharge(info,
>> +				LTC4162L_CHARGE_CURRENT_SETTING, val);
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>> +		return ltc4162l_get_vcharge(info,
>> +				LTC4162L_VCHARGE_DAC, val);
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>> +		return ltc4162l_get_vcharge(info,
>> +				LTC4162L_VCHARGE_SETTING, val);
>> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +		return ltc4162l_get_iin_limit_dac(info, val);
>> +	case POWER_SUPPLY_PROP_TEMP:
>> +		return ltc4162l_get_die_temp(info, val);
>> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
>> +		return ltc4162l_get_term_current(info, val);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ltc4162l_set_property(struct power_supply *psy,
>> +					 enum power_supply_property psp,
>> +					 const union power_supply_propval *val)
>> +{
>> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>> +		return ltc4162l_set_icharge(info,
>> +				LTC4162L_CHARGE_CURRENT_SETTING, val->intval);
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>> +		return ltc4162l_set_vcharge(info,
>> +				LTC4162L_VCHARGE_SETTING, val->intval);
>> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +		return ltc4162l_set_iin_limit(info, val->intval);
>> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
>> +		return ltc4162l_set_term_current(info, val->intval);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ltc4162l_property_is_writeable(struct power_supply *psy,
>> +						enum power_supply_property psp)
>> +{
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
>> +		return 1;
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +/* Charger power supply property routines */
>> +static enum power_supply_property ltc4162l_properties[] =3D {
>> +	POWER_SUPPLY_PROP_STATUS,
>> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
>> +	POWER_SUPPLY_PROP_HEALTH,
>> +	POWER_SUPPLY_PROP_ONLINE,
>> +	POWER_SUPPLY_PROP_VOLTAGE_NOW, /* Reports battery voltage */
>> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
>> +	POWER_SUPPLY_PROP_CURRENT_NOW, /* Reports battery current */
> above 3 properties should describe input voltage/current for chargers,
> see Documentation/ABI/testing/sysfs-class-power
>
> Battery IBAT and VBAT can currently only be reported from
> POWER_SUPPLY_TYPE_BATTERY.

So what should I do? Change the reported type to battery? Or make ibat=20
ad vbat into custom properties and report input current/voltage here=20
instead?

>
>> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
>> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>> +	POWER_SUPPLY_PROP_TEMP,
>> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
>> +};
>> +
>> +static const struct power_supply_desc ltc4162l_desc =3D {
>> +	.name		=3D "ltc4162-l",
>> +	.type		=3D POWER_SUPPLY_TYPE_MAINS,
>> +	.properties	=3D ltc4162l_properties,
>> +	.num_properties	=3D ARRAY_SIZE(ltc4162l_properties),
>> +	.get_property	=3D ltc4162l_get_property,
>> +	.set_property	=3D ltc4162l_set_property,
>> +	.property_is_writeable =3D ltc4162l_property_is_writeable,
>> +};
>> +
>> +static bool ltc4162l_is_writeable_reg(struct device *dev, unsigned int =
reg)
>> +{
>> +	/* all registers up to this one are writeable */
>> +	if (reg <=3D LTC4162L_CHARGER_CONFIG_BITS)
>> +		return true;
>> +
>> +	/* The ALERTS registers can be written to clear alerts */
>> +	if (reg >=3D LTC4162L_LIMIT_ALERTS_REG &&
>> +	    reg <=3D LTC4162L_CHARGE_STATUS_ALERTS_REG)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static bool ltc4162l_is_volatile_reg(struct device *dev, unsigned int r=
eg)
>> +{
>> +	/* all registers after this one are read-only status registers */
>> +	return reg > LTC4162L_CHARGER_CONFIG_BITS;
>> +}
>> +
>> +static const struct regmap_config ltc4162l_regmap_config =3D {
>> +	.reg_bits	=3D 8,
>> +	.val_bits	=3D 16,
>> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
>> +	.writeable_reg	=3D ltc4162l_is_writeable_reg,
>> +	.volatile_reg	=3D ltc4162l_is_volatile_reg,
>> +	.max_register	=3D LTC4162L_INPUT_UNDERVOLTAGE_DAC,
>> +	.cache_type	=3D REGCACHE_RBTREE,
>> +};
>> +
>> +static void ltc4162l_clear_interrupts(struct ltc4162l_info *info)
>> +{
>> +	/* Acknowledge interrupt to chip by clearing all events */
>> +	regmap_write(info->regmap, LTC4162L_LIMIT_ALERTS_REG, 0);
>> +	regmap_write(info->regmap, LTC4162L_CHARGER_STATE_ALERTS_REG, 0);
>> +	regmap_write(info->regmap, LTC4162L_CHARGE_STATUS_ALERTS_REG, 0);
>> +}
>> +
>> +static int ltc4162l_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	struct i2c_adapter *adapter =3D client->adapter;
>> +	struct device *dev =3D &client->dev;
>> +	struct ltc4162l_info *info;
>> +	struct power_supply_config ltc4162l_config =3D {};
>> +	u32 value;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
>> +		dev_err(dev, "No support for SMBUS_WORD_DATA\n");
>> +		return -ENODEV;
>> +	}
>> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	info->client =3D client;
>> +	i2c_set_clientdata(client, info);
>> +
>> +	info->regmap =3D devm_regmap_init_i2c(client, &ltc4162l_regmap_config)=
;
>> +	if (IS_ERR(info->regmap)) {
>> +		dev_err(dev, "Failed to initialize register map\n");
>> +		return PTR_ERR(info->regmap);
>> +	}
>> +
>> +	ret =3D device_property_read_u32(dev, "lltc,rsnsb-micro-ohms",
>> +				       &info->rsnsb);
>> +	if (ret) {
>> +		dev_err(dev, "Missing lltc,rsnsb-micro-ohms property\n");
>> +		return ret;
>> +	}
>> +	if (!info->rsnsb)
>> +		return -EINVAL;
>> +
>> +	ret =3D device_property_read_u32(dev, "lltc,rsnsi-micro-ohms",
>> +				       &info->rsnsi);
>> +	if (ret) {
>> +		dev_err(dev, "Missing lltc,rsnsi-micro-ohms property\n");
>> +		return ret;
>> +	}
>> +	if (!info->rsnsi)
>> +		return -EINVAL;
>> +
>> +	if (!device_property_read_u32(dev, "lltc,cell-count", &value))
>> +		info->cell_count =3D value;
>> +
>> +	ltc4162l_config.of_node =3D dev->of_node;
>> +	ltc4162l_config.drv_data =3D info;
>> +
>> +	info->charger =3D devm_power_supply_register(dev, &ltc4162l_desc,
>> +						   &ltc4162l_config);
>> +	if (IS_ERR(info->charger)) {
>> +		dev_err(dev, "Failed to register charger\n");
>> +		return PTR_ERR(info->charger);
>> +	}
>> +
>> +	ret =3D sysfs_create_group(&info->charger->dev.kobj,
>> +				 &ltc4162l_attr_group);
>> +	if (ret)
>> +		dev_err(dev, "failed to create extra sysfs entries\n");
> please use '.attr_grp' in ltc4162l_config, which means the
> attributes are registered together with the power-supply
> device avoiding a udev race condition. The change also
> simplifies the driver code, since (de)registration happens
> automatically :)

Good tip, missed that.


>
>> +	/* Disable the threshold alerts, we're not using them */
>> +	regmap_write(info->regmap, LTC4162L_EN_LIMIT_ALERTS_REG, 0);
>> +
>> +	/* Enable interrupts on all status changes */
>> +	regmap_write(info->regmap, LTC4162L_EN_CHARGER_STATE_ALERTS_REG,
>> +		     0x1fff);
>> +	regmap_write(info->regmap, LTC4162L_EN_CHARGE_STATUS_ALERTS_REG, 0x1f)=
;
>> +
>> +	ltc4162l_clear_interrupts(info);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc4162l_remove(struct i2c_client *client)
>> +{
>> +	struct ltc4162l_info *info =3D i2c_get_clientdata(client);
>> +
>> +	sysfs_remove_group(&info->charger->dev.kobj, &ltc4162l_attr_group);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ltc4162l_alert(struct i2c_client *client,
>> +			   enum i2c_alert_protocol type, unsigned int flag)
>> +{
>> +	struct ltc4162l_info *info =3D i2c_get_clientdata(client);
>> +
>> +	if (type !=3D I2C_PROTOCOL_SMBUS_ALERT)
>> +		return;
>> +
>> +	ltc4162l_clear_interrupts(info);
>> +	power_supply_changed(info->charger);
>> +}
>> +
>> +static const struct i2c_device_id ltc4162l_i2c_id_table[] =3D {
>> +	{ "ltc4162-l", 0 },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ltc4162l_i2c_id_table);
>> +
>> +static const struct of_device_id ltc4162l_of_match[] =3D {
>> +	{ .compatible =3D "lltc,ltc4162-l", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ltc4162l_of_match);
>> +
>> +static struct i2c_driver ltc4162l_driver =3D {
>> +	.probe		=3D ltc4162l_probe,
>> +	.remove		=3D ltc4162l_remove,
>> +	.alert		=3D ltc4162l_alert,
>> +	.id_table	=3D ltc4162l_i2c_id_table,
>> +	.driver =3D {
>> +		.name		=3D "ltc4162-l-charger",
>> +		.of_match_table	=3D of_match_ptr(ltc4162l_of_match),
>> +	},
>> +};
>> +module_i2c_driver(ltc4162l_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
>> +MODULE_DESCRIPTION("LTC4162-L charger driver");
> Otherwise LGTM. Please send bindings and driver as a series next
> time :)
>
> Thanks,
>
> -- Sebastian


--=20
Mike Looijmans

