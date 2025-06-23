Return-Path: <linux-pm+bounces-29299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9B3AE4063
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE013188368D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A9248F7B;
	Mon, 23 Jun 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GrlxxR9p"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012029.outbound.protection.outlook.com [52.101.126.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAB246BA5;
	Mon, 23 Jun 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681903; cv=fail; b=Chx55+EwsGQkR1gwlJ+32ptmtZYtHLC2z7eP8pQrp5Y6RSPHsdBDqnOMRZpZn9pyw/IgTNqLOlfOyv7ntaohl2A4LOhSPojthKJwhFsnf0OchOZmN9KFeMiacFnTALWLs3fSX9gIa0isTVERuLFMLNDyCYEikUqWyWcA0XrHlOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681903; c=relaxed/simple;
	bh=pj8U/OFxZ1RzWVBWXAsuTUH8PoXqXWUjpcXCH8LDWVg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=betivXpay5DjbCw6MBMJoauT88yUcm8JwtyzgCu1KNhQUWwg+tX8P354LgKH36l1TaSZLR+R0/vGecny/8g5gBWEs455yOczjPnHxRar7wIapSyLdd7OJYEUL292M1nNDtm3EOE6/1A47dsOlJ2OkCJEEhpwUNbawTeuky2bqOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GrlxxR9p; arc=fail smtp.client-ip=52.101.126.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClYzKlUakW87iLc80/AqnywHo4cJKw8X7VFuq7BkqOcDgeBgAa3LBNWJmjEtPo0QiFXT8S74nGl/lFHKemwk4SQ8qAkoDCimPlMzMrI55Ba0nSjFHZ27d3XYDbzs4MRQEzUR4oMKZks6Ry2KGAhUrlkZ+jmqLaGjBWjUQAzIiVRQoK9qz48Ur10gzdEI3tlj5qZ1EtZ8wq4T0p2RjqjiQAHoaVA824wNf4AXfl2PsOYiiDCU/i7pj/YwaM5aXkytpRqEiCQlQG1b6aJ0Yf9iuhcjgLfON5PWIoFODuyHwLj8Qoekh55VDIWE0wojoWwGLhA99JMm2E3T5RSFomDkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDBV6B31uO1pa022sfof1l2E+pfWOIJ2LDwkRo+GA18=;
 b=cHxM2Y/ZE4R7JnJuJgiIvCuFBxhgQ1pvAOG5dArAaIiVH28D85KBWEK4wHW/5q7/ZFTrG8sgnpmZMLWwPTCG3iJugZnyhfJagtbm9hupjsNl5TSt+HQceT1NjrUDzFhjzff/kAVU0S4bRPdlvjOMYFo88nMbJQKWiBpIhj0LxvBUUoiVxbUWA9ULejFBk0+6Qa06BI77hW1wvNKY91z1ZIDFINNO98k83UnVq4Hjhz+epPuiBTvNpMhPesZr/jw+qq5cIlxXWyV73KmNrJekSdf3tHhBqAHK0TfdsK1Bid1Uvw0q9KQex/1Q1GqWZm1W5rSAApJ7AfPHiF2FCIUKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDBV6B31uO1pa022sfof1l2E+pfWOIJ2LDwkRo+GA18=;
 b=GrlxxR9pZmTnxf2exnJEJmlVYGHCP5ebIefH8BArKRCP5d9qpYFPdT+bMs5iauTiDr4kMpbAO2K5F3OGbxR4tbaNpiU4NV5v9rTS6yCggwx2UtLxljqgg4xZALp6wVq+SSju/Yt8O0GZ1HQ7+ayB3/hf06Y83sJ71+Ay4+leodbIqBpIuPWXBdzQGCmoNB76H9BZk3BKQAGvIiDqGiFAhfWQKLu7Ck3/0u4mSW1LT8b5uIEn5IJe0+KqZqp/grZJPYqLb7L2T5X8jXyEeqdrWozs575VbeO7LwasJusIzc2JRmIiZZdmdEv2UjvxHwtHv6JLcQ8mBnuWowbRH7iTSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TY0PR06MB5185.apcprd06.prod.outlook.com (2603:1096:400:21f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 12:31:35 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:31:35 +0000
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
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Julien Panis <jpanis@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yury Norov <yury.norov@gmail.com>,
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
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 00/24] Convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:30:33 +0800
Message-Id: <20250623123054.472216-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: f1c08ef5-d1e0-41dc-26e1-08ddb251e3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFphQUQxbjVrWHhDelVvK1RaZGFjNnU5bE5jREo2SDhzV0oraUgrSjBEanor?=
 =?utf-8?B?cThWR1YyMGxZNTdkUmtWRGREVVFXM0JYbVliQ2hvMk9PYzdYRXdPZzhoQzli?=
 =?utf-8?B?VkNzS09XcTJBN3B0V0JmS2VVTEZmQTdSOGFxVnlGMWo3bkEzYTNYWlZKdUtm?=
 =?utf-8?B?R0pnNjFjN0o5cUJ5WDBVQkJydlU5QVRvZEJMam1lQVVVVW16NzRvVEZ4Uko3?=
 =?utf-8?B?OWNUSS9RS01JVzJ5ejAxaytyYk5uelFscG5ZejFtTVBqL3hHWXlpbk5QNlRE?=
 =?utf-8?B?Y2R4Z1VaLzhUeEtRZFBYanc0YzRVWWRPelpRMkRlYlltT3BQUldmL1QxUHBO?=
 =?utf-8?B?K0UyS29TWE5reXJGbTVnQUZYY3N4M2tmYWVvRHdTaGdLVlVFbzdMSWxIUmRq?=
 =?utf-8?B?TnY1VzEwNVVhU0svV3RGZUxLeC8zWnFKRE9RU2w4Yjh3Q3RBTnQ1bENTMGIw?=
 =?utf-8?B?aGxaVzR3Q0JDZVdNTG9jYnFpWHQ5azZZSm05OFoyM0p1ek1NdE95RzlhckhU?=
 =?utf-8?B?cW5nYWdQaysxZHY0V210NVltOVpTSld0NUdIRWFSbi9sMHRINTV4WENQTWZH?=
 =?utf-8?B?V2syaVpubC8xSGtTOVVWb2kwR1dNWk9iaGFwY0lmTmlEMnJoNE15QTc3Vmh5?=
 =?utf-8?B?bm53RXJNZkkxb3BvZDRYUDZ3dXVBRDB6dVNqVmV0eUlQbmtCcEVMOXpKdVky?=
 =?utf-8?B?WjUrNFBScFlhVUt6WEEvbGRxYWlmZGU2YjlQamlpcGNHeEdHdzdBdlVQMGRj?=
 =?utf-8?B?VXl0STM4KzVVMHNONXZNc0VNcGpKaGZvWkZHQXN0cy9VMmcwVjZuM0tPQ0Iv?=
 =?utf-8?B?a1laOWJhV2JzWFFEMm9HajVxdmZXWWpreUFaSisrRlZJdTVERWpSeVpKbEJM?=
 =?utf-8?B?SkQ3Z0x0WmxMYUI1V2RRaUdkVGZPL01Zd2ZJVExIWHBIazVRUmpNOWhoNXVo?=
 =?utf-8?B?YkRRckxvSEwyeU9hbnFyVTlxQ0ZrelJtQjVza0VHUlBUWWk3bU55NktIM0J5?=
 =?utf-8?B?VGdMaHYzWHQwQUVrMW1hYTdBSmpUYTBIckdNNGRHN3laeXJlQlBIeGREMWxh?=
 =?utf-8?B?b0V4dklsV1lRcW1XUlBPTmhrUGorWGwzbWJXU05pTHBsa01FNGgxK1IwMzZh?=
 =?utf-8?B?N09DVTR4Q3l4YUU2Mjh5QXEwcDNsWTFlc1VudmVwbEN3WUNQemNLVUpGa09p?=
 =?utf-8?B?Zk54YjdHcDNiZGtKb3I4UjZXRStSTzJEMnBwdFZoWDNocTgzQWtCRWdiMEVH?=
 =?utf-8?B?dmtVSndLRW1CY0hmV0tKL1EyNDI2cExFeDhDRUJkMFhUNkU1WDBYcmlkbFpa?=
 =?utf-8?B?MWRqeUwwUEhrM2haTlBDS2JtRFF2MmxyaVEzWmNoazlHNlhhTkJweVdrQjVs?=
 =?utf-8?B?L0VwdElFLzJlSjZ1bUtmb1A4ZGd0aHdpZFdSOG52dVBkZXEvZXBqMjRvSVRX?=
 =?utf-8?B?R094ZGliNkEwRmVKSXNiZXlmeE9PcDdkMVZZdlpwWFNDaUhOMlMxRCt5a1Vv?=
 =?utf-8?B?c2ZSMkdMQmJzK3NITUVCd1huVWh1UFg4RnJrTjFmbmFvT1I2UGltY21RZ3kx?=
 =?utf-8?B?UFlWazJ0dnNINmdSV2U3d29hOW1yUWNPK0s1QXM2UXJsbUk4NVZNUkllMHND?=
 =?utf-8?B?WnlWbTdEVVhwOExmcWtMNWlkNTNuMHh4LzJ1TnZVVHljaWpMNG5IaUNxdk5u?=
 =?utf-8?B?SFgrVHVLUEh5MGUwcmNucVlTcGF5aGoremc5b3J3YnFoUm01L1Z1bEJmUHZI?=
 =?utf-8?B?L0F5ZmJVQ1BLUmZOYkgvUUpDSnhtWWpvcVk4bVFGYy9oSWJHOEtNVUJKWGoz?=
 =?utf-8?B?eVRQSzRTNE9qdVdVNFBlbkZUWlhMZTlDSjA5Q282ZEhxWms5c3JqdXBlSDhk?=
 =?utf-8?B?ODVyQVBUeG0vcjY2TmdHVTRWSVFkdk1DUmIvZXBFNDhwRVA0NWYxV2hFNS9k?=
 =?utf-8?B?ZmpPZHlFWXYzSzVrSk5taTJMcGU5ejAvaTUyVFRreFlhNzVBcSt3NTNwMjZG?=
 =?utf-8?Q?2g6nbIXDHkuDJdVqhd0d6aiIc4xEPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFRGK1ZnV0FLazN0Y09mQVV0RUdUUzFFSzhHV3hwc0hZUEpjQ2RKOExXeWNF?=
 =?utf-8?B?U0YwMUlOc2V5R3J0eU9tNHp2Y3pzUGpIUU1EUFZXQURrdGYwZGNvd3pRQmF2?=
 =?utf-8?B?RTJlblBYNkhvODQrRGt5TjFVb001VHdVcHJWcXlVRk5NRnhhdXJZYUFyemRa?=
 =?utf-8?B?YTYyeXJJMnE4eHFtYktGN2xVTGlFRlFwb1N1c2RQUDUwc2hBWGZJWWhOUWJz?=
 =?utf-8?B?dU54YUJEYTFLKzhFSnZaNWo0bHg5ZVVhelptWUxIRU1FV1BaKzVIbm8vbUND?=
 =?utf-8?B?MndSRFdjK1JYbmxSaW9lNngrMFNYSXB3amlQWTRTN1lyT0FENjcvMFcxSWlU?=
 =?utf-8?B?QnJHamk5dDlsWW9sNC94Rk5VSm56MXFMYWtvalFUUUIyWVFwenlBZjNmcFNK?=
 =?utf-8?B?a00xWmNXRmZDQW05cGU4dHlIRE1zUHdxQkxqWFUxWDUzbEQ3aUloR3dacjRo?=
 =?utf-8?B?Z05hOGVndDVKUkNiV2s0aWdhYzM4Y3BCSFV6cGpkZE03YUtkcHEzQmxBYVpF?=
 =?utf-8?B?MUR2T1dnZ0JyaWJnMi9zV0xxNzErUDRwdlJJTFdBbzFLTWRabHZsaHozVTZB?=
 =?utf-8?B?RjdmNlhxUEZoclNWUjJoMW0wZnp0NjRVaDA4dEh4enJQM2RGWnJ6R3NBNVRP?=
 =?utf-8?B?NVBnNG5mbC8va2lFY1lLRzN3N0d5elV1Y1IrOTk5OTY5UjErTm5HRzFFT2VV?=
 =?utf-8?B?T1RjYmFaUE9tK1U2d0RyTGF3eWl0bVNOSit1cFVGblBwY0pIaEQwdTE4UlRN?=
 =?utf-8?B?bHZLeDRMTG9Cd3BJeTF1M292OFZOL1JGVTQ4ZmZFclVianhtVjAwZ1h2M0Ji?=
 =?utf-8?B?V2J5NVBzWEdoREl6RlFCaDhrMU9FZVB2UGMxbDhOTUxxdk1Ma2pnZUtJbFNR?=
 =?utf-8?B?Y3laZ1AwajJFbVVCdElKZXJ0MFFMYWtrYjV5WU5aRVFUNDVxWkVzQWEvMExI?=
 =?utf-8?B?VWVYNDZaRVZNQUwwOTUxeG1kdjU0dUJmdGkvK2Uxd0RZK1o1Z2t1dnBNR2lB?=
 =?utf-8?B?QTdWMkRpNWFkNTk0VVdzT3BTU2dhV21LMTR0eE10VzdDaUpoYlE3djdHaWFQ?=
 =?utf-8?B?YXpwM1ZraW11emVUZmZ4RW5VY3R5aXRJYk11L0puT2FOcWhKT2xiMjk1Lyto?=
 =?utf-8?B?TGJMVzNvNDFoTXJXdDhjYXFlOWJvR1F3dXV0OGFZbkNzbHVyN2ZLcUNtOTZs?=
 =?utf-8?B?YUdNaXpDWXZPcG4yZmpScjNzMW5yYkRBY0crTDA1ZERRdlVWYzVnbXNjRDB2?=
 =?utf-8?B?aER3SWZKSjlFeEtPME5va2NYb2hzTHJLZCtxR1J2MER6RThEV3FiU24zS1pM?=
 =?utf-8?B?SUZZbkRHZmdyREFVTEI2UGdEcHVjNmRsZVpUZFBoR1ZPRG9HYnA4RVJHU0Jz?=
 =?utf-8?B?aTVjT2xjbVFYdDRNVGw2ejAzbUl4VGJCbkRqd0F5NnFrZUJkUk00WFBOVEFP?=
 =?utf-8?B?TDN4eTQ0QXgxTmg1dXlIZXZHODZaVFBWb2NVREFtVkJrUi8yclVrcnVJdVFh?=
 =?utf-8?B?d3QycGEvZDRTVGZqTGJPYnU0RjdvdSs0NWs3MWVwMTZaVDVmK25DTFM5Y0xD?=
 =?utf-8?B?M0JHSlgzemo1cFJib0gyRGNtZXNQMGNJZVZSbTRpdDZqdUlsSmo2em04Mi81?=
 =?utf-8?B?NDAxMTBRdkhuM3VDQ3ZhbUNhK011akhNdTNNTTlScVVPWWszeEZlRnh0Sy9O?=
 =?utf-8?B?R293ak55ZmVQV1ZYWVk2a0JoU3d2NjlBbjNxc0h2NUhYUU1XUTdwSm9VemJy?=
 =?utf-8?B?RjN4dE92cFlKc3Q3c1c1NEZDKzRpUDRBL0F4dGttODZncC9UL2sxVTg3SGJY?=
 =?utf-8?B?aHhhY1hqRlI3K3ltcFNiOHViSFBUbXVEbjlCOTgxamlwTVVNT2VqQzFtTFBJ?=
 =?utf-8?B?OWxlQjIyZmhwdXFVZ01RTEJ1MEJ4cDg4VUlrWi84a0ZRZFhyYlIreFl1NER5?=
 =?utf-8?B?SHRQUk5mRndtS3NONHF3ZVRFVjg3dU1EU0RFQlRWUkg1UU9mV1lMSzFCNTda?=
 =?utf-8?B?ZkZvUXloMVgzQituVElScUN6NU84Zm5ibDBzdHNaYzFmYjFzSDdmcUZWeWYv?=
 =?utf-8?B?azFYaytMZmpPeU4xV3hjTXdqMXcvcTV0b0xPNWY4UzZub2dwcEw5K0k0eFQy?=
 =?utf-8?Q?yZaQi34CdSMe5EbJv7LZDGYyU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c08ef5-d1e0-41dc-26e1-08ddb251e3f7
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:31:35.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4SvOuCrRE1NxOi+Aw4BCbHhy0oqH1NBLm2bc7zNz+GWjnEDXrD3JLvTNrUThBQuSMuAnpq+qyXBWtDnMdvcEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5185

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

Hi tglx and Rafael,

Could you please consider merging the entire series into your branch? 
To be honest, I don't know whether merging into the irq repository or
the pm repository is the right approach.

Pan Chuang (2):
  thermal/drivers/loongson2: convert to use devm_request*_irq_probe()
  thermal/drivers/airoha: convert to use devm_request*_irq_probe()

Yangtao Li (22):
  genirq/devres: Add devm_request_threaded_irq_probe() and
    devm_request_irq_probe()
  thermal/drivers/sun8i: convert to use devm_request*_irq_probe()
  thermal/drivers/armada: convert to use devm_request*_irq_probe()
  thermal/drivers/broadcom: convert to use devm_request*_irq_probe()
  thermal/drivers/tegra: convert to use devm_request*_irq_probe()
  thermal/drivers/qcom/lmh: convert to use devm_request*_irq_probe()
  thermal/drivers/db8500: convert to use devm_request*_irq_probe()
  thermal/drivers/renesas/rcar: convert to use devm_request*_irq_probe()
  thermal/drivers/qcom/temp-alarm: convert to use
    devm_request*_irq_probe()
  thermal: intel: int340x: processor_thermal: convert to use
    devm_request*_irq_probe()
  thermal/drivers/exynos: convert to use devm_request*_irq_probe()
  thermal/drivers/hisi: convert to use devm_request*_irq_probe()
  thermal/drivers/rockchip: convert to use devm_request*_irq_probe()
  thermal/drivers/renesas/rcar_gen3: convert to use
    devm_request*_irq_probe()
  thermal/drivers/mediatek/lvts_thermal: convert to use
    devm_request*_irq_probe()
  thermal/drivers/max77620: convert to use devm_request*_irq_probe()
  thermal/drivers/intel/bxt_pmic: convert to use
    devm_request*_irq_probe()
  thermal/drivers/stm: convert to use devm_request*_irq_probe()
  thermal/drivers/qcom/tsens-v0_1: convert to use
    devm_request*_irq_probe()
  thermal/drivers/qcom/spmi-adc-tm5: convert to use
    devm_request*_irq_probe()
  thermal/drivers/uniphier: convert to use devm_request*_irq_probe()
  thermal/drivers/imx: convert to use devm_request*_irq_probe()

 drivers/thermal/airoha_thermal.c              | 10 ++---
 drivers/thermal/armada_thermal.c              | 13 +++---
 drivers/thermal/broadcom/brcmstb_thermal.c    | 11 +++--
 drivers/thermal/db8500_thermal.c              | 16 +++----
 drivers/thermal/hisi_thermal.c                | 12 +++---
 drivers/thermal/imx_thermal.c                 | 11 +++--
 .../processor_thermal_device_pci.c            | 24 +++++------
 .../thermal/intel/intel_bxt_pmic_thermal.c    | 11 ++---
 drivers/thermal/loongson2_thermal.c           |  8 ++--
 drivers/thermal/max77620_thermal.c            | 24 +++++------
 drivers/thermal/mediatek/lvts_thermal.c       |  6 +--
 drivers/thermal/qcom/lmh.c                    |  7 ++-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |  5 ++-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |  4 +-
 drivers/thermal/qcom/tsens.c                  | 23 +++++-----
 drivers/thermal/renesas/rcar_gen3_thermal.c   |  7 +--
 drivers/thermal/renesas/rcar_thermal.c        |  9 ++--
 drivers/thermal/rockchip_thermal.c            | 12 +++---
 drivers/thermal/samsung/exynos_tmu.c          | 12 +++---
 drivers/thermal/st/st_thermal_memmap.c        | 12 +++---
 drivers/thermal/st/stm_thermal.c              | 14 +++---
 drivers/thermal/sun8i_thermal.c               |  6 +--
 drivers/thermal/tegra/soctherm.c              | 38 ++++++++--------
 drivers/thermal/tegra/tegra30-tsensor.c       |  9 ++--
 drivers/thermal/uniphier_thermal.c            |  6 +--
 include/linux/interrupt.h                     | 15 +++++++
 kernel/irq/devres.c                           | 43 +++++++++++++++++++
 27 files changed, 197 insertions(+), 171 deletions(-)

-- 
2.39.0


