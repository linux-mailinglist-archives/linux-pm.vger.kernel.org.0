Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98598306A9A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 02:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhA1Bnw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 20:43:52 -0500
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:34017
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231177AbhA1BnS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 20:43:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfSzhX/Sc4r2848QwMqkasZ7xbU+P5h6FVPsc7M6UxXox95wAm+bZT2ZMteunkSDvdldI/W1AVGASrApbpZ3nOi2SN2pNj1VK/wZqflqmRjJUxKrju7bprP9p3cY/fGa6Q7M1r3K8XsrpQMOB2SzzuyCEk+DHdmG0A4hjCcdGDX91AEE+tT7eO2XP9b7iUQoCwtUgGeuKgJ3lUyjAY6F3egV8oiSkV/Y3qJ3fHMfQO+m+THQu/IDFSGkVT6Hll6HHr3bwUrV8Io4wkmglAoZFOudWITWrD52xTFkYerOckJeinfBGqIrCz8pPm+9cGOY6uMKkSySIbGeLUPYj4vL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbJ1jNKuCGawce0+XAA/nvHnCwJmcQffp68YQnIVYms=;
 b=C68a3p1BB7cB32mEptVAALeOz+ePayvpxmDntpFS2KIKu7Av09kPO+wuT+4F1/mkMWTZluwn7/XupUQFr3uFqfDkWU5/3kfNAAl3ESUheFnjGWPVWeLDlwkCnW0CC18dUZh3PJJehRPi4mf7+ciVAqLAVBGLfEM1PStcIlEHu/Ekqs/8myekc4s8bp55aghno9a/GIsfgIowihzykjJL1sNT0uGeGmP+8DvKPjh8wr+pcE9rnwy5w4yWWjwe8NG2nk0M35KRL1hz8kC1Yx5Cid2giXysaEXdcr40qtYSGGl7Hi7HA0HsYrnJWT1a9bFne6dH3EWkhtAOkZI8T0nMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbJ1jNKuCGawce0+XAA/nvHnCwJmcQffp68YQnIVYms=;
 b=NP6JBFEBiqNs7ODI6tWrSQqOT0cCJzG7ceYR+1ksdzuMc9AKxSxiPE9abo5ZwUSW0CR0qgGAj97yqe+V71hHWn1fj1zZrgRchszfpWuT0MqyqWcZTLNE3SoqMzS+8doJI99kZNJ6yDjaghtfHCHYabNlXMCxD4BXlxnB9JVR+S0=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4354.namprd11.prod.outlook.com (2603:10b6:a03:1cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 28 Jan
 2021 01:42:28 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 01:42:28 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBQTTogcmVtb3ZlIFBGX1dRX1dPUktFUiBtYXNr?=
Thread-Topic: [PATCH] PM: remove PF_WQ_WORKER mask
Thread-Index: AQHW8s6id2HiVZdI2kGFxo0iWoaVzKo7y2mAgAB7Z6Y=
Date:   Thu, 28 Jan 2021 01:42:28 +0000
Message-ID: <BYAPR11MB2632E0A742A67B72536BF844FFBA9@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20210125041828.20965-1-qiang.zhang@windriver.com>,<CAJZ5v0j-JxkPPdbUMiG3oqRs7O-35a0G2ryEHHKy-PagczizGA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-JxkPPdbUMiG3oqRs7O-35a0G2ryEHHKy-PagczizGA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5a53ee1-320e-4714-690c-08d8c32df86f
x-ms-traffictypediagnostic: BY5PR11MB4354:
x-microsoft-antispam-prvs: <BY5PR11MB435408E80941B90D5E2BC4F1FFBA9@BY5PR11MB4354.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wp0KTyeqsc6TYJz7k8eX0BR7IBp3f3Hkj8Fl8uHwLFFd5xCcYaedtC2zfh6aUCX5cAFaPUyiyDsE5tkKG7ZcPwwoopzyhGdMTQjepAAuzfiwLVkhoJVb6/TqmxfrDjxg7K+fdQwBJxPA0+oXA25KcbW6DvYjcTzMZzX2hgSXm1mbFcCdKRYO56QCf6luBwujU2FmvaK8/t5HMBCekloASs68pbV9IfrdURXecmGq9AJA/0WSNSGWFqiR99afn5l8/D7xusD7e14cBseWg2jveJJzW27sdRg6n7BkLvzqUGD1JNs3OsXcQy2KirEverARNLEJtvCnRMKeV1U2ANqHHmA4QBeEOd5qZcuzjOMcteJXKHADKVqx1oxgtXZ8G8rqPhfunNN2sV2X+tCV0PPODl4kSII4TIaEKB8l/CVMLUluIXa9ha6F1YQrjOO4IR+KoF4idlvqmAXOGMSlGHFvzFr4uD7jqZHUjqtVDyIbnek/elU6z6kKZWCq1LnGhALr1hgwLrmhFQODL3krGCX2tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(376002)(136003)(366004)(6916009)(66946007)(7696005)(8936002)(71200400001)(9686003)(86362001)(54906003)(91956017)(64756008)(66446008)(76116006)(6506007)(5660300002)(478600001)(33656002)(55016002)(26005)(4326008)(224303003)(186003)(66556008)(83380400001)(316002)(66476007)(52536014)(53546011)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?VFM4QnZWdXZFRzhBNlpFODFiWGovd2hzb2RaOFF0ZUFOOWJnZm41VGZHbzVu?=
 =?gb2312?B?TDBKOUVhb1hhSUFxaEdGdkNtVEtmUzZneWdDbUFCbi9SMVRKRGhWeGpHQVlO?=
 =?gb2312?B?Qk41SUVzVUF1ZXNZS3lteTd0Ym54Wm91YzEreVNvRytZZ0wxTk8vYmZIMmI1?=
 =?gb2312?B?djFkN0pXK1QyeStDSHVCYzg2alRwcE9JZGFpeFhBL1BsaythdVlSbXhiYUZ2?=
 =?gb2312?B?UDNHbkVYeENweGdQeXFPUm1acDUzemhhUlZLSEpLYXhFWkhEVHpTUDNJcTY0?=
 =?gb2312?B?cGNBaUNEQkRQQ2dWeWJhWVYybWxEUk9KQjZScGp3aHQwNllOUXBteWdoMG9B?=
 =?gb2312?B?NzNTNFU0TWkzRmw0aHNlQWwvVFpBSTJvM1dXZWtVbERKWHh5MUtGSVhaRjlK?=
 =?gb2312?B?VDUwNG4yTDhDZjI0TE9aUHhnTUdCNUNGTkRmTEtHaFNMbmFwbTV4ZWNxSU9W?=
 =?gb2312?B?TXA1dDZTei8yUk1wSjB6dHlFNE5IMnVXWERqQ0tyT0RQUEErcHVyOHBSNU9B?=
 =?gb2312?B?eXoraGJHUnZMMTBJbU5yREhtdUZTVFJkVnZZQk82VXc4TFREZm9NQnJoOUly?=
 =?gb2312?B?SWRWWVp4d3lqelhycnZsbkFZTUE3L003UHRvbVZhZzNJNmVubE9pZDFUaDJl?=
 =?gb2312?B?alZtUE5Gamo1TTQ1RG5SOFg0UnJ4WlUxcEtMY0Y2bGk4dGpxYXYzQVNDY1BB?=
 =?gb2312?B?UHJyZk5nNzc1c0llQWZIcXpQYU1LTmpEcDJkc25hK3JQbVRKUG9IdkJDNHpR?=
 =?gb2312?B?dGtBVjREVW4xWVVTRmZWN2xqWnRFM2FLWXlRUzUySVJQM3pQeFFUdGN1T1FT?=
 =?gb2312?B?V3grYmJSWHQ1TTRNUmU3S1BUZERUUy9xckRDRHVUblpDS2lodFdreXZzbFdZ?=
 =?gb2312?B?NGlMdXorM1dXSzlHZmdiNFE0enVaTnNyeVlUNHR1cHVZTWhqSmdEeFp1dWVU?=
 =?gb2312?B?S3I2WEprV0l4U2NNTEtsN29pWnJNYXNvWEZyOWZISmo2NmVpUmp2MVNqNGd5?=
 =?gb2312?B?WjNoZS9BK2VSYVpKYXBZL2kyUllZVnV3MjUxSkpGMEJtWi9LSDNtU0RSNU1m?=
 =?gb2312?B?cm9uZ2F0T3dDWnd3TUlXZm04azhmeHBDcHNHU2t0NlpuTm96Tm91THRiSGZJ?=
 =?gb2312?B?ejBQNXVvSjlobUJRR2E3U0VXNkVXdlBmeWlNMUo1MEpobnRLOE8yYTJXeDNi?=
 =?gb2312?B?M3NQU0JwcStVUmtzanB2THc5bGFjS2NITjlGWTQyTHBNL1VtTjlxZzV4THZW?=
 =?gb2312?B?eDd0NzcwZDc3bGVHYnp0K2tVUFMxRmF1d2xQNS9pR3p2R2krV2JLVys0dzlH?=
 =?gb2312?B?eHZMVis4eFdDaG5TQzRjTysyUitDdWpFdWtYUFhYbmJyRDNJcUV5bXhobkIw?=
 =?gb2312?Q?iz13822HDebyryPvoWbm2Fr+vnbppK50=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a53ee1-320e-4714-690c-08d8c32df86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 01:42:28.0341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ynl0zvmdS4EpthxhTBwyIJk+T3xZPUX+mpNkbIFAJiYXflug6HUcG44Pi7+RGM3C+DVUi2aE8xSWqnt5jCUCWD9XfEXkquWfetbaS5VnA+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4354
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUmFmYWVs
IEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPgq3osvNyrG85DogMjAyMcTqMdTCMjjI1SAy
OjE2CsrVvP7IyzogWmhhbmcsIFFpYW5nCrOty806IFJhZmFlbCBXeXNvY2tpOyBMaW51eCBQTTsg
TGludXggS2VybmVsIE1haWxpbmcgTGlzdArW98ziOiBSZTogW1BBVENIXSBQTTogcmVtb3ZlIFBG
X1dRX1dPUktFUiBtYXNrCgpbUGxlYXNlIG5vdGU6IFRoaXMgZS1tYWlsIGlzIGZyb20gYW4gRVhU
RVJOQUwgZS1tYWlsIGFkZHJlc3NdCgpPbiBNb24sIEphbiAyNSwgMjAyMSBhdCA1OjAxIEFNIDxx
aWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPiB3cm90ZToKPgo+IEZyb206IFpxaWFuZyA8cWlhbmcu
emhhbmdAd2luZHJpdmVyLmNvbT4KPgo+IER1ZSB0byBrd29ya2VyIGFsc28gaXMga2VybmVsIHRo
cmVhZCwgaXQncyBhbHJlYWR5IGluY2x1ZGVkCj4gUEZfS1RIUkVBRCBtYXNrLCBzbyByZW1vdmUg
UEZfV1FfV09SS0VSIG1hc2suCgo+U28geW91IGFyZSBzYXlpbmcgdGhhdCBhbGwgdGhyZWFkcyBo
YXZpbmcgUEZfV1FfV09SS0VSIHNldCBtdXN0IGFsc28KPmhhdmUgUEZfS1RIUkVBRCBzZXQsIHJp
Z2h0PwoKICB5ZXMKICAjZGVmaW5lIFBGX0tUSFJFQUQgICAgICAgICAgICAgIDB4MDAyMDAwMDAK
ICAjZGVmaW5lIFBGX1dRX1dPUktFUiAgICAgICAgICAweDAwMDAwMDIwCiAgSSB0cmFjaW5nIGt3
b2tlcidzIHRhc2stPmZsYWdzIGFzIGZvbGxvd3M6CiAgY29tbSBrd29ya2VyLzE6MCwgY3B1IDEs
IHRhc2stPmZsYWdzIDB4NDIwODA2MCwgZGVsYXllZCAzLCBmdW5jIGludGVsX2ZiY193b3JrX2Zu
CgpUaGFua3MKUWlhbmcKCj5UaGF0IHNvdW5kcyBjb3JyZWN0LCBzbyBJJ20gZ29pbmcgdG8gcmV3
cml0ZSB0aGUgY2hhbmdlbG9nIGFuZCBhcHBseQo+dGhlIHBhdGNoIGFzIDUuMTIgbWF0ZXJpYWws
IHRoYW5rcyEKCj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIu
Y29tPgo+IC0tLQo+ICBrZXJuZWwvcG93ZXIvcHJvY2Vzcy5jIHwgMiArLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9rZXJu
ZWwvcG93ZXIvcHJvY2Vzcy5jIGIva2VybmVsL3Bvd2VyL3Byb2Nlc3MuYwo+IGluZGV4IDQ1YjA1
NGI3YjVlYy4uNTBjYzYzNTM0NDg2IDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9wb3dlci9wcm9jZXNz
LmMKPiArKysgYi9rZXJuZWwvcG93ZXIvcHJvY2Vzcy5jCj4gQEAgLTIzNSw3ICsyMzUsNyBAQCB2
b2lkIHRoYXdfa2VybmVsX3RocmVhZHModm9pZCkKPgo+ICAgICAgICAgcmVhZF9sb2NrKCZ0YXNr
bGlzdF9sb2NrKTsKPiAgICAgICAgIGZvcl9lYWNoX3Byb2Nlc3NfdGhyZWFkKGcsIHApIHsKPiAt
ICAgICAgICAgICAgICAgaWYgKHAtPmZsYWdzICYgKFBGX0tUSFJFQUQgfCBQRl9XUV9XT1JLRVIp
KQo+ICsgICAgICAgICAgICAgICBpZiAocC0+ZmxhZ3MgJiBQRl9LVEhSRUFEKQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIF9fdGhhd190YXNrKHApOwo+ICAgICAgICAgfQo+ICAgICAgICAgcmVh
ZF91bmxvY2soJnRhc2tsaXN0X2xvY2spOwo+IC0tCj4gMi4xNy4xCj4K
