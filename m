Return-Path: <linux-pm+bounces-29322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73966AE40C8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708657A765C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11623248886;
	Mon, 23 Jun 2025 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SaZl12Cw"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49951248869;
	Mon, 23 Jun 2025 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682593; cv=fail; b=pYaCP6qu8zHTo7ZnRJ1tb3ViHjjX2rl0IveXLXPVGKOhoJ6bk+tbq8ddQLAkmteP9457P9xVNXJx4LpWo0EGzZZUrCJQWBNjR9p4egrrVbyViwqxbzKeQ6MaP0J7TX85UyUgbTpGQex2FWiZAh7QT0vGaEsaC0buW7c0xwibCbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682593; c=relaxed/simple;
	bh=mtKABeNl9bsn6KpzM02VkMvjMWLJR2UXDz0RgpeaMPw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NKfTPUOvwM4255N/6YTCr1VSprQo5fyftL3Vwt59t/fN8rOoKf8cpSC0vYe0BiStSAHINBdvI59/f5BjItl0qPg1y1g2zAPW6h4CcqF/XnRYngoDrdUtodZIfP1VtNVjU/q2s0xhGZoJ6UVIqAWkmvbwPyeNFJbDrD1qLC5e80g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SaZl12Cw; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvEuap8gp+KyXDQnQ62OuRibg22LNF9y0vr4C0ucrM5oQhdyMCNv7MM17tJ9rpjBwMlMf9vYvrABvdm8YG6VM55tPHgffuHEcTZjE/y8iEJ+DzyRLL1hEOhyIAH3qlWFaC/9GwU4O+2upn4R9mM6UVceKyY2A6YWklH6Kv0AMOL/hBY/XPx1Iz02MhSiPnOD4FO+Qv++97VwekemyrufXFyPp7S14G4PyooUDqJ0TkDpOpvRiFHo+hPKO4559DJqnX4ZKbuNd523fGR/vZ8qJggNQEzonYnbPR4s/mY8X58DhzQgunI9iKHSZHOMVZiMASHPeK6+tAeDYygQ2qsP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrdQYRzc4i6gQxXe/L3NrovTIRXD3dty8Sm3Fve1Uck=;
 b=Xd5FOmvpSTAjWzRBcVre5zA7/fwwzZaaolX2DmFI1Oa93POK5HAazrjFN0uuO4+Ii7wlHGHMInD3R/HglNJnUrCaNo0Q2XqBACUh4vO9c/o+FSnFbsi0tjpk7ASuIQ3x4M4YbYxyNr/RgsApRK+PBrZpqFVhLWK2w7QLh78wHN5jchf00lX2EAxSQiI3ZIe83dHzMsJ/Yq45AiZ9zhwu63lxNGVOPjsK9Hbg+jCL8XqHoOe9ayvYNZpwGLPi+xCyEiIyBAYuQWP3N/1t2RQ6GVIX2U9zG6FGaG2SAhSLPE7ejVK15SZvtkQKjOrggJ4uKmVMXH4d0Z7OJfxMKHzhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrdQYRzc4i6gQxXe/L3NrovTIRXD3dty8Sm3Fve1Uck=;
 b=SaZl12Cwqfjqb+QzXcm1HN9JrItZLQ4fvHliqUxvCxXz8bV2ONrekTpSlHOk5ih+1XNWqi/yfD9aq4P3EW2mnZRbmeSNuHdWSqwvksiaz7NJwXukpP3Ycs7qF1hkr62hFW2vp7RDV2iCyL8ttzBzni2BgYLNZumuOyX+t2UWdIk9CBHwzKzpTyRwXtVWSyNx9XQYQ0AUKHhUik9o7DvPQsELgF+cdm7DjpG2cXTzt1La3efvSpqhfc2dzLLgF+sfuiOALtwIBD2q5zp1rs4z9YFo/OC7+EnWdgdmtj58u/iJqUMvTYrdgDUlllJ1m5ljKcjhD2Ng64ZCv9KSYD1RwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SEZPR06MB6611.apcprd06.prod.outlook.com (2603:1096:101:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:43:07 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:43:07 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 22/24] thermal/drivers/imx: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:42:57 +0800
Message-Id: <20250623124257.475083-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SEZPR06MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a0fcd0-ee84-41d1-0547-08ddb253811f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGx4OEFCelBOb2d4cTJVUFV2UiswNU1LQ2o4OFBVM0F0Wm9oWEhDUThOWFlD?=
 =?utf-8?B?anpwTVg4YndXWnVpNzBvYWxydU5xNmdUcTJPMFhLM2RpbkkrcytiVmJPM2Fm?=
 =?utf-8?B?bTJuTzB1V2djTXZ6RHYxeTlsVnhDMDV2VFV3d3FXT0RiY2d5cUR5aGZac0pU?=
 =?utf-8?B?aS9DNTZWK205Mm5Kd09nRjYrb1d5Mk9uaE9iZkNTOE9SUXNNSDl0Q0N6SmpN?=
 =?utf-8?B?dmxKbnFmMXNFQWc0cU44N0ZiQlJVQU1wUmtJZ1Myc3JGNjlYcFVMRkc5Slht?=
 =?utf-8?B?ekNIc1lwME43aFpOU1ZqVUV4RkpwSmpOVUhwTGpzcWtNbXhBQWEwaE00aVZF?=
 =?utf-8?B?UnZBYzJDLzhxMU9ZdTZ0UUtxcEYrWWN4UCtpdVMzVWFSbUZTUDBQUDhrL09Y?=
 =?utf-8?B?L0lkYnlldXhBWjJ3WjZ0SjJ5VjRueEF1TEM0V3JDU2RoendrM0ljd2VsUUgx?=
 =?utf-8?B?VjNSelBubkdTbjdpZk1IOVpQTGQyclhRQmpBemI3U0htRXFzUjFLa2RmdmFr?=
 =?utf-8?B?N1h3SUEvZXNDWkhKRGpKSU8wdHBxdVJEem00aFo2U2ZsbVBZYW5Md2F6L2Vu?=
 =?utf-8?B?SlB0UTJEcXNrWlkzdnlpQS9WZTc3WGREQ21iMGlpTkZpeFhwaTlvVHQxYjBL?=
 =?utf-8?B?dk1MYmRqYmdxaDBrOUJjVm90ek1TREw1RDQ4a1YrMTVxRXh6TVZUVDY1dVlZ?=
 =?utf-8?B?WkJFS3N5K0dCUjZFUWhNankxNm0yZVhZUlVZUVBGOExpYWxocENWdjlFUW41?=
 =?utf-8?B?eU1pblhkY1hvV2FkRGY5eWtRLzRnMmlDS0pMSW5aYnplSHpFQlQ2ejlaTXd3?=
 =?utf-8?B?dXplcnJMOU1mQXZhWHZ2S3FTTTFseDhmQTdHVU1TVWRuYitMWmFPMXhVNkQ4?=
 =?utf-8?B?NmZCb2NJVlNHWWpORW9TWmwrZzMvN0x5VjliUlUyQkVWMURCaW1xS3AwdnZM?=
 =?utf-8?B?VmFRV1R2aUJHQXl0SUhDTG0vMUdHWXJIclA1UjFKdDBYZVNlTmRBdDhCV0lG?=
 =?utf-8?B?a3pVRjkyTXl2RURMM3kzRityU3B6SlpxcE4xRFowbnEzL2VzL0NnOEo3OUxQ?=
 =?utf-8?B?a05aUDdja214WGJwUXh2RUxtQUZtWXUrZzZVU3JGQ3I3N2J1cWE2NUFmWXBF?=
 =?utf-8?B?c21uV2lsMnFwdmJNNjJseUFqb2grcEtPQit0WUNuNlJwL2lzWngxK0hEelNI?=
 =?utf-8?B?NjVLMXFCU21oV1ByWmd2TFdydXFjb3pwS0xMREpVclNvV3JSSXpjVUpjdHRX?=
 =?utf-8?B?S3FpckhKR0VYNll6eHU0WUlpZDUxZkJJTFE5NDBXK1p4eUJSdytmeEFwOCtw?=
 =?utf-8?B?R0w3b2tCdksrK2xlelB5L3NWUmlXSkZSTTNrdjJ3UVVjaTBoZ3VocG1xWU1p?=
 =?utf-8?B?M3pmL0hXNW9kV0h5NlpZQjBHSFJic1p5RHRGakV2RGZ1Z2g1U3pPeFc3RGF4?=
 =?utf-8?B?YjFUZ3pWVWhWSDZWamV5dURSSmpwclU4YWJXcmxyQXd6VHk5RDB1dVJJWTZi?=
 =?utf-8?B?L2JPSmY3T3l5cTlnRkxBd2d2S2RLbXowMGt4bGFuTzBGTWFTNTBUMzhkK3BV?=
 =?utf-8?B?UUFWNXNudlhrYjFtMmJUbmNQdWNKZ0IrWjQ5TnBVYXFQWTRjaUJWM3lxSHRP?=
 =?utf-8?B?aWtFUjhObEJpcGNPcStWb3Vsd1YyU1MxMGRpQXFaUlVYV1pHaEhzNGRXdUNS?=
 =?utf-8?B?K2VwM0tiK1ZsaHpscjBsMWJ1dlRKWW52eFBUSE9neEtvRlNVVWRCdUxocHpx?=
 =?utf-8?B?OWEyM0V1MVhXWktnMkpIbDdWa09XZ2xBRm9STzVvZGdrakRxNnd5aFlwUmNN?=
 =?utf-8?B?aGxvci9YM3Qxbys2TWUvN2RoWlZvKzZvQ3VLamR1dzdGSDd4aUpzODZpMkUy?=
 =?utf-8?B?RU5hMjJ4RE9EUG9zc002KzRnVmorSTgxdnF4SlpUUFdkL3dkTmduc2wrNTIx?=
 =?utf-8?B?YkZYS0ZKWG03Z3g0RGMzSzVsdDBOajZ0NXFGOVRZTUdvZXJqakhHSXE3cUNJ?=
 =?utf-8?Q?8q9JjDKv9KunGgUNj4xGh3J/XgiQkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXJZTEphb2ExZDRuMW5Pc1hEY2Z5aDAwczlaZldFNVI2b1pnSVRFV0RDUFBQ?=
 =?utf-8?B?QlJzOGprZ2V4c3paQ1FhOEpNSHVaUjFkb2djR3h0VlYzYllRMmRPVGxXdHVC?=
 =?utf-8?B?eXVOTW1UWjJmWDFVd0dHRUNiZWsrd2hlaXFvY3VYWmdGVmZGYXVRMkVWUnlh?=
 =?utf-8?B?QWR4YzJmMjh1NnpIdWJxazV6TGg3QWpYcVlZUWpiOC9iT0NDaW91bnFmR2cr?=
 =?utf-8?B?UmZXdDJTaDhkUW5DVW5vdzgzd2pUaHJ4bzRoWndrQ240bkFZck1xa3VqZWMz?=
 =?utf-8?B?RHVzYTN6WXQwbC8xRk1RcFVKYzFCUGpzRlRrRVArMm9nbXNNV0FVV1NBRWVv?=
 =?utf-8?B?VHRkblliTDMyVFZzN2F6Y1dVaDhnU3kvWDhhdE1FZUpyMzFGR3poYS9YcC9n?=
 =?utf-8?B?NStUUGp5a1pzbk1jOXRIYlh0dEdpZW5SYW82K0w2bGNNY1lROEFoazRNWlZK?=
 =?utf-8?B?QmFOeEwzWithd0RHbXJQSHhSdHIzSzZ0djl4NFJNOGVHWVZIb29tWndRWE5n?=
 =?utf-8?B?M00yTVpGRmNZaWRqUVdaam02ekZVWmRFTFVFUFd4YU1qQW5GWlo4cVAzK3NE?=
 =?utf-8?B?aUdRQ2h4TDgvVXZ2dDhmV1ZmUXV6ang1bG9RS0t0NEozdjBDU0IvMG1sSkhE?=
 =?utf-8?B?ZHBSdjFOMnZJN0JyTDJ1VjFiclpuRFFpNDFYeXdQeVlnZXU3WldIWkRFYXlQ?=
 =?utf-8?B?a1IvSWs4bE9EbGVyajg1bm9CVUxwRHdoMnpUckVGZXJSRXFFWHBMdXJzS1lC?=
 =?utf-8?B?eUFRMDhBVlBsWkI3TGRSUDNHL0w1bUlCdERjeGV0ZXRNRmJiK0hrS0RaUVRH?=
 =?utf-8?B?M1NOVXhwSFFSeXJITWg4Z1lZQVZ6d29aakdTSFRpdjFiQjNDbURZamJVRTZ3?=
 =?utf-8?B?OVd6MjVuZzNTU01PNXRiMVdGMGVPT3pwcDdaeFZwQ1JYcHUyL25nL0VucGo3?=
 =?utf-8?B?SklscjQvNmdWRnJiWnB0QXNSa01LalB4dW5laFVML0NyTFVqTDJxWkpOV09k?=
 =?utf-8?B?Wmp2RGJUOHZ1QWt2R1NxRllDNHlCY1VjZmZERFFpL3NPOWw4TVNweEs4VjJr?=
 =?utf-8?B?aUdjaHY0QXJzWTBqMSs2ZkpWN2FsSld4UHAvZmNwdHRyQS9ZNHpyQXQ5NVZW?=
 =?utf-8?B?TkhPTDhLa2x1WWNEaGxNc1NPaThOSWV3N0NFM25pQnZJTWl3RkRmc1pNVGsv?=
 =?utf-8?B?TTdkN3RUS3p1YmtGN3BMYlIzSjZsYnNMK09oZkNlS2RMYlZ1YW8xZVh0ZUZp?=
 =?utf-8?B?NUZMU3Bpdm85ZmJndkZqM0RDbVpKaTZtZElRdmZSRGliVHRIcXN0SzhOc0pq?=
 =?utf-8?B?ZFVoRlJRWEk4Z3FyTC91cHpCM1psT3l4MENCL2NrUGcyVWFhVkdkK1V6c1Jy?=
 =?utf-8?B?NE5PeEZ2QkZCQ2RnbjNFL0Y2cExSTkM3cnBHN2xoQVhJaXFkMlFvdjE1VkVn?=
 =?utf-8?B?ZTBQR3cvTHRuTjgreHFzNHFOZURJVU0yUE5PYzBpSFkycVhRTkgwYkxFTVJF?=
 =?utf-8?B?ZERWcEEvMWJwaCt0akdSMGJOTHh1YmpPUnRRTlh1MTVHbTd2UXlMUVBKektk?=
 =?utf-8?B?Y1FkK3hKRmx4dVBVNDg2S0M4T0xadlE5cFhNOFRtZkR5MTdMUW5WWi8vcEpt?=
 =?utf-8?B?OTY4N21qdVl6LzlUMVVMYklrYTZQL1IzZmxjY0Y1bGRvZFdJQ2hvNUxWWEVI?=
 =?utf-8?B?TU5nVkJqUHV6cVhvZnY2SENsc1AycDBzMVd0MGhVbm5FSUp0WEJlNmhSdUJq?=
 =?utf-8?B?Q1BvcDVhTkJidlRZTm8ybVJkdS93eG15THFtMGUxOThPbytLMzluRmhjTDFQ?=
 =?utf-8?B?enU0a0VOM25kRVJXcUJJSjRqRUF5VnlLTVRaV29ZZWJLUGNPcUh5c0QyYnJs?=
 =?utf-8?B?a2lEd2o3MXdDdUFjRkYwRzEvL0xOdGVQKzlYSUxkVWhVVzJSTnowWGhFWER0?=
 =?utf-8?B?NlF2U1M5WjUrREZEbzVpUWp1NVVkbk9MWTEvTUJhclNrL0NqcjBTWVd4aHhL?=
 =?utf-8?B?eWFCd2JJa3dvT3R1cFNyT0xUdXduM1FENE9wYWJKZm5hQ3hrVFE3bUtmTFlr?=
 =?utf-8?B?bnA5aVJpeVZZT3g5K0kvMXFvdWd3bFBrVCtJS0lHOW5WRjkzQ2l1R3FyVHZ1?=
 =?utf-8?Q?hlgiwCY1A4jGN0t2N+42Id/m+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a0fcd0-ee84-41d1-0547-08ddb253811f
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:43:07.6770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tg32qEwa3U4FZhGPDubLC6mZexaXe6TGAQsynMP23YGcI4IyTyM8C9Ex9hUaafQUPMvgjRexLrJOlG25paxDIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6611

From: Yangtao Li <frank.li@vivo.com>

The new devm_request_*irq_probe API prints an error message by default
when the request fails, and consumers can provide custom error messages.

Converting drivers to use this API has the following benefits:

  1.More than 2,000 lines of code can be saved by removing redundant error
  messages in drivers.

  2.Upper-layer functions can directly return error codes without missing
  debugging information.

  3.Having proper and consistent information about why the device cannot
  be used is useful.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/imx_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bab52e6b3b15..151976d0820e 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -729,13 +729,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto thermal_zone_unregister;
 
-	ret = devm_request_threaded_irq(dev, data->irq,
-			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
-			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(dev, "failed to request alarm irq: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(dev, data->irq,
+					      imx_thermal_alarm_irq,
+					      imx_thermal_alarm_irq_thread,
+					      0, "imx_thermal", data, "alarm");
+	if (ret < 0)
 		goto thermal_zone_unregister;
-	}
 
 	pm_runtime_put(data->dev);
 
-- 
2.39.0


