Return-Path: <linux-pm+bounces-7797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1F8C4DB6
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283421C2143A
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F828DDC0;
	Tue, 14 May 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WEwYnLAC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC8B64B;
	Tue, 14 May 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675452; cv=fail; b=kzupwTwBOn7wIWX3/ZCGAHLZUWmx2qG/9+Lk2LP2W+n9dIXyHPB3h4TEDnjVzEhGlBpcxX4rQUodZOUj3LDbJ7wWspjlYhVyBpsMHo+Au81cZeOPXffAG8NLhxqwFEiV1oguDBa/W1IOkF/RTukDklq5DOiyshgjeXqRhIgDrI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675452; c=relaxed/simple;
	bh=Tfo/znfC8PtVmp9/P4gYC0vd77wDY8CXs42sG7AvXus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xjvd9anNzCqEVk2pADU8ikTnSDLXCeeepWOvFKmRxGzAYgqGh3EAfiUYE+FJGSrvpTxdMJMiB3jyBo1lX0wYBOAite4gmYA+sl18dOG/w5yFi4iDwOXFB/zSjVwtceDUyBfHGVa0GUieibOCcvn9eOlaJkuACn3LKjQC7wGKUSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WEwYnLAC; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjMy/fLq/KIwPJY1rULaKSUa0GNWLLlIFlMaU0vb6/cWcrT3GkV4jMHJJ5+HoQuduQ2+oz0+m/KJQNJ934Zu9RI598FSwSr3gRLhE/0K1JAzDdJ0y21LooCcGfRA8sN8rf/xfa8VdsXvIgVpb1i8aTy4aI30hBFcyijbbGZ+S0S+mu/8de1g+rx3aezW3JuHWse3509zt2Tcz8gGXv9+jGqA926oV0ThT5ZFC/eQbRaHITM6jz8MWL0P4Enm4kfaPT2iuUgvcdPZMtPNzy2rvFoIUyyLbSaDYl3oONAXC0OqNhI5IS6A1aWSauZ89N368OootPZvkv/mpKn7npZlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egeD9T8HYHji83xYrQVwzWH1b3bb+JshEvNEleG7sas=;
 b=mehxi1frnf0kW6pT7hyp/Q/r3cnliwP1+yJUnEbhbXBGUNXi5JzlQkGPpM8Ek1FmuRDnHxdOOrvJthpB73JXBrTWqdH3cZBmqjsP/YgWASn2/uvbhaIubUQYeF9TAFJf4MLN2n6MYb6fWV69MYy9tVHBu9nIRbhRtvRxOndExRPvcxmyX3m63sWz2Sv6RBCKuO1CO4j4ocMZg2UvOF1mIXK+rlRNSvVQs1tdudRE+ngFzufNJ39OEzID4QKH8vYPxfCpa3l4Aap+orrNyAMLQHQBnd+N4gixo2KUsAF2Yh9qLCsrqz5wx7mGi0W+pvGaMaFWKGrj6tdTYoA+YAzXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egeD9T8HYHji83xYrQVwzWH1b3bb+JshEvNEleG7sas=;
 b=WEwYnLACaWmNr+S73tEgmqCdkQamFt6KKVjNeGhpZOV0g8gMpRtWRWkkuY2oyVJRu8axik6HVqgF5e3wInKXALLiFD7gGkjPunTI8zapTHuVCNon81oZ45o+TgqkaLRfbJc43GFGK8DspB3YJU+c5P/0J6ykxNtHgJmzh26osFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:30:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:30:48 +0000
Message-ID: <dbcbe659-08cc-496d-9fa4-6520167ea325@amd.com>
Date: Tue, 14 May 2024 03:30:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] cpufreq: amd-pstate: fix the memory to free after epp exist
To: "Yuan, Perry" <Perry.Yuan@amd.com>,
 "zhida312@outlook.com" <zhida312@outlook.com>
Cc: andypma <andypma@tencent.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "rafael@kernel.org" <rafael@kernel.org>
References: <PUZPR01MB51206C1D9F3E2005B5BECCBA92E32@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
 <CYYPR12MB865591A37BC2582E247D0A1C9CE32@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CYYPR12MB865591A37BC2582E247D0A1C9CE32@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:610:b0::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dde4c0-688d-431b-9eb2-08dc73f02837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFpZMCthV3c4cGZ0Z3JPNEN6dWVwemZZK2VEY1R6VWk1cThrYUEwU3hGaldD?=
 =?utf-8?B?KzhpWFlGRGJ6V0hqRmtyYm1VekErbnBPZStqRmY3aUxtS2E2RGt1MFdDUWVM?=
 =?utf-8?B?SjFiQm9WNUh5Rjlhazl5aGhNeG5hR2I5T2p3RzAzdlMzV0lSMEh1SGc1NkVE?=
 =?utf-8?B?R21uZEt5Tys5MGFrRUpDYm1HZG1Xb1RLNnhvMi95NUtTbzNuWTZGYXl4bUdB?=
 =?utf-8?B?UUxySkJnb0YxM1FJaVRGOHh6N25jVFkzdXdUeFpvYXFNN0t1NzZNcW1MWU5j?=
 =?utf-8?B?alJLTWhOUEVmZ2EzejhHN3pFbm1NNlE0SlJzMEprUE9xNkJzNlRqcS8rOVg0?=
 =?utf-8?B?LzE4M1U0YWRpZVBqcDBTK1JWZmZKaUh4Y1F0ajlqK1hPVGx3RHJkb0ZRdTdB?=
 =?utf-8?B?THBLRUFRV2lDM1liRXNPVlY5ZGF3L0NEbStwV2ZwWDg2TWJSUVNTQ2RwWkZx?=
 =?utf-8?B?dEZrdlB3MmV6SkNOZVRPZVhJMTNmWUZ0Y0d6eEF6TDRTMmFGOUNxaXRrL3h6?=
 =?utf-8?B?eUpEV3k1bjZPNnN0L1hzN2ZxUndGbWJUS2lJSS9SdzJuZWoycDQ4ak9tYk82?=
 =?utf-8?B?Mk5HNE5yZXFtZFpNTWJaNDV5MzViT2dPaHBZNmlGaVhlK2x1ajVXbGhpd2Y5?=
 =?utf-8?B?SURUSlQzWk5jd0I3RG51WXB3bmt6b0hNUm5JN2VIZm5GenYvdEFwWEUweE51?=
 =?utf-8?B?Ym55WFFlRk9TblV5dk5tK1dlUFJObk5zK05md0V2OGdrTTF0V2dTbUhCK29F?=
 =?utf-8?B?c2h4YzdXcUdyS2hKd255Y21jN3BkcVhRcjE5c2w1d2pFNFI3Y011bkhKSmVI?=
 =?utf-8?B?N08vcW5sdWh2MzRuOXRxMHNjMzk4N1NrVDdXamtZNHBnT01iaDZhWVZNNXFs?=
 =?utf-8?B?ZnNLNUZ4d3gyVnh0QzVIM09qYVZWUnhrbHE3U1RCWDd3UUZ2Uk13YWlXbmZq?=
 =?utf-8?B?WnhUVHg2Mys0ZUtCQW9hVUlpWllFdnNNQ0QvNVJmanhWaXFsdFJFeWYxcmc4?=
 =?utf-8?B?czJITTZmaEpFSVMrcU9MSngvK3BrK1VHODR3Vm1QY2twZVB6KzZTcCtKMFFY?=
 =?utf-8?B?bFBOY3RzRzZDai9hWVRSa0JDMnYrYW5rRmhtVGtVc3hZRnduaUhMZS9DeWs3?=
 =?utf-8?B?dHN4MkxVK0tFK1lBblNqSSt5Wm5WU044WEVmV3BFOEtyak8vaDV0aktLa29D?=
 =?utf-8?B?VzJtM25XdnVCZ2R6QXNiUUZWU0pYMUFwUE8zdUYwZENTOGszbEpqL2UrWFAw?=
 =?utf-8?B?L1NCOTdzcU5DQXVPcTJ5M2FYRlB6SlB2K01jamZZMFJXSGRnOUtQYkR6K2N6?=
 =?utf-8?B?Nm94aFBYa0VUdnRMRS8xR2JxN3h2QURpQjRWSzhrdVh1aTk5OXJuQzJkQlVJ?=
 =?utf-8?B?OXB5UnpCSzkyK0hLS3dLMEZJNkRNUGtVbkRXRjE1aVlSc1NpdG9oYis5TFB3?=
 =?utf-8?B?dC85OTNHeUpkQ0RDVU9BcVV0SFlhcTBlbTdUSW8rVWtyNnpYdnF0ZjU3R2c4?=
 =?utf-8?B?ZFhmdjdwU29oanRsaC9IY3p0V3F0bDB2c01PVzcrY2hhdHhXRDZ0S2cxcUFs?=
 =?utf-8?B?UFhJT01obXhTK2d6aDk1Q0dCQjAvZEgxL0dGczFaYXFpTHR2Wm5leFZEczBX?=
 =?utf-8?B?TmUzQXZYTHVtdTVzaGpmTkZQT1FHZmxCNUxpb0JNemQ3SXc3YWJtNEhBd3Qw?=
 =?utf-8?B?dWd4RytaOGZZTmczREZRVnJPc1BmVFVpeUhxQnM2TjhRbG83UVd1VnhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anRrckc2YjMwZ3c3WENuUWRCSTIwai9wK0thZW1MaFVDWVo1ZEpzMXhxOUhj?=
 =?utf-8?B?ZGFxR241TGhIZHBZZUpiTFNIMzBvSE53WkxLNkUwK2tLSWZtdVg5eHNxV1Z1?=
 =?utf-8?B?dHNsVmExT1ZUak5yWEpRMUVBK3FpRmpoK3pLeHRneGNkMzdiZytQcWJxY0dX?=
 =?utf-8?B?TEZaT0Y0bHNLaVJmZzAyK0xpTG5MNGNRSUN6cEFzTk9vNGFwSTBvV1FwcjYz?=
 =?utf-8?B?LzRwZ0JDWFZxcHJFTEE5NldUQ1VlUW90cTlnQmVSdUpVWUkxd2RuTEh2SUYz?=
 =?utf-8?B?VHlpcVNNY1ZaT2xvVkJUeFhib3ZCSkpMNFRubXVIUWllYWM0SW9LTmhabFVS?=
 =?utf-8?B?SEFvbVZsbHhDRlRKZEVQSHFUSGFoMUtKZmRvTHNwODYvUmFjMzhBU3pHeGJT?=
 =?utf-8?B?RnhYL01CNXdzMU9ad2dUK1pmQVhVekc0cVgwaFpNQit1MGE3eUJJTzBUeU5Y?=
 =?utf-8?B?SU40NWhaWDZVcW1BbzVtVmM1cnd2TC9MdldSRUVzWjArM0N3TG4wSkF1aEtQ?=
 =?utf-8?B?MEowMVM2UjlyRlpzWmhSNkQ3R3NOUEpTWDROd3RkV3ZObjFSakFOWW4rQjRP?=
 =?utf-8?B?NndXN3lSekE4MjlwMVg3elhxVHl5TDVUbmQ1M0VVbDczUWlLY0JvdnVONFhY?=
 =?utf-8?B?TGlRZEV4N0phclpYRXB5UkxkMXNRY3dHckIyVmZFWEJSZEFPekNQeEx3TG1j?=
 =?utf-8?B?aUc4d3E3dXJMY1pXSzNWN2p0MkR3ZmhvSDJVOXFYZi9ZQlAzSVRsRDRzVnV5?=
 =?utf-8?B?eisvSVo2bmhFQ0lZMWVVUExCcE9PajdJTGpqVFZRN1NnWGhvV2diTVJzWVJ0?=
 =?utf-8?B?VnFZS2pKRENNMjBuNkNpdkJsQTZQQ0ZkVDR6cldmbHlES3Q0WXBPc25VbWw1?=
 =?utf-8?B?ZnM1UjZtSlJ3K010WGlOWEphZ3dlUEhkR1pzNEtvVDVuQzZqeFhsQ0RIL0tu?=
 =?utf-8?B?OE1LUEt3Zk9XRnZZcFRma3d6b0ZIVDFDZXdGWDZLdm9Qc2huMXlQdjhsTXpq?=
 =?utf-8?B?Wkt6OUZsWU1DbDZwWVpodStGektpaVBwcjJ2bjhxamNwcjIyRUxwbElKa0pR?=
 =?utf-8?B?ZXlHcmx1d1lxMlFaZWtBVC84dzJEa0g3RFFZYS9HRzFtOHI0L0hhWEJLNmhO?=
 =?utf-8?B?NGFyYzdRNHpDUXE0UThJbDFtbS8rZ1Y3TlJZb1J3WlROdHIyMUF5R3FqT2pa?=
 =?utf-8?B?N0p6bzBYbmw0TnhGczlqL2prVFd2MXhic29JSk1KTmo4eEtUOWNoTUhWaFM1?=
 =?utf-8?B?QXhwN1NXOWJpdmFsOWNEVURTekwvd1ZFbGVtaFRwZVZDd1RNWU5GNk5hRDNl?=
 =?utf-8?B?T0x4WEFMYjBrOG5nbzlaMXVZZ0l1VzVFeWs5RUZpZEVnWjVxU3ZMZ3RxV0Uy?=
 =?utf-8?B?N08ydlhrcTNpLzlQbHFibXcraTdhcTI4L0E4d0tRSHM5UHRnUG5TaFlvbi9v?=
 =?utf-8?B?Vm1GcXVuUC94NDJKQjVZY0RkZkN2NnFSek16c2V4ZyszRWJqb3BsTkk3RGIx?=
 =?utf-8?B?ZmFaZU1veWd1dkxubXplQUxCcElyazBtdTl4cEd1ZDRhQldzRXVWcHg3Um1r?=
 =?utf-8?B?RlFhYUlhT3BZb2x2NlJKdk5Ib2s0S2Z3dUpXQzg0djlCcWkzZ3JxRUtTTGI0?=
 =?utf-8?B?TzF4eXpKR0NuR3FtTmRHb2ZXeTQ1MkozdTJPR0NwK2ZkRnE0V0p6R3lJWjhj?=
 =?utf-8?B?ZjBONksyaEhVeXZhRjd4SlBOS2Nyc2dQc1lWVi90UVJCajhONndnQVk5eE5a?=
 =?utf-8?B?WFlMWnZ4b1U1RXZOeXBIN2hNd3Jhd0FjcjV2dXZHcDVEYW93clVLY0U1NFl2?=
 =?utf-8?B?SWpuY0RrYW92YjloVC81YjlDMVVmVXBnSFZMa1ZHemdOMnp0U25QTnZLbGho?=
 =?utf-8?B?dWVsUnpzdk9jOVJVWExxMjMwT3BtZzhVTDJKTG9KcHMrMmV3d0FHUkJzTVdW?=
 =?utf-8?B?WVZ2Q1BNN0V3MXJhbGxXRDVnb1lLK1M4VlZ6V1JNWDlwUjdIU1B2Tm40d3p5?=
 =?utf-8?B?dm9KOS90MUtma0VYNkFVdzJKZXExUkREdTFnU1AvWUwwYmluVlJ5amJvK0lw?=
 =?utf-8?B?TEpQMDcwcUd5dUkybjJ1YmpTTTRZTEdvMmZWUzhPc3Vyd1c2UVVHblBrc0NW?=
 =?utf-8?Q?BUQt0ABAyx00bZHJLcv02aDxR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dde4c0-688d-431b-9eb2-08dc73f02837
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:30:48.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mEg5qyln/pZBTWHQqqFncDTDlJhCpCSOdSDrbSEAxeDg8mp2oMXnsM0e7GOHCZAr2xpaURkLacotvAQSL0ifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606



On 5/14/2024 3:24 AM, Yuan, Perry wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: zhida312@outlook.com <zhida312@outlook.com>
>> Sent: Tuesday, May 14, 2024 2:43 PM
>> To: rafael@kernel.org; viresh.kumar@linaro.org
>> Cc: andypma <andypma@tencent.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Shenoy, Gautham Ranjal
>> <gautham.shenoy@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; linux-
>> pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [v2] cpufreq: amd-pstate: fix the memory to free after epp exist
>>
>> From: andypma <andypma.tencent.com>
>>
>> the cpudata memory from kzmalloc in epp init function is not free after epp
>> exist, so we should free it.
>>
>> Signed-off-by: andypma <andypma@tencent.com>
> 
> Looks like you need to fix the format of the `Signed-off-by` line in your commit, you need to ensure that it follows the correct format of including your full name and email address. Here's how you can fix it:
> 
> Signed-off-by: Your Full Name <your_email@example.com>
> 
> So maybe you want to change like this.
> Signed-off-by: Andy Pma <andypma@tencent.com>
> 
> Perry.
> 
>>
>> Changes since v1:
>>        check whether it is empty before releasing.
>>        set driver_data is NULL after free.
>> ---
>>   drivers/cpufreq/amd-pstate.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 6a342b0c0140..e100c5b6c9b2 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct
>> cpufreq_policy *policy)
>>
>>   static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)  {
>> +     struct amd_cpudata *cpudata = policy->driver_data;
>> +
>> +     if(cpudata) {

You want a space after the if

But isn't it safe to call kfree(cpudata) even if cpudata was already NULL?

>> +             kfree(cpudata);
>> +             policy->driver_data = NULL;
>> +     }
>> +
>>        pr_debug("CPU %d exiting\n", policy->cpu);
>>        return 0;
>>   }
>> --
>> 2.33.0
> 

