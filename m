Return-Path: <linux-pm+bounces-33620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1504B3F950
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E821A83B8F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB52E9742;
	Tue,  2 Sep 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GYXUs4GO"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F4219E0;
	Tue,  2 Sep 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803602; cv=fail; b=LrZOKgqW4G9BF/g3A//WWOnMFuyzfmVLyjOWUCT6qXkkOXsEdAvN10YooRtj9jQaDP/et7jMLCbfeR4S1Qtt0QePnzHEO7aRHYr7fwRoiNY+tXN/JGmUTpNKu2Pf8/XCdZvmLJDyXZem+7APU+mA/Rk3AGnExVbRCGyUFLxUalE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803602; c=relaxed/simple;
	bh=8ckE4swazCDIT54bg4RClazL7bGq1KQZ/TiSJnBHtkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ta2b2Vv5lfIjD8pM3vHlWfMBvFQ58u1FTa6uQCPgUOzMrGfPg812szYdAK2nj1ywj7Btkl117nViDs2yp909ns24IXkOE6eOwFihTykT2iowAECVfyaaERg1YO66W5F7VzDCwcM+Y9rUVV9bshhLq5KAbiIJ4m3SafIn5hK7mhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GYXUs4GO; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c456tJHH95GBMkgEoWjYnOcIe7w1w//7csxLZLeJNcPDxaTGKq8AfOHdPFBLpDgDEQuhVJA1CG03kTMGYim68i0kihLB0lxuco6CQmkTR3LnZ1w1rVTkK9El5yie+eg/G/PkYt3vA3HDu8UjSSVGlJLy3msNRLI14FlEsGMF+WOYwwLORcj8cAbQ4mkf2Oh2b+AhJqfzYfzKzMGhLns4T3fZeoFTcNvlLagN5pA+/EWMY0gvdnjEKR5BCIfFxPWDh+JO4zFszUFryTFr2goERNMp5IKm7SiaaId2B9Nv2/o8lCT398QtwWvKauDSj28/jyAShjKE6zgXXzOIoOxegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IED88uB/iRAtqKk3ThORp0qiw1dgm9yqxh9yumVfLxg=;
 b=A/3za58u6QQHuk6L/SQFDpYRQ97juxASRbdUVCOVe2xRC6Si9/BOE4sna8nw6ljIarLb5By/Lv3uSthUu3jAjWyobwLIoyM5sdxBmigFUzfezenP2GaSuRTbhkFuE3IY1pQarez4eiENt5aVGgEbnULgalc9sBpSje0S2QhkzCmVb+7t3E4Lnz4Z0W2R98jIAQDYZH+a1SKwHnpiEsKJmlDJ6oqoiN9zuo1UEV7ucGq2ystGgn8bEKBLbJ1CQrnhLzdQp1yHAMMdIr9N7jfW1fQy9izZ1IDrdv8HuoJfGvTuUBSVvVXHcn1EuoSPBBH/ZN7wED6JvToG5R5MPZWfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IED88uB/iRAtqKk3ThORp0qiw1dgm9yqxh9yumVfLxg=;
 b=GYXUs4GOAoq/Igr56eDqRlh26JNPTLG8ZIK1a4jcf8yFEH9ZT2gpyxj2uIsIu///ARN8DJ3AR7QSDh9laCo56bVmoKta6Uq4BOsepVVK9uPk9Kl6lEYtzxPbLITNAxYpAJDBvOP13fMzYqo8yAEEEIlgBDNffz8ImAP9dB0PpA66nwOA0Bb2yb9ko5qqkHLIZDdQhOX5SA0ajlUO0/msXywfrsITyjQ4pWhxKCQIny17o1lAdteW94lnYkM1iptZJQrAD8dZcbBUG47jAeygBII2+uVfEFNaAKx7uk5YS5NBTc0fKz6wud4EeTXh9H++4rj1yOeNON8WxkkQ/Y+u4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7638.eurprd04.prod.outlook.com (2603:10a6:20b:291::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:59:57 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:59:57 +0000
Date: Tue, 2 Sep 2025 16:54:18 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	imx@lists.linux.dev, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] usb: chipidea: core: detach power domain for
 ci_hdrc platform device
Message-ID: <lki3zjq7qmnmo3n445jbgxlijs5v7pqg5ngyvqkee625bfbx5u@3y56kxhocgu4>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
 <20250902-pm-v3-2-ffadbb454cdc@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-pm-v3-2-ffadbb454cdc@nxp.com>
X-ClientProxiedBy: AM0PR02CA0188.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::25) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b132d5-5761-4a3a-6cd4-08dde9ff1727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mV3WbK8yrguTNe6VWW4N4DgwHrn0R/mBgKlR904yNPh6sGs8PvnoZb5SHp3M?=
 =?us-ascii?Q?Kqv51PxY9Pfcw/M2qqFZZ50Jj5Q66sueBImzThfjrhjFiwRTPm9pVRnFi50p?=
 =?us-ascii?Q?CL460IYof7ej9wzY2dxbDHkvZLUNk5OPoA92rCmbVbii1qDuWXevhpRf3qLj?=
 =?us-ascii?Q?nbPvbzwMM+Cqx/GJMZFd/X49oxVsdjycYYl1kIZ7q6+cVg+IGkihCWvDAOSH?=
 =?us-ascii?Q?TYNs/xMJE2IqbZ/P8drFYKE1rvAbL5jVzF1l/4k5n+vibwS9GSiH5Oz5fUBU?=
 =?us-ascii?Q?T9zJeGz5fjemMTtjDE9pXWm1dd3z/vr+P69o6gbShtG5GTOPACuZ/gdpOQj/?=
 =?us-ascii?Q?fsEm2rRNgOLSY9KyiJ3WSMGeuQgl8yKl/seVIYlJXT2FKzmlW1icHxPOgtPd?=
 =?us-ascii?Q?wvQf88hex00WeeRPecc3LYlSsKJIwGIBMLMYN7nKrm2gPtkzS3HL6cbS/YIb?=
 =?us-ascii?Q?BsKLnL6rhz4iLujSwKgEl18UCyf0iYXtvmX+C1HbYNSxsAw30sMkSkfN8eNO?=
 =?us-ascii?Q?R9tu44uSywFfQ6+FBU+HOZAvZeHROXw8n+9AWMeAPqt1KAb4e2pltJwy3YoY?=
 =?us-ascii?Q?yHjV7xZQN2KWZqp5KnsAVl17/wER7QeVrh4NCJe3Imv/TKsluf8X6jKw367n?=
 =?us-ascii?Q?9D3EvZZzBLFCGYCc+aEGU9772TB68utsngraSJF6HD5rDEEGU5jbRaofiVvS?=
 =?us-ascii?Q?Mkw/CpM1YwYfNdDY9RgkNvgoGtckrxxycPexDklGMwOwfSAR6FUdPJPBD3qM?=
 =?us-ascii?Q?JsWfskYMQZ0RUrgt5P7SEvczB/xxTRgGEp7bxIHJ7uR/2OxYERNsxqX0TU3k?=
 =?us-ascii?Q?lIYLIJSIFSAN3HndM+26EIxFYMo34oddW5uWM8k7CQ2CjCdOEeffCB2YS8k9?=
 =?us-ascii?Q?gMu0uPpLZwgJG4ob7Tzu6RQBbJVYhMlPlic8x2ezp94PFjhuE/M5Oro1j9Zf?=
 =?us-ascii?Q?TYgBM5PAbDyLBJiY9YtSYUxJCdax4cW01dSmSfuRIPt+NYpqhsWslMqUd47k?=
 =?us-ascii?Q?kPKG23/9RPaLTswA6jgqmw4W90ieCe559qneH8BkCzJT2gVygaJjJNq+vidH?=
 =?us-ascii?Q?zvunvdJdEF0UYXtZw1VH1UneaWdiyaX7h6QHqtoZzOS5//g3e2P5L3ds54Sv?=
 =?us-ascii?Q?TAZuc7PPlI9cfX3jzbSvhoNMMhb2NrziK4f/VnyYHul0IPPI4rg5yKXii8u5?=
 =?us-ascii?Q?PqQgNGkCN07cH0i9UvU5N4Nesf2EXOnmiJlMwLrlG+BbkIpVu6yeRWoRwk1U?=
 =?us-ascii?Q?u72+RzYoQg9Yg/Y+fKJK5VNy+YV+PazJTLk2/Thpvta6fYCky83JZzW2IPHQ?=
 =?us-ascii?Q?4x2YKwQNzXmZK2VJzie9NlyvguiYaVvtiumz6GCp5QHFx5iQmfQCvsgi2Wyr?=
 =?us-ascii?Q?uirdeLpyb99/uGisPTbTh/xJsED5Df/sZknDpkpWbxJxjjUssNaM2Jh7H4lB?=
 =?us-ascii?Q?zU4aQhCU4PWev449zXYtOqCEY6QXmamII2hZVyDhrMp9slCC3soCvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMw4ANXDyhE23vCV4uZpCWUTGy5EkwVNpTRkP7wheMvxCDlO2vcg5o1GaTdy?=
 =?us-ascii?Q?jFpkAOYXIkfNCFEeNDWE4LKBG2ca5hNSAoFN12lV+pxNjoK/MBvupY8mdFdu?=
 =?us-ascii?Q?ESPs0WEp5FNXxU/PjmuaCWktoDJoCBbKcLKQeG6VbFs9Bip7i8VvDMPONbxo?=
 =?us-ascii?Q?rfeT/TodGr4HCkh4tCPEm+MZfmvnyLLyEUpRi8NF4E21eV8PTjdZQECBS+sv?=
 =?us-ascii?Q?xaR4z64QSj1PDbNX+sUJMkA9Rpyb8AFziPMZ1M9/ICKHjc7Y+z/4lrd6aOf0?=
 =?us-ascii?Q?W6gJjl8DhSvTgbFKDYD02V0A3v+EyGMJY5rd/533mcaUVa4Cc4jeX0SRYTj/?=
 =?us-ascii?Q?sh7yHk+Bl6p1RhSeEvhP9w3c9RY7b1YXjAZNwDB5rb09a+oxeMmxeeRAZ8D/?=
 =?us-ascii?Q?4iA6aERjBcYx14c/CW/Aflla7946H6lsSrMFsqhffI2cEVPXe+xU0UqZl50t?=
 =?us-ascii?Q?lDnPe/XGpM3zqYUqudZ/Z4dlnBFpLq9E9ozDax5RhRPzhW5VjCrqGWxyYwAx?=
 =?us-ascii?Q?gqMvlI9wSAwGhgDmZAsXbThWnEHyfPlFXQpoZdtNa0jv5lwXP7N2iQaPC51m?=
 =?us-ascii?Q?Qw2t9HgY08k16snuHzV69cNyrqiHV57BfBVCDXPtNKgiYzRPJdM66NLxwnBp?=
 =?us-ascii?Q?jHnBx20XWpEJJPj9zEP748MRzmMMGwuOPd7cC0B03JXoj8fTZkxJMcRVNC6/?=
 =?us-ascii?Q?xARHTBm6w3CivevQd6iw5e6e06tCGMjka3Zj9EFX55jhUrGz92WCyJvA/kVa?=
 =?us-ascii?Q?X1QAvyKX6x20PrBAMLG7l6Zty5ITjgQHFz9mq/fbQcbIWFS1Zvr/GemR/Dx6?=
 =?us-ascii?Q?cJ3+yalQDgyWOOdamTlXc1sSkKoifeDbmIQ3F/Pr0U9P+MHaflrIvS/pVHVF?=
 =?us-ascii?Q?M74x+++yMYvvt7oCB44DnTdTtt3+aFD+X2l4qGjMRslL06v1WU1wODTt4eHY?=
 =?us-ascii?Q?98CzNBbOpaTzqmaJSSOQkX1lRdwSsBoeMpo9U+ghlsUEG3+PCGWfoxQccmM/?=
 =?us-ascii?Q?5lwK6W9J0Ijtlw7YpjA+WcTP5IeLygODCpQZ2GSss0GmtCu7/5yCv5DzTta0?=
 =?us-ascii?Q?COwoKalMMUjCnOtOOZMsmrQ/0+Y1ejguR6rDiFYcqiMDzzTjdZ3Uss8RM0At?=
 =?us-ascii?Q?in0KJtobAtaeBpx7iJXeKDUsz3TUzYwusCb4wJQsTLqWvrqlJj1hP/7B49hL?=
 =?us-ascii?Q?9M/DeiFqq9v7MvvHk6rZm9YEd3qhOg8Q3MrmjxeN8+6zC7KyzJCwsCP4KGyS?=
 =?us-ascii?Q?Jr8/CJoVxNXTJN//Z5bS4m7lpxXR22lEffKdZWObNg2gIP0qo4Eee1pv36ZO?=
 =?us-ascii?Q?nGmRHudbnctFuZ04i9cL1co5Z2jkZnPQrNWC5iQ/w920/C0LcggzPiLuIddA?=
 =?us-ascii?Q?TaHIAVLWWZPBiKtfLnOkwxghm2mOhBgRFVsBEro/I9mhYQI011avfbyE04bV?=
 =?us-ascii?Q?AEZAOYFTEC6nbI7+t3w73VyTPd4eFRKBiZYFL/HR6nmQqvN+vVSJgoJRdyxl?=
 =?us-ascii?Q?i0KbxdM5lyxcVsehS640tXj2vI4Jua17/qH2LFWY2M+H1UfQNC0TENbljRoJ?=
 =?us-ascii?Q?w84WJkAkz6ds27glIGtKYWqWghDTR2d9ayvH9E9B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b132d5-5761-4a3a-6cd4-08dde9ff1727
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:59:57.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLkWmQOZFn7rB8RcVzgfqr5Kv9ld7o81JBXp9Ckk9hxHkhW9bUUG3Fg+uctSCC1ICZRALaIPiy7wlvWEHA+o5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7638

On Tue, Sep 02, 2025 at 11:33:01AM +0800, Peng Fan wrote:
> From: Xu Yang <xu.yang_2@nxp.com>
> 
> When add a platform device by calling ci_hdrc_add_device(), this device
> will reuse OF node of its parent device. If power-domains property is
> provided in the OF node, both two platform devices will be attached to
> the same power domain. This should be unnecessary and may bring other
> inconsistent behavior. For example, to support wakeup capability, these
> two platform device need different power domain state. The parent device
> need NOT power domain on for out-band interrupt, but the ci_hdrc device
> need power domain on for in-band interrupt. The i.MX95 Soc support
> out-band wakeup interrupt, the user need to enable wakeup for the parent
> device, but if the user also enable wakeup for ci_hdrc device, the power
> domain will keep at on state finally. To exclude such inconsistent
> behavior and simplify the power management, detach power domain for ci_hdrc
> platform device.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Tested-by: Xu Yang <xu.yang_2@nxp.com>

> ---
>  drivers/usb/chipidea/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 694b4a8e4e1d8583dcbf4a42f8c2dfd785d5745c..70597f40b9997a9766934c67bbbed38e96c210f8 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -27,6 +27,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> @@ -915,6 +916,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
>  	if (ret)
>  		goto err;
>  
> +	dev_pm_domain_detach(&pdev->dev, false);
> +
>  	return pdev;
>  
>  err:
> 
> -- 
> 2.37.1
> 

