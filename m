Return-Path: <linux-pm+bounces-35709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE80BB82F9
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 23:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EA4F4E4FA6
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 21:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC26264A8D;
	Fri,  3 Oct 2025 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHfM640P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5ED153BED;
	Fri,  3 Oct 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526905; cv=fail; b=uIn3WrounyM0ApISV0KbCKnAmX4krdIkbMhMe2ykyjluJ78k7Ni5IQKG9DLuok3KyONluvRmvwoi4htEoVAfMxC3QezvE7tG2aXNXRfLcpOG9QyWtYAgdJoUe1QXCJioLvfv9NvSlurUT1aFKvHgBvKe9Ck5/J4PTTefvAx15dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526905; c=relaxed/simple;
	bh=+n7OGG+Kit0Bymr4v6i0FjnDjkQdSvAE9805r+LmY4k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UY36+x6DgGg8o36DSIVJOYZdG9xgXZoenCXsl5TrJyh69IKHnYf4jlwAM2oWccy/5xcymoOpdl4c9sAEY7wxHutdH42D0ibvc4NcpZKwN+1qBfWxyoGzDMUG2g3Z7bEcwgxtNiVodA/p2171thvAD6xk8aa8W+Jo/bT/ix6mx9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHfM640P; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759526904; x=1791062904;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+n7OGG+Kit0Bymr4v6i0FjnDjkQdSvAE9805r+LmY4k=;
  b=nHfM640PtbYNKU5Ir3/kTla+7Ln+DxTSKKXgWhwTuuoxG10sZMaTHwQX
   6w2WIQxgMn5m4OwPz2++d6ixPDgTkjME2MD8mFSWSiwcyzx8Ks3K8paRJ
   mmwzUMupw7GOeqigqjFak6DyVNCXu3RIqFETuyNSM1/mEDahbkRvx246d
   70E7878iSWhD0BN5/PeZZofS5xmqlPhBV4QC355oyb4LkB975l8aA0jNX
   zZGYDfhaiEBcaiTrZCnYnWAvAWcaVb2wmQXtVox8q84/bjRrFtWNEbmiV
   fOUnLV+sFZOJ9CvEfHQjqJfrUMZSNyoKVbSZEXuCl4dAalwELo5JV3BHG
   w==;
X-CSE-ConnectionGUID: IPSoy45GTYCipTOg/3dPYA==
X-CSE-MsgGUID: ezMCurBeRDitRbqsq0nozw==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61721628"
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="61721628"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 14:28:23 -0700
X-CSE-ConnectionGUID: UeeIHERrTbW3IiUvFEd5og==
X-CSE-MsgGUID: mJKpN30ZQNC9KXube+J/pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="178510187"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 14:28:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 14:28:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 14:28:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 14:28:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5IJ1+ro1QHRLlt3kcSeM9THuJ6NWbrRonMfd21HDGJzUBfELFlRmabNlsivuCcfIllC8bg5oNv+ZwnffyWXQOg//SqXQ3XQaepdEVj1HT0cD4pp6B0ptERX5Nm0g+tvX3tu/+KdbiCv/AG+Dttzh8DcLIKaAmquUX0rYyEe+0AUBvBlnXnnKEPM878DSrvTbHi3VrWp6iY60NTIAmgHW7TcI8kc9h2PNfI8A8w/j02DcjHk1yF5B7kcq+uWDoYjpoNp0d3VrWyG7m/fU0/hZ0ozqPVbyP9V+U2k7uQdPzV52mtGPGQavdb3BK7jgG9RTcVzp9QFmNmqZgSTJdZiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0G7ZeMt+yrJOT31vQvb+VqKSK+VqMEmXQD/gwKs+0I=;
 b=Bsve9C7ryVCpqxWqLJ2wD4gY8qekObxDLHtw4bK2wHH3ii/dLdqJ87N7G+Qz0mIsHY8X9Nl+Sv2zvuPhfVCuiqfI87u+4xrWuaYmLXFQeCSxYUN2q9banqOvnQCvmy/KVBFpNfsnwU4OkJCz5WtDMmyMnnOs0G5x997ycIThPiceQIJTNnB8XjJ230d3Vj9mlEgp6g0p6BifSu16BDEH6YfjiFyKQ2kLf9OlZIFu/g21NkyIMhTN7ElVMcNd2+nJKl9HuH5weIVymDYt54n8sKQX5Pe7YejTeoJE54gPQKYIpuH21fj+TV5OGBYdHB3c83KSBwrdpsmUpUlnOo5u1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH3PPFEC5C0F28D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d5c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Fri, 3 Oct
 2025 21:28:15 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9137.018; Fri, 3 Oct 2025
 21:28:15 +0000
Message-ID: <b72e6a44-48e9-4874-9d9d-9e07fe58259a@intel.com>
Date: Fri, 3 Oct 2025 23:28:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] docs: fix malformed tables in Chinese translations
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, <alexs@kernel.org>,
	<si.yanteng@linux.dev>, <dzm91@hust.edu.cn>, <corbet@lwn.net>,
	<zhanjie9@hisilicon.com>, <viresh.kumar@linaro.org>, <superm1@kernel.org>,
	<2023002089@link.tyut.edu.cn>, <qyousef@layalina.io>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kernel-mentees@lists.linux.dev>, <skhan@linuxfoundation.org>,
	<david.hunter.linux@gmail.com>, <khalid@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20251003162626.6737-3-krishnagopi487@gmail.com>
 <20251003173926.10048-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20251003173926.10048-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::6) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|PH3PPFEC5C0F28D:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cec9b8-9355-437a-610d-08de02c3c356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFBUeWFvM0xDQ1FWRVJGZVFLd2NvLy9nUFAzNjVSTzdUdXp4S2xmdllOTVI1?=
 =?utf-8?B?WVIzVERaZmxDSUh5YWhqMVM1K0VHcUFpU2VITlcrLzNkZm5ZT2dmeTlDTDdX?=
 =?utf-8?B?UEN0YStsMkVlMzVOUlpDL0lYRTc1ZXM3dGJLSEpTUmpCb0ZaMUtYZW90V0FX?=
 =?utf-8?B?T29LemdjOTVRUzFNRG1CTVBGaklZTWsxaEg2eUFjU004Q3ZnK2VvMkUrN0lU?=
 =?utf-8?B?SmM5TXRhcXUvVWpWMjJ3dWV1RExwSVFNTTNqNUNUZ0k4d2lmWnNnV09jV04x?=
 =?utf-8?B?cS93R2RxZDd6QnNnU0Rkc1lGdTI1NFlGdTB6eWtyKytaNTFuMk5BcnEzRk9E?=
 =?utf-8?B?QXl6ZHQ0eDU2VXdCcjNNQldUcDFJOWJ4K2NEYzlNVXlIRm96QXlVM0RUNzBJ?=
 =?utf-8?B?TFFkcElZMWdaRk50SVk5Y3Zab2pvbE1OUHh1UzhyWGowVmE1Z2ZWUWtITlFW?=
 =?utf-8?B?aUp5WVZpVkhQTTRCUFZHTXNvRVE1T2dCeitrM1Q3NDZLRGRwcnVpWTRIREF2?=
 =?utf-8?B?L3NEL0RIUE9VeWhBOGlXRGlUYytWTE1ROEpIb2RPMWdJaVJnUUxZK0hPRTMw?=
 =?utf-8?B?RDJ4R2RuVnYxZUtSZXEweWF3eERsejF1engycnpZbno4TVN3NjV2bXpzTFRj?=
 =?utf-8?B?cm1KdXY2TlR6czN0eVhXYld0b1lNaHFSSVQ2Sy9sZ1FVT0w2Wmpzd3VpVWdJ?=
 =?utf-8?B?MG1IRUdndVVzaU9nVitpM0oxbDk3ZmxzQS8xV0Y4Z1V4T2NLUEloMm5QVmtx?=
 =?utf-8?B?eVppSW9XdjRlbDlLWFRLb3hJV29rSGgyRTJTZndiTm8xak54YnRBNWV2bXYr?=
 =?utf-8?B?UjRuQUsxSGZIMlNRMWlQSnVRS2huK0pnVVVMTTAzeUdiWGRsWE9XaHF0WWp5?=
 =?utf-8?B?NzI3Z1hMWUxmMmJTR2NUanFPbmdHUlljYkdJRUM0UGI1YUlKVkV1SXdNWGYw?=
 =?utf-8?B?Ri9kdGNrbWZWVHpxdjZ0c0pJdktQRUQ1b2l6R2xzSFpSN2FuYlppTU1wR25u?=
 =?utf-8?B?em1EWHlIWUFSK1M4Yy9FU290MTFDUUc3Yk93a0M2ZUw4U0FnN080OEFYbSsx?=
 =?utf-8?B?VWUvSHhjZDA5U2JCSWxPQ3hFWkk5cHRNWU14SUcxMExtQTE0d21NZ2dOWGdD?=
 =?utf-8?B?ODZYbDg4VXRjcERVbDFLTTNJWHNkNFZOcHdrckczNGlra2pvb2tpaVdpWVNV?=
 =?utf-8?B?ZVV1Und4dnhEbFUxVlZBTFlORGJ5dGdNOWFqNjUwbFRSc2xUOU95dHZKTyth?=
 =?utf-8?B?NjlzRmJiUVpwbG4rbjBHL1RVaGlkNk9nNFN2V2R1VGxXYVZZN1VsUmxGVU1J?=
 =?utf-8?B?Vkw1VEpNaWhCYXkvd0NCUWl4VktWTmVVZEJLV3VMVUhTeCtQV3VTOEw1RUdt?=
 =?utf-8?B?V1BoTGI3dU1QNzgvYndLeEROQmRtc2psL3d0TFhNTG0xY3JHR0xrTWFmU2dT?=
 =?utf-8?B?NjRJczNvZlpXblA5WmhDQVQydlBUNU4zTzltL052empmOWhWYnlMMVNEWldO?=
 =?utf-8?B?MXN4SGVYTGdXRW9pWEhnWDhvclFSdEk1dGpiWUhwNGtzendIOG1KeTdpbGNl?=
 =?utf-8?B?V2RpVCtkZVlIZUNvblVybFZGY0hHQVJOWG9VQWJlZEErQXRscGoyQnlvcW9w?=
 =?utf-8?B?V0Q4TWNqeGlMWTA0bGFMRE5vM013MURaYVlqZWNDVW1YY3VSbENXUTh1emFt?=
 =?utf-8?B?Wkk4NS9SZFpETCtmRy95SmRPYjZidmx1OCtCbWU3WGNRbzlORG5VelluczZX?=
 =?utf-8?B?T3FHSGdLNUtqRzRwdExzeUExY3RwSUFJU3hETVNyaWdPdHBZaHJJWVYxcFNY?=
 =?utf-8?B?YVlhNXQrcGhjL0xadmZJV0U1ZVRJcVlSZEt5TG9pSDZhVjN1TEQxVVpxSE9R?=
 =?utf-8?B?TUd2cDdiejNYU25UekNqRVhGekc1eWRTQ3FnS1pHUEMwTStOV1RGLzl0RU5r?=
 =?utf-8?B?TWcxZ1ZFQjUxWG42YUEvY1NjdDA4OXgvN0xYWUN4cVZxZnJhNTZlMTVRbmJQ?=
 =?utf-8?Q?yJOqZiypOrykPZHxGHbkL3l1M5q3kM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZjdHJYaUUrc0tCRi9ja1hwYTJUVnd0dmkyQ0RtbXBZcGZlL0VkeWE2R2c2?=
 =?utf-8?B?SmMrcllYdG9OY2VYWmFNdGFMQjlGbHVXMUxsbkYyUVlscXpGSXRuRCt6VS9v?=
 =?utf-8?B?SmdMZERIRnIycXJGMU5NOHpIdFhPbEt2YkZKQ0hINkFVRjhDdlZhTjNvbVlM?=
 =?utf-8?B?ZWNjN25UdU9UcU9haHB5eGVTdWNQc05HZ0lPMjhnSm1keFM2RENZYXI4WjFJ?=
 =?utf-8?B?ZGJwSmE5dVB3UGhHazdLc0NobCtMaWpDTFppdTlFTEFNek9PZUcrTXByS2pa?=
 =?utf-8?B?S09pZkRDeW5scm5KVXhvQkFSTUxkNTEwMDV3REtsRVNaU25Sa2NEU0hJMjh0?=
 =?utf-8?B?RG41cjJnbDFEQWhpNFNWZ0NIamIvU2VnTFUyaG9iUHFkWkhvbTNjZzJwN1lD?=
 =?utf-8?B?TWdrNEpuQWNpMkpaTTRVSU1SSnUxNnQxKzY4eThXK2s4TkpZVldET2pLcmx6?=
 =?utf-8?B?ZWQ0MmVjUk1BbjlVcW91M2tOZnZUYmZacHpPN21xajNPOHFDcmZDWE9NZnJz?=
 =?utf-8?B?MU5ycXRnWWI5dzV1U0haVHd3cys1V25qTE9Ma3NVMVdaRHhzckpPK2pGYVE2?=
 =?utf-8?B?SGFXRTdoR1NKSWhLMHV4c0VISUNFRnF4Q3A3THQwWGhqWHQyS3VVUVRINFRY?=
 =?utf-8?B?UWtzMnFzMzFGMEcwRFRyK3BtN1VyWDc0TWpOTWx6QXhEOUUyNFg3a0o1eEx1?=
 =?utf-8?B?TS9yQ1dLbzdScUsyKzV4YndXcGkvby9uOUh1ZGgrY29ZdnBUVW9sdWsrVGRp?=
 =?utf-8?B?T3N1VmxFanJ6VkpXQmthQWl3UDlxYkRacGltNi9CZjNrZzc3YWkrZ2JsU3N5?=
 =?utf-8?B?aWx4YnZLakVDdnJIRGxicnZYMnQvaUV0dzdXTzd4d1R5RXhZQS9XVFBYWEw4?=
 =?utf-8?B?S2N3ME54VG9sZWx0TUlpcDl2a3Y2N2JjUVRhTy8zNk1HS0tzREZUTTZIN09F?=
 =?utf-8?B?dzZUVjRjeExkYmllc0VhU1J5ZXhmUHRZTDllaW1iVzdJZlo4aXQ3VlJMNDR4?=
 =?utf-8?B?SHdKWkhxaHhKSFNLVWdWWmdRM01IV2M2TkpIQmxkSkJvdTk2K1lZNE9mQkZS?=
 =?utf-8?B?Y05jdDF5OTlHRUJOTnArZnVVZkVIL1p6Z0VPOXhqWnpmb0p6SWQyWUpGNUZF?=
 =?utf-8?B?cU0vUnMrSTdCOG5vOHFoVXBCZjVDTEtFTVNjNHJ3elJrNnFZc3owYkszTUo0?=
 =?utf-8?B?Mmk0RGpDS0FnQXpYeWJDTUgxTVVBV1ZTUi90N2VITjYrTGd0TEhFaEhsbEZP?=
 =?utf-8?B?VVNBMkpUaHRUUlFRbTc0eTdzbFpUSDNIN1VmTHI5V3lkV0Z2ckRnekRmZEl0?=
 =?utf-8?B?L3NLZTE1V2tCZEVWY2Qyai9nNjdkbXZhK1pMSEJ0VjdUZE45R21DZVI3bnZx?=
 =?utf-8?B?TGg3TE5QdVNjUi82T3BIUHlWSEdHNGNqbXFPbjNldCsyajRWM0hvOWFOMnZT?=
 =?utf-8?B?bDZHNllSNjZZekxnZFZyd0lDUm1kL0FSVTJZdStUQytxUm5PR1BydWo1dVFq?=
 =?utf-8?B?a1JuQ3NaU0RZd1EyaHh6QkxoVlZmRkFCNkx6K1IvOFVlLy9BVndqU2RBTGd0?=
 =?utf-8?B?eXJkSVg5bzNaQkR5cUEwVlI4dkxOeHJqN1BrQktFRGk5RnZyY1A5dVdEN081?=
 =?utf-8?B?U3JFcmNDZFZ4YmFseEpzMGdtOS9QcllSYmVhYzdCSlI0MUhYTzlkRXRRRzVX?=
 =?utf-8?B?OUxkcEZaZVFXMVpWdGNTODdMZGhsN3FiSHQyVUs4aGwrSTdPNnROUWU0Mzdh?=
 =?utf-8?B?MEowWm1XSXpDeTVEUWtGcGh0MW5oUHVOWDF5N0p0TEN1NnQyTWpYL280aUhy?=
 =?utf-8?B?ZzlEOG5ZckYvUzVBa29RV3pxVS9zdmdLQUU0TmNQWW05SnVXaG9VZVV3blEy?=
 =?utf-8?B?c05sWVRYNGllN2QzdVVtQVg3eTA4c21xa252c2UxUnFNWEpjaXZuckZRS2Jo?=
 =?utf-8?B?SkdMejB0RDhCZllRdDNsbmh2ZlNiMFJCd1Q3ZlRyMmFCUjE4S21YWDVORTk4?=
 =?utf-8?B?OGcxT0JBY2V5OTQrV1E4dXk4akY2R2lGTTFRaG83WWthbU1tOEMvUThXN0hE?=
 =?utf-8?B?SjFpMUhOM1ByMmpuVTRsU05QRFlZemhNMXJUR09GSFhuSGc0WTlwSkFFRE5G?=
 =?utf-8?B?aFB4WFRTL2NycDN0Q1FyOXNTV04rNm1wb3BqU3cvVHJTdFZrNktGZjBUcHVp?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cec9b8-9355-437a-610d-08de02c3c356
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 21:28:15.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJag6WuGjR3AapB37joAU/6xpCJh5axPZveowlSRt0aQdxxczw6LR1/L697OOkMsfb40ApPAWOdBw029Wb2ozklsDXSW+b+63SrIRhUFvQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEC5C0F28D
X-OriginatorOrg: intel.com


On 10/3/2025 7:35 PM, Gopi Krishna Menon wrote:
> This series fixes htmldocs build errors due to malformed tables
> in the zh_CN and zh_TW translations of cpu-drivers.rst.
>
> Changelog:
> - Adding missing TOs to the relevant maintainers.
>
> Gopi Krishna Menon (2):
>    docs/zh_CN: Fix malformed table
>    docs/zh_TW: Fix malformed table
>
>   Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst | 2 +-
>   Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Both patches applied as 6.18 material, thanks!



