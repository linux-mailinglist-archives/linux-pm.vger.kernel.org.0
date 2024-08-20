Return-Path: <linux-pm+bounces-12531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587EC957F1B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F5A283143
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89C116C86B;
	Tue, 20 Aug 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey7SN0rQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4718E344;
	Tue, 20 Aug 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137844; cv=fail; b=OW0ecVw0ENcevsKGILmtxtL8rDxn+Is7RKcQWmTR6cUTLFPOjIwKHJ3EzIe44LAWUcCQvnyK1GiloA3aSgwrQeiQMGzVgk/MRjWXbfVKHCHgaSeij5uMkRDhi1jpBgEF5vEdpn0jJTFux4j9JTR08gTFDLK9g9Bx4YaMMiSZPc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137844; c=relaxed/simple;
	bh=Iwvp2UsqLbtVrT6vBFaoKeBvAsy8QZhLlRr8dTaVrpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgTY1MsWYSHFQqFAKjfDrPVBhe2keG9im265tWaZaCkmC9KQZSyP91OeNVld4WIomWI12hp/09FtfU3XvMmqw0uIt5ZLDErk80gvtpYUsvUE9QZq0YJ8O6MfVbW84+OISBjSmqt2Buf+YVtCN7pJ9j56+5McZXYGe0vN4VmlHV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey7SN0rQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137843; x=1755673843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Iwvp2UsqLbtVrT6vBFaoKeBvAsy8QZhLlRr8dTaVrpg=;
  b=Ey7SN0rQffknqfLz0P+6E+PqSoDoBHuMC8ZI/PQnZ9Lm2MrNMEXby25N
   1nxohSsRX0BDPl6sYmqW+5IIeAi+jfX7D29gDCS2flf29AKXkJeezbB/U
   D+iTSvRj47vfRDeDNc6qMvYztMURfaXUH8ZMq6f4cjiBWaEewt/2tIgCj
   W2TeygCnsgzRMZqDlBt71DIOrc9qp+svND2ZNGc9R739ktUGt5z8IVcCv
   +JTQ+VqN7DXyKbfgPrBnaQU0DYsDBSX2qt7fB/ny4tPFL7aO4via7qSxc
   qRo9yWNgJ7ZsQwlPK8n8KqSDGNefAO9K6E0hX7AHiI1JaXkuwSKi64Ouj
   g==;
X-CSE-ConnectionGUID: F1ypyQCdT4WHVa3JnNMTQw==
X-CSE-MsgGUID: 7x7jL2DeSfqR/DbZKGoYOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22302368"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22302368"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:10:42 -0700
X-CSE-ConnectionGUID: oxqXmyrKSgS3kKLUrYZPKg==
X-CSE-MsgGUID: 5moKcgcYRcCbE47dHwXNwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60949638"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:10:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:10:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:10:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:10:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTSgx7IVhYPOHRE4/Vz0HoaABwBrkRuubu6keAXhLs3BHuhQFwZk049HL9tRP0GGFwa4KRx38EwkdD9DGaucPAZXqzUKOrhDSeRujVLKroNJpMvVsGOuSFRIlGhqHg3j3rOan5ViD8bp6JJgAAfj4D70K/0eaY56+aXToQEpM8kwUxQoYqNO4JofQ05dG8Ni6VO4DbKRCEYq8dJmJpWMOAqodJcY1lkB43dxVL7H47Z1UMIIlR5yxGM8nh/vOx5QrBRPJ/9KmQV0vQkWaF8E+quoRSmyieFtqL0GHHx95AtdtTl654MZ6r6+NmDWRrVLj1b6nbMYjaAYfAULaaPtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwvp2UsqLbtVrT6vBFaoKeBvAsy8QZhLlRr8dTaVrpg=;
 b=Aj0PRt0Bj+cZpuM3ed+ne674mTlAs6irUgEcf+dJemWF/wK+6rjsHsl0744SgN2mjcBAa9v6N+fYcNUJreDwlO1AUzRO2j85QQAA6jiQXWic66a2dQ/0tm08Rg03U4ewZRMyYEs9CsGaisxJQIS7nuKVAnTif0pRImxx6T+Y+V4lY5ZZ0q727BM3UFMLCe7VuVP9x7+d3fcXrxE5BsQo8+h6pIwjSF9uXoy3VGflf77xB0rOMboPa8iPkHC0dj8Q6eUCPwjJeMzhCdKsZzDMk4xfS8Z9m8c9uPnIl3qoDF9RkozeTQxEWGb3Fn5L4oyfy5uoWtlXbcEhwUnP8J3qZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:10:38 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:10:38 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net"
	<rjw@rjwysocki.net>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 13/14] thermal: core: Drop unused bind/unbind functions
 and callbacks
Thread-Topic: [PATCH v3 13/14] thermal: core: Drop unused bind/unbind
 functions and callbacks
Thread-Index: AQHa8lWWS5U72DMlbk6Y/0q1AM4QkrIvu3AA
Date: Tue, 20 Aug 2024 07:10:37 +0000
Message-ID: <6e99b0d7348a2a31cde0b98e1075c4e907d43fe5.camel@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
	 <4251116.1IzOArtZ34@rjwysocki.net>
In-Reply-To: <4251116.1IzOArtZ34@rjwysocki.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5125:EE_
x-ms-office365-filtering-correlation-id: 5115c6f5-4d9b-4dd3-6db1-08dcc0e73179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WFBZb00xdDJjQ0E5MnQ4d3lZa3BuR0FTTlo5OWJMdUZreDJ3SzRXclFwL2JN?=
 =?utf-8?B?YlhNY3BWWG51MHVLRFlkWFBQOTRwclRXVVF6aGFUaEhBay9NSkhqRUQ0VkFu?=
 =?utf-8?B?YWV6ZlRwQVBwdnFZWitEME4zenZjaGF3K1Bjc3dFQjJ4VTNVcm5CR081Qy9h?=
 =?utf-8?B?T1NKa2pQQzZUcEdLMnI2UXFNRStPeUJMMkptWitlbWdEK0FJc25LRXdGQTBU?=
 =?utf-8?B?Y2ozVUFFcjcvT2ZyYnkvc1JCcGxaSzNRRGpNME5VZDE2bDhOMUY5TzZKTFFU?=
 =?utf-8?B?d0VDbnE2a1FLeGR5T1habnpBV1RLVzdHMXNzSEN3YlNhRzh2OXZHdGZ4RWt4?=
 =?utf-8?B?aWxlaXpadFc4czA0dFVEMzlnbG42aEYwMnFMWDVoK3NwTGJLb3NUTkRwbVRH?=
 =?utf-8?B?MUVZdTVDcVhYRkNXazkxeUxwc2gzd1JDSWlzNkNINVpRMnlnTW13ZXR6dXd0?=
 =?utf-8?B?QmtEazkvMjMzRWhUVzh0WHBod1hXeHVjRWQxMDlJR0dYaENTeVY0YW5ZVGEw?=
 =?utf-8?B?VGU0SmtZL0lEOFhGTERaemJGbWVhbGNmYVcrcDVMQnFEajh1am91ei84RUdU?=
 =?utf-8?B?WWRLZm9KZDJnOUhiZnFXTEV4QU90aG1zY20rVG1aU2o1WlIvc3l2TlVmQ0xl?=
 =?utf-8?B?ZENteXdjcENXdEwyRlI4VFpYbldHOE1zNFp0bXkvVDFYS1MyaVVJN2lnYk5u?=
 =?utf-8?B?bS9lMHV6NlBrc0Q4cTV4cGZJM2s4YUFOdzF1RDdsTTlZVGIydjU1TGdUV2FZ?=
 =?utf-8?B?S2wreW9jSEx2ZXBDcjdUSzdwN0w4OVBDN1JMRlpHR2x0VmhpTDk3T2MzczBw?=
 =?utf-8?B?YWRpM1BTaDM4eWhvM3p3YnNmVmEyQS9WQW1BWmcwNHV5dlAvQnZoVk81SWFt?=
 =?utf-8?B?OFNJNWFGZ0RBNDhCMG8rYksvNnUyMVJsK1dNWGZrMWN0SGFWVTFHYlBmZCtJ?=
 =?utf-8?B?ZGh0Y1BOMWt0QXNoZFRzQzloaStvd2xoMTRKZXBSUm1qWkQ4VVNSeVJ3TUQv?=
 =?utf-8?B?MHREUXpNcEFnVDZmMU5QWmRraDVRd1c2ZzZkOUg3RDloQVZuYlFIdDRLZHlu?=
 =?utf-8?B?K09xcVp2VDROK29ZblZBOTZmNXFxemRRS2pvUVYvNHRaVGZDSGJqbEhWNmYw?=
 =?utf-8?B?NGRncjlSRCs5dkJMNW9ERkNaaUdwRjZ2QlRDbkJZVDMvOTNQOExWN2tHSW1K?=
 =?utf-8?B?THlGd2tMb1Jxb0VPajErYjJZWlI1T3Zacmp2T3hYcnY0RWxKU1Z6QWF4dWxZ?=
 =?utf-8?B?K1RPK3VjSkw4cUJYWXZVMXRJUmNUdktUM1IwMHNOMWhOd0NMUGU1QklmbHV4?=
 =?utf-8?B?Y1U5K3JTT2lidHhjZGhqOWFwLzI4TzAyR3Zqc1NuSjcxSmQvOFVhdUVGU3NS?=
 =?utf-8?B?VmVWZmpjWFkzelEwMDVlbjRIWG9EcVViNGRDQWtwaU5nWld3Z0JzL1RrSkZr?=
 =?utf-8?B?Ync2UFU0NkFZRnJqU1VKVndDbW1naHR2YmZjanE5V01PYjJyK0ttSG51YnBl?=
 =?utf-8?B?ZjYrL0k2Y0pqdm9iTWJxQmZ3YmxaUDVKQzR1K0hyZDZkTlBNT2V6VlRVYjJq?=
 =?utf-8?B?WkhXVUhETUczY2Q1c1krRHEwTjZIVDlTNjlFWU9ZQlE0WGFSNDhHM2lZRkE5?=
 =?utf-8?B?bFd1RDFGNGtxRkprRGlDdGRyRkZ6b3V5RHRjckxnR1k4MURpZFBGUVJLOTV5?=
 =?utf-8?B?bDNoRjB3WGwxU2N1Uy9PdFhkd2U1UG5yb2xBd2QwM2FsbktIWXFCMEhDY0Fm?=
 =?utf-8?B?Y3kzZUFVb2xoQ2k0NGJrYnUySVExRGVnMW9JUGx3ZE9kYm90MTd2WDUrOFdo?=
 =?utf-8?Q?B+jidmB2K8nwguy+s0UKmdUEhuT6dQb7jxkPM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3hNUHg3VmxMc1RHc2pxNlV4S1F3MXBLVDEraDU1eklVeFZ1NTdYWVcwMGd2?=
 =?utf-8?B?Z3hjZnd0d3NWMmNWUGVXblVjUEM0ditjV3UvdkRqZWxIYklZdnZuRDhXWUp1?=
 =?utf-8?B?OU41L0RJalVxSzVqTVVpTDZGZVN0OTBjYVZDak5NK2xpdVJZSzI4QjRSeHhq?=
 =?utf-8?B?TlNvblZSeFZHdTlWU0NBTEo4cEVKb21oR2lzazFjNlFvMlpDaS9ubU9yNTVP?=
 =?utf-8?B?a1ZwNytBcVo1WVhuRWthcTk2dU1SbHI1TW1jUmd1eURlOGRoOGtpMWZ1QkZz?=
 =?utf-8?B?anF0T1VkSi8yTVdoZWNVWjZIQXpCQnk4MlZnUFppVmN1TWpBc3JJbDZGcmxw?=
 =?utf-8?B?YWNSVWpnRGdYK0FjYUFxcittVmNqMEhicnVOSmRFMDk0VktXMjZsRHBRYzh4?=
 =?utf-8?B?MUN2S296Ky9KT0JmUDJrV29pYWlZclZUaWZQaWdIMG5vMVVLVmRsZkcwaUxR?=
 =?utf-8?B?cm03Ti9TTW1ZOGlIU1RoRFV6RTJrNEhTdzdyZlAzajhFS3l6Q01KU0Y1Mm1j?=
 =?utf-8?B?VFJqSXVIVUd0VEh6TUw1Sy9Pa1JBTlBOSjlVTDBhSzlWNkZMOVdXaER3VHZl?=
 =?utf-8?B?N2lGajQrQmdPSHJDeXhrYjZqLzBjdTc5UTNrMDEwVS9DOGphWlNaa25uZW1r?=
 =?utf-8?B?bmNWSDdZbHB1VTlrNFhTRklEaVhtVCs5bGUvR2JYcEFoR05jZDlTUkZtYWJM?=
 =?utf-8?B?TWVPUENBLzFnNXNyd1hTYnd0ZjdsQjBKSGlSdmVYcms4N2lRbXBmamIzQVgx?=
 =?utf-8?B?cmx4bXBleW0vdzU0cnNrRUhWQnJVcGtrSUxuaERTU3hYMUZ3YU4vc0NGaE0x?=
 =?utf-8?B?NFh4ZTVmcUc4WUdiMGxWQWZ2WS90YnVNNms0Z0hVaTJKY3JGTFN1Y2ZCTDZj?=
 =?utf-8?B?Q0svZzJlOEVCYWM5VDZZckNBb0FoZ1Y3ZlRWSDJoNXNtNy83aXRLKzJEVlQ1?=
 =?utf-8?B?OHFtd2ZkZ1o2b2NodDZubERITmdjOWxzNHM4QzJGS2Z3dU8ramlSOThEU2c3?=
 =?utf-8?B?aVk1N2lPU1RaUUhHaVBCcDNFQ1BYVG5qTkFQWEozcWdpWkptU1VVR2FMYlNG?=
 =?utf-8?B?NXVhcitFbHJwRnZHYXBLbE9OR0wrSzE1R3BWR09sMndNRmUyNldEWDM4MG5E?=
 =?utf-8?B?ZzdKaVNzRytHZlYyTlNwWU5CRm15WGsya01xQ3BhY1lXdDE0NXE4QUhaVk0w?=
 =?utf-8?B?MG1GaEU4dGQ1SU5sby85cURYaVVMSU1JWkExcVM5OXl4bEhwN1VQSjJnZFQ1?=
 =?utf-8?B?SWlZU1VuM2hyR29EcmZxZHdUN25CaDFEaFNTTHNFM1k1ZHJ5Q1B1RGFVVFhC?=
 =?utf-8?B?Rk5IWjRRWUlWaTB4ZTRRdU1UZElrTjgvRDNzSnZrNW5UekNzNXo3MHFDbFJs?=
 =?utf-8?B?RU53QllJWWxuRDI4MXFoNnhLd2tTbFVKTjY5NHJFZ1dyQUlhOHZrVnMrWUc3?=
 =?utf-8?B?TnJHbFlwcTk3OUtxQXQvK2l4MEZ5ZmFkTHhGQVV2eVNvYXY4Y2ptYVRHT3Bn?=
 =?utf-8?B?cmRhcmVlKytoR1dJWmV2Yll2bS9BZEVWQ0hoNWNtTTQxMFJ1TWZRM09pekZ5?=
 =?utf-8?B?TlgzdU1DRm5IV052NHRzTHh5Z3RIaWJmV0JRUTZIVWNRajYwQnF4VnprUmlO?=
 =?utf-8?B?c1dNWVhsMlFXbUNmaGFnMjdTajh3ZlYxRlpSdFcyNUVUUkc2MmZiMVJjMEZE?=
 =?utf-8?B?NnEvYXl2NldVOVMvbW5lUVl4akZ0RWxtdFhIdXRoY1ZOME8rRFN4MWRvaE53?=
 =?utf-8?B?WDVuRzhwdllzYnpobTJxbGlwOW5KNis0bC8rb0ppVi9TaWV4SFkvcWdLR2Vs?=
 =?utf-8?B?V1dVNFFlb3F2Ynhyd3ZVakYwZTNES0VWaHFXNnN6MWNGLzk2eWUvb1pLRjZH?=
 =?utf-8?B?bXZRY3JseWQxS1FqakZlNWMzN3p6cGx2S3RzSFlxZUx4NHdGRDdQSFVOUzhq?=
 =?utf-8?B?VDJOeHE0NEdmL2hnZDU0K1NxT1QwSytLK0lGNkZETXpIazk1NFUzemtQVlJV?=
 =?utf-8?B?WjZOY2x1QTB0aHNWVTJXNlRGNGFmUDR3ajlhTkJrMmRVR2pKdFF5MUwxZVUr?=
 =?utf-8?B?cldoSng3K01yb1FQZjVLUDNtTjI2RnZxOGk3c2NWTEdIRXdMVXYvcHh2UldY?=
 =?utf-8?B?bDRzem1oZnlVbHh3RGhtYi9ySzBLVmYzTFl4SkFaazM0VzRiWlNNUHh6TWpo?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A22FE75174F385469B57FE9DA112A201@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5115c6f5-4d9b-4dd3-6db1-08dcc0e73179
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 07:10:37.9749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8fU/Qz3cpzhwaC1hCHzi5bARyD4Sk9EncgCB7qSVIy793M/iQvRVxKpXNlzPLo0gZwKj5hsvAjFSjwadPyrpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDE4OjMxICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gVGhlcmUgYXJlIG5vIG1vcmUgY2FsbGVycyBvZiB0aGVybWFsX3pvbmVfYmluZF9jb29s
aW5nX2RldmljZSgpIGFuZAo+IHRoZXJtYWxfem9uZV91bmJpbmRfY29vbGluZ19kZXZpY2UoKSwg
c28gZHJvcCB0aGVtIGFsb25nIHdpdGggYWxsIG9mCj4gdGhlIGNvcnJlc3BvbmRpbmcgaGVhZGVy
cywgY29kZSBhbmQgZG9jdW1lbnRhdGlvbi4KPiAKPiBNb3Jlb3ZlciwgYmVjYXVzZSB0aGUgLmJp
bmQoKSBhbmQgLnVuYmluZCgpIHRoZXJtYWwgem9uZSBjYWxsYmFja3MKPiB3b3VsZAo+IG9ubHkg
YmUgdXNlZCB3aGVuIHRoZSBhYm92ZSBmdW5jdGlvbnMsIHJlc3BlY3RpdmVseSwgd2VyZSBjYWxs
ZWQsCj4gZHJvcAo+IHRoZW0gYXMgd2VsbCBhbG9uZyB3aXRoIGFsbCBvZiB0aGUgY29kZSByZWxh
dGVkIHRvIHRoZW0uCj4gCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFl
bC5qLnd5c29ja2lAaW50ZWwuY29tPgoKUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5n
QGludGVsLmNvbT4KCnRoYW5rcywKcnVpCgo+IC0tLQo+IAo+IHYyIC0+IHYzOiBObyBjaGFuZ2Vz
Cj4gCj4gdjEgLT4gdjI6Cj4gwqDCoCAqIFVwZGF0ZSB0aGUgbGlzdCBvZiB0aGVybWFsIHpvbmUg
b3BzIGluIHRoZSBkb2N1bWVudGF0aW9uLgo+IAo+IC0tLQo+IMKgRG9jdW1lbnRhdGlvbi9kcml2
ZXItYXBpL3RoZXJtYWwvc3lzZnMtYXBpLnJzdCB8wqDCoCA1OSArLS0tLS0tLS0tLS0tLQo+IC0t
LS0tCj4gwqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA3NSArLS0tLS0tLS0tLS0tLQo+IC0tLS0tLS0tLS0tCj4gwqBp
bmNsdWRlL2xpbnV4L3RoZXJtYWwuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqAgMTAgLS0tCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMTM4IGRlbGV0aW9ucygtKQo+IAo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL3RoZXJt
YWwvdGhlcm1hbF9jb3JlLmMKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVy
cy90aGVybWFsL3RoZXJtYWxfY29yZS5jCj4gKysrIGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90
aGVybWFsX2NvcmUuYwo+IEBAIC04NzgsMjggKzg3OCw2IEBAIGZyZWVfbWVtOgo+IMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gcmVzdWx0Owo+IMKgfQo+IMKgCj4gLWludCB0aGVybWFsX3pvbmVfYmlu
ZF9jb29saW5nX2RldmljZShzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHosCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW50IHRyaXBfaW5kZXgsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRoZXJtYWxf
Y29vbGluZ19kZXZpY2UKPiAqY2RldiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHVw
cGVyLCB1bnNpZ25lZAo+IGxvbmcgbG93ZXIsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50
IHdlaWdodCkKPiAtewo+IC3CoMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gLQo+IC3CoMKgwqDCoMKg
wqDCoGlmICh0cmlwX2luZGV4IDwgMCB8fCB0cmlwX2luZGV4ID49IHR6LT5udW1fdHJpcHMpCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IC0KPiAtwqDC
oMKgwqDCoMKgwqBtdXRleF9sb2NrKCZ0ei0+bG9jayk7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJl
dCA9IHRoZXJtYWxfYmluZF9jZGV2X3RvX3RyaXAodHosICZ0ei0KPiA+dHJpcHNbdHJpcF9pbmRl
eF0udHJpcCwgY2RldiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdXBwZXIsIGxvd2VyLCB3ZWln
aHQpOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnR6LT5sb2NrKTsKPiAtCj4g
LcKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiAtfQo+IC1FWFBPUlRfU1lNQk9MX0dQTCh0aGVy
bWFsX3pvbmVfYmluZF9jb29saW5nX2RldmljZSk7Cj4gLQo+IMKgLyoqCj4gwqAgKiB0aGVybWFs
X3VuYmluZF9jZGV2X2Zyb21fdHJpcCAtIHVuYmluZCBhIGNvb2xpbmcgZGV2aWNlIGZyb20gYQo+
IHRoZXJtYWwgem9uZS4KPiDCoCAqIEB0ejrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHBvaW50ZXIgdG8gYSBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZS4KPiBAQCAtOTQ1LDI1ICs5
MjMsNiBAQCB1bmJpbmQ6Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IMKgCj4g
LWludCB0aGVybWFsX3pvbmVfdW5iaW5kX2Nvb2xpbmdfZGV2aWNlKHN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlCj4gKnR6LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgdHJpcF9pbmRleCwKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UKPiAqY2RldikK
PiAtewo+IC3CoMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoGlmICh0
cmlwX2luZGV4IDwgMCB8fCB0cmlwX2luZGV4ID49IHR6LT5udW1fdHJpcHMpCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+IC0KPiAtwqDCoMKgwqDCoMKg
wqBtdXRleF9sb2NrKCZ0ei0+bG9jayk7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHJldCA9IHRoZXJt
YWxfdW5iaW5kX2NkZXZfZnJvbV90cmlwKHR6LCAmdHotCj4gPnRyaXBzW3RyaXBfaW5kZXhdLnRy
aXAsIGNkZXYpOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJnR6LT5sb2NrKTsK
PiAtCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiAtfQo+IC1FWFBPUlRfU1lNQk9MX0dQ
TCh0aGVybWFsX3pvbmVfdW5iaW5kX2Nvb2xpbmdfZGV2aWNlKTsKPiAtCj4gwqBzdGF0aWMgdm9p
ZCB0aGVybWFsX3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQo+IMKgewo+IMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHo7Cj4gQEAgLTk5MiwxNCArOTUxLDgg
QEAgdm9pZCBwcmludF9iaW5kX2Vycl9tc2coc3RydWN0IHRoZXJtYWxfego+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCB0aGVybWFs
X3RyaXAgKnRyaXAsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IHRoZXJtYWxfY29vbGluZ19kZXZpY2UgKmNkZXYsIGludCByZXQpCj4gwqB7
Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKHRyaXApIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGV2X2VycigmdHotPmRldmljZSwgImJpbmRpbmcgY2RldiAlcyB0byB0cmlwICVkCj4g
ZmFpbGVkOiAlZFxuIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGNkZXYtPnR5cGUsIHRoZXJtYWxfem9uZV90cmlwX2lkKHR6LCB0cmlwKSwKPiByZXQp
Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gLcKgwqDCoMKgwqDC
oMKgfQo+IC0KPiAtwqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZ0ei0+ZGV2aWNlLCAiYmluZGluZyB6
b25lICVzIHdpdGggY2RldiAlcwo+IGZhaWxlZDolZFxuIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdHotPnR5cGUsIGNkZXYtPnR5cGUsIHJldCk7Cj4gK8KgwqDCoMKgwqDCoMKg
ZGV2X2VycigmdHotPmRldmljZSwgImJpbmRpbmcgY2RldiAlcyB0byB0cmlwICVkIGZhaWxlZDoK
PiAlZFxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2Rldi0+dHlwZSwgdGhl
cm1hbF96b25lX3RyaXBfaWQodHosIHRyaXApLCByZXQpOwo+IMKgfQo+IMKgCj4gwqBzdGF0aWMg
dm9pZCB0aGVybWFsX3pvbmVfY2Rldl9iaW5kaW5nKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNl
Cj4gKnR6LAo+IEBAIC0xMDA4LDE4ICs5NjEsNiBAQCBzdGF0aWMgdm9pZCB0aGVybWFsX3pvbmVf
Y2Rldl9iaW5kaW5nKHN0Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB0aGVybWFsX3RyaXBfZGVz
YyAqdGQ7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCByZXQ7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAv
Kgo+IC3CoMKgwqDCoMKgwqDCoCAqIE9sZC1zdHlsZSBiaW5kaW5nLiBUaGUgLmJpbmQoKSBjYWxs
YmFjayBpcyBleHBlY3RlZCB0bwo+IGNhbGwKPiAtwqDCoMKgwqDCoMKgwqAgKiB0aGVybWFsX2Jp
bmRfY2Rldl90b190cmlwKCkgdW5kZXIgdGhlIHRoZXJtYWwgem9uZSBsb2NrLgo+IC3CoMKgwqDC
oMKgwqDCoCAqLwo+IC3CoMKgwqDCoMKgwqDCoGlmICh0ei0+b3BzLmJpbmQpIHsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gdHotPm9wcy5iaW5kKHR6LCBjZGV2KTsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50X2JpbmRfZXJyX21zZyh0eiwgTlVM
TCwgY2RldiwgcmV0KTsKPiAtCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
bjsKPiAtwqDCoMKgwqDCoMKgwqB9Cj4gLQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXR6LT5vcHMu
c2hvdWxkX2JpbmQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4g
wqAKPiBAQCAtMTM0NiwxNSArMTI4Nyw2IEBAIHN0YXRpYyB2b2lkIHRoZXJtYWxfem9uZV9jZGV2
X3VuYmluZGluZygKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHRoZXJtYWxfdHJpcF9k
ZXNjICp0ZDsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoC8qCj4gLcKgwqDCoMKgwqDCoMKgICogT2xk
LXN0eWxlIHVuYmluZGluZy7CoCBUaGUgLnVuYmluZCBjYWxsYmFjayBpcyBleHBlY3RlZCB0bwo+
IGNhbGwKPiAtwqDCoMKgwqDCoMKgwqAgKiB0aGVybWFsX3VuYmluZF9jZGV2X2Zyb21fdHJpcCgp
IHVuZGVyIHRoZSB0aGVybWFsIHpvbmUKPiBsb2NrLgo+IC3CoMKgwqDCoMKgwqDCoCAqLwo+IC3C
oMKgwqDCoMKgwqDCoGlmICh0ei0+b3BzLnVuYmluZCkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB0ei0+b3BzLnVuYmluZCh0eiwgY2Rldik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybjsKPiAtwqDCoMKgwqDCoMKgwqB9Cj4gLQo+IMKgwqDCoMKgwqDC
oMKgwqBtdXRleF9sb2NrKCZ0ei0+bG9jayk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgZm9yX2Vh
Y2hfdHJpcF9kZXNjKHR6LCB0ZCkKPiBAQCAtMTQ4OCw4ICsxNDIwLDcgQEAgdGhlcm1hbF96b25l
X2RldmljZV9yZWdpc3Rlcl93aXRoX3RyaXBzKAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+
IC3CoMKgwqDCoMKgwqDCoGlmICghb3BzIHx8ICFvcHMtPmdldF90ZW1wIHx8IChvcHMtPnNob3Vs
ZF9iaW5kICYmIG9wcy0+YmluZCkKPiB8fAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCAob3BzLT5z
aG91bGRfYmluZCAmJiBvcHMtPnVuYmluZCkpIHsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIW9wcyB8
fCAhb3BzLT5nZXRfdGVtcCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJf
ZXJyKCJUaGVybWFsIHpvbmUgZGV2aWNlIG9wcyBub3QgZGVmaW5lZCBvcgo+IGludmFsaWRcbiIp
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIoLUVJTlZB
TCk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiBJbmRleDogbGludXgtcG0vaW5jbHVkZS9saW51eC90
aGVybWFsLmgKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Cj4gLS0tIGxpbnV4LXBtLm9yaWcvaW5jbHVkZS9saW51eC90
aGVybWFsLmgKPiArKysgbGludXgtcG0vaW5jbHVkZS9saW51eC90aGVybWFsLmgKPiBAQCAtOTIs
MTAgKzkyLDYgQEAgc3RydWN0IGNvb2xpbmdfc3BlYyB7Cj4gwqB9Owo+IMKgCj4gwqBzdHJ1Y3Qg
dGhlcm1hbF96b25lX2RldmljZV9vcHMgewo+IC3CoMKgwqDCoMKgwqDCoGludCAoKmJpbmQpIChz
dHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqKTsKPiAtwqDCoMKg
wqDCoMKgwqBpbnQgKCp1bmJpbmQpIChzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHRoZXJtYWxf
Y29vbGluZ19kZXZpY2UgKik7Cj4gwqDCoMKgwqDCoMKgwqDCoGJvb2wgKCpzaG91bGRfYmluZCkg
KHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICosCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHRoZXJtYWxfdHJp
cCAqLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICosCj4gQEAgLTI0NywxMiArMjQz
LDYgQEAgY29uc3QgY2hhciAqdGhlcm1hbF96b25lX2RldmljZV90eXBlKHN0cgo+IMKgaW50IHRo
ZXJtYWxfem9uZV9kZXZpY2VfaWQoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6ZCk7Cj4g
wqBzdHJ1Y3QgZGV2aWNlICp0aGVybWFsX3pvbmVfZGV2aWNlKHN0cnVjdCB0aGVybWFsX3pvbmVf
ZGV2aWNlICp0emQpOwo+IMKgCj4gLWludCB0aGVybWFsX3pvbmVfYmluZF9jb29saW5nX2Rldmlj
ZShzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqLAo+IGludCwKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IGxvbmcsIHVuc2lnbmVkIGxvbmcsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50KTsKPiAt
aW50IHRoZXJtYWxfem9uZV91bmJpbmRfY29vbGluZ19kZXZpY2Uoc3RydWN0IHRoZXJtYWxfem9u
ZV9kZXZpY2UgKiwKPiBpbnQsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0aGVybWFsX2Nv
b2xpbmdfZGV2aWNlCj4gKik7Cj4gwqB2b2lkIHRoZXJtYWxfem9uZV9kZXZpY2VfdXBkYXRlKHN0
cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICosCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVudW0gdGhlcm1hbF9ub3RpZnlf
ZXZlbnQpOwo+IMKgCj4gSW5kZXg6IGxpbnV4LXBtL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS90
aGVybWFsL3N5c2ZzLWFwaS5yc3QKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gLS0tIGxpbnV4LXBtLm9yaWcvRG9j
dW1lbnRhdGlvbi9kcml2ZXItYXBpL3RoZXJtYWwvc3lzZnMtYXBpLnJzdAo+ICsrKyBsaW51eC1w
bS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdGhlcm1hbC9zeXNmcy1hcGkucnN0Cj4gQEAgLTU4
LDEwICs1OCw5IEBAIHRlbXBlcmF0dXJlKSBhbmQgdGhyb3R0bGUgYXBwcm9wcmlhdGUgZGUKPiDC
oMKgwqDCoCBvcHM6Cj4gwqDCoMKgwqDCoMKgwqDCoHRoZXJtYWwgem9uZSBkZXZpY2UgY2FsbC1i
YWNrcy4KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoC5iaW5kOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBiaW5kIHRoZSB0aGVybWFsIHpvbmUgZGV2aWNlIHdpdGggYSB0aGVybWFsIGNv
b2xpbmcKPiBkZXZpY2UuCj4gLcKgwqDCoMKgwqDCoMKgLnVuYmluZDoKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdW5iaW5kIHRoZSB0aGVybWFsIHpvbmUgZGV2aWNlIHdpdGggYSB0
aGVybWFsIGNvb2xpbmcKPiBkZXZpY2UuCj4gK8KgwqDCoMKgwqDCoMKgLnNob3VsZF9iaW5kOgo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjaGVjayB3aGV0aGVyIG9yIG5vdCBhIGdp
dmVuIGNvb2xpbmcgZGV2aWNlIHNob3VsZCBiZQo+IGJvdW5kIHRvCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGEgZ2l2ZW4gdHJpcCBwb2ludCBpbiB0aGlzIHRoZXJtYWwgem9uZS4K
PiDCoMKgwqDCoMKgwqDCoMKgLmdldF90ZW1wOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ2V0IHRoZSBjdXJyZW50IHRlbXBlcmF0dXJlIG9mIHRoZSB0aGVybWFsIHpvbmUuCj4g
wqDCoMKgwqDCoMKgwqDCoC5zZXRfdHJpcHM6Cj4gQEAgLTI0Niw1NiArMjQ1LDYgQEAgdGVtcGVy
YXR1cmUpIGFuZCB0aHJvdHRsZSBhcHByb3ByaWF0ZSBkZQo+IMKgwqDCoMKgIEl0IGRlbGV0ZXMg
dGhlIGNvcnJlc3BvbmRpbmcgZW50cnkgZnJvbSAvc3lzL2NsYXNzL3RoZXJtYWwKPiBmb2xkZXIg
YW5kCj4gwqDCoMKgwqAgdW5iaW5kcyBpdHNlbGYgZnJvbSBhbGwgdGhlIHRoZXJtYWwgem9uZSBk
ZXZpY2VzIHVzaW5nIGl0Lgo+IMKgCj4gLTEuMyBpbnRlcmZhY2UgZm9yIGJpbmRpbmcgYSB0aGVy
bWFsIHpvbmUgZGV2aWNlIHdpdGggYSB0aGVybWFsCj4gY29vbGluZyBkZXZpY2UKPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiAtLS0tLS0tLS0KPiAtCj4gLcKgwqDCoCA6Ogo+IC0KPiAtwqDCoMKgwqDCoMKgwqBp
bnQgdGhlcm1hbF96b25lX2JpbmRfY29vbGluZ19kZXZpY2Uoc3RydWN0Cj4gdGhlcm1hbF96b25l
X2RldmljZSAqdHosCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCB0cmlwLCBz
dHJ1Y3QgdGhlcm1hbF9jb29saW5nX2RldmljZSAqY2RldiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyB1cHBlciwgdW5zaWduZWQgbG9uZyBsb3dlciwgdW5z
aWduZWQKPiBpbnQgd2VpZ2h0KTsKPiAtCj4gLcKgwqDCoCBUaGlzIGludGVyZmFjZSBmdW5jdGlv
biBiaW5kcyBhIHRoZXJtYWwgY29vbGluZyBkZXZpY2UgdG8gYQo+IHBhcnRpY3VsYXIgdHJpcAo+
IC3CoMKgwqAgcG9pbnQgb2YgYSB0aGVybWFsIHpvbmUgZGV2aWNlLgo+IC0KPiAtwqDCoMKgIFRo
aXMgZnVuY3Rpb24gaXMgdXN1YWxseSBjYWxsZWQgaW4gdGhlIHRoZXJtYWwgem9uZSBkZXZpY2Ug
LmJpbmQKPiBjYWxsYmFjay4KPiAtCj4gLcKgwqDCoCB0ejoKPiAtwqDCoMKgwqDCoMKgwqDCoCB0
aGUgdGhlcm1hbCB6b25lIGRldmljZQo+IC3CoMKgwqAgY2RldjoKPiAtwqDCoMKgwqDCoMKgwqDC
oCB0aGVybWFsIGNvb2xpbmcgZGV2aWNlCj4gLcKgwqDCoCB0cmlwOgo+IC3CoMKgwqDCoMKgwqDC
oMKgIGluZGljYXRlcyB3aGljaCB0cmlwIHBvaW50IGluIHRoaXMgdGhlcm1hbCB6b25lIHRoZSBj
b29saW5nCj4gZGV2aWNlCj4gLcKgwqDCoMKgwqDCoMKgwqAgaXMgYXNzb2NpYXRlZCB3aXRoLgo+
IC3CoMKgwqAgdXBwZXI6Cj4gLcKgwqDCoMKgwqDCoMKgwqAgdGhlIE1heGltdW0gY29vbGluZyBz
dGF0ZSBmb3IgdGhpcyB0cmlwIHBvaW50Lgo+IC3CoMKgwqDCoMKgwqDCoMKgIFRIRVJNQUxfTk9f
TElNSVQgbWVhbnMgbm8gdXBwZXIgbGltaXQsCj4gLcKgwqDCoMKgwqDCoMKgwqAgYW5kIHRoZSBj
b29saW5nIGRldmljZSBjYW4gYmUgaW4gbWF4X3N0YXRlLgo+IC3CoMKgwqAgbG93ZXI6Cj4gLcKg
wqDCoMKgwqDCoMKgwqAgdGhlIE1pbmltdW0gY29vbGluZyBzdGF0ZSBjYW4gYmUgdXNlZCBmb3Ig
dGhpcyB0cmlwIHBvaW50Lgo+IC3CoMKgwqDCoMKgwqDCoMKgIFRIRVJNQUxfTk9fTElNSVQgbWVh
bnMgbm8gbG93ZXIgbGltaXQsCj4gLcKgwqDCoMKgwqDCoMKgwqAgYW5kIHRoZSBjb29saW5nIGRl
dmljZSBjYW4gYmUgaW4gY29vbGluZyBzdGF0ZSAwLgo+IC3CoMKgwqAgd2VpZ2h0Ogo+IC3CoMKg
wqDCoMKgwqDCoMKgIHRoZSBpbmZsdWVuY2Ugb2YgdGhpcyBjb29saW5nIGRldmljZSBpbiB0aGlz
IHRoZXJtYWwKPiAtwqDCoMKgwqDCoMKgwqDCoCB6b25lLsKgIFNlZSAxLjQuMSBiZWxvdyBmb3Ig
bW9yZSBpbmZvcm1hdGlvbi4KPiAtCj4gLcKgwqDCoCA6Ogo+IC0KPiAtwqDCoMKgwqDCoMKgwqBp
bnQgdGhlcm1hbF96b25lX3VuYmluZF9jb29saW5nX2RldmljZShzdHJ1Y3QKPiB0aGVybWFsX3pv
bmVfZGV2aWNlICp0eiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQgdHJpcCwgc3RydWN0Cj4gdGhlcm1hbF9jb29saW5n
X2RldmljZSAqY2Rldik7Cj4gLQo+IC3CoMKgwqAgVGhpcyBpbnRlcmZhY2UgZnVuY3Rpb24gdW5i
aW5kcyBhIHRoZXJtYWwgY29vbGluZyBkZXZpY2UgZnJvbSBhCj4gcGFydGljdWxhcgo+IC3CoMKg
wqAgdHJpcCBwb2ludCBvZiBhIHRoZXJtYWwgem9uZSBkZXZpY2UuIFRoaXMgZnVuY3Rpb24gaXMg
dXN1YWxseQo+IGNhbGxlZCBpbgo+IC3CoMKgwqAgdGhlIHRoZXJtYWwgem9uZSBkZXZpY2UgLnVu
YmluZCBjYWxsYmFjay4KPiAtCj4gLcKgwqDCoCB0ejoKPiAtwqDCoMKgwqDCoMKgwqB0aGUgdGhl
cm1hbCB6b25lIGRldmljZQo+IC3CoMKgwqAgY2RldjoKPiAtwqDCoMKgwqDCoMKgwqB0aGVybWFs
IGNvb2xpbmcgZGV2aWNlCj4gLcKgwqDCoCB0cmlwOgo+IC3CoMKgwqDCoMKgwqDCoGluZGljYXRl
cyB3aGljaCB0cmlwIHBvaW50IGluIHRoaXMgdGhlcm1hbCB6b25lIHRoZSBjb29saW5nCj4gZGV2
aWNlCj4gLcKgwqDCoMKgwqDCoMKgaXMgYXNzb2NpYXRlZCB3aXRoLgo+IC0KPiDCoDEuNCBUaGVy
bWFsIFpvbmUgUGFyYW1ldGVycwo+IMKgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gwqAK
PiBAQCAtMzY2LDggKzMxNSw2IEBAIFRoZXJtYWwgY29vbGluZyBkZXZpY2Ugc3lzIEkvRiwgY3Jl
YXRlZAo+IMKgCj4gwqBUaGVuIG5leHQgdHdvIGR5bmFtaWMgYXR0cmlidXRlcyBhcmUgY3JlYXRl
ZC9yZW1vdmVkIGluIHBhaXJzLiBUaGV5Cj4gcmVwcmVzZW50Cj4gwqB0aGUgcmVsYXRpb25zaGlw
IGJldHdlZW4gYSB0aGVybWFsIHpvbmUgYW5kIGl0cyBhc3NvY2lhdGVkIGNvb2xpbmcKPiBkZXZp
Y2UuCj4gLVRoZXkgYXJlIGNyZWF0ZWQvcmVtb3ZlZCBmb3IgZWFjaCBzdWNjZXNzZnVsIGV4ZWN1
dGlvbiBvZgo+IC10aGVybWFsX3pvbmVfYmluZF9jb29saW5nX2RldmljZS90aGVybWFsX3pvbmVf
dW5iaW5kX2Nvb2xpbmdfZGV2aWNlLgo+IMKgCj4gwqA6Ogo+IMKgCj4gCj4gCj4gCgo=

