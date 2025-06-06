Return-Path: <linux-pm+bounces-28183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC011ACFD8F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 09:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424343B023D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160D1E5201;
	Fri,  6 Jun 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mslZrvcq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE67FD;
	Fri,  6 Jun 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195308; cv=fail; b=DVYu3eUL0+Tshxd59OA7HyLSql8BeSU4JsHxAj2YYClsHEUnssRlk7PTQHILZAt8DqixIiXuZRW2UbeMIcvPbC9TCpe7vRL/hge6Urdf/pzWfhLA1aqqLUiGK8a0dSD9JjMZ+AsBarJJJmSNEYT78uWMwWljYgTqQCBc+6ISkCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195308; c=relaxed/simple;
	bh=4JnlFLhX+9TkvqI47fnz85dL/y+X4ZIQmrxjU1rn2SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ep7HaVYJMN11KNeoqZgVrYTCoTOtcQvucLXvDX1R5c1MrP+FNAqI7Pp+amUqXVDIAP1eQLA0CcI2JZw+ABPuh7PJWKSvsT+3SONbGgnXZFi/oOUY80xQIPYa6kXoP0Rp/GmYS6uID0xtNw17kL7bJCF8MS8sAfwDcIMVOlwHHUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mslZrvcq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749195306; x=1780731306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4JnlFLhX+9TkvqI47fnz85dL/y+X4ZIQmrxjU1rn2SM=;
  b=mslZrvcqPKqN0gn7djvKS36hkOv0Al9EpmkYkrnIEmbH8IWuo7H7gfEK
   FkFvoSBsPlaSez+nXEvimZ0kujvpHzD45FPoRU+qtywXQarSH3hTBPYsl
   ppcP5/QyUWlhLYYtpiDebGEx7JKiYew+bEGMwO4yenmIopE5Ng90MZxxy
   z9YWHVVAOvrG6SYkxYjigqdwLEmz2GgCjQg/iy7aFtueouaLxDa8E29CO
   0bYZ1sdRDY0NZXp4JD/aT26soktWSlQZwZFWL/oC9qB7mdkzHA1oBoB0X
   +/CchijlxSiKzQhpFY0M2N9VSbsUmwL5BaWtplaVFEvR+cd2iwbzqoLzs
   g==;
X-CSE-ConnectionGUID: xR9eM0q7TkuJHGmZiuG65A==
X-CSE-MsgGUID: 1ybpRVGuQ5SwMCpvrg1nfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55144950"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="55144950"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 00:35:05 -0700
X-CSE-ConnectionGUID: S1lotXHsSYSWtTaOd3vWfQ==
X-CSE-MsgGUID: JDTAD1qzTIKN7sM9rr8qgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="150906248"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 00:34:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 00:34:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 00:34:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 00:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF2Kg7L5D3f1ZrU7jZRZFF2eUoLiFD/8wjTpG/OlRQ2KZc0p+fWOsEcjgmHAgYHwEnsS7Dru9XHXI2pfriNoMgKctZ2rB4NqenjlROdfxkazVt3FdHjHLXp6QOX4lA9iJlAM1ceMmMfv9P/aJYcmpfX5I0zZ56W2mNQ7e/HZsadIUYkFy0JqgUiOzOssrQmpQbvm/uJvh1X4xGRzxPJqVw3JgtR4J7lqkvVCUfSlt10aLVCm1yQgcZFTMD1rbhF3N7Y+KEKFn0r4MGH15PJrdVAN/9uPmjHN3sItYfYjJDrYEeG3ADPeofvQC35XJqpqsW9RLOjf8jkStlfJLPx9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JnlFLhX+9TkvqI47fnz85dL/y+X4ZIQmrxjU1rn2SM=;
 b=V0ZpGuXwxPFKhbkOJWPuGmhXo4hnzSOQCpmotogPXV0ogWnIMQliPkhiqK6JRk9DYg5njo+pqPogYhYmuT4O5+Q6u4FB3Xkgj2KDgZkg3XgUJwgb4bifkQqiti82IFjsFtOts2eRXoQNOJLVWyzujBsGr9eRxItzpFS4CieShYWMFkgJ8ZA4hW/vMTnjCLluNSztu40poGaYs58VmQdvkEyoE1VThfVSKqQWRUXP1GfgX0sZaa1gYZDyprslJ0evQBavKqiOOltAoMNy0k0re39yFdPSSPUIY6Aw2oBbWa4LFdYUr0102wQ9cm61FbvtDYj2Pcl2XBoPSikGVXjC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by DM3PPF68472F2DC.namprd11.prod.outlook.com (2603:10b6:f:fc00::f29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 07:34:42 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8769.029; Fri, 6 Jun 2025
 07:34:42 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] thermal: intel: int340x: Add performance control for
 platform temperature control
Thread-Topic: [PATCH 1/2] thermal: intel: int340x: Add performance control for
 platform temperature control
Thread-Index: AQHb1ZA7gn/+BRW2hUK5BKaCbnhSkrPz4oMAgADwAoCAAO00AA==
Date: Fri, 6 Jun 2025 07:34:42 +0000
Message-ID: <c672a842ba17a69ed1e080549e0066d50303c2cb.camel@intel.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
	 <f33e302aac482860eebf5e5f45a44df77455512c.camel@intel.com>
	 <5a0dc3858c802a5d6247424529377c6dbfd450ca.camel@linux.intel.com>
In-Reply-To: <5a0dc3858c802a5d6247424529377c6dbfd450ca.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|DM3PPF68472F2DC:EE_
x-ms-office365-filtering-correlation-id: a26fb759-2ff0-4e88-9c29-08dda4cc9a0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RGRib3dweXVEbUxmcXJOcjZYYUZsZUJBVmNMb1lmL2x6NGpIUHJFN2dNSnJx?=
 =?utf-8?B?Y2dYL0RZdzZBaHlaOE1rcGF0MWRsNmhVZFc3cjRkR0VCQzQ4Q3p1M2I4d3pp?=
 =?utf-8?B?NzJWOHFacHM4clJKUGxJZUJ6SUI4b2pSZy9rM0FFR1BHTHp3RVp5TlQxWU0y?=
 =?utf-8?B?aFQwRktKYWhuOGU2T0pwbm1adC9WOEhNYkpYRlBKY1lJL1ZTUG8zeWlYUURs?=
 =?utf-8?B?OXczUUlNRXRKS2ZTWi9kVWZvWXl2c2NNZ09iNndiaXEzZGtvKzdqcUlxOWFi?=
 =?utf-8?B?UTZEK3FidzFEVXFpbXZPTmRxR2dPZ1pVK2Ric0htOHZJa0RTbjJLUmh0QzZK?=
 =?utf-8?B?Q3lLT1pIaVFMUW5OczFaV1BjRzlmbkJ1YUJ4LzcrenBLdmtYUHFGT2dhT1ZV?=
 =?utf-8?B?TmgxS09CMnkwRS9uemFOZjBvZkgzU1hlMThQV05iTXpKVFZDL2VMTDlWbXVB?=
 =?utf-8?B?UExRYW5YU2tUU2xDMmZmVTRyYjVLWVlGU2NJdWZLS0NLMHA3R3JqaFI5N0NJ?=
 =?utf-8?B?djUxVUkwNjNUb0Y4Y3RqS0NhR1NkSVR3TzQ0U3A4VVZFZENTMklaRVQwZ0h4?=
 =?utf-8?B?YTRiaDdCOGt2dWtla052emI3VnRDYmp5T3YzSzE2a3ozQk9sZjJUNnh6aExD?=
 =?utf-8?B?djVtcVBac1pBbVNtWFphWWZubkFVTWdJNFBUaW9aeW5lSlVnQnFrVGJYd3Ir?=
 =?utf-8?B?UzRYcXU0RHMwNVZ3NiszTnJNNVBqWGx0VTdKWmNrQ3J0QXcwRGhqcXpyN3Nq?=
 =?utf-8?B?L1IveGgxMUg3UDg1aFlHK1Z4MFNoZ1Z6VDEvVXlQMXJVZHZrQWdEdndCQVNr?=
 =?utf-8?B?eHNROC9jdE9TTUpRZ0k1TEdYVVhYUGE0UHc4YnpNV0dRRDdoN0swQVhBS1Bq?=
 =?utf-8?B?NGUxRnBhaEdOb0YzREsxKzBzTEU3WHBpK2l4SzNmSlBFRXZBUitmaHZtZGRq?=
 =?utf-8?B?K3paZnJQLy92bzVhaW9mclJhVHlUbWhwSGpWN1ZRcU1tRERUaUxsNlp6ZU92?=
 =?utf-8?B?THYvbGNYajNqajNEenJYT1VjQy9LZW1HSUlIL3BrMzFXQUJPQTdaa2krT2Zu?=
 =?utf-8?B?ay9UOVZ3WW1OUHdHcDN5VWZwL1FkMGdaNVduOGVvd2ExNmI0ZkxiRlhJUGtQ?=
 =?utf-8?B?emw5THN3T1JhTDBnWDRVSlhnMFo5bG9xek1FakdTa3FVZ2VnM2l5K2ZwQ0tH?=
 =?utf-8?B?ZS8zT0hDVHowams4MDI1RmdNazBJL2pBbTZlcGxxWUVIc1JvRXkyc01MdkhW?=
 =?utf-8?B?bWEyQU5RSERkTVhjdGhiOEJRUDNiQWNIWldMblVwS096RHgzSlZUdlZrZTdU?=
 =?utf-8?B?Yzhna3d5eTFvSzRmTVU4QVVQSjg3WTVBSm5Wa0NHa2d3RWRRd0lBdWNHNEF2?=
 =?utf-8?B?T3kxN2FqNTNTVllQczhMRnkwbUppTytPOUtRbE43M2d0M0tiVW14NkVLZSt3?=
 =?utf-8?B?QkRPUXhjend3VzdGN3ZTM3V1L2dXKzNUZXkyQ2FVWFU3djIyZHhGc0hNTTlM?=
 =?utf-8?B?MUk5SXo1ZjhZVEplb1AzVVUzc0dJWGg2TFFtcnhVRjBSTGZrampLKzJZNXdn?=
 =?utf-8?B?V3dseXR3UENuMVVibmE0MGlnVEpFVmsxYmFrblN4OEtLNzczMXF4K0FzOWZV?=
 =?utf-8?B?S3RwWkMrSFZsZmUzaXlyTXNLdFo0OVBHaFF4YUpYZFNHbGNzMGsyaHdac3hu?=
 =?utf-8?B?dkJERHZ5N2lJNFBjQml4VzdkUWxMbWNJV2hJSjNRVHlIMXRibjZzM3Y1clh1?=
 =?utf-8?B?dUZlcU9SdTUyUFRrNUFwcjQ5YmoxVnlNbmNHNUxSeGVScXJxNUczdm94L29D?=
 =?utf-8?B?UGVKdmxaL3NIc010cVpVYXJkNzNnR2V1a1BWOG9Kb3hLMlJJdGFqbTI5Uk1D?=
 =?utf-8?B?MUxOSlBOU05UR1BCY3h0allTT3VtekN3dHJqL0tqdnV2ZUp4YXd6YTBmUXFY?=
 =?utf-8?B?dzZMN0JCNWk4YTYvdnBWWENHVkVXY1FYdTJxRTlzRFcxRmFMMy9rcWpqQ3dh?=
 =?utf-8?B?UGpPeW1HZmZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2xjUVJtWWwySUJlSVBpMlkzTU43SjVZcEZuSEphZ3lYUE9hQ3ltK3RHaFJO?=
 =?utf-8?B?RFN5MGhVd3RwV2xaYk5ad2pqc0hZeVNxNEdMT20rSGV6UDlWbkdHVFRDTzJL?=
 =?utf-8?B?Si9HbHVSMkIvOTFwdHBqY2p5bWwxcGZTU0Ewd3Roc2tFYjNCSnhvNEw0bk9S?=
 =?utf-8?B?MnpZNGJKWmZOeXAyNjltTVFiemcrYlg5Qjg4TUxCdnZoZlk5cFRNUUY4c25Z?=
 =?utf-8?B?d1NyV1VFQzZCTElobnRJMlNxbk8vNkVQenlwUVIzMjRIdXFJYXo1OEUwS2RI?=
 =?utf-8?B?MWk5blRSOGJqYjdTOHZtQ0cwbUxuMk9vY3p0WmJlZ3lkUHFDaG5xcGZ5L3Q0?=
 =?utf-8?B?d1FUK3lNWWhxR3lmU3lCWjdnYUNqeGFHdGVPcExCNUd0TzRxeFBqTU5Wb1Y5?=
 =?utf-8?B?eFc0T2wwQTl3VmpleFBZRHYwOXFMckNadXhXRFZZaXFRQi8wVjRWZ2hnaGNF?=
 =?utf-8?B?ejhyK2dwcWNLTXRwaFlDWmp2K1duMzFwK0Z1Zld0bThPWWtidDI2eHYySWdP?=
 =?utf-8?B?WVhNQmNlZjl3VVh3MnNKRzBxQ0pHMW8rNVlid2N6b3IzZnVNMUtjQ0Zqa1Qr?=
 =?utf-8?B?ZUhTU1A3aURNeHJ1bjh0Q0FjRGxzWkM3Mm5oeGNZdDE1VU9sMlRpajhBZGgw?=
 =?utf-8?B?VjU4RmtNZG41b1R5a1BsNWNUT2krL1pJSW8xYnZSWFZhTkg2bGtIMzZnMFB5?=
 =?utf-8?B?ZmhQS0NNN1VjUkdOZlF3RTVrWHJSYVJJRmNZRENjbHpreTM3cEZDdDhkNlhQ?=
 =?utf-8?B?NE9sVHk5b29Ub2tqSGRaUlBCa0hkRnh6YXh6eTFyaDJUVjIwaXBGRTdyYTgy?=
 =?utf-8?B?bHBFWVBBamJtd2dKeko0T3JQNy9yRUIxY2JCTWh3V0JKLzZiOGE3TUJtNTZX?=
 =?utf-8?B?SmVGQ3dMNlNoWUw2TVB2c0Foa2IxaWRlRm9qOUlYcEprN3NtNGFCRi9CalI0?=
 =?utf-8?B?QTAyQTNtWDFib00xdThKREZjYzcwYXJIUjdEUW9DdEhmMmV3STYyZ2p0alVP?=
 =?utf-8?B?NHRLZkp1SUZ6c3BXWisrT1ZEeFZ6NjBpMm9kTHhxKzgybkxLOGs0RXJZd0dp?=
 =?utf-8?B?WFcvVXN2bVZkWGNkNGVtSlZWVG5RMzNSRlU2ZjN4ay9ZN21jcHVYVEFNUFVa?=
 =?utf-8?B?WkJzYzAveUVDeDdGZllkSkwxT0toeEZXdkloSllrMDlabWNyQzBSTmtsT291?=
 =?utf-8?B?RW5tZlFtLzhONWVadzRFc3Yvb1ZhdkZWa3lYUFBiU0tQRm12UEM4UVNkUmgw?=
 =?utf-8?B?Vk9aQnRqVjl2VWNwR2JZZ0xjMGRCSElBVGlhRTZIUXFSdVc2cThHK3lEZncy?=
 =?utf-8?B?SXBSY2ZReDdFbjNhOGhvR2VCVUFVZ2JOOGEzRTlzc0o0V2JIOHViMHlpWU04?=
 =?utf-8?B?VXE0OGRXQUpObUE2enYvVFk4UFowT2IyV3psRmFLcHBIRW1Gb01zaHg1ZGMx?=
 =?utf-8?B?N3F6NkVSSnJvcjlGbVFyS21ocGs2UWw4Z3VvOUhVNllRYmNMVVI1TUhkSWtX?=
 =?utf-8?B?cFRSTTNtUUhkTnp4K3d4RmRYZmt1NitxWHU5Y0hHaUJpbk15M1E3YURCT0pT?=
 =?utf-8?B?QThwT1M1L2wxMFZhNWFxTEw1TGc2SkNIbDd5ZTYrUFBSQkNBRCtuNG5RbGlF?=
 =?utf-8?B?TTdSM2xxRktiWUZvRlBOdWNwN0ZWck9KWnNrVWxxbU11NzZXbVgrcTRPYjh5?=
 =?utf-8?B?d3ZXVWF0V3Fac0hRWmpXMVZGYVJYell3eDY3WXBvOENXU0dXLytxLzBWaVhJ?=
 =?utf-8?B?YUxMNlhJRmZTYXEzUFN5WWFKRXRxUUVaSFZ6SG1LYlNsWXNWNWFWTWtNVDAx?=
 =?utf-8?B?bDlpTVZPTnVpNnFrN1RIajBqVlZpUXowTzAzV01JRk9HdW1pNXhKQU0xanQ4?=
 =?utf-8?B?cnpESm1qUWRXOXNvUzJhMit2cjlqT1h1WXAxZXpLdHVud2twOVRwY2ZoRFVS?=
 =?utf-8?B?S1VzSVU0T3BSTlFiZWdyRFQ2b3dRTFVWdUdoQmpzaVdnSkppUzlxaGJBZUFZ?=
 =?utf-8?B?RHJDUkxIZlp0eEorWlJpL21zWm00TGVRODMzVnp6OC9yb0R3czgzcStjaU9v?=
 =?utf-8?B?NVZCMFQ0dDcrOWlVM0lINCsvN1N1Tm02eUhLRnRpc1FqcGZZVVQwU0pYa094?=
 =?utf-8?B?bHFCcnZuMEJHTk94S1Zwb001eVZlUVd4TThwbkN5NVdBdWVyT0RTTGVRenkz?=
 =?utf-8?B?QzdjS0M4VDJPa1RiZlBxdTVKT2g0S2R3VW95c2s3N3UyY0UwNElPamxRTDMw?=
 =?utf-8?B?cWFSUTFGczZ5ZEpJbXIwdlRmK2xnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D541636CBD2AEC44B5FEDBF83BD8CE41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26fb759-2ff0-4e88-9c29-08dda4cc9a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:34:42.1027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lb69Jgpv0JnJ3Q64I5cYh2dtf6+0RSO4h0nqXY0T0+7Z61xVB7xGUxEfTf1weE6a+1SFOsGfllLdt/6xVImzEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF68472F2DC
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA2LTA1IGF0IDEwOjI1IC0wNzAwLCBzcmluaXZhcyBwYW5kcnV2YWRhIHdy
b3RlOg0KPiBPbiBUaHUsIDIwMjUtMDYtMDUgYXQgMDM6MDYgKzAwMDAsIFpoYW5nLCBSdWkgd3Jv
dGU6DQo+ID4gT24gV2VkLCAyMDI1LTA2LTA0IGF0IDEzOjM1IC0wNzAwLCBTcmluaXZhcyBQYW5k
cnV2YWRhIHdyb3RlOg0KPiA+ID4gQWRkIGFkZGl0aW9uYWwgYXR0cmlidXRlIHRvIGNvbnRyb2wg
cGVyZm9ybWFuY2Ugb2YgcGxhdGZvcm0NCj4gPiA+IHRlbXBlcmF0dXJlDQo+ID4gPiBjb250cm9s
IGZlYXR1cmUuIFR3byBhdHRyaWJ1dGVzIGFyZSBhZGRlZDoNCj4gPiA+IA0KPiA+ID4gZ2Fpbjog
MC03IGxldmVscywgd2l0aCAwIGJlaW5nIG1vc3QgYWdncmVzc2l2ZS4NCj4gPiA+IAk3IOKAkyBn
cmFjZWZ1bCwgZmF2b3JzIHBlcmZvcm1hbmNlIGF0IHRoZSBleHBlbnNlIG9mDQo+ID4gPiB0ZW1w
ZXJhdHVyZQ0KPiA+ID4gCW92ZXJzaG9vdHMNCj4gPiA+IAkwIOKAkyBhZ2dyZXNzaXZlLCBmYXZv
cnMgdGlnaHQgcmVndWxhdGlvbiBvdmVyIHBlcmZvcm1hbmNlDQo+ID4gDQo+ID4gQnkgcmVhZGlu
ZyB0aGlzLCBJIGtub3cgdGhhdCBzZXR0aW5nICJwdHNfMF9jb250cm9sL2dhaW4iIHRvIGEgbGFy
Z2VyDQo+ID4gdmFsdWUgbWVhbnMgbGVzcyBhZ2dyZXNzaXZlIHB0YyBjb250cm9sLg0KPiA+IA0K
PiA+IEJ1dCB3aGF0IGRvZXMgImdhaW4iIG1lYW4gaGVyZT8NCj4gVGhpcyBpcyB0aGUgaW5wdXQg
dG8gdGhlIGFsZ29yaXRobSBvbiBob3cgbXVjaCBwZXJmb3JtYW5jZSBnYWluIGlzDQo+IGFsbG93
ZWQgdG8gYmUgaW4gYWNjZXB0YWJsZSByYW5nZSBmb3IgdHJpcCB2aW9sYXRpb24uIE1heSBiZSBj
YWxsDQo+IHBlcmZvcm1hbmNlIGxldmVscyBpbnN0ZWFkLiBJIGFtIHVzaW5nIHRoZSBzYW1lIHRl
cm0gYXMgaW4gdGhlIHNwZWMuDQoNClNvICJncmFjZWZ1bCIgYW5kICJhZ2dyZXNzaXZlIiByZWZl
cnMgdG8gdGhlIHRlbXBlcmF0dXJlIGNvbnRyb2wsIGFuZA0KImdhaW4iIHJlZmVycyB0byB0aGUg
cGVyZm9ybWFuY2UuDQoNClRoYW5rcyBmb3IgY2xhcmlmeWluZy4NCg0KLXJ1aQ0KDQo+IA0KPiBU
aGFua3MsDQo+IFNyaW5pdmFzDQo+IA0KPiA+IA0KPiA+IE1heSBiZSBteSBFbmdsaXNoIHByb2Js
ZW0sIEknbSB0cnlpbmcgaGFyZCB0byB1bmRlcnN0YW5kIHRoaXMsIGJ1dCBpdA0KPiA+IGlzDQo+
ID4gc3RpbGwgYSBiaXQgY29uZnVzaW5nIHRvIG1lLg0KPiA+IA0KPiA+IHRoYW5rcywNCj4gPiBy
dWkNCg0K

