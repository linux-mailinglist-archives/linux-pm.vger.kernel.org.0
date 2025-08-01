Return-Path: <linux-pm+bounces-31760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F99B18363
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72827582681
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C51626CE13;
	Fri,  1 Aug 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JpzQnpJS"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA826B2B0
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057361; cv=fail; b=d1bPyMzgnrr6BmI2s3e26ZcfyHoYpoOeFRs2Z+Z0hOhjnbDQMC+awxfWDBLyZSTsy3niU0+ry9KINKb73uUemjptvv8FbuJCasRziSV2GJerHMDOZ8RNfIGU/Qb8n638AFI0HzsZuiSoXzC3Oi0p/IGe3HAab1EVJpXtT428QDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057361; c=relaxed/simple;
	bh=n+HZoEtd84RxCAcTxvplu1zeLGGpBt1UauZxLy/P6Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gr6hLDZ6qsNNyUM9XTd2g/Up1jVnXIVKW7wy8Jxn2ROofBqasmkBDyMaBDq+8vI35zgCbnCNTT0leZ8vtJFOdqkOlRrY/hy4yw8dnROYIRoKZt38ZyQb/4CIvv6GcWgLxMhSNcUBoG2INmsMzCfVeuqEGpCRFsLqb6qtKUlv3k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JpzQnpJS; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmTEPKTiNFI/YlF7h7IJGllX7pMlRZrCQt4kGgx6elLp3MVPiErQX2YC9aIsvciE2N+tQzvRdugIn3lv3XAMAtinpVcRULEumQF6kkn+DL/8jYT8SSn8cqHqYNtUDRD5TD5dWmVosatTnNVp1ks122t0NnOLZGREEMSTVr7O/P39vDcqV6yM5/wVq2/2YgyaE3KPayrAVB61zwtvz/PHFfXXIuevcPi/cCzqnh0tf7rHam5ziAgO3rizzvnefFRw0okdgAckLwAy1QoYGHmkdFjQZpaMlcU3/xTsiv4ttMo5eLnXwYZWlMF4epcVB3UD6iaSBsH0pXYtGAzxm2aXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wse6RcXpbMizZyxU/AM+SRxSZPGrAK0fEyOCQh80+i4=;
 b=zIYo4FtOQ1UAl/XFl3c9xAH990nXO5NfRlOfH4dPzFIZCXKEqWYvnYrlLA41f9yvDyaS2f25DexzXadzTdE0nhWpe0o6VTR08/60DzwyFbDHE3kbNGyDrR+UANFqkSGoGrvysNjaiPvXQfodYxgyef/2hp4Wg9vP4NBKQFJE1vF+IUmNDGguIf7ynQ2QDXZiOT4/ygwJuAmCrchK2Nc2HrjM5nzobci7mKyRpMZd6BxBMh1KXGCT7U1MYlafgcuLemTsbUGHFsrywlPEeLnuXH6zskHnIuPr2sIMUYh+NnhIvli7N3DjEsOuQFW6UMX/+vlqMd/O1KKERS77eY8JIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wse6RcXpbMizZyxU/AM+SRxSZPGrAK0fEyOCQh80+i4=;
 b=JpzQnpJSQbypF2j59oeyedYa2l0HqrUYLwzTkMRZ1B/vL0gAND+HcsSFiMVtJr9wpynEcRux5zKNgLsJDmnbqBqHCnN1u5ZuuZg2eSNqWFfcgR00gE2/fIzcroS/KGiKHf6lqrPxVL+wCUTRsKZjLif3HffszCUfxZ/osell5DHXCk4GGykjP32rtCMIYph1TxB5Q0hE3O9b3TBKQ3DgLb15rXbCWIf/uKzq6Y+GwUrPjwhb6ZeOa/jvz0pQuFDFR0XtYFyetBdAk9z+LbuDj6W3jhmQjQ5iS40tJeSNvnHFwcL5QGodDmYws4Iz8aXg+MZakGtHWiKCvaoHlQrZ3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 14:09:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 14:09:13 +0000
Date: Fri, 1 Aug 2025 10:09:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	rui.zhang@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [PATCH v2 2/4] thermal: qoriq: add i.MX93 TMU support
Message-ID: <aIzKgvERyoaCpnyt@lizhi-Precision-Tower-5810>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
 <20250801081119.1999298-2-ping.bai@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801081119.1999298-2-ping.bai@nxp.com>
X-ClientProxiedBy: PH7P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 257fa70c-08ee-4dc7-10f6-08ddd104fe8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dKItviputsA2432idIeOw8KPVXlxZNbRuY1D1HdrBqSFhv2qmXfYepjM3XoH?=
 =?us-ascii?Q?5cB3d0RJS8xOnNPqM/RITZFdDArgzyguhRti+/H6veB42KWHy0mRaPcIPxIR?=
 =?us-ascii?Q?PIiVxgjaEbz3G5l+zoKbwojNUx2ms0pI5QIcA2oPQTpth9hutMA0sAGjJ26+?=
 =?us-ascii?Q?nm+x28pFhfvheqJ1edKcMyRG71koK+HzUyQNzL6Zgdldo0qGiC/OG358/ixd?=
 =?us-ascii?Q?bMTaKdY6wgCUpn/ijk0qlmv09s0X2L9NPYxDg5IfbtsAUOpuxFY0qkLmr882?=
 =?us-ascii?Q?SHAYQxsGdDCMBFXkF8FLEJlxD5yNqoKIKe6aBdYyhdcUZhLi3PSP7SbTIMfW?=
 =?us-ascii?Q?eOHInj8Lh3yQkm/8Lm5peCWoj0NlHJ2KeEU/rmPvjnm2EaaKohVHZy1rVWq0?=
 =?us-ascii?Q?RzbGvYO/lrcOlbr2AgwWbCl3AD5MDPJbXOGJKzdgf/v+X9HrTeNXDvHsJrbn?=
 =?us-ascii?Q?CrCUjYiDrh+zskNqjgHdQfOng7Tf/MtqkeEnrphomErFPnrz2/ucw2HgJbbd?=
 =?us-ascii?Q?POhw4cDCjP8DrjbXm7SDqeM7fMqB/rmrmMWNj4uC9oyLb4byuN96LaYXwXIT?=
 =?us-ascii?Q?ogpJLSPfVfA1XwK9Nt0I/kJmmE54+QHa3ejNF0Bq5cu7wFIiaOlsLIHHNcY4?=
 =?us-ascii?Q?GnD8TGrQRegQB9AWJH847OK6XCfvqpc/rkqLmJ3MhhBXH/mdmNImBGKXTsZ9?=
 =?us-ascii?Q?ggFAYltcdffPNNQzxONIiXUOvH6UY3KbQd04hPrRzgwKRzqrOUbkRgSuVLZd?=
 =?us-ascii?Q?cJo0UhTVuDnr4NTJSSf2SlHHyKj/ZFGJz2HW5UNE53jOn8bDQI5tbw4kanth?=
 =?us-ascii?Q?fF7ovQ7AyWvYGgLA0QZY+x6HLkxK12sTujXr6wPmy9MnwPbVcXQocviF5g4g?=
 =?us-ascii?Q?BrSm2TYMbBwRyGFxT99nUQzbJskk3aBzymhXENesdOV8YwTW6DLhbFOUx+Ed?=
 =?us-ascii?Q?cPGKgF9xZ+1cctAJhOQPWc5G9/A1RCk+geWlxHgyUxku8TxcKCp7XArtkmRN?=
 =?us-ascii?Q?5dknqbRsVY8QJJxqvyMeIQsNKMWS9T4Tev7RCK4HeT/+6XHS5iqAFxAx7Jd7?=
 =?us-ascii?Q?kNYkcm6OOFd98wlbr3Bm+EJTlnHUNEnS3K/a4GwErCwdsn41/ibhUsG/suZ1?=
 =?us-ascii?Q?5PH9RZkXSdVLb7LLUa1eh8SSluBynkgo6/oSeOzfY+BXeJziS+EPZBtOcvOc?=
 =?us-ascii?Q?OBMC30W9qzaUgnnkDQH8qyF+/UcrNinfbfjgJjsPm4Qtjy+3rJQUK6BKFA0J?=
 =?us-ascii?Q?UBrCXxEoNjRo8yil9mKyWkbaSQiSGH8tqt/a4TLI3pTfN+xDLGJbloiWIR5w?=
 =?us-ascii?Q?QMSBbmG7rlVOLHpRnt4rMtJRxhh6vK0zQ/7RLNKcKkxKElPPdG+xgmchl4ls?=
 =?us-ascii?Q?gZ7z+PTaM4EMrISl/NSvzz3EDv67XaiYP6hNjJ94bPwE7msbwLhvU180RK1H?=
 =?us-ascii?Q?Qys7Ayc3O/nKlhNavIEZUzrXhYr2E+2DmiqG/ZtrXTLAQyCOhPfDlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MN3tPXN7iNodvipOtTovkNNcPT4FsB1vg2Cq6J+lbbYLaM+fKHDlYgXfMfOq?=
 =?us-ascii?Q?U3bpOx4wiO+rYefuI0Qpdc184r3WcmbCmvMra4z8k+CPwcJEPG2ojIMZo/Ji?=
 =?us-ascii?Q?/sJfa82BOqBFhKIo4Ai3mCdg30P6icZpsJ2Q9MgJKiA5rKFq/2SOTA5Wsl9m?=
 =?us-ascii?Q?GWh7fcj4U89FBT2K2qA43cXf+gLQqA37VKDt976M/W/hlGVBGGzQ3iEzQzDg?=
 =?us-ascii?Q?jnPIbzpowbSV6yvWCtGfDx5nJRqpp3zu3502DN+8lJW6x53UxolDW05M4MGq?=
 =?us-ascii?Q?Jyiserxj3GYYQKi9hCv5ViPsSM1lVbzqS2rLtL2Fpu1Mldcj1TCfeunfbGbM?=
 =?us-ascii?Q?SD+CRZt31W2p3vaIdO2ubmYR+lWmaOlfCaJfzG/9aa0XARNsPAtjhKJHJADT?=
 =?us-ascii?Q?4PcbR+jOYZEw3vbpZAFKLy/tYUnRKVmuVU2jqi8qsveNZaJ8i6ILtoeJXG+u?=
 =?us-ascii?Q?MZ88GM9Tjm8ejvbSFYM+8AE+ZaPf4rE3khspyqKDfnbzhAFa/eM9E/qkldzS?=
 =?us-ascii?Q?JJXw3UKfU4fDWzoyvqGhxr39AkeLbV13KsMemjg2eH+nLCDsySwSH4XVqQjr?=
 =?us-ascii?Q?PopKmmVlDtR6GNd3/agP/Kaa8PBiFAZm1ra884nWoToXAlRQAKLCSg9Gsoi/?=
 =?us-ascii?Q?AJn6dhpKGg+9OrT0wqabA69feTJhiQUEiGe7WhLNv930CIpvfY9QUZCo7CIv?=
 =?us-ascii?Q?YJ0sVo8MVz2EdFIQRHWcp93824blnjwgN+5QHYXjftzwmgNGBciw3ae9uhtg?=
 =?us-ascii?Q?Pr05Wvl0RxHb448Z3TV5ke6f+JbCZoEMy3qMpbyyBPWvybtjFplAitU0Qp/K?=
 =?us-ascii?Q?hiOKlOSTLxf7fw3HH+fQ/ieqShrxf4dLt0eSu5wgqLzMlxNQLH3w3X1gGWRk?=
 =?us-ascii?Q?7yHFXphN3azQaC/+ROMIj5LP3SDcG06Kn20fNBw8ScrSgu+Tncv9vaSFsxBn?=
 =?us-ascii?Q?4gTsFF/feN8ob1ki5gOk8sgZahsgfPGnTVuthwYWZK/xq9GW4Y/yc2YvGnQM?=
 =?us-ascii?Q?LxBaJ6gpfdDrcz/XqRE0eRb4rLdhYHpll2pDS/iSPxrv5cu4Z+BIT35Prerf?=
 =?us-ascii?Q?bRHdNcz1hSuh8QMTLB01WCqRccaTT3jurtjtWmW8JDrKMWU7+/9VBavuQRW0?=
 =?us-ascii?Q?tKSD9ynakJC4ygW5vxBXd/9S9VDOJy8tDDlLMUt/blKMUM7bZaoWFypCl5ce?=
 =?us-ascii?Q?VRdTypzt4GYkBhDMSqDfufpJ4SIBRj+hP81fEUQuOCVyr63xI4jijfFkG3A7?=
 =?us-ascii?Q?NKuwYYbjTaFg1GgeUNeZgaJ7qVK24boQ9rnXuu7sqL6DIhBZXE0oDkq+yqz+?=
 =?us-ascii?Q?kYeGGSMkpc4+WJXesTX26Ccn0M3j8NcM2VynrPkdQO19v3Pi/scKKYyO9/q/?=
 =?us-ascii?Q?wVrLEYEPOkX7MYDKXPv9VC8bLqAXWYLA9lQUnvviVr7NSaeV5d/k9lsF9at6?=
 =?us-ascii?Q?cuN9a7eSCUUH0ohY0nqEZMopqAHqDvrWXPhbd1rXkCELNzfojx+yAr8aHxxa?=
 =?us-ascii?Q?NTxBvJNPrlZCzERK9WH56cikdYoMFCErHmvYFhvUVVA2PLdF37L8ZF6w8zQe?=
 =?us-ascii?Q?UExqARBb4DYANS0emmM9IeV97nwCMQc0asaSW9mO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257fa70c-08ee-4dc7-10f6-08ddd104fe8f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:09:13.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UBiYKvCXCuTCeenXeOQY4lKGXl6n91Rs78hwqDgYM2ntsmWlUlEaU6TQEtcha23QUDsKFxAWDCYUTmk7Tv/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686

On Fri, Aug 01, 2025 at 04:11:17PM +0800, Jacky Bai wrote:
> The TMU used on i.MX93 need some speccial handling and workaround to be
> done even the revision info read from the ID register is the same as
> Qoriq platform. Add i.MX93 compatible string and corresponding code for it.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  - v2 changes:
>   - use the compatible match data to identify the i.MX93 TMU variant
> ---
>  drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 01b58be0dcc6..fd4d162fc188 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  //
>  // Copyright 2016 Freescale Semiconductor, Inc.
> +// Copyright 2022-2025 NXP

should only claim 2025.

>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -24,9 +25,11 @@
>  #define TMTMIR_DEFAULT	0x0000000f
>  #define TIER_DISABLE	0x0
>  #define TEUMR0_V2		0x51009c00
> +#define TEUMR0_V21		0x55010c00
>  #define TMSARA_V2		0xe
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
> +#define TMU_VER93		0x3
>
>  #define REGS_TMR	0x000	/* Mode Register */
>  #define TMR_DISABLE	0x0
> @@ -232,6 +235,9 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>
>  	if (data->ver == TMU_VER1) {
>  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
> +	} else if (data->ver == TMU_VER93) {
> +		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
> +		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
>  	} else {
>  		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> @@ -312,12 +318,22 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> -	/* version register offset at: 0xbf8 on both v1 and v2 */
> -	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
> -	if (ret)
> -		return dev_err_probe(dev, ret,  "Failed to read IP block version\n");
> +	/*
> +	 * for i.MX93, the TMU HW version read from the ID register does
> +	 * reflect the real HW implementation version, assigned the TMU
> +	 * version statically.
> +	 */
> +	ver = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +	if (ver == TMU_VER93) {
> +		data->ver = ver;
> +	} else {
> +		/* version register offset at: 0xbf8 on both v1 and v2 */
> +		ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
> +		if (ret)
> +			return dev_err_probe(dev, ret,  "Failed to read IP block version\n");
>
> -	data->ver = (ver >> 8) & 0xff;
> +		data->ver = (ver >> 8) & 0xff;
> +	}
>
>  	qoriq_tmu_init_device(data);	/* TMU initialization */
>
> @@ -379,6 +395,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
>  static const struct of_device_id qoriq_tmu_match[] = {
>  	{ .compatible = "fsl,qoriq-tmu", },
>  	{ .compatible = "fsl,imx8mq-tmu", },
> +	{ .compatible = "fsl,imx93-tmu", .data = (void *) TMU_VER93 },

Now, don't prefer direct pass a ID here.

struct tmu_drv_data
{
	u32  temu0;  /* or other touch actual bits define, or workaround
			name, ticket number ... */
}

const struct tmu_drv_data imx93_data = {
	.temu0 = TEUMR0_V21;
}

Frank
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
> --
> 2.34.1
>

