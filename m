Return-Path: <linux-pm+bounces-41636-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEGNMdNPemnk5AEAu9opvQ
	(envelope-from <linux-pm+bounces-41636-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 19:05:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D42A770F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 19:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C33330427C6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB410325495;
	Wed, 28 Jan 2026 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uy/Z2prk"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184A2BEC2E;
	Wed, 28 Jan 2026 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623400; cv=fail; b=I+M4K2z54rzNXRnvNSev8ltdeQkBx7OZhuVNbjPRmA1eeypr6CxyxsUex0hOXsZ1Rro9HTDIKuqulwIxStadtHaiG9hK0zP8ytzcBtTJ+oUfRsRbx30YQmfWY8XzQfdFe3Tbk3BaelnQlvjPJ39pIDGcQSxjXhoCNOxNC2y+ORw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623400; c=relaxed/simple;
	bh=8GKO+bS4BYYhKx8ipB0kzHUhx5dmOJwTedhkAPTJsfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GasMiJB+Cg6/wDSI21UlKGZBfOT4ouS6/Y5ML92dt8QIJILgPkqw8Qux58CwNjrRYi9L05F/u6uwGTkwpEk9L/6YK2ZCzIu0Am8B9BzP4rLtatPfPlaDEw7y7dmI9/KLUxMI6mOIXhARft5xw/TaOjouRQ988gSWuZrd3jAHhRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uy/Z2prk; arc=fail smtp.client-ip=40.107.130.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qln0fHnSYg/YBSEtwhe95RWqZ+lWfSa+5oSAxHKxZmcggYYr0rRnwQ1KhNVNX9HsRISpwcQ4v3G9AniXxYyPiE5HgYp/jFhhiMb+6dfhFAy5sMRIc6DyQgWmbg1YrRvKjI0W2C4oOqfBNtHB6LVO7nL98zVD0YUoHv2gq2APyY7nOcPnL8rI7ERhAYik/V4nRHViHi3DX/8fchf8cJf49+Y4V+OJMMQgtub4hyihz79V3hI741p/QCtqyQgns4zh6w6KTSVbvgXuB77inxsEoqYHmlfQ7d9/9xWfq7Vn8CMcZQjWbq5QSgq3i+MljbOazkmrePCDy4XjPJb8y7JtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfGrfretHsiXwkWHMj0yP9QnZOv/hZRrM72cLnmnpXk=;
 b=ELEyrdhvXp2CrPOLE0IXyTda7ZDCl+dN0DWaDBRQOSjb/u1B2J+er6bO0XSKjubt7/ayURsuEomNMi6wR7smeGD3K51ePvOqNrcIFjpXmmWW9XmvgMzWK8di3MoHMUXobHOsP0xVteR+DSd1/el6YTvEv7SZySHs2n9egkZXlc6bJxSK6kg5MTW3rD4OWzmdgwPJSaQP/aTrjVXBnc62pNvab+4Sd0y4RJI+2QQ4H/la6kEL96sItA+gc73xE3ch7JhpvXV+wKtjw++WgjRlcsd6BaBNqAOmYaFeWH/H4SMy50tPZdcZq2Nw2z8FFJl3XI/2p5//Ki+vMQrEIEQmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfGrfretHsiXwkWHMj0yP9QnZOv/hZRrM72cLnmnpXk=;
 b=Uy/Z2prkqFOA/NmZv5bNu65yDiRdS5msX/T6LLgnjtKS0nbJd86l21fXeuo5DAVp0I15xBKmXSmIGBQwOgiQoBFWdFVbQw5UukqQCPuYonk1qTlV3GCaPKwVLrjF5//2J37Ff1DtVE81ZPIkMrOH5BuGwp6by2TVJCXCDNQ6cgrmV1rxPz84NZ7jwY/rEyOIm+ShuywdNTKhwtoQdS0+pw2eBhGDZheWxrZfBi9/QRYSxPq8D7ChL9HZ+fOLH5UDWgWIEM/iooy+wknOFxYYP8RHLyiAepZhsjBqyCTJrPhkShu348t/B6cBmZYUOMRdn7gyCIxJlwVl4fgwoD1sRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 18:03:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:03:14 +0000
Date: Wed, 28 Jan 2026 13:03:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: imx: Fix i.MX8MP VPU_H1 power up sequence
Message-ID: <aXpPWea3dBY3lS6s@lizhi-Precision-Tower-5810>
References: <20260128-imx8mp-vc8000e-pm-v1-1-6c171451c732@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-imx8mp-vc8000e-pm-v1-1-6c171451c732@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: b34a9de3-3632-48d7-e1da-08de5e9781db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TKba2p2TXXcBLiRS829hcDgqkTrSjUbJbYHV7l4b3fZHzPTvmhIxc8mRmNt6?=
 =?us-ascii?Q?j9iNjeJi2vHoHGNNkuTUjcJse0CI0H3D6tA3MxTkQNOY1EouxydYkMF89yhV?=
 =?us-ascii?Q?1LJ1psBg8t8UN67EoTC+GYJmmJB7Gp0N3+KcwQJDZTiBHccJeZfZ4ILTGlma?=
 =?us-ascii?Q?j94n6j7tUMMTnGFCBxZF7DNcXq9wevmhtXohsT7AkD97bGahryZarsTcEVwX?=
 =?us-ascii?Q?eI7wHwGieZJzdIOC0rsn86cWGcGaE169EzyFMiUl0AuiwWrEUFo6B5a79NMV?=
 =?us-ascii?Q?AfcWWsAlohtqv90s41sjSYAstb+XcPfKVDW6gi/kcxcsFz7sHaZ2wlrPp4zL?=
 =?us-ascii?Q?/yPxMXvH027tP6ov170c1YIHjJNVuoC2/b6p/6i5FQhOXOCR2GyXIcUBhq/g?=
 =?us-ascii?Q?olP8PThU/it0evSmJ3SHIQtN4p8z7/smc9DE+gPWBOvo0OjABfnBVAM18w01?=
 =?us-ascii?Q?wyh6HFbvyUpaBT+8plAnLcedljBt6gSnXm/DFXVFJfHoYKbDsDk6N9p6MnQq?=
 =?us-ascii?Q?4iljh7Pwjqeo0BOyxUX0hfGVmrNYzOJPSWtCrIR6g39/EMZSOCI6/f9fK3Vi?=
 =?us-ascii?Q?SWQIG1hWQYKypEtXb2u5+SYnNosZ4IrG0kpC1Ilh6xfFPGQkahAaxwlukZ3Z?=
 =?us-ascii?Q?TDN4BBVMQZLySAh/uqYHopd5xEqz4CvEgaKrX+8Z+guJ1b70NGpq3MzRocAG?=
 =?us-ascii?Q?dLqr7mrXilAF8fLTSzKMpJtcUWGpMNBfMLqu2l26fLEE8cPuhW3BuB8XwWLA?=
 =?us-ascii?Q?SV877o6f2nvqWnsE0rSqBb/PKUb4TySf8VBAZ0xLkvvTYgrAHnsn8v5t2CXf?=
 =?us-ascii?Q?N+kxdViSr64iRiLMJSBqdPF6XkDdBK6uapmRqwujvckatvDgkaWu/FxpoJiL?=
 =?us-ascii?Q?6rvGbWZzH2/l9q7pnOlmWGWgUM6VxB9BttKvAZ3Q4DLcJCqK/tU/Ydc2DTfJ?=
 =?us-ascii?Q?cPpU0dCPsXePczD8NX/BrQ5gbrs+AhxXddOv/MS8z7hYtqE9jPGW0ImoArtC?=
 =?us-ascii?Q?VaqRYswZLiA8eP2MhqIBhnWNByhjEGuKBFYS69adu2H5XFdUzKmVqUPlFvyb?=
 =?us-ascii?Q?EMYRIoArK2xbd2bmoaScYV5I0BZOYvf06DE04i0bCEnYHZK5PdkMcV/X5YXI?=
 =?us-ascii?Q?5nP5KvK7jTepkSc6pCr7UbzOzzODm6BWuoUi/j+Uaq2UJWBNZ0FhcwbvRBqE?=
 =?us-ascii?Q?JRnSaLHr8b94Emt0sHVkwHu7y+42kIh75KcDWYl0xTRa5I+x7XSXq2GkR+NC?=
 =?us-ascii?Q?TP1ZJyTaTgasFgFMqItd6hZG1mrmxEeu/mtix7dke2crgVp/XNhJGC5lOOYR?=
 =?us-ascii?Q?pJx4ZDteBbKieFkbgRQKhNEGWWqh9Tg/dsVzTmQinRjtPRc02vto8jq7cS3w?=
 =?us-ascii?Q?Srn+M3pBG6aoHna8zqAQiIIpYWSGXFENFp/wrJB3dRLzwDLoOx4XCO1uSn6c?=
 =?us-ascii?Q?3lvLYyWp2x0xRNfsLSHJecwIvUN+bpWSp6GfVYANmP8TbNJHqBqs+wFJV788?=
 =?us-ascii?Q?GshctikWgzIBfAFrak6mSYQD5o7xsvCZCUzHB4WB2quPbj7Dn6DDY+8QHdFk?=
 =?us-ascii?Q?bq5e0pKtni2m3CBp3cs5YE6+oPYGEHsjSqmAztG1C2a+SfSRyIfCucD0vDvI?=
 =?us-ascii?Q?ZQLaNUc8nrwnnCjdPKiRVM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPgf+1IhABdgqTUt2VddRpyltuyOsPQyr7gulRjhooRklfQu6fBCO8cu+nI1?=
 =?us-ascii?Q?jGcQUp146Y+Ldcz7jO1LrvJMPLdvqIEBMxXiKojXAO/3yV+YOYc7ZqRA1NPd?=
 =?us-ascii?Q?m6JC8eTpdH7NzsLqIuOeQcwe+Ns0MQTdZe42xQOzMip4/LQVbOlDVnbxD3HY?=
 =?us-ascii?Q?qp8E+cb8L7WSdm1md4bZfhHUe5O+2gbXC9eQwpfSjGOSRLuViN7l/CXDrtiu?=
 =?us-ascii?Q?eGQqpPa0D/zXv3CprbkhvHg8EynATdCFB+z3oJgfbMSASsK6Ow8SR5KwVIJ0?=
 =?us-ascii?Q?btlwqt8nzJ+3xusba3iU0sD3m1PHX9OTICt8N7HuSJohnEAu1Ppr2nzH7WcS?=
 =?us-ascii?Q?oP+re9IFDqo/5vQM4+U3E8TYFgRL65AGe6BEa6F1QeJ7D+X3+8ru26n2+VkS?=
 =?us-ascii?Q?mO0hYk8WWqRL+R2E92pTWKmCO8wjx9mGF3uKtaSvOFFD0aYqT+DZKp+w7d8a?=
 =?us-ascii?Q?M8/UgonohQAddJmFZBdXMH/GSarG7/NOKA03uOw19kl3O/QLBZ1c2V0ZYdmD?=
 =?us-ascii?Q?gU/XBVdC/weAfHBga6gUiI1zQ1jZQnRUmGtzXr1nxLi+wvbCq8XM5u3FFXJO?=
 =?us-ascii?Q?jGoleHNXJF1nt8nfDweaIGReXchu3ZCch13cTdewD9vPLWuksBWFzyEdpRnz?=
 =?us-ascii?Q?1eAJ4BtOXVyNLdDNQ+w964yIytDa5KAPSb/yGW1sEJWdJWV8wGsDcj30zxZV?=
 =?us-ascii?Q?FXxP4IHZNLNt3xj+74YNZHkCT6UNbSS/ETpEAZ0bRMXTU/Y8vNSsws70aW5L?=
 =?us-ascii?Q?sUg9ISa2Vdwn4TgLHHBe5gPrxLhmhMuqRP43tiaIYmuVs/jrDQsW1gNWNKQv?=
 =?us-ascii?Q?XKw14nPekwBIpfO2VBi5Zj7+FBrVMVpy8ijq3Qq8rs0l4uJHJcJkP6cGf9if?=
 =?us-ascii?Q?+DyMQUGridjPLpudFuvb1JuKE6JTmdi9X+PC7++xYB8bXKDSPBTbuD4iwinD?=
 =?us-ascii?Q?T2aQTbOoDyj6KVpSCsIF3/Oo39wSLhB5UMt0UYZD4GBLQKRB+7k1etbYl8b3?=
 =?us-ascii?Q?WsNpaJ4l8pJAEnIpzBRJSMBvajhSdW41fAE0iVemp1eGblMXf5icVic9Soh6?=
 =?us-ascii?Q?+OW144RnqcnTZbkugxHpz18VE/QbPntJdWQsqJC380M1Tm0MP4tuK+0BYzWd?=
 =?us-ascii?Q?CFca+8XS86vDMiK3kf+9Puf3lgkzHujfAemRNvjiLkh7T/Q2f9iq7PL4dc9w?=
 =?us-ascii?Q?P5hZjPjfpq3WUFFdnHNkwPFocMd7Iofk68Fq3T6IfFEgZlNRdKeR52sBDk8p?=
 =?us-ascii?Q?qU45XluWn+44a1M611GGAyo5hkDganVXL4UwImDuDqCss2OFbBUqSzidsvMf?=
 =?us-ascii?Q?gz8M8l/J8An4LXv5hv2o8b1a6FmjbWtsK8mjQUfSzxlzc+7wLqhAZswkQ4KU?=
 =?us-ascii?Q?O88bhk4s08PODgkL4a6T4HHUAz2Wy+21nc+vXsmqRacXY94HM/PKq97OeoT1?=
 =?us-ascii?Q?qoiDM5vRj90QWYKUrVbE/EIrACHo1wzMoF7uMBE3ElbryR0zzI2m8ftI8uVJ?=
 =?us-ascii?Q?E1VB5MVdCrmkCvEOiSJW/trd+ZuVdxwHaGpijFMMSuS0lMwK0RrkYJ3TDzWI?=
 =?us-ascii?Q?nDByOtfcD16bdw2UZrdj8QOKp7KRtYh1el4aY3Ndg5aPVPCWdNdkTATfOU4V?=
 =?us-ascii?Q?CsaxevPxeY8eYOSuXZJoMBKOoQ5tbnU6aPFSF6m42XOaB6UaQDYhskG/oAls?=
 =?us-ascii?Q?rwincTPlwUT6vG9hX+15Fw16/Ui1aCFWB1Cu4G4rfOfvattH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34a9de3-3632-48d7-e1da-08de5e9781db
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:03:14.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0nF0lGw28ST+O+lS2u92dvaTj7DBu4HY5OY0cCOebV7p9LqID40xrRkOTLw2K/j2Y0o20rXdG+6r57CV3kWmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41636-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36D42A770F
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:11:25PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>

Subject need descript what did

for example:
	fix build warning =>
	do what to fix build warning.

suggest
	"Clear clk before power up gpc to implement workaroud of i.MX8MP errata"

> Per errata:

Provide errata link here

> ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
> power up/down cycling.
> Description: VC8000E reset de-assertion edge and AXI clock may have a
> timing issue.
> Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
> both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
> VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
> de-asserted by HW)
>
> Add a bool variable is_errata_err050531 in
> 'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
> is needed. If is_errata_err050531 is true, first clear the clk before
> powering up gpc, then enable the clk after powering up gpc.
>
> While at here, using imx8mm_vpu_power_notifier() is wrong, as it ungates
> the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
> but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
> imx8mp_vpu_power_notifier() for i.MX8MP.
>
> Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 37 +++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 74bf4936991d7c36346797d8b646dad40085fc2d..5b26b7c2c43172817d5e407a7d85eb6c5400d5a8 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -54,6 +54,7 @@ struct imx8m_blk_ctrl_domain_data {
>  	 * register.
>  	 */
>  	u32 mipi_phy_rst_mask;
> +	bool is_errata_err050531;

Put errata descritpion as comments here.

>  };
>
>  #define DOMAIN_MAX_CLKS 4
> @@ -108,7 +109,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		dev_err(bc->dev, "failed to enable clocks\n");
>  		goto bus_put;
>  	}
> -	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +
> +	if (data->is_errata_err050531)
> +		regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +	else
> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>
>  	/* power up upstream GPC domain */
>  	ret = pm_runtime_get_sync(domain->power_dev);
> @@ -117,6 +122,9 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		goto clk_disable;
>  	}
>
> +	if (data->is_errata_err050531)
> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +
>  	/* wait for reset to propagate */
>  	udelay(5);
>
> @@ -514,9 +522,34 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
>  	},
>  };
>
> +static int imx8mp_vpu_power_notifier(struct notifier_block *nb,
> +				     unsigned long action, void *data)
> +{
> +	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
> +						 power_nb);
> +
> +	if (action == GENPD_NOTIFY_ON) {
> +		/*
> +		 * On power up we have no software backchannel to the GPC to
> +		 * wait for the ADB handshake to happen, so we just delay for a
> +		 * bit. On power down the GPC driver waits for the handshake.
> +		 */
> +
> +		udelay(5);

this time quite short, suggest read register before udelay() because udelay()
is not neccesary to have MMIO read/write.

Frank
> +
> +		/* set "fuse" bits to enable the VPUs */
> +		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
> +		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
> +		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
> +		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
>  	.max_reg = 0x18,
> -	.power_notifier_fn = imx8mm_vpu_power_notifier,
> +	.power_notifier_fn = imx8mp_vpu_power_notifier,
>  	.domains = imx8mp_vpu_blk_ctl_domain_data,
>  	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
>  };
>
> ---
> base-commit: 4f938c7d3b25d87b356af4106c2682caf8c835a2
> change-id: 20260128-imx8mp-vc8000e-pm-4278e6d48b54
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>

