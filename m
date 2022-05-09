Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56051FE52
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiEINbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 09:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiEINbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 09:31:21 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2121.outbound.protection.outlook.com [40.107.135.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D451C7428
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 06:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1QBf7FcjbPuDtsOoksjaPTwNCXSNP3oMrzeyt4mirhhJxT2mNq5IU1vl9/FaT8WUZdOCp5DpG4wkV8yZfs5fGhWjPhmzx2V111V2YS6DPehQ5L5enfsNxJz/+PggE6F6B9k/dup7SZKP75NN8QvvEeUWPgOvAARWV6O2zbD6YiJiGtJRFFFcfSiWqaXfKBvm361W0eYsg5GUO1oOIGiBJ8nBKjkC75+dGRUZaWpeqLn4PBNbWp/RWFjkwwCrCwh+dB0Btxc/cJ33p0ODb48WXNziody43K4VLuASROAptLigJw7uBTkOlednhUrrdnYhOtHn+ziDjSVNBaDWypW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXUgVFwbU5cudxBZ6ldfNlH6b44dfthNUKT4ROrEeLA=;
 b=LRSjwMiKo3WibRoI1fILK/3HlPAgzzKjUhEo194FvAdOUf9XccqrNmad5JjkJFPpVK9Hhl7geVRIoUV/3oXAQV/kZ0SVa+hy1T0CGO1ih/F564XZmG4i0pgTxxuko/T+JUWeHLJvJzzpBelwDUBx3W7K3l0XHv6QqE/LRYEsJN2uu4OEPnsVD24xaCBTYumaW4+cbQIUqLNzoQ0teOO3AFxT0825fjx0HL2rkWv2uYt5opcz2NOGZdewIQud8yRMiTiteinOV1Ehmaife2uABehyz6d2llVwOqZUqzgla19gefRjt1jNEtT4mYSGkUyOT77mzul1wopvLmjPcwg5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXUgVFwbU5cudxBZ6ldfNlH6b44dfthNUKT4ROrEeLA=;
 b=KnUmwP3uWyk31kV8w0AP8jHuTtZwkYSPoR9l/9sCK0OEwTRl+fNynXinuqvON5akVI1j47XFfL/yfcqsrFJ9f1W2nRH9j6ci3y51F+0bF63TlqC4c/S+tyZuctrjBgkZwgwJlnJKmfeiHe40kgmgVPQk6y827s1gYT8fo3yun1E=
Received: from FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:54::13)
 by BE1P281MB1490.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.12; Mon, 9 May
 2022 13:27:23 +0000
Received: from FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
 ([fe80::75e6:c45a:af7:b789]) by FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
 ([fe80::75e6:c45a:af7:b789%7]) with mapi id 15.20.5250.012; Mon, 9 May 2022
 13:27:23 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] power: supply: ab8500: Respect
 charge_restart_voltage_uv
Thread-Topic: [PATCH 1/2] power: supply: ab8500: Respect
 charge_restart_voltage_uv
Thread-Index: AQHYUQjSMGx+kNOuikmK8OrupSCxJKz28xsAgBnlBYCAAJzVgIAFCVkAgAAwqIA=
Date:   Mon, 9 May 2022 13:27:23 +0000
Message-ID: <03b3878e-7dcc-95d9-12df-ed4435a14b36@fi.rohmeurope.com>
References: <20220415203638.361074-1-linus.walleij@linaro.org>
 <a1ad97a5-4048-1f8e-272b-6d1e99bd20cf@fi.rohmeurope.com>
 <CACRpkdYCWYgUAUJVVKy0jU4yF=d95e0Ead=coeMaA=uD3WV35Q@mail.gmail.com>
 <0442f454-9fba-8901-ca97-90538df439cb@fi.rohmeurope.com>
 <CACRpkdZfadK1vrCwOzUYOt5BjZP3SVhzd5-tyfA1s_QoekLkvw@mail.gmail.com>
In-Reply-To: <CACRpkdZfadK1vrCwOzUYOt5BjZP3SVhzd5-tyfA1s_QoekLkvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11c41d2e-738e-4349-e0cd-08da31bfa705
x-ms-traffictypediagnostic: BE1P281MB1490:EE_
x-microsoft-antispam-prvs: <BE1P281MB14906259194D20B8F0AFB9A9ADC69@BE1P281MB1490.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SHLgjHYv670a1gS1ulevQZ2ssFh7DN1BusZQh0adioZoTEZAU6GstTbI2cxGwcSjagGK9XeNq+Iz2dskF8ABEvHT7HDdV1mg7mIr1s9K4Sq53u2NZNR6VC7YPFM98y84JtgNE4HK8E/SMhH0pU2KFmrOyOPUqu93bUbI+hH+3dbL0d7EkCnyRFETV4xNGi0oT5aRRK1sEYCB3ZuzBCmrAvu+3Nh+BP4kMfX7/mkNa3ttTji80M6V9K3UuLhn/Zn+srTVPulL9e28q3ZHYjscCv1Upq5XOElFxigUd4Td10ixGiyh1KxW9/2kmPPYllAJSJlbBPGf7FiYSE+T5ObYUJRhf/8S/PeQRQ2pw+LXcA9W3Zg4pw1SMJoORujbNjpgIxwMSmL2kVCG4eHZYz2BkLCEcs5tRUXZVbyG2edfSP2+J10dfFtxQlG0sOIUrs9HH8vQgEdPbRs8eX/YLPidKHAmFC4izKH7Nhpje4apSP23x43+KDgfbS6ObhcKFDf1P21LnYjouH2LatwCWiN4cEUJi1mZSDz6bqfGxqGoszjnNQou7IfR932zikUcmXrqjiGEJ05nGcUiBShfr/W+X5baksHp8ShKgOoZqeX2H1x1fcNPCPPDEKQUL0VctAmDRXTXGoCHjp4bM1mFfR0YLMSUN3CS7Ird+tu8jCdfXHnNHHqayW8E/ETlChKdA76DVulFMggvPpOlcaTZHxeSYos9erhPQofwjZ5s2zDiITq5TGuLt/hGh1dZXVH/p03noUACmSYr+0NZtsGQE+jQYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(6486002)(2616005)(86362001)(38070700005)(8936002)(6916009)(83380400001)(54906003)(6512007)(71200400001)(508600001)(53546011)(6506007)(122000001)(316002)(2906002)(31696002)(66476007)(64756008)(8676002)(66946007)(66446008)(66556008)(76116006)(4326008)(31686004)(4744005)(5660300002)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEZMQ3MwZk1lVUQxenF2clVUakNDZ3hKckhXek9SWUVTdy9lT25xNkJvMWw5?=
 =?utf-8?B?NmIvN1JTb2RhN3VTWU1UZE5lTFNjcFdlbjhBRmtwTzVteDN0QThySGNDSUZp?=
 =?utf-8?B?SVlrZDI0VmZhTmJ5M09YZDl5QjdGUDl5c3EvZVF1aGZZZHZEcVhaNm9NRyto?=
 =?utf-8?B?Mmh1ZTZzU3YwWWtOT3dYRVFpM1ZFZGZaZVVlRU5jYTJQdEhGMUl0Ujg4UW1N?=
 =?utf-8?B?Q2wvRCtONVlObWtaS2d0bVlXYit4TFBuNWIzM0lZK3B5Q090WjNuK3JRMGVK?=
 =?utf-8?B?bEhOdXU1NFhPQU85RCtyT0s0ZE1MTEhMdWQ1eGFOaHJwR2htbEtqYU1YSEZw?=
 =?utf-8?B?NnM2enpoTTlZNTJyR2t4Rll6VjEyM2hWTFZTYTcyTGhPMXE4eXVramR2QVFn?=
 =?utf-8?B?VERqcDBrbXJhUEx3ZGVFZkJHQlVBNk9Mbm15NDR5VHh1MlB0d1cvRVJscmRk?=
 =?utf-8?B?WkNOaC9za3NvWXhuVG56Z2RQL1BodGw2SzJmVXhOUGM4VW80Y0g4Q05uNmtI?=
 =?utf-8?B?ZVIzWnpIQUgvRll3RC9WUnB0amhWZEUrK0JySWNoYnJQM1FlNThtSHFnQXUz?=
 =?utf-8?B?SHhNOFArQjgvSEduTitVZEpOWmZuZzlvRk04cHF2Uk16MnBnUjhiZmp6UDNB?=
 =?utf-8?B?NHRyR2pZZTM4czJIRjYyWlNOODB2ZmZVeUVIRSt5VGlqMmN3V0I2NnZBYlIr?=
 =?utf-8?B?T2RGaXlzK1htWmFBZ0ZnSUVFWWd6SU9lZUdvSjVpcHprQ3NrSXIwVUMyMEhX?=
 =?utf-8?B?WlN0Z2Vhb1lIZmlRNVZHdXIvY2hnTGFucS9YZkFNdU5FdVRHUnQ2aFp2V1Jo?=
 =?utf-8?B?bk02bkZhZmVwWWg1c3dLd2lQRktjdXpjWDR0ZkJOaGlGYlpWV04yUWlXUlFC?=
 =?utf-8?B?T0VuSEdqeGx6ckxJTXpNUVdySWtDQzd6aUdubUIrZzE1ZHBVaWk5VTFHRXRy?=
 =?utf-8?B?U1NHZnBUdEZLQ01BeXRNOTA1VUFsb2RRdlorcTJucHRRYVQ1ak5hTnlBSk5R?=
 =?utf-8?B?UGVrTUY3NmdUVyt6ZjlZWHBkc0MyckpUTWtQNXY2SW5tWUtqbi9lemlzSTBz?=
 =?utf-8?B?NEhybjhrOFVxZE9RRWU2bStKWkxTQXBnTktmTEdHNXZLMUpITWp6TnNCSEt1?=
 =?utf-8?B?K2c0VWc5YUtPc0RJZ2Rod2NmcFhUY2wzQVgrZ0hMN1M4cFA0SS9KaVVYMHZl?=
 =?utf-8?B?ZU05UHExZHZVbzl3Um5ZR08rcnJCVjh4T0laK3gxWVFaK1oyaXVMdlh1VUhr?=
 =?utf-8?B?OVJPby9JNnJPdzNsWjlqVUhDWG1qS1VBMmUrT04veURvUnJSZmJsaFhnUEIr?=
 =?utf-8?B?TlFUbXd4NHVsUFVRcGRtUFc2V0l3Y3VPOFNvWjNONG1KNnB3d0ZJcmFBMksv?=
 =?utf-8?B?QXVpNjdWUXRqb0l0MmpGUmNmZkZOOXhvK3NCNHZYTHNrRFE0aUtwbzhXT1Qy?=
 =?utf-8?B?cjRrem9Yc3JIc1FybzczaDdsbFJYM29jSEdPUWE5bktPTXM1VFVXWk1iZW9z?=
 =?utf-8?B?Wm41OUw0NUZxMWU4Q1hZSHhSOG9jTjNMQ05HYWRDNnE1eHFrMTdQYm05RnJE?=
 =?utf-8?B?Z3VWV08xUUFDNGhER3p6a28wdVBHYW5zWUJ4aEJhdEpuQVRDQ09tNTkvWUc4?=
 =?utf-8?B?Y1hCc3RwTU5NbnRLTUU5L09VaHhya0tZcGtFbVNIcDM2SkQ2SFdGK3Bxd0Iz?=
 =?utf-8?B?RlI1TmhNa3hxMTNydEdrNzAzRjFhMVUzNjVJN280b3NJNkNGSlFsb1NyMWo2?=
 =?utf-8?B?a2JndVkxYXJPT0YyYVpnSzc1aXdDV3NXNG5reGh1c1hSU2pPcXZLY2RTdGw4?=
 =?utf-8?B?SjhTWTJPVkdzZC9Ca3h3eU40SVM3MmlvK3ZMVXl0TFVkVEpLbkFYUUlzbXBa?=
 =?utf-8?B?YkE2YmtDQW93VVpHY2FlWE1tNGZEZTRkb1Uyc3I5QlNzNnoySzRqV1JUdkwx?=
 =?utf-8?B?WktBKzhqbUk3VXg5MHlwMWpHcmo2ZEh3Um9sVFN0ODVUQVdOaDRJcW1jRGpo?=
 =?utf-8?B?MTRKU3BCRHZNdWg4elpoVHBzdEU4ZFZneG5kbWN6U1J5V2VlSkdUek16QTIw?=
 =?utf-8?B?TGRsc0EyY2hLUXk4NklTd2k5SjFzWW9pRlBES2RVaG11SmcrcnYvTVVmeGE4?=
 =?utf-8?B?aTdBVlcwNjNVc0ZVYWFxVmVMbVZ3TkhRSXdkSUpjTzhDQ3dNVWpldk50OVJa?=
 =?utf-8?B?Q1Bqa2NhUTdjYURocGdKWnZEc1ZKbFpSRGdHSkl3WVZLWlZoenRoMndEN2ZO?=
 =?utf-8?B?THo5ZzluSmM0STlHazhQcWxJenUxaFEyRWJEV2lFRDhmMWdhZ0lpWmdLK2tX?=
 =?utf-8?B?bVNDM0dOTmFMdlZOUWtCcFJaSzVrV0hjRVA4YVBmcVJGTGMxN0pvNitsVHJa?=
 =?utf-8?Q?AUAQG/Y5RhAcpxrCNwgsdeA2oMVfAeWH6H/TTrZUfjB4k?=
x-ms-exchange-antispam-messagedata-1: 854EWcS1OglajA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DA68CA30F784A49AB5D4394BFCBF696@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB0865.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c41d2e-738e-4349-e0cd-08da31bfa705
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 13:27:23.6728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0eQ2bsFXmt2Ur4fYq+M23XIzzHSofM6FRaKMYyZqKbhg0ShpNl/yst8Md8f+isvTVAblaQOVkqQ3MCfKQq1MywRsw/JP1MZ2+Rs5krFRh3ZC79LWAICSSYGXbtGSPPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1490
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gNS85LzIyIDEzOjMzLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiBPbiBGcmksIE1heSA2LCAy
MDIyIGF0IDc6MzggQU0gVmFpdHRpbmVuLCBNYXR0aQ0KPiA8TWF0dGkuVmFpdHRpbmVuQGZpLnJv
aG1ldXJvcGUuY29tPiB3cm90ZToNCj4gDQo+PiBJIGFtIHBlcmZlY3RseSBoYXBweSB3aXRoIHRo
ZSBwYXRjaA0KPj4gdGhlbi4gQWxzbywgcmVhbGx5IGhhcHB5IGZvciByZWNlaXZpbmcgdGhlIGV4
cGxhbmF0aW9uLiBUaGFua3MhOl0NCj4gDQo+IEkgcmVjb3JkIHRoYXQgYXMgYW4gQWNrZWQtYnks
IE9LPw0KPiANCg0KU3VyZSEgQW5kIHNvcnJ5IQ0KDQpJIHdvdWxkIGhhdmUgYWRkZWQgaXQgZXhw
bGljaXRseSBidXQgSSB3YXMgdW5kZXIgaW1wcmVzc2lvbiBJIGFscmVhZHkgDQpzYWlkIHRoYXQg
SSBhbSBPayB3aXRoIHRoZSBwYXRjaCB3aGVuIG15IGRvdWJ0IGlzIHBvaW50ZWQgd3JvbmcuIEl0
IA0KYXBwZWFycyBJIHNhaWQgdGhhdCBmb3IgdGhlIG90aGVyIHBhdGNoIG9ubHkuDQoNCkJlc3Qg
UmVnYXJkcw0KCS0tIE1hdHRpDQoNCi0tIA0KVGhlIExpbnV4IEtlcm5lbCBndXkgYXQgUk9ITSBT
ZW1pY29uZHVjdG9ycw0KDQpNYXR0aSBWYWl0dGluZW4sIExpbnV4IGRldmljZSBkcml2ZXJzDQpS
T0hNIFNlbWljb25kdWN0b3JzLCBGaW5sYW5kIFNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkw
MjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn4gdGhpcyB5ZWFyIGlzIHRoZSB5ZWFyIG9mIGEgc2lnbmF0
dXJlIHdyaXRlcnMgYmxvY2sgfn4NCg==
