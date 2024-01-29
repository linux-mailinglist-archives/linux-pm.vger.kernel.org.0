Return-Path: <linux-pm+bounces-2853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E9840014
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 09:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE3C1C21DEF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66A537ED;
	Mon, 29 Jan 2024 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PQkLgjxN"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3BE53E07;
	Mon, 29 Jan 2024 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516993; cv=fail; b=MYZOlyP6XsEXbfrPW19Vn3jgpLHtXH+73pM2MnQf8DgeiQuFrdlGkslWMmdqK2MfDMViuvqMQ4Zv1+M1gV42OtVSHOKdghj8VkU4fi1VffRl65YPNlZQlEAIqVuD4FL5LU1IhpMVPj8+Ee2VBRxF1h9prbx/MgClm2qn7PRj5HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516993; c=relaxed/simple;
	bh=/+JvgUmL0juX3WbXNrG/lnO59GexQZw96WgPAXOF9J4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MW7j4xMO+Rg6mBr9lnX3ECA4i3PLvH3xyqEcNxjLGqcqJ4WvdLmaRwCFctvDmo6uSHGsK6ttgKqKA6cp99LWCwBFbTCKt8adVfikGU5rxHrFPypSBlc2ZRcvNBWoGs0BB95Tsj/01I9DQRWPnYx3S/Sv3kzYdx8PTunZOpoUWCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PQkLgjxN; arc=fail smtp.client-ip=40.107.114.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gogjDsltdJWybt2mb62kLodTrT/s5Z20GZfIGVO4xN+3CyS7Zl2kqk7QesZn0NV4PFJ9cn2ZqCJ9cVvsS7rb08/ubkkDBHEMdGmxLEaqQA9wcAsHDjemMqIL2vVCSXqtRICM2Rs/dW8JMK2G3QX1XWoLx92bdcdJlEXDqsIGk+lc6iv10VSVB2N5tAQce4tlbJl6dEGavlvVmRMWErmr0Bcgoxy5hgxEh0HmTXkMmwwfVuojT3NXrUgoPSdjTIdo72JQZL3mD3Aiun2rDSoz6IkkecEZRb3lOBi2z4LNlJ5PyZo0Gql0F9iYdYkO5WD7gwLVF0DWwxwSRktmEM5yCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+JvgUmL0juX3WbXNrG/lnO59GexQZw96WgPAXOF9J4=;
 b=QP/0hftkdK9JTIorr22N9RbEHO6oXygJveTQqQwuFFrUCZJ/QiFCnvxshRb/xSu2U6Q1U5wlB7Em7quVBgIMc1aUmObmh9rN/QK7bpfKfUc3rlwQ5/+rxd8rxHWJm/DqzpWuwshf+yPTcHsGrdHLAMWWDY5niowXiRZaHVPgPg8NkaociKa1s4+aC9FzKNGBMffKyox8qCQ+Itk6pIHpmjoA+1FyJQBlOPhADYANtcqfOgEBxRw14bqCjN2VCjwHtCINE7cMLVGRS/3jDpv8e3R351IJcKOzuXiCLbQ5yxU4dhm9FaqP5/X9lGlFFVMAZ4fqUSglezpZss6++/JIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+JvgUmL0juX3WbXNrG/lnO59GexQZw96WgPAXOF9J4=;
 b=PQkLgjxNqO2fh+JwDFm/Q61AUExFSP/7IXUN+MONFT+r5SZo2x5/fSYbIcfNasnOWqgTiOrDkcLp1j0sTDi+YJU3ag63fQYfg+TWo5TX/4CgWfIRy4RS+iod0yH2mMlkwrUZC7N431c1hqPUberUPt8rLl7JABaZGoRpxqbmUyc=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB10116.jpnprd01.prod.outlook.com
 (2603:1096:400:1ec::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.19; Mon, 29 Jan
 2024 08:29:46 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7249.017; Mon, 29 Jan 2024
 08:29:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lee Jones <lee@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Support Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Steve Twiss
	<stwiss.opensource@diasemi.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Topic: [PATCH v6 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Index: AQHaLmTZZmVT0psB8keMNtPm4cmnmbCz04OAgAAE+gCAPOHi4A==
Date: Mon, 29 Jan 2024 08:29:46 +0000
Message-ID:
 <TYCPR01MB1126921A54B9260CC33505FCA867E2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231214080911.23359-1-biju.das.jz@bp.renesas.com>
 <170316812973.586675.6248412029985031979.b4-ty@kernel.org>
 <20231221143318.GH10102@google.com>
In-Reply-To: <20231221143318.GH10102@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB10116:EE_
x-ms-office365-filtering-correlation-id: 4a11c383-45d9-4ae0-7ad5-08dc20a473aa
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vUjVH/dNlJOwTn81uievgTht6+CS6dxhaz23ljXvwd9k2eC927yEEgX0F7hFj37TUCUjHg8ArYcSY+Fg7ABjCbqMW3IegxQJZTzyeFw6rEhp9yHDfuPtbsMX4BxDciCv9DRu9FCxcDBX3lZ5cE/A0I1zL58M3TWa1R7HhmiurIgdnUPvok15QWWbtQihodCOYBGCZ7ddxysBtPEWVR+Ky7uGgB2ytjWFMaFqJe/EgK+S0MAMVQtJkV0v13lmZ3LX15vfTDfSDbbb4aemQ9oK1pxO4koOo6iCgDPBEifQrpWFtKs9MHd+l+0/4IOXXwHJdGytxXhmtm1+63gOJ25nIQVIzQEEg5l4FRXrrWyRp3vlYXESSTSfTi9Ya8io5VYXdSOmdwJ8Pq06ZbDMW4Uod9co8Lh+H8te0O+ikf2/pptTHNaZ4Eh77CkjEpeqCANgdawscRCwgGag1bnY7fOcet2sm3CMfLLvJ0cHFs/pyUkILcF3jLg31PRuHyFMFXCWdqHfKiQCFBzWhchcRwX/F6HZ2Ko0/P7rO2NdWO0fd6bz+Lvv/X3qYijMQFQLGD/uTTwZ97tO9OlezQKbX1awsXhQyd3L6fEiNqgOIyoRR529f2QjGbRQDqdnYvQ358nD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(83380400001)(26005)(7696005)(6506007)(53546011)(33656002)(86362001)(38070700009)(7416002)(5660300002)(52536014)(41300700001)(4326008)(8936002)(8676002)(9686003)(38100700002)(122000001)(66556008)(66446008)(76116006)(66946007)(66476007)(110136005)(64756008)(54906003)(71200400001)(2906002)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WngzemdRTHkzYkQxZXRITmt6RHJUa0tFN0kvZ0lrRFhwZXlnVFVMcWdnTFlO?=
 =?utf-8?B?dkgxVVZFeWJCUXFzUm9qSzMzS3R0SDhxZTVzVFJpeW1qUmRjUHIrL0QwM2xv?=
 =?utf-8?B?b0FUNWNYekxVL050WEg1Y0ZhSG9YelAzZTZmcWZZQmI5cjdUamxjdXZBOWFC?=
 =?utf-8?B?NDFCU1V6dGUySFl3VjJtZVVmUkt6NFJyeXp5ZFlidVNxNnQ5YVAzL0NLRk94?=
 =?utf-8?B?dmoxaWtnK2tCWGJwUTZROFM0RHdVMy8wMWEzQkx4SzVvR1RVT29LZGluRXYz?=
 =?utf-8?B?cHNPLzR3NkN6dTVLZjlwenljKzZFWmNWNzFqa0RTRkNGMXUvZXBoYVh1WVFW?=
 =?utf-8?B?ZEswR2JEeHYwaEFyS1drWW5qU2RsM3V1dXdNbEhrejdWTGdpckhjeklOZVhv?=
 =?utf-8?B?Z1VtcVloUzAxNEdBVHlkZUxrSUVZMnV2NUtsYXNrNS9Ed1M4eGZzVVM1a0s5?=
 =?utf-8?B?V3Y0cUZKY1JGV0J6WkMvQWRXeHVNQlViTUdzK21EUElGRzVVNnM0R1lRQkly?=
 =?utf-8?B?VGZXdC91WTg5R2kzZEM4ZFd5Q2tKbEF4bDJxSXNOZDZLNklpUXZPb2R0cE5l?=
 =?utf-8?B?OVdGQmJ6Z294dDlXcW1FUUprbnhtSitvdlNkQ290L2JtN2dsTWpGK1pMTEFJ?=
 =?utf-8?B?U29lV1NUajdRcUNYTkhCWlhpK2pNcUc5R3RBUkNBbUJTRWY3MG9kWEhRY2ZI?=
 =?utf-8?B?aW91U2Uwek1kV2haM0FYMUhtWkFVSmUrZ3JGVm93cFJsdll4Z3k0bm9rNExX?=
 =?utf-8?B?SHhBMUZMRzFzcks1Yk5COUxNM1hzTkFrajV6Wnl5NTAxc2kvejFiSllxRG1N?=
 =?utf-8?B?dXNseU5OMXRJblZmVHlmbUNsOG4zUGNqU0NHaWVpQmlMWWw4NlVxNGRYeXlK?=
 =?utf-8?B?QjZ1SDZuRjJUdHdwaGJ0cFpXMEFjcXdPSUFVeXdTOUxGWWxKbFBIVG9Wb1Rx?=
 =?utf-8?B?Y3M2TkxNM2NWMnFNQnRLUVYyU1hpd2hwQk5jL2pLMjV4VGd4VFc5THptRUd1?=
 =?utf-8?B?cDBXa2d6dWRQSE9ZbllXVS9JMnlQeE9vSXlxOGwyZkk4NGdVVzRvOFlkajZ0?=
 =?utf-8?B?Z0hsK29qeFVKL1hQeHp4czdjMnRjMk9iTHBFL3RNcUxRcm1uWThiZkFGalFO?=
 =?utf-8?B?VUgzYURLUmlNMitLeTN4Z0tnOTEzY2xMVVUvcHdGbUozVk16LzBlL1IyL2VK?=
 =?utf-8?B?ZDVqL1FZRVAzMTNYYU85ZElmVWdaMkEwbHozcG9LNTZvR0V6R3RRUlVoOGp1?=
 =?utf-8?B?Tld3Q2xNRUh5b1pLNHZJMG9xRndVNW16T25ISFUwLzQ4R1B4Ylg2UHZOTHRt?=
 =?utf-8?B?bUk0UU9sN2Ywd0ROTVRzcStRL1lDcytFZzdPZndaVVFoVW9vSHoxN1pHZ0x0?=
 =?utf-8?B?U1pzRmM1NER6Wm5ueGhGd2pabXJRcjN6bU1GTlBFR2JCR3FvcDBCNXl0OE0w?=
 =?utf-8?B?dERiSktpWkNOaXZlcjFTbmlzeUlZaUloZFppMmt6d0NYS0dNZGpYZEZKZmoy?=
 =?utf-8?B?cStST1RJNzFFclNxRHdGUW1zSjZOazhhR3ovdDNXWStnSXc2bC9hb251Vy95?=
 =?utf-8?B?RDlFa1RibmtHbkhqTHE5VlhBd0xxSlRDb1I1NnVqeHlOWVN5bW1sV2FtcG9T?=
 =?utf-8?B?NjJ2YkY1eWFXakEyWWlPc2crbkZkYU9EaVZrN2NWNUVMdXQ1Z0krVTloc05t?=
 =?utf-8?B?OHNFOVlLM0EzbThPcXhwZk95MXhsZkxhSTd4VzNHM2RLVVF5OFF0dzA0dXN2?=
 =?utf-8?B?MnNDWXpYeU9mWkFmOGpQaG1iZVJBTy9JR0RMSGg0NmVmTDc2M05rZWZNdk4z?=
 =?utf-8?B?bnVQWVpuQVM4TENTQUFVblZBMDJpWTNGU01lSi9oNmszTGQ0YmJZMDNPc2Mw?=
 =?utf-8?B?cjlWZHM3dTlCWlpENmczOEpaNXI4WnVHZEFHdkNmaHNwSzIrMEZLeTEySDdj?=
 =?utf-8?B?QjhWWkVhMkVrdzhaUDkwVWROdFlOMUozYkwwWGFFUm9VSEFwM3IranZlaCtO?=
 =?utf-8?B?K1NsSG5FQ0FmbWdWcmRmZk1RKzdSakpsWTZFZ2k2VzllWGtNd1JLSW1FS0Zq?=
 =?utf-8?B?U0RpR05mNnJhVmZJeHZpaFgyZityYURWS3NQMW1OVHg0ME9KNHpzQWVDRDJh?=
 =?utf-8?B?UmR6cU1YTHhXMVpIYktiWmZKQjYrVnA5Y0lIcENSYXE4aGd4emlOL05TbFlo?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a11c383-45d9-4ae0-7ad5-08dc20a473aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:29:46.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/t1qKm224d+rLv+qby4PY2NApVbVA++2Da1WxdOVRcC8tdr3tcEcWdHPtgOFEd4N3qmvHfttQUVFkLNBMBaddW0AZSyuVN/h8MgHNRX/J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10116

SGkgTGVlIEpvbmVzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExl
ZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAyMSwg
MjAyMyAyOjMzIFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMC84XSBDb252ZXJ0IERBOTA2
ezEsMn0gYmluZGluZ3MgdG8ganNvbi1zY2hlbWENCj4gDQo+IE9uIFRodSwgMjEgRGVjIDIwMjMs
IExlZSBKb25lcyB3cm90ZToNCj4gDQo+ID4gT24gVGh1LCAxNCBEZWMgMjAyMyAwODowOTowMyAr
MDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gPiBDb252ZXJ0IHRoZSBiZWxvdyBiaW5kaW5ncyB0
byBqc29uLXNjaGVtYQ0KPiA+ID4gMSkgREE5MDZ7MSwyfSBtZmQgYmluZGluZ3MNCj4gPiA+IDIp
IERBOTA2ezEsMiwzfSBvbmtleSBiaW5kaW5ncw0KPiA+ID4gMykgREE5MDZ7MSwyLDN9IHRoZXJt
YWwgYmluZGluZ3MNCj4gPiA+DQo+ID4gPiBBbHNvIGFkZCBmYWxsYmFjayBmb3IgREE5MDYxIHdh
dGNoZG9nIGRldmljZSBhbmQgZG9jdW1lbnQNCj4gPiA+IERBOTA2MyB3YXRjaGRvZyBkZXZpY2Uu
DQo+ID4gPg0KPiA+ID4gWy4uLl0NCj4gPg0KPiA+IEFwcGxpZWQsIHRoYW5rcyENCj4gPg0KPiA+
IFsxLzhdIGR0LWJpbmRpbmdzOiBtZmQ6IGRhOTA2MjogVXBkYXRlIHdhdGNoZG9nIGRlc2NyaXB0
aW9uDQo+ID4gICAgICAgY29tbWl0OiA5ZTdiMTNiODA1YmNiZTUzMzVjMjkzNmQ0YzdlYTAzMjNh
YzY5YTgxDQo+ID4gWzIvOF0gZHQtYmluZGluZ3M6IHdhdGNoZG9nOiBkbGcsZGE5MDYyLXdhdGNo
ZG9nOiBBZGQgZmFsbGJhY2sgZm9yDQo+IERBOTA2MSB3YXRjaGRvZw0KPiA+ICAgICAgIGNvbW1p
dDogMjhkMzRkYjc3NzJmMTg0OTBiNTIzMjhmMDRhM2JmNjllZDUzOTBkMg0KPiA+IFszLzhdIGR0
LWJpbmRpbmdzOiB3YXRjaGRvZzogZGxnLGRhOTA2Mi13YXRjaGRvZzogRG9jdW1lbnQgREE5MDYz
DQo+IHdhdGNoZG9nDQo+ID4gICAgICAgY29tbWl0OiBkMmE3ZGJiODA4ODcwYzE3Y2ZmYTI3NDll
YTg3N2Y2MWYyOThkMDk4DQo+ID4gWzQvOF0gZHQtYmluZGluZ3M6IG1mZDogZGxnLGRhOTA2Mzog
VXBkYXRlIHdhdGNoZG9nIGNoaWxkIG5vZGUNCj4gPiAgICAgICBjb21taXQ6IGQ0MDE4NTQ3YTE1
YTk0YzdlODY1YjJjZWY4MmJmZjFjZDQzYTMyYjMNCj4gPiBbNS84XSBkdC1iaW5kaW5nczogaW5w
dXQ6IENvbnZlcnQgZGE5MDZ7MSwyLDN9IG9ua2V5IHRvIGpzb24tc2NoZW1hDQo+ID4gICAgICAg
Y29tbWl0OiBkYjQ1OWQzZGE3YmI5YzM3Y2I4Njg5N2M3YjMyMWE0OWY4ZTQwOTY4DQo+ID4gWzYv
OF0gZHQtYmluZGluZ3M6IHRoZXJtYWw6IENvbnZlcnQgZGE5MDZ7MSwyfSB0aGVybWFsIHRvIGpz
b24tc2NoZW1hDQo+ID4gICAgICAgY29tbWl0OiA5OThmNDk5Yzg0M2UzNjBiY2Q5ZWUxZmU5YWRk
YzNiNWQzMmYxMjM0DQo+ID4gWzcvOF0gZHQtYmluZGluZ3M6IG1mZDogZGxnLGRhOTA2MzogU29y
dCBjaGlsZCBkZXZpY2VzDQo+ID4gICAgICAgY29tbWl0OiAyYmJmOWQyYThlM2JjOTMzNzAzZGZk
YTg3Y2FjOTUzYmVkNDU4NDk2DQo+ID4gWzgvOF0gZHQtYmluZGluZ3M6IG1mZDogZGxnLGRhOTA2
MzogQ29udmVydCBkYTkwNjIgdG8ganNvbi1zY2hlbWENCj4gPiAgICAgICBjb21taXQ6IDUyMjIy
NTE2MTgzMGY2YTkzZjJhYWFiZGE5OTIyNmMxZmZkZGM4YzQNCj4gDQo+IFN1Ym1pdHRlZCBmb3Ig
dGVzdGluZy4gIFB1bGwtcmVxdWVzdCB0byBmb2xsb3cuDQoNClRoZSBjb21taXQgZGM4MDVlYTA1
OGMwZSAoIk1BSU5UQUlORVJTOiByZWN0aWZ5IGVudHJ5IGZvciBESUFMT0cgU0VNSUNPTkRVQ1RP
UiBEUklWRVJTIikNCmluIG1haW5saW5lIHdpbGwgZ2l2ZSBhIGNvbmZsaWN0IGZvciBwYXRjaCMx
Lg0KDQpQYXRjaCMyIGFuZCBwYXRjaCMzIGFyZSBhbHJlYWR5IGluIG1haW5saW5lLg0KDQoNClBs
ZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd2FudCBtZSB0byByZWJhc2UgYW5kIHJlc2VuZCB0aGUg
cGF0Y2ggc2VyaWVzDQoNCk9yIA0KDQp5b3Ugd2lsbCB0YWtlIGNhcmUgdGhlIE1BSU5UQUlORVJT
IGNvbmZsaWN0IHdoaWxlIGFwcGx5aW5nLg0KDQpDaGVlcnMsDQpCaWp1DQo=

