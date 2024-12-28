Return-Path: <linux-pm+bounces-19797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C436E9FD8B8
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5A37A2775
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8114AD17;
	Sat, 28 Dec 2024 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L8NSaMO5"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77E26AD3;
	Sat, 28 Dec 2024 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348579; cv=fail; b=pL4XfofQkuOIZci5ee1NGWIhmL+7+nKxbx6r1dkymsEHdiezcduMRTN8GDQ4fypZI8Xf//2MMDameSOMzug8/8maW8vmDwvk4qAq7usPLl8JjVqtDGQW8HyquMxjhQwV31joHHsF8MUaD7rnRj68RB4Acxxu5YwQ7V6aEmetlfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348579; c=relaxed/simple;
	bh=/EC8zCoNiyDgYUl3GWxR1c0E1R02p9BWvo/Wx1hJgus=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iFkmjSiCsSUPQOIrVCR/DMJFVlVtbVTi0rKCUdmuvqSS9PNSf1SsYIxZ8FhT4TKT3vCgO5qcZM41jdkknjMbdTW046Xjakz68Eq8r0+PnjzecG8q8ibxWJl8H7Aw3dZdFjg55bYSUxFd42looUknE91eiEYKmywWjIciLCkwdaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L8NSaMO5; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7BjqXQfM67sPkUVU8p/a6OUUzCONkcGG9JgkMe/PmMIeQtUivzj/EnG5J50tDl+/wFg4/ca4MZSsNPzSpOnkVzyt8Ren4XSdguF9vgwHPQy/xMfASSO1b8BtxWznwOoJuQUiIYKnAzzVFMinJrlwb7rF9CLD3+4YHNgvonCaN9xjLriv7Yb2UJk739Y+GIBr1t/IuUP6Xot0bi6yDjhNAhS0BbmMgS3k+kzRHFqV/ULzl475z2R+5uhk4fZmq6eKrV44uxX2mySIo38OwnK/G6jrPKlkewmTK5lrnZ469jcJ2z1SRSUwccGlaet0GQClx2SatkzjzpV7sJGlVFriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsAJU3FUgsUM88m4mSGw1WR2K15UVHFt8h4YUCR7Im8=;
 b=jUi4AC7FKXkStWkLhMCJK6ITtvAugeV+cOSxWiwaW7fmenKLpYY7RPq7pOAoiFeHscel61xZEdpW3AoZaTFu8DAP5r9TVBKHG43zatdo0tB2sHfWtZ/KsJ+cs4zXyr4U9t/eX7gt71dKF5Z939vD3hdHOE2qDQQA4/qyEqSw37EmUIvvDV4k8/Sq90vPBMYmXg8uAnffVqtIkmnRiAIksdgiWDYBkxVurxjofSZn7uFnuOhzL0hql/fbPVOcwm34TS3Nr4PNfMqvdMnSrRmmuP6TanRxN2P4i1BKCchadoI04RLl6SU8Sp0rNgjfXpsULbpwwh+XQCXGVmE71pD4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsAJU3FUgsUM88m4mSGw1WR2K15UVHFt8h4YUCR7Im8=;
 b=L8NSaMO5bMY3D+ZNNkX9P98p8/aWXPNZSbUcdrvrKlI9jvJU/QAcn4ncVGKm0wr5VJl4PODd8Z8bSxohG2Bv6H2xbDR2FiaTcRhDaKnVscLVzmdERpDo/D0KkHZ3ij2ByV8+AfigSM/NJplkxfWVUMF+iulhDX1GirbPETfffm38glLKAVv2nmEwrWdHbr9JAePm0x3pbdH9N2zvrALFQsltQRPzI1mPaPrMhFsjVvxJ1um6qeF6Xy8Iihm37xTClw1ewV8Sfj+rKurPmyT1v+wYGpMtcVeq/1S0aTtQfFdIjDzvPC6k4jpWTq4YI5j2fFS++lFan0D0yOSC9CBlIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:16:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:16:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:47 +0800
Subject: [PATCH 11/12] rtc: mpfs: Use devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-11-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1347;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7sZhYfT/a75JkuPsULgAYPAtV5pnc5lWQRqy0mNIenc=;
 b=C02+WNqxKfAAf7mHi9bvaN45rY3SyyhH/d2aF3re2z0PhFA27PAuCbEo4WSccOkmHtNlPz+yL
 QsNBVl1prIIDgaoDXhtnsXPRGmUvFDBevQHs2g7/KFmxAsUGG0hhVGu
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
X-MS-Office365-Filtering-Correlation-Id: 8ef3df23-780b-404b-c7b9-08dd26dd36bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGtiemdmYkk5dUxxUVNadUVVV0lOVmphODkxazBJeDhsaU80cG9GNUQrWUxq?=
 =?utf-8?B?bGtTVE9aeE5lVHNSSzllWmUzQUhpYUNqUWxqcUJadE14K2ZndGRnOVk3STln?=
 =?utf-8?B?YmY2Q3U3NGIreVBxU21neVp6UitlNDRaUE5vQy8ya3lzRzJkOFRRTEtVNnU5?=
 =?utf-8?B?R0VUMWpLZUJKVUREdGo4L3dsekY5alhSS29heHViL21xVzJ1cUpnNU9aaDFX?=
 =?utf-8?B?WGNxQ05yTWlkalVyT3psQi9ZeEwyTjUxMVlxK2RvaFNxQjVSQm43TG5YV1NR?=
 =?utf-8?B?dWEyMHFrUDFGZlJJWnJiZVhBekFKUURtRzVUa2tvZ3dDRnQ0Z0dSK28xc04y?=
 =?utf-8?B?aG1SZ1RkbGtpWDdnNWc5SlBnZXlCWmkrMmV4SlU5T28yc2xWWU1NUC81Qmxn?=
 =?utf-8?B?c0l0b3Q1eThnUEpJd1NtSE5ncnRoUGFCdDRBYlloZlBDN2p4Ni9KR0wyeTRM?=
 =?utf-8?B?RzJLN2UrR2ZEQ1BtRTg0RWNwOWZEekcvVDl6MVpjWFNLQUFIU08yK2F2aWFz?=
 =?utf-8?B?SlBBVnhqa2t5WHNKb1JyUVIxd2cyR0tvNUR6WlNxQUVjb1ZDMmVRVFoxc3k5?=
 =?utf-8?B?OHpNaEpHeXpTSnRPRUxnc2hDSkNZdXdxR2RrcmpwZCs2UWRnczB3SjVPUWJ2?=
 =?utf-8?B?dEFDZloyQU9tRnBHM0RUQUU3ekxtbVVBNlRveUltOUtPMmlNeHBRVXpNQXRY?=
 =?utf-8?B?V0xHWGsrSGExZHFrbEM3R2kzRHhlODlHOXNvblNPQTFScjJnZ3pKWEdoMUdR?=
 =?utf-8?B?WFJFaVJnekc3M1liSHBKODJQa0hINUdSdFJLcHJVTmIvU2JjaTQrWkVKV2ZQ?=
 =?utf-8?B?R25ya2Qra3RSYzU0dUJyazY1b0xmTmtMM0lNWCtKTFhJUHhBeUZSbzd1Q0Fp?=
 =?utf-8?B?bUNKNUw2b1N6ZUpmRTYyOTJMdDgyeEU0WWxpQ0plME52aXJ1azZyNVNSMjNj?=
 =?utf-8?B?M1NQUzhXblZRYXRTVGRHWGFFTUp0NEtBelpveEM0Z2p6cXppclJ2dFU2eTlC?=
 =?utf-8?B?dk9xUk9nRVdBdVJHNEtSL09oYVFIbTZqN0toUXJRbTN4MmRNWWRidStZODVZ?=
 =?utf-8?B?TG9zNUdnakppOHM5Z1U2enFiTzFzQTVoSVVLM2pGMWFWQlYwdVYyOFZSRUcw?=
 =?utf-8?B?WUVud1ludmFyUVBXTUVUM1BxYS9HcGl2bGlMZEQ2UnNDU0R5a1d6YTVsK1lS?=
 =?utf-8?B?NGl5NndROHgzeGZlTEVHVjNzRXdmRGp5d3I4dVo2dW5LSGRpWjRMMEtvZmF1?=
 =?utf-8?B?K1dQSmV1MEhaeGl3SEorZ1lmamhTMWw1YTNSY2RUblM2VEYwQmVLcWdUMXN5?=
 =?utf-8?B?YUV4azkzTVJtY1dXVEZyN3FpREhzcFpMeWt6djFIREtaYVBKVkhCejFuNHhQ?=
 =?utf-8?B?Y3RvaW5oVDdkUWs1QkN5UGM4dGR6ZzNwYmlkZ0tVQTA1M1ZMdE5zdjFFU0ov?=
 =?utf-8?B?OXRncUQ2MVhxdjA3OFpUdTRPS2tVdVEvQ2dwWW5ZdktwUlNzMHQwV2lzM1p5?=
 =?utf-8?B?MXViNk1wNGhJWUg0anRZalNhQWF0dlk3RHZYU3pEdmJvSXFFcERRVmZwSGNr?=
 =?utf-8?B?N09vRTZXOW83R05zR0U3V3JYTDRBa0tTdzUwWDJLWmx2VC9NVzBjSm9IZVUx?=
 =?utf-8?B?eWlKRThhNHBYbUt0RGxHUlBJWkNqeER6eVlNU0JTdTlaTlg3dExtUTJHMXNY?=
 =?utf-8?B?Y3plSXFwZ2xBYnZyMUNpUjVDbkJkTWVLMVIzR0JHN2lTR1BMYWtPOWRBeTMy?=
 =?utf-8?B?VE9kVW52REVjS0N6MEc4NHdkUEgydS9ab1NxaWxFRVpBY3ROcHRvcEI3Z01W?=
 =?utf-8?B?OHp0Sm52R1VNUnpPRnFWRW84S09naUkwY2RieHV2ZEVROElzN3JmbUVwMlZB?=
 =?utf-8?B?R3Arb3IxR255cFhaOGwxbjMzcGFGMDVvNFhHV1FieFlSWkxCdnZKY2xKR2pV?=
 =?utf-8?B?bTVwWDhwbng5a2RyZUd3dVRBUmJxakJwSVlQaDUwUloyUjdwQ1Z2UXllRHN4?=
 =?utf-8?B?WFBDOElVOFBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0c0NkxpSHU4dEsxSHI2Mmp6K1pVS3UrcFFxb2loRlYzdzkrR0Jyb2t5cUNT?=
 =?utf-8?B?aHJ4OGNlbXZDMUt4YjdSa0p2RUF2QXArYkgvclU3ODI0OW5kY1lSUG16M0ph?=
 =?utf-8?B?aXpNdG52SCtmQmRnVElyOGJpZDNlTm1kOXE1c29JQnhsQ0xyazg3L1ZaUzhq?=
 =?utf-8?B?T081cEM1dzA3d0ZKVkxFYjNhb0FUUTdUQ0c5Nk9XVUFhUmxmR3dtVjVkV2xy?=
 =?utf-8?B?NlhRT3pUbDZ3aXFZRXN1ZkdYNFkvRElZS0FTak1qbmNVQmJBWml4Zmg2c0ZG?=
 =?utf-8?B?YmtoZ3RyUFNERTltN0FjNXdFL1RacHJZZXZtNzhSQk9GSTZBdEZlMTRlMEta?=
 =?utf-8?B?RGlSSlY5S1BCSDhQWjZGbzZIOE5RcjQvcVNsSEZ0U2JJKy85cW5aMzMxdTZQ?=
 =?utf-8?B?VzR1YVNVUmJ5S3JSanpLeTdrRXNPQjBTcXJvU1V6aThLSHRtd1RRalVxZHA1?=
 =?utf-8?B?M25Cdm5iRmg5QXlZL0poNDFRb2dVZi9iMkk3YVlVb3RIbEdCYnI3T2xlR1FK?=
 =?utf-8?B?RUhDVWd2TFhIbHFscUR4RmNEYVBpZjkya1V0VFV4S2Z6T01oaWg1c1FVNVA0?=
 =?utf-8?B?OUsvWEFMbXBYQWlBQ1RqVGR4TW1CcFVUeXB4dkd2REVtWmFreGtsUGRxeXRy?=
 =?utf-8?B?WnR2eU5LQTBtazhMYkExQ2pTZlgvUHloMTd5WEdBY3hlSHJFd1pvTkx3K2tj?=
 =?utf-8?B?ZDcrbmJnK1JXVUl3TFRJM3g5S1ducTJIbTF1ZFRRYXhKZWI0QWY2SDNaajgx?=
 =?utf-8?B?NU1jVDhnR0xFTGtTQmFSZzNJUXk3a3gwZE8wUjNSRjlld1JRR0pxeXlGdVRN?=
 =?utf-8?B?SURjUzlyTnBhTWlnZE0valIvMGhXSTZBbzB6UlJNQWFIcGxqYkhjYTd4OUtY?=
 =?utf-8?B?cjdMajE1QlN2KzREY3U5YWRJRWErbzVpcCtKK2VxdXJMZEo3dCs5anBHQUxn?=
 =?utf-8?B?MEVqc093Nm5EZWU5MmxWMGN5a2t0Z2lpeitvZFFGRVRrdmRQcXRCc2psdVFU?=
 =?utf-8?B?NHVMMnFUM1ZWYVdnbEdhelJmaHQ5U0VtK3JhWmdjTTB4eG5nQzd3Tm1QLzRS?=
 =?utf-8?B?d0ZoZEN6bVIraHhyV3krbzArSUQ0bkVqQVpncE5RZmVXd2dJSGlRM2RIaDU4?=
 =?utf-8?B?Z3hOWVlvTkM0bHBIMWIxOUpOdG1xWWVFWm5qQlp5aGpjKzdzbE1TQUNFRmFs?=
 =?utf-8?B?Z1J1QmFSdGxnb2liTS93WTZobmluYUtqWG4xUUJLNlg3ZTVWd2RTMXU5NHd5?=
 =?utf-8?B?Nm5GS3pvTkRsTUwraTB6NUI1MjlPek5uaFZBTkllbEdwZG1Rb2thRE9kUWRD?=
 =?utf-8?B?MkhjQ0VRWUxtd3lRam53NHZlQVlDamkrcUlJUFpEZjRvOGtoNkZNenVwdnlU?=
 =?utf-8?B?eGkzVnVNdjNNNTQ1M0tUbDFTRCt4YXRQTGhQVVhmVVJmMXdWSS9zVTc0Q2M0?=
 =?utf-8?B?dGtqTTJoM2E0ZXhVa3c2azZEWXdoV2Y4UFl5WllpVkU3MUV2THFBRERYSU9Q?=
 =?utf-8?B?WU5Vd0xjZHN4bDlWekpnSEdSSS91bDJVSno2KzNSbmt5eUpJYitGb0tsc1Rk?=
 =?utf-8?B?bm1tYVRlRElFTWpGdjMvTFZOMVVSd2wybUxvb2p1WUQwcTVCYXVBcEdoUXdy?=
 =?utf-8?B?VnRZaEpNSEhtUS9KUHhxVCtlWE51dEsvelIzV2NjOHBLZ3Q2c0ptQnArNEJn?=
 =?utf-8?B?TGZIUVM1cy9lbCtpVDQrckhFM2ZJVFgyQ3l5WmJGOFh1WG1yQk1qa21xQUZZ?=
 =?utf-8?B?RCtPdkR3MVU2Sm90RkpUeHdGT0wxTUFTTkp5UnA2aWhxenZuZk83Rml4eWhh?=
 =?utf-8?B?TXZhWktNWkFDVUpaWGhYYzZMdm9GMmV2aVdTZXFBTVBUcnNyNElxanlEWDYw?=
 =?utf-8?B?N2loQTM0VXU0dnRJbjdEenk5dWhGWG1tWnNxa1htL1ZtSTM1VmZkeGVKVTdh?=
 =?utf-8?B?SjBibHdEMXoyM1k3cDQwREh2SnFWZHhlK05GT25wM2xCa1BMUGlCS1pUNXdo?=
 =?utf-8?B?ME1QeWcyb29wakZNNFNMeXEveWFla3RRNWJYb0twYXBpMUdJVUE3UU1WWDJD?=
 =?utf-8?B?em92aEtEcnVxeXl4U3MwK1dlTUxMa1Zld3NacS9nZHZqWWJaY1Y2QXprUmJW?=
 =?utf-8?Q?Bi9wwXWxixUSbJY0l7xVzoye6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef3df23-780b-404b-c7b9-08dd26dd36bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:16:10.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSMkfeYsXxTgqcNrLWKeHIr3wkAYAF9gNGHiTcapqOUgG8r/cQkn61igxcVN+NC7nOV/kKRKGuv/LcA7+7L9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-mpfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
index 3892b0f9917fa7bc4f732cfe2c2b2f548ba7429f..5a38649cbd43b3c6f2fec5db95c4f0013deb2a08 100644
--- a/drivers/rtc/rtc-mpfs.c
+++ b/drivers/rtc/rtc-mpfs.c
@@ -267,18 +267,13 @@ static int mpfs_rtc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "prescaler set to: %lu\n", prescaler);
 
 	device_init_wakeup(&pdev->dev, true);
-	ret = dev_pm_set_wake_irq(&pdev->dev, wakeup_irq);
+	ret = devm_pm_set_wake_irq(&pdev->dev, wakeup_irq);
 	if (ret)
 		dev_err(&pdev->dev, "failed to enable irq wake\n");
 
 	return devm_rtc_register_device(rtcdev->rtc);
 }
 
-static void mpfs_rtc_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-}
-
 static const struct of_device_id mpfs_rtc_of_match[] = {
 	{ .compatible = "microchip,mpfs-rtc" },
 	{ }
@@ -288,7 +283,6 @@ MODULE_DEVICE_TABLE(of, mpfs_rtc_of_match);
 
 static struct platform_driver mpfs_rtc_driver = {
 	.probe = mpfs_rtc_probe,
-	.remove = mpfs_rtc_remove,
 	.driver	= {
 		.name = "mpfs_rtc",
 		.of_match_table = mpfs_rtc_of_match,

-- 
2.37.1


