Return-Path: <linux-pm+bounces-19069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D4B9ED75A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 21:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0472821F1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A5820CCDB;
	Wed, 11 Dec 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mzQw18Bj"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE1209695;
	Wed, 11 Dec 2024 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949590; cv=fail; b=F96XmLNeAOR6BLUkL78LkaZXdOTqm0CNEdy4+4b3BB3mPVPyp8wFsrAm01Ho1mQPAx+IQwHqA6Ofi6dXbTqDqXc+k9EMawrv4Aef91dDNsTNUoOUklPFjixOPtyakCr09JzSbnYOjgWl7yQUWrR0LEATfG5oIST76whoKIGa06E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949590; c=relaxed/simple;
	bh=LpdGjUFE7EGgmVT2o45GNXLPu7vCNSnE7cUQVWA0dMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eYmr0I9UT8tmI1Tfj7tCxavSAKuhaQUGI5FcXZJX8OI8hL/2aXkfmaDLIhTNJSXw3CuEaLA5foCCAe3I1c/6TaKdPFBbAHLFtMkAylah7+jJ8C+7c4bvZre2NwpOkQGJgAa1kckcz9PqEgfzDxgUe23bJbl9rxm5U5FpNgYmfFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mzQw18Bj; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7xgpoeHkJOQRj3sfY62gGZMHp6b2BYW+b7j3s38nXaI8AjZkKA1H8ETELNXAgEppSZrk8yTIAbvk4BmWOKnnTqUEA2M5grNQ7rdWyOgPnWQ9U6ZgSqeWvB0CTIi7goR4d91yet+b+x39U2EOR+AqNhVJZjyXkI2T+7wabtnAy9M8wZCFNxkD+scgiEzb978u+G/W2Wbs4LEazIKSocrwyekb/3dWY+wQsAKwrlmi6vxEiMMMgOt6ByU4uN76aKuKS8BPjXjwjdtY3R3JJHeoe3sjrQR0FC64Nk/wED7ySlCon6e8BrpyCNL6hb8kyXHbB6dvv+gOQoCpNN1lGNoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2MGIfYEiZ5X6IvfTH4LzmPSce9oxpUumYii5EGevXo=;
 b=t/p+URLiQA3phQsClrVMH7eJqCgHSE0v9zlB/CdpHh3uCipuh6GH1bHtuoONXjac+x3/6hxG0Nc+VtZ5gWha+hQ2P+zJot7MltslCn73ouyupfW9cdIo16M/xE+zM5BfnGg3NjABTn5zbTf0/4IgwBjhgq50AyMohaCLZ3/nB3UxQiCJJZjk+ll6NgwcszWCZZdnx/qfIgoKsShcvwISagAbTEAARZQQ9GEaunSzslMxkwlo4JfZdb79lGVg5PtoNSe/sBFNNRTiAEUrYWvNgqN9bC6Lklhj+habw9Ox37xrF4kGPqnb4RYL3jQj6ouvGKTdICsLi91w7esERLvcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2MGIfYEiZ5X6IvfTH4LzmPSce9oxpUumYii5EGevXo=;
 b=mzQw18BjJLitNPul6gkiQWdPto+34v6fMIeIG7OfRLD6VOGKa1+dCPfJ2P99jvbHk6OBayvv46rMXiWMssIEQlfq05eOsUaR3R0BlNKBoX45tRjwNEnA3BtpdY2Latr/cjetCWrih5TJvSogGXlDo9UHKcrk7XPAtxgjjuOK8b5jraa5CJVrX8magZt38Bdppldd6yVDeFQ0iTbRAyUeEM+4hFrbLFbspOIOSZKnF2ORr7y0YL4Urnmt3dxe9FrtwEAWZBsx0OeRmrbI8bfg6dZC6nhXAwi/SNIicPDY020UDDuZLLzjVEBTe7/tM0PCzM7qUcx9aLQybz9Kb9mIRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10313.eurprd04.prod.outlook.com (2603:10a6:10:56a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 20:39:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:39:45 +0000
Date: Wed, 11 Dec 2024 15:39:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <Z1n4h/AxzthB0V9l@lizhi-Precision-Tower-5810>
References: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
 <20241210-imx91tmu-v2-2-5032aad4d88e@nxp.com>
 <20241211154622.f2jwwrqansk6il3o@pengutronix.de>
 <Z1m+O1UV4HD+7Rr2@lizhi-Precision-Tower-5810>
 <20241211185705.7b5uw26loobibzln@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211185705.7b5uw26loobibzln@pengutronix.de>
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10313:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3dfaf9-b0da-4873-e54f-08dd1a23f271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7dtSP1XEhXuRLp5/oMFflGoiBIsQyhwhTGOreIFBSjHW6a7+RQjT2iWdSr1?=
 =?us-ascii?Q?OBe85UWSB3p4RmW61wb5dIBsLn3afEkrlp9JjKBcM4ISsoQL0SUg6lyMx1VY?=
 =?us-ascii?Q?9/vdkDhDr6zkqBXtvt1ihA/O/GhdggI9uKsxUhaR3y1zUH3ncFQq4cCmq0lG?=
 =?us-ascii?Q?XmuiIzB92BcbTJTOMO/upNljO9gVUa7fA8+Hupz6ZRMaP1qlFLbRWK2+uvGq?=
 =?us-ascii?Q?Gt3TfF1cgfPidzkVrg24ELoKf7kJHCToao+CBeUmbV+hLEYTRCv3G+xvAEcu?=
 =?us-ascii?Q?EpT+COpvthWyx9+c9q76LO9Wc2qYpO8P4Ps8hjQShnF6ez/Gw33Wc7zU36GF?=
 =?us-ascii?Q?t31OmnMwETnVQcn/SbExVURceeyWXDrlDm+hwP2xxhFnwM3jbOP14G2B8KLb?=
 =?us-ascii?Q?lWL44kI0Ew8cMlKZWCn+OEx8MCBHoEnUj3pAcTaC+rTd92qgWF4gqUIC0ArJ?=
 =?us-ascii?Q?CkhmE6tBtpPFPBKStA/kfcqo4xIVGq6EtxHhbgiMhfg2VpR3gSv8IJOiHsIo?=
 =?us-ascii?Q?ihFER6ynmpRHP+zN3ZnfE9BanCgX0hdNZk/awlj7Vd6Fjhn7OHw6YeQQXLX6?=
 =?us-ascii?Q?DwSM45bMGtVaVHcMuGKEhvTuKeSWpXi9B8T70DuFJPFm1ZdvYMGmRu6naAKo?=
 =?us-ascii?Q?IU4W5PxskAv8mOy7vAhuKIMp16XnITj1hDkdbA0M4zVCNIRX3a71wmmj0jVN?=
 =?us-ascii?Q?IrUwXxj0S2/D0zswyp9uttWsDNwL1Cf+u7+Rvv/Q9FfXC/Eds3Y6MggbuYXA?=
 =?us-ascii?Q?xJQVdUicw1D690GVTiELcuILjhZyFwWmyyD2YQEroStm5mW0JJxPT8xUfFul?=
 =?us-ascii?Q?McqaTN2rR+uKEYjZQ4e020LsmETauUvPeTWm+axv04KW3AKlnppR56Jhaqmj?=
 =?us-ascii?Q?t8N0gIBuoYel+eJ38Bia9pJAZNccPel7qWvyv7xiXR+8Jwqu+tp6ZKAUBinx?=
 =?us-ascii?Q?u9aeJqqRH9SePDbA7c0YgSG7Lf87D850r74x8cFKZ4srWRUMRtdtuMTdhHi7?=
 =?us-ascii?Q?Vr5RSY5DMnje0+UQSihU2/L4nO+cnaL8HMgikiU2cPl/uH0tDwZyIBRzfo8C?=
 =?us-ascii?Q?ZexFs4Z/YfJ7xxJinEgg0ETWeWOo19zZGVMeFY3lhF1YZ/g946VPCnofZ0DD?=
 =?us-ascii?Q?z/fGNlC+MPmFhyWcN0yfCB77YYw6Tq3F4q38vk/lCLAANbhXcKaIWPZJjZ9a?=
 =?us-ascii?Q?znnDd7Gy0zRhzlTSaSBh84e0V8JAW+JHOxtNzGFXUyiPSucaU6yXxYPzyMjR?=
 =?us-ascii?Q?QNPSYlTlGcup0GIRSC9bsLSrxCK6nYk/Ky0t6XtkGKbAQIQXCZBLwgDml3WT?=
 =?us-ascii?Q?Hga2Y7aMb4CdbWn0Wf5FnD3aoc64H45MghIWckL7vggbI/co3Zh95moIuzy0?=
 =?us-ascii?Q?N70DxyWF4u3mybu519xwCl2wB4Rld7JC/635KjmJijokFvlLLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1REVnwsDtzVK2hHBxPRh4E8Enagb57zB6EJWC8aqVXldAK8ZWLSfrmmax04R?=
 =?us-ascii?Q?sBHgc5WP0hmrCf5Vxb3ZnWpNWzDb2x7YtFpVYCcX1p/XuYQ86Exgeg55Nexm?=
 =?us-ascii?Q?sEFa/AwLcMlOX8TXeLOc6bwWh3CRdZK98obxCN97QOGpFSzBHfVJ93qHWapM?=
 =?us-ascii?Q?BGO6DcN6eA2tZCG8OK8Hdf+dWRbLACG5O9cEDpIQ8tvSPL5uxEiAR0/6pbkz?=
 =?us-ascii?Q?4Y0J3rRjPtQmKba6MJPL15P2H+U0PcMoAT9Ck/Fg2iFWxtvLj/pYZqbiudH2?=
 =?us-ascii?Q?4sat0pv+4qrXBxLxLQDDRXd6z/R4cPtRDMgRVQWcx3Yym5CISDUdNiIY7PLO?=
 =?us-ascii?Q?AKDZQWA9bDAfMG/8pY7ACTWu88jE6ulv5f+BR38VlSe2Pbhqm8K7WZ7nLjUr?=
 =?us-ascii?Q?HTMzeK2Fk50XhpB+XOv9fsCUEhVrBmqKnPrgWIl3I+CE5QL7yb9hJHEk0MBp?=
 =?us-ascii?Q?C2yzkRibgNZRNJyzGPmK/lBOlzP/3A/tM0CVjQAgYZypnAP4a5ok8eHk5lqM?=
 =?us-ascii?Q?4aP7tYb+QUOwOja+fxSM0UldyTj484H9SUMTTEB5kzs58BbB6NGL8OkRdPDe?=
 =?us-ascii?Q?SAGM16XhKlI/si5TnlqNLlQg1huKdwOzWamANRfo6ZAx571fAbJzyYYvhnZ0?=
 =?us-ascii?Q?B6ZivNHugR0z19mpgnPt7VnWvEVZJ8fchapjO8O05nDKxRbZfaJmxW7mPrgp?=
 =?us-ascii?Q?UR0CP2R7xYh6j5y7WdecnqeG5C/LAkXHW3N2voRuxWo2TnO3kJaCqHewU+o7?=
 =?us-ascii?Q?30Vqpknuy1SaEysym8aaVVqRS+zQFv8RsYwKcb+Aesfd9s1Gey3E1Cu6KzHi?=
 =?us-ascii?Q?yb6ofK+8lmqVzhB0H34tLbdmXLR44my50tI7kqaFv5aW1o20COInnbxqGxLz?=
 =?us-ascii?Q?pAFfH0BcgBnpyRI+wmb/97tnEVnXhdzUgtnCuPLqSlRhgHSCMej9LdvoJTaH?=
 =?us-ascii?Q?6CyUYC7BLH8EitqMBHbPBeOPsDc5kW88EDAc2zonlkkazrLFMZYTmHV0keQa?=
 =?us-ascii?Q?z0SRr780uoGpIGar7YAmMl4dk+OVfx+cFGcSrhvpCF4sQvGmhrElkLPcQxvR?=
 =?us-ascii?Q?zfFQVes+dyhat4gHx9Q7deNXrvkpkwkG1wqF/geR42Ne2+lLzF4FWHeiYavA?=
 =?us-ascii?Q?AlDZfqs0Tuc6v2uW2r6wB/ZzZSZihi0Fodj295q3ocXxeZxMoW150vKJramX?=
 =?us-ascii?Q?fdXlnsROw0i6XnrTxGxUk29v8k0q7uLKNSLZkZsmyygkzki+eFZ10++XgWVC?=
 =?us-ascii?Q?rDGOBjwfFwfRcx5mCQWALIPr90MhSMzqLfE6gqOSSl6vlDRplR1okwhYt+k6?=
 =?us-ascii?Q?O4Ba9FV8cMuTJf4TfteEZRmIBTXI7+xfo9KFaAUAd0ylbPed3xJnNkRJsZFg?=
 =?us-ascii?Q?HuprRRz5JuoPMYUgA2t79dwqNqOQdBTRVOURcIMnCnp6zRU2e0G31kUnZkl0?=
 =?us-ascii?Q?Ye/aZ1poTAW/5gAbq3Q95bdioV5N9tu28oXNaBx23sTa9ZD4ucypyA5FAZwL?=
 =?us-ascii?Q?w0aLYzxA3YWh7QCHlojGjDE3/9+GJCoPWJoiJAtpepxYCK/8DKXhwqaJJ4Yj?=
 =?us-ascii?Q?LuDivOQtYowAFrx18t/SDiV8earF8Z9/DPiB2ydz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3dfaf9-b0da-4873-e54f-08dd1a23f271
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:39:45.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHMuKwMFyTA0nBqILdVdXGxqurnhZeE5/5919TbQhq6u3K0NQQQc6h+U51pbegxhC7ewHTxCfGtoOoZcOEHJFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10313

On Wed, Dec 11, 2024 at 07:57:05PM +0100, Marco Felsch wrote:
> On 24-12-11, Frank Li wrote:
> > On Wed, Dec 11, 2024 at 04:46:22PM +0100, Marco Felsch wrote:
> > > On 24-12-10, Frank Li wrote:
> > > > From: Pengfei Li <pengfei.li_1@nxp.com>
> > > >
> > > > Introduce support for the i.MX91 thermal monitoring unit, which features a
> > > > single sensor for the CPU. The register layout differs from other chips,
> > > > necessitating the creation of a dedicated file for this.
> > > >
> > > > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > change from v1 to v2
> > > > - use low case for hexvalue
> > > > - combine struct imx91_tmu and tmu_sensor
> > > > - simplify imx91_tmu_start() and imx91_tmu_enable()
> > > > - use s16 for imx91_tmu_get_temp(), which may negative value
> > > > - use reverse christmas tree style
> > > > - use run time pm
> > > > - use oneshot to sample temp
> > > > - register thermal zone after hardware init
> > > > ---
> > > >  drivers/thermal/Kconfig         |  10 ++
> > > >  drivers/thermal/Makefile        |   1 +
> > > >  drivers/thermal/imx91_thermal.c | 265 ++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 276 insertions(+)
> > > >

[...]

> > > > +	platform_set_drvdata(pdev, tmu);
> > > > +
> > > > +	/* disable the monitor during initialization */
> > > > +	imx91_tmu_enable(tmu, false);
> > > > +	imx91_tmu_start(tmu, false);
> > >
> > > No need to disable it here since both bits (ENABLE and START) are 0
> > > after a reset.
> >
> > Maybe uboot enable it. We can't depend on reset value without really set
> > hardware reset bit.
>
> So the module can't be rested e.g. by disabling module power? Having a
> dedicated reset mechanism would be much simpler instead of writing each
> reg-field to the default value.

Not all module can be power off individual. Normally, it should have sw
reset bit in controller. but I have not find it in this module.

>
> > > > +	ret = imx91_init_from_nvmem_cells(tmu);
> > > > +	if (ret) {
> > > > +		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
> > > > +		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
> > > 			^
> > > Can you please anwer if _relaxed API is sufficient? I don't know why you
> > > making use of the _relaxed API here anyway. We have only a few MMIO
> > > accesses here, so why can't we use the writel() instead? This applies to
> > > the whole driver.
> >
> > There are not big difference writel_relaxed() or writel() for this driver.
> > Just original owner pick one.
>
> NACK, the difference is that _relaxed() APIs don't guarantee the order
> the register access is done.

It is totally wrong. *_relexed() API can guarantee the register access
order. Only can't guarantee order with other memory. such as

1 writel_related(A, 0)
2. x = 3
3 writel_related(B, 1)

Hardware/memory model, require B=1 must be after A=0, but not necessary
after x=3, that's means (2) x=3 may happen after 3.

if use writel(), guarantee 1, 2, 3 as order.  Here have not DMA involved.
So not any impact if (2) after (3).

Typically, only below case have to use writel().
2 (update DMA descritpor), 3 start DMA,

Additional, writel() also can't guarantee register access is done!!!!

writel() just means you send a write command to bus. Not guarantee to reach
target module. typical case is

writel(A, 0);
udelay(1);
writel(A, 1);

The interval between A=1 and A=0 may less than 1us if timer have not use
MMIO register. (arm system counter).

In this driver, the only valuable benefit by using writel() instead of
writel_relexed() is "short function name".

>
> > > > +	}
> > > > +
> > > > +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> > > > +	rate = clk_get_rate(tmu->clk);
> > > > +	div = (rate / 4000000) - 1;
> > > > +	if (div > FIELD_GET(DIV_MASK, DIV_MASK))
> > > 			^
> > > This misuse the FIELD_GET() API. Instead please add a define e.g. DIV_MAX.
> >
> > I don't think so, It avoid define another macro DIV_MAX, which may miss
> > defined, the related marco should come from one source.
> >
> > For example:
> >
> > DIV_MASK is GENMASK(23, 16),  DIV_MAX is 256. But if hardware upgrade,
> > DIV_MASK to GENMASK(24, 16), DIV_MAX is quite easy to forget update it and
> > hard to find such mis-match when div value < 256.
>
> We not talking about "possible" other HW. For now it's just this one and
> using FIELD_GET() this way is seems odd, at least to me.

If you look implement of FIELD_GET()
(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));, it will be
reasonable.

Hardware IP may update in future, bitwidth of field may expand.

>
> > > > +		return -EINVAL;
> > > 			^
> > > 		dev_err_probe()
> > > > +
> > > > +	/* Set divider value and enable divider */
> > > > +	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
> > > > +
> > > > +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> > > > +	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
> > > 		^
> > > You dont need to repeat the default value, so this line can be dropped.
> > >
> > > > +
> > > > +	/*
> > > > +	 * Set resolution mode
> > > > +	 * 00b - Conversion time = 0.59325 ms
> > > > +	 * 01b - Conversion time = 1.10525 ms
> > > > +	 * 10b - Conversion time = 2.12925 ms
> > > > +	 * 11b - Conversion time = 4.17725 ms
> > > > +	 */
> > > > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x3), tmu->base + CTRL1_CLR);
> > > > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x1), tmu->base + CTRL1_SET);
> > >
> > > Same here, you repeat the module default after reset, so please drop it.
> > >
> > > > +	writel_relaxed(CTRL1_MEAS_MODE_MASK, tmu->base + CTRL1_CLR);
> > > > +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, CTRL1_MEAS_MODE_SINGLE),
> > > > +		       tmu->base + CTRL1_SET);
> > > > +
> > > > +	clk_disable_unprepare(tmu->clk);
> > >
> > > Drop this, and
> > >
> > > > +	pm_runtime_set_suspended(dev);
> > >
> > > replace this with: pm_runtime_set_active();
> >
> > No big difference, if set_active, we need add Enable TMU here. I can
> > change to set_active.
>
> You don't need to manually disable the clock, it would be done by the
> runtime-pm.

Yes, runtime-pm can disable clock, but it need align harware and run time
state before enable runtime pm.

There are two options
1 disable all hardware resources and pm_runtime_set_suspended()
2. enable all hardware resources and set_active()

After algned, use runtime pm API to controller it.

I choose option1, you prefer option 2.

Frank
>
> Regards,
>   Marco
>
>
[...]
> > > > +
> > > > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> > > > +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
> > > > +MODULE_LICENSE("GPL");
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > > >
> >

