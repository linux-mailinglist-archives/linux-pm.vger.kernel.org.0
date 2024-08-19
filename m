Return-Path: <linux-pm+bounces-12406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB9956518
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 09:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDEE282258
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA615AADE;
	Mon, 19 Aug 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esJgRQj/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA9156CF;
	Mon, 19 Aug 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054290; cv=fail; b=WllCocXEnA0daAjXA+WppYp8BbNk242cjC4FD+Zoe87FSKXK201vtwtsgVbUNwm4f9WAoHDoshHxSLHPpy/jdB1H4e13ZddvtZOF59eUfaAPhMlE3YjMZJ8IGuMEhpUz38+J10dxFqoUctT/FX6K+EpF+Fh06ktTsnWBzQ19nY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054290; c=relaxed/simple;
	bh=DjeSXzPli/7kwiRy+R89wKMKmBgvDuMAc6YlzCIU2vU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BN2lQB3EPqw8Xaebi9AJ6BPMwo0y7RzCcSp6jt1UZt2Kn+XBYsLUWO7hlmqAhSWpBouA85WOJewitRVi78M7DperDf1APh+CuDUYfxi6m/N+PGHEoWbNxNMvJU+Ge61DDDl0lORavdalsHG6HSljDZ8UEydJbzLXSOk9B4aSlcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esJgRQj/; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724054289; x=1755590289;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=DjeSXzPli/7kwiRy+R89wKMKmBgvDuMAc6YlzCIU2vU=;
  b=esJgRQj/ypK6/Ew2PExV17gCbaP0emTms65e1bcwplmp8QAMJbIxwREJ
   1M8Yaw3DDyz3tmlgDgDrCwCB54nLgGV0l486Ew+e0SrEYwwmVetVnlUQ2
   HVLs8flLI/q3MfUM1dJsD+eoC98M4LicRl69r82RaNIQEZWL1cAgHS03Z
   v5s1rH0sxMHArobujFXzv+46AVz6Yzu6xdPLLbcYqXU6nne4gDGHahcJB
   XZu3d72mUyLl2j20Vhtkb4pn2Lc2GvxyUJIoFRBSJU8oucelNtNsuclwq
   uH0JNeE4SOg1FQ+citpHG2o7VTvPBxbD3DFSPbF5G4HyscdzIupGrp+eg
   Q==;
X-CSE-ConnectionGUID: Yd3j8Xt8TG+0rR9S7877zA==
X-CSE-MsgGUID: 1nDsyLpoSY6CSDDDBNF+JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33437271"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33437271"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:58:09 -0700
X-CSE-ConnectionGUID: M7xAWapxTS6mxHOZGVRUAA==
X-CSE-MsgGUID: AvMABSZ8RZeJO0mnlWxdxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91035818"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 00:58:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 00:58:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 00:58:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 00:58:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 00:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGeA9v8SkJ7rRy0f7/vuN8QbACVWNVvGAXeRhgCa1OjKZiYGbRzJOyOV81aDUsTNaIe7p5fslyCvjFYk+1EbOGZZtjjfrClG9NjOj9S55K8QDXofz8jkWh5aZY7Lw+mUs6qNFn8c86G3TjU+wP5Rt/6Dh4WLV037eMKVmlQXVa4kDzjA/ata2KtAPaSk1zUg345bGHs3/moMqvE9z+acLT4k5R7BuBjf+PJqWd7+1wn3C8zCfePGAeVF4hkkDW6J7tocoonLZwewaQbPwVYCmh4ZhbZyE+OWkwWqQojJaT//faoHlIgxyRFk/EMxxdVaKI0r2RqiglcjqKe8ap9GWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjeSXzPli/7kwiRy+R89wKMKmBgvDuMAc6YlzCIU2vU=;
 b=b94nC1kw36joV+5ZWwp2gcA9y6F75etNe3iJaDUXim8WtH9po/PGlOWsAr6eyPMd+WikJwjPqESpPvadAuqr4pZ+EVOqqSxzSxCk+jMkKSyTM3KT+4ldcf36urpJSXbl6n6UkDrhkislpgBQnPBtZeySwiaozM7mMy0MvdJVZDlXMSohApKg6sMbZPZv4KUCzIqTiUB6d2aSekH1VxhVDJhi5mQeCVKLUjHdUj3mzEgETOeHvC9DnO3Ae1vguYFV3Fa/2oOVOJ0arBdCJRWKVRoM6Ih3U9l21nUApGRIM+OCYdfgd8JmA2Qdxc9KXztDLc3KR36yfMIogthjPM9y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 07:58:04 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 07:58:04 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Pawnikar, Sumeet R"
	<sumeet.r.pawnikar@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for ArrowLake-U
 platform
Thread-Topic: [PATCH] powercap: intel_rapl: Add support for ArrowLake-U
 platform
Thread-Index: AQHa79KdkC7T90ge2060y5CFtqL+RbIuO2OA
Date: Mon, 19 Aug 2024 07:58:04 +0000
Message-ID: <1b28d2bd9cecb2151bcbc9e4d8f81f79d4ca9f92.camel@intel.com>
References: <20240816113332.7408-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20240816113332.7408-1-sumeet.r.pawnikar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA0PR11MB7693:EE_
x-ms-office365-filtering-correlation-id: a64dcadd-a5e6-4f0c-9f59-08dcc024a7c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UEtuK0dYTDgxL2hoeW5OU21jMVlyUWNTR2ExQTJsbTBCUjdnMS9HY1k4SDRM?=
 =?utf-8?B?Wk5ETUZFb1RDY2hVT25BQ25OM0tGSThEMjFVVkVGN285Y3lZL2Nob0VEL2l0?=
 =?utf-8?B?NlZ5cU0zTHJwNVlPblhDZ0RhU2pXcnJGN3FVRDI3RmluaHNqYzYwZlpNenBN?=
 =?utf-8?B?bm1BN3cxTWZoSnZaemlsYkNkVUpmcE1IM3N3TTNuaGJSMm1MNitYZTA5cUNE?=
 =?utf-8?B?YkR2cm9kaGREcnY0T2txYzQ1NU1EOFJZOGNDRzVsS0J3Q3hFeXNic1Bzc3A2?=
 =?utf-8?B?dGhVMm43QkIwS1dGZmNoWlVKcWFEcG0wb1ZMbEdLWGpka0hJSE9IQW4yV1By?=
 =?utf-8?B?MXJuMGx1cURUYW1FN1JJQVV4SGYvRERHTGlXMjdJL0FDbnh0VFV0MTJVd3hE?=
 =?utf-8?B?MXlFdFpvQ2hsOUNSbUttQTIrSzNnOXM4dUg4T0JWRUxqMGJWR2hNQlBBNXBz?=
 =?utf-8?B?QU1XQk1LbnU3VDlTWnRwQjh0MFhMUU50K2RhTVpiNmE4dXk5d1Z4cC8xa3Ni?=
 =?utf-8?B?dVBzSzE5QnZTUWthWWJFczVldlN5VmtQOHoyMGFlVFhnQ2pLZDIxNUlhUTVR?=
 =?utf-8?B?cnUvR3ozQzcycjIzcUVxNXJjZkllZHJqWFl2YmY3Zk01LzFRejBsQkVPNHp1?=
 =?utf-8?B?S1BHb0lVN21Hb094dEczTHhuUjVJU0I2NUQxRTZDR1BlNTJVRWl3b1pjMjZJ?=
 =?utf-8?B?eVNoTWNxNTJnMkM4Zy9vZU1YbS9VMTFXNVV5UGtpVmVvTmcrWUZtZEtwS0lr?=
 =?utf-8?B?alQvQ1JRamljRVZ1ZkVHaEc5bCt3YkJ4anRMcXdLeHMyTWZTb3RlVE9zbGFa?=
 =?utf-8?B?UWl6SE9taXZncWg2N3VHMmdreXgwN1kvQkM1QlRNMjNxb2pjNWJOZFpVR3Ex?=
 =?utf-8?B?c1lCV3F0UHd2U29PYWNUWW1WelNMM1F4bDhObllJbWRrQ0FPNUtUMG5KZ3dF?=
 =?utf-8?B?NkNuNDV2V1ZrN1Z1amUwUW1KVzFtdThmck1lWVlUWXJleVpGcGJWY0pROEZh?=
 =?utf-8?B?N2hyR09Ra1orTmQ2d1BQSXhmOXBDYVl2MUdkdEw2bTl5dTd4ZVJWdm50Yzdn?=
 =?utf-8?B?c09KUlRLdlpMSndId2dzVlB6UkJoUnRmK1lSMG5GM2I2U2xSdmpmOEVkdGxM?=
 =?utf-8?B?YVZXZlgrd3owU05FdkxUWHZzTDlOL1NJalpMVVFBUkJRbWlOVzhTaVM0QVll?=
 =?utf-8?B?U0I4aG1LTnFoaHoxUzhNVjRZUHVhc2VwUzcrVVR3d3NOU05JbzRMeGJCZTkz?=
 =?utf-8?B?dVhxakFPS1Q2RldTZVg3K2Qvd0lESXdPcW53alI1ckVsQ2VRNWVuMGpqN3g3?=
 =?utf-8?B?TXp3RWxpZFExTnBHcmpXbERrQkhZdzAzdGNaaS9USUJRRFdlem5Kd1krRHRC?=
 =?utf-8?B?c3FIVzRmQzh2Y2U0K05jaDRYcFIrSjZReFhraWlObURzcUdMVTRVbUFKcUFx?=
 =?utf-8?B?YzV1RmhsNWxGWGxJdm80dWIyUGFpRFBxdEtvdmJUQmdNY3ExVXJsUTg1UmlI?=
 =?utf-8?B?azF5QS92QzltNlNubmY5UERmZnVUK2tKVXVmVFJ0em5hMDVra0wyaTFScEh0?=
 =?utf-8?B?dkdPS1VicHkwUGpEaW5sb0dHc3M1RFptZkY3YkxkY3BmOVl3aXQyUlM5Z2xC?=
 =?utf-8?B?ZkQrSlhReUlsZS9kcE0zT0wxSjZwOXdsU2huVlVQQ0RuYlRRQUZLYVdsamE4?=
 =?utf-8?B?dXJzREU2cHd1L2NHK2poM3Q5RGxlVVlXWmJINmxSUURvcyt2azIyRklIelc0?=
 =?utf-8?B?VkxqMWozVUljekc1RHNEMWU3cnh3bk4xcEZNTlVhRmZiR053SGltR2ovclhU?=
 =?utf-8?B?cDcyaHpzaTk1VlJDajNDek13WUcrbG5ydmJxK2RpeVI4TWswTzd6LzVkN0NH?=
 =?utf-8?B?WUpDdnRmb0dsOElMdEtaNVJEK1YwVVluU1kzdlFoV2ltZXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2k5b1ljV242TS80Njg2R3piRm9ZU2RvV3FZRlZFajk4QjBESU9NdGNWTXVi?=
 =?utf-8?B?cGhFa1EwbFZ2U0hxbzFpaEtCWHBRMFQ3bk5zK0M1VlJrRjNYZE44R09JZzZL?=
 =?utf-8?B?ekc2Y3pOYnkzbzZBOTBhbUZnZ1FaN1dtZHJiejN6Y3M2YlZrU0Jsbkk5SUpQ?=
 =?utf-8?B?d1NRb083TmRpdUs5SlQydW96YkQ4NWhKSTFlWmZRNlNFR0Z1eFNCNzRBZHpq?=
 =?utf-8?B?dm40ZkNsR2kzZVJuaW1wY0FHWThUVHVpVUJUbVFoQmpwSk1VWnc4TDgzVU1h?=
 =?utf-8?B?WElqajZ5NFEvb1V4RGpwQ2wrTnFzQmJrTlF5Z1dWeEgwMm03a3A0UmJ2bmd4?=
 =?utf-8?B?OEd0ZGNGUmVNK1JOQTFwK2gzTXdpYldiYWRaUzlIL05hVVZvVVNWNzM1QUlL?=
 =?utf-8?B?Y05mZHpvUUtQVE0xSDVueFBOWDNhVW5lcWRxTDQwanFLY0dTVmpxcnNrZUQ5?=
 =?utf-8?B?Z0VSTndNMWNSVXFERWtLbGg0MUN2TzhhMDIxT0VxcFl3TTlDN1FwMWtpem1B?=
 =?utf-8?B?Tkd5WnQ5bllEQ3M4SU0vSFpVNXBOUFYzaUNDZkFOOFd5cDh3RWxwQmdUWWI1?=
 =?utf-8?B?OEVxV05aYS81VzYvNHdDQThmZlFHTk9CRVppZFV3OHF2TDYvcnJuOVNYbFdl?=
 =?utf-8?B?UUlWZm5MdWgyekdWcGFUVWtPYmhWWGFwZFNxQXVMNVlHRjZMTXF0UFo4eW83?=
 =?utf-8?B?NWZOOVZaYXI5YVFrVmtYZWJMU3lCcTJ4V2EzUGZIRzYyR3hTM1FHZm1RSkVJ?=
 =?utf-8?B?cGFuc1U4ZkU0Vk8zVCt6VnQ1SHZtT2ZxZlc3UzRHN1E1RFdNRnVFYmI4cFdF?=
 =?utf-8?B?TDA5WXdlV2poeG4rWGhEczVsZElsb0ZEQ0VBcnJQaVJvL3FxcWJXYkg0aTBJ?=
 =?utf-8?B?VUtrcWJHenYzWVJRVHhiSXZpSWV4aVRjVFZ2cVkrZkRyMkVWN0xURFQwbDds?=
 =?utf-8?B?SjdRS0haMnJhY3F6ZDFQemhVZUUwb3lKNU1QM2dvb04yRTFiaG84OGcwRjVP?=
 =?utf-8?B?eGxUM2Q5TmV5cGhTZkg0eEVBTkZsZE9mdXlJTk5ndm0vc1JEc2NzeFQrKzY3?=
 =?utf-8?B?ZVFtdU5RRW45OVZpYm12UDVJNFNCNTJrUFhLdklaa1BVTkVNd0drdVd2VTF1?=
 =?utf-8?B?Qnc2R1BMMHgzSklLT2VsaUl4dklkTzhQQVVFK2JnYnUyOHFLTjBrdEJ6NW9j?=
 =?utf-8?B?YVRwK290VEVrSW1kU3dBVzVDWUdGU2x1cGVrR0drUW1mamdHYjA3OVE1ajl5?=
 =?utf-8?B?WUxreXdrYUVCLzV2WFRGLy8ybEluT1g4QnFlZSs1R3F5RGp3R0hSS2gvRWVt?=
 =?utf-8?B?VjEyb2FzYkVVSzc0WURhMDZxRWRDWnpGVVZ3SzV6bEpyVzY3eGM4dEdOUnA1?=
 =?utf-8?B?c21RY0syRlQ0K0VxYTdwWit4dENSVFhxWTJVVDZybThxRTN2cjliOVUvRW15?=
 =?utf-8?B?R1lMakdGSGtyeVc4RUlCWFRvQTZQVHlCaE9CSnpnV1FHbG1jdmRVZy83cHFm?=
 =?utf-8?B?Qi9iNGpMUDJmSitGUUhrdjREWUgwcm1QeWErallvVm5zS2dNNkxvdkdRRktn?=
 =?utf-8?B?QXlUNitReTBYVjFjaE92aUd3aGVsa3RLcXZ4RWhmcXlxdjR2M21BN0hwYVpB?=
 =?utf-8?B?WlJDL0ZBRFRmMngwSC8xRkNGRC9jcTB6V0RsZ1V3Qlp0QXRITFkzeVV3TFg4?=
 =?utf-8?B?NkRBS2Rta0gzOUlQYmhQOUxyZGQwRzEzd0RKQjBkam1QNSt0a1Z6TU8yNzdt?=
 =?utf-8?B?aTN1TE5INUZ5ZHNsc0NnQ3FPTzlTWTVhZ1o5YnF5YlBwUTBXN21Vb3lkckZm?=
 =?utf-8?B?RHpXZlByOWR5YXlTa25CZ2hhdVdLc3p6Mnh4b2djREpKaGNMb1dvNW9YVlNL?=
 =?utf-8?B?bTZYa1BSUHdZN2FWdHExeU9qU1dNd3pIbXk0OXhjSENxOVNjTkk4V1ZqRnhF?=
 =?utf-8?B?QjQ2ZCtvTzdzbDdqWk0xL1hRWXExeXVOdFhRTHNoTW5nSExqS1ovSjZ1akEz?=
 =?utf-8?B?VTJCSjZ2N1R5bE55c1QzQTlPU0NxTHpnM3djbldUYWpQRnlZQVh2YXlIV0Zq?=
 =?utf-8?B?K3ltTnpsTXNYR3gzY3lNbDhja3N6TzhQZENpdWtIbU1PUWVCeDhwbC8razha?=
 =?utf-8?B?VHVOS2xsMWovN1J6VEpUMDNWN1BxMldRWlVaSEZRMThnS1VUL0pCSmhDUTR6?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE1B6D6F266EE749A3A1FA4708D62B49@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64dcadd-a5e6-4f0c-9f59-08dcc024a7c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 07:58:04.5493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXbGUmXzfbCUrRyHA/LDHADjodO7yGxOffYfU6yt6BzptZK50jwu4aGyN3hbUcSgJ3/4VCv1iJZOiR7igRX++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA4LTE2IGF0IDE3OjAzICswNTMwLCBTdW1lZXQgUGF3bmlrYXIgd3JvdGU6
DQo+IEFkZCBzdXBwb3J0IGZvciBBcnJvd0xha2UtVSBwbGF0Zm9ybSB0byB0aGUgUkFQTCBjb21t
b24gZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3VtZWV0IFBhd25pa2FyIDxzdW1lZXQu
ci5wYXduaWthckBpbnRlbC5jb20+DQoNCkFja2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1v
bi5jIHwgMSArDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+IGIvZHJpdmVy
cy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+IGluZGV4IDNjZmZhNmM3OTUzOC4uM2Vk
ZjhkZWNiODExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29t
bW9uLmMNCj4gKysrIGIvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+IEBA
IC0xMjY3LDYgKzEyNjcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgcmFwbF9p
ZHNbXQ0KPiBfX2luaXRjb25zdCA9IHsNCj4gwqDCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0o
SU5URUxfTFVOQVJMQUtFX00swqDCoMKgwqDCoMKgwqDCoCZyYXBsX2RlZmF1bHRzX2NvcmUpLA0K
PiDCoMKgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9BUlJPV0xBS0VfSCzCoMKgwqDC
oMKgwqDCoMKgJnJhcGxfZGVmYXVsdHNfY29yZSksDQo+IMKgwqDCoMKgwqDCoMKgwqBYODZfTUFU
Q0hfVkZNKElOVEVMX0FSUk9XTEFLRSzCoMKgwqDCoMKgwqDCoMKgwqDCoCZyYXBsX2RlZmF1bHRz
X2NvcmUpLA0KPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0FSUk9XTEFLRV9V
LMKgwqDCoMKgwqDCoMKgwqAmcmFwbF9kZWZhdWx0c19jb3JlKSwNCj4gwqDCoMKgwqDCoMKgwqDC
oFg4Nl9NQVRDSF9WRk0oSU5URUxfTEFLRUZJRUxELMKgwqDCoMKgwqDCoMKgwqDCoMKgJnJhcGxf
ZGVmYXVsdHNfY29yZSksDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElO
VEVMX0FUT01fU0lMVkVSTU9OVCzCoMKgwqDCoCZyYXBsX2RlZmF1bHRzX2J5dCksDQoNCg==

