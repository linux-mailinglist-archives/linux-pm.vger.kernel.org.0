Return-Path: <linux-pm+bounces-23819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418DCA5B8DF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 06:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E310B7A8BC2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 05:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F21225764;
	Tue, 11 Mar 2025 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/t138iz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514B1EB9F6;
	Tue, 11 Mar 2025 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672604; cv=fail; b=LGbWkdYvb0F3pf26AKPpk6g2LPG7FDd7cZfg3F0JV1Rs/Z3S0w4RE5ZL5maxzb6TQjgwDWDzNf5k6fXj9ANxQTuvcXDScCmBX6N+Qr1kFvub4x/LSA9PcBMFr2ve38tfHoxmbcVrqe0RhFhI9mSp5YGR+uPWa5pSPjOP1MqVxwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672604; c=relaxed/simple;
	bh=zF7gamabSq+CPZSvXGmmzKYA9BkrjvFcwn9p4I4yW0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJ3AwIUAYk0cxtz0SaUPRP3diWKvpkhClEIXjokvEKZk67OoMtMEsf07ciYqCqDiYo0TqLKyh57m7wToysGi8opA+M0sq9oYynvbbJDPJC0488TwxzHVkWK5iDiAVgaKr5Oi3pZMjoXn9CXmMMBBOsWMtmBhLefqDcLKFF8/zPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/t138iz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741672603; x=1773208603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zF7gamabSq+CPZSvXGmmzKYA9BkrjvFcwn9p4I4yW0I=;
  b=G/t138izMOxnZ4ubgicUu/pUdc9EmEHl1sq+co6ARAMaaw6BRPfTAAkV
   JED3RNbdYEmbm127oHtv7qDeZ3eB6w56p+CyU2El27cHo/8VlT+wF0bD7
   tovpNmaNoxlmmSQLpECulcOCLM1SfKCtmX7kokPV/iPQevueIkQ5i0OVr
   kZu9AIpEvF2kSqdjYbJ8kIkmHzf2RKSL//O40VOn/jaQxCB7XM9TvaWXJ
   f1mSLeiyZmA+lrbEGjmF5EjYsIy4QrQ5a6H+T7ijcOKaNDPXfJVk5sXZa
   cE245cTA6W9oPMZ0VxtDWHXm0hw479KdJZDwMcrYFgXejyUyA6Tq0YFZU
   Q==;
X-CSE-ConnectionGUID: LxgLeMFsR063Rp3KV+Xk+A==
X-CSE-MsgGUID: sYbsJYplTFi29W3uMJV7mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54074419"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="54074419"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 22:56:32 -0700
X-CSE-ConnectionGUID: e3e56FjrRfu2YeIdARWdNg==
X-CSE-MsgGUID: w2raO2X8SyWn/BUex1uhcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="119945128"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 22:56:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 22:56:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 22:56:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 22:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDhZfOFFV8whTtOAXWDiLwgXUQJlH/+5fJDUBfhHfDvmRhNElTPCuOG6ynhTKDJZWpl/ruCpCDRceMkwdZ+bbWlYjH4q1iTqV7uLxuUGAcB2XJ6QGU136Mn03kFCvB24ZGtM+lBlv4mTX33s/hRStR10ke+Pg7nPcfWbBLY1K/oP5VrbdhQnFZfBpYaY68y90z5SWn1Jr6Jw6kcyCLJYJjAlGNYROav9pXBNxR4pP0B+vjdq8UAd5i2iK2qqmgu88cv15bcu7p08zSKyO/ZWoIBRBdobHLGRUfJA0EBECVeSxLVm3uwom4p2DHxMAigktuXVet8wHqwYJXwBgV2vmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF7gamabSq+CPZSvXGmmzKYA9BkrjvFcwn9p4I4yW0I=;
 b=zSevXFIXPjHi5kYjxmT+tEfl48D3PXhHpLpdE46p2LpkyLJg7Ovzfc0BXSRhyiacUNERrwq4TvIpwgp27iV9JeqhugWiQawWecveQBZfwGqSIM0LYGd3gkYJseLHTcwVKxo2g79/IAO8a0gn6wL72YOkQNWw48NJx/3dKkQSiGAE2ZwOko95HgrUQu6V67X22pxS8TOxY2K20k4iulGJVNHoOlo5bdoKlx2L4UT8Yv77uNL9G65VRJaDdUejoYFVEeKpJVPXbOYVP9ZAqhr90QFStxvc+pW6PWCGxEUnYDWFwFidaOidxt3dRo48P+uFf7XwV1LFXYVGhYTkPh+Nbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 05:56:26 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 05:56:25 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] thermal: intel: int340x: Add platform temperature
 control interface
Thread-Topic: [PATCH 1/3] thermal: intel: int340x: Add platform temperature
 control interface
Thread-Index: AQHbkFlT/wZ1uKHYCkeK22/wJqAzArNtc/CA
Date: Tue, 11 Mar 2025 05:56:25 +0000
Message-ID: <ca935ccd07fb27a77a39fa797738e7a2e96abeb1.camel@intel.com>
References: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
	 <20250308183812.118311-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250308183812.118311-2-srinivas.pandruvada@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB5896:EE_
x-ms-office365-filtering-correlation-id: bb23ef86-933c-48be-e72f-08dd606175a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WjNieW13TzkzVEJHZjgxaWpTcTBleU9saXJIZUgycy9QakI0VVkwbWRDcnlL?=
 =?utf-8?B?S3grK25XY2djQmhPZkx3cTgrclJmWkE3QTU1akFwTlZRalJWUkJiUmlCN0l3?=
 =?utf-8?B?ZktuVWFsUEdjUVRKKzYzQzJxb3dQTDd2UTJZeTR1Z052RHpMNmZsNWppWlVp?=
 =?utf-8?B?N3FoRU5acEE1NTg1dVFTbWhXUjRnVXVyTndQQ1FMS3haZWlodGdtdmorbXo1?=
 =?utf-8?B?Z3A1YWk0MGtEN0RWNEhKbk9QMUZwNjlXVmNibHFZS1FDdlhtdGFqRndpN2ZD?=
 =?utf-8?B?cWhBTTFmcHJ2azVrdkJLb2RRVk4ydU8vVEUwcXVEekR3SmNqWFBaREtlQVZN?=
 =?utf-8?B?d1JCQ3VkSCszanF4NTd2ekRtNy9ZbjhpTm9jdEVKWEZmbC9WWm81bTZ1bHNp?=
 =?utf-8?B?RExqWmkzN3Q0NWxjTVZCTW1kbDBvc0N2eGFzVGsrZE5zZzFMOTJJU0Y5bGVl?=
 =?utf-8?B?Rys4UU9mTTJIdzJSWCtCbXp5VWNaS0dyUEcxcXo0SS9zMWxpRkxobGhwWjg2?=
 =?utf-8?B?MVYxN3U3WDZrK1JFclVMdWR5Y0hjdFJjdGJtamtDNmt6UTZMRCtwMnFhSTFp?=
 =?utf-8?B?OU81TmZTMEt3STNvdERQdE9md3RrWTEyMFhET3JCbVBaTzc0aEpwMWRkVzRD?=
 =?utf-8?B?RllpenhodlBxaWNidHpsbmxWb0hNL3QyaFU5blhhZnlxNDN6d3paL3M1UlF3?=
 =?utf-8?B?eFY0NDMvQmlQZWhDSFRUa1ZHaFJtMEZEcmhaREMxczhkbEFYVStiRlBrWkVF?=
 =?utf-8?B?dUVvaTJmakxjNTRXQ2p6QUViNzV5NlRhZWd5V1pPb2ZzRytTMUhVOVkzMlcz?=
 =?utf-8?B?enNHU2xJcmFpWDVFdFhPd0ZsMjl1blJoT3FDOVlxMzZNdDcraU5TaGRkTDdB?=
 =?utf-8?B?VTZyVmtGSys2d08ybHdSVnV0QkNpTGZzekJEc2FyZDRrRFBlcktHYnN1RlVj?=
 =?utf-8?B?KzdJSVZhOVZSd1V0YWVKc1MwR3JqVXhmbEppN0VjNEZTa0dDNEo4dk5uTWNk?=
 =?utf-8?B?UGIrYytjRGJlQWFEckNneUh3Vi9oN2lZRmpNU095Tm9scUU2bE5oT3FKcjZu?=
 =?utf-8?B?RXJHM3Z3VC9EUkFzeG1CYnIvSXQ5UDl6cjl6ZkhLU3QvaGJQRnp3dER1TDlo?=
 =?utf-8?B?aFJxQkNXbkVwTEdzRm55MGFDbmwyb2pQd2VjMjhtbTJSdFZoQTY3R3JLc0sv?=
 =?utf-8?B?ekhXWXhiUTRIQVlUVlFkUy95aCt0Q0kyeEZheUVJeU1WTU03QVhRZkZyN1ZU?=
 =?utf-8?B?Q2hWNE51bW03TjczOE52MHEzRXU1Y2tKdkoyRHA5UzlsQlZUT1VHYzVHbXdT?=
 =?utf-8?B?aTdFdm52S0RpZ3ZUR21qSGZNN3c5T0o0c0lrL2xpVkVtM2EwQjBINVNheFlI?=
 =?utf-8?B?Z2NqRDNienNoT29XSFhjRnpBZTU5MDRycHczQXVxYlBSSHdTSG9MclJLbk1y?=
 =?utf-8?B?TUxkMUhDN1NwLzk4eGQ5eWwyM2IybnhVZi8rWFBBMUZCNlFOdUN5T2RBakZx?=
 =?utf-8?B?WktxVENxRThEUFhNTFd0VTFUbk1MY0xSam9acjB0RW0xMDVLM1V4SjNaTThx?=
 =?utf-8?B?WnY1aUhWT0VIVmU0dW1MQTZFSURNSS8xejRTUzFNZUFwNFJwUHNKK251Ym1n?=
 =?utf-8?B?MHNPckxEOElsWlh3TFF3eHNqOHJaWTA4NWZPMXd2MlRXZVZUS0dSaS9NOWtX?=
 =?utf-8?B?dGEvN0xLbU9oY3BpSTZnVStzQnJMME9STENvb1Z6d2NKTFAxenp1UmNqS1Jj?=
 =?utf-8?B?Q2FpcDVRdnc4MWNFMWFJaTVtR3VVUWpCdXAvU1FjTzNqMm5aN0ZVajVKcFdU?=
 =?utf-8?B?YW9Ga2dVRVBTeFFhWGxKYWNiRHVIMTdYMEV0akNzK0RyVU1XK01SYlprMUFH?=
 =?utf-8?B?bDJMQTNzZE12TFJBQkttTXIvQW41dGZUZmV1QmkzUk40OW5vWi9qc0pZOHFF?=
 =?utf-8?Q?Q3RPwkUyOtHZXZxsOUdvPaq9sE6Bl2qQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2RKOThyc1lVMzg1a1dwTWU1TmkyakNpc3lmU1RUcThsSjZsczR5R2lTa2lv?=
 =?utf-8?B?a2tGUXMycGc2NE8wblFka0Q4VmpiYkxvaHVyYkNKT3dac1pMZTJMRFVJU1VD?=
 =?utf-8?B?ZWwvdDBsZjFsb20zajRjMEhaTzRyS1dRNjkxdmtTN0U4bXcxMFpCcTZ3NmpG?=
 =?utf-8?B?VUQrNmdSSExtdm9MaS9sanc0RVJXRGlFOFJaZitxNTZFWldOU1UvWmhJb3VQ?=
 =?utf-8?B?QWNWUGVpcW9WQU1BL3pwNk8vU3pZb0JVbUF6YWtFRDg0NWdsUXJWVVBpQ3FD?=
 =?utf-8?B?aFJoU3F2MVk3OFBxb3ZPck94UWlFNlRTUWpva3FjWmg5NzJBTm8zcU4rdFVE?=
 =?utf-8?B?ZXVoNDJheG9mdGwxQm9QeW9QU0J0ZUVhQzdrWS9nUi8rMjllZjcxeEVBY0xU?=
 =?utf-8?B?dEd4WWZOQTlOYzg4U3MvYmdQa25OQVRrbmhDQTgxUFZJckkrZUVSSFlmL3pu?=
 =?utf-8?B?SURrMzM5by95N25xWUdOTjZjMmVFU01Ub2VxYjVmNWdpcmNUejFlNFlBbzRs?=
 =?utf-8?B?NlowUE1nV0tOc0s0aDEwbC92NHQyakJ5ZHRJM1FpOFJoaWNrVXBRb3VaYWd1?=
 =?utf-8?B?TEU3ZDFmMTNkNWxZYVdzcXdBTnVQWDV0Z1FpNDI5MUlURm9OZkJkOGlMWWxr?=
 =?utf-8?B?U0d4TXdqVjFpU2U2cnlET21rZjE3ZjFyVDBNT1hnS0ZDRGZCQ1lkcEtLbVJt?=
 =?utf-8?B?NFBKOHFNQUxabHVGaGdBMGZYellrMCtZOUxmejB1NzNGbzRhaHkyNWxyU09D?=
 =?utf-8?B?WkpUWkpmWkRqVXVvWmdxdUVYMEN2TWE5YVNtdENmS2dCeERwZGQ2VkpoYnVx?=
 =?utf-8?B?TnNicHl0eGNqRFBhN1VyNlo3ak01dEUvVGplSlAxZmgwR0RYOUFxTCtUMlJj?=
 =?utf-8?B?SHJVcnJOUUYydDZDaHBHVVRpRTZYQ01QeGdtcW93dGFudTVOWitYbWtqeEpQ?=
 =?utf-8?B?bUFBTi9EU3ZWazExYWpYdjk0aXhoRVdoSU9vS0FyMmhhTHBxV2hiV1ltUk11?=
 =?utf-8?B?Ti9IemxxSU16VHlJeEJjNlk2S3RuZzljMFRYSGhtZWc0Mm91T2ZKQk53bWVB?=
 =?utf-8?B?NU5GOWtsRnB1emhDbEd1UWFHNXJlc3dLRkJyaVdCMy85cVU2YVl6cjNacDBJ?=
 =?utf-8?B?WjlpdDZVNCtjQjhyaktYOU43K1diQzAzV2ZFTjdsS0sxNUJ6bi95SHpRK05s?=
 =?utf-8?B?RVE0aGRhNjM2Nm1yMzJoRWJRalc1RU5aV3pDSHNVdTZzL1ZFTDZ4QVVSbm8r?=
 =?utf-8?B?NVROMmtZRk96Zmx0blRxT3ZQMkxNdHlPMGNadStCWWlWTWx5cXFySE0zaE1v?=
 =?utf-8?B?b2lUOFJ4Z0IrVko3ZWtQd1ZzbHJrYlZPZGZwWXVtRVZ2S3N0QmpIZW8wUDFQ?=
 =?utf-8?B?OTQ0Wk84bEZXbWRGY01OUFJVbExGcS9aUWZhNGJtZ0oycHlvTXJNL0dTSTU4?=
 =?utf-8?B?Uk5BMGpKUS9nK1hjWXBad2UzVEE1c01JOUJRVjZKaG5uWTNzdEdMK3g4Vkw0?=
 =?utf-8?B?SU9BdnYrWStSaU42UkdoQnBUYmVXZWRTaHZiSzdtRFkyQXdqcHF2endmYitS?=
 =?utf-8?B?eXNwNTRLamJsYVhzU1pKbVlmVUtuNHdYd1JXSExmY2VhN0srYitWZTRUL0Nr?=
 =?utf-8?B?MklkL2s3emlFb1NYaEJLVnZJV3lvRzhxcDR0a0Jka3FLcHVYb0ZXdlg4b3Rx?=
 =?utf-8?B?K0R6L3NoUTZGWnhMZVpWYUpKek03N3JVVTNyME9teGdWaVJaVWFzQ2NMT2xC?=
 =?utf-8?B?c09sTWVueWQwZG8vNm5SV1VOLzdldlJpUURkOVFYcHVkRHVPMVpXa1JPV2lu?=
 =?utf-8?B?dEpNcER4YmVmNGNhc05zdE1UQnJ5WVpsTncvakFOZk1teGZOZTJEUktvUDRH?=
 =?utf-8?B?Q0xubzR5cGxRWTI3Ri9VSzJ3K3hxZDFKamt1UmFyUnU4aGJGSTN6UU5wTjVq?=
 =?utf-8?B?VUdVMmtiRXJ2VVI2UHRxbjRKSi9zei9XbXdDNUVaNjRxWE9zdll2S212ZmxO?=
 =?utf-8?B?dE12VFZ6OUdxTnV6SXNhS0hqU1A1Yis4TDc5UEFWSkVOZ1BhendRRmxrRWpK?=
 =?utf-8?B?QjJyY1FXVXRSNE5vQUN2VHBoWG42ZDB2aStSbjZoU3hEL3BPaWJGcUJWRS9L?=
 =?utf-8?B?ODBoRVJFMmRJb0JhWGc4QXl0dXhuTGozUlgyWUxkZll0SmZIa2FFMS93eE9k?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8AC3F6529694845B21899A8873B7BED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb23ef86-933c-48be-e72f-08dd606175a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 05:56:25.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTISIw15QtkLHeypO2j04cL+emCFGbtSHVCGnTu8s/krmYSogzCci1mJZ2YZDWeIvgApkXG9HX7GdQ1xzOz0XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5896
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI1LTAzLTA4IGF0IDEwOjM4IC0wODAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBQbGF0Zm9ybSBUZW1wZXJhdHVyZSBDb250cm9sIGlzIGEgZHluYW1pYyBjb250cm9s
IGxvb3AgaW1wbGVtZW50ZWQgaW4NCj4gaGFyZHdhcmUgdG8gbWFuYWdlIHRoZSBza2luIG9yIGFu
eSBib2FyZCB0ZW1wZXJhdHVyZSBvZiBhIGRldmljZS4gVGhlDQo+IHJlcG9ydGVkIHNraW4gb3Ig
Ym9hcmQgdGVtcGVyYXR1cmUgaXMgY29udHJvbGxlZCBieSBjb21wYXJpbmcgdG8gYQ0KPiBjb25m
aWd1cmVkIHRhcmdldCB0ZW1wZXJhdHVyZSBhbmQgYWRqdXN0aW5nIHRoZSBTb0MgKFN5c3RlbSBv
biBDaGlwKQ0KPiBwZXJmb3JtYW5jZSBhY2NvcmRpbmdseS4gVGhlIGZlYXR1cmUgc3VwcG9ydHMg
dXAgdG8gdGhyZWUgcGxhdGZvcm0NCj4gc2Vuc29ycy4NCj4gDQo+IE9FTXMgKE9yaWdpbmFsIEVx
dWlwbWVudCBNYW51ZmFjdHVyZXJzKSBjYW4gY29uZmlndXJlIHRoaXMgZmVhdHVyZQ0KPiB0aHJv
dWdoIHRoZSBCSU9TIGFuZCBwcm92aWRlIHRlbXBlcmF0dXJlIGlucHV0IGRpcmVjdGx5IHRvIHRo
ZQ0KPiBoYXJkd2FyZQ0KPiB2aWEgdGhlIFBsYXRmb3JtIEVudmlyb25tZW50IENvbnRyb2wgSW50
ZXJmYWNlIChQRUNJKS4NCg0KRG9lcyB0aGlzIG1lYW4gZWFjaCBQVEMgaW5zdGFuY2UgaXMgYm91
bmQgdG8gYSBjZXJ0YWluIHNraW4vYm9hcmQNCnNlbnNvcj8gQW5kIHdyaXRpbmcgdGhlICJ0ZW1w
ZXJhdHVyZV90YXJnZXQiIHN5c2ZzIHRlbGxzIGZpcm13YXJlIHRoZQ0KdGFyZ2V0IHRlbXBlcmF0
dXJlLCBhcyB3ZWxsIGFzIHRoZSB0YXJnZXQgc2Vuc29yIHRoYXQgdGhlIHRlbXBlcmF0dXJlDQph
cHBsaWVzIHRvPyBpZiB5ZXMsIGlzIHRoZXJlIGEgd2F5IGZvciB1c2Vyc3BhY2UgdG8ga25vdyB3
aGljaCBzZW5zb3INCmVhY2ggUFRDIGluc3RhbmNlIGFwcGxpZXMgdG8/DQoNCj4gIEFzIGEgcmVz
dWx0LA0KPiB0aGlzIGZlYXR1cmUgY2FuIG9wZXJhdGUgaW5kZXBlbmRlbnRseSBvZiBhbnkgT1Mt
bGV2ZWwgY29udHJvbC4NCj4gDQo+IFRoZSBPUyBpbnRlcmZhY2UgY2FuIGJlIHVzZWQgdG8gZnVy
dGhlciBmaW5lLXR1bmUgdGhlIGRlZmF1bHQgT0VNDQo+IGNvbmZpZ3VyYXRpb24uIEhlcmUgYXJl
IHNvbWUgc2NlbmFyaW9zIHdoZXJlIHRoZSBPUyBpbnRlcmZhY2UgaXMNCj4gYmVuZWZpY2lhbDoN
Cj4gVmVyaWZpY2F0aW9uIG9mIEZpcm13YXJlIENvbnRyb2w6IENoZWNrIGlmIGZpcm13YXJlLWJh
c2VkIGNvbnRyb2wgaXMNCj4gZW5hYmxlZC4gSWYgaXQgaXMsIHRoZXJtYWwgY29udHJvbHMgZnJv
bSB0aGUgT1MvdXNlciBzcGFjZSBjYW4gYmUNCj4gYmFja2VkIG91dC4NCj4gQWRqdXN0aW5nIFRh
cmdldCBMaW1pdHM6IFdoaWxlIE9FTXMgY2FuIHNldCBhbiBhZ2dyZXNzaXZlIHRhcmdldA0KPiBs
aW1pdCwNCj4gdGhlIE9TIGNhbiBhZGp1c3QgdGhpcyB0byBhIGxlc3MgYWdncmVzc2l2ZSBsaW1p
dCBiYXNlZCBvbiBvcGVyYXRpbmcNCj4gbW9kZXMgb3IgY29uZGl0aW9ucy4NCj4gDQo+IFRoZSBo
YXJkd2FyZSBjb250cm9sIGludGVyZmFjZSBpcyB2aWEgYSBNTUlPIG9mZnNldHMgdmlhIHByb2Nl
c3Nvcg0KPiB0aGVybWFsIGRldmljZS4gVGhlcmUgYXJlIHRocmVlIGluc3RhbmNlcyBvZiBNTUlP
IHJlZ2lzdGVycy4gQWxsDQo+IGFyZSA2NCBiaXQgcmVnaXN0ZXJzDQo+IA0KPiBOYW1lOiBQTEFU
Rk9STV9URU1QRVJBVFVSRV9DT05UUk9MDQo+IE9mZnNldHM6IDB4NUIyMCwgMHg1QjI4LCAweDVC
MzANCj4gDQo+IEFsbCB2YWx1ZXMgaGF2ZSBSVyBhY2Nlc3MNCj4gDQo+IEJpdHPCoMKgwqAgRGVz
Y3JpcHRpb24NCj4gNzowwqDCoMKgwqAgVEFSR0VUX1RFTVAgOiBUYXJnZXQgdGVtcGVyYXR1cmUg
bGltaXQgdG8gd2hpY2ggdGhlIGNvbnRyb2wNCj4gwqDCoMKgwqDCoMKgwqAgbWVjaGFuaXNtIGlz
IHJlZ3VsYXRpbmcuIFVuaXRzOiAwLjVDLg0KPiA4OjjCoMKgwqDCoCBFTkFCTEU6IFJlYWQgY3Vy
cmVudCBlbmFibGUgc3RhdHVzIG9mIHRoZSBmZWF0dXJlIG9yIGVuYWJsZQ0KPiAJZmVhdHVyZS4N
Cj4gMTE6OQlHQUlOOiBTZXRzIHRoZSBhZ2dyZXNzaXZlbmVzcyBvZiBjb250cm9sIGxvb3AgZnJv
bSAwIHRvIDcNCj4gCTcgZ3JhY2VmdWwsIGZhdm9ycyBwZXJmb3JtYW5jZSBhdCB0aGUgZXhwZW5z
ZSBvZiB0ZW1wZXJhdHVyZQ0KPiAJb3ZlcnNob290cw0KPiAJMCBhZ2dyZXNzaXZlLCBmYXZvcnMg
dGlnaHQgcmVndWxhdGlvbiBvdmVyIHBlcmZvcm1hbmNlDQo+IDEyOjEyCVRFTVBFUkFUVVJFX09W
RVJSSURFX0VODQo+IAlXaGVuIHNldCwgaGFyZHdhcmUgd2lsbCB1c2UgVEVNUEVSQVRVUkVfT1ZF
UlJJREUgdmFsdWVzDQo+IGluc3RlYWQNCj4gCW9mIHJlYWRpbmcgZnJvbSBjb3JyZXNwb25kaW5n
IHNlbnNvci4NCj4gMTU6MTMJUkVTRVJWRUQNCj4gMjM6MTYJTUlOX1BFUkZPUk1BTkNFX0xFVkVM
OiBNaW5pbXVtIFBlcmZvcm1hbmNlIGxldmVsIGJlbG93IHdoaWNoDQo+IHRoZQ0KPiAJdGhlcmUg
d2lsbCBiZSBubyB0aHJvdHRsaW5nLiAwIC0gYWxsIGxldmVscyBvZiB0aHJvdHRsaW5nDQo+IGFs
bG93ZWQNCj4gCWluY2x1ZGluZyBzdXJ2aXZhYmlsaXR5IGFjdGlvbnMuIDI1NSAtIG5vIHRocm90
dGxpbmcNCj4gYWxsb3dlZC4NCj4gMzE6MjQJVEVNUEVSQVRVUkVfT1ZFUlJJREU6IEFsbG93cyBT
VyB0byBvdmVycmlkZSB0aGUgaW5wdXQNCj4gdGVtcGVyYXR1cmUuDQo+IAloYXJkd2FyZSB3aWxs
IHVzZSB0aGlzIHZhbHVlIGluc3RlYWQgb2YgdGhlIHNlbnNvcg0KPiB0ZW1wZXJhdHVyZS4NCj4g
CVVuaXRzOiAwLjVDLg0KPiA2MzozMglSRVNFUlZFRA0KPiANCj4gT3V0IG9mIHRoZSBhYm92ZSBj
b250cm9scywgb25seSAiZW5hYmxlIiBhbmQgInRlbXBlcmF0dXJlX3RhcmdldCIgaXMNCj4gZXhw
b3NlZCB2aWEgc3lzZnMuDQo+IFRoZXJlIGFyZSB0aHJlZSBpbnN0YW5jZXMgb2YgdGhpcyBjb250
cm9scy4gU28gdXAgdG8gdGhyZWUgZGlmZmVyZW50DQo+IHNlbnNvcnMgY2FuIGJlIGNvbnRyb2xs
ZWQgaW5kZXBlbmRlbnRseS4NCj4gDQo+IFN5c2ZzIGludGVyZmFjZToNCj4gdHJlZQ0KPiAvc3lz
L2J1cy9wY2kvZGV2aWNlcy8wMDAwXDowMFw6MDQuMC9wbGF0Zm9ybV90ZW1wZXJhdHVyZV8/X2Nv
bnRyb2wvDQo+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDA6MDQuMC9wbGF0Zm9ybV90ZW1w
ZXJhdHVyZV8wX2NvbnRyb2wvDQo+IOKUnOKUgOKUgCBlbmFibGUNCj4g4pSc4pSA4pSAIHRlbXBl
cmF0dXJlX3RhcmdldA0KPiAvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwOjAwOjA0LjAvcGxhdGZv
cm1fdGVtcGVyYXR1cmVfMV9jb250cm9sLw0KPiDilJzilIDilIAgZW5hYmxlDQo+IOKUnOKUgOKU
gCB0ZW1wZXJhdHVyZV90YXJnZXQNCj4gL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMDowMDowNC4w
L3BsYXRmb3JtX3RlbXBlcmF0dXJlXzJfY29udHJvbC8NCj4g4pSc4pSA4pSAIGVuYWJsZQ0KPiDi
lJzilIDilIAgdGVtcGVyYXR1cmVfdGFyZ2V0DQo+IA0KPiBEZXNjcmlwdGlvbiBvZiBhdHRyaWJ1
dGVzOg0KPiANCj4gRW5hYmxlOiAxIGZvciBlbmFibGUsIDAgZm9yIGRpc2FibGUuIFRoaXMgYXR0
cmlidXRlIGNhbiBiZSB1c2VkIHRvDQo+IHJlYWQgdGhlIGN1cnJlbnQgc3RhdHVzLiBVc2VyIHNw
YWNlIGNhbiB3cml0ZSAwIG9yIDEgdG8gZGlzYWJsZSBvcg0KPiBlbmFibGUgdGhpcyBmZWF0dXJl
IHJlc3BlY3RpdmVseS4NCj4gdGVtcGVyYXR1cmVfdGFyZ2V0OiBUYXJnZXQgdGVtcGVyYXR1cmUg
bGltaXQgdG8gd2hpY2ggaGFyZHdhcmUNCj4gd2lsbCB0cnkgdG8gbGltaXQgaW4gbWlsbGkgZGVn
cmVlIEMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhDQo+IDxzcmlu
aXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+IMKgLi4uL3RoZXJtYWwv
aW50ZWwvaW50MzQweF90aGVybWFsL01ha2VmaWxlwqDCoMKgIHzCoMKgIDEgKw0KPiDCoC4uLi9w
bGF0Zm9ybV90ZW1wZXJhdHVyZV9jb250cm9sLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTgx
DQo+ICsrKysrKysrKysrKysrKysrKw0KPiDCoC4uLi9wcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2Uu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTUgKy0NCj4gwqAuLi4vcHJvY2Vz
c29yX3RoZXJtYWxfZGV2aWNlLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MyArDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxOTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQw
eF90aGVybWFsL3BsYXRmb3JtX3RlbXBlcmF0dXJlX2NvbnRyb2wuYw0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvTWFrZWZpbGUNCj4gYi9k
cml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL01ha2VmaWxlDQo+IGluZGV4IGZl
M2Y0MzkyNDUyNS4uMTg0MzE4ZDE3OTJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwv
aW50ZWwvaW50MzQweF90aGVybWFsL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9p
bnRlbC9pbnQzNDB4X3RoZXJtYWwvTWFrZWZpbGUNCj4gQEAgLTksNiArOSw3IEBAIG9iai0kKENP
TkZJR19JTlQzNDBYX1RIRVJNQUwpCSs9DQo+IHByb2Nlc3Nvcl90aGVybWFsX2RldmljZV9wY2lf
bGVnYWN5Lm8NCj4gwqBvYmotJChDT05GSUdfSU5UMzQwWF9USEVSTUFMKQkrPSBwcm9jZXNzb3Jf
dGhlcm1hbF9kZXZpY2VfcGNpLm8NCj4gwqBvYmotJChDT05GSUdfUFJPQ19USEVSTUFMX01NSU9f
UkFQTCkgKz0gcHJvY2Vzc29yX3RoZXJtYWxfcmFwbC5vDQo+IMKgb2JqLSQoQ09ORklHX0lOVDM0
MFhfVEhFUk1BTCkJKz0gcHJvY2Vzc29yX3RoZXJtYWxfcmZpbS5vDQo+ICtvYmotJChDT05GSUdf
SU5UMzQwWF9USEVSTUFMKQkrPSBwbGF0Zm9ybV90ZW1wZXJhdHVyZV9jb250cm9sLm8NCj4gwqBv
YmotJChDT05GSUdfSU5UMzQwWF9USEVSTUFMKQkrPSBwcm9jZXNzb3JfdGhlcm1hbF9tYm94Lm8N
Cj4gwqBvYmotJChDT05GSUdfSU5UMzQwWF9USEVSTUFMKQkrPSBwcm9jZXNzb3JfdGhlcm1hbF93
dF9yZXEubw0KPiDCoG9iai0kKENPTkZJR19JTlQzNDBYX1RIRVJNQUwpCSs9IHByb2Nlc3Nvcl90
aGVybWFsX3d0X2hpbnQubw0KPiBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy90aGVybWFsL2ludGVs
L2ludDM0MHhfdGhlcm1hbC9wbGF0Zm9ybV90ZW1wZXJhdHVyZV9jb250cm9sLg0KPiBjDQo+IGIv
ZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wbGF0Zm9ybV90ZW1wZXJhdHVy
ZV9jb250cm9sLg0KPiBjDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uZGQzZWE3MTY1ODAwDQo+IC0tLSAvZGV2L251bGwNCj4gKysrDQo+IGIvZHJpdmVycy90
aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wbGF0Zm9ybV90ZW1wZXJhdHVyZV9jb250cm9s
Lg0KPiBjDQo+IEBAIC0wLDAgKzEsMTgxIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vbmx5DQo+ICsvKg0KPiArICogcHJvY2Vzc29yIHRoZXJtYWwgZGV2aWNlIHBs
YXRmb3JtIHRlbXBlcmF0dXJlIGNvbnRyb2xzDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUsIElu
dGVsIENvcnBvcmF0aW9uLg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wY2ku
aD4NCj4gKyNpbmNsdWRlICJwcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2UuaCINCj4gKw0KPiArc3Ry
dWN0IG1taW9fcmVnIHsNCj4gKwlpbnQgYml0czsNCj4gKwl1MTYgbWFzazsNCj4gKwl1MTYgc2hp
ZnQ7DQo+ICsJdTE2IHVuaXRzOw0KPiArfTsNCj4gKw0KPiArI2RlZmluZSBNQVhfQVRUUl9HUk9V
UF9OQU1FX0xFTiAzMg0KPiArDQo+ICtzdHJ1Y3QgcHRjX2RhdGEgew0KPiArCXUzMiBvZmZzZXQ7
DQo+ICsJc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBwdGNfYXR0cl9ncm91cDsNCj4gKwlzdHJ1Y3Qg
YXR0cmlidXRlICpwdGNfYXR0cnNbM107DQo+ICsJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgdGVt
cGVyYXR1cmVfdGFyZ2V0X2F0dHI7DQo+ICsJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgZW5hYmxl
X2F0dHI7DQo+ICsJY2hhciBncm91cF9uYW1lW01BWF9BVFRSX0dST1VQX05BTUVfTEVOXTsNCj4g
K307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbW1pb19yZWcgcHRjX21taW9fcmVnc1td
ID0gew0KPiArCXsgOCwgMHhGRiwgMCwgNTAwfSwgLyogdGVtcGVyYXR1cmVfdGFyZ2V0LCB1bml0
cyAwLjVDKi8NCj4gKwl7IDEsIDB4MDEsIDgsIDB9LCAvKiBlbmFibGUgKi8NCj4gKwl7IDMsIDB4
NywgOSwgMH0sIC8qIGdhaW4gKi8NCj4gKwl7IDgsIDB4RkYsIDE2LCAwfSwgLyogbWluX3BlcmZv
cm1hbmNlX2xldmVsICovDQo+ICsJeyAxLCAweDEsIDEyLCAwfSwgLyogdGVtcGVyYXR1cmVfb3Zl
cnJpZGVfZW5hYmxlICovDQo+ICsJeyA4LCAweEZGLCAyNCwgNTAwfSwgLyogdGVtcGVyYXR1cmVf
b3ZlcnJpZGUsIHVuaXRzIDAuNUMgKi8NCj4gK307DQo+ICsNCj4gKy8qIFVuaXF1ZSBvZmZzZXQg
Zm9yIGVhY2ggUFRDIGluc3RhbmNlICovDQo+ICtzdGF0aWMgdTMyIHB0Y19vZmZzZXRzW10gPSB7
MHg1QjIwLCAweDVCMjgsIDB4NUIzMH07DQoNCkknZCBwcmVmZXIgdG8gZGVmaW5lIFBUQ19NQVhf
SU5TVEFOQ0VTIGVhcmxpZXIgYW5kIHVzZQ0KICBzdGF0aWMgdTMyIHB0Y19vZmZzZXRzW1BUQ19N
QVhfSU5TVEFOQ0VTXSA9IHsweDVCMjAsIDB4NUIyOCwgMHg1QjMwfTsNCmluc3RlYWQuDQoNCnRo
YW5rcywNCnJ1aQ0K

