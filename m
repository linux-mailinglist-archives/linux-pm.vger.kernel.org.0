Return-Path: <linux-pm+bounces-18869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C99EA173
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 22:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E052F282D2C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB3A19DF64;
	Mon,  9 Dec 2024 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cwVRATEp"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19D19D89B;
	Mon,  9 Dec 2024 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781213; cv=fail; b=VkTKlgyxV6Rf9Sg+yOuSHYl7YWQ4jxEVNCU/yRQAX+v89zH8Yz7R6PQSABdZuWlAXwU9Cu+IRBj3xPukFtlURwjHtZ6mtmIpVMohLL2Ts1bB//IURSMCliq+To0WRg7OsRYBSvDlu5t8IcKSsoBNexaaU+71KpV18ebB1jHjqtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781213; c=relaxed/simple;
	bh=r1D6YleI4pfbRMudJcC/mpaiq45dCNo3RsDTZ3TyLf8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MKOk5miT4kfW9zgahNcrbSmwRfBmpiKj+9Cr+p5Q4Z4A1AWci6kMNBr05LR5Azve8qa1oGA6VsxJxVgZjcQeBUZ0vtH6nbf7Afb4xFMTbkT/0qX80VlHgEPLRTI8oAEnS/4tOXJ2/ItWzx9Ja1sMwT2W2WTwk8Y1z8D09Oy/eyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cwVRATEp; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWSX7dqGC731GCKWw6m8VUFPh6CBoG/9YPtoDVqsp9ZCGmm3q4KuZS22sRqCquWTnpzZAnLyVN9NcoXyA/hN7QLCp/eCb+zvPRLW+VyOmOPum3Zhh7xnxIc9aqCQY8AwLr1jojIjJHVZR4iBuMk7aMj/mApL3RHsddj+cImtCAPZCFajVNdj9gt2EXMgYrncG/24qaL41pV8v9BW+i62RaRI8CmdjmOjHmb1nK3YdyGU+ikUVaPp7+0Q6cvJ7dEirRBkvQRSMokti7X56pnNPVEB0W0k9/7mKWULyzlO1B5C1/qSgXwn9dDxdAGLdPR9Hd5jrsjOPNDKrXTQ4dHBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UwDRaceH7GvnQ/QxRniWA3dsOW7A2WQ6w6+nm1UCs4=;
 b=suOON05AsPllKoNx8nhPu0aGIihaOA9mJzYgyDv86gba6MLhfMg5+bZQz/Xy4fJLgm4QQdYReRHTSxiMhv0EIZXalPUdV3hKrGP05dURCB6dFZhDuoSxoeuMt0xY11AZlngohfIeDjkKqjfOiEB+7rw84UtGtDmOLTT/sTaQfI5NrvuIqd6g1g9XxGoB2xLqJTFcbisooVLyuOhu0Y4TmMvPBPlGIlP1dom2chkM9/ZhWl7ohVEhTnDxZaDc5oZAIV9t6NyFDN4tf7hBm9BpVwwaurGojl2D/RgtosLW/q1c+HpQcooB9BscTcKMqzMYlAnBT+RCVRtBLczIQe1RoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UwDRaceH7GvnQ/QxRniWA3dsOW7A2WQ6w6+nm1UCs4=;
 b=cwVRATEpu7tNytxcn/CgG/KlcWIOOw3Lh4FAgxus4vs6veJHV3LyeimJyMJgKqEZ5VFPxzM6Z0zjN2yBIRaAeUAxf6YmVMxrk5EVdQu6xT3588l1cdpFmgnZSHVCi8Ld8gUSrZb66ma4O6GiVcqcY4w5PHXBcUCaTM62GY/fRih5iX+1pqam3/cCENcZJK7CnFW9ykyDt8fNVvuhF3EklP6YWJC698ukIt8POQvG5pmH2l6zY+CO3EQYgtP5m7K80JBZiEKPiR/XQ7W8QciD/6P0snxbByvcd05WAPobVmDecUlAFbVWqL2teann8TRacOxsw17HIor3Caw/ibG71Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 21:53:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 21:53:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 16:53:04 -0500
Subject: [PATCH 1/2] dt-bindings: thermal: fsl,imx91-tmu: add bindings for
 NXP i.MX91 thermal module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-imx91tmu-v1-1-7859c5387f31@nxp.com>
References: <20241209-imx91tmu-v1-0-7859c5387f31@nxp.com>
In-Reply-To: <20241209-imx91tmu-v1-0-7859c5387f31@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733781197; l=2218;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iVQTtCNDQDMEk1P8NXmCJ6s4gReJ2DPWuwpLblkVduE=;
 b=pkoOOhbdccrJsmUeD8dR0pITRa5/TbrLr5S24g2XYlWeEGQgIVAihdAPB+3Fd2YjcJ2PmQcLd
 ne0xpHWkXvxB8JCk5wKj+Q2B4RF+yANH85g3qL+bjLSA2Ge2RFZuYAJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d21bea3-4ec0-414d-f4ee-08dd189be910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnNZcVBudEQ3aHhBbTRPZVNndGI5U0E4VmtSZzgvcFVSNkx6MWEzblFSZTZm?=
 =?utf-8?B?VHAvSHJ3SzNWV2E3VEpyVU8xdmdSZWtIR1RKa3ZTN3puM3ZOZVRwQUpWL2ZH?=
 =?utf-8?B?Sll3SG5Sc1Zhb1puRlVUTURwY002Z2Q4WlhqZWtIVTVNL3Y2K3l0N01UMjNC?=
 =?utf-8?B?aG5qQXExdVBEZkVtaXlWTWhMS2wzV3FtSU1vRTRNWnlSeDNjWXZ0YjFUNXcy?=
 =?utf-8?B?NTRHNTY3YnZwWVZudmVBbWlBdHRYQUl4MnUvaDMxWmdyYWd3QTh0M0lXZGJP?=
 =?utf-8?B?Q2FURnB5Vno1dVRtTjZwc2hyK1Y4bTNHNG4xS2hOSDAzTU94Vkh1YUNTaUd5?=
 =?utf-8?B?NkxLZU01cFRRWHBuTE9mNEdhN2x3U2J0SERmR1BFT1d4MENZZHFwRDVtREFY?=
 =?utf-8?B?ODlVazB5WHZhUjVDRzJuaXNGZmdzS3MrMHZBOUF0ejVXY3oxVFVueGpKZGFw?=
 =?utf-8?B?cXlBVmFreWM0VEdCeVlBYUwxTjBrN1ZFNnhhd0JEbFZmZFBmKzhWenVzMlJL?=
 =?utf-8?B?b25MK0NGZE5OK0JpYzJYKzhhaGx2VUFVODNoVU9senhEMjRqaW9SRmIxTXRQ?=
 =?utf-8?B?YmVtWmNjcFlVcGl4M0dRQnNsL2x6RE1LRldjM0Y1Qmp1Rk9vUnI3bmY1b1I4?=
 =?utf-8?B?a051TllxQ0lJL2s5Si9PcFB1cWtjbmZiRVlKTUE1YnYzbXBBaU9TMm5ueEVT?=
 =?utf-8?B?UHZMT1ZvaW5qQngzOEQzUWNJeEFzUkJTZWtwZEl4MC9RUkI3SnFUQzNmU2Qw?=
 =?utf-8?B?WlJnaEhSV0FRWmsvRTFwL3Z1NkZYRGEycjdoNE1mcHJHcVhXbEtQSi9EUlJy?=
 =?utf-8?B?ZG83ZnUxbndGazJ2TTVjT0pkdXVlRyt2SWRTWTExYkowZFRXMFdUMlJ4eFFH?=
 =?utf-8?B?ODU5ek5YV3ZidHJQRmRtWlYrR2NwTGk4aEZ4NlZxRE9RQVRLNFRheXRDWFdJ?=
 =?utf-8?B?azYyRWRPZjhRNDM1L3dJemFuS29wcEFkbE1mQnhLeEJVT3p6RTFFczFoRUdJ?=
 =?utf-8?B?SU9LMThhNGZWMDY2OFgvQTlna0gyd1I4NUhBc2dBaXNLUGVWM3F3Qkx6ZzRs?=
 =?utf-8?B?OUxhUzNPL0dQOGNDeGw1Y25LTjg0RHY1YW8xV1RBOWtpUEF1WU5jYVhwWjNP?=
 =?utf-8?B?UTgySGdpbU1lVnBBVlpmT05sUXpYMmVhdmdXQjlocG1XdVBESFpUcmZXN0lw?=
 =?utf-8?B?dmNnZWRBZzJZNm5mTFg3VTlIL1VBZUwwamZ0Q0dDYkJ4eVlBQVZFeUQ2VmxS?=
 =?utf-8?B?clVhNGQwS05WSFY5bXoyS0tQQkZJNXQxQ3JiSXhCaGtEdklMaE8rUktPd2xH?=
 =?utf-8?B?TDlCcldVNng5V3NoS0tnME1JVmNoQVlEemcxK0hYRk9wcUhNV3Y2NzFub1dy?=
 =?utf-8?B?Zk1wT2d1SFJqblB6SUFLT3RnejI3MUl5NHBaYm5ta0VoL2ZYVGlzcnVwa0Z0?=
 =?utf-8?B?TVZwaDYxWlc5a1FCOW5maDJhWWhHaTgwYXRsMVV0eHJqK2YyZzVwaS9xVmUv?=
 =?utf-8?B?aDQzQnc2ZENxblBoakNTbUJKaERrdFZCSWt3ZlpvSFhrQVFHdFIwSmJBYnpx?=
 =?utf-8?B?ZE9HRzZaT2dXV2Q1SzBUQnJCYmhlNEFoVmZhUU4rZ1RtcXRmVis2UEg0amFz?=
 =?utf-8?B?Y1JvOWdXVzVMMzVKV2NrSzJnZFJqMDA1dVB4cEdaWmpzTW9KcXR0TmF5dUVz?=
 =?utf-8?B?SlQ3bGJJWVBlVzU1ZVd5RTVWZGIyS2F3OGhrQmV6cjRicTY5L3Z0QU12RHZO?=
 =?utf-8?B?UGVWS1FKQmx3TExqbmxsWGlOeUJtNnhoamkwdFdaMkYyMkZ2MFlxZ3lEaDlt?=
 =?utf-8?B?aVB4b3JNM3RJczBsdkh5bnc3N1NSeWcyK3lMSDZ1S3JlOXN3SFhsamxxTy9T?=
 =?utf-8?Q?G3InSyPvzsYQb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnJYNGY5d1NtMjRzWEpVa2FIMlVxcGJ2Wk5IL2RreDRQL0NPMTZSM0Vxb0Ry?=
 =?utf-8?B?Q2hUeFFJdG5ralBYb1JpWU0zNGRwcWplUTU0aWZaK2lFK0dpbzhUNnpwdkl6?=
 =?utf-8?B?cE1XMElJU2o5cGZKSGRaU284Mm1ISWdUT2dYUGJBTTA4byswWlpkck9KWVlD?=
 =?utf-8?B?TE5tZWVBaHRMaFBJcm1kZmJ2ZnlHa2prWDhQUHNwL3BaQ1B6TzNLN21qTjd1?=
 =?utf-8?B?RnQ4RC9hVkRsSEdORGpwVHB5czVDVmRkVHQxYVlOVGhYblF1RTFxdHhvcy9V?=
 =?utf-8?B?MHQ0UkdoRjY4VDl2b1MvOXRMblgzalZWYVJnTGN1eFVzZWZsSGVDeTh3Ukph?=
 =?utf-8?B?UDMxcXpYMUFMdDdURXBiK2FtbWh6UTBEd3U4d0FhbFNVdGs1Q3ZPSFlMSWIx?=
 =?utf-8?B?Vk4xTGx3amlGOXhhTENza3lJVEUycUFNU3ZudnJ0T3BjUnVSK3VQSlZtTDl6?=
 =?utf-8?B?VWp2RUI1SW1OK0IyMGZ5Z1ZQeFRkUUh5R1VpdkJPQnd1eWpLbGFnR0ZNaThy?=
 =?utf-8?B?WEYvU1NZU2h4YTlnRncwcHdmVll0b0l4OElmQUJLalVyRVlENWd1VHkyRytI?=
 =?utf-8?B?VGR4U1J5Y3RhMWNCQWR4YTJINFloMk02WXhZSlRWcjdwbjNHUVJWdGF5ZVR0?=
 =?utf-8?B?SFZpVFhrd2wrR2VmU2huS0c0aTlWbXhlZEhOZlp5aHMwUFQrc0JOSnhJZVVC?=
 =?utf-8?B?SUVYck15VTRNallkZnpzclh5b2ZuakdxMXJrUkk0MWQ1dFRaL0d4bnd1SVFD?=
 =?utf-8?B?NUVwUXQybTMwSllGbWZET1NoWm10cXB0L3IxM2VjRElMQ1NpUjA3U3NZVVRD?=
 =?utf-8?B?RlFSdHVheHR3ZjB4QjZBT3ZnZU82aUZxRnppZWh2ekxyWWRvY0gwN3R2bkNN?=
 =?utf-8?B?SXJzN0FqU0ovTDVwUDhrMU81Yk9YVjIwQ0wxU255M1dFSFBGaGx2Vm5zSHhn?=
 =?utf-8?B?cGFYdGpIKzNyMjBoNVhCcklpcUk3RkE1NGpBS3hvak9aN3hOaFN4c2g4RjZ1?=
 =?utf-8?B?S3ZjQkZTUnRDUzZLa1JJTEY1Tk96NE8zNnB5Y1pUSEZ3amNxd2YwVXM3eUlV?=
 =?utf-8?B?UXVwUWNBUWo1YmJlRlp5TWRLUm9TQ0lFQ2dlelZVTndSRDFpcFMzZ1d5My9j?=
 =?utf-8?B?VW1ORTJ6UGZzM2V4Nlp3L2RIOWRXOXIrRktUWGFIWUFjMklHTjZ4VlZjbDRZ?=
 =?utf-8?B?VFQxSlFkbGJLanNuUUxCemg3VDVNeTc4QTYzQ1ZiRzdCOCtmOFJBRjdjWXc3?=
 =?utf-8?B?b1Nvbm1LRnVWbkJVZDJFOHdGVG0xNzJJb3VwY2pqdG05Umo0RkpCVDgxQ1lB?=
 =?utf-8?B?b3YyRVFVUkk2RzFoWTlzZVRoNXplcDZPa3FydXZxU2lEUGhxWE44dzJNMzFh?=
 =?utf-8?B?VCtYTmwwOGJkUmFicm5obU1nMU9wME41M1Uvd0RzVThuYmJUTVR6RUlNZ25E?=
 =?utf-8?B?a1Q5bjgvcXdVN1YwdHZ0RzFFenJrQzhuVlZkd2VDRUxRNTU0WFBuTzlaVWNL?=
 =?utf-8?B?U0VpS2hlZ1VrSnJtazh5N0dpbGFRNUhoUUU1bThxOVlQSGpOd2hKNlp2Y2N3?=
 =?utf-8?B?c1JjRGx0MGlROUYxWkZUcEZwNVRIanhYS094V1pBTWhmN2k5c1VHREFFYkhJ?=
 =?utf-8?B?a0JwV2NXVDVxOEJwNlkzMHdWS05XOTRhTUFpQURyMzV4ckR6M3JpKzFIays2?=
 =?utf-8?B?TXN0cWhSaUxsZkJ5YitnN1ZQblBmL2RCck82TkRnY1h2V0ZWNGZ6TGxmcVpw?=
 =?utf-8?B?MFNUU3U5T3I5ZGRjT1hJME1NbW1KY1huNUtOa29NMjhwWko1QW9MWEV2ZkpU?=
 =?utf-8?B?ZmMxY2hHQ1k4LzJiL2tDaGJXRHFiVFF0WUxzZ0g2RWdUeFVpcURyc3VwQkxT?=
 =?utf-8?B?Q3M0TlpzdU5kQmFnQ1FNdVVlbkFkR1Npck02dFNhSG9FWmVQeFpWcFJjU3hJ?=
 =?utf-8?B?a25YQ2VFRnkzVS9HTll6Z0tuaENWYmdhaE9RSVd2R3ptVzJjRWNsUStvMkp1?=
 =?utf-8?B?eDlveGlCTXZvT0JtV2hwQ1M4YXFFYUErNHFvbWU3TzFNaHgybkFQOU93SHJS?=
 =?utf-8?B?ZlR3YUpjWkVDdk4zUTNCV2hkZjgrSHhrUVdpR0xkemF1YkNLZ3huQ0p0L0ps?=
 =?utf-8?Q?mf/w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d21bea3-4ec0-414d-f4ee-08dd189be910
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:53:26.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fNDkkren3mXRl9ueUifeVqPgiOyAOJR/sltFr7q2PmyCjGZSAL+JorhXbOFnqOFDhM2vgouf6oxfVZaFxm7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818

From: Pengfei Li <pengfei.li_1@nxp.com>

Add bindings documentation for i.MX91 thermal modules.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
new file mode 100644
index 0000000000000..f5898db1006c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,imx91-tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX91 Thermal
+
+maintainers:
+  - Pengfei Li <pengfei.li_1@nxp.com>
+
+description:
+  i.MX91 features a new temperature sensor. It includes programmable
+  temperature threshold comparators for both normal and privileged
+  accesses and allows a programmable measurement frequency for the
+  Periodic One-Shot Measurement mode. Additionally, it provides
+  status registers for indicating the end of measurement and threshold
+  violation events.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx91-tmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: Phandle to the trim control 1 provided by ocotp
+      - description: Phandle to the trim control 2 provided by ocotp
+
+  nvmem-cell-names:
+    items:
+      - const: trim1
+      - const: trim2
+
+  "#thermal-sensor-cells":
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    thermal-sensor@44482000 {
+        compatible = "fsl,imx91-tmu";
+        reg = <0x44482000 0x1000>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clk IMX93_CLK_TMC_GATE>;
+        nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+        nvmem-cell-names = "trim1", "trim2";
+    };
+
+...

-- 
2.34.1


