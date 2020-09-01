Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B1259EBE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgIAS41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 14:56:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:20840 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbgIAS4R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 14:56:17 -0400
IronPort-SDR: YiT4U6pMZvP4dSgHlQtFgVGm2BILPW4tv+LyOE+fSNSugkD9rkzZWhxt0l3E6KN3uHpYnw6RZj
 Is6aMtQzbLcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="156512545"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="156512545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 11:56:12 -0700
IronPort-SDR: QoXp5KTyixeTDDz7JYv6j4Jc0OSftUF+pG0Go1ZFB6ER6CHDxYD70SpH5apLd4zhG18N9pDDWv
 maZPNX5n+pQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="333824042"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2020 11:56:12 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Sep 2020 11:56:11 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 1 Sep 2020 11:56:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 1 Sep 2020 11:56:10 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 1 Sep 2020 11:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1lvv7lpMYBsgqq/km3VYur2hDRp6uaB/d6fkCldhyKQhZHm2Oke6ehMo5RMmiQEZQPRJEPU693QKijWPO0igwLM7P9eN1xAoHgplt8WWfuPsQuaoNxGHsC4stWzGFUqCgLf4Np5LPXwqCWxBF3401DAPPL4HYmJ7kdXKTa1xbZDpHz4xsANfAcBwEBcrf3fFchTgwYUBIm/tV0EVnDFhBjuY0iNK1prIq8xmMbposx5aYEuuX8U7NV8ihKCsToL5y7alMEI5t6nu4XN9Fc8vc21fh/LjEjbvcdVsNz1uWPlIMmEkJDxzH1dOsrceybl95A92CNt2h0EwhN7MJJxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI6IT25kn36EZeY6VYd/fUlTUWGwE0SsaJXPcPPQ8mo=;
 b=aZSR/6bfstoYVIkucI2XxZDiz8Xaob362MV862u6WnlArJdRzo5pAqv2IdMGN4o+/c+QblhgW4DrNAs+YRvqSTneXzMEyPcHhxkxbaW10Rv3YSDEJWxAu/J1yFQ95GSWDMPQyiQHDX/y89/4imGaWcuVYqVKJR1AQaJcOVrtu/QoiUW6PV+FlaD9z9El4+RQo1GC3/Rqa2lI84GeN6CbhHMmBoWGp7woKXEHk6UEFwfp1kNunA423TU4q4tHI6bqHlkRf1mnCSHLQhAGp5PL5Le3tiGui2msabz/y5hAYuKYrj4izY2Z+jJOiBEFCJSRCpZuqYzHZtUqyx262I7ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI6IT25kn36EZeY6VYd/fUlTUWGwE0SsaJXPcPPQ8mo=;
 b=LSZn+ftFe9yGtwKxIaI8+u4zVM1f0+qTEzqS5Tai8ZPu4TzLQAtXVvIO71m8KX/84IsRpsHVHJrGsPKRt5XPVyDSUCEtKHKjk5iYQx4ujn916MP+SqNZVe9bJLtfPNkYH154vT1Vurj8LCLulsOJsAWamAFDRpzmolwplVF03yY=
Received: from BYAPR11MB3496.namprd11.prod.outlook.com (2603:10b6:a03:8b::16)
 by BYAPR11MB2566.namprd11.prod.outlook.com (2603:10b6:a02:be::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 18:56:04 +0000
Received: from BYAPR11MB3496.namprd11.prod.outlook.com
 ([fe80::b5ed:61b7:d992:eae3]) by BYAPR11MB3496.namprd11.prod.outlook.com
 ([fe80::b5ed:61b7:d992:eae3%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 18:56:04 +0000
From:   "Callaway, Caleb" <caleb.callaway@intel.com>
To:     Francisco Jerez <currojerez@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max() for
 turbo disabled cases.
Thread-Topic: [PATCH] cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max()
 for turbo disabled cases.
Thread-Index: AQHWgIxqLo218JeRjU6txkCYoZF8xqlUHMSw
Date:   Tue, 1 Sep 2020 18:56:04 +0000
Message-ID: <BYAPR11MB3496426018632CA8BF51FEC6842E0@BYAPR11MB3496.namprd11.prod.outlook.com>
References: <20200901030250.495928-1-currojerez@riseup.net>
 <81b98c58eab0bf075d9ded2154a7a88020628c80.camel@linux.intel.com>
 <87k0xdwead.fsf@riseup.net>
In-Reply-To: <87k0xdwead.fsf@riseup.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: riseup.net; dkim=none (message not signed)
 header.d=none;riseup.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.12.218.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41257480-3ec6-46d0-5846-08d84ea8adaa
x-ms-traffictypediagnostic: BYAPR11MB2566:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB25668FAAC4BECA79743B1345842E0@BYAPR11MB2566.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhAWQTczgU1Sq1lToL4/5BRtOWaVskL9auH/Wah8imQ3I134TOXqZT5IpDZLUvr1tcQnTvzI/nstsLtMKZNCER/VK1DLFEh2RVnj2TwNff3uC+MIwRLLlPSE++z+qP2HLG4rYfiFQiu3O7/u6KlKsrmTg4RmLdo4AvXZ/g248Or8RLQZfeu68YYH11HUAsdJI2LwSFTYDD5qPayeyzJLbfi+LYHBVvEoZvgRQYRKdveyDmWkC27ogUYJTwUutY2a49iDQU8z7PyAjuzxIUAlab6LeRs1LudJRWMC2Q7MZmbWM9UMH59VXMICEE/IUS6lst9S5HuVRJMHwLUL6S61Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3496.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(71200400001)(478600001)(4326008)(64756008)(33656002)(186003)(86362001)(8936002)(2906002)(66556008)(66476007)(76116006)(66446008)(66946007)(316002)(5660300002)(7696005)(52536014)(83380400001)(110136005)(53546011)(55016002)(8676002)(9686003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: w8rqi/TvL2/x5AlDUkJM/m+5QGxC762qXWht4FHrEOrMDLYq+cbppet758rNuRu5e4cSVWwElhndgm+KgmgN7fDydBjA0NImQvK6FVzQ4ODuvC3BjsIrv7+h2z+AdAELaRmlW8A5OU72LzgNpoh9dvv5SgdERt6txYwjzG9rUq7DfOesqUUUDH9+9+fYYWkSJ8gM9jeOGbw7YqPMGttI3Zm0Td4mkUSqKxUkg25AD/rOkwDJKJbCQfHJ9wBU0Z4ssou2jGpwA89JeSIJTxY0rng/d7JbLax8xcxc3+gtlzkr9NXMILuObs2pyxnRudR0iunlRG8jrNxfqmZ1GKQWM2lY+f0DIwye7Uc+rHBDRbbd6oGrxp+IuiR1Pgu0Gjev+/N07F9j7koEeXQk6yj3YZVckklv01fXToUxT5fzLr78Xe6wVspb8FiDbhhkSXnsrNaYbULzbrDk9UxOLz2ePRVuNsrNDOO+peDa2tOmH2ULtsD3VUZKWFr3CK0OEwuNUGN/Py936a8ai5jGOqumWhAdvLpPfrcg2R8+WFoVIGWFsgXhpl4fR+ClxG/C19CJgjNNBvg0kKPTfYJA+oe13HPFrXlSkYb1UvPFGJUBVoHJDO9eGoIsuCH61Ss5EawzjLDY9fUe5rCSVPM4sTIuZQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41257480-3ec6-46d0-5846-08d84ea8adaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 18:56:04.6500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6be3hi0hEWuAErj2ctRVad7t3Bw+0J1Ha07ffA2vgkqOu7MV75xie60xE6UK+Q0ds4TVOkbRRVVHrQ8W4O0qK3gojaGgwgeVp23kteiZLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2566
X-OriginatorOrg: intel.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgZm9sa3MsDQoNClRoYW5rcyBmb3Igd29ya2luZyBvbiB0aGlzISBJdCdzIHBvc3NpYmxlIG15
IHN5c3RlbSBpcyBzdGlsbCBjbG9ja2luZyB1cCB0byBtYXggdHVyYm8sIGJ1dCBJIGRpZG4ndCBl
eHBsaWNpdGx5IHRlc3QgdGhpcy4gTXkgZ29hbCB3YXMgdG8gZml4IHRoZSBDUFUgZnJlcXVlbmN5
IGF0IDIuOCBHSHogb24gYSBDRkwtUyBwbGF0Zm9ybSB1c2luZyB0aGUgZm9sbG93aW5nIHNjcmlw
dDoNCg0KCV9jcHVmcmVxPTxmcmVxdWVuY3kgaW4gS2h6Pg0KCWNwdV9zeXNmcz0iL3N5cy9kZXZp
Y2VzL3N5c3RlbS9jcHUvY3B1ZnJlcSINCglmb3IgY3B1IGluICRjcHVfc3lzZnMvKjsgZG8NCgkJ
ZWNobyAiU2V0dGluZyBmcmVxdWVuY3kgZm9yICRjcHUuLi4iDQoJCWVjaG8gInBlcmZvcm1hbmNl
IiA+ICRjcHUvc2NhbGluZ19nb3Zlcm5vcg0KCQllY2hvICRfY3B1ZnJlcSA+ICRjcHUvc2NhbGlu
Z19tYXhfZnJlcQ0KCQllY2hvICRfY3B1ZnJlcSA+ICRjcHUvc2NhbGluZ19taW5fZnJlcQ0KCWRv
bmUNCg0KVG8gZ2V0IHRoZSBkZXNpcmVkIGZpeGVkIGZyZXF1ZW5jeSwgSSBoYWQgdG8gc2V0IF9j
cHVmcmVxPT0yMTAwMDAwIHdoZW4gVHVyYm8gd2FzIGRpc2FibGVkIGluIHRoZSBCSU9TOyB3aXRo
IFR1cmJvIGVuYWJsZWQsIEkgaGFkIHRvIHVzZSB0aGUgdmFsdWUgMjgwMDAwMC4gSSBvYnNlcnZl
ZCB0aGUgcmVzdWx0IHdpdGg6DQoNCgl3YXRjaCAiY2F0IC9wcm9jL2NwdWluZm8gfCBncmVwICdj
cHUgTUh6JyINCg0KV2l0aCBGcmFuY2lzY28ncyBwYXRjaCwgSSBjb3VsZCB1c2UgdGhlIHZhbHVl
IDI4MDAwMDAgZm9yIGJvdGggVHVyYm8gZW5hYmxlZCBhbmQgVHVyYm8gZGlzYWJsZWQuDQoNCkkn
bSBub3Qgd2VsbC1hY3F1YWludGVkIHdpdGggdGhlIG1vdmluZyBwYXJ0cyBoZXJlLCBidXQgaWYg
dGhlcmUncyBhbiBhZGRpdGlvbmFsIHN1cHBvcnRpbmcgZXhwZXJpbWVudCBJIGNhbiBydW4sIGp1
c3QgbGV0IG1lIGtub3cuDQoNCkhUSCwNCi1DYWxlYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogRnJhbmNpc2NvIEplcmV6IDxjdXJyb2plcmV6QHJpc2V1cC5uZXQ+IA0KU2Vu
dDogVHVlc2RheSwgU2VwdGVtYmVyIDEsIDIwMjAgMTE6MTkgQU0NClRvOiBTcmluaXZhcyBQYW5k
cnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT47IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZw0KQ2M6IFd5c29ja2ksIFJhZmFlbCBKIDxyYWZhZWwuai53eXNvY2tpQGlu
dGVsLmNvbT47IENhbGxhd2F5LCBDYWxlYiA8Y2FsZWIuY2FsbGF3YXlAaW50ZWwuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSF0gY3B1ZnJlcTogaW50ZWxfcHN0YXRlOiBGaXggaW50ZWxfcHN0YXRl
X2dldF9od3BfbWF4KCkgZm9yIHR1cmJvIGRpc2FibGVkIGNhc2VzLg0KDQpTcmluaXZhcyBQYW5k
cnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4gd3JpdGVzOg0KDQo+
IE9uIE1vbiwgMjAyMC0wOC0zMSBhdCAyMDowMiAtMDcwMCwgRnJhbmNpc2NvIEplcmV6IHdyb3Rl
Og0KPj4gVGhpcyBmaXhlcyB0aGUgYmVoYXZpb3Igb2YgdGhlIHNjYWxpbmdfbWF4X2ZyZXEgYW5k
IHNjYWxpbmdfbWluX2ZyZXEgDQo+PiBzeXNmcyBmaWxlcyBpbiBzeXN0ZW1zIHdoaWNoIGhhZCB0
dXJibyBkaXNhYmxlZCBieSB0aGUgQklPUy4NCj4+IA0KPj4gQ2FsZWIgbm90aWNlZCB0aGF0IHRo
ZSBIV1AgaXMgcHJvZ3JhbW1lZCB0byBvcGVyYXRlIGluIHRoZSB3cm9uZyANCj4+IFAtc3RhdGUg
cmFuZ2Ugb24gaGlzIHN5c3RlbSB3aGVuIHRoZSBDUFVGUkVRIHBvbGljeSBtaW4vbWF4IGZyZXF1
ZW5jeSANCj4+IGlzIHNldCB2aWEgc3lzZnMuICBUaGlzIHNlZW1zIHRvIGJlIGJlY2F1c2UgaW4g
aGlzIHN5c3RlbQ0KPj4gaW50ZWxfcHN0YXRlX2dldF9od3BfbWF4KCkgaXMgcmV0dXJuaW5nIHRo
ZSBtYXhpbXVtIHR1cmJvIFAtc3RhdGUgDQo+PiBldmVuIHRob3VnaCB0dXJibyB3YXMgZGlzYWJs
ZWQgYnkgdGhlIEJJT1MsIHdoaWNoIGNhdXNlcyBpbnRlbF9wc3RhdGUgDQo+PiB0byBzY2FsZSBr
SHogZnJlcXVlbmNpZXMgaW5jb3JyZWN0bHkgZS5nLiBzZXR0aW5nIHRoZSBtYXhpbXVtIHR1cmJv
IA0KPj4gZnJlcXVlbmN5IHdoZW5ldmVyIHRoZSBtYXhpbXVtIGd1YXJhbnRlZWQgZnJlcXVlbmN5
IGlzIHJlcXVlc3RlZCB2aWEgDQo+PiBzeXNmcy4NCj4NCj4gV2hlbiAgdHVyYm8gaXMgZGlzYWJs
ZWQgdmlhIE1TUl9JQTMyX01JU0NfRU5BQkxFX1RVUkJPX0RJU0FCTEUgKEZyb20gDQo+IEJJT1Mp
LCB0aGVuIG5vIG1hdHRlciB3aGF0IHdlIHdyaXRlIHRvIEhXUC4gbWF4LCB0aGUgaGFyZHdhcmUg
d2lsbCANCj4gY2xpcCB0byBIV1BfR1VBUkFOVEVFRF9QRVJGLg0KPg0KPiBCdXQgaXQgbG9va3Mg
bGlrZSB0aGlzIGlzIHNvbWUgaXNzdWUgb24gcHJvcGVybHkgZGlzYWJsaW5nIHR1cmJvIGZyb20g
DQo+IEJJT1MsIHNpbmNlIHlvdSBvYnNlcnZlIHR1cmJvIGZyZXF1ZW5jaWVzICh2aWEgYXBlcmYs
IG1wZXJmKSBub3QganVzdCANCj4gc3lzZnMgZGlzcGxheSBpc3N1ZS4NCj4NCg0KQ2FsZWIgc2hv
dWxkIGJlIGFibGUgdG8gY29uZmlybSB0aGF0LCBidXQgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0
IGhpcyBzeXN0ZW0gd2FzIHN0aWxsIGNsb2NraW5nIHVwIHRvIHRoZSBtYXggdHVyYm8gZnJlcXVl
bmN5IGRlc3BpdGUgdHVyYm8gYmVpbmcgZGlzYWJsZWQgaW4gdGhlIEJJT1MgYW5kIHRoZSBtYXhp
bXVtIGd1YXJhbnRlZWQgZnJlcXVlbmN5IGhhdmluZyBiZWVuIHNwZWNpZmllZCBpbiBzY2FsaW5n
X21heF9mcmVxLg0KDQpIb3dldmVyIHRoZXJlIGlzIGEgYnVnIGV2ZW4gaW4gc3lzdGVtcyB3aGVy
ZSB0aGUgY2xpcHBpbmcgeW91IGRlc2NyaWJlIGlzIHdvcmtpbmcgY29ycmVjdGx5LCB0aGUgY29u
dmVyc2lvbiBmcm9tIGtIeiBmcmVxdWVuY3kgdG8gUC1zdGF0ZSB1c2VzIGEgYm9ndXMgc2NhbGlu
ZyBmYWN0b3Igd2l0aG91dCB0aGlzIHBhdGNoIGFwcGxpZWQuDQoNCj4NCj4NCj4+IA0KPj4gVGVz
dGVkLWJ5OiBDYWxlYiBDYWxsYXdheSA8Y2FsZWIuY2FsbGF3YXlAaW50ZWwuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogRnJhbmNpc2NvIEplcmV6IDxjdXJyb2plcmV6QHJpc2V1cC5uZXQ+DQo+IEFj
a2VkLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4Lmlu
dGVsLmNvbT4NCj4NCg0KVGhhbmtzIQ0KDQo+PiAtLS0NCj4+ICBkcml2ZXJzL2NwdWZyZXEvaW50
ZWxfcHN0YXRlLmMgfCAyICstDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxf
cHN0YXRlLmMgDQo+PiBiL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyBpbmRleCBlMDIy
MGE2ZmJjNjkuLjdlYjdiNjJiZDVjNCANCj4+IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jcHVm
cmVxL2ludGVsX3BzdGF0ZS5jDQo+PiArKysgYi9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRl
LmMNCj4+IEBAIC04MjUsNyArODI1LDcgQEAgc3RhdGljIHZvaWQgaW50ZWxfcHN0YXRlX2dldF9o
d3BfbWF4KHVuc2lnbmVkIGludCANCj4+IGNwdSwgaW50ICpwaHlfbWF4LA0KPj4gIA0KPj4gIAly
ZG1zcmxfb25fY3B1KGNwdSwgTVNSX0hXUF9DQVBBQklMSVRJRVMsICZjYXApOw0KPj4gIAlXUklU
RV9PTkNFKGFsbF9jcHVfZGF0YVtjcHVdLT5od3BfY2FwX2NhY2hlZCwgY2FwKTsNCj4+IC0JaWYg
KGdsb2JhbC5ub190dXJibykNCj4+ICsJaWYgKGdsb2JhbC5ub190dXJibyB8fCBnbG9iYWwudHVy
Ym9fZGlzYWJsZWQpDQo+PiAgCQkqY3VycmVudF9tYXggPSBIV1BfR1VBUkFOVEVFRF9QRVJGKGNh
cCk7DQo+PiAgCWVsc2UNCj4+ICAJCSpjdXJyZW50X21heCA9IEhXUF9ISUdIRVNUX1BFUkYoY2Fw
KTsNCg==
