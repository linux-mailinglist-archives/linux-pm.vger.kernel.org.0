Return-Path: <linux-pm+bounces-29872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94DDAEEF49
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DE71BC22BE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 06:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BDC1E5729;
	Tue,  1 Jul 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OP9qkhXB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE41190477;
	Tue,  1 Jul 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352915; cv=fail; b=asaVfAdjTZ6Mn8M9+7xgFpAS2LTnz8/L3zAenBHqHV7oFtixJHF/M00qw7iNKD9rrc6sjKg0kvgFh/pF9Mx4IQqswyeUwLJZ2L5fpBSuqkMidlIRkCBWdB/2HR7QA+PmMFw/3//ggLFUQXaI6yWmUQ8r3zwbmecM6CDqHde11kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352915; c=relaxed/simple;
	bh=byK4PRpCtHEZriE2+++OcDWGpdYOZIPe4lwzH1G+Xq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pCoo68uwO31A0EU9zE5THbfa0t8XgYHkYCQyvt9tRNr/890Uvmnc5Rb8BmK0Yq/ugx5UHEUshAsyDSGBet8xXt0FjPij7INgQerLoRzvyMg6S54WeqyxHnLk8YUktgFDCIplC1IURWTjTsQMTdPqC2qQEhKD2JlbZbeM1BiGsso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OP9qkhXB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751352914; x=1782888914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=byK4PRpCtHEZriE2+++OcDWGpdYOZIPe4lwzH1G+Xq4=;
  b=OP9qkhXBy7sfnMCDNyg00uaXiSFBTTz0r1BAAr9Es5A76Ow6h0K4fa7o
   9NjvJcJl+1AANOVYAUcfa+K9SFvvF7qInvkZR9E1sgIZJrsOFK1TQdd9N
   W0sPq0iV1CmYjhjQwqcypPUuyQ4Sb9VmEMdDpuDmhft43ZMCASTKPY17x
   PmLryATc4LL2Ec+pOqJrfsO84j9v6qKx9MSBKHDKETLEWEcl3Y5x6/Hxs
   TliwiPOunwb1c3pYEMx+EqdFjFM8nPxWTO8bt9fRaVutuO/llwh5ZQPjg
   Ru4EnLgGyPbxiwWR0m6KemJ0O4bHrfDUuPCuKoC4VOW6/cnKRqCBijAOi
   A==;
X-CSE-ConnectionGUID: eUvcCKzrRzW0feCbXAorHA==
X-CSE-MsgGUID: Iu3UAOPPSDS5KSevJGNa5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="56223519"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="56223519"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 23:55:08 -0700
X-CSE-ConnectionGUID: fCvo1+JGQU69hJT4IDYALw==
X-CSE-MsgGUID: TXVpbvMRTo2QPnlClfpYaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153073617"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 23:55:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 23:55:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 23:55:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 23:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD5t1PyDCz0oDvreXMLSEAhkx6DzPsiiPB1MrEjmT6jfUZ+D1SCSyBMFqn+wXqM/T9RKkGnY7eGR0nQs12L681B4jGhQPDW7SquFjr45iB9p9q6o04RurHviLr7FiqV0oJ9sIpBh51RIw2NAiLE0pg6vfmuug0VHz4bjHDTiyqhIaDmhJSCMr5HOfQJNPtx3tQHmKEZ9kFhyPgJUHIH99xNL/4rdncm44TheKZ28YHC7oT1gFe/MhgYuMGDj1IX3wVCuV90CXLPtXuLB5t2Z7YQsjz9e2D9rUP1aNpbP8SN/GYaTopVgLRaLNrT3SPN3NIu63H9u13O4Y6Wod/zdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byK4PRpCtHEZriE2+++OcDWGpdYOZIPe4lwzH1G+Xq4=;
 b=BXmy8gbWCkQVq+amD2QXJtxwmIH7PASwqBoVTki90WjyzHwq5JBz87+7uCMC7sX/4sLdoCJ9brKbhQGdluZUtI+lJMY2T4VkoMqwAhyphcWkby8mxGZm4gOxJg+GAEl6O9yB2KvxOUAaE4bKwOE/5eAYzi+Ik1QASlq8ZpjeCrOE+Euee+01U6s7Es1H39Bd++xdDh3JStjNIfwWVVN6lkcbESKlkN7X5zw3hjtNy9/8+59u6Hsq1GEkVI0wf3LpDx6u/sbKgKmE1non7F7YUzwcF0KrbEr9BzYNne2D9QpNCwfr75QOFdVcK36gEvetjY6n+25jc+ucmw78LLK+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by DM3PPF8F79256C7.namprd11.prod.outlook.com (2603:10b6:f:fc00::f37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 1 Jul
 2025 06:54:21 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 06:54:21 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "benjamin@benis.se" <benjamin@benis.se>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: HP Omnibook Ultra Flip 14 - power profiles
Thread-Topic: HP Omnibook Ultra Flip 14 - power profiles
Thread-Index: AQHb54aI/x4TucNMjkG3sTXjdCBKkbQa6rUAgADA7YCAAS9BAA==
Date: Tue, 1 Jul 2025 06:54:21 +0000
Message-ID: <ee9a2111eab5a8bc95fb406d8bfed12bcc5616b9.camel@intel.com>
References: <GXa7F-PA_8BE7nlK9r8dkdSv7c-DW52GvOUiyYHQ6RyoZDxIpNAocWDPYQDeS7WEZeUisqQH_bqmgSV-eaRmuw5r68MGKxyU9X_4Erd0RYQ=@benis.se>
	 <1037e223-a6ad-4d12-9619-f69a29cecba1@gmx.de>
	 <5I8UDmgF_DcJBmBE0zgCXjuvmmhLamDCHkpnkAwRjSAkCa5xcFUvU-SmAeymxTajjDPR8avuW55RxOjhd8idK6jLy-hz8i-Ma3RHSaFy2Gs=@benis.se>
	 <9642ad7e-3e57-45f9-bfd9-beac3e55418e@gmx.de>
	 <GXC8NQl6AY_N7nQAOCRLt7SDGjFNll_TnqQyzYnP_b1weGkRqITOR-kHKcM66lPonOCo9xO2nSWXr7yycwfFuKmjRMtXVlJKya8-qvvkGik=@benis.se>
	 <de8321ce-e595-460a-81d7-f7dae8a7b790@gmx.de>
	 <X-40AqXfdmQw5shUOk3VSaHSXmwJYWHPmDDMLyGUH6GpMt56ty5SbNg8EVfyI_uC9J07uqZ2TtGJmmpB_x8-xpcVOw29fnKzJZ4n9L0x78A=@benis.se>
	 <9439ec38-aadd-4aac-ba51-a8786ba50239@gmx.de>
	 <3b25e59bc1b162ee8f43ffbd3c50589a52d540af.camel@intel.com>
	 <rFJU7KbF6iq0CxJtSjPu4vLVjWata5hY1Kl-wOv253p0C2W7egJQQrkUnkSqmr1vXDXeTwwtwp0u5ZnQU6pZmPuJ7TnNBVgudMG-q5MRHyM=@benis.se>
In-Reply-To: <rFJU7KbF6iq0CxJtSjPu4vLVjWata5hY1Kl-wOv253p0C2W7egJQQrkUnkSqmr1vXDXeTwwtwp0u5ZnQU6pZmPuJ7TnNBVgudMG-q5MRHyM=@benis.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|DM3PPF8F79256C7:EE_
x-ms-office365-filtering-correlation-id: f3f597e5-65ee-46f2-536d-08ddb86c1bb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2Fhc0MxdlJvaFVITHdjajB6d016cERzMkNQVmUzaHZwOExtZ1dtTjlORWY3?=
 =?utf-8?B?OUViSWkwRDAvRkNFMGRtdDN0NU9jODRSNzZacS9sN1pOYkxzT0ZFNUJSc1hh?=
 =?utf-8?B?VGxIWlZmdEdKU2ExcWJRd05MNHRud0tmNHdGYlhlaWN3Mm1UYkk4UXlEMUlD?=
 =?utf-8?B?SW5rT2NZcXNZS05MbVlmRnZGeDlKZXFDVjRjcnpubitZd3l3MENrWXNNQnI0?=
 =?utf-8?B?TzBhLzVMM2ZSeVV5dGhLUnl0RXpoTFdzWnNKRmFVMnAzT0cvTEl1MlVjcHJP?=
 =?utf-8?B?VGoreVVzSS8zbC9NQTYyaE9SdmZTRExleDhmZzZIcEk3cVlmbjR6L2VxYUo3?=
 =?utf-8?B?L0NPWk5BUTYwZW9mSzM0TThGNXkvclNtYUhzTmlTc1h1SC9abkxPdkY1NHBL?=
 =?utf-8?B?TTRhTG5McmVUM0JsVm1UWEU0c1pPa2diY0JzQkVYaHdTUm5nM0VyYW9zVy92?=
 =?utf-8?B?dXh6Zm01YnZERVcyWDBXODRzYVlRb0RIdk9HSzVhdE50dUJyakY2bU9wR0F6?=
 =?utf-8?B?T1FzTXhHUFIzUGVmdzcvTkdVeFA1cndYMk9WUllFTktzclBCbnczb3ZBbEta?=
 =?utf-8?B?RUU0VjMyL3plWTFJS2p0dklZd1cyUWgwWkxQWGlSMmVVelFSYVNidVJaSVQ3?=
 =?utf-8?B?UUZpS0VxMEZtYjNqTjJkaEp4QWFFblYvL2JZcDVMQ09uMEJIZ0h1VTRuYzZQ?=
 =?utf-8?B?N0dOdGxQSDZJcnlBbk9zSkp6NjAxaGFjcE9iUlZjWTBtdnpOdzJhMCt0TGRo?=
 =?utf-8?B?ZkhSdGhNQ1N6WVh5bHp0QjFVa3hJbTFWZ0pOVTA0S0hMWEp4UmZVdHNXdG9Z?=
 =?utf-8?B?NFRSclRMV3ppZURwNHZJV1N6NkpEbGVDbm5SRUJ6WGkxSkdlRndsMllIVm1w?=
 =?utf-8?B?YVdLeEpRSSs5SUgxN3ExUWRGMi9ramo3YnhVL0NHNTVBZjRKNkFTZjBBeDVM?=
 =?utf-8?B?UDg5ZXVQV2lOMzNzT1NBSWxHS3NFSEtMaHF4QnJ0cmpycE10UUNwS280L1cy?=
 =?utf-8?B?aGRHWXB2QVhtSG5SQ01IWFdJQ0Jld2I3aGxvTFRZa3VUMVpiZ1pCQW10c2Ri?=
 =?utf-8?B?emRnRkNyM2VJWkpMR1dWVno1TlhSLytSS2xMaDhBeG9PcUh6NGRNanVsR09y?=
 =?utf-8?B?VDI2R0RCWTRWbzJHb3cveXplNjM1ck8vYXlMVzdaQlp5cXF0UEhMWUNxamg1?=
 =?utf-8?B?ZVVzNDExT1h2ZVp1cXhVRWhyTWRwWmJQTlRiRmFsTk9OcEpQY0ltSGc0RnJw?=
 =?utf-8?B?U2J3Umg0eUNsRGpTd1grVUZ0bGsrS0FvY3k4b2o3dUFEMnBvcHFITEtlNU40?=
 =?utf-8?B?TGprQitXK0xwdzJPNnpTa2RFdEFpY1krWUh1OTk2cUpaUjZxeDFkSENXSFpp?=
 =?utf-8?B?eW5KakhCVjFSUG80R09EcjZEaS9NMlVwd2dRZlFVcVp4ci9McGh1SEdCKzJz?=
 =?utf-8?B?a0llMk4ybW5GMUxaalIvVGhjMy9hc3YzaHNXRDNaQ2tIL1NDV0FLWjAxemFM?=
 =?utf-8?B?a1grclpCN3FLWEdUN1RjdFVLZG5zT1VueHVRbjJmY0hNdzdqVHhTb1dNRUJF?=
 =?utf-8?B?L0xseWxiTkdBdnQ3RHF3aGo0eTk2czhXL1NOVDByZkVqc0lKejMzaWUwSnJx?=
 =?utf-8?B?Wk9LU05SaWxvMEIrd1diaE9keS9MY0swdmZadEhHMXBIRFc1clhIdUxiZjNU?=
 =?utf-8?B?RnR2WUZESytJOGNPWHpOU0toQ3RmZDBnQW95Q21HQ25xcEZqZVVTdEJwWUlh?=
 =?utf-8?B?K1lQVHI5S3ZtUUxMMTc1ZHluOEFjWmZrM01EQUZNOThtYzlXNE9WTURNWXA4?=
 =?utf-8?B?a1cvRXAxL1hxZGVxdUp4dmt4eGg2djBMdkNHbklCMUhlbWl2TkdrdFpId0Vp?=
 =?utf-8?B?NDBYbmZUaGtwQTRoY1BtUk56N0RVaVE0cHFCU2JiYStjSUxYSVZOU0R3NnZj?=
 =?utf-8?Q?tPpluoPcPW4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWdvSXNadjh3RldrTUVsSk9xYjFnLzY3OTRYanVJeE0vazBuaDdySHdnZnQ4?=
 =?utf-8?B?dTNJSVdVU0xqdnZWMWUwU0NkWVdpUlJWRCtnVU9KU1dTR2JBSnh0a25uQzE0?=
 =?utf-8?B?enpwdUZodVB2cmJHVGEzU0MrNUx5NVpxUUxpOEs5d2RsbVorSVpIRk9scXZi?=
 =?utf-8?B?US80cHR4cUV3bjA0a3VORUpSWmttMGp3ZkdPNHVvdVA4b3hwbWgyNUxzZHFu?=
 =?utf-8?B?YjVXWFJ6RVU0RDRrMjkzemxzV1pPSlc2MFlVdXZrb0FpczROMmZWRTF4R1Zz?=
 =?utf-8?B?WmpEMHhWV0VBd3Rkem15SkhYc1gwaXBqNFJ4T1lvU1pGUm1DNHRwNERSencz?=
 =?utf-8?B?SnFQNkI3Y0dsYS94L1RhcndnK01WNnBmS2p4QXdkYUNubFAzNUdOTzhGYWxH?=
 =?utf-8?B?a1JWNnNlL3hsT0wwa2pqajd6RytIRWtlRUo3WDlYYzVzM0kxNDYvcy9Wak9m?=
 =?utf-8?B?YWl0QzdLRUs2bnJUQU9FSGMzRkc0d09pbmkwb0JwbGk4QWxaZUdxclhMbVdC?=
 =?utf-8?B?NFRaelg2Ym9kUDhsSHY3SnF4ZjhIb2NXdUhIQ0tIRHZodEQ2NWxQR2xRcDBR?=
 =?utf-8?B?QmkxTU1kNkU1bnlsQUdiTmV4K0FnRmZjQ1ZHd0lKTHM1SGQ2ZG5aVUl3RHRB?=
 =?utf-8?B?OHlXcm53QUp0UEtYZnFVWFFpZXBsL1NoRWJscFBpdTNtMUJXWEh3bzErWnJq?=
 =?utf-8?B?c1FSbktaK0RWZzhpSEcwSjRZS0pQMzVzRVQxTUxQRjNrcVcvczc2S3p1cDZE?=
 =?utf-8?B?YlNtY0RJUkRZVGxyU0FsaVhqcUlDdnFZTDc3WVlSWGV2ekVlUEJ4QWVBQVZo?=
 =?utf-8?B?bDR3MThkcWF0L1ZkWUtOT0pIWjhBVzVXSHlWMzdUdzcwY1VHQUJzcnZpUmUw?=
 =?utf-8?B?K2llVXRtQ3o5TzVXTmlHQ0NUWDB5eGVsWHhPczJoZHVtcHRVYzZCLzByWEhr?=
 =?utf-8?B?RWNMenRjSWNkRmhvMW1LWGYyMGFHWERXaEFyRDFUQkhFSTVheU93WFJHeXUv?=
 =?utf-8?B?Qm4yQ1lJRVR6SGpuSVJTK3dhUnFFVWNqRWFpZEdiMDZmeUt3bVFBU1EvOStV?=
 =?utf-8?B?dVFMMWR6OHA5YnU3UjFRVXZ5N2RMbzdObUI2ai83MzFTVGNVbHBGYWorSFBl?=
 =?utf-8?B?anpyWFFFL0pjWjBOUDFKaUxGVExPQmpaWS9GV0cvaCtVMDFOZWFseVRBU2Jk?=
 =?utf-8?B?a1MxTWpEZmJWRGs2OSthZWZhMW02TTI0TWhWMDlYVzdrYlQyMTBWTmlpY3Fz?=
 =?utf-8?B?bmo2VkwycTZnQXlmVzRLMktLRUZvN1Z1dlRSWnh2RTdVREovYUw0WTF0cFNR?=
 =?utf-8?B?L09NeGhiSWRHZTUvN0FrVlYvYWJKQnUvSExGWi9JWURIVXg3L2dnQXVOUWtu?=
 =?utf-8?B?Mjl5VzZadERyMUtqNXdYRmFYL2hSWFJQaElDQ3gvekl6MjgyM1ltbTRqZGQz?=
 =?utf-8?B?ei9LRjU1UnJ3OGZCM3RqL1hvdzlOektnMDhmNmJKcTFLMGtERzNkV0lDS3Jo?=
 =?utf-8?B?c0dEWkVXcFlOUU5mdTlVcTUvRUhzaVFPNFFSa3o4NU8zT3FyOTI0OTVWKy9R?=
 =?utf-8?B?YkVoK0o2dmxSYTBCOTRKb2srNnJGVzFxVVNXYW9uaUxKaExaa0lxQWRFeE80?=
 =?utf-8?B?dHlZYUczZmxtZTRuQWV1V092ZjFwVTdLRG11Tk51OE5ZNks1dXZrMUs2NStX?=
 =?utf-8?B?SUp2TTBMaTB4RUR4OVJINFVBZy9UQUU0QVo4ZmpoVE9GZTcrMVFXQUZxRjdl?=
 =?utf-8?B?M0lOOWF5dlN3dzRkUllPTkljWWk2eXh4VHd5MDJaVGEwbXdZazd4ZnBsUlpH?=
 =?utf-8?B?aExpMVg2NE9XTk5JZ20zRFBnekJMWTU4NkhuWDB6SWZDR0lxYlZlT3U4cEQ5?=
 =?utf-8?B?ZnlQU1pHdDZXdHlwV2YwQWxzOHYvMzd1TjdmM0c0ZVN5ZjduMzdiVTJQTzFU?=
 =?utf-8?B?djIya1FKeTlWNjFmcUUrVm5qZ1F4aEVNM3pWcHlKY0tXMFpNMmthTGZIRjQx?=
 =?utf-8?B?M0dMTnNxdnd5YVJ0K2ZZK3FBYTdFQWxYK3YyREx2Z1BxNmo5elN2a0VPQ2k3?=
 =?utf-8?B?VStMVXJURXU5ZUlBN2lOQmljSEtVY1pQZlZhS2Y0aG5lUlVZUHVlYzNaYXN0?=
 =?utf-8?B?bzc5Y1NwSEdYZ2c0UTZHbTltKzZZVXVGMVFkazBoYkwwTVg0ZUtBWXc2MUhU?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D0288168B9F67438ADD7493AD211ED9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f597e5-65ee-46f2-536d-08ddb86c1bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 06:54:21.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXHS9KspOB3njc/M87JqfJ2YkzX5qUBKhNbrEJl6roRgvPv0bzTETFJFLBWHvrZB1VlBqwg1rknBvU4hIuuPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8F79256C7
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA2LTMwIGF0IDEyOjQ4ICswMDAwLCBCZW5qYW1pbiBIYXNzZWxncmVuLUhh
bGzDqW4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEJlbmphbWlu
IEhhc3NlbGdyZW4tSGFsbMOpbg0KPiANCj4gDQo+IE9uIE1vbmRheSwgMzAgSnVuZSAyMDI1IGF0
IDAzOjE4LCBaaGFuZywgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gDQo+
ID4gPiA+IFNvIEkgdGVzdGVkIHRoZXJtYWxkIGFnYWluLiBTbyBoZXJlIGFyZSBzb21lIHJlc3Vs
dHMuDQo+ID4gPiA+IA0KPiA+ID4gPiBCZWZvcmU6DQo+ID4gPiA+IFJ1bm5pbmcgVmFsaGVpbSB0
aGUgcG93ZXIgZHJhdyBpcyAzNXcgYW5kIHRoZSBmcHMgaXMgNDEuDQo+ID4gPiA+IA0KPiA+ID4g
PiBBZnRlciBJIGhhdmUgaW5zdGFsbGVkIHRoZXJtYWxkOg0KPiA+ID4gPiBSdW5uaW5nIFZhbGhl
aW0gdGhlIHBvd2VyIGRyYXcgaXMgNDR3IGFuZCB0aGUgZnBzIGlzIDQ2DQo+ID4gPiA+IA0KPiA+
ID4gPiBTbyBpdCdzIHdvcmtpbmcsDQo+ID4gDQo+ID4gDQo+ID4gR29vZCB0byBrbm93IHRoYXQg
dGhlcm1hbGQgaGVscHMuDQo+ID4gDQo+ID4gY2FuIHlvdSBwbGVhc2UgYWxzbyBhdHRhY2ggdGhl
IHR1cmJvc3RhdCBvdXRwdXQ/IHNheSAidHVyYm9zdGF0IC1vDQo+ID4gdHMubG9nDQo+ID4gc2xl
ZXAgMSINCj4gDQo+IGh0dHBzOi8vZHJpdmUuYmVuaXMuc2Uvcy9LdFJ0Q1FYaTdtUzhHTWnCoA0K
PiBUaGVyZSB5b3UgZ28uIEkgYW0gY29tcGlsaW5nIHRoZSBsaW51eCBrZXJuZWwgYXRtIHNvIHRo
ZSBsYXB0b3AgaXMNCj4gd29ya2luZyB2ZXJ5IGhhcmQgKEkgYW0gdGhpbmtpbmcgb2YgbG9nZ2lu
ZykuDQo+IA0KaXMgdGhpcyBkb25lIHdpdGggb3Igd2l0aG91dCB0aGVybWFsZCBhY3RpdmF0ZWQ/
DQpJIHNlZSB0aGUgVERQIGlzIDE3Vywgbm90IHN1cmUgaWYgaXQgaGFzIGFscmVhZHkgYmVlbiBz
ZXQgYnkgdGhlcm1hbGQgb3INCm5vdC4NCmNhbiB5b3UgYWxzbyBwYXN0ZSB0aGUgbHNjcHUgb3V0
cHV0Pw0KDQp0aGFua3MsDQpydWkNCg0KDQo=

