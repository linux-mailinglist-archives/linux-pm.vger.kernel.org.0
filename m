Return-Path: <linux-pm+bounces-12597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB949593C1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 06:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CDD1F23254
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 04:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE1C15FD08;
	Wed, 21 Aug 2024 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E6hkHJtu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EA175A6;
	Wed, 21 Aug 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216241; cv=fail; b=H53JL5iY+gsjjPUlKRcLWhw4W+4Z2/i/03Y86YlFvy5V6aqolDg27YcpJXuLWBK/+D2kMkSDXKdEzLyLSxvSA/ywvLu9RB/dNUxFf2GoGb5JFOBDxnmfQd2Ch5yWwqLxnJwQgVDyV0ennkVr+GYodqOPd4ehYeGZZnNu/6FzAcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216241; c=relaxed/simple;
	bh=2daLoqu64NughYDmM06NbWuZOJRqtjLZ1/W+2/wmYTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iuy7SlCkxslCjla369f7IlBl0NPM/3vW63qR28TLNANp1aM/+q8rxGIpThQwQrOT/leKFe6hULZ0tyI3pB1NgE6ygA/gszTFPlAVqaeIjsrgRKhim1gh2fFZDVxSqv8kr4byc+2YyJqQLdqYZB4D2nM8mmtAAQ5hTzISuduPYDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E6hkHJtu; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCiVqxcIo1pG1ah4DnQAQhH+bolmRqGq+JZblCp79rRNfuMigMTqv2j2w7M3KAphd/WEoJjt9mjVKLBmYr/5orkdLHgFjvJseM62tqnbO8jKOkVCq/NhyxfPR9b89viLOPbOMdGT1iL/wUOzkhw2nJ8UtKmoduvqeUb4yr5jzCh/aQynYV75DSlB/gl3YT+QqNFMOAlmpOHMESlbkB3yAmN6ivf3R8uqcG/x1O5ozHQXTkrhV+LKkxIlLe8jUlf9xEgBt+URJdnHBWmWTX1krLz1exWCV4Gs598J/kj1nvegdqhZUOhvD70az8EKT8h0aXEu8y3z+QURr5Ay4kyunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fp3h28TUG86ZqADVZTQ+RM61W/UiY2yK8F6qXumGPY=;
 b=su2PsCLMxOBMf+oyLNDWZdLHA+hcI9r0Nd1uIAdRj4rpk9S4Ucs/IYP44U+GPyitgYTRWv3BWB+b8WNRGnkWZEp8jTZL69l0q7LbllQZCdqGOFJ7tOqGlmgw1d+giqASjw0S7oPoUDMe7IVdrvJ9uATcWTvuLpMyOJPowhznmGE/9ReF6I9BieGPtiBgcfb4AaqxYh/BNdiiOzdz74aqtlFZKwygPOr8c0RKGTADgRYEjSpDsOXXE5fYalwWeoFHtSdHpsNhVz7x54WdLemYsYf0vTte/iQEy3ws9w0+5PGOxvJcKi9QFTrgbb7nfd+invUxUtE0lYmYklNfLaIM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fp3h28TUG86ZqADVZTQ+RM61W/UiY2yK8F6qXumGPY=;
 b=E6hkHJtuX2J7Vx69NxXnB2g8nbD3/ivnnnnSDRqEyWnK9iBR7C5Sr2pDJjvettyqjmscz8vbdnj+YHkjaOPSowDXNW5FdCg/ULp3dq1N8zOZSa0+i61heHJUc6dtRWwOdEWDtzg3ChetmLC/uRUH1n67jCBejwjg1Zx5/QagmPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 04:57:17 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 04:57:17 +0000
Date: Wed, 21 Aug 2024 10:27:05 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, rui.zhang@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, ananth.narayan@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com,
	Michael Larabel <michael@michaellarabel.com>
Subject: Re: [PATCH v2 2/2] powercap/intel_rapl: Fix the energy-pkg event for
 AMD CPUs
Message-ID: <ZsVzoRrkrfCZ3ncM@BLRRASHENOY1.amd.com>
References: <20240730044917.4680-1-Dhananjay.Ugwekar@amd.com>
 <20240730044917.4680-3-Dhananjay.Ugwekar@amd.com>
 <CAJZ5v0h4GAVCpUnbCMHMophsSZ522kkReAbUMdfFgRJfd0vHkw@mail.gmail.com>
 <3c6e2fb3-4b51-4cda-a5ca-71bed94d47b9@amd.com>
 <CAJZ5v0gxD_nUabYLKoO2NoQ-TTYd5-4mocyri6M4g0xZ+4sd2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gxD_nUabYLKoO2NoQ-TTYd5-4mocyri6M4g0xZ+4sd2A@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 912e08cc-bc43-46ee-26a9-08dcc19dbb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGNEVlNGak5SZTBhNzNvOUNOM01FWHI4MlErMi94RnJPQklkUUJSLzkzR2tj?=
 =?utf-8?B?RDhXbElIWXo2TkFwVWxIZ1ZEWUNuMlNGR0VMaWZpSEo5OXh5bnNUNVJ4ZFI2?=
 =?utf-8?B?ditubnVJQTFRdU5IaXo4QkRSZWNqQ0p1UldOUEFDUkhobEQ4TEtPSFppM3BS?=
 =?utf-8?B?L3l6TlU0bk9KdzBNUnZFN1FaNVU2SDJYUjJBN0srdHlzRjJDRXJzTnJtTFAx?=
 =?utf-8?B?c2oxRE1kSXd6SWppTHBXZXpVK25PVk4wZjZ6by9SN1h2OTFDTHVOS2hvcUVF?=
 =?utf-8?B?VGdjeFFnYWZiclNFRS8wcjRKa0xYWnkwTy9Pd0I0cit2NnVMV2hJOWtOUndW?=
 =?utf-8?B?YkdRdXNQQTdMR2J4TDh4MnFBeGJGRjQ5T1lwU0ttbkZGRmVTcUZRU0gvbEtZ?=
 =?utf-8?B?KzRmY2svUktNeUhEUW43WXREYkdQemljYys3TUdkTmJnVnl4UE1Nbkp1WHVr?=
 =?utf-8?B?OWd0RzJOblZXQlFWRGVraC9qcG9mbUl5dEhndU95ZDVxSjQwSXl1ejh3WHUr?=
 =?utf-8?B?RzMwT01TcHNIbmlDcHgzSjhDSERyS0c1Ni9VK3MvdGhZMmtkZTNJdXlqZ0pV?=
 =?utf-8?B?cHU5V0VUeXQ4NDNVbFpvTTVTZUloMVp5U1NWOEhibmVBN1FuSGJid1MwNTZP?=
 =?utf-8?B?RklIb0MxU3g4ZkhjTEJHeGZPRVgwY1BhcW5LdUVLazcvVGlZS1J5NkVTempD?=
 =?utf-8?B?UFdYa0lpY1NwaDRlWFlEMWtOVmxmaWZuN0QwLzZYdFJjc3FVN2ZxRzY2dE5j?=
 =?utf-8?B?WnJ3OTBYMWRKZW92ZjB6bkdtNkhuVTk3RWFzaGQ2N0Q3cGRJa0syTURFTUpp?=
 =?utf-8?B?OUdJWUx3eGx2U0lLTHdBcXc5SWVQN054QXd0Wnc5SHRsL2pvNUZZZGtaNTJ4?=
 =?utf-8?B?Zmt1NlVNLzduenlkUVZRRmxSVmVIdnhLU2kxeTFSYlZPelF5cDhmVUxVTFFR?=
 =?utf-8?B?aGh1eVRISWY4L0JXVUFRYkNPTkZQZ1RVc2FoOG9yQlFCZmwxeFB3c2lGYzls?=
 =?utf-8?B?Y2FVT0pWek0yc2pWaFNHdUxQMHFjWUtuZnZKdjFWVjUyRjgydEJGOXgzaFNU?=
 =?utf-8?B?NVU5RVlMcjN1dGZkQTJCUFNSUVd5aTNjL292Y2kvRTJCZ0Q3bVdCWDJpOEMy?=
 =?utf-8?B?MHFQSGg1a1daQWtRdWZtWDNoVVcwU09rTlhTNlBMOW5qR3FNM0tYVWdnVEtW?=
 =?utf-8?B?WVVobFhSLzFyNEVremx1QTl5SHFnSHlzUDlzTG83c2tZaUlORVFOUU04WUwv?=
 =?utf-8?B?SE4rRFFiY25ZVzNTZTVJTStvc2pzT2gxTlFLWUszb3pMV0cwRk91eG9mNVBB?=
 =?utf-8?B?cW80NXFjWlRMeGdtYlNUUVpiY25SclNITjVSYTRBeXJGLys5Qm51aXhjR3pi?=
 =?utf-8?B?ZmNja2MzcUxrTkdUU0ZwUEN3YWp3SHJBNno1UENqanU3QUc2ekdGWW5hUVIr?=
 =?utf-8?B?Q3RLSVhVTEo0aDYvZ3F1MkI3STZVMEFvd1YvNmsyeDlSMllpYUxacjhsL0xy?=
 =?utf-8?B?L2UvQWt0NzhCZlVxd2ZKUWJaNnNvRFZxNjFHZFIvZnJJZURDbzFFb3o2c3B2?=
 =?utf-8?B?a2tGaVlVRjhRa0tnVTkzZnhNLzlWOUxjdDc3U3ZUTmhNQ3JYeEtPY1lVUFo0?=
 =?utf-8?B?UUFtZXdFWnk1SUdOTkp5SjBRV3BvQms0RWsyYWxmT3lFQ1hiMmJuUU5HWGtu?=
 =?utf-8?B?YWlJSnhBU1g1SXphYmR5VWhYOFIwTWhGOHcycjBsZFVUbC9YMzBFR1FoTDJk?=
 =?utf-8?B?THdCTmc2Yml4UERWbGJXQStJVGtJU3JwYTA5dzIrMktZMDF6YlhlV2gzN3h5?=
 =?utf-8?B?aHNLeUFiY0RYdktTeW1yQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0lpSmsrT0NYSmdWN0xMZEZIRmdnaklXY25NN1Q4RVdjM1ViYVVQd2U3N3Zy?=
 =?utf-8?B?dWNUSGUrdTlyZHFzSWQwZVBQTDJCQXYxUXllOHRRS3RVYUJJb3E2QzVudktm?=
 =?utf-8?B?NW5YQnp3eWFuTTlwRi9Cd0RqZHJFK1JFWnIwcWk4SkJYMy9JYkxtUktZMjVm?=
 =?utf-8?B?T1VYVEVKWlVsK3ZBMmZ1UEtiekVGRVYvUjV3VGVJajFpZ3pKRWRHMyt3MXNt?=
 =?utf-8?B?TzN3QWpqSjVxSHROMzBJNTJvNzhSQzRvYklnOVl3NHpxUzEvZzJRc2IxeTJk?=
 =?utf-8?B?NSt5bkUwR0JNcUc1TG9lS0llN2lGZkgvcDcvYU1DUmp4OTRPZVF3NVVwSzN5?=
 =?utf-8?B?c2Z0RjB4TXFCUG1yeXY2YlBXQWMzci9rOEZKc0xZaFFYOGxMM2VzVkJ5MTBk?=
 =?utf-8?B?N2ExSXNWL2NpcTdaTzlHdVpoTG9MM2RsVnFLdlo5L1NRd1VzVUhZSnRXMkR2?=
 =?utf-8?B?ajFiZzlWSUt2NWhJTjJyZmxmOEpZYkNESFhpNmFRMGthSUU1aEl3TGFuSHVw?=
 =?utf-8?B?M1BhNENibFBWTHpkeXdKdXhRZ3d4SnkwamtBbnlpSVJTK0VnS1JCUHg0Rzl0?=
 =?utf-8?B?M05LejJSaitBNk9SWi9oVS9qZENEblI0ZTJFTURxQkwzOWt1ZlNPdlp4MlAw?=
 =?utf-8?B?dkRtSjdiZm9DK2NySXBGejJKTnFKVFJOWXFTT0EwekQwZmdPNm51d1IrL1Iz?=
 =?utf-8?B?L04zZG9sb0RTdnlSOEl0dEdpTVJacEJEOTJkRDBsTFdxWkQ5eHVQMDZtTnZQ?=
 =?utf-8?B?enNRUGNUNUZrM2Z1Z1RZY1RmNjB3TkFvQ3dzZi9kNHVNVVEwTjdQaXluOVlq?=
 =?utf-8?B?Q3lYZzBuYnovZjVOVGxGZVdpQmlUUUlsSlh6eUJlaXAreEpRemdwRTlDME0y?=
 =?utf-8?B?NGhEbXV6T0h4cStkTVlxVGkveTdWNXVBald6a0pqRVhoN3R3ZDUxUGVYL05H?=
 =?utf-8?B?WGd4RjR2RmhrQWNBMXJzM1BwMlVtMTZ2a2JrejVRM05XcHBYUW9JYVBCelRE?=
 =?utf-8?B?MmFCVlVCTEtFWDByVXljaEJROXB1M1Qya1htTXlQTWN3S1c3QkEydlBuTUVG?=
 =?utf-8?B?cldNTDFnN0dPWkpScEtISzBhNWdDaWhCTkI3Y0xoeGJnNlRZOVR5L2o0amQx?=
 =?utf-8?B?c0UzRVB4R0dGZFIvemxKS2tLSjEra3IxTlk5UkxmbFc4YW12dTBVZkE4LzVH?=
 =?utf-8?B?TUtqdDV1NTZZcW15a2Q4WkhNd2ZlUHVGV01VRkpYQzZZOHdTSGZiT2pBQTJa?=
 =?utf-8?B?d1d6S21IMUtkMGRLcU0vRkJkaXdqM2tyRFgrYmJWMGlyRU45a2h6TzEwbm1F?=
 =?utf-8?B?REwxcXhzWitLd3J4dnlZZFpSQk1IYU5MbUQwcytwajltSHJwU3RTNGMyVFNY?=
 =?utf-8?B?bWc0cG1UMUhOUGFGempxVDNBS2JXVkdnYktqY0oxS3l0Qzk4bWdCZGZYTys1?=
 =?utf-8?B?emozaUhZa0FPL0xmNlJNVjRYUlo2ODRCWERSN3VHcllqY2hHSjNOaW00bUt3?=
 =?utf-8?B?OS90ODdIU29oanBPZ2oyc0hKUzc0NUJUVWJQd1ZjSzV0ekY0UnA1RGhRTDNL?=
 =?utf-8?B?VEZSMGhyemlUY21QR1VicXROeHBWaElNcjVRZGxpRFNOSlBQVjZPU2kzWTM3?=
 =?utf-8?B?MDNIMFFZVHU4a2FyOWdXcDF0S2ZjdjlSMUxXZnNXZHM1SXBBTkllNFh6TG1B?=
 =?utf-8?B?YUFvem8yeENpanh4N3FXbloxTms2NkRtS1RTVy95Qi9sUUJRN2dPNytEaUpZ?=
 =?utf-8?B?b3cxZFFrQ1BFUE5MN0lIQWw3WDZkak5xUDlFckFNMXpPQ3hVa3NGTWpvRjBx?=
 =?utf-8?B?T0k5WE1mY0NQNVlEcHVnMGNTK2dpWklNZlpvbW52cVAzS2twNHhSUE5GNTZj?=
 =?utf-8?B?QjRFTGFYdk9rbk9hbVpvcXVwSjIxKzlEODhMOGNOaXdCZ1RqZ1l6dlV5MWo0?=
 =?utf-8?B?cUxTWnpyRmc4b2Q2a0JuODJIM3BBdVdqeml4MExwdVJHV2JwbFFnaDhCNXVO?=
 =?utf-8?B?eXIycnlaTTBBVnBUWTdMMjBVbjZYVlJhQzZqbmhpYjU1RnJGalU0aWVza2p4?=
 =?utf-8?B?dlhyVEZ3Zm80TG9xT1gxdkk1a2sxUWJRUHAyMUVRS3dxajltZUhHb0l5Y25G?=
 =?utf-8?Q?aI5E/XcRUR6JGsq6peccr1P6p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912e08cc-bc43-46ee-26a9-08dcc19dbb1a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 04:57:17.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjrWIxaZEvGw6bV7hwa0SX18z6F5c0TI43gaSWSZx3mTQIdCACAW2MoGfO6cAyR+A05IJRTUq8VtiSjEDZnDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224

Hello Rafael,

On Mon, Aug 19, 2024 at 03:34:09PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 8, 2024 at 1:18 PM Dhananjay Ugwekar
> <Dhananjay.Ugwekar@amd.com> wrote:
> >
> > Hello Rafael,
> >
> > On 8/2/2024 6:05 PM, Rafael J. Wysocki wrote:
> > > On Tue, Jul 30, 2024 at 6:53 AM Dhananjay Ugwekar
> > > <Dhananjay.Ugwekar@amd.com> wrote:
> > >>
> > >> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> > >> on AMD processors that support extended CPUID leaf 0x80000026, the
> > >> topology_logical_die_id() macros, no longer returns package id, instead it
> > >> returns the CCD (Core Complex Die) id. This leads to the energy-pkg
> > >> event scope to be modified to CCD instead of package.
> > >>
> > >> For more historical context, please refer to commit 32fb480e0a2c
> > >> ("powercap/intel_rapl: Support multi-die/package"), which initially changed
> > >> the RAPL scope from package to die for all systems, as Intel systems
> > >> with Die enumeration have RAPL scope as die, and those without die
> > >> enumeration are not affected. So, all systems(Intel, AMD, Hygon), worked
> > >> correctly with topology_logical_die_id() until recently, but this changed
> > >> after the "0x80000026 leaf" commit mentioned above.
> > >>
> > >> Future multi-die Intel systems will have package scope RAPL counters,
> > >> but they will be using TPMI RAPL interface, which is not affected by
> > >> this change.
> > >>
> > >> Replacing topology_logical_die_id() with topology_physical_package_id()
> > >> conditionally only for AMD and Hygon fixes the energy-pkg event.
> > >>
> > >> On an AMD 2 socket 8 CCD Zen4 server:
> > >>
> > >> Before:
> > >>
> > >> linux$ ls /sys/class/powercap/
> > >> intel-rapl      intel-rapl:4    intel-rapl:8:0  intel-rapl:d
> > >> intel-rapl:0    intel-rapl:4:0  intel-rapl:9    intel-rapl:d:0
> > >> intel-rapl:0:0  intel-rapl:5    intel-rapl:9:0  intel-rapl:e
> > >> intel-rapl:1    intel-rapl:5:0  intel-rapl:a    intel-rapl:e:0
> > >> intel-rapl:1:0  intel-rapl:6    intel-rapl:a:0  intel-rapl:f
> > >> intel-rapl:2    intel-rapl:6:0  intel-rapl:b    intel-rapl:f:0
> > >> intel-rapl:2:0  intel-rapl:7    intel-rapl:b:0
> > >> intel-rapl:3    intel-rapl:7:0  intel-rapl:c
> > >> intel-rapl:3:0  intel-rapl:8    intel-rapl:c:0
> > >>
> > >> After:
> > >>
> > >> linux$ ls /sys/class/powercap/
> > >> intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-rapl:1:0
> > >>
> > >> Only one sysfs entry per-event per-package is created after this change.
> > >>
> > >> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
> > >> Reported-by: Michael Larabel <michael@michaellarabel.com>
> > >> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> > >> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> > >> ---
> > >> Changes in v2:
> > >> * Updated scope description comment, commit log
> > >> * Rename rapl_pmu_is_pkg_scope() to rapl_msrs_are_pkg_scope()
> > >> * Check topology_logical_(die/package)_id return value
> > >
> > > This patch does not depend on the first one in the series if I'm not
> > > mistaken, in which case I can pick it up separately if you want me to
> > > do that, so please let me know.
> >
> > Sorry for the late reply, was out sick,
> >
> > Yes, please pick this patch separately, it is independent from the first one.
> 
> OK, applied as 6.12 material.

Can this go into 6.11 fixes?

It fixes the commit 63edbaa48a57 ("x86/cpu/topology: Add support for
the AMD 0x80000026 leaf") which got merged in 6.10.

--
Thanks and Regards
gautham.

