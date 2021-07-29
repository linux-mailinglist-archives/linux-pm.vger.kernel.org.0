Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA703DA129
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhG2KhZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 06:37:25 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:62817
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhG2KhY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Jul 2021 06:37:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9BhTpcV108Bl8792NAxtN3J1gFl2Oq0P+eb5Erj+4GnbsWXH6gdYsK17B1gCkea2wzT3zZrtjbuz3rND7PANYZIExAHWuIXE59eceTcj7dB3jhoLPn0yRHCPT7nSkzp7NG6JNfkLSYJDMaIAraj8qkIdBIVCFHKCG6sEpyuezDy4+aSoCmXtUbHgDVq06fELWqnv8tToC+NbH4ZzvlYPULl/ZonKFP80m/B6H+x37wEJqwNmNCoyVBEXhBxKscNjMpOvN03uaQXmMj6qifXvMzHv63Rja10eAU7LG10J6M2hXpdBL90bAIhBaRL5UOdeNqCUUP8CeHPnznjTZm6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ339CnPDV1hdxPv624J2oqydHyZUHxG0tLhHGC+T2A=;
 b=l1AxlTfGRX9bWWb2Jer1zfZAAhKBy86vBQOmAvXphvQIe0V6uHeijsq0trWNWMJIZcleVR4UIbcpjhi3LtXY54u7rkK4BP+qYOxWPuIbTLuHsExl96cfwrycZ4LdUgIZTZ3mR7N6+9unWIOtmzIdfBcQam2YqGUqF9LyqwYVDHhWVDpcuNmNVDTUiYzXP946DZriHzP1eC4CYLN7XzViroNe5cSZ4Maw+LhFC7A7WgtwZgfU/XbiSEHnJHXCT92lXlReajx7q0VhlGWMO4URx6tqehwlkGiZxTEKhP8aFsU2KimRjNswz/uC8Ao1/exv6ckXMx3QRJIk01DjXt/4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ339CnPDV1hdxPv624J2oqydHyZUHxG0tLhHGC+T2A=;
 b=PNx4I5421AukZx6jOGxlFVJ8FXa8BaLyFWMLw+zeKClzpGTpxykmcj0lgMnOAq8HcnZd5MHks27Do3XuBbGBRXhyfp2s/URpehOYu2wOpWmO5NlJ/f27kFB7t8UlVGQxcL4l9QemkQir91gx/fpX8C/Da+4LcLLJrCr1eOYQYtg=
Received: from BLAPR08MB6900.namprd08.prod.outlook.com (2603:10b6:208:325::21)
 by BL0PR08MB5332.namprd08.prod.outlook.com (2603:10b6:208:2b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 10:37:18 +0000
Received: from BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516]) by BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516%9]) with mapi id 15.20.4373.019; Thu, 29 Jul 2021
 10:37:18 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH v2 0/2] Abrupt Shutdown for NVMe SSD
Thread-Topic: [EXT] Re: [PATCH v2 0/2] Abrupt Shutdown for NVMe SSD
Thread-Index: AQHXgjJctJSWzcMb8U6/xvTW6b+HaKtZxW6A
Date:   Thu, 29 Jul 2021 10:37:18 +0000
Message-ID: <BLAPR08MB690021D560D577A959673570B8EB9@BLAPR08MB6900.namprd08.prod.outlook.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
 <20210726152434.GA2024939@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210726152434.GA2024939@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-07-29T10:37:15Z;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=6d976bf5-c61b-4e19-b413-eff5bb380c6e;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d83c9123-880c-4704-18e4-08d9527cd6e9
x-ms-traffictypediagnostic: BL0PR08MB5332:
x-microsoft-antispam-prvs: <BL0PR08MB53326D07C09997DDDA531255B8EB9@BL0PR08MB5332.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xts25C1dI1mTL9e0/44bu980rc+V5lB7ynFBAx1oPN10s0ov+QVL0bwrbJoaQLNTx0UrcgqywKXFhlb1xOM5PM4zHVXgYyWmNKeaD5duJi2fBqwNBDISM34Kc1BH9+gUbwxS+0V2U+Zb5wkzxyvtTqz9prEGNIZloaCQv+5Ex/x4L8Wx74s+2h/J9zmZk5n+C4Inu5Xyyxve5UVYTq1/b+h/ZgRD9C7ORuM4CMjLWi9i9i2B1ryk0B4r2nh0eOMrMCSJC9+C2corqZ+jeYAawEOBIcD1t3U/7sgr7REC9F6Hc8CwSBHlk3JGv8gcjd4iyp3NMFqsukiDVATTPIAs19x82bU7VyPu9ghDqMfxIolofbSwcFzqg4yEHvMnWCGKLgTLz5nGy9vnwBlMvX+EZ9JxpwGi7WcKf+T1CmqOlkDGFYxnhp9jt52VbNLh9xmuCqsP8qscvq1n0mgZoXb8ikeegvhI3CYsi6jJ0EYwealp790mNZJ771O6eMAkD7J5V7AChabX8i5hILxY8sNjJXUE2cQY6kvgmTX9v84I7n02Y7vEOqZqVDNMVrTzFH8LC+chxXY9UfNwO/PB9SlALdkBMQD+EcP30I6kv86FuJmFMsMGGQEDbpInbU8WWptOt2WXcyeSOrv1L9R3ShIyo46sx+ie30QBIAPzMFzhvMJbDlSZF+JrVUawyQgXPtyGGLRl9JJ39NduepUGAFR5GQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR08MB6900.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(52536014)(7416002)(38070700005)(122000001)(8676002)(38100700002)(186003)(66446008)(9686003)(7696005)(26005)(71200400001)(66556008)(64756008)(76116006)(66476007)(66946007)(55016002)(6506007)(8936002)(316002)(4744005)(478600001)(86362001)(4326008)(83380400001)(5660300002)(2906002)(33656002)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W10qXbrzQoghdWI/lS8zaaFknjfgLX/wuxzGA+mj3Y44qWTHoGDxnHnuK95/?=
 =?us-ascii?Q?3McM6E+ewBmUHduTP54ZJy5S5yCs2yziqjj1UcKN3zDKWHvpW1pZ5lliRxJp?=
 =?us-ascii?Q?yxkMIvV0WvYxlQwvJLvsUVm2OYldXc21G8UAMlimJU6AAypI/9ZilS22Ubau?=
 =?us-ascii?Q?eRc1znhtiPjmCaOBTOhkNgpJ+YAr8+gr/tk3hKj216lFw+DCc3U/1FHcvHKc?=
 =?us-ascii?Q?pAwvIIxrlhQn6JEbzd4x5O/VaJHI0gJAuVulS4mqIyWLkVIm8tKE+q9ulu2o?=
 =?us-ascii?Q?AdAYo5UXo4Bk4IYvXM+jKvD7RmcGDQsSu/ZYtRAt61EEXTGdD2TsZG7UB4si?=
 =?us-ascii?Q?JypGxs7FWx9ywDCDucCIaNkVijoZxtoS7FQ647QlZj24p/1IXo+wNFXMpxj2?=
 =?us-ascii?Q?EEo6T/3/ydqCGpz1Pgrr0HL1E2LxFZhFjzTwhTVkOHrQ234vSNwY4HlAcz3/?=
 =?us-ascii?Q?imP7zkdOtfXnp/JcPSAsUZoWp7tfkswMiC6iRwArqER6Qv/RCsra5jikUIPO?=
 =?us-ascii?Q?kXgFyb1M071saGEHRcivvebNv1MkMTnul+DQ1Jd809hUcfqp5Mt24EFW4R/i?=
 =?us-ascii?Q?0/SFhpG6IjY84hYokyZnYh40Xusz7zpdPkaDYd6urI8V9d/dAwmzUAsSjW+S?=
 =?us-ascii?Q?zxbPRArhseaR4qVx7A9tyXMjk0VGhljo76n8atsa8iQm7GU3mKpEzj0rTA0j?=
 =?us-ascii?Q?1i27rhwbJL15vKMEzouXELr04/1MbyBfq1sfYtb77ETnLiI+DLJUzK4t3VYA?=
 =?us-ascii?Q?/SGGMwcDv1nYz5ZDRLCsxTCowtufmclBo9uFr1mX48+oirXerC0nCnUY3SvP?=
 =?us-ascii?Q?wRPkfMcKaHxwy4TEB6rXqfyOf+ZmTLz9dh1ZSp4OObiF0rk2hcXD4h8IFz+c?=
 =?us-ascii?Q?3OsSpH3fI3eIGac3ycKtSwNUKEpGah2n750UzBWdKgC0zM1302PvYtlWF5ks?=
 =?us-ascii?Q?fLUOqGPePspZX/LFflOt06bG8+4pMO2oEdFW8Vk2KsUS/s6nHIy4j9jyNEyh?=
 =?us-ascii?Q?gRZ/0QXSXYALn8frdo+fahYtkP0JZSKZN+GBfzurWrtS0vyYwrDPVp4hO6mz?=
 =?us-ascii?Q?NxOSLY3FKmts7RWITRnPDH5PZdFcHM7EAHPgh6tHCeRP6Ir+AA3g2qMA8gD3?=
 =?us-ascii?Q?4ipw4qR1k/+2Wo3nOu3kepmIjXFrIInrQgCnckPesTla2yh5Nu1hSHi4iKbW?=
 =?us-ascii?Q?emGtziwC7jXVS9VzmiuWKFbZn/SGZA4QozlwQ1sNcoYdktqEijljNDIif+2x?=
 =?us-ascii?Q?oaMqH9c/BfZaVyzobhjrgSor6KaPcb36YjakcbOjQHn3LkXMHx3kp7b9KdMj?=
 =?us-ascii?Q?uKZEssxU3lOA0XeRv0BW+2fF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR08MB6900.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c9123-880c-4704-18e4-08d9527cd6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 10:37:18.3075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMsNcwLCb2yfj6zSQvLjq5MXg1viZPT5BbZxdJabuj7pTzIKTn5KNpu0hHGxbH6z0t5roMZmMufjuaEKsB98Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR08MB5332
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Micron Confidential

Hi,

>=20
>=20
> On Mon, Jul 26, 2021 at 01:22:21PM +0000, shiva.linuxworks@gmail.com wrot=
e:
> > In the platform with a limited backup power supply, devices like NVMe
> > SSD does unsafe shutdown.
> >
> > These two patches address this issue by adding a power loss imminent
> > flag. The platform will enable the power loss imminent flag if the
> > platform's power is running on the limited backup power supply. During
> > the shutdown, the driver checks this information and pwerforms the
> > abrupt shutdown.
>=20
> I think the pm framework and nvme usage are ok, but you need a platform
> specific caller to set the new power loss flag before this should be
> considered, otherwise this is just unreachable code.

Sure, I will send platform specific caller along with V3.

Thanks,
Shiva

Micron Confidential
