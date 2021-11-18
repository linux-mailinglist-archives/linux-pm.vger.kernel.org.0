Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643D845544D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 06:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbhKRFd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 00:33:58 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:28992
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242431AbhKRFdy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Nov 2021 00:33:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P49e7rajamYqjzVpZiLxQtC3hcai3q/XQqr4PEqnxxklwVfUqADasTmHtJq/Tj8wrWsZd4XcAPbRNcsN5DFyqk1bhGjjxfjV5ON3ApMpAJFhPQJkpeAehQ9bqhkw4ivo0Ynq4V1LQ4GSkwpCLWKF4qB9NfSVguVnDSKf3vOKr9ymf4xi8n6TKcBa3Eq7zpj8s1TtbvQsubTmNLQTO9o0KGY147S31RpfJIO2KNfWJo8tm+FPXfQVzJ1erv5oPHfqBgN7bi+X0EoNoQY+Ry5EyaeY3Mzu33iemhXpHoZnc+7KqoTYnsuI6F/YSR8eg3t/U/f6mpBEyteNHjRqC9Lgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R53eDOXtWu+PzYX088EmPIFkGHWi6tDlvUq2uSfTdoE=;
 b=HBD24rDLAPv8PYY3m9mc7QUvgqX4Sy2JY6vi642jE9sPvNA1MsX5fD/SN/FPBJ3/RAQhrf6Md5KJIDMJWz2Xnm6fwh4FtrgszDp2pzbgDN51q8FVa2aUOoh0ifJSCaYVb0fxsMtNZSbnHbL7ZPX5nr4tdsd0Lpwygh7L1JJS1mav+TZW4S2Y6nWA3gXcS8vu7VYBVvk8Doim1sexKBmrdKaeYPccTf7jIjNhHEraAPWOVD1jsm4avtdSoYV1zQNbW69rztX8gkoG/zT89QbnXTWYJqdGSzAJIQnJzlhRLIv9198/AxPtKn8GLiTd1r/qfSn8Trb94/xDz9Rlq24Qmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R53eDOXtWu+PzYX088EmPIFkGHWi6tDlvUq2uSfTdoE=;
 b=jjuuYBGoHR9VRtVDpoMO9+LAIvyTQPi9uFdPZ6bxSQnTH7K/HQG+5AQYPZx3N8qmJrkbIDW6ajI6/c6bqxRskEePUHEcuR+bKMYlMIbjPADg7A6km3SK08i4BgbOUsQZ/2pk/WfVHV5JtkxgOf8UhLLLMeSW8zb23Mk4fsEahwo=
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com (2603:10a6:6:37::21) by
 DB7PR03MB4203.eurprd03.prod.outlook.com (2603:10a6:10:1a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Thu, 18 Nov 2021 05:30:52 +0000
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::65a0:9648:47b:5be4]) by DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::65a0:9648:47b:5be4%5]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 05:30:52 +0000
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
Subject: Re: [RFC PATCH v3 2/9] power: supply: add cap2ocv batinfo helper
Thread-Topic: [RFC PATCH v3 2/9] power: supply: add cap2ocv batinfo helper
Thread-Index: AQHX2uUPoZOTgBgrmkG3TNqVj0R7ZawIitqAgAA6QYA=
Date:   Thu, 18 Nov 2021 05:30:51 +0000
Message-ID: <8cd66743-242f-f4dd-c767-1f37551c7e78@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <20cfdc60b148646a0473640a8efdb056b207c56e.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdZJ50Q94inqpNfo-x4ivEq50yiisP2KAFOu3hr1Y8+Yrg@mail.gmail.com>
In-Reply-To: <CACRpkdZJ50Q94inqpNfo-x4ivEq50yiisP2KAFOu3hr1Y8+Yrg@mail.gmail.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 447c51ce-283b-4a49-0d5f-08d9aa549612
x-ms-traffictypediagnostic: DB7PR03MB4203:
x-microsoft-antispam-prvs: <DB7PR03MB420376D46B9047BC6BE17ADFAD9B9@DB7PR03MB4203.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9XBByqg3anlgY6UTMnrWv4C/FyFrtixQwrTajgm9m2imS+mPgua7ylQEg8ZHGSS93anQTBoOnobwN5VBf5dDTIZDpEyY0Sc3apN7ySff8/sx9REaM3auzxDLw4ocHSitqZ5si5A9r04OdDQW7h8/vxCwZq3C5Jb4h8APNf2b6yHeRAZbGX7Xd61Q1gODccd3kKS07c3wN7/ByH0hts5Z95RPRGeM05lAWphFdn0WahIS8REm829BHVkAfwAV6QuhxOHUqLjdqwwxYfWa5LQVmTMqqNhzB9u9lAuetDlHTWUPvhLCIAIzl9ut3YmMECnYjAjfe+e41MlGbP8eJXNAZoGcxc8N4Ah5j8PSwmF2tXUYXHS7V4putRnUS+O26WcguGuFT8LUYPy25HoOj2gBIOvHp27rDddTwXKN1eGbnktMI4H+mcywUAK32SsNWGfC++kY475P4M50K16mxTEWd3RHuQlzBtupylsB8+e4Gpnv3sjJ5xyUlnr8myXh0RAsWrzleWRfj9BRY9ly05gxHcighZJHjxhiP1Rz9/Motlx84udWJh7CehsxXp3ofiyYxnkAgesY1kx9uGdZfzdWUHdC+HRvUPZvuTdQYrN0xwLf1vbdR2y71SH69s9tEEAEIm8Ptt98tcxGBTgYVKFv2vo+uhfZpoqWRuCQTszwoJcU9FUYH+uAhCiBJEHZHI7lBNEuHpFzPeudPrTBIBxd2kYAqIi+EMNhqQ0I0HhnWTw8/cfWqKEjV38nEbD/OAmUMNHrBbrmKMmP5rnOWhaGU9dZf4VJ9ExKN+wgREgXI0dEIcYbqlxjKF696J0YHoEWeQdSN1SgK8rK1J5sv4fI4q0hNwYctfwa1yXjVf6eSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3160.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(64756008)(186003)(38070700005)(2906002)(66556008)(508600001)(66446008)(38100700002)(66476007)(4326008)(122000001)(107886003)(6512007)(76116006)(6916009)(8936002)(66946007)(8676002)(6486002)(316002)(31686004)(83380400001)(54906003)(31696002)(5660300002)(86362001)(91956017)(2616005)(7416002)(966005)(53546011)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWVPOCsyZUNmRGp5RUxMK2VBd21QYXA3bm9OZ3BpQml1NHgzOExueE1ieEFG?=
 =?utf-8?B?ZjFNZ1FCbnZZUEQ2SENqK3FFalZXYnozNlk3RGE2dForbU5yMHNNOTBkQzBN?=
 =?utf-8?B?TWtndjRsNExEKzVMUDZhTTRKbkJFN2RhQmlIVTBXRUdZT21UTE5TL2UrRkwr?=
 =?utf-8?B?RVJodkQzbjNORDhkQjJTaDJVQUFIaUFuQ0x4cTNVeDFVUzgveXQzMVA4a0xI?=
 =?utf-8?B?aWJ2MGdLOFFoaWNycTF1SE8rNkdvWUZtak5LQjBOVEhHWVNHeEIycFpINHkr?=
 =?utf-8?B?TEVqSktqM1UwbHE3ZTEwM0x3aWEyRTRPTWZ3ZXB2YTFHMkJBK1BZalE2c1BF?=
 =?utf-8?B?bEkycUdMNmh1Yjk1Z0ZTaHlOSUp5SVJFU0c5YURzQURMYnlIZGZoVmhvUmo3?=
 =?utf-8?B?OVRXV2tIenFaK3N4R1c3UDQ3MWp6QXJvN0g5ckxLYVd2Y3NGQ3UyT2NhbU9l?=
 =?utf-8?B?VGRIaEJLM2pEQ0RLWEVJc2dHbFM0cGc5ZGh5U3kxS2xob3BLbDIwVVZ2YUlJ?=
 =?utf-8?B?QmVNY0VtSER2S1dST1BOVGlyNldoU213U3ZBWm9FZU5YdUxJK2d0bVVadEoz?=
 =?utf-8?B?QlkyZEdJM010SVc3SEI1VERJVzhjZStGMzE5WUk5dlhlYjVPRWp3ZGVmaldM?=
 =?utf-8?B?WlpHRG9od3VrM2k5amxtbnJxcjJKRm1sMERBTlptcVduNG5lOVE1VEFjUDJC?=
 =?utf-8?B?Um5lNU5FcFBHQnE5ZlBhRTlLU0RPeFd6c0V0dTRLRnlmZDMzN21KK1FjUVAr?=
 =?utf-8?B?dUFFNU9wWmRQL3M4NnZLdW5oM0JNaklCWjZ5U2pRajdMQTZNbEFuK1NxZzNP?=
 =?utf-8?B?OG9CTVF5OGI1RnFCS2M0WmJRcDh6TGlVUGhHL0svYUNzQWVFQldwOHhQU3dy?=
 =?utf-8?B?aW8vTGdnWU40S3NGallJbjVlRGREVnp5L2lTN1dYU0d1eFUzRWwzeHdiL01a?=
 =?utf-8?B?Nmdvb2treWNBNTBSKzRtRm91cDkrcjRIUGlqVnpCK1Y3S3A3NGNaQml6YVVF?=
 =?utf-8?B?Y285YVA1L1A3ZmU3M2d1WHZCNUR2Q0o0M3p0a0huaE5Mb3I4MHowaE9xZzBK?=
 =?utf-8?B?dzV4Mmc5akJQZDRtUDRNWTIrQVVUaHY1YjlwTENNOTlSR2d3Zks3dDVkbmM3?=
 =?utf-8?B?UWNpVHVXVFRuMC9USUhlTjBhbkM3SkJ6N09hOXRyZEZNYXJTNmtHb3ZCM0NT?=
 =?utf-8?B?TWZTWFlYN3RZZGxqazByMjh6emtDeU5KOEpNQkhFNVhlNWxwLzk4b2syK1ZM?=
 =?utf-8?B?bmlFbWtFRERDcDN0WnpTempTdDRBNE92cUp4eTJEYStSZnJrNjhINnoxRnd6?=
 =?utf-8?B?RnV5blNKRXp5dmphSUJhd2x6bjNlY2ZHemsrOXlkK0hUSGtUSGVxaFlvUFlF?=
 =?utf-8?B?cFZmRVVHeDFWZ3hkc0ptZ1EyZ1o3dytIM05QajJTem4rT0VlT3JFS2d3UXVP?=
 =?utf-8?B?aDdrYklsWWFIMkVpdUo5ZG9IZVJNVXM3M1lFQXBkRDk1RlpVMFhFMHdpUTFT?=
 =?utf-8?B?TGtsb0ZEazNTcXU0R29IaytvOXJGc1FpYnJxdGZZb0kwZE9XelR3bWlyMnBK?=
 =?utf-8?B?cVhTWEhNN1ZjbkpVaEVxMFhXeFZGYXJ6TCtLQmdBTloreUVtSG83WmszU1pl?=
 =?utf-8?B?OTNMNFlscktoeVpSRllSM0pvZ1h4Z0RyT2JGODJQVWhJNnh5dzA2T3VVN3g2?=
 =?utf-8?B?RlBjdnNkT3dobkxjTzZJODcrUWpBV3E2dmtqQUV2amtIbmJXKy9zYkVwL0Nk?=
 =?utf-8?B?MS9EQVpXTDJGNkp2ZncyemxJQXVURG1oUnY2VlJ3ZTIweWZ4V1lxUVVDZ3Jw?=
 =?utf-8?B?VVUzUlkwVHZuQW5LbTVuUUh5UEFSenNQaUd6L0xBVkNGMkVNbllRWDFkSlZ1?=
 =?utf-8?B?Um5nVFpiR2d6OHZzZEZjcDA5RzhkQTQrbStUT1kzd3JPNFNIcXNwVHQvdFNk?=
 =?utf-8?B?U1dlNGF6WjlwcEQvRk1QL1JIVVVtSFRkU0RTMTZTY1VaWlhuRXN6T2w4ajMx?=
 =?utf-8?B?cDFhdVFxREJkaUQ1bk9wbmFUYzdycTJSbWhiRGh1VzJxSnhvNk1qK29zYzBL?=
 =?utf-8?B?ejFuYlEwNmMwdkQwcm1NNGQ2ZDVvQktrUDN3RFZBQnozWnR1SjhGMStyNXZG?=
 =?utf-8?B?dHhwRU9kQ0h1ZGNTMnU5QVBFSmIrYzhKLzVpL1hNWExTaGxTd3MwMjVkbHkv?=
 =?utf-8?B?dEFmRVE5RlNVSDYwWW8za0k5WldYaEFSVTlrSFhNNGJ6VERySGRwK1FyQ3FM?=
 =?utf-8?B?eFVnQk51OFpUaDVEbURDWDFyaGV6anpEWUIzV1FGWUdrWEFzdzdLQ0NJenJz?=
 =?utf-8?B?bUJaTGtwSGJlcjIycGNtcVJIZUtXRVlSb2FaVXVFcm1RUnRZWjZrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <341AE22872552449B8EFB1E150A20A30@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3160.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447c51ce-283b-4a49-0d5f-08d9aa549612
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 05:30:52.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6LFf+kcqDc6x7Au3WfsCLMWSGtiODhPbUehUV9sv+hsBeReKB0seOBXyGjMnJlJDYAlpFpz2wFWhwEK1jfmlEWFCht1KZIJM0uZ4YTZw0B16F73rn/GZitGJScqwsr+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4203
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMTEvMTgvMjEgMDQ6MDIsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDE2
LCAyMDIxIGF0IDE6MjUgUE0gTWF0dGkgVmFpdHRpbmVuDQo+IDxtYXR0aS52YWl0dGluZW5AZmku
cm9obWV1cm9wZS5jb20+IHdyb3RlOg0KPiANCj4+IFRoZSBwb3dlci1zdXBwbHkgY29yZSBzdXBw
b3J0cyBjb25jZXB0IG9mIE9DViAoT3BlbiBDaXJjdWl0IFZvbHRhZ2UpID0+DQo+PiBTT0MgKFN0
YXRlIE9mIENoYXJnZSkgY29udmVyc2lvbiB0YWJsZXMuIFVzdWFsbHkgdGhlc2UgdGFibGVzIGFy
ZSB1c2VkDQo+PiB0byBlc3RpbWF0ZSBTT0MgYmFzZWQgb24gT0NWLiBTb21lIHN5c3RlbXMgdXNl
IHNvIGNhbGxlZCAiWmVybyBBZGp1c3QiDQo+PiB3aGVyZSBhdCB0aGUgbmVhciBlbmQtb2YtYmF0
dGVyeSBjb25kaXRpb24gdGhlIFNPQyBmcm9tIGNvdWxvbWIgY291bnRlcg0KPj4gaXMgdXNlZCB0
byByZXRyaWV2ZSB0aGUgT0NWIC0gYW5kIE9DViBhbmQgVlNZUyBkaWZmZXJlbmNlIGlzIHVzZWQg
dG8NCj4+IHJlLWVzdGltYXRlIHRoZSBiYXR0ZXJ5IGNhcGFjaXR5Lg0KPj4NCj4+IEFkZCBoZWxw
ZXIgdG8gZG8gbG9vay11cCB0aGUgb3RoZXItd2F5IGFyb3VuZCBhbmQgYWxzbyBnZXQgdGhlIE9D
Vg0KPj4gYmFzZWQgb24gU09DDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVu
IDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+IA0KPiBJdCBzZWVtcyB5b3Ug
d2lsbCBuZWVkIHRoaXMgZm9yIHlvdXIgY2hhcmdlcnMgaW5kZWVkLg0KPiANCj4+ICtpbnQgcG93
ZXJfc3VwcGx5X2RjYXAyb2N2X3NpbXBsZShzdHJ1Y3QgcG93ZXJfc3VwcGx5X2JhdHRlcnlfb2N2
X3RhYmxlICp0YWJsZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHRh
YmxlX2xlbiwgaW50IGRjYXApDQo+PiArew0KPj4gKyAgICAgICBpbnQgaSwgb2N2LCB0bXA7DQo+
PiArDQo+PiArICAgICAgIGZvciAoaSA9IDA7IGkgPCB0YWJsZV9sZW47IGkrKykNCj4+ICsgICAg
ICAgICAgICAgICBpZiAoZGNhcCA+IHRhYmxlW2ldLmNhcGFjaXR5ICogMTApDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsNCj4+ICsgICAgICAgaWYgKGkgPiAwICYmIGkg
PCB0YWJsZV9sZW4pIHsNCj4+ICsgICAgICAgICAgICAgICB0bXAgPSAodGFibGVbaSAtIDFdLm9j
diAtIHRhYmxlW2ldLm9jdikgKg0KPj4gKyAgICAgICAgICAgICAgICAgICAgIChkY2FwIC0gdGFi
bGVbaV0uY2FwYWNpdHkgKiAxMCk7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgdG1wIC89ICh0
YWJsZVtpIC0gMV0uY2FwYWNpdHkgLSB0YWJsZVtpXS5jYXBhY2l0eSkgKiAxMDsNCj4+ICsgICAg
ICAgICAgICAgICBvY3YgPSB0bXAgKyB0YWJsZVtpXS5vY3Y7DQo+PiArICAgICAgIH0gZWxzZSBp
ZiAoaSA9PSAwKSB7DQo+PiArICAgICAgICAgICAgICAgb2N2ID0gdGFibGVbMF0ub2N2Ow0KPj4g
KyAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICAgIG9jdiA9IHRhYmxlW3RhYmxlX2xl
biAtIDFdLm9jdjsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICByZXR1cm4gb2N2Ow0K
Pj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTChwb3dlcl9zdXBwbHlfZGNhcDJvY3Zfc2ltcGxl
KTsNCj4gDQo+IFJld3JpdGUgdGhpcyB1c2luZyB0aGUgbGlicmFyeSBmaXhwb2ludCBpbnRlcnBv
bGF0aW9uIGZ1bmN0aW9uIGJ1dCBqdXN0DQo+IGNvcHlwYXN0aW5nIGZyb20gbXkgcGF0Y2g6DQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBtLzIwMjExMTE2MjMwMjMzLjIxNjcxMDQt
MS1saW51cy53YWxsZWlqQGxpbmFyby5vcmcvDQoNClRoYW5rcyA6KQ0KSSBhY3R1YWxseSBzYXcg
dGhpcyAoeWVzdGVyZGF5PykgYnV0IGRpZG4ndCByZXZpc2UgbXkgcGF0Y2hlcy4gVGhhbmtzIA0K
Zm9yIHRoZSBoZWFkJ3MgdXAgLSBpdCdzIGFsd2F5cyBnb29kIHRvIGhhdmUgdGhpcyBraW5kIG9m
IGhlbHBlcnMgOikNCg0KPiANCj4gT3RoZXIgdGhhbiB0aGF0IGl0IGxvb2tzIGdvb2QgdG8gbWUh
DQoNClRoYW5rcyENCg0KQmVzdCBSZWdhcmRzDQogICAgIC0tTWF0dGkNCg0KDQotLSANClRoZSBM
aW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCg0KTWF0dGkgVmFpdHRpbmVu
LCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFuZCBTV0RD
DQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+IHRoaXMgeWVh
ciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVyZSB3cml0ZXJzIGJsb2NrIH5+DQo=
