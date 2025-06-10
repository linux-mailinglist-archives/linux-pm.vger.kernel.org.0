Return-Path: <linux-pm+bounces-28416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF9AD4412
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 22:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DFF177DBE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6497925DCEC;
	Tue, 10 Jun 2025 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9wFTW9q"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B123909F;
	Tue, 10 Jun 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588542; cv=fail; b=NMZXgSwLkq3ttJa+6CaLE0t7djI5ZZJf3R9UsPK6VPjrZs4Zkt2dCsYSF8lif3z4wtQoiJJA3rR6K+lrjGxDXfg/x+oWWIaB75re3yNMjStMyfwqxDGFHgrdu9GX7jMvLQ7aN363BmvJgNJcDPEvDk2HE+Y0qHE6ny4NIPK1cSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588542; c=relaxed/simple;
	bh=EKhehn5Qs/7SzU+glA5dBEnL42xDg4DWySFzljd2Ec4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YEUIhDCaBQvji3t4+rhRfx/GI3vs25p853h19ekpSAtkyG2tK7CGvlNioCSTpM6aGjjoK0fWj3dIOSer3Rl9Kq5dcptGA8nzJBSvMMWWwMHaPjT4yXB0DoVFwICsJbW3iUcPlKlhRTDzE8+tWMuQKphU+1KuQhENfXuGP/1fjhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A9wFTW9q; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgkxutX0r1bjSBbSJIcGyuefYrrxnCLlPdHdor81UyKIVsAHSQEhmc3CFhBggiU7c5YHoyc9nc3kvOZsa0+RTc+ukhRgyZjUYxVAgBowLlev5duwNinCPJLev9KHhPrc72cp3oBV4cykMmCQdelEQvkIsUSMM66BAOQ6jFKFAJPO7b+4FSYbJJYvJ9kI98dzkJgYwCB87EF3KdPzeFhDDIdQHwvEFgC0NtzS4jfR/CbictbCuIUnOkzXC7falySFcvmpd0lFU8hpkSvJWco+gGqOpKUog0+AiPbDGV7pG9rbJiyzjrwdXX2YuOFcLxumewxyEjlzP2rvMJYFKIT8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRZmYYDx355+0IU4GGFAO+/YinK42beXAGr9biRFGfo=;
 b=LjKt805jEg8W/ZGH+nFPQTae9DpK1lFdoPYw1Sk0dKtjXK6FCA27ZT5roFXrUUmPN5Y5OvNIKJh0gdf1ePhT515Is+6f6vSTPP0RGaGtfrzLdG3DbeWyWVenmgiUCAf4Wz3rM+j7EZny0xY8Z1tDlZlGgQLhcmtG8KdhqWSMlDmxKTDIbnwmwONlbdMIr1Syebh7yIhrll+LBSJ/EbwM0eCmMdnpGxwA1foGmchlCtmtrwLPMCj1X5UU7KTU7oXza20BkSVFDmP1mXCVRK9GPA0/mwbsIgtd03wh5WKOqG/o8SNsnGsa/wG9VwgxpAd8nxkzS//nHRa8EkpPZVZReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRZmYYDx355+0IU4GGFAO+/YinK42beXAGr9biRFGfo=;
 b=A9wFTW9qwUGX7TDrdixuEhzrJz3xMlu+orNXAbsVG31Mp3K9qJbgxNgjOkNoiAIgS5CA0rz8LpcddqRC9gU4diAxLwkcEE4AeMeqYbUQvDwRt8RCgU1+nrMLwj9NnIkrutBeV7Xw/h377gmOSkhn/bNK29M9GmUtz5IYPWYoQcI+yq04fNMyWL7cpLgrEBITi2BkZnroGsNqq72sPwq7sBuaYjWvybcHBDZO+gFPWaVbe4nxK4FsAWqmabHp8EbK7yMC7Gre+EBjOyXvZQjKk8lF2B3Dg6X3CwTglX5iOHMQWqSuvS9oLA2cGQpWiFsZsOZy6lY930TIKE6tVUWCRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV2PR04MB11400.eurprd04.prod.outlook.com (2603:10a6:150:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 20:48:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 20:48:53 +0000
Date: Tue, 10 Jun 2025 16:48:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v5 2/6] mfd: pf1550: add core mfd driver
Message-ID: <aEiaLATQV/kODnX7@lizhi-Precision-Tower-5810>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
 <20250610-pf1550-v5-2-ed0d9e3aaac7@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-pf1550-v5-2-ed0d9e3aaac7@savoirfairelinux.com>
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV2PR04MB11400:EE_
X-MS-Office365-Filtering-Correlation-Id: be128b25-9bbd-442f-9434-08dda8603615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OJjPNvpPm79nfExiI1pfHi2xMky/ujSROfvObvvHVR+h6DKLoaTGrPmqzF8Q?=
 =?us-ascii?Q?sVEGxgN6hpfLdlCnbeYqB8hjE07dSC+k3Oumj9B9N25YzuftxXe4kytP6cWp?=
 =?us-ascii?Q?J+EPYotGa/1Z1knzIlWivfSNsT/vRpCA0U9dJ0nA+Esk8FQiCkYEcV07Qq3K?=
 =?us-ascii?Q?2b3NPAe2t1C1GDbGd/p4lVFJ/rZXXzOB9bJWBs2dztCnURHYIoaiAi5T7Iuq?=
 =?us-ascii?Q?x+P8kFy1zV7P3efR+tBIkvTHPNk59Ramil+Dc5smfn0h7A6SIK4adXXkvTmx?=
 =?us-ascii?Q?BnhRYaKZHENGrkiJMPvyo/YSTOwZQD6TldY5qo0RNc41EwwCoQeQiRMTs+tq?=
 =?us-ascii?Q?dwQ5yENxKzjCLgnrCIHJG1FQ0yAs1raJPfSxEUaKAg+Z/VgWnbblnhpxBfeM?=
 =?us-ascii?Q?p7m7tbOUkF31ScEw9ieg9aDbt9frlccwdo/rvffNZhukM+UcdAbslAAu+KUi?=
 =?us-ascii?Q?s6lNbgfucRJuqd+8dYdpxmbh81UQz3xNmTr0XIffckSq5SlH2yjGrMUKZXEq?=
 =?us-ascii?Q?gdL88WneAPaNdYZDdrwrOBOYjNINSvt5OOVz3IUqJW15c/TZCl8+YZIkIwSd?=
 =?us-ascii?Q?OZ9DIo1Gzvx6lV9kTvEDH1R8eyKopJO/N+/RWa9nZk36GFXA1Zos5Wn1H9He?=
 =?us-ascii?Q?RRM7tkEQIuCbVeFebKR+usDthFUTV596x0sZfzeZFiA6SW7Brg79K5KDpCrX?=
 =?us-ascii?Q?1Oew98pakD2YPn9olsJPRCKVaDW0cyZaIVRbOnJSMJ8oJtG1VL7XLCzWyA0v?=
 =?us-ascii?Q?YjjBnm5zcPaJL5oTPLrzc4hqTo1HJyQi3Oco30MSmpcdha+iUyrmJCLTXS4U?=
 =?us-ascii?Q?P40IcV7Ehnb69/kRkF685tbjPG7iwBi1Y1fMuaNakFbIXpCieE/x72Xwtixz?=
 =?us-ascii?Q?ikQb8ymATifJIUHHnygzfgcwCdMCUyS40J+XaQRtRj6Wn4e6Ets+JuTEQKoT?=
 =?us-ascii?Q?KpPWJ1ukZCYsbioMRE8enEdeGISa6Lxs9C/R9x4c1ZhnsyL1pI8I0Yo7TlSA?=
 =?us-ascii?Q?zzENcWRetImW5VaiSrHxDXv/X5/RrYS3kGOwffocdd/PkdXL0MXLAxhMGbyI?=
 =?us-ascii?Q?8o4KUVy6CIdYedunyl/EzSQhPDtD9aGB2F8qFWTYf4IRmAcGITPohgwcnfUO?=
 =?us-ascii?Q?6cKbpLpLExG7R1+NW1k1EVwdyf/48tYQEi3RRm51MAox3nSWwoaE+PeAZCyC?=
 =?us-ascii?Q?s8EFwI4s+NxN6nnyXyFQYfLrXqzIlHK3o3fuLbONJt6v6V83H0Wk44csW73n?=
 =?us-ascii?Q?XLj4Hy2yJYNJy3W6u2npIo89odm1U9ooR46RwJWJPdNDoxlrasfYFeCuPqxx?=
 =?us-ascii?Q?IIWirbzDsCOJrJY5hlVaBOl5Zf8yOd1ZZLv8d66Ja2cfAdMhnf0tO3OTQSOm?=
 =?us-ascii?Q?6HkZMSDDGb9QMG7j0rKf8+96NXTnv/ZaFd4hMol8vPVJiFZtZcGhBSq1sBX4?=
 =?us-ascii?Q?Cltovq+RxCnjg/vz4rDPnHz0auoLDneGB+61zDalOU8heJvPDgwlFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BxX/ZZSmSM1imlp2U38Dw40o5LFL1d9WGS6FFt7OjgE5EuyrzCB/+lU1vbKw?=
 =?us-ascii?Q?75sLeoJlnDlvq4QxIF+2T6tPVGk0cHweiG5j5eaQDJK0yNAzeWGxeWL2Ih5Y?=
 =?us-ascii?Q?Mg4zTVMB04zfAgeeuYemEGseKX8nK2e8A5heFX+fNKuU0TxDlSYUVhcPhMbA?=
 =?us-ascii?Q?ap65xkmP/7hYFeZxjZm+yaNMzmij7Ih6BF2zy1sZsHkhOQB0OeRyrhk5abAg?=
 =?us-ascii?Q?SqIqT0Koyh0noLRBMLsj/7bdBy9wzLzIa9anFGDNVWVNbhPo9cwc+YajbAGb?=
 =?us-ascii?Q?mVDPpe7TmOjlMT9ZuIzdGL5E1oo7X2ZXGFqSH6bFtDBoFtQtMSMSk+erdYzF?=
 =?us-ascii?Q?bfIF4lEDs/8g/TAFHJqpReO6/i9xWiblrj08iUVhVYZ8dtsHTAsRBATlTUpO?=
 =?us-ascii?Q?B4t7rcHGOGjoBP95MZFSe8h9Tb/uMN8iuUxtC/TY08yyvI/88BO8S7n/rfKc?=
 =?us-ascii?Q?5n1WWxojDyM1ZFdo3/QVXJpXQznuPqc3EpUF/3UHBscvdI3UbJqGhmOA3aIU?=
 =?us-ascii?Q?f5C0mvXZORVxXd8DLVlgdAslYZJNtO+tgedwVJaC33wEOxd/FSmMECYKigIc?=
 =?us-ascii?Q?aMtIN54Cblt6lBctwt8p8Pjnb0mUnGwGjvlwxdUNz8OG0RI2OQiPPDG2YWRf?=
 =?us-ascii?Q?yv7Aqdr+o22bJ8LQ3Ac+jRGNtQ1hezqf+qsiUEb8DJ5+Pd3LS2OZ2FoUd+kB?=
 =?us-ascii?Q?OTlaqqVgPez3K0yiw8X8d8wgtK3sZqiu5eh5ij1oO8MUVOAEEX/5Wsn7ksyp?=
 =?us-ascii?Q?yCnlsni4npdtPBpod3ijGAtZKfOvvbmJp2LC81f1v1O/80BkOL/GHuhf0c9i?=
 =?us-ascii?Q?8hagMLe2q9nhqvIxEdHIVKlpd0UPiH3YOdCkO5F5XyMOZjE2goqyJB0z84Yb?=
 =?us-ascii?Q?6bFso8tcIQv9CyIW/wVn4Zy4huX8MFjgt1cDHq98CG9a8cJosqsrJ+f712KA?=
 =?us-ascii?Q?vm20ANC1AuBmx+CPPokUQ+muXYN8Nans23xQZiHzVYcRYiJgeElKSkLYYiWm?=
 =?us-ascii?Q?X6GdT1XyRnqrEaIe8bGZ+J/1sCQiSLkQGmAYP3CMy6ZCUU4BllLP3Ep32bBy?=
 =?us-ascii?Q?BzJIxqs4M/GvelxuRliLLdrkOigwdOUoALOI/xR63L1mE/WtIDSp/mpyjVhy?=
 =?us-ascii?Q?V5pTaMcnaHqha2K15GpHWb/skdzmSkteukn0YZVU3ecgF4CxsAXg0W73qyCy?=
 =?us-ascii?Q?/LjB1KU1z5teMGKgtLAkWn2BL9eoIKig/y+heiWsXGkm+rpIZwv2/FfXn0Tw?=
 =?us-ascii?Q?iNBoxqO6/AOZV0iYhwlJB62epLUHoGOvNwWUY4pTSB/z/ImHUWSJnY0Tbr4O?=
 =?us-ascii?Q?pO0DSHrTVs/OFJhzi4boRL+kixRyIp8Q5SXcXnrhb7nN3GWrMwZx9v+vSqYT?=
 =?us-ascii?Q?hzXr2y+G5ipb6Ps0OlD+F5+LkDWtA98e1lOMsWrtD5sB4jHhjcfi1eustHyQ?=
 =?us-ascii?Q?nxIG5TMS1W/yz8kJYv7wXYrkYYXxkU9dhvvf5s9kQuJV+ssKsO41mgsr28Wu?=
 =?us-ascii?Q?ovDGbWCMhoJM5oLdMc8+JHOWyMb80Py9R9GLLcrHispWX9yNB8Rkd52yYpJV?=
 =?us-ascii?Q?G6ePzUCL+MGODVzdInfDbNYCCImx3Z2Zls1GWH1t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be128b25-9bbd-442f-9434-08dda8603615
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:48:53.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n9V6dbQSiurofzwyFx2lhwx5cdtxSGYia45BYCVhxQDuzum7MDx4EWSbvDyakls3o+PkSSY8Tj7gCKBoG4mfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11400

On Tue, Jun 10, 2025 at 03:47:30PM -0400, Samuel Kayode wrote:
> Add the core mfd driver for pf1550 PMIC. There are 3 subdevices for
> which the drivers will be added in subsequent patches.
>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v5:
>  - Use top level interrupt to manage interrupts for the sub-drivers as
>    recommended by Mark Brown. The regmap_irq_sub_irq_map would have been used
>    if not for the irregular charger irq address. For all children, the mask
>    register is directly after the irq register (i.e., 0x08, 0x09) except
>    for the charger: 0x80, 0x82. Meaning .mask_base would be applicable
>    for all but the charger
>  - Fix bad offset for temperature interrupts of regulator
> v4:
>  - Use struct resource to define irq so platform_get_irq can be used in
>    children as suggested by Dmitry
>  - Let mfd_add_devices create the mappings for the interrupts
>  - ack_base and init_ack_masked defined for charger and regulator irq
>    chips
>  - No need to define driver_data in table id
> v3:
>  - Address Dmitry's feedback:
>    - Place Table IDs next to each other
>    - Drop of_match_ptr
>    - Replace dev_err with dev_err_probe in probe method
>    - Drop useless log in probe
>  - Map all irqs instead of doing it in the sub-devices as recommended by
>    Dmitry.
> v2:
>  - Address feedback from Enric Balletbo Serra
> ---
>  drivers/mfd/Kconfig        |  14 ++
>  drivers/mfd/Makefile       |   2 +
>  drivers/mfd/pf1550.c       | 335 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/pf1550.h | 259 +++++++++++++++++++++++++++++++++++
>  4 files changed, 610 insertions(+)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 96992af22565205716d72db0494c7bf2567b045e..de3fc9c5e88b5c2a2c7325e2ceeb8f9c3ca057de 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -558,6 +558,20 @@ config MFD_MX25_TSADC
>  	  i.MX25 processors. They consist of a conversion queue for general
>  	  purpose ADC and a queue for Touchscreens.
>
> +config MFD_PF1550
> +	tristate "NXP PF1550 PMIC Support"
> +	depends on I2C=y && OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Say yes here to add support for NXP PF1550.
> +	  This is a companion Power Management IC with regulators, onkey,
> +	  and charger control on chip.
> +	  This driver provides common support for accessing the device;
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_HI6421_PMIC
>  	tristate "HiSilicon Hi6421 PMU/Codec IC"
>  	depends on OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5e5cc279af6036a6b3ea1f1f0feeddf45b85f15c..7391d1b81d1ee499507b4ac24ff00eb2e344d60b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -120,6 +120,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
>
> +obj-$(CONFIG_MFD_PF1550)	+= pf1550.o
> +
>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
>
>  ocelot-soc-objs			:= ocelot-core.o ocelot-spi.o
> diff --git a/drivers/mfd/pf1550.c b/drivers/mfd/pf1550.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6fdbfd179525c70f620348002f3d545de879f1a3
> --- /dev/null
> +++ b/drivers/mfd/pf1550.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// pf1550.c - mfd core driver for the PF1550
> +//
> +// Copyright (C) 2016 Freescale Semiconductor, Inc.
> +// Robin Gong <yibin.gong@freescale.com>
> +//
> +// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> +// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +//
> +// This driver is based on max77693.c
> +//
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_config pf1550_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = PF1550_PMIC_REG_END,
> +};
> +
> +static const struct regmap_irq pf1550_irqs[] = {
> +	REGMAP_IRQ_REG(PF1550_IRQ_CHG,		 0, IRQ_CHG),
> +	REGMAP_IRQ_REG(PF1550_IRQ_REGULATOR,     0, IRQ_REGULATOR),
> +	REGMAP_IRQ_REG(PF1550_IRQ_ONKEY,	 0, IRQ_ONKEY),
> +};
> +
> +static const struct regmap_irq_chip pf1550_irq_chip = {
> +	.name			= "pf1550",
> +	.status_base		= PF1550_PMIC_REG_INT_CATEGORY,
> +	.init_ack_masked	= 1,
> +	.num_regs		= 1,
> +	.irqs			= pf1550_irqs,
> +	.num_irqs		= ARRAY_SIZE(pf1550_irqs),
> +};
> +
> +static const struct regmap_irq pf1550_regulator_irqs[] = {
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_LS,         0, PMIC_IRQ_SW1_LS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_LS,         0, PMIC_IRQ_SW2_LS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_LS,         0, PMIC_IRQ_SW3_LS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_HS,         3, PMIC_IRQ_SW1_HS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_HS,         3, PMIC_IRQ_SW2_HS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_HS,         3, PMIC_IRQ_SW3_HS),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO1_FAULT,    16, PMIC_IRQ_LDO1_FAULT),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO2_FAULT,    16, PMIC_IRQ_LDO2_FAULT),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO3_FAULT,    16, PMIC_IRQ_LDO3_FAULT),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_110,      24, PMIC_IRQ_TEMP_110),
> +	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_125,      24, PMIC_IRQ_TEMP_125),
> +};
> +
> +static const struct regmap_irq_chip pf1550_regulator_irq_chip = {
> +	.name			= "pf1550-regulator",
> +	.status_base		= PF1550_PMIC_REG_SW_INT_STAT0,
> +	.ack_base		= PF1550_PMIC_REG_SW_INT_STAT0,
> +	.mask_base		= PF1550_PMIC_REG_SW_INT_MASK0,
> +	.use_ack                = 1,
> +	.init_ack_masked	= 1,
> +	.num_regs		= 25,
> +	.irqs			= pf1550_regulator_irqs,
> +	.num_irqs		= ARRAY_SIZE(pf1550_regulator_irqs),
> +};
> +
> +static const struct resource regulator_resources[] = {
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW1_LS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW2_LS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW3_LS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW1_HS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW2_HS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW3_HS),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO1_FAULT),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO2_FAULT),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO3_FAULT),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_TEMP_110),
> +	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_TEMP_125),
> +};
> +
> +static const struct regmap_irq pf1550_onkey_irqs[] = {
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_PUSHI,  0, ONKEY_IRQ_PUSHI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_1SI,    0, ONKEY_IRQ_1SI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_2SI,    0, ONKEY_IRQ_2SI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_3SI,    0, ONKEY_IRQ_3SI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_4SI,    0, ONKEY_IRQ_4SI),
> +	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_8SI,    0, ONKEY_IRQ_8SI),
> +};
> +
> +static const struct regmap_irq_chip pf1550_onkey_irq_chip = {
> +	.name			= "pf1550-onkey",
> +	.status_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
> +	.ack_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
> +	.mask_base		= PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +	.use_ack                = 1,
> +	.init_ack_masked	= 1,
> +	.num_regs		= 1,
> +	.irqs			= pf1550_onkey_irqs,
> +	.num_irqs		= ARRAY_SIZE(pf1550_onkey_irqs),
> +};
> +
> +static const struct resource onkey_resources[] = {
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_PUSHI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_1SI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_2SI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_3SI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_4SI),
> +	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_8SI),
> +};
> +
> +static const struct regmap_irq pf1550_charger_irqs[] = {
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BAT2SOCI,	0, CHARG_IRQ_BAT2SOCI),
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BATI,           0, CHARG_IRQ_BATI),
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_CHGI,           0, CHARG_IRQ_CHGI),
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_VBUSI,          0, CHARG_IRQ_VBUSI),
> +	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_THMI,           0, CHARG_IRQ_THMI),
> +};
> +
> +static const struct regmap_irq_chip pf1550_charger_irq_chip = {
> +	.name			= "pf1550-charger",
> +	.status_base		= PF1550_CHARG_REG_CHG_INT,
> +	.ack_base		= PF1550_CHARG_REG_CHG_INT,
> +	.mask_base		= PF1550_CHARG_REG_CHG_INT_MASK,
> +	.use_ack                = 1,
> +	.init_ack_masked	= 1,
> +	.num_regs		= 1,
> +	.irqs			= pf1550_charger_irqs,
> +	.num_irqs		= ARRAY_SIZE(pf1550_charger_irqs),
> +};
> +
> +static const struct resource charger_resources[] = {
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_BAT2SOCI),
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_BATI),
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_CHGI),
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_VBUSI),
> +	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_THMI),
> +};
> +
> +static const struct mfd_cell pf1550_regulator_cell = {
> +	.name = "pf1550-regulator",
> +	.num_resources = ARRAY_SIZE(regulator_resources),
> +	.resources = regulator_resources,
> +};
> +
> +static const struct mfd_cell pf1550_onkey_cell = {
> +	.name = "pf1550-onkey",
> +	.num_resources = ARRAY_SIZE(onkey_resources),
> +	.resources = onkey_resources,
> +};
> +
> +static const struct mfd_cell pf1550_charger_cell = {
> +	.name = "pf1550-charger",
> +	.num_resources = ARRAY_SIZE(charger_resources),
> +	.resources = charger_resources,
> +};
> +
> +int pf1550_read_otp(const struct pf1550_dev *pf1550, unsigned int index,
> +		    unsigned int *val)
> +{
> +	int ret = 0;
> +
> +	ret = regmap_write(pf1550->regmap, PF1550_PMIC_REG_KEY, 0x15);
> +	if (ret)
> +		goto read_err;
> +	ret = regmap_write(pf1550->regmap, PF1550_CHARG_REG_CHGR_KEY2, 0x50);
> +	if (ret)
> +		goto read_err;
> +	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_KEY3, 0xAB);
> +	if (ret)
> +		goto read_err;
> +	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_FMRADDR, index);
> +	if (ret)
> +		goto read_err;
> +	ret = regmap_read(pf1550->regmap, PF1550_TEST_REG_FMRDATA, val);
> +	if (ret)
> +		goto read_err;
> +
> +	return 0;
> +
> +read_err:
> +	dev_err(pf1550->dev, "read otp reg %x found!\n", index);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pf1550_read_otp);
> +
> +static int pf1550_add_child_device(struct pf1550_dev *pmic,
> +				   const struct mfd_cell *cell,
> +				   struct regmap_irq_chip_data *pdata,
> +				   int pirq, int irq_flags,
> +				   const struct regmap_irq_chip *chip,
> +				   struct regmap_irq_chip_data **data)
> +{
> +	struct device *dev = pmic->dev;
> +	struct irq_domain *domain;
> +	int irq, ret;
> +
> +	irq = regmap_irq_get_virq(pdata, pirq);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq,
> +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> +				     pirq, chip->name);
> +
> +	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, irq,
> +				       irq_flags, 0, chip, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add %s IRQ chip\n",
> +				     chip->name);
> +
> +	domain = regmap_irq_get_domain(*data);
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cell, 1,
> +				    NULL, 0, domain);
> +}
> +
> +static int pf1550_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct pf1550_dev *pf1550;
> +	const struct mfd_cell *regulator = &pf1550_regulator_cell;
> +	const struct mfd_cell *onkey = &pf1550_onkey_cell;
> +	const struct mfd_cell *charger = &pf1550_charger_cell;
> +	unsigned int reg_data = 0;
> +	int ret = 0;
> +
> +	pf1550 = devm_kzalloc(&i2c->dev, sizeof(*pf1550), GFP_KERNEL);
> +	if (!pf1550)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, pf1550);
> +	pf1550->dev = &i2c->dev;
> +	pf1550->i2c = i2c;
> +	pf1550->irq = i2c->irq;
> +
> +	pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
> +	if (IS_ERR(pf1550->regmap))
> +		return dev_err_probe(pf1550->dev, PTR_ERR(pf1550->regmap),
> +				     "failed to allocate register map\n");
> +
> +	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
> +	if (ret < 0 || reg_data != PF1550_DEVICE_ID)
> +		return dev_err_probe(pf1550->dev, ret ?: -EINVAL,
> +				     "device not found!\n");
> +
> +	pf1550->type = PF1550;
> +
> +	/* add top level interrupts */
> +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, pf1550->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED |
> +				       IRQF_TRIGGER_FALLING,
> +				       0, &pf1550_irq_chip,
> +				       &pf1550->irq_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_add_child_device(pf1550, regulator, pf1550->irq_data,
> +				      PF1550_IRQ_REGULATOR, IRQF_ONESHOT |
> +				      IRQF_SHARED | IRQF_TRIGGER_FALLING,
> +				      &pf1550_regulator_irq_chip,
> +				      &pf1550->irq_data_regulator);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_add_child_device(pf1550, onkey, pf1550->irq_data,
> +				      PF1550_IRQ_ONKEY, IRQF_ONESHOT |
> +				      IRQF_SHARED | IRQF_TRIGGER_FALLING,
> +				      &pf1550_onkey_irq_chip,
> +				      &pf1550->irq_data_onkey);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_add_child_device(pf1550, charger, pf1550->irq_data,
> +				      PF1550_IRQ_CHG, IRQF_ONESHOT |
> +				      IRQF_SHARED | IRQF_TRIGGER_FALLING,

all irq_flags is IRQF_ONESHOT | IRQF_SHARED  | IRQF_TRIGGER_FALLING,

you can hardcode in pf1550_add_child_device.

> +				      &pf1550_charger_irq_chip,
> +				      &pf1550->irq_data_charger);
> +	return ret;
> +}
> +
> +static int pf1550_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(pf1550->irq);
> +		disable_irq(pf1550->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev)) {
> +		disable_irq_wake(pf1550->irq);
> +		enable_irq(pf1550->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(pf1550_pm, pf1550_suspend, pf1550_resume);
> +
> +static const struct i2c_device_id pf1550_i2c_id[] = {
> +	{ "pf1550", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
> +
> +static const struct of_device_id pf1550_dt_match[] = {
> +	{ .compatible = "nxp,pf1550" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, pf1550_dt_match);
> +
> +static struct i2c_driver pf1550_i2c_driver = {
> +	.driver = {
> +		   .name = "pf1550",
> +		   .pm = pm_sleep_ptr(&pf1550_pm),
> +		   .of_match_table = pf1550_dt_match,
> +	},
> +	.probe = pf1550_i2c_probe,
> +	.id_table = pf1550_i2c_id,
> +};
> +module_i2c_driver(pf1550_i2c_driver);
> +
> +MODULE_DESCRIPTION("NXP PF1550 multi-function core driver");
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/pf1550.h b/include/linux/mfd/pf1550.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..0fdf29a1538c080ffdd582e92c5fa811a605cc6e
> --- /dev/null
> +++ b/include/linux/mfd/pf1550.h
> @@ -0,0 +1,259 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * pf1550.h - mfd head file for PF1550
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Robin Gong <yibin.gong@freescale.com>
> + *
> + * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> + * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> + */
> +
> +#ifndef __LINUX_MFD_PF1550_H
> +#define __LINUX_MFD_PF1550_H
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +enum chips { PF1550 = 1, };

Did you really use this?

> +
> +enum pf1550_pmic_reg {
> +	/* PMIC regulator part */
> +	PF1550_PMIC_REG_DEVICE_ID		= 0x00,
> +	PF1550_PMIC_REG_OTP_FLAVOR		= 0x01,
> +	PF1550_PMIC_REG_SILICON_REV		= 0x02,
> +
> +	PF1550_PMIC_REG_INT_CATEGORY		= 0x06,
> +	PF1550_PMIC_REG_SW_INT_STAT0		= 0x08,
> +	PF1550_PMIC_REG_SW_INT_MASK0		= 0x09,
> +	PF1550_PMIC_REG_SW_INT_SENSE0		= 0x0A,
> +	PF1550_PMIC_REG_SW_INT_STAT1		= 0x0B,
> +	PF1550_PMIC_REG_SW_INT_MASK1		= 0x0C,
> +	PF1550_PMIC_REG_SW_INT_SENSE1		= 0x0D,
> +	PF1550_PMIC_REG_SW_INT_STAT2		= 0x0E,
> +	PF1550_PMIC_REG_SW_INT_MASK2		= 0x0F,
> +	PF1550_PMIC_REG_SW_INT_SENSE2		= 0x10,
> +	PF1550_PMIC_REG_LDO_INT_STAT0		= 0x18,
> +	PF1550_PMIC_REG_LDO_INT_MASK0		= 0x19,
> +	PF1550_PMIC_REG_LDO_INT_SENSE0		= 0x1A,
> +	PF1550_PMIC_REG_TEMP_INT_STAT0		= 0x20,
> +	PF1550_PMIC_REG_TEMP_INT_MASK0		= 0x21,
> +	PF1550_PMIC_REG_TEMP_INT_SENSE0		= 0x22,
> +	PF1550_PMIC_REG_ONKEY_INT_STAT0		= 0x24,
> +	PF1550_PMIC_REG_ONKEY_INT_MASK0		= 0x25,
> +	PF1550_PMIC_REG_ONKEY_INT_SENSE0	= 0x26,
> +	PF1550_PMIC_REG_MISC_INT_STAT0		= 0x28,
> +	PF1550_PMIC_REG_MISC_INT_MASK0		= 0x29,
> +	PF1550_PMIC_REG_MISC_INT_SENSE0		= 0x2A,
> +
> +	PF1550_PMIC_REG_COINCELL_CONTROL	= 0x30,
> +
> +	PF1550_PMIC_REG_SW1_VOLT		= 0x32,
> +	PF1550_PMIC_REG_SW1_STBY_VOLT		= 0x33,
> +	PF1550_PMIC_REG_SW1_SLP_VOLT		= 0x34,
> +	PF1550_PMIC_REG_SW1_CTRL		= 0x35,
> +	PF1550_PMIC_REG_SW1_CTRL1		= 0x36,
> +	PF1550_PMIC_REG_SW2_VOLT		= 0x38,
> +	PF1550_PMIC_REG_SW2_STBY_VOLT		= 0x39,
> +	PF1550_PMIC_REG_SW2_SLP_VOLT		= 0x3A,
> +	PF1550_PMIC_REG_SW2_CTRL		= 0x3B,
> +	PF1550_PMIC_REG_SW2_CTRL1		= 0x3C,
> +	PF1550_PMIC_REG_SW3_VOLT		= 0x3E,
> +	PF1550_PMIC_REG_SW3_STBY_VOLT		= 0x3F,
> +	PF1550_PMIC_REG_SW3_SLP_VOLT		= 0x40,
> +	PF1550_PMIC_REG_SW3_CTRL		= 0x41,
> +	PF1550_PMIC_REG_SW3_CTRL1		= 0x42,
> +	PF1550_PMIC_REG_VSNVS_CTRL		= 0x48,
> +	PF1550_PMIC_REG_VREFDDR_CTRL		= 0x4A,
> +	PF1550_PMIC_REG_LDO1_VOLT		= 0x4C,
> +	PF1550_PMIC_REG_LDO1_CTRL		= 0x4D,
> +	PF1550_PMIC_REG_LDO2_VOLT		= 0x4F,
> +	PF1550_PMIC_REG_LDO2_CTRL		= 0x50,
> +	PF1550_PMIC_REG_LDO3_VOLT		= 0x52,
> +	PF1550_PMIC_REG_LDO3_CTRL		= 0x53,
> +	PF1550_PMIC_REG_PWRCTRL0		= 0x58,
> +	PF1550_PMIC_REG_PWRCTRL1		= 0x59,
> +	PF1550_PMIC_REG_PWRCTRL2		= 0x5A,
> +	PF1550_PMIC_REG_PWRCTRL3		= 0x5B,
> +	PF1550_PMIC_REG_SW1_PWRDN_SEQ		= 0x5F,
> +	PF1550_PMIC_REG_SW2_PWRDN_SEQ		= 0x60,
> +	PF1550_PMIC_REG_SW3_PWRDN_SEQ		= 0x61,
> +	PF1550_PMIC_REG_LDO1_PWRDN_SEQ		= 0x62,
> +	PF1550_PMIC_REG_LDO2_PWRDN_SEQ		= 0x63,
> +	PF1550_PMIC_REG_LDO3_PWRDN_SEQ		= 0x64,
> +	PF1550_PMIC_REG_VREFDDR_PWRDN_SEQ	= 0x65,
> +
> +	PF1550_PMIC_REG_STATE_INFO		= 0x67,
> +	PF1550_PMIC_REG_I2C_ADDR		= 0x68,
> +	PF1550_PMIC_REG_IO_DRV0			= 0x69,
> +	PF1550_PMIC_REG_IO_DRV1			= 0x6A,
> +	PF1550_PMIC_REG_RC_16MHZ		= 0x6B,
> +	PF1550_PMIC_REG_KEY			= 0x6F,
> +
> +	/* charger part */
> +	PF1550_CHARG_REG_CHG_INT		= 0x80,
> +	PF1550_CHARG_REG_CHG_INT_MASK		= 0x82,
> +	PF1550_CHARG_REG_CHG_INT_OK		= 0x84,
> +	PF1550_CHARG_REG_VBUS_SNS		= 0x86,
> +	PF1550_CHARG_REG_CHG_SNS		= 0x87,
> +	PF1550_CHARG_REG_BATT_SNS		= 0x88,
> +	PF1550_CHARG_REG_CHG_OPER		= 0x89,
> +	PF1550_CHARG_REG_CHG_TMR		= 0x8A,
> +	PF1550_CHARG_REG_CHG_EOC_CNFG		= 0x8D,
> +	PF1550_CHARG_REG_CHG_CURR_CNFG		= 0x8E,
> +	PF1550_CHARG_REG_BATT_REG		= 0x8F,
> +	PF1550_CHARG_REG_BATFET_CNFG		= 0x91,
> +	PF1550_CHARG_REG_THM_REG_CNFG		= 0x92,
> +	PF1550_CHARG_REG_VBUS_INLIM_CNFG	= 0x94,
> +	PF1550_CHARG_REG_VBUS_LIN_DPM		= 0x95,
> +	PF1550_CHARG_REG_USB_PHY_LDO_CNFG	= 0x96,
> +	PF1550_CHARG_REG_DBNC_DELAY_TIME	= 0x98,
> +	PF1550_CHARG_REG_CHG_INT_CNFG		= 0x99,
> +	PF1550_CHARG_REG_THM_ADJ_SETTING	= 0x9A,
> +	PF1550_CHARG_REG_VBUS2SYS_CNFG		= 0x9B,
> +	PF1550_CHARG_REG_LED_PWM		= 0x9C,
> +	PF1550_CHARG_REG_FAULT_BATFET_CNFG	= 0x9D,
> +	PF1550_CHARG_REG_LED_CNFG		= 0x9E,
> +	PF1550_CHARG_REG_CHGR_KEY2		= 0x9F,
> +
> +	PF1550_TEST_REG_FMRADDR			= 0xC4,
> +	PF1550_TEST_REG_FMRDATA			= 0xC5,
> +	PF1550_TEST_REG_KEY3			= 0xDF,
> +
> +	PF1550_PMIC_REG_END			= 0xff,

can you keep consisent by use low case hex value?

> +};
> +
> +#define PF1550_DEVICE_ID		0x7c
> +
> +#define PF1550_CHG_TURNON		0x2
> +
> +#define PF1550_CHG_PRECHARGE		0
> +#define PF1550_CHG_CONSTANT_CURRENT	1
> +#define PF1550_CHG_CONSTANT_VOL		2
> +#define PF1550_CHG_EOC			3
> +#define PF1550_CHG_DONE			4
> +#define PF1550_CHG_TIMER_FAULT		6
> +#define PF1550_CHG_SUSPEND		7
> +#define PF1550_CHG_OFF_INV		8
> +#define PF1550_CHG_BAT_OVER		9
> +#define PF1550_CHG_OFF_TEMP		10
> +#define PF1550_CHG_LINEAR_ONLY		12
> +#define PF1550_CHG_SNS_MASK		0xf
> +#define PF1550_CHG_INT_MASK             0x51
> +
> +#define PF1550_BAT_NO_VBUS		0
> +#define PF1550_BAT_LOW_THAN_PRECHARG	1
> +#define PF1550_BAT_CHARG_FAIL		2
> +#define PF1550_BAT_HIGH_THAN_PRECHARG	4
> +#define PF1550_BAT_OVER_VOL		5
> +#define	PF1550_BAT_NO_DETECT		6
> +#define PF1550_BAT_SNS_MASK		0x7
> +
> +#define PF1550_VBUS_UVLO		BIT(2)
> +#define PF1550_VBUS_IN2SYS		BIT(3)
> +#define PF1550_VBUS_OVLO		BIT(4)
> +#define PF1550_VBUS_VALID		BIT(5)
> +
> +#define PF1550_CHARG_REG_BATT_REG_CHGCV_MASK		0x3f
> +#define PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT		6
> +#define PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK		(0x3 << 6)

use GEN_MASK macro

> +#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT	2
> +#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK	(0x3 << 2)

use GEN_MASK macro

Frank
> +
> +/* top level interrupt masks */
> +#define IRQ_REGULATOR		(BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(6))
> +#define IRQ_ONKEY		BIT(5)
> +#define IRQ_CHG			BIT(0)
> +
> +/* regulator interrupt masks */
> +#define PMIC_IRQ_SW1_LS		BIT(0)
> +#define PMIC_IRQ_SW2_LS		BIT(1)
> +#define PMIC_IRQ_SW3_LS		BIT(2)
> +#define PMIC_IRQ_SW1_HS		BIT(0)
> +#define PMIC_IRQ_SW2_HS		BIT(1)
> +#define PMIC_IRQ_SW3_HS		BIT(2)
> +#define PMIC_IRQ_LDO1_FAULT	BIT(0)
> +#define PMIC_IRQ_LDO2_FAULT	BIT(1)
> +#define PMIC_IRQ_LDO3_FAULT	BIT(2)
> +#define PMIC_IRQ_TEMP_110	BIT(0)
> +#define PMIC_IRQ_TEMP_125	BIT(1)
> +
> +/* onkey interrupt masks */
> +#define ONKEY_IRQ_PUSHI		BIT(0)
> +#define ONKEY_IRQ_1SI		BIT(1)
> +#define ONKEY_IRQ_2SI		BIT(2)
> +#define ONKEY_IRQ_3SI		BIT(3)
> +#define ONKEY_IRQ_4SI		BIT(4)
> +#define ONKEY_IRQ_8SI		BIT(5)
> +
> +/* charger interrupt masks */
> +#define CHARG_IRQ_BAT2SOCI	BIT(1)
> +#define CHARG_IRQ_BATI		BIT(2)
> +#define CHARG_IRQ_CHGI		BIT(3)
> +#define CHARG_IRQ_VBUSI		BIT(5)
> +#define CHARG_IRQ_DPMI		BIT(6)
> +#define CHARG_IRQ_THMI		BIT(7)
> +
> +enum pf1550_irq {
> +	PF1550_IRQ_CHG,
> +	PF1550_IRQ_REGULATOR,
> +	PF1550_IRQ_ONKEY,
> +};
> +
> +enum pf1550_pmic_irq {
> +	PF1550_PMIC_IRQ_SW1_LS,
> +	PF1550_PMIC_IRQ_SW2_LS,
> +	PF1550_PMIC_IRQ_SW3_LS,
> +	PF1550_PMIC_IRQ_SW1_HS,
> +	PF1550_PMIC_IRQ_SW2_HS,
> +	PF1550_PMIC_IRQ_SW3_HS,
> +	PF1550_PMIC_IRQ_LDO1_FAULT,
> +	PF1550_PMIC_IRQ_LDO2_FAULT,
> +	PF1550_PMIC_IRQ_LDO3_FAULT,
> +	PF1550_PMIC_IRQ_TEMP_110,
> +	PF1550_PMIC_IRQ_TEMP_125,
> +};
> +
> +enum pf1550_onkey_irq {
> +	PF1550_ONKEY_IRQ_PUSHI,
> +	PF1550_ONKEY_IRQ_1SI,
> +	PF1550_ONKEY_IRQ_2SI,
> +	PF1550_ONKEY_IRQ_3SI,
> +	PF1550_ONKEY_IRQ_4SI,
> +	PF1550_ONKEY_IRQ_8SI,
> +};
> +
> +enum pf1550_charg_irq {
> +	PF1550_CHARG_IRQ_BAT2SOCI,
> +	PF1550_CHARG_IRQ_BATI,
> +	PF1550_CHARG_IRQ_CHGI,
> +	PF1550_CHARG_IRQ_VBUSI,
> +	PF1550_CHARG_IRQ_THMI,
> +};
> +
> +enum pf1550_regulators {
> +	PF1550_SW1,
> +	PF1550_SW2,
> +	PF1550_SW3,
> +	PF1550_VREFDDR,
> +	PF1550_LDO1,
> +	PF1550_LDO2,
> +	PF1550_LDO3,
> +};
> +
> +struct pf1550_dev {
> +	struct device *dev;
> +	struct i2c_client *i2c;
> +	int type;
> +	struct regmap *regmap;
> +	struct regmap_irq_chip_data *irq_data_regulator;
> +	struct regmap_irq_chip_data *irq_data_onkey;
> +	struct regmap_irq_chip_data *irq_data_charger;
> +	struct regmap_irq_chip_data *irq_data;
> +	int irq;
> +};
> +
> +int pf1550_read_otp(const struct pf1550_dev *pf1550, unsigned int index,
> +		    unsigned int *val);
> +
> +#endif /* __LINUX_MFD_PF1550_H */
>
> --
> 2.49.0
>

