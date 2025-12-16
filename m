Return-Path: <linux-pm+bounces-39637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFECCC46CF
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DF62300444E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD231D759;
	Tue, 16 Dec 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kB/ny3GU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611DE35965;
	Tue, 16 Dec 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903875; cv=fail; b=TOjP6E/C66lfDXwptbBiew3DwzVj8D/5AEm5xOE/rzUFa9HlA2elLGjaPKVeLJDPBmqm+LCFvg7ioTsED77ePNcE5WFCLbceemfRQwQSggKlFrIli+HyasDqyuP4SJOnrVeKxnAHxAvjk6Vhf13TrUkpmmuDTAlFtyH4TfduKXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903875; c=relaxed/simple;
	bh=tm5EGqiQ/ldKSIUojwYWMIktuc5w6SUTBKTWzbnGh3I=;
	h=Message-ID:Date:From:Subject:To:CC:Content-Type:MIME-Version; b=W57Nhnt7biSaCycFvWsv5DTdSSx4DqehjpzYTbYOnNwW7HUDupTkAvROV0ATYM6uwUFIZbuexPj8TWcKB9KTkzpLUUWOMrgZ8Xi/RYpVe+VxPZsGtaDhb8OCCpP/RVjiUwAXz5yWDu6R2mEw2KeFYuTcRa+wRWEAQT0mrATz6Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kB/ny3GU; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765903874; x=1797439874;
  h=message-id:date:from:subject:to:cc:
   content-transfer-encoding:mime-version;
  bh=tm5EGqiQ/ldKSIUojwYWMIktuc5w6SUTBKTWzbnGh3I=;
  b=kB/ny3GUTsLQR3nivNw7H8+DzmQNxw/skZsPnxr1xfTFMz1BnThJrKxE
   3TZY1gKZOr/RHHck1Vctw+XrlD7z60WKQmBN1IcwlJorBrFTPyeoUHaFx
   dJfkGLlfCZmN12ZF4w+zTiI9+Rjlk34HsOvgUP85cGPxXLJANdaiy4agw
   ec+DqK4jsthvyoHmMZP+f2+WDjmkGQ1VeJv+xtJ124FdxYqrx0FrCrMvC
   zlo4ceT4alVAeHTv7hU9TFyXVGDs9Z8+3ycJkRKo4XDwe17fCZrDVaTKZ
   SqjdfmXoPjfJWSdFIfXxB+V81Sy23TH6z2DOc2I5cq4Nze70Wnky/DBjc
   g==;
X-CSE-ConnectionGUID: eUprRN5xRiyyVvH0VmmTbQ==
X-CSE-MsgGUID: 6XUMK3m3T26sIfnAFJfBZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="78539587"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="78539587"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 08:51:13 -0800
X-CSE-ConnectionGUID: PPjzZeB6QgS6uXNcL8wusA==
X-CSE-MsgGUID: aOdxOgQXSRSuD/BX01cjAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="198318441"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 08:51:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 08:51:12 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 08:51:12 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 08:51:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTtKsdUZsN4lAXVca7VWlC1zUIRl40ZoMKgX4a0BHDzO/4pYSS6X3eg6gl39amA5jd3CotqmjXHwONqs3+OEGunQ6IUwe8B432A4ydv5OdR2YLnvbUM23rEVGZT8Bulrsy8i8Jh/rSP0Ls9MQ6fhMw4ffS2vlZy44u4J2xpS3xSbYu+JvR9QWh1BIvysGuKfpFqK4JP3/xVPuYHesgl+cBey9OmCNzP3f64FTxFSfyUNQ3uvBkDn/R40Lxp2HoaUh86fbOp/pyDXlvI+uJf/WubWusy2quOq+028Qb3h4zUElRgnN0MEflQdF4/Fsb6G7gGQURD4BE4ImJeRQZnMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMnzWxYsFCQhCRuiaRqw4cYe9t8i0I+sg2I/iiOH4kM=;
 b=yMCuBt77ATxhfpxeHKA10UfQlt3QvWwkxGhAbNKfOocUri/Mc9vxFEoN/VPon18kXgAUlrxwa/jm1myI6Q65ZF6nyO+HTmHUJE7CZar6K2SquqCvsZobOCiBLRNcZ/Hq7A255rz/BCWDHqBtW0pVGL9F7jBMIWrEdqbUmUw3LjgaVyo9q1Lp3iaCRs2b42DrpGBzKoa8OjbZhx+CM1c+SIp5q4ZDSWFGx1xF1GiX9+FbOwpmTYY3JgSZ4bPytYS16txsmHZcvQlGeosECD1BJMAfvUX7wAbBsMQLnyAI76hVwLNgTEVDQDzwm97LMxRLgxSuJLruM5pg92vkcHwWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by IA3PR11MB9087.namprd11.prod.outlook.com (2603:10b6:208:57f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 16:51:04 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 16:51:04 +0000
Message-ID: <5427ede1-57a0-43d1-99f3-8ca4b0643e82@intel.com>
Date: Tue, 16 Dec 2025 22:20:56 +0530
User-Agent: Mozilla Thunderbird
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Subject: REGRESSION on Linux 6.19-rc1
Content-Language: en-GB
To: <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <rafael.j.wysocki@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <regressions@leemhuis.info>, "Kurmi, Suresh
 Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To SJ1PR11MB6129.namprd11.prod.outlook.com
 (2603:10b6:a03:488::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6129:EE_|IA3PR11MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: f29fc859-4341-4cbb-42d5-08de3cc34d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDk0bFVLL01YQWV1anhPcitBVUgxalZDcjJZci9hTm9hTVF0ZmdiQVo1WVpr?=
 =?utf-8?B?T0VBMkNqbDRpNDd0WGpza0ZoWm9SdEVyNktmcW1Zb3FpRUtPajRyU2tRZW0z?=
 =?utf-8?B?T2FiR1RCaVd6T0pXd2NqL0xvWmNOamNiMW9iNW9hMDN6WE1XdFZnK3c0c1Ar?=
 =?utf-8?B?d1dKZ3ZrQUFjeStCMGlQaG84cFo1bkYwOU9MZEpTZ3RBN2hDYkxacmJWeHZx?=
 =?utf-8?B?Qnl5Uzdsd2EyVEdQRm56QWR6d29yVGdULzU5Mm5LVjF5a1ZvelFxNkRvdjJv?=
 =?utf-8?B?Z052ajZLRFVUSi9sc3FNajNzektianhDVnRQblRSZVVPVDBOSnppSzZlZ3FX?=
 =?utf-8?B?bjA1U2ZWd2ZpWXhVdTI2cWpEZks1dkZpQWhsd3FodGFITmR3UEJIaGU5TzBE?=
 =?utf-8?B?SGE4bGM5ZmJCaTl3aWxJTXFodXB3UE1aSVlJUXlEbFBqUXVLdnJkZmRjMDBj?=
 =?utf-8?B?TFdmRGgvM2gzTDJnb3lWWnNyKzBSOHNQOVd5L3FMcmRIMU8vS05iei9qUmNM?=
 =?utf-8?B?OTVlcVpvTkpjbEtiUGk4TEZybEducGdvbmFTSE92WVh6N0s0Y2Zxa01SUGNl?=
 =?utf-8?B?bEJYbXNYZWVodGJpZTRqV1RDbGZwdWwzRld4WlhJWlFyUDBvWkFtcjdsR2pV?=
 =?utf-8?B?Y0EwaFVoL3NBSmlpSCt3WU9pZVBwWERDTGVRWmh3WURJbTJLYUVwT2VZZHZC?=
 =?utf-8?B?Y1lyWHhOMFlOdGs4Z3pab0FlM3FHQTVVVDhRcC9sODhQZ1lLYjlLV0NXdGgx?=
 =?utf-8?B?ZGxBTzN1WU5NTzMwaWV3MUp4eUlIUXUrS01lNXBKSnJzZ28vZmRDZlRrOS9Y?=
 =?utf-8?B?cFVZRHVHSWI4T1RRMWRXVU9ZSlRmM0hnTndHOFdCdWo0c2xxWVRGUHpCS1BG?=
 =?utf-8?B?V2poWlhDbk9EeVRFLzkzV2V3N2d6RU5OaklSaklUb1FQZ2x2R1ZxK1FGejV6?=
 =?utf-8?B?bVpmSS9zU1AyYnFvSkg4bXZsTlovQWpSejlIdE00K3hvTk1pUHhmUFpLTFM0?=
 =?utf-8?B?NEFpRXFQY0QrUStuME13NTl5ejloZTdRMnlFYVR5a2UrcjczUkRRUndOcjgr?=
 =?utf-8?B?NFVvanJNTlhkdFdwTkt0MkFXVGNtZzA5REdNLyt2KzFVYkoyOU1STFllOGV0?=
 =?utf-8?B?TjNlanhSSk04aFMrODN5bUVMaWtDbUc2Z3ExOWxRV0VmZ3FkeXJzZCtWWi93?=
 =?utf-8?B?NkM5TGlOUWU2RW5iTlNpc1F5Y2lsbGgrM0gzSy9pVXRiSDd3R0JnS240Z2lV?=
 =?utf-8?B?TW5MbWFGb3RMejY0anZBLy9VYk5VSVNxaU1Nb0dNRFp1aGx0S3FETkZhVUJX?=
 =?utf-8?B?Vk4zc0NVZm5ybjZXN293cDMxZGZ3K3l3UE0yaWtmcU5oUStnZ1NCaVF6M1hw?=
 =?utf-8?B?NVNxNm5wSXdhREhHbld1ZWo3bTZyNGtMMVNTVzN5QUJvUnJVZnRCd2RVZ1Js?=
 =?utf-8?B?REJpTUgwZmRZazlScGxnWkxXWEpJNjdkSExNU1BtRHBHMVRsQWlCVEZ5K2p5?=
 =?utf-8?B?eFVvU05Eek9GRlRpTVVYQXY5WFI4L0hiK2hreGt5SW9Zejl0c3lVSmZPcDN5?=
 =?utf-8?B?Rk1wRkY4aXJFcUZ1NXNMZGpjQk1ZNTNmYjRFMEVRMEl4QzV0WlNlNFg3RVBJ?=
 =?utf-8?B?amxRS0szdTQzVUxpeWRUcWhpN2dIQnVqVlhueXI0QS9QY1Q2Y1VRalcrd2hB?=
 =?utf-8?B?R1J0dDhMejF2T0l3UXFJc3FMRVFvVVRwNTBXbXU3aGdlUENOL1pMUXZjZE1j?=
 =?utf-8?B?c0J5T1JtSmQyVHdQMTVJRjZYS0V3My85aC9ZWUJ6T1hRVWVQYkRZYzI5NE9S?=
 =?utf-8?B?b3R4OGVaV01nd21LakxSVjlOS2JFQ0RFQ2svRUFMdnp1SkRhaTVjNXhZL1Mw?=
 =?utf-8?B?TDRYcncxVUhjNjhrUnlMVzdYZjA5aGxybjRwU1V3Y0VaOGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dndibVRMNmNTZGVYYUp6QU9oQUlLQm1MVjBKNkkxRWZpeWNwTzlqRWdqWTFQ?=
 =?utf-8?B?V3g3NEN4akJjdmw5QTZZakp5b1V2cWlGN2NiaGFJbUh3VzBGS2NGL0QyV21r?=
 =?utf-8?B?UVU2TTBWeHMzdFo3VWprQ3lhcWpGektGTjVhK1V6dDM4SVl4MzJtZzBvK3lq?=
 =?utf-8?B?eEVUM0dBWndWNUNGY3o2SFQ0cng3NFNMSlZNRXhlVFovdjhTN0JOSjIvOVg5?=
 =?utf-8?B?STlhakxsODVYUlIzVFY4YnZzdFRWV0JNRjJrTjF3d3BkVVBybmpwOGdyQkZo?=
 =?utf-8?B?ejZxMDkyL0RCbHBRT2ZiWjBTZmlIa2F6Tmt5YXhMbDM2WEpDVDROVWJhcFRr?=
 =?utf-8?B?eHpSaGhBQ3hRRE9tV1ppbnZqQ1RYZUIzUlJTeXZLcFhpbXVJTkdUM2dpblA4?=
 =?utf-8?B?YXZYYjJaMFhEenQ3TzJoT1pRaks0L1pkRXU1dkZ1c0JoLyttcnFwWkVBK3A1?=
 =?utf-8?B?amhtZmtIUTk3SGlWZitjVmNNWG9ZeE9zbzNhNU5ZNXhIVkxxU0s4M3RCZU9R?=
 =?utf-8?B?ZEdPTFFUaWQ2eXQzUGhXTU50VVd2RUtITzhxK3BmQ2czcDN4RUJxOFppOTU0?=
 =?utf-8?B?SnNreWlMV3ZUaDFBSVhBRGJqNmV1TGRCakY1YU1WMSt0ZnVPMTBsVWl3ZU8z?=
 =?utf-8?B?aWMvRWN6NVc1NTI2KzVuU1RMYnFNTjhiK014MGNOY0E1SHRtZVQzYjA2aW9u?=
 =?utf-8?B?aTFpOG5kbURNRDRVSDl2cVlhbGtiOFdnTFRmSm5BVVJXUmNoQVpYSnlxYnFv?=
 =?utf-8?B?VGluK0RVN0ZuSUNHNWpzc3h0VVZPZldZc2JtSVN6RFhGNDM5SWxXODJwNmlv?=
 =?utf-8?B?Ukh1Y3R3VlF2MTRaU0JGT01sMm1hQ25RTW04M0FUbjdHVDlWaU5WV09iMFpx?=
 =?utf-8?B?ck4vTUFScS9mQ09HMGltOUNGekwzTVJsVmRmWVROcXpQUjVvRWMxRlduQVdw?=
 =?utf-8?B?MVBaRVgvSk5sbUNlMHJwQXQ1Mkt6dWp0bjltSUxMMmNxcGlldG9hZVZmRGZX?=
 =?utf-8?B?cU40TS8ydUNyLzZYTmVMbTBtdWREdU1yRmd5R1dBb2R1V1dUN1YzdHo2M25h?=
 =?utf-8?B?UUJIamUwUnE4ZGV3NUwwencwdkJ3K0dzdXV1cVEzOVZ5eWZ6cWJnVVE2TVNz?=
 =?utf-8?B?WTE0ZDRQNEgzQk42QUxLRzFRUDYyUUI3aWdFOVRXU2k2YWlOSmlNOW96T3pm?=
 =?utf-8?B?emJTY0cxdU1LWHA4WC9KV0EvNWp3aEZsS25pV2ZyMmQzU1VtV1ZlR2wwYUM3?=
 =?utf-8?B?YXhxc2VCQVB0S2JMRXkyY2NpeGk5MHU2bzY1R0dnNVk2b1ZtQU5TbnVPdDhV?=
 =?utf-8?B?bTlXUzBPQlRnTEZ4OHo1czZwUkt3bk40c3BDRlFESENUMWIyOWQxcGREZTFy?=
 =?utf-8?B?dGFPbHFIN0ZaUkJmQXJkNURUVTdHZ1NEUXBkaFE1K1dQRHpsclRSaGRXTERB?=
 =?utf-8?B?Qk5ZNWpYcUdjVHF1WHVGRGVydTdObks4U1lsQTkvMlVZcUpQclJSdFcwYWk3?=
 =?utf-8?B?VnZkZGVQcW1pbzdmUUgyay9OU1F0dStKZXVNWUMvVEVSaXRieDl4ZElmelJB?=
 =?utf-8?B?QTNFOHBZK0R4cFJ0QVo2UUIrcmRHS2NoOURla1M1Umw3eEs0M0g2c0NMcWNR?=
 =?utf-8?B?UXM4TEdqc1JrN1ZvV3NZSFRUUmx3RDBlMDNqeU90S3pDdHdrS2QvNVZDSVMr?=
 =?utf-8?B?ZkhIdjRYNWdiZWpyWjFHcU9uQ1BEWDRabU52eEswNFMwY0tIN0FUNHh1aXl0?=
 =?utf-8?B?WVNLcUpkdzhsb1Z4Z01TYUhXWEo2TldLZnh4bDM0WFpXV0pzWmxkUVF0a2sz?=
 =?utf-8?B?L0dyc2hXeWNJSXR3Qm4vM0JoZm8vVGZIbkNlUVo1bHR5SnVrTGpQOHFDOXor?=
 =?utf-8?B?THFiZTdCQnlVazJRaVh6T1EvbVU3bmR3NkhjS0dLY0dLaHdxUDNydDMwWW9u?=
 =?utf-8?B?Q3c1cEZLRjRvSm5tUEtFUE5ZMHJxNm5mRVJrNjZRL2IvVGpqeTkrYnMzWC92?=
 =?utf-8?B?OTFKT21CT0krZmw4NDVpeENNaUJ0dE90bHZ2MjlPcndOcnVEdysrbS82RVNK?=
 =?utf-8?B?N3FVZS9HelpOZTBXNUJuaVR5VzA2K01JOXhvanJYQ05La2NZRmM2YlBOOUpy?=
 =?utf-8?B?azNhT1dmZURiQ0VhTHRmd0RYN0ZDbG1qQVlTSVJEMnJJbzdvTXpkY09zOFhm?=
 =?utf-8?Q?VdnZ2l0bohthIUSRYgGAr+o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f29fc859-4341-4cbb-42d5-08de3cc34d2c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:51:04.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clV9QnLYXIky6nQbhOZs7UtV0UJGdylMDKiOJE0THKeqfvW7NUqdOUWj9kj+i/OVcX/guRwsLC3Bf0TDOQTHxuzgomgCh3cIzz9xp4DOPvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9087
X-OriginatorOrg: intel.com

Hello Sathyanarayanan,

Hope you are doing well. I am Chaitanya from the linux graphics team in 
Intel.

This mail is regarding a regression we are seeing in our CI runs[1] on
drm-tip repository.

Since backmerge of Linux 6.19-rc1, we are seeing the following 
regression in the PTL machines.

`````````````````````````````````````````````````````````````````````````````````
<4>[    8.197433] ============================================
<4>[    8.197437] WARNING: possible recursive locking detected
<4>[    8.197440] 6.19.0-rc1-lgci-xe-xe-4242-05b7c58b3367dca84+ #1 Not 
tainted
<4>[    8.197444] --------------------------------------------
<4>[    8.197447] cpuhp/0/20 is trying to acquire lock:
<4>[    8.197450] ffffffff83487870 (cpu_hotplug_lock){++++}-{0:0}, at: 
rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
<4>[    8.197463]
                   but task is already holding lock:
<4>[    8.197466] ffffffff83487870 (cpu_hotplug_lock){++++}-{0:0}, at: 
cpuhp_thread_fun+0x6d/0x290
<4>[    8.197477]
                   other info that might help us debug this:
<4>[    8.197480]  Possible unsafe locking scenario:

<4>[    8.197483]        CPU0
<4>[    8.197485]        ----
<4>[    8.197487]   lock(cpu_hotplug_lock);
<4>[    8.197490]   lock(cpu_hotplug_lock);
<4>[    8.197493]
                    *** DEADLOCK ***

<4>[    8.197496]  May be due to missing lock nesting notation

<4>[    8.197499] 2 locks held by cpuhp/0/20:
<4>[    8.197503]  #0: ffffffff83487870 (cpu_hotplug_lock){++++}-{0:0}, 
at: cpuhp_thread_fun+0x6d/0x290
<4>[    8.197513]  #1: ffffffff83489f60 (cpuhp_state-up){+.+.}-{0:0}, 
at: cpuhp_thread_fun+0x6d/0x290
<4>[    8.197523]
                   stack backtrace:
<4>[    8.197528] CPU: 0 UID: 0 PID: 20 Comm: cpuhp/0 Not tainted 
6.19.0-rc1-lgci-xe-xe-4242-05b7c58b3367dca84+ #1 PREEMPT(voluntary)
<4>[    8.197530] Hardware name: Intel Corporation Panther Lake Client 
Platform/PTL-UH LP5 T3 RVP1, BIOS PTLPFWI1.R00.3383.D10.2510222219 
10/22/2025
<4>[    8.197532] Call Trace:
<4>[    8.197532]  <TASK>
<4>[    8.197533]  dump_stack_lvl+0x91/0xf0
<4>[    8.197537]  dump_stack+0x10/0x20
<4>[    8.197538]  print_deadlock_bug+0x23f/0x320
<4>[    8.197542]  __lock_acquire+0x146e/0x2790
<4>[    8.197548]  lock_acquire+0xc4/0x2c0
<4>[    8.197550]  ? rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
<4>[    8.197556]  cpus_read_lock+0x41/0x110
<4>[    8.197558]  ? rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
<4>[    8.197561]  rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
<4>[    8.197565]  rapl_cpu_online+0x85/0x87 [intel_rapl_msr]
<4>[    8.197568]  ? __pfx_rapl_cpu_online+0x10/0x10 [intel_rapl_msr]
<4>[    8.197570]  cpuhp_invoke_callback+0x41f/0x6c0
<4>[    8.197573]  ? cpuhp_thread_fun+0x6d/0x290
<4>[    8.197575]  cpuhp_thread_fun+0x1e2/0x290
<4>[    8.197578]  ? smpboot_thread_fn+0x26/0x290
<4>[    8.197581]  smpboot_thread_fn+0x12f/0x290
<4>[    8.197584]  ? __pfx_smpboot_thread_fn+0x10/0x10
<4>[    8.197586]  kthread+0x11f/0x250
<4>[    8.197589]  ? __pfx_kthread+0x10/0x10
<4>[    8.197592]  ret_from_fork+0x344/0x3a0
<4>[    8.197595]  ? __pfx_kthread+0x10/0x10
<4>[    8.197597]  ret_from_fork_asm+0x1a/0x30
<4>[    8.197604]  </TASK>
`````````````````````````````````````````````````````````````````````````````````
Details log can be found in [2].

After bisecting the tree, the following patch [3] seems to be the first 
"bad" commit

`````````````````````````````````````````````````````````````````````````````````````````````````````````
commit 748d6ba43afde7e9ac27443233203995cc15d235
Author: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu Nov 20 16:05:39 2025 -0800

     powercap: intel_rapl: Enable MSR-based RAPL PMU support
`````````````````````````````````````````````````````````````````````````````````````````````````````````

We also verified that if we revert the patch the issue is not seen.

Could you please check why the patch causes this regression and provide 
a fix if necessary?

Thank you.

Regards

Chaitanya

[1]
https://intel-gfx-ci.01.org/tree/intel-xe/combined-alt.html?
[2]
https://intel-gfx-ci.01.org/tree/intel-xe/xe-4242-05b7c58b3367dca84d4745dfcac3b5d4ee142404/bat-ptl-2/boot0.txt
[3] 
https://cgit.freedesktop.org/drm-tip/commit/?id=748d6ba43afde7e9ac27443233203995cc15d235

