Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48A339D296
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 03:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFGB30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 21:29:26 -0400
Received: from mail-eopbgr1410107.outbound.protection.outlook.com ([40.107.141.107]:14720
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229932AbhFGB3Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Jun 2021 21:29:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWL5iPw2JN4jxULLM1PP5pdlqcOaBRDGfXkT3G2qrDuHDyEW/u9B3dMZu/YqeazaEbtdwAQl1R/6iJsp7OTqszedSs44As8jms3j+zX+RD3zXph+KkuKTr18yo6ddyUr2QW90MRnDObTde24AyUuc//tjSyKWU1JdbxDZZYSepmfnSjr2g57Qqu6kkbkU3ZiJa1pz5mZgoRdzkDLAPIhjCFl+DK2ibF28zkBNX9z0nwlDZPakikXDKAbzmXUrtir2X+WaENGciAH1gyJTychk0k6vTsy0fsi7PB5TcuPLF7vkFuLDjYPFWdPIpUvbBmLfwkV3+DXNtjL40Hmk+88Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKSWM3W/v5g1e3RdRt/xY6hq40B2Cc6wApO4T2nlYe4=;
 b=PqrvZJH/Hve52YURDVD/HKV80HU7kAGuLTGP7m+uVNtf+ZiOBhHhswzqu/uafh92VqSUwlqK5UDyuiEo/OhtwdnH01tcNLUIS06TJ5cZpaWLSMb7TJCRe3771eRtaPAg2bEmryl/ImXx9/2KMzkL+CCZkDAqQs1Xld92jnmBtFklx+4vH96dY7ZVZblS3dHcX9lgbC/klvK1LInP/poULeMm08w2wco8QaEatve0RFZsq8y0+vurC+mqUpqwMOqlJDJmeUVNJkoU1Cnwmhwz448eu+S9Z2VtkeQFuF/6umRZLTLAaLkkfxNO0whOlmcFEnpQr/vApJpWTa1pOWq8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKSWM3W/v5g1e3RdRt/xY6hq40B2Cc6wApO4T2nlYe4=;
 b=RWOJhJNqqZRtp5BHlT5jChtg9ugmIFj0ZzEJe890U3IxqU1hFLwAOgfpPrDaJ0qmFUSFBVKCFi3OIo/5swnP2zN29ASzoH2w/jaN/ICRiYicDHxH03ll7keAA/PKFZzCSNx7PttoHy6Vcn5agCeXfqZJwSyUF2NWzbiOY9V208o=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB5643.jpnprd01.prod.outlook.com (2603:1096:404:8057::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 01:27:32 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::4c5d:66ee:883a:72a5]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::4c5d:66ee:883a:72a5%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 01:27:32 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] thermal: rcar_gen3_thermal: Fix coefficient calculations
Thread-Topic: [PATCH] thermal: rcar_gen3_thermal: Fix coefficient calculations
Thread-Index: AQHXWegdcxrRUgVh9EGnBPU56I7smqsHw47Q
Date:   Mon, 7 Jun 2021 01:27:31 +0000
Message-ID: <TY2PR01MB3692189F346DA86A82E454CED8389@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210605085211.564909-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20210605085211.564909-1-niklas.soderlund+renesas@ragnatech.se>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ragnatech.se; dkim=none (message not signed)
 header.d=none;ragnatech.se; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:1558:d4b0:2481:8988]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e9be257-2ea8-4232-3878-08d929536c70
x-ms-traffictypediagnostic: TYAPR01MB5643:
x-microsoft-antispam-prvs: <TYAPR01MB5643A52B0C126C2656504940D8389@TYAPR01MB5643.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xb1pkCdQ1bXNDk1M9talZKUIwyO4JL/2c9xtdupWnixuGrcCFDhlQLsGU2LElpYvyOkfbrChkmnfLmUVOYj5PGBY39Ogc6rYE1bj0HEwc6G2Ra2aVMCcHqdYVp1FPTxx2XSO4lgK0OkmDai4cbGt6G0yOym121jQt7Jy08gIgONiQ0/5GJq40fPBopoGPc5GaY5qfWkGOVy2ien9jYCqVH5AduemchmgQ5T2wVOVLfmyP7tHWvbLecTHdWCn7MPW0c01YFMA0mBPJWVUZcOXj051hS/ZjGUL8iexwJ5HIZtspWFvSRLoEYIJ0AI+Vq4wZ2UoHMpRiWXJnlCMHuQUy4IFcwsxlC0aNJQPGHDZru09YOlLJ/X8bWAxJxPpuCJIIXQNHffsLeKnZX92BfflJhWwJS4NMFFWc3eDHUY+LPqf+Qnh8Nfnbt8HpOHafRZTRJJ6EOSPq0mebjCyHMBiB4qC16w5YB8/RMufDhoUPd7UGbudpL4VBsmtwXHVRCjNonD8+iFGEnm3AccRkIjn5I6OsvAAF9pcTVTwni+LGMC8j/SihAykyKqGjDChlK4kckQ94DLAKKxZ8s+hsFXCb345UhjsJis9vyWhe0XZFz0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(66946007)(76116006)(6506007)(71200400001)(7696005)(66574015)(38100700002)(66446008)(186003)(478600001)(110136005)(316002)(9686003)(33656002)(8936002)(66476007)(52536014)(8676002)(5660300002)(55016002)(122000001)(4744005)(2906002)(86362001)(83380400001)(66556008)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RDFaUC9seVptM1pGNDBpTnRYR1BqcmUxVkpYbEgvbGlUMSt0dVllVHcyVFdU?=
 =?utf-8?B?cFQ2Vk1KdHFONVY3VTV5M1NYb2ZFVGJxOUNMLzY3d09QNElxczRwdFhSdk5Z?=
 =?utf-8?B?aHhkbStOb1pPYlpkSkh6SC85cmYrb3hSTW1YankrYmxNR01PbWgvZzJTNnRJ?=
 =?utf-8?B?Rkx3d3dHTkxvMHFwcCtKRG9EcWE3NlUxTDQ0ZGJkdWJ5ay92aXdWN3lIODUr?=
 =?utf-8?B?blFpZXBWbVpMRWJLd29jOWN6ZTFhSmROUzdOS3lPS2FNVmttb2x0V3RYajJI?=
 =?utf-8?B?NDhXM1dNeXQ5RGg1ZGkrTmUyd00zQkNZMTViTlp5Si9qYk1aejNJRUFXVllE?=
 =?utf-8?B?NHZsbisxbTlXcEttVGRabmNLam5MZnBCV1RBeEpBYXpJV29qNngxTlNiYU1s?=
 =?utf-8?B?L0FnOUhFMm1OMlRyNzFHN2RuQlFnRTdpNVp2bGhUYW5pcThNSWdzaGZGY1Vl?=
 =?utf-8?B?MjMvVm9Uc2p6RENkcW1SNTlxL0VHeUl4RzFDTit6RjlydDlwTU1WZDdubzcr?=
 =?utf-8?B?b3o5ODdlVkVyZWxHNnZpeWlSSk0wcnpUaW5nbWhCeUkrVFBUTGlZamsrRmlT?=
 =?utf-8?B?RTVsUUpvKzMwYnNhVXFnZVpteTAzTi9TeDI2VjhCUGlDcnVoTEI4d1lGblk4?=
 =?utf-8?B?N2tXcUNUenlZWjIxVVR2K01vR1paZlg5TmVzb1NwZWlyaG45MmJsWFF0QzY1?=
 =?utf-8?B?Y2RHT0krNm1uWC9TdGR4Rm9UWjN6a2cveHMvZlpZYVlHZDhNcDFZUGhiN3RF?=
 =?utf-8?B?c2VzdEhFdFhwZi80VHkyM2RjZDVvRnRwY2puL1lNL25ESGhOVjB3UnBpQ1JX?=
 =?utf-8?B?ZVJ1UjNjM2R3TC9EWTEyeWw0ZEZhWXlxSDN1c0JhWDhFemJYbVducXREWTdj?=
 =?utf-8?B?Z0d5cFdOa0hpNzBrSlVPNkpGcDFPSzg2R0JoUllnWkxzUlRLczFPa3dVQWN3?=
 =?utf-8?B?dktzNDZtTS9CSi9KeTlWTHF1UlBWbWx6dlBlcC8vTnZhbmRFM3YvS3gvZ1Y2?=
 =?utf-8?B?NURadzNFTk1XKytOUmRmY24yZkdqb1FuQlBmdG1JTkdWY1hPY3Vod1FDVjhJ?=
 =?utf-8?B?Tzlyb3pXd0IyVUNGdi8zeU9rcy9PWHZtTy9aYUp1VnBzZG1LRGdwWk4wSTJH?=
 =?utf-8?B?QmE1WkQ0K1E2VjFsZnlSQUtyMkJsbmtWVnFpSFc3RTVuQUExbEFrOEtFWUtR?=
 =?utf-8?B?TW1DMmNWOFlTaXNaMG9lekFxRHhraW9OT1YxbkkrZWxicG5RUWhMbUZOWTJ5?=
 =?utf-8?B?cnhGWjBaZHcwdE1OSVdOeWE5R0l1VWxYeERhR0FpTHd5OG5uV1duT2YzTGda?=
 =?utf-8?B?dEJmbmxJWUJLRXZuMXlaTTNQYmQ0MmpUUHcwamlUQ0tLUHNNL3dMb1g1Y0R5?=
 =?utf-8?B?NWU2VXppVjhUbWVmdUhWYXNmUENMWXhGM2FjczlVV0cwWTB5YmQ1Q2NVTjRG?=
 =?utf-8?B?U1BMSm1pR2FXaEdBVVlCQlpDNUxXVk40YXZjWHhFOFRRaVBTbnNQL1A5U0tB?=
 =?utf-8?B?QTZGSzVHdVpMeDhWeURTZXdJUVN2bmxXNjNFcnZ0LzNmMWxkS0RiZUpqNlZJ?=
 =?utf-8?B?SzlPQVNPcjVYL2FnNjJCb2ljYW4wWDM1Z0xqbkJFMXhaWmt3QTA2SlBaQVhW?=
 =?utf-8?B?R0RYMkpKNC9KdWoxaDR2b05na1NUYWRKMmJjNFJScWxlNEhvbzcyZ3VjSVNW?=
 =?utf-8?B?dTRrZTF6Q3docGJSK0VOVEkyNnVpcExsRUp5NHBRL1loMW55ak1qbHoyaUpy?=
 =?utf-8?B?dnRIZjB5UDN3RDVhdEc3b2tKakIzZUlPMlUyYlh6dTRGQS91NHIyZVI2Mi9r?=
 =?utf-8?Q?PyDUhIqQ6ewc4gvtmvydhf1QY5doQPS87TwgA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9be257-2ea8-4232-3878-08d929536c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 01:27:32.6314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8p7cE3Frr4xgl6BjRVlk9cnxe8kf2268pPgwKcnJsSTYTpioXVeUuVH1x6hz0IlpK3ITyyjcOifXN4+u2nC0i3yITumNdiQ4MeoibM4rO6jp/7egrygRjKgEt45nxWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5643
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgTmlrbGFzLXNhbiwNCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghDQoNCj4gRnJvbTogTmlr
bGFzIFPDtmRlcmx1bmQsIFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDUsIDIwMjEgNTo1MiBQTQ0KPiAN
Cj4gVGhlIGZpeGVkIHZhbHVlIG9mIDE1NyB1c2VkIGluIHRoZSBjYWxjdWxhdGlvbnMgYXJlIG9u
bHkgY29ycmVjdCBmb3INCj4gTTMtVywgb24gb3RoZXIgR2VuMyBTb0MgaXQgc2hvdWxkIGJlIDE2
Ny4gVGhlIGNvbnN0YW50IGNhbiBiZSBkZXJpdmVkDQo+IGNvcnJlY3RseSBmcm9tIHRoZSBzdGF0
aWMgVEpfMyBjb25zdGFudCBhbmQgdGhlIFNvQyBzcGVjaWZpYyBUSl8xIHZhbHVlLg0KPiBVcGRh
dGUgdGhlIGNhbGN1bGF0aW9uIGJlIGNvcnJlY3Qgb24gYWxsIEdlbjMgU29Dcy4NCj4gDQo+IFJl
cG9ydGVkLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNh
cy5jb20+DQoNCkkgdGhpbmsgYWRkaW5nIEZpeGVzIHRhZyBsaWtlIGJlbG93IGlzIHVzZWZ1bCBm
b3IgYmFja3BvcnRpbmcgdG8gTFRTLg0KDQpGaXhlczogNGViMzlmNzllZjQ0ICgidGhlcm1hbDog
cmNhcl9nZW4zX3RoZXJtYWw6IFVwZGF0ZSB2YWx1ZSBvZiBUal8xIikNCg0KPiBTaWduZWQtb2Zm
LWJ5OiBOaWtsYXMgU8O2ZGVybHVuZCA8bmlrbGFzLnNvZGVybHVuZCtyZW5lc2FzQHJhZ25hdGVj
aC5zZT4NCg0KQWZ0ZXIgYWRkaW5nIHRoZSBGaXhlcyB0YWcsDQoNClJldmlld2VkLWJ5OiBZb3No
aWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQoNCkJlc3Qg
cmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCg==
