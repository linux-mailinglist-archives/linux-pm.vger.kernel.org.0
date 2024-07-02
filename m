Return-Path: <linux-pm+bounces-10312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F118A91F000
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762791F22576
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD03D13CFA6;
	Tue,  2 Jul 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPKmIEWt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9D537E7;
	Tue,  2 Jul 2024 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905276; cv=fail; b=lo7rkpJpMiaVPZp0es0YP99XYeBIMbEJ7jqFrwx41oBwS8Z4LO1iMKYKVC0yD1a95TRE+P9l1tO32FdMfZu44cbnNKeqn0UkOVAEDUboAcqBCYeop7PLiJLY1vr9IrF2hPUJn1jZjj9UPnjGdeFAztmMc3uPjGNf6yhcp6ZS7M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905276; c=relaxed/simple;
	bh=Fw621JJqBSZXiTc1mNo3HS1OtQGuqPGB65rEWRG3aXo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TQ8e+MZvqUW9DdJMqSQtmUv0G0MPeJ69c47Sh8TM9j0rm0QZAameXb/Ry4BTT99NV7QzYdlqUeoVDNDidSxnR3yiIm+JFC/4Cg8BqdZ7+VUNRZBGu3hujERKAjKjxERNkUTzxmlRiubpySJaQSHZZwHYNe5ERPqgd+OfFnqLi0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPKmIEWt; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719905274; x=1751441274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fw621JJqBSZXiTc1mNo3HS1OtQGuqPGB65rEWRG3aXo=;
  b=GPKmIEWtVKG9bQcA6oGqv6IR8OPv7jjLG8P6mlIzk9vmy8HS8Q/sALF+
   uP8coF8RLupfLTjxILqnMNhVDoEjVAIqR3bUTsynWOTOZxN54MQg7s4Hf
   mn5FFwTp1oNsNwPd0xEQk36QSGVP137R1wwX51ZUrrKVsh1Ue96tw6r+p
   tNsoB4/EU/5BEc44xoOsES6IZE8BIZ3qkqO7dSV6PRdmTX8Ktert0erPO
   w3iJwIT7rh/UBu/dbF4FYBR7F2gISZ5kJnnLt1B6BRh2VpCpkVP0zVB2J
   sp3sG7CPAz4q3A3KmBWmauYEy0dkS13VHxIC4ZRX440Y+50TVBhC120N3
   w==;
X-CSE-ConnectionGUID: s/m3Ds3eRMa3LeiCaRQURw==
X-CSE-MsgGUID: q3VTED1TT+2Yq7kry+64tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17015625"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="17015625"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 00:27:54 -0700
X-CSE-ConnectionGUID: xDwaUyZ+SQGjFFaJtDEE6A==
X-CSE-MsgGUID: LMpD4VJbQ1ulbb7q/+H0bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="51004969"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 00:27:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 00:27:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 00:27:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 00:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlWTPvb9yz4Fl+Wjj3iSMmpNFAxloOvqAyDRYUDcxRj16/8lerOau0/+iQEh5V6B3ywXS5bH6gyn26hsDaiu2EO/VXqcEp8yabIdMfla+zdV3xy2GacgLn0ecMPQfzD8V8SRUovfhweDgPZ97wNjBcPrWQg32xoo+W4HmEnTdLiusv6FfWuAMjjcG6AtoY3w1uxr4smNBjK0DjCc7XcvlJAznveBbufDbhPzNUAW/q8wBBc2upJ4CrPVj6zu404LNAMST5kukLdXX6SUN922b3jg/bGSulF1UzKR3qkwssAAJmO5iKxaVHzsjz5v8u7xiXPgC+Q5pcnEsPuZWJvkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIYo8BSEP9AJup7N5mSDgOXNLbDHjz+oGLYcfMMr/GM=;
 b=fG6GrToOUe/KF9J7096nYeo/U1cyA7hXF+LDuvFcuy6t0KWF6XP6N2zgK1gy/qBDpdunUppkXvotYnZzsS6ggqQMB1FJou9+VhIUnk0R50hpAqoo/DL3nh/lrTLbGJ7CBPG14ZibYFftdt4MMBQvJ4eiQTqgrnP+ey5GfvVBJrBSlOYYn/UuIM9ESOhVnW9/LUHVe1PzlInKwWJYcFCemoM5f5MCP55JM2LD8MN5Q3o+36xvcqdq5uoM2QMKv7JFDwEpvHTt+eoau/+ZVrzazF4de2NJl5LKKMCaaDKX+hBsA2kEgjqMHvr3ZU/rD1tfezXFf/z4AdH+LOwP2dNCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 07:27:51 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 07:27:51 +0000
Message-ID: <08848763-021c-4f6e-81c2-fb49603ecaa7@intel.com>
Date: Tue, 2 Jul 2024 09:27:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] mlxsw: core_thermal: Report valid current
 state during cooling device registration
To: Petr Machata <petrm@nvidia.com>
CC: Ido Schimmel <idosch@nvidia.com>, <mlxsw@nvidia.com>,
	<linux-pm@vger.kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <cover.1719849427.git.petrm@nvidia.com>
 <a9b97ecf80c722b42eceac1800f78ba57027af48.1719849427.git.petrm@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <a9b97ecf80c722b42eceac1800f78ba57027af48.1719849427.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: fba919b7-2747-4a28-18ae-08dc9a687ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0huN0Npb3NoZHdvTVU2SEttS1hIaDlOZENnSHhUNkdUWVUvM1VSc1FPenYz?=
 =?utf-8?B?NjR4QnJyV2ZyK2pHYVMzSDBTdFJVc3dPL0NCcnpZMTVHVTg3aXVodFBtdy9F?=
 =?utf-8?B?NFMyanFndmg4NFAyWWViekRqNXlMcFNNZEpmSTZ4ZnpHYkxMeVpWTDM1VDRh?=
 =?utf-8?B?eTNiN25KMjF4UEo2YVRMaHlQUXQ4dHJzL1RJMDVINEw2RmRuNTRieFdhbEp6?=
 =?utf-8?B?Rm8zZTA4bHdmSmVIYWtJQlRBTkRvY0MwdVFiK1d0M3JKRHRmQmVFa3RJeGZL?=
 =?utf-8?B?emdDSlpFaHlDRjFkc0Y2SjlKL25LQm9vV2p0TWJOQ2hMR3lVdXJwbHcwck5L?=
 =?utf-8?B?OHNVUDd1OVl0ek85WTV1S3BsZDkvVXVRVGdmWWlHSkord3d2dlltZkRNYWJR?=
 =?utf-8?B?SmZjcHN2VjM5YlBMSkJqUWV4N2hBYlBwQVh2TTBLUTZkSkVIUnlneEtxYXZP?=
 =?utf-8?B?a0kxS0N1V1ltTkNVWW1HZXpSdEM0cHl4Y0NzMVVxYWVBNVcxbnc0WXdwK3Ry?=
 =?utf-8?B?L0hmT2ZLZG5WTGg3R01COEpLek1FRzgwYnpFNWxmMlcxMTA4dHJNS0N3SnAx?=
 =?utf-8?B?KzZaYnBGdDNCYmpVbmNybnAxZWNMYnNuQTZHRU4wMiszRzhncEt5ZmZoZTY0?=
 =?utf-8?B?MUlaQ21aZi9yZk4wbGZUalFNMkhLMFRueDRMZW9HWGk2TW9sRE1ORG5NcC9T?=
 =?utf-8?B?Q1c4VnJDZzM3OWtpUzU5MzdwMHJDcStkdzRNM05OVVVUUnJCYmk4ZmdHQVlz?=
 =?utf-8?B?UzJ3eUdJbXN1eDFoVHowVi9XVTh4NDU2bzBqVkVaVHJ2Y1MvK1dOMlNDaCtS?=
 =?utf-8?B?WkxSWHVETXduWVZNeVJmcTVTN2NqNjl0SnRtYzR1ckNUOFhURUM5MUNTT0NS?=
 =?utf-8?B?dkpiUXRqeWJnYksxVVNOSktRdmdIbHVWQnh4eFlqZ1BNK0VpREdIMnlwcDdo?=
 =?utf-8?B?VXVPL25pK0V6N29aVDM1ZVpGL1NUTlhOak5tM0IxZVZUMVF1bUdPdDM1MVhT?=
 =?utf-8?B?dWI1OFBSZEVTVTM2K0xoZTQrcVZBZFdhTFp2WU5sSExvS2RmdXRIb3U3Vld5?=
 =?utf-8?B?eXg4T1RjbEFUamlVY0VuS1l3aHVabUFDVzZ0NzdrTUpPZUl1MWhUUUowV0pP?=
 =?utf-8?B?dS9UNHgrT1NzWjJsQlVlMk5wLzRkMnNPSGxqM0Z4RFE0THBWbjBzSmhGeEFw?=
 =?utf-8?B?T2JaRzJMWWJKQXBNR0lUajBUbTh1S2F2QkxSWG80TlYzbVRGSkNXSndhOXRU?=
 =?utf-8?B?b09iRzh4NFh5TlRhZG9nWGhsWG5sUmNObUx1eVBpbndYOE5MMS9JZ2d6N2xC?=
 =?utf-8?B?Skd5WGUzZG9tL2JSTk43N08yRGZDZU02SWIrQzEzMGFRS0FnUzVyeWlkSS9B?=
 =?utf-8?B?QlRrVU5mbmM1NG5XWmNiaVEwMGpxNVBob3hIaEZ3VVlkM3BVMk5JL1BUY0Y4?=
 =?utf-8?B?L1hjSUQ3YlRWZG1vclh1L0JVSDg3bmEzODMyb21tWTFKak1LVmFHVjQvRXox?=
 =?utf-8?B?M2ZRWmVkaHFGKzNVRE5CODlIdkFubjd5YzgwdVVNMHdxcklNZGdrdkxqN0FW?=
 =?utf-8?B?V1Q4Vk5ydURNTzVPeVRHYjFpN0MyY2lqd1VqQWRqa0QrREJpdXIzdG1jb0Vp?=
 =?utf-8?B?T3BXelJ5SDdkbCt5SGJsSFhxWmZsQTFzTkRiOUdabE43N0hQaUkyK2gzZmhU?=
 =?utf-8?B?Qm1OTzNOSGZHVk1LeXM1dUpLakJ5NVF6UUtCdTgwQnVOSnFJRjYyblo5OVA1?=
 =?utf-8?B?Nk1YVnhSUkZnOG9XTjhIM2ZteWFDTWlWVmE1UnpjSGVlcFdjU1lhS3JkeWhh?=
 =?utf-8?B?LzExY2kxRzVNbURKRjFLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUIzenN2SlhYbi95TElhZnYwUDZUdDFGb0dRMXd1UGJTaEtaNjg1WGIrWG1R?=
 =?utf-8?B?Q1hWeTI2c1ZlWS8vclY1bTVjUTk4KzFkdkhtMHhZY2lHRGMzVk1oYXBiZUFZ?=
 =?utf-8?B?L2FYWGtpeUk2MUZIZyt0ekx3UGs2cXdOQjJmRU9RTVlIRU1XL1ZBUmF2d1la?=
 =?utf-8?B?Mzlkc2R0RmlaZ0ZKTmh0UEoxM1pQL2N0WTQ5c2pZYVcyMllacXU3cnVtd2s0?=
 =?utf-8?B?c0REcTVkOFRmN3FUNmViVjJSUndSLzBvakw2c2lpTlNsRCtRaFBWVFJ5RE9p?=
 =?utf-8?B?SnRVYVNsZEZNNjJyUnRvVjlvUHJ1dGlCYy93Qis1NWM0T0h4cDhaUzF5Q3Ju?=
 =?utf-8?B?QlpPcjcxYVlhU3FQRXRsNmljMFo0T21qQkR6bHd0TGxWVDZ6M0FNVGlQYjNm?=
 =?utf-8?B?UUw4dFMrQ29aQzY1aUt3QWpCNmtTbTUvL094ZG5xcWNTditpczJLUjh1RWxF?=
 =?utf-8?B?UDhURFRTSjR6VHdPeHNocERnZjUxY1M0ZktTNDRnemRiSnJLSS9wZWQramdi?=
 =?utf-8?B?UmN0V0JjM0IvSkdkSStCaEQvaE8rRkRLSHdvVjJyRHVhYU4veFRZTkR3QVNy?=
 =?utf-8?B?T05TZC9xRy9wN0hRWTVHd1czdHZ6NU9rRk9Fd2pmd3lPRkUrNko3S1Q3d0pS?=
 =?utf-8?B?S3YyRlpoM1hndTlhOFdUOXpDWUtFWlduRXJSdTR2YlVzd045cnB0Wi9OUTl2?=
 =?utf-8?B?WjFjVW56R2xRd0N6Y2k1bHAzSlZDQUFadlUzczNuM1RaSW5rdjdNaVE0WGhB?=
 =?utf-8?B?NERqemEwUndGUnh6VEdCb1FQNmdBYnlqYjcxT0p4WEpQNWNlOEZpaHczQXFW?=
 =?utf-8?B?V2JEMXFFVnhKbjJ4TGkxakxDMWZaOHpNN0pDUXpYVDQ5YVpKK0pVMGVoaTZ1?=
 =?utf-8?B?YlFFSVk5dlVXNjJNZVpJUk1TLzIxMTNGQlY1QUpGVWd4cnZmcmNwK2t2NUxw?=
 =?utf-8?B?TVRRL3ErWkVZdXI4cFM3TVIxUHFGWjMrQUVtMlY1UzU3R1FGTDZxbnJlVU02?=
 =?utf-8?B?cHJPbEdmbWZsc2pHUWs2clNIdE1JNUREdld2MkNQSi8ySDM3M2RIcnVIbnk0?=
 =?utf-8?B?WXhmZVlISHdlNlBodzBTUjd4Z0QxK0kzT29jRkorNzBvUldZNDZRN04wbnpi?=
 =?utf-8?B?QURTRGFlL3AzZnE4YUdQWWh0ZFpHVG5wa0pWRU9BNGNiNi91SDJzSjhHTG9h?=
 =?utf-8?B?YVFJK29xWjJVUzAyMkZnNVpqbjZud3BRQXJ0VlJ2WjRNcHJJbDM2V2h5OTRk?=
 =?utf-8?B?SkRUUzVFOUtsVTA1WkFUOTUrblJYdEd5QTlWbW1vb1ZpYjRLOUdad3ZqdUZt?=
 =?utf-8?B?Y2tUaERjV1dGSEl3djRZd1ZSQXpYTVBYbVNNVnV6WWhNVm9TM3hvS25jRXBz?=
 =?utf-8?B?WHBCU3NaYnJBRnlyVnNGZXI1Y09tZUdpMTd3TWZNYnVRVGtWbmxyT0F5Y1E5?=
 =?utf-8?B?eFhNR3pYSGlpVTFHYlo0NDNNWnNuWEt1RGUrK1JyQ0RrRi8yMjBHd3dwZG1F?=
 =?utf-8?B?MVhiWkRmWENjMU1OakJYcnl5eUFHYld4Z1o0RHlVL3oyTzN6QXVLYk9tUHRp?=
 =?utf-8?B?dm5rbGxzMWgxZnpJcTFlMEtnb3FtNXRneG1Sb0NRTzc1ZHAxMU0reDU1REJh?=
 =?utf-8?B?bWdPNHdIQUprTTlnOWVaTHFMN2dIbXpLSkx0REJaR1Q3NUsxTExsTDVLU1gx?=
 =?utf-8?B?QjQ3Mm1qd0hscDdXZ1FlOC9LTDBhalVDdVg5ZjFwTFU4RllqY3FvdHlFTWFT?=
 =?utf-8?B?Tk5uKzBUekdMSXNBVUNSQ3ppeGVaS0VTUW5CU0hsVEJ5YlEvSGNYYVZNc1Nz?=
 =?utf-8?B?ZU14ZThwUGRpMDN0bjFzWU1QaVkwVkxBR0dybGZGZSsybTJyUHVOaWloUUtW?=
 =?utf-8?B?VW9wOWFpam4wVHpaUlJ1Q2FsR1lpRUMyaDlSTDZZRytzeTNtZlNlc0Z1bFRI?=
 =?utf-8?B?TUthLzdJNzhHWXNNdzR5d3hWWm1acmJaaURFYiszbWd6VDhrMTdGbVdRMWQ5?=
 =?utf-8?B?aEVjVWJ0aVFjdlVMSnFXMWNUZjZJOElETU55dGZ3MTFnK0FEOGRGd2Z5bTd0?=
 =?utf-8?B?L0JZOGhzamRaeGt6b3FyZ3JwNi9pcDJxTmNHLzYvMFpYNFAraXE3NGR2Snhr?=
 =?utf-8?B?NGR5T1QrQkdjSmdKK0hkTzlOcWdld1JlTTJtRkFoSGJmRnVMSVJrZFBUa080?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fba919b7-2747-4a28-18ae-08dc9a687ae6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 07:27:50.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OS0B7YM49rumD4OUgLLlrU/EKNaWOkIRgWJ7f6hMnK1tmAmyoupMAh7yRO+VrAODL8ofYOWc0Sfi1/D5/0YGgHtFQlIrwcgYu5w7Fmn7W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
X-OriginatorOrg: intel.com

On 7/1/24 18:41, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to
> thermal_debug_cdev_add()") changed the thermal core to read the current
> state of the cooling device as part of the cooling device's
> registration. This is incompatible with the current implementation of
> the cooling device operations in mlxsw, leading to initialization
> failure with errors such as:
> 
> mlxsw_spectrum 0000:01:00.0: Failed to register cooling device
> mlxsw_spectrum 0000:01:00.0: cannot register bus device
> 
> The reason for the failure is that when the get current state operation
> is invoked the driver tries to derive the index of the cooling device by
> walking a per thermal zone array and looking for the matching cooling
> device pointer. However, the pointer is returned from the registration
> function and therefore only set in the array after the registration.
> 
> The issue was later fixed by commit 1af89dedc8a5 ("thermal: core: Do not
> fail cdev registration because of invalid initial state") by not failing
> the registration of the cooling device if it cannot report a valid
> current state during registration, although drivers are responsible for
> ensuring that this will not happen.
> 
> Therefore, make sure the driver is able to report a valid current state
> for the cooling device during registration by passing to the
> registration function a per cooling device private data that already has
> the cooling device index populated.
> 
> Cc: linux-pm@vger.kernel.org
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>   .../ethernet/mellanox/mlxsw/core_thermal.c    | 50 ++++++++++---------
>   1 file changed, 26 insertions(+), 24 deletions(-)
> 

just two nitpicks

> @@ -824,8 +828,8 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
>   err_thermal_zone_device_register:
>   err_thermal_cooling_device_register:
>   	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++)
> -		if (thermal->cdevs[i])
> -			thermal_cooling_device_unregister(thermal->cdevs[i]);
> +		if (thermal->cdevs[i].cdev)

this check is done by thermal_cooling_device_unregister()

> +			thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
>   err_reg_write:
>   err_reg_query:
>   	kfree(thermal);
> @@ -848,10 +852,8 @@ void mlxsw_thermal_fini(struct mlxsw_thermal *thermal)
>   	}
>   
>   	for (i = 0; i < MLXSW_MFCR_PWMS_MAX; i++) {
> -		if (thermal->cdevs[i]) {
> -			thermal_cooling_device_unregister(thermal->cdevs[i]);
> -			thermal->cdevs[i] = NULL;
> -		}
> +		if (thermal->cdevs[i].cdev)

ditto

> +			thermal_cooling_device_unregister(thermal->cdevs[i].cdev);
>   	}
>   
>   	kfree(thermal);


