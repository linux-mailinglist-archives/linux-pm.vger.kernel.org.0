Return-Path: <linux-pm+bounces-23428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E44A4E67A
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4ADA4612E0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DF27E1BA;
	Tue,  4 Mar 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q9I8MzHk"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440ED25E83F;
	Tue,  4 Mar 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104750; cv=fail; b=F4r6Ta6FQayhz93Pq1NnuEHZ1oADU0Q2AAWHyNcRhkByug0vE3f2syVHTocCP+SYfUMuTSBsUXKk6JoKRppYwvyKq69ah26ycUZvEtzlaytjgzdyJJv/tVhAqk3ubXNeTxX0RLrTRz2yKqV6zrioHIORxGRQ++IJklDWXoPu02k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104750; c=relaxed/simple;
	bh=Dql1gNW+4Vsdb1X2fQAC+lj8MIJW6b2JO9V28Q1R2iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jaDRtXGr3xgA8MHHxuyWX0GY8DKkKcyKMYLcIX2BOAzcpp8IqqxrFGtaKXATpqv6g1bDuFYqE8yCjJa6PBfFfwiqQexwEeXrJBOJqB5DpNtkjP4H7ipJYDrgIYhGmdvWgc/c7LHs6vaNeNJzht8E2hOXolcM3XzR7YfivASUwBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q9I8MzHk; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq3KUzQac/NvH3FvYaFMAsJuAw3iEAkrFgNtWstpac02m5RFvdCvbSXqbxJBGLdE+CoqSa1WbnlruXtOc8/EWMFxN7ruqUpXKLVtsSUlZKposNG4zbgrSM1phFYKKIstUTHqnvIOwTyrxQ+HomcSUIHBmwjcIcz9JrBEzLfkqHMWWym/c29KvclsgdTuRO66ew8l4iTMyU+qxQyLnYV8TwePH/zmCIZnOvaLGo6f/aSO0sfcP7DMmX3ExnlvAvJ8jyxqkpevmw0wWQevMZRNfG3j5JIrONATFWaqhwc54hJ3LHxHsQkvbAn5YJN2Agj4CTxhl7fkG8qurk3g87SSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBd8p6NfIsOW2RjydclPSodqc1gbut/ikdq1LSSRz3g=;
 b=YCXOcr9iK/iM9Zm+kci4UG3BOsR6jCJZfeMGmVLBm+6Hl5W9gu0n5UviZE9mfJz/mhu5bHYcArxv79H/zWcjw6B3hXHMGcgWEkMW/+IYAFtlkSotabCrlmeHgLdlcMvO2FX/En0RVDIYz4FhrTsEmid1DEOcvPivVSTutyjdYCVy7VI7z6gcDrizOg+u7PJS08ldLKmGx2PqgZPBNheJjn0vOXrFo9HJHTnfOyIOQYlfDESgc/5fLBnnD3E9OY9SzyKvN1G2PVqkCTng5w+Onms7kymNMB2Y8bL8GG3VzpoRD+NPjb3tqLAgs7YqWIpunLtHmvdL5YaXSAPgPI35hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBd8p6NfIsOW2RjydclPSodqc1gbut/ikdq1LSSRz3g=;
 b=Q9I8MzHkIBydFCqv1Pi9/5trEtG/4IGbgwdsESbd5FFHLviMfiP818WmFgHz+rnFEvaSdOLNqeBC0RxYdiqdbu5OGNgqB8JZPePgdzNsNBgRVfbr+xvxc3k9qsJH5MekzDrOd6mMuVB5Rh6HurU6qMJS2+nDMNJg0gNT5b53MbgPfuTK7+3BsqA2NTPEwN+FCeTqO7u+PedBpowi/kldvjSwC91aqnLE4kQGHDwGXEYG4gnvxsHzsZZrm2gS7kfy7Vazx0sDOvsC79vcjp8QWd/zw75FUU4aR6n65irWmMrbA8j71ODIU1+CqpgaMTwlxmXCRoGi/KqTFl9RanBmhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9369.eurprd04.prod.outlook.com (2603:10a6:10:358::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 16:12:24 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:12:24 +0000
Date: Tue, 4 Mar 2025 11:12:12 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] arm64: dts: tqma9352-mba93xxla: Add LVDS overlay
Message-ID: <Z8cmXP22SXtXjNw3@lizhi-Precision-Tower-5810>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-6-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154929.1785200-6-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: 30178445-1605-4e20-dbf5-08dd5b375960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l50xa8i59L1nbgNWz5nmZiAgSJDcPpTpO1ayqq0n9+TTnr2j5TkHWEtOz4D5?=
 =?us-ascii?Q?an5iaTtYQnAVZ38Vypny7EuAn3NZ4pe42n2D53LkIJ0hYD7Qj0ZrT9qmXRr7?=
 =?us-ascii?Q?h+HbZMtFKJvnt//7xxogGoqPqbLlEgB3B7t18vb9wDiQXTBErScSQPy/l3wV?=
 =?us-ascii?Q?jMCMZbEvT9Z4+VDxCe1VHWRjQHCes8U7f9DBt7FubGyoqf/0jSWPcIqtawm0?=
 =?us-ascii?Q?ZGb0gyE7JPkDiy346g1JneLo9FuYtkTn6EDHCm4FhMwlcXk3gyH8rmGG/Zrl?=
 =?us-ascii?Q?eVfLVvYQ5mMYvsY5XwQp8Ze9zqO3hVpK0ZTSwOkqLlYa6ukJKK9BDkabwDEp?=
 =?us-ascii?Q?MEclBAEwIXgObU+zrxCtavOi4mCOdCWBCSX/DpX8a++A9VwZeNSKFx5fXyfv?=
 =?us-ascii?Q?hzuNC1X1CartHlKeHIBLLyauVkYNAiUQikovDXp58cdto0KOGUOBs3I+YJer?=
 =?us-ascii?Q?73MHaId3Hggb4GuMP2HCQITiE9wDujCS4d7t7Jv5Jp2PFQc1ntVecPsteanY?=
 =?us-ascii?Q?MXxVjx07uU4bfg9cZ0IZxzPf7gM3gEh2zKjHbHG2WkjtR79hwwcjhQxaca1y?=
 =?us-ascii?Q?qV8h0G39Is02/JoxGyZ+OP1i34apOiALUBJXo3Ondi5ybF7A0y16ngBUytny?=
 =?us-ascii?Q?/PT26XPd4T0mTCvEQJXZP+o1pXu6IhirXG1lUo7J60vh29IGo5RcBH6U1AEs?=
 =?us-ascii?Q?WfKhc2MHYvCWpi321vmMlpbSa1GzOAtSyigpp7hLhinOve074jQb/6rTIzlF?=
 =?us-ascii?Q?DhMgxkOa7/nQMIHfJJ3MqpRPSwq7kC1XhInd8q4WcaFIsMqfQfqxq7corPZC?=
 =?us-ascii?Q?VhblD74BOD1r60NRVCP8p74zVuQAIcAcnbg79W4o/uTmisutwUa0ebz5RJph?=
 =?us-ascii?Q?81apzfp82PJctSB7gfWgRpHGCsjU1OovOSmAZRv1Dtc16IHutnHKH1HtkrOo?=
 =?us-ascii?Q?OilCtbFX1eyarxYQdPh/aTni7V4RlmcRBZqHpFbyAYp30H9L+j9JIQe7Ekaa?=
 =?us-ascii?Q?/VIrzu6Uqcw3jrRb744MIBFOTsX7ro5vPMIMfWpGSIUtf7er5kRG/x5QYKnU?=
 =?us-ascii?Q?jHeKPdvxEQrypaiewd3HdqI8aUCY1swUwhb6N8J0RH8Ibh77w8efciyygVDA?=
 =?us-ascii?Q?RuC83Dbb8IaELv2u8MiN4IPs7me9uT+cC15nsKk6YIcMRcbwQfyI9SYdukok?=
 =?us-ascii?Q?Q82tLVLvEknHfydXS4OeSSZMEyHn69WMzOiYIELqL/dGCja7AIgsq5HUHsUo?=
 =?us-ascii?Q?SrvJqdiSWnO8GBGMfEx5JK5Y1zMWBwhqJxQnJH2tDf8pCAsNocLXEU+TWHm7?=
 =?us-ascii?Q?gv+dT8RzbrmkBUS7Ez3KZ7szLs15dVNy1ZDew+43KQy1uIEeNAUNK4SxRnjG?=
 =?us-ascii?Q?V8U+9H9TSGqiDU98lb+5GtrX+EP5Su4vluPRXShX5FCVLB/5eLnFgDj/68RG?=
 =?us-ascii?Q?mAOlh+6fV0CkGmXUNHqw15q7Dmi4hPbO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RRf1dQRZ22rMf5PuOH8DBqWw2gN3qxTuLH3aMX2fL68YZB7wZjzPC8BIMQcp?=
 =?us-ascii?Q?k470LjvbIRvPYYSlzH6uGvan+FvRCLRO6AmucQ+uaIxSDuWAOnWqGrmy4ZbX?=
 =?us-ascii?Q?yWLKJrbVt9d/wlgpZI/4QAoNjWc9qsO4VYQuLxyMHeK9pdI5CVx1ek/QznoI?=
 =?us-ascii?Q?LWrHJqWAsMmJeAaqvNjpez6CK20AUgqCjAz4yBEmnU1XHCIBYukqO3fqsIX6?=
 =?us-ascii?Q?vG0ncP8L0vHfBi6bW4t2/9vZdZtVQZntXZn5ycHnbjRtz+y7QKeuN4iZvlY1?=
 =?us-ascii?Q?9I5/WgT6nigMlslbeEIilOswVR+WfrgNPZXmo/iA4EhO4JfQjRIlqx5hZZvA?=
 =?us-ascii?Q?VwS549behG3DC/hE/Lxnh37BLRpOl+LoGXN8eyFzCFuegv46mgI9hqFLPPp8?=
 =?us-ascii?Q?D5NHilZbcwSAJJ00P9Dch2EY/M8Mp5hW+hhv5cdHrbP1cdh4f/I7MT2H4cNR?=
 =?us-ascii?Q?JiE3BWxQ+ges+trFB0EXVNaqhIAA4Ta2NLdsd2b5XqgQGOzuB6PaO28S49i1?=
 =?us-ascii?Q?/GaX9rRZUtpa8WcWO9bZRP6M8auW8UbZpkDmIhty69V8pgnhJtoblB7GyvDk?=
 =?us-ascii?Q?ziV0EC77AOS2iE7aOg0bMk7ZHaN3g2lLMyuom6/KlI6kVCtjslO1ZhnUGctT?=
 =?us-ascii?Q?q7xl1rdPBxu50bH/JMQ45TIMMDLKmbfQ/78nkYWX926ZbKid4bpgU3xkbsEW?=
 =?us-ascii?Q?Hme/9tTEX2efmb8jyWCC7ULx94Sv1sDGAYeYfof0iwilkXA7Al1wrGFgPfc9?=
 =?us-ascii?Q?4+M+sWhWPo8h7aonJpZE8NIyuJgknPyI5eMFo11SkeTe2EO4e5FWkzS3sp/Q?=
 =?us-ascii?Q?n7jvnwK+Qel+KDV3WYbJOkC77m4zJ5WEENXLckovI1kUNhJmiDHAmbq6CspE?=
 =?us-ascii?Q?jnOklxHuG1J98Cz0W1+klHRy94u/WdAPZN75PPIPzANxsaC2D9CUTvt9lnaf?=
 =?us-ascii?Q?MJDxtX488FUVqq0H/WFiChEDy8tU08i9xExL+2HaX5NjpvriWdFCM90T+LNx?=
 =?us-ascii?Q?AXN6ie7LofjT7cb3pWZ5O5NpSgQPIY5UXJxo3OCOhjyGYTONUq0LbMJoP8j5?=
 =?us-ascii?Q?s46WNsdFdiVoLKmjFZDZhqUZJjk+BPfbbA7EwgZ0E6fLWdKTasL7KP4Vz9IQ?=
 =?us-ascii?Q?dT3aYtlLEkzh/USRvhZTM+6IeylmtflZ5fpogxWV72iXTfh8s/XNGK85qPv4?=
 =?us-ascii?Q?HLEVq+JoLbUkxWHr4n2Vv/n1o/heQzAxN9yxi/JQa2lFpzZZGebhG6fe93mj?=
 =?us-ascii?Q?3N78FyBBt86ytpexAn5CGaTW8vddiKSD3lpcfzu/YIhPFZhYVJUVlmiT9Jhs?=
 =?us-ascii?Q?P22umVPBBTTKhQDsLuw51uNHPOnO/19DhdqUGUPX0wxogcwd242zs17sLr8/?=
 =?us-ascii?Q?iGs7sla9UmZ3FJQqtS9sS8YCiDFuPCtrExga0XKreyWNBVDlKC2UcTGcjqsV?=
 =?us-ascii?Q?OfXMhtqfJPsdWBkFIpe6dRdN7qPLemos5KZcNhk9fomw83xCuvS0c6ZU88ff?=
 =?us-ascii?Q?CtmU5JQvGuBZdfCCYnXesS+to68XH9Y6afO3iWO56lTH0yYXIMqcbFVqRwfn?=
 =?us-ascii?Q?lXcj5IQ2osELbux1bZ3Scv1stLZOp0Q4Dq4r58XY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30178445-1605-4e20-dbf5-08dd5b375960
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:12:24.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+zXRYCsgTuW/6Nik3SRTJhXO3ej+l9zt+JoqOR4HhDabIpes+DL38K5TPQrlBERbtpWGtxBWKif/KQSh22H7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9369

On Tue, Mar 04, 2025 at 04:49:24PM +0100, Alexander Stein wrote:
> This adds the overlay for the Tianma TM070JVHG33 LVDS display.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  3 ++
>  ...3-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso | 40 +++++++++++++++++++
>  .../freescale/imx93-tqma9352-mba93xxla.dts    | 27 +++++++++++++
>  3 files changed, 70 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index be6ef4c56fbf4..ac4f14c69cdd8 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -300,6 +300,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>
> +imx93-tqma9352-mba93xxla-lvds-tm070jvhg33-dtbs += imx93-tqma9352-mba93xxla.dtb imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtbo
> +dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtb
> +
>  imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
>
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso
> new file mode 100644
> index 0000000000000..c723a19f03d63
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtso
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +/*
> + * Copyright (c) 2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
> + * D-82229 Seefeld, Germany.
> + * Author: Alexander Stein
> + */
> +
> +#include <dt-bindings/clock/imx93-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&backlight_lvds {
> +	status = "okay";
> +};
> +
> +&display {
> +	compatible = "tianma,tm070jvhg33";
> +	status = "okay";
> +};
> +
> +&lcdif {
> +	assigned-clocks = <&clk IMX93_CLK_VIDEO_PLL>,
> +			  <&clk IMX93_CLK_MEDIA_DISP_PIX>;
> +	assigned-clock-rates = <477400000>;
> +	status = "okay";
> +};
> +
> +&lvds_bridge {
> +	status = "okay";
> +};
> +
> +&media_blk_ctrl {
> +	status = "okay";
> +};
> +
> +&tpm5 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> index 9e88c42c3d170..4618f836345fc 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> @@ -48,6 +48,23 @@ clk_dp: clk-dp {
>  		clock-frequency = <26000000>;
>  	};
>
> +	display: display {
> +		/*
> +		 * Display is not fixed, so compatible has to be added from
> +		 * DT overlay
> +		 */
> +		power-supply = <&reg_3v3>;
> +		enable-gpios = <&expander2 1 GPIO_ACTIVE_HIGH>;
> +		backlight = <&backlight_lvds>;
> +		status = "disabled";
> +
> +		port {
> +			panel_in_lvds0: endpoint {
> +				remote-endpoint = <&ldb_lvds>;
> +			};
> +		};
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		autorepeat;
> @@ -509,6 +526,16 @@ &lpuart8 {
>  	status = "okay";
>  };
>
> +&lvds_bridge {
> +	ports {
> +		port@1 {
> +			ldb_lvds: endpoint {
> +				remote-endpoint = <&panel_in_lvds0>;
> +			};
> +		};
> +	};
> +};
> +
>  &pcf85063 {
>  	/* RTC_EVENT# from SoM is connected on mainboard */
>  	pinctrl-names = "default";
> --
> 2.43.0
>

