Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA331BA0C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 14:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBONNP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 08:13:15 -0500
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:63670
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229666AbhBONNN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 08:13:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrD9Y8tgN/i4xOA5O44hJt0FgWLqFGjw0cRQniwOYpQTWyNh+OToE5wGrLS5QTBc14FyfVD5JH5sHfHb0/jUcbURzYYQiTEqcf5t379ccNdvyyWIsvORQzezSAWnlYCq7hKq+tL72BGMqosRR3tAEnY7wz+BHzisY1XiDIPuvAowWDAD41ox9Mg16I4E3UwETQeFxINXYG4N0N+RyJ/dnCyUjnj/YCXlbHif/0zeCgXBOIV3FDBOGhYISRkPfrytBAOvSoUbyjqK4ma9TETDPJ0AjWJ656RqB2lz4W87VxbShHYtXBV3vXLisWLSNyfrvheJ/dOgcoL/LU7oENj/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTA/NY6y0/7Eh5M03eXP+Oa1sJ3hsRn9vLhE1HUj6bE=;
 b=oehJh1EAbNJ2evFAUHZvjSaQBdvdt79s3bMm8hT0DMnOrlCxW0ILAsGSP5RLTnowHKY49vZWQLJaK2t5KnErN2NRDC8zZltt+gZ7W12CRDAfMgN83YvwRwq4GglZGDy+B8UFbrMtvp28AXqsIlrHpLw2ghjVcfgfp23KT8S3N2SbM8zqY6ERR9NVwl9RRXxEATL6aTw6pjF4Uh52SgFsKclf1IiU1WPTrUQpJSQkQr6Uy+MQQliePrIvqdbuuoBUxYNMLjlcR8LA5B0NTlXj6nQMzpjTkOlUnu6pdQkQVtLWLrBF9/WGeFqdiPe8apWui+mwtEghLULr2SZ15TpYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTA/NY6y0/7Eh5M03eXP+Oa1sJ3hsRn9vLhE1HUj6bE=;
 b=tbK8UVz6dJpp4HBqmI83FZWfThvUK4Rkxz5iDq7ZSlxnbT+fI74JIGW79jEGh3M6gFtDmlTy46tjFZz7F+IXSkUiZO0Tt2UXCfL/UFLIpzuI7GueIF/mthU1zVkWCd7EnH7byhb3dO7M0LRryQC0G09U8tb3N+evuYV8+/OxZ+w=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2889.eurprd03.prod.outlook.com (2603:10a6:7:5f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38; Mon, 15 Feb 2021 13:12:17 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c18c:4a01:ca24:78c1]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c18c:4a01:ca24:78c1%5]) with mapi id 15.20.3846.038; Mon, 15 Feb 2021
 13:12:16 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "saravanak@google.com" <saravanak@google.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Thread-Topic: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Thread-Index: AQHXAf+bFCY4blJH0Uy048cUlqVjwKpWLt8AgAAGsYCAAAjjgIACk9QAgAA21ACAAA8RAIAAA3iAgAAYuQA=
Date:   Mon, 15 Feb 2021 13:12:16 +0000
Message-ID: <78e7d7fd8ac7a78e0c3c39c0e80cee4351a690f0.camel@fi.rohmeurope.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <2fb4b305-a93f-f91e-3001-dab5057e39cc@redhat.com>
         <084893a3-0071-13e9-5ce6-b7b027e6cd2a@roeck-us.net>
         <16140f5b-c504-1c07-9f0c-3813d686d157@redhat.com>
         <74ec29cb5780e93cca3d4cdec221c65e764c8a3e.camel@fi.rohmeurope.com>
         <400d3e82-a76e-136c-0e03-ed7e40608e2a@redhat.com>
         <YCpbit8W3xsvb37Q@kroah.com>
         <a1e74f7c-06d3-dfd0-c467-ea68af6f081f@redhat.com>
In-Reply-To: <a1e74f7c-06d3-dfd0-c467-ea68af6f081f@redhat.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d965db4-0cbd-4924-e9d7-08d8d1b35171
x-ms-traffictypediagnostic: HE1PR03MB2889:
x-microsoft-antispam-prvs: <HE1PR03MB2889BC1C81BF01DA040B2F88AD889@HE1PR03MB2889.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2WZLuasn7vse9VZGzpjjfKKRF/fXqQg6iNBQQ21erXmqJiEPyD3CJd4vyRz9kNoZu0Ia0MeKt4EJumFrPDls8mnnR6H8VM9wq2ipUBG9uHGyrn7o/DAjXTWkF3MUV8eCKGHRJ7u5s6yrJmDS3M/8r6fOcVYXfY9aAEIjRvKRi5RXn0qCPrDftVkEFZ7YKKK/AnMat9IP0hH8vcJ5QTuNkGqwQLsh/rmmbeniFL4oNyMlsGj/QZ5FSL+4uwt7TaJykMMpeE7oahT2/U670laxFJ4ixv/ixXBbWVmmCXn+Yw5qEkQRGuf+5OoTJ8V1aifpW2xBMPNi/dxx54pX7oJStvaJsJ0YNLkONU5eRTmRXMSIEYjQXb14en3UGUx6a1c6W0x/+WGW7DN9lysZavvTv7zA9cWGDHmKJ5IxJ+/ad2/RvDOliGwNOZOU0I46wCbsQtnvweRweasngdfXynpbCq8ZvZsCU9EGkinR03uZVuonYRq7s8XEdwx5POcImRN9H0y7lCm82CmI1oKVG8w0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39840400004)(54906003)(8936002)(2616005)(316002)(53546011)(478600001)(6512007)(186003)(8676002)(5660300002)(110136005)(6506007)(4326008)(7416002)(6486002)(71200400001)(66446008)(66476007)(76116006)(66946007)(86362001)(64756008)(3450700001)(66556008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ajFTVGc1a3QwdzNYekVyV2toN1dwYWpJWUExS085NzdLZGdFSlF6WjJZUU9K?=
 =?utf-8?B?VmtHVFVWTVFPZDFuMTMvM3hjV3pIc2ZtUmRZNitxTGt0RHVxcVFJQk4yZnhm?=
 =?utf-8?B?UC96bURrNCtDVHpCQVJPem5xNTRUYVQ0YzR0SEkxeklJU0x2SWRPS2ducVRZ?=
 =?utf-8?B?M2ZqTTQzUkx2bGdPbGU2a2xldk5sdlFWZ2k3VkNHd0o5Q2IwemYrbTEwL1RU?=
 =?utf-8?B?RTJSdTRjTkliRUFLN0pha282M2V4aEcrUmUzL1A3L3JLa29RNXJOMUMxcnli?=
 =?utf-8?B?d2k2L01STlZPci96VTRUbE9CUzNJQzBoNlV3bEJwZnVrL1poQnJ3L0pTYmZ4?=
 =?utf-8?B?N3BqWExOR3B3a3lVSFJkSVBmNXlrVkZsUWZzSFZMeXNVTTQyUzVuQXNTNGps?=
 =?utf-8?B?MTBCQnI0dU1Mck5MYzFMMWFZdEo1ZitsK1dzejkrQ2c3TGZvdnQzL0RMTTBH?=
 =?utf-8?B?c0MzUG1VS0tJSk5tOVdCcU9rc1RacmlNOExVeHEwK1JJdmd6STNoanhmRk41?=
 =?utf-8?B?WWZ2K1RrcGZHNTYzOTlLUy9YamZkeFVxbW5QK2twdTQ1b0ZZQ1R3eWQ2SUJQ?=
 =?utf-8?B?SURmaUROTSthMEJGY0d0dlYzSnBIS3BWb3lja0hQQy9ZY29WWGNOQjYxTVcr?=
 =?utf-8?B?bGFVbzlkUGdTcVNLQXdRcHlYVXhYZnlJaWs4ckdxQlJsRnV3cmtiVno5TStG?=
 =?utf-8?B?L29CaDhacDhCOU9aL3lpSGtUSWRWcGxaU2JUb1VOa2xYN2Q3SDZuSjhVMWp3?=
 =?utf-8?B?eFFZcTBrekhocmZYdlN2ZTY2dE03NzVDV052VEszU2IyRWVvOFZ4M2tjR3do?=
 =?utf-8?B?M0UvRzl3WkZVZkhCN3BLaCtTMkFxejZuOGxDamlZYTk5bFg2dzltK0x0bDR2?=
 =?utf-8?B?cWhvY1BEaDJac1pYSmJaSFRwOG15a3ArNm1HYjdVQkRKWnZla3M5V1N1UWc0?=
 =?utf-8?B?Mk1OQXFTd2RKc2FFUkxuSFNWWVQyanNUd0tEK1ZRK1M1T2MwYnQrL3BRcGQy?=
 =?utf-8?B?QkhZaEZSdXN4dUwvTDhLR2JvM2ZOeUJtRm5IS3dVTllpRERmbnh3WnV1a2Yx?=
 =?utf-8?B?MzU3WXZMc1dUbHlGNWFvdW1tY3dzZzdDc2ZoLzhxdDNIa3BTNUhnT3gyTXk1?=
 =?utf-8?B?NGx2SEJ4L0JOOHpsaEhIZ3FUL1doay9kTXpJNkdFdDh0V0dUSFo1SHlERUtu?=
 =?utf-8?B?YVpTMFIvZ3hVUVVNdloyWWFJT0ZmY2d4ODVTeXVsL0g1K1Vxd2xpZnovby9J?=
 =?utf-8?B?VTBXNnlsQWlsNnpuc3lRQWZWaGZmS3R0VTEyd2dDSjd5Qm5lYmdKWDMvTmhI?=
 =?utf-8?B?aCtmUDU0ZzF1cUQ3UkUvSDlWcVpsQTRWM2V1Y0NpVEpEaTVENUp6dTI4VkVK?=
 =?utf-8?B?WlJoNFI4UjM3TnFZalM5VWZVbWgrWWxZS2huTG5rcVgrZ1lIVmE5U2N5WGtD?=
 =?utf-8?B?ZFEwU21OTXd3S2pZSy9sSWR0bUNRVW42c2kyRGVxa3dpVXgxOTFTV3JXUEpI?=
 =?utf-8?B?YlFJZVVMYmozd05zSG5LM08ycTBENE5DSUIwVVpuaUdITTVhZVV0aFM0OXdY?=
 =?utf-8?B?Z3F6bHF6VUJPdDdFMzNIZjJNbExTdU5WbUlVVmE3SGxmZzJ3NlpwemNxaURa?=
 =?utf-8?B?ZjB2QlF4cnRSdkdUUEZHc1VPbUlEMElacEtlWFJuWGNJbWpxc3JmZnF6UUJx?=
 =?utf-8?B?MnpZQ2hPYUhwV3BzTVZva0NVdDlNV3RRWk5kNE5QWnpxdmRUdk1TQlRISWtL?=
 =?utf-8?B?Tjlkai96TksyNzBkM1lEZXIvem90QzNRR3lWd0hhK3c1dEszb1NyY3hWNXJJ?=
 =?utf-8?Q?gCgtchZoWqsSYl+FW6uIMj9BjiNUnRMNLoO54=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C17A36B985BC8A4C8F147EB961743FB2@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d965db4-0cbd-4924-e9d7-08d8d1b35171
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 13:12:16.6777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rCHR5siQ8CNno7Br4O9wC8QkmkRvXzi7fbmtqdv425Y4xqvJKZrRq/QGtpbyHKMULkdbbH5XWwuiRXwOCAo0Uguua9+6Wdx7eOu0w1BnOpBPRWofNjVczfEqlMcyP30
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2889
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTE1IGF0IDEyOjQzICswMTAwLCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIDIvMTUvMjEgMTI6MzEgUE0sIGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnIHdyb3RlOg0KPiA+IE9uIE1vbiwgRmViIDE1LCAyMDIxIGF0IDExOjM3OjI2QU0gKzAxMDAs
IEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gT24gMi8xNS8y
MSA4OjIyIEFNLCBWYWl0dGluZW4sIE1hdHRpIHdyb3RlOg0KPiA+ID4gPiBPbiBTYXQsIDIwMjEt
MDItMTMgYXQgMTY6NTkgKzAxMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+ID4gPiA+ID4gSGks
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gMi8xMy8yMSA0OjI3IFBNLCBHdWVudGVyIFJvZWNr
IHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gMi8xMy8yMSA3OjAzIEFNLCBIYW5zIGRlIEdvZWRlIHdy
b3RlOg0KPiA+ID4gPiA+ID4gWyAuLi4gXQ0KPiA+ID4gPiA+ID4gPiBJIHRoaW5rIHNvbWV0aGlu
ZyBsaWtlIHRoaXMgc2hvdWxkIHdvcms6DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBz
dGF0aWMgaW50IGRldm1fZGVsYXllZF93b3JrX2F1dG9jYW5jZWwoc3RydWN0IGRldmljZQ0KPiA+
ID4gPiA+ID4gPiAqZGV2LA0KPiA+ID4gPiA+ID4gPiBzdHJ1Y3QgZGVsYXllZF93b3JrICp3LA0K
PiA+ID4gPiA+ID4gPiAJCQkJCXZvaWQgKCp3b3JrZXIpKHN0cnVjdA0KPiA+ID4gPiA+ID4gPiB3
b3JrX3N0cnVjdCAqd29yaykpIHsNCj4gPiA+ID4gPiA+ID4gCUlOSVRfREVMQVlFRF9XT1JLKHcs
IHdvcmtlcik7DQo+ID4gPiA+ID4gPiA+IAlyZXR1cm4gZGV2bV9hZGRfYWN0aW9uKGRldiwgKHZv
aWQgKCphY3Rpb24pKHZvaWQNCj4gPiA+ID4gPiA+ID4gKikpY2FuY2VsX2RlbGF5ZWRfd29ya19z
eW5jLCB3KTsNCj4gPiA+ID4gPiA+ID4gfQ0KPiA+ID4gDQo+ID4gPiBpbmNsdWRlL2xpbnV4L2Rl
dm0tY2xlYW51cC1oZWxwZXJzLmgNCj4gPiA+IA0KPiA+ID4gQW5kIHB1dCBldmVyeXRoaW5nIChp
bmNsdWRpbmcga2RvYyB0ZXh0cykgdGhlcmUuDQo+ID4gPiANCj4gPiA+IFRoaXMgd2F5IHRoZSBm
dW5jdGlvbmFsaXR5IGlzIDEwMCUgb3B0LWluIChieSBleHBsaWNpdGx5DQo+ID4gPiBpbmNsdWRp
bmcNCj4gPiA+IHRoZSBoZWFkZXIgaWYgeW91IHdhbnQgdGhlIGhlbHBlcnMpIHdoaWNoIGhvcGVm
dWxseSBtYWtlcyB0aGlzIGENCj4gPiA+IGJpdCBtb3JlIGFjY2VwdGFibGUgdG8gcGVvcGxlIHdo
byBkb24ndCBsaWtlIHRoaXMgc3R5bGUgb2YNCj4gPiA+IGNsZWFudXBzLg0KPiA+ID4gDQo+ID4g
PiBJIHdvdWxkIGJlIGV2ZW4gaGFwcHkgdG8gYWN0IGFzIHRoZSB1cHN0cmVhbSBtYWludGFpbmVy
IGZvciBzdWNoDQo+ID4gPiBhDQo+ID4gPiBpbmNsdWRlL2xpbnV4L2Rldm0tY2xlYW51cC1oZWxw
ZXJzLmggZmlsZSwgSSBjYW4gbWFpbnRhaW4gaXQgYXMNCj4gPiA+IHBhcnQNCj4gPiA+IG9mIHRo
ZSBwbGF0Zm9ybS1kcml2ZXJzLXg4NiB0cmVlICh3aXRoIGl0cyBvd24gTUFJTlRBSU5FUlMNCj4g
PiA+IGVudHJ5KS4NCj4gPiA+IA0KPiA+ID4gR3JlZywgd291bGQgdGhpcyBiZSBhbiBhY2NlcHRh
YmxlIHNvbHV0aW9uIHRvIHlvdSA/DQo+ID4gDQo+ID4gSSBkb24ndCBrbm93LCBzb3JyeSwgbGV0
J3MgcmV2aXNpdCB0aGlzIGFmdGVyIDUuMTItcmMxIGlzIG91dCwgd2l0aA0KPiA+IGENCj4gPiBw
YXRjaCBzZXQgdGhhdCBJIGNhbiByZXZpZXcgYWdhaW4sIGFuZCB3ZSBjYW4gZ28gZnJvbSB0aGVy
ZSBhcyBJDQo+ID4gY2FuJ3QNCj4gPiBkbyBhbnl0aGluZyB1bnRpbCB0aGVuLi4uDQo+IA0KPiBP
ay4NCg0KVGhpcyBpcyBPayBmb3IgbWUgdG9vLiBJIGFtIGluIG5vIGh1cnJ5IHdpdGggdGhpcyAt
IEkndmUgYWxyZWFkeSBhIGZldw0KdGhpbmdzIHRvIHdvcmsgb24uDQpTbywgSSB3aWxsIHJld29y
ayB0aGlzIHRvIGJlIGluIGEgc2luZ2xlIGhlYWRlciB3aGVuIHY1LjEyLXJjMSBpcyBvdXQuDQoN
CkJlc3QgUmVnYXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0KDQoNCi0tDQpNYXR0aSBWYWl0dGluZW4s
IExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kDQpTV0RD
DQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+fiAiSSBkb24n
dCB0aGluayBzbywiIHNhaWQgUmVuZSBEZXNjYXJ0ZXMuIEp1c3QgdGhlbiBoZSB2YW5pc2hlZCB+
fn4NCg0KU2ltb24gc2F5cyAtIGluIExhdGluIHBsZWFzZS4NCiJub24gY29naXRvIG1lIiBkaXhp
dCBSZW5lIERlc2NhcnRlLCBkZWluZGUgZXZhbmVzY2F2aXQNCg0KKFRoYW5rcyBmb3IgdGhlIHRy
YW5zbGF0aW9uIFNpbW9uKQ0K
