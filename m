Return-Path: <linux-pm+bounces-27441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DFABEA2B
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 05:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB093A6971
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6CC22B5AB;
	Wed, 21 May 2025 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ybzhy1xs"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D1482EB;
	Wed, 21 May 2025 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796953; cv=fail; b=CzGVVlJqUxYUPKwknGILkt+tbn9Yip1TRvJ068+8Elfzc4Xo+c3V8oT8p8UY5gRWvKw7BanQ02YmoKiwNzOhKt1mV84lXIS93kk73iuN7wd+YMxrDOOHvUdMJ5R7ssjzTHIjWC/o4z0PsD5YI/74mkhXggtVQVa+uzbIXFO0Hec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796953; c=relaxed/simple;
	bh=EpFQITfV2x+JNUeVhrzpxiJRV5fATi0Q+mPAWlLzVLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZHUR1h5puIG6peYcWxJM2Hnfw0ZggT+yc2igmChuIORLmuFIWuilAXMnBT3SctWUdvUAKjkJc2OvZ/Lo8UjQJekBmKuzwZ9Dtjiv3opvSz6AAPbRVb7xI4cyT3OqmIK9BMBBJJPGL12dzEaC0PV+N6hYBoR9wL2rvQ/khdSzH4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ybzhy1xs; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eswMC1JUWYJd5dapwIRN3eaZB0jS7esCRP64cfq1DmVTHhUE4PvZ2bkQV5QbrFpLjWvgQnZGzv9U2owHe35X0qWt7LcpSj/E80xApGo5mo4DMkYtfOMVN5/UXvwKLzlax6grWljye0RPPW9EWMb6YPG2NzwXdwocWl9/iF2hIXoRkL4aSe12cl29y6VN4FN6PWpYypszEHPml4XTPt0jn0CQ/XLYrqqJEmeZCUr2xF+sYqeeOXZqcNDzQs2pXxNWXdHn6cokq5K6eLP3a2lcwpaR5njb0bYBZBomykb1Z4ISDE/UH/JOMERgc3HSPqyuge1T6uCtJsH1i+FXbp2hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HjXAoR1reKAB/RCOzdr+P+s70O1R9Ce5Q+dFWWjT5I=;
 b=mIP6R+W5+0ZaVd9f5+wyl1jeEfLBNcj06XHcn2pJ9FdZ8tMUfrJ1cCrAR4CIfgxj/sUoIbKGcJqUNT9b9S+iAXrxP1IVIDtTCVq5xvo+E/5/pkyMxBznhuavBBKloCSzkn0mrvbf2FZe8F6BmI9ZfPxACWJPYZyrpLnhY32FsS1XM8mkxHQSX71ikTcFx01YS7MKgyJSHb9CjJoclYDN/9zVFuPC1otyX1E4jD6ekRUZ/NgTjgM5GpOeN3vOckyJjkLBIN5CnURGKBM6xChrx1HZwoxHYGbBwwXJczQlBaxUJa5Hy4KG16osgkbBGACcln3kGgs/iZp5nSQNst1VwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HjXAoR1reKAB/RCOzdr+P+s70O1R9Ce5Q+dFWWjT5I=;
 b=Ybzhy1xsxByxVNrWNWNtMVUPXAMmvgu92RD9/hA+Cvs3E/LqMHduIIsJjnNFQAptVX1ejQQg5Kr/bnviahu0zbDrzZnVVzFNjgrLn33AHfgpZ5gG07RKWSp3CEgA3108HfcF0lNKNLbBjSRImZWYS8RxbbNtRpIu9q5GHbV3Zd23rvp2CBMElVqE1h1rQmREzHQoTztAzQ6IDmv98Z00GM01wVfYaOn7BMBDhTEvgHejW0VrLFcmcPF0vifdF5DuLxgB0RjV5xFdBoByy5gk0ugQG277KWSm09qGQly0Lx7+73/g8krYUelWcGzw2ENEeQFOhxh47/lQQXtX+My7kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7613.eurprd04.prod.outlook.com (2603:10a6:102:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 03:09:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 03:09:06 +0000
Date: Wed, 21 May 2025 12:18:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hiago De Franco <hiagofranco@gmail.com>,
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
Message-ID: <20250521041840.GB28017@nxa18884-linux>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-4-hiagofranco@gmail.com>
 <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
 <20250508202826.33bke6atcvqdkfa4@hiago-nb>
 <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
 <20250509191308.6i3ydftzork3sv5c@hiago-nb>
 <CAPDyKFpnLzk5YR3piksGhdB8ZoGNCzmweBTxm_rDX5=vjLFxqQ@mail.gmail.com>
 <20250519172357.vfnwehrbkk24vkge@hiago-nb>
 <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
 <20250521041306.GA28017@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521041306.GA28017@nxa18884-linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 479f0913-e3cf-4869-2d25-08dd9814d8b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8DBLE1a9i3RCWfcFI12nmRi0HRCvRJqJAfQwQNxwTNim+7YXmCW3jGTSA2NU?=
 =?us-ascii?Q?F0e83zDExJ8JOvusiGu340i38V2Nd+e7Y9YHYn1NFY8uHCLc2m7QYZvnrCoS?=
 =?us-ascii?Q?uNozIiA1aLsnGT5ajaPMGkViCkaol9l3ucSSNYwr662Dr/NkqSA/vDvmfGmH?=
 =?us-ascii?Q?L6NglpvSrNcutTOy2dV/RF6SNfui+juWdRc1oL7w2qhNFQr2D6jVMr0O72+R?=
 =?us-ascii?Q?IxL28qppvnf6tvG4omLVOjvQQCSkE2PBiuPwP0Y00BVE23XvxwG6t3XNJWFq?=
 =?us-ascii?Q?vT0bSiZP98a6fSKA+d6WwVeTZmUSf4TXZsVK7o50wOSFPbUXsKnv6L543Men?=
 =?us-ascii?Q?pHemaXvSwORpISJtx3ADczXL6wZDmxC6qAp6joojzD7CwLhkq/qzd1Xam5V7?=
 =?us-ascii?Q?/HfxHI2d2Q1DDkGtUB0MGVy5mjH9vMWs6+jQ8mYni8DyT7p2ryGiEQMt8uKE?=
 =?us-ascii?Q?CywGHrFPWTIw3sqSU9CS50bt/4xWfWpIL+lAvXvpQPLdM9hZ7BMGTJxEmrj0?=
 =?us-ascii?Q?VZ3M9PDRwDLXt9pRzS2sj0TNdLaTBCJqMYeLvyeZ5afg+qFhL36ilWQQSaSP?=
 =?us-ascii?Q?1xVkjQhsDKn76EyWK4g9lAeTxR0TBZG7qzWf3as3y0fnqGvcm5R0j74IgBFJ?=
 =?us-ascii?Q?dHJ6sPc6+1UeiTAmd6xjqQaJULHJsBsBzuvjnfXDgwtwNlbZjEW7LmrCsBwc?=
 =?us-ascii?Q?pwXzKh2UVCIymMP1I82SXXfdIALEQiIEi8TpwV1TxvjG2jyGU0iuRi8S5khL?=
 =?us-ascii?Q?xjsNFePPyXGeRjRSfRn+Xf67tqWxs5kNIfpx/L2alCt5CuF8UklEiLj5GMFC?=
 =?us-ascii?Q?fpBr+buZ1wZirTzgmIjC741f4puCEw39ZfXzQjLCis65cInB3qgYbX871TbP?=
 =?us-ascii?Q?DNHM8Wc4ws05ID1NR/IA169VuaN6OSxXnMZPXpfNMhbzKZC5q9X0+ZaFfcHa?=
 =?us-ascii?Q?ws/B7bRJCC+u9jjIbUzvLj7XshdRG7zN1YdTIpqHCLx4Kfmn/o1jTSDX4lkY?=
 =?us-ascii?Q?czUzujxvUlvbLgJFWqRgodazf6tHi2M7wmKDSEcFvjvf3w4TJhMc7hpqs4ia?=
 =?us-ascii?Q?hkQ4f0PawQJ+i6sPvh8rQKAJhgmmmSmZlpVMS00Rg4nMX97tbGAMq2fU8Joe?=
 =?us-ascii?Q?6Dgg+6wEGhVi/MjVGLuIgJgmwoDJT3AQ1QhGlwXDM5Soy55L3N6BsdunOKqp?=
 =?us-ascii?Q?pYVbRCJNloNd0ZjSomqs+kcVI2iD4dF347XWEUp1c9WIbkC7Fy5oewEum0l2?=
 =?us-ascii?Q?3si9FM0+/FtI8nymKjSFU5l2NSP5uRUONg5SQge/WwIx2LuelJsI/qx5BykS?=
 =?us-ascii?Q?bnm0+EsI6G3TWPHmjWzwrij4PGw3Dohx8sHYBdMH+u37GUxY5DuSiBC1+Yko?=
 =?us-ascii?Q?T+xrnvLWRAiBIPIS/DxDPpbf0IJzLg3LfmfoDmL5fXytPYidi4SlyqEDhkAb?=
 =?us-ascii?Q?3kfYMMx0WsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ASxPL5CJFGJOx3MGT9fWLvYUWrOnyoEntrVQaX9ApZSwon9Jrp8jpSZQimu?=
 =?us-ascii?Q?R+ZFRhAD/KskzKfnarZMsrJvjasVfXUqVF8fxZe4sPtlSMJIJtu+XQXbsoJu?=
 =?us-ascii?Q?TBNZPjmg/QISv6tz+58dehjpdd4FOq2V6eB2MxiJSQzia9uqCsrXZv5K9KXk?=
 =?us-ascii?Q?fPxYfDfF+vWT0kKIddtWhikGRQyzKSpWhn5xsywtXx7S3BleBs/sSFENyYUN?=
 =?us-ascii?Q?6atZd36VBH/5RX7IZK2AVr74+DLKKcP72ieMlqxZ2caO821pQxwBNJ4lSbrM?=
 =?us-ascii?Q?zojdvbnpBTKuDAXoDbxkyGqm+5MLOBe5gwjmhVFjUTTbz4s3DR4yqyCBGAZ7?=
 =?us-ascii?Q?pgr6vPviBvNudtiYw1WbhBVqqWSUc8l0F6NemSzaCva8pxw/ZA7LDHEXJYEl?=
 =?us-ascii?Q?aLIzAe/UnNbRs6thXi4UN+VcYlDSHR2VU3aEfgKSgMPicPzHMOmOiTVl5xJ3?=
 =?us-ascii?Q?0IqGLJtNNQ002yMK3acHgzNC9JRLEe7ZtirSrI6tNMH6Uxi6fm8BiLeAknB2?=
 =?us-ascii?Q?x+TNk58SAcbjebuC7MMIubD6U6V9/pvxf4DQMNO9euQkT6v7baVyVhCePZYf?=
 =?us-ascii?Q?B1JhipPbC0F3kHmFIfKwakuqo+DpkD1RSXo20E5GvFpGIr014jW/nfwrgluZ?=
 =?us-ascii?Q?Lpi9pPBqE7wAD92xkaxTHGjGu6Qs7ADInaK0ytdNr77Z5Cq3GW8Zkd+ohS6w?=
 =?us-ascii?Q?wxk5JXh0zx4qwwiavgm7pvZYEw4Ct0ZGCHDb3hBG65lFyMi7tnKBwjslLLXx?=
 =?us-ascii?Q?S1DychDHj3xtB0PG1T0RL1X0XLoXezGqIibu00ChhcSFzUTgrGLV/CU1/jnK?=
 =?us-ascii?Q?yoqboL16QLIIVRzu94D8LPofQz7QL6Fbli2s8OAkZqcFJvM9iW8lYD1R19ZO?=
 =?us-ascii?Q?/elSfeF3vlmw2zt8wp8fOe8jeT4YA3H8/XBih79xMe7vPQx5sZlBShYCK1p3?=
 =?us-ascii?Q?h885Lboc2dxWsAaMi5UTK0HweFbBWNd0bKNa0SvKl5nSbllYJyP/dmSkEsJb?=
 =?us-ascii?Q?J2cJgJKJ7pb3RDEEuBYFvX+oVizZx8ZdJVCsgTbcAmeeIzetniFyQhO5bQ0e?=
 =?us-ascii?Q?lpLWr3bJS/Ydh3MKA/b08n0oRUvP4kfzetuUf/wUF8T5zRHtwDNu5eyWcvCi?=
 =?us-ascii?Q?0dWxCa6OZsFemvZ38L/Iqw57fg9u8piuKE3JBpTkeh5/JA0JbS6r3VOMOVfV?=
 =?us-ascii?Q?6ejZ67B6E1CElke3KdjMfQOiyomtvozQryNHXKuiqDIj37BoSc1zYuSAX5L4?=
 =?us-ascii?Q?ARU75bgiAmq4CZms6+aHLGZZCqbiExdU5OULsOyKqw2txjSeTDp5UuDy845V?=
 =?us-ascii?Q?bXeaukjuC3cBttPhd6Yigaxw1GNaiW6B2zh+ok9cQrIw3GZfEPRqSntqC01y?=
 =?us-ascii?Q?+jUDwhwjwv8EmPHrkvPF3fvgw/sUmxqsTu3UyRfAvcjAdjEfBvD4/gBZ2zIh?=
 =?us-ascii?Q?PWatzah3uWXRf/xbgD4DtWmsoBslb4BdHo/dh33AAtKFJlBU2BDD+FxdcCEY?=
 =?us-ascii?Q?fZzrrTCWgJ6B59N1FXUV2LUa0DkZsg1XskOPC22KhZWi3ps36t/+rKPjYOI5?=
 =?us-ascii?Q?3fZM3eFQZBonH4nyBCR+PG3R0seeQwNUPC7W89Yi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479f0913-e3cf-4869-2d25-08dd9814d8b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 03:09:06.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWoOCEeHy6lt6bMhMBSqdVdlLy3UXpuuz+Gmydom1dq/0SSwSHPHKfNDHcSlaKEzE3/26b4aAQkfGqXyqxEFyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7613

On Wed, May 21, 2025 at 12:13:06PM +0800, Peng Fan wrote:
>Hi Ulf,
>
>On Tue, May 20, 2025 at 02:21:49PM +0200, Ulf Hansson wrote:
>>On Mon, 19 May 2025 at 19:24, Hiago De Franco <hiagofranco@gmail.com> wrote:
>>>
>>> Hi Ulf,
>>>
>>> On Mon, May 19, 2025 at 04:33:30PM +0200, Ulf Hansson wrote:
>>> > On Fri, 9 May 2025 at 21:13, Hiago De Franco <hiagofranco@gmail.com> wrote:
>>> > >
>>> > > On Fri, May 09, 2025 at 12:37:02PM +0200, Ulf Hansson wrote:
>>> > > > On Thu, 8 May 2025 at 22:28, Hiago De Franco <hiagofranco@gmail.com> wrote:
>>> > > > >
>>> > > > > Hello,
>>> > > > >
>>> > > > > On Thu, May 08, 2025 at 12:03:33PM +0200, Ulf Hansson wrote:
>>> > > > > > On Wed, 7 May 2025 at 18:02, Hiago De Franco <hiagofranco@gmail.com> wrote:
>>> > > > > > >
>>> > > > > > > From: Hiago De Franco <hiago.franco@toradex.com>
>>> > > > > > >
>>> > > > > > > When the remote core is started before Linux boots (e.g., by the
>>> > > > > > > bootloader), the driver currently is not able to attach because it only
>>> > > > > > > checks for cores running in different partitions. If the core was kicked
>>> > > > > > > by the bootloader, it is in the same partition as Linux and it is
>>> > > > > > > already up and running.
>>> > > > > > >
>>> > > > > > > This adds power mode verification through the SCU interface, enabling
>>> > > > > > > the driver to detect when the remote core is already running and
>>> > > > > > > properly attach to it.
>>> > > > > > >
>>> > > > > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
>>> > > > > > > Suggested-by: Peng Fan <peng.fan@nxp.com>
>>> > > > > > > ---
>>> > > > > > > v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
>>> > > > > > > suggested.
>>> > > > > > > ---
>>> > > > > > >  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
>>> > > > > > >  1 file changed, 13 insertions(+)
>>> > > > > > >
>>> > > > > > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
>>> > > > > > > index 627e57a88db2..9b6e9e41b7fc 100644
>>> > > > > > > --- a/drivers/remoteproc/imx_rproc.c
>>> > > > > > > +++ b/drivers/remoteproc/imx_rproc.c
>>> > > > > > > @@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>>> > > > > > >                         if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
>>> > > > > > >                                 return -EINVAL;
>>> > > > > > >
>>> > > > > > > +                       /*
>>> > > > > > > +                        * If remote core is already running (e.g. kicked by
>>> > > > > > > +                        * the bootloader), attach to it.
>>> > > > > > > +                        */
>>> > > > > > > +                       ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
>>> > > > > > > +                                                               priv->rsrc_id);
>>> > > > > > > +                       if (ret < 0)
>>> > > > > > > +                               dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>>> > > > > > > +                                       priv->rsrc_id, ret);
>>> > > > > > > +
>>> > > > > > > +                       if (ret == IMX_SC_PM_PW_MODE_ON)
>>> > > > > > > +                               priv->rproc->state = RPROC_DETACHED;
>>> > > > > > > +
>>> > > > > > >                         return imx_rproc_attach_pd(priv);
>>> > > > > >
>>> > > > > > Why is it important to potentially set "priv->rproc->state =
>>> > > > > > RPROC_DETACHED" before calling imx_rproc_attach_pd()?
>>> > > > > >
>>> > > > > > Would it be possible to do it the other way around? First calling
>>> > > > > > imx_rproc_attach_pd() then get the power-mode to know if
>>> > > > > > RPROC_DETACHED should be set or not?
>>> > > > > >
>>> > > > > > The main reason why I ask, is because of how we handle the single PM
>>> > > > > > domain case. In that case, the PM domain has already been attached
>>> > > > > > (and powered-on) before we reach this point.
>>> > > > >
>>> > > > > I am not sure if I understood correcly, let me know if I missed
>>> > > > > something. From my understanding in this case it does not matter, since
>>> > > > > the RPROC_DETACHED will only be a flag to trigger the attach callback
>>> > > > > from rproc_validate(), when rproc_add() is called inside
>>> > > > > remoteproc_core.c.
>>> > > >
>>> > > > Okay, I see.
>>> > > >
>>> > > > To me, it sounds like we should introduce a new genpd helper function
>>> > > > instead. Something along the lines of this (drivers/pmdomain/core.c)
>>> > > >
>>> > > > bool dev_pm_genpd_is_on(struct device *dev)
>>> > > > {
>>> > > >         struct generic_pm_domain *genpd;
>>> > > >         bool is_on;
>>> > > >
>>> > > >         genpd = dev_to_genpd_safe(dev);
>>> > > >         if (!genpd)
>>> > > >                 return false;
>>> > > >
>>> > > >         genpd_lock(genpd);
>>> > > >         is_on = genpd_status_on(genpd);
>>> > > >         genpd_unlock(genpd);
>>> > > >
>>> > > >         return is_on;
>>> > > > }
>>> > > >
>>> > > > After imx_rproc_attach_pd() has run, we have the devices that
>>> > > > correspond to the genpd(s). Those can then be passed as in-parameters
>>> > > > to the above function to get the power-state of their PM domains
>>> > > > (genpds). Based on that, we can decide if priv->rproc->state should be
>>> > > > to RPROC_DETACHED or not. Right?
>>> > >
>>> > > Got your idea, I think it should work yes, I am not so sure how. From
>>> > > what I can see these power domains are managed by
>>> > > drivers/pmdomain/imx/scu-pd.c and by enabling the debug messages I can
>>> > > see the power mode is correct when the remote core is powered on:
>>> > >
>>> > > [    0.317369] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_ON
>>> > >
>>> > > and powered off:
>>> > >
>>> > > [    0.314953] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_OFF
>>> > >
>>> > > But I cannot see how to integrate this into the dev_pm_genpd_is_on() you
>>> > > proposed. For a quick check, I added this function and it always return
>>> > > NULL at dev_to_genpd_safe(). Can you help me to understand this part?
>>> >
>>> > As your device has multiple PM domains and those gets attached with
>>> > dev_pm_domain_attach_list(), the device(s) that you should use with
>>> > dev_pm_genpd_is_on() are in imx_rproc->pd_list->pd_devs[n].
>>>
>>> Ok got it, thanks for sharing.
>>>
>>> I just send the v3 with the changes Peng proposed (here
>>> https://lore.kernel.org/lkml/20250519171514.61974-1-hiagofranco@gmail.com/T/#t),
>>> but I am a bit confused which path we should take, the initial approach
>>> proposed or using these PD functions. Maybe we can discuss this in the
>>> new v3 patch series?
>>
>>I think it would be better if we can avoid sharing low-level firmware
>>functions for PM domains. I am worried that they may become abused for
>>other future use-cases.
>>
>>So, if possible, I would rather make us try to use
>>dev_pm_genpd_is_on() (or something along those lines), but let's see
>>what Peng thinks about it before we make the decision.
>
>There are two power domains for this m4:
>power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
>
>So before attach the pd, dev_pm_genpd_is_on should also return false
>per my understanding. If run dev_pm_genpd_is_on after attaching the pd,
>the pd will be powered on. So we are not able to know whether M4 is started
>by bootloader or not.


Could we use PD_FLAG_NO_DEV_LINK when attach the PD, then
use dev_pm_genpd_is_on to detect the status of genpd?

we set is_off as true when pm_genpd_init if the PD is physical ON.

Thanks,
Peng

>
>Hiago's case needs the real power status before attaching the
>pd to set remoteproc as DETACHED(M4 kicked by bootloader) or OFFLINE(
>M4 not kicked by bootloader) state.
>
>Seems there is no other SCFW API to check whether M4 is started by
>bootloader.
>
>I not have good idea as of now except directly checking the real
>power status to indicate M4 started by bootloader or not. Or using a
>device tree property runtime added by bootloader,
>saying "fsl,rproc-started"?
>
>
>Thanks,
>Peng
>
>>
>>[...]
>>
>>Kind regards
>>Uffe
>

