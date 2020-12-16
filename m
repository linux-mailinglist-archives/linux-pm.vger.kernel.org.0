Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203F22DC1F4
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgLPOOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 09:14:15 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25987 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPOOP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 09:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608128052; x=1639664052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LzxMH1ApuvFBfFKn0bKSmf22K3xfjmIsfppMZOJIQC4=;
  b=Cqi6OiFy2Spyq80E0AyqMl7OCKqlCJyAMWFOjLM4NwSua2F5gmSSMpXb
   S+CwUK3YFNFPDLUqHgGKKwFkSjW2lG4je4p1dk8ItEJ2vrkgX8Sb+ynbi
   PBIs4evlDKxPI0rbsiNdrgdufHJZmniLKp5L1DZ2NLlvgHxR0um/eofAI
   qohVPbCDl3SsP7q6GzEdTQHbbr8rKA+ranluIBjrpsgAQgMz+1UmnLT88
   YQplAYNkHJbBp8ZLx3xedjHdGdE3GJQggyinmiXBm0b7akYu7Dd1Pj5/V
   p2jyb+Hvs+Sdc8oOoIGvlt37a/2jYTi5r/X5vXkYJPR/ZKZT5Q+PXxWRW
   A==;
IronPort-SDR: WcbwAMd+jOaJg0rIyir8N9kavZYBq2sLK56Ax65jJyuMcx9umup3gbKzCM+7z17u0JAHylP7hR
 H5kAkmr7d645iPeN8u6xTy1gjPuSJYhvCqaNLbvS3d8IWn19TWLXkiH/kckVVnE8/cw8nJC47Q
 90KwR/BeALof3wwwnW7Bfez3gPOon/dK08n/j+olFKF6ndLT3xCgVbunHF84dGdBPj89m8QUJs
 NFoQLUtioin558bfFN12o7rHWDOuu1YRbC3efaeKpeBQ1JykZHTh3Q9digRb+FcfGadxh44hLG
 vt0=
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="37625634"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2020 07:12:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 07:12:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Dec 2020 07:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYqt7g1f/fEh+UlIQmxVcQ5tSEI6cf6Wr4/tMBpI7p11bof97oQW8jZr34P87zYQze052jBb7tzW+DmeZeTDE4qLQWlqXSv7NssX5IzIxbD1KoHKre6XHw/qmZOCHksapJE+JpVGGEqAnkDkYZPbLOZLPW8xb975JzTtLVYfcBbxi3p6JXn9iDN8zBK7VNtNNhz/as8jm3GjWT68PhhwqE+qfJPE/izdouakds0Q993ujMrUp406vQNl43L8b6/CJzgpKoBTq35znWKwiLYf14PSboqzgwCCEMPCD4JI962SfqHW1NPDK4+W9xTPfgdiwaUqBin325PWMzEGkIBdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzxMH1ApuvFBfFKn0bKSmf22K3xfjmIsfppMZOJIQC4=;
 b=UA6VLpxfli0bUYzsgjvomFgtswbF1PeZ3TZZwiEFbiXE/o2uzhSJm0ZO9zisRISheNxXEbSWN1PLmr9IBrq0BA6LJyFMk+6FXX5VUFMa61EoMMJ3eHQOjuENYRgUWI246G5vV2ybB4H5ko/HavwbOZ5E/1Ki4Pdaah8Mc1ukP+1OuzNIX8EtJGBS82x6IopqxKLT/Q8jPnjk4hfP7Lu5nydOz3T6kpz/XsWleTLES3zdJXu4UwlZkJCIBGxo+z7ieMpZavq6ca/e4TwTND6fIvYsRNdFANRwlMvuD8mKjI6Km71skf8VKiqO9Xvsjpj+xoGGJ1fwP2Xnmx9MBd7VVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzxMH1ApuvFBfFKn0bKSmf22K3xfjmIsfppMZOJIQC4=;
 b=f4aU59W013FIchogFHosEZG0Sknkuvt2u7IA75ViAh1YCndyD1DIoqy3vJzie68HhPif8RTzjeLnxhF6RAEUu5SDjGSnep1Zddpc5Zi2i9rEm0ylKIJU1/qYcto5MqnvCCf5wwLAHYPh2KKWz4xqRvBUe6Hn6WzAk2ElhlM3jHU=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 16 Dec 2020 14:12:56 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::eded:bdb6:c6f1:eb3e]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::eded:bdb6:c6f1:eb3e%4]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 14:12:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <sre@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] power: reset: at91-sama5d2_shdwc: add support for
 sama7g5
Thread-Topic: [PATCH 3/3] power: reset: at91-sama5d2_shdwc: add support for
 sama7g5
Thread-Index: AQHW07WM8svOvDAvX0CwyDsoq7Wrnw==
Date:   Wed, 16 Dec 2020 14:12:55 +0000
Message-ID: <02a1a3f5-1663-105a-2fff-9d5961d70792@microchip.com>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
 <1608123453-1423-4-git-send-email-claudiu.beznea@microchip.com>
 <20201216134532.GH2814589@piout.net>
In-Reply-To: <20201216134532.GH2814589@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fb8dc35-15c7-41d9-ad31-08d8a1ccaf5c
x-ms-traffictypediagnostic: DM6PR11MB4722:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB47229E134B76698C0892B3B087C50@DM6PR11MB4722.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBkAwYYx/486cHRddjLTXnrNcM8OxVuQy8HAspBxO18NQu8AUEg3FiwaSM8bO34NFiTvlYsPP1emUEtoVVdaq4yP/27JJh04mdk4t+qph7iiTqLfyg6FZgOZSXnE1M8wl8YJDzcM5AhNrqZLf6ojQhGiAkGb2yPOjwfd1qhYb5yYhnQXORoAFl8MODtKKT3X2eppMwVY9JIcURnFYYnzasj4dUIyopMFtBqQOgBhOtlvAgKM69pMjOzKMRdlndcwSpiSJHXMGc1Sy465ztdIU1pGRP7q3Lr+KdLgnVTZTkswAi3mGdz+xP/GLNGfLMuoRVvQS8TbqH/A6isivO2OZVBXhBYvQdjX48IR0eHRomFKRP1A7rAtVTIRFrUlQPWKHsKr4lYlVuoi4uN868xdMMeiC+A6VCB9ivBQ6VGON2q+agKtTTabXQh8tzCT3htBJBtjKi1kmKBcCgMUstzg7bYlDWKbv7CT6d6tA6S51Qf80YamHn9s+sDGmk0yfPxockqZgNLWJoRMvhU7evO3YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(8936002)(66476007)(66446008)(66556008)(4326008)(54906003)(83380400001)(26005)(6486002)(36756003)(316002)(91956017)(31686004)(8676002)(76116006)(966005)(71200400001)(64756008)(86362001)(2616005)(478600001)(31696002)(66946007)(6512007)(186003)(5660300002)(6506007)(2906002)(6916009)(53546011)(138113003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OVh4VDdFdXhYcmpsZEdPckRRS3JGNHNyNFJuRWRwZ1Vuc21FU1JOWkhodzRi?=
 =?utf-8?B?eVBHK1dCMXQ0OXJ3NWFKQzFrUmhWMU91eHp0NVI3aDR5TEVQT2RjYVM0Z1ZY?=
 =?utf-8?B?dHBVd1M0a0JYZHRBVDFXRE0xMy8yRW5yQWIzbURQN2Fwb3dSblgvSHk0ZVVo?=
 =?utf-8?B?N3RqMGFUQXd2MGY5cXVXTDZScnlIdFMyVHp0b0E5QzJPemdva1FqbTF2c1Bm?=
 =?utf-8?B?a1VnU0IrVGpqS25IUk5VVThLMHdud09odFpWSWQwSDlJRzBjank5czh6MDZ6?=
 =?utf-8?B?bnJ2OHVVb1dvZE1XeSticXJhYlRJV1dtbHZEOTRxRW4ycHRNL1lqNHZHbkZE?=
 =?utf-8?B?YWpaSncyenR0VmpsWVVybHNrV3ZLWTBhQzB2OFhzVXp1WDZ6RmV0eE1PQ3hr?=
 =?utf-8?B?Q3FrTEpzMktFbHIrRDVUcDF5UGJJK2t2SHkwdVI2YlBOMUpLYUcxQ2I0eE5j?=
 =?utf-8?B?U09SdkMvQVZlWURsNFpsWGUyRlI2cmU4aWdhQzAwNEF6V3lQNFlIdFZ0eWZt?=
 =?utf-8?B?VHhOU0RiS2l6eWpyc29nQytrYlVJcXI4elpUS0xyTS9aWCt3UDJmUmNyZElt?=
 =?utf-8?B?RUFxdWhKanIreVpGMEd5MEdPeW1xQTdSSk1SQlphczd4cldwZnlJMHR0ZU5r?=
 =?utf-8?B?b3cvZmJ2ZnByRjQ2cmNubU1QNkJORmhMbHdoYUlmZjEzUnpPNTZ6SXpvMFYx?=
 =?utf-8?B?cWZYbkF5MktSbVBzTW9mTURRWHVXZWljNngxeGpWTWdQckRHeGZTU0hFUEQ2?=
 =?utf-8?B?OXZnSDdvNFM4VU4yZFJmekJFT214TE4xUGMycTVVSDZ2a0c2d1lwUGhPMG1n?=
 =?utf-8?B?YUYxK3daZy9KdGcyMzVLNEx4dFRaSjduUzlncm5EaHJDZG51MmxKdlBBYmxl?=
 =?utf-8?B?OHRjNEVCa0JQd251VTR2YTVRbmQwcFJIcVE3N05YOXl3MWcwYzNVamk5ZzFh?=
 =?utf-8?B?SVgwallnaHNUSEM2djJlNlBvZERtcTkvQjVhelljdGFwV2Mrb3UxbkN5RWpX?=
 =?utf-8?B?V3o4Y3JPOGRDZDVhc3p0YXJiOS9tSTUxcmR1eGo0MDNZTlBJTU1iRGFaV2RS?=
 =?utf-8?B?OE5KN3hOYk1mQmdWNHBtNUcyRlBqcUpPU2RvRi82dzRBbmM4UldZekZSYkxh?=
 =?utf-8?B?ZWx1dy9tWGNaL2pHNFNlRkZSVjVNSlVZU042VkJvRkp6WENMZ0MrVC9TaDgv?=
 =?utf-8?B?dTQwYWtxN3NGNWc3Zzh6eTJVZllsQUp1aHgvNDEwTk9zTXREVFB2VFZ0NENa?=
 =?utf-8?B?eW9NRmJiMzhpYVI0cmphU0ZXQ3UyZ2ZVZ0JmS3dZRnFNYXRMelJpdVo3dXhG?=
 =?utf-8?Q?QiErvPZVR9I+4Hp+mchrX6JjUixZflK37n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5547A76BC28444EA24304E219B26427@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb8dc35-15c7-41d9-ad31-08d8a1ccaf5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 14:12:55.8922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tA3shO5W5MvgNXMrvv4C8UoNOpmZobd8WRiZMhBP3/XOPmWsmVotmyUWBIiBMgQ0+SgNI3mYKGwYwgzHhjIvwaA5guH/MWNCUNvGgJYP9qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCk9uIDE2LjEyLjIwMjAgMTU6NDUsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDE2LzEyLzIwMjAgMTQ6NTc6
MzMrMDIwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBBZGQgc3VwcG9ydCBmb3IgU0FNQTdH
NSBieSBhZGRpbmcgcHJvcGVyIHN0cnVjdCByZWdfY29uZmlnIHN0cnVjdHVyZQ0KPj4gYW5kIHNp
bmNlIFNBTUE3RzUgaXMgbm90IGN1cnJlbnRseSBvbiBMUEREUiBzZXR1cHMgdGhlIGNvbW1pdCBh
bHNvDQo+PiBhdm9pZCB0aGUgbWFwcGluZyBvZiBERFIgY29udHJvbGxlci4NCj4+DQo+IA0KPiBI
b25lc3RseSwgSSB3b3VsZG4ndCBsZWF2ZSB0aGUgTFBERFIgcGFydCBvdXQgYmVjYXVzZSB0aGVy
ZSBpcyBubw0KPiBndWFyYW50ZWUgYW55b25lIHdpbGwgdGhpbmsgYWJvdXQgaXQgd2hlbiB0aGV5
IGhhdmUgYSBkZXNpZ24gd2l0aCBMUEREUg0KPiBhbmQgYXMgYSBjb25zZXF1ZW5jZSwgdGhlaXIg
ZGV2aWNlIHdpbGwgYmVoYXZlIHByb3Blcmx5IGJ1dCB3aWxsIGJlDQo+IHZlcnkgc2hvcnQgbGl2
ZWQuDQoNClRoZSBpZGVhIHdhc24ndCB0byBsZWF2ZSBpdCBvdXQuIEl0IGhhcyB0byBiZSBoYW5k
bGVkIGRpZmZlcmVudGx5IG9uDQpTQU1BN0c1IGFzIGl0IGVtYmVkcyBhIGRpZmZlcmVudCBERFIg
Y29udHJvbGxlciBhbmQgYXQgdGhlIG1vbWVudCB3ZSBoYXZlDQpubyBzZXR1cCB3aXRoIExQRERS
Lg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1DQoNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZl
cnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMgfCA3MiArKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCAx
OCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9yZXNldC9h
dDkxLXNhbWE1ZDJfc2hkd2MuYyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3No
ZHdjLmMNCj4+IGluZGV4IDM5OTYxNjdmNjc2Zi4uYTMzNDJjOGMzNzI4IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYw0KPj4gKysrIGIvZHJp
dmVycy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYw0KPj4gQEAgLTc4LDkgKzc4LDE1
IEBAIHN0cnVjdCBwbWNfcmVnX2NvbmZpZyB7DQo+PiAgICAgICB1OCBtY2tyOw0KPj4gIH07DQo+
Pg0KPj4gK3N0cnVjdCBkZHJjX3JlZ19jb25maWcgew0KPj4gKyAgICAgdTMyIHR5cGVfb2Zmc2V0
Ow0KPj4gKyAgICAgdTMyIHR5cGVfbWFzazsNCj4+ICt9Ow0KPj4gKw0KPj4gIHN0cnVjdCByZWdf
Y29uZmlnIHsNCj4+ICAgICAgIHN0cnVjdCBzaGR3Y19yZWdfY29uZmlnIHNoZHdjOw0KPj4gICAg
ICAgc3RydWN0IHBtY19yZWdfY29uZmlnIHBtYzsNCj4+ICsgICAgIHN0cnVjdCBkZHJjX3JlZ19j
b25maWcgZGRyYzsNCj4+ICB9Ow0KPj4NCj4+ICBzdHJ1Y3Qgc2hkd2Mgew0KPj4gQEAgLTI2Miw2
ICsyNjgsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdfY29uZmlnIHNhbWE1ZDJfcmVnX2Nv
bmZpZyA9IHsNCj4+ICAgICAgIC5wbWMgPSB7DQo+PiAgICAgICAgICAgICAgIC5tY2tyICAgICAg
ICAgICA9IDB4MzAsDQo+PiAgICAgICB9LA0KPj4gKyAgICAgLmRkcmMgPSB7DQo+PiArICAgICAg
ICAgICAgIC50eXBlX29mZnNldCAgICA9IEFUOTFfRERSU0RSQ19NRFIsDQo+PiArICAgICAgICAg
ICAgIC50eXBlX21hc2sgICAgICA9IEFUOTFfRERSU0RSQ19NRA0KPj4gKyAgICAgfSwNCj4+ICB9
Ow0KPj4NCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ19jb25maWcgc2FtOXg2MF9yZWdfY29u
ZmlnID0gew0KPj4gQEAgLTI3NSw2ICsyODUsMjMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdf
Y29uZmlnIHNhbTl4NjBfcmVnX2NvbmZpZyA9IHsNCj4+ICAgICAgIC5wbWMgPSB7DQo+PiAgICAg
ICAgICAgICAgIC5tY2tyICAgICAgICAgICA9IDB4MjgsDQo+PiAgICAgICB9LA0KPj4gKyAgICAg
LmRkcmMgPSB7DQo+PiArICAgICAgICAgICAgIC50eXBlX29mZnNldCAgICA9IEFUOTFfRERSU0RS
Q19NRFIsDQo+PiArICAgICAgICAgICAgIC50eXBlX21hc2sgICAgICA9IEFUOTFfRERSU0RSQ19N
RA0KPj4gKyAgICAgfSwNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVn
X2NvbmZpZyBzYW1hN2c1X3JlZ19jb25maWcgPSB7DQo+PiArICAgICAuc2hkd2MgPSB7DQo+PiAr
ICAgICAgICAgICAgIC53a3VwX3Bpbl9pbnB1dCA9IDAsDQo+PiArICAgICAgICAgICAgIC5tcl9y
dGN3a19zaGlmdCA9IDE3LA0KPj4gKyAgICAgICAgICAgICAubXJfcnR0d2tfc2hpZnQgPSAxNiwN
Cj4+ICsgICAgICAgICAgICAgLnNyX3J0Y3drX3NoaWZ0ID0gNSwNCj4+ICsgICAgICAgICAgICAg
LnNyX3J0dHdrX3NoaWZ0ID0gNCwNCj4+ICsgICAgIH0sDQo+PiArICAgICAucG1jID0gew0KPj4g
KyAgICAgICAgICAgICAubWNrciAgICAgICAgICAgPSAweDI4LA0KPj4gKyAgICAgfSwNCj4+ICB9
Ow0KPj4NCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhdDkxX3NoZHdjX29m
X21hdGNoW10gPSB7DQo+PiBAQCAtMjg1LDYgKzMxMiwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBhdDkxX3NoZHdjX29mX21hdGNoW10gPSB7DQo+PiAgICAgICB7DQo+PiAg
ICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLXNoZHdjIiwNCj4+
ICAgICAgICAgICAgICAgLmRhdGEgPSAmc2FtOXg2MF9yZWdfY29uZmlnLA0KPj4gKyAgICAgfSwN
Cj4+ICsgICAgIHsNCj4+ICsgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNh
bWE3ZzUtc2hkd2MiLA0KPj4gKyAgICAgICAgICAgICAuZGF0YSA9ICZzYW1hN2c1X3JlZ19jb25m
aWcsDQo+PiAgICAgICB9LCB7DQo+PiAgICAgICAgICAgICAgIC8qc2VudGluZWwqLw0KPj4gICAg
ICAgfQ0KPj4gQEAgLTI5NCw2ICszMjUsNyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhdDkx
X3NoZHdjX29mX21hdGNoKTsNCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBh
dDkxX3BtY19pZHNbXSA9IHsNCj4+ICAgICAgIHsgLmNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVk
Mi1wbWMiIH0sDQo+PiAgICAgICB7IC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLXBt
YyIgfSwNCj4+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbWE3ZzUtcG1jIiB9
LA0KPj4gICAgICAgeyAvKiBTZW50aW5lbC4gKi8gfQ0KPj4gIH07DQo+Pg0KPj4gQEAgLTM1NSwz
MCArMzg3LDM0IEBAIHN0YXRpYyBpbnQgX19pbml0IGF0OTFfc2hkd2NfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgICAgICAgICAgICAgZ290byBjbGtfZGlzYWJsZTsN
Cj4+ICAgICAgIH0NCj4+DQo+PiAtICAgICBucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5V
TEwsIE5VTEwsICJhdG1lbCxzYW1hNWQzLWRkcmFtYyIpOw0KPj4gLSAgICAgaWYgKCFucCkgew0K
Pj4gLSAgICAgICAgICAgICByZXQgPSAtRU5PREVWOw0KPj4gLSAgICAgICAgICAgICBnb3RvIHVu
bWFwOw0KPj4gLSAgICAgfQ0KPj4gKyAgICAgaWYgKGF0OTFfc2hkd2MtPnJjZmctPmRkcmMudHlw
ZV9tYXNrKSB7DQo+PiArICAgICAgICAgICAgIG5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUo
TlVMTCwgTlVMTCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiYXRtZWwsc2FtYTVkMy1kZHJhbWMiKTsNCj4+ICsgICAgICAgICAgICAgaWYgKCFucCkgew0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FTk9ERVY7DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgZ290byB1bm1hcDsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4NCj4+IC0gICAgIGF0
OTFfc2hkd2MtPm1wZGRyY19iYXNlID0gb2ZfaW9tYXAobnAsIDApOw0KPj4gLSAgICAgb2Zfbm9k
ZV9wdXQobnApOw0KPj4gKyAgICAgICAgICAgICBhdDkxX3NoZHdjLT5tcGRkcmNfYmFzZSA9IG9m
X2lvbWFwKG5wLCAwKTsNCj4+ICsgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobnApOw0KPj4NCj4+
IC0gICAgIGlmICghYXQ5MV9zaGR3Yy0+bXBkZHJjX2Jhc2UpIHsNCj4+IC0gICAgICAgICAgICAg
cmV0ID0gLUVOT01FTTsNCj4+IC0gICAgICAgICAgICAgZ290byB1bm1hcDsNCj4+ICsgICAgICAg
ICAgICAgaWYgKCFhdDkxX3NoZHdjLT5tcGRkcmNfYmFzZSkgew0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgIHJldCA9IC1FTk9NRU07DQo+PiArICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1h
cDsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgICAgICBkZHJfdHlwZSA9
IHJlYWRsKGF0OTFfc2hkd2MtPm1wZGRyY19iYXNlICsNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhdDkxX3NoZHdjLT5yY2ZnLT5kZHJjLnR5cGVfb2Zmc2V0KSAmDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYXQ5MV9zaGR3Yy0+cmNmZy0+ZGRyYy50eXBlX21h
c2s7DQo+PiArICAgICAgICAgICAgIGlmIChkZHJfdHlwZSAhPSBBVDkxX0REUlNEUkNfTURfTFBE
RFIyICYmDQo+PiArICAgICAgICAgICAgICAgICBkZHJfdHlwZSAhPSBBVDkxX0REUlNEUkNfTURf
TFBERFIzKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgaW91bm1hcChhdDkxX3NoZHdjLT5t
cGRkcmNfYmFzZSk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgYXQ5MV9zaGR3Yy0+bXBkZHJj
X2Jhc2UgPSBOVUxMOw0KPj4gKyAgICAgICAgICAgICB9DQo+PiAgICAgICB9DQo+Pg0KPj4gICAg
ICAgcG1fcG93ZXJfb2ZmID0gYXQ5MV9wb3dlcm9mZjsNCj4+DQo+PiAtICAgICBkZHJfdHlwZSA9
IHJlYWRsKGF0OTFfc2hkd2MtPm1wZGRyY19iYXNlICsgQVQ5MV9ERFJTRFJDX01EUikgJg0KPj4g
LSAgICAgICAgICAgICAgICAgICAgICBBVDkxX0REUlNEUkNfTUQ7DQo+PiAtICAgICBpZiAoZGRy
X3R5cGUgIT0gQVQ5MV9ERFJTRFJDX01EX0xQRERSMiAmJg0KPj4gLSAgICAgICAgIGRkcl90eXBl
ICE9IEFUOTFfRERSU0RSQ19NRF9MUEREUjMpIHsNCj4+IC0gICAgICAgICAgICAgaW91bm1hcChh
dDkxX3NoZHdjLT5tcGRkcmNfYmFzZSk7DQo+PiAtICAgICAgICAgICAgIGF0OTFfc2hkd2MtPm1w
ZGRyY19iYXNlID0gTlVMTDsNCj4+IC0gICAgIH0NCj4+IC0NCj4+ICAgICAgIHJldHVybiAwOw0K
Pj4NCj4+ICB1bm1hcDoNCj4+IC0tDQo+PiAyLjcuNA0KPj4NCj4gDQo+IC0tDQo+IEFsZXhhbmRy
ZSBCZWxsb25pLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJp
bmcNCj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KPiA=
