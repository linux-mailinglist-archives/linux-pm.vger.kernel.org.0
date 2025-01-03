Return-Path: <linux-pm+bounces-19925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16880A005E0
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAD3163392
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426B1CD1FB;
	Fri,  3 Jan 2025 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GmN2+5E0"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013039.outbound.protection.outlook.com [52.101.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD21CBE87;
	Fri,  3 Jan 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893727; cv=fail; b=ajyXR0wWlTCcQ//3rovjtqw2zlBUQD9eDEivPzN/+l6LN8VyDcoOWg6Zp4rOEkG22ugAnYP/4zdpVu2rzn5EeySDtrDVPCVpADyR98pLYvaEW96zWMGqL/x44blY+VkdH9Yi1MzIBHhG1mkjfxFcFJdmCGHpIJaAD7LbzVo+G2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893727; c=relaxed/simple;
	bh=21OytqN+Lvuz+Aiwugq+YhJaD4KUmHT3/WIN/kIWcME=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=EIV9r+QkdnGeJyyKi41+oNncv70gxM+qCS0xXL3GsVVRHvmjscvOOJ4JrCSJnSyoK9JZLhdI0Kn2286UcaK5uqpRU14defxQI/9+k79Fg3myW+H/YJ8ChyErXpbKsydZnKOktym20RxTgTVF1jykvBtkhIFHvfkmvsPdMtT5OTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GmN2+5E0; arc=fail smtp.client-ip=52.101.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPK1ey+G0dUS6DfB015Mk3p+AyZM0HBtmPXYuq+Ut96oW6pmyAoq4/Gslj+9bHo4+IT8Z4ekv5WbulEwZULnzQITfxGokaRFyd+VtgT57m1+YLjhziWtGDX1Wj//Bf9ZXROuwx7lWQc2mJ51vAZMQ1iqGpHkAc1MkVI9eDkGW+NdYNf/673bJTCseGFLshORd7uAxQe3Vy227gOro44cRyinrLYYogzmNLVk64hVR/KRuEXDdTOT98bpTKfDMvFrzd3vZESJrT3bMXt18WyxBWOn+dz7Wtx7RAUBA42aUnOFwLIibHI2x+XSa3Ak0A9vSuP7BEkEoglQjGywbg8GsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNqfGJVXZeptY4nzSxZIb3/pLplzppPzMKDPfFSUggA=;
 b=kegOWFDvfgFe+B250LM7ucv7DEJbVU1QVPY4rDJXtBLF0PBnSSVUvowvRZ0HqHQ1Y2xnAUnuulYzzs8Ngru6YgT+oBfUis+IzFivLecUPMfeaM/vWiWCO6oSjPoaMcRGUr+QvS5vkBd2rGFFrIhBvfOmrPb2XyOnyu3cBFYZ76EWsgUpaGR7XiMz7BQFjEsRLqA/ciM8iIwcV638jxNzd/WxVydhUxx1TCdv82YtkYUwnxMgYSON1ZW1etLN60K6Ry6W39uHxXIlS2O+IpojCkA21PhDTm1WC+sRIKTyaBdSfZCXalDKYeSRtpA2g0tDc64ERRlxR0sC2m0phAYodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNqfGJVXZeptY4nzSxZIb3/pLplzppPzMKDPfFSUggA=;
 b=GmN2+5E0eMRobQUaBShdi84iQgm6L2p/ph4ZZGhGb5jET+NIgSGGQetMVhE7b62M9BHEFfzkjZgG1GVUHCFHV1tWNttbuHd/IiEuRlEA/2UucEaE2zNMlK6VGklA9x7F+hV6K8MkP/ndAwRRgtfcAkrHCKE7e5WW0lduR4ZDjL25dpC+9RPZGaLkaRJer7x4olCdx59Hesd6l436xXpcMemuSfQnqHW4MBeNDlwEVD8nhjVW+Sfo3YqoIZdFRVMlL97puGICSr6NThBcDkikaSGr506u/oQ4+DNvpy1vvOn1qe6fJnA7BXDmoLdVmvnR4MvjCyFMmvdJFklfreeb3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:41:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:41:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/12] pm: Introduce devm_pm_set_wake_irq
Date: Fri, 03 Jan 2025 16:41:12 +0800
Message-Id: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKiid2cC/0XM0QrCIBTG8VcZ5zpDRebWVe8RI0zP2iHSpWGL4
 btng+jy//HxWyFhJExwaFaImClR8DXkrgE7GX9FRq42SC6VkFKzl7nhmeKDXdrOtVw513MJ9T5
 HHGnZqNNQe6L0DPG9yVl81x/S/ZEsGGe8t6M1Wlun9NEv896GOwyllA/6zE9lngAAAA==
X-Change-ID: 20241227-wake_irq-b68d604dd902
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=2631;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=21OytqN+Lvuz+Aiwugq+YhJaD4KUmHT3/WIN/kIWcME=;
 b=ivy+0PDrWidXD2RpDv4THDGqs0kOBB+laHr78CWynspwL8zT+Kss9TE0UwF4bxp5Mqcjlb2o1
 b0sT2CspdBbDLBIJn2Hhs7uHOp3mEwFiMf9wGZCBYqtlkJFzvsI1WWq
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 88747f46-f103-4c4e-9cb7-08dd2bd27ae9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VS9JZEJzdWJwcFBKa0pndTYwbFVZNjVqaGt2Nm84SVI3NGUxaE1jVXF5UnNS?=
 =?utf-8?B?TkVLMjJnV2ZMWUtvRjY1c2IveWJxWEwwTS9JSURPL0tCRUlQZFpxQ1JadGV1?=
 =?utf-8?B?NG1SblpOejZHVlM5N3dDcWtMM0lhekpJTlRjVzRlaDFBbDVoaDJsTEFmODNQ?=
 =?utf-8?B?bkwzR1hDcVVqdXZka0lWclBnd09LS1JxN3hSMlNlS2NZVlBoTzZBQjdLWDhW?=
 =?utf-8?B?SFdmS0NFbTVrUERkT2cyY2hVWmZheE5Ta3NLanU4K0xJcEp6d1lYS1AvcEV3?=
 =?utf-8?B?NUZVdUR0OE1VTTU4aE9iZWxvT1RZaHMyYnRrTDA2aU5qRUJjZldReG5qNG1w?=
 =?utf-8?B?ek50ZENkRXJpMlBZYjRDd1piOGZScFlzamNaM3pLbDVpakZsWDI0N2ljbmdF?=
 =?utf-8?B?cDlpSUU3djlpL291L0tYNjhGUlVuUmlGQzdCOW0rZUh5Z0RSZWcxZFhabXVR?=
 =?utf-8?B?ZkdtclpHb3A0aGRFd016bjZMeTFmVDZTU0ZpUm9lK05peDA0TUFBQTBpenlP?=
 =?utf-8?B?cy84MnAvUDlOd3hxZ1pGbFJRSlB2K0I5N05tUmVNZ3pZQ2R6YXZ1bTBaTnly?=
 =?utf-8?B?YXU3bzJHeU1mSmdCQVd6ZkFZQUJJSDZiejZpUEJicWVVcUQwMG1NekxzT3hl?=
 =?utf-8?B?VjBxUVBKSXgvS2Z0ZG1SL0FRNmdhREdQSDNTK1N2aEFKZFhTV1RUVmxINlp4?=
 =?utf-8?B?dnU5V3VPUmRtQ3R6RVREc0hnd2tPZVNkcWRQTUJucThneDZPYnpZaVkveFkw?=
 =?utf-8?B?ZGlaT09xcUwrRzltRzl3cVUzWWpSekI0dGRaMzY5NW1NR3ZZbXJ4R3F1dUJG?=
 =?utf-8?B?eWwxYVNMNWk4MW1YYkN5ejBidWZJZy9MdG05M1dqRFVnL2hOWnFDUnZ6eDFS?=
 =?utf-8?B?bFRnN3hWdm83WU9RdjRIVWpoVGtkL3VIZUc5ZlpHaGRIemlzUS9KUHcvSStM?=
 =?utf-8?B?aHJ3Lzdyd3hoanlrbHlzYXl3SEluVG50QXpudTkrZ1EwWjlJQm1mVnh5Zkpl?=
 =?utf-8?B?bnp4SlErMVgrN0JrYUErVWVIRCtuZWVjZ3lObWQ3bVdmQXRJV0owZ09Oc1hm?=
 =?utf-8?B?VnBLR3I1NWtiRG5EREkySWo5TUZxVVliK2J0eDEzbElPTTFFZWswSmpqQTFm?=
 =?utf-8?B?UmtSaXFZeHFqb1ZGMkZDVmJVMWdETlZzdU5CYlhFQjlRRjZubVRnNGVkVHdP?=
 =?utf-8?B?Sm9CbFRLMG5VeWhVVVBOb2hLdGNpSnh5Mzl2cmdVOGpWSjB1OGYzVy83bkg2?=
 =?utf-8?B?OXRodFRMZEFHWll4bE1hd0QwOEpXenVYc21Ob1laYjVMNGRydFltV2Fvclhy?=
 =?utf-8?B?bWVHZzFnVWM0eEx2empwMW44NkNxYXdXRXEyMWk2MDJFU3dybjhVNUpSbWt0?=
 =?utf-8?B?WjFnb2wrRnZTMzhYcEF6eDNYa2JoWm5HZ3dFaDN2VG9XQkR2ckVqZ3VDL3Fj?=
 =?utf-8?B?amZQdXB3RUl2WHRhZzV2ODA0N0ovVEJGb3JrKy9PR3J2WVJyQm53T3dYTWox?=
 =?utf-8?B?R0NCOGZZaWVPbUFhY2s3N1U0ZGNVTkxQV3A0QURBRGhjN0NJU3pUMElvOUx3?=
 =?utf-8?B?bEVmRW91L05CaE1wdytLNDRIaU5sZU54czJrTmRjVmJYelAxd1FKMDRWRUFP?=
 =?utf-8?B?R2VjRkVaczVFN3R3QlgzOUxlTjRzQkpLdmxESlVqUW9QR25VN1VtbEVSWVhh?=
 =?utf-8?B?M3B4WnhKT3RrWFZEcUdFaThLZkJqOGYwQS91WDc5SW9CMjJBOXRoK1MzR0hl?=
 =?utf-8?B?WGYwd3p3MEs2Z0YvU0RXM3FNS0xHT2lvV0JNS241VnluQzJMTFlnZExDN3pJ?=
 =?utf-8?B?ZktyQXNDc1FoS0h2QUFRTmIrbUFDVzZ0VE1UZUsvTDhoQkcvRlo4djU1ZW5B?=
 =?utf-8?B?ZzlXU0wxcWlPbk5JdmR0WmFYNnA4SEtTYzlwUjJBWk53VGdtSGRRUWRHcE44?=
 =?utf-8?B?KzlyVzZVRTVqUVNvN0RXMU0rVlI3dEFUMFp4SWZQdVFWV2o2Zk5rZDloOExM?=
 =?utf-8?Q?EyJ96FEV6nHWWs7iCOxNOxpL/MGKEE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGdoSjJVa1NXQytWTWdSK1V3U1F6M1VPYytHR21LRWpYNXY2Tmk0aFdoVU5s?=
 =?utf-8?B?dXlVekUrd3UvdnRrMWdXVXp4WmFhYUswSCtxNEg4bm5odndCY0pFMzVlQkJQ?=
 =?utf-8?B?cG14WGpkNXRJZnRpdFhqQitPcDd6aFVkNTRxOUtIOHFaZC9jMDBEdW5TeUMy?=
 =?utf-8?B?R3BlWjR6b05UQ25qZnFQTzNFNG1iZnBKMStPZDROeVhqZ2c5cXFUOWUzcTVT?=
 =?utf-8?B?cHA4REtwRldpNmZsMWd0cWcweCtab0FVUktYMUxxNlBtSFFFcm9NcU9McmI4?=
 =?utf-8?B?OC92YnRIOCs3M1V1eFpJWlNHMnJDMkVGOEZEaVFtUTMwUFVWekNYeEY4ZVJ5?=
 =?utf-8?B?d0h1VGNxM2lmMUxqc2ovaDMzblpGZkkxQjFXdTZqS0l0QkxoSWgwbmhhSlF4?=
 =?utf-8?B?aVRnMDlDeXBONzR2WXR2aVljTXdpeHBiYy9DNWF5cTJoOFFIbWJkaGdONEU4?=
 =?utf-8?B?azJyUVlEWk83UVhoT3RHZ01tQk1odUdFcDQ5U1d5MzRxc3p6UFdxRGhrY3NU?=
 =?utf-8?B?NlN0RWhCS2xmWEZ0bXNNY1NhNS90K0ZGaXB3YTdKSFlqVzlhQjdOcW1jUSth?=
 =?utf-8?B?Y0JSODhXamFRQ0ZzcjdyZlF4Qmd0NDQ1S3h1YlhHaGZTY2V4eEVrSTFtejAz?=
 =?utf-8?B?TlViTEw5UTdlRmZmU1BnZ2h5dmVoeGdSaHlYM1RnbHV5UEx0SVN0WG9hblhI?=
 =?utf-8?B?eWo4OEM0dUc0NERvamNBdkxkSWViQmJmeXN3RjZ0Si9ETG14U0NJZXNQWG5J?=
 =?utf-8?B?UFFnRzhlcTJoZk8xSW9YUDBXaXRtWjFFendyTUlsdkQyeTBocUZZUjRKV0Y2?=
 =?utf-8?B?RjRxaHdUSlFwZDhpaEUrend5dk5SdTkxSUZUekczcWxXMG1taEVMYSt6TndQ?=
 =?utf-8?B?Z3ZQY1NYUEZIM05kQ1QzSXkyT2xmcnJBMUtjdHkxZXZSZUVJeGFuLzM0ZFpm?=
 =?utf-8?B?MUpKQlBoeXZjOVcybUJhbUVhaXdFT2pnQ1pYYjhBbm5OTVlQVDJkZS9rS0Vp?=
 =?utf-8?B?cDhEVGRRcXRtUDAwWDRSL2gxT2oybHd4b3ErMTJOdnEyOHNpc1ZTQTFsNWNM?=
 =?utf-8?B?K3Ivc2tES0RGTWNsY1p6MWpGTU05VlVkWkI3RGQvdy9YUWNRUXkyUVNQV1J3?=
 =?utf-8?B?MjBOV0M1ZUdMY0dNM2hOVU81YkRFTHVRZ0tESUViNDBONG5oM2l1OUhJSG8y?=
 =?utf-8?B?WWwwOWdVNmppM2hXRk5valVWVmNHeTUzckNkSmdXR1d2UFdRV1h1b2l4STYv?=
 =?utf-8?B?WWhpd1lCRUFDdTFBc1ZKbmphdnRpQTRMVmc2MmUzUlpVdisrdTZYbGhJcUcx?=
 =?utf-8?B?WHRYMFAzRks2ZlRFalZRY2JxbVllTWV0TmVmTlhGL2thbHZiRzJPNW1ZV3hC?=
 =?utf-8?B?VDZtN1JCSHJNNDFDbmprK2hyVXV2SndKM2c3b2VHYStCSm5hZ0NwemRaeW1r?=
 =?utf-8?B?emo1cnZpY1dVa044UC9JelZOU3Y5d1AxZG94K2dDZTlHNlFTRVYxWnE5UHQw?=
 =?utf-8?B?SUE5MS9MeDM5SHQxK2hVWDdNNldDbXQ5M240VVZtSDdPS0t0c3U3Yk9PZUpL?=
 =?utf-8?B?VGZONEdlcS9VeGFZRWtEMkczWExFR24yYVc0cHh1N05TS0kzYkNQeEc5VlRz?=
 =?utf-8?B?TCsva3FUT0VEbFB0aVljZmk2QzhZOXJXek9TYzVpNFNEUnQ3QXlYa3BzTWtY?=
 =?utf-8?B?V1Nlaktwem1SVUJlRnp1cStYWC9WUFd6c1VvdWtCSG9BaGxESXZ6dUVXVFdE?=
 =?utf-8?B?RExrZlFHS1dHQ1plRFpFQUNYZ05JbnpnUlA0azdKK1EzcjNzQkx6VUI1NVhR?=
 =?utf-8?B?UDZ0S3VtcDQ4Z3hDblJPUEJkbDNKRTV0K1lkamw1anhuM2Z2cFZuU1lYczd3?=
 =?utf-8?B?MTB0RTZXRDkxSGZ0RHU1NFlmd2ZuSkN4UGNNZHk1Y1JFbHBLd3p1VzRReGY0?=
 =?utf-8?B?S0t3ZHYwZXo2NnJhb2pMWUFsYllOTVVTS3o0Qyt0OC9sU1ZGRjVIOGYwZUVy?=
 =?utf-8?B?MHJrcTlKcUxReStoelFiQ1cvT0Y5WStjZzhYVVZsUWlwaVQvYi9INklDRG5j?=
 =?utf-8?B?SjJQKy84NnlTZUxOWXhjSEl0ZGRUR2l2a1lKUEo0ZFZ3Z0ZUUUFyRmVkMkdC?=
 =?utf-8?Q?DbmZExsJ2oaAYC/lQvtccMy+T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88747f46-f103-4c4e-9cb7-08dd2bd27ae9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:41:56.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuDqeoHk+SFHZ4aPCxnisDnSSsCddaoH19eo7m3RG0qLynMuzQafZh0o1Hvs9hN6+dKgTJb4bHDZrDd6qdxSQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

This was a retry to address [1][2], to let common code handle
dev_pm_clear_wake_irq. Then no need to call dev_pm_clear_wake_irq
in each driver.remove() hook and error handling path.

In this patchset, I include input and rtc patches to show the usage
to avoid introducing an API without users. There are still
other places using dev_pm_clear_wake_irq. If this patchset is
good for you, I could start to clean up other drivers such as mmc and
etc.

[1] https://lore.kernel.org/all/20241111092131.1693319-1-peng.fan@oss.nxp.com/
[2] https://lore.kernel.org/all/ZymxvLMkkktRoCXZ@google.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add R-b from Linus Walleij. Thanks!
- Export devm_pm_set_wake_irq to fix module build failure.
- Link to v1: https://lore.kernel.org/r/20241228-wake_irq-v1-0-09cfca77cd47@nxp.com

---
Peng Fan (12):
      PM: sleep: wakeirq: Introduce device-managed variant of dev_pm_set_wake_irq
      input: keyboard: ep93xx_keypad: Use devm_pm_set_wake_irq
      input: keyboard: omap4_keypad: Use devm_pm_set_wake_irq
      input: misc: nxp-bbnsm-pwrkey: Use resource managed API to simplify code
      input: touchscreen: ti_am335x_tsc: Use resource managed API to simplify code
      rtc: stm32: Use resource managed API to simplify code
      rtc: nxp-bbnsm: Use resource managed API to simplify code
      rtc: ds1343: Use devm_pm_set_wake_irq
      rtc: pm8xxx: Use devm_pm_set_wake_irq
      rtc: ab8500: Use resource managed API to simplify code
      rtc: mpfs: Use devm_pm_set_wake_irq
      rtc: pl031: Use resource managed API to simplify code

 drivers/base/power/wakeirq.c              | 26 +++++++++++++++++++
 drivers/input/keyboard/ep93xx_keypad.c    |  8 +-----
 drivers/input/keyboard/omap4-keypad.c     |  8 +-----
 drivers/input/misc/nxp-bbnsm-pwrkey.c     | 15 ++++-------
 drivers/input/touchscreen/ti_am335x_tsc.c | 43 ++++++++++---------------------
 drivers/rtc/rtc-ab8500.c                  | 11 ++------
 drivers/rtc/rtc-ds1343.c                  |  8 +-----
 drivers/rtc/rtc-mpfs.c                    |  8 +-----
 drivers/rtc/rtc-nxp-bbnsm.c               | 29 +++++++--------------
 drivers/rtc/rtc-pl031.c                   |  6 ++---
 drivers/rtc/rtc-pm8xxx.c                  | 12 +--------
 drivers/rtc/rtc-stm32.c                   | 10 ++-----
 include/linux/pm_wakeirq.h                |  6 +++++
 13 files changed, 71 insertions(+), 119 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241227-wake_irq-b68d604dd902

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


