Return-Path: <linux-pm+bounces-19340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7239F39DA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 20:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314DC188F919
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70D209F5E;
	Mon, 16 Dec 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D32u1T4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EFB209671;
	Mon, 16 Dec 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377139; cv=fail; b=lGD5t9OeKTDE6rcGQ/YroWNW8XoKoTgDfJVNa2B+qksFjFNf3CvvG45klGqcsdDmTPkyQ2V0RwARw+t7bP8HD/cbEKFtsJbRPkENBGWNsDdLfIzIRq4WrfNZiFZ1qhkF7KeKtc7r9qS2BJIR30T86jVPi9moT6kr4Bxfp3DgknE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377139; c=relaxed/simple;
	bh=ohSxHBxoEDTu++WIdotYsmiwjFWROATTylDhqdvwP9Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ph6TuoLbVQEQbjvUQ4n9vAu8tn8/nYG4LUAXVc7cAZjw6rO1TjC9dITmd+KrSRQf2nbxGsgTlpLSzpaM/gO0ISNcffpz8W5B+Zm3aCdXv8Hwe3vzle0YbheeN8u+A2ZPGOlrEjDzHgEyyQbPsFJo8wwuNiKLBkQG0II/+zrnzoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D32u1T4a; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvpCPnxd+jZTwTQA15vYQHGQle16zjMjUiwQOmFzJEx5nnws1tLGh6xploVFFWLPoyDGutWe9HU6chPhDe7/cqHFOug9DrtRxvOQIuzLBayFlhXOb1wjqDoPDABNSB6Ig8ktdxbcj4idfaL9kowPADE0NuCuaMN/TN55PpcoCOhsRp6B3ZPEVTlL4uxNOngg3FmNNt4UDNFplbQYn3mn43zg2gO2dPhzPATcvQiiWqaAN0hR3Gxpiq2yDeMyWe7RXZ9gacgr2NrwPzOlrwazjPBsKRiAewSR9C7Zst3q12aZ7BfVA1HLm0pyPOFWYNFlOloVbfEGQUbPmRWHVgdVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzzZhQmnuw14n3PPkimvz1dX5EuFY+l9PtzzZkXejis=;
 b=ighOOWvcwv+/uOLOmUMmRDkicImANICcreYGJFLocvq6ln8kVq2O3PHhWZWwQRCaFi9dX20iVnvgvSgPOIX2xZX8uB85tSbATTV245zHqFgJkResP4+T0zACCVMN4mdkrPSB7ARTGq31cKODRV6+9jU4Aiqsne9tAwS+Xj4XOwWwbwYkm7O/+4buXL/iEIcpjn9xhx5EGlg7wpJNrQInekpo0srXXQtku0fNlSEKF2r3bEqf+Iv3kHhij8K8JYYuuh9OZpvIB2Ysr4qSjxyLvrLE+ixTf89WiG0eYBb4ChDr6SPqYL7f8UcxJy4CiKokrK0LtAnlHK1kt4AhW9jwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzzZhQmnuw14n3PPkimvz1dX5EuFY+l9PtzzZkXejis=;
 b=D32u1T4aRWmQhBEIAiFkynkshUhJ3R6BssrtOV5C/i+WnASAoojQtxXqgPQeTgi+EeOazDhX7Nm2LUaSrEYtuibEiB0cz7j3kVaZsB8eyY0gWi5pMdpl9d4/lmhWTpo3NUMwjxC0Jk2oIo4FUBCox2NhXAkkJTLcWO4NUkCpwCb16bCIfVSudEy+BwcGD5vFi6ux/OxcdkEp0Ze92OqBWv5HxECZAu2/5UOPFEtdjJm9gr0HV8g7JUmRM6nlQSP2EXUXpJszmH/CMV0JeAayL5NFRSM/5j40HuKPUau/7LSLr/XtNSF9SlHCbjQqN8RBP+41nOu23dkUuDLAkV6Ymg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10249.eurprd04.prod.outlook.com (2603:10a6:150:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 19:25:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 19:25:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 16 Dec 2024 14:25:14 -0500
Subject: [PATCH v4 1/2] dt-bindings: thermal: fsl,imx91-tmu: add bindings
 for NXP i.MX91 thermal module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-imx91tmu-v4-1-75caef7481b8@nxp.com>
References: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
In-Reply-To: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734377121; l=2428;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8kxKovdlRL951oX75jiP9tw7DaGNLVhyTD0fBHpZz8w=;
 b=D9doE59fNeXO9bBlND34e9PCLsQ8fahToW9/z0fiFeE17jENSlwdCCI6t3ttDLzwUJdXV5mBT
 fBeCKn61PrCBQokOLlR4wwslLB0QRSokGMWBq/k4XYMHfsyb1XtXBk8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10249:EE_
X-MS-Office365-Filtering-Correlation-Id: acf2efd0-9335-4d40-a78e-08dd1e076802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUVQZ1d1SWpHYzM0czdVUlNObFRnUmMzUURDblpCZUVJSmlIVDFuRWNBcHJm?=
 =?utf-8?B?NWdFaVJCeWlUQVpHUjFOa3N1VXBpR05lcmpvRGJGekZ4aDFORW9nTGFoMUNI?=
 =?utf-8?B?elR1K25jbld1TUc4bmRtSG42b01TbDZ0RWFyWSs5amFwNHoxRStwUDcrWGs4?=
 =?utf-8?B?TUZRbDVuSlVuM1dldlp1WGJmUHhDMjBXTVpyMmwwTWIvRitLL2ZrTzNuakU4?=
 =?utf-8?B?RzNuWXNLb3NrYzVoSG5zYURtVzNCNUlMTnpUWlJSdWRTU2JQbGxsbXA5SHhk?=
 =?utf-8?B?Mmx2Vm94RkRnekZ2TFVCSTFsdmZkUGw4QXZ2U2crVEhTUGJpSVJqSzlBMFJj?=
 =?utf-8?B?d3hGK3N6a1prNzNFY0JkSmlTaXpxZmV0bkZzaGJ2MXNPdGQwZjA0TmRacGpI?=
 =?utf-8?B?RWdjYy9pK2l4cHQyUUVaMUpWSXhBcGdiWkQ3aEtja092WVhvTFBMU29HYWJS?=
 =?utf-8?B?OXBWeFk2VnRVbWpTZjhia1hoakUySTlpWVE1RFEzUFhwdEwzcUVUQ0NmaGYy?=
 =?utf-8?B?d0F3dVNtVHhEb0xpeW1iMGdTVWx2UDl2bk1pU2lZbFVLbnc0UjR3QzdPeGpQ?=
 =?utf-8?B?QUVDdjAxL0FnUm9PdDFDb2lSdFphOG52a1VYdklJcjMrcndlY3dnY2hXUWE0?=
 =?utf-8?B?MmpQamRLcUpON0tOdEhvL21qa1YycnUyMm1lNmhhMUNhVUdTbGd0ZHlCSWRi?=
 =?utf-8?B?THBOTTFEbldvbGxhRmxpRTIwbS9hQ3FNOW9rV0F3OE5nNlVGWjNIZGxPRS90?=
 =?utf-8?B?Tm84anpESWVOaGNCdjJ1U0dmYUo0T0RjL3JMd3BCUjlEOS9JYUtJZnNiL3ZZ?=
 =?utf-8?B?KzZuT1drZjVJNUQ0RC9ITCtwRkgyMjhXWkpPK2dCb2taaUwvMVJqUTlwQUwy?=
 =?utf-8?B?ZzFFN2hxRlhoS29BeTN2d3RGa1dMQzlHRWdiQkU5M3pXNk1NVVdySTlxTWFX?=
 =?utf-8?B?dGNiMnBGWVRSUlExQ3ZqTUM1YnBHMDRMRC8rZjcraUhSQk5OSmcrTGlGWndG?=
 =?utf-8?B?S1FvY3hZOWNJbnE5dlhXdmhQTmZEb29PN3hqMTNQZStZSnRPdnZlOGloUDF4?=
 =?utf-8?B?WHo5L3kwNzk3MkdkaTQ0Q0xpd3JxVk1GOVNzQTFFNUwyUmtzeHY1R0p0azVJ?=
 =?utf-8?B?TW1nTnF1bVZ2MWFkK29HOWZWYmZ6RXZHWUpWajlENTljeFVFUXdMWUgydFVa?=
 =?utf-8?B?RmtuL2c0MVhYRnl6NXhTd3lxSk5Td25DRS9lSDdvcWNrT20xcHFCcU1XMXo3?=
 =?utf-8?B?OWorVXBGSmcxRzNreE9SaUk4RURSK3hrOXhRQVYzTU1KOEUvenlZUFRBUlRU?=
 =?utf-8?B?czIwL1d4MjJkZGdsTXRwekJYN2dUODYvZW1rTjZmcVdLbFVENWFVWWZDNUNO?=
 =?utf-8?B?K2RQSjU0aW9PRFZqTEFydXJkQzZxSlAwbkpnMlBOOUVkbzE1Ynd5bkIwa1Zq?=
 =?utf-8?B?Zmk5blJtcTJIV3V4TURFR1hicHhIOXNLTWFBZllOK0FHTjVCYkNna2JYYjRn?=
 =?utf-8?B?RWVSOVh0Mzd2cjdSRHVpc1RpWmlJemNlNlVLT2ZpbWc2OFNxaGdxYWdMWWRn?=
 =?utf-8?B?RWdJWkZDSE1pNFluWE15MmJmb3UxckdQZ1dzdVg1ZCszZDA4cmJoeXdDN21K?=
 =?utf-8?B?UXRNKzFndjBYQ0VMRHRUZnY3V1pXQ1R2dkNjM1Y3VXBCU2RrbDVTeCtCRTdy?=
 =?utf-8?B?QjV0Tk9SdDVrSGRKKzNQQVBRYkgrNVJwTStCMXI0a1NzQ2RjNDBNVmsvbzRT?=
 =?utf-8?B?VjNjbGdQWE9tM2dIWnNXNEU3bzl2TmxuVkhtb1cxaW1tL0tlK1ZvSDU5NjZ6?=
 =?utf-8?B?WUdqd1ZGdSsvMHB1b2QwVVNIUXhZYXl1bWl0anJxTDcyQVRybG4rQ3M1eDRw?=
 =?utf-8?B?UlgrSzMzdy8wNHI3T2xwTU5SK3JXRnlaS3NiZXZjSDdzdXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFlGRm9jcTJScGxPQXJkZHNBaU90Wk1CK0VhUFVjWFNCTGJWSW0zUy8vdlFB?=
 =?utf-8?B?TzlzODlGMEwzZnd1alV5akMzOUhMOGt2djMrVWtlRVNiT1BOQytFQzQ4U2h3?=
 =?utf-8?B?UlRkdFdFN2RieXFRWnJFSDJyNWk3eTVEUHBKNS95M2hKY2xnTFoyMTdKa1E2?=
 =?utf-8?B?dEtlcXl5WXV2VmcwMitrZElrZllPNndiZEVpUHBzamxabVFlUUE5QWVrMHVG?=
 =?utf-8?B?RTRnSENNTDhTNkUzenI1ZDVJeTRMRlhadHFxUkNWTUZoYUtwT3VRSEdaYlJm?=
 =?utf-8?B?NUZqa0ZqeHNvampDOGdsUHFKQkhadEl0bUh2V1ZzUjBITXVnQmR2SmNZVllQ?=
 =?utf-8?B?YklBS0VqalpTakQzRU02RVhVVEdpQXFUdHNaVlRkODdaa0UvVG00NzI2T3Yz?=
 =?utf-8?B?RW1YRE9qZFQwM2FUOEJYTGRCTWxEbWRxS1cvT2M2dDYxU3U4RGdEbXh2clBF?=
 =?utf-8?B?RVlUNlJ4dzlTZlhLZE5RT3Q5U0hhYlRCcy9BVVpLTE5YOGxReUIvZUZBbU10?=
 =?utf-8?B?RkxuLzd4Tm4ySmdyMmNydnhaTStUMGZXVzR2ek9PU1k2aFphb3hGa1VNT0kx?=
 =?utf-8?B?Um0rWUtFRTRLMUE4dTBVMG5IL3NoWDV3bG1OaGNLOFNjWXlkaiswWjRBUFVZ?=
 =?utf-8?B?UGlJcndleHByaElXLzB1NlFoeWQrZE5YOXB2aUdYQjRxMGxZWHNGSit1eHho?=
 =?utf-8?B?QVlJUWVqK2F1NXg0TUVhaEwvaWQ1V0thV3BXTDVKTi9QWDZMMmpmRC9WMnpZ?=
 =?utf-8?B?SlRDUExUNlZNMC91NEViWS9HUlAwb3d4QTlsOGVDMGhadWVtNnhRRzdzZ1Zv?=
 =?utf-8?B?UWxMV3dsZWhtbjMxTUIyWXErTHZlUzRweG81dFErQ2xZQ3RoNmZZNHIzQjNC?=
 =?utf-8?B?Z202U08xeFg4emUxQVdvMThZR1VGUXBidWdROWQvbG13L0ZKVll0MHpZTjI0?=
 =?utf-8?B?YzBLSDVXcHJsMzdSSUNqYnpSUjAxejFsYWMwOHl1TnR3UUd6UFpWVjd2UFBv?=
 =?utf-8?B?b3dUajkzS2xqazBDS0xYMG5PK0dSamNUWTk3UnNENExST1ZockkwbDNlOHVI?=
 =?utf-8?B?SG51RldZTUtxaWw1MVRhVU51SjhmamRiZ0VrOWVJUVVDcStJelMvamlWdm1O?=
 =?utf-8?B?Z0pEWFprUFEzNU4zSWZISG9tQ0ZtQ01BRDlidHFTRFVMVGpwK21yMEtxTENa?=
 =?utf-8?B?MDI1amx6aTc3VGdjTFNXNDZ3eTI0Q3dDSnlqb2UvbzVjN2Jka1ZsV1oyQ0E5?=
 =?utf-8?B?aGNIM3FmQUFJekRZcHNKbWxPWlo0R0ZmUHJSNjJmWVlBN3FoMUJJYUxrRSsw?=
 =?utf-8?B?L0QyVTdoOXFXVnNsOGNPVWhySGx4VGF3REt0M2tUNEY0Y25EWldpNXFlNHNP?=
 =?utf-8?B?cC9oWTh4WWxDNHBIUkhITUVhVm5VMkwvcTdFMFUrZ01uQW0rQ004ZVRCRzYv?=
 =?utf-8?B?cWhuZVNtNWxLY0FJTy9HVW4zRUhOdGU4ZXIxYkhyVjlIazdRelVJZ0c4cThE?=
 =?utf-8?B?ZWhldEdNVEw5VldnVEl1UU1SNnZkMjJXcEg4WDN6bTBzMjNRQThIM2pZbnha?=
 =?utf-8?B?WitaWnpWdjFmVFlXczkzNjBnQVkzZTBHNXgxNG5HTC94WGxDYVl6d2dVazY2?=
 =?utf-8?B?U0dKTEQ2WG9VZ2JQeGhTRTRmTGNvc1g0TjRRNnpyeDJuYjVuUWI1aFUyeS9i?=
 =?utf-8?B?WXViMWtTRHF2S2VNWm5wNGp0TEN0R2ZIOTNTWkxJMWVBTkhZWVdHRjFTcnNt?=
 =?utf-8?B?VUhxalRqaWxIY3VvOCs0NFpFZ2JZVzRPTk5FZVVFdWRmZ2w1Szl6K1ZlYXBE?=
 =?utf-8?B?THFnMnhtcVVDVE93dnJYVjhDK3lqTi9ZOExOdFEraHZ0YVJOWGNtYjJtdHAy?=
 =?utf-8?B?ZlBzRll6NGlISDJHNUJQRS82Z1BydkdvWk80cVlYUHorK2hlNWpjYjA2ZEFF?=
 =?utf-8?B?VHdUNFBjTVJEeStlQ0xmK052Wlp6UE1QRzNIQk9CU1FqRGgxYzVRRDRIemZr?=
 =?utf-8?B?Ymo4R0J5Z1hYUEtFb2l1MUJlLzZwQ3hlQVhEY3FPNjlKYVp0T2REdG41aGw5?=
 =?utf-8?B?c0ZVTkU1M3ZqV2swWWNoWGh0SzN4OWg2NFlxWnpZcnVFRkxPSnVXeVppK1Iw?=
 =?utf-8?Q?oE2+FqUu8HUc+M6pgFRWhszFV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf2efd0-9335-4d40-a78e-08dd1e076802
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:25:31.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJCR8fy04LBnYmmkLRbq4a4+rtvvg/x3MEyiF0mI6EskxBXNcN16pPY/5bkyD5C9bRINS6RhjVzABSl90HcxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10249

From: Pengfei Li <pengfei.li_1@nxp.com>

Add bindings documentation for i.MX91 thermal modules.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties
---
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
new file mode 100644
index 0000000000000..8411f3233bf44
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,imx91-tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX91 Thermal
+
+maintainers:
+  - Pengfei Li <pengfei.li_1@nxp.com>
+
+description:
+  i.MX91 features a new temperature sensor. It includes programmable
+  temperature threshold comparators for both normal and privileged
+  accesses and allows a programmable measurement frequency for the
+  Periodic One-Shot Measurement mode. Additionally, it provides
+  status registers for indicating the end of measurement and threshold
+  violation events.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx91-tmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: Phandle to the trim control 1 provided by ocotp
+      - description: Phandle to the trim control 2 provided by ocotp
+
+  nvmem-cell-names:
+    items:
+      - const: trim1
+      - const: trim2
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    thermal-sensor@44482000 {
+        compatible = "fsl,imx91-tmu";
+        reg = <0x44482000 0x1000>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clk IMX93_CLK_TMC_GATE>;
+        nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+        nvmem-cell-names = "trim1", "trim2";
+    };
+
+...

-- 
2.34.1


