Return-Path: <linux-pm+bounces-6247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD28A0036
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 21:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9555A1C22933
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016E1802D1;
	Wed, 10 Apr 2024 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StgkYNHN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2A134CC2
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775664; cv=fail; b=XnW4kzpBSNo201BzoxN+WfYiqQoFtyHoT7hi5H1Ah5EtARvhICdPSBKo9/ms23IR9NuL2bE4kGaewhAXtHjf9JHtren9BmqEkCZoRy5y21ZaHlTUU5avnE9YRxlWdtxaXO82EJrgyX8/wGP7cP9FG0pTUpGNk7P/oMRYjw0Dri4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775664; c=relaxed/simple;
	bh=w7hveQJ3gR34QEXFDc1KbOTRp5PWomJW6V2+8H+/N+4=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EqW9tXdGKMSlIOSS+iHqkA+w70M8ERDrSz/RzBz5RY8wcmpv4+VRpvZFJU31LCisaPRS8fWTGHNvTye2jy72l9/142y30ky+Cyi4q4v7HxkErb68ZV0yzEXe0OcXSLXOZRnfG8oe7SumOVJAcL6qoEUsbMUhB5X0bnwYXtN/Ul0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StgkYNHN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712775650; x=1744311650;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w7hveQJ3gR34QEXFDc1KbOTRp5PWomJW6V2+8H+/N+4=;
  b=StgkYNHNH3k3yu3k1Rd83pApY/+rlYuk0ooJM2+a8RBS0gJdM3MB/o7u
   F360gT3Nr0DQlpFOcR0tmNrUEriprfbnMxYIH5xgykxtNoW1c87Khok1+
   2fkADgHy5IRN3sLPbgE5KomZUgU8dd7IX87eaQj05hFzmvRLq8nOqsUk1
   MPiyKLW4VA6x4vmgAkETc67qgYlf9bE6y9ELJn94d0oKtWyf3KJOUGzZp
   Hpzk2Pwxhao3qIIlwXiA4SQ7WHgp/GB93TUf7gpDB8mD2V7n1uSPOEbOl
   rPWXmVavkawafA4K5xzHGviSRdPff7DyOlyq8Ani0EHfPbLsCaXQhr+Lt
   A==;
X-CSE-ConnectionGUID: ac0YypmCTIiwV1IWYv6IEA==
X-CSE-MsgGUID: iVfqHEINSQOgV+XReXCcPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8022777"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8022777"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 12:00:11 -0700
X-CSE-ConnectionGUID: ite+0Y8nTeOZVFuzeVIc+A==
X-CSE-MsgGUID: eLb4cpiyRWeHNCoLkIBBbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20663757"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 12:00:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 12:00:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 12:00:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 12:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXsPZ5N+wQjacL45vKiUkZj3tBIYuKU2FLd2P4j/z7811MKU8IIXHowjIfxnXyEVWONHVDcczlJjk7rrA15yPL5qNJlE/5gNLXmThO0dWujMKD0qNl+RfTONnirD2frHLjQBQPW6py7FQeakO5+TwS8KMWG6w6svqvHIaxZ/lxOm9BgduG0M7wijmbo+1WyNy9KCfMerrW3L8baBXFSeZRhmU/dTLBtggXFEOwf6Ih8JtR0I8wgUfCFHMC0QmQyCxukocnXAR+ICNffe4rNvhkMv6yyA88RPpBSzb7zFGCakxsqxqOXzAI36Gidmc268xBMBdHFI6WYHBuDC4sOH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YH1SCuumXWRdJ/FV5N4DOxVM+54PYtgyWFNuYA6hR8=;
 b=DnCi1R9MhSB6U7zwbfW1LIEtvF1Ezd3sh2+vvdNURiXSy0M6gHyK7J7AT+1P4kT8qOIcttHvD67/pUnbUXv//dGGgXSiOuJFli8VrASz4Jf5YUqjBSYJwXjIiWY+QiWEs1jEcDb23YfX2YiuAxh8SMpckurjAnHvqRPdfsC5wKWwqF4bpWHOkVDbt/s/UljNsE7AXuFLAriXiTSzcCCsEYM3zeD+zCS7vvj28z+lJ6jUA1QPJROEekN+GHjS8EYtTtLJJ8t5cEvptZ/BnEHWvObAH/3fvGWUhGhO5xZySlRGtpZH9RIfuChxRMHzUQDUEfgfrPRToeJGj8l6erOy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 19:00:04 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::85d1:70d8:4c39:4599]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::85d1:70d8:4c39:4599%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 19:00:04 +0000
Message-ID: <124e6b11-ca62-48dc-9401-7932845e19f7@intel.com>
Date: Wed, 10 Apr 2024 21:00:00 +0200
User-Agent: Mozilla Thunderbird
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: Commit 0c4cae1bc ("PM: hibernate: Avoid missing wakeup events
 during hibernation") prevents my laptop from hibernating
To: Kenneth Crudup <kenny@panix.com>
CC: <chris.feng@mediatek.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
References: <cb5d3388-3d2c-42f1-9e93-026d14c7e827@panix.com>
Content-Language: en-US
In-Reply-To: <cb5d3388-3d2c-42f1-9e93-026d14c7e827@panix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::11) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SJ0PR11MB5117:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ui1jDxRr1aRkDNl5ppuBZj0OmAPGLl9fvFDGQJcbqPk5JZkJ7+x0/1TE48zlKvIQdPjByeEuYE6pccBxriBmueEJNZ4X6bRunIwBh0OWpNm6eoSLiWPMAUGxrKueIaghRQWhsfLfyG0XmDTij/fBG6VOH1FrJI0UuDKWrW6XZx5R88s9JX7UA6WtXllGZ3YELQOFglGFyTOB5W7nfQAlmH300K6ctu9h4jI81gsPUHFAQH2EgZGBYJSlJ48/IHSrKbD+5HXG+zjnVpwa+BMXdEYSFC7H+guwECdm2MP39fdgYaIEEL8LrcKtsAD8GCVArgD7ftju3IFHSWgIic/unSAxuIFHiQJbM5XPCo1XID11aoESODzqIT0c6uIrn+3b57ztdjU7oE4I4lrAg8/tYjzwXV8ZP+TjJDqEWYvzaN+z9p2PkRfHBJjsixErkLAsqYc2X77KY1EwwQG8EjKHJf1V3QSCumYcZ7/U4lvKIpO1/AuNTOWsK/LY+jUjwPmBNhz75cFR69jkA7tsRnKHf74DfKp5b+J8hkuo4g2M75y03QF0150RhWxk0uK0py4PIvr3wA5MEW4jjEmUdfAbsefOhuKPxVUja07CiAJHJNAHgCigz5vNBXnPygGPxgKnMizrQ2PBCXWlnEW9hXXbj7Npg65LFxyyxEgejuMfk5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2N2SFBwbUZzYVUwMmNCVXVtQkJ6YVlaNmNzQUtIZy83WVdSczhSRGRlMTUz?=
 =?utf-8?B?dGxTbU51L2Fua1NZTjVmY1pKdW1kYlIxUDdkcm93ZUkzbWh6WDgwc2JJZkZ2?=
 =?utf-8?B?ZHltUUhuc01GRlJFckVKV2NWbWtBWGlJUlVSY2FUMGhtMElmNmJjTmxPWW5U?=
 =?utf-8?B?cWlyN0pLNS9EMTFOanZXVVE2M2NzL25pNWlBU3BIcFZkZ0pWS2F6aWtlUXFU?=
 =?utf-8?B?aEFjL2VxNEJzZS94d3RRd0h6ZGdhWkEyYTd6bEFYd0NoNVVWMXllSll3ZXpM?=
 =?utf-8?B?SUJvUWs2aUUwc0tTOEd4anhhZTZiKy9ZZm1DUGR3R3NBSjMyZE1iZTlKekFv?=
 =?utf-8?B?UnltRC92OXV6bTNZRkZXdUtyMjdiSk9Zd3g5bzViaG45T1FNVGp5bUR6TnJW?=
 =?utf-8?B?ck9ReGVORzY1cTN5VlcrZHo2NFpRMm1HcFFKS3FLeFQvRnZXWmR3NEhBcEY4?=
 =?utf-8?B?citwc2puaUduQ0piQU5TOXd6OCtsdzBzNTNBR2tnOExzWmgwcllOUEYveGRY?=
 =?utf-8?B?ZitXbHJCNGliWnBHU05Sa1MxVmdGS3phcmQ0MHVjUkpzY2xuSkNMeXhQVFZI?=
 =?utf-8?B?NVVMK2phVG5Xb1FCbjVQcGFQUmF0dGlmTTRhKzNFMDFEbWZYdFBhbUtQOHh6?=
 =?utf-8?B?bDFaZ1FhNWMraFdWdUZZQVliNFFMd0p6Z2pqTlByRWFuSitqWkpXb1RxOGJt?=
 =?utf-8?B?V3VqTjJ3b0p3MWZOQ1ZHSjFaR0RIVllmMTNVeUdqS2k4aDVYWllTam9yYnFK?=
 =?utf-8?B?K1hNQkRQMllZcHpqQnBHTG9vK21SbkFlTTd3Q2hrTUZOeGY1REY2dm9BY092?=
 =?utf-8?B?bWhIc1kvSmVPQ2RUQno0M3BFY2FzWjZBVVBMODhsTGwxQU9CZUFIN2RXU3F1?=
 =?utf-8?B?dG1Ya0NJNHgrWDgySlpRQjNWRE5mdkt3MlZBMVZPMTFDaUgrWTlKSlBHNVBS?=
 =?utf-8?B?WFhYYkFpbjlHZjJUK29HK1ZNY3g4cnlSdENvazBTWjBwYVVsVnFoUFFiOERM?=
 =?utf-8?B?N2ZlMkM3YVEzU1ZMdkZHdXYzSVRHYXNSdEdWdVVrSkwrVmtwcm1MSHpvbFgx?=
 =?utf-8?B?RzFFc055SW9RRkw0WGtVaGtOZ3E3bU5nMXJjeHBsYU1LWm92c1Zock9TVlNI?=
 =?utf-8?B?bW9hOSt3dlJGMm1wUEdHb2sxK2s5VzNOY3V5NEwwL1JPWWJnLzRQZSt4QkJ1?=
 =?utf-8?B?a1VVRFVRN04wcnB6TXpIaWpqN21xTmJwcVRYTmppMmpMMEI0dzVIU1NZYTY3?=
 =?utf-8?B?ODdjNW16ckZvNWFOZnVWMHBwVy9JZlhTdVJ1Q25pcDlsTmY1WlF5SFd1elJB?=
 =?utf-8?B?eUQvS0t0ZFhQdStwbkU0b0RZWTdWb2tPbytjN1Erd29vRitYOGVlRUZZZ1cr?=
 =?utf-8?B?RzR1S25JKy9CWENFK3h2VjVadnpyWk1kUEkzTHZPYkVGN21FRHlteVY4bVFT?=
 =?utf-8?B?YVFnODEybDlOZElCc3ExcFZjMTltWVhYdndobXl1RnBJbWVmZG5jRWoxNS9E?=
 =?utf-8?B?dW5jclNJRW1jR2YySjJnSHNaSmVQTWE0WU0raXIxdXorWUN0b3FuRWQxNTFF?=
 =?utf-8?B?SmxJR0hRL1A5c1F3K0N3ODdZV2ptb0xvU1I1NXVOVjJLYTEwS21vb09Jc0RM?=
 =?utf-8?B?a2NBOVo2NCtWT20rc1F1YmNyUkl4Unk1UE9Sd3BtZS9hOXUrMzloL1ExUllh?=
 =?utf-8?B?aDc4YTk2ajgxVFNtR2JvOFQyN0hQTDQ0TW9PWE9iL2Q4aVRIOHJTOExacmlB?=
 =?utf-8?B?bnBkSnR0dlk1dU5jazJmL2o4TmVLbU1pNEhVU2NSQ2c5RUhoYWRSYUlHQWdn?=
 =?utf-8?B?V1VFNzN3T0Q3Z2lCbGRMc1VqVUZNdkJvV2lEbjVsaVh4RjUyR0NCa3RTMklo?=
 =?utf-8?B?OE56MlpBcHpZNm8xaEQvUWd2S3Ftbkc0TW9iQTZxUUpmVCtIZnlKNTRHZGVD?=
 =?utf-8?B?cjJqN3hsdllGVXZpRVNLaFovZnBVODJXdkhjSWxJKzI2MGxuVFUzMTlNa3pw?=
 =?utf-8?B?akxEdUIvNG9sOVRPMVcxd0c5MFVFMG9TZldqa1dDbDhudW5VaEMrS2pWVnVp?=
 =?utf-8?B?b21PYThFT1gzQ3JLcnJBb29uVEhXUWVHT0d0bmhqTktPRENTTUhWVjREM21v?=
 =?utf-8?B?M3ZzOTBKaFB3OXM1TlRmTGowMFJGRmk0OWs4YXNjTVB5OG1makl3bnUzQlVM?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c02efe-c632-4037-3368-08dc59906e68
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 19:00:04.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9VNo3vZresxcX/ef5tmTiXTU46Qd4UU7M4Ye9qZb0uM/DDHhMxVc5SjcQ7i1QZV3hkw/c+Iyl4WaPCLeSDmDakJG2Mm2EP2QaxvJsVwSd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-OriginatorOrg: intel.com

[Resend with the linux-pm address fixed]

On 4/9/2024 10:40 PM, Kenneth Crudup wrote:
>
> While in the process of trying to fix kernel 6.8 hibernate issues on 
> my laptop (including bisecting why my laptop crashes on resume from 
> hibernate on my machine (a Dell XPS 9320, i7-1280P, and using a 
> swapfile)), I'd determined the named commit prevents hibernation from 
> occurring in the first place.
>
> Are there any other reports of this?
>

There are.  Please see

https://patchwork.kernel.org/project/linux-pm/patch/878r1tpd6u.fsf_-_@gmail.com/


> What do you need from me to help fix this issue? I'm assuming that 
> whatever (pending?) wakeup event that's causing the rejection does not 
> seem to hinder previous kernels from having sucessful suspend/resume 
> cycles.
>

If the patch above does not address the issue for you, the problematic 
commit will have to be reverted I'm afraid.

Thanks!



