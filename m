Return-Path: <linux-pm+bounces-8915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39A9036D0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D907B2551D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B619174EE1;
	Tue, 11 Jun 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d9sCvDlq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24714290;
	Tue, 11 Jun 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094821; cv=fail; b=VvU3gDr5onpf5PRnlGWFwUZv5YoAgQevUUvKSie09i1GA5lUizJaGNb1YxNE7ukIgVhFQJyNT3sVy03g1+muc24XdFUcwk/dooNf5l2mKYtm6rKKvTDm5zZsu4YN0nbJCzqgDaOnDj1H3v9vmv0Anmn1enVGbFsA80+Z60lv9J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094821; c=relaxed/simple;
	bh=jOZfphJPX2XH9GnpOVPnTbrwU4icYKhrICMB+g4GOCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TfVpjMAlZcWjex/t3I7WLXlaRWihUdAqptJ7cpacuAIzYf+uWRtQlQlt6uZZYM9B3FKaD40MKTMIWytSperkJSs87UEm0ew0Bc+iAwVEfhPlfnguAAjS0NnjPZDy783RvwRxYjWxFx4ok0MRYXHiyF2lbP8O9aaOz0wAdzP6Bxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d9sCvDlq; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oceV+KSTKejZ6YPGPdPdYfSmxYouEpPRQ+iDN/QX3R6U3qi05CwtZpOQL/I9rqp8c/xbdYv686CaUxLUL7QbNJ/fn5rL67VpffZt2v0d/Q/3YGim9RHiXlsFpV9CH5G2TMRexGAljzhGoDZTMcG8LLkujGT7dnfu8sVq/9aZkaZ0ZL8D7Fb364+r/OOKvlb5V4V3jKQdn6/WO8eDhOk43vBUL6to/xfMknVBP30qJutTXz1HM7wpG/GgedKINJhlJzo2aHBvK+bjDeHieM7vufBVKM/3VF60tJI238bCSx9waJRdTk7fXgzyh+PkgvEBTm0GsVhO+ggh5lzHwOajRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5QkSwO1XnZB+C2oneelictqudoEW9INVJwvERqre4I=;
 b=gDuXKa+IafkeUT2xQW0iBXYZMSDCmP33BN/4mIGIw8nkXFWMGAUieB/ZngB/DrZkd3UdVjt2uqyZI+7XWtdS/yM5v2s5aMtmTa5r7J5GXsuvCqCvEMgRthJnaag4Q5el43MIJuYVJdRyvKJ9OgKMPtMyoojlRhYxWKZbpoPrS5cCrta+PbJiJRnkeQZJqCz4NREADCvx6sDQT/JRo/dElvxF3o6srJZb8CRTd3xCQzRSAttC1RO+uZqdaZZSDIySd/egCq5OV15WRpj3BuP8ct7qNAO7Ipg3jW9xWR84Oi8M6z06tL/CnquwQHue/LELCyd8BFY8Zon7BkBgsj2Rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5QkSwO1XnZB+C2oneelictqudoEW9INVJwvERqre4I=;
 b=d9sCvDlqrpVaVcdWJ0iOhH32avgeRcfDM0kS5b+MyZhSYwVg/ug/MgV7Va0xueTYdceYUosjiOEZC5c405RUndt6gpzLdeMI0OK/oRzYDV3C5TK6HA31LZVD8lvXNN3Nyqs9n1sRQQkfb8KE4Ef1QDPKLy2spRPtXyIZPQm8HcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:33:36 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 08:33:36 +0000
Message-ID: <a0397a78-1e75-4bb3-bdc7-d28791c448d4@amd.com>
Date: Tue, 11 Jun 2024 14:03:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] perf/x86/rapl: Rename rapl_pmu variables
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
 <20240610100751.4855-3-Dhananjay.Ugwekar@amd.com>
 <050bc53625a3da9bceda56f5196d3840a31e8d8c.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <050bc53625a3da9bceda56f5196d3840a31e8d8c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3612d4-c5e9-46d9-511d-08dc89f12f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1BCakZaSkorL21RUjB2eThpMlNBelRYd3VPcVZTN3VraFFWdVJ2MVlKVFBO?=
 =?utf-8?B?ZE1BcVFxY1ZyOE16bU43d3ZrcEl3MnhmTHZkTXV3aCtMNGZsalVCT3JVMURF?=
 =?utf-8?B?MWY5bG4rS0tkL1dya0ZpUDVrdFIrSktxellGNEJteVN0Y0tNODBuODNoRHpt?=
 =?utf-8?B?WTBlbk1EdUpEWTNuajRkYmJWMmxwamh2SE9BakF0enI3cFllb29ZZnQzZno1?=
 =?utf-8?B?M2tWc3NDeXVnY2hJNkNxNjlkaklETVR4TE43QmNpQ1Exd3VSWWNXYUxMTGlH?=
 =?utf-8?B?T3ZaR0RrWHpxRUN4L01oQnkxQ1hJbmFTQU81dFNkQXBYYk1JZFVVTlBEaDBq?=
 =?utf-8?B?N2M5WHR1Z3lJYnZjWS9XUTBlR2NDZng4WEY5NUk4NXNIUXROR1d4TFA5UGdB?=
 =?utf-8?B?dEJSdmFmY2dOajF2NjlaazNkdlFtTXhRbEs4THpWaDZ2M244amZOb2o3c2dB?=
 =?utf-8?B?amhPb0JKWVhCbVlDMFRsQ3ByY002S3RlQTJ4QlR3ZHJpVmdVMGJENEZBVVgx?=
 =?utf-8?B?cWJ1MVRCbE1HYmRFM0tVdGVPdU1iSUpFRFQ4bWFTbG1RVS9RaSt0MmZ3RmFm?=
 =?utf-8?B?QVdVUy9xVkFZTFFCUnpiak0waE9BcCtMUVFFM3ZidWpoaE1GU1p6NE1zT0hM?=
 =?utf-8?B?Q2V6Tm0rL1JDNlhuWGRXYzBEeDVBUjgrSlFEcVU5NGNvQ0xhY2JRdzNkaWZB?=
 =?utf-8?B?T2RLQzJpUnp5ck9DaFJacytzMDlSUnlocWZVQ1JHcVYySmc3OWU4dVVPSnlK?=
 =?utf-8?B?L3VWQUFHUzhTK3NYQk53VGhQZ2tZWmhBSnB6ZzFYUm43SnU5ZHF5ODd2R0R4?=
 =?utf-8?B?b3hNQ2xjLzFHa2N2VFJFN05SN3MxOHhPeDBnd0cyblRjSndjVUQvWHFFeWNJ?=
 =?utf-8?B?UktoYzRTQ0JUT3BZZGZJWENlQnBSL0pKcmpBMzRoaTZnWkZBOG9EVzNNRm5S?=
 =?utf-8?B?RHY5eWg5Qy9jVi8wSjlmb1RzeGsrdWpwRWplQTRCOHM1UytFL2VGNzRHRVdt?=
 =?utf-8?B?WGJhdlQ1U3JoRitLa1JQd1ZjZHd1RElZcUUzeGdVdXFMRmVHRXMvSzk5YmRI?=
 =?utf-8?B?czRUdG0yUjdHWDQ4MVJzTHdxbjhDbmpjNE4zNUVrNlc2UVJGZitQN3pDb1hN?=
 =?utf-8?B?d3VMcjIrd21udUdoNXo1ZmQxZklVL3FLdjNyZnFjNitnbHY3Y1p4MTZGR1N4?=
 =?utf-8?B?R2tvRllvSnlkWjI4Vk1QTGZTc0dZSGRLZmRoaGxxSTdDS0VQaXRScGNwV1VL?=
 =?utf-8?B?aElPUjkyUWlmVngvYXVVdCs2Y09ZNGRCR0g5NWlCcGxvdXRyeHc4K0dOMUEv?=
 =?utf-8?B?N25DOE9uYitMcWtCOGNCbGxnVFVOazNMTnNiY2VKSkU5dnRyU05ML0Rab2E2?=
 =?utf-8?B?b1FXWjEzdC9GTVhtcWZjNDJTOE5xbWJxRHFvWDVZRktwNHAvem1MRHZhdWhr?=
 =?utf-8?B?dkNIQ29MR3dBTWd2U1J1UWdEU2RLK1hiWmNMeklHNHFUMDNveWJaYXpQY0JO?=
 =?utf-8?B?dEpDK3B0Q0JMNzhBbUw0NHBnaEYvYVZhYVJ5MlI3Z1MyblNOYk1ZS0NTbEVs?=
 =?utf-8?B?bmRoRVhmT2Nyeng4Q01UZ0V4bTIvUVcyeHhzWjBDWnkzaVhCL3cwLzl1VDE1?=
 =?utf-8?B?NTF2RmVvU0x3bmcwc3ZHNGxmcmRTRS92ajIxclI0SmZtK25reFpoTmxXNFdU?=
 =?utf-8?B?U3dSdk15dHJqTjJsUVZvR3BjSzdjck1XMUxYVGdlL2dHVVVQa05oM2tEbk5D?=
 =?utf-8?B?bHRBd2s2elJjUWNSbFhQRkdFUENJelFES3ZpMmh0dW16UXoyMlpXUXVVL3Nz?=
 =?utf-8?Q?q74tkSEOdtz0QMA9r6ZDO8YOU2OnIYDkOz/Lk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkJydDhSb09QdDVqOGtPdGR5bElMSlNFb0dSR05SNXdCRnVTTEExS2cxeWRW?=
 =?utf-8?B?UzZaaVdsUmZsZzNDQjcyNnJmU0FjMzZMdE41UlBwdFhoeU1NaHZ4SFRJSGts?=
 =?utf-8?B?d01oVUFXMEVlZEZaT2tpd21iOGxTWk5tL3FIMGJUZ0loV1YwN0VJQy9TcWkz?=
 =?utf-8?B?VHZBMHZSa01HVlRZVHdJd1hNUmlic29KT2ZtWTNtZWxXOTRRQWl2Rmd4V09M?=
 =?utf-8?B?dFc4Z1VBVWpkYXJtRVlndTkxT2NmOGVWMjVWU0dWeUFQOHAvandWV1ZOSXVy?=
 =?utf-8?B?N0hDa3hORXJxMmVGOCtHRmNWVWlaT1VsbHU1Wnh3SnFwWXpSOEl4OHVDcVpr?=
 =?utf-8?B?WHpQK1Vya1NoQmNSVGFWL2c1SWxTMGNsdm82RmpTRHhLNkxkWmNKQlM2K0pI?=
 =?utf-8?B?OU80Q2t3Q2F3K0lPb0JjaFhQdlhmVHB6TWMzamhjRTNyTFFKSG5TbDZqeGdR?=
 =?utf-8?B?aHZaTmpEZU8xNXhSdFlPN1BjdXhiRlJ5TUdVZDZZL0YzVnFmSllidjFlRTVt?=
 =?utf-8?B?UlFOVFQ5SDgveVowSzBlaDNKanFGOTFQNXFlMFJROEYwN2drVUZGSnBXb25B?=
 =?utf-8?B?VkdtN2xPQ1dCZXBPcU9IU1VINTN1Y2NlRkNJRG9KNyt2V2NoR01qZVhOQkZX?=
 =?utf-8?B?U0xYYnBxNlM2N2xjZy9SVFM0VGZ3MERXam1QT2ptMTF5dnNFUjMwWXJBbXda?=
 =?utf-8?B?VFpVK0J1NVhNVzB5RWJQUEJ6blJrSDJOOEM4ZkJGZlNTRGNPQUlRQ1UxN1g5?=
 =?utf-8?B?Y0ovZVBBOG04ZG12K0M3MzdkT2JrV0N1c09BaDArVCtHMS9qSVZqbUxwd1Er?=
 =?utf-8?B?OGtXWXNwMkwxYTJUQWhsTW9JZmZqWXBnT2FleWc3VkF5bkdqVU1WNjFjbFlw?=
 =?utf-8?B?QlVNaHhFK1VZb2hSMkZUZStIemFDZW4vSVk0bHZXSEF4dy95S0NmeEZYTEND?=
 =?utf-8?B?YTV2MlA0NlRUa1c4V3BIVzZFQ2VVRjFJVFM0R3BVZ3BQSWRqMEM0TXFIR2py?=
 =?utf-8?B?WmJ3SXp2bm5jY3U4MVFUSy8zZm50TG1mOGJMTHRHbGpKblhoWmFDcDVQVHlI?=
 =?utf-8?B?Y0FDcEQyei9KSmZvTWNKR25LNDNLTFdOUDJoVUFTYWxybEZCMWJBZkFBR3VO?=
 =?utf-8?B?blVkT0JDcVpuRHFsblRCbTFwZjJpeldCck9oaXJnUGhXdUttV3ZxZDh4WU1Z?=
 =?utf-8?B?WWc5OW91YmpEMG81WEZtMG9ldDloQVFmWWovWXNKK3hra0FpN2lJYXFCaEJJ?=
 =?utf-8?B?WDJEb3BxVlJBTThaaG51T0hNTlE2K3hSTWx1ZHZucnR5dnh5VnNGdk9rUE9u?=
 =?utf-8?B?dGtucHhtZUNYaTYvQUFqUktCL1RxaDdoaDNZa0I5Z053Si9jMUh1Q3hsYmVH?=
 =?utf-8?B?Q0xBV0VlTG4yWVpDZ1dNL00yVnlKb0JBTzVyK2ZXckJGRCtJbFRjdG1TZTZQ?=
 =?utf-8?B?a0tUMStrTmloVmVkY0cyNFJpWnZIZlZGVFg3bU5IcjZZZFNSSVpjZVZJM3pJ?=
 =?utf-8?B?emIwS285RXh2S05oMkdadys5S3pxUmVxbU8rWFVHOHNuN3VyTlNGMzZCS25K?=
 =?utf-8?B?bldRVjg5N1F6QnBGYmlJTHNmY2VmaGNIMzdkWG1KRWUyWSs5NStQc0ZqZUs0?=
 =?utf-8?B?RDA1L0tMSlpFejBWcnJET2t2NjEyenRRSDZJKzlsa2ZTYnQ5S1duNWFFMmN4?=
 =?utf-8?B?V0tDVmlXaVdCM3ZNS0F5U1JNVE1acy8zM3BsT2E1RjJZMzVyNEs5cUpwMXNs?=
 =?utf-8?B?K2NjSHU3czdvcFExUDFnVEJDUHVqTTNEWTNxMlBFUTc2enJvVEdod1JqTTZw?=
 =?utf-8?B?UG5zdEhjSnd0b1FiS0NQVTRIWjIvZDIwSlNGb2xaYmRsaFg2ZTNJb1BkTE13?=
 =?utf-8?B?NytGcEJOSjBBRTZkVVhrejVHdzVzeC9KZTZlMXdPbU5QYTB6bk9ObjYycmVp?=
 =?utf-8?B?QkVSNzRzNWZWbkNlelIycVh2SWI0MHBpZVdoYUxLOXZsaXFHbnhFN0M0N3Qr?=
 =?utf-8?B?QS96WFRxVnUwenozRTlEMnVzMS9sNDM4Ry9Pb0Q3RVVkQ2JlaWc4clI5SVRO?=
 =?utf-8?B?UzlvS3pYTTJCbHF3RGJzRGV3RWY0S0RzbmdibXIyTlJZd1lodDRIM1d2YUdN?=
 =?utf-8?Q?biQxu6HDBuTfrZAjLTP63iQW6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3612d4-c5e9-46d9-511d-08dc89f12f56
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:33:35.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMkW/VecTx49IIRJ1cKR1iqg3D04HKdY1aTA1/d7xLeg9SRD6nHFp2bz0W9svd4NFrcx8bzC1SFlMRRJpXprcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

Hello Rui,

On 6/11/2024 11:13 AM, Zhang, Rui wrote:
> On Mon, 2024-06-10 at 10:07 +0000, Dhananjay Ugwekar wrote:
>> Rename struct rapl_pmu variables from "pmu" to "rapl_pmu", to
>> avoid any confusion between the variables of two different
>> structs pmu and rapl_pmu.
>>  As rapl_pmu also contains a pointer to
>> struct pmu, which leads to situations in code like pmu->pmu,
>> which is needlessly confusing. Above scenario is replaced with
>> much more readable rapl_pmu->pmu with this change.
>>
>> Also rename "pmus" member in rapl_pmus struct, for same reason.
>>
> 
> As you are adding a new per_core pmu, can we just rename the current
> rapl_pmu to something like rapl_pkg_pmus (as I mentioned in the
> previous email, we can consider the current RAPL MSRs as package scope
> on Intel platforms as well), and name the new one as rapl_core_pmus?

Sure this makes sense, will modify the original "rapl_pmus" variable name, 
but please note the renaming that I refer to in this patch is only 
limited to the local "struct rapl_pmu" variables used inside functions,
not the global variable name you mention.

Regards,
Dhananjay

> 
> IMO, "rapl_pmus" + "rapl_pmus_per_core" is still confusing.
> 
> thanks,
> rui
> 
>> No functional change.
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>  arch/x86/events/rapl.c | 104 ++++++++++++++++++++-------------------
>> --
>>  1 file changed, 52 insertions(+), 52 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index 73be25e1f4b4..b4e2073a178e 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -120,7 +120,7 @@ struct rapl_pmu {
>>  struct rapl_pmus {
>>         struct pmu              pmu;
>>         unsigned int            nr_rapl_pmu;
>> -       struct rapl_pmu         *pmus[] __counted_by(nr_rapl_pmu);
>> +       struct rapl_pmu         *rapl_pmu[]
>> __counted_by(nr_rapl_pmu);
>>  };
>>  
>>  enum rapl_unit_quirk {
>> @@ -164,7 +164,7 @@ static inline struct rapl_pmu
>> *cpu_to_rapl_pmu(unsigned int cpu)
>>          * The unsigned check also catches the '-1' return value for
>> non
>>          * existent mappings in the topology map.
>>          */
>> -       return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus-
>>> pmus[rapl_pmu_idx] : NULL;
>> +       return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus-
>>> rapl_pmu[rapl_pmu_idx] : NULL;
>>  }
>>  
>>  static inline u64 rapl_read_counter(struct perf_event *event)
>> @@ -228,34 +228,34 @@ static void rapl_start_hrtimer(struct rapl_pmu
>> *pmu)
>>  
>>  static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer
>> *hrtimer)
>>  {
>> -       struct rapl_pmu *pmu = container_of(hrtimer, struct rapl_pmu,
>> hrtimer);
>> +       struct rapl_pmu *rapl_pmu = container_of(hrtimer, struct
>> rapl_pmu, hrtimer);
>>         struct perf_event *event;
>>         unsigned long flags;
>>  
>> -       if (!pmu->n_active)
>> +       if (!rapl_pmu->n_active)
>>                 return HRTIMER_NORESTART;
>>  
>> -       raw_spin_lock_irqsave(&pmu->lock, flags);
>> +       raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
>>  
>> -       list_for_each_entry(event, &pmu->active_list, active_entry)
>> +       list_for_each_entry(event, &rapl_pmu->active_list,
>> active_entry)
>>                 rapl_event_update(event);
>>  
>> -       raw_spin_unlock_irqrestore(&pmu->lock, flags);
>> +       raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
>>  
>> -       hrtimer_forward_now(hrtimer, pmu->timer_interval);
>> +       hrtimer_forward_now(hrtimer, rapl_pmu->timer_interval);
>>  
>>         return HRTIMER_RESTART;
>>  }
>>  
>> -static void rapl_hrtimer_init(struct rapl_pmu *pmu)
>> +static void rapl_hrtimer_init(struct rapl_pmu *rapl_pmu)
>>  {
>> -       struct hrtimer *hr = &pmu->hrtimer;
>> +       struct hrtimer *hr = &rapl_pmu->hrtimer;
>>  
>>         hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>>         hr->function = rapl_hrtimer_handle;
>>  }
>>  
>> -static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
>> +static void __rapl_pmu_event_start(struct rapl_pmu *rapl_pmu,
>>                                    struct perf_event *event)
>>  {
>>         if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
>> @@ -263,39 +263,39 @@ static void __rapl_pmu_event_start(struct
>> rapl_pmu *pmu,
>>  
>>         event->hw.state = 0;
>>  
>> -       list_add_tail(&event->active_entry, &pmu->active_list);
>> +       list_add_tail(&event->active_entry, &rapl_pmu->active_list);
>>  
>>         local64_set(&event->hw.prev_count, rapl_read_counter(event));
>>  
>> -       pmu->n_active++;
>> -       if (pmu->n_active == 1)
>> -               rapl_start_hrtimer(pmu);
>> +       rapl_pmu->n_active++;
>> +       if (rapl_pmu->n_active == 1)
>> +               rapl_start_hrtimer(rapl_pmu);
>>  }
>>  
>>  static void rapl_pmu_event_start(struct perf_event *event, int mode)
>>  {
>> -       struct rapl_pmu *pmu = event->pmu_private;
>> +       struct rapl_pmu *rapl_pmu = event->pmu_private;
>>         unsigned long flags;
>>  
>> -       raw_spin_lock_irqsave(&pmu->lock, flags);
>> -       __rapl_pmu_event_start(pmu, event);
>> -       raw_spin_unlock_irqrestore(&pmu->lock, flags);
>> +       raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
>> +       __rapl_pmu_event_start(rapl_pmu, event);
>> +       raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
>>  }
>>  
>>  static void rapl_pmu_event_stop(struct perf_event *event, int mode)
>>  {
>> -       struct rapl_pmu *pmu = event->pmu_private;
>> +       struct rapl_pmu *rapl_pmu = event->pmu_private;
>>         struct hw_perf_event *hwc = &event->hw;
>>         unsigned long flags;
>>  
>> -       raw_spin_lock_irqsave(&pmu->lock, flags);
>> +       raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
>>  
>>         /* mark event as deactivated and stopped */
>>         if (!(hwc->state & PERF_HES_STOPPED)) {
>> -               WARN_ON_ONCE(pmu->n_active <= 0);
>> -               pmu->n_active--;
>> -               if (pmu->n_active == 0)
>> -                       hrtimer_cancel(&pmu->hrtimer);
>> +               WARN_ON_ONCE(rapl_pmu->n_active <= 0);
>> +               rapl_pmu->n_active--;
>> +               if (rapl_pmu->n_active == 0)
>> +                       hrtimer_cancel(&rapl_pmu->hrtimer);
>>  
>>                 list_del(&event->active_entry);
>>  
>> @@ -313,23 +313,23 @@ static void rapl_pmu_event_stop(struct
>> perf_event *event, int mode)
>>                 hwc->state |= PERF_HES_UPTODATE;
>>         }
>>  
>> -       raw_spin_unlock_irqrestore(&pmu->lock, flags);
>> +       raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
>>  }
>>  
>>  static int rapl_pmu_event_add(struct perf_event *event, int mode)
>>  {
>> -       struct rapl_pmu *pmu = event->pmu_private;
>> +       struct rapl_pmu *rapl_pmu = event->pmu_private;
>>         struct hw_perf_event *hwc = &event->hw;
>>         unsigned long flags;
>>  
>> -       raw_spin_lock_irqsave(&pmu->lock, flags);
>> +       raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
>>  
>>         hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
>>  
>>         if (mode & PERF_EF_START)
>> -               __rapl_pmu_event_start(pmu, event);
>> +               __rapl_pmu_event_start(rapl_pmu, event);
>>  
>> -       raw_spin_unlock_irqrestore(&pmu->lock, flags);
>> +       raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
>>  
>>         return 0;
>>  }
>> @@ -343,7 +343,7 @@ static int rapl_pmu_event_init(struct perf_event
>> *event)
>>  {
>>         u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>>         int bit, ret = 0;
>> -       struct rapl_pmu *pmu;
>> +       struct rapl_pmu *rapl_pmu;
>>  
>>         /* only look at RAPL events */
>>         if (event->attr.type != rapl_pmus->pmu.type)
>> @@ -373,11 +373,11 @@ static int rapl_pmu_event_init(struct
>> perf_event *event)
>>                 return -EINVAL;
>>  
>>         /* must be done before validate_group */
>> -       pmu = cpu_to_rapl_pmu(event->cpu);
>> -       if (!pmu)
>> +       rapl_pmu = cpu_to_rapl_pmu(event->cpu);
>> +       if (!rapl_pmu)
>>                 return -EINVAL;
>> -       event->cpu = pmu->cpu;
>> -       event->pmu_private = pmu;
>> +       event->cpu = rapl_pmu->cpu;
>> +       event->pmu_private = rapl_pmu;
>>         event->hw.event_base = rapl_msrs[bit].msr;
>>         event->hw.config = cfg;
>>         event->hw.idx = bit;
>> @@ -560,22 +560,22 @@ static struct perf_msr amd_rapl_msrs[] = {
>>  static int rapl_cpu_offline(unsigned int cpu)
>>  {
>>         const struct cpumask *rapl_pmu_cpumask =
>> get_rapl_pmu_cpumask(cpu);
>> -       struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>> +       struct rapl_pmu *rapl_pmu = cpu_to_rapl_pmu(cpu);
>>         int target;
>>  
>>         /* Check if exiting cpu is used for collecting rapl events */
>>         if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
>>                 return 0;
>>  
>> -       pmu->cpu = -1;
>> +       rapl_pmu->cpu = -1;
>>         /* Find a new cpu to collect rapl events */
>>         target = cpumask_any_but(rapl_pmu_cpumask, cpu);
>>  
>>         /* Migrate rapl events to the new target */
>>         if (target < nr_cpu_ids) {
>>                 cpumask_set_cpu(target, &rapl_cpu_mask);
>> -               pmu->cpu = target;
>> -               perf_pmu_migrate_context(pmu->pmu, cpu, target);
>> +               rapl_pmu->cpu = target;
>> +               perf_pmu_migrate_context(rapl_pmu->pmu, cpu, target);
>>         }
>>         return 0;
>>  }
>> @@ -584,21 +584,21 @@ static int rapl_cpu_online(unsigned int cpu)
>>  {
>>         unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>>         const struct cpumask *rapl_pmu_cpumask =
>> get_rapl_pmu_cpumask(cpu);
>> -       struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>> +       struct rapl_pmu *rapl_pmu = cpu_to_rapl_pmu(cpu);
>>         int target;
>>  
>> -       if (!pmu) {
>> -               pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL,
>> cpu_to_node(cpu));
>> -               if (!pmu)
>> +       if (!rapl_pmu) {
>> +               rapl_pmu = kzalloc_node(sizeof(*rapl_pmu),
>> GFP_KERNEL, cpu_to_node(cpu));
>> +               if (!rapl_pmu)
>>                         return -ENOMEM;
>>  
>> -               raw_spin_lock_init(&pmu->lock);
>> -               INIT_LIST_HEAD(&pmu->active_list);
>> -               pmu->pmu = &rapl_pmus->pmu;
>> -               pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>> -               rapl_hrtimer_init(pmu);
>> +               raw_spin_lock_init(&rapl_pmu->lock);
>> +               INIT_LIST_HEAD(&rapl_pmu->active_list);
>> +               rapl_pmu->pmu = &rapl_pmus->pmu;
>> +               rapl_pmu->timer_interval =
>> ms_to_ktime(rapl_timer_ms);
>> +               rapl_hrtimer_init(rapl_pmu);
>>  
>> -               rapl_pmus->pmus[rapl_pmu_idx] = pmu;
>> +               rapl_pmus->rapl_pmu[rapl_pmu_idx] = rapl_pmu;
>>         }
>>  
>>         /*
>> @@ -610,7 +610,7 @@ static int rapl_cpu_online(unsigned int cpu)
>>                 return 0;
>>  
>>         cpumask_set_cpu(cpu, &rapl_cpu_mask);
>> -       pmu->cpu = cpu;
>> +       rapl_pmu->cpu = cpu;
>>         return 0;
>>  }
>>  
>> @@ -679,7 +679,7 @@ static void cleanup_rapl_pmus(void)
>>         int i;
>>  
>>         for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
>> -               kfree(rapl_pmus->pmus[i]);
>> +               kfree(rapl_pmus->rapl_pmu[i]);
>>         kfree(rapl_pmus);
>>  }
>>  
>> @@ -699,7 +699,7 @@ static int __init init_rapl_pmus(void)
>>         if (rapl_pmu_is_pkg_scope())
>>                 nr_rapl_pmu = topology_max_packages();
>>  
>> -       rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus,
>> nr_rapl_pmu), GFP_KERNEL);
>> +       rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu,
>> nr_rapl_pmu), GFP_KERNEL);
>>         if (!rapl_pmus)
>>                 return -ENOMEM;
>>  
> 

