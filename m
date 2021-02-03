Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF38A30D23A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 04:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhBCDug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 22:50:36 -0500
Received: from mail-eopbgr60136.outbound.protection.outlook.com ([40.107.6.136]:64590
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230388AbhBCDug (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Feb 2021 22:50:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpfnYVjeiXGHTvPajFzjWkqyZQEpLII6PNfMuDlqe1R7cdUvAXi7XZSOHCx3n31Y7KlBHBb9OAgUKLiP3m7MBuZIY1i4hbFwygx9cV/rv3xPyOia1ZV7bXCqAD8Hj7pzhpOAd28dAai+glF70WcrIgya3z35JYisvkxIKLCVNsc0rWImAkaZHnHBSqGpIIJWzu9WC460dVcD4UMdl6dNyrK+aky8ZumObcmkCB3t8UHce8Ev6Qx62rQP3W4oIOkqUiuGx0y4wB247E+ac3+cHpaMssKCEix6VRH2d4whEYJgaPFxpAkOIiB8xwBJH/JnnZbxnzmuKTyg+fLWKYsKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGLbF06rBKqbFofJPNkszFGV1A/zmZjAOYOwXICdIH8=;
 b=ZQeFoe7cUKOV/Dw77Bt++mK9Sgafh4VVzF1XAADcHZ6bg0cTBEczsrUJFgOoT/uHS4eWHmhQCyF9a5TxMtpQaYH2LArYAvRUIBcdJot9yowZ0xhhPPkf7cK8I6DZ21+2+3zlwUBLp4i/kH11e5ilKgOrNXeQBlqqN2UUpxgSFeiZQbFioknvX9ED3QbvoUb7GrFpaeT3KGBILeNt8XoI/2Lcgs4gWQbpTA6Y3nawWRQya3vkSKJYB+s+qrGnQmnB9DrAeo/q6UIBny32qEXr3fZV9cweGTDP7KgdE5v3WlZG5n0iUbDC7u6ZC4HqX43faM+fSPOGyifDBMbUr6wauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGLbF06rBKqbFofJPNkszFGV1A/zmZjAOYOwXICdIH8=;
 b=IySmUg87u6rSrTeecHzZ3VtAx9yyP1jRmGy7A/0kD0Xwq1Ds3uH07XiPQtOWTifr1nxVFW5rl4ancCR1uDTJd7rANwFnNVpYq3widaUljVY8BTRDKapKt42J9kGmmRPblsVGHTG81PfRVuBhCQeVicb3Dz5dfqObqbFpCVPEIkc=
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com (2603:10a6:10:70::20)
 by DB6PR0601MB2103.eurprd06.prod.outlook.com (2603:10a6:4:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 03:49:43 +0000
Received: from DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee]) by DB7PR06MB4571.eurprd06.prod.outlook.com
 ([fe80::dcab:24bb:617a:30ee%3]) with mapi id 15.20.3805.022; Wed, 3 Feb 2021
 03:49:43 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "sre@kernel.org" <sre@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: RE: [PATCH V2 2/2] dt-bindings: power: bq27xxx: add bq78z10
Thread-Topic: [PATCH V2 2/2] dt-bindings: power: bq27xxx: add bq78z10
Thread-Index: AQHW+UBMREP8PfryIEW2DZfkjWv43qpEk2mAgAEVwAA=
Date:   Wed, 3 Feb 2021 03:49:43 +0000
Message-ID: <DB7PR06MB4571B2E6829B961C151F3D61D7B49@DB7PR06MB4571.eurprd06.prod.outlook.com>
References: <20210202084858.2944-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210202084858.2944-3-Qing-wu.Li@leica-geosystems.com.cn>
 <20210202090823.rgah5hxoegsueu54@kozik-lap>
In-Reply-To: <20210202090823.rgah5hxoegsueu54@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=leica-geosystems.com.cn;
x-originating-ip: [140.207.15.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ffbab65-7b69-4fde-59c1-08d8c7f6be0d
x-ms-traffictypediagnostic: DB6PR0601MB2103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0601MB21036D91B3FF31DC5D3D53AFD7B49@DB6PR0601MB2103.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFxSXPa84L3BDuDTpjQGR2n2rC04wbjRAm4ADlV1O3OaZBJcBKMItUw/SRzo20Qb3/24aIO9xsJisYAsfV5zTV3FA1z4NlmZOPQ3Nl5eZ1rogDWvM2/B7GwSAkjl33ojtr8S0HLGA+0od3vBd7odTX9rIU+GgguBG2+OUBwGPMVJLC2e++Zx8LszSpwcuBWyp9xa7OuBKTa13ih9NmRVQlKgjE+ewGmrqCVDDY+7wiuZWSfkoPZV0b6ubgUw9h/qowPV6PCVNy3IAqp/cC2MmwM+iYWQbyMxkiEp0OCdDvSDX+UXaO+L4WTmfGW35apBSmeO1PAGW1EY03OebIthG4UhkTK9zeLEYj3DQdNlHPR+6ncHCiznYM/sRJTPAtNYt+fnTIqSIPzkdjNXv0FGfzN2f+2cU/OZqzkNdSJaQHBmClcPR6LvfONuIqMsVxmeiUy5PgokpVUjOOcCSw0c3xUQ8xW9YhMJLkvUGCXqgi0e8KwVRZGz5rLtcdVHJzs5YBAHJC4HHjYi31F9oNpfpC5MzAZAdPe3LyNs+3doXN/Tw+81+e8BecVoJ78SBY3Z+WHPJl/CN86ovesq+4sU6CAarC5DYMJeAkjkScPa0olTEameD1aGg6Qx4/Cva3lTar9RlFeWYJV19Jz9RZfAOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR06MB4571.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(8676002)(15974865002)(76116006)(26005)(71200400001)(107886003)(52536014)(53546011)(54906003)(2906002)(6506007)(45080400002)(83380400001)(7696005)(478600001)(4326008)(186003)(6916009)(316002)(86362001)(5660300002)(8936002)(66476007)(33656002)(64756008)(9686003)(66946007)(66556008)(66446008)(55016002)(138113003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UVcrdXRqWTJka0dSWVd3NG9HbEYvdmlLQjh6YnRXZGMxMXhDTWRFTEFEY0Qr?=
 =?utf-8?B?ZFBtbFJSWHluWE1KdjFEUlBjZm4wWmhnSE4ySExQeEtsZ2ZvL1hSM1ZaaXZ3?=
 =?utf-8?B?TmQ1azU0dHhHZUpIdlZoZDNvTFlqWlJXMCtvWVZxVWhyOWhNR3YrUUVQR3VF?=
 =?utf-8?B?QVlmUFNBSzByZllHYWx4M29VMmd3QXcrSlJkSmZnWU5xTFQ1anNZbVRMeXNO?=
 =?utf-8?B?cU1DOHhHMTBaMlBBSDk5U1paV3I3T3lGbVhWTUxOUC9hdWJQZVp1Ylg5TWUw?=
 =?utf-8?B?MHNlR056NlBhU2JlbU15S2EzYVI3UmVpb1VualBYUDFTbVVVMlJ3cG9lT0Vm?=
 =?utf-8?B?b25VWXNGZ29LaDNaU0d2cmZzUkQyK2NTNGlBVUhLQ0dDeEVMbFRMbXFCOXE0?=
 =?utf-8?B?enpPMElTSy9ZM1ludzJuSms1VE5DdUlTdHoxR3NpbHBvWk9HZ3BGS2NMUkQ0?=
 =?utf-8?B?Qll5a3VKbGh0K00ySWlNak42dC82QlpYK0xkSmFyYWZObkVGOUxkZUhXNEkz?=
 =?utf-8?B?RjNmNytOcDFGSW1uUU9vL2VKU24ra3R1ajFLdDJGbkx3bEJ5YXpqbDZocXZB?=
 =?utf-8?B?MXRrdU51OU9EeERYWWl2VkZFd1Vmb2F4dmdvQlhlSWtmT0JNNURuTVVJbDg3?=
 =?utf-8?B?MGhNWWhCdUdPOWJIcEYrVWxUaFJyekhteGxEWHhTa0dHQzBTcWg1NWVmNFZ5?=
 =?utf-8?B?Y1lRUFJEVVdxZ3NMQWhiOS9oYUFiOUlQQ0kwK1pFZlczcFJTMUgvVEtkbU5j?=
 =?utf-8?B?OURnYTFsc3VmdGpmV2hKT3NKT1VCamh5V0UyaEFXdmhWUXRjcy9PWXVSNEU2?=
 =?utf-8?B?UmhnWmk3TEYwbldyY3pOYm9qS25CMTRJWjduWFl4WmliWm45QXBURjA4TnU1?=
 =?utf-8?B?YlMxKzFaeXpKeWh4VklvN3dkaGpPVHVrbGFnYzdNN3JjbTV4YXQvQ05memNo?=
 =?utf-8?B?VDJCM1htV1pJa2ZMcXBieVQyYlBsbmt6QXJndW16MzhPQUlxbmxIb1R1MEI1?=
 =?utf-8?B?Z3Z6MnZjSmdqUmV1K1pCdm02K2l0Z2NGWDkyczRXdjg2U2dRQmd6MER4SkxK?=
 =?utf-8?B?S3MweEo5VEpVak82cHBWNzdjZVQ0bjlBdTRzbkpOQSs2Undzd2JGWmdZanpT?=
 =?utf-8?B?cXFzNTJpb2tSNEM1NXBJVUhJSm9Md2hvSjZLOVdYSVQ0bUhidUVSVmROb2xy?=
 =?utf-8?B?R21Gc0RUN3kvT2NxaEdGSjUyQ2daVVZQZkJDdmNUVm02QUVSYnd1TUJNb2g4?=
 =?utf-8?B?NkVELzZxNVYrZGlMMzJnSnhYTU5LNXBaQVZTL3FqUVZ6MHYwblpMUEg2MTNy?=
 =?utf-8?B?NU9sN2VwWk40dTJvNXExR2VQbUwvbHJxbDRnd0ZmSm9QN3hvb1R3UzEyS3E5?=
 =?utf-8?B?amVDTHJQaXExZmJUOHRRNE0weVB5cUFIS1FXbEJIZnEvNG9mMytmUWY3aVBI?=
 =?utf-8?Q?ZSMy8Rq8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR06MB4571.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffbab65-7b69-4fde-59c1-08d8c7f6be0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 03:49:43.6353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnaPLlRD1bAAqOKox85fGky8sVcVX2WAVtJ3+v/CwS8PQUy7kDAC2+ZeYwHeZ9LDjQ9lNLHpzZHZDH52PGpqeqDvuuRPO65QDhbQdZNLJe6tHJEK8MnLl3elHtdvVNhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2103
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciBpbnB1dCENCg0KTm8gY29t
bWEgYmVmb3JlICJhbmQiLiAgCT4+IEkgd2lsbCBkZWxldGUgaW4gVjMNCg0KV2hhdCBkb2VzIGl0
IG1lYW4gYXV0aGVudGljYXRpb24/IAk+PiBUaGUgZ2FzIGdhdWdlIGFibGUgdG8gaGFzIGEgc2Vj
dXJpdHkga2V5IHRvIHNlYWwgYW5kIHVuc2VhbCBhY2Nlc3MsIHRvIHByb3RlY3QgdGhlIGRlc2ln
biBkYXRhLCBsaWtlIGRlc2lnbiBlbmVyZ3kgYW5kIGNhcGFjaXR5Lg0KDQpJbiB0aGUgZnV0dXJl
LCBwbGVhc2Ugc2VuZCB0aGUgYmluZGluZ3MgYXMgZmlyc3QgcGF0Y2guIFRoZSBjaGVja3BhdGNo
IHNob3VsZCBwb2ludCB0aGlzIC0gZGlkIHlvdSBydW4gaXQ/ICA+PnllcywgSSBydW4gdGhlIGNo
ZWNrcGF0Y2gsIEkgd2lsbCByZW9yZGVyIGluIFYzLg0KDQoNCg0KDQpCZXN0IFJlZ2FyZHMNCg0K
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KTGkgUWluZ3d1
IChUZXJyeSkNClNlbmlvciBFbWJlZGRlZCBTb2Z0d2FyZSBFbmdpbmVlciANCkxlaWNhIEdlb3N5
c3RlbXMoU2hhbmdoYWkpQ28uLExpbWl0ZWQNCihUZWwpOiArODYgMjEgNjEwNjEwMzYNCihGQVgp
OiArODYgMjEgNjEwNjEwMDgNCihNb2JpbGUpOiArODYgMTg3IDAxODUgOTYwMA0KRS1tYWlsOiBR
aW5nLXd1LkxpQGxlaWNhLWdlb3N5c3RlbXMuY29tLmNuDQpIdHRwOiB3d3cubGVpY2EtZ2Vvc3lz
dGVtcy5jb20uY24NCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4gDQpTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyLCAyMDIxIDU6
MDggUE0NClRvOiBMSSBRaW5nd3UgPHFpbmctd3UubGlAbGVpY2EtZ2Vvc3lzdGVtcy5jb20uY24+
DQpDYzogc3JlQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgZG11cnBoeUB0aS5jb207
IHBhbGlAa2VybmVsLm9yZzsgYWZkQHRpLmNvbTsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
VEVSVFlDSE5ZSSBHcnlnb3JpaSA8Z3J5Z29yaWkudGVydHljaG55aUBsZWljYS1nZW9zeXN0ZW1z
LmNvbT47IFpISVpISUtJTiBBbmRyZXkgPGFuZHJleS56aGl6aGlraW5AbGVpY2EtZ2Vvc3lzdGVt
cy5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBi
cTI3eHh4OiBhZGQgYnE3OHoxMA0KDQpUaGlzIGVtYWlsIGlzIG5vdCBmcm9tIEhleGFnb27igJlz
IE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJlZnVsIHdoaWxlIGNsaWNraW5nIGxp
bmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWluZyB0byB0aGlzIGVtYWlsLg0KDQoN
Ck9uIFR1ZSwgRmViIDAyLCAyMDIxIGF0IDA4OjQ4OjU4QU0gKzAwMDAsIExJIFFpbmd3dSB3cm90
ZToNCj4gQWRkIGJpbmRpbmdzIGZvciBUSSBCUTc4WjEwMC4gQW4gSTJDIGludGVyZmFjZSBnYXMg
Z2F1Z2UuDQo+IEl0IHByb3ZpZGVzIGEgZnVsbHkgaW50ZWdyYXRlZCBzYWZldHkgcHJvdGVjdGlv
biwgYW5kIGF1dGhlbnRpY2F0aW9uIA0KPiBmb3IgMSB0byAyLXNlcmllcyBjZWxsIExpLUlvbiBh
bmQNCg0KTm8gY29tbWEgYmVmb3JlICJhbmQiLg0KDQpXaGF0IGRvZXMgaXQgbWVhbiBhdXRoZW50
aWNhdGlvbj8NCg0KSW4gdGhlIGZ1dHVyZSwgcGxlYXNlIHNlbmQgdGhlIGJpbmRpbmdzIGFzIGZp
cnN0IHBhdGNoLiBUaGUgY2hlY2twYXRjaCBzaG91bGQgcG9pbnQgdGhpcyAtIGRpZCB5b3UgcnVu
IGl0Pw0KDQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg0KDQo+IExpLVBvbHltZXIgYmF0dGVy
eSBwYWNrcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTEkgUWluZ3d1IDxRaW5nLXd1LkxpQGxlaWNh
LWdlb3N5c3RlbXMuY29tLmNuPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wb3dlci9zdXBwbHkvYnEyN3h4eC55YW1sIHwgMSArDQo=
