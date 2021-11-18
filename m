Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD145544A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 06:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbhKRFaP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 00:30:15 -0500
Received: from mail-db8eur05on2083.outbound.protection.outlook.com ([40.107.20.83]:22624
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242431AbhKRFaO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Nov 2021 00:30:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgQejkjyy6pUa+n75sFqmLzprfzc2rJ2aYskEyGxQsfspr78/YniCMWW9XymxVKkkzzTd8awvvn9Ixb3+eZTd1hnRINHrC3NtGiGZj0aNWvT/zaIaKlV6aYIH5JQ1Dl+MyQWVStu4qP2tS/SrkSecKvPQIMcl3CNXRkVrQwRSgYPwVerYaYDl3/YGtpIrS0DG2DnLDmS/JkDAgTpSY2zdo6FTQzxjj9k6brj2e1OkGsnEd93J7rdJLDsZI5imv+/xuMtLHiljYOBst3SRSbJH1DC3gOHR38mqhsevdZfxZdgu1pieT8CE+UBQ/Dnd/Qw4p+zuKemz75oz8xbrqk0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1InoDr3HQku+SduKbtzSO7VnlKQ5rwa40TmNpGw0ltM=;
 b=WQsl3zD8HrDl3Oy+pGeCs+EOzME8flkWD7ZK1vW+Sh5Ct9ouMbXzZnBqPSu9IySIg2pH3H5g/94vo5NUEqEwsJ1v5LYU7vHdeM2p4SI1cnkjByKSZTd/Y82111ET8yYamkB1jUaL/DQ/mqK7wWl4r0LMrB6yiLdGb/HjQ253atV/XGkopfeK8eyPduHylywzyBgUyuQQU9CoNzxhH0BdBDAFTRNNCncodRKUd7/dOi13K+N/NwRBJjMjeNf8XZBdf/HzvGhKde1X8Zvp4TUtin0xj0esgvHmvC1AkOpgp+uxVKiWSBLvirFB2Vo+RaS/mwm+j1C2xsHy7E3UZZ51Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1InoDr3HQku+SduKbtzSO7VnlKQ5rwa40TmNpGw0ltM=;
 b=jagidpOtGXEhozsNDidX9FYdqMkPd/K43F2sCdJLa8QVWLMWHkck5a1Aoj/pIjKriFm0eUVp2D/7mcTFvz9K3Kh2ktVbfRfqD9NE1V6qprhytD00RPMu6iMMPcc91BssZehblsPYdVaYWuT7IvaVYxdR15c6GdT4gdoh62bW8es=
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com (2603:10a6:6:37::21) by
 DBAPR03MB6517.eurprd03.prod.outlook.com (2603:10a6:10:19a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Thu, 18 Nov 2021 05:27:13 +0000
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::65a0:9648:47b:5be4]) by DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::65a0:9648:47b:5be4%5]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 05:27:13 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 1/9] dt-bindings: battery: Add temperature-capacity
 degradation table
Thread-Topic: [RFC PATCH v3 1/9] dt-bindings: battery: Add
 temperature-capacity degradation table
Thread-Index: AQHX2uT4RKnOSmYYpEGsXKekwlA/i6wIiXeAgAA6nwA=
Date:   Thu, 18 Nov 2021 05:27:13 +0000
Message-ID: <16489e77-4cfd-4185-1a7c-4a3fc41dd290@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <740503b6b6439e01959016223f1ae464e82824c3.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdYE1r6mYAJsaMB9XyZjjAK-bGw3-9jhOpUFASWgkXaQBQ@mail.gmail.com>
In-Reply-To: <CACRpkdYE1r6mYAJsaMB9XyZjjAK-bGw3-9jhOpUFASWgkXaQBQ@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53a0ec00-3308-4685-fc44-08d9aa541388
x-ms-traffictypediagnostic: DBAPR03MB6517:
x-microsoft-antispam-prvs: <DBAPR03MB6517761442493DE95E6A32AAAD9B9@DBAPR03MB6517.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTK/8huZLfq2nqhrG6wiFHHvGSzvLTkOS8Zw5GVvHbFN1oXxy7jcRDdyf5evPRRqj/b5PDXsLzO6ei6AU7PFs5wkFuqqOoJ/8nakSEvTRqOPcoCSfG6Q1UGZVWp9SqPaz2NhSli64Q1NwkVPT+Ak8hvA4TNew3cyV8aw+vPCfN7VEvUHKS7qKHSc5W4J9WUHarmMMfGvzVoUwv6tOYRttVUdQDSBA2iBk5ioIzjrCxo2/G4Ifbj8StfR4MKyaQV+CjxMgQbpGPFls39rZkpidLs3wSh6EE052bxQzRCu0wyxFx4lKVfO+gRb1/EXckdHRfP7ijgTYtBwbg+kNfoLXQOwhGdnMYzo1CJuY1TyW8DViIX3iKDAxGoOdTX6u0Rk82OlfyDW2usPPs6iSxxKS4Za4e3sQ3QFhkvat7s1U2M41fWNjJdtViqTEUmuvUUVu0YHD56V+LyPYOVLZzJXTME6JgAG4Q5YwTYgdfOsXfVrEWxdW1OLFubUO541TXBJHbxOxmt9xjIO1jfOV+dOKnj4IIupHbfO/dqNndCcZzb1DmQ3EBE7ma3a5wJ5QOLRywCkcVyR4sOXiv596+IekEyOb/zDM/L130PVGx6AuJlcoLdITA0AVM8l66fZ2WB9LFgrYhajA+p9RsovUhzowvkm8IPCV2VDxRYTJD6RuT8d+8jBbbrP2BNPOqH0GA3gqBCmoxnvT4lItc2a4uMyayjjSpbLKL67wtvXMMR4/b7jsF98yRh8CTBAgZrFjh0HVewetzPu/dO2WX9LgOX4bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3160.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(91956017)(66446008)(64756008)(66946007)(2906002)(66476007)(38070700005)(8676002)(6506007)(53546011)(5660300002)(66556008)(4326008)(31696002)(186003)(6486002)(316002)(54906003)(2616005)(83380400001)(86362001)(7416002)(8936002)(6512007)(38100700002)(107886003)(71200400001)(6916009)(31686004)(508600001)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0FNRU1BeG94TmlDWUY5L0lmeEthMVpGUDlZdEY2YVhqMTV5c2kyY1VDaXJL?=
 =?utf-8?B?dDZHdnVjUWY5OUdZZ2cvbEErU2Z2ZGc3bUZhaXZZVU5PKzNzL2M0WmEzakFS?=
 =?utf-8?B?cGkrR1FXdVhWNlJzbTJVbU1Dc1dmMmtJSmN3RXhIb2lkem1xcXpkZndsNEhJ?=
 =?utf-8?B?TGswR1AvQTVGV3BxV0crbGtqc2REMXREa1pBMWNOSGhFL0FiRUltdG9XbnJ6?=
 =?utf-8?B?UlppNElOYjZVRGxZcysreURtaEVtU1RMdFNOdGZ5dTVzaGs3YnVKRXlNUXgx?=
 =?utf-8?B?SlNPZHdhVmU4U05hcmNPUzkwdVFWOURJMDRRWXZESDZBcERldGJSVEs1SWo2?=
 =?utf-8?B?cnN4cWhWSWQ5Vk5nY3VxV2JleWFOeUVDS1FKUnFiM3k2R3lxMHNENkd6K1dq?=
 =?utf-8?B?VlQ5NGtLK3h5MWF0NFMrOUZDUnFXbUtBZCtQeFV3QUxQbEI1eWJZQTREZHlx?=
 =?utf-8?B?d21hNUkwOXpzaDE2aGU0eXhOK2ZGcU1sNFVsY1RHZ0xta1JpZE5TTENJSkFI?=
 =?utf-8?B?SDRyRXNUWkNXcllvNktqSXpnVzhCb1NQZi9Zek0vaHIvRUlmbkNCcld5MnAx?=
 =?utf-8?B?NnNxNzZNOEhVZTJGZzc0dkY3YllLWUdrSUs5U0tLSndOdkhKcFkyNUZhdkVF?=
 =?utf-8?B?SXQweWJhSDJxUjlGYWhXZDg2K0JibDJsMnhBSlRmRDhmZTdhZTN3bU9JdGQ5?=
 =?utf-8?B?L0E1VkdGOHI4cUdXaVZSQUd0cU5ET09TaVp5MmxKbVdXeGEzTStGS0ZXT0ZY?=
 =?utf-8?B?dkhwbU1VUWZzRmZEblY0Tld1c1NGT3h5Y2E0RVpTSUJUVitzTjNHeDAwNlZW?=
 =?utf-8?B?UUs3QjlVWmlYbHZnUDhTS2FKYkY1N2swVjQ2S3VXY2RXcEFPVUJBTE05ekMy?=
 =?utf-8?B?bjdnUjBsNE5FRjBmUlN0bEFUbzQ2L2VSMVZTblBPS050dmNrTktoaHZjSng2?=
 =?utf-8?B?Vm8xZmJ5Q1FoZGhPc0FuelFpdXdNSUVhMzdibnRBQytuYjZjY09hTXBDSzdo?=
 =?utf-8?B?bk5ZMWZqemNVSmZWVEZaNFFGRGpJYUZsdENCdy9oVjFFRDAvRHhRRStQbEdJ?=
 =?utf-8?B?cTdDNEFKZitjS2d6RnplTnYva1ltclJsc0FINXpvK2hQVEp0M2pBaUsvMkR4?=
 =?utf-8?B?Yk5MZU93VDcvVDJheVVXS2tQK3VodTV1QSswVUkvU08wa0xadGtLd1c2eTJm?=
 =?utf-8?B?SmN5U1RZSWlnNkJIRE50ZXBybmdrNDJRMDB3VFdQa0hSTjRNUjBQU2tBUUhE?=
 =?utf-8?B?SDJXU2NpajZjVUhDanlSN09pWHRyVzBVK0VkQUwyZnFZd2Y0OXkwdXJuem1B?=
 =?utf-8?B?WGNxQzdsYjc3T1plZzFTU01Bc2VmbytEdWZlWjRKWTZtbG50TjZaVDVLWVlO?=
 =?utf-8?B?d0ZFQUYycG1qUVlUOGZDSGZEMHVvRlpIblBPU0VXNnVRV0llaS8zdlB2MmRI?=
 =?utf-8?B?UU1hUGU3cU1xNHlRNlNoS2RqZ1JUWnA1ZGZBb2ViOHQ5Y2RjRXBwUTVNMnoz?=
 =?utf-8?B?UXJNb0NQS1pCWG93ajlCVjVKOWliNjNUMUdGUjg2KzVqNjRodVdyZ3BKWXFW?=
 =?utf-8?B?TlFpb0R0Y3pTYUp6N01BM05mY3NEZEJVdC9PMWhIMTVsSkhJdVA4QSszMjBz?=
 =?utf-8?B?RzU3Y1Raa2ptalArajZiUjNnUkc5eUhoTXVoZ3BLa1pIMlRhMnhOSkt0NHhl?=
 =?utf-8?B?dXlZMlFVYnZVay9LNUhwWHJqenFlRVoyZGhQNHM4dWZyOVFaZXBpdHQyb0tm?=
 =?utf-8?B?Y28ySCtBQXhZTGNqRUY1MTVCM2VZd3dMVys4S2c2aFZXYkF1YjRlV2JjblQz?=
 =?utf-8?B?ZHd3aEU2RzY4dTNUamNxSFlNTkEyQ3ZBcXdvUE1KMDFrbmFNRU1JdDlqQmNH?=
 =?utf-8?B?Q0oyT25yeTFHblY2cXA5ZlZybUFudldBUGpPZlFoRk94cUNWYkxlNkdrbERX?=
 =?utf-8?B?T1M1VU9GS2E2VzdSc1llUWdXUlNpSXBvQjc3dWZxeWp2clkrM1h2cTIzRlYr?=
 =?utf-8?B?Wm4zY09ORmU5dThwS05KYjl0Q2c3Wk5wZUQ5S016SUNxcUJ4M0VWTkpDS2Iw?=
 =?utf-8?B?UWo5YzhSb2RIWFRoc200TmF5T3VDcStjMHAwVWxqeGM5ZmhNQVBFTHA5MW02?=
 =?utf-8?B?aklZVWhjTmxSd01PQjRvY0tuYXUxTHdBOWdTMU9scG1wbTQwSElNOHdtcW5R?=
 =?utf-8?B?aTVVaUYxaHZjYW9wL1hRL3h4SWFTTDlSMHU1bXZIa0dSa1J3c3dDeEpQOXFr?=
 =?utf-8?B?dmFOYm1HSVRxVmFSMVdMV3lGYVZJcXhmU2JocHVUUkQwcUtGbzNhakdVWVlJ?=
 =?utf-8?B?YVAyVmlqSkxrNTN3MWo3ME0xS3RqMUtNcW9sS3Q2blJZUUMvTUJ6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2F14A3E44435446B10767F0E9FD4302@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3160.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a0ec00-3308-4685-fc44-08d9aa541388
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 05:27:13.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmDEnjSqbSnwkxnbuC6g1ERhqWRfwIB93jO0laYA7ZGg+A+Qeldfpe8/FgTmWVwSO6GdUUjWMLacJDRv/x8GpWIbvogdUXRKaUrb7MlmB8j+CUbC+nNbPu1AmNxXTrnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6517
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgZGVlZSBIbyBwZWVwcyENCg0KT24gMTEvMTgvMjEgMDM6NTcsIExpbnVzIFdhbGxlaWogd3Jv
dGU6DQo+IE9uIFR1ZSwgTm92IDE2LCAyMDIxIGF0IDE6MjQgUE0gTWF0dGkgVmFpdHRpbmVuDQo+
IDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+IHdyb3RlOg0KPiANCj4+IFNvbWUg
Y2hhcmdlci9iYXR0ZXJ5IHZlbmRvcnMgZGVzY3JpYmUgdGhlIHRlbXBlcmF0dXJlIGltcGFjdCB0
bw0KPj4gYmF0dGVyeSBjYXBhY2l0eSBieSBwcm92aWRpbmcgdGFibGVzIHdpdGggY2FwYWNpdHkg
Y2hhbmdlIGF0DQo+PiBnaXZlbiB0ZW1wZXJhdHVyZS4gU3VwcG9ydCBwcm92aWRpbmcgdGhpcyB0
ZW1wZXJhdHVyZSAtIGNhcGFjaXR5DQo+PiBkZXBlbmRlbmN5IHVzaW5nIHRoZSBzaW1wbGUtYmF0
dGVyeSBEVCBub2Rlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1h
dHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gDQo+IFNpbmNlIHdlIGFscmVhZHkg
c3VwcG9ydCBwcm92aWRpbmcgdGhlIGNhcGFjaXR5IGF0IGRpZmZlcmVudA0KPiB0ZW1wZXJhdHVy
ZXMgdXNpbmcgb2N2LWNhcGFjaXR5LWNlbHNpdXMgYW5kIHRoZSBhcnJheSBvZg0KPiBhcnJheXMg
b2N2LWNhcGFjaXR5LXRhYmxlLTAsIDEsIDIuLi4geW91IGFyZSBpbnRyb2R1Y2luZyBhDQo+IHNl
Y29uZCBwYXJhbGxlbCBtZXRob2Qgb2YgZGVzY3JpYmluZyBob3cgY2FwYWNpdHkgY2hhbmdlcw0K
PiBpbiBhY2NvcmRhbmNlIHdpdGggdGVtcGVyYXR1cmUsIHJpZ2h0Pw0KDQpPaCwgcmlnaHQuIFRo
aXMgaXMgd2h5IHNlbmRpbmcgb3V0IFJGQ3MgYXQgZWFybHkgc3RhZ2UgY2FuIGJlIGJlbmVmaWNp
YWwgOikNCg0KVGhlIHdheSBJIGhhdmUgc2VlbiBPQ1YtQ0FQIGFuZCBURU1QLUNBUCAnZGVwZW5k
ZW5jaWVzJyBtb2RlbGxlZCBoYXMgDQpiZWVuIHRoYXQgdGhlIE9DVi1DQVAgaXMgZGVmaW5lZCBv
bmx5IGluIG9uZSB0ZW1wZXJhdHVyZSAoc2F5LCAyNSBDKS4NCg0KVGhlIGltcGFjdCBvZiB0aGUg
dGVtcGVyYXR1cmUgaGFzIHRoZW4gYmVlbiBlc3RpbWF0ZWQgYnkgc3RvcmluZyB2YWx1ZXMgDQp3
aGljaCByZWZsZWN0IHRoZSBkZWx0YSBDQVAgd2hlbiB0ZW1wZXJhdHVyZSBjaGFuZ2VzIGZyb20g
dGhpcyAnbm9taW5hbCANCnRlbXBlcmF0dXJlJy4gSGVuY2UgaXQgbmV2ZXIgZXZlbiBjcm9zc2Vk
IG15IG1pbmQgdGhhdCB0aGUgdGVtcGVyYXR1cmUgDQppbXBhY3QgdG8gQ0FQIHNob3VsZCBhY3R1
YWxseSBiZSBtb2RlbGxlZCBpbiBPQ1YgdGFibGVzLg0KDQo+IFdoYXQgZG8geW91IGV4cGVjdCB0
byBoYXBwZW4gaWYgc29tZW9uZSBzcGVjaWZpZXMgYm90aD8NCg0KUmlnaHQuIEkgc2VlIHRoaXMg
bm93LiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiB3b3VsZCBpbmRlZWQgYXBwbHkgdGhlIA0K
dGVtcGVyYXR1cmUgaW1wYWN0IHR3aWNlLiBJIGRpZG4ndCBldmVuIHRoaW5rIG9mIHRoaXMgYXMg
d2UgaGF2ZSBvbmx5IA0KcHJvdmlkZWQgdGhlIE9DVi1DQVAgZm9yIG9uZSB0ZW1wZXJhdHVyZS4N
Cg0KPiBJZiB0aGlzIGlzIGFuIGVpdGhlci9vciBzaXR1YXRpb24gdGhlbiB0aGUgc2NoZW1hIGhh
cyB0bw0KPiBndWFyYW50ZWUgdGhlIGV4Y2x1c2l2ZW5lc3MgZm9yIGVhY2guDQo+IA0KPiAoSSB3
b3VsZCBwcm9iYWJseSBqdXN0IHVzZSB0aGUgZm9ybXVsYSB5b3UgaGF2ZSB0byBjYWxjdWxhdGUN
Cj4gYSBmZXcgdGFibGVzIHVzaW5nIHRoZSBleGlzdGluZyBtZXRob2QgYnV0IHRoYXQncyBqdXN0
IG1lLikNCg0KSSBuZWVkIHRvIHRyeSB0byBmaW5kIG91dCBob3cgdGhlIHRlbXBlcmF0dXJlLWRl
Z3JhZGF0aW9uIGlzIHJlYWxseSB1c2VkIA0KaW4gc2V0dXBzIHdoaWNoIHVzZSBvdXIgY2hhcmdl
cnMgKHNpZ2guIHRoaXMgaXMgYWx3YXlzIHRoZSBoYXJkIHBhcnQgZm9yIA0KbWUpIGFuZCBzZWUg
aWYgd2UgY2FuIHJlcGxhY2UgdGhlIHRlbXAtZGVncmFkYXRpb24gdGFibGUgYnkgc2V2ZXJhbCAN
Ck9DVi1DQVAgdGFibGVzIGZvciBkaWZmZXJlbnQgdGVtcGVyYXR1cmVzLiBJIGFtIGFmcmFpZCB3
ZSBtYXkgbGFjayB0aGUgDQpPQ1YgaW5mb3JtYXRpb24gZm9yIGRpZmZlcmVudCB0ZW1wZXJhdHVy
ZXMgLSBidXQgSSdsbCBzZWUuIEknZCByYXRoZXIgDQpub3QgYWRkIG92ZXJsYXBwaW5nIHByb3Bl
cnRpZXMuDQoNCkFueXdheXMgLSBUaGFua3MgYSBsb3QgTGludXMgZm9yIGdpdmluZyBtZSBhbm90
aGVyIHZpZXcgb24gdGhpcyA6KSANCllvdSdyZSByZWFsbHkgaGVscGZ1bC4NCg0KQmVzdCBSZWdh
cmRzDQogICAgIC0tTWF0dGkNCg0KLS0gDQpUaGUgTGludXggS2VybmVsIGd1eSBhdCBST0hNIFNl
bWljb25kdWN0b3JzDQoNCk1hdHRpIFZhaXR0aW5lbiwgTGludXggZGV2aWNlIGRyaXZlcnMNClJP
SE0gU2VtaWNvbmR1Y3RvcnMsIEZpbmxhbmQgU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0KOTAy
MjAgT1VMVQ0KRklOTEFORA0KDQp+fiB0aGlzIHllYXIgaXMgdGhlIHllYXIgb2YgYSBzaWduYXR1
cmUgd3JpdGVycyBibG9jayB+fg0K
