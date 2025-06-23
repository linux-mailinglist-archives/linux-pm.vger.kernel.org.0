Return-Path: <linux-pm+bounces-29305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1699AE4095
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E8D188E282
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5424DCE7;
	Mon, 23 Jun 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ngTVmbSU"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DA246BAA;
	Mon, 23 Jun 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682086; cv=fail; b=B6Cm2sgtsiZ3x44zC1nAa2YF2qDn+qfem3QBBTaHd4KyMxpQAhpyTJ5z5KsnQ7uolHXJpgAfm6TrZwen3oLasbUacsYH59UCxBquzTSRSoTD4pS+KgipFeSfxcxO9HwV6Xr7n9h63mRe9ZlX5RdB19PrSJkjwPfpYZYKhgDX1aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682086; c=relaxed/simple;
	bh=10ZeyYAPSEDfMPlP6AFojrhgT4UFvJP8iY/F1+L25bA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sv5aiQwHNDVsxhgCvjgUcVXtIX/59fYhP7BB83kpyv4AoxPGGq4yQb/BVKkUUgs7Pqi/443/+1cXpB2LBfs+CKN8clikO0Kr3UGfjTZgMMpAoGDL9W7WwYefnjEIy6hq56u1pC77XCVCPEUrUQp60PHeoJRbUSiTs7yUFx0XdLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ngTVmbSU; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmIvOUiceNAgFv/1cSAnXTH8NXy3SRfNlvrPghnbl/sC07tkfwU8Cmkoqzmroo76AjwLGYT5TXqQJUA4b2HaI/zz4dhVlVLGO6RZg64TRKGO6Biq5aOJXrK7xoqecGC4LtvzWxCzv8KHWn+pSDb+lRmK2oaGnnchhLXkML8T/+ml+5Sk8AiP42iV8bO4PfMSqk3fOsgOOkFD0E6541BnS8g4BsPQIs2y88Zp2uPTHs+6qej/ZU9P7QxL5X2vnicWAGbe4EfRW7VGQhD66kW+payb1ef4PIntwgBLsEaG9VJ8atDf4H508y/N8JCSAgs3Lq+a0depUxwieUQf2uPgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+8HIINLxPHdJ00nrYFShEfcQm9a1AuSi+oYJHdnGZo=;
 b=MJFTrkhg/M0PHWMAwJMM/y9zrAXimeX2hEHMQ8f0iL8zxY51skmWdcw5+sPHCIotPakj7LbflLg6OnrK04nS+wsub3sv7pWOsbZ5vMHksCZdDrlNUWHxPHuSn/M0egS7yMHH0IO1VxUFiLBcbvZFjpyCZ9O4Zf5jvob6AYpqTrTxJyaaxJh3Bpu9OJmzirr1D2XG+0jhT6Kf75PVzuIQwbXh2rBJ9+yOz1VJkZd9ixQZsQ9DIG56/XFsw0fp6nbx1anZI1o9UNuNtJBs6Ed9l8z07+xYTTsGzho0z6LuD1akkqdhK1iHoU1s/wwj7CyIwJBFOwIp/enoV+s+vfRWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+8HIINLxPHdJ00nrYFShEfcQm9a1AuSi+oYJHdnGZo=;
 b=ngTVmbSUfj9Nwf48LFldwTi6a0yMyi/UVAPUmlridf6gio4MCTFneuWbIiSI7MjEqDTEE2AcsHetimq5+kW75G6GfPFI+vcjwXR+XLONHYnPNWkBZkTgHRzF4moT4RkB88P05q5IIJ2UFVGCXqSMr/iIiVx/Xg3Ekdx9Iu+yqPTqhNFsMNzGK0hVcnSNyXnLEjkDLVlC8TCWf4v1KtMe8GwiZEJkpxuzeOSRUEsmUEqj9S29N+1v1HnQiQV0EutHMoAQFoLSBozDj/wHby/hHftX/YwoKh/QS0CQRWGWYqw6zdbYFdr1zlh7E/WvJ/snBKTKxgUrs5EbpR02ZZ3JPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:34:39 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:34:39 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <treding@nvidia.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 05/24] thermal/drivers/tegra: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:34:17 +0800
Message-Id: <20250623123422.472872-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0186.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::30) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f5d8f1-e9eb-4de4-4662-08ddb25251ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkhRWUliR3VxeWRaVHpJdVFVdTUxZ09kUTkyaTlmY2NTaUs5bWc0cmozM1E5?=
 =?utf-8?B?NStYQ2tUMVAxUlpUb2dGY215dE9CRlRlUTBwRjZtQXRBeUJqcnNaNktqdVU2?=
 =?utf-8?B?bEpML21jUE5UQ3dpZ0R4RnVMTmdHay9lVTJmazNNNVNhK0pWejhOckU5ei9z?=
 =?utf-8?B?MHJEaWFpdHoxZXpWeE1pcVRveUtFR2VCVFdvUWxjblJkUk5uT1BKZDA4bXA0?=
 =?utf-8?B?eE42aUVJd3RLb0NVTE5aeUd1MG9tRlVvSS85MFdZNmFkdGJyNWlEekZzd0xq?=
 =?utf-8?B?RXE1cXlwR1hlYUFwS1dtNjFhK0pOUVVtajUrQnd2QlZWYnpnTmhoZ3NBVmI4?=
 =?utf-8?B?UUpHakNvWkNQMXJ4aUlEVkhyRm1lak5jRzdwWC9rb25qSWRhYUFlbDR5YmRN?=
 =?utf-8?B?OWpZYzhkNW9NblRMNzlxYlY3bXp4SEt3Qmt1cWYvQ3c1Sk1HNkFOMlVzMWJp?=
 =?utf-8?B?dVhiYVRjYmtTc1NFdTBrNXdKWCtha3dWQnFhc2toM1g3aGVmTHFrWkVpa1NC?=
 =?utf-8?B?QnZNRlZCWGVad1luUjIvZ0JpMEt6cHdiazVMYVZrNU5HNEpTbFVpRWxDSTI0?=
 =?utf-8?B?NmhzV3QrdWVOb256SkRYNkxuRk44Z2hvQi9IU1Y3TTR1aU9IRFdnMDlHeS9D?=
 =?utf-8?B?VEt5Q3BpTEJoWE82QWQ0UUJpZDVuTDJBNStQNlgrT2IxMnhTRVZ5Ujh2MlpP?=
 =?utf-8?B?N0hzOWpKL3RqR2E4TTJIYlRGeHZvbkRVb005Z1A3cll1WE1vc0dwdkFodVBr?=
 =?utf-8?B?VU4vNjE1d0JsUWVGeEFzaTJTaWtRb0J1Z3JmQ0FNNFFnZ2hGUFRxbmpJQjJv?=
 =?utf-8?B?dUx2MGF6TnROamtUcnNLTE8rY3FZbmppRys0eWdaaDU1M3NoVEgzdXMyNkRm?=
 =?utf-8?B?N0VJOTg4OFdtSjhBVUNGbXU1RWpKd0VkYmw2OFBqYmxrWU1jbmI4VmFnQWJB?=
 =?utf-8?B?S3I5d2p5aFlndi91eFZ2b204RFltWnlaWGltcmRoSWNiVW1YVUFMNlBySHBa?=
 =?utf-8?B?Vis1b3lncnpyQ3BqaENTbFJWeHdaMUhJYUFpQmR5b2xnQU1TVWdRS0QwcTJT?=
 =?utf-8?B?TVpVWERseFNTbzlKM2RNM01XQWZJcjFPM3dOZWpFQ1htNzRHbUE5MVEzVmta?=
 =?utf-8?B?WDIrMkxsbm1lMUg1U2toZTlhbzJMczZueHlDQ3htRFk3TmhycFZ4cGUxRXRT?=
 =?utf-8?B?REdXNFBXN2NVMFBSeEU5dDFkWG1IWFhLRWhudkxMbzdhWGtqNkx3OTkvQ1lX?=
 =?utf-8?B?OS8vdEtCSWdNb253Z0JhcFAyU1NxV2M1ZDc1dDQ4VTF0Q25nRmdKSFU4QlYw?=
 =?utf-8?B?emNWRWZTcHg0dEdNTWZKV3lPMitNa3FwcVZJVHJsQStXWG1vS1Erdm1DY1N4?=
 =?utf-8?B?c3NoTkx2UmR3b2VueEVOajBIc0JQMDJEOTRNY2swNlNpYU8vRVNXQ1NIT1pN?=
 =?utf-8?B?WmtFWHZQWUo2NTZQNlpkVkhIQmc0c3E2VFZ3Y3h4VWNPUXJpdTkvTDhaeElm?=
 =?utf-8?B?NFBkU1czakhsUzVOSkJmTFN1RUtIVDRVaWoyT3dhclg3WTIxaThHSDNCK2pm?=
 =?utf-8?B?N2hvb08xSkJScy9OMWdrTmliRjVaRHdrZzNLNWduQkROMHZwTDdiRU1tMVBT?=
 =?utf-8?B?T3ZsQjdBZXc5bVZEcldCRjNIaFdabWRuQ1hLcDJ6aFU3eVduSld6Qk0yQzZZ?=
 =?utf-8?B?OTdTT0c1OUx2am1LWFdudm1FMlFKWG53QkxWd3BxcDhKdnZNMGxKTEhCUlN5?=
 =?utf-8?B?V2sweFFadCs2bmN0MjBJVHB0U0gxbkRwMGc2R2UyRE5XZjM0Y0wrWmMvdUMy?=
 =?utf-8?B?YVdlbU9aN2RYb2xuY2Y0eXRLVW9DalJTU1FSa29qaEtEUWZOclpaMjcwalBp?=
 =?utf-8?B?MXRvWnJ5WFA4d2toeXNzMEpWUytuNmI5MHpHK3paMHRnWlJRaWJHRCtTNUZR?=
 =?utf-8?B?dnl5QjNMamlFbFcwV1h0U3hDM1ZudWh0aWZ1d2pmVkF2dy9rSHJZTHN6dWlW?=
 =?utf-8?Q?EX9O8Sao53J2Yqs80piHlCMiSiXaFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWcySHRQYUY0bE14Q2RISlJxTng2VEZKcnlNb25FRkJsbkJTckpHQVNKTGdE?=
 =?utf-8?B?cHZjczJrV0JQbEFFRGNvampSY0M3eC80NTlUbWRZZUF0d2NGTjZESVFOYmM2?=
 =?utf-8?B?RXJsN0dMUXhJZktJcHl5K0dGLzRyVnI2eGsvcHR4eWJJaytieFU0b2pFZUVi?=
 =?utf-8?B?RWVrQksxQUlsZXdCM3YxcUsvVi9Ca0t6VnBUSGZGNlhwK2t6YnB3V2dMbms2?=
 =?utf-8?B?Tk01bEpjMGJHd2tSMGhoenlJSWlLYWpjeVN3QWNJaGhzK3pickdJSzkwUmlO?=
 =?utf-8?B?L0lRY3N1M296S3VFUlBGWTVXMzQwZHBMb0hSVkdvTGV2aUtaWjJXYmlSY2M2?=
 =?utf-8?B?NWtXMmVFblpOS3E3Z2lmK2x5RGFvK3o1OFJ0RDN1bE4wLzJ6ckxPN0FacWhN?=
 =?utf-8?B?ZzNkdUh4ZTFlL0RndXkyc0o1ejZOSWdaRjlwaHAxckUvMVV1ZG80Qk9pb3Vz?=
 =?utf-8?B?UzliNEdXOWwrNjRxc3Zzd2J0S1E3Z2tHdFBLekVnZ1ZCWC9mR0RKcHpUbkt4?=
 =?utf-8?B?dWJqM1BZd01MTDNJVlgxeWl4R1NoV2lYMk45ZTJTMzEvZEtYWDZFaTJybjRG?=
 =?utf-8?B?cEJMTk1XN0lvQjdpWkhVQzA5K1JxSEg1eXBNcmtsM0FYSjlocmRyRTgwTVVX?=
 =?utf-8?B?Zmc1bU95a09kQWE2MkxhOFpLOHVkNXRYY0tpSGc0SjAxcHkyeU82RkExeW5U?=
 =?utf-8?B?VDhZT3IzWkFjQTIwSjRsVGdiUkxWOFhxSCt0amNabmtKN2lXTzI4R0ZCOWRn?=
 =?utf-8?B?SlhCMlBnUU90NURnMU1CQzlaK0htZzB5bk1RaWNFR1AyT25FeDA3V1lvK0xZ?=
 =?utf-8?B?Zi8xaC82aUtNSFNQTHNJUDRCK0tKcG9LaTBIYlNqd0RNYmxNelBMMFVIajJv?=
 =?utf-8?B?Zk5BbEJaaXR3VFE5NklkREJHS0FYazdFTkZQNXNaTkdQalNLRDN5NEJ0WUk1?=
 =?utf-8?B?Y0hVcHNqSEcwaHVyMGt4a082enNqTVo2RUdRTzVTSTYyWnBOY2dTcmFrUUE5?=
 =?utf-8?B?SnZQa0tjdk51aCs2NnNDY1RocXdPTkczK25jQlBTNXpvSHNFSUJ6a1pNUUxR?=
 =?utf-8?B?WFBKejcxRzV5VEpoajJ5eUltRUtVTVdMSk1HUk03bkJZQldUUnNIbXorRFAv?=
 =?utf-8?B?U2NQaFV4ajBDRGdCSTA5dFpoOE5xdmRmL3BjWGQ3c2JFZVpLTndxM2ZJcmcx?=
 =?utf-8?B?QktDMW1oQ1Q2UEhHVWV0SzJSS0FtZEszdTVjeTNSR0Zyc1RwbytiSjEvQXh5?=
 =?utf-8?B?T2xyRjA4MGI1eE1kNEZicklyVi9vdnJZNzJ5TGd5Y0dYSE1EYk5hbXNmZzRa?=
 =?utf-8?B?UG5yQUwrL3hnVnlPOXM5SWRTRGNoMzdaUUxpT2VoMWJQbEUwMlc1WEMxMVh1?=
 =?utf-8?B?bGtoa2tSQlcwN212bVB4bTVKQmF2ekR3dHJsVkw3aEhlUGp6QlJ3YWZsdEla?=
 =?utf-8?B?OXFqODZyTTJRM0dVcThZTVNaSlhlMUswNVdUeFhDbjVjNC8yb0pKWXErR09C?=
 =?utf-8?B?SlFYVWp1Ui9XN1lZcDd1UGdjeFlRU2NDdW9GV3hHZEpGQ2dyanpSOUlvRHdY?=
 =?utf-8?B?bkEzOWI1ZWI3bWZIN0s4bDBQUk80N01XU1lQaU56UlZOSmg0aWpaRWg1c3No?=
 =?utf-8?B?MGtuTTBhYkVlQ0xIbzI4OXJnQWNBanJSTko1SWdMTEk0TnNsSys3NGJKbmFJ?=
 =?utf-8?B?L2oxTC9laUhKdW9yVVl2aVdJWDAxN0tuOU0yUkkyYkU1U3U4TEVhTzRmNnpC?=
 =?utf-8?B?eklXS2RiajF0Qm9YbE5jKzVHTXJYbzZFVXpGWXl6My9MdUlPZnZmOVBoc0hI?=
 =?utf-8?B?WjZObFlhK2g2ejVxRUtLU04xSXB1Q1F0YVpWamJkb2NHOE5yNllHSUpnTlJt?=
 =?utf-8?B?K09pdmZad1FhNXhndzlQQ0lrMVlINTMyU3FWOERFK0tsVUxtWExmcVV4Rktu?=
 =?utf-8?B?WmlyN0Z4Y0h3QWZEYWpXY01xaFJncUd1NnkyaVdMK2VTVXJJeUdSRXFtMGJX?=
 =?utf-8?B?QnRld2pJVEgxRWtXUCtvS1JFemxtWGdmM1JFVVJzQXZhdkVoQzBjc05lS2Vu?=
 =?utf-8?B?dStvN0RLei80WDc3dWlTbXdNUkU5QUlSQ1k2U0NsNTZHWXVFcm84T1kxclFp?=
 =?utf-8?Q?duvF1j1huqfEQ7CepygwoWnXv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f5d8f1-e9eb-4de4-4662-08ddb25251ef
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:34:39.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEg6cRJZxMw/4R5noHqM9L7yoPnW6WHsj76H+DHx3oTU+l5Tr/kZnHCbG0zicq/dJbpCSJuaLZKeqw0EGWUN0g==
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
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/tegra/soctherm.c        | 38 ++++++++++++-------------
 drivers/thermal/tegra/tegra30-tsensor.c |  9 +++---
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 926f1052e6de..aea9931175e8 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1989,29 +1989,27 @@ static int soctherm_interrupts_init(struct platform_device *pdev,
 		return 0;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev,
-					tegra->thermal_irq,
-					soctherm_thermal_isr,
-					soctherm_thermal_isr_thread,
-					IRQF_ONESHOT,
-					dev_name(&pdev->dev),
-					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'thermal_irq' failed.\n");
+	ret = devm_request_threaded_irq_probe(&pdev->dev,
+					      tegra->thermal_irq,
+					      soctherm_thermal_isr,
+					      soctherm_thermal_isr_thread,
+					      IRQF_ONESHOT,
+					      dev_name(&pdev->dev),
+					      tegra,
+					      "thermal_irq");
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = devm_request_threaded_irq(&pdev->dev,
-					tegra->edp_irq,
-					soctherm_edp_isr,
-					soctherm_edp_isr_thread,
-					IRQF_ONESHOT,
-					"soctherm_edp",
-					tegra);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "request_irq 'edp_irq' failed.\n");
+	ret = devm_request_threaded_irq_probe(&pdev->dev,
+					      tegra->edp_irq,
+					      soctherm_edp_isr,
+					      soctherm_edp_isr_thread,
+					      IRQF_ONESHOT,
+					      "soctherm_edp",
+					      tegra,
+					      "edp_irq");
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 6245f6b97f43..807e568e5b25 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -598,12 +598,11 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					tegra_tsensor_isr, IRQF_ONESHOT,
-					"tegra_tsensor", ts);
+	err = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+					      tegra_tsensor_isr, IRQF_ONESHOT,
+					      "tegra_tsensor", ts, NULL);
 	if (err)
-		return dev_err_probe(&pdev->dev, err,
-				     "failed to request interrupt\n");
+		return err;
 
 	return 0;
 }
-- 
2.39.0


