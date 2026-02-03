Return-Path: <linux-pm+bounces-41967-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIwWDyfwgWlAMwMAu9opvQ
	(envelope-from <linux-pm+bounces-41967-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 13:55:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 605A1D9693
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 13:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CD313006923
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFBF346A15;
	Tue,  3 Feb 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTNkVku4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054020B7ED;
	Tue,  3 Feb 2026 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123298; cv=fail; b=jf5jpm9jb0xNogtLQkmWcGqkSQDWsiqp3g/2tQlY1aum0lLWVpdtPprPgGx6c1ntPRrSCzHjsZoHu9Kvc0qzb9qjbIjxJFoKrJTyVakuSI1AlqkJ35rWgPJfUxdRt9T1kucxFj3THxZC0WSWqBgAePDzcSMrwSEwSCqzfUBKhoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123298; c=relaxed/simple;
	bh=+zPOyEPAgsJjsIB7pNDSszaGTDoSkhw68qxFsoNqc58=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P41I8wj0CN7/sHVQzPNgaMuZUlxG+dea4kz7EOTxgPkajdk117h58kOl4IeGtJMI52ggJHV+Drpp7qKpnjK55uVqmIkILc9pfNs9077AAhwzQgI7KbblIOhL7F5ZGBiHYHrdj0AtrVg84ZiqQ/MG0QdKyPMpdTB3ayJaVNnk6gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTNkVku4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770123296; x=1801659296;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+zPOyEPAgsJjsIB7pNDSszaGTDoSkhw68qxFsoNqc58=;
  b=XTNkVku4Fb1B3lY68FZKf9lAYFW5Lm7VCwX3bgwP1rFpdS/T8KUnYASw
   75HPDT4Zrsq6LEwckO8jt4hcT/eP6YLO10YB8xMkKJq6C5BsPHd4RaFRx
   2ZzilOmZ2tPg0NtC220Tm9sw4qvyA9HrEQwD58cdPUjkxkEiWj+nfQnMN
   kL/fPkATCFY2iaz+UXkRcP0hzsqliTdyRbNd5jC9wLNZn/lJtRYTbBNPO
   VrL++QuYH2TcdSjiglWq8M0pVoSLr7jmrAP1A2GckJSjt5qWTF19olbjg
   xDhcn952r2zJBXKZKkD8T/iBO11yVjFw7I1e7mJOvOefIPLnPPALAKJPP
   A==;
X-CSE-ConnectionGUID: bAD168roQYSBpon2QcAomg==
X-CSE-MsgGUID: FEfeG5ANRReXdqsrtVaSeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="75149581"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="75149581"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 04:54:56 -0800
X-CSE-ConnectionGUID: rfx3BLO5SIaLsbHZjo02aQ==
X-CSE-MsgGUID: cii/n+e7SEO8BRu8IjWsZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="213981217"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 04:54:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 04:54:55 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 04:54:55 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 04:54:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN4aOagtXfLDFVntENLOId780BOODSFSIWUSSzaju6LDDkg5iBAOgo/uPq0QFiHK1fEZbhFIhly1dddcoR1SdX6ythj6f3LJ9CFpStf5ULVFrawQqDTPHqjqzxDmfBAHkFZKwP9GV0jehRRR5CiJHYC0g80mEy6cd9DNRi2XUNNY2qbociDGVoJvN5Xe3HWxlRubxfkS1V9a36W8Ln5yVDKw+bUe+j8+kc2jyQdP5xjl67LDmfUiDloFiWxMIGhIqNHEZe7iBrRO9pdRZhqYL9R9nxU1USf8eHA3egwiOYPcsEk+P3DGoNY1qfqRFakPFbhgf6c6nSsD6iMxYw/DZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7mCCyX2XR00091OOtkI3MubIraEfR0ZPMudevfmZrk=;
 b=eKD9Wn6KxIFiLy4ZYOIy2dEi9ovNKb3txmspVxOQHSsi4zduQWTJZ/agPDfmeh3JUeknlBDTXa6tMHGRaZBDMy+0zpF5Jfj9iIIksFWV+N5aeSbOmBy1R02+0oujOi0tFrRrIduD6w0K47i8L4kPwRg977Gh0FpBH7KTvnLwYjYGVHqJisONuiofTlHQhXIsCJMELM9R1WQbiJYbKsNi87EzPM5LHYIIJ3j7n864WSyBpPVu25FxR/+OcUNkGO076PzCcaLjwIkb3lcz1nj4Fez5iqYj1w8GJYsz6jDVksbKCcLNcqIQ9bik7MYyrkh0hNfDdUyo8UBFLnJ1ZnHAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB7985.namprd11.prod.outlook.com (2603:10b6:510:240::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 12:54:49 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 12:54:49 +0000
Message-ID: <eb335daa-ab6b-4cff-bea2-90160892bc8f@intel.com>
Date: Tue, 3 Feb 2026 14:54:44 +0200
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, Frank Li
	<Frank.li@nxp.com>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
 <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
 <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
 <aYDP847mgleQBF5Y@lizhi-Precision-Tower-5810>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aYDP847mgleQBF5Y@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0002.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 187734b1-14e6-4abb-b6de-08de63236a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWR0SDZGYndMWDQvTCtoVk4xRG1tN1JnbG4ySFpYdmd1ZExIMUhXWm5LOE9u?=
 =?utf-8?B?V3Q0eTZnNnlMN3dIeHhsMEpLYlRERjFzTnFGbG05WWs2RytMOSt0WlNxRTMz?=
 =?utf-8?B?VTQvaTVuSEZ1WnBSMlB5dnNjejF6M3JsVEZKZGdNSTEvVWo2d0pkVlJkOHpP?=
 =?utf-8?B?enJRYzJyNjhzQ2JLRVQ2TnRwUDByWlpNenlkUG1VREkzUnB5MmhXcmdsYWlw?=
 =?utf-8?B?aGFZN2toQUtXeU1zS1Y5bVZWVkhCb3hVbGdIa2xTWlgxak9LUXZFeVdMdW5k?=
 =?utf-8?B?MzlJOHVqWVNPQ1dTRXpvbnJ5NG1OZER2K0Z6aGhFUC8xS2d2UWZUeTg0MDk0?=
 =?utf-8?B?ZFJwNTloVzZuUkNYYklXVy9Za2NqZUQ4azJpNWk2L3dWUlBPV3Z5bXFQR3hw?=
 =?utf-8?B?ems3RFNlTWtTQXlzeDg0S0lUZVRaMkRWK1V4bEVPY0Q0QmVZZjNURTZMSmFq?=
 =?utf-8?B?RFZhQzBDUks4Ni8xcWRYOEtmRzNrZnFZNEJGZFBDMTlEaDhqZ05VR3ErKzZj?=
 =?utf-8?B?U0dCMnpxQmpIdGdGamdrcXU5OVMxcjVPcy9nVDd1N0xseHdlY0JzaTMxZ0tH?=
 =?utf-8?B?S1JWUzEvVk0ySWw3NXErT0lvbFdxV0llWVNkNm1UN0ZtU0tHUHBMZW1xeWpG?=
 =?utf-8?B?WkFSVDgyRk92QWJCVTl3Q291L1BBaSs2ajVuV1ViOVFDTUVtWUl3T1pGNXBG?=
 =?utf-8?B?REFELzUwbko1U3JLanE1ZnBwNjJ1VW03OXZGY3JjZ2pJRTlrdVdwNUlaaHdE?=
 =?utf-8?B?R2Q2UGc4bFVQM3FYYjhKTVhUeXM5d3RBN1UxbUJpZVlXNUh3eFdmakJGK20v?=
 =?utf-8?B?cUR1SHFVUlhFNklaUDNmQXF2UStjUWhqTjlPM3Q2RzZoUXdXbzZRbENhbUNx?=
 =?utf-8?B?MU9Gdk1ScEwvb29GVVRrYStmREhXR1NBT1J6NmZJUUM0R0o0STlBOE5UNWkx?=
 =?utf-8?B?VDUrSitRU1dZT0cwMlk4WmJpVzJQbW1Ed2cwRmdmekdXU3hQQ3NHQW5GWFFm?=
 =?utf-8?B?enJ3eVRMSEZuUyt6WHBHV0pDeDZ4M1Q4QmEwalVoN0QrYnpCcVFPbWFPQzJY?=
 =?utf-8?B?NDZ5cnF3MWdSdG04dFVURmFmeng3TGl2eU9QTjk4MHNRZmpPWnBVRWtvblV2?=
 =?utf-8?B?amxSSWN6anRvbytvV3VWZW8za3lpQ3NCUFpVbnFBZEplQVJGOHViNDhPSHJz?=
 =?utf-8?B?UkQ1SWtrcU1PTmhPTmRTTzd1T09nenliTUh4MFQ1OUdCSHR6UEp6RjI0R2d0?=
 =?utf-8?B?d2JqU09NdmJoMFZIMnF5KzUzck00STdZdG9BejN1V2ZJY1lPKzFITmUwOFdu?=
 =?utf-8?B?cXFuSzZPUEdUMGlWb2hRbUlZdlNNVnluQ3VtU0lFUkY3ckErcklvU2lNZ1lw?=
 =?utf-8?B?Nnd1dlZuWDJuY3J1VGcxOUp3WVhaQlpTUk1kb3pDTmlXZS9iQ3VNUUJkWkpv?=
 =?utf-8?B?OXkzcVBqSlpmWTFlQWFCTCtKUUowR0FjSWlqS2xuTkVvaHp6SGd0RWpEbnZK?=
 =?utf-8?B?azhqVDZwbm9QL0VEN2E1dnkyNktSdjBKTTRCZ2tnNGdhamlSK2ZoTTdyU0Y1?=
 =?utf-8?B?RGVYZ3Y5MHNDRS90VUVtOVIvUnp0bG45T1RPbG5iNlZWZVQrbE5iQ29Wc0hL?=
 =?utf-8?B?UElQNkxGcVF6MVFTN2gvejVIMWJGektjMDRJbUJ2U1FFeWtSNGR5d0ZudlZ0?=
 =?utf-8?B?dFh0NTlmWDBpaU43dWI5UHdDbFYrSEk4RTJKYllUajdKaWlRMEM3eGZNTURJ?=
 =?utf-8?B?M3pPQjc4amtsV3YxQ0YyQjdCbHE1aUFvSDdjSXZkN3VXTFVaVytvT2tjUnpz?=
 =?utf-8?B?OFRJQ0RaTUpPTWc3N3VYejZjWTVZd0UwSGd1V3daRGRBZ05ZcGRyZVd4VzI5?=
 =?utf-8?B?V3FsSklDdjl4ODFLbVZBQ0pOeGV3Q3R0OU5tdWc3NjhicldNY2FVWjZBLzk1?=
 =?utf-8?B?UTk4V1lRZmNuUlZzbTVVKzk3aGV5ZnRRbS80ZGo5VmRvdEVrekc1a1QvQ0FF?=
 =?utf-8?B?by90KzBWbkh0eWRxaklWdmwxdTZ0RC9uMXJwVGFuN1U4TTNUdUhUVFhsWC9L?=
 =?utf-8?B?a0lEWjd2ejAzbWgrU0dwVWRrR3IrNlJJTEpCZ1ZnUm5BNU5QRTNOT3Uxcm5m?=
 =?utf-8?Q?hUrM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?allOLzZRbE5CQzhJcGN1N1pVbW9CdlY3cHlFSDNubzl3SWEwRGpyZ21NQmlv?=
 =?utf-8?B?K1JneDJReUlUR25BVnJNSi9jM0xYTHlWbGM5KzdpTG40dEgraWVwb2RVYTNt?=
 =?utf-8?B?dzNYbEV2N1RjYzVISGlKTDlGaVg2a2w1OWpvUjdMNXY0Wkt1QS81QXQ1ZkJZ?=
 =?utf-8?B?NjZQUEtuQ0szWDRDVm5nODBNV3pqcTFEakJnZmIvVjFwdVQ1TFhjeFZBRXA3?=
 =?utf-8?B?VDdYS0xSNERuTzd0WDdCSHdoNnFaMVYyK0oyQThrU1c3UkNScm1pWHRDZHBo?=
 =?utf-8?B?eVFKdTlhdEtZMFMwTEk2bS9zSmlUSlhJNXpYRlowa3d3MWRLY3UzY1Jyek9N?=
 =?utf-8?B?ZHlJZHVCY0o3UHh5MFB2MDBZaFJVNU5yViswdy9TdDVlU0phc0x1SFp3dGxL?=
 =?utf-8?B?UlhRNCtrZ1M3S0w2V2JMUFYxVkZ0czZ3MEt6R0ZLUkRiU0hpNk9CeXI5cDFL?=
 =?utf-8?B?M0Z3NEhyNFFVUThTZWMyMmN1c3FlakRoNG5XZmN3MDd1YnFBakdRQzFCczIr?=
 =?utf-8?B?V0k3UHNTL1pkSWI5ejZzZlQyME9hOHRsT1RFWHV5Z0ZKaTlkRHZzeE1mZVQ1?=
 =?utf-8?B?a0ltL1ZPOW5jYzFBM1BQWGpQRStuTzc4SDFySFV6V1hkTWoyd05FSFVBYldQ?=
 =?utf-8?B?dTZNSU1MazFUdGVvUXZBMGRBQ0lwQXo4bnRjcFE0OGRpaVZWcWhRaElORGZO?=
 =?utf-8?B?b0R1QVdGc2h4dFYyK2lFMGxDQ1FkVW42U1l5bFIxSDZrVDBqZmVGblJYZ2to?=
 =?utf-8?B?N0g1UXprSDNrTFFNMjBZSlpMTzMrR3labncvY05teklWUll4cncraFoxU2Rr?=
 =?utf-8?B?Z2pEdmVSditabFJERGFuSUE4Ujh6NWxpZFZnenRPWjJkQU5oNmtSYllsWkFh?=
 =?utf-8?B?Mk96RmswSmVJUzI1STg3Y2VOQkRZWFphYTNsMWNhS292QS9OWjRuclNpNGVN?=
 =?utf-8?B?WElSQkV1UUpDL3BaeWZ1WDVsYTRsaWdRbDlOREtPeSsxbFVnL0M2YkF6WnFE?=
 =?utf-8?B?b1JsZDcxRU5tWkhBTU9rQW1Xc0dJNEdPNkozVmdxcnJ5Zmt1UXI1bGVIYUVQ?=
 =?utf-8?B?SUVSVVdJODR5bWxwaDFyQkJERzVRY3FqbFZpd3hZVHZRR0NEWUFxRkp3ODhK?=
 =?utf-8?B?d2JVTm1NVzg5cy9iSzNoSElvWXZEZExzcmlhVHJsTW9vaEM1Y1A3ZU5mZnQ2?=
 =?utf-8?B?ZUFLenovQm1wcDZaa2JHNWtKak5lWXZNeXl6eC9Sand5TXNIMDE5SzRVQzVL?=
 =?utf-8?B?S1BRT2c2bnJZSk1ZVlVZNHMyRGhPMUU4d1RiQ3J6a0djNnl1VGw1ZEw5alNB?=
 =?utf-8?B?SmJxaFBOc0d4cGVVOUNmUFB0ckhSdDJHVXlaNUU0dVFsK3dSdFlzTFlydTZo?=
 =?utf-8?B?ZWhhOFArK3RYNU5PSEQ0L1dNM05oQjZUZElhSjhUd0taV2xHejN3Y3R2eE5l?=
 =?utf-8?B?dmpuNG9YOHhJSTU5bjZ6MUtwbnBRdmNnejh0MlBnZC8rNzBkVm15d1lwaDhS?=
 =?utf-8?B?bVYxMDhTSG5kR202YjJnTnY5aFVxWU5XTDhKSHY2UjQ4Mk51Y3JLaG1mNXd6?=
 =?utf-8?B?dHdoMytSbS9rMXZ4OFJaYldlMDBUNlp2ZTBEVTBvbUdOV1JSSmYxdHpuL2RL?=
 =?utf-8?B?ZUxxY3lFVURLeUlyLzRTb200MHN4QTJ1WVphcC9wWGwwb3B6T2d3OWhvTlRt?=
 =?utf-8?B?cnRqY3Z3aWVLaitCRkpaMGJzOFJqNkx0ODVSejl5TjFXRklESGRmKzY4WnpE?=
 =?utf-8?B?WGs5THloUlJrODUxQkJYQ1QyTG5jd0hLQXNWZVA4cThhZVRvb3NkYkdmY1Yz?=
 =?utf-8?B?TmFDYlVPakNuRU4yY2FNSUJBY05zMjUwQmpZdU5MMW56NGVmOUVvVXlFTHNt?=
 =?utf-8?B?VEtaR2ppR1hFS3Jhc20yQkhicDZVQWFrU01DYnBLeHZsQVdMUUtaUHp0dnVo?=
 =?utf-8?B?WFVIR2szNTZ0TGprMzZMUzJmRzliZnVjNXNZejl1Q3JGb2NKVTE5MlczZ3Zr?=
 =?utf-8?B?bE4rS0g3a1pSb2NjVkRtTU04elJ1SWg4eWtQSVFXRzZCd0RGOW5LNm1ab2N6?=
 =?utf-8?B?S29JTEg2MnB2V21uenB5aXhvK1hFc0ZjOTIwMXl0Tld5dWNJeGxFKzByM0Iy?=
 =?utf-8?B?ekppeEN2SUxadVY2V1pjcEhlSzVGZkpBclJsaStpbmpTRlZzQlZIeEhGOTN6?=
 =?utf-8?B?c3l3MjJBSUVSQThMM0tlYXZhYzVOdkFIZllia0wrRTJOVXphQkFCR3dlUjZO?=
 =?utf-8?B?b0JCZVNTVVNmTEFacUhUeU9PUVlYNkpDMUVBaDZoUDVHVHJ6M2RNcVhKWnQx?=
 =?utf-8?B?bEFwejhmZjdRVTJZUHI0Y0xBUzRpMzBTWk9lWVJvTkVEM1BUU1Ztdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 187734b1-14e6-4abb-b6de-08de63236a65
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 12:54:49.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6tsx45Ha3YgLVnm8m/6cqgZejEeU1Fk4+ZwG+uOau+GmL+rQ3oY9KHGHiLSvRLVJL3WH5wqj1Cqvhl00RFxZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7985
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41967-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 605A1D9693
X-Rspamd-Action: no action

+ Rafael

Rafael, this is not at all urgent, but when you have time
please have a look at this patch set.  There is also some
more explanation below.  Is it acceptable?  Is there a
better way?

On 02/02/2026 18:25, Frank Li wrote:
> 
> Does your device Hierarchy look like
> 
>            PCI device
>                |
>        -----------------
>       HCI1            HCI2
>        |               |
>      I3C M1          I3C M2

Yes and no.  There is only 1 real device : the PCI device.
It implements the MIPI I3C HCI standard which allows multiple
I3C bus controllers in one device (in our case 2 controllers).

The PCI driver mipi-i3c-hci-pci creates 2 platform devices,
one for each controller.  The platform driver is mipi-i3c-hci:

 Driver                        Device                     Bus

 mipi-i3c-hci-pci            0000:00:11.1                 PCI
                            /            \
 mipi-i3c-hci      intel-lpss-i3c.0  intel-lpss-i3c.1     Platform

LPSS I3C also supports wake-up from in-band interrupt (IBI) via
PCI PME.  The PME only works when the PCI device is in a low power
state (D3hot in our case).  Also the PME is effectively shared by
the 2 controllers i.e. an IBI signal (the controller's SDA line
pulled low) for either controller will cause the PME.

That means there are only 2 valid configurations:

	1: Both controllers enabled to receive IBIs
		PCI device	D0
		Controller 1	Enabled
		Controller 2	Enabled

	2: Both controllers disabled to enable PME wakeup
		PCI device	D3hot
		Controller 1	Disabled
		Controller 2	Disabled

However, represented as platform devices, the 2 controllers
runtime suspend and resume independently from each other.
Whereas they effectively need to runtime suspend (or resume)
at the same time.

The proposed solution is for the PCI driver mipi-i3c-hci-pci
to take over managing runtime PM for both controllers, calling
into mipi-i3c-hci when it is safe to do so, to save/restore state
and disable/enable the controllers one after the other.

Current situation (I3C next branch):

	PCI device	Runtime PM enabled, dependent on child devices
			PCI subsystem controls PCI device power state

	Controller 1	Runtime PM enabled plus auto-suspend
			I3C subsystem runtime PM gets/puts the Platform device
			Runtime suspend: disable and save state
			Runtime resume: restore state and enable

	Controller 2	Runtime PM enabled plus auto-suspend
			I3C subsystem runtime PM gets/puts the Platform device
			Runtime suspend: disable and save state
			Runtime resume: restore state and enable

Proposed (this patch set):

	PCI device	Runtime PM enabled plus auto-suspend
			I3C subsystem runtime PM gets/puts the PCI device
			For each controller:
				Call into mipi-i3c-hci (when it is safe)
					Runtime suspend: disable and save state
					Runtime resume: restore state and enable

	Controller 1	Runtime PM disabled

	Controller 2	Runtime PM disabled

> 
> 
> You want HCI1 and HCI2 suspened only when both HCI1 and HCI2 can enter RM
> time suspend status?
> 
> Device Link can link two devices, but not sure if it can handle cyclic
> case, HCI1 and HCI2 depend each other.
> 
> Or you create common power domain for HCI1 and HCI2, in power domain to
> handle suspend.
> 
> It'd better ask run time pm owner to provide better suggestion.

Ok


