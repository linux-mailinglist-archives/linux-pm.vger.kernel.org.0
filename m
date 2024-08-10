Return-Path: <linux-pm+bounces-12060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230F94DD2E
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2024 16:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5501F2174A
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2024 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F368F15A86B;
	Sat, 10 Aug 2024 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQEEArTv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE4200A3;
	Sat, 10 Aug 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723298619; cv=fail; b=p8Mpud3xuGDlB4Q1nBY3LPrKEIUFK2UZXqPuKnQ4CsTKIRonXbAh0Y87kgoatSXI3lAz0DVJw5LL73/PiI5RsK7w9WuEwvTzJpiRUEdH33yXrH+LzhAlcPFETZK9vjPy00Alwb6aXDvC9GZsHakKQOtBCtxGxo8En+9NWyt0opE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723298619; c=relaxed/simple;
	bh=Xw/WLi+XoJhC7gjcuWTTi+MQv5swsmFoqNEiqpdvY3k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kR/deULOBZGUmx2m2jZUPALq39bWLkW9066lVeck0uVv+p1Bihb5dTkaOIc39bp0a8ydTBlyccIqyV+RCVFbpU8Cgx1G5o1A08Z23xRZJvkur5FD07dhQDWtfRgjWbsb9s6hrXrC9iZFbA+Ps55FbqBdNg2mEwMX8ckkZyGaCoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQEEArTv; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723298618; x=1754834618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xw/WLi+XoJhC7gjcuWTTi+MQv5swsmFoqNEiqpdvY3k=;
  b=VQEEArTv/9U0l0R/Y+YNbxhyEWqHpX0Rf7pygrndvqzgKR78gn2t+f2t
   R3z3vUj09/gDz4tL9GCxOAOAmumgdXG28srm69TvHzeSzxz3Yub6z5WzX
   sKSNCMSU59HWL1fhJBQhgYqj5JUa5HX6NudOCI3ORwk7guwOlAWxgMYWO
   z7lrLTv3TDXlftkw3F2nnELOajHyQxsKZNfVH7bHc4yEZjsOncrOb4Ro+
   lk7P7Vwz9T51TEemtCa/T1jJqOrsp7MoyNt9nj98IlFvHQLi41++1q2RZ
   Z8E8xzrTPIPZ8OSimHM/tybGgVEJG1N/MSvTvsqZOGW3U8wHbPh/g3oRn
   Q==;
X-CSE-ConnectionGUID: utfvGHeLR0OzSrpN7nscCQ==
X-CSE-MsgGUID: UxjLur+pQemj+Zk+elc6rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="21590560"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="21590560"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 07:03:37 -0700
X-CSE-ConnectionGUID: UJnpDkcyT2WG/74aUWFS9w==
X-CSE-MsgGUID: XedaJHfCRta+rYhoXow52g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="57718757"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 07:03:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 07:03:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 07:03:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 07:03:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 07:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQbBFJWGBfqDg3jR/UJGE72UeM5LF2sB5bCJnqc/meBLT854boW6nxiAF7JhGVl/dvqb7wRmtSya6Mp6ptc1e35c35oKETAmwGOk+HSSPk1diIPeZJPVgb9Oac70dssUCDTV+feM/OSC4OcPcbVGRq5cYC9vmv6MJKc375EWXgS2ohZB9/3rrF3y3FxtjDFktrUrtEJ3yKaleast/ZDZfpPiu1HhdTj785R3NZ7j/a5k7T3kV1vtApP0Cu11P9O6qOE3eP8On9Et5nOHgOsJuEUgqzg8THqnkOHBMF5hTif1BgWOizp5wPFv/65fv40/W5+73a0r40nWUJND2qbchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUdk4aaqsZVFGCFN6kUphSb7RTF+dkcZWyIXDiGh5qA=;
 b=le7CjAKAS+QsxMtObiTeIJmBGjvbU4a1yPC0OO6FKCEzW8nvN38M4SB2DPoKW6YI2coocktRd2a66hvU4v9jaCTVELjEw8/HluWgDGaLxyxcdOTFo3KBaSGE/Cx0/Dy7SRmDHLloKMQ1EMzNysAXLjRUj3AUaEMkF3k3aTkrGv0udjmiTSEraDOyXvvvPJ21pJTDGGKthdfnRnadHjM39F+66jp+HE1XtJzFV2GXtcNjNktKNUWaZs2TIbCU3LpkMym2JYC6cLnBVjqi3vRuybveaBZ2QzSQWhu2uw6Rj+0dHsW4uxBqI62PQRtB3r6JLjn2tcWx+h3g6JvxKX4+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Sat, 10 Aug
 2024 14:03:33 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.023; Sat, 10 Aug 2024
 14:03:33 +0000
Date: Sat, 10 Aug 2024 22:04:28 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <hch@lst.de>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<axboe@kernel.dk>, <syzkaller-bugs@googlegroups.com>
Subject: [Syzkaller & bisect] There is general protection fault in path_init
 in v6.11-rc2
Message-ID: <ZrdzbFYJly8EaVzC@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ2PR11MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: ef927397-ff64-4ff1-37c6-08dcb9453853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vdw7WgLltNnApCyOAYi7Enfrr/J+nKPAcNLJJ0H3hTCg5pWYR9qr8rluo84Y?=
 =?us-ascii?Q?Uy7QhlWpppUP5SMgCP9+goTTJOuWaNmRJLtB++Qze7YWIJ/XrAhoH3zNF/c0?=
 =?us-ascii?Q?60R0SLqplsibvGmxMeBm/Gi3sQ3ug5cxAAG0ectzvn4x3gRlw+inDj7wMZzj?=
 =?us-ascii?Q?aG9py6Kydmfi5hUjUuC8KXRpfGWkHe7MWYzdGkzsBFHhWe5fGHZP7pbyqxCc?=
 =?us-ascii?Q?vGisDd6VNauMrhV42K8u6miIfdBrs4q1kF3QeCJhjE/t8WNgAv3YwTbbpqlY?=
 =?us-ascii?Q?e07uDyot/WbAZgBwraveQaCui9pLgCG5YNwqqzMZzHJ8Zm9UFTaWCHb80tkX?=
 =?us-ascii?Q?sFng5sxH7oCZCUiZ5fQXYFfPdGlglFxL2aswAyZ7GqzfRPahMcBu5e2gMgpJ?=
 =?us-ascii?Q?xK6GoZqJE13K95nppo7G19gjMPelsZSIt3ZTXl/ULm9PaRQbv6ua6iDgIa85?=
 =?us-ascii?Q?9rziTncfgaUN3QD3SjgfAVzBQwu8qqF2M9kG6UrIPXdUXh5z8+Vg4m3GQiQQ?=
 =?us-ascii?Q?EsFSvaBifdT5wWg+IFazIE8d1UBVYz9ScF46XszjcGEl0F05COJBLSPU8/CL?=
 =?us-ascii?Q?eM/pcdMkWo93tDpf1GdMl0f79AteTCeqMnuvKa31B2M/97o7/42nJxmo1EqS?=
 =?us-ascii?Q?PG5SEjXCpBp9bt1UwSuzib70/aRB+jd/UfXflTdQ4N0YCbdA7l8fE1DvaFIb?=
 =?us-ascii?Q?S9ouijC/Ci9EXHk1byjKc/gdb5KClqqWhVeywvURzLhpMvk/pd1ZogxtfZI6?=
 =?us-ascii?Q?JFuIQk0Zeyxa9dj6OK0BrgGWEQr/qIoQCv20LFl+R1M87J6+1mwOZ1tlNv8e?=
 =?us-ascii?Q?pdt5vMul/QNTzOfw9UJCD/hMPs1Q/hLRilRr3ibyzNIbXlr8un1NNllug6KM?=
 =?us-ascii?Q?2UmoYVLVORt74VInwenhiidxZPMeE01LtoF0lMH7Gdt7rusaceDKnhfBLYdb?=
 =?us-ascii?Q?vrPDmfyjd5GfAb5CwtB7PBD+s8rQs4Ld+XsV3n0RYJ4iInDRS5FKiPvePBKK?=
 =?us-ascii?Q?bv86jFSwsi703u/6oTdbmO2dArrAmXf9/U+AhCNLA0SBJpfHxUn5VFRdHVDW?=
 =?us-ascii?Q?CVaiQTznAeKJleFFYzl4WwKc/Y/Grro0Q2Sy7KaOsWj8hUtLrWMUoy3QVnaS?=
 =?us-ascii?Q?brMj3sg2tkw6yxFeSINHabCJAGkMziYJ/21My5Et1MZzaCKYQ5YeNhTe8FL0?=
 =?us-ascii?Q?R0WUOE/S8h2f89AInpoInVxt4JUN2W8sV5/n5pI7rNCX/O7no2rYtZyVxEBI?=
 =?us-ascii?Q?gac9XeW/QP9XWB7pK293o1PI0Y573TpUMlQoNBEBGdrjaLRqB8fJTl4mldg9?=
 =?us-ascii?Q?rtQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B5aFeM1aBLc7ErdZan97XaFiDHTWDCPu0jyKggeSMajOlVPz7tV2hDyN8cL7?=
 =?us-ascii?Q?NlIOYNZTeZkdefNlPoa6INsWeVZocQUGpwWTBuGpePj6mpaYs6urs/UFD/2x?=
 =?us-ascii?Q?QwflA7JQ22NBHNQcbr+4sQzKyo+6rT+UKeM/nfVvFyJefLOKjmpBL18M80Bg?=
 =?us-ascii?Q?v5A/BArPIkidUZn2wejmL5A5MQZTwRvtwIovHIYjC3HppD5RFKsq0bPZVFsl?=
 =?us-ascii?Q?DwFzYaC0+8UE6Bp1a6I+ZEF/09pBfLXT1ojD+Q3BepaWCyiEIroU0gxduqSy?=
 =?us-ascii?Q?efFds9cC68QKFSZEpOETGXpgqfBINmCVwSHw/9a9ZzctTG+zalEs2An0gmSp?=
 =?us-ascii?Q?I42sK1ISEn2F+ZGgzvLMha4rexKG8mRkGW7notVqk/ZSnGi4yS9r9rl6sYxV?=
 =?us-ascii?Q?+Zgu6rzjEAWJ/0EQ4O0V5DHnaCsxmCEILABvunZB95fPN35UFIGL+/Ll3SMj?=
 =?us-ascii?Q?S40cDJmsf0gJBLWCOnLOC8KY9wBiKS+aeqo/6r3BXF54GGwN/A8uWZCDSE0+?=
 =?us-ascii?Q?ZnsVm1zIveRUFli4MS/83aL/5etrKZ5COYEQIJ2TF1cSB7M63nLjC7ow0IFx?=
 =?us-ascii?Q?bheFtiWtfiDCzQCDQmtxT0+Kuvy1sbi3XqEIg6RqQ3a5KpQUmxRZTRj/zNtq?=
 =?us-ascii?Q?W82saiGzNMuN0E6RpqJaSQ1wg4KZ2Tl4Sr57aprLj3zOYZYkJfvO1zDZfey4?=
 =?us-ascii?Q?GEsWyY2WtW1dGPraUOE/Kga4TOU+oZ5j9oYKTLFCSY+wO+5P49toGWIt7XrH?=
 =?us-ascii?Q?nsgg83MGT9b1g9n1x8qDJi4QDO4AmYp5uWIdMh4XPuc0mEI6VHWwQT0Alv4m?=
 =?us-ascii?Q?ee9A9smkgr5otpk2SkNYRmNxHXlIvktKU0KL/dv6CqHsUb4a9XCjiZXStA3h?=
 =?us-ascii?Q?r5ntZqdjavKQI5edlJKstd/p7DaK9cXofEEp94bDG5uCqj6GazqRV2LlEr9j?=
 =?us-ascii?Q?2Gu6hWKOQUHqaeLsBNlgD7niLu3jdJNPVEVNImDpzh52n+utmscinMi14LxO?=
 =?us-ascii?Q?PrF4TdVMG+6/dKlaLOuBfYLsXofq/e5DF3rwcDGQmAEFIEar+T+PynDENFRF?=
 =?us-ascii?Q?28ub4i9waR/0RFleJeM93CN+I6JHrpqa6ef58JJJwj2GNA89w0p6ItoHgtWJ?=
 =?us-ascii?Q?/SlzstdmX77nEqA1USWyRNMvaY6GH82TF8Z0VKdHtM7GlDr+e6RqcCJrtSDQ?=
 =?us-ascii?Q?6uE4SYcu3v+kNfo4H05RUF+quR+hY2j4Po5Fl7nEER7jGOhvJAftODZ78+rU?=
 =?us-ascii?Q?f1vc84Gh0JSp39CtSYBekBksVK564Qk9GQ9DBPmcsTLjMzM6DObKk7ttVxMh?=
 =?us-ascii?Q?CugJTSuOPcwESVbmR7cOmq6x1zmklhzTsYwY8tiWMNgXsWP+wfQi1IzgBMso?=
 =?us-ascii?Q?TtGqw3yZMrW+Y2LMcjFtvaL22zzzhCgGtZPpgLUeEq1lVFgQrDBQqLj1gwGM?=
 =?us-ascii?Q?VJJxmcb3ks+LoeyhTSDuRqJ5IWXFBL17PotR6+dJ1bZ0b6a39D44fxj4JEY5?=
 =?us-ascii?Q?D9sEfv5GoPT3xHRfqARnJv2dGAl1CiIUYShGdLOVflCW1CjPerFyUPR03hEv?=
 =?us-ascii?Q?Lmkrcaj1xVsYSWNlXLoOvKiqVRyBXBZKleRWbSBz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef927397-ff64-4ff1-37c6-08dcb9453853
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 14:03:32.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vt9evdzt2K+rPwkiUk/0/pJRxGanNspwoTLHd3fZK1qP8BlsOsYk+77iK5k7RbVY7bQx2S0iflVYfMPkz+DWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
X-OriginatorOrg: intel.com

Hi Christoph Hellwig,

Greetings!

There is general protection fault in path_init in v6.11-rc2:
Bisected and found it related to:
1e8c813b083c PM: hibernate: don't use early_lookup_bdev in resume_store

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240809_171408_path_init
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240809_171408_path_init/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240809_171408_path_init/repro.prog
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240809_171408_path_init/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240809_171408_path_init/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240809_171408_path_init/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240809_171408_path_init/de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed_dmesg.log
v6.11-rc2 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240809_171408_path_init/bzImage_de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed.tar.gz

"
[   23.436545] cgroup: Unknown subsys name 'net'
[   23.567369] cgroup: Unknown subsys name 'rlimit'
[   23.737915] Process accounting resumed
[   23.747674] cgroup: fork rejected by pids controller in /syz0
[   23.749730] general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   23.750465] KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
[   23.750937] CPU: 0 PID: 719 Comm: repro Not tainted 6.4.0-rc2-1e8c813b083c+ #1
[   23.751395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   23.752100] RIP: 0010:__lock_acquire+0xe83/0x5e10
[   23.752422] Code: 00 00 3b 05 df 65 fc 08 0f 87 c8 08 00 00 41 bf 01 00 00 00 e9 84 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 da 48 c1 ea 0f
[   23.753566] RSP: 0018:ff1100001446f060 EFLAGS: 00010006
[   23.753896] RAX: dffffc0000000000 RBX: 1fe220000288de1f RCX: 0000000000000002
[   23.754347] RDX: 000000000000000a RSI: 0000000000000000 RDI: 0000000000000001
[   23.754794] RBP: ff1100001446f180 R08: 0000000000000001 R09: 0000000000000001
[   23.755242] R10: fffffbfff0e70d4c R11: 0000000000000050 R12: 0000000000000001
[   23.755694] R13: ff1100001a9f0000 R14: 0000000000000000 R15: 0000000000000002
[   23.756134] FS:  0000000000000000(0000) GS:ff1100006c200000(0000) knlGS:0000000000000000
[   23.756636] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.756989] CR2: 00007fec33ffca50 CR3: 000000000667e003 CR4: 0000000000771ef0
[   23.757439] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.757886] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   23.758338] PKRU: 55555554
[   23.758525] Call Trace:
[   23.758690]  <TASK>
[   23.758829]  ? __kasan_check_read+0x15/0x20
[   23.759101]  ? __lock_acquire+0xc77/0x5e10
[   23.759376]  ? __pfx_mark_lock.part.0+0x10/0x10
[   23.759688]  ? __pfx___lock_acquire+0x10/0x10
[   23.759977]  ? __pfx___lock_acquire+0x10/0x10
[   23.760268]  ? lock_release+0x417/0x7e0
[   23.760535]  lock_acquire+0x1c9/0x530
[   23.760782]  ? path_init+0x8cd/0x16e0
[   23.761034]  ? __pfx_lock_acquire+0x10/0x10
[   23.761308]  ? __pfx_lock_acquire+0x10/0x10
[   23.761591]  ? seqcount_lockdep_reader_access+0x82/0xd0
[   23.761933]  ? seqcount_lockdep_reader_access+0x82/0xd0
[   23.762272]  ? path_init+0x8cd/0x16e0
[   23.762524]  ? debug_smp_processor_id+0x20/0x30
[   23.762828]  ? rcu_is_watching+0x19/0xc0
[   23.763097]  seqcount_lockdep_reader_access+0x9f/0xd0
[   23.763423]  ? path_init+0x8cd/0x16e0
[   23.763675]  path_init+0x8cd/0x16e0
[   23.763913]  ? getname_kernel+0x5c/0x380
[   23.764174]  path_lookupat+0x35/0x770
[   23.764423]  ? kasan_save_stack+0x2a/0x50
[   23.764693]  ? kasan_set_track+0x29/0x40
[   23.764948]  filename_lookup+0x1db/0x5a0
[   23.765212]  ? __pfx_filename_lookup+0x10/0x10
[   23.765512]  ? __this_cpu_preempt_check+0x21/0x30
[   23.765821]  ? lock_is_held_type+0xf0/0x150
[   23.766104]  ? kmem_cache_alloc+0x32d/0x370
[   23.766382]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   23.766744]  kern_path+0x42/0x60
[   23.766964]  lookup_bdev+0xda/0x2a0
[   23.767203]  ? __pfx_lookup_bdev+0x10/0x10
[   23.767485]  ? __kmalloc_node_track_caller+0xfb/0x180
[   23.767812]  resume_store+0x233/0x540
[   23.768050]  ? __pfx_resume_store+0x10/0x10
[   23.768326]  ? __this_cpu_preempt_check+0x21/0x30
[   23.768641]  ? lock_acquire+0x1d9/0x530
[   23.768905]  ? __this_cpu_preempt_check+0x21/0x30
[   23.769217]  ? __pfx_resume_store+0x10/0x10
[   23.769488]  kobj_attr_store+0x5b/0x90
[   23.769741]  ? __pfx_kobj_attr_store+0x10/0x10
[   23.770031]  sysfs_kf_write+0x11f/0x180
[   23.770290]  kernfs_fop_write_iter+0x411/0x630
[   23.770584]  ? __pfx_sysfs_kf_write+0x10/0x10
[   23.770879]  __kernel_write_iter+0x28c/0x7f0
[   23.771164]  ? __pfx___kernel_write_iter+0x10/0x10
[   23.771485]  ? __pfx___lock_acquire+0x10/0x10
[   23.771785]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   23.772130]  ? iov_iter_kvec+0x55/0x1f0
[   23.772382]  __kernel_write+0xe4/0x130
[   23.772638]  ? __pfx___kernel_write+0x10/0x10
[   23.772922]  ? __pfx_lock_acquire+0x10/0x10
[   23.773209]  ? __this_cpu_preempt_check+0x21/0x30
[   23.773522]  ? lock_is_held_type+0xf0/0x150
[   23.773806]  do_acct_process+0xd84/0x1580
[   23.774075]  ? __pfx_do_acct_process+0x10/0x10
[   23.774374]  ? __this_cpu_preempt_check+0x21/0x30
[   23.774688]  ? __pfx_lock_release+0x10/0x10
[   23.774966]  ? pin_kill+0x11e/0x980
[   23.775201]  acct_pin_kill+0x38/0x110
[   23.775452]  pin_kill+0x182/0x980
[   23.775676]  ? lock_acquire+0x1d9/0x530
[   23.775935]  ? __pfx_pin_kill+0x10/0x10
[   23.776187]  ? call_rcu+0x12/0x20
[   23.776420]  ? __pfx_autoremove_wake_function+0x10/0x10
[   23.776761]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
[   23.777079]  ? _find_next_bit+0x120/0x160
[   23.777343]  ? mnt_pin_kill+0x72/0x210
[   23.777603]  ? mnt_pin_kill+0x72/0x210
[   23.777851]  mnt_pin_kill+0x72/0x210
[   23.778095]  cleanup_mnt+0x343/0x400
[   23.778335]  __cleanup_mnt+0x1f/0x30
[   23.778572]  task_work_run+0x19d/0x2b0
[   23.778823]  ? __pfx_task_work_run+0x10/0x10
[   23.779096]  ? free_nsproxy+0x3b2/0x4e0
[   23.779349]  ? switch_task_namespaces+0xc8/0xe0
[   23.779656]  do_exit+0xaf5/0x2730
[   23.779880]  ? lock_release+0x417/0x7e0
[   23.780139]  ? __pfx_lock_release+0x10/0x10
[   23.780427]  ? __pfx_do_exit+0x10/0x10
[   23.780673]  ? __this_cpu_preempt_check+0x21/0x30
[   23.780982]  ? _raw_spin_unlock_irq+0x2c/0x60
[   23.781272]  ? lockdep_hardirqs_on+0x8a/0x110
[   23.781564]  ? _raw_spin_unlock_irq+0x2c/0x60
[   23.781841]  ? trace_hardirqs_on+0x26/0x120
[   23.782120]  do_group_exit+0xe5/0x2c0
[   23.782369]  __x64_sys_exit_group+0x4d/0x60
[   23.782655]  do_syscall_64+0x3c/0x90
[   23.782899]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   23.783225] RIP: 0033:0x7fec33f18a4d
[   23.783460] Code: Unable to access opcode bytes at 0x7fec33f18a23.
[   23.783838] RSP: 002b:00007fffdd22ee98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   23.784312] RAX: ffffffffffffffda RBX: 00007fec33ff69e0 RCX: 00007fec33f18a4d
[   23.784763] RDX: 00000000000000e7 RSI: fffffffffffffeb0 RDI: 0000000000000001
[   23.785209] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000020
[   23.785663] R10: 00007fffdd22ed40 R11: 0000000000000246 R12: 00007fec33ff69e0
[   23.786108] R13: 00007fec33ffbf00 R14: 0000000000000001 R15: 00007fec33ffbee8
[   23.786560]  </TASK>
[   23.786707] Modules linked in:
[   23.786910] ---[ end trace 0000000000000000 ]---
[   23.787204] RIP: 0010:__lock_acquire+0xe83/0x5e10
[   23.787517] Code: 00 00 3b 05 df 65 fc 08 0f 87 c8 08 00 00 41 bf 01 00 00 00 e9 84 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 da 48 c1 ea 0f
[   23.788664] RSP: 0018:ff1100001446f060 EFLAGS: 00010006
[   23.788992] RAX: dffffc0000000000 RBX: 1fe220000288de1f RCX: 0000000000000002
[   23.789444] RDX: 000000000000000a RSI: 0000000000000000 RDI: 0000000000000001
[   23.789890] RBP: ff1100001446f180 R08: 0000000000000001 R09: 0000000000000001
[   23.790336] R10: fffffbfff0e70d4c R11: 0000000000000050 R12: 0000000000000001
[   23.790788] R13: ff1100001a9f0000 R14: 0000000000000000 R15: 0000000000000002
[   23.791233] FS:  0000000000000000(0000) GS:ff1100006c200000(0000) knlGS:0000000000000000
[   23.791728] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.792093] CR2: 00007fec33ffca50 CR3: 000000000667e003 CR4: 0000000000771ef0
[   23.792538] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   23.792970] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   23.793423] PKRU: 55555554
[   23.793608] note: repro[719] exited with irqs disabled
[   23.793983] Fixing recursive fault but reboot is needed!
[   23.794322] BUG: using smp_processor_id() in preemptible [00000000] code: repro/719
[   23.794823] caller is debug_smp_processor_id+0x20/0x30
[   23.795151] CPU: 0 PID: 719 Comm: repro Tainted: G      D            6.4.0-rc2-1e8c813b083c+ #1
[   23.795692] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   23.796391] Call Trace:
[   23.796557]  <TASK>
[   23.796695]  dump_stack_lvl+0xe1/0x110
[   23.796943]  dump_stack+0x19/0x20
[   23.797164]  check_preemption_disabled+0x16a/0x180
[   23.797484]  debug_smp_processor_id+0x20/0x30
[   23.797771]  __schedule+0x9a/0x3010
[   23.797998]  ? debug_smp_processor_id+0x20/0x30
[   23.798293]  ? rcu_is_watching+0x19/0xc0
[   23.798558]  ? __pfx___schedule+0x10/0x10
[   23.798820]  ? __pfx_lock_release+0x10/0x10
[   23.799092]  ? _raw_spin_unlock_irqrestore+0x35/0x70
[   23.799404]  ? do_task_dead+0xa6/0x110
[   23.799655]  ? debug_smp_processor_id+0x20/0x30
[   23.799954]  ? rcu_is_watching+0x19/0xc0
[   23.800215]  ? _raw_spin_unlock_irqrestore+0x35/0x70
[   23.800537]  ? trace_hardirqs_on+0x26/0x120
[   23.800810]  do_task_dead+0xde/0x110
[   23.801046]  make_task_dead+0x37f/0x3c0
[   23.801304]  ? __x64_sys_exit_group+0x4d/0x60
[   23.801595]  rewind_stack_and_make_dead+0x17/0x20
[   23.801903] RIP: 0033:0x7fec33f18a4d
[   23.802140] Code: Unable to access opcode bytes at 0x7fec33f18a23.
[   23.802535] RSP: 002b:00007fffdd22ee98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   23.803013] RAX: ffffffffffffffda RBX: 00007fec33ff69e0 RCX: 00007fec33f18a4d
[   23.803458] RDX: 00000000000000e7 RSI: fffffffffffffeb0 RDI: 0000000000000001
[   23.803908] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000020
[   23.804354] R10: 00007fffdd22ed40 R11: 0000000000000246 R12: 00007fec33ff69e0
[   23.804803] R13: 00007fec33ffbf00 R14: 0000000000000001 R15: 00007fec33ffbee8
[   23.805258]  </TASK>
[   23.805421] BUG: scheduling while atomic: repro/719/0x00000000
[   23.805801] INFO: lockdep is turned off.
[   23.806050] Modules linked in:
[   23.806249] Preemption disabled at:
[   23.806252] [<ffffffff813123e7>] do_task_dead+0x27/0x110
[   23.806829] CPU: 0 PID: 719 Comm: repro Tainted: G      D            6.4.0-rc2-1e8c813b083c+ #1
[   23.807382] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   23.808097] Call Trace:
[   23.808260]  <TASK>
[   23.808403]  dump_stack_lvl+0xe1/0x110
[   23.808656]  ? do_task_dead+0x27/0x110
[   23.808898]  dump_stack+0x19/0x20
[   23.809120]  __schedule_bug+0x13f/0x190
[   23.809379]  __schedule+0x221f/0x3010
[   23.809630]  ? rcu_is_watching+0x19/0xc0
[   23.809887]  ? __pfx___schedule+0x10/0x10
[   23.810142]  ? __pfx_lock_release+0x10/0x10
[   23.810419]  ? _raw_spin_unlock_irqrestore+0x35/0x70
[   23.810751]  ? do_task_dead+0xa6/0x110
[   23.810994]  ? debug_smp_processor_id+0x20/0x30
[   23.811289]  ? rcu_is_watching+0x19/0xc0
[   23.811553]  ? _raw_spin_unlock_irqrestore+0x35/0x70
[   23.811873]  ? trace_hardirqs_on+0x26/0x120
[   23.812148]  do_task_dead+0xde/0x110
[   23.812389]  make_task_dead+0x37f/0x3c0
[   23.812651]  ? __x64_sys_exit_group+0x4d/0x60
[   23.812938]  rewind_stack_and_make_dead+0x17/0x20
[   23.813246] RIP: 0033:0x7fec33f18a4d
[   23.813486] Code: Unable to access opcode bytes at 0x7fec33f18a23.
[   23.813872] RSP: 002b:00007fffdd22ee98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   23.814347] RAX: ffffffffffffffda RBX: 00007fec33ff69e0 RCX: 00007fec33f18a4d
[   23.814794] RDX: 00000000000000e7 RSI: fffffffffffffeb0 RDI: 0000000000000001
[   23.815231] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000020
[   23.815680] R10: 00007fffdd22ed40 R11: 0000000000000246 R12: 00007fec33ff69e0
[   23.816126] R13: 00007fec33ffbf00 R14: 0000000000000001 R15: 00007fec33ffbee8
[   23.816580]  </TASK>
[   23.816734] ------------[ cut here ]------------
"

I hope it's helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

