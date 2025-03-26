Return-Path: <linux-pm+bounces-24510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F6A719EB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AAE188E748
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ADE1C84DE;
	Wed, 26 Mar 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MenhG+Yz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D5A48;
	Wed, 26 Mar 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001478; cv=fail; b=YyAqO1UQ3mRcDgGhjyi2pUgbefMEq7kMAWAl7LPY1sdj3CHwb03RJMyw665OAZB2WlFJ27+pvWhg9ODDvkLTUFgaB6a3hj/XI+VpSDvrmxxDGyiymfLi6KMRMqKmjE3pnPAR1YeBxS9N60yc5LI9nsLP/79Rsvy8BuvhX2YlJSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001478; c=relaxed/simple;
	bh=hGVH28N3y5+ndStXVbIGMnNtT01Zr20KAPCfP8VjEWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wqyo7upKHbc5bGdipYRUs7pPHuvt0pMNG+kcy2QOrtKFB9x8Elkm4szzfaqxTU81CjTKYJzEetXta7h8VgIA2L1tWfCAHMfDsGNdCHERyWkuiDqUSKk8lShPw/S2pGKiYMwREvPH1JdJUudRdgrYCDXkc2L5pQgDdm5qApDFRSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MenhG+Yz; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743001477; x=1774537477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hGVH28N3y5+ndStXVbIGMnNtT01Zr20KAPCfP8VjEWg=;
  b=MenhG+YzoNwLJQOh18xgYDd9XQ9Om2FJJhWqdIRhE/ZpkWSc7iAYYzuF
   eAOzvMEl62nOo4znRPlkG3xogqd2V6DyRcJbjD1paPn5vj+eJklPaCVIC
   fLenRWVZrjkx47OwWgIpeqWT8pQst9J4DRyKMSPAh4j3FXU8NGkmk5UV4
   qFY8Kaa4Fkvh2wgGtOiPBPCzZ93jIqTSi8/r35dsQ9b0fO0w+riW5i6ag
   kWXp57bNk1NqD8BH+GCZzwKq4D0AVY+nB8BZiqON6Kc8t9YrfXDHtVhT2
   jcdZwfk4yEaw+tgNf+jPI1W1qaeUDt2vHn/IYyvo5HIZDDsYtI/HZWVX2
   w==;
X-CSE-ConnectionGUID: KMvl+6CWQ6GFaaUhvEV4fQ==
X-CSE-MsgGUID: s5OKWH6STfKQqWOKq7e4Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44174802"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44174802"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:04:36 -0700
X-CSE-ConnectionGUID: gUFIQv5KQJCYw2Z0ahcdDQ==
X-CSE-MsgGUID: AokKiRI1RYinTCCBrWOjaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129917471"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:04:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 08:04:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 08:04:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 08:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYet9FR60jyJdfLdChgEB7woCnn7BP/SPnfEz/vzlixFjpcWuXospLvV1KJ4tGJZCiEdiKqwuhrBADnFKrV0UF7yW7BMBCBcLsoxwe8U6MGgHkJyj1uFlevReNVPKAaRxkZSI88pLbJBGukjyM+JjoNAqcri24EiYxKR4IUR7hZdsJCPSuq2DgFdifKi0Ul2s0ihxKrbv665WLO173lW5cONU1sNNgFQp514RwVEwS7JSA31Zzd9cPvuGXJ+zo4KbQ+y6uIbwHxPvrXaGQO0VLOCYVLPP2EpUC1YVVBT/Pt5cowxZTmh67syzXcw9CiInVtqDFyv8/z+ZkHh5A0FEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGVH28N3y5+ndStXVbIGMnNtT01Zr20KAPCfP8VjEWg=;
 b=FBcl7tWwpKHlNCepJUrVkBWTsy6rpjcP8y//2/kDNrlP7B49EAGUfn8Cdo4a3Zy20fzyMmZ2WpwGxohqeyJMeNPU55hlxzd39zviSEhX2wHKLbT0MFDkeKdPH2ojHzSWvg8533o4TebgcrxJHj+JjNHbpwz71U3K0LrWF3cyTq6nxa7K1jmGaqL+dU1hXeBp0VyGcrgU6C7vkIxhxbt5zCO5J7leSuOIUS3IIPnNaLoFU6/nEbJbdQGdHBv/jjvqpgmpjR4SQwyoqeKsJbqN9Y5ByNLar0d41H65r3R2yOZb2avONzBClZzYeNTJgnPetkJeqQ5f0lK/2k6ZreZkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 15:04:18 +0000
Received: from SJ2PR11MB7670.namprd11.prod.outlook.com
 ([fe80::c3bf:576d:1abc:eb24]) by SJ2PR11MB7670.namprd11.prod.outlook.com
 ([fe80::c3bf:576d:1abc:eb24%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 15:04:18 +0000
From: "King, Colin" <colin.king@intel.com>
To: Bart Van Assche <bvanassche@acm.org>, Christian Loehle
	<christian.loehle@arm.com>, Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
Thread-Topic: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
Thread-Index: AQHbjHwfO/1QphUhLUSIeLixfeE6q7Nh/R4AgBUtUjCACZzagIAE3fcw
Date: Wed, 26 Mar 2025 15:04:18 +0000
Message-ID: <SJ2PR11MB7670B2AEFF7C0DABE6856F258DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
 <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <1ae51ccc-66cc-4551-b649-2f5883e2f5a2@acm.org>
In-Reply-To: <1ae51ccc-66cc-4551-b649-2f5883e2f5a2@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7670:EE_|SA1PR11MB6894:EE_
x-ms-office365-filtering-correlation-id: f5714286-d7d6-4d7f-9f1a-08dd6c777b3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?STVCOXBUS1oyS0svUkRkdzBrRnNOR3I5Mmg0TCtpK3pEejRlZVpuV3pqUEhv?=
 =?utf-8?B?eGRtSnlEK0RjOE1OT29zcm5OU0h1aS9sWHVrWmw4WDkxdldKNDJieHNWUmF0?=
 =?utf-8?B?MSs3ZzE3bEdZT3lqdS9mQXV1ZTlOS1h6N0F0QjFKeU51cHBLQ2ZGZEEyVXFn?=
 =?utf-8?B?V2EvSUlpRWg5L1JJRHVJT2s0eGw0NFNleTlsQkJDZjhGanV4cGdvQlZtNGR3?=
 =?utf-8?B?Zk5KTFlCZVZ1NitGRm1LYWNPcXBCdnFSd2ljVm8zQUkvbE5DeTdVRXZMODdR?=
 =?utf-8?B?a0VmMmNEalJQZ2JML1NPRlVxWHhZOU9RQnNycW9jNlhSV3FNSG9nN0hRUjNK?=
 =?utf-8?B?Y3ZneHhNaVBkZkpMMXZOai91Sk95ZWgzbHZzY0xLakRiZmUvT3d4TEUvOEFX?=
 =?utf-8?B?Ly9PdzFLYkFVTlY1cmFkUi90Ym1NMWhPMXJRdDR0ajY0OURTS0kzb1FuRFJr?=
 =?utf-8?B?Zmd5dlcyVEhEcGpxZVRaNVZROHhaMnZnMzhOUjlHaWpWTzZiUVN5eU1ROVZa?=
 =?utf-8?B?dXQvb05HZXNiRVhPb1hTaW8wR2Z0d0F2QTQyY2JEYjcrc3dzcGNjZnBQWndV?=
 =?utf-8?B?aVIreWNZN2xPN2RTQzVGOVFDcDlEMVRqSjNPNVpBeFEyQmZwdHdHZ3NFbWY1?=
 =?utf-8?B?V29KMTdSTzlOOEtUMnVpMU4zKzJvb2ZITFZIb1g0cWpud3BKTGM2WTIvM1ht?=
 =?utf-8?B?NVV2WGQxNmJJaEl6TFh3dmUvQUtNaE1rbjl1V3ArdklEQXpoUWJBeWxSOFJF?=
 =?utf-8?B?ckZnYVUvY0c0bkdaUFc2b0c2eVdPekRtTW1CbmxmYkpRSmVycndhb1AzNUVz?=
 =?utf-8?B?cmw0cElpNWx6akFHNU5LeVVTRUZlWEF4Zm9ZK2w5QWJGRkltVUU1Q2hHWTcx?=
 =?utf-8?B?U0lsdFJYaWdTa1dYY2NleUQyOXJsbE1zOEUwaURzYmFpeWlNOXRUOUYydVZa?=
 =?utf-8?B?ZG1Pb25rUG56TkNER0hRQmwvS3dUR3FxdXJNNzBXVUZxbGt6aWhnWk1oWUJl?=
 =?utf-8?B?RlJ1S2ticXN2cGZmbG10elJwSEJ4aVFSK1dmRFNvRUtEK1lERzBlVExPdlZM?=
 =?utf-8?B?SjNNZmJUSmxZSkpLVDI5ZWl5eE1JTlY3V1phYjYzYSsyclFpeE5iUGN5amZy?=
 =?utf-8?B?aS9CU3N6U2NvS2RLalZjSmcxQ20weThmTHU5dkJwUXk1ckVrVXZLR3lkZ3Qw?=
 =?utf-8?B?ZWs4azU5ZlgxL1g3bVZlMm82VmFINW9lenNkNlRUNkpSRDJVWjBVcWhkMVRy?=
 =?utf-8?B?ZXVXeFp4OVpOQkdsNlIybEdsTmxScktVeC92TlBuQWhQZS9lZ3hRckNSMDVJ?=
 =?utf-8?B?MWN1cEprck5QSGloN3luMjhJTUszRDQxSnBuRVVyRVFPNGJZdVRIR1h5TlRn?=
 =?utf-8?B?UmptSDFZVFl2S29MdExDL1FUQmcxaTZpZXY2TkNqcHpobjdZM01CV2RvYzFl?=
 =?utf-8?B?UFRuRFlDSHZJVkxoUXpkTkI3QjUvUld2QW9UVUR4SkRNTzlmTG1IRVltbytE?=
 =?utf-8?B?WUYvU1E4SXZ1WnRkaW5xcnB5WE93U1AxZldNMzlvZnRvTDFlUDVVbjFKQVdq?=
 =?utf-8?B?Y1hyZGY2c2pnSEViVG9sWXRWK08xWllRc29BOXd2dVpJOFR3dWo0QW5oQVI4?=
 =?utf-8?B?blZqd09hZ3RqSXliYVMwTEJkVXdacFpBN0lmcnNLZTZBOHA2NXZEbHFLaU1M?=
 =?utf-8?B?aHU5OGhOeE52OHlUNVhMSzgrRzdadEhTbEJkVXNDZWVIbkcxVDNTT0RkNmpR?=
 =?utf-8?B?eUsyT1kwcG1xbDN5R1k0ZEFVOXI4UmxsY0JmQklKRUcxT3dKYmVLQ1hvWW1D?=
 =?utf-8?B?VTNXOVZ0RDhoeXhRYzhjOVBOYXRBaXlOVmMwVTBOZ2VNY25zWHNFQ0ora2No?=
 =?utf-8?B?dFkrZmhBRDFLVnZKc2RzQ2E0Rk5BUEJ2ZzZ5ZSs2VHlqdktQeFdIWGg0ekti?=
 =?utf-8?Q?U8aqrtQDqc1kE2DdWLu3JhjCNd0j5obY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7670.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjkrZXR5V1I4NGVBRzloalkzRTI5Yk9rd1J4OEhXZjJVN2VnRXpFZUlQcWtq?=
 =?utf-8?B?NWVqTWF1MTlxR3J5RlFCbkxneWtqQ3k1U2l4UmFxWmlicnVHeWZnZEZlaTky?=
 =?utf-8?B?WXpuS3MxTzJHdDBJQ2RkUm55TzB6VVEySjUvb1EyNHFtOEpsT1JMZDlSeUJZ?=
 =?utf-8?B?UHZRZ3QxQjBlT0FsUHNvSVlvZExVa0thYkNrUWh6SkZHN2QvS3o5Y29XOG1K?=
 =?utf-8?B?eDFpKzJmWnRkai9QZCtUS1VkUm0vNTczSTUxaVpiRWNSYjdnWWtQRWRGUnVZ?=
 =?utf-8?B?a2FkWE5QcTdyUUYzQ2U0RGpyZG5LTXBFMzBCNzRNMG5ESHpjYkplWTA1Uk56?=
 =?utf-8?B?TExwNS8zNkx3WUY4WHVRWmxMZWx6OER5SGlxSDJlUFZBSS9tczkxdXRqcitx?=
 =?utf-8?B?d0NWZ2o5bTVYNkVtNGR4eXh2VGFtZk9UR1FxeVo3WjgzTGJCUVVGOGkvR2Zk?=
 =?utf-8?B?eE05a0N4TUxwSmZ5U3dnbHpqT0N0aG5ET0hwWnowYnc1RGIyZHdMalhOMGFV?=
 =?utf-8?B?N3IvVWcrRmtBNzRsTlhGcWdIOWxSQkpLR3YwK1NWM3hKWXJxR1RpSENRLzVi?=
 =?utf-8?B?cDRDNFZzYkYrdnAvWER6Y3g1WWIxcmpIQUpIRnZMd3ZmcDVvM3M5SVFsVlFY?=
 =?utf-8?B?dHFOT1RCYTB5UFB2YXZMUCtqKzlWL0d2ak9ROEE4bGU4bFhORDJWaTRwVjFy?=
 =?utf-8?B?dnhUOXhCYzNUQlRhZXNGdncyazVWdGV0dVRJV2JsT2pOVURSZWNneWFpTE1w?=
 =?utf-8?B?THp4bEZzYzM2M2hoUHhFVis0TFdFNmdRWWZkd1NaUFZWZVh1SWtSbU43SXh0?=
 =?utf-8?B?SytaWmhab3E2MHd0T1EvMW0rdTFSVTdvUGp0Y0tzYmhDMFR3VG1QTllpQm0z?=
 =?utf-8?B?TGlaYlFTaklDS2F0UEpkNkw3ck9UT3RTYUdwNk9hQWt5dVZwVnZ4UzZYOUFS?=
 =?utf-8?B?ajlCZk1uRkJaOGNzT2ZKd3NMZFViSDRMM3R6ZVhoNEhNb1JjNURmOWR1aTVN?=
 =?utf-8?B?cGRwREQ5d1V2RW9ZUFVoSDFLZEk4OFFzcXkyYlVxWG1oZHE4V21zeHRrd0FT?=
 =?utf-8?B?MXVBS1gvLzdKRWdNV2FiRmZLZ3M5ZlNBSlBqVTlGdUhleFA0RDRJaTlCdW1j?=
 =?utf-8?B?N1pHWVRMeFR6Z0diYVUwTzN4YVJuQ01TcDVCWVdXLzk1L1lQWmprWUcyWHk1?=
 =?utf-8?B?dkZmSUJMN2Zlc2pNb1Y1TTdyOEdtTWVFZndRZkVPNEZJYkozZDJZMTVwT2VJ?=
 =?utf-8?B?WndnZWF6R2lBL2Z4TVZnY1ZPeElFcjZOWDU1eVVKRms3RjAwaW5EUXhZdU1t?=
 =?utf-8?B?c256Z2VoVklqZDdwRTgxaXFQdlRlSkR6dHpyV2RnUFpBcmZ2eFZJUjZVQUdY?=
 =?utf-8?B?Q3hPUldLcHViL01HOE1VT0srRngrMTlXWTN2dkwwNVphMjdDbmYvekFvb2hi?=
 =?utf-8?B?T1lWYlN2MHdiRFFibEhUWWpZUEdDdnNoQnh2NUNweGtKTzBnL0Y0TDFPMHRQ?=
 =?utf-8?B?UTJQemt0UzlTaXNwUTZaMWtoYmt0TUtTdklIUm1XUmpDS0lSVGVlM2w5MVJO?=
 =?utf-8?B?Rmd0Uy9iK0Y3aldPRDIxQlRjK01pejdCbjRPYW1ONE1wM1lBeHErK0kwNTM2?=
 =?utf-8?B?SXJhc0xCdzRVc0R5ZlFnRDA0NzM0K1hpa29wNmxJeTlGT2pPYVMyVEJLQ3FQ?=
 =?utf-8?B?bFJRZ3g0bjRqMEhqWVErRlZZVk9YMnFIeTZQN3lJbDZlRy9oZnlnUWxnbzg0?=
 =?utf-8?B?bFlRdlNGYXFtS1B5KzB1ZXZIRkdQWXBSTXR4YTRWS1VsMG5QcGtsc3dBSU54?=
 =?utf-8?B?U0xCUTFzamlJa3VSL2dnNFo4OGNwSzlXaVhHdFcwUnE3Q1l6ekZGUG5kK21o?=
 =?utf-8?B?Y2tUYnhIVytuTW5LZUFEZitBRzBNWkpxS1NYTUYvTDFkSzQxRE94RE1FWjhi?=
 =?utf-8?B?UDQzcWdoazVDQitoN1hKbjZFYjVyNHZoMDFndG9XTTJDQk5OY2ZiNTNXajNr?=
 =?utf-8?B?cXZyWVdKMURxYUdZOUZYZ2xqQm0rRXpZQnFMNDNqNTlKZktKVXFiVGNOWmlC?=
 =?utf-8?B?YlhNcDM3YnNSNlNUTkplRTJsZVgySlZRY2tNZmoyZ29iVUFRLy9YODNFWGpY?=
 =?utf-8?Q?GGUbGJ31nHNrUQGlWB3jOAMMJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7670.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5714286-d7d6-4d7f-9f1a-08dd6c777b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:04:18.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZacjkIua7pVLfApSLBMzIAezLVq9fm5p9u4aX6cTmT0j4stDSv+QjmIZRN0UcuHq6WwpyRhxHB3zxvFEJH00Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
X-OriginatorOrg: intel.com

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFydCBWYW4gQXNz
Y2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IFNlbnQ6IDIzIE1hcmNoIDIwMjUgMTI6MzYNCj4g
VG86IEtpbmcsIENvbGluIDxjb2xpbi5raW5nQGludGVsLmNvbT47IENocmlzdGlhbiBMb2VobGUN
Cj4gPGNocmlzdGlhbi5sb2VobGVAYXJtLmNvbT47IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az47IFJhZmFlbCBKLg0KPiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IERhbmllbCBMZXpj
YW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPjsNCj4gbGludXgtYmxvY2tAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY3B1aWRsZTogcHNkOiBhZGQgcG93
ZXIgc2xlZXAgZGVtb3Rpb24gcHJldmVudGlvbiBmb3INCj4gZmFzdCBJL08gZGV2aWNlcw0KPiAN
Cj4gT24gMy8xNy8yNSAzOjAzIEFNLCBLaW5nLCBDb2xpbiB3cm90ZToNCj4gPiBUaGlzIGNvZGUg
aXMgb3B0aW9uYWwsIG9uZSBjYW4gZW5hYmxlIGl0IG9yIGRpc2FibGUgaXQgdmlhIHRoZSBjb25m
aWcNCj4gPiBvcHRpb24uIEFsc28sIGV2ZW4gd2hlbiBpdCBpcyBidWlsdC1pbiBvbmUgY2FuIGRp
c2FibGUgaXQgYnkgd3JpdGluZyAwIHRvIHRoZQ0KPiBzeXNmcyBmaWxlDQo+ID4gICAgL3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvY3B1aWRsZS9wc2RfY3B1X2xhdF90aW1lb3V0X21zDQo+IA0KPiBJ
J20gbm90IHN1cmUgd2UgbmVlZCBldmVuIG1vcmUgY29uZmlndXJhdGlvbiBrbm9icyBpbiBzeXNm
cy4gDQoNCkl0J3MgdXNlZnVsIGZvciBlbmFibGluZyAvIGRpc2FibGluZyB0aGUgZnVuY3Rpb25h
bGl0eSwgYXMgd2VsbCBhcyBzb21lIGZvcm0gb2YgdHVuaW5nIGZvciBzbG93ZXIgSS9PIGRldmlj
ZXMsIHNvIEkgdGhpbmsgaXQgaXMganVzdGlmaWFibGUuDQoNCj4gSG93IGFyZSB1c2Vycw0KPiBl
eHBlY3RlZCB0byBmaW5kIHRoaXMgY29uZmlndXJhdGlvbiBvcHRpb24/IEhvdyBzaG91bGQgdGhl
eSBkZWNpZGUgd2hldGhlcg0KPiB0byBlbmFibGUgb3IgdG8gZGlzYWJsZSBpdD8NCg0KSSBjYW4g
c2VuZCBhIFYyIHdpdGggc29tZSBkb2N1bWVudGF0aW9uIGlmIHRoYXQncyByZXF1aXJlZC4NCg0K
PiANCj4gUGxlYXNlIHRha2UgYSBsb29rIGF0IHRoaXMgcHJvcG9zYWwgYW5kIGxldCBtZSBrbm93
IHdoZXRoZXIgdGhpcyB3b3VsZCBzb2x2ZQ0KPiB0aGUgaXNzdWUgdGhhdCB5b3UgYXJlIGxvb2tp
bmcgaW50bzogIltMU0YvTU0vQlBGIFRvcGljXSBFbmVyZ3ktIEVmZmljaWVudCBJL08iDQo+ICho
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay9hZDEwMThiNi03YzBiLTRkNzAtDQo+
IGI4NDUtYzg2OTI4N2QzY2YzQGFjbS5vcmcvKS4gVGhlIG9ubHkgZGlzYWR2YW50YWdlIG9mIHRo
aXMgYXBwcm9hY2gNCj4gY29tcGFyZWQgdG8gdGhlIGNwdWlkbGUgcGF0Y2ggaXMgdGhhdCBpdCBy
ZXF1aXJlcyBSUE0gKHJ1bnRpbWUgcG93ZXINCj4gbWFuYWdlbWVudCkgdG8gYmUgZW5hYmxlZC4g
TWF5YmUgSSBzaG91bGQgbG9vayBpbnRvIG1vZGlmeWluZyB0aGUNCj4gYXBwcm9hY2ggc3VjaCB0
aGF0IGl0IGRvZXMgbm90IHJlbHkgb24gUlBNLg0KDQpJJ3ZlIGhhZCBhIGxvb2ssIHRoZSBzY29w
ZSBvZiBteSBwYXRjaCBpcyBhIGJpdCB3aWRlci4gIElmIG15IHBhdGNoIGdldHMgYWNjZXB0ZWQg
SSdtIA0KZ29pbmcgdG8gYWxzbyBsb29rIGF0IHB1dHRpbmcgdGhlIHBzZCBjYWxsIGludG8gb3Ro
ZXIgZGV2aWNlcyAoc3VjaCBhcyBuZXR3b3JrIGRldmljZXMpIHRvIA0KYWxzbyBzdG9wIGRlZXAg
c3RhdGVzIHdoaWxlIHRoZXNlIGRldmljZXMgYXJlIGJ1c3kuICBTaW5jZSB0aGUgY29kZSBpcyB2
ZXJ5IGxpZ2h0d2VpZ2h0IEkNCndhcyBob3BpbmcgdGhpcyB3YXMgZ29pbmcgdG8gYmUgcmVsYXRp
dmVseSBlYXN5IGFuZCBzaW1wbGUgdG8gdXNlIGluIHZhcmlvdXMgZGV2aWNlcyBpbiB0aGUgZnV0
dXJlLg0KDQpDb2xpbg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0K

