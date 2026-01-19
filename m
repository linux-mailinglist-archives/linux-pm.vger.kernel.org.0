Return-Path: <linux-pm+bounces-41071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68338D3A224
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 09:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B2703016CE4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2C350282;
	Mon, 19 Jan 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hh2f+KxC"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FF3451CE;
	Mon, 19 Jan 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812837; cv=fail; b=ADDo0IvYGcSrTyKjjTpq2xQ7lX3cGOF14tctjtvr6xzP/UjXGlaPvAP0Fqrqe9OTaD3RmGFoWiH6MBCp3NfEg6PaGb2oHWoa2U6Mo/p8ZMuJ7F5dC4CEDuXge4fR4t+qF+TTSjFYdooFwiyPPR/dE37sc8lEwTPUKvnEVNewdbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812837; c=relaxed/simple;
	bh=WtjjGEeTsWxOyX2OzQYqrTJofP0kuCsDmwQ0XHVUmxE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=GQnu4h3mEXlJqJiogO1xOJTUVpWVGqtgmeaqebOIEOkBKxQbQAoUpcUiicUcQJ7wXYubYENPNG/BopGbaESVuOd9vvrV087u/apU3JsxgYoAHAlnklQ4tVK3Mp5RFdMo77zueg28+asWTcscKLnYEqOXMMrzGtjtVFJ/unf7su8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hh2f+KxC; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUV9F5+7K2NCF6nxQaFusgvyNr2NlA7EqJXUCX0clT3Po9G2RMYShO1QDSi2Bt3Sa6jLU6FZR80rXOxFnyD0Vzj4fxy/EzTXnKGR8DiyFEZIX+ZFh2qWomHwg9+kjFBH3Xy9G9ySuj/R1X1EDW5UFhZktYHlxbEGlLrJsPK/03yuKQXUSKYnlkRLpm1QRj1nhobwq9i6CqmmEZtVT9V7YjTX1lv/3f5P2ld+IVRALZvYEu73rXbafh4uIly5mrT4ORQANbvpE7BVsO26u78Bj9HgRNXsyIsr0hkvmbmurlI2qNiChPu9HsZT7vI9fyODINv/2Zb6Y7sGQqx4aCv8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cegwIPNdJZ9sYnSMzXEoPGUG0s//pq8ueWP1OmWNTGU=;
 b=vF2G5Oo+B8/CafPnrNCiUASfPtA2dSrxHtm1a9DZrzxtNWXEEIz8u0UL6IdOg6Rldzn2Nn2+2SuuW2ld/DU5sIWrebg/HVLKmkVVOcHn/16ry0N7GT5a46jXgkAyy578FJ71lo5XyEp/zjJEOCV66AcfqUWkmDK2VFYCG3IXWutCByzA1Dgu+JnlLny26jRdlPjaJTwnizK5U1M5dryFm/J4oXq8I++lN7JbbsfkUq8HBOyzCLGJh5oPjV7Ov05qMiyrbVj6Da1DGsreZIWVJ8SI4M2j5a+9HvBdscIfBwRiowQxeIUCY+1s410so5TcM0V8XWln3oQqdLI+xwmMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cegwIPNdJZ9sYnSMzXEoPGUG0s//pq8ueWP1OmWNTGU=;
 b=Hh2f+KxCPX2GGvHh7Deo64kaMFAHbmsZnFibduBVMSplqZODSuLVvX4mZTbGzZabeHvMI/1Az1DpHjzF5oxv2o+qzqQbucguY+qOVvU/4l0EBxRyic7ob2oSgm4xhzG7YD5Y84yM0NV0SX5fnzHZGOPu8pVxjp/2ZE11MmfKl3ucuNdCr9fCxO5CxtroyWa4OZRPylGFY3PomuelKdLU/GcLYB0TBzSupeLVrJ6+q/Z+EkDmuo0vdVwJqOzzkuVFagA3lfhwVxq7WIQrYus98VzgIl+hPXNu9QTHxejcY+V6FWEZNFFB/kUkF8oCF/qaPQzxER0K2Pg8RJA+V4sQtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by DU4PR04MB10743.eurprd04.prod.outlook.com (2603:10a6:10:588::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:53:53 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d%7]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 08:53:53 +0000
From: Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 0/2] Update the gpu power domain support on i.MX8MM
Date: Mon, 19 Jan 2026 16:53:40 +0800
Message-Id: <20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABTxbWkC/x3MTQqEMAxA4atI1lNoIop4FRlKqVGz6A8tMxbEu
 1tcfov3LiichQvM3QWZ/1Ikhgb8dOAOG3ZWsjYDaRo1Yq/E18l7s6efSfHkbNborQQ1jI7IsUa
 yCK1OmTep73n53vcD1cKx7mkAAAA=
X-Change-ID: 20260113-imx8mm_gpu_power_domain-56c22ce012a1
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768812829; l=1157;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=WtjjGEeTsWxOyX2OzQYqrTJofP0kuCsDmwQ0XHVUmxE=;
 b=9FBOBaj8Cw1+vz90Iq+dr0KUV2V57fSESCcn8ZiMvvtcqm5MGB7ZcY7jOyv3Rb1RE2O1rIP7/
 sJgWDp2w1qIBaezMCIsJxPyTfxyREgph8Xq1nKgOtMEFyZ/OYS+b1JN
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To VE1PR04MB7213.eurprd04.prod.outlook.com
 (2603:10a6:800:1b3::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7213:EE_|DU4PR04MB10743:EE_
X-MS-Office365-Filtering-Correlation-Id: 109bcf32-5364-479f-f8a8-08de57384585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVsSDNaOW00Uk15cVU0YmwyUW9wRHJQb2p1OVJyUHZPZ20zNmY2R3FIcCtR?=
 =?utf-8?B?OFFLNHl4UnM4UjhPUERSUnRDcDNjd2pLNGx5ODlFazIxeDg0dFFQeSsxK1o4?=
 =?utf-8?B?Ni9BNk9aWjdyVDQweSsrZGFlK1RaMjNGT2l0U1A2cWtQbGFwRGZwWDU4QzZB?=
 =?utf-8?B?MlROaEdIb1J6RG9UU3Zmcys3Z2NmVGgyckk2SzZPelFXNGNIR29EaDVlbmti?=
 =?utf-8?B?TTJHQzg5OEhNREhiL0hDUEhrMnNyaDdXUVNhRTlsVElBNUxBUCtRVk5RZUtH?=
 =?utf-8?B?RUgwcUZSZlBTSHkyRWVwTHRkY1I0WlFzeUFKRWJ5eGRCME9sL2FLbTdmMklr?=
 =?utf-8?B?em9SMWtWLzZsOTdrODBsOUdGUWg0WjdMakl5ZTdqb2ZCaVY1cmdQbU9NdlJL?=
 =?utf-8?B?SEt2V0ZmbWVORGM3U09kby9QWlh5ZytGRFdVRy9LWDVKSWhjS25BTTg5dUx3?=
 =?utf-8?B?bktSYWxNMFpSZ0Fra0dyRXNMYmpSdEwrbzI1UkNnUmJQLzRkZHVOUlU5NWRz?=
 =?utf-8?B?OUdMRDB5d3ZhTXYveit5dThOSnhOWVBkOVQ3cmRiRm9HaE53UnQwRTVRRkdQ?=
 =?utf-8?B?ZXdkbUVrRE5oYmY2SElMQ0dCbVNucUFpclNxSUNLU1czWXh4SXZFVE5NVFBO?=
 =?utf-8?B?MldzaXI2Tnc3K2ZuSTJiWVFudVFTSG00cm5Ed2x2R1RhMnRKbDFMeGtnVTQ1?=
 =?utf-8?B?Yk5KRFpmSEdiR0dwWEJxRDdkZklxaHpkbkhQcitjb2xSR010R2Erc1lOQXl0?=
 =?utf-8?B?NlF4a3R5cUY5bVZTQXBsdUxtdzE0WHJNdkJFMEVDS0gveXJ4K2FtaDJLaTJK?=
 =?utf-8?B?Rzlldis5bDlnd3FHUEZwNXVNeTBMejUvaG5Bd2dscnpCVW1YWXFaSkE1eEtt?=
 =?utf-8?B?SjNJZjFoYmJVTHpvNTNWWUtlMGRmZzlERHFxOW9EQlQveVhSZytRaTF0SUNT?=
 =?utf-8?B?WlZUaGRtZUtTL3k2Q0dEdk1CMXEwb2EyUStxbjdmalBzTHJma2czTUNTbHpt?=
 =?utf-8?B?RWMvcFdJMFBQODFqMzRnbnF0N2RwU3pRTDFwbUVvaENRbmlCaHhsRHMrZDRa?=
 =?utf-8?B?Rm1wQ3p3UjIrT1BhcUY4L0ZvcjFadEpNV0NkK3RxbUl5enZUUU90amZwNC9Z?=
 =?utf-8?B?Sm1jVm5FL0JoVDNJQU9QTVlmRlJ3dkFrckRyb0JjNzJpMjhoeFdMWjVuUm1L?=
 =?utf-8?B?VzJYTW94eDgwd3p0UzdEVDZZUTNoWmlFdTgxUUE0SEErVmJISDI1QkMyb2hl?=
 =?utf-8?B?S2FRT1lnU2krV1lXcEk4c2Y4U0F2Zit0dnNTejFpUk1OTUUvYzBWSGtYTU11?=
 =?utf-8?B?Y21YaVhDY2JSUXJud0RCNm9zZ2E1OW5nOURFL2Nid2h1Wlg5V1ZiLzRIUm5O?=
 =?utf-8?B?L2czMDMxK2YxWnhMR0xwSWRBQ2czTXI2Ym4xYzVPQWhoMlAwZU9lUmFnWnZi?=
 =?utf-8?B?U3loTVBDNGVRMmhoQ3hISUZFampTWE5YRkoxWWMzWHFxdzhBYlFxYzZpSmZX?=
 =?utf-8?B?TERhOFp4bjR4ZCtWdGZEY3lqNzM3MzQxUWN3aXcwd0JEVWlNQlUwbWw2NVRO?=
 =?utf-8?B?a3JSa2s0anBIY21jaFl4SkVxWEZjemY4NUxnaExNYWg1bjhFcnNPRFBtcy90?=
 =?utf-8?B?Q3JDUVF5NldXWEFZN2tXcUxhY085WXVYWDFab1N0L083b0VGZTI3WCtJV0pF?=
 =?utf-8?B?TjFvUDlBZVhXL1dRbGZCT2sxTkJvN0dlb2JmbHFYSjdOL0Y4QjE0cGNPNUEr?=
 =?utf-8?B?cG1IbXZqc0UxSEl0cEc0UGtBOHBLc3RHaUxFQk13SFgyZ1dMNExDVDhzaTUz?=
 =?utf-8?B?Q3pqYTJUeUJnV2xVRGhHUWF0SjZZQ1VXSWNLbjg4UFNrU0hvRWxGY3hPSTQ1?=
 =?utf-8?B?SFZVdGVFc2dnN3pRWGE3WHJ0dmhsR01BUnRpWEhma002b3VXR1lUZzBDalR1?=
 =?utf-8?B?STNhYlArTHN5WVN1WnVKbUN0ejlpMStURmhIMkRiM1NNU1kxV1R6cHJIV0lZ?=
 =?utf-8?B?TGhtWXRJbG8zd1VDL1V4Wm8vaUxZSmp4MlpYZC9Ra0YrcTlaOUU5TTdwYlpj?=
 =?utf-8?B?UndhT09qaU80Z2cvNGo2TXlCNWtPL0pwd3AxNWZkNUlZV2dYbi9MRlU1dEVr?=
 =?utf-8?B?Q1lFbTNFU0lubnRsZk5vVUdSUUdoTDVvLzRCa05nWHJSTU5lQ3RlOGRveFE3?=
 =?utf-8?Q?inaiFHCW3yvWNc+hPpzeW30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3BNV2grc0Z0K3B3SFhESkVYSjdjakZ3WTlQT2EralRMWlVFNnNtY2k0TlVy?=
 =?utf-8?B?NmRtVnhwbW1uYllKWXc0Z3pHMXd5UVZPVExhOXpqSG9vT1ZlWjRiZ1hFTkw2?=
 =?utf-8?B?Q0tPemMyNGJ3Tk9CRzBQcFFGd1lyY2NhUEdJTmEzM0o3WmEvTDdDNDBYWWx1?=
 =?utf-8?B?VVlPNllseHVHMUh6MGR6bkVnVEFwaFNtTHJXV1F2WGlLUFBua1I4Q3hUM3da?=
 =?utf-8?B?V0VLdjhlazB4djUraDVaWkNVQ3JkeDNRdUFKU1hnNXEwczI4Y0gzSGI5dmdT?=
 =?utf-8?B?Tk1ncDUwL2xKdm9TN29pWURVbkIxc214UjVmTWNZN3I3cm9zZitibWhUWXE4?=
 =?utf-8?B?UlVQSjdUczF0SG16V05QOUphMGxsbkRzYUZtYm9YZEUxS3RHcWhGRG9GWHA5?=
 =?utf-8?B?c0ZHeFFSSGlYTis2SCtYRzJjdk5KZjF1enpiRmxucXlIcFhsK2pwMnpZOWpi?=
 =?utf-8?B?MzRMeUdiYmVvcHBId0VrV1RIVk56TUVWZWJSUWZOZ3hIMllkSHJvQzk2ZVhD?=
 =?utf-8?B?RDFSMDFxbUdlMnhNRHl0c3lvQUpaQno0cy9wSllGV25SVDVGMWpjUXZYUzhq?=
 =?utf-8?B?UmZXeE82bTF0R1RBRmFmc2pkQnNweXBGeWphOTI0Y1FIWStoWVI5WnQ2QXNh?=
 =?utf-8?B?UUFuTW5OLzlVdkhidXlid1ZBTzczY1BwcTRiOGphaTVLeU9EUlRTN1cxQzk5?=
 =?utf-8?B?ejBvQmExTUg4LzAza1diVmhMOHRpN3hEV0ZJVEt2TUpZcjlDVW5Sb2tiTEVx?=
 =?utf-8?B?NVVvNncyaFBaUG4vNGVVaEFBYi80QTJUTHNoNS9tMnp3VFVTSHVBNGZPbWcv?=
 =?utf-8?B?TWltOUxQY0c3M2R6SHU0bHIvY3pHblVoZnNlb0x1bXlXK2VXNG9zaXhZRWNF?=
 =?utf-8?B?RThqYTNMcEJxWG1GRUl1QUtxWGpEQVhBeHZxYkxzZHdhL0hYL05zSHFjZ0Rx?=
 =?utf-8?B?YUpUeVl2MTZiWnhSVlZYSDVaNjRiZ3pPTTNmeG93bktjS3hGbklKb2RZTHlk?=
 =?utf-8?B?K0Qwb1lua3NTQWRIZEc3MmRjQUk1WEcxc25uM0hKQko2NnQvS05lb1ViSkQ0?=
 =?utf-8?B?U2t6WHNLT3JJWkpleGIrdFJtRGFqTUd6V3ZQSlYrMFBtWUNRenVrQXcxRzBH?=
 =?utf-8?B?RjZaYjJFVWdRanpkUXJsbzlxa2lQaExOdStZM3dzSHhmM2JkWUZWaHRqOStV?=
 =?utf-8?B?S1liQWhPYUpHcU0yYVZuV2l5cVpQK1R1ZGwwQWczZHJQbU1iUVZGV215cGJa?=
 =?utf-8?B?Vk4rWnArNXF1dVVKZWdzSktkcEhHT2laYUY5aFZkcVhkb0huN2cwcGJkdTRQ?=
 =?utf-8?B?b0RqZjhJSWpjYk1VTGNUQVB2bUF6TjlOaldoWnovREUrMkdkc1NsMlVUQTFC?=
 =?utf-8?B?K0tMQmhNbEd6Kzd1ai9aOUhiTDdlQzdmYkgyeXFsNW0yVEdyL3l6RTVyNjk1?=
 =?utf-8?B?MmkzMlBSK1dETjdnZ2lvQkg5ZlVqcnNuK0cwd0VjRkxpZGdZdWNFclFjRUJP?=
 =?utf-8?B?ckN2MDVQcDBaVVQyMUVUYzhNNUFpV0N4TjZwNEl3Q2RxVEZGaU94YWRmeWlw?=
 =?utf-8?B?MExocVR4VTRFekhDZkpGeGw2ZkpCeWZweTM3TU9sV0owV3R0ejlwa09CVTU3?=
 =?utf-8?B?WmRtWjN1L0F2MjN5YUhheUkxazJSdzIydFdoTUNpdUVkNHR6VTRyYXlkbXhr?=
 =?utf-8?B?Q3RKNzdJN29DSDVwN2d1a0FpeGV5WUNpcGVHRlZidmladzZwWkRmTEl4ZHFo?=
 =?utf-8?B?amFpQUd3K0VSU2Q4UDZRYkhvSnFJZVdOT2trcFpVdElyTzVjc2d1bGxvV2tr?=
 =?utf-8?B?dTFESkZwRnlZd0hiZVF2Y25xeDBaQnFROUk3NU0wY2JlZDBsbnJxQy8yWFNn?=
 =?utf-8?B?dXQ4d3ZDNUVrZDJYLzBYY2JXTVhXeVVEcWtLb3RFT1c5MXM2ODVKUjlDbnRr?=
 =?utf-8?B?U1c0eUtSYWlXcGFDdFROc2I2RHhtbkhMQ21TbDEyYWJxb1J1RjN6RWI4R2Vy?=
 =?utf-8?B?bFFzQTNUSUQzUGpPRWh3blNXTlJRTkpqMUN6WEM2Z2UvMCtCa1hYeDRpMTly?=
 =?utf-8?B?R0xPNDlSZXNHcEZ4UjFBTU1Yd3l5UDE3QXBJdXZ2QUJFVjZqeW9sRjlxb3M5?=
 =?utf-8?B?Qzk0K2g0azJBU0Q5c0J1SUQ3QkZETm5ENjJpbjJaeHVJZkt1bkE1bHFUdTAr?=
 =?utf-8?B?MlphTnlHdHBmU2txUzd3UlBGcndUNGxrR0c5V2kwQTEyTFUyeGJYc29qbTNC?=
 =?utf-8?B?b3g0empXT0xieE80bmZaZ0NWNUtWZkFUeUJhaWVOQmt4S1k5MG9tVVNtNFNn?=
 =?utf-8?B?YTBPZDZydWl2MHFzaVNpczZzTy9pcldFdWxGMHNacjhOcEJFSVpSZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109bcf32-5364-479f-f8a8-08de57384585
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:53:53.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKMueYbnOSVnjLk+bkfVhWxMZJNLXIMIArBb3QGx5SzH03s/klVNGT7N+IuLlyvJnUq7Sy8BnT33K6wrcqCnbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10743

On i.MX8MM, due to the hardware design limitation, the GPUMIX, GPU2D &
GPU3D power domains share one reset domain. It is hard to coordinate
all the three power domains dependency correctly, then lead to power
on/off sequence violation.

With the current GPCv2 driver implemenation, when doing the GPU stress
test, in some corner case, the GPUMIX ADB400 will be reset wrongly,
then lead to GPU hang.

It is reasonable to use just virtual GPU power domain to control the
three physical power domains as they share the same reset domain.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
Jacky Bai (2):
      Fix the imx8mm gpu hang due to adb400 reset wrongly
      Remove the gpumix power domain node on imx8mm

 .../boot/dts/freescale/imx8mm-venice-gw7901.dts    |   4 -
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |  18 ++--
 drivers/pmdomain/imx/gpcv2.c                       | 100 +++++++++++++++++----
 3 files changed, 89 insertions(+), 33 deletions(-)
---
base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
change-id: 20260113-imx8mm_gpu_power_domain-56c22ce012a1

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>


