Return-Path: <linux-pm+bounces-43636-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNXoKif1qGmfzgAAu9opvQ
	(envelope-from <linux-pm+bounces-43636-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:14:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B820A766
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA92D3015714
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 03:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40A72749D6;
	Thu,  5 Mar 2026 03:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wwt/j/Ij"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F2272E7C;
	Thu,  5 Mar 2026 03:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680476; cv=fail; b=ZI7WjM4jgmDmnf9QwW+Q91c76ZSVJHGdkmzMOGKXMW/qpwVlX12JQI37uJRHHhVsfVukq1L37AQwSt8YSQntZqPVsjZurTwGhzI0hpegukTAtCdle11eJ0gVMXTJ1KxSRLTi36qEW9hC54BcwiYBjcY97ok26+h6C+828XC7qeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680476; c=relaxed/simple;
	bh=0MXIlurCfCNvv85ZDRLtqG0Tn/hqOpLizb5V4J8LsO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kLxmkUk/5UQC6K+DsmVKXhA/WQaQya0JXV901a7yADagrkj8aDn9+bxrvEKgpXiTUexFoLhnRkkAzb0887uPX+QtoIosTPFwqsCS6Bl7rZDXUQhHDnW7EE0sxhW3PnK38b4ZtkMDsetaBIbTXZf6a1scl4I3HQRr3VjCM86COqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wwt/j/Ij; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772680474; x=1804216474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0MXIlurCfCNvv85ZDRLtqG0Tn/hqOpLizb5V4J8LsO4=;
  b=Wwt/j/Ij9x80ZP0bDclMCszh95c6Sl1fIbB0psCtQAQx9+WG1Rt5pAG4
   bvzBBYBD7yD7akKwrz/4UopD95ZzjCOrBHQW06PPRnm4IEFO3vgag4b/Z
   KMS7+BrxNcRru3r0MW4PrjD+7l4HwD+LAIQR472KupLTgxSzSqRkMfRJM
   qXjBmHZ9sKzu6kfmOqB0u7Ka6P9icn9ibiKrUd7SdTLgTNSzyQHUhknzX
   +BaoQzeYNUaUBegI2WjpQlPkk424uiiLIP3wJH8VHVwj+yY1olDnd1HMF
   jy2f33KbcrguizTBfR/HJLRx+p3Shx0SZ2/nDTeJfCJCSCM5onWsZmdBl
   w==;
X-CSE-ConnectionGUID: RS3dHvAdTgifGPAd+VqV+Q==
X-CSE-MsgGUID: r8ZbxuWbS4CUDAEtuHJ9VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="91328473"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="91328473"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 19:14:33 -0800
X-CSE-ConnectionGUID: OYHnFew9SaCcnb7ITmPycA==
X-CSE-MsgGUID: QaBEB6gMQJKgBHQ9a9YG5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="249014051"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 19:14:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 19:14:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 19:14:32 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 19:14:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsdFyT+GXOfFAe4iFwi7HNRwyQmVevSMi0XVRwY+eVfZXPHrZUDQob+b8vD0yUGPVaY9XfJBOIZ0ZMCP5Vr30bsdSEM8g13DBH5h4uDGJEyddGUrKSxM8VKPjZ/DsmhmFVzWzsZ/kcFTWscgmTZpOHzqeKKkAxWcxE39s0P6+1zRsSsczjkc5ttAps4eDLNLD1YThGkLKj/s6P41d03sFjkKdjXaPE7B+EWh2gcOQAx9kxP3FNxNDqOiCKTpzlAc77j8Rz4f+m3jac2UZmkRFoGwhKkLHR1Csxa9YdXTXstapWZzR1fB96latcz/lZAGrgfXGGVRJBdIgUHG0bQduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MXIlurCfCNvv85ZDRLtqG0Tn/hqOpLizb5V4J8LsO4=;
 b=sQ+KOd4h+ROMVx3sheFb+OPPpyyiPGEwPQfag2OfeLF1GfKRNH3CCt8svay0W4BVvvdww4BJ7y1fUf6iVYGcQ7PqEiOoQ65y4CaJAOkq7DeBpD0K38++AupKxcQrTu80A5F/HndVI80D9w7gPvflmq7Qt1nA1r1eCHzsONCj/v0e64+hULO/0PWoospK/nzRLWPOy5cwxZfUNwyPD5AlE11ePtu0Z9gDRwRQniaTTOraw9pRd/Q2hQX2rshc8TOJyqFtADRA/Ioal8rCFelKy5VH2cObgEXMN/P5youMz9/1hZJKjw5+RpWEGb/s2nIxFyujPKxRxfsCSX09w7uahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7489.namprd11.prod.outlook.com (2603:10b6:806:342::14)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:14:28 +0000
Received: from SN7PR11MB7489.namprd11.prod.outlook.com
 ([fe80::7114:e8c2:4d34:2901]) by SN7PR11MB7489.namprd11.prod.outlook.com
 ([fe80::7114:e8c2:4d34:2901%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 03:14:27 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "trenn@suse.com" <trenn@suse.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"jwyatt@redhat.com" <jwyatt@redhat.com>
CC: "fj5851bi@fujitsu.com" <fj5851bi@fujitsu.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Kumar, Kaushlendra"
	<kaushlendra.kumar@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpupower: Add intel_pstate turbo boost support for Intel
 platforms
Thread-Topic: [PATCH] cpupower: Add intel_pstate turbo boost support for Intel
 platforms
Thread-Index: AQHcmXP/aT0Jpeh7+k2WOPhhbZu0tLWfaLyA
Date: Thu, 5 Mar 2026 03:14:27 +0000
Message-ID: <5eeb01d0052f95bacdde907a8767a756fbc61345.camel@intel.com>
References: <20260209032441.489281-1-rui.zhang@intel.com>
In-Reply-To: <20260209032441.489281-1-rui.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7489:EE_|SA1PR11MB6944:EE_
x-ms-office365-filtering-correlation-id: 2a412217-507b-435a-59fe-08de7a654f92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: XlhbsIGTH3pK+mz5XNpBHGZc1aHKUfUlo/9X1DKSDt65VzUjd99aCjdZUl2Hdx0K8JRCTNf/TVZ6rm1plhKusJGAJFGgWhrFBQy51lZcOBUcltLXKsE7Q/jnUqoDUDIs+ciVhXPYnqyHJ0AfkkyU6qvjwDcGeKdhfeS5bl77NyFv9AlAgJoBjm3IxTqASqXrtWcxDfmDxytISPkprt8kyN4gSWmDLYbOhTG23ains3DT4f6GNnG4OsvYxht7h0i8+IDceIg8aanOg7JGdLo7gIU2lBlaJ3QxTLy3ePQN4NXf24Zka6ufvEPwlgE5T/F20miYVWb+Y+E1ANRmHlSQpXMU83wUawYFBmiq7tMLoPmdWhWFzvlxVsY6AsBWAAgZ79lWyIbbgfvjU/6W2C6WVHtmLtr8ssbZmt1QwbjaYxdl7NVQOIMpsHZKhaQvpET2+YxZoDCcXffJcm1xpiGqtkv7hg6WBau8rV8snz6warLKMJ/Em+YGOaU3viBQdoiFj10H6DKLZrf240K59177uCrBFtQvIwApTdftGidr4s0ese2egCAeJdWi+dTM9UdpkUs6Yff4rF+J4JTbY9V+oWzK8wubN0sNxfWfmND1+30gdh9/SHEVaB2he7CCGG1QhYQ26v6KqlBj2IzliIqPCtm/q22B9qGX8ru2CRQcBmOlgAE3FFGBFYWW9TBHealg10OaPIVKENEir/K5YhpPblxOeSreYadEP22mNTzS+uXrn/lyxymofSvKOg3Wms0CJzFYpwFmATq2MxTQxIf3Ers/AysgpVODZA32MVDwiRw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7489.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXVOdk8zSDgzbXkwYjBKWlFSRzlXc1NPay9lK2FyRmVHaWJCSE1Jc1RmUFNF?=
 =?utf-8?B?T1pMWjdxU2xTNFd1aVpCUWlnWDJpblY5Mk50b2FOOVdzcTFkck8reHpaVlQ1?=
 =?utf-8?B?bW1CN2FzTE43YzNqUE5UZjFwbWFLZjZuOFMwVk5icGFTUmh5YldnQzZySlFp?=
 =?utf-8?B?aDBOVXRZbUdKRFNXVlhBOU1udVFlaUlkcEI1QmJ6NjExTjBmREdYU3UxbHdT?=
 =?utf-8?B?RkwxWW9sMmQwcUdtSlV5QjV5Q3NwbjA5NEswbFMwWlBjZTN3dUNTMjBzOGIr?=
 =?utf-8?B?S3FIUlg5VTYvb09wMWMzZmF1ZlU0SnFCQzhJUUtMdGNSd1c1ZDFVY2lacm5m?=
 =?utf-8?B?cWNPWmsveUNGUU9VQ3JVUUpUdGNKdzlwRWhPQVRLQzRZTlBrUkx0WXgyVjc2?=
 =?utf-8?B?WTFxTERZNFJwQkE0aW1GRjJWajQ0eGVWOGV5cGNDVGhVMUpJck9oKzU4cGR3?=
 =?utf-8?B?NEdTNCtRSis3T3V5VC9vRWJRQlRLTkxhNCtFYkU5QmNDV09QT2VVTmg0dG0w?=
 =?utf-8?B?ZUlzZWtVR0sybSs0aVdpaUhGZFI0aWZ4OSs0d2Z3RVRsd29YOGNOZXpmMUF5?=
 =?utf-8?B?WlV0UkJhblZONGVWcWthNnhneUFhZEJiUzc5aVZzMXA4U25sOFF4blFGeG1v?=
 =?utf-8?B?Unkya2IxVzVIeVBNSHViNFZoc3NnalJUcm0rTVllWm94SEtQMmZJRFNsbzNW?=
 =?utf-8?B?OXZqNy9Ra05vZVk0bWM5MXUwTTE3N3JBVkd5ZFVRS01WbjIvdWNtbldtYkow?=
 =?utf-8?B?OTRUc3QwRmxHMmltcXZTMFBUYVVaWDB1L24rdnZPVlRaWCtjdmY4YUV4dVRt?=
 =?utf-8?B?bTA3azk0QnhtOFRIN2FJTDJGYS83M1hZd3Q0WVhJQ0MyUDFXSXZWOWhmd01V?=
 =?utf-8?B?N3lMWTkzYjBoMzBaNFlORTBHK25MbXZtTEUrM1RrOHlvc1h0emlxUG9QMlVN?=
 =?utf-8?B?b3hOMmkraG1VUjlLbDRXakpVb0pkVUhJTnl3c2YzMlc1UkdHdWdIYUQrSmNh?=
 =?utf-8?B?bTlRdXJ0YnA3bGlPOFBDZUxqQzhhYkRWS3Vuc2RuRDdPeGtFclF1V1ppQTJz?=
 =?utf-8?B?a2p1eTJWYzVCVllJUnNsUmpDckpIQUdCaWhHTm9TWUE3RjVkSDl5dDQ0QU5E?=
 =?utf-8?B?em1aSk1xQ3BHYTJpZDVTbVRkNGlzNTN2bFl5Uk5ueUszSFFLUGxPazZ2YjU1?=
 =?utf-8?B?ODBJbmtRZE1xL0N6N0hkUjJjaHp5N29xK2xubDBxb0tTaFVhcy8xUDY3clB5?=
 =?utf-8?B?RWhBamVqN0ltaHgxVEVNbVFGbjFMVTZLYmJkT0RDVzFmbUJrQ0ZmQ0N1R3JP?=
 =?utf-8?B?bUVvbmJxeEk3WVB6dldyZDdKYjIycHVaMHQwL3o1MTZZSEtaUmV5R2hXdVV5?=
 =?utf-8?B?YXVMOHNPa3dvdk9WRjd1QVMyZFFLQjREdnNFNHRzK2VsUVFGVDNKSnkwUUsy?=
 =?utf-8?B?a0dyaVV0QVpsWFJjSE1xR3U5NXV1N2t1ZVM3TlZMeUF6UUxBWFJEcXNlM3Ry?=
 =?utf-8?B?Rld4Ti9KcGthTmYxSEovOWNZbEtmellwQi9SemJWWCtubkI5SHNteFRxVXo2?=
 =?utf-8?B?WnZ4K2JKSkJmS1BTYlV5SW5oaTFIeU9mRUNsWDBMRXZYYkJ5dlpqcjdleWEv?=
 =?utf-8?B?Z1JaUjBiNGNNUXMzSFN3NzlUWDZtMGt5Nk9CTTh1SmF1c0RCL3BMYUk0Z0xQ?=
 =?utf-8?B?cFlqTWUvM2x5OWZxVUxCaUxFYkJ6WmFwVU83M1RRWjdtd2pUSWZ3MWtxTE4r?=
 =?utf-8?B?eEdtWHVLNmI4dGZ1WERPbWVxQmtUZURZbmthZUJpREt2dWc4N05RRTQ4Mk1p?=
 =?utf-8?B?K0lvLytPTUgvME1QQkZrWnVKcVNkZ0dPVnlERWJqMzBhOHVHaDdiT1pmRk44?=
 =?utf-8?B?OHF4dEhPZ1Q2T2xVK01maW81NmJRVVdsWGJvdEVWQ2dRUWtCakQxMTlQSXZ1?=
 =?utf-8?B?ZVlhUkpKeDBTM2FJWkFTdGdicXFuVzFtSjBadEdWMjAvQlpQYmtzTzE3aVZ1?=
 =?utf-8?B?am5NTlZ0UUppWjBvelhFd2F5MjYzbmNBZ29RczBRaHhsQkFGSTdCcWNjR3JC?=
 =?utf-8?B?QjhlSkVDNmh2bE9HdWVRSmh2cnIwWkdtbVUyTEN0YmQvNVlaUnk0bWFDWU92?=
 =?utf-8?B?blQvejgyWTEwYVdUa0Q4aTVaTDk1MGxXek03ei8zWFJnZkVkYzRrVmx2SHUx?=
 =?utf-8?B?cDJzQW4veU9IbE4rMWNiYytYYmVkOXlNUFNLMFdCajQzZTZvcG1UQWJSSjNF?=
 =?utf-8?B?L2hrcmo5UVN5MHoyZG02dHpKNk10Snl2QTlnT1JOK01qbWZYWExYSkUwekRH?=
 =?utf-8?B?bzZ1ZGE0b2JzOXo1SlREcU9tQ0hYSGx0R1psb29ZejBZMTFNRUsvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0E6755A7A7A9C45BE83FE6AA1CEE1C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TfXtfpSI4lyxeV2PQWyOOCWC4KVDY3YRHbRT7jS6n+x8x7OYMyJjrNcQIIiAvatcqkxK4wqqJsqOFfR71CWj+SLWMdc42zo2BkWUeSPZFm6ZC6KNhpB5DJ9cE+vGvaC/hM7CDyaObsKxswyrXP8sqgGXHU6jPn/RWOfrGG3BsHCwUd9ed2z9Q/LKSbQc32Hr3ZQq/fsfho6+tbg5TYhTG0LqUwmedeokQTXOwmLIu8ZhtmooCyTFADd/jbsrYww9wlbu4nBuk1/YQdIAdyfi/4bz3W4Uvf+Fn3dIdvWhc6ElyucYdNCY5YUtIGOuwYStoaW2De4/vYqjSBdNev8G7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7489.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a412217-507b-435a-59fe-08de7a654f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 03:14:27.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frtPNkJoRfUF2mjIThQuKnqUva60fAZ6gPwgDCWpWwT4BTLn9+3fSiozctD8DYdXe8/042Oc1lafuUdUnZZ9Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7A2B820A766
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.94 / 15.00];
	SORTED_RECIPS(3.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43636-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rui.zhang@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_DNSFAIL(0.00)[intel.com : query timed out];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDExOjI0ICswODAwLCBaaGFuZyBSdWkgd3JvdGU6DQo+IE9u
IG1vZGVybiBJbnRlbCBwbGF0Zm9ybXMsIHRoZSBpbnRlbF9wc3RhdGUgZHJpdmVyIGlzIGNvbW1v
bmx5IHVzZWQNCj4gYW5kDQo+IGl0IHByb3ZpZGVzIHR1cmJvIGJvb3N0IGNvbnRyb2wgdmlhDQo+
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2ludGVsX3BzdGF0ZS9ub190dXJiby4NCj4gDQo+IEhv
d2V2ZXIsIGNwdXBvd2VyIGRvZXNuJ3QgaGFuZGxlIHRoaXMuIGl0DQo+IDEuIHNob3dzIHR1cmJv
IGJvb3N0IGFzICJhY3RpdmUiIGJsaW5kbHkgZm9yIEludGVsIHBsYXRmb3Jtcw0KPiAyLiBjb250
cm9scyB0dXJibyBib29zdCBmdW5jdGlvbmFsaXR5IHZpYSB0aGUgZ2VuZXJpYw0KPiDCoMKgIC9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvYm9vc3Qgc3lzZnMgaW50ZXJmYWNlIG9ubHku
DQo+IA0KPiBFbmhhbmNlIHRoZSBjcHVwb3dlciB0b29sIHRvIGVuc3VyZSB0aGUgIi0tYm9vc3Qi
IGNvbW1hbmQgd29ya3MNCj4gc2VhbWxlc3NseSBvbiBJbnRlbCBwbGF0Zm9ybXMgd2l0aCBpbnRl
bF9wc3RhdGUgZHJpdmVyIHJ1bm5pbmcuDQo+IA0KSGksIFNodWFoLA0KDQpjYW4geW91IHBsZWFz
ZSBraW5kbHkgY2hlY2sgaWYgdGhpcyBpcyBhIHZhbGlkIGVuaGFuY2VtZW50Pw0KDQp0aGFua3Ms
DQpydWkNCg0KPiBXaXRob3V0IHRoaXMgcGF0Y2gsDQo+IMKgwqAgJCBlY2hvIDEgfCBzdWRvIHRl
ZSAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9pbnRlbF9wc3RhdGUvbm9fdHVyYm8NCj4gwqDCoCAx
DQo+IMKgwqAgJCBzdWRvIGNwdXBvd2VyIGZyZXF1ZW5jeS1pbmZvIC0tYm9vc3QNCj4gwqDCoCBh
bmFseXppbmcgQ1BVIDIxOg0KPiDCoMKgwqDCoCBib29zdCBzdGF0ZSBzdXBwb3J0Og0KPiDCoMKg
wqDCoMKgwqAgU3VwcG9ydGVkOiB5ZXMNCj4gwqDCoMKgwqDCoMKgIEFjdGl2ZTogeWVzDQo+IMKg
wqAgJCBzdWRvIGNwdXBvd2VyIHNldCAtLWJvb3N0IDANCj4gwqDCoCBFcnJvciBzZXR0aW5nIHR1
cmJvLWJvb3N0DQo+IMKgwqAgJCBzdWRvIGNwdXBvd2VyIHNldCAtLWJvb3N0IDENCj4gwqDCoCBF
cnJvciBzZXR0aW5nIHR1cmJvLWJvb3N0DQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2gsDQo+IMKgwqAg
JCBjYXQgL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50ZWxfcHN0YXRlL25vX3R1cmJvDQo+IMKg
wqAgMA0KPiDCoMKgICQgc3VkbyBjcHVwb3dlciBzZXQgLS1ib29zdCAwDQo+IMKgwqAgJCBzdWRv
IGNwdXBvd2VyIGZyZXF1ZW5jeS1pbmZvIC0tYm9vc3QNCj4gwqDCoCBhbmFseXppbmcgQ1BVIDIx
Og0KPiDCoMKgwqDCoCBib29zdCBzdGF0ZSBzdXBwb3J0Og0KPiDCoMKgwqDCoMKgwqAgU3VwcG9y
dGVkOiB5ZXMNCj4gwqDCoMKgwqDCoMKgIEFjdGl2ZTogbm8NCj4gwqDCoCAkIGNhdCAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9pbnRlbF9wc3RhdGUvbm9fdHVyYm8NCj4gwqDCoCAxDQo+IMKgwqAg
JCBzdWRvIGNwdXBvd2VyIHNldCAtLWJvb3N0IDENCj4gwqDCoCAkIHN1ZG8gY3B1cG93ZXIgZnJl
cXVlbmN5LWluZm8gLS1ib29zdA0KPiDCoMKgIGFuYWx5emluZyBDUFUgMjg6DQo+IMKgwqDCoMKg
IGJvb3N0IHN0YXRlIHN1cHBvcnQ6DQo+IMKgwqDCoMKgwqDCoCBTdXBwb3J0ZWQ6IHllcw0KPiDC
oMKgwqDCoMKgwqAgQWN0aXZlOiB5ZXMNCj4gwqDCoCAkIGNhdCAvc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9pbnRlbF9wc3RhdGUvbm9fdHVyYm8NCj4gwqDCoCAwDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoHRvb2xzL3Bvd2Vy
L2NwdXBvd2VyL3V0aWxzL2NwdXBvd2VyLXNldC5jwqDCoMKgIHzCoCA2ICsrLQ0KPiDCoHRvb2xz
L3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvaGVscGVycy5oIHzCoCA1ICsrLQ0KPiDCoHRv
b2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvbWlzYy5jwqDCoMKgIHwgNDENCj4gKysr
KysrKysrKysrKysrKysrKy0NCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIv
dXRpbHMvY3B1cG93ZXItc2V0LmMNCj4gYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVw
b3dlci1zZXQuYw0KPiBpbmRleCBjMjExN2U1NjUwZGQuLjU1MGE5NDJlNzJjZSAxMDA2NDQNCj4g
LS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1cG93ZXItc2V0LmMNCj4gKysrIGIv
dG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1cG93ZXItc2V0LmMNCj4gQEAgLTEyNCw3ICsx
MjQsMTEgQEAgaW50IGNtZF9zZXQoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiDCoAl9DQo+IMKg
DQo+IMKgCWlmIChwYXJhbXMudHVyYm9fYm9vc3QpIHsNCj4gLQkJcmV0ID0gY3B1cG93ZXJfc2V0
X3R1cmJvX2Jvb3N0KHR1cmJvX2Jvb3N0KTsNCj4gKwkJaWYgKGNwdXBvd2VyX2NwdV9pbmZvLnZl
bmRvciA9PSBYODZfVkVORE9SX0lOVEVMKQ0KPiArCQkJcmV0ID0NCj4gY3B1cG93ZXJfc2V0X2lu
dGVsX3R1cmJvX2Jvb3N0KHR1cmJvX2Jvb3N0KTsNCj4gKwkJZWxzZQ0KPiArCQkJcmV0ID0NCj4g
Y3B1cG93ZXJfc2V0X2dlbmVyaWNfdHVyYm9fYm9vc3QodHVyYm9fYm9vc3QpOw0KPiArDQo+IMKg
CQlpZiAocmV0KQ0KPiDCoAkJCWZwcmludGYoc3RkZXJyLCAiRXJyb3Igc2V0dGluZyB0dXJiby0N
Cj4gYm9vc3RcbiIpOw0KPiDCoAl9DQo+IGRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dl
ci91dGlscy9oZWxwZXJzL2hlbHBlcnMuaA0KPiBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxz
L2hlbHBlcnMvaGVscGVycy5oDQo+IGluZGV4IDgyZWE2MmJkZjVhMi4uYTNhZDgwYjljMmMyIDEw
MDY0NA0KPiAtLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJzL2hlbHBlcnMu
aA0KPiArKysgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJzL2hlbHBlcnMuaA0K
PiBAQCAtMTA0LDcgKzEwNCw3IEBAIGV4dGVybiBzdHJ1Y3QgY3B1cG93ZXJfY3B1X2luZm8NCj4g
Y3B1cG93ZXJfY3B1X2luZm87DQo+IMKgLyogY3B1aWQgYW5kIGNwdWluZm8gaGVscGVyc8KgICoq
KioqKioqKioqKioqKioqKioqKioqKioqLw0KPiDCoA0KPiDCoGludCBjcHVmcmVxX2hhc19nZW5l
cmljX2Jvb3N0X3N1cHBvcnQoYm9vbCAqYWN0aXZlKTsNCj4gLWludCBjcHVwb3dlcl9zZXRfdHVy
Ym9fYm9vc3QoaW50IHR1cmJvX2Jvb3N0KTsNCj4gK2ludCBjcHVwb3dlcl9zZXRfZ2VuZXJpY190
dXJib19ib29zdChpbnQgdHVyYm9fYm9vc3QpOw0KPiDCoA0KPiDCoC8qIFg4NiBPTkxZICoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovDQo+IMKgI2lmIGRlZmluZWQoX19p
Mzg2X18pIHx8IGRlZmluZWQoX194ODZfNjRfXykNCj4gQEAgLTE0Myw2ICsxNDMsNyBAQCBleHRl
cm4gaW50IGRlY29kZV9wc3RhdGVzKHVuc2lnbmVkIGludCBjcHUsIGludA0KPiBib29zdF9zdGF0
ZXMsDQo+IMKgDQo+IMKgaW50IGNwdWZyZXFfaGFzX3g4Nl9ib29zdF9zdXBwb3J0KHVuc2lnbmVk
IGludCBjcHUsIGludCAqc3VwcG9ydCwNCj4gwqAJCQkJwqAgaW50ICphY3RpdmUsIGludCAqc3Rh
dGVzKTsNCj4gK2ludCBjcHVwb3dlcl9zZXRfaW50ZWxfdHVyYm9fYm9vc3QoaW50IHR1cmJvX2Jv
b3N0KTsNCj4gwqANCj4gwqAvKiBBTUQgUC1TdGF0ZSBzdHVmZiAqKioqKioqKioqKioqKioqKioq
KioqKioqKi8NCj4gwqBib29sIGNwdXBvd2VyX2FtZF9wc3RhdGVfZW5hYmxlZCh2b2lkKTsNCj4g
QEAgLTE4OSw2ICsxOTAsOCBAQCBzdGF0aWMgaW5saW5lIGludA0KPiBjcHVwb3dlcl9zZXRfYW1k
X3BzdGF0ZV9tb2RlKGNoYXIgKm1vZGUpDQo+IMKgc3RhdGljIGlubGluZSBpbnQgY3B1ZnJlcV9o
YXNfeDg2X2Jvb3N0X3N1cHBvcnQodW5zaWduZWQgaW50IGNwdSwNCj4gaW50ICpzdXBwb3J0LA0K
PiDCoAkJCQkJCWludCAqYWN0aXZlLCBpbnQNCj4gKnN0YXRlcykNCj4gwqB7IHJldHVybiAtMTsg
fQ0KPiArc3RhdGljIGlubGluZSBpbnQgY3B1cG93ZXJfc2V0X2ludGVsX3R1cmJvX2Jvb3N0KGlu
dCB0dXJib19ib29zdCkNCj4gK3sgcmV0dXJuIC0xOyB9DQo+IMKgDQo+IMKgc3RhdGljIGlubGlu
ZSBib29sIGNwdXBvd2VyX2FtZF9wc3RhdGVfZW5hYmxlZCh2b2lkKQ0KPiDCoHsgcmV0dXJuIGZh
bHNlOyB9DQo+IGRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJz
L21pc2MuYw0KPiBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvbWlzYy5jDQo+
IGluZGV4IDE2NmRjMWU0NzBlYS4uZWViZmM3OWE0ODg5IDEwMDY0NA0KPiAtLS0gYS90b29scy9w
b3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJzL21pc2MuYw0KPiArKysgYi90b29scy9wb3dlci9j
cHVwb3dlci91dGlscy9oZWxwZXJzL21pc2MuYw0KPiBAQCAtMTksNiArMTksOSBAQCBpbnQgY3B1
ZnJlcV9oYXNfeDg2X2Jvb3N0X3N1cHBvcnQodW5zaWduZWQgaW50IGNwdSwNCj4gaW50ICpzdXBw
b3J0LCBpbnQgKmFjdGl2ZSwNCj4gwqB7DQo+IMKgCWludCByZXQ7DQo+IMKgCXVuc2lnbmVkIGxv
bmcgbG9uZyB2YWw7DQo+ICsJY2hhciBsaW5lYnVmW01BWF9MSU5FX0xFTl07DQo+ICsJY2hhciBw
YXRoW1NZU0ZTX1BBVEhfTUFYXTsNCj4gKwljaGFyICplbmRwOw0KPiDCoA0KPiDCoAkqc3VwcG9y
dCA9ICphY3RpdmUgPSAqc3RhdGVzID0gMDsNCj4gwqANCj4gQEAgLTQyLDggKzQ1LDQyIEBAIGlu
dCBjcHVmcmVxX2hhc194ODZfYm9vc3Rfc3VwcG9ydCh1bnNpZ25lZCBpbnQNCj4gY3B1LCBpbnQg
KnN1cHBvcnQsIGludCAqYWN0aXZlLA0KPiDCoAkJfQ0KPiDCoAl9IGVsc2UgaWYgKGNwdXBvd2Vy
X2NwdV9pbmZvLmNhcHMgJiBDUFVQT1dFUl9DQVBfQU1EX1BTVEFURSkNCj4gew0KPiDCoAkJYW1k
X3BzdGF0ZV9ib29zdF9pbml0KGNwdSwgc3VwcG9ydCwgYWN0aXZlKTsNCj4gLQl9IGVsc2UgaWYg
KGNwdXBvd2VyX2NwdV9pbmZvLmNhcHMgJiBDUFVQT1dFUl9DQVBfSU5URUxfSURBKQ0KPiArCX0g
ZWxzZSBpZiAoY3B1cG93ZXJfY3B1X2luZm8uY2FwcyAmIENQVVBPV0VSX0NBUF9JTlRFTF9JREEp
DQo+IHsNCj4gwqAJCSpzdXBwb3J0ID0gKmFjdGl2ZSA9IDE7DQo+ICsNCj4gKwkJc25wcmludGYo
cGF0aCwgc2l6ZW9mKHBhdGgpLCBQQVRIX1RPX0NQVQ0KPiAiaW50ZWxfcHN0YXRlL25vX3R1cmJv
Iik7DQo+ICsNCj4gKwkJaWYgKCFpc192YWxpZF9wYXRoKHBhdGgpKQ0KPiArCQkJcmV0dXJuIDA7
DQo+ICsNCj4gKwkJaWYgKGNwdXBvd2VyX3JlYWRfc3lzZnMocGF0aCwgbGluZWJ1ZiwgTUFYX0xJ
TkVfTEVOKQ0KPiA9PSAwKQ0KPiArCQkJcmV0dXJuIC0xOw0KPiArDQo+ICsJCXZhbCA9IHN0cnRv
bChsaW5lYnVmLCAmZW5kcCwgMCk7DQo+ICsJCWlmIChlbmRwID09IGxpbmVidWYgfHwgZXJybm8g
PT0gRVJBTkdFKQ0KPiArCQkJcmV0dXJuIC0xOw0KPiArDQo+ICsJCSphY3RpdmUgPSAhdmFsOw0K
PiArCX0NCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAraW50IGNwdXBvd2VyX3NldF9pbnRl
bF90dXJib19ib29zdChpbnQgdHVyYm9fYm9vc3QpDQo+ICt7DQo+ICsJY2hhciBwYXRoW1NZU0ZT
X1BBVEhfTUFYXTsNCj4gKwljaGFyIGxpbmVidWZbMl0gPSB7fTsNCj4gKw0KPiArCXNucHJpbnRm
KHBhdGgsIHNpemVvZihwYXRoKSwgUEFUSF9UT19DUFUNCj4gImludGVsX3BzdGF0ZS9ub190dXJi
byIpOw0KPiArDQo+ICsJLyogRmFsbGJhY2sgdG8gZ2VuZXJpYyBzb2x1dGlvbiB3aGVuIGludGVs
X3BzdGF0ZSBkcml2ZXIgbm90DQo+IHJ1bm5pbmcgKi8NCj4gKwlpZiAoIWlzX3ZhbGlkX3BhdGgo
cGF0aCkpDQo+ICsJCXJldHVybg0KPiBjcHVwb3dlcl9zZXRfZ2VuZXJpY190dXJib19ib29zdCh0
dXJib19ib29zdCk7DQo+ICsNCj4gKwlzbnByaW50ZihsaW5lYnVmLCBzaXplb2YobGluZWJ1Ziks
ICIlZCIsICF0dXJib19ib29zdCk7DQo+ICsNCj4gKwlpZiAoY3B1cG93ZXJfd3JpdGVfc3lzZnMo
cGF0aCwgbGluZWJ1ZiwgMikgPD0gMCkNCj4gKwkJcmV0dXJuIC0xOw0KPiArDQo+IMKgCXJldHVy
biAwOw0KPiDCoH0NCj4gwqANCj4gQEAgLTI3NCw3ICszMTEsNyBAQCB2b2lkIHByaW50X3NwZWVk
KHVuc2lnbmVkIGxvbmcgc3BlZWQsIGludA0KPiBub19yb3VuZGluZykNCj4gwqAJfQ0KPiDCoH0N
Cj4gwqANCj4gLWludCBjcHVwb3dlcl9zZXRfdHVyYm9fYm9vc3QoaW50IHR1cmJvX2Jvb3N0KQ0K
PiAraW50IGNwdXBvd2VyX3NldF9nZW5lcmljX3R1cmJvX2Jvb3N0KGludCB0dXJib19ib29zdCkN
Cj4gwqB7DQo+IMKgCWNoYXIgcGF0aFtTWVNGU19QQVRIX01BWF07DQo+IMKgCWNoYXIgbGluZWJ1
ZlsyXSA9IHt9Ow0KDQo=

