Return-Path: <linux-pm+bounces-12686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF45B95A7AC
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 00:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D57C1F229E3
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 22:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37C416DED2;
	Wed, 21 Aug 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fu8McHXS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1516EC1A
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278601; cv=fail; b=quWhrJHk+aDLnZ5iyPvOYXuGWtGC8HIR1OMkRYxRTvPPmgNoHy8KOBwe+ztock+kiaISsob3556EDTu26XAjTHRiLBURFKgYJDLNpbViPiYz/gbWrXQWdcxs4VZo3sA/D2IwAN5lg30DwZuyg0K1GNUgB4pO5VhlpCg1xaZLJL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278601; c=relaxed/simple;
	bh=yd/GilO8YlBh4qb7Bvj7lcd2U2V7UYBvecSYNy8wPqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aglPuQWyODVB7xsJoBrpSs/L2K2M6GAjtl4lOC+1i77F9iQd3G/sOhB1SEesUA48FEVAYi0SISNwkbU3pw9pFFQAQCsxhZnYtvJ/aTiKnmptKBzPx1n+gmdwLjDpBMOiIqLveSmjkLkRhSc97eyGMHKMPd+1+IrX7Eo1lxjDXNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fu8McHXS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724278599; x=1755814599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yd/GilO8YlBh4qb7Bvj7lcd2U2V7UYBvecSYNy8wPqg=;
  b=fu8McHXSffzm/xFplbRK4+x6NMe6M2yfGid8tvRCUTCIOhP9BttiKUKR
   +SXnY848vwp5nbvmtlGkHn3nMv04KUhR473+Vl4f8Zie9desQuwGy2mdt
   6FflzdJhyLCMXOy5qI2AnPH1T0awLVU0mJLnf9j/jUPBDqKnn9CNLDjKZ
   rctKkp5exWqocMBwEtxP08RT/T/281I3Dsmi1mxOJ04T8YbSqZc6PyH7a
   y4QJ+Hv+Cet3xKXWxj3VaSZkipoGD2kgi/hnfW0/N5EESgZ2mqng4Dicn
   38g45cQ3Q1qYrDeb+AEpp+Orzus7K5rDPB5sr+t500KdIFxCh8q2uWaMs
   w==;
X-CSE-ConnectionGUID: 2wJUabdZSriC8mqsBoefCA==
X-CSE-MsgGUID: 8g7oKLUcQvCrba/e3bsg+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33819488"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="33819488"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 15:16:39 -0700
X-CSE-ConnectionGUID: GoIgeFEGSpyx/1zcE22Jqg==
X-CSE-MsgGUID: QzN9KGOHQNOmG2Ipx/yIog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="91967727"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 15:16:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 15:16:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 15:16:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 15:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxU0I0YW7k+HMc4whYtgyirKLbuHzYU9zhd8pdZaOZmg0uhDPb2GoeJ0faTccfsBsnpv2PH14vg1QttMH6at4aD90YuR2pssztBhiHGp89+Z4SfmOWBDhaIzyTFA45v2x7f1EOWuklXgVFNtUFfzG04KiTcZ2++/UJteOY23Fi9SbRI55USgAEZ4u6u6sU2zLV3viO9++lqIsoJA3UNxm/hf96xKdrTDyv1rhni4+ZKlMFIoYO7wAtP8dwr3+17V8iUhE2PiAO/49d2ysi1nnWbvEnGsE6b4nzIVI+O0RNwnqsQlypjx5OkrsO3vVW9ap3Q3Cy577PbZJu63vAXnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yd/GilO8YlBh4qb7Bvj7lcd2U2V7UYBvecSYNy8wPqg=;
 b=Q9S11wJwrYplzFEjs5fYTSpGnj2QRovBlirbJNlMN+JGBKK1pSQvE3n7Pv9OigPDRTisldSbh/0/O4qVQrBmpbrFejmUyNzFSwN5z2zRlklL6u6AfggXyYZxVI+xWBhqPdky5zOkZz4+DAIKOQ9RFdCGyXYdH732M4fPw+QdEwzBUqKe88Fb9KPFVv73pylZIVbSJzhCkqAbVZ7M7STCeSie9GvIQBa9KfLmYLQRBKwJ+Ywy8OJCwxllaqIA4kpMxF/TVTuAwva46NIji2Qv90KxqAnUQ25bWeUE74PakRgoPpOA3fcH/lrhjdB3fnceU7oQLJBYhr63tJYXYtXazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 22:16:30 +0000
Received: from SJ0PR11MB5600.namprd11.prod.outlook.com
 ([fe80::3bb1:2d28:d07:bcc3]) by SJ0PR11MB5600.namprd11.prod.outlook.com
 ([fe80::3bb1:2d28:d07:bcc3%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 22:16:27 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "quic_manafm@quicinc.com"
	<quic_manafm@quicinc.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
Thread-Topic: [PATCH v2 0/7] Add thermal thresholds support
Thread-Index: AQHa9AVXUG9+if23L0i94LJXXQBhg7IyJwIAgAAgegA=
Date: Wed, 21 Aug 2024 22:16:27 +0000
Message-ID: <0494c22b09f9143d2a22e1f0ae2ae79b7d61ab63.camel@intel.com>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
	 <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
	 <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5600:EE_|MN2PR11MB4518:EE_
x-ms-office365-filtering-correlation-id: 41b71429-4a36-473b-2fdc-08dcc22ee6e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFhXVGxHaGFJR3BSVHNtc3BQcTkzYllJRkZKRHRhYkZ3bHJKTnoveXVXcWtD?=
 =?utf-8?B?L01FczI3bGxabGpTTTQ5Y3hwM3psazNSM2liMFRSa3dTTVR3S21paklqc2JZ?=
 =?utf-8?B?UGlHVDFvVEYvT2FGS2NaSzZaNWd3UXBsSWpPdTNtR2g0QVZvU3hrOVJZaDE3?=
 =?utf-8?B?K0tuRklmMCtQZldSTm5mTVZ2V0tkcXZ0RTRhSGlpV2lpQW05UVpoNG55OHUx?=
 =?utf-8?B?a2MwcW5nS3pMQ0I3SFhBYUdESEFVdjR2M0R0aHRvMXdDMWZac2t4bmRJTEtm?=
 =?utf-8?B?SS9QZ3didnR3Z1VIVDhacDJTeWsveXUzVEpGSVhUV1VYcHdqdDMyWTZ5SXZ1?=
 =?utf-8?B?bFV2d3c2eVhMTW53dmVmUGlXOVlDQlN5ZXpaWDh0Mko1QWJPRFhld0FqZUZ5?=
 =?utf-8?B?anl2UGZyK3NyMU12amZ6eDhZMGk4ajl3cVdYZlo1UHNPbkJLNTM5aW84Y3pj?=
 =?utf-8?B?Mk9rODgrblZTVFkrRFl3N3ZlNW96RitXaWwxQWt1RDg5NWUwWGpmYTBoamJz?=
 =?utf-8?B?MnJIQmFsbWpHRnhkVWhOOW1MaXRDanNMZ2VqdG9vTkl6UHRzekxLeEVQeXBr?=
 =?utf-8?B?OTRGRTlqVUdJQ21iVTZNTWhNYTdPSUl0S0w3Nk9Rd1JuSk4ybTcydjVjTTZ2?=
 =?utf-8?B?VVZtYzBhUGhnc0tDVlplQmhCOFlOTEdHM3VhdVNMR3prb0E0OHlxQzJsNkNS?=
 =?utf-8?B?VEVVTFd3NWpGbmsrRGN4YlUyV1NWZXhaWnA0cGZkdGduRUdMbmpiWDRvZ1RM?=
 =?utf-8?B?ZjhyWHdkUHRzOU1JS0FHajQwMzk1WldwRzZ5d2lmdmxYTjRrdFZFR2xadnZk?=
 =?utf-8?B?M1I4WDhHRFh2c2FJOVJnTitFN2llOFptazJ4NmRYUjN3ei9wQWJtbks2MFh4?=
 =?utf-8?B?Z3hNYXJUeS9nOEtkZmJRODAyS3VVY0lHYjZKUlVwK2lmWE5Pb0JvTnBLakJU?=
 =?utf-8?B?andkdGd5bExNTmErajhqS1VGM2dYMzRBTnBCU2hIaGdxU1dUQ2VGUk9QV1Rl?=
 =?utf-8?B?REpwZHgwMVpBZVVEdTl6b0ZWN2hWMXVzSUpaR0g5K25zMWRlMVdxRkRwT2Zt?=
 =?utf-8?B?Ynhjb3lEMUVCRTRNMXpMK1IwV1A5bmRabWgxMFBkNUlZaXRrdDdMUm1heTVo?=
 =?utf-8?B?aUMzeEZKYTA1WGU3WlZjUXZZZi8xdG94V25kT0RiK0dEK2NMN0hJVlNvRStt?=
 =?utf-8?B?SHNFUGxacjltZEpVN0N5eFRpUlZKTkNVb1FEcXFGUHBubEJmSmVhMTUvMkdT?=
 =?utf-8?B?a1NKM2hRNE1UajgvTzd2TzRXS1NDMlVhTFl6U3BCVnVIaGZFNVBBNXcvazNl?=
 =?utf-8?B?ZTE2aEl1QmVXUVZCUXN1UTV4YTFDMUYwcGVrMERsaU1vK1d5TkVHUUJGT05h?=
 =?utf-8?B?Y3hIb3FxOWJ5R3pPZUEzRWZTekE1NEpXd3F4TGhxR1ZaTzkxY1ZyUklZWlIz?=
 =?utf-8?B?L1BLbTF0d2Q1eXJjRXRPY0FCcVNjc3REbVppSWNYeVZiL1hSTkNiaDFGeGRM?=
 =?utf-8?B?WXRmVDNLSmt0b053WGRhWUhLa0ZNaUdYUXA3NVU1OUs2WjlqTjl0bi9FU0s0?=
 =?utf-8?B?eVYveFBsbE93a3hkYSttdWJEQVV5cThuVjhObzJxSllOOUZ1K3VlSExjS3Y5?=
 =?utf-8?B?MFZQdmtXNzBUakd1U2xvcllOZlg0YkRwSXVQYXdWVjdxVHA4RlkyQTM5bXhQ?=
 =?utf-8?B?TlJrN0cvQUZHTzRHWWRGNFoySU5zM2RTRll1S25udTYyY3IvK2pORHNrQVJE?=
 =?utf-8?B?QWtuN21iblExdEV1V2tZMHJWYU9vOGdOaDF4Qno4RDdHclBkT0M4YnJ6ejJI?=
 =?utf-8?B?cHIxdk1CSUFpZkJLUEx6MlBIV3l2RlFVYzNZRzVScGlKVWRTd2NjR0RrUURN?=
 =?utf-8?B?QVlxTW5ZQUZVWi9zYmk2U1pQV3RLd0diU1d3a1ZtYVkvMXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5600.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE5DOVlLK1lSU1FHUjBqWnM3SHlrMEZtYmw5YUg5YVUya3hWR1NHL0JlUGpq?=
 =?utf-8?B?cmRXNmlwcFNoNzR4ZDQyWUJiMmdjTUNQWHhqV0lhRitDZEloM3V6UkZoOWVa?=
 =?utf-8?B?WlZnZHdQbHNuRjYyS1g5V2c3dG1xcVNpTCtpbXlaQ01YWGtYRmRnbWd5YkRL?=
 =?utf-8?B?R1BpblNEY1dmM3lzQkRYT3A3RGZtZDE1UnZsaXpod2pSUzJwNVRUM0JCTmFh?=
 =?utf-8?B?MGI0Y0ttNm1ZbDRxRk0rWWhQeXpoNWQ0OVdZWU5VNE5XZk1xOGp6NzRpWlBv?=
 =?utf-8?B?ZmpKY3RZS3RiTzZSb2tCRjg1UlJGZnBhYUd5cUR1YThNVVV0VmZTMEFZNjcz?=
 =?utf-8?B?eUc0NmhRL1BacGtXT05wTjgveVNrMmRHK05mcnlQK2U1QTNueWVUQ0NObWZl?=
 =?utf-8?B?UUZjMW5kNnN6U21TbzlPTERtcnVZRSszeHJhT1Njb0xsYU9BRjR4R0VuUlAx?=
 =?utf-8?B?UDRNVjhaa25NNEs0MHhjUE9HUTJSNFV6T2N4bUJCa05Oak1nSUhwcWxQRmo1?=
 =?utf-8?B?MXJsNEtsOE5RckVBSC9lSTh1aXB0S0J6VjlReldEUnVpVG5UUlRRWHdvTGgr?=
 =?utf-8?B?NVlXQ0dVZHp3NFFtMjZTekh0dTFQNnFqc0pMOGZ6M0NHN2x2MzUvNUpQeXpx?=
 =?utf-8?B?MFRpZ09wS2p6cUJhZWgzZ04wVk8raUVOUDVnL0RXcmRzYU8wN0VaL0U3ajRP?=
 =?utf-8?B?V1VUZDNOQVRXbnRvUWV2SGI2ak13R0pLSXNFS05sV1VwK3VaVDBlcEFlRkJ1?=
 =?utf-8?B?cTlqVzMyR0ErZUxwN3FTOTZzamJ1NnlsVDJvazBocHNzR0FqUjZwWmpIdmNW?=
 =?utf-8?B?WVNyUHh3bmFHMDFySkxXWkJ2eXZiSHFjL0N6cm5KZ0s1TWpDbWdPM2FUQTFs?=
 =?utf-8?B?NTZCVGpwdzg3aGdDdGUyZVpEcXNQZjVGRHVHdzdvLzRyc25YdkxabG5ISk1M?=
 =?utf-8?B?bkI0a1lSb0tvbCtBWElMTzF3MFFxaFYzV1NJYW1sdGRaVTUweUh4MnhhYjhC?=
 =?utf-8?B?akhNbVlQWUhTR3VueXpLcFBEUTdnbkZSck1YVmhDVnBFUXBkV1REeUpCaTNw?=
 =?utf-8?B?MmNwSjJqaTVKNE82QVhYRFZCRUlrRjIxNC9vT0Y1T3Z6Ym9kWHp3VmZ1SHRt?=
 =?utf-8?B?SzZrL3RYUGtWVXRwbXdDM1ZtaWs0c0xVaHNRSDFtZVlrL21xSlZFcEN3OHVJ?=
 =?utf-8?B?MlZpb2VEVDQyVkVIY3NYREdIQUpUZEJhb0NzajNhZ0Z2cHVBK1VIb2FLUVRM?=
 =?utf-8?B?a2NaUVEvYXp2aHUxMEVjdVFra3QyNldiS3paSkgvdnk0djQwdExOUUZwNXFy?=
 =?utf-8?B?NjdXL1NEU1Zhdk45dmp4L3ZVRTcxZHptVm04Sjc3aVIwbU9BRi9qMjBCc3d3?=
 =?utf-8?B?aFVKSG9HVWlkeFB5QWxJU3NnNDc5dk1oTmVSTmlWN3VZazcyMG1GTWhEOXlO?=
 =?utf-8?B?WDVNOURMamp6SnBwVyttRU8xZ1ZNZHBHb2lUOUVHSnpZUGR6VnBWUkFWRHV1?=
 =?utf-8?B?bUVIaWoyMU9QbzY3dnFKR3Y0T1M2VDZoYzhHUSt6LzRYdXhHRXd2OTRFR1Uy?=
 =?utf-8?B?S01pWDVRU1p4NlhNaC9KbjhqdUZMOWxjdnBTQXhJQXpocWNwNDVYR0RmWFdI?=
 =?utf-8?B?N0ROeDJLYk1DcmZHM05OZVJMYmo3OEdrMUwwZW50a2ZLNzhUYStsbmVrVG5Q?=
 =?utf-8?B?b3QyWWhGaEp5dmY5a2NidmZFMjBxRnhrbG85cWlNN1IyMGtGOVdMd3hsMVBh?=
 =?utf-8?B?T1RnSTZKTWJaSG9RYlNsemJ5bXJrV2xEUTg4RndQc0JxS1pCL2o2eFlWYXQ4?=
 =?utf-8?B?ODN2MG42U0JYbWcrb3pISUl1WkZZZlNxUm0vcktLSkFwYjVnaUt3elhIV2M1?=
 =?utf-8?B?Z2xIcEphZ3FEQ2JwYTJEdTVRdlZvV2pBbDZ3NHAwemtXZlAxVzZEcGNELzdP?=
 =?utf-8?B?c0s5dGpQUkVXNDJnUDF6aEdYY1h6cWxpUTRWWnQ4SVRYNm41NnVLL0c4aFhs?=
 =?utf-8?B?TnJxeG9Pakk4ZmlNRkJXUzBHSUlldGxTeWpmM1dKSGNWb00xTWk5NWUwQVVx?=
 =?utf-8?B?SGlKSnMwdTJuL1Z4RDJnZ0VaRTYxK3RaNk1nM3VjbDVVWTdWeVNhYVc4K3cx?=
 =?utf-8?B?NjY3Sll5YzlDaFo3VDFNN0xsa1VacWVIQ0pycGpnSjNjajhBQ1dCVTRqSDdl?=
 =?utf-8?Q?Jb8KXSS/wiRcZIq/6p3NpGo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13A03BF82EB35143AB42C74B2597B9CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5600.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b71429-4a36-473b-2fdc-08dcc22ee6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 22:16:27.6691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DIgxhzhpYD6jxLU/koN5DPZ7hpjxFcyig1jP/TqwgN9nP72Md0nZT8jxoHCK1dd91/rj5UDOUvz31SlIvwMfpP1T9KMjTyxF/5OaN/XYZCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDIyOjIwICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gSGkgU3Jpbml2YXMsDQo+IA0KPiBPbiBXZWQsIEF1ZyAyMSwgMjAyNCBhdCAxMDowNOKA
r1BNIFBhbmRydXZhZGEsIFNyaW5pdmFzDQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNv
bT4gd3JvdGU6DQo+ID4gDQo+ID4gSGkgRGFuaWVsLA0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyNC0w
OC0xNiBhdCAxMDoxMiArMDIwMCwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+ID4gPiBUaGUgdHJp
cCBwb2ludHMgYXJlIGEgZmlybXdhcmUgZGVzY3JpcHRpb24gb2YgdGhlIHRlbXBlcmF0dXJlDQo+
ID4gPiBsaW1pdHMNCj4gPiA+IG9mIGEgc3BlY2lmaWMgdGhlcm1hbCB6b25lIHdoZXJlIHdlIGFz
c29jaWF0ZSBhbiBhY3Rpb24gd2hpY2ggaXMNCj4gPiA+IGRvbmUNCj4gPiA+IGJ5IHRoZSBrZXJu
ZWwuIFRoZSB0aW1lIHJlc29sdXRpb24gaXMgbG93Lg0KPiA+ID4gDQo+ID4gPiBUaGUgdXNlcnNw
YWNlIGhhcyB0byBkZWFsIHdpdGggYSBtb3JlIGNvbXBsZXggdGhlcm1hbCBtYW5hZ2VtZW50DQo+
ID4gPiBiYXNlZA0KPiA+ID4gb24gaGV1cmlzdGljcyBmcm9tIGRpZmZlcmVudCBpbmZvcm1hdGlv
biBjb21pbmcgZnJvbSBkaWZmZXJlbnQNCj4gPiA+IHBsYWNlcy4gVGhlIGxvZ2ljIGlzIG11Y2gg
bW9yZSBjb21wbGV4IGJ1dCBiYXNlZCBvbiBhIGJpZ2dlciB0aW1lDQo+ID4gPiByZXNvbHV0aW9u
LCB1c3VhbGx5IG9uZSBzZWNvbmQgYmFzZWQuDQo+ID4gPiANCj4gPiA+IFRoZSBwdXJwb3NlIG9m
IHRoZSB1c2Vyc3BhY2UgaXMgdG8gbW9uaXRvciB0aGUgdGVtcGVyYXR1cmVzIGZyb20NCj4gPiA+
IGRpZmZlcmVudCBwbGFjZXMgYW5kIHRha2UgYWN0aW9ucy4gSG93ZXZlciwgaXQgY2FuIG5vdCBi
ZQ0KPiA+ID4gY29uc3RhbnRseQ0KPiA+ID4gcmVhZGluZyB0aGUgdGVtcGVyYXR1cmUgdG8gZGV0
ZWN0IHdoZW4gYSB0ZW1wZXJhdHVyZSB0aHJlc2hvbGQNCj4gPiA+IGhhcw0KPiA+ID4gYmVlbiBy
ZWFjaGVkLiBUaGlzIGlzIGVzcGVjaWFsbHkgYmFkIGZvciBtb2JpbGUgb3IgZW1iZWRkZWQNCj4g
PiA+IHN5c3RlbSBhcw0KPiA+ID4gdGhhdCB3aWxsIGxlYWQgdG8gYW4gdW5hY2NlcHRhYmxlIG51
bWJlciBvZiB3YWtldXAgdG8gY2hlY2sgdGhlDQo+ID4gPiB0ZW1wZXJhdHVyZSB3aXRoIG5vdGhp
bmcgdG8gZG8uDQo+ID4gPiANCj4gPiA+IE9uIHRoZSBvdGhlciBzaWRlLCB0aGUgc2Vuc29ycyBh
cmUgbm93IG1vc3Qgb2YgdGhlIHRpbWUgaW50ZXJydXB0DQo+ID4gPiBkcml2ZW4uIFRoYXQgbWVh
bnMgdGhlIHRoZXJtYWwgZnJhbWV3b3JrIHdpbGwgdXNlIHRoZSB0ZW1wZXJhdHVyZQ0KPiA+ID4g
dHJpcA0KPiA+ID4gcG9pbnRzIHRvIHByb2dyYW0gdGhlIHNlbnNvciB0byB0cmlnZ2VyIGFuIGlu
dGVycnVwdCB3aGVuIGENCj4gPiA+IHRlbXBlcmF0dXJlIGxpbWl0IGlzIGNyb3NzZWQuDQo+ID4g
PiANCj4gPiA+IFVuZm9ydHVuYXRlbHksIHRoZSB1c2Vyc3BhY2UgY2FuIG5vdCBiZW5lZml0IHRo
aXMgZmVhdHVyZSBhbmQNCj4gPiA+IGN1cnJlbnQNCj4gPiA+IHNvbHV0aW9ucyBmb3VuZCBoZXJl
IGFuZCB0aGVyZSwgaW93IG91dC1vZi10cmVlLCBhcmUgdG8gYWRkIGZha2UNCj4gPiA+IHRyaXAN
Cj4gPiA+IHBvaW50cyBpbiB0aGUgZmlybXdhcmUgYW5kIGVuYWJsZSB0aGUgd3JpdGFibGUgdHJp
cCBwb2ludHMuDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgYmFkIGZvciBkaWZmZXJlbnQgcmVhc29u
cywgdGhlIHRyaXAgcG9pbnRzIGFyZSBmb3IgaW4tDQo+ID4gPiBrZXJuZWwNCj4gPiA+IGFjdGlv
bnMsIHRoZSBzZW1hbnRpYyBvZiB0aGVpciB0eXBlcyBpcyB1c2VkIGJ5IHRoZSB0aGVybWFsDQo+
ID4gPiBmcmFtZXdvcmsNCj4gPiA+IGFuZCBieSBhZGRpbmcgdHJpcCBwb2ludHMgaW4gdGhlIGRl
dmljZSB0cmVlIGlzIGEgd2F5IHRvIG92ZXJjb21lDQo+ID4gPiB0aGUNCj4gPiA+IGN1cnJlbnQg
bGltaXRhdGlvbiBidXQgdGFtcGVyaW5nIHdpdGggaG93IHRoZSB0aGVybWFsIGZyYW1ld29yaw0K
PiA+ID4gaXMNCj4gPiA+IHN1cHBvc2VkIHRvIHdvcmsuIFRoZSB3cml0YWJsZSB0cmlwIHBvaW50
cyBpcyBhIHdheSB0byBhZGp1c3QgYQ0KPiA+ID4gdGVtcGVyYXR1cmUgbGltaXQgZ2l2ZW4gYSBz
cGVjaWZpYyBwbGF0Zm9ybSBpZiB0aGUgZmlybXdhcmUgaXMNCj4gPiA+IG5vdA0KPiA+ID4gYWNj
dXJhdGUgZW5vdWdoIGFuZCBUQkggaXQgaXMgbW9yZSBhIGRlYnVnIGZlYXR1cmUgZnJvbSBteSBQ
T1YuDQo+ID4gPiANCj4gPiA+IFRoZSB0aHJlc2hvbGRzIG1lY2hhbmlzbSBpcyBhIHdheSB0byBo
YXZlIHRoZSB1c2Vyc3BhY2UgdG8gdGVsbA0KPiA+ID4gdGhlcm1hbCBmcmFtZXdvcmsgdG8gc2Vu
ZCBhIG5vdGlmaWNhdGlvbiB3aGVuIGEgdGVtcGVyYXR1cmUgbGltaXQNCj4gPiA+IGlzDQo+ID4g
PiBjcm9zc2VkLiBUaGVyZSBpcyBubyBpZCwgbm8gaHlzdGVyZXNpcywganVzdCB0aGUgdGVtcGVy
YXR1cmUgYW5kDQo+ID4gPiB0aGUNCj4gPiA+IGRpcmVjdGlvbiBvZiB0aGUgbGltaXQgY3Jvc3Np
bmcuIFRoYXQgbWVhbnMgd2UgY2FuIGJlIG5vdGlmaWVkDQo+ID4gPiB3aGVuIGENCj4gPiA+IHRo
cmVzaG9sZCBpcyBjcm9zc2VkIHRoZSB3YXkgdXAgb25seSwgb3IgdGhlIHdheSBkb3duIG9ubHkg
b3INCj4gPiA+IGJvdGgNCj4gPiA+IHdheXMuIFRoYXQgYWxsb3dzIHRvIGNyZWF0ZSBoeXN0ZXJl
c2lzIHZhbHVlcyBpZiBpdCBpcyBuZWVkZWQuDQo+ID4gPiANCj4gPiA+IEEgdGhyZXNob2xkIGNh
biBiZSBhZGRlZCwgZGVsZXRlZCBvciBmbHVzaGVkLiBUaGUgbGF0dGVyIG1lYW5zDQo+ID4gPiBh
bGwNCj4gPiA+IHRocmVzaG9sZHMgYmVsb25naW5nIHRvIGEgdGhlcm1hbCB6b25lIHdpbGwgYmUg
ZGVsZXRlZC4NCj4gPiA+IA0KPiA+IA0KPiA+IFNvIHlvdSBhcmUgcHJvcG9zaW5nIHRvIGFkZCB0
aHJlc2hvbGQgdmlhIG5ldGxpbmssIG5vdCBhZGRpbmcgYW55DQo+ID4gbmV3DQo+ID4gc3lzZnMg
YXR0cmlidXRlPyBUaGF0IGlzIG5vdCBjbGVhciBoZXJlLg0KPiA+IA0KPiA+IEkgdGhpbmsgeW91
IGFyZSBhZGRpbmciDQo+ID4gVEhFUk1BTF9HRU5MX0NNRF9USFJFU0hPTERfR0VUDQo+ID4gVEhF
Uk1BTF9HRU5MX0NNRF9USFJFU0hPTERfQUREDQo+ID4gVEhFUk1BTF9HRU5MX0NNRF9USFJFU0hP
TERfREVMRVRFDQo+ID4gVEhFUk1BTF9HRU5MX0NNRF9USFJFU0hPTERfRkxVU0gNCj4gPiANCj4g
PiBXZSBuZWVkIHRvIGRvY3VtZW50IG91ciBuZXRsaW5rIG1lc3NhZ2VzIGluY2x1ZGluZyBvbGQg
b25lcy4NCj4gPiANCj4gPiBBbHNvIHdlIHNob3VsZCBhZGQgIk1PRElGWSIgYXMgd2UgdGVuZCB0
byBjaGFuZ2UgdGhlbSBxdWl0ZSBvZnRlbi4NCj4gPiANCj4gPiBBbHNvIG5vIGh5c3RlcmVzaXMs
IHRoYXQgaXMgcHJhY3RpY2FsbHkgd2UgY2FuJ3QgdXNlLg0KPiANCj4gVGhlIGRpcmVjdGlvbiB0
aGluZyBpcyBlcXVpdmFsZW50IHRvIGh5c3RlcmVzaXMgdGhvdWdoLg0KPiANCj4gSW5zdGVhZCBv
ZiB1c2luZyBvbmUgdGhyZXNob2xkIHdpdGggYSBnaXZlbiBoeXN0ZXJlc2lzIHZhbHVlLCB1c2Ug
dHdvDQo+IG9mIHRoZW0gd2l0aCBkaWZmZXJlbnQgdGVtcGVyYXR1cmUgdmFsdWVzIGFuZCBkaWZm
ZXJlbnQgZGlyZWN0aW9ucy4NCj4gDQo+ID4gVGVtcGVyYXR1cmUgY2hhbmdlcyBzbyBtdWNoIHRo
YXQgdGhhdCB3aWxsIGZsb29kIHVzZXIgc3BhY2UuIFlvdQ0KPiA+IHdpbGwgZ2V0IDEwMHMgb2YN
Cj4gPiBldmVudHMgb24gQ1BVIHRlbXBlcmF0dXJlIGlmIHlvdSBzZXQgdGVtcGVyYXR1cmUgdGhy
ZXNob2xkIGluIENQVS4NCj4gDQo+IEV2ZW50cyBvbmx5IHRyaWdnZXIgd2hlbiB0aHJlc2hvbGRz
IGFyZSBjcm9zc2VkIGluIGEgc3BlY2lmaWMNCj4gZGlyZWN0aW9uLCBidXQgb3ZlcmFsbCB5b3Ug
aGF2ZSBhIHBvaW50Lg0KDQpUaGlzIGlzIGdvb2QgZW5vdWdoIGZvciBzb21lIHNlbnNvciB3aGlj
aCBjaGFuZ2VzIHNsb3dseSBsaWtlIHNraW4uIEJ1dA0Kc29tZSBzZW5zb3JzIGxpa2UgQ1BVIGFu
ZCBib2FyZCBhcmUgbm90IGxpa2UgdGhhdC4gV2UgcHVibGlzaCBib3RoIHJhdw0KYW5kIGZpbHRl
cmVkIGV2ZW50IGNvdW50IGluIGRlYnVnZnMgZm9yIHg4NiBwYWNrYWdlIHRlbXAuDQpGb3IgZXhh
bXBsZSwgSSBqdXN0IHJhbiBhIHNhbXBsZSBvbiBhIGNsaWVudCBmb3Igb25lIHRocmVzaG9sZC4N
Cg0KVG90YWwgbm90aWZpY2F0aW9uIGZyb20gaGFyZHdhcmU6IDIyNA0KTm90aWZpZWQgdG8gdXNl
ciBzcGFjZTogMTYNCg0KDQoNCj4gDQo+ID4gV2UgaGF2ZSBhIHdob2xlIGZpbHRlcmluZyBpbiBk
cml2ZXIgdG8gYXZvaWQgdGhpcy4NCj4gPiBZb3UgbmVlZCBhIHJhdGUgbGltaXQgaGVyZS4NCj4g
PiANCj4gPiBUaGVyZSBhcmUgbXVsdGlwbGUgdXNlciBwcm9jZXNzZXMgY2FuIGFkZCB0aHJlc2hv
bGQgYW5kIHRoZXJlIGlzIG5vDQo+ID4gb3duZXJzaGlwLiBTbyBvbmUgcHJvY2VzcyBjYW4gY2F1
c2UgdG9vIG11Y2ggbm9pc2UgdG8gb3RoZXJzIGFzIGl0DQo+ID4gaXMNCj4gPiBtdWx0aWNhc3Qu
DQo+ID4gDQo+ID4gV2Ugd29ya2VkIG9uIGEgY2hhbmdlIHRvIGZpbGVyIHRoZXNlIGFzIGRpc2N1
c3NlZCBkdXJpbmcgbGFzdCBMUEMsDQo+ID4gYnV0DQo+ID4gbm90IHBvc3RlZCB5ZXQuIFRoaXMg
d2lsbCByZWFsbHkgbmVlZCB0aGlzIGFzIHRoaXMgd2lsbCBiZSB0b28gbWFueQ0KPiA+IG1lc3Nh
Z2VzLg0KPiANCj4gVW5sZXNzIHRoZXJlIGlzIGEgd2F5IHRvIGxpbWl0IHlvdXIgc3Vic2NyaXB0
aW9uIHRvIGV2ZW50cyByZWdhcmRpbmcNCj4gYQ0KPiBzcGVjaWZpYyB0aGVybWFsIHpvbmUsIGZv
ciBpbnN0YW5jZS4NClRoYXQncyB3aGF0IHRoaXMgY2hhbmdlIGRvZXMuDQoNCj4gDQo+IEFueXdh
eSwgSSBoYXZlIHRvIGFkbWl0IGlnbm9yYW5jZSByZWdhcmRpbmcgdGhlIHVzZXIgc3BhY2UgdXNh
Z2UNCj4gbW9kZWwNCj4gcmVsYXRlZCB0byB0aGlzLsKgIEZvciBleGFtcGxlLCBpcyBpdCBleHBl
Y3RlZCB0aGF0IHRoZXJlIHdpbGwgYmUgb25lDQo+IHVzZXIgc3BhY2UgZW50aXR5IG1hbmFnaW5n
IHRoZSB0aHJlc2hvbGRzIG9yIHRoZXJlIGNhbiBiZSBtYW55Lg0KDQpHb29kIHF1ZXN0aW9uLiBU
aGF0J3Mgd2h5IHdlIGRpZG4ndCBzZW5kIHRoaXMgY2hhbmdlLiBJZiB0aGVyZSBpcyBvbmUNCmFn
ZW50IHRoaXMgaXMgZmluZS4NCg0KQnV0IGluIGVtYmVkZGVkIHNwYWNlLCB0aGVyZSBtYXkgYmUg
bW9yZSB0aGFuIG9uZS4gSGVuY2UgdGhleSBuZWVkZWQNCm5ldGxpbmsgbXVsdGljYXN0IGluc3Rl
YWQgb2YganVzdCBvbmUgY2hhciBkZXZpY2UuDQoNClRoYW5rcywNClNyaW5pdmFzDQo=

