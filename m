Return-Path: <linux-pm+bounces-20820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9E2A19827
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 19:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21466188D345
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101C2153F9;
	Wed, 22 Jan 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAcqfjGe"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53492153D6;
	Wed, 22 Jan 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737568809; cv=fail; b=LwCH9F2xZLba/zrZFRQf1b8LcB/1g3zvQKNRE0AjnZQ6L8ZavrsXHSdsdhOeLhYwuGh3smByANize2M+uQbbPTC1K3rVXxFj2MCTCYfG+ZGdvx2poMg8JkIJgWEWsogbTUQVldjZCy5VCv7GoqNU+m/UwMfOUZGzCI2C3ULi8fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737568809; c=relaxed/simple;
	bh=V31ksGrbR3BVzJi3KtkHdXLIyuoBMIyIpw9F/Oewg6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Df4a+FwAYPRBdmAFTzXAdsTQWibIGHyfHlDOIPSAkySMRjM5od4kiJtvzyetZHZ6xfqsp7agf+sc9H8at6gOeRZLH+E/BCujBK8/mRvKg2m5Um1cmTFViZctW3wi4DDdFsxRJp6XtfmFQhbE/Jx3GzCFeeAPot+QJ1X5zw5kBwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CAcqfjGe; arc=fail smtp.client-ip=40.107.241.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9CRXvPCBUF0axpExIPiioYbnhCnBTrpKCF9R0yA0+CUucJ8Ubm0bTwVUkpjKbkSSzntyG42GS+DuNAETI7p2nUlblxsvdSix/UbS+LYVJTSgYkAWCoJTgiiyWDepkMq5B3Ss87vwXfwJE8jnIYu9wNtkddQTfXxxTVIyGpF+f3AMzgpFqA/KQ+HN/erm7Al4Qnv+ueyHUV/xTDdn+2QMGv8lncqdNDHyvFL3KQa4hhT5USu8DbwH+TSAz3536taeh0Ae6VjjOmfkgycJNLMfCVDy7e+Vm6MW9UCjOn1R3dAO4vsDuHZAogX7vA/rxGy6z6egdDVm8upZ9zrK+V0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huBkoIUw/u/Khws61ncIncFVaNCii9Ts7qZuOrXvjA4=;
 b=yKLYvFYmxJcpz+uWmxlE8QuidHG6PK7XzHRBVEn80AfTVJCjszEueAsOGAqI6f31siVcUlSMeUweL5qHhgO4Zo8VdZbXAEd3L5tdsGnW6cfhDTumjqDvzkFmXKqS+adNGR0g25w0Poh4GFL5ucFve2VLDo7REh5C2Q++qqRYh1M3aaJDSpRCrEEKK4cqxmdJte3nsHhrbB3C0LI30AHIDZiOTXMnyN/oE9es2ez5sd3rWQmFnBx5QklioXIOS/FCnkIs17E4U8oxsvnlVDMTfeetaYV8eLCGj+hvOLPDL3dB8693lICK/zWAJmBluptlYl7dyqKqi/BAfzGL0U04rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huBkoIUw/u/Khws61ncIncFVaNCii9Ts7qZuOrXvjA4=;
 b=CAcqfjGeMhw2CIomDDHJnBv/TnhaRNfFKO2HxQGRSr/LmXS/4rxSPFA0rdZEwgQh5ojicdqFufQK+0v8YJSAbcX/ojLl52Qd9n/7PYQvBambrFgO8itfA94udE2Abnwen6gF1TcXeGm8LbFGziLiEX4nKnWp8bCUM71kJ9CW7nvqqhtqde8fEYdvYDTtvgi/tiWpi27Iy9tibcX1Dnnx+JQtjwxghTPbJbojC+wqznMFsnHIPn6lUy5yskSFLXWGE2gYm0zmPCvyJElKd72anBIQvVdiTbGeyWXZLrPrDknWS6IWFHUtsJCaRLVxX0pDBm0sw+cXCZnyp02DoneNfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 18:00:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 18:00:03 +0000
Date: Wed, 22 Jan 2025 12:59:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 0/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <Z5EyGZubxc2OpyT7@lizhi-Precision-Tower-5810>
References: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ae1f42-1a66-444d-3008-08dd3b0e98a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hl666xLP4BaPBqLV4yAMNq6u7LMn6nDpVfdDB8YGPvHO2/OZTRca2NnXma1F?=
 =?us-ascii?Q?jOxi6PPjiYG73Ric3cJpEwNlLVWDxHBkYMvn1tY+yrncnNTauIrFf3h9wUrr?=
 =?us-ascii?Q?LcTuGLaPpfrIMvXENYExrf1qYQlxH8pf9/hx0Xa0SUWMwKO6/WHYgVu+kdPO?=
 =?us-ascii?Q?qkpqeBiz5+yFD3BR8g24+4RjO7ais3gcya0kZAyQF20uQqv4oQ+t8s/FnH6Z?=
 =?us-ascii?Q?MqY3o2IUQHoZIvPLfuv+I2tJGx4ah0A78ZlViAW17NRXLZGPCjcf1SIUOEsB?=
 =?us-ascii?Q?xBtDaZf6ku6GEqcSwpc9p1ZSSlzhFm12tf/7FgQbyxAce/FTQ4mlR7JgcUTQ?=
 =?us-ascii?Q?KG/efbDEk9EQznA1on2KT6v2xCxPmi0q5cbBtjW+7erMI/VChuTNa37nTlGL?=
 =?us-ascii?Q?YtwgqKczEVpmTcvVsiqzL3kkqGU0sQ/F3BYuPtFD6OuEJRPPHyYpomyN2qVC?=
 =?us-ascii?Q?UkAx6amP3rt45NSppJ1vYG3wBtS7THsyUsx+5vpkXhlSIIGn3qKumq/lBgeV?=
 =?us-ascii?Q?m4Tk/m0o7OtKTox8Zt2PJB108QIDg9UM9paF7Pu4rWhl3XRb7Gi18p3fcFO8?=
 =?us-ascii?Q?wrDn/Pg763rLo61j9b2NXWasescFVrwBNCekdf37PA+2oha9YrPTt7HfWfxw?=
 =?us-ascii?Q?ES8tTk4tuwtb7nqdZVhxx8aPsjXKrEVjjRBYVkMhsNqTL1H7o1AN94uwhlH0?=
 =?us-ascii?Q?trN5xgJ8xgaJlYT6nDjbcg8qThrYxeWkpO6w3UD8RW/6+DDaV6zK/Ox8BXRu?=
 =?us-ascii?Q?NVXxwMf2Sm/WbKNgNnQzt6IFNDNQj0Tur76+i/32tAetMtdtNPMViw+UfZQk?=
 =?us-ascii?Q?z/u4vQT1C/BljoiqXtXNu0/AUuG551VxIRUS1d/xGOU4GyvA93SmYhCDh6qw?=
 =?us-ascii?Q?6pzVgh3jlj/r7c3C9nQWvw9qJRNH1QJj+Zkps4m0zM2Vew482ammyxyRL5+I?=
 =?us-ascii?Q?idxtF0O7rzUJKkUOBaUlXl916fKy5rw4lg0YCpA6Qndwh9j6wH3W/E4U+Jrk?=
 =?us-ascii?Q?i6p2y7tndgvaL7M057P47lhcFs22ziTmvhK/Id75ndNajlmjkAKvk7uPXSYo?=
 =?us-ascii?Q?wcjiza99/abwV0RKnX2XwpjH8hpujtRGnVMB7rqNrttFRR8IvxdBueKM1CkR?=
 =?us-ascii?Q?Qxbu00E3fhEQUu4ezjyFuUeSYRTZOq2Oq+vyeWBYFTtX74kXnpF6afLatMYk?=
 =?us-ascii?Q?jcD7H0qnPs/k/xArLmJfZh/VtZ9d+XJiSwTOvU4+tdXkTy7CNAD3j0Ht+iJU?=
 =?us-ascii?Q?BbzEJrxuxwu4poahfs04gJS5YKnC389rTeLHr3ppKj5nCSnICw0OAPkfNIyQ?=
 =?us-ascii?Q?5KbVi9yftlGIzY5RBmnHlOgWMIrpYzNlhSV+95A/vTQD4YkbY6vU87jr+5Km?=
 =?us-ascii?Q?MWqKUvnALmQtMG7dp7aoQOyCITt/3yo5CDc3/Mq7/869GDpNyeNT/kW0Ps71?=
 =?us-ascii?Q?hOF3baF8yL//IQ+hzvgIMYWKdS04nroM98mEV8FShSAaUto1m13W0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4QnuaI6EiUD0WfBu7Nugir8eukHFiTE7vof8TuFRs8H2Pxi2rJcMkcbfpVW?=
 =?us-ascii?Q?5jS54LDS6cHWskSFBKJhUl9Ig0lYk6z68INM0PJoh8LITcjSdw2abHFOPNAl?=
 =?us-ascii?Q?lwMdpaU2XTA13BwEt9dHBJTFfvsuSBxMHuvl4fSWCwe/Fh7tjgEpHSwlXo1t?=
 =?us-ascii?Q?0qtrhvHfzBvCRgTmB68bYn1YCB7WDwHnsgnBZZY7nxAR7us2DX05I+hTuS6B?=
 =?us-ascii?Q?ieXFY7aMDmdWKnaUskYdbmSQioywxRGwSM3D0+P2uUj1/6HKy5Gh830UZw4U?=
 =?us-ascii?Q?1ZPX+viN2BIEjFc24zeuOzXyxEpxpqbRH8GoSg5ju1r3XH6ywn1flDNvAcUl?=
 =?us-ascii?Q?Nt6K+50InyE8DUa06eIEdC/4X59RY75wNfFTKT0ydsgBrsrcJoHxempGFjTF?=
 =?us-ascii?Q?VFtiZzWtIQJnH8Fom6GKQrqtkkQN6vnmlAerxnZtojQOE1CbCJRdU9Xot7fz?=
 =?us-ascii?Q?eSrnkE1wBJMG9j475WxqNwEw/ipaTudznJa1NA3Yrv8qGGuLu6AsLXegGBSE?=
 =?us-ascii?Q?Pbsje0Up30fJX5iXRJasUjK3rHvPr91FdwLbFS/rzsRbLvaLZHhcuHjL3089?=
 =?us-ascii?Q?X8J/DY5oAyjsg+Hmk2PfXQA+xWfyCNRsDrn3ZBMIYSaZEVdljeRS0UPalZGF?=
 =?us-ascii?Q?2r1QB9GpS4CRw6sWWIZAJNtMcCiv5SwUyGLhAkHT5RWSkxSyrQCYzbZn4men?=
 =?us-ascii?Q?/L/KdZ4rPOMLlD4XcBAcz9JFeSokj/SExWQLfBx6n70LEa3tAOb0GVRni6E9?=
 =?us-ascii?Q?w51tGB0124w0h3vd+a8T0wIMYAZhxytGOYLVoj8wVVt1TpzpERpNAhpbUcza?=
 =?us-ascii?Q?T8s7KlAEtR/Nzm3a59HttVjA+9eO+/Yg/AZBuN024yh/fWfOe28Q+IOvftT5?=
 =?us-ascii?Q?BK/m7EST967+tJLl1xwxmMUxjCaFLiNLX8mBdxaQxqHJB4cCMPtAvt1hcSAU?=
 =?us-ascii?Q?5lGYDN2cr63G9CM6Ue3a88vZRijWlZKVtwJ+t+lqkhYsFeJ8zxTGMLJbGCme?=
 =?us-ascii?Q?vtCy0Vv66kQh7cpXsdj51GURboByfhyOEzc9FP5zx4/BCc/XJf15BzSErCHx?=
 =?us-ascii?Q?Z3V9XH0ohx6vg4azf4ltK24GVP6k7DCFf7OQ5K4c0gkwKLWr127cFPswROeK?=
 =?us-ascii?Q?tVb7Tb8utLphPZuXiPOk+BXQy26PpiXAu43uyFyUFX6dQV0Nef5AiGWMyj27?=
 =?us-ascii?Q?Dgshk6NV8GQFDPbtU1+fMhDben7T0Ac0Y0MVQZFq4GAEKewZtnUmFu4e0fye?=
 =?us-ascii?Q?6xRGY0ZdGNK1OOUQTpeR4i1545Q7bYkqMFeY7H6Dz3nLWb30u0c+k6ZDOvL9?=
 =?us-ascii?Q?k30o4PpdrZZjPLPiaZHnhfNL2yjK0X8soYn6vCb2Y3111FXl2bbbZMM39n/e?=
 =?us-ascii?Q?nw17WB6WYAHyM2kUUke00SFJRFHAQBI6mVVpSDQYCf4TGdCmiNJJ7OHfvooy?=
 =?us-ascii?Q?/JQw8EzAf7xdm3mamoQRJa5O0ofuQnFQiebtwgB1esMRWI+8cFnFDM6XFTI9?=
 =?us-ascii?Q?4dywxmIy1I/bcuFbu8//jkfzWstOxFIFF685kbCH4mdF9CjaVImgAtitRsO0?=
 =?us-ascii?Q?ianHiG9UKcNY/ByXuUw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ae1f42-1a66-444d-3008-08dd3b0e98a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 18:00:03.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHwGqnrUgmbE7R6GI2LVNGp0h7oPMccjR3SoL7wD6JgaO3rkKNuSnvTOvfaJ8j8jzZVjfE1sYQS+bKD9hpnQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716

On Mon, Dec 16, 2024 at 02:25:13PM -0500, Frank Li wrote:
> - Add binding doc
> - Add imx91 thermal driver
> - dts part wait for https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
> merged, so not in this serial.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Rafael J. Wysocki and Daniel Lezcano

	Do you have chance to check this patches?

Frank

> ---
> Changes in v4:
> - Add Kryz's review tag for binding
> - Add Marco's review tag for driver
> - Use devm_add_action()
> - Move pm_runtim_put before thermal_of_zone_register()
> - Link to v3: https://lore.kernel.org/r/20241212-imx91tmu-v3-0-85e756b29437@nxp.com
>
> Changes in v3:
> - add ref thermal-sensor
> - restrict #thermal-sensor-cells to 0 only
> - Change to unevaluatedProperties
>
> - add IMX91_TMU_ prefix for register define
> - remove unused register define
> - fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
> - use dev variable in probe function
> - use pm_runtime_set_active() in probe
> - move START to imx91_tmu_get_temp()
> - use DEFINE_RUNTIME_DEV_PM_OPS()
> - keep set reset value because there are not sw "reset" bit in controller,
>   uboot may change and enable tmu.
>
> - Link to v2: https://lore.kernel.org/r/20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com
>
> Changes in v2:
> - use low case for hexvalue
> - combine struct imx91_tmu and tmu_sensor
> - simplify imx91_tmu_start() and imx91_tmu_enable()
> - use s16 for imx91_tmu_get_temp(), which may negative value
> - use reverse christmas tree style
> - use run time pm
> - use oneshot to sample temp
> - register thermal zone after hardware init
> - Link to v1: https://lore.kernel.org/r/20241209-imx91tmu-v1-0-7859c5387f31@nxp.com
>
> ---
> Pengfei Li (2):
>       dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 thermal module
>       thermal: imx91: Add support for i.MX91 thermal monitoring unit
>
>  .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  67 ++++++
>  drivers/thermal/Kconfig                            |  10 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/imx91_thermal.c                    | 263 +++++++++++++++++++++
>  4 files changed, 341 insertions(+)
> ---
> base-commit: d07c576946b2bc440d6d2073998023e8a0bd7568
> change-id: 20241209-imx91tmu-af2a7c042d8d
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

