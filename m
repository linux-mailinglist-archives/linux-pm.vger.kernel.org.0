Return-Path: <linux-pm+bounces-11202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239693387B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52381C21724
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62F1D52D;
	Wed, 17 Jul 2024 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4hJFxm/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564617C66;
	Wed, 17 Jul 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203506; cv=fail; b=gxo8IEaXZx8nm8pcnV4fbuHKozTap5dwRHnVEFB2Q6v0UzaMT0yionTHp3M1dNxZcIlqKgRmL0XcybNbkyWL+bEIwyacdEti1X+NQ/yCCfO8NkRlAg7M5wHZ13cU+YUsGTXaCJb6MYFbuFqZh47b6vtPcPyHgMjbDxxqOwxjNN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203506; c=relaxed/simple;
	bh=yBrWo47VJMm79837PqBjtRDYGKVykoMy8b0J7xuk8j8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZ1Pn5PteotTO2kNfrQ6y5zwHwr3E7XuBCgKO2CP7W0em1tfjrdjg0tFfzkplULAf4II2r2GVyG+JrMC6oN4c6yVVo1LXlQH7NFyJ+SZesaV0wtHOuMmSM+vglmOqH8zqmTKY2HOLJTy7qaEhhDSSrc5yzlma8J0dYWe4FinDrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4hJFxm/J; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbVjBaWKjTC0zONriK3Lxuk4xOAxHNv/6sKjtX5CCMF+01LmxQs8y8JYMLbNOMBZ0/rs3grRMOMrl/t4wD+IocNRGlOZdv39m0hVpMxfZF+aPmrqSwXdp8ldDJZlsO7BN5a8NRvdO0slJYoqsPJXiqYA1YhsISuab3kA+kTDfc6Bp6MapilOh55d1zFfUpVhHGdEBx4dAAj3vf3XpiKpiGNqNqXOLRqJigw/NggsEvYhOQp2D+KpSGoMQQ8ucAvsss+1uSZZwyRQGVJ6/PtDz+sC0T75K1dzDmOMEK78wqbSrjQWTZSVN1PesYqITz4hJteriLBE9jmyqgV8tEO3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mspd0TjXu+S+26t1jNF4A4eREzY2N8gQmo8kUoAfc8g=;
 b=d/BLfAbsztPWOmQ8lKJ4iO949rlGispTDk/lzQ0wxSUjkOVN7VDL31cQYTIvmsuMwlpekOgWAXOL1yZ4LvyvHIf5UhPskgcbE+6/CcZtoXRbIdDqb3e+ggtoPHTUtOSa0E4qJknpFIDeAy2k7O4HzfvMqpNQdhW9rk6DexECR1UJxNvFJx39h1G4Wulv+Dn93xa1TLF+aYeF6BJC7+gx7xhJ2rh40T10ITc282V0Ge/0V995Ov++yS9lKlAYQy4NDl5zFmxJ5DC7qz4lBR3R5kVFX3mNAw9naz4pm8gn45xZj9pOVIX/vVg47JHl4DnRJlSfsHI1UrIQE5NT+IUgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mspd0TjXu+S+26t1jNF4A4eREzY2N8gQmo8kUoAfc8g=;
 b=4hJFxm/JQPA0YHSyWfNmseuxHVPHeOFRHOgDdf7IOyGZQU4H6as5MeLAQDJNM93Ti/ch0NGhoAH4RLQ5Fgt4W0bNtbMl6q0rMIqd+4FPXTjw0I08jiz1xJ5W2JKG5wQf9132cPI3ujLEDJeXqcUkVrMYAhhQqhhSCeZZyBqGDSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 08:05:00 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%5]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 08:05:00 +0000
Message-ID: <a1603596-aa36-4bb9-8c66-295b1872a2fe@amd.com>
Date: Wed, 17 Jul 2024 13:34:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Add per-core RAPL energy counter support for AMD
 CPUs
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
 gustavoars@kernel.org, rui.zhang@intel.com, oleksandr@natalenko.name,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com,
 sandipan.das@amd.com, linux-pm@vger.kernel.org
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
 <CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com>
 <05e96873-12a9-4b1f-b1b3-1db7647211ce@amd.com>
 <CAP-5=fVXi3Pdtjaw++oRkYgubh-MDkRYf=2k7dNqE8s+jyQ+Ew@mail.gmail.com>
 <2e7064c2-c769-41bb-a536-c6e75e8e5800@amd.com>
 <CAP-5=fXBYVH=qBJPm1d0-QEp8+HP3WtTLuukfF0g-2WU3gTofQ@mail.gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CAP-5=fXBYVH=qBJPm1d0-QEp8+HP3WtTLuukfF0g-2WU3gTofQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a35e06d-32a6-473d-c957-08dca63727fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXVWR2VYVDlLaHByVzlqd3R2L3hLUHV3eFF0cWhkMjhUdXM5OUVTZ3J3dkV4?=
 =?utf-8?B?L09Nd2wxNDUwd29xYlJqRmwrR3RKYitkMkhTSTk2amJGdUNwRzZPMHplMjE4?=
 =?utf-8?B?QlFyR3RSVDQwb0IycnhHb1VxZURFbUJ3UzNIbTZFWjg3Zno3b1NsR2RuQXRM?=
 =?utf-8?B?azlneXh2N2E5WUlSVlNoU0dsWEVXek9rUk4wWDhTN3VSdUtCUU1Va3lDcXVt?=
 =?utf-8?B?ZXVXaGhLU2M4aDF6WG4rTVpJN2o1ZUlUK1JzckFXMmNKM2hwcE9WbEkrOG40?=
 =?utf-8?B?eHZjaGo2K0VBc3RZT2VxZjVCWThTcmUwQUsvOGdaOXpzcC8vYlA5ZXQrNWt1?=
 =?utf-8?B?dkxmSHlMNFFkTjd2RURmZ0tMU1AyYklTd2RuZlJRZE9jMHh1RjEyU2YrWXk4?=
 =?utf-8?B?ditTYTJ0UFl4Zm5iN1g0MjlEd2dLa01UUzhMSzE2L0NIbm5KbTdVeUNkNlBq?=
 =?utf-8?B?Y3FramF1c2g5cE1ZU1Q4dFI0VWgrREtrdnRKdFJwdHF4ZldwTVN5NVEwV1VG?=
 =?utf-8?B?NVUwdGZjQ3krWmt4M1VPSHBweHdnaXkxeGdjaFVMc3plRk9tUkZEOWxiS3Ex?=
 =?utf-8?B?RStsQ2wvNVI4S0hSQ24yak9saWU4K3c4VXFSREtSeXNQanpiTHVhOUJBSkxG?=
 =?utf-8?B?cnBNNGhmQlR1dlZCUzhBcUNwOXV1K1FaR1hURWlleUs0YXRVZnNZVHV4cytF?=
 =?utf-8?B?di9jZ1ZMMExmUURLZktocVh2MndiekNLdFl5czlqL2RqK0VHTWR0aHJ0Y2FT?=
 =?utf-8?B?VlZRbTVKMUxvQzJxSUM4dmdnZEZqaFVRNmRxUFRNTEdydUlyNnFCdEQ0bk9H?=
 =?utf-8?B?L3FXbDFlTm9PWVJlbTlRUFZ2SUV6Q1lSUzA2SGVMMHBHazFsMDI0TmJmbDJF?=
 =?utf-8?B?NXRKK1JlbmZuLzdsUEd1VmJ3dnNUaXRmVmdMLzRMTy9GcmFWTGxBVFhzRXgy?=
 =?utf-8?B?TCtSTEFXcTgydjJidjBreGFVODY1R2JMWVB1MUdjQU9nQVlQZ29CUHRsTnBM?=
 =?utf-8?B?Q3lNV1lHSTB6SEx1ZzNYVjR1WE5vQ0VRVVlwOFo0SklONEVRYXlKZTRJM0lX?=
 =?utf-8?B?MkhZZlNMYlpZNkZtOG5pSFRoeTNxNHc5UE5wQkR2QWl3WXgvbitBelVOQlhP?=
 =?utf-8?B?ME0yV3FPS3BpKzVITnZKS1VhcTNVWkRMZ2hzcnNKU0J5RUVuMktmNzFMM3ZJ?=
 =?utf-8?B?djY2bU80SW9haFZUYzhjVW9FejdKOCtmTGxIdzZmY2pOdTlYRzdVSzJoMTJM?=
 =?utf-8?B?emU1YWlRbS9SbXgwWVZZOTBpUnhaMnA2TXNBSEI5WkFqZEpVSXljSCtKMndV?=
 =?utf-8?B?Q2NFVnNyRkx2ZEJEUnZCQ282ZFJiYjl2RnNCdVdsT1lIYllqZldpZGZaZkVw?=
 =?utf-8?B?OXhNNENyM2NuSFRVYmdrd05PSkMxWkUvWWszRlg0RktqMG5salV2MkpIRWtq?=
 =?utf-8?B?Um1FSWpMbmYzNUt6QWp2eXY4dWs5UzJhbFpVWFJsbUU5OU1DcGNIUVhPVjNL?=
 =?utf-8?B?VjRXV0JWSk1aSWlyZVRBL1ZDK3FYQTVzVlNtRXZyQXFXaGNmMWR4YWhsUkJM?=
 =?utf-8?B?Mm15amtXSGl5alpTOWV2aHZIU3RISDlCekdZdXhXK2xGWXhZVE5SKy9UUnAy?=
 =?utf-8?B?YWlxU3YvTm5jcFBKT3BqTWozY1kySmZFOStSRHR0WFNWTFNqdEI0ZEhTdFhZ?=
 =?utf-8?B?dDdCUGw5V3gyckRKdU8vUzRGUDhBdCs1eEVPU2pYamZSVHNkZmRTbDMrU2F1?=
 =?utf-8?Q?0xDcmPBuFAiVd7W7BQ6xGLA1ebaSU3fXZH4JB7l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFF6dU5PdTJuOE8wZEpNd0IwOS82S0NpRjM2RzJSYVRFYXBnbk1nYnpDV0U5?=
 =?utf-8?B?RlJqcEVLRVBFZ1drUXFRblIxOXREbmxTTVhBeThsbDdLbjJXemFWUlFuR1NC?=
 =?utf-8?B?dWVUQmlaR2ZLdjJ3UGYxRWFzSjQyKzRGQU1odTArVEhLOWNPSTRsQkxPUEQ5?=
 =?utf-8?B?OFZTZi9Fcm9Ob1Q5cFNvRTJMb3F5QVFXWFZoREV1ZHNZcmtUc1FNcjcwREE1?=
 =?utf-8?B?QkdvN3FpemtUcVcxNTh1Q04vZTRqRkFkT1VZTmZITDlOMlNFdi9VbHlTSzJK?=
 =?utf-8?B?UHZWK2ZWaDJ0dnh2a0RnNWs0d3hvRDI1TVBCdkEvYmlVcVR2R2VFQWE2V0sx?=
 =?utf-8?B?R3krRXpSeFpYbXlySTU2T3VjeE5JMXdyU3F1RURqbDFCV2JHb3lxc2FhS0Y4?=
 =?utf-8?B?bTFDSlV3UlpTVkZHNFV3UmhpMzJncGRZSWJ2NWwydXJJSnNJOTdCLzVhbmwr?=
 =?utf-8?B?SjhZUEdyclo3dlRCRDNwMDlma0NSQy8rbC9TUzQrWTNEY1B4SzYrNzV0dG9U?=
 =?utf-8?B?Zmp1U1o0NDdnNDc5SER2UE5EdHJrWTBIL3oyVERqek1OYkxZWHBDZGs0OHYy?=
 =?utf-8?B?a09yU0MrdzgwNnFuTHh5d2xlMHBMOUo3Z1JVWUE3dmo1QkxBd1RVcnJ5TmV4?=
 =?utf-8?B?Z3p0WDRaUlIxQ2FPdEVUcnZ4Mmg5ZitlRmVkdnFiRG1qeGdZWUdHRlUwN3A3?=
 =?utf-8?B?cWtuMWt3ZXZoeFp3UU53eTkzZ2tHM0N0YXE2cUVyMzhaaGRDZWIvTUVuOUty?=
 =?utf-8?B?anh5c3lYbmhOU3V1VVhsRm44S0tkWWROeTRmMjVSdVVkN2lQN0o0dTN3ejh4?=
 =?utf-8?B?MXpYdkIzKzlFTnIyOWdTTmxuN2RFU1E3VlN5YmZHd0xPUm5nd29US0YrUnJ3?=
 =?utf-8?B?alRYazA3cHZWMEdTdVNIbTRqdHpRYkVQa2drbEtYYkd6Y1VwVFpiZVlYUUth?=
 =?utf-8?B?Vm51WEcxNXVHWjRoemFPVGVXclhhNzFYVG5WTklERFBaZXRTZSt6YVl2OU9Y?=
 =?utf-8?B?dng2NncybUR3YUg2L245NnVUdFJ3RUNsZXkvNWJjQ3ZiVFhZNVgvSnJxalVN?=
 =?utf-8?B?cnBIaTJBaXZXdGVYZm5XNExOZ0V3QlhrSVlBeEYxbUg5UEtaZWxSSkowT3Zw?=
 =?utf-8?B?eFNkSDRRZmVXS2V0VUQrdjRVd2duMndSM0RyaVNMK0tuTDVtOE1jRnRmOVc3?=
 =?utf-8?B?b3BrM1hFWmhzRldWNm1td2pSeTRzbDc4L0VTOGJmM3lNSkFrTHR5eDhLTk5u?=
 =?utf-8?B?MVNheHZhRWRCZnJPdWkyanV0RnlxYktUaTZsdmp2eTVkQnNXdHQwcFNIR3Zn?=
 =?utf-8?B?TUVNdElod3dsbDlYT044cUltNjRuakw3bUpjN2tqSWdJdjgzeVU3WDc5aXhW?=
 =?utf-8?B?RmRJQzEyR3BIZjF0clVQMFpMQzRsdWRJS1U0VTdWRHVFMTM1SDF2cDF5eEtG?=
 =?utf-8?B?N3A5QVZJeGY0dmN4SE93bE5IRFhOSXdKSEsyYldYK0EzK0UwbFBOSTNNS0RU?=
 =?utf-8?B?YzFqaWc0Nm5nSS9kWnFCNXNJcjRVbTlVa2VtWm1lcWJUbFJGaFhYZDN5TkFz?=
 =?utf-8?B?VHdpWHBZSzlVL1k2NUhDd0NXdU45WFNzWk5sRlA2enBlZ25VcktGQmFleVA3?=
 =?utf-8?B?NStZSFJ0QmRPTVJKRXRjb2x3b3M2VTRPbFVLajRqZno5dGh1NmpSMVFHQ2s0?=
 =?utf-8?B?OTVOS25seHJybFV6OFNOK2pvckMvOE92Y2Z3TGhORmdHc1VTWWJtK1lJQ2tY?=
 =?utf-8?B?TU5waG5wSWNDQ3NpRStCV2MxVFgzbEpsaktrd0dPTWh2YTN6ZU9VUWNjMURW?=
 =?utf-8?B?cmpIZENSNWg0ekNRRVhLL0F1K1ZoTXhMVjkyTzZtK01YYnl1YWNQem9uemdW?=
 =?utf-8?B?MlNDTi80eGFQWWZsMWlKUlFmSmorQmdTajVRbCtxalMyYUU4TDBycnJmK1hh?=
 =?utf-8?B?S3p2Z3lmK1BXZnIzS2djS21rcVJnSVRJcHZsaTRMMlJwMjlaWitLQWc4L25S?=
 =?utf-8?B?alNJNmdoL3JhR0d0WFU3TGw5SFBXSklnOGE2amZ6TStncEpHd0JjTmNsWGEw?=
 =?utf-8?B?SVoyRGdTRlAxeXdqWndFZ3ZtdmNLL1kweEZNY3FVblJCaFBJMHh1QWRqM3A5?=
 =?utf-8?Q?eT/NHbsvcY7fbomFDZabt5CK1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a35e06d-32a6-473d-c957-08dca63727fb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:05:00.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzOVSbTth0wodw6H73EbOm6KC/gdtNTn6m87m6UEBqm4IPaN6wvYAhoqGZKO21UtavD2IET9Y/B/2emug5vW0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747

On 7/17/2024 4:17 AM, Ian Rogers wrote:
> On Tue, Jul 16, 2024 at 1:42 AM Dhananjay Ugwekar
> <Dhananjay.Ugwekar@amd.com> wrote:
>>
>> Hello Ian,
>>
>> On 7/15/2024 8:52 PM, Ian Rogers wrote:
>>> On Mon, Jul 15, 2024 at 2:36 AM Dhananjay Ugwekar
>>> <Dhananjay.Ugwekar@amd.com> wrote:
>>>>
>>>> Hello Ian,
>>>>
>>>> On 7/12/2024 3:53 AM, Ian Rogers wrote:
>>>>> On Thu, Jul 11, 2024 at 3:25 AM Dhananjay Ugwekar
>>>>> <Dhananjay.Ugwekar@amd.com> wrote:
>>>>>>
>>>>>> Currently the energy-cores event in the power PMU aggregates energy
>>>>>> consumption data at a package level. On the other hand the core energy
>>>>>> RAPL counter in AMD CPUs has a core scope (which means the energy
>>>>>> consumption is recorded separately for each core). Earlier efforts to add
>>>>>> the core event in the power PMU had failed [1], due to the difference in
>>>>>> the scope of these two events. Hence, there is a need for a new core scope
>>>>>> PMU.
>>>>>>
>>>>>> This patchset adds a new "power_per_core" PMU alongside the existing
>>>>>> "power" PMU, which will be responsible for collecting the new
>>>>>> "energy-per-core" event.
>>>>>
>>>>> Sorry for being naive, is the only reason for adding the new PMU for
>>>>> the sake of the cpumask? Perhaps we can add per event cpumasks like
>>>>> say `/sys/devices/power/events/energy-per-core.cpumask` which contains
>>>>> the CPUs of the different cores in this case. There's supporting
>>>>> hotplugging CPUs as an issue. Adding the tool support for this
>>>>> wouldn't be hard and it may be less messy (although old perf tools on
>>>>> new kernels wouldn't know about these files).
>>>>
>>>> I went over the two approaches and below are my thoughts,
>>>>
>>>> New PMU approach:
>>>> Pros
>>>> * It will work with older perf tools, hence these patches can be backported to an older kernel and the new per-core event will work there as well.
>>>> Cons
>>>> * More code changes in rapl.c
>>>>
>>>> Event specific cpumask approach:
>>>> Pros
>>>> * It might be easier to add diff scope events within the same PMU in future(although currently I'm not able to find such a usecase, apart from the RAPL pkg and core energy counters)
>>>> Cons
>>>> * Both new kernel and perf tool will be required to use the new per-core event.
>>>>
>>>> I feel that while the event-specific cpumask is a viable alternative to the new PMU addition approach, I dont see any clear pros to select that over the current approach. Please let me know if you have any design related concerns to the addition of new PMU or your concern is mostly about the amount of code changes in this approach.
>>>
>>> Thanks Dhananjay, and thanks for taking the time for an objective
>>> discussion on the mailing list. I'm very supportive of seeing the work
>>> you are enabling land.
>>>
>>> My concern comes from the tool side. If every PMU starts to have
>>> variants for the sake of the cpumask what does this mean for
>>> aggregation in the perf tool? There is another issue around event
>>> grouping, you can't group events across PMUs, but my feeling is that
>>> event grouping needs to be rethought. By default the power_per_core
>>> events are going to be aggregated together by the perf tool, which
>>> then loses their per_core-ness.
>>
>> Yea right, maybe we need to fix this behavior.
>>
>>>
>>> I was trying to think of the same problem but in other PMUs. One
>>> thought I had was the difference between hyperthread and core events.
>>> At least on Intel, some events can only count for the whole core not
>>> per hyperthread. The events don't have a cpu_per_core PMU, they just
>>> use the regular cpu one, and so the cpumask is set to all online
>>> hyperthreads. When a per-core event is programmed it will get
>>> programmed on every hyperthread and so counted twice for the core.
>>> This at the least wastes a counter, but it probably also yields twice
>>> the expected count as every event is counted twice then aggregated. So
>>> this is just wrong and the user is expected to be smart and fix it
>>> (checking the x86 events there is a convention to use a ".ALL" or
>>> ".ANY" suffix for core wide events iirc). If we had a cpumask for
>>> these events then we could avoid the double setting, free up a counter
>>> and avoid double counting. Were we to fix things the way it is done in
>>> this patch series we'd add another PMU.
>>
>> Yes, this seems like a valid usecase for event-specific cpumasks.
>>
>>>
>>> My feeling is that in the longer term a per event cpumask looks
>>> cleaner. I think either way you need a new kernel for the new RAPL
>>> events. The problem with an old perf tool and a new kernel, this
>>> doesn't normally happen with distributions as they match the perf tool
>>> to the kernel version needlessly losing features and fixes along the
>>> way. If the new PMU is going to get backported through fixes.. then we
>>> can do similar for reading the per event cpumask. I'd be tempted not
>>> to do this and focus on the next LTS kernel, getting the kernel and
>>> tool fixes in as necessary.
>>
>> Makes sense, even though this approach will require more effort but it seems
>> to be worthwhile as it would help things down the line (make it easier to have
>> heterogenous-scope events within a PMU). I'll need to go through the perf tool
>> to see how we can design this. I'll get back with an RFC series probably once
>> I have an initial design in mind.
> 
> Hi Dhananjay,
> 
> I can have a go at the perf tool side of this - I probably know the
> way around the code best. Basically we need to do something similar to
> how other "<event>.<setting>" values are parsed:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n335
Yea, right.

> The cpumask handling in the perf tool is a little weird as there is a
> summary value in the evlist. Anyway, I can do that if you want to spin
> the RAPL/power PMU side of things.

Sounds great!, I'll be happy to refactor the RAPL code to use the event.cpumask 
feature to add the per-core energy counter. Also, please let me know if you need 
any help from me on the perf tool side as well.

Regards,
Dhananjay

> 
> Thanks,
> Ian
> 
>> Thanks,
>> Dhananjay
>>
>>>
>>> Thanks,
>>> Ian
>>>
>>>
>>>> Thanks,
>>>> Dhananjay
>>>>
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>
>>>>>> Tested the package level and core level PMU counters with workloads
>>>>>> pinned to different CPUs.
>>>>>>
>>>>>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa
>>>>>> machine:
>>>>>>
>>>>>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
>>>>>>
>>>>>>  Performance counter stats for 'system wide':
>>>>>>
>>>>>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
>>>>>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>>>>>>
>>>>>> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
>>>>>>
>>>>>> This patchset applies cleanly on top of v6.10-rc7 as well as latest
>>>>>> tip/master.
>>>>>>
>>>>>> v4 changes:
>>>>>> * Add patch 11 which removes the unused function cpu_to_rapl_pmu()
>>>>>> * Add Rui's rb tag for patch 1
>>>>>> * Invert the pmu scope check logic in patch 2 (Peter)
>>>>>> * Add comments explaining the scope check in patch 2 (Peter)
>>>>>> * Use cpumask_var_t instead of cpumask_t in patch 5 (Peter)
>>>>>> * Move renaming code to patch 8 (Rui)
>>>>>> * Reorder the cleanup order of per-core and per-pkg PMU in patch 10 (Rui)
>>>>>> * Add rapl_core_hw_unit variable to store the per-core PMU unit in patch
>>>>>>   10 (Rui)
>>>>>>
>>>>>> PS: Scope check logic is still kept the same (i.e., all Intel systems being
>>>>>> considered as die scope), Rui will be modifying it to limit the die-scope
>>>>>> only to Cascadelake-AP in a future patch on top of this patchset.
>>>>>>
>>>>>> v3 changes:
>>>>>> * Patch 1 added to introduce the logical_core_id which is unique across
>>>>>>   the system (Prateek)
>>>>>> * Use the unique topology_logical_core_id() instead of
>>>>>>   topology_core_id() (which is only unique within a package on tested
>>>>>>   AMD and Intel systems) in Patch 10
>>>>>>
>>>>>> v2 changes:
>>>>>> * Patches 6,7,8 added to split some changes out of the last patch
>>>>>> * Use container_of to get the rapl_pmus from event variable (Rui)
>>>>>> * Set PERF_EV_CAP_READ_ACTIVE_PKG flag only for pkg scope PMU (Rui)
>>>>>> * Use event id 0x1 for energy-per-core event (Rui)
>>>>>> * Use PERF_RAPL_PER_CORE bit instead of adding a new flag to check for
>>>>>>   per-core counter hw support (Rui)
>>>>>>
>>>>>> Dhananjay Ugwekar (10):
>>>>>>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
>>>>>>   perf/x86/rapl: Rename rapl_pmu variables
>>>>>>   perf/x86/rapl: Make rapl_model struct global
>>>>>>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
>>>>>>   perf/x86/rapl: Add wrapper for online/offline functions
>>>>>>   perf/x86/rapl: Add an argument to the cleanup and init functions
>>>>>>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>>>>>>   perf/x86/rapl: Remove the global variable rapl_msrs
>>>>>>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>>>>>>   perf/x86/rapl: Remove the unused function cpu_to_rapl_pmu
>>>>>>
>>>>>> K Prateek Nayak (1):
>>>>>>   x86/topology: Introduce topology_logical_core_id()
>>>>>>
>>>>>>  Documentation/arch/x86/topology.rst   |   4 +
>>>>>>  arch/x86/events/rapl.c                | 454 ++++++++++++++++++--------
>>>>>>  arch/x86/include/asm/processor.h      |   1 +
>>>>>>  arch/x86/include/asm/topology.h       |   1 +
>>>>>>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>>>>>>  arch/x86/kernel/cpu/topology_common.c |   1 +
>>>>>>  6 files changed, 328 insertions(+), 134 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>

