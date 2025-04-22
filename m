Return-Path: <linux-pm+bounces-25899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCBFA96CC9
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC36819E105E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79610283C94;
	Tue, 22 Apr 2025 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XM4/QDNw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1B2836A5;
	Tue, 22 Apr 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328438; cv=fail; b=KofGGASIbagBSJ4bSqJZxuftONrJkrlVr2Vd8Qqi/oPc13bQCl/UB0oL0SZX9Jghbm+VZGK4tAoEcOksK4wjLYQ0PptEzfj2Xazx2ldDkijNu206iMJ15i/TKCotbJgrXqcLge/gOyCHBLSqZCgxAK4E4j0BJX0BczRBc3whyjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328438; c=relaxed/simple;
	bh=w2w2ZoDxOR7XaqeMwcaAOvSQYGDzSalD9z7Cq9vCZ1E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WaklNi8KRUZFtl7R6L0cy2Xi27GDdmGTvverfUqODk2FOXStUojhsPHmAUjhw8LijMVQwqHz5ypHsIHNZUBNsFLpAJCR3hfqxGsgpyGwsBmhVMYXJY4JI/8VwqhsyyrnDMx/UMx/dWaoeO8LwowbGcVKic1WuBnfpZOgAXGJWtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XM4/QDNw; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745328436; x=1776864436;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w2w2ZoDxOR7XaqeMwcaAOvSQYGDzSalD9z7Cq9vCZ1E=;
  b=XM4/QDNwpDdscB2dfPwoXMGAyk9F3IC2HzG8rAt281H75fejOvH+6VYZ
   b07UKUEuSEVpOXEDGIBKUCEam8TL3lY6LBc3+gSZs83Upp4lD2xfcj4g5
   O++cpERJC1Rh17v2qs1mhwy1N1u8SSKuXcsdhbdaosZowZ56585sfSxiy
   2b65wkHOOOhOk7DmgN2+WMmAZsNdkHR9BiAHgnQcd5HBuSjg/B6FxXpwF
   FBeJuWFi+FmJejFOTqzsho09/ya+vlcZMQq/RwUeQNg8VwQtTa3Yy7YMD
   J7FZQV0PlEWg09S/1rGnUAcS83UVTAxRqEXoT3P+4poY16yBvEWlyjfVS
   g==;
X-CSE-ConnectionGUID: zKMbw6XAQiilq46AwP2xQA==
X-CSE-MsgGUID: Ppscra4LTF26qX2OIVmtdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="49549445"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="49549445"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:27:15 -0700
X-CSE-ConnectionGUID: SFEPd8asRi29po6ADvQuKA==
X-CSE-MsgGUID: N0zDG/5CR5SMAfhsxbgj5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="131762179"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:27:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 06:27:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 06:27:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 06:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgBpfXH/FzNjEvsGz1ILfbjUDLu5UqCY7Wz+ifOZjqSc7Avy4Atp/EIaZ+uAnqxmzt/EfweCrz3c1X/mboT4llT6x3L5aNMd/OFpagxgNo9s3GRdx+yBJNMfu4cz6pT9ztSeZk1o59OWpA2QS0Sslvh2E1/lzZq4VDnSuchVXlCCYMtgWFiy0Yh8O7D0VSl5D6/xYOoTBf9ZSm4lYJKk4vHLBvAhbas2ydE6mgZeUcnEg52ldYznuVNVjnEpnaI5O3y/b9ro3DdaqUDUo+uXs1PDA/sIC8JF7yyc2kf+bg9d7kxN4UejFLeS+GKI1nFUm1gp4acVoYLr7swrhZcwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUKrBT+VLoNEaf/ujL5r+SvHsLgLIMnGR/nEbg7VZnw=;
 b=KUW3que/somhOs/9r4ximkhRhGKL6tcnfAa0zcPvmuYWKg6x/dfXFsAItyoDE+miEsPfZR/UCrTd+kjpGYM6sxu6B7a0fJGnGDCqZ9GO8QEGVlFnrai2C9vMoVe2kwJX5h/rAt2w2a1smnnmlUINuI/mzwcJ+WnmwnwC4be9c0GJfCTuG7Fv14MLi30UGZCemGLqRCi5qmwPS4gmYAwPZNR9bo0o7ALl7CfhAbzf+NEzi43U6QxmKWFxSgD8CBSzNFQyX3I+ByYEzt2vRvlkb9Xhfp6L/+3vbUnoSoI4c/vyBctdQiBo/zTMziI9adCO7qz1DaWw4Qo896NfzQZlFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA1PR11MB6614.namprd11.prod.outlook.com (2603:10b6:806:255::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 13:27:11 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 13:27:11 +0000
Message-ID: <ec22dba9-10c4-4a89-a381-17c0b09a2db4@intel.com>
Date: Tue, 22 Apr 2025 16:27:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: add PD workaround on RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Heiko
 Stuebner" <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, "Finley
 Xiao" <finley.xiao@rock-chips.com>
CC: Sebastian Reichel <sebastian.reichel@collabora.com>, Detlev Casanova
	<detlev.casanova@collabora.com>, <kernel@collabora.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>
References: <20250412-rk3576-emmc-fix-v2-1-830e653ad4f0@collabora.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250412-rk3576-emmc-fix-v2-1-830e653ad4f0@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA1PR11MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6e6ab3-5668-4763-671a-08dd81a16301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUlHYmdwcFI4VWdNQVA0VjZDbmtPNHVwemlJNENqMnk2R0JXdkliVFovOHRp?=
 =?utf-8?B?WjM2Q2VBMklEOS9kZGZSVUNiM2cxSm1ZVjM4UnQxaHBJd1k2TlpRRTZ1ZTVZ?=
 =?utf-8?B?MEtZNWZSMisrdkhjNEdYazVKdEE3cCs2aGVvWkZxYStLSWV1TFZUazF6ZDN5?=
 =?utf-8?B?aFdlSFJpNi8zTkZSQ3F4YTRBWTRDUmlTRFREVjdRZW96MzVWWnZTNWw3eis4?=
 =?utf-8?B?YVN0ZzJDVWl4N3pJckJDc240Qk4wTUdrS0NXY0FSOGh4Q1c2bzlhd1VZNFJk?=
 =?utf-8?B?YUZQVXdWNnF2Y3pma05vTDRWaU5XaXRQdkJUYWNDM3F0TEdoR1BYdXlkeVU0?=
 =?utf-8?B?ZVpWMnNRa3dSUDRqT1RkQTJjeVBIRUptbzZRaTlTQ2dNdW1yeWJFZ3FUWDdy?=
 =?utf-8?B?THkzSmZsK3ZKb2gvWjFMR0dWVElOeTFybWRLSTY4UUhiRlAwNzBrR0xXUHFp?=
 =?utf-8?B?TFh3TUFVc2RudVJFVDEyclA0MVhZRlZ6Q0tzZmwvMTc5aDE4WUp5TUJNK3Rt?=
 =?utf-8?B?VFozRXU0YmVNSUI1azRmakcway90dWZkcCtGd1MwVFQvSElPdndlck9WZ09m?=
 =?utf-8?B?TkZDdWlERVllY2YwZmdmYnJxOEVIc1pMU1lZd2FEMHNBdUJBdmladldld1Vn?=
 =?utf-8?B?OGV3NW9yTTRGK2JBdUJ0clFsb2dyMjZVSGNUNE0yVXlBYXJBUFNUaFpzQTRO?=
 =?utf-8?B?Q1JVZ0ZCa29wMHZ1bVhuSEJBZ3lpaVpNT0RrSE5DbEtWaytoamxseTdpV3Ju?=
 =?utf-8?B?N0ZQcmpFdmRtVHAxcHNneHFjUDl3dFc3YUJxRXp0NHNVOGZpSWI1VXVIRDdj?=
 =?utf-8?B?VGtmLy9abGhwbjhKaGJnK2VHbE1QMXN3RVRNVzdXU29SSDY0eFY5c3kyMnBN?=
 =?utf-8?B?OWEzd0JUR0I4Z3V2S09ldVd4bEo5ZmFlZ1dpbUJOZjNjZzJOYjkyYWRKMWxI?=
 =?utf-8?B?ZzZPdXNvZURTQm0yeWVnWGZYVHVJdUZ5YUZONVg2QjZKZVpiWVZoMDdqNm5I?=
 =?utf-8?B?WVlkOXhKWXA1dmxQVDNGUTJuTU9oYUdZYkFES2ViOVRLcUVMQVExUFJ4RVI5?=
 =?utf-8?B?MkdBWFBMVDByRE5LVEhtcHNyK003bXFUV2huTUFSM1hRclhWWG9Yc1pRY2U1?=
 =?utf-8?B?WTYrK3NidnVuRnlKSEovNTJQSGxvaEFaeG5MUGJ2ZjBueWxyUWpxK1lnZ1I2?=
 =?utf-8?B?MVFWMzVqY3VKK21jdk82a2J6ejBFVVNwWThycGlMa3ZUd0RhRzRqNEttRGVo?=
 =?utf-8?B?dWxrVlJlL09YcDg0T2hlZC9sMWJmaWl1SUVrN2pkMmFmRmx5elBKS293MFNW?=
 =?utf-8?B?V2wzNlQvTFR3WGpkRFRWYjZnU1M4MlhLTjdvekoxcEhIU0RJTnV4NGR3RDNZ?=
 =?utf-8?B?NGhPd0FJaGhablRMTU10Tk55R1lBZmdyMWFGR1hrRi81UjBDQml6cXZHem4z?=
 =?utf-8?B?MWtQZlJRWmd3ZzVBbklTbFQyZ3FodTVLcVYrbUFoaDlJYlRIMlBKR2FhS1Ny?=
 =?utf-8?B?cVp6aWVUa0hsRENZejNWQVc3L0JKbVF5andGRDdGTFQyUEgyNUh3STcvZGhi?=
 =?utf-8?B?bXR0dk1zNmpTZHVFVG5FdzNpVVQxZ2RyNlE0WjBTWDdnQ1B4eExwTmdkZ2xD?=
 =?utf-8?B?QnlqbUkvbkU0Q3JMUjVhUEpLWk5rN21qa2lvZEFxdTdCb2lMNk4wMHpwS0Nk?=
 =?utf-8?B?SzNkUUxHeXgwVXNiSnlDMjFkdDFLOFE2TC9tdngvM1BZTGtOTWM3aW9aUmdN?=
 =?utf-8?B?RllwdFhrWnR1OUR1MGJXVmhadkZxTjdUVnFGVDY4dEFDRUpWUmlPOHVGRzBZ?=
 =?utf-8?B?Mjh3aFJ6Nit4dVM5bTVUbUpxK0JWZ083NEUwVjNveGhIZitJbW1lUXY2OU8w?=
 =?utf-8?B?OWEzNWZKU3BzcThEVURWd0V3OWd4RW1YeGhxV0NMS3NRQ2tZVVF2VkFzYzU0?=
 =?utf-8?Q?2D7q7ACg+4M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWY2bmJqMUI0ZzJNZFZNcVJXblZGUklHTkZEeVF3b0RGZGpNcjVzNXFvcmNx?=
 =?utf-8?B?KzBneVRPSDk3N0p5ZnBoa1htWGFCVjU5M3VpT3FJY1hna3ZDL3E1N1R1ak0z?=
 =?utf-8?B?V3ZNQld1UGlCMGNtaG5FMTVGM01XbTRWOThFUUZJMDJ0Q1BMTG40MnBFUEZo?=
 =?utf-8?B?MW5uUjRDY0U5U0k1WTVzMFJ3VDF5Q0trQ0JzQXRUaHFXNVBnK0ZDRzhHa24x?=
 =?utf-8?B?eEJacC9keFJkNjl6S2V6Y3JHYnlQRTk3aSsyL3cxdzRBbVo0MWdaRDJkY3NK?=
 =?utf-8?B?MDRCOTIzdHYvbzA1NkVkeDA2anN1YUNhQnptVzlYR2JwSkd1bFUrU2IxRGY0?=
 =?utf-8?B?MmpPWU1NSTZkTWM3Q3N1bW9UUDEzV2ROWmVYeURvd0hHaEFXOG9pUVNpa1Nj?=
 =?utf-8?B?THl2TkxUMHFweWdjcHhEdkxsenVUNVFTWktYWms2VzIrRzhJeDI3TTNlMjUr?=
 =?utf-8?B?dTJzeTB6UWpLOURZaTZEWGYzTnVHWW4yTEdoaTFmaGoxK1ZHekNsaVlFNWJC?=
 =?utf-8?B?aEJWRGlMdGgxcmxjRnhjSThJMGZJMGw1MGh6R3J3M252V0UyTEtyaUUwMm1D?=
 =?utf-8?B?ODZpblBoL3ZxeEg3dElRbGs4bHh3eG01SS9YMzlSZ3lMcXVLRmtZdSs1Y2lR?=
 =?utf-8?B?ZVpqanduRisycVBtNVpkUW84cmNNY1JxbDd5Q1B4N2JweG1XMzM0ckRiTXFu?=
 =?utf-8?B?dFQ2TE45NlM2cWtsdVZQcTdnMUVjbWcwT3h5SDBBVCtvVXlBRVUvdXRPRWh5?=
 =?utf-8?B?MkszSEg2R1dlOWRBZkl1c055YkRxYUt0dGpnY1NhZzBZUktBMzc3YXNibUNl?=
 =?utf-8?B?YkhyMW9lYWlZbHI2RjBkcG5WS2ZGSDBDYjVqR1lWalQyS2NLSVZQbFpJNzB3?=
 =?utf-8?B?QlJNY3o0dDJMNDk2OG9RZXFyUGhobk9MS2tyWm5UWXo4RzdJR3FFbHlDZnlW?=
 =?utf-8?B?cE01dUJ2T0RsYWJOU0t5SHJSdTN6bUh4SWJ1eWdjUVN1K1Vva0dkQXNvTUlE?=
 =?utf-8?B?WEd0dE9FeFRGUVFyY3NNM0loekE4YVd6SlZUR0t5aUFUSEREajE2S0s4VGVV?=
 =?utf-8?B?Mnc0cG41MnBEWmYyMVBveWhxV2Z0RlZjd2V4RTRPcUNvNGxQTzExQTJZRW9i?=
 =?utf-8?B?NGY1bFprZUtSTHgwTDF5RFd6NDJjc3ZSOFROc0ZNYll3b2J0NTNjQXp4SFl0?=
 =?utf-8?B?UDBwdGNlV3BRUnQ1ckEzV1N2TVFvVXZoR0w0djVkcWo1SklnVHBMNGlnV3BC?=
 =?utf-8?B?bjZVeGpEdGhwNEpETDR3aEZncGVhQ2JobGgvQjE5ckhSTW9yK0hUL1ZnOGVY?=
 =?utf-8?B?L1VXemlzVTVITXR5L1Z3MVAzNUhySW9GaUx1aXZ2WndFRzdxME5tcFcvV3I0?=
 =?utf-8?B?N21ZS2dxdGtoNjB0bERQeTJvdDhvUVBRbTVlUHlSRmZtVW9UYkZyejhyUjBN?=
 =?utf-8?B?OVg2d0lYN2htVzRrUjlueE5OS0pXaGdvQ1luNXB0ZTVRc2dNZVYxTGlYNWw2?=
 =?utf-8?B?amZod3hEaHpqN1YyUlUrUUJxVzB3QU5uZ1k2SG5IR0FpRVJSb1U5cFJBOGNZ?=
 =?utf-8?B?RVVSclFWWHNuSk5pcWlDVGtXbC9UWGNRL0U3b0NtYy8wQ0w5dkdHQ3ZneFEx?=
 =?utf-8?B?cW9LeUt0YzlMUVduN3REU3ZHczl5ZmdDeXJrS2k5V1dxY1dBWm1WTEJEV1FU?=
 =?utf-8?B?Q1NHU1JGZGdIUGFaOTgrS2o0MGp4Zm8xbysrcHJxQW0xRWltdVNrMkt5anl4?=
 =?utf-8?B?NElyekwwcDF1eitpdXk2MUZvazZQbnlNb0Z1eFVXMWpnTklONmhvU1ZRblpy?=
 =?utf-8?B?dVlYM0MvdDlZRjZqeXdSM29qWVkrVzNobHVVZ3B1VE9XTlZsY0IzbUFHZ3Zj?=
 =?utf-8?B?ME9nREk0akhlYVpKdTVML1hmbWNDUW12OUNrOUxDT2w5MzYvV1JGRnFmcnNO?=
 =?utf-8?B?R1BmbzZ6T1RMYWJqQ3FXa2txbHdFbE1oclIxQnV3TWNxSkliSmsxbGJFV2RP?=
 =?utf-8?B?SEtQWXpyZkdXaVc3d1htNG1NLzQvTXVOOTNYR0JvYjd1Qk1ySFNtWnpOVm1n?=
 =?utf-8?B?cGtkbGxUQ0NJQUhZYVlmS1p1VUhiTWNnY0FyYzZnZjAvT2F6ZjQyRXFWSHVO?=
 =?utf-8?B?b05GV0hGd0g3YXM3Rkl2QUlkdG83OVNtTWIrU3RMVmtWd0R3cGpNQy9mTERU?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6e6ab3-5668-4763-671a-08dd81a16301
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:27:11.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QppgHCJ5xK3flt9eqcwFR2MiWnQW/DeM+I8XGT27eJoNO/LtZBuh9WA2jGTbA3mR9wia5H23xO9d305EpxHDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6614
X-OriginatorOrg: intel.com

On 12/04/25 23:45, Nicolas Frattaroli wrote:
> RK3576's power domains have a peculiar problem where the PD_NVM
> power domain, of which the sdhci controller is a part, seemingly does
> not have idempotent disable/enable. The end effect is that if PD_NVM
> gets turned off by the generic power domain logic because all the
> devices depending on it are suspended, then the next time the sdhci
> device is unsuspended, it'll hang the SoC as soon as it tries accessing
> the CQHCI registers.
> 
> RK3576's UFS support needed a new dev_pm_genpd_rpm_always_on function
> added to the generic power domains API to handle what appears to be a
> similar hardware issue.
> 
> Use this new function to ask for the same treatment in the sdhci
> controller by giving rk3576 its own platform data with its own postinit
> function. The benefit of doing this instead of marking the power domains
> always on in the power domain core is that we only do this if we know
> the platform we're running on actually uses the sdhci controller. For
> others, keeping PD_NVM always on would be a waste, as they won't run
> into this specific issue. The only other IP in PD_NVM that could be
> affected is FSPI0. If it gets a mainline driver, it will probably want
> to do the same thing.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Shawn suggested tweaking the comment, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - Rewrite patch to use dev_pm_genpd_rpm_always_on in sdhci driver
>   instead, after Ulf Hansson made me aware of its existence
> - Link to v1: https://lore.kernel.org/r/20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 09b9ab15e4995f0bddf57dd309c010c849be40d9..a00aec05eff2da8197cc64690ba9665be756e54a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
> @@ -745,6 +746,28 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
>  	}
>  }
>  
> +static void dwcmshc_rk3576_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
> +	struct device *dev = mmc_dev(host->mmc);
> +	int ret;
> +
> +	/*
> +	 * This works around what appears to be a silicon bug, which makes the
> +	 * PD_NVM power domain, which the sdhci controller on the RK3576 is in,
> +	 * never come back the same way once it's turned off once. This can
> +	 * happen during early kernel boot if no driver is using either PD_NVM
> +	 * or its child power domain PD_SDGMAC for a short moment, leading to it
> +	 * being turned off to save power. By keeping it on, sdhci suspending
> +	 * won't lead to PD_NVM becoming a candidate for getting turned off.
> +	 */
> +	ret = dev_pm_genpd_rpm_always_on(dev, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		dev_warn(dev, "failed to set PD rpm always on, SoC may hang later: %pe\n",
> +			 ERR_PTR(ret));
> +
> +	dwcmshc_rk35xx_postinit(host, dwc_priv);
> +}
> +
>  static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1176,6 +1199,18 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>  	.postinit = dwcmshc_rk35xx_postinit,
>  };
>  
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_rk35xx_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	},
> +	.init = dwcmshc_rk35xx_init,
> +	.postinit = dwcmshc_rk3576_postinit,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
>  	.pdata = {
>  		.ops = &sdhci_dwcmshc_th1520_ops,
> @@ -1274,6 +1309,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  		.compatible = "rockchip,rk3588-dwcmshc",
>  		.data = &sdhci_dwcmshc_rk35xx_pdata,
>  	},
> +	{
> +		.compatible = "rockchip,rk3576-dwcmshc",
> +		.data = &sdhci_dwcmshc_rk3576_pdata,
> +	},
>  	{
>  		.compatible = "rockchip,rk3568-dwcmshc",
>  		.data = &sdhci_dwcmshc_rk35xx_pdata,
> 
> ---
> base-commit: 64e9fdfc89a76fed38d8ddeed72d42ec71957ed9
> change-id: 20250317-rk3576-emmc-fix-7dc81a627422
> 
> Best regards,


