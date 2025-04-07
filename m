Return-Path: <linux-pm+bounces-24882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4DA7E130
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EFB162ADF
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9891D63E6;
	Mon,  7 Apr 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmrS6An8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF501D63E3;
	Mon,  7 Apr 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035485; cv=fail; b=JaB0llp/Qd1Grihbbe+DNaXwiopSuMSVti+IW/4SBEN2ycfbrpWUjaPZDpny3uPb78Ei1qXLre9I+ozH58bJmSJy5rO3acy+nEoTt6rZHKATOT2WPJsEAzrw2BgAKp9X7cZFmNXbtfR5hUB6bwkXrIOnEfR2QG6zeRgE8AAUPSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035485; c=relaxed/simple;
	bh=677dJuwKgIQGiHDqBNvbl4ZaGHcrQItr9DTZOtn7Ys0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rMYuqSJWT8YOLgHE+v/e8NV2o/37utKzeO/KQR3BItGlaMDwQPcyaHX8aAiGmlTlBdNAvPSFIz5Q5kQWmzKfQUU0CA7Tme8cQW0KEBRFO0/FUltg6NayjYwGM9LmbLSjzI773QEpx1otToF8NpnaHi2URq2FNfhibfID2bAz0ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmrS6An8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744035483; x=1775571483;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=677dJuwKgIQGiHDqBNvbl4ZaGHcrQItr9DTZOtn7Ys0=;
  b=DmrS6An8igCB7e+Vf2k5AUVQ+7rHiJj7mwaO39jOXViCbqJgRruMZidc
   I5yssPOXJ0wv8uzWVmu3dehnQV6/E3tpEtcqx/A6GXWJdw0QC7aBqilir
   8kKKgVfb9Mm1G5jZWbAtR+X5vRGwY0dx0atHmyJOF+v5LB6qESLhDCySi
   ylrl1yk34o0RkoQlpHHzsNSSx8Y0MwotTXnnjI0v4qwH/DClcGKOL62Fi
   wFem7ff0IIOjWn8VFzaJKDktgKdkVBsNSGbJfYJCzsS35TvtDjiWcVpDW
   Wo/82fXGzWmweY2BKBkpfPPyhRxMwkjLV9CzKFn2gEc3MuBLxOkyGPHWO
   Q==;
X-CSE-ConnectionGUID: fTeuQSyIQoOL3SSldHFbZg==
X-CSE-MsgGUID: F6rzECe9RKCglCLGgjYONA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45516273"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45516273"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:18:02 -0700
X-CSE-ConnectionGUID: KrxeuBxYQpOj9CcdtOgbrA==
X-CSE-MsgGUID: GyaYjFmwTOWYfwIzHBMnOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128301870"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 07:18:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 7 Apr 2025 07:18:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 7 Apr 2025 07:18:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 07:18:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnbiydKh4zAqtu+QQV/aVcxuNizd4Q/70o+btSkRKl0LRgdUaaLZ6Ch4r0GlmDx1ahlqmszmQAjYy3qxLaCgn8cNheoZU1NoCHkqbPXF0xPxKH4Itg855gCahLmtl+xdy5N2R8B3m2RSBeLlaolGEEL7W+qduaH31BZ2jEO9kGajLfLPdZ7q9XouPi6fSn/XFWovLXPpKqeUz07baBhAXKnmjs2eSaD1ycgcgGu32t2R+cv8GsqAoCVqg4kQ/shFn9btHuW2RxT/EVVzpOFa4svodGg9mb4o1WQ9e2HrONcXLkH2m1FLnpy2R6Ahsn2umsK8fo0h14pXTIEdS7gD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjPQOH9g7drO161JsaARs5pOBcg/EK++xPVyYS6WRt4=;
 b=vGZRYR7gF6he8tZarZSIF2SNTdX+Iq2r4BxkxxgpI9IFfx5p5d7WGFxq0EXllwrXZOF+Z/CHf6U4yMsBfTEIn27hVLvc5gjsLlDaa2QoqUX8TX6H1FL7ZLxmlwDRlweEreiqrd6USSUsdx6YlsGKO+IH0KUf/qS1AozAihpO1IT+9n5MfE3H/I7iJBtV5UPQebxGv4zMEwzAp0ek8vpP5DaIDyjENOkRv+Y/9zEfsOsK74HDU8kyTPDoAlG4KWC59FFCfHzkykA1BOJyQKL04tEcJCLDXJDv8iwDa+tz+Dxm7PvtdvCCrKftYl+5xW8kRkedoPCYYXvhVac0i9bFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 14:17:18 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 14:17:18 +0000
Date: Mon, 7 Apr 2025 09:17:15 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Andrew Sayers <kernel.org@pileofstuff.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>, Todd E Brandt
	<todd.e.brandt@linux.intel.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: Use two lines for "Restarting..." / "done" messages
Message-ID: <2wuf3xlvzvnkddddblsnomulhjpst2vezimulwgtjlczl3pnvu@qf7ypuuuvylz>
References: <20250311130204.216345-1-kernel.org@pileofstuff.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250311130204.216345-1-kernel.org@pileofstuff.org>
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ee8173-d2e6-4819-9d5f-08dd75dee774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xykr5/y8TWY3TNkBQuur1V3t6XHtu+WdMBNobFgdNIGdCvfh7x/oCFUlhF/p?=
 =?us-ascii?Q?sTUDF9Ey03j5GVo4cUT4EBG1fc8P/smFAO6Pylx9NJjOjavcKqxksP+aPPOp?=
 =?us-ascii?Q?8vVEY6c37y2xLTt98nEdDpARBMbW6g8ymwnbfDsUZHicQTzuQlHqP/KhicqI?=
 =?us-ascii?Q?Y3LLVv0BtfZPwiSlcca8G+Qc/jTNP1qAy3i2uYvTrlRU08ZOBCBMVk85F51y?=
 =?us-ascii?Q?s+hpq1+QcZPFMR9Xde80G7GDornSR/kY9+nD037P+Q40oMDXnt8Oz9r8JYkB?=
 =?us-ascii?Q?B0duOjJvFaU1eaJWw9dCm4lB1PSRxEWNrnWaodc/qCaPJYqD1+Cey3TaAopi?=
 =?us-ascii?Q?xkraBZ6Wj3ULJcW7I7vGl7GOBHBYHcjN0UJh+ds4cwhMXo3P7S7esHk1EGBA?=
 =?us-ascii?Q?y57dDCK9Kmo0icZmfVziAXX33CITvqkDEAmEQRtfKFk0Nnc/jvawMogdePKI?=
 =?us-ascii?Q?ccv2pqQ5998miq4obW58UngaANotK+SwRbkpAq5FC1Bnpe/DHxGf7CSSc0qj?=
 =?us-ascii?Q?i9tiAKmuMxaJT63xLQSmVxKV/Njuock/faaPh06c+fxBdILDST6est2cSg7w?=
 =?us-ascii?Q?1tkQyCD+pRNeBJATgJOm7VNO5wcpWeui7ZiRupuDQB0ixIVaEcXnshjXYPjy?=
 =?us-ascii?Q?5jfw4nOZDT8DF+rMzZNbs3Mwv0HYVjEuZw4m9WR1kHRk3Z6RIXvB0LBqWr+6?=
 =?us-ascii?Q?AbjpgHiLUBAK3xdXlnvS7qiRxxVL+Q83PWRp19ZdaI/3Tx8o4DcZyrk75GDL?=
 =?us-ascii?Q?jxFvLNqe23AJHicQDda8WgoBnIi9RJqqq0C/7HUYA3vZzs5rZYGJ/zYBJUV0?=
 =?us-ascii?Q?gZa5LuTlAQ5H8ky0hAlFxEcr0TfElgqyIdOG2kVIcfsA+gqzezA/Y+g7lbCy?=
 =?us-ascii?Q?RC/b70x8sY42HZC5YlH7397nl7e7ynUYmP5OaZqFMQ+AjOEQ6NjbBbZHrsM4?=
 =?us-ascii?Q?9Pn9PdW8HxKp7ozhLARpC7kexQPOx7ALVrwN9BmOrg663Ah6UN7/FpnNPmyP?=
 =?us-ascii?Q?K1pndUqP8j+vy4tgV5FKJwONVgMN020owBNTIoqztlv7rQUX2JmNx5SsAgP6?=
 =?us-ascii?Q?ourzKyU0lI4OCkqjmN8uK2E0gg9LXSyslMzCis8fizG6jA/ZUgLvs7KXAD8u?=
 =?us-ascii?Q?okWbZXUnfJ3JNqkQKDPvP+MyaXVmkk4jyPXS3X6WAfowCK5fqmygQFEqFlI2?=
 =?us-ascii?Q?h5L+W/FlWm1aPAUum2jylFEQF4K8uG5nINV4xW9MWCiJdAoQ6lYns+s3uWpA?=
 =?us-ascii?Q?5wEumU+FHTFQUEL4PPhn3V3MkDHQG+MNbhXUGSB9+zjJssSoSdXS+6U3mQ1A?=
 =?us-ascii?Q?2Lz4PypKE4sLNVvcE6i5zevUAgjGLj6655e73Ubmbqg7S5FLXFQDCkpfDTkg?=
 =?us-ascii?Q?1Rn1ys9yoVbn0QU8N9wrAayLdHUr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vNaPEfiqYRg/Wf0pV96AjACyD5zvkgL8WmResvSpYFm8xYttzNvR+NqdF81n?=
 =?us-ascii?Q?bsnF4zbjyulkxos44fMAryQQgeXedIIDEEvRycH5HEW9MfbthR9aslRFoOQP?=
 =?us-ascii?Q?293Jw1IBvdOFtmCHnBjmEcmhq2jDfgDkdWgha+8cJUrX3nq2s8U+VJFtkIlF?=
 =?us-ascii?Q?98xfmrIeVdUUa83SNCeLOfwqQEK4jmwhRZdYXqFs7rafsY98PPlvjZDofITa?=
 =?us-ascii?Q?g7rP/hFtiWG1jsmJxiiqSgwpTgNwRvfBjvlXRHTWmOWQznWBKXQ4YlqrJb8K?=
 =?us-ascii?Q?wgb22pa8NsvTY2/zoM5cbqY2ihZcfLZwULVd3Hm76X+zYqbsnI8jXs6PvaDd?=
 =?us-ascii?Q?MUo1cECmNof0QUBuFfItgroWEkJrl51vFFz9mtU2ya1sRBThEa7XlDkLDe9A?=
 =?us-ascii?Q?HIYpBl9rVIvjtOE+geLuh4ZnRJzAguq0IHvz1H3gWoJet/CxMmWjjNajZCvD?=
 =?us-ascii?Q?vubJtrsZ+nOGugK2gONLB3WjH2HBj+DWXoyGiM9ihoIjp3KDwE9YidLAolu6?=
 =?us-ascii?Q?XbRo5umWlZdCQJuQrNqW9RYdGZ2mP6HI6yY72a9vqZmY4Vrxj13PyNC3IMjM?=
 =?us-ascii?Q?RFKwvso6pl+hfo065uRYVKFZ47n8bd+V/ZAtK3OVv/30eY9tKnDZlCMDd98E?=
 =?us-ascii?Q?4SulW924S8SjmV3w6g1u7OVmFvskc2OlbTwYqEN47ZkxHreXkt9TWA5u9VM5?=
 =?us-ascii?Q?zFOeg6EqVdU0IhqhIWrOAFstfm1cH7AcbOYOFYcvy+Wflkpee4Xmcfm8ir0l?=
 =?us-ascii?Q?kUaLB6DkX8qwwyqqzaHD+BH6OCqueIrij+yFR6m823+SqC2d5pfCs2TksMPn?=
 =?us-ascii?Q?ojFEo8TozZdbTaY1ZGQIhoK1imJq+Fhn2pZ5fQEFUdH8z6zkTBk8KxrNaIYQ?=
 =?us-ascii?Q?jU/ONf1zyiDuFk7aLAYww5Mx0Gx499gO/QlTraTj8tF2QTFundc3vo86sGqt?=
 =?us-ascii?Q?94wExk3+nVcnqWAMjQU+ajS/NUCHC0krEvvuNwWsCmLStmu/hGfU0iFaRWly?=
 =?us-ascii?Q?N3Aj99MWdxsmjd1I3KS9WqAP+OL8fxzR+BRlRtMmfbPJwxBi9nG924+3fYXz?=
 =?us-ascii?Q?EK+O0u2ZL+BSBZWnjHJnv0nj4R4Qvb3t3B9UKeV6pmKYcpfyNKw8WfTJ8vC9?=
 =?us-ascii?Q?Wr46Y9pZGw0wrmLlVFitcPkNX1wsf4Qa2EjHmibWrPSHjM2RGi2hs3nhrTDf?=
 =?us-ascii?Q?/9ommJdbLbRcFpBt0lgT8kVqHkfPS8gDslZ8aUBWSvcnB7LqF9yoqvD2T50O?=
 =?us-ascii?Q?hOCgsVZz0KfXRCDCPJWbbvOM411r1c0wRnwBSOQP3ahJ78B4JDHhVHeuweJo?=
 =?us-ascii?Q?oob4MhcVfl4/XnP1/yk1WdDsl0qo/4vXy3JP2SR+WY8v2uhaTqBd+C7IlS5N?=
 =?us-ascii?Q?2iDKR0V8RoEoDS2FKkch6yOAExKWyjjPrVjRbEgNQtQR3BaON9kj0X48e7vc?=
 =?us-ascii?Q?JOmw8pnww7BziP0lFwK54f+R5j9nVU6HLDxuPSfex/U2MaGkXkFTluq0aW8o?=
 =?us-ascii?Q?/s6yHzDeLFjj4uoqn8l8Not4I0yskfzEpa/x2algM29taF+tD1KuzkTAyW+p?=
 =?us-ascii?Q?xONiFXoJ+/xaBodngueGSVX4lxwC1gvIyAyUAThITdq3k0TitN/skNox9+gl?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ee8173-d2e6-4819-9d5f-08dd75dee774
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:17:18.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZ15MbHv+b+vLscUKYVlAZf19U3c1y8OLBnX0SMcoUISEgYSL1Jyy2+k2vYTXVwMZNPYsFEWJu0DaUwgob34FeSSTl27zSoDJckXEyzQMTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7312
X-OriginatorOrg: intel.com

On Tue, Mar 11, 2025 at 01:00:37PM +0000, Andrew Sayers wrote:
>Other messages are occasionally printed between these two, for example:
>
>    [203104.106534] Restarting tasks ...
>    [203104.106559] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
>    [203104.112354] done.
>
>This seems to be a timing issue, seen in two of the eleven
>hibernation exits in my current `dmesg` output.
>
>When printed on its own, the "done" message has the default log level.
>This makes the output of `dmesg --level=warn` quite misleading.
>
>Add enough context for the "done" messages to make sense on their own,
>and use the same log level for all messages.
>
>Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
>---
>
>I haven't been able to trigger "Restarting kernel threads" at all,
>so can only prove the above occurs for "Restarting tasks".
>But inspecting the code suggests it's possible, and it
>seems more elegant for both pairs to look the same.
>
> kernel/power/process.c             | 8 ++++----
> tools/power/pm-graph/sleepgraph.py | 3 ++-
> 2 files changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/power/process.c b/kernel/power/process.c
>index 66ac067d9ae6..4c674282df03 100644
>--- a/kernel/power/process.c
>+++ b/kernel/power/process.c
>@@ -189,7 +189,7 @@ void thaw_processes(void)
>
> 	oom_killer_enable();
>
>-	pr_info("Restarting tasks ... ");
>+	pr_info("Restarting tasks ...\n");
>
> 	__usermodehelper_set_disable_depth(UMH_FREEZING);
> 	thaw_workqueues();
>@@ -208,7 +208,7 @@ void thaw_processes(void)
> 	usermodehelper_enable();
>
> 	schedule();
>-	pr_cont("done.\n");
>+	pr_info("Done restarting tasks.\n");


This indeed shows up a occasional issue in our graphics CI farm. I
thought I had a patch handling that and while trying to find it I ended
finding this one. So I probably I never sent the patch :-/. This one would
work nicely for us.

Maybe also mention commit a449dfbfc089 ("PM: sleep: Avoid using
pr_cont() in the tasks freezing code") in the sommit message that did
something similar for freezing the tasks?

After applying this patch, the only user of pr_cont/KERN_CONT I see with
"done" are places that would not affect normal CI tests:

	$ git grep "pr.*(.*\"[Dd]one\."  | grep -i cont
	arch/openrisc/kernel/sync-timer.c:      pr_cont("done.\n");
	init/do_mounts_rd.c:    pr_cont("done.\n");

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

> 	trace_suspend_resume(TPS("thaw_processes"), 0, false);
> }
>
>@@ -217,7 +217,7 @@ void thaw_kernel_threads(void)
> 	struct task_struct *g, *p;
>
> 	pm_nosig_freezing = false;
>-	pr_info("Restarting kernel threads ... ");
>+	pr_info("Restarting kernel threads ...\n");
>
> 	thaw_workqueues();
>
>@@ -229,5 +229,5 @@ void thaw_kernel_threads(void)
> 	read_unlock(&tasklist_lock);
>
> 	schedule();
>-	pr_cont("done.\n");
>+	pr_info("Done restarting kernel threads.\n");
> }
>diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
>index 918eae58b0b4..b608c7b44b5d 100755
>--- a/tools/power/pm-graph/sleepgraph.py
>+++ b/tools/power/pm-graph/sleepgraph.py
>@@ -4017,7 +4017,8 @@ def parseKernelLog(data):
> 							'PM: early restore of devices complete after.*'],
> 		'resume_complete': ['PM: resume of devices complete after.*',
> 							'PM: restore of devices complete after.*'],
>-		    'post_resume': [r'.*Restarting tasks \.\.\..*'],
>+		    'post_resume': [r'.*Restarting tasks \.\.\..*',
>+							'Done restarting tasks.*'],
> 	}
>
> 	# action table (expected events that occur and show up in dmesg)
>-- 
>2.47.2
>

