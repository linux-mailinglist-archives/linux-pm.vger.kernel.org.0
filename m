Return-Path: <linux-pm+bounces-19931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B3A0060D
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FB11640DE
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B21D5AD8;
	Fri,  3 Jan 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fGUYm12T"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D51D049D;
	Fri,  3 Jan 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893758; cv=fail; b=Hv2qcYsIftT5lWeDLBFtq0wTrFhYq6UjedV/M+Y+9hWnx0Vhdt/BA5TRyBKspMH6CExm3b7tMatNyO7Dm7A1DAJoIArC/EqrOKcriUfRCCfrHuIqDh4akBVA0ya6KmfL5LDadfepMnBBKQucH2tT2h0Rm+pHgu6AZUCWZsQXJwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893758; c=relaxed/simple;
	bh=JiSAV7Q4NNZurUbBcswCV+h/Lz5/1lhowxKOZ/KNAmw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ajiWfjinZ6rIs0j/re350mLvnVH7wPduPH+3Db2xZSwOWqSVZnvAgVVzeXlEQDwmxmrN4a94tb5Xdd2I2KRoF4q0vmiUMRAdCz320FVqaqz6p00Emarhrwm6Ernpg+igeplU3GSP7qg6FBfUXOZxBsckMtPm6XzxNXEKzberYAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fGUYm12T; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9tZLXK96LTb5DMTa0oxE0gtTQ57pmJ5KDGiVAo5R6p6LlRoTZ+iu8KkEo5UgUYQNbWquCHM9RA78fk8JU9VSZnW2J9wt8e3A4+gcsH1KMKiuYYP+apZGkod/oGP9XtcCcG+QVxPf0CNdMBA+rWXMunoJ08FYPzMAkVXQPp/opE5k1aj9aQ+ch/SG4CDjFwKUjge0yK2fUSYunZTFkKuCWCbNo3krtmW1XAlVw/J9/4G+c8Ch0WtPd1eN4s5RpEE1Ae56SNktr4fQXdXJMqvSM7l68k4tDWzB1DXwH0d8eixdN7D+KUaajl3luMjk9tPvfJXrklTvdK1ycxAN/5GKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvRxcJQkTcUxL+UY0CT1LkbMh/5QCJDI8WvxLfFze6k=;
 b=mDSjqbwFRfR3QBmdHtnQiHl9iqy4p3Y9k23qTai+X/b7qDExV6pNeNjFXsanGd8NbZadnDLImjIACu0ZA11GEdGCCUkrfjFBvsJv3/1Xg1OurbxhBwrbKbx6iulnuIo1P5Jm3k3m3DS8xri+sQohAdEvupRsPiHAhRbaUF0UKdexKuh/ch+ZEYbhaTf19Al7DRA+D3ILtzrSE8sL5nj8YzIVpRP26u6IW1g7pQWnwpHE50IN/h2wVtkb4tA77taPACWDiotasaqx4Rpq8D9XnSlZuOYMtQ3yWnOJirFwo7GNmnnv0YCDx9zxVHvzeWC4bH9jxExdTtnKR67TmCUvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvRxcJQkTcUxL+UY0CT1LkbMh/5QCJDI8WvxLfFze6k=;
 b=fGUYm12T/DQCz0A8aQISU6V492G83wjCCdwnPhKHUQpkImKdXiMH1j4RarlI9ZBQpa9PRrMVEBGyzZknk6LUjWlsYwU1yKR0QtaylOADgELkVd2+DrrXg0Wtge90dn/FplsmSt/y0fQm4lovOt4Bj/QBzC4FwXAoakaZfYm13GzI93n4lxP7ZSA/HEbmCclmOHnUJc9zXXBvoMBk/EOYXJr24rcRFeQh05lVqDooTlXUnPfswqjRv72xTOcS6ls3zvL6lHKjwC5NiJJ8RZSw4WyXR5BeOLajPQbJ/2uxX9qLbwPEZvr7uxjJ6LFWca1+BlfouHIAzPxI+f5SgEo3Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:18 +0800
Subject: [PATCH v2 06/12] rtc: stm32: Use resource managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-6-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1529;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=3L5kSry1bFWI+vzXqFXX2mukiWSnq2LH9PLt8NvYjoY=;
 b=Xu3sHTShAOCn276HCcSAjpYXzwQZYnEZUQUG/28E7wU8gCnra/3hnBowu+NsGfe4WKS3ziS7W
 vPvGrDFbiDDBnytnoXuv151BKhqwdVR4aBahH4Rtb6gqUmgcr5INuXs
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
X-MS-Office365-Filtering-Correlation-Id: ca160c3a-d728-47c1-9059-08dd2bd28e96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjk0Q1dGY3VtYkI0b3VOa3BoMnZORDZrcXFHWnMwZGxLcnJDYXNLMHNmeXRH?=
 =?utf-8?B?bk1kR0t1UGk4NTc2T1I1UjBacEl1WEZOTHoyNE0vTG9PZWcwb3BvUUluckE0?=
 =?utf-8?B?bkhiTGNwaDBFdC9rL3pKUWU2cFhMTzlFa2t5bEg3U2NIU3pzTXJMNjQ2blp1?=
 =?utf-8?B?NndnMnRtSE1walBrV2hGYVVMZ0Z3d3JmdGpoTXYyMTcwODgvdXFIcDlLYUxn?=
 =?utf-8?B?em1SRVJ4dVliNXJUQnA2MmdLbFYwZ1JXcitFUHBKT2g2Y0xYYk1XTVlNSmdN?=
 =?utf-8?B?SldWODBac1VYK280VWVSWFozb0lPeU9ES1Y4WVBaR3UrNmc3N3oyTU9ydjcw?=
 =?utf-8?B?QkF0bWZ4blFTMTVHSW1EMm9uaGN4c0R6NHVOelIvc0xsNm1Icm9OV0xFTWZJ?=
 =?utf-8?B?bjhJMWRtZTIrTGYxY3Q0d0N5TkRKSFI0Lzd0MVEzeE5kV3hnR04xOEZyQXIx?=
 =?utf-8?B?WnRIODU5Vk85QnR5VGVtaGRNbERZbTRMc3Q0WGFqTzk0NnVPNS8wWmlOeXZZ?=
 =?utf-8?B?cXkzQWdWK3hNM0ZlVWJOY2FkMkFwNkFUOTlpejdGaWVzdUpoME0xbGpCTjcr?=
 =?utf-8?B?cDBGNzU3a2RZZFU4U3U2YUtuUXg4dG9CMEcrSUIxN2QrbGZES3U4cFQ3bnhh?=
 =?utf-8?B?RkxzSkVGcnlhb0ZMc0VUNG1YZGMxeTJ2MUJreUQvVk1mOFkwd2pNYlNCQm1D?=
 =?utf-8?B?MTVzZWozZnY2NmtRdk1QSzBTUUFyOUVjV1J2WW9ZTXAzUVpiVWhSSlJJdk53?=
 =?utf-8?B?VHFhdnJjbWZzbC9VMzBtVm41MVVISnVlYVhDaGhyVG5WaDJTcUd0WjlTVGlO?=
 =?utf-8?B?c1hYaDhBc1h0a1VIbTBDU1VQYUVxaEs3WkQzMDdtVVkzS3pBeTQ5OE40cTRQ?=
 =?utf-8?B?ZXZwaEp2WWc0UXE4U1JZSzhCNHBldnZjcmdpUDFGV1lHL3JldGVzL2c4R21O?=
 =?utf-8?B?ZEFBcGFsU2t0eDFnb2ZJVklJaCtQRkZKNTFFVnRMR1JoeXFjUkNOdVRsYTJm?=
 =?utf-8?B?b2FWMFlvY0h2dXVML3lWOE80RVhiZWhvZGpuczM0Y0FCMHI2dUE3dEw2UFQ1?=
 =?utf-8?B?aXpGSUFhWk5RMFpYdHkxNFA2QWhhZlQrSVFSbStkak5iN1c3djJTVjU0VDYr?=
 =?utf-8?B?aWNGbFpBcmY1Ni9kUGlGTHZ5OU5lQUpmNUdxOHlMRzNPYzZFSmt5S1MrZ21G?=
 =?utf-8?B?dVd3cXByZlNGZW5YaEdnOW9udkwxYUtyL2QrQkQ0T2NkUko2WnphQVNhV1NW?=
 =?utf-8?B?VDNrMkdNVVNuN1ZXWkkwRnlLdVRXeHZ1U2c2K1hvbUVFdktiM0MweUpEeWwy?=
 =?utf-8?B?WndrR0tZTEMxdEdkUXd3TzhidURrcElrSGxmd0JPS2xGbEpFVm10aXBzdEN2?=
 =?utf-8?B?UytZUlVVMTVibGp5RG5scmI4Vm1UbFBRUDc1c3I2NHdmaytPRjRaZFlZY1Nt?=
 =?utf-8?B?b2ZsWVlVZEpTWWZPTnFuajVscGdYQzlWUGRncThFbW0wTkNoUkE0RUtvZERl?=
 =?utf-8?B?ZFc0MUlKVGN4RXJwRG8wdFNvT0dCZm1xRGZMOVdUajZFbGVrRFhkWXRWeVpS?=
 =?utf-8?B?eFdrQitZT003NTVJbHJ4cFBJV3duckNyWTFveUZtb0pXU3dJajMyUUNqaGRS?=
 =?utf-8?B?aW5TcWtDZkFDNitUcWs2a2Z5bjB6V3lYOVBwVUFISmNNdHdtY3NuZ3JmcTNl?=
 =?utf-8?B?OS9CM3FwOFhaUGdCWC8zVjNuK0ozTTQxUHFSdXVUaVhUdXIxQ0Y2M245b2pW?=
 =?utf-8?B?QUdYVWNJTDRrS2xkR0M2TDJZZTMwQWFsbUV3a3gzK0dVSGVKb3JmY1c3b1JF?=
 =?utf-8?B?QTR3dC9nZWgyRzFOL3BJYTg5WFFOR3RUdXZZU0hUM2ZEU1pTTlhkZW1oOTBr?=
 =?utf-8?B?UTFLM3pmZUpWTU1VWm10dWdWWUpIaHYveUFkS2psNWwxVFhoaUgwRUtGTWRv?=
 =?utf-8?B?aDZRVnVKNjhyN0hua0gxeWkxdHp3K0UxemxMc082Vmt5TjRwRTA2anAzRTJT?=
 =?utf-8?B?S1JHTlcxbEZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THFER1FUYUdMejU3cHQ5bzMrRktiZ3dRbk5zZVpvVTUrVHlVWkZ0dWYyNysw?=
 =?utf-8?B?WU1YRk5Cb0ZvNjVnQ2N1cCtOZXA3ZkNHYXNMeFFrQjEwY2s1ZDVxanhobnp3?=
 =?utf-8?B?Ry9lUmJxcjFWNUNCTlVtMVo3aVFra2E0YW1TTTZ5eUFVUm1lbFo4K0wyTHVU?=
 =?utf-8?B?M2hTYmlRZVpkTi9sMkhJbXVrTi9UcXdrckR4MzQ4Y3c0M1VyWnZWazd5bXFY?=
 =?utf-8?B?ZGMrNnBXeUJaZmpHclBsZk9tQzc0ZVJUaVllRmpHbkx3cG5GTXk3UEI1YXUz?=
 =?utf-8?B?Y09nam9Td2VzWnhFdy9oUzJEMGg1MldCTzV5TlFZSFA3S09YV3VjRWhKdTZT?=
 =?utf-8?B?UTZXV1ZKREZEcmtKL1Ird1lNcHpEdHhIZURTeGFWSHM0Tys2aVNKZG1MQW9Q?=
 =?utf-8?B?Z2pUaml3REFZUnNlaGNqa2d1dExmOHFieWpJVDZoUUFnYmtJc05TNWFlR1JZ?=
 =?utf-8?B?Q3ppVWZWcmdSdmxBdko0THc4cU05dVdCWFdxcU1jb3IwRk9UQXZ5V3ZPa25X?=
 =?utf-8?B?TVRiV2ZRM2dTMHIydHRvS2ZuMHpHdWtkbCtQV1pTUWtlY0I1RjBVdUxRbTha?=
 =?utf-8?B?L0x0WU5JQWE4OWNzUFluMERSVDNlc0VjOE1nYmZiMHNNKzFqT0hiSVdVYmFO?=
 =?utf-8?B?bFFqbEdoN0IxWXowMy91OFlrRzlDWWZtYXJqUmYwQng0NERJY3pPY3Rib2Vx?=
 =?utf-8?B?WWpjcnVJbUkxWUhYNkpOTHRUVWxyUDdDOW8ybG80cFRMdkVLbHJBQjcyeXRP?=
 =?utf-8?B?YWE3TFFTKy9HSlMzY2YzWlF1WGVvNWZSSXVPZGZnNElHaUQ3dVgxZG80SjdE?=
 =?utf-8?B?a3dyYndIODJlRmF5dXYxZHFDdm9rdG1FYks2U3lWSTd5cE9hTUFBZlpaSHJK?=
 =?utf-8?B?NUo0TkJxdHBYV045dWEreFFhNHMrM0pwRS9Id0NDOTJvaXFQUXZtdWgyT0pN?=
 =?utf-8?B?SXc4MFRUT1FlWXJPOTBxZDVjaWp0Nmh0SHNicnM0Myt6alhFcElJTzFvU2RG?=
 =?utf-8?B?V0pKQmFDbGdONVpxSjAxZDBYQU10WWQvWjZpaG1Xc2lkbGxEUUNZYm5YWGw2?=
 =?utf-8?B?KzNSbWZ2R1Vsd0JoemRxVllsZGRtU25GVkhqK29vQWx0ZTUvbU0zM3lJdVVR?=
 =?utf-8?B?NEs1Q3BwcnZhVzNuME5IK0JxM2k3YWMvbW42NFphZUpBNDR5UThCamhZTC9a?=
 =?utf-8?B?TWo3ajcrMFh6NlJNT1lORWJ6OXZCMHh1bmR3ditxa053bnVmeHpld1hTYTdu?=
 =?utf-8?B?cVpjSG5RRmZjM2NWbjl6dlMwYnRZZVUrVUFQUjRBUXRmN0pCWE1Xb080RWp4?=
 =?utf-8?B?bk9xS3JYSVB2YTNUZWdDdGorNCtpMFpPZFFXNGhnZm1HdWlTN01laE5HSnFE?=
 =?utf-8?B?ZTRUZ1E3RU1xQ3dMajQzSGhMSFZxSW85cklzd2V3Tm1oRGxRNFlSQmlreTgw?=
 =?utf-8?B?R1dqTzkzd3NlNGVkbG4xZk9Oa1Jtc21BL2JrV3VxZ0hiRnRkVUlORzlKTkxq?=
 =?utf-8?B?bEpiWEFDN25yeTBpMGFTVzZLdmUzdmdNenFsUG45ZXhhNzhUc243U2dibU5u?=
 =?utf-8?B?MFRpZnNMdW43cStZcS9ubUlFcG5Jc1ZJblZ4SkV5aGRTYWFNZkdSYWdTUTBF?=
 =?utf-8?B?dWMvT2JVT3Y4TlE0MkhEdjg2cTA2S1Uvb3laTXZvNjM4NnJBNFhOdkIrSTcr?=
 =?utf-8?B?eTR5MXZHMDMvUlZXb1Y3ZjlocW1ic2RaRXUySXFvdlAySFNnRHJuVm13Y3Zo?=
 =?utf-8?B?ZEdEWEVHRWlXWnlXajVMTTlGcmpRUEl1WTNkenZ3eW9keDFURDVRMTFYVmNk?=
 =?utf-8?B?WU5PTmNXY0IyaDVnYU1FMVhVRzN1Rkl1bDhWS1E0UUF5MnhGWGJldTluMERV?=
 =?utf-8?B?eUxmVTJ1blFGcnduNE14V0JaWE5tTEdLTVhmYXJLVURpbTdJK1hxQ1NqQlZq?=
 =?utf-8?B?K3Jvakg0K0V3Z3U3MkI5bGtucThxWE5URTl4elRlblovZnN3dzM4emZBNVlt?=
 =?utf-8?B?TXU2TUlnaDJLR0JTbG9HWXhnYzBiLzg0VEJaRmxKM1ZSaEtUSFZrbXlhL1Rq?=
 =?utf-8?B?c054d3FQdmM2YUVIMk5xWGZISGpYRkxhQVgvT2wvRVE4VnFOVHVpdHVvQXVP?=
 =?utf-8?Q?tEzSMm6ga1ZdTd4NXcq2Trq1a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca160c3a-d728-47c1-9059-08dd2bd28e96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:29.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkR6W/pclZiIsEJzYoDiIo3vnWW/iJPYiyS5Q0PmwImUWFPl9uIhTvvxsyInNit2cAyD4JzwhaUbi+W4YceHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
error handling code and 'driver.remove()' hook.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-stm32.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 9f1a019ec8afa57245c6d40d378ec50fdcd64deb..183017b0d33d10481f94891de24cf2eee95893f5 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -1151,11 +1151,11 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = device_init_wakeup(&pdev->dev, true);
+	ret = devm_device_init_wakeup(&pdev->dev);
 	if (ret)
 		goto err;
 
-	ret = dev_pm_set_wake_irq(&pdev->dev, rtc->irq_alarm);
+	ret = devm_pm_set_wake_irq(&pdev->dev, rtc->irq_alarm);
 	if (ret)
 		goto err;
 
@@ -1216,9 +1216,6 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 	if (rtc->data->need_dbp)
 		regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
 
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-
 	return ret;
 }
 
@@ -1245,9 +1242,6 @@ static void stm32_rtc_remove(struct platform_device *pdev)
 	/* Enable backup domain write protection if needed */
 	if (rtc->data->need_dbp)
 		regmap_update_bits(rtc->dbp, rtc->dbp_reg, rtc->dbp_mask, 0);
-
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
 }
 
 static int stm32_rtc_suspend(struct device *dev)

-- 
2.37.1


