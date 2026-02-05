Return-Path: <linux-pm+bounces-42120-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AeiyMi48hGmZ1gMAu9opvQ
	(envelope-from <linux-pm+bounces-42120-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 07:43:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F8EF109
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 07:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3408F30136AA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3135503E;
	Thu,  5 Feb 2026 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyEfHwL5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F384A35;
	Thu,  5 Feb 2026 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273835; cv=fail; b=YaanENiGScDr1kinzvLrWqgfA6ILMxk/wOBeldjHphGSkuZD+aNOkkbePVUfZYhWJnA/aw5EHdO6fITxdBrnqRLKZYZ33n5VpBzG2hO2X/2Z+9d9AqJpjKmV7vefR56BJA8SVIup926b/aKKita43ZCD4fGfYWNTydZqzEwv0dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273835; c=relaxed/simple;
	bh=4QnQ6pzyG+xt7B9XRF+jBhAuZR76pQA5zZBl+jqEswA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DFqyXtLnrSRojpzujH5WO4O9poJulkbSBaYwqK3PLLdcyMtEMrLrf4ym9fYfoAq/+YXkEq+jKR89KNLcE/GXbJu27uuGMEHenoSnJVWBX1+UICEZNx3KDo0FKc25Hc/q30XYSbaD5c+KNUcvie10badL7NZ1jLq6l3X9SBAGQI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyEfHwL5; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770273833; x=1801809833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4QnQ6pzyG+xt7B9XRF+jBhAuZR76pQA5zZBl+jqEswA=;
  b=NyEfHwL5ZAP6y7D59NdzG+T6eyB60a4KnBrUBKPw5dbOPejHcW03fMv/
   +fCpug8nQdVFm8DsZtEIM35Jl442Z3xOIhUCMOEG12yZtTR3JxVOGzDdz
   dzcPQkmDe1ppzi+bfkUmMcq3iQBSlRuC99sWzuY5eXpo+u6mOsg9ArNm2
   o86H7xrbJx64DzskKlAxg4SNqShF6L1DcjvaLrS67KqqogPQZZrMjYbm7
   fMZi9oYpA7TFdXPi6eN7YCJX8EMQ5FBavHxbyXQ9yG2vQKDR7eB19AVnA
   SfZwy7owFrm8N3GpylubCLt0Fn5iKwfnkOEP2x66ZVJmrUsBG5e10JlTx
   Q==;
X-CSE-ConnectionGUID: ez/lxAlxSIaSYakwMLHppw==
X-CSE-MsgGUID: EcR1JTzRQw21PTpVPIUsQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="94116777"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="94116777"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 22:43:52 -0800
X-CSE-ConnectionGUID: osRpXofPSVG/D3L5HB9Yzg==
X-CSE-MsgGUID: veNmc521TVa+sJ04W8WRjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="214930695"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 22:43:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 22:43:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 22:43:52 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 22:43:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMqlhwUZrmcCymR7ywbbVyeuXkSKPd2c/Oq4ekhavXINMvewbpioDJ4f/88vOBGR1ombzBjrPS6fNtOATCTJVTUNrdEj4rNxQR3qjf5gy/CDEMo30IPCFwRjGULpPiGLbKw65d0we+3gG5cV4PNAvS6MZJyC1oLdKtBrm0pNY9S03cwMT2xYxQfL7xSL8SWwdt79DHep66p3B4XzVl5FmBrqHZzeglNUmvfFl0fjSVVOTeUIo6TaZpExb2yWhcgq8eB1q2LEoDx9ngJ235/V6pkAyGq4nIbYy84qFiywAV8lmN44rsyxMb2BhtjkG95y6u5dSvMum794c5K1xzYx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIj5ittnkG6Oy2jqrpbjASsMMhjhU8ly3eEWCqe+g4Y=;
 b=ExlO1+bavF47BYBdCBEbJuksX8/iVlPr+LNZycVoke8t23mSsCRvPTSPJ34KkhQQJn4/VNX8pDyoZfkcau6v9o5HaHBmeqRuCMnAyRiCPU+KIUkQuePVBS0n0SQMS1s3RKE4nP43Bz+6hSjEE3hyCJlCstR6dBZ8Vufx+7lP6HoyDuxS64zfQqznoRvdmqfMve0dSSEXYE8T24vtyRu2G9WX97lNjOfE0DFz+bh9bgByh4OcsjKdn9KoMwr8vIhjl0Uz3khsFJm7ikXWtzZ/HSJUC47gX8pfBNJVG1NdCZRlSEEIO3v3lPVzCV1qWcq00uUbdS4Lkc3jlkBHt1jLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 06:43:48 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 06:43:48 +0000
Message-ID: <504a7276-53d3-467d-900d-eb9323a78223@intel.com>
Date: Thu, 5 Feb 2026 08:43:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/6] i3c: master: Mark last_busy on IBI when runtime PM
 is allowed
To: Frank Li <Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <rafael@kernel.org>,
	<linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20260204111511.78626-1-adrian.hunter@intel.com>
 <20260204111511.78626-3-adrian.hunter@intel.com>
 <aYNveVUsiixWWlWL@lizhi-Precision-Tower-5810>
 <a650c5c6-5975-40c6-828e-eaa27403adfd@intel.com>
 <aYO-BlFaIV_gTeqH@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aYO-BlFaIV_gTeqH@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: e0913595-084b-442c-f360-08de6481eab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHlkbk1GdjdCVXZuTmJvM1NIaE55N2lwdFp5emdNRmNTT3gzWFZFQThLclVS?=
 =?utf-8?B?VVVUeFppdFQ5dDVCZC9kNzZ5bjQxOXhkSEsrbXo3N2ZRR3VzRnJqbXJVeUJx?=
 =?utf-8?B?RXdYcUxqUDJhdklwZHlXN1krRUg4RkIwNllsSlhJQ3l0T1A3QWNOVGRYYS9J?=
 =?utf-8?B?TmwvSWdZWk43bEZ3RGFCNXlacS9jQXVjNmhTbnVKVWNLQ09QWnRvQ1dVQnMx?=
 =?utf-8?B?RHhLTUZWaTRNdndQOTdGc3F4K0ZpbVlDaEZ3am1KS29tU3RPUlowUFpraU44?=
 =?utf-8?B?UEVyUUY1cTA0ZU5UWHRFT3VsSDZVTkJETFdHSC8ybG9uQnNlNjhUZTc2Y0hu?=
 =?utf-8?B?RmgrWnJxcDFtd2w3anNDcWdKWnVWWmdrOU5jUDRMVVpUVzJyYURzbVRoSWtT?=
 =?utf-8?B?elRCS0h0YUZPWEFoNWdCRGdzbE1nUUlCSkdqOTgyWVV5QnVDY1l0MEV2Lzd1?=
 =?utf-8?B?VmliUVpwejVEZXlHL2NwQmVJN2NEQXpER003MkdJMmVoSUNld0M5dTV4MExU?=
 =?utf-8?B?MVhMaTdrV1lzWHloZnlwelpUbmVLRkc5endZMWFUN1Bza0NvNU1KdjdYTEVM?=
 =?utf-8?B?THZtblhlTmhUajFQTzRwOVVtZ3JJZDJaZ2lnSWZiZno4bllnNXdxNlJUZHY5?=
 =?utf-8?B?OXBJTWpVZloyWW5xam1WblJzRHI4bURzSzdxcFBodWhpRkVxRWdyUENNYjMy?=
 =?utf-8?B?N05rT3lOZkhsdlpmRzM0aTNudDkwd1VqOHBwUkhFL08yUEdaM3I1c0FyNERI?=
 =?utf-8?B?bThkQWVzWmhYZWVXQm9nN29WeXNKZWc4RFZjOTVlQWxjYTBrZ0hYT29YTzZp?=
 =?utf-8?B?RDh0KzJWcHorV2wwYXY0ZEQrTjFUMUJHT2trYXVBWGpEUmtXQU1JZmZRWkNu?=
 =?utf-8?B?dy9RTldEMDU4aUN1T0FWdENRSmsvZW54clJSa3NpMVQ0YmRheUU5R0FxWVNV?=
 =?utf-8?B?bWVEN2lzQ0JNYkJzSkMwTmx3ZTJrTThOU3VkMVVUT09CbEIyMG5tc3N3WnhX?=
 =?utf-8?B?LzUrcnhEb0ZuT0tYWEJZQ3hzeC9MdVJEREJRWnU4N2RjbGtFQzg2Q0J5WWNT?=
 =?utf-8?B?eHRyOVdBd2VnSE5pMHhweGRRK1NHUndtaVlMbjlvSXNyYUFaY2JocFNQSlkr?=
 =?utf-8?B?ZkxIMFhmL05xckVrNjgzMkZSM3VGdW1LZkY1dTExZWdYbnBQbVcwY3M3dnd4?=
 =?utf-8?B?ZldZUzZqOE5lSm9iVDhjYUEzWGlvU1ZNYk1IcHltTlJhcHBDdXUxczJvT2hY?=
 =?utf-8?B?bkp6MkFYVkhXVTBlUjRyckZBV0xVN25oMG9ZbUVqYVJMRlFRbjU2MldCcDhQ?=
 =?utf-8?B?aC9saEJzakQzcHpYQm1JTVBSV1NJdlFpcmp1M3ZyVUtFOU5halNaTmdtS1g5?=
 =?utf-8?B?REx5eVpwZjI2MnFVMEs0WjF6dkNrWWFJQ2U5Yk05citFMjlpRWNCT0dSdm96?=
 =?utf-8?B?enFieUg1RE5MS3ZDZ3IzekhQcXhScW9hMTFsWUtZRGsvNFVhbUwzQWpnUjRw?=
 =?utf-8?B?anhiR1VkeWlNQzU3SjNVbEN2RFVtM1hsb2JwMjFzaXd1ajBvNWdGRFY5c2Nn?=
 =?utf-8?B?ZlZZcVdZR2pkSTZOMko3ZEZDSFRzd3VXeVY1ZGxZQmFFR2cvZEplUG5pU2Vu?=
 =?utf-8?B?YWxic210eW0wdTh5K3BOUWN2Y2ZLSE1waG8wRGt2SGFjTzIyVDF0NVpxSFhp?=
 =?utf-8?B?QzQ0VzNXSlYrVEY4MEY2aXp5dE05ZjdVb21LcDM2YXZUMjh1Qy9EWmVoL1Ny?=
 =?utf-8?B?M0MxR1h6VlIvOEMxcUhQSVc2elpacFRYYklLZ3FPdThLbFY0MUZ5dU5TTW5D?=
 =?utf-8?B?ZGZHYTcyOGUwc01ENUpOTzZBY2NhWHo5Y281RWw2dlFRNVd4Mlo4YUdPbUxa?=
 =?utf-8?B?bnhOd29MazlJTGVUaDVpeTJpcGV4QjhINVFjK1ducmdZWW9XVVkyL0JTY0dY?=
 =?utf-8?B?ZFBLMkk2aytOd2VIRmFHUDVnRzAxbnBLZk9NTzh6L1pFWDhaMWZ6REx2Z1o3?=
 =?utf-8?B?Z050QXRrRi93SFdDOHRGMlk5Zkw0OHBkT2xkV1ZZZEZscURBbE5SOC9TVXcw?=
 =?utf-8?B?cWZNYWE2NXhUTFlNZlAvK3pXVjN1bFlUMklzNnJoSzVDL1gyL1ZCSTRYdGdM?=
 =?utf-8?Q?RtQw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGQyVkYrTHpVSEFDZ05US01Wc1A4VmkrczZXNy9vVWd5MGlzYTZQUVdCQ2p5?=
 =?utf-8?B?WjJFWnFVWmxPZ3Q5KzlKci9iOXVlckFrV3QvcTU3RVZORVNhWitHVmc2SHB3?=
 =?utf-8?B?aFlPdURWZXcvNGw5MDBFREZKcC9xekl3dU9MWlM1ODZuMjNMT0hZbnhVR3Fj?=
 =?utf-8?B?VTh6RHZwMFVqVGg2RENrWGR5Y3RPZTVQN216cWkxZFgzV2FMK3VRRmF0Smt3?=
 =?utf-8?B?cmlIMUx2U0QyeFNRQ0FWb25vTElUQTNTcTVUTXFWRUpLekY4a3pQQ1JQOXNI?=
 =?utf-8?B?dml4NGlyc3VaNDg0YWhhWnk5WFNnM3lmQ0dtcXFYbkhCbVRUMHpXd083bFNW?=
 =?utf-8?B?VU1rcFExaGZVNSs0QWFzcG8yejdDNk4yWUtGWnd0andkYklCUHlUT2RVZ1V1?=
 =?utf-8?B?aWRDZ2lYWkpxL3JpemhsY0t0SlVPNTJyd1RxRE9YOGNoSGJsa3FENUNhUUVr?=
 =?utf-8?B?V1pDUFdUSC80bVBaR3E4NktTRjN5aFVUSWM1NCs0MjM0aGMwQU1CbVVSb2FD?=
 =?utf-8?B?YTlaWHNPcWh6dzg3QU9hbDBXL3M0bFAyUUg5aHVnMEtzNTN6V0FhOEp5SzNU?=
 =?utf-8?B?K3dSTHN3SVJpelVhRFl1WlhSenZzTE5zZCtGZDZLYyszejhnVHhUdWp1R1U2?=
 =?utf-8?B?OGFPOU1nMkdNcDhYb1FYR1pXWEZBa2tJa0t1ZmlsV1JBZVN6SDZiTUYzMEdX?=
 =?utf-8?B?WFN3THkzNVl4alVwcVJxN29RTXlvTWYzWXFaTUIrUmw0cGRocE52SlBZc3F5?=
 =?utf-8?B?VFVNcmdSL2pIU2MxVk50N0dyZ0VRb0xyeDNWZ2ZZeEdIWkdTYmdkVmxkRTNQ?=
 =?utf-8?B?MklyUHZYNEtlVTE5MUZvaUNmQWFKa1NVMjlHVS9KR3NWVHNhbGdjeW1NQnpS?=
 =?utf-8?B?N3RyOE1mM0dVYkl2L2RlTkNycWtxcUJabXJENDlqZ1IrMGdkNnhOcWF1QlRM?=
 =?utf-8?B?c29UK2FIU0YxSnFCUTVtbjBiNndHdHhpcW9DUjVqZHF6NkVja0tETEU3RDU0?=
 =?utf-8?B?cDFyQ0RnYmxwbnp6bk81NEdaUS9DWFVWQklkZ2JaMG43cmxta2NPbU9Ud05k?=
 =?utf-8?B?UnpxbnlodFQ3cmpNemdkNHJPZnNiMnl6NDRYemlMdzZ3anRlSWVWclNxOS8r?=
 =?utf-8?B?anFIZjYwUlNlVlVIN2ZUcUdxcDFxbHp6aVN2enNMMk90aGdOdGJVbzdKSThZ?=
 =?utf-8?B?VG5yOEt6blR0YkNaQWdlc1pSZjUxeGd1a0wrUmhJWHNjRGIvVUpSa3pWSXpG?=
 =?utf-8?B?R0JhamZGM3kxTzRDMUlRb250a3NXYXgzNmdWWGNPaCtlbHBac3dZQ3hSYTIy?=
 =?utf-8?B?REZSeS9UOUtlOUN0SisvNTBIWGhrRngrb0l1Y0JSZDhiKzRSQm55Rk56UnFV?=
 =?utf-8?B?K01DeWpRb2lJK2xldDJzSCttODN6R01UZzF6SjQxQVBVb1A0b1RSOVYvdUFQ?=
 =?utf-8?B?SnNiV0NzeDEzOElvZ2k0ZERNaVgvM3NMVW1ZdTNqekF4YW43SExlNkVTMDB4?=
 =?utf-8?B?eWtkVlpkeFJ1UnFHeVJaamw1c0pQQ005aG9JOUJ4UzgzdFhXQ3RuMENVUVds?=
 =?utf-8?B?UE9QSllpSk5lQS9hWkhyUG1ldzR0ZEpmZHZSOVdnSStBMi9sdGYwbEl4bW0y?=
 =?utf-8?B?cVlMSW9uV2t2L1ZxUFdpMllEbjhmYnFEaDhKcmp4RnlJWkhwSEJ3OVZZeExW?=
 =?utf-8?B?TVlRbHFRR2IvR0U1b1VYR0xHVi9iU3AzRFluNHpLYUJ1blhsT2FTekp5OUls?=
 =?utf-8?B?WEwzSzhUZlYvQ3Bra0hvQ2RlcGpFWDVjZUllbG1DbDBaU21SQlFqemd6Yy8r?=
 =?utf-8?B?RXR0bG1kQzVyYlRTM0c4aEMyaVlyTHVFclR2c3RIdnYxUHpBa3l0N25BWE5C?=
 =?utf-8?B?YndoQVpTQnl5WUEzdjBvNWZMbU9ISk40RjIvMmFQVEJLbkRpKzhGZ0hvNngz?=
 =?utf-8?B?T3NoSG5SU1l2Z0pYK0FvOTdoNndoMkRnbys4dlVjVEJxRXpHMnl4cTJYMzRi?=
 =?utf-8?B?ay9RVlAyT3g2b0FQcEZLVFdqWndQUHVyOGV3NXQwRWJIbjhyQlR3QXN4blpq?=
 =?utf-8?B?UGJRRUttSGN5NWlydkwydGlIYVhnM2lURmVRUDBEaHR4YnMwUVVVaXRvWVlQ?=
 =?utf-8?B?bXJOUTFDdkNEU1JBUnJ2VUswWU8xamFZT293SnM5SjQ2VVR1cE5VbjF2OEN1?=
 =?utf-8?B?Tm1xcGFLSWZiVWpBRUE3RlFoV3V0NGxRQStLdm9PRCtsQXQvZjFlaktka1R0?=
 =?utf-8?B?YmNDeklraFMzT2R4aDkxSjBnQ3JhYTUwQjlwMWV3MzZmZkVXVmpJT25VQlJ2?=
 =?utf-8?B?aE1TajI1K2w0b3hKUWtJdWM2Z1B5c1JtczJqVVhNcTloaUs5SkEwUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0913595-084b-442c-f360-08de6481eab9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:43:48.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4cyulYWwSHFuZBkk/eEXDlw3sRPyCAVNUSVHtzTN6ywv73RhbojSS8Xd9VCpgVwe0xy87Xg3pCHZW9f2ZySaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42120-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E84F8EF109
X-Rspamd-Action: no action

On 04/02/2026 23:45, Frank Li wrote:
> On Wed, Feb 04, 2026 at 08:24:21PM +0200, Adrian Hunter wrote:
>> On 04/02/2026 18:10, Frank Li wrote:
>>> On Wed, Feb 04, 2026 at 01:15:07PM +0200, Adrian Hunter wrote:
>>>> When an IBI can be received after the controller is
>>>> pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
>>>> device is auto-suspended.  In such cases, the runtime PM core may not see
>>>> any recent activity and may suspend the device earlier than intended.
>>>>
>>>> Mark the controller as last busy whenever an IBI is queued (when
>>>> rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
>>>> recent bus activity and avoids premature suspension.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>
>>> Although it is no harmful, I think it is not necessary to mark last busy.
>>>
>>> schedule's workqueue task to do i3c transfer, which will call run time
>>> resume.
>>>
>>> Are sure it will block your function without this patch?
>>
>> It is not necessary at this time.  I wanted to cover the case
>> where an IBI is not followed by a transfer from the target
>> device driver.
> 
> look like it is impossible. Device raise IBI, which means device need do
> some things. otherwise, why raise IBI.

An IBI has a payload.  A device could provide all the data
in the IBI.

> 
> Let's defer this special case when we really meet in future.
Sure


