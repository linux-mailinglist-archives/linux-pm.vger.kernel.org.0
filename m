Return-Path: <linux-pm+bounces-28786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0643ADA9A6
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041033AAAAB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD091FC0FC;
	Mon, 16 Jun 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RyYxbDUM"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247F1F4703;
	Mon, 16 Jun 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059694; cv=fail; b=cojBzL1qANKZEq9nPC+YkKj2nC4T3Wy0fq69F0BayypQ1cvm8eiJRmBiR2nYa6y1787/tXcCw8T7C+dD+3Qe2PFsG5ZA4LWiD1/Y/Yp1E/gKMNIxZJm2tgsNejA8ZEaOKFUCsS8Guq7VaBJHPiU4QKaU7t81/VD/s7/0yAi5E7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059694; c=relaxed/simple;
	bh=BzyKY6QvFhyVQ8D2+Ls6pPw2+woUt6JpnM0bU/6uqyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYPvF5uWp+pT7VJpmB39MuJRlOvVocXDEriVV8TFH0+GhMWf4d83Z6wVLI1yYZJ6HtNzmGip6NepNY7DUzm0w+1UdVhzb/i3vm1Y3A6jbYbo2osvyZs0eGD45ko/HA6XmFTO5HF6szgvsf+xAXolofH4EJaaT347nJkcUHo5bx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RyYxbDUM; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACsv8m3pP55YdpC8/h7qMJXB7Ylf2nu57Kl4GN8nbZpWslaSNZ3RPFgixrYqrIQlaOYYwPLp5fT0GdfSpgnJwRiLCXDNV6dcIYW/1TlewJqncq8oQCo3qaRq+zZDmfGjGuh/mIj81E3JlYht6lzyj8VuHviuzB/0tmeHP4soqKejfANUtqlC5x5PtCKRBqMinEeFuhe8MBNz0STHu84LBTXtCduU7k/XLUV46VKfK0z3JocaCX4hskI7WvOwV17vjAp/bl04fC8c1rmIBvoA8triLgDOg7+eOV3u8FV5w+VpuEVcpm5IjIgkdhpBGoaqk7WaHTdrfE+Lujz8FPyrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzyKY6QvFhyVQ8D2+Ls6pPw2+woUt6JpnM0bU/6uqyg=;
 b=ZGKWkLxKWfww1C0LfbVSanFksBMkzuwhsWErlkoEL7VOe5DWa5LqJyjgACAj6tBClV362pxOxkaJXbSKZHnPJnHiL2BexgiHPcCHPUuNfl3abCqW+VQoMIdcKjwTcLUmGaR9YQC+yKc6/lTZ+5+4DkwwoqSBbs94bG07a8yuKWVp62rtRm1R5CYf4m9abee4w03oVtjkJ14Dyo90ftCAcMMrqqlPbyuJYZzxYTGOS+GLNJ3OM+gxKLd7G5q5tVRb0Truw4R9E8af4ic38ArjIY5PoK7WnNKAtz3pqUCtX2S14eFRBW0avqHbrSzV+UYKkt/4xOSfk298KKjfWtSlAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzyKY6QvFhyVQ8D2+Ls6pPw2+woUt6JpnM0bU/6uqyg=;
 b=RyYxbDUMqbK3WsLA7NcKCHuby5RqvqoRs2XHOXLvjHSdT2l9fEKs+1RPg8kvVtKw/KWPZcbdDKLS+ZkkhY9lU/GKtMQ4meZgHS6skomnBjrRWP65MeqRnZS0Z969mH9kfLimW2WFaq4X3GNnFeFFTlXrEcf2sOzQNFn6wT14jFBba+CqfPA8YkdCiAPtRmh1EdwHNTQhd2dJ32HL5FEFEVFz1CdkS58TbN7y0dQjDSWoAiKC2GRlLHkElnz6gh5UZi3KCjyr6OH75t72khLUy0PIdU01JgROOee/+Mli8nYjIkahyXMwB4tHhhyNMvtKO/HCI36CvU08uGpQnyrbeg==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 07:41:28 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 07:41:28 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Ye Li
	<ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: Re: [PATCH v5 2/9] dt-bindings: soc: imx-blk-ctrl: add i.MX91
 blk-ctrl compatible
Thread-Topic: Re: [PATCH v5 2/9] dt-bindings: soc: imx-blk-ctrl: add i.MX91
 blk-ctrl compatible
Thread-Index: AQHb3pIRaYtPywOlpkG/jrRJoOkXmA==
Date: Mon, 16 Jun 2025 07:41:28 +0000
Message-ID:
 <AS4PR04MB9386ACE1E56B5D4A771C62C2E170A@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <20250613100255.2131800-3-joy.zou@nxp.com>
 <05e936ee-cb24-4761-8827-e2d45ac0cd68@kernel.org>
In-Reply-To: <05e936ee-cb24-4761-8827-e2d45ac0cd68@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|PAXPR04MB8510:EE_
x-ms-office365-filtering-correlation-id: 55694bc2-e165-4805-1812-08ddaca93471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?bC9nL3B0OEExQkdEdTNkT1FMZ3Y1VFpIOEd3djdlQ1YzOXJ1akhpTlFXcFhx?=
 =?gb2312?B?ampPdi8wVE5hclNTbXFqUHpVM3VaeEcvaTJPa2JPT2ZNc1RyNTNFNXVZemxO?=
 =?gb2312?B?a3RSQ1lkblFWRnB5Y1dxK05WNVNVMlBENkoraEd6Mlcxd2VyK0o3ZXEya3py?=
 =?gb2312?B?REExM1pGWUszaWRSWDFrbDg3VlRBejY0bTJrOGVOVW95c3ptd0tIeXZZMGor?=
 =?gb2312?B?MHRzR2tHR2tYQ3lCWEhLYTduRDUrSlpWV3ZpaVBMU21rMDNjTHluK1dWSnFa?=
 =?gb2312?B?Mmc5LzF3VXhacGZDMTRsMFUxd3BCczFEaTBjelFZMVNIdng4dUlBWVRxMUNs?=
 =?gb2312?B?eXBKV01XdXQ2bVBUVTN6elgyMUVJRG1DMGVlTzFxeG5NWHJuOWhTWTc5MDdP?=
 =?gb2312?B?a0R4NmkxODhkR3E1MDduVTBmSENoZlhRTEU0aUR1V3RubkNrMjUzOE5hZGcx?=
 =?gb2312?B?WW5YaElMeWRZeCsvQXU3SDhhZ09OTFNMNElJRGNPSTVTRUtHK0QxMTRZRU5G?=
 =?gb2312?B?NGdBSDNndktvdnV4cFZ3UVNaYVhvbDVYalR4MU5ESjJhT3N0MHF6b3lraVNE?=
 =?gb2312?B?ZkoxQ3dML2tLUHB5RFozanpWR3ViOWpJdEVUZUgrcUh2S0Evd3l4NjBSamF6?=
 =?gb2312?B?bitOK2pIakFURkhxVlVvWXc3cU5FSjdFNW1oWXlWYWl4bE05R2JubDdWNm1G?=
 =?gb2312?B?NmhGWVhEemdrN0NySkxqRGswc1pnYmxvM0piYmloUThGZUJ1cnpnVjdNN24x?=
 =?gb2312?B?Z1VmUm9BZU1RTmlvMDhsaTRMbnlBdVkvbGttbjBoU3BIUk1lbXJjVjNvVk5u?=
 =?gb2312?B?RUVvUHpKdjQyQWJ6Mzhia3RHdGxOM251NVp5c2V1QkxKd3llZE51RFRBVkdG?=
 =?gb2312?B?ZXNybkY5cTZzNTBnSGdSZitmVHVsWnNhMCs1TTcwUG5JREp4Z21wWEYwL0xn?=
 =?gb2312?B?YXBxK1NzNGFEZHZvMEhBSDF0YW5SSHdHTjY0UVc5T3NkRk4wRTNMR1V5VHdK?=
 =?gb2312?B?ZlF4Wk8zL3g4bTFhMU5RbzBESGVFaUxINU5MTktuOTlTbmIwdWM4OFJKdlgw?=
 =?gb2312?B?S2plUDd0STJJSEVoYy82bWIzeFVlbkM4cHl3b2JuNTVEWHBIUFppTHRFVTh0?=
 =?gb2312?B?Z2RrV0lVYnN3Wm1ZTm9QOGlDNlUvU0xybnhNTTl3S2N5b3g1c2lLZUhXcUdC?=
 =?gb2312?B?Slh2eWF3ZnlCZ2Y3RFVrY1pxT2R2djFXUGRnSkxwMW84WGpWOXk5ODJGenNZ?=
 =?gb2312?B?KzcvY0dtTVFGUi9MMk4xNVBWUmFIbWdQSG1EQ1dpYmFvS0dTQnM5RzJDeDBY?=
 =?gb2312?B?bmlGRkZZeG1wcXYxN0VLRDlRVW5RREZOTzRrNDFtRFBUd1VIcTRyUUR3RkM4?=
 =?gb2312?B?c3JoZENRdlYwVXlxYVF4b2UyTGNWMXJFNmw3ZTVOdDFnSHNaTnFKY1FYNkNU?=
 =?gb2312?B?UUQrejhnM0d4QlFSQnhxMU9UeXVWQk9XNk55QUVRQ2dsZTNNemRNQTZQelF0?=
 =?gb2312?B?VkQ4ZWM1TXR5MjFIYTh3MHpmaG9MWlUvTHlLNUg4elBTMkZXQjRWL1MxWEcw?=
 =?gb2312?B?SWxiV0s4SFpsamd4Qy9qZllUZDZrMG5Qd1RQZTM3UmYvU2FVbnpFTXVaTUhj?=
 =?gb2312?B?SGd2OXpCOEQxdG9SZmp4cXplS2J5WWRtZ0FIV2VLdEtzQVoxMC9XUDluVE9D?=
 =?gb2312?B?V0Fjek55MHlVeWF1ZFltdzY3SGttT2pSVyt1bTI1YkF1RUpUT0duQUp6YmZp?=
 =?gb2312?B?UGtDcWhtOHZ3emFtMmxLUkhQKzlvR1JYNTFnNk83SVJlTUhpTUF0bVV1LzI1?=
 =?gb2312?B?dllmWVF2Ui8zeE9vSnA5b0dIV3FyMm1ZT0FFZDJzdG9PZ21tbithK1pnbUxC?=
 =?gb2312?B?dFMvZzRrcmM2NlpwTHpSazkwL0UzSHBZTFRKNmxlSXpjaHMwYllNVGMwbVlV?=
 =?gb2312?B?ZTA0MGVNY2hhMkJEUFg0U2tNaktMSjVzZFJDeXFRSEd5SDh1emVjcDFaL3B2?=
 =?gb2312?Q?aR7x5qEFzmWI4nL7yaUZ3ZyRkIojrg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dnhianVIaHpYeGJoSHQ0YkxDbWIxL25xQWpQK3NTUkU5Ym0xclQzOHI1SitC?=
 =?gb2312?B?TWlpSE9qbFZPMDV6SmdpcVZ4aG1iNk5MNDUySUhRaER1Y2NRR3lGUXh6OGta?=
 =?gb2312?B?aDI1bUIybFZnNjhVRVdURFdSTm5FWXErNkZMTzhSMWR1TnFLZmk0ang1ekxC?=
 =?gb2312?B?d2JiWWFSMzNEUjBwVFl4K1JxbDd3ZXR6ZnFxWkNuVDh0emQ1aGozaTkvSDZI?=
 =?gb2312?B?c1hEQlZad0wyVHZhUjJjYVF4SnlBUk5nUlR6UkVKTjFQSG5mNnluUzJJQ3hI?=
 =?gb2312?B?YkRUZW1KRnU0MkR6YTBNQWZSREVtZm96UXFnZmtSL2RyU2lOSU5rdjlNdjAz?=
 =?gb2312?B?WUZTTlJXRGJEOC9NdFUrb2VUQmxaNHRza0pheGFWY3k3U1BLK2hmOTRlNVhM?=
 =?gb2312?B?RHhsa3g5d2VnVnRWY1pLODllMjBQYmRxVXhsNWxDMlNXM0RnYXZLUUVKSzVo?=
 =?gb2312?B?MWIvY24vbDJWU1JjMkNldy9wdnZEYjgxWjZTMUlVV040cmJjelBsUWMvSE1k?=
 =?gb2312?B?Q3JtcjJTOStSV2RKWlJmRlJuZDBRUGZzMkR3bEFoc0xuZm1xNmlJOWVqUlB0?=
 =?gb2312?B?U3pMVlFRK2NLMkN3bytZbEsrenBJck4zQ0VkcW8zSjk4QmxaUHoxZFRUZ0Ew?=
 =?gb2312?B?aldWeXFuVVdHU1hVSmRQZE1qZXZMQ1hnQVp3K3crQjhJakN2ZkJZRUR6K21M?=
 =?gb2312?B?aEg1dkt3R2I0Q1ZxNS8zZVNtUVpYZ0N5ekFnQUZrVm5wU3ExcDJqSjZBSWZh?=
 =?gb2312?B?dlpwd3AvOWx4d1UvZ1BCYUFDWWxFMUN5ZHhkbmxLa084NzhVd2RQYjlrelE2?=
 =?gb2312?B?WmE3WjdOcjJwK3FZZnhpcnRET2pML3E5YktvS0NVbXF2NStZS210RTBTNDRE?=
 =?gb2312?B?VjUwbHlnTnpTSkNLajg1TTBxblpSOW16MmM0akJEbjJWQjF1UlNDam9sRnpp?=
 =?gb2312?B?VE1ueUc0czE3N0Z0VGlXM2dseFZzSDJuTUtiZEZyc05VOEdUSTJTakIrQUEv?=
 =?gb2312?B?cFJyaFljWHJoamVLeHBEVHNIQkpJVHVMRHVsaFVOSWJTS0hoNUw4cEtQd2lu?=
 =?gb2312?B?dFF6N0lYQjhLNWQxQWJ1R09DTXBNdEE1VExLa3ptZjI0aGRsNTQwZ2xUMmU0?=
 =?gb2312?B?UTNhUUlxRjgrbWtibmFBbmZ3RDJjVW5QazF2N3ZaT05pc1RSek9hcVJxajdV?=
 =?gb2312?B?WFVBVXQ4SGg4c29GcmlSdnpmMWQ2NHBnWXd1TS83K2FiY3l1akJGNW5KK3pG?=
 =?gb2312?B?VmQrYm8rV243TGNwdGdmdE5YWHV5Z0p5WW1YVzErOWNFM1Z0OWp1MWtlRTkr?=
 =?gb2312?B?cmdTN3RtYmdWWmgzQTFZS0x2SVVpUHhLNkRzMmFhZWh3R0lZSzAxZ25PYWpQ?=
 =?gb2312?B?Zi95bUJ6Q1Z1STBjNmh5ZzVQMHBNcXhmaWJXTTcvbGhhZWkyV1RnZE9CUnZ3?=
 =?gb2312?B?end0ZFhjeW1acTBxMlJUOHlVNjE3Y1ZMZ3Q3RHE2ZnRER1VCNDc0OUJuUkxO?=
 =?gb2312?B?dHJwdmRQdlpCSUIxbXNYakJXYWF6dGRSd3phV3NvSU8wSmJ0dDUvNkpHZFpJ?=
 =?gb2312?B?dXA3ekxnZFliWG1jaS9kUXA0TFdld2U2WCs0akFYb1NCRnJYZUQyRzN1akdV?=
 =?gb2312?B?RDNCV252SGlXSFgzZ0tIM2xNS0lBUkY2WlBJR2dXTmpsaTBkbENFSjA2bzR1?=
 =?gb2312?B?S3ZRWXZDV0Y4a3Z1WE0vTVR3eTJyTWNMV2V5NmhLdHAxSTdKYVJ1NDAxbGoz?=
 =?gb2312?B?bFlCUnFaczYwakFKb1dCd1lmNkNNbFI5eUJ3eDhydExHTVI5V2JBOVEzdjBC?=
 =?gb2312?B?NXBBK2l4bXphTE5HS0VGM0t4dTNoMGdHSzYrZ2piRXlaTTduSUtaVStNSlpj?=
 =?gb2312?B?bGJweU9pc2haeGtPelVDTytOZ2tCSUY1aWJGK0FLNzdrNmRzWVF0TEhBUExL?=
 =?gb2312?B?MVhKSXJNdVU3dTZxL0p6akNEMDljOWlyNzN2YXgwRWdpMEd3NnhpYjZwNHdW?=
 =?gb2312?B?cEg1TXJvNERaVGpTVGt0M0h2enR2eXgwMkx6bDVCaGdITnp5Zi9kWVYrR0dI?=
 =?gb2312?B?NUpnV2Nkd1IrdVNnVFI3Z05JdytFeTBZNWhGZEoyWG1YRkcvUkdaTWdCemgx?=
 =?gb2312?Q?5voI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55694bc2-e165-4805-1812-08ddaca93471
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:41:28.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwII+7EM7twbAGt3iDBUhNBqQ8tgRyFraqO6vbzNLBv2lITsyl4uvm1jJ1PBNwa3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNcTqNtTCMTPI1SAxODo0MQ0KPiBUbzog
Sm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5l
bC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5l
bC5vcmc7IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsg
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbTsNCj4gYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNv
bTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsNCj4gcmljaGFyZGNvY2hyYW5AZ21haWwuY29tOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBs
aXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJl
cGx5LmNvbTsNCj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAuY29tPjsNCj4gSmFja3kgQmFpIDxwaW5nLmJhaUBu
eHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBBaXNoZW5nIERvbmcNCj4gPGFp
c2hlbmcuZG9uZ0BueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIvOV0gZHQtYmluZGluZ3M6IHNvYzogaW14LWJsay1j
dHJsOiBhZGQgaS5NWDkxDQo+IGJsay1jdHJsIGNvbXBhdGlibGUNCj4gDQo+IA0KPiBPbiAxMy8w
Ni8yMDI1IDEyOjAyLCBKb3kgWm91IHdyb3RlOg0KPiA+IEFkZCBuZXcgY29tcGF0aWJsZSBzdHJp
bmcgImZzbCxpbXg5MS1tZWRpYS1ibGstY3RybCIgZm9yIGkuTVg5MSwgd2hpY2gNCj4gPiBoYXMg
ZGlmZmVyZW50IGlucHV0IGNsb2NrcyBjb21wYXJlZCB0byBpLk1YOTMuIFVwZGF0ZSB0aGUgY2xv
Y2stbmFtZXMNCj4gPiBsaXN0IGFuZCBoYW5kbGUgaXQgaW4gdGhlIGlmLWVsc2UgYnJhbmNoIGFj
Y29yZGluZ2x5Lg0KPiA+DQo+ID4gS2VlcCB0aGUgc2FtZSByZXN0cmljdGlvbiBmb3IgdGhlIGV4
aXN0ZWQgY29tcGF0aWJsZSBzdHJpbmdzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm95IFpv
dSA8am95LnpvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vc29jL2lteC9mc2wsaW14OTMt
bWVkaWEtYmxrLWN0cmwueWFtbCAgICAgfCA1NSArKysrKysrKysrKysrKystLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IFRo
aXMgd2Fzbid0IGhlcmUgaW4gdjQgYW5kIGNoYW5nZWxvZyBpcyBzaWxlbnQgYWJvdXQgaXQuDQpU
aGFua3MgZm9yIHlvdXIgY29tbWVudHMhDQpPbmx5IGFkZCBjaGFuZ2Vsb2cgaW4gY292ZXIgbGV0
dGVyIGFuZCBtaXNzIGNoYW5nZWxvZyBpbiB0aGlzIHBhdGNoLg0KV2lsbCBhZGQgY2hhbmdlbG9n
IGluIHBlciBwYXRjaCBmb3IgdGhlIGNvbnZlbmllbmNlIG9mIHJldmlldy4NCkJSDQpKb3kgWm91
DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

