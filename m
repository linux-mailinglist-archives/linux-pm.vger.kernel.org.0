Return-Path: <linux-pm+bounces-11416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423D193CE52
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 08:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0D31F217E6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB155FEE4;
	Fri, 26 Jul 2024 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eThaiRD2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08AE57E;
	Fri, 26 Jul 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721976749; cv=fail; b=SQIUIf/k5JkKeMHos5qMyO94ZFhXVBnyxQIajvlAAnoQFwCWzzwbX979v1+KlQNDXMQdPvTvZWnjztd6EmJ/MoK9wfjcN4DO/l0weIdjTMEvnC2iynPZnzh9FEQ8eEO3nxqBC4o88ltbEC4ZhvZO4xQKJ3FyHGWKU79FB1+UxAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721976749; c=relaxed/simple;
	bh=1H2yrA147UEHUmkGGxk2dhy72Ql1gbepPntgV/mkiTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VthVNoI8vblsRz8mBY4+9igk/89PiyJfhZHPtTaPWkBdFbAzKvO/raae5xyIKFmfMeKFuvG8CmSahjQuQIb+txbi8swILAvkxTR9ilSzUJKMP/b0HTgpCmDJsiaQTvKJxDgLXEFO3NZ5xmimdieBQJFrL940CU4npKLqDaygtTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eThaiRD2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721976748; x=1753512748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1H2yrA147UEHUmkGGxk2dhy72Ql1gbepPntgV/mkiTA=;
  b=eThaiRD2Zi4yWC/BrtRktVOsRtdQsgjTyBaU0M1LcWvJTZWNAciE6woT
   ovq9sVQoH3o9sANuSrxanr/jm7e1cT0ImbasNXAJdaF//OB0PqtnSsbXx
   VFEJY9wIImDmyyGnR/RvTqXq5MF4Zf/BZ/zZkT9XcA6/o3F1MXTi2xGS0
   AwvJO6AD7EU5Dh0CYBgFEABKDtl3ACGrU69eAUhfnoHbIOG9GaZS5lXyt
   IoW+Bm8tu/N1obGdZ9cjcv0Rx5T+fziYkBr+9R1AkCHhEO9FFegejbu9N
   Dk8g7vo5eV7JQGIY6VGMaW0PKz79AKPDW4r76FHN951yQfUBT7a5FHgIr
   g==;
X-CSE-ConnectionGUID: 5vHBA8feSly4dzcMIKCSOA==
X-CSE-MsgGUID: B2gTR7wWStaI0qFVaekBFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19715983"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19715983"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 23:52:16 -0700
X-CSE-ConnectionGUID: NVl7S11xS8q6QJ2WW0I+pQ==
X-CSE-MsgGUID: lO4TWXQQR3O0VjdpwHHUBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53096833"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 23:52:16 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 23:52:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 23:52:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 23:52:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSuNmREVX+NsEvHlCWU7EZ+DW+Hl9LKChUD7vlQffqNFl05VHaeRTvk7OGqU2Sq7LP+FMsTLsyuqEXQSvGvz/psbIeyS+4c35g8BWGJPVCEy/cvLnXROr5ETpG4wYj3Klzt6Puj+llHH/NTMXlHFm+oCYVQawb5NXSsTbPCBIKIk+cQsPR/qp3j/5/gpnqMjb1iDMjyNK4yqo/nJ8PxM7R3RGqQvof0GxaBr71wIZ4LFQzQrYun3r4L3hrf3Jee7MkzGV6KuomqIiVA+6xBic4/Kd/zYMHZSu8uO9TchSCLXOYWFLtDPvZwmVV3xQ35G8i8Xbtrj/rQIaGgZMM3Tug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H2yrA147UEHUmkGGxk2dhy72Ql1gbepPntgV/mkiTA=;
 b=wdW8qDH34hGjkvDaMJy98tBjprHmkMkp0bR6HUmKwzwMImTJHfA6ETfJRng8m4XG3+eOeNcV+jejEdUH431tAz9fQ6z1CtVVsmrS1DGSKjGbr1gadUvhiOX4/oGq0D9q47d55R33CH67SkY+VdR8Csfb+iFb83X5UeXaPBKmJ8xfCh8pBr0uUFyeLj8goPHo1mu5chszu7ptKmzY1t4TNvA41BA/lYoe7PZdoGUIVUNowqzf/502BvVZ/3ImfWyctTZzS9mlIvUk7Ryb3CzxvqTBS3vQiBKjaPUV3AIPsKw/ttMuOOUh8FtSSQqPUSgM1HUNTkFHmF7RUZZIOVn7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS7PR11MB7907.namprd11.prod.outlook.com (2603:10b6:8:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 26 Jul
 2024 06:51:55 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 06:51:54 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
Thread-Topic: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
Thread-Index: AQHa3yYADg47xNnD9ESjcTXoQSGHhbIIkkyA
Date: Fri, 26 Jul 2024 06:51:54 +0000
Message-ID: <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
References: <20240726062601.674078-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240726062601.674078-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS7PR11MB7907:EE_
x-ms-office365-filtering-correlation-id: 284da12d-ad7b-45f5-8d12-08dcad3f6fae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejMzZHpzZXNsSG9sdHFnM1h4VXRpbzBGTk9Edkg2dCtRd3QzSGYzNUs0SWRz?=
 =?utf-8?B?NVpZR0tZZVlheEtlWWplSmNyQm43RFJpSnpWTnViL0F1UWhFTkRTOEswdmVT?=
 =?utf-8?B?TXovN2svQVloRmxuRThrcjhSeWtoMDd2Y1hHazRrZTdwb2NhZmRNaDM4TGo0?=
 =?utf-8?B?Z1ErbDVUZTJYYlI1ekFIL3hRNGx1eWhoL2h0VE9ML1B2VVlwSTgyMW5BY0FM?=
 =?utf-8?B?SE1NZDE1WER5WU9oKyttcnZVYVVRSDBXMkpFaDVUblVYeiszdUdMYzRMUmw0?=
 =?utf-8?B?YVF5SVBXQ3dOYzRGZlZ0VUxFVzBtV1Znd0FsQ2puaWlQdE5sUkdZemE3SUhJ?=
 =?utf-8?B?TklvMVZvbXRqR1RkaDNML21VTFRzcGVQMW8rY3hJdVRPRHQwTlR6RnVjRWY5?=
 =?utf-8?B?cElyTTlqOWdXSGxjMHJYdTNxOGN4VHNrUjl1M3c5ZnhkSWpwTDc4SXdHUFFy?=
 =?utf-8?B?RXdwWXR1dGYzMHJqUGRKbHh3L3QzUHVEcTVOOVBYWlVlaHdCaG45aTdWMkY1?=
 =?utf-8?B?UjZEclM0Nmxqc2MwblFCWVp1RC81TWhnWnpsYzZZOXVJODdMY1dOTkI2aHVp?=
 =?utf-8?B?aTdvajZiT1hZUHJMMmxaTXpiZHFPQjBvRnM2WnlXN01yRDRhRndSclBIT0dW?=
 =?utf-8?B?bDI5MmQyVU1SN001K25vaWVJeFlINGN4b3QvWk85U21ia21MSkc1MnlrSDNM?=
 =?utf-8?B?ay8xTTkrS2ZNeENPUGhTbEVMYUlnY1pVTkdLL0t2NkM4MHlvMHBYMWh0Wmht?=
 =?utf-8?B?NXFLclVoM01GaG1EekJ4UXpqRllmQmVOM1RoM1JyTk92SnhDdHM0Kzg2OEZV?=
 =?utf-8?B?aUZEYmliVHkvQVZnN3FvMGZxOTdNdDh3alNuMURiZ3NkYStObnNTbzdVR1VY?=
 =?utf-8?B?OXpXd2NqQ1I5L2RsSkxzVllYV1FZSGhzNDFPT21zcTY3eGJHRjdWV0xxc1J4?=
 =?utf-8?B?aVY4NkZycGJBM2Rucm8wK1VKbTYyVkM5MHF5UkV4aTduWEE1a2JYN2hYTXla?=
 =?utf-8?B?bHFZam5YUUo2TnMyQ0tFMWZPL1FPb3YxbGpueThtMDZia1B5S2lMbzBOaGQ1?=
 =?utf-8?B?eU4xU2F0Rm1VTVNTMEhxZzNXTlVnY1dHcVJGL2N6cUZrRHdmLzgzR1AyZkJC?=
 =?utf-8?B?dDZzOUtSbzdnM1VJdWlBNnErMGtWdVFrbjJ5MzBkRjh4ZTBLTTlaWnluN2lP?=
 =?utf-8?B?VHZZcGM0bml3eXhLSGNJbUxNKzNDZmpHMUE2ZEY4T3Z1VWU1TUhiM3dwVWVl?=
 =?utf-8?B?bVlaZXZyT28yMitBbnBuejdkZDVUOW9qMFFuNUlDQjdhZGlyR0N3MHBTVTg4?=
 =?utf-8?B?YWNIZmhYYzJBdVlVWVRncjBPQ2YvMVpzclAxZU01VWJiRGZtMUJDWEx0b2E4?=
 =?utf-8?B?VmFHUXdhb1RCaXk0dkEvUVpydCtVby9ucG9VUHhPN3ZCdTBYSUpvUmQrSFQz?=
 =?utf-8?B?QVdBUUtPYVI1ZmROVkVQQzU1NldGT08xMDA0czdaNWpyanJPWTZqNVpncVVG?=
 =?utf-8?B?M2xQaTU3Z2hIRUZGSjhCcjNUQnJXYTVOd3lkY1R5TTNOdVBFVUhNRU9lOE5D?=
 =?utf-8?B?M3pYN0MwSEtuN0Y3UlF6a1hEMERSSWNFcU9vcDlJVGtNcUZmK2RHNTFuN0ZW?=
 =?utf-8?B?UHUzVk43U1dkb3NBb3E3MGVZNWdHaVRaVllyNEFKakp2eElwcVk5OEphbzV0?=
 =?utf-8?B?YUZZbW40L2toV0Y3bEFJeGFKc1NtZFhwU3RXOWhGbTFEQWdQRFlNR2Nrb3kz?=
 =?utf-8?B?QXBvVnMwRnBpVy9LcXlubWx6c3NuN1ZiY1NKUWJta0tIek5rcmxNaDNFQkhV?=
 =?utf-8?Q?WSdBus+8EtckVzmsam5uRrCTkxZxpeAuhu2pE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTE0cHlkekdpbmVPMlFrTDdaUlpHbWtldUh0eEcwNVI5WEFZK3BzUkxlTHZn?=
 =?utf-8?B?UjhWUUU4WkxJblQxb0o4d29DU24ySXp5MENTV0ZMNm9OL2Z4THZoYTJONHk1?=
 =?utf-8?B?RmhpeHdQTVFuaWtpNDNpbTZ3bHYzaVBtOWVLR0JWQ3EyK01LZ1Y2MXVZMU00?=
 =?utf-8?B?alZ5L1AwM1VrWmpTTUZZWWZtZ3JYLzlvU0hYWFlId2tJeFI2QkxOenBjN0Zq?=
 =?utf-8?B?Q0lvQWRJUTIvdC9FSmI3OTdMZmJNQUt2RHJ4TURlMlZ1L3RJODdOeDBTbVQ0?=
 =?utf-8?B?NVVoS1cvZGRDYm1nTTY3cHBsUUVsaTFTY2dsVnBpc2dpRUJvTFgxcFNVN0lS?=
 =?utf-8?B?ZjhWall3NEZ1Z3htTU9TWkg5YUdCSkMvR2JCSEdBU2lqL0dXVUVJV0N2TWhM?=
 =?utf-8?B?NEI5UTlXUGYwVGMrNEZsUEVVRmdVRjJUb3NjSzNYWVNBN29PRXQwa3ZIU1Fw?=
 =?utf-8?B?VUQ0VHU3MjhzRXA2QmtvL0E5UjRjVkNZV0VNaHBMNXVhOWI2Znk5SWZsOGhP?=
 =?utf-8?B?RVlNQ0lJcDNBazdQdWZwMWVuM0Q4VWFZV3FpYUR4eDZTRDFZZDMwaU5CSDRm?=
 =?utf-8?B?Syt1WGd2V2ZFZkxUVlBsSmtRK3pvbVRXNlFmYTlBTWc1d2tJcVdiQmlJSitE?=
 =?utf-8?B?RXkyMTc3NkV3aDE1aE80YnVVK0V5Vm5QZDI5MnZXUkNmemw5aVRhUVpNZzJB?=
 =?utf-8?B?allGUUdrVEhubWU0ZThBcHdrRWdqRENjOHdURlR0MmZVcEp5cGR5aWhFdzN6?=
 =?utf-8?B?dlJmaldaOFZpVHNmRUZPRHlKMTJ3SXN4REhYZWljRTV4b21DblYvTlZPdkdZ?=
 =?utf-8?B?WTBtc2VqRjdiamVaY0FSdGVVMS92UGZRaHNPZFZidWVzTXlFZ0pXTkdaWHFi?=
 =?utf-8?B?U0JQWktWZTNteTAvRlNGbjdlOThSSmZRcjZLd0ZqbmxjZWFPT21NYkdhdlF5?=
 =?utf-8?B?L0xtdUlBMklCeDdDS21vVVRyVmQ5U2RRYXhFTmlLd0ZXUXNvVUpxMW1GaHhp?=
 =?utf-8?B?a0tDZFlTeFdSNzlta05GTTl0M2JGTE1YZVRHai9KWUxUeVlzckQxRUVBaUls?=
 =?utf-8?B?bzZEbVphQ2xsZlZhclExL0orNmJ0YUcwV25PeC9jemxZWUM1TzVna0NsNDBj?=
 =?utf-8?B?cml5bHhIMVliMmlTb0t0L2NnRko2UCtLZjU5MVBadFg3QkIzbWFvMmRsL2No?=
 =?utf-8?B?NEx5NEpyVzhOai9YbDg3R2xiRTFBOTViSzZRbWVUeEl5TndoWHR0V2NOVFpV?=
 =?utf-8?B?NEo3dFRBZlR1UkJEalVHeW8vMm1lcEtiNXVPczhGN1A2UllPc0JsL09BaXVV?=
 =?utf-8?B?R25IcjV3dXFXSE9KZzQzZjRqYVU0dHdSWHRTMDFjS2hldXdvUURLSUMxQ3JT?=
 =?utf-8?B?NUZhaXV2cVhDdkU0WkNmQUI1VTlTRkZVOXFkLzdRMHRHekJKc1Y4VERhS0dz?=
 =?utf-8?B?NTFOWDg4L2Y4LzZaQlpNL3ZqWEZIVzhZU1BIck9MT2JYZkFXdyt4bklRZFFm?=
 =?utf-8?B?aHI0WEZLcG93eW4veTlQQm5PQitLcjZDcEZGd3E2VEllUGRSTnhBSkwxNEVB?=
 =?utf-8?B?cWxNSGJ1ZTBoY0RmTmcvYlpCMEl1Qk44cXJiaDczdnFRdVVyN0EvVmd4LzNS?=
 =?utf-8?B?VkVTdXJienk1TXdTdlVHTEV0U1BERmhIK2FUem1QblB3RWxsTTNHaEJwem45?=
 =?utf-8?B?Qnk1dUQxalVWTHcvb0xVS3VGWGpOaXVpY3l6dTlGalJZTjhTV2lGeUtTakpY?=
 =?utf-8?B?N0V1ZUZYYXhreklIWXZyVEc4NW1PUlRpbS9zM0tmR0hpcG5VOTUvdWdZeUF0?=
 =?utf-8?B?WkI5M04yVnJXWnN5a0J6eDluY1NOV284cXhTN2dqeUxyVk03MkJtVmc3UVB5?=
 =?utf-8?B?UmRoWFhIWmVOR0Uwb2duV0FNck9mTVprUmtZeE04V1NpYXVPbVN3Qk9SWGt3?=
 =?utf-8?B?cFpoVzJiRzhaUU1nMGdrSXBsNXBVSnVjTzZyOUpmME55czl0cjZ5VkdIRGk0?=
 =?utf-8?B?WGMydzVHa0tQRk52Ri8rUVhtakhoNTZDbmVGT3hKUEN5blpDU2xDYnVKYWtn?=
 =?utf-8?B?U0VqaE1tbnlPUjRSZG1iLzVVb3FzOHZTNzhpdUd2eU92VGNRTUFBQkxqaktS?=
 =?utf-8?Q?sIAqicnqDbd6lkrp1C+L2UQyq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBECF804E54DD5428511873D99FDCE98@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284da12d-ad7b-45f5-8d12-08dcad3f6fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 06:51:54.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lr15Uy+hQTP6nznSq1nshDxBMZ0EAtQuSuggiRstbBZqK0ITYTndAkwPPihxe4XRn7BpjJfvr9RQQfJNzEtRkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7907
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA3LTI2IGF0IDE0OjI2ICswODAwLCBLYWktSGVuZyBGZW5nIHdyb3RlOg0K
PiBXaXRob3V0IHByb3BlciBDLXN0YXRlIHN1cHBvcnQsIHRoZSBDUFUgY2FuIHRha2UgbG9uZyB0
aW1lIHRvIGV4aXQgdG8NCj4gQzANCj4gdG8gaGFuZGxlIElSUSBhbmQgcGVyZm9ybSBETUEuDQoN
CkNhbiB5b3UgcHJvdmlkZSBtb3JlIGRldGFpbHM/DQoNClNheSzCoHdoYXQgY3N0YXRlIGlzIGVu
dGVyZWQgdy8gYW5kIHcvbyB0aGlzIHBhdGNoPw0KDQpjYW4geW91IHNob3cgdGhlIG91dHB1dCBv
ZiAiZ3JlcCAuDQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NwdWlkbGUvc3RhdGUqLyoi
IHdpdGhvdXQgdGhpcyBwYXRjaD8NCg0KPiANCj4gVGhlIGRhdGEgY29sbGVjdCB2aWEgd3VsdCBz
aG93cyB0aGUgbGF0ZW5jeSBpcyBzaW1pbGFyIHRvIEJyb3h0b24sIHNvDQo+IHVzZSB0aGUgZXhp
c3RpbmcgdGFibGUgdG8gc3VwcG9ydCBDLXN0YXRlIG9uIEpTTCBhbmQgRUhMLg0KDQpzbyB5b3Ug
aGF2ZSBkb25lIGNzdGF0ZSBtZWFzdXJlbWVudCBvbiB0aGUgRUhMIHVzaW5nIHd1bHQ/DQpjYW4g
eW91IHNoYXJlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUgbWVhc3VyZW1lbnQgcmVzdWx0cz8NCg0K
dGhhbmtzLA0KcnVpDQoNCj4gDQo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MjE5MDIzDQo+IFNpZ25lZC1vZmYtYnk6IEthaS1IZW5nIEZlbmcgPGth
aS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9pZGxlL2ludGVs
X2lkbGUuYyB8IDIgKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRsZS9p
bnRlbF9pZGxlLmMNCj4gaW5kZXggOWFhYjdhYmMyYWU5Li5lYjY5NzVhMWQwODMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gKysrIGIvZHJpdmVycy9pZGxlL2lu
dGVsX2lkbGUuYw0KPiBAQCAtMTUzOCw2ICsxNTM4LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4
ODZfY3B1X2lkIGludGVsX2lkbGVfaWRzW10NCj4gX19pbml0Y29uc3QgPSB7DQo+IMKgwqDCoMKg
wqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0FUT01fR09MRE1PTlQswqDCoMKgwqDCoMKgJmlk
bGVfY3B1X2J4dCksDQo+IMKgwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0FUT01f
R09MRE1PTlRfUExVUyzCoCZpZGxlX2NwdV9ieHQpLA0KPiDCoMKgwqDCoMKgwqDCoMKgWDg2X01B
VENIX1ZGTShJTlRFTF9BVE9NX0dPTERNT05UX0QswqDCoMKgwqAmaWRsZV9jcHVfZG52KSwNCj4g
K8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9BVE9NX1RSRU1PTlQswqDCoMKgwqDC
oMKgwqAmaWRsZV9jcHVfYnh0KSwNCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRF
TF9BVE9NX1RSRU1PTlRfTCzCoMKgwqDCoMKgJmlkbGVfY3B1X2J4dCksDQo+IMKgwqDCoMKgwqDC
oMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0FUT01fVFJFTU9OVF9ELMKgwqDCoMKgwqAmaWRsZV9j
cHVfc25yKSwNCj4gwqDCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5URUxfQVRPTV9DUkVT
VE1PTlQswqDCoMKgwqDCoCZpZGxlX2NwdV9ncnIpLA0KPiDCoMKgwqDCoMKgwqDCoMKgWDg2X01B
VENIX1ZGTShJTlRFTF9BVE9NX0NSRVNUTU9OVF9YLMKgwqDCoCZpZGxlX2NwdV9zcmYpLA0KDQo=

