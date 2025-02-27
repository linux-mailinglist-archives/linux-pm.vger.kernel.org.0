Return-Path: <linux-pm+bounces-23037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264DA47533
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 06:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11797A2A0C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39C61F585E;
	Thu, 27 Feb 2025 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVWGY6Hw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D51F5857;
	Thu, 27 Feb 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634062; cv=fail; b=WmXgZaztUY+hmIu+QbNWpXZCwUG9sjVLpiSR95nBD5w2DMCaDse+4d4RJnTZ96EVH12do+9q2rmKyS8qB7abhtFlfs0ox7JTz30UA85j+F0RLUPa2cyVzPdSZ2SSksW2Rv8oQ4Cv96qUUeSY73R8O+nUvXPA8D+N7yDNSmN6Yrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634062; c=relaxed/simple;
	bh=ja1UK8unt6AVCwNXB+7Qra/U8h3jNNfUfrVTBS7ctkU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R8h2So9GiV8AR4iXZJ47wVKSwQeYzYYH4FBZgr4BG1wr3i7Y67JSm8ppGaiDyi2YQYT7FQXZWfrCxfD3auuxok0Nrj39dI3gmb2Jtaa5fKN9dSNNbzvSGqGI7ya1qEoGInYVDLP2P7ld9O2NsRyOVAhNBVq4qZAgHZVRJLwadv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVWGY6Hw; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740634061; x=1772170061;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ja1UK8unt6AVCwNXB+7Qra/U8h3jNNfUfrVTBS7ctkU=;
  b=FVWGY6Hw7Qcra5WDFuiarQMZ1UkvbXCxlgk8dxEyDddoef7lKFIHCR/B
   SOJy5lauIYZPrsjqfMVpDz5S6tYuSAQoMZeHvybO5bGuchTejn/KcaBQM
   zVQfia7yI/tb+0WcBAQsd5tmJmyqHY7lKI/EdD7m/LvBlpa8r+Y6CEkkl
   zjNmluhW6UBqUFm/SG/F8jCd+wmSHTAc/KSCaXuUiKzZG0TLFKQ5kRQFO
   YfI3U4ZlBVWfNSmXLm7tloA6NYOSxPylNIOE1tIMNO6wnB/psaWm0Mzhk
   gSZeTDD/cYPwX3Ly46leochgVbFHrsNwKfnCrU7mFTwHOtSdXl5+VEPne
   g==;
X-CSE-ConnectionGUID: cx5G4IyWTCukdfwvYYIoew==
X-CSE-MsgGUID: 3u+gqVcJQD+NjRrtsgjxwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52906502"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52906502"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:27:40 -0800
X-CSE-ConnectionGUID: GFb27J56SG6YV5yUx242wQ==
X-CSE-MsgGUID: 8rlsL/MqQxaKfbkPfXO0hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116947131"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:27:41 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 21:27:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 21:27:39 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 21:27:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ6p36El6NmoRqNK3YEBn5tBM2wPV/Hj0VMK4Rq0G3/MI9aaeu5RM3hEzC9CZaP5f16FQ9eD8ZwNh5rxDu/iTPsEaL1D97D0dMjeGOD45/A/QfM3RzfifY5ZY3kqdQaRqRiV2BdasmbjznuOyS4cKT8rIhIvEP1VwbgBpIqErbiuPYaRFmeTuEP9rZGIsNoVvs9kGEYaFimJ9f5LVzjyogWWze1pwa8OSWSBGE2pX8F3+Ci5mLzbfHKxgNuLGQBu219+Dir7vJbT0t0O3AgCclBd2BYcGQ9xBQA0wD9ieYnDeRw+r5mAxM3GwM1ggT3LV8yAZxe2XdDpllAnPrlmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFubd7Q9aoTLanbZE1PsRsRd1E/BU8+1pLA3wEJTZ94=;
 b=uRrMED5xf2gvfS6aDaTPBp0RLW0KqVewQg/fPESv9MM7v7O9Sactw4gb6bCTEudIDM1Wuq1k2lNDA7Srax2n8WusP25xBMhnFr6nk0/LABDx0Lz/Yvk5uId6oF9Vd16Wlc58+YgAaOA3EdBQbaBqKbOhvlPLxtvjRBi/y5+Nq2XiNRS+wmF/6S1Y81S11I3GqmnU3G1P9almi5dG1GATuV65d2VtU+IWlthmtjKY0zV3YrNZq4mKnZR5mKPIAJ/A4HrHb1/TJBRfBnPpcqXL1rUGze76hCWdULpdogak04pIBxcUS295epIdGC4VOtx+y7ryI4q21huniP1umyb8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 05:27:30 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 05:27:30 +0000
Date: Wed, 26 Feb 2025 23:27:25 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
CC: <intel-xe@lists.freedesktop.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?4pyXIFhlLkNJLkZ1bGw=?= =?utf-8?Q?=3A?= failure for
 drm/xe: Eliminate usage of TIMESTAMP_OVERRIDE
Message-ID: <utg4zpjvkeftrmoxoxlc2bpxkijsolte4xlxb5ikoz5347el3s@chxnpglfhmme>
References: <20250225224908.1671554-2-matthew.d.roper@intel.com>
 <174053697318.2172308.7135936144805731888@b555e5b46a47>
 <20250226214631.GE5109@mdroper-desk1.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250226214631.GE5109@mdroper-desk1.amr.corp.intel.com>
X-ClientProxiedBy: MW4PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:303:6a::12) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b2f6af-4747-46cb-be6d-08dd56ef6e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+7mF4ysgYZDQa5Kl9uqeTHxCCkWvum30xnNX0/0aKr/GQ8Hc30UGMPOPuLl9?=
 =?us-ascii?Q?EePqc5+kwiI41/BTgJckTBnhFXBSrqHmd+kxQJZmD+maP/d0QXARl6CnxMu5?=
 =?us-ascii?Q?0tU/ChgbSRCQPZZDBTqfjHgc1f9RGr/97OaaFumHT3Sm5RrBGUsYEtCCsowD?=
 =?us-ascii?Q?IPnPoWQkMSF4znoXrgHkm6CzDg6FLqKE1apSUMIfwv4FH3jWVB2qyV++xKf/?=
 =?us-ascii?Q?fiU10i+scD6FpbWTObryGUYbYuQlumjTg1OB4KHuXoo/8g6WiXt3Nm2fKnIu?=
 =?us-ascii?Q?w9aJzsHNCfzTPq7DlxnmPLzqLg1N9pII03k7xoybFrEdCX713AJ457Xgu/Yh?=
 =?us-ascii?Q?TYMLSq23K0zL2yRBpRT+jIjK8DChgJY80991DKl0ndpVvJ4Ko+Revs8v0YuD?=
 =?us-ascii?Q?I8HixL1FatAPNm8DqQ364t8eq40yvW2HA11XgIOUogi3X55V8fCZLAZ8+cv0?=
 =?us-ascii?Q?7k9kQ4kKEqn8DHTyb2vajCuv2OYmUl/TpjiFHeYjkcJD7OcFJrGtzUk/K938?=
 =?us-ascii?Q?AtnMdw7vdt7r64Pv6A8eloWeie2ZULHAuu4OimjWV90FKcxNFKiNPFfSomZE?=
 =?us-ascii?Q?sqS9QtdQBTQMWqqgikOtc1ygdpHqfDFM4Pe7ymrFfvv0SRUDa4LqEvizFJgm?=
 =?us-ascii?Q?ggp+Sh9etzTR8EzkrCN+fAuprY1IV88n2bsOe343R00gK7tw8yx+CMgoOvTL?=
 =?us-ascii?Q?6PIgYdU1ZY0aDk4GPtBdj0VBBDddGeIRL/pKx27iqbkeOdtBqRtSF682FX+6?=
 =?us-ascii?Q?DCNCTXujlyvrMb+ny0NNCO1sNlQCRKF4Mm52GFdDF/Ayx1POvmCPd4yyI6fh?=
 =?us-ascii?Q?OJBhVl0cwpjZCxHkP8eQczVdM6yGH8x0127dzLp3zPim6rNUrhBxBKqWO7J9?=
 =?us-ascii?Q?7B1Wjcf68zNO8JX3aXYm5VBWQs6kcE8Hi15Q1ErObuU07zC+cJBDHORShyDF?=
 =?us-ascii?Q?U1pF6Jo7FMYqR5nf9dALW567dmhNO0V40i4EGgp6fQI89wAC14de0ubFgKAZ?=
 =?us-ascii?Q?ErRC2DV1L8n5zaqliEpIcjCxWqO9VKN76K8uHjhpLdufFvCgK1sbMhpiI/G/?=
 =?us-ascii?Q?dT69jrsmuBfJwcelM2xlYovWXlhKIHTWPDoRorEoBbIRZ5a7AjbcdOWPQm8H?=
 =?us-ascii?Q?ujZDAzx5/buVubcNZMCf+hUoLguGofZxeKuPePqtT3YCkoHAemoXhJkZM4Qj?=
 =?us-ascii?Q?gRjL6QsUwclxQ49owTU2t/3Ww23Kj6PbP12GC+C93uSTOq2rG+iBzZyEbU7C?=
 =?us-ascii?Q?pJZm4q3CsJTc/pinTJpB1P+ZN1leC7HfRkO0TJxVRYi9ndf9CTr0G1zQP8UP?=
 =?us-ascii?Q?JhIjiKbk24oCQIbJtuPk7Wfq/82+t+tbgKyrPlkHmWnICl3HjZ+fHuqmIDpb?=
 =?us-ascii?Q?dyv8yNa8Ra6TETBDQQO6quhhnjNYP0J7rVsY4Q74P+h2G7g2lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjNR0hAmYlw9QYN417nU0plD8Akspx13mWQkGiOZlIfuaZOOWy9K4Q1DP18m?=
 =?us-ascii?Q?yGPKUBoVWbNbdq1fu29XY3RJt0kMJANk1nPVo5aCYv0egcv5yfPVf4Rh1IJ9?=
 =?us-ascii?Q?vzEcZJmn1JeoNIEQYxu+IpNdOvFP4x0GTW8FpeNVQtP6T/PA/5qp52PNMoUq?=
 =?us-ascii?Q?6mPq+7miTdeR9BsV6JGpy1Exx9/9aNV7dTpd1oLBKVKS3H7mzd6htPmqcSN6?=
 =?us-ascii?Q?nIU//TBlQmUiJd79rxJDiuBPq+KqoW6z1JB8vtG4mfG2PtW8uOjwvXgI2jmp?=
 =?us-ascii?Q?y7t6vZVdPXUKexgZO8fyi1C6DgKMaFL7NdepWprfocNN0lgKO0ac5rLelJd7?=
 =?us-ascii?Q?3ozQx21meaz4sfc0aSw7E/QW0LnydbgGj2Ytkq5+KBfy7WTbh36Yv2YHJW2m?=
 =?us-ascii?Q?+FTAEnfcTlaKQ0UAa+J6E+T+7AgMzYLvSQMHZ3F+F2IQNE1gZW1/6hoXKxiz?=
 =?us-ascii?Q?25pL5FzmtNb9/nNrOCgIQB73+W3p5hjmWmUOrmHzL5ZSsZKtdWbnOmqfn2dD?=
 =?us-ascii?Q?UyxsichoZtc67lL657m3x0OzzURqGxZFWqp0bAMstbq8XLyKX2Nj96EPi8xO?=
 =?us-ascii?Q?xkEhGrU8ndYYgEJy5GVmS6Fi7xzP1R4iPubF/MJ8AfQ4iQWs64UxafD9zG8u?=
 =?us-ascii?Q?OEaOZTp/ZDuWB6XO4e63XVpTELb3b0VgCtDVFGXU2iDHC2iOpthEf7UUUhK4?=
 =?us-ascii?Q?2hNVnD20xjVG4jz4YZ/jRnLWzfrBAylVmwyF47F+kf6vLFYgLxMlqrlZF1kT?=
 =?us-ascii?Q?DCjdciuC8HralIiR572v11WBiaEjtfLnxcgcsPWfl870DUCKXBxH3W2+gV4U?=
 =?us-ascii?Q?Pn21CaFBwY0lkk3SCHbf5BZ/9yzk36leBppoaJAyu/9vX6C1avVtp7XIO1jw?=
 =?us-ascii?Q?1xz440jPD4UXLYraeZg47aAsJxQgYCoKHBql7lsIWLOehW4eKImr6ejlzQA5?=
 =?us-ascii?Q?kBqZSN83MRrKpsmKJFvRoGujZBRDA7grcAPusN7SaNtT6DkOLz4DSoq+mJYF?=
 =?us-ascii?Q?u+/pxyfUgYGqjjjur1sKK1NzwDSiayZrZnxCm2sGxtDRYGpxOiF4QuYyjobQ?=
 =?us-ascii?Q?hElre9RtQN4jkLeBAa2lUGYchQ0I67VsGwUa/azysh9p66Kj+Mg9c3XiRoPc?=
 =?us-ascii?Q?jxD6t87Rcr0qapHyN+RT6ySOwKWSsUXroRW7v25k/8U/kzfIZKAO3fF/F2oe?=
 =?us-ascii?Q?TCQYpQsfqFJMfcs1OMsX2WJyBoc9MZeTwQl/1GJQxPPCocRbqIzHMYDzidIL?=
 =?us-ascii?Q?3793XSZSbXSBwDGWDHp5lAUysEmRtLakx10hmoU6U/h8QCkLtlWe5ClqRBW/?=
 =?us-ascii?Q?a9lRtn9nXKT/aGUzbcNnT77UPjSko+MXrtV0Cp1Q24XuKg909HXGeFzgdLux?=
 =?us-ascii?Q?53f3JfH7qtZT4ioJa1ZlCDe+6Fue7JQe6SfjknlI9xXITEsdlHl5m9aBqcYL?=
 =?us-ascii?Q?l+lbn0Gz4RupA3oeI21JbB3SbZLt9jQTQnuiy5LiSmrAb7YR9Kx1jpsNAZqC?=
 =?us-ascii?Q?9uKF6NkfjlmbrFe4WY5fDqwSzq0+QpYRApM1GP1AX5RTQuKAKBFH7F6h7AAp?=
 =?us-ascii?Q?7egJNbIKRIfyyT9WnGiSKHBJRNhQFPUQy2QsZJ2nJoLBlREcRAILqCSxIcje?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b2f6af-4747-46cb-be6d-08dd56ef6e69
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 05:27:30.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tH5WXp9nx5dyGGP89P/553WkSOFhKVD/IwUV/j/Gk7+X98XAq+4LsG5RXHP7i57vHqDmnkhoxa32KgV2Jt2y1EvDcgmY9chBSbqHnvd/t/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com

+Cc some people for kernel/power/process.c

On Wed, Feb 26, 2025 at 01:46:31PM -0800, Matt Roper wrote:
>> #### Warnings ####
>>
>>   * igt@kms_ccs@crc-primary-suspend-4-tiled-dg2-rc-ccs:
>>     - shard-dg2-set2:     [DMESG-WARN][2] ([Intel XE#4330]) -> [DMESG-WARN][3] +1 other test dmesg-warn
>>    [2]: https://intel-gfx-ci.01.org/tree/intel-xe/xe-2711-c7988865b658d56bcfaac76b7d72cc59435565eb/shard-dg2-432/igt@kms_ccs@crc-primary-suspend-4-tiled-dg2-rc-ccs.html
>>    [3]: https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-145437v1/shard-dg2-435/igt@kms_ccs@crc-primary-suspend-4-tiled-dg2-rc-ccs.html
>
><4> [319.697183] done.
>
>This seems to be something that happens sporadically when general driver
>debug messages sneak in between these two calls in
>kernel/power/process.c during system resume:
>
>        pr_info("Restarting tasks ... ");
>        ...
>        pr_cont("done.\n");
>
>Since those two prints were supposed to be on the same line, the
>continuation seems to be coming out with "warn" level (at least at the
>point CI reads it from syslog).

that pr_cont() seems wrong to me. pr_cont() is adding a 'c' flag to mark
continuation in kmsg. That doesn't really work except on early boot.

https://www.kernel.org/doc/Documentation/ABI/testing/dev-kmsg
		The flags field carries '-' by default. A 'c' indicates a
		fragment of a line. Note, that these hints about continuation
		lines are not necessarily correct, and the stream could be
		interleaved with unrelated messages, but merging the lines in
		the output usually produces better human readable results. A
		similar logic is used internally when messages are printed to
		the console, /proc/kmsg or the syslog() syscall.

And:
	https://lore.kernel.org/lkml/CA+55aFwmwdY_mMqdEyFPpRhCKRyeqj=+aCqe5nN108v8ELFvPw@mail.gmail.com/

I don't thiink it should be used in thaw_processes(). Maybe it'd be
better to define a pr_fmt and convert those to non-continuation prints?

Lucas De Marchi

