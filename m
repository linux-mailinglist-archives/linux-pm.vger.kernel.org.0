Return-Path: <linux-pm+bounces-31717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC60B17BE0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 06:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885685A7774
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 04:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E11F03F3;
	Fri,  1 Aug 2025 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FIcm9zj4"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EE347DD;
	Fri,  1 Aug 2025 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022895; cv=fail; b=bwwp2uX2xPFeXvPw3EwclVPcRr7cOr7LqQUK7NS54qMeQJq2Y/hJlJ4kcu5TdtR1VCh9O350qFi7QZGGHcQsayhEk5uYjyhMCEkl5H1+ZGZtAKlbpAVk/69YVwR5Cb1jDl3t2qSUWnaEByI0oE1GJdV83apHcyZ0mJdcIN2tsyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022895; c=relaxed/simple;
	bh=BSjADjXjvjsZOLauHtK7Nt6nAFY52nQ885+hvbMZ/eY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=LnCyQR2xyNvkT+/ftDFmsYtgjiVdceB8Z/uLE7KWpWW2umL+mMotwyagaybMuPB+9py+L/YTQXthSFlk/2cXURcBbBfE9J24Y7TSpCOae7mxHygdPIH9Je1GHGW4nN9EbWdoEcUyo/ThNXdz/k0f1xZ5kLRoiDOAcRBwB7z90aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FIcm9zj4; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHhTIrglptUWiR7gFWZrCr050myShLT3vvvVgqmqZm3OVPQ+82Jo+UdEXvGhMy5xRNMrNTet6mY9DRALu098neMSRYwJQMANwgmNmB4GStDQP1qGIrwiOjP/QCGZScHq1XXYOU3bLanEEJpJ50D3XCBweWFOFesASF8hQ+S/wZk7lhC93av8brQu6QObbzmo1xN010yYxH/Xrt3rNkTp5jGe4gh/WsTv0gye2A388PGr8FHu+XS0sDxUE6nSn1580bIoxcfUVegugnAuKrJq3fjPpGkkeia3e0cAwHnW/IQi2lzKm05vRsv/3ZYMzMzaZ3txqF2JqtlbuoB3tLeDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrGQMLCc5TSGW2JWafHMXndT5sVqYmPn8mrP/qF5de8=;
 b=GROxVTYgyEWcr6K3c6VxQ+vvFlyhe/h2kkYODy94Tk8+Quglw644dL56byad7Rnkr1etefIf1zF7i358H+Lp1F2vSmKxh5XX+/Ult0nzWMWCIBPVYG5Roy9jio1v8ckV0ljeC3mp3viQC4TfS1oXobaPqZoVBmmg2JJIUnMytVH/92pmmDUYbITdLQ4LeAPg0/Ito5NfkfAsVnA4+4eEWkZH1jX99OBc0rZnLabAZ4giiBW4AYQrijjtggSwSHbNURsg6MPr09SWzE1pE6I95tHWFEz6MPHo+wMVxCj9zGofoAEbLVfciic7Y+NoHqsrNuuo4IdhYG98kG+bsFl1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrGQMLCc5TSGW2JWafHMXndT5sVqYmPn8mrP/qF5de8=;
 b=FIcm9zj4fzy3oF9LdWyWewBAxL5zAWMeh65qWdOFsExd3urTUuSArCEkttA00QEBXWGE0nTyfb9UjooTCImRO0eakJWPvuHjbSZXrDqyOzXYKzEh6a7xrb4L7piL1rtyUuRlMyp6ZWapmF4eHJxG1JHti+gYnSyv/kgvWL3VBlRqv/xcBpB6miTUNIA5fE88I5f8m0vOiZsKgLQu1QG009Q8CU7ORCXyuoXPucwDXx5M83Sc8bZ1Vku70yUhXb7rC/R9G13We9PiBK/9CN/RiCdhzNO/jzBeu7scHe2JPu0ollOd+6G5yFZZsDyNIcYTanG7sg3R9Nv36rRMw0yrwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10600.eurprd04.prod.outlook.com (2603:10a6:10:588::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 04:34:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 04:34:49 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 0/3] pmdomain: core: Introduce
 device_set/get_out_band_wakeup
Date: Fri, 01 Aug 2025 12:34:21 +0800
Message-Id: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1DjGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNL3YJcXSMT47Q0cwNL81QTEyWgwoKi1LTMCrAh0bG1tQC81srwVAA
 AAA==
X-Change-ID: 20250729-pm-243ff7097e44
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754022883; l=1681;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BSjADjXjvjsZOLauHtK7Nt6nAFY52nQ885+hvbMZ/eY=;
 b=qewVlLsqN5bb/jPcrxFvNZi3jQo2ofKzgpzW5QeBW0IT5DKNfV6MRmG0OhO7kn8atWyq7LM9/
 J2Q8fv+S+fsDe/X1621ykKd7HQ5PdYG8jtVzuSuV71OrTdtoXSidc5s
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
X-MS-Office365-Filtering-Correlation-Id: 52c347eb-d43e-43b5-3146-08ddd0b4c023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjhkbG5lc2hoMEVISHZGaUFPeW93cFo4K0liV0Z1dThNbmp2dTNlZUtTSkU2?=
 =?utf-8?B?ZzNvNjFKRWhpWFBUVTFla3llZ3ZuYXMwTVhNSHowSXFOUGxqZnVpWlJaaGZJ?=
 =?utf-8?B?TmxZeEtHNnhRVEszN0hXejVJejRnT2hCUXArNi9WVmQ5cUExY2NwdVp5WlFl?=
 =?utf-8?B?QkN4RTkvRGJQVFZtUHRqd3J5enhqTmRZNmVUeXFOVmU5dWp6c3ozakd3elVh?=
 =?utf-8?B?N3ROMXlhRStTbWRjMFZ0WWJ2YUViZDluUjhpRGdDWFNXUXgvM3orMktuTHQr?=
 =?utf-8?B?SitxUWFsR3dpNDhWcTZWZVZkZDN5Rm5sZkRUM1ppSUh2YjdzTlFpbU5iUERM?=
 =?utf-8?B?ZHRFU1VscEFYL1VLU1hrVnlJOWYrQVJjVFlyTFJ5OU44VjBRVmpCdGk1NjFx?=
 =?utf-8?B?dUFieUM3QnAzVUdLVHRJdmFhZE5mYStpRjFQenkyT1R5SGo3RDg1WnpwL0kx?=
 =?utf-8?B?SHR2dEovbXVSNDFhNUZwaDg2MHlPL0ltc2drQWlzRC9VSUZwV0tkSytWOU4w?=
 =?utf-8?B?TytxT0UzVFIyZEhuSXlxRjVpT0IrNThtZE1FWXZFejZNRmc4Nm5kaC9pbFg0?=
 =?utf-8?B?UDd6YXVzNHpac0pwVGJQVFpvQSt3Y2ZIQSs0cmx0dGl4YjVxZnFzemFZc3hR?=
 =?utf-8?B?R2dLY0dmWjFyclNuS3BCSjlGdmIrZHBNVXlXV3YveE5KSGlmYjdDbm43RXFL?=
 =?utf-8?B?ZlY0Tk9hdWxsTFRjTjZ6OFRBN2d5Mkd6RkJtbkUvVG5Ed2xvZS9LTitJU1Z4?=
 =?utf-8?B?cjZxaE5nL3hUYlBXNHFHejZFeWhZSkw5cVQ2Z01SdDUvcmh5ZVRHb3YwU0ZL?=
 =?utf-8?B?MGh3MVBoZDlFeW5hV3ZGeXcvNUJvRUxXSVRBVWZtTm1YeWlOVmN4ODVIUmdk?=
 =?utf-8?B?UktvWGxmQjRhTGRGZzF4NWo2d2RUREpRdDlORDlzQnAxRG1KVDFqcjJBdVZ2?=
 =?utf-8?B?bG1uME9RUmZHUGxkdnRNbmtYNEZpTE5xZ3BXMGxjbmlRT1Z5UEUvVjJUTkdJ?=
 =?utf-8?B?N3o3eSsxRDRBYVkxYStIT0E3NTM0WFN0cmlQSDNDbzV5emdSTU1tRmdYaXd6?=
 =?utf-8?B?OUxpQ0ZFNllHTjIyM2oyd3lUc01DM0YwdEhFb2pQUjZ4VldGV1RDdEpiSHBL?=
 =?utf-8?B?aEN1WXlSL1p4TGM4MUtnNDIwRWtkd25QellzNnhSZldDSE0vVGZYQUNZV0VG?=
 =?utf-8?B?cHlFN0Z3VmN5ejM1VVQ5UWR2WnBTenhhNjFUQzF0ckpFY3pxdzdPMCtCeUl4?=
 =?utf-8?B?NUovN0I1eDV0MTRuenBZYkl1NFF3dVFpVUFNdTZWdVBnRWdZeU1Zd1JGZkRC?=
 =?utf-8?B?UzA0WnRuL3RiVVFDOE5IZURWMGV0aDc2TndvSnlTYngydmthcGFWYTB5N2Qw?=
 =?utf-8?B?SGdwV2FQZUZsb2ZkbWhBdVZzOU42cE01a2NRbGZvbk5VK3ZvM2dzWFp6U2VV?=
 =?utf-8?B?dGNVa1ZsTmJzOUVkZERhY09yeVNGZzBMeXVTUXQ3ZTRKNmdPNWtrTUwreGZ3?=
 =?utf-8?B?a0hkRjM2N0l4cU9PQ20wMWY5TWFaYnZJNmpqNVl6b1VhOFpzS21DbXBPWGxY?=
 =?utf-8?B?emZ4L2FhcFJxWmpKNkVyQllIeGFxRTQvTktOaGZtbGdLaU1QME5oWFRSdlhp?=
 =?utf-8?B?dFlKcERVb0RPMzQwUGV1WGVaa2ZNWlZ4SGlJdmJsRitQTWRzQXVPSEg2L1Zu?=
 =?utf-8?B?a21udXlUUDVKNlhZSyt0c1RaT3duUGVNMGk2Z0ZpbG9jWnc4SXNrTDNMRTU4?=
 =?utf-8?B?Uy9NMGhWZDRKbDlZYVN4L0ZTK3MzTGdFM0l6am1LWkh2VUYvYWpjQXZHRS8w?=
 =?utf-8?B?OE9zVUdSVjhWU0NzMjY0aEM2ejA0SjZ6b3F1ZnJWQVNuamRmb0M1Y3hGdUFv?=
 =?utf-8?B?RGtVVjFOeldTQTY4V2JlWFBZZWhPUXBibW5zdE1XdmJkM25kSWlOdCtKa1Ja?=
 =?utf-8?B?S2cxMEJ2RFJSeXlWM1hZL1hXR0todjhmd3RMbVE4KzZGWWxrOEo2YnZJNTNj?=
 =?utf-8?B?ZkVBeGp4QXo1V0hvMEIwc0lTWXUrUmR4Nm92L09jVDNreVpHbXpmU1puWUhH?=
 =?utf-8?Q?n5SxVY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlpPbjMvVW1MQ3o0WHZGaGttRTQ5VWp6Wk1oSGdjbE1hVXdLNDl3S3lhcDRy?=
 =?utf-8?B?OE9hU1JuTzA3VFlrYnZvY1dzOVhjQ1dkTHFjQmJTcDY3bE02TVdjUGVVKy9W?=
 =?utf-8?B?L2hYaEhIaUZIUkkxYVlRODFXOTVxb1JTWDViRGNJcnFaQUVpTUlRV1JqdkRi?=
 =?utf-8?B?Rm9URW1NMDRDV1BGNXl6ZllsKy9lNkpTYUZiVnF1SFFIcmE5cVJEQVMrRjV1?=
 =?utf-8?B?ZUpxdUNpY0I2L2tDbmJLZHpIQlg3WXZ1REVhTEkvWGZoVlYyMjdZTjlHWkJi?=
 =?utf-8?B?ZVFRSGZKMGIySFFZVk8wL3BYRWlmNWRXZlRCOEhiWVp5N01salRQaDduTElm?=
 =?utf-8?B?YWQ0R2d5YVJhc0F2bmdEN0VhVUdXZzlTVHZWVTJ5a2djTXR0bFFZcncwOUVL?=
 =?utf-8?B?ZjljRWNtMkZqb2k3YkpBRmM5WTlPYmtGSU9qa2JYZGVRaWdlblFXZTlqbU1v?=
 =?utf-8?B?SzBMQ2xnYU4yUmFwN3BGUStUTVRMRytIUFBUVGxBUmh3cmNuQklyOFp4enVP?=
 =?utf-8?B?K1lWbDFnYTZDRWhPUmdNSG9XbEVUWXB6UGg0Ujh2dzlYMFNWd2l5OVNsYzlB?=
 =?utf-8?B?UUdWc0pKVVJ0MkIrOEpSZ1VTUjVPNUU4UzFmejA1dXQ2M3gyNW1RM1Yxbk5D?=
 =?utf-8?B?eDhQczJ5TE96L0JaUnFPSjVoUjNFRlJLbVlwQkV5Uk4yZks1WGZ3YlAyMzFB?=
 =?utf-8?B?VHZiazdwa0pLUm50VCt5SUwyN0xhWXBNUHZxSGJRTVpuMGlFNU12YVp4d01X?=
 =?utf-8?B?VS9rb0IyZEVLMnZnd0djd25vLzQ3SHBGV054UE1XclUycWdyc2M1cnZ6d3JB?=
 =?utf-8?B?VlNmbXl4RGZoc2hGYnlDbG1QYlhMcStmaVpGL0xFd3k0YjduY1JEZXNEOFRG?=
 =?utf-8?B?RlM5b1p0c3h6aDE0dHlFNVNJSElxTmtzSENRYlNsa3UvdGxXNEIzT05lSEhz?=
 =?utf-8?B?Z2p4ZjJDdmp0Q2w2ZkgrNWZCY1VIQUwxU0N3ekZqSW8ranEwSTVKMlBUOWNJ?=
 =?utf-8?B?N0l0am5Ic3JkUWVxUDJvOHVieXJoTmdKTjBkZnY1VTZZa3pyMWdRWHgrcTRo?=
 =?utf-8?B?dDZaQkxQYVBVR2pHKzgzTUJ1SjA4Wkp2Wmc3bDRzK0tFWU0ydTZjM2FVNE5S?=
 =?utf-8?B?WmhrRHdNQk1kRzlnM2hJN3UvaWpNbEM0NXlsWURmSTZVci80RDZMQXNzeDBH?=
 =?utf-8?B?ZGJBZ3BaVEZIWDFmWktUdFREMXR4WmRyZjF2emNiUkJ3elV2NHhzUng0Zi84?=
 =?utf-8?B?aERkTlpnWXY3dmNwYWkyU2ZNNVdFT2JESkJKUW1QYzVSNTlwQ2ZMTHJzRXVm?=
 =?utf-8?B?SGlCOVhLVEZITVhvd3NzdHJDMmdXZ1F3VHl1cm1YQTV6b2RqZWJTK1V1L2Nn?=
 =?utf-8?B?clhTZ3JQcitrRmt3UStlK1Y0dnF6S2JBdDN2WkZVT242NEdCcStWZ0N6NWxz?=
 =?utf-8?B?SjBUcmNoKzZMVTFQTWU0KzhUZVYrdGgrYk9pK3Uzb2dmVjJhY0tLNW1kTGJE?=
 =?utf-8?B?VEdqQkMvTHJWMFA3RXZiM0hCaSswRWFiMTNHN0NGQUJwNzVTSjlMUm1XYXhU?=
 =?utf-8?B?a3lTajZuRktqRVlFeit6QzdHanJZV3FEUnJzUnZPdUxiMFhvV29zKzN4VmFk?=
 =?utf-8?B?VUdIbm9YNHJtUFAwTU1wSmhaZWRCTWFrVzlTRzVOR2I2VXhtWVVtR0QyU0d2?=
 =?utf-8?B?SmhXU2U4c2Q3VG56ZWZCbFVmNmRHZjRxQStQQXIvaytObms5WjNPVUoyTUFB?=
 =?utf-8?B?VisvakFSV1RsckhpaVBlUEdIQTVpS2E3ZEdjd2R4T3hvK3BIZ3Y4Y2t4RTkr?=
 =?utf-8?B?amhjY2tOaWNkU0taQU5BeG1zdW91TW9xVHUweVhLN3pnTXpIc3hGTTE0TFFH?=
 =?utf-8?B?QW1ReCtrZzZaWE9wYm1YT1RnOGVVcHp3aTJwenREMHFUMjBuSGY5M3loa0dF?=
 =?utf-8?B?em16TUVpMzEwTmNFRWtIbmpkVFlvUDV2RGk1SElrdFhYNFgzOGIwbEt4YmVW?=
 =?utf-8?B?cnN1YWdDais0dWRvbmEya0JaZXErQW1iVWJWTUNJUURMVWlvMXlBTmw2OTN1?=
 =?utf-8?B?MUJ4dS90cldFdElEMlFRcTAraU1pVHFHbUpaMHp5UURXbC9OWXhDaHl6bXlY?=
 =?utf-8?Q?DWMHR044H/409kiGjunAq92uB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c347eb-d43e-43b5-3146-08ddd0b4c023
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 04:34:49.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8w4VOsDo721g09NhoyautAfdZNSuCmkl7JjexYp23vjvpO9Plb7VuHBfAQ+sLlKq4O+itNAs/iQnUblloS0rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10600

This is pick up of [1] which does not have response in about 5 months.
This V2 patchset
- includes usb driver changes(patch 2,3) to give people a full picture on how it is used.
- Rebased next-20250729 to resolve conflicts

To i.MX95, USB2 and USB3 are in HSIOMIX, but there is always on logic
to make USB2 and USB3 has wakeup capability when HSIOMIX power domain
is in off state. Otherwise the HSIOMIX will be kept on when
USB2 and USB3 are configured to be wakeup source and Linux suspended.
With this patchset, HSIOMIX could be powered off and Linux could still
be woke up by USB hotplug event.

Patch 1 introduces device_set/get_out_band_wakeup
Patch 2 and 3 are drivers changes to use device_set_out_band_wakeup

[1]https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/

More old discussions:
https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      pmdomain: core: Introduce device_set/get_out_band_wakeup()
      usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
      usb: dwc3: imx8mp: Set out of band wakeup for i.MX95

 drivers/pmdomain/core.c            |  6 ++++--
 drivers/usb/chipidea/ci_hdrc_imx.c |  8 ++++++++
 drivers/usb/dwc3/dwc3-imx8mp.c     |  4 ++++
 include/linux/pm.h                 |  1 +
 include/linux/pm_wakeup.h          | 17 +++++++++++++++++
 include/linux/usb/chipidea.h       |  1 +
 6 files changed, 35 insertions(+), 2 deletions(-)
---
base-commit: 54efec8782214652b331c50646013f8526570e8d
change-id: 20250729-pm-243ff7097e44

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


