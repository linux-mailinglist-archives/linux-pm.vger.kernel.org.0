Return-Path: <linux-pm+bounces-27355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37AABC25B
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF91175AE6
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB332857C4;
	Mon, 19 May 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMnEG7T+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712A26E164;
	Mon, 19 May 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668286; cv=fail; b=d4J2GeAgXLm48yhWmFFROo/PdV6bDXGNiFXdKNnjRrS6mrMBIrV8hrPcI5QbMUTIeu5fYKnsd6VnfCy3mNa2ILEt3LPVLobjdd75suJwVJx6lR3XdsL08xBjlRC6Pfeyf7Be/GriR2owUj5veZDesr8dfQPtpLBpzuxwtNDhA0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668286; c=relaxed/simple;
	bh=R9aUlnzXCONNHKsR+IrlyNP+aiVJZKQVfmrgUTklG1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oh+6Ckj9P4K0nYCGMa6wVJvKoX+wDm0Q7RfiE9cI4iEXZ6gBtVXds1qiv8k04bydiKcXIfCu4XtDmwWd2+vkgWmjhlfap/HrBRF7LeDT4eJ3XgI+qSLEsQAywq/2eb8a23i39C321FeYQC09YFpWqfVwz+HDRLL2I6NRQdiELVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uMnEG7T+; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiQlXbA1hv4v2r2DgyYheJAZGVG/vYK4j+Qdk6fLXyvk0Nm+Fz10d4i7FpsrqNLjWX9/TNjJKmM1wzBB4adja9xVe/zLmxKbjZH+Xa/sYs3LFlZdqaQtRof38mMrdBITbBGP2Hk7tOhR55uuLcu/egDs3Ffr+VQeMkxUsuySy98PKdnq8V7iJxZiBew7ETFcVvO6zJD5cnDEetFw1Gjh6ewrMDedgJUCBH7Is5Qa53VBfQTclMqgPLxH2ceZ4GFaXDFfuoB7dUAXHrCCvUCnNP0keq3/Qc1jAgTbMy6UaheslMcoH9GtLSm44VmZljDxVLdzqk34YqfGL0UI/F9vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEW4dBrsBPauPQEAU4En6iXvNqlXYzsK7lomy/JkkMI=;
 b=h/+HjJ+Nj/d+b00/4/P0PtxTpi6bTtM5l+NBzs9TL2ptMxhq0jRPcYrT8YT5E/saA3aU3tCaGwGDL/x2F8pNOyqYSnQawLDte3ufj8jdHZsX95wCOmHOSFnLa1ZDUE2vn4Cf4EY+nEwyjvczUgYKm5GRpkyJS0EjnkJVMuzb76O2S5m9FmwN1dyMNeTdgUIADY8zV7wyDKoRTJ+aIHppIlbWbRSJFca0wt9ppRuR9uZGL2dljjjYfTrw7RkKGZaLa1S8WtDutOLJQlm8XCLBPaa1yVrtFlgDqVoxyWvKX8p58NiXzmyWdRGlrbmu/6Qp7dOidhN40qDVhf/7a+oTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEW4dBrsBPauPQEAU4En6iXvNqlXYzsK7lomy/JkkMI=;
 b=uMnEG7T+rauhfJvisur8zZSH8lqxG0N/lktE+L5B6WEbitNpY6vGTLur2qrcLN4dx9C8lrR+1F4s6LoGXIiCY9RPK+1IM6pu3Xu6ohrcA5UrfRqYJdQQVxpyom1XwVW1DJPxeohvfNYq4lw8dpJQ+YKFwtrIhAs/zPL7DUr0Ljbkky0/UieO4EiTDossa+QEFlSFt2jNiv0Lku33hkasIRG9m2/5SwWeXglLBtBCuk/ImkYIEAJogg+GENrjpGMrov0qNEXrI6kkVPHtMzepfrj/hJYdM6s2jvXidJzs8+fbuyojnEVkUbyEZHEC131S+cM3AFtPN7cTqFdzzOoswQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:24:40 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:24:40 +0000
Date: Mon, 19 May 2025 17:24:34 +0200
From: Thierry Reding <treding@nvidia.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] soc: tegra: fuse: add Tegra114 nvmem cells and
 fuse lookups
Message-ID: <cgmetawegvtm5ibwyeo4o3r4vyafxr6wd2tpma4norqi4sa3xw@o67pkm6r4emw>
X-NVConfidentiality: public
References: <20250321145326.113211-1-clamor95@gmail.com>
 <20250321145326.113211-2-clamor95@gmail.com>
 <aCcDdqXo_d34BHpE@mai.linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fzqaa6tp7u5yabmo"
Content-Disposition: inline
In-Reply-To: <aCcDdqXo_d34BHpE@mai.linaro.org>
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c5d4fe-3359-42ec-9dcc-08dd96e94600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+lop3aFoLJKePMd/2IUxduXiPIN50WyihLPPPmY6GPVzsZt4gMZ4MgHxmnkR?=
 =?us-ascii?Q?PoeQ3VAJlC1goC3FU34W//2BZUgScY10Q1+DY0palzWQg5wRmrjjqrvolDoL?=
 =?us-ascii?Q?S1iZoU6fbgx6a431wyfcW8BF0Tipjs+g0a4z9C6xpeJUAY1cNJZCZi1FpZJC?=
 =?us-ascii?Q?NKm+zs7QZ8R+ups1lHMFIYUPYTaQOjM9cHB1ah5uCBIa1LaRuzqRm/d8oclF?=
 =?us-ascii?Q?P1JrGR3AYNwF+httYHU9N7QsYFy7d+LRKRfJ0oZrUU8z66NVLCsIyntYzPRP?=
 =?us-ascii?Q?PRshiQJYRARPhqk9fYdkBcKLNAtG5qWiM5DPJ/rDLm7H+FgrkNlTPiSKQTZr?=
 =?us-ascii?Q?AtnobWsGo2FBE5VLjWMBM9OC3H1ppSnR/9arh1wFQAPTd1nWCBUplY/qrT/K?=
 =?us-ascii?Q?VeRsWl+Z6mdd3E20AiL8NTngGGESJ31TchfyZsW3YptTGUT21yRWeQvHiJNK?=
 =?us-ascii?Q?xdm9UQYqi0c9dgP5yrxfJky+kyxp8Au6Tvyq/kzPKGbZx92l/HQWL+dlsCOz?=
 =?us-ascii?Q?AhA2OGKgFb+mnxvzZQDrpL+0jFgQdxLe45oyHM43qZkWurdck4em284yxx0W?=
 =?us-ascii?Q?dxawu9IkKBZsppNXPuZIvJDOE6Fr2HH5Z3kXQuuOmnnPWzQHrB1BkPqsk5oD?=
 =?us-ascii?Q?VgDzqy7BmOB18zPiVigXJwr+Uocn3loaQ+bwm3PdrCRlGvfSqEisGcYkeQZj?=
 =?us-ascii?Q?pBYWsce1WmL2HT2a5YvDFinZYEOWW857Z1OZxuygD+WFmXxiHjtRdQqcaAF2?=
 =?us-ascii?Q?WPncG650axaLG7wdOP6JpXYf94ym22ksNHkeEETKY5Qd1QTxQgBBF/1NY50X?=
 =?us-ascii?Q?3NbUzVraEJktgNwyBEfIuMzCYZWUrsXdVIVrrWX+f0N/l8ya+lfIliSTFOnI?=
 =?us-ascii?Q?EQlU4LqT2v0oeiejJqSqoEvgnwYRKi81O1igjGScpd0u84qwbUQ7j3kjSQSm?=
 =?us-ascii?Q?N5mEKpieA7dtrqDN1+NvJ/MBo6qeaASRvlAKC60j3NbTwmK3BU2YskFg0dTT?=
 =?us-ascii?Q?wndbQfkgUyXmkGV/hOjz58WiAf8h1OzGyP9z/zWzkuTlRLRDw+GK5+glM1X+?=
 =?us-ascii?Q?FtzY8C5dP9xrhhXXWkoVgutnBNAhpuP6KMauE/IYdOo0C+8iTMEVEUtfu7D0?=
 =?us-ascii?Q?4DF7w1fgN2Y4vhi2PFZ1KNqfgq6bLsRKGz82bQDLjbb0LwahMaXNItDqF2un?=
 =?us-ascii?Q?gqA4WsahydJyQZ1S6ZBcBQH6txu0H9PISNwYjkyqiTBHrC5QbMLqV0JH2Zje?=
 =?us-ascii?Q?xdMmRsi38t3P8CzP7k2ECyVe5iHCVdt4qzaOS1A7DnKKmS2axSeR/31vnclw?=
 =?us-ascii?Q?pdS6YJmuZM5/dwdXE0afCmHPrtyVS+kpFqGqybP3e4jkhxjvNU+SpTuFqXq+?=
 =?us-ascii?Q?betH+F7hOEZRZDqhSIydK2PC+UoWx+B1V4nTk/o2nNvg8Ey0efGq+RHCU6VF?=
 =?us-ascii?Q?ZNOPRdxsVuU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SCjxJQ+PPp+UY249MaVif7eMvElxRqqlRLnnllwMkt7bHaPvB8SW3HC3wd3a?=
 =?us-ascii?Q?34XTPiSHoUXkaiGOilcclogXD/mB4jh6r8kzNTT8cT1S7Sz/d2G1prnFrenv?=
 =?us-ascii?Q?i43D8DS6xjufsxXR7cGFTUx7QiZp/mhUCCwl0WXbLXYOeN9JmKEokpXg3sjA?=
 =?us-ascii?Q?Rwdu5QvzBu7BjTGIBKEHZXARxbkbc10DYlWmr2/4baJ2/4KB5b5rDRFlTnU8?=
 =?us-ascii?Q?oXPuNF05TvgqLII5/jy1H7vfMI+/c68a/Ju9BEpL9XdZc8/GYIgiusAQSoMq?=
 =?us-ascii?Q?a3JDQzbMC3X21dLHIQU/IoXuz5+OSOtMtBFsmzv/zbEK4rnPjUVvIZk90ikq?=
 =?us-ascii?Q?N19QJj4CngiV5zpflyJ1MFn2BqCJM7W9AXWwSSW6hOVL1xykvgANWqedefo2?=
 =?us-ascii?Q?qRluM9fYdO3dm7vD6PF0g+XqzrF37PHvjHpt0/fjsm3xxqLPt+O+QJZWYs33?=
 =?us-ascii?Q?ZnLXPUnSd8ckmsiDL3tZICw8rfSnp0l6CXwkMdUGvlQZBeY0I2v2tlFXRC9q?=
 =?us-ascii?Q?DrYRER/fuIgDuXIa+8YFNZWO+aAvby/NyRf9ssfbr6EA+DO+pOmNiz5L02gz?=
 =?us-ascii?Q?ZEzbLudzc3Mxub8sGk33t66DDvr027q/EzSlgCpPrfhkDls+Ww6UHa7A+nzH?=
 =?us-ascii?Q?lwQ1hWCkTyfnyHaqipx9whiVMiOw1ixcw03FjrzQ2MDz2bOaRW/a9I02QzaR?=
 =?us-ascii?Q?ckHYMPAf0GCd9YHryIN1uwbeYn8LaBdGbk95TivB46ld1Bsv/5W5khVj1pPe?=
 =?us-ascii?Q?e6z1+Oz8tJhoov8NAWsx0WhMRT9Bvy8CYEaLBo/Dw90pXiUpCXzrl5ObCr+d?=
 =?us-ascii?Q?KDG4+AX3gySpmsf/TeKOW5A87RuOtEkWGADSA1lgjvSumT0SeG9sdY7YQVDB?=
 =?us-ascii?Q?fKHnCGch7Xn+YCe0ccRiln993Hfo3Bz8Qh+j/Zqm7Btje/Au+ruBOgqLQuL3?=
 =?us-ascii?Q?GObtY29wExQfzbdAdLlFfsqkLho3Tx5MvTv3pjYpr5FWs9lw/Qf8ihQBs4xD?=
 =?us-ascii?Q?oToX78vgLG0lBiSf8Mh190V6dwMaV4qimJ9DCx5/6mLnGZQ0xTdY18hzrMDl?=
 =?us-ascii?Q?n6mSS9FhmMJjenvuhpcWTlKahmlJZXby005vVOzGpgqYP46q7Ru0J6kZUvR2?=
 =?us-ascii?Q?YTOmztNT4HiWtNt+6ILNyTDyWxpEw9pBJigPvUKD0PXLyWPPL2BJTiadW2SQ?=
 =?us-ascii?Q?YJFFcMBJCT+O15fI0zWiCrEFRIidk/jLm58EXflG+qT4eZnLPA4q2DKHZZaY?=
 =?us-ascii?Q?33VuS2c/wX8HdMhaR23vWvi1ML58v/Sb+k4N7sePddOhLXD6XgmA69x4YP1Y?=
 =?us-ascii?Q?wCHNEu+BuSbjdg00bbNK5jiTDpgznLzt+WJ6NoJKd8QCN2YDWeCiCNHAZi92?=
 =?us-ascii?Q?XKcTkFgGV4QBQEGZrII/iUqz+Shz+romyKsNpzhyR15cpq8XWc3vd3jPlOoC?=
 =?us-ascii?Q?ZxPT8wH5GKpNnotfSk63Iy96x+F5RdDpR17YoFWF1HDPrpnEWfyA6OhY7/dU?=
 =?us-ascii?Q?z7JstMiPP0s6bcRM+LOzNSmI4umsS1wt23GtbYz+FVKjfswxlIGJBUv3Ndat?=
 =?us-ascii?Q?xZWyUGnq70UhkiC7tveXS4+tyur0r41BKG2yKvuvf+5Lo4G6gORyDuPajZhL?=
 =?us-ascii?Q?lQRI23rPBDs5u0JaDGM20HjMzaTnFOw1geGXcoj5/b+X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5d4fe-3359-42ec-9dcc-08dd96e94600
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:24:40.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yy8pJnZuH71n+c0xdHAZqc7ZI6GDTo+oQ99UXxlqMYiYK5Rq15O137zNC3oG8fSvj0w36RGXrmd2wo2Vt+4W3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

--fzqaa6tp7u5yabmo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/5] soc: tegra: fuse: add Tegra114 nvmem cells and
 fuse lookups
MIME-Version: 1.0

On Fri, May 16, 2025 at 11:20:54AM +0200, Daniel Lezcano wrote:
> On Fri, Mar 21, 2025 at 04:53:22PM +0200, Svyatoslav Ryhel wrote:
> > Add missing Tegra114 nvmem cells and fuse lookups which were added for
> > Tegra124+ but omitted for Tegra114.
> >=20
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/soc/tegra/fuse/fuse-tegra30.c | 122 ++++++++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> >=20
> > diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/=
fuse/fuse-tegra30.c
>=20
> Why this code does not end up in a fuse-tegra114.c ? (as there is
> speedo-tegra114.c along in the directory) ?

Given the nature of this data, there never seemed to be much of an
incentive to split it into different files. We've added a bunch of
these per-SoC data structures to the Tegra30 file over the years.
Primarily this was done because the register layout introduced in
Tegra30 has remained largely the same.

In most cases it's on the order of a hundred lines of code per SoC
and sometimes there's reuse of data and function pointers, so keeping
it all in one file has the benefit of not needing dependencies between
files, and the file size is still very manageable.

Thierry

--fzqaa6tp7u5yabmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgrTTIACgkQ3SOs138+
s6EtVQ/+OqJjnedSv6tGLrkwvmE37pHhu590FH/Ua+ruESWBwKbE4Fw9R5v0UOUW
4uh+x5WEybp3MYIAjb0bYu0ND4p4h4oIn2p5IXiA9HSJJuk1op0yyvHD+v5TpFUS
ofb10e3VCj+/zPdKW0atDWXMhgVcHZzQ927rkyUsQseuuBLy2Zsw5mRv6gcjVrcn
qOrxRd6twWiOkkDPCirCN7n+9+wUX7djsrxA6mUW4FxGHHdqFe3U6jCtcNpbV6L1
U3+4PLqj43j292NnCROEg+PweTeHjPv5jP1y9o5O/1K0jRM17ftBl8ceMtvp/Eb/
CfsNWZzhhiQIrBtpqJzxryZ9WnYRVzpxafMkSGQ994sKlqBlwyrxTGozD3YiLjg9
XIisyKAdk9WmAbixT7tVi5LNt2s9RpenhONbYIqaqPz32nNOWwobd1R10PjMypCc
fC0IfcmX9dyqoR1I5o668sS/54/V+mE/1nlGWHccSEs3s9vDyfj6oW2nP4C5wAJe
jiZp7WitVv5qoM+UoOxdrgGcGK91vLGdjO0fCyv5v0SZt03YHXiFtow26uQ9WGJ4
Yu/h8UvojYTfN4OBIHewHph4Dk9FpjXbIOHjaocl5MsbCSN/kGCFBr/h/2mZj+lC
jqyh0wsZpinv7HBRxwXNQNQenluoI4uljUPWOnBq9CLNjSK0mrE=
=5kOO
-----END PGP SIGNATURE-----

--fzqaa6tp7u5yabmo--

