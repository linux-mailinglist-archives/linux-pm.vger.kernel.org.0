Return-Path: <linux-pm+bounces-19787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FC9FD87E
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C34F7A0545
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641A026AD3;
	Sat, 28 Dec 2024 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G//0vpng"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD41805E;
	Sat, 28 Dec 2024 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348526; cv=fail; b=c7OzZU3kEXwDIrc3OfD8r7JnTicgYp5GrJ9thQ5wIUBc6jI6teeyRug6RsqxzaHywo2ciWm8ba1hyyp6/VhTE1FVjoObU48YTe5wzFYr1LKomClA0dEcbrq/9lVe4Pt5Rdyd0MgTpS/p+Nki2sdOMJ3GzTVJ6ad5Tpw2OO4x/wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348526; c=relaxed/simple;
	bh=rr4+NY79vHDTao21SuIwtmUb1wnSE8ucvghNGRhzc8o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kRsMxra/1QUDI6nb1C6Sm9ZaxWIpM8moXldQL8LyDbXJkNkUdddP+9g48zBYC1uPOKzYz2SLEiYsAPtvpHDTc1LO+GJXCpKWMF9WcGbmceznXotFMwqGvvoo9dyb+8oCV9B06hXm7a5W3XTHrHdij3T03Ss8GdSL4PIYnue/cgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=G//0vpng; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVpIBXKGDph7VANcYk4QJZCn4EzewIx7bvYcluc4SZR5svnbJ0byeNPfVc8L9XkqXmlMcYWuzf0/8wARB3oW2cZHpkwL3MYL6g3TsGloe+qFcV1PHpIG3CLqV3n5CRd5xIif53z3VyIR7DcnssS23ma8FwDifqIJVaa8xlV3JUXi0vk0p4ea7GrcXLoV+362g6FJAcjsfezHTEmwNZ2s4emGJ7M4sVEzGffZ+TB4yizfbAKPRtyLBRVC2jt++4yER9QeXh16X0x+L/it5fUF9Du8oofLo6BpzUBNezkEnw2vBxmzkP48/juiOvrr9mQ9LwshaRweIv4Z/CUon/A7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXYTp5BoecHg34e+obK9OingrwQWYhGlKmIRTdHjAGw=;
 b=A81C6fyc7AIg6W2VB5Vw2VbkwxT/TP+PuzuiH18mOJEeR4aHmcMpv9E18WxYob1Yfv+n3UUO+CUqoCLR2xtEVhAnX74Pqkbl7943MofP2Nsavh2wPcuMA80frFnCMhqEdeudC4P1u3ivSNyreD3uz3Xqvh/Dz3BVZxPfK+6+3TYjBS36UygZRwRo261CwcyJiChWgSaxLcKbUZngsRoEJaBHJbeJgc23U9QGEKMbZZtep7b/MR0xRfdPa5ttvbjt+C5kIa+adSXMcRbkAdsqQUv4Ph0/AKfXAttDK/DpWwfV5hbbAaT6Tmkv7DupfUgzr2K46WbhoYWp9blklWLkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXYTp5BoecHg34e+obK9OingrwQWYhGlKmIRTdHjAGw=;
 b=G//0vpngaurqRXrrBO8WtE6q50Gf80d3sz9sYm49MRZdJnU6xl8jFew+90FA3J/eKinN9+jsoZZlXXeHOY8aSG7RVYUdsWt4khMMnFk3aPi1uuoZjOHP6aK2xk6/NYW+x/MK/My23b9gDy2DEhys8LJHWofjNotD+kzjXqJp1ffMUi6htbEgpYFbTHVDOwuKscyJaj+EYRuMuJkOmV3cGbgKjsaFU/7VigC9cwdFgSfu0jb3PIOblh/01023p/CMQzr5afYJ16oOd5rTku+GGbvzJWBY7h/royKHBJBwcH6s3EhI947lqokEQaJV/v8iqrWlsmQu4mdrTRBECS4MTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:37 +0800
Subject: [PATCH 01/12] PM: sleep: wakeirq: Introduce device-managed variant
 of dev_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-1-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=2367;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1uWzLxz0ETkHUyA0IoSi0XaXoYut2vJxQmLJwOorGBk=;
 b=qSMQnYyGM9tDfzHYkMUGmXNyaUzaGa3+ti6BAH9c9FzUsXHbRHcqUk+iAcM38J1RjL8RaqoVX
 5f/l7EkwTGjALGnbsV+r7vQCvfEhAsFjc2BLLoZCeIs1xuYV04uru6q
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
X-MS-Office365-Filtering-Correlation-Id: 78ae5531-0393-418c-85f7-08dd26dd1779
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXcySDIvNUx4RXZRVGRoZ0ZwQk5RdlIxa2thSFoyU1VvWGdTT211QjAySEJL?=
 =?utf-8?B?eEl3cTJhTmpmbVBiRHRnSERWSEZWemQvK284WWhEVDJ1UXRFRUlDbFJQZW5i?=
 =?utf-8?B?MXRvOTIrU3NkdWpPMk1SNnUxT3BBd1BsRlFTUjBFRUg3eHNhczJaWnVqQlkr?=
 =?utf-8?B?ZWhZanJGQVVHSElWaXJNOWZ3U3A5NnBrOUJ6L1J5ZEQvNEQ2V0FjQTUvalZS?=
 =?utf-8?B?RDcxbzQ5dHArQVM0d3Naa1Q0cjJtNlhTeC8xNGxJbmx6QzhIc1NydVFsMVZK?=
 =?utf-8?B?ZCtGYi9zcXAxZFNlbTAycVhWZ0UreGZSTDBxOGdiRGEwOGtqc2NOV3hodGsx?=
 =?utf-8?B?SDF2U2haaDd2S1VUT29yRFhqdUVOL3h6ZVEwTnJmcm5mVzJnWFZ4MVpIVTNl?=
 =?utf-8?B?S1AwUGs5TEhUUGdPcVpveWtHcGNTaFc0SXNSYnZNRXAzcFN3UUIvWGJNRXhH?=
 =?utf-8?B?Y1VoWmt4djdtZTR0NVExbjBEUnduVUowYi9jdEpqcE1jSHA0QkpvUDYwbDkr?=
 =?utf-8?B?K0RyMUEzMXRid3MwbVIycENxbG5yWmdWY3NwQVpYR3FCR0dBbm50YXNoZ3Jh?=
 =?utf-8?B?aDBjWUF1STQ1cCtOemp2M2tud1VLTWMzVWM1YW56WjdKN3VLYmVPSHNwbDBr?=
 =?utf-8?B?U0M0RThZYzhXTytDeGhwMDluZ1Y1cHFrdlE1R1FEc0lxK1FHQ1lhNTBxSkpj?=
 =?utf-8?B?ZlFPRHdjQ1RRUXNnMXNNenk3TlFoUE9nU1Q3bm9vRmxYREh5K09uNFVVYUVh?=
 =?utf-8?B?Z0cwb3RtL24rUHNpY0lmV0trVklPNTJtdnhCVGh6UzFVNll0aEdzc3QyQXl5?=
 =?utf-8?B?SGlDNTlvaFJweTFCa1k3YkgrcG9FRFE4T0ViZ1ZSN2czZEIxVkNvd2JtUE5x?=
 =?utf-8?B?Q2dKNDRhVG1JaG9OODNqU0R0Myt4ZDFzcDBxVW8rak1XVGg1OUJSRm5ZZnJ4?=
 =?utf-8?B?Y0FWenc0TDJnOWwySFFPMEZ1WnhVMTBmZk0vSDZOVHdmaTRjVzN4YUNGWE1m?=
 =?utf-8?B?UldzMVR3N2hlZ3FZQy9VZ28yMmwxRnJldTByTHpKZ0JYSGVpY2xZSlVNY2NS?=
 =?utf-8?B?cGdDb3FXN0VuZGtISG1ncm5BL2xRRlRBQUNBdDNWSmtHbmZTWjZDVjdLcFhy?=
 =?utf-8?B?WjBkV25UbWVTUi9CalNaMUFRUnlwcGxtN245cG9JMGpkYk1RbWFIOWdvUVU3?=
 =?utf-8?B?QUI1bFV3akUxakNyWi9lMTJwNEN0MjdxMUExSksrUTFweThHQndHbXJaMHJI?=
 =?utf-8?B?YllOOTA0YkY5a0trZmRBQkQvWkt2N0c5TFhTWWd4MzExbjVpWWNuWmlrWFdY?=
 =?utf-8?B?TzZYVDA1blpaSVUxRTJVeGY0T1NOTDgvb0lLKzFqN0NpQlkvZHlNSWVEMmV1?=
 =?utf-8?B?SlFTUVdJQkI0K3J5K1ZGd2ZOQTVLQUNSMnUxWWVwUWhzM0diWHQwOTNhVkFS?=
 =?utf-8?B?cFZnVENheHRTM2pRc2NvS1d1UjVPOC8yYTdZcEtVRFUxNXFaUnc1akphSFY0?=
 =?utf-8?B?M0ZGZEFqeG5pR1FKcWJsRlJBUzJKM0NGMnlsck8zRkc5MktIS1V0M0wzSTFt?=
 =?utf-8?B?YnY2WWUyNElnc3ZUK1J6akxKMmxqUVE3bUZHSkt0d3Zxd2ViRjVncG9oOHE1?=
 =?utf-8?B?eERadXBpeko4eGdDTVhmU0JVL1QxU1ljR2ZUOFVtN2RnUVErUW0xWEdUd3lP?=
 =?utf-8?B?ck16eHE3YWdnbTJwS0IxS3BOWXRkZlNWRUlST2ZsdUVRNnhOQU9MbUFHY1Jy?=
 =?utf-8?B?a3ZZRTRvenhDa21NYU0wTW1ueDZuYVdKQWw2dU5ybHo2ajlzYVVSa29wS1JI?=
 =?utf-8?B?MzFtUGFieGl0cGM3dTNXZEFFSXNONURpWUtXSUJEREhpdHlsMGJUcXhsK2hr?=
 =?utf-8?B?TUxjaHE1R1ZIeVQrYnNWczhHT0lKWmZZNG9VQnErSy9tRmVEajJGa2taNlRH?=
 =?utf-8?B?WWx2clZvMGJGLzBVUUdZZXRRRjhBVzBSNUxoLzlTemR5enNTL1BlZitaYUdt?=
 =?utf-8?B?UTd5RGhvOWJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlpkNkl2T2YrcjkrREFvUUF2cVplQXlGQWo2aXkwUUljaEVQWllVU0xTaUI0?=
 =?utf-8?B?WnlNalQrcjZxejQwRWw0eFFZdXFKMTczUEV5ZHBpV0xGQkthQjdGMjV2UmhM?=
 =?utf-8?B?ZGlEeGpOUlNQWm1kajIzNTllV25UMld5YS9iR04xRXNuZTlobUhINE1WWUhX?=
 =?utf-8?B?TVh5bExEK3N5WUErSmw4N2c2Nzgwb1l2U3J4VVVTV1lKd3ozOWRDaGplQXBj?=
 =?utf-8?B?WHV5OUNMa1cyWnlRejR3K0NUR2VibVpFUVpOTnQrdmtXLzdmYjAxem5sc1NN?=
 =?utf-8?B?b2VKTWVUdXZTclo0WUdRQ1VYdnV5WTRadGYvdS9NVERiRDJYRm1YTCtIVWxF?=
 =?utf-8?B?Nmd2QkQ1UnA0dnlQbWVFRW9vZlZ2TFRyclZ0WVVnZnBmTEkwY3dCS3FnVWo5?=
 =?utf-8?B?NXRoQVJtVlBXYk8yUWpjeXJ5Ui9mYzdBUy9LaEZWUklUWFNNdEZtblZDUXg4?=
 =?utf-8?B?djBxbGZGUmZlYXFQZE5sWVNLeTJjbSsrdHlyL2xwdi9Qb1c5bzd4Tk5TZXFu?=
 =?utf-8?B?SGQ1NDBPY014MUN5OWkzSk5vQXNKNTByRnEvRUpJd1ZkRGtNZ0RNSEtxWGN0?=
 =?utf-8?B?ZFptU0hwY2MyY0JwbWtnby9zSkNORjdYNDZrMjBWbnVkdmswaE5ZOTJ4Yllw?=
 =?utf-8?B?L1YvS0pwQ1lnK0RRK1NIQUxlQlZzZ3E2d29vb2FlQWV1M21GWlBFa00vRzVG?=
 =?utf-8?B?L2hqQ3VPYUJxUmt1RHc2bnI0a01icFJiUUJSejJpNlFVL2w2R1ptQ294OXMr?=
 =?utf-8?B?NzU3ZmhJK3pnZGpMd1QyRUNNWVhYT2YyNzhUdnQ1ckx1Rks2cEhiaFpVQThN?=
 =?utf-8?B?S0owWU5UWDFndGxGS2JwWC82dTZvV0xLMVpuSThvSzFidk56d0M2d1Q1Qkwv?=
 =?utf-8?B?K0VBdFBmVHlOWE1uQXNFZ29lSDBDWGFsSE9sa2ZLREZVTzdEaUZKYWlDZ1FB?=
 =?utf-8?B?S1BjaEZOeXVJbXV0SkR2blBWZWtLSU5CQUlkTGJYbzNDVnlGMjVCTHQ5c254?=
 =?utf-8?B?M0lGRk9RbW5COXFoeCsrMjM5ZTJzMThxZ2hJWHR1RlNGRG1vZHhJVVo2dlpl?=
 =?utf-8?B?Wk9IYjNBVjdxMzBkVXV5VHJuSm1PejVldnR2UXZmTnViVXd2alVqYU9GRHFW?=
 =?utf-8?B?cE92Y3ZkNUo4ZnFCRG5DWFFNL3A3dzBwSE9KQWdldkpGRXJoNFJGSGNrRk1o?=
 =?utf-8?B?MTFlYXZDSlh1ZHZUeVFqc3ljRmRLSVpBbzJ1L1Q2eWxtNVZnbWlOV0t6azZW?=
 =?utf-8?B?UkVjNVFDeUFvMFNTQk5GR2ZWa09QRk8vM0wzMURhVWEzSTFtbk9hOGVCZHVU?=
 =?utf-8?B?WWRJdlZpRjlWVmJEeDd5cGJlbnBhb0lkamlscHpmN283NW5vM0xrS3VpeUNR?=
 =?utf-8?B?ZWNhb2xMSGluZWVkOU5ndGlld09TTjg0WWNFUE1rS2FKWTRVWDFzYUdJUTVV?=
 =?utf-8?B?aFJ5TW84SnkwTlNpZ0RMNUZzTTdwTXFsMGVjMDFIaGQzelk3RmFkRnY0ckx5?=
 =?utf-8?B?NFlmM0c5QUMrQUs5QmxYc3A2d29hbzZtUFBoR1RTTWhCdkxBUTRwUGo4SXNL?=
 =?utf-8?B?RElXSUZ1VEdvMDlRL1V1bmE1SFVNMXdRRGdoMDVqWkVzeFFRSUo3U00rZFoz?=
 =?utf-8?B?MGdGNGxmakJxWC9TRnlPSWlHWlB1Z2VEUjdnZGorZkc2a3ZsN3puaS9VUFNE?=
 =?utf-8?B?YlVPa25xZ2MzQnR3TmQ0dVRrdVEvc2NTN3d6Tm1sN01MWkgzNWdxVE5MK3li?=
 =?utf-8?B?eFh4My9NVVZ6UyszNWI3dVEwdkNkRzY3bThsVHFXYzNxNytPLytZZXY5aW5G?=
 =?utf-8?B?Z0hqaWtEZXJQcERvWlJGZGZkUC93U0JJNGpaaGEwOWhtdlVINzVmQU1URlRW?=
 =?utf-8?B?b2dYMTMwQzQwT3NKcjV2S0tEbkJuSHVsZDFWaDRiQlJYNVBiNkNTbGJEZTB2?=
 =?utf-8?B?UUx2VXpmWXd5SUplUHdMdUZKWnJXWExJenljb3RiSVJpdms4bVM1alNIc01x?=
 =?utf-8?B?ZG02YnNsNXBPOTdBeUxLL0hJUVdHL3N3SURCK0hrWDhmTXVSc01vdi9DeTdS?=
 =?utf-8?B?TERwTENGdUNtcjZXazVVdkkzQlNTb3NnMU5qRThtbWtaSGNacHhza3JKNkRR?=
 =?utf-8?Q?0WJEJX5VcbcyPjr/Ag/0jS+Tw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae5531-0393-418c-85f7-08dd26dd1779
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:18.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZpt2V3s6fjoSeNpK+N8ZCTOW9FTqpcYRuuV2IeIZSIS04XS3WUHC1McTJ1X3lhfLJFZTG8YJNo6dPCNO5MxPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Add device-managed variant of dev_pm_set_wake_irq which automatically
clear the wake irq on device destruction to simplify error handling
and resource management in drivers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/power/wakeirq.c | 25 +++++++++++++++++++++++++
 include/linux/pm_wakeirq.h   |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 5a5a9e978e85f3fc9d89cb7d43527dc1dd42a9b1..cdc445189f68479c54f85e84be09ae4f488df1b5 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -103,6 +103,31 @@ void dev_pm_clear_wake_irq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
 
+static void devm_pm_clear_wake_irq(void *dev)
+{
+	dev_pm_clear_wake_irq(dev);
+}
+
+/**
+ * devm_pm_set_wake_irq - device-managed variant of dev_pm_set_wake_irq
+ * @dev: Device entry
+ * @irq: Device IO interrupt
+ *
+ *
+ * Attach a device IO interrupt as a wake IRQ, same with dev_pm_set_wake_irq,
+ * but the device will be auto clear wake capability on driver detach.
+ */
+int devm_pm_set_wake_irq(struct device *dev, int irq)
+{
+	int ret;
+
+	ret = dev_pm_set_wake_irq(dev, irq);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pm_clear_wake_irq, dev);
+}
+
 /**
  * handle_threaded_wake_irq - Handler for dedicated wake-up interrupts
  * @irq: Device specific dedicated wake-up interrupt
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index d9642c6cf85211af603ce39e280a5b4de6617ee5..25b63ed51b765c2c6919f259668a12675330835e 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -10,6 +10,7 @@ extern int dev_pm_set_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
+extern int devm_pm_set_wake_irq(struct device *dev, int irq);
 
 #else	/* !CONFIG_PM */
 
@@ -32,5 +33,10 @@ static inline void dev_pm_clear_wake_irq(struct device *dev)
 {
 }
 
+static inline int devm_pm_set_wake_irq(struct device *dev, int irq)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_PM */
 #endif	/* _LINUX_PM_WAKEIRQ_H */

-- 
2.37.1


