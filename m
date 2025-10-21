Return-Path: <linux-pm+bounces-36593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EABBF7FE1
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33EFC4ED699
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2E34C833;
	Tue, 21 Oct 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVVvwhnd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B839F9EC;
	Tue, 21 Oct 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069418; cv=fail; b=GXSDJpfQlhUDp44bNgp6Gp+DCqmI1N5mHYVFJ5jAvw70K0mb04IQnW2xhMswlG+tlYVa+RG7t4yAbECAemDYAjtZUmqxdcRb5y7SiCc7UIQq9FicGmBy8xcW3JsarW7x8LJJT4pWl4DfMIoxzXUsGNBfgwS1kuIX4G4EYKeg1F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069418; c=relaxed/simple;
	bh=NYpSBcGRx+gzoEiFZJF8b5JbhG2YN6dUU7OrTmVKjfA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nx+CpezIHlnmVAtTtDKNZJob1Ar8DR4KisUdrSMMB5aIibiUtzNOUVNxfNBDLfkaVsPTsn2Rrg7CEUQLPiazRE+47XlSrPkTo0Q2RJnBKz3132fK0xVu1TiQH9opyWOSXrNpUT8/Sc9n5YkOLzLq91cYoFbgSVZ91xbhSJNrRaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVVvwhnd; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761069416; x=1792605416;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NYpSBcGRx+gzoEiFZJF8b5JbhG2YN6dUU7OrTmVKjfA=;
  b=RVVvwhndUEUtm+YrWwCLlbMBhzf/aYngthlEM2un5ybbwyfvoLrKF35I
   bSdRRJBl+Il0sBUq/zW14mRjvrKk/TLn/TqrnFmpXWKYCsufeK3MobFsj
   gLNPvES/lssjmZQtRKdVaOKG24r3sU7KzV08fAVb8t/UDjdOVcQkop7tf
   pWa4ZgLxQDJB5//nsBpZ+2parm9Sp1/2Ep/w0jlExUda1NAunB+hp/WOM
   wu7BtEy+qSkrZM+N1oEo/gHrRo/VMPFDfb0dmDyYHQZwgQIzf6XbM88uB
   I0f7PwWHJKo19qjA+i6NZ2LqUjT2nFaCnID4RlcnrjpSh9KsVZXg82LTI
   w==;
X-CSE-ConnectionGUID: laPnJumyTleZtuI2kQbfBg==
X-CSE-MsgGUID: EBou4FBJQiO8HoyYOicJDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73876089"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="73876089"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 10:56:56 -0700
X-CSE-ConnectionGUID: qXqROIQfSdW7h5sOPCVKJw==
X-CSE-MsgGUID: fPZKv1VWQiO4HqmNvvziHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="184056552"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 10:56:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 10:56:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 10:56:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 10:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yumuRQKriNJnTHqVxrfnuMEPMdXS+FwEWILlO5o95CvBgCgIEzj3Xu3mVfJH41swIvb9+RLhqQirCN2gB+Qx6ZD4PcBpf/0+KZxhbnAlozoaSJ4fKjd5Hhr1zf4jgItQP4haDUw4thqJlGMpbvgunUsx1IondtrFRD3zG5WdpgCfpFvXHJBnfIat5no6X0BEZWVz501gOyjnJcFz1JqK7UeKMETbiocJn2Eexpg1ChU30d6Cyfv5nzSZcYAnpSbAsqvSyBc/16lfarzxenQtX1Fu2EHMWZIJmdBsddME/zsSF73N2oI8gBL0J7yp/MgalBxdsaY+3TdbutUVwujUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rVJX2XMDd3tuljxgt5r2sLfebyweafZ327ojo4QK2o=;
 b=VzERw0AsdiBfH5T1R0sBiNKRJCqY3+z2cqS6OzOHwrBMR0f8YddGv8NztNsz+u9oal9ttfvZilJ6A8ubO+K3vohxIxAfWjUf9o8cqI6NzE4wWWGAPuOyn72l12fL1lm4o1MjNj+gU2scunnfASimto7f3Y9/6qmDz4Qtajq07RJpqWebepI0E+P+uXcnrM3XUQ2dUh5SRSgIqnhVzjdqFI6kkdL10rqldmr+aWIwldxhGfK/YDz2rJXoJfy6AORKjeLUy1YoQqLgBU0pR9XxiXAee2meP3tQEhMX1HTyROOGnL+d46iskK7q3v3WGnPk4xgix8EnjRMEWlrOtkgpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7780.namprd11.prod.outlook.com (2603:10b6:930:78::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 17:56:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 17:56:41 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 21 Oct 2025 10:56:40 -0700
To: Joe Perches <joe@perches.com>, Ally Heev <allyheev@gmail.com>, "Dwaipayan
 Ray" <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
CC: <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm
	<linux-pm@vger.kernel.org>
Message-ID: <68f7c9585ca25_10e210039@dwillia2-mobl4.notmuch>
In-Reply-To: <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: c7be00ab-46c5-407e-c6c3-08de10cb30cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eS9zQWY4aFMyZ0ZCZzArN0h0RDE2MGVmU1g0YmxsajMyK2dOdXMwM0RKdG9I?=
 =?utf-8?B?OWIwSmpPTVBjVGtjUlFPVm5uSlpMelJDaXQvTXIzVG8veG9NcHhBVmluZEty?=
 =?utf-8?B?NFFkcHBqMGZaNWJtcXFYeUlLUTZnWmVXbVhsV0hSRkJ5amZJWmZyc1F1SXZ5?=
 =?utf-8?B?N0RaeDVhcUo2RFFNUEQ0NEpkazFhRzJKSTFiUmpiaWI5YmdWSXNmekNJRlJ5?=
 =?utf-8?B?SkpDVjhlT0xyT2NOUkN1c24vZlo2b3dEcVBSWCtOK2s1SU40ZytVdVFlVVV3?=
 =?utf-8?B?a0c1azdDUy9HeDI5U0ZYNm45RGQvcGU5S1VIVlZFWUs1K011T0VjOWw1QWw5?=
 =?utf-8?B?N01YU2R3VlVUcVVReGs0TUFhb1VHT3FDUFF5bm5IWG5IeGN4M3cxNmVaV3VR?=
 =?utf-8?B?L2JyeXBLdC8vUlZMMmlvYzdRWTkxTE50WTROTlNMdm1WOFFYMmdxRjY5TlNW?=
 =?utf-8?B?dTY1T0EwazJHelEvQTM3TndKdHJQM2pYN0pWOTZUMnYwREU1WUFSTmNWVnVF?=
 =?utf-8?B?ZjFqMHlNU0dWUUk1em1OOW5BZTVNOUU0anA5N2hUeEIzVUlTZDNhOFc0c1FK?=
 =?utf-8?B?RHhlQjJKbVZLemg3TUdlSnVwSTcxNnYwUDJyengyMUhQOHBwVFhERGhrd0h6?=
 =?utf-8?B?Wko4QkdVYWtPTXJhK0NrVW5oaVNVbmMzV2h0T3U5OU1wYW0yOVpGR2NiYVkx?=
 =?utf-8?B?dC92WXZOeVFUQ0ZVT3VrLytXb3poelZXLy8xOEw2Qms3QXJ0ZjYrUy9jM2U1?=
 =?utf-8?B?dnBOZmtOWDZTWjdoZ2RsQ01BbjlaQTlObktSL2pBSmxNK255UVhWRlZWblcr?=
 =?utf-8?B?emRBcTIrcURNR0M1UUp3TVZoSXoxc3Azb1V6K3QxK29TQmp3bHBCSTB2eGxV?=
 =?utf-8?B?bzRMNWVUVExlZi83Um1OcDZYUWpsbGxGWXBDa0xTckVoY3p0Z1QwcDhUVGp5?=
 =?utf-8?B?eWFYYnMyTXRoenNRWGRqSlV5WHN2c21ZR3AyUi9PTDk2ZHFsTFcyM1lYQXI1?=
 =?utf-8?B?b2NPUTNiYkdUUnRORGN5enRBRXBsOUhHd3ZhNlNSa0p0Q1RpMEk0SVNsbjIz?=
 =?utf-8?B?KytVQmh5aHJyN2wrTWVLY0FFQ2tqZzdGcjFpbE5JT3FQQkQ2aDZwWHY0MUlR?=
 =?utf-8?B?bndVNEt3b2s2UWlqekVQL1VDSlhVUmxKL3hjbmtDK3BRN3RBSGNYSGZqUWFt?=
 =?utf-8?B?dkphY0NUNXZ5VzdxazVpTG5vdFZwdTdQUjVKSGxLNUM3QllrV2RSM1Zjdlh3?=
 =?utf-8?B?YzAyOENicVRJOFFWSDJ5QllwWTlMQ2xiaVdReW1TNFZKRVdsQnIwU25GOGxT?=
 =?utf-8?B?TkRFdGpUSjJGc25ObHdnaFQyb0o3ZnhKdUFabVRxaDlvNXg1VzhtNEdJT0Ni?=
 =?utf-8?B?Ukd4Z1hUTVhGdnJ2czdBeGErQ21JSm9HbXZ2bHErcHAyWXRVNitxcXhULytQ?=
 =?utf-8?B?dHJhZDlpWWorTjJyK053U1Rwb3hGWUlrOE5NVnUrVGtteXBhZElVanh5Rklj?=
 =?utf-8?B?R2VsMlFiUngyYVhwc0s4QzU2YmlSOTVXNkZNbzBXZ04xTWlvZW9GOGZBT0Uy?=
 =?utf-8?B?SktVRTJRVTl2K1hHbUdBWStoSk9CNEplUEovL0dOd2VMUmsxRVBvMUNEcW9H?=
 =?utf-8?B?cXNsTmlZUnplTEVBbFg5c2ZTVkxWRHp6SW84VVlzK3RXQWs1c2tjMU9heElQ?=
 =?utf-8?B?WG9TTjF6bFl5akpXVkFsZnhPMDRvSHJhZDlhL3VYNktISHhxWDhheE1wMnpJ?=
 =?utf-8?B?TzBQc0hkNGVONFFTaW9kdjc4ZnBsMTM0K1k1L2kyOFRrUHk2SDB6aWc0cURL?=
 =?utf-8?B?bjZmNi90ekV1UEtIQ2Jid1ZjeFJ0L2J5bG5VaFA3Zi9DYlRXc3NCYnh2SzBP?=
 =?utf-8?B?d1NEblBUdFBJcXdlMHBMN3lLY095KytLZFJjbFltNG9nS3RSRVplYnRtd0o4?=
 =?utf-8?B?Zk05N0JoMHF2WCt6QzZQcDd4NmtzYTRBQTE3YWhwYVR6aSt5SXFBUWZwa0pU?=
 =?utf-8?B?WFBUazVkcWNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRxdFI0b2ZXNHdGanFkQUk2QThRQkdnaHdweE1VUGNKdkdXcHd2RjRocWg5?=
 =?utf-8?B?bDN2SlV0UWh6TnQwdUVtV3E2SDhHR2V6Rmlkc2VNR3lCM3VSRE9HeWJ5eFk3?=
 =?utf-8?B?SklWU2dxSHFVL09Jd3RXVXNyVzduZFJIYnV4NVJzMmRBa0w5RWhmeUIvQTIy?=
 =?utf-8?B?WlJMWmhTUXFScE1wVHRiZTViUHJad1JhNFBnRSs1MitzaVhXL1NtU3Jxbi9E?=
 =?utf-8?B?UkJSNGhkbmJ6U0IvT2gwTUtSRnVja3o4UmFZYk9Ga0lPczJscm1WdXN5MDRl?=
 =?utf-8?B?V0dPZGd3TWFpM3ZMTVREM3NQWXpDRXpRQkI2elpadE5xZU5mZ3BVcWlzNjAy?=
 =?utf-8?B?aFB3Rzh3cEN6bkJaaUxwOE50TjVlUGlmdldYYStieThZNmYzWmF4UmxiNUtt?=
 =?utf-8?B?TnR6WlhNTmdHajFlYXUyT2VtRnZDOEIwZ3F6V004blhVVmtnL0lhUk9XdThK?=
 =?utf-8?B?TFQvSDgwZS93Y2dNNjZvVW16QUtMdXV3NVFMN0VmdmhoN2RjV3phTlZiNnZM?=
 =?utf-8?B?ck1LdGNwem0rKy9ieExQdUtQOTNwL0ZkZzd4M296aFA1QzNFWHlZckMxd095?=
 =?utf-8?B?bjd2RVBwTFNuTllkTGpRbFdtSU1rYk1PWEk4aTZBNlVLanArbVF3YlZhUmVm?=
 =?utf-8?B?YWo3aTUzeXN5YWZoOXB3ajByaFh4Y0d3d1plMEk0ejZ5YUxKbjhFb3luVm51?=
 =?utf-8?B?ajZPc2RCckFqeTZDTHl3Z2NIKys2ZS82Yng3R29SWGQ0TEtSaFdVeVA5SG1p?=
 =?utf-8?B?ZlcrZnFEcklCVjFaZ2R6L1E1Mzg1MUVUT0Q0UjVXTzlKbVRCSXFteVg5SUl6?=
 =?utf-8?B?SnN5anZiVkNud28xVVdSZVpCWHFRV1YrTW5HMWgxU0JMbCtTRW5ZOFBmU0Vz?=
 =?utf-8?B?Nk16NCtVb1FPeUt2azg1TXdYSXRhNkJRQ0d3STZRTnJiUVdxUVN6dHJyMnpE?=
 =?utf-8?B?TUc2UlVUanZSTlloMGRUbTF1S1h6Tzd4ZXNxRHV3Rk1uTXlJWDg4TmwybFdv?=
 =?utf-8?B?bVZ2SHRISGxxVWxwU0p0RTBTV3dsYkJtQStyeXBFZDBFcWFGTzc5WDdWQUxt?=
 =?utf-8?B?cXN4bDRNUmhpVDdFenVieDVJbmRQNHRZRTM2Q0ovaGErS2tKWTZtMHhWWnJp?=
 =?utf-8?B?Z2RtZTJNMExvb2k3aGZKTzZiQjVxZUhoamFHUk1MenJNU2l6alU3YWtxbG5J?=
 =?utf-8?B?cDZkakxJaTAxTkw5cHZiTGU2YlR5Q0ZrSU03bGtia0haa2hybTUvRUpEbHpu?=
 =?utf-8?B?K0kybXAycEhMbmlkcUFOVFlHNUVhaEhocEhRMlB0VFRDdlJFSmQ1N0tiZkho?=
 =?utf-8?B?MlFuSGlmWE1TV2NWRmlYZ1BYRlkzMjNyaStIdjdOeFZ0Y3dWTFVUcnl0TGo1?=
 =?utf-8?B?aEdGSmpNRzV5cThiK2N1KzJ2ekllczc0ZW0vZWZuRmlETkN6QmNZQ25YM29E?=
 =?utf-8?B?Ty84VHpWVEtSUDZ2RHQ4M0pNYkgvZ2tyUjFoWWk0VU1ZUlcvTlFxWHhoYW5H?=
 =?utf-8?B?ekM4ZVpud1h1Q2F5cWNLOThTTGRJZGt0MTNwRU1kaTIvYkNkYmh0U21TRU5v?=
 =?utf-8?B?UnpwS01FUm9LOXVXeHlFajNsSDE0T3pJdFdHTEhDdjVtYjl5cldTaXRBelk3?=
 =?utf-8?B?dnBwMkVNT3ZXNG5TT24vSTFkSnNnSXVlMlkyVEJrSlU4bzUxZmlsRXFKdWQx?=
 =?utf-8?B?d3ZWUjhxblBhY0xPSFZGbDJvbSt6ZWpaQTB2ekhPeGRrQXJRdG5ZTjJzSndq?=
 =?utf-8?B?YUYyOUpXd3hGbGRFS3JjOUNKZkk3WlIybFlrTkk0Q3Zmc1IxcmVaN0NTTkdy?=
 =?utf-8?B?Yi9JVkZXekloNWJUNlB6dkJXYkhwc21rNXJ0Z2hVcWs4aVVLS25RTVE3NFJq?=
 =?utf-8?B?M05jYjkxcmthREp5UWtZN0pNUWJpZldEZGw2d3hMYWhoVlNSNU9YaW9MeTNs?=
 =?utf-8?B?R2g3M0xDZ0R3TVFVVkwyRFo5MFVtVExDME4yVkxWYll2SGNDbXQ1YjkwZ3BP?=
 =?utf-8?B?UlNqbjBidUV4dlp1b0phSmdpb1h0VTV2RlowVTIrZFpOT3h2d0Q1OFF1UEpS?=
 =?utf-8?B?ZUFFKzN1bGdaU2R3Tk9zbVM1anNQTG1Bc1g1SFlNc2s1T3ZxU1RrWGgycWlo?=
 =?utf-8?B?Q2ZGejhZTzF3TFpoMklmVjEyd0kwWDUvN1hRRTYwV0pTSW8xYXpRdkp6OEFH?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7be00ab-46c5-407e-c6c3-08de10cb30cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 17:56:41.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0pQU9EcF9jB7fiDyXo/cdtSMeSZ9wA+TjKlIVqlWC05GmZPcJ6Vv/bg4UzDvb+p/7n4dPIVGtwju8fII3rSeKBo2O46mmRLHVCyPng8qhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7780
X-OriginatorOrg: intel.com

Joe Perches wrote:
[..]
> drivers/opp/core.c-unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
> drivers/opp/core.c-{
> drivers/opp/core.c:     struct opp_table *opp_table __free(put_opp_table);
> drivers/opp/core.c-
> drivers/opp/core.c-     opp_table = _find_opp_table(dev);

The documentation in include/linux/cleanup.h recommends always combining
declaration and allocation. The rule of "variable declarations at the
top of the function" is relaxed for scope-based cleanup.

> An aside found while using grep:
> 
> There are uses of DEFINE_FREE that seem to have an unnecessary trailing ;
> 
> $ git grep -w DEFINE_FREE | grep ';'
> drivers/firmware/efi/libstub/efistub.h:DEFINE_FREE(efi_pool, void *, if (_T) efi_bs_call(free_pool, _T));
> drivers/fwctl/mlx5/main.c:DEFINE_FREE(mlx5ctl, struct mlx5ctl_dev *, if (_T) fwctl_put(&_T->fwctl));
> drivers/pci/msi/msi.c:DEFINE_FREE(free_msi_irqs, struct pci_dev *, if (_T) pci_free_msi_irqs(_T));
> drivers/tty/vt/vc_screen.c:DEFINE_FREE(free_page_ptr, void *, if (_T) free_page((unsigned long)_T));
> fs/pstore/inode.c:DEFINE_FREE(pstore_private, struct pstore_private *, free_pstore_private(_T));
> include/linux/cpumask.h:DEFINE_FREE(free_cpumask_var, struct cpumask *, if (_T) free_cpumask_var(_T));
> include/linux/execmem.h:DEFINE_FREE(execmem, void *, if (_T) execmem_free(_T));
> include/linux/fwctl.h:DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
> net/core/dev.h:DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T));

Note that until this issue is addressed:

https://github.com/universal-ctags/ctags/issues/4289

...it may be the case that Linux *wants* to allow dangling semicolon
for DEFINE_FREE() if only to help "make tags" find the symbols following
DEFINE_FREE() invocations.

It is interesting that this happens to not impact DEFINE_FREE()
instances that use IS_ERR_OR_NULL.

