Return-Path: <linux-pm+bounces-20453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE16A1170B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 03:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2D63A239F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 02:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9922DF8F;
	Wed, 15 Jan 2025 02:11:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE571E1A31;
	Wed, 15 Jan 2025 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907070; cv=fail; b=UJcExi+r8RKV19Rk4sCcDec1uuy6k2CX0ZhiUEL1yQh6YTkwbeyuqcYN8TjE/KNmsn9uwrp+3h1++opyzrCDv3pWa/uS+gXuA1okIpzxczTu3GbO8TRP2IgOtC5bnkPriBKhl1t1iIUXj9WPTA5CwaIR1ChhwWQ0DhV6dV1ji4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907070; c=relaxed/simple;
	bh=dR3Cb/qTF5vN7iRT//Ymnuy+NFkTSFphMP9oaYobVjs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cTEXPpng6sxhhM5mYzRMy7/s1bG/PiHQeC0ii4GEKJemVw7cK6fxQGgbZ8mf5NytGI8HIw2tkpDNAgE4PaRqGEgKSrCYozGNPWvqUqcdXqkF5dcmWsZsuTFbTSv0xvcpum5aUVPgwL4+2Gpi12DqmCCPVGGGkVswPQo5n3pV4rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdOeT5vodXGbsoOXYWpxYE2Atvw3Iflen4CEGTQLnhBVrbaouuo7A8raSSvQPtMW+vhdfGjkA4eDfLvzh5xpGSX1U0eh/skawoMo50C6+qpzHgCjvFMXS7f1UvLTt7cl7iaWJ72hLgE1g+uem9XRbzxvQ+g2ENfQxvMHOjBw0ecy9D536sydDr34KhTnfTHFh/nz6f+oeu5NZUpuBGxIvsR2Q2fnJcuSCIo97qCSaJdiQ6qH8xLxrKQE9SQtP0C18Zlgi2t9Djv/dp1OEuopv9qUqtDdm58HyKcpdxTDm3K080cOCPxJfmQTysQidt9qSn2v3XfzNZPOxT8AaedKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR3Cb/qTF5vN7iRT//Ymnuy+NFkTSFphMP9oaYobVjs=;
 b=a0Qs8n2+VHBqewIy0pBQ2KXE4HzrH8TKPQ7xLmRmj16UWZIXIM+hbF2eMu8c3eMnMiWATcP3EaOwR8xJUc/StVvoxbAsRUwV6kZNO5Cacw5d7QuRi9pBaoOEKyB96yiH9zBRUP5BPmhfcVLbn1iBT7uwEesEIUw7841KAfjryMKLzsiUfWgJ6MUJKNefoNnfgdTlMXufdUEVhl4nPTcEJmz460zj2hwRAz64u7IQsKOvbidrpiW/+DZoF4SGzgjF53yV6oN+x1lPYOHttjnPmRvvoR85XsRdJJnUipMqLRwqeQmX2WHWfOCjKfGDyk1G4BgAsvyUsGrRstzD7PDXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1096.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Wed, 15 Jan
 2025 01:55:57 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%6])
 with mapi id 15.20.8356.010; Wed, 15 Jan 2025 01:55:56 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Walker Chen <walker.chen@starfivetech.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIXSBwbWRvbWFpbjogVXNlIHN0cl9lbmFibGVfZGlzYWJs?=
 =?gb2312?Q?e-like_helpers?=
Thread-Topic: [PATCH] pmdomain: Use str_enable_disable-like helpers
Thread-Index: AQHbZsPskPdcH3c8DU2dRgBeHOezf7MXEgSQ
Date: Wed, 15 Jan 2025 01:55:56 +0000
Message-ID:
 <ZQ0PR01MB1302D40B42B69887842A7377F219A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20250114203547.1013010-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250114203547.1013010-1-krzysztof.kozlowski@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1096:EE_
x-ms-office365-filtering-correlation-id: c08e440b-583a-4341-faae-08dd3507c0a0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|41320700013|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 bCLK1twlQyJVx3V+407NPbgIR33H1YeEmeYjJy/5LrkuYY7DPbSDJd3qMLE35msrImQyJDMcmGLqsLStedQIJ9mdhvGz9LhM2HfVO6NZA3FtqyvuEkEKKLev9Tl5a5rcO4AoKM0t1acO+9EU68Ya+D1tKET8X2yHGpJynhgpAOAONjNmGNbHjkD1kgJs2p6cBb6OJn+XurcPC38L/yUYUuhQe0S/c/Togy8BjlNbeAhg6dYoaR6bO0Ckf7XyYrM6OBpvc6pzLzlYgK+8bxccAAhwOTEpAfmt16YZT+xGBu6W22jXXvdw3QGIVtoegcyHtRqwTlk240pnvKQlo3lxb7DeUZDdnpu3GKpWDM4zstLrGnXiQBhMQH/F8b8JfFpzozgiJMfBof2MbUx19xvIMNxFpKe2F83VyyVMtTvvZt9cGqlFZbn9qg6Pu9AGu81OLl7YyPQSL/KfgKMsyfnMySko9fnFoVP8OvyXrXT1fprmCLOIuic1hKbes87WIeGhshaE1K+fuUjfoTA65v5s9Lqgvrjltsd1sIcSnfFHUpoh+biNN9y3nvLecTT14uJMID3EpMwjqhOxVk3w1F+9mkzgsTcN0roE0fKLM9gbU9I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(41320700013)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YjdzeWxmRVZXb1ArMWhTeGRSMmdPMUMzbWVpZTg1blFWODlmaGZXQXh6NElW?=
 =?gb2312?B?anprWVBhZkxTTCtqb3VoT1AyZ0d0MFN2MmRUNThvZC9xNjNPU1ZvcWw5NkNF?=
 =?gb2312?B?K1NOWkd5endLalNyNUltY041MEk4ZWVJVnBJVkdGTFBmUXNOQzVIOVZRMTg0?=
 =?gb2312?B?NkdTcTBnQVdFVW9GeERTUVNJNUZKQVZ2amZvNi9WV0pKazMxZUprZi9za0Nw?=
 =?gb2312?B?WkUyaS90VGRHTVI5RkFFNExFNTVRbTROYVVtTEM0VlhUdWV6NG1kTmVvTjBm?=
 =?gb2312?B?RjYwSDNMcFdlb2tWV3kzZ2tkY0JwODczNEVFeXV3cjdSNklVRThoZVJWS0lX?=
 =?gb2312?B?V2c0NmtLd2JadXMxejZpeTBqT3pnUU5rOG9sVnVnZ0NpaU53Z1pudDBLZ1pU?=
 =?gb2312?B?WHN1WW01Mk10VlhzRlBFTEJKUTQvTHpRWFQ5dXlmM09zMWJHZHBaZGliNzN2?=
 =?gb2312?B?Vml0dDdRTnp6cHJ6NHBrK3FwVkhmb0U4UG8wa05EOWQ2cDlBcXRBbm1iK29x?=
 =?gb2312?B?QmZmTjkrZW50RzFlVFU4TlYwV2N6cDZOSUNaTFVRMW1xazhtSHFidUdSUzJs?=
 =?gb2312?B?NWVPZUhrcWlQbGY1ZFFLbThsbFhEdFJWbE05MXg4V0dUTlFPa0pkKzIrSTJu?=
 =?gb2312?B?RE0zOTJWbU9iWU5JSHdiU09pcDY1OHFhc3hzZytyamV6NnRqZ3E1aXhzV05s?=
 =?gb2312?B?R2FhMjl0c09QdjlHOG9JcGFCU00yK0d0MlhQdjVBdzZZU0F4cVZsT0liaW5m?=
 =?gb2312?B?TGdaeGN2bmdlbUI5eGpDeFM1OE9JcHFQUVVvaFA5Q28zMllWUTB1bDBGSlBY?=
 =?gb2312?B?Um9Oc2V2d1l0LzkyMGMrNmFOaTNZb0Fud1d2MHNQMVFpUVorVUpSejJ5OW9h?=
 =?gb2312?B?S3c2UGZtd015N1VVWFkwUzNUQyt6RHkyeDc4UDNTT01zaUpTb0srOVRuREJ4?=
 =?gb2312?B?V1lVWUNDQjJOQ3Q5UThCWHRicVJqTGhraEIwRFVvS2FvdWgya1VncWdhV2d0?=
 =?gb2312?B?cVBGejFRZmFqN3pzT3VMSmNrWm5tc0dXcVVualRXajNYWEhKZ0RXVFV3amZm?=
 =?gb2312?B?UHIyaGlvbHcraDZzWVUwWnpxZFh5eEluaFplMGVHSnNsZG1pVmpJRzlEZnVF?=
 =?gb2312?B?elM4U2hVUG42a0svdFpBWXdML0R1ZFR4U3Z1UUJUNVZKVFpuN3EzVXVOd1Vx?=
 =?gb2312?B?dWRpbmFjVVVGQ0VOckhYV0RUbTNENmFicFMraGJ1YU1ENU9jZEFNbUg2R3d1?=
 =?gb2312?B?b2dNNk1oMFZzUVZCKzR6SVlBNkFreXFzVHk1S3MzcitCTEFWUlgwTjdScE9Q?=
 =?gb2312?B?VW1GaHVwdlVPenZnVVpZS0Y4RFZ4OEJ1QytsRzRrQVhFU1d5aFhWc3RZWllk?=
 =?gb2312?B?Y0xnck5oYmdzT1hpc3YvY1J0VE0xeWZycEdKWXpCK0FYUjNSOGJUSFVZZFZB?=
 =?gb2312?B?SHNqZHcwZ2ZKQlZkU05wTVZFZGVrQjdmSlZKdEhPa1p0S01sWG9DZ2pLNHp1?=
 =?gb2312?B?UFVoVVdlZWlKQ29VRXZmQXZNQjBUeEROdThnTnM1WlNtSUVCK1FSK0h6ZEcw?=
 =?gb2312?B?eU1XMWFPMWx4OHNQa2hqSG5RTjhXajA1THcrSzI3UUlPUHUwUE41c0w5RnVn?=
 =?gb2312?B?cDBXSnlGc1pNQ0dxOHY3bTNOcmg2VnBSRU9qTEpWOThrdG1lL0VyeXBFOEI0?=
 =?gb2312?B?N3pRTEMxNW9FbWpYYmRmUThQNGdVOWkyV2pKVERKaks2dithRTdESXR6d1Qr?=
 =?gb2312?B?SHhHdFRyZ2dKMGxCZTBKOS85ZDdLSTJLMFYxMWFYVFpiNTlpbXUzZWdialdk?=
 =?gb2312?B?VDlQZ3BYRktwWTVFMEwraG5GV0dqZlBFTFg2U1FFTGlJK1g0M3YyZlUxM3p6?=
 =?gb2312?B?V3dISXlFRko2YTRacnJYcFNsUlgrU2toVmFVb0tpcjNrTmxNSjhzK1pkaTR1?=
 =?gb2312?B?L2R4OVVKUjJpRmI5dXhTQUFDNWpET0VURkJvWFRLOHlycGtuR2s2OTRjOGMz?=
 =?gb2312?B?Ri9pOXBnSVZnN0VLbXpsdVQzcmdablV2c2EvMWlxSHZSOWZ6Z0dyM09BUThY?=
 =?gb2312?B?U3J1WC93N2xSYklIVnBIQmIyUXlZU2IreWE4QmJpcGt4Znczc3YxM0Y3VXFl?=
 =?gb2312?B?MjJHbnFUMHBTUVhiTDZPUlgvVEhiR2RGY0RzUnN0YjFIVUpwK0ZWWkE3YURP?=
 =?gb2312?B?YVE9PQ==?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c08e440b-583a-4341-faae-08dd3507c0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 01:55:56.9031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IThEjPVBuZiov+2frECQe8Hp8gLGOL6m/A4hy8hyCnFOd2a/6OTf2GSeatl1bdU79Z4IOCf3u5cRGIPd3aZZuiDO5WaR8lNz7c/q67KrFnCWGPJo98jXsYVLKCdLJ3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1096

SGksIEtyenlzenRvZg0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQoNCj4gUmVwbGFjZSB0ZXJu
YXJ5IChjb25kaXRpb24gPyAiZW5hYmxlIiA6ICJkaXNhYmxlIikgc3ludGF4IHdpdGggaGVscGVy
cyBmcm9tDQo+IHN0cmluZ19jaG9pY2VzLmggYmVjYXVzZToNCj4gMS4gU2ltcGxlIGZ1bmN0aW9u
IGNhbGwgd2l0aCBvbmUgYXJndW1lbnQgaXMgZWFzaWVyIHRvIHJlYWQuICBUZXJuYXJ5DQo+ICAg
IG9wZXJhdG9yIGhhcyB0aHJlZSBhcmd1bWVudHMgYW5kIHdpdGggd3JhcHBpbmcgbWlnaHQgbGVh
ZCB0byBxdWl0ZQ0KPiAgICBsb25nIGNvZGUuDQo+IDIuIElzIHNsaWdodGx5IHNob3J0ZXIgdGh1
cyBhbHNvIGVhc2llciB0byByZWFkLg0KPiAzLiBJdCBicmluZ3MgdW5pZm9ybWl0eSBpbiB0aGUg
dGV4dCAtIHNhbWUgc3RyaW5nLg0KPiA0LiBBbGxvd3MgZGVkdXBpbmcgYnkgdGhlIGxpbmtlciwg
d2hpY2ggcmVzdWx0cyBpbiBhIHNtYWxsZXIgYmluYXJ5DQo+ICAgIGZpbGUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFy
by5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9wbWRvbWFpbi9yZW5lc2FzL3JjYXItZ2VuNC1zeXNj
LmMgICAgfCAzICsrLQ0KPiAgZHJpdmVycy9wbWRvbWFpbi9yZW5lc2FzL3JjYXItc3lzYy5jICAg
ICAgICAgfCAzICsrLQ0KPiAgZHJpdmVycy9wbWRvbWFpbi9zYW1zdW5nL2V4eW5vcy1wbS1kb21h
aW5zLmMgfCA2ICsrKy0tLQ0KPiAgZHJpdmVycy9wbWRvbWFpbi9zdGFyZml2ZS9qaDcxeHgtcG11
LmMgICAgICAgfCAzICsrLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pDQoNClsuLi5dDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG1kb21haW4v
c3RhcmZpdmUvamg3MXh4LXBtdS5jDQo+IGIvZHJpdmVycy9wbWRvbWFpbi9zdGFyZml2ZS9qaDcx
eHgtcG11LmMNCj4gaW5kZXggNzQ3MjBjMDlhNmUzLi4zMGMyOWFjOTM5MWYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvcG1kb21haW4vc3RhcmZpdmUvamg3MXh4LXBtdS5jDQo+ICsrKyBiL2RyaXZl
cnMvcG1kb21haW4vc3RhcmZpdmUvamg3MXh4LXBtdS5jDQo+IEBAIC0xMiw2ICsxMiw3IEBADQo+
ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZp
Y2UuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbV9kb21haW4uaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9zdHJpbmdfY2hvaWNlcy5oPg0KPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL3N0YXJm
aXZlLGpoNzExMC1wbXUuaD4NCj4gDQo+ICAvKiByZWdpc3RlciBvZmZzZXQgKi8NCj4gQEAgLTE1
NSw3ICsxNTYsNyBAQCBzdGF0aWMgaW50IGpoNzExMF9wbXVfc2V0X3N0YXRlKHN0cnVjdA0KPiBq
aDcxeHhfcG11X2RldiAqcG1kLCB1MzIgbWFzaywgYm9vbCBvbikNCj4gDQo+ICAJaWYgKHJldCkg
ew0KPiAgCQlkZXZfZXJyKHBtdS0+ZGV2LCAiJXM6IGZhaWxlZCB0byBwb3dlciAlc1xuIiwNCj4g
LQkJCXBtZC0+Z2VucGQubmFtZSwgb24gPyAib24iIDogIm9mZiIpOw0KPiArCQkJcG1kLT5nZW5w
ZC5uYW1lLCBzdHJfb25fb2ZmKG9uKSk7DQo+ICAJCXJldHVybiAtRVRJTUVET1VUOw0KPiAgCX0N
Cg0KSW4gamg3MXh4LXBtdS5jIGpoNzF4eF9wbXVfc2V0X3N0YXRlKCksIG1heWJlIHlvdSBjYW4g
YWxzbyBjaGFuZ2UgdGhpcyBsaW5lOg0KDQoJaWYgKGlzX29uID09IG9uKSB7DQoJCWRldl9kYmco
cG11LT5kZXYsICJwbSBkb21haW4gWyVzXSBpcyBhbHJlYWR5ICVzYWJsZSBzdGF0dXMuXG4iLA0K
CQkJcG1kLT5nZW5wZC5uYW1lLCBvbiA/ICJlbiIgOiAiZGlzIik7DQoJCXJldHVybiAwOw0KCX0N
Cj09PT0+DQoJaWYgKGlzX29uID09IG9uKSB7DQoJCWRldl9kYmcocG11LT5kZXYsICJwbSBkb21h
aW4gWyVzXSBpcyBhbHJlYWR5ICVzIHN0YXR1cy5cbiIsDQoJCQlwbWQtPmdlbnBkLm5hbWUsIHN0
cl9lbmFibGVfZGlzYWJsZShvbikpOw0KCQlyZXR1cm4gMDsNCgl9DQoNCkJlc3QgUmVnYXJkcywN
CkNoYW5naHVhbmcNCg==

