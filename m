Return-Path: <linux-pm+bounces-31947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF0B1B02B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 10:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF7A17A7C4
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DA7253F11;
	Tue,  5 Aug 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iOLVMBrQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011029.outbound.protection.outlook.com [40.107.74.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B221C167;
	Tue,  5 Aug 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382476; cv=fail; b=ugqWUlMHVY6rtDf4y65YkGlFfiLAWt3b61QsW6CN+ZpuyUbZHjKQYbU1fU7xS8PsbcyuQX2xU8JTrCOCnENXEamdUsvRxm+zeburrC7saJlNGJzCkiU1LNToXAtwRp0fGYY2wwmP14f7K29CWDlmoscrZFycDb5iFJGujukVYXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382476; c=relaxed/simple;
	bh=alX4Qxn4rf13WTiExJFUiNHo3/xUUfSui9RyY2zfwAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nn9441WLfeF5noB+iDeiKdSVltTTYEE/M5bMoz4Y90sCtShRshKfzYwmtdIcjBoWOOsh+HSTitOKXH32dddc9C2kMyQKevUjy9rv/ltA7HTnJW/51u+cnG5mf7DVTrTeNW2EsQggdNbxApT5Id+3uLvKFfCZceKESt1neAZvheQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iOLVMBrQ; arc=fail smtp.client-ip=40.107.74.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfTc/Go5+1g650Dg4znc82gzK8RGFm3lbef2xuHOOBRAXPil4aQugH//NmeCUNO7HC/yflBLWxb/c3P22r3C7iBm5RIDCwbW8juKJ9Hisv6Wz1xSE0AGDmENvV8LIuKTI+hEGffpmRJ4sKrvGu37OIweeLFD0AOkZ2bGNRvfkeXMPOZcIpPijePZS5PsU18L7wloLkGU3uFWfYhQwhEXTsFMPsWMEjHtrBCBWHwabYgro06qSGiIlCn0MNqh9QCks6hql3nkUqdhxfogjRaw/KTQGy0/Uz75vc5Zbd//TjxnWzFEO933pLgXXg8n7Ye0M9Xp/ceRlKpDeMLTFcZWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alX4Qxn4rf13WTiExJFUiNHo3/xUUfSui9RyY2zfwAw=;
 b=GS+nFGuWFEkIPbZWHZdCnLgqO2k8jBWu4Ux2sClzPqu6xPz83FubB/S7XDEWOqhH5EIMRC0NKYtQ8Gsn6R/ONrh44mKJE9gPLMhMNlnPhAwAX0DFfkNT4PffrEYBIt5Rb1hCSEvu/cUfsWoIQYBLlDjREn1CrBliOHiE0WBaNpLLQGYbcrqwdgQzmMUUqLVd4gXBpuVU03EmEkKHH+EVlCYvLyIay8lgiyrMrlF9ZQLSIN7Isx9b8gFIpRG4r/aizXv0sbUf/dtZ+cWIi78PkxS/69XJEQ0gRBmLBBGCvXqgbJ2sKgYpHupSDKGRh6OEMb5Kk34o47MUIPLiqPhVjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alX4Qxn4rf13WTiExJFUiNHo3/xUUfSui9RyY2zfwAw=;
 b=iOLVMBrQl6M/yydOJL0anHmRJ+BQwL/gCZcczRST0JaS25c1ixzl4qYsxOb9WJnb3ablnLJISVjIoQ5z2KrCcYfd+NtUSlkX9cTzOIqwtS8FKcyNcfIVjfLkfuZHbj2cyeTdTgsD+93FZLb0Ld+MM076zuZdVVmX1KaUMs3jHcU=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by OS7PR01MB11882.jpnprd01.prod.outlook.com (2603:1096:604:23a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 08:27:49 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:27:49 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, magnus.damm <magnus.damm@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	"niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>
Subject: RE: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Topic: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Thread-Index: AQHby0ai9SCDgo20z0y3b2QkXuPFT7RSraWAgAGApSA=
Date: Tue, 5 Aug 2025 08:27:49 +0000
Message-ID:
 <OSCPR01MB146471D101C6D66C1B81336A1FF22A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
 <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
 <CAMuHMdW0CTM+d-N0FgP=dKoSTdmRr2Rpg2Rtzj33gDk8qW+FUw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdW0CTM+d-N0FgP=dKoSTdmRr2Rpg2Rtzj33gDk8qW+FUw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|OS7PR01MB11882:EE_
x-ms-office365-filtering-correlation-id: e4f0b523-9a2d-4b00-6591-08ddd3f9f6a9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGJzc2pBRUF3QW1wOTRpN2VsQUZLMVRscHdrRGxRQ1ZjNkJpc1ZtdFlpK3lT?=
 =?utf-8?B?Q1c0M0Q5VjhUYTlhd25SMzFzb1p5Ny91WlZ5MUJYeTBJTnYxL3V2TWppYTZM?=
 =?utf-8?B?Z1N2djFvL3IvTEhSM3U3NHB4eGhYVmlkNkZMdTcxVGxnL09GNkdBZDdZNGJy?=
 =?utf-8?B?MmV0Yk1tb2FOQWhjVnVGWEt6L2huWGZIM2JQWnlPVnd1bjZnWFVPd1dwQWg2?=
 =?utf-8?B?YjlKNk95dEIxVGpqK1B4WjY0UmY5VkJyRWJ1ZTdyRlMxVE1jQm5VcVpqMWhX?=
 =?utf-8?B?V1VtNFNob2g0Yis0OU1PM3BsbENlQnozVDFSLy9zMkJRTHNzNEwvaEpTZmJ5?=
 =?utf-8?B?V1d3MUNpYXlkQ2VubWJXVGYyeXU1eFl4NTQyVDNmZWlKSDlwOEtEbk4wS2Rv?=
 =?utf-8?B?U3FWRGhNbEpCMFI1b1BUYnRnWlJReHYvSUJpYU1oN3lOa1JiOGh0MTc3RkRm?=
 =?utf-8?B?WE1lMFpNVElRRXZxeVpqTFBaWHJ4N01uSGhUdVlGL1dFSHhldHJPaWZVZC9F?=
 =?utf-8?B?ajY0VkVMaStFOGFYNFA1alM1VVlSdkJ4ZW9lVjJJc25vU1VlOTRJL3IxRnhY?=
 =?utf-8?B?N09TV1V0VlJta3JlZ0JFRXZFVkhrdEM1cXlwaDcvdnYxM1B5WENkMGlQcTMx?=
 =?utf-8?B?aWlYRS8vb1FUR1N0TXdSbS9paXdsclpvaERBVldGeU83bURJMUxYL2lpLzhk?=
 =?utf-8?B?dmhuUWlDT2FQV0JXbXVpZ1pJYVBEK25WdEpGUW80MmcrMmc4R2FSSG04UTJI?=
 =?utf-8?B?d0d6U1ZPVGtUd2QwUGcxdERvTDZSUGNOM3hrMHNtNmxBMU91M1hhS1ljSDZr?=
 =?utf-8?B?TVpXYnNHZmZiV2taK1d5VzNaN3I0OHVEeE5GK0EzNVg5d0ZQL1VrWTBnRVdX?=
 =?utf-8?B?d1N3RUl3SU1qamQ2L3ZZWEJKUHlBczJCSS83ekd0RW1XTjFGZ3BMVGdHcXRh?=
 =?utf-8?B?YXBYRkhqSGp3bnozOHVBa1pLNEpMZHBCbldCL1NpckE4MTI1enp1am14T2ly?=
 =?utf-8?B?RW5qYlJGcG91MFZRQW42TURnL1I4ME4rM21iYTNNZk93T3Axazk3OTRqb0xn?=
 =?utf-8?B?NVVWK3JkSnVlejNtaUd4VVlvWUJpNUhZdjRiRi9mc2Q2ZGpYNzZkN1pJNUg3?=
 =?utf-8?B?OHRRQjJ6ZkI4S2RQdnAvY1pxeW1QZG9IMFZiYXRXUEpDRmhWZEZudVYrSUow?=
 =?utf-8?B?aUxtdVdrM1NiSGFVSldZRUJYTlhhelhNdXNYbUpWSUQzQmo5OHhCNTl0SDQx?=
 =?utf-8?B?QVpQL094TFFPMzVTWndERmNvdTJXN1dOZ0VRRTB3MFdRNVUvQncyMDdycFNQ?=
 =?utf-8?B?SWo0bGhhMzZzK1k1c1BHTkRLRm9zNFpaU2FyVXd0dFgwZTRKaG9PWjNxNnEr?=
 =?utf-8?B?TW0xQ0MwNytya3N5a3RnR1phRktmMkUwTnRBMFhzWHkxbktsNU1hZmIvU0tk?=
 =?utf-8?B?Tys1MmxpRmlVWWxockR6VnNlVUpvMjJaeVVlL1hiOEZkd0RPbDR5WExYdGlJ?=
 =?utf-8?B?dUtIbnlrM29kMmZidTRCV2xCQSt2cnJLZG1vWVBRMGZ2Uk5zMndXY2ZxRUk2?=
 =?utf-8?B?NEVSWW9YSHQwZ0Z2Nk5Ibk8va2x4elFHOXlKdk8wMW1WdHl4Vy8yUmdlai8v?=
 =?utf-8?B?bDMwNGhUb1lOMlJ5MWl6cGlpNkN1ZEtzemJEbTJuTGloN21EWWdIMVBGZ1E2?=
 =?utf-8?B?Y0N6Z2hzdHZZU1ZBeTNYVnJSRUcvQ2tDc2FLclB5cUdLbUlyeS81OXI0K0w1?=
 =?utf-8?B?SDB4T1lZait1MGpUMkVDQmh1QmhFTVNlYTNDVlhxMUxPWDlEWDY5QTg1Z1dq?=
 =?utf-8?B?VmhXaVdXbzdtYVRsa0RtM3lYOUxhbWFWMjZqNzJRMTYvMER5VDVjRzF2YXlt?=
 =?utf-8?B?LzB6SFVTT3JEM3ZpNjBzNnQzZEd6M0N5dytyR1YrTHBVWTcrUjF4SU9TODRU?=
 =?utf-8?B?eklCdktPczczc0tFY01aeStFNi9yOXpzZk8yakhSTDhzeVdPWmFSY1lHMWFU?=
 =?utf-8?Q?a1AqgaaHMAdiXeYPrL7NLvJ64FtFPc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVpBbDl3Q09UTnZJUnZOeFoyajdSNjRhbjJsWGRyVzJ2SjIzY1ZWbjFzS0pq?=
 =?utf-8?B?KzdBRTBZWWdMclJjNWhJcUhtZ2NCTWZPRzBrZzBJZDY1RVdscFlQcFJkeVFv?=
 =?utf-8?B?ZTZ1a2xNMXlPMTBqRmpONElybVpaQUhERnpxMHBHclpNMWlQYTBzemVldk5E?=
 =?utf-8?B?Nzd1dHdBT2RmQWIycTF5cFVhUC95MjB0NC90N2FDUmNiTmpMUWNDQlFvS2Qx?=
 =?utf-8?B?VXpKb1R3MVJOQVNYQVUvWE5ESndUVVdCSzR5eGJaMEdXUlBFa29TMWJBZjdt?=
 =?utf-8?B?dDBrK05WTTBmdnFDSUQ2N0dESEMzdVl4VUo3R1gvT2k0Wmt3WXRwTkpEaDEw?=
 =?utf-8?B?R052ZVAxMzFuam5iVUFkdEVwaGVNWVdDeER1bGhQanlzVXhFTzg3SDdsU3Bu?=
 =?utf-8?B?b1ljazNYOTFQTW5VVGsreTVhcUZwTXJGdzhlSVAvSVE2eHFGN0xLbVZjKzhS?=
 =?utf-8?B?V3Ftd0dNN1JKT3J6eW04RlpkSE5VYU5XZ21icTFRVTdweFlIZmxSeXEwdlBV?=
 =?utf-8?B?bHZpcHlQbGluUEgrQlIxNHZrQXg3R09hZGFDMU1FVkdtNFo5MWdwREhjS0pP?=
 =?utf-8?B?M3RBOFFGL2VrNitJOVdpRThJNUlSNFB1cTQwMWxTOGNBbEdISyt5SXN4TFRC?=
 =?utf-8?B?eGlNeTFpY0JBT296cWxIU25mdzBqV2xGS0FOZWUrQVdpU2pFeEZRTEhqMVhX?=
 =?utf-8?B?d1FrNk5NMTBNMHhHcDNWcDVCOGkrdTB2aUZqbm5SVnQ5NlJYQ2xsWTIvV0F3?=
 =?utf-8?B?ZXZYUHV5NXJGYzV5bElPTlZVMUw4Z1diSjFnVXNuZEFYeVgrd0s4QUdTNTRN?=
 =?utf-8?B?T2s0Y21PMXVpU29FNTdDSE5YSjBab0YxWExWQWJhck5WaFRMTEVkTUNUTThE?=
 =?utf-8?B?Sjd1L2czMy9Mdit2UWcyL25WNW16Vk9PMi8za2t5MmZQQVRHMVQwTnJsV0lx?=
 =?utf-8?B?cHV5VUtiRU5TS2xPWTFyZUFTeHNxbUVzTmZEblBFZG15KzFnN2RlbDRQelR5?=
 =?utf-8?B?NHFiazBSNnhyNC9vOHVuR0RhZE8wUmw3UHdrUDA1Vm1waVVzN1luR25DQUVF?=
 =?utf-8?B?bkhqMlNSMDdSa1lKQ1c0MmgxREdtdkhRb2ZPaERJNGlKbGdMbmRGOG0xaFdv?=
 =?utf-8?B?VUh6YjhFME9xbDFJVjhXbkY3UFRQUzdPYVlnY3VPelcvVWp4VFNOT3FiQWFL?=
 =?utf-8?B?ajBBSi9KOUM2UkFKKzQvYUVIUFZBd0drQjJ2ZVI2TkdId0V5NUl4b3VoUjVt?=
 =?utf-8?B?ank0T2pqSXpJd0E1SXR0RGlReEIxUEU4U01rSUtYaEhRVHZCSHFHT3F3SWNL?=
 =?utf-8?B?aXYzdFA0eVNudURVeUpjN3VIaVV4cE5MR2F5bnFEWFgwK01rb0pBMkNyQUJ5?=
 =?utf-8?B?MHk3K25tMmpld29DZDlrYXIwWW5qM3M4ZjBERGZxNks5V0diSi8yM01QZDZ2?=
 =?utf-8?B?dnVscDJPZU1qTS80UEJocS9vZDM4TkJOMDNDK21QYUU2NEJZQ2tUTlpWMllr?=
 =?utf-8?B?SkFTcmNyUllCL2NzMEt5cWhGUU1oUStRenR6dVFMdTA4ZEcrTzcvRWZ0Vklq?=
 =?utf-8?B?UFp3c0tCZXVOL1ZUNHhnRFBzS0hYbEczWmVvUU9sc2xNdHpWQ3lkOHlLSXBl?=
 =?utf-8?B?bGFkWFhNTXBwaTlvQk9JcEF2N0tuc3BQUGJOR1lMMWxFOU5zSXdZVUJqdmpG?=
 =?utf-8?B?S0FzQ3U0eGwzalpnZFh3MzIrTWFucU5aZ3RZajZzQ25VeW5BZjlXZFdYWlpS?=
 =?utf-8?B?S29kd2ZIaUVMeTNaMWV6eCsrMnlHNCs5bnZpQko3RjErS0IzWUVGOWhQL1BE?=
 =?utf-8?B?VElqVkdpWnBvYUNNd0JBT3lLNUgxSTlxd2t3aG0ySWNvV2VQcnVmalVMeFlG?=
 =?utf-8?B?YmViUHRLV1JsK1I5ejQ0VzVMMWdlR0JFbmhrL1FuQnVsUHZjNk8zSEdyQjdr?=
 =?utf-8?B?dmRub3k5eXRhQ3RibHdHbUY0eGdZTjZrRldYQnZidnRKeWZHWDNkVGE4RG9j?=
 =?utf-8?B?YWcrZkNZaU1taDV1QXpMQ3psL3dyTHFHSGtjOCt0U0dTK3l1bEJiZElEVkFq?=
 =?utf-8?B?NFlnOUkvV3h4NmI3aE14bHRmVVl2ekJ5UDVsQjlOSUZOL2NPbHpoY0svRHQy?=
 =?utf-8?B?OUFsOFRvQm5xZ0hsVUVodkJBaU5xc04wVTdhSHo3OUJLU3FUR25OcHRaa3VS?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14647.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f0b523-9a2d-4b00-6591-08ddd3f9f6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 08:27:49.4585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAbF7SqPShcTrWAoXcXaiBOLREf0ApBqhythTN0GPFeKmcm+RIczNGazv8nkK39/VxP8Au5k5Vo8hL0v800dHcLY8YTVMVwGpnK/G/R1nao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11882

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgNCwgMjAyNSAxMToyOCBBTQ0KPiBUbzogSm9o
biBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2IDMvNV0gdGhlcm1hbDogcmVuZXNhczogcnpnM2U6IEFkZCB0aGVybWFsIGRyaXZl
ciBmb3INCj4gdGhlIFJlbmVzYXMgUlovRzNFIFNvQw0KPiANCj4gSGkgSm9obiwNCj4gDQo+IE9u
IFRodSwgMjIgTWF5IDIwMjUgYXQgMjA6MjMsIEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBi
cC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gVGhlIFJaL0czRSBTb0MgaW50ZWdyYXRlcyBh
IFRlbXBlcmF0dXJlIFNlbnNvciBVbml0IChUU1UpIGJsb2NrDQo+ID4gZGVzaWduZWQgdG8gbW9u
aXRvciB0aGUgY2hpcCdzIGp1bmN0aW9uIHRlbXBlcmF0dXJlLiBUaGlzIHNlbnNvciBpcw0KPiA+
IGNvbm5lY3RlZCB0byBjaGFubmVsIDEgb2YgdGhlIEFQQiBwb3J0IGNsb2NrL3Jlc2V0IGFuZCBw
cm92aWRlcw0KPiB0ZW1wZXJhdHVyZSBtZWFzdXJlbWVudHMuDQo+ID4NCj4gPiBJdCBhbHNvIHJl
cXVpcmVzIGNhbGlicmF0aW9uIHZhbHVlcyBzdG9yZWQgaW4gdGhlIHN5c3RlbSBjb250cm9sbGVy
DQo+ID4gcmVnaXN0ZXJzIGZvciBhY2N1cmF0ZSB0ZW1wZXJhdHVyZSBtZWFzdXJlbWVudC4gQWRk
IGEgZHJpdmVyIGZvciB0aGUNCj4gUmVuZXNhcyBSWi9HM0UgVFNVLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPg0KPiAN
Cj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gVGhlIFRTVXMgaW4gUlovVjJIIGFuZCBS
Wi9WMk4gc2VlbSB0byBiZSBpZGVudGljYWwgdG8gdGhlIG9uZSBpbiBSWi9HM0UuDQo+IEhvd2V2
ZXIsIFJaL1YySCBhbmQgUlovVjJOIGhhdmUgdHdvIGluc3RhbmNlcywgd2hpbGUgUlovRzMgaGFz
IG9ubHkgb25lLg0KPiANCg0KVGhpcyBpcyB0cnVlLg0KDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9yZW5lc2FzL3J6ZzNlX3RoZXJtYWwuYw0KPiA+IEBAIC0w
LDAgKzEsNDQzIEBADQo+IA0KPiA+ICsvKiBTWVMgVHJpbW1pbmcgcmVnaXN0ZXIgb2Zmc2V0cyBt
YWNybyAqLyAjZGVmaW5lIFNZU19UU1VfVFJNVkFMKHgpDQo+ID4gKygweDMzMCArICh4KSAqIDQp
DQo+IA0KPiBSWi9WMkggYW5kIFJaL1YyTiBoYXZlIGEgc2Vjb25kIHNldCBvZiB0cmltIHZhbHVl
cyBmb3IgdGhlIHNlY29uZCBUU1UNCj4gaW5zdGFuY2UuICBTbyBJIGd1ZXNzIHlvdSB3YW50IHRv
IHNwZWNpZnkgdGhlIG9mZnNldCBpbiBEVCBpbnN0ZWFkLg0KPiANCg0KV2hhdCBkbyB5b3UgdGhp
bmsgb2YgJ3JlbmVzYXMsdHN1LWNoYW5uZWwnIHByb3BlcnR5IG9yIGFsaWtlDQpQcm9wZXJ0eSB0
byBzcGVjaWZ5IHRoZSBjaGFubmVsIGJlaW5nIHVzZWQgPw0KDQo+IEdye29ldGplLGVldGluZ31z
LA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQoNClJlZ2FyZHMsDQpK
b2huDQoNCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51
eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNv
bmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEg
aGFja2VyLg0KPiBCdXQgd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5
ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcNCj4gbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=

