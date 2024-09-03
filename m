Return-Path: <linux-pm+bounces-13449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC696A5ED
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F53E1F214DC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD718F2DA;
	Tue,  3 Sep 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VSmywxKm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B28818C90C;
	Tue,  3 Sep 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386082; cv=fail; b=Xw0CJDlppnko1BAn5J+rln4vsCkid6Y4ycRrdAgJIZI/LFbY/QVICXGgHN0FhcYQ1z1MERraFGittsNY6aDxW/YC/Yjn6xGu5DTM/3nBrnhBAxGOl6DgdY7afx/4AyHLEBecsnrWd8k1whPSE8wzDOLzVe/tUq5BIlenoLxFnlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386082; c=relaxed/simple;
	bh=3lodKDA4GluyuMQP+VVaTKyDmAywXxCdGOhac3QPCjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K347aB6pgXZTaXpz4Z93e9DbYbmv9ITk1UfJ4DsOsaMB/uuRHJJlUhZ7cJUMPA+GXuQZtvcZNOq5wyYrKXKOyfp3HuNqeOryZemRyurWbg+jbA763y36Xa7Jjg5DHipWSxGdkXH6LBfAZ9W0pNms09qHGXNsHBjqJwOuBcO2IyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VSmywxKm; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpLJYEqEd6kI2p1kHm45Ctvwf3fnvli0JIhKcfChecfdW9kyz2RcVm1FE9FuW8VA6R99E+PZ+8r8KUiduUddUj6GQjvnQVe67Xh94s6QMaHbb4K+5ZQLRY4kn8iHWiM1etE9yk29B6UPhsMcdEFeKG5IKOCGNEwO0yUCvG6aEL+c+MpRZw6sIxFF14vFiKRwVGZsBujWO5EzA5QM0FC6IXeFiKbopRqFGq9oQjUmUtzzosOYuxFa/9JMy118x47v01n/M7PWKlEDTiAPT/JsqeUgpV+tA3XWQFDu9w+uUpz7BrZKwZhw8+5OMWoF6pqcx6ad1H52wt8yv1bkAMGOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve+1+qtZ7hrQfOFkrx/ubzEOuhluzVKRX97EDHQ6kVc=;
 b=R9xb4W7CvSxC9BfW2AlrTP7jPXbuoE+60Z4Kt1u9a/VnqKO8db5HOPDDReBHn+YtyjpKS/VKtswz+YzHpuH5lvECWKPtXVJLGkG4jKDuNp39txJOnCCmC4KM8jbJAP5IiHJkzU/NEKodmBbU760QdJ9KxOFJgbpOZqkP4yMySfdRdiDcNr1ubhYYOkejJyrJODkSIj25TyhIsEgPiluaFvFw0uzMZ3ImE/aI3dh1yJTJ/mR/HMKtU+HvuAHy4sg2wJl7Y5KrDDndUaGTagLZLNadfz0ldq63mpoz3y/aoIxnaBRvoH+v/PO7FZI66+Df24YMeUSmgflms2IFq9dr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve+1+qtZ7hrQfOFkrx/ubzEOuhluzVKRX97EDHQ6kVc=;
 b=VSmywxKmRWXyqqkhX8aHp//4dOJifzOn+y+3T/A2Q6GNEtE2OOVJA1Rx3nSOghghlg/gxcDUst7WdQ4tRAoJh3R5iQl6kkUWGb/9AzhwoIyH8h3xlVLiFKmuKpr4LESEg9qZJsutMPZaqgUYgMi4oe9CZsJ9Ac6+OS6RPVBbndw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 17:54:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 17:54:36 +0000
Message-ID: <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
Date: Tue, 3 Sep 2024 12:54:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the scaling_max_freq
 setting on shared memory CPPC systems
To: "Jones, Morgan" <Morgan.Jones@viasat.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "li.meng@amd.com" <li.meng@amd.com>, "ray.huang@amd.com" <ray.huang@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Arcari <darcari@redhat.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
 <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
 <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0152.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b0ce19-71e7-4af8-e3f4-08dccc4179ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3BoOFR3bHZXd3BqRDF4eWl4M1MwUEh4MmpLMlRqS0h4enR3aVRCUVFMNWEv?=
 =?utf-8?B?UHZFTHJrdTdVK2hMZmRNTVNlTm9SV2xVQ3h5UjFNc2VKZDF1cktBOFhXVmtj?=
 =?utf-8?B?a2FrMEZxamtOdjNBdDhFWFY3YUIydXlYTXR1RGJKeUFPZ2tnVVRPOGtzQWFN?=
 =?utf-8?B?U05aUDl3ODVsdzBIQWZhbTVqaENtbGdkekhYS0hTRlZFZUR4NjNuc3BRSXVN?=
 =?utf-8?B?b3VYR3Q4TnRFNVdmdHVHUzZCMGpXOTBJVTJDS2k4OEF1NXVEVUF3MDlZcndo?=
 =?utf-8?B?ZlVNNXVnNEZ6YjdicDVyWTJSeGh4ZTV5SiszZFluSGxKSGgwZjRidERtZzlH?=
 =?utf-8?B?ODVZSFhtRXI2NU1ucnlrOS9ubWZDQ3AyUGhkVjM2UTAvMEF3c0JUMW5rNFN3?=
 =?utf-8?B?Qm9uOFVESjUrM2VpMEg5dHZxQzV3QU5tQUhEcGd4dlFWZ3NrZlJQeTBrZ3RH?=
 =?utf-8?B?NTB3ZjFpa2FSYXpmTXMydUdFK2NCZVlNM0FpQXNXUDdJUnAzVHQ3NHpVQzJh?=
 =?utf-8?B?RFVwZjIxRmJKUUpKN2ZWdjVGZFJrNC9WSk1od251Ujh5VEtkVC82bGpzaE4z?=
 =?utf-8?B?dERaYy9yTThQQzU0bXZRakNtTVE4Zm5tU0ZzV3lpaUJCVEc2VEVrTnJKS3lF?=
 =?utf-8?B?M1ZmTGIwZHBuTTRCSkxqQ1A4d01XMCtDY2F1Smxla2NzeUxKUWRYWkhWS1d0?=
 =?utf-8?B?eEZtUHJVa2krU3ZXNnBzdDRIaTBMcVQ3dG1zK3RvL0pYeFE5ZGQ2SzJaVVY3?=
 =?utf-8?B?NlJ6STlrTlc4L0xKWEcrZG5zUldXVkpiV3NxT2gyZlBYL1FvalF2MkI4UzFl?=
 =?utf-8?B?cUNqY0J1ZGRpcllRU2xtV0psVVBzcDZ2bklwVTkvd1NITUtjWm9zZU02b21D?=
 =?utf-8?B?b1FGdUlWTktYMFArOXdTUTRMb2MvU0x1Si9EWHJIeWtNMy85dkpHdkgreDNh?=
 =?utf-8?B?YjhWWEtBV1N4dTJKMFBJNTVFUkhWV0l4SXF4Q0FXdWFyQ2h2Vi9OZkpQTTdD?=
 =?utf-8?B?SjJFdXBYdFM0NjFKTDhlTkEzZU8zMFU3bzFWWFA2TXBKNzNtWWpoSUlKVk1P?=
 =?utf-8?B?Z3pJOWRvS01ndHIvNzhKTE1qeEV4OHpWR2xwcVRyVzVpcENiRHN5ZkMxRWgv?=
 =?utf-8?B?MDZjdHBzbWZtR3VWWUV1Mk8rQVlRWU1HWDA5SU1oWXBsODVEQmwrQzEyS0V5?=
 =?utf-8?B?dURaUGNhZXFXOHBQT243aTVVdDgwNStMRGRES0RSQjJESUlhQ3pGK2hHL2Jr?=
 =?utf-8?B?OURsVEw2eXlrRUxNL3VEV2psZXV4T1Z3bzlsZm1hR2dlNVdEd05tR3h5V3N4?=
 =?utf-8?B?eElWSlY3NE5DcVlWeFdnUkVNYmQzVStrUER5RnZ0bGY4bU8yUGN6K3FpU3ov?=
 =?utf-8?B?clN4d2xKSE1SVFdDK2F6ajRMcXdZampFV2JqaThVOFQwYWZUbHBKeFhSR0E0?=
 =?utf-8?B?MmYzOGxOVXhYTDhRSzlVbytnM0FvRXRmdmdFY3JmbnFYNWM0TE9WVGMwYSt0?=
 =?utf-8?B?ZTB6dDBHNXJ0b0gzMFlqWDdjTW95Q2c3NkYwVTBJazN0em1lc0xEMVFWbXFi?=
 =?utf-8?B?YUhhVDMzTzZ0TkM1V1BpL0hGWVZwZGFmZmk2aHU1KzljQ0NOcFBPc1ZrdU44?=
 =?utf-8?B?K2pCZ0FibXJpaFg0S1JKcTU5M2xodXF6VUpxOHU3eTJpZ2xQeDlpbFpaYUsz?=
 =?utf-8?B?czZEQlQzeWhaSDBUNVRNRHB5VklaWUtoaTY0Uno2VFJvbkdraUcrQWFzbGlX?=
 =?utf-8?B?bTZBTjRaSVFRUWJlZExPSTdONnU5SUlxVk16cTRrVzdaeFdGMmJ2SDhYL3Fa?=
 =?utf-8?B?SkFJRklUeGFCZVpzYlBVTGFqcjcyNEZMa2tDV24wdzhtUTdvZkEzWGRheHVm?=
 =?utf-8?Q?Zr/YSyglX22Y4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjJhV2hMeHltaUwyWHp0blFva09QNlAwTnNucEdkWm1oZ3BCbmQvMlFnRDhJ?=
 =?utf-8?B?RXZyR2x0OFNpQ2tNQ2FSbGxSUjd1VFo1MnV2OG96YnBLUlVYU1FhaFpuRlFo?=
 =?utf-8?B?Q1BESVpULzhKQ29oNGEwV3BBMThML2VCd2ZtY01uZFRlUWsvWVlzUDQvb2xn?=
 =?utf-8?B?R1hMUCt5NXdpT3kwc2JpTW9hLzlGZDh6UmxBSVFOWHNEOWw2Z3Z1anp6UVVh?=
 =?utf-8?B?Zzlua0tSTnBua0F3N2FxVXAzeXplR2pHclNWUDlQVmQ3NFY4OE5QeVdsOC9k?=
 =?utf-8?B?L3FGczJCVjNITEF1eUVmT3FmWVFha1I3VW5QY3cwZWJJaTh1TzI1N2pkWXJ6?=
 =?utf-8?B?Unh6TElpV3VBMDR5ckJvOERVNEZHVjFHTFdzR3BWcTFId0d6V01ZNXNaWFF2?=
 =?utf-8?B?bHFaN1FiYXJZcEZWMEl5T0VJbi9hbVRRbVZFSzV3bzNiVXdtK0cwZnNlK0RX?=
 =?utf-8?B?cnNmQmQ4bjQ0WjJhOGcrU1Q3Q2Mzbm9PQlZ4ZzBaZFAwM2E0ejNodnJ0ZVE4?=
 =?utf-8?B?djZUK21CaUdOMEppTWcwemxLS1pib1FHZG9kZzNJRSsxVzFQdmVMMTdJTHpL?=
 =?utf-8?B?WnlLdWI0SUJxOGxXNnJkai9EUWpRU2JBa04rcEtOMnZUU0hzRWhoZ1BCZjBE?=
 =?utf-8?B?TFhGZXRsSmpjbGQwQmVOczZVaThScW5Xd3JSRVBiR1JBNXlhVUltYytwODJj?=
 =?utf-8?B?ejhCSjJTME5DanVqN2d0UTJxZDlDcDBZZ2ZnOGd6R3ZvRkxIWFJxNDB0aGtD?=
 =?utf-8?B?N1crbXlvRUJuR2tzOTVIbkR1ZHpDZCtxZ1dJYUZubGM5NWpUSW1raTl2K24y?=
 =?utf-8?B?b1E4Rk50SEpzS2lyRTdMSHJJS3ZKVUJSRytvR0gzZW45RWw2REdpMUtKbFhm?=
 =?utf-8?B?ZCs5OTMvcDRnRGJOMFdZSm5zcTlhaHNOeE40U3JmQ2REc3FpbUNNRzdBNm5o?=
 =?utf-8?B?R2pIZXhwTGpMbFRLOTJmZ1BldHFuQXFFek0zajlHTzhpNGRZWVZHR2IzdjdD?=
 =?utf-8?B?YmY4dmVxelZESmpxR2hXVEhJZTczaElmdUI3bXpsbE1aRDQvOWxZaXZjcUls?=
 =?utf-8?B?R2tMcm5YeTFHZ3JpVjRrMFBxdlJSUFhMVitkV3hXZklOWHlldkMxRU1OUTFw?=
 =?utf-8?B?U0dRRjVYbURnTkVucU1wK3ZYdTVBNWE1cENNSU1qeXZCYmJrQzBvSFJzRjlF?=
 =?utf-8?B?RzJzSGNVMGtPamYwcWkzMmRCY3dBamw1dGI4SkZpMGZRNHhHQ0VKVDZNSkZy?=
 =?utf-8?B?RExCSmdJL0o4bTU1WitxWDhBVy9MaTZWeU1VbnFFbS9Vem9NUXBRdUVwM05Q?=
 =?utf-8?B?SGxrdG1GUjdycTRwbk9Xdm1TSjY4MFQ4dVk5Vi9rSjJUVmpYZ2pid2U2aTlS?=
 =?utf-8?B?NnJuSjd2bnRQejlVV1AwT2hNRDk0Zk1qdFg5RUE3NHpMVC85aHZBaVF5NlZQ?=
 =?utf-8?B?OG9HcmovY3NTZ1QrKzd1NkdHWnZ0TXFNUVljb3RpbVc3ZFBNZU9zdVJiRW92?=
 =?utf-8?B?TWU2cVl2SmVnMXRaZ2E0VkJDR2RZVzdKUDQ3aUdpeVFMemZaMHlIUFJ2YkVi?=
 =?utf-8?B?ZlJPQmtzNWJWbjRZeDVEZGc0bWpsMTY3TGRSYnRNdVd1YW9LbTl1M3dmY1Y3?=
 =?utf-8?B?QnZzbEJ6VDlNdjE0OVlHT2p1NUJjdUd5cCtZOWwwOVNnM2lLUHNJd1VLQTU0?=
 =?utf-8?B?dGh4cGhmbDY4WWdjWFNjWERkWUVJKzUyYjN3aDZGRGNhUE9qMlR3YW5pbzRz?=
 =?utf-8?B?ZDVYT1gra3c1bGpxVm12MTNBc2xJdTBuWUpTY1IyTEF5cDdyalNRcTdFMi9m?=
 =?utf-8?B?TGNyTjAzSERMazltYzBBcTNCS3V0eld0SnNYOGFtSVBkNXhHTUQrMUJqcXRW?=
 =?utf-8?B?eFBpYS9hRTBiMnNTWG0zUnJkQy9wckg4TEp1b2xiOXBDSitVTUI3bzQ3SGZh?=
 =?utf-8?B?cUtNSXNvdVdsTnF6MU0vRWNCRlhiTEswdHQ5eFVtMGo1ZS9oL0pjeHVZVTY2?=
 =?utf-8?B?T1M2MlN6TzBhN0tTekZvY1JXY3FUUDFkU2hFU1RmM3BJZWpXNlZiYUgweVdE?=
 =?utf-8?B?ODVYVnNxZVRHcGxQS1lGd3lZY2FLeUUzdXpWZFl5RWNRYUc5UDZRd2FYc3h2?=
 =?utf-8?Q?XN0p+4PRI3Jj0aJWbyle6w/MP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b0ce19-71e7-4af8-e3f4-08dccc4179ad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 17:54:36.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QrcW9yGFKXUabxx/emDb2aLnLXD3VN3OP0jcde/vSmKGWur3gJDdppXVaxsehdG1Wyqa0mlyscGNuLnndCAPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Hi Morgan,

Can you please cross reference 6.11-rc6 to see if you're still having a 
problem?  I would like to understand if we're missing a backport to 
stable or this is still an upstream problem.

Thanks,

On 9/3/2024 12:51, Jones, Morgan wrote:
> Hi there,
> 
> We are experiencing a ~35% performance regression on an AMD EPYC 7702 64 core machine after applying this patch. We observed Linux 6.6.44 starting to cause the issue, and performed a bisect involving rebooting the machine over 15 times. (Note that kexec didn't successfully identify the problem, since the PM memory mailbox is never reset).
> 
> It appears that we are getting a max of 2.18 GHz when this CPU can boost to 3.35 GHz, explaining the slowdown. Blacklisting amd-pstate solves the issue at the expense of the performance increase we used to get by using it.
> 
> Is it possible that the upper limits were implicitly at the max CPU power before, and setting the upper limit to something other than the boost frequency can reduce performance now?
> 
> # bad: [7213910600667c51c978e577bf5454d3f7b313b7] Linux 6.6.44
> # good: [58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9] Linux 6.6.43
> git bisect start '7213910600667c51c978e577bf5454d3f7b313b7' '58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9'
> # good: [72ff9d26964a3a80f7650df719df139f5c1f965d] arm64: dts: qcom: sm6350: Add missing qcom,non-secure-domain property
> git bisect good 72ff9d26964a3a80f7650df719df139f5c1f965d
> # good: [0fffc2e1bf40a2220ef5a38f834ea063dba832d3] ARM: dts: sunxi: remove duplicated entries in makefile
> git bisect good 0fffc2e1bf40a2220ef5a38f834ea063dba832d3
> # bad: [8cdbe6ebfd1763a5c41a2a3058497c0a9163311c] pinctrl: renesas: r8a779g0: Fix CANFD5 suffix
> git bisect bad 8cdbe6ebfd1763a5c41a2a3058497c0a9163311c
> # bad: [5dbb98e7fa42bebc1325899193d8f13f0705a148] drm/mediatek: Turn off the layers with zero width or height
> git bisect bad 5dbb98e7fa42bebc1325899193d8f13f0705a148
> # bad: [691ec7043122c9c8c46d84f6e6cd85d13d50cd93] selftests/bpf: Null checks for links in bpf_tcp_ca
> git bisect bad 691ec7043122c9c8c46d84f6e6cd85d13d50cd93
> # bad: [a1359e085d75d7393a250054e66c0a7bc6c3dbfa] perf/x86: Serialize set_attr_rdpmc()
> git bisect bad a1359e085d75d7393a250054e66c0a7bc6c3dbfa
> # bad: [e99d9b16ff153de9540073239d24adc3b0a3a997] wifi: ath12k: change DMA direction while mapping reinjected packets
> git bisect bad e99d9b16ff153de9540073239d24adc3b0a3a997
> # bad: [d027ac4a08541beb2a89563d3e034da7085050ba] firmware: turris-mox-rwtm: Initialize completion before mailbox
> git bisect bad d027ac4a08541beb2a89563d3e034da7085050ba
> # bad: [e6c9eca327e6a41a81e7eba0d0ddc13da37f82a1] ARM: spitz: fix GPIO assignment for backlight
> git bisect bad e6c9eca327e6a41a81e7eba0d0ddc13da37f82a1
> # bad: [b8cdefdaa555bbfc269c2198803f8791a8923960] m68k: cmpxchg: Fix return value for default case in __arch_xchg()
> git bisect bad b8cdefdaa555bbfc269c2198803f8791a8923960
> # bad: [13a71384ae6a8779da809b00c6f378dcead10427] cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory CPPC systems
> git bisect bad 13a71384ae6a8779da809b00c6f378dcead10427
> # first bad commit: [13a71384ae6a8779da809b00c6f378dcead10427] cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory CPPC systems
> 
> cpupower output:
> 
> analyzing CPU 47:
>    driver: amd-pstate-epp
>    CPUs which run at the same hardware frequency: 47
>    CPUs which need to have their frequency coordinated by software: 47
>    maximum transition latency:  Cannot determine or is not supported.
>    hardware limits: 400 MHz - 2.18 GHz
>    available cpufreq governors: performance powersave
>    current policy: frequency should be within 400 MHz and 2.18 GHz.
>                    The governor "performance" may decide which speed to use
>                    within this range.
>    current CPU frequency: Unable to call hardware
>    current CPU frequency: 2.17 GHz (asserted by call to kernel)
>    boost state support:
>      Supported: yes
>      Active: yes
>      AMD PSTATE Highest Performance: 166. Maximum Frequency: 2.18 GHz.
>      AMD PSTATE Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>      AMD PSTATE Lowest Non-linear Performance: 115. Lowest Non-linear Frequency: 1.51 GHz.
>      AMD PSTATE Lowest Performance: 31. Lowest Frequency: 400 MHz.
> 
> Thanks,
> Morgan
> 
> -----Original Message-----
> From: Mario Limonciello <mario.limonciello@amd.com>
> Sent: Tuesday, July 2, 2024 10:49 AM
> To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org; viresh.kumar@linaro.org; gautham.shenoy@amd.com; perry.yuan@amd.com; skhan@linuxfoundation.org; li.meng@amd.com; ray.huang@amd.com
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David Arcari <darcari@redhat.com>
> Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory CPPC systems
> 
> On 7/2/2024 3:14, Dhananjay Ugwekar wrote:
>> On shared memory CPPC systems, with amd_pstate=active mode, the change
>> in scaling_max_freq doesn't get written to the shared memory region.
>> Due to this, the writes to the scaling_max_freq sysfs file don't take
>> effect. Fix this by propagating the scaling_max_freq changes to the
>> shared memory region.
>>
>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP
>> support for the AMD processors")
>> Reported-by: David Arcari <darcari@redhat.com>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>    drivers/cpufreq/amd-pstate.c | 43 +++++++++++++++++++-----------------
>>    1 file changed, 23 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c
>> b/drivers/cpufreq/amd-pstate.c index 9ad62dbe8bfb..a092b13ffbc2 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -247,6 +247,26 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
>>    	return index;
>>    }
>>    
>> +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>> +			       u32 des_perf, u32 max_perf, bool fast_switch) {
>> +	if (fast_switch)
>> +		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>> +	else
>> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>> +			      READ_ONCE(cpudata->cppc_req_cached));
>> +}
>> +
>> +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>> +
>> +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>> +					  u32 min_perf, u32 des_perf,
>> +					  u32 max_perf, bool fast_switch) {
>> +	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>> +					    max_perf, fast_switch);
>> +}
>> +
>>    static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>>    {
>>    	int ret;
>> @@ -263,6 +283,9 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>>    		if (!ret)
>>    			cpudata->epp_cached = epp;
>>    	} else {
>> +		amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>> +					     cpudata->max_limit_perf, false);
>> +
>>    		perf_ctrls.energy_perf = epp;
>>    		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>>    		if (ret) {
>> @@ -452,16 +475,6 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>>    	return static_call(amd_pstate_init_perf)(cpudata);
>>    }
>>    
>> -static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>> -			       u32 des_perf, u32 max_perf, bool fast_switch)
>> -{
>> -	if (fast_switch)
>> -		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>> -	else
>> -		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>> -			      READ_ONCE(cpudata->cppc_req_cached));
>> -}
>> -
>>    static void cppc_update_perf(struct amd_cpudata *cpudata,
>>    			     u32 min_perf, u32 des_perf,
>>    			     u32 max_perf, bool fast_switch) @@ -475,16 +488,6 @@ static
>> void cppc_update_perf(struct amd_cpudata *cpudata,
>>    	cppc_set_perf(cpudata->cpu, &perf_ctrls);
>>    }
>>    
>> -DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>> -
>> -static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>> -					  u32 min_perf, u32 des_perf,
>> -					  u32 max_perf, bool fast_switch)
>> -{
>> -	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>> -					    max_perf, fast_switch);
>> -}
>> -
>>    static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>>    {
>>    	u64 aperf, mperf, tsc;
> 
> 


