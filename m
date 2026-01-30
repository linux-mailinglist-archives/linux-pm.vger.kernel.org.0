Return-Path: <linux-pm+bounces-41760-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7+U7N0lifGmTMAIAu9opvQ
	(envelope-from <linux-pm+bounces-41760-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:48:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C75B8080
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DA23300D464
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F072E88BD;
	Fri, 30 Jan 2026 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf73D8Ot"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746CC1D6AA;
	Fri, 30 Jan 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759302; cv=fail; b=NsKgjK1qgv/h/cwNtLZW1+I86cdxltFhpTz834vwcu/zJDA2zOSlXKHIVGNP5Sf2JY+TBGrmlUrTy7eviQ3fdwlfbw3vEhJkvCqFuljaUjbKJElSTnlL4Nt0pDWVuRUN3diFI6wQxVZkXCRP01zuU4XCPYnx8xBaVCRItz8Uvno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759302; c=relaxed/simple;
	bh=KPmx5XeDzxKFdtUhhsClhYvTBf7JwrPeFMMbNMJriKE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sGUh5AtWvUJHELArFGK4OT1ox3SAn3qoMWJgZKI5a0sr53xsunyMGvmJYVtjOuzGoAqX21WVgPIyYvg+0zwo06qPYtUjOe5B2d/VbW54SshAVvWwxIUZ4Gen32ErSy1RycTMCz+qI00Nx/5DLApwKkccVfJKmmIn+0MtyaEUBRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf73D8Ot; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769759301; x=1801295301;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KPmx5XeDzxKFdtUhhsClhYvTBf7JwrPeFMMbNMJriKE=;
  b=Bf73D8OtU1LVd98e4LGNdKhTHCQsbbP4gkUnyZfTxBJsY1DsREZF+aWP
   +J5CtoqO5Y0Gk7dcQ2lc/Qxg8LAl2qJfK79HqwwcuC3cHnKhlAkMsjd/m
   MPL2Ol5DQcz16GB9xHG1QdqIhsfrLJQZE/AQTl2D7KJ+vhGgteHKkEqy5
   OAJhd0pQtfz29nFQU3BbqPOH3Bf+/xSRKYQgihCavHygiWCtJz1gZ31ih
   q3ph/Whb/j3BvcKiLQAJzQ+owq7nGIGjqOm/JaTrBe0hCdpVrqBIHPWQn
   7sUtamulP0a7NCjfzRjGKCZAkDllqlVLF8AMnJpiwPU7makaIcuhQ4RUi
   g==;
X-CSE-ConnectionGUID: ftZ2m0UKSWuMnh6U3nWEmQ==
X-CSE-MsgGUID: G+9teum4T6mUy9BFLQhdsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74859697"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="74859697"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:48:20 -0800
X-CSE-ConnectionGUID: hhXylaMoTBatpgHs2Hwk2g==
X-CSE-MsgGUID: 8JILrHvHRD2IbIVZfEExzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="231713759"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 23:48:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 23:48:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 23:48:18 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 23:48:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sfhk2lD0uCgjhIhkG1zmOoXux53PEkZQTfcxunD4FRtCfkKIa+VPiDtcQl3O+WwJx4STDkvcoSJyph21pKvaCD7YlrdlNtCrGvru+Nom1b2nBJxvurnq1aQxC1mulVcoSwVG0INmTKdRngO3jYt49zu+0H+s7tU+nabhLXWFQuqqd57oz5XxmoioKbwPUfRmflQcZb1XB24c5rdVvbQ3WtM4fiQmq10HUmMhkmpO30wb2v2vJI6gBrGIBFeCNdnsNEii3RoUJppV0aZpqFuQkIIEXjsAVOOSkO/7b7Pv60q42tGzXvrcWJdjvoQ7WLvgOq22bJzwTSoMTVjSr+cgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLHamYBtoShK+4Ave3oSMeflJSsCxVy+C5nO8JOHGLQ=;
 b=H1v7M5AdxOe0lLW1AraiQ7+S4v05e944AjhXstpm9n7xZ1/IfnNwaPqVbQ5wypCdZ9dL19HQj4Od67W5BIE3VSfs7uu+AUNglDNmWdWCFKdxIBgbK9CaMPrUrEvcx9apFicrP8aGcPCg8y1rQI5myGw3hflzsXlefGkCbd2uhS107are4eSrieHiuRqvQq8xEuFpQ7VnHdQTNH3RTu9BI3eXwz3lp8T4f4T9lem14Xj55Y5ojgDL291PR268yA+UKAcvaRKG2g/xACJ5kqjNCdauVSJ5ah43n/8T5uI0xkKLMdfyZ+RhQThF/bsSI1/3lU9t45Ti1/gA8fNw9Zauxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Fri, 30 Jan
 2026 07:48:12 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 07:48:11 +0000
Message-ID: <66d63d13-8e49-4101-acab-a6a5203826ca@intel.com>
Date: Fri, 30 Jan 2026 09:48:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] i3c: master: Mark last_busy on IBI when runtime PM is
 allowed
To: Frank Li <Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-4-adrian.hunter@intel.com>
 <aXu7UduYCweVLxdK@lizhi-Precision-Tower-5810>
 <1db7b04b-ee65-4791-8db5-0dffc7befca2@intel.com>
 <aXvJTPWhQwFfv57G@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aXvJTPWhQwFfv57G@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 296f49dc-3543-4793-93f4-08de5fd3ea62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aitIbHRBKzM2ZCtmaFM0c0NLdTBOSjlBVkZZZEpIZUdpQ2txMm9xYi9iWGsy?=
 =?utf-8?B?SlRhRDVIZGJvdmgzNWNDbk9RajVLVnZiR3RCMCt0RTAyN0VtMFhJbWI5SXE3?=
 =?utf-8?B?V05iSE9vYy9jWFJ6UmtHQnpVSUI1b0RZeFpNU2J2WGNOTWcxREUxUFFZdFZ4?=
 =?utf-8?B?NVhMa1RUWWd5NnZXeE90aTJaMHRVd0l5OVlENGVNWVJGb2VCMXhVWkNNZnVD?=
 =?utf-8?B?a2t0TEZRV2lnbkVaeUdIdk0yZjVNQ3FVV2VUVjZxL0xQYU1mNlF5WUZ5U2F3?=
 =?utf-8?B?TkdIRFFONWIxbTRMWlpUVGlsRVZ0MHRjQmJqcUU4UnE3K2xuVTR4cUYydG9Z?=
 =?utf-8?B?U0FRREdZWnp6bU0xVnNhNHVKdkd1M1JIREt1dVJINzhUODZrMEN2OHRYdVVN?=
 =?utf-8?B?aTZOTXEza0hpWU5aOE1pVFpHL09RaHVMdjBoYjEzYzQ1QjJ6SWFTcCtSekVL?=
 =?utf-8?B?bEpLVFdUK2tCVGNMWVVJMFIrTS82SzNGRUlvK3podE11S29vaTZtZElkL0tZ?=
 =?utf-8?B?THFoSWsyTUI4dWhVNmhqZTc5bkJxc0Y3bkRSMWpLUjZmS3Z1MGZtVjZ0eWVW?=
 =?utf-8?B?dmVvM0laWjROWGhKeTRDTkk1WGZwWDErbGdMbU9pTERqb3NMTXUreEtvaGhQ?=
 =?utf-8?B?TlRUWEpRSC9wajZBdW9qRkljQlRldEpzVlZUL0RsbUxuejJ2Q0ZSclN5MnAy?=
 =?utf-8?B?V0wwVWo1L25NakxyWkVZVUMwUThYaUY1SGhmVjlLdlZRWHlabWthdTQwMy9X?=
 =?utf-8?B?REhNTVNnQnpsc2xOMDVwbDFuVzZHMnQyTVN1RFliUS9tQTIxUHRkNjJnVkwv?=
 =?utf-8?B?MTF3OGM1RThQd0QwU3I2TktvZkFJd0lBbHVtdGl2RnN5aTRUU2YxQVF2b2hX?=
 =?utf-8?B?OU8xVmJoK0FlRitTNWUydm9hVHQzVFl4MjNhTkFIWHpVYk4vbjdJRmYvd1Av?=
 =?utf-8?B?YTByc1hWVU5idlprR1BBSnhNWm9rUEwzZE5LYVlURDZTejVWZzZod1JRcGdi?=
 =?utf-8?B?ZCtJM0N2d09rc2tCMURtTFJiaCtWbk94aDY4RGh5d0tROFRTUFJzWTYrd2w3?=
 =?utf-8?B?d2h4ajJLY0dxVkp4RDlHdER5emEyR040REFOY0FuOWpoNDUwRjRNckRCb3Vr?=
 =?utf-8?B?dTk0TUFQSHRma3BSbWUzRHdyZS9IdnI1TnJQZ3orV2lYeHkzSWxBQlI5VXIv?=
 =?utf-8?B?dHBGTW5US0JZakZiNXBEZEN4MkcwcUdtc2RnWFc4QzgybVdGRTZSM3Nub1BT?=
 =?utf-8?B?RDZkM3VhREhRT3FuOCszZmxad3VqdzcvaE5LU2dWMCtTQ252d3M4Y2hPRWVZ?=
 =?utf-8?B?aUpuaWtjVWl0bXk4UHV5NDJDcGw3QzJBaThlT2R3VDNremhzZlhTd3RZSDFN?=
 =?utf-8?B?RVMrNE5PbXB4Q3BGWXg3WEZlK1laeHFHZDVJSHNtNlQ3SmYyWGVIbDFaVVZG?=
 =?utf-8?B?cXFBODE2L1J2Wk5aN2JCT1FzQVJmOFdzUUJURWNnb0Flb1czeVM4b1d1NFhs?=
 =?utf-8?B?QjlLTWNpRFZnZHZsQTVZMG91K2lqT0RTN2lGL1JoeUhDK1NYeGxOaDk4aWhP?=
 =?utf-8?B?OXc5ZzNSZWFoOW5UNUlIOXVVeDZTL09WL0hyZXpTaGNvVytRQ1Vmbi9kQ0gw?=
 =?utf-8?B?d1hFUnAvQUJVanNYcTM3OGFQWWFHN1NXaEs5ZUhLY2lvVWxFNjU5ZE9hSWFQ?=
 =?utf-8?B?TGp0ZFFaWGtGUGt2ZnMxQUdFNnlWcUU0R1dNcEk4bjUyei9SYVBmYTVZSHlR?=
 =?utf-8?B?c1c2ZCtVV2lsVERlUW1OVFlZSTIxcTFXT2hzS1k4Z1c3RVZQeWFobWtTai92?=
 =?utf-8?B?OFVhOTFyMVBwRk5laGNiRmpsOVpHMnQzbCtrY1hlWkJ4YXcwU1ZCY01UUlBt?=
 =?utf-8?B?TFo2WGRjVFhiaGNCVXdkaEh4dHZVeTlsMkJHOW9KcmhtQllaME0xRUVtRXlY?=
 =?utf-8?B?M3F5UDNSK1JydzFwU2hPUWFsa0pFM2s1OFlkMTFHM3pRcmpMdWx3RmRRU09y?=
 =?utf-8?B?Y2xvVHdLQ0c1RTJEZmhiaFNBalZPSmVxYmFjQ01ITkRRUENpVXJhVlBvTG9n?=
 =?utf-8?B?bnppdk9WSnRiZSt3clZVb3lyL05GbkhHc0hReEppT1I2TTN6MW5Ra2tianNj?=
 =?utf-8?Q?SCfs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWVzODhNTExjZlpIcnR3OEx1L09Edno3RFQrSGVaM1dzTHM5S0RHRnNqaDFP?=
 =?utf-8?B?aVZBSWxZRDNVOE4rL1JKQlJFWnlVcW1oQ0k4SFB6NTBQVk1JOFl4UUJQdG5G?=
 =?utf-8?B?YmRVZVhaK0FDT1loRjNJWmpNYnVpb1BaWnVPaFp6TzJMeFVvbG43ZURrWDI1?=
 =?utf-8?B?cXlEZG9mMUx4NGNpT3BCNUdJYU1udnozeFVUMklxc1RxWnFwWktVenppU0xw?=
 =?utf-8?B?bjJCVEpxMHU3S1ozZ0RpWUIxN2RhN3d5TlZuY2lDYkIyV0tqTjhMSkU4TDdn?=
 =?utf-8?B?RkZKUThTQUg2QlZIVG5ncm90eUJDTlpBNnFnL0JVOGlVUHA5aXFlRFdpN0tx?=
 =?utf-8?B?WDAxTFBZSWorazlwT3FmK1dhaTgySGloWjMvZ3hPSExTNVJVdlIwRHNSMzRt?=
 =?utf-8?B?c0lYLzFRNjZTTUVhejRHcGVwbVZWRDgyRmw3WnI2aUI0bmpabDAyU3h6ZGcx?=
 =?utf-8?B?ZjJDalJzbHdZWTJibVRiajg0enpRVGxabEl1OUFhL0lLSnJHeUh0MG5WN29y?=
 =?utf-8?B?QjVYdThtaXBwWGtIMXJJMzI1T3lRa3FGMCtKNFpOamFGTmxlelcrYzlLZGpt?=
 =?utf-8?B?UGxLQVJsbzZFNWdRbGtOL1pONnpRYkZHMGVlTHhsSGRzdU1ONjFCRHhFVTRz?=
 =?utf-8?B?Rktlc0NRNmRGSVR4YUFkWkhWUE5CdmpVeVd5bExNQnJQNnkxa25ia1U5bE9m?=
 =?utf-8?B?WDF5VEdYWFUycEVPTyt2OE41cmkyak9aR052bWR3cGZuM3ZEdU5sbzZKOUVp?=
 =?utf-8?B?WFFUczIvUnNsdmdWS2ljTkMwNFl5Mm5hdkY2L1ZwWnVHNnhhOGFtbmZDbm1l?=
 =?utf-8?B?MEkrREhSdFp5UGxTL3c4Z0JXbFNEWFAzUGYxRWxDdE8rRGJLdVg0cXR2cWlD?=
 =?utf-8?B?WnVLYlFvY3RWbDlqbkRESkFmZUpDdkIycXo4endMd2VHdE5kVHFoNS9HMDdE?=
 =?utf-8?B?MVRxd1VZdGg2MWZndFRhTHR1SlhyZkdJOFFISWFEUXM3YTR0VHc0RUZPb3NC?=
 =?utf-8?B?RGpWdVFIVFdiclRQNnY2djJnMzMzdW15b3JRV0gxL1NNYTdaRVVqYUJQZHZv?=
 =?utf-8?B?UzRVcW9Kd0k5UCtFV05ZZ0hndkFPbmVPd1FjUXFxTEhNU2tlc3NVdVB1VURY?=
 =?utf-8?B?T3ZkK3M0NjZxdG8rNHN1TlVRNmcvSTBBNzczbiszVEkrOEkxUmVpMmVESSt2?=
 =?utf-8?B?YS8rMjVhb0JnbVdya0NDVjR0SnpKb1M2NVJCL1RBb1BYcWpIUDF6QVVtV012?=
 =?utf-8?B?S2xnbWVzVEtBUXZReUNDNVpJT1JEY25jUzQ1Yll4c0REMHF0MDF6OUlqLy9Z?=
 =?utf-8?B?UHRtdGxsMlFjVzJJUGhWckozT01uWjRYNnU4Sy9XNG5PQmVDbVloWWwwekhv?=
 =?utf-8?B?Q3RtWDlscm9FQitvcE9pVTB1dVEvSkRMOENUaVdjUWc3c3RWc2xKTk5XZmM5?=
 =?utf-8?B?cmJ6K2RFR1JiV3Rhc2xDbnI5Slo4TnRVcEw5MnRNK1IvWjl5S0d2TjBvZ056?=
 =?utf-8?B?M0xNT2w3SmZvN1E2L3Z1Q29IdC9McUN4RWc4REg0dzBQV1FmNFRTQXlCTjlW?=
 =?utf-8?B?c1lWUVNwK0sxd096MFBydzJwb094cytpVFJ5cG95VUJKNGdPeVlkTS9KeUNi?=
 =?utf-8?B?UkRiZW52S3lRTVFaTTJ3T1N3K1NTZFlsYU5EenBZWHo4ek5GL3pnSlpFRCts?=
 =?utf-8?B?Y1Fib0x0UnVaT1A4ZGVuNVNmM3ZlWUdNKytPOExBNG9EUFV4Uk5yZVBXZ3px?=
 =?utf-8?B?ZUc1aGRNM3gyOW05c245VGl1aHZTN1ZSRWlSNEdCeldzQkg5QUZHb1JqRVQ4?=
 =?utf-8?B?WXZhb2lJdldKbUlPUE41VHlSZThWWnFmVXBjU1VpZmFiaFJwajdYMGlqalVq?=
 =?utf-8?B?WVZQK2hPRmNIcUlobTZIT2phdDJtOThqVnQvL1I1LzIzaDB3VTdwMlhLN203?=
 =?utf-8?B?K2x3QUN4Ulc0N1dSQU0rWnhkMkFWYmYveG1jUzZyQ0F3MElZZzdFSU1SdVlz?=
 =?utf-8?B?MTZZakIwZWJlMXdaMXhDeTYybnJ5UmhnUnJiSm9XcitsbTJaZVJJVlk4WFcr?=
 =?utf-8?B?RkxNMElGcXRaUDU4WkQrRzFoZnRoQ09DMlA1eExEOHRuaDFMc2ZDSEZtMHUw?=
 =?utf-8?B?WHNhOWdjYlRLcXdDTStadDZUSy9nVzQ0UHZWR3NwSE85WEx2WXVYZGlNUWVo?=
 =?utf-8?B?YXZrVnJJSzFXdy9ncE83OEw0azVpbFV1ZkMwRlNlZTVPL0J5ai9GZDNQUkpH?=
 =?utf-8?B?WHAvMWhUTldpUjNXVlVSazRkdkoyNWZrdmRvbkFXY1dLYjlNZno0WDg5TzNY?=
 =?utf-8?B?cHF3bW1rSk5SOHc3TTBWQytaNnB2Yms1Tk9PS0kzSTdveXFYNjZQdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 296f49dc-3543-4793-93f4-08de5fd3ea62
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 07:48:11.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffgOo43yLnM9HzabTpWJQanatGKgAfR0fr8kw1PxcUYY22EUi/0N8qWliXBxL5NRU1EzAkamlOcyLEoZ3XLUQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41760-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 34C75B8080
X-Rspamd-Action: no action

On 29/01/2026 22:55, Frank Li wrote:
> On Thu, Jan 29, 2026 at 10:42:32PM +0200, Adrian Hunter wrote:
>> On 29/01/2026 21:56, Frank Li wrote:
>>> On Thu, Jan 29, 2026 at 08:18:37PM +0200, Adrian Hunter wrote:
>>>> When an IBI can be received after the controller is
>>>> pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
>>>> device is auto‑suspended.  In such cases, the runtime PM core may not see
>>>> any recent activity and may suspend the device earlier than intended.
>>>>
>>>> Mark the controller as last busy whenever an IBI is queued (when
>>>> rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
>>>> recent bus activity and avoids premature suspension.
>>>
>>> look like this can't resolve problem. pm_runtime_mark_last_busy() just
>>> change dev->power.last_busy. If suspend before it, nothing happen.
>>
>> It should be effective.
>>
>> rpm_suspend() recalculates the autosuspend expiry time based on
>> last_busy (see pm_runtime_autosuspend_expiration()) and restarts
>> the timer is it is in the future.
>>
>>>
>>> irq use thread irq, in irq thread call pm_runtime_resume() if needs.
>>>
>>> And this function call by irq handle, just put to work queue, what's impact
>>> if do nothing here?
>>
>> Just premature runtime suspension inconsistent with autosuspend_delay.
> 
> 
>    CPU 0            CPU 1
> 1. rpm_suspend()    2. pm_runtime_mark_last_busy(master->rpm_dev)
> 
> if 2 happen before 1, it can extend suspend. 2 happen after 1, it should
> do nothing.

2 happening after 1 is a separate issue.  It will never happen
in the wakeup case because the wakeup does a runtime resume:

	pm_runtime_put_autosuspend()
	IBI -> pm_runtime_mark_last_busy()
	another IBI -> pm_runtime_mark_last_busy() and so on
	<autosuspend_delay finally elapses>
	rpm_suspend() -> device suspended, PME activated
	IBI START -> PME -> pm_request_resume()
	IBI is delivered after controller runtime resumes

> 
> Frank
>>
>>>
>>> Frank
>>>
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/i3c/master.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>>>> index bcc493dc9d04..dcc07ebc50a2 100644
>>>> --- a/drivers/i3c/master.c
>>>> +++ b/drivers/i3c/master.c
>>>> @@ -2721,9 +2721,14 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
>>>>   */
>>>>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>>>>  {
>>>> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
>>>> +
>>>>  	if (!dev->ibi || !slot)
>>>>  		return;
>>>>
>>>> +	if (master->rpm_ibi_allowed)
>>>> +		pm_runtime_mark_last_busy(master->rpm_dev);
>>>> +
>>>>  	atomic_inc(&dev->ibi->pending_ibis);
>>>>  	queue_work(dev->ibi->wq, &slot->work);
>>>>  }
>>>> --
>>>> 2.51.0
>>>>
>>


