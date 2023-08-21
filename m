Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785878254B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjHUIVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHUIVC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 04:21:02 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5598;
        Mon, 21 Aug 2023 01:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4SFFL9QV5TlMCKZHiMbMFGf771VceQ6aGD1SskUTyqOyb18AV25pQphQKoC9kq3aBYzPgOtB9yrkqMV4Mm2XV28a7NUcv7n2nEsduk+xlfcBH4/Qg4HOdEE8GF2ol3vSaRt0K2h76RJBY3ikwfJVrKjjgzzNbctnRCTpq/ckrETcB3kVoJvdacgMNKWk+CCNufZ9kO//ydBrBkDJfvP0G7m6OoH5BgSN18uNACXUDMCVHHGouTUfGDuLSM+OuQG3rNXlMnIRIZ1Q98YQ1S3vUdNr/GmXutEHpGzMsgr/i7Kdy5wITIc02UX/dR8rHX9FSuet5Lkiz6zYJRR8jIUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFVLOsclPwKWsNMAEJtzaHDabgjbJLR5Q/INPAn7lI4=;
 b=d6+OAJJgRgcMXpJRIAfabZe9bzOjPVpeHV9YRROW5Vghdh3Dvkxyo7JpQqhvuOKc+9kf0I64i5xRTc2iknQbkqF21VxRW4CF2HgGJDnizhxZCWer3uU7d8TfdhWU4kY+EFV1v1mS/qTkDgZqX2JBmHFYMLeo5HN1ZbNlAfV0Mfy//QmAYb0wAaSFCYd0Ih51x3xaEO695tc6SXDlM+wWhXV9PuKkE/sezZVXRAyCaUsNCnhzaYvg08suXclgQ8TmhMuOb0+LBe/VadsJR/GpvSsIQptAv8C+XuUDBhDTKfFhOr7JH/zQBWQubipYol91jq6zskPbOok2M3MBLg14lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFVLOsclPwKWsNMAEJtzaHDabgjbJLR5Q/INPAn7lI4=;
 b=jD3wnVidZ/kJcPACrgFgI2kmSlPHriZGXUA8hXgpDBnA3v2JyltyGMVXFf9/V3sHuSdJxU1LIvFT2ewXFdabxK4wFThdYMuU0XUDyvOIzdlF6ohePeSqCgdNyUT86DaYc9KwlKB1uJ2FsCwICqxX2sL1p0qpXy+Zh43POZ4TdZ4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6000.jpnprd01.prod.outlook.com (2603:1096:400:49::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 08:20:55 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 08:20:55 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/2 RESEND] power: supply: sbs-battery: Convert
 enum->pointer for data in the match tables
Thread-Topic: [PATCH 2/2 RESEND] power: supply: sbs-battery: Convert
 enum->pointer for data in the match tables
Thread-Index: AQHZ04ltYuj/bpql5UK8hcBWG/7wVK/0ZmCAgAAA03A=
Date:   Mon, 21 Aug 2023 08:20:55 +0000
Message-ID: <OS0PR01MB5922A59E515D4355366294CD861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
 <20230820171145.82662-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdX_5XtmUt_LBCHbbjS+Ds5j7KrPTtOLVYrHTw4Hipsu9A@mail.gmail.com>
In-Reply-To: <CAMuHMdX_5XtmUt_LBCHbbjS+Ds5j7KrPTtOLVYrHTw4Hipsu9A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6000:EE_
x-ms-office365-filtering-correlation-id: 9642789f-3df3-4e3d-7820-08dba21f8a67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QD95gs9UFssXFIAHWokcqhoduQGc7u0gHE+mSCGIEyGq5H9W3w2TFL5lFohqQpEzMNZhB7eVrIA616FOGVTEQdwRvVaI1zXSFyjP6nki3IrEbVdjZNMdWzybD7Ot3DpELOAlZ9buokeV+jiFplfQqvOFZRRQW241AazGmQQpBlUMRyJlCgZZJa4nYuOl6irHMBAxwmUsTZkL0LTJtN0N188HnB7x6nxjmScLiFqsFL/MX6K/rNBqr4KKcDFQLUgzJUMs2/hZhZDYMnVBKpFZc85TTCmZjAYQuiahH2ENIbvASxtHJavGAmH/UALy6YqlCV0EWVfBBU1czuvGk4q44RR7slE7pHPBrjfI42V4+lG0NHURIA7s/AyFoRzdH4bPu8b1RMezfuiYdI1+PlNS0SgTbBKH4lcOPLp2vAEfwgs7sqpxK8QMeDApWMm202nPm55cmpb1d4nlvA+TuijGQ739ugyBitsd4gARd0o+TfNMKIfyt7JGS85VyPFWkPBnpLqQ4oDmRFfHp3qmEQDuBJrL/aNkQiSlww4aFet7ogIvN4wIOLq05wIHNAND/RUy8bUHma3UgEIop4XhnnNYqYcEVnOusuMho1LkFtcn+zPknH44GnFVZxuuRYSlAZKp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(1800799009)(186009)(451199024)(71200400001)(38100700002)(6506007)(7696005)(122000001)(38070700005)(53546011)(9686003)(55016003)(26005)(33656002)(41300700001)(66556008)(2906002)(6916009)(66946007)(316002)(54906003)(66446008)(66476007)(86362001)(76116006)(5660300002)(64756008)(8676002)(52536014)(478600001)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rzg5Q1ovNjZvVjVlTHAyUWw2QVN4cUtIbTBlK25ucnpVTjArOHp3d0FWSnA3?=
 =?utf-8?B?NWJURkhSYys1WVZzQXdGS2pMQWVDYTJ4STlZYmRuaUsxcUlsRFhDbFJ1UTBS?=
 =?utf-8?B?SVNCNFZLU3NSSUN5VGNzVTBTQjczR2UrOXBsbkdmREZnUzJFSXYveHl5VFBh?=
 =?utf-8?B?bWhsNkJhMElIeGZubkc1N29qSkFLQTBEeWtFM3daMjNTUWtWeTkvOXplQnZo?=
 =?utf-8?B?RjhzRnNvUWJCbzh2Q2pMSFFJODRBVnRod1o2UjFXR1ZjenJuRFdLOHBscE1K?=
 =?utf-8?B?SmlYTEYzVzlQM1I3NWNVWWd1TllLOWdKS1poMDdBMUVVSXNrSGhMSnBIS0N6?=
 =?utf-8?B?ODRtVGlQS21raHRzQWJ3enJzbWp6ZkxmWWhxdmo5TXR0THkyeXJyN2h1Z3pM?=
 =?utf-8?B?aGJVcmsxVlc2bWs2Uk5LWWNDNUlpcXhjRHhBZTVPWUE3bVhFK3ZIOC9kYjEx?=
 =?utf-8?B?YlAwbzBlbkVkNWY1RG5BS3NFYjZWSlpsdEYzMDJOVG9jTSt0OHFxaWsvU05J?=
 =?utf-8?B?bDNSVzlHMjQyazBDUzdMQmMrN0JUTm9GVWh6Y21TUXFHUjZOYkZ1QnZKcFJY?=
 =?utf-8?B?TFBSQmlqL0R6ejNrNXZOSW9GNG81YkJta0dwNzhuZmRadENwZFFsdWJNbzI1?=
 =?utf-8?B?cFpyVlNYSTcwOTBKaHFzcSs3S1NWVVdIZlY5MjJoZTJEQUEvem1hTGNveFBI?=
 =?utf-8?B?NE11cWZoNFFnZ1oyOE5GckNKV1JsNmVFbmx0NXZnN29rUXpMdFhUZ3VZdU1N?=
 =?utf-8?B?UVRUM2wra2o1VmpiY2tpemwwWEdhRjlESG95R0doc2owejF2aWZ3VVh3aWFx?=
 =?utf-8?B?QldoOTNIVkpubHU3a2psRk5rdzB3YXRYU2h5amhmbmUvUDZuVndzMFRyeklD?=
 =?utf-8?B?NWcyVVRYQUxxd0VYMS8xUGxmcXN2S05CWmZkWGs1WXJzSjRyUnVZQTF2c3NW?=
 =?utf-8?B?ZnB3OHVqSGcra3VsRFVza294L0xiSnROOEZUbklzOUo0eDVzNWxKTWhZMy9t?=
 =?utf-8?B?TlY2U2hqQ1pYYUQzaUdPMVBZL2JOOU45Y085eUE4cGRuWmVFQUFPbGxoRUlY?=
 =?utf-8?B?NnltbWVaWXRJWFVzOEJjaXdEZmxvd2FVY0tEb3VNMGxYcnU0NTNjV0NXWi9w?=
 =?utf-8?B?bnpVUWxBbmYrRXJxbm1IMUw5NmtTa21POTlUM21HOGJyYnprajZ4c3JoamFq?=
 =?utf-8?B?MlZlMXg5cjJ6dTBOZkU2UG1zVURjNVk3NkdKRWxzclQxa1JpaHRCSS8zWXZk?=
 =?utf-8?B?Q0g5VktJZlVxSWhQaklXWG05ejA3dyt3KzhxYlBCVzRlbGNSa0ZOTmtneTdv?=
 =?utf-8?B?dVJyQnB1NnhhZXJLa2ExSy92cUVzOHVBMFBuZWRqcWZ3czFZRVdoOTA0WWNk?=
 =?utf-8?B?ejh2VFhUZzBOOC9FK1cvc05DWC9NMzBzSVpZTi9GMUE0M0VibUZ0Rzcya09m?=
 =?utf-8?B?QUJmVHBNeUprb3FuYzNrdGwwL25GeVJlYzNXSzU4SURYRHlZYU1nVnpTM2M1?=
 =?utf-8?B?cDFiR1p0aitCdzAwRWRuN2tpeVpWSEV0LzFtYUNnTEZDTGFnVnZMaUpZK01R?=
 =?utf-8?B?TUVVeXNxNGNoWUp4VTlpNituRGZYMWROdzlOQzZuSm5CQ2t1K0pxUmNSQVJN?=
 =?utf-8?B?R0pUOGREbE1vZmFzTnFFVTQ2dGtXWEYrNU9CaXNDbUlWMi9YaDkweWpvbXJi?=
 =?utf-8?B?VlJSb0pIQmJhdGVzZFBNMEcxZ2xod3RHMFlTKzJOeUdVdEZKQm5xMjBkVGVm?=
 =?utf-8?B?UE9SVW5KdjVkd0FxcytLTnVRUFdFdktRRHN1N2I0Y2xpWnMyVzJ3WmlGT3ZH?=
 =?utf-8?B?QXdZb2s0RHJ1U3pBdVU3cEw5WDdlTW1KdjBJRzB5dG13ek93OVJCUHJIWlpQ?=
 =?utf-8?B?TkRQZFh4ZXV0Y2t0b0c2UllEWHBQeHVSQXoxUW9Sc1Z0SUlWY2tZaTR5bDVF?=
 =?utf-8?B?YnJqMlVmVnVhWTM1VWN1R2plTGpvc3hrTkF6ZXhMWUl6c0xqalpwdCtoOERm?=
 =?utf-8?B?Qk1Vemc4SGxoZEtSOUp0anhGdUM4eXYxUkFaQkltT1MxQ3dOQS9jY0VFUHJQ?=
 =?utf-8?B?UTRyN3p5YnhwNFE0ZFZmUVNQT3JtM1A1dGRQUjAxbmNkWURndzVGTVJ2M3RS?=
 =?utf-8?B?T25KSXhGR2d1MXBYUHMvNVdlK05lbTNqZHFncUlxTGI3dUVjdmhrYXQzbWdJ?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9642789f-3df3-4e3d-7820-08dba21f8a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 08:20:55.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKtDV/9TNGy/PZYvnoKTSQVpUhTDszaxvxA9nJn+2yk0Eoyyw5/0ll56v+FnAlaNcGshkII0svsWooJggOWTPRtlAXWNHWblS7ptBxJT/7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6000
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDIvMiBSRVNFTkRdIHBvd2VyOiBzdXBwbHk6IHNicy1iYXR0ZXJ5
OiBDb252ZXJ0IGVudW0tDQo+ID5wb2ludGVyIGZvciBkYXRhIGluIHRoZSBtYXRjaCB0YWJsZXMN
Cj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBTdW4sIEF1ZyAyMCwgMjAyMyBhdCA3OjEy4oCvUE0g
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiBDb252
ZXJ0IGVudW0tPnBvaW50ZXIgZm9yIGRhdGEgaW4gdGhlIG1hdGNoIHRhYmxlcywgc28gdGhhdA0K
PiA+IGRldmljZV9nZXRfbWF0Y2hfZGF0YSgpIGNhbiBkbyBtYXRjaCBhZ2FpbnN0IE9GL0FDUEkv
STJDIHRhYmxlcywgb25jZQ0KPiA+IGkyYyBidXMgdHlwZSBtYXRjaCBzdXBwb3J0IGFkZGVkIHRv
IGl0IGFuZCBpdCByZXR1cm5zIE5VTEwgZm9yIG5vbi1tYXRjaC4NCj4gPg0KPiA+IFRoZXJlZm9y
ZSBpdCBpcyBiZXR0ZXIgdG8gY29udmVydCBlbnVtLT5wb2ludGVyIGZvciBkYXRhIG1hdGNoIGFu
ZA0KPiA+IGV4dGVuZCBtYXRjaCBzdXBwb3J0IGZvciBib3RoIElEIGFuZCBPRiB0YWJsZXMgdXNp
bmcNCj4gPiBpMmNfZ2V0X21hdGNoX2RhdGEoKSBieSBhZGRpbmcgc3RydWN0IHNic19kYXRhIHdp
dGggZmxhZ3MgdmFyaWFibGUgYW5kDQo+ID4gcmVwbGFjaW5nIGZsYWdzLT5kYXRhIGluIHN0cnVj
dCBzYnNfaW5mby4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4g
LS0tIGEvZHJpdmVycy9wb3dlci9zdXBwbHkvc2JzLWJhdHRlcnkuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcG93ZXIvc3VwcGx5L3Nicy1iYXR0ZXJ5LmMNCj4gPiBAQCAtMjAxLDYgKzIwMSwxMCBAQCBz
dGF0aWMgY29uc3QgZW51bSBwb3dlcl9zdXBwbHlfcHJvcGVydHkNCj4gPiBzdHJpbmdfcHJvcGVy
dGllc1tdID0gew0KPiA+DQo+ID4gICNkZWZpbmUgTlJfU1RSSU5HX0JVRkZFUlMgICAgICBBUlJB
WV9TSVpFKHN0cmluZ19wcm9wZXJ0aWVzKQ0KPiA+DQo+ID4gK3N0cnVjdCBzYnNfZGF0YSB7DQo+
ID4gKyAgICAgICB1MzIgZmxhZ3M7DQo+ID4gK307DQo+IA0KPiBVbmxlc3MgeW91IHBsYW4gdG8g
YWRkIG1vcmUgbWVtYmVycyB0byBzdHJ1Y3Qgc2JzX2RhdGEsIEkgc2VlIG5vIHBvaW50IGluDQo+
IHRoaXMgcGF0Y2g6IGl0IG9ubHkgaW5jcmVhc2VzIGtlcm5lbCBzaXplLg0KPiANCj4gVGhlIHZh
cmlvdXMgImRhdGEiIG1lbWJlcnMgaW4gPGZvbz5faWQgc3RydWN0dXJlcyBhcmUgaW50ZW5kZWQg
dG8gY29udGFpbg0KPiBlaXRoZXIgYSBwb2ludGVyIG9yIGEgc2luZ2xlIGludGVncmFsIHZhbHVl
Lg0KDQpUaGUgbWF0Y2ggZGF0YSB2YWx1ZSBmb3Igc2JzX2JhdHRlcnkgaXMgMC4gSGVyZSB0aGUg
QVBJIHJldHVybnMNCk5VTEwgZm9yIGEgbm9uLW1hdGNoLiBUaGF0IGlzIHRoZSByZWFzb24gaXQg
aXMgY29udmVydGVkIHRvIHBvaW50ZXIuDQoNClNvLCB3ZSBjYW5ub3QgZGlmZmVyZW50aWF0ZSBh
Y3R1YWwgbWF0Y2hlZCBkYXRhIGFuZCBlcnJvciBpbiB0aGlzIGNhc2UuDQoNCk5vdCBzdXJlLCBj
YXNlcyBsaWtlIHRoaXMgdG8gYmUgc3BsaXQgaW50byBpbmRpdmlkdWFsIG1hdGNoZXMgbGlrZQ0K
b2ZfZGV2aWNlX2dldF9tYXRjaCgpLCBhY3BpX21hdGNoIGFuZCBJRCBsb29rIHVwIGluc3RlYWQg
c28gdGhhdCBtYWpvcml0eSBvZiB0aGUgZHJpdmVycyB1c2luZyB1bmlmb3JtIE9GL0FDUEkvSUQg
dGFibGVzIGFuZCBwb2ludGVycy9lbnVtcyB3aXRoIE5vTiB6ZXJvIGFyZSBnZXR0aW5nIGJlbmVm
aXR0ZWQgZnJvbSBwcm9wb3NlZCBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoKT8/DQoNCkNoZWVycywN
CkJpanUNCg==
