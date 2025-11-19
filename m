Return-Path: <linux-pm+bounces-38198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA1C6C882
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 04:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76C4D34EE61
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114B52E6CC8;
	Wed, 19 Nov 2025 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeyGFe1K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931A2E62C3
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521906; cv=fail; b=tr3GPsZ8MR7ndLmoy1824ALnVj80fhWL893WPicbnCnfvtuY2L0m3be7JUl14g9pZAiAAtxYdcpoX+/Lyoc37jwbStf+DqXEhRgw8bChBxbeCn0oBi85fhJKH025/zSqX1vl1nDSXw1G0hJeaZmvp0QJKFnXdOvxilZ4J0aRmVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521906; c=relaxed/simple;
	bh=wS4fZyuoKGvhJDZ2OxGvYGvlZbJKzwk52EIXs20BHvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qs2Ia2DMijFNW62V5H3eyvuGtfmMKKW885J2BsvuEDPQ59CqgnGo72+/okMsMZ1ouTwufco+k48EO7nEGvHMaCc4e3WtWucezW8afrjAq+E15q14C5peOMxNTVngzgEXJ0QrOppGxccOl3Nva8wqWBVWW7Wtooee6HpQVfOQWTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeyGFe1K; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763521904; x=1795057904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wS4fZyuoKGvhJDZ2OxGvYGvlZbJKzwk52EIXs20BHvg=;
  b=GeyGFe1KA+piUWkSIwS7DjBLgFvaTjrbnlZfitxIEyBtv/cpSuHgyqc8
   RHrZOpRoc4Yli1sCwp3BjKXVt2PvtuD2e0E1gk6/mLRf0NAJuAF4U7cF+
   c9y7TfhBkDjza2oMeAmRdKyE/X2MaVsEpaaQBTDs+FKjqPLiIw6MYeh6q
   +m5fbr0H0escb3wnQlSShvfndk3EK4dkTK5JxpiAGapvfaWnFsZY0hG6W
   1830ZCO1v4Ti1mCgOgWpNXuTGJZSrOboHNz7rg6pxX4qrcOmmcYtZh4+U
   a3l+U+QuX/gmq7fEIX578uVtxELlAjGSawoADiT0qPOMCwxHERk5enke4
   A==;
X-CSE-ConnectionGUID: rQDaLTYOQXCiqc164Mlbew==
X-CSE-MsgGUID: HYeHLRuSRpmXcieJwvE85A==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76908841"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="76908841"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:11:43 -0800
X-CSE-ConnectionGUID: QsSG7ccaSNaVPFq1NgAruQ==
X-CSE-MsgGUID: /e+V/9p/SUyrhDdzcHnwRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190723122"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:11:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:11:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 19:11:43 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 19:11:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrTmFAcVrS9hxiqjl6ocIws+MNJyU1tkmlAxkNMfdatf/92g3LIgG/e2cFQrqMiNfbjpLUKaL18Vvh3Bu7gpcFyqFFEt7GZDfik9DeOmlhrW+6Y7Fp5sqp+KnA8OCJbxVF3m6ZJWhTUC6yf7K7C9elCtIJ0+rrbZdDClibrD2U1b66Gg5DveNNRF6RNHMs9Uu1wIjZfPI9bERPyQKI0a60Dr9m+wy4pmsaANlrynL5P2qA/LNoQURTflJdsrUOlw2d0pdFh4B6zkjUmGgohvOiaoP06fr4pRYWjctj20xfwwIUxIvml6krVSDMMT3BCudxwZemEN//js6Kj8P1eGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS4fZyuoKGvhJDZ2OxGvYGvlZbJKzwk52EIXs20BHvg=;
 b=WUqgKBz+A/Dvy1E5AOZm9lQvb06SVzUF5UIhjgcteuKOy1qY7Br7g5du1LrwtMtdgVSXDTpRlAn9HM3GXCoWbB8/ls+vksaJR4fzmlDH8XqSkHFGHmBHsDJKD42H+2lejaETex5uNom943dJ9bw2EfkyAUxgpLP0cxYcn5nB23UuuA6OGpEb8IbNAGAdJrrI1urkblXyENDySsRjwLmorzEc9jsdwl4NCsL29IDYXH9qImlgx/9Jb5I2g/Dxj/ES1pgoOMFiZ8U75iW4qIZqaoHOZ+wELTRtlWfGA8qvxlSMr1xOHauzN6IseiLw6ngrj83Vme5OYHaQVF7J7Bm0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYXPR11MB8754.namprd11.prod.outlook.com (2603:10b6:930:dc::13)
 by MN6PR11MB8104.namprd11.prod.outlook.com (2603:10b6:208:46c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:11:41 +0000
Received: from CYXPR11MB8754.namprd11.prod.outlook.com
 ([fe80::2fdb:7424:4f94:3d8b]) by CYXPR11MB8754.namprd11.prod.outlook.com
 ([fe80::2fdb:7424:4f94:3d8b%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 03:11:41 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: ACPI: Replace udelay() with usleep_range()
Thread-Topic: [PATCH] cpufreq: ACPI: Replace udelay() with usleep_range()
Thread-Index: AQHcWJhK6ucuMLTh6EuKsY0E0lvLr7T5UUnA
Date: Wed, 19 Nov 2025 03:11:41 +0000
Message-ID: <CYXPR11MB8754DCA36A36FF57C418B31EF5D7A@CYXPR11MB8754.namprd11.prod.outlook.com>
References: <20251117161317.2426787-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0jojkOBXDxGkxMuctSr8opAq5edotwxqM-MnFOpDg_5kA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jojkOBXDxGkxMuctSr8opAq5edotwxqM-MnFOpDg_5kA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR11MB8754:EE_|MN6PR11MB8104:EE_
x-ms-office365-filtering-correlation-id: 30347eda-4212-4ae5-0c2c-08de27195c97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?c0p4U0JWa1J2c3Y4SzZLeEFhejcvS3RCREVmdVRxMnREcUlaa1B1OFEwQlVJ?=
 =?utf-8?B?bVF5b1lpaCtPanYzd0l6YmhqQm1oeHFDZm45MkV0QzdOeDN4aVZBRkd0a0lo?=
 =?utf-8?B?ZFJFVFBvWTZZZFV6WlIxTnkwNnB4bzBOaldpOVRtcUZmdzRCaTY1RW1sRnRt?=
 =?utf-8?B?OHBjaDVGM2k2WjFSeHdiWHFBT0cycEVwRWQrVTdMa29Fa1praWw1OVdGT1Ey?=
 =?utf-8?B?bXJKVEhCWlVQNDdwU0k1VTdBRjdsMU8vTnFMNElpajc1Tk9wRWo2OFhBZVhM?=
 =?utf-8?B?WldsWk9MWXk3Yk9pWTFxYnJmSHVUZDZQN3VlMHhvaXZ4clMrSXc0aW9LZXpl?=
 =?utf-8?B?TVJUa3hxN2lmZmxMdzJGR2pIbmJyOHZDN25Rc0VXV3U1Z2Q2K1U0WE5MT1R5?=
 =?utf-8?B?SXYvd1RMYjFVYTU5YmsxY09CQlVVVjc3OXo4NTZVNGpyT0Q1UVd2YVRpenhM?=
 =?utf-8?B?bVNLZjBlRmtKWXlNT1kxaFBPS1dWd1ZqSHIrSFltRVBQV0RJN1llc3Z1RFB3?=
 =?utf-8?B?Nk04NzRDQXVsQzV0K2FMWjU3TlFwOFk0b0FEYWp3RWY1Q0t0ejV0a0xEUTkz?=
 =?utf-8?B?d1hieW8ralpmSVhqS0QwQ2g0bTJrRGtjK1FUUmJ0NFgrMVBkby9LYUdqSWJM?=
 =?utf-8?B?QXBaTEM4VTRycS8wNElwOUxFYnpyalpOOTlEMkdRSGNleVpycjBFaytpbFpt?=
 =?utf-8?B?aThqTkh4akZPN24xTkZzTllUOHpsbmt0b3Vmb2gyR1hwN3hCM283aDNYbC9W?=
 =?utf-8?B?L043UEJSby9UN2ZOOTBSV2xCSHVFMmhjQmtrUnRLU2NORC9HcGw2aDNUb2pR?=
 =?utf-8?B?bjRaSGlLcFRWMURFUlFDaldKUTl6MnV3YWs0RHJldy9rZ3NXa1ZvL1Nmakda?=
 =?utf-8?B?d0JNQnhqVFVwaDFGbE1PU25yOTB4S3oxa1hOT1U2a3cxWkNkazFIbVZsbnhz?=
 =?utf-8?B?OUU0cHRNQlgwaUI1MUl2Y1JjNGZ3VkJIV1NWVW9HTzFGOVIzYWZucTFZQTA2?=
 =?utf-8?B?NlFGSDNHVFFRTVFQdHgzenFsOEloQkYxMWlwZ2FMS0h3NytTYUQyVzRSYWxI?=
 =?utf-8?B?RmxCMFFxWFc3WDdjRDJpYnJvWUp2anZoRkFjUkNhejkyZ0p6cXJzeEx6TU9G?=
 =?utf-8?B?L2R4Wnd6WUlvM2k4OURuVjZaZWx3RTNhNzJ6alBSc2paaHJvZ3hNYVJ0d2Zp?=
 =?utf-8?B?dDhnYno5cmtVUkZqVTEyU0VPNnM0Z1U2Z0dJaDhmbFlsd1J6YzUrQlMxWFdi?=
 =?utf-8?B?b0JwZ3g1S0EyR09aUjJzd3FQRmNGMkJmUEd3WGpTSkZFbHpDbE5YUnVzWmNr?=
 =?utf-8?B?REpCUlFvSHdJcVpJSmtnd1VyZGZIcVoxK01XUDV6N1pmWnN1MHVQbSs2WlJ6?=
 =?utf-8?B?c2t4Z3hKYWFMbm9hY2NKdjhNU2hBWXhKSlFpNGsvYkRkTklNUmxVbXFmKzJp?=
 =?utf-8?B?ZG41NWtLbVIxNnkzbGJiUHFqa21ubzdYN3dNV09zRmxvcHRrc21ubE5ERHlQ?=
 =?utf-8?B?V09wRXEzRGNpVmJLb0EzNzYxYk9tTnBNTUxoQjBLVE5EVUl3RFpMYlVhM2ls?=
 =?utf-8?B?L04yMVFmUVp1ZXBzbHg1NmJIYjdQZ3lZTVdsS01NS1ZJTEdpQXNvSC9uOW9V?=
 =?utf-8?B?akdlOUN1ajdPSlc4RHUxNzdYNWhqYWNTTFVJdFJwdXJhMHBJcURYanJaSDd0?=
 =?utf-8?B?UzJDSlJ3aC82dmZ1c0JMcjNzcitrZVVGbVJ2eWZ5MWpqSk9qS1NDT09maDAz?=
 =?utf-8?B?ZUVjLytCL25QYzdQZWZ4NWRKc2JFZTE4UnVhSlQ5cUJFMFBrWTBpY0g4UjZq?=
 =?utf-8?B?MTh1bThZYXRiQTc3K09iUWViTHdEM0tqQlBsclJJcnhMSUk2VUpMbUhiamFv?=
 =?utf-8?B?S2lEU2lIb1FEN1FpaHJqODhLd0lZcDlkV3dmTzhsbU5ZMSswVkRIWk5pdTM5?=
 =?utf-8?B?TllyWlBxbGtaa0xZTzZpdE9pR21sSWJsUmZKekwxd25MZ0xWODExaGlzVUpn?=
 =?utf-8?B?Qm04am92K3RJVmg0UEtSR1RyVUgzR1lNeFB6eDFaVnc5WlpkQXpvSVVFZWdL?=
 =?utf-8?Q?2QEgeR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR11MB8754.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHpvbFNZVkxXTTdOamwrSi8yQXAvdGw5M3dXcFkwQ1o3eWtTSjBaYkZjUTcv?=
 =?utf-8?B?ejIrL20vOEorSlJLbFJwN2htVndHcW55Nk1LS2hpcjV2MXQxK1JGL3VZSDZP?=
 =?utf-8?B?ZW5STWlsNHcwNW1uTjJObHNUYTBvQXFOZjM2Y3pHcGFjUm4yTUx2dkwrTmhm?=
 =?utf-8?B?b3RmajJMSytadmxYK0FWbzJlalFFREsyRHQwMU5aN2RTSUhRYUw0a1VxTFlK?=
 =?utf-8?B?S0x4Z29haVUyWmRxOHF6d3lSZUhhbXJ2ODZ6MkR6UG41L2VSTVM3MDJIdjY1?=
 =?utf-8?B?Y1ZDbXo5angxbGhBZnJ1L09vbWJneW5UTzkzQml5VWVLNG1uZGhNNzVHT0hJ?=
 =?utf-8?B?MFBzbHl6bU1rSlYrUitQUHpaOXBZRGVhY0d0TkZEZnBPS2NBZWR2K3ppWmIz?=
 =?utf-8?B?bndRZXd4OFhqWU1hY3ZDZFl3bXZHY0NzOC80NVRYOTFmZUZCV0dObnRGbkxs?=
 =?utf-8?B?bFNheEpvWFpUdW44SnpTUU0rVERIeWpZNStTdEUvL29CZ1VMaSsxN0hiMHBC?=
 =?utf-8?B?Z2o2ZkFIZ3hMcVpRR0FIUmNTaDlPcG5mNDlQM25MN0c4SVlzMm1XVW9iSDQx?=
 =?utf-8?B?M0N3M255VXg4YlZhK0N6dFRDZGVGZVFVeHVtc2Q4MW5HZlpYeFlxMW9JVSsr?=
 =?utf-8?B?bk5mUDk2VFZJNGRXeiswMC9oS3FsV1lqSWhRTmk1cGlLWHhzMDhhVG5Cby8r?=
 =?utf-8?B?UjJMT2xhWGlzVmNqcUMrM0F5bHpvZDRLYkJ3djQ1aTgzaGh2QWJKVzBnL1p2?=
 =?utf-8?B?Y25NRWlzV0FubDBBVFkxZ016d09idk5aVkxMbzJZb05Ba0lPTTc0elp4RmJi?=
 =?utf-8?B?MG1ySzJ5RlJqRlVwTnUvSC9ISGNiVFM3ZHgxWmphaWhRQWxNWFVpVzZtNUls?=
 =?utf-8?B?Ky8zazlCVE5hQVljUm5jdzNtNmRma1NSbVllamswUjBydDdLNG5YSHVDZWI4?=
 =?utf-8?B?Vk41TDcxc0JVdnh5QzlnUC9ZWS9TZHgwY3BnUWVWRFk4U2gyTDYxSEo1bUpQ?=
 =?utf-8?B?UXFVdU9MQ1lFdzNEa1loeFBUcGJrNUNIZllqTG9vZG5rQ1ZGQVYzTlNtK0Rk?=
 =?utf-8?B?L2RXZ2pIU3lEU2lpU2NEOHlnZmdwMTliL3Rhd2Zjb2t2bG5LVGlXTGZ1bTFM?=
 =?utf-8?B?RHR6NG1NMDNGKy9HMFBiRGw5SkR6NHFQSzQ5c1l5VGt0TmxLb0RSZzlacWRU?=
 =?utf-8?B?UTNSNlk3U29VVi9pZmxrVEV4V3k2amxLclpRbUlMUGtzTHdEYkpFWkhTYU9M?=
 =?utf-8?B?R1BUNXZJQnRoRlRRODhVaWZMSGlCODFhZGlkOTArcXYrQXp6YlIyb01IYkhl?=
 =?utf-8?B?cnFiYkcvNzBINWhldVpVSlNyRTcyNSszc2c4dHc4dS82NFBibkljWktoWUtV?=
 =?utf-8?B?SElhRW5OMEg0Q1JIY1RBY1pYWlBueTFNdWhoeEtLU200dnRCbmg3b3AxMUtO?=
 =?utf-8?B?RjNReGx0Mm5LZkpLUjM5Rk1iek0vb0NHQnJlcjA2ZldzWmlwWkhmQkV5VlN1?=
 =?utf-8?B?VmUxRE1sY21OdjZrTW1ScXBWeHN6S0h5WmJZNktnU2syNEdpQzdKbW5VQ00v?=
 =?utf-8?B?a0JUT3p2dVlKRW9vSWdtc3FPQlI2QjRERlBHSkhHWUdEM05pSDlmQzVscUhT?=
 =?utf-8?B?VmJhQzgvL1Yrb3NvVS9YeW8rTXk4dDV1c0lHYU01OWR5RktJWGRzTUZiSGFx?=
 =?utf-8?B?WFEwdVlRVFNwT1FKYVVqeTNiSHAvZkdOQXhQa1N3eEdmSGhJV2hqOWNoRzNU?=
 =?utf-8?B?MmJhNXRIRERWczR5MzhET2ExTGs5VzZDWUxEQVd5d3RvUEVyNnpIWUhvVXFh?=
 =?utf-8?B?cXdCeldPM24zM0VORTdkQXI1cFdtd0tJN0dEZDMxTEVsZytSbmdQTUsrbU94?=
 =?utf-8?B?ZlRCZnZyZTVCUThZWEQ4a0x5blNMeGJzWVB1NVVMS1hyaTloUzFaWDVISGEy?=
 =?utf-8?B?Wmgzb3pxUUd5eXlsZGR3UXErNFhFUDU4VFpEelE4eW1mSlJHUWgwYUJpRU94?=
 =?utf-8?B?RytINTFrNkxheTc1Qm44c3IwWjNiaTlzamFLZGNablcyNTFtalo0UllsUWpx?=
 =?utf-8?B?eUFYZHhmZlp4RWw2OVU1NGlYbmZaa1pFeFZoNGJFUHlxaTNWa1Z0djhRRzJV?=
 =?utf-8?B?eEpjcjNNOXdaOW1iOVBmdFBtWC9KMWlPbzBtNGVMeVhXSWw1TUZtWm5SK3R0?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8754.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30347eda-4212-4ae5-0c2c-08de27195c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 03:11:41.3412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H82i8HTQ+tyHpmbk1V0hG7DiFI4zNl2RZVdc0i9lx0CB9toTqgjNt4nY7TRQbLmasOpNxwBjz6lX5iwY3UHrsKBEmJ1KxGBmrJEj4zj2Pas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8104
X-OriginatorOrg: intel.com

PiBJJ20gbm90IHN1cmUgd2hhdCBleGFjdGx5IHlvdSB3YW50ZWQgdG8gc2F5IGhlcmUuICBDYXJl
IHRvIGV4cGxhaW4/DQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEkgd2lsbCBjbGVhbiBpdCB1cCBp
biB2Mi4NCg0KPiBJbiBwcmluY2lwbGUgdGhpcyBzaG91bGQgYmUgZmluZSwgYnV0IGl0IHBvdGVu
dGlhbGx5IGluY3JlYXNlcyB0aGUgbWF4aW11bSB0aW1lIHRha2VuIGJ5IHRoaXMgbG9vcCBmcm9t
IDEgbXMgdG8gMiBtcy4NCkdvb2QgcG9pbnQuIEknbGwgc2VuZCB2MiBwYXRjaCB3aXRoIHVzbGVl
cF9yYW5nZSgxMCwgMTUpIHRvIGxpbWl0IHdvcnN0LWNhc2UNCmxvb3AgZHVyYXRpb24gdG8gMS41
bXMgaW5zdGVhZCBvZiAybXMuIA0KDQpCUiwNCkthdXNobGVuZHJhDQo=

