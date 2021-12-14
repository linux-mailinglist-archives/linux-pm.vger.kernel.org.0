Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A41473D59
	for <lists+linux-pm@lfdr.de>; Tue, 14 Dec 2021 07:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhLNGxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Dec 2021 01:53:41 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:59850
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229979AbhLNGxl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Dec 2021 01:53:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naxplrUrHJI/8mPcmz+LskXDpp7GQIAFzvs/BpQk+xlZxXDtZRAle0+KbusvL15NxfeSiYmhRM+1hVTafsNArE1ZES/H0hobMTsqmOaOOR2/HfZTDQkf9JoTDTw6VC67xPrJZUbvQUp83SI7zPCDbQRaBZ6q86pqmofzWcLlm4UI+IZ7JkhDm8tMXM9akVV7xIJUQlvuxmcfASilwoqjZBFETo7VJ1ljYY7fIe6gagv9SqPQqLFi+NzJtAMGbY7+qIgHH4XRwMwrYK6HNK8uJYCHIlZ45qRgouYUOrmcQPpidY5qbZrHN77YFqB78/SiYydktQdvNPwfGU7h8msIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMjchrmvQZcVQFVpgzpH3J+shfnrEIJN9c8yzqz8oww=;
 b=CSfI+mkHq8XAwI77hJW1oPhM9cl8i3UWxmqQKRuFkTn3XGLQgvH4BBoIRKXnHbreFKZuwsds3cD7EYbZD0eCkdXci/SLoeavDjY0lWKM8tUnp2RAsmI7mNR3w6l7eghOpvWrCoQ71PQK+vuHmQJSpIWPapaCLAAwxJ5t36DHoB9PCEBBSzuG+usgugxl68yYRmiYQFou/XdGLm0gJtyDEZboj9Is1HZ4LT+MqMAqi9t3KHkGP3TCXyK8VMb6D4y8d+tHDxvySbwntnW7WusmVtuxnm/Iv9+kU/QvY34ti8rBBSpA5oU8qzBVkZ5fYoyUwDz7iR4YWhe6otHTcUfRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMjchrmvQZcVQFVpgzpH3J+shfnrEIJN9c8yzqz8oww=;
 b=b57ytbQ85YxcagFniXaPwmL4/UIXdXb4IY5WlE3p00A4h6Xyxg5PHOiTA3K9sOlUbYgZUGx4j6vYcAAoKcwlhwmGD/zuysVOrc6RJqItEphNCaE7eyhRuFmNTX+w6Hug2lRHJRR6tl4Tkt6Wgob3xKFqEktj9Zc8VjgJ5kAYCX4=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2315.eurprd03.prod.outlook.com (2603:10a6:3:23::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Tue, 14 Dec 2021 06:53:36 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 06:53:36 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] power: supply_core: Pass pointer to battery info
Thread-Topic: [PATCH v2] power: supply_core: Pass pointer to battery info
Thread-Index: AQHX8LdQGviRSf/qnkquoPixbKLqpw==
Date:   Tue, 14 Dec 2021 06:53:35 +0000
Message-ID: <9bed108f-9600-871f-d126-64f9a8796bee@fi.rohmeurope.com>
References: <20211206000651.4168035-1-linus.walleij@linaro.org>
 <7228bbd0-4428-18d2-8cef-df9a9c789d41@gmail.com>
 <CACRpkdaKmZp62DSB7oMbESRjXAH8ncfLyc3KioSDx2z-_JOK8A@mail.gmail.com>
 <CANhJrGMHr=VLAwe-Tvyg70nN4ArjHa8UHKZODwrufK1r+rRNcA@mail.gmail.com>
 <d4478fbf-1ec8-5659-c77d-f412c351e497@gmail.com>
 <04df0bff-87b0-d39a-4f5c-bbeb7f3e0cd1@gmail.com>
In-Reply-To: <04df0bff-87b0-d39a-4f5c-bbeb7f3e0cd1@gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85c4bd8d-e056-4cd4-b732-08d9bece73a6
x-ms-traffictypediagnostic: HE1PR0301MB2315:EE_
x-microsoft-antispam-prvs: <HE1PR0301MB231504A988BB6CD53163D433AD759@HE1PR0301MB2315.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J00vB1GkcH208MTHUUhlHo0dZo36/u/NwyjN1KYDyu+oRUyMb4vY1DALJ0QoSQ9aNzCNFtH5+1wDBxDLM5NmgMdoYCL9QUFS6YvndYA9S4JxRduP/6vl7cJ+6JIz4NngQqJhCDk2KIsGzcMlSJqS2ypsQkP4aq0zQx1JYzdXN+ZQNQ9aff4a8f49UG69omIrvHGSOZHvYYL3z3zDYHfhe/inScn7Itsk63b6WU1+EJ+qFVmTouWDtvAlOjcj47yQy8delCdaT+ke6CCKq6FKGKMvCM0uIBwJNTAdKehgA4lSk7EvLPKw1hSDdbX17HhGjeAS85hfPNa+7GEJb52JluH7i8cDBj5/3rUifZQJ6+67Z8VLDxMw5zcoHCOt/rtDA+8TpvP+9Ger7FFQXhA29SSclkeVarBCJVrOetzIGQ1XEO2eqGOcbL4OG8PsSa8njQZyOR+VVVZMIGNfjiay95MUTtLstcB7CZe5ZAlu0YJLXHTmHnlydjPnYJ0jDAB8yVaC0vLXBqn+y4JUscrXp0ORMNNuX9L/woRRUT7ppphv3Pf1kdG8Jq3k0iNXAsQewsHPSbrFwNKGYqL0k27Or8SUuym0zWdpA/y90iFchB4VKxHZ+DywYUFC0YjtteXkPTCromSMU1lJGVPSlmkynBYHdJbo49qeG/e3lkxj4vkALBp88P7CBWHfU/7r9FQ2/GCLo+SkWgakQH1C8pCQAkWe3KFiL5R5ObGc9wJL1As4aQ/YsK0eyYDnJQqxhQ0YdFJrzY6slmESYIpjjXWJOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6916009)(2906002)(186003)(71200400001)(8676002)(122000001)(38100700002)(5660300002)(6512007)(6486002)(53546011)(6506007)(2616005)(38070700005)(8936002)(66446008)(54906003)(31686004)(66556008)(64756008)(31696002)(76116006)(66946007)(316002)(86362001)(83380400001)(66476007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhRUXl6Zi9XeG1Id3MvQ3luUjBzSCtMWDg5ZEMxSjFwMGs0RTFzNnhqQ1VV?=
 =?utf-8?B?a3VtZTh4ZFFwdHE1dzZRWHdmaG9HTkVhcmtoNE1BZ09ndTBRVk1iRkRlM0po?=
 =?utf-8?B?WjNVSVF0OFA4aVRaMGl6SGlsUXYrK1UzTUk5VUdwN0hwMUkzMFY4NEtqL3du?=
 =?utf-8?B?eVoyL3puZU9zUDdmR2VuUFJvTGFYaEhmVG5yYzNzWXdNUDVnWm5INE9OK3pz?=
 =?utf-8?B?ZS9oZHFZbXNxTmdiS3JLWlB0QXNyZ0JwakVnemFHZDBrUFQzTWxRVGphcnhz?=
 =?utf-8?B?bzQyT1dORmEzTTNwR0lESnBpVW81d1dVVlBVdk5Hd2h2YU9xZ1YwSnppQk1p?=
 =?utf-8?B?MWdWYlVlRUdiTjZ0TDBnazBPQVpNWkcrS1RBcUFhYTdnaXo3M3lCOTg5Z2I5?=
 =?utf-8?B?TUE0YlRTMEEzUzdmWDhkVFFmYXQ5QjlsVW5uOWd2OStEang4dUlmMjgzUURD?=
 =?utf-8?B?SkZQcjBldllISlJqMnZUQ2lVREVrczZCQVlDT05ySUtXUEZzZE55QklRZThH?=
 =?utf-8?B?NCtWcGlESkJaKzhCcmZOVWF6c1hxSFVsQlNXWUJ3ampXRnJ0WUZCVmRSNUlD?=
 =?utf-8?B?d0txMG9lRFJyTGhkeURtV3oySnRtS1EwbW9OS0kva2JOUHlwTEtMbmdNc3hl?=
 =?utf-8?B?RG9MazN1REZwM3hFVEhKR3BFN2FyQ2VjdUJpd1duTjB1bGdJOHhHZDFPMmF1?=
 =?utf-8?B?NVpmUTF6eGFRYmNERzFuM09tS2NteVNFeS9PY0laeUt3bDI1R0lYaUpXZUcv?=
 =?utf-8?B?WkpvMmdDc0ZIdXI3dmtrWjNxT2ZGb253WGM3R2tPWGlzVC82SVZmMDZVTGtx?=
 =?utf-8?B?TU9BenFTN1NJOGswOWlYMzJTSFRoeEs0RE44cHZZVHNzdjI2V21ELzU5SVJJ?=
 =?utf-8?B?WDVjbDFiY3ZHOXJTYUdjeEl1ZThnM1F2ZUJVVGdZRVg4ajZ6R3BmcFpIMzNa?=
 =?utf-8?B?akxucGh6eFFOUkJhYnVNNitjTDlhRWJUak52TTJXY05jVVZsZFdFaUdCZlM2?=
 =?utf-8?B?YU9xOGhNR1had1kxYlkwcUhybmdiRWpJL3o3QzlOVzdrOVFuanBSV1VORTJQ?=
 =?utf-8?B?MHdJczFMZnYxRE5JMmZraFdFenNTbnBLWlZPWjlQK05PSzF4QWJRd3ZzTHpr?=
 =?utf-8?B?OVV0VURnZUhSbWE4RWFZQlA5TnlPNDlibU9IYVRnNi93MjlhYzV6VGhkblVB?=
 =?utf-8?B?Q1Rmc3NqQzY5cWs3bFN4OGRuc0tBUHFCMjRBR09ZT3FoQ1IySlhIV0NNaVVB?=
 =?utf-8?B?aTQwT2JOR016RXRkWStYMVdZRDdvdHZoY0dvWVVPSWdoWS9tb3ZvcUZ6cTl5?=
 =?utf-8?B?aUlWdGkxeGZxanp6TnY1NXVpMEhkZk1nWGh1bVFEWk1KZjNnTnJFRU9ZVDJM?=
 =?utf-8?B?NVM0enV4K1RNaE8rYm00VTd1cndNc0VleW8rc1hreGZEbEd2ZUZoVTNMQWtG?=
 =?utf-8?B?c01IbVpIYmJXbHlFbHk3NEZ4Z0dKZStYNXhVRGJBOVgwT0JLQkdOUExRWVVE?=
 =?utf-8?B?NDJKd05kRE44OG03UGNvLytlM2xmcTRoOTJwcXJUYzBNdTJSUHZhRmVTTjd4?=
 =?utf-8?B?V2R6eEhCeHA0aTN4dTlWQjBxd2traitEd01zelhCbkpqVkZTcVgrcWlwa1Iy?=
 =?utf-8?B?T1FNUDRFUkxwZ2VRQWVDMmVBVDAzcW9Bd2tSQmVlRW5QMjVXSnM4bnVtc2lH?=
 =?utf-8?B?c0IzS3hWMjl3TERMM2o5MXVpWUYyZ3NMMWgzTXAvQy9yQ1ZhUHRpeC9tR00z?=
 =?utf-8?B?L05aTWh4VXFjMU5MNjI4QlBqWjlzN0EwTU9GeXlwa3hyMHpUUm50ZTd2VmVl?=
 =?utf-8?B?RlpYV3hnZUtrMlZnSGtCTkwyRE5LRVRGbTdMemp5bFl6OTBJUWFQWmhYV1Fn?=
 =?utf-8?B?SVJxNGhUNDk3U2owMHhudDZqdmdST2duVG1DNVdiZ3FuOVk4bDEyUFp3N3E4?=
 =?utf-8?B?WHMwWEZxQkRSeHRDT1FYdmQrSGgxV1RuL05Kd0lvMWJuSGxvelpBbk1kQzcx?=
 =?utf-8?B?TEMvVEhkRTJZUE1ST2ZnOUZrSWRDZWN2bUJkZ2RoMjRMcVlCeFE5dkZZQ2xh?=
 =?utf-8?B?WFNpejZXcW04NHpUMkJSdDhMQndQQ1NXS0tMZTUyTnZKL3k5STZiL3JWdVFm?=
 =?utf-8?B?MmFMTjVyL2ZZWkZSMnZBYzhSWEZaSVhydTJoSTNwWGlWWnJWY3ZrV25ZT1Rw?=
 =?utf-8?B?Q3F1L29YM1ZZelNTSFhLTTRoQlNkZk9GY1FJZ0Y3bytaMHJqTUtnYVh3dElE?=
 =?utf-8?B?eEQwMzdSVGpTNW5LZTdQR2RqdTEvQzcrdEhmNjgwUTNsS3JabkFrYzZ0bXkz?=
 =?utf-8?B?dVVmMkwxUkNCNVpWMkpQbHkyaUFvUG41a01jdm43QXY2QlBodzZxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26158616CC8EF54FA4E8178EFE2E6D99@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c4bd8d-e056-4cd4-b732-08d9bece73a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 06:53:35.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ox1Zcn8cXAUzi/QF0ZNgpqZPZObjTM6ZlpHJSleKuO0d/3tuiP/cCReuhsd+P3euUaXu3s62P1xgDd54h66z7a8DDhnjab9jOMOF+ayiejhHZfaK0gvFbbNHH8m5MkK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2315
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTIvMTQvMjEgMDg6NDQsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gSGkgZGVlZSBIbyBw
ZWVwcywNCj4gDQo+IE9uIDEyLzEzLzIxIDExOjIzLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+
PiBPbiAxMi8xMC8yMSAwNzo1NywgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4+IE9uIFRodSwg
RGVjIDksIDIwMjEgYXQgMjo0NiBBTSBMaW51cyBXYWxsZWlqIA0KPj4+IDxsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc+IHdyb3RlOg0KPj4NCj4+Pj4gQWxzbyBJIHdvdWxkIGxvdmUgaWYgeW91IGNv
dWxkIHRlc3QgdjIgb24gaGFyZHdhcmUhDQo+IA0KDQo+IEl0IGFwcGVhcnMgdGhlIHBhdGNoIHdv
cmtlZCBhcyBleHBlY3RlZCAtIGJ1dCBpdCBhbHNvIGFwcGVhcnMgdGhlIA0KPiBCRDk5OTU0IGRy
aXZlciBkb2VzIG5vdCBoYW5kbGUgbWlzc2luZyBpbmZvIHRvbyB3ZWxsLi4uIEkgdHlwb2VkIHRo
ZSANCj4gdHJpY2tsZS1jaGFyZ2VyIGN1cnJlbnQgcHJvcGVydHkgaW4gRFQgLSBhbmQgYXMgYSBy
ZXN1bHQgdGhlIGRyaXZlciANCj4gZGVjaWRlZCAtRUlOVkFMIHRvIGJlIHZhbGlkIHZhbHVlIChq
dXN0IHRvbyBsYXJnZSkgYW5kIHNldCB0aGUgbGFyZ2VzdCANCj4gY3VycmVudCBCRDk5OTU0IHN1
cHBvcnRzIGZvciB0cmlja2xlLWNoYXJnaW5nLi4uIA0KDQpJIHNob3VsZCBoYXZlIGxvb2tlZCB0
aGlzIG1vcmUgY2FyZWZ1bGx5LiBJdCBhcHBlYXJzIHRoZSBCRDk5OTU0IGRvZXMgDQpjaGVjayBm
b3IgdGhlIC1FSU5WQUwgLSBidXQgdGhlIHBvd2VyX3N1cHBseV9jb3JlIGRvZXMgbm90IGluaXRp
YWxpemUgDQp0aGUgdHJpY2tsZWNoYXJnZV9jdXJyZW50X3VhIHRvIC1FSU5WQUwuDQoNCj4gTGlu
dXMsIHdhbnQgdG8gZml4IHRoaXMgd2hpbGUgYXQgaXQgLSBvciBkbyB5b3UgcHJlZmVyIG1lIHRv
IHBhdGNoIHRoZSANCj4gQkQ5OTk1NCB3aXRoIHNvbWUgc2FuaXR5IGNoZWNrcz8gSSB0aGluayBp
dCdkIGJlIG5pY2UgdG8gZ2V0IHRoZSBmaXhlcyANCj4gaW4gc3RhYmxlIHNvIGl0IG1pZ2h0IGJl
IGJlc3QgdG8gYWRkIHRoZSBzYW5pdHkgY2hlY2tzIGJlZm9yZSBjaGFuZ2luZyANCj4gdGhlIGJh
dHRlcnktaW5mbyBhbGxvY2F0aW9uIC0gdGhhdCBtaWdodCBiZSBuaWNlciBmb3IgdGhlIHN0YWJs
ZSBmb2xrcy4gDQo+IChJIGd1ZXNzIHlvdSBoYXZlIHBsZW50eSBvZiBvdGhlciB0aGluZ3MgdG8g
Y29kZSArIHNvbWUgSVJMIHRhc2tzIGFzIA0KPiB3ZWxsIC4uLjtdIFNvLCBJIGNhbiBwYXRjaCB0
aGlzIGJ1dCBpdCBtZWFucyB0aGVyZSBpcyBsaWtlbHkgdG8gYmUgc29tZSANCj4gY29uZmxpY3Rz
IHdpdGggeW91ciBzZXJpZXMuIEhlbmNlIEkgdGhvdWdodCBJJ2xsIGFzayBpZiB5b3Ugd2lzaCB0
byBhZGQgDQo+IGNoZWNrcyBmb3IgdW5pbml0aWFsaXplZCBiYXR0ZXJ5LWluZm8gdmFsdWVzKQ0K
DQpJIHRoaW5rIHRoaXMgaXMgYSB0cml2aWFsIHRoaW5nIHRvIGZpeCBhbmQgd29uJ3QgYmUgdG9v
IGhhcmQgYSBjb25mbGljdCANCnRvIHJlc29sdmUgOikgU28gSSdsbCBqdXN0IHNlbmQgYSBwYXRj
aA0KDQpTb3JyeSBmb3IgdGhlIGhhc3NsZS4NCg0KU28sIHdoYXQgaXQncyB3b3J0aDoNClJldmll
d2VkLUJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNv
bT4NClRlc3RlZC1CeTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1
cm9wZS5jb20+DQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVj
dG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWlj
b25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUN
CkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRl
cnMgYmxvY2sgfn4NCg==
