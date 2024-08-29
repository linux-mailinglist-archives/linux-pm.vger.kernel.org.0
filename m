Return-Path: <linux-pm+bounces-13098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4496389F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E48028432F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD0ADDA6;
	Thu, 29 Aug 2024 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="m6cJmhjE"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071.outbound.protection.outlook.com [40.107.215.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7F61FDF;
	Thu, 29 Aug 2024 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900806; cv=fail; b=PWjCjq/K21mYw7ti2ePijrmuYOrrnh4/6KABqZCWBiSvQVejttciqVD/jjAMh8qCytGcq23ARckEfQuhadgPkAAp6qHG3BvzgzFOAL/kXoWMn2XuGCi7X1TODPbVGpEkSeyc4lM96NakcKkRsmbFN5QXR1Ym21k91C7aeYIhwP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900806; c=relaxed/simple;
	bh=Nxla8FRQcyZGgLQwp6pYp6xntN52dkKBscMIhA4LIHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XtKJ6jSOuGyfFOGKi9t9B2n2uE8FXnOP4z9HhS5ImRhezF2r5I/Cy4LGti/+N4q8VInarb+Y5CcATmMOkvggYFOjNqy9NnKfoYr5w8qgHseDrs+ycpAZTtI3A4kS44yS6x+NPgcbwBL9uaBgvDgasmsTcQUza7zWeAWxDkgQ4/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=m6cJmhjE; arc=fail smtp.client-ip=40.107.215.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8hgkRDATtliZgOs/K8zPdWu5yScVZELk2Eow1TFIFNXMcfGwKeuohApKCKv3MHv6nw0q+D3WyoOSwPqQVqjOs4I/OOXaEjXjdwL25rsezQKVDf6qlYr2yf9zbXqIgVXz/ryIVr6RA4GUCfLAb0Si1JzkOzMopkxJRpCxXSMSD8MbhSn2gAVS2eHyfg/US608zEi/DJ6uo8cpqYhHB1rvs/u8FJdAD9rkWnG6YeuFi50H2mGJcsQbOYHUpop6BCfJ/oGVIdqnPVT3M2G9JcsyAQtARN6jwMCS1e6wwn5LnLZxE4lFC46A8vE03sxH23fMYujbnpFuiTNKXlwmPLUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTAV9+D0TTikaAb6+bQMNJ/YTDeL+lsL8bRqP8usnqA=;
 b=MqSG0i3i7yCEANDRbl8RqdBVjHZpL/Sv97qxC0xlS10+DsHrIPDWF21LSsuR6KdH9u6Ty2FT6tYMK9O4VRLQVbVd/JD4OF6hrrihkv60eApffvdyu0i/fcG9JxdlEHbOXwTE3wPiWshdhyv/sOu2AWEU9p5CDY8Gkab5uiiZxi50m5+zdp/3H21yGKAe3VevVwXX6nYB51jYyvPZlkMvrSIi83/q0xNfi866LIKP+jprBz6Gk2ScxbaYn40xfI6FpsKJALKdCK/xSCV3MJafkFk6tcd2pFscOUYtW66N90G1UrciMLnUeA/HFo2ySXCQRck/t5PGythNH7i7qN80vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTAV9+D0TTikaAb6+bQMNJ/YTDeL+lsL8bRqP8usnqA=;
 b=m6cJmhjEeeOfTcCG0TfpwE0C9uLc6mfRvMUlDFLBnhTsnF2VTQ9p8WSSmHrCKje/YA13jmh2iPNppASyQMEtJV7mha885ey9YrB2EFD0hPy9Kc9cBdYBAB7cxaibATuQVkxx5NzF8eNnMy7fCyxFK5g4COuIFsrKFAy2MoxQX6p3LgmQjRcIIRZOjfP7iDeHHSLclmdSNweeFCXpOEAJJ/O9tIj0Avyo4CpE5XgNTWkKbMiAIjeNMIgdZHvERMlH1RGxltElD1WWFaB/hWs9w9lUm68jEmEd0M33t7Z+05/jqzR1Osq//61SnwFq3FP3KY8I36nv/5Q16BExceh/Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB6066.apcprd06.prod.outlook.com (2603:1096:301:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 29 Aug
 2024 03:06:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 03:06:38 +0000
From: Yangtao Li <frank.li@vivo.com>
To: rafael@kernel.org
Cc: Jonathan.Cameron@huawei.com,
	amitk@kernel.org,
	anarsoul@gmail.com,
	angelogioacchino.delregno@collabora.com,
	daniel.lezcano@linaro.org,
	frank.li@vivo.com,
	jernej.skrabec@gmail.com,
	krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	rui.zhang@intel.com,
	samuel@sholland.org,
	tglx@linutronix.de,
	tiny.windzz@gmail.com,
	u.kleine-koenig@pengutronix.de,
	wens@csie.org
Subject: Re: [PATCH v5 02/22] thermal/drivers/sun8i: convert to use devm_request*_irq_probe()
Date: Wed, 28 Aug 2024 21:21:45 -0600
Message-Id: <20240829032145.2851567-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0iB5arngPxxduafyZ+hbxqTRLXm_5iwNoEcQcqVyCdCYw@mail.gmail.com>
References: <CAJZ5v0iB5arngPxxduafyZ+hbxqTRLXm_5iwNoEcQcqVyCdCYw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: b8671ab5-b27c-4ce0-ba80-08dcc7d79925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q5isNf6vMspGe9z7sIRv2Fv9ujDSfWGwfuwa1A/IuGiS3LhHO+r/P+eSrgt1?=
 =?us-ascii?Q?xu2OXi6/zxA/73lo9z7Z0Fn9hQydXlzSlkxrD2IeRGtJ9TRmJFrHx680FbbV?=
 =?us-ascii?Q?ofq36Tx6E7Q9eTd9UPsLPpnPsG85MD2o3cBXKsR9TPN0FD9W6q+TQQvyWrfn?=
 =?us-ascii?Q?p4c+K9lifYkQda3xu97bBZFG6nqNtarS/gnEZ7gntnggqNVZtiDaNz0+XSmU?=
 =?us-ascii?Q?3Su2QdKayGUnTtusPvxNwtlZVychb24ndAP7cgsgo1mtWZPQ+7cYxTEo6Kum?=
 =?us-ascii?Q?ToUxMYpDXtLR+QjPHeSP/aIjRZQ5w1yoCdALatQ1h9eiiXLIFKc6LugIwyFJ?=
 =?us-ascii?Q?unszp2ziUfh0387+82/YBEFeFoT7nM4Lx3LJe+4yVr9EqxM8576JbVDiqlRk?=
 =?us-ascii?Q?WVAmd4/uPOf0gdYeXhJqlaeTjlCQcbm36iEgxEUlkSpGsGLvHYQNna/L8yMk?=
 =?us-ascii?Q?Tu0XynG4j60hMhu01MaBg6+1wLRC25XJ5g20ygFnKPY1s42AE+oPdeM9w6Uo?=
 =?us-ascii?Q?kljNUNZ5Z9XZQT1WGOES5UVm/oG25ODSXnYA0M1X7/KqD5NKGFHD0GWAs3L4?=
 =?us-ascii?Q?g5arNyCRYv03Ffpw3HXHPAtOXLIGQkmO1fZ5xToKyReXcUPrv3QdRAUYPQ0U?=
 =?us-ascii?Q?OCk7aXAg63zvBrv63lwiY8e8EN63rFbv/2VLGZrf6I1cAJaGLfab0aST2Dqv?=
 =?us-ascii?Q?UcR3tAKZFY1oqC2UJhdvK3unTrLz2FJe4ZOM49OLeNzXxioSx+ZEi8OyH0GT?=
 =?us-ascii?Q?71S6DQTIo8Di8fhdYFlTMTfdu7KQAWxUf2aV1PuHXTqLx5P6HkMLexR3dKsG?=
 =?us-ascii?Q?x7Hsg6NxOC0aX9Wufau8vwz6vPpLl6OmxDly6ZimnXbojxK8/A1KpmVwi+Dd?=
 =?us-ascii?Q?SVAylu1Ityeb/68SJycqxXE5yC2SwXipXE3S2aNjbH6hI1OOFuDZO2ZtZ9mr?=
 =?us-ascii?Q?UHnwErngffkPTwbv00ChOZl21BxBxCbXFvJBoFb/Kt3dbg/4uz+xtL9GS3LU?=
 =?us-ascii?Q?tpxBRLno/ZD+l0Hcdi3MPFSFQp0XY9wfuwfwJl/VlGAGXlxEH+87yMYkDoBV?=
 =?us-ascii?Q?VaZMRVsoOe73rJCJyX2koG3iZ+auI0b7vXUg/ryhR+/4mkInzn9kquEXipO6?=
 =?us-ascii?Q?IlRsMhXYOZtuNajW7OcD0d18rXXGQyNBfo+MAoMnX2ST+HMrTTcC3txqVFXq?=
 =?us-ascii?Q?nDSgfuyA9aIpVyCtK23C+6hwY8JGzNZdoek/s5+GvXKNgfFE8YkvEYhwkdbm?=
 =?us-ascii?Q?hjUx8q42UQZJUnbSaCtV9MsmTED35dGakAHZ4yUiG6BgBxnxh0kQoKjDma6U?=
 =?us-ascii?Q?793yiOKVuHiK6EUhYMw+YfQhnE0Ae1xVquPQtZJZ79pVwr1vN0pmdSBnKVVh?=
 =?us-ascii?Q?LHyCFGWerrcJRED2anxM8X0SS60AKCTgnyZxjIqeSjt5Kg9h/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BB5adySu+fUrVf/Tkpd7mBaKEldwQl7IlirUEyCctwK3+N7JbLM7qFeb8cv4?=
 =?us-ascii?Q?oikcVvime7gr18/WaF2dAYqjj5I0K9LYS8+QNU0C6MB5sZ7YXv9degPgw2im?=
 =?us-ascii?Q?oI7RqGwljChnMvWUgmxxTCccx+xtLEriA0m7rQTwrOMtVJA+Bv9f5smbC/Oe?=
 =?us-ascii?Q?roJCvF0WgPJwuaq7kkDwjJpZm2OmQU0IjHLUFGry4d4zD17aiDzh46u5kNaR?=
 =?us-ascii?Q?Bnvo0JswdJpqbCgBrKADWYyM38+I24+fVk13YvzCZ00immK/wULMAyZwumkF?=
 =?us-ascii?Q?pb6XThw5mNPuPfFRI/Wp30rPpm1MRoP9BL+K3MWYfAk3pnCqFbfaEKehmlO/?=
 =?us-ascii?Q?sU8kL8T7QyB4eMGOgvCFq1YgUYdndRGPrnCQ+J1rZguBXDoS2W5HNZWhfHh3?=
 =?us-ascii?Q?dlPHl9CDEocBXVYpB5ejQSYcr2V944NbeBOoSA2sjJG2nbAJsevZYBAlsaZf?=
 =?us-ascii?Q?bzd9ZecvaefXyW/tPuQe2Ryl8SBwc+0cODso9e9nVamKwQj+XOVHGtGpWubk?=
 =?us-ascii?Q?tfJ7GipeDQ6zzbGkJScuBnjHaIiMAm4wlDDciuNuWW0j9VOBKEh31AQrNMRX?=
 =?us-ascii?Q?mFNMW9j1rXM3pbLbIgZfdqnrfoGSF5uPxf23DOf4O0YZR5fRcoNszTSI9LnA?=
 =?us-ascii?Q?1AS/Q52UJzS9hUUXIpQZS22fp7vCzV4/TWlBWroaU9Xmjs5LAYJGKMdVgBM3?=
 =?us-ascii?Q?MHiEAaoqAptxL6TCN6Z7WQC8CZl3+dk/U3yAzGSJPlbRJTygW0gmdWUvX+vt?=
 =?us-ascii?Q?Qkc0PRia2C1wTY1NqUWWm8RhP3JS3jrYtgYPvjmASL16LbxbXqgeQO1TJyMJ?=
 =?us-ascii?Q?5/iruodV3dLO0deh58G7xQGtNL5DbaWTaB3exxIjhJCukdpc1PrvOPy5ylnY?=
 =?us-ascii?Q?OVcGY86D4s+IhqSMdQGtUQ0UAtXpK5bRGZQCSF8KhgroKR0m+ms1CCesf8t4?=
 =?us-ascii?Q?0f0Me6UkL7YfPoWaHtyhsYftd1D4mYnOW3Q12+TCXBsClsR7ZQkdU27ks1uJ?=
 =?us-ascii?Q?qt0T1sYPbDwzsbACCwiezloViKlNO00SCRNBLNpRs1yYNKKmwCJ4aZ0B9aTM?=
 =?us-ascii?Q?HGqUI4LiKN1MS07svFv0HHc4XhkNwzGnfvKTJea3OzzM2q0OlgjufcR09F5g?=
 =?us-ascii?Q?rKoaWB6ZNBrPdKjacTZ1tICCqjyE9EQMfg3Mi2nCs5h3u6QhN9OSKFdxzQ/5?=
 =?us-ascii?Q?9vO9LzW9bku7AmN8jrOvEI+9d7RFFon2Zvwp/qP+Kb5Gm6eO5vM6ohpQYrFl?=
 =?us-ascii?Q?/iWBhOLvaJSRy8yia3OD0FCX/k1QzWSR/L8aO1kpzYtf92Hv06SdddpFrr4Q?=
 =?us-ascii?Q?WH2Pxl0CddxCB+Im7Axmv+qRaezfwV5XaIEynAJM+iT8MepNtUVNKpwMBfly?=
 =?us-ascii?Q?tMqDP7yhe79Oi0I7nrE4w/GDxePA3wAOImyrk8q7UTZKEKD3nl8KXdZ/FlzC?=
 =?us-ascii?Q?7hjOMfAOgoJrvCoHuBbzqamCiXU80J8fnvXmPT8SBOSSfhS1yoN5usRV9UXM?=
 =?us-ascii?Q?FlSHZkR92nI99b/xgLELb28PX2c7P2fgHQWCvS3QDujSnSi6cVluyiOAhbUv?=
 =?us-ascii?Q?vRnQrW7HePPfk5LBYtd5XudlCFYQvo53rogh3jGE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8671ab5-b27c-4ce0-ba80-08dcc7d79925
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 03:06:38.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIwtsof+B6/T63JOQD64WnmaXC5MHnVQ8+P7tyAoFASEycvUglBfYmSF0I30lZvo041Vboxsuv0H53VqUdRlfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6066

Hi Rafael,

> It is not clear to me what the purpose of sending these patches is.
> 
> Because the devm_request_threaded_irq_probe() definition is not there 
> in the current -rc kernels AFAICS, it looks like they are sent in 
> order to collect tags from people.  If so, there should be a cover 
> letter making that clear.
> 
> As it stands, it is also unclear how you want them to be merged.
> 
> Moreover, sending the series without patch [01/22] to linux-pm has not 
> been helpful.

Could you please merge the entire series into the pm branch? 
Also, do I need to send a new version?

MBR,
Yangtao

