Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006165886AA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Aug 2022 06:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiHCEy3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Aug 2022 00:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEy2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2022 00:54:28 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2117.outbound.protection.outlook.com [40.107.127.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF357254
        for <linux-pm@vger.kernel.org>; Tue,  2 Aug 2022 21:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWtM9vLPI4P35laDRWLwSDxr8wxwRA7QBxRobE7Xemn5WWPRBLq7p4TwVb0jwBjPiCotgforIM/BGohjXhgiC5sfuq3FdkIJtt3rvOStJQI3EewzAbG0I4j8uGNpZzCHD1C2QH/lThRRcj0tsz5n34sg5M+NlvsehMwwmqAhdFkMH4mp82rZGBgoaPJ8PIyd1a4S/ASyO2O3cLANF3tYd77dvFZfTxb7ucvdRSvwhFj0eHbcaPMjiUXoLHCYd1R8xVvNTocjpa3v2WCft30CQkqQ4y4sx8ur2RqcelEw8Ef/hLvsmvPpJdX/LM3u2gSVUumPJEpEeT3PgH1yVb/nCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYdFsIULigoKBAcoRaccj4DlGnH2F5TEXN5/p07APa4=;
 b=Oxef/k5JyFOTBDs4XX60dCG2pmeOM/iP6mDeZwkpIkvE/vhKi/eqcnhHuhjt47qq/Pf93dE327cejjxv12LduUNW7lFmbYZonlUHLgtNQlY2BjoPWwOib2//0K1DYCOtq5Kw9Kd8MU5aoh3XnsVZjIGJzse1e8QV5NSdMpRztTRVwmKHZvAvJTz1IkTrwmhpRV1JqRkWWfse0dJhMhGmT+0KXYdgc3hhwYJdRl/WA6u37HxXp9SeY+FcsyWmzpkYk1imp4kNxicZAZjsJ8xg52Wq27wa0K3Y/SKZ4GzJYLmiFJW4PIQiZjd9vxVCqAB5seraY6MFiZ2dihrKN2CIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYdFsIULigoKBAcoRaccj4DlGnH2F5TEXN5/p07APa4=;
 b=wk2z+jfBHyRWMxd9Tq99/jc4CGuKyqnDxhSgtILmZj8cBZtwSEMiwd0xI97T0jJhonqs7xXKjhqE8Cw95jkLEnjvO1v5fiuARkbfsOapcu/0hcVCLJsIEdYDupIula49vwBYJKlJNp7OpX2QMwb2CcNlpjqKXLKfi8eoPgWvL+E=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BE1P281MB3096.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:61::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.4; Wed, 3 Aug
 2022 04:54:19 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2812:f9e5:c7e5:166e]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2812:f9e5:c7e5:166e%9]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 04:54:19 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: supply: Explain maintenance charging
Thread-Topic: [PATCH] power: supply: Explain maintenance charging
Thread-Index: AQHYm2TMGQUcuk1EEkKlBri25K1tda2cs2MA
Date:   Wed, 3 Aug 2022 04:54:19 +0000
Message-ID: <2f548d19-8899-561f-a93b-25f40241b640@fi.rohmeurope.com>
References: <20220719114131.62470-1-linus.walleij@linaro.org>
In-Reply-To: <20220719114131.62470-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ab9520b-3df4-4d79-ea11-08da750c39a9
x-ms-traffictypediagnostic: BE1P281MB3096:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3qDPLAPIWUlpo3Cuek2MpBUvaBTXrXGeDoyW1PXtvRDMXpvt4u41qYoX0mCKBVu93rb+PbhQ4XYbzZtvMmOLBXSbLwQlEHQbyr1SRqXwIEqEblHjSvQQiFXcWt2C2co1sbIkZAqdDcCnU+M1fhEKkV4L8jHLovU/FXNV5z9gc0iJMZgPJvq4CNgou5nA+TEVApDd2Tub3cMOMBE0ftH8QUHfcLlh5vR7Il5wW7TfizvdzpwSY+V/GMyBwWN+LRwU/T/trsdPwzPI4zI7LNkcR0zRm/TZzC3gxigYoQcBHXScyHdH+NHdUqX09QCBe3t273TFWISwP7ipXgVAf4TACZj7ImcZLEACUGTZkxQce0qojbNHYzMhAtgw2zhJ8Voj8MYkmEvhWGCkq/SIEHN0dS895x9xzqNs8kc3fmSISI20pe9SJEBn/dGKjI26ZLD1ZhzLGd8gGY56+ZxV3M63AvMWbX6YgRCc7Q1ybVtJ/ZnKrmiNomhWMPjb7z5AWhSVqUE5VgfIsZNaPWD2Qu1HtaUIX9HGTp94BIl0UOFpGRFN6wkNnandnzRGH8yt24NuwmMUyvfN41YlN2iZWGq6e65gaJIDFRTrRaOPiFYucHhrioWvXypT2+TwtVHh8l4bsbBw94PvBQ3vw0AuuCHUm2yAzY1W2wjxNTrgkw1fkareBHtqWkjGVPJbyRNOEXT7QfuwR3gqV6A2z6ROyu/n3wd3rkFb+hg5MxpMw84MrlUvtwz0L5xSa7zv863Ex4g1qnuw9QPOAzj3UWz3W2oDh0R/vFyd6/8lYLHYwc/1OOI4F+wCB/uQ7VBNuYOYpvtW+75j49X1rPlsrC1QjRtgTnwuLcDexMM0sukWJ950Bs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39850400004)(396003)(136003)(366004)(346002)(53546011)(31696002)(86362001)(6506007)(6512007)(41300700001)(110136005)(6486002)(71200400001)(478600001)(38070700005)(38100700002)(122000001)(316002)(186003)(2616005)(66446008)(66476007)(64756008)(83380400001)(8676002)(4744005)(91956017)(66556008)(66946007)(4326008)(31686004)(76116006)(5660300002)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUlZdXpQRjdod2x2QWlPY3pSczBvTXBSUmJvZlpXU2xxUkJKb0hpakppMUZR?=
 =?utf-8?B?MjNmNk0waUpvRXkzeTNJZ2d2bjc1OHNUZER3Z1djY3JjQ3RJbE1BTE1IK3ZS?=
 =?utf-8?B?UFJpTk05Z1FjWHJlenI1YUhOYjh3NGg2YkkxREcyWFNkYjYwemlDdXBYZnhG?=
 =?utf-8?B?eDRIZHZaa0NuSzlBeGlSVFllQkFGbDR5VTlFN1UzajVRWDQvWS9acEJWKzJC?=
 =?utf-8?B?U1VBeFdYd1QzdDg2S3BoTExHSUlIQlNHZHFoTWM3bEpsT0hUb1dBWXF6RkZq?=
 =?utf-8?B?c3pkeEpXRUsxVUI2Y05rSDZOOENZZ3B1ekVmakFZM3Z6V0p0bTdWTmFFV3Jh?=
 =?utf-8?B?TFZ6QlBqUjFtMDU2Ri9yMm13U0c2em1kOExGdTBvdWFXSXhnaTB0OGVVS1dS?=
 =?utf-8?B?M3lXR0pDUHIxcC9SVWVnMkpWM0VQazNmRFcwQ1plajQyRkN1SVdFT252MUla?=
 =?utf-8?B?K09ndlJINFNTYnNQNzk1RTBkTnlGa01pRHM4SUZ3dHhYTXl4bUZnSFREbk5K?=
 =?utf-8?B?TjRrVWU1alNmeldwVHI4SWtUdU14U3EycDF2YTFhSFF2ZFRGa2hKYmU2Yk1j?=
 =?utf-8?B?blAvOUJRWUVpUlFSNnBDV3haZVpzZU1qSUlKWUNJaGxqRkFuVkZWZ1N1Zy9o?=
 =?utf-8?B?Ulg0UTJIbk5yN2lVSW9LN21FM0FWbDB5ZFIwbGZiVXlsNHl5bjlCMzZhSmUy?=
 =?utf-8?B?dVdNYitLOEVrUkhUZE1lWEE4VHk1RUdqYUkrUVppNXhhb1I1L2VWdTVLVXdo?=
 =?utf-8?B?blZkemNkc1pxNUFScGZQeGFlVkY2QmtSVy9sUFdwQlVrRFVWSy9Hais5bm9P?=
 =?utf-8?B?d1NVN09oN0hZSmVuSVd6S3ZVcExFWGpGd3NnZVB1b3c5aTFES0RTVTFPSjZm?=
 =?utf-8?B?b0tmZ1JEaVVGMStOdHhDdjdIMURnNUhZYWF0ZXNQMWllZkEvOFppZzgwcndI?=
 =?utf-8?B?dldTV1F2NS9RMlZCYUpRT0ZmUWJkd3hacnNzd1lzbmJ5OGlTK21kbm81a2Vv?=
 =?utf-8?B?VDZIWnpzOFZTRTRBU0UvKzI4ck9kMkFleEVneDZhM25GeURMdkVQL0ZLOUVx?=
 =?utf-8?B?MUV3djhrR2RhcVBwcXVoN25lck1UQ240MkVoMmJjRXRhVWdTNHJ3cjZVdkxE?=
 =?utf-8?B?QjBjM24xWGw3TldSTTl1cmhHNm16WjBWNlRrRWxTdzRjcGRSdWVaTTE5YUZi?=
 =?utf-8?B?ME05SXRrRElvclY1bCs5TFFRcHpOR1J5R0I1bnZVTlFmM0kybEhZSllUdWtt?=
 =?utf-8?B?bVVwVjV1MHJCTHRUd0hoZzBUTWxJQzZMMDFoVmQyeWExa3RpUmJobWM0akVE?=
 =?utf-8?B?WHVrVDhOTmt0anFXRzA0V3I0NVhjZ3l4UVh2MFlRaEtvbzcvNURIK1ZKMzlN?=
 =?utf-8?B?dUhzR293ZTdXeEpleE4rN3MrVzRvRWZjQ1lKcy9CWHNTdWM2OUFrK21IeXlL?=
 =?utf-8?B?TCtIam5tcldYWDNKYjdTTENwNGx4UCtXMVZ1cEZMbWZEaWFValRxbHZLMkNn?=
 =?utf-8?B?OG50anZhK0Q1Q3IwUGVOM0owUFlaMzRvMUp6YWdQOEUwa0pFV1FwWDdqbDRt?=
 =?utf-8?B?d3RrZVlyTGE4U093M0ljOHE1NEk3TnpPa0lYOENPay9jUmdDWlBxemE5cFlo?=
 =?utf-8?B?Ym94YjJLV0VWeHFibThDdCtSbEV6RzA0THVCMFQ2Ukxvb0xyUW9vZDNoYVdS?=
 =?utf-8?B?MncxZHhlZWNqK1JLcTVOY0JKaUsvelFESlJPcFViWlVKRVdZcDQrbkhqR0xI?=
 =?utf-8?B?SS9ZN0RwbitJWGtWbkp4R1AyOUpNeGg5VEhpSzNLTUkxUzFFK3ptUXQ1c2Nr?=
 =?utf-8?B?UHRXbkg0Sk1TMjZEd3Fjd1dlQzJ3c2R2ZEw0NE9wejBRVGFSRWUyWDZCN29Q?=
 =?utf-8?B?N3lYWGt4ZlAvUnU4L3M5cnM2MFBkUHRkUVI2cWkxOG5LdTQvOVoxaGM0QTRG?=
 =?utf-8?B?bVlOd3F6Q1NlUEFST3l3RlRJNTg3aDFvSlVoRlRIZ0hyOUhqRlducllRUGRI?=
 =?utf-8?B?TDYzYTJ2MVRjVnBqRkNHS0dVa1BLSUhvV0h4OUhZZkxHUFlQUGVJT1ZyUkRM?=
 =?utf-8?B?ZmpWakRzdUxZTWxZNlhYMktnSzIvRXFEUXEwMjVMVnR2cVY1ZG5oZDhsbU5J?=
 =?utf-8?B?aGJ0NHZEcUZmKzVZSFJ2cGg0UFArUWhsYmVqQmJyRUhMUTVGallJYk5pZERv?=
 =?utf-8?Q?9tuzme0q7qtBgtigbBKrtVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B9F7BD38AD65C499F94D10E009D5F75@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab9520b-3df4-4d79-ea11-08da750c39a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 04:54:19.3527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ISYuYyeSasIxj69QgdHLLVtLQ/SHQSHicBYF21/UYssJQXit7Tq87A0479R2mC8CfXRF2g/CP3RIBCC/0QiyaC6sOa4iJWuJi8pNTFqkxIB78Ak/7L5xLeNI2z2VAGW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3096
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gNy8xOS8yMiAxNDo0MSwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gSW4gb3JkZXIgZm9yIGV2
ZXJ5b25lIHRvIHVuZGVyc3RhbmQgY2xlYXJseSB3aHkgd2Ugd2FudCB0byB1c2UNCj4gbWFpbnRl
bmFuY2UgY2hhcmdpbmcgZm9yIGJhdHRlcmllcywgZXhwYW5kIHRoZSBkZXNjcmlwdGlvbiB3aXRo
IHR3bw0KPiBkaWFncmFtcyBhbmQgc29tZSB0ZXh0Lg0KPiANCj4gQ2M6IE1hdHRpIFZhaXR0aW5l
ZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
TGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KDQpJIGd1ZXNzIEkgYW0g
aG9ycmlibHkgbGF0ZSB3aGVuIGNhdGNoaW5nIHVwIHdpdGggbXkgbWFpbGJveCBhZnRlciB0aGUg
DQpzdW1tZXIuLi4gV2VsbCwgSSBqdXN0IHdhbnRlZCB0byBzYXkgdGhhdCBJIGxvdmUgdGhpcyBw
YXRjaCENCg0KUmV2aWV3ZWQtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZp
LnJvaG1ldXJvcGUuY29tPg0KDQotLSANClRoZSBMaW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2Vt
aWNvbmR1Y3RvcnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9I
TSBTZW1pY29uZHVjdG9ycywgRmlubGFuZCBTV0RDDQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIy
MCBPVUxVDQpGSU5MQU5EDQoNCn5+IHRoaXMgeWVhciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVy
ZSB3cml0ZXJzIGJsb2NrIH5+DQo=
