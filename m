Return-Path: <linux-pm+bounces-12524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE31E957EF1
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F5B21123
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14516BE13;
	Tue, 20 Aug 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvBNc+Ir"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7F18E367;
	Tue, 20 Aug 2024 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137528; cv=fail; b=LOTHzU6ui5j/WzBZWeYaWha8+XLveJRK61FXOYIXEyxBuU2C1V0zQN1X/Bj6Z4Fsy9km5piB5+eBNrke98JRNozA+OGeWf4+aKbKF72kMWaplcKIhSsXhPzP1OlFMSSNfllDPeUllJL0CcqAGCDnzOLGg206JJ3FtwY+NPXk6bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137528; c=relaxed/simple;
	bh=+kBO3ev7Uu8fqJL42sA8z9zhWe9LTUOs72Rk0NqVioY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ea7r9APT0kuDYxVjkix+gwGkd5uZxx9RCLzPAXaGNVlztt9y1F7ueraj9aVIxdqG2Zgw0VKQOXqXp2MZpc8N/hRwHACNts2dS0veCIfEP1pX96BQGudS7PKZUMWWQwN/5E1NeJW17XlCA15UbzMGe0GEBu1oafYyktK4DDqC5/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvBNc+Ir; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137527; x=1755673527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+kBO3ev7Uu8fqJL42sA8z9zhWe9LTUOs72Rk0NqVioY=;
  b=SvBNc+IrZpuphyApzMfX2yR7kc7MJ3EvSJ3rBejBece4dpSfieofPfu0
   6VRUrR97n6puYtkYOGkMkwwP2KuU7+gwBexn/63a1TeQd609HPntjHKME
   HJOaoM6Q+y1C/iAGx+wMEOlV86HbmfQKUx9Xbe2NnDoKT2UQ6wy+Omeah
   pamW+8Ff4OERxVEhg7SFdJibmq3fA6z3mqUqYQ59/Nh80fl/uvTGDBweF
   vABQ2m3lSW8zXFyezxV+VUZ1HcAFTHQnGyLHNCwvD5354iYU2or/9rBMQ
   PdmvypiM7Ogk/mwH5WZBimS9rYl2R1KSj8FycLAxlGZs1Pg7ScCa6KLNw
   A==;
X-CSE-ConnectionGUID: W0WO8TCRTJSSlAARLygdLA==
X-CSE-MsgGUID: EFsT03xYSwm3Y74Sf/FJSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33038948"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33038948"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:05:26 -0700
X-CSE-ConnectionGUID: Cjbr2xaUQt6EqqCNYREdsg==
X-CSE-MsgGUID: qr53iTs4RnCNuzh0U00e2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60789601"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:05:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:05:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjLrSYCaT4bRfRr9vwTfRx83us2UuD0Vwa/TcLKvnvOhF9Co/0T1hy9PifKcG8F345zsTHTTctMCaUdXZD0YJwrvYpw9ea+haXH6XDgSeiveWztr8QBSRwkGEkHqRhLsBEC6iflO6tLjxNbqW8+Oks15K1KXpzXLty7Eg2pn7duAjZW55t9BYrrDS6pwTqImHQBXBqwMY1VH3DpeDGyrSmcGYRD4yNZMiC7bqjbFsBtEA4tPodgNtQK2t+KL9gN7xVnNbYC0RuR9ecCF1ByI2RrDu/t4w3qCHwN+QqrnFFOiWkW5RhddAuvixj9ozeo8A4rnd0TKve5zrudTUj6n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kBO3ev7Uu8fqJL42sA8z9zhWe9LTUOs72Rk0NqVioY=;
 b=ULTYAONScDB5lMOBLiMDyRNRSiyT4Hondvx11t6AIy+nVyiQj4eDJ2FZSEcNrRn8mzHZfV3yG8RsJXFAQ1zCySW1ttCkTmEaI+S/Y4nlOKa1JUm/IR7F6zcIHFT02aoD3GkZ5vRZspWIiEQjePLTVrxnXlj3IY3MSbLgb73xa8D5Pe+wiB4P//X1IFCRrLb7KPNulY6IYwePE/zzDjLhvZTnRE2Y17SXevsuA9yMlNr8rtv1brNIC0NTsNbZL0zRM2oKj8KTe9Xzy2UWRKjjU5zWZ7KIqymcSRezxnQFgAiWhBgl9NUT7AVSJGaJYc5F1RjCqS66p3ixKWHdJfssXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:05:17 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:05:17 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 03/14] thermal: core: Drop redundant thermal instance
 checks
Thread-Topic: [PATCH v3 03/14] thermal: core: Drop redundant thermal instance
 checks
Thread-Index: AQHa8lL2kRqTHs97BkaQqiE3ceGPu7IvufgA
Date: Tue, 20 Aug 2024 07:05:17 +0000
Message-ID: <aba49c8be35d62047f2ba9c07c3217d1583ad6dc.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <10527734.nUPlyArG6x@rjwysocki.net>
In-Reply-To: <10527734.nUPlyArG6x@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: 19a0e7aa-774e-43f5-117c-08dcc0e67275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TC8wZTBRVVdNRFNBSkZ0azVsaGxGMUpEdkxIVkhVWjNuemJJY1hNT3E2bnc5?=
 =?utf-8?B?QzRmd20rU3plSkR6djhkZ1JOYnV2bVlSWXF3ZFh1cSt0UjVqVWJxdk0zZE9k?=
 =?utf-8?B?RU1EZkRyeDVJMTBEZ1ljcVRsbGVXL0N3Nm5hbWJUUFR1WG1vRXlFNUMvVmEv?=
 =?utf-8?B?UzdKWmpBYTdNNWNmSHRFd29SZGxvMzZJWWIzRXRhcHYxb2l6Z2JkMDAxa3FC?=
 =?utf-8?B?dnpJRHlmMXJqam1VdDVCd05teVFOUXVUSUJtUzRJeTJnaVNzeVBxTll6aERq?=
 =?utf-8?B?aksvRVJvUDNWSDdZTHVZanhKUTJ6R2VvandIYzJ2SVNOaWwrTmxjYVdMRUlI?=
 =?utf-8?B?dUplSU9FdHhMWHdmVmYraEVvTkFESC9NZFhHcmhCVXVXZ3BmSDV5VHlHRS9x?=
 =?utf-8?B?TWJpVmJ0UHd3OVFabUhURHUxUmMxTzZ5cENIK0VoR1o4UzY3REZud1lHdjNI?=
 =?utf-8?B?cmpmYWtQSmc0bGp1a2pNWFZka0VFUm5tU1U4a0FkQWNHRWRobStPNkNhaytI?=
 =?utf-8?B?eGVycmJWd010Ykg1Y3Z1L2MvbVBLcnVwL01RZFFMejV2RE9TbVNHNmVLMUQ1?=
 =?utf-8?B?ZG9BSDMxYWgwUEJPTnhSRjZ3cWZJb3c2a0Z2anZMbmUxc09KZEdRaW1wUTNS?=
 =?utf-8?B?MktvbmRJVjIwczhockF0dmpmcjdxQ2RhUDBtU1lhUDVQT2NPaklZcnZDOFJr?=
 =?utf-8?B?ZEFjV1NpWHFJUDFwMSs2S25DQlFSNkdwOExtNTRkRXlGNWtYcVRjTC9MMVJh?=
 =?utf-8?B?NzM2eUJJTW5BM2htdERYZlJ6VHZjQ0kvbENuRE1BYUFqdkExVGsyOHJEYWdJ?=
 =?utf-8?B?MUJ1RTE3ZmZCUk5sOUFwQTdoV3k4dGFiRUs1MlgyVXNzOHd1QUl5NTRQODBw?=
 =?utf-8?B?YkVjZ2NsU3hKR2kxL2h6UnlsSDkyRlpxcHdQcjQ0UHhRQWVRN2s0eWY2UWc0?=
 =?utf-8?B?cm9sa05qQnBMT2ZKVTVOdlVKWElKaHB6MDFFMnBISDV4WVR1ZjJaOVZneG1z?=
 =?utf-8?B?TTd0R25PeDRLNGVmMXFpOHhCa1o1T3lKWlgyUjAzVk96ZUFpWE1VV0lxN3A3?=
 =?utf-8?B?WE56bitiRWtnS2NQNGJJd0U5UWpaQURhWlVtWTNSdVlndUJWVUpINUxDUFl2?=
 =?utf-8?B?R2VUWWxiNmY3N3N3dXNpSFYxOUlidzJDUklieC91ajVJVHNLUTRNcHRsQnFw?=
 =?utf-8?B?Vnd6bnBtcHVDQ3M4ZUhNczk5QjFWdXdLaWtsNkVkU2E2L1VQTzhMTVF1cnJo?=
 =?utf-8?B?SlJ1YVRJUW5rd095eVZFK1I0ZDRzRDJlOFlhR1BZNzExMXNKV3RpU2NiV1Rw?=
 =?utf-8?B?emFWMmtrcUUrdXdJNlVaTkVxSTZTRy9zaEQvSUJHUXkweFd3UmUxNDh2ZDQy?=
 =?utf-8?B?UmwwNVJBVnltN3BjS1FBaFZUeWJqWkJwcU1lZ0xPdjQ5aEtJem1uajlrVlo0?=
 =?utf-8?B?Z1dQanUvMUdoL2I2Y1dzR2EvNE9Ibm5rTTVycWQ2ZnNLVUpES09FMm5yLzNs?=
 =?utf-8?B?SmtvTHBhbHFmZkxtVUoyOWlVVzY5T3JUVTZ6SnBqWmQzOHY5Ui9FWUg3a092?=
 =?utf-8?B?T3BPdlo2WUtTcExlRkg3TFE4NkZKTExoQ050K1NKWklNc1FSUmpBWGtMaSt2?=
 =?utf-8?B?RHYvMSs1R1lYK2FRVFVqZjB6Y2E4OUxkNDlZa3dhbk5rcnE3V2hTUklzZVJE?=
 =?utf-8?B?aFRYWXM5eUtpcWdJSXNIcHVhNDkwMzczWVZoWXZhQ203c21RakVKUGdmK0dB?=
 =?utf-8?B?WDMzeHIxazRBbjk1NG9manZPNUdyYTVMU3EyUFd3OUx4SmhvY3pWZElxdjZy?=
 =?utf-8?Q?OZG8+PSXPo5sXdpub2WqGmPPpdYUyDgZ+IYRs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVB4Mmd1bzIwa0xTVEdwZW5NUHhXdVBCTkVZRkh1MXVyS3RBMGh5VTdITUQv?=
 =?utf-8?B?enV4UThoM01rUGU4YUJJR1l6NHp6ZEVUOWRUOTJNS1NhQTUxMVBsbW1ReE5j?=
 =?utf-8?B?Ukd6dVJRdzZrRlNrbjBwTVpaeWNnZGxYTytkMXBydi9ranhQZUQ5cTJ2MlAy?=
 =?utf-8?B?cFB4ZGxkTkIycUpVZi80V09Sb2pTcHZYdXFMOEFrUDVHOGV3RUVIOHNLdjFx?=
 =?utf-8?B?MWM5L28wVDVxemVqYnFyQVpob2hQT2FxYTI5WFZrVFlMSXEyWDMvM2RMVzBU?=
 =?utf-8?B?bkIxT2RUWkJwVllUSGp5TWJWWEZqdzhKckZrOU9ETUx6SldheUFkWkxFV1FB?=
 =?utf-8?B?blNLQ1M2SVZMZWpQcis5K3dYem1OTVcvRk1ad1VPenRGSmlRQVo4VjduNlpr?=
 =?utf-8?B?U3hHT2FjLzhFakRndVU2V1pwR0hBOFdkeHpVWWVEbHkvV2tHZjFrbHpLVmJR?=
 =?utf-8?B?VkdOajRWdlBJQVZZUU9vbW1wZGhIM0tnR2xqbHJDQTJsOGVqa1loZWxxZ2ds?=
 =?utf-8?B?RXFPUjduZUR5SUZwQURWcExpdy9ROVdzME8zMHF2djdxYnNnRXNzVXUwWExj?=
 =?utf-8?B?ckVHY1hER0w3S0dBcTlnTnlla3dVTnU3bVdmb1RwclV6clpmMGh5a0xURkxO?=
 =?utf-8?B?eCtDcGo0WE50SHNDUXlMcDB6d05BOEhaeTErYmI2aXB5c0VWLzNlMDB2MGZa?=
 =?utf-8?B?SUltM1hoeEVKRjFQamtiUDgvREFTRHBnMW56eU15c3FVWTdCTm10c2NscGNz?=
 =?utf-8?B?dnZqcHp1M055N3VldjNUN3JlczZnQTY1TWpuU1NrWGZDS24zbmlBU3B0ZFM3?=
 =?utf-8?B?RDAvVzF2ZEJLL0FHWUNrQVVUT3NTWTRsNkYyMW93cUVnWjBvcUhPQ0J2WW9P?=
 =?utf-8?B?Q3AvUGdyOWNDNnBUaU8zQ0h1WGdoOXExeEl4VTVzdE5hQWxQcU13cXh0S0dr?=
 =?utf-8?B?cFdVakpxTmUzRzBWVXhjUHFjazNaRStFbmRoejcxUXAxSHBiMkFqemduVjMx?=
 =?utf-8?B?c1dvS3hMMUJzaGZNV3Y4cWFWUkFaY2luMHdyRFY0a0huOEhMZDkxdDJYcUd6?=
 =?utf-8?B?dWNKNnA4OURWZUFZL3ByblFDVDhFZElkMnJtbFdDNUpvL0JzRVM2eXBHcHk5?=
 =?utf-8?B?YUc3c3FkMXl6Tys4S25jZHFCV0l4b0hKVS9vaVoxT1o3N3RDbUY4Sk1KVW10?=
 =?utf-8?B?UHpKNXJLZ05hWWl2b3RYV2taQzNBdmFpWkdsYy9yT2JzSG1qRkRWb2NIM3po?=
 =?utf-8?B?MFBpM1Qwb0puY2ZqWlBrVWlrcHJjUUZlZUtmM1BPMTFFamJOYkVqeUJGYUtv?=
 =?utf-8?B?Z25BaXkvaUVST0EvQkg5RU04RXhNVVpYQnM3RFk0OHJ1WXdXOFJ2UFBpVVdH?=
 =?utf-8?B?TThiOEFKWDFyU1hUeFZDd1dCL2VJWGpoZXFwMFhBMTJ5aldQL0UrZnhjZWh2?=
 =?utf-8?B?emdPdU5lT2tKSW5VazN3ck1taGRCZlNCNGlSMjE2eUxXMXVNSSsxZ1cydE43?=
 =?utf-8?B?dUVhdDZaRlYyUnFseTJhQ25aT1lXWStWTjB1eUJWMWozZktIOWR1MkNYaDMy?=
 =?utf-8?B?Y1hXZUo3bEVsWHIwTm1kTTM4THk5bGNIS3p6SkpMVlF6T09nL29mMFZ6YjZ3?=
 =?utf-8?B?OVcwOHJRNEV4eFNOYTk2eTh0c05nR0JxV21GMDdzaGprRlRPWUp6dmd6VkF1?=
 =?utf-8?B?S3p0bXRna0dpYkVTcFN5d0NwbjJ3bjJxcTVjcjJlT0ZtMU5EMjFwOHkvUlBY?=
 =?utf-8?B?TFBRbTZHcTFHYVYrb3BsckNyR0dHdXc4NHN4c2Fqa3p4NVBYUGNEaVNlTmp5?=
 =?utf-8?B?dlBzaFZNdzVpTDZ0OUNucXRucVJDUzRncFNIMW1EVVFQdThTNlVJaytuMlVI?=
 =?utf-8?B?THlGenB3ckc3Vzh2RjlEUG5UNFFpUkpheHN0NG5ocjU1WU8xZFIzZXpVZGIw?=
 =?utf-8?B?VjY4ZzZJRjJWVlR5bHR3WGJHTGZKQTBqL1doRzJmSm16QTY3anNHdXhNdEVE?=
 =?utf-8?B?RjUxWmV0aWJLemcrQWswb2RLVHJaSGVJMGVSMEdXejBBdk5DUktvd2VvYTFi?=
 =?utf-8?B?WDNBdjZDZlE5VVlNdWc0dnd4SGhkeTlqSDIxdTZoV05uZVYzbnljUnVmMUc0?=
 =?utf-8?B?ZFRZRFF1Mnl5dG5taDFEQ1NsV29vTG5WWFVSR2I1ZDJQZnNxRlZhNk96cmJW?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B063C2A6BE62C845BF1EDB7F6B2B48D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a0e7aa-774e-43f5-117c-08dcc0e67275
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:05:17.4586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6P+0M2jLozxv7mWUwXZXoeGFc2FbRaITKWmYf799XEmKzdk7MD6VLji5BfQ83pdi2J2Qp6z37ONImaX7XdhURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE3OjUyICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gQmVjYXVzZSB0aGUgdHJpcCBhbmQgY2RldiBwb2ludGVycyBhcmUgc3VmZmljaWVudCB0
byBpZGVudGlmeSBhCj4gdGhlcm1hbAo+IGluc3RhbmNlIGhvbGRpbmcgdGhlbSB1bmFtYmlndW91
c2x5LCBkcm9wIHRoZSBhZGRpdGlvbmFsIHRoZXJtYWwgem9uZQo+IGNoZWNrcyBmcm9tIHR3byBs
b29wcyB3YWxraW5nIHRoZSBsaXN0IG9mIHRoZXJtYWwgaW5zdGFuY2VzIGluIGEKPiB0aGVybWFs
IHpvbmUuCj4gCj4gTm8gaW50ZW50aW9uYWwgZnVuY3Rpb25hbCBpbXBhY3QuCj4gCj4gU2lnbmVk
LW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgoK
UmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KCnRoYW5rcywKcnVp
Cgo+IC0tLQo+IAo+IHYxIC0+IHYzOiBObyBjaGFuZ2VzCj4gCj4gLS0tCj4gwqBkcml2ZXJzL3Ro
ZXJtYWwvdGhlcm1hbF9jb3JlLmMgfMKgwqDCoCA0ICsrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gSW5kZXg6IGxpbnV4LXBtL2RyaXZl
cnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYwo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiAtLS0gbGludXgtcG0ub3Jp
Zy9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKPiArKysgbGludXgtcG0vZHJpdmVycy90
aGVybWFsL3RoZXJtYWxfY29yZS5jCj4gQEAgLTg1MCw3ICs4NTAsNyBAQCBpbnQgdGhlcm1hbF9i
aW5kX2NkZXZfdG9fdHJpcChzdHJ1Y3QgdGhlCj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2so
JnR6LT5sb2NrKTsKPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmY2Rldi0+bG9jayk7Cj4g
wqDCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnkocG9zLCAmdHotPnRoZXJtYWxfaW5z
dGFuY2VzLCB0el9ub2RlKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocG9z
LT50eiA9PSB0eiAmJiBwb3MtPnRyaXAgPT0gdHJpcCAmJiBwb3MtPmNkZXYKPiA9PSBjZGV2KSB7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChwb3MtPnRyaXAgPT0gdHJpcCAm
JiBwb3MtPmNkZXYgPT0gY2Rldikgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJlc3VsdCA9IC1FRVhJU1Q7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Cj4gQEAgLTkxNSw3ICs5MTUsNyBAQCBpbnQgdGhlcm1hbF91bmJpbmRfY2Rl
dl9mcm9tX3RyaXAoc3RydWN0Cj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJnR6LT5sb2Nr
KTsKPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmY2Rldi0+bG9jayk7Cj4gwqDCoMKgwqDC
oMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShwb3MsIG5leHQsICZ0ei0+dGhlcm1hbF9p
bnN0YW5jZXMsCj4gdHpfbm9kZSkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAocG9zLT50eiA9PSB0eiAmJiBwb3MtPnRyaXAgPT0gdHJpcCAmJiBwb3MtPmNkZXYKPiA9PSBj
ZGV2KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChwb3MtPnRyaXAgPT0g
dHJpcCAmJiBwb3MtPmNkZXYgPT0gY2Rldikgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfZGVsKCZwb3MtPnR6X25vZGUpOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfZGVsKCZwb3MtPmNk
ZXZfbm9kZSk7Cj4gwqAKPiAKPiAKPiAKCg==

