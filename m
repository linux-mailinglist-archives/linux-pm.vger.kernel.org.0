Return-Path: <linux-pm+bounces-24060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635DA612D8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99768880AD1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800A51FF7D4;
	Fri, 14 Mar 2025 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6mRtsKZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55251FF1CF;
	Fri, 14 Mar 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959354; cv=fail; b=LGjKRoqDxO0i2QjifWh1LgbJM8RkJ6HFi1V0k5JAsfPnJ+Fkdfbuc+H0PmYB5jMFOUKJoK6Uj9fUZNIA1TK61NfgXyoxtTWzeMD4olUYnSQfHIvCG416nGA3AcBF7a20yEgEmCw4mWGu5D8+ZX6E8J8kChVua71UMHFX9OG+CdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959354; c=relaxed/simple;
	bh=i66QHY+r5vfBO3tZylxeHgWZchQOnhznzTovBHnz3JU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kT5Lt0BymehwlKcbRskoR8Mc/A4gCfvI3AI1Qcs9eze07YChZ3u3nRY2BfkOsterbHU3WB4Rb9I4h5+YQZPh1Nhu2an4MoS3gFBScQbcoH9MXQ+B3ymdREkcyN9VYR5JUnGZ/EbNIU7NWn7jEeSqrTeX5sA3yyUZXcppaB+POik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6mRtsKZ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741959353; x=1773495353;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i66QHY+r5vfBO3tZylxeHgWZchQOnhznzTovBHnz3JU=;
  b=k6mRtsKZoUhmXPaCTS8hHlr3I1JDJtq4uskmxmEumFuodo33W9V4rTMs
   j3bGNX8OSGVE5aj6RKJPsx0vQDzPcBEnUEY+jNq/6lVr4MInry8x8QhBb
   vOWY+kcM6QOPQc34DCAUmBrPgd3rFyyxKv5Euu9agWZY3WnivgPh1/X61
   QI7httlZaKW2iYamxrFpCnCmVZKXyEHFbuwUABJWHFboQtdhnODbMoWKV
   kOpcd+P8TqH771SggWak83mmgKvGSzKUBy4gc6ePhOkY21pa7NCoMr3P9
   nVk/p/9SP+0kADNKkapWNJBKFvWR96GTM6DkC9E7MwPVB1zXXzci/0z0/
   w==;
X-CSE-ConnectionGUID: yrMZwSZaRUWWBenJKgH0nA==
X-CSE-MsgGUID: kF55Qn/7S0ObIi87eaw09Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43239380"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43239380"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:35:51 -0700
X-CSE-ConnectionGUID: 0aIWUna4St2FWJAPquL6ug==
X-CSE-MsgGUID: /x6pZqIQQ/CHhdzkwRLWXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="158435717"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:35:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 06:35:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 06:35:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 06:35:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/YDDUhzC8FwLhgS/5dydPxXPz6QTsFXDS6HPgDagDE3Id/Cmxo88y/nnGXA7u0GTHTvf4eftbbK98S0CudXwM3W3ygONql8Grb0E5wiOQ/DmWiaIeA+TK1D3A6upn6i6x1P72US7eUxq6ZqYyhjhd/D+INowNwYoSbgLLI+mvGTyDvXmS0a0CaqZwgO/mL5F65d1/Em9RJzoyAJ6MUTpGRBmEHQzY+HXlf8W5hQ8bcJ+2NNLcvVfWcZwWlStghLiPzQFBIsp42Qrf3q5H7UxsZx992tQOezcho36X/of4kDggwbHYFFn3jHnwLxzlu6q08eiupOFVMoYVXAqh7Xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUoNb12D3Kw/zeVSyWjix4HYnctaVtCFvlSgSNYsOLQ=;
 b=D5EzL0tH2hjhB0PA/ZvegLW1nYgWMn7EbTk12Lr6Dn9Q8AU4uXe7DD6HGh+/RPUukf+sVYFizPFSR5io/HQks+wA+MujGWAcuSAW/gdmBbEpSBGxSCT1fDmpHaWbOGxpLlLBJRvQj8bDs2WU2JUNXB1+ssTa6Tc339zY/r6kY4wmoykK1Ws591cEMI6CxZIHpv+FwfgfxMe+fehjs5kWCRHE3WMChCD8+BGHBdYhkdMWrxcUP8elw7zC8gj/QIAayJE68VEGPBTTO7jTa9SPecyMqsdopiVAJJisdmz4CVOgDCVl7sUbprRFjV/8Divoz2M11B21KiYtMkym3Y+rxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 13:35:49 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 13:35:49 +0000
Date: Fri, 14 Mar 2025 13:35:41 +0000
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, "Richard
 Weinberger" <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>,
	<linux-mtd@lists.infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, <linux-pm@vger.kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: Re: [v4 PATCH 03/13] crypto: iaa - Remove dst_null support
Message-ID: <Z9QwrUqA0eaYxZaA@gcabiddu-mobl.ger.corp.intel.com>
References: <cover.1741954320.git.herbert@gondor.apana.org.au>
 <11128811057de7bb7e8d9ce9fe56bf9ee64ad143.1741954320.git.herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <11128811057de7bb7e8d9ce9fe56bf9ee64ad143.1741954320.git.herbert@gondor.apana.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB3PR06CA0021.eurprd06.prod.outlook.com (2603:10a6:8:1::34)
 To CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ0PR11MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 61924878-87cb-45e9-1242-08dd62fd21b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S45RTUJGhk0xpWyz750cBpAdjaeN1cOUTk4A+ddZ5jzkvGyJhzx/MMabucaZ?=
 =?us-ascii?Q?hDaPRh7mYalnHiu2krxW6jEJyO7Uq1X0qfkV5i0+ms0tUNrY5Qxm/wACiRtE?=
 =?us-ascii?Q?v2eLDTPF9Jhm2FUObnw2ErmG0mBD8bzBbI2m299ZjRKHkI1/C7OxDcmKeXOq?=
 =?us-ascii?Q?5lZ7MhhHpficxkeJpqAL26EC03nXwAqgvXA5ROWYwPSn7ago0iDUtdVN9Wic?=
 =?us-ascii?Q?L1w5HU1dE4IHrciGonyL/g4O9q25rxuWJaMPwGfxb08F1CLsxPfecOSCl2ss?=
 =?us-ascii?Q?+OFiebD6nfzeGZR8vF8K5J3fhsZKNSGj4JZBitQAoxpIGUISIftRyAflcr8s?=
 =?us-ascii?Q?ASRCo6cR0oBbktAJlk7cKNqzEqY8/rRekh8LR/5mNXynvqJoPDOp1SMf4S3n?=
 =?us-ascii?Q?CZ9M1HBuSOUm/rO2i8p+T87ggqYoaQg8DwAas0tybN+hzzcoK32vpQAhxvp7?=
 =?us-ascii?Q?+YRnT/BgAsxA1P2UbQHd9V/Ogtx7VrRysedmQmb6NSf7SaAyxlLyM6nT+yNp?=
 =?us-ascii?Q?Zbxma+2CvQkwniuSPNKb4AJN4mwt3AgNF+0DpZwdtuG1eRw1FXVypymqLcRS?=
 =?us-ascii?Q?wG75qdN78Uyhnr3ZkIh/apqe/XWJvWeyUC4uZi6LuiDoQtxDYAuLBDqzf6FC?=
 =?us-ascii?Q?reKj/z9E1MCXetce8WVugookqhgLsqaUEVFAPw5l4pSizyMvSPk6Nia2B0cu?=
 =?us-ascii?Q?bC+DejahPQ4TGCfBMhQ1nrleDpGHJ+6Jf9kq89uCCJkvtzUoVpcudlpxFOaA?=
 =?us-ascii?Q?xrPKvzxPYlJh86LmrViCkKlPS3viz7X4p/xMDKQUxbl3S4Im+KEAhaE3YNFM?=
 =?us-ascii?Q?puTrJsmw6MCIChd1K1Ucp3R1SgD1aJKsww0/81+rYvEeb1TPVzeUhJkscjYz?=
 =?us-ascii?Q?GymTtsaFko1xhwz0upY7xWNToZgiMCxhMBSusfXA21lHC1DMi3aXXfQ6leV0?=
 =?us-ascii?Q?TP9y45soj1bL72nr29KX3bVdf6Qw3pzct+wAc4IwiGh9wx2BrkDuFYRM2tvv?=
 =?us-ascii?Q?EwbMrvpc8nkv6WaR3xcGCt1BYepr0ggxxHceHnwDlqkQBlFP66/ucHqZCvxF?=
 =?us-ascii?Q?5lhAF44c8zvwCUReI14QWymOojN3SUWB3TQtTaiJGq2AIjoujyz1LLmtY+Yo?=
 =?us-ascii?Q?qPUYzqXurmmTIFD7IavDOnJe7csQzX4WDDBfQAEsl3vN3cLZCSQHUOBOZpIA?=
 =?us-ascii?Q?Z9O2Btbj0EfJ1iPLxLuV/PUUNWIujNs+iIcj9R65G+P/xrfj2c+5gRvCqbFg?=
 =?us-ascii?Q?Ls4oWmtSaAFYQmtqml+TwPQ6SDM8rWmOpAT4ivF1lcLNPjVMrxVWlTfT3uOi?=
 =?us-ascii?Q?265geLusxcz0mesrn+IBtCDGiBg90kpWAuGggzJipLF73FAlnUcrJcOkrOfL?=
 =?us-ascii?Q?eKNsepeNyDFrQeGWqBgpSMpDuWdh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3GqRWJwQIdcyeQptb8N8plpaQ8/ASJBFbXT4X1XnP5RE+Y2JE6pfLSpHZt1c?=
 =?us-ascii?Q?3YHZy2GKA/Ah0NNUB1tkuVPIAeX+e7K0yCCt8XODyflgItNT4uhYUlNqsfmN?=
 =?us-ascii?Q?iL31u/PS6rgkJ4KUmygFv78F3XE5czEJVSHj4wnLUOujxAlWeOabvOdE+hCF?=
 =?us-ascii?Q?210SHOqH3AL0z8f2rSqJgGAxzE27SKrwYPugXla0AGHsNMbUqyuBp03s1zS+?=
 =?us-ascii?Q?8+JcpZQr2LOc8DbjACXskCwUY6VY/2WyZY9IKFmmXFde1xzXw7Oa3EA8HHUw?=
 =?us-ascii?Q?GHsALaDB/Motu2Q930T9EM+Jw51UL1SczpmMtVKoUKL0NRbEXQ6hHf9hHy7e?=
 =?us-ascii?Q?0UtxXV6YVaW+O2p3Wlhi1Bh3muxwqmHtTf1OEr1tHyZMpwgP+leB62RkrozZ?=
 =?us-ascii?Q?W9B4QavEU8vO9WuXm2stcoV9ItSYw6fs+RssmOcg95VsxLnXs67YfN5oDlou?=
 =?us-ascii?Q?IM9qo3XNEjg3L7hWUMNGGif53RLtgioAeOsIucdi34UVNZsbIoOXJ3ndRPv8?=
 =?us-ascii?Q?F4iEwswCaewvk6YrLHn5wQXbue+TYnTHglJszD3Q5NOQ6WpBRkXmjGSmn7QG?=
 =?us-ascii?Q?y9clNBKsxBl2thIvW2eMe576yAEK2pXj86ndxeEdD3R0yGSbXpIMUeUrr35y?=
 =?us-ascii?Q?UdrxRONrS9CHzNh3hb5eWNEVlPbIukJgocLq6PebemBk/xeLFHMNTBsgD6lT?=
 =?us-ascii?Q?761GdPxW9itQAKq63Wrpv+sJnDTgpfvTK9IaWDVFREoLWSg0FtIxsIP6j0j9?=
 =?us-ascii?Q?dTPR/Jcp1HDEhR72QU6/ucVUZwWg2DLvAEVR05xn9jJseJFuQ2YCl56bzkIc?=
 =?us-ascii?Q?3cerVg2wa2zRjKcq7jlySuWYfUgaQioja1UYYkp+h0J11gXHVsjlb+yOYmoq?=
 =?us-ascii?Q?bNzbtfAE8o2/FrTPre6oRsB0bdsGLImDEz4bDM22mORlC1wGYdK3S20Tif7L?=
 =?us-ascii?Q?2XabWuZQQMHCpeHPBzVaeZ3vEjNAEffBELenlXMmQw9QcKyGNhltSw/SkGn2?=
 =?us-ascii?Q?XlzQJIbglNoXVPAWIaxiSq7eJPgffZuRa8e5y5QsIopCkv+iABv0laSYygaQ?=
 =?us-ascii?Q?2QrMUOijteXgXR7SCXULhZVTeNiwdmMneWIfqLBd0BN/1AjLVPeqekixU2Jc?=
 =?us-ascii?Q?KGX4Fx9SW+F8uO3AVnQkvfk61d+k+hYDs7ed5Ccwxjs5AJx48eLaD0Zi6VWs?=
 =?us-ascii?Q?bs1WJh7nqbsOSZ6w7NTRwyFytcPoGbArLWOsNNTt4ky9R/gKJlZHOsa5XPcP?=
 =?us-ascii?Q?qAK0HxW9zxqMU3TJYkfZcoA6PzDLABMNKTQm3ooQyDJKcT9pen/ij+Pli2UG?=
 =?us-ascii?Q?Sm13PeIAL/m5Plyw8meJZl7xoHu99IN6T21JRFWBv5XCrSr6za438JZRBz+E?=
 =?us-ascii?Q?etFE1deW1R8eMIvBvIq+KSfRRdIZkhsqju+jMhvYJ9DUKbHMONNo8OmLRmC+?=
 =?us-ascii?Q?5ZXpRI8pZww2dwiF1gfuyiBhjVImzA2vyEWlG7p1jTCSk7rVVNQOmPIF51QH?=
 =?us-ascii?Q?ru1UtE/bBSDPd0YIzcVahG3C18vu0P3alR5t4MkCqthCPHTnkDRbUmwumL34?=
 =?us-ascii?Q?OttRz0+z2bFjmwuQCzuy4hjgSTPpGUM1zWBk/21eJTt5CmxpEPt4Qgu4+o3q?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61924878-87cb-45e9-1242-08dd62fd21b9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 13:35:48.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgv628r8rGxirHEH/M1JLmb/3R3tqgN/tXqbCvYNJMN7UJeFDe27C/oWjQTZpyjQEbzBJokQfNSL7WmTaw6NGtef6hfZ4HSFFW083bHhBrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5037
X-OriginatorOrg: intel.com

Hi Herbert,

On Fri, Mar 14, 2025 at 08:22:28PM +0800, Herbert Xu wrote:
> Remove the unused dst_null support.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
This patch is replicated in the set and does not apply. See [v4, 02/13]
https://patchwork.kernel.org/project/linux-crypto/patch/11cc12d83023ca382492fc2b2ebf45c84e37acf9.1741954523.git.herbert@gondor.apana.org.au/

It seems, instead, that the correct patch 3, crypto: scomp - Remove
support for some non-trivial SG lists, is missing from the
submission.
Something weird happened when you submit the set :-).

-- 
Giovanni

