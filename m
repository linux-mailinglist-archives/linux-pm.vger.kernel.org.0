Return-Path: <linux-pm+bounces-17512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025579C78DA
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 17:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63F4284CAA
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9F11632F3;
	Wed, 13 Nov 2024 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFWaX6B6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF92309AC;
	Wed, 13 Nov 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515254; cv=fail; b=qE0Tbes52jIpeFm0fAug5f8NWmEaP4hx4UToimw1s1ywaSdjhByMYQYaebhrHYFZ74gXYlJVp+8WUOv/Qz/fWcBkH6yzWud/LBXsVFiOEYeH9bUf+VCwqYyLpb3NW78pU0ev8ysDZ683gNaqZOf1ywOJPWz0hgl2P9mWHHhjOXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515254; c=relaxed/simple;
	bh=UenSLQCxDZwzALxJKTSzSXyCWXRbxcQHvKioTh2Wono=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fIqjZbMjsPwnjHyWHw60ikCMOdw6chwc5qqkCaYY0fSYwX08j8x8qXhIkXjnAdJtDXItOys6RMtaGCO1oFCjeR7aL9cu/+S9LyJGEVQBPtRICQuysch3qTe8FkeRMrKlKJrRqhoAlSlxLe0jQeW2uE62ea7M0HgRhWlx8xkrtFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFWaX6B6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731515253; x=1763051253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UenSLQCxDZwzALxJKTSzSXyCWXRbxcQHvKioTh2Wono=;
  b=aFWaX6B6+lLTSzTw6wqkYpgA0dkJuuID/w0HSGhgAcDGspRaGH/YqG/V
   kmm9DbnbfGqyl94RdUNFmNggpA1OeXJcUHSJ+7ictlzgLMj0VOT7Hm5Hp
   QjaAPVtS7NLYXEAuhoQ3ZdV4ixt75QoCAY5OfT6qrIK3sSvA0nMJUjplh
   xPGhPoHXE6zx7aV81NHroz5M/eiywTmd7xnVlqf34/TXNhuDb62HzGJ1c
   nwhNlU993LOvwr8qmNzq+vpA1GFzgDgZJLGWvcHGx499xSuQWeXJMmC9V
   agZsaG8P6tCcf2j80sxeCEzyoAMcHcQ9rOGA0fUb+dpBb0uukg6eF8qRg
   A==;
X-CSE-ConnectionGUID: 1lo/R0aVRZeFNjS8uHPP1g==
X-CSE-MsgGUID: Jf8OBltZTPuVyEwk5DcKpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="30806136"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="30806136"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 08:27:32 -0800
X-CSE-ConnectionGUID: XDM4BiXrQaufwLWVUKZiGw==
X-CSE-MsgGUID: 2PEgxn0OSPiB1wqnF0Tsbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="88345034"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 08:27:31 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 08:27:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 08:27:31 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 08:27:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPdjOZ5Q1jTRxq7iMbDRJFPYJ5BIiPq79Fp9rDxy+AX/+VQYrVKVpvx7LAtse5PyoUtPdD2byIr5q1dH1fe/6C/Lj54G8YW5Y6HdYmfU/HDbCzyQDIHM6xapSEIrV+jzlMQm5EL3roIhQ5wUAZf7VprwO9D6zG76Wd0eHW7rGf80m04Cg9TE27ZErligfWQKtyZ+LYeFUkBhPDANzx6VTVVQ8k/UW44zsfBOyM8LslavGIiliLX69i/LYZBi5w8cA0xeD5emr6LPZt+pdH5589l2XBmuszt4mbus1EPKiJ3gTn1ob0r5cUgTyuwPgLTMtOE9nDDWtotyAclSZmYTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpYUvndklHbYqE85oGvMDdgyxn/67PYI0Ar1/NE7UyQ=;
 b=HyG5xij2VTaYJnwznCTaL8TbkOEjRoJ4utxZWcckjeYN1EMZACW3lco5/i9JjH1Y1u0PcbvjknANC78cmCC5M9lH01SQ0t24TvLKPZRcBRzTiZij477GRScU0dd+pRJTIJNrtOlYcvDDFJV1JPcPbFpBBzx677awt543U6OU1nOE4zy4KhsnXR/ES7OkUShhvmyCQ/gPCDJOFNfJ85qmVTN+Xyxqkl9GXcIRIN7MULEL+KFPwGEHVU6Q8HJje4bi9aHU8TMOP2wRIx5HvQlDn5/rOgRaiNnCWNwooi4zJb7N9gYi1cX9ARMRR3wmn0zeJO3Gvie/QOz0ILJGQTOyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 16:27:26 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 16:27:26 +0000
Message-ID: <9152f296-3f81-438d-8dc8-3c0bc60ea4b6@intel.com>
Date: Wed, 13 Nov 2024 17:27:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Peter Zijlstra <peterz@infradead.org>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn
	<patryk.wlazlyn@linux.intel.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<len.brown@intel.com>, <artem.bityutskiy@linux.intel.com>,
	<dave.hansen@linux.intel.com>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <20241113162222.GA24625@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20241113162222.GA24625@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b13225-9d05-4503-5b58-08dd04000f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0ZlVDhVU0FTcktEVnFZQkx5bXRLVU9FNjUybkE1UVNDT2pBRkYxMkdQd2to?=
 =?utf-8?B?RUx1UDVzUWpXS25uQ2VGU0dZYmVUWmRhNTNZNFdybWpzOEppTUhFdkpBb1JV?=
 =?utf-8?B?VUgydFUzbW1VWnJQVjBrWVo0MFhxcXZ6STZZbVd3cVVlT0Z3R054U1Jqc096?=
 =?utf-8?B?RTNJY1o5aDdQUUExZTNPWElGMFgzOUtFaUpURS9zNWN1RTY0MktiQ1BLREZH?=
 =?utf-8?B?b0dVVGhEY3M3ZlNvM1gxbHEyZitWWEgxZDN1WGFPZ1VuNjcxamtHa2hOME53?=
 =?utf-8?B?WFdiNStGbytla0s1ODNwSTJPRGc5RWkyY0x3RUR5cjZZd2x1aHJVV3FKdDFu?=
 =?utf-8?B?bFVkZ3pDYzhkWnNTcE4xSm5iWGNxZHFOQ1VHL3ZFQkRsYXEvMExySklZZDh1?=
 =?utf-8?B?c0ltd1BabitvTExWSEYrdjY4L2RmakNSb3g4OGxaRTRSa0FraEhvd1BNNzJ4?=
 =?utf-8?B?RHFiTFJGWC9Zb0JmK0x6Qjc2bGtsa3FZYjRLRTBPT2VYRUp3cmJSUmtya05n?=
 =?utf-8?B?Rlplci92U1ozSU9QRC95a0crV0NSVUhqYzVKOXJpYzA2WmV2aXdIMWZ2M0ZB?=
 =?utf-8?B?S05Ob1VrNXhxenJVTnlWTVNtK3F3SURvRzhXcGpBVjRXZkszd1R4QkpQZU10?=
 =?utf-8?B?eit3NzZabDZnNG00TFIxNHhhMFFVaXFRalhHQ005cy9sRk5sajdnaVZFQWxW?=
 =?utf-8?B?RjZHK29iS2MvTVJYcjFKTHRMSUdlcWwyOFNKaTNBcU1oR2Rkb2tUTndIeUpT?=
 =?utf-8?B?UTdCUDM4U3dnS2lGWGgyU2tIWE9iWHIybnhYUWo1bzlWMjlBNWZBeHVTVE5L?=
 =?utf-8?B?Y0greDF1YWdxcHlLV2E2QW04d0w1bk1sa25rWnhKTGpjNzN3T0pDb2VlOGpN?=
 =?utf-8?B?K2tIUGQ3RXFoZnNRaFhYS053anRCVjZjbDlIMEw4RXcraFRKWjRsQWRkY1Nh?=
 =?utf-8?B?TFk1WmRMY3hJcE9iM290N1J4REF5dW5vbFVkMWUxR3RxMVhabUFBT1oyb3U2?=
 =?utf-8?B?Ky9lbEdJemcwaFNUTWpCNkxmMlplVFMyajNCaU5BbVlid3JqVjBPbGdiQmlj?=
 =?utf-8?B?blgyV0h5MXIyT0lPOWZocUtoenBQaUcyOFFiTTU3ditTTVYyNzBIcmc0RGtL?=
 =?utf-8?B?dzNvV1hud2VlU1FMWVpLdlBzRG43S01wdVJTVnpuWDBOM0h1Nk90ZDFjN01p?=
 =?utf-8?B?YTlMWUR5T2hJcWp2WnlEb1ZJODZYbHM1VXQ1RVY4YmQwNEJNb2JSSUsyZWU0?=
 =?utf-8?B?U3dZVXVpU0U4bUx2SHBzUWxDaENYNTRSNXBMSm9IT2poanJteE5tOVhscVJU?=
 =?utf-8?B?M0NzanJvNXEySzFvVTRqL0tYM2E5SERoclBxUC8zdXQrSnFEV3VqeUdkbVRB?=
 =?utf-8?B?aWFMbkE3d1QwUDZEOEw4VnpWcE1sbkxGcWpwV1hTN0M0NXRyWnpuemNiU3lk?=
 =?utf-8?B?R0tTd2tZbEpWeXRtaWtuU29oa0JOc1ZMZWk2L1ZzMFhIdEVQTjlxYWhxUVlQ?=
 =?utf-8?B?SVJDQXg3SzhuTlpsb2dpL2sxa1JSaDloSVIwMkNaQS95d3R0NSsrZW1UVjJl?=
 =?utf-8?B?bHQ4YnA2VTAzR1BEc1FEOFlsWHlVNVAyaVp3U2k5VHhEUnZUVHF4K0FkcVQr?=
 =?utf-8?B?cDh6eDQwVEJHWXNaeUxZeWx2OXhBbFZxd0xUZEFodFFpM2lFYnpZMVQ5Wm5i?=
 =?utf-8?B?Y1FISjNtNGZ5SkxPdzlXREhXSnM5L2cvYytaUXV5dzh1Z2E3a1FmMVFOQlRU?=
 =?utf-8?Q?073YOEo7niWwFyD3GAlnu8xsWosvMAZAl1cFhXM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFphMVlXSkRMN2FLMk5DejRVMzZ2SW1NMmp3c0NZdXVwMGxEY0lrR21lNmJK?=
 =?utf-8?B?K1I4N0M3OE9BUWYxN2E4UHNzb3puZ1ovNUNFeERJbDJJRUFYaFdWMlhla3Ry?=
 =?utf-8?B?WnpmdnU4eHl4SWtXMk96QnIyN2dseE0wcUV5M1JxV0tpemowc2ZuYkFzdGxj?=
 =?utf-8?B?clVxK21nSmN2cUpKc3R0YnJmcjR3U3ZPM2htSlhGdkhVUTdOSklTMDBTVkpq?=
 =?utf-8?B?L1duUHJyVFQ0dFUwdkxrbjlqZ2p1SmwzT1orNEFLZ2t4Qks4ZTZ6Y09wVnBn?=
 =?utf-8?B?RGxmZnNvMmEzT0xlUENIZzEwTmVOZHcwd3YwRmY1dkZ1S3oyV3F2YTFZUDA5?=
 =?utf-8?B?eE01dVFUOEJ1VXl3eGZyY3pQd0MxMVVUUVp5M0VocXBDN3NKREJQZlNHcHNu?=
 =?utf-8?B?dmhRWTNVWExYZUd2NEZNTFMwR2xWTTNYZDNvWEpBRGFzYzhBVmJDeG5naHdy?=
 =?utf-8?B?RENZeWVlVlZyT09QbS9qM2ZtaUNndVhrRkZZd3R5Nzh6SDZQbzJmY280N2NJ?=
 =?utf-8?B?Q1VDS1F0aWR6MkNYUHc3dXh2ODAyRmlBejhsaGtuQ1czSWtjNTl2MmN3MnNo?=
 =?utf-8?B?SW0ramFjZW1EdDlyNFhKOUdoMG1mN3pVMVRCQ0NEUVNVb3pEV053WmUzQ3Nl?=
 =?utf-8?B?aitWdjQ1RlZpcS83bmZtekpkMmpCWm9jUkNZbm9KZ3RYYXJ4aS9OcTRleHE3?=
 =?utf-8?B?MVZKdkZnYjRaTFo4WHJnaVpOTGgvdWkwNmk4amU5aUhSS0ZnVFV3VDJ3YkUr?=
 =?utf-8?B?L21tbU1HeUk1VW9jQUJZWDBSSElvZVNkSFFQRXFaWnNzOGo5MHBxOW1oNWYr?=
 =?utf-8?B?SkdtTTNKeTJISFBtNEtKK3FkTmlOQk5oYXBQMHg3MGlNZDNrOXVOZzdCNyta?=
 =?utf-8?B?Wmh4Uk9mbEh5STRNSEFlRUs1VzF6aXhma3VFWFNEaHV5bEsyVk5VLzdwc2o1?=
 =?utf-8?B?ejRrdURoYkpkUEllQ0NRK3F6dTA4R0gwOHRHK2F0SFNOSnFSZVdydERxbkV1?=
 =?utf-8?B?MEJlcC9BRmM5cEZZcnkwc29STkNNaFJFVXZwSEN0RDUvcEJPMzlPQVNQSkV4?=
 =?utf-8?B?WEN2eHIwV3VCdkFvWWdiWm5ETElPVldzbVN2QUw3UWxib3I3aTg5bktLNEVm?=
 =?utf-8?B?UnJaTElQd1Z3enk5Q05vNXBHQjgxbmllM3lRaUQyRlBZZFVuVHpqS3VOVW5O?=
 =?utf-8?B?LzNYWWFtaGZWZ0lxOXVCRXFlL2ZYL1gva3AzSTdRbFN3cndJYU1iUXVxb1ZL?=
 =?utf-8?B?YkdRbzlsQmdWdFhta0xGQStaOGh2ODRHVSt0ZGhZWVVuSXp6cVh3RmRnd0Zz?=
 =?utf-8?B?ZlgrTWxsVU9IL1EzMzhaR2ZDMlRHc3FoTU04THhzQWNHa3dMUlo5V3dOTnc4?=
 =?utf-8?B?djErSHk1dEx1bUdUbmdaVm1pYkQ5T3cvaFVXY3FNdnlGdUpMdDRSbktFWXhO?=
 =?utf-8?B?RjhRbzVReGIzSHBTOTFzeFAzRzI3VHN3Vkl4NnNzdXIrVzI5RnliTXhuSzFB?=
 =?utf-8?B?aERCcHhodUt1NzNPMXFUL2l2TS9vb0poMkJOb0dIUGFONTh4Z2loL0RJOTll?=
 =?utf-8?B?ZFlPYkRvVHEzbDQwaWdLanhNSHBndGhtMW5pS1N4ODF0QkI0OWpDYWxtZzUw?=
 =?utf-8?B?cWZyL2p1ZGQwZXR0dFM3UXd6QVdPanc3Sm1raFFFREFsL1I2bzdSZDlzTTlN?=
 =?utf-8?B?QzJyUHhpQklTc1BmV0FyVHJyNW04RXpWekYzY3NqWW5HVkFGdWNYMWY4aXhw?=
 =?utf-8?B?eFRhbTR2RXZpdGxXc3BBQzMwYWt3eENrK0FpTHZIaHhVSjkwem1pN3EzeWhW?=
 =?utf-8?B?MEl0aUtZUFh4b1NvbEVLOUxHKzJyaTg0UUZHUHdVWGdWNlY5d0N1dkR4MUZr?=
 =?utf-8?B?M3VwR0NmYzVuZUZVOUFiNmRhQzE1WHROSlZrN2dDRlBSdUxtd3MxS2NHeXRF?=
 =?utf-8?B?MjBLT2RIQ1Z1T2c5bHQ0UlJzK2J3N2UrZ0JVRGpPbnRVcTNxd3pqb1lsS2ZS?=
 =?utf-8?B?Tk16anM0cG1Lam55UEZYVlM0NTNtcVB5ZFlmSHRPVjNmUzA2TENrV3p0aFBL?=
 =?utf-8?B?Y2c1ejNtK2U5RldkSTlLYXhkOFZ4NGh1clZOd0RkNktFMlJucVBudnIwLzB5?=
 =?utf-8?B?NTRvR1k1bk1yUXFFZE8xbU16M1hmZGZTd0xwVXNBYVZaQ000VEN0UURybkNh?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b13225-9d05-4503-5b58-08dd04000f48
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:27:26.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbWJFzn74MVraPterinQTSYw+3D5nRj+768GYCbqmXptaSOCh4sprcYQlRW79MrSmKEY3ywZLO4UplrRUxN5D4RTfjyfmxfU+SrQQE5/kxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com


On 11/13/2024 5:22 PM, Peter Zijlstra wrote:
> On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:
>
>> How about something like this (completely untested)
>>
>> ---------------------x8----------------------------------------------------
>>
>> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
>> index f3ffd0a3a012..bd611771fa6c 100644
>> --- a/arch/x86/kernel/acpi/cstate.c
>> +++ b/arch/x86/kernel/acpi/cstate.c
>> @@ -215,6 +215,24 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
>>   
>> +static int acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
>> +{
>> +       unsigned int cpu = smp_processor_id();
>> +       struct cstate_entry *percpu_entry;
>> +
>> +       /*
>> +        * This is ugly. But AMD processors don't prefer MWAIT based
>> +        * C-states when processors are offlined.
>> +        */
>> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> +           boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +               return -ENODEV;
> Are there AMD systems with FFh idle states at all?

I don't know.


> Also, I don't think this works right, the loop in cpuidle_play_dead()
> will terminate on this, and not try a shallower state which might have
> IO/HLT on.

I think you are right.


>> +
>> +       percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
>> +       return mwait_play_dead_with_hints(percpu_entry->states[cx->index].eax);
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_processor_ffh_play_dead);

