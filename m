Return-Path: <linux-pm+bounces-27035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4ABAB2E33
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 05:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAFE1891F93
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 03:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9825485A;
	Mon, 12 May 2025 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="haAQlFS6"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5582F383;
	Mon, 12 May 2025 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747021621; cv=fail; b=T+/+Ctw0me3j1qhKL2gULWW+iifDL4KqraPnvk3S3rhqbZZmAvAeBCq3KDphxQzWEHWtqS95M5taBPQWf8JuDRtHZUIwRxfhGEc0n79xx5a9PvHT0FRq9Qd70azMKB/cV7ZZ3aiiE1DPOetxSugMkb+SDQ1zI1BPpLUR8pYJiNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747021621; c=relaxed/simple;
	bh=l5ImEIOZemAJXkDCrWG2BwI0OxawgPWHsM+VWtCmlqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F6nvyanBkUncB88ksAJw6gaKaFAnB1C53G/Tghh1iTgY3colh/6q18mbP3QoHY1yOc3bXUYXO1UQ/FzGkK7HxNs31lsxO9s1tGL0jk8LXh6skx0PmM4Y4NXYUn1RK/p42jd0XqsGsuLVZnH3mc6lnOmWuggptQJMB7O9RNeO4t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=haAQlFS6; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7M3nzejX61p0cmYLUF0N/ED83Hs57q9oRACGPtT0ucnEfkrmXE1ATDi1QtadxcQX/Gg/LMpElxSsRTQPIa6Dc7IdImbZ+TElX477mQucTk6mIeKK1EMRD/Vr+YW7X6RwqtDdZSNGzOgDBmd7SJtFJNQkolT7dzz7iQz62HIizEwUu6wCYE53O4zkk/yW0H4ug7Gn6KfOVcMJSHqv+bv3eI/+z230abiooX3fnGkBugUweLk3CZeqZIZOlu0p+kcnpOobYcDyxkw6x10L8ex4yPYfPAiXae6KsUXl3JCNQ2c4MmowitEJnwg42Ee2+M5O96DgXMdj1Mp1rA4cLRLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRdXLm2J5pQQHgcBLJseImvGOJ85of8HYr/z3girkwg=;
 b=ZVH+TrONFaP2ibGMUCHH15e7bJ2zaldjZjtdIlW1pl/7u3+QIoneXpTg49ygaXhRw91ZCbN0bMwtldxCcl6olZBufuzqV0MrnTpotBTYfO7MKwkkWiYyzVnah+/DyQ+3z6Isb3NQw7wLpGk7v19O0zN7j1INJ0sy2YExN+bxbxZT/n+KJsUNQ2ijr0rCWuoAiTFxoBYibeW7odoE8vQvmfD4iJRacmN1LdIwc3ljLtlrbf0OC9ful70rh4SbgF8eWAZTW78/3cv14YNC6nnFZMF2hWCQ9UwM/nDI1gLbRPjQ7OAJ6piYBzCiVthGHNWAMoYFfnehG78RlKGr7uMSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRdXLm2J5pQQHgcBLJseImvGOJ85of8HYr/z3girkwg=;
 b=haAQlFS627gcLyRgp/Axn930RW4hvGuEHBMptxPFg/PiOVwnUiPXnnpfDb5T+IFezssaFkqyfbChtYrydHqiimvTqyUO4N5OhtAnvhVwpkEEPKSsE5rgjeiUR9H/IGpw5ECp5+ffdcOvIGPrGWFd5jtkyo15ad/NpJZ67IsI67W8RE9xW1pBwYNtYpB0NtIlYyhgmsittvaxBoCtbI+vKxNujtg5WsQGSuvlqBfE5IE8ToTy0ZOYTam+clxYZN1Kby8VySy0cATH5nYi30gnxN2NtVIbzryOGXueMQIy/5OXu3dhHdMKTjuLsCEkQIiNaknecqxjDdppNDAhY9UdgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7696.eurprd04.prod.outlook.com (2603:10a6:102:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 03:46:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 03:46:53 +0000
Date: Mon, 12 May 2025 12:56:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250512045613.GB31197@nxa18884-linux>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-4-hiagofranco@gmail.com>
 <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
 <20250508202826.33bke6atcvqdkfa4@hiago-nb>
 <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
 <20250509191308.6i3ydftzork3sv5c@hiago-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509191308.6i3ydftzork3sv5c@hiago-nb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dd607c-b7ec-4f67-194e-08dd9107a1ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNLj4IdpKvLTlAGblBTcfI5DqcH/iGx/BdtgnrjRJMhDp73XXOi8/3JU4oM6?=
 =?us-ascii?Q?b/r2CyPHhHihlwUSdMdzM3IT6AIvqSDn2XMHssNjnJw340gLFA/zbM+krU03?=
 =?us-ascii?Q?vgS6WUpwr5SFlplPD8/vGMTfn4+2egMGlmiEZCudVnWCklvPppZWvONIt2iy?=
 =?us-ascii?Q?e0CDZpWou8QEPkjcATZBv+J6H7u/9PxFjx4JFUVmThnqjIQjtqhabwZNGC3u?=
 =?us-ascii?Q?8xkRuiyh/EqTzIwSmebyhnBhmy/BT8hEEPYVFJ694XY+AFSiYnlA1tsj2pnB?=
 =?us-ascii?Q?rmcHXw2Pcy8Ugj1mYWuK/Lk+MuTpG/s3Y9BhIhW9769Y89bCy5nR3YG/43gD?=
 =?us-ascii?Q?GbW9GEwQA5mFmH/JAnM+Q+5kyWFquH9P3Du0qmmXEwxZufIzv1CwLBFdVbuY?=
 =?us-ascii?Q?TjiJ3ArqKbN6fZr0aKvtBfk760d6BOOm0Hc1cPvNdZExiAtnT4hT5J8mlRZe?=
 =?us-ascii?Q?OoXcvOrkvupkZ6CrbuzbpiEqwJAgkCI+bibfdQGnC0+eqIfijYZRq2BnwlmY?=
 =?us-ascii?Q?/00tMXt2nXjgng5lllKtfLFDOUhkfON/uKGEv8W4XLFmdDdIlhQzqs9zLIFh?=
 =?us-ascii?Q?TOu6069f3kdW4sTCjXrQezWB/UB2XmYIhyDwQT+RGm1b9dqYad6seUZoHNlD?=
 =?us-ascii?Q?F3mtAs3NqJ8M+HAGyusA5I23WpLUDebZmQ4ftW9bxKG+llujHfL7YP8TP251?=
 =?us-ascii?Q?HIjvitmHk0ehxgLh6rdLEJUB4tYulxC1sQcrr0Jzk1Dp5+mS/ia/le8gsSsW?=
 =?us-ascii?Q?9cjDxvKUkTcgrmtNXsvq8NkHzbFSow2mJjrISmiIOzZxw12ppojuGMjkZqI4?=
 =?us-ascii?Q?S6Z5Oxmu4ymfzXeMhGfn6AXuf9EqQ0e/wbS6BmpDAyLKkjrE7QaA4fvODupd?=
 =?us-ascii?Q?sYJj6m8ASAYcBD0fWvX0htuoyxWZ0E8YLJZkN2i5Li/Ttdh+5Bm8Sth4XmMO?=
 =?us-ascii?Q?MNKVEXNnofOMcAJlHPzuTcQk9vrd3slsRmJFUSrGmUsADb4P6y82BgBsBiEA?=
 =?us-ascii?Q?o1TyVSfwYVhs4YfUazvixEOgzYl0Na+Tcdxoz1QaNtLjwDlG+Q81HQIn3vaW?=
 =?us-ascii?Q?M+gtW3z2XSgf1jfo50m0+3zMf8pjM6f8Li4BMRTRR5AjDqh2klttcukgjefI?=
 =?us-ascii?Q?gHwcPIL695yyMFKxw4vUxMa1utEq7xhsFgefmKcBkzDUHZeR/ZEOEwH1yZUC?=
 =?us-ascii?Q?02XT5CnnKndySq62V9XiSepNtUjDGDRug6lGRqXyWdQaNuyVZc4KAKzW1uPX?=
 =?us-ascii?Q?dARvTcIBCnsHL/KLz01DYSrzkevb0Z48SHQNTpBmHI86q5+xXIl9GWxIFzUT?=
 =?us-ascii?Q?Bz1s1G9+vuxq3H7PgLtJJ2IAfk5pHMwKgkVc/pBkl7h5UyVqMShdCv2dEKRd?=
 =?us-ascii?Q?dcMKcyxEnD9bCkLEEitLFRcNwDcu3VQIQPmBMIzPTKmoneEYJypej3bWLiNo?=
 =?us-ascii?Q?O7qE3IneK4YDNegZGSEETqk4kB9ZdIBwZjA7GnnL06j0uQx0v5aGnI9HA6fo?=
 =?us-ascii?Q?ydU5rnd4ORNvBH0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eT/S4rN9qlVuNZfQaZnE2729hE6NrNzwx6G66bXHKO9VfqeDrS/EKsPwDjU9?=
 =?us-ascii?Q?20ORVZbW7yhMa6HtB1yKzHPy4qYGmuSSqX3ZSS4jziTBn+zRYipuAmqu3Cvc?=
 =?us-ascii?Q?0lUIxBmTuyRusZhkbltNFqZUjrs6yg/oNp2qp5SoNP0hJzqDZkEg5hWRJhXK?=
 =?us-ascii?Q?fCeOXhF3n7wzc5DJGtWeGxCSEtjQ6WMX3pgk5wT8vWIBadhnSByRubI/7O31?=
 =?us-ascii?Q?UuNtqG7zESn1eWhvSaP3kR17XSNoFaYmja/cawJ6PgMhpSIaxhoyBa57gjzy?=
 =?us-ascii?Q?s7RDjaaMXYRV3VBzaVE3OoSCtAjNsKCat4012Ltt2RYrBYeo+C/2mYo1uX7G?=
 =?us-ascii?Q?CJXmWjA/7nCgLKYfhQe9aGsfmkd7s7NP2asEOwvDadRDVWO4xdM8MVV/hoJb?=
 =?us-ascii?Q?JvECUi0YarcOdBTcV1HMp7/PlLu8sFFES0JQ30YPxIVV8rtk5l0I6tZB8A/3?=
 =?us-ascii?Q?kgzHlcxdJat8Of1UoEP6GC6+yk0k/XGB2pkz63xyUciSOKNZp8FfYpWA+aOt?=
 =?us-ascii?Q?GpIQ1BEQFVX7YDyj9+oOhynbeHqH4HkQNeKm6mZr1cOx1zJvS0QFYFvKhTFk?=
 =?us-ascii?Q?L9fwNJz4KR9Vv55dYfOj6YSZIa2BH7kkwA7KTNhp6A+A2B2kQTbsIrIg3/5R?=
 =?us-ascii?Q?k6m0RWXIddBua/wz3FS7Vx1Zwf24hMByERkPolNITqZpqqkCiuWMYlJSE81h?=
 =?us-ascii?Q?CbuOy3GyXmbMcL4mCnGLgCTveLFnuenrMd5S6oEXkZwMJHP+3zPUFkzmPcCw?=
 =?us-ascii?Q?buQeQ43XXyUC4kYNSHkBj9O8j4rtJq2ge4uT+449CYWSiFrj619yv+8gEG8E?=
 =?us-ascii?Q?hk0FYozE5eiRTJ0nmi6XcxzKHyoyn9yjcaGgk1ftH/2onY/vQGjLvm/qMqD0?=
 =?us-ascii?Q?li0uPzHlQROocFPurdx+vO78ecC8rwKNy+e1eY6eG2sNfz+X+y7pNtVWsW37?=
 =?us-ascii?Q?z/6CRdISHaJUsOOE+PrhlmBb6nqDX6Uxpd23xzS8iwsdXyv7UMDgQb07VpJW?=
 =?us-ascii?Q?w7WH3aO+5yWJluw/AzM00dM3+BY4VUBdAvaQCupW8r379S6o6ojE6QANtc5p?=
 =?us-ascii?Q?K5AuBeIJOGCZXW+JO3vwaRtxM9xzoxu6ztkEZHUP8YHtQ1B/1KdOtD7ee7fe?=
 =?us-ascii?Q?80NeYw6LEcUUXSNIQNFHW3pSjIKUKGTCW087CCJhd851KxL5rwNylbPDwQic?=
 =?us-ascii?Q?ljCMDrPdvPVxwgtG7ZkS6v/Xn8ta0DmRWYGSToyGZLKLyb4D8+GOsQfL6AnC?=
 =?us-ascii?Q?71C5SPJWn72GmbjbpTB1VjEKKIsrms2WXkf8gHMSvSBtwhS/jc5rCBYLKmvV?=
 =?us-ascii?Q?UAHagF5cOrNWD3ZPHUHi0c9wA55QGxOFiR9JsyaAXPRl3LiGq8p0niKa8eh9?=
 =?us-ascii?Q?zGFIUhtju6k4hm03/nTUa4uT2ANhTfzCEnDvUxVYcZ02rxXnTfwCV2xg+Y7u?=
 =?us-ascii?Q?1TyquXRs5phQv6LoHWxlR5WaM4z63vxkYeMi5WbScrR14zSdgSyQxGZEx8nI?=
 =?us-ascii?Q?UP5NF0MxxukTy18+E8v9Xlk7XiR9hgfnb2T3xotPJ4NJxSpoYhtyFsw1Wie6?=
 =?us-ascii?Q?IZfud0xSvnyrsrkFSEmnsfBXhu+zT7WZilg42NXV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dd607c-b7ec-4f67-194e-08dd9107a1ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 03:46:53.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5niVtcMJdM47iozMvbA1SRz1R6YSEaYSBF1qmdqKF7SorinixxLrwnC+QnvdDfrLWsJBSFj3TwZ6FngigxBUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7696

On Fri, May 09, 2025 at 04:13:08PM -0300, Hiago De Franco wrote:
>On Fri, May 09, 2025 at 12:37:02PM +0200, Ulf Hansson wrote:
>> On Thu, 8 May 2025 at 22:28, Hiago De Franco <hiagofranco@gmail.com> wrote:
>> >
>> > Hello,
>> >
>> > On Thu, May 08, 2025 at 12:03:33PM +0200, Ulf Hansson wrote:
>> > > On Wed, 7 May 2025 at 18:02, Hiago De Franco <hiagofranco@gmail.com> wrote:
>> > > >
>> > > > From: Hiago De Franco <hiago.franco@toradex.com>
>> > > >
>> > > > When the remote core is started before Linux boots (e.g., by the
>> > > > bootloader), the driver currently is not able to attach because it only
>> > > > checks for cores running in different partitions. If the core was kicked
>> > > > by the bootloader, it is in the same partition as Linux and it is
>> > > > already up and running.
>> > > >
>> > > > This adds power mode verification through the SCU interface, enabling
>> > > > the driver to detect when the remote core is already running and
>> > > > properly attach to it.
>> > > >
>> > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
>> > > > Suggested-by: Peng Fan <peng.fan@nxp.com>
>> > > > ---
>> > > > v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
>> > > > suggested.
>> > > > ---
>> > > >  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
>> > > >  1 file changed, 13 insertions(+)
>> > > >
>> > > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
>> > > > index 627e57a88db2..9b6e9e41b7fc 100644
>> > > > --- a/drivers/remoteproc/imx_rproc.c
>> > > > +++ b/drivers/remoteproc/imx_rproc.c
>> > > > @@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>> > > >                         if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
>> > > >                                 return -EINVAL;
>> > > >
>> > > > +                       /*
>> > > > +                        * If remote core is already running (e.g. kicked by
>> > > > +                        * the bootloader), attach to it.
>> > > > +                        */
>> > > > +                       ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
>> > > > +                                                               priv->rsrc_id);
>> > > > +                       if (ret < 0)
>> > > > +                               dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>> > > > +                                       priv->rsrc_id, ret);
>> > > > +
>> > > > +                       if (ret == IMX_SC_PM_PW_MODE_ON)
>> > > > +                               priv->rproc->state = RPROC_DETACHED;
>> > > > +
>> > > >                         return imx_rproc_attach_pd(priv);
>> > >
>> > > Why is it important to potentially set "priv->rproc->state =
>> > > RPROC_DETACHED" before calling imx_rproc_attach_pd()?
>> > >
>> > > Would it be possible to do it the other way around? First calling
>> > > imx_rproc_attach_pd() then get the power-mode to know if
>> > > RPROC_DETACHED should be set or not?
>> > >
>> > > The main reason why I ask, is because of how we handle the single PM
>> > > domain case. In that case, the PM domain has already been attached
>> > > (and powered-on) before we reach this point.
>> >
>> > I am not sure if I understood correcly, let me know if I missed
>> > something. From my understanding in this case it does not matter, since
>> > the RPROC_DETACHED will only be a flag to trigger the attach callback
>> > from rproc_validate(), when rproc_add() is called inside
>> > remoteproc_core.c.
>> 
>> Okay, I see.
>> 
>> To me, it sounds like we should introduce a new genpd helper function
>> instead. Something along the lines of this (drivers/pmdomain/core.c)
>> 
>> bool dev_pm_genpd_is_on(struct device *dev)
>> {
>>         struct generic_pm_domain *genpd;
>>         bool is_on;
>> 
>>         genpd = dev_to_genpd_safe(dev);
>>         if (!genpd)
>>                 return false;
>> 
>>         genpd_lock(genpd);
>>         is_on = genpd_status_on(genpd);
>>         genpd_unlock(genpd);
>> 
>>         return is_on;
>> }
>> 
>> After imx_rproc_attach_pd() has run, we have the devices that
>> correspond to the genpd(s). Those can then be passed as in-parameters
>> to the above function to get the power-state of their PM domains
>> (genpds). Based on that, we can decide if priv->rproc->state should be
>> to RPROC_DETACHED or not. Right?
>
>Got your idea, I think it should work yes, I am not so sure how. From
>what I can see these power domains are managed by
>drivers/pmdomain/imx/scu-pd.c and by enabling the debug messages I can
>see the power mode is correct when the remote core is powered on:
>
>[    0.317369] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_ON
>
>and powered off:
>
>[    0.314953] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_OFF
>
>But I cannot see how to integrate this into the dev_pm_genpd_is_on() you
>proposed. For a quick check, I added this function and it always return
>NULL at dev_to_genpd_safe(). Can you help me to understand this part?

Ulf's new API dev_pm_genpd_is_on needs to run after power domain attached.

But if run after power domain attached, there is no API to know whether
M4 is kicked by bootloader or now.

Even imx_rproc_attach_pd has a check for single power domain, but I just
give a look again on current i.MX8QM/QX, all are using two power domain
entries.

>
>> 
>> In this way we don't need to export unnecessary firmware functions
>> from firmware/imx/misc.c, as patch1/3 does.


I think still need to export firmware API. My idea is
1. introduce a new firmware API and put under firmware/imx/power.c
2. Use this new firmware API in imx_rproc.c
3. Replace scu-pd.c to use this new firmware API.

Or
1. Export the API in scu-pd.c
2. Use the API in imx_rproc.c

With approach two, you need to handle them in three trees in one patchset:
imx/pd/rproc.

With approach one, you need to handle two trees in one patchset: imx/rproc tree,
then after done, pd tree

Regards,
Peng
>> 
>> If you think it can work, I can help to cook a formal patch for the
>> above helper that you can fold into your series. Let me know.
>> 
>> >
>> > With that we can correcly attach to the remote core running, which was
>> > not possible before, where the function returns at "return
>> > imx_rproc_attach_pd(priv);" with the RPROC_OFFLINE state to
>> > rproc_validate().
>> 
>> I see, thanks for clarifying!
>> 
>> Kind regards
>> Uffe
>
>Thank you!
>Hiago.

