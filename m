Return-Path: <linux-pm+bounces-27787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FA8AC7668
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 05:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EFA9E2012
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 03:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D221CC5D;
	Thu, 29 May 2025 03:16:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2104.outbound.protection.partner.outlook.cn [139.219.146.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239112AD31;
	Thu, 29 May 2025 03:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748488584; cv=fail; b=LudSvMHYqDMHkxNO6fovG0iPsArCIv7Hh2fMxfDG6Q3H6voYI9teJp1y4yQXFm8wO9sTkPPQeHaPtV0YWNopQbG8IJvn7pvJzkwa5lxZiJXvgwt7jxBfAmeTvX65UailJMX5t2U99g1laF2oau2p8WnGdw63RvPZob70IRmWkAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748488584; c=relaxed/simple;
	bh=4jX1PWk6yYTxcJL9sDPGjAd2cU4rInZ1jHZf9R6oAMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ThhSUm3AgHQtnwop4hrWnG8hVsqWH7foErPTho6t0ZcIzIPzuA+FAYdrjfXznCI3u99GmjQobd6ctdgROG5dxdzqbV2Hw32m/wMQ4jG2EW9Wmnzl1rmhL31iWenD/WVlyAAaRp+6bBPDpSJol1bQsUsn2RmKc6uY/JUpEkzHhY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/sh3YbPPFgL56x4KZLuZ8zdYBxYufaIleu9hPYIqcRqN7bIxOAPgx79EecfiyPk5iKHHMD7uem/WfI9bqcZ7780IhbHbNPQcdM5m1vbk4XR3xuUfvAFvPi1STTvV6cimuuJrabMNPMBJ+7NewQkKiuXYT4We+LjgA5cqAkt6Gx7+u8jlmFDvssbR1HmaMDMgf9FbPjDyzetqehfv29TyTNCHpBlhmHq8x1xPgmu7qQSkkP5uHugkSa+zhlq9Dj0gtuPSPOMyfTwgONQX12Ov9zvM9T3QaZ28yT0xbcJSQMeNFzdDpLNVXcB5SXeVXH+21hBWWKBX3xjofxfGfqr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jX1PWk6yYTxcJL9sDPGjAd2cU4rInZ1jHZf9R6oAMI=;
 b=kGA9fi47rmiZx9n1xVWNh1loI9svs8VfqC6eIBT0dZJgI/rQEV9OOFzZ7gnn+gafa9xq5ZyQtFc3Y+0mx29GdeQlZY4ls4ScK8tisq1p0DpL/ZyCyyM0okw9QkQ61ama8xzzFH5V17V7T+jkHx7l15tQv/ryNsYCToAvkBuU+Q9F4jEnRDXR6gOf7pxjXHz4uJP8sTbAsU23pSnND1ys54RgCA9syPq2Xr0MTXYKZdWxSK6IFNxfMbZyRIerLYnbEX7MWpLPTBYwTNkFHNO18KFneXYE36caSqWhs5i6Cb9nMpfpA8b9RgBjhI8HLTNpj6QLSrMOCkoC1Kqh9c145w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 02:41:54 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%6])
 with mapi id 15.20.8769.025; Thu, 29 May 2025 02:41:54 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: "shao.mingyin@zte.com.cn" <shao.mingyin@zte.com.cn>, Walker Chen
	<walker.chen@starfivetech.com>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>, "xu.xin16@zte.com.cn"
	<xu.xin16@zte.com.cn>, "yang.tao172@zte.com.cn" <yang.tao172@zte.com.cn>,
	"ye.xingchen@zte.com.cn" <ye.xingchen@zte.com.cn>
Subject:
 =?utf-8?B?5Zue5aSNOiBwbWRvbWFpbjogc3RhcmZpdmU6IFVzZSBzdHJfb25fb2ZmKCkg?=
 =?utf-8?B?aGVscGVyIGluIGpoNzExMF9wbXVfc2V0X3N0YXRlKCk=?=
Thread-Topic: pmdomain: starfive: Use str_on_off() helper in
 jh7110_pmu_set_state()
Thread-Index: AQHb0EA3AiAR0kfx2U66FCLwfWKAdrPo4+9Q
Date: Thu, 29 May 2025 02:41:54 +0000
Message-ID:
 <ZQ0PR01MB1302F225EB8C1B1B75D2FD66F2662@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20250529102005168oXmW54srQ-rBCEFa12u1U@zte.com.cn>
In-Reply-To: <20250529102005168oXmW54srQ-rBCEFa12u1U@zte.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1015:EE_
x-ms-office365-filtering-correlation-id: b6552567-143a-447e-6f0f-08dd9e5a5f85
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 GFfPN/AR6yYS5Li+LB56D3WnUvqaNpt0WOO0Aepc9VFGx5ex5RuiY1eQfbhTQOCunePV0170uxeW3hflHNk60cJPgp9Vx5VBFL12rBpjfXl3LSCenBfCFtJu0fKu4HxThsuQSk38uhh0jVG1wuu0SIb7fyAvoxF4M5dHAI+Dp1NSqoWQ5oGTkW5UvjQlhIz2GYxLmNvBSBQccSCjpsOR6vbUoYa5AMmwCmZAq4IcQVRhsoTcn4BeVQxhpUdnYyztn8f1Lpb/UreQiHzkKf4HxtVilNOANoGvDLby4MiYTjQRxrXmAO90vP9vP+MEmyOJdzhgs29EzgV/Y6NQdknAPwTym6KJ/0Efaym8xAKzzjXARW8++K163vJFNzhYK2WFU+eQl85w3gittosCk1olVj2UftjgX3H8ObdWZBdmcwhMI8ffqu9ksaRQvc/a3zz1AAj86Yw8S4FLgNGd5V8IpQxLBf/2zcAfEYLmlub33vy49ho4//Zs6Eeg3jy3AGPoZS3du/OS7msZ7++8HVKV5Axt6Z76SV05W/swjAIW78wRdCG7UwGtTO56PQfIiWNbapziE8cpOnikd5fj8LiWakwpYFDjwsTu25K5vT1JZJU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1hTdXVHSVhHcEl3MjN6ZkRDeWVLRlJMZjlka3ZsWVFOWldCT0ViNVhKczl2?=
 =?utf-8?B?MU1qc3IyblBtODkwNGkvZjhmemhoalFvaTZBbFJGVnMvZkJqVE1GUkdreXkr?=
 =?utf-8?B?Vnp4aXZERFQyTGMzZXRRczRIcDRRYVBWSVRFWEVlOUNudmxtMDVpRi9TYXdJ?=
 =?utf-8?B?dk84b3o0aUR0ZDlVVFkxNWplaG8wakxucStiOVQ5SDVOdklCU3VNMTdhQ1Bt?=
 =?utf-8?B?aEJWYTZIUTBHY1JTZzJhbTlCMVpyYXRrVDNXQzhJSndIU1J2dGoxT3Z5MTY3?=
 =?utf-8?B?cGs5MDZIdDFXQ1lCQzduVU8wa21XNGQwa21zeWNWTUcyVTBrSEpYcnZ1ZUlh?=
 =?utf-8?B?Ym5CRW9xc0JvNU9KZ2wwNVVXaWZMWXlZQlpWUDVuSkFOSldTVk91OWNwbTRR?=
 =?utf-8?B?S0k3OXVsMjAySzNCbzdOdkNCa2drRUp0VHAzRFhGVmQyZGFPRndTbk9kR1lo?=
 =?utf-8?B?RG1HejVyUXorcGJSWWttWHExZS9ma2NsbXB1ZVV6cUVaekpBMVJkQjYzZVR2?=
 =?utf-8?B?UzVCL2ZRNFphSXYvWkovQ1JZU1R3UDlFZGk1T29qbHJFc2hKUFBHL1VjdXZj?=
 =?utf-8?B?RWkrU1o1RTcwTkpkMDZZaUZ4SldwaUdSOHk3d1RWWE5IWlduTEo5Vm4xSVJV?=
 =?utf-8?B?SXRtditLVzlMQjBKWFJQNGNOdWtFSUhjMzdWMzBCSm53V0JqbUlUU0MzSXB5?=
 =?utf-8?B?dEpBNk5jYllDSXpGNjJJQTc4ZGsxczRTbno5c1grVW5TcGhoUTlhZi8xbkJZ?=
 =?utf-8?B?TUlpSThPZndBeXZmbXNpa2w0d3VCRmhtazVLcjBRUG5RUEJaQ2k4RXNaQ1Fz?=
 =?utf-8?B?OE4vWkg1ZTJTdEU2cUFXWDgvOHp4TDlZTmxXcU16UXNPRmNOSXBXUHRRTVRQ?=
 =?utf-8?B?SjN6RGtYenVDYWQweHVweTZPa2hvQTdEUjE2Q0g2Y2RTWFhpWVlFRFlXZ010?=
 =?utf-8?B?MkR6ODFQV2hhTXZSOVZNS0F2TGVGeU0xSXF5bmNEMWRFeFdKeTJpQUgySHpK?=
 =?utf-8?B?UnNRUUdQdmhDZ200ZHc5VWk4eUJQSHBVSWsycVIwb0ljRnU0YURDaWV4aXFj?=
 =?utf-8?B?dVRTM0hGRnRVZFZsS0VlK1V4ZzVnSFp4R3NWbDZBa1hBNkRxbWgyd0dxZ2ND?=
 =?utf-8?B?Ui93NWRIdWRVcUhuK2l3WkZlaUl0allsNDVvQVBoK3ovUlhJUzlsd3lnZnlW?=
 =?utf-8?B?YjZlMUlTWDlLU2ltRTMyTEp4Rk9Zc1NkL3dhODV3bzFKN3NCdzcxSWNqWVBm?=
 =?utf-8?B?ZzBSbS9MNGtpR0JCc1JkYTdQQzIrRUh3Z21YZm9jaTkvNTdPOHA0UHljelc3?=
 =?utf-8?B?azJaRVNTUkhsY2NHclNVOWF4Zytzb3ZQS254Ukl4QkhTVC9MOUZObmVORzVF?=
 =?utf-8?B?SHBub0EySFpRTGY3KzB3Smo1QmpOZzI4WEQvM2ZWYUdxQUhneFdsallNeFFa?=
 =?utf-8?B?NWNnOFgwc3YweVB2SGFuOWpKa2dyTUFwajNNVTRiMktTMVFzUkFmNUdnaW03?=
 =?utf-8?B?Y045dmV2TE9vYUg2NURLYlpTYlVCbmpuU1MvRGM5MFgwcjgyZVJyZG5WNkx3?=
 =?utf-8?B?TUE5ajFQUWY0MmhOdjhHaktNakoyNmJESW1CUHJjdHhXa2RUYlNtUmRjU3J1?=
 =?utf-8?B?S3RFbFNOTXBQRXBUU1JMQjJYcFhRZWw1YmFIUTVFMWppOTdUSHJxL2NvZTBp?=
 =?utf-8?B?NWlqYnU5UnJOY1h0K2lnSmU3d1dhbVZDQ3hXQVRqQkRHbmdSTkNYOUdiTTBP?=
 =?utf-8?B?OXVLTnpKNmg0VjV4WklNL2twU3g0emdLMlIvQ1VsUUpuTFFmclBDREFGQkcw?=
 =?utf-8?B?U1krZ3V4eTNjQlg4QUhGZnFvQXhLVVdNRVhEeTExS293RThpbERIZ3d2S2JD?=
 =?utf-8?B?K2ZVT2ZSTjJYRzNaN1U2QmJRamtoSGU4VDZsNTdkN1NBOHYyVkhZS29pN2tH?=
 =?utf-8?B?bFl0aEo1aEkzekpYNFNsdktqTnpJV3hvcU5odHkyY2F3UWtrdjNsQVg3OEUr?=
 =?utf-8?B?dE1IY28zZTJaRVBqLzVZUEFpT3g0M25kSVh2YitvWnIrbytvMVNCd2NiQlM4?=
 =?utf-8?B?R2doemtORWY0S1BuRzVRR0MvbGdZcDlKTEhra1dWYnhpd0VoRkdvNFVvaWVM?=
 =?utf-8?B?S21pL2lBWnpDWW1kSW5mMWZuYjJPZENDYmEyanhCWmhwc1NwU1duZ0ZSU00v?=
 =?utf-8?B?VkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6552567-143a-447e-6f0f-08dd9e5a5f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 02:41:54.3129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiKJOhUbxzfBT1iSwlTpbPThomMiQhlXGhMkvwi8KvvCsv57s1fNghoLDC2XnTynRvd6DCestKUSApgOaS9J9/kwKl2WdpW5FrVCL/wXyN2r4IVks3TLWBIBu2Zdu70o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1015

SGksIE1pbmd5aW4NCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KDQo+IEZyb206IFNoYW8gTWlu
Z3lpbiA8c2hhby5taW5neWluQHp0ZS5jb20uY24+DQo+IA0KPiBSZW1vdmUgaGFyZC1jb2RlZCBz
dHJpbmdzIGJ5IHVzaW5nIHRoZSBzdHJfb25fb2ZmKCkgaGVscGVyIGZ1bmN0aW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU2hhbyBNaW5neWluIDxzaGFvLm1pbmd5aW5AenRlLmNvbS5jbj4NCj4g
LS0tDQo+ICBkcml2ZXJzL3BtZG9tYWluL3N0YXJmaXZlL2poNzF4eC1wbXUuYyB8IDMgKystDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wbWRvbWFpbi9zdGFyZml2ZS9qaDcxeHgtcG11LmMNCj4gYi9k
cml2ZXJzL3BtZG9tYWluL3N0YXJmaXZlL2poNzF4eC1wbXUuYw0KPiBpbmRleCA3NDcyMGMwOWE2
ZTMuLjMwYzI5YWM5MzkxZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbWRvbWFpbi9zdGFyZml2
ZS9qaDcxeHgtcG11LmMNCj4gKysrIGIvZHJpdmVycy9wbWRvbWFpbi9zdGFyZml2ZS9qaDcxeHgt
cG11LmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Bt
X2RvbWFpbi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3N0cmluZ19jaG9pY2VzLmg+DQo+ICAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvc3RhcmZpdmUsamg3MTEwLXBtdS5oPg0KPiANCj4gIC8q
IHJlZ2lzdGVyIG9mZnNldCAqLw0KPiBAQCAtMTU1LDcgKzE1Niw3IEBAIHN0YXRpYyBpbnQgamg3
MTEwX3BtdV9zZXRfc3RhdGUoc3RydWN0DQo+IGpoNzF4eF9wbXVfZGV2ICpwbWQsIHUzMiBtYXNr
LCBib29sIG9uKQ0KPiANCj4gIAlpZiAocmV0KSB7DQo+ICAJCWRldl9lcnIocG11LT5kZXYsICIl
czogZmFpbGVkIHRvIHBvd2VyICVzXG4iLA0KPiAtCQkJcG1kLT5nZW5wZC5uYW1lLCBvbiA/ICJv
biIgOiAib2ZmIik7DQo+ICsJCQlwbWQtPmdlbnBkLm5hbWUsIHN0cl9vbl9vZmYob24pKTsNCj4g
IAkJcmV0dXJuIC1FVElNRURPVVQ7DQo+ICAJfQ0KPiANCg0KV291bGQgeW91IG1pbmQgYWRqdXN0
aW5nIHRoaXMgcGFydCBhbmQgc2VuZCBWMj8NCg0KSW4gamg3MXh4LXBtdS5jIGpoNzF4eF9wbXVf
c2V0X3N0YXRlKCkNCg0KCWlmIChpc19vbiA9PSBvbikgew0KCQlkZXZfZGJnKHBtdS0+ZGV2LCAi
cG0gZG9tYWluIFslc10gaXMgYWxyZWFkeSAlc2FibGUgc3RhdHVzLlxuIiwNCgkJCXBtZC0+Z2Vu
cGQubmFtZSwgb24gPyAiZW4iIDogImRpcyIpOw0KCQlyZXR1cm4gMDsNCgl9DQo9PT09Pg0KCWlm
IChpc19vbiA9PSBvbikgew0KCQlkZXZfZGJnKHBtdS0+ZGV2LCAicG0gZG9tYWluIFslc10gaXMg
YWxyZWFkeSAlcyBzdGF0dXMuXG4iLA0KCQkJcG1kLT5nZW5wZC5uYW1lLCBzdHJfZW5hYmxlX2Rp
c2FibGUob24pKTsNCgkJcmV0dXJuIDA7DQoJfQ0KDQpCZXN0IFJlZ2FyZHMsDQpDaGFuZ2h1YW5n
DQo=

