Return-Path: <linux-pm+bounces-42233-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBONJ+EChmmyJAQAu9opvQ
	(envelope-from <linux-pm+bounces-42233-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 16:04:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B11ECFF6B2
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 16:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF5C93002D13
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98887275864;
	Fri,  6 Feb 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="msyhg8h2"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49803274670;
	Fri,  6 Feb 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390223; cv=fail; b=KWQHXLpJTrDIorNy/eiF4f5MezPHVahRjevcDlyy8gN/ccAkzT8iVuJcNELlJrszLH/VowS3aBFwexJzvcaDVrb0VUliLygUhX+LUlaElY7fVc6U5Vn/t3FypLZVxX4bK79nGWTpoIK887pZRmJ3GIu3TbeRrv88C2r4VUD2wXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390223; c=relaxed/simple;
	bh=KD2Pn6WNryZBV0Xmb/SM0/JeUBhWaSE3sSMXvXIlHPo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=pnKCY3Je/ZT/4XUyVgwgLxyIwLMcX5Wqc5VVivFmaezXzPeFW0qKELMpKRbrHF31tw02QiYrAATeTZbCreb0YT+DmgZF6E+d67vC0h6nAt++xM9si+lko1pHT8GTUFzp/sDM9OfUaY9FvwAzKkYwj0lsypNDrvLTeahV8V8C2Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=msyhg8h2; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xgwv2xVSW+92OyNnwHUAFnLKmS+Hh72cUEbfcjrM78T0LbUIPEe+PVtnECTPkPHrELCUCNfzioJEB3aVQzNv12KmdLZrr68lawaGaEvGYHdsmb2holvGxmnpF1YSra7bgWXhbvjtbIKWOg8L+RXeAlARE1BHx2iUnDgp7ek/3qUYsgmgIxco/alSFcr5qwOsJJpbOopC4CrmurZBFgVHyWOrVgNF2OsxmJF2Vppiw00tztSAIdkEEJsG0JM+gHQml/Q/RSNkyaDnvHNismhk1yfbt4xqZVudzpdrMRl3P3o1SiUsTzB0Q6qiMeUO2b5FE/xzne5E5Xt8X+/ePYRDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+JlsmSQsx2a9UcoRSNaivjQmhWdJaxK0AdpI57FjOU=;
 b=FqE9uF0/us0c0UraLlox9nXgAeFU4fGJAMCD4PZEMUL5Upp04lcdSqnxCCuqJdc2YK9Szt9fSZHOSs4b+LGl29fpBXOC6GJGiSWeoPVN7w1qdO3H/a1Kk5swz/L8/DZhd0v5Bet2Q41+kenVK32tc2R6RGoevowT9mBm8I1gZxiziiOo+LIpNgViWv85Bjh90EiWmvjDrY7Vl8uugFMHQlO4kr3AraORHPacVj+J9/5vk1YKYCYL4vHry8RLfOAlLgcKaKBreZ/574s4bik9MP3vvW+QiqPwst3MvNbAMpEgr530e77xNdY9uC/ne3fTeuN3NOeYkYdH/Uma2yP8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+JlsmSQsx2a9UcoRSNaivjQmhWdJaxK0AdpI57FjOU=;
 b=msyhg8h2eqYzqErKdJVRNNil+Mhp9t8Xloq9FNsP6vugtuSevcfb+J6iDHhVmgRAxg3/pT0vVyQ3J28V2p1Sa9hbLgDMIk4j/bnNY56RgBpGzBj40gQf5vqFEObBda+V7TmdfUBZw8bIstuEn9KeJew6hG8Lloz2slTr3HOAVMF6w2nh+HuWGHrAz4KnfUi6dvY+GUw5q/3OI7A69oE2Fmd/hZsFfUv0m3q0f6qtNM+lLN1buByLCLg35Fs5DrhAdwFpeVF3UUxj9jEHtfF8Y+J8IuVADn4Me1yGu2CpLItZCJCAcMXPB2xRgvby1NS3AvskROICamkE5/znjCwBaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 15:03:40 +0000
Received: from VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b]) by VE1PR04MB7213.eurprd04.prod.outlook.com
 ([fe80::3e5c:ea79:66ab:c67b%2]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 15:03:40 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Fri, 06 Feb 2026 23:05:11 +0800
Subject: [PATCH] PM: sleep: core: Fix race condition in async noirq suspend
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-noirq_async_suspend-v1-1-d10f2418df4c@nxp.com>
X-B4-Tracking: v=1; b=H4sIACYDhmkC/x3MQQ5AMBBA0avIrDWp0kZcRUTQwWwGnRDSuLvG8
 i3+jyAYCAWaLELAi4Q2TijyDKZ14AUV+WQw2jhttFO8UTj6QR6eejllR/bKVXb0bqxLbRFSuQe
 c6f6vbfe+Hz/wVjRlAAAA
X-Change-ID: 20260206-noirq_async_suspend-645bd6b8305e
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770390326; l=3259;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=KD2Pn6WNryZBV0Xmb/SM0/JeUBhWaSE3sSMXvXIlHPo=;
 b=otJ+23OiUnqXuV+j7ukF5YAo893ySySQI2TyVoJiLwbzw1ctmQwNMnjUagkhuMy10o47DktBG
 kaDZshrJFmHDV2uqh/8xGOWTc9RPNpPEXJ0wJhcu1/RrNZJuF+64stq
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To VE1PR04MB7213.eurprd04.prod.outlook.com
 (2603:10a6:800:1b3::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7213:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9db5b7-5d13-4ad2-5224-08de6590e998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkNONFlZUDk3YkNQSXBhbUlVY2lpMjRlYUpOcGFTRG80TWJnVFdJczlHL1RU?=
 =?utf-8?B?RDVidkNJaStEQ1A3UGNIdFNBQVBrMzlZNWlDZjc5ZU5LOUJmQmp4cXBSNk1q?=
 =?utf-8?B?czN4V2JTN2tpZFpuaGNzMFJ6b2tNcEJyakRQVFRlQTA2cWR5c2VicjZJRC80?=
 =?utf-8?B?NVpWV1FscmdiRHpIeWFqb0xhZGRETG5PN0dYVE42VW5JKzhwNXBOMEtOZFRR?=
 =?utf-8?B?TEhNT1dpWXZ6aTlQbjJCaHc2a3ZvS29GZHpUN2RCSGVuN2pYZmRabHAzTzQy?=
 =?utf-8?B?TDdEVDNDL1hVVGkyWHRtbDhIZnNyVmg1alg3YmlDYnErTHRtUmZzRllDOWtW?=
 =?utf-8?B?YzF3MHUzNDB2M0srRnBVZkxpeDJhdGhNTlVrWHlMUXFaMkFRek5GMzBzekYw?=
 =?utf-8?B?VE14UG1waHMxMXk3dE9KazVPK1NRSFczRFJEc3dYQVNRM293ODVIZy9KZ3Ru?=
 =?utf-8?B?anBaMzRYZXZ2VU9XNXlJY0FoRlI3Z01kM2w3cUE3ZTZVTXlTWi9SUWV1amdv?=
 =?utf-8?B?Qm8xWGNPZUVtM1pQSTN6dFRzNWNnbTNtU21JYSthbUFKM2drcHFmM1BRdWhE?=
 =?utf-8?B?NWJpRVlRTWpwcmhjOGFER2txTTlkcTkyUTF2aXkvYk53NEpFcGdRUm9wMWpZ?=
 =?utf-8?B?Wkhja2V4aGs2VUVWeldUdTZFMEY4bHRaVnpoOEpEUkE1ekZIRWdaRTRwTWZt?=
 =?utf-8?B?ODZSNnRpWkl2VGE1VHhHZVRNT3FacVdYM3g0aEdkZ3ZzeVZIK3JkbVcrU1Jy?=
 =?utf-8?B?ZXZEQXJ4VEFVMXlMNmVmeThDNGxZRjlZOEFRTVdIVld0T1RxVEc1K25aYm1l?=
 =?utf-8?B?ZU5vRHFHeTdUbVJ1R29Salp2SG5UdXdsNmJVTGNKbHREUDZGYW1UUnBaSDFV?=
 =?utf-8?B?N1E5RFhKMGZhMXd5SkVSTVlxWkdrd0JZcEJaSzAvRUN2SWxyVDc0ZFV6KzBx?=
 =?utf-8?B?REhTZGdIRy9Jc1lvOWJVaGVFVnJPOCtZOFdQUlZuTTlwN3d3bGk5a05SaGly?=
 =?utf-8?B?VzhmWERQUmk0N1JxTjREYjhoTDRmTHRDSHB2OVUxN0hlRDNRWWJZQm9VWUhm?=
 =?utf-8?B?bHQ5QlR5cWM5RGNXZ1FSYmhxSnI5Z2lId0ljY0FIekVmZnRDYWdub1p5ZGRt?=
 =?utf-8?B?REZ3eW1pVnlieSt4V09wYTc4S01od29WSllWWU4wd1JTV0REV1E5ZkV2Q3hO?=
 =?utf-8?B?dXJuT2hyRldieXg4dE11eVcyZkpRbWtnVitEOWtub0VKWVVVYm5GbVM1MWdQ?=
 =?utf-8?B?dXVZdE9zTzJuNkF2ZXEyM2s0VnRTN1pxbEoySkF2RW5nckNjSWM3Yy9OZnNa?=
 =?utf-8?B?dTFDTVRSV0loL1RIeVNYRytBYW1FWWNWbWdyTkN2RUc5MmJtRjl6Mkx6UUdT?=
 =?utf-8?B?SXcyRkZPeldIK0l3dElwVnNVZ3lCZTAzbk5OYU1aa202UW5najZJZERsTGFP?=
 =?utf-8?B?d2Myb1pnd1p2WkZ4WVQ3TVJWRXNiNGtuZmwrdi9PM3VsM2R1R2dBMVI0WFhm?=
 =?utf-8?B?Zi9RVmVXcEpxQ0JUSzhOMUN4QlprUUZBNnFqVVRsRkdQdEk1ZDA2ZVc3WXlG?=
 =?utf-8?B?aDY3VVJVd2V0cHZpUDF2Qm9vZTZVeW5oSHltT3NwbmpNQkF3SWxBNUNNVjU3?=
 =?utf-8?B?SlcrVEZuUThpS0hPcWJ4MmFXMG5oTEQvV2QxNmJaWVJGTHdRWnBuRjhJbTU5?=
 =?utf-8?B?Ylp2MUNMRTNzNkxqb25rNmVreGQ3OEhudEp0blJJR1ByeUROamFPNWJYN3k5?=
 =?utf-8?B?SFVPNGRrMFBoMzdzYlJLQjlUZjZ6OUs5R2FJYzIxOVY4dzBkQjFVa2kzemN4?=
 =?utf-8?B?bHJRdGVzZGlJbG9QYjR1NzhVNENOMTh2VHEwMFJLRllFVE1oNEd6Q0FZanV6?=
 =?utf-8?B?TTNqZGZtNmdmcXhSTWt5R3R2WnlJc1hjQ3IwLzk1anExUWJyUG1OWDJScDRk?=
 =?utf-8?B?R2NpWldON01TV2w2Y0ozN1R5TS8reE1HS3A4MXl2b2MvQU1JVXJyL3hlTkxU?=
 =?utf-8?B?T0ROUlJ4cW1zbC9SS3Z4ZGU2VEhwSUI0aFVRYVVMTGp0N0lDVktXQ3RGd2Qv?=
 =?utf-8?B?MDd3V2pJQ3d2UmI4RGhwVmtqTFhwZm1tMTh6dmJlaUgxT1VhQm51VmpBd0xP?=
 =?utf-8?B?RTBKRXc3S09rZ0JCSkRIZmdIdzdMVC9DUWgzMzhLc3l5VWc4UStNblNTNkFv?=
 =?utf-8?Q?riWAcuKdNybgRUw7FzhoRFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDE3MFpqMjloelkwUEtwTmVsOTVsL3hVY2lrMnRqdExITHllOWR5UUtPOEV4?=
 =?utf-8?B?NVVmSVYxVXFKSHNvbDk4VHE5OW5rZjMvWE5SQWFWT3doNVRDOVRaRHZiUjM5?=
 =?utf-8?B?anNEVnZIdlF4a3FteGFVRzNTcmFXY1k2b2NkWDQwSDlpbjFqQ21nNURnUUtU?=
 =?utf-8?B?TGg2bEhQTUZhSHdkTHdLRUNYc01WaHZmZ2p6WDRHaTlBRXZ3bVVNaWlkMXpD?=
 =?utf-8?B?T1JUZ3Q4ZStRemJrZ1pOaFM0ekM4K0F3T1I0YjVxeVRGQ3B1TGxaYVU4OVdT?=
 =?utf-8?B?VEVLemVxbnhrWVB4eG9QaFZIQ3A3Lzd0M1VEZ1hGRGxDdXg2WEhzcGRYUVkx?=
 =?utf-8?B?Y0ttK1JHNmZXMEtiRjlNTm9EOStRck1OajV5bmt3NzBZZmp0SnJzWUxlNTFl?=
 =?utf-8?B?QktkWlRvSGlON2JJN3BTdlNvOVFCc2k3VUo0NlNpRWQ4L1pSbWR1enV1Z0VV?=
 =?utf-8?B?WFNrVU9IblJ5VWJZcEpzZkZrSUl0NXhxamkyVytkTUtEOUNPbFpMVGtQS3B2?=
 =?utf-8?B?ZlVzaTRsSzYzQ3J3Q3VmemRYVTRKTDlxSy9yYzVPMFJMTXdyQzFWRUJyTzRX?=
 =?utf-8?B?NFFITFM5RGpIOS8zOU1uVUU5allNUitBRzVvUnVNMytPK2RaZjRtZ3VsSkgz?=
 =?utf-8?B?VGJJb3Q0YytGZGFDN2hCU1duTjRUNnJES0hnTlRSTGVhWUNzQzAxTFJveFE3?=
 =?utf-8?B?SzlTdWtVQU5LTmh6bzkrbUhrVlNOV1YyRS9hQXhLdFhWcFpPRElOTlN0dGNj?=
 =?utf-8?B?UURPbWdyYnBzRnBHVWxOWHloQmNteGZnY21uU1VpRFVqSTVXRUhDdkNYRERP?=
 =?utf-8?B?ZjlId2k0a1RtZ1BVM0Y5bmFkZ2pWbVZySFc4Q2k4RkF4dXBIY3UrbjNIVEVF?=
 =?utf-8?B?UGFwQXljOEhWNC9HbVhUc3d2RzVOMkFjR2lpYURKRGNmNVZRNUcrTWs2QStO?=
 =?utf-8?B?NjQ4cEloc3dkbTdUL1RBWURJOGgxR3MxSExTTWdwQ0I2MEkyZXg1K2R4Ky9K?=
 =?utf-8?B?L2p3ZmdtbTZxTEdtVktHQWJaaEZ2ZGlhRnZWTnJkeFVmN2t2bzg0WE9HQlVz?=
 =?utf-8?B?Q09SRVRic0VyQmdDeTNZZ29GMjhzSVJZQU4rWXpEOStiY1VNYnppUVRKZ3dm?=
 =?utf-8?B?cFhrdk9pUWVidmtUcVZEUXpXWjFzd1laS3V5WEQyK3NUcWI5RHVtZDhYNFZ3?=
 =?utf-8?B?S1g0QkUxejMzeVJ5YWxkYjhKR0dzMVQ2TmFBY3A0eGtCK3pOdzJaVWxHUGNk?=
 =?utf-8?B?bnVhRGRybmlzVHoxSFlJLzRCcFhpbjUvYzB3SmVwVDJmaWViNzVvZ0FkU1Ns?=
 =?utf-8?B?S1lGNkJZRHZiRk1mRVhrd0FjUE5Kb2wySzNkWkhwR2ozQ0pSS21sRFJRZEVI?=
 =?utf-8?B?U3JiVWNhQU5CR0M5aFBXaGNqb1o0ZndxQ0E0UmJxQ0Z5YkxrQVJHdFZHb0Fx?=
 =?utf-8?B?RFl5aXhWSlJCeW5Qdnc3SnlSN1ViU3BOa09HYXhKcjV2TThHUlZTakFCTGs3?=
 =?utf-8?B?RjNyK2o2UVR1Yi9qTFZQaHRrejFCVWs4NjM0MW9iZ2NmQVcyVjRwWnFjSUd6?=
 =?utf-8?B?NnZlQ0oxeE9XQTBsaXlMekxhYU9lSmJUaUlIbVJyT3haMkp2UW1XNTVMdlp4?=
 =?utf-8?B?N3N1UjhadEdUU1d3WkRxVVVtZDNFbUJKay9SdWhqMXRiL3l4SGlJcEtFTTVs?=
 =?utf-8?B?a3dlU2orYUFJcTR6U2l1ZU5iVjcwTFFPczZNek00emk1YmJLdU8wendvQy9x?=
 =?utf-8?B?dTQwWTdyRngvME9WbFFReERZT1MzRldMMVZKWmxzUDg1ZmJSWm5YZGJrbUx3?=
 =?utf-8?B?cExqeS9TNXRJeVVTTFRuZFpkSUEvRjFoSmRCdk5JdEIrcjFJbDBjOUV1ZmZr?=
 =?utf-8?B?Z1NXVGo2ciszb3ZmMHRoR3l6bVZGUDZQVksyclpXbVZLc0l4UHE2N1J2ci8w?=
 =?utf-8?B?OUhWNHFIZ3lvRDRtSWxzcjhPNkc0UXlOZnBBOGNueHJyVmgva0VKUEtLVE5z?=
 =?utf-8?B?TS9BR3pXekJPY05WRmNhMkpsVTlnNkVpcmUvdUxrcG5kRzZ0MVVzVnZZMGhq?=
 =?utf-8?B?aWEvZU94V2N4cGd5bU9aRWhxMytPQkdXc1dLUEdJQjFQeUIza3ZaSjdIT0dX?=
 =?utf-8?B?Qm9HV2ZndTNJS3JMcEZZM0FrUVhuZUZlaExKODJxZFg5Z1gzeFU3VmsxM2Fn?=
 =?utf-8?B?Sy9FYXZLeml3VHh2VW0xSHF6MVUrRjRmY24rcXpYL0o4cjdQWHNsdnhLc0Uw?=
 =?utf-8?B?L0Q3cTIyZms2L1RrS0t6UnJOWllDR0NMaTJQOHNGclFQT0V0M2VuOFVSZnFl?=
 =?utf-8?B?L2srbW1TVWxEdnl4K1lpQi90cTQ4MmswNkVLaG1BcG9wOXoxYnMvdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9db5b7-5d13-4ad2-5224-08de6590e998
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:03:40.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wl4oOjr3/MuZCbVqdlJWQsc2DSvqmDQvKeO504P1Tham/Aa/MjSMDcxw3ehQDqz8AZwZLLbJ34NRtItO0c49LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42233-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ping.bai@nxp.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B11ECFF6B2
X-Rspamd-Action: no action

A race condition occurs during the noirq suspend stage when accessing
bitfields in struct dev_pm_info, causing system suspend to hang.

During async noirq suspend, leaf devices are queued for asynchronous
processing while the main suspend thread continues clearing the
'work_in_progress' flag of other devices, including potential parents
of those leaf devices.

In struct dev_pm_info, 'work_in_progress' and 'must_resume' are
bitfields stored in the same byte. This creates a race when:

1. A leaf device's async thread sets its parent's 'must_resume' flag
   via dpm_superior_set_must_resume()
2. Simultaneously, the main thread clears the parent's
   'work_in_progress' flag

Since bitfield operations are not atomic, concurrent modifications to
the same byte can corrupt both fields. This leaves the parent device
in an incorrect state, causing the system suspend to hang.

Fix this by adding lock protection around the bitfield accesses to
ensure atomic read-modify-write operations.

Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/base/power/main.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 189de5250f256bdc1cdc33006b2c386d0794485f..561e24c257d779db51a0f0d50dcfee61e98de64f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -633,7 +633,9 @@ static bool __dpm_async(struct device *dev, async_func_t func)
 	if (!is_async(dev))
 		return false;
 
+	spin_lock_irq(&dev->power.lock);
 	dev->power.work_in_progress = true;
+	spin_unlock_irq(&dev->power.lock);
 
 	get_device(dev);
 
@@ -656,8 +658,11 @@ static int dpm_async_with_cleanup(struct device *dev, void *fn)
 {
 	guard(mutex)(&async_wip_mtx);
 
-	if (!__dpm_async(dev, fn))
+	if (!__dpm_async(dev, fn)) {
+		spin_lock_irq(&dev->power.lock);
 		dev->power.work_in_progress = false;
+		spin_unlock_irq(&dev->power.lock);
+	}
 
 	return 0;
 }
@@ -698,7 +703,10 @@ static void dpm_async_resume_subordinate(struct device *dev, async_func_t func)
 static void dpm_clear_async_state(struct device *dev)
 {
 	reinit_completion(&dev->power.completion);
+
+	spin_lock_irq(&dev->power.lock);
 	dev->power.work_in_progress = false;
+	spin_unlock_irq(&dev->power.lock);
 }
 
 static bool dpm_root_device(struct device *dev)
@@ -1407,13 +1415,19 @@ static void dpm_superior_set_must_resume(struct device *dev)
 	struct device_link *link;
 	int idx;
 
-	if (dev->parent)
+	if (dev->parent) {
+		spin_lock_irq(&dev->parent->power.lock);
 		dev->parent->power.must_resume = true;
+		spin_unlock_irq(&dev->parent->power.lock);
+	}
 
 	idx = device_links_read_lock();
 
-	dev_for_each_link_to_supplier(link, dev)
+	dev_for_each_link_to_supplier(link, dev) {
+		spin_lock_irq(&link->supplier->power.lock);
 		link->supplier->power.must_resume = true;
+		spin_unlock_irq(&link->supplier->power.lock);
+	}
 
 	device_links_read_unlock(idx);
 }

---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260206-noirq_async_suspend-645bd6b8305e

Best regards,
-- 
Jacky Bai <ping.bai@nxp.com>


