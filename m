Return-Path: <linux-pm+bounces-26712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED8AAB9D3
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 09:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D587B6869
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 07:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0460201011;
	Tue,  6 May 2025 04:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dn/3MePB"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C329ACD8;
	Tue,  6 May 2025 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746503072; cv=fail; b=DcJO40Rct9PF5vBSXDNHzq2DkiA6L7/6Yv3OcOHIt0wdAqUOwbBri+jw2M4ZXIuMZeOwmxw8Ym5gy/nuPLLOhmbKRbFKR/J5B9lF9p8OzRkAtMxojAGsl0SsUxBcqNSCQ6cdPdT3oXESZV+C1pE3BCyX35EDDhmsEUU14SZ9+48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746503072; c=relaxed/simple;
	bh=6bP/IF3FOj1AnpVe+rmWzUB6bYJL6UPkBpILWZhD2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t/rvpsyKtR8AiPImYcuSlsSzO8CjU3oh0K48lyUx+Pz/xjpELF7zLk3DJutO7p7MYqv68zqhrwPggnPACzW4JFmNo05xtl6BN5DMpzhDjjnempjPnST9WL+PPLBgfGGeNbjZo27gbOI8SrEF0Atd8UPLuBvld/orCE+oMT2yNpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Dn/3MePB; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4gjtnya9mf3cmFPId6BhZYADeZLxdxqZplOzRnD+SGAY1w+FsnkBZ3S4jp+OuOD9a2Fmo1vj1wb7Vh+5B7Y6BUfIxHxSvKUboUi0zEvWtjCygYxaO88ZEEa1N1z9cmDF5USVFyI68kD6OHoTuh+O++NcKMTr+TOcz7WIDjR/2HK0ZUgLeN9EaV8IhrOpsRW4FTgooLODVtjkr2YsAfhWWUP1t2thKafgCosvT+zUwaQ8BvijuGDE5xq78eDDrv17hUmjiLv1eBzYl1T66Hs5j1YxGEtVUdl6dTqdWd1XYtLjhWDJa9CI+wweTfb2lYw4TpFsVUn4KUKTyE524/UGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGC/uymXtaW606JLwHXz7CPMq3X1EYFH6kU1ca8j+6Q=;
 b=ZUotQOZ7YI8UfaNV5P/xMNJImEkfJni5Wyv+WeVjAiUVIGGvCIDMBJVDyoB0YIp3AlmAsR53rMPG7xqGUpvFm61WrVgwHzs88irotH5E1VzQzIK1NyP/KcuP2T5i5bc0orU/8QbSCrncFe2FGP8g5umy3cNUwQIbqBrV+AzNyByCoUDf7QM4rXt/GRXDEkhNs/BdLZ+be73kUWA3Rm4TMtBsPiciPTWS4xUobqJ/Vz59uv9jDXijW1bcJAmkeKTEr4GVDgldcuN3t4WieUIAcz+t4L0qBzdGkfQZzahlrN9guwTIHkOheB/6a97ywHLQ+HeOarsAhRr2MW2PwQja9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGC/uymXtaW606JLwHXz7CPMq3X1EYFH6kU1ca8j+6Q=;
 b=Dn/3MePBXJChxX/CVnCNMjnImuUb1G93lGCGYNxCq38GrJseeWCRiwgiuzMKNvuQVlguACZJ7aa/jq1vlZkEICFyLXxnRR/5L8seIlXl2XNZoTDKnMz+YJ/Vd3rjLL4DJzir+6GWqbPuUiJa+2C8AnkO+RQYRgu3vtNBTeykK838fcmQQwEJrjD582bC6zMjs5YPnGaM/RwTQMjEC1j0jmqP0sJyyBfB+WTQ5IapfQwSvN8sM/hjmQXA1p7MZycq78p9pK5MljK0WM3yTyneL9SQTX618xuGj3dYKpEhafwoA8wCJST774xq2CQMTm4MjgxrUjRCvBQTOp8O5UbnMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 03:44:26 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 03:44:26 +0000
Date: Tue, 6 May 2025 12:53:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250506045335.GD24259@nxa18884-linux>
References: <20250505154849.64889-1-hiagofranco@gmail.com>
 <20250505154849.64889-4-hiagofranco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505154849.64889-4-hiagofranco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 74702f25-536e-4dcb-0add-08dd8c504bda
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y//c12Q2I+/ydgzFKuR5+EvZJt8N9CDgqrdpRjWgQfAusJArVoMMLEebv6QJ?=
 =?us-ascii?Q?CcbxZrwrHL6XjZsF27qvcK6s/2uT8f1TsF49ScaG3Kt8+LM0NZuAk0SnmpxT?=
 =?us-ascii?Q?mDVONkInN1J44Vmk63abE0tPuUD6ly+X7aUAn+GDkFOAVUqxcyDOcxyT17Xf?=
 =?us-ascii?Q?DJ4yWktpzELEWnilEB5ygCsZMql/tPwfiXkb4/tjZXy7MqhGldK6OaYyD+O8?=
 =?us-ascii?Q?TKn4Tb1Oi16Noqi4rT9B3ZLG6umoH5phtznBEWjMUgvV2GmpklHWNwLfhmMr?=
 =?us-ascii?Q?XjXELCQY6Z5ZHphJ1KIXAlxPfY322oFxmEUt60/BLtRCvAI1Nkyfx06eWZgS?=
 =?us-ascii?Q?VXWC9Hx+zRwZ9IVOIc7tYgJW/kJ3+RdKaKHZxy1SlOgSoIdcKHYKhJwdG6NB?=
 =?us-ascii?Q?/xB3Y0UZe0SoWWyJ7DkWG64usMZMCGq78RrVfddwRuFbWlUrlJPtpQ/DbI5E?=
 =?us-ascii?Q?ur1CH64USjtO+WPFziHTiSx9y+Zt9/OFt96qeBwm+KNt3unhbT/v2eonjNam?=
 =?us-ascii?Q?x4wZyrQQbj5d6OhWkX7CoZHKBM70vZ3g/RsNkM4c71c3ABCToFuroKtO+IOo?=
 =?us-ascii?Q?VUbD0ugCbbBL7lh7GFYVw76Il58uuZa+qjRA0jUvQqMNTmgZ4uosoqscW1Im?=
 =?us-ascii?Q?swSvcXgw1TWY9nDNTA+NwiGEJTCyac0QxSlK53sZMOG5rjYq4eTX1otNrsYq?=
 =?us-ascii?Q?omOrP8XnIkgcuLUxZ/yW9WAUyJKHYaTiTUnyoHucy9nJ/1DtjW6iwwmG9CSy?=
 =?us-ascii?Q?BQXZYa0kFSMIyv6yM2jBwXxUGwdKM7M6Lu13mPf34XyNn+tLv/lYXSaQvl6a?=
 =?us-ascii?Q?xVm7qmNOLISyfryLDRMvxkqSmJRntUGawnz7RwWBnjQ8x1V6PgeGH24uhd4q?=
 =?us-ascii?Q?4rECUT5r1nGz/yAtrYsrbTEaMYafH5FRKHmwkwFspD1iltYxiuYQV/2g0Rfv?=
 =?us-ascii?Q?RqAfqc/o1Nx1fLvU1u4XvrCfsV2wby5BUepISB6ykt/ywU5d1YJf8gPF2+Q8?=
 =?us-ascii?Q?KE85YPHXu/K/lPuHBmY8Q+Rq5foVM+q2SIprJcOr6Eahx4s1keEo0dovFPmG?=
 =?us-ascii?Q?BTf/4yIWIigXWQ2jML65zAeIgsKd7Ws6H5zPlSjkAmV5FziF8aL3HoxF9ee3?=
 =?us-ascii?Q?dtF0RvIlzRkH+mWk+MroW1QaStDLmwEU1TG8Yzy0E9KLNIahM2Li+kw6RH1e?=
 =?us-ascii?Q?jWVO3VTW3izj4Xvc4UpPidNtbLxWR0F6Sd5Z5adoe3zhbJTeYvmM1VdOVD23?=
 =?us-ascii?Q?sD5osKKnDuu8hXChM8g+ysUrhQvdH+D2d6m4c3AY7UmNf2mIqgudJn20bBAK?=
 =?us-ascii?Q?cHpK0vUdBw+4O3pMVMYSuUd/ikJOT21I2LbOxprWTYXHqskFwPZ8UUzQnUVQ?=
 =?us-ascii?Q?k6d2O1o0HnP8hYtWwcsRWNxTCgWeF18DvHxv99QPLhBAyXRisG1rDmPKFqq8?=
 =?us-ascii?Q?9uThCztPwcPYzVlLFaa9mQum9r3Wkjc0cakvwf0yxUXck0SRVDva71IfiOuq?=
 =?us-ascii?Q?WOSUQS/Fbnlws60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oJopUrqK7feGqo6H/mMrDwhXmZIG58lJ7H1HQaXnjjD+JLa/vkheUDk26d+Q?=
 =?us-ascii?Q?c62JnaYLZNTPXEpSejQ5TEO9d3Nr1SN7vijbnG4fMai8eAwGXfx0BwCW4KIK?=
 =?us-ascii?Q?N4w2i91OUTXk2CklTm27ReGxlQguf29A+WdJb6sp41rJFCqyD+T4qAXBizAG?=
 =?us-ascii?Q?mbYO4TKLahJWV1XoQD1FjycL5freVlocWCdI+Mmvm/p7LVFNiwgyermAOlM9?=
 =?us-ascii?Q?s1Bd1Mzlbn6fip22cIPsFtEr7LbzVO2Hab8K1Noraxxhww73y8klK361rUrG?=
 =?us-ascii?Q?2OfDrxMSJNqwDH+u/4zGeAE2rk4k7tbHrhmDh64bYL2D1exA9LGNikU85pNB?=
 =?us-ascii?Q?2fNvhuk6VYYTUcWYqciCkJOYOZorQaLQybzaCzANF7HpXP/bXQ/Fyj8u49/6?=
 =?us-ascii?Q?VEfBLG4yZoJ+4E+4WzfCEhdnYmc/xu46vDWHAZozSksTWGzBiRe6TTeJvNmd?=
 =?us-ascii?Q?pm+LEXP89uqTl58liaEWJDRJJWlHnjKo96XwTiDf3Y4MroUFNWt4i4libsYq?=
 =?us-ascii?Q?Qo78sK1oVeZWLXhUZS0anO765xNyOhZwDwkhiSUW7MndnPISLjfspHwnI+lT?=
 =?us-ascii?Q?YNsEZiKPrtgLtdLJSgxhXO48fAk3KyD36pVqj1sYxSZsxXfLbNqYfTRvoogI?=
 =?us-ascii?Q?ygmBPl3PuZL2CbaaaBFRYMz7QVMKGHJkTKbVcjU7V4Q1lY8niwY1MC3XwSAe?=
 =?us-ascii?Q?aEfADSUBlBE7HSpb6EYzN3B1KCYLOJk5aP279R0wQv7x0m/XT8MKgPT5NVvI?=
 =?us-ascii?Q?LhXN4bld4lM4/PEdsTS/pXuinLMybGcUCPQr9Z3qXSiW6I6qjo5XSq9Xiu2Q?=
 =?us-ascii?Q?BnK3maHAxWC0JKFVatg7ops1TEUwzAudOkIpymINq65gXWu2M52qtS78ITLM?=
 =?us-ascii?Q?IEFEDZNHqlyE1pxrxbBR3NvPre4vjqG+a3sy4XWv6ovJnymLq48cPImM041d?=
 =?us-ascii?Q?uSKuu3vxrDB+VBAJOLMx48UJ/pjR5U0LCYjRTsbbb4nW4N6Pd/GHXmnpcSwZ?=
 =?us-ascii?Q?QUkjrVAM9Le7Cy81iNOywE3RHXYOnNITttE+OPcGydhO6fUEA6lzKRf7xP54?=
 =?us-ascii?Q?yxsYM0qQZHZtFPqLBHD4nLBOckBkYOxpdx3cLbLV+BQAxHantiwqSRGKbmqr?=
 =?us-ascii?Q?T32hJjsQU0YOj7T1cdRrZ9W3KixeiV/vMKzGs96leO1/bUhQZPBO4S7Wpswz?=
 =?us-ascii?Q?M87ZjoFYOiD5kuWwjuRbS5A8O/buXO7Lb8+2z/j7oK0YWAVqGlXtl5GfJVTK?=
 =?us-ascii?Q?eqCwdMfh0JyuwwcI7KdV45Rp7kH39AdZikaotNRYQGxQ9C1oiRNr/CyjpsC8?=
 =?us-ascii?Q?9W4w9AQCBzXrEuVorjoIE6+q5uMPXwvCzQSnOjXo1Le2n6278wap5c1hDSFb?=
 =?us-ascii?Q?7R0nlbIVUruJxjejE+W3QO9SEgOQpb0kZgNX3ohUXdRvFmYn6ZP5cXqC+0Go?=
 =?us-ascii?Q?UtM/WupwvkbBGleCogKe+Awt1phzgudOig2ERS4iE5eX29LfVV8LiOvUFpos?=
 =?us-ascii?Q?xSNBfLy8hoY2RFdMv30sa12pXxv1nuboLjofhy8LwIb38eaVIbDccV1bAng+?=
 =?us-ascii?Q?SDH5ScpG71AghngkKLI+zIXkiHxYWskaOVO5Kcdj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74702f25-536e-4dcb-0add-08dd8c504bda
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 03:44:25.5848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lxVA9t6ewFmg4YOPA3nZ3WVuSaoBMVK4K/NEdCOi7pjP0k80Nh7Qb0jIFVS2fHCaYhwE7d6JXHsCHrJk5NR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473

On Mon, May 05, 2025 at 12:48:49PM -0300, Hiago De Franco wrote:
>From: Hiago De Franco <hiago.franco@toradex.com>
>
>When the remote core is started before Linux boots (e.g., by the
>bootloader), the driver currently is not able to attach because it only
>checks for cores running in different partitions. If the core was kicked
>by the bootloader, it is in the same partition as Linux and it is
>already up and running.
>
>This adds power mode verification through the SCU interface, enabling
>the driver to detect when the remote core is already running and
>properly attach to it.
>
>Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
>Suggested-by: Peng Fan <peng.fan@oss.nxp.com>
>---
> drivers/remoteproc/imx_rproc.c | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
>diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
>index 627e57a88db2..86541d9d8640 100644
>--- a/drivers/remoteproc/imx_rproc.c
>+++ b/drivers/remoteproc/imx_rproc.c
>@@ -8,6 +8,7 @@
> #include <linux/clk.h>
> #include <linux/err.h>
> #include <linux/firmware/imx/sci.h>
>+#include <linux/firmware/imx/svc/misc.h>

Drop this line.

> #include <linux/interrupt.h>
> #include <linux/kernel.h>
> #include <linux/mailbox_client.h>
>@@ -906,6 +907,21 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
> 	return ret < 0 ? ret : 0;
> }
> 
>+static bool imx_rproc_is_on(struct device *dev, struct imx_sc_ipc *ipc,
>+			    u32 resource)
>+{
>+	int ret;
>+
>+	ret = imx_sc_pm_get_resource_power_mode(ipc, resource);
>+	if (ret < 0) {
>+		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>+			resource, ret);
>+		return false;
>+	}
>+
>+	return ret == IMX_SC_PM_PW_MODE_ON;
>+}
>+
> static int imx_rproc_detect_mode(struct imx_rproc *priv)
> {
> 	struct regmap_config config = { .name = "imx-rproc" };
>@@ -949,6 +965,13 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> 			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
> 				return -EINVAL;
> 
>+			/*
>+			 * If remote core is already running (e.g. kicked by
>+			 * the bootloader), attach to it.
>+			 */
>+			if (imx_rproc_is_on(dev, priv->ipc_handle, priv->rsrc_id))

I prefer "xyz == IMX_SC_PM_PW_MODE_ON"
But anyway, up to you. I not have strong opinion on this.

Regards,
Peng

>+				priv->rproc->state = RPROC_DETACHED;
>+
> 			return imx_rproc_attach_pd(priv);
> 		}
> 
>-- 
>2.39.5
>

