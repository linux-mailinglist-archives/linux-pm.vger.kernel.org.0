Return-Path: <linux-pm+bounces-19926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEEDA005EC
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7577C16338E
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DAA1CEADC;
	Fri,  3 Jan 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SQQbuU/P"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013039.outbound.protection.outlook.com [52.101.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EC1CDA2E;
	Fri,  3 Jan 2025 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893729; cv=fail; b=PJ/1zqBn0vMiW4jabA4z2FEeAcNBFEhiMjh2akMZW3m7xKcFrDwcOj4xuwqwXZ6j/b9MfH1+SXtYtpgudpF0/Atp0dUsIyiNDKPhy0FY49Gj4pmRQjjiY9yw4Xs4sJjzEM8lPY6ZBiQnPO3E8tHJp5f3ddROvVe91CBdvlRXdqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893729; c=relaxed/simple;
	bh=MtlGyF7f4IaQ5gXyjDyNBKstfyPBC/6xufVjFPOKlIQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tq0SK/wdk++ZzMWBCHExITQKMq2AqBPPtiSsHYfnPXuWLyzbLzFbNqRIoRXeSCjdDlmshtYI1NiY/Tm5DM0bf73TWl28D6b7wrd/UEIzBlNhEgjgrGGdzia1MOL/jcqarHrfUzwaq+miek8kjhC+xlPy0S0rkoyWifeRUOdv87c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SQQbuU/P; arc=fail smtp.client-ip=52.101.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIZYJBv1zHodPoR8UlsPvIFTyC734gJepvyWTq2DPyHmKVGqauYz5yNbfVLOJdiYkl/XoD8uZnXZWiriXMiDpiJDIDoZ29kOVXO9sfxr/WDKzlPuP69NUY37ADt0PPBv/wk3ygrQUB1lVZelYNgUHL1pMNGMDXFqgtIu9Sdm94XLty9jFbBFc71UkjEs/t4ww1OyViQ6hqROFRAqMp86ISlzhCAJ6qu0hAO5IvT0M5vTTpVLMA5WjZpt91wA+gw/WreGwrKaIF3biz01gf/JiRiMPCzdID/ftFCpT+KNSdxsfZJOLEeKNSaFT9GTWgpBU5lERF3P7DxYjwymHaQWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvJSucZCIwQtWFHFefZHH8o5izy9wD1tkxKMnEC2y5Q=;
 b=aACBxHw7G6D7OHprQyA72NYuDRI0Ip2BZWXxyxzYqLWWA/kYRgFfK+PjilFKXKS3tfM5hUeqMgz9PxO3Op9tzUm3/WDqnFpy0GdyfPg8KwxL/XhFJtzzGUAvh3y9u4fHxIrStxEej9kGKeMtfMG0uCMmC5Ct6TqJL4B1eW7tnIf0jxgie0qjURrsVKVe0ZPMYLaT9czWfxwdg6dWMpsoKOB7meGsM7lk9l0Gagp44nt7o/wo08o+osv5cPEpD0Ueg6DqzpdvZPcaRAVJ6EctjAjmaUulUzjKorqGOChvQDSG8pKo62vBt7wwAypAXvGI7Wa4QuJw1lwGzdUqjSlZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvJSucZCIwQtWFHFefZHH8o5izy9wD1tkxKMnEC2y5Q=;
 b=SQQbuU/Pc2kDdi0mMKNu2kHZ6WL/6I4ax1KRGRPL5uT10HLJL247RaP4UDTf964jmS+cCB1wbyOqrMYAngo1mOXCydsFNMKN8PsBjONCDk3eHQSEKd6RE6vjegnpAn03Ocn/ga1oICZ8TArFtG+BzMh7BEUxRFNV3uhORI0bdjCMJvZ8jQIyYqhqoOirXeFV0RZmt0Fwdn76PVdawpQ5DFpQvIbdLgasRs6xGJaRqnNFnijBGcElwBY8qPgRcbQtOh+R86P8yBoGy/BYLN1ewRVfIRUyaJCiAx6l/N7nb7RQgi4KLmg9qZwXW4lC6Iwd9tunu8y/dmAvZCoY/da5yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:13 +0800
Subject: [PATCH v2 01/12] PM: sleep: wakeirq: Introduce device-managed
 variant of dev_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-1-e3aeff5e9966@nxp.com>
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
In-Reply-To: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=2411;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=cZsxdEVfnwbWB6VyEJvR/aoyZKsWpsHQZXR8Pc5i6rY=;
 b=j1W2wjxkUyGXeKstwZDwXLHFSM2SgXzdNMFeRi14fZeVx9+ZZtiyM8Xe0hbxRmrqsALDiNlsh
 Z+I5HCmQOy9C3IoAIY6cIOYoh8iGZZWq0onr5AsZ4tjvecBnbvrw/8h
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
X-MS-Office365-Filtering-Correlation-Id: 605fc750-e430-4da8-2e5b-08dd2bd27e65
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTdVY0JMNVFMS05vNTVjVC9nQXdzeXcwT3k0LzVqNEpuS0dodWdXVG93dWpk?=
 =?utf-8?B?OWk5K2ZzdHlEM0Q2ODFnd3ovcHBUa1F1Vlp4cW5CUCtLS3JrZTdlR0hFMWpo?=
 =?utf-8?B?Lzc4L0ZSdTVnK3FGTFNYZjZsMms5QjVOR08wZUhDLzhUMVptbm5NSEFLc2xI?=
 =?utf-8?B?YlE5T3J0bFpMWm96S3YxU1BvNld4R0szM2pCMTBzc2dRTUVtTDE2cDMzeHJH?=
 =?utf-8?B?dnY3WHJaVU9qM1pNVHZrQXkrZ1BvVGhyb05TdVAwTHFZME05bzl1V0czR3B1?=
 =?utf-8?B?d1pkb2VtYitKU1gyWUhwemFLMmRuem1xS1pIMkRscTJ5MzNkL0ZOSFhKbFl5?=
 =?utf-8?B?RElkVVIvT2cxcFRwZjVucStRVk82aGRLL21MMmRCNHljQXJaczI0ZjBhLzVO?=
 =?utf-8?B?ci8xYTBXTnFvbk1WeWVUVEkvKzNXNk0zYnVsZkFXQ0xsNnliUXZSNE5VQUph?=
 =?utf-8?B?aGkzNWJvQy9PV3ZLVTcyNysvSGVKc0xjaUJqVGc0ZzE5VHgwcWZac2FRMW8v?=
 =?utf-8?B?MnI3bVU0V0krTzhlVENyNjdIeENrcTIxSHZDZk9TNElIVlV5QVpOWlhCRGNC?=
 =?utf-8?B?alpDYnI0eW9RdW9NRVpTczBENXJab0krbVdIc01vODdmS29JbWNqb0lLTFJw?=
 =?utf-8?B?d3ZnTDVaVEtYc014RHIvcm9NanRVWllNSXVPK0F3eFVqd3Yyd3dyY2w2OGVn?=
 =?utf-8?B?TUwwb05qRVViQ3FVbXFTY3pITVhUczZkSFovTXd3Z2VUYldnSlJRdWt6cEh6?=
 =?utf-8?B?L3MzZDZoSUZpOWxmeHFEQ1hkaXhLUFNqV2hDZHhJYXRraFJsOS9RR0E0S3NM?=
 =?utf-8?B?cG9acXVGV2FpbVFqdFZHNU1KUEt6Q01nb2ZIR014WlVjUkhzSWRxcTJaYnN5?=
 =?utf-8?B?dU9NenR2ZW5jSXcwSjdhVWtCV09PR3dBS1FockRFZUEwRDduY21pS3BOd0Ru?=
 =?utf-8?B?K2d5N01IYmxjT3E4ZFdHWDdmc21XMTAyODFoTVBHSU56TWdtTW03eGVDRTMz?=
 =?utf-8?B?b2EzRnBlamtGeVNsdmpzNGVmZG01L2ozVVhtWWphSWJJdU5Hb3NKcERoTFFR?=
 =?utf-8?B?cTcwVXNVQzE5bkdPUW1pNCtIWldMTHBQdldyeVBIZC9oREJTQ3QwMDBVbGEw?=
 =?utf-8?B?UjUwZ0tqQ05oekpIelNMdUFUSUNsdnpmcVZ6RXJBa2s3d1locjVKd0FOYitZ?=
 =?utf-8?B?bTZ0dXVYUHdxRjhCcjJzY1QvSGlwMWhET2ZsWlhoMDl6L1JFMklBUXhKb0xB?=
 =?utf-8?B?a3hLQmFIWXZVUkN6bGdWZnloMnJjeG1mb2NSejVxQVVMOWJ2Z0xjODYyRm5Z?=
 =?utf-8?B?cWgrbTg0b2ZaS054aUM5elRGbDQ2SWZxUnlrQnI5V2MwdkRtOWpFdDU2Z2U0?=
 =?utf-8?B?MVB4RUVHV3hGQkwzRXpCQ0hXQXZEY3YyNVdPODNDWnFyM1BQVGZMdlI1S1Vx?=
 =?utf-8?B?dnloTm9JRk9uSVdjajk2UWZaYTlHNURJenlVeWRWTVlrOTdsTDlZeEhHNURt?=
 =?utf-8?B?M0xQUlFhR3BGR205VVZLOU9ob3ArTlp3bWdkN25sNUo3TlRoUE5ZeHRyazNn?=
 =?utf-8?B?Yjg5VjZ4QkpOeXBpazVWdUY2M1FYMnJpVHR2UGpqY1BOVm1nZ1pDWHljcXBU?=
 =?utf-8?B?SUxvZ3MxaktGME9nL2ZOa0treUJ1MTdHVDJjVWNEU3ZrM3ZiZ1NNVllMRUJX?=
 =?utf-8?B?SXFER2lRUVJIb00xWlJSZVhVaHQ5RlJKemtrK3VwZDZOdXNINFJIbklON0RU?=
 =?utf-8?B?VXZJZHZqbk5YcFJCSzR2TnphZGdXRlNyR3RrWHMyNU0vK21sQ2M5SUZwemRp?=
 =?utf-8?B?WjdJeWRFTVl2SE1nWlRCYmtWVTZ3aHNRZGdXcmlPWk83RFBQcUlDaGR1elAw?=
 =?utf-8?B?azBHNDhFKzJvQk50TlFXcWpVQUlqTStCMEN6ZVBnQ09sTEVESHBTUXcxNXNM?=
 =?utf-8?B?cXcvQjV1REc4aE15SVBsODBSU1htcGJiNWpEZC81Mjk3ZWp5b2NRVTI3ekln?=
 =?utf-8?B?ZlloQ3dpU3h3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tmtiazcwd3JRRFAxbzBwbkVvNUpQeHpTZ3BUWTMyZ29BMnlUTzJCYk1ac25i?=
 =?utf-8?B?djhROGpjVjc2bkU4dSs0RW1wQVhlMTZpZkcxMUJCbGxROGN0ZUhFdWJwemxP?=
 =?utf-8?B?R1doS3RGeTk4TXI1VGhCL08xSGxJVzJ0RzZBeXR0Z1Q2TkVobVhZbWdncVlC?=
 =?utf-8?B?RUptemx1NDJiN0VqNEFWa2hTWG1tMUJKaUNWaW9yTEZQb05wbDBPWnhHNkxH?=
 =?utf-8?B?S2daUGdhdURucjVqMnZLM0IyZEFtSkxuN3l2bHJ0bWUrL0tuM3BPNXdXem9T?=
 =?utf-8?B?bzFjN0xHL0w3em9Bb2FramxteEN1LzFLaU1wUDllTnh1NVlMVENweWU3L1Nv?=
 =?utf-8?B?cXJWR1l1QzJhTW1QTE52SGlkL1VvR2N6ZE01TUxBaUdzQmc1TnBINDNIMU82?=
 =?utf-8?B?NXk2MTluMk1mMUtVTjBXcTdFV1QzZ056SHc2NkErVm5SWlF2YU9pVXIyQVI0?=
 =?utf-8?B?SVRhMXZRcWZQOXByRk9WaTV3TWZhM0VEb0pXbm1wL2FOUmxWNTR3UGZYclpG?=
 =?utf-8?B?TS84UFZ6VTBqeGZwMGpSR3ZQZjR1ZFBxdEM4eGp3akwydlFmVXlmSmdmcndp?=
 =?utf-8?B?WjV1Y1YwM1pPMFAvT0J6NWM0RW1TWFNVMENVa3RpTXhWaWxpY3NXaVc1b0Vl?=
 =?utf-8?B?QTkzZm9DcEpXcVJtSC91QXQ5UFdXQVBkUXhMcUlxYlplcHprYmhxenhTR0tN?=
 =?utf-8?B?OTFZQmlkeHlCbWszcWRKdlpnYWZ2MFRnUlBjaFh6UzNQdVRVelZpdXozNG1T?=
 =?utf-8?B?YVQ5a25ra04xQ3ZTbGg1U0ZWZUxMSEZqZXpFUDAvSGZ5andLVWd3ZlBSUDdu?=
 =?utf-8?B?a1llSy90R1ZIWnN3MExRd3ZKaGpqaXlraExkd2xSWXczY1F2WFJYMGoxUjZt?=
 =?utf-8?B?em5YWmpkTnY5MVUxeFlCdElKUDdXblBmYUNub2VPMXppd3ZLTW9lWVFydzJr?=
 =?utf-8?B?b3VvbTdFQmgzY3Q3UmhlM1NTOHpDYW16MFd6eHliUXRvb0g4blA1ME9vOTAz?=
 =?utf-8?B?MUFsaWllckpQNmNFYXczOTcvdU9rMks1Vk5aQTBsNjY5S3JiUHlsTi9xZC8r?=
 =?utf-8?B?SCt0RTgyMSsrM1UvRDJOR3BnNVNOb2xCQWwvNVVwTlJ0SXRhVnBISkpWTUp5?=
 =?utf-8?B?RERFcWxOZkdUS2lQcnY4VFpIL3dOcGNEVCtPbDJ2aGZ2ZVBjc1Z1cGU5VWJS?=
 =?utf-8?B?YldKR0trdEppM2ZGQ3RCYmNXRWlBU2FsR0VTZldnaCtaZkV3OTNUMWVGUkdB?=
 =?utf-8?B?WGZPWjVlcTZtVWtLOXdVb1VzK1phUEI4RmptZ1JSRnVrZjRheEgxRG9wRUdp?=
 =?utf-8?B?enExaEw4MDYyWXJpeCs1QndsNmcyd3A2TXZoNm1KZ3dhelNPdDVYd0pKVFh4?=
 =?utf-8?B?Wm52cW9ad0tEWXpBYmRqZ2FJeVVTSDZvR2xhOWNrdWFpKzVDY2NvcFFPU2l4?=
 =?utf-8?B?NHJ0c0piQy8wZmhndStWV1NDVCtxa2ptRGk1TGdyaWR1Y0hNQ0ZGbGZhM2ZZ?=
 =?utf-8?B?SDh4YkxGWnh1V29IVWJFWTRiMHZQQWlhbVVhY3pkNWFKSFRoVzMvQ1JjUVQ1?=
 =?utf-8?B?U0pRRCtGMmV4bS83RDgxOWdkeiszRkRGemFFQW5KMU9hWnpkSDNGY0liaklB?=
 =?utf-8?B?NEtGaUwyNXdCc1A0QlBteGdEM20rRkpzZWhmdHoxeEg1Njc3T1E3Y2hCRTk0?=
 =?utf-8?B?V0FCYjdQa2RwQXI5dWoxamlJRWR2TXVxZkErV2xFVmVsYmFlWE9jUzBtZEE5?=
 =?utf-8?B?OSswRUp5bFVEaFVzS1FoVnN6eUlXeS9WZFJIMm1IWndHTkdYMWhFQnBXTllS?=
 =?utf-8?B?SXRrZVZ4TDZzUE1hQmlKZ2N1eGJQeER3TUNIemthc0dmTUU5Y2dGOEtFMWpO?=
 =?utf-8?B?d0NlMnJ0WVA2UWVaWENnRFlGMU4zbnY1RHJtZkRUNXY3TEYzVE9oQnpKL2Ja?=
 =?utf-8?B?cGdRWW5rV251YWJGcFk4Z0gxMzF6cXFUaHA0SVpRSG12SU5nZ1dVakZac296?=
 =?utf-8?B?WFNJeWRyQVRnM3drY3d5NmJ5VlFiNlVCUXlvbi9NMXMrcGlOSjVVck5uVEdZ?=
 =?utf-8?B?TzhlYWdjajZIN0VTaG5aLytSdnA2YUEwTk5KNnBZQnhURVdaNGN6K2srUGVZ?=
 =?utf-8?Q?zasmBY8JtHQPVE/hLQgyuRLDD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605fc750-e430-4da8-2e5b-08dd2bd27e65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:02.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92QI+cW0ykw8vms9yGkeLmFh4UlLy1EB87SyEeB8Gpy3Jd+fCGIdGBl9ExHcq4l5Ulkp12486k73j81I7QY44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

From: Peng Fan <peng.fan@nxp.com>

Add device-managed variant of dev_pm_set_wake_irq which automatically
clear the wake irq on device destruction to simplify error handling
and resource management in drivers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/power/wakeirq.c | 26 ++++++++++++++++++++++++++
 include/linux/pm_wakeirq.h   |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 5a5a9e978e85f3fc9d89cb7d43527dc1dd42a9b1..8aa28c08b2891f3af490175362cc1a759069bd50 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -103,6 +103,32 @@ void dev_pm_clear_wake_irq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
 
+static void devm_pm_clear_wake_irq(void *dev)
+{
+	dev_pm_clear_wake_irq(dev);
+}
+
+/**
+ * devm_pm_set_wake_irq - device-managed variant of dev_pm_set_wake_irq
+ * @dev: Device entry
+ * @irq: Device IO interrupt
+ *
+ *
+ * Attach a device IO interrupt as a wake IRQ, same with dev_pm_set_wake_irq,
+ * but the device will be auto clear wake capability on driver detach.
+ */
+int devm_pm_set_wake_irq(struct device *dev, int irq)
+{
+	int ret;
+
+	ret = dev_pm_set_wake_irq(dev, irq);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pm_clear_wake_irq, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_set_wake_irq);
+
 /**
  * handle_threaded_wake_irq - Handler for dedicated wake-up interrupts
  * @irq: Device specific dedicated wake-up interrupt
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index d9642c6cf85211af603ce39e280a5b4de6617ee5..25b63ed51b765c2c6919f259668a12675330835e 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -10,6 +10,7 @@ extern int dev_pm_set_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
+extern int devm_pm_set_wake_irq(struct device *dev, int irq);
 
 #else	/* !CONFIG_PM */
 
@@ -32,5 +33,10 @@ static inline void dev_pm_clear_wake_irq(struct device *dev)
 {
 }
 
+static inline int devm_pm_set_wake_irq(struct device *dev, int irq)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_PM */
 #endif	/* _LINUX_PM_WAKEIRQ_H */

-- 
2.37.1


