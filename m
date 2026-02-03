Return-Path: <linux-pm+bounces-41981-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIwAF5kjgmnPPgMAu9opvQ
	(envelope-from <linux-pm+bounces-41981-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:34:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED726DC0B4
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 17:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2762B31B38A4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DFA3C1960;
	Tue,  3 Feb 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ds31BFYt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB223AA1B1;
	Tue,  3 Feb 2026 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135770; cv=fail; b=A/fa17qgoz3s3uQ5FnNbmypHW0r6V3Wih16OFH9IV0fm2bs+2+oGfUtPo4hukvbfhmwrv/6ArKsrHL4jjbVkc6XMybuFpgbVA2X5E1bPBuK1Ds3IKdpVYnnGQ5GvT1ymC2zAno0LzNM7F0ViQU1sIZk6PB2yZS7mdmzwsb6NdD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135770; c=relaxed/simple;
	bh=1brcDYX6jxayIj7ITdmWDlHXamSsr6zqJRmYjEO1abI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LiQ30uTDZ2AVP0xmFCCpfRrovztzSEYdrgHXF0bfowt1c0rYvTVizNYM5gTUenOVjqMNYR3U4ttKAHAvMPgO1mr2UPAeqrM1t0UX/IndLw+Q0CQJf9YPIMboCMfIATYQtLwyNPNhZ2bnNZberamYqX/i63/QURYBuUgKmDYFlUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ds31BFYt; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770135769; x=1801671769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1brcDYX6jxayIj7ITdmWDlHXamSsr6zqJRmYjEO1abI=;
  b=ds31BFYtTwVC3z+iTEfP5ozo6tWRZQT/jxBricCkdXEhMEcU4Ig39VrU
   FwC4t/TAn4hGCrcK4CPzCz1S5XlzzaekrjE+DMlorIx4xD5mpR4wq+BZ8
   tPUDny1GJD7wkwXXMcvO5W7+NFym5t6eW6XTjkWqTUMujQKu4o+88KtQV
   bLsMQUX+Lgi2UrbOODanEHySXo+GLuVplyYJlOJmK/vk55Y1p7e9D4VXP
   D9T9/XuD33YqdLtujt20k/oxpH7npTz70cv6XuilbFsvDvwbVh61d3pMc
   PI0MrJRO2WOH6JILOiaCUx8i0Cw6U/4szoblKNQT0J4tpDr48UgTZ8bNE
   Q==;
X-CSE-ConnectionGUID: BTZGrHcIR4SKm8Pg77fpuA==
X-CSE-MsgGUID: prgwcMbDT7mw/WVrx/Pzfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="73909797"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="73909797"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:22:48 -0800
X-CSE-ConnectionGUID: Ycj7Gw8pQw6LovpZtjp/Kw==
X-CSE-MsgGUID: NItyiWf7Tni1+ZBON/2x7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209181591"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:22:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 08:22:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 08:22:48 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 08:22:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUhMiXqAhOYSYVgfq9keKX4oaV8VOHNqv8LF8zVH37cHcxO4D914jktE9EOsKCS7uthwPgyU2pjZcmBAM5Frzr4FGn1TAB6QEVSv93RuIkbVYRzl0rMSRlabgd8Ps9oWYKQ/5Hy2RvN8S38liz/hslLsFDf/wD7xGShEXam95W3oPG9KIg7uB4XX2F7FygHr9Ywgj2/5KY3OETONxwMy4FNzCGEvxtB5naxs4EC+J++qaBRfODAsEqNjCDfCOoWTs141uBdLbm12rWTKMlUmFNF/50YVjCeT/Fw9mAW2PyVKC9H+iEOVn0HkhaKUEk4fpVfPwCAGpKJDkwtxthWMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qKMQKxCrT1tVA3GNPymoe4xL4/f6ue4A9DpU/WB8pU=;
 b=tBlZ46LfOvYwXCWPj1Eg4CzIL2Msv+pyhriiqedolxgqFaPKWztEvMbMthlBe+TcISYQlF1R11PGI+rySMzXvV6q/nGKt4njkYgWL49gJACY/UykrZhIYchvjT/TW+0S1ilmAhdiKz+ROM/UebuHZy9QBiBSRBrnjywWnIvfbnxu9Vx7PWWmlH85H+ee5xoLom1ZCTGPM1sQXHFlQtElaJpq5x9WCYTzb99hfryCbACk3KK4AbHIWOUnPRsUJR8PCtrlM5wj6Pu11UMb8k8geLiJFXveZ42Z/D0mUSelQzeBB/cbtGxI8wKisAyKRIL8kmmH70mU0B+ZXA1TNBIykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SJ5PPFC362E0A4E.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::854) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 16:22:43 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 16:22:43 +0000
Message-ID: <73f7fc6b-d3cc-46d0-a07b-45c2a4190434@intel.com>
Date: Tue, 3 Feb 2026 17:22:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
To: Frank Li <Frank.li@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>
CC: <alexandre.belloni@bootlin.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
 <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com>
 <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com>
 <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
 <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com>
 <aYDP847mgleQBF5Y@lizhi-Precision-Tower-5810>
 <eb335daa-ab6b-4cff-bea2-90160892bc8f@intel.com>
 <aYIbZ3PwiKUfp/eL@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <aYIbZ3PwiKUfp/eL@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::10) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|SJ5PPFC362E0A4E:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5ad1ce-7427-4353-e90c-08de63407544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVl1WTVkaEovV29pMGRHVndpemZOVWJNT3pXUnYxMlBKcmozeVJnWDZJWCtv?=
 =?utf-8?B?V2YwZllGd2pyVWpab241MU9JaVRVN09oQUljWTNWTXYvNDlPVm85WUE0WU5j?=
 =?utf-8?B?OENZVkQrNlZCWGkrL1kzaGwxMkdrSjM0VlFkTThIZlljNFVYaGx6ZHJDMGsr?=
 =?utf-8?B?WWhramE2dk92Sm13YVRGd2R5bEl2cHNjbmxMOHQvTWFUajMwRVFkNmMwcUh3?=
 =?utf-8?B?Z2puR2JsUXVNK1dZWVdUMDVXa2thUFdQZTZiekpSZHQwZE5VeG1lUWZYYkFO?=
 =?utf-8?B?SklnMG1sTjM5Z1FBYVBEZDlkRW00Y1kvcFZpSFVOV2tMQkNudHRycVRFeVpt?=
 =?utf-8?B?N0tsak5LUS8rWFYvdWdaWjVraG54dFROVXdhNXhFZkJwZis4bUhNN3lSY25W?=
 =?utf-8?B?R3p6dVJXQW43VlBZcWpjdldxVzcwR0VqWmFISUMzbUVpRGQ4d3FYb0x3b2JP?=
 =?utf-8?B?VTFIRzc4Z3VySVg5YTZtM1VuWkQ1YjFyelJmdk5EOEdBZlVjN05lWVNtVVM4?=
 =?utf-8?B?eGdHNUJrN0xBMUE2OFNwalROb3YycnRqSGhscU10Q1d1bzlRQ0oySEpoOVJ6?=
 =?utf-8?B?U0Evd091U1ZSRjlRaU4yMjlBdEFrelZwOW9Vd1M0Q3hRZDhvR01iZUdKRHVM?=
 =?utf-8?B?WlovangyK3hwNk14ZEVUbFlaUU1zdGlXMXBXbExpM0RWaUFjb1R5SGFxekhQ?=
 =?utf-8?B?NVMweW53eU4ycGhXcEM3cDFTbGsvbWw2T3dyN25zUFRZajc1RCtMMkxJVCtw?=
 =?utf-8?B?MlVYS1lDbzkrSFQ5UU83R1pBUldyN2xGakJVbzlHeUd5eWFyWWF6TzhTOUxy?=
 =?utf-8?B?VDNsRUxpOFlRWVBISi9xd3BHM2MzV3ZBVTBiODBaSzNaUzFoSW13dFVEcXh3?=
 =?utf-8?B?aHQ5RzJ1SksyRjJERmh1N2cxVksvd2p4ZzV3WTdrTUtmV3A1alI3UWY4QzJO?=
 =?utf-8?B?WExiN2ZUOStWRVpvWU1YaS9hamovckllWWVYaUhFUkJWYUFOOXBSUisraHFn?=
 =?utf-8?B?ODhldWFXR3p3UUJqSm91M0F1R3N2akJZWVUydmdlWjNMaXY4NEJCbElwNFVn?=
 =?utf-8?B?SlMwNVRuYkJ2OGFGdlo0dzd1MTZxTWpzWnAvSFJEVkltc3pHa1RPOWdSYmN5?=
 =?utf-8?B?ZGlOYjMydzRKOE1oZVZpT216SzJmUEdCaXE0MExJWXk1aGgxMjYwOHUyaTIx?=
 =?utf-8?B?TlNvVDJiVjN4ODk0MTh2N1lPTDNGNFFrVjV6SnpMYVBhc3BvZTVtZ0VseUt2?=
 =?utf-8?B?OW0vcHJjdGpPTno5T2lCRW40VmYvWjJHQ0lZNVM4djJrd0R5UnpTMWE2MFhO?=
 =?utf-8?B?dXdKYlNETGY1ckd2QVpVMW5ickhSR3RQVjBadnpUenY3aWtUZGNPbDF5aDV0?=
 =?utf-8?B?cGlvSDgxN096dWl1aDd2SnQ0VlVhUkM4QlMyVUU2WnluaVMxUDdHR1NBZm5P?=
 =?utf-8?B?eDBUK01paVptNUdIUHJQMVpaWE9NYTRWRzR5cTJUYnFvVEpUUHZNc2VQUHFI?=
 =?utf-8?B?WXZrVkxNZmlYSndjVkdBOXMxWFAvZzJaa2Nvb3UzVUpuR2szL0ZuRGtLQUlZ?=
 =?utf-8?B?bFZHNytsRHVUZS9YZmE3K1BKa0hHR0QyUUVOWnJKcVk2V1R0dG5ySkw0MFRM?=
 =?utf-8?B?aDNPOTgzWmgxNkNkOG9sMktoRXJ2aXNsSkE4VGpza2xIMGRrbmx6WWdUVUNS?=
 =?utf-8?B?R3NnWkhGQmRZcUoxN1l1UWJUWHQ1bzhoU3AzbFIvSXFETnB4MFpUVTlyMFFK?=
 =?utf-8?B?bVpNSldSalBlckxsNXpVR2lPZ0xBMU5sTzRpQTRONmtVMFJLYkR5QWFCQ01q?=
 =?utf-8?B?cXZQWStMbDIvZXhlSWxHYytHWUNDOWpqMGtvZCtaTmtQNnBFTHhxdStsbUho?=
 =?utf-8?B?ZnFwZnlyeU80UUtzRGlTWFFkZnZheGJ6YzJvcUk1OXc5VEtxem54ZGkwTUxy?=
 =?utf-8?B?Qnl2eU5scWFtNExDRmpDREpLZExENmFxVlpHYTkwVzBFSnA1b0hkTXZ1dmNG?=
 =?utf-8?B?WVBxM1R4WE9YK3hpMUlua1pKbzFhU3A5WEx1NnR3K1RwbkswSXBkeGNyZS81?=
 =?utf-8?B?aUZjUDV4eHpFNzRyTnZXTkYzNG8yUkJ4K0VHVlU5Ym9QUDZKSDRzc1BCWWE2?=
 =?utf-8?Q?GcLU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHovTnFDRzlVZVFiQndWZzdHL0dURUtqekJmb0VsTUFLMTEveGNDMFp2RkR1?=
 =?utf-8?B?dmJBUUd3dHJXR2JoN3BWdXViM0dRRjhxNFd4N0FVOXlyUkZjK09oVFhwWHVa?=
 =?utf-8?B?YnJlc1NrUVg0aXZKMlFxbXl4Y2VnZzBDUi8yNnlxa3lMQTY0UWNwTnNKdWdj?=
 =?utf-8?B?WkRuUFhDWnlhSWZqNWYwemVEUDRqQ2NGQ0NHempwMGVNY1g2U3BaaUVaYko2?=
 =?utf-8?B?aWh0MDAvV2YyNW9uY0c3MDAxdGNCVkdHdHBEV0MwVllRb0JPTHNRN2pWZGFj?=
 =?utf-8?B?Z3VkdWdYaE9BTTFiN0RKdlRaamE4aWdZc3daTHdCcERoN0l4a3pnMitrdExw?=
 =?utf-8?B?SVdNaWd3dTc0REl0ZkFCY3VkRkhHMC9qU09MczhOUFF5SzhIaGl1YllRY1Qy?=
 =?utf-8?B?b1lUcWpzWHN5ZjFNTldYYTBDYUxPSDBaS0FPelpyYXFBbHdEU0FCMHNtcW1J?=
 =?utf-8?B?SzhXdlZBbU5NSFp2OU9rZE04aWRjaHhSeTdjVXpXeDJVUk9kRUEzeHpOMDBQ?=
 =?utf-8?B?Z3pVKzNLckZZekpualBqSExBKzVIZWVEVjUybEdKMmhWSkphMG5acG9YdDZo?=
 =?utf-8?B?K2NHS05EQy9rY1NKSmh1ams3aGFnTHczaERRbGVSN21sRldwOFljRmRaRWor?=
 =?utf-8?B?V3Jpa2NmRlpmdzdHU21zeXhCZ25NbU1lTVVVcllVb1RrV0RrdXQ2Z0drVGdq?=
 =?utf-8?B?RUdNY0dNSGR5dzJ5bEJnM3RWdUt4V1MyWlFLSlN6YU93MXMzQmt4anRrbi8z?=
 =?utf-8?B?d3FlVnYremRpdm9KWkROSXVWN0YyM05MeHlmK1NFOUs2aHFvK21nVFA0aFU2?=
 =?utf-8?B?VGl6Qnhwc0s0SitnZVhUSitmMi91TG9TaEFvWGE4SjlxU2N5allpVW9JeGpS?=
 =?utf-8?B?d2FnS0kxUk9Bci9LWnIwbXJITGxUVUlqTFNTQkRlQUNpNEVKNjd0dFJXbWJ3?=
 =?utf-8?B?STk4RDI4YkxEVnRYdXFmLzdQMGVmejlhYStMNlJsWlRMSXZ1TjNLaHR6SUlz?=
 =?utf-8?B?alJDT3diMzJvRERaSlN1eVJQbHF4Z0ZiZ3lwdmdqc0Jpa0R0UVRzVi9xT3dG?=
 =?utf-8?B?Nzg3ZVB1eFIzcjdJOVNiMlZJTmxjdHRwaEpvUEExMXkxVm1RUE1nVUFaMzQy?=
 =?utf-8?B?dTZBTVk1V1FHalo4WFVOUWs5Z1RxM21aUXVXYWZNYy9QbDZmRTlpOVBWczhK?=
 =?utf-8?B?UGwrelorR1NRNVVOdzFUU2x1UEhBQ3JKZFJxUEw0QzR1a1pMczNWVFl2a0Rw?=
 =?utf-8?B?M29yYTVIVG9aeWNyMVhBczBxVmNleXlRZm9ObzlMSDkzSUVoUXEzTFRPcm5y?=
 =?utf-8?B?NldIQis4UHRVa2JqSUNSekVaa3l0MmZ5M283ZHlnVlhFMW0rMFdQa0FESHc5?=
 =?utf-8?B?U05pL1lHZi8yS1BhZTA4b3V0b3A2bDl2NHlnVzFWZmxIWGpVNG1vWmhGd05P?=
 =?utf-8?B?d1RJMUh4d3JaNVk1Y0ZlY3N2MmZxc2Z0M2xkaHpwTDlyV244aVlYRTFzU2la?=
 =?utf-8?B?WWc0WEFzd1dYamlzUm16RldHdE50UzZBNngrbDJyeloycjlXT2Q0ODFXenBI?=
 =?utf-8?B?MExuZGpKVXVaNlBRbUF3YVN3ZitXK0h6RjdwMGpGUktSSm1CT0NxVkVQV1ZU?=
 =?utf-8?B?cHBKSk15dGRuZ25FRFRzV2R5VC84VHRZSzlvbG1CODJUV2FlMWhYd1N1MS9o?=
 =?utf-8?B?dlkvc2wzek1udXcvWlNITXJWcTZ0c3RZVmtieHArYncxa05kZDRSWnNScWFr?=
 =?utf-8?B?R1VhakxmQlliZXJOVGpTZTNVRlZISU00MHF6ZFR2eE9WM1hSakFRQ0lkYTZx?=
 =?utf-8?B?YVBaT0VsL2tabFZSZ0ROSUczdCtSM2wxRHpDWmFTRjF6a2FUaG44M20rWi9S?=
 =?utf-8?B?NHZhakRqU0pOb29VR1QxTVlJd1hLOFhySzRCazB4NlcydTVYWVlnbm12M1Qx?=
 =?utf-8?B?RC9KQjF0NmQ3V1NiUmNkZE9NQk5SY3V2VGs4bkUwVmlRZFhwMkI4RzF2V05G?=
 =?utf-8?B?NER2aHFtRHErc05tVkN4QjRsM3paUDBQaFJmeld1RWdHYWhYREhsQVNWS1l4?=
 =?utf-8?B?bE5Yc3JnaHNyN0NqNEZ3ZVp1bUwrY3pSZVNjeXlHMzZ0WTVnSUEyYmV1ZFZH?=
 =?utf-8?B?c09heldyRHZNZzdYTGt5OEZId2k1RTdWclZMUkxIYm1PN3BRdEIrWkV4VHlr?=
 =?utf-8?B?TEcwOXRHNWV3NWhOLytqY2ZqUmFvNXpFUzhmVVZhc2xUSHRqUkg1MVUxVUk5?=
 =?utf-8?B?Q01CQmhFSmFUanpSRStJUmFQM3FQUys5S3dPeE1ibWhvMVo5NmM3ZDFONFZ3?=
 =?utf-8?B?ZUNSZ295TU1heE0veVQvclp3ek5KaUZFcVMwUXdrMVR1UWZhVStBSTVldFhl?=
 =?utf-8?Q?J4951/EiZe6DmO7M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5ad1ce-7427-4353-e90c-08de63407544
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:22:43.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+bJzdnSGjBLGxURlqj7FGOcAdy06wXiRjkoZn9Rh2RYJMpTe9K0HigNe+S1KWLjNr09G8jBtTpTyUIZFyk6yV0BRGt3jDJn+17/iGcvOHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC362E0A4E
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41981-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[rafael.j.wysocki@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ED726DC0B4
X-Rspamd-Action: no action


On 2/3/2026 4:59 PM, Frank Li wrote:
> On Tue, Feb 03, 2026 at 02:54:44PM +0200, Adrian Hunter wrote:
>> + Rafael
>>
>> Rafael, this is not at all urgent, but when you have time
>> please have a look at this patch set.  There is also some
>> more explanation below.  Is it acceptable?  Is there a
>> better way?
>>
>> On 02/02/2026 18:25, Frank Li wrote:
>>> Does your device Hierarchy look like
>>>
>>>             PCI device
>>>                 |
>>>         -----------------
>>>        HCI1            HCI2
>>>         |               |
>>>       I3C M1          I3C M2
>> Yes and no.  There is only 1 real device : the PCI device.
>> It implements the MIPI I3C HCI standard which allows multiple
>> I3C bus controllers in one device (in our case 2 controllers).
>>
>> The PCI driver mipi-i3c-hci-pci creates 2 platform devices,
>> one for each controller.  The platform driver is mipi-i3c-hci:
>>
>>   Driver                        Device                     Bus
>>
>>   mipi-i3c-hci-pci            0000:00:11.1                 PCI
>>                              /            \
>>   mipi-i3c-hci      intel-lpss-i3c.0  intel-lpss-i3c.1     Platform
>>
>> LPSS I3C also supports wake-up from in-band interrupt (IBI) via
>> PCI PME.  The PME only works when the PCI device is in a low power
>> state (D3hot in our case).  Also the PME is effectively shared by
>> the 2 controllers i.e. an IBI signal (the controller's SDA line
>> pulled low) for either controller will cause the PME.
>>
>> That means there are only 2 valid configurations:
>>
>> 	1: Both controllers enabled to receive IBIs
>> 		PCI device	D0
>> 		Controller 1	Enabled
>> 		Controller 2	Enabled
>>
>> 	2: Both controllers disabled to enable PME wakeup
>> 		PCI device	D3hot
>> 		Controller 1	Disabled
>> 		Controller 2	Disabled
>>
>> However, represented as platform devices, the 2 controllers
>> runtime suspend and resume independently from each other.
>> Whereas they effectively need to runtime suspend (or resume)
>> at the same time.
>>
>> The proposed solution is for the PCI driver mipi-i3c-hci-pci
>> to take over managing runtime PM for both controllers, calling
>> into mipi-i3c-hci when it is safe to do so, to save/restore state
>> and disable/enable the controllers one after the other.
>>
>> Current situation (I3C next branch):
>>
>> 	PCI device	Runtime PM enabled, dependent on child devices
>> 			PCI subsystem controls PCI device power state
>>
>> 	Controller 1	Runtime PM enabled plus auto-suspend
>> 			I3C subsystem runtime PM gets/puts the Platform device
>> 			Runtime suspend: disable and save state
>> 			Runtime resume: restore state and enable
>>
>> 	Controller 2	Runtime PM enabled plus auto-suspend
>> 			I3C subsystem runtime PM gets/puts the Platform device
>> 			Runtime suspend: disable and save state
>> 			Runtime resume: restore state and enable
>>
>> Proposed (this patch set):
>>
>> 	PCI device	Runtime PM enabled plus auto-suspend
>> 			I3C subsystem runtime PM gets/puts the PCI device
>> 			For each controller:
>> 				Call into mipi-i3c-hci (when it is safe)
>> 					Runtime suspend: disable and save state
>> 					Runtime resume: restore state and enable
>>
>> 	Controller 1	Runtime PM disabled
>>
>> 	Controller 2	Runtime PM disabled
> Controller 1/2 is child device of PCI device.
>
> So first patch "i3c: master: Allow controller drivers to select runtime PM device"
> is not necessary.
>
> You can enable controller 1 and 2 Runtime PM with dummy operation.
>
> When controller 1 run time suspend, parent PCI device will reduce ref counter
> when controller 2 run time suspend, parent PCI device will reduce ref counter
>
> Only runtime pm reference counter of PCI device is 0, PCI device's run time
> suspend will be called, you can do actual disable and save work.

This sounds to me like it should work.


