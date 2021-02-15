Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6431B596
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 08:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhBOHXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 02:23:45 -0500
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:60256
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229944AbhBOHXo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 02:23:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR77qpsZQe0c4wHTzjaeQNG4XuVPuKzKyBx3WRCrwrTiTSmBwNrg6N5JYpxc/tIvc3lC+uTa8ejLgFCkdgh7Q6fnrdYzhljnoa2OE1v8TfCZgFiR27X8A/Bw/mmfZjU/Ki+GHwaQJ9B8Q+cQYqHBt2ZLq5qwKMQvvvjZ4phccmLc7BIlGQzPPW9rOxk+/d2GBie/E0so7FRiheCRA9qCm55nZO1sLCkaD4wtzimH9V7lDpqngDlSjgqLqKCi6Zg2o6GEAew5PEi8wRrkNMcVzWrRb3QBGFoTKFSYuLAtgFIZ+XO6Mq0Ujc0RuDQxXFbXMViKqhdxoh5oOxBqFJ7nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gSmW+Dsi6pp0jTnkYnwEMWNHGYx4T7ZTWMrugUejpY=;
 b=c+5ys6FMYp9x4EafTBFEnul4u1hCPX+cKfNcrV4uTPcLyAJdYSFvq9Wxjqo96AM5oDoOT5fLz5fWrGHCA1Qbz51JNbTrBeaX6kRxLKVlpLsn2YnyknrEthIKlQXOmRCn5qh4VzoyArkHj0FNoC1XNBPrNCovAFXWB3HEHIvMat7BmKIKYNVyUGRztaRpYC5wb+EmBKV8t85WuXiykzSxionKYdIsurFODrH+h3DPdWX+L/x02jSnP6LjCFlSFvOVpTx9sGTU9tkqlQ+Uieslcm1r7hGEx8FAc47OWAousx2yzjgWXv7HWQs/YKIz3ybHW3r5p8lo6R4eAbQT2Cy77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gSmW+Dsi6pp0jTnkYnwEMWNHGYx4T7ZTWMrugUejpY=;
 b=PViACDB+mESnqVBu8wdzwWLWcZ5xGz7fXiaPMc0E4+ty60aL2mvIHPBjcmMWTJnUPwpYWycDVnyBPKXRay/MLjzskfj6/zjgLyv+XdON16MvqLc9rumXJOYFgS7w2WJYiHNXbGn+v1J8/pFKXK8UZRF0aioL7u3GRpG0zzXC/hw=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2987.eurprd03.prod.outlook.com (2603:10a6:7:5b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38; Mon, 15 Feb 2021 07:22:52 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c18c:4a01:ca24:78c1]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::c18c:4a01:ca24:78c1%5]) with mapi id 15.20.3846.038; Mon, 15 Feb 2021
 07:22:52 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "saravanak@google.com" <saravanak@google.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Thread-Topic: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Thread-Index: AQHXAf+bFCY4blJH0Uy048cUlqVjwKpWLt8AgAAGsYCAAAjjgIACk9QA
Date:   Mon, 15 Feb 2021 07:22:51 +0000
Message-ID: <74ec29cb5780e93cca3d4cdec221c65e764c8a3e.camel@fi.rohmeurope.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
         <2fb4b305-a93f-f91e-3001-dab5057e39cc@redhat.com>
         <084893a3-0071-13e9-5ce6-b7b027e6cd2a@roeck-us.net>
         <16140f5b-c504-1c07-9f0c-3813d686d157@redhat.com>
In-Reply-To: <16140f5b-c504-1c07-9f0c-3813d686d157@redhat.com>
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
x-ms-office365-filtering-correlation-id: 916c4f4a-d38f-4c32-8b12-08d8d18281a5
x-ms-traffictypediagnostic: HE1PR03MB2987:
x-microsoft-antispam-prvs: <HE1PR03MB29874241B0A32F8BCD011F6CAD889@HE1PR03MB2987.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qz48KPGeUOhiW9+we1vrzw6DKL3VpJWBnGbka7vj1K0MSdd7Abog27ENeRavfqisljFCyCHeZhce4Dr8+ZuxmibfXJbciq16A7pX9hrzeauF6Wn7I2sxNWbu/jgE6r2Kh5R5sNvkvQgoioPx18Y1ZuJC11ZH7Xk5ZPJg3MMwe5B/bc86iOS7sRPFhQA0qHnkQsyIRHMu4RKbwrlC89ejosby/9SNSM9xaJ/h3xBH8Ylqojvs/+lpeVe93cin6mtmkrfaCldNALAU3QGvdL2foveuTy7EOMP6sRKPyhsPmlPRsvImxblnm68DSXX0XbqdophDvQX2VpvA9lnyK3wPvuQ15NKNN3/+YSV8gDFXX3FDFe119RC2wmxoaDKz071AZYDS+VYXIbqCG2N0QleLctpyGxxP1U8Zf890lz9G8xwkDqejiUi/fnhU0Js/AhxVDGJPadC9E1qditYESgRSFzvvWPzcee9sDEC5vj5yYBopM4nuyOvmYsAmlFTxWUPN+k5q2P3rz/aagtMznpcbLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(136003)(396003)(346002)(110136005)(5660300002)(54906003)(4326008)(6512007)(71200400001)(8936002)(3450700001)(8676002)(66946007)(66556008)(76116006)(66476007)(64756008)(66446008)(2616005)(7416002)(316002)(2906002)(186003)(6506007)(53546011)(6486002)(83380400001)(478600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cDMwZDErQUNRWUxVSTJUc2pvYkt2ZUlQMFlMYzRuZjQrdEI1RUpOcHFoUXp0?=
 =?utf-8?B?QVh4WjljNzhXWlBKMzJpTEFUQ0U4MzBxNmJoNnZjVEJreHNERWV6dkVtTWg5?=
 =?utf-8?B?SndEcDYxZVhXY3djUnF1V2hVN1ZwellYQnYyakt5UzNWYWhWNDJjZk9zR1Nu?=
 =?utf-8?B?SHBUTW13Sm94aGdyMW9hTjJKVUIzQWdNYlNHaVhzdHBhYkR6NVNwWkxMbk5D?=
 =?utf-8?B?NllJSm9hOHRmbU84TXFZdERvUEFVR1M5c2dBVmNSWlVENDRQNFNJUGRJNm12?=
 =?utf-8?B?ZG94bFZ0OFFKTjZkM25aa3IyU3BCaWRVQXVlUTRnbnhpMzQwcHNVQVVZT3BT?=
 =?utf-8?B?WDJuYVJQV0crN1liUGxqZ1k4b1RFY2pKWUw0UDMvZHEza2hDaUJBVjFWOEJR?=
 =?utf-8?B?ekJRWEVaRlRuRkthMll2Zm1QdzE1M09lcE5LR1BCUEVLcXJ5VVdxVDM5SHlO?=
 =?utf-8?B?eVczZHVBUVlpYmRnNkFvS1ZwV0wra1BmdGZSYk1CMkJ3QWtGelVYdFdiWlFa?=
 =?utf-8?B?TUtiUWpQVy9UQ1FKMGRLbThVZ1F3aVhhNldBVmpzR1Q3RmhHMktIZTM5SGNI?=
 =?utf-8?B?a080SFEzVDk0b1c4M1BpRDZVU2RteTNreWpocHY2NUVqQzNldU9LNlF4OVp1?=
 =?utf-8?B?eGpucWk1cHlkeHhkV2xTRDVHQ0RIZXYwcHZJS1dWU1FxdC94WlVZdkxmVVRN?=
 =?utf-8?B?d0crOFpuZG1LTGg5ZEVSWnFYSHBZWDJGa3djYkJqNE44SHV4cUVpU2dLcnM5?=
 =?utf-8?B?ODZuTEJxSElUQTloTmdTSG5nMjRKR0pwTmpNdm9Ld0RVTHFhU01rRGkvdFd5?=
 =?utf-8?B?SklnOURvSWY0cWc5MXM4VjllaWFvV2doOVFmemNCYkdXQXFLVDhUaGcxVmt6?=
 =?utf-8?B?V0dYNXdobUdiYUxFN0Y4OEFQS09jTGVSbzVhOFRkaU13UzhEMTlKanhtUXps?=
 =?utf-8?B?TmpHaGlMeVg0OE54M0hsUVQrTmU1dzhVM0o0M0JFNms3WWJuYTBMNjhLYU1W?=
 =?utf-8?B?Zk0wMFNqWXUxSWo3N0J5RzhNNnBEQ29wNTc4Q1YrMDluai80Mi9sOCt6N3BJ?=
 =?utf-8?B?c2NOY2hGSzlMM05rOHNJVEtqYng4REFZYk52aTJ4Y2p0VDFQTzRRa2RZTm5G?=
 =?utf-8?B?azdXalNQVDEzNkxCM2FNMW9QQVpKcCtJcEZ1bkFzMnk5Sko3bm9BcUMwZnFp?=
 =?utf-8?B?ZGU0NFRKV3pQS2dFSUplMUV2TDY5NzVYYUUwVXduUGw4eGh6RWFicGNuMDVQ?=
 =?utf-8?B?L0k1WWhLelNyMWZoK0ZDbXBmam9HTmNHN0Zueml5QzVFZGloQWExN0Nad2w0?=
 =?utf-8?B?cHpPbWsxdDlKVHBKSTE1T3hNQ3RndUZwVHNDaUJmQTJIRWtQL2kyM283MUN0?=
 =?utf-8?B?K1NIYzFmM1BVRDQ4YTdZZ0RZM3FscjBHZlJRRSt2SDRFeGtMVWRmL1VPbzFU?=
 =?utf-8?B?OEZqcG5zQkxyZUFBRGxYZFJGVERLbVJwRmVRT3dOSWhyMlZRcGVzalhMQXNW?=
 =?utf-8?B?a2JzdWpWcVA5aXQwdXhJRGpXREM0TXovWkdtUm1KVkthRmY5WllsSW5peFZW?=
 =?utf-8?B?d0RNdm5YTUJJd1VNYnY5b0NVUHpQejF6cDBZWFFnaWlXVFBBSnBvSW9uNjcv?=
 =?utf-8?B?WjkzMmlpem5sdWFIcmhDWFlQNHpWUURxTUR0dmZ1VEphRGJ4RTNOa3N6R0RO?=
 =?utf-8?B?VjhXY0UybnVaalZ4R09lNWx4R3V6Q2RCSytLSHM5bEZnQ3JyaW5FNHN6dEpY?=
 =?utf-8?B?SzllOUhYd0FEV3hLQWJQNmRxc09zQ3Z1dGVKZHZEQjFZSWVPanhRcFRLMUZu?=
 =?utf-8?Q?1wniJMUZlVkbrpd7E7x01PpGnJXjQUQVu2Z8s=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <548101C13A256C49B4F9FA657883E12C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916c4f4a-d38f-4c32-8b12-08d8d18281a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 07:22:52.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfpE4XeaVqpwLmoA12zMNE5OcFOS11tuxx6bUuk70EeHasNqG+qzMyR+IH7LmeMyBoCHUbh6b7TAG5Jyh5lHjBY3ToEEElomsGlk/smzfhtDA8bG7jMDc0tQiJQROO4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2987
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBTYXQsIDIwMjEtMDItMTMgYXQgMTY6NTkgKzAxMDAsIEhhbnMgZGUgR29lZGUgd3JvdGU6
DQo+IEhpLA0KPiANCj4gT24gMi8xMy8yMSA0OjI3IFBNLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiA+IE9uIDIvMTMvMjEgNzowMyBBTSwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gPiBbIC4uLiBd
DQo+ID4gPiBJIHRoaW5rIHNvbWV0aGluZyBsaWtlIHRoaXMgc2hvdWxkIHdvcms6DQo+ID4gPiAN
Cj4gPiA+IHN0YXRpYyBpbnQgZGV2bV9kZWxheWVkX3dvcmtfYXV0b2NhbmNlbChzdHJ1Y3QgZGV2
aWNlICpkZXYsDQo+ID4gPiBzdHJ1Y3QgZGVsYXllZF93b3JrICp3LA0KPiA+ID4gCQkJCQl2b2lk
ICgqd29ya2VyKShzdHJ1Y3QNCj4gPiA+IHdvcmtfc3RydWN0ICp3b3JrKSkgew0KPiA+ID4gCUlO
SVRfREVMQVlFRF9XT1JLKHcsIHdvcmtlcik7DQo+ID4gPiAJcmV0dXJuIGRldm1fYWRkX2FjdGlv
bihkZXYsICh2b2lkICgqYWN0aW9uKSh2b2lkDQo+ID4gPiAqKSljYW5jZWxfZGVsYXllZF93b3Jr
X3N5bmMsIHcpOw0KPiA+ID4gfQ0KPiA+ID4gDQo+ID4gPiBJJ20gbm90IHN1cmUgYWJvdXQgdGhl
IGNhc3QsIHRoYXQgbWF5IG5lZWQgc29tZXRoaW5nIGxpa2UgdGhpcw0KPiA+ID4gaW5zdGVhZDoN
Cj4gPiA+IA0KPiA+ID4gdHlwZWRlZiB2b2lkICgqZGV2bV9hY3Rpb25fZnVuYykodm9pZCAqKTsN
Cj4gPiA+IA0KPiA+ID4gc3RhdGljIGludCBkZXZtX2RlbGF5ZWRfd29ya19hdXRvY2FuY2VsKHN0
cnVjdCBkZXZpY2UgKmRldiwNCj4gPiA+IHN0cnVjdCBkZWxheWVkX3dvcmsgKncsDQo+ID4gPiAJ
CQkJCXZvaWQgKCp3b3JrZXIpKHN0cnVjdA0KPiA+ID4gd29ya19zdHJ1Y3QgKndvcmspKSB7DQo+
ID4gPiAJSU5JVF9ERUxBWUVEX1dPUksodywgd29ya2VyKTsNCj4gPiA+IAlyZXR1cm4gZGV2bV9h
ZGRfYWN0aW9uKGRldiwNCj4gPiA+IChkZXZtX2FjdGlvbl9mdW5jKWNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYywgdyk7DQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVseSwgeW91IGNhbiBub3QgdHlwZSBj
YXN0IGZ1bmN0aW9uIHBvaW50ZXJzIGluIEMuIEl0IGlzDQo+ID4gYWdhaW5zdCB0aGUgQyBBQkku
DQo+ID4gSSBhbSBzdXJlIGl0IGlzIGRvbmUgaW4gYSBmZXcgcGxhY2VzIGluIHRoZSBrZXJuZWwg
YW55d2F5LCBidXQNCj4gPiB0aG9zZSBhcmUgd3JvbmcuDQo+IA0KPiBJIHNlZSwgYnVtbWVyLg0K
DQpJIHRoaW5rIHVzaW5nIGRldm1fYWRkX2FjdGlvbigpIGlzIHN0aWxsIGEgZ29vZCBpZGVhLg0K
DQo+IA0KPiBJZiB3ZSBhZGQgYSBkZXZtX2Nsa19wcmVwYXJlX2VuYWJsZSgpIGhlbHBlciB0aGF0
IHNob3VsZCBwcm9iYWJseSBiZQ0KPiBhZGRlZA0KPiB0byBkcml2ZXJzL2Nsay9jbGstZGV2cmVz
LmMgYW5kIG5vdCB0byBkcml2ZXJzL2Jhc2UvZGV2cmVzLmMgLg0KPiANCj4gSSBhbHNvIHN0aWxs
IHdvbmRlciBpZiB3ZSBjYW5ub3QgZmluZCBhIGJldHRlciBwbGFjZSBmb3IgdGhpcyBuZXcNCj4g
ZGV2bV9kZWxheWVkX3dvcmtfYXV0b2NhbmNlbCgpIGhlbHBlciBidXQgbm90aGluZyBjb21lcyB0
byBtaW5kLg0KDQpJIGRvbid0IGxpa2UgdGhlIGlkZWEgb2YgaW5jbHVkaW5nIGRldmljZS5oIGZy
b20gd29ya3F1ZXVlLmggLSBhbmQgSQ0KdGhpbmsgdGhpcyB3b3VsZCBiZSBuZWNlc3NhcnkgaWYg
d2UgYWRkZWQNCmRldm1fZGVsYXllZF93b3JrX2F1dG9jYW5jZWwoKSBhcyBpbmxpbmUgaW4gd29y
a3F1ZXVlLmgsIHJpZ2h0Pw0KDQpJIGFsc28gc2VlIHN0cm9uZyBvYmplY3Rpb24gdG93YXJkcyB0
aGUgZGV2bSBtYW5hZ2VkIGNsZWFuLXVwcy4NCg0KSG93IGFib3V0IGFkZGluZyBzb21lIGRldm0t
aGVscGVycy5jIGluIGRyaXZlcnMvYmFzZSAtIHdoZXJlIHdlIGNvdWxkDQpjb2xsZWN0IGRldm0t
YmFzZWQgaGVscGVycyAtIGFuZCB3aGljaCBjb3VsZCBiZSBlbmFibGVkIGJ5IG93biBDT05GSUcg
LQ0KYW5kIGxlZnQgb3V0IGJ5IHRob3NlIHdobyBkaXNsaWtlIGl0Pw0KDQpJIGtub3cgSSB3cm90
ZSB0aGF0IHRoZSBkZXZtX2RlbGF5ZWRfd29ya19hdXRvY2FuY2VsKCkgZG9lcyBwcm9iYWJseQ0K
bm90IHdhcnJhbnQgb3duIGZpbGUgLSBidXQgaWYgeW91IGNhbiBmb3Jlc2VlIGRldm1fd29ya19h
dXRvY2FuY2VsKCkNCmFuZCBmZXcgb3RoZXIgZ2VuZXJhbGx5IHVzZWZ1bCBoZWxwZXJzIC0gdGhl
biB3ZSB3b3VsZCBoYXZlIGEgcGxhY2UgZm9yDQp0aG9zZS4gVGhlIGRldm0gc3R1ZmYgc2hvdWxk
IGluIG15IG9waW5pb24gbGl2ZSB1bmRlciBkcml2ZXJzLy4NCg0KQmVzdCBSZWdhcmRzDQoJTWF0
dGkgVmFpdHRpbmVuDQoNCg==
