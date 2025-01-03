Return-Path: <linux-pm+bounces-19934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2416A0061B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB24164727
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939F1D63C2;
	Fri,  3 Jan 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NtKJBg3E"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BEE1D63C9;
	Fri,  3 Jan 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893776; cv=fail; b=fm0TINDTb1KMKKAiGsjorxegtaAQgZ5tqdf4xGW0ZBxoHBOfhREEVy/cOYa7RrSVfRKT2/OBrvUTV2TZ3nZrskbEGKx0qP2ufNCS7HuL0Hb05O5K4sx/X175sWKdGrurr6epLsGyNxejhk8L/FccjCdyE3ZzlXABpi+lCA06fNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893776; c=relaxed/simple;
	bh=ZKjmg1MtBFOISkDUMyTeytnGcAdAAATDapDdHX79doQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OlgU2Beb/MAixrBF9d8CniZOeVEBB56p/yQxmBjhgrDpcodgJu1lmbYfzGpVtJHWS+Yli5n+FM+v51Eq1CKfQHZX6nDR3cM7U+IaNdxij9YSnf0WWsNb9DAtP3ifL4IdusQXirI1Id8crfGLe4R2e4iJKhoMbs90/ZaF4snVcRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NtKJBg3E; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeC+NfazkdKVsZEXy+eIyBv1r+W/1dFPndPPVEIauj05/h19cguDfpWxoFma3ZSfh7hjuRIiBaN04DBjujwJpaXnmoGxv89bwnzdx/jHce6dqT6M0Dg9VsTkiJCOuXi+PXb31Obbbscj2MqUjnIlKfINgciGhq9trrBsdEQlqUc+/6vdoN3Oy7Oybl+DR0dxQ1+3gseQPTMw2eHdKWP5+YD3cSigB9Yb+gYWB4aLRxi2DR1T5NACJ2IRWthw4OKAXhuAhIvRcL5B5kB4FspUuyHn0XbOgvKW5n50s3O0uXm4I6SnhOkPWucd0wyhap6vmsyWKT8wARhDxYOzbKwdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukcfnak6rASj1mOqRwYrxQ2oQzH5Bwejo3Xly8lLTrQ=;
 b=wB29f7EcuCWHP7IQcXJoAd6u/aN0JnFIy/SdSRY6OOQdPkJs041KTCR/djxq16CaBNFb4p9XxvKTrO3t5ecrEpezIn1E3wXc07Czc8d6a6A68I+nGHX56uA5KrwdaBYi9d/r5wqazvIL72FdjMwmzWBWEgVMZriI+K/Z6yqg7eGnzP60NZa1wwofTkSNsiRVVSSWgIa1mop3upWQ0OLt69mPgQUg271EFsAIcaRtAEpuwDY3niosKaVlZ99UpBIxhoNH8atTYAJ/vKic/cA61jM5Of6jxM7wPNboYvhWkOw9tlIjLToo6b9lM73A/+9YsuWhIO/rM5jgrNOxeKCkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukcfnak6rASj1mOqRwYrxQ2oQzH5Bwejo3Xly8lLTrQ=;
 b=NtKJBg3EGttxxA9nZ55BpiDOyMVPOopPHXo2Afp1VKK2bLtQxEI9Rgyd5DeyQK9BGUmWgv16I3by1GR21cVkUbru+2nNIjS47r8tWTWpTg4PLt8oYjTrBYuzW2MT3cAluG/RsZ3uiL06zpZK7w8KSVtvyCdMMS/5Is7YPK8orGn9R3AGtDBDYpUdsBpk3aX8MVdI+KqTouIjnufZyYl9f7czq3fxAD3m3rcmPMlf8jEo9kZmAdOHIA9dQC29rE6Sf5Ikc2MiEH4vLyJZI8gwzhi0/QxF3t+mGIHVz5j0jioxx9vRT7pgmlh5T1q842SgUqJ13aEviRUWSEZ3Z3+S3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:21 +0800
Subject: [PATCH v2 09/12] rtc: pm8xxx: Use devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-9-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1049;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GvTygPs23OU+WJ4Ssa5ar7+WSYAkUwf2a/2JL3pAL9Y=;
 b=JPMab25FiuphWW4zg1wpUHsKfC8j4X4PmEXhMG8FlB//Cag8g4nboWS7yj9Rm1f9sO6jqHfMb
 iu/i03TNnEhDEbRkTdAsJEVEhnN6H6MmGZg2Oh/wuw9wXjT9YcZ2lzK
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b8be2a-229a-43b3-2ae0-08dd2bd2985b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkRmYkxoVkNtRmdXR091QTdhMWJ6Z2tuLzdOMUd3RTJRbU1LakR1KzdCMm95?=
 =?utf-8?B?YXI0SXZMbWdHTHhqZWhzcFRPbnBiSVN6Q0ZvTHpEQ3QybGFJNTRjSjFqa0NE?=
 =?utf-8?B?L2doVnlRWk5NYmVLY2VRN2cwZTJST0hsbE1BYVAweEo5cVhJK2duQWxwVWVv?=
 =?utf-8?B?YTBkOGV0OEc4VitOUGYzMEVKdnlId1JTNWl3V3JVR3NNK0d1V1hKbnpHOHpo?=
 =?utf-8?B?NEQ4RFljVHN4YURRY2MxMG1rcXN2RHAzT0xEYjF3OHFvdXFTNmE1SHdsQVhJ?=
 =?utf-8?B?Z1JvUlFhQ21xRG41RDU5TXlqMUxNOXMwZ1NMcGk3MVNocXN4N3lBOTdZdmha?=
 =?utf-8?B?dW5Ic2tkQXVzMml2cWhQeUV1RTdKMG9DanR1RDdLYTdvNmlCaGdlaDUrM0p6?=
 =?utf-8?B?U0VjQi9TdFAxcVZMcHB2OGJKVzQvT2lDNWVQYmxWT1Y5M3A0VUxuZnNsdTNQ?=
 =?utf-8?B?K0lPQjBBMlJIRUp1UGdUcnNYak5JUVdsN2RTaWlETFd4WFNzVUI4RW9tMFIw?=
 =?utf-8?B?Tmg4SmVmVEN6bWNpS2V2OTNmclgxSGZxVzhyd1VRdHUrSFdFVEM4NkRNNlgw?=
 =?utf-8?B?Tk9LSlBtMmRRY243dkwvd1ZQdGc3MVJSMzIzdVY4RU1IbktKM09uTEVZMVAx?=
 =?utf-8?B?RFZMamwyUW44MkplNmpxK0o3Nnh6UHZLYnc0TzB4Ry9MU1lGaHFOUjJkL2Iz?=
 =?utf-8?B?RHViY09WeGJsNi9hZm1rMUdhUmowcDV0bGg5SDVMbkZ3UzZSMEkrZGwxbHVt?=
 =?utf-8?B?VE93TTFZQXQyc0liUVM0cUxtUkZiQnpqSTFlaGs2b096T1NBTDlWMFlnK3JS?=
 =?utf-8?B?Tzkyd01icHhTWkt6Nk1Ka0EvT0dGUWtDQVQ2OENCdDlzTTlYYUJMbTdwRXgr?=
 =?utf-8?B?TE82WW1UeWNSMENtdVZJK3A4bWJJMnVOSDA5cHQ0Q0JYd2x1dzdrL3hqbis1?=
 =?utf-8?B?NEY3ek9BVG1OQ0dERUhZRDV5NFZnNmhMYzZ1N3k0QmJzckc4WHd2MFNiL3hI?=
 =?utf-8?B?SHV3R3dFODhmRXorbis0cExhK2s5SDM4S0ZaNFhYR3A2eUdnYlh3WCtUNWM2?=
 =?utf-8?B?NStPRmZYcGdEdFJpY1QxRDNLT1hIaWhWK1o2RUtFQ1drRXRQRXNTUTloaFdY?=
 =?utf-8?B?U05Udm9jYzVTdXBSdGFweWJKMmo3cWw0NjdPdlhra2ZmVUlBZkJPMXQvNHI5?=
 =?utf-8?B?WXBzd3lpMTQ1dEpLQVR0THV3NXBiQ2EvTTBpMlBURTdONGVydE8rdDVIamtj?=
 =?utf-8?B?c3g2d3JLUUo0NUZORExBQzRBRGR4L3ZlSU4rbDEyaWhOUkNBUFpBVjRHYkZS?=
 =?utf-8?B?SWlvaXFiMWlYVzVpczJuejBBVEI1bTc5cTJBTW9PYWp6Y0VlLzhzeVhXUnpp?=
 =?utf-8?B?by9TaVBYV0I3elMwaFRVSmNkMHpGMlh5UHU5N0lOVnhsQ1laa1FPcEhFVDlm?=
 =?utf-8?B?bXdOeUdtdjdvUnZZS3NaM0NaQnpuM3JqblZzelpWZ0dsMEVBVlBtY1NFSzF1?=
 =?utf-8?B?T1lwTnlVYjRPaE5hK0FPczdvZVo2bUJ3UCtZdUJzNDRUSDEzTm1CRzdLMmw1?=
 =?utf-8?B?RnBJQzQ1bTBNSnB6Z1Q1amxpbE1hd1RCbnJFdlI0eFhmbWMyRVdjcVc1ank1?=
 =?utf-8?B?VEVRUGFHajZuQThRbFBuNFNxRTBwNTA5ek9UT3VHMllkSWkxWmdNWno0SWZM?=
 =?utf-8?B?c3lxNzIzUFdRVGZTUURxRHhaVHJ5cFFaV3FoZktNajNqZHJmREl0cmNUZGdL?=
 =?utf-8?B?YUZqTUp2SnkreGVhUDNKVWpRcXlTenFIVU1pZ290aWRwS2dzUTdHcWVGVjJP?=
 =?utf-8?B?L21IRUFwVTNhSkFDSUEzK1NrSWJCQTdabkw3a2JoYy9WUllPdjl5NVdWUENX?=
 =?utf-8?B?Uk1GVkZMMXN3bDdRTStBN3d4ZkVvQUxIUFlheHZlNDUxYlRlbU40WUJyZ2xE?=
 =?utf-8?B?alF1VnliajJwSHFvNVg2N2hSVGJlaVNLZzRlWm5aYnRHblRrQ3NjUzIyRjh2?=
 =?utf-8?B?UTlKaDJ2cjh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ZvZzhveVBoV2o5cE1iQmdORkJDblVUSThhWlk2TjBvdzBBSC9UanBXR3pl?=
 =?utf-8?B?bk5xM0toWWo5OFRNZStqZ2I2b2YvbVdKQkEzdm1pMStoeVhPMFpWaytQdE1u?=
 =?utf-8?B?NmxUM3lCQmxmMXFyQjkvdHRNaFZOSm12TFMyR1lQWHF4M2VYeWhJM1dUVFh3?=
 =?utf-8?B?d0tDMDlLcm5LZ0h0R0J1UW9NU05zdThBYWJDRjFQblg2T1dKUkFoSzBma3pj?=
 =?utf-8?B?M3dxOGNXRlQrZHBuOU42enFoWjZMRzgvTWo5cVdTSVUyZm4rTHl6bTREQktO?=
 =?utf-8?B?S2tYVEtzcFk2RXBJeUcycmhQL2JBOWJOS0k4V3BwN2RjZXhnRFA2WU9uMG5S?=
 =?utf-8?B?bFQvNDZITEZnOTNYYVN2WTNMQ2l0anV0WGlOSE82MVh4UWpqUnM1SzE4TzAv?=
 =?utf-8?B?T0h4Vk9JTlhSQk9qRkoxSCsxUG9iUXp5L1hYNUlrQURmamw1UmZScmJoMDhO?=
 =?utf-8?B?Z0tsejZnQm1vM3NmVFR2akN4TDFmVjdIWHlTYjhqa1kraVZEcGQrbCsyTkxE?=
 =?utf-8?B?OFVRaGhOQ01LMFdvYXkzVndRMWNrZElGemttdmRUNUpBN3p5Q1c2TUJFam9o?=
 =?utf-8?B?anNNOEVUQXpvaHAzbXFoVnJ4RTBxMHBndTVsOTdRemwyVHJjMEhtM2orNjc0?=
 =?utf-8?B?dUJ1M2JwTEZoVzNUVDM5cFpZOE1JZ2FGS3h5VXBhK000bUR2bG0yT0g5ZnND?=
 =?utf-8?B?QjlyUnZTazh6bTUwS3p1bEJENTA5YTZ0bFZCYmRudHRHS3dWY29nM3YwREtq?=
 =?utf-8?B?eCt4bWdqR25HemFzMFNLTGJjc3dYTnpuK0Jld1FPaFZGdG1VU1Nzb1hNTlAz?=
 =?utf-8?B?ZEg1ZHNFZjg4RWRTUGlsWEFMWmVESkY1V1RhdmUvMUNmMVd3L3IvZmFFdnFo?=
 =?utf-8?B?UHVqTi91Y096dm05YkZ5S0Z0VERVdjMvbGxzLzI1ejVKaHU1K3dOSzlqS0gr?=
 =?utf-8?B?NEZhV2MrS2VwVXdBUFNiTVFEMzg4VnFnaVVVS29WU2kzNFh3NE5FRHZ6RjhP?=
 =?utf-8?B?bitUNW5pVnBMNUVQOEFuY1NySW1ROE1OQ2hOYU1WMkladEhCQkNxcjJxeHlr?=
 =?utf-8?B?cFhQaitsQmxEYU5aeGRtNTJ5TkorYVl3QVNRbVdRSHdVV0dISWlTeDM0U0M0?=
 =?utf-8?B?Q3F1cWFMMGJOL3hKaGt6WDlJaDl1RGdNR0hSNTgrSmtCd292MUM5akhUUkln?=
 =?utf-8?B?VEVtQzFRT0xxdVJKaDNnU0ZWaUM0S2Jab3FDT3p5OHcwbC9LdU4wa0FDQ3Uy?=
 =?utf-8?B?MFRuNlEyM3JhU1ZrYmExTGk0MGgyZWloTmltZmdCbnNEcEhjSWQxZmlqU0Fx?=
 =?utf-8?B?LzBJeUFLWXF2L2pNcWNJT0lrRFoyRG1SQjkzOWpWTjRweE5tZmNzYjYxeFp0?=
 =?utf-8?B?b2k3NFFNZ2p2Tk42VkM0ZlNCQmoybkRuY3pJcVBnR0xNbzhxTTZTQUVNNUk1?=
 =?utf-8?B?R1VSZGN2aWdaNWRzWEtJQXlLZEsrRXFTVmUxb2ZVNk8xRzFzb2dRbUhHZ042?=
 =?utf-8?B?T3pKRWR2Vzk2S0ljMnhoSDZVcmdWUU4reWk0dUp4TlVMdkZydlBydWVYTm0z?=
 =?utf-8?B?eHpCa3NlMzBVMlpLTEt4TmtJL3Frai8rMjN1NWhhU054RTRNT2drRE5PNnNZ?=
 =?utf-8?B?bnIvNUY5WWNkNG56UTE2RXRTSjh4YnFDZm5iQS82YWFJRWIwL1QzNnhHOEVF?=
 =?utf-8?B?YzAzK3VwY2tYUDRMMzhLUjFidVVQZUhxdk9ad0lGNVIrVjhYRFRQelpkUDlN?=
 =?utf-8?B?ZWxKd3pUaTZwTTh0c0pkZ1R1SWZaSDAxczllcE5xZ1hHaWtMWW95WlAwMEQz?=
 =?utf-8?B?OTZsS1hVSGF1M2tYYW8wRlUzSC94NERiMHVPZ2ZnWHNWVDZFRExpbkRkb3k1?=
 =?utf-8?B?S2hMMmxRakdmUVczcXFEdHVERVFkY3k0UExRL1dLTklGa1YvOUdNeFh6eXIz?=
 =?utf-8?B?SHBjNlBxb2w0M1lZYlh1cVdvOTl0dkVqQVpxaUJ0MjBraWRxbERqMUZYVTlS?=
 =?utf-8?B?MHhUU2p6WGlYci8xaEZrOGVFS3FRWVJrdWRQdHc2Q0tEREF3WFd6T3RCVVEw?=
 =?utf-8?B?ZU5PZEhvNllFd2IrOXMxSHArMVlHc0U1WFBDVmQ4a3h5VnVWTXNPMmNGbG55?=
 =?utf-8?Q?IotRMBB2M0a38Fmdkkg0VT6YK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b8be2a-229a-43b3-2ae0-08dd2bd2985b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:46.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5Lh40lqSLsdrDSJw2rae9QAHrJbyEHMLWXM7lLzA09cYN8S6y6ee7bR5+SvM7ZYvUMdwDroOR8zAL/Y3whlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-pm8xxx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 2f32187ecc8d3276a451a317ab83446b7b04ecc8..f1b620b168fcca8c640e4beaaf7e8c17776c5ed9 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -523,21 +523,11 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
-	if (rc)
-		return rc;
-
-	return 0;
-}
-
-static void pm8xxx_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
+	return devm_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
 }
 
 static struct platform_driver pm8xxx_rtc_driver = {
 	.probe		= pm8xxx_rtc_probe,
-	.remove		= pm8xxx_remove,
 	.driver	= {
 		.name		= "rtc-pm8xxx",
 		.of_match_table	= pm8xxx_id_table,

-- 
2.37.1


