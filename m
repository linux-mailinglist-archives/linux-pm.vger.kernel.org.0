Return-Path: <linux-pm+bounces-32768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11465B2EE27
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88181C80506
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BE26F2AD;
	Thu, 21 Aug 2025 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gc5UwHjf"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074726CE3A;
	Thu, 21 Aug 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757460; cv=fail; b=W1JH80KBdHpP5WGoNWJYGGOp7dfQpESah/gc4mQUHl7H76/pYu95KATpse8stHcss9QS4pQkwk878FVvb8517yySxZCkqv7It9Fs3oWlUVVOp9UqiB4M/lxoTHUbj5+AErJo+WQivc/vVhTOjKLxAI2/VaLT0ypYIs8nvmULEO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757460; c=relaxed/simple;
	bh=9LmYbUjF6NKgsCz3NCZ3pQaiDvVfg94KofeTqslWGEs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eUDulZhqKk3VHNxP2Fx9qA/cOTFlx7nEWf8o1sE2ZdNTgYS9SSDGdAx0fzHvUf044QnwWeDRx00n9wQMes6HtJkjVKqFL2xMjH08xne0fZGewXXcraoZpOZYekUeSjR/tdEYUvfGULY0tFZtCEVrhNVNlPcNrO/qQSXBUh0Db30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gc5UwHjf; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/SMRjHoIHMmEjc3OfuKG3kScQsmVZB6cDpv6FJbbo6nAhPBFEfBX8tpp6vMs+3LCilNvID+X0yKCsgTrnN2au6aiz92E9+GrJAde6Z4YTknE6fbXZ13jPLhZyXTcvy99jQtwDGd67QM8exhe+duqMdxRji5MIIxpSGjk0DoYjjr4N7r2m1FYMI7RNZAp+dBK8KovWfulqtc5QCG2SdJ16Eqlw9WHExQG6X5dkRgAXUJn+fOIgI41Z6RvtHTVHOzeXYFbwfDki91jn/Sx3Kq6rHHQwRX2GNh8nVuGduFh8+R86wsjg0jNRzzgsY81LHq4+y2XtAoRUsLjEvJHOn5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRrWzKVtUMkl4NRJtsNYMwKtJMMEEDB4qNolaYXJle8=;
 b=ljGZAh/eQqXfHOV51kteBogmcHL0Fehud7u+vosE19FvzcQrCNB9Zf8I/RNYeyL2lbz+npr/lKJXH2UhXwOuv1n+OoRmMVRGzccNptp84jyzR4uem/hK9KRlQEjS/Skz1upKX5pvhQooWcVKh/Lk7RZC5MZyjNZORKpEwKl2Z8XHQMGm92eG2dO/ihmfxzYy+fQoB3beTe1A6hzStBwxAdrcAnctBZw0/vkkg6PyFdQxsBaDgrx17sDnItB/f+uO1ib2FWeCg7hu3GATxqWLWSb7+t8UzSVba754mWiswdGgG5EBCLFAD/tKwma8wl52mc2f9aaxCIB+UI8iH9L2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRrWzKVtUMkl4NRJtsNYMwKtJMMEEDB4qNolaYXJle8=;
 b=Gc5UwHjf/+uTv1YzqmZ/kWxPlPrlGA+GaYiIBBH+v0wy4XYJAtNhQ+q/ZosWK0WXV8BiWTCX4eAdNZ7rON2gKbCqcdOJ4JGfmjVinasVF37pfObeYkou1+5pm7JrSJmq+07JHvJJqtMdHamyEKJ1FkXg9/IET7hQ4tdCeXf1hSaFzU/u8Dw2qh6qjpMYcUQkSlS/4gZV/b99G/sASndpETqGQSKv4pxj4prmNnZupybHEE9VbLpZ8B/mmZiXQft3Jk5j1341UA0O82A49V7UqLto7re+Iw6OitIOpYnBuuBAH2hS2Y4ZQydRJxFVGaNKFPzSL8tk70h+RHqmkXPGSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 06:24:14 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:24:14 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Thu, 21 Aug 2025 14:23:50 +0800
Subject: [PATCH v4 2/4] thermal: qoriq: add i.MX93 tmu support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx93_tmu-v4-2-6cf5688bf016@nxp.com>
References: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
In-Reply-To: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755757438; l=3204;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=9LmYbUjF6NKgsCz3NCZ3pQaiDvVfg94KofeTqslWGEs=;
 b=P4MNDJWwLgk0/u19eIn+WqJ46zxK/7MfY8Hdxp3cdcN3FnDGvCRruBrHO/YMJ5uNhcqj5+cQp
 sf4iOppNZYLAiJCPTi0XlExs3mMqNXNvtp1QMfO9bAHjasw/fbRSo1z
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: d0dec681-955f-48f9-29ae-08dde07b597d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1ExL0htc1YyZjRuRlg0UThjemU5SnFIVEMzQkVTRTBJMzd2Vy90YXpBRlVj?=
 =?utf-8?B?dm9ldFlCVmhneGJwcnZmSkhoNm9iNE0rK2x0QjBHdG5RUlExSlhtbHY0alFS?=
 =?utf-8?B?ZkplTHpnT1hrWWV1WEtiby95OGZpa3JxWmcrUk9mbHBDRzBMcHUwUDlHdW80?=
 =?utf-8?B?bnZrbjFlaTM4WGRrdlFBdzJYZENhT0YrNGhNdmVaMUZTK3FBdlFFQUZndmpm?=
 =?utf-8?B?VHJDNUo3RjlTSTR6NEpZbUMrYlk2Tkw2RkpvV3AzZUdKc3k5aUg2VVVERzhX?=
 =?utf-8?B?YUtwY0xWamkrbXhNTk9EOEtOMjNvZ2ZpeVlWRENxbER0UmpqQVNycnkyaG5r?=
 =?utf-8?B?N1p3WjdBWGtZOFA1cldIK0EyT2FrMDdESkQwaWhydkFyelBrOVd5aENjeHRH?=
 =?utf-8?B?VUpod1duc08zZE4zUXZxM0YybmJKSnRLS0FScHBSSHYrc2YzRWJXSnpUdnF2?=
 =?utf-8?B?WXZ0Nm1yb0VwYnQzNllCSGx2eTJKeDRsUW1iK2NESGxRL1hTSnlwQk1HY1J6?=
 =?utf-8?B?YnJpdkpxQllyclgwdEpCK1ZWM1NCOGltdHc5SU9MTHBTdzJEbVZuOVBJTzZ0?=
 =?utf-8?B?QnYvNWlKZnYwQUYxdHBIcTlqYkd5YjAvMkZ4eGhLYWFsVCsrUnRsRnZVUXZm?=
 =?utf-8?B?cGhLcnQ0U3lkTkpvbGNMWS9YSTJiTFBsR2dMMFZMa1FnYXlRcWtzUTk4TFdW?=
 =?utf-8?B?OHhhaG5rS3lOUmJKZ3JLbkE4QXZWbE5FY3pmTHNicHcvUnFCNjJGbElvWGUy?=
 =?utf-8?B?d3V5aS8rMUwyalh4VHFycmNFZDdrenQvNjhNS1N1TmI2eXpDeFRFVVZSR29N?=
 =?utf-8?B?RlV0VzB2SXhxalg2QW92NDNDaFlpWWtvaXBnZGZKOW9YaW5IOGxXMVdpK1B1?=
 =?utf-8?B?VzQ0RnRBTmU0ak1NdmM5WEFLK0pqYTVKb0picTRzazNNNVZlUFpKOEZmaDkr?=
 =?utf-8?B?bkJpQnIrU0lrWStwaFAyZVArdjJUN1lKclUyeU1LcGt0VlJVWDBza0hSd3Za?=
 =?utf-8?B?MFMweUoxY0xmRU1tdVV5bHhsWmxBOXorY3pzSW5XcEFIQzBEcG9BYlFxWWNS?=
 =?utf-8?B?LzR2NWxaNnZMVHZNWkhSTUZLdFhla1kwYzBDSi9QT0o3SDluY1RYblF0NWVj?=
 =?utf-8?B?NU42bGtVeE56U3ZqWXdkbGVxVm42S0VRaDdYK2Q4QWI1aElWRkthcG9LWXJr?=
 =?utf-8?B?ZW1LSWh0Qk81djUwY2x6RUkrai80RjJOc0kwVmlGTU84YjJCRkFlSkxjOCtP?=
 =?utf-8?B?SnpjamlHN29jSk1KZmdZS2RmSzlRTmRiQmVGSGc4dzZnK1c2RTVOeDdhYmU5?=
 =?utf-8?B?NjU4a0pjTXFzU0Y5NVhwTFBkZm9BUVhNQ3A4NUNwYU1hL3RubVg2RGlVN1hm?=
 =?utf-8?B?a0VUUnRWVWt4YUxNcDhzQ2xLRkt6VFdmbWlmWkNRcmpsQ1FrVkg2bEM1S21H?=
 =?utf-8?B?bmVzMGVlbWpNZmRwZWl0VUg0a1lkTFY1c2dOcnNaU29PNnZhL3dxNDhVVkNO?=
 =?utf-8?B?cGtwMnkrcGRvV3U2TSs5MkpaekFvRmxOeVY2UVR1VlFWM1BtL3ZwZFpqd3l1?=
 =?utf-8?B?a1JuTmJqYzFDT3FCNTQ3aGY1VDN1Q0IvRzZsQWwyZWM3ZytQMHAxZi9LUmF3?=
 =?utf-8?B?bXUrbVFIeFNNK3l6dG9penRHNFM1VVFMNHhzYktVRC9HWGVGVEFKbHpvL1Rs?=
 =?utf-8?B?TkNpK0xKYkJmY2lHZ3lSVUNBQU04R3hOWTBWOXIrSm5qenhQczYwUUNVOGpt?=
 =?utf-8?B?RDB1UXJtbE92eHRVYnZsaXdHcFhKM09pZm9kK2ZNdW5sSHgwUTcvbS94M2F0?=
 =?utf-8?B?TzcwWGkvT25pNHVub3FXdm5FaTJHcWU2S1ZlMEFQTWNUNE9BS2tPb3dmL2Z4?=
 =?utf-8?B?ZVJzMDVjSDVTQW1QY2NrWXNsQWRuU1lPMUtad2dKRjZpcHo3NURlMEd2Nmt3?=
 =?utf-8?B?Y0hKYktxSmlDQ3pHZGJEMkNJQkI2cUZSSWZScDZYL2VveE9zSE9QYWF0MnNK?=
 =?utf-8?Q?avTq4pBCRHg6/uon4kECcWlRPxpIgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0hwQlRNcjFOanVNTDQ5T2JaRGQ4aE1CWGc4cTZzMDhmak8yQXNhd1N5NmM4?=
 =?utf-8?B?U1JiM2JyaGI2aDR0bTVWSVZLZm4zazJ6Tm5vT1hZSjJoRXVrb29OZHUrSmpI?=
 =?utf-8?B?ckNqRnZocjRtNFF2eHVXSjU1d25reDFkTVlBQ0dVQUsySGpFME9QVUU1aGhR?=
 =?utf-8?B?MytTQndEbTJwVzhiendWeFZTOWJWMUJXRnI3Wk4wRElycGhwWHRBVG5hbjVH?=
 =?utf-8?B?cUw3dkh1bHV5SEVQZDh4SDVIcXZVaTNxR2diYU81ZjNZS2ZBbldvQU5IOStm?=
 =?utf-8?B?TlB6azZGeEUyVm0rUlhkSkV1d2Q3V2RyN0l3dTZtNnh0SDM2UTE1NVJXWEZx?=
 =?utf-8?B?b2wydWMwNkFCbWxDYlEvT1RlVDNTUlBlbUZBVWxaZUJnbTltVFJCRlBEaGVE?=
 =?utf-8?B?djdmcDh0VXJHd2JFVVk1TEh0REM0YndxL1lxRWZxSzV0NUN1dWQveWMyUEJu?=
 =?utf-8?B?Y2tMUzNER1BJYkVDQ2liMzdScVJVcUFlOVB4ZTRXWUJrbFd6cnJKd0NPS2hh?=
 =?utf-8?B?WkxwUHRLR2FpVjF6Z1hRamZCTTc3QlNvcHFlVFFNTzR5cjcvZnV0VmxkTlMy?=
 =?utf-8?B?TVZLb3hycUtweXJVNTczZTZ3SElCcDZRaGdQbkxxbWgxSllzY0hiTmN2dEpD?=
 =?utf-8?B?ekpDaFd1ZHhLUEZVbFlLQjdnSVpCd1dsRlROZ1ZWVTVUclNxbEN1dWNkRnUv?=
 =?utf-8?B?YVcvMGRqZDVhM3RjU0gyOEJ0TzZiZGFiVXVGUEQ0TFczOEtBdGdTeWJnQUYy?=
 =?utf-8?B?SHh4YjVqcVhmVlRmRS9MYS82VzMxaUs2Yi9GbmFWM0lyUTNxb05sV21RVHQz?=
 =?utf-8?B?MHVjZmlmb3ZsUWNpMzRWMkEya3pVU0JVZlhkVzdybEQyem5lZXdPNm5UTmp6?=
 =?utf-8?B?d2VXMUVaRzduSTU3UjFlSkxVeXorZy95TnViVkpKRzhYWGw4dXpqUEJEVEE4?=
 =?utf-8?B?QngzQkdDYlVhVmd6SCtlclJzaThzOC9GNms4N1lmTDJRbm4wbHN4cXJDNmdI?=
 =?utf-8?B?elhkSU9nNllITitZeHB3ZjVlNHhoUlF0VmM2NnlpOHhOMUVaWDFpNlNhQlYx?=
 =?utf-8?B?RXhTQU82UDliMVYySTlvTFcvTWFKdzFMbW9XYnI3cWFEN1NmRHhYTkRyQnpN?=
 =?utf-8?B?MXNDOFMxa1NmUTVyL0FMRnJRVjZiSFpKSlBVUTA0QldQVmM0ZEd4bXd6OGYv?=
 =?utf-8?B?NjdERUxlWUxOS2hiR3Jac084SUdkZW50MDFvb3kraDJkU2VNNUhsOEdIcVR6?=
 =?utf-8?B?M2x6Z2xsL3NWQklsSkV4ZllaV0JRL1lwRU9QVXBDb0t1NHRKSFNzeWk3OGFa?=
 =?utf-8?B?TGN1Nm9lMVJVSWtObU1QSXlyTjB4eDFoU0xSYlNkaHZ4dkF2MG9QcmlDNzlO?=
 =?utf-8?B?bEtyNTZFNUdDS0FUOWpMT3JES2t1NzFoRXg2M0o3UG5WR256MlpNSDJKbklo?=
 =?utf-8?B?SEdveFlQVUYzeFNLTVRVd2JJUWxLTkhicGR0cUV0UzFuQ1h0anZlQUNGSEcv?=
 =?utf-8?B?OWJWOEltYmppcXYxSTd4aWQyLzZ1R3BBUHoweFB2QXpGZ1RoSGlCR1dPVlpI?=
 =?utf-8?B?bHJRTlQrTVRXeXk1L091WktSc2RQSUdZNi94SDNOSTZJUzE2VnFUWXZLZm5D?=
 =?utf-8?B?Vi9CdWYvNCtDSGUzOXBCN1FiWk1XK2pVcmNXMVhoK3JjOWFqSkxueEU3Uysw?=
 =?utf-8?B?eFZiYjhEdUN3UW9WblkrdnROdndzeWdPck1aYUxxSjc3UkRjR1BhV1M1Uzlq?=
 =?utf-8?B?VCsxeHRrSXVYUHZMRjZDK2NNTVlYZFdmMWwxK2psYnduZ1c1cGpweUJOQXYw?=
 =?utf-8?B?b2k3MmRZTTFwMUduNUhOVUdnUjBvREJKTkxiVUJsM2trWGdWeVZ1U21Gc3Zh?=
 =?utf-8?B?dE5ScUtNSkNYQnFmVmFKajZqYjEzMGZMVm5pdG5qcjI4WHh4NUZTeGhNc2to?=
 =?utf-8?B?VFVGRHlXNnc2dzYyTEtYQlNXWEJTYjc5NFhEVm0yWjY5TkZBZ25TbCtwWExN?=
 =?utf-8?B?cndFRllaNE1ndlMwVWZ5SzBkWmU0N2hKZnRNZEFPRkRRazNkd0V2alhxL2JO?=
 =?utf-8?B?YWVrYm9KNm5sby9ZZlE4MGoxVHcxSTJPeFB0bHBmOWdlY1pWSUhvTHdTUUpD?=
 =?utf-8?Q?gML1ekDg9FiTY1DOpiaPeFHIx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dec681-955f-48f9-29ae-08dde07b597d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:24:14.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlkjqfpxWbaJBLS90804Gk9PJknIagxcrholRIO5yoWP/Pb0xh2f/IOo3claeE83MuQmDMD6LH75I07OKDAqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
from the ID register is the same the one used on some of the QorIQ
platform, but the config has some slight differance. Add i.MX93 compatible
string and corresponding code for it.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v4 changes:
  - no

 - v3 changes:
  - use the drv data struct for match data and refine the code
  - update the copyright

 - v2 changes:
  - use the compatible match data to identify the i.MX93 TMU variant
---
 drivers/thermal/qoriq_thermal.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 01b58be0dcc64d14ca5e4bba654eed8f15e827fc..b2e634547271dcf512c714907baa162921d2d527 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2025 NXP
 
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -24,6 +25,7 @@
 #define TMTMIR_DEFAULT	0x0000000f
 #define TIER_DISABLE	0x0
 #define TEUMR0_V2		0x51009c00
+#define TEUMR0_V21		0x55000c00
 #define TMSARA_V2		0xe
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
@@ -66,6 +68,8 @@
 						   */
 #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
 
+#define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
+
 /*
  * Thermal zone data
  */
@@ -73,12 +77,17 @@ struct qoriq_sensor {
 	int				id;
 };
 
+struct tmu_drvdata {
+	u32 teumr0;
+};
+
 struct qoriq_tmu_data {
 	int ver;
 	u32 ttrcr[NUM_TTRCR_MAX];
 	struct regmap *regmap;
 	struct clk *clk;
 	struct qoriq_sensor	sensor[SITES_MAX];
+	const struct tmu_drvdata *drvdata;
 };
 
 static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
@@ -234,7 +243,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
-		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
+		regmap_write(data->regmap, REGS_V2_TEUMR(0), GET_TEUMR0(data->drvdata));
 	}
 
 	/* Disable monitoring */
@@ -319,6 +328,8 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->ver = (ver >> 8) & 0xff;
 
+	data->drvdata = of_device_get_match_data(&pdev->dev);
+
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
@@ -376,9 +387,14 @@ static int qoriq_tmu_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 				qoriq_tmu_suspend, qoriq_tmu_resume);
 
+static const struct tmu_drvdata imx93_data = {
+	.teumr0 = TEUMR0_V21,
+};
+
 static const struct of_device_id qoriq_tmu_match[] = {
 	{ .compatible = "fsl,qoriq-tmu", },
 	{ .compatible = "fsl,imx8mq-tmu", },
+	{ .compatible = "fsl,imx93-tmu", .data = &imx93_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, qoriq_tmu_match);

-- 
2.34.1


