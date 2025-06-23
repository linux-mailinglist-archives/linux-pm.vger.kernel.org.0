Return-Path: <linux-pm+bounces-29324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A6AE40F0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039003B442C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692F0248F45;
	Mon, 23 Jun 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FjYVJoUA"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013010.outbound.protection.outlook.com [52.101.127.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B324888D;
	Mon, 23 Jun 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682626; cv=fail; b=lBPsW5uQpCSjc9ElkqVVEXzeLiuzOaU/KP/5oOzaeoZp2hc/+/8zIwW20/Br4+99APG4o6Y9X7kjzPuBJdu1LD2xteiKoLVwgCXb1O0UVHf5hnLgoPm+kRM7nBph1nQ4jo9+la2q/vpk2b81tMMrf+7Ci3iMJN13A/IEEtVSraY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682626; c=relaxed/simple;
	bh=qv72uYWMjNnjUaDROC60KRs9nT8l2gVgXpP/GOyR0iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TXqJshaxKAozOhgauiQVhDzjy4TqHT5H+8ZyijEsDvZgQut55d3CtqD6+5K9y1mCaRNpvWXl2k+n9S5PR2iyLiSVoSQzAiS+TG0J5rZCWAU+KyXKAXMYUaDydV7vu4/Q7QzEiBPcPVWKNKwwJ/mW6Ffon959p4P13NA0QpA8mMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FjYVJoUA; arc=fail smtp.client-ip=52.101.127.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABc17AJJ00v2WsCqV3rPo1eLpO+Hx2vZFXNgncIGfpkm6RsC5h+Thu98dAbDG9sD78fMjuhxUEEA2T/iCC2dMhcAsyTDTdjHHZL3HHJtz+Z+4tQqaIOK0b8JdOBHGgZCx8OPHoMokcxiNAF0/6utDzuavlozu0Rl6aQCqcWB6X0sutJA7ogSSLuq9W1mUsgWWWg3ey/QD9xdaG5yeHgr6noS2pPWM7odCI+H1yz6aD6eWhBTPUjUC6H9x8PM/1N8bbDmhkAPWMNEmvYd+Pd/GczUq/tLoFSi4C4UiXWv9N8GYEXMHZFg6xjAI5Ki9/jzJzX1dN483BH97B03OTOsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m55j4/lBNEAJFpgAHXZuEtDyuLAH4bvJbs0juv3TjVc=;
 b=FnyYJ7TJl2css9CBA5M77HaWpCFXd7CpWYELY3RdIKAiSS3t+A0MdIv9Krt/gFik8ydX6pBlp6+rsuOmzdkx6Zn8w1Kj5H5wJpV76s2jQi+P86Cx6SFpHw1haXZiUPkdwryyEywMeXjSmK3WiB6FxCDEEzV/+WeGjsM0ahQstX8MoIE4nOk9sxxbUxqS73sE3xltQR/9ny5AR2wb9+Kp0WiH9LX6Hg3ze9w1GNJAdl9yERDUjXdwyvTMuVmifhmjeVk9kKwmCI94akQ1OSM8Z+cxKe6VHLSApFc5LjqnJfGiMkPPYzQ34+X08+qkEZsx/3l4h0m9IMKf0wqZMQMuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m55j4/lBNEAJFpgAHXZuEtDyuLAH4bvJbs0juv3TjVc=;
 b=FjYVJoUAg3EUwnxbd7nkN2YwBFEDzLMieoCvopBWI2PVAjY6LK7c8Vql1r+lx7wB9kyoRDprY2jrF39p43+aLuPqlkJv8kEtF8yysVgpykGAU7OeEYq0wDNzordyWyj9itTg3OOU6bd3dRXi22AsHwMz0j4Xw3NwEht5xsuLLOUIwiJ9wOsDkMTZ1qF4KHl50tsFQUgGInmBPHWy2rWQTnML8Bw2n+y89hFQ8YkS59Xqr5MejnjsV5YCTPC8mW6pXqrjFL3hC+0JBgS3SkHOx7+9XGHfz7HK7uQwlQMXjG74dPtqkW8InqEy8XpwRTTqSsParq46/KtW6r18L+pINg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SEZPR06MB6611.apcprd06.prod.outlook.com (2603:1096:101:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:43:42 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:43:42 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: frank.li@vivo.com,
	Pan Chuang <panchuang@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 24/24] thermal/drivers/airoha: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:43:29 +0800
Message-Id: <20250623124329.475147-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SEZPR06MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b2f066-59a7-433e-11f9-08ddb25395bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Smx4T1IzRkd0cjJWajdFKzUweFR4clk4ZnBZbW9HbTJZa3Q1SGI1Rk50RG5t?=
 =?utf-8?B?a3MwMzlvUk81cksyRTdway9QMytDSkZvd3o0VjBsOFZVSlY3RjV3cWQ0RnJD?=
 =?utf-8?B?bnVrQ2dFMFNEdFlFZm5meG1zWW9DWEtYdFRXMWgzZUhkQWRMQXBRSWQ0NzYv?=
 =?utf-8?B?VzlaSWNSdWJOeUlGNlJlcEY2SHVQQ3lWY3dPTllzNlovZ1VVS2RDUk9BTklI?=
 =?utf-8?B?akFMWWJwQnpVck81cEhXd09uMW5WWkJBYUdWZ0FDY0FLV0NCOGRqM1d2dGpJ?=
 =?utf-8?B?WjVrR05tQXVraEhSTUpFZDRFWkVPOFc4ZWFHQTlsSUxXUTJOTnJQL1ZMUjkr?=
 =?utf-8?B?NTJrZlB2aGJUZ3Zjb2xpY2RjR0VWRnE5SURpVmRQdm5tUVZGQVNHaHRFa0li?=
 =?utf-8?B?SmNBYmo5Z2xDckJjWk94MFlrMm1Za1VyQUVTMjZjM29nNWs0S0FTUnRWSkJl?=
 =?utf-8?B?YW9wNzBQdml0ZFVPb1MyTTJOOXFjaXorbTNpcHZCNVF6dXkzUUdDaDBERTdz?=
 =?utf-8?B?SCtUMWR3NkI4Wk5vY2hzSy83RVloejk4Y3kxV0tVcnV5RHBDcHlTVzN1NWJz?=
 =?utf-8?B?VXVFRm9lTXlSZndWbVdqMllISTZBUm5LVndNSitTTG10aXFKSFI3eE5USEE3?=
 =?utf-8?B?TkFoQkNIc3ZxQVBNM0xnM3RabFJZNmNiQzFyYmU2eWRpR1Z5OGxUYnErcS9z?=
 =?utf-8?B?R0pINEhOeWd6N0VRQTdzWisyVDFyNzdXWmoxZEpkRXFab3A2aU1zL0NCbU9R?=
 =?utf-8?B?MS9Hdm1MT213SHl6allxbWdtVDZnL2hsWFJxaGZvM0M5TXl0WDZUcjBYV0xF?=
 =?utf-8?B?bW1zWWg1QkNyOFpXelpuOFNYSmppRzJVdUZPWHA3VVZPcUNTUW5hYW5YRTdU?=
 =?utf-8?B?MXV1SStXTnVZN0doRUJxekk0VnI1UDBBRGt0bXFicDJ3dVBNeVpNaDE1VE1I?=
 =?utf-8?B?RkVjVHJpZHptb3dBSGM1NmtQa1d4eU5lemZpSjVGWDBrZ25ZUkwrTVU2VEc2?=
 =?utf-8?B?M1h3Snh5N1ZNN0RmRENlbFhBdWszUUJJREN2aTl0cVZsK2EvZlZhLzlzREVP?=
 =?utf-8?B?UlBNbi82aUNlVTY5cjZVTUVLOEU2TTh6SXVick9wL1V4bWI2cWw0d2Z3czN4?=
 =?utf-8?B?OUJlZTI3ZytmeHRQSE9yWUtVbHAyV3MwVytpbFprb3d4eHlqY1BxL0RYckZm?=
 =?utf-8?B?bXhGZFdRUXdaeGw0OCt0Mk5ZamhhUUhCb2VUSVgvVDZVTDR1Z0xRajQwdXpD?=
 =?utf-8?B?YW1qOCtqaHZ4U3N2TG42SVo4a24yeXVQTURpbWlZZTl0dDVyZHozdmtoUkw5?=
 =?utf-8?B?LzNwRmJJeTVoWVQ4U21ONUVYUGt5a3dtNGU0WU5vMjFyU0cvWTViUjF2NGN1?=
 =?utf-8?B?KzNrcHNaNHduc016WFlkWHE2NkxMN2hFQ2ErVGxKVXlGZ3BrQzRVWWxNV1I3?=
 =?utf-8?B?ckxlK3l6RmNSZ051cU43QzZkbjRLZU4vM2ZYcy93b0c4eURHd2dzaEZzTUs1?=
 =?utf-8?B?WUFNWDNGNDZ6dnd4bUViRzlmNWVPL0pPNytDNm1VTzVTRHdWUisxdGY1b2ly?=
 =?utf-8?B?U2NuQ2hXVGlLLzhNUjlwbmd0SWh2UWxTZERWL0JNeW13S0k5eVZYVEVmc1Bo?=
 =?utf-8?B?S2p6d1UvekxEQVlST3hlblhSYTZDdEdGSENnb2ZWbDE4RzJ2NFA1R0IyVm1K?=
 =?utf-8?B?QVNGMlNvZ1pIaU1yUzZQTGJ2TWJ2L2xkVThjK25RWlBzRlprZTByeUtnN0c5?=
 =?utf-8?B?dGJkTXA1ZWZsQUhmWGRVcjJDZDdOVnl1M3VpczRFL1dtYm1FSGFiR1RaRnVO?=
 =?utf-8?B?ald3K1FVSm94RlhsTTc0dEV6a0lDQXoyNEJLV0J4K1FwWXJWOGN6SkpQd0dF?=
 =?utf-8?B?ZUh5bDI2THkyakxEMVl1QXliWHNpNXFRWndVbHZpYlJKWXJvZlNjMlRCM2Fr?=
 =?utf-8?B?QlhES2FDdHBxekxGd3NIdXZNQUNpejBkMzBtazNlUnZCTkZEMWlJSnhnL3Bu?=
 =?utf-8?B?RVYxNW82eElRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXYwY2o1UVFmbkh2Z1F1NytKbzhsczJ6VXEzMDNlbE4yamg2VjJ4TWorb3N4?=
 =?utf-8?B?bXlqcVhFS0FNKzQzcjA0eDRIcFBreEtYSkpiZmpHaWhKU2Nud2lqbEo4TzVW?=
 =?utf-8?B?S3V2Rk9qOXJBYm9aMmlLbFlSSW92aWV2dG5QY05KeVlFYkRoRVRKZDhpUFlQ?=
 =?utf-8?B?d2QyL1Q4RHlDQTdWZGx2NTQ4c040eFMxaWw0M0FTRnpqWkZROHVVVWV3WmJL?=
 =?utf-8?B?cFBucXJTR2dKVDBUZlpIenVtYXdYNHR6cm5NbHpsVnRUend4QkpuSHJia1Jy?=
 =?utf-8?B?N3NaUmRVSXpYbXlESm93MFIyNlJBZ3M4ZHAwU2JtM2dHYXBiSmlza003dU9r?=
 =?utf-8?B?VFVwYUxBbFZkTGdwN1ovMzVMNmx1ZU5ya25iT2xFcSt2ZGU5Z09FdVd5YnFZ?=
 =?utf-8?B?bzVuVkJwN1p2ZXlESEw5bWRKYzAxbk14UVFmSEhES1F2cWpOd0lBNWVTeGxp?=
 =?utf-8?B?TndTQnV5YmI4eUZacDBjMkY1YTZ5SXoxbytaYUI3Ymxjd095SmRQQyt5NHBm?=
 =?utf-8?B?MnFKZXN6cmNjdlRHM3R5MnJQdXh3SlhzeHAyY2ZNWG1rK2pKQVRkV2xQWGlu?=
 =?utf-8?B?UE1BOGkxN1pjMjk2VU9oVVlRYWYvWHlKZkRsV29ybUZtUVNvckZqUGt4Z2Ur?=
 =?utf-8?B?R0xzZlUwM2NLRkRkeWR3dCtOZXlEdWw0TXhES1VSanBXOVZ1MitvRjluL0Ux?=
 =?utf-8?B?Z3J3UUovdElacEZ6T1JEaVpCcGtOSFlPR1phamdOSEJhS1EvTzlQRzVZVmRu?=
 =?utf-8?B?Skh3U2R2MERvSmNZdEJQZ01xalBhbmh2SEhZeitVSkI0SUFSYzA2azhEZXhx?=
 =?utf-8?B?d2t1c1Vad005TXRzYjR6cGN4UmFnVGJOMklMV2RyanBVODFzM3U5UHZBNjVU?=
 =?utf-8?B?eEJJbEV4ZXBCM05FNmNHK21kNkNrMkZLa2c1Y2gxMkZOSStqN2xsMHFMeStG?=
 =?utf-8?B?WU5zdUFIaFRNRjlIK3dqL24rcXY5NGNOak1CWjFNQ3JmaE1VdTlkVmhyRE9Z?=
 =?utf-8?B?Z0s3ZUMvdml3RkcyWW0rOThKNkhxcUJSaDBMSFRPZi84eHZSNFdyTzRCWkl3?=
 =?utf-8?B?bHRjM0sySnFtKzE1NUtVa0xaekRQNnVqMlZNa1A3dEptWlRrcGo3a2hpT3Ri?=
 =?utf-8?B?SWtOQ1BrMkozT1dyZ2owTXlHSVFPOUNCeitpd1NWLzZxeVIrd2J6Nkc3ZTVH?=
 =?utf-8?B?RC9iVUpjY0NlVnEwQUFGYjd1VGFydXJlY2hQZUc1aG9ESHRHb2dQTDhaNzhu?=
 =?utf-8?B?WlB4Uyszem1uUGl1ZG94MFlaTm1yeHZ2T1NyU0g1T0hmZE5JVFdHYWV4NW93?=
 =?utf-8?B?SVlSYkhjNzJneUtyREJmOG8rL3Z5c2k0MENjTDFScEYzMnB1aHJrRzZhWkFL?=
 =?utf-8?B?UnFFTHJEcE9aZWhldXp4Miswd0J1azVGa1hRbE9lQzB1dXpmalhidGc1TzUv?=
 =?utf-8?B?bklPQ3o1aFA5MFZZQkUyejlaR2lueVY3MUxWUndPc1diSTUvUmZlZ2VuNmJF?=
 =?utf-8?B?Y1YwbWpoVlFOczlpdHhMUkxWY2hRWjNKemxaM3pjNHhGanJrNHg3QTJiQnRs?=
 =?utf-8?B?MXNJY0lzbUo1dGZxWG9ocVdsWW5Db1J1S0FxRDNVTlNzZm9LMjBMZUJWc3hP?=
 =?utf-8?B?ZEZtSVJ5ZkJJT2ozcDBpTjJTSkVGS3VNRkthZXBKT0xhZnRlTE1YY3NQMjVY?=
 =?utf-8?B?VDhYTXdQbTZ2NW1jclVHdXZUQ3pkNUlITDF3Yy9kZjdNR0pxUkUwUGtUWGF0?=
 =?utf-8?B?ZytON05wL1ExbVRwZ29mNzVYdDBhZG1GYWpEWlprYUNVcTBYOS84TFVRV1dL?=
 =?utf-8?B?ZkNibUpjRC9lZEUvSXI4QzlMY1V5RktsR3F6OGpqTm1DaEZDcERIWXBteG9P?=
 =?utf-8?B?YmE0aEduL0lEZmdTNk11ZVdwdEc0WWxkMUlsdnlHWnptR0ZUNmdRNHBnTGtT?=
 =?utf-8?B?cUhvdTliM0dRdXYvMlAxLzAwemZoc0pIQVBtcGo0ZmMvdFNXUVMrNDZuakZm?=
 =?utf-8?B?UjY3RHY5dVcxRmNuZDFxcEpWWkdJN2x1eXVpYWdKSUh0Ync5Y2Q0aFVEaTJl?=
 =?utf-8?B?YXFGb08wNlFVN0JPRWxBQVpmNExZOU1UcllhMmc2RHZ4K1VSclkxUDh5OWhp?=
 =?utf-8?Q?a5oInbzTV1o+8boeA7mROPfl1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b2f066-59a7-433e-11f9-08ddb25395bb
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:43:42.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGtQ8GPa+MVyv35MgorhQzEWKWq6tGcA+C4R6w5HZblTYCzu5gHcLEakgbf67jV+gViWA0Fl4Oop8Gk1R30sTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6611

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
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/airoha_thermal.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88e5..6918043c8630 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -441,13 +441,11 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					airoha_thermal_irq, IRQF_ONESHOT,
-					pdev->name, priv);
-	if (ret) {
-		dev_err(dev, "Can't get interrupt working.\n");
+	ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+					      airoha_thermal_irq, IRQF_ONESHOT,
+					      pdev->name, priv, NULL);
+	if (ret)
 		return ret;
-	}
 
 	airoha_thermal_setup_monitor(priv);
 	airoha_thermal_setup_adc_val(dev, priv);
-- 
2.39.0


