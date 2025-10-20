Return-Path: <linux-pm+bounces-36504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D00BF314D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 374E44E5CE6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0529BDB1;
	Mon, 20 Oct 2025 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n+9IvQrV"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4751DDC33;
	Mon, 20 Oct 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986867; cv=fail; b=uPJMno3O2wKxnk5rBI5JTMrFW8I87X25NY6YhT9y0N+uovunYpPV/lHSUYkyv+BQp23Eey+clS0ofevEJhtXJxjv9XWaDlKEqY9ipIgwbnZbF5lu9sAFhzNrdBb9lzzVEno7LIZ3W7OegxtdDXvju6i8eH9IAJ0oCzDmw2ZA2kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986867; c=relaxed/simple;
	bh=Ry6eiFw45ys61X8DJjRFKF8ArEpf1pzlL4lg2+fM14w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Tm0+7Jsj44LwhPV2EHr8F3ivwIi9bF1RS/Z8dKHFYAn88k/ZSFhVPTTnlQ3DrLJMUW0jBMHMFfifzP++pVFXQDJPfC8uLagwm6DSuqP1nLu1l612EB2gOWgtIc11F6X+y6O5C/Hjxns95SMB4Zl+R5sJjp0UB+Ddxugua73FAag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n+9IvQrV; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVlk6hfTIDSE2E1vLf+4CzsXdHAypsbGzQa8Qk9ElxZQZvJcYAFqERefy2C17Ngg9Lxsh7z6VwFivbmmgK6Uc49cl+XCUf0rK0jeckWrxP9bDOhgXHQWnGYkC31fjryhFIa01M4V2q+xdiiJwhBPIYbUka0TBUOR6lCiqw4UZfqek6OR3sMUvMZqdBQZAPJQ0vlVsPkqMV+h4i7k+NE8uKpCgZTcn8Hoag+dlzHx0bCf47KE55fcOmL0CDGfTvXrm2IaXQ1uwqzWGSfYK4/gH81PZvlp3GHMaDkRmdmGlV6XgfcmmLyYTkm7ttCyYjp39CdaMJIETxc5/w81NNpBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TnhFJNaMjTOca/wN3pjbnMVKuX5r74izB7CHK6C/1M=;
 b=bQfENYocpgBraVNwJL7hphXlIFdVmEoMoQWo8UQeQceg+XGt6ZsF7hjto2Sq4oQPTdp50gqmtAdtsMuxF0TkgUQCvAYdSTeeGBG+3uqfUQ4knGa+e7LE4ZuSsP6XEvAxR/iG8IraOMFmiQYt5/PRsPTqDtNWtCqwNJDmeVDwUfeo8V27YHEKY+RLOJQOU8jimzjaatLC+B4uo8OitjjWTkFZNVFFrlAt8Uj3kZLqgFV4Ww9dAmSTTOiBRQvQDZp1CFlMNFzNLDPYTeiyf5UQkUxj2bN9BCOq2SZkbinCN6dAMPT8Dcqo63SQorKb1avAw4fSeRh1oyTkw6STujNnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TnhFJNaMjTOca/wN3pjbnMVKuX5r74izB7CHK6C/1M=;
 b=n+9IvQrVPmYhymS+l28lGKtI53+lFiBmixuUfVXsFS03Svw7d9OhYiGmtgSFkmLxI/HQDdLuObEhrsIhorWiZwCAH8hs6j6mAJKFzrfqcFRKbrJK4b0+nSiPG/k2BuZJniUnrRx/x66P+DKY9KCuME8ieaSnn4nNLi1uUyOJEZ+qvnrMld3RzM8h5olGTrxSJfxtRAhG4pax2ZVsDpathSrGyrk4KOif+ZtnspaqpwjnmrHpv7usmd12DjCcGSDBcBkqf6UGzHNUXgyyfq+S6g32dN9th4w4PFiJVY8uZyzWNX79aFbXG01e1sLNe4Ir/SVC8PNRHwWWGWeFB/Q62A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PA4PR04MB7773.eurprd04.prod.outlook.com (2603:10a6:102:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:01:00 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 19:01:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 0/3] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Date: Mon, 20 Oct 2025 15:00:39 -0400
Message-Id: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANeG9mgC/23QTW7DIBAF4KtErEMFAwM4q94j6gLDOGHhH9mp5
 Sjy3QuRqmKpyzfie4PmxRaaEy3scnqxmda0pHHIwZ5PLNz9cCOeYs4MBGgJouGp3xr56L+578D
 bIDREF1l+Ps3Upe1ddf3K+Z6Wxzg/382rLNN/SlbJBbcOm4DK2U7Jz2GbPsLYs1KxQsWkqBhkh
 kKB91FH5+jIVM2gYiozh2TRtNBoZY9M18xUTJdPYvDUWe1k644MfxkKkK5iWJgJogVrrCJzZKZ
 m9UlMYfm6kFcFH/0f2/f9B59QbjmxAQAA
X-Change-ID: 20241209-imx91tmu-af2a7c042d8d
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, ye.li@nxp.com, joy.zou@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760986854; l=2643;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ry6eiFw45ys61X8DJjRFKF8ArEpf1pzlL4lg2+fM14w=;
 b=HSPakEZpgZBHZNRbkO+c8FfCPGAVqwSxkeiK5+y3hphSzDBEg3PEpYDJ5fBCDpQLnr7bmfCcM
 YroW2FUcHj4AidA9eVQUIDjmwfOUqhvYidHF0IuSlkrpzESint79KRq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PA4PR04MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc7baae-f1be-49c9-0e94-08de100b026e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cktGZHY0QTJON0kwRkJyVmRPaXo0d1AzMXYwRDEvaWRXemVZdXR4N0FmU0xV?=
 =?utf-8?B?cm5qZ24wRExWN2xDL1FCYWVZeXhldm9wK0xmZUNGcjd4OHFsL3pHd0c4REhD?=
 =?utf-8?B?Z1FmT1hqaFdiUTMzWWN2MU1zV1FXQmlySXM2Tk8yZzZEalQ2R0NsUEp0VnB4?=
 =?utf-8?B?K1oxSEJTS0dselRJSzlEVDRDNmQ2WlhGWCsvTkp2S1ZHdjRvUlZidHhnaDZG?=
 =?utf-8?B?c0pYcllhRmFVS1pHNmJubWxkaXI5bGVXQ25UM0pybG5jTGs4Y1pUNm1RVS96?=
 =?utf-8?B?TTF5WjE2MU8rT3VmaEpPV3ZHYWs4b2hPRlJPSFJMU0ZneGpWTWR1L1R1cG1w?=
 =?utf-8?B?Ukg0L3l5MlV5T0tJUWVoS3E0Nk90Yyt3R1VGZmtxcW8yckNZbHIzSUR5eGFP?=
 =?utf-8?B?R08rM3dIbnVQd3BSay9iM0tXenVCNmJLbUdrbFZQZE1Da2hNNHJQTWxsN282?=
 =?utf-8?B?alZJeHI4YmhjaStINHU1NTRVdnZSTzY2WGo3TXlMdHVlakdBc1gwaG11Vm83?=
 =?utf-8?B?b201NTVXL2tTdmZtV3RRV1VXWVJtcGt5MkRCTUdmNFMrR0dnVjA3V3dzeTZY?=
 =?utf-8?B?a3l6NncwQ00rM2VxN01rRXJnK245bmtSZXpxc2NTSVBQL3gvUVdrb0x3TFVk?=
 =?utf-8?B?Q2swQThOS1E2dTZEcDNWWmFQTjNQSit1R3FaQjFMaVg3M2RnbHlDQ2trM2ph?=
 =?utf-8?B?WHYrQUhYcG5JaFpaVTAvdUUxbVc4elFFbFU4Y1F2RlZnTUxjRDFJSFhzTHNt?=
 =?utf-8?B?WUR5aTl6YXJCV3N3RE5KV3NRcXpkMDZaMGpSM2tTQ2s4dGx6RWdtc21vdGQz?=
 =?utf-8?B?c3JLSjFFUUVoUjJmUjd5VHk0NTdwZ3EwenVCaDR3N09sd3FXSDF5UnNJVGI5?=
 =?utf-8?B?NnBYdXZyVjBRYlNDT0FpSFFGM0pvSWRlK0k1dDltTGRibWZOa3RTYmowVWtT?=
 =?utf-8?B?ejdLOU5NNGF3SEsweXRQbUFrcmpvRjdOaks5MGFvOWIxNTNVbzhpdnViOVFr?=
 =?utf-8?B?cHZGUG10QkFjRlZUOEU0TEZBcWRscWJFWFh4bnpaa2VZdktBMUtFSnlsaGND?=
 =?utf-8?B?dHR6ZXF4UGk5VnJKREkwOFY0dUFFM3V6RG51czZsMXhtNCtId2dHaW9SWFB4?=
 =?utf-8?B?Ym9WeWZXSmM2bGxGeUpzQ1MyRStKemt0dzMzT2NNd01SSWhzNk1VcTQrb2tn?=
 =?utf-8?B?TFkvQVNnZzVUaTF5N3BxQXFycjhLNFBEUE04ZVpLdEpFUFl0em5mZUthWFRC?=
 =?utf-8?B?Y3l0TzBJR0NqemxwUzZjK3BLQ05OZDB4NjV4cVdwSFJ5eE9vMmFRc3JvbDJQ?=
 =?utf-8?B?aXBIZXlSWmZFVk5kaVBBczFUR05YV3FoUUZwUjdQelo1QnZuTTlUUzUxY0Iz?=
 =?utf-8?B?NTB3Z1dvcXNFN0pkYndLYWdFaFlxMWlLc0tjcUo4SG1hRTB3RzdFTEJ6VitP?=
 =?utf-8?B?WFhaUnpJRVROcko4S0wyOW02b0E0NDZUZmF1QnpzdUZmUG1WVk1OU20yQkwv?=
 =?utf-8?B?MDhsQ0hBeGVCVENXVkZDSit5SFQ3SmNacWRIVXpoU0VOOFFnMGJ4bEdRK1U0?=
 =?utf-8?B?TjZsaDdIanJCdUVQV0x2WUxNME54RGMxQ1Z6Qng3OFpsRU1keWJ0ZFhLNXRq?=
 =?utf-8?B?OU1teE9ObldhR2JKUXhuOFI2SlZtbU9adzFpT3FBN2kzK3FZTDl0aGVMeitp?=
 =?utf-8?B?T2E0dk1Ea3d5NzUrZ0FETzZUcnAwbm1TSDk0RUh3cGhCc1I5a1o3M0p2am56?=
 =?utf-8?B?NVl4ZU54QVgzSUU5OHhaZ0hSbGZ6UTIydDkzUVg2Qko2M1V4R212RVY5Zndr?=
 =?utf-8?B?UkpMYlQ1aWFTdDBRUnpmN1l4TXpuZHd2Y1pMUnpmOHNnZ3U1ekFhV09iR1hk?=
 =?utf-8?B?UE9pTUpFK0VMeFQxd1lsSUQxNHdERVczeXplK1M3UG05SjhMeitUVVFLQkFB?=
 =?utf-8?B?SlZ1WTZVL04zbU5QdE1YMUNOcnoxOWFnc0VzVTF6Uk9veWRyWnk0RmFRdVlz?=
 =?utf-8?B?aU82Z0F6TW9JNTluYVMzSmF0dHRlZTZOR1Q4M1VHMkpQS0M3KzZHK1hMNzl4?=
 =?utf-8?B?SE9iODh3TlIyNEhOTzVEMDVUb2tKSjFvZ2IwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2xEL0xmVkxJdDBDZGNZRFg3V0JVVlFMdUg5NzhZMFR2eXd0K0JWaUdBejB5?=
 =?utf-8?B?K0lrQ3UyVEdRNUlMRkkveXJwQjJhM1JWVEFlM0FjcC9NS21JVHg3TTlKVFQ2?=
 =?utf-8?B?cHlZUTA2ZE5FQ0k1SG1WT1ZOQk1sVzB2R3N6enpWL1hwRkRRcHZBYlBmTDhS?=
 =?utf-8?B?akhqSFVzQlBGMUEzUVl4YmJodzZSMW1sT3RqbFRROFhNbmVJRGpXcUo3c0N5?=
 =?utf-8?B?bHFWOGE4eTJJWkZWY3ZrZXRSM1lUd3ZEa1JJdEZYTWY0VTBLalJVQzMvYnF5?=
 =?utf-8?B?OWpGMkwvRnZsRVh4TVJjQjQvT3J5Nk56VjljVC9LZ3RWczg4QldQWGxJd2NY?=
 =?utf-8?B?NGdMS0p4TnZlVmMwNUhMTnNyZTRnMVFpQU9wMWRiMnFFUTdIQUF3SG9uRnh1?=
 =?utf-8?B?Q1NYejV1U3NiRWxLVFdHbW11akRNU1krTTI3UHg5U0NUWnN3bXpKdFVOSkd6?=
 =?utf-8?B?Wmh1ek1wY2t0Ry81V25oWER0ZytBMDBESUxublNjdDY0NEJuY0Rzd2FyQTdC?=
 =?utf-8?B?M2FuNHdVL2JHUTJ2aC9MbTU1NmNhWm9neTh0TzA4U1h2RTl0NG9PamE0UU5H?=
 =?utf-8?B?WUpacCsvQlJVK0FxeXFVS0lBc0xXYkxLWUtUd0NYU0R5aStUWXhSNWkzcnQ4?=
 =?utf-8?B?MThwcWM5TlJPUUsyWFhDN2J4OU94U1FUMGFwaXpLV1BpUUVZNTdjeERWMDFm?=
 =?utf-8?B?TWNnZHNwQW90RGI5eUZLbTZqaGZ0dUsvR2VrdnFLMThGa1YwWmh4cjZQY2xK?=
 =?utf-8?B?cnpvSDcxWUJFL20xNjFQay9HZEswcmZzcmZKQisvSFFmWXJLSC9sR3lIQytp?=
 =?utf-8?B?N280b01jZXNjNE91Rk0vZ1ErSHFYbTFpV1Jud0p6YVN3RkFIenljaEcxbGRN?=
 =?utf-8?B?VEwxc3hDQnRIV0tHd2NTMjhMZlU5MW5TS3l5Q21ZUnlld3d4TFZiRzU2b2J5?=
 =?utf-8?B?UDh6UVVMSm1QNTdUayt1bFBuL2ppdkVPY21JM1N0dDE1R3ZiVGYwWWR5R1Az?=
 =?utf-8?B?dU1SVGx3WUwwd20zeHV0WDNuMFpZS1RtaytnVzlGeFFlNU9WOTFKSmMzMGFz?=
 =?utf-8?B?VmtzUFNsMC81MjF0ZjBvSjhkOGNURkFVYUVMNTY1azZiQVY5RGdCeFpNVjNt?=
 =?utf-8?B?UGVwdHoxTGNwYlVsUGpLakNJOGdQMXJuU3ZrdmFqTnpCOUM5Um1EL2lQdHRI?=
 =?utf-8?B?NnFCeEpZYk4yUUJyUDhHblZaZEt4Z0pUNHhsa3RnTWVEdzEvclZ0ait3VVdo?=
 =?utf-8?B?ek5ic2pGY29hdkh0bGZXSUM4VUc2bHh3d3JsMzBISjlyVXhnbnA3MTBFa1E3?=
 =?utf-8?B?M09WVU1TRmJ6WXNkWERiV0xxaXo4d2xCUDhZWEU4ZktSY2xBdzRYR1lSRm96?=
 =?utf-8?B?TVhYTjQ4UFZ0SmIvblhsMWxEM2J5RUNQZDF0WVJnOFVLV2IyUElsODBkeXdl?=
 =?utf-8?B?WEs4aVRrUVkxbnhnY2lwL3JZVGs0Q0QvSlFHOWtnd1lSSUljUlRuVXJrZEJu?=
 =?utf-8?B?aTllK0I2SmtWS1VNOUJCcWpOQnBLTWpZS3QyMDJIc1hLQnZRd3pzZWJBR2dN?=
 =?utf-8?B?WGRmVVVBWG1hKzVFRk8xWXM0YW0rMVdDcDh3eUU2L2dCSU1TUXJUWVpueG1R?=
 =?utf-8?B?aSt5YjRvMytMZEkzUlNWTGZES0g1SDFqSkIyNC9HU1Z1Z0grc0w5eFhqbWVL?=
 =?utf-8?B?RCs0VWJTdjluNWlkdXVRczFoSm80bHUwWHlGUmpscCtKaTBmVUoxd1dZaHE4?=
 =?utf-8?B?SUovejJJWnJsNVd6bHZLZG5oeFdGUFVFckJ1SGU4OGxwUWR6djE4c01Vd1Bs?=
 =?utf-8?B?WUI3am4vdm04UEtHdms0WTFkZTJhM1Q0azRmVnVwMURNZ2V5TzQ5WHJ6MUMr?=
 =?utf-8?B?U0JjR0VybmpOM2U2WUh5c2Jram83QVBzNUludnlTSzNScDI4T2haUUkxZjRy?=
 =?utf-8?B?T0FUOFdxZklNNFo1Q3N5L1dLTmt2QWFBS1N2bExhQWlMNFZhaFU5TTB3ck9G?=
 =?utf-8?B?ckd0MkdtVzNFck1BV090UjNxdmVqM1AwdUxjaS91aVVlZERLaWhkSWJ0R0dy?=
 =?utf-8?B?NFRpcE5GZmpWVXFhcUlNLytsVmhFZHZBY3ljcnVLR0ErcG0wWDVTY2t2elZm?=
 =?utf-8?Q?cQQk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc7baae-f1be-49c9-0e94-08de100b026e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:01:00.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joBRyF8y4APEXxK9KanrQsDySKptzYDx3pYWPXGMmjg7mIy+WVUeylnxC8tFb9/82U5B8Rqh3WqiCi1Up0Uwrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7773

- Add binding doc
- Add imx91 thermal driver

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7:
- Add dts change
- rework irq handle (see change logs in patch2)
- Link to v6: https://lore.kernel.org/r/20250219-imx91tmu-v6-0-7af2281bcada@nxp.com

Changes in v6:
- use set_trips
- remove mutex
- Link to v5: https://lore.kernel.org/r/20250218-imx91tmu-v5-0-76c0b27673e6@nxp.com

Changes in v5:
- Add irq support.
- change to period mode.
- Link to v4: https://lore.kernel.org/r/20241216-imx91tmu-v4-0-75caef7481b8@nxp.com

Changes in v4:
- Add Kryz's review tag for binding
- Add Marco's review tag for driver
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()
- Link to v3: https://lore.kernel.org/r/20241212-imx91tmu-v3-0-85e756b29437@nxp.com

Changes in v3:
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties

- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
  uboot may change and enable tmu.

- Link to v2: https://lore.kernel.org/r/20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com

Changes in v2:
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
- Link to v1: https://lore.kernel.org/r/20241209-imx91tmu-v1-0-7859c5387f31@nxp.com

---
Frank Li (1):
      arm64: dts: imx91: Add thermal-sensor and thermal-zone support

Pengfei Li (2):
      dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 thermal module
      thermal: imx91: Add support for i.MX91 thermal monitoring unit

 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  87 +++++
 arch/arm64/boot/dts/freescale/imx91.dtsi           |  58 ++++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx91_thermal.c                    | 384 +++++++++++++++++++++
 5 files changed, 540 insertions(+)
---
base-commit: 2433b84761658ef123ae683508bc461b07c5b0f0
change-id: 20241209-imx91tmu-af2a7c042d8d

Best regards,
--
Frank Li <Frank.Li@nxp.com>


