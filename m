Return-Path: <linux-pm+bounces-27713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F6AC5F0E
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 04:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08A41890C90
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 02:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C781A38F9;
	Wed, 28 May 2025 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMXJIN57"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1791531E3;
	Wed, 28 May 2025 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748397896; cv=fail; b=f0V34JQykFmN46RvY8yL1mjEKsWe9jxa5R4qove/fAfJZ7eMtVOze1W33KNrTXHS6KB7ybqlAyzL7x47Hocv5h8eKtQOpaX7Wc7PHD9KzK2lCDy/Esx6I36wMe+78ucEAzygjJzQ696ZUeJ7uUyXXEA/k64cglFW1/Sd3DPhRl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748397896; c=relaxed/simple;
	bh=9sy3RlhEhdRBQIA0RxS088RTLyYe04x5AOy6nHmOigw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wp+AEL3lj0oOPZ4PpXwEKV2TW4yqr2dc13L0Y50Q9NkqzA5djP2D6mLTozYEywYpcsgN2yZ05bRbYSnksd0eQ68ObZHYxUoy7oPkwHXgmfafI/LUH2GEHJdSXRM61WVF6aAVOsi3dXeik22ag898OIsb5CV7Act1niwHL78y8GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMXJIN57; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748397894; x=1779933894;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=9sy3RlhEhdRBQIA0RxS088RTLyYe04x5AOy6nHmOigw=;
  b=IMXJIN579e0uOEsX1GdEpfqshX/6CKGTkU8VjBLOyloxj37D/EHW74hG
   Q6vQ5rrI569pD4ogV/2CIIVgW/h1ODhrpDHrJEkfNGhXDr/tD6DIe+uEh
   zCwriZPMl4UKh6OQhGTIyAbPEcGLFdBLbXJe1S5g/0pCMNkwGEOAV9Ffy
   SKPcy7fJPlzVXC5MyeCCoqkIi2P440kJw80VyoUVdA1LOnHOLZ7+sv0qx
   tx5EdAyKpq4Zvrv1f5+wvlvG6e1v26DbPmKvGFE/wEn1xkgidOO5Jh1+/
   qAAVXhWILXd1fBVEGkesnpNo/EePMW4OqUzXo/6w1DbZ0hPve6yIxbAVN
   A==;
X-CSE-ConnectionGUID: x8nU5Z2IS8y8lX4X/kBVIQ==
X-CSE-MsgGUID: 7rYBwEsgR/iW+UpBKoL2Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50334229"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="50334229"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:04:54 -0700
X-CSE-ConnectionGUID: jYj++MlnSrCyYHlqk+fzuw==
X-CSE-MsgGUID: xxs6CBP0QHebNuTadVeI+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="166252411"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:04:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 19:04:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 19:04:53 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.62) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 19:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw0S41OaEm9IT1qCQVCMwikfGqHtXCJDHmzvIwhRoPCxoU+LjyhPsGRwIZZJo4ngYzaLqfHb2KOn3CxfkepHk7eJVBqp2y3SKJICf6gaSYr1RbGKT7Grc+V5Euetw+mZlwuJBqu8XreCjqIg5BzKSLElt1c10ErarALjxAH+lhYBjNlxu6VNmbB6p5Y1tHvBWr4uCjGL1/IcE2YCVIc1y42H+HxgOMEP2NKaicFzmT9QqxpIAmbvyqC0a5ZTFoJ5cQ+AE5iIWAs1IwVl6svwBgcxZcrXCjpzp5yrG7yINc6DLFG030x8dLs+3T59a5FaAZvJwk/5uPfv9ARmcP5n1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0sW4qeC3zZWzefKv4Oa+Ie87yaN16SUKIVAVXG/pzo=;
 b=j98VZ2+sTT+/jKMOolfXNelyHikGJf+bUOUH4tSz8Kj4BDan2UxjERamlkFSxb55RRn8AWJyOvYYjwAU5vn0rkjhpzNN7CN6uPE5VYqeK7A3atiDbsa1HydBTWETU5WJljigv8vI+6epik6Szjk/gbVSGmloSbSW0FmQN5NqFTzIyjJ8KTE0rMDIKzYcdyEKRASwWQUVr1qkV//gb0sayaQH9l5dQzGYoDq/kythL5tISauRW7kOs0BqSaSI60hTAGpCvqyJlBPRgZHpzWYBZ9R9gx1GZWhxIFZnPAgiM1K4KqmS0YC2FEbiH6RwEEH2qwpEaRMbZGC4JQdmtocMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Wed, 28 May
 2025 02:04:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 02:04:50 +0000
Date: Wed, 28 May 2025 10:04:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Ayush Jain
	<Ayush.Jain3@amd.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-pm@vger.kernel.org>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Herbert Xu
	<herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 2/2] x86/fpu: Fix irq_fpu_usable() to return false
 during CPU onlining
Message-ID: <202505280957.3efe5bf5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250520152938.21881-3-ebiggers@kernel.org>
X-ClientProxiedBy: KU2P306CA0041.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b916b6-5246-4a5c-e706-08dd9d8c07ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BV4h4dUAxLp4z+BG3TCfQRy070XpJIPRDIYgPjVV6qsouAso/r4jXmiv2c72?=
 =?us-ascii?Q?ViVRM9T6BGJKTASuZNUi8udh7oMk3ERyRus/AK5ym4Mbv/JkFIL/x3Z0tCiF?=
 =?us-ascii?Q?gj0Qj3v2MMSXloavy2VJfbkdRV+LQc+fuZsJEt8cLG35HodXXHv3028n6L8v?=
 =?us-ascii?Q?K7Ge8O4JK8S/Pm6HFGOvaPZMQWI9Axgx8jWq+u9KFwugKTdv2xwDThRpCfwq?=
 =?us-ascii?Q?BejOMFvs36KxmUsjizWXSpyRDAV+pVOUg3awd3DzP8bEG/hjuY/8gHrt1ktI?=
 =?us-ascii?Q?zlvXYH72P8iXa+RAMVkZTSuvi0MtvX/Q433/PE2ftiyeLkkwboZLw/eBgxsT?=
 =?us-ascii?Q?ofPaDBYGwtSkQ2vXJnTMdT4LDQHOCUs9q7Wq+1lDCRO7ZtrI966NkouHM1s0?=
 =?us-ascii?Q?rG9IFOwOumZ7KbdJ6jXYXp6Ifep/4zo9uKuVo3UrHsn7gfpC2RR/7n5BOCK7?=
 =?us-ascii?Q?H/yWDyQSWA4IBQwwa84GM15XsD6icoG7je8cDB720KBDSArSmPVPrabC44nP?=
 =?us-ascii?Q?d0Je61IOjB89i9gIwDcKq2swpYEeH2R4uSaPl1QX1f9hzXY4V3E3MwnOzsxK?=
 =?us-ascii?Q?Bmzda5HokYQm/SjyAisOalsl35c9NpOYOYpPlV+D/byc9KwPpbAqGQDSo/3/?=
 =?us-ascii?Q?xz2xdK18R31MW5OV76Z87PlDSJK5aJxqGvW6yXrlxeskGbJfFuvvFqmNnodh?=
 =?us-ascii?Q?vWE3ATkc9hXFF73HWk3BWwcGSCd+WFAaDwASDhJP/gLehO65cdAJOc7qUjJN?=
 =?us-ascii?Q?NWJ7deKotOn+Ra/KP2Kp+s7wh8pKqIRhQBn+MNjnSFrwgI0gGhnDSklg4P//?=
 =?us-ascii?Q?jTZJI/HvfWBozcbbbCtKQYEu+ivZJy5kO4WICHhtO3i73C+4tZ72fVUEzj5Q?=
 =?us-ascii?Q?ouKvBIEdP8JC8sKgr3HxLLUgPQuZgQETHrG0QmW5Yxt6DCK4onaLmQqti020?=
 =?us-ascii?Q?AOkm8fbQgoCarEynP0GwNndvEagj0NCDD7mXLOsU7FD28nvjutwnsKQKV9c6?=
 =?us-ascii?Q?XL29QFaBaCN1RZPrn5W07t6/rcsYLdJuQedWRRgqGRxHDk8TETML4Yp8dWfx?=
 =?us-ascii?Q?UsCgCp3snC/LGVHKINXy8KY/PKK41Ta4qQObgirkFcRsw7u1f3dYwUyEb+Qh?=
 =?us-ascii?Q?CjnoFHxaYeblFH6CswyPtgR/zQs2ie6jYup8fAIgfAU7hQOF8f8FQTQHz6b0?=
 =?us-ascii?Q?19RyANouxn+mo2U5sxt1L5xSg3Z3KDVMohbudWoq/up/6axBML/dqj6R2es+?=
 =?us-ascii?Q?chqgQnUu+hwInkD8vuK2Kb6jt59aBHoZgCJafrebwxRAPYaJVuvcfSI0dHP5?=
 =?us-ascii?Q?X4MLgyeKZ+6ssvrpjt+mPKMKoplrqeqNu6pij4pZcg8g9o/XnJQ/a0cg/Jrp?=
 =?us-ascii?Q?2ynMXa52535dbP9gM34RSjQ1i63e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YzepRcyZcCHHJfC6KcyhS+pT46xvPq0XZquha0u5/OkQtvDNFhnz9N7IFppX?=
 =?us-ascii?Q?01XwNA87AkjRjuHJWEb8zDq1c4mImL5gdyJtD1245af4cUYwLK0pfXNyfPbc?=
 =?us-ascii?Q?7W5qpdtftsveC+viMxMH3vyBfWIgxc37OK0x0Hy2qxgUMVbI/YKvY4+4XItI?=
 =?us-ascii?Q?TbVByJ4krFUK5U0RqCLG2/O4HUv29Z6TKofiVbITR0jpaLa2+JM54vFSVo/A?=
 =?us-ascii?Q?+S8L9Wcuhr01OlCQV4sRuHXvE9tPZmWTtYQe9JMQcZCs7fsqLVsCp+GigIyH?=
 =?us-ascii?Q?K083FpizlA1+XIcTLXw1ETW4k4CyeowpgQit//ydk1aXH5R/Ay1zuHxMJn3V?=
 =?us-ascii?Q?wHstGzvbt4PL4uieRlxYke2jP/XsdKv/iVlakKSupA1RSHnsRhyEvh6yaCVf?=
 =?us-ascii?Q?+Y9+BE0EPPY8gQoB467NPHka+00UA5O5fuR9qtGkNrb7EpcKTOsVuqgMOsHc?=
 =?us-ascii?Q?br7H19CORUtm/xZG0xXOZnntEJ2eJe4/C7G4fIMjadLLhbXOqDOInlc2dvR4?=
 =?us-ascii?Q?9kE6BQI7ZjBSz/Yg+wkDJ0aywqMZNv3o7uzzin0ixTwh6wdc3azsauSOCVm8?=
 =?us-ascii?Q?g8ZtHJiev2ORpuDQwpiH8mE7+A/iq22tEdeEqj3yw496RzIgqHelaO9IhH5p?=
 =?us-ascii?Q?42GeRsGx6xN1PwjFVBQWK6BHd2lAGM/z3BNXeWCEkhUG62GydkDYixEhLMVM?=
 =?us-ascii?Q?gIUzQwGRCR+Dw/FqXCRk/hW0++DrODtFreVEojvhzPIyMpePzJ0Rg9hwmPdc?=
 =?us-ascii?Q?8js3vIolfnfgzR9a7rGe2qYMi9kxOl/ZiP+u1SL3+vv2M6fh5wR4ocYGwtGc?=
 =?us-ascii?Q?6Du2kQuTi7lDlekoD9KbM2yCKPu0qOHv5wPLkAZug+CHDTqAmev1WhxcJ7uN?=
 =?us-ascii?Q?pBsKtM+B4f9YMj0GCvl3njy3KdHF7oMiNyIuHubCbaiDHQJFP91KzC6JrQWG?=
 =?us-ascii?Q?Qw+nwg3y6OdG6vuQepZtPeDUmqD1cXoHsojqAwO1A33Ep+yYLngwzT+OjFyU?=
 =?us-ascii?Q?5hjfiSYJ5rJIBbXoYg/04vZ6spVUR6tRrEW2tEBnjNFUDIjwqH+qfQn4kOnQ?=
 =?us-ascii?Q?vGgDZpFiRATeBrLkY7dCtspVp4s9KPoIiRerQNU8vYebsnk4oULiMvbzxS0N?=
 =?us-ascii?Q?2L5gYjNA1smU7grVg3z4veo7S+GCc08sBRRpcgcIWLBZBpcJs/Mzuwu3496U?=
 =?us-ascii?Q?0ZTz5tE8SVKxg2vvY6o9q0meUrQXCzvSpp597iY29Qq0nApfhLkPMFohoMbG?=
 =?us-ascii?Q?lr2N+NIw4w68GC6RnvZj/UqZXDnfRarrNuRF913TPwEH/gquZNhk87uhdKLw?=
 =?us-ascii?Q?KjDNns7UlRzkjCW1TZNfLh3YRGrUJWBHVg2CZO8J25TsJrZoVJZvPiVDzPJk?=
 =?us-ascii?Q?OLrZiFOOAYzWIcA5b0Q8GNHocUAPQTqxw8FDK+ff8bEp3FgzA+p1BnwfZH58?=
 =?us-ascii?Q?norbpS6hyAuSWRpDNnXZj/9e3NJEKLusDGlEwjMiTtz5TI4fvp3rG97ie4kS?=
 =?us-ascii?Q?yM5+U+uK+MHIPCKia9mTnw6fALbVeWy7W0TrTzVGzqo9NoUkGfHf2MKhUTll?=
 =?us-ascii?Q?DKAEscBJIxYYPzyCXHphfrflI4bpSZ1Fp0poDO/EZZrM5gBYtAxGP6j1/ejd?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b916b6-5246-4a5c-e706-08dd9d8c07ae
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:04:50.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4Cjf+B2NSCeybI4f9FMRfY0JazaIiSK6rREXDy+7uJ0FfIzQdMdlQiaS3xMQjWQj8wRFlkXpCpjcFdnBfzNJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/fpu/init.c:#fpu__init_cpu" on:

commit: b88c4665c7f43e1898f695642fd159c6c542e49b ("[PATCH v3 2/2] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining")
url: https://github.com/intel-lab-lkp/linux/commits/Eric-Biggers/x86-fpu-Replace-in_kernel_fpu-with-kernel_fpu_allowed/20250520-233322
patch link: https://lore.kernel.org/all/20250520152938.21881-3-ebiggers@kernel.org/
patch subject: [PATCH v3 2/2] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining

in testcase: boot

config: i386-randconfig-003-20250522
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------+------------+------------+
|                                                      | 5454801de7 | b88c4665c7 |
+------------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/kernel/fpu/init.c:#fpu__init_cpu | 0          | 12         |
| EIP:fpu__init_cpu                                    | 0          | 12         |
+------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505280957.3efe5bf5-lkp@intel.com


[    0.324937][    T0] ------------[ cut here ]------------
[ 0.325455][ T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/init.c:56 fpu__init_cpu (arch/x86/kernel/fpu/init.c:56 (discriminator 15)) 
[    0.326299][    T0] Modules linked in:
[    0.326690][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G                T   6.15.0-rc7-00706-gb88c4665c7f4 #1 PREEMPTLAZY  c76c09082e833299bbcc71b75dc4abf37758b94a
[    0.328079][    T0] Tainted: [T]=RANDSTRUCT
[    0.328493][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.329028][ T0] EIP: fpu__init_cpu (arch/x86/kernel/fpu/init.c:56 (discriminator 15)) 
[ 0.329483][ T0] Code: 75 00 00 db e3 e8 64 28 00 00 a0 10 76 8a 83 84 c0 75 17 c6 05 10 76 8a 83 01 83 c4 08 5e 5f 5d 31 c0 31 d2 2e e9 58 cc 8c 01 <0f> 0b eb e5 e8 b3 0b 8c 01 f7 c7 00 02 00 00 75 bc eb bb 90 55 89
All code
========
   0:	75 00                	jne    0x2
   2:	00 db                	add    %bl,%bl
   4:	e3 e8                	jrcxz  0xffffffffffffffee
   6:	64 28 00             	sub    %al,%fs:(%rax)
   9:	00 a0 10 76 8a 83    	add    %ah,-0x7c7589f0(%rax)
   f:	84 c0                	test   %al,%al
  11:	75 17                	jne    0x2a
  13:	c6 05 10 76 8a 83 01 	movb   $0x1,-0x7c7589f0(%rip)        # 0xffffffff838a762a
  1a:	83 c4 08             	add    $0x8,%esp
  1d:	5e                   	pop    %rsi
  1e:	5f                   	pop    %rdi
  1f:	5d                   	pop    %rbp
  20:	31 c0                	xor    %eax,%eax
  22:	31 d2                	xor    %edx,%edx
  24:	2e e9 58 cc 8c 01    	cs jmp 0x18ccc82
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb e5                	jmp    0x13
  2e:	e8 b3 0b 8c 01       	call   0x18c0be6
  33:	f7 c7 00 02 00 00    	test   $0x200,%edi
  39:	75 bc                	jne    0xfffffffffffffff7
  3b:	eb bb                	jmp    0xfffffffffffffff8
  3d:	90                   	nop
  3e:	55                   	push   %rbp
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb e5                	jmp    0xffffffffffffffe9
   4:	e8 b3 0b 8c 01       	call   0x18c0bbc
   9:	f7 c7 00 02 00 00    	test   $0x200,%edi
   f:	75 bc                	jne    0xffffffffffffffcd
  11:	eb bb                	jmp    0xffffffffffffffce
  13:	90                   	nop
  14:	55                   	push   %rbp
  15:	89                   	.byte 0x89
[    0.331175][    T0] EAX: 00000001 EBX: 00020801 ECX: 00000000 EDX: 00000000
[    0.332290][    T0] ESI: 00000600 EDI: 00200206 EBP: 83841f78 ESP: 83841f68
[    0.332937][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210202
[    0.333655][    T0] CR0: 80050033 CR2: ffbff000 CR3: 0413a000 CR4: 000406b0
[    0.334516][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.335460][    T0] DR6: fffe0ff0 DR7: 00000400
[    0.336093][    T0] Call Trace:
[ 0.336599][ T0] arch_cpu_finalize_init (arch/x86/kernel/cpu/common.c:2536) 
[ 0.337340][ T0] start_kernel (init/main.c:1067) 
[ 0.338019][ T0] i386_start_kernel (arch/x86/kernel/head32.c:79 (discriminator 1)) 
[ 0.338725][ T0] startup_32_smp (arch/x86/kernel/head_32.S:290) 
[    0.339030][    T0] irq event stamp: 2667
[ 0.339652][ T0] hardirqs last enabled at (2677): __console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:344 kernel/printk/printk.c:2885) 
[ 0.340902][ T0] hardirqs last disabled at (2686): __console_unlock (kernel/printk/printk.c:342 (discriminator 9)) 
[ 0.342501][ T0] softirqs last enabled at (0): 0x0 
[ 0.345464][ T0] softirqs last disabled at (0): 0x0 
[    0.346433][    T0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250528/202505280957.3efe5bf5-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


