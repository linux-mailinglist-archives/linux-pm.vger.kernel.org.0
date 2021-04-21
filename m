Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426CD366B5B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhDUMz7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 08:55:59 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:33643
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233932AbhDUMz6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 08:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CC/b2PS7aUiUqo744qOeqQ354+eyhOL7X6LOBLu4aio0y/2XbIPsUsyMW9cZLA7FRB7a5AnjRJGxdMA50/oNhV3hBwUYxx73L+adC2mAOrIQ/ukAWX7iPP6TxPIHOyLvWuh8xtspY400cuDWrSWvZF2ya5SPsf+4RVvFzYlDmt6q90L/YC7x0Ez47HVZCBcTWel8ksu5YUD/y6E3YdhmLU6flTu2iy+rl+dy1UacFtG6UJO6HgZk/TtkICdkLJEN79BxWddWdENtZciLg4FMI2NHioIyj4t9VE5aNRkeQAie93yBrtdVqwrj2PDcDjJUAXfHiQIeAVw98CQnCNCHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy1LYzs8uC64ANtO1ePiWYreAA9Z+i0Wa1SSz9Cme4w=;
 b=JsoDTLudaSQ7Y2sZ8BzOnkskKfwIPuTX7ZMCQAqDQztYS0UQumKQPe8jFknc50C8Y3xK5xfZEcqjO47i99qdt60JIuXyP3saNiaDY2y/FAM/jtUhnLvKyKhPCdTTSqS9WwaCT1FOgUJM/GW6z5+ftjD8E4exEAEhDLEl3nJvnvtNVlI/0ZzvtvCoNc2dldRwVPTU9ZiX74V1v9nhyoJv398s11wFjqmLJ9ip/0Cw1SC5NKy0hiHoE9s/n9jiv2WX9H6odtfDs9z4OXRtV3g9vhf69Ef8g9McMf5NGphA8vnHNZLZJK31/IOksSYDYpy3kgRhTkc28FxphKgUTdoq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy1LYzs8uC64ANtO1ePiWYreAA9Z+i0Wa1SSz9Cme4w=;
 b=UDLMFxBjgauEngknFnOPWDGZNAIW5zK2CFK81OfleCAGQhhr8lGG4m1RPUJFu4QKLmzXki9/xvmQ5YxVkQHYzuJpKdKKlvPtuD0GaXxHX5H2wIZxUnngdMaSgHk4qW0l2IrGM5XtXP7kjtO6/ZW89ISSL+1JWehqFSgiS2KFvH0=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Wed, 21 Apr 2021 12:54:30 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f4d0:ee66:d5fb:9cdd%3]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 12:54:30 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
Thread-Topic: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
Thread-Index: AQHXH+xi61CpXgfyeUm0V+UG1OxzHKqRmVoAgAAF/ICALWwlmoAABUKAgAACggCAAAfWgA==
Date:   Wed, 21 Apr 2021 12:54:29 +0000
Message-ID: <d434f4abf974cccfe51132c37c35843b1bbc2b77.camel@fi.rohmeurope.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
         <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
         <YFn5CSB1O3i+SzgR@kroah.com>
         <da0233f3223d7c0816581afe0969caf0abe20378.camel@fi.rohmeurope.com>
         <96935c55-c799-595e-024c-56fd352f279e@redhat.com>
         <2f6d096c30a6d1d22422cf9c3553d74132f75708.camel@fi.rohmeurope.com>
         <171af93e-e5be-b35f-23d4-0ccf37062902@redhat.com>
In-Reply-To: <171af93e-e5be-b35f-23d4-0ccf37062902@redhat.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e6cd9b9-d1e3-4872-bfec-08d904c49a64
x-ms-traffictypediagnostic: HE1PR03MB3162:
x-microsoft-antispam-prvs: <HE1PR03MB3162E46E72F1073FF759BC1DAD479@HE1PR03MB3162.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oddVuGClWWceGn7iLsqmtc+Fwdw7sChZm2dsek0z2f539EYzn7qtphomxZRt08SnRClSJAzv3U6J6vuUkwDPPL+cL/erXe+IeK/3+/EThLHKs/9VmayPZKWUlxKKTR325Jpk01gIbWKWpcJdsNY4HiGExPbxuECFmyBajUZiO+QO3r2h+QtSOYsQglaECXUUI0eFp93/kkCBflsl1gZYCRoGPNPxiCd3WsPpa8BqI0Md+SMk/dygaVmyB1ihppdclp4aokYFKr/n9fGLAxBIcllpGd/XRUXwtkjj4oQcG1sIFvlmNI6GKbZeyG8kOWyx5rstcSaJarrvi1xlmQvICNkD6ksNWkmY5Dw2Vgm7uobaCpo8BkRTFgHGcGjK4zZnmG2q3BCgYN8z6VsBc4OSAedNRt8bz7ONeOwm/3Fpki4Wm06C6TlE6yLLygfCUAidLE++5E9/vJQya6Laq0HQQSMEPwtj/ozLM5uucgVele/r4WW3knlUmw69Vr6g7C7upJGzp1Blf+ArO6kBm+4GT6ywNbCVOFP2LYoGf+Px+oxyyhD5Nz+1m6Bu4zBUZtb6XoDV6R0yF8EY2ZhxnnILEZ906n2XM1lvDOz4OxTjGeQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(396003)(366004)(136003)(2616005)(5660300002)(54906003)(4326008)(6486002)(110136005)(8676002)(8936002)(86362001)(122000001)(3450700001)(38100700002)(2906002)(66946007)(66556008)(64756008)(71200400001)(66446008)(478600001)(76116006)(7416002)(6512007)(6506007)(53546011)(316002)(186003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dEN4a3EveTBOVk9VUUxMb3RveVllZExpU1J0dlZjWHhZcEhlNFdSZUJ6eHZE?=
 =?utf-8?B?ZUdhSFhLZHdMdzRyeDBlMG5EQ1hzSzc1eFhhOFdnR0NjYm42cUdzTEllcjdS?=
 =?utf-8?B?UzEzYWFZV0NyNFJPWThiYmdJdkExa1FIN3ZGbSt0VVZ0YmIyTFN1cnd2MHJo?=
 =?utf-8?B?RjhFN2xuK0l4UW1Pejg0VG5SUnNmOGhMUmhMelpsNVU0UFNFN0hBcTcrRWVZ?=
 =?utf-8?B?ZTg1dTNOK29VVVZqN3dzZHhzdzZMbHNlZ2crRWIrbk9yOHVYaFQvc204VUh2?=
 =?utf-8?B?VThpRm1sb2xxTUNSRFFCN0xnTTNTTGlSamgzN0JqWm9xY09Oem1SWWg3dlNQ?=
 =?utf-8?B?aVZWeTNjMDdMSkxHMVgwOURKdHc1YTBhRzl1QjJpRXNqSHhtL1BFZjJ1WTFh?=
 =?utf-8?B?bkVRSXlpVUxxemQ5dXFYN2xCNElET1BFUEJrdUNMWnhRNzlNSnBqYk9EOGJL?=
 =?utf-8?B?OVRyMCsyQlU2eVJFdGZ2OFQ2MXFGYlhPcUtMVE13OWhFQlFNS0FyKzVYMmFw?=
 =?utf-8?B?dG1ONjFUckxLYzdkSTNGY09jVis2c2J6bmVTaDI2RHdsTW44WmhlQVdLZGdP?=
 =?utf-8?B?UTRiM3Ftd3JvY1JYTVZjNzRCOU5LMUNKQmRrcXY0YmwwU2lVK2JTRTU3UENm?=
 =?utf-8?B?TmUwQ0krUE5uTUx5MzVqaTZkcXZYd1pPVjd0KzdJNTFYVW53UW1GbFpmcDFN?=
 =?utf-8?B?VWVSOU0vdEh1VTh0dmRXYUtyRGJCUlc1N3NWQ09VaFo2Z091VUpxUjZIcjNV?=
 =?utf-8?B?MXlJYnd0TXhuSUlWMDhKbys2bEtFQmdUY0RZZXovUU5VWVlFYlNUZWthdldk?=
 =?utf-8?B?YmdiNlErWHlHV0VLWTYybllZeHF2dUNRMHd2UnVPeHhUUWl5azZNNlNFeWpX?=
 =?utf-8?B?c0IrbklNYk1YZG9xTTc1ZkwydGswSzRVUDlNajMzeitYZ3RUNk9lbTJ4bmUv?=
 =?utf-8?B?czNrNVBhODNPTG16SXRkOWpGU20zRDZCbWFNR1NtU2NmRDJmSUN3SHNROXcr?=
 =?utf-8?B?V3lXYzlNSWZ0UjhSSEk2VFFBVFIrVXZibEk1YnVpT25aWWtlcWVOcXl2dmxn?=
 =?utf-8?B?clhxei82V1VoNnRyRFNObFcvZXFrazZjUzdIYkVzdG43Y09uS3ZxOWJ2Uy95?=
 =?utf-8?B?VDNSdG5TRlVVWkUwemQxT3BrV0JydTFPRzA5LzZWUDNNbm5IQU9GUTJRM2Vp?=
 =?utf-8?B?NWJkRHVwWjNrWUUvbVJYM2ZMcnVzSnJaUUZPS0VFeklaY3lzNDNBcGZ0a05F?=
 =?utf-8?B?Um1MR0dMczRVYzJUT0JUWjRFNUZ4OUx6SlpHcitBYVR4Sis3cUNIYTRSYWNp?=
 =?utf-8?B?c09ZNG4zTjU1SEdmNFJZdG9GcEJtc0xqSnZ2azZxbC9pSnpsRDlzaEJkamt1?=
 =?utf-8?B?d3d3bnhUYko5am1yZ1hqVTZPSWRZNW94K2xUc3VOc2ZVSE1VZVZ6eDh3Umhu?=
 =?utf-8?B?aGgrUWpIYzdHU3lRNUdGSWIxZ2ZxZFlORDdHRmtnc3JTY0JabURoOUR2VU1H?=
 =?utf-8?B?VG1aN1U0SXRLazJ5aXlGc0tlYVBSM1NyQS9BSDgyVjVNM1dZUGVEUmV3cjFy?=
 =?utf-8?B?RVFqdmZ2YnB5VXgvVHlTODc2SC9ackl5UWlqMGVWSVNTSTZseW1DZmRsMXBL?=
 =?utf-8?B?RkNCNzFGdlJrc3B4eTlmRGNSMkZLYmcrS3pCUnlQV1Z3SGd5Ym4yc3RFZFBa?=
 =?utf-8?B?TGRHYzlmczNQcTZwVmlLV0tVUWNjbDJqRmFDaWRVOUJYc3NhNnFsOU5DRC95?=
 =?utf-8?B?UjBpbDVZajZmdGsyU1AvUkZxNlY4S1EvZXBmR1liUWhuajQ3UmVQNWpFM3kv?=
 =?utf-8?Q?J+MttdVGPiGnwcTCH1w+u5mdxGTmWwAd3INvU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A11924D40180CA409E1B82226A98158E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6cd9b9-d1e3-4872-bfec-08d904c49a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 12:54:29.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0uProzUlzNNqaKbgz/RxQAgAzRZNyujPkIjmVnh7FIYZQhgJTn5Ep4GU+LKTTHes5sOXnX28NhKYLB7anos91OvCfB37DfXA4skVetA+If/YJ6pRS9IB28JDRRt3Ypt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3162
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gV2VkLCAyMDIxLTA0LTIxIGF0IDE0OjI2ICswMjAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIDQvMjEvMjEgMjoxNyBQTSwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToN
Cj4gPiBPbiBXZWQsIDIwMjEtMDQtMjEgYXQgMTM6NTggKzAyMDAsIEhhbnMgZGUgR29lZGUgd3Jv
dGU6DQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gT24gNC8yMS8yMSA5OjUxIEFNLCBNYXR0aSBW
YWl0dGluZW4gd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAyMS0wMy0yMyBhdCAxNToxOSArMDEw
MCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIE1hciAyMywgMjAyMSBhdCAwMjo1
ODoyOFBNICswMTAwLCBIYW5zIGRlIEdvZWRlDQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
PiBIaSwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gMy8yMy8yMSAyOjU2IFBNLCBNYXR0
aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IERldm0gaGVscGVyIGhlYWRlciBjb250
YWluaW5nIHNtYWxsIGlubGluZSBoZWxwZXJzIHdhcw0KPiA+ID4gPiA+ID4gPiBhZGRlZC4NCj4g
PiA+ID4gPiA+ID4gSGFucyBwcm9taXNlZCB0byBtYWludGFpbiBpdC4NCj4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+IEFkZCBIYW5zIGFzIG1haW50YWluZXIgYW5kIG15c2VsZiBhcyBkZXNp
Z25hdGVkIHJldmlld2VyLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFVsdGltYXRlbHkg
dGhpcyBpcyB1cCB0byBHcmVnIHRob3VnaCwgc28gbGV0cyB3YWl0IGFuZCBzZWUNCj4gPiA+ID4g
PiA+IHdoYXQNCj4gPiA+ID4gPiA+IEdyZWcgaGFzIHRvIHNheSBhYm91dCB0aGlzLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IENhbiB3ZSBtb3ZlIHNvbWUgb2YgdGhlIGRldm1fKiBjYWxscyBpbiBp
bmNsdWRlL2RldmljZS5oIGludG8NCj4gPiA+ID4gPiBoZXJlIGFzDQo+ID4gPiA+ID4gd2VsbCBz
byB0aGF0IHlvdSBhbGwgY2FuIGJlIGluIGNoYXJnZSBvZiB0aGVtIGluc3RlYWQgb2YgbWU/DQoN
Ci4uLg0KDQo+ID4gYnV0IHdoYXQgY29tZXMgdG8gbXkgKG5vdCBhbHdheXMgc28gaHVtYmxlKSBv
cGluaW9uIC0gbW9zdCBvZg0KPiA+IHRoZSBkZXZtIGZ1bmN0aW9ucyBpbiBkZXZpY2UuaCBhcmUg
dGlnaHRseSByZWxhdGVkIHRvIHRoZSBkZXZpY2UNCj4gPiBpbnRlcmZhY2Ugb3IgZGV2cmVzLiBU
aHVzIHRoZSBkZXZpY2UuaCBmZWVscyBsaWtlIGFwcHJvcHJpYXRlIHBsYWNlDQo+ID4gZm9yDQo+
ID4gbW9zdCBvZiB0aG9zZS4NCj4gDQo+IEkgYWdyZWUgd2l0aCB5b3UgdGhhdCBtb3N0IGRldm1f
IGZ1bmN0aW9ucyBpbiBkZXZpY2UuaCBhcmUgcHJvYmFibHkNCj4gbGVmdCB0aGVyZS4gTW92aW5n
IHRoZW0gd2lsbCBhbHNvIG1lYW4gbW9kaWZ5aW5nIGFsbCB0aGUgZHJpdmVycw0KPiB3aGljaCB1
c2UgdGhlbSB0byBpbmNsdWRlIHRoZSBuZXcgZGV2bS1oZWxwZXJzLmggaW5jbHVkZSBmaWxlDQo+
IHdoaWNoIHNlZW1zIGxpa2UgbmVlZGxlc3MgY2h1cm4uDQo+IA0KPiA+IE9UT0gsIHRoZSBrbWFs
bG9jL2tmcmVlIHJlbGF0ZWQgZnVuY3Rpb25zLCBzdHJkdWIgYW5kDQo+ID4ga21lbWR1YiBtaWdo
dCBiZSBjYW5kaWRhdGVzIGZvciBtb3ZlIC0gdGhvc2UgYXJlIG5vdCByZWFsbHkgImRldmljZQ0K
PiA+IHRoaW5ncyIuDQo+IA0KPiBJJ20gY2VydGFpbmx5IG9wZW4gdG8gbW92aW5nIHNvbWUgZnVu
Y3Rpb25zIHRvIGRldm0taGVscGVycy5oLCBidXQNCj4gYWxzbyBzZWUgYWJvdmUgYWJvdXQgbmVl
ZGxlc3MgY2h1cm4uDQoNCkkgYWdyZWUuIFdoZXRoZXIgdGhlIG1vdmUgaXMgd29ydGggYWxsIHRo
ZSBoYXNzbGUgZGVwZW5kcyBvbiBob3cgbXVjaA0KR3JlZyBfcmVhbGx5XyB3aXNoZXMgdG8gZ2V0
IHJpZCBvZiB0aG9zZSBkZXZtIGZ1bmN0aW9ucy4gRXNwZWNpYWxseSB0aGUNCmFsbG9jcyBhcmUg
dXNlZCBfYSBsb3RfLg0KDQpCZXN0IFJlZ2FyZHMNCgktLU1hdHRpDQoNCg==
