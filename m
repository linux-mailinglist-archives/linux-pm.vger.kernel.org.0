Return-Path: <linux-pm+bounces-35474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B4BA46CC
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 17:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3AF7B34E0
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D47215F7D;
	Fri, 26 Sep 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gLwo+Xj3"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CF205AA1;
	Fri, 26 Sep 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900779; cv=fail; b=ODJB0EGzIlHhgHRfj4MKdv5+fWTVjBQxyI0V2u20J0wQkIch3F/Oo5tBJrsmIvdD/7y86MDP7qsRnmi+kO/tTDKUDbGmQ2DGLGoEiRkSJl6BjAZEgXXb08P1psKUZPcCoP33VAIKVyGPZWBCb6FI9epmZ7CZ+zyVIjofPD8kgEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900779; c=relaxed/simple;
	bh=mF5EyYGMbanII9D7X6j9rGwSrSmb8I4padvUAnmp6CY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YIj0m0hPj74h21G1ZilN2KG06xbN8MZdDkPUKHaCWc6HaepV3IhkK2cVCG9Dz5ngMhpdVVGC/OwVd8e+v8Hqj5XxlHCx26i0oLTSwy7HfqB8poH1mkX4EDYZcR188sAJZDyGMatxBZF6oI7qpRKr2sKdkmoIMvmudSmGAz9oorY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gLwo+Xj3; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+AAnecGlxzxFlIkr+rDYRafazfkSC0lSwZUMFqp0sE64SeljwBPqr91Hlsjmz6hxrm35INX94EjN0p1NECVfR5ci/9YozIUHFqu2aBpilABiFdkrPar9VBW79IFnd4H1X0dpoDW1iSr+xxwmu53+Pd1zVdUdk6HE9gxlG+mx/ScftCx1CnqIty3ucC4O9oKb3/DEXiJhrXo9wnn7GAPxxT4/u5b8PdDDGgmTGftLCD1Kmr/7vwqD4n8Cs9NLrevpCFw+YqmCd7xYv6vvDk8i8Yfln980MG1iy6xfgan+avIK08D6fHSfkY5Q5wqtPj1oRoyNpIKG4giA8w4SRSKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDDYvSAoXno8bQTKbhaGa+gQ/TilHJ4eLnN19KQQMJg=;
 b=hn2wp2gJn8ACjYsYvQXjI6PRumpvUJGdTezr0AKpzVVYed/Pi9fSp89239fqrHWYyvxn9wDqQ0Obv3IY2XdOQa83A6LUiEro7JanV8kF65PR76pjOEAghAs4c+/9dMQsYkv4tVbhdjswDLTqzf/wgMd1EAQ4Av+IF6QJZNI5D2CMIcucw/U3Pw4BGOTSmcL7EOBOkXAur0hnslliXWE/o6wZIsUwEq3L2cOya/gifG9LKVnSwMFVj4WwUpcJALV9D3tkLwq1cXThXOgjWo9ARiYPtA4vgCAPy8exgfheSL0xYzLUI1tk4Ve/7mHNDn5bPw5a1xQ1MTFei3nvQh3gIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDDYvSAoXno8bQTKbhaGa+gQ/TilHJ4eLnN19KQQMJg=;
 b=gLwo+Xj3seYaGzn0VhRBQfa5Gac9NWtuKlg2K7vD8VEN96JYgHYsdBMDQ3OGwhRMlXy5dMTT0OCFHb6Tmcjr07BPXx653X6HgrPx6NsXHVH7WiOnUpTTRLKNeHWxddmI/qGznLS6b+V/6i6db8V9WmN7EEiaouS3dGEune8osDBSm8YDZKv0IzPUxP1Xp0qAJZOMn4zgZoIMnux7xjtO/W12xkku7k2N+g+n4BK4TnigkriskXqRI/EauSMj4YRDNbalumhlVKt/ZpTk63jcr3uCiW068mtvpWxRjY0z5EttX7zHEYL4nXng/zVzza/9RpzvKVum5x9VD/z+Jn+AbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 15:32:55 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%4]) with mapi id 15.20.9160.013; Fri, 26 Sep 2025
 15:32:55 +0000
Message-ID: <be41e552-e626-4923-a9e7-15acbafc19e3@nvidia.com>
Date: Fri, 26 Sep 2025 16:32:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
To: Saravana Kannan <saravanak@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-21-ulf.hansson@linaro.org>
 <4478f28b-47f8-4049-bf17-b7fc95cfac65@nvidia.com>
 <CAPDyKFqSyP3e=JRFYEuFefWVN5SYJWULU8SKzXmrThvyiVGXgg@mail.gmail.com>
 <a904d953-acb2-44f6-81bd-118f7abd22da@nvidia.com>
 <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
 <CAGETcx9CpOgtPSDK_qPRQ_u58w3fedSFAfFzugXW4eYq2TLECw@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAGETcx9CpOgtPSDK_qPRQ_u58w3fedSFAfFzugXW4eYq2TLECw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To PH0PR12MB8773.namprd12.prod.outlook.com
 (2603:10b6:510:28d::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8773:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acdd092-b704-4fcf-905b-08ddfd11f61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGRoSVdGYis4TGhvbHpUUDlHQWxlQklRR2d6ZU9lYyt5UDNjTkFza0lKU0J1?=
 =?utf-8?B?MEk5WjFRcmphMWZ1TUdYSGpqNXl0UXcveU1EVnRJN3RUNXQwOVpWeFJodG1s?=
 =?utf-8?B?R1FhYU9lQnhTM2cyYmNJSjRNQzdiSm1tbFhjMjZFdzFnZmZXUkFqQk9HcWlG?=
 =?utf-8?B?RmJ3eVJac1gxaWVTKzB5ZFJtWUs5T0tCN3ZRUzhiWHMwMWR1ZWR6QmUrdUIw?=
 =?utf-8?B?SUxHSFNJN25CMy9QRXhpa0dQZEo0TitmU3Z5dlRRMzhRSnl4b1JuUHFNQzYz?=
 =?utf-8?B?eFFycG91NkZPcmtaS3l3K1ZOdWJPWHhXczNkdlhaNkJqblBkU2dDNjNITGpj?=
 =?utf-8?B?Q0NSRzI4QkJtQmFMN1Ywenkwc3d2Q1daMlEyNFdCc09ESEZzeW50MC9NNjgr?=
 =?utf-8?B?V2lBK3YxNU9DbStsMzRjb3BHQVR3M1pRNk5NRzdWbnVKeEpueU9kRTRSejBz?=
 =?utf-8?B?ZGxNSmtlQzJHU2tmSUJiT3pHU1NTUlFPZHA5Y3BySVl1VThUT1NFSGs4bUFt?=
 =?utf-8?B?bEc2cGd2c2cxMGlnb0ZNVThhMG1XQ1hwdW53TkM2SlhNMkpwRTBzVzJkckkr?=
 =?utf-8?B?UnIvZHBWMGFQTWxUb3hKNjdWbXkxRHoxa1V5V01iZ1BRUm5WMkZBNHFJQWdV?=
 =?utf-8?B?L1dUMEhHTlJKR29EdWlYUUlaYkx2VWFvOVowUlB3ZWxkZnZBRkNmcWdLQkpS?=
 =?utf-8?B?MGF3NDIwZlplbmlPWjY3OUpUY0NsRnZNMzByZ29NaVlPOXBHV0FLdWp1L3Ja?=
 =?utf-8?B?RTBVUU82UlJ6WWJwWnY0aTk1MzFib3NxWlZrNDNyNXdwalRYZ0pIOXI0U2Yy?=
 =?utf-8?B?R3c2SERjbjZ4aHh1elgweDF6bjFMS0NLeC9uSlZYMEZTbXd0RzdrNG9FcE9w?=
 =?utf-8?B?b29waUZtRXFZcERsNFpmR0psV1BWY0dObDFjK0I0WTdzRGpYYXVKaHRTNTlG?=
 =?utf-8?B?RWRlajR5RFFPWmUzTjZtYm1ISUR1dkFKZ2RDeTRyaUQyWFEyV21wbWsyZm9y?=
 =?utf-8?B?SlFHelFuZjVCclhKVTZ5bXpGVG9CYUQ3ZnZML3RBb2E5cGNuVmh5UE05OXc1?=
 =?utf-8?B?QkJFZXFKYXkzUjhaUWpXRG96aVFzUjZKcVdFYkx4NVZyZGQvWjc4L2xRblVr?=
 =?utf-8?B?T1ppcEgwUHdRTTV6Qnl5U2dnRDhCbzF3cHhiaUR5TnRoTVpibTQrSGZKUXZU?=
 =?utf-8?B?WkNVRmRtUjV2KzFtNU9tU0RDdkFhV1ZtR28yKytuZTRvWVVBc3E4cnFFY0h4?=
 =?utf-8?B?dFB2YnlnMSttV21VTjVqRUN0bnR6MVFCOW1PdmtNckFTRVQ1eDNlbzJwTVNW?=
 =?utf-8?B?b2dKcWUrcHdORkErVFl3Q3RRMGh2WC80UExyVEEzQWdqeldWS1RUQjZFS1ZV?=
 =?utf-8?B?eHg5R1dadUlMM0FwRzdIY2N0TDlqTkUrUzFXQk9RQWlFWG5UTEJWQjc0RGZV?=
 =?utf-8?B?UjNJY3BlTVhwMjVFdk9TT0lHUXpHOVZnczQzQmFVbXEzNXRFbks3bG41WGV0?=
 =?utf-8?B?d1VIK0dET2JTL0hHU0NWc1libk51c0FZMk9mNVdwWWRFSnlhWGdPM041V2pi?=
 =?utf-8?B?UDQ3MmtHMS9xU0lYMk1ENEFtNXJraVNVd040bGFoazd2dGRMcG11VHJ6WGZQ?=
 =?utf-8?B?SERmKy81NnplSkdOWndvaHI2clh4dTNDekVKZ2Y0VkU4dGZrdHVKSG9XT28z?=
 =?utf-8?B?bHhJdVdTWFRQbVZ0V1l5N09XeEJFa1J0Ymh3Y1Z2VUZwNTJ6UmhycEtsWm1F?=
 =?utf-8?B?d1NteGxlSjU3REZrNWs2VWRZR1UrZ1h6bVkvZHdMMkJNUmRVejZBWjhEd2RW?=
 =?utf-8?B?bU5iQzY4L3lCM20vcUc4SjBXemo4TzB5NnpkR1FXZ0pJTmRtWGFteUxmSnVD?=
 =?utf-8?B?Sk00ZHBLWnRWVlVSVGxzMjBNb05menE1MUhGb1JhQkdVam03TDk5eGJtTjd4?=
 =?utf-8?Q?5grA4P1dgn8Rm+QJE6Ncw6AXq0tB7T/K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk5zZ1VlZVRuRnJ0WlZHK05EWE4wNzlZeFQrOUFCd1VjellJS3U4emVsdTVk?=
 =?utf-8?B?MTh6UzMxdkRtOVR4VmVDdDdyOVNBZ3lMWS9IK0hKZmtqOUZBZ24rTW5aeDJx?=
 =?utf-8?B?Vm9GR3BTVS9OUHk5QmJFTVFzMkNPZnRneDIyN2diQU13Ymw3TFVEOGtVa3B3?=
 =?utf-8?B?a29ycHlxUCttY3lDRG5ZUU9INzZtYlJTbW10ZURSVldZRGlIQzArazBYekhE?=
 =?utf-8?B?ZDBUYmtqNlhEL0RZcUxyUldZcUhZQTBiZ2xMV1E3ZFh2RzZrWEFlZHpwc1FQ?=
 =?utf-8?B?YWxSdDBRL3JXQWNZY0FOVU9xUWNQM2phTFRwNVRKVGluUWhRQTJuOGRuVWxC?=
 =?utf-8?B?MlMwRE5xRHd4c3VIUU5oWU1wVGRWam0vWVFBaFJ0ZkQwTlNHcTNIcGE4Y2Jy?=
 =?utf-8?B?WTBnMnpMdElFaTBtSWVGMkRHZExXSUlaTXFxS3E0d1U4SjRac0V6aFIyNXJX?=
 =?utf-8?B?YWtjY3ZIdHRDamRtT3dKNmNEOURBRjJTRGNBR1M0ZWlLQUdVWGloS0tzeDhp?=
 =?utf-8?B?L3NPcGRXa1R0U0lOc3FhaENEU1R2SUR5eHNKTlB2b1k5bEFXSmk4Z2k4WjRY?=
 =?utf-8?B?Mm9BRGtQSldvb3c3R0pZdXcySFhyRU5BZmJnN004YmlxTEJ5TVloNlFiZC94?=
 =?utf-8?B?RGpmamtwMTAyYytvWlpYZTd4ZkdkMWd2LzFtQzRtWDFCMlo1UkZwUi84QWNy?=
 =?utf-8?B?cEFKMFgvaXd2YjZBenVsMy8zL2Rwb0NTK2NabmRFbFFPYWtZUGU1KzRtUmIx?=
 =?utf-8?B?d1h1ZkZiajY5aVpTNXNUMzdhdFpjVldSeTRTdXVDQk1DL0R6U0J6SzgrQ3Rr?=
 =?utf-8?B?UlVWUUZySHFYQnZ1dkNORkRKMSs1RlVrSDNTZEllZzBjZ3NRQnQ3U0NEVkt3?=
 =?utf-8?B?K0dhY1RGWGJqcWZCQXdjemVEaDBEOWFrYnNKY0ZoYlNJeXRhalR4RE9FNDFq?=
 =?utf-8?B?YlAxQyt4TmExRDFST1NCZVhtNXZBTlhueTBOazNwWUZjbGxzZjJhNmtyZ1Rk?=
 =?utf-8?B?QWZWQ0hDclVyejNsWU0vNTd2dmpGTGRaSTF1TXFoa0Z3YXBTZ3RMc0FxcmNl?=
 =?utf-8?B?bGx4MFNOZ0o3bytGN05aZnNxRDA1YTUweEVGQVpiRTE4ZlBwMUNRTmZiSURZ?=
 =?utf-8?B?OWJ2WEQxeWZEWnlsU1NjOHREWFBBRW9LMTgwWEdsV2JseDVncURqdGUyTHYv?=
 =?utf-8?B?UzA2RHByQ2dieUd5VmJhUGUwbFpENjdYUlVaZExoU0NWcytOdnJ3VU5tOEVK?=
 =?utf-8?B?THVHRTVnSmpXZkxZbzhJSXJ0b3hUcURFMlNVWWdWZzRpelZ0Q0lxbTFXL24w?=
 =?utf-8?B?RWxKenQwend2MGQ2ODJDcEUrZXlIOTFYUUtWeXdkY09NbHF5K2Nleno2enZw?=
 =?utf-8?B?QzgwVVludkdJTDRZc0NWTUZmSktBRmN4VmZUNDY2b3orSDc2V2tZQUNvV3pj?=
 =?utf-8?B?NkpNU2hUcElEakVDTFlsczdMODJpV3FQMUJKZ1lDb0VrYnNMVHpuTXlPQWNC?=
 =?utf-8?B?YkhJZFdpdEtxRWtvRmpmb2NVN2VMRFV3bGEra0lyL1dhZi9NOGt3R1J5QU90?=
 =?utf-8?B?WlF0Z0FqdGJGTEwydjhFYWNvU0hlQWljanN5UGtFa0pCQmVmTnJIdXd3UFlP?=
 =?utf-8?B?TS8rT0pEYnptYjNrTGtlbXRGN3diTW9RdEdycU41Y3VLTG40ajdBa3lmL3Vy?=
 =?utf-8?B?Q21ReHYzd3ZGMHByUEh5dDV6RTA5bnFsS2o0S0NMQ2ZEN2JXTDg5Y3NOMUcz?=
 =?utf-8?B?SWd6VEJUYmRFUGJCWUt3RHZVQWhLNHZ5ZVoxYWtDQ0dEVnY1UGlnc2VrRHow?=
 =?utf-8?B?LzR4NDEvV2U2OTNvR1NIRHIxTTZvNk1RdzJRQ01RR04yTW9YT0xib0MxWE0y?=
 =?utf-8?B?MEczT2NpSGptSzY2bTlrTXlUdjEvVFIrdUE4cklmQ04vdmhQRkwvS1F4VmpX?=
 =?utf-8?B?S1EyREVpd0dMNmtGWk9MQVZwUWFLNEtwZHJEcXVYN1NQcXk1V3BXMWVlU2Ro?=
 =?utf-8?B?Sm5vL1JJNXdxUmNPYlU0NG9XYjFlMEZZa2lhZ2pncjIrU1RBaGlBc0lYRlRo?=
 =?utf-8?B?YnpNc2VKUXp5M04xQ25jMVFGaU5yZElNczhTL1RjSW4vMnZTWWkyOElORDhy?=
 =?utf-8?B?a3BKczFQNHQxMTJjWjBLUUZBR3dzVDF4Y1dNSkRWQnVJeVJ2cVltZlcxSUkv?=
 =?utf-8?B?ZDMrRTBsODh4Z01PT1dMZ0s4SzFrSVkwazNLUFVnQVFTQUlOWmxVQ3loYnpR?=
 =?utf-8?B?dmpnQzJpZnQ4S1pFMFVwbHdrNUlBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acdd092-b704-4fcf-905b-08ddfd11f61c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:32:54.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHtXyx2tJbQbChepPmzMAoJ009q469viqUQGBi2+PNE3dilyQhUZHa+Rz+tG+96T7RIPM6MP/fGeSi804Ghacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030


On 25/09/2025 23:31, Saravana Kannan wrote:

...

>> I have been doing more testing and do see a lot of "tegra-bpmp bpmp:
>> sync_state() pending due to" on our platforms for basically are driver
>> that is built as a module.
> 
> It being "built as a module" is not reason enough for this warning to
> happen though. One of the main points of fw_devlink is for things to
> work just as well with modules.
> 
> In this particular system, do you never plan to load the modules? Or
> is the module load just missing this timeout by a few seconds or
> something?

We absolutely do load the drivers. Initially, I observed cases where 
drivers are missing, but doing more testing with the necessary drivers 
present, I still see such messages. A lot of our test infrastructure is 
set up to use NFS for mounting to the rootfs and so I am wondering if 
that can also be a factor?

> If these can be turned off, why not turn these off using the sysfs
> file or the timeout commandline option to turn them off? You are
> burning power by leaving these on. A warning seems appropriate to me.

Again the drivers get loaded, so that shouldn't be the case.

Jon

-- 
nvpublic


