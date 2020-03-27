Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24C3195FF6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 21:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgC0UpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 16:45:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:46292 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbgC0UpQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 16:45:16 -0400
IronPort-SDR: 8yZbWktBFrs5cv+RRLhqPryvYcVZrYGANt1WvPRC2BjOmXsAgyjKB+GCPCgb9LgCQYQ1PEJMdX
 GeK43Xw6Rpog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 13:45:15 -0700
IronPort-SDR: teWqXqUHus6Uv//mjVahHR6sezrhybi4GXLPtxLgP9aatjC2Z1I7YTk+v4/EcQleIn7GecbZLb
 Yoml3fTkTJeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="251256528"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2020 13:45:14 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 13:45:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 27 Mar 2020 13:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKDESFxSmkQbTPX871eYuxTLsUZyHbXms8gTn4CRZpiLb/lNexwvK1XE23McfPP/vO/GmXzG1vZhP91CnoX6BzozJaHLvheQHuIi5RmD0XctEX+W/1/3WxRQgzgpc4XoHLmD1dOMWVs8FIbKbW96cDXmdgeZtvtuQs/9T8UGgUU4gJJ9PfVcUILmEu+Yrms2zweCYwh6cxjbvA0cAd7ZNPgbtE5pBrmHeFM9TN3McZhJT4EaHwMTLReOLHC2N2795dRIer3NkQvLxLIJRoAmqqANdlNyBPCApyFIFMXtylGwN78d10T8HxkQ8hE9KinE35qjgro1NblCVCMgyfKaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7ldJOfFU7OT39TkJ7tcWmaG5kGdnbL50Ieakf1mvmk=;
 b=QX14ALdtvUgsOs4Gkfkq2LY3Yr8UBtPxPAoZ5S8UXXoUh1jgInBzuG+KQ11fXkT279Onvkgr8e0o2KrLX3hR5bhtVz38q76koWXrUfGvKTkUCrEzr2pq5g7Ex5UC5jK2R8zjflSc5UZNsWAV+F/yfLoxlwTkn7J1LtKyD+kElOanXQ9Vs/JTyrFCf5/Vyfndjnr9mTyIKiX3P3TDPVkt5yNqvCwb755r0i5iNR1h3lemPwZMu/OBJ5Y3imPFkmjKzxSPzmSAB7OwvxyzNiuGWy0dosvA0rDI4iXGkhCkrhyALxXvmSVXVFFjKPfnZMDMPPu/fSvkxk1hu6A6BzScfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7ldJOfFU7OT39TkJ7tcWmaG5kGdnbL50Ieakf1mvmk=;
 b=mkiTZbOH1Aorz4icySuwZHfJhd/jbrXmvFeY0RhMG1AfQYQEPYdwgWy/cmfzjOhsAHqG90Ocgi98Ln/IhnMZ3He+rFn/eK27J9VrwGeEPNR7j8OwN/4gNBOyk/ROYvqpgOD5YMOoVXzDW2FvQGi3G8RbRolQzfO0DJl/gLCSY4Y=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB2597.namprd11.prod.outlook.com (2603:10b6:a02:c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 27 Mar
 2020 20:45:13 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 20:45:13 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "dvhart@infradead.org" <dvhart@infradead.org>,
        "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH v1 1/3] ACPI: fix: Update Tiger Lake ACPI device IDs
Thread-Topic: [PATCH v1 1/3] ACPI: fix: Update Tiger Lake ACPI device IDs
Thread-Index: AQHWBHaXqPkz5brYI06TmKlyZq/Lqahc5g6AgAABztA=
Date:   Fri, 27 Mar 2020 20:45:13 +0000
Message-ID: <BYAPR11MB36249D9AC4FDE3A9EFF79D66F2CC0@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1585335927.git.gayatri.kammela@intel.com>
         <f2b887a74103500ab59c42e6082f9c52f2063e4a.1585335927.git.gayatri.kammela@intel.com>
 <7e9c5faa9c4c873b6f5b5a8a526134cd92ef6a2a.camel@intel.com>
In-Reply-To: <7e9c5faa9c4c873b6f5b5a8a526134cd92ef6a2a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acb87467-4b08-4605-723e-08d7d28fbfe8
x-ms-traffictypediagnostic: BYAPR11MB2597:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB25974B10891A3F8993AC37FBF2CC0@BYAPR11MB2597.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(478600001)(52536014)(66946007)(5660300002)(54906003)(9686003)(186003)(66476007)(53546011)(71200400001)(64756008)(86362001)(2906002)(76116006)(66446008)(55016002)(66556008)(6506007)(33656002)(110136005)(8936002)(81156014)(7696005)(8676002)(4326008)(81166006)(15650500001)(316002)(7416002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2597;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKXaCGoBNd6Vzt/6psZHJAPPXhpfq3qgRPVKIFaX67oj+ZWS2cYP4J0w+0YMmBcxm2cDDlXGqrQBwdxkk67sr+9yxCtseiwDqnYvc8JmD8kKAN3CNexqgbLVnxccn79UJ/8aByl5BeB8V8J2dQdyKBHBtyb4KABSGbZrBr3peRDw0ZBtIfZTftqNGTKFzi2uLvrSrSZEZgxa9EvH8nIhZBr2rAwgHVbUFb8jIcLPxuWrAccMNUqUrjaSoUNICRmgGz9gmc63tOBjToWzK/7WsrEUosi/tnAjBn16YX66xC7KdrN64xn38GEkJZFEEe33Ze5t4fFoRD4md1Wr+6QHTy4hjGwhIrKfwva3DVPvBgZBx4TQ/NJ9sbiYTpXGIFwgQ+RAeh3XTC795MhvRRxcimIS36/qLx6zeAMzD3gVT5rfbnBWZtcyEtPrt1GwLkJH
x-ms-exchange-antispam-messagedata: JleUnFavx/UE5hw6kFQUVX6MQJTMRtEQHNcgoBT8yMKgZaeW3AbxRh0uUU8KcIZED7LVLRZq2k74VVvqJSDc80uV8dWoNtynFN8Y8z5N8VDhGh6q88jUEodDT/JU2L26TNsqbcoWtDEb9YeCbnLWPA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: acb87467-4b08-4605-723e-08d7d28fbfe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 20:45:13.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sk4XNI+1GYu3Nwiwj//Tj3jZv0Npx7+KkGMypP0fVMN9rFw2MfhF1GoRZfDhI8NFLMGV0TRy6gfpOWF3Uf+DoGLoNPmaCnLHjqIILTI4cWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2597
X-OriginatorOrg: intel.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW5kcnV2YWRhLCBTcmluaXZh
cyA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2gg
MjcsIDIwMjAgMTozNyBQTQ0KPiBUbzogbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBLYW1tZWxh
LCBHYXlhdHJpDQo+IDxnYXlhdHJpLmthbW1lbGFAaW50ZWwuY29tPg0KPiBDYzogZHZoYXJ0QGlu
ZnJhZGVhZC5vcmc7IGFsZXguaHVuZ0BjYW5vbmljYWwuY29tOw0KPiBkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnOyBhbWl0Lmt1Y2hlcmlhQHZlcmR1cmVudC5jb207IGxlbmJAa2VybmVsLm9yZzsN
Cj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IFpoYW5nLCBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgYW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tOyBXZXN0ZXJiZXJnLA0KPiBNaWthIDxtaWthLndlc3RlcmJlcmdAaW50ZWwu
Y29tPjsgUHJlc3RvcGluZSwgQ2hhcmxlcyBEDQo+IDxjaGFybGVzLmQucHJlc3RvcGluZUBpbnRl
bC5jb20+OyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsNCj4gV3lzb2NraSwg
UmFmYWVsIEogPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxIDEvM10gQUNQSTogZml4OiBVcGRhdGUgVGlnZXIgTGFrZSBBQ1BJIGRldmljZSBJRHMN
Cj4gDQo+IE9uIEZyaSwgMjAyMC0wMy0yNyBhdCAxMzoyNCAtMDcwMCwgR2F5YXRyaSBLYW1tZWxh
IHdyb3RlOg0KPiA+IFRpZ2VyIExha2UncyBuZXcgdW5pcXVlIEFDUEkgZGV2aWNlIElEcyBmb3Ig
RFBURiBhbmQgZmFuIGRyaXZlcnMgYXJlDQo+ID4gbm90IHZhbGlkIGFzIHRoZSBJRHMgYXJlIG1p
c3NpbmcgJ0MnLiBGaXggdGhlIElEcyBieSB1cGRhdGluZyB0aGVtLg0KPiA+DQo+ID4gQWZ0ZXIg
dGhlIHVwZGF0ZSwgdGhlIG5ldyBJRHMgc2hvdWxkIG5vdyBsb29rIGxpa2UNCj4gPiBJTlQxMDQ3
IC0tPiBJTlRDMTA0Nw0KPiA+IElOVDEwNDAgLS0+IElOVEMxMDQwDQo+ID4gSU5UMTA0MyAtLT4g
SU5UQzEwNDMNCj4gPiBJTlQxMDQ0IC0tPiBJTlRDMTA0NA0KPiA+DQo+IFdlIG5lZWQgRml4ZXMg
dGFnLg0KPiANCj4gRm9yIGV4YW1wbGUNCj4gDQo+IEZpeGVzOiA1NWNmZTZhNWM1ODIgKCJBQ1BJ
OiBEUFRGOiBBZGQgVGlnZXIgTGFrZSBBQ1BJIGRldmljZSBJRHMiKQ0KPiBDYzogNS42KyA8c3Rh
YmxlQHZnZXIua2VybmVsLm9yZz4gIyA1LjYrDQoNClRoYW5rcyBTcmluaXZhcyEgSSB3aWxsIGFk
ZCB0aGUgZml4ZXMgdGFnIGFuZCBzZW5kIHYyDQoNCj4gDQo+IEJ5IHRoZSB0aW1lIHRoaXMgcGF0
Y2ggaXMgbWVyZ2VkIEkgZ3Vlc3MgdGhlIDUuNiB3aWxsIGJlIG91dC4NCj4gDQo+ID4gQ2M6IEFu
ZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiA+IENj
OiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4NCj4g
PiBDYzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiA+
IFN1Z2dlc3RlZC1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBp
bnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogR2F5YXRyaSBLYW1tZWxhIDxnYXlhdHJpLmth
bW1lbGFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMg
ICAgICAgICAgICB8IDIgKy0NCj4gPiAgZHJpdmVycy9hY3BpL2RwdGYvZHB0Zl9wb3dlci5jICAg
ICAgfCAyICstDQo+ID4gIGRyaXZlcnMvYWNwaS9kcHRmL2ludDM0MHhfdGhlcm1hbC5jIHwgOCAr
KysrLS0tLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMgYi9k
cml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMgaW5kZXgNCj4gPiBiNjRjNjJiZmNlYTUuLjgwZGFlM2Iz
YzM2YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMNCj4gPiBAQCAtMTMyMSw3ICsxMzIxLDcgQEAgaW50
IGFjcGlfZGV2X3BtX2F0dGFjaChzdHJ1Y3QgZGV2aWNlICpkZXYsIGJvb2wNCj4gPiBwb3dlcl9v
bikNCj4gPiAgCSAqLw0KPiA+ICAJc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBz
cGVjaWFsX3BtX2lkc1tdID0gew0KPiA+ICAJCXsiUE5QMEMwQiIsIH0sIC8qIEdlbmVyaWMgQUNQ
SSBmYW4gKi8NCj4gPiAtCQl7IklOVDEwNDQiLCB9LCAvKiBGYW4gZm9yIFRpZ2VyIExha2UgZ2Vu
ZXJhdGlvbiAqLw0KPiA+ICsJCXsiSU5UQzEwNDQiLCB9LCAvKiBGYW4gZm9yIFRpZ2VyIExha2Ug
Z2VuZXJhdGlvbiAqLw0KPiA+ICAJCXsiSU5UMzQwNCIsIH0sIC8qIEZhbiAqLw0KPiA+ICAJCXt9
DQo+ID4gIAl9Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvZHB0Zi9kcHRmX3Bvd2Vy
LmMNCj4gPiBiL2RyaXZlcnMvYWNwaS9kcHRmL2RwdGZfcG93ZXIuYyBpbmRleCAzODdmMjdlZjMz
NjguLmU1ZmIzNGJmYTUyYw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9kcHRm
L2RwdGZfcG93ZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9kcHRmL2RwdGZfcG93ZXIuYw0K
PiA+IEBAIC05Nyw3ICs5Nyw3IEBAIHN0YXRpYyBpbnQgZHB0Zl9wb3dlcl9yZW1vdmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZQ0KPiA+ICpwZGV2KQ0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBpbnQzNDA3X2RldmljZV9pZHNbXSA9IHsNCj4gPiAt
CXsiSU5UMTA0NyIsIDB9LA0KPiA+ICsJeyJJTlRDMTA0NyIsIDB9LA0KPiA+ICAJeyJJTlQzNDA3
IiwgMH0sDQo+ID4gIAl7IiIsIDB9LA0KPiA+ICB9Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvZHB0Zi9pbnQzNDB4X3RoZXJtYWwuYw0KPiA+IGIvZHJpdmVycy9hY3BpL2RwdGYvaW50
MzQweF90aGVybWFsLmMNCj4gPiBpbmRleCAxZWM3YjY5MDA2NjIuLjI5YjVjNzcyNTZkZCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvZHB0Zi9pbnQzNDB4X3RoZXJtYWwuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvYWNwaS9kcHRmL2ludDM0MHhfdGhlcm1hbC5jDQo+ID4gQEAgLTEzLDEwICsx
MywxMCBAQA0KPiA+DQo+ID4gICNkZWZpbmUgSU5UMzQwMV9ERVZJQ0UgMFgwMQ0KPiA+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIGludDM0MHhfdGhlcm1hbF9kZXZpY2VfaWRz
W10gPSB7DQo+ID4gLQl7IklOVDEwNDAifSwNCj4gPiAtCXsiSU5UMTA0MyJ9LA0KPiA+IC0JeyJJ
TlQxMDQ0In0sDQo+ID4gLQl7IklOVDEwNDcifSwNCj4gPiArCXsiSU5UQzEwNDAifSwNCj4gPiAr
CXsiSU5UQzEwNDMifSwNCj4gPiArCXsiSU5UQzEwNDQifSwNCj4gPiArCXsiSU5UQzEwNDcifSwN
Cj4gPiAgCXsiSU5UMzQwMCJ9LA0KPiA+ICAJeyJJTlQzNDAxIiwgSU5UMzQwMV9ERVZJQ0V9LA0K
PiA+ICAJeyJJTlQzNDAyIn0sDQoNCg==
