Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123D1367DAE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 11:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhDVJ2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 05:28:17 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:23694
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235097AbhDVJ2R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 05:28:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+z7SzXMadXhiSu9Hff3JnWJkC8DLZl7s03l6SZOMxZgBs6lO1vEGiexrJDhIfcO9xC/Y47Bkh3Am2Ra32/gABAQKzhb78SInaFEm3H+344WZZIcC6qD8hvqQdR7SUn3M3Y8OHmizMPiZRAIsJyt8XqEbxdHAtxiZ+1VWAnb7YoYd5in/8YqJV77R8DIEQct+V6Tv62kal7HDTBkQn3yO1bn/+Jytvlic2RpgZ+W4HgDu3ThsvEsTWLFtegqlxwL35xcEnhtQ1DKnDUvrIfuwhotXaeWH4/Lz2e6iLrVIUx7Es25yidFuULawzcj07oXri9GWlk16nTPTrSBbpbYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeMp2slNWSW/YC9AzOmeO4uRAUdbfIvQBCmqpGWeMUE=;
 b=lfeFbP0NVeryKev6QMsU0tCWja6NjxWi4o4h629RD8CVs3ykxBbnKUxyUWGOBsIxrD3w6o/E7rXdze8TH1FEUO8K7PoLpx4E359+cI1BuhQikwoHVzTY2Bqqb31NVewMN5VQE0nPPgqh67+8WM65SVI79HgKSul8NG5qnwT9JKc8a5eJefjpFguzxbVRcFBs4Hejm1ep7O4zSOXVUvD4zWE0AbDfkdFlg4aQ0rbaM2BWkzRe7sGAO2B8N9MHn8t4VOGmbwtcVv80rcFInVLHpKQNpF5unR5EkvVTwBlF/NIYs6wVcsQBJIUXndPBTmQENsfSLj7ckeC1ob/LZdThjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeMp2slNWSW/YC9AzOmeO4uRAUdbfIvQBCmqpGWeMUE=;
 b=RDezNOT1FlCv0h/abCHWudQrBPU5czGn6xPDt9LorPCC/NVESDCCQTcLTQ9Na4CgnnF5YAbYcaGHLU0m75Q+ieqaxEOnEpRJVAvNDI+VAnSVDRRhCoLWrs1GEE5Qv3EiElc1R1XNyNtLccvelSpe3dQiTrxslE6OTNv4dnvzLhs=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2284.eurprd03.prod.outlook.com (2603:10a6:3:1f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Thu, 22 Apr 2021 09:27:38 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd%3]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 09:27:37 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "mcroce@microsoft.com" <mcroce@microsoft.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v8 03/10] thermal: Use generic HW-protection shutdown API
Thread-Topic: [PATCH v8 03/10] thermal: Use generic HW-protection shutdown API
Thread-Index: AQHXNRIT+6l3Jc0aEUWAeX5zwQZ+DarAM9SAgAAVf4A=
Date:   Thu, 22 Apr 2021 09:27:37 +0000
Message-ID: <13ede9c1a755300f90c0e2f454cb12ee7a89e3ac.camel@fi.rohmeurope.com>
References: <cover.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
         <3b62226e320ab412357e102baf6d628e354a0b61.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
         <c9b61f91-301b-92a2-f5e7-e8b8e2373040@linaro.org>
In-Reply-To: <c9b61f91-301b-92a2-f5e7-e8b8e2373040@linaro.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [213.255.186.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ca72395-fc5d-412b-4302-08d90570dea2
x-ms-traffictypediagnostic: HE1PR0301MB2284:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB22841FC6B719494300403E9FAD469@HE1PR0301MB2284.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vD76Gl3Salanec5EXJgL5OHYsOH7GcYygf3T6T/mlbFOcH/ewgyV41RO9CeciGWHeQDhIF/RG6ZsFJYdcN/NuH9Fr/oOpJ8KCnqacw18IuObT/tNjRsjoJEM29HZ1Ty038LKV4dq4AdDxPAzJFeoWsO/GvlQk6QW9bOEMvKpRjDLrOYG/iP3A7Hb5PIDdebKJNHUbjNUP969wN0LZpADsih6MRiZqunWCjKTsR4mCIl94fExelLq6S4HLCB/iAlW2bfznwrYHz9OuoqQr42MC1TE5pe4binAqGjqr0C6tAZByPBihaluoC/2iF8TBqIlIi06f1YwIWTyJBkRsU6LjIBIvt5zPVyVERPHNSMxpCqplFpEST69TpIPwz0kib7bKH7DiGl6MoflFvmhQfH1gwfYTh75r7oQ1V8M/ywDL0RqIhACRVHFIF36c25ubeZzwPB4x+rXDtXh2XYA2kCm7Z7y0S1zcFfy/BFzaWM0GENkAf+DigJfSyDxV26IiStWT8GuWDGUWiQKTYQSo+D8fm5kyg0MYPGWKY+4wdn7wHqpUinXPT91UBy+ApEv6R84YEb0gimiaipZbsjxAdQ5uh9hYo4XPsHFdnum9QMIYNNKnEoCo7OGP1fxNfNU5O9lldydHHRUk8mzTqYBzpwaGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(366004)(376002)(396003)(54906003)(2616005)(8676002)(83380400001)(122000001)(7416002)(4326008)(6512007)(3450700001)(6916009)(66556008)(2906002)(66446008)(86362001)(6506007)(66476007)(186003)(64756008)(5660300002)(53546011)(8936002)(76116006)(316002)(38100700002)(26005)(71200400001)(66946007)(478600001)(6486002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Wi8xeWJIcTBBd1RWZmdpNyszcjNuRUdYMnkzQWlOVE5QVUx1Q0tGdFRPSGNm?=
 =?utf-8?B?YkFLTWxsSjlmdmxvU0VxUzZtaXdHaTE4VVNjckhkWFA2d3dEWlJzSEdISFlK?=
 =?utf-8?B?VTZYbko0Zk9ZdGdxNFdSTmJqUjFrdC9USlNhcGFTbmdpdWtiM0lxT2s2eFpk?=
 =?utf-8?B?eWpxeGNXbDZ1Z0JyVTRQdUVSYnRCSUovaVhXcldNS2NSYjllbU1kVUQwemZV?=
 =?utf-8?B?UVRiN0llaDJnRGp5elM3a0tmTm1YaFFiTmJKUGtSZnYrbkV2VHZ5Tllxb1pq?=
 =?utf-8?B?ejF3aG9rMW5uZ1Q1MHd0bC85V1NsbmlCRDRhRXR1aGRXZGZ3SGtwTUJwYU1i?=
 =?utf-8?B?QjllbjJPTWY1T0pva0pJNndzQnY2OStXclYzM1JLR1AxdFFVR0xnR0VRS2di?=
 =?utf-8?B?Q2JXL2dpTHhWWUQvZkkxblpyQjYxN1lob1ZwRE5zM3pBYzUyTmFPcFkyQXhv?=
 =?utf-8?B?M0JuQ3lzT0JiTXZQcXdnenhjVGZpQXF5VWR6T3pwL3lOUVJmaFU2Y0pTUS9Z?=
 =?utf-8?B?SWdja28rN2lWZ3U1eDJ2RmVaMzFLUm5jL1Y5b3pxMmpTQ0htWU5ISnBQVGs2?=
 =?utf-8?B?cHg1dHE0Z0FYS1FCMlVDSEI2elVVcHFvMTFuNUsrR01SYzd1TDE3QkYyTDBU?=
 =?utf-8?B?WTlnVllQRWw0ZnRXNU1JbVMwRkdGZzJvL0cyR3F6K25DaGZoYlpBVXF6c1Ry?=
 =?utf-8?B?eG5EZVR3K01EeHFGZTllYncvdjVIKzRZd3FTWDhvL2NGdDhHZHNnZURuQi9F?=
 =?utf-8?B?QW9hTi9RTXdVbnU3Wnkya1dyUyszd2pLRmNDM0FteWlsRElLc1I2YTRBWmRB?=
 =?utf-8?B?SitzWlBuUXpDNjZEMlpQUFVya1lzOFNxRmw4d2JsS29DZ29WUVNmRU1pQVVO?=
 =?utf-8?B?eExsUy9wdW1sb3J5NWplNEVuVlJQUUVjUUdRekUvVlhuV1l1N1l0bjU2THNi?=
 =?utf-8?B?em5EK0liRWVZVDl0N29UejZNMWpBZzdoeUg3TDBnYVJiMjdaTmtTSVhtNldx?=
 =?utf-8?B?MnBrQjBCVFl2cEdsOXYxakV2UGZXS25LRVl2bm1GYjBmbFIzd05peTlCVFpL?=
 =?utf-8?B?L2hlcnFqamh4ajY0OXp6WVpzZWdWNXgvUWIwa3JSZERVcDZzR0w5d0tJZkFv?=
 =?utf-8?B?VUExeEN5WWszWlFaMHFhbVhSR0RJWEVvdXAxWjd1ZkNVWXVsbjcvZCs5VmZv?=
 =?utf-8?B?V3l4UTY4Ym5DbklVY3RsODhSeHlGcmVtREt3RXowTDlNYkZsSjNsd3V4RTMy?=
 =?utf-8?B?NzRyTzdpZm52bVVjTjlOL3hSdVpuWExQK3hLeDVpUUszSVlub2NuUDZiSU1X?=
 =?utf-8?B?NEw2VVFXbFVZZTF3STZBd2ZVU3dZSEtnemFBRUsrZjY1TUw5N25mSmZwZ1pJ?=
 =?utf-8?B?d3p0M3RjZnFmV29IaU9ybkYrZmdPb2E1MERZVDBHNXNManRITFUrN0ZZaUZX?=
 =?utf-8?B?MGZrcGZpcUpQbnRwaXJiSUF4UlNraWJOa2hma3plOUkwQlVwVWZlK00zTDBG?=
 =?utf-8?B?K3dXUDBXOTBQMEV5T3lSVjdYZ1c5V3ppN1h6MmREbFZYYXlGSzZReDZEdE5W?=
 =?utf-8?B?VVdzQkZXYU43dDNTQjBUMlNpY0QvdU1MTitQNmQwYkZkVGdWZmV0ZjJJMEtY?=
 =?utf-8?B?dVRaMlhOT2FraDdqbGllQXM3VHBtSXJMZVZSd1dPRWErdzRVem5rSVdnNzZa?=
 =?utf-8?B?SlVkdjRtdjJEeUJnZUtHUnBlWUkzVU9FUUsvZ3ZoZ2RPV3RSVk1iSXZ5Smc0?=
 =?utf-8?B?WS9IYWR2OUVleVJjajNaL1Qzb29UM1dpUVlxdmRPdGpkOGpXUnl2SVZNdmsr?=
 =?utf-8?B?alJ5OUkyN2JieXIvYmhCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B9CAD978ACB6F469DC7848463E515EE@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca72395-fc5d-412b-4302-08d90570dea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 09:27:37.7338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcCI+CH3ldJqkF24Mm0PF84mZe/53GnGXVI95VTEdEqPqucabaWq2Xa3S4xXcI5z0w7Xq8o2pBtGezRgyMlOnjbJkT/CLaX9ptUp5Cjq1ihFU2EEfFd+ngrnWwItTAzd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2284
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgRGFuaWVsLCBhbGwsDQoNCk9uIFRodSwgMjAyMS0wNC0yMiBhdCAxMDoxMCArMDIwMCwgRGFu
aWVsIExlemNhbm8gd3JvdGU6DQo+IE9uIDE5LzA0LzIwMjEgMTM6NDksIE1hdHRpIFZhaXR0aW5l
biB3cm90ZToNCj4gPiBUaGUgaGFyZHdhcmUgc2h1dGRvd24gZnVuY3Rpb24gd2FzIGV4cG9ydGVk
IGZyb20ga2VybmVsL3JlYm9vdCBmb3INCj4gPiBvdGhlciBzdWJzeXN0ZW1zIHRvIHVzZS4gTG9n
aWMgaXMgY29waWVkIGZyb20gdGhlIHRoZXJtYWxfY29yZS4gVGhlDQo+ID4gcHJvdGVjdGlvbiBt
dXRleCBpcyByZXBsYWNlZCBieSBhbiBhdG9taWNfdCB0byBhbGxvdyBjYWxscyBhbHNvDQo+ID4g
ZnJvbQ0KPiA+IGFuIElSUSBjb250ZXh0Lg0KPiA+IA0KPiA+IFVzZSB0aGUgZXhwb3J0ZWQgQVBJ
IGluc3RlYWQgb2YgaW1wbGVtZW50aW5nIG93biBqdXN0IGZvciB0aGUNCj4gPiB0aGVybWFsX2Nv
cmUuDQo+IA0KPiBDYW4geW91IHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbjoNCj4gDQo+IERvY3Vt
ZW50YXRpb24vZHJpdmVyLWFwaS90aGVybWFsL3N5c2ZzLWFwaS5yc3QNCj4gDQo+IDUuIHRoZXJt
YWxfZW1lcmdlbmN5X3Bvd2Vyb2ZmDQo+IA0KDQpJIGNhbi4gUHJvYmxlbSBpcyB3aGF0IHRvIHB1
dCB0aGVyZS4NCg0KSSBsaWtlIHRoZSBmYWN0IHRoYXQgbG9naWMgb2YgYW4gZW1lcmdlbmN5IHNo
dXQtZG93biBpcyBkZXNjcmliZWQuIFlldCwNCmRlc2NyaWJpbmcgaW4gdGhlcm1hbF9jb3JlIGRv
Y3VtZW50YXRpb24gd2hhdCBhbiBBUEkgaG9zdGVkIGluDQprZXJuZWwvcmVib290IGRvZXMgc291
bmRzIGxpa2UgYSBjYWxsIGZvciBkb2N1bWVudGF0aW9uIHdoaWNoIG1heSBub3QNCm1hdGNoIGlt
cGxlbWVudGF0aW9uIGluIHRoZSBsb25nIHJ1bi4NCg0KSSBkcmFmdGVkIGZvbGxvd2luZzoNCmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGhlcm1hbC9zeXNmcy1hcGkucnN0
DQpiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS90aGVybWFsL3N5c2ZzLWFwaS5yc3QNCmluZGV4
IDI5ZmRkODE3ZGRiMC4uYTEwYmZlNmU3MjkzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9k
cml2ZXItYXBpL3RoZXJtYWwvc3lzZnMtYXBpLnJzdA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kcml2
ZXItYXBpL3RoZXJtYWwvc3lzZnMtYXBpLnJzdA0KQEAgLTc1MSwyMCArNzUxLDE0IEBAIHBvc3Np
YmxlLg0KID09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogDQogT24gYW4gZXZlbnQgb2Yg
Y3JpdGljYWwgdHJpcCB0ZW1wZXJhdHVyZSBjcm9zc2luZy4gVGhlcm1hbCBmcmFtZXdvcmsNCi1h
bGxvd3MgdGhlIHN5c3RlbSB0byBzaHV0ZG93biBncmFjZWZ1bGx5IGJ5IGNhbGxpbmcNCm9yZGVy
bHlfcG93ZXJvZmYoKS4NCi1JbiB0aGUgZXZlbnQgb2YgYSBmYWlsdXJlIG9mIG9yZGVybHlfcG93
ZXJvZmYoKSB0byBzaHV0IGRvd24gdGhlDQpzeXN0ZW0NCi13ZSBhcmUgaW4gZGFuZ2VyIG9mIGtl
ZXBpbmcgdGhlIHN5c3RlbSBhbGl2ZSBhdCB1bmRlc2lyYWJseSBoaWdoDQotdGVtcGVyYXR1cmVz
LiBUbyBtaXRpZ2F0ZSB0aGlzIGhpZ2ggcmlzayBzY2VuYXJpbyB3ZSBwcm9ncmFtIGEgd29yaw0K
LXF1ZXVlIHRvIGZpcmUgYWZ0ZXIgYSBwcmUtZGV0ZXJtaW5lZCBudW1iZXIgb2Ygc2Vjb25kcyB0
byBzdGFydA0KLWFuIGVtZXJnZW5jeSBzaHV0ZG93biBvZiB0aGUgZGV2aWNlIHVzaW5nIHRoZSBr
ZXJuZWxfcG93ZXJfb2ZmKCkNCi1mdW5jdGlvbi4gSW4gY2FzZSBrZXJuZWxfcG93ZXJfb2ZmKCkg
ZmFpbHMgdGhlbiBmaW5hbGx5DQotZW1lcmdlbmN5X3Jlc3RhcnQoKSBpcyBjYWxsZWQgaW4gdGhl
IHdvcnN0IGNhc2UuDQorc2h1dHMgZG93biB0aGUgc3lzdGVtIGJ5IGNhbGxpbmcgaHdfcHJvdGVj
dGlvbl9zaHV0ZG93bigpLiBUaGUNCitod19wcm90ZWN0aW9uX3NodXRkb3duKCkgZmlyc3QgYXR0
ZW1wdHMgdG8gcGVyZm9ybSBhbiBvcmRlcmx5IHNodXRkb3duDQorYnV0IGFjY2VwdHMgYSBkZWxh
eSBhZnRlciB3aGljaCBpdCBwcm9jZWVkcyBkb2luZyBhIGZvcmNlZCBwb3dlci1vZmYNCitvciBh
biBlbWVyZ2VuY3lfcmVzdGFydC4NCiANCiBUaGUgZGVsYXkgc2hvdWxkIGJlIGNhcmVmdWxseSBw
cm9maWxlZCBzbyBhcyB0byBnaXZlIGFkZXF1YXRlIHRpbWUgZm9yDQotb3JkZXJseV9wb3dlcm9m
ZigpLiBJbiBjYXNlIG9mIGZhaWx1cmUgb2YgYW4gb3JkZXJseV9wb3dlcm9mZigpIHRoZQ0KLWVt
ZXJnZW5jeSBwb3dlcm9mZiBraWNrcyBpbiBhZnRlciB0aGUgZGVsYXkgaGFzIGVsYXBzZWQgYW5k
IHNodXRzIGRvd24NCi10aGUgc3lzdGVtLg0KK29yZGVybHkgcG93ZXJvZmYuDQogDQotSWYgc2V0
IHRvIDAgZW1lcmdlbmN5IHBvd2Vyb2ZmIHdpbGwgbm90IGJlIHN1cHBvcnRlZC4gU28gYSBjYXJl
ZnVsbHkNCi1wcm9maWxlZCBub24temVybyBwb3NpdGl2ZSB2YWx1ZSBpcyBhIG11c3QgZm9yIGVt
ZXJnZW5jeSBwb3dlcm9mZiB0bw0KYmUNCi10cmlnZ2VyZWQuDQorSWYgdGhlIGRlbGF5IGlzIHNl
dCB0byAwIGVtZXJnZW5jeSBwb3dlcm9mZiB3aWxsIG5vdCBiZSBzdXBwb3J0ZWQuIFNvDQphDQor
Y2FyZWZ1bGx5IHByb2ZpbGVkIG5vbi16ZXJvIHBvc2l0aXZlIHZhbHVlIGlzIGEgbXVzdCBmb3Ig
ZW1lcmdlbmN5DQorcG93ZXJvZmYgdG8gYmUgdHJpZ2dlcmVkLg0KDQoNCmJ1dCBJJ20gbm90IHN1
cmUgd2hhdCB0byB0aGluayBhYm91dCBpdC4NCg0KT3BpbmlvbnMvc3VnZ2VzdGlvbnM/DQoNCkJl
c3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0KDQo=
