Return-Path: <linux-pm+bounces-15632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE03C99D7E8
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 22:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F76C280E8B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 20:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8F1CF7AB;
	Mon, 14 Oct 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B/u2Xf0C"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7F1CC8B9;
	Mon, 14 Oct 2024 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936567; cv=fail; b=t5aSwMzXZ+dQInQwfTC2+e7yhGbkTWBJRvPlPQwvY0IiVhVnNNc0Nb/HbgOgkl3ss+5U0RMywUp1255w/j29UCdDm4ovzTpGDazlJLwqee4Ss0pxBX5W5bmePzWN5kyhRKigwliMjBm/87fxnKLyhxAZOuj6DQfvnSl6HjldBhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936567; c=relaxed/simple;
	bh=d4oHSmqRY6ZAdfp0JHZdOOhocQGDc5FtelLSS3QAqN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aQifStRmpXJq9nVQclh2AK1Q4mFWxp6Lf6L28MKddXIAPUGzwf3/MYLbBH6/Z8lPmurRS5ZVVn7O8vKC5rIyEbW+LnSAW9UuT4PBD3mqVDbG1JrPdBOsJH4nQOXRh9MXABe17zqbVS0djE9cdV59lXk/59FYQ4Fro2+1pyBMIAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B/u2Xf0C; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7EWIqYsjWKgYbruHEEBGX1lw82mI2SxHstcfke/YlwV/XTidFUJTjHiL/0PsI1sBb88jtYxlog/OTi1G8m0D3gZD79xlPUcl+1I1RnFnJOCS8hqp1VC2lNW0HKK9zJyXVSQUn8tQKo9SsITWhMh/h3SaaRNRPFQbdQI2dtjcMou4Y48mZ81WHpxAGnOdLq0RlmQEF9O+hK1REXhYIIv4x4A2eJd+4zNTGz2F9Iff4Pl1e2spRHIH9fWa2WEWY7XQfPaMMc6/xQO8W9geEqBwiRExTDQMXyZlQXzUh6iHb+YyW5f8raOE0d9hg5b/MiO6/rOnns/s0gLJhnOphigdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ouDWrAgEk0djlzGRSA8v/kZPqq2MiBcBnfwG07xu7c=;
 b=joz+CUsgEGRnU7Y5QvNf+kFsoW4yXjtY4OVfy+fRT75gfiXXl+ODzIjqDBpAK+r4WPHueIC9FyQbNXz2QurM4y75SuZ6w9ofW5uTehAyUBX37dg9qCTDJ0DIt43XmBT4TAMSfYoQMvUzMrftmC4IlPinCPOEegokkrxStGWYPvvUtqRrxnEyTsxv56wF4+cJSTKolh1zrscjYjl28ISzffqBEX90Bx6f+YIzEJmldJ0kKo/kgiF9QWaJZhNgQVp5EbwC4+OmvMZ3gQ6M2xUA+WHRZNMB7gvKvcCLmPcVEvOYOR0PFnbHU+8d11xMM6bvICT83YRugVvj61ROZTtz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ouDWrAgEk0djlzGRSA8v/kZPqq2MiBcBnfwG07xu7c=;
 b=B/u2Xf0C1KkGlg8IhtxqbS1ls+4X3AhRZ+9Q1c2aF1DRQTem02SeRaimjWOtQcNuud9s5kgVk6NvNKR8KdyjWhUAxdyrsGyG9a0Qv5SKZg7mLZuIUmwAugmwITWFn+2vhpxdiWpwISSPm6ICFWai7mPIVEohLJ3zfa1D5MmPjSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:09:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 20:09:18 +0000
Message-ID: <c652d77b-9b5d-475e-92c5-435941fa206e@amd.com>
Date: Mon, 14 Oct 2024 15:09:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] platform/x86: hfi: parse CPU core ranking data
 from shared memory
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-7-mario.limonciello@amd.com>
 <21e35bbf-a7d7-2b6b-60bf-e4eeceeb9bd3@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <21e35bbf-a7d7-2b6b-60bf-e4eeceeb9bd3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:806:f3::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b122e69-2203-4e7e-7791-08dcec8c15da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU9QbmpWTFg0MjYyL2pJaHVvZ011ajlFZTZlWGc2WjZhWnFKbXVrYXZha2ZZ?=
 =?utf-8?B?NmJrZ09QTHdEaTZhU1RqUVNGMGlUaVJZSDU0Qzl1Nmh4elA3bHJKRHhvYzY3?=
 =?utf-8?B?S2kyMG9OSGxDeE5TdE1aZVV6RW9lT01ZeTZWaGdvSUQxdThhc2VmUkY3TUd0?=
 =?utf-8?B?cnU2UXAzWnhBbG9kbk5idkttV1ZrV1BkN1RTb08zMThzb1REMnFNaUxLNktH?=
 =?utf-8?B?dFljbDhKWFRFSVljV2o2akpGZXVXTHMvbU1uam5ITmV2VXAvV2ErV2l6OW16?=
 =?utf-8?B?Q0oxb05sSDd2ZkxXak1vTlprRjZybFB1RE9ER3ZmdFFYYjJ0c0RCQVhTU09w?=
 =?utf-8?B?Z0hPS3pUeE5lWDh5OVlzNlE4amx0cXNlUmw2UWlRRmRoYVZTeGtQM2JFdjJh?=
 =?utf-8?B?aFk4b2RJWnVYYkF4QmppZ2JtSWg0NnVCeXNwL21lSWI4NnRSVXl5WTY5ZnlH?=
 =?utf-8?B?UUxEM2xHcjhGT2JvSVZXT0tyVTRTQllMZWZwY2dWcGVXQmVyaDBUMUVkQ0Ja?=
 =?utf-8?B?eXVZM1B4M1dZSXNiN0d0T05ReVZNeWhObjV5dkVkMVcwVGZXVCtuWjJQRW52?=
 =?utf-8?B?R0FCeDdvcGNINnZwcXBSTC9yTlhaZm1ZTjVSS1QxNXJzU0Q3SmUxVjgySzFa?=
 =?utf-8?B?YXdodTdPOGcvRUI5OWNjWFFBeis5NGNyZDV6c0FmczJuTlhlc0tQMFpDWGtH?=
 =?utf-8?B?UGVmeVhUbEdtcWhoVDFlRnloV29QUFFHNWpWRjFCRFRqeWZ1TitOdXBWQlpR?=
 =?utf-8?B?UWJaMVEwUzJZOUxtc3ZucGhQcTZmSVpWSDNYZnNMNXdmRXQ0eEFXVW90dURE?=
 =?utf-8?B?UEtENkROM3l4VnRnNm03Y1didGltdEdadHFOZllYbWQ4VDQ4OFJDaS9naE01?=
 =?utf-8?B?TlA5V3g2TDhocjJlekF1ZUh4SEtvNDFrN2hUWUE0OEhqWW1vYlVGYWxpbVls?=
 =?utf-8?B?Q3JoelZuUGUwWHZ0Ti9LbVlJbjlQM1NsWHF5cVNzM2RpV3h0MGhENDZOWTZR?=
 =?utf-8?B?Y1pKZCtKUS9JQlY1OFAzNm1YYTdFNXpuOXVpOTF1UkR5VkdzWVltUjg5bm1z?=
 =?utf-8?B?djYrbk1LWjlnOWk3eDcybGpDL0V3K1FqY0lsZk1yWXVFMk11RkFpMUczVGtR?=
 =?utf-8?B?OTdYT0pqd1QzcnBEcUNzY1lIUlBLTnZ3c3NvVnhKaTRZeWg2bG5JU3lsWUJH?=
 =?utf-8?B?RUlmbzNhcFF1REpkWFRDWkpJNVJOMnp0TFJCQ3h5STRTZ2pJQzVLbVdsUnpo?=
 =?utf-8?B?YkZsL2dPL3ovUUtWM2ZFMzk5NitoNGp3T2MyblJDMmZzSEpOcWlLVnZuSDZF?=
 =?utf-8?B?ZlNNNVVBR3diTWFpcEk5aFdwRDJONk9Xc0U4UzhvcldWR25RdDdBSTNqMnBy?=
 =?utf-8?B?dzg0L1hyS0JLVEVUdEsxQk1qUWVDMDQ4Zlg5aHMrcUtGU2hCUlpQa1FNMHBz?=
 =?utf-8?B?dWVpNkU0UjdwRkxPMFkzYWdNSkc5YzFmTTFiOEtLRlhZNnd3eHVxVXBHSE10?=
 =?utf-8?B?QXl0MWtqUnJpR2lrdEgzdnJ3RmVwZEVsdGt2V1pCaTVQejRTSXZ4YXhEQW5S?=
 =?utf-8?B?Y0hyRHdCWVhIcHR1bmdSbmgrVFhYc3J6b3N1aE5odGYzZDlHakhzc3JBOXNG?=
 =?utf-8?B?aDZVd3NuNU91NG1ReEJBV1pRQk9jVUw5YXJrRWpmeHZzV09nVFFPT0NEZlI2?=
 =?utf-8?B?ZzBkVE1BSWdkb0svNGpQVzB4Q0dTLzRsOXVKZ2N2aElBYUZYSmNFR1pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bndOQjFkRXBjRUdNektIQnBiT244K0hsZzVGS0hjMUM0ZTdWcHdVM2REZ0VY?=
 =?utf-8?B?QmFWcEZYM0Z1alU2cFd0d2tndXY2RjNkUWJvVFdYb3VQdlRUOUhNNytueWhY?=
 =?utf-8?B?SW1ScktXOEQwQ1g0RnZleWk0Z3lTeUtmODNKZUtiWkhFV2dDemZOUkZQMGxq?=
 =?utf-8?B?ZkRBdjhSN25rOVN6Vnk0NEMrbUdqbmw0L1JKQnM3VEZkazRkb1M2ZHJUOUdQ?=
 =?utf-8?B?RG10cS8vYTE5UVVQdUJyVFo0RTV4MFF0eTJ2R0g1UGxkaUN0M21XVmZYZ0J6?=
 =?utf-8?B?TW9GU3FOZkJMUjEwRE5iTW52SEZRclZZeDZLSkc3bU9yMUhVaThhS2RsMzJL?=
 =?utf-8?B?T0ZtV2F2QlBLS2MxTC9sVHcxYkllN0UwcEcrMW1tOTdVeEw2SUJhMFViTlQ4?=
 =?utf-8?B?YUpnSVNoMjNOWXgyV2ZFb0NueWExMVZrajJRb1QwaG5tZU5qeTNPRnVXbERT?=
 =?utf-8?B?alFZYnUydWpoRE50SmxyTXFGelFUM1k3SzA3UnlXZ0tCZDMyMjROajQxZUR2?=
 =?utf-8?B?ZDNybzAxQmRvL2JqcXFHclNXckVxTVFlME80RFF1M2tlUUZlbHRwNDlFRGo0?=
 =?utf-8?B?NVJKajZjdWM0L24zcnhHRTRHMC9OYldiVGtRZjJtWFhLLytiL1JjSUZDMU1r?=
 =?utf-8?B?NUlkdU5tZ3ZiR1hWQTJ5WksySmJLTzJ1bkJQUTA3N1BzcFZtRzhtWjM0d3pL?=
 =?utf-8?B?MDkweU4zc29tai91T1U4cGxnbmJDRFdPK3E1Tys1NzF1T0FGcExWejl3MW5s?=
 =?utf-8?B?WTd1cHd0RUdQR01nd1FzYUZxc1ltakRPdmozcFk5cHFUN1ZwcGF5UjNkekZm?=
 =?utf-8?B?TUFLZlhqMlltZGxRclNpb1dkdVVac1I3MEZjdWVKS05yb0ROQitheGNZZ0po?=
 =?utf-8?B?MlN3SmVCYy85TU84UXVFYWlQVGw5Z1Q3ZlEvV24zZ0gySDNZWGMxcUlXVTE1?=
 =?utf-8?B?RkphaDZLOUJ2d2MyN3VxSUtZMU9oTGROWmZDVWVaTUovS1Mrc1RwNDBueXBy?=
 =?utf-8?B?eXhoNy9uSzltdFovSitySGorSlNzSUpkaGFLNVV1MTZPNUhhUWFyWUwwNk1F?=
 =?utf-8?B?bXh0Y1dDT0drV1Jpa0czdW9HT3BSZDZZMTRCdDFhM3kzc0lsM3dRK3BBdkhT?=
 =?utf-8?B?clFwVVIrRU5hVVUreWROdGdoUTZ6NnoyclJqc29jNEVsdG9IQk4wanFhOWxD?=
 =?utf-8?B?OHNOcWNXbjZ3aHF3TnlGOC9GczBZSXM4WTZYaEdleXp5TTlnUTFsdTA5a0JC?=
 =?utf-8?B?azFRSmNqdE1TcmFZaTRRQ1ZvZVJVcFZvcGtMYmR3YUF6L2swZnpvY2s5NGU3?=
 =?utf-8?B?bDAwS2h2KzFLdGhlNk5FUzlNOGdpdDk5UytnNzl5MjdLNGpuckRsdTBVR05I?=
 =?utf-8?B?eXoyZnNMREQwdHR6OXVDTmZXY1N1Y1BmVXdyZU0yejlSMzYrbUF3TVRXSlRD?=
 =?utf-8?B?ZmZ6cFErWnRvWVRVbkFnVU85R0hNRmZaT2tEUm9BUDJmQWlhbU1XOEd0cWRS?=
 =?utf-8?B?eU5DNy95M2MwZlY2WHU1c2xaM01Fc1Q0MXFwMXExT1BSd1grNDNDZ1RFZGFs?=
 =?utf-8?B?akgvNkQwdy9LS3JuNXdVNlh4M0h3cU9xdExaay96Z0FNOCtnblZJMVJBSTZx?=
 =?utf-8?B?Q0tqUDhJRXExT250SEtQSXAwOFFVMDFlbHZxVWp5Qk05R0lYdThBL3ZjNHNH?=
 =?utf-8?B?ZXFKWWhNVUhJck5rOUU5NTVBOU5IL2wvck5jdEFhOXp6b2IxYndRaFlxalkv?=
 =?utf-8?B?S05UbHA2QlRQcVpqRnA0RVFqaGtKVHZ2NkE1T1h4dVV2VnNtaEp1d2swTWUx?=
 =?utf-8?B?MlB6Tzlhc09YaVpNRTNCM1NTZjVHaTZXVnBEVTNkaHNtWXIrUXpYYWRDOXRh?=
 =?utf-8?B?a3I3RUxOQW9TQzRqbW1wRS9QVytGdTZYK3YwT0xyazZVNWE3czNCVWJZWnVo?=
 =?utf-8?B?UGtGWSt6NnlJNThmQ3hrNG5QT0NiVERHYXBNUWhkNEk5OEVld1hJZmdUZU5B?=
 =?utf-8?B?cHhrM3MzbWJzd3RTVzh1cUNGTXZ5aE4xNS9pNy9oRW1sU0tqdVFpeHpIUnAy?=
 =?utf-8?B?V0p2S1BzZ2pFMHU3NzRZTGJFZXdBQ1hsQzdjQlFYdlYxUEtOUXMyQjhlOXYx?=
 =?utf-8?Q?f8N/alvr+35FWXJSIbxZEwNw4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b122e69-2203-4e7e-7791-08dcec8c15da
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:09:18.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM+/bOHzMdAvocNMnz9h3wKSN7Q5NVHgn+81yYHN1XidcmEjL8Z7zdP5rhD5aUULfZsLsAobhwyTPilb03gw0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

On 10/14/2024 05:14, Ilpo Järvinen wrote:
> On Thu, 10 Oct 2024, Mario Limonciello wrote:
> 
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> When `amd_hfi` driver is loaded, it will use PCCT subspace type 4 table
>> to retrieve the shared memory address which contains the CPU core ranking
>> table. This table includes a header that specifies the number of ranking
>> data entries to be parsed and rank each CPU core with the Performance and
>> Energy Efficiency capability as implemented by the CPU power management
>> firmware.
>>
>> Once the table has been parsed, each CPU is assigned a ranking score
>> within its class. Subsequently, when the scheduler selects cores, it
>> chooses from the ranking list based on the assigned scores in each class,
>> thereby ensuring the optimal selection of CPU cores according to their
>> predefined classifications and priorities.
>>
>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Rework amd_hfi_fill_metatadata to directly use structure instead of
>>     pointer math.
>> ---
>>   drivers/platform/x86/amd/hfi/hfi.c | 215 ++++++++++++++++++++++++++++-
>>   1 file changed, 212 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
>> index da2e667107e8..10651399cf75 100644
>> --- a/drivers/platform/x86/amd/hfi/hfi.c
>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>> @@ -18,22 +18,78 @@
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/mailbox_client.h>
>>   #include <linux/mutex.h>
>> +#include <linux/percpu-defs.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/printk.h>
>>   #include <linux/smp.h>
>>   #include <linux/string.h>
>> +#include <linux/topology.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include <asm/cpu_device_id.h>
>> +
>> +#include <acpi/pcc.h>
>> +#include <acpi/cppc_acpi.h>
>>   
>>   #define AMD_HFI_DRIVER		"amd_hfi"
>> +#define AMD_HFI_MAILBOX_COUNT	1
>> +#define AMD_HETERO_RANKING_TABLE_VER	2
>> +
>>   #define AMD_HETERO_CPUID_27	0x80000027
>> +
>>   static struct platform_device *device;
>>   
>> +/**
>> + * struct amd_shmem_info - Shared memory table for AMD HFI
>> + *
>> + * @signature:	The PCC signature. The signature of a subspace is computed by
>> + *		a bitwise of the value 0x50434300 with the subspace ID.
>> + * @flags:	Notify on completion
>> + * @length:	Length of payload being transmitted including command field
>> + * @command:	Command being sent over the subspace
>> + * @version_number:		Version number of the table
>> + * @n_logical_processors:	Number of logical processors
>> + * @n_capabilities:		Number of ranking dimensions (performance, efficiency, etc)
>> + * @table_update_context:	Command being sent over the subspace
>> + * @n_bitmaps:			Number of 32-bit bitmaps to enumerate all the APIC IDs
>> + *				This is based on the maximum APIC ID enumerated in the system
>> + * @reserved:			24 bit spare
>> + * @table_data:			Bit Map(s) of enabled logical processors
>> + *				Followed by the ranking data for each logical processor
>> + */
>> +struct amd_shmem_info {
>> +	struct acpi_pcct_ext_pcc_shared_memory header;
>> +	u32	version_number		:8,
>> +		n_logical_processors	:8,
>> +		n_capabilities		:8,
>> +		table_update_context	:8;
>> +	u32	n_bitmaps		:8,
>> +		reserved		:24;
>> +	u32	table_data[];
>> +} __packed;
>> +
>>   struct amd_hfi_data {
>>   	const char	*name;
>>   	struct device	*dev;
>>   	struct mutex	lock;
>> +
>> +	/* PCCT table related*/
>> +	struct pcc_mbox_chan	*pcc_chan;
>> +	void __iomem		*pcc_comm_addr;
>> +	struct acpi_subtable_header	*pcct_entry;
>> +	struct amd_shmem_info	*shmem;
>>   };
>>   
>> +/**
>> + * struct amd_hfi_classes - HFI class capabilities per CPU
>> + * @perf:	Performance capability
>> + * @eff:	Power efficiency capability
>> + *
>> + * Capabilities of a logical processor in the ranking table. These capabilities
>> + * are unitless and specific to each HFI class.
>> + */
>>   struct amd_hfi_classes {
>>   	u32	perf;
>>   	u32	eff;
>> @@ -42,23 +98,105 @@ struct amd_hfi_classes {
>>   /**
>>    * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>>    * @cpu:		cpu index
>> + * @apic_id:		apic id of the current cpu
>>    * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
>>    * @class_index:	workload class ID index
>>    * @nr_class:		max number of workload class supported
>> + * @ipcc_scores:	ipcc scores for each class
>>    * @amd_hfi_classes:	current cpu workload class ranking data
>>    *
>>    * Parameters of a logical processor linked with hardware feedback class
>>    */
>>   struct amd_hfi_cpuinfo {
>>   	int		cpu;
>> +	u32		apic_id;
>>   	cpumask_var_t	cpus;
>>   	s16		class_index;
>>   	u8		nr_class;
>> +	int		*ipcc_scores;
>>   	struct amd_hfi_classes	*amd_hfi_classes;
>>   };
>>   
>>   static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>>   
>> +static int find_cpu_index_by_apicid(unsigned int target_apicid)
>> +{
>> +	int cpu_index;
>> +
>> +	for_each_possible_cpu(cpu_index) {
>> +		struct cpuinfo_x86 *info = &cpu_data(cpu_index);
>> +
>> +		if (info->topo.apicid == target_apicid) {
>> +			pr_debug("match APIC id %d for CPU index: %d",
> 
> Missing \n
Ack
> 
>> +				 info->topo.apicid, cpu_index);
>> +			return cpu_index;
>> +		}
>> +	}
>> +
>> +	return -ENODEV;
>> +}
>> +
>> +static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
>> +{
>> +	struct acpi_pcct_ext_pcc_slave *pcct_ext =
>> +		(struct acpi_pcct_ext_pcc_slave *)amd_hfi_data->pcct_entry;
>> +	void __iomem *pcc_comm_addr;
>> +
>> +	pcc_comm_addr = acpi_os_ioremap(amd_hfi_data->pcc_chan->shmem_base_addr,
>> +					amd_hfi_data->pcc_chan->shmem_size);
>> +	if (!pcc_comm_addr) {
>> +		pr_err("failed to ioremap PCC common region mem\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	memcpy_fromio(amd_hfi_data->shmem, pcc_comm_addr, pcct_ext->length);
>> +	iounmap(pcc_comm_addr);
>> +
>> +	if (amd_hfi_data->shmem->header.signature != PCC_SIGNATURE) {
>> +		pr_err("Invalid signature in shared memory\n");
>> +		return -EINVAL;
>> +	}
>> +	if (amd_hfi_data->shmem->version_number != AMD_HETERO_RANKING_TABLE_VER) {
>> +		pr_err("Invalid veresion %d\n", amd_hfi_data->shmem->version_number);
> 
> version
Ack
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (u32 i = 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
>> +		u32 bitmap = amd_hfi_data->shmem->table_data[i];
>> +
>> +		for (u32 j = 0; j < BITS_PER_TYPE(u32); j++) {
> 
> Are these u32 really the types you want to use for the loop vars, why?

I was going off the type of amd_hfi_data->shmem->n_bitmaps which is u32.
In practice I think an unsigned int should be fine though too.

> 
>> +			struct amd_hfi_cpuinfo *info;
>> +			int apic_id = i * BITS_PER_TYPE(u32) + j;
>> +			int cpu_index;
>> +
>> +			if (!(bitmap & BIT(j)))
>> +				continue;
>> +
>> +			cpu_index = find_cpu_index_by_apicid(apic_id);
>> +			if (cpu_index < 0) {
>> +				pr_warn("APIC ID %d not found\n", apic_id);
>> +				continue;
>> +			}
>> +
>> +			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
>> +			info->apic_id = apic_id;
>> +
>> +			/* Fill the ranking data for each logical processor */
>> +			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
>> +			for (int k = 0; k < info->nr_class; k++) {
> 
> unsigned int
> 
>> +				u32 *table = amd_hfi_data->shmem->table_data +
>> +					     amd_hfi_data->shmem->n_bitmaps +
>> +					     i * info->nr_class;
>> +
>> +				info->amd_hfi_classes[k].eff = table[apic_id + 2 * k];
>> +				info->amd_hfi_classes[k].perf = table[apic_id + 2 * k + 1];
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>>   {
>>   	struct amd_hfi_cpuinfo *hfi_cpuinfo;
>> @@ -68,8 +206,7 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>>   
>>   	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
>>   	if (nr_class_id < 0 || nr_class_id > 255) {
>> -		dev_warn(dev, "failed to get supported class number from CPUID %d\n",
>> -				AMD_HETERO_CPUID_27);
>> +		dev_warn(dev, "failed to get number of supported classes\n");
> 
> This message was added in the previous patch and now immediately changed.

Will drop this change.

> 
>>   		return -EINVAL;
>>   	}
>>   
>> @@ -79,7 +216,10 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>>   				sizeof(struct amd_hfi_classes), GFP_KERNEL);
>>   		if (!hfi_cpuinfo->amd_hfi_classes)
>>   			return -ENOMEM;
>> -
>> +		hfi_cpuinfo->ipcc_scores = devm_kcalloc(dev, nr_class_id,
>> +							sizeof(int), GFP_KERNEL);
>> +		if (!hfi_cpuinfo->ipcc_scores)
>> +			return -ENOMEM;
>>   		hfi_cpuinfo->nr_class = nr_class_id;
>>   	}
>>   
>> @@ -93,6 +233,70 @@ static void amd_hfi_remove(struct platform_device *pdev)
>>   	mutex_destroy(&dev->lock);
>>   }
>>   
>> +static int amd_hfi_metadata_parser(struct platform_device *pdev,
>> +				   struct amd_hfi_data *amd_hfi_data)
>> +{
>> +	struct acpi_pcct_ext_pcc_slave *pcct_ext;
>> +	struct acpi_subtable_header *pcct_entry;
>> +	struct mbox_chan *pcc_mbox_channels;
>> +	struct acpi_table_header *pcct_tbl;
>> +	struct pcc_mbox_chan *pcc_chan;
>> +	acpi_status status;
>> +	int ret;
>> +
>> +	pcc_mbox_channels = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
>> +					 sizeof(*pcc_mbox_channels), GFP_KERNEL);
>> +	if (!pcc_mbox_channels) {
>> +		ret = -ENOMEM;
>> +		goto out;
> 
> Please return directly if there is nothing to rollback.
Ack
> 
>> +	}
>> +
>> +	pcc_chan = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
>> +				sizeof(*pcc_chan), GFP_KERNEL);
>> +	if (!pcc_chan) {
>> +		ret = -ENOMEM;
>> +		goto out;
> 
> Ditto.
> 
>> +	}
>> +
>> +	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
>> +	if (ACPI_FAILURE(status) || !pcct_tbl) {
>> +		ret = -ENODEV;
>> +		goto out;
> 
> Ditto.
> 
>> +	}
>> +
>> +	/* get pointer to the first PCC subspace entry */
>> +	pcct_entry = (struct acpi_subtable_header *) (
>> +			(unsigned long)pcct_tbl + sizeof(struct acpi_table_pcct));
>> +
>> +	pcc_chan->mchan = &pcc_mbox_channels[0];
>> +
>> +	amd_hfi_data->pcc_chan = pcc_chan;
>> +	amd_hfi_data->pcct_entry = pcct_entry;
>> +	pcct_ext = (struct acpi_pcct_ext_pcc_slave *)pcct_entry;
>> +
>> +	if (pcct_ext->length <= 0) {
>> +		ret = -EINVAL;
>> +		goto out;
> 
> Ditto.
> 
>> +	}
>> +
>> +	amd_hfi_data->shmem = devm_kmalloc(amd_hfi_data->dev, pcct_ext->length, GFP_KERNEL);
> 
> Why kmalloc ?
> 
>> +	if (!amd_hfi_data->shmem) {
>> +		ret = -ENOMEM;
>> +		goto out;
> 
> Return directly.
> 
>> +	}
>> +
>> +	pcc_chan->shmem_base_addr = pcct_ext->base_address;
>> +	pcc_chan->shmem_size = pcct_ext->length;
>> +
>> +	/* parse the shared memory info from the pcct table */
>> +	ret = amd_hfi_fill_metadata(amd_hfi_data);
>> +
>> +	acpi_put_table(pcct_tbl);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>>   static const struct acpi_device_id amd_hfi_platform_match[] = {
>>   	{ "AMDI0104", 0},
>>   	{ }
>> @@ -121,6 +325,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto out;
> 
> This should do return ret; directly, not jump to out label which does
> nothing but return.
> 
>>   
>> +	/* parse PCCT table */
>> +	ret = amd_hfi_metadata_parser(pdev, amd_hfi_data);
>> +	if (ret)
>> +		goto out;
>> +
>>   out:
>>   	return ret;
> 
> Might again be there for churn avoidance, otherwise, please consider:
> 
> 	return amd_hfi_metadata_parser(pdev, amd_hfi_data);
> 
> That goto out should again just return ret directly.
> 
>>   }
>>
> 


