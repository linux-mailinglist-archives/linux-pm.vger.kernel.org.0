Return-Path: <linux-pm+bounces-34032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC532B46591
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 23:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A62A033DB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927D22EFD86;
	Fri,  5 Sep 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNKDWQ72"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245827281E;
	Fri,  5 Sep 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107966; cv=fail; b=K4x8msvRtSgaoDVUHoj2N0vZWvg/4sQh+rwJrHt6emMOp+biO9OhaNueIVGRbYv7Y929txLY9yuI1B5tgmOeAUvedFWoQg3yymCW9cZvbVZvOawTXCDS0wV6EcjPjmq2SVRoc57szQ6JpZVKqjcGtlJXiENPu6vyJ8nbyEmBkJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107966; c=relaxed/simple;
	bh=EtaiGUdTy1kWAb4XHHVmB+2pcHQMiYSzbVbYNIyYzHI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7zYmVn7g/pQji3egy/umqW2pQNlosfZft/R1AIj/CQlSMXQP384VGKBJP3ejcnI71ySVnD+oz/h/3GKCjuiF80+4LAY2NU/QUsQQAqirrBO9kPC+MhvTuHlAa2SYHLSmq42yLg/rnTkxYNf3BWqBt8bDdtn1hzvghHL02Ct8Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNKDWQ72; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757107965; x=1788643965;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EtaiGUdTy1kWAb4XHHVmB+2pcHQMiYSzbVbYNIyYzHI=;
  b=QNKDWQ72+uy7GDdJCMDYeBFbKZbc1lpyrE5u0HTIo1Zn12jNvLIvogDj
   UsasaCeasl7GIT1ZbsCt9VHUvdR35IyW9Xp9KOpZy8LvcsT7Abnqhuivk
   oB4pLonb4dZPVAKZyvIzzbo+eqVgj+pfuXebbUiy1zx+MTv5EHdRVYWzh
   pWR1TImRRFPqkhLOtE7quV82yqtTXlC78DvecAsObyxv5zKHkdFk4AgHV
   1e9/EM2+TRkfxzC9b7ifIsK96t6ZXgeB70fg1LB3VJIBO2Emh/TlsmOBB
   FUh3mMqw5Yorwp72HbBLOxUNRy5QTVxh1YdmkEU+wbsU9BsQ7qoc8TjUu
   w==;
X-CSE-ConnectionGUID: l+1ZTlSqQfGQ+FyscbXy2Q==
X-CSE-MsgGUID: lUklWJWUSFSPq1cKpSnHeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70081679"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="70081679"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 14:32:44 -0700
X-CSE-ConnectionGUID: Fa4VslTNTxurDRncT/uF0A==
X-CSE-MsgGUID: Mq8DAcafRY2ByPsdd0DYug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="173063909"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 14:32:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 14:32:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 14:32:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 14:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuMhL4DEQ+KE3LqHy9mF1qIoYGA2pr/aeog6gQ9c0Pw3bnJI2FyYLjeu9/d7mutUfn7gGmHmvmLUegYqfVb0UMevSjKxRn0q7NTT1tNDBmiwYq4BRPtBO+zV0t4IPmijmtLZ4uD4BQHQXBOJcy9+ogLUaUIXavNXZ5tf7o2sbS/ULXDqDy2nofgO4+HXc2mPrEEzz+4gz/VDmHfEDv4smgHwBFK11M4o+dpI+Q7g9yLNtWDVqbUgBPmeK5Z2gi2Y9dkEiQdq+5y1swIcxPERbW8LZMGjRMe4Y5XPolagWgVvnIexybt5DEBhhDxoe87MRYQnpcoNpePnZ2L33sJfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqOOPO8RS5EZpuYCPAUrqNzzt0MCn7GvEK14lD4GMMw=;
 b=zPa7X5DC+W/NWBKjJITvtE7+HKilUyIEWsqjtcZysSUhE6WCpLeIVV30mxmZqkRxT1vNnJUHiJjoDS/LPRhqR0KGJSKxNLNeoOSyjL1SX0E9JFY9t4o3GyUdAvLXFA4tIguqEySD/7NjhuW1gHoH5r4o7npoFQIFFDkRpijOA+GYp2H+v5ggxmzGvMmh4TB/MX3xGliPdEh/TE1+Pq8XeRJff5KnOzmy/oPux4TxMCOeCNB1JnK8O7Eis05uEzw27npm2wDdUz93tJ6ookZxvW8YS7SM/qLzLMj9OgCBkPKz1aHKhpCiVERunHiichINxProE9TLRPI5hUCLCyiZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 21:32:40 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 21:32:40 +0000
Message-ID: <67ffd6b7-55c2-4ee0-9243-44bf8336152d@intel.com>
Date: Fri, 5 Sep 2025 14:32:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: ondemand: Update the efficient idle check for
 Intel extended Families
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<x86@kernel.org>, Tony Luck <tony.luck@intel.com>, Zhao Liu
	<zhao1.liu@linux.intel.com>, <linux-kernel@vger.kernel.org>
References: <20250826183644.220093-1-sohil.mehta@intel.com>
 <CAJZ5v0hw+797-mm3qA6PqQdA7hWyZKhkYobbvF+8MCvg1cHZvQ@mail.gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CAJZ5v0hw+797-mm3qA6PqQdA7hWyZKhkYobbvF+8MCvg1cHZvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CH3PR11MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9126e5-20d9-49d3-2b5a-08ddecc3bdab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWJ0SW5QZG9DUVRkQ0F3TlNBZ0FqWDJhTVRmeXhIN25sSGh4VEVPQlROTHQ4?=
 =?utf-8?B?VVVDdDM1UWN3UGFMTjMzaHBJUktleGhmVlFVUEUycWszcUkxMUpMQm5MR0V4?=
 =?utf-8?B?Tzdlc0ZDbUo4NlFpR1hQb3Fkb2Q3cmM0aEViZzMzaCtTN1dQek1Va2pVSmE4?=
 =?utf-8?B?VzQ5VlFxMmJpeVgvNVN3VUNTb0xXNTltQmVZdnU2T1FyT2xOakdpdGxNUUNG?=
 =?utf-8?B?OStyWU9RTE5ycFBqcGZNVjFtU0wwOWxyVGJuMGh6ODlJZGFjZWlKNVdBUUNN?=
 =?utf-8?B?ZUwvbUtsb0prc01pV1QxTzJmNFpzbDdiNDV2ZllLdWRUMUNFSlFDYTc4T0tz?=
 =?utf-8?B?Mmw5aEw5WWNGTnJGS1pycnZjamszU0tXS3doY2NXNVM1REJkU2Jack5sNHFP?=
 =?utf-8?B?YWhGeTEyVjBUbVYwMFhaTGJWOU9SZGpyTGVxUXpRM1hJNUtpRHArSmtJSk00?=
 =?utf-8?B?azRPTWVhM2pKWWxuVlVUaVdjT2FEMG5RcTBSYUtyWStnemE2MUJxWlZqZVY1?=
 =?utf-8?B?eUZ4OVluRmRpQk1YZG1IMDZ1N2lzZ01xbG1rNi96UHZXM3Q2dkFCc1IydkVZ?=
 =?utf-8?B?SjNyRSt5UlJ5a2hmMjhDMFpRdXJBVFB0MzhaRGlnL0o3WXlvbnVXWGExU0R3?=
 =?utf-8?B?M2NuSWFGdHFKbERESWZPT0VoZXFSTjBJZ29OUGNBdnVYclJpbHFpSkswZXBu?=
 =?utf-8?B?a2VJcEpGQVYzSmRjM1dLWUxtR0tLTWpTTzlOT1NLSG9TNnd1OHdyV3RhZWov?=
 =?utf-8?B?Z0JNRGdNelVzOW94bE40WnZvVHZ3UmNVN2w2b0JyMW5zWnJUaXZMUm5NRVoy?=
 =?utf-8?B?VFhGdUx6bTdCYXJ0ei9yTTdVcHlJVmlSK3VGejBCbUd1dGNjVmk3WnRBQTZy?=
 =?utf-8?B?MVgycUxPemd0Vm1DbnZJTFJpd0FlYXpweU8wVldtajNiN3Y3b1pWdWxHQUVy?=
 =?utf-8?B?VFdmaTl6QVlLUjcxL05kTCt6MDRBRUlzd1Z3K0FwMEJOZCtqWXFwdmMrME83?=
 =?utf-8?B?ekZUR2xCUmliNEMwY2lwa2xRS3VUY1RRZG01M1hUWUtOQkpRSWFJSUovK1Rn?=
 =?utf-8?B?NGtGampmMVBwN1RvenlueHREdU9HZU9hVUJFL3RlaDlJbWs2d0F6TDRDRCtv?=
 =?utf-8?B?OTh5TnFlYnNIWEc4djZnV1hpd2R2L1NXaFRobXZXZ01ZdTVvejgvZTFLVTFS?=
 =?utf-8?B?bGc1SmVqY3Nxb1ozUHJLVVp0T3A1WW05ZVZoeGdqL1Y4eWErQjlxUWZBcm5y?=
 =?utf-8?B?anc1cmtKbWVHbWpBTjQrNkhscVlsVnp0ZmhZV1FnOXc2Qzg2TjZDNC9nR1JC?=
 =?utf-8?B?dFF5Q3JObGdVa3NlcUlYN3UxV2hBU0tGWGprelZvQkdzYW1ZY0RkSG5tTDA1?=
 =?utf-8?B?UkNIZFNocmljL3JKa3FPejM2eFdnZnpYTlp4VXRHVlRsVHBYdU0zV1loVitQ?=
 =?utf-8?B?bTZNMlI1a2gvdUlJU2RPQjUxRXBJUVgwUHJveFFmTXE4dEcvSSthQitNQ0No?=
 =?utf-8?B?OTJyTmVVMXZ2aFAxaWJScCtySmVZcUxMY0ljL3I1RUJpV3hNLy8xQUlvRHpm?=
 =?utf-8?B?Z01USGRObzFtWm1GeEtuZHFRQmRUU09RRnZQNTFhQWNWbWhqaWdJRWg0MHdo?=
 =?utf-8?B?UkJiSUJlajVyelVCOElGdmRRT05Ia1JBSTlxSHJpQ3RGU2lDTUdVZHE3cElU?=
 =?utf-8?B?K2xENmZVTWR1VXRqTUZpUUxFTG9zMEZBNFZETzUzKzNsV3VTMFpMLzJDdklV?=
 =?utf-8?B?ZU5mK1NIMm5aUnNkZXphQUF4RWRyNnJFWVA2SnhiRHlPUmUyQUtjYWxNVmpF?=
 =?utf-8?B?a0NDOVdUTFpMSzBMQTZCVDR2OWRwQ1NyMk8xeG1mWjlnOGljMVdORlgwOEZH?=
 =?utf-8?B?NnM2YjNJZ0g3MjhKUmhVcGZwNjROeGN6UTBHeEE3VHBTWlBjcVMzc3NuS0t2?=
 =?utf-8?Q?uc/6xek9lYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdzZnVrR1BrOEVjajN1bFBLOGJTZ2pNcGpTY21zbVh5TnRsbFVHbUU2NU1O?=
 =?utf-8?B?UTdSclNSMGNiZW44MDZYcSs2NVRFT3ArV1U5UWhQRFhhV0Z3dHFvWHp5Q2Ro?=
 =?utf-8?B?S1JadERDNU1Sd1hqbXhyKzdteDNMczg2VGdFajdRQzVPeGpmdlVWSkVLZlQ2?=
 =?utf-8?B?K3E3b2J5Y1RvSHNpaVQvWTZpano3dytTZkpxRWNhdjh3YklHVVBOU3R5Zzlk?=
 =?utf-8?B?MXFISkZpcVlZclhiNHYxbnBOUm5oVldRNzFLSmkwc3hiL1d0ZVRPUEZKWVA1?=
 =?utf-8?B?SWtFdE5nL2VkanVXbmhQVW42THBnek1vbWFPa09VUkV4c2dhdExod1RWcG1H?=
 =?utf-8?B?R3hOM3REK2VUcndRQURxTjk0OGh3dlFJUDVUTHRpdTVHNi9VYWxFU2EzSmx0?=
 =?utf-8?B?Zk5KblhCVjRDY0pzekhHTU1Lb1pjcWtZSy9mZnprN2FCRk9PcU1VQjRHN0FD?=
 =?utf-8?B?NEhRb2F0aUJpNHBkelgrbHNTOHVuNmNDZjhmcGhPM1hidlVuL0VvdVVkc0JS?=
 =?utf-8?B?ODUyWElrcEdVejBDS2h1OUlYbVBuWlk0TlVCTnNhL2I5bWVGNFBQYzVPbXdp?=
 =?utf-8?B?OUpqU29PUlgxblM2bExDQWd5TG9BMW9pL0dPU1VWQ3ZOVXJsZlAvazd0bm12?=
 =?utf-8?B?UTVyWXczdTZmMkg3Ykp5NTFoR2M2L0dJWmFyZXMyNUtDbmZML0p5Yk5CRC9V?=
 =?utf-8?B?NFBlYVhUL2F2by9HaXZyVU5XWGYzWTEySTVlUzdhc3RDdXVvTnVLVkE0QmQ5?=
 =?utf-8?B?MFIwcWQ2N2M2djVrQVh6eDZLc1l5N0ZDWVA3Ulk3QmRBT2dRL3F4di9adU5X?=
 =?utf-8?B?WEdxU3pHeDk2Q0k0Y3RSa3VUd3FlNHNtcEJGU1M0R2preEJ3eUEwSDVPZEpo?=
 =?utf-8?B?V0N4ak9aOHZZRHpUT0E0dHQwOFJwTkI1NFJmYUE0d2thRFptM2V1MHJiMFZT?=
 =?utf-8?B?QXVUMmdCL1VibzlMTUU5WE9OSzRBbERFdFB2ME0wbHdIVnVvMmFtTkg0UmtD?=
 =?utf-8?B?NFJ2QUV4dkVHek5TeDMrRHRmVGdkQ0toTXgxOFZEeklrNEQ2aC9KUGhNOEFu?=
 =?utf-8?B?aTZjWFhwS2pjcERQakFFL0dyeWpscEFIbExhanZvOTVnNEFUczgydWdZbm1o?=
 =?utf-8?B?bkgwMFJNaFVScVNUNnlXVFJKUmFZME9RdFZxMm43dURLK2xMT3FQNTJpcXRJ?=
 =?utf-8?B?bHFKQjV1eWQ0dCtLc09QTy9PZTExQnNTY2xZTXZrK0Q2V1MrUzJPRVVKV29W?=
 =?utf-8?B?c0o1K3ZzYzZ2SWxxME5vdTdEazVMTEVUWFJ5RGxSZVpFMGx0YUUwN3B0bWlq?=
 =?utf-8?B?SXkzakRqR2F0OXVlcFdTZWZZK3o0OXQ3Q0xIaU5JaHpTdEVyVmNzZG1pNHB6?=
 =?utf-8?B?c1FKRFh0MGhrUHpVYlNKUWRDa3p4R2FZZGVjUE8wRFJGQjk5cndwZ0orUzNw?=
 =?utf-8?B?c1Uwc3VBTGlsWjh5ZCtwMVlHWmlmWHBIS1VIR2ZteXpHVmE4cTVqTDg5ZmNj?=
 =?utf-8?B?T0hyMGpUdEpNNkJZK0RLRTNBOEN0V0VYVXF0WEViakRvQkdnZXh3LzE4T3JJ?=
 =?utf-8?B?NmJuR1ltaGtkRGo0ZkMramtFYU5KOEwzT1hFSUlLQjB1YUk2a3FFUkxxTU4z?=
 =?utf-8?B?eDhTb3FuUEJweXA0bjRaNVR0Vk1hQnpiejZIeDgxY2Q3R1R3MnFoR1lrL2JU?=
 =?utf-8?B?M0NoaUtMdUJQT3lHYjBjSGR2MzRyWVFuMUY2b3RlR1VVbWEvWmVhRHdHYzRn?=
 =?utf-8?B?RVc2K0piNDJXUUtxaEZVaUpyTCs4bktIdlA5SzNJdGRhV0pRVUM5RE5vREdl?=
 =?utf-8?B?ajBpQjZvMUt1elpWZEJqVDZqOTJQQWRxZ2lNWkZxcnhTNEI3bC9ONjJlTi9n?=
 =?utf-8?B?TzAwVnBSS2JsSmhXckZRN09CWktzRTBnT3ZicFRpWXY1S1hHOWRGZys5RFJ0?=
 =?utf-8?B?eWV1c3I3cTVxaDRROXp6LzBLMWVUUTdmbWlkWm5VN1d6RXF1b3AvT3RhWElh?=
 =?utf-8?B?VlNJQW9Ma3BvVUtnM0VUYU9iUkpPQXM3NVF2eW1odlpCNkNON0UwT2pSb25l?=
 =?utf-8?B?QXEydHVZdGlnN1A1cWIxVlJaZzgvRmkwM3RKcmlycDZHOUFXb3J5dkwyRHBt?=
 =?utf-8?Q?zfewE2+TT7lOWJqkW5ShFSkWO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9126e5-20d9-49d3-2b5a-08ddecc3bdab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 21:32:40.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dhDicVA4biLTstkrnjpn2jqsoVTuc23tMn+DNMHRXhiDjOCoaNHVp/Ks4AXltNsHiSMY8s2taaIfpVv1yLHWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342
X-OriginatorOrg: intel.com

On 9/4/2025 1:02 PM, Rafael J. Wysocki wrote:

> 
> Since you are adding this #ifdef below, why don't you go a bit farther and do
> 
>> +#ifdef CONFIG_X86
>> +#include <asm/cpu_device_id.h>
> 
> static bool should_io_be_busy(void)
> {
>        /* All Intel Family 6 and later processors have efficient idle. */
>        return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO;
> }
> #else
> static inline bool should_io_be_busy(void)
> {
>         return false;
> }
>> +#endif
>> +
>>  #include "cpufreq_ondemand.h"
>>

I am fine with this approach. Would moving the #define to the header be
slightly better?

Add to cpufreq_ondemand.h:

#ifdef CONFIG_X86
#include <asm/cpu_device_id.h>
bool od_should_io_be_busy(void);
#else
static inline bool od_should_io_be_busy(void) { return false; }
#endif

Then, cpufreq_ondemand.c doesn't need the #ifdefs. It can simply do:

bool od_should_io_be_busy(void)
{
	/* For Intel, Family 6 and later have an efficient idle. */
	return (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
		boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO);
}

