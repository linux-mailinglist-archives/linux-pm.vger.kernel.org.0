Return-Path: <linux-pm+bounces-11297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C561E93902B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 15:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5276A1F21C92
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136BC16D9BA;
	Mon, 22 Jul 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLNK/YIr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F916938C;
	Mon, 22 Jul 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656352; cv=fail; b=do9HcZuB3sGA/aRQGJKZqUlfsucXZDVqhKVesGWY9JciIXDfw7O8TCwqHD1V4Th64K/fZHiW8pJ7hwO8YCEuj+xguoJ/sRu2KaabV/JntmtbzGUr+8y0zlSDpYucdGqGfRyhU83R25NdLRYyUpbQyK3A9UOCKAt0lBcgbQgCeeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656352; c=relaxed/simple;
	bh=Y5nkewMTarWzRAT20mJKtZOHCdFigJRTihp5iejW4lE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8HhJhc7my8g6PPbGDKAfH4pWE1lbsMPcm3MqcJ8h54WUbMWn3nWa+B6ClAosUrsUrofO+YkC/q2kG2IAO+PtVbiIQTT31NSGbsDviGYC6g+WaPJOHCBWOqjWs8TrmGzQmksMBT9jditWxpvLX2BhDcnUtgJTpO85jbheeX1IWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLNK/YIr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721656349; x=1753192349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y5nkewMTarWzRAT20mJKtZOHCdFigJRTihp5iejW4lE=;
  b=mLNK/YIrsYCod+7zjloXkomSNVBTHf39Yt9YalR76/HXl71/XLNc7yMD
   qIADfIRynC10NUgXIHBrH28JdrvU/X1u+4HvhegNW6bXs6LTJUXD+bky9
   Y+dFpNJbGyA4iwDsRTqr2x6xcmBHV1qn4PkookJIyIE9ueH7sw5b6B/KO
   ooVGgeFQp4/QBQgKfUN1UBimpXQ9Fcfbc7EIaE8bn5P8p3i4AG62/ATsS
   WkkNDq2ibyqS/MQA0g9V5I0yRNV0mvlBjSaTb84Io050S24pJnP0BMtwk
   8t5l6xjHM7ARCVVxN9iK4sUDMtsz6QHLVsY8A39Ln+TDqaZwy0FC/ty8y
   Q==;
X-CSE-ConnectionGUID: s0V8BnXYSZGtBbxyLngbvQ==
X-CSE-MsgGUID: VxAva7WWSr+Oc+MP8y2YPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="23090039"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="23090039"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 06:52:29 -0700
X-CSE-ConnectionGUID: ww3xDNL7RQ6wYDzBUz81FA==
X-CSE-MsgGUID: J3wtPbJsR4qoTPT+fJPUgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="51791329"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 06:52:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 06:52:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 06:52:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 06:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiAtpjjeOSyWAcHqX4T51j5glL4ivOmfyWQufTz3XOWtM0CntoTafiZW+DIv8Q7a47bSds9LIf1BfkHrlKZ2C2L/VMGHTJTioWHO0Ihzt+FFkGKkyKPinCvvT/2JawjHcFmJfWYq7Bi5pwXcxtfGJJw6luMmpTUEttmfFxpIWZ/Raq+jabvc2dJazHnwhiQKZEmfExnHtKIkzo8owAfkyK7kwgORHgIu7kU7vaib7tF6snvX+iyWKcVCo3QNCO0QzOJB6e93MSewytwde80Blah2vAoAuatVraXfkxDgQ4qVC7zASwlz3PN8JIMqBQ3Haxxu3zrl6ZjS7l5ls2ppeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5nkewMTarWzRAT20mJKtZOHCdFigJRTihp5iejW4lE=;
 b=Sd70lyOwoyHsUUzUZZ+y6g2CZ/0LTF4Ylo92YBlOqClaFX81aw/xeJIDDHGm+ODtL7N+aaX+ge+f3+wOeYp0LnBdcmqHmHZGP/t3LfFtSWQuIbd6rqo97U+4m734vbkYVe5QkfUOsksV4k8RkqDRW5kZzuP/Hv202i2DJAXg9iVTgA/ly1sYcQH87m1bOtCFCeKCrzw+xjvUkxRjut1NInaaRK1NSckPW/TXDeQTYlCNjwD/DLy1v6whWw+KouGS9eWX4rXpRnUx5tWzFfPJq8HpsPJ4OTIyLJSb91qHtPpdaPxhQUPBQ6rsXdDuV6Qpy9Pyyz1ngpDr8b8mCGbpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 13:52:26 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 13:52:26 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "irogers@google.com" <irogers@google.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "acme@kernel.org" <acme@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Larabel,
 Michael" <michael@michaellarabel.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "ananth.narayan@amd.com" <ananth.narayan@amd.com>
Subject: Re: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for AMD
 CPUs
Thread-Topic: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for
 AMD CPUs
Thread-Index: AQHa2cOQ281/U8pyC0SnDudrUQMJSLIBPfeAgAEvpwCAAFucgA==
Date: Mon, 22 Jul 2024 13:52:25 +0000
Message-ID: <77ea13bb319d6408ff262b10ed744c2e80c5fe24.camel@intel.com>
References: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
	 <20240719092545.50441-3-Dhananjay.Ugwekar@amd.com>
	 <2a81f438306b82620bb4db9065d2cbf3e4c2d56c.camel@intel.com>
	 <9c492669-d97b-4040-bdcf-e7f5a5ac7e09@amd.com>
In-Reply-To: <9c492669-d97b-4040-bdcf-e7f5a5ac7e09@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CYYPR11MB8432:EE_
x-ms-office365-filtering-correlation-id: 45b9fa2f-826d-4f8b-50a4-08dcaa5584fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?M2tnVTFsM295Mys2NHo1WG5tWXA5VVpFdVcyUHd2R3dhT0ZOWmtkZGt0L2Yz?=
 =?utf-8?B?UWxsaG5WajF5d0hqVkdaSHA1WlZkWnBCYnNSaWpjd3BLc3RuNldsM3BGYTho?=
 =?utf-8?B?ZGZ6UHp1TkVkb0I4TXh6TEVGS2h0T3Z4clF5eFNJZ2oxaEJORE1MME0vOERM?=
 =?utf-8?B?QmlqSjFmd2ZCT2o3WFF5MG1uVDFydUdIRnhsMGlheW5mOS9nYVJNaXVwbm5v?=
 =?utf-8?B?THhtNExQWjM1RSsxcnU3eUFLTU5DalZvM2hDNHhtZnpId2UxWndjNVpMdHNS?=
 =?utf-8?B?VDdPMnE5dTEreHI0N2NrWmZ6T0NKSzNPZ0FkU1NOSk95TG83clg1MUI0a0NF?=
 =?utf-8?B?OHdkWEVMd29veFNwaVAvaUk4SmNmQTcxQWF5THArYUNyRHd4ZG52YnA3ZUli?=
 =?utf-8?B?UG16YlhIL05lakpHQ2E0cHNnMlVoVE0wOFAwRXVndzQ3NmFjOHZERHRqdVV1?=
 =?utf-8?B?QWFmMllEVTRkNGpmaHBLRjVQdVhZZDdhK1VPRnhNRy9TU0h1VWFiUWp0aXZU?=
 =?utf-8?B?M1lXRDBNNzE5c011Q1dZc1VNbk0wazZvWC9jMlF6MDFXc0FIdkI5dmwrK1RZ?=
 =?utf-8?B?Sm1sQ1lIVUw0emtBWDVzR0tVNEN2dW9TRnlvWHIzSWhYeE5ObEtPQXpaZEdu?=
 =?utf-8?B?MFcxa2RaL3NWU0djd0QvUzRUcVRjN05FRUFiOStFdWljL2xHVU9RVE1pdFJu?=
 =?utf-8?B?VEZwV3BMRFBMelJKWlltQ0pFNCttdUNDcUQvN2dsTThDa21WUGRYS0V2YWQz?=
 =?utf-8?B?V3ZUcHViS1FKTXBvN2ZCOGhRMjJ1a2Z4MTJRV0ZySkN5WS9TNFh1WFpaOXFV?=
 =?utf-8?B?blFVY1dvZ3dZcW5iMUQrV1FFYmJZUUhiWklRRTRaS1doTjFBWnlUWHRHWmU2?=
 =?utf-8?B?eGhwdUl0SnFQSGhmYVhmQjJzemVBUnJiOGtoK0M3Smk2Qnl4aVJUeS9MOUxr?=
 =?utf-8?B?YjlpdTdjZytGTDE5SVgxSVVsSEZNbXIxQXgvWkk4RFdTckNxYW5QQXM4Rk15?=
 =?utf-8?B?Z0RvcktyMUwzdkw5a05aZCs2ejhhcWdQNjVmSnNjdXFSRGlTWjRuZmJJNFBj?=
 =?utf-8?B?QlJ0MmNmUnZwNW92NjV0cmRmRFYxRGowL0hhOUFOWGVBcGhsMjMxbHFmU01t?=
 =?utf-8?B?bk1xblIvODlXdHNuN2RqMi9RYVdidExBbGh6ZTBXNEtYL2ZwcTRCdElPSklx?=
 =?utf-8?B?clFyOWZsQ1F4UEc4Wll5cXNqWXVmaHdWUGFvUDZNUlcrTnVZNXBMZyt4WmVH?=
 =?utf-8?B?dWRMbWsyK1EyQUZPSHNxTEtPWlpMcGd1WVdraG5yTFBDV0tzUVdNeDlRdTV4?=
 =?utf-8?B?OHZvcWxaNUZiUUFIWlVqM0FYMmNoWUtMQlBWQVdWZlc3YzRad1ozdVpzSm5l?=
 =?utf-8?B?c1ZlU0xidG9wQkhSNXNzZm5RdzhiclRRZnJKSGJCU05aVGpSZ21JOThsYUEr?=
 =?utf-8?B?WDRtblR3Q2RoSGFqeld0WkQ4a0EwWTN2VHhGNU1qRHk4dHZQMzYxRDVTRGxK?=
 =?utf-8?B?K3BQSXlsbE9VVTg3U0JBa3dDNWxGaHBaRTNBcmhLak1MaU5Ra1UwSzRaUXNP?=
 =?utf-8?B?NGtISllCeHFPZjNwelVHMW1OVlhLQnRqNVpRQTB6Ukx0RkxTVkM3VndEbStS?=
 =?utf-8?B?WmtVeEhPWk5meDNXREI5alJxY0s5ZEpMOS9SUHhSK2F4bHFTUUVpSldQM0Fz?=
 =?utf-8?B?MlNxQnY5alRqT3JJYlpOZjQrcDEzSHdoTkMxMEZMWlBjTWJVdFUyRFg0dUls?=
 =?utf-8?B?eUNRVmlCWVRaV0JBbGNyRWZEUUUrZ1MrSlQwSVpQckxQQzF0QkpOOFNlVTRs?=
 =?utf-8?B?Qm9ncHBuSDgzWDVhZUtyN2VGanM4UlpMRGhKUURJVEdQVFYzVldEZElJWTU1?=
 =?utf-8?B?MFEvTE9vQmpvOTdEYktaeGdRYkxhVFFmblZUanY2WFFUSTJ0VDBBT294VlhN?=
 =?utf-8?Q?zwJgCdeWwWk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZERDdzBtYWlSTk1tMjBRaVNJRm9NeHYzM1ZLNDVPTkVadnJrblVWOWNsdkJ3?=
 =?utf-8?B?Kyt3dXVSbHA2QzdWRkxYN3JPWGNkdWt1TzhDQmVKL3FWZjBhOGE2eVVvWHox?=
 =?utf-8?B?TDh0MWt4Ykw5WDhEaE4xc0U2UVAyZ1lzTEx2Wm9jMGozYllzWmVtTHEzK0o1?=
 =?utf-8?B?eWlESnkxK0tBalBOVEZPV0gwWDBhazVRQVBlN0tRdG9OZ2I2MTJZYjJDakhn?=
 =?utf-8?B?WTA3K0xuTTV2aER1Wkx0aXp5UkZBOXN6eFVqak4zYThkaDNDZExrL0ZJOGJN?=
 =?utf-8?B?bVQxOTdpZERJNUdjNGFWaUNuUytQejRCdmpCR1k2OGJCeklRS2loZzg1QVlK?=
 =?utf-8?B?S3pnQS9sUFVDSVA3WS96Y2tNZVhSa3puNE5SVnhRelk2WmpZaUtNMXBhcTFE?=
 =?utf-8?B?OTBPT1BoeUxtdC9kSGVOSEJwOFBlM0tFVFBxM0Nsc1NlblF5TlRIWEZ0bHI4?=
 =?utf-8?B?ZklObVpsWURhQW50cXRHVi9jdmdoN2d4U01zWDV4b2NnRzI5ZWZNc2hMU1py?=
 =?utf-8?B?RzZHby8zalp2Z0lOdi9EM1ZwMjlHd1JHKzcydVNuRUdsdTB4RWdxMmYvTnh4?=
 =?utf-8?B?NkFXMytxSjlOSFkrUm9hL24wOGh2SVBSbzlucVBTeHNuVU15aWNOb1A1L2Qz?=
 =?utf-8?B?S3RUNXlEVTVnWjdaNTFaQ01iWTArYUFVaWNqSzV5c3B6bElzQ1hTOFJUdXF3?=
 =?utf-8?B?cy9IM21zS05nVEl4R0dXKzUyYTBIUCtwamM1MlZtNE1CbWxwVVhTZ1JZdGFx?=
 =?utf-8?B?V1hZVFhjRGsvczFXQ2xDOGFDdjIxWHpyZ3JYdjR1OXA0ZTdxc0JJQ1BPNVo0?=
 =?utf-8?B?MWRtcjBZTHlvcDc1Q29NV0N1TTNsZHR3cXRPL0tmaFUvdTIxdGVBZHNYZ1Vq?=
 =?utf-8?B?UnBocGRWQ0hEQTZBQld0NSs2TnBWS29pV0pkM3IzQVQzZEJPbHFJalBjRXhL?=
 =?utf-8?B?R1p5T3NzVjJmZi9aRUNReVhsTy9uUFdNdy9OcjVKalcxNFJSY0RGZ1d3SGh1?=
 =?utf-8?B?OHhQV3ZUY2IzY0JpTS9mMG9PdlcwY0FtQUNjR21SNk5GTkVVeUJQWmowQmZM?=
 =?utf-8?B?Y3M3anZnVldBbGJ1aFhPVjhwMHMzd05rN3hOQUYwZHI5M21Qai9Nd3pKbUdt?=
 =?utf-8?B?VHJ2TDF6ZXVFVG5obWV1c24yRHdrOU4zK2ZVK1dtOStTbUZUcjduc3VzdVpQ?=
 =?utf-8?B?ZElJTVFsNHRPRTZJQWhoaHJBY0pHMGZ2NHJwcEdjU3V0b01xUmZhRFpYMkNn?=
 =?utf-8?B?czZNdWVWU1RtcEdITmkvYnhSNGNobk9SSCtRR2hXeTRvZXR5UG5XY09PbG5n?=
 =?utf-8?B?OHFJbVgzRjhreUNpTGZkTnVRRDV2ZkswOUwzVDdMclUwa0FlSldVejZiYmF2?=
 =?utf-8?B?bGhwM0JmbzhETCt5OG4xYVREZ2lKOVZFbC8wOVUxK2JzK0J5bHVnNjYzSXVu?=
 =?utf-8?B?dEZFTGNyeWVHQXZ1R0pkcS9vak8zK3pTeTI0N2svc3BxYWRZZTljTHBUdHd1?=
 =?utf-8?B?VWhHNWhuZWhSL1N1Z2JiOHJ6OTAxZ0ZPN3BzYnIzYlBPanQ1enl5d3lxbWQ4?=
 =?utf-8?B?SXNHWm9uWlQ4cmFkV1NIbXp1Mkl6ZHZiQStUYmFaY2hQUlpwZXAvZDJNaG5m?=
 =?utf-8?B?SnJwdHhKd2ovMnFzL0tJSTkwQndWRUtyR1ZoTjhhdEN4VTF3TVVSZzZrUjdZ?=
 =?utf-8?B?UDQxVDV1VHArNTdvNnp3cFltM1drN3hLak5oTTVabXFrTjJYRUZSYktJSmp4?=
 =?utf-8?B?ZktDT3FHbGd0NnM5YkRBYW50ajExNFBUMjhEcXNsWmRsYjF3M1ZSRHc5ZTU2?=
 =?utf-8?B?TEU5b21BaHF6SGt5b2tBK09nN3FDanVkZmNVZThvUVZIT0Y1YXM3MUZiNGRX?=
 =?utf-8?B?WkJFbXd0NmtiL0NHeXk0L3NGdlZhUHAza0lQYU5YUUpUVkM2L0xWdkVTMmlu?=
 =?utf-8?B?c0I4eXpabUVFNUxlY24xWmRNODRwMDh6WUZySjhjbjlCVjRtVG1jWkp6N1NG?=
 =?utf-8?B?cTR2SGsrQ0dudEF4eGswemU0V2MvVkFKNHlxZmt4R2ExbUJ1K001K3JMa3RF?=
 =?utf-8?B?YkZLRGVHaXJPWHhyMGh0NWh0ZS94RkRhSkw0SnhGcGhVZVpYWG8vd21md25a?=
 =?utf-8?B?RVlSQzZweVVjUGFIb3BNTm9Bb0h3ellJYjRMNTdXNi9mQ3hWR2dSQldhUGds?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A627F305B146984C9DC5D1CCB65DD577@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b9fa2f-826d-4f8b-50a4-08dcaa5584fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 13:52:25.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIqLNcjTyOzBrFTcFYL0fx/iDK9lna5pKlapMd1lLdILZCw5rvDPvuNuYpHQoP42lWpMg9nuRg+LaYJMzBVHCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8432
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA3LTIyIGF0IDEzOjU0ICswNTMwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gSGkgUnVpLA0KPiANCj4gT24gNy8yMS8yMDI0IDc6NDcgUE0sIFpoYW5nLCBSdWkgd3Jv
dGU6DQo+ID4gT24gRnJpLCAyMDI0LTA3LTE5IGF0IDA5OjI1ICswMDAwLCBEaGFuYW5qYXkgVWd3
ZWthciB3cm90ZToNCj4gPiA+IEFmdGVyIGNvbW1pdCAoIng4Ni9jcHUvdG9wb2xvZ3k6IEFkZCBz
dXBwb3J0IGZvciB0aGUgQU1EDQo+ID4gPiAweDgwMDAwMDI2DQo+ID4gPiBsZWFmIiksDQo+ID4g
PiBvbiBBTUQgcHJvY2Vzc29ycyB0aGF0IHN1cHBvcnQgZXh0ZW5kZWQgQ1BVSUQgbGVhZiAweDgw
MDAwMDI2LA0KPiA+ID4gdGhlDQo+ID4gPiB0b3BvbG9neV9sb2dpY2FsX2RpZV9pZCgpIG1hY3Jv
cywgbm8gbG9uZ2VyIHJldHVybnMgcGFja2FnZSBpZCwNCj4gPiA+IGluc3RlYWQgaXQNCj4gPiA+
IHJldHVybnMgdGhlIENDRCAoQ29yZSBDb21wbGV4IERpZSkgaWQuIFRoaXMgbGVhZHMgdG8gdGhl
IGVuZXJneS0NCj4gPiA+IHBrZw0KPiA+ID4gZXZlbnQgc2NvcGUgdG8gYmUgbW9kaWZpZWQgdG8g
Q0NEIGluc3RlYWQgb2YgcGFja2FnZS4NCj4gPiA+IA0KPiA+ID4gRm9yIG1vcmUgaGlzdG9yaWNh
bCBjb250ZXh0LCBwbGVhc2UgcmVmZXIgdG8gY29tbWl0IDMyZmI0ODBlMGEyYw0KPiA+ID4gKCJw
b3dlcmNhcC9pbnRlbF9yYXBsOiBTdXBwb3J0IG11bHRpLWRpZS9wYWNrYWdlIiksIHdoaWNoDQo+
ID4gPiBpbml0aWFsbHkNCj4gPiA+IGNoYW5nZWQNCj4gPiA+IHRoZSBSQVBMIHNjb3BlIGZyb20g
cGFja2FnZSB0byBkaWUgZm9yIGFsbCBzeXN0ZW1zLCBhcyBJbnRlbA0KPiA+ID4gc3lzdGVtcw0K
PiA+ID4gd2l0aCBEaWUgZW51bWVyYXRpb24gaGF2ZSBSQVBMIHNjb3BlIGFzIGRpZSwgYW5kIHRo
b3NlIHdpdGhvdXQNCj4gPiA+IGRpZQ0KPiA+ID4gZW51bWVyYXRpb24gYXJlIG5vdCBhZmZlY3Rl
ZC4gU28sIGFsbCBzeXN0ZW1zKEludGVsLCBBTUQsIEh5Z29uKSwNCj4gPiA+IHdvcmtlZA0KPiA+
ID4gY29ycmVjdGx5IHdpdGggdG9wb2xvZ3lfbG9naWNhbF9kaWVfaWQoKSB1bnRpbCByZWNlbnRs
eSwgYnV0IHRoaXMNCj4gPiA+IGNoYW5nZWQNCj4gPiA+IGFmdGVyIHRoZSAiMHg4MDAwMDAyNiBs
ZWFmIiBjb21taXQgbWVudGlvbmVkIGFib3ZlLg0KPiA+ID4gDQo+ID4gPiBSZXBsYWNpbmcgdG9w
b2xvZ3lfbG9naWNhbF9kaWVfaWQoKSB3aXRoDQo+ID4gPiB0b3BvbG9neV9waHlzaWNhbF9wYWNr
YWdlX2lkKCkNCj4gPiA+IGNvbmRpdGlvbmFsbHkgb25seSBmb3IgQU1EIGFuZCBIeWdvbiBmaXhl
cyB0aGUgZW5lcmd5LXBrZyBldmVudC4NCj4gPiA+IA0KPiA+ID4gT24gYW4gQU1EIDIgc29ja2V0
IDggQ0NEIFplbjUgc2VydmVyOg0KPiA+ID4gDQo+ID4gPiBCZWZvcmU6DQo+ID4gPiANCj4gPiA+
IGxpbnV4JCBscyAvc3lzL2NsYXNzL3Bvd2VyY2FwLw0KPiA+ID4gaW50ZWwtcmFwbMKgwqDCoMKg
wqAgaW50ZWwtcmFwbDoxOjDCoCBpbnRlbC1yYXBsOjM6MMKgIGludGVsLXJhcGw6NTowDQo+ID4g
PiBpbnRlbC1yYXBsOjc6MMKgIGludGVsLXJhcGw6OTowwqAgaW50ZWwtcmFwbDpiOjDCoCBpbnRl
bC1yYXBsOmQ6MA0KPiA+ID4gaW50ZWwtcmFwbDpmOjDCoCBpbnRlbC1yYXBsOjDCoMKgwqAgaW50
ZWwtcmFwbDoywqDCoMKgIGludGVsLXJhcGw6NA0KPiA+ID4gaW50ZWwtcmFwbDo2wqDCoMKgIGlu
dGVsLXJhcGw6OMKgwqDCoCBpbnRlbC1yYXBsOmHCoMKgwqAgaW50ZWwtcmFwbDpjDQo+ID4gPiBp
bnRlbC1yYXBsOmXCoMKgwqAgaW50ZWwtcmFwbDowOjDCoCBpbnRlbC1yYXBsOjI6MMKgIGludGVs
LXJhcGw6NDowDQo+ID4gPiBpbnRlbC1yYXBsOjY6MMKgIGludGVsLXJhcGw6ODowwqAgaW50ZWwt
cmFwbDphOjDCoCBpbnRlbC1yYXBsOmM6MA0KPiA+ID4gaW50ZWwtcmFwbDplOjDCoCBpbnRlbC1y
YXBsOjHCoMKgwqAgaW50ZWwtcmFwbDozwqDCoMKgIGludGVsLXJhcGw6NQ0KPiA+ID4gaW50ZWwt
cmFwbDo3wqDCoMKgIGludGVsLXJhcGw6OcKgwqDCoCBpbnRlbC1yYXBsOmLCoMKgwqAgaW50ZWwt
cmFwbDpkDQo+ID4gPiBpbnRlbC1yYXBsOmYNCj4gPiA+IA0KPiA+ID4gQWZ0ZXI6DQo+ID4gPiAN
Cj4gPiA+IGxpbnV4JCBscyAvc3lzL2NsYXNzL3Bvd2VyY2FwLw0KPiA+ID4gaW50ZWwtcmFwbMKg
IGludGVsLXJhcGw6MMKgIGludGVsLXJhcGw6MDowwqAgaW50ZWwtcmFwbDoxwqAgaW50ZWwtDQo+
ID4gPiByYXBsOjE6MA0KPiA+ID4gDQo+ID4gPiBPbmx5IG9uZSBzeXNmcyBlbnRyeSBwZXItZXZl
bnQgcGVyLXBhY2thZ2UgaXMgY3JlYXRlZCBhZnRlciB0aGlzDQo+ID4gPiBjaGFuZ2UuDQo+ID4g
PiANCj4gPiA+IEZpeGVzOiA2M2VkYmFhNDhhNTcgKCJ4ODYvY3B1L3RvcG9sb2d5OiBBZGQgc3Vw
cG9ydCBmb3IgdGhlIEFNRA0KPiA+ID4gMHg4MDAwMDAyNiBsZWFmIikNCj4gPiA+IFJlcG9ydGVk
LWJ5OiBNaWNoYWVsIExhcmFiZWwgPG1pY2hhZWxAbWljaGFlbGxhcmFiZWwuY29tPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogRGhhbmFuamF5IFVnd2VrYXIgPERoYW5hbmpheS5VZ3dla2FyQGFtZC5j
b20+DQo+ID4gDQo+ID4gRm9yIHRoZSBmdXR1cmUgSW50ZWwgbXVsdGktZGllIHN5c3RlbSB0aGF0
IEkga25vdywgaXQgc3RpbGwgaGFzDQo+ID4gcGFja2FnZS1zY29wZSBSQVBMLCBidXQgdGhpcyBp
cyBkb25lIHdpdGggVFBNSSBSQVBMIGludGVyZmFjZS4NCj4gPiANCj4gPiBUaGUgVFBNSSBSQVBM
IGRyaXZlciBpbnZva2VzIHRoZXNlIEFQSXMgd2l0aCAiaWQgPT0gcGtnX2lkIiBhbmQNCj4gPiAi
aWRfaXNfY3B1ID09IGZhbHNlIiwgc28gbm8gbmVlZCB0byBtYWtlIHJhcGxfcG11X2lzX3BrZ19z
Y29wZSgpDQo+ID4gcmV0dXJucyB0cnVlIGZvciB0aG9zZSBJbnRlbCBzeXN0ZW1zLg0KPiANCj4g
VGhpcyBzZWVtcyBsaWtlIGFuIGltcG9ydGFudCBwb2ludCwgd291bGQgeW91IGJlIG9rYXkgd2l0
aCBpdCwgaWYgSQ0KPiBpbmNsdWRlDQo+IHRoaXMgaW5mbyBpbiB0aGUgY29tbWl0IGxvZyBpbiB2
MiBhbG9uZyB3aXRoIHlvdSByYiB0YWc/DQoNClllcy4NCg0KVGhpcyByZW1pbmRzIG1lIHRoYXQg
d2UgY2FuIHJlcGhyYXNlIHRoZSBjb21tZW50IGZvcg0KcmFwbF9wbXVfaXNfcGtnX3Njb3BlKCkg
YSBiaXQsIHNvbWV0aGluZyBpbmNsdWRpbmcgYmVsb3cgcG9pbnRzLA0KMS4gQU1EL0hZR09OIHBs
YXRmb3JtcyB1c2UgcGVyLVBLRyBQYWNrYWdlIGVuZXJneSBjb3VudGVyDQoyLiBGb3IgSW50ZWwg
cGxhdGZvcm1zDQogICAyLjEgQ0xYLUFQIHBsYXRmb3JtIGhhcyBwZXItRElFIFBhY2thZ2UgZW5l
cmd5IGNvdW50ZXINCiAgIDIuMiBvdGhlciBwbGF0Zm9ybXMgdGhhdCB1c2VzIE1TUiBSQVBMIGFy
ZSBzaW5nbGUgZGllIHN5c3RlbXMgc28gdGhlDQpQYWNrYWdlIGVuZXJneSBjb3VudGVyIGFyZSBw
ZXItUEtHL3Blci1ESUUNCiAgIDIuMyBuZXcgcGxhdGZvcm1zIHRoYXQgdXNlIFRQTUkgUkFQTCBk
b2Vzbid0IGNhcmUgYWJvdXQgdGhlIHNjb3BlDQpiZWNhdXNlIHRoZXkgYXJlIG5vdCBNU1IvQ1BV
IGJhc2VkLg0KDQp3aGF0IGRvIHlvdSB0aGluaz8NCg0KdGhhbmtzLA0KcnVpDQo+IA0KPiBUaGFu
a3MgZm9yIHRoZSByZXZpZXcuDQo+IA0KPiBSZWdhcmRzLA0KPiBEaGFuYW5qYXkNCj4gDQo+ID4g
DQo+ID4gVGhlIHBhdGNoIExHVE0uDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8
cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiANCj4gPiB0aGFua3MsDQo+ID4gcnVpDQo+ID4gPiAt
LS0NCj4gPiA+IMKgZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jIHwgMjAgKysr
KysrKysrKysrKysrKystLS0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bv
d2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiA+IGIvZHJpdmVycy9wb3dlcmNhcC9pbnRl
bF9yYXBsX2NvbW1vbi5jDQo+ID4gPiBpbmRleCAzY2ZmYTZjNzk1MzguLjJmMjRjYTc2NDQwOCAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0K
PiA+ID4gKysrIGIvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gPiBA
QCAtMjEyOCw2ICsyMTI4LDE4IEBAIHZvaWQgcmFwbF9yZW1vdmVfcGFja2FnZShzdHJ1Y3QNCj4g
PiA+IHJhcGxfcGFja2FnZQ0KPiA+ID4gKnJwKQ0KPiA+ID4gwqB9DQo+ID4gPiDCoEVYUE9SVF9T
WU1CT0xfR1BMKHJhcGxfcmVtb3ZlX3BhY2thZ2UpOw0KPiA+ID4gwqANCj4gPiA+ICsvKg0KPiA+
ID4gKyAqIEludGVsIHN5c3RlbXMgdGhhdCBlbnVtZXJhdGUgRElFIGRvbWFpbiBoYXZlIFJBUEwg
ZG9tYWlucw0KPiA+ID4gaW1wbGVtZW50ZWQNCj4gPiA+ICsgKiBwZXItZGllLCBob3dldmVyLCB0
aGUgc2FtZSBpcyBub3QgdHJ1ZSBmb3IgQU1EIGFuZCBIeWdvbg0KPiA+ID4gcHJvY2Vzc29ycw0K
PiA+ID4gKyAqIHdoZXJlIFJBUEwgZG9tYWlucyBmb3IgUEtHIGVuZXJneSBhcmUgaW4tZmFjdCBw
ZXItUEtHLiBTaW5jZQ0KPiA+ID4gKyAqIGxvZ2ljYWxfZGllX2lkIGlzIHNhbWUgYXMgbG9naWNh
bF9wYWNrYWdlX2lkIGluIGFic2VuY2Ugb2YNCj4gPiA+IERJRQ0KPiA+ID4gKyAqIGVudW1lcmF0
aW9uLCB1c2UgdG9wb2xvZ3lfbG9naWNhbF9kaWVfaWQoKSBvbiBJbnRlbCBzeXN0ZW1zDQo+ID4g
PiBhbmQNCj4gPiA+ICsgKiB0b3BvbG9neV9sb2dpY2FsX3BhY2thZ2VfaWQoKSBvbiBBTUQgYW5k
IEh5Z29uIHN5c3RlbXMuDQo+ID4gPiArICovDQo+ID4gPiArI2RlZmluZSByYXBsX3BtdV9pc19w
a2dfc2NvcGUoKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBcDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAoYm9vdF9jcHVfZGF0YS54
ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EIHx8wqDCoFwNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oCBib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9IWUdPTikNCj4gPiA+ICsN
Cj4gPiA+IMKgLyogY2FsbGVyIHRvIGVuc3VyZSBDUFUgaG90cGx1ZyBsb2NrIGlzIGhlbGQgKi8N
Cj4gPiA+IMKgc3RydWN0IHJhcGxfcGFja2FnZSAqcmFwbF9maW5kX3BhY2thZ2VfZG9tYWluX2Nw
dXNsb2NrZWQoaW50IGlkLA0KPiA+ID4gc3RydWN0IHJhcGxfaWZfcHJpdiAqcHJpdiwNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ym9vbA0KPiA+ID4gaWRfaXNfY3B1KQ0KPiA+ID4gQEAgLTIxMzYsNyArMjE0OCw4IEBAIHN0cnVj
dCByYXBsX3BhY2thZ2UNCj4gPiA+ICpyYXBsX2ZpbmRfcGFja2FnZV9kb21haW5fY3B1c2xvY2tl
ZChpbnQgaWQsIHN0cnVjdCByYXBsX2lmXw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGludCB1aWQ7
DQo+ID4gPiDCoA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChpZF9pc19jcHUpDQo+ID4gPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWlkID0gdG9wb2xvZ3lfbG9naWNhbF9kaWVf
aWQoaWQpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVpZCA9IHJhcGxf
cG11X2lzX3BrZ19zY29wZSgpID8NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRvcG9sb2d5X3BoeXNpY2FsX3BhY2thZ2VfaWQoaWQpIDoNCj4gPiA+IHRv
cG9sb2d5X2xvZ2ljYWxfZGllX2lkKGlkKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBlbHNlDQo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVpZCA9IGlkOw0KPiA+ID4gwqAN
Cj4gPiA+IEBAIC0yMTY4LDkgKzIxODEsMTAgQEAgc3RydWN0IHJhcGxfcGFja2FnZQ0KPiA+ID4g
KnJhcGxfYWRkX3BhY2thZ2VfY3B1c2xvY2tlZChpbnQgaWQsIHN0cnVjdCByYXBsX2lmX3ByaXYg
KnByDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFUlJfUFRS
KC1FTk9NRU0pOw0KPiA+ID4gwqANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoaWRfaXNfY3B1
KSB7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcnAtPmlkID0gdG9wb2xv
Z3lfbG9naWNhbF9kaWVfaWQoaWQpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJwLT5pZCA9IHJhcGxfcG11X2lzX3BrZ19zY29wZSgpID8NCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRvcG9sb2d5X3BoeXNpY2FsX3Bh
Y2thZ2VfaWQoaWQpIDoNCj4gPiA+IHRvcG9sb2d5X2xvZ2ljYWxfZGllX2lkKGlkKTsNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcnAtPmxlYWRfY3B1ID0gaWQ7DQo+ID4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHRvcG9sb2d5X21heF9kaWVzX3Bl
cl9wYWNrYWdlKCkgPiAxKQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
ICghcmFwbF9wbXVfaXNfcGtnX3Njb3BlKCkgJiYNCj4gPiA+IHRvcG9sb2d5X21heF9kaWVzX3Bl
cl9wYWNrYWdlKCkgPiAxKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgc25wcmludGYocnAtPm5hbWUsDQo+ID4gPiBQQUNLQUdFX0RPTUFJTl9O
QU1FX0xFTkdUSCwgInBhY2thZ2UtJWQtZGllLSVkIiwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+IHRv
cG9sb2d5X3BoeXNpY2FsX3BhY2thZ2VfaWQoaWQpLA0KPiA+ID4gdG9wb2xvZ3lfZGllX2lkKGlk
KSk7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsc2UNCj4gPiANCg0K

