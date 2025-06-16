Return-Path: <linux-pm+bounces-28789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB6ADA9B3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638361896A2B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413741FF7DC;
	Mon, 16 Jun 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iDOh/Zpd"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B413595A;
	Mon, 16 Jun 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059765; cv=fail; b=Epak5KL58GljyjQsq4YMTlqkdv995+nE8jOPA6BVRb4/hCnsmhPAB6fd4Mns4kotEkP+70bU9jYWq9E52QKL4zAwDp/usifWpw1KXTTAStkrzYx757v/vigY7cJEWqsCPpv9awkQPF+VYUnOh3EABpHmTxughYCVkW9HXAqCiks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059765; c=relaxed/simple;
	bh=KHJcntmFS6JM5EKc+xmrkmHIqxPdk5Fw00njv6T9ejA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQ164s2Zi9ATaYy4DTpZlgG3CDl/sSjzbHsNWVg2iHgQCpOTz1CYfJkKLl0ZRuG0mN+njPOh387f5CeQEz6LeWJCTH/FH8wAzNvCC8ddf/upbkKcfOy7AE6TdVqa0MVRwqpxl+VWB+ZXH0Qnn/1eGeo4uRs8VOS9iCMPR1nGTnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iDOh/Zpd; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJFxfo1Rba7L0jrjKXHpDDdrgjzxDdlcUQ99Ay1+SAUSlJ8JfPOl0Z0srF0Hj8RqEKe1dUwtr8OryZ4gkstU/rQEq/yLE+USUYf3LpC1LAgk0WQYovQmbEjbW/iU8FdLLy4ZHML8vvL37ioKc7GI/vb/9njl9x+L4O8t2JZmXMwuPkvjeRTY9vCswQppKRE+xXJNfP+ProPoFJYe6e56pI6T/zOCex6NYotdVwnOZxgTqaR6+ffZ0Xy06x/KiLYj7XHrwOErsZdfJA5sqYYZcxfL6YglA4Pj6TyNMSzT3LrO+Uc4WCap+3VGc/REW+iciSLW6G5UQQa+oQRA9F0A6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHJcntmFS6JM5EKc+xmrkmHIqxPdk5Fw00njv6T9ejA=;
 b=EkVhOR0QncZenFQU9dW55QkqsQBNfrGT9uOpCv8TNqSSgUaQ5t4a2IoD53FMr5Mmcz/arvx+/UFAaFYtHVDQYvP9PmkGw21qFPgE/pGrW8q5qb2AybEU3Gz0y2Bg3fCHKc+8M59isy6h15tM+UTW2DOx8+SkbPIplfzk/R1h25vbbGYOx1V0La4F7FTqPL2mkMfgbyy72/vyPvH3sGierFSgGGXhGd99DkHMoJy5tCrbxwF17fodgBbeCOCLIZWpv/cxz0gvrPeScSnWucCpHbuWxPtS5HUBPJRrNO7XPY31muu6zRwXYEO4g1K0r0sh95AwJY2itTsCBP9z0z0N3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHJcntmFS6JM5EKc+xmrkmHIqxPdk5Fw00njv6T9ejA=;
 b=iDOh/ZpdXaVhRAIk+bxIYxWWyP7+gwkdMxzZMiY+TP4cE6gaHGSem5dNfLlCsapF9snSqx5mt6nLXDwQJ8LmZbHcmVz1nla+CuEZVTWStIujnEBMJ/YMuH99Mn3Wuf3bdhEpSvbs9m4lZJyGsK2ybD7KCr/59qAu8c2aSNGH+oa8dcpGcOo8jIbVfeUrgm5W42K0PR7wF5QR10gnUojyCnY52SzGVissprwIUV19NlDtjpgM1hksp+sYUVFSScqaMkCAyhEPYxs4nYM/6pr8bjAV01wZGniUiPMDngiVteI58UgTEUK/9w1Sc+bpjui+IIaB2qRJ3BxN1LoqTazKiA==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GV1PR04MB10349.eurprd04.prod.outlook.com (2603:10a6:150:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:42:40 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 07:42:39 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Ye Li
	<ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE:  Re: [PATCH v5 1/9] dt-bindings: arm: fsl: add i.MX91 11x11 evk
 board
Thread-Topic: Re: [PATCH v5 1/9] dt-bindings: arm: fsl: add i.MX91 11x11 evk
 board
Thread-Index: AQHb3pI8Co8kOzjYZEu2GgHRQn77Cg==
Date: Mon, 16 Jun 2025 07:42:39 +0000
Message-ID:
 <AS4PR04MB93869345F739436917920F59E170A@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <20250613100255.2131800-2-joy.zou@nxp.com>
 <20250614171642.GU414686@horms.kernel.org>
In-Reply-To: <20250614171642.GU414686@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|GV1PR04MB10349:EE_
x-ms-office365-filtering-correlation-id: 7bd5b324-25be-4d82-257d-08ddaca95ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cTVEV3JUWnQwYnVjRGcwai8vaks5Mmh6Zy9NdSs0c0VhdzU1TmoxQ21ZTExR?=
 =?gb2312?B?b2JQczFGdkVTMUt1SmZUSHVkTW1IOEd2c2p0NWZnQnN5cUI4ZUdPWlUrWXJ4?=
 =?gb2312?B?MmlLcjFiU3M5TS9QeDFEUFNuMGtCclpLZ2hSRytwbmxEQW1mODVBb0IrRjlM?=
 =?gb2312?B?TlZoTCtESk10ZDVuRnBCUEhpWllZRE11anliNlFQTE4zVVpycFN6ekdmb2I4?=
 =?gb2312?B?Zmh4L0wvSWdNbnNkQVFScjkrd3JmRlR0Ti9lN2ljcnRBeUNWc0l6c1pEb0Ro?=
 =?gb2312?B?b2kwMVlWbkJxMEZwS1oxLy81bEc5REtKVXpkREFDRzhMUURYck9aSktHajRo?=
 =?gb2312?B?bjZIT01pYmlVempZbisrMGFVbEhsOU4rdEVLUjJwTFNWc1FZbnFBK25YQXlH?=
 =?gb2312?B?enY2Ky9lMkV0SE4wcFZQbzFoeHl5QXVZNzFnTFpuTTRmV0xTMmVRRnM2Q1ky?=
 =?gb2312?B?aGNaWjZBZ2NteWswWHBNNHdqb0V6RTdGUzdwNTNzdS9MZzA4MEtSWmZEQlRs?=
 =?gb2312?B?aVVkRDZLRnlBV3NYUWpWRm5pczNNS2tqbjhwOHZ4YVlVL2w4OGx5SzR0L0w5?=
 =?gb2312?B?aHJyMm9ubWhraVY1WEZBUWRDUmkraWdFSGZWR1FjeFQyRGJTS01ZOHdxaUVj?=
 =?gb2312?B?OGMzejRvUExVYldBQ01jclVmcjgwelVMblhPc0pOOGhaTmRzcEtJWWhvdGdK?=
 =?gb2312?B?U0lVOGdpN3J2bFQveVg3K0phdDVHSzUwcndmK0JTdkg2SURoemRmL3dyRjFy?=
 =?gb2312?B?blJtd3pzdlFvZUZVaWN0RXJYUjhmODBkT0J0VkoyTzhLNURuVXNSc0pJK3E1?=
 =?gb2312?B?bDBCbjJLM2pPNGdiUnc2YUpwUlJZeXJncmRXaG1vbzFPbFpEaFBiaXZjSGh4?=
 =?gb2312?B?Z1MwY0VQZHU2TkpSVTNvd0c2czJIV2hIZGlKaXNLclhJM1BZc0hPaVVWMnhy?=
 =?gb2312?B?cmhlK1R4MGorUldJQXcyRURkVVYrZXBjM2NiNWJqTGk2Y2lFM1N1Q1RaeTJq?=
 =?gb2312?B?cERIV3VSNzRhRzh4OVdDZmk4Q2RlVlVPNW5QZ2MyK3hhSmJoR1pzOVltSWFL?=
 =?gb2312?B?VHp5Y2tQRFh1cFo0bVlXZGVSa1pOK09pUVRUM21vTlNCNHJNNXc0Q0NEUlVT?=
 =?gb2312?B?aGx2c1kvNFJmeWlkcWp5NzJnVU1tQStzdGFFcjQ2RmNNVDhhZC9jeHVyTUJu?=
 =?gb2312?B?dDVIelpVOWFGNHZJMDB3VEltOTBFNjlEeVBOTlhiSm9PNlpkRTJIODNtS2Nh?=
 =?gb2312?B?Nm9nUUhvNWdadVpWZmowRnQvNy9CcjAvRCtGTUlmSVk4RXQ1OFp4UHlOOGMy?=
 =?gb2312?B?K0x5OXJWdHh2WWRqVC9oZlZ2UU9GZWZkVlJLWkNGeGhiVmJuQ2g1STluOHRk?=
 =?gb2312?B?OGhnZTBHRW1BcVlpS1ZkUlBkNW4xUnZiZ1dxRVppbStQb0xEY3pqajBzU0Rh?=
 =?gb2312?B?dHdUY2Ric2hKMzh1bTI2ajl2OGdyV1FEbmMxbWJWWjNRSC85UW44enVHTjlF?=
 =?gb2312?B?VGc5SlozcU45QnFmOGZ1TGx3ZUM5RTl1VDYzT2JXZ3FBNWJqWG5kQW96dzB3?=
 =?gb2312?B?bXpYWmhUTEhSSkdDa0FoS3dxckdtTS9HcGFSRXFvOXZ4WWZBam9MSXNLckx1?=
 =?gb2312?B?ektwVHpqMzdlNUJ2a3I0Y0lsb2FRYUllc2ZWQ1V2aHdub2FIaGYyQ0NBbmJT?=
 =?gb2312?B?cmdjUUNmSUhmdzB2QzlOQ2M2bFBOeVlJdlJObFA0VjBLUUN2emlBRHllSzRE?=
 =?gb2312?B?clJjTzUxZDN3NXFWdEs5M1EwQmgzZXRJQ1YxbndKK2lxSzlxTk5xayt6U29o?=
 =?gb2312?B?YjVmbGFHOXRZMXQwZ3dUZnA2RVAzTU8za3VZcmtzRCtGbmJ0U2NEZnVDOTRL?=
 =?gb2312?B?Z3lrcm4rNFV1dE1TRmVYZWRNQ05FN2c2UnlUNlZqSnFQcEhTOUhURkErVVJk?=
 =?gb2312?B?SnRreDFZSTlmVkxzSkVqMUZxWWRmUkJvSGVDckQ3dWVMdUV5UEMzUDIrVHFH?=
 =?gb2312?B?OUNOc3hXbzRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bTQwM3BVY0lQUllob2hjc3psT3pKVVlBdjRHR0ZweFhlMG9sakFDcmNwbURS?=
 =?gb2312?B?amFLTHF1NittYnpnbXh3WU1uZmN5NkRYN2tpL3hURnNSZDIwMVYvN2g0SUti?=
 =?gb2312?B?NzVGbmg5VU9NN0s3WVFuR3ZtTW1LUUJROHVFa3ZLcGNLWTlISHAyWG5MWlBl?=
 =?gb2312?B?ci80WU94cC95RE9BbFFnZmUxa2JORkpWRVVXaXRMVG82ZmVUTERTemRDUW9k?=
 =?gb2312?B?RmNxSVlmN0Y1SWVtbXJvbkN5OHQ5bFlEZG13TWZzYTBZaitoZlpxamU2VENm?=
 =?gb2312?B?aTA0cnEwZ0ttTFhoRHVOeEtZRXhRSTUvV010UTBVUnJDQmxKc3FQenI4cTJZ?=
 =?gb2312?B?alZ6S0prdEwvaUpwVzFwMDZQbFRrUUZPMXg5cHZhOGNaNkZrSlRndFVzSS96?=
 =?gb2312?B?MjdGbWVqSllmUHJQNldzcHpIalRnejVRL1ZpVXlmTGxHYnhDRXloNGFhWStW?=
 =?gb2312?B?dUMrMGkyaklMNUg2MmRBeFRCM09jdHlLTzdEcU9Xc0xMblhhWGxoSEtwR1Ba?=
 =?gb2312?B?VlRza2pvVTZXMVFtaW5lSnVPa0NVb2ltMXBlUnJucHZKYnVkQXh3YXJBMm1l?=
 =?gb2312?B?MWlOeVNHU1RjZHN6cDB3U2lmakVQU254ZmV0K2dBZEt0SHhkZk9IZjJ5RjRz?=
 =?gb2312?B?YXNHL1NHa3FCUHp4a01KTkdhdW14eU96Q2pjc3g4a1pnWnQ3cFFHMnJHdTlw?=
 =?gb2312?B?U1crU3hiYnVwZzV6ZnZyamJWSDJ0c3hxRWFLVVZ5TnQzYzhTNzV5NTNUYkc0?=
 =?gb2312?B?ZzZmTUR3emtsNWM3TitHTHhSU0k4QzM5QkdkTmc0QW0xUVRwNTBURjJMK2dt?=
 =?gb2312?B?UnBNVkdBa0xJMmgrZUdMb0YwdTQzWXVaaEJ2VDd5bTNtU3lUTHI4ZWxOdHFp?=
 =?gb2312?B?Wkg1Q2RwN29ZdEhIdXE3TFJBUXhrb1ZyU2ROckNrdExrNjZ6ejZPcTVTNU11?=
 =?gb2312?B?aW9YYW1vTWRPMDNuNUZvNDIxYXZZQkk2dm5IT1ZqL2MxWnhCb2paZFB3d1M0?=
 =?gb2312?B?TDhXeFRleXhZRE10QWhFY2liUzZmOC9UVVZQZ0c5WTR3MUNXRXNBUW9pNFhH?=
 =?gb2312?B?bEYxTG41WlVHZEdsdDNKR05yQnUxVGxWc0JPMmpJaE56amMrOWQ0RmEzSEZY?=
 =?gb2312?B?dHVNa1FsQ0ppMSt5eXBRUjcvQ0xyUlhRUGJxbmJRejNyN1ZhbjFBQTFsdWNk?=
 =?gb2312?B?YTZ0eERMd0RpQXFtSE5Dam0yYUxicnZkeE0yVFNreXFEbkJsbC9aU0hxT0oz?=
 =?gb2312?B?bXpxdkY3M3V1UXIvQmp3by9WQnJHa2xKNC9tV2hLRGtqZlIrM0wyU0lwd3Jx?=
 =?gb2312?B?N3JFa3Q0Mlhtb3BxMUtaVWliWklsVnNwZzY4T1Y5MVJENXZyQUgwa2NnSHBp?=
 =?gb2312?B?Tlo2MVhseFNhWk5DNVJyNGFoSG1tRXRabmJKTk9LZ0VNZ1BPT3JpQWF1YVJ3?=
 =?gb2312?B?cmhnLy9kS2Y4YlFtbnRZVGNhc2ZWS09DejN2REdBV1lERWgxalg1eVphU0JM?=
 =?gb2312?B?QThWb1liVHorSXNJaFMyNmdndmxLUit4dUtJQmZUK3lmampNZFo1bWVTb29y?=
 =?gb2312?B?NmFHaDU5Y1kwcXcveGtiYVprY0pJdGczNnBaOCtCekpZSWQrUU9QekRJZThx?=
 =?gb2312?B?My9HWHUrZGY3NnBTcCtydVRqZ2twcXFCMDFCL0k1RlNmWHRUQWU3bGRLV1Ux?=
 =?gb2312?B?ZlMycFF6OTc2SlhnbnFtdGtGU2hTZy9sZzE3Mzk1S2pkNDUycm93SCs2Yktj?=
 =?gb2312?B?a0tOUlJuQlVKREhsOGlMd2UzT3dBRXlscWN0ZVB1dndQa1k3d0R4L3hDTzdG?=
 =?gb2312?B?UDlCaWE5eW1lMWhnVHlvVmkyeWtsZDZHZ2FXalhYVFdQY0hjRjgrYXQrSVVL?=
 =?gb2312?B?RmhweU4yQS90SllJUmdlcVlFSmFNK1ZXWjNBTDVOVUhNSmlpK1NmbUlnYmd5?=
 =?gb2312?B?dklZU1JPdUxtLzNhVmZaSWlxZytlNEJJek41clJmd2pwWGNucmh3eVI1ZmdP?=
 =?gb2312?B?VC9FYXk1VFM3MWJZWEVUS2xnUm9TaFFzcEZCV0h2NXRiZVlESWRLcTNqWEhz?=
 =?gb2312?B?SDBZTGk5R2dFUTBoLzc1NGRycVZXZmlFSjdxYjZRcUR3OU80anc5dTZ3ZFp3?=
 =?gb2312?Q?mh1E=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd5b324-25be-4d82-257d-08ddaca95ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:42:39.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URHLwgMLdVraA0ju2KOY8oLyRgh+Q14yHmdf0tmKCbPeCOd2XqVVbMrawua1mj6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10349

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbW9uIEhvcm1hbiA8aG9y
bXNAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNcTqNtTCMTXI1SAxOjE3DQo+IFRvOiBKb3kgWm91
IDxqb3kuem91QG54cC5jb20+DQo+IENjOiByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVs
Lm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207DQo+IHdpbGxAa2VybmVs
Lm9yZzsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBlZHVt
YXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOw0KPiBt
Y29xdWVsaW4uc3RtMzJAZ21haWwuY29tOyBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tOw0K
PiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxp
bnV4LmRldjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHku
Y29tOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7DQo+IEZyYW5rIExpIDxmcmFuay5saUBueHAu
Y29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+OyBKYWNreSBCYWkNCj4gPHBpbmcuYmFpQG54cC5j
b20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVu
Zy5kb25nQG54cC5jb20+OyBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS85XSBkdC1iaW5kaW5nczogYXJtOiBmc2w6IGFkZCBpLk1Y
OTEgMTF4MTEgZXZrDQo+IGJvYXJkDQo+IA0KPiBPbiBGcmksIEp1biAxMywgMjAyNSBhdCAwNjow
Mjo0N1BNICswODAwLCBKb3kgWm91IHdyb3RlOg0KPiA+IEZyb206IFBlbmdmZWkgTGkgPHBlbmdm
ZWkubGlfMUBueHAuY29tPg0KPiA+DQo+ID4gQWRkIHRoZSBib2FyZCBpbXg5MS0xMXgxMS1ldmsg
aW4gdGhlIGJpbmRpbmcgZG9jdWVtbnQuDQo+IA0KPiBuaXQ6IGRvY3VtZW50DQpUaGFua3MgZm9y
IHlvdXIgY29tbWVudHMhDQpXaWxsIGNvcnJlY3QgaXQhDQpXaWxsIHVzZSBjb2Rlc3BlbGwgY2hl
Y2sgdGhlIHBhdGNoc2V0Lg0KQlINCkpveSBab3UNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBQZW5nZmVpIExpIDxwZW5nZmVpLmxpXzFAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
b3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4gQWNrZWQtYnk6IENvbm9yIERvb2xleSA8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiAuLi4NCg==

