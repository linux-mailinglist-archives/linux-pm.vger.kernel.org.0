Return-Path: <linux-pm+bounces-24062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE66A6132E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902F77A8384
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECB21FFC45;
	Fri, 14 Mar 2025 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRGR8CN6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DFB1EB3E;
	Fri, 14 Mar 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960611; cv=fail; b=C/HG1WN4m5nq6iJVVaDaSMmUyCcq5ALDiLlyxLqbrFanB/vysBA+LIYuXYCVCB5JW44uCrjqAUYs4ayz5zmisvIViwGYx+ySLcByFDZ2ALPBcgWfCxs3VQ6F4sQlidRZRHAeYebW+89ErEsrhXzrIujyhtS4p+K5v5RH/z3Qfgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960611; c=relaxed/simple;
	bh=cnqixVFfa3VUIkDrTk8hlfTy6UAZU407wxYWin2ulIg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GgoV9R5t+iiHp77cDyMEZCml7ZnCcf7+zM4STpGsAFCQEAkd3j2gKE5N67AuMOv4mR7FJHcIYU2AzlC6eqXizVxYjClTlQKkygZ53Dzxn1oKXrHYvLNNvI4JTwao/Bv1HPBfLVOgcSeOaZ3F4GnvU28zOBGdTyIebVMUutEjDXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRGR8CN6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741960609; x=1773496609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cnqixVFfa3VUIkDrTk8hlfTy6UAZU407wxYWin2ulIg=;
  b=LRGR8CN6+UzE0I1IOB9thZBa3pxMzmvLSb+BKJjkGFAzThgfhAYD94B1
   6pBS2IFOy2Lngq4DulD+2c8FkKFye+mhPjBMAAA9/m0ApssVl7u0H0Ent
   53V/u7QOVvNfxmPuXApMgu9g2G43SyOAYDVc4xez93IBbVd+R/Ua5moEl
   mr7HXIuez99ytbYkwBE+h6GK+KwhitUrqJVC9mQeY6vkh3QxiH7f3doIX
   nEAfP4104JBFG83c5tr0+whqpGf8uZNzLUtuZphO7FntVFOeP/Op93Xza
   x3u6EP1eA3ktowTB9hFRtfmgZaPCoasKybthmhRrdmYRTHw1vZWqGvU15
   Q==;
X-CSE-ConnectionGUID: OIahZUdzTWG85XvfHlD7KA==
X-CSE-MsgGUID: OPnA4DXKR6CwoNdy31+ZFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42280775"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42280775"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:56:48 -0700
X-CSE-ConnectionGUID: 6K+tE4ttSDKCCmHeR5aM2A==
X-CSE-MsgGUID: fHAA8qCYTdquyPFqaW5K1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126355835"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 06:56:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 06:56:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 06:56:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 06:56:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyAeELflvoPJH+XEQPqp3C8p5j12dsCNi22zKLEParKA6NtwYHs2tDXSb6q2ROHlGJ+q2EtUAj77W5kxy10gBN0E4KVO9fZ0Ulq8an5Xjcr7rGsq7regbSIRrzh+U4rb3eSPpAfcPr7QFXIBSRPrylekFi8WRl6HB3E3wQ2HNtuQiHR2sVrgQekLNGZqzuyhPzaVpARBwVYaUFkEIbfS3e+gSxePa9Y/Sv59cRIHWktyv5pCfnaHz5MNxTQIUwvmrSmYH4jjPsNd81xqQD3ynMhoCO8H9cKesuiI1sOdrS1CyZR6wQaLtw6mXT90j7uMshV4NzTxF742SzSYdRyeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KckEjEuFJuekabHa3ZQTilG5qkuBV2G8wWqZLDi34gs=;
 b=i9GAuF+Kyg28+hVmUXp5wtIoG89l2zFmyZBie+zXgdnagF0utx8ikaDKIM8y4JcxPifPPVpf9vyYBVf3NcC0+Hf3Cj0cquvg1Dg0c4SYK706oRrJI+0r2/FMr0as8V19Bv6f/FDsIc9tp8w0io/5HZd2pBmvIthsiXj96DRhgQu08LBzgNcMA6bb1lIhlIzNMIMG5fMM70x83sFqVtBEuOIxAq/B50RM6rSxM+u6qnMqINisq1GaGd1orq3bdaH6CKnQlwNcQbDHK/J9FifgbnwnbirunLsxoO3xa0/JyIMQXvX4UM5y5uk9Mbi08T+hgPoxeIiSe5P7sVI3Tjhn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SN7PR11MB7667.namprd11.prod.outlook.com (2603:10b6:806:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 13:56:18 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 13:56:18 +0000
Date: Fri, 14 Mar 2025 13:56:10 +0000
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, "Richard
 Weinberger" <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>,
	<linux-mtd@lists.infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, <linux-pm@vger.kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: Re: [v4 PATCH 02/13] crypto: qat - Remove dst_null support
Message-ID: <Z9Q1euXeBy7x8zZI@gcabiddu-mobl.ger.corp.intel.com>
References: <cover.1741954320.git.herbert@gondor.apana.org.au>
 <1e29b349410b0d9822c8c0b8f6e01386a3c44d66.1741954320.git.herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e29b349410b0d9822c8c0b8f6e01386a3c44d66.1741954320.git.herbert@gondor.apana.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU7P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::17) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SN7PR11MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d622456-1a21-4192-c83a-08dd62fffe5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JETI8s6RgOexpAx4oI63KbG6uCmnLGKhQV1gmjPLQPks8RCOl6Jr0kziXCXp?=
 =?us-ascii?Q?dF5HYtBZ3P8bCyPp9h1Bgrx4J8pwL3E6vBK+zkcAWeTnWYP1JU0kXY6NrGjs?=
 =?us-ascii?Q?KmFpvmatPmpFkeh62OpN+brEI48KLaliOVip7OuWcDCK0iZcDcePjTr9z+GW?=
 =?us-ascii?Q?tlbdQugigrf7kfR4cuDag2j5YpFNt25rLtg1/5ENiZwWLSFSuSkE91zJDloY?=
 =?us-ascii?Q?sidBWxxatz/5ttSf4Grfzrg/JpHVAG2CakzGEnxyhDs6+VNJwQ+Bk1m6algr?=
 =?us-ascii?Q?GSybWDWuMrWLvGqcJxYu0U+BeXClZHWH9ltC1WO2YVYqdDyCbQZbMhNWifRJ?=
 =?us-ascii?Q?g5PzRKZ40dtjb8WEsFE7im0XI5sMtojk38pNdJvgw8mo9t+roKjHam0GC+LF?=
 =?us-ascii?Q?GtJbBe3fkAoWkb002+iENFRlwn/u6ZsPORJqNwZhdbFCvy+FWtstAlrdqTBY?=
 =?us-ascii?Q?AQ3nGrDUkS5m9PmIaz7f5R0YK+wfVT68feneoIDpjBHWXBdLmMPS1b9CqWzZ?=
 =?us-ascii?Q?A7/xR/FA3lP1Tcj3Ce+bJcfQExHU3aRPoVC6MIAW88PoIdEHNXMm/gxuOHUs?=
 =?us-ascii?Q?yagMlGrhq4rsBnk3yRQ8AXz4XhEIn7T/DUjct/a2W7PLWfQY/XyBDs4YWoS6?=
 =?us-ascii?Q?hQtHXI+ll42u9B06PoYys73qCDwQXZi9iiqeq+CCMuvRRE1umafan7Cd12tZ?=
 =?us-ascii?Q?THAIZbIqQ0dIxKl4GMexreaFFNBYrJF2KbuJ+dafuPREGDPZlWudmvVhRZ8B?=
 =?us-ascii?Q?22JU5Cks0ntC0oKbHwgCNAZAnmlqW9nWn2swQRkQRmAKL7r6TSXc+gZz7hBD?=
 =?us-ascii?Q?Xf4mY+sex3ThWngJUoCsw842EE6RCWT4M+QsA//89z32m7pl4ctER1pLeL5e?=
 =?us-ascii?Q?7mfII10Y3I+IJ+5ODY+LUO9ZGm/8I7x7Yh6sQwJiB7BFFtFHkuiKQ5UenSqx?=
 =?us-ascii?Q?lnhoc4Ef1qRlLFST9omReXyXxYXR1VXer3c9hokKTcqyoFdQu4bRxZnC2XLw?=
 =?us-ascii?Q?3H3yIWjByBN6CC/0YRINZeJ/L5z6cyn7RyEr1QKv1LBOOrSTFhVZS3HHKJAD?=
 =?us-ascii?Q?MeaTe+4TX8E+H6K+7FpCEcDU9GyQNtCIvPnWDF0Ea3YTgv0RDUHHgoH7wMQ2?=
 =?us-ascii?Q?JJSJ2uRH093kPZ7GwzdKHrnRfOZu0IjIFn7ViQs52o/vn/lYh99O4ywGkVQN?=
 =?us-ascii?Q?RcMUKRycArpoF4TR8EF+Ulur1HtLTRxcnKX5rqmfn4Ag/cSBpXm34lql4o46?=
 =?us-ascii?Q?ufAltpT5hLGloUj8bvfomFW94QfN6oJk1Kjh+3dX+qLcYHeWpRlujgBL/Tej?=
 =?us-ascii?Q?1Z9J4AGDUAO4SFvlgDwBfTqmhuXIcngPcAH9rnyYdaGUole0wxcGXIMiQ6PL?=
 =?us-ascii?Q?9KUr1fu6vE1Z59vmBzlf7yEUjsmH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBs6NYSHBevAV4GxJ+pi74pWg0qxt5/uacmeA+RcrpyUve/TajTxbR19YVD/?=
 =?us-ascii?Q?c4oAGbAepq4PsfgR0gOQq8jLlo0V7qwbj+Vaqb5sMciA2P1SLQ1aSoSCkE+y?=
 =?us-ascii?Q?F2EhRfWyX3Pp3NqhfaU7WusJ2leDUrFTIuzuyLdw+5TG4xWy+ODR1STmu5nf?=
 =?us-ascii?Q?ONkEqFxc6oO7WzXSsrV4G7fswDOvGbBrfNDjtSbZYoLNteXCGAYo4dgSDpX4?=
 =?us-ascii?Q?Ke6OjnKSavYETA2WuLATr6d3LtllpNYJS/OEfTwJUY3DMYwoOjsdwZbbO0uf?=
 =?us-ascii?Q?wBrjxtWdVttzuG7ZpRUEhuU2t0Jic+ibrp3prSlabOBCqEWo1rvotvX1li6M?=
 =?us-ascii?Q?o35Aho3brNJhkW1S0aUUog7eJIPoN/vY6W8hr/fBpDh6W0J1p3lAAQ+cCvaq?=
 =?us-ascii?Q?+q0taeELHgs60sT2zLUciRaWFtX083yFliAKyGiQk9Krvxfc7zIytx/SukYu?=
 =?us-ascii?Q?79zG1sxwHV9/wsKQrvmomWH/7RVQHE7vVrJveAUCfi8dHpTGShlOtaLsrXpr?=
 =?us-ascii?Q?hKHcyKMdCMoP7AU/hP3PA2yyDlJae0DaMlLNtx/ZSrsbttZ4moaKZGywjhmH?=
 =?us-ascii?Q?uoIZ81DN1YG037NLNMClCjz2hqmHJ1RKM7yDeUC3HiOs1d1tM5Ihyenfs6hd?=
 =?us-ascii?Q?wD9A7PpZ16qQcobp+o5YDNLiTyQOCbMFmCRn4sGdHg8f125I1VCphk1VGRli?=
 =?us-ascii?Q?2RioWinZjfw1AdjIAkJyDNNQbJl3kGNYZgFP6INUa6dD8TFUJpeWEPLTnV2F?=
 =?us-ascii?Q?a0+XFhJqTY7IAdDYtYTzUkPyKLtFMI+nKv5zDAp5+GWGXVvbn4fwlSFH/SZy?=
 =?us-ascii?Q?gUwD7jvLQKsBILir88Y7uxfmiWzBc36Da6jOHq5TKG5RKhdoEre8I43ep22s?=
 =?us-ascii?Q?ZFd4aqLlgrGYf4mb9PIPgbv6AspbZzSz/vVBoO6viqI2SefIViWiqeSX3tqu?=
 =?us-ascii?Q?5jNruG497SMSjZ9xSVnLIAeD3DUbbFVQ8bh8Xgc3aiIZcZjvtWecp1IMwAGI?=
 =?us-ascii?Q?5GIdOZmtuirBdtSnJLIjagdkpyUtx9JbZlKuBeZ+24CBrXCUAJIT08EbASLh?=
 =?us-ascii?Q?O58N6s1HUqhRYQWJXzMHG257cuuccz3YfgCjWO6CcfKIeWT+RApf8b6bMhDO?=
 =?us-ascii?Q?wnf801Q35LWePQWUPDBtUEDNOP6nQxxwW61vHwwYJZZkNNuLqZj+DzoSCTI6?=
 =?us-ascii?Q?WfaZtlIacMMI3f1kaD8WRHUANS5FwquCb0fhrPeX5EW6DU8oXQitvMdUo7wQ?=
 =?us-ascii?Q?Ptrl4dEy8wPvwSCzOtN7SzzWWjJVnGv8IBqPnNQYkptFykLk2hAWCM1pPUAZ?=
 =?us-ascii?Q?dKnPhBzTJN9/nq2nj+aFE1XXqIwXUEyTzXIwfPpvnGlekIh6k9Ys5MWA7pIg?=
 =?us-ascii?Q?Sq5wURdFNr7BLt8+XobG5WDCZ7m980KC1f3jjpTAL2GU1bH+ZXtgNLGFWge/?=
 =?us-ascii?Q?HGklH3kaYn9vRJW43erszc6xSMJKY9TV4BQqwOn/8J/6CkSrxKmajTHIDKLM?=
 =?us-ascii?Q?l969z3b4hjqxENAHBk3DUn6MCbG9d9yeoryfLs1iWc5/W1agEY+qHTaiyU6d?=
 =?us-ascii?Q?goXxmu3MoeAGq2jYkrsCh3LZ/Oq6T3uXeCdty/r7KVtnDhWpF7STf0xteMK2?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d622456-1a21-4192-c83a-08dd62fffe5e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 13:56:18.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4M7iKBCdBIBVEG5BChOvDbMdMj0r83W7N4viKnfDtlF4Sv8+V7rg/7LpJNJA+75WiyCwlyio0MmBaDOKG0VBhA2w8cMg6827TaqhGr7++1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7667
X-OriginatorOrg: intel.com

On Fri, Mar 14, 2025 at 08:22:26PM +0800, Herbert Xu wrote:
> Remove the unused dst_null support.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  .../intel/qat/qat_common/qat_comp_algs.c      | 83 -------------------
>  1 file changed, 83 deletions(-)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
> index 2ba4aa22e092..9d5848e28ff8 100644
> --- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
> +++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
> @@ -29,11 +29,6 @@ struct qat_compression_ctx {
...
> -static void qat_comp_resubmit(struct work_struct *work)
> -{
> -	struct qat_compression_req *qat_req =
> -		container_of(work, struct qat_compression_req, resubmit);
> -	struct qat_compression_ctx *ctx = qat_req->qat_compression_ctx;
> -	struct adf_accel_dev *accel_dev = ctx->inst->accel_dev;
> -	struct qat_request_buffs *qat_bufs = &qat_req->buf;
> -	struct qat_compression_instance *inst = ctx->inst;
> -	struct acomp_req *areq = qat_req->acompress_req;
> -	struct crypto_acomp *tfm = crypto_acomp_reqtfm(areq);
> -	unsigned int dlen = CRYPTO_ACOMP_DST_MAX;
> -	u8 *req = qat_req->req;
> -	dma_addr_t dfbuf;
> -	int ret;
> -
> -	areq->dlen = dlen;
> -
> -	dev_dbg(&GET_DEV(accel_dev), "[%s][%s] retry NULL dst request - dlen = %d\n",
> -		crypto_tfm_alg_driver_name(crypto_acomp_tfm(tfm)),
> -		qat_req->dir == COMPRESSION ? "comp" : "decomp", dlen);
> -
> -	ret = qat_bl_realloc_map_new_dst(accel_dev, &areq->dst, dlen, qat_bufs,
> -					 qat_algs_alloc_flags(&areq->base));
> -	if (ret)
> -		goto err;
The implementation of this function in qat/qat_common/qat_bl.c
should be removed as well as. After this change, it is not getting
called.

Thanks,

-- 
Giovanni

