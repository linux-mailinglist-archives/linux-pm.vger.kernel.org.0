Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B268C392BEA
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhE0KhV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 06:37:21 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:61861
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236157AbhE0KhU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 06:37:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4GvJyrw6dxXro4xAooxAPck4b7ay8HQeBnq08cogYmVYB4+eN2kbO5ZAKa5K30hsT2uGT9W+Pmzc33TjiFFD9vumOnbGdPRT/32LpjjsWt9N6aVsQZ0rcRDcPsfJulIAUANMrKUiA7OxknN5mvG6utJbfTEOYg6eg9Mc468GHyq1DTdAPt+MsRTRLpqjj5q7sHYGq5e7QtcbBSQZgCu59EMGQNC23sLuOsx4n5bm3b/OT+HwoIUo6TMh26je473KH6EEnA+VS/JVrsPLuAdvrjAurJw5i99C2Q6wQJG53CdhGTOJEEix4AmEHk2VTfqT40Lsg+xrjQAN8oJSadIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F16p57xd31urzuNhh+gSwkOxMyPX7yZYB/QxJyACp3c=;
 b=VFNVwQJ0q92erlt/ZrLnFGL84/V8LtaNpurf85Qi3AEeb1nmmpRoG2gtzTR9aCADhqNgOQSbTVu/rfMnnB96twzdngKDyryhtyvErmbinhM/txAcrr830efWxWCIAX6SDqjEUMqsNrA6krIhW6g+yI5OilS63hgSQuilVzDnqUrZ98RePymLKyhmmuXwFLsWOJ3CUP8TyZYMzlHWyJ/W0dBG+e6FwIOwPwqWJs8L7ozUvcHjVydDd4qyN3fJMulisR0tTu3cpp6xfh3+bnWFv0GvCUmup6kvpLXJF06uiV9zL/OcpVLebWEqlA43OLZg46AVmbW8rnMmZGRvlFiHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F16p57xd31urzuNhh+gSwkOxMyPX7yZYB/QxJyACp3c=;
 b=vDtFlln+G66jvX57J5oY/Db/817xssDhPOfOlq5i3rXXM2SCSSmo629d3Y/X8J/F0gwd2BDPCXBOM438FZwwsDd8dGGC6+r9et+zuphUo5r196bzJaS2WzVCuKeI/vPQ7jf+HbBvI4ddlqeQKqoa27dzMAtfkNvwAyyJ6uxWQkk=
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com (2603:10a6:6:37::21) by
 DB9PR03MB7467.eurprd03.prod.outlook.com (2603:10a6:10:22d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Thu, 27 May 2021 10:35:44 +0000
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::d10a:71a9:656c:7d96]) by DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::d10a:71a9:656c:7d96%3]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 10:35:44 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 0/9] Drop ROHM BD70528 support
Thread-Topic: [PATCH 0/9] Drop ROHM BD70528 support
Thread-Index: AQHXUU6g/F3P4WWLe0S0t2z9ZGko1Kr3JXmA
Date:   Thu, 27 May 2021 10:35:44 +0000
Message-ID: <de5a85b755799db771616147da36de7d5af17a6f.camel@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: fi.rohmeurope.com; dkim=none (message not signed)
 header.d=none;fi.rohmeurope.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 253d9b00-4e2e-40ea-1976-08d920fb2ee2
x-ms-traffictypediagnostic: DB9PR03MB7467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB9PR03MB74673A9AAF6BD7C250BB03F8AD239@DB9PR03MB7467.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Kms8aGAQ7384+4Pk2sb9NPQpiskkUfGCmrr1xF6lpkuf56cXuzULm3gBjiwznN1nsxnE8RThpRC6I/O2LV1By4FdQmvXo/t1kh1DMflki/P8bOy/g265YEJv9fFhzoj13u3d/8S7p8ktjDUZ+HWTYyctyY8MTxV7ZCdak3yWBdcH+pHlTo8iSsYhEQl9G8LpZJKzGclM2HRJ+PH72pPrQ2+EV4f0FEiGfR5xEHGy6ZFBmPJUBCbQd41vBJKT/15CNG+e5liApNRlICQfxgFvsGiK2X2SufWZwqOTjqIELpQ9IyMP+KIaHwl/S8kV1D1Qr++X4XLUHIo1ttYY3QKAnTZ2EU31Z/2SBVBP90C9KwoOqK0fEu/PZ/9TrctRsJnJ9OONr1FASBzY1f/6zqVjtihxOqeMn/IpxXDb7WWN9efPj+WOtpGoWhXDkiL4f/cyWlOmU1QbL8GQPsm70t+WgVEkJujXmDt1y9DQzo4/70n7OD8dbqxBane/EY3KRO37Ny7WRdDMqkM5zipB5g6AxPTwwrnjess0MINtqVlYAZZTOrxSB1acUm5gzXyd5DZf/F/vetH738Sc0z7jcmnfXrOmAew8B0xksBSOvP8d1MicxWHcBOtxNFt8OWYJsyf4XCRmFSMPQueFUKgzcOuD1yc42tsrpPuedKVU2Ej3SC+DXqbGYeQM1/AhwIYhbI1jRPGBH7n/do5y2B9LBYQKqTjg3Gm5Ulm/9BhBxi7faE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3160.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39830400003)(376002)(6512007)(6200100001)(316002)(7416002)(37006003)(122000001)(6506007)(6486002)(54906003)(86362001)(8936002)(8676002)(186003)(478600001)(64756008)(66476007)(66556008)(66446008)(91956017)(76116006)(66946007)(2616005)(3450700001)(5660300002)(2906002)(71200400001)(4326008)(38100700002)(6862004)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N1NHaVllK3kzQWZRN3llNmxWZWpRYlMxYnJrYlNEV0hkeDEyYlh5NFBqWjhO?=
 =?utf-8?B?SU11STBuSUpKcUkweDFCemNBSGYvLytSQmRLQlEweld6Q0VKTGhyL1MzbktK?=
 =?utf-8?B?Z1h0ZXVzTVZWN05RdGpUelVKZFM1ZVhUOHcyRWVTd3VLaXp6N2RxaTRTd091?=
 =?utf-8?B?RE9EUFFrZHBGNWRFTjhFZlZHc1FsVXNlbU5yY3h3T3FRRk9ITTZQN1MyWWVU?=
 =?utf-8?B?VDZmdWZhR0JEek9HdmdQZmpFcmcybVlCNnpHdGhaV0l4dlg2aU1hMmN5Q0hN?=
 =?utf-8?B?TjFQZUpsaFhBSXM5eitDcHBMUkZpZm0rVldnL2kybTJlWS9uYWhJU1l2QldR?=
 =?utf-8?B?Z25LVTZvUjRPMkdKT3gxUWE2UGxWc3JRMlRPN0s4b2l6b1E3T0hKTDhFUTYx?=
 =?utf-8?B?SWh0ZG9GNW5CWklZdWFjYmtxQmdlS2JtRHBrV25SQ1VjNFhscXFSM2E4YmZS?=
 =?utf-8?B?Y2tkN2d2dldkZmV2WlY1eUxGVFhGeGE4eDZqMlVCYUE0WDBSUTVmbm1FaGJq?=
 =?utf-8?B?WGswNzVvbnREUkx6bzhlR3NneDl5L2d2L1BOSnd1ZkFPRlY1SjZic0RRUmE2?=
 =?utf-8?B?aFZVZ0pJbEl2dkF3VWoydHJYZHQ4QVNPemsvMDlUVTNyN2VpbXAxbndjWk9Q?=
 =?utf-8?B?b0hHTGV5L1JMekxMdjJKOWo0WklmZE1HTlRGNDVFTVVLUkZBak9wQXdJb0U4?=
 =?utf-8?B?anRZRzluUEVKc0c0c3YxczM3b0MxRU1jZEJOM3VKU2djVDNaODkzbjdmekNj?=
 =?utf-8?B?NTJIdjhIRUNTanBUUDEwNFpqRjh2dEtoRkJTN3Awd2lLemticVRWVExCMU83?=
 =?utf-8?B?OHJjYlJnMm9NdkhZUVNPN1llc0sxWXZKbmUzc2dlL29LbXE2Q0wxYjJtMUNV?=
 =?utf-8?B?YWQzRTZoL2ZsMXJxbWZ4bHNKMEVncHRMS2JpUWdsVlNoOGxLcjNhQVBoRTRE?=
 =?utf-8?B?S2RzNlR3dm00c2FiNGEyOVpyaCtLbnpsS1VNWjgwN0t5OThWa0tsYlJOaFN0?=
 =?utf-8?B?NTl1elhnMmQxMzZ1WFkwRnVreTFwWkhUQUxiTFRDNG1Ub2R4R0J2b09jMHVE?=
 =?utf-8?B?bXk0bzJmdzNKK2hORVcxdGlqMGNZcWdleVhucEVhU2ltVmpNNVZFTVdZa1RL?=
 =?utf-8?B?bjI0MnJGcEN4N1M2dk56QU1VVEZUN3NhNEx4YzBsNE9JTGN4ZnVteTNXdkVj?=
 =?utf-8?B?eFJmMFA2bEJCbkNBZzlWbkkvbmtmSzQxSmVYd2UrTEtHNkJjMnVhOVBMVW1E?=
 =?utf-8?B?RmE3Y2xqS3JWS1U1NG9jaWVqVjFrNjZlbVdlN1hJc2MyK3l1Z2RBZDdoRTJo?=
 =?utf-8?B?K3NxSkxscHM2K1FXdnMwREhuTUhYbFZ0YXoyUFREZkMrcE5ITi8rQ3NzRE1h?=
 =?utf-8?B?SGFzMko0ME9JWERWZ3RGZk4yckU1Sklyd0RNc1JBYjNmUVZwamRoU2o2dkdy?=
 =?utf-8?B?NkcwWERScVVISk1sNzAxYUNXSEtwMGhhNDdHQUxmZUNadEpxMnNTL3VTSnB6?=
 =?utf-8?B?TlVKS01ocWZPOGVDYjhabXhJUGtiOHk5YkdqY1BvNWR5NlQ3U1BuSndsNWJB?=
 =?utf-8?B?YXdJYnppQklpc2hVblhwZ3E1RE13S0g2TzY3WjBKYTBWUG5nV2l6YTZrSyt5?=
 =?utf-8?B?UXc4RXY3VHdUd2JtN3JmNTNtWmQzaStpQ1Z2eVplWGlabmZZeGNiV1Z0bENt?=
 =?utf-8?B?MGM1aTNPTVJUNkh1OUIwTVNFS2h3RmxmY20wRk8yUmRPc3ZraVlSeko5cXNu?=
 =?utf-8?B?ZWVMeVAxMnFyKzZURXlxOU5KeDZ5ZmlKN1ZtTTFKUHVxa1piTjJQRnhtZWFO?=
 =?utf-8?Q?pDgfp6dgOUEtZQw84eJGfMegHjvVTgMf94Frk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66F84A895622BF438BCB4C734C44365C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3160.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253d9b00-4e2e-40ea-1976-08d920fb2ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 10:35:44.3686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WZZWHAZQH7q5QDeGvyqpaoRoEjiyemQrNVLIszf8fxfCvTI1r49nyMykvb3Y4m0W1DM1T1jJdtdP7LBo/p96TTaHnKVO7RanQ5BaobhFg151riaYt6eW7zlW/769nqB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7467
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBUdWUsIDIwMjEtMDUtMjUgYXQgMTM6MTMgKzAzMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90
ZToNCj4gRHJvcCBST0hNIEJENzA1Mjggc3VwcG9ydA0KPiANCj4gVW5mb3J0dW5hdGVseSB0aGVy
ZSBoYXMgbm90IGJlZW4gYSBiaWcgZGVtYW5kIGZvciBST0hNIEJENzA1MjgNCj4gSUMuIFRoZSBm
ZXcgdXNlcnMgSSBrbm93IGNvbnRyb2wgUE1JQyBmcm9tIHNlcGFyYXRlIE00LWNvcmUsDQo+IHdo
aWNoIGlzIG5vdCBydW5uaW5nIExpbnV4LiBJIGFtIG5vdCBhd2FyZSBvZiBhbnkgdXNlcnMgb2Yg
dGhpcw0KPiBMaW51eCBkcml2ZXIuDQo+IA0KPiBXaGlsZSBJIGRpZCByZWFsbHkgbGlrZSB0aGlz
IElDIGFuZCB3cml0aW5nIHRoZSBkcml2ZXJzIGZvciBpdCwNCj4gc2VlbXMgbGlrZSB0aGVzZSBk
cml2ZXJzIGFyZSBiZWNvbWluZyB1c2VsZXNzIGJ1cmRlbi4gU28sIEkgc2VlDQo+IG5vIHBvaW50
IGluIG1haW50YWluaW5nIHRoZW0uIExldCdzIGp1c3QgZHJvcCB0aGUgZHJpdmVycyBpZg0KPiB0
aGVyZSBpcyBubyBvYmplY3Rpb25zIHRvIHRoaXMgc2VyaWVzLiA6KA0KPiANCj4gRmV3IG5vdGVz
Og0KPiANCj4gVGhlIEdQSU8sIHJlZ3VsYXRvciwgcG93ZXItc3VwcGx5IGFuZCB3YXRjaGRvZyBk
cml2ZXJzIHNob3VsZCBiZQ0KPiBvbmx5IHVzZWQgb24gQkQ3MDUyOCBhbmQgZGVwZW5kIG9uIHRo
ZSBCRDcwNTI4IE1GRCBLY29uZmlnLiBJIGd1ZXNzDQo+IHRoZSByZW1vdmFsIGNhbiBiZSBpbmRl
cGVuZGVudGx5IG1lcmdlZCB0byB0aGUgcmVzcGVjdGl2ZSBzdWJzeXN0ZW1zLg0KPiANCj4gVGhl
IEJENzA1MjggUlRDIGRyaXZlciBpcyBzdGlsbCB1c2VkIGJ5IEJENzE4MTUgYW5kIEJENzE4Mjgg
LQ0KPiBidXQgdGhlIHdhdGNoZG9nLWhhY2sgY2FuIGJlIHJlbW92ZWQgYW5kIGRyaXZlciBpcyBn
cmVhdGx5DQo+IHNpbXBsaWZpZWQuIEhvd2V2ZXIsIGl0J3Mgd29ydGggbm90aW5nIHRoYXQgdGhl
cmUgaXMgZGVwZW5kZW5jeQ0KPiBmcm9tIHRoZSBCRDcwNTI4IFJUQyBkcml2ZXIgdG8gdGhlIGhl
YWRlciBmaWxlcyAtIHRodXMgdGhlDQo+IFJUQyBkcml2ZXIgY2hhbmdlcyBzaG91bGQgYmUgbWVy
Z2VkIGJlZm9yZSBNRkQgY2hhbmdlcy4gQWxzbyB0aGUNCj4gQ0xLIGRyaXZlciByZW1haW5zIGlu
IHVzZSBhbmQgbmVlZHMgdGhlIEJENzA1MjggSUMtdHlwZS4NCj4gDQo+IEFzIGEgZmluYWwgbm90
ZSAtIEZldyBpbXByb3ZlbWVudHMvZml4ZXMgd2VyZSBqdXN0IGFwcGxpZWQgdG8gdGhlDQo+IHJl
Z3VsYXRvciB0cmVlIHNvIHRoaXMgc2VyaWVzIGlzIGxpa2VseSB0byBjb25mbGljdC4gU29tZSBm
aXhlcw0KPiB3ZXJlIGFsc28gYWRkZWQgdG8gUlRDIEtjb25maWcgLSB3aGljaCBtZWFucyBhbHNv
IHRoZSBSVEMgdHJlZQ0KPiBtYXkgaGF2ZSBjb25mbGljdHMuIFBsZWFzZSBsZXQgbWUga25vdyBp
ZiB5b3Ugd2lzaCBtZSB0byByZWJhc2UNCj4gdGhpcyBzZXJpZXMgb3IgdGhvc2UgcGF0Y2hlcy4N
Cg0KQXMgc2hvcnRseSBkaXNjdXNzZWQgd2l0aCBBbGV4YW5kcmUgaGVyZToNCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvWUt6MjVQREwyWjZ2Z3FKdkBwaW91dC5uZXQvDQoNClRoZSBlYXNp
ZXN0IHdheSB0byBkcm9wIHRoZSBzdXBwb3J0IHdpdGhvdXQgYnJlYWtpbmcgdGhlIGRlcGVuZGVu
Y2llcw0KYW5kIHdpdGhvdXQgaW50cm9kdWNpbmcgY29uZmxpY3RzIGlzIHRvIGRyb3Agc3VwcG9y
dCBmcm9tIHN1Yi1kZXZpY2VzDQppbiBvbmUgY3ljbGUgYW5kIHRoZSBNRkQgb25seSBhdCBuZXh0
IGN5Y2xlLiBTbyBMZWUsIHBsZWFzZSBpZ25vcmUgdGhlDQpNRkQgcGFydCBmb3Igbm93Lg0KDQpJ
J2xsIHJlYmFzZSB0aGUgUlRDIGFuZCByZWd1bGF0b3IgcGF0Y2hlcyB0byBSVEMgYW5kIHJlZ3Vs
YXRvciB0cmVlcw0KYW5kIHNlbmQgdGhlbSBhcyBpbmRpdmlkdWFsIHBhdGNoZXMgdG8gTWFyayBh
bmQgQWxleGFuZHJlLiBJIHRoaW5rIHRoZQ0Kb3RoZXIgc3ViLWRldmljZSBwYXRjaGVzIGFuZCB0
aGUgRFQgYmluZGluZ3MgcGF0Y2ggc2hvdWxkIGFwcGx5IGNsZWFubHkNCnRvIHRoZSByZXNwZWN0
aXZlIHRyZWVzLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBkb2VzIG5vdCB3b3JrIGZvcg0K
eW91Lg0KDQpJJ2xsIHJlLXNwaW4gdGhlIE1GRCBwb3J0aW9uIGR1cmluZyB0aGUgbmV4dCBjeWNs
ZS4NCg0KQmVzdCBSZWdhcmRzDQoJTWF0dGkgVmFpdHRpbmVuDQo=
