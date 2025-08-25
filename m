Return-Path: <linux-pm+bounces-32969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4CFB3361D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 08:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8770C480419
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C626241139;
	Mon, 25 Aug 2025 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E0InJtVK"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AB1DAC95;
	Mon, 25 Aug 2025 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101845; cv=fail; b=VcoVe3rtVr+Zfzy/jrVvXv8ZX+/7vPayHFgM/r6+W1TBSZpB6KhL9t+AJmvwDpLmLTPyEgs4FyVG75uqIYyxQdpgdxjKi7uKoV2C0XK+FFMtyd8XZgqeu3n/M7KUb7BfjMjfuRJWMQVegPR74l2WH93KhiDPARKDovH2wYfZxX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101845; c=relaxed/simple;
	bh=Sr6J0TDUHCK4fF7DsjLAOMGJ+PyfkjZmY6/LaUaTkj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQribfZ/Ll58Z2U7FjVhJEfnnm6dc99zNcAyF+CHnOoM++PFZNHx2seBIkZqHZxxTRqWdwTdSrXFWDSRZqUTX+vVEuy+v3UiQUmAUUhsbIkWQn2S2K3r8f5sgSsk+Z+Xyt3mll/k+CavSgPuflbpWJ+FlZz+jCuylASy9Y6fw5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E0InJtVK; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEbmPm7CMyu65uUToYRJKveO2I7V7864fSjhxuFhA8/BsCuhV/OtAvcdYoeKDA7W0A12MA8qEBpOwYjEzVLAv1yURXW0lVT1XOrXtFivlpxgYYMv9XfrRVC7qUEHfMRyqn9geKkmHsgleqelgnAm6EPFtKyjgjmwPwk0pFUjgJoPPpndMsE43bLSmxCZliFKyxXpKw+sVtZrvR3XwgnPmLnD0luGK2cik76c4Co400A+Ow7CIiP71sgAD77k5pi/C4ljdU7XP7KKy9vXCy4FV8rUFTRCeA6GoqwQl64U9QgiZcHeJj6vUHGo6t++OFwlFP7qIySWVlD2uruinrOtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNHi31K/K7LDGIuu5u2E8UVAtTmA8s5j6bd82sa8Juk=;
 b=EBo4Xf0pBgMguRExUud1tRkXFtinH9kD3C92WqmS7oJNXDg8zBTqZzDpZrn/jnVazevQ703znzMDrDUWa3PI84BQKec7NPouiJ2s7SWYrIKKe7I3UYu0IDxLePy4/W7xTSMMDr9vvzLyaH+nbH9nievbnO7LHbdlkrH2puDPrZpg6PKqv1xzNS47X1+yZxXcd8dOA3mqM01VDf5eXFLVBasbJPAIhyB6nRwek7IKwucaf66rQoN/UynpsS9vIku+58o9gLEP/5PN0CHMlOfrgU5boynV56rH6MiznaYrRIsrf1g7zYd5B7CwK6F4p+9/FaFgX/ufKFWf4RycNR2nqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNHi31K/K7LDGIuu5u2E8UVAtTmA8s5j6bd82sa8Juk=;
 b=E0InJtVKZZFBfgmLhshInRydQ8xljaDEATm47EnCjPJhuidm8k/cDwll2kn0vQNEwQ6oi0LrXCOdaxrqMzC8MKEaPz8rmcMWOwQTzgUWxH7U2pb+sRZKcVmgorJYYgMc5cHWwnR0+3kMyRLr9B1IZq07WRnSSDmAvVWI5vOhQr41IM80O8KbXVcq5dhA02pjXbKdSYeomrCEG0BH9LN1hKv0T8scqQOHEviwlYOFenA3FosFgf1q9FpwDBcehJnA46xpNYneya62S1YhgTolN1uzRO/pqKKcYr06w8VBTbVTBZNi7hVYUmcxjD5cDdTv7g8iLgTOS1Cn5y/1hkNlAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8130.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 06:04:00 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 06:04:00 +0000
Date: Mon, 25 Aug 2025 13:58:18 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, jun.li@nxp.com, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	imx@lists.linux.dev, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] usb: chipidea: ci_hdrc_imx: Set out of band
 wakeup for i.MX95
Message-ID: <xvqcdtgjvriypwcq26lbku5pgfha7idxing5ep6if552whv6pr@7fkgqkgrxpow>
References: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
 <20250801-pm-v2-2-97c8fb2a433c@nxp.com>
 <zdzpddjjdj2ezkkfh5jjnnjvkvu4gb6vqmhkdlnnc2ioamvcuk@ftmezbyxrhfb>
 <20250819162133.GA18601@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819162133.GA18601@nxa18884-linux.ap.freescale.net>
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM9PR04MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb02dfd-f689-41d9-335f-08dde39d2ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EF2jtWmZtzgQUb4lnX51eKXvysPwhKB60+ri5dMO8mJLMdmmlzcpsujI0ITa?=
 =?us-ascii?Q?i3RzNyWA5ZJi0UO3iZD4m2IYu5PuJ0/5mGbEHpngZ/rrEtfnThrC6HfHT+bJ?=
 =?us-ascii?Q?jYmKiWXU057LqJm48cL6jpjwzkACphlRSQrBn4FEEtbSJ12QjjkhtO+DYLFt?=
 =?us-ascii?Q?POsU1r/U4yEVtOlOoUWZOadwQkeb4Ws4CS7zegs6dJ1BxzW5qfWGlLF8+2du?=
 =?us-ascii?Q?QT8gehTLJqGfeONzUQYt3xZC73DbyeOqJ8oQQm40JXa881itKuEb5HYWKbyX?=
 =?us-ascii?Q?etk0JRKgU7w4HnKCuluX4OrgN445NmUn/CqWov4bxfgInlja5+MPMqpG7vff?=
 =?us-ascii?Q?1JoQ6O62YX8RfzAjYUo4iE8bMUAr45gmPoL8JEfGT23AkQje2Yus+3qSrWKm?=
 =?us-ascii?Q?0fn61UrIn5jXBIvrxYl/PCA9syV4XTeMyN39iyZz9UXWat7PwiRKnlocZk4S?=
 =?us-ascii?Q?gxeJfsXdN7oGlicbL58UH2cXb5Bqh1RCw7ZOfl5kYyMb+lnkz+x4S1bo95pz?=
 =?us-ascii?Q?wTA7pAq0mqiMHHDguKecHxGneGoYYQ3+Wr/QMaKDVJBLi5+Fa4d0OZFDpweW?=
 =?us-ascii?Q?7vAdZm7e4Uvt5kmeQb8+j9gcjp+jV3DQThRJEwLRo54kqtdZmj8ROadOWP81?=
 =?us-ascii?Q?TywDW6CSmbbW+abLaeRUQiMc3s5q4EJuGRIyjYQNQ6mFDflCosxQ+WSppwNp?=
 =?us-ascii?Q?q33gw2Lcm8yyYp2tY/f52MrA9RS2qRz8uQAir4uOJk62jAw4efb+gbDdfK54?=
 =?us-ascii?Q?xgAiA/dBz0Qo51K5CJ8eXwVWguHFhxCJ8s6d9IkVNckM3pclrQ+K+WTRwFY/?=
 =?us-ascii?Q?1XZen8vHvG8b8JOy5XIgpnmAcwnl91XjCQHvuHwU4reoXqtmlBJmONcpm0hU?=
 =?us-ascii?Q?dAIk0ndEvNe5qFmWRQoMUVsmDAd1gIP0UZVMAlnUrB+HBVJZKxY9X4Pym76g?=
 =?us-ascii?Q?r/eC0V4r4g17v98O23YjqmbTnQsWSXPH4AXb/HA1YPaLb4EuBjO4eH7LEVt1?=
 =?us-ascii?Q?3JXvO98rDhoCaZY+t5OLpU/+oOxjzTP1/Fe3GzOCB0bbUDVKi5lgHe3KaN5f?=
 =?us-ascii?Q?eXkDQrcAgBw7PM54XuNwg8L8id+YB0Rx/GZozafSvu7t33WpQxeA2UZgnr5p?=
 =?us-ascii?Q?AvKk2fgUjOL8fBnWc8BfCN9EL1vdGOMApI2RLZBOFPOWB9mymZGLDRWTiiQF?=
 =?us-ascii?Q?hTE5++599x6TEHQqgaQA85OG+M/aatrwsBcp17Ktk3kEyeQ6Sd5CxeSiBC/z?=
 =?us-ascii?Q?JwkrJEFiXONb11Bnnkq4BN0CkzjCN9NPkK4U7eSMg/OovO/B7ZCPpQjQcH1A?=
 =?us-ascii?Q?gk3lRHhr5TklLwfODimQamxxRuQCsFHecosNIvCtNOclBXz4KdFbxJMPytA6?=
 =?us-ascii?Q?Q2LwKUUD4dg/bE4mJ45S1iu33EAPm1G/QJ/sOqffFoNIdOdDGQ8U6e6nyA98?=
 =?us-ascii?Q?Fwh0DEvcviNKUy9RztX2J9XXo/96e1Q1i+Oij8E6p4mztgQijAqcrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R6S5Svk1/MhUgPp6DGuPCKfy0YLv/AfRYNDDshZMnjKvKg8fi/fi53cvxZKm?=
 =?us-ascii?Q?jGeum6+xK2wcvJPteGO1uVVqGm4d3qvqry+PpUxJ9RlS+3L71DQU8pWMu4BH?=
 =?us-ascii?Q?8pwEzK5oGMrOcrWA7ekyGIDUNnI0fcixOUrZqA/OV4OgHi0FvYhwA3NstVMu?=
 =?us-ascii?Q?ZgB1+zxkYD2G8j2oAqso+HC8+cLmWSn6/cR0Nyzds5WPzDGzx14QFFojcfJm?=
 =?us-ascii?Q?Dgfq0kmPufwvv/0uKv3a1dnYoIqRyxOthQo1d1kHawYTfA8i//Tnl2Ro3ncO?=
 =?us-ascii?Q?9345HC+54mTOnzQor8a25+h2SMlyC5J7hTUzCdvaPKfZ8ohHNQbJXmK/5YP5?=
 =?us-ascii?Q?4oChoMhkDuBXsNMRicxXEItZaIOy5oD9TCokZIaoFMpty9wj1zlDH+7oO+zw?=
 =?us-ascii?Q?dCFwPowXqsrO4pNsHepqC3dLWAo+QKpiGF6tay8N7tgvkHwibA19YzbICE6B?=
 =?us-ascii?Q?7PhhxBQjk/8bueN0MNvUD8WDjLQcSQjXOMaGlQhF5FR+nqpwHL0F3wHAxsi/?=
 =?us-ascii?Q?YaINqe5jgYoAh1Vdkk2q66rEQY4qlmwniY7WEjObm3RNo/NV1RLm3XfQcdtO?=
 =?us-ascii?Q?EJHSCuIXf0RSmpAMfZj1jv52fNIB1bCl1kyqbwkMKU238axlt6IR2QoGJYI2?=
 =?us-ascii?Q?YxYj0jDdkv35S37Ukodmf4C/hO1VGGzJvrBcxV+D7sVgH+9fsDnBv1JcsONK?=
 =?us-ascii?Q?jdBTJ9m9e259MVHbZDBAHN3y3FMpmW8GSW9OreT2Ja1DgGEdYCUNgJe2gZ7D?=
 =?us-ascii?Q?delFTbVXUGSdkwYwFMRKqUfFTVPYI1zeDXIpKVw8nvmphW4cWAfqiM8Q14Ud?=
 =?us-ascii?Q?73J39BU9d2oXcDlptzYsoowVeGhqgBfM5l7oRtDyhLkBC2HGEJZX9e8NjcXw?=
 =?us-ascii?Q?fTySyEtKdY1bfyzuq/rv/4KLmTJUCMqw/yzUNYpNirApRr9cSfhPj21n5iRx?=
 =?us-ascii?Q?XuNAVW5qA4k6x2fbTnAkDNnPsbncTFGG0iTPEeONXUpiJuFOsUWgywqoljos?=
 =?us-ascii?Q?joDEfWMuJsI6E9iUcs9HH3pgyEjHcbmGD/Q5gbut0oW2BZPszDGoxz5B73D8?=
 =?us-ascii?Q?Luu2M5OqBFZRajtf4VW3LTnzOtYaBcaNQaF27JBoCD/TnL+tbZip7uJCsY1z?=
 =?us-ascii?Q?IdphXjKlmvntc9c0TyP008BmR4SnPGGHZCxn8f9Y2+BaAloFrAvn3KXwsUXj?=
 =?us-ascii?Q?1dnnkLNI0+Qmid2wSXdbNB1NxlRwHoFeHjeXFc+2in9Phemu0kCrJQlV++rL?=
 =?us-ascii?Q?UumRDyHsyDm8PqT1Or0aG9OQeLgGBFbMmc1VhnDhNyZhfaIQ0B/LJoNCysNi?=
 =?us-ascii?Q?FUM8Njdb4TBg9r+zQOGdOGbiEwJAhCyXHs155V5Uox+frbHB2f+L1Y7tS+8c?=
 =?us-ascii?Q?QmoJ+DDm4TGHWF+GXdtUsESyc+gmlO54YAKeydW1whAAyPCEg+OJlDTFxp6+?=
 =?us-ascii?Q?OHWgrTPa+eobqmBOEa0KzfuWXVnGYm+5dGpNZpD8IIKzyRjTuCyaOiXqkNf2?=
 =?us-ascii?Q?0LKaQXC1XPxS7i3aNYStBVjKcoa1TisV2FDJz0uqK4D4CO+spLGrS5VjC+OK?=
 =?us-ascii?Q?4SyBFizRvRBr3d+yZYcvp2T6N5tntaVdD25H5ulX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb02dfd-f689-41d9-335f-08dde39d2ea9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:03:59.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzPmaik0pyD2WCOY+fteiobojlnk76ck3iS/RgugFK7TLdWTgugxD7soGAV4Ot4tj9z9tTgJqcuscqVsbV3Xbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8130

On Wed, Aug 20, 2025 at 12:21:33AM +0800, Peng Fan wrote:
> On Wed, Aug 06, 2025 at 05:28:08PM +0800, Xu Yang wrote:
> >Hi Peng,
> >
> >On Fri, Aug 01, 2025 at 12:34:23PM +0800, Peng Fan wrote:
> >> i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
> >> power domain(Digital logic) is off. There is still always on logic
> >> have the wakeup capability which is out band wakeup capbility.
> >> 
> >> So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
> >> wakeup system even if HSIOMIX power domain is in off state.
> >> 
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  drivers/usb/chipidea/ci_hdrc_imx.c | 8 ++++++++
> >>  include/linux/usb/chipidea.h       | 1 +
> >>  2 files changed, 9 insertions(+)
> >> 
> >> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> >> index e1ec9b38f5b9ba0568101b51fbf16b99461b6ee2..7a3360d8a0fd065394393de829108a12c27c85b9 100644
> >> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> >> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> >> @@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
> >>  		CI_HDRC_HAS_PORTSC_PEC_MISSED,
> >>  };
> >>  
> >> +static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
> >> +	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
> >> +};
> >> +
> >>  static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
> >>  	.flags = CI_HDRC_DISABLE_HOST_STREAMING,
> >>  };
> >> @@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
> >>  	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
> >>  	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
> >>  	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
> >> +	{ .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
> >>  	{ .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
> >>  	{ /* sentinel */ }
> >>  };
> >> @@ -569,6 +574,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> >>  
> >>  	device_set_wakeup_capable(dev, true);
> >>  
> >> +	if (pdata.flags & CI_HDRC_OUT_BAND_WAKEUP)
> >> +		device_set_out_band_wakeup(dev, true);
> >> +
> >
> >In current design, ci_hdrc_imx_probe() will create another platform
> >device B which will be a child of current device A. Furthermore, device
> >A and device B will attached to a same power domain. In this case, some
> >conflict setting may happen. For example, if the user wants to enable
> >wakeup for this USB port, they may echo "enabled" to wakeup file for
> >both device A and device B as before. As a result, device A is out
> >band wakeup so it doesn't depend on power domain on, but device B has
> >also enabled wakeup so the power domain will keep on finally. Actually,
> >the power domain needs to be off for imx95.
> >
> >So I think only letting the parent device A itself attach to power domain
> >should be enough. If it's the right way, then below change needs to be
> >included to avoid potential misbehavior.
> 
> Thanks for looking into this.
> Just detaching the power domain may break others. I think the better one
> should be:
> 
> if (device_get_out_band_wakeup(dev))
> 	device_set_out_band_wakeup(&pdev->dev);

I don't prefer such way. Firstly, The irq of pdev->dev is totally a in-band
interrupt. This will mislead the users. Secondly, it won't take effect if
call device_set_out_band_wakeup() in ci_hdrc_add_device() because the dev
hasn't set out-band wakeup yet.

Thanks,
Xu Yang

> 
> Regards,
> Peng
> >
> >diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> >index 694b4a8e4e1d..c2ca81fe5e09 100644
> >--- a/drivers/usb/chipidea/core.c
> >+++ b/drivers/usb/chipidea/core.c
> >@@ -915,6 +915,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
> >        if (ret)
> >                goto err;
> >
> >+       dev_pm_domain_detach(&pdev->dev, false);
> 
> I think the 
> 
> >+
> >        return pdev;
> >
> >Thanks,
> >Xu Yang
> >
> >>  	return 0;
> >>  
> >>  disable_device:
> >> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> >> index e17ebeee24e3ecc4b1c2d153d9ea9b656b5a3d35..c6451191d2de68607a9380482701d11f949d0ff7 100644
> >> --- a/include/linux/usb/chipidea.h
> >> +++ b/include/linux/usb/chipidea.h
> >> @@ -66,6 +66,7 @@ struct ci_hdrc_platform_data {
> >>  #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
> >>  #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
> >>  #define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
> >> +#define	CI_HDRC_OUT_BAND_WAKEUP		BIT(20)
> >>  	enum usb_dr_mode	dr_mode;
> >>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
> >>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
> >> 
> >> -- 
> >> 2.37.1
> >> 

