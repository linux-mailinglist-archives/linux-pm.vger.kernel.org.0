Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D611171AC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 17:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfLIQbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 11:31:32 -0500
Received: from mail-mw2nam10on2130.outbound.protection.outlook.com ([40.107.94.130]:17473
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfLIQbc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 11:31:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4taHhlA9cP1sQvtzE7McAliosSbKtYY/HntLNKJdnosbWSRzY2d3TisUU8yN1gMxWyJ8822xcGIXam5brji03g28h9V9EZpMIcX+ZUq43Phopt6tV3N8thWNPc3uD2nR0+/HDaLeghWxNohsd+u2lZ/+VhWao/hinFWQXu/W/795FrrhXTBEH5rtbnuvlfojG8tkzatlHu/8yovGCEW8mZLbXttFHl7BxAjOjO6FeNnbup064ubl7vId/1PZLEPxn4Md2b/VmbwKUIgfNxbi25SSAtC1/zwL8lDPAFYU5ZN81dUYj3M3Lc1sVneTY0Oa97TVGbabx7qUeIfbeUy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwpsAQnULDJ8pcN+aHMeeinTzKknxNWBs4HSVe9zAwQ=;
 b=krrXzfjaDrQoDQKwduSX4bE+SvGcsxG0ZxLwR45yCNZs6f1edLb1bjY9WOLrx6tGlCgLJdEkp5Q9YDN06OJY4TEp0ijBvIQMtkR8NYsBD+QSzSZuaRiq0UVmqQ3UVzoDqDpICFUthL+mEdjPqlYFudYsJ4AWplauCc1mb3VNWivptrMxGe5p5Gqngk9hr71hFFBNrERCM9EDsuHqX3EWfBC+iN+KRc7grSLoFy4c/hif6pcUE5XfDxxC0PvnRk3e4KF4oMU/ZVehFeSLym4vMHz8stte7I+HdReoBcHNU8aUwyn66Nt3uTEQFPmqAwsmITmkxRaMA40zz35TssnAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwpsAQnULDJ8pcN+aHMeeinTzKknxNWBs4HSVe9zAwQ=;
 b=B/VCf/OcYveceHVsT4DbWQlkU+D61sNv5SgXx4+t2NaGnIj0p5AUXP8APacOrsxF4R0pYjJgswLzmE1Ev/hQfn8KpQ3eKcSzmW/YuwlurgShUZIOEvrwhBymJX2fL9ygWi1I6x6BHyfUWYlBSlXljZxMjl2UV51gEbzJ/BEzFKI=
Received: from BN8PR10MB3379.namprd10.prod.outlook.com (20.179.140.29) by
 BN8PR10MB3169.namprd10.prod.outlook.com (20.179.138.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 16:31:27 +0000
Received: from BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84]) by BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 16:31:27 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] thermal: armada: fix register offsets for AXP
Thread-Topic: [PATCH v2 1/2] thermal: armada: fix register offsets for AXP
Thread-Index: AQHVqtv7mxwVHsmesUi/W4BU64aP7qeqa2w8gAeNUACAAABEaQ==
Date:   Mon, 9 Dec 2019 16:31:26 +0000
Message-ID: <BN8PR10MB33792C7BA3B1D002AEDD25E08C580@BN8PR10MB3379.namprd10.prod.outlook.com>
References: <1575485367-18262-1-git-send-email-zhays@lexmark.com>
 <BN8PR10MB3379A954079A4ECF574E80DE8C5D0@BN8PR10MB3379.namprd10.prod.outlook.com>,<e2ed2a04-83c0-b346-4de0-0f92d6dd7fbf@linaro.org>
In-Reply-To: <e2ed2a04-83c0-b346-4de0-0f92d6dd7fbf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6700e64d-8e0c-4d80-1fa5-08d77cc53d04
x-ms-traffictypediagnostic: BN8PR10MB3169:
x-microsoft-antispam-prvs: <BN8PR10MB316996FB383345045D68BF368C580@BN8PR10MB3169.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(189003)(199004)(305945005)(55016002)(81166006)(5660300002)(81156014)(71190400001)(66446008)(8936002)(186003)(71200400001)(66556008)(76116006)(6506007)(6916009)(26005)(86362001)(52536014)(64756008)(478600001)(66946007)(9686003)(54906003)(316002)(66574012)(7696005)(66476007)(4326008)(44832011)(8676002)(33656002)(229853002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR10MB3169;H:BN8PR10MB3379.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoaQU9hOCt6/KCvhwzgAz9q7Ih/xV2rp31wbm0x5eQ8M0EiLdh/XpTPvncYg5vzFkWjVygoF9LMtW0/PRvA7BFSe/xyjqhudcXt5JGnl35S7UtuXZh4arvkv9ORv6+pR489VarHCRUVC4bvfeOCMqRLtzV+Uiu5ogLN8zsbouIXUvEFqGCPK6Ol9iSMnQoeLj5SbNE4c3i01f+Xj/JZndmDv2XUna1wSiluITfa39fvAvSYGLy7/9hoZHUerEvYv9otw6UCzx4ncHKKJUy0ZEIv0DX9ISw4yGDBfgyoMwpHIAgpBNKV7jHelSEVpZ7pJ4J84WU5gq3MPndMPRPtgvsEJcaGDswMKw4HY5vz7+IiaE3effI+P1ZKQ9eC7C6iPqhiJfEQJilHlCHvPCG7OTuAnJtbIv8PuvmVBcSfk9VDf0dJhaxYnNoXM0ia4I+kJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6700e64d-8e0c-4d80-1fa5-08d77cc53d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 16:31:26.9157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Btbwpjv2AxinfwA6Qp5MvX+UAEKvldXvrSeYrybttt7xwHNc7QN3qkd3Q+bMY1Qspn39tnjjunETFU3coz5NuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3169
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,=0A=
=0A=
>Hi Zak,=0A=
>=0A=
>what patch to pick up? V2 or V2?=0A=
I'm not sure I entirely understand your question. There are two patches:=0A=
=0A=
Zachary Hays  thermal: armada: fix register offsets for AXP=0A=
Zachary Hays  thermal: armada: clear reset in armadaxp_init=0A=
=0A=
Version 2 of each patch updates the commit message to add a "Signed-off-by"=
=0A=
and cleans up the commit message per Miqu=E8l's earlier comments. Otherwise=
 the=0A=
patches are the same as they were in version 1. The patch below is version =
2 of that first patch.=0A=
=0A=
Does that answer your question?=0A=
>=0A=
>What email is the correct one?=0A=
>=0A=
>        Zachary Hays <zhays@lexmark.com>=0A=
>or=0A=
>        Zak Hays <zak.hays@lexmark.com>=0A=
>=0A=
Both addresses route to the same place but "Zachary Hays <zhays@lexmark.com=
>" is preferable. Sorry for the confusion.=0A=
=0A=
>Also waiting for Miquel to ack the patch.=0A=
>=0A=
>Thanks=0A=
>=0A=
> -- Daniel=0A=
>=0A=
>=0A=
>On 05/12/2019 15:19, Zak Hays wrote:=0A=
>> As shown in its device tree, Armada XP has the control1 register at=0A=
>> 0x184d0, not 0x182d0.=0A=
>>=0A=
>> Signed-off-by: Zachary Hays <zhays@lexmark.com>=0A=
>> ---=0A=
>> v2: update commit title and add "Signed-off-by"=0A=
>> ---=0A=
>>  drivers/thermal/armada_thermal.c | 2 +-=0A=
>>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_t=
hermal.c=0A=
>> index 709a22f455e9..88363812033c 100644=0A=
>> --- a/drivers/thermal/armada_thermal.c=0A=
>> +++ b/drivers/thermal/armada_thermal.c=0A=
>> @@ -578,7 +578,7 @@ static const struct armada_thermal_data armadaxp_dat=
a =3D {=0A=
>>         .coef_m =3D 10000000ULL,=0A=
>>         .coef_div =3D 13825,=0A=
>>         .syscon_status_off =3D 0xb0,=0A=
>> -       .syscon_control1_off =3D 0xd0,=0A=
>> +       .syscon_control1_off =3D 0x2d0,=0A=
>>  };=0A=
>>=0A=
>>  static const struct armada_thermal_data armada370_data =3D {=0A=
>> --=0A=
>> 2.7.4=0A=
>>=
