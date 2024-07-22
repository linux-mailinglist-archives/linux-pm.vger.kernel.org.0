Return-Path: <linux-pm+bounces-11291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0994F938B22
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61172812AA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E4161B43;
	Mon, 22 Jul 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PbrcvOGP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272C125BA;
	Mon, 22 Jul 2024 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636688; cv=fail; b=uwoACKLyS+nwdNL/hXOFmB6oyuqEU8fj7DREGbYKK0b0RwzzNQjFNFt2BpxV/ttz+itB3eGGFct9Li/Rr/3PCsZ19NCNbrdxiLWv9yIQvCSR5OawTZCLEsi4TM3Td2jvtMIKzq0lp2Zpig49P/o0+dRT6GCCTrP43owt6FSute4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636688; c=relaxed/simple;
	bh=OfJ8siL0e5uIlGA3aBjPMdD2JuWjUlquh+6JKSX0g/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i1wx3cVNoZiJhX8qF+Qeppi1d/RkiNLeyN2ZCDR16pQXr3yB6AWTgpQVgVJYBO8O2KejS2cmqSQMyaMCFjJr3l+MRcVxytY+MjOCs+siWwcOohUury6LfdmlAOFnjJWZubcLGsCcumYCLM+O+F3Uyd9MW89mh3UXwwpSztQs3Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PbrcvOGP; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HserMm+QV33quBWVzHTI+uYFAz1J+WzenEIKE4BGQQiL/Bga5Y0+STbnKG0rlKbUMAXzUUg48fYsj8hOHiyPT8kUDXzl1DeYUglGx4Jm3zcnxHhq3TLWpcdq995Sr2Wju1LpZDcxb/Z3TsAyrDNsrKkuuckOchIluc9FaNzGWEpmPmng+0fn3LEOav1VbrgwcO7EyB5b3q8IcoBd70BA4t5J9nI4c2kVQ2tcw7yfymX2EhjkdsdA5i6lRnTNQJ/LvuhYXaLTez2IWEoniquFN8XFMS4iTX/H3XqpaZypAjyiVdtSWyYL0977noP1xLCEw5L0GNZmzG0L5cFYQLkTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No7SzoMXUp2ojYGgdWy4yJq87YxPctSRotkPYKAPtu0=;
 b=LNmpJra53mUw5koUsXfhyRKPYztNwuDyQPE2n2zgKOjKIeBVxqrrUnjXhSNlODqPrQxxuetsvcKYLf2J9gyLCdys7NGVkQBiErCucv7+GSvjWIfg01u60oC5uv6U95IcWYwC/5zKYa1a6S0B3Eozd0PHlUHtE/U7chomLSdIk75O7ObdTkkfcJvtX7BF+e3EXuuWSQbraMgcEyu4t1ppncMwPkQ/wuz5LPQWpLzu+UAtCAsmI9PZ8KhqxeB0jmnoxFD1xyAee1jQh9LIIq8mes9aqVu474iqaqRWPV3DOuUAsujQJaRJJ/enjIyl9gtK8Xx6mTrFmWqLAUv1VcVH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No7SzoMXUp2ojYGgdWy4yJq87YxPctSRotkPYKAPtu0=;
 b=PbrcvOGP8usKUB5uXZVaXDZiA9S9qIU+6d7pTQSOYy5NDTt/6pWNbABu7b2a8V7lGzXglKi2mcZB4m9PKSpcscEZXJRFrqFDZSsGvShu5onU6DRfmYfcjh0HqSOPI7ZRKs/viboazbXo5zDd410v6GGFR3EEXka8atJjZ96r1JQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 08:24:43 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%5]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 08:24:43 +0000
Message-ID: <9c492669-d97b-4040-bdcf-e7f5a5ac7e09@amd.com>
Date: Mon, 22 Jul 2024 13:54:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powercap/intel_rapl: Fix the energy-pkg event for AMD
 CPUs
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "irogers@google.com" <irogers@google.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Larabel, Michael" <michael@michaellarabel.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>
References: <20240719092545.50441-1-Dhananjay.Ugwekar@amd.com>
 <20240719092545.50441-3-Dhananjay.Ugwekar@amd.com>
 <2a81f438306b82620bb4db9065d2cbf3e4c2d56c.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <2a81f438306b82620bb4db9065d2cbf3e4c2d56c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::21) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d89845-fed6-4f0a-08e6-08dcaa27bcd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGRSeFh3T3FJRjEwcjJEMUl3cU1vOWFuTSttTmxtem1DSDBBNXNHNHBPTlFh?=
 =?utf-8?B?K2RtV1RQZ0hLZEhOaXYzcHBKNDZKNGpPcmwrVU5mdUdZbGxRRDVkQ3J4ajFi?=
 =?utf-8?B?dWpkU3ZWYjlEYnlXckxsOWsrNmVUR1J4RjJjVGd5ZXk0ckR2bnVvQVhIek4w?=
 =?utf-8?B?SW40V2JGNW1IcVo0aDdoeUY4cGpHT0x1MHJNdUZENFp4ay9LdEo4QjNTcE55?=
 =?utf-8?B?aVNRWEtOODJZZEp4aFhpdjVMaUpSd0QzUHE4bC9kUjY0L2FjRTB5MkdBUExI?=
 =?utf-8?B?WnkwQVgzejlzM0hmaGt3clQyZzI0aE9uL3hZQ1c3anhIVDRma05tcTJWT2pQ?=
 =?utf-8?B?NGYrMjFZU1E4b21HRkRsZHUwM0QwVk9GTjQ1Wm5EbXN5cXJyQ05wTUFQeTlG?=
 =?utf-8?B?b1pKR0lpb0RpUjJKbjdDM09HSzQ0N0dpeHlNeHg0emFIaFJVbFl0ekVjRTNq?=
 =?utf-8?B?V1c0N1UwZ0JMS21wQTdrL1hqa1AvY2YvZ2hQNnBzRXY2ZXJSaEQvUW9SRzlN?=
 =?utf-8?B?STRSVU1wbVdsRTRpZHBsRGllam5UclRCMmVDL1JSUWpQWmJ5ZHltOVpYVGxa?=
 =?utf-8?B?dmVBeVRBMEFIYnRjMURsYStoa3ZPZVJtZnVGSSsvRFdja2ZMRFI4N2xVYnRt?=
 =?utf-8?B?R29iU2tRU2d2Mlh2STJkb2ZyNnAya3VIRmFHSFNkazBRd29ibndhUTJmSVQ5?=
 =?utf-8?B?T0tMMFA3bzdmNUlxRHpXWDdIK2lYMmpDcktpS3RTQUFlemMxdWtTZGNzWG5m?=
 =?utf-8?B?KzNPOWhIK3NwUzRhQ0RBQldMWVRkNURkQWF2N1lTWHdBVUpmWjg5bkJGS3Ix?=
 =?utf-8?B?d0dZL3pqS2J5Rk56Zy9HN2RlOWV6OVdrUCtmYXF0TG9XdFJvS1BrNlZNek1t?=
 =?utf-8?B?bjJ5NUdnbHZ3ZU5TOGNUYVBtSDVKTmxmQVhhT3JKa2hia3N5MUdBaWtXRVFw?=
 =?utf-8?B?QjZqTnVIc2xCQTArcnIwVnhUdkpwcjRPSXZSQmYrK1ZzSVRyZjcxSUxheWJK?=
 =?utf-8?B?TFpublZvR093dzRDdlZGaW9GWlVrRnRYQy83cVZFUk9ScnFzVFhmT2J5MXZk?=
 =?utf-8?B?WVFOazBkMUpRcTVPMjVic2trRFVldzRSeG9haDhicXovRDc2L2haRFI1NEhE?=
 =?utf-8?B?Szh4dlhXUG1LM0g5Ny9Cc3Rmd0NUT3NLdWZ3TUt4c0s5QXNXRGdYamQ1dS9F?=
 =?utf-8?B?dU9xazF0NHRVSTJYYXRZVG9oRExkK0hkNmVTY1VRa0lBeDdobHRodWJ5RDhx?=
 =?utf-8?B?akphSkNzTXlSQlorOGxENmlYdXE0dVMyWmpHSldCNURTSnBISjJ1K1BSN3dH?=
 =?utf-8?B?YU1mOXRiMlc2b09zSmM0WVh2bFplYmlGSXRyV3VTY0o0RnQwRmIvUDROa29k?=
 =?utf-8?B?SHhMRlF5TmlMKzRVRGZ3aXhNVUFNbWtoandpc0xKRW82NlZqNWZIWnliV0RK?=
 =?utf-8?B?c3JuUDR0UFRWWDlDdHIrNVNCUSsvNlg1eVQ2MGJiNCtNKzYxNEtpN29wMkEz?=
 =?utf-8?B?YTNKUnJWSEVQWXBTRVI1RmRRODdZOXNpSEUrbzlKODloNHpoMXZWNmg3VTV0?=
 =?utf-8?B?NVVXekdGaWlYaW1SVnVYaXlTNUNVbFFHT2lzNVFwK2tzSThsOG8xWENJUE91?=
 =?utf-8?B?cWpvY3FxTG1QdE1aRUlCeXk5TG5zTUMwWVFOYmIrbDAxc2lTUEVQcG1rK2tv?=
 =?utf-8?B?dlpTckhHS2hKZTNKWTBhTDVMa2ZlQkZVVkNvem9hS1h1VVY1VFNYNnBGbEM3?=
 =?utf-8?B?RUF2ckJyaUQ3QnN6VVdqK2xodHl4VlQ3U2piZlJDN2JqUXY2VEVmeHlXMWli?=
 =?utf-8?B?UkEyMlhRT3U3N3pLUVdTYzVpL0pHSWV0dmk5WnhMR3pBdkRkY2F1K1hLZnFr?=
 =?utf-8?Q?PilEC5Wg6jqJ8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlFCck5EWTBEb1hQZVA5N3k1anpJYXV1S1luNVlvVEpKb1V6V2YvU0lNblE2?=
 =?utf-8?B?b2tRd2NQbzhldzJweCtNaTlnVFlmT3Qwd2dNRTBKdy9zRDR0SEZoVXczRGw5?=
 =?utf-8?B?S0hYTjAwQjhFSkxJampvZ1hlZ3o5K0lSYUtXY1pkcmdJd29KaVRjSnJnZXdG?=
 =?utf-8?B?Z0ZXQ3JzVXpPRWFKWG94WjZ6UTlYRnpTeUJaRFZiSmwyWDRNb1pRT3NFaDc0?=
 =?utf-8?B?N1ptMDkrVjRxSXo0RHR0b0RMczZhRFExaThuNGtKd2E2ZUYwSno2M1VkaFdZ?=
 =?utf-8?B?cUM1czlEa0RhQUZMdG1TNzlwMUM5VmJyQTVSOW5DTk9STUhPM1FYRHk0M2Ev?=
 =?utf-8?B?NURSa2NMOWJwcjRqMUdQWDBKL2Q2MUFiQVB2OHJ5a053UGZpc29WSGFMZEpH?=
 =?utf-8?B?SG41aVNoWkppSXVQRUF3VXZCTFNEK1RHaE1uVVozZzR4NjFRaXRrNWJjejlD?=
 =?utf-8?B?OXYwNkhlb0xXZHVsTmRoQ1FIUG5SNGlJOUxVQmd1YjcxMWZzZGhlUTdwMnFV?=
 =?utf-8?B?dk5GMnpBVUU0c3Y3QVZkMWVJWk1KK0h2UHFxbTZnQTROOVBmQkdTcUw2WUdi?=
 =?utf-8?B?YUM4T1ljR292aFdZaEhEbjFPeUwwNmxPeWU0QnpqTWxuc0c2c1ZhVnNTdzZm?=
 =?utf-8?B?WktjUWt1Q3hDVzlTSm9XWTFlM21YaVJrdURMQVZuNVo5VWQrdUhSTWhqK0Q5?=
 =?utf-8?B?WjRNeHZqeTMzU0dXSnVMVy9ER2EwcTdPZDVzN0ZOVUZTN2RlSEhFcXlUcnpM?=
 =?utf-8?B?eHYvODl2UmJiUVhqNTV6d0pVZVN4QmRKd0dzYlJUUlJxQmhmaGdQeXlOSlpD?=
 =?utf-8?B?Mi9yMi9UUXNvWitEcnZ0cmNOdUhPMDJCRVh3TFkrUU1tZnBBUGdHemwvQnJB?=
 =?utf-8?B?SHJrQ3d2ditXayt2VEVHVkkrcVlPM1l4MWllaVdQNGtubzFhZlc1RlI4RzBT?=
 =?utf-8?B?ZVRkc1EydERNSnpIdy9walFvN0VSS3dFUjJpTVV2SWowcXNVcmhsRlhEeS9a?=
 =?utf-8?B?Mm5HeGxlVWRaT1Z2c2xzM3VhcC9pT0QxVkZOZ3UrT0tMVUt6Qm4wRkdwczBE?=
 =?utf-8?B?bnp6L1RhRDdLQlUxdEdpaW1acHg3OFRPVlFvYTRSRHNpZk1wM1pDamNlVXdv?=
 =?utf-8?B?dkUvclhCbjdUS2lNTzBVbkpPMmhNYXd0Nk9mNEhVTmtXZlNIdS9UbTZ0aStQ?=
 =?utf-8?B?T0REOXFLTHFkczVXaDRpSDJqNSswQWJ0dEhRQmpjbER2SXB0NUZoNEVZaWlR?=
 =?utf-8?B?TEVoZ2tZVjJVWStuTklaSHM4SHJYRWNFaHZpWUVTVEEwVU45OHV3cGV1eGdj?=
 =?utf-8?B?SkJzTlZDc2o3cGQydzZiZk9nS2czQzJrdGc0RnV0ZVYyU1kzNHNRMzBoU3Jl?=
 =?utf-8?B?NUtyeUQvV3lreWozU1lXcDhnQm9aTDRpQTZSZEFUY1VwWTAyMEV4N0k1SU9a?=
 =?utf-8?B?ZzJ1a2VMNUhOV0IwZFgyQ1lOdDlzaDF2NkFtT3F6M0IrUHRDNGpYeEVpVzFO?=
 =?utf-8?B?aFNjOUxFK3pOTnQ0eGJXTko3THFJMHJuVU5ZaUd0OXR2ZUo5bGxBcGxZaXh6?=
 =?utf-8?B?cFI3Wld1RE9qQyt6Z2NTUU13REI0RTA3emUvbk1kdm94UU42SUhBV0lTbFNx?=
 =?utf-8?B?bnRWRmt5WHBmYkxpd3JQQjBGTFpqYWdMZXphajdIWXVRaGVrRzBVUDBweXRK?=
 =?utf-8?B?K2lNb0VNUEl0cFF6Um9Ob0piSDMrdnZLQ24zdlhGc0wvNXYzcGxrN2JRWW0z?=
 =?utf-8?B?dFpReXlaS3FvUWNFV3Q3RjJHcVhBc0FHWHl4dDdqZ3ZEWGg3Vlo2VkVLK1FX?=
 =?utf-8?B?eDZCYys4SGdaZDdEUHhsRzRoQUQvT3g0a09QQ1dnQ0Y5cjJ5V3Q1eHVLZStS?=
 =?utf-8?B?QnQvODJoSy9peC9HcmR5S0ZvMlhRRnBBYzR5bk5OZHVPb2dSd0RObXYreUFQ?=
 =?utf-8?B?czB6ZWlzT2pTc0Fibmw1a2lMb3h2U0JRdk9vQ2hrN09wQ1Q0ejFFMG93MFRG?=
 =?utf-8?B?cEkxSUkxeWJyc2sxMll4OW9TZk50MzhIaFJwNXVCWWRKWGw0cGpXcUFKZXVw?=
 =?utf-8?B?L3gvTUk1VGxUNStsL2dVKzgzN3lIcGFPS2hRMEROaGxsTFk4OFNUcFZBSUJl?=
 =?utf-8?Q?pi+OnkWGnpswqU1qJdgYGZ/1D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d89845-fed6-4f0a-08e6-08dcaa27bcd7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:24:43.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/PRJA4O4ph2O8Kp4ZdAoVoPhYy3OvCBoykcWhTMsO/5yrxNvmxxqQfXuQJpUwZflDsw0FTsFivHPQyJAWS2OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233

Hi Rui,

On 7/21/2024 7:47 PM, Zhang, Rui wrote:
> On Fri, 2024-07-19 at 09:25 +0000, Dhananjay Ugwekar wrote:
>> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026
>> leaf"),
>> on AMD processors that support extended CPUID leaf 0x80000026, the
>> topology_logical_die_id() macros, no longer returns package id,
>> instead it
>> returns the CCD (Core Complex Die) id. This leads to the energy-pkg
>> event scope to be modified to CCD instead of package.
>>
>> For more historical context, please refer to commit 32fb480e0a2c
>> ("powercap/intel_rapl: Support multi-die/package"), which initially
>> changed
>> the RAPL scope from package to die for all systems, as Intel systems
>> with Die enumeration have RAPL scope as die, and those without die
>> enumeration are not affected. So, all systems(Intel, AMD, Hygon),
>> worked
>> correctly with topology_logical_die_id() until recently, but this
>> changed
>> after the "0x80000026 leaf" commit mentioned above.
>>
>> Replacing topology_logical_die_id() with
>> topology_physical_package_id()
>> conditionally only for AMD and Hygon fixes the energy-pkg event.
>>
>> On an AMD 2 socket 8 CCD Zen5 server:
>>
>> Before:
>>
>> linux$ ls /sys/class/powercap/
>> intel-rapl      intel-rapl:1:0  intel-rapl:3:0  intel-rapl:5:0
>> intel-rapl:7:0  intel-rapl:9:0  intel-rapl:b:0  intel-rapl:d:0
>> intel-rapl:f:0  intel-rapl:0    intel-rapl:2    intel-rapl:4
>> intel-rapl:6    intel-rapl:8    intel-rapl:a    intel-rapl:c
>> intel-rapl:e    intel-rapl:0:0  intel-rapl:2:0  intel-rapl:4:0
>> intel-rapl:6:0  intel-rapl:8:0  intel-rapl:a:0  intel-rapl:c:0
>> intel-rapl:e:0  intel-rapl:1    intel-rapl:3    intel-rapl:5
>> intel-rapl:7    intel-rapl:9    intel-rapl:b    intel-rapl:d
>> intel-rapl:f
>>
>> After:
>>
>> linux$ ls /sys/class/powercap/
>> intel-rapl  intel-rapl:0  intel-rapl:0:0  intel-rapl:1  intel-
>> rapl:1:0
>>
>> Only one sysfs entry per-event per-package is created after this
>> change.
>>
>> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD
>> 0x80000026 leaf")
>> Reported-by: Michael Larabel <michael@michaellarabel.com>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> 
> For the future Intel multi-die system that I know, it still has
> package-scope RAPL, but this is done with TPMI RAPL interface.
> 
> The TPMI RAPL driver invokes these APIs with "id == pkg_id" and
> "id_is_cpu == false", so no need to make rapl_pmu_is_pkg_scope()
> returns true for those Intel systems.

This seems like an important point, would you be okay with it, if I include
this info in the commit log in v2 along with you rb tag?

Thanks for the review.

Regards,
Dhananjay

> 
> The patch LGTM.
> 
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> 
> thanks,
> rui
>> ---
>>  drivers/powercap/intel_rapl_common.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/powercap/intel_rapl_common.c
>> b/drivers/powercap/intel_rapl_common.c
>> index 3cffa6c79538..2f24ca764408 100644
>> --- a/drivers/powercap/intel_rapl_common.c
>> +++ b/drivers/powercap/intel_rapl_common.c
>> @@ -2128,6 +2128,18 @@ void rapl_remove_package(struct rapl_package
>> *rp)
>>  }
>>  EXPORT_SYMBOL_GPL(rapl_remove_package);
>>  
>> +/*
>> + * Intel systems that enumerate DIE domain have RAPL domains
>> implemented
>> + * per-die, however, the same is not true for AMD and Hygon
>> processors
>> + * where RAPL domains for PKG energy are in-fact per-PKG. Since
>> + * logical_die_id is same as logical_package_id in absence of DIE
>> + * enumeration, use topology_logical_die_id() on Intel systems and
>> + * topology_logical_package_id() on AMD and Hygon systems.
>> + */
>> +#define rapl_pmu_is_pkg_scope()                                \
>> +       (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||  \
>> +        boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +
>>  /* caller to ensure CPU hotplug lock is held */
>>  struct rapl_package *rapl_find_package_domain_cpuslocked(int id,
>> struct rapl_if_priv *priv,
>>                                                          bool
>> id_is_cpu)
>> @@ -2136,7 +2148,8 @@ struct rapl_package
>> *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
>>         int uid;
>>  
>>         if (id_is_cpu)
>> -               uid = topology_logical_die_id(id);
>> +               uid = rapl_pmu_is_pkg_scope() ?
>> +                     topology_physical_package_id(id) :
>> topology_logical_die_id(id);
>>         else
>>                 uid = id;
>>  
>> @@ -2168,9 +2181,10 @@ struct rapl_package
>> *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
>>                 return ERR_PTR(-ENOMEM);
>>  
>>         if (id_is_cpu) {
>> -               rp->id = topology_logical_die_id(id);
>> +               rp->id = rapl_pmu_is_pkg_scope() ?
>> +                        topology_physical_package_id(id) :
>> topology_logical_die_id(id);
>>                 rp->lead_cpu = id;
>> -               if (topology_max_dies_per_package() > 1)
>> +               if (!rapl_pmu_is_pkg_scope() &&
>> topology_max_dies_per_package() > 1)
>>                         snprintf(rp->name,
>> PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
>>                                  topology_physical_package_id(id),
>> topology_die_id(id));
>>                 else
> 

