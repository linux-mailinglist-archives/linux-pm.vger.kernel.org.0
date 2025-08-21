Return-Path: <linux-pm+bounces-32766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB0B2EE23
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D085720C07
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2982226F295;
	Thu, 21 Aug 2025 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BOyfHD6X"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AE4A32;
	Thu, 21 Aug 2025 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757450; cv=fail; b=na5rAqWZ1/df18Z+7Bx1SaweiyLVRpdoGrKSgUs1ojkITfaydf+rykYjVB+OkR/wSLAYqfBsB8lSjJMzdFjc/1Z37//8fab5duJZm0Z+HxPb/jFFboibsSWFjJDKuNrRUM4r8NA0gXf3KrXEK5oC4Igu2CVDMvaYzAfMHni8cIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757450; c=relaxed/simple;
	bh=Dxde1ygyfetNfODYK3TUE8DMES7Nu31EWBoGHxbV2KE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=IQ+RtvTyiuwwATv4IazHUE85fVozOXFq6NYz+ajpOubSiuztX5PG8nD0DeMvTLepoO95f4L/PwPEYRNmtPGeO+ejP/AYnkAF2MlCU+GU0l0dUU6pKz+bUFcxls4ARuR/+jAjCL72FJ0wgAsaKJoShLVCsIaxkeGgJeVQg6K8HPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BOyfHD6X; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgH1jfYRtXNb9KdFvm7+TwluccLvRzuKfdppPTptDvL+YcEkNbVbqy6RAVDdAsXCIQOXKQMvyjoMlpvN8bN0LvZDu2p5dsO64iXjVu6x4Wf9bas7GaAytIGZxvBwuMtQTeSpBDLDt/vYhcJoO1XemdBnBQCQP+a4b3RjnYfK/Dk6TaZfMi4M516jajHZqAWzVk9vCCuYRWWquR/ekEI8bEIcghn8khRxk2G8SpF6yQU0Kv8WGrjAn6lY/XSNY9inYQgMA/ap0SEdkaFcuJ7tmmf/23m63OH/645MlNEtrkFVBxiOMmFjO2J4+m87snbErw/FsZEC3agFk1hrKrGWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICxBb2kjjJ2w/LZdSRbKiaHFj+biQxdfkG1bNU3QBik=;
 b=kzSTNU8KBpIkfW1rMI7d1gvZLVV+yCULZxdENSp3ZN895VV2ShSBNq7W8gqpYIflI7MQbN06xug0PLvppRFs+ZVdOkJy+JZ1aWC1so3/rZlHA3DTt96jdo3mC8glWOAVubdQPzcvaNR376zvaq/G9a1oKGi9clp5w9yD305QB8HaLrBXYrFevWyZ9hty7YtCGqIg0wlipcnd3mODEQcAp9TRG6ZsxJBVSwSAqHcHbHveBhW4HCjHwjIjXfMSQYajED6PcFJk6iI9kjbsHv00QVEAvW0GlyMlMwa6DDqCMG0j9J2P12TN7w468qgNBBsAS6ZNWDKk+PNFYNp5xXyjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICxBb2kjjJ2w/LZdSRbKiaHFj+biQxdfkG1bNU3QBik=;
 b=BOyfHD6XZDlfeWh303UmP+NiALblG8SCGuCY64to2eNukOF7GYRA6QlhJsddtrbAvX/5OPZrFE2bAiRNf8oQqEBpg8nvW9GvF9ldJdZuPxbFf80CqjTuGHq1Xi+Vh4UAwVfYM9l6Ks7WG3EoiJEQ29wCbOUKNe4Q0BBWPC7V0SqDh5v9DODoweZCxAs6B3ma7BcM2d66l6JDDat8rKGTH1beShmcT56P24CGM1D55ShGBI3xEXW0HPRFgyQ3uupXJ3W0sNGyJFCazTQhPY5is5+ASj9fwNuLDs7Tr7BfOtBepaE3xPz5NQvZtdGq7sSJ1CjxTP2vH7Y5CmObIihLEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AM9PR04MB8859.eurprd04.prod.outlook.com (2603:10a6:20b:40a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 06:24:04 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:24:04 +0000
From: Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH v4 0/4] Update the thermal support for imx93
Date: Thu, 21 Aug 2025 14:23:48 +0800
Message-Id: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHS7pmgC/03OywqDMBCF4VcpWTeSi5dJV32PIsXGqLNIIokVi
 /jujVKKyx9mPs5KogloIrldVhLMjBG9S5FfL0QPjesNxTY1EUwUDFhO0S5KPif7phUAaChaXpW
 GpPsxmA6Xw3rUqbvgLZ2GYJqzwBlwzlXGlVJCAeV0RNdnrwbvbhkz7e1uDRgnHz7HrFnu4u+fw
 2nBLCmjsugq1UCpWSX+RL1t2xcslNtP3AAAAA==
X-Change-ID: 20250804-imx93_tmu-7888c85d176e
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755757438; l=1304;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=Dxde1ygyfetNfODYK3TUE8DMES7Nu31EWBoGHxbV2KE=;
 b=Kx7sh6suos2sEW7ofiFp67KrHnous2/n+sqXYNvh4dpNEI8Lbxouh8bqTqS1pI4eH8FhaYCjd
 r/8TfnMSQ6HCNlpQbDZjt9fV8cmS/9NMmEDXcTM1UNh2aAjLkPnymCU
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|AM9PR04MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 31df1886-4dd7-4e58-9a52-08dde07b532c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVNjQ3U1Mm5hbm1rekhsVHZGU044WEtpb25ESkhLR2lvSWFjd0RpMWsxTE9V?=
 =?utf-8?B?ZVUrTkd3OCtFZVpOVWY5b2g0Y0I4SnVvR3FQekIyNmlNMThBcnRTZzBsdFpt?=
 =?utf-8?B?cHRHTDhxRXNkWC9GSEQ5UGdYZFEzVUhVTWMrbitEdVlwNGc2SndpazV4cWpm?=
 =?utf-8?B?VUY0Zy92OWlsUWhYYXlBeHpNeE00WW9sait3ckI1QVE3SklaZVpKYzJieXJv?=
 =?utf-8?B?M3BWdmVXQi8zZzdyKzh4SVlPT3M3UlRFMllSdGZ5OFcwQmYzTzRBaUp5RWlw?=
 =?utf-8?B?UExoT29jM2lHZkEwNDhHME5kNWh6YnYzUHpmTjFLN214ZUtrWlY4bVFsS3c0?=
 =?utf-8?B?YXBURzRrT2IvTGM2VElsM0ZST2lDdTUvdEd1NkxmMVg5RXJKbjBwUjBqUnB0?=
 =?utf-8?B?RjQwMTVUZ1A5YnFncEZNWHY4ZndYQzBjQWJZc1ovWGR2U0NoVURyT3VMclU1?=
 =?utf-8?B?RVRqREdLdlFlSitrMzYzUkxOTFpFVElBaXJ2QXVvMjdjQzBPMSt3ZU9WN3RY?=
 =?utf-8?B?MXNQVnZaREdUOUVxWGVqbjM4V1QyY0l3TWRLZC8wYXRxajVnZGp6K2RDU3I0?=
 =?utf-8?B?NU1YeFFvTjBjMEtteE5LNXU4L3dlRUZPVjJsQ0pqdGFkY01waXRFeDJzSitV?=
 =?utf-8?B?N2hURFA1WTdoL2s4Z2grUUF2MG5pYy9YM24xV2NkTXVweXEvQ2F2bFRua25n?=
 =?utf-8?B?VnBvOW5pUjl1Q3Q0SS9OQ0gxNkdKd3d3RlBwaGN4amF3ZEJjWU04Q0NaSUxI?=
 =?utf-8?B?Yk84UjdQSTQ0VXFORTRYcE9MTC9DRHJ6T3BwSk5xaHVFSWJIQjdIVTZQWDBz?=
 =?utf-8?B?ZHBPcXZBVjhEUEJ4MlI0Wmo5eEswbUJEZWtRLzczMHNFYmwxVnZJdlFoYzN5?=
 =?utf-8?B?TDhBbFo4NmZwb2NTbk9UV1FBN0JFNE1waTVyZnJwck81ZVlOSTc4c1FORmsy?=
 =?utf-8?B?RTVuNmRHckJMN2ZvdVdkM2VnTzQraUVseVlMeVlESVZDWUNHVFdzTURFOTVt?=
 =?utf-8?B?d2hBRmVUYkhlVjJaZi9ubXBtc3N6aWtCUmYzU3FwTi9BL2pSSHFWNEYwSzBo?=
 =?utf-8?B?WU9KcEdra1NLR2pueEpQRHkySlIyU1piTHpKaHBacDFsK01kMmV2UWo0SHVK?=
 =?utf-8?B?UU45Y2hpc2x2WEVJcTVwQzErbHZTNzBKSkNqYzU2WGRpdllTNm9LUXpZOFVJ?=
 =?utf-8?B?WTBsVWdJN2NONGYyY1A1UDRzYXM2Y2drTWxoWHd6Z1luNHpHUXBOL0hNVUpS?=
 =?utf-8?B?TE91SGc5YTFQN2NQWWpLY1pUVDhOSlM5aWxPbXNra1JzRUtTZHVzaWF3aGpv?=
 =?utf-8?B?Mmw3T1lrZjUrVXMzckgySFNCUWx2MmdyRE1CR2pFWnoyNnFiRDhNUlV1aXk3?=
 =?utf-8?B?ZkE2QjYwNnBVK2VrNnUyUzFlb1poWVI3b0lFOUZTUGdjVzFqakFoQzRGNjh3?=
 =?utf-8?B?YzBzSUEvMm4xQ1IweGhtK2dxdXNhUnJVTWFJMjdaL1Vtc01RK1h4UWRCbEwy?=
 =?utf-8?B?NzJNNkM4bVk3RGdscFp2TUhmdGNmbzlsbFQwaHlYWnZZc3ROZ2hvMmtkUURC?=
 =?utf-8?B?UXlCeWxhSDIwdHhUdk5xRHViQWRia3N6UlVDencrVnhlYjc2anhINmVwNWFz?=
 =?utf-8?B?YnRmWHd3UzdRWTdMc0tFeSs5UFVEdmVvUlNUWVhzRDdRUEE2UVloczNiaFNq?=
 =?utf-8?B?SnlwZ043VFVKYWRId2lVYXZGS2s3UWx2S0gxNDZnRUUxMzV2bFc5Q1ZOUFN2?=
 =?utf-8?B?SDBaM2V2M3dRVm4vYVVsMG5xeE5VWldKdklMRjB2NER1TkhGY0JCckJWSTB4?=
 =?utf-8?B?VHdkdiszSFpvY2luVlZLRVFDZTlVQ0lWTFhWb2hRTEtXWW03QURrYk5RMzVx?=
 =?utf-8?B?K2k4bzkwc01VeXJ2VzJsZEdOS3B6dGtqQ0dzSlhlM1IzT0tpTnFRenRyaEI0?=
 =?utf-8?B?dm5CMGFrSmExemNhRFprRDRaaHdxcm9YQUptdStZTTNldjBsVjdRMCtmMjZY?=
 =?utf-8?B?dzNFZTFsS3JOTnpiVEpKc3ZpWW02M2ZDMG9FbzJ1YjVIaVFwdVhJeUZLOEJ6?=
 =?utf-8?Q?wGOZ1j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0hqWXc2NVdNTFZUMjZaa2cxVFJIY3NVNmt5U1BveWpHZzI5QTk1QjJIK1dz?=
 =?utf-8?B?L1dkWHdXQjJNdEE4WVpGYzRJeVpNYmNxTzZVZERSQ0xuVmxVUGVJdXVpZjNl?=
 =?utf-8?B?OUNNejR2Q2lRbHNxM05lUjY5S2JiMVZlVlNUajkrd0Ixd284Nng3djROZmNP?=
 =?utf-8?B?b0dnc2lCUFlXLzFSV2hpaHF0VTJNbGh5RHl3QldjWU95SHhPMU5aRkZwVC82?=
 =?utf-8?B?dHZSelVZRzQ2N3M3YjMvenpXSEkweFhlRmZpeUR6ZnkrREt0aUw0UWJqYUtP?=
 =?utf-8?B?SkRMM0JMMmhyVFFuaElDWCs5amlaSFU5WWVkOWM1M2FKcXpkdUVsb3hzd2t0?=
 =?utf-8?B?RS92VElqZXNlZmdzckN1UFY0TXUzc3ZSUk5VSU1DUDcxWUVWLzN1NDllRW5S?=
 =?utf-8?B?STlkK3R3T01KK2lkM3lPVUNWcVBud0lVK2tOV25obVhZTVVtSDZtNHNUL3Nn?=
 =?utf-8?B?ZU5BK0N5Skphb0UvMG1mWjFpL2djaWJMTC90SVMrbTBUdnNTdXNvRzI0VVFC?=
 =?utf-8?B?eTRRbGd2RVNjWU1qVlFaQ3FiR09BV05WODFBU0hXMWNYRXZEQU9OdWpQaVpR?=
 =?utf-8?B?VXE1a3ZoeVR5ZUdtM1pmVUc5SkRXU0FkWHFJY2l6RTZNV3l3VHVvZjdSZzJH?=
 =?utf-8?B?YWg3T2U1M1RHdkozODExNDRoVjl2QzNSNlZhRXQrekhhY29zY0FLZnV4VGZC?=
 =?utf-8?B?Zk92UUlPWGV3Uk5TVFFYY2FnWCttR1ZTVG1uVWdyYTNxT3ZSSGFlK1Fya0Ry?=
 =?utf-8?B?RS9iSE5Dc3RCS1MzZ1ZTT2ZxelF3YTYvc09Gd2p2dTc0NU00a1pXdXlXUEpQ?=
 =?utf-8?B?UGsrYllReDFJcVB5VnRIcTRycVRnd1VVcE9NVHRvODhjT1hjTGhVcU01Wm9n?=
 =?utf-8?B?cTlyZkxWeWlyMER6UDRpTEUzRUtZaS82OTZQakRTS3d6WDEwQVhoQWY5cEQw?=
 =?utf-8?B?ZVBhbGVSREl5dFRqSGZ4anB0VmE4TTBMdkV3SWZuWnJxZ0oxVUozWnhSNklj?=
 =?utf-8?B?akREeEZlNjBPMFUzVENueVdyU1AzQW44UEQvRndWdGRHL1A5MG1tbnpMa1lo?=
 =?utf-8?B?cDNBenRuemlsbGgrb2p3TUdOQy96WWhaUWFaSGh4bmpLTE42V3VJMTAvdWt4?=
 =?utf-8?B?QndzVlpxbnR0ZHJnbWJ1SG84MGlLRHU2NmxiVmVCNmZ3RlBOWnExR2RzUWNP?=
 =?utf-8?B?MHRlM3hqcDNkZzhCTlJIemNJbzh6K2tFWGNRN1NocmZ4cXhPamlyVElYSkZL?=
 =?utf-8?B?VHRHTUpFSlVDcCtjckhLWnB3S3cvNWQzM1VuU1VTZ3hIYURFL2Uxa0tmZC9Q?=
 =?utf-8?B?eHc1cm1XTkxTVXp4UlRWbWZ0N1paSTZiUDJnSDZNcTgzN1l0a0EwVzlrY1VU?=
 =?utf-8?B?TkFJY25wMFhuWmhHSUZSeXFuQ09mMEQvNW01VDdFcEtqR1MrRGJvMEhkVEph?=
 =?utf-8?B?eGVINGFJQnJRWlc5YzZHMGRQb3RKbVloYjZoRkpKZmRSTmRIVTN0cmdaWU8z?=
 =?utf-8?B?MVNGNXJFT3pyOXhFWjRTd0RmeHVXcXFDOU1RQlgwZGlIV2dOZlZlcjF0U3l3?=
 =?utf-8?B?TDlPVitlNTZTKzAwL28xenlyN2JjMjU1bFRyQWYzZWdIZXRsRktISmM2clNK?=
 =?utf-8?B?c2l4UUpDQzM5bHd0dXNDbDY2Wi95b2kxTWlzVElRRTlaZVcwRGloaXNLQWp3?=
 =?utf-8?B?dVBpZ295ZGFiQkwrUmJFNlVyUnR4d0Z0UlFOZWV6WUw5REdTSFBDVEN5ODdF?=
 =?utf-8?B?Y3Q0dC9OenprSXN4MGllM3hYZHJnVElvdkdJbytESm0xOWNYMmtKdjUwZkUw?=
 =?utf-8?B?M3V1dU81Ryt0ODBFSVZBNlFOU3ltbDg5TWg3eldpVmk1eXY3dm9xUE00TlBC?=
 =?utf-8?B?WEJOUjlmUW1NcjdjeWNqbVhNNENiTUpCUmtTNGE3R2l0V21GaUd0REVQbWhl?=
 =?utf-8?B?TjhsME1aQ05nbmxiaTJraERoei92T2IvVGhNcXFBYzNpM3N6UjZYREZ5VDNY?=
 =?utf-8?B?NUkrTFRxd3BjUkFpNlk5K1p5bzNxNmZ1b1UvWXhTK1dlUWlKbVJCdXJTdXZX?=
 =?utf-8?B?RlFDQ21EOTd0ZCt3dDRsditMSUxCVXRlRDAxRUhsTCtrSTdCc1ZsMEJpa3cz?=
 =?utf-8?Q?ifsFowF+ionqvOp3WPie3l0PO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31df1886-4dd7-4e58-9a52-08dde07b532c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:24:03.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wi03CwxpjOFPSvWLYBj2H9Q1qO2Vw2+hY127lsOxDmEpbON7uucWWyYtcgKpYY8a36+x7s1hKh5Fw1w/W00/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8859

The TMU (Thermal Monitoring Unit) on the i.MX93 requires specific
configurations and workarounds that differ from previous implementations.
So, using the 'fsl,qoriq-tmu' compatible string is not appropriate.
To address this, a dedicated compatible string and corresponding driver
changes need to be introduced to properly support the i.MX93 TMU.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
Changes in v4:
- Include bitfield.h to fix the build error for RISC-V
- Use macro to define temp rate threshold related settings
- Link to v3: https://lore.kernel.org/r/20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com

---
Jacky Bai (4):
      dt-bindings: thermal: qoriq: Add compatible string for imx93
      thermal: qoriq: add i.MX93 tmu support
      thermal: qoriq: workaround unexpected temperature readings from tmu
      arm64: dts: imx93: update the tmu compatible string

 .../devicetree/bindings/thermal/qoriq-thermal.yaml |  1 +
 arch/arm64/boot/dts/freescale/imx93.dtsi           |  2 +-
 drivers/thermal/qoriq_thermal.c                    | 62 +++++++++++++++++++++-
 3 files changed, 62 insertions(+), 3 deletions(-)
---
base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
change-id: 20250804-imx93_tmu-7888c85d176e

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>


