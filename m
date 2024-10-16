Return-Path: <linux-pm+bounces-15745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CD9A04DF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8011C22BC6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301A204934;
	Wed, 16 Oct 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShutEUrn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161E203711;
	Wed, 16 Oct 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069078; cv=fail; b=V5yxyxychFJDw4x3LWCWgrHj8Z4Tgl4iYlI7wObpIFpD4TpP9twrc/+dsrVsIKeqnnDsSCo+Isv3Tn/8oMZykA/ty2HErfSdHfKVMdVsHdGXdcRtPtTdZ9UmOdnMV9SBospALKXH8HOb2Gw7rXsvyzd1GVJ44rW2sFEnSV6Wj50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069078; c=relaxed/simple;
	bh=Nd4BY0cNsnMvwcdzPqCMsJOsDL5VtudXaDUut2EogB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtGzziFnJENhVnUzwCZ1Ty3LLrnSD+hyN+fccRqlUWBwFY1tgl0M07n/CsK73z6qvTQMS68KSu1txpnR3jA2xriQEB6V7SvqlU6vlROIZ4Ac5iVwlzyrcWRal5vGS4Es+jZB0BrsSArZQRRQPFjg1bStflvrThiiTUaYaOw69nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShutEUrn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729069077; x=1760605077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nd4BY0cNsnMvwcdzPqCMsJOsDL5VtudXaDUut2EogB8=;
  b=ShutEUrnWGLSI/SQpm9HjZTufCvprhOvVMf8vx4Zv6v7HolfXIXXBsXE
   1Y+6XbyBxK5Yyf+IdTddrtaCMrHKdEZTBBWCuL+nqM/E76XlwXakh4sTV
   YWmtuu1wrk9mwjAN+bq3rDzAHBoxUKy/MF6o0u72L81N70Tmzd/znIo9S
   oNhUm6KYf6blZFolLpaq5nbmaRuPGyaD4jsCubVQ3oK/J1ppq7zR0ruN8
   l/8kpUj6pCoUnU6yy3OD046XZRQ553OhznxitQE79TwcEPHr60b7GWXxh
   4PqjpD/b1LwNXiO+4lv1Li3hYHS5RkjTKEqqc7LPv/gw7fKRg0mzbGnX/
   A==;
X-CSE-ConnectionGUID: M4F+sdOmSWW0bTwLplp7sw==
X-CSE-MsgGUID: 9mbo8UJFTqWP6gfDX/haJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28598774"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="28598774"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 01:57:49 -0700
X-CSE-ConnectionGUID: KZo+dqJdT7+vW5LvSC+qjQ==
X-CSE-MsgGUID: pc9pOtdgRVKBdwRTfBpUhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78054090"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 01:57:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:57:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:57:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 01:57:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 01:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/aWLUO/0QL/jtZr0uJ6Nb20Y31TeVesinuJqgVpIA5a3sKkPSg5cfO22ehhpkX6k4ZIw4Gm88YVtU0TXFxOBHHoVi563B0p2XCRpNyFd4Ww89fTkYNSUvdsKQWckoTyPKjSSMcq/o/PKstPcfWtIhG/R5WieJoZXwgmLqknQ3DmFvJjRbpkUqmtQFewPee0TUqso+BnCYrCiBVvCrIEY+QGPqtaD1OOug8g7s9jrNDc62y8B9smqBwJq583fy372djjC4WBn7lD5PtCs0MXN8w6zkq9pEqlFosXQexodMhAb3plCwWbnPCqAFHeYQa3y2gq8Fxbi3KRPDVon4ZmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd4BY0cNsnMvwcdzPqCMsJOsDL5VtudXaDUut2EogB8=;
 b=g59tH9tcB+yVBClkKSjUt4nMhdrryyq6FKAvdsfnb4icXEavysCqwF5Jq18fDe9ShrH6nLcdFCs1vkFNbE6gdgNr7J4zW7dgqrT5UscW+PfDL15KqiVb6/WTcEWBV9tftN8G9Tm8+8vOURg4GOfGKbaLkYK3J1wNiQ+Fzc8QvfGlzkY7kv5b/U8MBsGKp1VMFgi98Py73sB7hWvbyC6C1WUfIJI/7PNSMwJltxg9czI6CPACFduIDue9kqY9+m+EYg+fvyJvOO3ETAVpuxlNNPMsVUI3GI45SvXrDQ1SUauNTfFaEaEqf/pEcUNpY55/OWEnix2F3/OGfW76A8PiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 08:57:35 +0000
Received: from DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::6078:57ee:53ba:57a5]) by DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::6078:57ee:53ba:57a5%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 08:57:35 +0000
From: "Gopal, Saranya" <saranya.gopal@intel.com>
To: duanchenghao <duanchenghao@kylinos.cn>, Alan Stern
	<stern@rowland.harvard.edu>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Hongyu Xie <xy521521@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"niko.mauno@vaisala.com" <niko.mauno@vaisala.com>, "pavel@ucw.cz"
	<pavel@ucw.cz>, "stanley_chang@realtek.com" <stanley_chang@realtek.com>,
	"tj@kernel.org" <tj@kernel.org>, Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: RE: [PATCH] USB: Fix the issue of task recovery failure caused by USB
 status when S4 wakes up
Thread-Topic: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Thread-Index: AQHbAAnZn0I78z2Rm0CO/hcA6/JbFLJQy8GMgAHlSICAANSWAIAAw06AgAJWrQCADn2pgIAB8KqAgBbZsYCAAN5LAIAA7Q0AgACMa4CAAL4fgIAAzDmAgAFO4ICAAFadgIACRQaAgAObC0A=
Date: Wed, 16 Oct 2024 08:57:35 +0000
Message-ID: <DS0PR11MB74570B2F9CB54FADA323CDE9E3462@DS0PR11MB7457.namprd11.prod.outlook.com>
References: <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
	 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
	 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
	 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
	 <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
	 <5f2f6b979e95e4c2bc33ea0277112939164f6024.camel@kylinos.cn>
	 <d70e070f-5224-402c-ac27-0703b4010b18@rowland.harvard.edu>
	 <0ad92e8fef2f07672aa8e97bc04f20657469ac6e.camel@kylinos.cn>
	 <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
	 <f27bcdb6c5ddd4e91a1dc9f86b4f0c55c50671a8.camel@kylinos.cn>
	 <74848334-7cd7-4ce1-ad96-5dd29d70d3bb@rowland.harvard.edu>
 <eb119532f37c84aedab32df9169e64abf894f006.camel@kylinos.cn>
In-Reply-To: <eb119532f37c84aedab32df9169e64abf894f006.camel@kylinos.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7457:EE_|DS0PR11MB8739:EE_
x-ms-office365-filtering-correlation-id: 5f89bd4d-1c11-4ffd-9624-08dcedc0943c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Skhyd0FYWnBzNkdnNnIzdG4yZ1k0Qkx6UDhqUEVhSVJQMnA1Vm9YMEVMaXdQ?=
 =?utf-8?B?c1JQWFB6Y1NuMVFnWTBFWXdVeVo1R2lVTW80amd2Q2lRWW9ubVluRC9teFk5?=
 =?utf-8?B?QmYva3JXZ3RXOTNISktEcjVaQlhLenVTN1pOUklIaGo5cXBNdzVjQnlnVk53?=
 =?utf-8?B?VFFORnEzM0NSdlRyTjRXRHA1bFhLdzMyRTc4V3NXYkJtTWVUVVY1WWdPd3lG?=
 =?utf-8?B?OG1MS1NpMldKclVpV0ZwR09Ja25UU1lWNEl3T216czRpSFNCOVRCQ29VRmFT?=
 =?utf-8?B?d3A4NVhoK21WZWlBa3hqK3VEb3duT2k2emFaazhLQXA3Q0RDZ28wKzRCU0VM?=
 =?utf-8?B?SWxlM3l2V2p2OFRsWVNHekZObGxKN3ExRThtaUlGNVpZMmtzZzNzYnBxR1Nj?=
 =?utf-8?B?aEFBWUNodHR3amlkL2x2eHN5TDdnaDl3ck5IbDN0YkxzSU9OYU5xZmdWM2FQ?=
 =?utf-8?B?T2V2ZUpEb3l6STJRbzgyQW80aVpGQ2lYZWdNS0lUOFR3aitRWDJNcTRpdnh4?=
 =?utf-8?B?bkxRYkJTNTc0bVJTblliWjlPb0hIay81QmJ4eFZXKzB3YTc3WndXVUVWZlRR?=
 =?utf-8?B?dmhkRHZCYmlrdzBiUkJhdjVsQ2RKRnNvVjQ1dVhIOFZMUXB2TEU2bjhZa2V1?=
 =?utf-8?B?UWswYTltVGdObkxpeVgwVklHSWZpRjRUT2syUHR0TkhMREZKT1VWTWN1YXZ0?=
 =?utf-8?B?TVhlN3ZkWVN5OTE2ZlhEUlpqU3NtcitDVE1GaGRpeCtvYTVEaUwvMnF5TDlw?=
 =?utf-8?B?VTdwbWdpQitLV1Z5TEl6S0FvcUxrdUcyYzdDK2h5THhEUzE1UDBRcDhLeFUx?=
 =?utf-8?B?SFo1Q0QzdGtiQmdxb0pQTFRMcTI4akE5N2xpaFVudzVPS2ZWMlY5SXl5M2Rk?=
 =?utf-8?B?ZFZaWEZhNDVxM3U3a0xxdkZ5TUpiMUFXNjBiOHdMNkNrYjk2Qk1kbkVNcUQv?=
 =?utf-8?B?aElET2p6WHVheWFQekdCR1plYmpyQmNuNkgvWExidEp0WXo0UWR3L2s4VHlF?=
 =?utf-8?B?dFpRcUV5Sk0rU0ZpeTBZVjVrWnl4WVN0aXF0NGxKNEJGbnRINFJPNjdUZHUv?=
 =?utf-8?B?bk5uVit0bldUcnZjUnVpQTNMWFhYNVRObzhCN0M1NjVhUXBuM2tNckdGY2xK?=
 =?utf-8?B?Y3JIdFFWK20xcjZzMS9xVUpGc0IyRytTMVVjQ1gzYlJuV1JISTV5WENlTkQy?=
 =?utf-8?B?bGJySjBmUURoWDR1UElYVUFOZ2MzRVFGMDQ1SzFDSzFDcWVscE92WjJ3UjNT?=
 =?utf-8?B?RXFaODJlZEg0SE53Rnh5cW1XZFBNYnVKUldsczdQSC9vK1NyTzg1ODcwSHF6?=
 =?utf-8?B?amNoK0YzY2lvQXlnRkxIVnRNek9YUGIrY082WU4vbmhmQTFuVEdNU2pESXBN?=
 =?utf-8?B?b1ZSYmptMHBmbm42V1ZlOXdScGsvcDhNN3pZY0V6ZW10bGo4RzU3dkRvc0gy?=
 =?utf-8?B?UGhxQU15OHZGMFFyZTJlTjBua2hyaE9zUlVuSVZmeVFYZmdJbzRYYkpqVFlP?=
 =?utf-8?B?VkZueVA0YWpyN3lON2s2Z0k5YUZCYjljdklDOC93aEdwOXNDWG5CSitUYXo3?=
 =?utf-8?B?RGZhS0p3ZC9hY2lUV2R1NXI5R0Y5b0ZpckdPWVlwRmNtSE1INEwvazlqT201?=
 =?utf-8?B?RXJMblNBdDZIckIwdUpiTXp0Q3hFSGRvSHJseVJPdzNjYUhVS0habXc0cWJZ?=
 =?utf-8?B?Qm1pb1RXemxsSlhnM3MzSEJaWmEwRmdUck9qTDZrbGFmKzhteG9UNzdkMlpG?=
 =?utf-8?B?QWlSOVRuTUZoVGd5Z0QwcVdlUldQTEh5RFlUc1lta210dUg4Z0NaaUg4OUZm?=
 =?utf-8?B?bERrTTErb1RoMGVVVWFtQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTdVNkRHWlRrZnhid3NObUx4SnAySGwzRGc3ckFjeWd1NDJlblNMbExHeHdk?=
 =?utf-8?B?dUpDdU5GdFFLUEdCZVF1WGRsUUl0bUk0Z3kzU1JyejFvMUlKSk9ndW5yOTZi?=
 =?utf-8?B?MmpleG5TM1NTVU5tY0tUeVNpcDhhamQ5Vlk2T3M3bmlZbFdCQ1hjWmF6ODRy?=
 =?utf-8?B?QzZDcDN5aEt1WlVMYTZhdzB0TTlOdzdhT3FYVkw0bjlkbmRTWEx1cEdWQytW?=
 =?utf-8?B?UzEvY0hOVUNNVDBreHpnN3N3N1YvdGt6UWlGeG9IN2U1R1pyUWxxbHd1Z1Ji?=
 =?utf-8?B?a0pIYVphS0VNYkRBZGl2VEF2U0FIRGQ2TTh2MldJdGtWNlNGNGNrcFY0bjlu?=
 =?utf-8?B?TS9WMnF3Qi9zT1g0UXlIczg4MGZ2Z21KSXdmSWI1UytvcWVPL0pSa3MxaTlh?=
 =?utf-8?B?QWVDcXc5QTNRUHR5VWpwMDA4b2ZJQXIwUzFCQ3Q5QUxNcXEzcUhlTUlNTXhr?=
 =?utf-8?B?MDdNenhidG5LOTJmdmQxdDNvb2t0b2FpbGNTeUY1cVF0YnBraVdQNUY2dGRt?=
 =?utf-8?B?Y1dUZXB2dUNQMEd3MVZxV3RqMGFMR2N5QmxtTVBvbi8wY054TWkwN2t2UFhI?=
 =?utf-8?B?WXAybW5HZkRyczBiWnhHSlpuTFZnK2J4N1pZaFlYTWMybVBsZFYxbG1WS1RZ?=
 =?utf-8?B?UDVVQm56bHFwdUt4b24xMmIwNDJ5WTZud2lYYm1jYkxBSDdCaWZmTmF1ekRM?=
 =?utf-8?B?djlKelZ3eGVIc0QzNkNMMnkyZ1RDN1NYSFI4R1dnWDBBSThaa1VkalFTM2pa?=
 =?utf-8?B?ekN4RUdMRnB0N1NVTTI5Q0ZXNjhMbllia0VJbFVQOG51VjlyZ1hZUi9mdXNW?=
 =?utf-8?B?empCVmxVSGkvM1NhSjA2TmZ1dTlSaEdxSWJ6Ylc3T1JGOHZQMDNCOHVWRmlW?=
 =?utf-8?B?ZEo0WlVxVENtdktGNkR2U3N5aHpuT1BZSHdvNTRXdzR6R2c4S3NVdEYwRkJF?=
 =?utf-8?B?YkhkZEpGTFFobmxTVjBjZy91T1ZQeDdWZkRaWWtvL0RGaXRGZGdVUXl1dURy?=
 =?utf-8?B?WklxOUpDaGVyV0UxTythSEdOSzhsSDMxM1FPNTU1Zm5XM1RNWElMT2toSGJl?=
 =?utf-8?B?ZFhNOGViUlZqQWpWM2FBQVQ3aTZNSVhoK1RtZG1mVldVczhYRGZ1eFdRdGZO?=
 =?utf-8?B?ZGZoY1QvUjVFc213YzJaRkVUZ0ZUcEltTThINTRoYnEvM21wa2R0VDJxaWVj?=
 =?utf-8?B?a3VRYnJhOXlTRTJQcFo1MEV5NjRVa0c2VlNGa0JwN2k5c1c3QW55S0FhbkF6?=
 =?utf-8?B?aDZQd1FPSHd3eFRpc0hJL1pUdEYvRTgzUDR5RjNJS0o0U0phRjNvaDUrdXFm?=
 =?utf-8?B?YlRBQ2Qycmd1WHZZZG1ZdmNyenVsSUZVODVPUzJSY3JpYmVESVRZaGpLa3J5?=
 =?utf-8?B?ZHhhTjZML2hMdkh3SmZ4R3JMYnZheFJJNkN1Y2tIUlNpNHlYdXFSRXJncDl0?=
 =?utf-8?B?bWcwNTlsZERtZUk5Tjk3ZGw1VnpyUzFKUmQ3L0dZMEVwS2ZEUjJmOW83Wmtn?=
 =?utf-8?B?ekt3Z1ExYWFHcTNOQWk4dlRyK1BraVhsQ1dxNHpmYWhMa3ZDT0hPVnVoVjJo?=
 =?utf-8?B?ZnpJbWJuOXhacU1PN1NNR2pRWXdCZzBra0p3Ynl6eEhyQTRuNzErdENueGVv?=
 =?utf-8?B?VThINDlidU84U2FISUkraGd4T1Z0WHppRnZYMG5Zc05SK28rNUVoeXF1MlVn?=
 =?utf-8?B?dk1IQlZpTi8yOW1Yd0pSbjZHdWczZGpabEVuVDNYRXJ2WnI5OFdwZVpMcEtl?=
 =?utf-8?B?cm94NU91N3V1WFpWTk9qakVtRWlrMllXSk12ZUM4VWxrQ21EanF3c2FmTTJ3?=
 =?utf-8?B?bFBINmhWRjBzaXJ1QUVTUm9nR1kyVllsdkluVklSY3N2YXhJU3k2bktiaVhK?=
 =?utf-8?B?QUtIcUFRVkw4eklzRXRMZjdtbEN4NmdNTFNpUWJ6Ynk4SGp2dit3WTdGU0tI?=
 =?utf-8?B?SmZzL3g3WHprTGxuZXI1NVN6VjVnSVRxQ28rUERBL1E1ckZ6THFtc0JhUVhr?=
 =?utf-8?B?YURhVS8wdFJGVUI2WTN3VGM1MmVZTjAzK1V2cUNpYU1uUUFqZDBNaldaMVhX?=
 =?utf-8?B?U09uZHNtOGk5c2k1bFAxOEU0NTdqSjlkdytnZUNuVzJNbE44SHc2WFM0a2Vv?=
 =?utf-8?Q?QQ9kbort17hKAmdnn4NdgESkl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f89bd4d-1c11-4ffd-9624-08dcedc0943c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 08:57:35.6071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czIIa/GUOMKkkjVblstxVDRvk2Ao7ypZvKaeYqjshBSVyDPMbzuAPbE1FzyOCZ2BcdBqJw/OCo3LBXbtMNpahw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
X-OriginatorOrg: intel.com

SGkgRHVhbiBDaGVuZ2hhbywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBkdWFuY2hlbmdoYW8gPGR1YW5jaGVuZ2hhb0BreWxpbm9zLmNuPg0KPiBTZW50OiBNb25kYXks
IE9jdG9iZXIgMTQsIDIwMjQgNzoxMSBBTQ0KPiBUbzogQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFu
ZC5oYXJ2YXJkLmVkdT47IEdvcGFsLCBTYXJhbnlhDQo+IDxzYXJhbnlhLmdvcGFsQGludGVsLmNv
bT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IEhvbmd5dSBY
aWUNCj4gPHh5NTIxNTIxQGdtYWlsLmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4gdXNiQHZnZXIua2VybmVsLm9yZzsgbmlrby5tYXVub0B2YWlzYWxhLmNvbTsg
cGF2ZWxAdWN3LmN6Ow0KPiBzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tOyB0akBrZXJuZWwub3Jn
OyBIb25neXUgWGllDQo+IDx4aWVob25neXUxQGt5bGlub3MuY24+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIFVTQjogRml4IHRoZSBpc3N1ZSBvZiB0YXNrIHJlY292ZXJ5IGZhaWx1cmUgY2F1c2Vk
DQo+IGJ5IFVTQiBzdGF0dXMgd2hlbiBTNCB3YWtlcyB1cA0KPiANCj4g5ZyoIDIwMjQtMTAtMTLm
mJ/mnJ/lha3nmoQgMTE6MDEgLTA0MDDvvIxBbGFuIFN0ZXJu5YaZ6YGT77yaDQo+IEhpIFNhcmFu
eWEsDQo+IA0KPiA+IE9uIFNhdCwgT2N0IDEyLCAyMDI0IGF0IDA1OjUxOjQxUE0gKzA4MDAsIGR1
YW5jaGVuZ2hhbyB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSBBbGFuLA0KPiA+ID4NCj4gPiA+IFRo
ZSBWMyBwYXRjaCBoYXMgYmVlbiBzZW50LiBQbGVhc2UgcmV2aWV3IGl0IHRvIGNoZWNrIGlmIGl0
IGFsaWducw0KPiA+ID4gd2l0aA0KPiA+ID4gdGhlIHNvbHV0aW9uIHlvdSBkZXNjcmliZWQuDQo+
ID4NCj4gPiBZZXMsIHRoYXQgaXMgd2hhdCBJIG1lYW50Lg0KPiA+DQo+ID4gSGF2ZSB5b3UgYW5k
IGFsbCB0aGUgb3RoZXIgcGVvcGxlIGF0IGt5bGlub3MuY24gdGVzdGVkIHRoZSBwYXRjaCB0bw0K
PiA+IG1ha2UNCj4gPiBzdXJlIHRoYXQgaXQgZml4ZXMgdGhlIHByb2JsZW0/DQo+ID4NCj4gPiBB
bGFuIFN0ZXJuDQo+IA0KPiBJZiB5b3UgaGF2ZSB0aW1lLCB5b3UgY2FuIGFycmFuZ2UgdG8gdGVz
dCB5b3VyIGlzc3VlIHVzaW5nIHRoZSBWMw0KPiB2ZXJzaW9uLiBUaGlzIHdheSwgd2UgY2FuIGpv
aW50bHkgdmVyaWZ5IHdoZXRoZXIgdGhlIHByb2JsZW0gaGFzIGJlZW4NCj4gcmVzb2x2ZWQuDQo+
IA0KTXkgdGVzdGluZyBjb21wbGV0ZWQgdG9kYXkuDQpJIGNvdWxkbid0IHJlcHJvZHVjZSB0aGUg
aXNzdWUgd2hlbiBJIHJhbiAxNTAwIFM0IGN5Y2xlcyB3aXRoIHYzIHZlcnNpb24gb2YgeW91ciBw
YXRjaC4NClRoZSBpc3N1ZSB3YXMgYW55d2F5IHJhcmUgYmVmb3JlIHdpdGggYW4gb2NjdXJyZW5j
ZSByYXRlIG9mIDIwLzE1MDAgY3ljbGVzIGluIG91ciBzeXN0ZW0uDQpTbywgcGxlYXNlIGNvbmNs
dWRlIGFmdGVyIHZlcmlmeWluZyBmcm9tIHlvdXIgc2lkZSBhbHNvLg0KDQpUaGFua3MsDQpTYXJh
bnlhDQoNCj4gVGhhbmtzDQo+IER1YW4gQ2hlbmdoYW8NCj4gDQo+IA0KDQo=

