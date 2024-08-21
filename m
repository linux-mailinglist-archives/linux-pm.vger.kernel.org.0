Return-Path: <linux-pm+bounces-12654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A995A59B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 22:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB66280D76
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 20:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3415C12B;
	Wed, 21 Aug 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDxqb8WX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4F1D12F4
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270681; cv=fail; b=GDQUfiqYMaHxESk9EmZvBpbI53xUr90yn6su2Xp8XdXscL2oKeTs3SPqaFyevOWezsD0JPt+NJ9QJQ3jGXQeMNblkwI1LMxFVxQ1h8Hpu2cMIKOsAQ0gRT98iCpSgnoCOL0w5/LJhoFos/4EjifGMbzePSR9XlmSSJ7qoQRSoYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270681; c=relaxed/simple;
	bh=Jy8/KzgtMhlA5/s2/zcMbHl3Dv071a8rP+fsaosmac4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VAbV/ZaGyZg02VLhh7ai14SeXS/WQLbDKXet0m1AbAVw4Wf3niota94QV6tvBHOpnNvdonhJmSWetOo2Sh85n08w56sQ19w0melSmECYWO54iksIw1kEq26pvgzoxiOf1WXtVBDMv+Y173SdF5Xl8f3Z71iRDtmB/3bvMikwSR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDxqb8WX; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724270679; x=1755806679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jy8/KzgtMhlA5/s2/zcMbHl3Dv071a8rP+fsaosmac4=;
  b=XDxqb8WXj4EiWz13sMVqmdUGrqY+/NojEKXnaUEuMMoyQir4zlFVLLCy
   JF/QQU/kCV5vfs/4zuwYzKMWPQlwG8B/ZvYUF+sTdwpyfrpl0rhm24VlG
   9z44NkYe5wU8C4f1GCBzVnwcnS0L0b2elHQqZOCgi+kMWBbrk9Lo32xfp
   u2YE56cp2k3DllXOFt15UTs2EVroMuQdzZO9NFcyUSavnGmP7wyTFweiJ
   +rFNTwHf7b0cc/IOs8g2Du67MDDUFgOXtQ+G8fR5AWsgUoxEyzI9FFCbm
   PNMIpAite6Ugy6/AgyGqJpSX4RBpq0k8P8G8CK7+RGzL7N6aQf6AgPfm+
   w==;
X-CSE-ConnectionGUID: GffjJAH8SzOXRXwxg5e4Pg==
X-CSE-MsgGUID: rtcQwwgYRHqflD5ybXNIkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26520380"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26520380"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 13:04:38 -0700
X-CSE-ConnectionGUID: FJPLibb6Qp2xnLDXNiA8GA==
X-CSE-MsgGUID: qDGhpsqaRpeG99dODVHr7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65401582"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 13:04:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 13:04:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 13:04:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 13:04:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 13:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chdhf4BVV8OX1d/z2PSDwcR7O2ac+y58eYhfMrb4M8auL7EkGKG+gI4EaOZT5Txrdbfi3HUHEn7X2k01sm/UVHlWGmOgpJ7+hgsmsUBhYsy6wqeB9+DuPJ6ShtHv6svnT7HqghJuy8Yz/wYCVeCMZgb9k+yNgpqYbIThXVrfj8xyhvqai2kIzSfimPrkJ6ob3m2+nj2I2AmcJbjFq1WvOWrN7ecYrKJdy5VijEsA8DfSusA/1alspJXtVhH5jzx1H417e0f9/3sXVi8J3jgv82EMxhvnpBKd+mAjAjCtRF58TItWaGdGQ9N/q04uKp2TvO1jYntvTJpB/nO2nrV9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy8/KzgtMhlA5/s2/zcMbHl3Dv071a8rP+fsaosmac4=;
 b=QcJf3Mdpykr/GZww2Pd+8q5FqvFY5pQXUpHFL8u95XI8BTfK8CKZywVCV6ATp+DJuIaOL9LUqnJ3IlQTl+k7xnLvt8lp4yWVm/hWHZ47ZrJhwarrZ418skPuBMrWxShzELyLI71ctx1Esm488UxC6al+rVmeKsY2y25a9lPdAoL6Je1ZCA0QNrRgXcVZpIVaSDi+fxYBJyVAq9e137fs/CRS92P8DM7CHx0n+f8ohYlMaFH6eTXfRyrZCCbhsZWlYghqSJ50h6+IvEwK7gRyuH34D3PiNehRvL3mBINLXrf7PNWqrGjSp8RDIz9B3CwZIIBO1DkSeR+joJrGKZO2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Wed, 21 Aug 2024 20:04:35 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%7]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 20:04:34 +0000
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>
CC: "lukasz.luba@arm.com" <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "quic_manafm@quicinc.com"
	<quic_manafm@quicinc.com>
Subject: Re: [PATCH v2 0/7] Add thermal thresholds support
Thread-Topic: [PATCH v2 0/7] Add thermal thresholds support
Thread-Index: AQHa9AVXUG9+if23L0i94LJXXQBhgw==
Date: Wed, 21 Aug 2024 20:04:34 +0000
Message-ID: <1942ed0b96419621583d4a0928883aafd8c2f7f2.camel@intel.com>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
In-Reply-To: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|DS7PR11MB7782:EE_
x-ms-office365-filtering-correlation-id: 4617ff55-8067-450d-dbde-08dcc21c7a79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OFFmbnBOV09CVm84czNqbUFoSElwL1hjV1phWW93aVcxMFFZL1pWTEJZSTFL?=
 =?utf-8?B?eS9CQ0VoZ0tCWWo3MFdFYkpqTWlMd0JZWGw5ZWFpRHMzaVhYREJyVXQ5dDlv?=
 =?utf-8?B?Ri9PZXFtYXg2RnZKbHJMVncrUFVHQkozNXR2bmJLaUp2ZlErM21PVG1PZGxM?=
 =?utf-8?B?SzFRdHk5QjlIUW5ZVDMya1pjQlppTmdPQVQ5K3dWWk5rVFlMcU9XOWVEYVp5?=
 =?utf-8?B?Q0t0eDZRNmsrR1pWZ3k1dnlLUDZOaDRRV0lHT3MxZVphWGxnVnprUHFOTzRp?=
 =?utf-8?B?UVM5bXVCTFIzVjJoUDlGcENvbnNVVWdCUTRvZUl2QVBkVHQzNGh2Z2NZRjR5?=
 =?utf-8?B?N2MwblVxWmdZZW91eEV5OFFjcDJlQW8yNkVxUmhFQy82Zy9SalA2cWpNVFND?=
 =?utf-8?B?Wk1mbks4aWJQNzV2N1JjQ2VXWW1XNS9xSmFuNldwZkl1MS8xTmNHQllKeUlm?=
 =?utf-8?B?bHlQTkY4Rk5CTGZNZVFTSktxcmZRZVl3dUpXaDY0cHJROHcrT3J1dlRHSmlD?=
 =?utf-8?B?UDgxMW9XV3pEWmw4c09OTnlyVDQzRmxsRGYwaExmNW9kbUxySmFOM3BqNEVz?=
 =?utf-8?B?b1V2eExUdEh5ZTRaK0dGQlZkTzdaNjhmMmFFTS9CQU1QR1J3bVRIZGhpR216?=
 =?utf-8?B?YTVlTlZDaXB0U0tucFJFMUpLeWNIMmY1M2pyQXoza0xYT3YxWXdWTXZnL0ZT?=
 =?utf-8?B?c0lQdmpBRUxNWk1RUWNyaGhINHlQdUJuSWZsemdYWVllakhxN2k5c3hrd1ZE?=
 =?utf-8?B?QnNEZEJxRXMyQXZNemJxOStFckJIWHBXWVlIdEF1Nzc2M2JXejdNVWFRWDJv?=
 =?utf-8?B?QnNSdmZZTVpFdTFzM0xscGJQVlZMOUJBMTFGNFlLOGF0VENNcGRrbmx2eDll?=
 =?utf-8?B?U2duYURwRlY5VmViekVvZGJBdE8ySUdUdVVLSUF3UzlqWWZCMmxmbnpFOHox?=
 =?utf-8?B?Y0FGamNvT2txWG9neElvcm9XS1Y1QS9hYlpUZXd2RzJobUxjUG9XaVVOenlW?=
 =?utf-8?B?czlJZWozZEk3QW1jckxEd202RHlIazN5UVBSQllFVmxEbE5kcjAxbkFhYW9s?=
 =?utf-8?B?a1dKN1VKT2M5M1hMZWlBN25WZGx2VmJObDVtWW91aVlGNDFKQ0c5eTNCN1Fi?=
 =?utf-8?B?UXJ3OWdLaDIrS1JZdDNlWTNZOGVVQVRnR2FuY3NhQnZYeVRScTJIT0pTRVpx?=
 =?utf-8?B?ZU9HeGZLdkRhSDRhTVBKK2tkS3FDYnhMTjJlK3BnSEllbzZiTUFSVHg3U0tm?=
 =?utf-8?B?WVY0SldSaGY4RS8vVDdNZDVhdGdHajh0TmVZSFZXaTdhZzhNNWM4WUtmQmxk?=
 =?utf-8?B?R1VaWFZoS3dhY2RHSjFXWktGWnlCWWZEZmFLa05TeWJBRkZvUy81US90cDMw?=
 =?utf-8?B?cFpNVzRZZ3NxKzR3WmZ4RDdZVmJvMzJyS3hWOURxOWVnZ2FSdGtDTHFJbUZE?=
 =?utf-8?B?TDBITnJZTzVPOStldFJVNDdUWEtQZkZTWVhmMXdCKzJnNE1vSjMrajhoVDdy?=
 =?utf-8?B?d25KaWVSUm1WaTQyb3hUL2QvRHRucFJUV1BMZnplaGd3elAvYzBOU01Fb2sw?=
 =?utf-8?B?RGx1RkNFcG1NSTJISi8zMU1jT09LclBtSzdScG50NWhZenRtZ2dPU2htUDVu?=
 =?utf-8?B?YVdleFRqRHU2SkRaTW8xWVdlQzFRdHN0aW9JTFpmQkpiU1NoV0l6d09XK0xM?=
 =?utf-8?B?Y05UcXlBU21sa3d5RHhvQ0dNMVhQNDQ1eUFZaGN6V256c0diM2RNTkFmc2lj?=
 =?utf-8?B?L292N3BMSEs4blFBS0NtTmhFV2k4L1JNVGI2WU1kaytZN1gxY3k5aFlIR09h?=
 =?utf-8?B?b2FER0dFZE03UXFqWWVxU0dWekRPVmNmR0hKYytHM1NjcVhnbGE4eVp5cVRv?=
 =?utf-8?B?UVhEVHZmTllyYWswWTZBRkRrNUNrbU5WTkdDUFZLSzNZSEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFV2KzhJRUJ1Q2IvUlpsWEQ5NnNnYlpMdWcxNzUxY2o2MnIyOHIrbkdDWGcy?=
 =?utf-8?B?cWthMisrdkozdVJHVFQyM1hEcmJEZzZTTWQyWmUxV1YxK21iOHdabGZMblZ3?=
 =?utf-8?B?S0JBdWo0NXhvenJRSlQ1WFd6UUZzdzRNdW1la3lZekRCeWNQVnhCVGhTdFVD?=
 =?utf-8?B?R3EyOG91TTluajhIM2FNZytxVnpwZ3ZrTEIzWUxnYkpWWmxQb0taYm5aY1Jt?=
 =?utf-8?B?KzBKbUtoUWRxeG1DWWZkUXNzSC9EUnNIK2JydWZ4N05QbEVDdkozWWpKZUlj?=
 =?utf-8?B?OExOdFY3cTVDR29uK3JNQTVYbGU2REFRWE1ROC9lekIzNjI5aXoycmtvc0xB?=
 =?utf-8?B?QkdlTmpxNXhqaFRTbnhmVFM5UCtQb01lNlVaVy8vbVpkS0I4VWozSGdhL1ZD?=
 =?utf-8?B?VWtSVGdJWlpSNmdPOFdXa2YwTGMyYjlGc2JCRmd4NUduckNnSVNFb1k3YmRp?=
 =?utf-8?B?aElOTFBhSzZQdm9sWHlhS0luZURmVkpFUE9WWUhxMk1RRzRXb041WmNQSmhC?=
 =?utf-8?B?QXpZR1VSNUFMRVVJb2pJbnZNOVRyQ3VRbnJabnY5SmZMalhBRS8xcVg1dTd4?=
 =?utf-8?B?LzhDSE8zNnR6bkREWTdJMlZObHlRMmdzbTY5a0JOeTBJS1U2VDY0NW05NDBO?=
 =?utf-8?B?OGEzZmJHWFgvVzhqWmNDL0xxRDFVWTZJYVo5YUdCTEV6aTF6ZTg1TndHR1ZI?=
 =?utf-8?B?MzcvMTVPNjMxUGhEd0I2NlUyaUkxRHNZVm9PdWc4U20rampuemlFZnhicFph?=
 =?utf-8?B?YXpPLzZaZ3ZRQXMydnV1UVRNdldFWjRIT3NGa21jWEVLMTUrQjdkMDdKMjcy?=
 =?utf-8?B?aU5hL21BR3BvRFY5ODVIVzVKVWxWL2ZYZkFUWnZtVFZGSURwcks5dk0wL0hX?=
 =?utf-8?B?OHRJRWJ2YStmUjRFckVPazQ3SXg3eTk4TmgrUjB6NmZkc3l2RHp2UUpnM1cz?=
 =?utf-8?B?S1ZVdkVoSlA0SnVJS05sMkRYWVBPMFZIUDh3UjhVOS9JTy92ckI1M1BMQklu?=
 =?utf-8?B?aEZRWnFLWXdZQkErVXFSTkEyL0s3V0xoL3BQekh2VUVMYzl3L2d1ZkxEbXZV?=
 =?utf-8?B?K1FjYm9xeUFyWDNIR1ZSbjFxOTZOV01IbDhSeFNCSmFxcDk5M1dJamJlYTJD?=
 =?utf-8?B?R2cwMGlSSlcrOElZZDQrOEtoSW1mMjE1V1lEdGlRS1ZaRjQ2L04xcXZyaG1j?=
 =?utf-8?B?aXhYc0tvcUhVTm9Ba1o5L3lEbDVwNzRQYlFsNEptVnR2c2krYzJaUGxnQlcz?=
 =?utf-8?B?Q25INlRXUlI5U051cGdiQ0MvOFVKSi8vcWhDMTBQMFc2TElDUzNYdCtuVHVj?=
 =?utf-8?B?V1NQRmRpTXpmM2RKQ2ZnWGV4UzJobFVXZWJ6cjZtRUxmRFdHWitkd0U0VnZI?=
 =?utf-8?B?Zk83bzdvSFB6VGpwMmZGR2dtNTdDT0RWNE5rT1J2dFAxQXU5c21pYmxhNlhE?=
 =?utf-8?B?aUZmbHl5Z0J0RTdmM1hnaE5naFl1ZXc1V2J0dGw2d0JHSXJrSEJvZWZmb1NS?=
 =?utf-8?B?YVRxNGJrVkRjV1piQ0NPYlpac2JhcGlYT0ZqM3hhRENkRkRmeWxWbUpwUVVt?=
 =?utf-8?B?SUFTSnBEcDJIRG82M0lsb0dtRDB0RVd3MVZUbE8vWUl3VGNzSFFEU2NPQjMx?=
 =?utf-8?B?dFFUNjNZTmF5KzZxZ01GVWFsem9YODQ5N2RnOGgvWkxnWWRIRnVjWFJFY2hX?=
 =?utf-8?B?ZTduWTh4bHRQRkJsaGJ6YlZScTRHcXdNVGEza2dmd0gxa0NlemlGVkpjSEJM?=
 =?utf-8?B?MDBPTnRWbGFvczZMM083dzBvbXd6eForaVVjejBJQ00xSWxERjhXUXFiWUw4?=
 =?utf-8?B?N09JN211ekRIcGdwS3B4d0o0d1hFRHMySG83RmlxWlRxeGtDK2M3ZWNTSE5Z?=
 =?utf-8?B?aWx0N1JtRTZmTVlVREZGd3VvSXY1VVpHQ3ZUaGhxZjh1Rzl3amtZeXhmTDJu?=
 =?utf-8?B?Y1NlTkJXYmhqU3FUNkNOcmppQVJRWlVqUmw3VGlrdVY5YmxEQ2d4YWpRM093?=
 =?utf-8?B?SHA3L3huSzFpTjgyV1o1Z0NsSlJ2UFBtL0M4Yk5lYmtWbFY2UVdKODFWMW9q?=
 =?utf-8?B?MDRNdUZwdzVBUk9LZEx1ZkRNUVpKUk95TFE2Uk1TOGVmcWZuRkM5bEd0bDJn?=
 =?utf-8?B?RFMrMmU0ZVBnNkZGbWl2bmZpRDlPaFZXMkp6WHdhbFR3UkxZQVp5cm04VXVG?=
 =?utf-8?Q?yVfhVoE+nMHoAaAiMCk70E0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C350D3C823D31E4C9477E18DCC24BEEB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4617ff55-8067-450d-dbde-08dcc21c7a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 20:04:34.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyFQFeVK3Urmb4NCaSDeUHjxCgzWLv5DPY2V9vzEXxLwCZWa+xCPaphlBz6wbL2/yZY8xoMGKKtdEjlrnwds7zGdcghjLq2r+jJIdHDCi20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
X-OriginatorOrg: intel.com

SGkgRGFuaWVsLA0KDQpPbiBGcmksIDIwMjQtMDgtMTYgYXQgMTA6MTIgKzAyMDAsIERhbmllbCBM
ZXpjYW5vIHdyb3RlOg0KPiBUaGUgdHJpcCBwb2ludHMgYXJlIGEgZmlybXdhcmUgZGVzY3JpcHRp
b24gb2YgdGhlIHRlbXBlcmF0dXJlIGxpbWl0cw0KPiBvZiBhIHNwZWNpZmljIHRoZXJtYWwgem9u
ZSB3aGVyZSB3ZSBhc3NvY2lhdGUgYW4gYWN0aW9uIHdoaWNoIGlzIGRvbmUNCj4gYnkgdGhlIGtl
cm5lbC4gVGhlIHRpbWUgcmVzb2x1dGlvbiBpcyBsb3cuDQo+IA0KPiBUaGUgdXNlcnNwYWNlIGhh
cyB0byBkZWFsIHdpdGggYSBtb3JlIGNvbXBsZXggdGhlcm1hbCBtYW5hZ2VtZW50DQo+IGJhc2Vk
DQo+IG9uIGhldXJpc3RpY3MgZnJvbSBkaWZmZXJlbnQgaW5mb3JtYXRpb24gY29taW5nIGZyb20g
ZGlmZmVyZW50DQo+IHBsYWNlcy4gVGhlIGxvZ2ljIGlzIG11Y2ggbW9yZSBjb21wbGV4IGJ1dCBi
YXNlZCBvbiBhIGJpZ2dlciB0aW1lDQo+IHJlc29sdXRpb24sIHVzdWFsbHkgb25lIHNlY29uZCBi
YXNlZC4NCj4gDQo+IFRoZSBwdXJwb3NlIG9mIHRoZSB1c2Vyc3BhY2UgaXMgdG8gbW9uaXRvciB0
aGUgdGVtcGVyYXR1cmVzIGZyb20NCj4gZGlmZmVyZW50IHBsYWNlcyBhbmQgdGFrZSBhY3Rpb25z
LiBIb3dldmVyLCBpdCBjYW4gbm90IGJlIGNvbnN0YW50bHkNCj4gcmVhZGluZyB0aGUgdGVtcGVy
YXR1cmUgdG8gZGV0ZWN0IHdoZW4gYSB0ZW1wZXJhdHVyZSB0aHJlc2hvbGQgaGFzDQo+IGJlZW4g
cmVhY2hlZC4gVGhpcyBpcyBlc3BlY2lhbGx5IGJhZCBmb3IgbW9iaWxlIG9yIGVtYmVkZGVkIHN5
c3RlbSBhcw0KPiB0aGF0IHdpbGwgbGVhZCB0byBhbiB1bmFjY2VwdGFibGUgbnVtYmVyIG9mIHdh
a2V1cCB0byBjaGVjayB0aGUNCj4gdGVtcGVyYXR1cmUgd2l0aCBub3RoaW5nIHRvIGRvLg0KPiAN
Cj4gT24gdGhlIG90aGVyIHNpZGUsIHRoZSBzZW5zb3JzIGFyZSBub3cgbW9zdCBvZiB0aGUgdGlt
ZSBpbnRlcnJ1cHQNCj4gZHJpdmVuLiBUaGF0IG1lYW5zIHRoZSB0aGVybWFsIGZyYW1ld29yayB3
aWxsIHVzZSB0aGUgdGVtcGVyYXR1cmUNCj4gdHJpcA0KPiBwb2ludHMgdG8gcHJvZ3JhbSB0aGUg
c2Vuc29yIHRvIHRyaWdnZXIgYW4gaW50ZXJydXB0IHdoZW4gYQ0KPiB0ZW1wZXJhdHVyZSBsaW1p
dCBpcyBjcm9zc2VkLg0KPiANCj4gVW5mb3J0dW5hdGVseSwgdGhlIHVzZXJzcGFjZSBjYW4gbm90
IGJlbmVmaXQgdGhpcyBmZWF0dXJlIGFuZCBjdXJyZW50DQo+IHNvbHV0aW9ucyBmb3VuZCBoZXJl
IGFuZCB0aGVyZSwgaW93IG91dC1vZi10cmVlLCBhcmUgdG8gYWRkIGZha2UgdHJpcA0KPiBwb2lu
dHMgaW4gdGhlIGZpcm13YXJlIGFuZCBlbmFibGUgdGhlIHdyaXRhYmxlIHRyaXAgcG9pbnRzLg0K
PiANCj4gVGhpcyBpcyBiYWQgZm9yIGRpZmZlcmVudCByZWFzb25zLCB0aGUgdHJpcCBwb2ludHMg
YXJlIGZvciBpbi1rZXJuZWwNCj4gYWN0aW9ucywgdGhlIHNlbWFudGljIG9mIHRoZWlyIHR5cGVz
IGlzIHVzZWQgYnkgdGhlIHRoZXJtYWwgZnJhbWV3b3JrDQo+IGFuZCBieSBhZGRpbmcgdHJpcCBw
b2ludHMgaW4gdGhlIGRldmljZSB0cmVlIGlzIGEgd2F5IHRvIG92ZXJjb21lIHRoZQ0KPiBjdXJy
ZW50IGxpbWl0YXRpb24gYnV0IHRhbXBlcmluZyB3aXRoIGhvdyB0aGUgdGhlcm1hbCBmcmFtZXdv
cmsgaXMNCj4gc3VwcG9zZWQgdG8gd29yay4gVGhlIHdyaXRhYmxlIHRyaXAgcG9pbnRzIGlzIGEg
d2F5IHRvIGFkanVzdCBhDQo+IHRlbXBlcmF0dXJlIGxpbWl0IGdpdmVuIGEgc3BlY2lmaWMgcGxh
dGZvcm0gaWYgdGhlIGZpcm13YXJlIGlzIG5vdA0KPiBhY2N1cmF0ZSBlbm91Z2ggYW5kIFRCSCBp
dCBpcyBtb3JlIGEgZGVidWcgZmVhdHVyZSBmcm9tIG15IFBPVi4NCj4gDQo+IFRoZSB0aHJlc2hv
bGRzIG1lY2hhbmlzbSBpcyBhIHdheSB0byBoYXZlIHRoZSB1c2Vyc3BhY2UgdG8gdGVsbA0KPiB0
aGVybWFsIGZyYW1ld29yayB0byBzZW5kIGEgbm90aWZpY2F0aW9uIHdoZW4gYSB0ZW1wZXJhdHVy
ZSBsaW1pdCBpcw0KPiBjcm9zc2VkLiBUaGVyZSBpcyBubyBpZCwgbm8gaHlzdGVyZXNpcywganVz
dCB0aGUgdGVtcGVyYXR1cmUgYW5kIHRoZQ0KPiBkaXJlY3Rpb24gb2YgdGhlIGxpbWl0IGNyb3Nz
aW5nLiBUaGF0IG1lYW5zIHdlIGNhbiBiZSBub3RpZmllZCB3aGVuIGENCj4gdGhyZXNob2xkIGlz
IGNyb3NzZWQgdGhlIHdheSB1cCBvbmx5LCBvciB0aGUgd2F5IGRvd24gb25seSBvciBib3RoDQo+
IHdheXMuIFRoYXQgYWxsb3dzIHRvIGNyZWF0ZSBoeXN0ZXJlc2lzIHZhbHVlcyBpZiBpdCBpcyBu
ZWVkZWQuDQo+IA0KPiBBIHRocmVzaG9sZCBjYW4gYmUgYWRkZWQsIGRlbGV0ZWQgb3IgZmx1c2hl
ZC4gVGhlIGxhdHRlciBtZWFucyBhbGwNCj4gdGhyZXNob2xkcyBiZWxvbmdpbmcgdG8gYSB0aGVy
bWFsIHpvbmUgd2lsbCBiZSBkZWxldGVkLg0KPiDCoMKgwqAgDQoNClNvIHlvdSBhcmUgcHJvcG9z
aW5nIHRvIGFkZCB0aHJlc2hvbGQgdmlhIG5ldGxpbmssIG5vdCBhZGRpbmcgYW55IG5ldw0Kc3lz
ZnMgYXR0cmlidXRlPyBUaGF0IGlzIG5vdCBjbGVhciBoZXJlLg0KDQpJIHRoaW5rIHlvdSBhcmUg
YWRkaW5nIg0KVEhFUk1BTF9HRU5MX0NNRF9USFJFU0hPTERfR0VUDQpUSEVSTUFMX0dFTkxfQ01E
X1RIUkVTSE9MRF9BREQNClRIRVJNQUxfR0VOTF9DTURfVEhSRVNIT0xEX0RFTEVURQ0KVEhFUk1B
TF9HRU5MX0NNRF9USFJFU0hPTERfRkxVU0gNCg0KV2UgbmVlZCB0byBkb2N1bWVudCBvdXIgbmV0
bGluayBtZXNzYWdlcyBpbmNsdWRpbmcgb2xkIG9uZXMuDQoNCkFsc28gd2Ugc2hvdWxkIGFkZCAi
TU9ESUZZIiBhcyB3ZSB0ZW5kIHRvIGNoYW5nZSB0aGVtIHF1aXRlIG9mdGVuLg0KDQpBbHNvIG5v
IGh5c3RlcmVzaXMsIHRoYXQgaXMgcHJhY3RpY2FsbHkgd2UgY2FuJ3QgdXNlLiBUZW1wZXJhdHVy
ZQ0KY2hhbmdlcyBzbyBtdWNoIHRoYXQgdGhhdCB3aWxsIGZsb29kIHVzZXIgc3BhY2UuIFlvdSB3
aWxsIGdldCAxMDBzIG9mDQpldmVudHMgb24gQ1BVIHRlbXBlcmF0dXJlIGlmIHlvdSBzZXQgdGVt
cGVyYXR1cmUgdGhyZXNob2xkIGluIENQVS4NCldlIGhhdmUgYSB3aG9sZSBmaWx0ZXJpbmcgaW4g
ZHJpdmVyIHRvIGF2b2lkIHRoaXMuDQpZb3UgbmVlZCBhIHJhdGUgbGltaXQgaGVyZS4NCg0KVGhl
cmUgYXJlIG11bHRpcGxlIHVzZXIgcHJvY2Vzc2VzIGNhbiBhZGQgdGhyZXNob2xkIGFuZCB0aGVy
ZSBpcyBubw0Kb3duZXJzaGlwLiBTbyBvbmUgcHJvY2VzcyBjYW4gY2F1c2UgdG9vIG11Y2ggbm9p
c2UgdG8gb3RoZXJzIGFzIGl0IGlzDQptdWx0aWNhc3QuDQoNCldlIHdvcmtlZCBvbiBhIGNoYW5n
ZSB0byBmaWxlciB0aGVzZSBhcyBkaXNjdXNzZWQgZHVyaW5nIGxhc3QgTFBDLCBidXQNCm5vdCBw
b3N0ZWQgeWV0LiBUaGlzIHdpbGwgcmVhbGx5IG5lZWQgdGhpcyBhcyB0aGlzIHdpbGwgYmUgdG9v
IG1hbnkNCm1lc3NhZ2VzLg0KDQpUaGFua3MsDQpTcmluaXZhcw0KDQoNCg0KPiBXaGVuIGEgdGhy
ZXNob2xkIGlzIGFkZGVkOg0KPiANCj4gwqAtIGlmIHRoZSBzYW1lIHRocmVzaG9sZCAodGVtcGVy
YXR1cmUgYW5kIGRpcmVjdGlvbikgZXhpc3RzLCBhbiBlcnJvcg0KPiDCoMKgIGlzIHJldHVybmVk
DQo+IA0KPiDCoC0gaWYgYSB0aHJlc2hvbGQgaXMgc3BlY2lmaWVkIHdpdGggdGhlIHNhbWUgdGVt
cGVyYXR1cmUgYnV0IGENCj4gwqDCoCBkaWZmZXJlbnQgZGlyZWN0aW9uLCB0aGUgc3BlY2lmaWVk
IGRpcmVjdGlvbiBpcyBhZGRlZA0KPiANCj4gwqAtIGlmIHRoZXJlIGlzIG5vIHRocmVzaG9sZCB3
aXRoIHRoZSBzYW1lIHRlbXBlcmF0dXJlIHRoZW4gaXQgaXMNCj4gwqDCoCBjcmVhdGVkDQo+IA0K
PiBXaGVuIGEgdGhyZXNob2xkIGlzIGRlbGV0ZWQ6DQo+IA0KPiDCoC0gaWYgdGhlIHNhbWUgdGhy
ZXNob2xkICh0ZW1wZXJhdHVyZSBhbmQgZGlyZWN0aW9uKSBleGlzdHMsIGl0IGlzDQo+IMKgwqAg
ZGVsZXRlZA0KPiANCj4gwqAtIGlmIGEgdGhyZXNob2xkIGlzIHNwZWNpZmllZCB3aXRoIHRoZSBz
YW1lIHRlbXBlcmF0dXJlIGJ1dCBhDQo+IMKgwqAgZGlmZmVyZW50IGRpcmVjdGlvbiwgdGhlIHNw
ZWNpZmllZCBkaXJlY3Rpb24gaXMgcmVtb3ZlZA0KPiANCj4gwqAtIGlmIHRoZXJlIGlzIG5vIHRo
cmVzaG9sZCB3aXRoIHRoZSBzYW1lIHRlbXBlcmF0dXJlLCB0aGVuIGFuIGVycm9yDQo+IMKgwqAg
aXMgcmV0dXJuZWQNCj4gDQo+IFdoZW4gdGhlIHRocmVzaG9sZCBhcmUgZmx1c2hlZDoNCj4gDQo+
IMKgLSBBbGwgdGhyZXNob2xkcyByZWxhdGVkIHRvIGEgdGhlcm1hbCB6b25lIGFyZSBkZWxldGVk
DQo+IA0KPiBXaGVuIGEgdGhyZXNob2xkIGlzIGNyb3NzZWQ6DQo+IA0KPiDCoC0gdGhlIHVzZXJz
cGFjZSBkb2VzIG5vdCBuZWVkIHRvIGtub3cgd2hpY2ggdGhyZXNob2xkKHMpIGhhdmUgYmVlbg0K
PiDCoMKgIGNyb3NzZWQsIGl0IHdpbGwgYmUgbm90aWZpZWQgd2l0aCB0aGUgdGhlcm1hbCB6b25l
IGlkZW50aWZpZXIsIHRoZQ0KPiDCoMKgIGN1cnJlbnQgdGVtcGVyYXR1cmUgYW5kIHRoZSBwcmV2
aW91cyB0ZW1wZXJhdHVyZQ0KPiANCj4gwqAtIGlmIG11bHRpcGxlIHRocmVzaG9sZHMgaGF2ZSBi
ZWVuIGNyb3NzZWQgYmV0d2VlbiB0d28gdXBkYXRlcyBvbmx5DQo+IMKgwqAgb25lIG5vdGlmaWNh
dGlvbiB3aWxsIGJlIHNlbmQgdG8gdGhlIHVzZXJzcGFjZSwgaXQgaXMgcG9pbnRsZXNzIHRvDQo+
IMKgwqAgc2VuZCBhIG5vdGlmaWNhdGlvbiBwZXIgdGhyZXNob2xkcyBjcm9zc2VkIGFzIHRoZSB1
c2Vyc3BhY2UgY2FuDQo+IMKgwqAgaGFuZGxlIHRoYXQgZWFzaWx5IHdoZW4gaXQgaGFzIHRoZSB0
ZW1wZXJhdHVyZSBkZWx0YSBpbmZvcm1hdGlvbg0KPiANCj4gQWxsIGFmb3JlbWVudGlvbmVkIGFj
dGlvbnMgYW5kIGV2ZW50cyBsZWFkIHRvIGEgbm90aWZpY2F0aW9uIHRvIHRoZQ0KPiB1c2Vyc3Bh
Y2UuIEEgdGhyZXNob2xkIGNoYW5nZSAoYWRkLCBkZWxldGUgYW5kIGZsdXNoKSBpcyBub3RpZmll
ZCB0bw0KPiB0aGUgdXNlcnNwYWNlIHdpdGggdGhlIHByb2Nlc3MgaWQgcmVzcG9uc2libGUgb2Yg
dGhlIGFjdGlvbi4NCj4gDQo+IEFsb25nIHdpdGggdGhlIGtlcm5lbCBjaGFuZ2VzLCB0aGUgdGhl
cm1hbCBsaWJyYXJ5IGhhcyBiZWVuIGV4dGVuZGVkDQo+IHRvIHByb3ZpZGUgdGhlIGRpZmZlcmVu
dCBBUEkgdG8gZGVhbCB3aXRoIHRoZSBuZXcgdGhyZXNob2xkIG5ldGxpbmsNCj4gZXZlbnRzIGFu
ZCBjb21tYW5kcy4NCj4gDQo+IEluIGFkZGl0aW9uLCB0aGUgdGhlcm1hbC1lbmdpbmUgc2tlbGV0
b24gdXNlcyB0aGVzZSBuZXcgQVBJIGJ5DQo+IGZsdXNoaW5nIGFuZCBhZGRpbmcgdGhyZXNob2xk
cyBhcyB3ZWxsIGFzIGdldHRpbmcgdGhlIG5vdGlmaWNhdGlvbg0KPiBhYm91dCB0aGVzZSBhY3Rp
b25zLg0KPiANCj4gT3ZlcmFsbCB0aGUgc2VyaWVzIGhhcyBiZWVuIHRlc3RlZCB3aXRoIHRoZSB0
aGVybWFsLWVuZ2luZSBza2VsZXRvbg0KPiBhbmQgc29tZSBzZWxmdGVzdHMgd2hpY2ggYXJlIG5v
dCBwYXJ0IG9mIHRoaXMgc2VyaWVzLg0KPiANCj4gQ2hhbmdlbG9nOg0KPiDCoCBWMjoNCj4gwqDC
oMKgIC0gQ29tcHV0ZSBtaW4gYW5kIG1heCBpbiB0aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSgp
IGJ1dCBrZWVwDQo+IMKgwqDCoMKgwqAgdGhlIGxvb3AgYXMgaXQgaXMgKFJhZmFlbCkNCj4gDQo+
IMKgwqDCoCAtIEluY2x1ZGUgc2xhYi5oIHRvIGZpeCBjb21waWxhdGlvbiB3YXJuaW5ncyBvbiBz
b21lDQo+IGFyY2hpdGVjdHVyZXMNCj4gwqDCoMKgwqDCoCB3aXRoIGttYWxsb2MgYW5kIGtmcmVl
IChrZXJuZWwgdGVzdCByb2JvdCkNCj4gDQo+IERhbmllbCBMZXpjYW5vICg3KToNCj4gwqAgdGhl
cm1hbC9jb3JlOiBDb21wdXRlIGxvdyBhbmQgaGlnaCBib3VuZGFyaWVzIGluDQo+IMKgwqDCoCB0
aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSgpDQo+IMKgIHRoZXJtYWwvY29yZTogQWRkIHRocmVz
aG9sZHMgc3VwcG9ydA0KPiDCoCB0aGVybWFsL2NvcmU6IENvbm5lY3QgdGhlIHRocmVzaG9sZCB3
aXRoIHRoZSBjb3JlDQo+IMKgIHRoZXJtYWwvbmV0bGluazogQWRkIHRoZSBjb21tYW5kcyBhbmQg
dGhlIGV2ZW50cyBmb3IgdGhlIHRocmVzaG9sZHMNCj4gwqAgdG9vbHMvbGliL3RoZXJtYWw6IE1h
a2UgbW9yZSBnZW5lcmljIHRoZSBjb21tYW5kIGVuY29kaW5nIGZ1bmN0aW9uDQo+IMKgIHRvb2xz
L2xpYi90aGVybWFsOiBBZGQgdGhlIHRocmVzaG9sZCBuZXRsaW5rIEFCSQ0KPiDCoCB0b29scy90
aGVybWFsL3RoZXJtYWwtZW5naW5lOiBUYWtlIGludG8gYWNjb3VudCB0aGUgdGhyZXNob2xkcyBB
UEkNCj4gDQo+IMKgZHJpdmVycy90aGVybWFsL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTUgKysNCj4gwqBkcml2ZXJzL3RoZXJtYWwvTWFr
ZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyAr
DQo+IMKgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAyMSArLQ0KPiDCoGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICstDQo+IMKgZHJpdmVycy90aGVy
bWFsL3RoZXJtYWxfbmV0bGluay5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjM5DQo+ICsr
KysrKysrKysrKysrKystDQo+IMKgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfbmV0bGluay5owqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDcgKw0KPiDCoGRyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX3RocmVzaG9sZHMuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDI0Nw0KPiArKysrKysrKysrKysr
KysrKysNCj4gwqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF90aHJlc2hvbGRzLmjCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDU0ICsrKysNCj4gwqBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF90cmlwLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI3ICstDQo+IMKgaW5jbHVkZS9saW51
eC90aGVybWFsLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCAzICsNCj4gwqBpbmNsdWRlL3VhcGkvbGludXgvdGhlcm1hbC5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzAgKystDQo+IMKgdG9vbHMvbGliL3RoZXJtYWwvY29t
bWFuZHMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNjcgKysrKysrKysr
KystDQo+IMKgdG9vbHMvbGliL3RoZXJtYWwvZXZlbnRzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNTggKysrLQ0KPiDCoHRvb2xzL2xpYi90aGVybWFsL2luY2x1
ZGUvdGhlcm1hbC5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQwICsrKw0KPiDCoHRvb2xzL2xp
Yi90aGVybWFsL2xpYnRoZXJtYWwubWFwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
NSArDQo+IMKgdG9vbHMvbGliL3RoZXJtYWwvdGhlcm1hbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAxNyArKw0KPiDCoHRvb2xzL3RoZXJtYWwvbGliL01ha2VmaWxl
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQ0KPiDCoHRv
b2xzL3RoZXJtYWwvdGhlcm1hbC1lbmdpbmUvdGhlcm1hbC1lbmdpbmUuYyB8IDEwOSArKysrKysr
LQ0KPiDCoDE4IGZpbGVzIGNoYW5nZWQsIDk3MiBpbnNlcnRpb25zKCspLCA3OCBkZWxldGlvbnMo
LSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfdGhyZXNo
b2xkcy5jDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX3Ro
cmVzaG9sZHMuaA0KPiANCg0K

