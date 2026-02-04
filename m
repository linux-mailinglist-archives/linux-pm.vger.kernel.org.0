Return-Path: <linux-pm+bounces-42108-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F3HBuaPg2n6pQMAu9opvQ
	(envelope-from <linux-pm+bounces-42108-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 19:28:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E6CEBA6C
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 19:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 984B1301BF75
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD5641C2FA;
	Wed,  4 Feb 2026 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtYsIxxK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612642EF652;
	Wed,  4 Feb 2026 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770229682; cv=fail; b=g4hwok5/rNrg3l48Swzwwrmw2yTLatN7pjIqa6sPkSbq75Li2ggOmdcw7n1HzPErfTTA+df7j14+VvoosVuLJaM51sao0TVGxKiFii/wOnBsB0uGashl9G0tqZhNtjmixpben4Zvx+pFkKF0l1CMcUIldunFW510MYGcYQ1yhKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770229682; c=relaxed/simple;
	bh=nQFkkuMkmVRVnqsl7J5n9PeHIPkIs4++6mYa2rJaGJ4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VAM50P2o7W9hHxcKdkU3ZyWB0txI8tbObCRaEnDVspO9TdcHhp9OqZL1+EykJpr+4NVOJMmIS3Dg09qAQiAVvSqwlKNjHUjz7w7gAeSeahtYy7VGgLl1jhB+ipX5G6wU1mS4hSY+VwhMKnA5Esi0YSsGTdViSxaV0heKJTLR8K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtYsIxxK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770229681; x=1801765681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nQFkkuMkmVRVnqsl7J5n9PeHIPkIs4++6mYa2rJaGJ4=;
  b=UtYsIxxKpqIjQWMUW8QqPTIEXhLABfkQdPicv6ia1MZepFG34r8osECE
   o8LYy68OdI+xVmBU4l0x39UWx7JuZAiWtaPdDeneSD3165oiYhbfCMkjj
   FYiiP4YYcPxLGSs0yBWGV3GyzBH00xPVpTZChOKiTxaLUa3of4q3TBVEZ
   kFWUr+9FgAyb9vhrJYrJ6s+c0jSLLxdZSH7PP1UXwTnUJf+KvrS/fzxvP
   okwm+iI9WaWZ7gMncPJ1iG1/bGO6TV8bM0gE9vsfeCqzMPWX1mRbaKoqG
   BJ0XWZD2BnUb9O2RxpBdz9hzHg1K3XbkdPH6qtgKi9Ujk63wew72MIMp2
   A==;
X-CSE-ConnectionGUID: vmoF9Q3cRVaLEnwCGhNTzA==
X-CSE-MsgGUID: pJpXwv4ASfeybWiyw1uoSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75276419"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="75276419"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 10:28:01 -0800
X-CSE-ConnectionGUID: 4nlf1y4aQ+WeXDpxFOESuw==
X-CSE-MsgGUID: fts9/SpOSauVzCG796KPWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="247831861"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 10:28:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 10:28:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 10:28:00 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 10:28:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZUiZuxSo1S2TWTFxrugnn8txtleZIjOqK8L2B0EBVcZIy5lXcLMNbrJ6pI7BPZvvP+/Gd9DhSI77jQqtHDNxkbtXLx4jOHcxLh4nRB1RXlWGqVKZXdwwS1w2MvI3S1Ujta9t5j9JJngn5vieiN4X2ITmM9h03OwoQtP5GgPfn7Kj2DoEwcIg6QPknVUEzkEb0ghAcvsIV1pJO/BeXZC2xd23YWMPSkOJzbBwJvoW3ijswt53LFoOAkMlqn9AQSHPKnYGrx8iHmj8/p3FyOZ++pasWfdU9p5nA84Ox24s7umZK5T+eyuEiNNsqZbHytjNzYpuYyQ+VBV0PnCWlwS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqFzYRo7MD9wUDy8bNWYVc03rEfBmXM/wZHAl7+Ns1g=;
 b=MPg1A8wk9/7OYKxzajFTqN/auYHU1ubt571wNM7S2nXfR/1t9PRMFQiqqXdo1/QvZB6BS5Y0r8ZfhIDbrnbEn0+85bNQIqNmxPLCcHe1FJfH+MVDKvK/1NfUm13esEJ9tGDBSk7KysDiOtrRR1Yoj37gO0Sh5Mj0M9YXANaBrLg/QBPqYIX2KZs05j/ZttSRw6WXu9GkXKYHPuFYAA1PDFuZ3vVEcbLTI3lX7oB0tJpm7lgxSTOCQfgkgZLRe89HLcpqpNf0uopfcGvDbv9xhKoh9KD7nnnaqYJq3CbymdGXbtWRfDIg67nMFCk8iVoref2nLjxSDmRRSkWcvzkUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW6PR11MB8366.namprd11.prod.outlook.com (2603:10b6:303:24c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 18:27:57 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:27:57 +0000
Message-ID: <8dfd167b-246f-446c-bd86-ea9de95e445c@intel.com>
Date: Wed, 4 Feb 2026 20:27:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/6] i3c: mipi-i3c-hci-pci: Add optional ability to
 manage child runtime PM
To: Frank Li <Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <rafael@kernel.org>,
	<linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20260204111511.78626-1-adrian.hunter@intel.com>
 <20260204111511.78626-6-adrian.hunter@intel.com>
 <aYNumA0-FvE-g7nl@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aYNumA0-FvE-g7nl@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0147.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::29) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW6PR11MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 022c247d-f6de-47f3-014e-08de641b1ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnlnT21GbGZVTy9tYy9HSVBIcjBSbEVxTHlxd2FMdGZVSFNycjgwS1FIUHp6?=
 =?utf-8?B?aW92STRhS1ExRzl0SHpYMklSZ1g0ZjRjRm9PZFpraHBQczdsRFEyOStuczBs?=
 =?utf-8?B?SVdUSFkxdlNuRVJZdXlBaS9Gc3U1WENGSitnVmF0V1hOYXRVMTdaL3g3dXA5?=
 =?utf-8?B?V1pEbjlodnpUbjZ1b3JBZXBHeFJVKzdqUTNXMC9vR0RYNU1OSUlZMS9jTXBY?=
 =?utf-8?B?c3JCU0EzNysvcWlIWFdDekVyNHJQcHR1M29wVVBSaHZKN0xRVHlhaFlackEy?=
 =?utf-8?B?Nlo1M1NGQ3lIeExCQjg0allPZTIvOVVYNUhCQ2VSZFgvU2NRUHZnUWk2MERO?=
 =?utf-8?B?RmkvY3l1dmJPT25ydENWT21NTFA0NW9od0tvanV3WnEybDRIVWZSMklYZm5Q?=
 =?utf-8?B?UC9va3c1TkhXZDAxVzFUSVh1QmJ3MzZiN0o4RmpRMkZIYzJOalhYc3B2L0Fs?=
 =?utf-8?B?UHFScFRTZW1rSXZjTTlndzFmYXA1anBZc0NQRE50NC9zSTNlYVY4S1VXME81?=
 =?utf-8?B?YVNNZW9GSXBwVW9vSkV6bGw3a0ZFR0k5VXY2dk9LMVIwY1dSZ3B0WGhSd3Iz?=
 =?utf-8?B?WElxZFQyQmR5bTAzRGVoVG5nbVNoV0VrNjE5UmpSN1dBWkp2MTlXUzEybEdL?=
 =?utf-8?B?SVhHQWJ4NjIzODRwaEdMc2hNbkxXcXczdysyK0pGWlo0M3dDV05GTlBDdE5G?=
 =?utf-8?B?YU9RYndjcVIwa2k2MzVNeExzSHlLaHV2b0lyZnorNklLWWV0RjAvQWhDU1NO?=
 =?utf-8?B?Q1BoL0wxQzFUWG5MK2V1eDNrWG0vbzA5Q0ZSY295Q1dBbDVUSHd3UUpoeWY2?=
 =?utf-8?B?LzdXUWtaN1dUWjNwYjg2YnUvcGRCMHBvWHdyR0I0SDJrWFpVSHlsYmQ2aE0x?=
 =?utf-8?B?UmhDQXdGR3gvS3E0elZnMHo1NzdRTFcwTGFOVDdXaVBrSlgxdkNVYjlLUjBz?=
 =?utf-8?B?QzdTTTV2d0FQQzgzOU10VzFad1ZMZkdaZVA3ZUhDMWt0UWtRemJUUGc0Rnh1?=
 =?utf-8?B?TmgzNmgyTXAyMzBqdDNWYzU2V2N4TTVMeTNoOTg2VXpTcXNDcTI5ZkRkakQ2?=
 =?utf-8?B?N3N2L0FuaUVuTDE3SGVwZmladXJTUDJUVlhGQ1NiejduZU5hdnBxNGtBMzRi?=
 =?utf-8?B?Yk1FdzlQSnllWk16dnhubmZ1SmE5Y1lzVHcwcHZLZUJQVy94ejQzK3p0UEdK?=
 =?utf-8?B?OXdyL3BUMjhYT2VtRXdTWWdXeVVCb3c1NmdhYmpLVHhKNW4ySzFrYzl2MDdS?=
 =?utf-8?B?QmplTjBZV0xGMnpwUngxdkRLYk9YWmRvSUhIS20rZko3dG1qY0JtcTBEeVQ3?=
 =?utf-8?B?dUw5TFFzOW5Nc1ZFQkYrOFZDcE1qQ3RhTk1WRjB2SzM5cDJxeXVuT09zT3dB?=
 =?utf-8?B?UG5POCtMTENQVzBDajViOEljay9kOTJsQ1pWeFNReXh0V0xIajMxQyt4VnVr?=
 =?utf-8?B?NlFWNUVmVWF0ZkdQZUIyRmhmUC9RRndVaDVidWNPR2VXTXBnRDhSOXBYazVO?=
 =?utf-8?B?NFZ1WEt4Sm5SbGg0cW1aM2RrUTRxdFV2YWJNSW5RTkJuZTYxK3BLZmNJQk9z?=
 =?utf-8?B?VkdKY2E1UUZKUjRwMFYySjZoS3BPTlFXVjl5cy92OGtVTTVseG1zejhTajF6?=
 =?utf-8?B?SGtYVUdVVVhKZlBjZWpodEdpbTQrcEtwcm15TDFuZnhvRVVPRC9uVXRZU21V?=
 =?utf-8?B?ZlRkYnVuSm9pUUlVQklhK2VWT0NMcWl3SUpUZUNnSVN4alphWkpLMmZuTmg2?=
 =?utf-8?B?WjZBVi94SStUOU5pblVsVG50VnF6a2s4TnFDM2l6Y0Z6SDhSVG9MYlVMM2tl?=
 =?utf-8?B?bjZSdVBlNmFwQTF1Nmc1N0dkZERwZW5ySjhZWnZaL3ZMVVBscDFEQ3RYWGVo?=
 =?utf-8?B?MnE3Ly9MOW9YRTdVT09TTXhSL1NoL3FmZ0dHSVkxcGxCci9WVFNFTDZRMkRX?=
 =?utf-8?B?eFJNRkN1WVNMK3R6ak1ydE8wa0UxMmkyL3diUWVJeFRGUytnQ0FlWHNWNkRK?=
 =?utf-8?B?R0hPVWYwZFJHelhCM3hVQ0FpeGN6WmhTemp2cmxMV2Z0eWtzWkgzVXp0c1ZU?=
 =?utf-8?B?elNUSlh6dFpCWjM0QVVUMGFTWXo5SjZHYjlwaU9ZR0hONHQyRWxtQUNQTi9F?=
 =?utf-8?Q?zuXs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjlHblBpNU5JVUdhekNDNHYzNCtkajJJZGZBS2N6dlo4a3gyM281OXRqdEtz?=
 =?utf-8?B?S1B6UDBmWDRFcWJTZ0txRDRyaWJnVGE1dGpXdHVLZkNyTzVXOG5mM20wbGFt?=
 =?utf-8?B?THZ1cFhaVHp5bkJpaVJCUE1Mcll3LzNBSHg0a1FCc1pFOXJheGRkc1hZaDR6?=
 =?utf-8?B?aDlGTGd1cUxSNnNnQlMxMFZkb05KaGpqZ0xlcFlLdlY1d0xDeExwSURuU2J6?=
 =?utf-8?B?UWhncExzZGQxS3c0SGR1UzVQWWlvcFZuOHVxR2RYU2RxSVhpM3hkUndiSkty?=
 =?utf-8?B?RFBVOGVNaEZaMlhtK1ZQR3J3R2RLQm9JNmFtb3hKOUZNY3hEbnVKZ3J6eGFB?=
 =?utf-8?B?RzlWRGJLMkVTalhyZGxEOURiSnBpdkp1Smxoc3pVT1BGK085MVdMd3dtM3pm?=
 =?utf-8?B?QjdqMkc1dHN0cktzVGlPc0JseXU1Y1pucnpHc1BqNHV3d1hRbDhGanJ3eW1Y?=
 =?utf-8?B?UGVwZFhzcUk2bUhXVjdqcXZKdm9icjBPSTVvNDJSUTN6RlZoemtuaStPUjJ2?=
 =?utf-8?B?SnhrQWJPbVBLSThnNmRKRTZ6UEJUSFlkQzFmOXhNejA3VVhyTnRQNTZtc3gy?=
 =?utf-8?B?MkU5M05xelh5WlB3SW45NkxZSGFWVlhWL0UwYlJTeXl2cm8wTStUbnhIRHZh?=
 =?utf-8?B?UitkSE1lYkhWY1hkVjlJYys5YkY3VFZLaVdkcVczcWsrbjZmRkpwTjVhblBn?=
 =?utf-8?B?WGZ0WVJtSFdGM2tNTXc4bXEyZzY3bjRJRGZNYmtseGlndU53R3JCYmJ4Vy9B?=
 =?utf-8?B?WFVnZVVwbThJZ3UxaGNXVG1XSlJwYXVoZ0FuTmp6M3BuS1BxUURtakZ3UkRJ?=
 =?utf-8?B?S1g5MGxJZEJacW80VkF6ZU4wL1dqSUwwbExPMjB1YmZlVUNpVEpPRDFLVVNm?=
 =?utf-8?B?SFViVTU5Wm1RMkFvWFc5d3l4elE2Y1RiR0NLNDlidDNoWTNMNUFnNUlQdlFX?=
 =?utf-8?B?TnZuVUZYcUdRRVgrN04rTTVicTlhYzh2Z1FKSmg1eFNDY1AyU2NoN1RCQytX?=
 =?utf-8?B?UExGa0hrbFY0a0lWc2s2M2pYUFZxeGlPaXloSlUxbzBHU1RGNGpCV3d0NzBm?=
 =?utf-8?B?RjV6TUhkamh6TnltTzBxaFVYWjVXSG84WTRZWWtWSlFVblFuOEF5UFVOUUs5?=
 =?utf-8?B?UEVaVk1wNTVPT0Q4eU1LM3IxdjlvNUI2ZUIxWFlXV3lOenBEa05oSS83M3pG?=
 =?utf-8?B?S3hBTWJhUHcvWGJsb0RZaTd5YUFEQ28veXVKNDF0ZXpSS2RJSWkvTFlRcjZ4?=
 =?utf-8?B?ZG83RGpTWnZ3WkMzR2p4dG1iVEdrdHNLR2p4U0JoRFZlcmt5c2F1ZzA4YWxt?=
 =?utf-8?B?bHFhcytycjhvOGVmNkJQenJ4a2FMMi9YVU5KNys1TDFUNStnS0RnaWtiVDBa?=
 =?utf-8?B?WjMxSjQzNHhBeTRYL0lmVW5QRmduQisyN0w5VUtlcEFUR0kwTE9nMU11WXFB?=
 =?utf-8?B?OVEyVG9SOFBqTUw2dG5OMWVaeWRqcStVcms5eFdZWExEaE5wL0NEM0gzN2p5?=
 =?utf-8?B?eDIzRk45bVRPMXlFWE1aNW1vQzM3YlJEenVGeVZ4OENzc0RVMG9YUWhLYjVF?=
 =?utf-8?B?dFBLaHluNDZLMVdjelVLQzEwbDRHZEtGcnNpQTZ2Zlc1cnRNTlo1ZTlUMW44?=
 =?utf-8?B?b1E2RVZySmt6a2hKZjVCRytMWXlpNXBTMXhPazN6dU95UzBteWZaSksxa1ox?=
 =?utf-8?B?SXlIbm5XUGFOdWxHMjZGSjdqQ250VjljeHNUNHNDU2RwRGk2TmJ1bTR1bEcx?=
 =?utf-8?B?MmgyQTZiYk1MRTVXVW1aSTR1QmdyUElmMXNtTGppWXNnNHhXakFITVh6OVNZ?=
 =?utf-8?B?bnUwZXpmWm8vNEV6QzZydmF3SUo5YVlCbHBZUk1WOWk3aEhkb1pxaHFvWHVu?=
 =?utf-8?B?bWR0NmhQWnV3TW1ic1p3bzRGa2FHWnJydmJUWGFBWmYzclR4REdzdE10c0xj?=
 =?utf-8?B?R0hjMWNodFZCa3BGT3dkdGppR2R5YjQxeW9tWHROamIyeVdkNVdLVGI0WWF2?=
 =?utf-8?B?M2hkUnJ2cU5hQk5XZkt5NGxOL3VWOVpDMlNtY3ZaYWF3eG56N2NZTkIwTzky?=
 =?utf-8?B?ZllmUHRleTUxUm9zc1ZmRmlKNDlHMW1PTisrTVRpTWxFbkRhalBXQnpKSjRo?=
 =?utf-8?B?UVp1Z09YUWl2TjlJMEFDZHFFZS9KczcyNW1jWTM0RythTUtQeVJkVWpXQ1ZN?=
 =?utf-8?B?RHBKYmhDR1pjL0dHWjRVd3JXZjdQM0dRb2NlcXpMb2crdHh6L3UrYkVKc0tj?=
 =?utf-8?B?UmdaZ3VuSTRmUWQ1RC85Y1p1bWJ1N2xTL1ZTR2NMQXh1U01UaGlNYXE2aWYw?=
 =?utf-8?B?cWZrbUN6dURZTklobEg0SitRSWdCTERkNUJpYUVHS3pLZUZ4MlZlQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 022c247d-f6de-47f3-014e-08de641b1ec2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:27:57.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2grZV0xtP1CnF0NjjuHttDJv0DXvGhyDkfvhr5EUi3y5VnEyx3AAEXuVKQ8Y2nHGAAyeGXBYVuY4XNNlE7fng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8366
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
	TAGGED_FROM(0.00)[bounces-42108-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 76E6CEBA6C
X-Rspamd-Action: no action

On 04/02/2026 18:06, Frank Li wrote:
> On Wed, Feb 04, 2026 at 01:15:10PM +0200, Adrian Hunter wrote:
>> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
>> where a single parent device hosts multiple I3C controller instances.  In
>> such designs, the parent - not the individual child instances - may need to
>> coordinate runtime PM so that all controllers runtime PM callbacks are
>> invoked in a controlled and synchronized manner.
>>
>> For example, if the parent enables IBI-wakeup when transitioning into a
>> low-power state, every bus instance must remain able to receive IBIs up
>> until that point.  This requires deferring the individual controllers'
>> runtime suspend callbacks (which disable bus activity) until the parent
>> decides it is safe for all instances to suspend together.
>>
>> To support this usage model:
>>
>>   * Add runtime PM and system PM callbacks in the PCI driver to invoke
>>     the mipi-i3c-hci driver's runtime PM callbacks for each instance.
>>
>>   * Introduce a driver-data flag, control_instance_pm, which opts into
>>     the new parent-managed PM behaviour.
>>
>>   * Ensure the callbacks are only used when the corresponding instance is
>>     operational at suspend time.  This is reliable because the operational
>>     state cannot change while the parent device is undergoing a PM
>>     transition, and PCI always performs a runtime resume before system
>>     suspend on current configurations, so that suspend and resume alternate
>>     irrespective of whether it is runtime or system PM.
>>
>> By that means, parent-managed runtime PM coordination for multi-instance
>> MIPI I3C HCI PCI devices is provided without altering existing behaviour on
>> platforms that do not require it.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
> ...
>> +
>> +static int mipi_i3c_hci_pci_suspend(struct device *dev)
>> +{
>> +	struct mipi_i3c_hci_pci *hci = dev_get_drvdata(dev);
>> +	struct mipi_i3c_hci_pci_pm_data pm_data = {};
>> +	int ret;
>> +
>> +	if (!hci->info->control_instance_pm)
>> +		return 0;
>> +
>> +	ret = device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_suspend_instance);
>> +	if (ret) {
>> +		if (ret == -EAGAIN || ret == -EBUSY)
>> +			pm_runtime_mark_last_busy(&hci->pci->dev);
> 
> This should not neccessary, the runtime suspend API already call it now.

In face it is not necessary because the driver is no longer using
auto-suspend.  I will take it out.


