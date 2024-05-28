Return-Path: <linux-pm+bounces-8215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32FD8D138F
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 06:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63EA1C21F74
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 04:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CF318EA2;
	Tue, 28 May 2024 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YU+i0NTo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0517E8FB
	for <linux-pm@vger.kernel.org>; Tue, 28 May 2024 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872362; cv=fail; b=lp5GsM1ZuY5tPnF+DKKwK7A6AXYgVZGaijVh8L4doXfQji7SlFLqr4qLtWLo135SRLnDN50BKombM+jTy4a4Bt8ylm8WGJa00qcZdoeD5M0eMxjAhHDWKDLUPx1DuDFPy1H+D2UayKOLyoaS/Rbr13tENGw+8C9MWmM+mq8/VHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872362; c=relaxed/simple;
	bh=/uPBtqOlnah3IIfPkty+f2AJTGdoiqhKcgDfGMhNGN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+7KCvMG6+I06vvXIMRg/j/c5jcNv1v9yJZtc3y6DRX/a8lCRiSe4PI/rHC5WZmLOD9OsDP70qekTc5jPVqLc5Z6VzWLEcr4ZaS0jsgS4o4yPLXLoQZOn6rHXXPxiX40HcYY6DGQ/1nnQDeM1GXans5orf1EudcPt0DJSO2drPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YU+i0NTo; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716872359; x=1748408359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/uPBtqOlnah3IIfPkty+f2AJTGdoiqhKcgDfGMhNGN0=;
  b=YU+i0NToSVaFscG8DhvXziUvO+JyDSqaopwkddw1I6/wJUqhajr3BBlM
   nItUdmNsBi9tMZZKWI4PbK5eE6j03tBeRbh0CXQ7qzMqk9v9GG1yiKihd
   C4A6SoSYIKyHlKAvdIciYo30Mz8hnHDirn6frBhL3BbWfF0yo/qU4fOuT
   jU4+y5QfUc/LIayHK9fk/m4FHfsGWPZlVEzXfnvJELRE0yeELuKcTdVg4
   TPXt7QBweQLph210C92ecbVktoG25j3hBDsSOU69e5CnoI33Z56/T9iEa
   qh89YHkgh6kf8dwJmQfvB45PVBGc6/YLNEIkmGDUw+PfbcalvHKii986W
   Q==;
X-CSE-ConnectionGUID: gHBqiPgVRGieufXsR76jSw==
X-CSE-MsgGUID: DCHtJEm/TuaPUpouDNvw1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24321382"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="24321382"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:59:19 -0700
X-CSE-ConnectionGUID: bybF+EtMR4amlcPdnnXLtg==
X-CSE-MsgGUID: 9T4wy0DYQG+B+WiJtLtAWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="65759771"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 21:59:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 21:59:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 21:59:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 21:59:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 21:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnpdiX33+iiWwGl7iuETK5xk9pZ293cdPI6DU1/cmFqOJMH/dWIINZnOfyBL2zeFfjqUtwnct4LmdN8NlrVa8ro5WoFLthN/lp03QNVVSXNTrfPD0VUyHK/oC1B+UQg+NZMsm3Kr4yHqu4aHmTgvpy6d12DgW7FHB86YJ/eX2aL9ErD5KojCEl7nSoB+LVBUkQ3l2KiOm0HKdNIkHK+YzftvA36CLueYwBPOrz9L2QZ2g64Ai22/+KNMTrC7tXGZpJKllQ1aQnPFUOSRuzEZjbVN3koHj6kY8JfREZ6PPr5jTo/a/dbUqy3OeqiW6ln9nWmqCI768NvBuMhkSxWMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uPBtqOlnah3IIfPkty+f2AJTGdoiqhKcgDfGMhNGN0=;
 b=EUNcjkpPa/jePjPBOm0jna8YmuU2+S4yH/8XElOb1X82JLurUYATGra1Zjae0c0TB19ek2keWYBpsJCqkhEVHgVfJvFcqGSuaBwQMB7gUWyQuWryAxso5LKCqJogmitkz/fhODv+S090rn3De5m/s/+NXZeHjMMQrllyZAZdxObj5R5VnXE4BaygXZ5c/kOwmrnZ0pbRAjul+fUW7a15xPrrlYaP/TItWCmGRC80saL8PTVE/h/6NRAPJA15goa37QUiMp9ymsy0TftWAxSv40ThJVkXPHHLT2Icn9pZeW2INDeXGklJdbF1YKUXlxliCFuDiq+kc1p0nbtdJ9ezPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 04:59:16 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 04:59:16 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "Pandruvada,
 Srinivas" <srinivas.pandruvada@intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: powercap ABI clarification
Thread-Topic: powercap ABI clarification
Thread-Index: AQHasDVGuh1xQBglm0uP9v8YcHNYRrGrHfUAgAAcuICAANtOAA==
Date: Tue, 28 May 2024 04:59:16 +0000
Message-ID: <5cb71aef90ebd2d613f0643446b8a1db049f4d50.camel@intel.com>
References: <59e5a949-ef20-4f11-a0a7-247c457f1dd3@linaro.org>
	 <9c97e4f8549744b1e2464a3b632f0716514ff55c.camel@intel.com>
	 <084eb643-f410-4e66-9561-4dcf5924dab7@linaro.org>
In-Reply-To: <084eb643-f410-4e66-9561-4dcf5924dab7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CO1PR11MB4769:EE_
x-ms-office365-filtering-correlation-id: fde5c70c-72cc-4a36-69d0-08dc7ed2ed17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?U0dOcVJTNE10eE1POWdKejc1V2E4WEJNOUJGZ2V3b0Z6eWZsanNrcG9kc3dY?=
 =?utf-8?B?akdZaVdYWUlaTmxaVTZHdVFNREVNc3pCWUdxeGhXbldobTBISDhYclhpaTls?=
 =?utf-8?B?MnpsVnJXRC9tc09uSUdhbXgxZUZSTGxXOWlyTVJNSWgyYU1lNFFBdkk3UlFC?=
 =?utf-8?B?biszVUxwT3dYWE13bldBcHJUYXcwZ2loQ1packNxb3J3OC9SSmVydUdwck9P?=
 =?utf-8?B?MXJ6QzJIUW1qUGFoYTVTejBXMk14dnArRnRVRzdQUHFMRndWUGJUQ3dsVWZF?=
 =?utf-8?B?cmxuM0ZPWXBhaHF0WW5YZEFURkdDSTl1QnNWc2p4NUptc201QUozd08yWFlM?=
 =?utf-8?B?NXZvRHVEN0VHKzBrSXoveVJBYk85YWlkMWVpWEpiYUZZaWhVRngwQ3Nyci9x?=
 =?utf-8?B?RkRVNlRaNUk5Vi9JdnAySUc4am5PVGJpLzh5K0tpRi9PaTNuNHVyem1qaTRH?=
 =?utf-8?B?L0RMK1BoT2xvcWY4WTU2OHYxeitRK0g5SGhRVmt2ZHg1ODhXMTdtNnpacjI4?=
 =?utf-8?B?SnJFelNOY2E0OS85R3BGWDBsdGI1amdwTVZac25jOUJXLzdLczJRc0ZMUGZK?=
 =?utf-8?B?aUJ5bFBxeFZvZVUwdm1rRGgrVmJ1WWNQWjIwS3daMmxhV2ZURmMxRnNJbUZv?=
 =?utf-8?B?MUtDVXBNSkZVNnBFN2hUZG5hTGhMa2ZXS1gvZ3ppbmJpSVZWa3ArSFRuNGd4?=
 =?utf-8?B?UWxtZ0Q3N3B2S1c2aXRwaGt3a0tCWTI1STVCaUpmMTAzMUtwVVpIUDFuTEZw?=
 =?utf-8?B?eFBHQ2Q4Q0VoYTJqb3RQRUduK2xUVFFyMlVucFpyTWhSQnpRL1hjTWRmelhN?=
 =?utf-8?B?VUN5Y21rckoxNHZHSFB3VlVYMlhWWXRFSzFyNDJQU25xRFRxUnd4aXRVbkJ0?=
 =?utf-8?B?aytmTDdaUmhib0psZnVYQXpZSXZ0NUhlZmFwQk9CMjRnYndUdHJ5OTF4dlV3?=
 =?utf-8?B?MnN1ZTNTU1ZpdWh2b1lhdFpkMUdNM1MyQktWSXBwUlFIYW9qMHZjUnZrWlVD?=
 =?utf-8?B?eWU0dHBxODBqU2xXeUw1YzRVZEdVaTJrVmdVTVpKK2hHUEZITlorb01rZ0JG?=
 =?utf-8?B?YTRtWXJGbitpdFFPQWdHVkxNR21LcVFFcktjK1RIbUxyQUlaVEV5NXpGbDlp?=
 =?utf-8?B?WVpONzVmVy9OY2g5aGR2TW9VY2pNVldieVo5ei9MR0R6dHViRm84MTNnNitu?=
 =?utf-8?B?NHE5VUcxVjNzT2VtRzYwVmpaRHI0aURTa2pERGZQa0JXb2RRRGF4VDJRY0hs?=
 =?utf-8?B?elpsdzNoZ2kxc25wUDkybXJETFNMSnJiTEFRRXp0TlJaQktWSlBJLy95ME4w?=
 =?utf-8?B?WXlIUERlNXdBai9PaUxoSjcrdU5sY2dGQUE2VnBJVTkrdElyOWM2bUFueFJY?=
 =?utf-8?B?UFA0T21qSTdCajJZb25nb1JkYTdLakFmZW9INUFiQW1keWViVWRuLzZiTzlE?=
 =?utf-8?B?NTNZNGRTQ1VQZnpvRGxZYm9UYWFSQkxZbHYrRU03dy9ocDFrc2s5aGpxdjEz?=
 =?utf-8?B?cFNvbHYrMmFvM2RBaHpJdnNKNzJvVlp6T2hvSkRHR05Qa2M4TEdSMEs5UnNG?=
 =?utf-8?B?UGFyeTd4dGgwamdzSXFQU3RpYndQZXV5cU9vSCtESjVTRjJPZytRV2JHTk5j?=
 =?utf-8?B?NFJJNHhQVHpPcWJDZENoK0hMQjdqRnhWdHE1bXhqRDRQZ0svV1BmZ2hsTERh?=
 =?utf-8?B?OHNKZ3hOay9KOVkvZW9nS2lWK1d0ZnBHdUlVL2dUWDlja2RlNTlYNk51dlQ2?=
 =?utf-8?B?Y1RmL0hmWXd0a01QVlVIaUdMOUw3clJ1Y2lmVG01ZUZYT0F2V0o4SUxIb3Qv?=
 =?utf-8?B?aFVvMXlQM3FEa1dCRHFmdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnlKNitBZ2ZtNEN0ckJYeWg3eExvTkVTWlZudm1aVnl3MEswSFhxODQvcjI5?=
 =?utf-8?B?WmkwWEt6ckl6a2dHa0lIV0pVUXdSY0UyL05icEZoaXJDQ2NmZ21TcHp1bFl5?=
 =?utf-8?B?UWpCTDBmQ2h0TmFybGc5MHJjdnE2SENncG5oUW9tMUtoNWxwWGRIWUhGRXdm?=
 =?utf-8?B?MEJERFA1Y3BTS3Z4ZEw1ZkJCTHlnWFJzTDA3MWtNZWRQKzNOUGt3d3hzQWFB?=
 =?utf-8?B?Zk1sRmNkQmVIaXN4aVFlektVTnpYK0lrYnZkd0lzN1BoaWhLR0p6N0JGTUFY?=
 =?utf-8?B?c3R6RHMydm8vdTBjbkt2TE1ucTF3NHFmd1hrOW1ieXc1V3o2RytFODRRRnhU?=
 =?utf-8?B?d0ZDUGVkYlpWV1NvTEtZTkJnVzBuWXVla0RDbUFrdlhJeTlOZWM2SEdiTjln?=
 =?utf-8?B?eWhhTVExTFhLNGxCNUZyd3hxSit2T2w3RVhDUkJudzdlTElDeVJEZHdqNEx0?=
 =?utf-8?B?UUxtVXVBd0cySXdIcWxEVnJINmRjU2NDNmZ2Vmd1djBXWFhPL0sxQUc1SExn?=
 =?utf-8?B?Zlh5WFV0ZEhTMEV0dVBxWm56NWZOeFpWNVlmWDEwckpMYURMWHFxYmVpMkgz?=
 =?utf-8?B?T3hSVmcrOVBxY0l4N0J0SkpvNzd2Z3VselJiWmIyNDV1ZGpOajBtNGgrYTAv?=
 =?utf-8?B?S3hOaDF0SmtYZ2VxT1ZnaEhaSmw0dzFNbnNpaEtBZWlBWUVOeGtSeGJpSERp?=
 =?utf-8?B?TmVhVXFYdFZNUFBuK2lqM3IyL3ZBcGxaMHd5WTg0cyszSjZjcURWR3gyK0lT?=
 =?utf-8?B?R3M2Sm5NM2NFNUhGVld0NmhnZTZubkZHeG93OXFiSVg5THIxR3JQUGtMdjNs?=
 =?utf-8?B?eHZvaXhRckF5S3BuQ3JVSEFzTVNua0xwamlPNXZYZ1EwcjN2T2F4cU5TNi9Y?=
 =?utf-8?B?VTRUQSttQlJlVlBZVjVMK0t1RTVKdDBzYk5UWHE5RTlFNmc2bkk0dWZhaXVY?=
 =?utf-8?B?ZTlSbC9laXg0ZmprMkZYcVFVZFhKenZnL1hjUG9NSk9CS2ZUMWtMWXJlZExJ?=
 =?utf-8?B?eXhvTGtaMFJ3d2dvYzIxY2l2dmtYaTlNaFQzTWxVSnVaSTh0U1NBZjFyVDVx?=
 =?utf-8?B?bG0yQUptRUJyTmVSVEFQbUpnOVdndFppbGJQbFZTSnZOQ2VwMGhkMnRVUGph?=
 =?utf-8?B?TkY1ZzN3dEdzTDlNenNpRTBXdS82ODdqV2pxSXN2cHhMajZhSEJIaStFQ2VN?=
 =?utf-8?B?MUNYMUxuZEhWRUp0YndWb3NkQVVJUFU0eU5wRGpsdzdnTVdtWmhEYlpkU3FJ?=
 =?utf-8?B?WjhaTC9hYTRGU2Rnb05NM0lsT1BNZ2gxOEorZHlCdWxraXdkaXF0RWJPMytI?=
 =?utf-8?B?MVVFYm4wYUt6U3poYXdyRHNLU29jQ2JYN3FwQnJJallhUExoT0RrS3h6SDlE?=
 =?utf-8?B?R0V3VVZIS0VobjZJRFpUekYrOTZXL1BzSXJuSkttakhhOWNINmc5cklWTCtw?=
 =?utf-8?B?MG9RZ1UvVEpmUm8rWkptZFkvL2tTaDZMOGQ0OXd3VmMxTDFya0ZYNUYwT3JG?=
 =?utf-8?B?VE02VmlubXBMQ0tqYUo1L2xURm9ab01iQVNEVmdSSXBnTHhZUGNuU2h0bExP?=
 =?utf-8?B?MlRLbVBkVUNOS2lDR3JBSmM3Rk5nYnlPak9ZaG52amJiUFl3c3pVSm5KSkh3?=
 =?utf-8?B?cjBueEFHNm8zQnJ6U2RLeUYvcmJVYlBuSjBYdlBmQmlIWHRVOXJrTXJpcWRO?=
 =?utf-8?B?bXFxWFJOdHhjVm0yTHRmbUpsSWtwTThIZ0Q4UFVjc3A0U3VxYkxrQUJtU0xY?=
 =?utf-8?B?QTRzRGFDV0ZFbnhheXlweUZrL25xb0dDa1A4OXlBMnB4VFpzNFdGWGVJVFVl?=
 =?utf-8?B?WFFmMU1nZjhNalkzM3pCM3pNL2pZSzVlOE9sU2Q2K3M5RmJOQWY4Y2c1ZTZN?=
 =?utf-8?B?cWptZ0xyRVQ5Y0d1Y1NZbHcyRnExdDRhWmpaM2FGQXVGWm9UeVdqWjYwOWhp?=
 =?utf-8?B?L2IwdHZuTGZzaTdMdHAwWmJYTWRmc0h6WTFNT0U0b1lBZVRXNTZOeUpiTFM2?=
 =?utf-8?B?NEJXMklRNFFaUHJhczZ0N2ZzN0ZxRFB0elY3bkhKWmh4M3QveXhrL1Nnd05U?=
 =?utf-8?B?M1JQRkRPSmZjeGdoOC8yT2I4c0lGSGhXMUZYdlFjbk52WkhKT1A3L0xTV05n?=
 =?utf-8?B?cURGSldaTlM1WHlzeWxrMVFaOTgxSGRVZWhYV0YxL0ZkL2xLU1BvcTV6WVY1?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <214B0FB1B7CC4940B721772B78C67279@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde5c70c-72cc-4a36-69d0-08dc7ed2ed17
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 04:59:16.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjyOT0FYCzsqpGWq8aMwtRIldVpe8gglWEUidxqBiVBbAld292A46wJVhs95+mFbFpwsdMFeKm8CPQdOcy6+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDE3OjUwICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMjcvMDUvMjAyNCAxNjoxOSwgWmhhbmcsIFJ1aSB3cm90ZToNCj4gPiBPbiBNb24sIDIw
MjQtMDUtMjcgYXQgMTQ6NTUgKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3RlOg0KPiA+ID4gDQo+
ID4gPiBIaSBTcmluaXZhcywNCj4gPiA+IA0KPiA+ID4gdGhlIHBvd2VyY2FwIEFCSSBleHBvcnRz
IHNvbWUgY29uc3RyYWludCBmaWxlcy4gRXZlbiBpZiBJIHN1c3BlY3QNCj4gPiA+IHRoZWlyDQo+
ID4gPiBzZW1hbnRpYyBpdCBpcyBub3QgcmVhbGx5IGNsZWFyIGhvdyB0aGV5IHNob3VsZCBiZWhh
dmUuDQo+ID4gPiANCj4gPiA+IMKgwqDCoMKgwqDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAY29uc3Ry
YWludF8wX25hbWUNCj4gPiA+IMKgwqDCoMKgwqDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAY29uc3Ry
YWludF8wX3Bvd2VyX2xpbWl0X3V3DQo+ID4gPiDCoMKgwqDCoMKgwqDCoCDilILCoMKgIOKUnOKU
gOKUgGNvbnN0cmFpbnRfMF90aW1lX3dpbmRvd191cw0KPiA+ID4gwqDCoMKgwqDCoMKgwqAg4pSC
wqDCoCDilJzilIDilIBjb25zdHJhaW50XzFfbmFtZQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqAg4pSC
wqDCoCDilJzilIDilIBjb25zdHJhaW50XzFfcG93ZXJfbGltaXRfdXcNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgIOKUgsKgwqAg4pSc4pSA4pSAY29uc3RyYWludF8xX3RpbWVfd2luZG93X3VzDQo+ID4g
PiANCj4gPiA+IEFyZSB0aGUgY29uc3RyYWludHMgY29udHJvbGxlciBzcGVjaWZpYz8gSSBtZWFu
LCBlYWNoIGNvbnRyb2xsZXINCj4gPiA+IGRlZmluZXMNCj4gPiA+IHRoZWlyIGNvbnN0cmFpbnRz
PyBPciBpcyBpdCBzdXBwb3NlZCB0byBiZWhhdmUgdGhlIHNhbWUgd2F5DQo+ID4gPiB3aGF0ZXZl
cg0KPiA+ID4gdGhlDQo+ID4gPiBjb250cm9sbGVyPw0KPiA+IA0KPiA+IEN1cnJlbnRseSB3ZSBo
YXZlIHRocmVlIGNvbnRyb2xsZXJzLCBNU1IgUkFQTCwgTU1JTyBSQVBMIGFuZCBUUE1JDQo+ID4g
UkFQTC4NCj4gPiBUaGV5IGFyZSBhY3R1YWxseSB0aGUgc2FtZSBmZWF0dXJlIChSQVBMKSB2aWEg
ZGlmZmVyZW50IHJlZ2lzdGVyDQo+ID4gSW50ZXJmYWNlcy4NCj4gPiBTbyB0aGVpciBiZWhhdmlv
cnMgYXJlIGNvbnNpc3RlbnQuDQo+IA0KPiBUaGV5IGFyZSBjb25zaXN0ZW50IGJlY2F1c2UgdGhl
eSBhcmUgUkFQTCBiYXNlZA0KDQpyaWdodC4NCg0KPiAgYnV0IHRoZXJlIGFyZSBtb3JlIA0KPiBj
b250cm9sbGVycywgbGlrZSBEVFBNIGFuZCBTQ01JLg0KDQpzbyB5b3Ugd2FudCB0byBkZXBsb3kg
Y29uc3RyYWludHMgc3VwcG9ydCBmb3Igc29tZSBvZiB0aGVzZSBjb250cm9sbGVycw0Kb3IgbWF5
YmUgYSBuZXcgY29udHJvbGxlcj8NCg0KPiANCj4gQXJlIHRoZSBjb25zdHJhaW50cyBzZW1hbnRp
YyBkZWZpbmVkIG9yIGlzIGl0IHVwIHRvIHRoZSBiYWNrZW5kIHRvIA0KPiBkZWNpZGUgdGhlIGJl
aGF2aW9yID8NCj4gDQpJJ3ZlIG5ldmVyIHRob3VnaHQgb2YgdGhpcyBiZWZvcmUuDQpNYXliZSB3
ZSBuZWVkIHRvIHVuZGVyc3RhbmQgdGhlIG5ldyByZXF1aXJlbWVudCBhbmQgc2VlIGlmIHRoZXkn
cmUNCmFsaWduZWQgd2l0aCBjdXJyZW50IGNvbnN0cmFpbnRzIGJlaGF2aW9yLg0KDQo+ID4gPiBJ
cyB0aGUgdGltZSB3aW5kb3cgZ2l2aW5nIHRoZSBkdXJhdGlvbiBvZiB0aGUgcG93ZXJfbGltaXRf
dXcNCj4gPiA+IGNvbnN0cmFpbnQ/DQo+ID4gPiBPciBpcyBpdCBhbiBhdmVyYWdlIHBvd2VyIGR1
cmluZyB0aGlzIHRpbWUgd2luZG93Pw0KPiA+IA0KPiA+IFRoZSBhdmVyYWdlIHBvd2VyIGR1cmlu
ZyB0aGlzIHRpbWUgd2luZG93Lg0KPiA+IFRoZSBjb25zdHJhaW50IGlzIGFsd2F5cyBlZmZlY3Rp
dmUgYWZ0ZXIgd2Ugc2V0IGl0Lg0KPiANCj4gVGhhbmtzIGZvciBjb25maXJtaW5nLg0KPiANCj4g
PiA+IFdoYXQgaXMgdGhlIHB1cnBvc2Ugb2YgbWlufG1heF90aW1lX3dpbmRvd191cz8NCj4gPiAN
Cj4gPiBJdCBpcyB0aGUgdXBwZXIvbG93ZXIgbGltaXQgZm9yIHVzZXJzIHRvIHNldCBhIG1lYW5p
bmdmdWwgdGltZQ0KPiA+IHdpbmRvdy4NCj4gDQo+IEknbSBub3Qgc3VyZSB0byBnZXQgaXQuDQo+
IA0KPiBGb3IgZXhhbXBsZSwgb24gbXkgbGFwdG9wLCB0aGVyZSBpczoNCj4gDQo+IGNvbnN0cmFp
bnRfMF9tYXhfcG93ZXJfdXcgPSAxNTAwMDAwMA0KPiBjb25zdHJhaW50XzBfcG93ZXJfbGltaXRf
dXcgPSAyMDAwMDAwMDANCj4gY29uc3RyYWludF8wX3RpbWVfd2luZG93c191cyA9IDMxOTgxNTY5
DQo+IGNvbnN0cmFpbnRfMF9uYW1lID0gbG9uZ190ZXJtDQo+IA0KPiBUaGVyZSBpcyBubyBjb25z
dHJhaW50XzBfbWF4X3RpbWVfd2luZG93X3VzDQoNCmJlY2F1c2UgdGhlIGJhY2tlbmQgZHJpdmVy
IChSQVBMKSBkb2Vzbid0IGltcGxlbWVudCB0aGUgY2FsbGJhY2tzLg0KDQpCdXQgSSB0aGluayB0
aGVzZSBzeXNmcyBpbnRlcmZhY2VzIGFyZSBkZXNpZ25lZCBmb3IgdGhpcyBwdXJwb3NlLg0KDQo+
IA0KPiBIb3cgdG8gaW50ZXJwcmV0IHRoaXMgY29uc3RyYWludCAwID8NCj4gDQo+IFdoYXQgbWVh
bnMgImxvbmdfdGVybSIgPw0KDQp0aGUgbWVhbmluZyBvZiBlYWNoIGNvbnN0cmFpbnQgaXMgcGVy
IGNvbnRyb2xsZXIuDQoNCk9uIEludGVsIGhhcmR3YXJlLCByYXBsIGRyaXZlciBjb25zdHJhaW50
IDAgaXMgbWFwcGVkIHRvIFJBUEwgUG93ZXINCkxpbXRpIDEuDQoNCiJNU1JfUEtHX1BPV0VSX0xJ
TUlUIGFsbG93cyBhIHNvZnR3YXJlIGFnZW50IHRvIGRlZmluZSBwb3dlciBsaW1pdGF0aW9uDQpm
b3IgdGhlIHBhY2thZ2UgZG9tYWluLiBQb3dlciBsaW1pdGF0aW9uIGlzIGRlZmluZWQgaW4gdGVy
bXMgb2YgYXZlcmFnZQ0KcG93ZXIgdXNhZ2UgKFdhdHRzKSBvdmVyIGEgdGltZSB3aW5kb3cgc3Bl
Y2lmaWVkIGluDQpOU1JfUEtHX1BPV0VSX0xJTUlULg0KVHdvIHBvd2VyIGxpbWl0cyBjYW4gYmUg
c3BlY2lmaWVkLCBjb3JyZXNwb25kaW5nIHRvIHRpbWUgd2luZG93cyBvZg0KZGlmZmVyZW50IHNp
emVzLiBFYWNoIHBvd2VyIGxpbWl0IHByb3ZpZGVzIGluZGUtDQpwZW5kZW50IGNsYW1waW5nIGNv
bnRyb2wgdGhhdCB3b3VsZCBwZXJtaXQgdGhlIHByb2Nlc3NvciBjb3JlcyB0byBnbw0KYmVsb3cg
T1MtcmVxdWVzdGVkIHN0YXRlIHRvIG1lZXQgdGhlIHBvd2VyDQpsaW1pdHMuIg0KDQo+IA0KPiBJ
cyBpdCBwb3NzaWJsZSB0byBnaXZlIGFuIGV4YW1wbGUgPw0KPiANCg0KVGhlIFBMMSBpcyB1c3Vh
bGx5IHRoZSBURFAgbGltaXRhdGlvbi4gV2hlbiB3ZSBzZXQgY29uc3RyYWludCAwLCB0aGUNCnBh
Y2thZ2Ugd2lsbCBub3QgcnVuIGFib3ZlIHRoZSBzcGVjaWZpZWQgcG93ZXIuDQoNCj4gPiA+IENh
biB3ZSBzZXQgc2V2ZXJhbCBjb25zdHJhaW50cyBvciBhcmUgdGhleSBtdXR1YWxseSBleGNsdXNp
dmU/DQo+ID4gDQo+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZXkgY2FuIGJvdGggdGFr
ZSBlZmZlY3QuDQo+ID4gIlR3byBwb3dlciBsaW1pdHMgY2FuIGJlIHNwZWNpZmllZCwgY29ycmVz
cG9uZGluZyB0byB0aW1lIHdpbmRvd3MNCj4gPiBvZg0KPiA+IGRpZmZlcmVudCBzaXplcy4gRWFj
aCBwb3dlciBsaW1pdCBwcm92aWRlcyBpbmRlLQ0KPiA+IHBlbmRlbnQgY2xhbXBpbmcgY29udHJv
bCB0aGF0IHdvdWxkIHBlcm1pdCB0aGUgcHJvY2Vzc29yIGNvcmVzIHRvDQo+ID4gZ28NCj4gPiBi
ZWxvdyBPUy1yZXF1ZXN0ZWQgc3RhdGUgdG8gbWVldCB0aGUgcG93ZXINCj4gPiBsaW1pdHMuIg0K
PiA+IA0KPiA+ID4gDQo+ID4gPiBJcyB0aGVyZSBhbnkgZG9jdW1lbnRhdGlvbiBkZXNjcmliaW5n
IHdpdGggbW9yZSBkZXRhaWxzIHRoZSBBQklzPw0KPiA+ID4gDQo+ID4gSW50ZXJlc3RpbmcsIEkg
anVzdCBmb3VuZCB0aGlzIG9uZSwNCj4gPiBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LWNsYXNzLXBvd2VyY2FwLCBzaG91bGQgd2UgbW92ZSBpdA0KPiA+IHRvDQo+ID4gc3RhYmxlPyBP
dGhlciB0aGFuIHRoYXQsIEkgZG9uJ3Qga25vdy4NCj4gDQo+IFllcywgSSd2ZSBzZWVuIHRoaXMg
ZG9jdW1lbnRhdGlvbiBidXQgaXQgZG9lcyBub3QgcmVhbGx5IGhlbHAuIEl0IA0KPiBkZXNjcmli
ZXMgdGhlIEFCSSBidXQgZmFpbHMgdG8gZ2l2ZSBzb21lIGRldGFpbHMuIE1heSBJIHJlZmVyIHRv
IHRoZSANCj4gUkFQTCBkb2N1bWVudGF0aW9uIHRvIHVuZGVyc3RhbmQgdGhlIHBvd2VyY2FwIGZy
YW1ld29yayA/DQo+IA0KVG8gYmV0dGVyIHVuZGVyc3RhbmQgaG93IFJBUEwgd29ya3MsIHlvdSBj
YW4gZG93bmxvYWQgSW50ZWwgU0RNIGFuZA0KY2hlY2sgdGhpcyBzZWN0aW9uLCAiMTUuMTAgUExB
VEZPUk0gU1BFQ0lGSUMgUE9XRVIgTUFOQUdFTUVOVCBTVVBQT1JUIi4NCg0KVGhhbmtzLA0KcnVp
DQo=

