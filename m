Return-Path: <linux-pm+bounces-29311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365DAE40B3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B371E1661F1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92989242927;
	Mon, 23 Jun 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GW4Fyu0b"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013006.outbound.protection.outlook.com [52.101.127.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951513C9D4;
	Mon, 23 Jun 2025 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682299; cv=fail; b=GlPClfoYRE/n3wt3S79ZGDmQeJtQVecQoe+rjjIt1zKpFvu6jW2+xNMR80rL+0lyoX98FHnyXU/GOWiAY8U3tqva5twcIgbAss65hUjYp2sBDu8ncfrS52sJKT8MnmgH9SPPQakCF0JPDQkD+KWj00SKn4guUCSnpf/0hToIUc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682299; c=relaxed/simple;
	bh=aQKsvtw2jQXc4yxLtx80Pf+ywcKnFzjo7yqEB8/jlTI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JjrqcW5sPjlpv7zZnkcMjlVVgTlL3zj9PjZ0FSXWR+7hM5h9dWy1MmuoJbRuv6DDzJpxEk5qG7NedDG+Pssd2paA/reLd8MjTSG7lg1L/unRY9WDNS3MpZF7fW1QMQAA4kUa6qa078769regrl70D+vgOYrRPruB9u+fGXobpYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GW4Fyu0b; arc=fail smtp.client-ip=52.101.127.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsh0AbbcjBXMQZQmI7KLoiyYRhoPOKIJ1KMfpSnwTmMuuzqstiFGuLeyxZNTxPnzunQ3Jw52XngocVn3UHcMuzhOqTdl4EAVYn7Jc1/d/UA3dBeIa2HcUt6M2rI31tENsDh44K+Mc0TVeiKx87cWnOkNAe7+cijB53Ws5lha7IzpcZSb42dewNFJJwEWDJnBq/+kCKA3HkSLlagFCFPfl2TI8rXRsMRcodrwTFjJjDzsB6Q9tFWqegsjXavvizfz60aZHfR3AljWa1u7QgU7VNxm56wFYcXiN1sL0t9t3fjg/I56+NhY/wKCX/So+JeW7JrB2MFWIzWJmm0SaEpDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFQ/WvBLOsut3WaC27zJRozhhVLUwCYvJ1a05/25L2Y=;
 b=DMyJfgJU4lqygo5HCwYa8svDyzIsQWYd1bNRBlgUIjo0UG5XIYSh0pS+YSZ3Jfdct7bG5epNbJPQ9kkhpn479OwLNdJvpPFvP/uk4bl/lJjxKdKP7LyVDjpRXGF67x60mQwbgZQCb+ZGpXHvxuwpi5LR6HKXLw5xaIxenLpjdUUC3Naj9hgwGWId+MGNzhF4mdq7gGx8/BUWgNtEDKyCXC35Kp9NCqln2s2ruIBZU61ou8txXeV7qTvc92KUC4btJUsPvFx0q8BGyQ5qfpwqSqStyfrMxSsUoIwmKkmy/v57lalN/OGEqPD/QSM6/OJ9j7XWwbJsTIHWVV3eUIYxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFQ/WvBLOsut3WaC27zJRozhhVLUwCYvJ1a05/25L2Y=;
 b=GW4Fyu0b+UcUBAx/XIS4OTv6HGTBkpJrlwsvOZ3uBSedPhrX9Bxk4TvcjvDkd8Ln4eeOLoNmxMYdQTXsMR4/MIEVRypEKTpWrl3FoaYXlY0aSXG00Jc2Yy/qG+wuW4WdEAArfA2Nr5pe3gjrIqO5/Aeg1k2Gc9lDurA5bpKX9+Jc52sgAGZU9WVec3C+ZIM16g+LA/eC4zY1D/erkTzsV4yei+qQHkEb1xfAsPG0FFFbJqSzeo3dJaMmhLJHyJCN1kGjDb6P8KnZ4xBXn4ce1ZW8W0ihsKoPuswOgJks0+mwKE6Jzzh3FXcNcv+TR1wjejq4OFuyvsjDd6ZOIvLBzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:38:14 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:38:14 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 11/24] thermal/drivers/exynos: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:38:01 +0800
Message-Id: <20250623123801.473790-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9695fa-a280-4c10-e43c-08ddb252d285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHRuN3YwS21CaERFVkxXcXd1ZWpKN0lNT1JOMFJuMVNmTXJmSDI2eGcvd3F3?=
 =?utf-8?B?MlJ2ekVvQVdVZExmYnRvaGJIV1Q1QlhPa0xCVDV1aWFPMDUzbTlIVDB5SEEx?=
 =?utf-8?B?TWU0QjlBQkNFVlB4ZHJtS1h1Mlc0aytjaHJRcmVEelM4dGxRWlJucFVhbExn?=
 =?utf-8?B?NXNadm9oNmhjYmZ5Q0UrNFFSa2k1UUJ1NGJUS1JYVTU3dUtncUhMTWRrcG84?=
 =?utf-8?B?dlZvd1pmWmZEZEtJNEpVQ1pMZk5VN1JYTlRnbGwrV0NvWkx4cmZuMndQVFBk?=
 =?utf-8?B?UlhJOFBBcnZZSktJMld4Nm94V3lGSWovMUxqeGNPdDVZSStEcDhpMndlYVBB?=
 =?utf-8?B?c3JBbldnYVBpS3lvVFJyRWx0K2VIMEs1MWVRNXFCU09OVlVFRXJrNlcraXV4?=
 =?utf-8?B?dmpnMzRHdENOdFBDaFJGSnMyWmxKY0hzV2oxMFZPS2twMEVvVnZIWmozcFpp?=
 =?utf-8?B?REdpbi9pUnMxVXBZZVJFY1o1UTY5MEdpems4Z3o3cVlaQzhqZ3RMSUFaOHhD?=
 =?utf-8?B?d1EzTlNMZStzM0w2YlZIaXNNQmJKU2IwVkQrcTlPUjhKcHlaZitxUzVLREwx?=
 =?utf-8?B?b1JhNVNEZkI2Z2VXRG9paGorRm56clFkNm1DWlZ0OE5wOFkyLzQ4Z0ZtYit3?=
 =?utf-8?B?ellCNk5qT00rQnRsQ0F3eTdYUUhjRnMrVVRtNTM0L08vZ1RidmtPOEorUUJv?=
 =?utf-8?B?eGVibTFsN3RqTGRncXNrUzI5c09oemlJMTNCRmFUU1pEeFpndkxjQ2NpR3Fx?=
 =?utf-8?B?Qmw4Szh1UGlLMHVaZzZrcHFuVU9PQlpzWUloeXZRNUszbnl0ZEtKSXgzajB5?=
 =?utf-8?B?TjJJZWd6d3dIa3dXQklkQ3hEVDJ4dUg1STN2OWkzNXRKaGtQY1Q3TERpOXdq?=
 =?utf-8?B?ZmJNYVRvR04wUHBrYXN3M3U1ZFp0NHBFR3h0TUZJVVVtTElwUTc5YVBLNFZ0?=
 =?utf-8?B?WEVwZWFkcUpyS2d3SkgzRXE3WUxHVVA4d2JQUHBiMVZiRTl4LytZNVhsVnVv?=
 =?utf-8?B?VVp4MHVwK082Y3JtRXlxbTZTbXdBQUh0SWtLNTA4dWY2eUxDcHNMU3JOTTg5?=
 =?utf-8?B?QkhJSnM5ZVFNemsvczROMDhwQ3VWYmNaR0lKVnpYemViOEtmcmdkUVpwUVln?=
 =?utf-8?B?SmxEc3p4ZkR4Ynd2SnRkbWVQODlLYVlSSGZlL3NBRzRDTk9SK0ZaVUtRdXVw?=
 =?utf-8?B?d2w2THMxcFNRbEV5WDh4T0YvMjFOcVRyL0hPaittTG1VaGFkbzI4Y0xuVURD?=
 =?utf-8?B?ZXBaSTgxblA1d1VZWDJ1dkc2dWh4b2NoQ2UxSFdRUzc0NUVXQ1NFblBtQ25Y?=
 =?utf-8?B?TWU1NnQ1MnM0cTMvejl4MC8yVXNvaVhwNU5CSXBxREJTYlV1MXUxcWh0VFFl?=
 =?utf-8?B?eXduQjF5Qnp5UEhwUkZndWJwVk5vcG9hcVRjMHlsSlhPRWdlQXlmbkNlRWVG?=
 =?utf-8?B?VUE3OVVCNlRsYlgrWWNDcnF5czBXL0NWVzNJVEQ2WFRFcUJqcFBzSndkaE1V?=
 =?utf-8?B?cFcwRUJNai91TlBKOHNaMnRZY1BWWUk3ZmhVWlZuV1NmUHdCVkllaURYc1NM?=
 =?utf-8?B?V0t1clBJTHNGNnNyZDVlK2lia21GMnFiWTdqUWVKUFlhbHp3bWcrZTdpRnNR?=
 =?utf-8?B?TldTT01iTmp0b01aNDFXNnp6M21kRWFKOCtnNkFGUURnQnM1SnRURmdoY3Vj?=
 =?utf-8?B?VEhvaFArcm1lbEh6NzdNT3Z4end5K01JQmRIdGRKaE01em5uYU1PS1ViSkZJ?=
 =?utf-8?B?eEloV3YwZkVub2JWcE54WCtzbzY1TG1Jd0YzK0EvdUhvK01UalR1Nm9MZURM?=
 =?utf-8?B?RjYzaEM0blJTVER6QU91c3VIYlJjYWxzL3g3Q25PL0EwQ3Z6Y0ZKY0ZPQk1M?=
 =?utf-8?B?NDg4RHhNSHdYd25lNmhHVUt2N3RaVlRpMFl1ZFZ2RU1QUzFIbEJqSVFmT3FV?=
 =?utf-8?B?VEZSRHhHRG5IbzE2ZU1hNFZ3YXhpdmJ5eUxWL1hhWFNZOFR6VVprNU5GUDVy?=
 =?utf-8?Q?y2Ei4jaxF4tazWOpX/qRSFNKWVJq/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekZIUkk4amJKUjhpSWlVK25oUXI2akhocUIzVzR2T1lFNnhnUEdTQ3hXM2RN?=
 =?utf-8?B?ZnhwU1ZJbXQzc093NWE0ZGVmaXYxM09GSndUdnBSMkxUMTZxT25JaG5FWmxl?=
 =?utf-8?B?Q1NDbUxldVhtUis3Rk02cnZGNWRINFNvVFBXQ0J1eEd1SzlsZnEwTi9lZGxF?=
 =?utf-8?B?R2NobGtLSEk2YXBJWWVydjVFaWRQS1cxQi93NWhzWUhZYUxJOWRNK3hqYmtG?=
 =?utf-8?B?b2cwQ1AvTG9Da0RLc3VDcngyQVZRZmdnWUZMaFI3YzlRMVZMYnNWdEFRdCtN?=
 =?utf-8?B?RjQ2OElDZTg0N0IrWm1SdG1xU2pwc2tST3NzSTVtUlNFSnhDUU9lbVoyTWd5?=
 =?utf-8?B?N3pqb241NG1iODZDMEpwVnJGaXlaL29jOEhwUkpaVEZyS0NJVGJiV0Y0Q25Q?=
 =?utf-8?B?OFVOZXJyMG5EaUZMOXBrZVZrdkVNY1RDeVlZRW4rRlgzbEJTYWxmOTE5WE5r?=
 =?utf-8?B?dzNoVytiQ0UxS2VqYWtoZlkveVNrVThRN2dQN2d2dWFGSDZrcEUwZS9nTElG?=
 =?utf-8?B?Sk1hSUd6MklzZFBmbC9Pb3R3eG5FTVpjQ3M5cHgrTXltY1Y2V3QzT29qVkMw?=
 =?utf-8?B?RXZqOUFuajU1dDNDQ0RPQzRwUXlqTno5OEErZDgvd21HOXVKY0F0WjRvRUN2?=
 =?utf-8?B?d3Z3cDN6d0xMUWtjN21EUTNBRFJJaEZBNmo2dHY0OTBacm1UMWpIUmdrWkJF?=
 =?utf-8?B?bEFmUjV6UWExV2JtcjZVTHRhdGh0MzBZQXEyK3UrcXFqQzYvQWhuT1NyRGdh?=
 =?utf-8?B?MlNPTTZhTXdabmc0YTZSME1GNDlDUzlYQ2s0eVpoeVlVSFV4VXBOZUlPeHFV?=
 =?utf-8?B?aDYybEVqUGhMblFDRkdDUFVhOW8zZFVTYWZ0WlpmbGpPbm1YNHBuUlE5bEM2?=
 =?utf-8?B?UVRuL1NId3VPRkpIN25IL0kzclFMM2ZuS0VVUE9zSVVjajM3YkhHUDZXNm5C?=
 =?utf-8?B?WWdBUU9nZW5MaW5ic1RoWitJTzVwcGhjZkpacGZTcU91YThmM0orNFJFdnph?=
 =?utf-8?B?UUtZcU4wbjZhR0Z5eSt1Ymo1dWxDTFFUbzV1M0dOSFgyelhubmMvaHkzdU1C?=
 =?utf-8?B?eDA5di9tM25tREhKN29VVkh2eVVCeXF0VFUwKzRYUHdEU2Nkb0VXV3BRTk0x?=
 =?utf-8?B?S1ZucGJHWWJUekxXdDA4ZnpRL2Z2bTB1VG1DSGgxWmhOZURIRlNaYnp3YlI3?=
 =?utf-8?B?bFRXWUVRazlqcnJ5OU9NbWRuY0xkaUpqTS9rd3N4MWJYNTV4RmE1VmFxY0M1?=
 =?utf-8?B?Nk1hUWNSYlNyUkRaTDNHVGQwNHMwdE1YSFVPL2NmZzNLMkcrdytpS0p5VWhT?=
 =?utf-8?B?Q1VFRlRPSUZVbERqTEdrQ0s0T240cmxmYW5BUVd3M0JrQnExVDF0WHlOQ01x?=
 =?utf-8?B?azNSajZMMW1VWTE0RkhGMDB6SVRmWWZnSkE2TnR5KzA1RmxRandKQ2NKdHlq?=
 =?utf-8?B?UTZwR3JXbDlDcHFRWFZwMWJqOG9mYjVQdE5CSUwzVWJDYW9kZFRyR0orUnFv?=
 =?utf-8?B?dzdQRyt5SUJISk92bERvNlJkZmdaRS9pdGNORE5DaCtacEx2UHM4NWVKd0xh?=
 =?utf-8?B?RzRCZmVrOXRPd2JVdzdzYmFJRElBK3RmWi84a2wxVkI4NlhrTlc4aUxWY0o3?=
 =?utf-8?B?SVRRNDYzbzBOSlI4V0NzSnhVdnh6ck8wM1p1angwTk1xWUUzdHltZW5UM1Yv?=
 =?utf-8?B?dGgyVnlTa20zSXRrZHplbnV5dzVIR2lpbHFwOXpCSmMxQ0ZvaUNQUEdwcE1o?=
 =?utf-8?B?d3NmQ3hLWjAvRDZzK0JPNWZpclcxQVFEUDJqWUsvUTZLWFQwaTBsS2FaNDJw?=
 =?utf-8?B?K2RkbE9helJhSnZkdDZMV1ovZytYblpLS3RkbW5kZjBHSTJVSGtWY2E1RXc3?=
 =?utf-8?B?OE8vSnJwVkFYMnQrQkpQMzJkS3FpdEx5cDFiUlMyc0F0MUc5dTJ1VWg1MGJl?=
 =?utf-8?B?Sm1hdzJPSlJBS2FxbnlLRjIrSDVVNkZmTkVabXFDdHhxQ1F1VEU2RC96RHVp?=
 =?utf-8?B?MzBvSVF3Y3YvUldhV25ucWtjUlZ6cUJ2cFFvSm1RYWx2OUc0YWdYdDVFUDdj?=
 =?utf-8?B?UTRhdFdCM3l5OW91aHZOTTcwblkxT09VVjVaOTlUQTM5N1BQN0E5b3NEZGhR?=
 =?utf-8?Q?suGx0HMaDGcSIBUkqRUeLzsMI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9695fa-a280-4c10-e43c-08ddb252d285
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:38:14.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrcjwJ+CXpO0DcAkTgmlq8N2wjd9b78bLcX0IxSaRlecIoqC4nczF09JbeW+BedF5dUIxGSXqxClROMLudqlig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6196

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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..f8dc0a9bfa14 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1097,15 +1097,13 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	ret = devm_request_threaded_irq(dev, data->irq, NULL,
-					exynos_tmu_threaded_irq,
-					IRQF_TRIGGER_RISING
+	ret = devm_request_threaded_irq_probe(dev, data->irq, NULL,
+					      exynos_tmu_threaded_irq,
+					      IRQF_TRIGGER_RISING
 						| IRQF_SHARED | IRQF_ONESHOT,
-					dev_name(dev), data);
-	if (ret) {
-		dev_err(dev, "Failed to request irq: %d\n", data->irq);
+					      dev_name(dev), data, NULL);
+	if (ret)
 		goto err_sclk;
-	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
-- 
2.39.0


