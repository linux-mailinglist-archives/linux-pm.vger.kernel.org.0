Return-Path: <linux-pm+bounces-29313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7457AE40D2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A40A3B08B4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0B9248862;
	Mon, 23 Jun 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DxFhJlr6"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012041.outbound.protection.outlook.com [40.107.75.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4D242D9A;
	Mon, 23 Jun 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682353; cv=fail; b=igoB/zEcohzjh3YluMf096PdMz3JgtNqpAL/FtYKNedpJJxhb42PeO+LeH7fynNSstaSOkK+F2Td2AzAX3tEwhghK5voQJcyq2CQyChbaq6w3sOp4+FTxj7/2jbxLC9oSZSGQvVfeAg8+gc1gOlIUF6ZoyumCqa8JAXh13l+1Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682353; c=relaxed/simple;
	bh=4s9fPrNVWpql7MaLLT5WZfKQX7yJ6zZyqDRjalbu/Es=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D/HmaunhDGBQvI9lpRLiI9hja5zlrLe59E9l3flyZhnq6ixTcdX3yIdmwie3CFaqGAOs8eYBxUyLbIO8npUuf34FHfPEJ6sXihui/6Wd5j5YjLLiSqd+cvGx6P4oEjyitfdvcOLZIuDapsxWQjWji8dNKj1qwReoLMOU+dixf9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DxFhJlr6; arc=fail smtp.client-ip=40.107.75.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpErXNXsk8NmcgoL0RroBYOFdZKt0bYhBvFAjTNM6frL8ZFDWaE49SQNh/TrYPkjYpVrrWq8cmuxYlFRtvPylG2915k686JyajXSNJg9p70/QaWflCabcduhNhGp5EWehNDeiaiGArsnZI+qt6wZF0EOQDZE3pcgotZyWocv0oqvz6qr8CR9X/c8FAL/LBBfGiAc5pgserY4qLGSJUBNK7c2VDfSekEihU9zILNzRhfTwvk2I9CTOAujTobWpKOWfo+st6FGZ/EzDdavXEJDiOKsx8YQ+tU83tMiO194VoKQPsmYMtvJfRyfJIbk9eXw6aB+M7BJIdzWbgKxzBH7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qox89oEaUtSimHSecXNE0xE50l3zlhN7J9o5jMHrqyY=;
 b=dwWUhpX0K+unDBjXZ/PqdPZ3cQOzavfjGT5+b/WsPG97INLJl1gX1W6NtvgiSGOxj36hIbuBcGQuhbJK1AbsXgKTJAZuE22CbBiytjXxqiEzRPLAqbwM5tiMctwekbokyZGNShcznmO2LaPC1oJzzr0+msUXQ/mDLL0pL558R113rIV9oCvi1n/tgr6Fl3fTdAvnenwksFZcSueO0f+j0Q0pJSIrE0rSFZKJuPMKbjez47QdH3haTFJo2LfCq+JRws6nwKXfCQd53tmz+NsSD2DM0e51avmPeXNBbbtWraxA730SQypL8rXh6maYhhJdXABiBtaVVe2ZbC4umn/dVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qox89oEaUtSimHSecXNE0xE50l3zlhN7J9o5jMHrqyY=;
 b=DxFhJlr6El1fIpTxUiQVzxFtyaPFcy9VnRz8EZzCMmB3zmZLGno06e5zMrOWsmxLX59DgwOaiAsuoRT7XGHcS3wSSjbiHUdQpn9RF0pYezYsweP8Ro8Dl/yitcsF+TEllb+dhAdiMzoMA0azVblDjWp67lunpyChMCcjEjZX1ZcUjys3uwyAR/QpEaRVrfQsX9EiDL+OiDj65bV7MTbZxNcg0Fv6n2CRRNGyknl652s30ipmCtOl1k8cRu5a7ugeosykSHx1awChRgvI1KnOyED53vxfzjbGNfHfhtmX3N0XdiVjhqhL4mk9K/2dE8+c+LSFlMQ8/A8+LA4+jGdyNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:39:08 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:39:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 13/24] thermal/drivers/rockchip: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:38:56 +0800
Message-Id: <20250623123856.474015-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ab1e6c-ca1b-490f-7ca3-08ddb252f2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTJQWmo4bzJ1RU9wQzdRM3Q4VGF6SHY4VTJUQzh2RWROUzRWUEs2Sy9oZDl1?=
 =?utf-8?B?b05TMGdOdW8rcXZEMVVKTXZmNHNIN2pTUlE4VEVTb2dOU2lCS3pwUkxtVVlZ?=
 =?utf-8?B?N0hLa29WcDVGNG9FOG11S0FLaDIwNXJjdHVMRXVYYVdnQ3FNcUtMVFppYUJQ?=
 =?utf-8?B?ZzdGWitpUlJ3elN2eUNLb0FVUEhBYmVwSUtNcUtva1NvMzlrd0YvaC9uUktN?=
 =?utf-8?B?S1M2WWtLU3hyRG9JWG5ZdDFiQTdoemV6WW1LNFl0ZVd0TVBocVlqRzdXMXlw?=
 =?utf-8?B?SzNXS3BLWjNPVmcvZndpRVZSYkM4blRLL2RkRVB0bnBUUWFxUnFnVC93RWlG?=
 =?utf-8?B?T1J1Ymg4ZEN0K0pid2Z6WkpxNldLSVJIc3NCY2tneEFEdWhNNUVGUUhydytC?=
 =?utf-8?B?RkQ3aWNJWUFRbG9rdS81WXQwb2JjR2VtOEFTSm90SHA1RWhVMW5TNmV0U0dm?=
 =?utf-8?B?SzJsQVRBamVqMjhrOGR2anQzUVdacW1BcEdvVkZ1cmxOZnJYL2hDWUl4blZj?=
 =?utf-8?B?RWtVSFQvTTdQNFRFSjFHWWJNODlpSkZsdFRiQk9DZTB1N3A4WnFIY0FHQU9L?=
 =?utf-8?B?MTB5MjZML1hMdnhlQlR3QUtSbFV1MGhzcmUvWHJIbDZzYTY2eUViNlNzUW9Z?=
 =?utf-8?B?b1ZHN2gvSzY3RkJXS09SQk9jbUphanBPVWxuYktpMlE4bTFuNmdhTUF5V3hn?=
 =?utf-8?B?TVprSERDT0N3NytGWDlxK3llRGtCNkFZRVQwUmkvTnZpMDJwK3hQcm1nbWN3?=
 =?utf-8?B?cXArWWtuNVFxU01nZ3J1WDFyQTM1OTRzWGxGTmVCbzdIeVpxYng1d1Y3TWJZ?=
 =?utf-8?B?RDN6a1NTMVNMQXZpTHdVc2lyTllNUEsrMVp2dFhQWFdweE5GL3JpZURKMkJR?=
 =?utf-8?B?bWZEM09ielR6MDVBWHM0L1V4NjlqaWE4MG1vSDlqejJmK3VQK3FhVHpzaCt2?=
 =?utf-8?B?SWs3Sit1ZGJLZGVxU1VoNy9IdVdGNndua3Bxc3JBL0xyRlRWZ0NidmhWcndu?=
 =?utf-8?B?MWsvcWQvZURVbGpCaUhGNkVFeVhVeFEzWFBJMWlaQ1NPMHd5dXJKR05jMDB1?=
 =?utf-8?B?OTA0ckp0SGhWam5aM2MxMUk4ZWFQN2tsWkNJdjc1Tjgxam5vRzR5TVBET2dJ?=
 =?utf-8?B?ZS85QmZPRGhmNTN3T3FSZzdDM0ExZGhGRE9LeXdXVmozbXV5clRxdUJnN3lj?=
 =?utf-8?B?WGZaa01UaHdmOFhMUjA2SUpZUTZXVmFRbGhkQTdveWtxWVd3emxOUVhlSElF?=
 =?utf-8?B?aFIxM1VVWTQxYmtpTWJxVFBxSS9NWkRSVzViaGh1NVhzajBmdmlDZ3JiSVd5?=
 =?utf-8?B?eVNUTEtPWnpFZzZUYWVqTFQzcU5aMUJLZjBxaStCbzFqbHBYdVUvUTBBcnF0?=
 =?utf-8?B?TFVGQWZXaTNIQjRyT1hnWHA0YnhjTUVqcjdramFlcE1Qa3NLbVM1a2JEWkRV?=
 =?utf-8?B?QjZhWCtvWnEwVTBsKzcvbVRuOTZvNktzVkxxeG54bnRqRjRhOEFNWjR3VytG?=
 =?utf-8?B?Uk5wRVF3RnFwd3I4Y2thMTFTVXNxMlZBcm81OXpCWC9tR2R4L3pnbXJ5ZFQv?=
 =?utf-8?B?WXByYlJDcVRUUFNwREpUUDJDTEFvWmpLNHhLL05DajJhY2NJZjZkdmxJTWdR?=
 =?utf-8?B?N0ZFSUFySEJJb085UzFzSG5jVFlScVl5RzdWcTFKVUJkTjdyWDZOQWNyVUFO?=
 =?utf-8?B?Q3pHdDBta1dJOFM5bkxCcGdZYm1scERzeVkrYXdKSWNFY1JOckhRNFg2Y2tz?=
 =?utf-8?B?b0VIV1QvdkdNMmNvQmQyZk5hYzAydm9oN0xxc2FtKzZ0TFhHOVc2QitXYkJv?=
 =?utf-8?B?ZzNaZS81eGp3WGxxWjNXZWMrUnBSWDZCNWdsSmYzWUhTcDVKa3lsZXBwaEo0?=
 =?utf-8?B?c0N1cS9PZElHNnpOaWZuVUpoUzNtUEdCbE8zZXVGb25qcjJyNU9Yd3R0QXll?=
 =?utf-8?B?RENWektPU09lTHNuckRlcTF0MVFqSnJxUTl6ZE8yRkl0eW5WdURqcVRrRjd1?=
 =?utf-8?B?eEFLcm9zaG9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTNHemVjU0lEV0gvTHQwOXRtVTJFRVVKNmtDVjM0ZitYemZsM3pRaVgzVEw3?=
 =?utf-8?B?TDkxeEg5ZTFINzhOR3RqZVpvN25iaERxZ2RGenplSTVaYVU5dHBRY3lkZUhv?=
 =?utf-8?B?MldFM0d5ZlYwREE4dG9uNVhOUnZZWGdLYmd0amFKbFVKYVZuNkxVTGNCOXZL?=
 =?utf-8?B?VUlFb0luN2JqdHBESXFwRTZ2cWpGQ2M1NUhQM0JvNHJ5UStJN1JhZVk2RFJJ?=
 =?utf-8?B?ejV0RnR1Rm0vblo4b3MvYzl5OTcxSU96U3czRzlzYTdnTTIya1RpN0h5Rkpi?=
 =?utf-8?B?MGJlWjFWNU5nbmtsZi9PUUZUWUpIcDI4djdkVVVkQkQ2RjBrWWFrd3dWWnJB?=
 =?utf-8?B?YU41cGZrUEJNby83VTcvZmYwY1JrYng1YmtEd0pEQTl5RTU2SHVNSTVSbmZB?=
 =?utf-8?B?NWZtWm5GNENRTXlxc0ZXUTkyRG9iSm1mcVZJOHI0ZmNuSWtyOUFtZlp4ZHBE?=
 =?utf-8?B?cTdKMFRFOWZjb1lrQVc0cEYzY3IwaklFdDZDZ01ER1BJYkp5R0pENThJSTc5?=
 =?utf-8?B?YWdMSCtnVDMwSzBJT0VtYVZQTUhuakxzOENJa2pqbGxSNXhzZTExSVUzUmdk?=
 =?utf-8?B?ckVUOU9VdWMvTEdWNld3cCtvbktjcGZ2Y2g3Y3B1Vys5UmVwUzFMdk1ISk9r?=
 =?utf-8?B?M1VNak03cklzZUxxNjRNY3VtaGZrZm9VZ2Z3eTlpZ3N3TjFyYVN1bEhoeTBw?=
 =?utf-8?B?bWtzSndsazVvUFJIUWc3L2QzTStPQnhObkVDakJ5RmNKZUYvcG13RDhNU1k3?=
 =?utf-8?B?U2drSTBreXlTTC9yb29pdDJJVnFwMHgrOTVxOFVhMklDM1RhekRCcXVDM2p1?=
 =?utf-8?B?WDIvZ3RGRWV1aTdIdEM0NmZISUQxOHNOWWRvVlJ3V3FnaUh4VEExVFNhTkxx?=
 =?utf-8?B?ZGZGUEd1aVVaQVJVWFZ1ZVBkU0trVC8yQkxqR2xSUGw0eWY2YUswdG9KNnl2?=
 =?utf-8?B?eUhEWVVJR0ttMkpVeW5aZXBJQk1rb1U4bkRKeEZpSTlNcmFxd1hZUlRGSTYz?=
 =?utf-8?B?TTA0VUVKR1gzanB4eGJiS1psa2JzanZkUEdmMWJkMm1vL0Nhb3dWU2Jyb3N3?=
 =?utf-8?B?QzM1NUtrMW1FQzhBVEIvNXU1M21LWUM0aG1tRUxhVkFjV0o3RUx3MGdwdTVm?=
 =?utf-8?B?ejFIZEx3d3BHdXJsZE1NN0RBeEptSkZvS2RQOVVjZlcxNForK3drdExTdmtQ?=
 =?utf-8?B?eFBMN0QvM25LK2VJVkwzbXdBRVpudnFYT1RiUkNZTWJjYkU2RnZyM1dXN3Fz?=
 =?utf-8?B?dlMrK3VIN3NKemIxMXpzRDc5eWpJNWNZUzFpU2I0MWtUMFNpZ3puSDRzd29m?=
 =?utf-8?B?a0oxZjdpU3l1dWFNTjUvR0hKUFVYNnBBbjJ3Z29xakptaDNWTWg0V3hhU2N4?=
 =?utf-8?B?NFJMK0JCVHZBcVJkbFB5MnRQdVFPQURNRWNONXhhUzBwa0NDVzY0cUROMUcz?=
 =?utf-8?B?VXlwVEg3L3ltMW5WTVJTRE8rYnlVY09tQjVtaDBQT2tSVDVNRTRuajdMQUNW?=
 =?utf-8?B?VU5mbWEwUUd4MkZqaENEampYWm9yQWZ6aXB3em9tc1l2ajVmbmQ3Z01uVEhG?=
 =?utf-8?B?dkFYVDhKQUY4NDhVeHBXa0ZqOTh4NG9uaWdvd0JGcE5uWjExODRRNHljUGZK?=
 =?utf-8?B?dGMwVDVXWjJ0Z0p0bW9CbHhjVnpUSUZKWGFTQk9pa3BtcW4xQUx1K1V4NEpG?=
 =?utf-8?B?THpISEVNNHJYL0pINlNZdUttcGIxMXk1d2QyeVE0dEtmVGpCbkxCdEdUQXNI?=
 =?utf-8?B?T0gwS0RqajZMUUxCV05WNlBselBoVGx0eXBVSmwyeXFXMmhkQzZzTE92U0Jk?=
 =?utf-8?B?d1l2em5LSUd4Tm9oRFBIZjZ6VzVGWUs1NDNUVGFiYStGSzJxaVdndGxVOXRL?=
 =?utf-8?B?Smh5dGpRbWIwcHArZUFzc2ZOL0hsSkpBcWtnYkRkRWdhbk4zMitrNGtDNGdN?=
 =?utf-8?B?MktXYnFCUW5tOSs0Ri9keHBZblpUbWNVdWQ4THlEazdBYndldSs3Mnhzemlt?=
 =?utf-8?B?cWFibVAyL25xbWYyWVN1djVvc21zSk9ZajRKQlF4SjNXUExKS09lYkR6RjV3?=
 =?utf-8?B?elRieUZjY3h6VDhyNWdQa1I5QmlWYVhOS2pJbXRrcGlNMWJMVDVJTUdmcWRI?=
 =?utf-8?Q?P/LjA/E0zCFmIXVqjQfvhdrsN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ab1e6c-ca1b-490f-7ca3-08ddb252f2ac
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:39:08.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fv7NX0yibxm6KcYexJb1LtI1DbuV5dxyMaJBYcYV/G2OyGjBoQR1WLqPyzapwP6hcdCA3Kv0savJXDs/rybLjA==
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
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/rockchip_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index a8ad85feb68f..87039f60281f 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1578,13 +1578,13 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 				"failed to register sensor[%d].\n", i);
 	}
 
-	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					  &rockchip_thermal_alarm_irq_thread,
-					  IRQF_ONESHOT,
-					  "rockchip_thermal", thermal);
+	error = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+						&rockchip_thermal_alarm_irq_thread,
+						IRQF_ONESHOT,
+						"rockchip_thermal", thermal, "tsadc");
+
 	if (error)
-		return dev_err_probe(&pdev->dev, error,
-				     "failed to request tsadc irq.\n");
+		return error;
 
 	thermal->chip->control(thermal->regs, true);
 
-- 
2.39.0


