Return-Path: <linux-pm+bounces-19796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E8F9FD8B3
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B89297A05B9
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35C142659;
	Sat, 28 Dec 2024 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uG0Ep0v+"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530513B280;
	Sat, 28 Dec 2024 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348573; cv=fail; b=Xv57axFwenmWc4xlN82Ph/YeIFcylA+BCH/DKMA17Y9TnkS3hnYFPTm6+Gng5e9EFT44mHvnmzIKD6CmeASfRixetbdvhwZSbjxDXlS9pPPTy2rg2ylrglWacjJ81NDm12SuS7XCFBApyGM7n1x+jEr5JAV7vteLzZYZhxDymFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348573; c=relaxed/simple;
	bh=OXuOFfUQAHPfSnRmpga8T/NGjVQFp8ksF2HNRG5PdzQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iee/Rix9YQ2VH7C7AhnDZ8plgwJfzNYNLL3olGjeV/v2nGCDxEW/I1UeL9kktO4LeEfm/1phvHfBJXgdCgFuyd3irk5URb7QebZ8uuv1ZxQJ6vUJCTsEH0oAJN1VDt+Qh78RApsZUBdUoNECwa2Uyl1flxYfNqpuLz6e45348qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uG0Ep0v+; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ6gdXIPLfjHHP2y67U3hO6zvTNAt/t+5ja0q1RDQtY8T7ZVo5AnpHuMyajXYxA9TSffBjaZMdjzP5G68/3cLvIg+HPibX/IuLpWVCGSldWjizgTuglhQrBElvb2Sa1gYdwSjlY2OS1gd4qQhKRUwI88vUEKWcArbDl/KCOuNw/PdAweHf0tSkkdVt0dmXQgZOQatWZ3xtRqdpvOnsXBnxLDKd61aP+OFyc/BkcEMam0FVTrrcEpdq2IUZgvFU00JcJW/7AqGj1+rIuhguhIHtK/7UlXz5repTzsVaKYJIouyozGQQGP14kGO6V5qAj10yUx0gpk54FpDCZUUj1q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlobrdkVfX/38MVJCt8Iq+/b3rUpD0WjleMSu5zbIM4=;
 b=cbKKdlqxlu4F+RwOV3FNhP2MVOYZOvPxDjpQ28hAG9hPT8htRhfHHWoeJ7sODHCo7dKEtvG+UgHqzIU3mvc5VYWOTcvLr6vBA1yPzV/UkkhYWezIInGWlc4RHJfn3Ep6gDIpDnIjvjJ0s/hhBFKGIRB5pdNIRZE0e37ECLcJQwwNJL1kbQbsTTue2GlU2VSfi/JpYhInFSmMzdil7fbrZHwiDOmAeCAMbvp/oivX44uPSFIzvHBqvKNoVeAaEzKrk1j+pg++vhpJblZFrPF2Q1uC224PgpFUkI5b4MqHsLk6So2Gi86N848+9Dq7JkhKwi77/yI5n/VC9Wt5A+RUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlobrdkVfX/38MVJCt8Iq+/b3rUpD0WjleMSu5zbIM4=;
 b=uG0Ep0v+6QTXMa1RdhceJXxdlnGtB9jFpcBl32bUXTUafyTVd2k9XQ7O6ti8rtqw8p/i6hV3UXWrDDRZ/OilXbmmk9JyX7lxYFYECbI+o+m4uxZJvrx55Omeygok35IO9gYuZ12UrT4cX5lm0htNsiz7d5r5TvU7VgCw2BpRoJPP6TzjQVFy4ZnzB8kWVSk8ISvYneurx23imGwUWrE2I6lNefwVmtLlHYz1QnZMbVsVZOruvlXQqVlpwTd+sBxFt017IL8sr3GXgvfL6edpPZogqUeK6hd619vnCvkRJo/u1HwFF7caP7jFwxVxX2t64jesT1d4p/uf542U/s6T0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:16:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:16:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:46 +0800
Subject: [PATCH 10/12] rtc: ab8500: Use resource managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-10-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1542;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=AVqWXSH+9LxOuTXtwUAoRCUt6CUhlH/6QudqZPFpQdY=;
 b=RhDPsrgbN6Cz12kt87YwDpCKRz6gWnKaN3fVCGjJ3KW5nlRvnx/OLvu3OgFY4hlgaM1G+FH9v
 hEr8JDrMVBOCCgZCVbKmi6wbwHJhfmvFo2Vahlk48PpOT/3Z0XdrW46
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
X-MS-Office365-Filtering-Correlation-Id: 2ba8a545-524a-4099-9954-08dd26dd33a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGFydXppQ1RXQWFlcE9HblNBczRzZUJKeFFRMUQrRFpWemE3Y05lb25Wc2Mw?=
 =?utf-8?B?NkIzL3ZBNHRQcW1JdFRLck9uMDFwSmRFTEs1K0NZTHNBOTJoUGdhMmJGekZZ?=
 =?utf-8?B?VFR6NVpRR29PQVM1dnRsYmV4eFBMNnF0TFRJazN6eWNNcmZtcFRqRHZUcnZv?=
 =?utf-8?B?TEFoSlMrQUFVTWt2aG1tV3crZmxXcW5ZVTFzZzJYWnpLcGJrRThnOEptdzlo?=
 =?utf-8?B?QTRiRUhVenFPUFV1T1ByZkkvdnRCd3h0YzBCa0hSMm84S0tkQnNNcnZaZjVC?=
 =?utf-8?B?bkFiTWg2ZkR4dUFEQWtsWXA3Wk5udTRKbTNhMXJxQytJNDgrUXBIVDk5b0ZK?=
 =?utf-8?B?amVrNjh3Y0Q4Z0dqRjk0OFlVRkZoSHBGUWNHS05kN1ROSG5JbkJRVVNVdjVT?=
 =?utf-8?B?RFhLaTU4WkthTEdDekxrZUxvckN3Q2xBWlFPMDhGMmVuSk1VZVRvTGY4dzRl?=
 =?utf-8?B?bVl4MUUrMUV4UndGUGpmemFUQ3lRbGJYc0htcEhrOElYU0VkUFdFd2owTFhv?=
 =?utf-8?B?MVJZdWNqdFFhVnZuaFJpUHZEUGJyZzFmd3AvS24wc21tQkRPNHZiM0VGT29t?=
 =?utf-8?B?OG1JQTZnajdYNXhYcFZiNzR1STE0TkE4UTB5V0N2WGhmVmJGVE1xaHFOT0N1?=
 =?utf-8?B?L3RLSGVvR1pHVEVPRHQ1VVRlZ1ByVGVHRVc2RXdKd0oza1B2ZGFwcXd0TEFi?=
 =?utf-8?B?UU92WDZhTHY0RWVGK1lScEFDUXRmTlZtalorNnhyKzZYWGU2ZjA3dVdibGpK?=
 =?utf-8?B?Ky94ckFzckFOTUhBbTlGVS93bHh1SDNYSDczMCt5dTJDa0ZIRUVQYUhxRlJF?=
 =?utf-8?B?R0IyYmpxSDk2bVhzcmxnL2U5VmdNN28yZUFFZlAxNnBtYTNrNDdzVGRLeTFw?=
 =?utf-8?B?cTJwU2NKek5BaWErQUZ1b3F2WWN2QzZiM043VWc5THM1aUI5QnJ4UndhU3VF?=
 =?utf-8?B?VHlWWUxXOTU1Wk43SUUyS3pSOHJGVDVMbHBNMW5HUEI4bnI0ZGZ4OFRESzJP?=
 =?utf-8?B?UnVhMi8rbEdIVjMrNWZaRGZsZk1Lckk4eVB0ZVZqYXUrcjdkejZyK3ZJQSsy?=
 =?utf-8?B?Y2dGd1JBNE5GTGs4STZvVW81MG1ZOVQ4YXp0QWtpK3pzMlZaZm1QNjFVZFN5?=
 =?utf-8?B?WnVUWGorVFRHRXZEZHdObXdhK24rK2E5YU94dVNKMUxKSktmT2kzdzZnN2t1?=
 =?utf-8?B?UXRZVG9JRTlwWDdiazJtcjBjODlJTk1OL2w4aXhVZW5hZ0xCc2MyUVpuWVpF?=
 =?utf-8?B?N0dra3VxcERKbzVUSCtLQnRVaThxeGNvdkxzRE5YZm13UFNBK2lQOXBVWlhq?=
 =?utf-8?B?UHRQZkxMWVlMOGFlK1M4ZWt4MXJWUGRSc1pFeU1yZGtQcmwyNjZCZGxCUFVP?=
 =?utf-8?B?RmJpcmZJcTJMd1dpUFdCREVPc1VRQnRQSzRoYjlZMkpibGhkNlQxcm1xbFAy?=
 =?utf-8?B?WHZlZG5nVk4yVjFIZEdDOUtRK3NFU2svV0RtZGFXcDM1L3l5VVo2LzlhbkV0?=
 =?utf-8?B?RGszcGVnZjdLd05ZOHoyTlNMUjhnQ09IVnFUTXZxMHBsbmhWUXVKeUtoWUxS?=
 =?utf-8?B?WXhsdVdVK0RWSkxydXJMSUxiR25CSUtJcFJKZ2FtNW81QkVob3BERXhyN3dQ?=
 =?utf-8?B?WEIwSktmNGdFcHFNSVNzUDhZUWNZaGpKZ2NjRHFmVWdzWjNSK3ptamVOQ2Qv?=
 =?utf-8?B?RTBBVjFNMmZTbzJsSGRHYXZKYUl1ZlJHYWxVQlltRVVpaGJsZFFpRWhGYjJQ?=
 =?utf-8?B?cUJOWmJzT1Y2L0tOVlJIS1ArbmZFVkU5clBuTTRMQ1hhbUdVVEM1aWVyZVds?=
 =?utf-8?B?bFU4WFFGWmI1UzFEUGFxalQ2dUFXV3FieStjdnRQejZud3pKWjBSK1VEMHJ6?=
 =?utf-8?B?T0wyYTN0MEZid01mL3pCNWczV3dZSzVTS2c3cVZ5bWNVT0ZYa3JHbloxQ3pu?=
 =?utf-8?B?ZWRTZ2dvcEZLQlBEWTZjbnNpQ1hmSGlpR0J5QzhjU29QTTJMWHllSDlQSENt?=
 =?utf-8?B?QkllWm9aNU93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmhTZFNXOHlLQmJUN3p2SVhjSmNKZnV3Y1ExcVU4ZTFMcWNrZjY1SEU5dkNC?=
 =?utf-8?B?bkhhUzF1RC8wMGN1WVAySndUVzVsT091aEM1YVUrSDZLUFZhSTZobEQ3QVBS?=
 =?utf-8?B?SFA4S1RVK2dkZVJMaGxjRTEyczhlYndOQU5TUlpXa3c2MmlSNjBOTGJWQWhU?=
 =?utf-8?B?YzZBbE9zeEo2T0U3R3dPaU10OHZKNERlK1ZSdzdmRWpWa0xmT08xbUNNOWQ3?=
 =?utf-8?B?a29mMzY0M2Noc1N0MUJTamJYSDl3eTlWNjIzaGpxT0ZoSEthVm5SQUMzbW1B?=
 =?utf-8?B?ZXNjQ29zYVZabVhTVWVoTHQydHljTHlYQ24wR0FOellDOE13WERQNHA1RUk3?=
 =?utf-8?B?RlFvWloreDMra2dZbXFGd2gzY09vVEhSemRpMDFwdWFjdUovU1liK3QyZFNz?=
 =?utf-8?B?QjhBME11Tm1ZdWIzTUxHMHlQdCs4OEc4UzdkVzBGeW5DZkhUZ0FXNUxNSjZa?=
 =?utf-8?B?emRBQ05CQ1A4Z3YvanV4U2o4SXBJeFVYZTNmZklJVkhiY3lmWXpsRXFyQmZo?=
 =?utf-8?B?ZzhaaVNmMkp5TW9mN3ZaUjZ6WnpKekxIWExSTU44akNKZUlHTGtKVjg4ZDM1?=
 =?utf-8?B?VFBsTTM4RnorK21NY2FRQzJ2NnYyUVVNdXVSZk9RcjdEOHJEekg4aWFnR2Qw?=
 =?utf-8?B?K3d5ZlJoRnBrdnNJakh4dk52Q2pEcm5ZZSt5eXlMRnhacmJ1WEtKaWxEWjVT?=
 =?utf-8?B?VEhPaCtNT1VxUGlreGw3UTYva1pmVngyUDdzQU11YUtYY1hScDlERXZYeWV5?=
 =?utf-8?B?MXVMK08wTG5uY2dXckVVbXFxTW1TYkN2RDk4SXZSUGZnaUUvRUV0NWFha0Zv?=
 =?utf-8?B?dzRPN2hRZm1LQk9CQzdXa1VoOVQ3ZzNPc3pHdGRWUDBMb0tFdWVSeC9lOGhn?=
 =?utf-8?B?bGVDMm4wQ2UwMUdYMUo1OFFrS0FOR2xVVkFTY0tvei95bnZOVDVyckhSS2p2?=
 =?utf-8?B?d2tSZCsxZ2FiVWFINmp5cnBaUmRSVTJUNXVZUXFzOENxNGx3K0xzNTBraUp4?=
 =?utf-8?B?bCtFSjlCdk1CamdmTmYrQWFGb2hUOXBIUmVjd0RhZVp6RGNtdm05MzZpWlVx?=
 =?utf-8?B?T2ZTYTZ5SWNiVWZaNC81d2dFYlV2bE1sUHdFZEY5UHRjSnNZUGY2MXB6MTAw?=
 =?utf-8?B?bXJITGdFTTM0T1dNcmJMT01FTUxwWjJwblhNWk1oMU5RRE41NlZsYXhmUjhY?=
 =?utf-8?B?NnM5WGRLaG9zNm1VZmRqdUN6bkdBekVCL0JIWHlRTzVCbW1hK3Y5SkdzaVd4?=
 =?utf-8?B?R1RtM1ZPSE93c2ljTk5YeEtIVmM1Z25GLzFZVTBvejBPemcrZUk4dWtwV3J5?=
 =?utf-8?B?REc1emVZaHM5eGN6U0FxR05EVUYzTFdpRUZmM1g4L2tSb0w4eCtjOVl2dis5?=
 =?utf-8?B?UnQvK0N1VkpBQVo5RmdLZHRuOEkvUUcvWWJVWG1udTRoVitBTWtNb0ZKem5Z?=
 =?utf-8?B?M2xBVHBZSVlxV1pmZmNsT2JWU3RoNTM0cERlRFF4RDJON0M1Z29laUNpTmhv?=
 =?utf-8?B?UlMvcDhJRUErYWoxWHFkWmRiL3N6N1pRR1lvNzd1Yk12bmExdEYraS8rRHNU?=
 =?utf-8?B?QWQxSGFKR29Mb3ZXeVgyeE5lNG9YTGdJc0EyVHd6MUpsa1FSVTdTWDU1VEd5?=
 =?utf-8?B?dmVlSnhlVVNqRzFjZzdHQmVEL3dRcXAyaDF3bnhtdG4rMVVFNWdJS2JLeWw4?=
 =?utf-8?B?MUJCd2FMdXVCSEc0U0YydWh6eVVzdHJDSUpuQ0FRb1ZaRkYyVG0vRkNPOEFU?=
 =?utf-8?B?akpleEx1SHNkaFN1cjBlWmgzQXd4RG95RWlRR1Zab2svTFRQOVViTDVzMVhj?=
 =?utf-8?B?UGIwK3BLSDJpRGN3UWR5ci9ZMDUrbkRsRWczbmRGNWQ5cUhGM1dSQ0k4SXR1?=
 =?utf-8?B?VjJBc2Q5NWl5NGkwNVVqd0p5RUtWOXJhMTV2TDBNbnRiVGRkcVMyNnhNMllq?=
 =?utf-8?B?aGQ1T3FKaGNCTStndzNrV3ZkVGlkWEhEbHBSTy93RzBiMjUxUnlIUFFCdkZs?=
 =?utf-8?B?T1JpV0RQRkhlUVhSQkNVbWVDcnIzd2k3bldiMWlPa29hUk1uaFF1Y0R0cTJ4?=
 =?utf-8?B?aTRlSldQdGR5RmhMdWs0bnpIVG9MTUsyc0FmYmJJZzZZY3YzYmQxb0pDMklt?=
 =?utf-8?Q?0/Zi/r77AnEubdYb6zF4c6fKw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8a545-524a-4099-9954-08dd26dd33a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:16:05.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKaSLTWiob+/xhXPj8ShaJViObRyPTr6S09bGVRj0rjn9e3njfuuP7OgrpdyUqGfKDiz1EKdAgxuKrtMPmmnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
error handling code and 'driver.remove()' hook.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-ab8500.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 2dcda96f4a8ef727514c751322b84d8d2b382b75..ed2b6b8bb3bf8f99fef9f8bee9676f71f8a86d2a 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -361,7 +361,7 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
+	devm_device_init_wakeup(&pdev->dev);
 
 	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
@@ -375,7 +375,7 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	dev_pm_set_wake_irq(&pdev->dev, irq);
+	devm_pm_set_wake_irq(&pdev->dev, irq);
 	platform_set_drvdata(pdev, rtc);
 
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
@@ -392,18 +392,11 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(rtc);
 }
 
-static void ab8500_rtc_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-}
-
 static struct platform_driver ab8500_rtc_driver = {
 	.driver = {
 		.name = "ab8500-rtc",
 	},
 	.probe	= ab8500_rtc_probe,
-	.remove = ab8500_rtc_remove,
 	.id_table = ab85xx_rtc_ids,
 };
 

-- 
2.37.1


