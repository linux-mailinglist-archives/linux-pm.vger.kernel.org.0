Return-Path: <linux-pm+bounces-19933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E7A00618
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450CB1885005
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52851D61AA;
	Fri,  3 Jan 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JM9SRDLL"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBE1D5CDB;
	Fri,  3 Jan 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893769; cv=fail; b=Mhec7ZcTC+ehO+7Mji5GtkOdkSQg5DpLQG3huscJfXqDyX+4x4yZLVhIuxrzwQlpno/Sr7oATgPMVrfD8ibzWNrFteZ++zBIB7AkvzNgu1ExkVvFYd6Ekz2fDlpESaA4KtXPVlMQgI6MqR0xeE9Qx2eqmo58qDapgWn6YOgGp90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893769; c=relaxed/simple;
	bh=BO8Hwal6yUEtmatjGxTeE8CGMKa+r4910TYtu1OW9Cw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mOnhVeu7mlJ4arAq52lDPpxxuVf23wPOTHFf6NpZnXLcSKRcwv/P3IXc94kEX28Jhs2cXRsDKqho2Z/96Lb6tlmRY9Yqlky35KAumUdLJhGUri8r+x2S+ch50GpE1RKMRMVkCVU3oNkHKlXf1ZrBX/vUZvnBOf01n4kgujTNXro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JM9SRDLL; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buf2XaHbOo0mnUHhZBium0o4JAe2v5OHZ1ilDaYKSUwdIQ+rOI5vu2bs2oHD/wxkTsV+NzCG72Rm92V2IUQoxd5PNNfi66bThVNcmEyQqZamJapaJNXros8Omqem7u7jAZt7oCDhArkOMtk0AF2v1Oq2eSGShFL/rrrpbbq2K7ufyJvIfjiI6JDnDcFaHNPetFDmV0HdAp+pMj+K1C6DeRbTPgSLLqKzeJh4FDY4eawrW8kny7uYRhQ5UIAfPurgdAuV37E9K1ati5ZwpzaI8xfONrkgweR2tPmQOLiRc4T0M9g5wjVTtdXjFK4PVPIjbh6RI/awaupwKBsWDCt40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQmjc+FMqh0dI0wNgt8HMjgVvX1TWtUXJ1FCgaXAoBk=;
 b=IpM0rpaeD6cHgPulshGi62S9Lvk2VaqvRIS+cQm22Kg/nQkjZjvIrvjLwxBj6bivtvDB+3kPqYsq41HELwQFwb0qYX7TgkGB+H1DgJb55LswQ/S4gSeHw0JxiMt/3frxeKvC3AUtZsfl66A0lYMEe+MO+VUqFc1/3TPvPyT7cuunFInJQgsKThBWP8qPgt1uRRFaKuKwJt5jL/IBbSJX8VSuXZ255ux6JMwzD6hnFD+arVF/aS1Ga0ikDXeW2Zdxwn++Qz7WF9jClcMrn5ed2mHN7/jKxGIqwgyxMZqe1Qha64mAUQsX5sw7RzMmV31cB9EuNg65KFz2/tVJgTUloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQmjc+FMqh0dI0wNgt8HMjgVvX1TWtUXJ1FCgaXAoBk=;
 b=JM9SRDLL7Iai7G4X/dCL/0+6Vy7tLFMfeOqFCpg+N29s1AB5cGuB0YHlfmq+wczIphIuevu0xZBjXmxxJTloR9EyVGHTDCDqfm5FshggeaAJ8RL+Sur37NuwAg9dxQrr+ezWlIqI9kPBUw5aGEOl2U3iGAJBfKwrimcIgL2aUCIsFW+L1FIMNSQQgi46QeAnniF3MpwKq98FC3tYQFip60ul7GngCC2U5lABIZHMw9x/9Bwg5SzrAZZe4O46Ue3fBAWIKdjoPWJUwL9pKKoX7BPIbdjKnhBJluP0KXwnL+yRBmEETvLK90mqQoGs4QCkX/5h+qqknge80DMOIRZ9sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:20 +0800
Subject: [PATCH v2 08/12] rtc: ds1343: Use devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-8-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1119;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yYeVC601Fmqm3h8IRsE1e0gqqkwuyZ6uKwkA4brZ+6s=;
 b=frrewPLMHBqjUxMa+a+fJPMsZKvOP0ydpssUsy2Dl4jy3KEwpr2k2XS9bf92qot4Pcgk5A5Sq
 btsu1E28jMfDRRyXatmaIw5jJojAERsH5wy1AoFyaExNc7XvPuWJVZg
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
X-MS-Office365-Filtering-Correlation-Id: 2e33ee89-b252-46fe-0276-08dd2bd29527
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGgrWjBTSW5BdTQzOFFoMzRGZ29uVWFDeWozbVZhVFNEVnN4Z0EwS3grMEZ2?=
 =?utf-8?B?WVVYbmZ5ek5IaFZoZTd6ODUzZjhTU2VxeUJXOFhsL0VuOGgxWmxnc05mbTEz?=
 =?utf-8?B?UFFnd0NuREtDMTlVa2FYcDU1VnE1TE1GWDhXQVBKVllMMld0ZkZMWWVjWTIv?=
 =?utf-8?B?K3ZEd3R1bmdqakI1M1A5MGNKRlcxRER0dHFsa1gwWlk1WlV1S0RQdUJmVjV3?=
 =?utf-8?B?eGFUNmNnODB6bDRHeS9PaUY1QktRUzVOMFRUc1JBdzBUR2lJbm9EVjg0bjJX?=
 =?utf-8?B?cE9Yano1R3EvNFUvSC9uajJ5dUtRTVhzNWN3eWltL25ibU41akU0enNCWW8x?=
 =?utf-8?B?UFNkQUMzZUdsbERYRWZvNmpZYTlPS09zL1dyTXM0M2pmc0QvczRWWVJISUhV?=
 =?utf-8?B?Ky9XQ1lDeDVwYmdaZHBFRW9INEY2anFzbWR3UzZMVG04ZkFrUk5Nc3c2elVC?=
 =?utf-8?B?UC9zUkZ6a1VIU1VGcmZCRTRWNE1rMnYyWEFRS2pMWGF6S3ZSZTdVZGpxUUFP?=
 =?utf-8?B?Q3JucnJRY3V1MzJ5cDFKYnJ0UFJmVmNtVUNYOG5Nc3Y3S0hLYmpVejZkQ0JZ?=
 =?utf-8?B?UmJMOG8yaktWRlZwU3RWZUlrcDNBTm4yR1kwendHeW56dmZnR2NveERFaitS?=
 =?utf-8?B?RjV1UXp6dnFGUnRoSTZobjN1WGxSTExSQkgwMzBzVHZqMFdKbEJMRGJCOVh6?=
 =?utf-8?B?dUdyTnZPV0JiMmNxSlRDWlFEUFB5anN5a0tvaGU4UUx3TW54clFVTXJvc2k1?=
 =?utf-8?B?dHhmS2s0UUdCSzhFVVFvQkJqQjVsbGZBNi9pdjhQU1lMUHAxQ04venpOT0lO?=
 =?utf-8?B?ZVZ3aDFDMyt3UDVTUEMxRnRRZG5MYUdISS9sYzd0TzF0ODBPNTJDN2pMd0Ft?=
 =?utf-8?B?SHYrWkkwakZ3K1Rra1FNMUJZcjF3c3pVbFFncENPckxkc1lCWktraW02M0hZ?=
 =?utf-8?B?SEtsL1VVbVJjdnMxbUNXQTlkc1BVQkR1cGYwWC91RlBmdEw1MEt6cDBSRG5s?=
 =?utf-8?B?WVZvZjJ3ZVFGQ3BPTi9jdERnY3NoeHZBV2ErSXZ4RWVnWnFNc3dkYkRlM3hq?=
 =?utf-8?B?VG5kVldQMG5LZTYxMFVEWmhjamFyVEFUT2U4N1lBbTFhc3QyYlhsYXQwdGZn?=
 =?utf-8?B?MlFVbUZEUXRKQnZOaUdmaHdLci8xLytqNGFLVE1MNW81b2x1N1dxUU43SEdH?=
 =?utf-8?B?YlUreExZQmlXL1NkUlQ1eHlwaVNINWNjS3RYZHJqSGZwV21jSm8rTHI2Wm5N?=
 =?utf-8?B?dVZxeThrTFZKZFhqRlpRbW1PMDI1VTY1Z2oyMk5PNWlpWGRmMjBoM3kzd1lN?=
 =?utf-8?B?S2NUa1dGbjVRTzFyVnU5UVhGZEljNGZNQjRLLzBTS2dRVUhHNS9YaDdCZU1x?=
 =?utf-8?B?VXFnVlZhUXlYMW9SNG1iSXQzSWJPMXFFUEVQVVdGN29ITnFQcmtnUERqQUdJ?=
 =?utf-8?B?QkZzNkFQTFdrT3ZHM1pFWkZXdHp5TU1sS1VNNEYrTHdtd1k3cnB6aUd1eTBG?=
 =?utf-8?B?bTNIcmtMb1dKa1ZDWERMYjVKZWtCd3p2WURWbzVJVytKTXozWE5ob0FlZWNq?=
 =?utf-8?B?NUVPQ2YrWTlXeXpXTnRaWThDVXlQV0lWdWdaYVFXTmEyZ0poYkthV1p3R1Vu?=
 =?utf-8?B?MlFnMXV3VXoxSFdjd3Y5NjVMOEs4c1Vmb0lrcElyVjMwVlNRcXAzRXY1L0Yv?=
 =?utf-8?B?UkdjMkRIQktOZENzTElFYi93elF3T0RXaGlHRVFuWTg3TllaR3dFRjgzUTI5?=
 =?utf-8?B?L2Q2cGsycVRmU1V1aFh1ODFoVi93b3U4cFB5Z2dQdzBpYmp3dDJnSTB3a0U5?=
 =?utf-8?B?RjVaNEJmWEFYRlhmdExQYjBXb1VSQnM0bjAzNHVRZUlpay9rb2lhRHRYVnQ2?=
 =?utf-8?B?Z3BIQ1JMOG9WYnBrOGNjb28zSzlrSXFPRENJd3d3YVVCWFhpKzAxcVZSOEd4?=
 =?utf-8?B?bHZVSWlWMWFtTndZSngzREEyTFR1Qk8rU3Z2UHdlWi9DdnVFTUdyL2xqZGlE?=
 =?utf-8?B?bThQd2RGL0RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVlpek0yUDVwV1l0em94eVpWWVBDdXNVSjltWFgxNEFFRkdudENvMThhbm54?=
 =?utf-8?B?blRleGo0SWJNTnF3eSt5VVhVcXFEbDh3alRkdFVZemRNSFMwRmQrVkVvZHhF?=
 =?utf-8?B?TXFHUWJWSlZ5aUo4WVM0eUpvWnlVN2NHRUdJenpjUVNlazI2c1Z3cEJNWS93?=
 =?utf-8?B?eVBVWTVWR2t0Ukt1OVFLMUNpaVlISk05d05OVmxObDA4TnFDVTBVTXNDbHVT?=
 =?utf-8?B?dlg1V2w1UnkySWlYQ3A5QkpOT2FCUFVuR0czSGk1M0lZQ1pyR2p2VVVEZW5u?=
 =?utf-8?B?U3hwYVRVbVVWWXBLRjY4ZThOcGcxQ0xaR3ZtMWtiSGNRM1FQeENkbVNxaXNl?=
 =?utf-8?B?NHVmOG0ySE5YTEVIV2V0a1BBRXFZVEoreGxoYmV0ODBDbDgwL3RFb1lsZWp3?=
 =?utf-8?B?T3lxS1g5WDRBQk1OQ0ppV09RN0tJRVJLWnZ1ZDhtSDk2Ujd2RktBUW8vZ09U?=
 =?utf-8?B?U1huWXR0WEFzSnN1UThrMmZCNDF1VFVRRnQ1OW1GeWwwYjVrN056KzJWa29m?=
 =?utf-8?B?ZXBHZjY5c1lFM1dNNkNxUE55UEhrcFdxVHNHMUVINHphcEMvN21ZbnpNZHh4?=
 =?utf-8?B?OWMyNFVqNDZQek1OZjR4akxIckdDUHlIa2Yxem1pNXhCVlJzT2ZZNHpqdjFL?=
 =?utf-8?B?QWlsNEorU1lEYzB3ZURYcFlsUk9WL04rODFiVjk2WEQxenJvQVM2YmNraTJH?=
 =?utf-8?B?OWpoRy9xeDJQYmgwMDBSQThpSWJ5VXdGamRaZ0R4TVlRWFphcmRxbkFEcXpY?=
 =?utf-8?B?dWUyR3dydkxKK01yeHl6MkpCU2dJSW9jZk80NEFVTkwvYnA5QmZoMW1tSnVR?=
 =?utf-8?B?cHhRcXk2czBUVTJYN0RUcnIzTlBhcHZUaVRaL1ZLcXpOL05BanpuaytSUkJS?=
 =?utf-8?B?R2NmZ3ZBMlhOZXBFZTZqbzFNclUrWDYvVTlQd3FKUUNuZVNyVVZVNW9zZmJp?=
 =?utf-8?B?MG8xaUsrVmlQblpOTm9sSjZsdzlnOVZqeFVCdHpheFMwcXk4VzVyRll0d1FV?=
 =?utf-8?B?WTRnZGgwSEVWY2gwNEdyaTZ4cmppM2RxRWxza0swbFNvZDIxWGJBZ1A5c3ZF?=
 =?utf-8?B?VTdPZnlaTEo5YkVUMDg3MGtaUjR5dUptT1A1NFgvOE9YY09oWUF1THVZK3Mv?=
 =?utf-8?B?N0JrMHBIai9Yd1N5azh1TVFoQzFYOXVvQTRmV2p4TlhCanFvUGF1c3JVbEF6?=
 =?utf-8?B?a1pZdHZyME9ET0xsaWZ2SndPVEh3M2lKSVNmTGdQdldBUlRHMEVCSUR0VWsv?=
 =?utf-8?B?SVdTc3Ric0hXRlBZRVQ3N0FLQ3dJRFkxdEN0c05tWUlVbENSMmRXRHFvaWRl?=
 =?utf-8?B?RUpHVnVldytlSzNrUzBLMCtZSFp3QUxzVTdoYm1ZMElGYmNUZmhQMytYNnAx?=
 =?utf-8?B?UFg1S3F5Y25QaDc4TnB3S3pyMHcyaGttSmI4OWRTQjBhQXlGWHozK004cGNR?=
 =?utf-8?B?Z2VLeXpMNHNQQlpYaDVFc1M5eGo3Uld3Q3VKbU9FQTFYeWlrWE1rYUdJdlQr?=
 =?utf-8?B?Yk9EZzJ2WndxNERVQ2dTcDhoRmI4N3Rmb0Rpb1g0d0hLMjRmMVBIcXBUN25C?=
 =?utf-8?B?T0s1Zk5kOExvZnN4aU9FMm4xMEhkN0N2bXg0OFhxeDZrY3RzVk5KTEJvQ1pm?=
 =?utf-8?B?aDJKY1A2UzVVaXBJTEF3bm1uZFJTUXljMjZoMktkVDlIWWdZQng2NFJYUmkv?=
 =?utf-8?B?TVN0Rk1CWVFwQkNraGZ5Q2UzWFJNZDZYZHJ0RlpuS0xCa2F6ZHIrNzhDWndF?=
 =?utf-8?B?Z3oreG94VEl6RUFETHpGYng0TlUzOU5VVVc5bU5OMTlUalpheFZiSTV0ZGdK?=
 =?utf-8?B?bGs1ZUE0L0R0ZWl5bXhnNGZiUGd2bnhQcEFXeTZVa3lBc2RQeUlpSDd5dzlX?=
 =?utf-8?B?UzY1SWJndDNTOG9VU3dBdUJMU3BXVjlxS2NDemp0TVJhMDBUZjhCTVdxNDBn?=
 =?utf-8?B?dFRCUlBOdnc0bU5LcWFQZnZFSVE0U0RMaXlWMitiY2UwcmgxWnVTK282VXU5?=
 =?utf-8?B?RHJPR2lrREdxckVsNzZ3WExZQWNJUm91WkdSSkhsckFxRlp0cUYyaVdxR1da?=
 =?utf-8?B?dkZlV2FUdkVLVkcweVk3a2F6Y21KdUxJdFBxM2FmamlORkFSS1NmSlNhTXJr?=
 =?utf-8?Q?roMoJPHBb7vRSmtQ1MSFRQUuA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e33ee89-b252-46fe-0276-08dd2bd29527
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:40.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDzBr6FXHOMthwGDfQ/C/dZA7CYz0zRfECADuFYnbw/BSLbdC2r6oP56L2fp2IYOSwQs63Z2G5k2boNxvFjDGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-ds1343.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index ed5a6ba89a3eeb2a0b9d6dea3c8b3d40aa2cf317..aa9500791b7e0300b150bd654b69c74f3e5e6e6b 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -427,18 +427,13 @@ static int ds1343_probe(struct spi_device *spi)
 				"unable to request irq for rtc ds1343\n");
 		} else {
 			device_init_wakeup(&spi->dev, true);
-			dev_pm_set_wake_irq(&spi->dev, spi->irq);
+			devm_pm_set_wake_irq(&spi->dev, spi->irq);
 		}
 	}
 
 	return 0;
 }
 
-static void ds1343_remove(struct spi_device *spi)
-{
-	dev_pm_clear_wake_irq(&spi->dev);
-}
-
 #ifdef CONFIG_PM_SLEEP
 
 static int ds1343_suspend(struct device *dev)
@@ -471,7 +466,6 @@ static struct spi_driver ds1343_driver = {
 		.pm = &ds1343_pm,
 	},
 	.probe = ds1343_probe,
-	.remove = ds1343_remove,
 	.id_table = ds1343_id,
 };
 

-- 
2.37.1


