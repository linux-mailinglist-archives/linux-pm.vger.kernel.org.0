Return-Path: <linux-pm+bounces-29300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD3AE4079
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE5166E11
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07A2475C8;
	Mon, 23 Jun 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Q+xc1/8k"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013055.outbound.protection.outlook.com [52.101.127.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65212C499;
	Mon, 23 Jun 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681933; cv=fail; b=IlS0mRMZ1LMyQgSCTlZtvFYAHeCn4HA//jX1IKS4XjwPdw4O6GujnhjzhDa1ATBFNrFgBqcygfHDjdrmdMIwXPDWq+UvzdvhkSIH361xRptKEi1F8BpOuCPNZ99fChgdDJhfV1iYUPbRU7XvjRJHNBLHzpguhOh+JQEy8gKr1sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681933; c=relaxed/simple;
	bh=Tpfwy7lTMgV42NFEkAN5PiSCjy7Zcq7FKF8xwXsU+No=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGjtNGQ7PjMsJI/UAOVebDqlh1RtTLUsm7Ja54AKAyO0GHo20FzJEo6cUqzOZiIzQ185ocGH/Dy6KGYcwMWC7mzQ8LKzhveMT1bGiU3xtqVKOp6wGUkoSDQWbpxA7MkY2R8FvdfYR11NBGN1asJS0d5BWa+om69Di39EqS+Iv4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Q+xc1/8k; arc=fail smtp.client-ip=52.101.127.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LabcuhEI7R0OHPDl6CGYqLYHr25DLNeSHKGqMPr4MfdhX4awHYAPAmAi/eeeQEPseWETC+yyre1zu99BG0riVszYD6/N67ns4bPopLPXSQnkcxbZF0itwQTjAA+CkmAro6VMxzLG75wo43Rzkn2BGRJq/Dj2g8WrWr26yHNTaboJ6NFCGsprYtQ2gfkNbtA0FMOOAc3JIp4gK2T6YSqQg1Mv2LUkIdYXqZF5h+2JAtwR0grQd8XODViNAcXWzkTlf2YhBu5E2R2+yAQ3lqSQq03XJmb23B64ppOh/gXRBMQpd/jNmiYxWF5eZSx3R8izm+yqfVxBAEnyc1oyYCg2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vocg3RzS4BO05UD+5EdoWPqN5uUHyMEOG0x3xH7h0Q4=;
 b=dz8+M5m+mmzBazqnVCC7L7DvavNn7/+kSpg7rYTuQ2p6w2zXVHqmGKtITs579/D1w7zTXWSAj8kNl5B4lalgeGkLHNcH2NWbtBHZb1yDp1TSwkHBVonA/CdkHzugH6SaaPotJ0LAoV88GGXa+g3bMbhM7bCIfvc3LzPYlsHQKnsxhSrB6U5RrjIwDVb3GloRZwPCOF/1mkuX7sKu4172F77qF4XLU085UTT4mQz1yu0Dggnkvj7Qq4mBMZQVUVudS2GW5yLTJ8xTWnFsu9zlDhKjr6AZWhfvDeMGQX/ZUChcWZOslGUM/e33x94XM/YDHUOuHsN1eyvxB+R5ASSptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vocg3RzS4BO05UD+5EdoWPqN5uUHyMEOG0x3xH7h0Q4=;
 b=Q+xc1/8kKmI1r2CZ+jreb/MupjlqPrTomkN+wUhfEIHAroHfoJtx8uZJ2DJKCY6Bj8V7SWVZomsR4oiwsFyma3lzWU4TkyTJaGu9pjgN0vvdgIeUaI+SxnOjmzOruoomkIeL8EJz2lWuAw4RPmbrjHySSHlCcn3fosNPjgK6oxeYELjVKsjVMp3668rj9PI41U7dxuFKNn9NxW4mNpKfzZP7xH2evs9eqiXweQoTl8hYDWu7zHo9nZf1LfJ2NgKuFKcgeDazHKunGi7FFvlWmyKVzih5gIrtBgOX7UWzypyBjqpP+E5tHeKbNVrqRabdpsw9lQ73uqrJeOfJk+ZUcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TY0PR06MB5185.apcprd06.prod.outlook.com (2603:1096:400:21f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 12:32:08 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:32:08 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Julien Panis <jpanis@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Yangtao Li <frank.li@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 01/24] genirq/devres: Add devm_request_threaded_irq_probe() and devm_request_irq_probe()
Date: Mon, 23 Jun 2025 20:30:34 +0800
Message-Id: <20250623123054.472216-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623123054.472216-1-panchuang@vivo.com>
References: <20250623123054.472216-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TY0PR06MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: c61aa7dd-385e-48db-7762-08ddb251f7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnJxcVRJM01VNHBES0FKVkpFaDh3NnJxbXF5N1RPVkRhdG52Tk1pWEV0WnND?=
 =?utf-8?B?bTFTbE1kdUZJQ1JqZXM2WnVTYU1XWFBTWGtpQ3BzQ1ByaUE2U203RVh0RTZU?=
 =?utf-8?B?UlJROCtqWWhxTGlZMkQyenZqRWJnYkgveHNpSncyNGNyaEw1MXBGb016S0s4?=
 =?utf-8?B?VGtlTjZyemk0K0FLOVJ4VXM5MnMwaTBZL2ExdGl4Lzcxb1Q0QnhsdmtqUGJw?=
 =?utf-8?B?L0hUbG40WCs0Rk9WcEwwSXZENkRTQnZiVlhvckRhQ2JDYlhMRHFMZ01SaFFK?=
 =?utf-8?B?TkV4Y3phYTlnbDdxL0RnZk9UcVFWbXEybTFuVTVUYmcxaitIUjhUQXAvMGVW?=
 =?utf-8?B?NHNaZzNyUkI2em1UVjBUV3JyTGtVWjdVMmU5N2ZnRmczVFFvenZ3K29ZMkJw?=
 =?utf-8?B?ZXlHWTF2bTVnWVEyem5MZTkyZjRPWFEvNDcyekJ3dHdENS9McGFnajZHR2tj?=
 =?utf-8?B?WGY0M2hzNzA5T1VxWnJ1QzhmVFpJVm9ubGpsTVl5N3BlK25zeUtiTzFlQktT?=
 =?utf-8?B?UENHeTlrdHEvN1hYNXNhWDhUZS91NjdVTGF1Vk5pcjV1dXFKMU9iK1R5VDJX?=
 =?utf-8?B?R1licFByczFwdWlkcGZQMnJZdmxoWVpTR1R6dFU0akJRN3FRZHJIbFd6RWhZ?=
 =?utf-8?B?bTNUUzNLNjJQSlhsYU1BSzBBWnppL0dnUkxPU0EwZ081OFdJZFUyV2tGd1Nq?=
 =?utf-8?B?dlBBeEF3L2xpc2o3WkpnMTFsczdKbXNpblVYVStXa0NCdjhEUWxqRm5LK1FK?=
 =?utf-8?B?T0poM05BbnlUaEJwOER4QnFnc2FKSUVER0lGaTVscysvM0FlcWJRYS9mWVlF?=
 =?utf-8?B?UXdsSXoyVlI4NFBSM21nZkVudUJXWUdCdGhFTWJ5U2h0S0hKS0ZaQ3BMYS9Y?=
 =?utf-8?B?WTFJNTJydmFGRjJ5ME1yQ2RMSUttejVnZWQ5QzlXZmk1cVVGWU5NeThVTzdZ?=
 =?utf-8?B?L0lod05BMEJ5bDZIdlpsRXpyWURHZGtzWWI0WlRpd0Z0bGsrcDU5ak8rMGg4?=
 =?utf-8?B?N1MrUEROZXdoZTZxSkZDdmIzSVVFek1MNXhtTjF4M3ZZWWUzRHJhcHZ5Zzc3?=
 =?utf-8?B?VVFtcUN6ODR5c3I3UDFJVSs3T2NTY3praUxSM2R3UCtpVjRlUVZQUlhCTDBv?=
 =?utf-8?B?Snp6V3h2eG5BdVpaMUdldy84aFFzME0wdTMxL3JIK25CYkcyMWhjSmZqd2ZJ?=
 =?utf-8?B?bFU0QlpxUzdoajRHNFdaeFRhRXF5UmcyWkxtVUhJcFlyRlVwUW5ZZHJMdWdN?=
 =?utf-8?B?RGlXNDFtYWx4Q1hJZFkyK2tiUm50eURhbXdrTHJ3bFlRWWRKb2pPalJZUkJE?=
 =?utf-8?B?UGVDaHJuSEhYMzd3K2lIOTVWem1jMkY0b3NTemo3Q3JJOWRyQkJiWU96Z3E1?=
 =?utf-8?B?ZXJsZkpQbGRSMGpNWHM2aEJ6cThNb21FSWxnYVVJazhscDl2ZlhGQ3Y3eWxE?=
 =?utf-8?B?TG1hbm5ObXZXM0xBeEJQQnpkK0VVQzJOY3I0SkRRQ2N2TTh2R25lZnFSVDV4?=
 =?utf-8?B?Tm5sZlY0YmEvZHhHa0VUWXBwNGxCNTlXMU5lQTZWdjlGREl4Rm82YmZ4RVJy?=
 =?utf-8?B?VFFNVHNMQ0V2WTFXR3BGU2lnUnpXT20xNE90TGpscVlTN0I2NHdYWXVZN0Vv?=
 =?utf-8?B?bEswQXpXdVlUUithTnExWWxSYUtjcTA1THQ2KzQzWkFudWNja0RWT09yNncx?=
 =?utf-8?B?TldNQmxIbzNQYmtMazRSUjV6c3luVktMZVI4ZGpaN3gvWExheFEwQ2k1YnZu?=
 =?utf-8?B?VFBlWlZ5WXpsVkVxT2ZCUllobkR3aEZMWlUweEFiSEFYUmV4bzBnQyt3Zkh1?=
 =?utf-8?B?cmFqeXlRbHNuYlZJWGVzRm56T2k4WEE5SUcxaC8xeWhRdlNXbFJCYlhTZmUz?=
 =?utf-8?B?Z2pMK3pmUEF1TXpjV0NrU211c0dtU3BWN2ovSkIzYllPMmxiTWxmRlNPWktK?=
 =?utf-8?B?MGZpNFZMdlRkeDdGbGlkVCtkQjAwdCt3MmNDYktJcTJLMUF0emRzWExnYzBV?=
 =?utf-8?Q?vGbVMGJiVqd+Xuj82qbiunZZjucegU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxlN21nczh1ZzVhTi9CbzN3bWMzZXRMTjlBL2xURUpwYUwrTktVanFnWU0x?=
 =?utf-8?B?Q0dQa3pmNzRQcDdBbjNkS3hFNFB6aHMxOGZObzRGTzU1eExjT0dlOFlubXRs?=
 =?utf-8?B?aFJaM3lieDlHb1RiTGxkYTVobmRTNUhnZ0hONDRkdzhuanFxb3dRSWlPSkVR?=
 =?utf-8?B?WEpSNWtaYUN3Q3NreDd5OCszSDBDemk2cC9WRXNnc3UvOEtQV3BhMjhscGc0?=
 =?utf-8?B?Nk9hUTJvZFhSUmFqZnJ0VzVkMHFMZ0tkeHl1b3JXdE50NmhjV0krQm1hMllj?=
 =?utf-8?B?VDZNZGs5UVQ3KytRUm5LMktRR0tJV0FuMFdsQUQzRUlIMnZpQkNXVVN0a2d6?=
 =?utf-8?B?am9XZzlrY24zUUN2cFMrWVRCVWlJa01ML0ZLVllrOUw5TlB6WjFjSHo0T3N1?=
 =?utf-8?B?SHkxWVFpaEZIc2pQU24zR1h5RW1ObnUxYXdETWVDNTQvNVo5T2VabEdSZFpw?=
 =?utf-8?B?ak1tTzBwTyt2d09WUko3WjhTQ29Ib0ZDR0hleS9NYnZMVjZ4cTNHTjdoNmo4?=
 =?utf-8?B?YjMwdm10U3FvNFNUMUlKUi8rUVdsL0hWMEJGSjRPeWFBeDh5bFhMM3Z0TUJC?=
 =?utf-8?B?MDQ3TmF4MW0yeTdRN2JIMnRKN09BSjB6VW5FdTNqRUZhUDlUdjdPVHFwZnR0?=
 =?utf-8?B?TmdYNy9ud1FSSVRPMU91cHNyQTBHbHJaTnNYL2tHWW1mRk82cElrTHRiTE96?=
 =?utf-8?B?VHVyUTNuTkhFRTZ0Y2JBdDhsWDc2ck1XWE9yMDVpZk5QT3RGL0l5Y0IyTFJm?=
 =?utf-8?B?SGFpSFU2KzdIMXJnVWJmRlNPdGxpdlFZVWhWYzBBQ05ESncrYUw1Ny83Tmt1?=
 =?utf-8?B?RHBqaE5KdUx6Z2FnSHkrQThJN1NwcnNDVkhpTVo4akhKVEcvd1RUa2RpbXZF?=
 =?utf-8?B?REZZU292Z0U4N0JHVXd3WU1HZlRKRzNIRVM2UmdEWXNqU0Z1TlVCWTNZK0Nj?=
 =?utf-8?B?bElXcmZaU2F2RTlHTGZvczUwZGNWVm1VOTBWZ1hEMEQ3MXdGNXcrb21pT3Ru?=
 =?utf-8?B?VXFMVjIxV09qTkdZOUhxdGFRWWd0QUlVQlBVUm9PaS9wQ2dVN0dxa3ZsUEkx?=
 =?utf-8?B?YVUyMWZLdmFvRkZPbHBJOXFNSTZEejFneWNHUUt1dm9MUE5tdWJKdUwxcGIz?=
 =?utf-8?B?TjBGcmJJcnZvTzFMV3A1WWVpTHNYVzNmWFZXVGZ4c3JNMk11aSt1NEJudHRt?=
 =?utf-8?B?ZHdCZ3A1TkJySUd3ZGFCZnhNejJCVHZ3Z2lnWTFSZm5IbHE3MzBnQmtnR2hF?=
 =?utf-8?B?Z29aMHZkRS9JR2tvcXlsT2R6UjJRck55ZWJYa0xzUXRRQmJaY0pialJtZkNp?=
 =?utf-8?B?Zm5HOHY0S0xhRWROcjErTytOVWlUSDhkM0F3bmF3cURFVXVib3p1OFNRS2lT?=
 =?utf-8?B?OHhSMTFsQXkxYVJ6ZkpvVm1BRkRXYU9DcnRsQi9wRGJ3M1hTaG1Eak5SQks1?=
 =?utf-8?B?TUhtSWsyZkxDNmQ3ZTRmcUorajgrK1hkcUFPdG8rNzVubFc4N1R6UnZ3Q25u?=
 =?utf-8?B?NjY0S2ZiMmdVbk1sTEFPN0pOVkVPaDZPQXh4ZS9Bd2pqMFJKQjVFeXdzelpS?=
 =?utf-8?B?ZUl5NGVVYkNYTmNPN2J4VHZ6K251NUJYN0RJZlNFNWZUUTlQZDBtV0ZDTXJ0?=
 =?utf-8?B?TFZ1aGpmWUo3ZXVFUGRsRndPV3lpc0VmMjVWd0VBamVkaWFNSHF1VFZnUWVv?=
 =?utf-8?B?N2IrekJ1anhPaDJLc3dzbTFDVHF5MitrYWhBcm1mTytiSUFhdDFkcjEyVGt0?=
 =?utf-8?B?bVJJTVRJR2tBS0wrUzlqWDVRZGRlOTBubFE1Z29vY3AwT0YySGd6NVRtK0lx?=
 =?utf-8?B?YmVvTld0Qk0vS3NtRTd3ZDNoU3dRLzU2YWs3d3lSbUEveHpKbHVoK3VGajUx?=
 =?utf-8?B?dE1GbkZvU0pkQkhqemtXOFF5MFhJZFpGc2lNS25EbjRrMkpMS3BnU0h4Z1hF?=
 =?utf-8?B?SUQvWUliUFpIL2JZdFdIZWxlZTdTYklFdXBIamh6UWV2dFlCNVBXUDR5Mi9w?=
 =?utf-8?B?RllWV0Zsa2NiQ0pzaU8yRnNEbmRWKzBPOUxOZURIdE1HMjd2NTRVUVlFUE1s?=
 =?utf-8?B?a29RTHpMSGR1UGZZMVFuUzM2MGtLQyt3bTNhVTFYOVBOUHAwUDBtU0k2TE9O?=
 =?utf-8?Q?iMKdvg6GuIQuRKhYwwKmP7xAH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61aa7dd-385e-48db-7762-08ddb251f7eb
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:32:08.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8TrhS4vQSuLAO+GIir2a6VCIS0vwqh+lw53pF3RgoxHJvQjWInSiMN/Rr3pbfTx8t/tHesWblORkRrIeMwyaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5185

From: Yangtao Li <frank.li@vivo.com>

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So add devm_request_threaded_irq_probe() and devm_request_irq_probe(),
which ensure that all error handling branches print error information.
In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 include/linux/interrupt.h | 15 ++++++++++++++
 kernel/irq/devres.c       | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484c0493..5c39ff7f030c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -205,6 +205,21 @@ extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
 
 struct device;
 
+extern int __must_check
+devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id, const char *info);
+
+static inline int __must_check
+devm_request_irq_probe(struct device *dev, unsigned int irq,
+		       irq_handler_t handler, unsigned long irqflags,
+		       const char *devname, void *dev_id, const char *info)
+{
+	return devm_request_threaded_irq_probe(dev, irq, handler, NULL, irqflags,
+					       devname, dev_id, info);
+}
+
 extern int __must_check
 devm_request_threaded_irq(struct device *dev, unsigned int irq,
 			  irq_handler_t handler, irq_handler_t thread_fn,
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index eb16a58e0322..40e3862b0e80 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -80,6 +80,49 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 }
 EXPORT_SYMBOL(devm_request_threaded_irq);
 
+/**
+ * devm_request_threaded_irq_probe - request irq for a managed device with error msg (recommended in probe)
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs
+ * @thread_fn:	Function to be called in a threaded interrupt context. NULL
+ *		for devices which handle everything in @handler
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
+ * @info:	Optional additional error log
+ *
+ * This is a variant of the devm_request_threaded_irq function.
+ * It will print an error message by default when the request fails,
+ * and the consumer can add a special error msg.
+ *
+ * Except for the extra @info argument, this function takes the
+ * same arguments and performs the same function as
+ * devm_request_threaded_irq(). IRQs requested with this function will be
+ * automatically freed on driver detach.
+ *
+ * If an IRQ allocated with this function needs to be freed
+ * separately, devm_free_irq() must be used.
+ *
+ * Return: 0 on success or a negative error number.
+ */
+int devm_request_threaded_irq_probe(struct device *dev, unsigned int irq,
+				    irq_handler_t handler, irq_handler_t thread_fn,
+				    unsigned long irqflags, const char *devname,
+				    void *dev_id, const char *info)
+{
+	int rc;
+
+	rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags, devname, dev_id);
+	if (rc) {
+		return dev_err_probe(dev, rc, "Failed to request %sinterrupt %u %s %s\n",
+				     thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
+				     info ? : "");
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_request_threaded_irq_probe);
+
 /**
  *	devm_request_any_context_irq - allocate an interrupt line for a managed device
  *	@dev: device to request interrupt for
-- 
2.39.0


