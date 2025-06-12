Return-Path: <linux-pm+bounces-28518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F92AD651A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 03:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8865D17606C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 01:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696EE135A53;
	Thu, 12 Jun 2025 01:27:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5572613;
	Thu, 12 Jun 2025 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691636; cv=fail; b=EqRUkDfUR71eyd7WnO2EjVaRVmN7U76JYRI9LHDkJDLyMmLozlx3fioiliptRqVQMP1DAKRE0nBnWfCYlSQ92IaK/14p8jUDq/6QnPsJXHfkVDslJ5oYCTKxPS77URJAnGTRjtv261dSLYoiIXT7S1TsWxNa70+tnRUnOx1Ajvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691636; c=relaxed/simple;
	bh=c8pvgE3v8aI/eCvcneiU/QzCzZ2LarIoE8YbhUHmUic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qfIcK/gjRLUcQqe5CA7AwMJcm1zOOAIOZF2bG0taRRHutYXzpiKb2Zgh/Bq+yW3ChP+MlQ1mOF06171GkxnjeTSUDlgu0/QxEyaZNzB8FJ65Zex1vLyab2j89mnjoHCrMzQXuEqk+uy1Ya9xmAGbb+zCQETK3/gcaLzFfv0l5nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ26Lg0kosfM4yEQc/FQOT8bXJeHKdxK8aXFnkn0rBlZl2yuet0VQPi/bnQC++pT1mpphVLMb1dlRydaxPNWcULeh3KO6C2BZfJmWLuv8or41Lm9YXvG8EnKmJ9F+CnAsjDkJJ61FzV3lyMk2VLMMDeaW3IRsTD3f08O7ev+O22cZgEXgdijd+Nxu9hkhcccsnpUEkQhT5+J+d+1R50tJWRz4k319nguSdZrkGQ5bPwKMgrumYXXRUOXHxCWVDqiNDjD0SwmI6xv+Xqoe6VBTdiBH0t4fbWdImQoBVAvDPhwvYIGzre4UxFzoPcJ+GZcLnfjkcgKcNLbqvg1sQxmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8pvgE3v8aI/eCvcneiU/QzCzZ2LarIoE8YbhUHmUic=;
 b=EeyYGtf0q3sdyJrGKIOUda58YvVR2i9D6spBa2Ee751EG0Fbw0e3Od7pCtmkGjtTRiCKZ118MpuFuf2ga6FQoB5tdlim/hvNpBk6unSs59s9hnZD+X9xUJVCFD3TDrMJSGGQXlDIxyfN8sIiuoZ7osBSYPMSmVx/bNHYpBQz1V1wXuS8yuKPmtEr/27oIAxii+Sk0jDxf850WeqyaLyPie30RSE0KNy5I5ZhzZ0EtBovvb+WcdqfL2d0h2FOGpTyIQWvQMDZuhX7Up/RJ0LOO9kYgV63FJVJM0agFpnSThWgKG0x2SOjVjdwzWTXtVDcge7aAycEBPlIDi3gHFR23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1303.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Thu, 12 Jun
 2025 01:12:05 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%7])
 with mapi id 15.20.8792.038; Thu, 12 Jun 2025 01:12:05 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: "shao.mingyin@zte.com.cn" <shao.mingyin@zte.com.cn>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "geert+renesas@glider.be" <geert+renesas@glider.be>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, "heiko@sntech.de"
	<heiko@sntech.de>, "krzk@kernel.org" <krzk@kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, Walker Chen
	<walker.chen@starfivetech.com>, "sebastian.reichel@collabora.com"
	<sebastian.reichel@collabora.com>, "detlev.casanova@collabora.com"
	<detlev.casanova@collabora.com>, "finley.xiao@rock-chips.com"
	<finley.xiao@rock-chips.com>, "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>, "pgwipeout@gmail.com" <pgwipeout@gmail.com>,
	"qiu.yutan@zte.com.cn" <qiu.yutan@zte.com.cn>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, "yang.yang29@zte.com.cn"
	<yang.yang29@zte.com.cn>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
	"yang.tao172@zte.com.cn" <yang.tao172@zte.com.cn>, "ye.xingchen@zte.com.cn"
	<ye.xingchen@zte.com.cn>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIHBtZG9tYWluOiBVc2Ugc3RyX2VuYWJsZV9k?=
 =?utf-8?Q?isable-like_helpers?=
Thread-Topic: [PATCH v2] pmdomain: Use str_enable_disable-like helpers
Thread-Index: AQHb2fuaxaFW95Sx/USP9qxGCvTQ0LP+uXyA
Date: Thu, 12 Jun 2025 01:12:05 +0000
Message-ID:
 <ZQ0PR01MB130266C8DC79B041567E2262F2742@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20250610193403161UQCV5cVGXCRVDheTb7jvi@zte.com.cn>
In-Reply-To: <20250610193403161UQCV5cVGXCRVDheTb7jvi@zte.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1303:EE_
x-ms-office365-filtering-correlation-id: c245bb18-bb2f-4714-a066-08dda94e2573
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|41320700013|38070700018;
x-microsoft-antispam-message-info:
 LM29ALdgyzJjhKL9iC5l3yRNObMy8isMzLF/5cnyMplXSrVBfYU1l2MItq7LQAhCoP5AcSlP0f+4U/21dEYx14hzeWiBsGLPH9S8OaBPzLkbJ/ty2FbGKGUDMu+EtkgO8wdtIxSb/TVezcbNaOdPHTb3zyZ5BSz19JFKLu8grY2Rm3QnEk4gwZ8wr9+ZVUlDVinR8njXomcIUgDCB4qlt+V71zjv01I+gLZMaAhgyEjAI0ByG/qrqEZTagGi3Ff3Alr5T1Wc4d/ZdQ1ByKcb4JgNTmvIfO1CTXdM4G7M8cSikuYc7UpSQCUZkLw9juTLlS8c/FuiNX4H9NbE8EgAsvpEbANNY20n+/v1PJrH+dmNup4ikVoEmBNacCngto91CPnTZJ8feQccndNWE8bV/pDA8C6I5Xfy7l3JdvXBUAWqFFsUO4OyaLIeY1J10EwsEJy1eaJbveT8eD0mMqtTlyqrj5yeYE8R+9xpdSIqin52ZCyPAv4eMNMtxJmz/UcH89Sm42F9klFNybuP4f+Axk1pO7OSlkbwEIjyHs829CtFVR2CMhCNws0mrM4i6qwuCc/8LfPBeNnX6DtkG7ddzmaTq5UtH3jtF7nGQ60jPYs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlIrNnAwbDBZdGIvOFFFdGxIQUt4VkhNVy9qN3V6bkFPYis2T3lUcnI0N01O?=
 =?utf-8?B?cnJLWnZna1QxRmttV05xbGNNeUQ0SDdodXp0ZUsvbEpYR0ZVOWtjUmpEQ0Zw?=
 =?utf-8?B?aDVuck1HS2ZPbUJrUllxMzFQMi9EOGRpZ0xiTmUwMmlIenk5VmdUYWpKekpj?=
 =?utf-8?B?N01UOWVqM25LSForRmptZHZsQWVlWFVVOHZSdjhoVmtBVUFLcnZOQ1YrVlNk?=
 =?utf-8?B?cU5qSmJHLzR0WFhVU3RBSEFCenNrcHdQNm82d0ZBUkluemp3NVlHZUJEMENa?=
 =?utf-8?B?NnhJYjFab1dlbmdRNytZVW9TMXZJOHduTFBVbjZXQ0prdUM0TlQ3NUFtRndU?=
 =?utf-8?B?L01CVWNXWjhIOGlLbDlWdG9SMFVBRnBRZUk2U0tyYm55ek1Nc2ZEc1RwSTNI?=
 =?utf-8?B?angvZTRBUTBheXFyMFEyRTdLTkIxc0ZsYVpPbXV5R0FyTmVGbVVpdytlUFpo?=
 =?utf-8?B?Y3RDU1NhMWlsYTd1bFBMazZuRmtTZ1JINUw5YmJrZ1Y4aDcyZjFjUW5OR0Vz?=
 =?utf-8?B?Z2RyTXdzSU9Ca1JhRjBYb2ZqUmxKVXdqU3U4K0RJMmVIa0wyM3ZhSUpTRzdP?=
 =?utf-8?B?ek5LZ1YxWTd0cEx5b2dBc0xueE9yWW1ZenpocG1UcmlCOVdUVk1vRnhQdkFC?=
 =?utf-8?B?dll2MGdrWmxDbUttNHNGU0VNSVgySWJsMVMyMkZHZGNHVHJPdTQ1UmZFcTln?=
 =?utf-8?B?dThoU05TYTRCaWhSL2J1UjJwNUUvYTMyOXNvUW8vREZCaVpCN2Y1cU5SSk1i?=
 =?utf-8?B?N2x4akYrd29CbDFIOWMreFhVRHpubG5kNHZpV2tMMXVjTnd5Smx4QTZqc0N5?=
 =?utf-8?B?M1NHaTdYRHpVUVQ0VE5KeC84dGZMZWZOanJJU2d0cVBOZ1Jpb2tGNVJpSlY3?=
 =?utf-8?B?OGd1OHFVS04ySkg0T0RkUEpLY3JydkxzVEFKeHJNemgvR2FkZncxdDVsUUdi?=
 =?utf-8?B?Tmx1VjlDOHJ5NGVZQ2duclRwckFERzhJQ2djWVpmV1FURXFRc2IyQys3R0I3?=
 =?utf-8?B?cFg4SDZuUDBsdjJKTFRsN1l2YUVMMlJadm9QbzY2SXdCczhVWkdMalhzdTl3?=
 =?utf-8?B?dEJZSEZxSlNNK3hxVTFQa1Z4MGtWM1Vic1p4Z3QxZEttUnJTVW9xeWtjOTU3?=
 =?utf-8?B?cFNQb1c0QmJmaEFLL3A1N1lMeWRnNDVFS2VrTUxIS09WNHE1MXZvTEQ0NjM0?=
 =?utf-8?B?cFp3QkFkM0dXWS9NbGkzM2ZwaHpLNmIwbDZ5RERSOERIY3lvN01Hdy9rbHlF?=
 =?utf-8?B?cld3aWJvQjNDOW1Ka3Y2T3MrY1dLVE9aVlFEeExpdTV4TCtSMldYRUQwcXpG?=
 =?utf-8?B?SVRVTHUyN3FRM05UcUdoeElxY21XOVRyVlJHZWczRkdpTENNZXJ6L3ppSGxR?=
 =?utf-8?B?RjhDSVNRcFlNOCswVjZKTitvMDJyNzgyUFoxSGkwRXRzclYxQVdXenBJSExO?=
 =?utf-8?B?SzVsY012TUdQZ0ZjTzNXTm5uV2VMWll5Tm9aMnJEREVudkZXQ3JuZDF1NGxy?=
 =?utf-8?B?eXlYRFc5Z0VrVHpuc3VKMkgvNkp2aDhTNXU5WDNIaFRoN0FLV1d6UXhYeXk0?=
 =?utf-8?B?RHl2VC9MTHRmejlicDJ0YVBJQUJiK09rSWRWY3lKampsNG5yb0o0QzBMdE1N?=
 =?utf-8?B?QjhQR3FsUlZkTGxGS1ZHdE1RajdPZDBPSVA1bkc4UnBPcW43VDRaeStDTWFE?=
 =?utf-8?B?ZFVnems0SUx0NmxoRHhMRHNSRTNxZjNpbjhVWG1MNEZVem5uWDJnVVc4aE9R?=
 =?utf-8?B?dlBWbEQ1WG00V0NINjFwRmdCUDNDYlp3SzQwdm1SSmZCQkEwSXhDMjNGTWxD?=
 =?utf-8?B?cnUra0xsbGRpN2VKcm5HVldxdkNCRi9oOERoRlVBY3BiZ2xVTDd6VUI5UzZ5?=
 =?utf-8?B?eWdkdzF3Q1dRdGwzanR3S2QrRlRnK1BZcENnZ3lHRzlpRmZEd2JiRVFud2Jj?=
 =?utf-8?B?MWhQK2VITk0wbVNwOGt1aitxVkpHZlRhaXJBb25pNFd2OGVITkE2d2pXN09x?=
 =?utf-8?B?L0V3QmpsTFp0YkJMZ3JSa09meDlTR2l4Z1ZXR2pPdjdaVmlwNWUrT25veFVW?=
 =?utf-8?B?eUtML3BRSjBnM0JTcU1IbVJvWmQvbkNVbENyRFJVTmp5cWxzRTFjV0owOFBl?=
 =?utf-8?B?YW9XWThBQ21mUHNzbDFsN2pnMjQxdkdkbjYzUEx5anZWbS9HT05VMTZIKzFi?=
 =?utf-8?Q?34X04WYoAgaLMf150t3rE6U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c245bb18-bb2f-4714-a066-08dda94e2573
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 01:12:05.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ4kR6m5KO83RiV0FNcph/aV3JQxx05KjjyJaNIUIKDMJK8wp4pyQ2TRJvynmbgNu8/kI6Fko27ZuyDMMhV8EcLeX2DPAzFDNvQ0M8pGKtxqlna9S+607Clz7/dU/UT6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1303

PiBGcm9tOiBTaGFvIE1pbmd5aW4gPHNoYW8ubWluZ3lpbkB6dGUuY29tLmNuPg0KPiANCj4gUmVw
bGFjZSB0ZXJuYXJ5IChjb25kaXRpb24gPyAiZW5hYmxlIiA6ICJkaXNhYmxlIikgc3ludGF4IGFu
ZCB0ZXJuYXJ5DQo+IChjb25kaXRpb24gPyAib24iIDogIm9mZiIpIHN5bnRheCB3aXRoIGhlbHBl
cnMgZnJvbSBzdHJpbmdfY2hvaWNlcy5oIGJlY2F1c2U6DQo+IDEuIFNpbXBsZSBmdW5jdGlvbiBj
YWxsIHdpdGggb25lIGFyZ3VtZW50IGlzIGVhc2llciB0byByZWFkLiAgVGVybmFyeQ0KPiAgICBv
cGVyYXRvciBoYXMgdGhyZWUgYXJndW1lbnRzIGFuZCB3aXRoIHdyYXBwaW5nIG1pZ2h0IGxlYWQg
dG8gcXVpdGUNCj4gICAgbG9uZyBjb2RlLg0KPiAyLiBJcyBzbGlnaHRseSBzaG9ydGVyIHRodXMg
YWxzbyBlYXNpZXIgdG8gcmVhZC4NCj4gMy4gSXQgYnJpbmdzIHVuaWZvcm1pdHkgaW4gdGhlIHRl
eHQgLSBzYW1lIHN0cmluZy4NCj4gNC4gQWxsb3dzIGRlZHVwaW5nIGJ5IHRoZSBsaW5rZXIsIHdo
aWNoIHJlc3VsdHMgaW4gYSBzbWFsbGVyIGJpbmFyeQ0KPiAgICBmaWxlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU2hhbyBNaW5neWluIDxzaGFvLm1pbmd5aW5AenRlLmNvbS5jbj4NCg0KRm9yIHN0
YXJmaXZlOg0KDQpSZXZpZXdlZC1ieTogQ2hhbmdodWFuZyBMaWFuZyA8Y2hhbmdodWFuZy5saWFu
Z0BzdGFyZml2ZXRlY2guY29tPg0KDQo=

