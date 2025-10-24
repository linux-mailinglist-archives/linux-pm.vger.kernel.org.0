Return-Path: <linux-pm+bounces-36805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DACEC07C75
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 20:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4339535C6E8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB73491CE;
	Fri, 24 Oct 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JT/T6b/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488C2749D6;
	Fri, 24 Oct 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331071; cv=fail; b=NG1orq7CnQsd264xB0dtiMUGopiDa9GYRDSBWL+xTjWIpfKWElRs4ipjKSMK7osYUMpDSj5JrB2AJvind/OtJxA+99VIPNeYPNN+56F9R3XLMAfmyPGdSJDUew9oqdJSkTQOrkVm/sWU//G4blksaZsD9EnZwvHZLIuwyij2xU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331071; c=relaxed/simple;
	bh=/nxgrqfTg7uKHJslBfLercfjwdcKtGA/zpK+7ps88wU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ebssJ+Te2m2LMVtdRzHwdtgVx35Nn9aYd7hIpDW+tPM8fDmGAA4KuWdR5NVb03mcTDm+HBXLft+DlFncaarw3LdhIaReDBAU7CQx3rXQr1RyhacdhTMLgbDe86XVVcNOzgWyOTItR21O3wvV4tn3B2GGkIyoIWwYZPzbRcfVqgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JT/T6b/W; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761331069; x=1792867069;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/nxgrqfTg7uKHJslBfLercfjwdcKtGA/zpK+7ps88wU=;
  b=JT/T6b/WmJAYkUZme3kZtLhadgH+n/Zj0SezMKf1HOLATJAr6d2GftsP
   FE6+uP3D8UX+VQNZWgKeMUCOWaWEv0oWXU79r8+hOlyurYnANLoFcoUOV
   RQ1CiHLxBKhc2TC60gJpG+6Pcn8354W9La39x+omr7Eb9WxUd7rMDANbR
   jVbcM/2wO8J68DzvI86Z72QJSHMbEqpuQIPuZa9R5/cNbO3sBVpaofsPw
   zqwTy6Dvg7FVV0w2hK+J9n0fUoQCbv0ZQ7+3IH0kibI8yPbu3jHeCYqLM
   z+AOxA4vQhmmahTvCzqE/tU+aj58f9Sr+1mwkVXawXPRdL6gWOprXcQVf
   A==;
X-CSE-ConnectionGUID: xPy5aa4rS1WPjjax1aCovw==
X-CSE-MsgGUID: e6xGsgiKRPC4qEG1QB8JfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66132444"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66132444"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 11:37:47 -0700
X-CSE-ConnectionGUID: SCNPAN0TSqKf3D5xFmKF+w==
X-CSE-MsgGUID: FCLtk+HRR9OcSQOM8GMtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="184203813"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 11:37:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 11:37:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 11:37:46 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 11:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+nhP2jEq/euVMoaJBK0YEyuK1Bt38jj1E/GNCh61RGXJARfV7ti5d0vRJ4n5+SUI38UJvwwn5Sa9npW4+yyfw++yt9u7k5W/C3Yo7hRTYyEpX8Iui1Vv0/agVQy9rPZOmYMeYlTZrHb7/3wqo8hniBqibmV0SJevsVhAnJo3ybiTw6wOS1c/yQHkAMDnCoFeO8rS+1wZGjnVIsgqQ/QFJqPXuoAfbd9/PU5QYlL0yi6gqlvASrPwdh99j/GzKoywf+COb5l57x1xHU3Db2wSilv8Vum59rUgH9sHpk8dKWCowRcvGS+ZYbm0eUHZ3seyBuo0fkNTaebocVz3CbPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhSjLi9OcwznAnd+zg5z43m55nCW+Da7OJkpokOmURk=;
 b=LobHAtCa93sExb7HleHDyiksvbvLJamBZdIaPPhv67b3Xk9KpqlaL8zjicu7nUeDzjhgXrdmtSph8s+UcrOsUvqdM7tWy3yENEVeCUkkW3AsfUliRfosh2432HMMTQrNX/uwhHAGYEFCckZM9ADWKj8r/fhNeiJai2YGF2w6wg2Ww7xXV04g90gXiz0hATOm5gmhq+6r7D+OwmDHiaatS2h2MRGV/YudQrq7M2VepWzKfcI5+pzTS1vMEWHAB3f4lfwjwB7UNQV78D2Ts2nZypeflN8XvZshy+w/h+tFI7MgGfu8tV3YC2V/BN4llXsmjus8fHiC5JqXyb1No4JHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 18:37:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:37:38 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 24 Oct 2025 11:37:37 -0700
To: Joe Perches <joe@perches.com>, <dan.j.williams@intel.com>, Ally Heev
	<allyheev@gmail.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft
	<apw@canonical.com>
CC: <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm
	<linux-pm@vger.kernel.org>
Message-ID: <68fbc771199cc_10e91006d@dwillia2-mobl4.notmuch>
In-Reply-To: <df0d47c9ca7e984a38f56c6f0ca4696cd4ff1b21.camel@perches.com>
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
 <769268a5035b5a711a375591c25d48d077b46faa.camel@perches.com>
 <68fbc211c59b9_10e910034@dwillia2-mobl4.notmuch>
 <df0d47c9ca7e984a38f56c6f0ca4696cd4ff1b21.camel@perches.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3eb887-5b2f-4c20-5950-08de132c6855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVVwN2FKa0lvbEU3bk9vUmNRQlE4NmpHZDdCSVJvMnU0WWVGZ2FXN25jUmVI?=
 =?utf-8?B?YmVqNXJVRkkwU1AvRDhCRitXdENxdXk0RGIxdE9KQ1NGS0VNNDZseXdMNU9o?=
 =?utf-8?B?SDl2V3ZucElaY0paQmg4ZXVwNWlxbE51WHZhak5LaWtLM2k4TzErZlFmQXVm?=
 =?utf-8?B?OFAyYWdhNVQzVXdTWU5qYVUwODMvQ2NoSDBoZzBIOE8wbDlmV2VuYnN3SlRN?=
 =?utf-8?B?cCtYL3g3Nmt6VXZaUkFqUzdXdHhEOE93MXY2dlVXalBDNWdXV2RBZ1l5OHYx?=
 =?utf-8?B?eU1jVzhaMktKeFhWaUo0QkZVR25MU1NNamJNVjN4cHBKbWgrb1ovTjVGRWJX?=
 =?utf-8?B?eG42QVB0WG1sbjhjQTNoSHdhbkNZQ3ZEZnIrRXdaREFQb2Y2aHJKRFo4alVW?=
 =?utf-8?B?Y081SS9VcklYQ1RBTUVTN2M5Ly81V1kyRThsaUk2eWdubmxqbW9hWnVnQWwy?=
 =?utf-8?B?WUVOMzJUdGcxdHQ2NjRnODdGZmh4am9HWnFsN2c3YkEyWkgwOGRBcks3ZUlj?=
 =?utf-8?B?SGFSdnRCZkJveEh3bTIvY3BzSTlLYTNkZWg1VTZyN2p1WXlDbWdqaHNEdmdr?=
 =?utf-8?B?RDZEYktSNW5HK1lDanhEOUxQSVpwKzJaQU9YV0dPekxuenZHWjErK0JMUFRr?=
 =?utf-8?B?Z21GNXVrdUkxMkVGRUNXYVlOK0NRd1V4ai8xTEpuUXpMQ1FJWG5OMWwwNmJa?=
 =?utf-8?B?NEw3WTUyQXJQWjdYQUQ5ekg4U2dpbE1hL2g4aVZRWktoaVFhS1VJb1FjQlJD?=
 =?utf-8?B?MGxQdGZpakh0SlV5Ylh4WEdYbmpodWo1cE9WL0hiNlRqT0c4czhyM2tEdzU2?=
 =?utf-8?B?VnE2czVhbHZrM1Axd3M3T3FJSks0cWNjZGpBbXEwSHpVZXR3elp2andqZjFy?=
 =?utf-8?B?cDhRNkh2ekhzQ0gzOWtEbFhPeEZmUUZ3MG9vUzF4cGV4amRCQWw0d2VDemRv?=
 =?utf-8?B?Y3lTSzN6d3ZPSmpKeGlQT01aTGNnRERqRFVQb0NKWUlYOWxIZGpkVHJQd0Ew?=
 =?utf-8?B?RUNuQ2VWOU9YRk80Y0VJUU12UGVCNk5xVGpqc2VHWUFJaWdIODJVYkR5NGQv?=
 =?utf-8?B?RENUTmpYbUhIOVJ4azA2aWVySndJL2FLVmVoRnpRV2FqVGI2OFIvTW1HTUpC?=
 =?utf-8?B?OExBblVHUUpvTERibURDRDk3akFJNmQyTWVBYjl6VUZUaWZ2bVJrYWlaaDlM?=
 =?utf-8?B?Y0VxOXZ0RFErdHRkTmtHMGZJR09JdEc5NndrY3FoN3ZOOURwK21HRCtueU5S?=
 =?utf-8?B?Tkx1RzJwRnlWSnVUTWRhWEFnUWkxRm9CQzZLekxuSFdqbk9oaEpIb3M1bFdC?=
 =?utf-8?B?bnFHM0dTRDBpNlFDais2dmM4M3dHZ1I1aHl0d3FySDhpekl5UVZaQlBvNHRo?=
 =?utf-8?B?d0tzaDZzQk1NVTdQSFhZZ09CdFd2eHhESlljTERCSWd5Y2RURFhFZ0E0NEtQ?=
 =?utf-8?B?MFBhbkFLUWZYVEdBZDA3Z3g0SmpuUEhFdzUrOGhhMlJxVUFjcEJNa2VnMDZr?=
 =?utf-8?B?cllTVDVPRjJMdFQrbnBDVFloSEtLbGJqWXoyQ3R4VlRqNG1rZmN0bWxkamp2?=
 =?utf-8?B?ZlE2cyt5RUNhMVAvNzdvMDBCbDRPaERBWGRMSWMrbGRSQVlLOCtUdHhtZ1pr?=
 =?utf-8?B?dURMbFd5Q3pYZXdESjhpK2VESDVpa2g0amREcnJqdzlCZWtwYTFXZ3dVZXhD?=
 =?utf-8?B?Mlo4ajFCRGVsZXR0M2l0NDZzaGJQYUdzTDB1ODJmQWxtZHp6SXJBUFVmSTZ3?=
 =?utf-8?B?NGlsOEpTaEV3K1hDUXFVZnppcVhxc1huR25lUU13R3d6T01ua3cxSUZJdHVB?=
 =?utf-8?B?NHA4bTlOZ2F4amUvZ25TU0ljcHRPVXR3dXhNK2o3MDFzOU1oUjJuNC94enJs?=
 =?utf-8?B?YzFXTGRMZ2ZwdmdoWUR0YTMxWC9jaHV1RFpRRlQwYlZ5OVhHbGNiMW5nVmo5?=
 =?utf-8?Q?4O3H9gTvb22yN2eo1sexnQneup7LqkPN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ViMTZmdnFIOWduVy9PRFNaVHhTb0dWWU1ZUHZjVnI5VTJHZCtPMzVNRUFD?=
 =?utf-8?B?RHNHOW1FeDRObGgxWnpKUkdSb3I3alByclhVamlHZExRa2l5SncvSUVTMmZr?=
 =?utf-8?B?RmYzL25tZS92dU12VnJNUHk4Y1ZLb0ZFemM5WTlPaGx5dXFhT3Z2bklqcXBl?=
 =?utf-8?B?OFBJYmJ1ZWlpaDZheDU1SnpjVHRuWTFmM29KZlBVWkdtSjF6ME5uQzAvK3dk?=
 =?utf-8?B?d3QvOTVUK2N2R1ZUWG1UVmp3SUVJdnlPbWJFdVpJM1lSblIwS2I5Vk43eXh2?=
 =?utf-8?B?U1VoMEY4dHBGWXV2dm02OVFJWVhMbzh6OE9tTXRjeEJVY0FuQmpNUVNJQUp4?=
 =?utf-8?B?WE55S2k5UGkzdlpmd29JZGs1QVh0T3dZK2p3UGtVUU83NElpZzdRQWVxVVds?=
 =?utf-8?B?R0lyVmU0cU1UbzdScnpCTG5nNkMwdG92UjRFUy9vWnpHd0VTK0F4S3RMVHhz?=
 =?utf-8?B?dGhSV1grTmFWUkNOYVJiT0VBbmJ0Q1Z6RStOL01wR3Zid2JSemJpTm5MQnBk?=
 =?utf-8?B?ckI4NnJiSzQzSG1Jay9hQzEzM3Z5YkJucGVVNzh3a1Z4UURlVjhtOWxRVW00?=
 =?utf-8?B?VFozOVd5SmhJVkpsdnBnb1FMZWxkQk5Ua0N3eXA0Zk9oTWZxbS9NUmFyYUhM?=
 =?utf-8?B?djBtYXhvTjF4Q29ncnIyMWQxdE0xb3h3MjMyVE9mdWRBR05qamIwMjVJbkh4?=
 =?utf-8?B?VWgxNm5UVWJEMXpkNHZaV25hOTBpM2c2TVRyZzQ1SFA3TUtadjJ3cjIwUnpy?=
 =?utf-8?B?dktzWlU4UStyRjQwLzJQRFhrdUNQMFRmSDI0bk5hajRlZ0p0eTJoOWZ5cnNK?=
 =?utf-8?B?QnlpTThrMzY4SmFReE5Ia2VYQ1hvbjV4N2haY25zWmdrOEtoS2FwVHRSWktz?=
 =?utf-8?B?VHpnU0xZNEsvbzJ4R1RNaWJBNjhvZVRkbXA1ZDhHU1h1YUNrM3gyOGYwRTUw?=
 =?utf-8?B?b2tjUlJ4WWdCQ1VsaUg3Z3BzL091ckJQZC9Od0VSTExyQ3A5RW1mL3p6b0pZ?=
 =?utf-8?B?c1VFSlhPcmZqRS82d01tZ1FDbk1OanN3bXJjbGNhOFN2dmt3K0E0Z1ZlQ1Nn?=
 =?utf-8?B?L3pXeXU5Q2lEN284SHBSUWdJNFd0MUVmdE4rTGMvcFBFUkplZGdtNTRISmlW?=
 =?utf-8?B?RHZ6aGxLOG9XWmhDSExCdVpNL2ROM0xuYWZXd1IxS2lUa1U3QzJhMTlIUUJ5?=
 =?utf-8?B?T1QxVkVxbDNKK1lZQ09Ga25tSkhHLzdGVUNyS1VUZFBtcXM0ZytPUzR3WG1C?=
 =?utf-8?B?a1B1dEJEZ2NCQWsvSk5QaUlEZkdnQlJpcGJYUExYdkprNGNmcVNzUHE1blBQ?=
 =?utf-8?B?cm10L3lLeFF4Rm1mS1ZhRzhxQTBDQ3VRWGo1YnVPRU1FcGRYTjNNRERyY0RH?=
 =?utf-8?B?Z1pvTlcwaTg1RGp1OTZXT0JhMEF3bTZlM2NNZzJsZzIvU1YyMDhkUWdKNkVF?=
 =?utf-8?B?bHJYYkh5VEh1TWF1ZTc1T1MrbkVIcCt4cVk5L1NaSHpNL1praDlpNSttYmVS?=
 =?utf-8?B?NnRrb2phMDN6WVRPYnc3M1RTYzQzVFVpRFI5MmZqQjlrOWRuUG43a09OTkxo?=
 =?utf-8?B?ZHBIYkx5VG1sOHBFd0NMbkFBbXdEQlVWa0k0SFRPRDdrcDVueXdUQVFjM3Bz?=
 =?utf-8?B?SU9KeFd1L3lMRmhIdWpyekJ1azB2Mk5mTmFDQitkK1czZldxTVgzT29ib2Fh?=
 =?utf-8?B?UUdQemorUnEvSHYrK29ESS9OTmVtekxFd0o1bHRPWkxTWHFtUzJkK3lYT25F?=
 =?utf-8?B?Ti82Zm1BZHFYYmpuSGNvYUtReVAxeklFU01xUktaSS9MQUU5MjF5OEwxUkpu?=
 =?utf-8?B?bGo5Z05iRWYvdC9YeUhRSlk2WnhldDNaallQYlpwVVBuSE5VZDdVakY3Z1V1?=
 =?utf-8?B?N3pPdlQ1MkhtR0JLVGZkNlVuK3p2OTQ0eHVHd0J6TEtFayt1YzFEMFlTWG5Q?=
 =?utf-8?B?c0RLQ1B0SnVKZ0F5Y3FEMDBvQmdTd1RadzQ5a1JWUENtZUFTaGdZak53K0pZ?=
 =?utf-8?B?a0JiQVBzSVA5dmIwNHlUNnFzQXJFK1ZGbHA4eHBBdXRmZGFiV09wYlNxV0xp?=
 =?utf-8?B?OStiRlJFR3Q1UmJTVXArL2R3aENTUWdZcjR0RVVWRy9tVlRiZlBNc1plKzlU?=
 =?utf-8?B?TXlpU2xSSVhCbE5XcFZUcWJTTXhCSzduMEx1RUZhN1VOR0UxUHFhVkFRQTQx?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3eb887-5b2f-4c20-5950-08de132c6855
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:37:38.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SU6k5zZWnqcVpFLpCGjH7oMwDJ0yqLogi1qMMhlAKj8m3cdgTRaTFThBiWO94F4SuUR3BtA0TNyir5sjN28r9zuuVF2i7D1jrs27heqP4KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com

Joe Perches wrote:
[..]
> > > And there are a lot of them.
> > > 
> > > $ git grep -P '\b__free\b.*=\s*NULL\s*;' | wc -l
> > > 490
> > 
> > That is significant. ...but you did say "almost" above. What about
> > moving this from WARN level to CHK level?
> 
> I have no idea how many instances in the tree are inappropriate.
> Do you? I believe it to be a difficult analysis problem.
> 
> But given the number is likely to be extremely low, I think it should
> not be added to checkpatch even as a CHK.
> 
> If you can show that the reporting rate of defects is significant,
> say >10%, then OK, but I rather doubt it's that high.

Fair enough. Ally, thanks for taking a look.

