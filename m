Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38BC7825D5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Aug 2023 10:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjHUIxE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Aug 2023 04:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHUIxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 04:53:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2095.outbound.protection.outlook.com [40.107.113.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83326BF;
        Mon, 21 Aug 2023 01:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZpgJ4Xx7IH/5UfkHpSNfCFXiQ52ethsW7MwcTylmXA8M60A6Hr9AUm2SlD/7VUZsjy6ufMy+uKn2HnYRSP8VfxdupJXqkSRShQm16lqcQhtCqcPcWC+SBus0AXl2PrAnUVIjXcp05hoLfqFsPl6hsFeUhB4U8tVXodnee6yyDa/Iv6foOvbgPZ6VLwwTtWha1XyIYqypIUW2v8IjkSloONSeHju9Kinfj6JP0k8q+1r2JBscKy+uCby5yaj5XNWNuAxdXH8eXkxWqpZRnvT8vr6T/M/peaVpENmcvZYWBp/DclupaNUdWFtb6gL8rRSjZt54SghA9rfClTMm4t+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZHa6GndZXFvyG1lL5k6W7LGMV1hkmj1dJCJL6xIn/c=;
 b=mAqJHCbOgjOCkti2M8QPgdWnRpJ7bEiNhHOMru5VUaQF5TiP8Wfj0VvtF+b5kROeQiN0bd5tyiOy2BmKfMB6uAo9TqLQrn4trah9NPkZoyO8964PPLIIe60//IhAR0a6e6vqC1G8KVj3INoCDq4kzDZJhUspGs0zS7O04SddXtDNk/5gMM0I/iQxdemtXxzY3pnbvp1KdbgWmRKXAP/Gtn7va5OQLBVmyWk+SqZwlYt9gTamEppPr6EenjNCuqzMLgmYqCTdJZF+9DyNio7zLehLUvLHTS63TAb3SBIfAttGVnMPXjPIKNMDvuCAdl1tfwnJHwJMORAdnFZpidz1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZHa6GndZXFvyG1lL5k6W7LGMV1hkmj1dJCJL6xIn/c=;
 b=oU8XUMp+xUsKcSvz5aTMAcI+aGTU858G+vlWcDsHOK0tcdaaqEjckn9Kbk71sJIm320kPYVcIYEsBbxn/XswGbTNngWK4NopQsusIaJHMXcyCrq0WEcOOEZo923XB5hvbbvdT+3T5M67q0isnha74x0FkVur2Ed6etTwqWuTBJw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9592.jpnprd01.prod.outlook.com (2603:1096:400:19b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 08:52:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 08:52:54 +0000
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
Thread-Index: AQHZ04ltYuj/bpql5UK8hcBWG/7wVK/0ZmCAgAAA03CAAAdDAIAAARiw
Date:   Mon, 21 Aug 2023 08:52:54 +0000
Message-ID: <OS0PR01MB5922A624EA3B52BA99877C07861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
 <20230820171145.82662-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdX_5XtmUt_LBCHbbjS+Ds5j7KrPTtOLVYrHTw4Hipsu9A@mail.gmail.com>
 <OS0PR01MB5922A59E515D4355366294CD861EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXJV+fJHWWCm8w19ryErKhHcpKbWvtoOjCn4p1NUse1sQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXJV+fJHWWCm8w19ryErKhHcpKbWvtoOjCn4p1NUse1sQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9592:EE_
x-ms-office365-filtering-correlation-id: 5c4f9ba0-d1b7-43f4-b463-08dba2240250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1EtRENs7/u5yggeZO2jhTbKxIQVAaGqT8RPkmXGOHuSmVbYMjkwvgyGDx1dm9giZGAyjlPLNADfD5EFjhB06oB6m5FfptGWG+tp9zUr8lYPgubbKBnXDtHl/MYKYuspXs6KNtYj8BO9Ye/OMMKDeGmNx0wUZuM3bkYMmy76DOaRQAknajDoAVb5pf2J2eZCfO4EIzyUr6dNOospRGY3yIKPTl/y9mzF5h/5zaDloPs4lIrEdXxx6Kup/Kdo8STQZfPDAUz3oEU+wV/vxNTnQ1mlfAqNg27a4UYbj6YnYrhteRQlae9q422JWdvqKMRyuW2oWJ4TYqTEKYpxq9pb5ZWbtVXmOGnA+g81RNVoCs1rU2C7ta9BKefX4UqhxoP8udVjmWH7Xq40hNl4+PeBjIzVSn5pATvBe/Vp0PioMBXks7apYfFhRrGPowAVMPsWDshO5rYDL/wFpAv2nJ8esuyCbZNtepY+JifSnMx+w7tbkoLkj+/FSYP31REwTLr+VHIyvoydWpkVPPs/K1PQIZyDQMjRIh4oOWDXv1VnKmTtTOeyhsnub1Gf/+YmjLEKQJIRJUPLyEIqKiEmjTMMEF2cTqGvJvOjOLUvIeETAY0wOY+mDQO78Zl0stLmf8mT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199024)(186009)(1800799009)(2906002)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(6916009)(4326008)(5660300002)(52536014)(76116006)(8676002)(8936002)(316002)(41300700001)(478600001)(53546011)(6506007)(71200400001)(7696005)(9686003)(26005)(122000001)(38070700005)(55016003)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXRsL2ZPcUVKbmNuaW5ZOWRhQ3RXQitxK3RoaERoWWNRbkxLNnJvUHdxNFpo?=
 =?utf-8?B?eGlBa0lCUXZXNDRRTXpTNlg2bnBKY3M0d1pMMllDUjh2Tld3dGV6c0UvbERZ?=
 =?utf-8?B?U2NwemtEZ1JkNUhaWkoyZVJoZ2dKdTVTWUZDeWxLRlpxdkhWNzY2czd1Y0Rv?=
 =?utf-8?B?SU42enppdmE2RmVZK3FGL2lNQnVXWDQ0aVNLWnVmakpJNlFHY0Z4NnFMYjZ2?=
 =?utf-8?B?RU5xU0tUSWZRakVldThlSXBOOE1xZVIzYzZMLzZEcEdNcXRPbktJQ2EyYlhT?=
 =?utf-8?B?MzRtbmFqLzZpaHhhU1pLRGtDUHNLZ1dmRHFrb2tIeVo0U2ZyeTNiTTArR1RQ?=
 =?utf-8?B?WDhOUi9GNTJNZ29MWlQ1Z0wrVUI4ZVloc0I0bEZhY2xHUHR6ZlpaVEYxcklM?=
 =?utf-8?B?YnlxMUJrRUhSL3crdVZxYnR0WENyQkRVTWVDT3A3Rzlwb0MzUW5vNWxqcXpP?=
 =?utf-8?B?Q0d1M2UwWDR3WFJoUW5CTktXcElteVJUeE1DaSt4Z1A4VW1RdnU0ZTNJemJT?=
 =?utf-8?B?b0NyNHFoTWEydk5wRWlrYU1xcUcyWlk5RmpwYk9UbjhzZFc3ekpaUVFaQnlk?=
 =?utf-8?B?eUJDQm5jcnZsRkQ4aEZZSHFMZi9WU2NEQ3N2VUdqQ0JGMHZLeGJ5bFhPUTQw?=
 =?utf-8?B?YXlEN0dEQTR6Q1E3SHFvajNvQTZETEJKSm9HTWl5VkZoc3lQWElSd3JvTWxp?=
 =?utf-8?B?NC9LRm5BYnRJMFlIQU56Uis4c1doZnkySlZkeEdwNUJEUTZQb3VzUFJoN085?=
 =?utf-8?B?WDd2Qkh0TDg4UFZmYTFDaGJHRGtpd0JIdFMvZmozQ0w5M1dXdEdMbm9QL0FV?=
 =?utf-8?B?a2ZuUmlQNGlYUlVyZjMzTG1FcEQ3WEFnYmJjd2hLRWlPM2M0NDRObFpBamM3?=
 =?utf-8?B?N2xENDBVbjFZa3Y2dkQ5L0I0Wmk0MUl1cnJweUtuUzArYjA3Rmc1QmsyeFNV?=
 =?utf-8?B?d0l6Ujc1OWpWN0NvMjZZYTlQNGJucXRGZTJxWWRreUFZTVVkdlJMRlhjY3dM?=
 =?utf-8?B?cE5BUFdqSERQZTBkcmpRQnlBMXZQR01STzNKbHlUdHlFN0lqcGpXMENjZUI5?=
 =?utf-8?B?ZStLSmhrODc0dHowYkI2U3hzV3h5dllxcTA5LytUUk5wcmhSZFBEMzJCMHJL?=
 =?utf-8?B?MEx4WDBRNVdZdW5id2lFM2hUY0t1TkV0RGdBYXBpamU0NzYyVjk5UWlMcksv?=
 =?utf-8?B?a1hlZ0Z0ckxpamR3c3JtR0VoSXdnbmhPVERyanhSUFhSOWJsWTg3eC9ZTURy?=
 =?utf-8?B?dmhWKzYzSXozbkFFWXNRNUFGeTVJc1ZJaFVmNzRIeFBNdlNVYUJ5Yk5hWlhv?=
 =?utf-8?B?bGxrNVNocmtlbXZIWDZUSlNZajVuQm1Pd2pGYk95Zzk4cUlaZUY5aStJWkNP?=
 =?utf-8?B?VzIrbE94SEJ6aHhiaGxiR3BCNGxuU3k0cWlnTUJnR25RZ21lZGl2NFRocXJk?=
 =?utf-8?B?WHRWdjBoTkZwWlNGQlRvQTBBZkliNUt2bXF6bS82and4K3lsUlJPbUR2VTAw?=
 =?utf-8?B?WUdGSVJ3YlVUZHBBbFQ1YXNlYkdYM1hxVEoveU1TemZuMlF2dy9TMDNQU1dU?=
 =?utf-8?B?VUlRWWNEbzdSL3JLbW54allGRXNIZ2RLU1R3UFhNRFdYaXlPS3BaalZHd1FQ?=
 =?utf-8?B?aUkycXFFK29pdzNBYWxhVWoycG5rVEprQmJ6Q2o5SSs1OW9oT2doMzRsdFJj?=
 =?utf-8?B?K1NTYlZGY2k5Tkk1TzFFRHF2bUNIenNxek9VWkgwMElnWHZ1aHBvWkhQZ1JM?=
 =?utf-8?B?bHkxVE9kY1MzSlpXMS8yMTI5Z0ttOUd5SzBRY2dVU2luSUxka2ROd0c2NTNB?=
 =?utf-8?B?S0F2M1VDY3B6RkV0TkoxZ0xmd2txTlZQZzNpU1ZlR3QvRHRCakhjTnprU1JC?=
 =?utf-8?B?ejNhZURUSlhGVzdkMUZ1WXdRc1U1aFQ1S0l2QWZLdU82V0cza2JKb1dyQStG?=
 =?utf-8?B?UUhKMFFqTHlxaVZMbDVLRTBJZklXVDNCTE05dUVWU3hhdVNWNHM3SnMyckQ0?=
 =?utf-8?B?VHdFL0hYUzhZaFh3YjdRVkRtVVowaDFWMlZYcGIvNHNFcGNlQTNERytsRDFB?=
 =?utf-8?B?aWVLYTlOa0VWY2R3WGFDTWNnbFlvbEkwU3l3ekdLV1I4M3hxdjJtM3V3V3Vn?=
 =?utf-8?B?dlNpR0F4UWZJdktYMGE0NmRsQXlkZnBzc2tDa1dVK2FVeCtBNkwyVlBQVGV3?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4f9ba0-d1b7-43f4-b463-08dba2240250
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 08:52:54.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xU3LU5iW9Ro0hORaa8dv2nkRJ6VOy8ZyTH9x/XxmivNTo/3jZignPmPyu0/w2C2mzesuUlUdcX7/2NkcAXCP10l5DGGB+nyJVUXRyaB4HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9592
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
Cj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBNb24sIEF1ZyAyMSwgMjAyMyBhdCAxMDoy4oCvQU0g
QmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiA+IE9u
IFN1biwgQXVnIDIwLCAyMDIzIGF0IDc6MTLigK9QTSBCaWp1IERhcw0KPiA+ID4gPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IENvbnZlcnQgZW51bS0+
cG9pbnRlciBmb3IgZGF0YSBpbiB0aGUgbWF0Y2ggdGFibGVzLCBzbyB0aGF0DQo+ID4gPiA+IGRl
dmljZV9nZXRfbWF0Y2hfZGF0YSgpIGNhbiBkbyBtYXRjaCBhZ2FpbnN0IE9GL0FDUEkvSTJDIHRh
YmxlcywNCj4gPiA+ID4gb25jZSBpMmMgYnVzIHR5cGUgbWF0Y2ggc3VwcG9ydCBhZGRlZCB0byBp
dCBhbmQgaXQgcmV0dXJucyBOVUxMIGZvcg0KPiBub24tbWF0Y2guDQo+ID4gPiA+DQo+ID4gPiA+
IFRoZXJlZm9yZSBpdCBpcyBiZXR0ZXIgdG8gY29udmVydCBlbnVtLT5wb2ludGVyIGZvciBkYXRh
IG1hdGNoIGFuZA0KPiA+ID4gPiBleHRlbmQgbWF0Y2ggc3VwcG9ydCBmb3IgYm90aCBJRCBhbmQg
T0YgdGFibGVzIHVzaW5nDQo+ID4gPiA+IGkyY19nZXRfbWF0Y2hfZGF0YSgpIGJ5IGFkZGluZyBz
dHJ1Y3Qgc2JzX2RhdGEgd2l0aCBmbGFncyB2YXJpYWJsZQ0KPiA+ID4gPiBhbmQgcmVwbGFjaW5n
IGZsYWdzLT5kYXRhIGluIHN0cnVjdCBzYnNfaW5mby4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4NCj4g
PiA+ID4gLS0tIGEvZHJpdmVycy9wb3dlci9zdXBwbHkvc2JzLWJhdHRlcnkuYw0KPiA+ID4gPiAr
KysgYi9kcml2ZXJzL3Bvd2VyL3N1cHBseS9zYnMtYmF0dGVyeS5jDQo+ID4gPiA+IEBAIC0yMDEs
NiArMjAxLDEwIEBAIHN0YXRpYyBjb25zdCBlbnVtIHBvd2VyX3N1cHBseV9wcm9wZXJ0eQ0KPiA+
ID4gPiBzdHJpbmdfcHJvcGVydGllc1tdID0gew0KPiA+ID4gPg0KPiA+ID4gPiAgI2RlZmluZSBO
Ul9TVFJJTkdfQlVGRkVSUyAgICAgIEFSUkFZX1NJWkUoc3RyaW5nX3Byb3BlcnRpZXMpDQo+ID4g
PiA+DQo+ID4gPiA+ICtzdHJ1Y3Qgc2JzX2RhdGEgew0KPiA+ID4gPiArICAgICAgIHUzMiBmbGFn
czsNCj4gPiA+ID4gK307DQo+ID4gPg0KPiA+ID4gVW5sZXNzIHlvdSBwbGFuIHRvIGFkZCBtb3Jl
IG1lbWJlcnMgdG8gc3RydWN0IHNic19kYXRhLCBJIHNlZSBubw0KPiA+ID4gcG9pbnQgaW4gdGhp
cyBwYXRjaDogaXQgb25seSBpbmNyZWFzZXMga2VybmVsIHNpemUuDQo+ID4gPg0KPiA+ID4gVGhl
IHZhcmlvdXMgImRhdGEiIG1lbWJlcnMgaW4gPGZvbz5faWQgc3RydWN0dXJlcyBhcmUgaW50ZW5k
ZWQgdG8NCj4gPiA+IGNvbnRhaW4gZWl0aGVyIGEgcG9pbnRlciBvciBhIHNpbmdsZSBpbnRlZ3Jh
bCB2YWx1ZS4NCj4gPg0KPiA+IFRoZSBtYXRjaCBkYXRhIHZhbHVlIGZvciBzYnNfYmF0dGVyeSBp
cyAwLiBIZXJlIHRoZSBBUEkgcmV0dXJucyBOVUxMDQo+ID4gZm9yIGEgbm9uLW1hdGNoLiBUaGF0
IGlzIHRoZSByZWFzb24gaXQgaXMgY29udmVydGVkIHRvIHBvaW50ZXIuDQo+ID4NCj4gPiBTbywg
d2UgY2Fubm90IGRpZmZlcmVudGlhdGUgYWN0dWFsIG1hdGNoZWQgZGF0YSBhbmQgZXJyb3IgaW4g
dGhpcyBjYXNlLg0KPiANCj4gSWYgdGhlIGRyaXZlcidzIC5wcm9iZSgpIG1ldGhvZCBpcyBjYWxs
ZWQsIHRoZXJlIG11c3QgaGF2ZSBiZWVuIGEgdmFsaWQNCj4gbWF0Y2gsIHNvIGkyY19nZXRfbWF0
Y2hfZGF0YSgpIHdpbGwgbmV2ZXIgcmV0dXJuIE5VTEwgZHVlIHRvIGEgbm9uLW1hdGNoLg0KDQpJ
IGFncmVlLiBidXQgInJldHVybiBkYXRhIiBjYW4gYmUgMCxpZiB0aGUgbWF0Y2hlZCB2YWx1ZSBp
cyAwIChmb3IgZWc6IGhlcmUgInNic19iYXR0ZXJ5IikuDQoNCj4gDQo+IEJUVywgdGhlIGRyaXZl
ciBkb2VzIG5vdCBjaGVjayBmb3IgYSBOVUxMIHJldHVybiB2YWx1ZSBmcm9tDQo+ICpfZ2V0X21h
dGNoX2RhdGEoKSBhbnl3YXkgKGFuZCB0aGVyZSBpcyBubyByZWFzb24gdG8gY2hhbmdlIHRoaXMh
KS4NCg0KSSBhZ3JlZSwgb25seSBkcml2ZXJzIGNoZWNraW5nIE5VTEwgcmV0dXJuDQp2YWx1ZSBm
cm9tICpfZ2V0X21hdGNoX2RhdGEoKSB3aWxsIGhhdmUgdGhpcyBpc3N1ZS4NCg0KQ2hlZXJzLA0K
QmlqdQ0K
