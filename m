Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA94117245
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLIQ6z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 11:58:55 -0500
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com ([40.107.244.98]:39781
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbfLIQ6z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Dec 2019 11:58:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3OV0i/7p8gSznzKelJyT/VtdOBffVt8v0bqgBRT0T6j5tmrZT/fYVUWQeWgABOVaP4VkWR768RhHaAa+FqNgFfCSU8ZKoPLzhEqU9nsF1cVulrDM3rGbbVF75SKimPdtzCXdcfWz2HpY515KKaQiNNOUOZiFCNrpRnB8ebbkPPRGjdPxNuAbr0Ztq7px0jfrGgRoZIzRrB2Ag8IpU/fUNaLNUGx/DJTjaLIrTXT2TV+nrGFrZ6/aQCMQKQzT/ZJu95GltHrMOjfDwQmHZI5g/nggTZZHIcdJPVVmffMHC/DVLVCnhqc/80pPtYMV679NgZR4lO8LbChPl2gyCHGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ISClUF4aTL3Q7+DaT2dfdevxKnfeh0lR7zCUwyyANM=;
 b=fL7CMyFNAom6LAzwjPKJRx9PLsyj8bCNVLKXMU3njQXdzHh4DIiFOQTorWr5eIP85tfTAzeqyUy5/FXPZmf+jMVSxqfK6czE1el1dAS5OIwJVJBeKIQDITZJFgLX3t5Y46YGrVk7Hw3zcvrKiYRUYjvoAnbNtIC9F5/KM3eaI3eKZp5J6DNiWwOdthGE7orOzNgzs0B2vVHiUxRytrlt/kaffzKVetphHYmbc1RiYwPPR0tv7NqUxDjjfVmvkSRGZbM1nRdtKE2iE99AZmA+OZPfvi0aIBOX1ycTijyXEs2UZdcxm1Hwq5zwi6AZYTPC4fc8Wi+E4gPqNcm4WrQQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ISClUF4aTL3Q7+DaT2dfdevxKnfeh0lR7zCUwyyANM=;
 b=CHlARLcNJ9CRULLDAXtek1qs+IRkjy8aCHVjXL7GhU7RrnFz38dZ63ST6mI6hZpDPd7pSkxu5MGw/+MHposnN+qEesWgIc930x6q+sU5N92sxlwqCxW0cxwbKlXZbBAit6RVhViUTGXctXTizYU7fbUb9C0ExQ83g1/k8iHXJog=
Received: from BN8PR10MB3379.namprd10.prod.outlook.com (20.179.140.29) by
 BN8PR10MB3268.namprd10.prod.outlook.com (20.179.140.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Mon, 9 Dec 2019 16:58:12 +0000
Received: from BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84]) by BN8PR10MB3379.namprd10.prod.outlook.com
 ([fe80::9d23:4a97:d48a:7f84%7]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 16:58:12 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] thermal: armada: fix register offsets for AXP
Thread-Topic: [PATCH v2 1/2] thermal: armada: fix register offsets for AXP
Thread-Index: AQHVqtv7mxwVHsmesUi/W4BU64aP7qeqa2w8gAeNUACAAABEaYAAD8WAgAABepw=
Date:   Mon, 9 Dec 2019 16:58:12 +0000
Message-ID: <BN8PR10MB337975A77D726FDAFA9F13598C580@BN8PR10MB3379.namprd10.prod.outlook.com>
References: <1575485367-18262-1-git-send-email-zhays@lexmark.com>
 <BN8PR10MB3379A954079A4ECF574E80DE8C5D0@BN8PR10MB3379.namprd10.prod.outlook.com>
 <e2ed2a04-83c0-b346-4de0-0f92d6dd7fbf@linaro.org>
 <BN8PR10MB33792C7BA3B1D002AEDD25E08C580@BN8PR10MB3379.namprd10.prod.outlook.com>,<6c4e79ab-313c-5bb5-1489-329d916bd947@linaro.org>
In-Reply-To: <6c4e79ab-313c-5bb5-1489-329d916bd947@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c12cfdef-9c68-403b-b300-08d77cc8fa04
x-ms-traffictypediagnostic: BN8PR10MB3268:
x-microsoft-antispam-prvs: <BN8PR10MB32682FA8A853DB8E8618B8728C580@BN8PR10MB3268.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(54534003)(199004)(189003)(55016002)(33656002)(9686003)(6506007)(7696005)(54906003)(4326008)(66574012)(8676002)(186003)(53546011)(44832011)(8936002)(81166006)(81156014)(71190400001)(71200400001)(26005)(76116006)(229853002)(66946007)(6916009)(66556008)(66476007)(305945005)(478600001)(52536014)(86362001)(316002)(2906002)(64756008)(5660300002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR10MB3268;H:BN8PR10MB3379.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r513l7AIKtmVRR/Vb9p4rBDaeTLWbQfgW0RPU+o+dBSlWVvdIu4+en+UfYwPiqMWub0px79J+lr7YDtEutBYs1cBzG7dJ9M5Xa37mk6iySvClPuh/Ct2es9n8QU9prLRcVVRSeWI9QxmDhZqYv7x4dMcvjCTB3VtQmdfk8qQzDDQhSIG4yg42DrkfyBJDfVPLnglCg2ouB9snKbFyGanlxFT+1wWp9cbcTjjfr8DYEW5u/A60JiSJyOY4VlkM1UpInxU9gjYRMUI5A63/z+CfY5nOjercse9xq5JBOHr/DTOrtrif2bwjsmIuZ/7Y/qRrC9N+QywhQtBaUd1Nu6vhSTZDvi9cx6rYLRhEWnWr2p0lXzBZiCDbsOIuOTP94Fabg69ShbeDPIioU4MD8oS3pQnGqRNemrYJnasTEPlArIjUyMUwxB+rcxjYr2F6/wzaWnG9wVq6cIXjaODIq1guhy5iUtDk/AqFolOpPsbLps9qrHXN4KY+Jfq5KAJsGqH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12cfdef-9c68-403b-b300-08d77cc8fa04
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 16:58:12.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVNmMkrxfwadUo1U7mDBHNqtJRzqAyZV1EK29CrtemyxdDk02W1MI18/Vj4ts2ohP+JxkOYQLC4rC15Y8ky7yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3268
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>On 09/12/2019 17:31, Zak Hays wrote:=0A=
>> Hi Daniel,=0A=
>>=0A=
>>> Hi Zak,=0A=
>>>=0A=
>>> what patch to pick up? V2 or V2?=0A=
>> I'm not sure I entirely understand your question. There are two patches:=
=0A=
>>=0A=
>> Zachary Hays  thermal: armada: fix register offsets for AXP=0A=
>> Zachary Hays  thermal: armada: clear reset in armadaxp_init=0A=
>=0A=
>I'm seeing multiple posting of the V2 and reply to V2 with I guess a=0A=
>changelog added.=0A=
>=0A=
>It is very difficult to deal with patches when it is unclear, duplicate=0A=
>series with different changelog.=0A=
>=0A=
>In the future, post a resend version explaining what was missing, so it=0A=
>is easier to understand what is happening. Or send a V3.=0A=
=0A=
Ah. I understand now. I've been fighting email issues trying to get these p=
atches sent and=0A=
inadvertently sent out multiple versions of the same patches. The most rece=
nt patches=0A=
are correct. Sorry for that spam. Shouldn't happen again.=0A=
=0A=
Would you like me to resend as V3 for clarity or would you prefer to contin=
ue with the=0A=
V2 patches?=0A=
=0A=
>=0A=
>> Version 2 of each patch updates the commit message to add a "Signed-off-=
by"=0A=
>> and cleans up the commit message per Miqu=E8l's earlier comments. Otherw=
ise the=0A=
>> patches are the same as they were in version 1. The patch below is versi=
on 2 of that first patch.=0A=
>>=0A=
>> Does that answer your question?=0A=
>>>=0A=
>>> What email is the correct one?=0A=
>>>=0A=
>>>        Zachary Hays <zhays@lexmark.com>=0A=
>>> or=0A=
>>>        Zak Hays <zak.hays@lexmark.com>=0A=
>>>=0A=
>> Both addresses route to the same place but "Zachary Hays <zhays@lexmark.=
com>" is preferable. Sorry for the confusion.=0A=
>>=0A=
>>> Also waiting for Miquel to ack the patch.=0A=
>>>=0A=
>>> Thanks=0A=
>>>=0A=
>>> -- Daniel=0A=
>>>=0A=
>>>=0A=
>>> On 05/12/2019 15:19, Zak Hays wrote:=0A=
>>>> As shown in its device tree, Armada XP has the control1 register at=0A=
>>>> 0x184d0, not 0x182d0.=0A=
>>>>=0A=
>>>> Signed-off-by: Zachary Hays <zhays@lexmark.com>=0A=
>>>> ---=0A=
>>>> v2: update commit title and add "Signed-off-by"=0A=
>>>> ---=0A=
>>>>  drivers/thermal/armada_thermal.c | 2 +-=0A=
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>>>=0A=
>>>> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada=
_thermal.c=0A=
>>>> index 709a22f455e9..88363812033c 100644=0A=
>>>> --- a/drivers/thermal/armada_thermal.c=0A=
>>>> +++ b/drivers/thermal/armada_thermal.c=0A=
>>>> @@ -578,7 +578,7 @@ static const struct armada_thermal_data armadaxp_d=
ata =3D {=0A=
>>>>         .coef_m =3D 10000000ULL,=0A=
>>>>         .coef_div =3D 13825,=0A=
>>>>         .syscon_status_off =3D 0xb0,=0A=
>>>> -       .syscon_control1_off =3D 0xd0,=0A=
>>>> +       .syscon_control1_off =3D 0x2d0,=0A=
>>>>  };=0A=
>>>>=0A=
>>>>  static const struct armada_thermal_data armada370_data =3D {=0A=
>>>> --=0A=
>>>> 2.7.4=0A=
>> >>=
