Return-Path: <linux-pm+bounces-29456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B8EAE74FC
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 04:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE40163887
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9711D432D;
	Wed, 25 Jun 2025 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QqvSQJaC"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012018.outbound.protection.outlook.com [40.107.75.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E82AC17;
	Wed, 25 Jun 2025 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750820091; cv=fail; b=hi+XoPeA5mayOgS6lD/YtiEoow5Xv1/YE6Bgdl4NMuDUhApOpGgrGyRUBN0OChNYcT5YbtUhPkEOu15Zok1k6tKyq6iw7hk+sM88O/uTAhsRnRRnt/0sUtIYCxMIv9eptJy3d2woD7uNKV4NWVmh2/MIO9VAqFvJLlM35bClGks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750820091; c=relaxed/simple;
	bh=4HIoj8FDWkTWOmynsZ+SE9TwmgNTqPHN98TZcvobkA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B29sJhgaKU8zUNkbj2TJPiUQO3k+z9mUKCKff9kkxF/tvD8Hd6040yvxyhdLd1ZQKEAi2/GnhYXMD1CEiV+vJI6cA+KoPGmp3CQu62dQPZC9AFk7jH15E7UwV0rWv3IHyI//yReFJbZwXWsrN9aA9HwwcEZtkOPMIfDbkn9Bi2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QqvSQJaC; arc=fail smtp.client-ip=40.107.75.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayz4DdvE18B+9tpwcRn+mYPkkrz3vJLydeQ4NnGgFBWb1uPZVaAgMRjf75bvJIBmQPJNXgo6ECpc35jcGavxQH0558toSEUTLyMVlOnkohCKjAscRWRLGLMuUxKM6ckCt3vs/NIYudcGpEFyC27rCUmUsLyqbwGYgWD/bNnSSXl+rk6s4mu0K8bjvBe5AgH702TsDDsxPM7986oFxBxRy0ZQOznSc3g0RvHMAnfHx590LOHOhvhiGGUhVBPMICzVrDHj2opbccw9A6J1HXhyIreinuwTWG7dhl9f5N0kLMw1ZhjAGA19BHSXkrvIt+kngsU9HtELKelENF4hmSetgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HIoj8FDWkTWOmynsZ+SE9TwmgNTqPHN98TZcvobkA4=;
 b=Trh4BaebK6XUTaQ4D/naEZwRS5i7xLA0c02YcyMd8irLhzPgQchGmhXgQDEiqOZR9E19xxVlXl3o3yW/FWfhfCP/rHI2c0AJKKGmIhDfr4CMAMUAy2lhhLvX4PHGuz0b+LwIzPhC3Q9nnzXLa8SwsHt+NGwWDFBl1PJ4HD8ZB48qAq6F4HK8anHIlhIvrqXGc+1nMWTm29uL0cgAqyYw9T2FFKewqBjTYehOrCZjQ4hE8Xum7KkfvyBQfznv83M8dO/G/D0+f7qLHhJbO3v2JwpARtdIxQ2SR2p6FTIohzGcfE4At5hskSjoUXbHwdmtcG12E9IQySNFRxhdwA7XWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HIoj8FDWkTWOmynsZ+SE9TwmgNTqPHN98TZcvobkA4=;
 b=QqvSQJaC5ncGFotmBLm5RiHAHlAcEhkHYT8o3CPmWhAUI8C5X+gVyC3nKAptJiYIuGinHw+4FioVH0QC45dt+qRJK8rpi94ViVx1GLLPRxvOPyoeWx2MKT3mYjWpU6DXpzQG7qIOB78gsxWXB8WoJGMf5WEIHCD+hkYo9GAzRUmDjuATvjjpbox6PS/ecaroXYxnOwu0PQH2GRrO/O1sG8+j6p8cEvCdZoAKV1jhXpneoO4J3/hEDjRT2AtzQPeZ5FVcycK/wl+b5OAK5KBa4g+477QqquTa9yyPhfkoLyaRz1jqEMd49sPFTKxPbnSXJgCugMoCp43I9X+jKiDYGA==
Received: from TY1PPFECF6DCA7C.apcprd06.prod.outlook.com (2603:1096:408::92f)
 by SEZPR06MB5440.apcprd06.prod.outlook.com (2603:1096:101:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 02:54:42 +0000
Received: from TY1PPFECF6DCA7C.apcprd06.prod.outlook.com
 ([fe80::9d84:835b:c798:76bf]) by TY1PPFECF6DCA7C.apcprd06.prod.outlook.com
 ([fe80::9d84:835b:c798:76bf%6]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 02:54:38 +0000
From: =?utf-8?B?5r2Y6Zev?= <panchuang@vivo.com>
To: Thomas Gleixner <tglx@linutronix.de>, Miquel Raynal
	<miquel.raynal@bootlin.com>
CC: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Markus Mayer <mmayer@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, zhanghongchen
	<zhanghongchen@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>, Amit Kucheria
	<amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
	=?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= <niklas.soderlund@ragnatech.se>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Vasily Khoruzhick
	<anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	=?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, Conor
 Dooley <conor.dooley@microchip.com>, Julien Panis <jpanis@baylibre.com>, Arnd
 Bergmann <arnd@arndb.de>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, Colin Ian King <colin.i.king@gmail.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, Costa Shulyupin <costa.shul@redhat.com>, Yury
 Norov <yury.norov@gmail.com>, Cheng-Yang Chou <yphbchou0911@gmail.com>, Caleb
 Sander Mateos <csander@purestorage.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjYgMDEvMjRdIGdlbmlycS9kZXZyZXM6IEFkZCBk?=
 =?utf-8?B?ZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxX3Byb2JlKCkgYW5kIGRldm1fcmVx?=
 =?utf-8?B?dWVzdF9pcnFfcHJvYmUoKQ==?=
Thread-Topic: [PATCH v6 01/24] genirq/devres: Add
 devm_request_threaded_irq_probe() and devm_request_irq_probe()
Thread-Index: AQHb5DrVs7AhkZH9IkWAHjahbM1E5rQR9y8AgAE1wec=
Date: Wed, 25 Jun 2025 02:54:38 +0000
Message-ID:
 <TY1PPFECF6DCA7C0493FE1041C661918E91DA7BA@TY1PPFECF6DCA7C.apcprd06.prod.outlook.com>
References: <20250623123054.472216-1-panchuang@vivo.com>
 <20250623123054.472216-2-panchuang@vivo.com> <87h605o8vd.ffs@tglx>
In-Reply-To: <87h605o8vd.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PPFECF6DCA7C:EE_|SEZPR06MB5440:EE_
x-ms-office365-filtering-correlation-id: fe0c1224-3adf-4eb3-b556-08ddb393a02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3F4MC9HZVg3U2t5YkM0WXRLdk5xK0lEMzRjcWZuUklGcjZRQzFBUzlMVldh?=
 =?utf-8?B?ZUFWemNmVWdqb2d1elZmUFg0SDQvbGZzVGxPUlFnVzRlL0dOY0xvYjlEU2pj?=
 =?utf-8?B?NlZjZ2xMVGpZVlVMMlJ3dE5pT1YwRCsyajQwWTBHaER5V3FETjNibXhtZUFk?=
 =?utf-8?B?bWlsTDVROFNVemRhRmlMWnA1cWtMN1dhcURrcUo0dHZScVpJcTdhdFVXODBD?=
 =?utf-8?B?WWVnUS9Nb0dHUUJNOVRGTndGVmJyaHgvc1JBZTZwc1h6dW9GTWQ0WWFZalhz?=
 =?utf-8?B?M0NXTkFjUzFoS3ZsdmRiM1MvM1dGRVh5QTJHNU5oNFYxRFAvcEZJZ01tRXN5?=
 =?utf-8?B?ZjQ5RjREMEE0VGNBYmhCU2hhMm9zd2Rab0RFYk1rdi80Ynl0L3VadWdLNWhM?=
 =?utf-8?B?eEhGMHFjY3JpNzh2WmQwWlVtd0JhUm1nRmJ3SkFTWjU2UnBqM3QxQUtydndH?=
 =?utf-8?B?emhBTWNMbHZaMEVYb1F1UGRNWTZwcFBWSjJIVUhHZTkxNWlTMUtkWWRSN0Zn?=
 =?utf-8?B?YWQ3U05HVm81VzhVTXNBVG5BUi9NQndIdHpwUnczTlJ6dy9oVUdqcVp1RTdv?=
 =?utf-8?B?aTZQekR2cHF0OUhBV2pDS0ZvSThUQmxUZW1ZWEcyYVcvMFJveVNlVkU4WjhL?=
 =?utf-8?B?enRZdzdnUkZkNjBHS2pyVjZ5VjlaNkYwcWdGdGFaVzZLa3p4R2p0dWVpUGsx?=
 =?utf-8?B?ZG9zdTl3STJNb28zUUJIVUtDL0FCQkx3c3MwbmZtZnhqUGo5RC9WRk5DaWsx?=
 =?utf-8?B?bWNiOHovTHR1VkRWbjkvQ0x4V0thZXZYKzNPdUNya3FzUFFvZHpzV2dXK0I0?=
 =?utf-8?B?RlhMZ0s4ZmxneVd1Mll3b2tjVnErTjlEd1RPc1c3V3QyQ1FpbkdoVlFQOERJ?=
 =?utf-8?B?QnFUdzBCa3dyY2VtYStKN2ZudXNLUGhKQUtneWhCbWNqT2VLL2syWG80anc1?=
 =?utf-8?B?emFZdWpBejZxczBDVVBEK2FHeUc4UmEyalJHYXIwMHdJRGVhd0xZczZlZXVy?=
 =?utf-8?B?d0pDbGdMMXNJU25oZ21leUk1MWJLbGlLNGN0aEJVMzJRaGM0Z3ZGV21EWE9X?=
 =?utf-8?B?SDJLOWkwSmlTUEdDQ1RSZ0pmSkEwQm91T09SVDhJTkhuWUFtZVlXd0Jrdzd3?=
 =?utf-8?B?dlNIcERCZ1h0bkdId0lMZlBOWDVOMENUbUQ5NU91dm1peE5Fd0tKRmRkOThp?=
 =?utf-8?B?K1NXK25xY2JIL3dZeklBbHlKN2VNWjFUUkpzRVBJNkRqMENJMWlzNDNjRWl4?=
 =?utf-8?B?TTdwWUM5UnVJa3dDcnNxQXpuMm9SSS9vVVFJY0dNSGwzZFdRZFFjL2ttUGZv?=
 =?utf-8?B?VzZvbWtTbi9zemtZWnlmSE10MFF4cWFxZElsYzBEMmJaOXJ4SkxlSXUvTVI4?=
 =?utf-8?B?NnhFWGc5eTBxQUdxQ3d2NFJpcFdvMFFYUVlmZjVEVUREazl0Vk92cFZvaTRY?=
 =?utf-8?B?cmhzWVNUYk1iWEFwdTltTjhvVkQwb0ZKZ2hwT3p2M2dzcVFjbnJQalgxQi9S?=
 =?utf-8?B?US9Ca3pwTTdxV201RjJ4OCtkS3NQTkF4VlZBcDJHb1NxaDNyRGRsZlZlMzZm?=
 =?utf-8?B?THJwenFtS3hMSGZJdWdHV3NUWEtXbUp0N3pxTUZuU09oRndpbnREYVV0T0tt?=
 =?utf-8?B?MXN6R0JYWXd4VWxabFNqVFdURGY2YVRwdzNtOWVvK1hzbFlCTy8xWWhWdzFi?=
 =?utf-8?B?YnBPUUQvVmVBU2ZnVVhPWUdCbSt4ZlFkM0ZpMm40Q0h6Nm5ycUxvR0VGZDds?=
 =?utf-8?B?WGdEMWVPQVBaZ0ZwanJTYWpIc0trNG5TTTBGN2Fwb2VJclVINUkxZUI0V3FP?=
 =?utf-8?B?V2srSHBDUXluUytKOFVjc3FMU0R5bjlMaXZFb0NZTktZQUlRV3BIRDlaOUlm?=
 =?utf-8?B?bEYvWld1Z1hPRHJsVEh5bXcyOU1zOEVkQXBYak5SNFRuT25tTjNqZ1lYa3ZH?=
 =?utf-8?B?OFhFdW1lREJVSHBNNUVsV2c2b05tOVp5SWFUMjhOblQ1aVpZVU5VcUJZWHpq?=
 =?utf-8?B?MnRqTlNWcTFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PPFECF6DCA7C.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0pXZjd4R0UwMnJqcW5XL0Z0ZnVFSld6Nm9pU0JveFlsZlhLQ1JLSG5SUHc3?=
 =?utf-8?B?U0ZpaEpyNFpwZStvM2VscCtwV0Qxc25sNUZaeXQyYWFkRGFSK1RCTnQvMGt2?=
 =?utf-8?B?ejV2Ulg5SC9tWVZGbWZUL1NKVGlXbzR3RHlJN3M0aXZ5Y1B6ZEhpOERJdVlN?=
 =?utf-8?B?V0xmMWM1eW45RlExV0hZYkVCamNUWjV3S3M1M1JNVmtHVzNmY3Qyd1NPMkNO?=
 =?utf-8?B?V01qanRpZHc5c3ZDVzVCUEVlWHp2dXFkYlRmVkJqUGxxYXBpTXZ5RkZsL28v?=
 =?utf-8?B?OE5Sakh6MkRTT1NTNGgrQ1oyVUxUTzcwVHQ4TU85WkRVOHo3VEprOERJc0dM?=
 =?utf-8?B?cTV2L2dZQXdnZWVRUU1ucEVsb2NkY1VkTUlaSDQ0WGZuL0hRRlJLRTEwVEcw?=
 =?utf-8?B?QzFuN3dsQjhrZWtEL3BRTHdRMUVOUng5MjdBWUNoMVY1djg3My91Y2xRa2tG?=
 =?utf-8?B?cGN4dlQrTVdFNVU3VkU1TVFKQ2NpU2J6aDdLWnhGYkJVUGFjM0drV1ZvUzdE?=
 =?utf-8?B?QVdZd3hRTDNqdmJZZmQyNkVLb2VqUGVvK3Zrd1Fla2FlS2s1WU5neWEvZzcy?=
 =?utf-8?B?YmRSUnRaUXdIcVhKQTBTSys3ODNqMm1hRlFaaUpvaVJPS3ZBbCtkYUR4Vkl3?=
 =?utf-8?B?NUFib1BTZk1aRDA5YzRVb296dFJMZW5QcUljSGdPNGEwY3NpbUVuM3V0Z3VR?=
 =?utf-8?B?OWc3TmRLZFNzNzVIQkZKejhTc0IrRURNMmowZ29FT0k3bTBkWnNMbGEzUisr?=
 =?utf-8?B?aklqMFpyMGNSSkpCNHlaSmNCR0ZWNG5ucmZvNncvS1ZNbjZ6TVlsNmxxMGFY?=
 =?utf-8?B?SUJYL3pNRWxuYnNubGZIMGtzbU5FdlFtRXRqSllvdzgzck45UFhGa29sTEFH?=
 =?utf-8?B?M2pWNkRtQ0ZVREcyMjJmalE1Q3FQUzV4NEVWUzRHNGFhTEZZNHE1eVRJaXdL?=
 =?utf-8?B?TjNsR3hxVHZGb0k2c2dPeHpFa3VuQTVKSEd4a3NQV1d2ZXhyRjVlMWxWbE9S?=
 =?utf-8?B?RW9tSTZqQjVqcVI2eXc2V1ZKRnlDQkFTdG9VKzVKT3hCWEl5eU1Db0l5T1pL?=
 =?utf-8?B?Y2o2QmdRSmJvdzN1dk9UQlFVOHdFL2xoRkRXWWVpVjVHNGJwTGlwc2FOSytn?=
 =?utf-8?B?OU9xbmp2TlNrQUpZVUJPV0ludGEySFZyZ1dZL1I2eENKcUo0bE9mY2o1RS81?=
 =?utf-8?B?YWhEVW5wSUQxdmZTZmNnZ3dHZVFJRk14ay9sZnl1REJYRldzang0djhrbXEr?=
 =?utf-8?B?dSt4SklVc0VKYU1QN2hwUzJkTDFPUkp5cjRMcmRQMFcvWVVWTUF6aWVScHgy?=
 =?utf-8?B?Vk1IaDl3YnIrN3RrRGxrK0taNThvVERhbWlqVlVvbkdvbEhkclphWkdUM2dp?=
 =?utf-8?B?T3R6WFh6MG4xOGxjd3VvWExlczM1Z0VyWkgwQjNYaUZ1SmVrQ2FzOGd5T1BO?=
 =?utf-8?B?K1UvU0xla1BYNlBuTFJKSGdabE53Z29wRVZhMmF6QUZnalJTempnakttVWtw?=
 =?utf-8?B?WFUxMFg2cFFkQzR3NlI3MlRBdmtvTHdRV3BHUFNnYWdXQzZBLzBld0RKR25l?=
 =?utf-8?B?cDBYMEZyUU42Njd4Rmh6bFhNYmhQN1J6bEx5eFJCbVhpVFMxdi9qWUlKSnA3?=
 =?utf-8?B?WWxlRW9QVjM4K29GWGFSMXc5UFNtL3JkWmNLNEpNNGdQNmY4d3lKL3ZqV25Z?=
 =?utf-8?B?UVNFMEFmTWkweXpPbFJ2VmtnamtrT0g1WU1WT25uMElUclZIemxkbXFLeU5l?=
 =?utf-8?B?aStGaXk0WXU1ampCOEFYRThKR2p2SG9vR21VbEhFd2czYUQrYzNqaC9ISWhR?=
 =?utf-8?B?Y2l2ekUvKy9heFVJeHhxaFZEU2lBdjFqUjh6MkxBRmhlTnM4RXdzRTgrQnpr?=
 =?utf-8?B?dEZkWG5PdnZuWEx3VFFoSEMybGR1citqQVNjOHptd0hrd2x3WE43alk2dVlK?=
 =?utf-8?B?d0lBS3RMY01hVWxnZlc4Ymc0SWNMaDZxeDNRNlE4NHhNL2FPQlBEREUySEYy?=
 =?utf-8?B?dXpyNWZ1RnJYelg2U1RGTFZwd1VQYzNKeFRGK0o0R1RCUXR3YkxaWG93Z1l5?=
 =?utf-8?B?U0MvL1o4MGw3ejFwU2lCd08yem91NmxSWXZoWFB1UXNIdlJkYnVoeDdVRm1j?=
 =?utf-8?Q?SGJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFECF6DCA7C.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0c1224-3adf-4eb3-b556-08ddb393a02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 02:54:38.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9LdtoG6jmYBf/D4UR5FbUZqqJfJPtTSe4TgY59tVwa/++OrmMnwfQznCWOn/Hi403uJPBIQ86+WXuKoZsoxZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5440

SGkgdGdseCBhbmQgTWlxdcOobCwKCk9uIFR1ZSwgSnVuIDI0IDIwMjUgYXQgMTY6MTMsIHRnbHgg
d3JvdGU6Cj4gQXMgeW91IGNpdGVkIGNvcnJlY3RseSBJIHNhaWQgYmFjayB0aGVuOgo+IAo+ICAg
IlNvIHRoZXJlIGlzIGNlcnRhaW5seSBhbiBhcmd1bWVudCB0byBiZSBtYWRlIHRoYXQgdGhpcyBw
YXJ0aWN1bGFyCj4gICBmdW5jdGlvbiBzaG91bGQgcHJpbnQgYSB3ZWxsIGZvcm1hdHRlZCBhbmQg
aW5mb3JtYXRpdmUgZXJyb3IKPiAgIG1lc3NhZ2UuIgo+Cj4gVGhpcyBwYXJ0aWN1bGFyIGZ1bmN0
aW9uIGlzOiBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKCkuCj4KPiBJT1csIEkgZGlkIG5vdCBh
c2sgeW91IHNob3VsZCBnbyBhbiBjcmVhdGUgYSBuZXcgb25lLCByaWdodD8KClRoYW5rIHlvdSBh
bGwgZm9yIHlvdXIgdmFsdWFibGUgZmVlZGJhY2sgYW5kIGd1aWRhbmNlIHJlZ2FyZGluZyB0aGUg
cmVjZW50IHBhdGNoLiBJIGFtIGEgYml0IGNvbmZ1c2VkIGJlY2F1c2UsIGluIHRoZSB2MSB2ZXJz
aW9uLCBubyBuZXcgZnVuY3Rpb24gd2FzIGFkZGVkLiBIb3dldmVyLCBpbiB2MiwgdGdseCBzdWdn
ZXN0ZWQgaW50cm9kdWNpbmcgYSBuZXcgZnVuY3Rpb25bMV0uIE5vdywgSSB3b3VsZCBncmVhdGx5
IGFwcHJlY2lhdGUgeW91ciBhZHZpY2Ugb24gdGhlIGFwcHJvcHJpYXRlIGFwcHJvYWNoOgoKICBT
aG91bGQgd2UgZGlyZWN0bHkgaW50ZWdyYXRlIGRldl9lcnJfcHJvYmUoKSBpbnNpZGUgZGV2bV9y
ZXF1ZXN0X3RocmVhZGVkX2lycSgpPwogIE9yIHNob3VsZCB3ZSBjcmVhdGUgYSB3cmFwcGVyIGZ1
bmN0aW9uIGluc3RlYWQ/CgpUaGFuayB5b3UgZm9yIHlvdXIgZ3VpZGFuY2UuCgpbMV1odHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvODdoNnFweXprZC5mZnNAdGdseC8KClRoYW5rcywKCiAgICAg
ICAgUGFuQ2h1YW5nCg==

