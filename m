Return-Path: <linux-pm+bounces-41344-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG69EPbicmkyrAAAu9opvQ
	(envelope-from <linux-pm+bounces-41344-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 03:54:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D422D6FDAC
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 03:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83763305371A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BF33B6EE;
	Fri, 23 Jan 2026 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lceerwtc"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23582344DBD;
	Fri, 23 Jan 2026 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136723; cv=fail; b=h263HPg1ek+oeYfWQPVMxaWMdS8PtUjGPG5a4R+Tsgw/yZTnk0Kg1hhvY4oVepH3Ce3MGo+fZdLutIMiz5x8tlJy8KzJogCL80kQIyxySetDVlirfpsM8L6shxV7Q0ZMxTpwaiIcScVOpIugU5NMLOVJfk5RwHV7iLLzBHQ1Vsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136723; c=relaxed/simple;
	bh=5tIZ5X2+HWit5fvlIJ3Lj4JemyLlez0pFFJXGBL8n38=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=bP6vOpJENh6VZ1SanOYNSigMBx2T1eI2cuT3fWQpgwdG5Vrp1kL2fUe6qkMQsO8FtBEk7iiFiPvneRB1l5+i4gQeLTmEfSVfnDu47QSML5qFEcI5qKWEQ+8FV//2vgoEsR/mxPeA2Eb6l2/NUT5ppJY7wjucaBbgFJwk8/Z+5Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lceerwtc; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vmg8RUIoa8K0omfvYDPGbZzuleqgY5fapFWUiAg00iptbpdVwuqFwI+xSl5rn2C0upUtAkTdbIFOZwYrKZTD1oRNrEwsAq/RadHNIwgomNiyRPT+14WMqZWly/+Pyfek1nHYA5+jdxst25R0SvDNODf2ml0H/OVbooRdeximhAIxzd16yQSQaiucudJLIfOSuV0027z6xGr+27ssbIa24BCKIEiFIlbzAiorPqjLa2K+ujc4zXRinVGnr/RZqxCFruOG6VgMTnoJy8plJ/G85LFe0DwvY822GNw4m/5Y1KojuZ7xepwZb3etfhRnw60/boxmSrzVrvKOex6FR5JsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anArFfqu5DQqNRTr0xaZeXTB9A8EXyjn3Dfp++iXnL4=;
 b=NAT1r/BNq/EwgNdrxRa3quX3/JHPJTazp/oh+G7eGP+hXo6GbyvJHD4eZPYi6743JPMECN8v62nhUFD99rca3KaZIKQuHebOhbOMSbPMlcZw+VG5MfLvYxoH6xuCk1OapXx70AVmoZRGo3y42XbIyKYOOkeGm9Z13OAq6g6GFsSL+54NGZXLWNQflSuh9uznf98oCeixYCUUz9Img/Hrq/MEDQAQ0REUDu8o3esQ9b5qNj+1xerSs7oC3LbwRwAxKOvub797ka0Ei+kbwod2AeGtUH0/A20MVfUF2TzUYC06iBYmxWJX6HgQCryUjXoDNE+ir+thI2pvAPSlXARbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anArFfqu5DQqNRTr0xaZeXTB9A8EXyjn3Dfp++iXnL4=;
 b=LceerwtckkrdriNN9v5u3L7UlYjL8pQpAHEup3bsNZKFICcAeBNETPO4BoThE48fxTW4jyPxsjL8sThdh3625+vMWCeoXP4MZo12k0rRsY4rJIc+HIF+sewJyyrxlY5WUvGMEWSAeJ7AwgkZcSA/XCbZrsA71pBInzfar6/62HkfzdQp7iNqIdhATl0sl/8Tpx9YzMpIHrTcA9a5k/JiaB2ZwVnNjqAsTzgN0D+daUMCtzyp7pK6NxNtbUme5CXU8aoTdVR8k/ZH9G3phc4N7xmCLB8GiETxOBzIbgy4wS2+3iGWib2Sbu+YfmDifSRwN2U+fcWPI3/Y3OqhyE8hOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by DB9PR04MB9673.eurprd04.prod.outlook.com (2603:10a6:10:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 02:51:40 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::93cb:5423:e3b:9a0d%7]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:51:40 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Fri, 23 Jan 2026 10:51:26 +0800
Subject: [PATCH v3] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260123-imx8mm_gpu_power_domain-v3-1-3752618050c9@nxp.com>
X-B4-Tracking: v=1; b=H4sIAC3icmkC/3XNTQ6CMBCG4auQrq3pFK3FlfcwhmBbYBb9SasVQ
 7i7QGJ0w/L9knlmJMlENImci5FEkzGhd3OUu4KovnGdoajnJpxxwQBKinaQ1tZdeNbBv0ystbc
 NOnoUinNlGPAGyHwdomlxWOXrbe4e08PH9/oow7J+zWrTzEAZLQ9agjoJUYG4uCHslbdkETP/U
 zjbVjgFejfAWs1AApM/ZZqmD1//n1sCAQAA
X-Change-ID: 20260113-imx8mm_gpu_power_domain-56c22ce012a1
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769136699; l=2963;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=5tIZ5X2+HWit5fvlIJ3Lj4JemyLlez0pFFJXGBL8n38=;
 b=8pe8nQ+Ivi3dg14iDJQp8YTTNFEPjjuruRTp1UvWaMy093EQ6+rfvYGEaxeDqB7oW32FCjPjv
 ntcmJnxq9guCcXOT/pITYAsUsRv1hgnRr9Kl4HwTVbPb5O0aowFhe+e
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To VE1PR04MB7213.eurprd04.prod.outlook.com
 (2603:10a6:800:1b3::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7213:EE_|DB9PR04MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 75278974-92a3-4871-76ab-08de5a2a554c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDFPSWEzSEttM2ZrV0l0R3F5eDZQZkNzNklSakYrMytWZlRzZTFrZCtpcVpa?=
 =?utf-8?B?OGtyTTZwaytLRkszczVRcWxHOUNSeE1JWGpQREd0WXV4V0xwSGVYZ3BxVFZW?=
 =?utf-8?B?eEtjNzB0U3dhbnRrbmNLRzQrY3FtQ0hER2tqODVFOHZrb3pDTWd3T3lwTm4z?=
 =?utf-8?B?T1p3N1BFQ3c4Z1lrVjBrcjZMZUYzNkJmS3JITmI1dkR5d0tBMGZPVWN2RUtp?=
 =?utf-8?B?RjVNMnhDSDZ2bGg0Z0oyT1hDRG8yTWpnZXlGbFZNVXNid3E4d0gxM3orM0F4?=
 =?utf-8?B?VzlOZHhOUW5DZHlYczRSVkp3S3NLSUZjWHZhNmQzZDFGY0hvejVrb001cDVk?=
 =?utf-8?B?RUxMeVkxWjFDNFlXc1RoUW12eVB5THJ0bjVxRWNTbnIrZU51U2Mra3hzdHV1?=
 =?utf-8?B?VW1sd1RqTWpSNTBXT25TQkRoOW5UdnFYQVhVV2k0cWtucHQ3WmlwaVlKeSsx?=
 =?utf-8?B?dkhxV2lmSUxEVHdaQUZ4TUtnV3hTRC9IemQ4TGNBZjUvMFk3TkdZS0w1eU05?=
 =?utf-8?B?MXdjU3IvRUN6V3VoTEw2MUJFcFc4VnZQbFl0RFN2dHI0N3NabmVVQWFaaGRL?=
 =?utf-8?B?bmFJd2FkMDdEeW1vWFVxWW1qdW5qN3B3VVFXWFVwRXFHMCtUd21qNGowUFk5?=
 =?utf-8?B?aEQzVDFkTHZFcW43UGZ5ZU9sbUI0VEJodzAwRjVMb2FJRldEVC9WZTN6L1dJ?=
 =?utf-8?B?dUZiRVJnTFdvc0c4NlZMLzdPTC9BY29hZUl6MlN1cUdnV1lMNXJmeGlnMklz?=
 =?utf-8?B?UitBQXNkTm5TQXh6WHlMRUVRTFEyZld5Z1ZyQWNQeWJDdFo2eVRqSlVzNkVn?=
 =?utf-8?B?WUNTZlBHSGpqdnZMQzhzL3ZwcmVpcGJhMWcrQkZRMnQ5NXFlVSs5Mk9OQnhE?=
 =?utf-8?B?S1JxN2h2SWx6enFuQ01LOUNzSGpPMThWVGU3WWM1b0lud2tsNWEzL2Vncm05?=
 =?utf-8?B?NkpuaFJTSEVIWUs5Z2R2eUU1TU1XYWdIRTNGaWdyNnd5bklONVVEZlJ2VXVI?=
 =?utf-8?B?cDFoZHRZbm1JUWhtVDQxeGZJWTRvbVhhV09sZ0ZFRFVwdUZXeTl4T2I3RUlp?=
 =?utf-8?B?VnpJYmVOaWFVR2c2YXhPSjdTUzltVWNZYXp0WlN6Y1doN1ZWV2JMYThOQlZ6?=
 =?utf-8?B?V29nZ3A4UE5xWnU1M2h6Y21lNVAvTkFoYnFBYTNjaTFIYXFwamUwbEJRUzhu?=
 =?utf-8?B?b3RqdFdoUGNlMjFTTktsREQvcFRrVk5XVlNnRGkwYUJuZlZPOVFOcHJuRnpu?=
 =?utf-8?B?MGVYcmtDb1lvTDRxWWlZVGh1Q1RpaEkxSkFwQ2FOSmRFRGZ6ZXQ2bXN3MjdX?=
 =?utf-8?B?SmRHeWFTT2d6N3dpYzd6UGhuVWVwakRhcDFLbWVUaHpvQzM4SDAxYTdEL28x?=
 =?utf-8?B?LzN1eWhpSytMOUpGMkdYYkU0N3duSW5sSDVua1hUU2FRNCtxa0x0Q2ZMajd1?=
 =?utf-8?B?MWE4ekZmMlhXdVYzMTBnbHR6N2czaHh1SndEenJTUFlSY3JodUJML1JTaTUz?=
 =?utf-8?B?QjEzTWIzVTRFUG05VDhYUFRnNWJ1bTF6ci9VSExsaG04enJucVRtUEJGY0pI?=
 =?utf-8?B?M3JqQWc5S3dIMmRLaUMxbzdjOE5OUi9QZFhYOHM0Y05KdCt6T05LU25uMk9J?=
 =?utf-8?B?TUx2cmFNWlUxbktmK29OT3o3alZDS21VRWVQUGZna3k5dHpLc0dCcHNCc2ZR?=
 =?utf-8?B?QXZwUlZIY0R6SE9XUktJNFVDUE1wbGdKSjdoQ0pidG9yTHo1S1NVcFJWdjNl?=
 =?utf-8?B?eHgyQ2JUU0luV244cS92K2Z0WDdwYXI5TkRrelV2Rjk5Vmk0dGZHeHM4L1VL?=
 =?utf-8?B?YW8vUFVPQzQ0MlJIc0s3VjFJSmZlc3FzdU9HOC84ZW1JQUJlaGt2QTExRUQv?=
 =?utf-8?B?bTN5Vk9BWWZTN0Rzc2czWDR4WVJaWEFYdStXR0FaeUFjLzFuR3AyZS9CMlV6?=
 =?utf-8?B?WWlFTEdYZlM4cjNEL1VCaGdzQVd0d0xZRGZhV3VSWXhPRE4zays0Sks1alN4?=
 =?utf-8?B?ZS9MY1RFUjR3SzBXK3ZzSHRCNmowVFhOS1F6Z1lmOWRVRTJMZ1RJWkN4bEdy?=
 =?utf-8?B?L3VWZzA2WjYxd3hhZlh6TVdjbE0ybHh2YXd6L1pnZlQrcmZ6QlJ5dysxcVRn?=
 =?utf-8?B?SHlqZFQzMXFXUWZCcVNlQnVTMlA4WDRaV3lZWlVNMGFDSytHcnk4Vi9QTW9C?=
 =?utf-8?Q?7e3TkHIIM78W2vSQg48d1Ug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEw1WHZEczdNWm4wZ3A4akFUY3oxQS82LzUzdkRPSjJBOTlkSHJKQXZYN1pk?=
 =?utf-8?B?azUrdUJBbGV4WS9aK2pIb1ZUVklVVmtrNTVuZDhWSEIxQnc0Mks5MzB0M2VJ?=
 =?utf-8?B?Y2FHN2VwQWNIWTVBTGxRUk5oaWl5YXlQMThFNFhwb05IM0xlaTBMNThHZVpW?=
 =?utf-8?B?bUo1U25RZVROcnNSNFZRQXdUZjZOTTltajIyQS9jSFRuaTQza2ZoazA4cGsz?=
 =?utf-8?B?OTEyZld6bDlFZlp6Q3R2SXhhZjl2Nk5OckZxbmhCelpJWC9yblhLL2lRZVd4?=
 =?utf-8?B?cTlmT2I1MnZLTWY3REVKc1ZKYWcrQ2JmeUtkTDF4KzczY3ZDbGwzSVg1MUsz?=
 =?utf-8?B?TTN3Z2RpRnRBVWdZWXBFUkUrTjM0MUxUS0VYUUt5SnY3SktnbGxteDZkaFRq?=
 =?utf-8?B?VzNOaFk2ZUkvVTZrWW1adWdvUi9vd24yNzFQdDFFRE0rN0tJQTBhblJVb2xt?=
 =?utf-8?B?SjI5NlVvcHIwSzFGM29uZ0J2L1dHbFVSaDhvNGhkcUdxWml3cmdpM1U4NTAv?=
 =?utf-8?B?bTV1Z2tqMVpKWFFZSjZWMjJWQjJ1QUNLR29wcjltMWJiL2Vkb0VtY0p6d1lU?=
 =?utf-8?B?TGVLMk9nb2RCTmkvZ3RUR0dsOEFVWHVEYjN2WnJYTHFqN1pPT2pqU1pDbmp6?=
 =?utf-8?B?MVlyVUxCN3ZHSC9mNGpncFJ6MTVrQkFXZEUyNktrNDVyaDltdCt6WmptU0cr?=
 =?utf-8?B?emF6R3NUUSszb1l6bXVoaGdWZkZtWkNlYy96RG1RRWs5YllHdnJXOUNNdXFW?=
 =?utf-8?B?bG5QUmcxOEZSZVZPV3RVVHRZWkVPYnMrcE9VWDd0dFNpOS9ORFNqbDRHVXp0?=
 =?utf-8?B?V3ZOeDdpNnJDTUFicmFPaGdjejdDd3M3VVE1Q2d2UEdhTWt0ZGhDMkVScFor?=
 =?utf-8?B?ZjZjbDU3MGlxdVB5eGdHNnErZlZXUGhUc1B1Yi9BaWliMlJURG9pWUZZV1pi?=
 =?utf-8?B?Rkdxa0h6K3dGZUxhdW02cGJ3d1lFdFZiTjRieUplbzQ3L1N6dkFuSHhCd2M3?=
 =?utf-8?B?RE9uamRvNDRXV3BkeVVjSEcvUGVyVHhyWmp6bm9meGpTaWRJelBEM3AzZi90?=
 =?utf-8?B?NGVKbitBb3NnUFVmUFEzcXdvZEhMajMxcmEyUms2WUJrVUZ4Vmd2Z2ZKTXNT?=
 =?utf-8?B?TDZMUFlJZzVEY3lFemZLZUhQSlBiR1ZMeVhvMWMrZjV1ZlJTZ0NvT3hSMGg3?=
 =?utf-8?B?MUVOaFFlZytoZ0VsSENhb01Fa0NOL202M3NKZUpodHU4M1VNVzlObElaRElC?=
 =?utf-8?B?dytmaWdrYzFwWjZzTVlTWXl5a3J4NXRvTWJTbWdsR1pQeFk2MDZYWHJYZWJQ?=
 =?utf-8?B?L0xXeHo3SnNidU41OUl5ZmpHVHVSK0N3OWVGZ2oydjI4UitRYUNCdkVqN3lF?=
 =?utf-8?B?ZlovWnNycmNUQncyMGQ0U0tJTUU2V2ZTWXN2SkFaa1U0eHkvTkJ1emdVRHcx?=
 =?utf-8?B?enRkeWpWMmNCdk1DaS8rUlY1QmkwcGxjemxrSWFHc1FqZUMxcGNFby9FbnRO?=
 =?utf-8?B?UG8xaEsvc3lpZWdpSndUbVhVTG9Ia2dyUUsyOFg1Y2tieVZGdDQraHdoTkxU?=
 =?utf-8?B?Q2c1ZGpqbWJZK3Z4cUZBMGJsQjhuYmpQU29wS0J3T0VRa25ZNTN5Tit4WWl2?=
 =?utf-8?B?R1pJUUFFWVJvWGpJV0JscnJrWVJGaHE1RmxiQmJhNCtDaUF0bGFhby9WTXp6?=
 =?utf-8?B?RGtGK2xhaldHNEtwUS8yNGdZY200M0ZHL0lLVzRBVzU3WHlxckpESW9yb08v?=
 =?utf-8?B?VVpIVVlLMzQwYUN4TmRBLzhtVUNUK0NtNnl6YlB5ZUZ1Qnl1R0c5eE8yZ2dy?=
 =?utf-8?B?TmJoYjNrZFFtRlNDTmNTa1BpMlVWdHJFSUZsRmg5eXp2dFZYNUNyWjArSHV4?=
 =?utf-8?B?a3MzbnRmdW4reC9OeCtiS2VHbjVuaGM5RlA1SmEvQkRUeWZCT3JUTWxidHB6?=
 =?utf-8?B?aFhOMVIxSk5RUFJGSm9NaGVPRFVJTGpEdEVLM2I3a0JoalFVZHU3UGpjRkM5?=
 =?utf-8?B?aW9VeGtpMUdJWlU5b29ObWg1S3NPVTRiUVFDUWN0SHIybUtUS056N2ttWVA3?=
 =?utf-8?B?MVNmRWJ3em05eHJScTN2STg2ZnV3TjJiWklYMzBSaWRyVlRyOHAwby9NWUpi?=
 =?utf-8?B?TC9BVXZTOWhDcStwdDBFdnZwTy9PV0pKVlltSGRUeHNFR2RSRlNhY0IvNkJ2?=
 =?utf-8?B?Q3VhMzdONk1DT1JOeFQyWlBWT3FDN0N2aTdmUHhhY1RvWHNyOGVvTjRTRmt5?=
 =?utf-8?B?cmliQnJ6VVllTlFaTnRmeHM1ejhqcXZQeFdOZU9lZWI2cm4rNGhFdnRYWFRp?=
 =?utf-8?B?Mkx1Zm5MUlpQNUUzUXNIdnR0Q0VkTW5TeG85NnVCNUlyZmVBVy9mdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75278974-92a3-4871-76ab-08de5a2a554c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:51:40.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fbI4NQePLKJcrl01B7Fb/ZnpFzmYEDb4AV4ZC7nyUiWkN8tFeiOPvktqcfgnn8kX68hY2QqlQbttNxrSSd5RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41344-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ping.bai@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D422D6FDAC
X-Rspamd-Action: no action

On i.MX8MM, the GPUMIX, GPU2D, and GPU3D blocks share a common reset
domain. Due to this hardware limitation, powering off/on GPU2D or GPU3D
also triggers a reset of the GPUMIX domain, including its ADB400 port.
However, the ADB400 interface must always be placed into power‑down mode
before being reset.

Currently the GPUMIX and GPU2D/3D power domains rely on runtime PM to
handle dependency ordering. In some corner cases, the GPUMIX power off
sequence is skipped, leaving the ADB400 port active when GPU2D/3D reset.
This causes the GPUMIX ADB400 port to be reset while still active,
leading to unpredictable bus behavior and GPU hangs.

To avoid this, refine the power‑domain control logic so that the GPUMIX
ADB400 port is explicitly powered down and powered up as part of the GPU
power domain on/off sequence. This ensures proper ordering and prevents
incorrect ADB400 reset.

Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
Changes in v3:
- Fix the Suggested-by tag typo
- Link to v2: https://lore.kernel.org/r/20260120-imx8mm_gpu_power_domain-v2-1-be10fd018108@nxp.com

Changes in v2:
- add prefix to patch subject as suggested by Krzysztof
- refine the patch to move the GPUMIX ADB400 into GPU power domain
- Link to v1: https://lore.kernel.org/r/20260119-imx8mm_gpu_power_domain-v1-0-34d81c766916@nxp.com
---
 drivers/pmdomain/imx/gpcv2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index b7cea89140ee8923f32486eab953c0e1a36bf06d..a829f8da5be70d0392276bd135fb7fc1bbf10496 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -165,13 +165,11 @@
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
 
-#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
-#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
+#define IMX8MM_GPU_HSK_PWRDNACKN		GENMASK(29, 27)
 #define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
 #define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
 #define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
-#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
-#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
+#define IMX8MM_GPU_HSK_PWRDNREQN		GENMASK(11, 9)
 #define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
 #define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
 #define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
@@ -794,8 +792,6 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
 			.map = IMX8MM_GPUMIX_A53_DOMAIN,
-			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
-			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
 		},
 		.pgc   = BIT(IMX8MM_PGC_GPUMIX),
 		.keep_clocks = true,

---
base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
change-id: 20260113-imx8mm_gpu_power_domain-56c22ce012a1

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>


