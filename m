Return-Path: <linux-pm+bounces-37630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20934C40FD1
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 18:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7131891C91
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 17:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AABC333448;
	Fri,  7 Nov 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ns5N1yhi"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26A22836C;
	Fri,  7 Nov 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535523; cv=fail; b=FJv7x7yYFaEcQQPs90x6+MiIzNHUVi5xaszJdCqbsz7qulumQfgY+JzjcfOTsQpW1vidvrGTYnqz38rbIuaLrpg6BLrvWc37ZTgaBWrz3hDXF19lZaMMARpAWOkX+2e2/LtXIXx5xCE7siOYZXfKuivNTJb5/ONPJy90EjGs+zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535523; c=relaxed/simple;
	bh=36vwyrVuu/ymszuhG8xEkERCr4nwFA8mijzy5aVAG9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=og8xcG4480aYKHV6EkfbEt4cYeSGe2rP/5CKTGx3UKe2wva3eDIEkTPn/m5c7219ZAxnEu2z4nGLUB9xB/gvxXYFk8iuDQq3SBaz57H2pX2K/7u+6Pr3WnvV/N9muyE13mmGIWHyz6ALrqKTvV6oeQcTwPTSRDnolZg6KeAu9Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ns5N1yhi; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFxL4gwoUPxS9xpTnktmrc2W+ep7e5SaSOryYorO2HIt3cU/PvOsVYkQF5H0/ucq1cfxNkobLySlP+xsz49Qr8Kq3bqb8P4gp8Swd2He6MRM65dlY32ye0sJrbvy2W0uTohBoslOzAAWeugHdRYqjqku9NFbJAJ81ST4fELKoNal5T4haEoEwRoXkW8pOFsypYL6kAd760pOUZ+QXLe5gRgD7MeZtTJvBxRmCHYRMM3FHWEm1FKbHNpemB4POds7lIXSi7FaatQD5eVfIWs4PEkh4fS3lrTPRN9b6qjMRjIsr1o1VTW+L58XBOztZgkdaWDndhEKv0OkyhgGhVx/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d4HNobGnJBP5LmJr5GGfUSzsZYLOr0wPp78InFogZg=;
 b=E1AUlaMpVXFZDDu6Lr5fngFCPAnRC2uzOjKHlJReRJxF54ma4H3QjUDduathp4JYYLdQhHAPV+n2LQsEK+I0vdce62Xi89tabZmyMIHkku6WjDEBOUgWsfkLRZ4EAuaM5vK9N7qNYjYeeDLUBNmGLzji8tbv7ditmZDx6iUPiHFjFpJg3vWLvZsiAzT417bn/sZlpp8gf4D169+oze7P4XjxV2I/9v4I5+P5ywB2otWKViY0d0jX6x6ASQOJupiM3B/GEpBsnxAA2+7pHMFlaIIba8eILrAyR9jmKHkXnwiSi8zmW4QC11tZ8g3ZnpSnL8vqInY7YXCNWj34Kv93xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d4HNobGnJBP5LmJr5GGfUSzsZYLOr0wPp78InFogZg=;
 b=Ns5N1yhiHbSpdfq1vOzOZ0V4GtQtXmHg28yGt/f87nVmD6cCFq6NtVJx8T/04gz4zQIGXHiycwmHKyx+VnYY8jpCNwOXcDXX0ix2rGO3MxiXnqL5QaPTGFvzXiVQ4us36lK949cg3bZL1pI8R2BDd261HAL9ujxg3gn1i94ecgxkhvAqgad8pdGQfZZJMo7zjMQWUt8V4hRI4V/mZE6HPSB/60pnuNbxlIuG7lmLFxpt1pk3sNST0VdVioRKeYg0FkBQcr5JlxbgLK5WUGVOzoweEG6TCWThACBCmZ248jE4RpgGiGKgYJ5X/xTnsMGzg+yhjRP0+7EP0V0cnBon3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 17:11:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 17:11:57 +0000
Date: Fri, 7 Nov 2025 12:11:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/13] of: Add wrappers to match root node with OF device
 ID tables
Message-ID: <aQ4oUYkqg5Zi/61T@lizhi-Precision-Tower-5810>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-1-d780ea1780c2@linaro.org>
 <aQz8rW9GE66xPYrL@lizhi-Precision-Tower-5810>
 <aced7337-eabd-4b05-a0d3-eea7079d08ec@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aced7337-eabd-4b05-a0d3-eea7079d08ec@kernel.org>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b71c63-e41b-40a8-e090-08de1e20c1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cevkYDKTyWVmRFJkysIHh+UKbxGF/Z1lOiyk8WDgJp2Jg16pazV2X9QbiVYs?=
 =?us-ascii?Q?W1XLqyo0k+ljl59hkDSHAw4FoV504cbiLuJO0BjIFfEdGNcSW5kiXfO8hWae?=
 =?us-ascii?Q?9RjcONQpq6MQX4Ruhizbwm37bAArge65Mx8YN2zshPeTpPkozOBo6BcPsSqf?=
 =?us-ascii?Q?NPJYK6s1T84H7MDkaOpRYdhcXSQHDa+IBH544g0j15Rs9kVG7WGGmjTDuio6?=
 =?us-ascii?Q?iObWJ8ia2b8NGao2opY0VHoy+vmhGLwgoBTSItp68UGqoNJ6DsFmqHmOi5Le?=
 =?us-ascii?Q?9GlgfKWPrK8NpMlpCNt3mGqJSjj1TkhBEark7Gb5zzF7r05H/EzbzPV3OmOw?=
 =?us-ascii?Q?6ZzDUmxcv9kQRmsvain6J8plXgdJCSACMtxqqR+Ai72Hztl8f6YNo5yixgGY?=
 =?us-ascii?Q?r3DhuqibutK2ixB0LbRagf0VfKJJXRqq1h9F8wLkFVDQKMd2TuqSvceziZ2X?=
 =?us-ascii?Q?q8oQg7n5jKprcf/qYDBLLKdvk5Dz2REFP6a0LN3iF934V3nJMkKHg1v32Jc5?=
 =?us-ascii?Q?t438ei99CivDUeAg9jut3lJXddAH9L9pV25avVemnfHH3MkHbyw7LyaNBHYr?=
 =?us-ascii?Q?dgdW6vkFRu7i8/kgJLAtuFjtBrGg1aPfJWeLKEuBvtNOjJJ1mXMF1870pA0A?=
 =?us-ascii?Q?f5qQv3bWw4wSvSRuZbLdbkPZ+tQhyXd8kGhGXrqSWSE8kgcROeN5A5n7jjOQ?=
 =?us-ascii?Q?ckY136bvir2Ek8vlp1uDS9VKfLqzDxaIjt0Qmjmwj0jirCfFQ4s3Etrnkenc?=
 =?us-ascii?Q?E/lrHn98Q3ZDa2AYgpyvr89NAg1j4mmMQYOTqBrVHUS9f0ehmYceYqkI6i/f?=
 =?us-ascii?Q?lJTmJKzDhF3idhxL9qO13eTx105QYEzjsdQU5Oo3hWhKe1GTtpS7BiU1R3Ox?=
 =?us-ascii?Q?7IX9yfI+6X4MNuBGSYVxfrZ1SnxVGCDdCbTpN6bNqmgVilgQcb15gwg+F3Q+?=
 =?us-ascii?Q?3mteXjzYOuwJeFrc967ClBrguo2q4rs0G1HnT3Ah6lPZkSoiOIJIcp8oDkRw?=
 =?us-ascii?Q?TgwIeTBFvthxpJbkGURDSWnVPINe+xsu8ISlGKGiVvTxzZRtt3rvbub396Xp?=
 =?us-ascii?Q?KlsRoCSj3gMG+mCktJaRMaIkr9Mp268xrcSyHGGvfnhsKTW46GB5Kj5mmiBJ?=
 =?us-ascii?Q?hJnL42PLEmfAx/w7I8cJQMHNr5PUsVg26NY40yCla7HIG3N5dlLSiMdODvzB?=
 =?us-ascii?Q?/KW+ec6KUSpvyiLmuZ8q5MvAHhSyVoXTXf4twjY2FIHAMVPLrpkCHtZ0EyJk?=
 =?us-ascii?Q?KeY0rgzwmeJ+flCUlEEEHTZXXxqgivlIrGO1+Z9MtOih9eso0m9OZQExhc60?=
 =?us-ascii?Q?FycYjo/NKwsU9byAh72kFcWUEutU6Yj4OFDLr53qC9iadTJn2Nu2Iukvkubw?=
 =?us-ascii?Q?jWlyo3KKYrjMBPBhRnKraUOMjS1xuimZPg3+sniqNn2axbrq2T/YNTmoUAj3?=
 =?us-ascii?Q?UtbSZa4goVpnuEzZZCc1WuYJFwy6kXk+OiG/hIaJodZIao47mrL26wIlKtNS?=
 =?us-ascii?Q?O4Hcc5kZqu6/x513NZqupgMrdJXLOuTPtOPR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvmOFnhl2zksbzAodIFd7djp6I/F2EWl/rscIpb9x1/1KTZseMSFYb3fNpKw?=
 =?us-ascii?Q?tEelFKSY1IrLN3qePx33L44Ut4RmA4ViEd8YD6MPfq3UeLQCnBCR5wWiTW/y?=
 =?us-ascii?Q?9jeeJl+Qoo+pcReTkqR9blIsCJ8BUHYQTU5NFm/QMiZjRKBNC1Ej2dMuSNru?=
 =?us-ascii?Q?ms+5/DKGjxmZ05BFlfZsFgNlWL1iwfQtwzn7Jy4JeYXWoOxRCZX4vWkUmxX0?=
 =?us-ascii?Q?l2rL2/FxH4JnBCCoWyFhxnt0TbQvylZ6FiTnzSJxtMDld0U7QKjqwiXkpWSO?=
 =?us-ascii?Q?tng9ER+X2nHiAqywgq54YowZ08w6QbDPjWUQLentOMqECP8j7kSD8EcEtcN3?=
 =?us-ascii?Q?bmD1VZ/iEWtrUFCCqzXqhD32JsLuECjIpYjfxZpVyU822qAPG+t59RCFchwf?=
 =?us-ascii?Q?g5+909HKlLMGsydWmmpeWERLZGcCplPIWKm9UlPed8xQ6e05S9lhUTDt+JTQ?=
 =?us-ascii?Q?+k7sEEV08O6WTEmoglLwdV+pkRcHSTJEVlAku0PEtw8tW/0eAU6usVCZ5YA2?=
 =?us-ascii?Q?Y9yi1L6iFtaFbjn3yCWTyg/xuWyOX5tP1rRrL0n+G+GwobIA6gSZTRCrVbGA?=
 =?us-ascii?Q?4xQA944Yi9nXgFi8Qmj/E/yAWjXmaDjPgb1caw0uw+qusLzZLU4CbFp3qTnj?=
 =?us-ascii?Q?niQ+2vHIOr+5MVt7/1mAJkmspxMxJAXjoKHJXP36zMT7W9Z1P+2YCXFtwLVW?=
 =?us-ascii?Q?u/OYRpXC55mYNIAnVFyNBw6q/cEw3GwdxgR2E92F6FXGfVqC7MO00WbQv/eI?=
 =?us-ascii?Q?oniOUU3EeS3dxdUN+M7LD8SUf/t1k9dD5sWUG1j/raCS3eXyBmCnaKe92BM9?=
 =?us-ascii?Q?vqZcZmSTtN6nUCmR3Q6+4EMo2XDUAgLv2lDjlFygrglO7gyJuYxB4QpZf1tT?=
 =?us-ascii?Q?ThqpDaEnVfQJXlWUEivwwlje8BFYcIiWf7+gNlFlMu0P8UrmXV8K9TMJ3DZj?=
 =?us-ascii?Q?00+kizac8GPYyjRxLXS4a3zRoDvu7PDkXc/qroeQJhl2r+iTigDLXC9aCRgs?=
 =?us-ascii?Q?gkyMJe0Y8Z9qPFHSL0jUOWrWGpslUoY2oQAjnP2DQymeD6DGEF9rch+SGqbZ?=
 =?us-ascii?Q?FFFqHaP4V5tUik3KDh7BrDQXJXt9lPtGnJ5ZlZtXxdJUH+ue6ZUyKE0wzDp/?=
 =?us-ascii?Q?+RtoKR2gxMvFTm04Bc1M0uOOlhe7SZc9j5+z7g1PZQGcb8owCreVvk0NdnIZ?=
 =?us-ascii?Q?uRL7d2JmPV6sO5K2OWjus0Dgh/ZZZCEqcR9jTB6TYcEZ7hQmEVnTZmObC5er?=
 =?us-ascii?Q?W+XpyUFstlPBGSNyWvSYZ4uAFJoe/FqRQCKj0xLoq2ICtRso3vvpCYtaHjs/?=
 =?us-ascii?Q?ouu786BHTan3Bb1ULNUZ2XER6DkYn2FTLLpZiDqgQ5rerelH2q2AzqlXdCri?=
 =?us-ascii?Q?wUC0acdnR6jZ90zBD5L90TbAF0jzeD582nFcqJac6Kpqcj5RVsQmwrMcP1K0?=
 =?us-ascii?Q?whXCrr2SAtFdWKP1DnAoCVi1lUfF7emRgWGvWaNhiRXiaKXPGlx3dBP2IVSM?=
 =?us-ascii?Q?2iN/z2r4xaU+j0KfCRIkFXVtYOYCWnJy8jBLruQd4E+tg/i2VWR5dn52sOuh?=
 =?us-ascii?Q?Njpn155S6mz5LHwiU6Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b71c63-e41b-40a8-e090-08de1e20c1ab
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 17:11:57.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbYKCI2TUm3pu2vmoM2pZIjh+Ct0C1zQQ0gocA0X/K5pv9PeTIrh/gVfjyULFa86ljhip2/4mBo2Sk8iGqZuxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514

On Fri, Nov 07, 2025 at 08:00:53AM +0100, Krzysztof Kozlowski wrote:
> On 06/11/2025 20:53, Frank Li wrote:
> > On Thu, Nov 06, 2025 at 08:07:08PM +0100, Krzysztof Kozlowski wrote:
> >> Several drivers duplicate same code for getting reference to the root
> >> node, matching it against 'struct of_device_id' table and getting out
> >> the match data from the table entry.
> >>
> >> There is a of_machine_compatible_match() wrapper but it takes array of
> >> strings, which is not suitable for many drivers since they want the
> >> driver data associated with each compatible.
> >>
> >> Add two wrappers, similar to existing of_device_get_match_data():
> >> 1. of_machine_device_match() doing only matching against 'struct
> >>    of_device_id' and returning bool.
> >> 2. of_machine_get_match_data() doing the matching and returning
> >>    associated driver data for found compatible.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> All further patches depend on this.
> >> ---
> >
> > ...
> >>
> >> +/**
> >> + * of_machine_device_match - Test root of device tree against a of_device_id array
> >> + * @matches:	NULL terminated array of of_device_id match structures to search in
> >> + *
> >> + * Returns true if the root node has any of the given compatible values in its
> >> + * compatible property.
> >> + */
> >> +bool of_machine_device_match(const struct of_device_id *matches)
> >
> > Will it be more useful if pass down path
>
> Path is fixed, there is no point to pass it. If you claim otherwise,
> please bring example what benefits would it bring, instead of just
> asking nitpicking questions.

You design new APIs, which should be used more widely. Now there are not
such user case yet, but just avoid need rename again when new case add if
just little bits improve here. Of course, the policy is that add it when
needs. But keep some extentable also negotiable.

>
> >
> > of_machine_device_match(const char* path, const struct of_device_id *matches)
> >
> > caller just pass "\", or NULL point as root
> >
> >> +{
> >> +	struct device_node *root;
> >> +	const struct of_device_id *match = NULL;
> >> +
> >> +	root = of_find_node_by_path("/");
> >
> > Use clean up will simplify code
> >
> > 	struct device_node *root = __free(device_node) = of_find_node_by_path("/");
> Not much difference. Look at existing code first. This should not
> introduce different style.

__free() already used at base.c. It is not necessary to align with what
will cleanup's code. I know it is little improvement, but code will be more
clean and simple.

Frank

>
> Best regards,
> Krzysztof

