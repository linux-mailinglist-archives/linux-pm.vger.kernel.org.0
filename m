Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2FF4540A7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 07:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhKQGLn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 01:11:43 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:38663
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229632AbhKQGLl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Nov 2021 01:11:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR5TYo4LRV/XMB4PdTFSfZJ63gVj5wK7EU7AFP4gfqPKG5jr5Pn927niPCvN76BixpCosWinv4rmjm85ENzJhNZOmojbf1vrScLE2O2PUtfM8csXUiCnRvKCbWsnbXMwrmVZruKYfmqXXbYmKVKPM1JvzD5GoVfldSdd0g44itLqiqnmCT2bQRzTtsip2m9ajDU425iHgAnsfbSEX9ZiNLbYCc86zb1GIxkdG1/wC4DQdfKaxtXV8DBAippi/eCHvX+1EQ30v5BliJYq6WOOEGyFuWTF2pGrQ5JdOz6yrB0ccyu/0DX70FjnIA9GyKPFP6PDaOjaMx327mc90i5fTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAuv3fxl/qZJ4lnZfcLmxj1vrBDQsbjPPQ2FU/0bdlY=;
 b=oaEg1sDgAspXhoa9Of5uDfKZKkzGg7N144ucIXCJY3F9HNZ5Ljcinw7DmHQYXBWgoX1FetLhbfbEG3j+2bnMyUJnnfQSFpmfyQ3Q3SnEbENYLgRhw2rEe8h2k2ifdI3SrRkADSn4sS716y0HtPtL14EH/IHOZSvCetEe34E/DmkwUMPH8KxHtJb/D5DqULFLWgbHgVA78rRyF4XWBF2ybfLMbpLIEPhT44C9S5gXR6gn2LutLfTmOQyVaz+rZxwi05r0EehLrWmkpO3iqRbKfHP8pQ7yCUlWyoevW/utVl173p978mQqKuoGdQOodLywu4rCTmqdi9CDCso4XmbSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAuv3fxl/qZJ4lnZfcLmxj1vrBDQsbjPPQ2FU/0bdlY=;
 b=j3NfZBN9GA1CZvxcb5HwhtWsNipc6J5yMZNCChqcXNOHLjjOE0XsmHy3WRi9hdU8vxM5dwCBbG072XU9k2kTXgeaQ5AEJcABlztKQhk0XxR4yGE9xuOALKvEfyO6T+3VBODMSw+u4c5RLrq+eqs8npmBkyFK4z+4u+/bgDHnC4U=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2780.eurprd03.prod.outlook.com (2603:10a6:3:f0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.25; Wed, 17 Nov 2021 06:08:40 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60%5]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 06:08:39 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] power: supply: core: Add kerneldoc to battery struct
Thread-Topic: [PATCH v3] power: supply: core: Add kerneldoc to battery struct
Thread-Index: AQHX2n+y2iIKcdsoDEGLqcFn5J628KwFr0iAgAB7TQCAABsTAIAAZ/GAgACQiIA=
Date:   Wed, 17 Nov 2021 06:08:39 +0000
Message-ID: <bbfeba1d-6199-c31f-26b6-afa9fd18dfe5@fi.rohmeurope.com>
References: <20211116001755.2132036-1-linus.walleij@linaro.org>
 <bbaa93fe-8a10-7c80-2b5d-c36b0968429f@fi.rohmeurope.com>
 <CACRpkdYNe8cMo016ZCtgnOLs2b5JzHXUB34KkNR_dzBRZQh8nA@mail.gmail.com>
 <e9458f4c-4520-4c13-13bf-a2c575fdbdfa@fi.rohmeurope.com>
 <CACRpkdb4FMqmVgJtwGdFmn3ZG4xy4qoYnNZPQEqfvTYGBDnwNQ@mail.gmail.com>
In-Reply-To: <CACRpkdb4FMqmVgJtwGdFmn3ZG4xy4qoYnNZPQEqfvTYGBDnwNQ@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c4761fb-29b1-4ed3-8b16-08d9a990b361
x-ms-traffictypediagnostic: HE1PR0302MB2780:
x-microsoft-antispam-prvs: <HE1PR0302MB27808621AC9E5B4214D2DAF4AD9A9@HE1PR0302MB2780.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rdPwTQb+XTQPMqdj479L4oZWDugDul9EHtXTQPcGyFmgh6R+CYa7cLF6MSZbTdYvyKliVyZE7tap0Kot+Y+Qx5N+ZMzqEBNfG3y3kOmOuBObKbyxDQrmOKO7KSNUTWLIPzbfaPMuLvX9Gmh9KXxDB3sAICpLVVcRb3f8yv0UDWwgCPJ5itwQkuw4cuREbE9b93irwRRgLsOMVzEMmFbLpL0MtRZFPUCpC31BKAFyXxFBHZsRQZntNVwEyqy2+2oUkIlwBlNanFsD8xTV5FZNCjQJ8W0O1e5UXWFknkklIxMvh+io5T35rLIWb7yN/cBkH+lvK6t797u3hBc5GCxHny61Gq1dRbb8CqPKHF5AzLHC9ZRDzgASjTAjSNWF5/epREqcfQTUO0RaJkz0fglsJIQGhnDjG+BLjacCv5AXbqU5ZdVVDfusW0im9As81FYcBthd/txa2e6VKgDNpxE8iiVnhcx0BEkaq0PwIRbhPHp/kAeFHfyOnQ26e/g8HXBda9pLCEEuGSl/P5nGQnBbZEVSqIJdEPHNdHWHfH9AoGZ/FkbUqGjbsf0sBlKQd8JftgLfl8cBTHOtzXWnvGinuh7zuqekKfRTPELHQ0ACxQX6EEFJxKTbOkVunSepObR1UI9fb+HQFjCrmgIzqvZr8/lkbyXXj3RatSqH8uzDfdTIDV0I1BWMd9Qpt0Qtu7pjbSCThZ66F6FyrsqwJrtUQ1BAA0RzhDqj8uF2+VBgKV7OGsQnL6gmut5xgt7vL8sSO6sNx9cY4jQzvkrJ6nzElg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(31696002)(508600001)(53546011)(66556008)(6512007)(64756008)(66946007)(66446008)(186003)(66476007)(6506007)(6486002)(8676002)(83380400001)(5660300002)(71200400001)(76116006)(54906003)(8936002)(31686004)(86362001)(6916009)(4326008)(2906002)(2616005)(316002)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TndCSWNzZmZMZGdibG1jRE5ub1hhYjQ5K0VQWWE2S00yd29MaVNKQzc1ZXRR?=
 =?utf-8?B?VTBOekV1NWNHT2QwUnlZNndCRFBLVkkxRlRDd2poWlpUQ1daWVQ1Q2YxQnZN?=
 =?utf-8?B?T201eUVHYUNldmMzWGtlSkI5NHExWmZFWlFtcFNHbHJHTURuVTAyT3d0ZzNy?=
 =?utf-8?B?aGFndjN0dGdKTENFcmpXelJodTNOelBWU21VRHJzUjRyUlRIWENMT2JzMGtJ?=
 =?utf-8?B?SVgwekV3WE5XWUMvdTVtYjV2K0NYNWlNd0l0U3FrYUlDRFdEQWd6Z3hNL2o4?=
 =?utf-8?B?K1NuK2lvc0c0QUhkMkVjNW41dEZ0MTRaWng2VHFnWHVMQmhhcGtPWktDV1d1?=
 =?utf-8?B?cjUrb1FVUE0vVStyMDlXc3RBL1F5WEJvN3prU1ZoVW9ISzkvUG9HZTM2d05W?=
 =?utf-8?B?THpNZDQvMDV5N3MvTjhlYWY2RkV1T2tlS08rNm9meUIvOEdudFBYYTlOOWph?=
 =?utf-8?B?Q21QVlBMQzIzUlIzb3dlano3V1pOV21PMDcxdDh4K0pmZGFSZHkrVDMxTlRh?=
 =?utf-8?B?VHBZOHJEYzF3L2h5eWNkZ3dWMENzeGc1N0UyVENpeWh2K2hzdVNSYUU4emdW?=
 =?utf-8?B?YXVhWW43L3Y3T3EzeVViZmxVbFhEMndtNVlEQVorUHNnWmNGODIwQ05CR3BJ?=
 =?utf-8?B?VXFDODJqUCttZC96RlRaUWI1VzFQcTltU3NPanIyeVNuMFRvbTRDTitNcXZB?=
 =?utf-8?B?ZENKZ01DRHBtenBWd0hmSWEycTh6aHlBQ09DdkJCT0dKSit1RThCVGMrakc2?=
 =?utf-8?B?UURiektnbFNiU2JQQXJxS3dZb3R6cC9MN1g1KzVReE5hQXJhaXgrVW95aDFO?=
 =?utf-8?B?WFNZYzg4OHZGSjJveDhCOGNSeUpVMUg0WnVXYnoyMkFJTTZsbVptQ2hJZ0Ux?=
 =?utf-8?B?VENzNTV1dk9HY1RKOHNWL09paGNuTXZqbUVlZFVSakE1ck9jSDF0K2tybzR6?=
 =?utf-8?B?YUdnZHEzb0YxZVd3WHNiVkFOdEY0UlZqRFkzS1AyK0tSU1c1emV3V01yeVpX?=
 =?utf-8?B?ZHRaeDUwNDAzTnd2Z1JMWXUyRkp5QjhqTzVRZlRudUVWekNETjNEMG1QaFRw?=
 =?utf-8?B?Wk1BNzZFUktHbWo0ajM1RGF5UHBSUGtwZTkvZXJacTJrbllqcUVtK1J4K1dB?=
 =?utf-8?B?dDNDVWM2VXREalNEVC9rSXBadDFkZ01TVHJJc1RjZUU4eTQ3RUNNbktGOFQ5?=
 =?utf-8?B?RXZpTFNZZlpySlVBdWJiRlFnTXk3NHNXOWV2L1lrNTJuZlQzL2N3SEpVM05W?=
 =?utf-8?B?bnpKWmNkNDRHZzEzcmV1WXVCdzdyNzhBUEhoWWVrNHJOTDl1ZUxrci9HWXRC?=
 =?utf-8?B?ZzNQU2lqZGU1eDFrVUpXZXJqTXhQTzI1OUlZR0pWOGh3VnhaUUlQTk1vb2N5?=
 =?utf-8?B?cUYwdnFZaXNFUzBuY3hrTjBhakJZQmdOeklsUis4NnU0dmpLcCtXeE82SDZH?=
 =?utf-8?B?aVc3ZzRQeVlYd0gwMzdITGRxU2ZVeXM1akh4Mi9wTlNWdXp3bi83bVhjbUlF?=
 =?utf-8?B?N2tIK28yakdOMEpKODdLb0FrbC9ycUVIVEdvM3pFNEpEeDk4LzJHL0dOK0po?=
 =?utf-8?B?Ync3V1VyQkxiMlpOYW9PdVJiWlprTE92L2NuMDVOWFo4N3lSdVRPTjR2Nnps?=
 =?utf-8?B?NHgzUUJPSWVrUHlpTjlwOGxPdDFSb3l0WG93RDkrRndZWU9IV2ZoM1ZiU3Ja?=
 =?utf-8?B?UmxYbjBQN0c5eWprVnMrY3NYZUg3UDlPQlF0eUR5bDArNnJUeHI2R291c0dp?=
 =?utf-8?B?aVVPYm14N0RvaEFEaTdVS05Na1pVa2pvYzlmUWswMkhuWTBUejkxNlY5eU9C?=
 =?utf-8?B?WHNkTkdhWExWd2gxQWNKeGFtT21aSkVEOHVldWxzQ3paS3k5eGYrY3VzOVlR?=
 =?utf-8?B?a09UL1o1SU4wQVJ0d3dxKzJRcDN0bVdDQWtpOEhTN1dFd0E1ekEvYm5zLzFD?=
 =?utf-8?B?LzRZdFlubFh0WHZLSjJ2VytYZVZKaHhsRVdPQlRsTEF6emJ2c2Q3SkNmWTVi?=
 =?utf-8?B?cEZSRFNZTkhSOE9Iem9xZDN2WkFRVFJuTE1JdG9aTWhSeDVqRHkxVU9MNlFY?=
 =?utf-8?B?N3R5QytSNFJ2RDVoc2FTVXRNNnA1cHZqMS82VXRBQndIeVFQZUVuUzUreWlF?=
 =?utf-8?B?bEZGeVV4cStscDhPdDI2THNnRndXSjNNT05jYXZIUUpXdDI2Y0N2YlpTWUF0?=
 =?utf-8?B?MnpKWmdDNFNJQzZHN3ZKNGdFZS9Dc3RIRXpma0xqYjFWaHhRMzhmSUZ5R2Jz?=
 =?utf-8?B?dTE5Z2xOWndzYk5acU8rdlllZnIvNi9XV0gzc3N2TlpmUHVWblB0TnJNL0cw?=
 =?utf-8?B?VTV1QS9NQjFidnQrb3BEdWNocEVxUUJOUkl5NEVFTWdDd3ZMSGF3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E813DAEB4BB2A04B84A5C30117E16989@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4761fb-29b1-4ed3-8b16-08d9a990b361
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 06:08:39.7336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzaiiMijD4hKi09mzLaFBx3OIHJrq+2HiHZg3bc/HbUjp+ldubZexZq9SZ4iJOdzAlzgoXmulgII+apUltLah68guVDJzTkYRsOBpwS2goR5bF6I9f332wBYERzLqZlO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2780
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTEvMTYvMjEgMjM6MzEsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDE2
LCAyMDIxIGF0IDQ6MTkgUE0gVmFpdHRpbmVuLCBNYXR0aQ0KPiA8TWF0dGkuVmFpdHRpbmVuQGZp
LnJvaG1ldXJvcGUuY29tPiB3cm90ZToNCj4+IFtNZV0NCj4+PiBoZXJlIEkgYWRkIGEgdGFibGUg
dG8gaW50ZXJwb2xhdGUgdGhlIHRlbXBlcmF0dXJlIGZyb20gYW4gTlRDDQo+Pj4gcmVzaXN0YW5j
ZSB0byBzdHJ1Y3QgcG93ZXJfc3VwcGx5X2JhdHRlcnlfaW5mby4NCj4+DQo+PiBZZXAuIFRoYW5r
cyBmb3Igc2hhcmluZyB0aGlzLiBJJ2QganVzdCBob3BlZCB0aGVyZSB3YXMgS2VsdmlucyB1c2Vk
DQo+PiBpbnN0ZWFkIG9mIENlbHNpdXMuIFdvdWxkIGFsc28gYWxsb3cgdXNpbmcgbmVnYXRpdmUg
dGVtcGVyYXR1cmVzIGFzDQo+PiBlcnJvcnMgaW4gZnVuY3Rpb25zIGxpa2UgdGhlICpyZXNpc3Qy
dGVtcCooKS4NCj4gDQo+IEl0J3Mgbm90IHJlYWxseSBhbiBpc3N1ZSB3aXRoIHRoZXNlIGZ1bmN0
aW9ucyBzaW5jZSB0aGV5IGNhbid0IGZhaWwNCj4gYW5kIG5ldmVyIHJldHVybiBlcnJvcnMgYW55
d2F5Lg0KPiANCj4gSXQnZCBiZSBhIGJpdCB0aGljayB0byBzdGFydCB0byB1c2luZyBLZWx2aW4g
c29tZXdoZXJlIGluIHRoZSBrZXJuZWwNCj4gd2hlbiBldmVyeW9uZSBhbmQgaXQncyBkb2cgaXMg
dXNpbmcgQ2Vsc2l1cywgaW5jbHVkaW5nIHRoZQ0KPiBzeXNmcyBBQkkgdG8gSUlPLiBBbHNvIHRo
ZSBkYXRhc2hlZXRzIEkndmUgc2VlbiBhcmUgdXNpbmcgQ2Vsc2l1cw0KPiBmb3Igb3BlcmF0aW5n
IGNvbmRpdGlvbnMuDQoNCkkgc3VwcG9zZSB5b3Uga25vdyB0aGUgc2F5aW5nOiAiSWYgZXZlcnlv
bmUgZWxzZSBpbiB0aGUgd29ybGQgdGhpbmtzIA0KdGhpcyBzaG91bGQgYmUgZG9uZSBkaWZmZXJl
bnRseSwgaXQgb25seSBtZWFucyBldmVyeW9uZSBlbHNlIGlzIHdyb25nIiA7KQ0KDQpJIGtub3cg
Q2Vsc2l1cyBhcmUgc3VwZXJpb3IgaW4gZXZlcnlkYXkgbGlmZSAoYXQgbGVhc3QgZm9yIHVzIHdo
byBoYXZlIA0KbmV2ZXIgdXNlZCBGLiBBbmQgZm9yIG91ciBkb2dzKS4gQnV0IGluIGNvZGUgdGhl
IEtlbHZpbiBpcyBzdXBlcmlvciAtIA0KZXZlbiBpZiBJIGFtIG5vdCBzYXlpbmcgeW91IHNob3Vs
ZCBiZSB0aGUgb2RkIG9uZSB1c2luZyBpdCAtIGl0J3Mgc3RpbGwgDQpzdXBlcmlvci4gRm9yIGV4
YW1wbGUsIHlvdXIgcmVzMnRlbXAoKSBmdW5jdGlvbiBkaWQgY2hlY2sgdGhlIA0KcGFyYW1ldGVy
cy4gR29vZCBvbGQgLUVJTlZBTCBzdWl0cyBhbG1vc3QgYWxsIGZ1bmN0aW9ucy4NCg0KWWVzIHll
cy4gSSBrbm93IEtlbHZpbnMgYXJlIHJhcmVseSB1c2VkIGFuZCBicmVhayB0aGUgZXhpc3Rpbmcg
c3R5bGUuIEkgDQp1c2VkIENlbHNpdXMgbXlzZWxmIHdpdGggdGhlIGRlZ3JhZGF0aW9uIHRhYmxl
cy4gU28gSSBhbSBwcm9iYWJseSBqdXN0IA0KcmF0dGxpbmcgdGhlIGNoYWlucyA6KSBCdXQgaG93
IGNvb2wgd291bGQgaXQgYmUgdG8gdXNlIHVuc2lnbmVkIHR5cGVzIA0Kd2l0aG91dCB3b3JyeWlu
ZyBhYm91dCB0aGUgbmVnYXRpdmUgdmFsdWVzPw0KDQpBcyBmb3IgY2xhcml0eSBvZiBLZWx2aW4g
LSBpdCdzIHRydWUgaXQncyBtb3JlIGRpZmZpY3VsdCB0byBpbnN0YW50bHkgDQprbm93IHdoZXRo
ZXIgdG8gd2VhciB0aGUgVC1TaGlydCBvciBhIGphY2tldCBhdCAyOTNLIC0gY29tcGFyZWQgdG8g
MjBDLiANCkJ1dCB0YWtlIGFuIGF2ZXJhZ2UgZW5naW5lZXIgYW5kIGhlL3NoZSBzdGlsbCBmaWd1
cmVzIGl0IG91dCBpbiBhIG5vIA0KdGltZS4gSSdkIGd1ZXNzIGV2ZW4gdGhlIGF2ZXJhZ2Ugam9l
ICh3aG8gbWF5IG5vdCBiZSBhbiBlbmdpbmVlcikgY2FuIA0KZmlndXJlIGl0IG91dCBpZiBoZSBo
YXMgdGhlIG1vdGl2YXRpb24uDQoNCkknbGwgbWFrZSBhIGJvbGQgY2xhaW0gZm9yIHlvdSAtIHRh
a2UgdGhhdCBhdmVyYWdlIGVuZ2luZWVyIGFuZCBhc2sgDQpoaW0vaGVyIHRvIHB1dCB0aGUgbmVn
YXRpdmUgdGVtcGVyYXR1cmUgdmFsdWUgaW4gZGV2aWNlLXRyZWUgLSBhbmQgaXQnbGwgDQp0YWtl
IGZhciBsb25nZXIgZnJvbSBoaW0gdG8gZ2V0IGl0IHJpZ2h0IHRoYW4gaXQgdGFrZXMgdG8gZG8g
dGhlIA0KY29udmVyc2lvbiB0byBLIDspDQoNCj4gSWYgd2UgbmVlZCBhbiBlcnJvciBjb2RlIGl0
IGlzIGJldHRlciB0byBwYXNzIHRoZSB0ZW1wZXJhdHVyZQ0KPiBvdXQgaW4gYSAqcG9pbnRlciBh
cmd1bWVudCBhbmQgYWRkIGEgcHJvcGVyIHJldHVybiBjb2RlLg0KDQp5ZXMgeWVzLiBUaGVyZSBh
cmUgd2F5cyBhcm91bmQgaXQgSSBrbm93LiBJdCdzIGp1c3QgdGhhdCB0aGUgS2VsdmlucyANCnN1
aXQgY29tcHV0aW5nIHF1aXRlIG5hdHVyYWxseSA6KQ0KDQo+Pj4gQXBhcnQgZnJvbSB0aGlzIEkg
d2FudCB0byBhZGQ6DQo+Pj4gbWFpbnRhaW5hbmNlIGNoYXJnaW5nIEEgYW5kIEIgc28gZXNzZW50
aWFsbHkgdHdvIHZvbHRhZ2UrY3VycmVudA0KPj4+IGxldmVscyBhZnRlciBDViBjaGFyZ2luZyBo
YXMgZmluaXNoZWQsIGVhY2ggd2l0aCBhIHNhZmV0eSB0aW1lciBzbw0KPj4+IDIgKiAzIG5ldyBw
cm9wZXJ0aWVzIHRvIHN0cnVjdCBwb3dlcl9zdXBwbHlfYmF0dGVyeV9pbmZvLg0KPj4+IEJ1dCBJ
IGhhdmVuJ3QgY29kZWQgaXQgeWV0Lg0KPj4NCj4+IE9rLiBUaGlzIGRvZXMgbm90IHNvdW5kIGxp
a2UgYSBjb21wbGV0ZSByZXdvcmsgOikgSSdsbCBrZWVwIG9uIGV5ZSB3aGF0DQo+PiB5b3UgY29v
ayB1cCBoZXJlIDspDQo+IA0KPiBOYWguIEkgd2FzIHRoaW5raW5nIG9mIGJyZWFraW5nIG91dCBh
bGwgdGhlIENDL0NWIGNoYXJnaW5nIHBhcmFtcw0KPiB0byBpdHMgb3duIHN0cnVjdCwgYnV0IGl0
IGlzIGJldHRlciB0byBkbyB0aGF0IHdoZW4gc29tZW9uZSBuZWVkcw0KPiBpdC4NCg0KSSBsaWtl
IHRoaXMgaWRlYS4gSSd2ZSBub3QgZ2l2ZW4gbXVjaCBvZiB0aGlua2luZyB0byBpdCBidXQgaXQn
ZCBtaWdodCANCmFsc28gYmUgY2xlYXJlciB0byBhbHNvIHNwbGl0IHRoZSBjYXBhY2l0eSBlc3Rp
bWF0aW9uIHJlbGF0ZWQgc3R1ZmYgbGlrZSANCnRoZSBPQ1YgdGFibGVzIGluIG93biBzdHJ1Y3Qu
DQoNCkFsbCB0aGUgYmVzdA0KCS0tIE1hdHRpDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkg
YXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBk
cml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5r
a2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9m
IGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
