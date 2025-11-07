Return-Path: <linux-pm+bounces-37588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D16C3EAC6
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 08:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE43A6208
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 07:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DD226159E;
	Fri,  7 Nov 2025 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF+m+gQG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFC18E1F;
	Fri,  7 Nov 2025 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498887; cv=fail; b=ptFneTMkhzFd/4zEbFFvjY78GyMusHBO1b3xUkksbcpGrpBX/KGZDbrj/0Op38+zpe1kEJtusFcT8L3AHWxAXrKJAwsujmDQeP9sGc95ILw8yMvOkgB/FScZix60XYeYXwpVjg1e9Mw8wRuMjpgFVw+RqQOGukL++jSUhs5B8lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498887; c=relaxed/simple;
	bh=tl7rY1ZuyMobB+tT3qCkxxE9kJW/9trRsk3mPvxmt4o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qtpzWl/hSttnM9L4UzLRLGqMEhOi8oA9/aQvq9xcnmyhBBpAz4fCXP5iCB+SOppJ8xCrFgm0VWY5FUEv+Tf0CPodKFj9r37QCYt6bM7AluyIBufXoFl1wpSYHxBDegAtjrmeMjAai6krzMQ3zHc44AxfyXxgfJoPSZyTtTsxesQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF+m+gQG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762498885; x=1794034885;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=tl7rY1ZuyMobB+tT3qCkxxE9kJW/9trRsk3mPvxmt4o=;
  b=ZF+m+gQGkCIqYQQCZl3kmeyQqKWVvZDtcp/LezvPCIa0uNbdE8pSF0kT
   cgFi/hcE1xBJL8Ir22kflva1OAXS9buYCJz4F3oU9uPbx+uvOV3crx3gY
   wZZuZVvV1TVK8/QfYwAIT2JGFqPE5RpZdY+h4TysB7Dv4H/Wl9CC1FHoM
   HyHhNUe3+UE0/xpW3ZypNeVijv9qHqfoi1GnnKymjIu0vYbxk+JuMoZkE
   6gaGh0D6Bj4/OYl6i+kgeiyLocYQI3eZC4TNO7DEQwJJj78CNyJnH+P0o
   DvDWyE5+GJHSzgNCXK73dLnbjvxEsDYzX3u9ncMzarOzgrd2DnAaKFQa1
   A==;
X-CSE-ConnectionGUID: BRtPtHPdTIim7eUVsNTkzA==
X-CSE-MsgGUID: RdIT6NodR1OHVRK0IRdylQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="74938581"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="74938581"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:01:24 -0800
X-CSE-ConnectionGUID: f0rbB2N2TEuZ/h+E9Z2rzg==
X-CSE-MsgGUID: Jm1Ny98hRYScdTt6wDKrlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="193136737"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:01:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 23:01:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 23:01:23 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 23:01:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icayVo3FmGG8UEOF6kr3pCEWE12pP7upok9He0KC4woYTOMjPdaYOGIZ+VK20gRK8a4DhE/PCh2QqLdcPd5perPkm1kQ6p5ne7qNJ0+52/ZXT5p7FSB79JXqXfMaTEjprJjATq99miy4m6PFFRfA4m991WJk48XCunOTHpUs3hGK5cA6Cwn7LZbVMvfX8DhLrCK1WI//zHmeRYRNX1tcgy8zN8YQ9earRcKO48QTBHmBxmjhwitO9a2klaFuVg66M7EapbPH1U3bLeG5vo4rFTZulgY0xL0tnM2FoEGQEuBpnVTmM/9sWB2Fg+mFMNEXV9hoAUiHJmsUxq+O/Co27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yuGB+QhtsGXaTwAt6NvEUtNKoDx9JNpruJL5zOZlUE=;
 b=ijMGiKW2joinxUF0ZCfUS50s1KZiMdH7yuCFzoSQE2hg9VQiZ4RjlEmaKaRWaaMiGkaAO+RsPYBBRJknJJ4RlNGkd1xk9wc9fOJCNatOyK+6bDSgPKDho6+IYXXfhdORMKs9EPrNpSf5K/5Z+jr1EtD19pV60Wp6wGVpuzK6ei+pQxcpQ8m7eow8W4/l+dB6XCVMuskEtJ68aSvf6TKPVzjZqqQx3RhpO0KBtovgS4s/LN+DeoYXY1OT++HvbCbPUhlTVBb6ss3q2pA9BTrFQJsVk8OQ7vaozKAgiBm6Y2RnNCstkw6IUNoti+Mk4Y+1BBQxiVXyUXdc+sleA/EhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7210.namprd11.prod.outlook.com (2603:10b6:208:440::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:01:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 07:01:17 +0000
Date: Fri, 7 Nov 2025 15:01:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Doug Smythies <dsmythies@telus.net>, All applicable <stable@vger.kernel.org>,
	Christian Loehle <christian.loehle@arm.com>, <linux-pm@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [cpuidle]  db86f55bf8:  lmbench3.PIPE.latency.us
 11.5% improvement
Message-ID: <202511071439.d081322d-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0009.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d96187-41a3-49de-6a1a-08de1dcb72d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8Dzd4Jfr3dc9sR9eLy7GUCpgcCuga4F7boqww+LgPbCyIjjP1FLp322UKQ?=
 =?iso-8859-1?Q?vojsGeONZ+Zu+HWC1uyubsVLKOM27Z+tDsWS1zPdUsXmb+y3Hk10AGr/f5?=
 =?iso-8859-1?Q?CJtQkpIRBO+X9cm9vAtl0F2wlonWRsXdj/EIkUm7QuwxOm8IY4CSrXL4Zz?=
 =?iso-8859-1?Q?upkZds225lecfk9q+UKqWtdJZBzkPAwOYSHosDTH3fLV9YDIhryilnMrTp?=
 =?iso-8859-1?Q?7gzMw8Do++4Xpey+LZHqQRhR3lhOV+NEj3eoThqxKK30ylksKCroUhCaEe?=
 =?iso-8859-1?Q?GGSI5+BEW0sbScYzJnyOSNXzSY7IukhGdAt2wpXWBjmMDbyD5O9X2NlaIn?=
 =?iso-8859-1?Q?azXBwqTPKERVItATARpQ+kV/D/fwsPNHtljHcf8a3ekCSsqT6xPpqrOvxk?=
 =?iso-8859-1?Q?uI6g8WnpVeQTQ442KhRLUziGfZV4MI3gUJywwSQciODJxrSc3ZWxaLTYZt?=
 =?iso-8859-1?Q?UB9y2e3D4qBLZHTGrO3dBt6vNfOVGQwUcNiBXHDnL+j8c7mX8SdNtdyttX?=
 =?iso-8859-1?Q?jdh36L34wPIFXbLHL6JZm3iv2bXlcbsfzvreOaIjgdO7cPOiUyvV0XQJ/K?=
 =?iso-8859-1?Q?t1k1CMiOG3brtvYYLHLgM6s1eADTaH4xPXf5vHPH5fSEjIHEfkJcZKpqWQ?=
 =?iso-8859-1?Q?azoMZtDrnsKgsC38PoK/zuw+84E+R8PWdsiEPQkSaBZGxD4iJA2uYN6JOg?=
 =?iso-8859-1?Q?DNfNNeKbOBSyrS2wJkEvK8HcT7wz9ocDzmUw9RtXHAASC8iR9Qv+eVEf8t?=
 =?iso-8859-1?Q?DX2PqaoWgG2FDnLE+c3ls+ShF2c/4EUqAi2bcbsuvFxG4A7T21a2Xki9i1?=
 =?iso-8859-1?Q?2saHX6v4zkpL1HaiZyXXnRs+aNaZ0M6dqVr6RJkxiMCbbr4c8Yu6i6pHdA?=
 =?iso-8859-1?Q?tnvV9HLs+GI5X9zzYDTz0iMUiFcOispdwK9OV2q06g27Zp5qmxVVib+WLt?=
 =?iso-8859-1?Q?/pEJIbLMeUPfBddv9QxyB0jDfp0fsuR0FvLeIYQDbLvOClfhcTm4SW2vQ9?=
 =?iso-8859-1?Q?+TxQa9pTqsxeBLUjI0POhxme2uMXvShhi+Gg2um1IlWqsGrmkME1bRLu8C?=
 =?iso-8859-1?Q?nVDI6p6TbB0YQo3Hw9FYl2/e8rsVPwqZrIDWJPzV5nAP4M527cSt5fq2kB?=
 =?iso-8859-1?Q?k/h014eFOiux9EjzLcSuna7QUxBkL/QGtkDMV94Eo3ii84gUf0+yZqODYI?=
 =?iso-8859-1?Q?GV+PvnIvL2USoMi96UmqqI+8dl0ThSzOgsZjAL/PG86VsIpO8WXvDJQ6Ey?=
 =?iso-8859-1?Q?TCHCBtRf66S39vTvjT/rZnWLG7ISKeS1JvHSrMVbANPH3aAwtkpK4N9J7T?=
 =?iso-8859-1?Q?RDLuZb1w4ncdKbR0eSxwZrnAe/bPhkVYeEFqfa7vaT5BDT0J5ewkwnInNB?=
 =?iso-8859-1?Q?q8SlsbNf5rVwKqbR7fNu7U2tZn7GusionuOeVL8SA+IvaAhy+33sUsCxJw?=
 =?iso-8859-1?Q?3dUDYh2gBwDT78FavZVvKFlfOFl1sB3adZ1AbY3ZiUDOhHOfR+4esn8T2s?=
 =?iso-8859-1?Q?bgNL57YIsLiveT8Q3f9d45PvQUMv/jq+Fs1kGNU2pkIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AuuNffYU0efzjJEPhSRtogCiJZKRgrPlN8cJBL7GWDVcr/7HgwaU0UKC+h?=
 =?iso-8859-1?Q?gjwqe7m3DX3PS8cF7jvx+X0/tDYYVe9eApwVm2VrtdnJjP4G9BiPDeYSD7?=
 =?iso-8859-1?Q?NGAcM8SSYO/iiKWwp1evtZrN/b7odKs/1MsNjMG4cWGJkojDMkG6z0hjzM?=
 =?iso-8859-1?Q?MVUrFoBkJs51nT5jmNHoSmbAU7AzU7LZqRVAqkYlr7//3Rdjki2u10xSpg?=
 =?iso-8859-1?Q?YV3mqN6KrHju1DkPcD7ycoBSBjhuHImkEENhqeVPd+howiy4wzBTaaF6OX?=
 =?iso-8859-1?Q?74aRX8aBOKdeMwsJEsfqJLEEF3c/q6mvqKZQUclUYMjT7DvDKbmQNs6g62?=
 =?iso-8859-1?Q?leWAbV0UXQBOWm5qhQvK5AYiskKXJkgbh6chfyCzvSa16KcwibWxf7gzqt?=
 =?iso-8859-1?Q?PCvqmNlexxMwkZqC0b8mugg5ez9n8AA3vMIsl/7rQisJPSedjtemWzHbJT?=
 =?iso-8859-1?Q?xGTNXA7kOe4u36b1/tcVz+pZwdsevgQO8peABwqz4lGLZE4Kwyk38XIAS3?=
 =?iso-8859-1?Q?BIBGocPzWwPl4LND/PR9dcNt+FkvFUbKRGM2TsVIHpFTa6Yd7K9dbLTbe8?=
 =?iso-8859-1?Q?iZ256sKgY9cEMb0nmsNDTvaIaZiRRGNf5GoyN5a5bgogVxvQZWdciYush2?=
 =?iso-8859-1?Q?tSJ79ch5e76us/qH2LmA6LBmlKsl3/hBmjW/kL7uwU/ZMlrf/cQbYlpo2r?=
 =?iso-8859-1?Q?F2zWUcbkp/rQZ1fbcPlQJE48j4YcT8qlB943VtfNhBSIFRA17lR/WASaRF?=
 =?iso-8859-1?Q?ZeUfgG+nK983VaubrP9p7Afk8eUaJgAnejebeCRxZqJbn01g4wIWi1J0lQ?=
 =?iso-8859-1?Q?xHEZuSN5MHDEA6r5qtB1mcEsuxPA12johxn/pLggyAoyUZT0DPIWDYC5/K?=
 =?iso-8859-1?Q?8rTzbmoeyFfCdrBnEEJzzZpPx1GugLdkuN/8dLa1uIR1Wnxad0PoQg9ZDZ?=
 =?iso-8859-1?Q?uqewm/aaJGIiumxiwUE1lKXeAhWQZvwte8R2j3FI23uxcJrF0ZoxqZp5fB?=
 =?iso-8859-1?Q?Do6Tz68AFgzvO9KxvCz/aKUc5Ej8LSKLUwgkhl5HqUyRpXNrLTLlzsev9n?=
 =?iso-8859-1?Q?6DWZ8ZMDVuE9qv6aBm8ni4z3vO87urEtgpto6FpUlTS2X76qps1GIZebyM?=
 =?iso-8859-1?Q?IeqrVzzFB8YnX1lzJhefNQ3T9t5D5mKDYNDc2NOY/9a2ugHMvzGawTxq+R?=
 =?iso-8859-1?Q?r5cAuY5VT2TOTDdbH7i2hXyPht4EfkHf29YfTvtzCv+0C4opufg6Ea5D0l?=
 =?iso-8859-1?Q?gfA1VDK1bGctbist3rFnEkDhmh9DQ3NEvHgEge+IFI7v8eTjmWWJvYCdMU?=
 =?iso-8859-1?Q?qIPfN2JG5jikapQno7pynP9qZ6PCL0bYkyvcW8m1LSrdQfTT9i1DSmvVYr?=
 =?iso-8859-1?Q?BAuj/tgsR0YaHg0dfQBqi9QTGfh65V2idwbpzgZS7UdY9ScTVqzBDkcpnN?=
 =?iso-8859-1?Q?8fdNvvnDrIQPPVqfXjLhJy+JU7DlbPGJ2YNPUNWyReqOg9oMIDWWr/6Oiw?=
 =?iso-8859-1?Q?gpUP2f9WemIR9T+90OrqHd5XHq8kNxzO9wukZrWENYqz2TMVqPQPAq/+Cs?=
 =?iso-8859-1?Q?ikhALWWytVCo5PSKzNzbf2PLvFsHITFnR8hIZta6TtsOd3vQpfTr7Sgf8+?=
 =?iso-8859-1?Q?Z517QZR5I2lbpkI+syonMKHneHcRXrQh7fcL+YT0cw0nRX6JVRfJ12Zw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d96187-41a3-49de-6a1a-08de1dcb72d8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:01:17.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCIp62u0Y1TlPT/pWDy2tIklOUUcqGn9ao5iPbrMQul//i9m4mYiQ3JrooQvhW4SaUx2dPAG8RCxOYAMc9qZ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 11.5% improvement of lmbench3.PIPE.latency.us on:


commit: db86f55bf81a3a297be05ee8775ae9a8c6e3a599 ("cpuidle: governors: menu: Select polling state in some more cases")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: lmbench3
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	test_memory_size: 50%
	nr_threads: 20%
	mode: development
	test: PIPE
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 13.4% improvement                               |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | test=context_switch1                                                                        |
+------------------+---------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251107/202511071439.d081322d-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-14/performance/x86_64-rhel-9.4/development/20%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/PIPE/50%/lmbench3

commit: 
  v6.18-rc3
  db86f55bf8 ("cpuidle: governors: menu: Select polling state in some more cases")

       v6.18-rc3 db86f55bf81a3a297be05ee8775 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 2.984e+08 ±  3%     +13.0%  3.373e+08 ±  2%  cpuidle..usage
   3870548 ±  3%      +8.9%    4215418 ±  3%  vmstat.system.cs
      5.11           -11.5%       4.52        lmbench3.PIPE.latency.us
 2.949e+08 ±  3%     +13.0%  3.334e+08 ±  2%  lmbench3.time.voluntary_context_switches
   1474808 ±  2%     +13.7%    1676175 ±  2%  sched_debug.cpu.nr_switches.avg
    908098 ±  4%     +11.5%    1012241 ±  5%  sched_debug.cpu.nr_switches.stddev
     35.76 ±  6%     +70.7%      61.02 ± 36%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
    438.60 ±  6%     -42.6%     251.80 ± 28%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
     35.75 ±  6%     +70.7%      61.01 ± 36%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
 6.834e+09 ±  2%      +8.8%  7.438e+09 ±  2%  perf-stat.i.branch-instructions
   4003246 ±  3%      +9.0%    4365130 ±  4%  perf-stat.i.context-switches
     14211 ±  7%     +30.7%      18567 ±  6%  perf-stat.i.cycles-between-cache-misses
 3.305e+10            +7.8%  3.563e+10 ±  2%  perf-stat.i.instructions
     17.81 ±  3%      +9.1%      19.42 ±  4%  perf-stat.i.metric.K/sec
 6.738e+09 ±  2%      +8.8%  7.328e+09 ±  2%  perf-stat.ps.branch-instructions
   3917194 ±  3%      +9.0%    4267905 ±  4%  perf-stat.ps.context-switches
 3.257e+10            +7.8%   3.51e+10 ±  2%  perf-stat.ps.instructions
 4.907e+12 ±  5%     +11.7%  5.481e+12 ±  3%  perf-stat.total.instructions


***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/debian-13-x86_64-20250902.cgz/lkp-spr-2sp4/context_switch1/will-it-scale

commit: 
  v6.18-rc3
  db86f55bf8 ("cpuidle: governors: menu: Select polling state in some more cases")

       v6.18-rc3 db86f55bf81a3a297be05ee8775 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   8360618 ± 14%     +37.6%   11502592 ±  9%  meminfo.DirectMap2M
      0.52 ±  4%      +0.2        0.68 ±  2%  mpstat.cpu.all.irq%
      0.07 ±  2%      +0.0        0.08 ±  2%  mpstat.cpu.all.soft%
  24410019           +11.1%   27123411        sched_debug.cpu.nr_switches.avg
  56464105 ±  3%     +17.9%   66574674 ±  5%  sched_debug.cpu.nr_switches.max
    473411            +2.6%     485915        proc-vmstat.nr_active_anon
   1205948            +1.0%    1218407        proc-vmstat.nr_file_pages
    292446            +4.3%     304940        proc-vmstat.nr_shmem
    473411            +2.6%     485915        proc-vmstat.nr_zone_active_anon
      4.03 ±  3%      -2.5        1.49 ± 21%  turbostat.C1%
      4.83 ±  9%      -1.0        3.86 ± 13%  turbostat.C1E%
 1.087e+08 ±  3%     +59.1%  1.729e+08 ±  3%  turbostat.IRQ
      0.03 ± 13%      +2.0        2.03        turbostat.POLL%
 4.745e+10            +8.5%  5.147e+10        perf-stat.i.branch-instructions
      0.94            -0.0        0.90 ±  3%  perf-stat.i.branch-miss-rate%
 2.567e+08            +9.1%    2.8e+08        perf-stat.i.branch-misses
  48551481            +8.1%   52493759        perf-stat.i.context-switches
      2.76            -4.8%       2.63 ±  2%  perf-stat.i.cpi
    593.92            +5.6%     627.34        perf-stat.i.cpu-migrations
 2.367e+11            +8.2%  2.561e+11        perf-stat.i.instructions
      0.62            +9.8%       0.68        perf-stat.i.ipc
    216.75            +8.1%     234.36        perf-stat.i.metric.K/sec
      1.85            -7.0%       1.73        perf-stat.overall.cpi
      0.54            +7.5%       0.58        perf-stat.overall.ipc
    204618            +2.0%     208750        perf-stat.overall.path-length
 4.674e+10            +8.4%  5.066e+10        perf-stat.ps.branch-instructions
 2.532e+08            +9.0%   2.76e+08        perf-stat.ps.branch-misses
  47800355            +8.1%   51652366        perf-stat.ps.context-switches
    591.27            +5.5%     623.50        perf-stat.ps.cpu-migrations
 2.332e+11            +8.1%  2.521e+11        perf-stat.ps.instructions
 7.417e+13            +8.1%  8.019e+13        perf-stat.total.instructions
    534510 ±  9%     +24.8%     666973 ±  8%  will-it-scale.1.linear
    471854 ±  2%     +26.9%     598959 ± 13%  will-it-scale.1.processes
    534510 ±  9%     +24.8%     666973 ±  8%  will-it-scale.1.threads
  59865194 ±  9%     +24.8%   74700994 ±  8%  will-it-scale.112.linear
  52446572 ±  3%     +17.2%   61467049        will-it-scale.112.processes
     52.12 ±  2%     -11.2%      46.28        will-it-scale.112.processes_idle
  89797792 ±  9%     +24.8%  1.121e+08 ±  8%  will-it-scale.168.linear
  90159107            +5.3%   94951409        will-it-scale.168.processes
     23.53            -8.4%      21.56        will-it-scale.168.processes_idle
 1.197e+08 ±  9%     +24.8%  1.494e+08 ±  8%  will-it-scale.224.linear
  29932597 ±  9%     +24.8%   37350497 ±  8%  will-it-scale.56.linear
  24228097 ±  2%     +22.6%   29712218 ±  2%  will-it-scale.56.processes
     80.80            -3.6%      77.89        will-it-scale.56.processes_idle
    495994           +13.5%     562996 ±  2%  will-it-scale.per_process_ops
    211008 ±  5%     +13.4%     239359 ±  4%  will-it-scale.per_thread_ops
      5748            +1.7%       5848        will-it-scale.time.percent_of_cpu_this_job_got
     16823            +1.5%      17082        will-it-scale.time.system_time
      1410            +4.2%       1469        will-it-scale.time.user_time
 3.625e+08            +6.0%  3.842e+08        will-it-scale.workload
      6.75 ±  9%      -3.4        3.33 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      8.01 ±  8%      -1.7        6.26 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      7.89 ±  8%      -1.7        6.14 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     10.30 ±  6%      -1.7        8.60 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      4.36 ±  2%      -0.4        3.99 ±  5%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.59 ±  2%      -0.4        3.23 ±  5%  perf-profile.calltrace.cycles-pp.anon_pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.91 ±  2%      -0.4        3.55 ±  5%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.75 ±  2%      -0.4        2.39 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.anon_pipe_write.vfs_write.ksys_write.do_syscall_64
      2.50 ±  2%      -0.4        2.14 ±  6%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.anon_pipe_write.vfs_write
      2.44 ±  2%      -0.4        2.09 ±  6%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.anon_pipe_write
      2.56 ±  2%      -0.4        2.21 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.anon_pipe_write.vfs_write.ksys_write
      1.73 ±  2%      -0.3        1.39 ±  8%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      1.48 ±  2%      -0.3        1.14 ± 10%  perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.35 ±  2%      -0.3        1.02 ± 11%  perf-profile.calltrace.cycles-pp.call_function_single_prep_ipi.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function
     61.64            +1.2       62.81        perf-profile.calltrace.cycles-pp.__schedule.schedule.anon_pipe_read.vfs_read.ksys_read
     62.24            +1.2       63.45        perf-profile.calltrace.cycles-pp.schedule.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00            +1.7        1.72 ± 23%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.82 ±  9%      -3.5        3.36 ±  4%  perf-profile.children.cycles-pp.intel_idle
      8.10 ±  8%      -1.8        6.34 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
      8.04 ±  8%      -1.8        6.28 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     10.45 ±  6%      -1.7        8.72 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      4.41 ±  2%      -0.4        4.04 ±  5%  perf-profile.children.cycles-pp.ksys_write
      2.76 ±  2%      -0.4        2.40 ±  5%  perf-profile.children.cycles-pp.__wake_up_sync_key
      3.63 ±  2%      -0.4        3.27 ±  5%  perf-profile.children.cycles-pp.anon_pipe_write
      2.51 ±  2%      -0.4        2.15 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      2.47 ±  2%      -0.4        2.11 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      3.94 ±  2%      -0.4        3.58 ±  5%  perf-profile.children.cycles-pp.vfs_write
      2.57 ±  2%      -0.4        2.22 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      1.74 ±  2%      -0.3        1.40 ±  8%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.49 ±  2%      -0.3        1.15 ± 10%  perf-profile.children.cycles-pp.__smp_call_single_queue
      1.36 ±  3%      -0.3        1.03 ± 11%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.22 ±  2%      +0.0        0.25 ±  8%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.23 ±  4%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.local_clock_noinstr
     62.26            +1.2       63.47        perf-profile.children.cycles-pp.schedule
     66.06            +1.4       67.43        perf-profile.children.cycles-pp.__schedule
      0.00            +1.8        1.75 ± 23%  perf-profile.children.cycles-pp.poll_idle
      6.82 ±  9%      -3.5        3.36 ±  4%  perf-profile.self.cycles-pp.intel_idle
      1.35 ±  3%      -0.3        1.02 ± 11%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.26 ±  4%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.24 ±  3%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.set_next_entity
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.local_clock_noinstr
      0.00            +1.7        1.66 ± 23%  perf-profile.self.cycles-pp.poll_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


