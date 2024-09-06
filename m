Return-Path: <linux-pm+bounces-13759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936796EC85
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF1BB25C3D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA81547DC;
	Fri,  6 Sep 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kjOcA/eJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BA3C463;
	Fri,  6 Sep 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608887; cv=fail; b=aycveDKbxXSXfLktULSvUYkX1pnWFaFSXLxCuAFzDSpABoEn02RYrK2mkNBE7i1dATYu/OPJNk1tY95AFFNaYtCVHepacokvfaRxd4TCQNG67jJVSSoGJiGBGKRV5nX0+dxGbfQD9y+5A8x3IXlIxF1vTAySjE3KnJgKikNgLTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608887; c=relaxed/simple;
	bh=n3c1lWdZ2gsUSCKqC23ii0Oatzr/cXClluRG0SS5xEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eyfregp1NZ7nlhT2YEpKHYgSKRUAwDSy5vKq78TWkwsuiVz5H69cMqmb80fvZ5DWVBfxNF19HAdHlaqGQM0mmnVO7Nq9su4OBs3e/T3nGnlgALzreuqp3wpYAEzc6HCqOcF3lbYK8y3pYkWD7msBthYxWnYdnTI9v8+fD8Y6wGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kjOcA/eJ; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTpLfNmxX+NUYePxViE1c2P7+5q3Um7i5j78yMGBKegn9Rb41Fi6mruxidICo+Zu3JlZmWRswp8nYr7bUO2Soi1S6cnAybtgXtHk7OJVX4DNZkZmnvgwX79lktxz4VSIRF5T6YPXvRdaGItD02q+3feMLjV3aXBd1RCAJdRw2Cul0N9OyWBv4OmwcklS1JEVrgET19wwLoiS2cwTqCXPe2tU7GMLyp41mtPXzWSrxA7W8mzHGAmnE0I4DFuWFzHZd3Zgd5W0Lt9wSzbrWrFjTxQy1iIdrs810gysPeREwt4vkOwFqu+Q6FIo6yF8FeKkjbll5TN2jlYJg+GfOrCbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3c1lWdZ2gsUSCKqC23ii0Oatzr/cXClluRG0SS5xEI=;
 b=o+cL0bWTMsV0OESwTpReZf/4x7bnya5CwwipYRnZWJU7bIvWd1bncS3dKz5QOJt604v8Nd0QQyUzJSvgA+Cqg5nWncuXUGI92yCdUudszTR9WgWm00y2lDYrHk3RqD0te97Yu6ix3ScpVSzuEcOUWO7M/gH9Z6qmHhiyJIWtf1WKn9KY93IZ3pbEXOj4jjwMjL1ncDiMZla+nrRU1bnOs3z84z8SyEZBXeQSOKinOo7drhkzGmoXPmCQm6WXeDnFN6cXZSXDqQ1Y4s40Q8sbMuXMf+7gHGpQHE+4ccaPZ0rjL10SDxLjt8/vhgbxby+ua076UZMvhcnNyu6mH0yRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3c1lWdZ2gsUSCKqC23ii0Oatzr/cXClluRG0SS5xEI=;
 b=kjOcA/eJWJlKlnvQwqRXUBRGJ59TzbgrqaM1L7kOYtSHIAKeE/g31DtQljhBvjZHpLfw6BlKi9qoSP8LvWTsuFO7sufKHekbquQzVTQFfP9pgIxu9hvAmg62haGQQmWekkQou7QhWTk1P809IMbJT2bcqhBhcCSNBWV1JGdWClotBDx1de0H0fuGcGkaHdB3wJvN1vAPIvvqS3N5ZPIOhEjmOnIebJti5zdEuKIcUxJtoa/zsNnrEvhQzDI3VPI1smLECXX8agocEvkmrPKPrqRZo44qugCgcNNt0AvN9hweNzwtsF7pSSIIVy8Zta7CiMIUH3zz5ItQh5/nafF63A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9726.eurprd04.prod.outlook.com (2603:10a6:10:4e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 07:48:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 07:48:01 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Ying Liu <victor.liu@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>
Subject: RE: [PATCH] pmdomain: imx: imx93-blk-ctrl: fix power up domain fail
 during early noriq resume
Thread-Topic: [PATCH] pmdomain: imx: imx93-blk-ctrl: fix power up domain fail
 during early noriq resume
Thread-Index: AQHa9UEOaBOLRMgGwkemUKRgbs3/57JJc0YAgAEBjWA=
Date: Fri, 6 Sep 2024 07:48:01 +0000
Message-ID:
 <PAXPR04MB845978002DBA02B596BBDA54889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240823095319.3917639-1-peng.fan@oss.nxp.com>
 <CAPDyKFpYgZwNvVnpS0fjmhcEq+yiBizxDTw9nJEyQF287miFJA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpYgZwNvVnpS0fjmhcEq+yiBizxDTw9nJEyQF287miFJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DUZPR04MB9726:EE_
x-ms-office365-filtering-correlation-id: ee2874cb-92ab-470d-7754-08dcce483b98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEltSTI0ZnAvR205SjFvRUVjckR1M3dCOWcya1VhZnpnR2w5cFBmZExmT1pw?=
 =?utf-8?B?OVlOc2Z4NnE3VXJOaTRCbG1zMjBkQUVEeWdyVmpNejBnc2ZONFZ2Rk1zOW1o?=
 =?utf-8?B?ZElKZHFnV3B1YXZva3dZNkxWcEZkVkJ1TVZoVE9SRVdsczFhREwxYWYwTFVa?=
 =?utf-8?B?NDJGbytJMm5JMUxkOEFGNUM5clpBMmhyaWN0V3k3SE5PVWUrVW1nUW5pcVNN?=
 =?utf-8?B?amQ5dzZNRGw2c1hzZEpSSG8reTA0elZEcHZnQmxpRTcyaHRuMkRZamQrVXhl?=
 =?utf-8?B?TGFJNExoanRPY1ZmMnNBR0xjamg1VVRJcFM2dGY1ZlVBRUptYWxkY2J6aEx2?=
 =?utf-8?B?TktydSs5QU5ONkI4OHA2amx2cDM3T29Xd285T2dNeUZGdzVkaUdQdURmNC95?=
 =?utf-8?B?QkJBd1NoN2tSZWRHUkxVQU56alhCMTdnNHBTVENOYWcxY01yQTlTZWdNY1ZZ?=
 =?utf-8?B?WG9TU0NiY1lMM2kwcUI1THVJNmRiTkUxWHhwNUhiRmwxL0h2TkIyUDVtN1Ew?=
 =?utf-8?B?ak4xanNYUzA2S3VBVEQvVzJ5a1JwOTZGd2tMcFJTNFhYbGZvR1lEMytLbTNT?=
 =?utf-8?B?dUN0SDBXQlEvMmxEU1U3WmxFZm9LWE0zSWo1b1VldWgxTUhoZlRsTDluNTM1?=
 =?utf-8?B?UzFIVDRpNkM5enBxQVNEajYyRm45Y2JkQlF5akZzS043a1hOUFI5c1k0TlJ2?=
 =?utf-8?B?RHNTRytxVU5oNjZmRWY5elplbDRINDNLR0h0aHJXTWJSa0NrNEF2ZHp5L3lt?=
 =?utf-8?B?R2RxbitxWHBES25hRmpHa0Z4UFJTZVp2a21wa1RIckFrZW1zbVhEU2ZhSDV0?=
 =?utf-8?B?S1REZUd1RExTUkcxN0hvcDBRdzR2bjF3ZU11Z01jU2F5L3BWZ3ZSdmZuak53?=
 =?utf-8?B?cXJnTmRhOTJGcURqRHg3RE9PdWJ5VVFwcVpaNDhiS0NFbisyb1d6em85emJh?=
 =?utf-8?B?aEZ5MXFhNWY2akRYOUZtc2p3WHluWjljcGdYcmpocFR0UXAvS1UzOU9BdXkw?=
 =?utf-8?B?Y3JVeHpyYjFIMWwyb2ZSb016SWVtVkd3ZHkzcWlvVjJpeWhNOWlzS041SDNP?=
 =?utf-8?B?cjZycmhRMDlsK0prWGVxWjdndUZvWEsvQWtnTHVMS3JQMzMvYTFmU0RoNE9L?=
 =?utf-8?B?ZDNUL2lOSk5yUWgwZUxNYW5GRjJJYXMxZGtHUzU3M3V1MFhsTDRvSThGazk1?=
 =?utf-8?B?a2I3OEhmMjk3eWRHc2VYWE5nU29ZYzVFd3JQQmt3c3IrYkt4RFRJMjF2RDFG?=
 =?utf-8?B?dWw5d3BZdEJFV0o0MktBaUZWMVFaTU96a3VuMFFzSkIrRVlSM21adjVTYVE5?=
 =?utf-8?B?RkkvTktTZHlIQlVXc3p1cmFMRVNLVWYwVUZMYi9DRytRdC91QjNlaStPb3Zo?=
 =?utf-8?B?bTFlMTZJQlBxYWh2VHkrY1dIVHJuUGpwN3NBSi9BLzlFRnJnbm0yZndEeHQ4?=
 =?utf-8?B?UXVYY0VkSWptTVhZK3EyL3FMVGoxUDJ3ZWJBNVNQc3JacDJ6T1RSc053M3BC?=
 =?utf-8?B?OFRsNkgxR05CeUc2aVdxbWtpMXBqUjZXdHJSK0hibVJ6VmJkRkh0Ti9uNTBP?=
 =?utf-8?B?ZkpQWUVXSWx3VDl2REw2MW5ZWitja3VTTG8vZStYTXI3NEx5M3FUeXRHVElU?=
 =?utf-8?B?Wm9nSUVSU282OTZCUWw5K2ZlaGVrZ1c4YUdzdXNMN2xSNXFNa2FNTEhMNkk5?=
 =?utf-8?B?T25NVGUyUmsyK040WlFpVnNHSTY4MTd1bEV6bkNUNjhKU21BQ01tT1BjeTFJ?=
 =?utf-8?B?cGxRMHMyaGF1S0R5b3pOUGxveVNWUzZkSUlaYXZ1eVlhdzBvWEhXMWs3b2N1?=
 =?utf-8?B?YjF0WDIzNTV0akpQdUtMU1p5ekZ1eUthdzY0RXJ3Ly9MbEtjZ3V5TUhxVGNT?=
 =?utf-8?B?b0M3emZlVkFBaVRVWkpNVUZxeS9MWFpFYXpPMkFJbXNqOFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGtvdG8zTDJZYlJucjBVYXE3QnM2Q2hkKysycVJEb00yT2lVVjB5M1l3dnFR?=
 =?utf-8?B?U1R6bzhoa3Rqczg2N016aFdwREJ5YjAwNW9jQ0NYVlZLZ20ra1hjdWJMMy9V?=
 =?utf-8?B?T3pvMGJoTW4yN3J4MThVb2czemVpclY4cnRqUGtHMU9FZkVjdDhBeVdHSXc5?=
 =?utf-8?B?TVVNWmRRRysyOTByc0JaM0R3RHBjSTJGWnRIeHFQT2VWSFByL2xMSGd4M0Zj?=
 =?utf-8?B?QnphQlY3WVNWSndYcE5iNDZvbHJrZXBDbnVrWGdOZGljdlltSWhQNlJrS2pn?=
 =?utf-8?B?c1NRcWFqbDU4ZTJVeW1pdmQ3ZktGQjUzc3JvWjliWEwzMHBMdExTVWRrSlgr?=
 =?utf-8?B?TndLTlFBSG85WjZqZmNpR0ZRcUdqRzJoZFF4SjZjOGZWVG55eXFxdGFuYnNU?=
 =?utf-8?B?NVlCNGlvSUhKRk1SZTZOK3dhcTVTUTZwL3VrWnFUNW43K3kwcjlabkdKS0N2?=
 =?utf-8?B?aC9kTFJVOU8xc1NpUTVoSGlCWDlnM1JpS0lNYmkvSFRvODVVcjNZYzk5bmZl?=
 =?utf-8?B?aGFUajVzQnRRbm5SNjhrWmozQW4vMzYySkxuNnZqOHkxcnZoT2VxWThBWHFD?=
 =?utf-8?B?ejIyUVFRYlQyWVpUYnJ2b2hYUlJCS2hlRlE4emhUNVVqMVUzaXdEWnhObkhP?=
 =?utf-8?B?Z0VDcGU3NlhxcG55VVJ5akcrWWN5dkE3SVd2ZUQ5ZWtJeG9kcnVpdEhSQXJm?=
 =?utf-8?B?QldEVmhzN3ZOSkU5QTdNeGtXdDZjalMyd2VZVTU5VnVsN1NJMlNaSmJOVkor?=
 =?utf-8?B?YzVOdGVFS2tBR1Y0M2tGT0tOT2xHcEdIVTFEaTBwY2x4aUpNRVJRSm4vMDE0?=
 =?utf-8?B?M0RoRENxQkNtS3VuZjVXV1hXRHRkeHRJQVdxVXQxdzY0b0pML05OKzJUdEpE?=
 =?utf-8?B?QkNuS3FwdzZnTFpuTGZsTE1UYWRlMDh5MzlmcWVCbTVGZHMwOTZMSXgrUDQ5?=
 =?utf-8?B?ZXR2bmxmQzM3RURmYXpkWWQrOWlXZFIxV242cXB5aS93c3UzSzdwbUorMlpn?=
 =?utf-8?B?ejZFMFh5YXlHRG9sanBpNC9sbnlUNXBXR1cwN0NjckVWMEdIQjd0VXlVcFFH?=
 =?utf-8?B?OUVjVEF2SzFybXJWSTE4eUprbnA1RU11ZjNyZHlsSE9qa1RpN3kvL1hrb0pX?=
 =?utf-8?B?Wm9ibWRWUWRWV1dtaFc3bk1ua2R6MkRkNm9pUkZDSmozUFhRRHd2eDZsTThN?=
 =?utf-8?B?cjRzRFluY3JLM2tQSyswWEhXZ0VvVkdacWM4dnUvd1ozMUdielAzMUI3NGlU?=
 =?utf-8?B?QXkxdkxRNURHT29SbXRpRDc5TDRoV3ZEY2xWV3IrZzFXbmx2a3kvcnZLOEN1?=
 =?utf-8?B?V3E0TFBsMDR2UDVCbkorS2V4cmFKT2lMT1FnbklwdWhxN0wxVmdkR0I0S0pP?=
 =?utf-8?B?YWdsVy8walV6dzJ6Qmh0dktObkxRM0NFVFpEbXU2TE9udXd4RHpFcDlzOW5y?=
 =?utf-8?B?RGRRc0Zhd01nakgrUGE0ME1RM3ZTM1N2d3Z6VjV4d1hCSExkMXRMMkNRblFQ?=
 =?utf-8?B?WndWMW5qSHBXSnRNUytVK1RtRUM0Vnh5allYb2tqNW1jcENLSTdYYkp0bEl4?=
 =?utf-8?B?QTFCQUVrVGVwS2NaaHdyVUMzTERUU0VBeGJJM1NHSVFxc1paYTdPYlpnQ1J6?=
 =?utf-8?B?ZmVScnYzN2tYcW56YWpEb1dtNktxWWJhYVc4Q216RnlHZzFwcEl5UmlzNHRm?=
 =?utf-8?B?N3ozMklTbmZhQWxJMXNNRmR2dXlMd0IzckpkWjh1SVZLMmhLZGdFNDZEK3o4?=
 =?utf-8?B?VGlFa1RwVEtaQTUyZmxRUFdXaVlPbzdEODI1NlA5Qjk3SXRPSzRmaVlnbG4z?=
 =?utf-8?B?SVZhZERTTWRidHFBR3Y1MGcwTkhIOWhWd3BGSGZ3WDV1czVHcUVqYjVxUk1i?=
 =?utf-8?B?Rjk2eURzQlJSNXVpUkdZeXVZOE5PY0E4TnpLODQrZThpd2ZnMTh0YnAySXRK?=
 =?utf-8?B?NmlUSDRRSjRjZXlaLzFicnRtQ1V5aklPcjJxVnRtYjJXaWMvVU9lSTF0eVNU?=
 =?utf-8?B?QlpTR1Q5Rk1xM09ocndvczIxTVc4Zlh0TG9ocGFiL2lqaW4xcTdGVkFHT3p4?=
 =?utf-8?B?QmtEQ1ZSTDJtZTJQR0paZjY3WXdBVWlLNUNrNDh2bjdNbndIbTRTYmszKzNu?=
 =?utf-8?Q?kxtI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2874cb-92ab-470d-7754-08dcce483b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 07:48:01.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7nP83P//kYJLIbPNJ9iqgoVESLdoJ8DgP5BWV9uDQapb8fBt6dq9Sattf7lTdrL6Ks6Ox6Xd2D2oV0EE/5ztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9726

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBwbWRvbWFpbjogaW14OiBpbXg5My1ibGstY3RybDogZml4
IHBvd2VyIHVwDQo+IGRvbWFpbiBmYWlsIGR1cmluZyBlYXJseSBub3JpcSByZXN1bWUNCj4gDQo+
IE9uIEZyaSwgMjMgQXVnIDIwMjQgYXQgMTE6NDQsIFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBv
c3MubnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBEb25nIEFpc2hlbmcgPGFpc2hl
bmcuZG9uZ0BueHAuY29tPg0KPiA+DQo+ID4gQWZ0ZXIgZGlzYWJsaW5nIFBYUCBhbmQgaGF2aW5n
IG5vIGRpc3BsYXlzIGNvbm5lY3RlZCwgd2UgbWV0IHRoZQ0KPiA+IGZvbGxvd2luZyBzdXNwZW5k
L3Jlc3VtZSBoYW5nIGlzc3VlIG9uIE1YOTMgRVZLIGJvYXJkLg0KPiA+DQo+ID4gIEVuYWJsaW5n
IG5vbi1ib290IENQVXMgLi4uDQo+ID4gIERldGVjdGVkIFZJUFQgSS1jYWNoZSBvbiBDUFUxDQo+
ID4gIEdJQ3YzOiBDUFUxOiBmb3VuZCByZWRpc3RyaWJ1dG9yIDEwMCByZWdpb24NCj4gMDoweDAw
MDAwMDAwNDgwNjAwMDANCj4gPiAgQ1BVMTogQm9vdGVkIHNlY29uZGFyeSBwcm9jZXNzb3IgMHgw
MDAwMDAwMTAwIFsweDQxMmZkMDUwXQ0KPiA+ICBDUFUxIGlzIHVwDQo+ID4gIGlteDkzLWJsay1j
dHJsIDRhYzEwMDAwLnN5c3RlbS1jb250cm9sbGVyOiBmYWlsZWQgdG8gcG93ZXIgdXANCj4gZG9t
YWluOg0KPiA+IC0xMyAgaW14OTMtYmxrLWN0cmwgNGFjMTAwMDAuc3lzdGVtLWNvbnRyb2xsZXI6
IGZhaWxlZCB0byBwb3dlciB1cA0KPiA+IGRvbWFpbjogLTEzICBpbXg5My1ibGstY3RybCA0YWMx
MDAwMC5zeXN0ZW0tY29udHJvbGxlcjogZmFpbGVkIHRvDQo+ID4gcG93ZXIgdXAgZG9tYWluOiAt
MTMgLi4uDQo+ID4NCj4gPiBUaGUgaXNzdWUgd2FzIGludHJvZHVjZWQgc2luY2UgdGhlIGNvbW1p
dCBjMjRlZmE2NzMyNzgNCj4gPiAoIlBNOiBydW50aW1lOiBDYXB0dXJlIGRldmljZSBzdGF0dXMg
YmVmb3JlIGRpc2FibGluZyBydW50aW1lIFBNIikNCj4gPiB3aGljaCB3aWxsIGFsc28gY2hlY2sg
dGhlIHBvd2VyLmxhc3Rfc3RhdHVzIG11c3QgYmUgUlBNX0FDVElWRQ0KPiBiZWZvcmUNCj4gPiBw
bV9ydW50aW1lX2dldF9zeW5jKCkgY2FuIHJldHVybiAxIChtZWFucyBhbHJlYWR5IGFjdGl2ZSkg
ZXZlbg0KPiA+IHBtX3J1bnRpbWUgaXMgZGlzYWJsZWQgZHVyaW5nIG5vX2lycSByZXN1bWUgc3Rh
Z2UuDQo+ID4NCj4gPiBIb3dldmVyLCB0aGUgcG1fcnVudGltZV9zZXRfYWN0aXZlKCkgd2UgY2Fs
bGVkIGFoZWFkIG9mDQo+ID4gcG1fcnVudGltZV9nZXRfc3luYygpIHdpbGwgbm90IHVwZGF0ZSBw
b3dlci5sYXN0X3N0YXR1cyB3aGljaA0KPiBwcm9iYWJseQ0KPiA+IGxpa2UgYSB1cHN0cmVhbSBr
ZXJuZWwgaXNzdWUuIEJ1dCB0aGF0J3MgYW5vdGhlciBpc3N1ZSB3aGljaCBtYXkNCj4gd29ydGgN
Cj4gPiBhbiBleHRyYSBmaXguDQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgY29uZnVzaW5nLCBJIGRv
bid0IHNlZSBhbnkgY2FsbHMgdG8NCj4gcG1fcnVudGltZV9zZXRfYWN0aXZlKCkgYW55d2hlcmU/
IEFyZSB5b3UgcmVmZXJyaW5nIHRvIHNvbWUgb2xkDQo+IGNvZGU/DQoNCm9oLiBJIGZvcmdvdCB0
byB1cGRhdGUgY29tbWl0IG1lc3NhZ2Ugd2hlbiBtb3ZpbmcgdGhpcyBwYXRjaA0KdG8gdXBzdHJl
YW0NCg0KPiANCj4gPg0KPiA+IFRoaXMgcGF0Y2ggcmVmZXJzIHRvIHRoZSBzb2x1dGlvbiBpbiB0
aGUgZXhpc3Qgc2ltaWxhciBpbXg4bSBibGtjdHJsDQo+ID4gZHJpdmVyWzFdIHRoYXQgaXQgd2ls
bCBwb3dlciB1cCB1cHN0cmVhbSBkb21haW5zIGR1cmluZyBibGtjdGwNCj4gc3VzcGVuZA0KPiA+
IGZpcnN0IGluIG9yZGVyIHRvIG1ha2Ugc3VyZSB0aGUgcG93ZXIubGFzdF9zdGF0dXMgdG8gYmUg
UlBNX0FDVElWRS4NCj4gPiBUaGVuIHdlIGNhbiBzdXBwb3J0IGNhbGxpbmcgcG1fcnVudGltZV9n
ZXRfc3luYyBpbiBub2lycSByZXN1bWUNCj4gc3RhZ2UuDQo+ID4NCj4gPiBBZnRlciBmaXhpbmcs
IG5vIG5lZWQgZXh0cmEgY2FsbGluZyBvZiBwbV9ydW50aW1lX3NldF9hY3RpdmUoKSBhaGVhZC4N
Cj4gPg0KPiA+IDEuIGRyaXZlcnMvcG1kb21haW4vaW14L2lteDhtLWJsay1jdHJsLmMNCj4gPg0K
PiA+IEZpeGVzOiBlOWFhNzdkNDEzYzkgKCJzb2M6IGlteDogYWRkIGkuTVg5MyBtZWRpYSBibGsg
Y3RybCBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5k
b25nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcG1kb21haW4vaW14L2lteDkzLWJsay1jdHJsLmMg
fCAyOQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG1kb21h
aW4vaW14L2lteDkzLWJsay1jdHJsLmMNCj4gPiBiL2RyaXZlcnMvcG1kb21haW4vaW14L2lteDkz
LWJsay1jdHJsLmMNCj4gPiBpbmRleCA5MDRmZmE1NWI4ZjQuLjM0YWM3YjcyMmI5MCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3BtZG9tYWluL2lteC9pbXg5My1ibGstY3RybC5jDQo+ID4gKysr
IGIvZHJpdmVycy9wbWRvbWFpbi9pbXgvaW14OTMtYmxrLWN0cmwuYw0KPiA+IEBAIC00MjQsNiAr
NDI0LDM0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14OTNfYmxrX2N0cmxfZGF0YQ0KPiBpbXg5
M19tZWRpYV9ibGtfY3RsX2Rldl9kYXRhID0gew0KPiA+ICAgICAgICAgLnJlZ19hY2Nlc3NfdGFi
bGUgPSAmaW14OTNfbWVkaWFfYmxrX2N0bF9hY2Nlc3NfdGFibGUsDQo+ID4gIH07DQo+ID4NCj4g
PiArc3RhdGljIGludCBpbXg5M19ibGtfY3RybF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikg
ew0KPiA+ICsgICAgICAgc3RydWN0IGlteDkzX2Jsa19jdHJsICpiYyA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiA+ICsNCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBUaGlzIG1heSBs
b29rIHN0cmFuZ2UsIGJ1dCBpcyBkb25lIHNvIHRoZSBnZW5lcmljIFBNX1NMRUVQDQo+IGNvZGUN
Cj4gPiArICAgICAgICAqIGNhbiBwb3dlciBkb3duIG91ciBkb21haW5zIGFuZCBtb3JlIGltcG9y
dGFudGx5IHBvd2VyDQo+IHRoZW0gdXAgYWdhaW4NCj4gPiArICAgICAgICAqIGFmdGVyIHJlc3Vt
ZSwgd2l0aG91dCB0cmlwcGluZyBvdmVyIG91ciB1c2FnZSBvZiBydW50aW1lIFBNDQo+IHRvDQo+
ID4gKyAgICAgICAgKiBjb250cm9sIHRoZSB1cHN0cmVhbSBHUEMgZG9tYWlucy4gVGhpbmdzIGhh
cHBlbiBpbiB0aGUNCj4gcmlnaHQgb3JkZXINCj4gPiArICAgICAgICAqIGluIHRoZSBzeXN0ZW0g
c3VzcGVuZC9yZXN1bWUgcGF0aHMgZHVlIHRvIHRoZSBkZXZpY2UNCj4gcGFyZW50L2NoaWxkDQo+
ID4gKyAgICAgICAgKiBoaWVyYXJjaHkuDQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIHJl
dHVybiBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGJjLT5kZXYpOw0KPiANCj4gVGhlIHJlYXNv
biB3aHkgd2UgKmRvbid0KiB1c2UgYSByZWd1bGFyIHBhcmVudC9jaGlsZCBzZXR1cCBvZiB0aGUg
UE0NCj4gZG9tYWlucyAoZ2VucGRzKSB0byBjb250cm9sIHBvd2VyLW9uL29mZiwgaXMgYmVjYXVz
ZSB0aGVyZSBzZWVtcyB0bw0KPiBiZSBhIHNwZWNpZmljIHNlcXVlbmNlIHRoYXQgbmVlZHMgdG8g
YmUgZm9sbG93ZWQuIFNvLCBpbnN0ZWFkIHdlIGFyZQ0KPiB1c2luZyBydW50aW1lIFBNIHRvIGNv
bnRyb2wgdGhlIHBvd2VyIGZvciB0aGUgcGFyZW50IFBNIGRvbWFpbi4gIFNlZQ0KPiB0aGUgY29t
bWVudCBpbiBpbXg5M19ibGtfY3RybF9wcm9iZSgpLg0KDQpUaGlzIHdhcyB0byBmb2xsb3cgaS5N
WDhNIGltcGxlbWVudGF0aW9uLCBidXQgcGFyZW50L2NoaWxkIGhlcmUNCnNob3VsZCBiZSBiZXR0
ZXIgaGVyZS4gQWZ0ZXIgcmV0aGlua2luZyBhYm91dCB0aGlzLCBpLk1YOTMNCm5vdCBoYXMgdGhl
IEhXIGxpbWl0YXRpb24gYXMgaS5NWDhNLCBzbyBwYXJlbnQvY2hpbGQNCmNvdWxkIGJlIHVzZWQg
aGVyZS4NCg0KPiANCj4gSSBoYXZlIHRvIGFkbWl0LCBpdCBhbGwgbG9va3Mgc3RyYW5nZSB0byBt
ZSBhbmQgc2VlbXMgYWxzbyB2ZXJ5IGZyYWdpbGUuDQo+IA0KPiBUaGF0IHNhaWQsIHdoeSBkb2Vz
bid0IHRoZSBzZXF1ZW5jZSBtYXR0ZXIgYW55IGxvbmdlciBkdXJpbmcgc3lzdGVtDQo+IHN1c3Bl
bmQvcmVzdW1lLiBPciBtYXliZSB0aGUgc2VxdWVuY2UgZG9lc24ndCByZWFsbHkgbWF0dGVyIGFm
dGVyIGFsbD8NCg0KSXQgbWF0dGVycywgdGhlIGJsayBjdHJsIHNob3VsZCBiZSBjaGlsZCBvZiBH
UEMgcG93ZXIgZG9tYWluLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW50IGlteDkzX2Jsa19jdHJsX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYp
IHsNCj4gPiArICAgICAgIHN0cnVjdCBpbXg5M19ibGtfY3RybCAqYmMgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCj4gPiArDQo+ID4gKyAgICAgICBwbV9ydW50aW1lX3B1dChiYy0+ZGV2KTsNCj4g
PiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBkZXZfcG1fb3BzIGlteDkzX2Jsa19jdHJsX3BtX29wcyA9IHsNCj4gPiArICAg
ICAgIFNZU1RFTV9TTEVFUF9QTV9PUFMoaW14OTNfYmxrX2N0cmxfc3VzcGVuZCwNCj4gPiAraW14
OTNfYmxrX2N0cmxfcmVzdW1lKSB9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgaW14OTNfYmxrX2N0cmxfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAgICAgICAgIHsN
Cj4gPiAgICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAiZnNsLGlteDkzLW1lZGlhLWJsay1j
dHJsIiwgQEAgLTQzOSw2DQo+ID4gKzQ2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIGlteDkzX2Jsa19jdHJsX2RyaXZlciA9IHsNCj4gPiAgICAgICAgIC5yZW1vdmVfbmV3ID0g
aW14OTNfYmxrX2N0cmxfcmVtb3ZlLA0KPiA+ICAgICAgICAgLmRyaXZlciA9IHsNCj4gPiAgICAg
ICAgICAgICAgICAgLm5hbWUgPSAiaW14OTMtYmxrLWN0cmwiLA0KPiA+ICsgICAgICAgICAgICAg
ICAucG0gPSBwbV9zbGVlcF9wdHIoJmlteDkzX2Jsa19jdHJsX3BtX29wcyksDQo+ID4gICAgICAg
ICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IGlteDkzX2Jsa19jdHJsX29mX21hdGNoLA0KPiA+
ICAgICAgICAgfSwNCj4gPiAgfTsNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+IA0KPiBLaW5k
IHJlZ2FyZHMNCj4gVWZmZQ0K

