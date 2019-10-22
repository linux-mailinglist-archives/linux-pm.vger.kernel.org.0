Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A675AE0942
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbfJVQjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 12:39:15 -0400
Received: from mail-eopbgr690046.outbound.protection.outlook.com ([40.107.69.46]:39438
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728768AbfJVQjO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Oct 2019 12:39:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWa/KqY0Wnv6spkXy1Cc5qMmlTYYRELu7lKy4MT06gwDRwZGYkl+LEh3dZKm9z+uW77+NSL9BfctGk+aJD/diToVYfnbP62/Q5KFNQp9b1GQwUTtYwIB3IAwJvXQBQhP9LrpxdfohYy/uexopBLAiq8GHh4nCBNwXL+4Qz9e7e8DLNDIfsm33LJ6DDEIcxy2+4On5gpNYlXwWMvfjsIiodgakfwiL9Ng62KKEzv6WGjNYws9vwDhk/cJLMfLS5fYiQgfDpU0KSETZoOarSEqQa4pufLGT4OcecoGs89QXvCZ3NIOABjR8Qf/oDjd3Jz33PBY5UFOQnaY871og558aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ8rlFk7S/GgfZtAmwzPKdMiwjs0JvERTjjNI2BmR5w=;
 b=WeH1QFWwbwADlHFhWVA09eAJ3ItIKr5Xnsblnrggc8LYkgkeXkhSs/ljCc4J0B4QvHGx++1bgIbz/Dj9I+UGRyyGKIO8TXK14daY9hCXnTdny03lWrbzPxR6+wE9+5FQ+kCWO6LS8xO+FfrpWdfYLT+/KWnEYSwfx6TTGLFzCdbXDuhIxDqs2ddKFFziFmQ/fgNwV3YnG72lzEYiSIuSH7T3YGMUeTLXx7FrynsikLzVJcO2nwjvIXE2L6mmenf3/w3zPhq/9qd+OP9RM2uXcaWwLf1PjbFPyat2aVc238aVlh1LtdS2GeljhLYTjma+AWVY+cXg63uuyw+ousE+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ8rlFk7S/GgfZtAmwzPKdMiwjs0JvERTjjNI2BmR5w=;
 b=z4Or9jgIEHtRNKQMty/EE4heF9jzCY2qxNpvpwMLI4VEi5Is5bblrBTWYsWnOvCP5F7stjMxDFXT650fa5DO/Lw4AiBQPlfI3HUy/6m9dv94Gq/s/2ApeqbqFjLZW7Ga53llG1h23TBiVxCvSrhVOmJ1dtP40bMSpXD5NnBYZKY=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 22 Oct 2019 16:39:11 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::b1e3:1867:e650:796c%6]) with mapi id 15.20.2347.028; Tue, 22 Oct 2019
 16:39:11 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Pu Wen <puwen@hygon.com>, Borislav Petkov <bp@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCHv2 0/3] Update cpupower and make it more accurate
Thread-Topic: [PATCHv2 0/3] Update cpupower and make it more accurate
Thread-Index: AQHVgGtgGy3CWOpXjkaZczBU7MWRIqdm7Z2A
Date:   Tue, 22 Oct 2019 16:39:11 +0000
Message-ID: <ab5d732b-f322-0aeb-3970-99167afc177c@amd.com>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:805:a2::43) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 224b63d5-4390-4e0b-e240-08d7570e5db9
x-ms-traffictypediagnostic: SN6PR12MB2815:|SN6PR12MB2815:
x-microsoft-antispam-prvs: <SN6PR12MB2815FF2D76F6C77810290776E7680@SN6PR12MB2815.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(476003)(486006)(6436002)(6486002)(2616005)(478600001)(66066001)(5660300002)(11346002)(446003)(229853002)(25786009)(316002)(110136005)(54906003)(66946007)(2501003)(256004)(14444005)(14454004)(6246003)(86362001)(6512007)(31696002)(64756008)(66446008)(66556008)(4326008)(66476007)(7416002)(81166006)(81156014)(26005)(8676002)(8936002)(71200400001)(36756003)(71190400001)(305945005)(7736002)(186003)(53546011)(6506007)(102836004)(52116002)(2906002)(76176011)(99286004)(31686004)(15650500001)(386003)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8q5ReoXlP8AbZQr1iiBPfTYGIQHRs6Gcb3NZT6LbFfUFpjq9hZ+b0y5XyU7xlwYbmw8hpHMrW4WeB/omQtLneYM9a2IMf+YyKWl4NNRk0Q80G6d1eAHOxsLwQHCh71hf90V3vFYKC2UBWX+zYGLQhlAiCAs9Nozsz92vtRWyL5V/X65e45FkBCLJ2qMVLs2tU8kxIH2TzdREpS06wSijrE+uoDjGnGWGa57Kp+2Pivb2SEanVHz/RCYzX3xy8SjnFioWNL30LFLTD+l/fmmbxcWGYoi5EXYH8Z/IU82MpCDjDAcFgqOHfelRVzvPdHc4WvQ0bH2sXMbeI4dTX7lu0ph4jGG9kIWCqt34okbVOtu6QagTyJVq9fy5Vhg5u9DLBHEDfXinbSZAiWxxrzxgw4G7D3/5Y1Op+CY0AtWkVprurwVxomavyqfJf1aSLicw
Content-Type: text/plain; charset="utf-8"
Content-ID: <8574767E89561443B9744513031EAC69@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224b63d5-4390-4e0b-e240-08d7570e5db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 16:39:11.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnUrkuXvXfJrIvP49khqyL8B1TImZDznXZ0diyhE5dO7gv4SgNJGkuhWaDwgswdEXrCwf4LZ14iBwbxHSkqQmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTAvMTEvMjAxOSAyOjM3IFBNLCBOYXRhcmFqYW4sIEphbmFrYXJhamFuIHdyb3RlOg0KPiBU
aGlzIHBhdGNoc2V0IHVwZGF0ZXMgY3B1cG93ZXIgdG8gbWFrZSBpdCBtb3JlIGFjY3VyYXRlIGJ5
IHJlbW92aW5nDQo+IHRoZSB1c2Vyc3BhY2UgdG8ga2VybmVsIHRyYW5zaXRpb25zIGFuZCByZWFk
X21zciBpbml0aWF0ZWQgSVBJIGRlbGF5cy4NCj4NCj4gVGhlIGZpcnN0IHBhdGNoIGRvZXMgYSBs
aXR0bGUgcmUtYXJyYW5nZW1lbnQgb2YgdmFyaWFibGVzIGluIHRoZQ0KPiBjcHVpZGxlX21vbml0
b3Igc3RydWN0IHRvIHByZXBhcmUgZm9yIGEgbmV3IGZsYWcuDQo+DQo+IFRoZSBzZWNvbmQgcGF0
Y2ggaW50cm9kdWNlcyBhIHBlcl9jcHVfc2NoZWR1bGUgZmxhZyB3aGljaCwgd2hlbiBzZXQsDQo+
IHdpbGwgYWxsb3cgY3B1cG93ZXIgdG8gbW92ZSB0byBlYWNoIG9mIHRoZSBjcHVzIGluIHRoZSBz
eXN0ZW0uIFRoZQ0KPiBhZHZhbnRhZ2Ugb2YgdGhpcyBpcyB0aGF0IHRoZSBJUEkgbGF0ZW5jeSBp
cyByZW1vdmVkIHdoZW4gcmVhZGluZw0KPiB0aGUgQVBFUkYvTVBFUkYgcmVnaXN0ZXJzLCBzaW5j
ZSBhbiBJUEkgaXMgbm90IGdlbmVyYXRlZCBmb3IgcmRtc3JzDQo+IHdoZW4gdGhlIHNvdXJjZSBh
bmQgZGVzdGluYXRpb24gY3B1cyBhcmUgdGhlIHNhbWUgZm9yIHRoZSBJUEkuDQo+DQo+IFRoZSB0
aGlyZCBwYXRjaCBpbnRyb2R1Y2VzIHRoZSBSRFBSVSBpbnN0cnVjdGlvbiwgd2hpY2ggd2lsbCBh
bGxvdw0KPiBjcHVwb3dlciB0byBub3QgdXNlIHRoZSBtc3IgbW9kdWxlIGZvciBBUEVSRi9NUEVS
RiByZWdpc3RlciByZWFkcy4NCj4gVGhpcyB3aWxsIHJlbW92ZSB0aGUgdXNlcnNwYWNlIHRvIGtl
cm5lbCB0cmFuc2l0aW9uIGRlbGF5cyB3aGVuDQo+IHJlYWRpbmcgdGhlIEFQRVJGL01QRVJGIHJl
Z2lzdGVycy4NCg0KDQpBbnkgY29uY2VybnMgcmVnYXJkaW5nIHRoaXMgcGF0Y2hzZXQ/DQoNCg0K
LUphbmFrDQoNCg0KPg0KPiB2MS0+djI6DQo+ICogQWRkZWQgY292ZXIgbGV0dGVyLg0KPiAqIFVz
ZWQgYmluZF9jcHUgaW5zdGVhZCBvZiByZXdyaXRpbmcgdGhlIHNhbWUgY29kZS4NCj4gKiBNb3Zl
ZCBuZWVkc19yb290IHRvIGZsYWcgc3ViLXN0cnVjdC4NCj4gKiBJbnRyb2R1Y2VkIHBlcl9jcHVf
c2NoZWR1bGUgZmxhZy4NCj4NCj4gSmFuYWthcmFqYW4gTmF0YXJhamFuICgzKToNCj4gICAgY3B1
cG93ZXI6IE1vdmUgbmVlZHNfcm9vdCB2YXJpYWJsZSBpbnRvIGEgc3ViLXN0cnVjdA0KPiAgICBj
cHVwb3dlcjogbXBlcmZfbW9uaXRvcjogSW50cm9kdWNlIHBlcl9jcHVfc2NoZWR1bGUgZmxhZw0K
PiAgICBjcHVwb3dlcjogbXBlcmZfbW9uaXRvcjogVXBkYXRlIGNwdXBvd2VyIHRvIHVzZSB0aGUg
UkRQUlUgaW5zdHJ1Y3Rpb24NCj4NCj4gICB0b29scy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxw
ZXJzL2NwdWlkLmMgICAgfCAgNCArKw0KPiAgIHRvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hl
bHBlcnMvaGVscGVycy5oICB8ICAxICsNCj4gICAuLi4vdXRpbHMvaWRsZV9tb25pdG9yL2FtZF9m
YW0xNGhfaWRsZS5jICAgICAgfCAgMiArLQ0KPiAgIC4uLi91dGlscy9pZGxlX21vbml0b3IvY3B1
aWRsZV9zeXNmcy5jICAgICAgICB8ICAyICstDQo+ICAgLi4uL3V0aWxzL2lkbGVfbW9uaXRvci9j
cHVwb3dlci1tb25pdG9yLmMgICAgIHwgIDIgKy0NCj4gICAuLi4vdXRpbHMvaWRsZV9tb25pdG9y
L2NwdXBvd2VyLW1vbml0b3IuaCAgICAgfCAgNSArLQ0KPiAgIC4uLi91dGlscy9pZGxlX21vbml0
b3IvaHN3X2V4dF9pZGxlLmMgICAgICAgICB8ICAyICstDQo+ICAgLi4uL3V0aWxzL2lkbGVfbW9u
aXRvci9tcGVyZl9tb25pdG9yLmMgICAgICAgIHwgNjQgKysrKysrKysrKysrKysrLS0tLQ0KPiAg
IC4uLi9jcHVwb3dlci91dGlscy9pZGxlX21vbml0b3IvbmhtX2lkbGUuYyAgICB8ICAyICstDQo+
ICAgLi4uL2NwdXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRvci9zbmJfaWRsZS5jICAgIHwgIDIgKy0N
Cj4gICAxMCBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkN
Cj4NCg==
