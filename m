Return-Path: <linux-pm+bounces-28425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A072AD4851
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 04:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784AB189081B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5E13F434;
	Wed, 11 Jun 2025 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBGZbyl0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5B561FF2
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749607370; cv=fail; b=qx2a9uTWU65dNM/By/88N+VkVJEQCWM02K396YT7FhgzCkp9y6GuoF5RWOXL/TqDtdzYsDUQdmid0+Q7UcmqswjWQ6qlPWs59T/lL9riCpQkXwGJe0RM9vuIrt56ePC/E8E4oqBjxP39YYH1SDH2UtsW+wSRxfJfEbEaeUXm9Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749607370; c=relaxed/simple;
	bh=V2nh/oFpJLEpBYTjOgvEaJTTbqqYrXzaBD/3mp3TJew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J0hAmW4j3Y6L9zvdGGoRnbDBiFNsMABMwWZnf/52q6YNJaaPDXcNVnMCLg2SSH5R8T+R1bSdxx7NIu4UJvHVItiW1KQsjgOVFUJNRe1emfUhNkAeGpsCbMTConVXaRl26/Yy8CuvKnGhAJaF9GfRyrwtLiYtCdC5hO6owI5a0m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBGZbyl0; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749607369; x=1781143369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V2nh/oFpJLEpBYTjOgvEaJTTbqqYrXzaBD/3mp3TJew=;
  b=iBGZbyl0dOPCwGNj9SSqlaqu1cU5ynEBasJpMFcAi4IN878U1lBjy2Jo
   fgoKMn0c+yCH08+JMeV+5Og0I4M5ZW5lb0/r8yTrVvzej46PLTCNqxohT
   UKRL8CFkrYddEUu6ia3dBObhwrCCqiEWWHEDEsq5RV2FHGWef7BhuF+LH
   TVMg4/dOgIDrw5IV1Hr2Y+XShnfLdUebSqvsCX+TOjpzU8qvAuEAZ2qo1
   WolOvNb9cGcI2kK9P0uLaYVQzszjSu4BtxclL62qgqX7KP2tz418KwFbD
   32Ys2nvFFI51h9z8lDus5XQwSxFaBqRjl3Uf+PU5biiz3MORoI8KWL3oK
   A==;
X-CSE-ConnectionGUID: rJkOE8w4QCSD0pn26MugRA==
X-CSE-MsgGUID: Nb2Zu3RlTvyIboINZeIlSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51616262"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="51616262"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 19:02:48 -0700
X-CSE-ConnectionGUID: Yu6U3obQQ+ix5Ln8PzJYsQ==
X-CSE-MsgGUID: 96dimGTFR2aOsplvrWg49Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150861153"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 19:02:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 19:02:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 19:02:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 19:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJqtpLYDoPkpv2zj3GnFAxcr9yPA0qjP5I7uQM+4SggUvtDmj5sjcMWMUo8NxQOx7igfcIXppVlwFxnmmDy1M0UoH4CS7RjqqROe7IKQ8mPfSsZbibidsiY0fMf4pVIsG6geT4d5IbMcbECvI1Mq2dG7NTk1mJbl4GGu0chyCvypJHHsQt9cllGglyoSOWQVO4f3zUw6f+w3IIXnaXqofzxcIhshF3U0m2j4AX8F4sxImJcB2cHEBjItJhrgebi5jJ5UvG2hmkIanoEIjWGXTWDs2MzNLp25ux+Lgh4Q3LWlFRuYtgYwGpH+a+dxKqJUw4wPqPtZ/IfahlFdp6RAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2nh/oFpJLEpBYTjOgvEaJTTbqqYrXzaBD/3mp3TJew=;
 b=tcIBBPWv4ZF6kClawrzJtfP4QuTLhfDp4ok8hthcPJXYqsN323VTMo56kTKaqUpPE3q8sgHIYt5R+gTkqSny+yE1KcoqZg33QS4XxT34JJPbTmXSnIuDKWi9KVAOVd8bYqE797oG8aX46PdTnIAtwFHhYRa32yh2RdMTwX8hPMs+kepAyzzid33zzissmd8gq1YQehgViuSBAUY6/9xhT6xxqE3vqFvhDlqClEReZbVbOHYuokjDXw4TQyI6Es9Wv08Yfe7ZyOn7Ddd66gTL1fwXm0ka6Rtto1CKHU5MTX2Y+NT2Yas4Hys7ADfS7BXiKyDlYqYtr2MT/oYP0kzAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by SA1PR11MB8521.namprd11.prod.outlook.com (2603:10b6:806:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Wed, 11 Jun
 2025 02:02:29 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 02:02:29 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>
CC: "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 2/2] tools/power turbostat: verify arguments to params
 --show and --hide
Thread-Topic: [PATCH 2/2] tools/power turbostat: verify arguments to params
 --show and --hide
Thread-Index: AQHb2lWgYrncXJwRtkChPIpDjygcs7P9NRgA
Date: Wed, 11 Jun 2025 02:02:29 +0000
Message-ID: <51d8569871c88bbeb449268b74157c099245fa43.camel@intel.com>
References: <5d939fbdd480cdf276eccc01eda3ed41e37d3f8a.1749593891.git.len.brown@intel.com>
	 <c07ce1369b8972c60993b86bfacaa77ceee3af3a.1749593891.git.len.brown@intel.com>
In-Reply-To: <c07ce1369b8972c60993b86bfacaa77ceee3af3a.1749593891.git.len.brown@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|SA1PR11MB8521:EE_
x-ms-office365-filtering-correlation-id: 293e1ace-d5b5-46db-b64c-08dda88c057e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ui9KRkkvYnRCcmFNTUxCTEFnc2NickVBTks4S1RaYjNrL1dtaytseWg2NWF5?=
 =?utf-8?B?YzJSWVJCY1hScW9wT1VPeFB6c2w1WnBHRUgrcFlPOFpDZzYwNy9OZStyRnNK?=
 =?utf-8?B?QTZYL2lTUUJaNlBHa3J0aW1NdHVuVWpiSzVnYnVJWjhCNDNjVWZQZitzZE9W?=
 =?utf-8?B?bERjUWdJTUcrM2RWY1ZKNGtPQ21tblNPUDJVbisrcE85REU2elNWdHErcTRN?=
 =?utf-8?B?YXRYWlRMQU03QTk0THgvMVRReDNYd1lrTWplTzNoTW1kNXV1YXpRN3E1ZEZM?=
 =?utf-8?B?YWJhN1B4WG1CYUJhbmRMeURtK0JmUlo4eXJaOG8xS2J5b3IyT1hqbzFUN0FX?=
 =?utf-8?B?d2FaQVVGcnVBNWJqQnlCME9QTk9BZkRQYXB3NStneDc3RGZqY1d4eThzSGsr?=
 =?utf-8?B?djdPSkl2cjYrMTkvbHVpc3VkbEtnUDQrQUFhOEdGazYwcVBkYTFKeE5qakg4?=
 =?utf-8?B?ZFQ5aUdEMUVYdjBKWXdIOXo5UWdISEY3MEtvclJVTHVYSWs3MzNyQXpDS1lt?=
 =?utf-8?B?aHRpQWdFejlSNnFUVVFIYzRseUViWjZ0cGh0d2NPM3Z2ck1QYXloRWYvbGhT?=
 =?utf-8?B?cjBaSFBTZjBDeGxBVWJxeHFZTEczM0oxbDM2UkkyWHdINFUvZmFJenJUdmtn?=
 =?utf-8?B?eEx5L1hYTm44TVNOVE4xQWxnc3p1b2dzZ2tQelE5QnpvWkh2THBOeTZvUTU4?=
 =?utf-8?B?WHd1cnFOZHpLMDNaVGRlTnIzQVJPYkxrUlFzeDlZOXp4QVZDVmw0aCtYbjBx?=
 =?utf-8?B?NmVBTnZIcEcrOHpEbExkcGJDaUQ5WE0zMm8rUHN4UEx3WStLR0NHdGE4V2JG?=
 =?utf-8?B?VzQ5NEZ3NlEyTmFMcTJLTFF5Mm82d29xVzRaOTlSdXZBbGhHWndaZUN0WG55?=
 =?utf-8?B?ODd3TXlyY09neXV5azdRT1RQekhxZFRkUEhCekp1QXNjQm9hT1ZGVDFVVXlB?=
 =?utf-8?B?U3dRdVlQT0IrRDZMRzc1bkt1MExpL2pGNkx3UEZ5Z0dzSXlKNnowOHhRb0cv?=
 =?utf-8?B?SVZPM051NUJSK3RYR3FLWEFyTkNObmZ6TTRiMmZJK3l5QkpuNHVrdXNMbklG?=
 =?utf-8?B?UWZoUW5NMnl3eUxpN3VtaWozT3BHYzdtajNFVVI1OUdROTFEdGROYXNTQitW?=
 =?utf-8?B?OXpSQXliZ2cxUnFRVHYySG5JNEZhRE85VEx1MEtFRTM2aHhaMks5cW1RK3c5?=
 =?utf-8?B?VDdCWGE0T1VTSU84U1dhRWp5QjhQK0Fpc2N6ay9HaVVELytYUTJubFlGNXZG?=
 =?utf-8?B?YlpTMXcyUnlEUUlwRHR2WHllWEU1empwSjdDMURzNldZR0oyVEo4T2lWQzlC?=
 =?utf-8?B?ejh5Mko1TVBxaFFRVXlMT2d6ajd3dHZHSFRNYllvc2VGei90ajZ6MERzSlRl?=
 =?utf-8?B?dVhteVZ5NDlrUFdNbHpENmJ3Rzk3TWU3WGxOaElhbXdCSU1WanJZZHpuUWRv?=
 =?utf-8?B?OEttdFZEU2pnbWdrLzJRa0kxZmk5enNpQU8zUEJsMEIzM1pPb0lxZWMyWm9i?=
 =?utf-8?B?a1B1eTlwdm9DOG4yNnN4dVJqL2U0RFVuN3Z3ZXNrR2Nkc2dKc01BLzhldFRz?=
 =?utf-8?B?bCszVTRvaGk1QWNOSmJJYUxobUtuejBVYklaNnBER0w1T3hPVGUrT3lPT0Zt?=
 =?utf-8?B?NklpUVRKUml5L0x0UzRYL3ZiamhsRERvaFdYS2JZMDRFOHVlYi9XSWxnUTE1?=
 =?utf-8?B?UmVlSlgySCt6RGd4WERrdi95L3JCR2F0WFIzaUdEa0doZTVYdXZMd203dmtn?=
 =?utf-8?B?OGJGK3JGdVBJM3hUN3k3WTVqRGQyb2NJbGhtd2pldmxHN1lsaXRFbHNjSndQ?=
 =?utf-8?B?NWhrL0pQUVRYWnZzWDlIZTRzejN6ZFM5WW9EdWR2Q1VmYS9NeFM3bkxmbXY4?=
 =?utf-8?B?MUI5bFRUNmE4VUFyaEpYWDU0eGs5YmNLZVN4VWRxQXd1WVFiZkZPM1dkRnRD?=
 =?utf-8?B?NFd0N2JlUVc1UEZKMzU1aUI1ZWpJK0FpZVlrK0Zyd20xa3AzblR0djgrK091?=
 =?utf-8?Q?3EeyIE/TSJLJGG2JsH3SEZwwKXELfo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXdWeGRXcDFlak1mbGFMV201SXlXR2FqbGx1dFlGQ3l1RkFMUVVkRERkM2RZ?=
 =?utf-8?B?OGV3V2FQOW12UHkwVTR4YXZhYkpOL0tiMUd4MkpSNTJ5UnE3L09tUnFDTU9h?=
 =?utf-8?B?NUM1QTNhMUVOOFhXWTdVQUorY1h0WWp5czAvNG5NYlJ5dEJ0YmtFa05adUxo?=
 =?utf-8?B?Ykd4SXovcUJmRjQrOGdpM0svdlRQTzl2K0JvbDdNWWVTMTdSbWFOKzhjTVR2?=
 =?utf-8?B?WGVvMVp2a3pVZzJhNVQrYmF5WU0vdlJrbFFNajdBYU5SeHhucGY2VU1TQkdW?=
 =?utf-8?B?b2NXSytJYUZtSEVzUnhsWU5yRWFYRTYyVlAxazhKd3Z4Qm9RdytNWmV4S29w?=
 =?utf-8?B?aFhXV1FPak1HYjdFSmJvLzQ4eXErQ0MvM1Y5dDQ0L1dHOFdnQVlPL3k2RlJs?=
 =?utf-8?B?bW9lRGcvMFBhN3NyVlo0TzMrMDNZTmtER2FDWmZrcWpLQ1BpT0o2U1NlVWRa?=
 =?utf-8?B?Z0JxRE9Sa1p2YWY3SmZvbTRnd2xzc1NoNG5HVkxiTG40NS9uNnNuUVdtd2ht?=
 =?utf-8?B?cHpma3RhaUh0eWRoK0s5bVhLZUR0VzVOT0NjYXdRSWJIS3FWWGFHRXFnbjZ3?=
 =?utf-8?B?N0UxekJoY3paTUZ4Nnh0bmRZOVdKVjBtbUxsNWplWUVZVnByZnRCZUJkejBT?=
 =?utf-8?B?RGtPcTZ5M0xlUnkwUDhiSmtNUStucEtCemFycG9ENmZGMncwUGJXbnpPU1o1?=
 =?utf-8?B?T3BrK1AzMUlzeUFSSTlPVjA0YmpsaEwyWFlQT0tqSVhBWFhta2RleGZLeXZh?=
 =?utf-8?B?YXU4SVN2eEw2ZUVxb3FXVERKL0ZHTzRPWERxMmJjZ3RHUTNjUVRPbi9rajRk?=
 =?utf-8?B?N09hdjBCRzdlTlV0NFljSzNyL25ya0RIaXFFN3cxQ3BHdWJxSjd6THl1bHhV?=
 =?utf-8?B?eDI5d1pGNzZURFdHRmpobElUZVpkczlHT1haOWpjdFNVamtMWXV0aWJjczl3?=
 =?utf-8?B?Q2wrdWNSekZEaDRiejl6N0pLZ3UyZTg5bkRxamdHRkdvVzB3OWp4OS83NnBN?=
 =?utf-8?B?ZGpoQW5pQytiLy8rd0M0Ry9hOUhsNjcySTJtZUorb0cwb1o4U0VaZ3hCNTl5?=
 =?utf-8?B?OWNtaWlNYVFWQkxqek5DY0ozcGJpUWN2bmdSdW41dng2cDVRVU9BZ2xQSy85?=
 =?utf-8?B?eWMyQlE0VWJvbnZqSHowUVJGY0Q5NmtxTloxS0xHc09WeFdQK0F6dTRXc1NC?=
 =?utf-8?B?VEcvcVdMdzJTb0w1K04wdzZjdzdOYnM2U21ObmtLMUllaHBaYkY5aDIxdU5J?=
 =?utf-8?B?anJQSkZFczFBY3VkMXZpbk1vY0dVckppdjRVeWtRdWlyQjA4ZGNPa2YvWWVW?=
 =?utf-8?B?dG1PTTNiNndXNm95OU1sdzMwUVVHRk1jc0VQMzBRZ1V0N2ZZV1FlVktSL3p4?=
 =?utf-8?B?YUlXTWZ6NEdWazIxZE5KVVBxcXVFdWdnbEM1MzBMbkd4NW9JSWQ3Qi9wQ0h3?=
 =?utf-8?B?YXl0MkovWXdTZ1Y0ZS9MMkZVRDBnUDU0VHhMRFByYW5BdlgrK01UVGRPTU1E?=
 =?utf-8?B?NFVFRW0wUVpJa1pTa3Iycld0RS9Bb0dpTGo3K0tRZTc5cVNvb2NtRnNsbnhj?=
 =?utf-8?B?YXhlSFR6MVpRTEZpQkw0UEtYRmlXZW1PRzExUUxrc0pNdEw5U1hROXh4Nys5?=
 =?utf-8?B?aDg3bmVsQ21IdUIxL0NNbmp6OFE4SVEyTVdPcFY5K3lxa1pVdVlYMWxwYlpS?=
 =?utf-8?B?SUhkL2VMOW9GU3J1ZlJWejhNRzFRM2JGVVFSS0ozOTJDVXovOW5NTTJvbnFv?=
 =?utf-8?B?T0lQRlN3N0MxVjNVRU82L0JkazIwTTlzRUhwZjd0Zm1vemV3S2JJNmVKWXdV?=
 =?utf-8?B?cE5JRWRsZzQwQ1NkdUVzQUFuN0hSaWxwMERMUnA2SDBKOVV0ZkFSSGFaQWdI?=
 =?utf-8?B?cEw3RmtxUUZKRFJCejdGejJkbkNkOENnWmRmd0tzTnRIL0FVdk43RDg2Nndp?=
 =?utf-8?B?T1dteGQzRkJZMndyZDFodUVGS0Q5cVBFdUZNU3N5aCt6ODNzODNDeXdvY24x?=
 =?utf-8?B?YS9ZaWhBQXJhRUhtLzVIWlFoSUh4VjY0Q3JXQlRpSzJocnBkU0xkSHg0U24r?=
 =?utf-8?B?NXZneHZEdDNmZU5ZNXBHOFEzQ3FWbGVwMGgxM09MVlk4TC9udTcraFRNOTJm?=
 =?utf-8?B?ODkxRWpBZFJjNFcyWU11MFR1bnFibjhnWmY3UHlHZ3lNOU1lbkVKc3ZINm4r?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1022569B781D444BBD03716955D761DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293e1ace-d5b5-46db-b64c-08dda88c057e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 02:02:29.7436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyYADtpygFYuKYriE7EhAy2DWNp2thF7AWQyneFkhBsIdt4dIqwrU/xCgPhcFOODkF7ZsQA9/SitGrfI67dm/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8521
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA2LTEwIGF0IDE4OjE4IC0wNDAwLCBMZW4gQnJvd24gd3JvdGU6DQo+IEZy
b206IExlbiBCcm93biA8bGVuLmJyb3duQGludGVsLmNvbT4NCj4gDQo+ICQgc3VkbyB0dXJib3N0
YXQgLS1xdWlldCAtLXNob3cganVuaw0KPiB0dXJib3N0YXQ6IENvdW50ZXIgJ2p1bmsnIGNhbiBu
b3QgYmUgYWRkZWQuDQo+IA0KPiBQcmV2aW91c2x5LCBpbnZhbGlkIGFyZ3VtZXRucyB0byAtLXNo
b3cgYW5kIC0taGlkZSB3ZXJlIHNpbGVudGx5DQo+IGlnbm9yZWQNCg0Kcy9hcmd1bWV0bnMvYXJn
dW1lbnRzDQoNCm90aGVyd2lzZSwgdGhlIHBhdGNoIExHVE0uDQoNCkFja2VkLWJ5OiBaaGFuZyBS
dWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCi1ydWkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExl
biBCcm93biA8bGVuLmJyb3duQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgdG9vbHMvcG93ZXIveDg2
L3R1cmJvc3RhdC90dXJib3N0YXQuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKystLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9zdGF0LmMNCj4g
Yi90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jDQo+IGluZGV4IDMzYTU0YTll
MDc4MS4uNDA1NmI3ZTI2YTBmIDEwMDY0NA0KPiAtLS0gYS90b29scy9wb3dlci94ODYvdHVyYm9z
dGF0L3R1cmJvc3RhdC5jDQo+ICsrKyBiL3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9z
dGF0LmMNCj4gQEAgLTIzMTAsNiArMjMxMCw4IEBAIGNoYXIgKmRlZmVycmVkX2FkZF9uYW1lc1tN
QVhfREVGRVJSRURdOw0KPiDCoGNoYXIgKmRlZmVycmVkX3NraXBfbmFtZXNbTUFYX0RFRkVSUkVE
XTsNCj4gwqBpbnQgZGVmZXJyZWRfYWRkX2luZGV4Ow0KPiDCoGludCBkZWZlcnJlZF9za2lwX2lu
ZGV4Ow0KPiArdW5zaWduZWQgaW50IGRlZmVycmVkX2FkZF9jb25zdW1lZDsNCj4gK3Vuc2lnbmVk
IGludCBkZWZlcnJlZF9za2lwX2NvbnN1bWVkOw0KPiDCoA0KPiDCoC8qDQo+IMKgICogSElERV9M
SVNUIC0gaGlkZSB0aGlzIGxpc3Qgb2YgY291bnRlcnMsIHNob3cgdGhlIHJlc3QgW2RlZmF1bHRd
DQo+IEBAIC0xMDUxMiw4ICsxMDUxNCwxMCBAQCBpbnQgaXNfZGVmZXJyZWRfYWRkKGNoYXIgKm5h
bWUpDQo+IMKgCWludCBpOw0KPiDCoA0KPiDCoAlmb3IgKGkgPSAwOyBpIDwgZGVmZXJyZWRfYWRk
X2luZGV4OyArK2kpDQo+IC0JCWlmICghc3RyY21wKG5hbWUsIGRlZmVycmVkX2FkZF9uYW1lc1tp
XSkpDQo+ICsJCWlmICghc3RyY21wKG5hbWUsIGRlZmVycmVkX2FkZF9uYW1lc1tpXSkpIHsNCj4g
KwkJCWRlZmVycmVkX2FkZF9jb25zdW1lZCB8PSAoMSA8PCBpKTsNCj4gwqAJCQlyZXR1cm4gMTsN
Cj4gKwkJfQ0KPiDCoAlyZXR1cm4gMDsNCj4gwqB9DQo+IMKgDQo+IEBAIC0xMDUyMiwxMSArMTA1
MjYsMzQgQEAgaW50IGlzX2RlZmVycmVkX3NraXAoY2hhciAqbmFtZSkNCj4gwqAJaW50IGk7DQo+
IMKgDQo+IMKgCWZvciAoaSA9IDA7IGkgPCBkZWZlcnJlZF9za2lwX2luZGV4OyArK2kpDQo+IC0J
CWlmICghc3RyY21wKG5hbWUsIGRlZmVycmVkX3NraXBfbmFtZXNbaV0pKQ0KPiArCQlpZiAoIXN0
cmNtcChuYW1lLCBkZWZlcnJlZF9za2lwX25hbWVzW2ldKSkgew0KPiArCQkJZGVmZXJyZWRfc2tp
cF9jb25zdW1lZCB8PSAoMSA8PCBpKTsNCj4gwqAJCQlyZXR1cm4gMTsNCj4gKwkJfQ0KPiDCoAly
ZXR1cm4gMDsNCj4gwqB9DQo+IMKgDQo+ICt2b2lkIHZlcmlmeV9kZWZlcnJlZF9jb25zdW1lZCh2
b2lkKQ0KPiArew0KPiArCWludCBpOw0KPiArCWludCBmYWlsID0gMDsNCj4gKw0KPiArCWZvciAo
aSA9IDA7IGkgPCBkZWZlcnJlZF9hZGRfaW5kZXg7ICsraSkgew0KPiArCQlpZiAoIShkZWZlcnJl
ZF9hZGRfY29uc3VtZWQgJiAoMSA8PCBpKSkpIHsNCj4gKwkJCXdhcm54KCJDb3VudGVyICclcycg
Y2FuIG5vdCBiZSBhZGRlZC4iLA0KPiBkZWZlcnJlZF9hZGRfbmFtZXNbaV0pOw0KPiArCQkJZmFp
bCsrOw0KPiArCQl9DQo+ICsJfQ0KPiArCWZvciAoaSA9IDA7IGkgPCBkZWZlcnJlZF9za2lwX2lu
ZGV4OyArK2kpIHsNCj4gKwkJaWYgKCEoZGVmZXJyZWRfc2tpcF9jb25zdW1lZCAmICgxIDw8IGkp
KSkgew0KPiArCQkJd2FybngoIkNvdW50ZXIgJyVzJyBjYW4gbm90IGJlIHNraXBwZWQuIiwNCj4g
ZGVmZXJyZWRfc2tpcF9uYW1lc1tpXSk7DQo+ICsJCQlmYWlsKys7DQo+ICsJCX0NCj4gKwl9DQo+
ICsJaWYgKGZhaWwpDQo+ICsJCWV4aXQoLUVJTlZBTCk7DQo+ICt9DQo+ICsNCj4gwqB2b2lkIHBy
b2JlX2NwdWlkbGVfcmVzaWRlbmN5KHZvaWQpDQo+IMKgew0KPiDCoAljaGFyIHBhdGhbNjRdOw0K
PiBAQCAtMTA4ODUsNiArMTA5MTIsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
DQo+IMKgCXByb2JlX2NwdWlkbGVfcmVzaWRlbmN5KCk7DQo+IMKgCXByb2JlX2NwdWlkbGVfY291
bnRzKCk7DQo+IMKgDQo+ICsJdmVyaWZ5X2RlZmVycmVkX2NvbnN1bWVkKCk7DQo+ICsNCj4gwqAJ
aWYgKCFnZXR1aWQoKSkNCj4gwqAJCXNldF9ybGltaXQoKTsNCj4gwqANCg0K

