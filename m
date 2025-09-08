Return-Path: <linux-pm+bounces-34138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D128B487B1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8883BED9E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526F62264B2;
	Mon,  8 Sep 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEv+oBbw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844801946AA
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322115; cv=fail; b=T+DQu7wdntfFskv86E9NcvZHKVAxeAWjtvg5wTEp2ED1bB4PnSlUV5FPZeq9w+PJ88PV96GhImheOYCnd+yKImE12Zmf98Mm7HZ+hzjDh6EWV6HB/0Q8PiX9skYdSYFKiSjCoVVykGIW4WyyMHdiHjih79zGIzOibt+EcknCSso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322115; c=relaxed/simple;
	bh=nX4fis+zRo3RlzjJQFmdrJvQbl9klDVno3doo+aLpyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJPQJfc0a7PWGUefrvY5lPHX1xb1fIkhWer3ZKYGkht4nuAkGwjsxNUE3Z1bJWzlQOFrM1WwYR3o6YuVwgSShqcJzQlOIwyyPqJ/Y5gzFjmfcYtGBo78mJPVGMN9wZTidn+lUn8ifVqBzx0YeM3Z6RDc0QbZpLdFMciXY5x3ovU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEv+oBbw; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757322113; x=1788858113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nX4fis+zRo3RlzjJQFmdrJvQbl9klDVno3doo+aLpyo=;
  b=PEv+oBbwIkawospU+mK0w0zPAiSw/i61F9iffEQMPiih14TpE5PRidCF
   z6BXXFwRut431owgIdKeE4Zki6+2eE4yH965kk4XsST9uKUKEXNJaz+cZ
   6Eb437cZHranEXJnPfCcecajAXtWntIhUhXw/X0sC2TRM3LMdWpU3/RgX
   FzrpsnkP6GSd98vfgZPMkOZZpm3AzFjFSb53XJO9upLIi6WbtqFnKI3WQ
   pV0JylDrfveKcEPJDTgjyuS3dsxb+xDwJ88r4CcTfSNfJvjuKDFk8O29l
   2VcUX/nt+hhZ44Wo/zQVpdN3J6SIkqfljXLLow4s8yzXcB0MFTca9lifX
   g==;
X-CSE-ConnectionGUID: 7mo8o/gFRHiDJpQzkIL4cg==
X-CSE-MsgGUID: FEvgsv/nToK6oV3BKDWo4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59719552"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="59719552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:01:43 -0700
X-CSE-ConnectionGUID: 9rIQ4Qd0SFCQqRr0U/UPTA==
X-CSE-MsgGUID: W+LE7oesT5OQlwp+s2vemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="177968624"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:01:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 02:01:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 02:01:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 02:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pka5TNMWc+HMautQEwXNO021ExwaAx8aONJbfAaSmHaOQRE7f21ilmkf9Gi2iOxJpwMvD8zkLSSKJSczqJVWnX2FBAKYRBk5G88/DWrkhYbgkQ+7lDJ1bYKNJ91yDzldtD0ERnWh9VjkOrAywvP+PJJ9qQBmrg93zeBR3mWR4zqgdJYj/iWSfzy+WEkqs4Kb8TOg2ntk3USAEentxNsw10N/tKukM/oF7WF6eteCRrktnfBEvIFb/Ff/+L7uwkUUP5UMKCnu+3M30KjjJEee/QQf3b7szBUqX8ambJnydJ81H5ro4+jfKBnutuvc0Dd5D1DmnxRGVgJ2nzDJnkGm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX4fis+zRo3RlzjJQFmdrJvQbl9klDVno3doo+aLpyo=;
 b=XaZ774w/mYZATRNhmp5C+3HiulDTehRWbL6WY1+oGB+Aztrhvs+Vu41NxbFycAgLGn8ORjadXz3GXubtTu9hxFNUialwqvpjpilyuQXi+BtFfYTGykjPazHOeU9J4b83XOB9+TaByrxyShNePArsKOoyuntAU6dgAexp06cwneRODd3IljjQq28RpBnKlh/vRcDFemY6dM2ldsjsLFLkg32gmYLSgNNJOVsi5BvsLtaTSi6sFWFw7y9b2UotaSNSjkeaDfIvzzIjZDq/47uLF4fBikNHhUtk7xjfHgp3BCJmPB6K2ou/KZIMm5sFNcogrmUjt81T/PCHjfjDGErRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 09:01:37 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 09:01:37 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Oliver Neukum <oneukum@suse.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: conservative: Replace sscanf() with kstrtouint()
Thread-Topic: [PATCH] cpufreq: conservative: Replace sscanf() with
 kstrtouint()
Thread-Index: AQHcIJvFe6JR/wpnIEWq64QwwkjQCbSI+z4A
Date: Mon, 8 Sep 2025 09:01:37 +0000
Message-ID: <LV3PR11MB8768010CAD67E4404853AA0EF50CA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250906115316.3010384-1-kaushlendra.kumar@intel.com>
 <93d51f53-8530-46b4-a2f3-d01046d9d583@suse.com>
In-Reply-To: <93d51f53-8530-46b4-a2f3-d01046d9d583@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: 846b480f-c9df-4ecc-aa7c-08ddeeb651a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S3M4R0V3SjkxRXdNRnd2Y3RRSVQzb2ZNMzdEeW5zdzY0NU9MMG5MWkFKei94?=
 =?utf-8?B?UDY0UGwvRFZjVVBUd1ZzR1JSQWtMZi92SC92Vk1ORlUzVW11MFp2OUw5MWIw?=
 =?utf-8?B?TE9LdEMrVjBqdERsZkxZalZtanFOa0NGaXZLZTNWT21ZZjR4R3pQT3pKZVY1?=
 =?utf-8?B?eVMrTFpVeGtKbk80Zk9DK0pBenNVTnd0cGNmTitNZStwVExMV1hwVHVZTTRU?=
 =?utf-8?B?SXFkNEszYnVJcjhQTm9icXdTNzhPa1BNN3VUVUJFNTc3UjM1cWJRdXRIc3Bi?=
 =?utf-8?B?MkNZYThEa1ovMzhrWUk2VTkyN0FOWU1xZEg4bitDRDZPU0diZzlGVXpYT093?=
 =?utf-8?B?ZFB1M2lsak4xME42VDJ0ekg4MFI5NGlOYUg2ZDZ6WFd1YlhZVUc5MXhYeEpC?=
 =?utf-8?B?cWZvNHA1OEhRN0FpK2QvU2lsRUc0NjB0YlBBYTQ0end1SlVEUHVxNU4vSjhX?=
 =?utf-8?B?RlNKSndQRkZKMFNsZEhDMWtLWWJuckxSQmF4cWszUk9lQ3ZVRkI4TGdlMCs4?=
 =?utf-8?B?SzlKWmFyQ3NCbndXSHVha1J3d1BhU2JGZG9Vd3VOdXRUejlLSXdVOC9oNk1y?=
 =?utf-8?B?UitIcHpWSkdZQmw3REFGTG1ZSkl3cUJsb0VJL0NRN2ZFR2IycWdRNXFLQTc1?=
 =?utf-8?B?TnIzMWRRa1RPZ1Z2Yk9IZkY3ZXYzSFVHbzFtQURYYjRleXNiQ0ZyL3R2WDRk?=
 =?utf-8?B?TjAyc2thZFROUXcxQ0U1cndFYXMrMmE1ZVk1a21BYTB2L1paYTR1UURKWWVm?=
 =?utf-8?B?UnAwSGhRaDNBcE85aUdSMGVqc2NOMnpVS3paUm9HVGtZOWNkRlZWQ0pPT0hq?=
 =?utf-8?B?Z0dKNkJPdFdCQndIY05VRjdOdTBaU2lMQjZ3QXV3cFl2V09TWWVPdlFGVUFx?=
 =?utf-8?B?S3pmZkFLT2V0endxU1hSQVlmb2RMZ0pBRDFLQm5Tcld1Y0pOYU1LRkxocWJr?=
 =?utf-8?B?REN0dWF5UitSQVN0NWpwdE9aMVZqWUV4OVZza1lOUStNOXp4dURZcjhiZnA5?=
 =?utf-8?B?bC9BYnRINlU1SXpGYi9vZkNnTFhWbHhCMmVtYjhLajBxM3J3enVva1VjWVJq?=
 =?utf-8?B?RHJrdXJ4N1k4Q1lJU3UwUDBuNjQzelp0Lzg1dFQ5VTFUbGszS1FQZ29ZTitC?=
 =?utf-8?B?N0NKOE16L2txNmhDSjBTNWJGS2daM2ZoVVliUEI2TEhmd0hCVTM5NDNoTmdZ?=
 =?utf-8?B?eVB5V1MwTzcyZk5kbXVxc2NrdXg2eFdiOXRYRHFMZHhObWMzVmNuajRpUXpT?=
 =?utf-8?B?MFVWY2VBWGVZOFd6V2Y3YUdyc3pDRUp1V01mN2VBVjJDMVdYKzlHOGV0OUxP?=
 =?utf-8?B?RU9yK0lPeU1xU21GL0pnVFFVSEwveVZKcWdZcENqMGRMSExzaFZ3OXFqOEo1?=
 =?utf-8?B?bloyeEtHZjRtSW1iUkpxT2VibE81WmlOWU5IY1NhMTF1VDJYMFZaUjNyOWFj?=
 =?utf-8?B?cmtOeTgxWmJWSGEyTzgrTVdKNkZ2TmMrbjYwTTMxNG43U2RTMVIwSTRHNXJD?=
 =?utf-8?B?MFFwSDR2dHlBSS9XY1VnL09tWGhlMk9oMGlKODdqMlhUTzVKcG5QRVUrUzRE?=
 =?utf-8?B?b1RWb3phNDI2aitsZzVLdmJseFcrRWVPdkJ0bnBjS1RvSWZjNHRwQU9aV3Bm?=
 =?utf-8?B?NStPcTF2MEk1dmVHRkhvdXNieTFkbnA3aXJXUUFOT0EycjdFTHB0N1k1UU9s?=
 =?utf-8?B?NXBuTzV3OXA5Q2Z4bGRTaEZBWDc3QllmRU04R01heVZ5MHBOV3NTZWJnaWM1?=
 =?utf-8?B?V1NDcGs0WDBpQUpXbzBPNVV0V3MvNDlpcFIwWnZlRkYxNjMxT3NzTjZjVi8y?=
 =?utf-8?B?TWsrZUx1OUNHTThMSjJGa2o1WUlBbGVmeWNKc0pTVHBjTVN4R1hQeGpSdytG?=
 =?utf-8?B?M2FkZWIzMHdlTHRGTEc4NDFOdlMyNjEzdVRsbEc0RHBTdGNXRVlWL2EyRGZo?=
 =?utf-8?B?Q1Y1SkN0U01mZy9kaTBLanpDTWVCZ253Q2tmVTBsMEEvbEdHcldpWmhrLzdr?=
 =?utf-8?B?LzQxRi9YTmx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFBwbG1zcHBzOG9DZmdWQ1NJK1o4ZjlHdU9hc3h4WFlLR0RZdTRVTit3NDhD?=
 =?utf-8?B?bVU3dkkremdvbTQ3cDBaMzJSS1JVZDFDbDBkZkRwVXZjaWNxdVpWRGQvMmlH?=
 =?utf-8?B?ZkVNNTExWEZiQ0djZUY3dnJ0c3ZOLzBsczhtUXZJZllGbEVkTmNwTEJNdHBQ?=
 =?utf-8?B?RTdEcjlTV014VUVtc0lsdzN2SzR5RmN4ME1XY0JhZ2Z3eVV2akUrMnRmME4z?=
 =?utf-8?B?dGdCR1Y1K29BSjN3TU5ibisyQXRaaWZQby95OFJvVzkvME81aGlrM0E4RzdO?=
 =?utf-8?B?ZmxISFBkY0NFL0VhYjZYdCs0WjluclA4cWt4K2YreEllb1VWL3dERW9MWmpq?=
 =?utf-8?B?amthbzdtK2R1NDViMU03cEc1UXV2Zjd1WnBLN1BVSWVZOHJKaGczY2RONXlw?=
 =?utf-8?B?YzJpbjdpYzQ1WmsreWZva2FURmQ0SFYzRC9OemdBaDRXM09CS1BHcjFhT0JZ?=
 =?utf-8?B?d2pyeFJKdzhuODI4R2FOSXFSdDlRYlFYNk5Jc0Urd2NqV2JXUWVYNmloVHVs?=
 =?utf-8?B?NkoyUGJkWWZuSUZzM3d6YlQ4K0ZtYVE0RzRVR2RhT0hPZU9iQ01ydml0cnVx?=
 =?utf-8?B?MFZMQWQramtTMWFxS2hnK3ppc0JvdzFPbmUzalZpdCtMZFlMcVdsc3Y4VmV1?=
 =?utf-8?B?UnlKc1NReWJGTE93OEh6eGIwT0RjNFVYNzBLOW1tQ0JGRWMyV0Q0TXRGdnQz?=
 =?utf-8?B?WFhGNHdPY1FHNEI2aVpxZ1BaYzd2SkwzL1J2NlJZaUM5Z3MrMkc4enl6QU9O?=
 =?utf-8?B?N1JPaFhjUlJFYjdyTUFFdFYrZGhMYW9Da3hjVW1Rc2MwR2syeUxMclQ5VU9E?=
 =?utf-8?B?b25kb0g1NGRLSlE1NnREMEZudFZ6RXNpTys2M1dMbFRxSzYyVGRMZENtdHpm?=
 =?utf-8?B?SHNiZFR1ckY4ZnFQcWpXN1hNMnladHZWbitvUjdvcEVqMm52VXVGMVA3RGR3?=
 =?utf-8?B?WDRvVG5FN2hKUHpCbFFTbTV5cGV1a1owQTNXRnJJc1FEVHgxQVNUclNuWUVP?=
 =?utf-8?B?ZTJjekFxcldDOE5LTUF6T1JQK1c4ZE55eUtLSHcxS1FOV3JKaFRIT1RHcFdB?=
 =?utf-8?B?akdzUnEvd2wwbDg4N2llZ1hRUW1tQ0hZWkFmV1JYaVhreHNoN2Y0Y3RmVHJ4?=
 =?utf-8?B?c2hpVXd1dGlWaGxyYVovNCtlKy9JOUFqaFZDdEhreGZ0b2RtcUZzaUduQWw0?=
 =?utf-8?B?dlFHOEZjdzcyNU5FMlRqeUJrMkR6QkRNQnpNWk1wamFISkFJclJXY1VtK0lq?=
 =?utf-8?B?T3hSOHlIa2V2eFFTN3UvTXJ1Q2ttYW1oNE5lZ3l4dUdVVVNaeVFwY2FOS0FK?=
 =?utf-8?B?TTJRdHBBTVM2Z091akRCMTU2VzZsdEt5OGw0QXVqSCszSDhCQkRjaHJ6TUp5?=
 =?utf-8?B?akgzdjZVQTF3QzhIajlpb0xTT1l2WGl6VnQzNEV1UHRLNUlhRlZYY1RCekxR?=
 =?utf-8?B?Y3ZNZndIUmpUTVNpdERzUTlIeVNXN0NSMkV6eVl5ZmJScExGQ3VabC84OGM5?=
 =?utf-8?B?eUV2eUQ0QXJQcldUeG9qZG9LcGYxV1k3L2dxWWNjQ2xMelBLa3M1QkdlMFd4?=
 =?utf-8?B?d3Y3dTduMU1KNlErMHRQK21UdGR4QjdOUUZ2Z2FHT3RXNGdtcHhnTCtuVjZL?=
 =?utf-8?B?V3FGcGM1REc4bHExNnp6ZmkxbWN4b3Z1T2U0MG1UbkNLSGhUb0RiSnk5SDVJ?=
 =?utf-8?B?WXNWYjZLei8zR1ExeFBaS3pwZW84MXphc0dqcXRySzRKb0dYZjlNMVJPTERn?=
 =?utf-8?B?dldoV1Vna0wzdW5KQ3lvZWZNWWlIaXNSKzBVMkl1WUZqWEJxaVo5V1ZVMEdJ?=
 =?utf-8?B?bHV0MStzRTJndnVmQ3dia3BGOWFQUUFZTkJyZ0N2T3pyZ21qTkw4bVhTVkpw?=
 =?utf-8?B?cTNudGs1TXZxNmVhcFJ6WDNPY0FrS2lVZTZZRnVvUEU3cUV1cmpDUmdhb3cw?=
 =?utf-8?B?Unl6dlBUN0JrUDhYbTFaSkY5VE9aQ0RtRVJmT1NTYzFoQklJbms4cGNpUDRh?=
 =?utf-8?B?cjhaSGduMmlQOWhmZlVZK0lia0tnZUJHQ1hJZit6clQ3MlB2a1poQXd0eXU1?=
 =?utf-8?B?UlVVVnNXOHJvakdKZEc2bXNvVjc3NmJ5RmFSbnJFeXQ2aWkzUDZpYjVRQmt3?=
 =?utf-8?B?aUNHWmdVUXZ3ZUczM0toTER1Uy9UZk1SNWtucG1vcFlLMHV2ZGtyV1ZHVGFT?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846b480f-c9df-4ecc-aa7c-08ddeeb651a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 09:01:37.7042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtZGkx3FBGSw28Ha8JwPyuNP4dsSq4FpFCmYu/Am0OZPX8sF/ILWYJStQEPrP8DwlA3jeqkggqLd1cboDHUmnGCvKYOCn1osnX2AwcyCO1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com

PiBIaSwNCj4NCj4gT24gOS82LzI1IDEzOjUzLCBLYXVzaGxlbmRyYSBLdW1hciB3cm90ZToNCj4g
PiBSZXBsYWNlIHNzY2FuZigpIHdpdGgga3N0cnRvdWludCgpIGluIGFsbCBzeXNmcyBzdG9yZSBm
dW5jdGlvbnMgdG8gDQo+ID4gaW1wcm92ZSBpbnB1dCB2YWxpZGF0aW9uIGFuZCBzZWN1cml0eS4g
VGhlIGtzdHJ0b3VpbnQoKSBmdW5jdGlvbiANCj4gPiBwcm92aWRlcyBiZXR0ZXIgZXJyb3IgZGV0
ZWN0aW9uLCBvdmVyZmxvdyBwcm90ZWN0aW9uLCBhbmQgY29uc2lzdGVudCANCj4gPiBlcnJvciBo
YW5kbGluZyBjb21wYXJlZCB0byBzc2NhbmYoKS4NCj4gPiANCj4gPiBUaGUga3N0cnRvdWludCgp
IGZ1bmN0aW9uIHByb3ZpZGVzOg0KPiA+IC0gUm9idXN0IGVycm9yIGRldGVjdGlvbiBmb3IgaW52
YWxpZCBpbnB1dCBzdHJpbmdzDQo+ID4gLSBCdWlsdC1pbiBvdmVyZmxvdyBwcm90ZWN0aW9uIGFu
ZCBib3VuZGFyeSBjaGVja2luZw0KPiA+IC0gQ29uc2lzdGVudCBlcnJvciByZXBvcnRpbmcgKDAg
Zm9yIHN1Y2Nlc3MsIG5lZ2F0aXZlIGZvciBmYWlsdXJlKQ0KPiA+IA0KPiA+IFRoaXMgbWFpbnRh
aW5zIGV4aXN0aW5nIGZ1bmN0aW9uYWxpdHkgd2hpbGUgaW1wcm92aW5nIGlucHV0IHZhbGlkYXRp
b24gDQo+ID4gcm9idXN0bmVzcyBhbmQgZm9sbG93aW5nIGtlcm5lbCBjb2RpbmcgYmVzdCBwcmFj
dGljZXMgZm9yIHN0cmluZyBwYXJzaW5nLg0KPiANCj4gbG9va2luZyBhdCB0aGUgcGF0Y2ggd2hp
bGUgaXQgaXMgYSBnb29kIHRoaW5nLCBzb21ldGhpbmcgc3RydWNrIG1lIC4uLg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEthdXNobGVuZHJhIEt1bWFyIDxrYXVzaGxlbmRyYS5rdW1hckBpbnRlbC5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9jb25zZXJ2YXRpdmUuYyB8
IDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2NwdWZyZXEvY3B1ZnJlcV9jb25zZXJ2YXRpdmUuYyANCj4gPiBiL2RyaXZlcnMvY3B1ZnJl
cS9jcHVmcmVxX2NvbnNlcnZhdGl2ZS5jDQo+ID4gaW5kZXggNTY1MDBiMjVkNzdjLi5jY2U2YThk
MTEzZTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXFfY29uc2VydmF0
aXZlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcV9jb25zZXJ2YXRpdmUuYw0K
PiA+IEBAIC0xNTIsOSArMTUyLDkgQEAgc3RhdGljIHNzaXplX3Qgc2FtcGxpbmdfZG93bl9mYWN0
b3Jfc3RvcmUoc3RydWN0IGdvdl9hdHRyX3NldCAqYXR0cl9zZXQsDQo+ID4gICAJc3RydWN0IGRi
c19kYXRhICpkYnNfZGF0YSA9IHRvX2Ric19kYXRhKGF0dHJfc2V0KTsNCj4gPiAgIAl1bnNpZ25l
ZCBpbnQgaW5wdXQ7DQo+ID4gICAJaW50IHJldDsNCj4gPiAtCXJldCA9IHNzY2FuZihidWYsICIl
dSIsICZpbnB1dCk7DQo+ID4gKwlyZXQgPSBrc3RydG91aW50KGJ1ZiwgMCwgJmlucHV0KTsNCj4g
PiAgIA0KPiA+IC0JaWYgKHJldCAhPSAxIHx8IGlucHV0ID4gTUFYX1NBTVBMSU5HX0RPV05fRkFD
VE9SIHx8IGlucHV0IDwgMSkNCj4gPiArCWlmIChyZXQgfHwgaW5wdXQgPiBNQVhfU0FNUExJTkdf
RE9XTl9GQUNUT1IgfHwgaW5wdXQgPCAxKQ0KPiA+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+
IC4uLiB0aGUgcGFyc2luZyBpdHNlbGYsIGZvbGxvd2VkIGJ5IGEgY2hlY2sgZm9yIGJvdW5kcyAu
Li4gICANCj4gPiAgIAlkYnNfZGF0YS0+c2FtcGxpbmdfZG93bl9mYWN0b3IgPSBpbnB1dDsgQEAg
LTE2OCw5ICsxNjgsOSBAQCBzdGF0aWMgDQo+ID4gc3NpemVfdCB1cF90aHJlc2hvbGRfc3RvcmUo
c3RydWN0IGdvdl9hdHRyX3NldCAqYXR0cl9zZXQsDQo+ID4gICAJc3RydWN0IGNzX2Ric190dW5l
cnMgKmNzX3R1bmVycyA9IGRic19kYXRhLT50dW5lcnM7DQo+ID4gICAJdW5zaWduZWQgaW50IGlu
cHV0Ow0KPiA+ICAgCWludCByZXQ7DQo+ID4gLQlyZXQgPSBzc2NhbmYoYnVmLCAiJXUiLCAmaW5w
dXQpOw0KPiA+ICsJcmV0ID0ga3N0cnRvdWludChidWYsIDAsICZpbnB1dCk7DQo+ID4gICANCj4g
PiAtCWlmIChyZXQgIT0gMSB8fCBpbnB1dCA+IDEwMCB8fCBpbnB1dCA8PSBjc190dW5lcnMtPmRv
d25fdGhyZXNob2xkKQ0KPiA+ICsJaWYgKHJldCB8fCBpbnB1dCA+IDEwMCB8fCBpbnB1dCA8PSBj
c190dW5lcnMtPmRvd25fdGhyZXNob2xkKQ0KPiA+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+
IC4uLiBhbmQgaGVyZSBhZ2Fpbi4gSXQgc2VlbXMgdG8gbWUgdGhhdCBpZiB5b3UgYWx3YXlzIGZv
bGxvdyB0aGUgcGFyc2luZyB3aXRoIGEgY2hlY2sgZm9yIGJvdW5kcywgdGhlbiB0byByZWR1Y2Ug
Y29kZSBkdXBsaWNhdGlvbiB5b3UgcmVhbGx5IHdhbnQgYSBmdW5jdGlvbiB0aGF0IHRha2VzIGFu
IHVwcGVyIGFuZCBhIGxvd2VyIGJvdW5kIGFzIHBhcmFtZXRlcnMgYW5kIGNoZWNrcyBhZ2FpbnN0
IHRoZW0uDQo+IEluIHRoYXQgc2Vuc2UsIEkgYW0gYWZyYWlkIEkgaGF2ZSB0byBzYXkgdGhhdCB5
b3VyIHBhdGNoIHN0b3BzIGluIHRoZSBtaWRkbGUgb2YgdGhlIGpvdXJuZXkuDQoNClRoYW5rIHlv
dSBmb3IgdGhlIGZlZWRiYWNrISBZb3UgbWFkZSBhIHZhbGlkIHBvaW50Lg0KDQpUaGlzIGN1cnJl
bnQgcGF0Y2ggZm9jdXNlcyBzcGVjaWZpY2FsbHkgb24gcmVwbGFjaW5nIHNzY2FuZigpIHdpdGgg
a3N0cnRvdWludCgpIA0KZm9yIHRoZSBzZWN1cml0eSBhbmQgcm9idXN0bmVzcyBiZW5lZml0cywg
YnV0IEkgYWdyZWUgdGhhdCB0aGUgYm91bmRzIGNoZWNraW5nIA0KcGF0dGVybiBkZXNlcnZlcyBp
dHMgb3duIG9wdGltaXphdGlvbi4NCg0KSSdsbCBwcmVwYXJlIGEgc2VwYXJhdGUgZm9sbG93LXVw
IHBhdGNoIHRoYXQgaW50cm9kdWNlcyBhIGhlbHBlciBmdW5jdGlvbiB0byANCmVsaW1pbmF0ZSB0
aGUgY29kZSBkdXBsaWNhdGlvbiB5b3UndmUgaWRlbnRpZmllZC4gVGhpcyB3b3VsZCBtYWtlIHRo
ZSBjb2RlIA0KbXVjaCBjbGVhbmVyIGFuZCBtb3JlIG1haW50YWluYWJsZS4NCg0KQ2FuIEkgcHJl
cGFyZSBhIHNlcGFyYXRlIHBhdGNoIA0Kd2hlcmUgdGhpcyBzc2NhbmYgcmVwbGFjZW1lbnQgZ29l
cyBmaXJzdCwgZm9sbG93ZWQgYnkgdGhlIGJvdW5kcyANCmNoZWNraW5nIGNvbnNvbGlkYXRpb24/
DQoNCkJlc3QgcmVnYXJkcywNCkthdXNobGVuZHJhIEt1bWFyDQo=

