Return-Path: <linux-pm+bounces-32866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA80B30D68
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 06:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EE63ABCFA
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 04:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7B26CE2A;
	Fri, 22 Aug 2025 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MReQvU3G"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8038221F06;
	Fri, 22 Aug 2025 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835884; cv=fail; b=Dp9y/oNnfzeCCNwTUkNeKJ47+6Y1zXDnOwT5yHELpPpdkxM8ATJstnHZFP0RpdY3ORr8aCcfJ+DCq4TouBM82NCQihPS4rbYOrVNJoJYxYUrsUEt87MRnUERoOLTCGNZ2yZCrm/aIeaXjB1npc6K+YBYqms+FzypqMwzN1IS9G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835884; c=relaxed/simple;
	bh=B/qCMk//T4D0OQweV910//LefOe2C6gHm8Uqj5siZgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nj1HrsquTBHGRCQK5G++mwQwbZ5acEAZCaRSefe2ckklKOmmxn4F33CE6I+02dfUiEvnIhAolyXaIRN4211FS1ntzthx2aDqXYOZtJo1dqVFGEp+fjfoxs/uwYlY8fSDS/+h4Qsg3ilN5zKeH4mnJ4QWFgqxT1Jl6E5ITbaZamo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MReQvU3G; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph3e7LMkOYoqeYllltsNcwDqJ02gVABI5dqdlYqlDZ8NTg72jdYeyGNWE1TT9Y+0eC/C2YBcwgsuYTKi3NJlg9N+J68klP76X49nKWSqfRAoUjVxlb5TnrPsb3CqmEdIeX7vERzi2VftH1mox0lhM/hj5y8Bj7n3ORrit9scbiSkcUGku//heNIecjl+w9nvKUwmxS/x9If7IzRI8fB5B0IvPnpPZPlENX6/qLTYo/NRTNWb0Nt6xB3qJkownkHCPUjoxWvrMhf91q4QY42Omx00XoshMPpwsb+ZCO3NPoUmpmcXN/CCuxN+gz5kkJVPXW/BKEol4qt1hHHdtwe0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/qCMk//T4D0OQweV910//LefOe2C6gHm8Uqj5siZgU=;
 b=QgR7Epz6kVYl52Uu+ILj714XpRLDqCXeH1v2HUZ5g/DL8SPCY4PV7C+DgSvnyVcbLaMF95xUl1wTq20sBKoh2DlRyRRunl4OFkkxDVSFPPutTJfTkyBKHASaNniC2G4wtKEBydBL4UcrRpfLVi7D4vSr865a3lDdss8lYO35H7+9f2z64VH++ysR1bNDIB3wVkt6JpCqQ+DWEFp4+j5g86D1L9LT8DsOVAmJTr+jOBdfjeUs3TGKq3hFiq//oKL4boRkHB+AGbnZEkDWr9uFyDiMpXWDabnU3aVXzuwp98cLg3LA0thKCfgNzqnI8q7GljkzUY1ekrrk28LZA/5KFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/qCMk//T4D0OQweV910//LefOe2C6gHm8Uqj5siZgU=;
 b=MReQvU3G1JH216591HMsWRjQg9pXHBKxHs7Ia3nURTB1Cb5uebCBq5quGn+PJkcE4njMuTvd29B4dPPedtJvWuzjqGhYEhA3cW/ddSmzRZ79J7ykv/YP8xXpVnfnW1W4KwZWNsx890UqkTxQfenG0vW/Zi+WguxXT1vCCve3PEka4Sm1SxKctyS4q6x4E82xjTSbQeayyGBvzDEl/3Vgv6vVkP8o22BQVJARNAcunNnNp8BLl8pw5IMtdtKqfOeBh3O89M/Kj1WxXfGLxPDKmEXhIhm/dNBfoNn6+UblsjAkx+1gdY841my14wxq/53os5Ou52nv3OdK2k9XJ/Wxqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8545.eurprd04.prod.outlook.com (2603:10a6:20b:420::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 04:11:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:11:16 +0000
Date: Fri, 22 Aug 2025 13:22:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] pmdomain: core: Introduce
 device_set/get_out_band_wakeup()
Message-ID: <20250822052222.GA31356@nxa18884-linux.ap.freescale.net>
References: <20250801-pm-v2-0-97c8fb2a433c@nxp.com>
 <20250801-pm-v2-1-97c8fb2a433c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-pm-v2-1-97c8fb2a433c@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e36ff16-4d86-4b95-4e98-08dde131f065
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Cmuv9mVqIAfmfqzULrrWdMV4gwzPRgBtcKUqUTk2rfUEf7KX38E2/jHUzlr?=
 =?us-ascii?Q?2VipC/vnOeo8Q0o2msZblurLrMe4wPHqErsh6Iu1lKGuTdcmaNEOSWc4f+8E?=
 =?us-ascii?Q?e0mvDzPhK2qsrXRSAhZDG34s2Wy8z8bhmVAmu4VgnEVo69hhUkP0t0ckvlqZ?=
 =?us-ascii?Q?Y5iJ0Ygurie1NbxDxVht+suB00kF4ImK0Eg0VfulECvrD5RwOlWhF2Ra2w6K?=
 =?us-ascii?Q?DGuKN/qTNzljvK0IVYkUQD7jjiXre7AGzu753g2qcz6pxFKqi+842j3vBJkV?=
 =?us-ascii?Q?9UyVB4wNNFvmIe7PqGMLby6uilk+gFRTlcXqeG+73Z6aVsjk3hdIroYbbS6b?=
 =?us-ascii?Q?3WtVKEsCaysZhpwZtOjF/hvESbhwci1c0e7u5Md4naFtag2o4x2VI9bXY0Lu?=
 =?us-ascii?Q?z+LUjwX4MwBb8O4VlTGgQp6aiTc/BmWb9pUDWXs+WX8InynSKggb1ixEKxSU?=
 =?us-ascii?Q?ojy7u53ObqNQT5rjsuBCNceQbIgrFSQAiBAuo9160UNFgbyigshdNDMB27o1?=
 =?us-ascii?Q?bjwLB+iGckL4LNhB5A3oAIzVI1s0a1bMKokmJybFt3fWIh8eaZfejUbQm+RL?=
 =?us-ascii?Q?ydc0KQ5EXBvZcQqICtUFxS6+UyAgXuP7pdNwp7WFfYrfnH3iUGGZcPKdGvIj?=
 =?us-ascii?Q?nKw6GE/2jFsY+nBuReFCGlunFSbVetvaly9xWKfhxz4sB3bH/Q7HP8vaKt48?=
 =?us-ascii?Q?gW6EJqpPISIm+X28NWTzswV4XPCm0rFIE9ROrEEHiIVIDjLDQXUDM+naHgkY?=
 =?us-ascii?Q?LS7Ubsj5YNhbvXlQDatAG5+sNLByIE0l9alv7NtWGizwF95QCMczTJZdb65J?=
 =?us-ascii?Q?/VI4QDTjEQ0jfyqK+pFSvVfVfjFYRkHu2oi2AQfN1Ddw18qjC3hq8sTvomIV?=
 =?us-ascii?Q?HhodwWRFkAqMMpkj1CCPfSEGaFhtOFHCff5COBMqB7wSHwldAdf+Uixhpk1o?=
 =?us-ascii?Q?3NyQTW54Tw00KM94NNZMMDWzBBItpjmI/OJFpaKF3lCX90bkHGtQ6D8IGUaS?=
 =?us-ascii?Q?G+z2qF2HDhEmivX23KqfBeK9l90rR5BRvVJILVRl0Fswqg8cAJzk1TzFutZl?=
 =?us-ascii?Q?ZfdPBra9zlDmY5oIDWwmFOucc+XZkjjEksH2/M9+kJta7sBIwOf6AgHvpll+?=
 =?us-ascii?Q?WNRaiyIUSvtyv3t+udeYnYEl3ehu4uhY3cuX3aV2VLVlBxjpZRp3dyx3IkwC?=
 =?us-ascii?Q?Hfp9lA6Axl4D79eQ0XGQBCl4fLo17CMUgc4VczlXocoG/Ln+XAmSRi3Fr4tn?=
 =?us-ascii?Q?xMCd37Dnksq+LZ+PvJEFwXQS5VLkatz5t+xO3Tk6awCu2k5vEDzdp7plL6wV?=
 =?us-ascii?Q?Na5wpjmsTMLaQYzu3bXGhuiy46cbRA4NIfmvfHGRhMYHcvhQsKKHZM0YTOtK?=
 =?us-ascii?Q?P8jr/91xY3W7Ke6WrZByOVz9R+MbOEPaGdcsJVkilCYnSZWUnMKjAqCQfCV9?=
 =?us-ascii?Q?y/PBd+Klo/qKM+6V7B8SSixejUk0n/4a0DhxyttmXPZ7SwWIZkwCSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QwUzKBECmSE3JduhBi03TnxBsZl1ALXvJcG802DB3RTFjp0zFjQlQNsjM6Kj?=
 =?us-ascii?Q?Kr00qpxfalzUqYgo/iA5TRkXqLSm1Csq0/1v5UVGrTdxzxFwgIM1aHrLqJag?=
 =?us-ascii?Q?ubHza4yUmH7TgvTzFbWQ2B5fyj9C6gwAksekQV1GchNA0Uq1gdpt8Dt02o76?=
 =?us-ascii?Q?zYThmLWIZttbig7TwLNCNebX75a5mUEfI/2sengn4a4SazMetFfoC6AHNJyC?=
 =?us-ascii?Q?rIGWi5LqhbNib7zovTT9HCaGum0gA9Ia4FWg3OBxqVfJ9HQiQEx0/sYLgQ69?=
 =?us-ascii?Q?VAmJzaUdN2rgyo1g9v8IDfa8ExXDLY6LEqsjthu3aYogSbND71Zoa+XtgZVO?=
 =?us-ascii?Q?/deY8pBF7SdIr9G6eowu/wrMJMO/gMEtlMP/mgHQBZfkeDehUoLOBr2tyaIb?=
 =?us-ascii?Q?UtFicYnfvKtAO9+L6NX8bfEnCVRleJo9TMsnKTRwLkvOnxe2B7In35hKDJmT?=
 =?us-ascii?Q?Jt99nADMCQmLiJ6+YFZ9AULVhG+RujtyfLQn1s81qm6CHyDtxcuR4oABFXcH?=
 =?us-ascii?Q?/HD6k0SYcGQHBS0mTQqbHhxoh9A0aqLHw4yeWpQGOiJsn+VqPPJ2X4pYz+Vj?=
 =?us-ascii?Q?PWor7sqcxcrbjpkqA+cgPqyRr1TX/QDi7qgvPnBgT4znnQMY6n//GILo2riF?=
 =?us-ascii?Q?rgW95JeFNhbK8aq+dq1YF1nfuiOVSbiIOVqGD62EbUEPWpWoB8i++9ArL91X?=
 =?us-ascii?Q?crNghXCZGvOddUvrTFm1l6n46Vw06hfByurswypr7iOuRT20wAH5rjEoS8jb?=
 =?us-ascii?Q?HibwqVm8TnGGqWrQbFqQtli6xsaQCQH/xr9/1bRO4zT0JwVynuMPLXxM0nGv?=
 =?us-ascii?Q?TGLSbH9h6+R65g+OhOVwkqaZv1uXvDmOo5KFi1i5nkhMx5g1rZNNKr4YDI6G?=
 =?us-ascii?Q?/vjAOg0GQDkLbGNHlZYemGQmswotIQ+gtA8i6purmGmbqf6gGGcTFQHkLj/+?=
 =?us-ascii?Q?ufXvfRns16vY2ikg881xQez62Uv9WahDBxLeLru0FN52UboErhjbS8yi6ZYv?=
 =?us-ascii?Q?KXBXkfsgLNim5/FaGHPxtYRasKQFnAOxJWRT4L2eOBEGS9b49uJIq7J99jLu?=
 =?us-ascii?Q?h9SfEiAlxLZaU+5dxD2mZEpi7vIYxqZcG3HHmVhexrYe4JQc+hlwrEuFAtMB?=
 =?us-ascii?Q?rDInc+1iaocYBBH9RDeV1BEtjzBNdUxV+Fy3gXG5cIHiQWo8xUD/4tgL7Bm1?=
 =?us-ascii?Q?IbpNt/sLIMOvZJ+XU5I3d0ZgvZygXJhyJpUh29crp5SStiKn3ptOOUwg2Xy6?=
 =?us-ascii?Q?wFrdPCXOOGgIjB44RoblN7kPYPUVlnl+MDni7YgxLXTImCbp06Ge5hjrGU7F?=
 =?us-ascii?Q?uxFW2g4xJC1GJjS7mdPbbPMtxzx6AnPc1xSYQtQDx9/xNDSDgEqmjxR3RSDe?=
 =?us-ascii?Q?uXHlHSgLvA77X0efd+Zr5oK46XUkkPSKSn4hdkVLRJikSMfFQrxOsh5V13JM?=
 =?us-ascii?Q?BhqH8wPZ1G0/NhCwZowvYgl+romfHc780YudAIyF23mv7xoYSlRYAKYNb5VV?=
 =?us-ascii?Q?hBwvT03H6MaEkR1oNmJeONN5Us7qu7YmhGl8GXba3Tu0XlVAq0VCjPAkf2VY?=
 =?us-ascii?Q?8+pdzFX4BXA8s9388fzb9MabaHV41V6FyXm3Z+4O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e36ff16-4d86-4b95-4e98-08dde131f065
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:11:16.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjv5K0fV5gDlNNJ92FhSjGH2OsJxjgpIiJ9G3d1fXLHGNG1aYcEi4Kn01rdqmJ8hexgpRcTz04IRB3AMmjFHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8545

Hi Ulf,

On Fri, Aug 01, 2025 at 12:34:22PM +0800, Peng Fan wrote:
>For some cases, a device could still wakeup the system even if its power
>domain is in off state, because the device's wakeup hardware logic is
>in an always-on domain.
>
>To support this case, introduce device_set/get_out_band_wakeup() to
>allow device drivers to control the behaviour in genpd for a device
>that is attached to it.

Would you please give a look on this patch? Is it the right way
to resolve the issue or any suggestions?

Thanks,
Peng

