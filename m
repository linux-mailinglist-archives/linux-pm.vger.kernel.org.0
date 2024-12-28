Return-Path: <linux-pm+bounces-19795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3279FD8AD
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2962A1652CA
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F68586350;
	Sat, 28 Dec 2024 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C/tf/3lc"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA65D477;
	Sat, 28 Dec 2024 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348570; cv=fail; b=lyGh/zKC2SotZfeyNimfs124UwsQm2Vygm/4dgKtT4iQu13aXwAjqgcSmCszYIUqvgYNHazr0R0mjaO5v4bmvkS9SZzC89EyAwTsrQMZXssLWkONKUVy+BuZiNDDeErMGHzGC0d20KpIf1oSoL8ZEI8NuDdKpdO/+LMRNnZMXFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348570; c=relaxed/simple;
	bh=ZKjmg1MtBFOISkDUMyTeytnGcAdAAATDapDdHX79doQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jYwwJRiIhVp8fm6b+a1FkcC/t+zsrlbvCCkHVvHNJapAqMKpgnrr+R9oTxd04sUOUkAWG/weUsslaRkM/A6LVVUXzxmMmAGH+lPvi+LEbVMObokqr1H2MyryYssJTfiQ7AkhXYRnW3EW7teoY/vl7VGKqzhYiiiZ1Uxs6SufXqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=C/tf/3lc; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW73kT5SM2qg5sm99Xy7PevMYBjQmCodm7XlAhgWBDpCUxxz1/k5Rpo37/EgD4o5CAADs90yk5vsyGQ747pzPFBGGFYWSomG61TuPRI1Ula4WdZ9Zeerx3ltqT7kPlRS8EfQ2TqTgZYDpYI53g8nmrL6aUfxYohIlMnpHbupJGOskTFaK40Ui9WnulI10E154X/Zrz6VSL8wpE6QqoMK+dDq0YgBstmgH4sXDJq8FNMI64jT6gT5qW30WaNiYwM/Ql2qzsZyQQtVYADpWyX2cjkaB+1UBeEIrBIvSljaCNeyn7pZYqiIkDK3accHSOcWH1gRtNel48ldtowgkxCVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukcfnak6rASj1mOqRwYrxQ2oQzH5Bwejo3Xly8lLTrQ=;
 b=qcOAbfADEE3yCiHYIZ7hnRXsplmajjCKkWDVMtSkoj+NAXsDe+lLJQl/iQ3f0VvaWHLJjAVpLdxiv512Q9dtd1o2Io3vWO+o59c4HEWMyUqcWg9NrTFUHaPJbVclW65+Svrhi7T1+/5lYPgfKrNHgEX9iwX1KhtlIM7tXunenFkOGJZ8XyZ/Ce6ACOEmtD7iqx3KFpQkC+etaXi9O3B5WIOP7yW5dZx0Vr9IMUFm0ElARv8aJAHOwVAydcl3eVzuvLzD7dr7PlTc4jAUt8PykdYqVs8Ca2FQz8VIdomnY761ymzc3Bj2GU3OLFvypmotGUyyZMlim2T5KaBWiP0B9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukcfnak6rASj1mOqRwYrxQ2oQzH5Bwejo3Xly8lLTrQ=;
 b=C/tf/3lcOThIwmHuUfWQZrYwl3CVThLUQMhCZ9IOzbKddcmYgsdUGK3BuFrXXj00A1E+OOsCOWrjcM9F8RHf+RUiY8/bz0zyAmo/G85apfMwQu/CdCnqW1xd4eVIM+/voXR+Pas7JESQZOuNygFUoFRui5xCDixH1rlUHg91hBiTGqqMkSHz7LIkqxRAbKUj2ZNPjxslLPKwc3CzuzZPtkCZlO/tuLlq88aiIBc4ceQBo7Vp0CGgKzyj4aY46b+usIQf4LPLi1xsQltgpxQk9WVvuXK64On5Lfp2VVJ7Ypm7sy4+ltqcsdvFpVVZnju23wJ2kQKshYn5zBCWgMzeJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:16:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:16:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:45 +0800
Subject: [PATCH 09/12] rtc: pm8xxx: Use devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-9-09cfca77cd47@nxp.com>
References: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
In-Reply-To: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1049;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GvTygPs23OU+WJ4Ssa5ar7+WSYAkUwf2a/2JL3pAL9Y=;
 b=fuTuUxBpzA72Kp21pez+zNIQrc7GeIb80GQ6AoCih6Kuf6w5GU3tFr4HYAL2bco0pS2GFVYAx
 lQXFpAX3Yb9BFXbDZCsQZuX/uNEfUOyCxP+nzE5dENo4Aq3m1j79BLI
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c455295-9197-4e68-5b11-08dd26dd3092
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmFST0IvV2hGalljUFdLcVd6V0hqS25EaitTNWlFYmR1WlF3Y240aGlTaURh?=
 =?utf-8?B?TkpXMk0ydTdpZXpzN3FDTXMvcUIzajd3cGpFUUZNZXNOYS9zWTNXZldJS3F4?=
 =?utf-8?B?Z0xkRnJ4dXdCTGpxYmliVnFMOWd3ZlYxd2ZmZ1FxZzdraldiKzNQem9ZRCt4?=
 =?utf-8?B?YkpBVnRTR0d1bWwzVkdYS2JTbElOUUtENGNtY2lhUlkwQ3BpZTJZeW5QdVlP?=
 =?utf-8?B?NG5CbWw1WDA1S2d5KzhKbTNkR2R2K21neGFBWldmOUFYYkZiMExvRGVKeDNU?=
 =?utf-8?B?NzZRQzhWU2dKYWVSWVk1QWlqWTFCcCsxQ2lHbEp3QjZuWDV6UmhyK2xocTdD?=
 =?utf-8?B?VnEvWGFLWUpiek1tWXFoMVhhWjdUQTJvZC90U25XQTcwbW1reTVwZytZb2ww?=
 =?utf-8?B?Wnk2V0hkc3NVVzdzMHNWTDF5cnkwT05TMThIRCtIcGpXbDNpVWJpV2NWYTRw?=
 =?utf-8?B?R0h2djJpdDZ5L2J6N2Z2UUxJVGQzWW1RcDRqRGtycis0RmdJNlp1azNWSHpJ?=
 =?utf-8?B?K0dBZlNDUmxIV2Z4Z1FQaHJabkEwTXRuc3YvQmN0RmNZL1JLTm5LNHZGRXJ0?=
 =?utf-8?B?bmE5VG4wZU9tY1YrQkYvUy9SOGYwUHgwRXluTTY3YkVKSVo2UnIwdlFTYWpt?=
 =?utf-8?B?MXArQjI2bnRoV1ZKcGF5bVFIY2cyR0pSc1BrQm9KcmNFWngwNG1YU01DbVdL?=
 =?utf-8?B?UWxra0FadFFNcGd5RTAzNU9CcDVmVnlDTE9CTFZFYVBpbkpyTVVLckIvamlD?=
 =?utf-8?B?NE9tZnpNUS9BdnhSK1pHSUk1dVEwejV1S1FwR01EL1FoQk54MUdIcFU5U0ht?=
 =?utf-8?B?L0Q1eXl6ZEhmS0lkK2NVVXEzK3JqRU0ySHFSYk9TaVQrTHVFYzIwb1BsY3FR?=
 =?utf-8?B?cVZCcml5NzA4WnptemJoZmxzb3pISnBIUHVZOWtNQTNxSk0xWDBMNFJzNGhr?=
 =?utf-8?B?L1kyVDlRYjB0NjkvaGdoN1ZjUzdhNWt5NmZ2TzNWeEZzNHIwSWEyS2s1ekda?=
 =?utf-8?B?WnhIS29EVmhYZ2dJWDZ2U2dsOEJyc2YzWEUvczZOMjZDdGpZNkJ5bGI2Qkpl?=
 =?utf-8?B?TmZqRzNkRVRUTmZzN3RYeFhxcm5DZHRhQXNkbTNuSWJMVU9hbXRCSkFLZSt3?=
 =?utf-8?B?SnRHcmIrY0ZQUDB2N3h2eDJOV2ppcHp5NWpUZnU1MHVra1NkZVVSeVJIRm0w?=
 =?utf-8?B?cFRRUEJ6YWdZZ3A1WVljbDRUUXhkYVVnc0FybFFFOWNHNllUY3VuOE1RbHp4?=
 =?utf-8?B?ZnJXS3BnNENHMXVyWUNHRTUyS2V3aHNnVnltSVRMWU5XS1MvUnlLTGVDS1NT?=
 =?utf-8?B?dFQzUVJqVkVLbVdMMExha1kzelo1TTBHZEF1VnBHM2IrS1YvNFVqNGpDZ0Vt?=
 =?utf-8?B?cGVlQzlGZ2hBSmIvcnpuQ3lvOU1IeWVQNEh6YmRSZUp3YTRjTlpCcFJYNDRR?=
 =?utf-8?B?V1FuNkdJV2NmU2xIMEZBalFSczZ6bFZXeHduNmZnZFhQSXptYm94TU53eFBC?=
 =?utf-8?B?YllCcDd4RUNGb2szcVBOS1hEZnNJTUlFbXBnd0Z5eCt4d3ZNL29PMmUrT3Yy?=
 =?utf-8?B?MGQwNENHc0dVRXV4OWJ2WXMvbnFKb2lVSkpONWIxM0Q5M2tDRG1nODlhay9k?=
 =?utf-8?B?ci9qdTdZdWcvRThUazRiS29MUkJhTmR6L3BTbDV6SUNJTHpPbFdZTldHaUxJ?=
 =?utf-8?B?UjVkU0FXclIxM0dLS2FFUFpHNnB5Vk1tYTNWSWZpUlh2UldBQ20ycVZJZ3FS?=
 =?utf-8?B?RjVrL0MydSs4NTNCbDJ2WlhJanpOQXVNelEyVDJCVitPemVJaUxWdGhJRHdR?=
 =?utf-8?B?d3VHMHBRZW5PV0NuRFl5YW5XTkN0ZnBBeklnQ1RHNTB0aHYrUi9JZ2k2MjJH?=
 =?utf-8?B?NzYyYXBOV1NLYzNGL2EwS2FJZHVQcVcwdVNzc0tSU09US1NxcW9hYm5QQjVy?=
 =?utf-8?B?TTVJVjNXS281Nk9MWXJwUmgzM0dZVTJ1M2NvbVEvYXNBZWo2V1Fwajd3SkhF?=
 =?utf-8?B?dXBWTlVjRWhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHp2cW9PemZCbno4RktGUEJQTitBUjhJOXBtL1FYeEZsbWc3ejdFWVcwYllN?=
 =?utf-8?B?ME0xRUpEZTI4WDBkcGFqeFlRYUFHQ3JMNFh2NmVPUStUbGsvcy9VQXE5WXpo?=
 =?utf-8?B?Y2JiY1Y2VWdZQ2xhb0hwVVVLT3RSdTV5dDhJOWFHczE5N0wyd1BiWTd4MmpE?=
 =?utf-8?B?SWRoSWJ5MUI0TlNJb09lcUFtRXF0RHJ5ZS9kTENUZFEzbnRncGp1SE50ZlI3?=
 =?utf-8?B?TS82cjFudXJveGwyazN4TElna003WkVEWXZNOUw4bDhHcmFNdlM5RXNMcTJp?=
 =?utf-8?B?RnZJbFVpOXJuVkZ6aEQ1SkRNNmtjanJlWEl4R0tjQXdGTWdjQnhQNUF4a2JH?=
 =?utf-8?B?Mkc5WGZwRnViY2xqSGZMU0VEQWo4cmxOeUlTbmtHcVF6WDVPQjFaU0RuUHAw?=
 =?utf-8?B?bDR6clpMMjFNWjJqV0w0M1U2NkhJMnBHRDlrUFpieUcwa1RudUw1aHR4WXpu?=
 =?utf-8?B?cG9XeCszSXpUQjRqMGZtaUVGL1ZNYldDZ0UzT1VOMVRiNUFZTWZGbE5RS0h2?=
 =?utf-8?B?VVkwbXpuOERMQXRqREM0cFR2UmVJREhXUmZRS3R3cVhWRW94TVdYcWZwTTlQ?=
 =?utf-8?B?dFVvblduVzJSTVV2WkZoekRMR0lSN0ZBUHVNR2QzbGl0RlA0VUx1Uk1EaFhJ?=
 =?utf-8?B?Skl2VFZSK1pDOHdyYzVUSlpIdjUwL21mVjViUjA2bGtqQWpsWklVbEV6WHFr?=
 =?utf-8?B?aDNabnJZcXl5Q2ZQZzlNaDc2NGo3NFk0RlhBakhhRXN4U051UXZCQjF3STZk?=
 =?utf-8?B?YWgxTkt1bVYxbGhPQmMwLytieStXcjMwbUdMeFFEK01SLy9tRk1XV3ZCaG9m?=
 =?utf-8?B?NlRFT09oMG5ZOTdtS0o5NlY2aktUOFNZQUdhbS9GcVNWNzJ3SHJDT21hU0JG?=
 =?utf-8?B?d3VSajBTZG1MVWhkTSt6UWpQcnVwMXc5V3RYeTJaZ091VGlGVkhYQnZiMjdZ?=
 =?utf-8?B?YjQzbGZPaEFTdE1Jc2RJYTFDc2dzOEdBdDlBL09icktXbThsc2JodXNjcE9w?=
 =?utf-8?B?dU9mbnhMUy84QzJjWHQ4NytFTGZsS2xkNHNBNVBWRUx5VG5xdEV0VW9Lbytu?=
 =?utf-8?B?M0NjclA1VHcrbVg2SDNOM1h3WTR5N0lESzV4akY3dFN4aUxDUVJRcjdxNGZI?=
 =?utf-8?B?bGxCRmdud3RvVXJQakUrWUlWKzM1TjY4eDJlNGVBUjBmWFhNUG56WTM4MXhY?=
 =?utf-8?B?Y0Z6Ni9peUs0Nlc3RjVsUjNqMmsrMTF6bWRlc0NoK05hOWNiUi9MTHhBMHNv?=
 =?utf-8?B?enBLYnBiaUdsb3M5NGdZM2N5RXFZb3Fvblh5Zm40bU1PRHI2WjcyYzllVnBS?=
 =?utf-8?B?SUNhS3BvUjBZTmx1Y25NYWUya1dLVk55eWU5bXdFY2tHbGFrRERoSVB4Vzcy?=
 =?utf-8?B?ckppVTNCTmNKL2tnaXpEVGR4S3RWOGxuYzI3RHRuVWdiVWJiOGhleW0yd2lV?=
 =?utf-8?B?Tk92TXBvVTM1TElKRWpHblgxY2k1QWE3eTM0WE5WMm9BRWNPNWpPRzNjZ1U5?=
 =?utf-8?B?ZnZQajZzOXRUbTdZOUlTQWdQSUR4SnZaMVJSbXFLUHVWYUtlaS9iRStnRGM5?=
 =?utf-8?B?MSs3SDQ0czVOKzlLZHZUZG90ZFA2ZmxLakhrSXpRM2dVcXlzWkw5aTJsczRw?=
 =?utf-8?B?TURkNExLcEJzdlo0V01DTnpLZ00vMmR1dnRSSks4THFIZ0NRQnpTUTRsS0ly?=
 =?utf-8?B?OE1ZRWJMRVJRNmsvRUdpTDVoaUxFemNQdXRJMWF6dk8yRUk3MmMrcFdWS1Zn?=
 =?utf-8?B?OWx2ZWtmTFljUSt3Z3FldTBkVVFSTVJrNFZhZTZ5TWgrVTN2eWRqQXMwTy9y?=
 =?utf-8?B?dlNvVDNMMm8zU1NUekg0QmFrbUVjUFpGejEzeHhYanVuWUhyMzdSRk4xWm10?=
 =?utf-8?B?NDZxVHQ2bXYwSGdJbEp3Q0lSUSt0SDFnT0ozeE1QcFBRRjk5SkdHeTZBaWk5?=
 =?utf-8?B?UXF0bThRTnlEMEJ5TXRJWUhMYjVGank3OUpvMVB1MW1yS2hqMWRSZ1ZDck12?=
 =?utf-8?B?NzBVN3V5U3lmbXBVK3BnU2Zob3BRZzFYOVl3YW41Tjl3a1k5NzZ6WTBCK1d1?=
 =?utf-8?B?SWEzaXMxV3UxeW9GWkRGMUJnd2dMb0phNVNQRVh0YVg0ZjhqZ1FWbk83b1NB?=
 =?utf-8?Q?cg/h5FEdxTGgdKFrYzVyp1rDv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c455295-9197-4e68-5b11-08dd26dd3092
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:16:00.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyY8PCxEPmljJos9fmkXDE7ay/AXbvO3S/dSe9oHFq23WNU4jI7bbcKJv2IUy3Ml6BGmWmYN3Rh+bC9u3a/InQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-pm8xxx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 2f32187ecc8d3276a451a317ab83446b7b04ecc8..f1b620b168fcca8c640e4beaaf7e8c17776c5ed9 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -523,21 +523,11 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
-	if (rc)
-		return rc;
-
-	return 0;
-}
-
-static void pm8xxx_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
+	return devm_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
 }
 
 static struct platform_driver pm8xxx_rtc_driver = {
 	.probe		= pm8xxx_rtc_probe,
-	.remove		= pm8xxx_remove,
 	.driver	= {
 		.name		= "rtc-pm8xxx",
 		.of_match_table	= pm8xxx_id_table,

-- 
2.37.1


