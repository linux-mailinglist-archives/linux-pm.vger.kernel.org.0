Return-Path: <linux-pm+bounces-42254-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ClHD9sSiGm9iAQAu9opvQ
	(envelope-from <linux-pm+bounces-42254-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 05:36:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C7107E0A
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 05:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BDB300A60C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 04:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB0287505;
	Sun,  8 Feb 2026 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZuvVTeb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CD1A2545
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770525399; cv=fail; b=IAaF/7HW+MasrErR6x8RgqVwXQe0ETU9caJF3KiKKdnI+BxtwJXJvm7VTSO18j9nUZJSYCY6AOUr+pKFhYD2CluQLHtbBVc2d/9lTR9w9ly3UEJ+mve2ZDr4TAjUKNGbXh8X5sE9pNoVXGYmQd9zlbXjf1a/Wig4dsq//w7qoLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770525399; c=relaxed/simple;
	bh=MHdv+eboO4oXstXdFZ43xGtL1AubxY7oW7FNyC17Ebg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVU0VGj8UUf2+BfKd8BAIXT6uZaJcJ6TfvC8GEUIX3UxVmGBPwiVSZK+YZj+gWFio0tJeSnlUNoBg4sm+YaclCDsRLOggHRVpBydnIM74NY3XBgMsUpBgQCX35kKPcB8Xy4CBE3r3lifIQzBRDmmT1NJbeJ6O9keZxICuCcGGjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZuvVTeb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770525399; x=1802061399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MHdv+eboO4oXstXdFZ43xGtL1AubxY7oW7FNyC17Ebg=;
  b=YZuvVTebF7UPh8YIldYAL2dkXVoCpgZQ7ERpHVZ1Tep7RRmXLodKH+6k
   sl7rcJ+XgY5JRK79ykaRy0p1W47xSBkoEn6XjRFkHM8Hy4GzaZ3E0Xxkw
   7lb7qRHS3ROvhAOCK5dnSHM9F6RayyyuKYAMu9pD1zef4pcZGgr4uljbW
   ZgAv9tGybsfHVb0WbhtiHZZYhrRBtPI4mjTmbuslylXyfFUGGpvP+b3x+
   FVkw7yhHx8J82J7nbgxOmlUavk8hR1VzBtiCm+SdgaBZ0HRoNQF4BSuT+
   7nSulNM0kSr+2DMwgWauHe1FHSXg+mwId8nup+A5vyZMxRIeRQQidrBCU
   Q==;
X-CSE-ConnectionGUID: cNVXOQ0jTkeIxYmhmPfEZg==
X-CSE-MsgGUID: 2Ly5ZwE/Qfai+VpugUaOPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="71862775"
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="71862775"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 20:36:39 -0800
X-CSE-ConnectionGUID: NuoRmiqhQ46cpnywIYJ8hw==
X-CSE-MsgGUID: U5v3J1mwTiW6JXllvMh52A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="210474436"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 20:36:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 7 Feb 2026 20:36:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sat, 7 Feb 2026 20:36:37 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 7 Feb 2026 20:36:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJlkCVqJPwvf0hbBTzHtc48hzVBdl9Dwt1GbNZ56c0aEjx5s+G2AQNOJumXPZJx5OETkrbcz7/wzFDAHC21AbvRis/1ogvpEkcQ6gOT7BVNk332TQBIUy80Q+OLYgxMHS+DJ6kuzu8OeBT0O68y1EjBrBP0Q3cul1jFSvqGrkWRlfWR4ZbHivpIoAq6DFDADQiXbPaY1fX95xd9Cs08dhGqukpIu3QK84InteaIk8gRbwebWgFrsJUcymonQUcBhYi6ZxnGOU09Hq9Bq4O2OEBej+WtejOhRTgN8hFhSJ8KntsVv8AApjwANqTLouLoCQVjjyrB7I4CtqypAvOGGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHdv+eboO4oXstXdFZ43xGtL1AubxY7oW7FNyC17Ebg=;
 b=vylBT0B+TLuaStI5uC+2yNPjvaXBW5wntX9CIWVDO50HW/rc9BXcIoCXYeC0/YdnBmJJE17nofWp0xgsr1IWoNRgI/LYr6uOfjBuiBXN3wDj3yG4PGYovSVrF5/kHvyXN2O2xERxHdWQ4RizWk0d6WhFaKebzVWs0bj3kBx7sg+dHj7W4mrfFm0f/do7NpxlmCu/8p//NvEEV6FW/PZe13hZtfED0U2+339SaZBSYKYuX465oHylFyjBhigjAg/pvyKiYPbryjz3YThFJcFDn8uMtmp5O3agkbVBWHpmHmuguZcfW8ws/cy4sKbwBsCGxOQ3FKTeNcUFBGNBjBweHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DS4PPF990BCE628.namprd11.prod.outlook.com (2603:10b6:f:fc02::3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Sun, 8 Feb
 2026 04:36:30 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%7]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 04:36:30 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "trenn@suse.com" <trenn@suse.com>, "jwyatt@redhat.com"
	<jwyatt@redhat.com>, "jkacur@redhat.com" <jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH 2/3] cpupower: Fix memory leaks on early exit paths
Thread-Topic: [PATCH 2/3] cpupower: Fix memory leaks on early exit paths
Thread-Index: AQHcmEiWcdTY6LiW9kKl90RZc4IB1bV4OEjw
Date: Sun, 8 Feb 2026 04:36:30 +0000
Message-ID: <LV3PR11MB876872174E5323B108418471F564A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
 <20260204052143.3281063-3-kaushlendra.kumar@intel.com>
 <7280c837-0c2e-4faa-816f-a30b8215b285@linuxfoundation.org>
In-Reply-To: <7280c837-0c2e-4faa-816f-a30b8215b285@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DS4PPF990BCE628:EE_
x-ms-office365-filtering-correlation-id: 410cc0d7-158e-46ed-fb67-08de66cba123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NTVnRk9SSU5LODE0c1BEZ3JmdXZqaVJETldtL1p5V0wvaERtSTdMMEV4V1NF?=
 =?utf-8?B?K0JSU1V2VXRRVXZqS0trM05LWVo1Z2x4RFhMYUlDeXZ6TElGZURvSEs2cjlh?=
 =?utf-8?B?bmRQTXhkdTRtQlkzSW4rWkVtWW1aMDFNTm1vTDJTcDlObC9JdStBVEtvcmdq?=
 =?utf-8?B?QmJsV21sS3pRc1NZV0ZhK1NJUzlveXRjU1pSWWZiZ2RDczhNK2MwcGZKNWpq?=
 =?utf-8?B?M2lpblYwUThMUHB4UjhLZEFSeGFTcklNQmVXaHdtanZoU1lpZFc4SzBpTXlx?=
 =?utf-8?B?ZnRwN2FXak4vV0FHZEZUWHBJM0E0dDdHencvZWFhZGxlUC84cUJ2SU1wMkM2?=
 =?utf-8?B?bzJmcjBDWDVSSTVhaHdEVmNPOStMejhwZ2VkVk5qbis2Tll4S01PTm42VnE3?=
 =?utf-8?B?VElmSWhieTdTYWJQWnlrSHlRYWQyZ1hYbFdkWnhubFg5ZlhuaEtlb01rOTlC?=
 =?utf-8?B?R0M3LzNFNGU3YVhoS3pkNFhpNHFBWkhzTnpZeFdnaldtN2J4cUgyNFd4MEpQ?=
 =?utf-8?B?OXM4TmdvV2I2d1ROMUQwb2p3bEthWlRVbHVlUS9LVGVqaTZpcjBFMWM3VDRT?=
 =?utf-8?B?dk5NZ1NMaFJpMWQrcHJ6aitIQkcrd3NQc2JEc3BsU1dLQm9SM1ZCc05DVmtp?=
 =?utf-8?B?eFNBQkJpeWV1WnR5bnd4UXRLMjFiR2k2WU9Yd1IyaVoxV1ZldXJSdDE4bjAx?=
 =?utf-8?B?bCtFbVFpV2lvQjdMQUNFVGE3OHkwUUsxUlVqYWxaQ1ZBNmRDMk1yK3NmL1h4?=
 =?utf-8?B?SzU1MEYxUGtBTC9XeVJvTkxPelI5QmlxYXVVYVMzcjdCSDhHRWxnL3BweEhL?=
 =?utf-8?B?aVdUaGV6cW1YRm9Rb0lZN1RqYkhrL0xOb1ptY1hSWUZBeGJjSzlmKzhSNElV?=
 =?utf-8?B?ZzVoWVQ4TS8vNm1xVGdhRGg3YURDczNjSmV5YnlhUzJXbVZpbFgrYnJXMElZ?=
 =?utf-8?B?NUF0YW15eExSMWVLUy9iM1ZHcEN1aTY4cVpOeGZWM0toY1JPcytlYUxWMkN4?=
 =?utf-8?B?ME83UXpYbFUrMUUvOTJWQ3NCbkc0SXBKQ1p3aklIV3c3Q0FrNmE4MVBKczdw?=
 =?utf-8?B?U0w4NGFseW9XRlpiSEQ1K09QSXAzQ2oyOG5VTk0yNmlJUXY2OUc3YUJFbmhj?=
 =?utf-8?B?OHpzZVZpc2o0bFp6SHdIOHpsek1TWjU1RDQvN3BYb2ltNGlBWDJHc1FkUmZL?=
 =?utf-8?B?cnppRVlEczdCei9zbHlQQ3VSam8yNGRPUXRuemw1NzlhTElTQlM0ZVhNUStI?=
 =?utf-8?B?UVoweDRDYlFLV1I3YWE4MWRWcXFmWjZURGhDaE1ub1d0d3VLbGd5NUo3YWUr?=
 =?utf-8?B?bFZhODM1VFhHRFhOS05TUnY1di9udDNac2N2bm5TVzVpdGdnbTMvckNPR0J1?=
 =?utf-8?B?V09xdElQdGpEZVdaMVdWU0l2aitrODdMQk9DaW10MktvT2lmU1A4cUptTEFK?=
 =?utf-8?B?WXRSNkhmUkRIM3lCSzc1YmhjZGRlS2xHSUpGTkZTQzhleW52aXdMTWVDOWl5?=
 =?utf-8?B?WVFxYWROcE91aVhXVGZnejR5d3d6eFJtMmM5cFB2N1ZCSzZneEpiTWcyZlVx?=
 =?utf-8?B?R1RuODhGcytLSzVUSmp0ZHhIdDV0dTI1TGZaL1p1QStxODhzRjQzZlhmZDln?=
 =?utf-8?B?YTczUkdiWnBic1A2RXBNMmUxOC9RWWt5dDlKSHRaV2dPWXBoVUNocUdHM0ps?=
 =?utf-8?B?T1g5d3lYQmFzTHV6a1FyQkd2SDhKYVRtRlVXQ1JxdC9nbER3V1ZDV0hOcWN0?=
 =?utf-8?B?RmEwVkRoV21zNUdHU0JBMERsaW1SNXhnZFRHTlRRYUd5aU5kOVZyaEg5WVEy?=
 =?utf-8?B?V1EvaFg1Q09NN29UY0tPaXNiYjFLVktZNXJYZjgxNjhiNmFYNWVVWnFvRzQr?=
 =?utf-8?B?ZTgxcjRMMGlKQjArSkN1c1Z3VWkwREhrSFFsd3pKSzRlU1QyMGZVU3h0QUNV?=
 =?utf-8?B?RFFOYkEyQU41RVVLa3hjQ3cvK1NmUVpZRkxBSCs5bm85dm5zV2VGMDJxazhB?=
 =?utf-8?B?KzkwTHcvZ1RwdDY3NmhHMCtzamV4OXBUMkdEUjNUb0VDbVl6MDIrVTc2b0lZ?=
 =?utf-8?B?a0FXRTU1bWVmbVpqb1dDVGpKeG8rUHBMQ3pBNUYzUEdkVGNZVTV6SEhaWFV4?=
 =?utf-8?B?UDRlR0IveTFjc0FJNUovcXc5b09DQXRNMGF5RktIMzRmQUNvaDBTT0JsVEIz?=
 =?utf-8?Q?ubv7AFeT3LlAhFRGuxqUmxE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXlnd2wzZkpMK2poZzZWbGhXQTN5Qm1mRVFwUy9taldEMnJBbFFLbWtGd0V0?=
 =?utf-8?B?MGdxK2tnR1NaZm9LVDVaM1RxZGNSTkpxYUpCcGMwNUU4QW1UM2FRa3plWDAx?=
 =?utf-8?B?WjRUaCsrSk1PSXkwSUVVYXFpU3NmNHFhQUw2cWh5Uk5QU3ZiRk1JR1U3QWQz?=
 =?utf-8?B?clRvNm9HTDN3Wno2MjBaRWtEQmlmeDUybEg3K0FYYnU1WURBaGV1Zm8reHEw?=
 =?utf-8?B?OEQ5c1BrTVIxSDBSRExQV2JsMHN2LzZGa204eEFJNWpkYURTR0J6bHdDWmVC?=
 =?utf-8?B?ZTRkNGxEUGp1ditYcDdnRWk3Tndla1hjWHV0NHI1R0pZUkdZOWZGQ1dVR3Jt?=
 =?utf-8?B?Mm4zTWpjVm80UmZNRENFQ0EzdFczM2RaMm9Qdlh6V1FHL1FhTzdwZlU5c1BX?=
 =?utf-8?B?L1lac2REbEJKVTB6VUtMMm52czV6U2lRVU5hR1B1Zyt3YVdVUmNvM1EzTm5u?=
 =?utf-8?B?RXpzVE9NVWRTclM3MFBxMm9hbDJ2YmdrRS82alNNa3hnN3dhcWpNdk9wM2VC?=
 =?utf-8?B?RVlkRXc2MTRjWVpJN1h3aWlINzlPYjNNVnFaamZmZGk0bi92YWdHeDIwSW80?=
 =?utf-8?B?cnhpem1Ma1NaSHdKZ29UTjdLR1JiclByWUROekQ1VlBhVURiUUp4TVdsNGZC?=
 =?utf-8?B?bFRjaThCdzk5WklvUnJLZnU2SkRQZStBbThFNlN3VDlCK2VSTDc4bW1NRDRU?=
 =?utf-8?B?QWpic0tiTnhpME5TQ25FMlkxSmdackZDUlh3ZjVuUkFyZFZRVjF4enJkSy9l?=
 =?utf-8?B?alZVcUsraHN5anBOekphbE4wL0NDZWNId0JaUnZVUng1TTJzbjVvNDJTVVdQ?=
 =?utf-8?B?ZWZPMDVCODY5MUE0ZEtVV2xUVVYyVldKRUxsVTdRMzFNQlB2M2NBNFVGNzJ2?=
 =?utf-8?B?MTFjSWtwVW9xcTMzNWs1MWwxOWo1YVF3bmZHZGZJUlJhMGZxSmxaaGw0WXN1?=
 =?utf-8?B?ZGRWSWcrUllXdmJTbDluZkQ3MFk3OGxJOVZPL2VIekZIZHI2MUJlQ0RJK2cv?=
 =?utf-8?B?QStadXh5YUlMREV6NERvYUxjbDN2TmdRZCtZY1JuMFhYNG9SeW9EMStxcGdS?=
 =?utf-8?B?Nm44cHM1aEpNNHpMN3doRFJVMTZuUWx3SXVGSThMb25ocmpTbkEvS2ltTXBm?=
 =?utf-8?B?bStQZUE3bXBGYkdDLzdkcjVmbVpZOG1nYzF1NGRDaDkwd29XeE9xN2hFWDRh?=
 =?utf-8?B?TUIreGhtY0xYTWRuMlg0dk0zTng5NVk4aUZqeTNSMU5MTWtKaDdZV3hFZTlj?=
 =?utf-8?B?OVpZeTY4WHpiUTlJSThsSWRhWFYvSUxFZVVxV1pqMzR2eVBzQ3NCb1Q1Mmhx?=
 =?utf-8?B?aStSSGlpVWtFYWpsVXQvditnbm9PY1YwY1NqU0FUb25OTFdrNTIvenlXWVM3?=
 =?utf-8?B?VlpmanBaYitPQU5wdWFQMm5ETkFRL1doZHhBRytMK1B2UVduU1pRQlZpSlYw?=
 =?utf-8?B?S2ZSbDd4VHFjdktXOGxvdTZrWFdRWVJPM0FFOUNXeHhLRmRHOGhTTTY3VytE?=
 =?utf-8?B?bUlsMFRuUW5ScVpmeWtHVXg5RWVDUE9YSHQ3UnovQlBDRHk5QWpSSjBXTzNo?=
 =?utf-8?B?eFlaMk1XY21YK253am95c1U2OWJkRGJjVm5LRC9IVWF5RERVd1dVV2xmSWZ3?=
 =?utf-8?B?R0FkbDE5VlhqZUUwNDRKQ25OU1lac2tOa1lIbkY0Q0hkd2M5YTRKdVF3TFgv?=
 =?utf-8?B?MDBXR0JMbGlCMG55YkoxbTBkbWgrSHZhRk0wVnU5UW9jQmJDNHZEMlFUd08v?=
 =?utf-8?B?S2hKcEhZb0w5d3VFekc5eXJNbWp1c0NqZmtuUzhSMEY0MWEzK2tKMkRISldF?=
 =?utf-8?B?Uk9jZ3BmN0w1OTFHN3c4Ty9rb2tzcW12d2RUU1hmSjRzWTVYb0ZqVjhpNFVY?=
 =?utf-8?B?RVNweWtWV3hqblk5VFR4SjRqOFFkNU1NZG9qL2QrR3luTkJkZ2FKN2NLRXBt?=
 =?utf-8?B?WUJ6emZtVVBwaVBJL1haTlVBZmlLKzBnZktSeHNiN0ZhMmthNm5Pei9hVEpV?=
 =?utf-8?B?Tmlzenc4TTFPcHNJcWhsV09SMzZYTDNmQ3N1MjNoR3kyZ2k4dmxvYVZaSHZQ?=
 =?utf-8?B?TFRWSWRqOG0zR0pLMUs0TzZVZDFtS0NIZ0xHbXcwNDN6N09GajFhRkd0VUtS?=
 =?utf-8?B?c0ZSMWRwR3lNMFlkV0RhQXJYRFVwc0VtbElkVVlxNkxzNFFrcWJqUUl5QW1G?=
 =?utf-8?B?N2lXNzREaWcyeWJTRXNjMTBnV1RMOEhha0RJZ1poWThvdWlZRUFYVnpKaHky?=
 =?utf-8?B?TGRzMWYrYmNHOFovNFZaMzR3U2RDdk9oT2hac0NxWk1lV0s0L0VWbVJqclND?=
 =?utf-8?B?ZXk5VFk5cjBRQUx2blk2VWZxMnlvbHF0bUNWTU04TWJiMjdqbkx1cExKbVJJ?=
 =?utf-8?Q?vLZLOVtVTo3DJbFUWudUv1XOG1t5EhhA7uo6ZpddZp3/D?=
x-ms-exchange-antispam-messagedata-1: qXIqmQ4Zo6V+TLRO8t4jVDZUHuXTrRmhE8Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410cc0d7-158e-46ed-fb67-08de66cba123
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 04:36:30.0572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xL4v3Z04DC5vNMktVbe5eJNCfJaesGW6CFEinvxrynMBcq8ytxO6P5juSpcDyUGIdJQKaHifInqjbRY7fFSXEOfJcmGDGm/PfrV6bmX1k/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF990BCE628
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42254-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,LV3PR11MB8768.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 883C7107E0A
X-Rspamd-Action: no action

T24gMi80LzI2IDA4OjE1LCBTaHVhaCBLaGFuIHdyb3RlOg0KPiBPbiAyLzMvMjYgMjI6MjEsIEth
dXNobGVuZHJhIEt1bWFyIHdyb3RlOg0KPj4gQWRkIGNsZWFudXBfcmVzb3VyY2VzKCkgaGVscGVy
IGZ1bmN0aW9uIHRvIHByb3Blcmx5IGZyZWUgZ2xvYmFsbHkNCj4+IGFsbG9jYXRlZCBiaXRtYXNr
cyAoY3B1c19jaG9zZW4sIG9ubGluZV9jcHVzLA0KPj4gb2ZmbGluZV9jcHVzKSBiZWZvcmUgY2Fs
bGluZyBleGl0KCkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2F1c2hsZW5kcmEgS3VtYXIgPGth
dXNobGVuZHJhLmt1bWFyQGludGVsLmNvbT4NCj4gDQo+IE1lbW9yeSBnZXRzIHJlbGVhc2VzIHdo
ZW4gcHJvY2VzcyBleGl0cyAtIHRoZXJlIGlzIG5vIG5lZWQgdG8gZnJlZS4NCg0KSGkgU2h1YWgs
DQoNCllvdSdyZSByaWdodCB0aGF0IHRoZSBPUyByZWNsYWltcyBtZW1vcnkgb24gcHJvY2VzcyBl
eGl0Lg0KDQpCUiwNCkthdXNobGVuZHJhDQo=

