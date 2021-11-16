Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17829452A70
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 07:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhKPGYL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 01:24:11 -0500
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:2176
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230385AbhKPGYH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Nov 2021 01:24:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPmywwcEEjDNKnU7XSwB/PbtdprIOg9a4sQGahkP/cIZMFfZTexdtEKTZOCiuwW1wYIwXi2msT3ppv8+N5vbEp72M89EOkm43uYAk1dO2WCyPN2dTne/lx2Wjv8mbyLFktr7fe1Odo+5dsAwshFGaq3y+hpXIBq1LB/B05mDBSBHGeg049kQicU2xbSpWhZQNJRzeNfZgUx2HN6yz+YPdfKaI3a3QY12L9ISqrZ84snncuHYpQAyeyjhqIl0QRwr4BkfLqi1ndC20Vbq30iAdewMdn15Mzd5YLBzF3tRJP8r83Ie/gxMf3YKnKXTK0lvoWAdzmy72EkPbpbxQywouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6AzlE3orQ1vz1uH4BkFhF9l/yTKYUtv8LYElQ/o4gA=;
 b=HD+zz85Tewxv0o5MLYhAZWdRAdLPPhm6wbEAY9Ge5QgtSTMXPBFnkuPRW0vH60gtjosO+HEjdLNMeITwNoytkT7wGDF06AZyk1MbsHzDeADKDGASqSQT6MBcGOCBAkg5p+nEQyMdTtUAa+q0FeBSqTasgyvH/iHXNqpJKhg1N6SpfsQqtRlL7wG/gAp/NthKxAFXZn02QIwLLJMYm4l6NVhSj4tWjDmHn3zC7KOlCp+rRVEC0AZSp7xIlntHRr72RCwRXPvrpD9/g60tpWaIhvb08j/tK8G6LC9fnnv37g+SUGqvbZ7cdpAbZV4XpESReIc3XLe93QtiR5bhfS7xRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6AzlE3orQ1vz1uH4BkFhF9l/yTKYUtv8LYElQ/o4gA=;
 b=VOSOGkNZGsNAwufbi0q5hXSIPzo/RCrZTpNfsEYLaI+Igg9/ZNEJ/h/e9UzHHVYrk4TDdhHB21jlvTwn/SGPgLa9H8GjuKCmACrG1mdHHzdG1QCRZdb87UoSkZwDvK2wIm4gauXJd9u3l+SWwi9TidcCtfPGLPjXA5TLdKIP5/A=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2329.eurprd03.prod.outlook.com (2603:10a6:3:67::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Tue, 16 Nov 2021 06:21:07 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60%5]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 06:21:07 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] power: supply: core: Add kerneldoc to battery struct
Thread-Topic: [PATCH v3] power: supply: core: Add kerneldoc to battery struct
Thread-Index: AQHX2n+y2iIKcdsoDEGLqcFn5J628KwFr0iA
Date:   Tue, 16 Nov 2021 06:21:07 +0000
Message-ID: <bbaa93fe-8a10-7c80-2b5d-c36b0968429f@fi.rohmeurope.com>
References: <20211116001755.2132036-1-linus.walleij@linaro.org>
In-Reply-To: <20211116001755.2132036-1-linus.walleij@linaro.org>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f4130a6-7e22-498c-86f0-08d9a8c9468f
x-ms-traffictypediagnostic: HE1PR0301MB2329:
x-microsoft-antispam-prvs: <HE1PR0301MB23292762AD0CC619E51D4A0AAD999@HE1PR0301MB2329.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZpJ5MCi9hR+sSUObnRUqjc0peJi7TBWQehsjeCJYn1qzHVg06GmgzT/k1VVonXcZ2Lz7YCboff9sS/7NNY3j2NGvzS0uctg8KnK+ENZINDW8aTRhi0+TS5Rt2n24lkQnnGiNoPa9gnoGbjgClz+zrEaH+mqTsEb/aVDb8PZcbKqwsEx5XWz45ad+U/BDg7k+ogIk6e97uyO01cwOfTe+w5bnoPXM/Ic5jZ2m+Tq+v3QhFqKsb9DfXDTbSeE7D4F7j3B8A+pd9KI/L7bHX0rwqp4bSSdcOSotF1X9KsrkWO8NddK8V+oBawp0k4lelinBsCr6Ek2vI0e+j0K2f65lAKGD8rfNs+eXLFVts8pUUoGpknlul/cp87G/rMVfnCKpcI58YaI+hdUuwiSWCjmoZ7BG9ViS/py9HvFA1M0GH0WSgZx8wLkG1eGO32179LkExlt5jL2ZdTkPcdTaFhCFsM2/NAYFTtYHom5RkMnMXqjO6n4DRf0tEMoJRnFxv8RzppY3toUklTnmLMkR+D2eQfO4StpKYk4EbqAwxcDwpC47zZVvhXgDzXpI7KWtrSX5u7XqCvztAj+9kiRZkHb53Pr6ZEgRkUKeL/xTuMmPuHljYCNbJLPF9j7SJPNFlFT/PrfEeXF34xN+QhXOn7nvn10QyeJsas3XYXYVoPQ95j8Iz0UgjEWjNRkUV/BdOaqnm2V1Mw/DeMtIPq8jTQ1Rhyc6FndeRbYrxkFGg5S+CBM8PuOt1gn2NU9fqMh5Y/DfDfsr1D/q+zAUU4mGgWOQeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66556008)(508600001)(2906002)(66946007)(8936002)(31696002)(186003)(4326008)(6486002)(38070700005)(66476007)(66446008)(110136005)(316002)(64756008)(6506007)(71200400001)(2616005)(122000001)(31686004)(6512007)(8676002)(86362001)(38100700002)(83380400001)(5660300002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNaRlRsOWhVS2JyVHJPbVpKMUpHWDZhcnJVNEk4M1M2UWs2SzNEb0xVYWY5?=
 =?utf-8?B?U2RYWHNpZzcxNjdIZDJSVWl2dUVreHZGZ1RmL210TEI2UG9ESkhJUXRZK2xZ?=
 =?utf-8?B?ZGhKL1UyaENITXdsTVphdHhGZ0Fmb0JQODhxY2dEVXBPcUlBTFhnUHF3VWxP?=
 =?utf-8?B?ZFFyYitsaUtYbFlOallXbWMxVXZwOGI2SmJtU1lRQWNTNVZ6bXl0VVZJR2xl?=
 =?utf-8?B?ZVFrb1Q1TmsyM1JOTUkycTZGb1RGcnpTMGtUWHNrNlZ6dGV0SklLaFB0NnNV?=
 =?utf-8?B?RWozeXVxVWdYVXFTVUZUNVdaRTUvdFpKQmpMRSttNHBZTHpYem5VK0UxYm44?=
 =?utf-8?B?bC9oVHlWL2lXNUtta002Rm1rM1ZOZm9maFNxMkIzSjRORjVXS0lFYk5JK0s2?=
 =?utf-8?B?RlpCUmRjQ0UyRDlQc1p5WDl5TlhvOGdFL3hoT3pKWWJzYzZpOEFSUTJRajBS?=
 =?utf-8?B?MHk1SFNiTDNacTMwRENKK3NnZjRMaVpGWnZDeUxob29rcTc4TzJaTmtmdkk5?=
 =?utf-8?B?ZGZuVG5vMlpoc2RRSDJFZWFJMkUwbE00aGh6Y3RaQXF6YWlyZXpHb2ZLd3Fu?=
 =?utf-8?B?UjNKTFgzOWpVK3VOZDdNbkFFY2gxcE53WmxlQ2NBSUYwNkI3c3MvOUE3RXZK?=
 =?utf-8?B?QVF5S2g0MmtTcDN5cnVyUzlHMU10ZUtsZXh0MDVRblY5bnFBUDBkeGVsRExt?=
 =?utf-8?B?dllYOFpBeWFnRWNJY25Ra0FDRnE1Ykk1ZDNVRHMwa0xha0FjTTZReit2Witk?=
 =?utf-8?B?UzEwcEVKamlyc2w4QnJuODRzdFZwQWpsbHJORkpuNktiejEwaW9GVEN4NFU1?=
 =?utf-8?B?NThRRDlmMnRzU3FENEU2bWJJRzI1U3dRT2N6L3BKTXRsYUhGSkI2cTNIUVNL?=
 =?utf-8?B?WjkzWjZrTXBFYW1hcEh6c1ZWRGEvdXc4RFRWN3RtbU13SEE0SW1RLzlBakRt?=
 =?utf-8?B?S3lQNzErY2JZaWp1Y2NmOXVwTjkydWFBVnNKYmNEVWpkWmdRWTc5M1FmSnFm?=
 =?utf-8?B?WGNSVllJQkR5ZkkxUW9xckIxRm44K3RiTWl5Y0s2KzJGeFpaZlM1SlVabEJs?=
 =?utf-8?B?MnlyRG5mZnJCTjRpUy9kQzJDM1ZTejZuUCtTQlFsejVlK0FmVGMyZnBQdTV6?=
 =?utf-8?B?UXN5aGNlVVdyMTA3MmxZL21IZmEySmdyenVXblhkd3ZQZGxQMDR0YjFUUlBt?=
 =?utf-8?B?VGJxRnIyUEV0R1FsaVkzdGR4Vit0UlJHWVJJeXhXd0tUQ2I5Y090dVVzVDlW?=
 =?utf-8?B?RW5samE4WTU5ZWRVWmVFT1RtbHcyb0ZwYjhNbG02MjZSWFlpUVdlazZYcnNw?=
 =?utf-8?B?a3YvTEcvdW12Q0lqUEQzaVN0ZVEveERvc2pTSGJnMTFPQ3NYM05jN1ByRXJL?=
 =?utf-8?B?OGZQR3JBZ21DUmY0REVYRStXTzduNUMzWFNvTlhKVk1ZUGU1TG5nd00xZUdN?=
 =?utf-8?B?d0tTRXB5aDYyOHlSYWNHdk85ZlNnM2RJNWlGRXdFWktGYlUxMEs2aEoraE5W?=
 =?utf-8?B?MGhObVlSbkJ2Tyt0aWtLQ2licThKU2MyUlZKU2xveThXU3dDb0VDMHJJbUho?=
 =?utf-8?B?QzNxS1ZIZUJrTnhvYXQvZVJGYWUxUERnZWhScE5USEpwa21yWVAxWmVMUXZv?=
 =?utf-8?B?dnBQL2lsVi96MHlZUlNKOE9HVWRkdXE3OXQ1L1FUc1FSMHptRUVxY1B1M2t6?=
 =?utf-8?B?OFJpL1FydFhjQ1RMSTlZWXl1TTJzN0dJWmRvS1pJZEthOHRtQ29GaHVTbm52?=
 =?utf-8?B?OTNoRnd4eGh3UlM3Z2ZXZXh4WCsxUGtCT00zSk5mVi9hbzlLU2UyVGw0YWpV?=
 =?utf-8?B?dVhuSi9MVi95V0s0WUUwN3hzeXBvTWVBQzlPZ1ZVa0FjWEpuMk5WSk9xSGtD?=
 =?utf-8?B?YUNOUktJQVNlVUs4TE1Obm1yRGszYkRBM2NsU3VtejNrRWlrT0doSjBITTJ5?=
 =?utf-8?B?M0lmTlVhdWsrYlQ5MU15b2JURFNCMTEzQ2N6Wk05Tzl4VGQ1U3pIbHBwTWps?=
 =?utf-8?B?ZmtSTlV5SWZJZnZ1cUplQURSS1ZSVjNqZmJOYkdsell2L2lWWkNEd1N0aFVP?=
 =?utf-8?B?dEcvMDlHLzBEcy9SQ084dXdZeFlzL3hKd0ZFVTlBZWZ2YTF3MWVFVUVMa2pO?=
 =?utf-8?B?RCtvNzZxNHBwa0lMZUUzeGlMWlpqVk9RSjJFQ0ZXZGVXeXRnZXZ2YjI4SW9X?=
 =?utf-8?B?NDlybEQrWWJ3VmloQ3R6MU5UbWQzWlB0Q3NBWWtWUE1oVVh3VnhFcUhNVmNu?=
 =?utf-8?B?dm5ZY1JuRDNJY0UyN1NvbXB4clgxSm1RN3p0VHkrdFVybDFSVXJuaVdEWjl5?=
 =?utf-8?B?R0IzV2JqVm41NjFFQlB0MTRsUkE4OEJEZ0x0TUN4enFEcGlwc1dwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D52AC8FD80FD4F8775F42F66630E6E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4130a6-7e22-498c-86f0-08d9a8c9468f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 06:21:07.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNbRVP7p8r/fQ1yhjiPqQQGABEic/7GQeg2mgMGQNXG9sS/rDx2yD5XeLv9c0ez+doXIsTP0cKPHfyB46Bu6palZZdHz6gMPkgerxPb5f/gC1O5oHI6I3eFjzXWVxxIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2329
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgZGVlZWUgSG8gTGludXMsDQoNCk9uIDExLzE2LzIxIDAyOjE3LCBMaW51cyBXYWxsZWlqIHdy
b3RlOg0KPiBUaGlzIGNvbXBsZW1lbnRzIHRoZSBzdHJ1Y3QgcG93ZXJfc3VwcGx5X2JhdHRlcnlf
aW5mbyB3aXRoDQo+IGV4dGVuc2l2ZSBrZXJuZWxkb2MgZXhwbGFpbmluZyB0aGUgZGlmZmVyZW50
IHNlbWFudGljcyBvZiB0aGUNCj4gZmllbGRzLCBpbmNsdWRpbmcgYW4gb3ZlcnZpZXcgb2YgdGhl
IENDL0NWIGNoYXJnaW5nIGNvbmNlcHRzDQo+IGltcGxpY2l0IGluIHNvbWUgb2YgdGhlIHN0cnVj
dCBtZW1iZXJzLg0KPiANCj4gVGhpcyBpcyBkb25lIHRvIGZpcnN0IGVzdGFibGlzaCBzZW1hbnRp
Y3MgYmVmb3JlIEkgY2FuDQo+IGFkZCBtb3JlIGNoYXJnaW5nIG1ldGhvZHMgYnkgYnJlYWtpbmcg
b3V0IHRoZSBDQy9DViBwYXJhbWV0ZXJzDQo+IHRvIGl0cyBvd24gc3RydWN0Lg0KPiANCg0KSnVz
dCBhIHJlcXVlc3QuLi4gVGhpcyBzb3VuZHMgbGlrZSB5b3UncmUgaGF2aW5nIHNvbWUgYmlnZ2Vy
IGNoYW5nZXMgDQpjb21pbmcgaW4/IEFyZSB0aGUgY2hhbmdlcyB2aXNpYmxlIGFueXdoZXJlPw0K
DQpJJ2QgYmUgaW50ZXJlc3RlZCBpbiBzZWVpbmcgd2hhdCB5b3UncmUgcGxhbm5pbmcgOikgSSd2
ZSBoYWQgYSANCmZ1ZWwtZ2F1Z2UgUkZDIHNlcmllcyBzaXR0aW5nIGluIG15IG93biBnaXQgKGZv
ciBhIGxvbmcgdGltZSkgd2FpdGluZyANCmZvciBtZSB0byBnZXQgaXQgbW9yZSBleHRlbnNpdmVs
eSB0ZXN0ZWQgKGFuZCB3YWl0aW5nIGZvciBtZSB0byBsZWFybiANCmhvdyB0aGluZ3MgYXJlIGhh
bmRsZWQgaW4gdXNlci1zcGFjZS4gRnVubnkgdGhhdCB3YWl0aW5nIGhhcyBub3QgDQppbmNyZWFz
ZWQgbXkga25vd2xlZGdlIDpyb2xsZXllczopLg0KDQpJdCB3YXMganVzdCB5ZXN0ZXJkYXkgSSBk
dWcgaXQgdXAgYW5kIHJlYmFzZWQgaXQgb250byA1LjE2LXJjMSBmb3IgYSANCnJlLXNwaW4uIEkn
ZCBsaWtlIHRvIHNlZSBob3cgaXQgZml0cyBpbnRvIHdoYXQgeW91IGhhdmUgb24gbWluZCA6KSBJ
IA0KbWlnaHQgZ2l2ZSBteSBzaW1wbGUtZ2F1Z2Ugc2VyaWVzIGEgZ28gYXMgUkZDdjMgbGF0ZXIg
dG9kYXkuDQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0K
