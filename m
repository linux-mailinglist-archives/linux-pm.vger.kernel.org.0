Return-Path: <linux-pm+bounces-19927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28637A005F6
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43ADD188413A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3161CF5EE;
	Fri,  3 Jan 2025 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CgbFYNBD"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C71D31AE;
	Fri,  3 Jan 2025 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893736; cv=fail; b=UOgG5NHrSc6dx7jyw+QE6QXhgA+MJs0W0yj5eD8y8NK1MYcYTBOViaEp4zsTtDjX5Kg1UhZYjfJUc9oc58cR2umVzHsArATjMER8JnLPfBFcTHTyah8wzqWnX48/CBKTeGL5kLg5FFJOphVUzZfadrkj06FTOUkDArrsmLGZ0sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893736; c=relaxed/simple;
	bh=f0XWM6xBggK2QfOcHzd3+B2023F378UQ/qXOqelOuSw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sQ5mLN6bOmSeiiuc48vMqINUhU5Raofa+QUnsVhZarZ1quQfxOvqttQglb+XyukxEtM7U8nD0/m63b2Fpv4Z48S4W2NldNmkN9B99IWOsrBnPqMibinlCGWPr/a+vENKs6SeDzePiAk+jlyGNmc5Lhku+8nVykpp2cGthWuOWvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CgbFYNBD; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1aH+MEkJL5DstVipxgKG6JRHaV/1Ve7AjvT5moKZG+24DF1F19ec5JL0AxlbkFVbweUK4ZVhiXSwqaf+lsxDxAR/4iTWFSnSvSxC0ch7STbUbgT/TrPNpGtwKF2hbSQFF9x7l3DXNwDfPshaE3AiOvR1arbtksbEWOlnRkdaGStWcCAB/Ak0Eb5IYJH7j9z1GUXO1eOL4iG8p2ybts9b8o7A9Bz4/gZoCte+K9Vjg2rxU5AGYqtTKs/XK3qtM2V6Io7tMJ0cQqWPrSWfDq1QirzQoFeOE48beVj92el+zZfLg81xn3W7NOEHbP+uCPfjGUUVf7CsZ/dYOHPHqFLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBJXBX/BlDu3iR52lDbc09nZRQMR+H0jkQvpTPg3SOY=;
 b=g+Gt9ZCwEdf+zk3TaGDp9Jh+IOMtI8QOTe/QVSUc+O9Y3I1/+UitbW2BCSvH1QSEiNhnJDKSdshSjUG4/nHf/zY/WqD9//hxz1j0UiaYOWBPB8zuPA0tpCbZgQ6j38zxeJIf+VH+w5vuS95gpzxDVl+x72yOYCrNjrewNV62B8zBfIFyoN4a/dYqTZOxe9eXD6riGHfD8dJXUS2EEv5r+WDgSgk5j/CNjZ5Tqj4l7EIT7K+VeK8W9LjxXCT08wNaRm2OE5A7EO+sFpbCL+JTnmbK7ZeMPW89gRsC2u9ggjPXnwIe82fQ7XOOoyDyXxq8Os5FSZ8TU1Q33OwKJ34RsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBJXBX/BlDu3iR52lDbc09nZRQMR+H0jkQvpTPg3SOY=;
 b=CgbFYNBDuGz8UJ8IfWvKeqMsk9s3KcXjoeEx4/S6BOp25/Zo3oL10mapeicpDGrr49bu5aJCll+91k8laxyjbXk0SyTc5OReAJILBRqhf3aEMmPlI/6zhiUhZqgEus3slEop9raYPBZOBP/cnJpJNwkYKztrLBiTC3dZS3GG3ybwfkhOoMqfcfOMi2eeGlQbZsubqWeJdTRiPmPN6MNA06CMUECE26dQsikGMjtByRmTbcOurOVrGaGbCVavBPuWyfedfw3xAW3YL7VxtrzlTvjdvdWgVtwjvIRrimYIILyYonmNWhrjh8aDQazYkLcJsjJdHyNKjoUYU0DDUpUrnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:14 +0800
Subject: [PATCH v2 02/12] input: keyboard: ep93xx_keypad: Use
 devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-2-e3aeff5e9966@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1402;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=lLk6bV9Q4qc+HUdwJdc/NyACnoatpwVUWdW9RwekWXs=;
 b=R9/qzuNawG0lBp3arrRjMdx/n5J25HPKu2UkbM3HWbYO1/MmCJQ6naNNy0xhmrFQWFa1HqZD+
 xfQu4IBNzZKBQUW368Fey1iMo3Zzkr4YqCV8xVtsxLgW9IUk/Wzh57Z
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b7a357-005e-45ff-41f6-08dd2bd28193
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXN2QmR0eTlBVlptckNlUmt4YWg5djFsRVU3ckJ2RnJjUWF3ZmZDYkJKNmdx?=
 =?utf-8?B?TkZvLzR5SnFkWWVFS0swQ3FUNmJUZ2luaWRORkg1N3QvbVJQVC9tb2NpYnJv?=
 =?utf-8?B?YW80RVhqQkdzaUVNeTJlVFFTVWk1b2IydFVycUhSelFPTC9aVi9lT0VNNFVp?=
 =?utf-8?B?bkZUcWJlL1ZlRDZpSWlMRVJxd0NuQ3VQYUxUd0FDQzNxcnZwd0lEeDBBRFMz?=
 =?utf-8?B?cElkSk5SejJTZDVFZ2ZnWWEzbWlwaS9SMzZIWllyYmo5ZnlRK0M1KzNBSjdl?=
 =?utf-8?B?MHkyN2xERkJNMXhFVnozaGZyOHVEMmNzdXZzSGU5ek92V2h0b0RPSk5LYkFh?=
 =?utf-8?B?Z3hteUF3aXdMR3ZjamdORzl2cTBNaXJXdjQ1Wnd4ZmdmS3oyaU9RWWl4NVF1?=
 =?utf-8?B?NjJtTzB4NkJkK3FGbHE3S1I3b0IyYm1OL0RTODA1T1RhV01CbDJvTXAwZlJV?=
 =?utf-8?B?UURQMkREOW5qUUkzd3JHbklvelRrakhHQXFDdUROQ0tlYlowTjJHY1ZBbDBy?=
 =?utf-8?B?Z1hlT3NmcTJKMWJOOExBSVI0Z1FDSkNxRlNuZitMUFZPK1JueTRwZHJOVEdT?=
 =?utf-8?B?WkFGUUtMUlhPaGVZK2U4SlRXWGlDdUNNVjZ2QmFST3N3NWZ6N0JJcGVrNkpt?=
 =?utf-8?B?QTAzZHBuUCs5MWNJWW5veUhNZWs4bllXS085ajlNYXBCM2tKZy9kWEtvVHlS?=
 =?utf-8?B?L2htTUVZdStnaHVHZkYrTnFSeVZEYjFYVGJLMVV6TUNGaUxxYUFxd0UyYU5a?=
 =?utf-8?B?UXIrdFVpNTkvUXdYaDJUZTJKYmg4VVFGaTlrZmFqM3B4a3lyOUNPdCs5bXFI?=
 =?utf-8?B?OG4rSUVxdmxWaTFER3RnaHNaUXNlRGFmQ0tqUEJjMkFLR25rY052RERGeU9D?=
 =?utf-8?B?eU1WSkRVVG1lb0s4SXFCRzlnamxYWmxyMUs4bEhxTGt3UHQ0RFd4U1ViU0w0?=
 =?utf-8?B?OUViNHd2TFcwWXhoUXJudDhkVFN5WFg0czBUS2hlMXBrSGpqVStlUDZ4SUJu?=
 =?utf-8?B?aVNKbGFNL1lDNGlka0ozMEMwaHBvYWFZYWJSMlJTclpZQngxdHM1SjdkZUxP?=
 =?utf-8?B?am0zd1U5TktVU1BBZzhsUDJFdGNiKzIyeFFuT2tseUZIUzNiWEJiQTcwcC9W?=
 =?utf-8?B?bWZPdk9sV0tPOGN0VzRaam83SE5xVXJvUlh0V1lyMHljVXVSV2xydlhVSDd3?=
 =?utf-8?B?UWUybnlFNUhJOEtZU01OWC9hdDMrUlN3MzBnS3k4Ym5uMmVkNlhVT1NDKyth?=
 =?utf-8?B?MTBhSWRTbjZBM3dLc2RZNTZaTHJYRkpWUWM4M2owWEdxcThWdERXRXhCVzZn?=
 =?utf-8?B?TGpVWXk0Q2xQTjl0NDVmUHpqOG1vdUl4eXNqdWtPTW5XbVA2bG9ZNU12Zmpn?=
 =?utf-8?B?cjJvdUtoQ2FDcUVldUlKckVsYm1yUTdXR3NwK0RHNHhjVGNIaWwyTCtmWFI1?=
 =?utf-8?B?S0Y1b1dCdUQxS2dHTWI3VWN4MjMvL1dyNUVJalJTNEpFMDl0UWtBOUxCeHdl?=
 =?utf-8?B?QzNjWWRUYmNrZXRsbjA5NUZEazNRYVlSb1FJTVVFUXJYKzVhbHdVWkxiS0FY?=
 =?utf-8?B?YnlHVTFtQVNObmNYUHB5VkJuN3oyRHo3ZHM1QWRFWDF0UW4xaDJ5SHF6Qkw1?=
 =?utf-8?B?ZTc1dGFmcW5lRnRmTE1zR2hlSkdrZlhiSVh4MjBQc0lVZ1BveGpuSkNueE05?=
 =?utf-8?B?UmJ4eVdLVGU0VTdEUHRDS1YwTzM1T21Id0xWd1BBM1laNmVOT3BHOU0xeWxi?=
 =?utf-8?B?cXBKbUhDVEsvT29sZU5KanFCeG5OQ1E3U25WK0VaM0tTZ1BFZmFPOXFkeHRX?=
 =?utf-8?B?SnZCazhRK0lpRUlVbTY0NnBCZjdhVkM5YWdjUXRlNUQ2cXVJY3E2MWlBeE1h?=
 =?utf-8?B?KzlLN2psdlBoUmRoL25kbllXRXJHald5TFFxTWp4ZVV0V1hqdERWS3UrbEhQ?=
 =?utf-8?Q?OVzwfqGJxd2WaX0yUiDcuIKlV26VM/lo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGNMRUs1NzhDSFJzTlVjQ29DM3pQTGRNc0dJcVF1QjF0c1FLd0VvVmNKVjRQ?=
 =?utf-8?B?ZHJTWk1QU29UOVFmUEFCYnphalFndFIrK25XRUoySVZxNU9vU0JJcytwNlY4?=
 =?utf-8?B?ZVViRG9FVmN4TzhQZ0ViY2R6VEcrNUs3QURiRUQ0MHZyanNvQlVhRlNHVUp1?=
 =?utf-8?B?aC8xaW9qdTM0WmFsVWFoWGJTaTJvTTJWYzhYK3FwV2lmRVBlME5NSGprRDJi?=
 =?utf-8?B?QlVwWXVZSXY2TEtqSGdmK2RLc1BUZVlJT3E2WkdTNEIySUxBUkE3c1ZYMWt3?=
 =?utf-8?B?MzlWYis1SlRLejlQUDczZXR0YUhSVE9ucklwb2ZzbUZGUUtiQ2x2VWd3ZHN0?=
 =?utf-8?B?RHRrNlZrdDh6clFQaGdIZmdTRzBsNVhNL2NzOUV4Q01DNHJMZVd0SStRbDQ1?=
 =?utf-8?B?T3lEVlR1cnQrUk56YW9neXpUb0M4LzI2K0JWOWVCNlVtc1kxdmwrUGdkRWVU?=
 =?utf-8?B?TVA5ZDZ6WklhbGpLQU5lNmpzcWVyaGhvbWdBUGJJOGZjOHpFdkNOSlJsdEJC?=
 =?utf-8?B?bnBiQldFOElpRFd4bjg2N244OE43eDZmR2ptdTRHYUJTdDRpcmIySTkxVkU1?=
 =?utf-8?B?M2lFOUdCTDZ2TFBtOEg1QTF3ZjJQSU9PNHBZU21oOG1LQ3VPTFp6VnQ3SHhE?=
 =?utf-8?B?ZVZaU1FOeFRlaTErYmNJdGFSVzhsVFREbmMvTnJYTGUzLzAwb1ZZQ0xHcTVJ?=
 =?utf-8?B?WjNhVlV4M1hRcXhNaDl3MTlWWTA5VTlqWmNNaU9rcW1sNm9nYmEvVkdCL2dL?=
 =?utf-8?B?ckdJV2xOOUhYR1I0bmxVeFN0SExFSWRDeXlQNXZPc2dlUnJuRFBONjJ3MVlm?=
 =?utf-8?B?ZHA2YXBZTUxwQjRRTGZGY2NLZUc2V1dNOFBlOFk4a2NwUGpsb0lYWVpQRmxQ?=
 =?utf-8?B?UFFOM2lRektURjJCenhNNlRrako0S25yZXdEa0J4cEwyM1VaeDAvaVhzcHEz?=
 =?utf-8?B?MUI5UlcyUi93SElKb29pR25kMjBIckM3R285SXBTUWtlRDdZd2dxbUJMZXJO?=
 =?utf-8?B?NFZFRlg1ZEViU0RCT3FvaW5FWjh3WGxZcEh6eGovVEw1MWJQd3hYTnpac0sy?=
 =?utf-8?B?L08wN0VPVkJRQVdGMzIybVEyL1ltQkpid3A1RGExM3N3ZHRJTUdwUlFxRkRr?=
 =?utf-8?B?VXc5anc5YmNIUVRXNS9MRk4zdHgyOFdKU2NsNzZ2aFdSd0tpdUZFM2JaK1dz?=
 =?utf-8?B?Q01OVTJHWXNhOEgzcXJrREo3WjA3U0lna2c2ZEhpbG1WNS9pQXBjVnZvWHMv?=
 =?utf-8?B?c2UzWGplY1RJdzNkSStudnRVbW55VkNqMFpXM1VKNUJLV1VlNzRoNDZIdzE0?=
 =?utf-8?B?T0c3bnBhaUttZkh3RHl0V05ZOElqK3dUMTVmd2xOUDdnUU5RL080bXlHSTdG?=
 =?utf-8?B?TlE3Nk5CWGc3anQzY3Q5TUp0b1VwRkNQd0thcnNMeG5CVnhCVlN6VkpxK0RZ?=
 =?utf-8?B?aE5QZVA0c0VXWnQvdWk5OEE5YUd5VEFaRllqMnRpTzliZk1zUEpTT3Y4cXQr?=
 =?utf-8?B?eWZ5ckt3ZW1RK2FwQldJUXVkeVVmaUgwUEJuR1JiN2MxNkRReUcxb0RmWHRS?=
 =?utf-8?B?QXBzSXVVc2sreG5NQUNwdVJvUVJscVl0QnM5QmxGRnZsdmtPUU5KeUE1Vml1?=
 =?utf-8?B?WUVYem9lcHFFNllxcDhGWlFWRjNrTDFJRmlYRmJIYTBPeDdmWHNJcGRlUkNP?=
 =?utf-8?B?U0dMU1VzOE5yVDJWSGx1SFlaZ2V2TUJ2NmdSQjNnWnN5S1NjazluR0h2aitV?=
 =?utf-8?B?U1BkYUtpNHpMdzM5dFFEbDdzNUd0NS80aXQrcEFXd3g5a3Zlbm1hWk4vV0d1?=
 =?utf-8?B?Snh4eVlSUzJSUG8wZE9ucHZUKy9MQVlaeFI2WEhLYVZxbjcxQ1NOb2cxVk1V?=
 =?utf-8?B?b01DWDZsTkMvUExiRmpJZ3htaVZsQ1NGWGtzV1BCcHV0alY1dk1QK0FrbW5L?=
 =?utf-8?B?SjFsb3lxMGRBV3hEYS96V3Z2aytDV25jSll0Ujhmemd6YlpRK3MwYlF2TS9U?=
 =?utf-8?B?Q0tMTFJXM3gyVjl4S2pQT0hBNzJCVytEVkk5bVU4Q2pRbHBYZ2VsWUxYd05L?=
 =?utf-8?B?S0UwQkN6cmd4SnhCbzl5Z283eDQ3YUdnYVV5OGxwQ0FUNWFHWXUzOFVMWGo4?=
 =?utf-8?Q?lrkCZ/7uhymU7XoHVCoteo5er?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b7a357-005e-45ff-41f6-08dd2bd28193
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:07.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVjgLhuqcubx01q2NGl5hR+bX9gxV96kxlnjqpwmNZlGCKPMwxzv/hI3L5PEmXuTX4/2xuH7XrhBznoEcUFLYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/keyboard/ep93xx_keypad.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 817c23438f6e5176431e1f736bb511f9919b67de..6e3cbe3ca72dbd43485c23f6042b4fba007ff5e6 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -260,18 +260,13 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, keypad);
 
 	device_init_wakeup(&pdev->dev, 1);
-	err = dev_pm_set_wake_irq(&pdev->dev, keypad->irq);
+	err = devm_pm_set_wake_irq(&pdev->dev, keypad->irq);
 	if (err)
 		dev_warn(&pdev->dev, "failed to set up wakeup irq: %d\n", err);
 
 	return 0;
 }
 
-static void ep93xx_keypad_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-}
-
 static const struct of_device_id ep93xx_keypad_of_ids[] = {
 	{ .compatible = "cirrus,ep9307-keypad" },
 	{ /* sentinel */ }
@@ -285,7 +280,6 @@ static struct platform_driver ep93xx_keypad_driver = {
 		.of_match_table = ep93xx_keypad_of_ids,
 	},
 	.probe		= ep93xx_keypad_probe,
-	.remove		= ep93xx_keypad_remove,
 };
 module_platform_driver(ep93xx_keypad_driver);
 

-- 
2.37.1


