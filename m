Return-Path: <linux-pm+bounces-39244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A4CA8568
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46D032A88B6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A33C34CFCC;
	Fri,  5 Dec 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QfxhTYCc"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86416345CD8;
	Fri,  5 Dec 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947305; cv=fail; b=Qs+DC4s7by+OZqdpvfgvU6UEZks/Fwzr+Cc7xgqS/A5gKFlTYMcWj3VIEX3bcOcf1cQyPXNbJVZcELTezuOFQVNAb2F4lrtQxStkSyKuh7sPJ9hWi1+mnkDqwgRgf3Mpk0AQbpl1E6nU1YWbebvlV7nV4Wx3iDUB1xlW4oS7ejc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947305; c=relaxed/simple;
	bh=gsix+RhW/KSd17d912TP6u+JVsx/LszykCK4Fr2kh4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tiby55UpuaTPUR4EeyWmntveqpIFX8JYQUon1jJm2NDrEarvO6yoW73hYHPl3r8TcfgP6UnZk98aCunv+3SpyxM5OwVeaY4HjTtViojOJhZNEbxd1uN4BsTSo6pr0EYz8doDBPaNlHIoxe3/2CmzQlc7U3GWl1eGKk2Z+2sigiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QfxhTYCc; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoMe0dhU34FkA5kg312MdQWbM0SIygqzEGGxEWN28+lWvtfUlT0TOu9ovPHRxkoZt/QtWvwwoxE7/vA/vF2PcfuyO0vcaCtF5LgCp1NeRTGNgPQn4Z62aOfVVcLfNo/GC1z7vlPaW46WpWlmNqNmtXOzB5L4NyiN+lR1yW+DFvvQjXu65TOiArQ418XgkoyeJcRpPOyJThVo5WI3Kut6HFFCfB2kd+WlyOmUdi4Gfmgnf9ExnEfapVdo6cK/Gt2q35aWuRLmv/o6IZOH06XhqI2tPePJGUEZyAMoapiphUKBxpO3QhnrqqXfraCOjXidUMc1wxpx8oUGGoT14jO91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTfY6EWmq2gzRb9AeJBUVjP2xs908KwCCUHhuQ8w7Yg=;
 b=LLBOu40A3JS0ULR9IyJqdeclv+pAmZN3qm4gUYeAkz6yxpyTQodiMNaFLjkOZO8IZJXL9Xk+hi7gYW4x76fAaXHR19+myQfgNuj88pcacdI8P4E4BiXfxB4qKH7bYhcoDnUs2qbEfzedSEbnTP0nSIpBppMNB02gQ2PjU0JrnQP0uL4DCyzm5+vXQDDtIqg5p6tz8sdMsJqBsZTwcciMGK+Bj6kqGy6SBCI8xCqNXofO/lSHbrtMYUZ8T+EJy6baZVerx19okmKxcwAVES6dBLqLtdgjFaVnLWp0mbDxGYJv1C4p2ssJznPz4NDF3w9IgERWqWWBHDVfevu0JHDlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTfY6EWmq2gzRb9AeJBUVjP2xs908KwCCUHhuQ8w7Yg=;
 b=QfxhTYCcuX7si7H4xRwh+k/4Orr1XA3d5GapRURlM03u4mwNQx605Cy/r3ayqGtjYmYFU8PpN4aLwD+TVrOtrBwb5RpmGBylQOvrh7Dcw1b+yc8CXGCVkGuwwESMQrT0OhxpmJW8Q4qjNrTmxya6OoPZ6Lca9JhaWmlc5l7jLVZEQbdsPqMNXtD5pkTdBI2Kzxgl4Yq+WFv7p8Xoxq4spzhA4eljaRBWhpN2D4xxwBJuGYsiiEQhhTQtu95ijnmx2EH27Qrqal9besCbrwGnzPbijdzukn7KqJgKhx6aZJNHe9mYvSOh/VV02Q2sKwl5wpgpGkjspQuURa7odoXyFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB9779.eurprd04.prod.outlook.com (2603:10a6:150:111::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 15:08:16 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 15:08:16 +0000
Date: Fri, 5 Dec 2025 10:08:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
	ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	l.stach@pengutronix.de, peng.fan@nxp.com, eagle.zhou@nxp.com,
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] media: v4l2-mem2mem: Add a kref to the
 v4l2_m2m_dev structure
Message-ID: <aTL1VleoygCIap3N@lizhi-Precision-Tower-5810>
References: <20251205015428.643-1-ming.qian@oss.nxp.com>
 <20251205015428.643-2-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205015428.643-2-ming.qian@oss.nxp.com>
X-ClientProxiedBy: PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::28) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bee49de-00c6-4caa-3768-08de34101dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?On2X8vTN2DFlsHv7K9dqH7PVc8OgdInisDg0CnCFgqq2CsR8FIrSM9PJln5O?=
 =?us-ascii?Q?KLhlzEXreyRpyectZ2lye34Jiyv5s9ddHAH222vWrSjHGk1QVaJIgSvdDQv8?=
 =?us-ascii?Q?rY0SV0UbH3fnveDaLgDhzALKxCp2IKa6fHIFkWXpgnPaSVCYyzqN9bvjQgWI?=
 =?us-ascii?Q?HhOePRlDxjC257/yLKGzx5v2rnsk7T/+ZhiB4+Cr/ziXUvVZoNXDlTmcyf5i?=
 =?us-ascii?Q?3otX1YW8+4Vol6gdQxb8AZnOIObNBx7SOq4YTymfK2mIGnqmGTIC6HLoUmgp?=
 =?us-ascii?Q?zNNYZUXJE7mIp5jsQ/ESZ/ciAknDUHQwCOSqf2pAMjqaUrSAIIKa1zkdyDsn?=
 =?us-ascii?Q?pg2W90Ru3OFnZsOP96THtww8W+ASo1RyZAIdLW1WFDHTcwYAQAd+QZsrbA8v?=
 =?us-ascii?Q?vElfKNZTZq5yLWiP/EnqC8dt6vX4bh0i9iXguR/6bZJcW2PfRqEpoy8PjLxS?=
 =?us-ascii?Q?1zEk9Pp0ihj+uMGz9Z8ZEnEQ1M0yjnROALgMFFcxjfVmGTPHckSWngDKqqeB?=
 =?us-ascii?Q?M/fcC7XUlSsmnyk1haOEteqVAHOmXJOBNuAl0ktaLR4FoRnpUD4i1Q+jb9Yl?=
 =?us-ascii?Q?7Z8nGUIC5YVPVTehD83bnVlque1qjRcABUhtuhfBRERcTv3SfLQ7woP1Hea3?=
 =?us-ascii?Q?Mt0RaXtFkeK1BTyhyxkdtuVk/IRosHyVlA+dRinS3CPVPFJu5UgI+yjTtQ1Y?=
 =?us-ascii?Q?WlVe2AI8FpjDN5Er38iDORTMp8HXa861/Sv/ThpDJKo3BvBUuMfiWlw4sHJg?=
 =?us-ascii?Q?Zdg9DnUeoZjks+UD8ikLleY7V3MgtC6zUBRDEyBSrciNyRzIs2sJ9hBXdwKj?=
 =?us-ascii?Q?B8EPDq2D7uxMCYNkar82d6+Ni2nuct/+rtvCq48pc86rphVlTz/kXv+WonLl?=
 =?us-ascii?Q?Y76YyurSyuXPHHaXgF7fE8uStfevyjUw7aDVnuh3KKX4fmmiI2MmRaKC9n1z?=
 =?us-ascii?Q?cD90B/suRRwKjCb8vyo9glb9E/rTukmGzVbB6Blj4eaVOYa8Tm3z2cZ0RkCm?=
 =?us-ascii?Q?+qn2VYnX4dCeTnzl5g3EvVfiLlEz11l1/L7NQ6ClbygGOCPTcjXy8kQMkOq8?=
 =?us-ascii?Q?sSqXxpjhi8fUlNkFjCCLUQST+pSoS26o42HIiErXLSjVvkvT3CYVDFcsaccQ?=
 =?us-ascii?Q?T6raL1kvmeJ7sL6ONconnvQ+eVdYzt4dggBv0T551eRjcJY8RF9PyyYm+lGZ?=
 =?us-ascii?Q?ZVhSGSXpoOHhernEjSCnPhnpcVjipviUlYvWl2ETrsLei2DZrHbyhjaVIRXR?=
 =?us-ascii?Q?OZo7f0waUPYQKrNA7QSuI8tTy7Be4B5RlxwYvu15+qCHGABqnvzQrRFenIXb?=
 =?us-ascii?Q?oVo9MPkM4lx6kLqQXb30iU8fSmE1CeKSYeC7bgT8/K/T7GdPa8qbPOehO/Ui?=
 =?us-ascii?Q?dtHwRytB878OQ63+PDY/jZLmm9DHm2/JPfpbQ+VG3xr8VjBNNU94U8dcWaGO?=
 =?us-ascii?Q?KaVa/NSJttU2KruMhe5puwpkBzM74VvJoiM+yauTaXlov35onyHZ5/J4va0l?=
 =?us-ascii?Q?JbBDdypjbFonxvDbEQJROqyj1kDkNyQR5uat?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iwkYT0mzCzncSzpNdU4iPv1CiM8hh4lApene8D60U17y+VrntXhIoSlK/lM9?=
 =?us-ascii?Q?BAMjyBRbBumAdYH1IKXNpEdVpLRtrf3eMkXxVEC06W4PRHmBpt6HUaQIqB0O?=
 =?us-ascii?Q?oA/9t/LeqpzHqNiHTTmmLS2ImZOX7a16RenE0omWMcnfQLlXM34A7JRA1a3/?=
 =?us-ascii?Q?MtwaCAtyOXWt6sM+6y1kg0Oxh6PCJ73o7uMoZcTeHXYCCGqn5i6GaeGX79wY?=
 =?us-ascii?Q?osZtNY1qkYOYc3IF6qNSrfD9yoblxgsDlOtOMAH/iiRuY9MNDuh+MFnGxA9p?=
 =?us-ascii?Q?RVklghBSYYMBleGx64s7VbpkhoVOf8Hojj2EJk7GHDDrEsze0eeG2WHRjf75?=
 =?us-ascii?Q?MapHqqqM11qXj+IUVDjHrBGdOLrEJDUw+LOHbo7y9N/+w01J9aMJYsnIW0w8?=
 =?us-ascii?Q?X3nYKhqIxtU9lje19SWyNhMHLoJsX2bU4raYL+yS3hjIY0O59gOk9pvpZdo4?=
 =?us-ascii?Q?FQ6vhqby7AxMr7g5l/Ky63Tx7jl/fz7qpsYltBpVHaU1f9SF2zC5A1XFhczu?=
 =?us-ascii?Q?1ZxLofB7SlH7O1QYd1wbmlQCD+lTSKObBrP93hYx7b4bR3lK62pRAqE3W9MS?=
 =?us-ascii?Q?ST3HL6Rb7LPpPs5NoUybpjfI1LNt+T6+F9u7Bo4vSYtVQBA5hojRCsiiflg8?=
 =?us-ascii?Q?Hv2/AP0B4F/SnXKnfQ2aIYhoZLAus1sh4k7aiYfZL9zc672i9F8RXTxskeMC?=
 =?us-ascii?Q?AQkAgrUHLypms+fsoKLWHX6tdtYuqp8ieYS04OiVfsrrzsU+CchcZCLgFbDu?=
 =?us-ascii?Q?6E8UlrfcwwStOVoI8FG3egqRzesBV7CLeK8sbiuK5GshzKwgZZKUuGnqh+dj?=
 =?us-ascii?Q?yjFsijwjclYKVdNgvmqYt0QSZCQqMhdhxBV+NMr3KFhYOv3QMUaoJbJz/dmu?=
 =?us-ascii?Q?E2wPYUM3LsfTMAqw83VvrwfHzaEhGko5B5fQF310Gl0gR0FADwta4Lb5cfqO?=
 =?us-ascii?Q?dYfd5HMQ00LaxbEjnTa8xdKZjXYHP4t117g+2dB1lGXvuz1bdH5rhz/PKvm+?=
 =?us-ascii?Q?an5HyAQnlBuCD0puRplsIugPGoxuQbrtR9vQT/8DMEtUrpVI7Z4X3dLVvpTQ?=
 =?us-ascii?Q?ELSoRMxo1p5ltX83nyNvXp+arRH0TW8ivVFAs34kQIeQFhOZ5iqKFOQeqfe0?=
 =?us-ascii?Q?PFjP3Ifvw0DZWcWBBqdKZReEgpo5eRUFTaTnZxmXJ+el3SExoCL6luuksfxU?=
 =?us-ascii?Q?NaIoGJPC3vMAMVlxfT9TcfejCGKba0GU7aSOsrfmbLZ5NXkpeWkYWDWlYWhu?=
 =?us-ascii?Q?P6/QAFv1KCaZ0bLnLVQtPMmQy1FmJIdsyqmsXvwEjt3ri9au7YEtAnjTB3k+?=
 =?us-ascii?Q?Y2rX23ZZ8rjQCFejQFGxpl1+dWzU2OM2/9sEA1UI/rPDilQF8iaULo+2XBuK?=
 =?us-ascii?Q?tmBn3bKp07vVJ0SLFqK93fq17SBdl2bHTfbEpRvBXtjbQZ4OhNuMmTSkm1jF?=
 =?us-ascii?Q?HB8+MBVbxM6jJf2BuLZUFlxN7qGSMgWNTNHIeS7Bgs5HpbRZWlCvl4+GAblF?=
 =?us-ascii?Q?zjN7EpaY5lbdXWgvvTSsCHqYYl1ss419vB/zRja215RjDlOQSzutPBrUunqy?=
 =?us-ascii?Q?YPsZfSsdMot+AlHSxHM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bee49de-00c6-4caa-3768-08de34101dbb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:08:15.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paYhtDbB4qZjMO/DCT88x75BVnYaETJQHpptSA4Q6+vtRYZlfhioRxcs9a+cn9/EczXhr9ya5PKKNTsIUPI+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9779

On Fri, Dec 05, 2025 at 09:54:24AM +0800, ming.qian@oss.nxp.com wrote:
> From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>
> Adding a reference count to the v4l2_m2m_dev structure allow safely
> sharing it across multiple hardware nodes. This can be used to prevent
> running jobs concurrently on m2m cores that have some internal resource
> sharing.
>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v4
> - Add my Signed-off-by
>
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 23 +++++++++++++++++++++++
>  include/media/v4l2-mem2mem.h           | 21 +++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index fec93c1a9231..ae0de54d4c3e 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -90,6 +90,7 @@ static const char * const m2m_entity_name[] = {
>   * @job_work:		worker to run queued jobs.
>   * @job_queue_flags:	flags of the queue status, %QUEUE_PAUSED.
>   * @m2m_ops:		driver callbacks
> + * @kref:		device reference count
>   */
>  struct v4l2_m2m_dev {
>  	struct v4l2_m2m_ctx	*curr_ctx;
> @@ -109,6 +110,8 @@ struct v4l2_m2m_dev {
>  	unsigned long		job_queue_flags;
>
>  	const struct v4l2_m2m_ops *m2m_ops;
> +
> +	struct kref kref;
>  };
>
>  static struct v4l2_m2m_queue_ctx *get_queue_ctx(struct v4l2_m2m_ctx *m2m_ctx,
> @@ -1200,6 +1203,7 @@ struct v4l2_m2m_dev *v4l2_m2m_init(const struct v4l2_m2m_ops *m2m_ops)
>  	INIT_LIST_HEAD(&m2m_dev->job_queue);
>  	spin_lock_init(&m2m_dev->job_spinlock);
>  	INIT_WORK(&m2m_dev->job_work, v4l2_m2m_device_run_work);
> +	kref_init(&m2m_dev->kref);
>
>  	return m2m_dev;
>  }
> @@ -1211,6 +1215,25 @@ void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_release);
>
> +void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev)
> +{
> +	kref_get(&m2m_dev->kref);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_get);
> +
> +static void v4l2_m2m_release_from_kref(struct kref *kref)
> +{
> +	struct v4l2_m2m_dev *m2m_dev = container_of(kref, struct v4l2_m2m_dev, kref);
> +
> +	v4l2_m2m_release(m2m_dev);
> +}
> +
> +void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev)
> +{
> +	kref_put(&m2m_dev->kref, v4l2_m2m_release_from_kref);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_put);
> +
>  struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>  		void *drv_priv,
>  		int (*queue_init)(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq))
> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
> index bf6a09a04dcf..ca295c660c7f 100644
> --- a/include/media/v4l2-mem2mem.h
> +++ b/include/media/v4l2-mem2mem.h
> @@ -547,6 +547,27 @@ v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
>   */
>  void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev);
>
> +/**
> + * v4l2_m2m_get() - take a reference to the m2m_dev structure
> + *
> + * @m2m_dev: opaque pointer to the internal data to handle M2M context
> + *
> + * This is used to share the M2M device across multiple devices. This
> + * can be used to avoid scheduling two hardware nodes concurrently.
> + */
> +void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev);
> +
> +/**
> + * v4l2_m2m_put() - remove a reference to the m2m_dev structure
> + *
> + * @m2m_dev: opaque pointer to the internal data to handle M2M context
> + *
> + * Once the M2M device have no more references, v4l2_m2m_realse() will be
> + * called automatically. Users of this method should never call
> + * v4l2_m2m_release() directly. See v4l2_m2m_get() for more details.
> + */
> +void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev);
> +
>  /**
>   * v4l2_m2m_ctx_init() - allocate and initialize a m2m context
>   *
> --
> 2.52.0
>

