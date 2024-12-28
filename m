Return-Path: <linux-pm+bounces-19794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCF09FD8A9
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83CA165916
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F106B86358;
	Sat, 28 Dec 2024 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k7BxjQzI"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BEA18E3F;
	Sat, 28 Dec 2024 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348563; cv=fail; b=UePioW2BcwDlVvEbp+stk/7mKtE6BY6Rz8D2GZipLaiOL8QNy7G57FvczvkKM5KuRhDlbmSn8f9DEe5UGAfDwJBHQd99N2/bvxl08/+XUj3y4AEoArd35bYT+BTJV7nqPTMNmnu/rpQ2uK4Gi+5GZIKsBD7s/8jl09rVQPvDNbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348563; c=relaxed/simple;
	bh=BO8Hwal6yUEtmatjGxTeE8CGMKa+r4910TYtu1OW9Cw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aTDNP2jYHGERp5Eu7fKxDUy3dQaTW3PWnXmUnLvTe+6KmyPwKLosSvF9zNgZ7YpzP7Z28aR4jYsZtUno+zZu/YLEdxgKiYZO3zjsWBtQnYxXYodMHag3Y/E3754Yw06yQgbQIE2uouz4aVW6PRIVkAVMBlQsjr0qHmei1Y8Ka5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=k7BxjQzI; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHXDjsC32wslnnL7m9PNn1c/gxKJLVmRX0zTPfuCv96TTCJ1jI7rvG+EjP9gt9a1OFDHXkv1YZ0Qz0ilSP1OtSEEY2+APOmrJpqCoyxn1fBOvYEHXZpxAGPhCL6RT/MBUYfJzgQSFRnTahMghOk1oN6O7IT5zC3Vcea+eO+gpF1K7pA/fE78XiCJPtgaWJqzcBMi2A7ibmu/6D3F33FQOPPwShx2hVD8Uyjr1cMGuDvbAKECUHPqMozaJKycfdudvk+KJaxW7mudIbzlZ5DnM3/HBGhX2sj+eF7Ti4LHXlDjxkaQn5a3BGrzC0B5pwIoAHBCCNrdyUlXa15wuaUGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQmjc+FMqh0dI0wNgt8HMjgVvX1TWtUXJ1FCgaXAoBk=;
 b=Arzkft/TW8P2dsrs3yCzTwNhOzT4Z8ZX7mBWZAGNdZERYI+Kh/6+09nop4ZEhiQpH8RnKrGXHI5wKM5R3pvJ6mQZ0qNgwGJYGc88FXWIaEoFHIZmC+owF4YR5LBNA2QyEkdYlsE739OptvRXXoTfdBu3ns4PCyqDsaA3Q84icEOIyv9DjV6p5g4Q4ytQFesAsOxX4Am2ftVE2DwGpx96RUVQcElEJzlLuJbcDw4uOdTeGpNFsmKj2AaKf5HsWCKK3J7xEbJhfjtFapCNqC08D5sD7IzKF5CLKlhL3ziGD2+F30dSgrNlEnM1HZgHzCABga9ehHccttOJoj1zWDKdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQmjc+FMqh0dI0wNgt8HMjgVvX1TWtUXJ1FCgaXAoBk=;
 b=k7BxjQzIHzaKczjRlj4gihW8gshonT1kqxqWI170XRTk9p4LDLpDV4vEK6tdiKa5IhvuDbnQmeAAlXJ4hWt1Z5iESGxwAPNiyNo1rfgoYxAzN0gr2pnhdl0iwnvIDHDeA60m4Gx9xhqss1Wz3UfEQUpgHA4lw3lLOJWCRbd3BfSeWqcgcjd0XUdaMAi4RRbAYcq3vjGM0hiECYkJ6nFix2XJIEBzuft461yluK8o+VBdvnRStzYBogStqemonUaqex1MUMRCfVeZDhcwOv5YIw+XUPB9+/LVLzJXpbz9b7oo7Pzw5a2zW/vQM6m4Wzvsvz4+zW7VtA4jSV/NG84NTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:44 +0800
Subject: [PATCH 08/12] rtc: ds1343: Use devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-8-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1119;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yYeVC601Fmqm3h8IRsE1e0gqqkwuyZ6uKwkA4brZ+6s=;
 b=M+cjMtBJIiSnSiefeaCL1kRXO2h+J0tucG3uxMJe5UH0vh+z5jUGXRMNrSqfIEAjK4/rPhH/h
 VZWDY4zP6vtDH5h+voA6RkrS/HIpVqO3Z1HUPMPZPVSPN3MNZ7k/Psb
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
X-MS-Office365-Filtering-Correlation-Id: a0ec955d-cc44-49f1-cf2c-08dd26dd2d77
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTIrUlVOQWRYNDI4ODk4cXExS2dKL25Hd0hwbERzRk8rWW5RU3ZlVStUbFpH?=
 =?utf-8?B?S0FjZlV4eFByczhNeld5RFBlMlVQZTduZHpVWnkwT21MamxKQU0vT0dLSnBs?=
 =?utf-8?B?emt4bWJnSnpBcjk0R1dCd0x2b21IUDhDRVp1SUErcks4QlJ2QnQ5bE1vQlZN?=
 =?utf-8?B?YWNrVVZJL0pYSnRVK3JjUjhlWkdKTFhvbEZMNXI2R3ZqSC9TM2dvQnVkcjUz?=
 =?utf-8?B?WGpUV1ZJUGVBak1ta3NjRERqVGhKTE83MFdIQ2MzekxMaURNaHFKcm9YYVlh?=
 =?utf-8?B?Vmh0aFBEcFY3NnFROFRoWnJCcnRLM250bExPRkNKajdjMS9qT2VLMFJ3SWpM?=
 =?utf-8?B?WC90ZVBLTzdGNC82Z25uQ2EvR3VPeEZIeDZhOTdhbFpFcFVYb1hIY1NtUkRQ?=
 =?utf-8?B?UUliSXd5U0Fnc2xiY0d1UmpXajRDemsya0RtVzlXelZBNWxLKy96aHV0eUdo?=
 =?utf-8?B?UUlMSFRpdUw1LzZId0NmTGNCZkV4eDdZQTBpVlQya3EvVWw1MldqMUFPNXlV?=
 =?utf-8?B?bTdCWlJ0REkwMXhOUXdDLytmOE5Ydkt6WE9hdHhOdU15MmNUOE40QU84NkNL?=
 =?utf-8?B?WWw1K3o3UnhSNTFBK0xhNXdNellQR3FWNkRrVE1EbVZrRDNJWnZUWDBCcWVy?=
 =?utf-8?B?Znk2SW5heGFFSkxFNUFtalNlMEFsQ1o0MkxGSm1GcTJieHdteVZ3N3dvSXFX?=
 =?utf-8?B?QWJEajBhOWsyWnFtdVdCWXJtaVhLY21tUDlCdzJnR2dBbUhrTVlOS1RkYkgy?=
 =?utf-8?B?TXE5T0dPYlhKTWlsWmM0eWJwbDZOamZLbHVtcXpHRTFyQVF6eFBZWno2OXhU?=
 =?utf-8?B?VnNZOFRWaHVJOG5mNlVmd1VvZ0J0eTdzQzdXc3JwTUVaOHpvWTYyQ2NnSUYy?=
 =?utf-8?B?dnEreFN5SlpiNXJOVHVIWFl6MldZYnArRGhwV1hLbGY3Nk90YWI0MERxcGdG?=
 =?utf-8?B?K3NoVnN1OG1naFRsQVhDV1Rqdkc5WmgreDRETHMrOHlDUklSTVBSYUMrRkpE?=
 =?utf-8?B?dk0zMGZyVWRsSGptdFNodTA5MFMvL1FmWDZyT2IvTkc3c1dESlg4RGFtRlMy?=
 =?utf-8?B?dDRVS2NIMlRHc1pzbmFJdFRUYzFUQU5PbSt0TEg3b0V2ZzZQdCtlQm1iODN1?=
 =?utf-8?B?SUZCZnVabm03WkFNY2U2UlpjM1BZNnJZZGlQa1JrMkJQcDgzcnBOeTdUeUFy?=
 =?utf-8?B?REc4QkFiOEFkbDRuNTVDOG50b3liTWppSjZ6ai9INUZ0UitPQWJDdkpYVjI3?=
 =?utf-8?B?Z1VNQzczSlJPU0FRT1o0YnMyQytFU1QvVnZXZlIzVzI5WS94RHpPcVVPV2Fj?=
 =?utf-8?B?N3JkRGo3YUtRbW9KeFpqdnQrWU41WHNEdUY5dDl5ODBYMFJqWlNQaVlGb1lO?=
 =?utf-8?B?d3J1dFhiN3BneTNDY09iTDE5dTNxb2thL1Npd2xIQk8rY09pUGVTOU4vVDV4?=
 =?utf-8?B?SDgwV04yL1MvblZvRXBmWEVyVThOalBoenVURUU3a0FMNXNKM2g1SU9HSkpW?=
 =?utf-8?B?b1ZGdk5SSnlVcFN2RTlVa0xPZjhvVzhHNGwxUTVxYVJOREM4d1hEUXBTWEpx?=
 =?utf-8?B?OHNmSGtpMnB3Z1NSakY1SThjMkpxbmpjayt0bFg2cTRSNVAwa0tFdHhNQWhq?=
 =?utf-8?B?bW5waTFDdVJFVkoxVUwvMFdNVnRQQ2x4c0svMkpXMk12V2p4NzRMYXJRVFVh?=
 =?utf-8?B?MTBqZmhDVjg0amdMdEdtQmNwK1I2c0RZT2FtM0VjR1NYdmJGUmtCaG5IR25w?=
 =?utf-8?B?L1ZSTlpsS2l6YWgvelVzNjd0aFlPcTAvSkE0bkRUM3VvUWVmaEJXVWRzUFJw?=
 =?utf-8?B?WEJCQUxHeUZlTlZsdEtWT2hxT0Y0VCs5TnVESGI3V05VQWNQQmVWejdZcmYw?=
 =?utf-8?B?S2VkbXNrdkh0bEVITjhFVmxMamg1c2Mwc3F3Q1FrTnJqeS9BQ0hPaG1wK0Zs?=
 =?utf-8?B?R0Zya1dUdUNTdVd4L0kxNGlhL2FDanpFdGVFSE9xTmFVSWEyZUpxUGJPeUhG?=
 =?utf-8?B?c0ZlLzRZVVVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUJOWVltdUc3QkpaNlNyNTdLdFR5dGJlT0JobmVPRTdTRldHdEFrRVBya0Vs?=
 =?utf-8?B?cFhvMlI0OVh6Ky9FTVNsQ0FqVkZ1c2hlL3FGa3paNEhhQmpmd2NNNlkydHI5?=
 =?utf-8?B?WmxrRnc1RHJKNWdUa0lDU2N5eWd5ZGxlalJlcjRUem4rZGxKY3JFNnpsclI3?=
 =?utf-8?B?K2R3eDNrQTBhN213enoyL1JNUUltTTZ4NjR1SWZjTUxXT0Z2b2xIVXFETGVa?=
 =?utf-8?B?OHBPdEJvNWhhN25kSVdjU1BFeHdSTE9zSTdQZzNGaHVtUkdlU0tCVnJGRmJz?=
 =?utf-8?B?NlU1aVZsZ2RzaUdHQXhrWGxoODRJeXFXVDR5OGU0L2E1TklmeWExbWNWdWZ6?=
 =?utf-8?B?RFlUVGIrQkxnbGdOUVQ1Mmdwd0d5d1hhZWlEcmFuL3ZEcmlZWmFQd1MrWFRm?=
 =?utf-8?B?THNXMDZGZkhhdC9IazJBSWN4NFpIeG5STHdpQmpkUFhnOGV4MmcycEFKaitI?=
 =?utf-8?B?MHhhSS9heUJlUVRVN3c2ZjdZZ29Sc1hLTi8zRGJNTzlyUHhxNkFjbktGYTJJ?=
 =?utf-8?B?TVVWSHRFcmtvYXc0eWtvYVlrUWZuTEZOc3Z6ZzE5Y1habzc2RnZkeENsQVEx?=
 =?utf-8?B?K1ZOVDlPMmw1dG55UG1BbWsvRDhkUytaVlQyQllkYkcwZW5ib3p4ZFFEVFo1?=
 =?utf-8?B?d3V6R1puWDVvSzFzNFRWbkdkZ0d6WHJBOWtBYVlTVXlQeis2U050VzlTZ1d1?=
 =?utf-8?B?MWdpYUN1V0U1U3duMlVWeFZkeDNMVkVOVnpNRnZkaXZra3FGV0RxZThodzcy?=
 =?utf-8?B?aGZTN0Y0UUhxL0JQVHd0Y3hsa0gvaFdEaVgwR0VtaGN2MThQeTZuNXVZRmFR?=
 =?utf-8?B?Z3locW5tdWJzZmFnSkZFa0lOcEhGenQ1YXdnYlFmbzQwb2VhenJ0Kzd5RWRz?=
 =?utf-8?B?alFmc0ZaTGFWVVZCaVh1UlJPYUdvY3ZEWElzQ0dXSGlYM3JiVm5NeFJaYlFn?=
 =?utf-8?B?U0VaekFpY0hqbis4TVJON2hyMFQ3dU50N2xoT2RRK2ZxNUw3bWwrbm9OS1V4?=
 =?utf-8?B?elZVVUh0c0FlUGFPc01KUFBQRW9QMEJ1bjhBOStMU2h0VklvZ0pjemtvRmlv?=
 =?utf-8?B?MHpIUHIyOWhBOUs2TmJ0RG5vd094Zno5RUhoQS9tMnNHck9iTnhUZzc1cXRx?=
 =?utf-8?B?MHVCSGJsNjVXcjNJZm5zNDZZakFwZHNZRk5GUUdxTlIrbUsxUmtxeitWOEpK?=
 =?utf-8?B?N3hFaEpPczd0R2lpMnMxNTIvVkVlUktsQzR1T2ZMdnJCUUFwNTJJeVBtREF6?=
 =?utf-8?B?WDZSa2NXK3kzTHlISzNYR204Q3NCclhVM3UvU0JldEFNcEcveWJ5b2p3YnlM?=
 =?utf-8?B?VnVwVkZoMjFYUGs5cFZ6dEVoQXN6b002N29oQUpZLzMvUlJaM25GNlB4emxZ?=
 =?utf-8?B?bHBWRWtBL1VOdEJJTlIzeUVwRVMzZE5IQkh3OHRHUmxkbm9CVTVCVXhSaUJJ?=
 =?utf-8?B?NVJFUkFNUDlvbTdRQUM0a1QzYkVQTlpNeEtTc3pxVndyQzd0OEdzVWpMbEM1?=
 =?utf-8?B?eFVBWkU5ck81TDlMbDdoTVJBZDFXeGhOb0VRR3FrRUI3dENtMG83YkpkR0dE?=
 =?utf-8?B?aThpOWRTQXNUTlRpaWdzQklCU2RaSDZJcDUvMFlYNjBXQTNlYmkrSVlqS0FJ?=
 =?utf-8?B?ZnNiNmZPVktsc3VpejB5OCtoemx0YUZNby93a2pzR0NuTFlBTGs4ZUoyd0dP?=
 =?utf-8?B?T2M2N01Ha0V3cHYweGRJLzhQdU9iUHFNOXZNNXlkMDhDaURBU1Q0M3poU1Nl?=
 =?utf-8?B?Sy9JbHBiOU8vSWZ5c0lPWXRyR2hHTDNMeDVjWXBQSFhCQnVQRXJQWGFkdXpB?=
 =?utf-8?B?TVNkRGdteVE0WWxIcnZuYW5YemFZLzhURS8rNkhQUEFGeXFoU3YvOEtzUWwz?=
 =?utf-8?B?bENDNVJQdjY5bzdqdHlpKzlSd2NzWVBUblJaZkVPYzNuVU9rNGNieXRQTThK?=
 =?utf-8?B?SVNBWnlXRGxyS0VybmtJdktELzh1UlpIMm5xeGZCdk5DSUFBUkplRWF5eGxO?=
 =?utf-8?B?ZEZkTjc4SzdSdVZxZnZRSUhwZHdVZGlHeHlTbU55bG9hTENGWUtNOE40cXY0?=
 =?utf-8?B?NzlRT3NOSVZ1dW95MEM1M2xFWmw5a1RVcUtYUUNSVHJlSzlHUldtblRudHYz?=
 =?utf-8?Q?kUiFdGBJlb6gcE/RosWJdxGKm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ec955d-cc44-49f1-cf2c-08dd26dd2d77
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:54.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwvKbv5GosjWqZa2YcMCtdodJ0R1g3KlLznc3H50OvVOScRvG5ZLdmEa57bndJs7fh1Hwkm/eVx50B3Oq2Iq/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-ds1343.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index ed5a6ba89a3eeb2a0b9d6dea3c8b3d40aa2cf317..aa9500791b7e0300b150bd654b69c74f3e5e6e6b 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -427,18 +427,13 @@ static int ds1343_probe(struct spi_device *spi)
 				"unable to request irq for rtc ds1343\n");
 		} else {
 			device_init_wakeup(&spi->dev, true);
-			dev_pm_set_wake_irq(&spi->dev, spi->irq);
+			devm_pm_set_wake_irq(&spi->dev, spi->irq);
 		}
 	}
 
 	return 0;
 }
 
-static void ds1343_remove(struct spi_device *spi)
-{
-	dev_pm_clear_wake_irq(&spi->dev);
-}
-
 #ifdef CONFIG_PM_SLEEP
 
 static int ds1343_suspend(struct device *dev)
@@ -471,7 +466,6 @@ static struct spi_driver ds1343_driver = {
 		.pm = &ds1343_pm,
 	},
 	.probe = ds1343_probe,
-	.remove = ds1343_remove,
 	.id_table = ds1343_id,
 };
 

-- 
2.37.1


