Return-Path: <linux-pm+bounces-12718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C751595B56F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 14:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B85280EEA
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 12:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E91C93D7;
	Thu, 22 Aug 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fh/p0KW7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997D61FF6
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331129; cv=fail; b=Oz3duyk8dgRmUZ1MUZF8vEVswuiFuAisfDzskBhcqlFrVdVjnpw/HhDYFUY2dGLwQVdhdTGSC5F3B/KwRPbJsjslZJFMM7WWYFgbBtyrDd+fwbfZDp7DvDWqpVTbyf7VBcyy1iUmUHamd7yjBraGVukVTk1XWnQidg41+QTZv94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331129; c=relaxed/simple;
	bh=rryYV2vUagpy1XqyuTDXrtsr8pLplDXAzrAdYNZiIAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kjk4q/dT6N8k0YWY0zadWL1l1kxUqaERRpj8fxw5fQIuvJUJR34q3bd6Jt6esR/HfOCNV8Ix5EvJW7iWhPn4lPwi9yp6OdcOKa6y2jkpZrA0aXklz1GpPBCrHslw6ys3VWNuOJmAwuKuYQmqPN3ey76d5W8JznBsK9Lk6asgoUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fh/p0KW7; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724331128; x=1755867128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rryYV2vUagpy1XqyuTDXrtsr8pLplDXAzrAdYNZiIAE=;
  b=Fh/p0KW7NzNuCPgphA0+Yu9kHcrEbxRhMba9hI0KTzyaOnscVSNusCic
   qewckcqVz4IwT2ZTYj+WVTWt0uK1c1U+hckmKrP815VaDZxLipU9ISZxt
   J1Rim0OE5toNlKbAeJswkQ2UMp2/qRCMX/RRvj0CmIDDhTpOGoyFodih5
   BH5Pl6GNk0ak0rpRg/Y8Uc5OLOrBLFNVuliieq/QL9NSKBxUXzu5m6ply
   M5dJmpFTOnGh+9KEKKd6linjzOOUb8S9M/PiWTPyKfD73HbRC8oT/JYCo
   5bdi19YyukkPQODg+rqQJSTirdQFcXWEEX9mE2JyD3ycr3EedEwriBejd
   w==;
X-CSE-ConnectionGUID: 7DDkFBC9TZGW+2vaurWI5w==
X-CSE-MsgGUID: pyvheRKlSBKzhRR2zV7dBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22619124"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22619124"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:52:07 -0700
X-CSE-ConnectionGUID: 9qhGhQkTTn2NhXFZFgo2XA==
X-CSE-MsgGUID: RjWZ12p+T0Wh3W2AR8ODig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66357871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 05:52:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 05:52:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 05:52:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 05:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6ihwKO6p45EHAYtayljeDvgZCHPX1ooNHMg+Of8YVII36xqh2RkYmHrBoBA9j4qYiEg0fdxn4Yrects2FYnV95Oq3kncpUGtZfSW5ZLXpjNDrV4Jt2MD9fyvFJ1KzDszXTbGzmJa7ep5iycAptsyWVhsUbelSV7X59H9cNJdp+Qx/HVPQAyO8v3TpjXaZv+b1lPvRQ1lZDx6HT5F9RvhpRMmIBykyN8cNjRKU9INCW3Hl7iQ+2NboBmWXtbmzTzTMWbbiJP8zzU458zwEip03jEGO1wyPJenDhL8s3JHl7PTpQWpimERA0XlaMBOIuVd2+MZOrDj2JnexB1AKlkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rryYV2vUagpy1XqyuTDXrtsr8pLplDXAzrAdYNZiIAE=;
 b=YxO/rQFs7gggYopNZRGAU4m0/jCa9edGJ1Opf159mH0X88iZEgVtoHZ9vmT9GoADlC9oQT1VPjPc/Sipn9xcOLntO7jeAwnZk3q6Mum6HEIXrQoL1uOLwlvAuW8K7QNOPWi4JXdVjvuSYAtbUuMoFoT8SKgAxRyUVOsU5F4kpW/VIIR5PVcKELdCsCLGpOqti08l1RCyw0Ne5jH+7Xa9npOH8KpBt0UnhQUTWblBOqan+K77UfBgnXSfXyh2d/tmvJKxL6OZFL/s0NqqWxmXN4qHLZgipePcfci2PNdESwL5jF+tHn7KJdrDafPIbjMpzap6fISBSy5fihh+txaGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CH0PR11MB5236.namprd11.prod.outlook.com (2603:10b6:610:e3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Thu, 22 Aug 2024 12:52:03 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 12:52:03 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "quic_manafm@quicinc.com"
	<quic_manafm@quicinc.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
Thread-Topic: [PATCH v2 0/7] Add thermal thresholds support
Thread-Index: AQHa9AVXUG9+if23L0i94LJXXQBhg7IyJwIAgAAgegCAAL9gAIAAKe+AgAALU4A=
Date: Thu, 22 Aug 2024 12:52:03 +0000
Message-ID: <4e06ed4bfb3f6f03eaefb73763bf3021829502ce.camel@intel.com>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
	 <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
	 <CAJZ5v0gW-iaL34Mz2M0gzh-ooDbw=Rp=M_-dt1Ctqhxm3wUGQw@mail.gmail.com>
	 <0494c22b09f9143d2a22e1f0ae2ae79b7d61ab63.camel@intel.com>
	 <CAJZ5v0hbPRGyNYv0LjSjqFiH6uixDtsO-2Dbq8Qi_9fWhSwz4A@mail.gmail.com>
	 <dec10692d8bf72b425509d2ea002eebbd7238ccd.camel@intel.com>
In-Reply-To: <dec10692d8bf72b425509d2ea002eebbd7238ccd.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CH0PR11MB5236:EE_
x-ms-office365-filtering-correlation-id: 252c11e2-7996-41f1-d6d8-08dcc2a938a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0NOOTFScEJ6L0RJaVBOOGhPOEtWSERQckJlRTBjWDNMRGpJK1FLTjdhRTBp?=
 =?utf-8?B?dVRrdDI0Q1IrQ095b0QvaVkzcEZwSmQxMDArWnBISW5qZGJnc1VyNXVzT0p0?=
 =?utf-8?B?Sm9ia2JEQnVaejBuRUlRSUJoK29adHZUUUxPNkRTc1Rieko5ZGVqVmxmOXZT?=
 =?utf-8?B?Zkx4ZUVCWmJueXlncWFRY1hwQWpOYjh3ZFB5bURsQzJKV2QwNzlrOHphR3Z2?=
 =?utf-8?B?SVhiVmV5dWlDdjh6akc0OExZRVZmSGJ5ZUpVMlFWYTI5N3FYOHhDY3dHMFVJ?=
 =?utf-8?B?TTdxSjFkRkJoLy8vS2p2bVlpQjh0amJoMzRHOVlFaE16WDZZOXBQejZPdURS?=
 =?utf-8?B?NTJhZzRKcFNWeDRwSzJpd3Fhemx0QWs3V0RLTW13SnhEbmQ5dnJKREx1Znp5?=
 =?utf-8?B?NVZCOUJWTXUrLzdTQ0Mxd2pCOWp4R0VxRzBDaGIveW9SNU9RYnMzOEQvNTZw?=
 =?utf-8?B?M2pqVHlTS1RlYVNudTgzWjhUaG5zWXRTVm4zaUkzakFRdTZwcWRYekk5S1JK?=
 =?utf-8?B?V0Y2Q0o0S3hIS1kybEkyOUdIV2dQb0RyMmhYK294ZzRTZVRHQ2FacFNMYjV1?=
 =?utf-8?B?K2lnV0czeDIxNnlyVis4NVJsWldkWWhDU3pYMHFDdlJPdy9jdW1pQjZMZjZr?=
 =?utf-8?B?dFJKTzlwREF4NmJqb1NZZzkvZ3JQWnFTc0hpMEhKaTFTb3ZDanRvVVE3L3Uy?=
 =?utf-8?B?MUFlQXZ6K0FFbjBaSVFleVJ0cWFNcDh6V0tnUEpieUZYUzVmckZmeVp0YVVL?=
 =?utf-8?B?dENNbWQ3QzVmb001cUQ0TXd4VkVVSDl1MURaMjk1L1drTWZRVk1uYk5Tc1Js?=
 =?utf-8?B?N1ZzSG0rdi9ZYUlUU25TRWxxQVJJWG1mQUkyWnFMOEhac3psb2FUdEN6c0Nr?=
 =?utf-8?B?TncyOWlVNzRBaERrZkUvR0laTk5ValRaNDZqV3hKVldGekF6Zkl6TWE0dDFM?=
 =?utf-8?B?S3RFWCthaHlFV1lHSzFYTi92V0Y3d2o3Ny9tUzNuZkdkZ3pNTHZLNHhnNlB1?=
 =?utf-8?B?RUM4M3RSbDNHYzVXKzdyekZadHg3ZWYzc2tDbkVyVmsxY2JrMmJoTDJZNHA4?=
 =?utf-8?B?ajgvMTdrUnE2aUxyWEJQcXY0VklERmZWdXRIb1ZNREhyR01OdUJWV3VqUzJp?=
 =?utf-8?B?Ky9aS2sydDh6Mkh2YzcwcXdZdjdsNmpKN1NMRGFFVlQzRkMyUzNRcjJpdlRz?=
 =?utf-8?B?UldWUnN6dVQxeDJUWHdTTWVEOEQxTU9lNDNuUElic0FTUTBubm55RDV6N2ly?=
 =?utf-8?B?UWROQ1JmQWhhaytkQTVpRXlPaTMzZ0g3eHQxaHZvTW81ZmlDbitiMExTTWhI?=
 =?utf-8?B?QjNMU0p3Y250c0R0NGVVTFpjTkZiZS9ZcVJ4OWlqcFc0bGlKemFoU2VGaitO?=
 =?utf-8?B?WkhXejJIYm1icWNFLzdUWFZUN2puRUhodGpjUHBhSU9MVG95TkdKQzlFMnpU?=
 =?utf-8?B?NU9KSVBuMklseCt2TkNweTJlK3FzR1RKdmtvVXNnc3NCYmFhb3BDanZKbVFV?=
 =?utf-8?B?TVNrQlRsby8yQmlQR3hIbmp2TG14WGNDWHFKMSs3d29Dc0dRaGN5M3JQWkN0?=
 =?utf-8?B?b3o1SXgzTFh5N1hpWmZrQi85M3hycUNITTl1ZGxuRkR3RXczUitCR1VHbElM?=
 =?utf-8?B?YVJ4QTlKL2pGR3QzeU1pbjBuMmh5SDN2UWN3RU0razIyYnBzaFhMM0FiWG5T?=
 =?utf-8?B?ODVXYmR3NXg0STJ6eUNkVWFvdlB1RWpFTzZxcS84UmJUVFN0K0RxT0pGdFFG?=
 =?utf-8?B?N2puaDJMN2w5UFc4azFQT1ZtU0NYNkF4eVNDeS9JaDUyYVVkVlV0akVVTVFB?=
 =?utf-8?B?M1kzaVRsUzh5WkpudE0xM3hUcE5TMTFQSktKaXFMUm9SM3BJT0ZiNlNubHBM?=
 =?utf-8?B?M3IrZWYydS9TUU5KVmhhMGZVakNJcmVseSs1eUJNSTI2M2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1pKM0hFQ2Z6SUJqeERQTVlPYUQxU0xRZGdraDQwYWtqanM4am1vdDBESzE0?=
 =?utf-8?B?MkQvQVExeEZKcFI3Qk03K1o2VEVDUXhvbWRGVTlyY1hJNFgxL0RTZWtScEJR?=
 =?utf-8?B?akJrU3VZSmk4Tncxd0tjVnFkcllnaUV4dHh4MWVmWDZneWk5cytQbkxQdzVL?=
 =?utf-8?B?UTZhRDRTclZEVXRlMllMQlhIR25oTGQrYlVvUGhXRXZvb2I3dEFjN0VIQTR4?=
 =?utf-8?B?WU11Mjc3bUhoSnE3YnBJZ3pQdHltUFF6VnJ1allobDFHRTFmYzVITDZtQ1cz?=
 =?utf-8?B?Q1ZxaVZxWDdJb1VQb3BPR0llSXo1ekkxcm1YT1UxcVg0cDdrMHluVjhtTlJP?=
 =?utf-8?B?eHExSitVcE1EanEyRU5tTkFKNGVJaGJnbmw1SVcxbTNLcVJXTklSMnphd0xH?=
 =?utf-8?B?Y1Y1NWYvUmRTSFljQkJMVElhclJXM0kyVWdvZVh4RUVOb3FWanJiNkc2dmp5?=
 =?utf-8?B?d2xRMDU5MjA4ODNTV0VzaTQybG9qUWt5K3lYNHl3bmdoWHExZWtISm91ZEY3?=
 =?utf-8?B?cTFlaHpsWG93Y1dkZXlxYjFXNm1ad0IyQlZUQjF5b21FTXJZWSs1ZWd3blp1?=
 =?utf-8?B?aGhYVWMzTTlWUFF4VmNNbktUWUpQZnZ2ZkNRdmhyaUQzSmtsZzFWNis0NjVU?=
 =?utf-8?B?RmhVdWY3MFBObzZHMFRvVWhrellYRVprZkdzVTR0TC9iRXFqUUQ0LzNRamZk?=
 =?utf-8?B?aVN0czUvVS9sZEIxbll2a3VwcjdKb203RVh5S2lFay9RUVltWmE4M2xVcUV3?=
 =?utf-8?B?WjhoSG9KcUdGQmtXVjVJRE82eWpITkdLc0pCK00rbW5nTTdKalpHUXV3Vkxn?=
 =?utf-8?B?VmpaaUFWejVXcW01NE5oMndndlFLdVZHY3lLVWdHWkloa05EYWhMYmhqQ28r?=
 =?utf-8?B?TWdUQi9sQnZDZS9SV29NZlp6c2ovSlRwY3lZcGJuYTlpbWNwRUhTWmJibGxW?=
 =?utf-8?B?QVFWOFZrWENuMlhkRGszWkZFc2JzeFhkdEtCOVBlRWdEdnFPcVNDZlN6cmU2?=
 =?utf-8?B?M2N6MCtwZ2ZZUWFIV01CTXE1M1BpL2hkbThoamZsVEtkUVNEMURKY2VmR0Rj?=
 =?utf-8?B?VW5lZjVMbmhkak10bTYveHNjOUErRnk4WTNZYndENVlwb1VkMkdSbys3YVFE?=
 =?utf-8?B?a0g5M0ROVDJnYy9idGl1Z3d5RDczS3pBVzAyekdEc0JGYkNUVUMrbGhEdFJC?=
 =?utf-8?B?UldEOG5UZFRIRlpReWh0NFdrcW1vVUVEeHluU2tDR2JTU2pOQldmQ1YyOW5M?=
 =?utf-8?B?R09HMjUwb0hYOFdIQlN2R1FFcVNlOE94TkxKQTJUZVFobStmNkNLWHlSSWx5?=
 =?utf-8?B?cDVCempNUU1jWUczNVlvL2ZYSVVkRU5ocFVrUnFPODUwN1lKSGpLQ1oxZGJV?=
 =?utf-8?B?WXdTdGwrUzRDdDJwU2RKbS9oVHgxVEw0VWlnekx1a3Q0N29KamtuN0NyS2hp?=
 =?utf-8?B?b3d5bjdUZ1NCQ1RQdDRCTFk3eWxSdjduNHhVMU9YUXRjOWg3VzE5UUd0d0tN?=
 =?utf-8?B?Rno2VVFObUNoUk9hdno5ak9QTG5LUDYrU1BneU5yWE9rYXFnVThRallzRjR5?=
 =?utf-8?B?a08zSXNkcjBjQVRacytYc2t5OStCbGxBRUtrQkVWRm44MXpXOUJiNGFxcWNU?=
 =?utf-8?B?eU9wdk81S3NFcmk2TG4rQWtBbThwNGM5V2x4L2huZEFjUnV5VU8wbHdwVlZx?=
 =?utf-8?B?WmthQU9vTGhNZ3FnQUR5b0N3UURTU0xMRWt3akZDMllReVpIZmd5eHE3VkQ1?=
 =?utf-8?B?d2l3ZzFCUWM5U1dGcmNpV01VMEpVVE12dW56VTlXaXJEM2RENVh2NTQza0Fr?=
 =?utf-8?B?NkdkaEdUcUcwY2dLQ3U4a2tUUnF4QkpReUlWajJLV0hjU1FNMXg0RFovT0Zs?=
 =?utf-8?B?NzJmendabEtxSXZhS1pIUFB2clBYeXkwOTNFS1ZDY1pLSHhLNHkzaElkODNJ?=
 =?utf-8?B?NFNIVFNxNGdEdVlVN3JHa3JLaTU2aDR0ZDZjWFdoa1cwSEg4L0hXZEowdC9Y?=
 =?utf-8?B?SnVQOGxSQkFKbk03Q3E5TlpqcXBnMWRSUXl6K2FVMGtqRFZPYVhrbGRmNjcw?=
 =?utf-8?B?NlRPUW4xdXBrZlFGSVMyMEJUT0MrdEpmalZsZVJxQnVVQkVBOFVpMTVkRDlI?=
 =?utf-8?B?Y3lFS0pkQzFhQzE4eTJBQmVHc3k5SElaWHU2VXgxNXNzVVlCanNmN2JDYlNI?=
 =?utf-8?Q?zN4/QCYJo/W8SNXpyD7P40Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67145BE7795EFC428A7EBF1ADF8D55CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252c11e2-7996-41f1-d6d8-08dcc2a938a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 12:52:03.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3bxHKkPpPowjDnlj3VB4l3usoT1CaXyWyj3oCl29XiaxzJASX7/7NY6AU+Tm1YyC6/BZXLqW4bTcmKHrZ4xvytV0WjHFHH3TtFsKFbDDUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5236
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTIyIGF0IDEyOjExICswMDAwLCBQYW5kcnV2YWRhLCBTcmluaXZhcyB3
cm90ZToNCj4gT24gVGh1LCAyMDI0LTA4LTIyIGF0IDExOjQxICswMjAwLCBSYWZhZWwgSi4gV3lz
b2NraSB3cm90ZToNCj4gPiBPbiBUaHUsIEF1ZyAyMiwgMjAyNCBhdCAxMjoxNuKAr0FNIFBhbmRy
dXZhZGEsIFNyaW5pdmFzDQo+ID4gPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPiB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMDI0LTA4LTIxIGF0IDIyOjIwICswMjAwLCBSYWZh
ZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+ID4gSGkgU3Jpbml2YXMsDQo+ID4gPiA+IA0KPiA+
ID4gPiBPbiBXZWQsIEF1ZyAyMSwgMjAyNCBhdCAxMDowNOKAr1BNIFBhbmRydXZhZGEsIFNyaW5p
dmFzDQo+ID4gPiA+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gSGkgRGFuaWVsLA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIEZy
aSwgMjAyNC0wOC0xNiBhdCAxMDoxMiArMDIwMCwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+ID4g
PiA+ID4gPiBUaGUgdHJpcCBwb2ludHMgYXJlIGEgZmlybXdhcmUgZGVzY3JpcHRpb24gb2YgdGhl
DQo+ID4gPiA+ID4gPiB0ZW1wZXJhdHVyZQ0KPiA+ID4gPiA+ID4gbGltaXRzDQo+ID4gPiA+ID4g
PiBvZiBhIHNwZWNpZmljIHRoZXJtYWwgem9uZSB3aGVyZSB3ZSBhc3NvY2lhdGUgYW4gYWN0aW9u
DQo+ID4gPiA+ID4gPiB3aGljaGNhbid0DQo+ID4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+ID4gZG9u
ZQ0KPiA+ID4gPiA+ID4gYnkgdGhlIGtlcm5lbC4gVGhlIHRpbWUgcmVzb2x1dGlvbiBpcyBsb3cu
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZSB1c2Vyc3BhY2UgaGFzIHRvIGRlYWwgd2l0
aCBhIG1vcmUgY29tcGxleCB0aGVybWFsDQo+ID4gPiA+ID4gPiBtYW5hZ2VtZW50DQo+ID4gPiA+
ID4gPiBiYXNlZA0KPiA+ID4gPiA+ID4gb24gaGV1cmlzdGljcyBmcm9tIGRpZmZlcmVudCBpbmZv
cm1hdGlvbiBjb21pbmcgZnJvbQ0KPiA+ID4gPiA+ID4gZGlmZmVyZW50DQo+ID4gPiA+ID4gPiBw
bGFjZXMuIFRoZSBsb2dpYyBpcyBtdWNoIG1vcmUgY29tcGxleCBidXQgYmFzZWQgb24gYQ0KPiA+
ID4gPiA+ID4gYmlnZ2VyDQo+ID4gPiA+ID4gPiB0aW1lDQo+ID4gPiA+ID4gPiByZXNvbHV0aW9u
LCB1c3VhbGx5IG9uZSBzZWNvbmQgYmFzZWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRo
ZSBwdXJwb3NlIG9mIHRoZSB1c2Vyc3BhY2UgaXMgdG8gbW9uaXRvciB0aGUgdGVtcGVyYXR1cmVz
DQo+ID4gPiA+ID4gPiBmcm9tDQo+ID4gPiA+ID4gPiBkaWZmZXJlbnQgcGxhY2VzIGFuZCB0YWtl
IGFjdGlvbnMuIEhvd2V2ZXIsIGl0IGNhbiBub3QgYmUNCj4gPiA+ID4gPiA+IGNvbnN0YW50bHkN
Cj4gPiA+ID4gPiA+IHJlYWRpbmcgdGhlIHRlbXBlcmF0dXJlIHRvIGRldGVjdCB3aGVuIGEgdGVt
cGVyYXR1cmUNCj4gPiA+ID4gPiA+IHRocmVzaG9sZA0KPiA+ID4gPiA+ID4gaGFzDQo+ID4gPiA+
ID4gPiBiZWVuIHJlYWNoZWQuIFRoaXMgaXMgZXNwZWNpYWxseSBiYWQgZm9yIG1vYmlsZSBvciBl
bWJlZGRlZA0KPiA+ID4gPiA+ID4gc3lzdGVtIGFzDQo+ID4gPiA+ID4gPiB0aGF0IHdpbGwgbGVh
ZCB0byBhbiB1bmFjY2VwdGFibGUgbnVtYmVyIG9mIHdha2V1cCB0byBjaGVjaw0KPiA+ID4gPiA+
ID4gdGhlDQo+ID4gPiA+ID4gPiB0ZW1wZXJhdHVyZSB3aXRoIG5vdGhpbmcgdG8gZG8uDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIHRoZSBvdGhlciBzaWRlLCB0aGUgc2Vuc29ycyBhcmUg
bm93IG1vc3Qgb2YgdGhlIHRpbWUNCj4gPiA+ID4gPiA+IGludGVycnVwdA0KPiA+ID4gPiA+ID4g
ZHJpdmVuLiBUaGF0IG1lYW5zIHRoZSB0aGVybWFsIGZyYW1ld29yayB3aWxsIHVzZSB0aGUNCj4g
PiA+ID4gPiA+IHRlbXBlcmF0dXJlDQo+ID4gPiA+ID4gPiB0cmlwDQo+ID4gPiA+ID4gPiBwb2lu
dHMgdG8gcHJvZ3JhbSB0aGUgc2Vuc29yIHRvIHRyaWdnZXIgYW4gaW50ZXJydXB0IHdoZW4gYQ0K
PiA+ID4gPiA+ID4gdGVtcGVyYXR1cmUgbGltaXQgaXMgY3Jvc3NlZC4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSwgdGhlIHVzZXJzcGFjZSBjYW4gbm90IGJlbmVmaXQg
dGhpcyBmZWF0dXJlDQo+ID4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiA+IGN1cnJlbnQNCj4gPiA+
ID4gPiA+IHNvbHV0aW9ucyBmb3VuZCBoZXJlIGFuZCB0aGVyZSwgaW93IG91dC1vZi10cmVlLCBh
cmUgdG8gYWRkDQo+ID4gPiA+ID4gPiBmYWtlDQo+ID4gPiA+ID4gPiB0cmlwDQo+ID4gPiA+ID4g
PiBwb2ludHMgaW4gdGhlIGZpcm13YXJlIGFuZCBlbmFibGUgdGhlIHdyaXRhYmxlIHRyaXAgcG9p
bnRzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGlzIGlzIGJhZCBmb3IgZGlmZmVyZW50
IHJlYXNvbnMsIHRoZSB0cmlwIHBvaW50cyBhcmUgZm9yDQo+ID4gPiA+ID4gPiBpbi0NCj4gPiA+
ID4gPiA+IGtlcm5lbA0KPiA+ID4gPiA+ID4gYWN0aW9ucywgdGhlIHNlbWFudGljIG9mIHRoZWly
IHR5cGVzIGlzIHVzZWQgYnkgdGhlIHRoZXJtYWwNCj4gPiA+ID4gPiA+IGZyYW1ld29yaw0KPiA+
ID4gPiA+ID4gYW5kIGJ5IGFkZGluZyB0cmlwIHBvaW50cyBpbiB0aGUgZGV2aWNlIHRyZWUgaXMg
YSB3YXkgdG8NCj4gPiA+ID4gPiA+IG92ZXJjb21lDQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4g
PiA+IGN1cnJlbnQgbGltaXRhdGlvbiBidXQgdGFtcGVyaW5nIHdpdGggaG93IHRoZSB0aGVybWFs
DQo+ID4gPiA+ID4gPiBmcmFtZXdvcmsNCj4gPiA+ID4gPiA+IGlzDQo+ID4gPiA+ID4gPiBzdXBw
b3NlZCB0byB3b3JrLiBUaGUgd3JpdGFibGUgdHJpcCBwb2ludHMgaXMgYSB3YXkgdG8NCj4gPiA+
ID4gPiA+IGFkanVzdA0KPiA+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+ID4gdGVtcGVyYXR1cmUgbGlt
aXQgZ2l2ZW4gYSBzcGVjaWZpYyBwbGF0Zm9ybSBpZiB0aGUgZmlybXdhcmUNCj4gPiA+ID4gPiA+
IGlzDQo+ID4gPiA+ID4gPiBub3QNCj4gPiA+ID4gPiA+IGFjY3VyYXRlIGVub3VnaCBhbmQgVEJI
IGl0IGlzIG1vcmUgYSBkZWJ1ZyBmZWF0dXJlIGZyb20gbXkNCj4gPiA+ID4gPiA+IFBPVi4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIHRocmVzaG9sZHMgbWVjaGFuaXNtIGlzIGEgd2F5
IHRvIGhhdmUgdGhlIHVzZXJzcGFjZSB0bw0KPiA+ID4gPiA+ID4gdGVsbA0KPiA+ID4gPiA+ID4g
dGhlcm1hbCBmcmFtZXdvcmsgdG8gc2VuZCBhIG5vdGlmaWNhdGlvbiB3aGVuIGEgdGVtcGVyYXR1
cmUNCj4gPiA+ID4gPiA+IGxpbWl0DQo+ID4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+ID4gY3Jvc3Nl
ZC4gVGhlcmUgaXMgbm8gaWQsIG5vIGh5c3RlcmVzaXMsIGp1c3QgdGhlDQo+ID4gPiA+ID4gPiB0
ZW1wZXJhdHVyZQ0KPiA+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+
IGRpcmVjdGlvbiBvZiB0aGUgbGltaXQgY3Jvc3NpbmcuIFRoYXQgbWVhbnMgd2UgY2FuIGJlDQo+
ID4gPiA+ID4gPiBub3RpZmllZA0KPiA+ID4gPiA+ID4gd2hlbiBhDQo+ID4gPiA+ID4gPiB0aHJl
c2hvbGQgaXMgY3Jvc3NlZCB0aGUgd2F5IHVwIG9ubHksIG9yIHRoZSB3YXkgZG93biBvbmx5DQo+
ID4gPiA+ID4gPiBvcg0KPiA+ID4gPiA+ID4gYm90aA0KPiA+ID4gPiA+ID4gd2F5cy4gVGhhdCBh
bGxvd3MgdG8gY3JlYXRlIGh5c3RlcmVzaXMgdmFsdWVzIGlmIGl0IGlzDQo+ID4gPiA+ID4gPiBu
ZWVkZWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEEgdGhyZXNob2xkIGNhbiBiZSBhZGRl
ZCwgZGVsZXRlZCBvciBmbHVzaGVkLiBUaGUgbGF0dGVyDQo+ID4gPiA+ID4gPiBtZWFucw0KPiA+
ID4gPiA+ID4gYWxsDQo+ID4gPiA+ID4gPiB0aHJlc2hvbGRzIGJlbG9uZ2luZyB0byBhIHRoZXJt
YWwgem9uZSB3aWxsIGJlIGRlbGV0ZWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBTbyB5b3UgYXJlIHByb3Bvc2luZyB0byBhZGQgdGhyZXNob2xkIHZpYSBuZXRsaW5rLCBu
b3QgYWRkaW5nDQo+ID4gPiA+ID4gYW55DQo+ID4gPiA+ID4gbmV3DQo+ID4gPiA+ID4gc3lzZnMg
YXR0cmlidXRlPyBUaGF0IGlzIG5vdCBjbGVhciBoZXJlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IEkgdGhpbmsgeW91IGFyZSBhZGRpbmciDQo+ID4gPiA+ID4gVEhFUk1BTF9HRU5MX0NNRF9USFJF
U0hPTERfR0VUDQo+ID4gPiA+ID4gVEhFUk1BTF9HRU5MX0NNRF9USFJFU0hPTERfQUREDQo+ID4g
PiA+ID4gVEhFUk1BTF9HRU5MX0NNRF9USFJFU0hPTERfREVMRVRFDQo+ID4gPiA+ID4gVEhFUk1B
TF9HRU5MX0NNRF9USFJFU0hPTERfRkxVU0gNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBXZSBuZWVk
IHRvIGRvY3VtZW50IG91ciBuZXRsaW5rIG1lc3NhZ2VzIGluY2x1ZGluZyBvbGQgb25lcy4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBBbHNvIHdlIHNob3VsZCBhZGQgIk1PRElGWSIgYXMgd2UgdGVu
ZCB0byBjaGFuZ2UgdGhlbSBxdWl0ZQ0KPiA+ID4gPiA+IG9mdGVuLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IEFsc28gbm8gaHlzdGVyZXNpcywgdGhhdCBpcyBwcmFjdGljYWxseSB3ZSBjYW4ndCB1
c2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgZGlyZWN0aW9uIHRoaW5nIGlzIGVxdWl2YWxlbnQg
dG8gaHlzdGVyZXNpcyB0aG91Z2guDQo+ID4gPiA+IA0KPiA+ID4gPiBJbnN0ZWFkIG9mIHVzaW5n
IG9uZSB0aHJlc2hvbGQgd2l0aCBhIGdpdmVuIGh5c3RlcmVzaXMgdmFsdWUsDQo+ID4gPiA+IHVz
ZQ0KPiA+ID4gPiB0d28NCj4gPiA+ID4gb2YgdGhlbSB3aXRoIGRpZmZlcmVudCB0ZW1wZXJhdHVy
ZSB2YWx1ZXMgYW5kIGRpZmZlcmVudA0KPiA+ID4gPiBkaXJlY3Rpb25zLg0KPiA+ID4gPiANCj4g
PiA+ID4gPiBUZW1wZXJhdHVyZSBjaGFuZ2VzIHNvIG11Y2ggdGhhdCB0aGF0IHdpbGwgZmxvb2Qg
dXNlciBzcGFjZS4NCj4gPiA+ID4gPiBZb3UNCj4gPiA+ID4gPiB3aWxsIGdldCAxMDBzIG9mDQo+
ID4gPiA+ID4gZXZlbnRzIG9uIENQVSB0ZW1wZXJhdHVyZSBpZiB5b3Ugc2V0IHRlbXBlcmF0dXJl
IHRocmVzaG9sZCBpbg0KPiA+ID4gPiA+IENQVS4NCj4gPiA+ID4gDQo+ID4gPiA+IEV2ZW50cyBv
bmx5IHRyaWdnZXIgd2hlbiB0aHJlc2hvbGRzIGFyZSBjcm9zc2VkIGluIGEgc3BlY2lmaWMNCj4g
PiA+ID4gZGlyZWN0aW9uLCBidXQgb3ZlcmFsbCB5b3UgaGF2ZSBhIHBvaW50Lg0KPiA+ID4gDQo+
ID4gPiBUaGlzIGlzIGdvb2QgZW5vdWdoIGZvciBzb21lIHNlbnNvciB3aGljaCBjaGFuZ2VzIHNs
b3dseSBsaWtlDQo+ID4gPiBza2luLg0KPiA+IA0KPiA+IFJpZ2h0LCBhbmQgSSB0aGluayB0aGF0
IHRoaXMgaXMgdGhlIGRyaXZpbmcgdXNlIGNhc2UuDQo+ID4gDQo+ID4gPiBCdXQgc29tZSBzZW5z
b3JzIGxpa2UgQ1BVIGFuZCBib2FyZCBhcmUgbm90IGxpa2UgdGhhdC4NCj4gPiANCj4gPiBTdXJl
LCBzbyB0aGlzIGludGVyZmFjZSB3aWxsIG5vdCBiZSBmb3IgdGhlbS4NCj4gQnV0IHdoZW4gd2Ug
ZGVzaWduIGFuIGludGVyZmFjZSwgSSB0aGluayB0aGlzIHNob3VsZG4ndCBiZSBzZW5zb3INCj4g
ZGVwZW5kZW50Lg0KPiANCj4gPiANCj4gPiA+IFdlIHB1Ymxpc2ggYm90aCByYXcgYW5kIGZpbHRl
cmVkIGV2ZW50IGNvdW50IGluIGRlYnVnZnMgZm9yIHg4Ng0KPiA+ID4gcGFja2FnZSB0ZW1wLg0K
PiA+ID4gRm9yIGV4YW1wbGUsIEkganVzdCByYW4gYSBzYW1wbGUgb24gYSBjbGllbnQgZm9yIG9u
ZSB0aHJlc2hvbGQuDQo+ID4gPiANCj4gPiA+IFRvdGFsIG5vdGlmaWNhdGlvbiBmcm9tIGhhcmR3
YXJlOiAyMjQNCj4gPiA+IE5vdGlmaWVkIHRvIHVzZXIgc3BhY2U6IDE2DQo+ID4gDQo+ID4gU28g
ZGlkIHlvdSBhcHBseSB0aGUgRGFuaWVsJ3MgcGF0Y2hlcyBhbmQgcnVuIHRoZSB0ZXN0IG9yIGRp
ZCB5b3UNCj4gPiBkbw0KPiA+IHNvbWV0aGluZyBlbHNlPw0KPiBXZSBhbHJlYWR5IHVzZSBuZXRs
aW5rIHRvIHNlbmQgbm90aWZpY2F0aW9uIHRvIHVzZXIgc3BhY2UgdmlhDQo+IHdyaXRhYmxlDQo+
IHRyaXAuIFNvIGRpZG4ndCBhcHBseSBhbnkgcGF0Y2hlcy4gSSBkb24ndCBzZWUgdGhlc2UgcGF0
Y2hlcyB3aWxsIGRvDQo+IGFueSBkaWZmZXJlbnQuDQoNCkkgbWVhbiB3aXRob3V0IHJhdGUgbGlt
aXQgaGVyZSBhbGwgMjI0IG5vdGlmaWNhdGlvbnMgd2lsbCBiZSBwYXNzZWQgdG8NCnVzZXIgc3Bh
Y2UgKG5vdCAxNikuIFRlbXBlcmF0dXJlIGdvZXMgdXAgYW5kIGRvd24gb3ZlciB0aHJlc2hvbGQg
Zm9yDQoxMDBzIG9mIHRpbWVzIGJlZm9yZSBzZXR0bGluZy4NCg0KSSBjYW4gZ2l2ZSAgYSB0cnkg
d2l0aCB0aGlzIHNlcmllcyB0byBjb25maXJtLg0KDQpUaGFua3MsDQpTcmluaXZhcw0KDQo+IA0K
PiANCj4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gV2UgaGF2ZSBhIHdob2xlIGZpbHRlcmluZyBp
biBkcml2ZXIgdG8gYXZvaWQgdGhpcy4NCj4gPiA+ID4gPiBZb3UgbmVlZCBhIHJhdGUgbGltaXQg
aGVyZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGVyZSBhcmUgbXVsdGlwbGUgdXNlciBwcm9j
ZXNzZXMgY2FuIGFkZCB0aHJlc2hvbGQgYW5kIHRoZXJlDQo+ID4gPiA+ID4gaXMgbm8NCj4gPiA+
ID4gPiBvd25lcnNoaXAuIFNvIG9uZSBwcm9jZXNzIGNhbiBjYXVzZSB0b28gbXVjaCBub2lzZSB0
byBvdGhlcnMNCj4gPiA+ID4gPiBhcw0KPiA+ID4gPiA+IGl0DQo+ID4gPiA+ID4gaXMNCj4gPiA+
ID4gPiBtdWx0aWNhc3QuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2Ugd29ya2VkIG9uIGEgY2hh
bmdlIHRvIGZpbGVyIHRoZXNlIGFzIGRpc2N1c3NlZCBkdXJpbmcgbGFzdA0KPiA+ID4gPiA+IExQ
QywNCj4gPiA+ID4gPiBidXQNCj4gPiA+ID4gPiBub3QgcG9zdGVkIHlldC4gVGhpcyB3aWxsIHJl
YWxseSBuZWVkIHRoaXMgYXMgdGhpcyB3aWxsIGJlDQo+ID4gPiA+ID4gdG9vDQo+ID4gPiA+ID4g
bWFueQ0KPiA+ID4gPiA+IG1lc3NhZ2VzLg0KPiA+ID4gPiANCj4gPiA+ID4gVW5sZXNzIHRoZXJl
IGlzIGEgd2F5IHRvIGxpbWl0IHlvdXIgc3Vic2NyaXB0aW9uIHRvIGV2ZW50cw0KPiA+ID4gPiBy
ZWdhcmRpbmcNCj4gPiA+ID4gYQ0KPiA+ID4gPiBzcGVjaWZpYyB0aGVybWFsIHpvbmUsIGZvciBp
bnN0YW5jZS4NCj4gPiA+IFRoYXQncyB3aGF0IHRoaXMgY2hhbmdlIGRvZXMuDQo+ID4gPiANCj4g
PiA+ID4gDQo+ID4gPiA+IEFueXdheSwgSSBoYXZlIHRvIGFkbWl0IGlnbm9yYW5jZSByZWdhcmRp
bmcgdGhlIHVzZXIgc3BhY2UNCj4gPiA+ID4gdXNhZ2UNCj4gPiA+ID4gbW9kZWwNCj4gPiA+ID4g
cmVsYXRlZCB0byB0aGlzLsKgIEZvciBleGFtcGxlLCBpcyBpdCBleHBlY3RlZCB0aGF0IHRoZXJl
IHdpbGwNCj4gPiA+ID4gYmUNCj4gPiA+ID4gb25lDQo+ID4gPiA+IHVzZXIgc3BhY2UgZW50aXR5
IG1hbmFnaW5nIHRoZSB0aHJlc2hvbGRzIG9yIHRoZXJlIGNhbiBiZSBtYW55Lg0KPiA+ID4gDQo+
ID4gPiBHb29kIHF1ZXN0aW9uLiBUaGF0J3Mgd2h5IHdlIGRpZG4ndCBzZW5kIHRoaXMgY2hhbmdl
LiBJZiB0aGVyZSBpcw0KPiA+ID4gb25lDQo+ID4gPiBhZ2VudCB0aGlzIGlzIGZpbmUuDQo+ID4g
DQo+ID4gSSB0aGluayB0aGF0IHRoZSBhZGRpdGlvbiBhbmQgZGVsZXRpb24gb2YgYSB1c2VyIHRo
cmVzaG9sZCBzaG91bGQNCj4gPiBiZQ0KPiA+IHByaXZpbGVnZWQgb3BlcmF0aW9ucy4NCj4gPiAN
Cj4gPiBJZiB0aGF0IGlzIHRoZSBjYXNlLCBpdCBhbGwgYm9pbHMgZG93biB0byBwcm9wZXIgY29v
cmRpbmF0aW9uIGluDQo+ID4gdXNlcg0KPiA+IHNwYWNlLg0KPiA+IA0KPiBTb21lIGtlcm5lbCBB
UEkgdXNlIHNvbWUgY29va2llIGFzIHBhcmFtZXRlci4gSGVyZSBhbHNvIHNvbWV0aGluZw0KPiBs
aWtlDQo+IHRoYXQgY2FuIGJlIHVzZWQgdG8gbWF0Y2guDQo+IA0KPiA+ID4gQnV0IGluIGVtYmVk
ZGVkIHNwYWNlLCB0aGVyZSBtYXkgYmUgbW9yZSB0aGFuIG9uZS4gSGVuY2UgdGhleQ0KPiA+ID4g
bmVlZGVkDQo+ID4gPiBuZXRsaW5rIG11bHRpY2FzdCBpbnN0ZWFkIG9mIGp1c3Qgb25lIGNoYXIg
ZGV2aWNlLg0KPiA+IA0KPiA+IEkgc2VlLg0KPiANCj4gVGhhbmtzLA0KPiBTcmluaXZhcw0KPiAN
Cg0K

