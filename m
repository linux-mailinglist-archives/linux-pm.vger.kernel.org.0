Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E033C22DC
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfI3OMH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:12:07 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com ([40.107.4.109]:36686
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729738AbfI3OMH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 10:12:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izAJ9qB+/VhnPPGUK5li+G1JDff+5X8UegyoALua+S8oRv0T4sQkT94n+SCPSp/OEU7iYT6Ats6j3wCFyl6hZLuzV4aeZq98/enTqne9LJh5E3Z6inJvyVWc+QI1MDk/UHfzGXSABE1Y2D4trAuAyuxnHIxoq4dafPL/ZbEIYh0BQ7HIrywRBRMq5lHU9IKIll/2hkybae4RssNX7FLxFzC3y0cfw03WtqhP001LpF2R0sLTkV25z7o6RQCgNFqTPKumDQjmp6yrRRRQ0p5/Fgbm1BDvwZFUFnRNDfIVs4cueduzejFXVWxJwckFek4EN/j2zG6Sx8d3X0xwEtUPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKl3WPFEDJWeqd8d1FTxGK+hBzamFpg2JJT/epoNplM=;
 b=Z4PqPta074wpl1FcMW5zT1Va/HK5ZEGz15I3r59e6CRkVKtdB6SPfbqbgvues66UoF80LNSHaJQeiGqSotvGblSnDCnIxwz1Vti3QGgOvW24Bg2Akf+/B5NJD2K33lYVygvLNn931XtE0e8imfxg3Be4ayKl/eu0yK3k+piDD92CK2vwLW4Vhbau1BtJgUMnaEYuMrAlQO90AdN1GzRjSJ6a8YJACJfoLDqk4WZEZ/4P8dHDpGzJnV877mN0PhjWUls/Lqu2mC1QeEfY+RhVPifPdRAD4eD4UqiX05VyGlUxQnBVw6eeSC3ztpSB/8TiDzYwvBqy1g073cnILInkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKl3WPFEDJWeqd8d1FTxGK+hBzamFpg2JJT/epoNplM=;
 b=oinTMIHnFGtG0OWfdYutjxrf7LR6tXpffiagcTzeY6rdxbsH6yQi28xLbniFsPi453GdzLgKHBGJF19O8XloIwaFBy332/mJ8FxR8P+cBTPFXjkQG5/PUUZ/ta8yWkihsl2PIeFqENk0RKdAQQ8yQ10uOge6DA2VP5aboSz4pl8=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5453.eurprd05.prod.outlook.com (20.177.200.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 14:12:01 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::dcea:1e0a:c05a:22f9%4]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 14:12:01 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jamie Lentin <jm@lentin.co.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] This patch introduces a feature to force
 gpio-poweroff module
Thread-Topic: [PATCH 0/2] This patch introduces a feature to force
 gpio-poweroff module
Thread-Index: AQHVd3rLAHQrXJaKQkmXW+yh5sbf26dEIk8AgAAgtQA=
Date:   Mon, 30 Sep 2019 14:11:59 +0000
Message-ID: <CAGgjyvEx_F0C2XHDGxf3F0Z8iHF1vQZkoPft3_ZbTswVFv=SJA@mail.gmail.com>
References: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
 <20190930121440.GC13301@lunn.ch>
In-Reply-To: <20190930121440.GC13301@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:c0::46) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAWPYmXBiF8N5qOu7MSKMnKxv7s5xoBSbC4WvbT9jkn5KS63hf2S
        OQhdE0iC4tOD9/DHfBNIefR3SWY64men6HDHD/4=
x-google-smtp-source: APXvYqwoPdmvgF0M0xVLxnVurbOqi7pvyGxlGAXoldhGgvFzKbjRgJK6Q93m78Xo48X8jrOv2kivi1+o6ktB9jp+7Bw=
x-received: by 2002:ac8:6b82:: with SMTP id z2mr22948289qts.331.1569852715486;
 Mon, 30 Sep 2019 07:11:55 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvEx_F0C2XHDGxf3F0Z8iHF1vQZkoPft3_ZbTswVFv=SJA@mail.gmail.com>
x-originating-ip: [209.85.160.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed83844c-700e-41e0-336d-08d745b02885
x-ms-traffictypediagnostic: VI1PR05MB5453:
x-microsoft-antispam-prvs: <VI1PR05MB545375B91EA44CA043CE93EDF9820@VI1PR05MB5453.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(189003)(199004)(4326008)(61266001)(66066001)(66556008)(66946007)(66476007)(64756008)(66446008)(55446002)(305945005)(71200400001)(71190400001)(6862004)(7736002)(256004)(6246003)(99286004)(9686003)(102836004)(6512007)(3846002)(6116002)(8676002)(2906002)(55236004)(25786009)(11346002)(76176011)(81166006)(52116002)(95326003)(8936002)(486006)(6506007)(26005)(54906003)(450100002)(316002)(478600001)(6486002)(14454004)(476003)(44832011)(5660300002)(86362001)(186003)(229853002)(53546011)(6436002)(386003)(446003)(81156014)(498394004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5453;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPp5eSvFPRYhLsdzdO4HENTRrwmL2IcxjeR+2GnvN0m1kLeJRulupS14izWV2mbttUoMcXM2PFzUwc2T9LUlW+aNBhbu/wSKgDHQ5Amyswjo9YLVzvw65UMFxkJ4ywv1y57B9C+4MOPuOD6J9thMDYbbUIHzHdh7c18oda4HQo2Ngtz7pVVrR/Vc43xTUDAr+SJpJJ2BwV/MxNAXAaoA0TqLxi1sAQDPsafzKf005+BxzpvctlPY9P7XBxDy770e06WzVgrspsH81gceV/1pbH06+HqTTjc/y9acBW/BpWaaajHKHyAcYc6Ig1bMI/dBXECnyImqOlnz/+st1LIKSpqnPZT428iTOI8tp/l+HkaQ20pAjPdh5L1b64V7jYc2uhpICcgi5YHUOzg7gxuSN2iWLYDP+dobDLzMbOtiuaM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C95B0AFB21C7E4E999D0E55BD3C99E1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed83844c-700e-41e0-336d-08d745b02885
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 14:11:59.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mafDuazl3DvX5KhJMkZbkutZoDgD8JYcGXzLJPvXO18nRdIe577YOYu0h/KYQJNRhy4GL/JzXXWt0UboFLSu20FvJX6R88+U4iU2ZvAN8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5453
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiBNb24sIFNlcCAzMCwgMjAxOSBhdCAzOjE2IFBNIEFuZHJldyBMdW5u
IDxhbmRyZXdAbHVubi5jaD4gd3JvdGU6DQo+DQo+IE9uIE1vbiwgU2VwIDMwLCAyMDE5IGF0IDEw
OjM1OjM2QU0gKzAwMDAsIE9sZWtzYW5kciBTdXZvcm92IHdyb3RlOg0KPiA+IHRvIHJlZ2lzdGVy
IGl0cyBvd24gcG1fcG93ZXJfb2ZmIGhhbmRsZXIgZXZlbiBpZiBzb21lb25lIGhhcyByZWdpc3Rl
cmVkDQo+ID4gdGhpcyBoYW5kbGVyIGVhcmxpZXIuDQo+ID4gVXNlZnVsIHRvIGNoYW5nZSBhIHdh
eSB0byBwb3dlciBvZmYgdGhlIHN5c3RlbSB1c2luZyBEVCBmaWxlcy4NCj4NCj4gSGkgT2xla3Nh
bmRyDQo+DQo+IEknbSBub3Qgc3VyZSB0aGlzIGlzIGEgZ29vZCBpZGVhLiBXaGF0IGhhcHBlbnMg
d2hlbiB0aGVyZSBhcmUgdHdvDQo+IGRyaXZlcnMgdXNpbmcgZm9yY2VkIG1vZGU/IFlvdSB0aGVu
IGdldCB3aGljaCBldmVyIGlzIHJlZ2lzdGVyIGxhc3QuDQo+IE5vbiBkZXRlcm1pbmlzdGljIGJl
aGF2aW91ci4NCg0KWW91J3JlIHJpZ2h0LCB3ZSBoYXZlIHRvIGhhbmRsZSBhIGNhc2Ugd2hlbiBn
cGlvLXBvd2Vyb2ZmIGZhaWxzIHRvDQpwb3dlciB0aGUgc3lzdGVtIG9mZi4gUGxlYXNlIGxvb2sg
YXQgdGhlDQoybmQgdmVyc2lvbiBvZiB0aGUgcGF0Y2hzZXQuDQoNClRoZXJlIGFyZSAzIG9ubHkg
ZHJpdmVycyB0aGF0IGZvcmNpYmx5IHJlZ2lzdGVyIGl0cyBvd24gcG1fcG93ZXJfb2ZmDQpoYW5k
bGVyIGV2ZW4gaWYgaXQgaGFzIGJlZW4gcmVnaXN0ZXJlZCBiZWZvcmUuDQoNCmRyaXZlcnMvZmly
bXdhcmUvZWZpL3JlYm9vdC5jIC0gc3VwcG9ydHMgY2hhaW5lZCBjYWxsIG9mIG5leHQNCnBtX3Bv
d2VyX29mZiBoYW5kbGVyIGlmIGl0cyBvd24gaGFuZGxlciBmYWlscy4NCg0KYXJjaC94ODYvcGxh
dGZvcm0vaXJpcy9pcmlzLmMsIGRyaXZlcnMvY2hhci9pcG1pL2lwbWlfcG93ZXJvZmYuYyAtDQpk
b24ndCBzdXBwb3J0IGNhbGxpbmcgb2YgbmV4dCBwbV9wb3dlcl9vZmYgaGFuZGxlci4NCkxvb2tz
IGxpa2UgdGhlc2UgZHJpdmVycyBzaG91bGQgYmUgZml4ZWQgdG9vLg0KDQpBbGwgb3RoZXIgZHJp
dmVycyBkb24ndCBjaGFuZ2UgYWxyZWFkeSBpbml0aWFsaXplZCBwbV9wb3dlcl9vZmYgaGFuZGxl
ci4NCg0KPiBXaGF0IGlzIHRoZSBvdGhlciBkcml2ZXIgd2hpY2ggaXMgY2F1c2luZyB5b3UgcHJv
YmxlbXM/IEhvdyBpcyBpdA0KPiBnZXR0aW5nIHByb2JlZD8gRFQ/DQoNClRoZXJlIGFyZSBzZXZl
cmFsIFBNVXMsIFJUQ3MsIHdhdGNoZG9ncyB0aGF0IHJlZ2lzdGVyIHRoZWlyIG93biBwbV9wb3dl
cl9vZmYuDQpNb3N0IG9mIHRoZW0sIHByb2JhYmx5IG5vdCBhbGwsIGFyZSBwcm9iZWQgZnJvbSBE
VC4NCg0KPg0KPiBUaGFua3MNCj4gICAgICAgICBBbmRyZXcNCg0KLS0gDQpCZXN0IHJlZ2FyZHMN
Ck9sZWtzYW5kciBTdXZvcm92DQoNClRvcmFkZXggQUcNCkFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0
OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDogKzQxIDQxIDUwMA0KNDgwMCAobWFpbiBs
aW5lKQ0K
