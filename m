Return-Path: <linux-pm+bounces-29306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4335AAE409B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9B3178638
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2B24BD00;
	Mon, 23 Jun 2025 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TazQ7n3Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6172475C8;
	Mon, 23 Jun 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682155; cv=fail; b=ujVnjhapvDNcDas9V7AdsONEh6rfifOKQ38SpRIxR61SWUeloulXq7cJ2S5WNYa9Or5s5/gbU2yW39kf+0NtYkoZZJUPihCNKs28h1ybIQIlAfwKRMrUzyMw56040LUfJITPKDo1guJ/J5tqnzh5BxAg1f/6tsqIA0yjRF8Md+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682155; c=relaxed/simple;
	bh=WI5R8Syk2gjkITfeeuBiP29RV5EyuMNPTvVRPOaAHW8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NlOuCZUdchNut8liUh1EOO4DOoNP11+dXhxVRYi2RHqgfLwJdCDg0Im74lWsLPEBUHum5xVZeP/Nvconxxyr9ckNmGWte1rvYF8/HFgyF3QAOkoDRgDSXxRJzNM+1E/FGuTZHKI2/U5CsG9x7ELVsvc6X1t9c4PAL04wDVswOoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TazQ7n3Q; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkgLuywQ0g5lAhs+gE7QFQYzUk9gZTpu6N1olwgg7uJd74F0KWL08NTpeYDLH5vC/qg5D8GcwJ9ckZHd4VQP7y8gq8nXGTtC3/QmFJx1N5hLMFB3giIeVl9m54tLDvYdfx/hOD02EyI1Ua5NqX7NiJFD/TTHWTDejIlXzOCvTBGm2CLmJRH1mp0sETHlIBhN9So2P9fQGBuHq5ptcmT58maL75STGmLKtOYYC4DrPK7mVjjQ/LL3yPYxlhy85m6PICXbkwZpXRY86lqKeg0i5KRTcb/xbwhlXCOD2n4us3pQ1ozHCJObKrAra/yOlHZqwx84kwStZLPmbGch1qcOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbmJeH5i273iynv0vD4TdD2E7VSpTcg5MPtxKgWpqEk=;
 b=PVJagm5BY7Gzom8jaTEKuz0YyEHhSYRXkr8tRQR2YxHMGK4lnFch3LSrTJM1WapaOJhLaQ76VOMlj0O+l9n+smdaelpA3lUHqE/67vfWg5xiVvTy9mqcDtrR8Wt3Fnqfrt5Bwp1LmfXO3kXCiJFQ6y2tQqRB5ccVFkfQ7g6f3ZcVSEdafBNFnVBadVquQFk9gBX/yH7LKZ3dntVWpuIezwNAJQI1KE+uwIXNhxgKfl7RoJoA8QiKTdaAILlkp9MWLL1n742vvCOLlKpOUzN360gnNMBcIj+fTjsgz5tJewlbl2w9BnAm1OeH7nZB8mFGpP1o+khUHLTRFt2qtKvBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbmJeH5i273iynv0vD4TdD2E7VSpTcg5MPtxKgWpqEk=;
 b=TazQ7n3QoMQ14xnnVJfQScJfU6Q9KpTeWAWF7UwYIiQt1j4nfbhtjLStikiqbyND+kLEcHY/G/p5DLyo4hL3HVYeepZM13bOMlkPizYQEwOWVl6muKwnPKlOPrYgH231OTtUMSem2w70NI7EERLgIo8JuNOPPsqhqx1I49i7DQQc3YjEm5pI1V7JSdtmktk9lCp7/jHC4YTyf/wpMDoVeUtb7mwkLVUGp3CZIxmMLcXcAhAN5dtOgv2XE78X/TfNDyNdI0oXhHgxzQwKLNq1kKb97YskLE6d+IzUrGlNyopQJNdJ6XGbVDra9dZZ6DOA3xzRTfY5qA/FVtdIHo0QYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:35:50 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:35:50 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 06/24] thermal/drivers/qcom/lmh: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:35:35 +0800
Message-Id: <20250623123535.473392-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6f75d9-7ee8-47fe-e25d-08ddb2527c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGZLcS9vbWhVYjd3cUlnQVZZcnQwOW9KZ1BIQUx5K0svNDFaU0lNRFF3OVlK?=
 =?utf-8?B?U3EycHRFMHFvQmpVdDRZVi9UMisxcTJqeHp3eVU2QWM4ajE3YitIcjdPRnhC?=
 =?utf-8?B?RTZROEhUQ1NKeVFwd1Mxd0diZFF4bDgrdW4ydTFxQ2FDUVY2ajRES1ZkNlFU?=
 =?utf-8?B?eUhZd0RDb2ZlVEt2L3prR2E0b1pTNFBhZUNIejlCODNFSWtxZkRKWDNPM1I0?=
 =?utf-8?B?Y1p5b0ZDWXYvUmRwVkVJdXdraXQ2bXl0Z0NIY1NNdlBjN2RkVi9KeG1VRXBY?=
 =?utf-8?B?Skwyb1Z1aWxKcVNCVm11TW50Y1VGcUhVd2pPYnVaUzNONDdVSGxXdm43OWNH?=
 =?utf-8?B?dzZoS3FkanNwK1dveWxrOUlhV3JnZUFTTHZTOFU4dG5UWHVoaTBXNnVHT3hV?=
 =?utf-8?B?VzRISjVzN2wycGxYUDNyUVRiam9RcndvL2ljMWJQWXdVd0h4VUQ2aVBXM3JC?=
 =?utf-8?B?OXN5S2lld3hHYjN0WFVTTERxL3NjNDJNM0xhZzkrRDRaSVh5WlQwRjJoT2Q1?=
 =?utf-8?B?c2drZFRuYzBHQjd3UXlqWXZwUmJObGkyL2MvRFNjUEprN2VEcFpWaG1kU3Mv?=
 =?utf-8?B?a2VoT0VBMlFqelJYdTRKRlFrL2dzK3V3SzFUSWRpV1RBYmIvZnpYYjVlem9p?=
 =?utf-8?B?amhmVklnd1QwRFZsQStpdGlWaEVuZ1UwUVNkVHdiemJTY3BOc3NEL2ZSRHhQ?=
 =?utf-8?B?bjZqWFVSM3BnemsxWlQ2dUVpK3pKNlBVOEZITVZrUTBEZlJJQ3FLbG8rb3Zl?=
 =?utf-8?B?SWwwdmhoUjVkL1l1a2VHWkY5OEJFODE2N003MWp6LzdDWndPcVVFdm11NDRZ?=
 =?utf-8?B?enRqZWR1eDk5SExGeWIvWHBXSWdtbGhmdnAwT1VRYTV4OG5uU0puYVRsQVlL?=
 =?utf-8?B?N1hQbmdmQURqMWxHK3hMVUliRllFM2VFejUvYiszRTRDKzR4MThCc3JLa0cv?=
 =?utf-8?B?LzVHUTZGQ1hBZW9XQnBLWmpHZW5xam5JY01TbkVmQ0ZTVmNhQ1RMdHNxYWVO?=
 =?utf-8?B?UHJNeDdVQVNQb1lqcm9RNWUvUDIrb0VKRWVJbFpGSkZjbUZrT3BCRmx2WnpQ?=
 =?utf-8?B?OE01OWp1d0FiQUlLVTZHUXlhZlljQ2ZRSTdpbVpLeHpydjNPMHZ3N1NDS3px?=
 =?utf-8?B?SERYQ2tkYXUybklCZW11M1gvYld1ZmRMU2xZWG5YZkVvOGZnUXBYQkF0WkhW?=
 =?utf-8?B?Y0llM09IN1FCZnZvQjY3cWt5UnFKd0gvSEJ6eGx2MEVLdSs5T3U5S3h4dStj?=
 =?utf-8?B?K25wUXpnTmtPTFBaUE1oVnhIZlV6eEhwQnpNckFiR010TTJuUGlkSkcyeWZv?=
 =?utf-8?B?bExmQS9QS1ZwUk9PTEVDaEVIUGx5bzJRdVB0NHkyTTBURks4SjBQTncrUlF1?=
 =?utf-8?B?RDViaEtkbkFRdVFLT2xvWml3NW9FZlpYWXg3MWNKcjFRSzJWQ3Q1bXZmaVhH?=
 =?utf-8?B?NG90ckZlNkVJYTZKM09Ca1YybWhBbkNXRk1ZR2Fja3RUamJMZUwrWmZqcnkz?=
 =?utf-8?B?cmd4NGs2RS96ZnEvaFJveHk0b3AyTGt1WG1GaTlkMXR4NG83TW5iWkRUZnJy?=
 =?utf-8?B?V1k5QWVBQ3hkNk9Fdzg0NEw1QXBTOHcrMmFLZFFEMVpLTlU5dmhGWndpUldX?=
 =?utf-8?B?MnZlQUNOSjVLZ2VBN0MzaE5LN2MrdWRpZ3VWVWFveFVtOUwzQStDR1FhaTVH?=
 =?utf-8?B?WTlTL3dDQlZyUDlxNFRuMkdDc2h3YmF6bUhQc1pjczlaa3F0aHovRWNKbXQ1?=
 =?utf-8?B?ZHU4ak9scmNTSWhxV2JuN2NxOE1CaUg0cG91TXF2TnhFTk9tdHMwR2g5czlX?=
 =?utf-8?B?ODB1d0I0RFE0c0JHMkRjNnI2UmJxMnFQK2hSVVRYRUVwMldZV0pJTFJKN1dG?=
 =?utf-8?B?anZJMWE4MjNBVWhldmRMd1hwVmZUNlhJYS85cm5sdEFSUXc1dHBnVFgwUWpm?=
 =?utf-8?B?Y2ZBNGxMYWgxU0poM21SbjMzY1pmendQSE9MT29sd3krenV0cHJ6WFRhQkgr?=
 =?utf-8?B?R05yOGJWWWFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmFZVFpyenNsSnU1TmtvS28zVXVJRDZnakNmcU5UcW9ZaUZEQ2JqU1g1YzNP?=
 =?utf-8?B?UWdJbjlOaEFBSjRMQ1ljYkVlMmRiWmhCMzRiV01yVEdPRE9ETHhBM0lNZW9R?=
 =?utf-8?B?SVI4Zm9YNjZiTkhTSU5Kd1lBeG5jUnloSVUzeFNtRzlUc21tenloQ1NaWTBz?=
 =?utf-8?B?Qlc3b3QrZ1lOQjZ5QTU5Mnl0MEpIaWN2ZkhxUkhaS0VOcEFBbUkxL1NCSGI0?=
 =?utf-8?B?QzJyc0l6aVpRRGxackN4RCtlbTJCMFlEWWlzMmo5NHI1QjBsUlVyNWpFclYx?=
 =?utf-8?B?YzhqTXBxbWVvSldsMkc3K0NTUUJUL0x6blk4R29vSHJvOXRERmt4dXlvVU9V?=
 =?utf-8?B?K2VvdXdqY0xtd2gxVURPUHE1TW13T1FodzJSTHcwanRuSWpWL0oxOUNpemxR?=
 =?utf-8?B?cUxhTmM4WVc3bEcxbmd3QzUvSjZGckw4REg1cmdNK3c1bkFSNWVvUkxmYmRM?=
 =?utf-8?B?ZFVvK3J4ZVVzUHpxUjBFV1FRcmI3UEkyRGhaS2tXVzJqWDZmV3didXpSWEp2?=
 =?utf-8?B?a2NEZHp3Q0YwQVNMekNvTE1wN2w0VE1yNXZMOGxBSXVnU0d0ckxwTDE5V0Jt?=
 =?utf-8?B?N3ZGQVlHUzFqZGJaZTl6T1JUaEpHWXRPWHYwczNwaFMzT3FWV3VlZGpiTEFP?=
 =?utf-8?B?a2J1M3JELzAxVDNDc2NqejY5YjZFeVVPdGVRMmw2ZjJRaWpuMjJZRFZTSVpF?=
 =?utf-8?B?RlhpU1NkMW03bEg0dXF2YU5UOW02MWs2N0ptcEtpVVZYa1lkajd0RC93MWxT?=
 =?utf-8?B?VGVqcEp2MStEclVSYXEveEZTQWlxVTFMYlZUcHN5MFFOZW9RblZrQUpCZmky?=
 =?utf-8?B?WUs5WUhTZDhaYk8wZnpiNHpLUlorRkozZmZhZUdVb01FbU1kQjR4K212cFVn?=
 =?utf-8?B?UE5GTExubUVRSXpHSExZQm1adzRBN04yZ0JWRGxDV0xkU2hNZ2JJTG04Wjg3?=
 =?utf-8?B?SE5ORDFaMDMvVXp0TTJ5TittZUlZTEo4UExQVSt3ZzZwcnVwYzlOTDZ2d2l6?=
 =?utf-8?B?Uk5vbDBIQnhISFpmK28zZkdmWTRCMXoydzdXMmJIYnhZUkRpRno5aUpjOXov?=
 =?utf-8?B?Q29ORW1aNFd5MCtqV0RYQmx1eEhrTDcxNlFQbmdRWHFiZGJBZzUvbDlzVHZS?=
 =?utf-8?B?TXFQMlR3TXo2SkhQMDU5SURjbUp5azhiRnVFQTF5d0xKNHB5QnRBVmx0QWpB?=
 =?utf-8?B?UEREWG85cEZqTCtlTWNHUG1EZDJNQ2RlNU5ZSXlYQWQvSkVacFB0UXA4aU81?=
 =?utf-8?B?MmhXb1RuUERTMmRseXdMV1pEenhQSlNROFpXVHVycERlR0VGTGU2Rld1Mjly?=
 =?utf-8?B?OUw4em9GREtGRldvaXVVKzdXd1pGQUZjZXIwSFVzTXBkc2tuUUtsTWxyTUdZ?=
 =?utf-8?B?MWpGODNNako1ZU4wQjhWQiswc3RaSzZRd0tSaXJ5SHh5OHFnSjZ3SkgyM0tv?=
 =?utf-8?B?cHdXai9UNEUrNWdMS2kwR0phbFN3WWZPMWF6aSs1cTRQVWhGbUNYQW9hYnJi?=
 =?utf-8?B?NTk0a0doa3J1Z2ovUVNtVmVvZ0k5VzYrOWVMZGlWczExQitYUWgvRVR6V3lm?=
 =?utf-8?B?RjhVUTdxZnJzTFl6U3pZcmNYQUlENFpHbUh3b1BNWTBEandYMVBoc3VmRjdD?=
 =?utf-8?B?VXptYUtpeDVRU1dxMmtrbmtoc3BTeC9IOTJDbTNsQTRFcFA5cWhVVW16dWI2?=
 =?utf-8?B?SkczMTdQRld0VWtQaU1ZZkVsWFV4TTE0UE9XTEZpeEVrMndON1pONDBYa2Vx?=
 =?utf-8?B?eFN0c0FHN3E0K01pRmVYK0gva3lnUUNueEFkNCtSYmdrQ2lWT0l5OXV3TzA0?=
 =?utf-8?B?OWptRklSeFZSQ0lERDRKeVRrMWFPRGU3SVltci9XamtaU2pqaGduS05yZlgw?=
 =?utf-8?B?Nml6SFVTNGRhSzF3THhhcjlNeENmLzdja2dNaHJ4YVA0alFjTnVuWVBRRHcr?=
 =?utf-8?B?ajhQL28vb1FSWmZOM1hRUkRkN2pWSnJKc2JnNzlHZHhXYTVXM2lsbGRVdnVk?=
 =?utf-8?B?TCtwUHZNL2plZXdJQWx1QUwxSDhaYit5aUo1OFNrUkNuNWRFVHM2bjhHSkZS?=
 =?utf-8?B?cWwvTUs0NVRic0lOaHdjNU9ISUtHdXpXN2VNV2dYUyswamc2Q2JlY0J4eUNh?=
 =?utf-8?Q?uEdm5d9GvtVVl8caGOQYkDYVy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6f75d9-7ee8-47fe-e25d-08ddb2527c65
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:35:50.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8sbiiyhKukh6SbTxKHtW9j6HrTnd9154IR5cw8R9fF0g2WaL7LWgkdTTnnDpDqO88/QVj/5eoWnjT45bYaK9A==
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/qcom/lmh.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 991d1573983d..2d7751e31a7e 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -218,11 +218,10 @@ static int lmh_probe(struct platform_device *pdev)
 
 	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
 	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
-			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
-			       "lmh-irq", lmh_data);
+	ret = devm_request_irq_probe(dev, lmh_data->irq, lmh_handle_irq,
+				     IRQF_ONESHOT | IRQF_NO_SUSPEND,
+				     "lmh-irq", lmh_data, NULL);
 	if (ret) {
-		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
 		irq_domain_remove(lmh_data->domain);
 		return ret;
 	}
-- 
2.39.0


