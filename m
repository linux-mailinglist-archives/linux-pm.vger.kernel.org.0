Return-Path: <linux-pm+bounces-32347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40548B2524D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 19:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57C51C24F33
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20126299949;
	Wed, 13 Aug 2025 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mkHGT0ey"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010039.outbound.protection.outlook.com [52.101.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5F296BCE;
	Wed, 13 Aug 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107078; cv=fail; b=ZMjVKrbOz7QhVmqkh+xOYGWLufs/XN9S3T3GCPk+T7OZiJ/aoolmjqGXRB0uN5JkhJ6QtUDJN5RYxaNffVSktzyEX71RJaZUXPSr+iuDdBVPquIssCQw6t5UyOKDo7unhh6K1IKS4NA+hGqmsJ+niieCw08Ix2t7sBNdtzfKUVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107078; c=relaxed/simple;
	bh=Bcza40z1Yp6rzPERSqcwcIZ2qWA3o6P58weTOAYZIOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEwUSzYy4JHUbAPC2VC7H9mdyqBKLs+Kn2cKTvLL7Qu8FFmByn2cD9kb7PTQ3VcCMPwyp4YBJTXr9jdSJvpdvQthoMEbhw70S+xQOQLDvYG8TgzWlYIl1JsHqFXEXwjxHZwRBPv+rvlwSIeUm0FLibDBk1RBnNY+BFFTgtcGmxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=mkHGT0ey; arc=fail smtp.client-ip=52.101.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1TOS4leSxKvVY7uwHkZBYRleROaa+UWT4kGNaIMuaFNnn/jEROV5Y08LVh89T1ejo+BHEZUEdzb2o5F+7abn5LxMV4U5REfDCuSjXQhWCwA2pe2vU9E2xWEFr6lVTRp2G+WbcGMyg/mtGcE7CByTZuN0I4XI2SGtBp3nrVtIlOgb/GhmL2rLoHaUJaQkDEX/RJHLlTWUiZPMUpWod8I+ca58m6Xo65qzygPvBmf07nnI8uJWyuFTeE8Q3LtF0ST8z+kUPqR9zwr0yvsJGgjh6S6LBzzt4AZxaJp7Tx595XrTQLRxpPHEW0kLOGJibN0KDnS0oJLVs1cJwbYlXnDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bcza40z1Yp6rzPERSqcwcIZ2qWA3o6P58weTOAYZIOI=;
 b=sK4zLo8um8bSKryrcYd1iAqGGBUOu1ZDSBXNnN8jkj01zN6pR6kx51OI2orPeb5LPIr+5E8lffYf+fBDBi1VUMO8eJTcAdbjwbxwaBi8kFmJuuVkIQUwV4UocvSJHVvxXpmZAIBK08ut/01TB2AY8IxVnD0n5PZH1CaIHWCI3tKLxxuU/ck4oRrhd7R4w+kuMXAJTKJnOHalsoMIoVq85ewdxThdmVGCbYWRycrGzNf0fnp/ZvpHxHUMDcgK7rRfDfIE7xAOMf8mcuHn5TGr/RD98t4aUr5Y+N4xpi8WWzJcUbdN4aanQwhiJPwPBHjJz+N3ALfP18QZFHcyCpCIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bcza40z1Yp6rzPERSqcwcIZ2qWA3o6P58weTOAYZIOI=;
 b=mkHGT0ey/zjbcAjmZT3VYwDalMPpfeQiKLAx2cAzPczXrgXBu/ulbBxo0tlW6fb2D9ghgQIsFc6gioCEGOpIqyU0wltL+4aozUValDe3RGSYO0ad22uGXzaxhz9zTDnubflUAIVANDDc+k0bKe/AoZfJ/XZItJBtGVQ851KPpHw=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by TY3PR01MB11624.jpnprd01.prod.outlook.com (2603:1096:400:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 17:44:29 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 17:44:29 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, magnus.damm <magnus.damm@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>
Subject: RE: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Topic: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Index:
 AQHby0ai9SCDgo20z0y3b2QkXuPFT7Q1ldCAgAJIPtCAGz9OgIABBmmggAAmsoCADQV88A==
Date: Wed, 13 Aug 2025 17:44:29 +0000
Message-ID:
 <OSCPR01MB14647EF08573B0D26175426CEFF2AA@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
 <aHgVe0YwPWapIYed@mai.linaro.org>
 <OSCPR01MB14647DE009925C982AE6BB5D2FF27A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <64622ffd-05d1-43c3-85d0-cf98f3012477@linaro.org>
 <OSCPR01MB1464771054F720542F817E84FFF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
 <6e496737-3cec-425e-a4a1-29b576f8eade@linaro.org>
In-Reply-To: <6e496737-3cec-425e-a4a1-29b576f8eade@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|TY3PR01MB11624:EE_
x-ms-office365-filtering-correlation-id: 1302f7e5-939d-42d4-b310-08ddda910de8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWduLy9SV0xCUFl2YTdBVFdnRzI1N1NGUFVEWlBHdjlLVFZNQnoybm9DdzhC?=
 =?utf-8?B?QTV4bGQwSzlsaWpSYzcxL3ZSTnpSbTUvOU9mcmw4OVhxaFVuRmc1VkZUZTRs?=
 =?utf-8?B?OFkxdXMzYWl5ZUJDL2o2UXljZ3hKUlk0MFRXVWZpZjdBSW10TUZUNkl6ZDRu?=
 =?utf-8?B?VFlDTHBuekpUa3A0SDdjdUhsTFhpLzZ1cVlFMXlzSXlmZzhQV2tUQ1BBZG5J?=
 =?utf-8?B?UDFkMlBUVzZwd2tzaG9xSkxCN3dMOVd3T290MHlyb2xVazF1TVZ1OWswSmoz?=
 =?utf-8?B?dW9oeGJRRkpnVW9NMVZ1T3N1TCtmNGluZTJCRkEwVFA4ZUtFK2YxdWlpTDNi?=
 =?utf-8?B?bnpwWGlBbHYySGhqdVpYWHdObFlKc3NxbEY3ekxtMWdOWFRtYll2UGZxWmsw?=
 =?utf-8?B?L1BpTzJjclBKMUJXS29zTUZKNktZRkUzZFNtTldIeFdIa3ZLNjVIOGlGZUs4?=
 =?utf-8?B?YlFRTGtLcmYvL3RHV2hhTG9PemR0U0pwOHQxWWkwRWNicUNabEoxR0hJMDVM?=
 =?utf-8?B?YXJGY1hBbzhLcjhNK1BORk5zUSs5dlNDek54c01adkdScVRhb2pzL3krcTQx?=
 =?utf-8?B?R0J5cjJkZ2R0SDNCaU9ad1hFM1ZCeE82ZHlRWVh5SWdpUmduT2V6Y1JNVUt5?=
 =?utf-8?B?c0dad0NCMzMvM2dMWGVyYXN4NU8xVngydWVXWjhKOEFSME9MdHZlRm91UEp3?=
 =?utf-8?B?QUk1WmVxMnZkZjJMbDFZdmRIUW05K3o5WVZqQmw0d1RuZVN3ZnpXc09tbFhw?=
 =?utf-8?B?bjI4YnRyY2pHVmk3a25vRzJDMXpLUVVVbjhnMTdxWjMyUnZJRk9icmZya0Vo?=
 =?utf-8?B?T25ZaWV3bjVoYVhtQzVFK3RveGM0NU95L00rcDR3QTR1NWlXMkI0YzZURnB3?=
 =?utf-8?B?SFNJQVJJMHlZUUlRalVqRmE0Q3hjRXo1VEMxa21TZ011Y2U5NTNWWjZYY2VJ?=
 =?utf-8?B?a3VnVG1uV0Y3eTJ5Sy9JR0ZwTVBod3JJMFNnZGJ5YnRiMlI1cFEyU3N6ZmFx?=
 =?utf-8?B?Zkltb09Jc2pjRG1BQVR5REtCTDVManFDMUswMjFXNnhvQ1ZWUmo0cnNZWVI2?=
 =?utf-8?B?bDlnS3RqbDd0MFhVUXF3RzN5LzdEbHd0VXI5UGlyM2N0VzVHOXRRVm1vRVZP?=
 =?utf-8?B?dFhyOWRpVXlNdUFKRkUvN3FJQVZpMGRjMjhSRk1VSU9CM3VvWXgwcFFabUlp?=
 =?utf-8?B?YkdZR2gyRWtIVllRakl0RUJKWDRubXlrWWhzdlZ5K0dtWjEzbzZYRFRRUTJP?=
 =?utf-8?B?Vk8zYzE5Wm1SWSt1ZTdObDJRditzZklNZjBxaWdlbGJ2cXNFd3BOMGRsN0Nr?=
 =?utf-8?B?Y092T0JIeTZGelhhaGhEQzdvSXZFWHoreGNyN1RPNjhnLzIwWnRyQlpNYkVF?=
 =?utf-8?B?ZFM3eEk1alJOd0lUbVY2T1VobjlPbXdlcDgxaFFlVytzbE9wVFhQdTNYUlUy?=
 =?utf-8?B?b25pMXN6Tm9nanNHK21iVkdqZDBNQy9mOTg0YnNldUFEMStmMTR4ZjRKYTBW?=
 =?utf-8?B?WnB5ZUhPeWtjVThYOW9QOHp1b0I1bXpDYXg0ZnFSTm8rZW5ENjlORmlXV0c5?=
 =?utf-8?B?dnU1MXlmK3hmY2xIWE04MGp1NDN0QllWdzlPZnNIZ0pZQTk5elZzUUpoK1gz?=
 =?utf-8?B?OHI1bHlGeGFxVXpvNTg0b3FrVEluTEF6ZFdpRy8vYTV6Y2ZaMURKYjZDcFpq?=
 =?utf-8?B?OHNPMnFoMnFiLzN5SThxM3VQZFZMWUN6bmMrWGhHcWxjWERINXhUdXhaUk1h?=
 =?utf-8?B?OFZFZmg1Y0VucnRhOXYwL1QvUGR5Tm1UODRLQ1lPVUVmRGxlNmttdnlVTkVE?=
 =?utf-8?B?a21RcDJrdVpFUUNsT2UvZGVOUmhKbld4WVNseE40cWNFQ0dYZENNMlE2MEhs?=
 =?utf-8?B?WnVEcWpxR093QmNObXJVN1dsTlhMUnR0Mm1VVFFvRndubEl0bjJ1SEZtYk10?=
 =?utf-8?Q?hrrPzWVihAI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEtCa3d1eG13T015RDhZWVhvT0V2cWtKeTMrcWVhYWhYZHM5Z2lIUGhCMERh?=
 =?utf-8?B?RnAwVytzWE15SWFseW9DeW5YZUQ3dGh6NWRiZjNKdWp1QVczY0NzTmxWMGs5?=
 =?utf-8?B?LzludjE5bFJqcjhtakhET0hwaTY0d09HbHRQQWlTa3VHMVI5OUpFbGkydFJv?=
 =?utf-8?B?VjRKZzBTZHAxTDJ2aDE1TDB0WUVobTZNSmdXdkVwUTQwQ2syN0VwUlFEa0Qr?=
 =?utf-8?B?UjF0aGFBeVNQY1N3ZWFMbk1IaGkyTUtHdkl5LzNiQm5wcVZYaEpzdU1RRE80?=
 =?utf-8?B?MWM1MTFHbzhmT2JKRHRoZ0FHTURNZlU5bGJ3THZWMDUvYm9ZSFJITGIwM2RW?=
 =?utf-8?B?aWxib1ZobnZGVUx2bFZOSm1ndGZSMyt4SkxEdmRDMy9yMWt6eEFvMW1tYTFy?=
 =?utf-8?B?elU2SUtkb1hoU1JuVWxKZTZpM1NJcUV4NW1pVERJa1lXdXFkckhmckJVdU5z?=
 =?utf-8?B?eFZoWmNOWGo2by93OEpDR2UyVndCYnRMSkVZblFXckZDUDdkQ0dHOU8wbkRV?=
 =?utf-8?B?NVdKQS8vZUR4ZG1tZUdQUkx5YUxVclBkelUyRGhvdjZVZkc0MDJWN3hobXRD?=
 =?utf-8?B?VGtoZWZia25QMTBRK3B4N3NLSVFKbnNGM3h5MDI1eEs0eVNwekRLb2ZOMENs?=
 =?utf-8?B?dG1LMGQ2NUhLWHkxcFRtU1ZJdTJSNGdJNEpaaUwrRHRSZEFnQ0gwU3RFR2Q1?=
 =?utf-8?B?eXNpcjNkU0VZYVNwMjZ1eStSRnJHZ2hjbTRFTHpudHI1S2NVdk9rVldjQmZr?=
 =?utf-8?B?Y2ViYlBod3ZkS0Z6N1VMZDhFNlQ1N2FjaGpiYno3cFREYVZObFZMUnY0T1Zu?=
 =?utf-8?B?L0FhblNkR2tuelFhcndjU2hPRVNqL2QvcVRucHFzR2tYaXNtaHRrMVZ2bWNu?=
 =?utf-8?B?Z1ZZL2g1N0VodEpESGlpUkVjN1BDNm15ZVJZNTZUc0JtR1ZWb0ZJOWVuVkJn?=
 =?utf-8?B?NHorM2R0Q2dyNzNEdWVOdG1DVVk5aE5tQkd5WnVvOWVZaTNabk9xT1FpY0Js?=
 =?utf-8?B?M0JubnkzZFFHdkxhQ3ZJMEsrYzhkL2FWaStpN21hb1lsd2lqQm04Nlg4ZmFE?=
 =?utf-8?B?TXpWdGEvSFR2V1dpL2I2cVppaXN6WlFqYk9uKzRpdTREaEtqUEVGOFE5WkhI?=
 =?utf-8?B?d0RMV0dSME1IT1hjVCs1SkgxKzc2NTJiN3VQNlVYZmw5OXhzWUtOREtVdXlm?=
 =?utf-8?B?N2Zvc1VsYjFhMzhsQlFPMjNpd1pFdEMzK25lNXg0eTdCYlZWVUE0ZWlNY29K?=
 =?utf-8?B?cTN6aHZwSmJYZExnTmYyS01iTjFxQjNDY0VDbG1YQmtySWs2WEdMbVUrSXhz?=
 =?utf-8?B?cGVDZjdpcVY3R3k3QnNZMEZnOHdMS21lMTYxZWZ1TWtteWRLRDhaZ2o4Q3Bi?=
 =?utf-8?B?Skd3ZnVrUWVFQnhCWVc5dU5Va0Q5c0dQRzZlMHJvUTJTampZUUVDbWpaVkxh?=
 =?utf-8?B?VzRrVXp0VW1tVGpRL3lKbURqaHk4NzVaOHdvdVVwckkybFVmWjhOSjJ6VVNz?=
 =?utf-8?B?N1ZqS05tVWF4ZDhZRXg2NmQ1Rmt5YXFjMWpPeDEwZy82RjhFSG1yS29SQXk3?=
 =?utf-8?B?VmFFT3pDUnlLbHN3S2Q3MGtidEtQZ0xQYXBqL1JNMjg0cHpVZEgrdjlQaHRE?=
 =?utf-8?B?d3pySmErWnhlVkZ3UEdoTXRrN0pGck5nWHEzUHlqUHZKTjlSNkJEQjloQ1hJ?=
 =?utf-8?B?TFNmUDUxN0lZZE1MS3h5UWw1bzF5WFdZWjRPTk00K2hyYmdJTklsMWozMWVR?=
 =?utf-8?B?VUNhVmZxeEtlM29FMklHdlY3YVBFTnR2V0NpM1ROTzBnVDZpZzlBZHZSeERS?=
 =?utf-8?B?dHVTMjh6SGdPNzlhZEY2bVE3ZGxHQTN4RnVrRytSOVQyWG1mU3dBOVFxOHJa?=
 =?utf-8?B?ajY5WlVHbU5jc3piVTNmYnJYWVJ0d0xwa0dXNnNpdDFYaEdVTWgxVzMzNU9r?=
 =?utf-8?B?QVAwODFQcTdFQ2lhNUdQZ1hmU1RBeWVIak9KWi93RWRJbE5sVE1xemZRbHBw?=
 =?utf-8?B?ZEsxSmQwTXFhZVNqUkhsa2JDWGNPTFh4VEdVbjZ5czI1ankwbnpPSEMvWnIz?=
 =?utf-8?B?NTFKVHVMVlNjTy9lM0lxbGVsYWVOL3diVU1GRmZ3N1ZHZktzSHJwYko2bFNk?=
 =?utf-8?B?U1poQjZYMGNqVnhua1ZxUFJzNzhLRkx2V3FBRUIvQUxHSW44SUR6bFNOL1pY?=
 =?utf-8?B?elE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14647.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1302f7e5-939d-42d4-b310-08ddda910de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 17:44:29.4847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGpwNK2eTSqiyRFDGTdAIXgY0M1aBTvGV2Ns9MdhwtCtne+ds6v9r77304swFjYlcLb/trq5tpHpSfaX9W4wNTLpq0YQ5Es04icEZ97m1vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11624

SGkgRGFuaWVsLA0KDQpUaGFua3MgYWdhaW4gZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNh
bm9AbGluYXJvLm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDUsIDIwMjUgMTI6MDYgUE0N
Cj4gVG86IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NiAzLzVdIHRoZXJtYWw6IHJlbmVzYXM6IHJ6ZzNlOiBBZGQgdGhl
cm1hbCBkcml2ZXIgZm9yDQo+IHRoZSBSZW5lc2FzIFJaL0czRSBTb0MNCj4gDQo+IA0KPiBIaSBK
b2huLA0KPiANCj4gDQo+IE9uIDA1LzA4LzIwMjUgMDk6NDksIEpvaG4gTWFkaWV1IHdyb3RlOg0K
PiANCj4gWyAuLi4gXQ0KPiANCj4gPj4+IEkgbWlnaHQgbm90IGdldCB3aGF0IHlvdSBhcmUgYXNr
aW5nLCBidXQgc2luY2UgSSBjb21wdXRlIHRoZQ0KPiA+Pj4gdGVtcGVyYXR1cmUgaW4gdGhlIGhh
cmQgSVJRIGhhbmRsZXIsIEkganVzdCB3YWl0IGZvciBpdCB0byBjb21wbGV0ZQ0KPiA+Pj4gYW5k
IG5vdGlmeSB0aGUgY29tcGxldGlvbiBzbyBJIGNhbiBncmFiIHRoZSBwcm9jZXNzZWQgdmFsdWUg
dG8NCj4gPj4+IG5vdGlmeSB0aGUgdGhlcm1hbCBjb3JlLg0KPiA+Pj4NCj4gPj4+IFBsZWFzZSBs
ZXQgbWUga25vdyBpZiB0aGlzIGRvZXMgbm90IGFuc3dlciB5b3VyIHF1ZXN0aW9uLg0KPiA+Pg0K
PiA+PiBDYW4geW91IGRlc2NyaWJlIGhvdyB0aGUgc2Vuc29yIHdvcmtzID8gQW5kIHBlcmhhcHMg
aWYgeW91IGhhdmUgYQ0KPiA+PiBwb2ludGVyIHRvIHNvbWUgZG9jdW1lbnRhdGlvbiA/DQo+ID4N
Cj4gPiBIZXJlIGlzIHRoZSBkb2N1bWVudGF0aW9uIFsxXS4gVGhlIHRoZXJtYWwgZGV2aWNlIGlz
IHJlZmVycmVkIHRvIGFzIFRTVS4NCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vd3d3LnJlbmVz
YXMuY29tL2VuL2RvY3VtZW50L21haC9yemczZS1ncm91cC11c2Vycy1tYW51YWwtaGFyZHcNCj4g
PiBhcmU/cj0yNTU3NDQ5Mw0KPiA+DQo+ID4+ICAgIFsgLi4uIF0NCj4gDQo+IFRoYW5rcyBmb3Ig
dGhlIHBvaW50ZXIuIEkgZ290IGl0IG5vdyA7KQ0KPiANCj4gSSdtIGEgYml0IHdvcnJpZWQgYWJv
dXQgdGhlIGxhdGVuY3kgaW50cm9kdWNlZCBieSB0aGlzIG1lY2hhbmlzbSB3aGVuIHRoZQ0KPiBz
eXN0ZW0gaXMgZW50ZXJpbmcgaW4gYSB0aGVybWFsIHByZXNzdXJlIGVwaXNvZGUuDQo+IA0KPiBU
aGUgZ2V0X3RlbXAgZnVuY3Rpb24gd2FpdCBmb3IgYSBjb21wbGV0aW9uIHVwIHRvIDEwMG1zLCBp
dCBpcyBhIGxvdC4NCj4gRXNwZWNpYWxseSBpZiB0aGUgdXNlcnNwYWNlIGNhbiBiZSByZWFkaW5n
IHRoZSB0ZW1wZXJhdHVyZSBhbmQgYmxvY2tpbmcgdGhlDQo+IHJlYWQuDQo+IA0KPiBUaGVyZSBp
cyBhbHNvIHRoZSBzcGluX2xvY2sgdGFrZW4gaW50cm9kdWNpbmcgYW5vdGhlciBsb2NrIHdoaWxl
IHRoZQ0KPiBnZXRfdGVtcCBmdW5jdGlvbiBpcyBob2xkaW5nIGEgbXV0ZXggb24gdGhlIHRoZXJt
YWwgem9uZS4NCj4gDQo+IERpZCB5b3UgaXQgdGhhdCB1bmRlciBzdHJlc3MgPw0KPiANCg0KQWZ0
ZXIgc3BlbmRpbmcgc29tZSB0aW1lIHN0cmVzc2luZyB0aGUgZHJpdmVyLCBJJ3ZlIG5vdGljZWQg
YQ0KY291cGxlIG9mIGlzc3VlczoNCg0KICogU3BpbmxvY2svbXV0ZXggbXV4IGNhdXNlZCBzb21l
IGlzc3VlcywgYW5kIEkgaGFkIGNhc2VzIHdoZXJlDQogICBpdCB0aW1lZC1vdXQgd2hpbGUgbm90
IGV2ZW4gdW5kZXIgc3RyZXNzLg0KIA0KICogTWl4aW5nIGJvdGggY29tcGFyZSAoY21wKSBhbmQg
Y29udmVyc2lvbiBjb21wbGV0ZSAoY29udikgSVJRcw0KIGludHJvZHVjZWQgc29tZSBsYXRlbmNp
ZXMgYW5kIGluY29uc2lzdGVuY2llcy4NCg0KQWZ0ZXIgc3BlbmRpbmcgc29tZSB0aW1lIGluIHRo
ZSBkYXRhc2hlZXQsIEkgY291bGQgbm90aWNlIHRoYXQgb25lDQpjb252ZXJzaW9uIHRha2VzIGFy
b3VuZCA1MMK1cy4gSW4gYXZlcmFnZSBtb2RlICg4IHNhbXBsZXMgcGVyIGNvbnZlcnNpb24pLA0K
aXQgd291bGQgdGFrZSA0MDDCtXMsIHdoaWNoIEkgZG91YmxlZCAoZm9yIG1hcmdpbikgYW5kIHVz
ZWQgYXMgdGltZW91dCBpbg0Kdjcgc2VyaWVzIHRoYXQgaXMgYWxyZWFkeSByZWFkeS4gDQoNCk1v
cmVvdmVyLCBhcyBwZXIgZGF0YXNoZWV0IHJlY29tbWVuZGF0aW9ucywgSSBrZXB0IGNvbXBhcmlz
b24gSVJRIA0KKGZvciB0cmlwIHBvaW50IHZpb2xhdGlvbikgb25seSwgd2hpbGUgdXNpbmcgcG9s
bGluZyBmb3IgZ2V0X3RlbXAoKQ0KKHdpdGggdGhlIDgwMMK1cyB0aW1lb3V0KSwgd2hpY2ggZ2l2
ZXMgYmV0dGVyIHJlc3VsdHMuDQoNCg0KSWYgeW91IGRvbid0IG1pbmQsIEknbGwgc2VuZCBhIHY3
IHdoaWNoIGFkZHJlc3NlcyBhbGwgdGhlDQpyZXF1ZXN0cyBmcm9tIEdlZXJ0IGFzIHdlbGwgYXMg
dGhlIGFib3ZlLW1lbnRpb25lZCBjaGFuZ2VzLg0KDQpJdCBpbmNsdWRlczoNCg0KICogODAwwrVz
IHRpbWVvdXQgZm9yIGdldF90ZW1wKCkgaW4gcG9sbGluZyByZWFkDQogKiBObyBzcGlubG9jay9t
dXRleCBtaXggYW5kIG5vIGNvbXBsZXRpb24gYW55bW9yZQ0KICogQ29tcGFyaXNvbi1vbmx5IElS
USBmb3IgdHJpcCBwb2ludCB2aW9sYXRpb25zDQogKiArIEdlZXJ0J3MgY2hhbmdlIHJlcXVlc3Rz
DQoNCldoYXQgZG8geW91IHRoaW5rID8NCg0KUmVnYXJkcywNCkpvaG4uDQoNCj4gLS0NCj4gPGh0
dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJl
IGZvciBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29r
LmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwNCj4gPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9s
aW5hcm9vcmc+IFR3aXR0ZXIgfCA8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby0NCj4gYmxv
Zy8+IEJsb2cNCg==

