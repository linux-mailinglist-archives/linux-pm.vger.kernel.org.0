Return-Path: <linux-pm+bounces-35141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A9B8EC6F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181CA189B3D7
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3352F39A7;
	Mon, 22 Sep 2025 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAGtCel0"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797E2F3602;
	Mon, 22 Sep 2025 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507709; cv=fail; b=HqmlaaxwAqhO708Efoj7CEdkudwosNRE3g5hcQq6r/JZcZM86/JzjdPP/JnyS8/exv6JLIBh2wJkF/rqau5LHkByglQs/mVlqeWxn4KJp8niNc2xt4W4cRu6fvgBloF1JAOQL7vKCnVuVvvMZ7/f3G69b4lpkootMutX78uBhyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507709; c=relaxed/simple;
	bh=tFenkh2DWRPRFh+U8llYlxsWJbKVaGoikrze3QAq7uI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=POven166IpIQnXwHQYnZBhvP/amGBeciSye1BLmuRCuRL7yItFeQoFyWcQF/KZliBVE9o943AicuuD8E5Uty2Uo4B0iESjS30tqMvnbVAjI2abV+L5kMVknFaB1+P8EpG3yIpkQ3Js0LBvTBuwbywZCgvXWqUJo7bdpsFNgjPd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CAGtCel0; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0O0abcSV+dnfg+4KhIUTqHv+oPhkYWEMSFwAGx9R9NmecNz9VGd/zpkEeeGDnutAtIf2BBSydCuo+eEhW+0Ab6U4k6lvL0epouxCX8j9jhevEtA13U/vnk2AXafwNkmyWljD/z9K9rKeLkpx0DwmYPKX3nLDbTjAaQ8y5W8mCQ1sF7ta0czsuZkIwqQZSIj3V8RvAUE8iD2xWRWOWgnjoPRSwdd4/+MSGxEi53xFpUMctolYE+rSmCI9fR5r8/vOw8rNyUppFC731hbwpiQPHXuzcHAc+xkG/cD+qUkqwqo2tb+8NdlLeDE1dbCk5uE3hbtxUx1y8dXW2BZASbnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=budbbIk+wOY4LKgHwBzvWz/sXgCDytqnME2SSU/foFM=;
 b=BCGvwXiC4m7yRmDzQ/Dwkfpw8QFqScv1e5EMxwmRQX1fjayCFYre9Cntwo9JfRFi1SYUzd7ZhhJD3rWDRxqUh9ERtSXk++c17Blke5Wrw0EppSNli4dNwHhwqLsTDLdeInINjD12e236fifoNWv4FL/Ie5UmoCxmra9pMKCD4L35xRMOi8NjrY2P6iPUyR7Ub0MorN8xerFMRiSSuSJtyI59WOGbxU3OVxCSA9Lkhc9AuSaJ62hqM2Kutk2gj1tc10ShF0q47kNUzdVvVI0QhuZvsUVVId+b2EOkOviUU0t7Ye/4sM7PN1qhdCi3ankOLJ1YpMIasnQZRxu7hpyRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=budbbIk+wOY4LKgHwBzvWz/sXgCDytqnME2SSU/foFM=;
 b=CAGtCel0bvESYIYAKJQfNu6ggrm8R6I23/49p7DRdmsTpH54DXHENoWTWRyBI88YNWcFnZt1ZJ9VnvzNwr0EsYkd/EYq03StZEuEtt0I13x5GHAa4n+FIFU1EkEzjBvRvAzSjgl+nQYuyhhh/KTKTkGv2T1/YV0iCHMGXA7McR77zyNZgDnCmj4L4SaH++4vleKAJIchqKv+MVeDSEAkQdq9Y7XozW6VsHfXrH7dBDCKHAB2nmyxPWpD0cwMsSl9kPqKLyjsHIDRQjHdinPzBTZ62zcRP0Tm24V5y4tVIhLFxXICUl49a+f2/zvTQyXa936YXvwYP+xqn+cRW8juHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:21:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:21:44 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:21:09 +0800
Subject: [PATCH v4 4/5] usb: chipidea: ci_hdrc_imx: Set out of band wakeup
 for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v4-4-ef48428e8fe0@nxp.com>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
In-Reply-To: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507676; l=2706;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tFenkh2DWRPRFh+U8llYlxsWJbKVaGoikrze3QAq7uI=;
 b=IihsemZH+NlO9SOD4V4E6oA6HqTaHLbj67JDRf3CYwMdCuXIKJMmPZxxYSP/Ji6GVZZ/RCkJt
 eDtZissPwBtBqxNnqbz1KzZdbKuQVfBW1mkLg7lFR+g5QVfqTtqEN5U
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 3216a522-6bde-4ba9-ca8e-08ddf97ec61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGZKTHMyMGpqQ3J2RFA4UWowS1U0cEJGREcyYWJ3ZkppeHFGT2RWYUtpeTdV?=
 =?utf-8?B?bkx1N0V6cThJUWIzV2pTanFGak04cnMza2p4Z3Rna091cU5WRzRIWHU5WStN?=
 =?utf-8?B?b3NYSWFINVBPVmdNa3YxUjdyQkVQcWRpcEU1RjdjMy9QSHByNWI1UlNKQVNG?=
 =?utf-8?B?YkZuMkk3czJNN2g4NjR2NG5EYkxvYmVibk4vMExzNjF6UjlrUTZYZTNrUEI4?=
 =?utf-8?B?VlJkYlZwWXE3SVBxVDBPbm9xZ0xBak1NWE80a3gzWUFuWjNiNWY0MnIrT2oz?=
 =?utf-8?B?WHo3eGhJN2xjTFE0SW5NVHg2b2RuQlVOcjhHWXlPaGFBWHh2S21SVHpjOTIr?=
 =?utf-8?B?bm1lYW5PTFNLRW9TbThHcHFhTTArbG9XUWpiMENBMERROCtNZzBsSll3MnY5?=
 =?utf-8?B?ekZMZmc0RHZQa2kvSmh2RUtIS1NxclRSbDlZUnVMclM4T2VYWG5kSjVsSDl5?=
 =?utf-8?B?UzhCUmROc2d2YlR6VEFrSG5RMEdhcjh5clNqOWxITHlac2F3cWNZUm5aS3JX?=
 =?utf-8?B?UTE5UVphUG5FTVVwOFJLa2NUK3BTRkRxVUk1RG00cWNkOW5sVVpzWG5ETTZL?=
 =?utf-8?B?N3J4cXF1QWtta2N1M1BISFM4U3JuazV5dEwrc0paalRIUkx0Q1Q3T3NmbEFy?=
 =?utf-8?B?alhXdC9wWHppMms5RzgzK3lYZXdEbkh6eDVSN1dSL2wrWTE5bjgxWlBsVWhr?=
 =?utf-8?B?WEQ5WnRCb042NGFsSDhIaVcycFExdzV5OVZ0amRlN3dIRkdQTlFRVUdxZFla?=
 =?utf-8?B?VW5wbWx0QitrYjRtVHdJZFdvQ3NFWGVoRmFMNnNjM082NzJya1ZIZnQ4c2JW?=
 =?utf-8?B?VE5FR3FRdDRUdXZjVVZoZklCUWxTV0lzRWFUVHE2UC9LRjI3WFRkelNDL0hs?=
 =?utf-8?B?TE8zQ3ZlVEZkdXRkL2xkZzlDR3F6Y0hXWCttaVdwbE1MRkYrb3cvb1BQempz?=
 =?utf-8?B?d2lRWk43T1o2akVYL3ZvYXpub3JNQ3ZWd1pTaDBtVFhvK0VRcFhJc0hXdUlj?=
 =?utf-8?B?ZHVUQkk5ZnhGVjNUVUgyOWZubm1nZTdaNzZ1V2Fpa3gzc2ZWMVlqUHdoTlRH?=
 =?utf-8?B?ZWVDcEZMSVp5SWl6QW5ONTU4NldnQTFSZ0V5cEpoVFh5d1hKMnFIT0o3d0Zw?=
 =?utf-8?B?SHQvdlJqejJmR252VVhwbGkzbnJ4ZTFreTVoQ0FscWtpUzBDakg2SG5LdEQ3?=
 =?utf-8?B?NVJZNWx2OGRURmJXT24yM2JVUTJZTXp4UWgyV2hzUmcySmhhcDNEdG90L0VP?=
 =?utf-8?B?OGZ3UWlUaDQ5L09vTEVWMldkOHNmdzVWaFczOGZGa1M3T0tURW9EbUFaaHNh?=
 =?utf-8?B?KzlvdEp5OTJtMGRHcmQ4b1ZUdGVZZ3VhRDdScXUvdFdUdVROb2FkK3R2UHVS?=
 =?utf-8?B?dHFneXpWazBqTkEvQnJtSXJna0IxK1FGRjhxcGcwMFJ2bElZUmh1QXJBdGlO?=
 =?utf-8?B?Vkl0WExGYkxPcUVHdXFvajh3NXkyb2h4ZWpJZmRPWTZQeHFqakdjMVNyUS9x?=
 =?utf-8?B?ODdkZTl3a2x4OEdPcGRSYUcrMXZrOFUwUEVhTmE0WEUzSUdISEsyMTdsWnVt?=
 =?utf-8?B?VFVYaXhHUCtwWjlUK2JMVHRlQ1lhb056QXhMUGttNlByVWVUYVJhMTJyeGtV?=
 =?utf-8?B?WUxpQmZJbTdLU3NKaHM2TFZRSlFOV3BaSml1M1JaRFNWUHBmcVNjdXVGbkgx?=
 =?utf-8?B?NVM5S3c4dElETTJxQWlhSmh3NTRXblJDMXNYOHdYY3JyRE8xN3EyM0hSdTl4?=
 =?utf-8?B?dGgrNVhEVHRmS1diRERTVmpoMmwxa1BnQXI5RHFlMEhKaDF6Qng3NWgzWWMy?=
 =?utf-8?B?S2ErQ2JXQTFUNUVQZStuV2l0RXdoQ0lFdHRQdnZwaEE3S2pUYlplcE80MWZY?=
 =?utf-8?B?eUV5YU9ibmFKUzlPanA2MmJxaHF2WmQ0TTQ0ZkNpd2VvUEM5Zks1cFBpcDBo?=
 =?utf-8?B?cFRZMEJNSEIrUGF4SGhySTJmemVQNDg1c0kwOVNtczNGVHFjbWZQbFRZTDNB?=
 =?utf-8?Q?ctgMs2GHIuNkqOPRMAS+IuWWtxCRPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnpSK3pkdkR0eEVhU1hQSVdjMTdicDR6YmNrNmh4WUVnbjFkcDRWWUVMMzN1?=
 =?utf-8?B?RlZHcnQ2Z1VPREJ0MjRPUkFLcVpMR3FoZWJFZUhYKzNVbXJyeDh4ZkxsMUY0?=
 =?utf-8?B?ZWdldDY1MmhuZURRdkMrcFJCeDRFMkEvNVpHN0MrYmN1MEJMcmFQRm1PZmN4?=
 =?utf-8?B?MzFJZDAzYWNjK3BqU2ZBV3I2V0VGd0pKNVljL3NrK1JxNzd3cnVGNmRBUU41?=
 =?utf-8?B?cGJFZ092SzhEd1YybkRaWlByWlFDUCtrT2ZlR1AvbDZyc25Ra3RSc0J6Smkv?=
 =?utf-8?B?ekpFeTNiaGMyR3Y3cGRvOUNFazBtdWViWlFrb0Z1Y0FqZkNOSEVKNVdVbzlx?=
 =?utf-8?B?ZHg5WWw0bHBvVG5mVkVUeFIvdVZCNllwSXhIekxTZHVtQndvNzYvU3A3QlBX?=
 =?utf-8?B?TWtzTWdTK2lTTVNaL3BzcmFoOE8rUFJ3MWZjRDc4bUphSU1STGxteGtraXhm?=
 =?utf-8?B?QTVLNm5aQm5OSHd1dUJDV2o4VU5qanowOVBtLzhxaHJzbmNYVnluQWcvaWg5?=
 =?utf-8?B?L2dsZ2J2eWFuS1h0Q2dJZGlzaEtxa2pjYXgyM2I1ajgrNTY5Z0V6NmR1cFZZ?=
 =?utf-8?B?LzB2YUhzVDRET1NXZlo0VjhTTVF6SWUyQnlLNlBORG0xM01QTXRKOHJDcmlS?=
 =?utf-8?B?VjI0cXh5MjFhYkRVSkovNmViazM3S3lBazByMjVpTUxNRmZyK1VYSHlEL2ZZ?=
 =?utf-8?B?TnlIYjg3YTFFUUxaSnJpSG1lZ0Z5b3VxQmExelJ3TUhSRzlxOTFqaW1xWUVL?=
 =?utf-8?B?U0kyZFJ0T3lwbXVxQ244ZEV5SllTZEUzbVRXeW4yQVFzWE9RVUFoWG1ja1FH?=
 =?utf-8?B?eThPdlBSUkZ1WkJzY1pVRlkxeGJPQjhDeVRFUlB3TlY5eFgyTEJKMVRwZUtQ?=
 =?utf-8?B?U2pFWVpsaEI0SFozeWJpUUhiK0hmM2JIREpqL0tpanAyTThGMnZiVldSWTdw?=
 =?utf-8?B?eG1EdGxkWm1HVHhzOWdQeGZVTDNrWVR0VXY5NVYwVHhvRU10WE5ldzZ6VlFN?=
 =?utf-8?B?VGRrL0MxVVdDblVJbWxCQ2RpYTJWSWdEVTNyS2ZZWGFDL1BZVC81b3c1VGZJ?=
 =?utf-8?B?WUxpQ0F5ZWdDNTFjZVpPY3NuMDlXS2x5eVl5Mko4VXFpQU44WVpRaUd5Y0R3?=
 =?utf-8?B?OVd4SmtYVE41b3ZxOHBwbkc5ZjNXQzNlMkZSb0QwVkNMc2tKNC9xeFBVYkVI?=
 =?utf-8?B?YU5BT1Y0TGNySUlDeWozMkR0YTArS1VXM1k1eWV2N29zSTNaYVo4a3YyTEJ5?=
 =?utf-8?B?Z21BOGgzRGg5eWhjTVYwWDR2dHFYNk5jOFRNQTR2eDQyZGppbzdBRlBvYXNG?=
 =?utf-8?B?SVVHclV1R0JXSG1sWkViUmhya1VhbmtDOHJBcjZnQVQrOWd6c2oybFJkMFdL?=
 =?utf-8?B?QmFsR3FSVWcxZmZFTUdqV1UzSEYzOUNzYUZuaEMvR0ljSVpmNnFUMDhOTm40?=
 =?utf-8?B?ZmZrUHN4anJQUjVoQ0xzaTdtcXVlc3NEb2lhSXB5MFdnRU9YMEtPdmtzSTMv?=
 =?utf-8?B?YVJlYnBmdkZXdlNLdS9mQjd5c2E1VE5qZzdOazVxUEJKUHBXWWc4RzlaMm5X?=
 =?utf-8?B?Z3dlSFFibk54SUpXYVlvNGxQSXg3ZnZyOWZvSXB5dkVnaUlnL2NReUhOZ3g4?=
 =?utf-8?B?ZzlqT1ViVFhrVXJLcVdqaUNGSkdncUd5aTdYU2Q5QVMrTGRrTElKVVNMN2JH?=
 =?utf-8?B?RUFNY2pjc1J2T1VTQ2NHU0NDaTR4NnJWQzFTd09rL25IZXp0V1kybE1qOW9v?=
 =?utf-8?B?c1JsMHBlODg2cCtUSldFYWFZeCt2QmNiZ2lZaHBKeitFejBvSUVWeS9WUVJE?=
 =?utf-8?B?WG93ZW1sZ0pmTTcxRHlaRlEzdm1rbEppbkZVYk91ckpBZE5jUmZnbmF5dHg3?=
 =?utf-8?B?YTB6YVNvYmhEeU85cXJkUUJ3aCt2NU4wZjI5NFQyNE8zL1J0M2tSMUx1UE5X?=
 =?utf-8?B?anlqVzlpZUd5Y3ZHVkl6NmhhVm9qV3F5aEEySHllTVlVS1pnUHV5V29QU2FW?=
 =?utf-8?B?SllNamQwUENSRzQrVXZ3aVFBSlJGRk95azR3cG13Lzc2SmtkN2VDVmlsaUtw?=
 =?utf-8?B?MWNCMkVsbE1BOXN6OGRFa0J5c3k3R3N5YnJuZ1FCMS82ZDRzbVJsYStHTHBH?=
 =?utf-8?Q?eOPG0jZUctXiVHQ1U/m37vcYx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3216a522-6bde-4ba9-ca8e-08ddf97ec61c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:21:44.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN2WP5x40QvlEarZFHIJY2fvTx/7Oqyh77pIbd3sdw2KVFo96E7By0Ag57LRX0fVaar+vb+9VjA2uV9t+//a8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053

i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
power domain(Digital logic) is off. There is still always on logic
have the wakeup capability which is out band wakeup capbility.

So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
wakeup system even if HSIOMIX power domain is in off state.

Tested-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 11 ++++++++++-
 include/linux/usb/chipidea.h       |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index d7c2a1a3c2715967203b98c819fa864e06a00a32..d4ee9e16332fe8b506711e4739c9008f73a377bf 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
 		CI_HDRC_HAS_PORTSC_PEC_MISSED,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
+};
+
 static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
 	.flags = CI_HDRC_DISABLE_HOST_STREAMING,
 };
@@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
 	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
 	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
+	{ .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
 	{ .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
 	{ /* sentinel */ }
 };
@@ -704,9 +709,13 @@ static int ci_hdrc_imx_suspend(struct device *dev)
 
 	pinctrl_pm_select_sleep_state(dev);
 
-	if (data->wakeup_irq > 0 && device_may_wakeup(dev))
+	if (data->wakeup_irq > 0 && device_may_wakeup(dev)) {
 		enable_irq_wake(data->wakeup_irq);
 
+		if (data->plat_data->flags & CI_HDRC_OUT_BAND_WAKEUP)
+			device_set_out_band_wakeup(dev);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index e17ebeee24e3ecc4b1c2d153d9ea9b656b5a3d35..c6451191d2de68607a9380482701d11f949d0ff7 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -66,6 +66,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
 #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
 #define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
+#define	CI_HDRC_OUT_BAND_WAKEUP		BIT(20)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1

-- 
2.37.1


