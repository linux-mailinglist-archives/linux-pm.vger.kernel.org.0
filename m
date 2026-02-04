Return-Path: <linux-pm+bounces-42107-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPn9B3aPg2lCpQMAu9opvQ
	(envelope-from <linux-pm+bounces-42107-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 19:27:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C3EB9FA
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 19:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12C01303181D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24913423A80;
	Wed,  4 Feb 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kf773FjR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6A340A70;
	Wed,  4 Feb 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770229470; cv=fail; b=LpoJJhW4ZyyotRNhCCgmUSOmLRPRGN/Ctzb7C9WCFd9eJc1d9JfynX7zmazyHksRbUamTEhU7O5KhdOVhZQxPt1L0Ij+CQapF9j0T2Om3bC/4Lo5CrWOe3s/9xK2LkyOf2PChMHUsDdwjVZiU9jVxgUX+MUTZ1KJqoS3ulSRhC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770229470; c=relaxed/simple;
	bh=v8HwyrNhzbS9tqtA+liemXMcZXK72OIEZ9o4ipze85U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XS9SMQvCPbBKV5bXEJq8P4o1LBuUmUq3YdG9//2Hk8++gbT8iou8RERzhw4x/Idqxypr42n+JiqDk6AvUWihabuzajgCU+W9kxDmeMCO/qwrPZbxkuYH7oZrEICeQIXwGYDe4QllTV6jOCah01jK3RD/duWrqcN54gPuizjST9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kf773FjR; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770229470; x=1801765470;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v8HwyrNhzbS9tqtA+liemXMcZXK72OIEZ9o4ipze85U=;
  b=Kf773FjRyTzQ4SyxqAGp+r92AICfMAhD6ecm3BM+kgPyrHkoiJGadqhr
   texLX8kUSx+xcpmtereAyHuKvvF/2xkbq3Wdzc7LSLZ65BXrOTM+Yzol/
   s5YWFtlp/vkxQ/5bNl8v0asVfmchf6UIuOhnMcbT4dtGMANr8RlD0KaP+
   dRfUDgH943FMRawsxFrmUW3o9jzeMZd6Ul1/6wvI8la/AGln9HPxePEOq
   NNkD3RYOrLw+Brol3C2nazMGJD4O4zoX0HcdeijHPDN8oJdiCy3dd1SbP
   RmBWkqaxNo2lwbfyyjgE5I1dE5WOV1jXdtJabl7KZv2wjntCyT43abjE8
   g==;
X-CSE-ConnectionGUID: CjXDRrNfQ/aCVhtGOYlBcQ==
X-CSE-MsgGUID: 3kKsTuL2SM6AwRDcBctzqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82792977"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="82792977"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 10:24:29 -0800
X-CSE-ConnectionGUID: h+AaDke/SxqUY9IHqoqPWw==
X-CSE-MsgGUID: UTzJNPEVRWKRUmLHS7ling==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="214920967"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 10:24:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 10:24:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 10:24:28 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 10:24:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsTVOVoOazmk8ycSCTTHy36TIn1DY2XGlMGz2xwC9f3LiSzlftFzIj9AAR7r0GrAnft+zI1CMiM1nExEG+xFV3ZAOXoZzRabqHF3C+VyRivdbXPAcNAskjmupEZF7m4P8t8kK2CxORGFtU/opjEMNoJbjPnnzYFTVShvF2wEzDyfKyRNHBYKZpaztpA3LGYqaPAemAp9XLdMHCZR6Bf6WcCS6YGMirR9RhqzL3SZRsRsSPGZDgnFDm1aKWoiUilLscoVk8V51G8YfZSZuPvjTjwHxCUGW5md1wudEaXYEKQ7kUtHJDlSggKM4p/e3zX+mIrC2zqoFr5S+5LL6dOxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JpqdiMGFA1SYLl+8zZMkWb4wMsDYVuyttjWfqGiU5o=;
 b=pjNmILh5A+082PhWlS6JRZhsb7blo5cz4DS/fjWAgc89kPmPHm+B0UlW0RzCJgi71zBa2q2dsTgwCie22+3x/JQXKD3r6+zmc8diYQoFnjsKpegR83mGJfneEwfYfeB702bTAFQz0lyLRMXzTq406rrxSd5/qnSFDBjxeD2sIF7lLexFLrWKsi+xA35iy32KnkZZR7TM3fF2zvkgY5s+60t8Ms5RKldIE3Asw50j7ykBtktbh5LFGdEvWI0LKlUDm4+9RWgRzD5S9poJ6DzP/+h6CxGM5mpuEyZQua3fjvRQ43mo/EfqPMHS1VoAOzpTgLnXU6tvYl0BWq1G2TXVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB9423.namprd11.prod.outlook.com (2603:10b6:208:582::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 18:24:26 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:24:26 +0000
Message-ID: <a650c5c6-5975-40c6-828e-eaa27403adfd@intel.com>
Date: Wed, 4 Feb 2026 20:24:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/6] i3c: master: Mark last_busy on IBI when runtime PM
 is allowed
To: Frank Li <Frank.li@nxp.com>
CC: <alexandre.belloni@bootlin.com>, <rafael@kernel.org>,
	<linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20260204111511.78626-1-adrian.hunter@intel.com>
 <20260204111511.78626-3-adrian.hunter@intel.com>
 <aYNveVUsiixWWlWL@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aYNveVUsiixWWlWL@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cdcc37-a0cf-4667-c54b-08de641aa096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWlTaG5aSVp4OHFBYzRITE5MOVA0UHk5b3NPZysvZUtOYmZUbjVibkk2azR2?=
 =?utf-8?B?YlZwRTJHK3Z6NytkTHdGYUdPOSt6RWx3a0RXcDhZSHA0UjlaYmxRbDMrSzhK?=
 =?utf-8?B?NWs3aE44czNOK2Y2U0c3SVVTZHVOMDZnby9VWXZjOXQ5SC9zWWpFdWdnZUJa?=
 =?utf-8?B?M21pZHRzQ0RzOWJZQjJHdFVyeiswWGpmMEpiZ2xKQkF5VGhSN0NLbjY4OUdX?=
 =?utf-8?B?djY4Q3B5SkJpUSs1MkRMb1ltUGhYejlERDFjZXNSblZLeDRkVitpZndpaWhh?=
 =?utf-8?B?Y1d1T1FxcmdYeFZtaVBsOUxFWFR1UkNlbkFNOGFaUUptdnNUVnoyK3FEdVFL?=
 =?utf-8?B?ZTFVMzFoNnFNY2FRRXJ4SGJOK2hwd0x0WWxZTWdYdUlNYUVaMm9uV1FLdEZi?=
 =?utf-8?B?SmlrMC94dzYxb04wZ1FnOS9SUXdsQk4zTkRXT1VSNGFOR2RRM3h3TEI4ZzBw?=
 =?utf-8?B?YlBOeWF2Uk9IOTlwS0x6dFNTYUU5T1g5UlZNcW9mRjN5aFkyQnlIOHBIK2FB?=
 =?utf-8?B?d1o4OEVhVkRCYVc5cHJPSUdXbUpmdlQwWTdVdDhOZlN1SkY0RzRzWlhPR3dP?=
 =?utf-8?B?Ukd1NFVrclR0RTdTZTNuTy9QOUFhTmlzM1cweDFyNEhlcDVsNlVnSktlUnow?=
 =?utf-8?B?TXZIWFN1K25lSmNRSUpHblFGTUI5N0JhNmc1bVcxOGE4M0kwSmx4Vy9abDk1?=
 =?utf-8?B?ZUNwMFVDZ0tISEsxQ0NaN1hZRlJ3aXJKN1ViSmM3Nm0zdE55THkxN1RKalQz?=
 =?utf-8?B?QThoN2E4bFVCWHE4cVZabUd0Y21XaHNvSWYvQllmeVZqbmlHYnB3NkEyRzN2?=
 =?utf-8?B?RlJabVlpQzVhelgxSmYraGU0QVBHZGxaWlUzRmNuWVZJNy95d04wanJza2ls?=
 =?utf-8?B?QTQ4VUxrKzYrUTNXTmxiTUJBaGRsZHpUK0d0Nkx3OXFZaG5TaDhsMm9KYTRH?=
 =?utf-8?B?eXpMeEllUytNcithUVFmOU9KOWUyOXdjdFUvWlEwOHNyMXFtcjU3TW81K003?=
 =?utf-8?B?dStVV01aWk5id3k2bXhnMG8xdWhEcjJGTmM1Y2h2bU91WjloRXB1RHpsOW15?=
 =?utf-8?B?Mk9tb3AwT2RadzhBM1F1R1JyZWZGbVRVN3dpMkJKS3hFS0Q3aW12dndvQnJ3?=
 =?utf-8?B?K3pZNmN2RUJFN3A2cytVaEc0UHBIUjhrV0lPRVZiZkRQZ3RjWFUzU3JCS2M0?=
 =?utf-8?B?OFF1Si9IRCtpWWtEZTdlc1kweHRKV2ZrZGcyUjM5bGZ1bk55UjFHWnRNMExV?=
 =?utf-8?B?NGZpbnBHWHgxRDNuRjVqSzg2citFVHNmYjBkb2ovZHhIOWJoL1FBL01QN1BS?=
 =?utf-8?B?SEp4NE9JbURFQldja0lFL3lVK2wyZWxON0h6eUJCSnZoa1VSYkw2SEFmQ0l4?=
 =?utf-8?B?Q0NxaEdWYXBYMm9pMVlmRCtjbjNkSHNudFMzZVNwZzNpU1pyUXBTRktzVFNV?=
 =?utf-8?B?L0hSS0pqejdGMFYvdWxXYzN3cHdrUEpKU2N3RnNRN2svQ0VtOGZONXZQV3Y4?=
 =?utf-8?B?RG03Yllka1VjR2xIZ1F2UndHblc1YUZvWEVFdmd0WEZkQ2tZT1BWSHBhd2c0?=
 =?utf-8?B?V2UzSDY0b0pWSmhudVhaUFYyTnhXRWZjamJINHBDelcrOTQ3WXhVTDhXZndy?=
 =?utf-8?B?ZFhXditDWlNqa2EwUndva3poVE5GTkhHajNBU0VtRmI2dnZJbkplRnhRVEhn?=
 =?utf-8?B?SGxZb0IwNE5DS1BYaHF6czB0NC9Wclh5RTNvZk9nbXNIV3pzTkt6Wk5TWmJF?=
 =?utf-8?B?dDcwUFBtSi9SSHdoRHNFcVZLdXo0cmdsODEyYkFXODFheUlZZUpsUlZCMkVY?=
 =?utf-8?B?M2NJNkNlOG1WcmNGQlAxdDRsS1I0S2hyRkxwcklERE16cTRXa3VCN1N1KzVz?=
 =?utf-8?B?cHVlSGx5a05jeEk2eFhOYmViSFAvQStLSkNnVmlienM3b3Z6d1IzV2llL2Yv?=
 =?utf-8?B?M3lkVkpMNXhxb09oT0tiRDRWYzNJbGtyY0FuQlpFdmh4U25vYXE0YnFFKy92?=
 =?utf-8?B?RE1mRmMvb2tJM2hSVW90eW4rZThiMHo0alhHL3BVdlVTRHJsaUt4RDFuajFV?=
 =?utf-8?B?Rk8wcmVQK0pndlYrYVdsRzRaK1FLaFpyTnk3KzZUK2xZZ2lOd2pEQmJpbFR2?=
 =?utf-8?Q?vB7A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFV1UHRsakdYUG9UWWlUclhvTU0wQ3Rtam5sVFBmTDI4V0ZjUmlpdTM1ZXl5?=
 =?utf-8?B?RElIMWlJZFkyQVpYOUFzTEx4Qmx6bEdDUVFKSVZHVitPVUV1d3JmTVgvK3Z1?=
 =?utf-8?B?b1hpMXlGS1pvR1p3cjY3YzNnT2ozeTd6Q3B4N1RRK1pqWVY1V2FMM2RWWERu?=
 =?utf-8?B?R0xxMzl3aHBTTGhlb1BUcFBqTkVHVEU4WDNrOXplWk5KQmxQY0N4RndHQXZX?=
 =?utf-8?B?aTkyalBSbkl5TC90VElKanQ2RnF0Mk9YWWFkRDVzRk14ZVhSWE5vVm1EaHVm?=
 =?utf-8?B?SHlMY3huaENGYytTNlo3T2pIUm4vOVUzWkI2RDNodFpNWk9aNVJFc3pXYXE4?=
 =?utf-8?B?a3dXZXlmK1FkL1p0VElGL0xvQUp5VDQ3UG5RZjNnZVk1aDg3SmRyakl1T25V?=
 =?utf-8?B?MFd1dWR0T3JqTHlkUlJaUCt4SmZ4MnVpZ1FaTVdrVzQ5Wk04ckJSczdmR3Ju?=
 =?utf-8?B?VDdtY3ZvOG10Mm9Ja1hCTTd2VFIrVHE3Ui9lR2tUSExJaHdrNFRGSmVERDRZ?=
 =?utf-8?B?cEZiTHBYN09pQVMrZFBONHZqbGV3OHJuZjgvbzQ1TklIZEFQRGl0c0xnVlpp?=
 =?utf-8?B?K2lFZENaNThqakJoUGtaaUk1VEFjSFFNSHh5TnV6a1RoR2ZFenhGcGNXNGJ0?=
 =?utf-8?B?ZmRrdmdQZmI0SUhQN2xFeDlJODlrcWd4Z0dzSVloZWREcEFWTmJwS2Ywd3lz?=
 =?utf-8?B?di9zUDcwYmV3dFVVZE8rOFFuM2dLU1J6YVd1b20yU3IvRjdpay9tV08zdFcz?=
 =?utf-8?B?Zk5pcm1TaU9sSDVSZlBDVHNlM1FMNVFIM0k0THYzKyt5dW5NM0FmTEVxL2d4?=
 =?utf-8?B?c1lQUXZQclBNREEyQXA2Z29BMmloT0Z5TS92aE4xbFIySlhqaXNObVBBUUtu?=
 =?utf-8?B?dkM0OEVNQmdMTU5jdlNPVTNrdlFjQkw1V2phaktZNHdRR1Zjdm9lMmUrck9W?=
 =?utf-8?B?c2dhTWE1RjFNUjFMWm5HL3JVQWJQUnhUbHJHUGZOQ2EweW11SlVkb1lJZFBO?=
 =?utf-8?B?MFV6eXNZSTB5aHVuK2hZNTZ2ZGFiQkMwZlIxcmJzbmh1Q1VScTY4aVR4d2lU?=
 =?utf-8?B?bHRVdjZZeEl4SHNhNm1jNkFLc2ZlUzFTTHpBRWdWcWFPT2RWUmFUMDg3RFY1?=
 =?utf-8?B?R2pRTXdnSTBtVnE5djYwcTllTUxRd2RDV0hkdXJPWGtsa0tBNmgra0ZXZE85?=
 =?utf-8?B?OVZTckpBWnJtbnhOeDc3dHlQQktjZUY1QTVFeGNyWVdwazNwNlp5VjBDclVT?=
 =?utf-8?B?Umhza0ZpTUpSd29XVm5RcC9lZEFMcTFjZVd5WjZJeGNaZUhuYVJzcGh3aGxY?=
 =?utf-8?B?RWJDYXBna3F4ZElmZWI2ZXZZRjczb3FwSTlyV3J1dzJ3V2l6Zk5iNzVlc0h6?=
 =?utf-8?B?K1ZGZHBIcDdlVlR5NTZVa1VlMDZXUjY1RmdtRnVHdU9WOXVWOWJ3T3F1UnRv?=
 =?utf-8?B?R05DWkNydlBKb3lhWG1rWWhCNTQ4YnpNY2x5VG5pWlBURXZSVXhmSUhPcW1Q?=
 =?utf-8?B?VjlOU0NRRlN0d0hKN21mQVpmR3FZNVFSaG4yN29rVEJUWE0zcEhkMFJmT0lO?=
 =?utf-8?B?dTBUTStWKzRjWUZzQUJmZTFaSmtCMUNMQ2kwYlltYStVeVpvanVKTzFsWDQ4?=
 =?utf-8?B?SVFGeFFzWGhBdWtVMzJ2aThLSk4yYS9uaFczS0xJUkZLUWhjVktLNTIxVTBT?=
 =?utf-8?B?TXpjY1E1NG1XSUplQ2RLM0RENXlncko4dmdjWHdxL1lYUkljMmJFYVBGejhN?=
 =?utf-8?B?YVg2MFVzVURRYnJzTDVTREx1UWJEc0xxR3VHS2hvSjM2VjV3RlV4NVdqVjBQ?=
 =?utf-8?B?ckhxZ2NxdDZMQ2loRjBLTXZKVkF2dUd3RjRpelBWNUpCbFRWWWdVWjFLTURt?=
 =?utf-8?B?WW4zVDZDNkRhS3lpY2l6cU8xWlR4cllOY3k5ak4xRytiNEUvcnFDT1owSE5O?=
 =?utf-8?B?OUQ4bDg4eWEwRnlSTDNSV0NjWVJFWHpUYjY5NExsVDhUeGl6L3EzNWk3bHJQ?=
 =?utf-8?B?NmJOcU1DNTdsMkJJRXR0YnAydTRsRHNUSVBvL1gxZzJGS0JsTFVJYjFnMkVs?=
 =?utf-8?B?aFhmSXdBL0ZEVjhBVVdyWGROb0pZNHozdDZNK24rdXZzQ1JMMlZWaGZXT3hC?=
 =?utf-8?B?RjBNdGNISXlWTE4yV0tDWUNnMUw4REt1QlA3K2lDYThVeFJDNDJMMTJCZzN1?=
 =?utf-8?B?MHVuVVpQeWYwbUlYZDRsTUtsalNQRDNhVTZPOXRReG5EcG1kVjNuTDRCWmsw?=
 =?utf-8?B?bFdSNVJrRkYwdkhlUms4N0ovc2xuSC91by9kOTFMbFhmRTc3UWFzNld4akRl?=
 =?utf-8?B?YVFLKzhmR205cUFLZzREMzFUMEZSL1F4VUZYK25DMnh4aHBoazB4Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cdcc37-a0cf-4667-c54b-08de641aa096
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:24:26.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvQBKcootC/i6A23DlHhmbTE/LMPGSGnR8zKmRLmcKWo1VWsNxU1wLZ4NhLisvTVQP75jKgjqI7UB47TGcB2Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9423
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
	TAGGED_FROM(0.00)[bounces-42107-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,sea.lore.kernel.org:server fail];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 904C3EB9FA
X-Rspamd-Action: no action

On 04/02/2026 18:10, Frank Li wrote:
> On Wed, Feb 04, 2026 at 01:15:07PM +0200, Adrian Hunter wrote:
>> When an IBI can be received after the controller is
>> pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
>> device is auto-suspended.  In such cases, the runtime PM core may not see
>> any recent activity and may suspend the device earlier than intended.
>>
>> Mark the controller as last busy whenever an IBI is queued (when
>> rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
>> recent bus activity and avoids premature suspension.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
> 
> Although it is no harmful, I think it is not necessary to mark last busy.
> 
> schedule's workqueue task to do i3c transfer, which will call run time
> resume.
> 
> Are sure it will block your function without this patch?

It is not necessary at this time.  I wanted to cover the case
where an IBI is not followed by a transfer from the target
device driver.  Perhaps a device could operate almost entirely
using IBIs, but there is nothing like that presently.

Let me know if you think we should leave it for now.

> 
> Frank
> 
>>
>>
>> Changes in V2:
>>
>> 	Adjusted slightly for earlier changes
>>
>>
>>  drivers/i3c/master.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index 49fb6e30a68e..48d1b1256290 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -2721,9 +2721,14 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
>>   */
>>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>>  {
>> +	struct i3c_master_controller *master = i3c_dev_get_master(dev);
>> +
>>  	if (!dev->ibi || !slot)
>>  		return;
>>
>> +	if (master->rpm_ibi_allowed)
>> +		pm_runtime_mark_last_busy(master->dev.parent);
>> +
>>  	atomic_inc(&dev->ibi->pending_ibis);
>>  	queue_work(dev->ibi->wq, &slot->work);
>>  }
>> --
>> 2.51.0
>>


