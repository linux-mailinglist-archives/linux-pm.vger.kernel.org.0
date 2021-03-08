Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9C33136E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCHQbk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 11:31:40 -0500
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:29829
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhCHQbQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 11:31:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuzCQxXggPR7qn6YaObrXEnRUvd+6K3D7ANMy8CJ0xtTeUrPdhNF4xPmRhTnK7gENzmwFkFij6HVYbbcUi/IyYUizO/j8+ddcLthLM33dfKtdNyIJCOtg8QxtIUWL8PCIay0vpK81v7TT/VRNVJXyCj5ktcjeON/4Ds0hpsf3UpsGf25lV64WO6X7n+hCianap/3X7rNxQDkLrdlFHaxoGNE3+AA3B5lRmGCKZJ29nIZTb21ace8D5IzJgg8muCMpvUuwiiybtUguReEiklxCbvYXzA8PvNJKhzGc7uQJtT2ObHW0feu3qxYhKJJeXLkC2vbfpftiyGxrfOVvKJjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlrTen4OdX5GXSGSTdoUv8zzvEP3vhtXdgDzLhBQJJk=;
 b=Mki0HdqSMeeyeviYac8z5zP1OC0vL/HlIB8o5DpgMdrOPP+fo0B56BocTtdtVsAly4u1JV5vkZBVpXQJ+iSNieEYrpinWYlWczadL3332HS/qGUEOaO95ZKWJnUZCURYYLrcMLsewg4E6MKyKq7PuKXUpcG93hqjUtt6X830sRum/eh1yVEGrb5N3fV9J8sLppm9L+O2HCnoHzEK7OTUEXZMKJ9k/5vqGUu8s1UzT6+fklDtoDd9e+XMucm3f1zBkrx5yJZz3zjXVEmCnoTYCOc460f9y8LzmBv1+AKlNSydAN3bUfKIPCB4mt9Jz6nVY/R3iJNqrR/q5RtNJqzzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlrTen4OdX5GXSGSTdoUv8zzvEP3vhtXdgDzLhBQJJk=;
 b=N52r2iMIgwFrmWuJv2WrqpHtYssjcd6XuzCz8zUGGIrCgoEGveQrcDmhk6feuTJ6G2ePDeRX8f9WTTYsf7UgAA/CCAUehBKLrMJBy/uedSUW7ClTHXNAQEA7Un3SxZJkmYMfzhuPY3GVUrcb00chW51UlWjmwbScty/8Sq2PBTk=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2475.eurprd03.prod.outlook.com (2603:10a6:3:69::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26; Mon, 8 Mar 2021 16:31:12 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::246a:935e:e8b:c581]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::246a:935e:e8b:c581%4]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 16:31:12 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@kernel.org" <arnd@kernel.org>
CC:     "timon.baetz@protonmail.com" <timon.baetz@protonmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency
 unconditional
Thread-Topic: [PATCH] power: supply: max8997_charger: make EXTCON dependency
 unconditional
Thread-Index: AQHXFC/d7FvMVQrJLUaET9XT21g2rKp6QbeAgAAGZQA=
Date:   Mon, 8 Mar 2021 16:31:12 +0000
Message-ID: <2fc305c55e06c5740375013bc9a4d305ad985ed1.camel@fi.rohmeurope.com>
References: <20210308152935.2263935-1-arnd@kernel.org>
         <CAHp75VcMAWFCOFEXizuOvDZs=qDSYndH=Y9RhgLdjb9547Op+Q@mail.gmail.com>
In-Reply-To: <CAHp75VcMAWFCOFEXizuOvDZs=qDSYndH=Y9RhgLdjb9547Op+Q@mail.gmail.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64989bd0-2e80-4dab-df41-08d8e24f965f
x-ms-traffictypediagnostic: HE1PR0301MB2475:
x-microsoft-antispam-prvs: <HE1PR0301MB24757561CAB78FFB0AB1DBB3AD939@HE1PR0301MB2475.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSvJEzNkpzjyNNiskszxB/REf2DuFowu+vWzyQr57Hm/UKQHZptUFeBj6R2WJNTqIwjCcTlvbGTdgE40gLqhy3MS3GvC7IpWQisKvBumJeZL9D/ChduE6485l+QE0IQw/auMEbINj0qlej11ZjLJZcbTBQVlTEAEkqMqFNuu5T1+RgsqXq0v5A2169lmsHwHm81ZDbJWtPOFXMA0jkoDuviKaO5GhfrafzHx2kZsITG7+gZFh4HdOocH7Fv763Dc0QtTAWb0lZ9OA4Fz9g7JWrST4tYV0CD9aofcUDemypsctx5zmPefqD3h2cSEckikL5gfl8lzyHclhvLR8RlIEcEIqOHt10et6/DrGJiDUmAzugMrrVmlmK3HGjmQhCCmcMFAEPWq7xUmRkeug4hbOA3W/SuHvwmQOLPx6zSX8RNE+CSEISeSCflM/qbn489eUFP5sfageLd1Vuyccp2Zn2PrlLhK6MmPi9TmFDHED3MiRRrKkxtqXa6vI+BD0EIweR8naMvlhUZv9F1J3NjlAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(366004)(346002)(396003)(66446008)(6486002)(64756008)(66946007)(83380400001)(53546011)(66556008)(66476007)(6506007)(8676002)(6512007)(186003)(76116006)(8936002)(86362001)(54906003)(71200400001)(316002)(4744005)(2906002)(110136005)(4326008)(2616005)(3450700001)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TWtxQ2sxbEtUcGorY1VGUThvM0R3OFVoK3lRREI0OTRPRWZ5dXJ1dDExdi9T?=
 =?utf-8?B?WnNXNllja3RUV2MyZ2g1UzRMMGZmWFVFdjJBditJL3J5QTdObFE2TXVQaEJM?=
 =?utf-8?B?akcraXdTclJsRG1USlpCT1VHdVRYYlg1V2I0Tld2b2h5OHZPSmQ0em1uaTBk?=
 =?utf-8?B?bEthZmYxNmVqK25BVVZpek50UzcrekNkb3hRbHk2byt3d0hlOStMcUpVSEU5?=
 =?utf-8?B?L2lBYUxqK2ZBdXZqT1VHdzdNRmZhb3dxb2tSNzcxT3c0aXJ1dHF3aitFSjRE?=
 =?utf-8?B?OEZPUTJOdW0vaExZcTI1NkN1V1BlbFA3aGFUUjlpdzEwRVh4M0paT0Z3RCs5?=
 =?utf-8?B?WmFXRisyUkNNalF6dlgzZ2RNQm50Slo0OWpNc0tHNk15Q0JyeFZ0WEdhbGkz?=
 =?utf-8?B?ZElVV1ZqTGdsak9zZnZYZ3hycjFRRERJaHVnMFlLNXdCVVhBeVd0aEpqdFFa?=
 =?utf-8?B?aWlHdDBIdzJWeDZjeHRoTDdnRUtWc0t2WHpGNnllVVA1YjZmaVZRL1c4blhE?=
 =?utf-8?B?Rmp2WjV5SHdQZ2xjNFh3aEtTeE1lRGtzN1dhNTBUYzBFT0tJUE1oNFgySmsr?=
 =?utf-8?B?S25ZaHU0dVZyenNMcDMya2hIU0xQTGxsV2hRM0VkN2VmQnA0WEJnM2RyTzJi?=
 =?utf-8?B?emR2ZEs0V1VqbmMyOGN5dG9XN2hRYjNydmh5VFREWENWTGppckhnZ2tJTHdk?=
 =?utf-8?B?UHFlbFJ2YktGZkFLSng4b3hOQXk1VmFPbTdKZmxHVmVLL2p1UXRIUGg2OTFS?=
 =?utf-8?B?M1F2alNFaHFuWHNFVEFvOXFMRE9zblNXMkZBOTZjZ0RYVnk1bTlvS3F4RVU2?=
 =?utf-8?B?aEtvOEpmU0c1eWErNXRZRlR2SGEyOXVCc2hXb0wzVmJKcVhhenhLTVgrQnpt?=
 =?utf-8?B?OGJIbFlUaEE1YXBXS1UyRnJsVGlZeTdQZXRkY1lMVGFjMHNIR1ZpK2I0SzVk?=
 =?utf-8?B?bit5dFZpTEJaekI4d3pNSjF0RmhzcTllMnZrODBibzdVVTY5WnR0N3NxMkNY?=
 =?utf-8?B?dk1SSzV1YlpvTHowcUdGTE15UWQzUVkwV2dQVjl1ck5KZ2EvaFJkK1VjMjNS?=
 =?utf-8?B?ckZtOEg0cng2RkpnTkhqYjkzTm5IWk1pdTBCTnlrWmRMM0hxTHlZMVhIYzBo?=
 =?utf-8?B?bEYyOC92L0kvMDUvenJURmFQN2xiL2xPYnFNb0VQNHRxM1hmU0xSRDVGbnRP?=
 =?utf-8?B?SmgzQjYyZzVBanU0TUNLcEg5UFVabkZuRi91TXVBOGNHZEFwU1FYR21IWlF5?=
 =?utf-8?B?NmkvN1pqZGVLZFdCZ21MMHlOTUx3QWhCVkRzWlRTZWRoSlRYNEtyUmhFK1h2?=
 =?utf-8?B?MmZPWU9PVEZQdm1OZ1lnNXNUcDY5WTM3RlBXZHN6ZGN1ZmxzUzBwakJUZEZT?=
 =?utf-8?B?ck1BSk5IWk5DMHlGS1phd01PeDNXOXR3L0xTK2d1M29vS1dWMHJxODFudXVU?=
 =?utf-8?B?cGtWYkIxcFdkcUwvbmNrNmNFR3FGQVRKeERuUlhSU0c0OFBROWNIa2Y1bEZE?=
 =?utf-8?B?UUZYVzFuQ2tieG1rbU15d0s5dzg5clQ3bk1OSnlRY2svaFBLU2NPUmV3RW1a?=
 =?utf-8?B?OHJmZU1leGUwMTgzTzRLRGw0Q0szUGNlcUFCdGRjb24rTTM2SGhsem9lWnNo?=
 =?utf-8?B?emczWGg5UzZKVVFMZzAyS1NRQTZZcDVCczNkMW1pblA0TjRjejAzczluTWNj?=
 =?utf-8?B?eVd0dCtyQXpTVG5qY3FvTlg3N0dBejhVc2lhS211ckhqWkRFOVo3UlJicm9B?=
 =?utf-8?B?aURab2FVeS83Rml0Mzd6SGt3OExURDhYUjJCUldpWEFwS0RraVQwREpiMTcv?=
 =?utf-8?Q?bQ6PxTC0OuGRIjN8yJrN6xFDiLKrsU6FpZgns=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <30C920DF28BEC54C9717C10AF196347A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64989bd0-2e80-4dab-df41-08d8e24f965f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 16:31:12.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bFcCa0tLUyrYLGIWjNNV4KP53wBufJX5jssx8BNqlZ6pHQgNh4oTObDSXtcKlco56Ac/VlxObFW7uf7/DZfL4Y5w6Z+iBc1fpSuwU6dn7N4JdavasAGh8Jo4NdPL99S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2475
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBNb24sIDIwMjEtMDMtMDggYXQgMTg6MDYgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90
ZToNCj4gT24gTW9uLCBNYXIgOCwgMjAyMSBhdCA1OjI5IFBNIEFybmQgQmVyZ21hbm4gPGFybmRA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiA+IC0gICAgICAgZGVwZW5kcyBvbiBFWFRDT04gfHwg
IUVYVENPTg0KPiANCj4gSSBzdHVtYmxlZCBvdmVyIHRoaXMuDQo+IFdoYXQgaXMgdGhlIHBvaW50
IG9mIGhhdmluZyB0aGlzIGxpbmUgYXQgYWxsPw0KPiBXaGF0IG1hZ2ljIHRyaWNrIGRvZXMgaXQg
c2VydmUgZm9yPw0KDQpUaGUgbG9naWMgd2FzIHNvbWV3aGF0IGhhaXJ5LiBJIHVzZWQgaXQgb25j
ZSBmb3IgQkQ3MDUyOCB3YXRjaGRvZyB3aGljaA0KcHJvdmlkZXMgbG9jayBmdW5jdGlvbnMgZm9y
IFJUQyAtIG9yIHN0dWJzIGlmIFdERyBpcyBub3QgdXNlZC4gUHJvYmxlbQ0Kd2hpY2ggdGhhdCBz
b2x2ZWQgd2FzIHRoYXQgd2hlbiBSVEMgd2FzIGJ1aWx0LWluIGFuZCBXREcgd2FzIGEgbW9kdWxl
IC0NCnRoZXNlIGZ1bmN0aW9ucyB3ZXJlIG1pc3NpbmcuIEl0IG1pZ2h0J3ZlIGJlZW4gR3VlbnRl
ciBvciBBLiBCZWxsb25pDQp3aG8gc3VnZ2VzdGVkIGl0Lg0KDQpJIGRvbid0IHJlbWVtYmVyIDEw
MCUgc3VyZSBidXQgSSB0aGluayBpdCBtaWdodCByZXF1aXJlIEVYVENPTiB0byBiZQ0KYnVpbGQg
YXMgYSBtb2R1bGUuIEkgZ3Vlc3MgdGhlIGRpc2N1c3Npb24gSSBoYWQgcmVnYXJkaW5nIEJENzA1
MjggY2FuDQpiZSBmb3VuZCBmcm9tIGxvcmUua2VybmVsLm9yZyAtIGJ1dCBpdCBpcyBwcm9iYWJs
eSBidXJpZWQgZGVlcC4uLiBNYXliZQ0Kc29tZW9uZSB3aWxsIGdpdmUgYmV0dGVyIGFuZCBtb3Jl
IGRlZmluaXRlIGFuc3dlci4NCg0KQmVzdCBSZWdhcmRzDQoJTWF0dGkgVmFpdHRpbmVuDQo=
