Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504CB45549A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 07:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbhKRGOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 01:14:15 -0500
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:11361
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243265AbhKRGOO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Nov 2021 01:14:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtPSePqF0dR08243Hcs5dn+6XxHZPs0uZT0M4O+ixmK5xF001tPeUdo6dSPt725eZ0BSXbqZJlJAvlf6zd8+4M8cC3dNqr2BC8AopxUGqmxsG2TZfDA1ChSf67Iy5vxawpsub+etd15kmxcYE5HlV5zabaRH7Z0/8lzqVpv8AWQxALZkbdeoBczcCWSPA5r6oQO1rODVoN0uJw7Ufo+NZMBS7Rp0fhV0LbWGXtTuUuJ4oTouzFN9EdEOr1gxCwQau5JDhrwcElMGMhaUJQUb5qcLEdCpGdU+NDLy7IzfO140wpNExSEdP1dNy2RIKrDcknc/qd+wFLNdTrCXUfF3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP/uhZkLxdf5t5Qls/yFY9oyCHqKPQLihHysXgE2b1E=;
 b=IG/Kv/HS62Z3DvObJ5BDYpASPJwBnkCrIqTF9XAAfPNiEGt/qVQvAZs2/0tL7Uu9l5zObvBqBv2fmaWrJwEsQEP0F7xTkFo7AW9SG5yfzfs1XEFCheEYjIi86w99s2zHzDnIz156SdR4aGaL0ll4bXIubAZn6VjbX4koBPTA1DjsYXzGlg56RAgiRfa/xAVq3DHOmB3mIWPEEh9UeVhck2vk0Ok3zEDGeo8AMMojGiEPyhCNia+xD671ayabxcuQ3rb+9IMuX0qZwoBV0z7Q/kJAOKBbBvIFtwf4oSvbSSZuG1BWQdwcOZbB+xlS55OY9gPZZm1N0AF8p57t4qJTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP/uhZkLxdf5t5Qls/yFY9oyCHqKPQLihHysXgE2b1E=;
 b=Wy+tS5Kica1+99ynvxzaIMzNDJlOVXOGx61liA7tIQvOxjoXNks4s5xMjqGZhHYf8QeaPX6rMnqSjduNaFlRtaS46RnI1XJDyMX6BXn3oI8JXtF8q43u43dnKvD39nG1PyeMlWujph776I80lMe+cT4aHxIXJggU7af+GnckIxU=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2954.eurprd03.prod.outlook.com (2603:10a6:7:5a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Thu, 18 Nov 2021 06:11:11 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::d535:e3e:baf4:2d60%5]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 06:11:11 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Thread-Topic: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
Thread-Index: AQHX2uUgAyZ64u/b2EuYwDXlo7neoqwIjSeAgABDOAA=
Date:   Thu, 18 Nov 2021 06:11:10 +0000
Message-ID: <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
In-Reply-To: <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4048aa68-6b60-4caa-0eb5-08d9aa5a37dd
x-ms-traffictypediagnostic: HE1PR03MB2954:
x-microsoft-antispam-prvs: <HE1PR03MB29545C8DDE34F6FA5F44314FAD9B9@HE1PR03MB2954.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0eg0IbSD5pUeOxiKO5ADdt1XTzcANqhPFTZDvVYBAW0xK9EVPLPJz/nQP3E6AKDHHXthBRx0kjkGBXiynaKmycfmEeqpNwv5LKmV+mOqYiWUxlLPiEz0BrhU7TBkf4YD7tUmbxr8rZKVN51URiwygEdG8ruuidt4vIbUonWDKGrJ5KQf+fDPVxrlWzRM/pYxLHr8Qja++c9ecHUtHu3ncwkcFvrZLRUejixV7hKBl++uQJJvatsQmnyIiHnc+IBm+3wgpSDWDXDW4mU831h2GoDp4Eb6YI/Dsa7jY+no8i1jja5cVW71UX6L+hi0h8Q4sLGMcGyUpgDCYPvC7/T3HVImrXpr5ic73dvKBWuCoLjyJpvp+hEjc7UNGQ4heyMnrfjd/suMeXDQi/4n+xaHpWlfVHvb7XbE5Hi2gW5WklDH59K4WR7v3Fzge3/k9+CA0zs1th1h023D7siTQshZtuzJOYVeH6geKLy2leFIOZUqOqSZpP3MKxKfZ+SpxAMmTVS43QGFb+qqQvpvUrd9LgPCkY5BfnXCcgE33wjKy8q08sVZrepj9mlGLAlCj0zS3YRtdm3XZ9xjIMDmzrBalbqj906ZVDjs39J570K7ck8LtlnFqQmfuuwanLr0yGtIVdx6i+x1Atrez699LnIpnxKV0H2WqVXhNqL5o1derh8ULUwltYboWTHcw9V38U6Hy1yki7GbxohcmbXJ4AK1cIe8lMkSek2wvqkfQ0iuZ2bH82ksF5KVug2m6nVVktrejpImf35zEo0hToCc2T2bHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(8676002)(31686004)(7416002)(122000001)(2906002)(76116006)(86362001)(5660300002)(4326008)(38070700005)(31696002)(6512007)(508600001)(186003)(66556008)(66446008)(64756008)(53546011)(6506007)(8936002)(6486002)(54906003)(2616005)(83380400001)(66946007)(71200400001)(316002)(38100700002)(107886003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVVqam1aN2lqNWx4UUtiQ2JTaXFldVp5VlN0SElnZGpvekZCMWk1bTYzYURW?=
 =?utf-8?B?MlRYVGNIbVN0YU9ROUhGSUcwTEF2MEhVbGVVczhRd05XSlkrdllPNkxEMHJB?=
 =?utf-8?B?OGhUZ0JUaVgxaklXTkh4d3dKaFpCUnA4MXdVeittcWdFMkZKck9kVW52QWRw?=
 =?utf-8?B?RG05b0JkRDUxVytySFE1RllLd1VEVlVBSTNuM3FUaU5zWTh1SDBtWTlReFo2?=
 =?utf-8?B?VHZJeE85czBoNU14MlVieFRxSkNHSjNYaW1XL25mT1o1bmowRlVvQU9ma0NV?=
 =?utf-8?B?T0l3V0pESDY1MzFFZkVhUCtuVkNVd1c2NkE0TCtpVzcxZmNLcHZWV3djWnov?=
 =?utf-8?B?Ymx2a1RjRVBDNVJjRGQ4OWJDamJ6S01BcStvU1RxSXNVZDBLZ1pEbGJyaFVT?=
 =?utf-8?B?L25tSnN5UDhEdnhwUEFpZXA2bm43WEx5elRweWFETTBSVnA4V3hKckwxYVR0?=
 =?utf-8?B?WGhCdng3TTZSKzBOM1JzOGJzcWF4ZkJrT3duSXhITHVoMlFrUVFTSXR1YTFV?=
 =?utf-8?B?Sm5MVXRKdUxXVTZ5YzNSb3cxUDczRC9JdjNKc3Y5UE4xRWV2SnNicXdCcXhz?=
 =?utf-8?B?eGhEUFFaeEhEOFI0ellOdnk2am14QTFyeE9YaFl6T0RKTnVBYjRZTWdISlpD?=
 =?utf-8?B?NDJyK29UREVVWEZmZGxPYWtzSkQ5QkdYVXRlNjAxLy9RY3lBZFpGcGtndTl6?=
 =?utf-8?B?b0RWVERMUHR3aGd3RnVoaUVYdEpjQ2xBZnB5eCthNmpDM2Y3WW1NeUsrY0hr?=
 =?utf-8?B?V3M3Tm9tWndOT05NUWRBNjZvWFB6ZHJDUE1nYzljdEk1R3l3MzVocGgwaGVr?=
 =?utf-8?B?dzZpd1c4cW5YMGUxd3hiMVJ5aCtJWnZSdy9iUlFwZE1jaWkrQ1BSV2paRWVv?=
 =?utf-8?B?TWZMR3BLZE5DUEVVUklOenlxTmZLZGF3MmtiOTZBOFBZSXlQemlneW9XY1N0?=
 =?utf-8?B?Q1VXSENKSysyVzBGUk8vSFJ2Wm1RWExZbVRndHVNZkREdnQ5cTlsMmhmNnlV?=
 =?utf-8?B?OVk3Q1BSZDJBK01Fa09HOVB0MG9YTHUzV2UrQitob2dIM1F1WEFNaUN4QUIr?=
 =?utf-8?B?N2dibFNrUjlJc1pIZDlnd085Zkd3dU1pN293Y1d3UW1UQXRuM3g0bW82YjR0?=
 =?utf-8?B?c3lHYzEyZWhKdVh3Y1FEQlVYMk5ZR2ZRZm5wWklXbGc0SldYQUFTUDRzVXFQ?=
 =?utf-8?B?YnFhVE4rNm1oa081QUU2Y1VMNTM2M29LN2pxRHpzMW1jRUx4dXRVNkNjSFZP?=
 =?utf-8?B?MlFaNnBpdTYwbk9TRThLdmtrU01FT1grVXBWQjZIcXhya0l6MUd6NUM0YldH?=
 =?utf-8?B?UWRpM0Y4Q3FyWDBHTmQ2TTRSMGduUTJjcUtocjlmK0M4Y3hpb0RlUCtJeWwy?=
 =?utf-8?B?Qnk1dW9KVzVleFZuUEVQQjR0RXlMYkNGbXg0c1RIZUplWUVKWldqOTdZS1p0?=
 =?utf-8?B?VWZkeHNrZ3cxZk51Uzh2ZVJyR2ZQRUhnSkVvZ1J2OERyYmphYU9jbTBkK0Jm?=
 =?utf-8?B?aExDK1ErOWYrbEtZSmswVnBwY1NTRUpCRncvc1BjUlRrNTdOQXVqMGVhbFdr?=
 =?utf-8?B?ekRiaVovd2Q1VytBKzJ6ZmwwN3R3cmxUay94MmNYSFJjelNHbytXaW9TdUQw?=
 =?utf-8?B?QnF3L1ZGaDRyajNsZk4rdHU5ZWVleFBmNEYvWGxDREJzeVV6bnJFL0RJcmJh?=
 =?utf-8?B?U0NZTUFyOGxrVTlNTGt3ZU9XNmlQZC9tRy80bFBwSlFkVU9GNkxJc29JbzQy?=
 =?utf-8?B?RzlERTNqQlgwTGNldktJeGdWZ05KSG5UODd6WjU5SXdORm5teXZDSmtPd0Ft?=
 =?utf-8?B?bnVSTlV3dHBWczJUbmxCOTY0b3ZtcHMybEZzTjJLNEdwY0ZnYzBnaTArMHl4?=
 =?utf-8?B?dCtKQ3FaU2p0RFJmSlJrZkRXb0VWdEllcXl3NHVnMXFjM0NIZlp5d1h1aW80?=
 =?utf-8?B?UHFWTVpWNW0wZng0d1VjUnlKeWlGOXV5cFNPRlN6ejhOZVBELzhYMTBMZmtl?=
 =?utf-8?B?SENkcTBISjBkb3pwUVkyTU1EUUxCT0VsQlNrYzMzUTZsVkRTcjhucXpRaDVQ?=
 =?utf-8?B?M0gxdE1nNTJhUXk3SmRyblVha0NqeHdQYjhSVjVjU0NaMjJhVjZ4Y1J2M2pE?=
 =?utf-8?B?WXBWUk1IMUl1dmpkMXl2Z1A1b1NBTWw3S0NyQ280dXJzNVl3WUJZN093TTRv?=
 =?utf-8?B?cXFDelZFOEthR1NjWlc4RUhnWi8vRG9pbmJyUER1UEZqcHBwd3o2K3ZhUmZk?=
 =?utf-8?B?SlhkTWt1eG5raTRlQk5vbkxtWldDSFRjMmpzbmVrYW13Q0llVXI0bk1IWk1o?=
 =?utf-8?B?dmZHc3VPYk51UFRFQ3JTQ3Y2OGlBN1RBM1orRUhlWCswekZ5Q1IyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <200932664EB8E648B274D2E4C93C65F0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4048aa68-6b60-4caa-0eb5-08d9aa5a37dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 06:11:10.9379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XM5SlwH6OqR3FyjPMic51NfriHX69+QXV77is00cc6trIhJw441Uba86Utu1jvB/Zdj1qS64r9SW4qMetzMxIWgQS8iWgtVdMxzj5s8lCnFbaCbT18h1c8BsmU+vdVhd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2954
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTGludXMsDQoNCk9uIDExLzE4LzIxIDA0OjEwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiBP
biBUdWUsIE5vdiAxNiwgMjAyMSBhdCAxOjI2IFBNIE1hdHRpIFZhaXR0aW5lbg0KPiA8bWF0dGku
dmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPiB3cm90ZToNCj4gDQo+PiBTdXBwb3J0IG9idGFp
bmluZyB0aGUgImNhcGFjaXR5IGRlZ3JhZGF0aW9uIGJ5IHRlbXBlcmF0dXJlIiAtIHRhYmxlcw0K
Pj4gZnJvbSBkZXZpY2UtdHJlZSB0byBiYXRpbmZvLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1h
dHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiANCj4g
U2FtZSBxdWVzdGlvbnMgYXMgb24gdGhlIGJpbmRpbmcgcGF0Y2guDQo+IA0KPiBJZiB3ZSBhbHJl
YWR5IHN1cHBvcnQgZGlmZmVyZW50IGRlZ3JhZGF0aW9uIGJ5IHRlbXBlcmF0dXJlIHRhYmxlcywN
Cj4gd2h5IGRvIHdlIG5lZWQgYSBzZWNvbmQgbWVjaGFuaXNtIGZvciB0aGUgc2FtZSB0aGluZz8N
Cg0KVGhhbmtzIGZvciBicmluZ2luZyB0aGlzIHVwLiBBcyBJIHNhaWQsIEkgZGlkbid0IG5vdGlj
ZSB0aGF0IHdlIGNvdWxkIA0KaW5kZWVkIHVzZSB0aGUgQ0FQLU9DViB0YWJsZXMgZm9yIGRpZmZl
cmVudCB0ZW1wZXJhdHVyZXMgdG8gYnJpbmcgaW4gDQp0aGlzIGluZm9ybWF0aW9uIDopIEkgc2Vl
IGNlcnRhaW4gYmVuZWZpdCBmcm9tIHRoZSBwb3NzaWJpbGl0eSBvZiBub3QgDQpyZXF1aXJpbmcg
dG8gbWVhc3VyZSB0aGUgT0NWIGF0IGRpZmZlcmVudCB0ZW1wZXJhdHVyZXMgLSBidXQgaXQgbWF5
IG5vdCANCmJlIG1lYW5pbmdmdWwuIEFzIEkgcmVwbGllZCB0byB5b3VyIHBhdGNoIDEvOSByZXZp
ZXcgLSBJIG5lZWQgdG8gKHRyeSANCnRvKSBkbyBzb21lIG1vcmUgcmVzZWFyY2guLi4NCg0KPiBJ
J2QganVzdCBjYWxjdWxhdGUgYSBmZXcgdGFibGVzIHBlciB0ZW1wZXJhdHVyZSBhbmQgYmUgZG9u
ZSB3aXRoDQo+IGl0Lg0KPiANCj4gQXQgbGVhc3QgZG9jdW1lbnRhdGlvbiBuZWVkcyB0byBiZSB1
cGRhdGVkIHRvIHJlZmxlY3QgdGhhdCB0aGUgdHdvIG1ldGhvZHMNCj4gYXJlIGV4Y2x1c2l2ZSBh
bmQgeW91IGNhbiBvbmx5IHVzZSBvbmUgb2YgdGhlbS4NCj4gDQo+ICsgKiBVc3VhbGx5IHRlbXBl
cmF0dXJlIGltcGFjdHMgb24gYmF0dGVyeSBjYXBhY2l0eS4gRm9yIHN5c3RlbXMgd2hlcmUgaXQg
aXMNCj4gKyAqIHN1ZmZpY2llbnQgdG8gZGVzY3JpYmUgY2FwYWNpdHkgY2hhbmdlIGFzIGEgc2Vy
aWVzIG9mIHRlbXBlcmF0dXJlIHJhbmdlcw0KPiArICogd2hlcmUgdGhlIGNoYW5nZSBpcyBsaW5l
YXIgKEVnIGRlbHRhIGNhcCA9IHRlbXBlcmF0dXJlX2NoYW5nZSAqIGNvbnN0YW50ICsNCj4gKyAq
IG9mZnNldCkgY2FuIGJlIGRlc2NyaWJlZCBieSB0aGlzIHN0cnVjdHVyZS4NCj4gDQo+IEJ1dCB3
aGF0IGNoZW1pc3RyeSBoYXMgdGhpcyBwcm9wZXJ0eT8gVGhpcyBzZWVtcyB0byBub3QgYmUgY29t
aW5nIGZyb20NCj4gdGhlIHJlYWwgcGh5c2ljYWwgd29ybGQuIEkgd291bGQgcGVyaGFwcyBhY2Nl
cHQgZGlmZmVyZW50aWFsIGVxdWF0aW9ucw0KPiBidXQgKmxpbmVhciogYmF0dGVyeSBjaGFyYWN0
ZXJpc3RpY3M/DQoNCmxpbmVhciAqb24gYSBnaXZlbiBzbWFsbCB0ZW1wZXJhdHVyZSByYW5nZSou
IEkgdGhpbmsgdGhpcyBpcyBpbXByb3ZlbWVudCANCnRvIHNpdHVhdGlvbiB3aGVyZSB3ZSBkb24n
dCBkbyB0ZW1wZXJhdHVyZSBjb21wZW5zYXRpb24gYXQgYWxsLiBBbmQsIGJ5IA0Kc2hvcnRlbmlu
ZyB0aGUgdGVtcGVyYXR1cmUgYXJlYSB3aGVyZSBDQVAgY2hhbmdlIGlzIGxpbmVhciwgd2UgY2Fu
IA0KYXBwcm9hY2ggYW55IG5vbiBsaW5lYXIgYmVoYXZpb3VyLCByaWdodD8gV2l0aCB0aGUgY3Vy
cmVudCBzdXBwb3J0IG9mIA0KMTAwIHZhbHVlcywgeW91IGNhbiBkaXZpZGUgdGhlIHRlbXBlcmF0
dXJlIHJhbmdlIHRvIDEwMCBwaWVjZXMgd2l0aCANCmxpbmVhciBDQVAgZGVncmFkYXRpb24gaW1w
YWN0IC0gSSB0aGluayB5b3UgZ2V0IHJlYXNvbmFibHkgZ29vZCANCmVzdGltYXRlcyB0aGVyZSBl
dmVuIGlmIHlvdXIgZGV2aWNlIHdhcyBleHBlY3RlZCB0byBiZSBvcGVyYXRpb25hbCBhdCANCnRl
bXBlcmF0dXJlcyB3aGVyZSBtaW4uLi5tYXggaXMgMTAwQy4gKHRoYXQgd291bGQgYWxsb3cgdXMg
dG8gZGl2aWRlIHRoZSANCnJhbmdlIHRvIDFDIHNsb3RzIGFuZCBhc3N1bWUgbGluZWFyIGRlZ3Jh
ZGF0aW9uIGF0IGVhY2ggMUMgcmFuZ2UuIE9yIA0KZGlkdmlkZSB0aGlzIHVuZXZlbmx5IHNvIHRo
YXQgdGhlIHRlbXBlcmF0dXJlIGFyZWFzIHdoZXJlIGNoYW5nZSBpcyBtb3JlIA0KY29uc3RhbnQg
d2UgY291bGQgaGF2ZSBiaWdnZXIgc2xvdHMsIGFuZCBhdCB0aGUgYXJlYXMgd2hlcmUgY2hhbmdl
IGlzIA0KZmFzdGVyIHdlIGNvdWxkIGhhdmUgc21hbGxlciBzbG90cy4gSSBkb24ndCBzZWUgbGlu
ZWFyIGludGVycG9sYXRpb24gYXMgDQpzdWNoIGEgYmlnIHByb2JsZW0gdGhlcmU/DQoNCj4gSWYg
dGhlIGludGVudCBpcyBvbmx5IGZvciBlbXVsYXRpb24gb2Ygc29tZXRoaW5nIHRoYXQgZG9lc24n
dCBleGlzdCBpbg0KPiByZWFsaXR5IEkgZG91YnQgaG93IHVzZWZ1bCBpdCBpcywgYWxsIGJhdHRl
cnkgdGVjaG5vbG9naWVzIEkgaGF2ZSBzZWVuDQo+IGhhdmUgYmVlbiBub25saW5lYXIgYW5kIGhl
bmNlIHdlIGhhdmUgdGhlIHRhYmxlcy4NCj4gDQo+IElmIHlvdSB3YW50IHRvIHNpbXVsYXRlIGEg
bGluZWFyIGRpc2NoYXJnZSwgdGhlbiBqdXN0IHdyaXRlIGEgZmV3IHRhYmxlcw0KPiB3aXRoIGxp
bmVhciBkaXNzaXBhdGlvbiBwcm9ncmVzc2lvbiwgaXQncyBlYXNpZXIgSSB0aGluay4NCg0KImxp
bmVhciBkaXNzaXBhdGlvbiBwcm9ncmVzc2lvbiIgLSB0aGF0IHNob3VsZCBiZSBteSBuZXh0IGZh
dm91cml0ZSANCnNlbnRlbmNlIHRvIHNvdW5kIHByb2Zlc3Npb25hbCA7KSBJIG5lZWQgdG8gZmly
c3QgZ29vZ2xlIHdoYXQgaXQgaXMgaW4gDQpGaW5uaXNoIHRob3VnaCBYRA0KDQpCZXN0IFJlZ2Fy
ZHMNCglNYXR0aQ0KDQotLSANClRoZSBMaW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1
Y3RvcnMNCg0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1p
Y29uZHVjdG9ycywgRmlubGFuZCBTV0RDDQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxV
DQpGSU5MQU5EDQoNCn5+IHRoaXMgeWVhciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVyZSB3cml0
ZXJzIGJsb2NrIH5+DQo=
