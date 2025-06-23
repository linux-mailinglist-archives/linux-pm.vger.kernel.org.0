Return-Path: <linux-pm+bounces-29312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7650AE40B4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C818817A2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812A242927;
	Mon, 23 Jun 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mwSdT/Fq"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012037.outbound.protection.outlook.com [52.101.126.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE109239E84;
	Mon, 23 Jun 2025 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682332; cv=fail; b=bAi1wjKTVmDuut5dL9DRtHStIaT5KGqD5OXE7mNPjkEGJWvMj3rz7DmrCP02/rmz1iTwG6LrMWpczDOIrgN6hlQR0a6yz4xbPBCj7iclrCd5e2m5mso4hOHGb1IdVxcOINchnxEYtxtp/o6fB706WEH6ZdiNpCRLHis0qLHrh38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682332; c=relaxed/simple;
	bh=FFIfLslow3HPs/t2u5VfuSNXNCnJ+WScJEQXJeyerls=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=asuw+L+u/4CVYuFD7EBm9sqzgy9+i7EL68+aR25BXHXVNkWxyTgjFEmDbwzWN6w2tLANM8fqvXIYFSxKRvAl2cRCmzJTbFl0i77uQnMlaA5EUcsq0Appbtr8qtC1gWNb1TEk251tgbRDxHhS7pCoh+AU062mfl/stVkB8dWOkPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mwSdT/Fq; arc=fail smtp.client-ip=52.101.126.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HodDJGqEvv1C0zqW1r7BKeS6EmQGykCQAcmdpg2kosECoMrpqa+05SLKYXRrDTywEVS0HNoEh3FJtIis9Dy0w8F1xIxRovbbG0Ry+PKI0/wN4mWXuzp6Hf5dMZA6MyPgJI4GpLxIml6g5bIKrK53MiKEEOgMkNgqFHBCd2szgHcA3aEglga18cfRgYj2P4VSz4M1Gy1Irl1JpSvsOh3bsFFTiattZ4QWUjThUF4hLVZ0wb1ViHp5luUOM5yk5WvkrM63Nlq9Ukw2kwG/1DUEP8co2VodbessPqTBzAlOgcED3dIfd21imxv/3lTQ9AH//V2zvZy2tYVm0tJJOgToaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkDGdVlQZYWMN9a94Q+BlSceVeS3v9T6gqhzFf6gXjg=;
 b=iQxlggxt0YnMNnSAIG55BTqAFdsFlUyDefh1rhdlpeQZ/HeB97+1H2cs84i+pgvqSoKR0e/mli6q+t2D4zjAwTUMyF8hvtOOI/GVkfADFVGqacHSgSSnxeDwC/4ylsd1GP17m4m7ajCEJPdlzCL8mQ0CpCTj+NtGliU3EU/URd4c6EiPLiTdXPoRRhiB2s2byxIiV0VVoihldTmfPD58ERIf6lGY7ENwXQL1tnMR/AEBSVTJfhWrN8cJX4AiFcVLjAdthx94eZ/G43ZbxZB+r9VK/RJzDsyUn/DcBb41q+wElb2/1kcxn0Lve5yiZTPytdv13OZzb9MxZ/Q/TtoVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkDGdVlQZYWMN9a94Q+BlSceVeS3v9T6gqhzFf6gXjg=;
 b=mwSdT/FqZ7Qw2rk+WVGMpNpGGLpt6JVPSiRSvubVyPJccGqhpklRBwHGGjlTzEKofOsmVImPaLzvt6hBVYRrhUfvfwfh5C97jYI2CDVrn3zPudVhhtzsFn8+AXF3zqTc6g596LVzsP4ydrx5YvDqTW+mqhrAUjdMRPQiP3umF4ZGNuiXimQm7iGoj4GmGcwt0rNj0upP+m3rb0ssuYhY+//c4+df/Awt8lYGcNnH1hyxkTZNptYdIl6GJRU5EVOfinDOaNxUd7BwAcqrzCjhj4N8nW5YVrE6ba0cXiQqsCgSGpl03L8Pw5Xa92hcNzgd+GYZtMcjQ4QNUFKIhbwKjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:38:48 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:38:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 12/24] thermal/drivers/hisi: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:38:35 +0800
Message-Id: <20250623123835.473981-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: e2439b9a-f48e-483f-2161-08ddb252e664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0ZSTk1neWM4THNtV3FKSFppWXRKK3BKenMvWG91aGZKd1Rld3hGMkxzMzNB?=
 =?utf-8?B?b3E0YmlseDJMNjBGVEFjTVNKNjF0VW5VVWE1VTJlYW1paExBR0swc1ZSZWRF?=
 =?utf-8?B?WEN3V3JIME14N1JiR3RScitlNTlUdGtGRVB4KzRwWk15K3g2VnVVWXhNU09s?=
 =?utf-8?B?U3V0MU9qVSsxUExyZVpUd01pUXNPRm5YVlFmVTBoSXlCUVY3cXkyTWlBZEcy?=
 =?utf-8?B?dHl2TnNpcXJBaHNZNFRqUURxY0xLeDRIUFNudEhqbzZSZjFIT2Z6WE02VjhZ?=
 =?utf-8?B?RmJqYjljOHU4RWdDc0ZraG1SNjVUdjFPTG9WTUdERkxob3ZGYUZXZmJ5SDFY?=
 =?utf-8?B?N1ZTTlRNRnVWblpEOFZjUHJCaUlyZjFub3dxWFR1QmxvVEQvOXFQWnh0Titm?=
 =?utf-8?B?ZDhJbXpjdTFEdWd6NjF3N1JQbXowVzV3dG9ET0NKWGtJemRScjRkTWhhaHpz?=
 =?utf-8?B?Mi9VSVVXVEpFZmtuWmIvd3JFVVNWcXEwTW5XaHl3UmlQT2hGaTJjb3cwVmFX?=
 =?utf-8?B?ajdUWHNKR0gzdUNzb0hNa0FPakZnRHJETDNvV0xLTkNJVWZNOE0zR3VrQ2hn?=
 =?utf-8?B?emlwTkcvNkl1eXlOaEJ2K01nQ3JrVDFLZzlCVWlwSTg5TU56SzMvWU91M3k1?=
 =?utf-8?B?R0RrL2ZTZ1M5eUFXekV5Rmo5SHF6bU5mT0RkVGpmd0JlNUFmWWdLYzIyT3c1?=
 =?utf-8?B?MkFtL2svazE4TnBWUzIwNTM5eFhzb3ZrWWJwVGZVVWY2cFhpMDhkdWlTZnVC?=
 =?utf-8?B?d3ZoYmZTZ1ZLanF5Y0FaWXhvVm9iQUhjTkowdFdxYjdNNkp2a09aOUZ6UGFZ?=
 =?utf-8?B?N2duQXBkTDhESHRLbjFOMW43ZE1Rd21XZlViQ1pLUWp4QkJBeWlkWUk3VEdM?=
 =?utf-8?B?aW5xYmtaNlFZUlRiTHpzYTBhUFljdzhoYWl3Um15S0xMa0Zkb0pla1p1SnAw?=
 =?utf-8?B?Y3k4OTVlTXVuREtYY3UwNHBKSVFTTkErVkZXNHNGZEJqbjB1T0RDWVlqUDNX?=
 =?utf-8?B?R2ZtYmhuRnh0OWZxMW5SYnFKNjFiNnI2aDBLWDRYWnA5YmEySzRkSGlaN0tN?=
 =?utf-8?B?cDlnY1RhVnlkZW9ZdjRLeFVxNDRoNlZKVTYwMllsamk5a3NTNUt2ZDU1dWhz?=
 =?utf-8?B?bkJWVm9qUlZlYy9BdEhmd1Axek9FMGVhSEQ5dndRNC96UTZyWTZ5K3J6amJ2?=
 =?utf-8?B?VXhiV0c0alFKVk5XRE5QN21idEc1QzI5a0pjNnJGekJrQkhLZ2FnY2ZVSGVH?=
 =?utf-8?B?bW9SZzVYcmdETVFVRUIwNzN4TDV5RTRMTU16UktEQ0pWcWIraUptb3JzV0tu?=
 =?utf-8?B?SnpWT0lQSHNvV0k1Q2d0ODB6MU4xd3FsRUNmWGplcCtGMEgwOXhxaFFabDhT?=
 =?utf-8?B?ZC8weXl4TDFZb2tXemVxbk5TVTJ0VzFkdlgxemFzKzg2LzdKWjdxS2NWL2I1?=
 =?utf-8?B?NGVHWWlneEVsS3l5VTl4N0VJdzlGN0RZZUJVZTVwNUJLWUVJZUw0QW5uWm0v?=
 =?utf-8?B?aGoydzNwUnFvSXI5M1p0YmNGNjBKZ0VhNE15QmJibksrSEJVYVk2NWpnZloz?=
 =?utf-8?B?TDVROG4rZ0UwOWVDdUE3MFExTTFoWFVxekNYeTVFZHlHWDFLSjhoUVJBalhl?=
 =?utf-8?B?dzRmVmJNQ1dWMDFtZmhjKzZmaDZCYzBlQXVYbENOZUJrNDgrbGRHZ3pESkZD?=
 =?utf-8?B?eDJwViszSk1rVktNN0xCVGdSempPbURvdmlGbnRpSjk3a1FoVzc4RUNud3Jk?=
 =?utf-8?B?WDdpTit3YmJZUC9nT1BSaisrclBUMG1FYWJxNytHdU9kV0h1NXdUbU5pWmFm?=
 =?utf-8?B?MXdVUGJSMVExMDlGSENxTGtnVG1WOTBzbkpTVFVaY3lqOC9rbVIvNzFvNVNI?=
 =?utf-8?B?UU9wZ25rTm1ndDlUSlFJUEprZFRqTHR2RmM3d05jMU0xQ1J6d21weXJXbVUy?=
 =?utf-8?B?WGJNdWh0Uy9mUG94NERacnJjSDU5Vjh2d3JzQ0ExSVNlOVZxS0lHblJ4MlUy?=
 =?utf-8?B?dmhOdUZlcXp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2RoamJPNitaU01NTEppclRZY1JyVEwxQUdLMGZCeWdDZVFqZ05VTHBsa2lV?=
 =?utf-8?B?R2R0Wm5UaWpNSGJpUWx6dnRUZkJuYndLcFBYWGZnNlU0UEhkS2JWcWZVangv?=
 =?utf-8?B?YnpwbWJIdTJ4YTFReml5LzZrSGIvNlRIT3o3Sit1NHFiUkpteGtUK0d6RFZa?=
 =?utf-8?B?a3lDTHRpYitYZ0dGYkhyQU5oRXh5R2JqSlNiaEtydVNVajhkNFlKOEF2eG1G?=
 =?utf-8?B?QXJScXpxUFVubjJCRGZHS3UrR25rOGVkQWp6L1lYZUw2b2c5aUVTWmVyZ3JS?=
 =?utf-8?B?cmxZYUUvbUZsTUxxNmJMYjNCNVN3T1RkVnVnc1phaGY4RGR2QmVIdHJoVkRt?=
 =?utf-8?B?VkhMV3dhNE1HNUcyWDRCYzc5NVpuQURHOXJrNnEwVG04MDY3cjIvY3hXOHha?=
 =?utf-8?B?WjZwNk05Yzdsd1JlOXVEVk9obGZmSzV0eEtTSmt2bUkxRytoZUpLNTJmZU53?=
 =?utf-8?B?QXhMblM1VUtwSjk4cFRaTTZDQzhkcmY4YjBlMndNUU02anUyajR4cXR0ZEVW?=
 =?utf-8?B?NHpYTG9iSmk0SDUycnhYMEVJNHVSQzBBVGhpaDk4SFc5M0JsL2lnK3Bxd25q?=
 =?utf-8?B?NHdhbU1NZ0czdFQ1NXFrcHlsSjV5WUx6bCs4ZFZZcEpMbExHR3FwQXlWZnlL?=
 =?utf-8?B?UjhKemMvMSsvL2x5S1lZemM1QjVrYUpsTFpyeitwZjdud2Zsc0QxR2dhRUVW?=
 =?utf-8?B?Wk5XVUtIWFJlY05OMXFuaUlUeFJNUXMzMlJlM3BiSlJXa01UaklHZ3p5Q1VE?=
 =?utf-8?B?WS9qcUp2RzJlTEhkKzBlTllaRVJBeSthVVYxb2pNc2dja3FTQzFUUU1hcllv?=
 =?utf-8?B?eUF4a2JYdk1JSlhhMU1uck0xK3NnVXhxbXVtVGQxRmU1b2p1Y25VQit3ZU8y?=
 =?utf-8?B?WHVjM2dvRmNyTS9vZFpyYWhCTzZtNGV1ZGVLK3hyakNCSjdYZFFHVHB6ZDN6?=
 =?utf-8?B?QW1VT2VUa3hjek9oYW1VSkVIWHZwa25pQlFBdnJiQkdROGxYcnBMVlV6ekxV?=
 =?utf-8?B?WVVvakY1SWRzYjAweUdkK2ZzSmJyaU5PVSsrVmdPYlUzMFlVRnViNzhvSUNY?=
 =?utf-8?B?eHEvdVhmUW1VWlFyL1IwNGVFWG9OaU5EaHNLVGM4SkR4eklDZHJmZEs5VjRZ?=
 =?utf-8?B?U05hbTVvbG5RZ3h5dmtCTzRmOWxhdSs5SmdYOUtSUTRMRzRWemhucUg2dG1Q?=
 =?utf-8?B?dGVFK05vakZoR0dGWDl0WU9kT2VVVEhOTk0rVWZSWG03S0hjQWl1R1RxZDY4?=
 =?utf-8?B?aXNRK3E1Vmkvd01lYWJ1aTEzTHJFZ041aVlXRXNEbXFMNHljTjhLQTZ2MlZJ?=
 =?utf-8?B?RWxzL2hmR3hvWmNJYzl6UTZra25ybGtWNmFLRTJQQWR0WDRMbDN4c0l5VkM1?=
 =?utf-8?B?ZVkyeHNzM1pGMHJzeUhsZm1oMkh5SklqVDllOWN5RjVJbSt3OTRyNnNLVWhF?=
 =?utf-8?B?M01TZmZYdW11dUhxdHd4Y3piT2NucXM2M08rMGNrVzM0SUJmV0NiSnFaSnJi?=
 =?utf-8?B?WnhIVUI0K0ptM05tUk5vRTh4RW52VmNNWTNiK2plVUFCbU16cjFvZjRLUjRE?=
 =?utf-8?B?Njl6eXdVVUlVL3NzSWFoRncrdEx4VGlIMms4VldiRllBN0QrTkNuZitWSVY1?=
 =?utf-8?B?blZLTk5OVzhGSGYvZmpONEYrZWczSlA1TTVaNDlUMGVTeGZ1QmpJSENoUTl5?=
 =?utf-8?B?YW9ORktqWkROd05tVW1MVnRJa2tXRWNTTWNGY09uUVpWdlBMKzFUYlpuL01Z?=
 =?utf-8?B?UDAwa2xlYjlsS3ZYN0tHNkErTHkzdVdkR0VHbThtNFpOZTBld0RLU2dvTEVl?=
 =?utf-8?B?S2gwYVVkM21KVVUzWUZoUWhDWCtOeENiNzFzY0hVaU1tSGQ1bkQ2aDFxM3Bv?=
 =?utf-8?B?QVRCQXR0YjR2WnJwR0VFWkJ4c3hYRUlnanZTWHBaNnErQ0ZHUFZaNHF0ajJu?=
 =?utf-8?B?eEFtTlJHV3BVMmhMR25XNXY3ekt4UzhGeklsTTJpVHg5VXl0bkxTd21YdDE1?=
 =?utf-8?B?L2FENGxNYjNteUJWaXJTci9GMWZWNDNxNkE0cFBvT01yWndMT2x1Y3RNN2pz?=
 =?utf-8?B?S2xGbFMyd3V0Wm1ibGZ4aktmQ3NsaTVFZUdUWGFlYXVJZFVRbVNjNzJYWnlC?=
 =?utf-8?Q?CLAwZuh3x/IvWH2zzsKKtTmoY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2439b9a-f48e-483f-2161-08ddb252e664
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:38:48.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujJ3m5OtCUJvjBrOiPwZQOlzoRm8WlUmvbk7zqqeb+y0m2ZtRtxWoaPgkVS0VGyBbvYKaP5iZoX0MFxZgIGIOg==
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
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/hisi_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 4307161533a7..bf283b8c216b 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -574,14 +574,12 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
-		ret = devm_request_threaded_irq(dev, ret, NULL,
-						hisi_thermal_alarm_irq_thread,
-						IRQF_ONESHOT, sensor->irq_name,
-						sensor);
-		if (ret < 0) {
-			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
+		ret = devm_request_threaded_irq_probe(dev, ret, NULL,
+						      hisi_thermal_alarm_irq_thread,
+						      IRQF_ONESHOT, sensor->irq_name,
+						      sensor, "alarm");
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = data->ops->enable_sensor(sensor);
 		if (ret) {
-- 
2.39.0


