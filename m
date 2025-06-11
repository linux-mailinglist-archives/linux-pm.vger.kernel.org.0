Return-Path: <linux-pm+bounces-28509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D7DAD615E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 23:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBBF1E1566
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 21:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B923AB81;
	Wed, 11 Jun 2025 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SpUrOrzl"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012058.outbound.protection.outlook.com [52.101.71.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403523717C;
	Wed, 11 Jun 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677589; cv=fail; b=Q0hoQdYyFz+rkl7S5Gr8othaPAXIRN3+4q0opgIMtFJZekPW1ZGJu+i9ZpUUQ1zUMZ26W98m7k9eHQLGwXU0p2IrpGjUMJfGAIiw8bq2qvyJluG6UpGE5VWWFijsgynlv4wuKa65RCe1R7uqhC5HWXcnFEZUJDIKhR0TZU0NJ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677589; c=relaxed/simple;
	bh=WeM4YeU4y3lXIskIfytO2sSWtCFs8ZEUyJS+N8xd9IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mW9L+6g+p63bOauseQ1Gw7KFCnB9IgF+HnObj1qOouRbI01KPbNUI3GpV5R7IsVkZdH8/va26joFr1ijbc6mOdaYG0A+Jbl1LHQiZJb+1kogq/ii3LN7Hb70Z/EM/xLQpCFe8cIewzZVgxRPGJDvaaaSWxAM3UDI250g8IAZl0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SpUrOrzl; arc=fail smtp.client-ip=52.101.71.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOmc01Tf0JooWS8y9cHI23OSsw7cInf7bVqrXTAe/xUeyQheUZdnSLhmoaay34z21iItDXZWHQPRcinzqjkiot/R5Nb3c1M0dT/MhvwvekDkbY84Kh+2GqZH1zj9kB/kuoLtkWaBUenjQVVj3j3qDZ0G/ZJ6lnYmeT7XV34jk5sTZsaQInrN0lA7qT9mx1SxfSRJfkoQJVo/uCI/pCsy5vRu3Vj0FvvZnbDA5FPSVxz9FfcJzNNjbE277ASlMX1iO4EtXuOl9CHDk9siW3khYt495IND8eS/J77mpF+ztMAWMInT4YQYzYtlWVIUGp+8K4vmq5VBW88Cx5mo5PF5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB6d5+hYJmDtPe6pIaRAJ62XubCfP2a5fo2Ou9V1crk=;
 b=c3NtJNEyzw34hNQdQvGeWMu3IoYLLA1E+E3vZDbqbLpO4sZkntKS9CDLTrj6c7dE+2kWNW1PZhnOMGc5swxoXWyMoM1vr8O+vESENrFeyVoX68lcq2LzHy0wXYXCJ3VE6HlfQcB3QFzLE+8W1JZVPg+z5ZrJxK56CeWbIt9qL4+p78znPR9i4BEc/JiTbQMnJg2G+wHStFfrMN9yxH3wllVNxqi8U6q02IKFZTiuPgrMRfUsWE391Q/r+9OIncE2QlTsIQQ0zrEAGQ2mXQbCYC9dcs7viEQ8qKdaF+ll43xKw629BxJ7Rm5gyTkST0Id+yv6KQz+9Mn6N0s7r/opZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB6d5+hYJmDtPe6pIaRAJ62XubCfP2a5fo2Ou9V1crk=;
 b=SpUrOrzl7zZ541bGLMe2gT8sRAqWDP4BZUZ6M31uykrJOTZnagqTFf20VoSml8Nlk+xgFgmUVUhGLHEnjup2xquJLjEivVlkayVtVILt75ynfEW6LuiRyRqk76LWVPfcjulvdsAyRV65Fx41jgN7QUni3hJlocrf2tC6Sa3+fuCV639rbogdWBfwoUk50w2MipOsLJpTMnDNCycGgQJIlpkBKLbAeeLhQ8raOjZTeSLhgCWLagPnSIodbyLsh/8SOOeBu/NTYUjMYNOL13WQBPIzj4KmXjKWvBbVijrGK5WJKBDg5xZvFT0Y1PWKXkcAAEnvzRf+zqcyC5RWyDIy0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6846.eurprd04.prod.outlook.com (2603:10a6:803:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Wed, 11 Jun
 2025 21:33:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 21:33:03 +0000
Date: Wed, 11 Jun 2025 17:32:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v6 4/6] input: pf1550: add onkey support
Message-ID: <aEn2CXio9a8TVG4V@lizhi-Precision-Tower-5810>
References: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
 <20250611-pf1550-v6-4-34f2ddfe045e@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-pf1550-v6-4-34f2ddfe045e@savoirfairelinux.com>
X-ClientProxiedBy: AS4P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 843e400d-244f-44a1-4205-08dda92f8bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nU8nodPVu6GAyt2g1M9rfKgjVjerScKjlhwG8xt21OHHo6PQofvhfE6Ykowa?=
 =?us-ascii?Q?mUi3wMZW1/VPu97+4MnN3J6fluf3xePkxqCgYhQNxcW50zkauJZwqu/oYHb3?=
 =?us-ascii?Q?NIM0UfzfACgoomD+FjuCPYOO1/IUwSIg211TthouKxpN51Bf/aR1NWNMPpzo?=
 =?us-ascii?Q?lQVDHlubgLWH3bq4LLx5XqthCW3TVSuVUDNQHkxeR/Ln7ghX3RWadXyp6DRg?=
 =?us-ascii?Q?4kHNJE/aUC4WFAwg7ki2GbLuJuDgACR06VJp97kBxpImLf3sW6mQLV2rrtEr?=
 =?us-ascii?Q?hMzpt8nmrHR1CLd5C3CGWGOxONJWZCwToe5T4saWspKYWT46ll4KF+vO7xwF?=
 =?us-ascii?Q?HfhOkPuRKbX3+bsj758IbkCwebRBsaHrbmloioSPAQNPh6x08ACKzjud2YwG?=
 =?us-ascii?Q?DGl8lOry03jcZXbNFraHDHlXfwgJmYmYzAdutH+oudJtCCgfHKQ9g8Tgn+kI?=
 =?us-ascii?Q?7eMdrF3Pdyfzb4ArRHPxp6qqE8byAPxeYVkzZr2Mr7BWERVdls23Z2bLxq9w?=
 =?us-ascii?Q?aPtODkyr5Tk7spGtpzezCgp2d0oIRtANOZMA72SJ3Sz1jzpsExLqzaHCOUWr?=
 =?us-ascii?Q?7A/tg6GbZ63b4ohvnuEmPhGjorH1e5GgejIm32W2S0Ox7wW0vjJIKmgfFhda?=
 =?us-ascii?Q?F/uH/LYYgBzfhQoaITu6Fd8hfa3yrpVyV65D9AmW9WZ5CT8IiVq7xjOMxfkB?=
 =?us-ascii?Q?JZU3r7qxK3jWezEUc0A3+VxccMiAtktX1sADRw2s0RlIwHK/C395Je3rcfR8?=
 =?us-ascii?Q?tf4svn8T4JkuL80hPfGxbbZkuzAORB0dj1gURYKUbESxC3BC0lAZ4zCUVcfC?=
 =?us-ascii?Q?3hsrhPXszMu2h6CpcZ9lRSEfUfDznHhUCOPsiwm+6gQubOSWSimBBDTUv3wO?=
 =?us-ascii?Q?ku+WX6mIgSHfyLVqPYIZvinedjPrJyLT2GywS3nT1aupkN0Hzcy4kSJB86wt?=
 =?us-ascii?Q?iUfi7lenp6ndIrLKDN8ttQn5py/jwEe9U89xnvREM/aZco4flJPS7P5+Glr0?=
 =?us-ascii?Q?SUZ4/LgzrqwlHhfQEdYQCjfNB34VD/RjfTq+DX13qwX4ya7X5SzhUvIZPoj8?=
 =?us-ascii?Q?cNvramjUK3XLFEmVAqfANvy+EMCc/GmQVOAXXtS8WNAUVXBSxFdvg1wgsKz5?=
 =?us-ascii?Q?/Ip/fxYT3eSza6pecuRHyPlAjmQ+jKIHkrr4HisCbMatDxC3WM2TBidCqID3?=
 =?us-ascii?Q?brb233b4iN51ih9R3IF18WpsZbzJL9lIBpy3kAT0KkNHhyRaxPczuiXCOz1T?=
 =?us-ascii?Q?896KYHy8judPUhJvdyRfPkqqPAumdd7lw3wO+JM524XCuz7OkEORUo7/dXQb?=
 =?us-ascii?Q?fBAicdVxaLy2LiB+illixI0hI1G0l+GRguA/aYwbLO/x/JpA8r5icjzUlczz?=
 =?us-ascii?Q?T5AEI+v2yESWS+wFJj+rbUZrXfE5QCnZcIIVzRkqGu2sU/2yUiu0DZRKlUvQ?=
 =?us-ascii?Q?boOD5+W31tYLk9G+4ZPIixkc/XKvUVVYP0fZAK1VrT/ALAwIlBVzUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tTedEVmH5+k3AGFgcoRsC6zJ1uPNVMTZhYuVe5u+stRltf+O4THc/+VtxAT8?=
 =?us-ascii?Q?DowBxhLSwX/+Xl25Ws88djUkD8N9R9MmA0dhCph4rxk7Gg5gnLlYcfTJbKb8?=
 =?us-ascii?Q?eJGR9PY+MVXa3+MrXP3iP4rsfD1OkiaQoI1N9Zfl8li64+jD2J0+DscRxlEZ?=
 =?us-ascii?Q?iv4Bra2Se81J63hpp7sGexaZnbUskXicnAXqgg1z0LHEJMJqB156XZmDC9mO?=
 =?us-ascii?Q?rKo1eI/y/3Q9ldYcO0wfjumL5yK9ExFGeoylvYF5Gj+BVf/DVKFxj7ihUiuU?=
 =?us-ascii?Q?ZjiZ0V/ss3qQBT3/5alpJLMKLOjIUFJOnMX5M5CbbScgB7FFnluIXDsIg5A7?=
 =?us-ascii?Q?1qp1Wae9syZlgnGaRruw67tW6EGO4YxT1FZ3yTiq1W64xo8k5KAbWwtEP5lC?=
 =?us-ascii?Q?QDAerP8ZKAasUjRdjTYyrUYjkxdsGpaBuxVmSiKzXl/h+PaRCJKRWPQwgCwb?=
 =?us-ascii?Q?1kk6FiNldsaVkWxpGD6+3r0ivcAx6PG+RWQh+xmPrBYssLig22yIr/ATFv3O?=
 =?us-ascii?Q?CON3zXoRCYXi+UwkPKcgDScw56TydMl91aj1xrYdoGuUefxO0lQHbCXlXr6c?=
 =?us-ascii?Q?QdEGY2w/LqOv9KHLk9Cm0TiOPChxPMQ+AxN0WbbVDDO/H3evEsYWog573sDa?=
 =?us-ascii?Q?nM8PLw1F4DUkoKi1PkVUmIgmC9tkytouZfc3izRDj1orr8XfLHiQH6FKhNwP?=
 =?us-ascii?Q?A91qlz/2KDofWEpQiRvNUKbcpzOmOcji6wnr0CcOAHEYSJc4uVXQpHQrQnLN?=
 =?us-ascii?Q?USr7ggkpL1dpqd075g3eUAcazzupqkWlL8WwMmWbWnR5L4XGFVDAJag6ENU0?=
 =?us-ascii?Q?b21o/TE+dtKwuE8YTJlWl6i01Z6iMsI/Q6baWDtyfgsVs8H3wCZ3FGndVCTY?=
 =?us-ascii?Q?uWAZiCXc39HLJwtaC42Xtw71lScy0oa2wEyWajJjwQ4O9nDnkdLF1KfNOLrF?=
 =?us-ascii?Q?nwvb+O7lIGdsBdlbCVhH3yfNeJWqE7bTLP5PjgjXYXHNNwngoT/9zMG2UNQD?=
 =?us-ascii?Q?cFjttxoe4/q3XH/XCifry4MoGLbm7upbbXI+TirA7n8UdGpaszDO1jK+jIF/?=
 =?us-ascii?Q?dK857CreKBoS8IwLlysy2KBST6qTUHvH/0QToy63dO5klLgd7X9Hy3MK1qMc?=
 =?us-ascii?Q?UQ/CWLYcYhGYj2ZTv2o6+fUU1zoStEbL/YXdSodZ2sHyG6ri8pt+CbVjddiD?=
 =?us-ascii?Q?5WL2AJpQbTcQp2R9vRUwGnEvkV0DFe3uYGfOKM59q2lMbIuXXwjvggqM5a+q?=
 =?us-ascii?Q?UgbufNhTDzGHRsByEJpFKsoheFvZ39wPTFEaMPCshWjMicq0PyXz4Z1XfbsW?=
 =?us-ascii?Q?+bnL7XJuScHBYCGYYQiIJKe2riNRJpxMuYnonawb5t6XhWSOTtEU8mjSF5IH?=
 =?us-ascii?Q?Jgsl4koPIQGJ8dXJ5FIjA77FEscMq3FhwBXcUja+iVaQox5i3/3blHJyC/XZ?=
 =?us-ascii?Q?aHnPIV450G9HSDFyd6qL4U1Kij2pZkJ5B55QJ9zpspMSY/umVeTWTO8yEZL3?=
 =?us-ascii?Q?t5SIcnZZXKhqVcZDmPjTIzTakOyus1W9eJZHX0aJEziIyhlws7Y4Kf5cCBG2?=
 =?us-ascii?Q?KO1RCC3VzSFgnThqmsNG8TQNZ9l+URo1AqGd6Mql?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843e400d-244f-44a1-4205-08dda92f8bde
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 21:33:03.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr5z2HrajuDxhNTmQNWi2TJB8eY3upp4Qa9uS1Tt0MsaG2YNI70pQHhlqlfG8RA+2Z1mquzvQUz0DL71YkNJxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6846

On Wed, Jun 11, 2025 at 04:03:01PM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>
> Add support for the onkey of the pf1550 PMIC.
>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v4:
> - Address Dmitry's feedback
>   - Drop irq variable in onkey_drv_data
>   - Drop keycode variable in onkey_drv_data
>   - Define wakeup as type bool
>   - Use platform_get_irq
>   - Use type const for struct pf1550_dev in onkey_drv_data
>   - Replace (error < 0) with (error) in if statement when applicable
>   - No need to define driver_data in table id
> - Define driver.pm with pm_sleep_ptr
> v3:
> - Address Dmitry's feedback
>   - Drop compatible string
>   - Remove dependency on OF
>   - Use generic device properties
>   - Drop unnecessary includes
>   - Drop unnecessary initializations in probe
>   - Always use the KEY_POWER property for onkey->keycode
>   - Do mapping of irqs in MFD driver
>   - Define onkey->input before interrupts are active
>   - Drop unnecessary input_free_device since devm
>   - Manage onkey irqs instead of the main interrupt line.
> - Fix integer overflow when unmasking onkey irqs in onkey_resume.
> v2:
> - Add driver for onkey
> ---
>  drivers/input/misc/Kconfig        |  11 +++
>  drivers/input/misc/Makefile       |   1 +
>  drivers/input/misc/pf1550-onkey.c | 183 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index f5496ca0c0d2bfcb7968503ccd1844ff43bbc1c0..47b3c43ff0550f14d61990997976366436411adc 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -179,6 +179,17 @@ config INPUT_PCSPKR
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pcspkr.
>
> +config INPUT_PF1550_ONKEY
> +	tristate "NXP PF1550 Onkey support"
> +	depends on MFD_PF1550
> +	help
> +	  Say Y here if you want support for PF1550 PMIC. Onkey can trigger
> +	  release and 1s(push hold), 2s, 3s, 4s, 8s interrupt for long press
> +	  detect.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called pf1550-onkey.
> +
>  config INPUT_PM8941_PWRKEY
>  	tristate "Qualcomm PM8941 power key support"
>  	depends on MFD_SPMI_PMIC
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 6d91804d0a6f761a094e6c380f878f74c3054d63..c652337de464c1eeaf1515d0bc84d10de0cb3a74 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
>  obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
>  obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
>  obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
> +obj-$(CONFIG_INPUT_PF1550_ONKEY)	+= pf1550-onkey.o
>  obj-$(CONFIG_INPUT_PM8941_PWRKEY)	+= pm8941-pwrkey.o
>  obj-$(CONFIG_INPUT_PM8XXX_VIBRATOR)	+= pm8xxx-vibrator.o
>  obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= pmic8xxx-pwrkey.o
> diff --git a/drivers/input/misc/pf1550-onkey.c b/drivers/input/misc/pf1550-onkey.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7e604c5544066eefbd84abe7bdff767b8b8978ab
> --- /dev/null
> +++ b/drivers/input/misc/pf1550-onkey.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Driver for the PF1550 ON_KEY
> +// Copyright (C) 2016 Freescale Semiconductor, Inc. All Rights Reserved.
> +//
> +// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> +// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +//
> +
> +#include <linux/err.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/platform_device.h>
> +
> +#define PF1550_ONKEY_IRQ_NR	6
> +
> +struct onkey_drv_data {
> +	struct device *dev;
> +	const struct pf1550_dev *pf1550;
> +	bool wakeup;
> +	struct input_dev *input;
> +};
> +
> +static irqreturn_t pf1550_onkey_irq_handler(int irq, void *data)
> +{
> +	struct onkey_drv_data *onkey = data;
> +	struct platform_device *pdev = to_platform_device(onkey->dev);
> +	int i, state, irq_type = -1;
> +
> +	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++)
> +		if (irq == platform_get_irq(pdev, i))
> +			irq_type = i;
> +
> +	switch (irq_type) {
> +	case PF1550_ONKEY_IRQ_PUSHI:
> +		state = 0;
> +		break;
> +	case PF1550_ONKEY_IRQ_1SI:
> +	case PF1550_ONKEY_IRQ_2SI:
> +	case PF1550_ONKEY_IRQ_3SI:
> +	case PF1550_ONKEY_IRQ_4SI:
> +	case PF1550_ONKEY_IRQ_8SI:
> +		state = 1;
> +		break;
> +	default:
> +		dev_err(onkey->dev, "onkey interrupt: irq %d occurred\n",
> +			irq_type);
> +		return IRQ_HANDLED;
> +	}
> +
> +	input_event(onkey->input, EV_KEY, KEY_POWER, state);
> +	input_sync(onkey->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pf1550_onkey_probe(struct platform_device *pdev)
> +{
> +	struct onkey_drv_data *onkey;
> +	struct input_dev *input;
> +	int i, irq, error;
> +
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	onkey->dev = &pdev->dev;
> +
> +	onkey->pf1550 = dev_get_drvdata(pdev->dev.parent);
> +	if (!onkey->pf1550->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get regmap\n");
> +
> +	onkey->wakeup = device_property_read_bool(pdev->dev.parent,
> +						  "wakeup-source");
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "failed to allocate the input device\n");
> +
> +	input->name = pdev->name;
> +	input->phys = "pf1550-onkey/input0";
> +	input->id.bustype = BUS_HOST;
> +
> +	input_set_capability(input, EV_KEY, KEY_POWER);
> +
> +	onkey->input = input;
> +	platform_set_drvdata(pdev, onkey);
> +
> +	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						  pf1550_onkey_irq_handler,
> +						  IRQF_NO_SUSPEND,
> +						  "pf1550-onkey", onkey);
> +		if (error)
> +			return dev_err_probe(&pdev->dev, error,
> +					     "failed: irq request (IRQ: %d)\n",
> +					     i);
> +	}
> +
> +	error = input_register_device(input);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "failed to register input device\n");
> +
> +	device_init_wakeup(&pdev->dev, onkey->wakeup);
> +
> +	return 0;
> +}
> +
> +static int pf1550_onkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
> +	int i, irq;
> +
> +	if (!device_may_wakeup(&pdev->dev))
> +		regmap_write(onkey->pf1550->regmap,
> +			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +			     ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
> +			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI);
> +	else
> +		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +			irq = platform_get_irq(pdev, i);
> +			if (irq > 0)
> +				enable_irq_wake(irq);
> +		}
> +
> +	return 0;
> +}
> +
> +static int pf1550_onkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
> +	int i, irq;
> +
> +	if (!device_may_wakeup(&pdev->dev))
> +		regmap_write(onkey->pf1550->regmap,
> +			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +			     ~((u8)(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI |
> +			     ONKEY_IRQ_2SI | ONKEY_IRQ_3SI | ONKEY_IRQ_4SI |
> +			     ONKEY_IRQ_8SI)));
> +	else
> +		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +			irq = platform_get_irq(pdev, i);
> +			if (irq > 0)
> +				disable_irq_wake(irq);
> +		}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
> +			 pf1550_onkey_resume);
> +
> +static const struct platform_device_id pf1550_onkey_id[] = {
> +	{ "pf1550-onkey", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_onkey_id);
> +
> +static struct platform_driver pf1550_onkey_driver = {
> +	.driver = {
> +		.name = "pf1550-onkey",
> +		.pm   = pm_sleep_ptr(&pf1550_onkey_pm_ops),
> +	},
> +	.probe = pf1550_onkey_probe,
> +	.id_table = pf1550_onkey_id,
> +};
> +module_platform_driver(pf1550_onkey_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor");
> +MODULE_DESCRIPTION("PF1550 onkey Driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.49.0
>
>

