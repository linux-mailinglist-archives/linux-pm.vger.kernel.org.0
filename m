Return-Path: <linux-pm+bounces-41789-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD9aDKrdfGl1PAIAu9opvQ
	(envelope-from <linux-pm+bounces-41789-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 17:34:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD5BC8E5
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 17:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3594D300AC8B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BEE34320D;
	Fri, 30 Jan 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWxNrnZD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CEB19F137;
	Fri, 30 Jan 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790887; cv=fail; b=siS+DZVhcpzMxDz98OLEg/TNLKb4peh952rPpwSUuhuinWacEO7nKOy0p+A2pc8eZ6oylQMZ0EIX4P7SMrzDa/noy2EHfwB4QDqXHasd0x5/oBk0EHaM244W0zsQN6wHAfjjmjKvOwuGbEZZhbiFkZ67WjVXSRccnupWT+VnbGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790887; c=relaxed/simple;
	bh=9oJ773esYT2UpbPh3JKpSwryV712f+y+FyFKvCGfXbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afgXrU0QDN3BvCtVuR8vZXM1kP3TtaCXtthr0twtKfHWqpVlDNkrlRVrtQtFR8Jo2TrgOJy6uSRjTGEn75xg7uPCEJr+6S0k6780gKeQ1bdVjMfynI0gm4E4EWBOIa/LKZBbnCyLiniy2QQ00tlATaMU/zDyWJFzbnFrUeoqaAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWxNrnZD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769790886; x=1801326886;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9oJ773esYT2UpbPh3JKpSwryV712f+y+FyFKvCGfXbI=;
  b=iWxNrnZDCZWRj/PliBKsIpME3HMLzR1q8mBgVzT6nPjsYQMgw/hKovJ0
   RBMrK80b4kLBnjGre51p2SaO7vVIq+mo1BjO29qzfvuUHzOmc/bIe8QVe
   L7fjD31i7zKRaUixVry+v8iKicsttfj70L1eUjtT5ll2tpz1id5o4x+1E
   w3DDVxhbURyQkV7xhTZB5L4QglNlL48KwOUPClzrazkysHXHeyOTuTBFT
   WbU7XwqnCn+vvBZ8bn1zTzd2o9gcVCqXI2BkTIIbEwcVRLwmdFJfJXypX
   Wz32U+TDG/95kEf9ZsMkWSwM3ZTqUMtFHh91DU7/n7d0i6wzdyWYIdCz+
   w==;
X-CSE-ConnectionGUID: w5h8hgGXRIeysT/wCuyVAw==
X-CSE-MsgGUID: coHfQ+OyTZOkDceugE7L2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="74666618"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="74666618"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 08:34:46 -0800
X-CSE-ConnectionGUID: 2ajle16CTIu4ddLIynbAcA==
X-CSE-MsgGUID: QwjLKBo6R0CaBLpUvmalhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="213789819"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 08:34:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 08:34:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 08:34:44 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.22)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 08:34:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMbkx0ZdsVzO5zjjKtJPUdThL0O2TCGJICu+hR7QijWf634g4N739OvXRd5yLfHjiAtVJNzSrLhYoVICzrso6EnFtOUugkVJEDCBvUIKJtsD+CHzRDrBDnED+RPFswc+NTVYzGZZcr8Ixq5tRdIwV8XrRJ+uGAiZ88V5YA/9r2DWxPB/1FYfhUIBYYwcQGGaqLYO38r0oBbUGRFBOXBYf60PeCCgt2QxDx+DbGbq6SVqSC/yw7v2mWWLPlSFKerEhz/mgcV639WMrOSkby2XX2qqO94E/Se7LnXeaAGoVPLhe5AdYBmItRoP9K3OBoATpAUWoRbERFn6XZeCYenwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9ge7XVFIbmjJwqWsIPCi6NXeH+QsX6Yim+Yn3bxcEQ=;
 b=fHG7aHl/Xn6akh7H5x47YXaGGB6AVmfUEdZS06qnNjiHwzW5DlzAyZ4SahV8tBFo0VercEg9h80SikPA6Ntm0ztUuWzk3ubVPOPZ3/a6Yltdv9ILopKvHhmmsZcs7qsXxRf7QyHJZuu01755yFcvOZzXukwb7jFWIPPo8bxOjVJlaXxmIRH+LNYGUF8yGVb6xJE0WEDoAMC+x5adID8vTXlShuQfZEiDmXvVfxWJRzDK6QSQ+R9ZXU0ni4jpA6My+52X/bG0jPHQ8lpJNmbOYep51zsTfvf+0e4hCtSI4gFOfNAeCjLFy2SBtYwS54pm/7JAOSQhSCTLlA+FhYrxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 16:34:41 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 16:34:41 +0000
Message-ID: <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
Date: Fri, 30 Jan 2026 18:34:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
To: Frank Li <Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
 <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f20a2d7-0460-46bb-e514-08de601d77de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjU0bW5nbEZWdVJ1RVF5a3kwNHRwaFdabGsvRG9SQ0c0K2VOZG0rbXBSYnNU?=
 =?utf-8?B?TllCYkE3aklaUjVhRUNvRzlwM2E3Y29aMEVrRWNCWUkrN0twdHZHcGNiNGdZ?=
 =?utf-8?B?YTVRTzBxN3RZUDRNTWlxQXFDczByNzZHZXY5aEViUVU2R21KbmhTNFFrb2ZY?=
 =?utf-8?B?R1FlMTlWbjE4TXZsbWRxMTNhWVRHWm96Q1BrSVpQejVOYVZoVVF0WFQ0MmFO?=
 =?utf-8?B?cEpHMjVVdmxxYXNiZkQvaGlRRlRUeXpYSWJBSjNHRUZXd2FCdmJxU3JqSlJZ?=
 =?utf-8?B?QnJuT0x2bmkvbm9YV2kwQWJlTXhmZ2tTcHBraml2UDR6VkNSY2VsNGx0Vkc3?=
 =?utf-8?B?elNEUVJLTWNGcXRreHBNWVR2VFVPbnRrK1JvNi9GOVU4VUNPK0I2WU9Ec3V5?=
 =?utf-8?B?Q2JYYlkxRkkrVzMvZGorL09VcU5qaDR5cENoN0ZZUEJmaVBlalJRU0Y1elNK?=
 =?utf-8?B?cmxzVHN4RitqTGs3TWRlTjVlVmEwSEFrWldTb1l3dW5YaHpqcEw1ejlUOTZM?=
 =?utf-8?B?L1NQUnoxZ3p3eisrOHlBUGh1TFc4bVZCYnpLN1lsUFhnTG16U1p2Zjh1eEFy?=
 =?utf-8?B?T3RwNUMrR2ovRFRwR0c5YllCamwyL21MT295ZGowa21pclpISVVBRFhyZlRX?=
 =?utf-8?B?eG4rekl0REtLcG1aTXlTQzdzRlhJaVMvKzZqVlhLbkhNeXZWYnZjNmwyZ0tR?=
 =?utf-8?B?UGU3cVRwWXR4S2ZUTWF5Znp1WW1rSXN3b0dmN2piUXcwMUtGK29aZmdtUjdY?=
 =?utf-8?B?alFGSkRBcnFvbG1RR21rTmp5OERLcFhxc3hoZGVjRHh2SWxNeEJIZGFCd2Nn?=
 =?utf-8?B?QnlJSERvWGZCVmRiN2gvaCs4RWFXWUhNN0wzUWpKcWQ2N242UkYzRW5oOGxJ?=
 =?utf-8?B?UjBZSmQzdTM3cWV4YVl6SWRMVCtyVWp6S1ErTk1XR29zQWZJenlpaWFod0Zj?=
 =?utf-8?B?Q0NSYmF0NCtycGFrVjdIQVNYK0NJN1A4YmFTVTlTWjVlUnNrRFNPOEduNjRX?=
 =?utf-8?B?d0p2L1VSMGdsTkxGV2pObGlHV091d1Q1SUhPd0s1QXk1UU1IZVhlRTdxeFVZ?=
 =?utf-8?B?NnMvcjRQR2h4UHBMenRJeWRoUG5kb2VTTk5qSExoSk8xNlF6R0ZaUEFibVFy?=
 =?utf-8?B?U0hQSlhmSXhyNmNTWVBuMFRSUjlvYk04MnF2Y0RQWTlVd0Z2eHlwNzVvc292?=
 =?utf-8?B?TVBoWk9UYnc1Wk9VZlFzcDZ6QU4zV2tJNVZyTGpOQ2JiTFBDUE54SUozZkNq?=
 =?utf-8?B?dkJtSHRkeWw0NlBIVGJRbWk4eVY4RWpBMFhKQkdBQi9ma0J0d1lHV0pCTWxo?=
 =?utf-8?B?M29HNWlmSXZkVWllek5iQVVJb3VjMFVzejBwYnkwRlZWMWg3MWVXT2QwZHFl?=
 =?utf-8?B?MWlheUhKLzh4Tkc2VkxBeS9WUmI5OFlmOCsyTjYxVytNZjFmU2xIWTYwSDNq?=
 =?utf-8?B?cCtYSGN0OVZoUkhuUkp3ZDBSUTR5cUNYQzBzNEFXSUpwK01zVlpuQjRtZGN2?=
 =?utf-8?B?bmFDcXRCOE5JZGloTDhUWjNoK24xa0hrdnpmdGgrcmZ4UXQrT3lzYkVxc1pl?=
 =?utf-8?B?QXdyb2U2OVFtcDkvbjFoV3Mwdm00MUlJQVpVMEhnYzRFeE53RjZhRC9HVERa?=
 =?utf-8?B?THdwWGw1TDhUZEFJVHZwREpNT3VWcDBYQi92cVVDbSt0NjExankxZTJJMk9Y?=
 =?utf-8?B?TDQ2YjdPUFdpSDBIY2dseG1zampHU251clBRL0Q2MStjOU9wY25ac2N3VG9n?=
 =?utf-8?B?M3lxOTRacUpId0EzdjlRNzVSSUlwM1ZwVW12Z0RpSjRiL0gzMjhvZXlzQ3dN?=
 =?utf-8?B?TlZKN0dHd2NTaWNnOHZjNXFDSVVDYXRhZHJSSFhsalhjVzJlQ1QyaUFzMkdp?=
 =?utf-8?B?SnpPVk9COTJYODdSNklZclJ0WTFYeGNrZGc4RjA3b1A0ZGFmbDJDTGZTeGx4?=
 =?utf-8?B?WkphK0RwRytMY2FkbVJ2bHZGQVpsTFJRM1JYWlhoRVRFUUNSREhld1ZhTURv?=
 =?utf-8?B?b0NMM241YkFkWG5lZEl6YmpKQUkzVVR6a253VmYrVWx2MzVlU3RIeWZ2K0p6?=
 =?utf-8?B?WG14ejBUcmExMnM0M3lCbno4Vi8rNG5OaGgzSHVuaHBUZ3RocFJTQXFWOXZN?=
 =?utf-8?Q?kRwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGFJeWU2ZVRQM3lJczlCZkxsNEU2d3o0NGZ1a0s3NzNxa0Z3NlVnWGlrQTZY?=
 =?utf-8?B?NFNkeEE0MGVGUURxQ2MzbDdqVDZLVHdGMGlWajJoYjhnOEJOTCtUN3Joak96?=
 =?utf-8?B?VCswdnl0YzI1VW9KRnNITGxwYzFHcDNISVVCdHNPMzJSemF0WDBLRTFFNXU0?=
 =?utf-8?B?WkpmbXlYNm1aY2haWVpQTVJDaTBKakZDcW9kekQ3c1YxN29ycDg4N0xlWTJk?=
 =?utf-8?B?blI2RE14TXdsckFjdVhWUmllV2NORUJuaXR2bDl1WXdPdzVlQlVITWdTamt0?=
 =?utf-8?B?ZEpVbVF4S3NVTnQwU0IremgvV2tNemJWb1duZ3AweiszUHhOekNqckQwbHpW?=
 =?utf-8?B?eitpdnpJaWZYdTlCeDlBR0pITGlLNVRlWEFJWGh5amdTSHJoQzhqSHlqY3I4?=
 =?utf-8?B?b09XQ0hhVFRZUU9BT3lZL1pxWXRDMlJOcUlvWURHZTBmamNiaXk3bUZEVU1B?=
 =?utf-8?B?Mnk2Sk9KTEZFeGJzWld6VXorN2YrSVplMjdxYno3SERHVGUzQStqeXcxK1l1?=
 =?utf-8?B?bFFNVm9YNk9aaWhQU1ArZUhyV1IvWWp4b3BmVEluamtJM3VqU3NSblZHYkts?=
 =?utf-8?B?U0wrdDFnNTV3MmFmODZUdS8yQVZCeTVPdHd3VWZQQ3BGUTlvVGY3RlYxR1Fw?=
 =?utf-8?B?TG5ieUdEbytYbjJpUy9uUDBOWmUwS09ETUdWcEFEOEVUSlpYOURMS2ZZaWpH?=
 =?utf-8?B?a0RnYnBVd1p5czg5b0kvWHVQUmo1RDRxQzlYUTliY0FwOTBra01GQ0JBeWhm?=
 =?utf-8?B?c2Jyby9lZzdoRVl3NU5mM2FhcjNhckRrdW9ESkhvSnIzbXk2d3VSNExQbTI1?=
 =?utf-8?B?ZjkvakJuVjhkbEpEZDhWaVJrWEpnSEN4MEpPdHkvSDY5RFFJbUxFcjBLU3JW?=
 =?utf-8?B?THFoY21FTXNwUmdSaXRUYVVGR1k3a1gzUDNVNksxU3dHQlpiL3pGdTlvWjgx?=
 =?utf-8?B?UHBlK3dnbnV0YTBsMGFYWTBqUnYxTjQzM3ZML0g4WFBYWDdIZUNnc3lqcTlp?=
 =?utf-8?B?aGpuUEJicmJPNWtMYVAwYzh5cEpPSW9hZmFjZzlDOVlCczd1dktVUnk3cGdT?=
 =?utf-8?B?OHRYWGpyRW45RTB2UXhiR3EyWGQ1a3kzazdvMFF0S2tuRHI0VUdOWW4vZlh3?=
 =?utf-8?B?NGJPSlhBMDBWWkg3MlBzbTRHS0ZiSG82UjhVRlVmS1F6SnpUQWtveUhlVmpv?=
 =?utf-8?B?MmNUVE5oZnVpbS85RnlPVFcrSmppZlEvaDFIZ3gyR1p2a0JSNWNpZ1I4bnhY?=
 =?utf-8?B?RjIweFJ3TGVwZDZ5ejZNcFJLZUZjOGpBUHBMNElIQngvOWNlczNOTWU0R0tn?=
 =?utf-8?B?NWhYMnl2S2kxdndxM0RsYUhHWXNMMDVvN0VGNnVDRGVWN09qSStZc1c3SmFo?=
 =?utf-8?B?Sm9ZNUxheXc3TGJNMnJrT0J6emI2MjloQjIyTndxaGZVcDIxZ1JPUk5xYXFj?=
 =?utf-8?B?Z3FZSWU2UFplS3h6cTdqMW9SRm1DQWJNSzkzZTNac09NeTlLN2tlVzJRS3ZV?=
 =?utf-8?B?Z0tXbTd3UzFMaHByTStRSnBnQVRLWHp0ZlFXL210RW1xNVl4aGZvWHhPZWNa?=
 =?utf-8?B?MW92TWh5dks5Mnoyc0U4VXV4MHU0bE9FUGRtanMxNDBRRzlPRVFJNXVxeUYw?=
 =?utf-8?B?RzZ6MmQ1Yk5Zc3BZQXV3WG1YWWhlUDRUREtYcUo5RnRrajFrVkZyL2J1ajVY?=
 =?utf-8?B?YjZkalRxdjRBV2owYTBqKzZld1Z0ZTZqK00wOWwwcG5GSnpDczErcUx5bjh0?=
 =?utf-8?B?NEFNK25iSUJhUEwwaEx5YjlBR2lTcEk3MTVEeHpxMHQrczNDcm5MUFBXcSs4?=
 =?utf-8?B?L2N5UnltcStPWmtxVmxqWGJXM3hiQU1xUUtpY1I1eTY3MnZGdzg3YWJjMHc1?=
 =?utf-8?B?Um5RdHRWZFc4RVZmSTdlUmZuZ3pUajJvQWFnV2QzUTFpMFcyU3BzNVhmVkhQ?=
 =?utf-8?B?SGlNWDd5SzQ5UnFwRVNCR3loY1U3Yko0TmdncmYwa1ZucXlDTXYwNlJpZ283?=
 =?utf-8?B?Q0k2bUR2RThkVlJ4Rk1mWllJK09JSkVkQVlucTlOMk42V3FaN0NpUnJsbE5p?=
 =?utf-8?B?SXpnVUFBditJV0duMTllTW1CbkNVaW9xUVVOTlNrVVpLSTR6cHNhNyt4MFZM?=
 =?utf-8?B?dUp6VXlCVkdQM2cwcGxoMW1wZDZ2cTkzZWRzNkJkbzh1UW5jTlFpNVFCTldF?=
 =?utf-8?B?TkZab1JXWllWNTYrQTZsNS9QUTd5M3hvNjZwQ3pBK1JJRnJ6MzZmSVA3VzhS?=
 =?utf-8?B?b2dmcjRlUUIwbkFleWR6dUpUbnZDU0d1a1c4NjVBR2E2RGxKcDd4RUNDV3Bz?=
 =?utf-8?B?bHdnK1REZDg5bjFNY0FCQndsc3dlM0RGQTg2MjJlcjFMWWRpd0Z6dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f20a2d7-0460-46bb-e514-08de601d77de
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 16:34:41.6596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XpGpHUO++5/spof0brRrNV2D1xGwCM62xxSgEnVMSRsL/yBM+spZJ9wka3c1J5CiwSvOMnfYfpyVz6/iobVGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41789-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C7CD5BC8E5
X-Rspamd-Action: no action

On 30/01/2026 17:04, Frank Li wrote:
> On Fri, Jan 30, 2026 at 09:00:33AM +0200, Adrian Hunter wrote:
>> On 29/01/2026 23:00, Frank Li wrote:
>>> On Thu, Jan 29, 2026 at 10:28:14PM +0200, Adrian Hunter wrote:
>>>> On 29/01/2026 22:00, Frank Li wrote:
>>>>> On Thu, Jan 29, 2026 at 08:18:39PM +0200, Adrian Hunter wrote:
>>>>>> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
>>>>>> where a single parent device hosts multiple I3C controller instances.  In
>>>>>> such designs, the parent - not the individual child instances - may need to
>>>>>> coordinate runtime PM so that all controllers enter low-power states
>>>>>> together, and all runtime suspend callbacks are invoked in a controlled
>>>>>> and synchronized manner.
>>>>>>
>>>>>> For example, if the parent enables IBI-wakeup when transitioning into a
>>>>>> low-power state,
>>>>>
>>>>> Does your hardware support recieve IBI when runtime suspend?
>>>>
>>>> When runtime suspended (in D3), the hardware first triggers a Power Management
>>>> Event (PME) when the SDA line is pulled low to signal the START condition of an IBI.
>>>> The PCI subsystem will then runtime-resume the device.  When the bus is enabled,
>>>> the clock is started and the IBI is received.
>>>
>>> It align my assumption, why need complex solution.
>>>
>>> SDA->PME->IRQ should handle by hardware, so irq handle queue IBI to working
>>> queue.
>>>
>>> IBI work will try do transfer, which will call runtime resume(), then
>>> transfer data.
>>>
>>> What's issue?
>>
>> The PME indicates I3C START (SDA line pulled low).  The controller is
>> in a low power state unable to operate the bus.  At this point it is not
>> known what I3C device has pulled down the SDA line, or even if it is an
>> IBI since it is indistinguishable from hot-join at this point.
>>
>> The PCI PME IRQ is not the device's IRQ.  It is handled by acpi_irq()
>> which ultimately informs the PCI subsystem to wake the PCI device.
>> The PCI subsystem performs pm_request_resume(), refer pci_acpi_wake_dev().
>>
>> When the controller is resumed, it enables the I3C bus and the IBI is
>> finally delivered normally.
>>
>> However, none of that is related to this patch.
>>
>> This patch is because the PCI device has 2 I3C bus instances and only 1 PME
>> wakeup.  The PME becomes active when the PCI device is put to a low
>> power state.
> 
> One instance 1 suspend, instance 2 running, PME is inactive, what's happen
> if instance 1 request IBI?

Nothing will happen.  Instance 1 I3C bus is not operational and there can
be no PME when the PCI device is not in a low power state (D3hot)

> 
> IBI will be missed?

Possibly not if instance 1 is eventually resumed and the I3C device
requesting the IBI has not yet given up.

> 
>> Both I3C bus instances must be runtime suspended then.
>> Similarly, upon resume the PME is no longer active, so both I3C bus instances
>> must make their buses operational - we don't know which may have received
>> an IBI.
> 
> Does PME active auto by hardware or need software config?

PCI devices (hardware) advertise their PME capability in terms of
which states are capable of PMEs.  Currently the Intel LPSS I3C
device lists only D3hot.

The PCI subsystem (software) automatically enables the PME before
runtime suspend if the target power state allows it.

> 
> Frank
>> And there may be further IBIs which can't be received unless the
>> associated bus is operational.  The PCI device is no longer in a low power
>> state, so there will be no PME in that case.
>>
>>>
>>> Frank
>>>
>>>>
>>>>>
>>>>> Frank
>>>>>
>>>>>> every bus instance must remain able to receive IBIs up
>>>>>> until that point.  This requires deferring the individual controllers’
>>>>>> runtime suspend callbacks (which disable bus activity) until the parent
>>>>>> decides it is safe for all instances to suspend together.
>>>>>>
>>>>>> To support this usage model:
>>>>>>
>>>>>>   * Export the controller's runtime PM suspend/resume callbacks so that
>>>>>>     the parent can invoke them directly.
>>>>>>
>>>>>>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
>>>>>>     parent device as the controller’s runtime PM device (rpm_dev).  When
>>>>>>     used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
>>>>>>     instance’s system-suspend callbacks from using
>>>>>>     pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
>>>>>>     PM is managed entirely by the parent.
>>>>>>
>>>>>>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
>>>>>>     by parent-managed PM implementations.
>>>>>>
>>>>>> The new quirk allows platforms with multi-bus parent-managed PM
>>>>>> infrastructure to correctly coordinate runtime PM across all I3C HCI
>>>>>> instances.
>>>>>>
>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>> ---
>>>>>>  drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
>>>>>>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
>>>>>>  2 files changed, 22 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
>>>>>> index ec4dbe64c35e..cb974b0f9e17 100644
>>>>>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
>>>>>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
>>>>>> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
>>>>>>  	return 0;
>>>>>>  }
>>>>>>
>>>>>> -static int i3c_hci_runtime_suspend(struct device *dev)
>>>>>> +int i3c_hci_runtime_suspend(struct device *dev)
>>>>>>  {
>>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>>>>>  	int ret;
>>>>>> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
>>>>>>
>>>>>>  	return 0;
>>>>>>  }
>>>>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
>>>>>>
>>>>>> -static int i3c_hci_runtime_resume(struct device *dev)
>>>>>> +int i3c_hci_runtime_resume(struct device *dev)
>>>>>>  {
>>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>>>>>  	int ret;
>>>>>> @@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
>>>>>>
>>>>>>  	return 0;
>>>>>>  }
>>>>>> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
>>>>>>
>>>>>>  static int i3c_hci_suspend(struct device *dev)
>>>>>>  {
>>>>>> @@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
>>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>>>>>  	int ret;
>>>>>>
>>>>>> -	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
>>>>>> -		return 0;
>>>>>> +	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
>>>>>> +		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
>>>>>> +			return 0;
>>>>>>
>>>>>> -	ret = pm_runtime_force_resume(dev);
>>>>>> -	if (ret)
>>>>>> -		return ret;
>>>>>> +		ret = pm_runtime_force_resume(dev);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>>
>>>>>>  	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
>>>>>>  	if (ret)
>>>>>> @@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
>>>>>>  	return i3c_hci_resume_common(dev, true);
>>>>>>  }
>>>>>>
>>>>>> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
>>>>>> -
>>>>>>  static void i3c_hci_rpm_enable(struct device *dev)
>>>>>>  {
>>>>>>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>>>>>> @@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
>>>>>>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
>>>>>>  		hci->master.rpm_ibi_allowed = true;
>>>>>>
>>>>>> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
>>>>>> +		hci->master.rpm_dev = pdev->dev.parent;
>>>>>> +		hci->master.rpm_allowed = true;
>>>>>> +	}
>>>>>> +
>>>>>>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
>>>>>>  }
>>>>>>
>>>>>> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
>>>>>> index 819328a85b84..d0e7ad58ac15 100644
>>>>>> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
>>>>>> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
>>>>>> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
>>>>>>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
>>>>>>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
>>>>>>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
>>>>>> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
>>>>>>
>>>>>>  /* global functions */
>>>>>>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
>>>>>> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
>>>>>>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
>>>>>>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
>>>>>>
>>>>>> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
>>>>>> +
>>>>>> +int i3c_hci_runtime_suspend(struct device *dev);
>>>>>> +int i3c_hci_runtime_resume(struct device *dev);
>>>>>> +
>>>>>>  #endif
>>>>>> --
>>>>>> 2.51.0
>>>>>>
>>>>
>>


