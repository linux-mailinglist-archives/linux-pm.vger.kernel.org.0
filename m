Return-Path: <linux-pm+bounces-28182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92408ACFD6B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 09:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49027175148
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058C2040B6;
	Fri,  6 Jun 2025 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXVLoAi7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68950149C7B;
	Fri,  6 Jun 2025 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194602; cv=fail; b=T96Zyv43pUXynbz7cOBh/jNZTgH0wiG0tmT6NeFk1DB940tHgVX7+dt42/TPKvNroeq+iFBbz1+R6Ed/k2Ibc4IEqEqbXfrFHo39xCerO1B32dmEwYQgMlvAk75HBcFx8t3izw1IHW+QewbX5n/cI9oK+MlGL/eCoKRgzHF8OMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194602; c=relaxed/simple;
	bh=xmkfOoT4EDJTGuV88y8ooePmvinkbSEmHv8KFoxNn8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RTChb4UhpzI9IUd8HPLS8G2a2AzGt130eQNmFhpfpBC/o2TemgfvIDttvSQTrtwcdQ5TJZrBw1LpIf97DMrP9lbgnTBbAxEBEsuo+V5dH8V4q+kX6+HQEyNnbbx+yNtuwiO8oEnbtqNZh50B7FO8Kkuvav+HRPn0gs5QHpO6lBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXVLoAi7; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749194601; x=1780730601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xmkfOoT4EDJTGuV88y8ooePmvinkbSEmHv8KFoxNn8k=;
  b=TXVLoAi7/H0MyyR9bTkRSLGFLsTTnp1Okr/OF7qEcrK0q29JBT6scf4l
   C7kVZ14whud45el5oUWoVFucduOluDxqE1CnVXRy4M7YD42qA+LEaYRzo
   MjK7vN5Qm1Zs5tfXgQnBl15h33Db6qC3ot4Nk1OSoHHK+s7g80UXYxs91
   7+zNCLvuAniBFrL93lyRIKALP6rDluYjEOJ8S03sE5oDCPea2CcPsQ5TQ
   9HMWAGO/sEbwEqBsAA1elx/aheVnbU6F30l49dgbJfHrLS8yJVRxJKqkp
   0/dqBEBXOpoApNT5vkxC8hqNlwOjnqTKiD8NDxzK8q/iyu32f9AVRCD1W
   A==;
X-CSE-ConnectionGUID: FX3kx+ATQp+zWldScBWCUg==
X-CSE-MsgGUID: 1baK7vc7Q8+Lec8R6u4Tkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="50447508"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="50447508"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 00:23:18 -0700
X-CSE-ConnectionGUID: ztSCkACRQhqz6j5EZUd+lg==
X-CSE-MsgGUID: 0lKa63LlQ0Krk3LOB/xW3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="146719006"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 00:22:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 00:22:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 00:22:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.54)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 00:22:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfcOE05XX+2XdRSHfcJbGBQfleAvw9jVtl/eboy/iVVG7O+/7oNzFgccpQI7OAOXnXZzc5zyeBNxo+PvClA0eEdRNkuM8vJLvAe8kYblmBLL9dPMHbqMJ3JJuoCndb0CwgO6xh0Xi/6HzopnNXal7Ig8RP5ClpSc/W0l5Xijbvjc8mQjgQBImAFip8wqit20xHlxfn4yE3yBI33Xh2e28ROWWeR1c3A0/uFTaQ0+eWSL3iwfc44C/3ILH65JIMrHmbH4Su0nKuOIADv/Wacg3jW1XXGBuRJvhkZFg958jeL2puwyi9e0Rgctgu671CfQIZxzReujziSCp5lve3EStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmkfOoT4EDJTGuV88y8ooePmvinkbSEmHv8KFoxNn8k=;
 b=iJnCLckk2rtVx70ge9I3oxC3heZPj9YRZ1I2fIlNDSE3w/l7mI+ViCxAqDBhtfKRRYRY6sE9fY9dbowWtQEpEqxM9PZ0dZmXv3yp9bYztvjzosR0bH1zfr2UEz/lfrcka6aZ7mqOTLt18Tkbz8dGMs1LqpwuMqOFxB8o/RQgnnFy1XOUG4s+sIeN3Hk6fbPBx6pSoYWis6WTzOONsL6I1KjgpH3pxQHe9CxtxI+1JBEbEkVfUysphAfmFOxQzrrxuPTyuY96/FDUzeqqbzyGwjSnnwn6SBQg81PVInbJac0uNq2IJX/dMw/erYW33oLq3DMIsWldPkKcwTH16XuhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by MW4PR11MB6764.namprd11.prod.outlook.com (2603:10b6:303:209::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 6 Jun
 2025 07:22:27 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::b83b:c176:bef3:a4e3%5]) with mapi id 15.20.8769.029; Fri, 6 Jun 2025
 07:22:27 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: intel: int340x: Allow temperature override
Thread-Topic: [PATCH 2/2] thermal: intel: int340x: Allow temperature override
Thread-Index: AQHb1ZA3JL2mYo8Ib068GOxg2oxm8LPz1QOAgAD8MYCAAOspgA==
Date: Fri, 6 Jun 2025 07:22:27 +0000
Message-ID: <0fcd95bc6e9b300caa7d3029c9c43e9b5de6627e.camel@intel.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
	 <20250604203518.2330533-2-srinivas.pandruvada@linux.intel.com>
	 <545fae8be782943a92d9df1c4a3ff90b7a865c76.camel@intel.com>
	 <63d616ac8bb1dbac9eebf10953886a5ce3274940.camel@linux.intel.com>
In-Reply-To: <63d616ac8bb1dbac9eebf10953886a5ce3274940.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|MW4PR11MB6764:EE_
x-ms-office365-filtering-correlation-id: 74ee4447-8ed1-4192-fac8-08dda4cae40a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTNYMjh3ZXU2NXZwRWd5b1BNVzA2ZEIvWmNaSmdIdmpJdCtJM1FTNGFQbU1E?=
 =?utf-8?B?d3dnOWt6ZGQ3VEF0aEtPMDdnQm5jWjFNV21nRUlpTVVaaW1ibTlWMmdlWGRw?=
 =?utf-8?B?NzYwNHh3NUxUM05XbmJWR2xSWkMvUnZLMVVPbFJYZE96eE9iYmFUSkhVU3Jt?=
 =?utf-8?B?VVE0ZGFXZE5RdmxnTnA3blJSaE15WTAwU3pBVGVaK2hwUWRCVkJPRUkwK1Z0?=
 =?utf-8?B?UFhGcUxodlBHRWY2dDVQTkl6cE0wRnRsQTE1WWpFMzJ6eEM1OUZ4UE5VNWpZ?=
 =?utf-8?B?d0Q2TlVaSTFHVnFRMlBGQmtmL3J4Qmp6cFFhMVRsUDF1NTJDRFJSUkU4cldh?=
 =?utf-8?B?YVcvdEU1WHViaHhUcmhKdlJWWHZtbDlkUUhWMVVsbWY3amZ5R0NoWCt5cG5O?=
 =?utf-8?B?UWpEaWdQRnlyb0JLQ2RrV3g3VHVlNHAxM1JUaGhUUXNLTk1uZlEyNnJYcDQ3?=
 =?utf-8?B?Qm5TUUt5ckhCWGlObytER1ZpenpNVGJReGt1N3FaTk1DSS85M1N5Mk5CdmFj?=
 =?utf-8?B?Nnc3NGt1VnJLMllXVmNta3pybWJCV21hWlZQRHlIQUUvSGhrSjN1eDIzQUtY?=
 =?utf-8?B?Y1dISDQ5a0d0c052WlQ3RzNUcDFMV2tGc3IzeFFzSi9DN0duVm5TMTY0Wmpp?=
 =?utf-8?B?Rk9pbmp4QmdMaWRWTndOUHdvZzRWckNaYjdPc3JOMjltaXdVZTV1WDY1MVhH?=
 =?utf-8?B?M3FEd0xyazlsZG5zb1lvdHZxakRmUE96am5SdzZkWFlwOXNPczhXTlVNamM2?=
 =?utf-8?B?Z1RNc21YWEs1S0JJN2JZaWVTbUpqR2ZWdnlnZDBkRVNlbkVpY2xtMnZ5bU03?=
 =?utf-8?B?MmxPanMvM3RoUjMyaHpGTFRveEVmeFM0ZU0ydUMyUlNhbVluSGJTOWJjNG9V?=
 =?utf-8?B?bmw4dUNqQU9udURuWXI2eFRKTC9OMDlVVnpKWUNGZU94YW8vTXl2QmhGeHlW?=
 =?utf-8?B?TFBWbDhDM3hqNWpTRFJUMVVzSUZvbjhURzZuekdpcmtYTjlVbERhM2dmRWRr?=
 =?utf-8?B?RE5HQTN3NFN6S0ZzcVNOMUpMOE5pbVJQTjFMOXZML3dlVjlvMG9ZeXZNNHZU?=
 =?utf-8?B?a0o3VDEvNDB1SWFKZTFOYmxTSXlmSDVvR2svMmcxN1JXMU0yVnBhVDhKL2p4?=
 =?utf-8?B?Z1NPRlh4ZWw0R1FWL3gwRktuTGxwNXFwWUZ2a3ZHQmdQMUoyWXphRVVaNnNY?=
 =?utf-8?B?dzFpWnRqTmJGUFI5OU9nRmRtVERQTzlZZG0ySVR4bEhORFZMdkFvbmlvUTlH?=
 =?utf-8?B?d0NpNThzQ1Q5SzN3Vlg4M1EwRmpRa0lnOVNoSDZPQmNURGhucGtOMkJTNmhN?=
 =?utf-8?B?YWFxSVZyOFZpdk9iSHRQVXFuVFVGamtLYm00cWRoakkrcXArdVcxN0tTQTQ3?=
 =?utf-8?B?NzlGQUpFb2pRSXh6TWkrTXc4Qmoyb0JNMXFIc3VQOXFTRmo1RU9ncGpqRHZB?=
 =?utf-8?B?TTNWQ0xxbWQrV0t0YmQ2K2hrMkp0RE9xNWlHZTZDSVp3MlA1SDNFdGJxRVla?=
 =?utf-8?B?MVdlRW5wbENGaGJ2RDhtUGd5NkR5bnAreXlSM3JxYmdLa3k0Q0h1Y3BDMHdn?=
 =?utf-8?B?aEprVHU4bzZMZ2djeitaS3NmVm94Z3hZOWRMR3pneFNqbFZOQ3U4RlBSWFVs?=
 =?utf-8?B?bVJVSzRQb0pZYUhCSlEweVV2bWV6TGVmTHFkejVMbTVKTWlPcThWOU91Rmpy?=
 =?utf-8?B?Um4vNlVaekRJRXhnV3pwaXF0ajIxU2xGdjBJbFB3emoyZlhPSHZ5eiswNHhE?=
 =?utf-8?B?QzNYMkUvZVVVQlE3bVBLdDhXVlBrbEJCbElwWDQ0UjcvMjN6RVhhS3h0bGNE?=
 =?utf-8?B?Z0Fsa3liQitVWFVNNjFHTkh0M2FXNHBJdnJhRGtGbjFvNHFkZ3hhOGxBSUR1?=
 =?utf-8?B?YWRwcytqS3pMdmZ3L0lFcEtQT3BiekZoS1FlSkJIaWZoNkdYUUR3anRWa1FJ?=
 =?utf-8?B?emlqcXNBYmlsVDBmVFRTSkQ3YzlxOHd5NHhEd3pqa1plY1FyOUduVU1lM2gv?=
 =?utf-8?Q?saxVKKSunGZcEGYqti+CpaREEt4AsA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnVJaGhId0tZYmtwYzM3czBUMzZ1enBvRzZyd2U5VWpVQXBGUTNBVzVabTM0?=
 =?utf-8?B?UVBtNnBOZ0REZTlXOC81RmRwTjNvNTk1cmc4T0dMRDE2L0Vqd0dDMHZ5T0pW?=
 =?utf-8?B?dEpkcjBleW4xTExhMXZnWmkvbmlSRDFYc2UxMjVJN2M0bXJVdE0wRUpERGg0?=
 =?utf-8?B?RS9PT0pTTWRkYnRMWVF4VzlEdGtINVgzMENyTFFoMVJWMlpmUUhPTFcrUDIr?=
 =?utf-8?B?U1NqaHJqdHdNUlc5WmdqRG5FTHgzbmxJVXZHQmYzVFR6OVZWaVIxQVVZbStm?=
 =?utf-8?B?U3hSOFFvWGZNc0t4SVlLOTMwSWFSNFBNK3RwTmZoekpCbE5OWEVsaUZIdEhn?=
 =?utf-8?B?Q2ZkU0N1ZmVWb3pOWUpqQXZoUklwZFU0Ui9HM1N2RHFQZ2dtN0ZQM2ltbzlN?=
 =?utf-8?B?VHZYSGNObk4zSUwyczhnb1NZRlNWK3NqMDg2M01oL3BLV1krSFhZWGNNb3No?=
 =?utf-8?B?TG9oWm5uNDl5SFJFNTFwY0RTNlg0Sk5aZWRsQmFDM3IrTjNCVldxRm1sU3NJ?=
 =?utf-8?B?WURmdk5zemN0Y2RZYmNKRk9JMHpWZEdLRmJPdmRkMnZYdytQMzF2UytOekZl?=
 =?utf-8?B?ZU1kSlp5N2dSR3dYVm92ZUdjYlJPVm9wS2cyWkFjQVZ0TS9zWjlmdmJPOXFs?=
 =?utf-8?B?UytQVFBJSEo5eVdKQzE4VHRFaStqdG00d2ZIbjNpY2ptdm1xUE9RdjNSamtQ?=
 =?utf-8?B?OVZMLzUzUy8rbXFXOE1aSk52SFUwQkxpc1NJZDRUdmh2cEl5dDdZeTF3UTdX?=
 =?utf-8?B?S0tNNGxpQXYzMk55SllWRlNRNDNaZlg2QkVEUjBPYXJEQ1hpaU11QXFUZ2Ux?=
 =?utf-8?B?VUNFNlorVnVzTUtVWjd4cWtPNVE5QmdkMzBEQmx2OXNqUmR5bjhjZTdYb2x0?=
 =?utf-8?B?RFc2S0VFZjhZZ1czcmRGN1I4aDV0Nnk1Vm1kQVVubTZPRUsxd290cFBLVFVP?=
 =?utf-8?B?UTcwRS9XWHNjbGVacEx3OFh1a2Z1UEJhOStNWFVrWkErR3dJek41R1BGYmJw?=
 =?utf-8?B?Ym5aMXZYdDYzMnVCQ1R3Q243ekczT05uZnFGb1J1ZzY2S1p3cXE1TW04M0lY?=
 =?utf-8?B?S0ptMzE3cjJhYk95L3diTWRpL3BSTVNnSlBYSDFwRTlJQWFOTmoxWHloa01M?=
 =?utf-8?B?OUJkK3lmR2s0SHNNMEt0RXpTemc3c29YWExhamhJcDkrc0lWVFY0eUZ4NWNN?=
 =?utf-8?B?cGZ3T0hYOXp4c3M2MWJMczRvbGtvSjlNSWZwVUV3aXNNVWtUZWJvUzcyQUxL?=
 =?utf-8?B?ZFI2SCtVdjhseml5ZHd6c3FWQVZPcUE1QTBOd25EbU50bXNBNy9oUi95WWFs?=
 =?utf-8?B?cnE1Q1pYbVlYUHhMN255SWx1RkhoUUdXVEk1ZHN5ZDJudFVuV3F5K01pUVVF?=
 =?utf-8?B?NTNsdnp2dHR5dmNrZlkvTlA1RkJvK3hWQldTa0FRSDVOVUN1UG5nZmRhekFP?=
 =?utf-8?B?a293a29MT1E2anBoNys5OW1teCsrc2MzU0RTazRIOXJiSUh2WndDbkF4cDBu?=
 =?utf-8?B?dWppeW1kRVpPWEkySE5lanF1cWtOT2tJMDRlcHpYc29MeUNTN21qLzByMVJU?=
 =?utf-8?B?SjRtczhZbnJQQ244TWkwU1RMK1Q5WlBqcWJTWWd6TEwrVnl6VHNxeXNZQ3Qz?=
 =?utf-8?B?REhVWHpUMkErU3NBR0dUekQrYzhnQS9udS9TcHllOTh6TXJBSTBaSTc0MnJU?=
 =?utf-8?B?Y2FhQ0JzVXVyd2VvaUlPakZvTkY1Sk1PZVFnQ3o2U3dEOG5JWHBpRFdRdmpl?=
 =?utf-8?B?WjlIb0g0QmVMY3RaMko0MlhzeDc4L0VsYVRNN1F0aGNYWW83RGM0TDg3d0Rm?=
 =?utf-8?B?QTIzdWd0SGp3TU1tdkpGT0phUkJ5LzhjbXNmTHVnR25ISDkzd2w4NFV0VFJl?=
 =?utf-8?B?WG9XOWFSR1VyOVphNUs2cDNGQ3F5TkJmclYwK3d2WEtYMFpzaWlPZHFqZnVi?=
 =?utf-8?B?YW5meDBXRWF5Z0dwV0tPeG0xK3pyaTRiSUxGT3BGN2E4S2lhVTByMHJBVktj?=
 =?utf-8?B?TG44Ky9sT1FBMUxBNjlCaHJKbW9hUFlPZVp5VFZVU25MdFBrL09lODk1WnpG?=
 =?utf-8?B?YXhHRzZDeHJPN2FabUcvSzdENVpaRXhyc01PcDlxTUx2OVI1Q05NcFBmK1k4?=
 =?utf-8?B?SUgyVnRtQnprVXhJY0pLVWJ2YjhNK3BnQ1FHUGlCYlM5UDRQcWUxUktweTBm?=
 =?utf-8?B?eXZZNWk3WGhnOExDWkpSRkF1TVpzQTRSNkJpM2NKYm5pU3BiN2ZtRE81Z0ZW?=
 =?utf-8?B?NUM2anBJVk5sVFFuU200YmVobTF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6225102D91593F42A8C136861C74D5D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ee4447-8ed1-4192-fac8-08dda4cae40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:22:27.2435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMLVubIN92fcUBqtV8f9vTpcPH5X6beuwauiwJ0C+HpwCe8cOJ10m4vEAUVvoHCNZBPoX8pYsrW5exJw4z0uJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6764
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA2LTA1IGF0IDEwOjIwIC0wNzAwLCBzcmluaXZhcyBwYW5kcnV2YWRhIHdy
b3RlOg0KPiA+ID4gwqANCj4gPiA+IMKgaW50IHByb2NfdGhlcm1hbF9wdGNfYWRkKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LCBzdHJ1Y3QNCj4gPiA+IHByb2NfdGhlcm1hbF9kZXZpY2UgKnByb2NfcHJp
dikNCj4gPiA+IMKgew0KPiA+ID4gQEAgLTIzMCwxMCArMjg5LDEzIEBAIGludCBwcm9jX3RoZXJt
YWxfcHRjX2FkZChzdHJ1Y3QgcGNpX2Rldg0KPiA+ID4gKnBkZXYsDQo+ID4gPiBzdHJ1Y3QgcHJv
Y190aGVybWFsX2RldmljZSAqcHJvY18NCj4gPiA+IMKgDQo+ID4gPiDCoAkJZm9yIChpID0gMDsg
aSA8IFBUQ19NQVhfSU5TVEFOQ0VTOyBpKyspIHsNCj4gPiA+IMKgCQkJcHRjX2luc3RhbmNlW2ld
Lm9mZnNldCA9IHB0Y19vZmZzZXRzW2ldOw0KPiA+ID4gKwkJCXB0Y19pbnN0YW5jZVtpXS5wZGV2
ID0gcGRldjsNCj4gPiA+IMKgCQkJcHRjX2NyZWF0ZV9ncm91cHMocGRldiwgaSwNCj4gPiA+ICZw
dGNfaW5zdGFuY2VbaV0pOw0KPiA+ID4gwqAJCX0NCj4gPiA+IMKgCX0NCj4gPiA+IMKgDQo+ID4g
PiArCXB0Y19jcmVhdGVfZGVidWdmcygpOw0KPiA+ID4gKw0KPiA+IA0KPiA+IHNob3VsZCB3ZSBj
cmVhdGUgdGhlIGRlYnVnZnMgb25seSB3aGVuIFBST0NfVEhFUk1BTF9GRUFUVVJFX1BUQyBpcw0K
PiA+IHNldD8NCj4gDQo+IFRoaXMgZnVuY3Rpb24gaXMgb25seSBjYWxsZWQgd2hlbg0KPiDCoGlm
IChmZWF0dXJlX21hc2sgJiBQUk9DX1RIRVJNQUxfRkVBVFVSRV9QVEMpIHsNCj4gfQ0KPiANCj4g
DQpyaWdodCwgdGhlbiB0aGUNCiAgIGlmIChwcm9jX3ByaXYtPm1taW9fZmVhdHVyZV9tYXNrICYg
UFJPQ19USEVSTUFMX0ZFQVRVUkVfUFRDKQ0KY2hlY2sgaW4gcHJvY190aGVybWFsX3B0Y19hZGQo
KSBpcyByZWR1bmRhbnQuDQoNCg0KQlRXLCBpbiBwcm9jX3RoZXJtYWxfbW1pb19hZGQoKSBhbmQg
cHJvY190aGVybWFsX21taW9fcmVtb3ZlKCksIHdlDQoNCjEuIGNhbGwgdGhlIHJhcGwvcHRjL3Jm
aW0vd3RfcmVxL3d0X2hpbnQgLmFkZCgpIGZ1bmN0aW9ucyB3aXRoIHRoZQ0KZmVhdHVyZSBtYXNr
IGNoZWNrIGluIHByb2NfdGhlcm1hbF9tbWlvX2FkZCgpDQoNCjIuIGNhbGwgdGhlIC5yZW1vdmUo
KSBmdW5jdGlvbnMgd2l0aG91dCB0aGUgZmVhdHVyZSBtYXNrIGNoZWNrIGluIGZhaWx1cmUNCmNh
c2VzIGluIHByb2NfdGhlcm1hbF9tbWlvX2FkZCgpLg0KDQozLiBjYWxsIHRoZSAucmVtb3ZlKCkg
ZnVuY3Rpb25zIHdpdGggZmVhdHVyZSBtYXNrIGNoZWNrIGluDQpwcm9jX3RoZXJtYWxfbW1pb19y
ZW1vdmUoKQ0KDQpUaGlzIGlzIGluY29uc2lzdGVudC4gSWYgeW91IGFncmVlLCBJJ2QgbGlrZSB0
byBwcm9wb3NlIGEgY2xlYW51cCBwYXRjaA0KdG8gbWFrZSB0aGVtIHdvcmsgaW4gYSB1bmlmaWVk
IHdheS4NCg0KdGhhbmtzLA0KcnVpDQo=

