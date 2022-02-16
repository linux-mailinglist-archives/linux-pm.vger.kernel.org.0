Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499D44B80CF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 07:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiBPGrB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 01:47:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBPGrB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 01:47:01 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE282A24C
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 22:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb6vpv5BPF79dXsOHFUTrElw8ni7tbN/Npi94jbEdMuQCJIKnHtRr0d/WlfiJBXKFjuRMVgGvpeGfMit5aOcQ779T7oVCQ2DBF830guW1olTr7oQjUisKNMTSMS3RZa0yswWIkFjeoucST8LJpcjWNqzUBTuByprm6pVEIsHlSt3kIKIOOWDdw906YrVWEQPYwSOJPQlJukhpPv3N+tfCZfrye1IzdDKGQpuDqukemoNDKdB60ENFxOkmkl6nK1cF5Wqxv5rnXJcFzCQHdmfXN5ty2dtz6LtaJz82+B2eb0wSCu0AfrIyq09xMMSrc8L/wAcrydH7E/2OxOkG4KzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UepWHVErL1+1eVnrH9RtrPDTeydDAwETfUNinuwPg+s=;
 b=kvGiQjFwLgklUJMdc3bzQFmnhlDy8mWRGMziod9zScLGPplR8vFqPySpqtTzTuiR0XkvwVnUUlruz4Stunzl7N2mxZ/MkDnDf2slo/XtHyoUSHbRH/HXC3fKzp7vJAl1738gmW0NkeE3/CJy+H0tZZO5SblzwGqnTTaodiHHzs8lMTH+BOEuzXKTvIVdSmfUDe8tXqYBkqTnjdF5pPWPpV6ajSQzgVLebi5P2e6D7bleVhPg4tqcIeQHqsa1obsAbO0+q5pQ2r0xo7ZQ4rNLVvKeWxVH+hNujz+PII0PvDtZV1kAaotIVHY/mFmUw8qseECyUJIh6Dz9DcoRxeo3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UepWHVErL1+1eVnrH9RtrPDTeydDAwETfUNinuwPg+s=;
 b=KLGzjOatXC0eEsDK3nA+kP1sBt/kgozPGh0IRs0WExiZD+pQRkRtjPOUGpZZO9hLC4hNspJ/YfO9r1UYbIWIUibmi/r0KtBkpzRKxjyyylYz3XveX5rc2d1IeM4biholADbtBVvPx/f6oqtBel6cfLrN0o11e4Hb/mMfPNEnS58=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 DB6PR0301MB2150.eurprd03.prod.outlook.com (2603:10a6:4:46::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.19; Wed, 16 Feb 2022 06:41:55 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fd01:86fc:2baf:1ac4]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::fd01:86fc:2baf:1ac4%6]) with mapi id 15.20.4975.012; Wed, 16 Feb 2022
 06:41:55 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/6 v2] power: supply: ab8500: Standardize maintenance
 charging
Thread-Topic: [PATCH 1/6 v2] power: supply: ab8500: Standardize maintenance
 charging
Thread-Index: AQHYIG4H3kqzNSwIKE29nhglBtgEpKyVv7eA
Date:   Wed, 16 Feb 2022 06:41:55 +0000
Message-ID: <402b0254-3a1c-1d18-fa95-0019876ab4a1@fi.rohmeurope.com>
References: <20220213000703.772673-1-linus.walleij@linaro.org>
 <20220213000703.772673-2-linus.walleij@linaro.org>
In-Reply-To: <20220213000703.772673-2-linus.walleij@linaro.org>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f14ed2d8-86cc-4885-18eb-08d9f1176c75
x-ms-traffictypediagnostic: DB6PR0301MB2150:EE_
x-microsoft-antispam-prvs: <DB6PR0301MB2150D9CD3063B1FB1EDE00BAAD359@DB6PR0301MB2150.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOAp+1Pne++nleNKWqriu3ra6LLoBT5hZMJ57wGxDUpwOFgKfCRgVEBQyGMpYnOnRV5oGpXIs97BQNOBl7DiDYDv36jJT5LQzzTE6MY+sjKf/X8QDhGMEoXXUuHAiLSO/MEKNcUh0YgahaPpPO4SrDW6UTK+rBDj3my/1qtuhYxnMDNhoFk1xQNpX+97WigDpa6N+1RBj+djB26llPW/f4YI5YZIxsAArs5cZ/ovGIjgYcYSwoiFe5GeMFjo+n8ra/uKW9NhEXomwiDB0065FSG4cZrC3jqNvDu3QRKu8M7kKquBYEPa2ZBdJEy77GXwHeLLbFbTWB+SS3XKEwEv4eshndpGAy8ifIRwMcUUfHi8+7JC4DD6i5NRpYYIXnPpJnpXYq2cJ9NtglY7+EihMSX5zo/iedb2yNOb0PTlEBDZgoDbMVuWmWSTepIiRXPFhb1eSoqurYiQ9hQEy0t4JeDhewBq84hJ1Uad9AFcRZghlLUQVS8iwGTJAQGfhp4IS0ThB8dt8ZU5DYKaiIyEdEZwzNPtrReLVIBgmsMbpTqfopKoR7bQPJoR2QQ41GWW8GJPrP15610bZWXQL3EyuGCrqoDiFVDlpkV8sIa4B7k/+J0LZiFe9UBiOEd0HyhrPTZtTbJPftUIKKnlYzDzMfU9DCrkZPU+ezMDXcD4vTomyarbo/oLnvOWOe61RjOQOSoanmTngOlAUpF8ZIP8UOrYB9LJrlMZndAZgOE0vnuszstGyDRVLGPhz/3p+fxGJrKk3MhHTFsiJZNygfLWtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(316002)(38070700005)(83380400001)(6486002)(110136005)(31686004)(53546011)(508600001)(5660300002)(6512007)(8936002)(6506007)(4326008)(71200400001)(76116006)(2906002)(66446008)(31696002)(66556008)(186003)(66476007)(86362001)(66946007)(64756008)(2616005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzlvTUphek96YUxLZW85bHpyK2xVVXA1aklyWGMzVkhLdEc5M1FJUXBvdEZL?=
 =?utf-8?B?SlVHZkJXd1gxQkNxeUt4dEJxTmdvSzduZXBUcXhsMll0MHNBSzB4bXNzQWxQ?=
 =?utf-8?B?WDRpNXdicDBsWUNadEdHd2pIQVRvenlVMTI0a1pBUHdmWkhMUHlmRTY4VzdS?=
 =?utf-8?B?RmgvU3ZDZ0JlY0FKUHlsVlkxdnpqWERCMFJJalhvcitrelROamc3dWlkazlP?=
 =?utf-8?B?Q2dONXFJeXNVSThvUEdub2ZKclJjMEJZdlAxK2tPbGpMWFR1VG1tUWZ4Rmds?=
 =?utf-8?B?clhiNEpEUm05c0VCc2dZaXFURzFxbjdvV051MXZCY05OODZMd3RkWWwxaGYx?=
 =?utf-8?B?TjUxSEVDL3VhM1VXZ3pGVEthOEcydHlGR3BKNnVxNzhNUUlXZlpTcms0djdZ?=
 =?utf-8?B?WUdiWTRqM3N0TDdzRjg3QlpzUGpyWGxPSmVkSi9xeXdiTU5rNEVTdGRSTVlv?=
 =?utf-8?B?RUhEQzFValZ4UGhDNDdUL3VveWFTQjQxZ3FDV1QzcXRjSkw5aktwRk5ldjNI?=
 =?utf-8?B?OWZXWS9RaFFzamhsaS9rMzcrQVlQbFFGeHMzdVdoU2F2bFdqdDRDUW5KU3FZ?=
 =?utf-8?B?OWcya0RUVi84c1lQSlM3dFNZYVc2bW91YW1tODJVNmVmMElHUHdmYmNpNWNk?=
 =?utf-8?B?cnd5L2JGbkF5NThyb3JGd0ViVHhmdFZEMFdTcjBMaTFmaEFiZjhNNmtzbzdm?=
 =?utf-8?B?RGxFTURtdzNlWGpYTjZBQ0Nwditrem04ZjB6RExuOFR4TmRQS2ZTTWJuNGR4?=
 =?utf-8?B?d0tWb0taREhuVnVMZkM0cDRVOE9zem5aeXk3VTBtL3Y5WGZ1Tmk4QUQ2QkN5?=
 =?utf-8?B?SFo3ZUVUV2E4TDdYVWg0Rkh6ZTZlRVFFUlhPR0MvaU00cWoxaUNOL3dFV1h2?=
 =?utf-8?B?Z1NFalNUelA0WXNJTGtNWm81YWg1c0pNd0RiZFZSNTAwODBxc1ZxYVlqc1Yr?=
 =?utf-8?B?bUhzTGdvNVhuN3dBZEtidnUrTjhDQ25ySzZEMzZuckVvcHBRN2FCRVc3OWRj?=
 =?utf-8?B?NEJNUUtiSHVqR0pLU1ZxaXhKRy9BWVNxQTh5RXVFRXNFZWNZenErcjRDYko0?=
 =?utf-8?B?ekJIYTlEd2xXR2N3T29NZkxpdDUyV3R3ajRsaFNqdm5oSW02Z1F4NHh6RUp3?=
 =?utf-8?B?L05Wa2lyeVJyN3lHaE83QlZJNlBQVnVCZ3FMNGFKMTdsTFhqUHJoeUMyalFW?=
 =?utf-8?B?NDNrOWhMOTlkK1k0bWRDZVhFMFZiVWRyZnRmT3d6R3VSaWp0RC9ON2s5N1dJ?=
 =?utf-8?B?TFdwUnVBZFFTVTZqMjFEa2hnWFdRdmJZR1k2Szk3cmRDMG9KQk1CakRiQ3RF?=
 =?utf-8?B?L2pjRWEvV3FNanoya0tLdUtmZUF2OW5nWEZsRmovZnd4NmdwZlltQXplcENs?=
 =?utf-8?B?aHJHeittK3QxMytjWE5PQzh3ZzJ5NlBETVFUL1lqWUlvL21hbDBvU1dLczVQ?=
 =?utf-8?B?YkdYZVUxSEVHbnNubWRZcitRSi9RbUJhVHN4alFlSzlpMW93dmwxYzRiR2JD?=
 =?utf-8?B?L0xCaktURUtKeS9HczhWK0o2UlgwTFRRSFZzbWcwVGJUYlJyeHgxVmtWQzU4?=
 =?utf-8?B?Si81RTl2RStBSUUvMnB5NmZDQWFBUjdkTFVKTENRc1U1emJuQzgwYUxRdER5?=
 =?utf-8?B?OWlkME9IRVZzaUZqUFBuTmlCOXR5WGRsSERRSk9BR2dmOS9BMlZyQ05GaFdp?=
 =?utf-8?B?Wlg5Ymt1emhZN01IN25rOG05N0h0QkdVOXJtWXdRVHcrckFIV2JMT3JSbFVO?=
 =?utf-8?B?ZVJWdHFFczg4Sld0WTRHaEg3VW1rRjM0VWtrZ1RGRnI4aEZQU1RrV3p2S2pO?=
 =?utf-8?B?blVwM3JLa2NWdHB4SWtpU2htcjh5Qkk5UHk1bmt0SjVDTFJYK0RlalNQc1pO?=
 =?utf-8?B?b1VmWldnV3EzOHZCOGE0OFRZUkRVdWRWOVl3Q0czNXZVZEh2TUxVQTdzQUow?=
 =?utf-8?B?WmRjRXc4Nmt1eC9OMm5tUEdrbFNwWmZ0RFJhaGVTYWc1M2Jwd0pPOUlPL3p4?=
 =?utf-8?B?UWF2MXMzNituMXFnZHdzQ1o4MjBkQWpENkpCU3lPd3Z2VnMwTWJraFJmOHpw?=
 =?utf-8?B?ZlN0TnNzdHh0ZFE4eGRaZS9JRlVFWXZLZGJWTUNZdE5ieE9mL3p3YmtqZU55?=
 =?utf-8?B?TU5Oc2FpVC9FVFRiaWZKNXJUYlJWZ1FuSnhzaFRWeElUN1A3dXo1eVJWZStZ?=
 =?utf-8?B?UC9Xd29KQ1NVdU8vdmw3d3l0anpIdlFibXUxZGhjK01zdTRVUFpMTmhlWHRW?=
 =?utf-8?B?d0hlWTZhVXUrZ0lYVkdXZWNPUmRnRTF0QmZmQmFuNENwemlvRUpCL082Y1NO?=
 =?utf-8?B?dWwyOWVWTHRyQiticEgvcVdpL2JzSE85MUp0aVBFWlFtc3J0cFBRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5503628709FB9E4681846220DD302C53@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14ed2d8-86cc-4885-18eb-08d9f1176c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 06:41:55.4541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2A0juwQv5T4ELjtLSOC7VA+vzIjnHc5ucF4q/JNK8QYrIGGGBFutbStZoGOKf9w6dJXzMaxZrXLyZbU2clkZSUZrDuvW8+xFCvDTQVxt1ENrz2Ge8+YmFIdwccJBE1S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2150
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMi8xMy8yMiAwMjowNiwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gTWFpbnRlbmFuY2UgY2hh
cmdpbmcgaXMgdGhlIHBoYXNlIG9mIGtlZXBpbmcgdXAgdGhlIGNoYXJnZQ0KPiBhZnRlciB0aGUg
YmF0dGVyeSBoYXMgY2hhcmdlZCBmdWxseSB1c2luZyBDQy9DViBjaGFyZ2luZy4NCj4gDQo+IFRo
aXMgY2FuIGJlIGRvbmUgaW4gbWFueSBzdWNjZXNzaXZlIHBoYXNlcyBhbmQgaXMgdXN1YWxseQ0K
PiBkb25lIHdpdGggYSBzbGlnaHRseSBsb3dlciBjb25zdGFudCB2b2x0YWdlIHRoYW4gQ1YsIGFu
ZA0KPiBhIHNsaWdodGx5IGxvd2VyIGFsbG93ZWQgY3VycmVudC4NCj4gDQo+IEFkZCBhbiBhcnJh
eSBvZiBtYWludGVuYW5jZSBjaGFyZ2luZyBwb2ludHMgZWFjaCB3aXRoIGENCj4gY3VycmVudCwg
dm9sdGFnZSBhbmQgc2FmZXR5IHRpbWVyLCBhbmQgYWRkIGhlbHBlciBmdW5jdGlvbnMNCj4gdG8g
dXNlIHRoZXNlLiBNaWdyYXRlIHRoZSBBQjg1MDAgY29kZSBvdmVyLg0KPiANCj4gVGhpcyBpcyB1
c2VkIGluIHNldmVyYWwgU2Ftc3VuZyBwcm9kdWN0cyB1c2luZyB0aGUgQUI4NTAwDQo+IGFuZCB0
aGVzZSBiYXR0ZXJpZXMgYW5kIHRoZWlyIGNvbXBsZXRlIHBhcmFtZXRlcnMgd2lsbA0KPiBiZSBh
ZGRlZCBsYXRlciBhcyBmdWxsIGV4YW1wbGVzLCBidXQgdGhlIGRlZmF1bHQgYmF0dGVyeQ0KPiBp
biB0aGUgQUI4NTAwIGNvZGUgc2VydmVzIGFzIGEgcmVhc29uYWJsZSBleGFtcGxlIHNvIGZhci4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJv
Lm9yZz4NCkRlZmluaXRlbHkgbm90IHdvcnRoIG11Y2ggYXMgdGhlIGNoYXJnZXIgSUMgaXMgdW5r
bm93biB0byBtZSAtIGJ1dCBhcyBJIA0KaW5pdGlhbGx5IG9wZW5lZCBteSBtb3V0aCAtIGFuZCBh
cyBJIGRpZCBpbmRlZWQgYnJvd3NlZCB0aHJvdWdoIHRoZSBjb2RlOg0KDQpSZXZpZXdlZC1ieTog
TWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQoNCi0t
IA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBW
YWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5s
YW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4g
dGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
