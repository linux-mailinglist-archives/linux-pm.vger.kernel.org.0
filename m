Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9EB4A9B63
	for <lists+linux-pm@lfdr.de>; Fri,  4 Feb 2022 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiBDOtQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Feb 2022 09:49:16 -0500
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:59360
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229837AbiBDOtP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Feb 2022 09:49:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC1PcA0W9EW2d0xlGwusU9MN7RKMXPOV/XUHoJr3LuoBtQzIhhN5jqrlUTmid3RfPjSM1OKn7fyV18xMb9Rth4zgdeekH327F7V8uZA//nSrj4hv+TyRr28knjINMkul+cJJ2Nhtf2nFA6iMCWvZQidvBeNgsBMU1Is+fDFkQMzc3HFSDFeISFYtvCbyNiiTgLGqU+wVM3Fvo/ZmZzmv/AJGzDeQk8K39VpQ3QiXN1oBfV3pX2uVjNQYqaSKMt+AWSY+xZSPW7b0I85yjglfAFJkQHf8QnFWcUol6xMk6avBGtqjliPtg7YWqejCfpq75tIDCFcUUgVXf/XqMc3/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHNrnhucpvEpFnEGKe+fxQ1iFRB9AYE726hxIbBELks=;
 b=EmTuPplkPVIrjIcw0JToechzHmIIi74Rt+PNXZdyFaqo5Z1/i4YjjssXMSl0ZgQqdBWh4tkNBhDvr4ZEb1a1cIjjLaPvRhHvAxMKHAIGdNKaA7P6Y3WPJPBlfoxBkQhsKSwQ6Na/XEOXe3CgKfdSqvZaZl1id90RAPZHruzLVeeYQHm2Z7xTIzS+aa8RkjMpAxPRzDQHuZQx4hzyWS9IaezFHa3/9XKcnFhrVCBnLbNb0JeO5i3S9vqk70ppvo+Ytlo2alOlEu1piJFtaK15S3Qw0d9yFwSvPmYhRMgthlRZYPDKYK6AKkT1ownLQ12a/wWWd9gpYgHD+LHiUJFLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHNrnhucpvEpFnEGKe+fxQ1iFRB9AYE726hxIbBELks=;
 b=YNFRjS6Rnqczr55s0Q3eYvyKZPre9FYC3zIVZBKzhrQ7NrNLlInCyqh15F0TuERvCJeNyzdZ8vSBt6nnp0e72yimQA+iUpDJjzSXAKWJdQf32lsKF1qP7z5mlsM4j82n5NPdao2pAbWBTDjnALlg0o7CthxKP+9DvV4bHWS2aYE=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 PR2PR03MB5388.eurprd03.prod.outlook.com (2603:10a6:101:1a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 14:49:12 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::833:be72:6b04:dca9]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::833:be72:6b04:dca9%7]) with mapi id 15.20.4930.021; Fri, 4 Feb 2022
 14:49:12 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/6] power: supply: ab8500: Standardize alert mode
 charging
Thread-Topic: [PATCH 2/6] power: supply: ab8500: Standardize alert mode
 charging
Thread-Index: AQHYGSMdMKVBZ0Iir0ed/00jxpX2z6yDeneA
Date:   Fri, 4 Feb 2022 14:49:12 +0000
Message-ID: <8f77b653-529e-4c9b-2fc2-ed49a7f53433@fi.rohmeurope.com>
References: <20220203171633.183828-1-linus.walleij@linaro.org>
 <20220203171633.183828-3-linus.walleij@linaro.org>
In-Reply-To: <20220203171633.183828-3-linus.walleij@linaro.org>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f101cb9b-3c36-411e-4a39-08d9e7ed81e9
x-ms-traffictypediagnostic: PR2PR03MB5388:EE_
x-microsoft-antispam-prvs: <PR2PR03MB53887354E5F7E7B4ABA9086FAD299@PR2PR03MB5388.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObOqsj6rlhfZNL976p+PTsQmfxYKWhSqUd7j5itiQCBJ5j18iB2LUTCRL5in8vZbNPV5EmDVRNkLq+qOr0Jp0SYD6DIPcI5xQqF07HwcE7rQYXFF+bqCdAAe1Bp6OWscggLIdR4gIGMmVyYWoZq+VLcGOI744MbRy0VGVQVvBhXPtGj8cjJsO8/MgcO7jh188rW5wLfVSAniqCo3b7zRFuCZ5Tw4q/OLtwpzbADaY6yFJAT6OGditEXni2oes4W979Ve6LV/acKNFgHTHMaqO89R7NxOWLwCCSxjR2bukBGAEFVBQfiI0qZriH/BR6AIH58hVPzUQ840+J+MY8U0smDcq57T5Qfd80zcBRbdWnr62mXj8sJuFeLmiDJ08O7V0mZF4D9I4Uf0XMUBktPvaFLO3zlPfKRPmcNebVFK5p00fmovmYu/iKYN21BcF5f8YijCikQ4g298i+ASyetZVvYhPON7Y7bFFka1pWne3BgEjuWp01QPpHjr4WGKgL/l9tTSxdmfcpbWBxcHLUSMeqtsla7wFXN4o/aWIKOMA5qb3fu+uX2lJYz23a9P84Lt2F0bFag4i2CnC82l3hPp8Q9jpyfVV579eNzA1mKjVnQpgOLNYPlgX2fPktaNcp7Z5le7DoZgyZvZ6WQhoQ2MKQVb5kS1gPh52pATjO9Xrp402/J7XOSoZDIRTCjOGqbrm2Lm06ffzCorwA90w5hehK+cuiyivFc2JGQhMvNZE4xFUifCFSBby2F0J9Osv7ZPMkcGTOANEzXTmDQ7/2gJ7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(186003)(83380400001)(6512007)(86362001)(6506007)(31686004)(38100700002)(508600001)(6486002)(316002)(110136005)(15650500001)(71200400001)(38070700005)(2906002)(8676002)(122000001)(5660300002)(64756008)(66446008)(66476007)(76116006)(66556008)(66946007)(2616005)(4326008)(53546011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUNySjk2L29nUnlJT29CcktoTzVGMmNkRGxuU3BySUh5ZGQyT2R3VFV1UzFD?=
 =?utf-8?B?aDAxWDBkMTA1UFNpcFIxRXBwN3k0RFVlcDFCRVRGdWFYQVkyR3hSZW04TzJl?=
 =?utf-8?B?THlJc3hqZUhqbThGUlpLVms2Mm1rTFc0WG1sQXdUSHpkSGdjRVBHNU1ib1hY?=
 =?utf-8?B?OUhVRjI1bDJnZGJ6WmJQd3hac09JZFpGTk55ekFWdGxhQ3diUDYvN3FMK0V5?=
 =?utf-8?B?MDluZlVQclZDNTJyZU1KVlFxSVBRNDdnK2wzOEJiL3lLbWVYaHk5Ymp4YWk1?=
 =?utf-8?B?R01rQmlhMlJiSVZWUEkzUHFjc2N2dWdjVTFQemVtTjRzdmJ3dEswTFA0c3kw?=
 =?utf-8?B?NzVIMHhXSG1KUEVrc3JsZjY2dWxRa0g0aVA4bEVZMytVUnc2RkhLZTlYSTlB?=
 =?utf-8?B?S2dXcXZ6SmwyZ2hXWlJQcEpPVGZHU0FBamdhMlFjNnBrb1dYRXdIWWF5MTFY?=
 =?utf-8?B?cVRES29kRXQwbEllZ3Ivd2xHVGg1c2VpL0l1dC91RGovNkhPZ3o2djZZZS9O?=
 =?utf-8?B?c1AzbHFQOXJpVXVRZlJJWlpjOUdKK0p0N1lONHA0R0k5OTRNU3R2Rk1jd3lN?=
 =?utf-8?B?MFRLV0Rad3BQMGVTTkVnSGtnZ3RVMWR4ak9rdkpVU0pUOER2amtuVkFpakRS?=
 =?utf-8?B?SGdOcHk5enpOd3RoaGZoWVZWeEU2QzQ5NDQwb2kzZ05oT3MzMGxUeUo1ejJH?=
 =?utf-8?B?S0xlaG4zTnU3N3NDNm9abkIyWG14VnlUelV6ZVRwUGEvRXBMWkEwZVdTVzZ5?=
 =?utf-8?B?N2k0cnhXZ2QyZkJSZlhVUjhpSlhjemE4cmNFeSsxTHYwUkh2Y0MrOGttUGFm?=
 =?utf-8?B?akF4SmJsMmRnVXNyM29XMDIyUUJXdE5zZVhsNi9yOXk3U1dqdmM0bGY4RjFX?=
 =?utf-8?B?UVNwbTRyV3A4ZmlBWWVYNlBmZnhJd2Zkb3NVSSt4RWRodjBWNTNBanp6U2tE?=
 =?utf-8?B?Q3Y0UkovMzF0MWdyTHVSZ0Uzc1JLdEkxSm5RNTJWY3NzaUpEc2s2OGdnVitx?=
 =?utf-8?B?S2xRZ05JRnI4SjZyamtZTE9CeklhZkVVa1JVdmtQQXdmQ094MWdNQkJIV25n?=
 =?utf-8?B?S0FxOEltdUxyTmVCcmZkNFZHOUZNU0hPQmp5bG91UWhKZHBpV2dlQmVZMnY0?=
 =?utf-8?B?R2RMbTFLT1ppSWtSSHRzTmZWQnFUT21QMFcycW9JMytLNytzcy9jUnJyYjJN?=
 =?utf-8?B?NkVkS3VJaWE4Y1hhY2NjeHJ1R3RHUUsxQXBJVHZoWVRHOVpFbk1YMjNEK0o4?=
 =?utf-8?B?bC8xa1RXMm5RSUlWbnVkcWE3UW9wbzJpRE4xUStVTlB4aWFPcSs0d0ZSUzNK?=
 =?utf-8?B?VFUwRkxOaFJIaEcrbjJWbCtxMzBaOHFDc0dGZFBidFdLOTErOTBSNE9JUXU2?=
 =?utf-8?B?SnJYWGFkTlpTbnFGeWI3azhIcDlrM0pwckdORW1DeEpaaHh4M2ZTcjNCTldW?=
 =?utf-8?B?MllpUENvaEIrWU1WSjdseGFuZXpEMHJqcE8xdHRqM2o5cG1hSEFMelJ0blpT?=
 =?utf-8?B?a1NUSFlsRGhHZlNnQU1zdUtjdDRtRlltdDNnR0hZOFNLL3JqQmFsemNhMW9R?=
 =?utf-8?B?VHM0dnNPVkd4djJ3MDhCSXd2WjJHWVFDM1pnMzFCa0FrVFJOc1BqWDRTbUd0?=
 =?utf-8?B?NlpJdnQzMWF6alJuRmZqNjFvaEdSb1BIQ1dBeHJlRUUzSndKTHBVTDRaYmt1?=
 =?utf-8?B?dFh1TTAxZVFnVmRMQTVnZDNxTnZyb2VoMmk2eUY0N0h4UmVtVGtaSkp2Y0x2?=
 =?utf-8?B?OVdoU3pPSWp6Y1RKS1B4NjVzUlpiUzc5Z0tlN3paSjhKM1p1Z3hDSlkwME1C?=
 =?utf-8?B?ZmVLWGJzN05ycWNzZFpTWGd3QmJxbENIVDkvdjdsQU1lb2VHRG1tNU8wZTR0?=
 =?utf-8?B?TXV4OG1kM0dxMDdwLzFXMEtTTXNYTWM0Zys3cElUVGNUL285WGdybXZHb2dK?=
 =?utf-8?B?OE80a2xsV0VnUUlqOVk4TU1OUXh6TE83cnVudGpVS2c0RUhoNmJUekRsdXc1?=
 =?utf-8?B?eDVyL0dtTENlc3I5c095WTBGOU1aZlh3Z0dkVXdNNzh5UFdJZnEwZW1xYmFO?=
 =?utf-8?B?QWpPMERvS1RzT0tXSkdCZC8vZ0F0OXIzZlRNMW1uTjhqNTdOSGFkLzFRT29l?=
 =?utf-8?B?RlZIY1pwSCtiMTBjbnBBTUEzV3VnTXFQVGhOYzBLL2NIcytScEhqVU9DbXY3?=
 =?utf-8?B?eFFLc01xMVNMR0w1WGxWUTJMZmtzRlZXNXNpY2tNZ2FVcjhuU0xKb2VUdmxm?=
 =?utf-8?B?MkZ1eGdGMWZ6bFNIbU5KSlJSOFlEc1NCbjF6VjQ5c054d2xadTVYTzY1S3J3?=
 =?utf-8?B?ckRVcWwwRnlOMzhVQ1NhSGl2NVc0ODZiNmZ3eEQxeXhKVjRMUHRKdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E4446FC650D87469DB441182FB8A1C5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f101cb9b-3c36-411e-4a39-08d9e7ed81e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 14:49:12.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1q9B4bf+WN+fvOiXG86J6UA594+tSlwZaIF+FheMJf179tXHxD5qQNIypSBQUpQ4Nw8kd7Ap3cCGa92bpAxgdF9eEmpZVwmQvbltq2o7jnVJS7FHyFn1q4DLImmRCceN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5388
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgZGVlIEhvIExpbnVzLA0KDQpPbiAyLzMvMjIgMTk6MTYsIExpbnVzIFdhbGxlaWogd3JvdGU6
DQo+IFRoZSBBQjg1MDAgY29kZSBpcyB1c2luZyBhIHNwZWNpYWwgY3VycmVudCBhbmQgdm9sdGFn
ZSBzZXR0aW5nDQo+IHdoZW4gdGhlIGJhdHRlcnkgaXMgaW4gImFsZXJ0IG1vZGUiLCBpLmUuIHdo
ZW4gaXQgaXMgc3RhcnRpbmcNCj4gdG8gZ28gb3V0c2lkZSBub3JtYWwgb3BlcmF0aW5nIGNvbmRp
dGlvbnMgc28gaXQgaXMgdG9vDQo+IGNvbGQgb3IgdG9vIGhvdC4gVGhpcyBtYWtlcyBzZW5zZSBh
cyBhIHdheSBmb3IgdGhlIGNoYXJnaW5nDQo+IGFsZ29yaXRobSB0byBkZWFsIHdpdGggaG9zdGls
ZSBlbnZpcm9ubWVudHMuDQo+IA0KPiBBZGQgdGhlIG5lZWRlZCBtZW1iZXJzIHRvIHRoZSBzdHJ1
Y3QgcG93ZXJfc3VwcGx5X2JhdHRlcnlfaW5mbywNCj4gYW5kIHN3aXRjaCB0aGUgQUI4NTAwIGNo
YXJnaW5nIGNvZGUgb3ZlciB0byB1c2luZyB0aGlzLg0KDQpUaGFua3MgZm9yIG1ha2luZyB0aGlz
IGdlbmVyaWMuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9wb3dlci9zdXBwbHkvYWI4NTAw
LWJtLmggICAgICAgICB8ICA0IC0tLS0NCj4gICBkcml2ZXJzL3Bvd2VyL3N1cHBseS9hYjg1MDBf
Ym1kYXRhLmMgICAgIHwgIDkgKysrKysrKy0tDQo+ICAgZHJpdmVycy9wb3dlci9zdXBwbHkvYWI4
NTAwX2NoYXJnYWxnLmMgICB8ICA0ICsrLS0NCj4gICBkcml2ZXJzL3Bvd2VyL3N1cHBseS9wb3dl
cl9zdXBwbHlfY29yZS5jIHwgIDIgKysNCj4gICBpbmNsdWRlL2xpbnV4L3Bvd2VyX3N1cHBseS5o
ICAgICAgICAgICAgIHwgMTAgKysrKysrKysrKw0KPiAgIDUgZmlsZXMgY2hhbmdlZCwgMjEgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bv
d2VyL3N1cHBseS9hYjg1MDAtYm0uaCBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2FiODUwMC1ibS5o
DQo+IGluZGV4IDRkNzRkMjFjZjFlYi4uOTFlZjlkNGE1MjIyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3Bvd2VyL3N1cHBseS9hYjg1MDAtYm0uaA0KPiArKysgYi9kcml2ZXJzL3Bvd2VyL3N1cHBs
eS9hYjg1MDAtYm0uaA0KPiBAQCAtMzMxLDE0ICszMzEsMTAgQEAgc3RydWN0IGFiODUwMF9tYXhp
bV9wYXJhbWV0ZXJzIHsNCj4gICAgKiBzdHJ1Y3QgYWI4NTAwX2JhdHRlcnlfdHlwZSAtIGRpZmZl
cmVudCBiYXR0ZXJpZXMgc3VwcG9ydGVkDQo+ICAgICogQHJlc2lzX2hpZ2g6CQkJYmF0dGVyeSB1
cHBlciByZXNpc3RhbmNlIGxpbWl0DQo+ICAgICogQHJlc2lzX2xvdzoJCQliYXR0ZXJ5IGxvd2Vy
IHJlc2lzdGFuY2UgbGltaXQNCj4gLSAqIEBsb3dfaGlnaF9jdXJfbHZsOgkJY2hhcmdlciBjdXJy
ZW50IGluIHRlbXAgbG93L2hpZ2ggc3RhdGUgaW4gbUENCj4gLSAqIEBsb3dfaGlnaF92b2xfbHZs
OgkJY2hhcmdlciB2b2x0YWdlIGluIHRlbXAgbG93L2hpZ2ggc3RhdGUgaW4gbVYnDQo+ICAgICov
DQo+ICAgc3RydWN0IGFiODUwMF9iYXR0ZXJ5X3R5cGUgew0KPiAgIAlpbnQgcmVzaXNfaGlnaDsN
Cj4gICAJaW50IHJlc2lzX2xvdzsNCj4gLQlpbnQgbG93X2hpZ2hfY3VyX2x2bDsNCj4gLQlpbnQg
bG93X2hpZ2hfdm9sX2x2bDsNCg0KSSBhbSBqdXN0IHdvbmRlcmluZyBpZiB3ZSBtaWdodCBoYXZl
IGNhc2VzIHdoZXJlIHRoZSAnbWl0aWdhdGlvbiBhY3Rpb24nIA0Kc2hvdWxkIGJlIGRpZmZlcmVu
dCBmb3IgbG93IGFuZCBoaWdoIHRlbXBlcmF0dXJlIGFsZXJ0cz8gQXMgdGhpcyBpcyANCmdvaW5n
IHRvIHRoZSBEVCBpdCdkIGJlIG5pY2UgdG8gYmUgcHJlcGFyZWQgZm9yIGRpZmZlcmVudCBjYXNl
cy4gSSBhbSANCmRlZmluaXRlbHkgbm90IGFuIGV4cGVydCBoZXJlIGJ1dCBJIGNvdWxkIGltYWdp
bmUgdGhhdCBpbiBzb21lIGNhc2UgDQppbmNyZWFzaW5nIGNoYXJnZSBjdXJyZW50IGF0IGxvdyB0
ZW1wZXJhdHVyZSBjb3VsZCB3YXJtLXVwIHRoZSBiYXR0ZXJ5IA0KYWxsb3dpbmcgY2hhcmdpbmcg
Zm9yIGZldyBtb3JlIG1pbnV0ZXMoPykgTWF5IGJlIEkgYW0gbm90IG1ha2luZyBhbnkgDQpzZW5z
ZSBoZXJlIHNvIHBsZWFzZSBqdXN0IGlnbm9yZSBtZSBpZiB0aGlzIHNvdW5kcyBsaWtlIG5vbnNl
bnNlIC0gSSANCmtlZXAgb2Z0ZW4gdGFsa2luZyBtb3JlIGFuZCBmYXN0ZXIgdGhhbiB0aGlua2lu
Zy4NCg0KQmVzdCBSZWdhcmRzDQoJLS0gTWF0dGkgVmFpdHRpbmVuDQoNCi0tIA0KVGhlIExpbnV4
IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExp
bnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktp
dmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlz
IHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
