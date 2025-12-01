Return-Path: <linux-pm+bounces-38944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE6C958B7
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 02:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9C614E0125
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 01:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397D81AA8;
	Mon,  1 Dec 2025 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="esJQvvDw"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA42556E;
	Mon,  1 Dec 2025 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553955; cv=fail; b=LStf4CAvrg5tMO21sWcB2QOxIVM+eEoOozVSAN/Dom504IHJUPIDO7xoMC7efqJCfJjqWHHGZV9e/YA08ggCgDYllakZN3q12y+BMaHIvHfBCDuizRwqQFbh7J1EqoMqfjV4b5l8zJetXyCA26hlvHh8mcmJMvj68/zEhTX4eEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553955; c=relaxed/simple;
	bh=bmBT1czJ8tlK3YTkT9Q/Qk/ayidoZp1Z2ibVUGh3q6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XkIDUfFjUNNxajsKyUko765aPHaxgxFu+8MnrjO7x5Nmc5ksBAl6AWnlwBJYI12jomhdJSg52W2azmXNRec6FZiD4rM2O+lXuHph8vIvRNTf6zOkjbhn3Z6/fNGwRtR+QkL5f1wIfjuIEGpwpdJoUp6DtES/NZNak3E6tI8EB00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=esJQvvDw; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlOdTQXWAyF5ahH22gkPr52hx3CtNPIzzytugbyLBlkVpMVS39p07/Rcjc2a971heeWB0A/+FSFnGuqg620Zjkn29wuZYBHzxCvQN2kY3CFEMs2D2mUhixgy91t/mqpPj7vlfoZEEijAJBZLEk2aCV1L8CEmrb7v/v6tT9167vR5sxx1BVbtsffJDi+Th/SExTQbi8CvhS3mSz+HcSreNXO6dVwEDZxdXTL6m95xaw+6jaWrCxqfNcWESOjyNh0XfmUyjzt5oVgBgQDMEcfjK8dREIUhuKG4881Vk2aU4oqDDVPOdqE1A0wJS5fEQgr/mZlCm4Y/4019WNqNlod3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeR1edaGi3dM3bZD6lireq5WEauAfqHVWPLFwGH/t6A=;
 b=JpixVFGQG3f38bxbUHAHmrMwz2KdQnsfbBfllp/m5Dfx/ssS3JJk6006QnnoWYXbwHhkMGIg7jmPS/gndnhKRzmrlY+gfhcDNiwjDnu+Q6OMf/AV5QSuqHWoacH/jgy0FrydImWJqXK9BanruX0Ej+3f5xsb3U3rHbTHpxgup0jWpSaQ9k5DYd0WTAnd+GOhg8NOcxYU5oHp53Hjtu7jowPxr9GqYmR8+YdUZ5mWVYNZ4cKADgSUVTVazbeN4zEJMviAZHGWnLo60hQVXFBwmYSXR3Cf48mXOSaiRSTLjisDmWf9U5x9NPM1Tp2kwQXWOJVNTXGkjwnVOKvQMFFMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeR1edaGi3dM3bZD6lireq5WEauAfqHVWPLFwGH/t6A=;
 b=esJQvvDwAodnPkpB7S0p+Gn9rbq2TyuBR+RkvJ+sO6P4vGSL2HYgnYXFL1RGgUtTIdrTieX72XkG5lQ4B1e11vmYt7EJKvyNjETNfqTQuKPADZH4BXEGJX1K83/lfEA+peSQmKh2R9ODn2Ptn2Qu0oWyWzPyEf3AJrnDM22hA3F3JTYE88WVP2eza9UerAVFFdClvxKjXUEUXueJnHnYnZ+JpVTmL37U1gQ2fpSw7G8o41way0sD1+keshDbAQciIGk6u2WZFcp1+LR3qjNN9rCos1MS88MfTFxrZuVcteMDL6c5TtqNA5D0I7eGXgEXs21nGNWJNLc6miwvWnF7ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by PAXPR04MB8317.eurprd04.prod.outlook.com (2603:10a6:102:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 01:52:29 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 01:52:29 +0000
Message-ID: <64ad3d66-4edf-4a0b-8992-0db0e90a32b0@oss.nxp.com>
Date: Mon, 1 Dec 2025 09:52:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
To: Nicolas Dufresne <nicolas@ndufresne.ca>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com,
 peng.fan@nxp.com, eagle.zhou@nxp.com, imx@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251128025117.535-1-ming.qian@oss.nxp.com>
 <20251128025117.535-2-ming.qian@oss.nxp.com>
 <46e9a5a881946d879d1b2af3421d574b26256ae3.camel@ndufresne.ca>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <46e9a5a881946d879d1b2af3421d574b26256ae3.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|PAXPR04MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: aadda413-b7e0-42cd-1002-08de307c48bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDBGVk45bEhPQ0hIc3NWRlNUczE5SkcvOUFaUWFsMFhodURseFJWd0VMTHRU?=
 =?utf-8?B?MDdMZXpiUC8xNVVjV2ZpMzVwWWZ0VUdoaHh5aTltanQyM2lkcDRhTUJiODdV?=
 =?utf-8?B?N0tacTJkMU9CcElVQU1sVjJVM1lieUhoeExTdWZCbFZVNThHdFhvNjZWK0Q4?=
 =?utf-8?B?NjZ5T2g2cjUyRjB4dmNST1g0Q1M2VndHM3FycURaSWdaaldXWjFqYlVqZGpZ?=
 =?utf-8?B?Ulh5ZW53aUl3QjkxQy8wNTZuWElsejE0V1hlZksrQzlIVWYvRktGcUJwZ0Zh?=
 =?utf-8?B?UEN5MkE1N091SEQyV1A4Mkp6WGcrWDMwY3ZSUnh1MmZma0JldlU0bHd5ejV1?=
 =?utf-8?B?Zm84SkJ2MWVndjdvZ3lxU2JrVHBaZnk4Uy9tTmhESTV3bld2Y1IrK293VUFP?=
 =?utf-8?B?dnVTbjJOZTBzUENnSlErK1RLK0s4SlV2SzAvVzlzUUd4VDU4NFpIOHltYjB6?=
 =?utf-8?B?TVNDM3FtRllrK2l2ZHdBSzBwU3ZHa3RwSmNubExxN0tqQ29sM0k0WXg2TnZs?=
 =?utf-8?B?UHc1UWZVcWpYRGRweWZ4ZXJXTFNHa2Q3T0RsVkxqSzV2c2U1VE4wUWVrV3lK?=
 =?utf-8?B?c0RTOWtYMEczNE4vRGN1UGVJNjN6THpzem9heWFIZEhQcFROK0ttZ0tsaTFr?=
 =?utf-8?B?bW0vNzFldS8xV0FEYkVIeUNvUjlEa050dFlPU3hNaERaNGJIS1I4TTRTK2Fj?=
 =?utf-8?B?WGJ4TjZROUV5YnRQSjJhSHJpdWQ0VmhYZzBUNDFiczBlTGYwQldvTUZ3S1Vq?=
 =?utf-8?B?K2JBdUxFVGtpaUNDS2Z0c293OWVxZWdyR1hBMjZCWmtsYTcwbXBWSUJxLzdY?=
 =?utf-8?B?UkpRdXJnOUlKZmxXekwyVG1leWV5UHpBZ0wySXg3eUdlc3c2SzFyMGh5WXVE?=
 =?utf-8?B?ZzN5UERzK1VTTU9BZzZBakpyU2pGTXF3WmVpWjdLVzJaelhha1RJbDl1Vnlr?=
 =?utf-8?B?QXJQZEpWK1pTNzdLZzBSYVlubk9WT2hITHd4M2VHSG10N05lbHNFaGtsdXV3?=
 =?utf-8?B?VjRyMVp3KzQxZ3RCWXVGOEI3TlJ1eWgrNmF0RGVIMXE5NE1aakxMRkEyVDBz?=
 =?utf-8?B?cnlKY2JzcU9Fc3dnYmEyeTZnQnJXVEVKUS9uTHdzMmVBV1g3dFVRSFVWQTVx?=
 =?utf-8?B?ZTc2amRNQVdpc2NKMjlDZEVDWWxDVlBxa21hSGRDc2RMY3dlOGVJK2RublQ2?=
 =?utf-8?B?Q0xhbE4xOFlYWHRVekNNdHdCMDBjMlloMWZvSVZNSnkxWmFQUitTRmk3R3Z0?=
 =?utf-8?B?L2U2V2tOQXZveHFyLzBnazBMa25hV1BQeVZad0VyeXFwcmJqOXQyQXNoUWk2?=
 =?utf-8?B?SDhPU0FHdGttY1FER2g4bThPaFR6L2NobGxGdUphSjZBdUdDcmtnZ3pzMzdK?=
 =?utf-8?B?dXlibVZUcDZzV3FsTnRNbFNDdGJDT1hMdDdqcSthSE9JT2lBL0RZZDNvcFRF?=
 =?utf-8?B?cHpWZmM1NUwrOWwzMkc4QldvUGlXK3ZKOWVxUjltc09UaC9mSC9YeC9kanlK?=
 =?utf-8?B?RXNZVTdLQVhhbWNnYXpyRDQ3M0ZuOG43TVMvOE1ZZFlUV2ViQlRSdXNUOThw?=
 =?utf-8?B?b3BBdmQwZmxzWkR2a2pCcURJeCtjUHY3bnJobnFMTzhYNUdGOW9HR1FkWnYy?=
 =?utf-8?B?QTBHdXdSaXI4Skd5c0dycXNxdi9NL1ZBVWZsS1I3S2JjUFNPQ3VtanAxSFF2?=
 =?utf-8?B?ZlhaVTZtZnYvMmFJTTZ3R2RlN1FyNkVROHNjTWY0aUt1ZmMvQkRZc3dId0pX?=
 =?utf-8?B?U3lNQlYzTGtBTTVhQ0ZDYTZVZ0dpakZ1eVZmeldyTTBqb2VkS0hnODRyWkVV?=
 =?utf-8?B?Z1FMMGlFRjFnZWJYR0ZJM2psQlU4Tk5zQzQwMTlsRnZYU3RjVlhYWU9WR3Jy?=
 =?utf-8?B?MC9ZamU4R2UzVmtWejdSV0FiUWc0NDB3OFFtMUpSemMzUmhzQlM3T2JpS2Zn?=
 =?utf-8?Q?uY8sIqBfulEVCYk5nAIeFo6P+SsafVzZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3lVWXRZL1ZoK0h6VWNDd1RXbmIvOUcvQXl3K1NkMytmaFUwQW14eG5aQ3Y1?=
 =?utf-8?B?WXBhcm52dUlNR3BuNnlBUUhtc1pxelpZa3Nld09HeXJsUTBSNlRFMEg4MGF3?=
 =?utf-8?B?eFJRaEdIUUx4cFlUazgwWXBhSzRVbE9vMEoxb0dCYmJsNGhNWlBCRDhSNHFq?=
 =?utf-8?B?L1NNS1daTXFjV1h6VnM1THdrR0wzTGxWZzlzb01obkwydXBBU1phSWVsRkta?=
 =?utf-8?B?OGNVM2M1eVpGSU92TUFOMU9BYUwyc3l4TmU0dXlZdUthWHk4N2I0RjZWY29k?=
 =?utf-8?B?T2YydmI2c01ycjRvMmFFUlBFdzU4d0tQRzhWMW9EdEU4YU5jV2h0VVFlRHBI?=
 =?utf-8?B?d29IZVFJVEcyMEkvYitwbE1GS0QwUGVHMGF1a01PTktZYVZ0bDlVRXNrR1FK?=
 =?utf-8?B?bUt0YnRGUUtrSjB2bUVvTGo5cDkzMURXdFJvaUNXTi9tNmhZUXZtNEdRbDBS?=
 =?utf-8?B?M2E0cUVZcWdDN2w2WVErRWlxWWNUUGZzSmJxdHluMFJNcEI3RU5waG5pa1BP?=
 =?utf-8?B?d3grbzlkZ1crU2tpc3hGSEFmdWNHTzc0NUVaWnR2Z2dNUldwMUVEZmYxR3N2?=
 =?utf-8?B?eWdkUDNLa0RLaVVMTGZLa1RkbWlibllyQ1FOYVJDWUE2RSs1MWFFdUdaMnFy?=
 =?utf-8?B?ZGtKSTZTRnBNSnZVZnFicUJLVDQxb2pXQ3BwQ0hua0RMZUZOVWJTanRCRkwr?=
 =?utf-8?B?eHkwT1V6b0N2bE1BbHN3OVlhV1VobVZNdUEyZTYwYjVTMEF6REhEalJCZ1ZX?=
 =?utf-8?B?QTFMb0YxWXpkbUM3ems3S2ViTHN2UkJpaDVROE5YOGViRlpCd3Y0NWhuSVNw?=
 =?utf-8?B?MU92QTFZam9USXdDZ1p1T05OZWdwK0x2TFpIeFM3YUVKV1lyTFgxQ2lqTzc0?=
 =?utf-8?B?VWgrTDlSTDNjOU9TNUJtTjhvK3lneUxOSlFNS2ZVbnllUUdLck5hSmxIYng5?=
 =?utf-8?B?c0s1amRVV2ZjNCtrWm9MOWI5bXpmYzlTZFdsTUZkbkpWaU14Qys4MXpZYkJR?=
 =?utf-8?B?RkliY01wRDh6MFVOSjdGejVRWDVheXVBZmNXeFVBaE1SZEhVdVcvVWI0NVJT?=
 =?utf-8?B?bkQvZU9hMjUwMjd2clVpVDY2bHg2KzJNaDh1RE9wa0ZtYWppQzY3Yk1PUHgw?=
 =?utf-8?B?ZVhDWXVZdmdwUWNhNXk5VmVta05KcU9MRDhURFJuQ1Z6czBmc3p0Nm5QZ0sr?=
 =?utf-8?B?WXBTaFU3Z0IwR0xLNnduR0hpL0xFZllHR2dGWVRnb0hjaWMvNng1ZVFLUmdD?=
 =?utf-8?B?Y1RQcStqNFlNa3VVUm9IQUx6S0hmQ1dMMFVqSnJHMXFGMS9FWnhIVktxTVNP?=
 =?utf-8?B?NzMrdFRBc2o5ZXhzaVFOK2FIcmVHUW9wQXNadFRza1lOY0ZDVFIzME41QW1Y?=
 =?utf-8?B?S3VOV1dBbTlMUmFQMURGejY1eGxnR08rQmpQZktjTk5WdnlXdDNBQStHSzR6?=
 =?utf-8?B?c2JWYTl3ZGJuVWtwMFgxTktVZnFrT3lWQWI3Tk5BRGxjWS9JWWVQemw2ZUNT?=
 =?utf-8?B?Wk1GeW45VVpPcHFGNEw1bU5DQ0xtOW1NYm4vZDRadVhNMUdkZVRycGNycmo4?=
 =?utf-8?B?cmYyV0gxN01rckYrcVVmaDRHbGxKVllrSGZacjY4R2xVOFBuWGN3ZHd0MFdE?=
 =?utf-8?B?VktvSTlQWCtZaThTRndSTGZuWUxKbE84a2tLMFdBUzAxczE4S1pLcUJEWkRZ?=
 =?utf-8?B?WmMvWU9VZEJ2VE45WFVNUkt0S0pHemZzRm9BdlBjL3hDQVVEVFQ2TTNqWHRM?=
 =?utf-8?B?WUtJV3RSOVJIdXdjRGpCL0RDM25pazJJWG94SnU4cnlSdkh2RXEycHlMQktQ?=
 =?utf-8?B?akd3a3dnTUdKOW5ycVdTdi9jeElUcmpHVnczQ0NVOGxZVW13enZtK0VlTkVq?=
 =?utf-8?B?bW5ZYjYrUGY5WWUzNXRxWnBuK2pycnpPdnpUb1JmL3VEWmJYMnJydnlrcmlu?=
 =?utf-8?B?Nk5hekttVnRDZE1hL21SU2Zxajc1YkxmVWhOekJBT2NUTnVKQ01BRmNSWHZ6?=
 =?utf-8?B?R24xektheWgyaGk4RHlzVVAvS0pnclpDZ1JSK0YwZ2Yycmc4TGw5b2p1Tlh6?=
 =?utf-8?B?VmhCOVBETjdoZUZON0IvQWZmV3pUdys4ZktiLzg4Q2F6Zm9HLzYwYmFyZ0sx?=
 =?utf-8?Q?4KOuf4KX4qrN39hkDegQ1kQ0j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadda413-b7e0-42cd-1002-08de307c48bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 01:52:29.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzPMbqhUog8PEhYaq0ihqgR+s12zDC16PiFe4iKZTk42sJIWeXTvvGOe1g+TotFikjk4/D7ypxoucvNYxl2Obg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8317

Hi Nicolas,

On 11/29/2025 5:28 AM, Nicolas Dufresne wrote:
> Hi,
> 
> Le vendredi 28 novembre 2025 à 10:51 +0800, ming.qian@oss.nxp.com a écrit :
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
>> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
>> error and produce corrupted pictures, even led to system hang.
>>
>> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
>> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>>
>> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
>> Then this allows for successful multi-instance decoding of H.264 and HEVC.
>>
>> To achieve this, we can have g1 and g2 share the same v4l2_m2m_dev, and
>> then the v4l2_m2m_dev can handle the scheduling.
>>
>> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> 
> I like where this is going.
>> ---
>> v2
>> - Abandon the waiting approach.
>> - Switch to a shared v4l2_m2m_dev solution.
>>
>>   drivers/media/platform/verisilicon/hantro.h   |  2 +
>>   .../media/platform/verisilicon/hantro_drv.c   | 41 +++++++++++++++++--
>>   .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
>>   3 files changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
>> index e0fdc4535b2d..8a0583f95417 100644
>> --- a/drivers/media/platform/verisilicon/hantro.h
>> +++ b/drivers/media/platform/verisilicon/hantro.h
>> @@ -77,6 +77,7 @@ struct hantro_irq {
>>    * @double_buffer:		core needs double buffering
>>    * @legacy_regs:		core uses legacy register set
>>    * @late_postproc:		postproc must be set up at the end of the job
>> + * @shared_resource:		flag of shared resource
>>    */
>>   struct hantro_variant {
>>   	unsigned int enc_offset;
>> @@ -101,6 +102,7 @@ struct hantro_variant {
>>   	unsigned int double_buffer : 1;
>>   	unsigned int legacy_regs : 1;
>>   	unsigned int late_postproc : 1;
>> +	unsigned int shared_resource : 1;
> 
> Instead of that, I'd make an array of compatible node we are going to share the
> with.
> 
>>   };
>>   
>>   /**
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index 60b95b5d8565..f42b2df86806 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -35,6 +35,10 @@ module_param_named(debug, hantro_debug, int, 0644);
>>   MODULE_PARM_DESC(debug,
>>   		 "Debug level - higher value produces more verbose messages");
>>   
>> +static DEFINE_MUTEX(shared_dev_lock);
>> +static atomic_t shared_dev_ref_cnt = ATOMIC_INIT(0);
>> +static struct v4l2_m2m_dev *shared_m2m_dev;
>> +
>>   void *hantro_get_ctrl(struct hantro_ctx *ctx, u32 id)
>>   {
>>   	struct v4l2_ctrl *ctrl;
>> @@ -1035,6 +1039,37 @@ static int hantro_disable_multicore(struct hantro_dev *vpu)
>>   	return 0;
>>   }
>>   
>> +static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
>> +{
>> +	if (!vpu->variant || !vpu->variant->shared_resource)
>> +		return v4l2_m2m_init(&vpu_m2m_ops);
>> +
>> +	scoped_guard(mutex, &shared_dev_lock) {
>> +		if (atomic_inc_return(&shared_dev_ref_cnt) == 1) {
>> +			shared_m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
>> +			if (IS_ERR(shared_m2m_dev))
>> +				atomic_dec(&shared_dev_ref_cnt);
>> +		}
>> +	}
>> +
>> +	return shared_m2m_dev;
>> +}
>> +
>> +static void hantro_put_v4l2_m2m_dev(struct hantro_dev *vpu)
>> +{
>> +	if (!vpu->variant || !vpu->variant->shared_resource)
>> +		v4l2_m2m_release(vpu->m2m_dev);
>> +
>> +	scoped_guard(mutex, &shared_dev_lock) {
>> +		if (!atomic_dec_return(&shared_dev_ref_cnt)) {
>> +			if (!IS_ERR(shared_m2m_dev)) {
>> +				v4l2_m2m_release(shared_m2m_dev);
>> +				shared_m2m_dev = NULL;
>> +			}
>> +		}
>> +	}
>> +}
> 
> Then instead of this, I would like to add a kref to v4l2_m2m_dec, I checked
> already and this is both safe and backward compatible.
> 
> Then in the get function, you will walk over the compatible that are different
> from the currently probe node. If you find one that is initialized, you will
> call v4l2_m2m_get() to obtained a shared reference. In _remove() you will simply
> do v4l2_m2m_put() instead of v4l2_m2m_release().
> 
> Hope the others are happy with this. For Hantro drivers, this will make it a
> much more powerfull mechanism.
> 
> Nicolas
> 

For v4l2_m2m_get() and v4l2_m2m_put(), do you mean defining these two
functions in v4l2 m2m, instead of just adding them in the hantro driver?

Regards,
Ming

>> +
>>   static int hantro_probe(struct platform_device *pdev)
>>   {
>>   	const struct of_device_id *match;
>> @@ -1186,7 +1221,7 @@ static int hantro_probe(struct platform_device *pdev)
>>   	}
>>   	platform_set_drvdata(pdev, vpu);
>>   
>> -	vpu->m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
>> +	vpu->m2m_dev = hantro_get_v4l2_m2m_dev(vpu);
>>   	if (IS_ERR(vpu->m2m_dev)) {
>>   		v4l2_err(&vpu->v4l2_dev, "Failed to init mem2mem device\n");
>>   		ret = PTR_ERR(vpu->m2m_dev);
>> @@ -1225,7 +1260,7 @@ static int hantro_probe(struct platform_device *pdev)
>>   	hantro_remove_enc_func(vpu);
>>   err_m2m_rel:
>>   	media_device_cleanup(&vpu->mdev);
>> -	v4l2_m2m_release(vpu->m2m_dev);
>> +	hantro_put_v4l2_m2m_dev(vpu)
> 
>>   err_v4l2_unreg:
>>   	v4l2_device_unregister(&vpu->v4l2_dev);
>>   err_clk_unprepare:
>> @@ -1248,7 +1283,7 @@ static void hantro_remove(struct platform_device *pdev)
>>   	hantro_remove_dec_func(vpu);
>>   	hantro_remove_enc_func(vpu);
>>   	media_device_cleanup(&vpu->mdev);
>> -	v4l2_m2m_release(vpu->m2m_dev);
>> +	hantro_put_v4l2_m2m_dev(vpu);
>>   	v4l2_device_unregister(&vpu->v4l2_dev);
>>   	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
>>   	reset_control_assert(vpu->resets);
>> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> index 5be0e2e76882..5111ce5c36f3 100644
>> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> @@ -356,6 +356,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant = {
>>   	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
>>   	.clk_names = imx8mq_g1_clk_names,
>>   	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
>> +	.shared_resource = 1,
>>   };
>>   
>>   const struct hantro_variant imx8mq_vpu_g2_variant = {
>> @@ -371,6 +372,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
>>   	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
>>   	.clk_names = imx8mq_g2_clk_names,
>>   	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
>> +	.shared_resource = 1,
>>   };
>>   
>>   const struct hantro_variant imx8mm_vpu_g1_variant = {

