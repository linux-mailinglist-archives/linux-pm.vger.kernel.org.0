Return-Path: <linux-pm+bounces-31720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03899B17BE9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 06:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FBF1C269E1
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 04:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260A41F4E34;
	Fri,  1 Aug 2025 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B7RjqX7P"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166541EEA47;
	Fri,  1 Aug 2025 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022911; cv=fail; b=kP9oEuNlKW4e63nuDlOcrBKByV6p7g7qu1KwfjjOCEFBPx1B0sePBz7olfTiSXlo7XSAVJEDJwj4c0GblaaJ/aICM0CtY2nBv2atl/PCSujr+qtlxnvEKpygzXFXxoSUqQ8ZLl3B/XzpQmiiksTxdt5QwYpbfFXPRviPcVu90JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022911; c=relaxed/simple;
	bh=xp++JJRoAxX8jN5gPlb5hwg2gm/dy5GVIBpRvUzPZM0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SrtlkwZieAxhpTxg8Hn5JhBllscO16umsQ7YFLXGiUWb2X/y54vioq/ixcCkARZv9Lv0kCEdF72WUwmdDVQma3x+CS9iDFAMsS22sLv6UI1CgYxPiQe8Hwc426FWKBDGvTEKvRkBw/eRuACQ5TygE64nip94WyLwVIru3Ukt2r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B7RjqX7P; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1mbw+AhQbHTJ5pdnu6JSSSo1UzKWvdsEOzCSYK2jCO0fXO6b/gVn3YGW05ljdgwGhKHnA1JsXMFm2EnUyb0fqMmVfe/EE+fQ5IuSiCNHhtyhgSbxz2YDon+dPJ4J/2gHWRs3VI+a745/Zmyyr240tINTC6uy5Xr94oAq43KgkHMvMgyl55kmmsbPz3DTD9ofBBEecHyc2BxrjMfQt4ndhFh0c1yx2Q9TMs95TgWBZevS/v7kus1Fcm0AuDE+ZIF1qlvrdCYZtKZlPz5kJB08EpYKfAAEGSJicA5EOMe5ATHiVX3HaH2vLk5rNAFt1P/xJTx6yNl3ifqnpohKfg5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkb/QAZ5ffb6HpNPKm4tGtXWVn8/4l3Gi7oJRiokwa4=;
 b=hYFgrE0nwxF4zZJ4YJWELyigi0agt+mEmrkMY6Iq7fQ9U0Jvps1m/UEBaeY4ENxaSM6kNpVeJLZaMagcJiJQ3MAlJeHfZEAwT5YJYvJeL2p17yC1DhLxNNuwtxO3rEiTWDf1Hv0RGHNdCbItW/DqDXcXl9BDsQ4jjfaiZI5JcJJQ0inCWWa/2ALH21ZIUGwUdLzg02mhNHp6GmLjMP3/6ZMQykyFNTJnM+3k+iIsEcO/lekfBRq/UPNIj34BFhuYo6BTjm7gZysqOXeCLkj+T05dKHHLdaaf3fGan3DUaCVJxqEST4peNLKN8clLVt/S6mEKvMHmgdwLBI+D4spHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkb/QAZ5ffb6HpNPKm4tGtXWVn8/4l3Gi7oJRiokwa4=;
 b=B7RjqX7PsZyTEVKh8REDrIWog9tXPgqsp8OLuZQOIVf5CG/7GjNSwcQggxCwBU8T/6V6ALeizZAeEehz/OaqjuCRhRa1PmIkzKf+fbR4VfzK3qye8NR0hyeNKfQuknNqJACPnU5htfAaDehiabyjUKo1QHaJDusmYByC1MEFUS/pEkb+oZxqP70cdZ+sSnS8DjiTIPaR0gm9DGsSSMEQivU8MuUrqodetwvr0n10hrAOhMEbklQ0kK+OgKEzokick+f0l7L+yGk4KKHKMESf1TM6LPlmZ/1Ey9bLD0fobTZuuG6UppOxiUkpJk08124V/xRqJ9G/duRsCMblQ2I3og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10600.eurprd04.prod.outlook.com (2603:10a6:10:588::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 04:35:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 04:35:05 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 01 Aug 2025 12:34:24 +0800
Subject: [PATCH v2 3/3] usb: dwc3: imx8mp: Set out of band wakeup for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-pm-v2-3-97c8fb2a433c@nxp.com>
References: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
In-Reply-To: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754022883; l=1001;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xp++JJRoAxX8jN5gPlb5hwg2gm/dy5GVIBpRvUzPZM0=;
 b=1HC5Ld4j1zFHvdt6y668wcU6qmxwtdnRpM9m+EtcTIQ3FFtZNuZCeGOOD8XbaesDco9yVOkjc
 XnUm6swZ2AXCLs4qBWe2fuX1uO9qG1U+3YAyDrfYm4kUT5rsotqb6AA
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10600:EE_
X-MS-Office365-Filtering-Correlation-Id: 075d0ef6-17d1-40d1-ee94-08ddd0b4c9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhGbE45T0YzZ0xmYlpLUWl5REFMTERicS9aaS9XajY2M3pHcFRzU2RYOHFO?=
 =?utf-8?B?QTBlOTZRRHYxZGlGRUI1d1IrN0xLK1BGQ1JhTm55NzdHeGc5bGZ2THV6M2o4?=
 =?utf-8?B?WlE2QXIrbjgwOG83SldZLzdTeGpsNGsraGtNVThEWWxDQm92M0hneXN3K3g1?=
 =?utf-8?B?cUFTTUtqOHJUa2RFVEJ4clpTeDVaOWlneG95SG45TjNMaXBIcUx0WUg2alRI?=
 =?utf-8?B?UFlUTDZ0WEo0Tld2WWVPS1VyYXpwLzg0enVCMm9ZTURmOFFrbXgycjI1cUNH?=
 =?utf-8?B?SUVISU4wNlhCMHYvVlYxVzUvL1NtdFdhME5xMWhHOFZ6TGgydjk3RmN0Mm9K?=
 =?utf-8?B?U0JlakdQckx4bzV6enk1K1ZBQm5DRXA3VGNvQ0dhYnFCOHl5VmwwNHdFcUdp?=
 =?utf-8?B?ZmpncGNGNW1XQk9MQUIvcjl0eFRMQzArTUdtNVRnbkd5SjJISWVOZ1JRRUhN?=
 =?utf-8?B?NTFSUGgvY1k2QTl1UTRrdWl5d3haS3hSNFFVZzFrWUhLbFdwMHh0Wno4Mmky?=
 =?utf-8?B?M3J3ampoUEdSQldtcy9pay9jenBJSXdVVjFkL0VrUkp2UzRacFNaUDFCYWxt?=
 =?utf-8?B?dmM1R1JxOS9TdFRaSHFQZ3JSVTViNG96ajF2ZzFIaEV3T0tDMzJxd28zRWI2?=
 =?utf-8?B?TUhPRDlyY3FKODhhUXdLQ2hJakRMMFo2Q3BPSzRzM3VhZCtYbGNUVVEvclpF?=
 =?utf-8?B?MWZUOFMxa2N3M1J1MkpYMWlLSStpbjJzZmhhY2FlUWFtQVNsTVBvaWZ2YWlF?=
 =?utf-8?B?UGJLSENmT1haZHdXdEZkVDR1TTV1V2l6S1dJdkk2OE1JM2V6V0M2OWpUUGtO?=
 =?utf-8?B?SXR0R3VhdUJpRFhKVmV6ODBMT3ZTVVZzMEI1aTZUc1lHdmJwRUxWb1hFYVpW?=
 =?utf-8?B?N1IxbTNHTFZ5clY4Z0x2NlhBVGRvUDlDUFRJNHpGM2s1ZzUyZEdhejdDYlVS?=
 =?utf-8?B?UHNKMVc2LytCdDhCNngya1pNNk4xc1VoY0lXL2k4MWNQN0h4cUxKUzU0OVpp?=
 =?utf-8?B?MHZTaVJOQUpoalY1Z1ZLY1Zka1lFaGh2Zms4Rm40U0o1RndYUnlYWUdMSVZC?=
 =?utf-8?B?c1Bra0tuRXlmTkRTVjQ4QUJ6Tm9pMHFnVmZSWUxpK1dCSVR6L2JBRThYUjY3?=
 =?utf-8?B?TVhSaEVJUVd4NUxyQXhOK3dwY1VxS0F3T21ZRi9ScWwwTFVqNDdWNytTUHNX?=
 =?utf-8?B?NHFNUkZiK1FTOVdaZzdsYWJkbVNpclV6OFJZdmNnUTgwS2FMZFlYRzVRMWp3?=
 =?utf-8?B?cE1nQzA3UlR6RExKSDc5UlpKbXVsWHJwTG0wS1dINDVDd3JxSmtST29WdnhS?=
 =?utf-8?B?d3BxS2d3MEpROFhlK1h4Ym9HOFJUbmFUSjVtOHZFN3JodXZEZStjdTA5SURl?=
 =?utf-8?B?aFNKMHROQjh5NFFLQ0VsRUtVc3RDRURsQ3EvaHlFMEtncjdTUHpCRlFreVRq?=
 =?utf-8?B?cXJpVjhIQnRGRmpmaDZYYURzVHpCdVV0RTI0VWtHZExwMFRaZG9ocTQ4QlFj?=
 =?utf-8?B?bDNkSFlCSWt0bVJ1M2EyWGtVK0FVc1BhdUJzWDFaUWRZckI3Zmh4VG1paDlC?=
 =?utf-8?B?ZG5qYm4wTFZBV2JEa3hGeWpyOEhiczNNN3RqNG9lNDBUSGJGeXg5bGVoQjVP?=
 =?utf-8?B?Y1lTbWlwNkJWQlhEclErQ21QV0FseUhHeVk4WFlaNmw4ck9CbkJpMVZCaXJn?=
 =?utf-8?B?empBeXZSUzJrV2o0NzZWSVlYbEE4TGVzdU9HNGRnSHR3Rk9STHNwcjNVaEp3?=
 =?utf-8?B?SHdTeXdXWFgzYnJuVFExWGJGbmF2MFJzV0RCVGtSeWh3Ui9YZFZ3OHo5d0RF?=
 =?utf-8?B?Y3lFcStPMEdkMzd3aGQ5bEZZODZXanp2ME1CcDI3ZC9SWWdRWUUyczFBYThU?=
 =?utf-8?B?Z29TZmJQWjlLRGMyamFQQXhTcUc3emdyZ1QvaUd4elZ1dHV0S1F6YmZ3Y1ht?=
 =?utf-8?B?K3hWRW5HMDJQb1RuYkV1QzR0T3FDVmVWeFpER2ZWbkdWT2hnZHNObi8ySi8r?=
 =?utf-8?Q?kE9o/qbXNVx/AqEjcMSL0YviEhVD5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWtrN3ZhcHd4aDdzOThHMlQ1U00xQkcxamdPdk5GMkVBaEVkYW1GY2N4ZXlG?=
 =?utf-8?B?SmZsV3gzc0tCVS9EOElkcWJpMVlMaEJvUTZxeUdwT0lqU08xVmFTT0xXUGlT?=
 =?utf-8?B?anZZRDVkbWdWR1g2QkdkYmQwS2tkZkdGUWZXUldwak05ZjQzL00vNFBJdEJG?=
 =?utf-8?B?cHdMeU5Ra3k5VkxRb24rYjZFZXM5QndPTFdscHdTZTdqTVpEYnB2d015Q1Nz?=
 =?utf-8?B?ZHJRMUoyWFduaDhqOW5kNkc5R3owQ0ZTT1N2QXhsN1JSUUdrR3BGSENZL2lt?=
 =?utf-8?B?Ti9LOXV2TUIwb2pOdWVkUll2M0dMYVVPbmttUDlxclpsdWhtc3pLbGZQTU94?=
 =?utf-8?B?TUhkcWhqOFk1T3FSYzBpbmxvYjFpaGR3RVlMVzQ2dnlNRWVwT2t0cjBRaVIy?=
 =?utf-8?B?L3dOUjZlL3AyZWUzSzgzT3BKUXM4L1o2RncyRTArbnhpZkJ4RVY3QnBhTmtD?=
 =?utf-8?B?eGUvbmNIZWRwL3hybTNHVkRPd0hKbnIwZlgyLzdjbVhnZnZGYy9qTzJuU21C?=
 =?utf-8?B?MUs5U0JGYXlpKzJSRk9QaGFWc3p6YVBiUGNWbjV6cFo5aDRhd3VsRXhLZlA5?=
 =?utf-8?B?TE5wMi9LYnhXOTBYTXB4ai9mL2prWmVuNWt5OC9idTh2d0s4VFdNU1V2d2pm?=
 =?utf-8?B?aUJPT3BSWllYS25ibFBENWhVN3FDMUlzWklJWkRyRmh1akwrVm1ucmo2SEYr?=
 =?utf-8?B?NmZVdzJUMHRJeERDN1h4RUxtUVRPeXNtaERYZ0pZajhoOWdkTFNGbHhIZWg0?=
 =?utf-8?B?YVR6Wk8yY1dMWWNtZUI1ajJRWjZtRjA4N2tTRnQ4ZTU5MUtiWU5MZUdHSmwv?=
 =?utf-8?B?M3VOSHV3a1Y2SEJxejNpTTBEKzQzQXZyWnh5VnF3Vk9oTDJyQVlwYllPR2da?=
 =?utf-8?B?blVPU004ck8xdFRBWUtmQk5pYkxYeVJBaDB5ZS9TSUYwWkNOSDJjVWhXdmNO?=
 =?utf-8?B?dXk4aVI4U2U0dUV0SzNJckVFM0ZNcGpCanFoZEVpM3BFMjkxTEdjdDQyVG1k?=
 =?utf-8?B?UVpiYXhmR09Bd0o2RHoyM0NzSC92UWptV25qckw1ajRtZWd3KzNaL3dlWnhP?=
 =?utf-8?B?ekc3SG5tdXFaQVF6K3VOcG00TkFFOEZ4ZytKcDJYZ3lJMkc1SG9FQytEM1RS?=
 =?utf-8?B?SDFaYStTQ01MSmZyaS9EOFVzbXBmeGltQ0FBQUpQWVA0NDU4VHFFRzhzb01m?=
 =?utf-8?B?RWU4aGhicThQdzU1UjFOZ1pHbWFtMHV1ZG1vTjN4VjlrTVcyc21MNUtqdHZZ?=
 =?utf-8?B?YTJ6ZG5ESWhocU0rVG5DTVB0Nkcya1pudVBqczEyOWd5TWYzY291ejVDVS9J?=
 =?utf-8?B?bm9WMXlHMGlPbFAvK3pXTEwwaEEvT1lIeXY3R1hIT1NVeGl5My9hV3hxczI2?=
 =?utf-8?B?ci96eXdiY3JuVG1NZDN3VDF2cGtraVVPU2lQTkNKdUdYQkR1NGlRN3BxRVdn?=
 =?utf-8?B?OEFVT1MyalRxbHRxUnBmN29kTHBaRXQyZFJGTm8yQjh3cU0vNWxKb1RjOGox?=
 =?utf-8?B?U2s3MDNpOWs0Vy9iRFlJT1VhNmIwdXVJREk2MzU3Y1R5K05VRkVLMnkwSmgv?=
 =?utf-8?B?ZjZ1WGxqaGIrUDBmaVhKcERCdFhaUDVEMTNCc3Jkd2dwMmIwZ3c1QUE4WGlG?=
 =?utf-8?B?ejBCVEcvU0dXekFIT1hjRkNoUElkcE5UejVmSERvTG9Od1N2Z05POXdvZGor?=
 =?utf-8?B?RllHZzdBdnkvQmVFUWlUallYZ29Cc25RNWVEaVVHL2YvWkx1RHZIT2ZWMk9R?=
 =?utf-8?B?S2dkYlp4VlBpaEtiOFd6dXllN0FURGZlRWFkeUc3R3hZM2dhWEEzMDNMTUl5?=
 =?utf-8?B?ZWhPRGdPdzNCTFp0RlovVTErV3hUR0t6di9Ya0xScWcremR6ZUUxSFNFOVFm?=
 =?utf-8?B?NzBrNFRpVHB5L0dzV2Qya2VyVHZmdkpmdWZRb0dodU9GK3dQL3dhRjhjek5r?=
 =?utf-8?B?b0orWTFyRFRoTC9PMlFnd2RJQ0M3MGpsMDJGY3ZYMVhZRVgxZGtDV1R1V3ZP?=
 =?utf-8?B?R2xvME1aSTNkZEhOOWkvTE1BU1VMUDRXZVloOW5YSDZFcEQ2WkNsYjVxNFhT?=
 =?utf-8?B?YnB2Q3JRTXFtS1gwd3QvTXBsaDVHVWZMZFlvRXlPczV0OEpBQ1U2V1ZrK0k3?=
 =?utf-8?Q?s923WRHsyrKkSuOU/Na0WroYB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075d0ef6-17d1-40d1-ee94-08ddd0b4c9dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 04:35:05.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EhlDfd4u/dKls+ZrO3KibjykFemnEARKcU7PHYpjoyEhAOc0fT646krD5NW0SHkUu5lJpSo+X/vF8my2mPMcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10600

i.MX95 DWC3 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
power domain(Digital logic) is off. There is still always on logic
have the wakeup capability which is out band wakeup capbility.

So use device_set_out_band_wakeup for i.MX95 to make sure DWC3 could
wakeup system even if HSIOMIX power domain is in off state.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index bce6af82f54c24423c1e1fcc46913c8456b6f035..fde158d1f6e3d89d261ed3689a17d703878c7e37 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -248,6 +248,10 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 	}
 
 	device_set_wakeup_capable(dev, true);
+
+	if (device_is_compatible(dev, "fsl,imx95-dwc3"))
+		device_set_out_band_wakeup(dev, true);
+
 	pm_runtime_put(dev);
 
 	return 0;

-- 
2.37.1


