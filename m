Return-Path: <linux-pm+bounces-28508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396FAD6157
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 23:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2861A3AAC7B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 21:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA712235BEE;
	Wed, 11 Jun 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Io/23yq8"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0720127D;
	Wed, 11 Jun 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677492; cv=fail; b=C1LjskWIBkszaU4Wce1Zje5bvmZgYRy8LP9evvLN0xkjq2MkFme3imbIxLMlQqNhVliVj3c0WsubADIQpnf5jCS1VsmmRjCdgqGs/+lREoJwyWRB6ZIKFTQEOyKsoenn7R/KqzYrSojNE+XarhXq7R5yPdk0bXqxkx9n3vOmrYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677492; c=relaxed/simple;
	bh=Iz2C/vNvN0SkDepGOd68RtuY3wELgexig7T39YXTz4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sMSgq/SxK1L08Gsoouis4iUIhxdOrJ9h82Qt9KNQAdWOgYepwSEQtqItvCj8sHt7dGwrCjW1OL0cpJl86hlBCzDTySiI9/F5UOoMtC0q9Zl1aBFtXKikMkHxwvfKemti2RYWvBxrZIY3qKK192hCa821Ef4mg7RVCSiWLyn2J6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Io/23yq8; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMdwaAKf8TXbO8DSB6K8d89C/ItlShhZ+6Hh/nHmYDGMCo2t+yBTSUMtfyGnoYy4y7HT3FO50vFMaeq6TChgV8FWYzaPdjW99AOpFi++dWmwjQjTFuknOXelrdI8plxINOJZJMidYI2Ry/1OV8fZqzM3/lXqXHegTHUdQC6PU1BPn0JAQDiEKZ9jZti7LT/MsgzCb42Pn1TRCzvcociwHDBv2ZRRvWPwEujpMwtItHf244CYo+jJh3w+ncaZ5+7ij028cGVpA7mu7gLdkF6dYncfDTjxvselxa1dqEmRiY9KggdA/KKHh+QxjtQmK/06+UAzonBlXfG+acBIsVvrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSZ5C+mCmJK9JQ2M9i6r2dGTZqF3Q3Q9fagnjS7j2/c=;
 b=LCTHqbKlTDYXti5mXzGHVtzATbJJwZ/00Om9rlGtxqaIT8G5kK2RaB99hppd67gwtjm82rCeDtfNRZ0P/I4HKVjYFKuDlibya6p2Vs1ZOPVzJA/A/UQCHAld+TyuEl3hqFN4nt8YvT4gFoHOSM4JAbedWya+BkIDPgLdlPcRcsyXOzfSTnNsNBLE7eY5xv4Ed3y1DbROpUNSxSGmaNMNhmK62lxRQA0v9W1tVVZlPiVpEew0vq7hZ0nox1F8gcLIeOwUzdMAXejGhpsLyHf1BIKeffh8DZI/56FugMPrJ/KBLdkvEozF/164HT9kscPaEYp1RvDQVXgupnfp51DM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSZ5C+mCmJK9JQ2M9i6r2dGTZqF3Q3Q9fagnjS7j2/c=;
 b=Io/23yq8bM2JQuelq5MrWu+pe5MSCt2WCLRXlGn2cJ0Gjf5Gxt2ZvKlfugfgcMqYF8+kdWXHMXz2VqlswZlyYPFhN2J2xVlrKAHeeiOrI2x32ydW2fuAWtFhhDdzffzJOYDrj7wbIyX0YfMZW4iEEoZ1jqCkpeD+LzTfB008pM4tWfElF/SyRwvAQRxTjQ+eWlIjbp6A6OKS62NMMLUPvRAl1bvcYMtsAbip9aGvMdD+Y4GWFxnuCbnoGF8IRb6bfPD3QEaowAJ8uL9R4C/qH1U7jR7CemVwQlAW4cbrHFxDVQXN/MYRlb9xkpIT4CZpkpYdUgsxDI7CNpw6yo1A5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10722.eurprd04.prod.outlook.com (2603:10a6:102:483::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Wed, 11 Jun
 2025 21:31:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 21:31:25 +0000
Date: Wed, 11 Jun 2025 17:31:15 -0400
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
Subject: Re: [PATCH v6 3/6] regulator: pf1550: add support for regulator
Message-ID: <aEn1o8tkXmqMwd5k@lizhi-Precision-Tower-5810>
References: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
 <20250611-pf1550-v6-3-34f2ddfe045e@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-pf1550-v6-3-34f2ddfe045e@savoirfairelinux.com>
X-ClientProxiedBy: BYAPR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:74::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10722:EE_
X-MS-Office365-Filtering-Correlation-Id: a0379a7b-f7f8-45bb-a5a6-08dda92f5195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnS46FfdAa/pdHxzB9MoMiu7NNaHDYHG/81V9pne6ZFLQIV6T7o3J3brCyIQ?=
 =?us-ascii?Q?puAsLCKv+RZr6VSsoP247sFjXCY3MvPlsGkYcgOtKFXgDL5obG+WO55oP77f?=
 =?us-ascii?Q?O2zgmjgl9UmSkuf3hskZ5ro+TIppHKqJjAfIGrfTLd/cUEQL5jFsw71vEt+3?=
 =?us-ascii?Q?O/IFizKwNZ7QSlUbRnFZnIu8EJGe9Vot/8qzYCWQ+n6zZ4VBRn2pINUX6jv0?=
 =?us-ascii?Q?7RAxWYtqPkChgJXTeLdaaIg1y1Y1D5gM6axeL9OQ01KIYdny+pDF+kzsapBF?=
 =?us-ascii?Q?joI1LYmyUfL+BZt29bOSP49M8KKdgDN9F96J2VYYlOoxNTWW1FQBYNYFg1VM?=
 =?us-ascii?Q?ekawBr96LRNgz+dhoLBSyfW9FkO+pN9vKFW0GfVeyGa0sOKV5c0p3mZrD40D?=
 =?us-ascii?Q?hoj6fp1EDl8Cy8mGK7xWG2NXbgD6nLkmxObrGE9xvu4LpC+YYJ6HMbkxxtjT?=
 =?us-ascii?Q?WNL/RuaeKTU+G5NPCNlnniT7G5JP1iwWOK1F8mtkdlV2zNCtVKex6Jkz6zzF?=
 =?us-ascii?Q?aywEg1v5ZG0dEiHuUiogSqO9nX3qMLbRq80hXnkhMtWgiM1MjowZ6oG3gPW3?=
 =?us-ascii?Q?IlIPL9qaBsXIjw7PKs/cAwnS1EagzjAJTNDkknFFPESYqSPn4V5CYygPyLdc?=
 =?us-ascii?Q?oE4yekOu7h7HGr1vfoG9bLWuQTHNRY6q4zTKR/oWH0vR5ML3pNNKY+fexf9u?=
 =?us-ascii?Q?8mDlYrouFloo5gJjoe3Q1xKCNThwxBI5la/bPPXAiGHqt9CMErSQ01OftIjz?=
 =?us-ascii?Q?0K3aRhvk5Ge+hIWs9gOl92unjjSZGe4NX/Zw9fqWVR4I6V/pMB6U5gtJM0t8?=
 =?us-ascii?Q?z261Zn9FcsH4sZQxv7ke7k+AuIs1/RhULb/1gPsIHT9Tv5zY0RCoesqIYJH6?=
 =?us-ascii?Q?fAcwK14wtigRSRAmd3ampoV/j4bc4R3f86DHaAdF8hvt6aw+ZYR13jvxlLxr?=
 =?us-ascii?Q?y1b1cXy2phyb8sYJWx2XHd6Gv8VlYprj4p0n/094VqaIKgnuvlZEvc3U5I9Q?=
 =?us-ascii?Q?5V2GAk2oeQ155yDuzD1978W65nbl8l8WtZh4DmccT4JiXb/ggIyAYL1fEjzJ?=
 =?us-ascii?Q?gGAw+9vT5qAGgfGP4FdQnMEBWvYDnztsdHnGz0qwf34x4u1Zn7g0KdSmiiQX?=
 =?us-ascii?Q?zCNxD4z2AtnJRG6yQTpJ1ib1Blx/oS5XS2aygBVqm4n/kWw+AsXJFOyjIW4p?=
 =?us-ascii?Q?5OdElZCKEgtcSifaYx9T+rXbfM4DOLXvEcaSLLEkPlZWgiTTcuLrBR3jPqNt?=
 =?us-ascii?Q?VEPxZKyGYyDcUhQUz7YkSIER26Oh5zWJMpZrHd4nLgS8fV9YY5gWHjmnKzE4?=
 =?us-ascii?Q?MWrzSikzIXBkrUNCIwTydleRym9QB8GtfpW5SzIPYLjFH6uxUOmpwB/AaPWN?=
 =?us-ascii?Q?1F34IlJw9bxfH47yI+BxWk3ckuD+ES2KnC8J7SQHfkG/SCq/PhHnHncdL/ZI?=
 =?us-ascii?Q?Up/cq/zXc52Dzrx2LmzyNN69J+bUa0n7UACpjq6pw3l4JKNpfndiLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oyjy1dizehhzgaD3t9wU0xCEmT2WzPLjyFRREQ4Wnm1nHGdG9ztWV3GOf2eb?=
 =?us-ascii?Q?72/eNDEw/qfgX7xLkZd5x+o3o5H+wz2uLtoJmYPc0g+VaW7rC0voatQAG0gx?=
 =?us-ascii?Q?hN7A5ZCW5xUG0bmBQTEPeihY1MyS8kAikY5QB0118uZoK/TatGmZ7yzCp1sB?=
 =?us-ascii?Q?r2s1SUwgBeyJYgHRqhmyAaHgt1Y+LabOV5yz0inIZe6pCkrtfR1TzkQEgx6e?=
 =?us-ascii?Q?JvBMqaiXzW69lm69fenGf07dtu2TcjHGev09fRAVt0YMoJkpDtnLu8qBOH+N?=
 =?us-ascii?Q?KEQ3H+AsD9e5efD4gVQ8rNXdJsdbcgfcKYr0vI22NG2gHBw0UxHyqYEuCd0k?=
 =?us-ascii?Q?pOfeoDkth60X2LY9phU6TXtbydReNZwKsBtTpPLUtVjCuMWgijZArZwhrlL8?=
 =?us-ascii?Q?RzkLcfIjr66kA3kdeD0RRiLXLeQBy4ZyWoVY2Aw0cPwgHtALpD8v8gPSUQal?=
 =?us-ascii?Q?8GyZ32ZyUWYEYWBXj7onbVR4n7QOiQd4JHH6cos1H0NWU95Mi35UtabdCuqy?=
 =?us-ascii?Q?1zM7vGJbLzdrHYWSJP9k+o1XcWgn77dAuBLCkoQ1DbSRpQMZt8rgyesUYmSG?=
 =?us-ascii?Q?78tMVEeXSX3KHbT93VvAtHqGYL7ksSzdF5D6WGQ5epByozKPwaZew3K5RCHb?=
 =?us-ascii?Q?LVH1RirORq5QdtRasG4io4Meu/zlk9a3Y70SEwBMq2D1SMeoQVkhCLG7LvqN?=
 =?us-ascii?Q?hj+gTZd+icAyFefJs0/uRADWlAbYaD8/pvrXjg5mOiK/qnJPYwy0F8mxuS4p?=
 =?us-ascii?Q?OAsWj9lsvvEG4+H8CZ9V+bYbWG0wqWxZcOyuEJmV/+ezIqIDwrRL6XVMk3lY?=
 =?us-ascii?Q?7VtB75jSKUI+h7MacZ/SgI5GjScAD4Gb9SV44MiJFW366rBPSuGktWbqkYeW?=
 =?us-ascii?Q?2zINLRj+9DmaavpQr9b5JGGLjSNa4skfSaZaNxL7HKbfNcvDg0G8J2g54qIx?=
 =?us-ascii?Q?9P2YhHaZPggnOmArhVrA0KuSrgyaZToev9j1MCeeVVm/zg21IjA/ukBTMHdB?=
 =?us-ascii?Q?BAz2ceEKWjayahXvluHetX6Dg/vRUF7PNAaipM3R594GOybXq4EC44kTZOtX?=
 =?us-ascii?Q?UmmnYAadT4C+5jMVgdcOo2Jf20DCdI8MLnnpIFr8g57XL0b2YMXyf7ecfkNV?=
 =?us-ascii?Q?BhnFVAyRSerIWsvqMjvufHo8pLocPGDDQhWqNE8hO/Y7McZFUSdKH/wka8Mz?=
 =?us-ascii?Q?i7Ya9Uc/pDEVRORvDvsWoPUFePVrUsvnCSRtWw5qVN5qunj+nrPNgYiXFK5R?=
 =?us-ascii?Q?wwASqUgQoUa5gIr6xLSzzQwQ1OQDdin3nuQfm0iFWpYBoEwjAL7rhLoni0ua?=
 =?us-ascii?Q?jXLWO/1/jLGSZEKWJMrdkg79FTVbGH83PYoS5ooZPUwzR2GjGSWMiTP1EeIk?=
 =?us-ascii?Q?u0sELCy9hD3L3mJ38IxccejhdWkfITNV7uBGOEc6jjGDkijKtSm2QTZgbkQM?=
 =?us-ascii?Q?eylx+KiaggS1NzyyoPncm91nUKjXc5Pw6O2/IoK2+ApW7Za4cnZcxcZ8KDCJ?=
 =?us-ascii?Q?QbV/eSUmHhMq9AUlkLD42WTQB8ahaNsQ+sF6C+LifaxJatOnfZOKk1qq+jOA?=
 =?us-ascii?Q?i3KxUndYP59KpZx6k5OXVF0bfEKZFs3b1bZg5T6L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0379a7b-f7f8-45bb-a5a6-08dda92f5195
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 21:31:25.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHPKVCInA5X0eJg609h3GNEvo+CqEcDZK6m7KA2fFB5g0txm9La8d73YYdPvugmgn0el4zL1kkOTG2nj8J73og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10722

On Wed, Jun 11, 2025 at 04:03:00PM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>
> Add regulator support for the pf1550 PMIC.
>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v6:
> - Use dvs_enb variable in pf1550_dev as suggested by Frank Li
> v5:
> - Address Mark's feedback:
>   - Add comments to clarify difference in interrupts
>   - Issue warn event for _LS(low side) interrupt
>   - Validate maximum ramp_delay
> v4:
> - Address Mark's feedback:
>   - Use C++ comments for SPDX license
>   - Add portions copyright to reflect my update
>   - Validate ramp_delay
>   - Report overcurrent and temperature events
> - Use platform_get_irq
> v3:
> - Drop duplicate include
> - Drop unnecessary includes
> - Accept lower case regulator names from devicetree
> - Use virqs mapped in core MFD driver
> v2:
> - Add driver for regulator
> ---
>  drivers/regulator/Kconfig            |   9 +
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/pf1550-regulator.c | 362 +++++++++++++++++++++++++++++++++++
>  3 files changed, 372 insertions(+)
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 6d8988387da4599633ca9bde2698b9711e34a245..de455887f9aeeada5546e44b8dc9d7ed041618a6 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1049,6 +1049,15 @@ config REGULATOR_PV88090
>  	  Say y here to support the voltage regulators and convertors
>  	  on PV88090
>
> +config REGULATOR_PF1550
> +	tristate "NXP PF1550 regulator"
> +	depends on MFD_PF1550
> +	help
> +	  Say y here to select this option to enable the regulators on
> +	  the PF1550 PMICs.
> +	  This driver controls the PF1550 regulators via I2C bus.
> +	  The regulators include three bucks and three ldos.
> +
>  config REGULATOR_PWM
>  	tristate "PWM voltage regulator"
>  	depends on PWM
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index c0bc7a0f4e67098c50ac3cf887ae95f46b2eac44..891174b511fc0653bac662c71659498122e8441f 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -125,6 +125,7 @@ obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
>  obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
>  obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
>  obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
> +obj-$(CONFIG_REGULATOR_PF1550) += pf1550-regulator.o
>  obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
>  obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
>  obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
> diff --git a/drivers/regulator/pf1550-regulator.c b/drivers/regulator/pf1550-regulator.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..af448a5188640239cf446576d3133c59ebdb7307
> --- /dev/null
> +++ b/drivers/regulator/pf1550-regulator.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// pf1550.c - regulator driver for the PF1550
> +//
> +// Copyright (C) 2016 Freescale Semiconductor, Inc.
> +// Robin Gong <yibin.gong@freescale.com>
> +//
> +// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> +// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +//
> +// This driver is based on pfuze100-regulator.c
> +//
> +
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +
> +#define PF1550_REGULATOR_IRQ_NR		11
> +#define PF1550_MAX_REGULATOR		7
> +
> +struct pf1550_desc {
> +	struct regulator_desc desc;
> +	unsigned char stby_reg;
> +	unsigned char stby_mask;
> +};
> +
> +struct pf1550_regulator_info {
> +	struct device *dev;
> +	const struct pf1550_dev *pf1550;
> +	struct pf1550_desc regulator_descs[PF1550_MAX_REGULATOR];
> +	struct regulator_dev *rdevs[PF1550_MAX_REGULATOR];
> +};
> +
> +static const int pf1550_sw12_volts[] = {
> +	1100000, 1200000, 1350000, 1500000, 1800000, 2500000, 3000000, 3300000,
> +};
> +
> +static const int pf1550_ldo13_volts[] = {
> +	750000, 800000, 850000, 900000, 950000, 1000000, 1050000, 1100000,
> +	1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000,
> +	1800000, 1900000, 2000000, 2100000, 2200000, 2300000, 2400000, 2500000,
> +	2600000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
> +};
> +
> +static int pf1550_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> +{
> +	int id = rdev_get_id(rdev);
> +	unsigned int ramp_bits = 0;
> +	int ret;
> +
> +	if (id > PF1550_VREFDDR)
> +		return -EACCES;
> +
> +	if (ramp_delay < 0 || ramp_delay > 6250)
> +		return -EINVAL;
> +
> +	ramp_delay = 6250 / ramp_delay;
> +	ramp_bits = ramp_delay >> 1;
> +
> +	ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg + 4, 0x10,
> +				 ramp_bits << 4);
> +	if (ret < 0)
> +		dev_err(&rdev->dev, "ramp failed, err %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static const struct regulator_ops pf1550_sw1_ops = {
> +	.list_voltage = regulator_list_voltage_table,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.set_voltage_time_sel = regulator_set_voltage_time_sel,
> +	.set_ramp_delay = pf1550_set_ramp_delay,
> +};
> +
> +static const struct regulator_ops pf1550_sw2_ops = {
> +	.list_voltage = regulator_list_voltage_linear,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.set_voltage_time_sel = regulator_set_voltage_time_sel,
> +	.set_ramp_delay = pf1550_set_ramp_delay,
> +};
> +
> +static const struct regulator_ops pf1550_ldo1_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_table,
> +	.map_voltage = regulator_map_voltage_ascend,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +};
> +
> +static const struct regulator_ops pf1550_ldo2_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_linear,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +};
> +
> +static const struct regulator_ops pf1550_fixed_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_linear,
> +};
> +
> +#define PF_VREF(_chip, match, _name, voltage)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = 1,	\
> +		.ops = &pf1550_fixed_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.min_uV = (voltage),	\
> +		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +		.enable_mask = 0x1,	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +	.stby_mask = 0x2,	\
> +}
> +
> +#define PF_SW1(_chip, match, _name, mask, voltages)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = ARRAY_SIZE(voltages),	\
> +		.ops = &pf1550_sw1_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.volt_table = voltages,	\
> +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +		.vsel_mask = (mask),	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,	\
> +	.stby_mask = (mask),	\
> +}
> +
> +#define PF_SW3(_chip, match, _name, min, max, mask, step)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = ((max) - (min)) / (step) + 1,	\
> +		.ops = &pf1550_sw2_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.min_uV = (min),	\
> +		.uV_step = (step),	\
> +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +		.vsel_mask = (mask),	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,	\
> +	.stby_mask = (mask),	\
> +}
> +
> +#define PF_LDO1(_chip, match, _name, mask, voltages)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = ARRAY_SIZE(voltages),	\
> +		.ops = &pf1550_ldo1_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.volt_table = voltages, \
> +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +		.vsel_mask = (mask),	\
> +		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +		.enable_mask = 0x1,	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +	.stby_mask = 0x2,	\
> +}
> +
> +#define PF_LDO2(_chip, match, _name, mask, min, max, step)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = ((max) - (min)) / (step) + 1,	\
> +		.ops = &pf1550_ldo2_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.min_uV = (min),	\
> +		.uV_step = (step),	\
> +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +		.vsel_mask = (mask),	\
> +		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +		.enable_mask = 0x1,	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +	.stby_mask = 0x2,	\
> +}
> +
> +static struct pf1550_desc pf1550_regulators[] = {
> +	PF_SW3(PF1550, "sw1", SW1, 600000, 1387500, 0x3f, 12500),
> +	PF_SW3(PF1550, "sw2", SW2, 600000, 1387500, 0x3f, 12500),
> +	PF_SW3(PF1550, "sw3", SW3, 1800000, 3300000, 0xf, 100000),
> +	PF_VREF(PF1550, "vrefddr", VREFDDR, 1200000),
> +	PF_LDO1(PF1550, "ldo1", LDO1, 0x1f, pf1550_ldo13_volts),
> +	PF_LDO2(PF1550, "ldo2", LDO2, 0xf, 1800000, 3300000, 100000),
> +	PF_LDO1(PF1550, "ldo3", LDO3, 0x1f, pf1550_ldo13_volts),
> +};
> +
> +static irqreturn_t pf1550_regulator_irq_handler(int irq, void *data)
> +{
> +	struct pf1550_regulator_info *info = data;
> +	struct device *dev = info->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int i, irq_type = -1;
> +	unsigned int event;
> +
> +	for (i = 0; i < PF1550_REGULATOR_IRQ_NR; i++)
> +		if (irq == platform_get_irq(pdev, i))
> +			irq_type = i;
> +
> +	switch (irq_type) {
> +	/* The _LS interrupts indicate over-current event. The _HS interrupts
> +	 * which are more accurate and can detect catastrophic faults, issue
> +	 * an error event. The current limit FAULT interrupt is similar to the
> +	 * _HS'
> +	 */
> +	case PF1550_PMIC_IRQ_SW1_LS:
> +	case PF1550_PMIC_IRQ_SW2_LS:
> +	case PF1550_PMIC_IRQ_SW3_LS:
> +		event = REGULATOR_EVENT_OVER_CURRENT_WARN;
> +		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
> +			if (!strcmp(rdev_get_name(info->rdevs[i]), "SW3"))
> +				regulator_notifier_call_chain(info->rdevs[i],
> +							      event, NULL);
> +		break;
> +	case PF1550_PMIC_IRQ_SW1_HS:
> +	case PF1550_PMIC_IRQ_SW2_HS:
> +	case PF1550_PMIC_IRQ_SW3_HS:
> +		event = REGULATOR_EVENT_OVER_CURRENT;
> +		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
> +			if (!strcmp(rdev_get_name(info->rdevs[i]), "SW3"))
> +				regulator_notifier_call_chain(info->rdevs[i],
> +							      event, NULL);
> +		break;
> +	case PF1550_PMIC_IRQ_LDO1_FAULT:
> +	case PF1550_PMIC_IRQ_LDO2_FAULT:
> +	case PF1550_PMIC_IRQ_LDO3_FAULT:
> +		event = REGULATOR_EVENT_OVER_CURRENT;
> +		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
> +			if (!strcmp(rdev_get_name(info->rdevs[i]), "LDO3"))
> +				regulator_notifier_call_chain(info->rdevs[i],
> +							      event, NULL);
> +		break;
> +	case PF1550_PMIC_IRQ_TEMP_110:
> +	case PF1550_PMIC_IRQ_TEMP_125:
> +		event = REGULATOR_EVENT_OVER_TEMP;
> +		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
> +			regulator_notifier_call_chain(info->rdevs[i],
> +						      event, NULL);
> +		break;
> +	default:
> +		dev_err(dev, "regulator interrupt: irq %d occurred\n",
> +			irq_type);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pf1550_regulator_probe(struct platform_device *pdev)
> +{
> +	const struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
> +	struct pf1550_regulator_info *info;
> +	int i, irq = -1, ret = 0;
> +	struct regulator_config config = { };
> +
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	config.regmap = dev_get_regmap(pf1550->dev, NULL);
> +	if (!config.regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get parent regmap\n");
> +
> +	config.dev = pf1550->dev;
> +	config.regmap = pf1550->regmap;
> +	info->dev = &pdev->dev;
> +	info->pf1550 = pf1550;
> +
> +	memcpy(info->regulator_descs, pf1550_regulators,
> +	       sizeof(info->regulator_descs));
> +
> +	for (i = 0; i < ARRAY_SIZE(pf1550_regulators); i++) {
> +		struct regulator_desc *desc;
> +
> +		desc = &info->regulator_descs[i].desc;
> +
> +		if (desc->id == PF1550_SW2 && pf1550->dvs_enb) {
> +			/* OTP_SW2_DVS_ENB == 1? */
> +			desc->volt_table = pf1550_sw12_volts;
> +			desc->n_voltages = ARRAY_SIZE(pf1550_sw12_volts);
> +			desc->ops = &pf1550_sw1_ops;
> +		}
> +
> +		info->rdevs[i] = devm_regulator_register(&pdev->dev, desc,
> +							 &config);
> +		if (IS_ERR(info->rdevs[i]))
> +			return dev_err_probe(&pdev->dev,
> +					     PTR_ERR(info->rdevs[i]),
> +					     "failed to initialize regulator-%d\n",
> +					     i);
> +	}
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	for (i = 0; i < PF1550_REGULATOR_IRQ_NR; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						pf1550_regulator_irq_handler,
> +						IRQF_NO_SUSPEND,
> +						"pf1550-regulator", info);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed: irq request (IRQ: %d)\n",
> +					     i);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id pf1550_regulator_id[] = {
> +	{ "pf1550-regulator", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_regulator_id);
> +
> +static struct platform_driver pf1550_regulator_driver = {
> +	.driver = {
> +		   .name = "pf1550-regulator",
> +		   },
> +	.probe = pf1550_regulator_probe,
> +	.id_table = pf1550_regulator_id,
> +};
> +module_platform_driver(pf1550_regulator_driver);
> +
> +MODULE_DESCRIPTION("NXP PF1550 regulator driver");
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.49.0
>
>

