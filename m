Return-Path: <linux-pm+bounces-35137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A01B8EC4B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC641899FA5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B72ED872;
	Mon, 22 Sep 2025 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QI7hyIxE"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3F18DF80;
	Mon, 22 Sep 2025 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507689; cv=fail; b=KbnK0/ccSzs2MKSP4/YZNP3JSZLyPcE1KzCzIFb2CNerYez9guLt7ropzdSHikNLIOR40nSqIpVhWMCPp1xpkFXWl47ZmhXIslvtzoE51QyrVgzGWAAn0QKCofIgVLBV81B+u4ThpuPPP923+Wp9UUofCP7rP1k+PFtek13k7c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507689; c=relaxed/simple;
	bh=ugzC+pgoMcvHsA/UBz02SmKrvFFMwDAliYqBtcghI1A=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ASx0O6lKcHpawQjecPhv312w8XjPj3/LGk3bL1DqF+j8LimxKL2YX4yflcZj8+I2atEWlkDbSX02wy0cWNtnAHH6T614y0zQHd5G6qKlQh2nNO1guprrqE9wF3fPsxWW2FAiG208jsGTM3prwcBas54ErEMYOq5185Q9Ra0aHSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QI7hyIxE; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ierw/HCRSyZDciM8uKrJmoaTrL6kuxBJIdrq7bF2k3rdrxRWfyTtbduL4sOPTw9pPvULqsLyIsdRJDqY5t9ZiRCtkHhpWQqW+jJAensqsCs/u83WiPmMNpNbfI9y04uFN3InVVD/QL5yAzXOh98B8XhrKgdg1rM4X94duqssvxkUIAT7zLSI/90EfUJrpDbNI0aUuu54QlPyHAfu2upq9smd25akmLfD03zcDKdKXWc/Zixtf9lMN1hxRNkbnGv6VXmFnlQWCaFfk/U7omJI5+iK8lm3D3307vxttDm4vsmywd7lUvJX44qcyU9SLAorbnDfJefiGR3uIRHeJa82AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o99Y988nKk5Cj3Iu/jImHiD9eq6JPH4xizAh/6jnsg=;
 b=Bo7W2WOBfxavBjSlAGow3jyy8LRdg9ondSJ5u8KRGxrZ/ES2SdUFdg2Rs+K3D9Jly9Xh44UOiwcaFK28zi3iZ50XK0TCGyAc1wI+Fb7X+XlYHxIW7S8EvEDN+mKqbEHaOFkmQFB88peesuB03Qk6xgMaoLvsyP3upC3cZ0gB1+5NjoxinxWr7PWMU5I9nBlLO+J9/i6a3if3+ammhfH6sh+kJ7Y7zrZmz1FHPdVKScRKaZ5dVpGKpXWbIxFJe+1HNZA2HvKluzQktg2UzjQ6U0aYW2E5fWl1nesf2JlRabslBnhg1ynfhpGAs4LZvT4AP5BxcyQm2Fi5j3uCBhXGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o99Y988nKk5Cj3Iu/jImHiD9eq6JPH4xizAh/6jnsg=;
 b=QI7hyIxE43WwBlY3q1GsMyP4GmmCl2b9WUJ5M8iD30OvWlu06ZALIVmZRRYCt+2v2u/islr/pPzzY4a9H4XRRTi3yLPhjGteTkuIyK5MaYcDAYz+BHGHQLEIyAXag+DwMe6Jo2casLJSGWK7Bnm0ZdNBsaHPYq2LZ0AkI6iLuLo9QRIV5OKIv7N3od4U1UVon1w3vRYX0wMnfKLGtnZkrdsSSmd/rwhrLLOFe6HfuOBlNeJhUYapgIcUXesoAZPzKgMw4bb7GhIbAgP1nLEutxm30qtFB3BPSO0Dy1G0Q8TWolWHcwRw2JbhfiRH3X3MM1BS5xnsA0gmXxO5jjeW4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:21:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:21:23 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 0/5] pmdomain: core: Introduce
 device_set_out_band_wakeup and use it in usb
Date: Mon, 22 Sep 2025 10:21:05 +0800
Message-Id: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJGy0GgC/y3MQQ6DIBCF4auYWXeagYhCV71H48LItLIQDBhiY
 7h7qXH5v7x8BySOjhM8mgMiZ5dc8DXaWwPTPPoPo7O1QZJUZITBdcHcotC9UZ22rIigftfIb7e
 fzmuoPbu0hfg92Sz+6yVIeQlZIGHPVrLR1KnRPv2+3qewwFBK+QHgh3oJmAAAAA==
X-Change-ID: 20250919-pm-v4-1879568de500
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507676; l=3067;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ugzC+pgoMcvHsA/UBz02SmKrvFFMwDAliYqBtcghI1A=;
 b=qR7DEaZEFnD9Bkws39KTEajh0Zuw+NcxoCZ5wy0fCcK4eRHWDLIQq+8eUhR5PwQufVzFtSpVa
 UZSkZKJOiluC6UI9ZEEGl9KGMA30DSvTzv7c8g+Tm1FvMvOg+E3imbZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 96071c90-6ac2-4338-2d2e-08ddf97eb9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFhJQlRPMHlmUzFzMTUvTDN0Q280eEJZSWJxTHAvcmlUR0l5eGhHS055bzZw?=
 =?utf-8?B?SGUvT2I4b0RNQVBSWldjZS9uQ3EvUXJEajFvd2FuUEl0cmdsNjRFUkR2Z3Yz?=
 =?utf-8?B?dGUvMjl4cUF3eWUzbi93NTIrU0NHTVZXRnJHSUNDaXROR0pmc3lJeFlRb2Q2?=
 =?utf-8?B?RENqelFUQVVlRXdQNlRkZTMwTjZMb2lERWszWHc2WU1mbEN6eTJKREdid05D?=
 =?utf-8?B?SHhIZTRIdlZGZ0EwQll1Uy81amgxVTVrVC9wS3daUDl5YWtxUEY2aXlkTTVF?=
 =?utf-8?B?cHhkM2REMDc0ZlhHSTdWWkFlS1hSRENvZ0lXaUx4MlV2WkFDSWh6eit1bEZF?=
 =?utf-8?B?a0ZhbklWaVdHU2dITmpYZkdqNkpMMExPY3VGSTdOeTBpSFgvT0k4VzYzUW9B?=
 =?utf-8?B?bFo5UnJGNThMVmJ0OE1OWStCSFpZNmh2WDV3ZWZ3YzFGMGZ4MmhpMlZTQ1Fz?=
 =?utf-8?B?M0NaM0d1Q29iWkMzZVRacTFidTRtczNzZ3RoWU42TlFCQ0RaVlVhRWRxMkll?=
 =?utf-8?B?eExKOC9uRkg1QnozSVNFK2cyK0V6QU9wOStoUGw3djZWdVJOenlJcUY4NmMx?=
 =?utf-8?B?YnNNOWtJVUNQRVVWT3ZyUXdPUE93ZVZCSkdmYTZNejJuQ1l4ekc2ZTJVQTVM?=
 =?utf-8?B?WkVwSjJDOERScGp2UEZQZytpRjRkdUpXb2FIMjYzMnNIWUVxcWJKRXJFNGw5?=
 =?utf-8?B?Q3ZHVVdvY3FNc2pWSXZody8wdmdTY1h3MG5UMWtNTzhhNVcwWnh3ZFY4cjFw?=
 =?utf-8?B?UEF2Y05UZjNVWEViZ2VtR0tDd0E1WElIRFpMcmdqeUlCTHA2dVo0UGxiQkZM?=
 =?utf-8?B?aUQzOHZ3VmhZYm1SSzBlTnNtY05OdFdCZTBwZWdiZjhHTjZqRUNDaXFVQ1Zi?=
 =?utf-8?B?eVE0VkRKOWZlcCtDaEphSHBuWEw4V0xQaGtxbFNhRkdOOTJnYUJwd0FtTTZP?=
 =?utf-8?B?aFVJNnRMdzNWN3RTK1Q0Y0RFQkFlS1ZWYXBEellySmFjR2ZGaFo1THBIRGFN?=
 =?utf-8?B?VkhINDlYUFhWb213MHBJN01pemRYWFNJL3RLdjdMVUdmejlGTlhLV2ZIWFVI?=
 =?utf-8?B?ZFlnUTFvajk4OVJyZGRrckdENVBlQWI0TlBnZy9Ydno0a0tHSm1yVWp6V296?=
 =?utf-8?B?Y25FNFJ2VXpXdTI5SHhaRjIyWEU1RXJmcHhhNlBUYUVLRklvS2Y2VkFBWk12?=
 =?utf-8?B?K2FXRU5yWXdoS0d4Y2FIQmZYai9heVcrdWZYc002QUFQNmllUmdBOHRtR1Rl?=
 =?utf-8?B?b2l3c1RpeU9SNHl2bHBzSWQ2cHN5Qml0S2ZKQ3dIdFBBemp5Ym1XeFdoZ1g3?=
 =?utf-8?B?NDdUUDJaM2tvTkx2UTA1MTdTUEFOQUJKaEowMnRzQUwrelcwUExsUkpsLzgy?=
 =?utf-8?B?REl6TE81OUw3OUVkNVI3QytDZVduaVRjTVovTEFlQnFrdXhlNGJVL0lwR0pk?=
 =?utf-8?B?c21uald4Q3o2VEd3UjhGNDlXa25yNXg3cDZEOU1NejdZSXFJdEw0SUI5eXFU?=
 =?utf-8?B?d1B5ZHRONXlZY25ncHg2c2FHQkNjY2FpYXdXTThmeVFFZk93U0tTZVNhK1gw?=
 =?utf-8?B?cnJOT1lOOFRCUWVlWTFYYTFYcVpGSVVkQk43cWtLZzMyanhkSEMyWWdFOVFM?=
 =?utf-8?B?WlZPOVg5cDJJQlFqVFhTRTlSTGRMbzRSMDMxOGhObFlROU83bjVQREZUTjJN?=
 =?utf-8?B?ZnJVSktLVFN4dGdsWDBsMHl2cVFTY0tDd0tnY0hWTzlRMithVndNZDYvVjB5?=
 =?utf-8?B?aEZlWjdxM3dpZFA3STZnanBCRzk2cEJlc28rL2p0Znp0VktkMStxL3FzbzNo?=
 =?utf-8?B?V2ZUK1RpK2UwUEFrb2kvMkk3T01Pb3VZQmFGcUNqcGU3WEhFN2dUemlQTzRG?=
 =?utf-8?B?Wi9QYzdTNlFaK2RDN1prZEdKNUZ5SEphSitONmY1ak9EeFpNT0VheU4zaW9a?=
 =?utf-8?B?SThmT1VIdkRISk9VT0h2N1VXSmxvMzdCN2lkcW1UcEhpbDM4cTNLVDZ4NjRw?=
 =?utf-8?B?ZklLZGwrMmZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXd3Tis3QlMyUUdXUmVSc1htWXFHUVFEWGMxRlA0NVcrMzVvOTcvZzRsNklD?=
 =?utf-8?B?bXN1U205K2J6cFZKQW9lbE9rb0s1VjNtMVdmM29rTjRwVFdHU3JDSDM5V2JR?=
 =?utf-8?B?MUpXR2k3WmFMYUZVTlJwWHBIWGhpek5hbHNEeXRyZG93VVBMeGwzUzIxTDl3?=
 =?utf-8?B?dlpTOVVNMjliSEM0eXcvcjZKTFNqWXVDckdmRkxXRWs5Mjh5eDJsYTN2R3Nk?=
 =?utf-8?B?dXVVZVUxK2U4MG9FNFVyUDNBeW5DMUZOT2V2aXVZc3l0clVueEZEWGFaaFlo?=
 =?utf-8?B?Z0ZCdFhiR1hqUG0rcU9EaHRzVUZtREd6dDRrVWVaeExsVStYaTZsN041c1dD?=
 =?utf-8?B?UkZaY3FjYmEvTDl6RnFobnNBN3ZINU94UWJrdUdvT3NSaytxbUNKSEZTMERO?=
 =?utf-8?B?cWpLWHlZOVlqYUJ1VVdQNEJONEsxbzRiWEJLWVh6YnNzWC9jLy9maG9JRElO?=
 =?utf-8?B?RG5tSGRQWHFjNklTc0hPUDhkelZZNU1TYWliMUV2cHREeVpWUHRxOUhCY2V0?=
 =?utf-8?B?U1Vwd0VtM091NDRHNy9PRWxMcHpON0VtSEowU2FhZ2owaTN2RXZ1bStITGdW?=
 =?utf-8?B?NUxYTlQ1YXNDL3BLSG9PN1FoV0ZuekZkaXNJOE1iQXZEMUpyeFQwdVRwdmM2?=
 =?utf-8?B?V2JtNmZOOEJpOGxFNlZZYnlldExVNmdOcHhYZ1dqSy8vMlJSc3BwK0RucVhq?=
 =?utf-8?B?TE1MeXlJZEI2c3BXOCtTaS9pdEhIUWNKRlQvQVVJc2FYYkE4UEhsM1RUOFNK?=
 =?utf-8?B?V2MyQ0dQSTFCRjEvOXJaWTNWSWRJekpjQ3libmJlUXFwYXl4cmllY0tOY3NT?=
 =?utf-8?B?akVKRlFTVTJORGV1cEVqNG1ENjdUQXV6YVJSRWZ0a0JIbmVVQWpRUzZwaGQ4?=
 =?utf-8?B?aGdjK0pLZ0VrdFhha1paeUIwTzJlVERsMjhEQUpybGFEUGFUTzNjdTJGK0RT?=
 =?utf-8?B?angzV0NqejdUR1YrNUxoS08rZFphZEJxYmp0R0gwK1ZyR0xnWnJNVi9jWXBW?=
 =?utf-8?B?MjZlY1dUU2JJQ1ZYOVNINkZzSHlTTVpXRnpwKzJJaGJHd1lpRkYyUENITUdZ?=
 =?utf-8?B?dVVEUldmK0JTNEp6SE11UnJBK1ZOVmxlZllUOHFjQmV0NnNpVE9sZHhwT3ZW?=
 =?utf-8?B?N3JRT0tJYkVORjZnOElsZjVHemJCbHN3MlZaTDFYM3VLUG1GaVJteEhXR2hB?=
 =?utf-8?B?WE55U0xzM1I5S3h4bkRvdVhFVFFaT3A0K1c5a3R1enVTa1dLSndWQUk5RDVR?=
 =?utf-8?B?Z2RscHN3RGR1S2cybFpEbWt2TFFpVDdFRTgwam1ZZlpUTTF6SDFQMWlibDZt?=
 =?utf-8?B?dVNNWWwxdU9BYVdtVHU5SnNnUGhIMUcxNUFpT0xVSTY3UDRibHBzVXBSc2FJ?=
 =?utf-8?B?VTNqeGtzVnJwVkY0bW9OeGRhUXdKRTIrYkRHMGNLNk1ZcXljTXZDbVEzdElY?=
 =?utf-8?B?ZjVKQWUvMHl0TTBZbzZrOWwyWlpDMzQwd0tNbUZhamVzcmFsV2YxWDBsam4r?=
 =?utf-8?B?WGd5UEp2OU8xcWx4UHlWN3JnelZHNGJwSkdMMXJqRWVhbUwycCtVZ0Q1ZGtH?=
 =?utf-8?B?M215djNtbytqdnhmeWYrWG9KOEVEeHAwNGJRS25IaVZjWmkxUis4dUVmZmY1?=
 =?utf-8?B?T3BHU2MxMXgzaU95RDlWQUxoZ1IxcmxhRDJtV2ZVWmFUcUxBYXFLRTRqRTdQ?=
 =?utf-8?B?NnN2Q2FNSnJUTnhJRjkxZFp3YzFsaGJoZWxBQWlRcUc5SWh5bmNBUEZnc1hj?=
 =?utf-8?B?Umtidm9SNjZzSFpWRE1RSy9BWFhiUUo5MXdUWk1YdGx2L2R2QXU1eXFoWTdS?=
 =?utf-8?B?TlgxbGZObTJXVVhTbUxNMnNHYXVtZnNGQncxaG5tVSsxYlFDTGZLbTVlWC8r?=
 =?utf-8?B?UmlpMkRuTHRNbzBWM3BOQnFWajVnWHR0cHM5dm1GVytkVENOWU1kWVRQOW51?=
 =?utf-8?B?bHhUS1Uvb2NSUUIwOWJBN0t4L0p4ODZPOHVibWhhdk4vQmwzSEEwWWpIcWt2?=
 =?utf-8?B?SU9YeC95aElpSnVBRnJEYmJKbi9SNnhnUHhuTzNuMnVCQjcvc2xOM3RSTFZE?=
 =?utf-8?B?WUh5WnFSYmhGNFVTMzZrQU5lQmdVdUFpbmpjY2ttUXhJZnpSdlJVTDRWaU5C?=
 =?utf-8?Q?DCiVphhsOgIuW2eHaodB7huwT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96071c90-6ac2-4338-2d2e-08ddf97eb9dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:21:23.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MB057BC/lbipwuOlxDHVxwP7Ng4m58WdfZsnIR01MeQSQI2+PTHeq2SmwNVvqXSpU4W0Y+1PvTMqsFw+vG1Tzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053

To i.MX95, USB2 and USB3 are in HSIOMIX domain, but there is always on logic
to make USB2 and USB3 has wakeup capability when HSIOMIX power domain
is in off state. So when in system-suspend state, USB2/USB3 could wakeup
the system even the USB2/USB3 HSIOMIX power domain is turned off. This
means USB2/USB3 has out-of-band wakeup capability to wakeup system from
suspended state.

Without this patchset, if USB2/USB3 are configured with wakeup enabled,
the HSIOMIX power domain will not be turned off. This leads to more
power consumed in system suspend state.

This patchset introduces device_set_out_band_wakeup and
device_out_band_wakeup two APIs to set out-of-band and query the flag.
In genpd_finish_suspend, there is a check, if out-of-band is set,
it will continue to turn off the power domain. In genpd resume flow,
there is a similar check to turn on the power domain.

Patch 1,2 introduces device_set_out_band_wakeup and
device_out_band_wakeup
Patch 3 and 4 are drivers changes to use device_out_band_wakeup

More old discussions:
https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/

This is pick up of [1]
This V2 patchset
- includes usb driver changes to give people a full picture on how it is used.
- Rebased next-20250729 to resolve conflicts

[1]https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/

Changes in v4:
- Split device_set_out_band_wakeup API and pmdomain changes into patch 1
  and 2 and clear the flag in device_prepare (from Ulf)
- Add R-b in patch 2
- Move the call of device_set_out_band_wakeup to system suspend
  callback in patch 3 and 4. (from Ulf)
- For patch 3,4, I still keep the Tags, since compared with V3, it is quite
  small changes.
- Link to v3: https://lore.kernel.org/r/20250902-pm-v3-0-ffadbb454cdc@nxp.com

Changes in v3:
- Add a new patch from Xu Yang to detach power domain for ci hdrc
- Add A-b for patch 4
- Link to v2: https://lore.kernel.org/r/20250801-pm-v2-0-97c8fb2a433c@nxp.com

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      PM: wakeup: Add out-of-band system wakeup support for devices
      PM: domains: Allow power-off for out-of-band wakeup-capable devices
      usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
      usb: dwc3: imx8mp: Set out of band wakeup for i.MX95

Xu Yang (1):
      usb: chipidea: core: detach power domain for ci_hdrc platform device

 drivers/base/power/main.c          |  1 +
 drivers/pmdomain/core.c            |  6 ++++--
 drivers/usb/chipidea/ci_hdrc_imx.c | 11 ++++++++++-
 drivers/usb/chipidea/core.c        |  3 +++
 drivers/usb/dwc3/dwc3-imx8mp.c     |  9 +++++++--
 include/linux/pm.h                 |  1 +
 include/linux/pm_wakeup.h          | 17 +++++++++++++++++
 include/linux/usb/chipidea.h       |  1 +
 8 files changed, 44 insertions(+), 5 deletions(-)
---
base-commit: 8f7f8b1b3f4c613dd886f53f768f82816b41eaa3
change-id: 20250919-pm-v4-1879568de500

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


