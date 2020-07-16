Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07D8221BC4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 07:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725270AbgGPFK6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 01:10:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:52379 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgGPFK6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jul 2020 01:10:58 -0400
IronPort-SDR: YySXkUVc31vDCiTVTVIqUhDNkYHCZWI3nZsdi1ZYcdf9ElwJ/DfjvvoIVs/Y8UUSbdHPDWBXzB
 pViqwHgJMLyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="128887540"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="128887540"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 22:10:57 -0700
IronPort-SDR: OYFEqHJiwdKUXq2AcA3T+3GlmMhd8o/gSVtIZoJQRjGbavQz6kuwEDFClFN2RJ1yPwBwtuVHsW
 dkVSrNE/P3JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="300136101"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2020 22:10:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jul 2020 22:10:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 Jul 2020 22:10:56 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 15 Jul 2020 22:10:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 15 Jul 2020 22:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw/lnhiOzlRqKk/4pRwRl/pLuL1ar0QGtcNGpgjzjXPO/LaDFDfBq2OMNfvDu7bZi87UKX/N1cHGKVaWXvanbTp6Qt+WwHcTE5EgUqrQQ7EiJQV6V1JCPNy8kcNetD2cph1YJWycsh+/OWhMt8tuxRnZPevlyp/arQutpAPIu+oo8q7HX9iXxQ+KcGP5pfgZJOQy3X4sKotDqWs8mGF2WJs7Fumg7xWAPkL2Ish7ud91XYMCK5uoocG/JUnRvoVQoPHXNjIeNct7GOHxDSKVt86vTSsSSD1ukt9neOlorJegoNHW/c2xpysuisLcLmgob8cn+JOrTeC4wwEtRjBbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj08Eq4kzpY5drLBv2fgO2hFkPxAKZld2G/IxIp87mU=;
 b=iOrOtRmc0msWFcdrPZuK3TiQRwCmCqmaeJFsmMt1my8/og++HubwCPtFx/hijLIGwqzKJZAqPEyc8op+s6Zn5lKpMMihKiTncDsOcTXHGXarNpqpV5PdtUDguaAwh2uFmFoNb4Cv+ky431aOiw0qXq9uFCv2phsiJs7sNKe5Ve/2vuIAuLnUifuBXbBWDmUoqJBm2wgiwP4rQFfjscQsC1xL6eDjMswElSxFR7j1jIoH8nyOKJYX/15E3g4YlvvLEOCje9BUaiTW/w/vVhMnfgw341CkLVmbqYnu9GU5SxvGUGdxmGiC8po2sUKNzFrH21+1uOC/NmN/Vt3kuQjbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj08Eq4kzpY5drLBv2fgO2hFkPxAKZld2G/IxIp87mU=;
 b=o8BjnoF1xoeQoT6FHNI9+0t70mitfxuQ896Q2DGq0GEVYeVxxe2P9F3R/DsLezMo778B/9jFTYeTghx8COEMZ3FBC3xgmKaD+r4/XqqAG8A/66mC9jSY6+e8a5D+8872uQLPCdNcLbysmXKriVKK3vvrX0bv5LfeDB/vXwpY/Ng=
Received: from BL0PR11MB3363.namprd11.prod.outlook.com (10.167.240.148) by
 MN2PR11MB4759.namprd11.prod.outlook.com (20.180.246.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Thu, 16 Jul 2020 05:10:54 +0000
Received: from BL0PR11MB3363.namprd11.prod.outlook.com
 ([fe80::fcc1:eb92:1f03:8622]) by BL0PR11MB3363.namprd11.prod.outlook.com
 ([fe80::fcc1:eb92:1f03:8622%7]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 05:10:54 +0000
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: RE: [PATCH v2] powercap: Add Power Limit4 support
Thread-Topic: [PATCH v2] powercap: Add Power Limit4 support
Thread-Index: AQHWWbfiWjBrO+3IOUeiOzKQuUxHfKkHD9wAgAC2QACAAeIdkA==
Date:   Thu, 16 Jul 2020 05:10:54 +0000
Message-ID: <BL0PR11MB3363757AEC2CF48D77F68F89BB7F0@BL0PR11MB3363.namprd11.prod.outlook.com>
References: <1594715306-10411-1-git-send-email-sumeet.r.pawnikar@intel.com>
         <CAJZ5v0hYv5TsAWduzaoErS2a2r6dn9vq2t_s4EJ47U7Dz-C50w@mail.gmail.com>
 <ec0336b09ccf932aef6bbe51fed1e79c864c55ea.camel@linux.intel.com>
In-Reply-To: <ec0336b09ccf932aef6bbe51fed1e79c864c55ea.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [171.61.90.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7341fb9-8c46-4009-de1f-08d829469da6
x-ms-traffictypediagnostic: MN2PR11MB4759:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB475962371178D3A74F3F61EFBB7F0@MN2PR11MB4759.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hK3J8GZM0qrxZos71jcK6q2x/FHdASF7z8F5zJFgZ1JxNaoqVcMkvARlty4pmlWwLXL1SFTDJFRaqQmoWnCoZlSMMzH42zsO6dp5kEST5YEp2HoXs+u9zhwx2gtWzRDNiMQQgfXNFR6V9zrmJVYhBmH0Yas0hJbzkyiMms6zAaW3GdzHd7aimpVe3wBG4nVBwY0V2TYGiJSlfrGrdffiohadHtqJhXJ93Nac8dh3mZZEjJG+ypR60Udm92S8OpfKj0elS2MaLiEVsIUUxhwmh7WG0UrTuLj3uo5wCn68bgC9kRx+cezxOg7aXCT4TzIFYi3mQAofxY66DC4uLhOjJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(6506007)(7696005)(4326008)(8936002)(8676002)(478600001)(186003)(83380400001)(86362001)(5660300002)(71200400001)(26005)(110136005)(54906003)(316002)(53546011)(76116006)(66446008)(64756008)(66556008)(66476007)(55016002)(66946007)(2906002)(52536014)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: El54bHILW71T+y/duKfQRXEYYbAyVkdmtAwuaGUo9QB1SzaQqZmQkVWV5g/D8UBgAEoA1RbeuBkRUG/3FJWQjJWoixun8tkEZ77FPjvqz0w5ZeZvC64UOCBc8LjAkWttb1ZYJTcJRa8748eeW4YPrqX2g1S63sRdx5HYejjh4K8e/bBgAf9yIykPVEiUN9zX/z7dbsa4vVSE7ZyiZKLl2fomBK67JAoPIXHl6vRv0OgHVPLb9Np/Bh+5lxrA0mYJRtz8IjHycGXDlUsuX08+QpreZvbAKIGei8ZRW79yzxV0wttEZ3Y44163SWCBu2KWsvCzD2yJchjUei/U5+sYlRSCwteuCrVnzTfssLx9QMjeUGInd8mzM6b4Q+aX7XzBIYe+DuLTBwBRWwgeF4GioS4W2AcMU7XPbibT3g0Q5KCIbCwbR+nXK+pHrluft48FBL0C2R/3zEMYa49by/MXBuOTD366XUdWczvr5KJUxKk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7341fb9-8c46-4009-de1f-08d829469da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 05:10:54.0754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nc7AzU2IfVyGHbm/hzu/LaORMEGzSpve6/H/S5586TJXBdY6aSFsO1OHgXgfqzYk2ibbv+bj3la5Rz0u1sc7TCde+Xbo5v4muN8TG4bMkts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNyaW5pdmFzIFBhbmRydXZh
ZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bHkgMTUsIDIwMjAgNTo0NCBBTQ0KPiBUbzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFl
bEBrZXJuZWwub3JnPjsgUGF3bmlrYXIsIFN1bWVldCBSDQo+IDxzdW1lZXQuci5wYXduaWthckBp
bnRlbC5jb20+DQo+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+OyBa
aGFuZywgUnVpDQo+IDxydWkuemhhbmdAaW50ZWwuY29tPjsgTGludXggUE0gPGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbA0KPiBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+OyBTaGV2Y2hlbmtvLCBBbmRyaXkNCj4gPGFuZHJpeS5zaGV2Y2hl
bmtvQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gcG93ZXJjYXA6IEFkZCBQ
b3dlciBMaW1pdDQgc3VwcG9ydA0KPiANCj4gT24gVHVlLCAyMDIwLTA3LTE0IGF0IDE1OjIxICsw
MjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+DQo+IA0KPiBbLi4uXQ0KPiANCj4g
PiBPbiBUdWUsIEp1bCAxNCwgMjAyMCBhdCAxMDoyMiBBTSBTdW1lZXQgUGF3bmlrYXINCj4gPiA8
c3VtZWV0LnIucGF3bmlrYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFNyaW5pdmFzLCBk
b2VzIHRoZSBwYXRjaCBsb29rIGdvb2QgdG8geW91Pw0KPiANCj4gU29tZSBtaW5vciBjb21tZW50
cyB0aGVuIFN1bW1ldCBjYW4gYWRkIG15DQo+IA0KPiBSZXZpZXdlZC1hbmQtdGVzdGVkLWJ5OiBT
cmluaXZhcyBQYW5kcnV2YWRhIDwNCj4gc3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
b20+DQo+IA0KDQpUaGFua3MgU3Jpbml2YXMgZm9yIHRlc3RpbmcgdGhpcy4gDQpJIHdpbGwgYWRk
cmVzcyB5b3VyIGJlbG93IGNvbW1lbnQNCmFuZCBzdWJtaXQgdjMgd2l0aCBhYm92ZSB0YWcuIA0K
DQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gPiAgLSBBZGRyZXNzZWQgcmV2
aWV3IGNvbW1lbnRzIGZyb20gUmFmYWVsLg0KPiA+ID4gIC0gTWFkZSB0aGUgY29tbWl0IG1lc3Nh
Z2UgbW9yZSBjbGVhcmVyLg0KPiA+ID4gIC0gVXBkYXRlZCBwb3dlcmNhcCBkb2N1bWVudGF0aW9u
Lg0KPiA+ID4gLS0tDQo+ID4gPg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gPiAwLDEpLg0KPiA+ID4g
K0RlcGVuZGluZyBvbiBkaWZmZXJlbnQgcG93ZXIgem9uZXMsIHRoZSBJbnRlbCBSQVBMIHRlY2hu
b2xvZ3kNCj4gPiA+IGFsbG93cw0KPiA+ID4gK29uZSBvciBtdWx0aXBsZSBjb25zdHJhaW50cyBs
aWtlIHNob3J0IHRlcm0sIGxvbmcgdGVybSBhbmQgcGVhaw0KPiA+ID4gcG93ZXIsDQo+ID4gPiAr
d2l0aCBkaWZmZXJlbnQgdGltZSB3aW5kb3dzIHRvIGJlIGFwcGxpZWQgdG8gZWFjaCBwb3dlciB6
b25lLg0KPiBJIHRoaW5rIGJldHRlciB0byBzcGVsbCBvdXQgdGhhdCB0aW1lIHdpbmRvdyBpcyBu
b3QgYXBwbGljYWJsZSB0byAicGVhayBwb3dlciIuDQo+IE90aGVyd2lzZSBzb21lb25lIHdpbGwg
c2VuZCBhIGJ1ZyByZXBvcnQuDQo+IA0KPiANCj4gWy4uLl0NCj4gDQo+ID4gPiAgc3RhdGljIGlu
dCByYXBsX21zcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgew0KPiA+ID4g
ICAgICAgICBpbnQgcmV0Ow0KPiA+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgeDg2X2NwdV9pZCAq
aWQgPQ0KPiA+ID4geDg2X21hdGNoX2NwdShwbDRfc3VwcG9ydF9pZHMpOw0KPiANCj4gVG8gbWF0
Y2ggY29kaW5nIHN0eWxlIGluIHRoaXMgZmlsZToNCj4gCWNvbnN0IHN0cnVjdCB4ODZfY3B1X2lk
ICppZCA9IHg4Nl9tYXRjaF9jcHUocGw0X3N1cHBvcnRfaWRzKTsNCj4gICAgICAgICBpbnQgcmV0
Ow0KPiANCg0KVGhhbmtzIGZvciByZXZpZXcuICANCg0KUmVnYXJkcywNClN1bWVldC4NCg0KPiA+
ID4gICAgICAgICByYXBsX21zcl9wcml2LnJlYWRfcmF3ID0gcmFwbF9tc3JfcmVhZF9yYXc7DQo+
IA0KPiBUaGFua3MsDQo+IFNyaW5pdmFzDQoNCg==
