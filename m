Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D043FD2D8
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 07:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbhIAFW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 01:22:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:27726 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232095AbhIAFW6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Sep 2021 01:22:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="279639179"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="279639179"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 22:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="475961818"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2021 22:22:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 31 Aug 2021 22:22:01 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 31 Aug 2021 22:22:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 31 Aug 2021 22:22:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 31 Aug 2021 22:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKrQzMheVrG5Aas1hLMq8JvodXXzzyx69aL5NZvGcQdTefWS1GbIS3KsmJnBPBckCOfbadfdhWVyVwxpPNK46D02DKfGN8h1PGIeMKVR+9HStIekH0FWeFPJ0Z2knc9QqpYiRaARENXsxxbPhTp2BxGgkUliG2uyGPF0hASiVsheRzO+dfURYtA+jPMHXTdocGU1sa4ZajrnBuF06VGZA8ZbOg/qR+E/WaObpKNnRHKF8rjn03zbI6tirz+WRo8peta7+fc5oE633p1LNxMHhPY9TPB+wy7YFZY7Aapd2UEHqX2JGPUQ+2zXVJDF0zIYUNU4upWsgJjFliI/sM71zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhUHr0+XnHj195owgIyY5aTFknAmuWDGRCnZsiAqYes=;
 b=l4U7EUOmCgMguJqRZ5NWk93e2/R08UCyb5yM9NiuZq2o8lZzg1TBcYEqntO/mPEIvo4riKjfYsCVe0xrQ/2BdkPnjRWXGDI0oop/+B9I+ASESogphgSxu9dPqYSYGtFzWiSm57gfdmIM6dFM7CzTnrR5g8xBNxSrzUSVHCA7Uf7sMEe5FT0dU1YT6pVeYpAVUI9O9slLNiHyG5hhPL2yNlcpqbkWVDdbjO4JKMYVIOiTxJtZrAu3ymabmee9bSfmpaiMgkwerhm6kzZc1/Ak+8wvaSYwwR5JRljJy9UOcXoe8sSMbz2UMhZDlxtti2O58+H9/wjmNpVwrhV1o4MpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhUHr0+XnHj195owgIyY5aTFknAmuWDGRCnZsiAqYes=;
 b=shCfP8+lm3xLu2Pghi8isC0PhCCXPaxfzzl8nK2VK+OFWiFkLRrty/kLj0cTdkD3eSeKIT2tSDdvEUwyI2B8hZdcPTsbMCWRT5LKgRYH94Q9Qkgh83OL/NMH9S9lHb0016XfFVCOBUdmdVRtHlfzIeo22teGq70dEfOaM4t66L8=
Received: from BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26)
 by BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 1 Sep
 2021 05:22:00 +0000
Received: from BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::7426:7b96:b9b9:6882]) by BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::7426:7b96:b9b9:6882%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:22:00 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH V6 1/1] interconnect: intel: Add Keem Bay noc driver
Thread-Topic: [PATCH V6 1/1] interconnect: intel: Add Keem Bay noc driver
Thread-Index: AQHXnjKFvPGsOLQFu0yhd4mKaNMQ96uNyniAgADbP8A=
Date:   Wed, 1 Sep 2021 05:21:59 +0000
Message-ID: <BYAPR11MB35283C11295BCBEB4DA5C39CE1CD9@BYAPR11MB3528.namprd11.prod.outlook.com>
References: <20210831063615.1021-1-pandith.n@intel.com>
 <986f25c1-a6ce-f142-018b-88ee0c237943@infradead.org>
In-Reply-To: <986f25c1-a6ce-f142-018b-88ee0c237943@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1738604a-bf74-4920-e947-08d96d086cb7
x-ms-traffictypediagnostic: BYAPR11MB3141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB314124D4E90E70CA6FB999BFE1CD9@BYAPR11MB3141.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5BpbrHUYSDHn9y92ZwuOUs0PcPeumd65y+9dn3aIYIxoXJOetuFF+X+desmzrKd3fVWmLAVvKRgeHe8b1X/npzJvMV22hIK7JUhCf9w/Vko1bketRUoBEqOJKI4CxBb61qAzeD7t/PVKqOl7yJ8EqlY3wgbbzYvmSPdajarwnttMlJl7/Edi8EX4cjUSZx/j9RcbXPY0vRFasNtF/quxOzcKilN9rVDzt+S/SMQh0gmpKpUQl7f/hpuOUZgNDRIjqTiXb3+5tVvGZlCaMBY6ml5sU3N67aXvCWque9F2rmQTolzs/sB0IqBlK4+Ji4KOIZxq9qWtZL/xjNfEmhhRWt+K9Wz95HBTJVwY1aM7JYrOi7wURpUmvD7ioLZmT6o8eTsvBV8QYUZLeJWjgZrnEqBtu4ydI2u5TPtqoWCNa/1KgQGzKjIifvxiM/kKkYN2yyeUeqlrXGKw9XTo9oJGOo1g4fcD+beNrJSvsQp9RFikAKfJLSL51UHBhtnHlq9LhgUOz6JbIc02k0/jR26rIRWvqJSBOW3QgKZAYnH1ycOEc6qw1oEFu/DNAV9eU7BVuFDWKxB7a6aNOLmKeEFAfRQZmhD0onlDXRGp9kZUiSxA5c8361wnTLx74qMOAndxltjMthYkTG0Aw3h9Kv49fD5tz9WQQtimucH733gB1Ghm7DcsP1EQyu7FDvKeDmVnwLg3sZ3iLbuK7t07ykojkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(122000001)(71200400001)(86362001)(55016002)(6506007)(2906002)(316002)(33656002)(55236004)(54906003)(83380400001)(66946007)(66446008)(8676002)(64756008)(38100700002)(508600001)(76116006)(4326008)(110136005)(7696005)(9686003)(66556008)(8936002)(186003)(5660300002)(53546011)(52536014)(26005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWZKU1pJcWVjNVVMcXprU2l4Mm42Y2RselNRSDc0a1pvaVBPeE5CUFZxRCtz?=
 =?utf-8?B?ZjZWa29hS0xjQlQ2eUNEdGhHUlhLZWVkK2xjMlV3dnhvV09lYXY4QXBxcEhX?=
 =?utf-8?B?NlJNMVFYUlJNVm00YjNoTk01NmxOUGN4SndkakNXNlhHemlxTllEV0VJTVow?=
 =?utf-8?B?V1JvMTVBMGdPSENRM1ZKSys3V2ZmZStJNTQ1Zzg4NGJ6TVZSTlBvZWlyMDdP?=
 =?utf-8?B?UmF3aXBLWVpUVWdRR09EWDk5dW9ZWVYvM04ySU5RTzZPd3FXM29JY05ncWs0?=
 =?utf-8?B?YWJtME5CWURCMm1rMEhGcDl3by9xRlJYcFRwbFVLbDg2bHVXblhXbzRoL3VK?=
 =?utf-8?B?eXV2TTM1TkJuaVJzaHF6NHhRbitxRnlGNnk5SHpGTHBsRHdiem9oaVdRSXU3?=
 =?utf-8?B?RjZReE96UW1mNCtaV2swamxDZ1JZVzFCVmFObTgzb2dvem5Ud0EzSCszTGFj?=
 =?utf-8?B?b0J0WC9veTV4aFhDa3E0K3JUT2s4VkRQaEwxbXgvUHpIZ3R4YUZ4Nml5eHQ3?=
 =?utf-8?B?dmJEMGhlc000blpNVnBBYTNXTy9WRUx3cW50YzRsLy9ueDBZWkRwMDBTdmgy?=
 =?utf-8?B?SXpNSk1hL3FjOWozMmwzK09GRnpLNDVpdHAzWWgzajZTRnlHMXowUnE1bm9h?=
 =?utf-8?B?V2VscXluK3dKejIxbFJtVGdBaHRwaE5iZldEam1QdEozNDFiS2dlRUUrMkJ1?=
 =?utf-8?B?MzBYTDNPcTF5Nmpzb1VPbFFoWmNybkFYb1lFZ2toNXRvOG9JbDBmMDJiSmw3?=
 =?utf-8?B?WXVmR3FNTmRncjkxbGxNSnVIcFV3Y2gzTkxxUTJmYnZORWFJYjVPRjl5a0tY?=
 =?utf-8?B?cmlrTnNZMmkrUDNHNExZdWlGLy9Fd3YwOHdsdXRaWlZ2NURlR01wV1BDK0pO?=
 =?utf-8?B?bG5yRHFtdytvMDBQRGcxZDYwalVvbGtZbUxMUWpuOUsxZ2cyTTRiUUI2MDBC?=
 =?utf-8?B?ZW5id2xjWkpHSXNid0VpVStJSnVTdU1CS2FodVplb0c4dzlwOEpnREhHRzVo?=
 =?utf-8?B?R3NQaitXUzlLQUh3SEQ3bXkyTUZYNXN3Rkh4YnlVcHF0RlFIOWZ5TlFYbGEz?=
 =?utf-8?B?ckJWRFIzR3RWWERMM0Y4YW9EZkdhWFNoSnFjaHA4bXo1RTRYMDZjRFdpZGdB?=
 =?utf-8?B?TVpUVXYzYWdCMmZ1TWs4TVdtelpkOGxNOEtEcWlMTDY2VFNRT2Q1ZEV0UE1D?=
 =?utf-8?B?UVc0SXRlZDduWXMzbElvWnlpVUIvZzYwYkpEZEZsQWJkZ3ZERTRNMEdYaFU1?=
 =?utf-8?B?VVE5TmdDVHEvV3ZvaFBEK1plVUFTNEZoUGdlZE1sWHpBd1F3RCtheTVEU1Zy?=
 =?utf-8?B?Vm83RWZFMG81cVdIUlBYdzFHRDlXb3E0enV3aGRBVlRLWVJJamhRZlhZSGdy?=
 =?utf-8?B?emt0a2JmWTJDbUk5L3E2UHZQa3RPMFFNTDZ1WEdZWGxxdnNhWXpnbWtxQkUy?=
 =?utf-8?B?bElXRVlpaTZJdW9MVmYvQ2J2eVBLQUJhb2FSV3JPT3FieXNLVWliTWhiUTZD?=
 =?utf-8?B?c0VvaTl2eGFvUkNWYU5KdHhhOGVWRk9uTUlQeWVRSStLMStwYXV5VmdVNzZG?=
 =?utf-8?B?M0JIbGJaQjkxcXJXMnc5bnlBM3NUd2RlOStoQ2JLRjhPNkxxRDA2RTRNYW9F?=
 =?utf-8?B?Zzh0bEIvUVEyTlc2Kys5WE9sU3ptbC92NitBQ1c5cWVvb3FrNkVISHRtRjg1?=
 =?utf-8?B?cGZhcVJzcjFTZFpUZ2tEbGhNUEFSV3NHMGpTNVJzUFRtd0JiOE9yU1hqbThr?=
 =?utf-8?Q?ToQtkFvrY8FcWje64zWmK6GAZRu7EqT1uIlcEaa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1738604a-bf74-4920-e947-08d96d086cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 05:21:59.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqeng6vgLA10+94D99IekUMv299DFynVom8eMvsTGEsKkL6IxQG0EfyrL7VCIJ4uIp7sUpPDcnZBIY4/z4/hQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3141
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYW5keSBEdW5sYXAg
PHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDMxLCAyMDIx
IDk6NDYgUE0NCj4gVG86IE4sIFBhbmRpdGggPHBhbmRpdGgubkBpbnRlbC5jb20+OyBnZW9yZ2ku
ZGpha292QGxpbmFyby5vcmc7IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG1ncm9zc0BsaW51eC5pbnRlbC5jb207IFpob3Us
IEZ1cm9uZyA8ZnVyb25nLnpob3VAaW50ZWwuY29tPjsNCj4gU2FuZ2FubmF2YXIsIE1hbGxpa2Fy
anVuYXBwYSA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVsLmNvbT47IFJhamENCj4g
U3VicmFtYW5pYW4sIExha3NobWkgQmFpIDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNiAxLzFdIGludGVyY29ubmVjdDogaW50
ZWw6IEFkZCBLZWVtIEJheSBub2MgZHJpdmVyDQo+IA0KPiBIaS0tDQo+IA0KPiBPbiA4LzMwLzIx
IDExOjM2IFBNLCBwYW5kaXRoLm5AaW50ZWwuY29tIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2ludGVyY29ubmVjdC9pbnRlbC9LY29uZmlnDQo+ID4gYi9kcml2ZXJzL2ludGVyY29u
bmVjdC9pbnRlbC9LY29uZmlnDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLmEyZjkzMzc3MzM4MA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9k
cml2ZXJzL2ludGVyY29ubmVjdC9pbnRlbC9LY29uZmlnDQo+ID4gQEAgLTAsMCArMSwxOSBAQA0K
PiA+ICsjIENvcHlyaWdodCAoQykgMjAxOSBJbnRlbCBDb3Jwb3JhdGlvbiAjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOg0KPiA+ICtHUEwtMi4wLW9ubHkgY29uZmlnIElOVEVSQ09OTkVDVF9JTlRF
TA0KPiA+ICsJYm9vbCAiSW50ZWwgTmV0d29yay1vbi1jaGlwIGludGVyY29ubmVjdCBkcml2ZXJz
Ig0KPiA+ICsJaGVscA0KPiA+ICsJICBTdXBwb3J0IGZvciBJbnRlbCdzIE5ldHdvcmsgb24gY2hp
cCBpbnRlcmNvbm5lY3QgaGFyZHdhcmUuDQo+ID4gKw0KPiA+ICtjb25maWcgSU5URVJDT05ORUNU
X0lOVEVMX0tFRU1CQVkNCj4gPiArCXRyaXN0YXRlICJJbnRlbCBLZWVtIEJheSBFbmFibGUgRERS
IHByb2ZpbGluZyB1c2luZyBOT0MiDQo+ID4gKwlkZXBlbmRzIG9uIElOVEVSQ09OTkVDVF9JTlRF
TCB8fCBBUkNIX0tFRU1CQVkgfHwNCj4gQ09NUElMRV9URVNUDQo+ID4gKwloZWxwDQo+ID4gKwkg
IEVuYWJsZSB0aGlzIG9wdGlvbiBmb3IgRERSIGJhbmR3aWR0aCBtZWFzdXJlbWVudHMgdXNpbmcg
Tk9DDQo+IA0KPiAJICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE5PQy4NCj4gDQp3aWxsIGNoYW5nZSBpdCB0byBOT0MuDQo+ID4gKw0KPiA+
ICsJICBBZGQgc3VwcG9ydCBmb3IgTmV0d29yay1vbi1jaGlwIChOT0MpIGluIEREUiBTdWJzeXN0
ZW0oRFNTKS4NCj4gDQo+IAkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFN1YnN5c3RlbSAoRFNTKS4NCj4gDQo+ID4gKwkgIERTUyBOT0MgaGFzIGNhcGFiaWxp
dGllcyB0byBlbmFibGUgYW5kIGdldCBzdGF0aXN0aWNzIHByb2ZpbGluZy4NCj4gPiArCSAgTk9D
IGRyaXZlciBlbmFibGVzIGZlYXR1cmVzIHRvIGNvbmZpZ3VyZSBhbmQgY2FwdHVyZSBOT0MgcHJv
YmUNCj4gPiArICAgICAgICAgIGNvdW50ZXJzLCBuZWVkZWQgZm9yIERTUyBiYW5kd2lkdGggbWVh
c3VyZW1lbnQuDQo+IA0KPiBJbmRlbnQgYWJvdmUgd2l0aCB0YWIgKyAyIHNwYWNlcyBpbnN0ZWFk
IG9mIG1hbnkgc3BhY2VzLg0KPiANCkFjY2VwdGVkLCB0YWIgKzIgc3BhY2UgaW4gbGFzdCBsaW5l
IA0KDQo+ID4gKwkgIFNheSBZIGlmIHVzaW5nIGEgcHJvY2Vzc29yIHRoYXQgaW5jbHVkZXMgdGhl
IEludGVsIFZQVSBzdWNoIGFzDQo+ID4gKwkgIEtlZW0gQmF5LiAgSWYgdW5zdXJlLCBzYXkgTi4N
Cj4gDQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg0KUmVnYXJkcywNClBhbmRpdGgNCg==
