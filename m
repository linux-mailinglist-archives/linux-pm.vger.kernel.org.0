Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50696347510
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 10:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCXJvW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 05:51:22 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:37473
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232343AbhCXJvO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Mar 2021 05:51:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTxYyXr7mns0A1lOOBekIJq2N8sMt2K7tg3EJf+Tn7POYZspW56G4uGTJXn2AJYPpa6FxA3sbGz4bNPYN3KkLmAJ2WMEcozeJKlIC8Hys72M9DcCztL7mmPZCNMNVPWEPOq2NybE9oPCmuHPtWdD7x9sGvmAWDSPDXRboBJ/J7bPr3iLUlcxvCHeKfcRhCy5+fhHlbzbUYj1pJIjwRYI0BpJIq/Hu9xcWdIEYgxkCtWL6wQwEQ1tpBV2vjQv58zfDSewmInbB9EnpiA5eAVMuJFeFfGrvzlXoWWnKPr7SdBhh8SPHfxiGOPyckXoJr5FTaFTOuZ1wA9SJ/2cmN/Hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpkkea9mVofsYQMbgSsK5lj5q0+u/NAbylA96EkpZhk=;
 b=lzBqb5HUZ/yviTODlAF/0vJSjs+gUmnv4x5jdPyXqlws7mEZ7SVOd9RzBVtYQsAZqrluiHnd9pwxB3TnEMh2d+58a1Ucb6VGz6+jEa4xqiTh74QNO2iw5Crw0eDY5posl6FfCn9etgYHJlkY0/rpn5nAFJHOonzm1aP1YGG0OXuYz65cvbsJJjk5OFUsF6VRk4LL0l4bTfzjHF4zxe+Dt1ZPa4SkUY6Zf83dAtJvMm5BI0LRODIg0fE6371Fp09bIoBrmmwjkOUOUBYF/ru4bkD7uCK+rv7njyDt35NHnxdbOQRSjCW3Hl0A7aJKI4Wj1lxWny3h0nBpJj7xy158WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpkkea9mVofsYQMbgSsK5lj5q0+u/NAbylA96EkpZhk=;
 b=jUPVzubb3SmTiBI3qZkY4r8tH8tRJsYcxxHacsMTIW3EEFcHBH8YaQ0F+N36I1J8qljaNilDI1Kg1GNajNNHs1kiPkDYvafQipkW3oE0v+ZP0Y9GIJS5DArwXnGgPzrlva8mWczDQqDeSXKgltUPJEga6uNpsJ09+6EHxGdplWA=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2475.eurprd03.prod.outlook.com (2603:10a6:3:69::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Wed, 24 Mar 2021 09:51:10 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd%3]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 09:51:10 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] extcon: extcon-gpio: Log error if work-queue init
 fails
Thread-Topic: [PATCH 1/2] extcon: extcon-gpio: Log error if work-queue init
 fails
Thread-Index: AQHXII8SSw+f6bGlyUOCCe2VPDR3+aqS3hGAgAAHP4A=
Date:   Wed, 24 Mar 2021 09:51:10 +0000
Message-ID: <58298d5bdd026a492e4fa2ad6de25720c66710ff.camel@fi.rohmeurope.com>
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
         <bfd893701ac3d239fef856d2f589063983422100.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
         <1860d4e8-2e3a-fe05-cab9-782f3e35b9ab@redhat.com>
In-Reply-To: <1860d4e8-2e3a-fe05-cab9-782f3e35b9ab@redhat.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4847d46-f30b-4e17-8ced-08d8eeaa5aa5
x-ms-traffictypediagnostic: HE1PR0301MB2475:
x-microsoft-antispam-prvs: <HE1PR0301MB24757E099DFE7B0DEB7B16B6AD639@HE1PR0301MB2475.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tzFul8wNB6w4A85PfEcHACL2u+tpatNkbOTW2RkaNVGfVCFYp0gqLM2blDr1ViLjXSb7548zBYkth4LTHyBDU4VkFcFv6TWTAnay+NwMZJ5em54tYLknlRGAgUBSuyYuLOtDg0dXcnFha7UU+zMuHbCR56viVYia1k0d42agXXDJMurNj4VdmhCrYArIbMck6dT4j0yVG+Lv309sAEs806bBxI50fUVn2XNYdAgAogtqPKvDkSygy6JKJN6zK9XAXKEfkdS2zrws85Fxp0kjWDGHJIpq8ebR6DM1/7oiVccrMCZvl4tkc4yC7Y7lcwvKd45w/O2TU6OYnDvGaSO7MF3kYKXgivou+W3hY/cUT4xSSiE4t8ALrOCWQ9O/vpNfap9uysAON/gWTDUIaL0M5hzDVNTXAF4mpV9mKW5DmaMPvCmYjj0/1LtBG1SHzpuguATvq2uzrY5fOMbH5VRxU/PRJu8kYWoYii5gpLUyFapMa3twTtp670EhyFi/YjTV/xtuARYtHlu/auj5zw2pfc77w3uxd5jgcURbKraUZv2Tq0SdsuTJ2yXgoDczwPFF+lV4O+KBjj5rgJ1Wh4Db1Yakaqq53IgpstwV3izEKAQ/ud9xsIj8AE6RhJ6G9BR31HVRu/JJic0nOFjiq5h35KejnhAjShN0Knbol1N/UkQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(376002)(396003)(346002)(76116006)(3450700001)(8676002)(6512007)(4326008)(66946007)(38100700001)(5660300002)(53546011)(2906002)(66476007)(478600001)(6506007)(64756008)(66446008)(66556008)(71200400001)(54906003)(186003)(86362001)(6486002)(8936002)(6916009)(83380400001)(316002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Vy85RVFkd2syemE5THpKVk1jdG1KM0pwM1BobndhbVhFemtaTEQyblNrOG9D?=
 =?utf-8?B?WE9Wb1dQRXh0bE5zRGJaVUtjSmVJekt3RzZtWitzL0NwOWVEL29DMG9hUGQw?=
 =?utf-8?B?clBqRlJGczBVNjd2QWJxa0wwZ2JNQ1ljcFBPZGdHNC9LU3RWTjRRUGdESmxw?=
 =?utf-8?B?OUFydkJITW14K2JYdllyeTNZT05MQnpzZ291QjhQVUdUMEFSQ2VYMEhMTTdL?=
 =?utf-8?B?QTMyTGdTV3VNMS9aMmdEZWRzVDV3U01SYU1uS3YvL21LREtJeW53R0xjSnBI?=
 =?utf-8?B?S2s0QWN0ZmZ5OFJib0dUMFRqVVZ3blpXQ1B6MkN6REsxNzFUUlNrUzlUdzE0?=
 =?utf-8?B?UWlHeDB6WFZvMGZnZFhNdGRhN0dSY2NlM2V0MnVKK1NqVTlHZkdRYW84b0RZ?=
 =?utf-8?B?UCs0dnQrdm1hNk5qTjNpblBVV0hwY1N2bzVVOURKWllUS3R2VW4yMnJIQjMy?=
 =?utf-8?B?YnJXejM4dGRRaVdUT0ZGMnluVU5nRVg4WVhta25jTVRZdFg4aDdoNXNIT0tV?=
 =?utf-8?B?OWVjZ1VwUWx0YTVmZU51MUR5UlUwMFBOQWl2bDVoNS9kZW5XWU5uL3NZVTRP?=
 =?utf-8?B?Q0dzSzVBWFA2NUwyODF6U3d1OWdmcFU2bm5vWjR1M0tIRCtHenAvMDFGZHZw?=
 =?utf-8?B?RTVDeG8rbGhtNjNvbFdGMTl0aW10Uk9mVTlFYnB0dG9ycUtIM2JFZklxZ25w?=
 =?utf-8?B?dTNRRWhVcUluMEp4SUJYK0RadEVZQm9nN2FyMGhwVmJXZ0dwZHQzNzFqM0wy?=
 =?utf-8?B?d0puckpsQU5pK3JpZlcvSGNMYmtNSjNQbU96ZytUYmZ5NjBDY3IrMWhZL1Ry?=
 =?utf-8?B?c3V3M0c0YVhsTEZKNDF0aHAyWmRQOTYxMENPcXo4SW50cG52b2FONVphQVpK?=
 =?utf-8?B?VExnbW8yc3N0VjIxVXVYMHpzaHI2OHJDRTAydzQxcFI1YXUvbE9qaEExem1Z?=
 =?utf-8?B?OUpCczFsSElDWE9IWEZLVzBjR0swSkc2T1dKSVE0RVY2Y2M4Y1dDZUlzbEt0?=
 =?utf-8?B?bzVxZXhYdkE0UWhVamdTTXJWdkVqWVV2N3hBZlYxN1JOZ3B0N2oyM1FKU1B3?=
 =?utf-8?B?WUtnaVpaWmxJMkZXRmFEYWtRWEMrdi92bzcxRWhJTTBRZlZOTWJHZWR6eXZa?=
 =?utf-8?B?RHQ0SkxlWXlLMkNOWFVCTHVzR0dUaGJLblZmQ3ZSWE9Oams0emQwcDhIL21Z?=
 =?utf-8?B?N2hQdWxzT3lIUWVCSEl2M2krZ0wrcWsrN0FiRHpVQkozN3hCYWl3dVd6UUQz?=
 =?utf-8?B?Q2JGT3pGVHVEUzF4TzhSZExKUGtYTDQ5VUgwUDhVZkg2a0p0RUlVZUxuYVRk?=
 =?utf-8?B?emg0K2Q2eWt0QUFVYzc3QWl3VzltZnVUSTZxMlBTRWF6V0hNS0xDN2lZekhT?=
 =?utf-8?B?d1Faa2cxQ21iODZVZnQrOXM1bEZmbmQyUHBTYTJaa0RXY3craFQyTDQzUzRi?=
 =?utf-8?B?ZWpUcTh3L3pBR2dVM3ZPbnk0Nmg2UWREeTc3OHkxSWg0TE0weXNBVTV3WTFr?=
 =?utf-8?B?Y1pqcUw3eGIzakxQZ1dvZkJ6ekRaRDBtUlEyNytUeW85aHJUWWgvVEk0OGhF?=
 =?utf-8?B?TkZwTzNVMmF4RkpJTjg0MDNJZXJJa2MraUNXdHV1QmxCYmRsNk1vRy82U2M3?=
 =?utf-8?B?TXpjWjhSRkxBbTRBOERqN3pFRTE3RHRxbWtVZUxkSHdnL1U2Y0d6WFVnbHJj?=
 =?utf-8?B?alF1aW9iZlIzUVo1U1hMUjJRdmwyR09idUwyVGlNdTVhUDdzdGJreEsya1JM?=
 =?utf-8?B?S3h5Vk9xZTVZNFUwMHJmRE1FQm9SMmVtTHg3L0t3ZzJnWGZSZVdUV01VR3VP?=
 =?utf-8?Q?v/rX9ggEl6ouOcEl6dd5Jzxn7h5gojeY72yEo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED69FD7E6A98AC43862A88B099A8D9E3@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4847d46-f30b-4e17-8ced-08d8eeaa5aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 09:51:10.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eIR8zyB4Ckc3SQHKUrLiwht3+vbOU9ApOtoproTiOtWCuJrtHjetUQr+gZMfI7ZmAmj/COWCTFQHM8gvV8j8yCf1+khh8wj9ksn8ZKx9hFupUORhOOUxzgLllrmbL8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2475
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gSGFucywgQ2hhbndvbywgR3JlZywNCg0KT24gV2VkLCAyMDIxLTAzLTI0IGF0IDEwOjI1
ICswMTAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIDMvMjQvMjEgMTA6
MjEgQU0sIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiBBZGQgZXJyb3IgcHJpbnQgZm9yIHBy
b2JlIGZhaWx1cmUgd2hlbiByZXNvdXJjZSBtYW5hZ2VkIHdvcmstcXVldWUNCj4gPiBpbml0aWFs
aXphdGlvbiBmYWlscy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4g
PG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gPiBTdWdnZXN0ZWQtYnk6IENo
YW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2V4dGNvbi9leHRjb24tZ3Bpby5jIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9leHRjb24vZXh0Y29uLWdwaW8uYyBiL2RyaXZlcnMvZXh0Y29uL2V4dGNvbi0NCj4gPiBncGlv
LmMNCj4gPiBpbmRleCA0MTA1ZGY3NGYyYjAuLjhlYTJjZGE4ZjdmMyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2V4dGNvbi9leHRjb24tZ3Bpby5jDQo+ID4gKysrIGIvZHJpdmVycy9leHRjb24v
ZXh0Y29uLWdwaW8uYw0KPiA+IEBAIC0xMTQsOCArMTE0LDEwIEBAIHN0YXRpYyBpbnQgZ3Bpb19l
eHRjb25fcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCXJl
dHVybiByZXQ7DQo+ID4gIA0KPiA+ICAJcmV0ID0gZGV2bV9kZWxheWVkX3dvcmtfYXV0b2NhbmNl
bChkZXYsICZkYXRhLT53b3JrLA0KPiA+IGdwaW9fZXh0Y29uX3dvcmspOw0KPiA+IC0JaWYgKHJl
dCkNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBpbml0
aWFsaXplIGRlbGF5ZWRfd29yayIpOw0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+IA0K
PiBUaGUgb25seSByZXQgd2hpY2ggd2UgY2FuIGhhdmUgaGVyZSBpcyAtRU5PTUVNIGFuZCBhcyBh
IHJ1bGUgd2UgZG9uJ3QNCj4gbG9nDQo+IGVycm9ycyBmb3IgdGhvc2UsIGJlY2F1c2UgdGhlIGtl
cm5lbCBtZW1vcnktbWFuYWdlbWVudCBjb2RlIGFscmVhZHkNCj4gY29tcGxhaW5zDQo+IGxvdWRs
eSB3aGVuIHRoaXMgaGFwcGVucy4NCg0KSSBrbm93LiBUaGlzIGlzIHdoeSBJIG9yaWdpbmFsbHkg
b21pdHRlZCB0aGUgcHJpbnQuIEJlc2lkZXMsIGlmIHRoZQ0KbWVtb3J5IGlzIHNvIGxvdyB0aGF0
IGRldnJlcyBhZGRpbmcgZmFpbHMgLSB0aGVuIHdlIHByb2JhYmx5IGhhdmUNCnBsZW50eSBvZiBv
dGhlciBjb21wbGFpbnRzIGFzIHdlbGwuLi4gQnV0IGFzIENoYW53b28gbWFpbnRhaW5zIHRoZQ0K
ZHJpdmVyIGFuZCB3YW50ZWQgdG8gaGF2ZSB0aGUgcHJpbnQgLSBJIGRvIG5vdCBoYXZlIG9iamVj
dGlvbnMgdG8gdGhhdA0KZWl0aGVyLiBNYXliZSBzb21lb25lIHNvbWUtZGF5IGFkZHMgYW5vdGhl
ciBlcnJvciBwYXRoIHRvIHdxDQppbml0aWFsaXphdGlvbiBpbiB3aGljaCBjYXNlIHNlZWluZyBp
dCBmYWlsZWQgY291bGQgbWFrZSBzZW5zZS4NCg0KPiBTbyBJTUhPIHRoaXMgcGF0Y2ggc2hvdWxk
IGJlIGRyb3BwZWQuDQpGaW5lIGZvciBtZSAtIGFzIHdlbGwgYXMga2VlcGluZyBpdC4gSSBoYXZl
IG5vIHN0cm9uZyBvcGluaW9uIG9uIHRoaXMuDQoNCkJyLA0KCU1hdHRpDQo=
