Return-Path: <linux-pm+bounces-19935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F6A00620
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA85164A2A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C541D63E6;
	Fri,  3 Jan 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rk6kpXg0"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899911D364C;
	Fri,  3 Jan 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893780; cv=fail; b=IqvxlOrSBw4qmO1pvAaqNuS55uP6Ph/OSfjp3RNgG/yEhU2JfaPdFzLZwIcG3jgVyPhypPTNH+XuraWX8tUpjw5FsDOoEpDeQ4Hd1ZL/zjcubH0sGbEHuxC9BsuHFdtp3vYQsJEqTcF9IiffhsF+6Fg5nYbUbuO7yYuyNQLcNuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893780; c=relaxed/simple;
	bh=gHY2BHYvxVzRpPgRTgubI5fi64I6Ubu6MUDTYIfuE+U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RFKqQQTOjhuQOgFF/d/GhLS/S0kxC2HKjdw29AZ09nbLE1Lam6emhr04O1lw7l7NfqoSqY6QpVGWrSWdgqEvlFPEV617XsXB9nT7a8qrLQYV7GWQ+GKllK91vfjy8BoJagsY0TCQetEiXq1zwTXwAuICio8oGCm8bXLsez/aBss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rk6kpXg0; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Md4A0Ls1ch7WKaYvjrmUH8MtpM5feWLHNXE5kVDeHYgnNZrgL4gjrJP6rU82LxzViMnBey/0PtSq2aXc+Lau+KC6ze+UEKEdy3x9CPfHkpDUD9yU5syIK/WIiUDm5gXOGXdvuNcNvrGdwX4Be7W+s++NXN/0upTVk0uyBT9IxLjV4wIBrDXumBrao/qW4HtDgYToyB5D/zSN1unrAMJSnvwOfMjtDEwQFRDpAT9R2bQZD6YuX/r2azSXYhinG0nisu6Gb3E2/m7T+0/X762y4KR12KW7rIK9LS2b2LMKWAj9+fQEoN4doRQTc/0zWBffHjmZ9VUFMIs47twkTrCdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjUzsRVsWfUKGqcMfcInIdzIFU4EDALwy1w62++QsnY=;
 b=NNyLgFPlTYgh8Khp4SfPZnGrCwaurFZMGzo5PMIBgbrV/vUGgsFS6GjKniBd6v9xYKLN19f3qAxqPH7850qCpr17fWCneAQFTRiqmHhmkYG2/1gk1zrF6mE1tWYkmtHSHQdsHR1Y7k/xx6PEoIp2llHMBn9cMFdiBxo6RdKVoq4XebnBCOfsbuRD56WUv+NcYaMxv1hiv0/Wvfibjwf0nqQB+10vadmzcEs2UOalC4jtPvthc6/sFo9BmPNQJX2OjaUayCMjm5iedj3I9A8dF1lt4sFb7vdId+Wp5XaV+9V+G8Kjy6bTCHM3TLTEHMacbcQDRjv0VLDRRtHV7ZCIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjUzsRVsWfUKGqcMfcInIdzIFU4EDALwy1w62++QsnY=;
 b=rk6kpXg0jJzsrvHsjOIt/T91wiNyt7KcPzFMabciOPVCuo8zwckPgPfWCU3nYbNtuVyGmAT4CV7feR7EigFGLZvXRa9yWB3ZG2/REEXkAo+IY6xRQkBsiLL2PVG6pqVAdBljO6lfUCdu4bJLsjnQnCkTgh/KrO70q5Ac67GMZdzqBzVkO8qIWrh1D8+zMZQB5jxppH4AF3gizJxUFCrCtmXPJC51RUMcGlydsuGrL3CsmSJrmTCtc4XRvq0YqwfABPXYfvkaZbJn7yoQ+mMvn1k6q5zEj4851UHFlwcW37dlnSfj9PL8xBoBVSmkNiJgBaHEbOXmkxY2uybvddWBhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:22 +0800
Subject: [PATCH v2 10/12] rtc: ab8500: Use resource managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-10-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1597;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rISyYCuz8yJRuvtcynWqye8n/ybIJ7leHy6yEB7pHHU=;
 b=xaSOBF7rbPCPOPpRk8B72PtGMEon0vCPZFSnnNt5H6V3KsWLbwrLyvuss/Olw4WIEYNlzcdnV
 X7R5cOLpQU1By5c59CRK+xFOdl3nMqOGeDn4fIgj1jykTG6IMhvHt0D
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
X-MS-Office365-Filtering-Correlation-Id: 6b3111a9-45d3-429d-94b0-08dd2bd29c03
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDZxMVVMTFBwWHRIMFMrMm5ia3JsazI0dW9qNmUyY011a1l5enZrNkszOGZx?=
 =?utf-8?B?L0hTemkzbThDQVlhZGZ5cENmcTg5QkFIUlVTcnJ0NUhmREhXNFVsVDI3TkpT?=
 =?utf-8?B?WHV1TWlrWFB6TlB3REhhTE51OTI1ODRnN1Y5dGZtb2QrS1J4SU9nQnY1WDhS?=
 =?utf-8?B?SDdteFZDbzVkcjlkbDdFeExJY2pnemIxV1pEWEJGbVFTdyt6TnBGTjlSTnhL?=
 =?utf-8?B?SmRKUC83WDRndDJBeUk3R1JMOEFFZnVLVitrOWl5NmlxK2FLcjlKZ3BUQkFY?=
 =?utf-8?B?QnZ4d1Jia3ZNa1k1NnUvcWxwRlNkVHVienJ6ZXc4M0RhcC91REZqVnQ1dXhi?=
 =?utf-8?B?RnpQUi9BVXdaaFNXTzZ2R0pQTkZ1TmF2V3FUenlVODJaSnh4RUZyOXBaUHFt?=
 =?utf-8?B?ckVVMkZzL0dhcys5RHpzb0RvUWJIWldJTlhIeXFBQ3NNcHhUNVEvR0lHb0I3?=
 =?utf-8?B?OExvNS9MTmlVQ01BYzc4MENJWFdiRGN4czVUUGNSYnNhY0pvYmVTbnRocHAr?=
 =?utf-8?B?N0xTeVQrNzZhVE9qQXh1blRCMm9nVDQ4cW5YZkpRU0hxbzFCTHNxaHQ2VXQ1?=
 =?utf-8?B?RG5YZ0x5Ry9zdHhQSGJCejNrZzFZZktYS0IybFN0SHFsb2p2eTdiU3Bra3RY?=
 =?utf-8?B?NkkyaEgxYlR2SXFZTVdXcE01Y1R0RmdFVnhFRitScEtlOVhJYllqQ2VTR3hS?=
 =?utf-8?B?Z3dwdTNUSk9qcyszTEZKNzBWK3llSVFGODVQQW1ZSE8xVlpnd0VNcndESGVu?=
 =?utf-8?B?S1lzbjN5bXdXVkQrMllWMzhqYjIxQzlMOEJsa2Jrd3BiWVlRY0NUQllmM3Qz?=
 =?utf-8?B?eW01bitWVHl3elpzb2RSS3B4T2loMXpBOEcwUHNxUUl2a3lUME5TL0dGbzFt?=
 =?utf-8?B?KzAwSDBhZ2pvcWtqREhFK05PbDR2YXJuT1dSRXlQMkV3TFlqTjliQ0c4WmNz?=
 =?utf-8?B?WXM2dWVPd2NZNEN3KytFSDBnTUUwMHFiRFFMMVpnYTN5QUN2ZVFCTnhCQnVu?=
 =?utf-8?B?WGxESnJhazU3WUhRbFNvVkJUZGVsb2NLL3liakJ4KzJXbURrcXpncC8yUzlF?=
 =?utf-8?B?MVE5cWVsMDRFd2NzWno5U3dia1ZhTjVaWXFjM1h3a1hJZjNpeW91c1c5djYy?=
 =?utf-8?B?eS9KN2hHZlUyVUpMdXo0V3ZaMmpjUGswUUt4UnhmMTVCckovR3pYdTluYVJ0?=
 =?utf-8?B?VnNHY1cyaFd2R0dsdjRNVnZyUWlReEpDQ2VRUFJ2Y0xvSlZTc2lsY1VsNmla?=
 =?utf-8?B?V0RWODBza1lhc1pXVngvYUdNRXZWL08xV0svN29jaEJTVUNVQ1lEdTFCQ0ZI?=
 =?utf-8?B?RTNhbStjSHp3dkRjOVM2cTBNVnFwQTRaVGk2ZDhYdzFCeXF5MHpqTkJCYjIr?=
 =?utf-8?B?b05xbUYwWStrb2RXVjVLeGdLTWlxSWJybGtlVWVuQVlhVjh3a2F6cklBTXBG?=
 =?utf-8?B?THVtTDA4c3BmUElIOWQreElPa25Gam8zdkJlOUcyYXcvVStwZWp3QUFvU1dO?=
 =?utf-8?B?R3dPTWRFNG45b2JnbTdneWZsT01QYlBvbS9obmVGUlc4bm9FTWRqTUI5MWRl?=
 =?utf-8?B?NUdVcVFwbEM2dVBJQzk2QWRtc09lMzhkQTFnVWpxS09CSExVcG83b29vTUtK?=
 =?utf-8?B?KzJwSVJ2NzdkQWZ0UDBkR25FVFdlT25hVlFPSGFJd004QjhOQVNrUkJLWnZS?=
 =?utf-8?B?YjViUElnajJrYkZ1RGRRaXJwWEFtbXlLSFZLcCtKeG5mMm94bzRhdEIwUkZi?=
 =?utf-8?B?S21sRGtWR3p6Nnhlak1LQkU4b3dWK1IydWxvcHY3R2JPMUthd2lKejI0cFRG?=
 =?utf-8?B?RUNjQ3F0OHVNRzVGMkFrVWlWaTZlYzZDMkxzRWxtSitoek9tdTV4UFQ4UWMr?=
 =?utf-8?B?K1Rzcm9YU2ZyN1pMbGtNYkp3anlvYU5Dcm5yYVVEdkgvLzlqM2dIUFFZdy96?=
 =?utf-8?B?N081YTNzMk1HL1RKZXl4VVEwaDRUU2psaFozdjI2VEpNNTdvU1Y5SSt1MXZn?=
 =?utf-8?B?ay93TDlkdldnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEFzVjBIcTF6ZGQ5ak5LT3dnaTg5Q2lvQllBc0F4VzE5WE5WV2pqVVNiU3Qw?=
 =?utf-8?B?bjJKU2ExNDJqWFBnZWs0dTN2V2xXSXIyREs0V3l6ZWM0Z2JuUjhDdkhSNW9n?=
 =?utf-8?B?bXYzNjgvRitZZ0ZMSUdHVklMcTFYdW1oYThRSHh0WXZsWUsvQXFaL29LQWZL?=
 =?utf-8?B?NzNyMUt6RjBDcytBZkdMS1ZNb2N4Y25IZ1hLSSt2UVB2WWd3Z2I5bjkyM2Nr?=
 =?utf-8?B?cXRkc0hrcVhsVmpkMUVBbXVxNWhCeDNDWlRFZlBMUVZhUWcxdDRTQWhHbWJT?=
 =?utf-8?B?UTFVSmhvUTJ0VGtkZi9XaUVreGVGSXBSUzN5YnA4dldoN0NUOWFNeWlTdGFk?=
 =?utf-8?B?QzlMTmVHaXVJUXBDVHphb1VMVzlRSjhHY0Uyb2RkRUdpUnpDbkl3eFBvOWlW?=
 =?utf-8?B?WkZ5UEE4ZUFIVTRzTE0wbGl3aDZlZkNJRHgwdW5FNnYvZDh1Q2xJNS9BdVY0?=
 =?utf-8?B?SzJ3Njg0Vis2NUhCWGROVWo3WkJ5R1lrVXUrUElubHB2Ry9mMi9RMGRia1No?=
 =?utf-8?B?bVBVbXF4MWJhR3dTdUZjZ2JHb3E0aU1sN3YrTHVxOVVVcG5oUDZCSHkxbkY4?=
 =?utf-8?B?aFFYTnBzZGlkYnc3RkZwenlocU1MOEJDNFZ6S3R3a3gwaTBmUkNENVhYRXJJ?=
 =?utf-8?B?c29qY3NrT1FNZHcxYm5pcllkL0srQjFodTZlUHhuSjB4TytLSWxRcmFKdkZ1?=
 =?utf-8?B?L2t2WDJ5dGZhc1VRR2UxdmxkdUhHQXQvOUJTQzRJR3RlM1YyanRVZCtUV2ND?=
 =?utf-8?B?RE9KdWR3Tmk2am51NEVuUnBLM3BoU2RIMXBmTHJoNjJLemkvZ0FRTjdDd0pl?=
 =?utf-8?B?dzZGdVU2YUd3U2tydDRDMUVJWVhKNVpPUnk3SVArTC81cXE5d2NUZkY4eUhx?=
 =?utf-8?B?d2w3RmcwRTRaNGh6ZmllKzlzcnhSUUJIaWhDdjVTOGpJTGdlakp1VC9udVNp?=
 =?utf-8?B?U3lTamNZaGs5eVNDbWE4VkVGNzYyaU9KQmMyZ1B5YmZKQWZsS1VWcVhqTTZZ?=
 =?utf-8?B?SkhWbDhDOGhlR3NJZStaWHhZaVNlMEdMTjQxaWtjTU4vRWM2RnNnNkYzVXB3?=
 =?utf-8?B?L1M1VkdRbzJPcE5vdVBhbHM3eXphN3JhVGpzdlNVS0FwdUQvYWRKeGtabHVW?=
 =?utf-8?B?ODF3MVpzb083Rk16cGJuUGlMNk82d2dRZ01ETndieUI2eEJIUXVTcEdKTTRF?=
 =?utf-8?B?RTZWUzlYeHRhaXJXVUxRRFNOUWU5R0hsbzhiT202YnlOVXExV3pwWjVsNHpB?=
 =?utf-8?B?L1BOZDZTVWNsVjk3NjdZOE5xbGU3NFQzekNBbU9Sa1RCbFBDY25lclBpdU52?=
 =?utf-8?B?VmJScDEzT2V6WTFIakZKbFJ4dExoYWlFVDVSb3BiQ0swRTYyUDBGdEdwS0ls?=
 =?utf-8?B?dUFzK0wvaklxTHdJQmgzZ285bjJKRHlhN285Wk9hRFFuSUlZWjAvb1ZuZ1pC?=
 =?utf-8?B?QzdUVTVRU0g2RUNJRHo4T1QxVkdITWY2THNPR29IMDNWbDRtNjJNbEhjRURV?=
 =?utf-8?B?amEwRXhGUmlnRWFvZFlNNHhUZzdhQjZQeWh4YVlxN2JSbWV0U3Q1MHNsRDg1?=
 =?utf-8?B?T1hYRzY4ZHl6Q01tZ1BMUGZVQWdtY0Fyd1BJZTlVY00xU0QzbklCSTdudC9D?=
 =?utf-8?B?dUwxRWZsYTVISjRwejVibUlBcGtlNE1mMFNPSnFsdDByTjlHT3JFNCtBV3dS?=
 =?utf-8?B?SzVZTFlLTnE4T3NkL053VlIwR09SNFJidUFkbUFkUFo3SkxaOFV3MlhjRStz?=
 =?utf-8?B?NTZxaFZLK2I0eW84QTQ5d3ArY2FGMTN4a2J3SGNrTndHUVFFOUJCWFNCVnhV?=
 =?utf-8?B?bm1ZbnBFWHhVSytNQXozZXM4cno3cW9NOGJMc2lvQ3M1WmxJWDhhQmlHNHB1?=
 =?utf-8?B?KzdHVWVyeHFuaTRQejBlZnhVa3llQkJXQVJtc2ZzRk12R3Z6MjNMTjlBSlRM?=
 =?utf-8?B?cXdWZkF5MlNDRGxvYTVHcjFWUi9yN2VRd0xqNHBMUUxDR3JqVk1vWG1UMTFo?=
 =?utf-8?B?V3IydDVzNjMrUTNjMGFYU3dnaCtYRWJUanBoVWdIOGRySmlmcDdSZUZPMWNy?=
 =?utf-8?B?MkJsUWk4bDZVRFQyUTZUOWE4ZXQ2aTlSWVZPZTRyaml5N3VqdDJpYU5FUXIy?=
 =?utf-8?Q?UR42GJwqhDUltdIbwRZuHKbGj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3111a9-45d3-429d-94b0-08dd2bd29c03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:51.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBccr9Kg0zcivnKXlfIPzpufRiqn5RmXhVbU1IS84DVazBkSZe0kenEoQGKBxhRunqXQ2eAyxyPagxi6XvIKGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
error handling code and 'driver.remove()' hook.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-ab8500.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 2dcda96f4a8ef727514c751322b84d8d2b382b75..ed2b6b8bb3bf8f99fef9f8bee9676f71f8a86d2a 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -361,7 +361,7 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
+	devm_device_init_wakeup(&pdev->dev);
 
 	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
@@ -375,7 +375,7 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	dev_pm_set_wake_irq(&pdev->dev, irq);
+	devm_pm_set_wake_irq(&pdev->dev, irq);
 	platform_set_drvdata(pdev, rtc);
 
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
@@ -392,18 +392,11 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 	return devm_rtc_register_device(rtc);
 }
 
-static void ab8500_rtc_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-}
-
 static struct platform_driver ab8500_rtc_driver = {
 	.driver = {
 		.name = "ab8500-rtc",
 	},
 	.probe	= ab8500_rtc_probe,
-	.remove = ab8500_rtc_remove,
 	.id_table = ab85xx_rtc_ids,
 };
 

-- 
2.37.1


