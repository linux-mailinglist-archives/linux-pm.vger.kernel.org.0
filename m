Return-Path: <linux-pm+bounces-29056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A56ADFECF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62380164E63
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90FE246783;
	Thu, 19 Jun 2025 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FbyJdrbd"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD124418F;
	Thu, 19 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318481; cv=fail; b=XLLbVUIY5i0q54JQ79YF0KKUdAcBNQ3Do5GlbRRWN5Lx0YL/T6MnabIyU86Kwnuev9MvNl0AcqpDBI1vCBzs2E29TK8SxhuLTWlQ5zeF6dSA3SeeSGQ/BNnvaMGBOxvTXRCmlNmX8y8uErd2MIj32Xh0Y10NP1ztYIS8OGLTG2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318481; c=relaxed/simple;
	bh=3NaUOxVgAgS/4mDsw2ToHTQGnIdtLxUXJVGxXJqiCa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ub2bhK2to6H9ChV5oyFCNXuCCk7YhGVLMUOF0dwSC7dvgtbvNLm8lxokkzsTda3uekoTidGrDSbFU5/ZogvC8KxcSsagzY1Da/7DS57yIVMJ4Seyc5M9VnFPBtsuCX1ZsEyrX22zmByP/Q31p3tpL8uyyz04Lxysr/OhYa6lIdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FbyJdrbd; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UN5eqNXeCeUcRs6VtHNMa4zE92xVH/AuaTFtsuPmGmFzq5A6N2YUGSuZNeKF1bPfPLi0dQHxs7WnUoaKBAKWUWYZ2nQ5EoNXLN8moaBjX2wrf/HsIFx5fgWaUmTWUNlWrtUg7m7bNIseIM46DO+NlXIvgJaVmxNl+6kC8bPgqH7/6fuIk0IIpE7tm8qHQWnz6PAvE94Zb+E3DTyvXrqvOc8oe9ytB92Rtg2iK1UoQq//dXNES6+GvNFzzz99MzdpGg95CQrcue5cSd+oUaKkU0+EL74Aqd7uojkXTafhNKJRb6iWLvBpCKngmigmUvDH9QLI8onbMOpIDmbBGaswBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCe0VQnd/2XKO+TABP9HgIC0vjJEyqJQaZnx+cTDR2A=;
 b=m5SGdIA6ucJdU+NpJvO6cn9JI2EIO82OMTruzjRclG0e6xg9kD0bzfyJM3taaAITtfjO2vjMH1IdOQo3/oYHAovN1LsGufMqym1kZjDu0H/zZ89vP1fChwXvtYqS68rZFWyPVj+2I4BFr4nGptZEyCWJ6eX2SsE798hdtCxQONGNisQTEISoJKp1niUu1BOOQXtLzf11pOrvlvAtvXFkeV60g/rJtb8pfNMQVJ4ZWnFyMcjPc3XO6c7ObxwGRy5syeC0JJM/GhbsizkGj0IPjtL8dODg3P1+RJFbXw5owNJKIHRJkc69Au/X7uRC3IL5F8B0xZ05i3ZCFyXVABV7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCe0VQnd/2XKO+TABP9HgIC0vjJEyqJQaZnx+cTDR2A=;
 b=FbyJdrbdJc/iE7/2G2r2DXc73PE+mHkELA00zgtTeZsdYDfpkCcAXY8rIK8HcPTO4r1H3Igl+ureTo2e2WGu4XkOWsAAYd/YQ9+kXcRM3clLwewgbzmHtJAFmxYJbcegWLXM+ee+UGMb7m5a0MPe6r6/qE/DKE/wXLxuycWr+WAOMn500BLJ4YzbsPLOkG8RfbGdhVQ+qmPDv/TNlmR36WyEJrrrLJRuWHKImYVEzhtEnr8kd5DnlxtrYTuK0kT6hQsyu2dp6+rZGa1BPSw2TwxwA6l82ueDMx/2sBgIV7XY5LUYv3NBNsvarohCEHJ0xyl++6iUABpE6z6Tk1xEOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 19 Jun
 2025 07:34:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 07:34:34 +0000
Date: Thu, 19 Jun 2025 16:44:48 +0800
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
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <20250619084448.GA22452@nxa18884-linux>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617193450.183889-1-hiagofranco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2a7c83-7a08-49d9-8a49-08ddaf03bc31
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?POMMYsOzLqC7ReW+Jo4IFzlleeTSxAxM4aKMFT9PIIUt6NpguKt9DyHOtW9B?=
 =?us-ascii?Q?ugKSRaMlZnS8XcSn02kisbr0h11NvVHdTzAv13p/dcbwM76FNKarsd656dLW?=
 =?us-ascii?Q?bkAOwiHGtsVNTsd1PbnvBvkwMh0mjj49+UZI878ZTfmJB7LzWs/mvur5MZBl?=
 =?us-ascii?Q?xeVsuSUjito/8sNM5bQ1YjEbLClXpwmMX8wV9uPJrBmRo1C/hljTtmOmlTr5?=
 =?us-ascii?Q?oi7HruriDVH8qQeM4d66OgLn9uz2TkuEpQnfhH+9XYDHBQ0+EqJYRFIiB7lW?=
 =?us-ascii?Q?IYxBn8BoX58BjgehJpAsJ8+v3tASp2SUkPRTU1bPED1xGi/MEFi95KJTwnmF?=
 =?us-ascii?Q?3E1wCMKgJu9/fTptUVaIkfNsA+TZQb5dTwtieSTr1c2Npc5KYXi7xa+QUF+2?=
 =?us-ascii?Q?A5rNDAkfVABiMear9jZ3h094XhSg/PIG1bRJoqvIqem79sggPs0XIE+rqOP2?=
 =?us-ascii?Q?Gzg08Elb3VN9U20Ios9jnI+dMfWUpFKzCBhpBdSPcOCe9DNtKKXWoGEpg6Ke?=
 =?us-ascii?Q?mIjv7IhWszVogJHvcENdfzgewviLdK3KDoajdWJ5rNZ8KXoU1WASDvFXe1WG?=
 =?us-ascii?Q?05E3JMfXP6kVHoLTQ/tStbfmkzTtQRA0vBY4nS2MIXAjtxvZexuAg6jmw9RJ?=
 =?us-ascii?Q?DtKZ4P/n2PjT2Yxr7E8oHWiRrzvMxMx6nSsF+HhBBpR4o9ru18YtWcSKAK5V?=
 =?us-ascii?Q?hnGnpJAqOGNwatZas2Yf9tbIryaKRKv5Cvr24fLRse15xRlLS4gqzZAc9Xgf?=
 =?us-ascii?Q?/cKbY4DGUtgyR/LVLJLc+AgswVEu/RWQMSs3JREL/KiHvFlkkFqAIELwFk/I?=
 =?us-ascii?Q?lBhFjqGJaXSUM7n45mV86nkLHhxsafwymHJlMichX9XWj2bf6WY5G1v+6Rh0?=
 =?us-ascii?Q?fKvo3E2+5cyZHR2X5RryzmZLznhYaWY1xfq5AV48YLhT7bOc7O9y0XnN31zs?=
 =?us-ascii?Q?nv9YKjKGTdI20t3ELIPcIXeehOD2/aepIuVCct+UVYbPxpFRd4iMYTxW/DFo?=
 =?us-ascii?Q?ZSLSiojTepUDCNHQ64jCHFMasUordQhTC/+CYiEnUgmOVDJgj0ebdPISULbd?=
 =?us-ascii?Q?obKxsVjGkP8ctLvOlpF9Ech8876p/rZuksA1p5s48oIzwvE3xQH2uZz1ROix?=
 =?us-ascii?Q?gXqzWRlDfJHK0H8Y6VTIv7+9AY9GaxJrTRhyhy2BMcGosvqOTIYN1etbGh9a?=
 =?us-ascii?Q?ZeTn4C3IIwRwJ+ItK+glC2qJpcWdmjEWCFVri+ayGuld85le19L/WgGamquj?=
 =?us-ascii?Q?p9uTRhfRVp+UAXdKIyzNRZQp+koHdYO+4ocM8j2Uw52k/K10xu8w6/+A9fa8?=
 =?us-ascii?Q?QKuWXWl867WA2dCO0EpnsugTgGty9MEgCasFm7j8hgQ8RF+PA1ccstdUxDkC?=
 =?us-ascii?Q?q7zB4yJ7yUdLRt5n+w+ael0NiT9jH4F1fMzviP7KpvuTBFt1somGYfQYv7dF?=
 =?us-ascii?Q?jh4Gxc4shQNWS7+mzYs4eyPGSm2PzDtZQjDl9E5GoqS0SyiATlgH/RdDcETp?=
 =?us-ascii?Q?MTayYCVMEQA0e5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0idgXG9oaymJ0uBw4Zec980pCmyeSbqjytE82ucUtSMqknKgwYHn7yOLuEjQ?=
 =?us-ascii?Q?yYlc69zgrhdb7RAJ7YXbaxrAWN/w+Er77hNsN2phVrvDhrJLBij3KncTsThD?=
 =?us-ascii?Q?zKEgp2QrrgAw2zuJ7ff1uy1+EvEk9ndXHLhkaUhsMayY+OTpuEnP6l1dr/dN?=
 =?us-ascii?Q?cAsgXc0PwXLPO4v8ENYWnC4hTGTlREWYbI9AjNRMwjWo/nLoHm9wAE8pUpbk?=
 =?us-ascii?Q?/xwVTzEIz8nFrecMvaxmtvE5eG/poB2dOJ2ClyxB6xkhHJpZL+UG1mFto7rh?=
 =?us-ascii?Q?/tewzHqospbQoP0zvXQrVARQf4wwbgpUQJU6H8l+rtj6TBTtG1S46yNu9dF3?=
 =?us-ascii?Q?EO7HtcK8LB6Nm7expmh/cFlgkKckpTECfpJdNkkkziWAX1WThlDFwcAGbFau?=
 =?us-ascii?Q?wh2czKP2UWooXzdfalEsSgOfKrwxwgS7+cuY0N4ozXHVatuXrL1n2NnzJ41v?=
 =?us-ascii?Q?K9PUq9AIWToMqxTFJ98Zw+4ITOr8IA9gdZ+bFWvCt2IllEyWv+EISaeKQJuV?=
 =?us-ascii?Q?jzl0yEEpgFz38W3VCOj41W0Bkc+SDYc6DWr6oVs51SMu9LPh0/g+KslvAVdH?=
 =?us-ascii?Q?ctdZ2uJvFMdweUpy5HU3QHJysxR47XyEVNeiIKhXyuT2KVxaPAu5wzGJ84Ka?=
 =?us-ascii?Q?en3T022jLoAAfnGJGQqHhzPTZCooeWY96qYnowudxauJg3HeUfrVM6aM7JS0?=
 =?us-ascii?Q?a4yLRJ+SHHRBEWgW+sbvw34IArdyRikfrgS5iJ7oEgszQONYtgj+/tzdgXl9?=
 =?us-ascii?Q?5J36uLlVJKqk24IVTMy/hAJhpNqJmf2HWKWwVOlReLW/4R55XqNmIZfdGk97?=
 =?us-ascii?Q?f+J8bAptGz0Io6mcetPqTYNeHTwrEYmvUp/Jvv+Er/RxpWV2PgeYRc6MP0J9?=
 =?us-ascii?Q?+rPwCn3XGt3Iv4E8/gJMzRoMioggH0NZwW3OcgvjZAAXt5sX5q5mT+8vXsgI?=
 =?us-ascii?Q?MLrH6Z7XagUzC3GT4ZrzdL7xyOeGuSLSsV3WyR3cW2Bc7WK/it3f7Xml35eo?=
 =?us-ascii?Q?S+OIC0CKZyU0AmKBkmOroeNo8FmxeFiOkrrtR/ePrMz1IjgSZCelZyFjGIHf?=
 =?us-ascii?Q?jGT59G+3ICH96fkFijPKr869ag3h8NYty81dYuoNxzhq/fgQzWYXGbxcgeIV?=
 =?us-ascii?Q?JbQxwRohzQbexIwaWdtyQVYmNLUY9HXs8eFy7Ac1iy0ol4Fwh/zXrcxVpmdo?=
 =?us-ascii?Q?NlNRPdjXJ52aRFb8ajXAHfX7hZc3xTvMJLzLwV14I5YHxEHW12+yoJ6GPCq9?=
 =?us-ascii?Q?CSNhH9OxRdFvTbb2bM0e3L2fQImGYP6N8LeLHtWyC6mGc50z/VHnov8CGltf?=
 =?us-ascii?Q?O2EvxCJc1ia0KPjIaqw1GbJNYj5wuNk0Bx+moPfESh6Ce+KPOOJw8vNtXUHI?=
 =?us-ascii?Q?5545UH08Ia96oeTDZY0tL5KH+htHCtA/6GuDXpVP8fk8GWdZnHQlKvspyez7?=
 =?us-ascii?Q?N19t41YdP5vtwQ90W14JQWVifMgE3Pa2qqEyE/35O5MUNnafgA/trWC4zN/v?=
 =?us-ascii?Q?172ZrKvoTyERBuiF+y0NuXdgQ9iBBZp/HnQbzb5dRtRZxLWmIV59EqcPr3z9?=
 =?us-ascii?Q?NK22eL/QFtue9JYAKphseZyz5fVEpJ4XgBz85JBH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2a7c83-7a08-49d9-8a49-08ddaf03bc31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:34:34.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygGfwkUOVFyzM0Qipz1xhm+d7pHxZeDrbvXwffl7YVePfOiKsEdBx/I4SBUzO26yg9b9ny22NxVBSeTaQR3pCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445

On Tue, Jun 17, 2025 at 04:34:47PM -0300, Hiago De Franco wrote:
>From: Hiago De Franco <hiago.franco@toradex.com>
>
>This patch series depends on Ulf's patches that are currently under
>review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
>Without them, this series is not going to work.
>
>For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
>started by the bootloader and the M core and A core are in the same
>partition, the driver is not capable to detect the remote core and
>report the correct state of it.
>
>This patch series implement a new function, dev_pm_genpd_is_on(), which
>returns the power status of a given power domain (M core power domains
>IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
>already powered on, the driver will attach to it.
>
>Finally, the imx_rproc_clk_enable() function was also changed to make it
>return before dev_clk_get() is called, as it currently generates an SCU
>fault reset if the remote core is already running and the kernel tries
>to enable the clock again. These changes are a follow up from a v1 sent
>to imx_rproc [2] and from a reported regression [3].
>
>[1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
>[2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
>[3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/
>
>v5:
>- pm_runtime_get_sync() removed in favor of pm_runtime_resume_and_get(),
>  checking the return value of it.
>- Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove().
>- Fixed missing "()" in dev_pm_genpd_is_on description.
>- Updated dev_pm_genpd_is_on() function description to be explicit the
>  function reflects the current power status of the device and that this
>  might change after the function returns, especially if the genpd is
>  shared.
>
>v4:
>- https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
>
>v3:
>- https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
>
>v2:
>- https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
>
>v1:
>- https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
>
>Hiago De Franco (3):
>  pmdomain: core: introduce dev_pm_genpd_is_on()
>  remoteproc: imx_rproc: skip clock enable when M-core is managed by the
>    SCU
>  remoteproc: imx_rproc: detect and attach to pre-booted remote cores

Reviewed-by: Peng Fan <peng.fan@nxp.com>

>
> drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
> drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
> include/linux/pm_domain.h      |  6 +++++
> 3 files changed, 73 insertions(+), 7 deletions(-)
>
>-- 
>2.39.5
>

