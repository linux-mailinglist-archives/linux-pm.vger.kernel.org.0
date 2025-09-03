Return-Path: <linux-pm+bounces-33711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D32B41F09
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94BE14E3D34
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 12:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085572FDC50;
	Wed,  3 Sep 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SoFcd1tg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E32F616A;
	Wed,  3 Sep 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902838; cv=fail; b=FSSgv0iFGmdafgjFo6zgnpY1idQ37XnSVyfmN/QI26iePTbRJCjsB9CY9X1B5QdqKjw3G1TIxhSloRdxOoh960l/5me5jJXr/3tA6twMGVxdLA2vvnbaT1F9f9wJZvNvq33UCsmKkvH6RwALZuaDMI+UpnJLjbu1SepiA2MCMFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902838; c=relaxed/simple;
	bh=GNBXv6QZgz55Ww65hIYuuNL350dl7iVfdHTKEwrTIiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=abKSXa+qBEq/rAXCAG3nW0JeGwlkD05vUu18yU9RDLCAPj36dWPqveg24HcCQX1DO3x4Pd5SkaaqJwLhD6P+2myELWLzdePScn3bt5ii1JIgkjo830xK8tHW7twlwwFiSD5eR1RnsmbeW2ZT2yNaMMhruSv0c8gMNd3gAoPE5HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SoFcd1tg; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnScqUPbAoSfd6e5arFH54GFrDiijObtggVnXAyL25wbpH9m++EPWyeXmT/tk7a3/hYdyLgsJLxIDl3gOC2cBHXvGSsgE1PnQeZfLKdbnSojuqw119aVlUvUKkzoYda1OrjIgAj0/1aSN6lj4OOIrsCebWPtt4ilK6kpl6xHKwLo1tKyRf8mstFtVMX6VrPozGQUDPcPzpS7duJy9Z1R4qhLMczXNbowha+exy/mb8HwCn0b1c/oQd8yvk3N6ON9YqF77v/iGpjoMqNsDv4Xyj224zOcvWUg/UJ2bb5AtZyW0bLYptvV5ZLuhkehUPwL7BRcp+ovN6sTZJ400Evi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H34Sy6siy10siiEQulVrU+G71BqfD+QU+TCBhABMql8=;
 b=qXsqW9IHaUgaWPS5eeyM9t0ACBxnQKjomoxYwnTTOFDun6Bgg8RKkS4E+faHyM33fh6FXgmatKm72fhhJpuTkrxl1S68eym7npEQ7Fjca2Nnt75mYId/6X5iUsh0c9P8omp7zloShNznEPX7BCbXChXsD8q9UBy6NadgalS6ZoMoiAsi8mXVMASpTHD5frBW0PiFVoN6TXs8jXhgvT6BowX6Go4l5+jhOdvs7Qkk3BL5mWVb38fZWvh5CAUQ64fz9v7AE7Yi7eFSEFtFSUlZCOWIxmsvK/C0RBQjSkgSpmktYo538xjMUef8SBtIURRjr6QJfYBJqm+HBYH+CkRgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H34Sy6siy10siiEQulVrU+G71BqfD+QU+TCBhABMql8=;
 b=SoFcd1tgfsr5k/TkXQSCkPgim0y5BWKH5gX9d0t3clTE+La7P8EXoqw5iKVprDRVf+m0KzPH4lmeABJKidUYU3xL6lxHtvjRqaW5/sDBo93XT3eNMMrxrP4L0Asaa4zFhwaPsanffDXoYUkPothhEo9D0O3Mc+/WF4TUEs/AOEWvt6HorVKuOk8BcusBhNuOYdBBqnIBVdQ9C/Yka5HrGgLVvDaJJPnIZpwSy7PvpLwTtQbp9s9HYBwvT+pXhFjHxPU6ApxiQACX1FK/Jh9iAvblmr2DH0DBTJyv8CgtVSBvNsFejb+3X0TdDeSrxxGG+5Yg0fCerfXXCwLvGYxQOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 12:33:51 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 12:33:51 +0000
Message-ID: <a904d953-acb2-44f6-81bd-118f7abd22da@nvidia.com>
Date: Wed, 3 Sep 2025 13:33:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
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
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAPDyKFqSyP3e=JRFYEuFefWVN5SYJWULU8SKzXmrThvyiVGXgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0512.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 911f05a4-ba35-4212-0987-08ddeae6236f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU1lU2Q1UWRPZTluYTlhWnRjNFRHbm9FOEhwQTUwcnR3RnF2YmM5R3FmVGpY?=
 =?utf-8?B?Mm45bVdoQVUyY2Y4NkJ4MnFxU2E3SmwrTHdWN1hFcVFQTEFvc2pJVnBVUUI5?=
 =?utf-8?B?bEE3MWJoVjdWK09DV2hXazRUMi9EeWRabEdzY1plak5CRjdLKyt1b21CNmxn?=
 =?utf-8?B?UUZDNGFjemhVR0VoR01DS2hLZWQzZEtZSGNYbUtpdHpsZVlSMDAyNFl6S0RT?=
 =?utf-8?B?Z0l3TURTY1NvZG5qQmlIN0pIZVUvNHFqL2Qrd256QnhUdXFGd2N4anRzSlYv?=
 =?utf-8?B?ZmJlaDlxc3p2emNKVU43K09ObkYrTTVjczdlVlc4T2JibHNQdTF1VjZYOUQr?=
 =?utf-8?B?dGxkTUQ5eFMzYXdYUW9LaTBlSSszRVhTTm5XTnRlVktRaU5HRzY4cTFwN3cw?=
 =?utf-8?B?YVdEbEt2NWFaWHpZcUxOeTQrK2Rja2ttcHhESU1QSlVPelB4emkvSUFJYjdh?=
 =?utf-8?B?Z0tkQVc5ejRRbk1uVHl2c3grU2lXdFRGMGNpREpaQUVBNCtqYVZmWjZRUVZC?=
 =?utf-8?B?bHJZUDNxMzgrOU1Cem5FYmp1KzBlSER1amtHMkZYWXFCQ2hOaDVkTys0b3Er?=
 =?utf-8?B?UHZyN3FLc3FlQ2VweDE4UjFBKzBTb08vRHVGMnVWR1pUWXRYM3pDZC9EUStC?=
 =?utf-8?B?cW1XRW9DWmlCc2FnSVFSdGF6Rmt6eXgyYWo0V3JIcWdYbFBQanJwYmZTT1Fw?=
 =?utf-8?B?ckZlWkNLN0xrenlUSmFSbW51amw0Zm0wc25jbWllY0wvNm1RMzlmWHlIMHFw?=
 =?utf-8?B?SDAzMm8zWU1Cb0VBRHJRUFNkTUV1cmZYS3JsMGpBemtZRk9zclBqdkxlbk5q?=
 =?utf-8?B?azZXZzlpemNWQkhFemVsb3NWaFZ6WndCY1RDemp2dDVvbnc1ei9Wenl0N2JW?=
 =?utf-8?B?VnpuNUtYVSs1M0d1T0syYjZuWjhjWVlmdFhsMURURWU0ZzFQaXh1d2UrMGhr?=
 =?utf-8?B?Uy81TlNOci9JQlkzOG90ZjQ0azNnUXdjcWNCRnZLN0RXK3BMT0dSYmxNcGlk?=
 =?utf-8?B?anZyak4rcVBFdGJJZ20vZWZqK3RSRzEra0c1UEF5R1N4Ulp4eitHNUpFRzNk?=
 =?utf-8?B?eGhaQ0M4ekpEV1RGZ0ZET3dvRGxpbzg2L2pHaE1DTWx0V3ZQeWFvT1BEenpK?=
 =?utf-8?B?UXIvL1dob2RYWEE0VHlDalMxb2dqSHFlVWJHd1ZiVXltTnN2VHUvZllWT2Uy?=
 =?utf-8?B?ZXRGbFBUQ2dmZmdGRnJraG5LTnc1UkEycm9QcWQ1dmFCdWJCYlduSTRiM0RN?=
 =?utf-8?B?RjhocDNvY0NuZzI5b2N1eEFMVEYvZjJMa0pJQjc0Q0ZkYnRvMDFWOVgyaEVX?=
 =?utf-8?B?RnRVV3F0MTA2YmNlMGZ1a2ZzcGk2cW15ZXRHL0lsZlh6N1BlbTQyYjd1OHlv?=
 =?utf-8?B?bnlSVEM1bWMzN3NqdWpkWm1ydjN3WWVMS0ViUWRXMjA4VGN2VjUycjExTld5?=
 =?utf-8?B?eW1WU1ZCRFU4NkJ1bnowT0l4WURnUkN0REZTb2VHZHFOTk1iSGhyS2hyN3Qy?=
 =?utf-8?B?S0YzdldqOWN0Zm5hQVhLdFVtNGZmd3RzOTdTbmlwNGlOQ0NWeFc0akNDS05P?=
 =?utf-8?B?STFMYnc3NlVjVXBrMG5NT0V3Wnp6dldiVHZMdUNNdFp4d2V6QkxoVlBEYVh5?=
 =?utf-8?B?bk9uWTU4NXpaOWdOSUxtMnZnWnBiVjM2dTk3dlJkVWMyN1ZnYkJTKysvVmJU?=
 =?utf-8?B?R056ZXMyZDFCQ0VhL3F3YXdpc01VWG9VU0xjR28rV1M4RjFXTFUybzNudGFU?=
 =?utf-8?B?cVdOMm4xSXN6YVNGSG8xcDZaR1pvbEVVTWhtVFFldHpZZTEzd3ZzY1B3NUNG?=
 =?utf-8?B?N25RNCtFcjFIQUs1ZjZMNmgwM3RlUkUyN2NwOWtJWW1MRk0wUjArYkhOOEpx?=
 =?utf-8?B?ZmpQR3lGOW04WkdwaU1yZ2RZZ2pxRGZYQ0VxOGFvMWJidXlLN2UrNXdlTDha?=
 =?utf-8?Q?75/68FOWmB0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVVlM29pUG1ta3NWY2IvK2MxdW9GcVhtd2ZVdXZLU2tKUkhaVjFMN2VUTFV2?=
 =?utf-8?B?a1Jka3lLQ3Q2MHF4Uk5YdXF2VUZnNGlNSGt5cDZKY2hDdmNxb04zMmJnYVpW?=
 =?utf-8?B?TkFWMi9qOVpadEtnVW56YkE5NmRDb1NjR3VGREZxSGtnYmUvZFRtZDBKOThK?=
 =?utf-8?B?YktnVlBrc2NCT25ZZTlVK2tCNjh2ZSswMGdIM2pKK25IcmdZS1ZMMEJzK3hs?=
 =?utf-8?B?aXNmTTNTQVlNNmF3OE1nZVFhM0ZLdG1wbXIyeWdLYkFtK1BtRVVsSW1oTXFs?=
 =?utf-8?B?NEtFNjNVOUpQZjVXQUxsMGZYbEtxdU9jbnhBSCtvYUh5dFV1UHJMZ1l0VnZx?=
 =?utf-8?B?VEJRQWZvNE9GRFNGck5EbzQwV0xGdHFhaS9GRGtqeCtJL0Z2SnVuaHpkR0pn?=
 =?utf-8?B?dzg2cUZUTjR1TXNad0NEeGMvRnpVOGhqTzAxWWNneHlSdGNSZmpQQytjcW5V?=
 =?utf-8?B?dEZ5K1VhaGNWckRHK0w0RWx6Q0NXd1M1L0Z4VEp6REMzclFpdmZpRThGL05Y?=
 =?utf-8?B?VDVDcHpaUnFiSjc0VmQ2THV1ZFYwdUxFYVN6c0tUZVZQZlFuZVF2UzNlWnpm?=
 =?utf-8?B?bnlDS0Y1dkt4dG9JODhPZGpnUjlsN2xKaWNsMCsrcVBkNjFkWVZnNkt2NldW?=
 =?utf-8?B?QU5JTHE2U0k0M0RUREMrQXpWKzBJTmNPblZKWTR2ZllBdnJKWTRNa3VoZkhM?=
 =?utf-8?B?clAzaXYxV21udXprTFhid08vY00xUWlpMG9ra2dxaXNUMi85SUs4dnBrTnJw?=
 =?utf-8?B?Z0tLSUZQR1RqUzFOREJCMXZyS0dEbDFEYmtRallpWlBtVDlaQnhaS2wzTFFi?=
 =?utf-8?B?RE5jSFF3cWc5dVlsc3RiL1puamVUamRWSE5iRTNpMllqY251eTU2N3JhUlFj?=
 =?utf-8?B?WDdzQjZWd1BiQlpmQ0djTVVmaGsyVXYzSG41SHBWR3lMNlZ6U2pyY3dwaEs1?=
 =?utf-8?B?Ukg5bGh3M0NEZHcvVGVOTEVmNy9mbXZ2b1puUEoxMExsMmVVa0VsdHhxM0ll?=
 =?utf-8?B?VytFbGk0bzRmTnJUN3l3WDVHWkorVW9Ca0hBWXYzTGJBRXJKaTc4UEY5dkd6?=
 =?utf-8?B?V2QybjZwbVJXQ2phVTY5NWZwVTBneWdTZ04xb0FNdDJ3QklMeUNsL0l5Z3hZ?=
 =?utf-8?B?eEU4NHBUcHVYazFoTFFKOVh2Z1pDWEMrVmN2eWxPdFp1STVSNVZqekNpNEVO?=
 =?utf-8?B?WVNTRk45akxSeDA1T25rSXdzNUZNT0o4eU1jOS9oSkpoM3IrL1VUMUJaSjJu?=
 =?utf-8?B?MzhzTE9WdkNYYUdXQmIyR2RhV0Y5elFtbnlXMzJWc3h5MDFjb3ZobUFDK2ZW?=
 =?utf-8?B?OWpQVXhLSE0wYU1HYzY2a015VXZMbmlkejd2ck9CR3N0NVhxY0YvTEZVTVFG?=
 =?utf-8?B?VXB4VTd0WUdwWWdrdHA3Zm9mbDN3eXEwSU5HSDZSWUZvWkpqWk14eStyQXRJ?=
 =?utf-8?B?YUZKcUhGN2JYL1k4MGR1NXdsdFNVOTU3aWN4QTBmdXArekludTkrWTFCMk43?=
 =?utf-8?B?YlRxVENvT2VodHB4WDBUa0F6TTEvc1BIUWg3bEZqY0YyQUxta2E2ckhsTWh1?=
 =?utf-8?B?bEkwa0RQM3NtMzdud3Zid0o3Q3ZGaldIYUthaXo1bmRzKzN1a2dhby9HZlZE?=
 =?utf-8?B?OTJkRlFEUGw2RTJJU0VFdWg5djIwSDZNZ1hhSnV5Z1RiWkhDMGtIeXJzbEND?=
 =?utf-8?B?cm53VTFoRGNJQ1U5Q0gwU3VkcDIrR2hYR1hKbjV0YlM1aCtRQ2xzQ2pnUlFZ?=
 =?utf-8?B?VkpEUUNRSUZ3dyt3Wjc4dGsvbGM5T3dXNHdzOFpsSUJyV0I1OGJOdE0yZEEy?=
 =?utf-8?B?Zkt1ZVhSRWxwMTdYWGpiUFFVdVVDaWlQWVExYVh1ZmhPK3A3SlI4M0l4SjFK?=
 =?utf-8?B?SzVxVkl6Q3JMeVg5ckNIZ1hYWDFzSmtHcFY1SllMWmx0Z1lhTzEwSVF2VERv?=
 =?utf-8?B?algxYmNreVhYMWU4UnZTWjJBaGtMUjVCbXk5TGFjRE1EVCs4aEsyTjVyTVFV?=
 =?utf-8?B?M1N4b2FEVjgvaWI0U0VYSjNWTzlkVnRIK09na0hqc2RPWUhkZWJDdUFnMUw3?=
 =?utf-8?B?NU14SnpyQmR3NkdtZDJxMGZZTXhOdnNjSVQxTjF4UGZZRTl5bzh5Q1ltMHlG?=
 =?utf-8?B?dThsMXhsa01UK3VsbGY0RWtXdkpBdFNlT0MyUnlRTEowblBYd2Jlb0lWdDlJ?=
 =?utf-8?Q?iiOTCXERowEoQriVfC531CbQjz/+h1b1lL89E2RGgyPf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911f05a4-ba35-4212-0987-08ddeae6236f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:33:51.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6Ts65PteBXAXBOCKhwx8O5asZn7uHciY6JZuxQQT+FvmBn3Ns3mRHx8H5EboS9HpB9a8O10qq29MdVRGGYYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

Hi Ulf,

On 11/08/2025 13:11, Ulf Hansson wrote:
> On Thu, 31 Jul 2025 at 17:07, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> Hi Ulf,
>>
>> On 01/07/2025 12:47, Ulf Hansson wrote:
>>> Unless the typical platform driver that act as genpd provider, has its own
>>> ->sync_state() callback implemented let's default to use
>>> of_genpd_sync_state().
>>>
>>> More precisely, while adding a genpd OF provider let's assign the
>>> ->sync_state() callback, in case the fwnode has a device and its driver
>>> doesn't have the ->sync_state() set already. In this way the typical
>>> platform driver doesn't need to assign ->sync_state(), unless it has some
>>> additional things to manage beyond genpds.
>>>
>>> Suggested-by: Saravana Kannan <saravanak@google.com>
>>> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
>>> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>    drivers/pmdomain/core.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>>> index ca47f91b9e91..5cef6de60c72 100644
>>> --- a/drivers/pmdomain/core.c
>>> +++ b/drivers/pmdomain/core.c
>>> @@ -2600,6 +2600,11 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
>>>        return ret;
>>>    }
>>>
>>> +static void genpd_sync_state(struct device *dev)
>>> +{
>>> +     return of_genpd_sync_state(dev->of_node);
>>> +}
>>> +
>>>    /**
>>>     * of_genpd_add_provider_simple() - Register a simple PM domain provider
>>>     * @np: Device node pointer associated with the PM domain provider.
>>> @@ -2628,6 +2633,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
>>>        if (!dev && !genpd_is_no_sync_state(genpd)) {
>>>                genpd->sync_state = GENPD_SYNC_STATE_SIMPLE;
>>>                device_set_node(&genpd->dev, fwnode);
>>> +     } else {
>>> +             dev_set_drv_sync_state(dev, genpd_sync_state);
>>>        }
>>>
>>>        put_device(dev);
>>> @@ -2700,6 +2707,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>>>        dev = get_dev_from_fwnode(fwnode);
>>>        if (!dev)
>>>                sync_state = true;
>>> +     else
>>> +             dev_set_drv_sync_state(dev, genpd_sync_state);
>>>
>>>        put_device(dev);
>>>
>>
>> Following this change I am seeing the following warning on our Tegra194
>> devices ...
>>
>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 17000000.gpu
>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 3960000.cec
>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 15380000.nvjpg
>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 154c0000.nvenc
>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 15a80000.nvenc
>>
>> Per your change [0], the 'GENPD_FLAG_NO_SYNC_STATE' is set for Tegra
>> and so should Tegra be using of_genpd_sync_state() by default?
> 
> This is a different power-domain provider (bpmp) in
> drivers/firmware/tegra/bpmp.c and
> drivers/pmdomain/tegra/powergate-bpmp.c.
> 
> For the bpmp we don't need GENPD_FLAG_NO_SYNC_STATE, as the
> power-domain provider is described along with the
> "nvidia,tegra186-bpmp" compatible string. In the other case
> (drivers/soc/tegra/pmc.c) the "core-domain" and "powergates" are
> described through child-nodes, while ->sync_state() is managed by the
> parent-device-node.
> 
> In the bpmp case there is no ->sync_state() callback assigned, which
> means genpd decides to assign a default one.
> 
> The reason for the warnings above is because we are still waiting for
> those devices to be probed, hence the ->sync_state() callback is still
> waiting to be invoked. Enforcing ->sync_state() callback to be invoked
> can be done via user-space if that is needed.
> 
> Did that make sense?

Sorry for the delay, I was on vacation. Yes makes sense and drivers for 
some of the above drivers are not yet upstreamed to mainline and so this 
would be expected for now.

Thanks
Jon

-- 
nvpublic


