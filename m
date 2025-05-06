Return-Path: <linux-pm+bounces-26711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD313AAB9EE
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 09:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B5E1BC52A1
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2BD286D60;
	Tue,  6 May 2025 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EkD/QNa8"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012049.outbound.protection.outlook.com [52.101.71.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362528ECFE;
	Tue,  6 May 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746502635; cv=fail; b=sc3OpvbK57lFoMq12W0WiBW7Aerf/+vpF4yckWlDv44UENVcJMrQzJh8M7KNzNCF9PBPlXn9D8uoJ8s112m1AmUERLLQ7pbbBnUVtOz2cryst8L/MZ4x7fY8ZbmuNCmjNi4DICWW8Rgw/0dowWnUg4c48zGlyomRoSrL+J3fB40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746502635; c=relaxed/simple;
	bh=aZ9eRJ/VrHZ7fASaK9lJuxNe2i1YmPORtW0glY7Gg3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aduSfBtjTYNbo579ioat+FzHsNiayl45A19prktDwqJ72Dgg76Dj8mVGE3pCmNgIHzT7uHCUHleCoXd2kpP9gIt5Xo71z9LI6o9O459f1kUbq+Y3aRACRwrQGHAPTAje0ynakhXn68XkwsuT8GbR8M8P+X/ZNF8xU8OJqxMMrEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EkD/QNa8; arc=fail smtp.client-ip=52.101.71.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIQ3izgW6FsO/ClImp0LPRzLLdJq5Bmy9ts9nsSWfpknhxg2V6jMU357cHOqclVlK92AWThRkS8M3ACAls1/aPPVmziTSyI88H9EJqWKxPyRHJEdHt/B+B67mCBuR/JYsr8xWO04gIePl8HvDkJ7s0sVqJgZrig3f39azSSOuGZrDFrv/SoQGP1G+2kR4n3jvhxIsck94GnYzmk1ycO/m3pTMlhW0cMa9TqiahwMqjtEbTtHtRiNtw2TVd9Q4KSYtj7Wq3cLSSw5OAd5GbnCtgDyvbh+iaB/GJZRGXT5krtu60xsvXGcwNo5sG9FP6dnURpm8th22sSUZg8oc5nzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC4JElB+rpQhiA/GcUeEL4R9keldKICAKef6QnSg7Os=;
 b=Ci/b0oo6ojvvohn7qw/w/3zl9Pump0exrpm5PXUZGE/EuN81sUkF5hiVWvBr0yIHMRGNfT1Sc5xAvNbrHktnU8tqsawOaw5s0Vztd2iMEulTDemqQMhgJZmcf/Abc41N/9aXPbVDIR3qjGYsFq8Svp+a4VEj8flbL/u/pNOoyXH5jW2IQPk6UgBe0lBOZZrtFNu+6e+EDbiObGxwjGkGxfbWPDRUNpnkPAOZEhjMerzpknV3uEht6isAGmyPCSF0Z0ym5reBedcxy2mv5xt5XREeS0jDNDlc2KYZN8IkiilfZmD2/WGQQA/NiCDVZsVXfIfTcBRJ/wCYkQSmGuBPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC4JElB+rpQhiA/GcUeEL4R9keldKICAKef6QnSg7Os=;
 b=EkD/QNa8JhpXgWdAPhI2bz5pFWb02l+EaAGZ/dkDz6iHU+OWGT9dPZ0mUJZAfiGOOKzAOh/TMa5XcTOdUX9TIqJxw5V8xemkiVLstVIufsUmBz/2bLKFhfMRg4XRe3XdZ5ncx4ZPb3reriHzFyFEh124tMUTiCLExpOQoFppS6I+Kzv7usuRHXn/FjeExj4fGl/yTpeRXdnzFurqH4Lw7Ty53tzjLUEqmotygFXxCERU8yfIElTKRWsRMjH65EXNs8F2AhbwfW4tbhFtJg6H/PhdfhC5SzAt+R5R8L9WVIX9FLEl4nRv7eMv/ToNNyIM+bOYRP/rXok6Jmj+ntvn9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 03:37:09 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 03:37:09 +0000
Date: Tue, 6 May 2025 12:46:18 +0800
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
Subject: Re: [PATCH 2/3] firmware: imx: move get power mode function from
 scu-pd.c to misc.c
Message-ID: <20250506044618.GC24259@nxa18884-linux>
References: <20250505154849.64889-1-hiagofranco@gmail.com>
 <20250505154849.64889-3-hiagofranco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505154849.64889-3-hiagofranco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ecb0d4-8001-440d-d7e0-08dd8c4f47ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ktN0AzhIkz13rwyAllRN3MtsxbZkJUb9n48oZmhHIqd4W7ya0I2+V+y5onYi?=
 =?us-ascii?Q?zhSkp5cEGdYMiktM5Hp+G/mjYf0iHZtOAfBwPfn7BViqFZQ/v6Y2a6V7Dy8X?=
 =?us-ascii?Q?kjzfH/ti7TFbibCcSsIZ5wbQCDtS618gqK/USDaMCILOvjtL6mQ/pMgptFeQ?=
 =?us-ascii?Q?m9Gmimn6KtDODkyyW3dMSlEnyCe7CklfkG0lC8PlCSF0d/Am55+0bTb6pxE+?=
 =?us-ascii?Q?WiGDFedIHoomb/SyaycQyn1JMZqPQneVVF04tZCvaXXQdl5OofKh16qIqUuU?=
 =?us-ascii?Q?sStqiZvuWMl97NJYU94/cJEBaXtNN+M9n/KgthUpFZY85x9GR/iOKtfEgIUz?=
 =?us-ascii?Q?cZ42jWeS0keR1IUWr/YAU0+7RQYqWuO4+FZtnhisOeo8Ya+1kNImBe/jSRpp?=
 =?us-ascii?Q?Rcnfx6wrqlysm1EXFdjzCT/iHnEZ58RCrplSs+GSUYjx7s34ciujZQUkW007?=
 =?us-ascii?Q?NFYVfRzX9YEiiH/2goBF8QnX1/wKKbY3ETIJfqN0BScycdhWYU3euNEleAbH?=
 =?us-ascii?Q?lW2of1GSZmIdwL65sPatVfHiqTH+cnKErjauu0MZ8x2uNyGBK4gi0c26kbiF?=
 =?us-ascii?Q?7Z6m7SCTlWn4hPMfuGdo55KrLKi2+hLEhjs2w5+YxGrbjgON99QKjWscTATE?=
 =?us-ascii?Q?TiNzboaSqxkKV1QO+RCHRgMlYd0cqS4qNDmbukvziXqFKGnZG+uY1+HZuHxV?=
 =?us-ascii?Q?0RDfDbmkmEQlqHWjGHmcnpRGO04pW68UG+mDY7GxEAeN1jVR1DpEcjCw7BYk?=
 =?us-ascii?Q?KRSOCqa8TMKHSyZUSUfIIGBuo5eJIApLzLuE8oMvNrmgBZcXnAkgb8mJLbep?=
 =?us-ascii?Q?V8GJT/flPrLj8d12iodo8aPG4PCxgjfbO4hBIULXT1+3rd63sLscIFPzxtvX?=
 =?us-ascii?Q?G/kM0qmHSdFBARpGzsQ1WdpXhss9gmY6H/dyuNpFUqFh/s/YrkRpGxHMOiit?=
 =?us-ascii?Q?WVr2Vnfl4elOKgYTgcTtjwc1HLe0lmPRGlIQYYPgA972TsMG0JRNf3D1jZGZ?=
 =?us-ascii?Q?K+LThrhS/5+uZpklTI13DUwRSSbB8gogS+ZnDxpMh08eVCq/S0P5ggB9iZz0?=
 =?us-ascii?Q?Raa0kD0oFVDF9OHL0Hm+st2hIlTk+aC8zDjcTflf+8KI9xKFDVDJxoTHmPNg?=
 =?us-ascii?Q?dHN0I3DV1vrftOQvK4bVgq5ccEA7RtSlbRRw7652u2TFvQvG8u7MTtAWW3/f?=
 =?us-ascii?Q?bhTC2O4OPVo4DcaCSD5kKhb0K4xxWYbHQWlliTht8eSapqtW1+elocIfzRCf?=
 =?us-ascii?Q?gWSED2c6D8m7fDlkq3xgaoPJ83c8YqDrJOhp+bJdQYHFK7dUsbBQVyGZ30fX?=
 =?us-ascii?Q?KTKDF7ipxMgvL3P83yKl2Qa4DyLdKSEvtWLrNpUp0+L6H71qmNhwpvUP2zRS?=
 =?us-ascii?Q?2aAFigOmtuHfLuU18mF6DmdFR+tktJKI5uSIEt/7q1KA7U1OqOohIvtNfHui?=
 =?us-ascii?Q?DWn8DuwO65+N1WAWban9AZb+t3/HFoaBQZK63sGAWanTboYxHvxEUC1RLs1V?=
 =?us-ascii?Q?KIQWVfdDHemFPoc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ixx64L6zo6+/09YPudv7K6a2SMH3JkDSEUdZ8a+2wE19rgPuALcmHrbs6guq?=
 =?us-ascii?Q?9f3Z72ciwC9YUmYFAuRk2/W7pzzhC4qHreq0QGNDlYAoYcD87s1dt3iNCTyA?=
 =?us-ascii?Q?vaahQdCnYxOPjI3cOS4JmGLwSt7sgoFeqx3ByVdDoYOm3q4UwwPfQx+UcEAJ?=
 =?us-ascii?Q?zViCrdIM+N43c4M4TrgAyfRe+33F4YGezhZDu13OvwCiNtSte5CIFskcydH8?=
 =?us-ascii?Q?Nkkods7ctaMu+in+t2wF6gxuGQ6To+0A4x/VHZv+UvYsSz2I8xWaD7UHVxLw?=
 =?us-ascii?Q?OL6YneofOV1TJ6MxJyrWNqA7quXUJNnbMttH+S02M3mvkTKR+oPEeApzPCoi?=
 =?us-ascii?Q?Ijc1s9/luVJE7rnCKKMKIQDAO87ATQW6XSZXHxOpJYrVlPtFKkQGudzHRLmK?=
 =?us-ascii?Q?yBhWMgcu5exoJdgFxfPvBKDg6M8LVuEzFcnHKLYwQslNZLN++nz7bSSFQmnL?=
 =?us-ascii?Q?3BOr6jFc+las4P7IWL/RniP4VTkFIRCo/ZzTNp19uKrNy3WF2kqXgOom8YW7?=
 =?us-ascii?Q?RSBYK5b9E7w+aivvbyx6F+Fkg8YutC9sPI7IGHg4HQZVPDy+etT9zOOpXVNg?=
 =?us-ascii?Q?EH9cPotw+S/+3vsBJGsabfP9EDcHr0y/Tfll9Zzx+83PfSR9y5bWV+cY+a/4?=
 =?us-ascii?Q?ow0tfRJZnNbOL0VuZ9ZbQcqXRFofXV/FQODBaAjHG6nFpGpWnihx+/xKM4wx?=
 =?us-ascii?Q?suvJZT9Q3hZNodUvSOXfhvGM1PMztiEPnC3xQN/PZpZy0/gmjmLR+S8Mbend?=
 =?us-ascii?Q?/1roYoP3mNeaN+Q/Cx4UF9xH5sGhI8gNJgdmHn9gLSDwAGdqEruTsn7mIErZ?=
 =?us-ascii?Q?Tlqm7VG6gfivT5MbOzI3S+b6EYOVq3eUGDhH2oPYtoz5TACcCjryt9ynZUnA?=
 =?us-ascii?Q?HcYP65bK1UNl/gVG3Of5OxfZ/ukJXBEuipUu0TOKW+J9QO2JqdgWK3/tOXA5?=
 =?us-ascii?Q?azVoxKLQxD2uX2ZFBXMkIEAsTDSvAup7nujz6FAvVCWoRZoSfo98+P+tVY8I?=
 =?us-ascii?Q?Nnhj9A4XMp+rX3eD+AC/0jmPjzuthiFYZ0tYDbq2jkypmeGhcq9TPLPCymgw?=
 =?us-ascii?Q?gowW3RiTHz5RlYfsANpu+eTAaIgPmBSTQbBdKFuAPnvxQoHCekMyjDsvwxF5?=
 =?us-ascii?Q?309ti15T+AuGiZWtJgJGV9CWm6fYWSbjJsMXvEGNT2kfXPhkBUQZyH5s1izp?=
 =?us-ascii?Q?EyEqYRn8Q3YyqzWJq+mZMu2QwEf/oY7fjmnr4ileT6e/hN1w3okWzJ8em8z6?=
 =?us-ascii?Q?kNxwVJCpcHzolrYfERmZ2BAj9JY6bP79nvub3ExPGEBTgk5Tg0+nzc+znhMW?=
 =?us-ascii?Q?YfL96Wp+wpQgFObKLGmqs2pPrefGxXe/AV5YTQAKxtHvpVAk2gb1wN4yVwV7?=
 =?us-ascii?Q?MXu/2dtwsLrrOGp44690tX29BtqxmUS6TyLnfsiLYfPbc4ZKAskcZjfGZJ1s?=
 =?us-ascii?Q?+LjRzr4y6S9Id8Vnw7uPlsUL7DHV1gYyB6JPP52ALXI1cFuUbTeDBRKg/BXz?=
 =?us-ascii?Q?xPHgev/ynh2ukeJXo4cjwjyH3/enNRiZNdrnA9csmqUn9iuhjtswyhHNXNc0?=
 =?us-ascii?Q?ar/rIsVlyRtEURBc+Z5cLQx4eFXBdFiN1WL+OKNF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ecb0d4-8001-440d-d7e0-08dd8c4f47ca
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 03:37:09.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQzJjZYVCOym1PcGIsbIzc9o9L/710PkFtpRLqYMa7gkNZM4D2xBm4YMZNsmBjHYXJLVPrOaZ49PTI+GkQjrPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473

On Mon, May 05, 2025 at 12:48:48PM -0300, Hiago De Franco wrote:
>From: Hiago De Franco <hiago.franco@toradex.com>
>
>Move imx_sc_get_pd_power() from pmdomain/imx/scu-pd.c to
>firmware/imx/misc.c and rename it to imx_sc_pm_get_resource_power_mode()
>to maintain the same naming logic with other functions in misc.c.
>
>This makes the API available for other use cases. For example,
>remoteproc/imx_rproc.c can now use this function to check the power mode
>of the remote core.

Better put this patch at the first I think.

To be simple, I think just export
imx_sc_get_pd_power in drivers/pmdomain/imx/scu-pd.c.
And add the function declaration in include/linux/firmware/imx/sci.h.

Not sure Ulf or Shawn is good with it.

Regards,
Peng

>
>Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
>---
> drivers/firmware/imx/misc.c           | 47 +++++++++++++++++++++++++++
> drivers/pmdomain/imx/scu-pd.c         | 29 ++++-------------
> include/linux/firmware/imx/svc/misc.h |  8 +++++
> 3 files changed, 62 insertions(+), 22 deletions(-)
>
>diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
>index d073cb3ce699..61fcb0066ec9 100644
>--- a/drivers/firmware/imx/misc.c
>+++ b/drivers/firmware/imx/misc.c
>@@ -37,6 +37,18 @@ struct imx_sc_msg_resp_misc_get_ctrl {
> 	u32 val;
> } __packed __aligned(4);
> 
>+struct imx_sc_msg_req_get_resource_power_mode {
>+	struct imx_sc_rpc_msg hdr;
>+	union {
>+		struct {
>+			u16 resource;
>+		} req;
>+		struct {
>+			u8 mode;
>+		} resp;
>+	} data;
>+} __packed __aligned(4);
>+
> /*
>  * This function sets a miscellaneous control value.
>  *
>@@ -135,3 +147,38 @@ int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> 	return imx_scu_call_rpc(ipc, &msg, true);
> }
> EXPORT_SYMBOL(imx_sc_pm_cpu_start);
>+
>+/*
>+ * This function gets the power mode from a given @resource
>+ *
>+ * @param[in]     ipc         IPC handle
>+ * @param[in]     resource    resource to check the power mode
>+ *
>+ * @return Returns < 0 for errors or the following for success:
>+ * IMX_SC_PM_PW_MODE_OFF  0	Power off
>+ * IMX_SC_PM_PW_MODE_STBY 1	Power in standby
>+ * IMX_SC_PM_PW_MODE_LP   2	Power in low-power
>+ * IMX_SC_PM_PW_MODE_ON   3	Power on
>+ *
>+ * These are defined under firmware/imx/svc/pm.h
>+ */
>+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource)
>+{
>+	struct imx_sc_msg_req_get_resource_power_mode msg;
>+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
>+	int ret;
>+
>+	hdr->ver = IMX_SC_RPC_VERSION;
>+	hdr->svc = IMX_SC_RPC_SVC_PM;
>+	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
>+	hdr->size = 2;
>+
>+	msg.data.req.resource = resource;
>+
>+	ret = imx_scu_call_rpc(ipc, &msg, true);
>+	if (ret)
>+		return ret;
>+
>+	return msg.data.resp.mode;
>+}
>+EXPORT_SYMBOL(imx_sc_pm_get_resource_power_mode);
>diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
>index 01d465d88f60..945f972e636f 100644
>--- a/drivers/pmdomain/imx/scu-pd.c
>+++ b/drivers/pmdomain/imx/scu-pd.c
>@@ -54,6 +54,7 @@
> #include <dt-bindings/firmware/imx/rsrc.h>
> #include <linux/console.h>
> #include <linux/firmware/imx/sci.h>
>+#include <linux/firmware/imx/svc/misc.h>
> #include <linux/firmware/imx/svc/rm.h>
> #include <linux/io.h>
> #include <linux/module.h>
>@@ -328,27 +329,6 @@ static void imx_sc_pd_get_console_rsrc(void)
> 	imx_con_rsrc = specs.args[0];
> }
> 
>-static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)
>-{
>-	struct imx_sc_msg_req_get_resource_power_mode msg;
>-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
>-	int ret;
>-
>-	hdr->ver = IMX_SC_RPC_VERSION;
>-	hdr->svc = IMX_SC_RPC_SVC_PM;
>-	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
>-	hdr->size = 2;
>-
>-	msg.data.req.resource = rsrc;
>-
>-	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
>-	if (ret)
>-		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>-			rsrc, ret);
>-
>-	return msg.data.resp.mode;
>-}
>-
> static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
> {
> 	struct imx_sc_msg_req_set_resource_power_mode msg;
>@@ -438,7 +418,12 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
> 	if (imx_con_rsrc == sc_pd->rsrc)
> 		sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
> 
>-	mode = imx_sc_get_pd_power(dev, pd_ranges->rsrc + idx);
>+	mode = imx_sc_pm_get_resource_power_mode(pm_ipc_handle,
>+						 pd_ranges->rsrc + idx);
>+	if (mode < 0)
>+		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>+			pd_ranges->rsrc + idx, mode);
>+
> 	if (mode == IMX_SC_PM_PW_MODE_ON)
> 		is_off = false;
> 	else
>diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
>index 760db08a67fc..376c800a88d0 100644
>--- a/include/linux/firmware/imx/svc/misc.h
>+++ b/include/linux/firmware/imx/svc/misc.h
>@@ -55,6 +55,8 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> 
> int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> 			bool enable, u64 phys_addr);
>+
>+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource);
> #else
> static inline int imx_sc_misc_set_control(struct imx_sc_ipc *ipc,
> 					  u32 resource, u8 ctrl, u32 val)
>@@ -73,5 +75,11 @@ static inline int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> {
> 	return -ENOTSUPP;
> }
>+
>+static inline int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc,
>+						    u32 resource)
>+{
>+	return -ENOTSUPP;
>+}
> #endif
> #endif /* _SC_MISC_API_H */
>-- 
>2.39.5
>

