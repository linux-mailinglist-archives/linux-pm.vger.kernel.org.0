Return-Path: <linux-pm+bounces-39469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA90CB9731
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 378C430146D6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9612D6E42;
	Fri, 12 Dec 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="atSzvDen"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F72260578;
	Fri, 12 Dec 2025 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765560360; cv=fail; b=qwWW8xDhXfVk1EwhTmxv7NSeLLxpBN1+uJruRZqBBVA3F3pW0QSWDWZplw81MLaOyLzHvOk36+ixKcybfGvSfns/QzA501NeSlGQQKY2I8tc1kJL3hSDM2CQ8fRZrzaH3r+okqIeUi7Lvr9JwcPelKUCkOI2CinS4YkBv/P06LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765560360; c=relaxed/simple;
	bh=qdgngME9j7+x2NlpLmfiICgDk0ckydGo30dXPLiJtdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ephv/plZxP+x7LmdODXAb6Q/b9FEACpKOETgINkCmXItcbhRFOtkrqH8GGwzMYv/ZfTIqy9ZpnN3MESPydbZXakPvDK8dsu2UViKbPVvDXPUHDRT6uYFh+2RoTge112yWcNFp6gN0b7X0fzFztIjFp+jrzYP5uf0cVQeleGC2ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=atSzvDen reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNhoWyz/30oyAqTuwnxwGvpXRBaQ52AIxDiU4a0M4mxSCkp9WO5V5sGMCv9vLdYS96VHP6rIJD1VUvjI++cYbUocbJlDdAt17+O63U4oAf5KJgz7aHNskPvPdqt3Ap/2D3zMuWH7QB05868alvnRmV04jZn4e4SxbL/ItGYRgbiPFmOVR5zaEs0PVi0N9hql8wZMy80GNZ9wqTxfUHPO3MeeqnGr0+0g9aXd1OVatXjmyGLnWNZGQpHuej8wAdrpx5IvIPfrocLeFcCjS5uADg7z9G9QDvC/cme7WC2ttyC9uLNxHH0bcU5AZx68J9Q2KHzipqS0oG4I63yUcDjUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi3B9yO5cutuyW2w7waP2jmRddtvqTJG5jysU0LsSpw=;
 b=tOVJ7yDWRWlB57NYkwhVf5IUEWZxtlfo45K6m7+o9XxFi14B4LlK33jj+2up3nJcQYqC7FUzY50VcuIVdVmwumIZPCJdhit/XcgsjGryCeT0jS5uVWtPAkh7Pza8AvVmBEs2R6VPXVz1uuqER+Se0mUE/nt0xEQUAOO5GuL8SoSNVvq64JQhSoCeY4lV6ptghtWxEOuQK8vUfH+UTEPSlWllCCHO2FoxBRmtZjcygS9GJoRk/oRaR2E2OHNgk5vyPVYheAKtjHUPIETx35Z90XGWYQvuFyGKK10sAoddRRrQE9ljAxVD+ZTHhUZySR+ph37Tajw7kqPHgM1Rdgsrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi3B9yO5cutuyW2w7waP2jmRddtvqTJG5jysU0LsSpw=;
 b=atSzvDens7a0j2jtbhGnP6VS0JXwFTazyMTUDqt6FlHhsRYP2Hsj+e8iMTW0VKTHaPvmXI8XICz1WLLDg16UM/XUoS4umRtLcg7eLxhlXdE0N3ttxSMLqyMDg6ASp8YowO7IpXdR9ePG6lJ34DJaa25b4h2P8fXvZSCcIZTxJpwlPaxQaHLvvk6ZxYBQc7G4SLAi6iY71mk5Gd23KRfuXfMJGyTMR59BXUnLm7tXXcrPSf5NkduYQR+QwdxpPjhXdmbY6gZR32bJYjQkW+sVpDPgAVt8ceVr+9fsWIuLrV5kBLRLciWcjhkM2gvgDXqjg1j1iibWjnFrfPJD0lyHgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB8PR04MB6955.eurprd04.prod.outlook.com (2603:10a6:10:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Fri, 12 Dec
 2025 17:25:55 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 17:25:55 +0000
Date: Fri, 12 Dec 2025 12:25:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] thermal/drivers/imx91: Check status before reading
 data
Message-ID: <aTxQHLh0OD89oc/g@lizhi-Precision-Tower-5810>
References: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
 <20251212-imx91-thermal-v1-1-c208545b44cb@nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212-imx91-thermal-v1-1-c208545b44cb@nxp.com>
X-ClientProxiedBy: PH7P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB8PR04MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a95bf96-9362-4c11-3c2a-08de39a381f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?k4zDcj5cZuowTn1r6e7feqADSRo3/59Wx+d3e/SUS6/cWoyhJShjy2ylfI?=
 =?iso-8859-1?Q?VjlIVNmdzqfnzaSHdJ1fMzrkkffCsRn84OUaYZhEK6qDqtHqLlzmyabQeL?=
 =?iso-8859-1?Q?UqM5UnvCEhbQOmfo61h/LgQejPvrxGbDaELI/R+h5G/UN/FyxGEJkRA3yA?=
 =?iso-8859-1?Q?wA1m5TcTBMZCqrZTuO2/BzZMWd8TXsfhCPAfASv/1FTh925sk5tAxb3v0M?=
 =?iso-8859-1?Q?zUOHCG0oLDrEm2wuUVXj7ij/V5vqty0PxowWVuK/jJBWeXatoU6/8VLPxQ?=
 =?iso-8859-1?Q?Zb23s0tBKKog+pdeRv+ULYzEXzm7x0/lye3+l5MO6RhO7kihcKMJuGSMm/?=
 =?iso-8859-1?Q?nHzpxO97YUU1wFWZYBuwJruFDh3cvzdezwgGWBTHg0RoTYGx6BWgIgBCBG?=
 =?iso-8859-1?Q?6xlpIDJx9nduBh8Mhy7f46Nbe7x07QF7nLNGBsd7TXyGRHFPVJiU1CJsrx?=
 =?iso-8859-1?Q?847aPVwuVA7jvpXVgDaKIEFV17wTp3yjkNtJnyESYKYXv38rYaCrHpFojZ?=
 =?iso-8859-1?Q?XeQmQZVzmW5PS9mRiezBTdZ37GTCdv0oOLyHEbqI/rG3CMNC8z8gQMOIkQ?=
 =?iso-8859-1?Q?27EXQx4/UkDUoyjHwYPnT8K9hHgmRqizyPruq5HVbf8xl9ankgBgyQBhJF?=
 =?iso-8859-1?Q?PFofQuKuQGSFt+nHJFK2n8KfpTeRntjjUr+kK1Xq1s/CjBivC0EHxPbg0y?=
 =?iso-8859-1?Q?RlwevqDGz+m+wBmToKodM+vfpAVj7P/thwgdWKVTtoSOis/WYHQ9WmHXYd?=
 =?iso-8859-1?Q?qJNZ17cFLpKH2VGATpPjdDSES5BA4mAxPfjzd9LDurwPC0gkFCuQeD1C/W?=
 =?iso-8859-1?Q?JGsYdAs1xc4M2vIchboFxpy31TabY8v4EM7JsCIkweYCThD/7gBD6Wb0yn?=
 =?iso-8859-1?Q?Lx1HHTPR+BAi66Jzq0krMgmo/f0O6iolZHRiKPHbUKpt1IeuGzSbomjIqW?=
 =?iso-8859-1?Q?RB+u0V/78lS2kBnRotHc0EpVC5BVBTlrXej7UZBRVEY9F+fzIMaonqA6n2?=
 =?iso-8859-1?Q?QiWivK6OUyJfV51GM5U2BhKRfzgM+xjw05JcSkQBbVbhyFDMulTRI62dlx?=
 =?iso-8859-1?Q?Q2jwnLM+hZcg1OOPZsWd/9sykbNuR1i1YFRuapgHVDH7kRfg3D/aA36ajB?=
 =?iso-8859-1?Q?UO5cLOQdI9OTtUIiimKbtEcwdBhXen/WZXIThYTGSXeLZVrlk99xiNwELu?=
 =?iso-8859-1?Q?gbQYN/vKXhHo3udjGKSO957MzhWQW8hAKjNgm4T5GgFL0Xsn+J4ylUxv5S?=
 =?iso-8859-1?Q?ieFBWtResiVjxpv54zDf9JhNIoPsh/gDtmXx+0RGojSHfpB8DSedRThKiO?=
 =?iso-8859-1?Q?+nWQxTDkEpImktdmdnNLAEmPy2WjfLqk1qIXzR9qMJ3pDOHqD3eQv5FNON?=
 =?iso-8859-1?Q?abiA5xyAqB7et/KUX9exBFjeLAaRsaee1F7vLJ6vqCKO2/scO9Csq6Nqh8?=
 =?iso-8859-1?Q?EpJMJWE5nG65O8uae9DQSoxPu4KRbPEG7W5cQSZm6ElaHK8EE4wC2p4Q2x?=
 =?iso-8859-1?Q?r16DaLdCM10QF73H4eGyB2bvLE28HsS/Rxq/R4QXtSw4VW/wZSr5PqUuy5?=
 =?iso-8859-1?Q?he3xjDR4ORJnEvcsqczg3/Yx7ua4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?oh9jP3ZHMMwYDX6wUM9OnrynInSSODmfM3gJIZJ1DNkSzDoXIRgZ9Sl5WD?=
 =?iso-8859-1?Q?tShwal+CUP9JKSKWx9MJlc5TclyMhHYYQ9wAH4NBJMeFPzWQP4GQvRyHQ2?=
 =?iso-8859-1?Q?nGS18tE8jw29Uk+5Cdps5F5ES9Flz52Wt7we4sqfioJVAyV8u+T8JUVwcG?=
 =?iso-8859-1?Q?O9ygS/+BlVWdRFX5fyjYnrIBKf2BDXXLf44UAD9sino/B8fVglcknBbrm3?=
 =?iso-8859-1?Q?VDBTcNgjckA68lsY1sMt/QUJnwhE04k/zSXk9yYYs135LnYvoDZvxks8mF?=
 =?iso-8859-1?Q?XO3F0FAcC0CI83xRitz6IQgypZ+5vSLi3j6kxrNriCmt0elM5GkJfzSJxm?=
 =?iso-8859-1?Q?SgVL6IQc5IaB46sHCnOtCWzeD9zlcB8A4yUmvzIq6IdwirtfV1tmv5WgKE?=
 =?iso-8859-1?Q?ITQB44F2b/9Z072IWwzXmcUgcQs0mj3PQ7hljXFIt5s3s6/ca69ryKCZjK?=
 =?iso-8859-1?Q?X/Jjm+w092v84fmX1uxXTArDgxeJDVryVHWDoR2AeF31G71Uh1DjFt0EL5?=
 =?iso-8859-1?Q?cBrTeSUipPDq6FS2Y6AC3wDpxWlqo+xhidOFCCcV8pyOg2VeeoDKeOa/mO?=
 =?iso-8859-1?Q?fU+AxyXCRU9Xb4eTH8Adqq66k8caWpuXQiw2u/PkHzDfVfoqhSc4FhOoWy?=
 =?iso-8859-1?Q?5J6PoZMOIRRajC3DlKyPn68iTOn84Bu4OoKOJMNhZ+n1zzFplDwmM1LjFs?=
 =?iso-8859-1?Q?E9eaN3rHd8BHfgk9n9yD2yU0tl25mmItQUcFN2y+ujU+c6ZJbdCuV7N+hL?=
 =?iso-8859-1?Q?33StwaZzBYkiqOcQa0gItoAjFw8C+DpXcHkFFpG4HatxOi4k8AkDIB7d99?=
 =?iso-8859-1?Q?svu8f63REixtonzhHi91VFBU7vAOyVXB41qB7NppEqP4z6Tvv0DeqkMUI6?=
 =?iso-8859-1?Q?GlmXNRs+Dn5yLZX+6udmi+DNi6pDpeWPhtflBV0y3cvkWYltIA94MJQ/fd?=
 =?iso-8859-1?Q?KO0FIA+E/LsuIYgQWImeVU0TQd7AaKf92odVmtW5ADbd5GkMsMTr6wlVid?=
 =?iso-8859-1?Q?eCkUhDA+IFChx6B1M8RIh6OCFw7RSyx55pcoA+DBYaflrrTrhcgkxRSw/Y?=
 =?iso-8859-1?Q?LK4rP1iEJVX7BXCOJb1wnOHndSuQam885ftAN5lQ/h6IrAMklD87t///5Q?=
 =?iso-8859-1?Q?0p4eD4WJwUGKKa2mPaVVrO6fdaR0imVrrKNbAG1aw1kaqy48Dl1N0QK0eO?=
 =?iso-8859-1?Q?LMdPM14YsHf1y/5xHa94an5bx2NpxMLk071Joc4zKhqC8nHEauJiG2p+6C?=
 =?iso-8859-1?Q?0jOb2WNXzSiP+GcaPqwKtQA5TFOPdyIklPjgOrRFVmVAx72o1SWZTrnT9B?=
 =?iso-8859-1?Q?gkJpyD8KQWoXFQreUD4OHS5vJNV0JxSXe/Gu04qCf6ek/q4YPryDqsPraE?=
 =?iso-8859-1?Q?UZN0waF8Yg/liUNOwpLP0CvhCWkPq6tTZq9AR7dCh1a/2za75lMD4g5vfn?=
 =?iso-8859-1?Q?27SJ6Qa1bz5iv5dnnlVPO19TpoNeUWvkj+DnJk5WJNR/flu8bDnFkkIyTy?=
 =?iso-8859-1?Q?ULgZeKeJgXD5Wz31vDGIf5k0BV6Hdyndwt6bwLrZkE6KiZkDiXzBw2kVDm?=
 =?iso-8859-1?Q?t9IcUhVOmD5urJsKdeP/nTGpyKyn1wgccNadUs7PpYe7h3z7is+4JnPkuU?=
 =?iso-8859-1?Q?KZA/t5hmZhoOfBonTnVJ2KnRw2b/+EOJzu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a95bf96-9362-4c11-3c2a-08de39a381f0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 17:25:55.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ph6FGrsdP+x1M8RUmcgXgcnTagAZMzTvvMzusk9uQ5xFLXDKzk8tXVFyt1nXPETwuWTmcC/SLCWafFpoHwcDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6955

On Fri, Dec 12, 2025 at 03:51:14PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Per periodic mode from reference mannual:
> Write 1b to CTRL1[START]. Wait until STATm[DRDYn] becomes 1.
> Read DATAn[DATA_VAL]. It clears the corresponding STATm[DRDYn].
> DATAn[DATA_VAL] and STATm[DRDYn_IF] keep refreshing at a periodic interval
> of time, corresponding to PERIOD_CTRL[MEAS_FREQ].

It should get last time sample value without check DRDYn_IF bit. it should
only be a PERIOD_CTRL[MEAS_FREQ] delay.

worst case get value at previous's PERIOD_CTRL[MEAS_FREQ] sample.

PERIOD_CTRL[MEAS_FREQ] is quite short compare to call get_temp frequency.

Do you get invalidate data?

>
> Need to check STAT[DRDY] before reading the DATA register.
>
> And check the returned temperature to make sure it fits into the supported
> range (-40°C to +125°C).

https://lore.kernel.org/imx/aAIkAF_AHta8_vuS@mai.linaro.org/

Do you answer Daniel Lezcano's question
  ""When the measured temperature can be out of limits ?"  at v6 resend
patch.

Frank
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/thermal/imx91_thermal.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> index 9b20be03d6dec18553967548d0ca31d1c1fb387c..77e8e6a921c6af308b830c36721293c007256ca6 100644
> --- a/drivers/thermal/imx91_thermal.c
> +++ b/drivers/thermal/imx91_thermal.c
> @@ -108,10 +108,20 @@ static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>  	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
>  	s16 data;
> +	int ret;
> +	u32 val;
> +
> +	ret = readl_relaxed_poll_timeout(tmu->base + IMX91_TMU_STAT0, val,
> +					 val & IMX91_TMU_STAT0_DRDY0_IF_MASK, 1000,
> +					 40000);
> +	if (ret)
> +		return -EAGAIN;
>
>  	/* DATA0 is 16bit signed number */
>  	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
>  	*temp = imx91_tmu_to_mcelsius(data);
> +	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
> +		return -EAGAIN;
>
>  	return 0;
>  }
>
> --
> 2.37.1
>

