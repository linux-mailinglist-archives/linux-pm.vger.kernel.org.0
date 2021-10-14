Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDEB42D718
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhJNK2W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 06:28:22 -0400
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:45504
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230314AbhJNK2P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 06:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4zuZuEuw6MJ/rtVboUCjHhCrW28hxtq/VuK/uYITMPg/roc9b0o1k49Vjfa/giR8y5fQ9YnRKtdTPkzMGshUxLM/axmqEs/n/2x5qvs2tOticI6zOuOKyZhrxne75w06ciQo41/CBp4JTE0g1GNtPo60ujsiTD/H4Jpp9bjqG1kRbZzlbd1tek3Jcrn9MrdYMZ3tLIOrMTeVZdX7QVQwKu2BCnhsnmUzQNiWzBwr+HOqJXHA/bDkJ97HCUMP5NRfKV2+4fFDYavrL+fRIHVy8mlRYEyPZnvXCnW6wCwU3qCcU87boofBoT6NBSeAYs+1KjuoT38lCYsWaTAPldP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCVIGgmBqYXOdTOmwymJfL1nLOuMkTcuZXf60CQGZVM=;
 b=LCp2CHiyDVcB9SubI1rSfd1Byt/JOo8kJeOqr/dilHqzIUXZFsdstCKSoklYV3VXtxDGxNPXiOEDzzSw+Us67Uf3wGr7lxtFD+bwuvAyWUuwdgEX/BfzQWAX9Pqh8XQljbTXRh+j8ZCYncCKrL+8NyIkfcCvvUwuPEq2xSzqPJWSL5cBamol9lSZBC0D5sItNHN+HnivBhT314Hvu8xmZQy+VyxE3f2hci9TrRwg+CR8uSDNREI0WFMz/k1UitbxT3/b6gkOLU1sAjQtdMMXstp7bMh3mIN6G0I5oWQedJ6AAiBxZ6qdm0ZKeKsMcwT6Tli1Iuar8u/CCe//kripbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCVIGgmBqYXOdTOmwymJfL1nLOuMkTcuZXf60CQGZVM=;
 b=n5o75Hqsq3L6lQeNtRvLc+3tXALnvjwDKaGIGUxof4317/QbGt8E+ITn9Xn1DAmoZIreGfk8QJVve0tSbBoCLmKJpCvBYLnMkR/aVmlY1V3Oha+lF56QZs6s8byPqQofkTXtinRUuN8sZMPk8p/mWq7tU664PUtCoFFEytAUxKA=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR1201MB2517.namprd12.prod.outlook.com
 (2603:10b6:903:da::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 14 Oct
 2021 10:26:07 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4587.030; Thu, 14 Oct 2021
 10:26:07 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 10/21] cpufreq: amd: add amd-pstate checking support
 check attribute
Thread-Topic: [PATCH v2 10/21] cpufreq: amd: add amd-pstate checking support
 check attribute
Thread-Index: AQHXsrXfa4DoG2GhWkWmM5/MK6tk5qu5+O+AgBhqf7A=
Date:   Thu, 14 Oct 2021 10:26:07 +0000
Message-ID: <CY4PR1201MB0246BE2C3BDBFD575E3BE390ECB89@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
 <20210926090605.3556134-11-ray.huang@amd.com>
 <93e1079f-7450-5c5d-f1f8-7d607899343c@amd.com>
In-Reply-To: <93e1079f-7450-5c5d-f1f8-7d607899343c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-14T10:26:05Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4a344251-5e96-42ee-bc8b-e2adf659392f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f50752ce-9718-49a4-c356-08d98efd0907
x-ms-traffictypediagnostic: CY4PR1201MB2517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB25174B20E9107CC95FFCCAD9ECB89@CY4PR1201MB2517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 881rsIMyGAQdhirMXpuBGvdOQUhEVIbrGhLeA28Zegik1KLKaeO/4hP7/SNUSjpgMxHK34kABBcqg1TBMld2EvrLlM1U92lLru+1nVte3fJwFYXJAod4MaYF/wJkWiYB3k2yJAv3FqmjFkdWqRVJD80yNY0ia6dGQlP/UMUtfCebGsivnccN4eCaT9G68sP2/3x4iGZ8mklbPP0ZFobimE35hZGCz7QJrJiw5ee6MvWRhcAjiLgzfEKy/ic1Ft+noBhKquvadZhi7AGGVfV5Sl8juIPwmVtn32WHuayi3AGk8QuxOlw6d0aUpccx8d3e065pc4W9sQtD6rUIptnybv69f/Ys4TwXqA58NBG/23sOgXCbRAvFnsFL/WruNj/jAk36opiSKDLTnljkIRFyB5/6Lo2F+CSyaxE4y+x3awxmAKrO9kliIt+/b3a6MkQeCdGc2HFsTXQ0Lwe6I0urqkS5+3RcR8X7VbhQb1/uuQOxxCOaOTpu5huw7S+XnEpUIM3Lnk/JjEe7CBIYm0IMH7LvWBqGCpnwDAN3vF8AqRnbz3aF9BKACKN7f7SKCGq/AwDRheZYN+DU0CL1IXONNnsA74xoq5RqbFW+x3X7NY5z31qWq+ODQfgcO4jKgv2S890hClmwxSVQUYhi0vYlpaAhvo0oSfs5kgG7wm8vCl5CtdzV0/egQ7now0TdP/Z/bBXT2x/yHdfBvM8NvXjHGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(316002)(54906003)(66946007)(76116006)(508600001)(4326008)(66446008)(2906002)(55016002)(9686003)(110136005)(122000001)(52536014)(53546011)(64756008)(8676002)(5660300002)(33656002)(7696005)(86362001)(6506007)(83380400001)(186003)(8936002)(66476007)(26005)(71200400001)(38100700002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzVkdXVadHRaSVg1VUFmSUpMN2FqbnA2eWlRZUo5TU94SmlEa0oveTVWeU1x?=
 =?utf-8?B?RDlQbjVYVFM0TGlTMUZybXR5Q3MvaUFCVVdoMWRYODhvd25ybXJHQVdkNFJa?=
 =?utf-8?B?TjM0NzBHcDBTZ1dqYlRORzhHZk5BcFlJbWc3VkdmRTNsMG9QOUxCaDg5U0ta?=
 =?utf-8?B?aGpTZ2ZkS2NsaEFMWlVGZ3BmOHdLRUFheW40TnpKNjBWTGdBZi9hSzhiekZo?=
 =?utf-8?B?MjBSRmExT1VUU1pkZDUrY0JYdjZyTTRHcGxqYkxkM2dIWFFSdXNiQkdmUWNu?=
 =?utf-8?B?Qnc5ek10Q1A1SE15NDI3eFhmc0UzU0FTZnFTb1VlZVB3Vm9xMHYxRHJEemNX?=
 =?utf-8?B?MllkSzlJMjBYa0Q3MzdndWtjcytZaVI0K20wT3ViWmFkcWt1eDlWWVp4YjF4?=
 =?utf-8?B?WE43K2xIc0d5d2c1R2F6YURtRk5paFQ1d3BNUGQ5dUJVdVdDTklyakt1RXFE?=
 =?utf-8?B?N0NtTy9sRE5IUXZOaHhZK2ljWTRiUnVoOUxvTEJWdDVTOGlCT0dpWUh6NWdz?=
 =?utf-8?B?bTl6ZnMwdm9HQ3FMM0NpZTRxb05QZEZiZUVYblR0bzA0enJtSFI3d3pjM3lN?=
 =?utf-8?B?TWpDbDIvc0cvUTdrWEF3bUcrQitVVmdOdVppOXpPazkzYzJIOGdsZEpiaVZp?=
 =?utf-8?B?VG8zemlQdEZBZGxZWEE1MDZVTHpsbUoxWWFsazRINGRzNE9ud0pBT0N3Qlo1?=
 =?utf-8?B?ZnpGY3RKRXNqSGpZY0RLN3dzTVNsZng4OHB4N0o5STh4SmpJWW50eC80UnY4?=
 =?utf-8?B?NEtjSzdWbzBOWngrWHdwa3YwVEZDcllFNmIxSnB3UUkycFNueHNtekU4aXor?=
 =?utf-8?B?WmJuMGhiZ0xSakFXSjNVdFNkOFd1ZXl2bW1GbjNmUlB6aHRLZjFTSmQ2S3RT?=
 =?utf-8?B?MXl4TFhHUXR1QkxkNWZDUnM4L3poOWUrcmkwNUk0ejRKQnNWcHkvUEdmWFh3?=
 =?utf-8?B?SXZEanN1RmdsQzN3dnJCUFhaWWx1WDBJMFFtaS8wakZQNTF1RWlDTVZ5Z0k5?=
 =?utf-8?B?TG42azdTaGJ2K0J5eVY0UDhjb0I3ZENKRzY4czRVbnQ3c0xkTjB6M1RGaHdY?=
 =?utf-8?B?VWJPcUxUVisrazVKUUpKU1ZYT1E1OUdOQWdzT0ZrUFRkY29XS1crRkJoTWdQ?=
 =?utf-8?B?dktpV2IwdjVhblhycFViUjRvMzhmeTl1Q09XOE1wRUtFbi9tZGdKOTNuUVZs?=
 =?utf-8?B?WDRFODNhY2I4amhpbjIwRjJnU09xZHVKQlM0eURDZDZIRXpTNVllK001QkNK?=
 =?utf-8?B?QVVpY2FTdFBNUExZMHBDdWhkNzFsK2VKUzdWWUhCRmFZemF3RDFYdXg1dThK?=
 =?utf-8?B?SXVIazJwMFVQSzQ3eU5tS1NWV1ZENTRZWTVHeUk1dFZtWTNHUjh3UUVic1Er?=
 =?utf-8?B?dVp6ckU2TEl4OGluSkladmh4T2c1dVVXemlsZGtaQzNKK1g2VWRLV2pPMng4?=
 =?utf-8?B?alVPQ2p4ekpZcVJSZEFTMVVVa0UrNDM4cXFBaHY0NHhScG9KM0xMSUUybk5v?=
 =?utf-8?B?cW9TK2hHUnhGS0JJdXl2cDd2SVh4N2N5eUpEczNHWDAvU3VETEluUG02anlm?=
 =?utf-8?B?clRvclozSGJHQ3RpUE82aGsvRng0TEV0RHcrNFo5d3VBTGVQSmlkSEZaTHAv?=
 =?utf-8?B?UHhQQlo0c2QyWGs4ZUhyVnVTcWhyeVJPV1pBT1Zsa3lTUGlia1NnRlhnSlZ3?=
 =?utf-8?B?WXgxT3RndGF4d2ZQTmJPWndBdjdGWTBIc2ZiZXdpbVd3TFQxQ3pjeHpMSGFz?=
 =?utf-8?Q?sKMtvUDUhedxj0dIPxHYrOmR/URA6cO8g+D+wtL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50752ce-9718-49a4-c356-08d98efd0907
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 10:26:07.7340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aY0wyHW9MVyoScJAJ39faFcu8QrwRajeLtaRYkZ1kE0xQfvEMNv1xoJIGfeVClEn2I274xUxIMOZ9oUkC58xSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2517
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBGb250ZW5vdCwgTmF0aGFuIDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjEgNToyNCBBTQ0KPiBUbzogSHVhbmcsIFJh
eSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBSYWZhZWwgSiAuIFd5c29ja2kNCj4gPHJhZmFlbC5qLnd5
c29ja2lAaW50ZWwuY29tPjsgVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47
DQo+IFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBCb3Jpc2xhdiBQZXRr
b3YgPGJwQHN1c2UuZGU+Ow0KPiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
OyBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz47DQo+IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9uY2llbGxv
LCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IFN1LCBKaW56aG91IChKb2Up
IDxKaW56aG91LlN1QGFtZC5jb20+Ow0KPiBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5j
b20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB4ODZAa2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDEwLzIxXSBjcHVmcmVxOiBhbWQ6IGFkZCBhbWQtcHN0YXRl
IGNoZWNraW5nDQo+IHN1cHBvcnQgY2hlY2sgYXR0cmlidXRlDQo+IA0KPiBPbiA5LzI2LzIwMjEg
NDowNSBBTSwgSHVhbmcgUnVpIHdyb3RlOg0KPiA+IFRoZSBhbWQtcHN0YXRlIGhhcmR3YXJlIHN1
cHBvcnQgY2hlY2sgd2lsbCBiZSBuZWVkZWQgYnkgY3B1cG93ZXIgdG8NCj4ga25vdw0KPiA+IHdo
ZXRoZXIgYW1kLXBzdGF0ZSBpcyBlbmFibGVkIGFuZCBzdXBwb3J0ZWQuDQo+ID4NCj4gDQo+IElz
IHRoaXMgbmVlZGVkPw0KPiANCj4gSWYgYWNwaV9jcGNfdmFsaWQoKSBpcyBmYWxzZSwgdGhlbiB0
aGUgYW1kX3BzdGF0ZSBkcml2ZXIgd291bGQgbm90IGhhdmUgYmVlbg0KPiBsb2FkZWQgKHNlZSBw
YXRjaCA1LzIxLCBtb2R1bGUgaW5pdCByb3V0aW5lIHdpbGwgcmV0dXJuIC1FTk9ERVYpLiBJZiB0
aGlzDQo+IGRyaXZlciBpc24ndCBsb2FkZWQgdGhlbiB0aGlzIHN5c2ZzIGZpbGUgd29uJ3QgZ2V0
IGNyZWF0ZWQuDQo+IA0KPiBTaG91bGRuJ3QgdGhlIGNwdXBvd2VyIGNvbW1hbmQganVzdCBjaGVj
ayB0aGUgc2NhbGluZ19kcml2ZXIgaW4gc3lzZnMgdG8NCj4gc2VlDQo+IGlmIGl0J3MgYW1kX3Bz
dGF0ZT8NCj4gDQoNCk1ha2Ugc2Vuc2UsIHRoYW5rcyEgV2lsbCB1cGRhdGUgaXQgaW4gVjMuDQoN
ClRoYW5rcywNClJheQ0K
