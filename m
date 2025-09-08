Return-Path: <linux-pm+bounces-34172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EDB49944
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 21:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239EC340B71
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AC238C26;
	Mon,  8 Sep 2025 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dst/7U8q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B623717F;
	Mon,  8 Sep 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358175; cv=fail; b=IyEcyU2Kwc5rY67ttgBmoWMGzmL8JLJE8Ddw0u7hT2c3GXtS09IrwX1y2XPxituKX7B0wb6N8JaXA8lqVxowwRgzgLbJkbCt6NF5lY0KheBHJGwR6iINROQ+bU1/WXR5Bn7HmA8HArXqhMcFL9WAn8ES9BmGF77NLwFzzvAzziQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358175; c=relaxed/simple;
	bh=REjDxlFDGniWAugP4H+6GhtyiOR15dWNeamBD+QSKYQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NoWf//wgZ0UXv+Bqdpul4bGWUqCgO/NVRc9HhUlvCb8vHk7BWQ14FZuk+jX7uYiipnsGTj9H1ECEb9qCreypxHnl3froU+u7CcXfNuwsPExh6pgiL+0jIx7VVnXIDlehPOv7AHAbTpk8aP2MjFQZA4k23Cs/2+nJ7bIMWG/HG0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dst/7U8q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757358174; x=1788894174;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=REjDxlFDGniWAugP4H+6GhtyiOR15dWNeamBD+QSKYQ=;
  b=dst/7U8qjlBYjlOoQsb8oY5LWFN8enJZ7eNaKz1Pr6xVgpzHYfvIZKdX
   /VTHjhs6F2+ae242g7gN4OS1IhiTr0Ih6idwHdZo3seeN/GzxPa4qzq10
   RPxRlkjkzj3p2QfSUOuCZIDftcOlA0Br0osa8rdyFQDc0IycgXK4IcQ0Y
   TWed2Lej9L3MHgaHCsq7BerhOJakWVfW9xaGdfWNnb5JjZ+MQHTgj1bp/
   50cEk0NV7VQBHD5zVe03jYuXMRxPY81QBC2m5uCJgSS0SuDG4aroWP47N
   9OEGDxgIh9e8/8tpF4CzE10tiSC+HoX8uvcxL1xpWuaAiS7Nzjukcdsfy
   g==;
X-CSE-ConnectionGUID: YlapIhP1QDiR4/+7gnoU7Q==
X-CSE-MsgGUID: CQGe6SaZT+CVHwBoXaNVKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="47198716"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="47198716"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:02:53 -0700
X-CSE-ConnectionGUID: zqwjR5E+QkKnfPoRURIYJQ==
X-CSE-MsgGUID: Nm+0Yg7uS8iGCryAN3ERxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="172132777"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:02:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 12:02:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 12:02:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.71)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 12:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fU2/VWvrnPLZRu8Z53DccfSehsb57pdC0brOmfN/6PBNxV5wrDpsiZv5meULeCgRM9RrM2xHpLB+1yHNFDO0uSPvX5+0iPexRmhaWEgmrkz5pHwkZ8h5uGF9ktHMFQ8u5bIKj3xKvEmWY1ZZQ3mKzp+iKOKtUi0KG8iH8jRCfCsoRfLrxK0wkODcn9hOs2UsIYrVuUlMwRQNruqNqoBA/hO/zHeAFvO9/bK2s9lKRKcPt8RYmfTsM9tKLViiCaYNCGNgjsN7I55E/QjdZhUHPU0N8hvY4xKxjK9LsA/ZZpr9KXcfFRbabywjgzqBP1FUdp5fbKwErqg9OY4KSzmywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REjDxlFDGniWAugP4H+6GhtyiOR15dWNeamBD+QSKYQ=;
 b=NQhMfQENRqKoHLpTZRhxQT4ijeKF/Mo7X8ZluQGkOqRP8FxMC7Bb0RZ/zhBBI2fDBbG96UIEhokQr9cS6B+a38dW85jh5Q/0RNdKny5/IwrP9Kq7z5i/nf8lUNOnBeuUb1IMTyLQzwkUb66vLh7SZyr787qTbzD+n2BLf3HtH+wctYaC5h5y/BUFakfvYcgetWIiFYIqlbaq99Ygm2fiG1nK2j0FX2kvAZumtFRORPuqNDbwRZ27luVktyW/eFROS0MtTmdnfUAYUBE10W2Mdu08p0IgqC5P7nnPsQQL04TMKYT766ZtDORepOAcPDvlrLrrn1A/NGbZdLJtd2fx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CYYPR11MB8406.namprd11.prod.outlook.com (2603:10b6:930:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 19:02:47 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 19:02:46 +0000
Message-ID: <d87d55db-c841-4d6b-b218-a6a642fca988@intel.com>
Date: Mon, 8 Sep 2025 12:02:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: ondemand: Update the efficient idle check for
 Intel extended Families
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<x86@kernel.org>, Tony Luck <tony.luck@intel.com>, Zhao Liu
	<zhao1.liu@linux.intel.com>, <linux-kernel@vger.kernel.org>
References: <20250826183644.220093-1-sohil.mehta@intel.com>
 <CAJZ5v0hw+797-mm3qA6PqQdA7hWyZKhkYobbvF+8MCvg1cHZvQ@mail.gmail.com>
 <67ffd6b7-55c2-4ee0-9243-44bf8336152d@intel.com>
 <CAJZ5v0iXrqs2oVx0iYanjyJ6ucXorWi6PXPqW7Kdjnsu-zTGEg@mail.gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CAJZ5v0iXrqs2oVx0iYanjyJ6ucXorWi6PXPqW7Kdjnsu-zTGEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CYYPR11MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: d81eec2b-7bc8-4abf-b576-08ddef0a4c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjVXcXdSMXR4cXlPbVVQcC85VFFiR1czdWR5Y0hFRzBQcVJGZE13ZGJSTzlT?=
 =?utf-8?B?dE1KcmVjclRac3hFN1o4dHZyNm5BL2ZKWGFGUFQrNTRWYW5PRmxrTC9YMWxX?=
 =?utf-8?B?RTlodVdXV2k2Vkl1MTRQUVFwSmRkL0ZWUjV4MDBxUHRpMG0wc3BTQkxEcndw?=
 =?utf-8?B?TktybjQxd3dXSkF6UmhNWVpLSHduT1V0Q3pzQnYwNERlN2NOaVRnYkJKVUF5?=
 =?utf-8?B?NlBMMCtMNVVwV1B2cVB4YjhuRm5HNytGQW5LeTY5aURsWHFvcExoNnV0Ykpr?=
 =?utf-8?B?VElNMW1WN0t2ZEFFOHBWZTR1OVJ4bkoxZFZmdC8xRTVUZUFHSDRuaTBtb2lT?=
 =?utf-8?B?WTlIRE84c3llNkdibG9JN3IzVmI3WE9rVXhmYVRaUnNZdndhMWU5ZUtJZXZ1?=
 =?utf-8?B?UGt4QzQ5dHFjS0VPeDVpM3kvbHVTRHhWOUg3S0dxNmttblJLMWQ4SmhPSXZQ?=
 =?utf-8?B?amQyNlpESUlSRC93MitPSzEzYmJGQW5rS1pnWkpzOStpU0MzK2VCKzZ5NUtB?=
 =?utf-8?B?WU9ZbE9TYlFxVVgrT2J2c3A2RjhvSXNSVjM2L1lxR0NFNTlCV050SGtXcDNa?=
 =?utf-8?B?TmtndmVObWc2K3ZWdGlHUU1vK0w1RVBNVzBlUVNrTC9TZ3NvMVNLcjhod3JF?=
 =?utf-8?B?YWF5MHdNVDZiZDZ4dzBQZGRPd2cwOUVCLzZUSFlEcjJGQXArRGdyZFJuYmxq?=
 =?utf-8?B?eTg4QnJyQko1UUlDZmJnaHpUT29ta0kyQVJKSnpTaUtSNnhyUlA5aHdyV3Rv?=
 =?utf-8?B?enYzTE93ZS8vL0RCYlRDVndic0tvTkx1R3pDMWZZRE9ZY0wxOXJRTlVjbDBl?=
 =?utf-8?B?eTljMGdPTVdTc3QydnUxbjhNWFBDdG9zWU0wZVo2VGNPYyttb0F4QlowOFpF?=
 =?utf-8?B?N3k4WG1YdkRNaVBYMzNoVUtxWDM3SGFIek5wNWRTTFRQZG56QW1KazdRNG1W?=
 =?utf-8?B?ME5ma0VjcmFZc255OTh2WlRjMVBTZExGTmJETG9TSjh1K05ndkY1THFTWUt4?=
 =?utf-8?B?dStRak81OVBDYkRqbXlycHY3YVFhRUVzMkMydy8yMXkyZTUrcEJsWmwyc3dR?=
 =?utf-8?B?bCtmWVJpZmx0SllJaVRaTkZ5NVFaWWxza01OaDBYUkFIdjBlUGdBam9IdmpJ?=
 =?utf-8?B?M3pjU3pLV0hUbko1NUFJYU9NVnJTR3dVSkIwR05JN2hyemM4Skp5T1E1TklH?=
 =?utf-8?B?a3RWYmZHeTJQNTMxM2EyNHYwUVh2ckxZTTcrSXZrY00zSXc4eXFEbVZ0aEg0?=
 =?utf-8?B?VGtZWnJRL1R0NmFHdzJhcXBMZzY4ckJNUzlhd2RvL0E0TjNWeWJZcjlPMFFN?=
 =?utf-8?B?Ulh5L0RXd2MzcSsvcWJSV0s0bVVxbklEQ2pQVEl4Qzg0ZFUra2FQeWNLUGY0?=
 =?utf-8?B?NHFUbFRtS0hHWnFqVGhVeUZLRjRxQndOTTdSSlBUdk5BeXVDZHFyeW1QaVRs?=
 =?utf-8?B?WDJnaUVyYlZUNFBJZHd1cVJzTHRnSDRraWxKbVJvS2ZjL1FLUEE4ZkRqRlZm?=
 =?utf-8?B?TFZyVk5hbTVMd0xZbTExck5OeTFsOS9GYVg4dUo0RHVveXlXVGM3U1NhWXRa?=
 =?utf-8?B?VVhYNXRYcm9mWnh2VllBOHp0R2d5dXF1NEhYOGM1VmVmWll0Z0l5RkprR1VM?=
 =?utf-8?B?cFZLekJnOEo2NUVwcW1NWHFjYUFuQng1K1ZBMFBoeWZHWENkeDRMM3MwelFH?=
 =?utf-8?B?SUwwSG5sTWZXbXBXeHY4QmVFdE1rUllSUGZkc2lyNUhjQTZ5R1BUb1UrN09R?=
 =?utf-8?B?NzJncWFnNHRJRjN1TDhremgvRDhQdERyejVoK1pWdldabmlUdnArL0VsSHhI?=
 =?utf-8?B?MXQ0VlRSWmlHMTFDT0NzTHVPdHBVbDRaN2NQSDEwMjhZVGRCT0I3UGZSSzZL?=
 =?utf-8?B?Y25kbU9MbVV0RkltaHhjNElBdngwOVo4QnpaNndYREo0TDZYOFhpSFpOaExG?=
 =?utf-8?Q?AMVmiHl7yUM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9hdm53bExoUDhleUN1KzUzTDZmTU5pOExmUkhrQTBkSEtIQ3lrbFJMRXJC?=
 =?utf-8?B?ZzBDYXVVNUc3WnRrQjdYV0NvRGZtVFZ6cU1iR1ptVk5XaTdlc2xheC9mZ3lX?=
 =?utf-8?B?ZkFJTzRmYkVWc2ZGMGpGeUFCMDVlZmZua1d1YkwwdG1Pa296OG96a2ZRUXRY?=
 =?utf-8?B?clJsOWdiTU96Ukh3TnlUWHpPbXZ6ZWw3NklRZEdKK3dlazJqN2d1OGJJUGZw?=
 =?utf-8?B?eGEzSFM1MDFRNjRzTlVMaUI0MVZmdzhyZUt5K2lSbExuZml5bFJtd0NDaEhz?=
 =?utf-8?B?L0Z0L2Q1cFNmRjgwRzVlcCtrYWpCaEtFNXo5T01UUUpWS0YzMFU0MU41Ty9q?=
 =?utf-8?B?S1U4M0FQZ2JuUE95TlRqV2psTnpHQmVCSlNWQXhQUHJNNE5Fb3dUb0RaSmRl?=
 =?utf-8?B?Rkxla0ZyWU1hTnhzVUJNYVRpVkRqZEtsdzlRWkdBQm4wZk9IaHdlc1BJazk4?=
 =?utf-8?B?RlNsN1JNYktNV2gvekcyRUpNbG5jakFraTZIKzNaSHFBY2NUeU9UKzhMMlhp?=
 =?utf-8?B?MnVIMU16SlZmRkw4WWZoV0lhdEgrVEtNS3NMRFdEUldDcHdhVElzLytaUlU3?=
 =?utf-8?B?bU9XSDNMN2tXcmdpQmJpVHJUN2FzRzFIWXRBZU9NWTFrZkxDcXhsV0JvQTN5?=
 =?utf-8?B?NzZNWU90Rzh2K3dSWnJzdzVURHFReHluTVlaemlWMW1FbWU2ZWlSUWdZQjJh?=
 =?utf-8?B?c1VMYVdTWEtBS2t5aHRnU21rZlNTczFLOXc5UWhKcXpMdEtMdDlYcUJkNGNt?=
 =?utf-8?B?czZ3WkN0aXVOR2hKOFN3cUlqeldKVWczQkpLZkNaNkJIeXpiZXI2UzhBYy93?=
 =?utf-8?B?cmU1QkV1TVFwQ3lKU0tiQUFkK2FMMnQyY083MjAvRUhiWWdJeGdQRUpFdEpX?=
 =?utf-8?B?OGxVOEd3NkxmU0VVaUNiRks1bW5tOVhvOUFMNzRlMkpRbmplc3lsRTBuY0hJ?=
 =?utf-8?B?ZENWbTNtNHNWcUFCWHdiOHN6d1YrdFRqZDFFUkdVd2ZYUFlOajVCa0pYdlI5?=
 =?utf-8?B?TDh5WFZuUitMa012VWpCdUpFQXppbWdhM2RPYlM3RVRMSlRwZmt0K3QyR1g0?=
 =?utf-8?B?Y3BJV1RQT1dLMXBkNCtWL2VVYzFEZjU0MVZ4ZFdLVktENDJ3bXVxdC94aXds?=
 =?utf-8?B?YjR4S1dycnpBaWFOVFFGcDFUc1JWRng3U0dWOXdrTWxsT0FxbGpvRTY3elFU?=
 =?utf-8?B?TkJXNUVJeVJianp3YU5zQ0hjN0pZVGtWQWd5d1ZUcmdGaFpaUHcyTkc4WE5Y?=
 =?utf-8?B?ZkNCWnpydmFuS1pWVlkwaFJwalBMOWIvd2hQYVRNV3B4QjdCODNHOTlmcklp?=
 =?utf-8?B?cWUwdmZUQXBOQzhnYjJ6aVJsRXlnRHpiR2xJcmFYNkJxVUdpQUZ0czdUU1d5?=
 =?utf-8?B?em5Cb2JMWjlGdS9UTzZEQVlyS2RXZkMzdjlJeWFXeGJjZ2JodHkwZjQ5WXBC?=
 =?utf-8?B?VzlQdFVjUEZvS0lMRHBQcW83WHByU0lDRGxWZEJQYjhrRzFHQU1vUGNRTElo?=
 =?utf-8?B?WVIvTU4zdUZTZlVEVnBIMGh2YXExLzRvR3pXRWRPL1RIalFoN2p3VU03Sytz?=
 =?utf-8?B?OGVlci9pa1RyYW9MN3JDazlIOFBGL3BlcWNSZ2d4anhWUWYyQTk5NFBBZUI0?=
 =?utf-8?B?dWI1NDZtd1ozcXdjZkl0dktCNmoxaXYvSXo3NjJDYVNaTVBTR3JMTzN6Vklk?=
 =?utf-8?B?MWtrNzZTNUdNTGgyWVpGa1RYRjJGN1E1VGIzeS93Qk0vSWtGUUFXeE41VldR?=
 =?utf-8?B?V0tlMnJKR2ZQMm5TMnhEbjZnMzJFMGZMZFhrNXN3Ykc5bDZUdHBlRXFqYmZT?=
 =?utf-8?B?NmhlbEhjcDF4dGttM2ZaS1RDZTVTTUx0KzdOQ0FITVdJYkRxNHhLRzRUSWdv?=
 =?utf-8?B?cVJ0WkNTN2RhMk5hWjNiS2xwN2VVOXY5Tzd6aFM2WTJOMk4yQ3E4VjZlUkxL?=
 =?utf-8?B?MTBURDdHSHVjK3dLQVlpcWdnNW8zWCtFK3NmaHRNdTlpV0l0VHhvWjA2WTBS?=
 =?utf-8?B?aGZKSU5BWWwwQ1JqK0x2ZFRBdFpmZFhUNndjT08rNGpxT1h3djAyN3J6amJB?=
 =?utf-8?B?TlNEU21wWHgwNDJHR3F0VUlhVDRiYkpQUW15NFllcUpHMSs4aG84T0dmemF4?=
 =?utf-8?Q?t3FwP/LfYml0Wnng+Ficu9u8u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d81eec2b-7bc8-4abf-b576-08ddef0a4c44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 19:02:46.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lsdd5dhOXT1LusK1zwZrIJ60HcUH9faI5mZQKbELBEiMyPy/dfgengQQu7tRv2ZH/Vxw+VwEWAUZTSyxNT52jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8406
X-OriginatorOrg: intel.com

On 9/8/2025 11:54 AM, Rafael J. Wysocki wrote:

> But it may as well go into the header as static inline in the CONFIG_X86 case.

Makes sense. Will do.

