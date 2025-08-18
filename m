Return-Path: <linux-pm+bounces-32518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B2B29DFC
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721BC3A713A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ACC30E0C6;
	Mon, 18 Aug 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XNkorL0h"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E33176E8;
	Mon, 18 Aug 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509618; cv=fail; b=KatOGYSir1bHEVVOeXc8KAdIjXCgCXlJ913p+JvZ/sullv2lMF5Sj8o+kjhmXVlv0lNrGGlxTI2H6WspPKn0EXnhuuHcbFkZj3HUtlrOrN9B1gQMb51O/yCrzMl/rdy4n+A9gJEHPK7rh5scWv6LQFdnnSSwhDj9wR28jut2s4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509618; c=relaxed/simple;
	bh=zg351AE45U2ybKcKR9yBvPxjvRtj3jttAEeWBzzf0jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oPPXeURhvLkGIPlWsZITopESVsfVmg21oT2pWtxqdbOjJ12O8qYQdv6Cj8asCiXrQciTMX1FLlrVQM6pN+t9uJIHOmjSUAYNuwmcR+EnBKvMULdxF4V6LOhqxgE+2fPnmvyrz31wP8L0Nu41Db0oW/h+ddz6J7OMzJFihRC3zD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XNkorL0h; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0NumZgtD1Euawz/8HgSePxTsJNIqcu/XDiFfdkme6kNEHyGXxcnP8OzCxDqUTquddlTBJRyZVj8jxuSIlKT7uvU20wqdkOj1r4qZZCRhIk8nVF9VXTmL3JvRpT5L7Uciyv/RU8QXUXZZt5wVvJDQembDMEsDTygkZSpNyplmERHn3URti3O9DpTpjdQ2509J5DgoHjJR7U4PbDpYPeuvYhDmYoveJ4T/+rOQE9a9+qoUGcaFFuLPEVqFiQ+xQgcpbMPdzDRTty8EvtX3WysErYLrcBCMcJNXcRWfBHeiO8pNKZ37MjyKkgHqKpJBo3v/+SFF3f9jLEu8jglMLO4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbRDR0YwnMdUQFMYv6lhocw2PRgXER85TAEnvpc0jDg=;
 b=w9KAMoBBqcpccoS1dW6CNA7wb2+ANcVKYBDPK2LIPbgcIpZOtMOpm6ctpbeJieLuixcCBMBaeffeiYbGaFj2gwQOJZFZSMd2utQudJwqKn5zDrJfx5EAOhFDv187ZNMM5tRDj3/40XtsEkVzXgYBHoMvxn7sONmwT0u5ZHN7vsB6cWa1nhdt2bqXasju+SKYJuqyN3MUXGqQiAwmSJXEmOluOtFzQQTkx3ADjKeY4rTXIG/FIUin/hKwz88uzWS2BqlDdhkKO71nVadyPniDyqSFBGgynoeRBSFpTVVh6mTsoxyZloP+lggECgtCQP+oIQoi9NkVKFzYoRpbJe5BJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbRDR0YwnMdUQFMYv6lhocw2PRgXER85TAEnvpc0jDg=;
 b=XNkorL0h5L4lBqXW5in5hQ5BcF4Ts0y4o8hj7ATyODdVc2AMs695Tcdczh4dQTF0Hbnwl6/8AbDNlDYgcqmqanGpWCaacPHCek66/7KmnaZB5t2DV9Lk6A1He5DHJib59+09xHHLT4gmOrvLL0mV4m7/yfemlX7H9cKXKePrTU7bAYTqcvTgtDwGHlZYjZBRCymKLKjFxJzXanSbxsFfs4dI38pkKpRtKsTWtw8t+mpVP55f/m1k+BxwfFyUHJ/2jpLofLmBQ8KSv1zIcK8Cch5D+OFLKjxdp0hQsx8j1pMHeywJMIr97t5UJ1rR5WIBG9Sk4WJ77fjVFbA9g8ZWng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.9; Mon, 18 Aug
 2025 09:33:33 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 09:33:32 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Mon, 18 Aug 2025 17:33:11 +0800
Subject: [PATCH v3 1/4] dt-bindings: thermal: qoriq: Add compatible string
 for imx93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx93_tmu-v3-1-35f79a86c072@nxp.com>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
In-Reply-To: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509601; l=1071;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=zg351AE45U2ybKcKR9yBvPxjvRtj3jttAEeWBzzf0jw=;
 b=WHLrk/4cueLAtlATvg8ichhRZnYjieR1W6GpRb7aKgU0lZnSIsN2o5+PyRi8Eyt4n1XssKLgv
 gyAtcPPEs/SCiYPf8NVZ/4s6zoloqydvb/ke+K+oUUteHBNxTW39qsx
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8642.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: da2c6899-6cc2-498b-b2dd-08ddde3a4c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1ovbmFvS0JlOERJbGhYMXBqREhTOGlIa2tBcE9iZEpGMjRsQkJURU9RVlJs?=
 =?utf-8?B?M3JXMmJqM2Iza3h2YUpKUFRkWkZ5ejBRV2k0ZlJIdHJ1a3dOUE8wN3I3U3p1?=
 =?utf-8?B?cjJ0TnFKSjNSSmNwMUhTeU5id2VuMGRSV1QzeDNaekpmUUtzZG5HbHRUOC92?=
 =?utf-8?B?bHRuS0p1U3QwS2F2Mm5qZU5SMko2ZXE0WkFaNXJ4RlduMWlXRUJpSHcrUXZU?=
 =?utf-8?B?V2cyT2Z6UGtCcHVWYWYrM0pRU3hxLys0SEhoeC9IS25jeE9Nak5QWVdRSnVh?=
 =?utf-8?B?djNwRmMyWHBhbXM0L0VWYzZLTVpsN1RlYnNyMldmV0xNb1hxNENqVzVKWm0x?=
 =?utf-8?B?WWhzd250aUhFdlNna1BBWmxISXhsWG5ZaVo4SG5rUGorVWd3SUhJZng0VU1Y?=
 =?utf-8?B?eWxscnpEbjlxM2xRaEIyZFRVc1F0SG92NjhERzk0bkVtZlB6YUNCRm1CYmd3?=
 =?utf-8?B?bTFCVnhFVm9mMjdtRUZQejBTTzZpbzNoUU1peHV5UElVMHNCUGQwajQzay9r?=
 =?utf-8?B?NFQ5NkhCa0tXQmFVTU9iT01MODh3ZzZ6bWZhWU43V0ZPSWJIRENzN2RQRkht?=
 =?utf-8?B?eGQvT3l5VGs1eXIvMWxDZGxKZGxpeHlrRk5BeTg1MUlmQ0F3ak9SNkVwMFM0?=
 =?utf-8?B?NVBVQ0tacW8wRjhCM2ZxUlI0K0dWdllVV0xLR05rclNacUpqZSs2dEtTUDR6?=
 =?utf-8?B?UVkrWDZCYVlsMHlCOXA4NWZ0V2JoZVozYVMwUlE2dy9XUVAwQURzdEdseVA1?=
 =?utf-8?B?cGt5ZUYvczFJK2QvZTBxN2pERlBTSXRoVHVGZVRuVTdES1dWa2hlbWhqRWl5?=
 =?utf-8?B?L0hhbVRLTFkwdzJlOFNOdnFzUDB5V2ZsV3BCSUVwMlJCbVg2ajMzK01EcWhO?=
 =?utf-8?B?Q2pHZVBsTnJoNzZmcmVtSk5qMmtsenFGalV3cTJwSE04MzdHYTJkcDVEcCtW?=
 =?utf-8?B?dk9ITkVaaFAwOUhLWUVuK00vdnNEREJPQi92WXpnUzkyU2RvMWVoRFZORzNj?=
 =?utf-8?B?cml0ZmJHWkdaaVZVVEYyaFBkNUVNdU1LaExaTng3dWxpUjRlMHAxM0dCQTUw?=
 =?utf-8?B?eVFETW1RNGp4OHlGcGxVMzRreU10Nzg4SFFVSlJJVlJZTGx3L0hVaEs4NHl1?=
 =?utf-8?B?MVBXVHlzbTJXSGhubXdkN3RHR2V3RTB6NWRyLzJ3K1BqVHcrVXB5YWg4Y1Fk?=
 =?utf-8?B?VE0wSElHaVY0bFh6Zzl5ZmFiY1hBSXFzd2c5Z1p3MHFCZzdveU5jUmg1SlFn?=
 =?utf-8?B?bzl2RlVFaFNlbldac1dCR05MZ3FFT2k5bGYyWm1WaU1yMmcwb2lpZWpiRDhW?=
 =?utf-8?B?NEp0czQ0UHJCOStBOXo4T2Z5UHBIeTErdkdGdTN5THhtVGpzZFZqT1VwVjA0?=
 =?utf-8?B?VlFaQjd1SlhUL21SODhYNk5oYXI3SXd4UHRjM2VaZ0xXNHR1ZndIYUtNcE5B?=
 =?utf-8?B?WjFHK05kdm9BYlpyUi9EdlRLNGRWOS9vVUE3N0tFS2RIVGY4RktndGNKTUlp?=
 =?utf-8?B?cGhzZ2ZxL3lUS2ZBSm1IaUsvVU9MWTBsZ254b2lUOXN3TjlqTHhZZSszUDUy?=
 =?utf-8?B?Z0JoMHN5c3NTdHJaYkFFU3dyOHdGbnhVMHdTQTdPQVY1elA1VDJWM21YZWg2?=
 =?utf-8?B?TkVkWHFYN3lBRGlsUkpNcjhDTGhnMllIOW9hTkNQTmpmQURJbFNmRHlkemhN?=
 =?utf-8?B?dmZoVUJDUjhGQ1JaZFFIU1Z4L1UzZExQc0V5bmRldUk1WndyVkpub2VUc0Y4?=
 =?utf-8?B?L1E3dGlaNmFPNTB3d29ia2Q4anh1L2VVeGR3Q0Z2dWFFK1FTdDJvcmVnVzdj?=
 =?utf-8?B?VDBtWFZNRTZzdmJoOERreXdDRDdLZDVybWQyWS9kR1YrVWY4Z0ZxNXFlR0dw?=
 =?utf-8?B?MUhmK3A5Ukphd3d0ci9FeWZTa0Jmdk54bWtsWUdkUlN2VkRjYUZ6U0RkZFVm?=
 =?utf-8?B?dGpud2tMRldDTlN3OEkzWm10TGdudWtEaHBzOE9FYitwanNEbjlLOHhrY3ht?=
 =?utf-8?Q?PQgZpfCdG1nfvjbpSSCrlS2Do3+7ps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHgxd2dVcndOZGVrT3UzaXlYYlFjUTR6N3pXbkZOQU9kWGtwb04xNmpqekZm?=
 =?utf-8?B?UnNGNnVZdlhNNDYxaGtZY2JtS212Q3pXejc2MHNPZFIraUhFWDdxTHM0bEFP?=
 =?utf-8?B?THM5ZGtPNFdtRm13eGErc0xTTmwyYVh0ZlEzSWVTeFo2K1hpbFdOM05nY1Yz?=
 =?utf-8?B?YkIyU3Erb2tuSlh6WlRUb2I1UWMyNFJtck5rcGdvajhyNU1hUHZEaTh2Q0ZZ?=
 =?utf-8?B?Uzh1ZXJGaStTZjhOb1pYWGJ5UWZWK2tQWUR2Y3p1b1ZwVTRMeWdESzAxUVAz?=
 =?utf-8?B?cUdYY2h6WTZXb0RkQWlHSVdzUGRVVlFuQk1ZdG5WT1NTTnR4TXRDa0pJV0RI?=
 =?utf-8?B?aVM5LzZ4YzlaTExRZ2pBbEJNdHdIRnlHNTR4eEdYVStmZjFyNDBldXc3OFZQ?=
 =?utf-8?B?TloxaFhDYWl4ZUpVV01HZlFwZFF6MG8rYmtBVGF0VXlLNWZlNkpidmtSay9Z?=
 =?utf-8?B?S2w3YkQyQlBmUm50ZDZWV1lEejYwekNKVjRFSng4U1p4WnNUWlpTVmNtdHdO?=
 =?utf-8?B?bE5hWnBmSlRsU2ZQNGRWVi8zbHRNMkJERkg0YStta1BaMGl6ZWtlenN6M1pS?=
 =?utf-8?B?eXF0ckJOQmN3NUNZaWQvWHhSWU56alZYckxqVWxEc3ZUdDVIVytpdFZhUDRt?=
 =?utf-8?B?aDdZT0RBWjRIdUREeC9nNzVlbnJsSVRyajlUaUhWbTBPanZlZ09LUVNsRUdz?=
 =?utf-8?B?VU1YK1pqdUJZYzhzWGlyVklxWWM4TGllZ0ZYU1JDaGM5Qk93ZHp6ejFGNkl3?=
 =?utf-8?B?czBHc2c3b2tpMmFSUGRrZVlCMUlRL2ZyWTR6WHRqMzBNM0I5NDZ3VXpteEUr?=
 =?utf-8?B?NGlZckZNT2xJWDFYS0E2a1Fpc0lkOWtEOHJleDFrZnp2MG15dVMxbjhsaVp3?=
 =?utf-8?B?OUdVKzNmRkgwbGpOQk81TUVPcmNTdDZWYUZML255eFFoWFNjM1JVdzBMT040?=
 =?utf-8?B?WDhQT25manRtOWVxOVR2Ukt0TXdGVUFBbmQ2MHlsYi92SVhSb0RqRGM2bEox?=
 =?utf-8?B?Yy9PQ2FvKzJsR1czbS9EbHM0U09QWW1UdkswUVpDVXZCUit5MlhTT1U5UDd2?=
 =?utf-8?B?a1FJTXhKZm1XN1UydW9MWkw5UHp0NjA5ZHFTVVNqSHpiYUdsYUhGVGcxRVU4?=
 =?utf-8?B?c20yRGtVOTdHM0NFVWJQTW9jT0I3UElWcXl2ZldMbWJkMVhKYURrN2Q2WkJo?=
 =?utf-8?B?eFZuNVhxSUdtRHNDREE2SnJOYkJCUnZEVldwdVVpMDk3aGJJWjN3b25vM2Ux?=
 =?utf-8?B?SytrQ0V5b3pQOVZWRU5wMUl6SWhUQVhlTkxhMGVEcjc1OGZnQWkvQ1ErSTI4?=
 =?utf-8?B?cUZNVzRRdUNaN1dWYUpTYXVObThhSUJKejdjYTRJRHpSNkE2bjlJUHdodXBt?=
 =?utf-8?B?V2NvVkR1UFJ5VjNtb3VmOUtFWnpuNVBJazhkUVZsOVlLUHAvWTlDZ2NkdkZ5?=
 =?utf-8?B?VGZhL2JNQTJabHhWSzdQcVI0ZEdWY2RMTXNYZmVlT1VYSTFiWHoxZzhGS0hp?=
 =?utf-8?B?dy9VTE56aHBDT0NwZUt3dXJTOFNqU09nUHNoSkNhZWt0OWczT1l0eSs5QU9U?=
 =?utf-8?B?ZlVtN3ltRTdnRm1pOWowNzF3b0pmczNQMHRLSmxyM2lpOUpVR2R0Wmg3anVO?=
 =?utf-8?B?Ky96V1MzaXB4MUdHYW83WVZ2TERqZU13R0lFdno1WVVBYUM5SEp3OWkvN0t3?=
 =?utf-8?B?S0Zacit0eGZXOGkwM1ZhcW1oTEVJRURIb3FMVUFqUVFoLytVTG1zYnkxWVR3?=
 =?utf-8?B?NnhXbVAvS3lSVEd3T1pQQlo1Nk5yTVBJbnVQNEdiNklqZnU4M1VLT0VmeXkw?=
 =?utf-8?B?ZGVvUkZ5Q2VOTHJPY1NLT1cyVlZLSVpRVVRuallhako5VHM4Q3I0ZGpYbFhI?=
 =?utf-8?B?cVNxNVNkTm1vVVkwZWVOT1BhMDZMdmZHamF2N0xkcGh5NU94MWRTOHg3M3h5?=
 =?utf-8?B?K1U1ZTh4RVRoalB0anBPdG9vQ0FRWkF4YS9POVFmelVHR21JTDA3L1R2OFJi?=
 =?utf-8?B?V0w2WkNHSWdNWHBIOGRXV3AzNzVXNVUvMFlMNmpuYmNKWUhWNG5GRDN6Smtw?=
 =?utf-8?B?eUM5ajhzeFZqNHNCcGVhay9nREkxeDhIZ0pWVmg0Q1ZBOXVlUWRoenNubUIy?=
 =?utf-8?Q?0G8Izv9bha+BLl9RyXfVItSTo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2c6899-6cc2-498b-b2dd-08ddde3a4c69
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:33:32.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGHhXnJYrG1ZmsRynJmCsJkkj+tS9ocSYJm3LcNnSKEcO9/7k8khcNKlK6pkBUbu/TlsuQUKBJMVtgzxopBoyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

Add i.MX93 compatible string 'fsl,imx93-tmu' because Thermal monitor
unit(TMU) on i.MX93 has differences with QorIQ platform and not fully
compatible with existing Platform, such as fsl,qoriq-tmu.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v3 changes:
  - refine the commit log
  - drop the compatible fallback support

 - v2 changes:
  - keep the enum
  - refine the commit log to use i.MX93 and QorIQ name
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index aa756dae512a2c6e3f0b6bb1ab4a65c01e373ea7..f3b136f5e1cba1fff7e90678d7e3d7ec3ddd25c1 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -25,6 +25,7 @@ properties:
     enum:
       - fsl,qoriq-tmu
       - fsl,imx8mq-tmu
+      - fsl,imx93-tmu
 
   reg:
     maxItems: 1

-- 
2.34.1


