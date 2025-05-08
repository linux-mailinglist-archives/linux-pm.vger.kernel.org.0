Return-Path: <linux-pm+bounces-26861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF314AAF14A
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 04:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6AEA7AAD8D
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 02:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57451DFE12;
	Thu,  8 May 2025 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOyFSRyU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6131B0402;
	Thu,  8 May 2025 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746672757; cv=fail; b=ovV2A2x4oGcuPCmWETb3XKHAOdtrtwUXeDY7sxJJ1bwLLw7FwXUW5XdiBNtJwN/g4qASrAO054i9pGwQ3nB0kthagYH3hWPmUSMqC39O/5ee3PLfPa6bMk3WseYlKAEvAawAClCBy8IY/cFu2APUPDg4i236wmM9uPs3OEvGBDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746672757; c=relaxed/simple;
	bh=bl4cNiFbcLPepJapmO2Iq5ZIAZRGRU6aYxivP9DKAbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDQ0sdu/CZ23iaEI6RTSUz4LUyfjI4H9yj4dWluJwXOPr7/5XH41v/nOD+N69oCKwqTmWz0wif2bBYx0D8mhMq/a4IcEIdl8WmtbDSU+/HhdnBDg5TP8tFyOJnoqb93kL7fYX/rE2AhIIjq11Nd4k6+mtk7WETWnPIHXzdy6tJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOyFSRyU; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746672757; x=1778208757;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bl4cNiFbcLPepJapmO2Iq5ZIAZRGRU6aYxivP9DKAbM=;
  b=BOyFSRyUVEiHDSCqkxHt76ydmYsDAbpHNurP/09QEMBWsY7v6c9tprRr
   Z0Wx797q8OR00pv7igLVMROoAq/WXxbJqA/Uz0DcvgTcV6kZ80sN1oH0f
   Zu1mqIf0jF8rYldfE5dXYqAZXBfbhiQbeiGknQMN3bER2CvtAYmji349M
   bEH+bU8DtCYLG8IIycBYuyI1gDY1IwN4xOqnHcQqxpbWzVOwxCSEon2wf
   YOZGIoNbaKUK2Wt7jjv011tw4VwSgGCjBZ5dHyz21SQ8p3ymI2RzDk3DG
   qiiu8pb9PqUdP/oEj76NXUgU+KAKhO6ZBLEzQKX04uYMyWEYRiFsaZCVz
   A==;
X-CSE-ConnectionGUID: 43VCVhArQLuWr1YzQMp2eg==
X-CSE-MsgGUID: 7aFS6F8TT2Gyt2a0swxxww==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="70938588"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="70938588"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:52:35 -0700
X-CSE-ConnectionGUID: rAze10LtThKGNssoMIKIdA==
X-CSE-MsgGUID: rn7mhZpDTdehkXvCsSueaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136169064"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 19:52:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 19:52:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 19:52:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 19:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUMYbUqrVkYeAaw5Sko1KjWPW2YKtT64FaZ1rJmqzHBS/Mes4QBUUIYj49fgwUYl5tb6lJpqhGRIQgvoPeFlb5AbGoXf2IkpHh5IhSe0LVmkFI+Uojr1SbRPfDdui2R8KMVyff04eImuKWmQ+WWeszfcALbPbQ9WUEIbgz3ReBmQ6IOw/lDgo2Pcs7qQfkkJuOu0s1N3nK5Em8tT4RLlnpG5O25nT7i0hqZSl09MEhXFFklfcsWrs4zly2lTmhrMkoex8vT6irAI40KOVEmj0McWOElO5jwnKL9hyX4hhKeOEbAlTulHCodDv+Ohmjd8uKwQxZXy1wKBEh03Co2BUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vdRP02b1+Uqnb+mOtMkcetJgbC8i9qGPejHXN+CX+8=;
 b=yfrhyvpB+0+JCEGxDQ9DGegsb7m4b6Q1SQMmB25QdtDS7Dd0ESi/n1K6C9IXheeRyrPPDWFfWtEE9+yItkce38Qxk2gFSvq6ebqYvNruLTojtM5MYSmAdxNFcHoSP0UiPkkly+Lbv6ozX6Mt7V6NZfatCrEEdB7xPvtvp8UNI9uyPqQTIRCk5ZCmxwINDZtYvQ3U8bwBTCakJgqkXDpLCFATi/gOEfNTSRzQWTTy3ZSf7NYs9sTzAyhyczB+xy0V8cSPJqmFjxMkfeVgh5ApSgZQ4TR7Pd1PINNkA9CU4TcGV3If4WUQ2vwXXR4/do2Lj0JBN8PdYw85pLc+4l048g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by DM3PPF96964A2A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 02:52:27 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%6]) with mapi id 15.20.8699.012; Thu, 8 May 2025
 02:52:27 +0000
Date: Thu, 8 May 2025 10:52:11 +0800
From: Philip Li <philip.li@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, kbuild test robot
	<lkp@intel.com>, Andrew Ballance <andrewjballance@gmail.com>,
	<a.hindborg@kernel.org>, <alex.bennee@linaro.org>, <alex.gaynor@gmail.com>,
	<aliceryhl@google.com>, <anisse@astier.eu>, <benno.lossin@proton.me>,
	<bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <bqe@google.com>,
	<dakr@kernel.org>, <dakr@redhat.com>, <daniel.almeida@collabora.com>,
	<gary@garyguo.net>, <joakim.bech@linaro.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux@armlinux.org.uk>, <linux@rasmusvillemoes.dk>,
	<manos.pitsidianakis@linaro.org>, <mturquette@baylibre.com>, <nm@ti.com>,
	<ojeda@kernel.org>, <peterz@infradead.org>, <rafael@kernel.org>,
	<robh@kernel.org>, <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>,
	<tglx@linutronix.de>, <tmgross@umich.edu>, <vincent.guittot@linaro.org>,
	<vireshk@kernel.org>, <yury.norov@gmail.com>
Subject: Re: [PATCH V11 00/15] Rust abstractions for clk, cpumask, cpufreq,
 OPP
Message-ID: <aBwcWzc4zmPzAW5s@rli9-mobl>
References: <20250502070109.inpes2ou3rxx2fxp@vireshk-i7>
 <20250506101311.142475-1-andrewjballance@gmail.com>
 <CANiq72k3ozKkLMinTLQwvkyg9K=BeRxs1oYZSKhJHY-veEyZdg@mail.gmail.com>
 <CAKohponbEEP4_weUuKkOGLRj5-1oOsoL_Zu_7W_SxB61hjsSCw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKohponbEEP4_weUuKkOGLRj5-1oOsoL_Zu_7W_SxB61hjsSCw@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|DM3PPF96964A2A1:EE_
X-MS-Office365-Filtering-Correlation-Id: b524ab33-6dd7-45d7-bfb2-08dd8ddb5de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yzc4cUVicU85WExocXhiYTZOYjhuVkpsM3ovTEdGZUhMYWE3UWxZU3JGSXV3?=
 =?utf-8?B?VnNlZ2c5UjJPZW04N2dxNVhOYi9nUzZLVEZRNFFZc3lRb2gwaHBqNUpDenVP?=
 =?utf-8?B?OWkrV0FxRlJ3TUxEdFJUZXU1TjNJZnN2aFJHRUlXUklKcWRUNUtXYmVOT2px?=
 =?utf-8?B?M0cxVDJoWEhIZWNxWGtyNUNsU1I3MzhQaUlwbEtMV0o2VWJnbEJOSFc1a2tU?=
 =?utf-8?B?empSNXNXL2JPNEM4MzR5MDE0VWdEYmgyekpmc2lScHdrQWJET2dXRjlMOEsv?=
 =?utf-8?B?bERPcW1zYlpJa2xwVWdUZU11c1VIczhIcC9rbUMzNzNSeE9tSXBQdzNMa0ht?=
 =?utf-8?B?V1RtYWw3a0dOLy9tRjNtU1M4QWVTQzJjNUdhV3piQ1Q4U1V0NFRQRGZsNlVv?=
 =?utf-8?B?dW1yL0tkOXR1M3pNVVdOYVJlUzdjWVlQc2E0eWE2YVVqTndzU2NwK1FLdFUy?=
 =?utf-8?B?aGFBOUQ2RkNNa3FQRDNmOUJpY0czSVlaaHJPY09pemtkTENIQ3NPNGttS1E4?=
 =?utf-8?B?ekNYd3VTYmhobERTNm05Z0VOZEJubWdJKzFyWmhEa1N6QTNsSGJXZEJEWk45?=
 =?utf-8?B?RlNkY2VZQlYySEFNRnJicThYSFFYS0dPcklDeW1SM0pwK1k1Rm0xd0hkVGdX?=
 =?utf-8?B?S0E4UG9HbWtCUUVlOFBPRUc1S1JvTkN5OEpzaklXN1c2UHNpR3VzandDZCsv?=
 =?utf-8?B?TXo4K2NUMnYzcldCQ1lvKzlsaVA2OHdSUG01eXJGcXJJM3pOa2ZpcXp6NU1h?=
 =?utf-8?B?eUJ5YkV0K050amcyWlRDTVhIMlhhSG15bFJ0YkIyQ2xDb2RsRmdwQzBKdGZ5?=
 =?utf-8?B?SWd5RDJvbWhBTlZBaFBwN2hJZStoQlY5S05WUDZDR00vbnhadG1nVUdEbG1F?=
 =?utf-8?B?VjdwbGVCVkltc2Y0Q3RJV1BlRmlEZ1pjNHUzaEgrTVEvaGR2dmRkUGc3ZjF0?=
 =?utf-8?B?dEtXTHZiekJTcDBKQnpYbFdPMkZFcStwbEtRbXEzSkFUSmlveWNHdGt0Vkx0?=
 =?utf-8?B?a0d5NmNvN3pTVm1NMmFmWkJkakxPZjBBS3o0VEg3YXVQQ2Zock5ZekI1Z0dL?=
 =?utf-8?B?T2VtSVlpVjRHOG5WanhyRk9SZW12RW53SlFDcm5nZldjZDcyN3A5T2hOOHpp?=
 =?utf-8?B?dWlRaDFrWEZuMm5LS3pJNHlJTGF0WkhRbHU3bEJpcm52VXd2WGViUnZLWTdy?=
 =?utf-8?B?WXZDK3EyWU1SQW4zaDcxRmlCTVY0Ky9BWkF0SzQ1Ty93QlhuTmIzQkhyS0gy?=
 =?utf-8?B?UXZwZlJicDk4VEV2SUY5Y0pMUlZ3VTBqWWc5dXpYakt6cmI2UkhOMzJrT2dR?=
 =?utf-8?B?S1VQc2JuVjg1c00vUGl4UStqYW9SOVdwRXZiUVJZNitoQmloQzgxSjNlbFNV?=
 =?utf-8?B?OUoxQXIwTXR6WTJVdk1IYmY2RGV4L1JPb0o4czdJNU91NEdQQm5GV3dSSFR2?=
 =?utf-8?B?K3F4V2srMEp3NU5MVExXQlZNWXlKcUo4K1g5cGQ0My80NmdRTk9oOXRhRFdh?=
 =?utf-8?B?cUxXU2syZGtUbG95Vno4eGRpeFVGUXB4S3ZRaGpVT0hMUUR4MnlSRUJwUytP?=
 =?utf-8?B?UXpWOEJsR3hEay93VFVQeFlaR3htd3VIM3p3dS82aERnQ2RXOHU1ajJ4YzdX?=
 =?utf-8?B?d2VjL1JzR0lkN3phMEc0ZWM2NER5ZGxNU2ZUcFcya2tOL05Pak1JYTBZZHht?=
 =?utf-8?B?b0hpbWYxRUpXOHc4eVlZK3dhTnFSdncyaWl6dXIxQWpLRVdadllmdzZ5WWFn?=
 =?utf-8?B?eThMb1BPOGhZM1NUK1psT1FURGY1d041dXBidlVCcU5lMEM3RlFTWFdYVlBn?=
 =?utf-8?B?ek1tLzNuUTg3Z3FjMEJrcU5aT2VTOHZLWGhpTVI3ZGtiY0tBRTU3QXp0T2tq?=
 =?utf-8?B?bW94OTRHOEpZdW96a055ZmZaT2JFQ2pOTTg1cFdqdDJRelE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlVDYlZOVm93M1lqR0ZMTDJ4UTFhMEVsQ1F5Q1JTMXEwRWRzcEZuSW52VlRy?=
 =?utf-8?B?NVh5OHhOaXY0c1d1cGtncisrdk1BUDZ4bVRYcTVQV0R2V0Z1RnBoWENEbU1I?=
 =?utf-8?B?eG9wdWExRk9tNittc3N1Y2tyc01WZGgyeCsvWHVJSk9QVjFXTGpTbkU0UWla?=
 =?utf-8?B?bzJHOHJZQ0dqeGFSbmVnSFYybTVQeW52VSt5Mm9zNnNGSGdIZDAwL2NwRk5q?=
 =?utf-8?B?dnpOWlB0amtZMFVNbkREQmJUb2xOV1V1YUZzVEJpRjRlbC9jNXRwd01iVmMr?=
 =?utf-8?B?NEdqbWlEczN0djBuTitueWdBd3UwWW9IN1F5eEFkaUkrMytZQW8vM0tsRUNx?=
 =?utf-8?B?MlN5RUF1SDFGSGRsQUE3Q1F6UFY0RWwrYnM2bGNRWDJZRWZJTlp3VE1IQVQy?=
 =?utf-8?B?U1ozTlk1VkZCMjQ1LzNxcmxLZm43a2ZtY1JaWDVaWGkyNTZac3lkMUY2bERj?=
 =?utf-8?B?Rk5wUmt2ZmRIcmZxUUU1eEhtdS80dG8rY0hJZFRXVmlGT0hrOTc3THN2YXdq?=
 =?utf-8?B?UVpTdWxMOER1YThoUXlzejJtaXcxNjJwRzR6K0ovT2ZOVHBtMHY4dlA4Sk1q?=
 =?utf-8?B?VlJVRW9DdUVWekg3bmNmM0NvbUw4Z2hyaWVuYXUyZlNXem9uSFRRYVNXOFd0?=
 =?utf-8?B?VDNlM2JuWEw3WTRNaHpzaWxvVHo0M2VlT04rWjRIMHZvNkh6WVc1MEVLa3d5?=
 =?utf-8?B?YU5DcDNvZDF5UDQ0dlZWQWUrQjVRTmJNWThnRUFkb0ttY0xkV1F6eit5akYy?=
 =?utf-8?B?eDNwdDZOejQ0L1NNNE5JMkd5amk0cjh4TllobGZyV3lSN0V3QXBpcGw0VEpz?=
 =?utf-8?B?a3JiUHgxV2RGQmN6dDhZZkJrQ3lJeHdxQ1FuZkw0ZG0wSC8wcFdjNUV0MGhz?=
 =?utf-8?B?bjl3ZloyaGlXYUg2ZCs0TlY4RldMamVUZUFFMGVQME1qR2pWaElLTlAxZm5E?=
 =?utf-8?B?djBWRFRwNGZkQjdta1AyRUVYSG9RRHBGZmtCaXI0WWM4REVQU0JXQmRyWkdB?=
 =?utf-8?B?UHJvY05FSmlIbm81aGp3dnMyMWFxRGExb3o2SEpkMStINTNKU1RaMzJlbXd4?=
 =?utf-8?B?UlVzRVFIbldxSU9CNzlOL3FIMzcyWDM3V0RiTkhWUk1heDdpVGlqK0xGZjBB?=
 =?utf-8?B?L1BkbmR5cTVmVmdFZ1Q4c1YxQnRaVFN3dmh5VThGemUrMWp1cUNNVmkvb01M?=
 =?utf-8?B?bk9ZeFo5WVFOR3R5RVZXL0hZU1A0QWRmZ0YyZitrK1J6a1JLUitSZ1Q2bU42?=
 =?utf-8?B?ZjJia2JUNmpHazJyc0psNC8wRHVvcldMMndTOXl1Z2xTVWhYeXB3Qkg2dXIw?=
 =?utf-8?B?R21jd0VjRHMza255QjdoUnVzbGtFV25GYW5ITklxY2luZFY4cGR4dnFrMjds?=
 =?utf-8?B?WWVFNG9oSHJudk1STmVqbkVldGN2VW04WFd3dHdtZGIzL1BoeEw0ODAzcGEv?=
 =?utf-8?B?UHVxUEV2aXhjQnZ4UExmR1AyYnR5ajFIR2EwVHJSc01wdlRxRGhKSUtCa3Ns?=
 =?utf-8?B?OVlST3FnaDdDY3lCZEdPY1g2NUZpbnpmSXlvWWk2NzF5M3JZeG9CbEppL3pS?=
 =?utf-8?B?UFRlbjZkT3hIcHMwTjRDMVZVb24xMWkyeXFxY1Z0WUNyRWVqWjdrQXppTGNv?=
 =?utf-8?B?d1ZoVTJpUlZMb0pyVW44MlZSdWhJWml0M0ZYVUUydnJXK0xtcmpTOGpyNTJh?=
 =?utf-8?B?cVBZNVlnZC92MlRlb2RSZm9zcWxqenRKRW1LMTY2OHFmeHNsclY0eVpVVkRF?=
 =?utf-8?B?Y1Q5SnlOU2pqMnk4S3V3V1VmelpEUTlna3Fvcmp3ZmgzV3ZKNFhieTd4bXNj?=
 =?utf-8?B?SjkzOU14M3RzSElIUDZka09LMmd6aExKR202Sk5NN0ZDTExnS1ZlVEN1Umlt?=
 =?utf-8?B?YWlpMHh4MXVFTWQyWnR4QUk2dmNiQUtick1zWmxJQlJQb3NMdExWQVZraGlS?=
 =?utf-8?B?bDdrc1h3RFZnSE5GaU1Kd3l3ZnBGNTI2d3JmeU1EL1NPM2NrbklvVWZuSjVh?=
 =?utf-8?B?R2l5QkVrTUxGSjJ6eU1seTdlTEM4WkIxUkw1Y3JBUWk2TCtUWmViNjJsLys0?=
 =?utf-8?B?Z28wMi9uMHBydmw2Y2VOZWhjYmdTTDgzdFRPSUtHaFhsbUIzRFMwcGw4THhj?=
 =?utf-8?Q?YUVn0iMvADasbm5IULZ2fnvzc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b524ab33-6dd7-45d7-bfb2-08dd8ddb5de0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 02:52:27.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ubs0lIQUdlL3EsTlJveMXXZQZZD1a2b3gelBrRDf+O7h1m/LAtm1Rdavg919QOP2ykNTQdeO50usKsACjcaCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF96964A2A1
X-OriginatorOrg: intel.com

On Thu, May 08, 2025 at 07:40:26AM +0530, Viresh Kumar wrote:
> I am on holidays right now with limited access, there may be
> delay in my responses.
> 
> On Tue, 6 May 2025 at 15:55, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Tue, May 6, 2025 at 12:15 PM Andrew Ballance
> > <andrewjballance@gmail.com> wrote:
> > >
> > > I have tried building the latest linux-next and I think that this
> > > patch series causes a build error with the defconfig for x86_64.
> 
> Thanks for the report Andrew. I was expecting to get
> these from LKP (for my branch [1]) but I didn't. Even if
> my branch isn't getting tested for Rust currently (please
> enable that Philip), I should have received these for
> linux-next ? Philip ?

Sorry Viresh, there's coverage gap at the bot side. One is rust kconfig
is not set as mandatory early on. Also the bot met build test slowness
these days and is under recovering gradually. Thus I think the issue
is not detected in time.

We will resolve both issues asap to provide better test coverage.

Thanks


