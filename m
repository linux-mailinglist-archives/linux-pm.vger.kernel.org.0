Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D424ABE5A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Feb 2022 13:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiBGMDS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Feb 2022 07:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378149AbiBGLPp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Feb 2022 06:15:45 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DD0C0401DA
        for <linux-pm@vger.kernel.org>; Mon,  7 Feb 2022 03:15:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqXEm7JnbUDJSd/b/tnEuo6g2aXDp+e7jNkrwxD5w4MJZzLTXsBmjNelFrpIuS75NBepH+/LHXCZRTcDKgQvH6rCvXiHp5UFRD+ENKs841bjn8xcWqVfJ5Z2g3OSTKsvr64cs9riVWG6v+hDlX6dWx+5XLffAnAmn2F/5RaQyRynQP3ObJSkHZv5iZurymQp3KmNep5/UrrXKfAkcS43w53IZerHUOZPZ65sjZMGq/LpLL64YwI8zNgEVjkvq7QOX+KIJZ4C/Ggqd2q81jh1Ha/7XcrZeeUwhUA/CuN43ypa2AvvjGeAAS8ZwKJXvNY5ufwg02wDt4r8SjpIpBOqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAByceCQBClpA8vD0jt8iOwBpJY6b7ijddJwZk1Sy9w=;
 b=SpPw8kODWBcpp9msO8vkA2o1Z0mM05Yc/6/P4JJt9EnOURDK+bSKsMT59y84MU+cOsA7TH6RUB/A2rXKVFFIFr7O++aaWSKfxQVZ7sgaw3umY147zH5RChu00oeuVOlmtCpjXScQYcDtsy5ke9N/Sgjlvla44fyQ+o7zkY4bkV3TPxywwYSu+8y7VvAM9WLKCP+5XOluCXuIS/TmGl5HoekZA6EyYflKwuks7t/oHJKVdTx219oE+fXkRXST7KuUjHOGRZh/9zIG8sDNBY3c3eftTaUIBkhz/Q6Lo6bkacGPRBeXm26t/uogZLi2xSbp9WILnr5FZJjqS2apKfNU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAByceCQBClpA8vD0jt8iOwBpJY6b7ijddJwZk1Sy9w=;
 b=CyrcggFDfJfAgA3p01r4BUCHj3yCEIy+Nln7ijuPFqbxlUmhvDCqNeVs5h5F+x/hwuRKsBnxCNUlHdSjvrYWPzxnrQKVW/BokOfmNDcLZoCEdJFbYnK3F187ubyFtfwCvawgTVd16l9tVqz9Rgxx/xW7CtrjL2SibwXwxJgRFgc=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 PAXPR03MB7731.eurprd03.prod.outlook.com (2603:10a6:102:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 11:15:07 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::833:be72:6b04:dca9]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::833:be72:6b04:dca9%7]) with mapi id 15.20.4951.017; Mon, 7 Feb 2022
 11:15:07 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: Re: [PATCH 1/6] power: supply: ab8500: Standardize maintenance
 charging
Thread-Topic: [PATCH 1/6] power: supply: ab8500: Standardize maintenance
 charging
Thread-Index: AQHYGSMdqDb0RF6TEEeT47NHTIy2z6yH9aUA
Date:   Mon, 7 Feb 2022 11:15:07 +0000
Message-ID: <d49e08be-d24a-6cc7-21e5-c568015b9076@fi.rohmeurope.com>
References: <20220203171633.183828-1-linus.walleij@linaro.org>
 <20220203171633.183828-2-linus.walleij@linaro.org>
In-Reply-To: <20220203171633.183828-2-linus.walleij@linaro.org>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 838502b2-8142-4aaa-d531-08d9ea2b18eb
x-ms-traffictypediagnostic: PAXPR03MB7731:EE_
x-microsoft-antispam-prvs: <PAXPR03MB7731B37AA6470447F102BFE0AD2C9@PAXPR03MB7731.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUwnk5UYXxanFRN6pMg1TdRZcT2mNAhIdPlpJ+3izQeXdRciGl77EM34DtOinUe3ZqUtagh1J98jD2tSdN3pDfWrgE5fcvSsEq9hr1SYSJBShvYNzVCrDmzR3j33ynqmYK1GoXV56f9SLIkOKkw5tGm9lzixV0zyaQzgPOb+yM3JX/s/5tS/1H+/f5I3MyG10tK4+NZVYZuqODZv4Yp/EMGqm7yA4IrRCXaLePLFKNgfrVfH6lczsOZ3o/DhRMVN06Wo0a2uB+XMUPVdPvN6Hjkh/voY/0BIoUwVtCOfAbaUw8hJFPmClQ+gzJk1MpD9flzVBz9YNSkL4hqq1Rvwvdt1eVeUcIWDUomg6GYq+qFefX6m5su45O0KrQenc4JZhHwdYVtnnr9D2nJPCIIx4X0K67rmp9LvT1ZVeXjwSRQ2X/Vg9La4Iz9kqJn9WI04pOCvVPsEhxjbvnGvIYAt3OTQsqdab4Fojphu4FMpkOvrbcwRBcVS5INtmgpauEb1/6nBADRQZBTCOYqHMsuhDl9r7L57MRcspnX2+NYcS7kOI7aA80YGy0B1iYvBXGR0BVLdgEw2z2is0rs5+9EdSJkQuRYi3B6Jcskec54u1XelIsL3432JXIQ67wMUiTslmO3DkpCt6DTLZAiJ++wWwIc0RBKaSM3rDNCY759fvBpr/xH86TJcoSdIzSKAzlXnDOCNT5AZoVV1PuYKut/Lp1lETkEcNPIWuQVzUAr0J0RdDlHcRyVf+/diLisX2/aHUuEuS8sNoAUsYJXIkXWAfry6mknt8uu03cnfTwiZcQsCvQEWZxOg1M04aLVJ1vgT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(6512007)(6506007)(53546011)(5660300002)(30864003)(122000001)(76116006)(71200400001)(83380400001)(2906002)(4326008)(64756008)(54906003)(66946007)(66476007)(66556008)(66446008)(316002)(110136005)(38100700002)(8676002)(8936002)(31686004)(186003)(2616005)(38070700005)(26005)(31696002)(86362001)(448074003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlpwV3RVeHQzMXo3UmdmVmJDc0NKM2k3MVVVV0tFR1E2Z0V5V2NMQ3NRVElC?=
 =?utf-8?B?U0R2akttNzdZcDFNMjFTdExTakltSDlQeU9sQ1BzSmlwMklTOVg4dUtSdHJZ?=
 =?utf-8?B?Wm95VFJTazlwY0syMGpzSkpTK1MrNkZyT2h1Vi9US2JjRit0UE5HLy9KSTdh?=
 =?utf-8?B?NzNrWm9KRUorVW8wNEhVTmQzQnhqRGhvL0c4R0NoR1lIMS9WZ29FK3NOQXpH?=
 =?utf-8?B?dVRwZmxMT0E0dmpINmxHQ0lnYU9IekJVdC9jME05S3pESUpvZm9EdjJYdWVT?=
 =?utf-8?B?M0EzNXluS1lHc1dheSs2Lzkvc3UwNStxcFZrdFBEazJ3MnFGbWpRaEZlZ0NS?=
 =?utf-8?B?TDVZUXZLdmVqSENqNVJBNlZFODIvYTZGSmpaSFdhMWVrUHBCbGlEcFBORi85?=
 =?utf-8?B?S0hYQ0paUWhTbWRSRnpoUDhFcUZoRTZ1cHhUNCtyTWZMdzBRUDdPUXg5QUxF?=
 =?utf-8?B?eTg4akJtMmI3c2dHUjdrS3JqZTJ6dkJ6aUxhMnZyaE9KUHJxMCtXQ0tuMnlQ?=
 =?utf-8?B?amdPWmFLWWVnUzNZcHRMQmtKNVhvcGZUaEdESE11Qkw5UDkxa1lnREVrZzRp?=
 =?utf-8?B?aUs4L0Q3dnNDUFc5eENoY2xtZUoydTZsWGoxQzdGMW1welB3WGh4SjV3SDdF?=
 =?utf-8?B?czdqcmVnc2VvUXZ5cUJ1RUwzenhsVE84MldvWWF6MU1SL0FOemxCL29PU3Nq?=
 =?utf-8?B?dVRkT0xSK2JNUkpxRmtYQVhSNnIxN0ZaN0N5clpPNzd4YmRqdDlXV3BzOTlG?=
 =?utf-8?B?SHFmSDNuS2VzRE9RTjdaWjh2UEhWUGVtbDNMQ0dvcGJZc2l3VUhXYmZPNHAy?=
 =?utf-8?B?a21NS29rbmwvaGp5YVlrVFhWVzNLMDloSWxPeVB5bzZUQ2VJYnV5Yis1WERF?=
 =?utf-8?B?ZXZoaklZbm5MYzFhMlJjNG43aUlzMHJrSHJMYUp2N0dPcnRwK2hqL29sMk80?=
 =?utf-8?B?eUlMcXQwWXM0azRzejgzeWwzdENYUFhKSzlxamRhc2xqaS9SN3dub2xCT0pI?=
 =?utf-8?B?ZVJWSEVVQzdmUWMwMXdDcWg3RTVEQVU4L2ZHaldwYVRjNkJhazM1NFNRb2xU?=
 =?utf-8?B?aGw1cFFQUngwQ3hyS0ZFZ3RXTjN1ckJZN0JWVXZUbGF2QU1MNmpyWWlYakp1?=
 =?utf-8?B?OVhXNExOQW5RTGo0aGxaMzIvN1pXbmh5RysxNUVGT01GZS90VHAxV0RHUFNS?=
 =?utf-8?B?eGUwQUo3VnBoQmxvZlEwTTZVazdjSjFkcnhZeGN3SWFJZVRDRnAwSWVXUTFR?=
 =?utf-8?B?aXdEeHE3Y0IzK3pYV0hqR3hlRjFXZkgrTDRLTUltbkRGRlFOOHlQVXltZlZr?=
 =?utf-8?B?L0xnVnEva1ltakZiY2liRzJDcnhocWF2ZFJ6b0s1NHZtbElBYlZ2MXdYMlJK?=
 =?utf-8?B?V05ZRDJidjJzOXF5UHE0M1UwRVJNNnhiVWZvaktrYWlwZ3IxdVNBN3VhZWg3?=
 =?utf-8?B?SFFLN3doeTdidmh4UHIyaDJQL1dEaDhoOUg3d3NZcUl4OHNtOHV4QkJVZVVw?=
 =?utf-8?B?cmFVTkVtZU5hT2lYR3ZzQjRSc1VxTGt3blV2c3ZtYnhyUEY1em8vYlorc0hW?=
 =?utf-8?B?MjdSeVBLcFVmb3h5aGFNRTMraVI0Rm1rT3AzaHEydzIyczBuME1wbFNKZjdP?=
 =?utf-8?B?Q2Y3N1MreU55WlQ1akVRUlA3RWx6bTZvRHkvbG5QNVFmSTcxNmVtbkpzNHRt?=
 =?utf-8?B?a2FqMnZIcmExWkZ1VG9VZy9SZnZGV0RLNUtQMHE0OTVtOG03OXNVVkg1b3oy?=
 =?utf-8?B?YWdVK2R5anEvUXQzRGdJUDEvSTY4dkM4Z1JQTG90ckh6ckFkTzNsa2ZnZnIv?=
 =?utf-8?B?VjNGcjYydUhEODY0VzdBLzg0d2RYZnZtS2JETjlOM3lrWFNvRzNqbHZDZk9l?=
 =?utf-8?B?V2E0RkZvZFpXL0ZPaGh1UjlsZU1WbVErVDJIZ0NXbGNoVTlBN1I5OXE3QmJy?=
 =?utf-8?B?dkJDbWVibzIvMGFNOHBUTElsVW9VYkhFaTA1emYzRGFZNWIvZlJWeVgzUUdH?=
 =?utf-8?B?VVFJNmUzUDJ4dEhicEpRTEN2S2lJbnBkMG1UMGtxdE52c2MyVkZtVGF4WmxX?=
 =?utf-8?B?SlhmalpwOE1ZK2ozTGh6V0NZVVAvY09JMjB1bDBDK2FPaitoendGV2N4ZTNR?=
 =?utf-8?B?R2YwK1RMbzJwcE8xUXRSbVRMZ04wNzQxV2JQRWN6UmZXTE1raGpZTklHcExj?=
 =?utf-8?B?Y2xpRDU3NUxXK2JyRVNSUHBhMXZRSVB3SnFGWnJMdWFHeDJ1dXd1bHZZS2Jm?=
 =?utf-8?B?ME1ZeXJRUmcwdmhXdlU2REwwYmZVZWNaSVN4L2hpeDIzNCtNUGpqVWpnWUJN?=
 =?utf-8?Q?pa3H71BEQJ7U4VEw5J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15DA4DD27CEA3646A1537CAA7FDAE5BE@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838502b2-8142-4aaa-d531-08d9ea2b18eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 11:15:07.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJ1uo/M5MblSZ5bvOmfqbF3QbCqpbYAU9y0VN5x/UZIQB4Jc1CK9idAgqTtf5Kk/w5swOGB4u57eP33dsxj425rXYlwpal1zrTMvWHm/5YDQbliZjEVC0WWr2lBovMOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7731
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gTGludXMsDQoNCkkgZm91bmQgdGhpcyBsYXlpbmcgaW4gbXkgaW5ib3guDQovKiB0aW55
IGJpdCBvZiBzYXJjYXNtICovDQpBZnRlciB3ZWVrZW5kIGZ1bGwgb2YgRk9TREVNIGl0J3MgZ29v
ZCB0byBjbGVhciBteSBoZWFkIGJ5IHJlYWRpbmcgc29tZSANCnNvbGlkIGNvZGUgOnAgU28gdGhh
bmtzIGZvciB0aGlzLg0KLyogU2FyY2FzbSBzdG9wcyBoZXJlICovDQoNCk9uIDIvMy8yMiAxOTox
NiwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gTWFpbnRlbmFuY2UgY2hhcmdpbmcgaXMgdGhlIHBo
YXNlIG9mIGtlZXBpbmcgdXAgdGhlIGNoYXJnZQ0KPiBhZnRlciB0aGUgYmF0dGVyeSBoYXMgY2hh
cmdlZCBmdWxseSB1c2luZyBDQy9DViBjaGFyZ2luZy4NCj4gDQo+IFRoaXMgY2FuIGJlIGRvbmUg
aW4gbWFueSBzdWNjZXNzaXZlIHBoYXNlcyBhbmQgaXMgdXN1YWxseQ0KPiBkb25lIHdpdGggYSBz
bGlnaHRseSBsb3dlciBjb25zdGFudCB2b2x0YWdlIHRoYW4gQ1YsIGFuZA0KPiBhIHNsaWdodGx5
IGxvd2VyIGFsbG93ZWQgY3VycmVudC4NCj4gDQo+IEFkZCBhbiBhcnJheSBvZiBtYWludGVuYW5j
ZSBjaGFyZ2luZyBwb2ludHMgZWFjaCB3aXRoIGENCj4gY3VycmVudCwgdm9sdGFnZSBhbmQgc2Fm
ZXR5IHRpbWVyLCBhbmQgYWRkIGhlbHBlciBmdW5jdGlvbnMNCj4gdG8gdXNlIHRoZXNlLiBNaWdy
YXRlIHRoZSBBQjg1MDAgY29kZSBvdmVyLg0KDQpMdWNrbGlseSB5b3UgYWx3YXlzIG1ha2UgaXQg
cmVsYXRpdmVseSBlYXN5IGJ5IGFjdHVhbGx5IGV4cGxhaW5pbmcgd2hhdCANCmhhcHBlbnMuIDop
IEkgZG8gbGlrZSB5b3VyIGRlc2NyaXB0aW9ucy4NCg0KPiANCj4gVGhpcyBpcyB1c2VkIGluIHNl
dmVyYWwgU2Ftc3VuZyBwcm9kdWN0cyB1c2luZyB0aGUgQUI4NTAwDQo+IGFuZCB0aGVzZSBiYXR0
ZXJpZXMgYW5kIHRoZWlyIGNvbXBsZXRlIHBhcmFtZXRlcnMgd2lsbA0KPiBiZSBhZGRlZCBsYXRl
ciBhcyBmdWxsIGV4YW1wbGVzLCBidXQgdGhlIGRlZmF1bHQgYmF0dGVyeQ0KPiBpbiB0aGUgQUI4
NTAwIGNvZGUgc2VydmVzIGFzIGEgcmVhc29uYWJsZSBleGFtcGxlIHNvIGZhci4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4g
LS0tDQo+ICAgZHJpdmVycy9wb3dlci9zdXBwbHkvYWI4NTAwLWJtLmggICAgICAgICB8IDE0IC0t
LS0tLQ0KPiAgIGRyaXZlcnMvcG93ZXIvc3VwcGx5L2FiODUwMF9ibWRhdGEuYyAgICAgfCAyNyAr
KysrKysrLS0tDQo+ICAgZHJpdmVycy9wb3dlci9zdXBwbHkvYWI4NTAwX2NoYXJnYWxnLmMgICB8
IDQxICsrKysrKysrKysrLS0tLQ0KPiAgIGRyaXZlcnMvcG93ZXIvc3VwcGx5L3Bvd2VyX3N1cHBs
eV9jb3JlLmMgfCAxMSArKysrDQo+ICAgaW5jbHVkZS9saW51eC9wb3dlcl9zdXBwbHkuaCAgICAg
ICAgICAgICB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDUgZmlsZXMgY2hhbmdl
ZCwgMTI2IGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcG93ZXIvc3VwcGx5L2FiODUwMC1ibS5oIGIvZHJpdmVycy9wb3dlci9zdXBwbHkv
YWI4NTAwLWJtLmgNCj4gaW5kZXggNmVmZDUxNzRkYmNlLi40ZDc0ZDIxY2YxZWIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2FiODUwMC1ibS5oDQo+ICsrKyBiL2RyaXZlcnMv
cG93ZXIvc3VwcGx5L2FiODUwMC1ibS5oDQo+IEBAIC0zMzEsMjQgKzMzMSwxMiBAQCBzdHJ1Y3Qg
YWI4NTAwX21heGltX3BhcmFtZXRlcnMgew0KPiAgICAqIHN0cnVjdCBhYjg1MDBfYmF0dGVyeV90
eXBlIC0gZGlmZmVyZW50IGJhdHRlcmllcyBzdXBwb3J0ZWQNCj4gICAgKiBAcmVzaXNfaGlnaDoJ
CQliYXR0ZXJ5IHVwcGVyIHJlc2lzdGFuY2UgbGltaXQNCj4gICAgKiBAcmVzaXNfbG93OgkJCWJh
dHRlcnkgbG93ZXIgcmVzaXN0YW5jZSBsaW1pdA0KPiAtICogQG1haW50X2FfY3VyX2x2bDoJCWNo
YXJnZXIgY3VycmVudCBpbiBtYWludGVuYW5jZSBBIHN0YXRlIGluIG1BDQo+IC0gKiBAbWFpbnRf
YV92b2xfbHZsOgkJY2hhcmdlciB2b2x0YWdlIGluIG1haW50ZW5hbmNlIEEgc3RhdGUgaW4gbVYN
Cj4gLSAqIEBtYWludF9hX2NoZ190aW1lcl9oOgljaGFyZ2UgdGltZSBpbiBtYWludGVuYW5jZSBB
IHN0YXRlDQo+IC0gKiBAbWFpbnRfYl9jdXJfbHZsOgkJY2hhcmdlciBjdXJyZW50IGluIG1haW50
ZW5hbmNlIEIgc3RhdGUgaW4gbUENCj4gLSAqIEBtYWludF9iX3ZvbF9sdmw6CQljaGFyZ2VyIHZv
bHRhZ2UgaW4gbWFpbnRlbmFuY2UgQiBzdGF0ZSBpbiBtVg0KPiAtICogQG1haW50X2JfY2hnX3Rp
bWVyX2g6CWNoYXJnZSB0aW1lIGluIG1haW50ZW5hbmNlIEIgc3RhdGUNCj4gICAgKiBAbG93X2hp
Z2hfY3VyX2x2bDoJCWNoYXJnZXIgY3VycmVudCBpbiB0ZW1wIGxvdy9oaWdoIHN0YXRlIGluIG1B
DQo+ICAgICogQGxvd19oaWdoX3ZvbF9sdmw6CQljaGFyZ2VyIHZvbHRhZ2UgaW4gdGVtcCBsb3cv
aGlnaCBzdGF0ZSBpbiBtVicNCj4gICAgKi8NCj4gICBzdHJ1Y3QgYWI4NTAwX2JhdHRlcnlfdHlw
ZSB7DQo+ICAgCWludCByZXNpc19oaWdoOw0KPiAgIAlpbnQgcmVzaXNfbG93Ow0KPiAtCWludCBt
YWludF9hX2N1cl9sdmw7DQo+IC0JaW50IG1haW50X2Ffdm9sX2x2bDsNCj4gLQlpbnQgbWFpbnRf
YV9jaGdfdGltZXJfaDsNCj4gLQlpbnQgbWFpbnRfYl9jdXJfbHZsOw0KPiAtCWludCBtYWludF9i
X3ZvbF9sdmw7DQo+IC0JaW50IG1haW50X2JfY2hnX3RpbWVyX2g7DQo+ICAgCWludCBsb3dfaGln
aF9jdXJfbHZsOw0KPiAgIAlpbnQgbG93X2hpZ2hfdm9sX2x2bDsNCj4gICB9Ow0KPiBAQCAtMzkz
LDcgKzM4MSw2IEBAIHN0cnVjdCBhYjg1MDBfYm1fY2hhcmdlcl9wYXJhbWV0ZXJzIHsNCj4gICAg
KiBAdXNiX3NhZmV0eV90bXJfaAlzYWZldHkgdGltZXIgZm9yIHVzYiBjaGFyZ2VyDQo+ICAgICog
QGJrdXBfYmF0X3YJCXZvbHRhZ2Ugd2hpY2ggd2UgY2hhcmdlIHRoZSBiYWNrdXAgYmF0dGVyeSB3
aXRoDQo+ICAgICogQGJrdXBfYmF0X2kJCWN1cnJlbnQgd2hpY2ggd2UgY2hhcmdlIHRoZSBiYWNr
dXAgYmF0dGVyeSB3aXRoDQo+IC0gKiBAbm9fbWFpbnRlbmFuY2UJaW5kaWNhdGVzIHRoYXQgbWFp
bnRlbmFuY2UgY2hhcmdpbmcgaXMgZGlzYWJsZWQNCj4gICAgKiBAY2FwYWNpdHlfc2NhbGluZyAg
ICBpbmRpY2F0ZXMgd2hldGhlciBjYXBhY2l0eSBzY2FsaW5nIGlzIHRvIGJlIHVzZWQNCj4gICAg
KiBAY2hnX3Vua25vd25fYmF0CWZsYWcgdG8gZW5hYmxlIGNoYXJnaW5nIG9mIHVua25vd24gYmF0
dGVyaWVzDQo+ICAgICogQGVuYWJsZV9vdmVyc2hvb3QJZmxhZyB0byBlbmFibGUgVkJBVCBvdmVy
c2hvb3QgY29udHJvbA0KPiBAQCAtNDE3LDcgKzQwNCw2IEBAIHN0cnVjdCBhYjg1MDBfYm1fZGF0
YSB7DQo+ICAgCWludCB1c2Jfc2FmZXR5X3Rtcl9oOw0KPiAgIAlpbnQgYmt1cF9iYXRfdjsNCj4g
ICAJaW50IGJrdXBfYmF0X2k7DQo+IC0JYm9vbCBub19tYWludGVuYW5jZTsNCj4gICAJYm9vbCBj
YXBhY2l0eV9zY2FsaW5nOw0KPiAgIAlib29sIGNoZ191bmtub3duX2JhdDsNCj4gICAJYm9vbCBl
bmFibGVfb3ZlcnNob290Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9zdXBwbHkvYWI4
NTAwX2JtZGF0YS5jIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvYWI4NTAwX2JtZGF0YS5jDQo+IGlu
ZGV4IGQ4ZmM3MmJlMGYwZS4uYzEwNGFmZTgzYjRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bv
d2VyL3N1cHBseS9hYjg1MDBfYm1kYXRhLmMNCj4gKysrIGIvZHJpdmVycy9wb3dlci9zdXBwbHkv
YWI4NTAwX2JtZGF0YS5jDQo+IEBAIC01OCwxNiArNTgsMjUgQEAgc3RhdGljIHN0cnVjdCBwb3dl
cl9zdXBwbHlfcmVzaXN0YW5jZV90ZW1wX3RhYmxlIHRlbXBfdG9fYmF0cmVzX3RibF90aGVybWlz
dG9yW10NCj4gICAJeyAudGVtcCA9IC0yMCwgLnJlc2lzdGFuY2UgPSAxOTggLyogNTk1IG1PaG0g
Ki8gfSwNCj4gICB9Ow0KPiAgIA0KPiArc3RydWN0IHBvd2VyX3N1cHBseV9tYWludGVuYW5jZV9j
aGFyZ2VfdGFibGUgbWFpbnRfY2hhcmdlX3RhYmxlW10gPSB7DQoNCkNvdWxkIHRoaXMgYmUgc3Rh
dGljIGNvbnN0PyBBbmQgbWF5YmUgbGVzcyBnZW5lcmljIG5hbWU/DQoNCj4gKwl7DQo+ICsJCS8q
IE1haW50ZW5hbmNlIGNoYXJnaW5nIHBoYXNlIEEsIDYwIGhvdXJzICovDQo+ICsJCS5jaGFyZ2Vf
Y3VycmVudF9tYXhfdWEgPSA0MDAwMDAsDQo+ICsJCS5jaGFyZ2Vfdm9sdGFnZV9tYXhfdXYgPSA0
MDUwMDAwLA0KPiArCQkuY2hhcmdlX3NhZmV0eV90aW1lcl9taW51dGVzID0gNjAqNjAsDQo+ICsJ
fSwNCj4gKwl7DQo+ICsJCS8qIE1haW50ZW5hbmNlIGNoYXJnaW5nIHBoYXNlIEIsIDIwMCBob3Vy
cyAqLw0KPiArCQkuY2hhcmdlX2N1cnJlbnRfbWF4X3VhID0gNDAwMDAwLA0KPiArCQkuY2hhcmdl
X3ZvbHRhZ2VfbWF4X3V2ID0gNDAwMDAwMCwNCj4gKwkJLmNoYXJnZV9zYWZldHlfdGltZXJfbWlu
dXRlcyA9IDIwMCo2MCwNCj4gKwl9DQo+ICt9Ow0KPiArDQo+ICAgLyogRGVmYXVsdCBiYXR0ZXJ5
IHR5cGUgZm9yIHJlZmVyZW5jZSBkZXNpZ25zIGlzIHRoZSB1bmtub3duIHR5cGUgKi8NCj4gICBz
dGF0aWMgc3RydWN0IGFiODUwMF9iYXR0ZXJ5X3R5cGUgYmF0X3R5cGVfdGhlcm1pc3Rvcl91bmtu
b3duID0gew0KPiAgIAkucmVzaXNfaGlnaCA9IDAsDQo+ICAgCS5yZXNpc19sb3cgPSAwLA0KPiAt
CS5tYWludF9hX2N1cl9sdmwgPSA0MDAsDQo+IC0JLm1haW50X2Ffdm9sX2x2bCA9IDQwNTAsDQo+
IC0JLm1haW50X2FfY2hnX3RpbWVyX2ggPSA2MCwNCj4gLQkubWFpbnRfYl9jdXJfbHZsID0gNDAw
LA0KPiAtCS5tYWludF9iX3ZvbF9sdmwgPSA0MDAwLA0KPiAtCS5tYWludF9iX2NoZ190aW1lcl9o
ID0gMjAwLA0KPiAgIAkubG93X2hpZ2hfY3VyX2x2bCA9IDMwMCwNCj4gICAJLmxvd19oaWdoX3Zv
bF9sdmwgPSA0MDAwLA0KPiAgIH07DQo+IEBAIC0xMjQsNyArMTMzLDYgQEAgc3RydWN0IGFiODUw
MF9ibV9kYXRhIGFiODUwMF9ibV9kYXRhID0gew0KDQpzdGF0aWMgPw0KDQo+ICAgCS51c2Jfc2Fm
ZXR5X3Rtcl9oICAgICAgID0gNCwNCj4gICAJLmJrdXBfYmF0X3YgICAgICAgICAgICAgPSBCVVBf
VkNIX1NFTF8yUDZWLA0KPiAgIAkuYmt1cF9iYXRfaSAgICAgICAgICAgICA9IEJVUF9JQ0hfU0VM
XzE1MFVBLA0KPiAtCS5ub19tYWludGVuYW5jZSAgICAgICAgID0gZmFsc2UsDQo+ICAgCS5jYXBh
Y2l0eV9zY2FsaW5nICAgICAgID0gZmFsc2UsDQo+ICAgCS5jaGdfdW5rbm93bl9iYXQgICAgICAg
ID0gZmFsc2UsDQo+ICAgCS5lbmFibGVfb3ZlcnNob290ICAgICAgID0gZmFsc2UsDQo+IEBAIC0x
NzksNiArMTg3LDExIEBAIGludCBhYjg1MDBfYm1fb2ZfcHJvYmUoc3RydWN0IHBvd2VyX3N1cHBs
eSAqcHN5LA0KPiAgIAkJLyogQ2hhcmdpbmcgc3RvcHMgd2hlbiB3ZSBkcm9wIGJlbG93IHRoaXMg
Y3VycmVudCAqLw0KPiAgIAkJYmktPmNoYXJnZV90ZXJtX2N1cnJlbnRfdWEgPSAyMDAwMDA7DQo+
ICAgDQo+ICsJaWYgKCFiaS0+bWFpbnRlbmFuY2VfY2hhcmdlIHx8ICFiaS0+bWFpbnRlbmFuY2Vf
Y2hhcmdlX3NpemUpIHsNCj4gKwkJYmktPm1haW50ZW5hbmNlX2NoYXJnZSA9IG1haW50X2NoYXJn
ZV90YWJsZTsNCj4gKwkJYmktPm1haW50ZW5hbmNlX2NoYXJnZV9zaXplID0gQVJSQVlfU0laRSht
YWludF9jaGFyZ2VfdGFibGUpOw0KPiArCX0NCj4gKw0KPiAgIAkvKg0KPiAgIAkgKiBJbnRlcm5h
bCByZXNpc3RhbmNlIGFuZCBmYWN0b3J5IHJlc2lzdGFuY2UgYXJlIHRpZ2h0bHkgY291cGxlZA0K
PiAgIAkgKiBzbyBib3RoIE1VU1QgYmUgZGVmaW5lZCBvciB3ZSBmYWxsIGJhY2sgdG8gZGVmYXVs
dHMuDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9hYjg1MDBfY2hhcmdhbGcu
YyBiL2RyaXZlcnMvcG93ZXIvc3VwcGx5L2FiODUwMF9jaGFyZ2FsZy5jDQo+IGluZGV4IGI1YTMw
OTZlNzhhMS4uNjA1NDk5NmI2MjYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bvd2VyL3N1cHBs
eS9hYjg1MDBfY2hhcmdhbGcuYw0KPiArKysgYi9kcml2ZXJzL3Bvd2VyL3N1cHBseS9hYjg1MDBf
Y2hhcmdhbGcuYw0KPiBAQCAtNDMwLDcgKzQzMCw3IEBAIHN0YXRpYyB2b2lkIGFiODUwMF9jaGFy
Z2FsZ19zdG9wX3NhZmV0eV90aW1lcihzdHJ1Y3QgYWI4NTAwX2NoYXJnYWxnICpkaSkNCj4gICAv
KioNCj4gICAgKiBhYjg1MDBfY2hhcmdhbGdfc3RhcnRfbWFpbnRlbmFuY2VfdGltZXIoKSAtIFN0
YXJ0IGNoYXJnaW5nIG1haW50ZW5hbmNlIHRpbWVyDQo+ICAgICogQGRpOgkJcG9pbnRlciB0byB0
aGUgYWI4NTAwX2NoYXJnYWxnIHN0cnVjdHVyZQ0KPiAtICogQGR1cmF0aW9uOglkdXJhdGlvbiBv
ZiB0aGVyIG1haW50ZW5hbmNlIHRpbWVyIGluIGhvdXJzDQo+ICsgKiBAZHVyYXRpb246CWR1cmF0
aW9uIG9mIHRoZXIgbWFpbnRlbmFuY2UgdGltZXIgaW4gbWludXRlcw0KPiAgICAqDQo+ICAgICog
VGhlIG1haW50ZW5hbmNlIHRpbWVyIGlzIHVzZWQgdG8gbWFpbnRhaW4gdGhlIGNoYXJnZSBpbiB0
aGUgYmF0dGVyeSBvbmNlDQo+ICAgICogdGhlIGJhdHRlcnkgaXMgY29uc2lkZXJlZCBmdWxsLiBU
aGVzZSB0aW1lcnMgYXJlIGNob3NlbiB0byBtYXRjaCB0aGUNCj4gQEAgLTQzOSw5ICs0MzksMTAg
QEAgc3RhdGljIHZvaWQgYWI4NTAwX2NoYXJnYWxnX3N0b3Bfc2FmZXR5X3RpbWVyKHN0cnVjdCBh
Yjg1MDBfY2hhcmdhbGcgKmRpKQ0KPiAgIHN0YXRpYyB2b2lkIGFiODUwMF9jaGFyZ2FsZ19zdGFy
dF9tYWludGVuYW5jZV90aW1lcihzdHJ1Y3QgYWI4NTAwX2NoYXJnYWxnICpkaSwNCj4gICAJaW50
IGR1cmF0aW9uKQ0KPiAgIHsNCj4gKwkvKiBTZXQgYSB0aW1lciBpbiBtaW51dGVzIHdpdGggYSAz
MCBzZWNvbmQgcmFuZ2UgKi8NCj4gICAJaHJ0aW1lcl9zZXRfZXhwaXJlc19yYW5nZSgmZGktPm1h
aW50ZW5hbmNlX3RpbWVyLA0KPiAtCQlrdGltZV9zZXQoZHVyYXRpb24gKiBPTkVfSE9VUl9JTl9T
RUNPTkRTLCAwKSwNCj4gLQkJa3RpbWVfc2V0KEZJVkVfTUlOVVRFU19JTl9TRUNPTkRTLCAwKSk7
DQo+ICsJCWt0aW1lX3NldChkdXJhdGlvbiAqIDYwLCAwKSwNCj4gKwkJa3RpbWVfc2V0KDMwLCAw
KSk7DQo+ICAgCWRpLT5ldmVudHMubWFpbnRlbmFuY2VfdGltZXJfZXhwaXJlZCA9IGZhbHNlOw0K
PiAgIAlocnRpbWVyX3N0YXJ0X2V4cGlyZXMoJmRpLT5tYWludGVuYW5jZV90aW1lciwgSFJUSU1F
Ul9NT0RFX1JFTCk7DQo+ICAgfQ0KPiBAQCAtMTIyMyw2ICsxMjI0LDcgQEAgc3RhdGljIHZvaWQg
YWI4NTAwX2NoYXJnYWxnX2V4dGVybmFsX3Bvd2VyX2NoYW5nZWQoc3RydWN0IHBvd2VyX3N1cHBs
eSAqcHN5KQ0KPiAgIHN0YXRpYyB2b2lkIGFiODUwMF9jaGFyZ2FsZ19hbGdvcml0aG0oc3RydWN0
IGFiODUwMF9jaGFyZ2FsZyAqZGkpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgcG93ZXJfc3VwcGx5X2Jh
dHRlcnlfaW5mbyAqYmkgPSBkaS0+Ym0tPmJpOw0KPiArCXN0cnVjdCBwb3dlcl9zdXBwbHlfbWFp
bnRlbmFuY2VfY2hhcmdlX3RhYmxlICptdDsNCj4gICAJaW50IGNoYXJnZXJfc3RhdHVzOw0KPiAg
IAlpbnQgcmV0Ow0KPiAgIA0KPiBAQCAtMTQzMyw3ICsxNDM1LDEyIEBAIHN0YXRpYyB2b2lkIGFi
ODUwMF9jaGFyZ2FsZ19hbGdvcml0aG0oc3RydWN0IGFiODUwMF9jaGFyZ2FsZyAqZGkpDQo+ICAg
CQloYW5kbGVfbWF4aW1fY2hnX2N1cnIoZGkpOw0KPiAgIAkJaWYgKGRpLT5jaGFyZ2Vfc3RhdHVz
ID09IFBPV0VSX1NVUFBMWV9TVEFUVVNfRlVMTCAmJg0KPiAgIAkJCWRpLT5tYWludGVuYW5jZV9j
aGcpIHsNCj4gLQkJCWlmIChkaS0+Ym0tPm5vX21haW50ZW5hbmNlKQ0KPiArCQkJLyoNCj4gKwkJ
CSAqIFRoZSBiYXR0ZXJ5IGlzIGZ1bGx5IGNoYXJnZWQsIGNoZWNrIGlmIHdlIHN1cHBvcnQNCj4g
KwkJCSAqIG1haW50ZW5hbmNlIGNoYXJnaW5nIGVsc2UgZ28gYmFjayB0byB3YWl0aW5nIGZvcg0K
PiArCQkJICogdGhlIHJlY2hhcmdlIHZvbHRhZ2UgbGltaXQuDQo+ICsJCQkgKi8NCj4gKwkJCWlm
ICghcG93ZXJfc3VwcGx5X3N1cHBvcnRzX21haW50ZW5hbmNlX2NoYXJnaW5nKGJpKSkNCj4gICAJ
CQkJYWI4NTAwX2NoYXJnYWxnX3N0YXRlX3RvKGRpLA0KPiAgIAkJCQkJU1RBVEVfV0FJVF9GT1Jf
UkVDSEFSR0VfSU5JVCk7DQo+ICAgCQkJZWxzZQ0KPiBAQCAtMTQ1NCwxMiArMTQ2MSwxOSBAQCBz
dGF0aWMgdm9pZCBhYjg1MDBfY2hhcmdhbGdfYWxnb3JpdGhtKHN0cnVjdCBhYjg1MDBfY2hhcmdh
bGcgKmRpKQ0KPiAgIAkJYnJlYWs7DQo+ICAgDQo+ICAgCWNhc2UgU1RBVEVfTUFJTlRFTkFOQ0Vf
QV9JTklUOg0KPiArCQltdCA9IHBvd2VyX3N1cHBseV9nZXRfbWFpbnRlbmFuY2VfY2hhcmdpbmdf
c2V0dGluZyhiaSwgMCk7DQo+ICsJCWlmICghbXQpIHsNCj4gKwkJCS8qIE5vIG1haW50ZW5hbmNl
IEEgc3RhdGUsIGdvIGJhY2sgdG8gbm9ybWFsICovDQo+ICsJCQlhYjg1MDBfY2hhcmdhbGdfc3Rh
dGVfdG8oZGksIFNUQVRFX05PUk1BTF9JTklUKTsNCj4gKwkJCXBvd2VyX3N1cHBseV9jaGFuZ2Vk
KGRpLT5jaGFyZ2FsZ19wc3kpOw0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gICAJCWFiODUwMF9j
aGFyZ2FsZ19zdG9wX3NhZmV0eV90aW1lcihkaSk7DQo+ICAgCQlhYjg1MDBfY2hhcmdhbGdfc3Rh
cnRfbWFpbnRlbmFuY2VfdGltZXIoZGksDQo+IC0JCQlkaS0+Ym0tPmJhdF90eXBlLT5tYWludF9h
X2NoZ190aW1lcl9oKTsNCj4gKwkJCW10LT5jaGFyZ2Vfc2FmZXR5X3RpbWVyX21pbnV0ZXMpOw0K
PiAgIAkJYWI4NTAwX2NoYXJnYWxnX3N0YXJ0X2NoYXJnaW5nKGRpLA0KPiAtCQkJZGktPmJtLT5i
YXRfdHlwZS0+bWFpbnRfYV92b2xfbHZsLA0KPiAtCQkJZGktPmJtLT5iYXRfdHlwZS0+bWFpbnRf
YV9jdXJfbHZsKTsNCj4gKwkJCW10LT5jaGFyZ2Vfdm9sdGFnZV9tYXhfdXYsDQo+ICsJCQltdC0+
Y2hhcmdlX2N1cnJlbnRfbWF4X3VhKTsNCj4gICAJCWFiODUwMF9jaGFyZ2FsZ19zdGF0ZV90byhk
aSwgU1RBVEVfTUFJTlRFTkFOQ0VfQSk7DQo+ICAgCQlwb3dlcl9zdXBwbHlfY2hhbmdlZChkaS0+
Y2hhcmdhbGdfcHN5KTsNCj4gICAJCWZhbGx0aHJvdWdoOw0KPiBAQCAtMTQ3MiwxMSArMTQ4Niwx
OCBAQCBzdGF0aWMgdm9pZCBhYjg1MDBfY2hhcmdhbGdfYWxnb3JpdGhtKHN0cnVjdCBhYjg1MDBf
Y2hhcmdhbGcgKmRpKQ0KPiAgIAkJYnJlYWs7DQo+ICAgDQo+ICAgCWNhc2UgU1RBVEVfTUFJTlRF
TkFOQ0VfQl9JTklUOg0KPiArCQltdCA9IHBvd2VyX3N1cHBseV9nZXRfbWFpbnRlbmFuY2VfY2hh
cmdpbmdfc2V0dGluZyhiaSwgMSk7DQo+ICsJCWlmICghbXQpIHsNCj4gKwkJCS8qIE5vIG1haW50
ZW5hbmNlIEIgc3RhdGUsIGdvIGJhY2sgdG8gbm9ybWFsICovDQo+ICsJCQlhYjg1MDBfY2hhcmdh
bGdfc3RhdGVfdG8oZGksIFNUQVRFX05PUk1BTF9JTklUKTsNCj4gKwkJCXBvd2VyX3N1cHBseV9j
aGFuZ2VkKGRpLT5jaGFyZ2FsZ19wc3kpOw0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCj4gICAJCWFi
ODUwMF9jaGFyZ2FsZ19zdGFydF9tYWludGVuYW5jZV90aW1lcihkaSwNCj4gLQkJCWRpLT5ibS0+
YmF0X3R5cGUtPm1haW50X2JfY2hnX3RpbWVyX2gpOw0KPiArCQkJbXQtPmNoYXJnZV9zYWZldHlf
dGltZXJfbWludXRlcyk7DQo+ICAgCQlhYjg1MDBfY2hhcmdhbGdfc3RhcnRfY2hhcmdpbmcoZGks
DQo+IC0JCQlkaS0+Ym0tPmJhdF90eXBlLT5tYWludF9iX3ZvbF9sdmwsDQo+IC0JCQlkaS0+Ym0t
PmJhdF90eXBlLT5tYWludF9iX2N1cl9sdmwpOw0KPiArCQkJbXQtPmNoYXJnZV92b2x0YWdlX21h
eF91diwNCj4gKwkJCW10LT5jaGFyZ2VfY3VycmVudF9tYXhfdWEpOw0KPiAgIAkJYWI4NTAwX2No
YXJnYWxnX3N0YXRlX3RvKGRpLCBTVEFURV9NQUlOVEVOQU5DRV9CKTsNCj4gICAJCXBvd2VyX3N1
cHBseV9jaGFuZ2VkKGRpLT5jaGFyZ2FsZ19wc3kpOw0KPiAgIAkJZmFsbHRocm91Z2g7DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBwbHlfY29yZS5jIGIvZHJp
dmVycy9wb3dlci9zdXBwbHkvcG93ZXJfc3VwcGx5X2NvcmUuYw0KPiBpbmRleCBlYzgzOGM5YmNj
MGEuLjY1Njg5MzllNDUxOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wb3dlci9zdXBwbHkvcG93
ZXJfc3VwcGx5X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3Bvd2VyL3N1cHBseS9wb3dlcl9zdXBw
bHlfY29yZS5jDQo+IEBAIC01OTAsNiArNTkwLDcgQEAgaW50IHBvd2VyX3N1cHBseV9nZXRfYmF0
dGVyeV9pbmZvKHN0cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSwNCj4gICAJaW5mby0+cHJlY2hhcmdl
X3ZvbHRhZ2VfbWF4X3V2ICAgICAgID0gLUVJTlZBTDsNCj4gICAJaW5mby0+Y2hhcmdlX3Jlc3Rh
cnRfdm9sdGFnZV91diAgICAgID0gLUVJTlZBTDsNCj4gICAJaW5mby0+b3ZlcnZvbHRhZ2VfbGlt
aXRfdXYgICAgICAgICAgID0gLUVJTlZBTDsNCj4gKwlpbmZvLT5tYWludGVuYW5jZV9jaGFyZ2Ug
ICAgICAgICAgICAgPSBOVUxMOw0KPiAgIAlpbmZvLT50ZW1wX2FtYmllbnRfYWxlcnRfbWluICAg
ICAgICAgPSBJTlRfTUlOOw0KPiAgIAlpbmZvLT50ZW1wX2FtYmllbnRfYWxlcnRfbWF4ICAgICAg
ICAgPSBJTlRfTUFYOw0KPiAgIAlpbmZvLT50ZW1wX2FsZXJ0X21pbiAgICAgICAgICAgICAgICAg
PSBJTlRfTUlOOw0KPiBAQCAtODIxLDYgKzgyMiwxNiBAQCBpbnQgcG93ZXJfc3VwcGx5X3RlbXAy
cmVzaXN0X3NpbXBsZShzdHJ1Y3QgcG93ZXJfc3VwcGx5X3Jlc2lzdGFuY2VfdGVtcF90YWJsZSAq
dA0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChwb3dlcl9zdXBwbHlfdGVtcDJyZXNpc3Rf
c2ltcGxlKTsNCj4gICANCj4gK3N0cnVjdCBwb3dlcl9zdXBwbHlfbWFpbnRlbmFuY2VfY2hhcmdl
X3RhYmxlICoNCj4gK3Bvd2VyX3N1cHBseV9nZXRfbWFpbnRlbmFuY2VfY2hhcmdpbmdfc2V0dGlu
ZyhzdHJ1Y3QgcG93ZXJfc3VwcGx5X2JhdHRlcnlfaW5mbyAqaW5mbywNCj4gKwkJCQkJICAgICAg
aW50IGluZGV4KQ0KPiArew0KPiArCWlmIChpbmRleCA+PSBpbmZvLT5tYWludGVuYW5jZV9jaGFy
Z2Vfc2l6ZSkNCj4gKwkJcmV0dXJuIE5VTEw7DQo+ICsJcmV0dXJuICZpbmZvLT5tYWludGVuYW5j
ZV9jaGFyZ2VbaW5kZXhdOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwocG93ZXJfc3VwcGx5
X2dldF9tYWludGVuYW5jZV9jaGFyZ2luZ19zZXR0aW5nKTsNCj4gKw0KPiAgIC8qKg0KPiAgICAq
IHBvd2VyX3N1cHBseV9vY3YyY2FwX3NpbXBsZSgpIC0gZmluZCB0aGUgYmF0dGVyeSBjYXBhY2l0
eQ0KPiAgICAqIEB0YWJsZTogUG9pbnRlciB0byBiYXR0ZXJ5IE9DViBsb29rdXAgdGFibGUNCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcG93ZXJfc3VwcGx5LmggYi9pbmNsdWRlL2xpbnV4
L3Bvd2VyX3N1cHBseS5oDQo+IGluZGV4IGUyMTgwNDFjYzAwMC4uYjk5OGZjNGM4N2FlIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3Bvd2VyX3N1cHBseS5oDQo+ICsrKyBiL2luY2x1ZGUv
bGludXgvcG93ZXJfc3VwcGx5LmgNCj4gQEAgLTM0OCw2ICszNDgsNTIgQEAgc3RydWN0IHBvd2Vy
X3N1cHBseV9yZXNpc3RhbmNlX3RlbXBfdGFibGUgew0KPiAgIAlpbnQgcmVzaXN0YW5jZTsJLyog
aW50ZXJuYWwgcmVzaXN0YW5jZSBwZXJjZW50ICovDQo+ICAgfTsNCj4gICANCj4gKy8qKg0KPiAr
ICogc3RydWN0IHBvd2VyX3N1cHBseV9tYWludGVuYW5jZV9jaGFyZ2VfdGFibGUgLSBzZXR0aW5n
IGZvciBtYWludGVuYWNlIGNoYXJnaW5nDQo+ICsgKiBAY2hhcmdlX2N1cnJlbnRfbWF4X3VhOiBt
YWludGVuYW5jZSBjaGFyZ2luZyBjdXJyZW50IHRoYXQgaXMgdXNlZCB0byBrZWVwDQo+ICsgKiAg
IHRoZSBjaGFyZ2Ugb2YgdGhlIGJhdHRlcnkgZnVsbCBhcyBjdXJyZW50IGlzIGNvbnN1bWVkIGFm
dGVyIGZ1bGwgY2hhcmdpbmcuDQo+ICsgKiAgIFRoZSBjb3JyZXNwb25kaW5nIGNoYXJnZV92b2x0
YWdlX21heF91diBpcyB1c2VkIGFzIGEgc2FmZWd1YXJkOiB3aGVuIHdlDQo+ICsgKiAgIHJlYWNo
IHRoaXMgdm9sdGFnZSB0aGUgbWFpbnRlbmFuY2UgY2hhcmdpbmcgY3VycmVudCBpcyB0dXJuZWQg
b2ZmLiBJdCBpcw0KPiArICogICB0dXJuZWQgYmFjayBvbiBpZiB3ZSBmYWxsIGJlbG93IHRoaXMg
dm9sdGFnZS4NCj4gKyAqIEBjaGFyZ2Vfdm9sdGFnZV9tYXhfdXY6IG1haW50ZW5hbmNlIGNoYXJn
aW5nIHZvbHRhZ2UgdGhhdCBpcyB1c3VhbGx5IGEgYml0DQo+ICsgKiAgIGxvd2VyIHRoYW4gdGhl
IGNvbnN0YW50X2NoYXJnZV92b2x0YWdlX21heF91di4gV2UgY2FuIGFwcGx5IHRoaXMgc2V0dGlu
Z3MNCj4gKyAqICAgY2hhcmdlX2N1cnJlbnRfbWF4X3VhIHVudGlsIHdlIGdldCBiYWNrIHVwIHRv
IHRoaXMgdm9sdGFnZS4NCj4gKyAqIEBzYWZldHlfdGltZXJfbWludXRlczogbWFpbnRlbmFuY2Ug
Y2hhcmdpbmcgc2FmZXR5IHRpbWVyLCB3aXRoIGFuIGV4cGlyeQ0KPiArICogICB0aW1lIGluIG1p
bnV0ZXMuIFdlIHdpbGwgb25seSB1c2UgbWFpbnRlbmFuY2UgY2hhcmdpbmcgaW4gdGhpcyBzZXR0
aW5nDQo+ICsgKiAgIGZvciBhIGNlcnRhaW4gYW1vdW50IG9mIHRpbWUsIHRoZW4gd2Ugd2lsbCBm
aXJzdCBtb3ZlIHRvIHRoZSBuZXh0DQo+ICsgKiAgIG1haW50ZW5hbmNlIGNoYXJnZSBjdXJyZW50
IGFuZCB2b2x0YWdlIHBhaXIgaW4gcmVzcGVjdGl2ZSBhcnJheSBhbmQgd2FpdA0KPiArICogICBm
b3IgdGhlIG5leHQgc2FmZXR5IHRpbWVyIHRpbWVvdXQsIG9yLCBpZiB3ZSByZWFjaGVkIHRoZSBs
YXN0IG1haW50ZW5jYW5jZQ0KPiArICogICBjaGFyZ2luZyBzZXR0aW5nLCBkaXNhYmxlIGNoYXJn
aW5nIHVudGlsIHdlIHJlYWNoDQo+ICsgKiAgIGNoYXJnZV9yZXN0YXJ0X3ZvbHRhZ2VfdXYgYW5k
IHJlc3RhcnQgb3JkaW5hcnkgQ0MvQ1YgY2hhcmdpbmcgZnJvbSB0aGVyZS4NCj4gKyAqICAgVGhl
c2UgdGltZXJzIHNob3VsZCBiZSBjaG9zZW4gdG8gYWxpZ24gd2l0aCB0aGUgdHlwaWNhbCBkaXNj
aGFyZ2UgY3VydmUNCj4gKyAqICAgZm9yIHRoZSBiYXR0ZXJ5Lg0KPiArICoNCj4gKyAqIFdoZW4g
dGhlIG1haW4gQ0MvQ1YgY2hhcmdpbmcgaXMgY29tcGxldGUgdGhlIGJhdHRlcnkgY2FuIG9wdGlv
bmFsbHkgYmUNCj4gKyAqIG1haW50ZW5hbmNlIGNoYXJnZWQgYXQgdGhlIHZvbHRhZ2VzIGZyb20g
dGhpcyB0YWJsZTogYSB0YWJsZSBvZiBzZXR0aW5ncyBpcw0KPiArICogdHJhdmVyc2VkIHVzaW5n
IGEgc2xpZ2h0bHkgbG93ZXIgY3VycmVudCBhbmQgdm9sdGFnZSB0aGFuIHdoYXQgaXMgdXNlZCBm
b3INCj4gKyAqIENDL0NWIGNoYXJnaW5nLiBUaGUgbWFpbnRlbmFuY2UgY2hhcmdpbmcgd2lsbCBm
b3Igc2FmZXR5IHJlYXNvbnMgbm90IGdvIG9uDQo+ICsgKiBpbmRlZmluYXRlbHk6IHdlIGxvd2Vy
IHRoZSBjdXJyZW50IGFuZCB2b2x0YWdlIHdpdGggc3VjY2Vzc2l2ZSBtYWludGVuYW5jZQ0KPiAr
ICogc2V0dGluZ3MsIHRoZW4gZGlzYWJsZSBjaGFyZ2luZyBjb21wbGV0ZWx5IGFmdGVyIHdlIHJl
YWNoIHRoZSBsYXN0IG9uZSwNCj4gKyAqIGFuZCBhZnRlciB0aGF0IHdlIGRvIG5vdCByZXN0YXJ0
IGNoYXJnaW5nIHVudGlsIHdlIHJlYWNoDQo+ICsgKiBjaGFyZ2VfcmVzdGFydF92b2x0YWdlX3V2
IChzZWUgc3RydWN0IHBvd2VyX3N1cHBseV9iYXR0ZXJ5X2luZm8pIGFuZCByZXN0YXJ0DQo+ICsg
KiBvcmRpbmFyeSBDQy9DViBjaGFyZ2luZyBmcm9tIHRoZXJlLg0KPiArICoNCj4gKyAqIEFzIGFu
IGV4YW1wbGUsIGEgU2Ftc3VuZyBFQjQyNTE2MUxBIExpdGhpdW0tSW9uIGJhdHRlcnkgaXMgQ0Mv
Q1YgY2hhcmdlZA0KPiArICogYXQgOTAwbUEgdG8gNDM0MG1WLCB0aGVuIG1haW50ZW5hbmNlIGNo
YXJnZWQgYXQgNjAwbUEgYW5kIDQxNTBtViBmb3INCj4gKyAqIDYwIGhvdXJzLCB0aGVuIG1haW50
ZW5hbmNlIGNoYXJnZWQgYXQgNjAwbUEgYW5kIDQxMDBtViBmb3IgMjAwIGhvdXJzLg0KPiArICog
QWZ0ZXIgdGhpcyB0aGUgY2hhcmdlIGN5Y2xlIGlzIHJlc3RhcnRlZCB3YWl0aW5nIGZvcg0KPiAr
ICogY2hhcmdlX3Jlc3RhcnRfdm9sdGFnZV91di4NCj4gKyAqDQo+ICsgKiBGb3IgbW9zdCBtb2Jp
bGUgZWxlY3Ryb25pY3MgdGhpcyB0eXBlIG9mIG1haW50ZW5hbmNlIGNoYXJnaW5nIGlzIGVub3Vn
aCBmb3INCj4gKyAqIHRoZSB1c2VyIHRvIGRpc2Nvbm5lY3QgdGhlIGRldmljZSBhbmQgbWFrZSB1
c2Ugb2YgaXQgYmVmb3JlIGJvdGggbWFpbnRlbmFuY2UNCj4gKyAqIGNoYXJnaW5nIGN5Y2xlcyBh
cmUgY29tcGxldGUuDQoNCkkgZG8gbGlrZSB5b3VyIHdheSBvZiBhZGRpbmcgcHJvcGVyIGRvY3Vt
ZW50YXRpb24uDQoNCkZvbGxvd2luZyBpcyBub3QgZXhwZWN0ZWQgdG8gYmUgZG9uZSBmb3IgdGhp
cyBwYXRjaCBzZXJpZXMgLSBidXQgSSB0aGluayANCndlIHNob3VsZCB0cnkgdG8gZW5oYW5jZSB0
aGUgcG93ZXItc3VwcGx5IGNvcmUgdG8gcHJvdmlkZSBzb21lIG1vcmUgDQpmcmFtZXdvcmsgc3Vw
cG9ydC4gRm9yIGV4YW1wbGUgdGhpcyBtYWludGVuYW5jZSBjaGFyZ2luZyBjb3VsZCBiZSB0YWtl
biANCmNhcmUgb2YgYnkgdGhlIGNvcmUoPykgRWcsIGRyaXZlcnMgd291bGQgb25seSByZWdpc3Rl
ciB0aGUgY2FsbGJhY2tzIGZvciANCnNldHRpbmcgY2hhcmdpbmcgY3VycmVudHMvdm9sdGFnZXMg
LSBhbmQgcG90ZW50aWFsbHkgZXZlbnQgb2YgcmVxdWVzdGluZyANCnRoZSBtYWludGVuYW5jZSBj
aGFyZ2luZyAodW5sZXNzIGNvcmUgY291bGQgZGV0ZWN0IHRoaXMgZm9yIHRoZSBkcml2ZXJzKS4N
Cg0KSSB0aGluayBidW5jaCBvZiBkcml2ZXJzIGRvIHBvbGxpbmcgb3IgdGltZXJzIG9yIGF0IGxl
YXN0IElSUSBib3R0b20gDQpoYWx2ZXMgZm9yIGZ1ZWwtZ2F1Z2luZyBldGMuIEZvciBleGFtcGxl
IHRoZSBsYXN0IHNlcmllcyBmcm9tIEhhbnMgc2VlbXMgDQp0byBuZWVkIHBlcmlvZGljIGNvdWxv
bWIgY291bnRlciBwb2xsaW5nIGZvciBmdWVsLWdhdWdpbmcuIFBlcmhhcHMgd2UgDQpjb3VsZCB0
cnkgbW92aW5nIHRvIGRpcmVjdGlvbiBvZiBhZGRpbmcgc29tZSBjb21tb24gImxvb3AgDQppbXBs
ZW1lbnRhdGlvbiIgdG8gdGhlIGNvcmUgLSBhbmQgYWxsb3cgZHJpdmVycyBqdXN0IHJlZ2lzdGVy
IHJlcXVpcmVkIA0KY2FsbGJhY2tzPyBJIGJlbGlldmUgd2UgY291bGQgc2ltcGxpZnkgbWFueSBv
ZiB0aGUgZHJpdmVycy4NCg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNCi0tIA0KVGhlIExpbnV4IEtl
cm5lbCBndXkgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4
IGRldmljZSBkcml2ZXJzDQpST0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmlo
YXJqdW5sZW5ra2kgMUUNCjkwMjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRo
ZSB5ZWFyIG9mIGEgc2lnbmF0dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
