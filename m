Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE05453596
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 16:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhKPPWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 10:22:30 -0500
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:20341
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238105AbhKPPWX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Nov 2021 10:22:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihV9cK3oB+0tWN8xps74I3fhMmHDIsi/8XSLekGQLUHOD+ETQD32kCEZJtMQ1BkYA01+uVfuX9dh4gIUDMYgYMv0JRBPvJ76Ms/jhBzwk9xoY0LLSjkIPfMYrHee5D+E4Fg0H8ubh9KpY+dgayyOCIgDgdh1sm1KaN/JpXlPkVd8N5S+1tILpY4A0lguQhTN2tPflaDINDr/Dnu5s3/Ut3OLhB1qNUwljD+oDFtvqCX+AYNThjqrczvCdKWO1azbaoQXFgK6ntFSUFusQcUBwc86+ZCfXx/U5RvexFBlWzmTB9so+W/RCOQZqv+KlLd+zMBRT4p6heRC6ZzB//I/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LZ7K3Y0V/b6fi6bgSGQR2FM+JBX6PSMndf6maYpIz8=;
 b=HU8u3ytNLI2tQq3X8CExil6hL90Nf8aqoM0tgudvbeS/NBO/xQBqFPaN46na6GmEBmSuN3WgO3QGQlzIN0VIzwZ/6ULAL5rvRcJfT3v35+nB+ZH244AIlM3Z+XPlbgvn3xLyjgUc1UDo6oeonnWR+puk0/Aeq3EzJHP/06dmf+keSky4G5SF8XkQxlWTc6Qw+G3x1VVPiPXlb7TyOFbkZjssN4HPdwTGaeSW+wTnizrRjk2iqPFskwSdY1NflKmS4XuQuvgx0bjNaka5P4L0jZ2tABaq6l0vdFDsXhXVq1H4CnUUONRhKT/DHh5J6zmX+ZNblO3mRPZmPkY7JOpaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LZ7K3Y0V/b6fi6bgSGQR2FM+JBX6PSMndf6maYpIz8=;
 b=nqEb6oqQoKwHSg6U9cBhfyzQof5/OBDTAoICfzLSUV8qtfZlLMMrxTCubBTOCisNGtMWmRqoxvgVe0SNFsoJmQe0p3IYlm1HnWr0erBIAOx2ABfIWJFvuP27Xht/kn7uPl2pjwFt38YLQYbrlggP6lOyEXun24iY4L2sDIAOt3s=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2778.eurprd03.prod.outlook.com (2603:10a6:3:f5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Tue, 16 Nov 2021 15:19:21 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60%5]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 15:19:21 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] power: supply: core: Add kerneldoc to battery struct
Thread-Topic: [PATCH v3] power: supply: core: Add kerneldoc to battery struct
Thread-Index: AQHX2n+y2iIKcdsoDEGLqcFn5J628KwFr0iAgAB7TQCAABsTAA==
Date:   Tue, 16 Nov 2021 15:19:21 +0000
Message-ID: <e9458f4c-4520-4c13-13bf-a2c575fdbdfa@fi.rohmeurope.com>
References: <20211116001755.2132036-1-linus.walleij@linaro.org>
 <bbaa93fe-8a10-7c80-2b5d-c36b0968429f@fi.rohmeurope.com>
 <CACRpkdYNe8cMo016ZCtgnOLs2b5JzHXUB34KkNR_dzBRZQh8nA@mail.gmail.com>
In-Reply-To: <CACRpkdYNe8cMo016ZCtgnOLs2b5JzHXUB34KkNR_dzBRZQh8nA@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f87ea4d-111a-4ed7-323f-08d9a914773f
x-ms-traffictypediagnostic: HE1PR0302MB2778:
x-microsoft-antispam-prvs: <HE1PR0302MB2778FD5EAFD20F56B09C15C7AD999@HE1PR0302MB2778.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18JwO0N6qgQZlvBq3RzzD16te8lkjG7c+13qylSHV5Jk0T/DOnhj7hIUtzp+2YReJidal31VxTTHwRYVPnFxd3wJ9vACJ306prtbhzeVW9MqipyCrPCZTC7JhASPasT/wPPubM+rYQPTzvDW5hGFWtOvXN5W/XQ/10mRbEdoD/0uJRYoMbFhyJgD1CQB33FRWzo/ZyI6zS5g8nE52NOZHWsxEzFjTr9le4gdHtUsn6Mu11dYtaTjU47AvXU6yd1qzw1tXzJaccbTBcfjL5NSIpLUrZStYKxbspEQG8deUQOuoEKkymchB4P61dZjer7OiqIaKseKbxyNOv1zLEN0pqdwo9Ms/eTeQFZjdSSmsxUXHa2tfA6sToF2NDj05DlOHbQz+EiSgKxN8A9f2vvif+DGfVKuZpPe1h2i8c/DOq1MoB7yIeCGEH/lchKx9pXmpGwUo1mLgu/MwLYiL/0gFGtcITQP3m0c8DhrY7mLYyTdP18CsOwq0Nbw3idlOy4Se5LqI+O5CcM0OYxzFSz5rwLMwaY3NBXhUc3gBGL5TGWL7+4rGGac6s2HtVVdTzqEUzuCFN+lFWRiorJWqYyMge/jDeEg2SHF4YD9o1pNfSr5sF640UyQwIiK9N02QJWcyW7MsdouKfR96rkRciQOoKk8ms3cSwxvBF+6uEYml5SldnuORmJLHqOGswWhMOM7LKcIHyd9XKXDzhfc7slY3BSb77kcmExXZDJhXhVbfqLw4gmWY2aiCgMdLjHX1OV0tHwCVaHIypyAEGOUj1VxKzEQfeRu9tNc34kVHQsH6zXKmvNz0EL/zAT+xcfq22aDYwF4xrTPTq0KdHXZjGEmJTz1AWPj373Vb1505krUi9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(6916009)(6506007)(31696002)(2616005)(316002)(4326008)(83380400001)(54906003)(8936002)(5660300002)(508600001)(122000001)(26005)(38070700005)(31686004)(66556008)(66946007)(76116006)(2906002)(38100700002)(66476007)(86362001)(53546011)(64756008)(186003)(66446008)(8676002)(966005)(6486002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2UzNXdLZnIwcFUvd1dTYjV6b2xOSUcwRzlnQW5pUlJlMHZKYVhkVER4Q1dJ?=
 =?utf-8?B?NzJNY29yaEp2SG83TC8vOFJ3MXFhUkJuVWxIaXNyWlgwNk9lUlNQY1BzZU9K?=
 =?utf-8?B?KytIMjNtK2g1WUtKcGwrbHgvbE1jckNUaDdNRU1DRHBiNFZ0NzBMdU8xRFZI?=
 =?utf-8?B?dC9IdVFuVWJPRXBZZVpaQWRZNlhDM1BZQWx1Sy9DMFNveVpaVVovQWVUSENl?=
 =?utf-8?B?MjNEdkU2cG81QUZDODNzWXJ2MUtpVEF5K241NHdGTTJEUXJOd29ONGpFTHk1?=
 =?utf-8?B?ZzNFN25QbHFvRGxxSGdpczA4S0Jzb1VZdEdUazZYSTZFemtHSkhaOXhLZVNJ?=
 =?utf-8?B?Yi9OamxYODB5R29WNVVsUzl5ZmR5cWtIOEVvdkNTSmNnY1pnL3V5QkRXNnBT?=
 =?utf-8?B?WExoaUU3M1RvTnNEbmhiTUkrOFRJakJteXRQajRVcDNXaGR0S3ZzdDRaaVcy?=
 =?utf-8?B?a1JKYUJwMi81Mmh5clNsTWl0NXZaaXdUTzVvK3E2bXIwV0NXV3orRHFUbkxj?=
 =?utf-8?B?ajRzRHNmU2hCbEcwdzE0ZWhZR2dqcDgvNUlNTDliaEdOTjFLeWkvTVFTNkRm?=
 =?utf-8?B?b0crNGRRenU0MUQrV01xTXdJdDRpY3diZC92TXR6QVVSRmxhRXovaUtQWTUz?=
 =?utf-8?B?cFBHUWs3Wk5Bdmd3b0szalV5YTk4RitlOHZYRU8wcEt0Yy9JUHY3ZkhIaE9o?=
 =?utf-8?B?dEo1RGFlN2EzU3o2TFZrTlVZaTN6cCt6Vk1iOXE4UjZaYW9xRkVmdEpEVmRu?=
 =?utf-8?B?aHVqcmx5VzZ3ckdwOFVPZC9qYk92TDFyMFVOUWNJNS9ZWkRCVUhEQ2VBNGtw?=
 =?utf-8?B?WERVc0QwRDdGcU14NVhscW1NY0gyTHppVDY5MnB4S3lSZnJtby9hdUNRVXh1?=
 =?utf-8?B?VFhWdE90cU1hR0NHRmloSWVZdEl4Z1hVelZXU2Z1cCtOZTNybVg2ZXFyWWdD?=
 =?utf-8?B?UVlYRk52OEhDbXQzRFJET2tzaGd3ZVBkZjZxSm96UlFnaGg2NmtKaVFuZ2xs?=
 =?utf-8?B?RlQ3ZlFyajVqK1BpdURNZWJqMXlqR0lKU0NMenJOdnNZTmxEcisrYUNvdlJE?=
 =?utf-8?B?bWhOL0s1d1dnL001S1ErWVgwVjFENUlOTDU5MVdUYzBoWGpjQVNiSkZVRUpw?=
 =?utf-8?B?WElpUjc1YTlCWHBsaG91R09WbWRGMWJ1cU9sNGwrSHYyY2E1VTVaenFici9I?=
 =?utf-8?B?alhtc09vYkZkanNYUXpTK244UlUyU0JEVHRsVmhEVWhBUnk0ZjlneUY3MlZQ?=
 =?utf-8?B?V2RITTR6SHJiRXRtUkt2MENabmVjTDkvbmMxMDcxelpkRVRXRzRNV2VZTnFo?=
 =?utf-8?B?QTFyLzRicyt1QnBlVmU3a2tNT3I2NjNJbUlkTSt3Z05oVkd4ZnRzakJYK2hQ?=
 =?utf-8?B?SmZrTzBUSldQRkZqOTRKNEF5ajdLQ05TYWtrUmpEMVRtelN1cXduaXpRWjkw?=
 =?utf-8?B?cGdaRjZqV3lML045ZkEzb2pBdDZNVkhYcUVkUlpNMHFvcXdhVlc4ZE1aRHJ1?=
 =?utf-8?B?VHdPRExhUlVicHJrTFJ5Sk1tSmRjNSs5N25pRUZweTd0ZnpGaHYybUpzUHpw?=
 =?utf-8?B?L1NuM05wVzFqV1BoYUloVFoyUDdzVUY4Nk9VT1AwZmlkcFcxR1VUNVUxS2hH?=
 =?utf-8?B?SGpUb0RHUncrc2FtUVB1dXpTYjBCTmZEdjYydzN4YnNqdTZLVHQzL3c0bTJC?=
 =?utf-8?B?ZkRmMG83OVd5NVJRYjBhcE9NSE1Idk11QmJLNlZpbWovYm1ZMUo2YVpGQ0tj?=
 =?utf-8?B?RjZNSEdydzlidEtYKzJaSWRlWWxBcDBlbHovNUo3V2pxMTYvSmZuVzlQcEpF?=
 =?utf-8?B?VEhMNE80N1BJamFtMEZUaGxuVHdSM01oMFhuSEp6S2FLemVhNWVSM2FBL1hx?=
 =?utf-8?B?TytqTVlpQUZBM3Jyck5KZjlwNDUrNWh2ZnBWZXZIWERPMDduK3dVNGlNREpQ?=
 =?utf-8?B?OFpIcitmZFd0L3BCNEEvMTVhRFhOdW9WazAvSUQyZy9Rb3dXNzJ0MXcyekw3?=
 =?utf-8?B?eFdTQ3YxTjRyU2RHRENXSkdENXVnY1ozeE15anlKc2JCRm05ODFqbERza3ZQ?=
 =?utf-8?B?OUZBS0t5c3dMblJqcXNldkRmcy93cUtRODIvK2wwMDVZV1lOZ3cyZTFUTFNn?=
 =?utf-8?B?SzFER2hHOVZpRy9vV0tNNlUybzNOZ0F2bWRuZ2xYYm1GY2lyZ1lLa0NxREFZ?=
 =?utf-8?B?eFlpSWgwTUpXR2R2RUp4Z3B4WEs0SmJaa3FJWHRvSWk1WlVGY3lYekRQL0s4?=
 =?utf-8?B?QXVKSmpEVDdyQXMwVnpnRzFsc0lBeXJ0VFlPeklPMGJ6dEVwMjZjTVlMMUFV?=
 =?utf-8?Q?M88AZygPVmY8BdGG21?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D8918A68705134CA5D4C81B120FF2C4@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f87ea4d-111a-4ed7-323f-08d9a914773f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 15:19:21.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MYwaETgdpIFpsKo3G4AsSr4z6JPZIvxmcsgNEClngG2YXouidBOOWbgPMuMGHXzE0ZFGa3zKdFWtUBXOxsFmAM9g3mrhVaYUip42qbpWYDWsGm0HTrb2wmK9WtH0en/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2778
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIGEgbG90IExpbnVzIDopDQoNCk9uIDExLzE2LzIxIDE1OjQyLCBMaW51cyBXYWxsZWlq
IHdyb3RlOg0KPiBPbiBUdWUsIE5vdiAxNiwgMjAyMSBhdCA3OjIxIEFNIFZhaXR0aW5lbiwgTWF0
dGkNCj4gPE1hdHRpLlZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4gd3JvdGU6DQo+IA0KPj4+
IFRoaXMgaXMgZG9uZSB0byBmaXJzdCBlc3RhYmxpc2ggc2VtYW50aWNzIGJlZm9yZSBJIGNhbg0K
Pj4+IGFkZCBtb3JlIGNoYXJnaW5nIG1ldGhvZHMgYnkgYnJlYWtpbmcgb3V0IHRoZSBDQy9DViBw
YXJhbWV0ZXJzDQo+Pj4gdG8gaXRzIG93biBzdHJ1Y3QuDQo+Pg0KPj4gSnVzdCBhIHJlcXVlc3Qu
Li4gVGhpcyBzb3VuZHMgbGlrZSB5b3UncmUgaGF2aW5nIHNvbWUgYmlnZ2VyIGNoYW5nZXMNCj4+
IGNvbWluZyBpbj8gQXJlIHRoZSBjaGFuZ2VzIHZpc2libGUgYW55d2hlcmU/DQo+IA0KPiBZdXAs
IHNlZToNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
bGludXN3L2xpbnV4LW5vbWFkaWsuZ2l0L2xvZy8/aD11eDUwMC1ocmVmLWNoYXJnaW5nLXY1LjE2
LXJjMQ0KPiANCj4gVGhlIGZpcnN0IGNoYW5nZSB0byBhZGQgc29tZXRoaW5nIGlzIGFjdHVhbGx5
IHRoaXM6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L2xpbnVzdy9saW51eC1ub21hZGlrLmdpdC9jb21taXQvP2g9dXg1MDAtaHJlZi1jaGFyZ2luZy12
NS4xNi1yYzEmaWQ9NDViZGI0YzU0MzMyMDgwMzYwNmYwZTc0ZGM0N2ViZWMxZTg4ZGM1Mw0KPiAN
Cj4gaGVyZSBJIGFkZCBhIHRhYmxlIHRvIGludGVycG9sYXRlIHRoZSB0ZW1wZXJhdHVyZSBmcm9t
IGFuIE5UQw0KPiByZXNpc3RhbmNlIHRvIHN0cnVjdCBwb3dlcl9zdXBwbHlfYmF0dGVyeV9pbmZv
Lg0KDQpZZXAuIFRoYW5rcyBmb3Igc2hhcmluZyB0aGlzLiBJJ2QganVzdCBob3BlZCB0aGVyZSB3
YXMgS2VsdmlucyB1c2VkIA0KaW5zdGVhZCBvZiBDZWxzaXVzLiBXb3VsZCBhbHNvIGFsbG93IHVz
aW5nIG5lZ2F0aXZlIHRlbXBlcmF0dXJlcyBhcyANCmVycm9ycyBpbiBmdW5jdGlvbnMgbGlrZSB0
aGUgKnJlc2lzdDJ0ZW1wKigpLiAoVGhpcyBpcyBub3QgYSByZXZpZXcgDQpjb21tZW50IC0ganVz
dCBnZW5lcmFsIHBvbmRlcmluZy4gSSB1bmRlcnN0YW5kIHRoYXQgd29yayBpbiBwcm9ncmVzcyBp
cyANCndvcmsgaW4gcHJvZ3Jlc3MgYW5kIG5vdCBuZWNlc3NhcmlseSBpbnRlbmRlZCBmb3Igc29t
ZSByYW5kb20gZ3V5cyB0byANCmNvbW1lbnQgb24gOnAgKQ0KDQo+PiBJJ2QgYmUgaW50ZXJlc3Rl
ZCBpbiBzZWVpbmcgd2hhdCB5b3UncmUgcGxhbm5pbmcgOikgSSd2ZSBoYWQgYQ0KPj4gZnVlbC1n
YXVnZSBSRkMgc2VyaWVzIHNpdHRpbmcgaW4gbXkgb3duIGdpdCAoZm9yIGEgbG9uZyB0aW1lKSB3
YWl0aW5nDQo+PiBmb3IgbWUgdG8gZ2V0IGl0IG1vcmUgZXh0ZW5zaXZlbHkgdGVzdGVkIChhbmQg
d2FpdGluZyBmb3IgbWUgdG8gbGVhcm4NCj4+IGhvdyB0aGluZ3MgYXJlIGhhbmRsZWQgaW4gdXNl
ci1zcGFjZS4gRnVubnkgdGhhdCB3YWl0aW5nIGhhcyBub3QNCj4+IGluY3JlYXNlZCBteSBrbm93
bGVkZ2UgOnJvbGxleWVzOikuDQo+IA0KPiBBcGFydCBmcm9tIHRoaXMgSSB3YW50IHRvIGFkZDoN
Cj4gbWFpbnRhaW5hbmNlIGNoYXJnaW5nIEEgYW5kIEIgc28gZXNzZW50aWFsbHkgdHdvIHZvbHRh
Z2UrY3VycmVudA0KPiBsZXZlbHMgYWZ0ZXIgQ1YgY2hhcmdpbmcgaGFzIGZpbmlzaGVkLCBlYWNo
IHdpdGggYSBzYWZldHkgdGltZXIgc28NCj4gMiAqIDMgbmV3IHByb3BlcnRpZXMgdG8gc3RydWN0
IHBvd2VyX3N1cHBseV9iYXR0ZXJ5X2luZm8uDQo+IEJ1dCBJIGhhdmVuJ3QgY29kZWQgaXQgeWV0
Lg0KDQpPay4gVGhpcyBkb2VzIG5vdCBzb3VuZCBsaWtlIGEgY29tcGxldGUgcmV3b3JrIDopIEkn
bGwga2VlcCBvbiBleWUgd2hhdCANCnlvdSBjb29rIHVwIGhlcmUgOykNCg0KSSBoYXZlIHR3byBv
dmVybGFwcGluZyBjaGFuZ2VzIG1ldGhpbmtzLiBPbmUgaXMgc3dpdGNoIHRvIGZ3X25vZGUgLSBB
UEkgDQoobm90IHN1cmUgaWYgaXQgaXMgdXNlZnVsKSwgdGhlIG90aGVyIGlzIG5vdCByZXF1aWlu
ZyB0aGUgcG93ZXJfc3VwcGx5IA0KdG8gYmUgcmVnaXN0ZXJlZCBwcmlvciBwYXJzaW5nIHRoZSBi
YXR0ZXJ5IGluZm8uIFRoYXQgd2F5IHRoZSBkcml2ZXJzIA0KY2FuIHRydWx5IHVzZSBiYXRpbmZv
IGluZGVwZW5kZW50bHkgZnJvbSAoYmVmb3JlIHJlZ2lzdGVyaW5nIHRvKSANCnBvd2VyLXN1cHBs
eSBjbGFzcy4NCg0KPiANCj4gKEkgYW0gb2ZmaWNpYWxseSBvbiBwYXJlbnRhbCBsZWF2ZSBzbyB0
aGlzIGlzIGFsbCBnZXR0aW5nIGNvZGVkIHdoaWxlIG15IHNvbg0KPiBpcyBzbGVlcGluZy4pDQoN
Ck9oLCBjb25ncmF0cyEgVHlwaWNhbGx5IG9uZSBkb2VzIG5vdCBnZXQgdGhlIGNoYW5jZSB0byBs
aXZlIHRocm91Z2ggdGhlIA0KJ2JhYnkgZGF5cycgdGhhdCBtYW55IHRpbWVzLiBBdCBteSBhZ2Ug
b25lIHJlYWxpemVzIHRoYXQga2lkcyBhcmUgbmV2ZXIgDQphZ2FpbiBiYWJpZXMuIChBbHRob3Vn
aCBJIGRvbid0IHJlYWxseSBlbnZ5IHlvdSwgaXQgY2FuIGFsc28gYmUgDQpjaGFsbGVuZ2luZyB0
aW1lLiBJIG15c2VsZiBqdXN0IHdhaXQgZm9yIHRoZSBwcml2aWxlZ2Ugb2YgYmVpbmcgYSBncmFu
ZCANCnBhcmVudCB3aG8gY2FuIGVuam95IHNwb2lsaW5nIHRoZSBraWRzIGFuZCB0aGVuIGhhbmQg
dGhlbSBiYWNrIHRvIHRoZSANCnBhcmVudHMgd2hlbiBpdCBnZXRzIHRpcmluZyA7XSBBbG1vc3Qg
bGlrZSBvZmZsb2FkaW5nIHRoZSBkcml2ZXIgDQptYWludGVuYW5jZSB0byBzdWJzeXN0ZW0gbWFp
bnRhaW5lcnMgeW91IGtub3c/IDspICkNCg0KQW55d2F5cywgSSByZW1lbWJlciB0aG9zZSBkYXlz
IHdoZW4gbXkgb2xkZXN0IHNvbiB3YXMgYm9ybi4uLiBJIHRyaWVkIA0KY29udGludWluZyBhIGZl
dyBvZiB0aGUgcHJvamVjdHMgLSBhbmQgZW5kZWQgdXAgZ2l2aW5nIHVwIG9uIGFsbCBvZiB0aGVt
IA0KOnJvbGxleWVzOiBTbyAtIGdvb2QgbHVjayBhbmQgZG9uJ3Qgd29ycnkgaWYgaXQgb2NjYXNp
b25hbGx5IGZlZWxzIGxpa2UgDQpub3QgZ2V0dGluZyB0aGluZ3MgZG9uZSAtIG5vLW9uZSByZWFs
bHkgZXhwZWN0cyB5b3UgdG8gZ2V0IDpwIFlvdSdsbCANCmhhdmUgYSBjaGFuY2UgdG8gZ2V0IHBh
cnQgb2YgdGhlIGZyZWVkb20gYmFjayBhZnRlciAxMC15ZWFycyBvciBzbyA7KQ0KDQo+IA0KPj4g
SXQgd2FzIGp1c3QgeWVzdGVyZGF5IEkgZHVnIGl0IHVwIGFuZCByZWJhc2VkIGl0IG9udG8gNS4x
Ni1yYzEgZm9yIGENCj4+IHJlLXNwaW4uIEknZCBsaWtlIHRvIHNlZSBob3cgaXQgZml0cyBpbnRv
IHdoYXQgeW91IGhhdmUgb24gbWluZCA6KSBJDQo+PiBtaWdodCBnaXZlIG15IHNpbXBsZS1nYXVn
ZSBzZXJpZXMgYSBnbyBhcyBSRkN2MyBsYXRlciB0b2RheS4NCj4gDQo+IE9LIEknbGwgZ2l2ZSBp
dCBhIGxvb2shDQoNClRoYW5rcyA6KSBJIGRpZCByZS1zcGluIHRoZSBSRkMgLSBhbmQgYWxyZWFk
eSBnb3QgcmVwbHkgZnJvbSBSb2IncyBib3RzIA0KOnwgSXQncyBvZGQgaG93IEkgX25ldmVyXyBn
ZXQgdGhlIGJpbmRpbmdzIHJpZ2h0Li4uDQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5l
bg0KDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0K
DQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0
b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxB
TkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxv
Y2sgfn4NCg==
