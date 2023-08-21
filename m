Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3ED7825F8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjHUJCy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjHUJCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 05:02:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12884C1;
        Mon, 21 Aug 2023 02:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENWUWjn20e6/4QZD5nN+0yL6es507sO7bUAqAW7gnwhQS0SrC/gN2iHtyRQ2AO6icSkFGJKNLKXlcwNHHI6ALUfxWXoTpug1Vfk6Jl72Gsg8m7biSxRNn3+0zTe52bSS1z6M0pNExwNebmEDj+gdey48Ka0OEG1jx4QmUPNeSBKSYuG1KH2VISVfOUhSI/FU+bd45wMWNFqahTKZMnw+wAvjIaTuthjYnKCb5I/SQnRYdXZmleDOhgqSgjaML8srPzrDyisI7KEZR0K5I/4XGXBClwdT/fdg2m52Wo+RUS2iiQdtijeepKNRM8/sk05op1kvT50p1iZlJRu6Q+n2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC5RpoQ3UgftWO8Ai24rd0EfNFNmdP/aUH9LW0M1iSA=;
 b=lT9JdlsWezPfg5fNf/DcpafhIYoJzjKPPmnl0MvI1i7IVqz4taRVZ1r/M5MhiFTDRVcW2+x83qsef8AUxl0XZYvLfp+Lr5e74pmp0rfr15mf9WhwEI9SKMdTi18W4cQR6uL0IOYHlbdxBzLKiD6pQ045HemGeAnpbhspwf5K0GwFzqORwWd8VIu12yJc7AMiRfA06kQzxpLw/zTzdaQ2++etkK0/7lhLZDX1+7oTLyH25DUdd/WyNHTi72RncuRlQxH6gbrDLdY2M5ar9YYSRH36UGN1+q4cXINvf6ze2DuuVDTRwTXX1wV6EBFx39Twea4HToY87gxTaxQiaFc22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC5RpoQ3UgftWO8Ai24rd0EfNFNmdP/aUH9LW0M1iSA=;
 b=ZZe4FXs+sQS7WVw9REfouJVZNLw0uGGkQtGxpbfpazgfgjNlWWtxftcX2/WpsGNWglhsBNwO3ujlrzu47+YrTNVmQ6befwSSK1kCybYQZqY1VIbrvH/U7j8UXOVLhyce6hh9BgpzhC6RX5Y/950Vqe+xEDarFFHSSVRaSeeJNcM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10293.jpnprd01.prod.outlook.com (2603:1096:400:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:02:47 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 09:02:47 +0000
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
Thread-Index: AQHZ04ltYuj/bpql5UK8hcBWG/7wVK/0ZmCAgAAA03CAAAdDAIAAARiwgAAEQQCAAADa4A==
Date:   Mon, 21 Aug 2023 09:02:47 +0000
Message-ID: <OS0PR01MB5922BD56062EE5A02A6A3FD1861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
 <20230820171145.82662-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdX_5XtmUt_LBCHbbjS+Ds5j7KrPTtOLVYrHTw4Hipsu9A@mail.gmail.com>
 <OS0PR01MB5922A59E515D4355366294CD861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXJV+fJHWWCm8w19ryErKhHcpKbWvtoOjCn4p1NUse1sQ@mail.gmail.com>
 <OS0PR01MB5922A624EA3B52BA99877C07861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVNHJBeiU9vmpQoFjriWvWqjLLvpdoHRDxg-3f6b1CTyg@mail.gmail.com>
In-Reply-To: <CAMuHMdVNHJBeiU9vmpQoFjriWvWqjLLvpdoHRDxg-3f6b1CTyg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10293:EE_
x-ms-office365-filtering-correlation-id: 1c3479f1-597f-432f-0e7d-08dba22563c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xjo7BfSRmb8Mo6BakV7Mb1BD91VOhV1ExzAr7iJHwHuP1fDB4CVsHO998GIq5QzyOpXAAx0ZtbpjaG57SxXXv7QVgVvF0gpIcOPWkf4tn4V5CV7lru40aL9O5SzSBma8rcSdEyxwmKNw9moJ2O+5mZg3ACtpfLEpGdriJvM0kqFTDr1oTTwWNFTrRYqCIEJbP7L+diSKuLgcm7Hf8Pt1/MTHqxVG34btFmGqfZyVYDpjHTZbfF1lozKcM9xPytG1tqUs5iaFcmZvaxH6sDHcmG0h9bi27OSKPLAZK0ZKOSn6+6KTKRP/hSpI8Tw4OpiPA6FD/D+jiDsar98xoaPcpgiDr6mChxDA1WaaAZxK9g7L6eiBaH3NpkT23/J8Fble8NArDorkT19hu4hYvZGwMD8ZbDi8q6fpH19NaWwJaRQrTwtN5Hzd6rW8KPSm0aEHSPZkKaWo+SIp/v4Bu83mbXxWP1g9QvYqAenIuwGm5PoQ7sJ3Ef2rL/5+fQKcCSYlB95AQ8Bz+byOm0zKlzEAViyFMNellLNCZvwKM4lGf7P+0bgmrEHPSL18XR32nJO8h6n8yl1pI2DwfmUwjwlFRQcRlsxx3OAjSX9V3Tk5ke7ZAvMZOoK3OcgD6XfRHlek
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(53546011)(7696005)(38100700002)(38070700005)(6506007)(5660300002)(52536014)(33656002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(6916009)(54906003)(66446008)(66556008)(76116006)(66476007)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGpRc0xsRWVFQkNIZWNiQTAwdlBCQkc2Q3hKR0VZOGtrdnY2d05ocnpDejVv?=
 =?utf-8?B?S2trVzcrRnlVbWtDcGt3TnVpenI4c0hIVGFlMGp6NTFON0h4dXhmeDFKUWs0?=
 =?utf-8?B?VmkvYTNOMGYwQWc4TlpqT1Z6VlV3SnRpcE42ZEFyeS9XeDByN25ELy9BZVhB?=
 =?utf-8?B?dFBud1Z0dzRNeFVPd21mcTZWbi9SclVERkxqZWtBSUI5dEZnSkZNZS9rRXg5?=
 =?utf-8?B?bDlrTXQwZzh4Vjl4VGErZm15bFNYYjBLVElPbmtNalVqM09qQnNtSVFmb2Yx?=
 =?utf-8?B?NU90aFVYMlNSNVJuWmk0QkNBL1hBRzZIU3oyNUhiR1N4c1BIQlFlY1pQR2hj?=
 =?utf-8?B?cUhKNzEzb2I5Vm16amNhRWxFZHFmQzVQVHpQNXh3cVRSVjdoTDAwdHZBR3o3?=
 =?utf-8?B?WnhUczBEK3d3SGFselg4N1hxSFVjUnIzUW1PT1gxcW83eDN6a2FGWmVkb1hJ?=
 =?utf-8?B?Vll2YmhucWM0N3dXVkQzUzNrTXE4bDVoZ3JCUldsaU0xVHBmMjdidXRSekl5?=
 =?utf-8?B?djN6Mi85NlZMcTVoc25zaTJTM1JHTTR4a1VEU0J2MU84cWdkQnVYVVVnbW1Z?=
 =?utf-8?B?QzB6bzM2NlgzR0QyY2ZDK0E4c3pHY3RXKzJsaHpyeHpxQWhMN0l6RVdDbE56?=
 =?utf-8?B?RytpOXdvYVhOa2JpNFlEaEN4Tk5uaksyWDVtYko3WVc4S0VHbHU2blJYZWVt?=
 =?utf-8?B?YUFLMXVEejR2dWZwZHZSYW1INUxTYjVXZDVCTXhEQzFXNGJHbCt6dWgzQisz?=
 =?utf-8?B?L0hqZ2NhVkhVTTVNZ1hjZnZDUFZuTWdsRzJJWFYycUlEazZNa3NBMEgzTzYy?=
 =?utf-8?B?bVJoMitvYlErYzNYanZDRkY5bC9JMTFjcllVRllweWJRVktMbngzL203NEU0?=
 =?utf-8?B?WFhMTDFHay92UVNOdGh2aUdOR1BVNmtENzlWdHZuN3R2Z2huSjYra2M3akJ0?=
 =?utf-8?B?ZWJkdXphYitQUEQwVHNrd3RXcUZUVlRPNnFzR2FsRDZjNXJCb2ViNlVLZ29v?=
 =?utf-8?B?NmpOeGdXTkVqU3c4QlZ5UVZuanBSODBKR1V0K21nRnNiSVZFVHMrQVI1TTdt?=
 =?utf-8?B?WW9yb25wOWRLS0hSN3dUZTFsMlF5UTRyQm04MFQ0VG54T1VEZWxtTUErRCtK?=
 =?utf-8?B?N3gySzNVV1crZE5oaEVZUjRvU1loVFM5TlBhUGtSQzJ3MUlISHpKSm9jZURQ?=
 =?utf-8?B?SHlGdUcrMjVodEw1cVZjRFM1TDViMldSQzArRGFFSFRSTmh6WEtLeG9YSzV4?=
 =?utf-8?B?OFM2YndBOFlkbE0vVjI3RitOcWpzR2tUNS9NNG5FZ29iSG9GRWRidGZGczc1?=
 =?utf-8?B?a3g4d1FUZ3FGeHhKOEtXV2JBVjltdjVjK2pTeWFGaVo5Wi9PVGd4c2lMKzY5?=
 =?utf-8?B?T2JjbmdXKzBqNzVoVE5EenpoNk1TeVF2eUgvZTc3dmFweStLZ2JQQmh6NGs4?=
 =?utf-8?B?YzgzU1lwU2dESFVzclB6KzFxdi9QaWw1TkdoeXNndjBxOW5oYktja1pSaXF2?=
 =?utf-8?B?OTd2bUg0NjJnSnZqS3kxa25VdUdZTnlZQ3Z6aDBrd09oREhPdzdRWjlSUkdV?=
 =?utf-8?B?ZnhnQzdqQUxUVW9PamNja1REQUNtdzViOXlvaEdIUCsvOW1NV2NIaEJHeno4?=
 =?utf-8?B?QjVkUEJpTk4vTkJ2UWRLR1lENHJRUnBIOEM0ekNRVDVtQkx2RUtnd05BeWd0?=
 =?utf-8?B?aEs1ZVdBNmpGTE05TG1tL0xvY3FXdjFpTEoyWVhaL3hZODlDVmFKaFM0ZGF3?=
 =?utf-8?B?cUtRaVJQRU1DRzZjOTIrRlhJcEc5MS9qcGpOYnJWSyt5VHNIRytkL3FOSWxW?=
 =?utf-8?B?dld3T3U5eUhPeUo5Qy94U1VMWDBaWnRRd0NFalFmOXFuZGhreElJalhjV2Jq?=
 =?utf-8?B?R2J5L2ZvOTJ3OXp2ZTBFbCtHcXpydDB1Z1ZCMWFxM0IrcVJuaHN4Q3ZLaFZk?=
 =?utf-8?B?WDB1UEh0RGkzOE0yRG1DOWw4Ymh1R3prbnkxV2NrMnNuaFZoVHNpbk1yTFZH?=
 =?utf-8?B?eTY5YU1OV1RNUkxhNFQ0TUMyTDRyMGN3ckR5L1FzQ2dvVmY1ZW95Z1ZGUGRT?=
 =?utf-8?B?eHYwTjZkWVhybkZWUVo5TlVHUUdTb1JUQnpQc0dySTY5MlQ0cGsrbW10bzlQ?=
 =?utf-8?B?Q09jcElocDkraFFvZ1pPK1I2dG93YUdnVW9wRUdVNWRGMGRxL1VOZStNZlpr?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3479f1-597f-432f-0e7d-08dba22563c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 09:02:47.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlqhxhouX2asnC+nutHZHAVW7bfCgVvrOgpTz60qPa/8KD6Q40v+pRzohR3MKDEv8TjfnOive+CypiF9CMiGSVwmp+EcbeXG2RsI4R9UB90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10293
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgR2VlcnQgVXl0dGVyaG9ldmVuLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yIFJFU0VO
RF0gcG93ZXI6IHN1cHBseTogc2JzLWJhdHRlcnk6IENvbnZlcnQgZW51bS0NCj4gPnBvaW50ZXIg
Zm9yIGRhdGEgaW4gdGhlIG1hdGNoIHRhYmxlcw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIE1v
biwgQXVnIDIxLCAyMDIzIGF0IDEwOjUz4oCvQU0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yIFJFU0VO
RF0gcG93ZXI6IHN1cHBseTogc2JzLWJhdHRlcnk6IENvbnZlcnQNCj4gPiA+IGVudW0tDQo+ID4g
PiA+cG9pbnRlciBmb3IgZGF0YSBpbiB0aGUgbWF0Y2ggdGFibGVzDQo+ID4gPiBPbiBNb24sIEF1
ZyAyMSwgMjAyMyBhdCAxMDoy4oCvQU0gQmlqdSBEYXMNCj4gPiA+IDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFN1biwgQXVnIDIwLCAyMDIz
IGF0IDc6MTLigK9QTSBCaWp1IERhcw0KPiA+ID4gPiA+IDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IENvbnZlcnQgZW51bS0+cG9pbnRl
ciBmb3IgZGF0YSBpbiB0aGUgbWF0Y2ggdGFibGVzLCBzbyB0aGF0DQo+ID4gPiA+ID4gPiBkZXZp
Y2VfZ2V0X21hdGNoX2RhdGEoKSBjYW4gZG8gbWF0Y2ggYWdhaW5zdCBPRi9BQ1BJL0kyQw0KPiA+
ID4gPiA+ID4gdGFibGVzLCBvbmNlIGkyYyBidXMgdHlwZSBtYXRjaCBzdXBwb3J0IGFkZGVkIHRv
IGl0IGFuZCBpdA0KPiA+ID4gPiA+ID4gcmV0dXJucyBOVUxMIGZvcg0KPiA+ID4gbm9uLW1hdGNo
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZXJlZm9yZSBpdCBpcyBiZXR0ZXIgdG8gY29u
dmVydCBlbnVtLT5wb2ludGVyIGZvciBkYXRhIG1hdGNoDQo+ID4gPiA+ID4gPiBhbmQgZXh0ZW5k
IG1hdGNoIHN1cHBvcnQgZm9yIGJvdGggSUQgYW5kIE9GIHRhYmxlcyB1c2luZw0KPiA+ID4gPiA+
ID4gaTJjX2dldF9tYXRjaF9kYXRhKCkgYnkgYWRkaW5nIHN0cnVjdCBzYnNfZGF0YSB3aXRoIGZs
YWdzDQo+ID4gPiA+ID4gPiB2YXJpYWJsZSBhbmQgcmVwbGFjaW5nIGZsYWdzLT5kYXRhIGluIHN0
cnVjdCBzYnNfaW5mby4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvcG93ZXIvc3VwcGx5L3Nicy1iYXR0ZXJ5LmMNCj4gPiA+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L3Nicy1iYXR0ZXJ5LmMNCj4gPiA+ID4gPiA+IEBA
IC0yMDEsNiArMjAxLDEwIEBAIHN0YXRpYyBjb25zdCBlbnVtIHBvd2VyX3N1cHBseV9wcm9wZXJ0
eQ0KPiA+ID4gPiA+ID4gc3RyaW5nX3Byb3BlcnRpZXNbXSA9IHsNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiAgI2RlZmluZSBOUl9TVFJJTkdfQlVGRkVSUyAgICAgIEFSUkFZX1NJWkUoc3RyaW5n
X3Byb3BlcnRpZXMpDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gK3N0cnVjdCBzYnNfZGF0YSB7
DQo+ID4gPiA+ID4gPiArICAgICAgIHUzMiBmbGFnczsNCj4gPiA+ID4gPiA+ICt9Ow0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gVW5sZXNzIHlvdSBwbGFuIHRvIGFkZCBtb3JlIG1lbWJlcnMgdG8gc3Ry
dWN0IHNic19kYXRhLCBJIHNlZSBubw0KPiA+ID4gPiA+IHBvaW50IGluIHRoaXMgcGF0Y2g6IGl0
IG9ubHkgaW5jcmVhc2VzIGtlcm5lbCBzaXplLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIHZh
cmlvdXMgImRhdGEiIG1lbWJlcnMgaW4gPGZvbz5faWQgc3RydWN0dXJlcyBhcmUgaW50ZW5kZWQN
Cj4gPiA+ID4gPiB0byBjb250YWluIGVpdGhlciBhIHBvaW50ZXIgb3IgYSBzaW5nbGUgaW50ZWdy
YWwgdmFsdWUuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBtYXRjaCBkYXRhIHZhbHVlIGZvciBzYnNf
YmF0dGVyeSBpcyAwLiBIZXJlIHRoZSBBUEkgcmV0dXJucw0KPiA+ID4gPiBOVUxMIGZvciBhIG5v
bi1tYXRjaC4gVGhhdCBpcyB0aGUgcmVhc29uIGl0IGlzIGNvbnZlcnRlZCB0byBwb2ludGVyLg0K
PiA+ID4gPg0KPiA+ID4gPiBTbywgd2UgY2Fubm90IGRpZmZlcmVudGlhdGUgYWN0dWFsIG1hdGNo
ZWQgZGF0YSBhbmQgZXJyb3IgaW4gdGhpcw0KPiBjYXNlLg0KPiA+ID4NCj4gPiA+IElmIHRoZSBk
cml2ZXIncyAucHJvYmUoKSBtZXRob2QgaXMgY2FsbGVkLCB0aGVyZSBtdXN0IGhhdmUgYmVlbiBh
DQo+ID4gPiB2YWxpZCBtYXRjaCwgc28gaTJjX2dldF9tYXRjaF9kYXRhKCkgd2lsbCBuZXZlciBy
ZXR1cm4gTlVMTCBkdWUgdG8gYQ0KPiBub24tbWF0Y2guDQo+ID4NCj4gPiBJIGFncmVlLiBidXQg
InJldHVybiBkYXRhIiBjYW4gYmUgMCxpZiB0aGUgbWF0Y2hlZCB2YWx1ZSBpcyAwIChmb3IgZWc6
DQo+IGhlcmUgInNic19iYXR0ZXJ5IikuDQo+IA0KPiBZZXMsIHNvIHdoYXQgaXMgdGhlIHByb2Js
ZW0/DQo+IFplcm8gaXMgdGhlIGV4cGVjdGVkIHZhbHVlIGZvciB0aGVzZS4NCg0KVGhhbmtzIGZv
ciB0aGUgZXhwbGFuYXRpb24uIEkgYWdyZWUsIGZvciB0aGlzIGRyaXZlciANCnRoZXJlIGlzIG5v
IG5lZWQgZm9yIGVudW0tPnBvaW50ZXIgY29udmVyc2lvbg0KYXMgWmVybyBpcyBleHBlY3RlZCB2
YWx1ZS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
