Return-Path: <linux-pm+bounces-38591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2DCC85150
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0053B347E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A030E83D;
	Tue, 25 Nov 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGXouJFq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5233019A2
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075901; cv=fail; b=GmTmyaX+LYJqIdJe+yPO1B13fQT/jAfMk9RB7ErZLArk833MM+p8mf/3VMMxXhqKL5PU/6qrHSvTqpN46mDlK704jbEs+g3iOsgpB2fcZc5LJ7R6nJzlrNGX1sd82+Qjgd1jCbVlBvJNbrkuAqgG09GxG4+r7ohXcWF/Ebu4EHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075901; c=relaxed/simple;
	bh=9Z4+TJmUQDi0aVk6Bd+qI+uM+27hQI+t8r8xXdZXQII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ntK/I7w9nCvrH+40K8+jaVDnK4NBu8j89fVa7tEEk5zzN0niD/ePN5T3jUDOhzGQepDpgowju5QA80j0w86Ol32JCfD/FdFVobfyCi0VpGAjUS/Vd7oWLfeu5nqsTh0+6V2NicA1vUn3kB3O9BzwmmxDjgueAU2LisLI9tuE7tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGXouJFq; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764075900; x=1795611900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Z4+TJmUQDi0aVk6Bd+qI+uM+27hQI+t8r8xXdZXQII=;
  b=VGXouJFqZ10TW3Hc8YqXbOQ0ZN5wnnGvOTQqfXV+6J6WE89P/9ltrSrP
   RFUAVKj95m300+khAeRBfTpLMP1w9u6cWXGred9aYBTnxWOVSuYLmpcqG
   UxoADy0YXUbcsffUBs9TJxhY8S65+c4+WHOH1cCK2R+wP9e5mnzS2+GuV
   R4vtqTA2bn4Ek3IHd9hz4pTAyFEBJ8TjnHuTrl37ZVoxVvL/0+T74VxK4
   dAoRcxCMu/xVR3HpPl5ifUW7FPkePKDO/gB4rgCEOPGCqxAMofqmJWqir
   bToCM0oJCjXilYkoNddrJgSr0a8lxOOypA9OTem8UJnU+/VzDQCk7Ep9J
   g==;
X-CSE-ConnectionGUID: vhkwRmzvQQyPfSPSpfBSeQ==
X-CSE-MsgGUID: zUUQquMCTlS24bCTPVG4Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="66038064"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="66038064"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 05:04:59 -0800
X-CSE-ConnectionGUID: zTa6r1y4Q9+6sB8wT7zQ3w==
X-CSE-MsgGUID: ykfdKZsrQAe0xYD9s0kg+Q==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 05:04:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 05:04:58 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 05:04:58 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 05:04:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRsPrO4j9inqMmtBhQgnjuxlodfbICt51UZTxum1C0iw3YwAhYe9VoXpso9SNzAE1RXPIDltEWVHQGNxTBaVemGOxYiFVuc0G0GiO2OS2LhlD87p2oPrIzRR6em8qBufRz4VGek2m/iBF/85nBw1vRZlow/7WRxR3aTmCFpLj8X1ycCNAyoCntkBVQnUxeBEXBTA/XWuoJCOtIvWxX3uR0CHm8Ds4Dm5KYRC60SrkLdrlrIjOb1W0MNvFK0EO5Y0njl88lYWCspCBS4nNguaYTLZVm5PKBjbgzH3N1/SjCLpE5sx93r42JpWSyfcDbAPROOt7FUG6n/f0vsYsS7nGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z4+TJmUQDi0aVk6Bd+qI+uM+27hQI+t8r8xXdZXQII=;
 b=Tlq6lDRNpluqJDYrWsbM3ih1vkduQRTg2KN8T6wQgqNLljSM6GHjNxIPgqrLPZts9IHZF3MFpQeG+9v2VRm4w/V3CyE3zk7To2qynJEpFd1HwpaNuRS71Z0YkIenwmciOW/7KsWNLa240s6UXudf1kSUXvJhmR/vNj0pn/jkgbbM71HDVX7PWy48f6FpjMgUYSv5SePzJofL3+IDtI2i6EGFbgqm/iza0LOjgOE8lDzk+Crg7K7h6oEyoqtFu3JW+IvvVMp8gyx524zfPb636CA9AIQXEXlPx4yoMvLtHfP4LD49jP+qzPAHq30XrFTt9lOji85SGxWsc/Iix9VOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 13:04:56 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 13:04:56 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: schedutil: Fix tunables_hook cleanup on init
 failure
Thread-Topic: [PATCH] cpufreq: schedutil: Fix tunables_hook cleanup on init
 failure
Thread-Index: AQHcXgnsIoBPibeWREOSDJ87Hw3w7rUDWbDA
Date: Tue, 25 Nov 2025 13:04:56 +0000
Message-ID: <LV3PR11MB87686D49A69727A16D913D60F5D1A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251125105453.471445-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0gfcwg1+o5-H5tQVd=xM=D1Gufyzdk-WeD4Vmyz_pstCw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gfcwg1+o5-H5tQVd=xM=D1Gufyzdk-WeD4Vmyz_pstCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|MN0PR11MB6277:EE_
x-ms-office365-filtering-correlation-id: cddae94d-3c01-4476-3ee3-08de2c233b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U0g3b05WSDRHOXhaZTYraDArayt4NWVsZ1FuY3BhNkxqTTZCbVRSM20wZks2?=
 =?utf-8?B?R3dWZXZ2VFZqZExZNzhOQ1BzVGpaR1Z5aGFzNVNGUXVOdVcvR2hGdUg1Qno5?=
 =?utf-8?B?a252M01FNWE1ODA5bTZRTjlVc0hWRkM4MHRjbHpGL2FQb3d6UkNrcjRuZjFr?=
 =?utf-8?B?KzdFOUlmaU9LeG1ydStlbGVkbGx2TU56V2NaVE5IcG9zenJTOERRVTVDbWlm?=
 =?utf-8?B?SmdaYzJYNmpQV1JBdis5dFpCSFh1dHF2b0NwWk1mczYrck5yZWc5YUFCWGMz?=
 =?utf-8?B?dStJMUlvOFdieGFQODd1SllRRkJxdktzdTVpVXFBSkxJc01kVTI0eDFJRTVk?=
 =?utf-8?B?dmZHWE14ZjBTNEJUOFlTWkNSWDdyNFUwUjJMb1paNTNsMVc2M0ZNTDl6bm42?=
 =?utf-8?B?c0lEaUtSZHBOM1I4ajNQRVRvVkswdFdZZmRVTkxMSUR0NmRseXE0QUVvQ1do?=
 =?utf-8?B?alpLQjdiTU5jcStDNjhGYWFva2tDeTlBc2VYZUF5NFZNT0RSbnFVYjFSekR0?=
 =?utf-8?B?bkMyQWVPNStHUXFueXIrb1VMUmJ3NzExQW8zQUtYWWxLV0xHT01zRlQ0WFl6?=
 =?utf-8?B?RTZPRy84TWs5QlA4K2tmd3pxK015S000cEhPZ1E0TmdNK3NBQVE5ZFRUSFpP?=
 =?utf-8?B?cWp0N3ZXWDhSMUlYQW12SkFtS0Q3QjE1cWNKUmVLaU8wNGpYalNxckNPQkFr?=
 =?utf-8?B?WW5MT0lhSGdybVVDZVdnL0RXUkV4cDVVLy9SelpWTjI4SFpIRmZTRXNkallT?=
 =?utf-8?B?TkRFUS9EYWIwNHVxOHhWSEd2dGZVeVpaRGRmVnNPaXAwMExCLzhIQVRWTU5O?=
 =?utf-8?B?aDZMTlpBK2RxV2dzbUE5YXRxU1RGZExqTDk3eCtRY0M1dC9UbitwdTU2Vk83?=
 =?utf-8?B?TUcrcWdNdVhMd1YwUXc1ckE1N3J3eWZZN0N5eFNRRmhGMjNVUlcyR0dtRXhB?=
 =?utf-8?B?bCtMckdaNXBqejQvQXlZWTFiSWMvV3ZWNmp4U3BWam5VOFlmMjJtSVNMYU1a?=
 =?utf-8?B?Nk04NWtaRnEyWjU4Y1o5Zm9oekNZTXhtS01wODBSYzRCakV0QzlxcUVramJL?=
 =?utf-8?B?dDZzUzZZWlVxV0w0WjVpUEhCMnN5M3BZOXR0bTJtRllrSzdSclp6TjlZZTlz?=
 =?utf-8?B?Z3BiR0tXYjRQSnBFeUlWbkNEV1EzVFNwdmxqODBYQjIzUTRQRkFMWXkvSEVH?=
 =?utf-8?B?TTJ1NXV6eFIzL0RJOTh3alBmWU8rNXB3a1lqUGQ2N2FicU5TMHBDejdESC9a?=
 =?utf-8?B?OEZuZGdFMXovZ0pxSHgwY3hoS0JXemlWT1FkaDlNZ2h4Zno4cFh6THYvalp6?=
 =?utf-8?B?emVrbWZzWitCUWlOaTVvN0F1YW0wTVM5QUp3NU9MOTVLck9TTWdNWnlvWVBR?=
 =?utf-8?B?TjBPWnpHbkgxOVIwUnZTbzlHYjZEclo4NmE5V253SmgzRXUwZWM4YUNCT3A1?=
 =?utf-8?B?MFNuMmNESllDdVQzSXQ4cEc3UzRVYXA0dW9aOFlhSU1tUXNpb215bmZEaUcr?=
 =?utf-8?B?SUZwR1pxeENHbGMvTWtzR25BaXY2NWkxc01GUHZkVXRMNHdld3NoUjZtQWJk?=
 =?utf-8?B?ak82REU3MGErMWxJOUtNYnpyckYrdGZkTDVYTjZDTytaMUlsVTEvaEhobkxv?=
 =?utf-8?B?SzRPTXhQcm5CNXp6UWp5WUZlQU5kWnBkcVFiOU5WRytEcGI3a3M3d0QxVlQr?=
 =?utf-8?B?V21NY2k3VkVIV0tLaERxckhXRzFZaGxIOWlUclVtVjZKNXlKek02K2F4UGVU?=
 =?utf-8?B?Ry9qN1FwQWdYZTZ4QlZVdG9UQ05xa1RvVi9RZzBHbEZqQ3pxSFZnZzBRdXBw?=
 =?utf-8?B?emdJQXEyY1JqV0Qxd1I3UFpEenkvMjREcnl5cEovTHUrZCtDRTlTQmQ4d2lt?=
 =?utf-8?B?TkhDQzh5K1hHZzdudERXL0RwQVlPMGQxa2phR2lnK0ZndXhpbWlVMnZHazBi?=
 =?utf-8?B?TWkveVFMK2lnelNWVDlxOFlZRHpjZjIyVldoUTM3bGJwekhncWsyTXNQNVhG?=
 =?utf-8?B?ZjJJRnBISUdXTHpUYlFCb0JpaEhpSGY2Njg5RFpFa3phay9EYy9QeFpGUFdS?=
 =?utf-8?Q?/zGa1s?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0loUVZGVUpSb2dxdzlKRXkrQ2wzaUs3enlJYnZhbThpOXhOOEVoU3l4emJI?=
 =?utf-8?B?elNkTDhIYm1GS09qdGVjM2FmNEZNOUZyVFczY05qaWM0WDYrbnl4KzJSZWx5?=
 =?utf-8?B?eE9JcVZLdzdub3FyZER1R09jNHozc2lYWm0rdzUzLzNIWEZBYW0vYllJaW8z?=
 =?utf-8?B?WDZNUmRGYjFxeVpkbW5BM3lzMFJpbVFtMnZQU1B3STNkM2FEMXlvOWM1NGda?=
 =?utf-8?B?L3Zrc1krTGp4MW9PT2U2aFU1Y0FrUGJxWGlUbFMwTVphc1ZzNGwva1dVUXJX?=
 =?utf-8?B?ZVl3UWZGVjE2KzJ1b09vUW55ZTJqSG50MGVlMGp3dmdlRGtaaktaUERsU2pN?=
 =?utf-8?B?TWk2L0hyZVJNNmVBUEJEMlViYnNodnJLZmhIYTVaOHZwckx6akhqK3p4eWI3?=
 =?utf-8?B?TFlyWnNFUTBsZlhCb1gvclVpU2NCeTd0RnBFcWcyYi8yOHdTd3NWbC9HV0dn?=
 =?utf-8?B?UmFkS3FsbSt5WklsZ3lqWDd3K1VKeUJ2djAzNlFQVUI2bXFqQXVMWFlIUmd1?=
 =?utf-8?B?ZnNiYjhENStLUXpVM1pUeSs0Tm15RUZsYldYNmxyUGszZUhrVzdJT0dZWXpM?=
 =?utf-8?B?SjA5MTUzS2N0ZlJxNElpTVNLYXVaWEpFZGFwd2VIeHYwM3JJMUpBOExrN3gv?=
 =?utf-8?B?RGkxVjFGQ0Nsb04yUXl2YUFsVGRVSUIzZmZkMTRGUFlrdTdweUxBWk5nK0xj?=
 =?utf-8?B?OTRZMHRzejJjc1lXRGZvYlRIdVpoK01rT0ZFSk82aEdEdHA0OGdIdytEOThm?=
 =?utf-8?B?VmNLNVU3MDhtblFzeURaUFZyN2RFTzY0V0wwblRBYkxyNEVzVVMwd3F4Vlgx?=
 =?utf-8?B?VytOdmhhRStvb2VmVERNOUFmNWlrbU9YNGhNVUY4OUtMRTNtbk9VTmFvOHhy?=
 =?utf-8?B?WnU3U0N6SGVReUhBZUNnVEZmN0xsZnBFNHJEVG9iMktiQlZ2aytTZUR0T09V?=
 =?utf-8?B?UG1XS2l5YUNFYU9LMVJMa2E5bm12TXgrcVpSeUgwa0ZPUWZrc2V2dGZUeFVo?=
 =?utf-8?B?U2ZYcmliWlVaUHdwZ0crTEcxNEFEL2VyZ3JCYnU5cGtUUlVRTHFyS3Zsa0N1?=
 =?utf-8?B?eHdtaExIY29MY2xtbW0vU3JVOThZRFRpRFhNSnREV283ekd6aDRXRUl2ZWFk?=
 =?utf-8?B?dEZEQjd1cFJwTmNoUlNBTWVubkRZUWROejUrUEhERUQvUUJpMEhHZFAwbEgy?=
 =?utf-8?B?c0N2d1lMUk1iV1RzOGlWWG0zVzE3clZtRG43M20yZGkwemdta2lhWXBSWjc1?=
 =?utf-8?B?L2YxbFpVVXdjQWh5UURnYVVFYlA2cjNFUkNFREZNbjZRMk5pdzdHNGFnTG0x?=
 =?utf-8?B?ODF1SnorTmpvTGlMQ3B3N2tScWtFQ0ZiRzhUWFk3ZGxCMmR3c3pUVGhmTHg2?=
 =?utf-8?B?UHpQMFBzdXlzRmcvNXZ5aHNDRFNJYXZOM0x3S1d0RE1CS2l3T3NSOUhzeW5M?=
 =?utf-8?B?RmlONUE4Z3B4aTgzMDlhYTN3RDExdUpNWUo5TGlHV0FIamdKZ3I5RzNWdlNu?=
 =?utf-8?B?YVNGbGhqUGhjS2w5V21tODE2TzlqdTlubzlTUHd5eWlMSlFhZnYzMGtjNTZX?=
 =?utf-8?B?dXhOUmtUU05xK25iZ1BkNy9QbnpjR2diZUlOSVRuOWJmMW9NeGNnWlBObEhk?=
 =?utf-8?B?L2F5Tm1DQVhOUmkyNExXZVBZOHdiYkQyOCtvenMxTmNaM3VVbnRmcTdNOHY0?=
 =?utf-8?B?ZXpHM3U0aVFsakdYWjF1aUJuTGEwMjg4QUhLaFAyaldaazVGK1I0cXRSSVF4?=
 =?utf-8?B?RkZ3Ni93dEd0dHpjWWhsN2ZuMWVpV25ITFNXMFZVS1dwV1JuejRtdW9xendZ?=
 =?utf-8?B?VDllOHFqZ3BZR2ZFay95N3FhdFlsOGVad2xkVmJWMnBEd3cxMHNKNEY4Nm1L?=
 =?utf-8?B?TTZOK3FYRUJkU3RqaXQyb0dlQXRmbUR5cmd6MTRIZ2poRzd4SGFKT3ZuTm9m?=
 =?utf-8?B?cEdsaFQ5S0kxdkVlMUZVVS92dm16V1BKS2NXdjZCUkZ0dDAvb0dIbWFsNUJy?=
 =?utf-8?B?MDB0VS8zajhDL1BtV2EydmI0Q09hM2F0TDJ5T2ppMGhFVlNRQzRaUXp3L3VX?=
 =?utf-8?B?OHp2c1BOTmNja1lteEhSMjhGUW41SFZPZU9PZEhHM2NEbFNtRjJ4bkc2ZjI3?=
 =?utf-8?B?bmtpeTNVbHZSS3FGZmtkeWJ2THNIWVorTTVScnJiU3ZHRlpOQS9GL3ZJN2hO?=
 =?utf-8?B?TlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cddae94d-3c01-4476-3ee3-08de2c233b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 13:04:56.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3v0MgZR9hnaL/ZJyyGAJ2wT2gvjU7UXZ2QEYXy75KUrMoFemx7jKYGmgNLPwjcWqfu0LkA2PvoIGZi3gK2+lctiPB1W2z4bcm4eOuntp6A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
X-OriginatorOrg: intel.com

SGkgUmFmYWVsLA0KDQpPbiAxMS8yNS8yNSBYWDpYWCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+IE9uIFR1ZSwgTm92IDI1LCAyMDI1IGF0IDExOjU3IEFNIEthdXNobGVuZHJhIEt1bWFyIA0K
PiA8a2F1c2hsZW5kcmEua3VtYXJAaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiBJZiBzdWdvdl9p
bml0KCkgZmFpbHMgYWZ0ZXIgcmVnaXN0ZXJpbmcgdGhlIHR1bmFibGVzX2hvb2sgdG8gdGhlIA0K
Pj4gZ2xvYmFsIGxpc3QsIHRoZSBob29rIGlzIG5vdCByZW1vdmVkIGJlZm9yZSBmcmVlaW5nIHRo
ZSB0dW5hYmxlcyANCj4+IHN0cnVjdHVyZSB2aWEga29iamVjdF9wdXQoKS4gVGhpcyBsZWF2ZXMg
YSBkYW5nbGluZyBsaXN0IGVudHJ5IA0KPj4gcG9pbnRpbmcgdG8gZnJlZWQgbWVtb3J5Lg0KPiAN
Cj4gRXhjZXB0IHRoYXQgc3Vnb3ZfaW5pdCgpIGNhbm5vdCBmYWlsIGFmdGVyIGNhbGxpbmcgZ292
X2F0dHJfc2V0X2dldCgpLCANCj4gc28gaG93IGNhbiBpdCBnZXQgdG8gdGhlIGVycm9yIHBhdGgg
d2l0aCB0dW5hYmxlc19ob29rIGluIHRoZSBsaXN0IGluIA0KPiB0aGUgZmlyc3QgcGxhY2U/DQoN
Cj4gDQo+PiBSZW1vdmUgdGhlIGhvb2sgZnJvbSB0aGUgbGlzdCBpbiB0aGUgZXJyb3IgcGF0aCB0
byBwcmV2ZW50IHRoaXMuDQo+IA0KPiBUaGVyZSBpcyBubyBidWcgdG8gZml4IGhlcmUgQUZBSUNT
Lg0KDQpJbiBmdW5jdGlvbiBzdWdvdl90dW5hYmxlc19hbGxvYygpIHR1bmFibGVzX2hvb2sgaXMg
Z2V0dGluZyBhZGRlZC4NCnR1bmFibGVzID0gc3Vnb3ZfdHVuYWJsZXNfYWxsb2Moc2dfcG9saWN5
KTsNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpSZWdhcmRzLA0KS2F1c2hsZW5kcmENCg==

