Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE824D2919
	for <lists+linux-pm@lfdr.de>; Wed,  9 Mar 2022 07:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiCIGrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Mar 2022 01:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiCIGrI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2022 01:47:08 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D297D148653
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 22:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMVYwsPpLpePafEyBS4mA0gakOpMA7wGgvE3G0Tzj6VFos1nFSKg5VWYf0XI9fIR4jhpZI+X5nnhT59bCgn2lxRMF3EOky6sOojrABnKwlyKFm39CAnA6rHMxZnaZ4i6BdBCuaV7lj9l6907UvcJi7St6HMzeDJmg/n5U2HaRjojB9LWhLyyHA7fVbRLlG0+mboEzYP2qJ/FAe6Ag4nLt53dLikkq6fLeuJr7+ihAHv5cNIbsyGAHCYB9Yd5TestSfk/bWM350RepznEp+IECmZPPO6WTiihBbSResdV4stihby+te3CzUP3JOVAKD1ZqwZquiIg7OBhinIB1u0wSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6HxzNAL+DOBiyBAFej+2bn67LR9PBnUkgydspyggQo=;
 b=UJRMtHo/ne8Lomj6jPxAArF+9Ni3jJ/ZmfqaxGuIrD3bSw8ZZUPpQwBt+0sWSKheNbfYL4CqSDptdsycPHgII3AML7ldriykURe7km9pShBABEZlZ7haO3cVt3KcTX+EGYKBpB4KLOsAz8xPvzjhCzhfnemdVYxjXduLBQQBYvdk4JmCs7Y1MmYnWBhgjq4ExvX0LInP1e0zVEb+q8hvuvjkgKcyvF8qIwpPQnhNvr/AfZMTZ790L0awOYnCZlz07zgH0eC3PtemG+Q5BHul5+GINzgv9py7XK2LuRQ4S1bi8bCvkVyKQBaOj7yr1JZhoYYAepqEz7zDQL27ibujcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6HxzNAL+DOBiyBAFej+2bn67LR9PBnUkgydspyggQo=;
 b=avXAWdQ+J8iFjSAI2RCXW00vzvYOy3URIar54XFs3KbOiMsaP4yYQMpVmn79DE+8RhLh7058fbNmasChSTiYN7MjQ6j0LQP9tpedmGvVob0oMCdjc+HGWNQcrG4tBRWGGzCMO898R9sEQ1freaqICgWgM+XHPmeoi8BPvuj7RL8=
Received: from HE1PR0301MB2329.eurprd03.prod.outlook.com (2603:10a6:3:67::7)
 by DU2PR03MB7896.eurprd03.prod.outlook.com (2603:10a6:10:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 06:45:59 +0000
Received: from HE1PR0301MB2329.eurprd03.prod.outlook.com
 ([fe80::f4ef:29d4:f6f0:3463]) by HE1PR0301MB2329.eurprd03.prod.outlook.com
 ([fe80::f4ef:29d4:f6f0:3463%11]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 06:45:59 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] power: ab8500_chargalg: Use CLOCK_MONOTONIC
Thread-Topic: [PATCH] power: ab8500_chargalg: Use CLOCK_MONOTONIC
Thread-Index: AQHYMwOw7FLwBaHxcE+i0VUQ4cRIWKy2nKIA
Date:   Wed, 9 Mar 2022 06:45:59 +0000
Message-ID: <42220d81-0f7a-a134-98f6-bdbabc584b20@fi.rohmeurope.com>
References: <20220308154425.296308-1-linus.walleij@linaro.org>
In-Reply-To: <20220308154425.296308-1-linus.walleij@linaro.org>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f60ad7d-ddbb-4eaf-f9c4-08da0198785d
x-ms-traffictypediagnostic: DU2PR03MB7896:EE_
x-microsoft-antispam-prvs: <DU2PR03MB789672376D647EC03ABDFF35AD0A9@DU2PR03MB7896.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBDu1ZTIVwE3dTU8mdl21xEoJs8X6CBPPH9FSLyWYCYWCsCnkcAPQzReci9jF1YzH35ovAs3jhL4+mQlCT9yMtXVqAzoBGQmTw1Ws1g5pRPT0UUKAYA0O9ou88i8Z4BKQJBjgfxBhUZt1+TB7P/GIVQXWnmPYcxfyVdlmrOXr2WLpWEtUWvQoD8cZvCBSjERAVw1+Vi6ukfyXkMw4gMcaITQGOLB9lyfHhOJn8IYvPWeLukz7ZxpNWmPeB9E0ePf0UdjJfXI/r8jKO78y9IYRU7pD5CQfW3gRhkhwcVXHT7Njk76s6OB/9+h6rdYjAYjZEre2dlQCHCSIVMpXEidXgbp0312tw+NGbBw+QtpiOvYeybGYmYP78Hqka4qDvXUaJLx93niszVAJMOF3NFdIQ1O6TBXEyMETDV88tPAHmetkD3eOmm2zpSrPmUo6RGZaopKuwyXGe+V4VWPDgeNVoZUFC3rrJgjiMnyhuKetoXtxuSAhTzKoFeeQxbxpzJWgAqLDPXVQkFrVPKlS6JgnxQcWzHgRpXrRuLzZsdamP1DIhKo5wF63nX7KqONBc60FwkScPtrEmVTJa7Letir7Ro7Nrn8sSjjIo3bryST/I305upxel9dllVNESqq5hT69i2VTac0C9oNzIqS4EIypOVqy/szEDUbLZ0D9e11N/4st/ePDsmDzkPPaFQZwozmTytcuZuHJNiM5mFcmcqjem25w3xHueZseNRdy4/h6nBFjWODQEsIQ+jRBWirbbzHvLFyGsVsgDid+v+6MKeBpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0301MB2329.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(71200400001)(6486002)(6512007)(186003)(508600001)(6506007)(31696002)(53546011)(38100700002)(38070700005)(122000001)(83380400001)(86362001)(54906003)(4326008)(2906002)(31686004)(316002)(8936002)(66946007)(66556008)(5660300002)(66476007)(76116006)(66446008)(8676002)(110136005)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVZ2NHFOK21xdmU3Mmd1Nk00ODYxOXZQS2JINXRZbFVHeU4zZzEwRCs4TnFH?=
 =?utf-8?B?b2NVRU9iYWxnQ01PT3ZCNzB0ZVAwOWgwaFVsZFJhd3ZCMUdyYzZGOTN0dTMr?=
 =?utf-8?B?ZFJQKzdmVnFHM3A1NXdLWGlmd2Rtc3A3SUNKZ0o0YlB3Tk5hc1p6RXpuZVhM?=
 =?utf-8?B?aS9kditTcmwxc2k5SFFDcEhhRE14TWh6bGM1VSs0cnUrejNtSURqeSt5cU9k?=
 =?utf-8?B?SFBpS2lLTktQVzBJeXBLMUxJTGVTUVNOdkN2eW54bmRFYjhCNGZWR25yanlK?=
 =?utf-8?B?MXdRRVllZGFhbzd2dHRCajZETjdzZzBpSUhNOE9LQVZkMDFsRFFwOExLVG53?=
 =?utf-8?B?djJrbmNwWStmUVdBbGJJLy84b3lSOFdpY29rbFMrK3ZQeXc5dTltWWtBVit4?=
 =?utf-8?B?TE5XU1gzOS9xTlNUL3lUQkppUXArQk9wSnNBTExRKzNWeFdyMHFyZitobHNY?=
 =?utf-8?B?ZTRVS0xUKzIxYVgzSHg3TlFySWtPREdTOTBMbnpWWGdGaVYxTzVHTmJaNzJy?=
 =?utf-8?B?MDdySzh6Smk5RmFyZ0p6TGIzeUF1dWhnZk56Q2NzbGNLTk5TSkF2MkNua05u?=
 =?utf-8?B?allpaWZueTRaeUQxNHVTc0grWFN2VTRCeU1ZNTR1Tk90c1Vjcmh6NEIzQ1FV?=
 =?utf-8?B?Vy9QcSswdDlRSzlYVDRhS2MrR0ZtaWdPZjAzNVZnR3RRUFIvSTgwRWZITUg5?=
 =?utf-8?B?RnJFWUJvM2grQzljSFd0UGhIdUdoK0tFSGgxUkRJc2FtNENkRmNacmVRaE1m?=
 =?utf-8?B?T1FIeXhTSUxUb2k5NGNCd3VDSjN0YmRZc3B2OGlkRUtZZFpyanJ1SVhxVFZz?=
 =?utf-8?B?cEFIL2xNU0IwTGFXOVBOdTdyRkZ1OWFrd2hFdzJFczd1bms1ZWxFWVVURitT?=
 =?utf-8?B?VmdRWmRBdTRhV3JZSVEwMi9MNENlc1lsazYxTXNHTk1YRVd6Q0tLaks5a0J5?=
 =?utf-8?B?Z0IvTXFIeFJvTWxuUVVjcUtoRVFUTjVqOUNTS0pmNWh6Z2xjTU9uRGhIODda?=
 =?utf-8?B?eWZ2TDZxQllHQVZDODMxQ0RIRE1kdTJwWldORmFNdGtyK1IrODFuZ2VCRi9C?=
 =?utf-8?B?N1pORlg1SVp2RFp6eThXellmc1VLZVovb3JUSnR3MXBacWxSNHJNckdNYzN5?=
 =?utf-8?B?ZmpCODBaQ0Q1Mno5amR5dlZsL2lWaHlpQXJ2UFNXaHNZeDd3VU4rOTJRM0VK?=
 =?utf-8?B?TEhMT1BIcm1nK3pRdmo4dmhxemFVbW1hZWl2MlluREJIanBienkraGpJRWk2?=
 =?utf-8?B?QXM3TlVQQUQyTXNYV2NpS0xIMS9kdThoSUlqVW54djNCQ1hqbE5NNlFCenNC?=
 =?utf-8?B?Zy92Q1htdWwxWnIwL0lRYVlHQ3BkdE1yMFQvYk1sdXlCODJNVG13NEtiOWdo?=
 =?utf-8?B?cExENVBGQldweEhxNTBvamp0Mnk0TmxXSnFzUTZUemYxL0ErWEZ5aFBVenpF?=
 =?utf-8?B?eU52WkdHTUQvVERTWlNoUlRRUitwR0VKU201REVTYUZqaThUK2pmRm4rWEZz?=
 =?utf-8?B?bHRFRUZmR09lTkV5OXFKbEhlT3pWalhLRittaXI1bTIxYXlIMS9ybEVMcTBC?=
 =?utf-8?B?NlNMdXp3K2tZVWhqZU5aZEFod0ZVckk1MkRjRVdFZVUzMnorZ01kTGdBcXJv?=
 =?utf-8?B?N3BQcXdxcTV5MUE5ZzFGYWo2VER6S1QxS05zSWQwZWE1K3RvZ2JuQjhSTEtN?=
 =?utf-8?B?UVlBUUpiS01lY3JjRm5QSmxsdTNaNG5sWnZwQ0lXRXlyTklVUWdiN1JyelJQ?=
 =?utf-8?B?SXpHanJ6c21FNkg0em1tRUFyK3FCUHlaVC96MXZMTmsyRE1KOHhnRVRhTWZF?=
 =?utf-8?B?cnAwWXpGaStSZzhabGswQ3N1cHlBTHIweDU1eHBETjYveFpsK2VnWWhUTDlx?=
 =?utf-8?B?TTBDMDMrYUVwYjZ1YmRLMEhtcVUvR2hKZU9xaGJyS28wNzFpUWJKM3IrMUh0?=
 =?utf-8?B?d2haNGFGUnpxZFR3cS9LOHBRV0g2S3lhRUhnYWVTTXpUMTh0SHg4LzZkdjd5?=
 =?utf-8?B?T2xJSzdPUXhDamhaUktiYUVoODRRWVFuSHdUaXplNFlpUFZ3dEJjQnpIcDds?=
 =?utf-8?B?a2t6cEJCQzUxRUp1S2RhSFNKZkZaQ3ZXeFUva1pYY3FHd2hFcXhmbWZpbnM4?=
 =?utf-8?B?SDB1N0R4VEtGTlhYaWx4MmIremFPNkE2Y3grYTNpTjkxZVA0ZWxNTlNkREww?=
 =?utf-8?B?NTR4YTFNZm5PM0I0NG1zVUhMTjVqdnI4bVpPcWRwSFpLT1pZckd3VmgwVnNw?=
 =?utf-8?B?anp0ZzYrNURjakdUY1VrYWg1Yy9LVTJzb0FHZHZaNlA1YU8wNkR0QXZReU4r?=
 =?utf-8?B?Tk9RTlpmTld1S3lzc2tSQ0ErNllwVWU1eWtDVWgvZURFSFpCYy82Y3poWFZJ?=
 =?utf-8?Q?pp5OS9KiCO5HNBteawmw+0b3eaXgEye/aUsIR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4FA177A81DA6E4BB4F39689B87069E7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0301MB2329.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f60ad7d-ddbb-4eaf-f9c4-08da0198785d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 06:45:59.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgBqFwWHkFF9j1zRPbQKgYYEZJRPOtLR+xWs04/rmgnlvndsu4Ox9BeN9hcq/hrcmegaR2RuuVGsttMvSu2ZN8HpmQLEaGsuh9zMBAI/ydYYi4OQzyD/GsGhcugLeJkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7896
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMy84LzIyIDE3OjQ0LCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiBUaGUgSFJUaW1lciBpbiB0
aGUgQUI4NTAwIGNoYXJnaW5nIGNvZGUgaXMgdXNpbmcgQ0xPQ0tfUkVBTFRJTUUNCj4gdG8gc2V0
IGFuIGFsYXJtIHNvbWUgaG91cnMgZm9yd2FyZCBpbiB0aW1lICsvLSA1IG1pbiBmb3IgYSBzYWZl
dHkNCj4gdGltZXIuDQo+IA0KPiBJIGhhdmUgb2JzZXJ2ZWQgdGhhdCB0aGlzIHdpbGwgc29tZXRp
bWVzIGZpcmUgc3BvcmFkaWNhbGx5DQo+IGVhcmx5IHdoZW4gY2hhcmdpbmcgYSBiYXR0ZXJ5IHdp
dGggdGhlIHJlc3VsdCB0aGF0DQo+IGNoYXJnaW5nIHN0b3BzLg0KPiANCj4gQXMgQ0xPQ0tfUkVB
TFRJTUUgY2FuIGJlIHN1YmplY3QgdG8gYWRqdXN0bWVudHMgb2YgdGltZSBmcm9tDQo+IHNvdXJj
ZXMgc3VjaCBhcyBOVFAsIHRoaXMgY2Fubm90IGJlIHRydXN0ZWQgYW5kIHdpbGwgbGlrZWx5DQo+
IGZvciBleGFtcGxlIGZpcmUgZXZlbnRzIGlmIHRoZSBjbG9jayBpcyBzZXQgZm9yd2FyZCBzb21l
IGhvdXJzDQo+IGJ5IHNheSBOVFAuDQo+IA0KPiBVc2UgQ0xPQ0tfTU9OT1RPTklDIGFzIGluZGlj
YXRlZCBpbiBvdGhlciBpbnN0YW5jZXMgYW5kIHRoZQ0KPiBwcm9ibGVtIGdvZXMgYXdheS4gQWxz
byBpbml0aWFsaXplIHRoZSB0aW1lciB0byBSRUwgbW9kZQ0KPiBhcyB0aGlzIGlzIHdoYXQgd2ls
bCBiZSB1c2VkIGxhdGVyLg0KPiANCj4gRml4ZXM6IDI1NzEwN2FlNmI5YiAoImFiODUwMC1jaGFy
Z2FsZzogVXNlIGhydGltZXIiKQ0KPiBDYzogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4NCj4gU3VnZ2VzdGVkLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50QGdtYWls
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5h
cm8ub3JnPg0KDQpGV0lXOg0KUmV2aWV3ZWQtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFp
dHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkg
YXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBk
cml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5r
a2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9m
IGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
