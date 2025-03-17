Return-Path: <linux-pm+bounces-24225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9984A66116
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 22:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4183188432F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 21:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E42046AE;
	Mon, 17 Mar 2025 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Lo+O13M"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAF14900F;
	Mon, 17 Mar 2025 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248723; cv=fail; b=GQ3d4IVWSs/olCO0bPYBn1NcX6UB5tl6TeOWj87zFA+5Llshw4KPiEfNMfoo5yL6E9tgz4GADbR4sGnsYTHOL+4AmgJxIGQ45abIYtt3jLzEP3XFfdlzYr3Slw4N23eIQ+DsYdSKbIvJrjQLnYMXgm3VcKs0La24gtvu8s+Vd18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248723; c=relaxed/simple;
	bh=cnjZq0tSlVulpM6717KdvmFpgWZNRm6eHQSRSR97Ebg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MMtkRbeZOBNNC2fna5Dqi7JfzAEQXjkFRHOIuDop5aZdXbqiQj0wwKOcLfb2MxIh4a1VUhTLjMPUKFaOf25V9URhtjuW56phTCffGytWne8R/6P/vKoP3cm1gzUnl0b+8gpoa7TqMEF0TBljESFqjKIdnOKNCZzlX156SGnUzmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Lo+O13M; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idUaAsIs+8w0bFNYi3H8fDO3VboG0bzAvXW3JhPkNiAC8MN0tzV7dc9FHuZsU1VxFlZC3w4jc4mmjkk/V6xRqWxU9Bxm+mn7MuQvnKxMIzWjTGa2HybmbDt3AEQZqSokttJwZdyx3Md4VNlXLUu/YYOR9p1jhTA85NftMAHsCTtbhQn3pcBsA33+PDpfAmRnsCyf7NMxPEACauOjsZ3MgFZb2Ornhw/RKjzOEZkQyTx5QNlRO/bYJ0WuRvJf61+s/9JYsskwC0Paha/TtUouS7jiUC0rRxtJa6ljFtZqtKaLLpMw+zBDzphsH6PAAuEehvWC9KZWGK1cC/sWulvCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbRvtCmLIMn+KWTxjiuHRf2JzHhP4YXm5mUgUBg29EE=;
 b=Zu0qeKh1xopmv+FT+y6uM9yXvdXmesXLtd3B8Y3EXm0D72lUIrmw4wbepFKsxLDjfZ2mqTd+cjk+6tsrCyvFEvkpcKWxiM6syMu9Dsp8k4WEthbz1NbWsBfmAGfGX11MiDQ8EuuCT2vI7p36UuDw15lz5onm3yIquCxhyZWz8JqofdIyAxjBeygXtHDSYEdkUCrLc5GgVN0cpf7aLWQe5/AETtjS95cbsIDAwjE0s+EU8PS1j7GuONKpvnIIzf6fenDdkVIerVneeBVUaUBAl5EJSO/UPSjXK2XteQuNYV7xKL3VTWNfO4oZWNn7S0QKaFInAArxJg8rTt8YWaOQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbRvtCmLIMn+KWTxjiuHRf2JzHhP4YXm5mUgUBg29EE=;
 b=0Lo+O13Miv/7Rha61/ULMBloQFCaJ+bbbYDrcSNUsipcYajfskej6iirveZ8xsDfeDyMGeQxaagUPiCzalPBu7WqlYtQVyd/hZGQay8orzPmiYViPSldacKe/vZBVnnBbXozMilCifjWkp37rBYl1OK6lznN3QiJQop0QkVEOR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 21:58:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:58:39 +0000
Message-ID: <aa0a6b0b-7c2b-4a3e-bc47-81c59e776068@amd.com>
Date: Mon, 17 Mar 2025 16:58:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] ABI: testing: add tt_toggle and tt_led entries
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org,
 sre@kernel.org, linux@weissschuh.net
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-5-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250317155349.1236188-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1f66dc-24ae-450a-a4fb-08dd659ee026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ty9HWStKTWo5eXZIVENIYkxLWGpYemdIOU5BMnVoNjF3Lzd3Vk5wSWo0cXdP?=
 =?utf-8?B?WVVCZzNoOGVkT2VHSFNaSmQ5S1JqUmRoWVc5RWNoZFl2ODVaNngwY3p1dWVJ?=
 =?utf-8?B?KyswWjhwS2E4TlhwUTFRbTEwMWFQK1ZFRkFuR2dvUWZyRkFMcHNWTFhGa3Zp?=
 =?utf-8?B?UExGVWhOOWd6R2VXaE5ML1hEUFVVNVNGQTZFWW9HeVFpQXZRejhSSlBjdUE0?=
 =?utf-8?B?Q21xYjFNcmVka0pGUCtlNWJCUXZ3b3puUUFUOUl4WjBBY1lWY0hhcTJoTUVZ?=
 =?utf-8?B?aEloTnM1cEpxQ1VIWGV4UVA0dEhUZEZmeDliSU1VL3ZFN1Ftb0EyYUFBa2tl?=
 =?utf-8?B?VkVBMk1ZNDJzbmhYRnJSSDE3b0svU2Z0RHBtdnlKTWplY05TUHVvRkVJQnZO?=
 =?utf-8?B?dHdDZElGOThVUkdib3VNZ2ZWSXJBaTZvTW9taVZVWE1PazlHa0hoYlhGUEt2?=
 =?utf-8?B?NUgyekpLTEdIVHZwMHBtekt4YTkzMjVxaU1BY21xaGFNQnZRZVdjRWlkNHdF?=
 =?utf-8?B?SlF3VUhuL2JsL2x6NWc2MGlKdzJJbGl2K1NKZUVXQm1iWGE1eWdHTWhGQzdu?=
 =?utf-8?B?cHhDc2ZMTDhEUG5TemFxRFJLbk9IZXJQS09sSXRIOXU5ZVo3bkFrNDJZemYr?=
 =?utf-8?B?ZkVOQm5CSDV2dUFPeXEvbmNwdHRuQll1VElPbmlBb3RwSVA5Y1pRNHo1QVN2?=
 =?utf-8?B?S2p0eWtqdkZ5K2xBZXB6K2FyR2tQV1J3QWxqR1Z4MGxNSkQ3SXc4NSs4dk51?=
 =?utf-8?B?Z25lWFJRUXhrU0J0L0ZZWGdyZGlvaUtnVDRjVXZKQzRjOXBKbnJnVHJlNGFs?=
 =?utf-8?B?RzJuSldFdFdnOEtuc3NtbGg5cXFWWnNITlp4eFBudEcvT3VwOGhQUU5ad3Bm?=
 =?utf-8?B?TmxkTXdvUU5XTjF6aXBZa081N0hRcGJwS1k5SnBtV0Y2YkNBM1FyNWo0dmhQ?=
 =?utf-8?B?UVlVeVduNSt3S2V6N2ZidkdrMFBzOVVDTmhWNlFBNWs0OVhFbGJxVG9XUVRh?=
 =?utf-8?B?Q1BHVUxmdlVDMkNZaDA3Vk9rbjg1TGsrSGZVUjBBWnpkTFF1bWdES3A4bld4?=
 =?utf-8?B?R2srVUV4aE4vcEt1bkFndEZKUTJrbU9NUWtOR0lNbjQvQnBCRFRVS21UTHJ3?=
 =?utf-8?B?RDlOOGxlQUxxT3lLeVBzQzdoQ2ZVMjN0R094SlpPa0ZSbVYrLzh0aDBLWG5E?=
 =?utf-8?B?RkhRa3ZCNWQwN2pzbEhETnFnVE1zSWo1emFoc0FqdU1IbXZMMk5XM2tyYXlT?=
 =?utf-8?B?SWhwKzcvbW1IUTFOVnp6cEVlUU9kWVF2Z1NVbDBXdTZjYlVpK0t3TVFJeE5Q?=
 =?utf-8?B?dklmdnVDdmNZeVBzNGdZMGRSQnhvZW8zNTZZUkk4WWJTN210TDNsMUtTNWFQ?=
 =?utf-8?B?QVBlSFUrelU1dDRvSWNLS3UvTVFuOWlzS2NLdnNyTjFlNVIvZkJVdDNPV2p0?=
 =?utf-8?B?WklOVGJleTN2Z1pTSm1LaHdCeFNYWW1KTmlGTllGV2tNMmNFZWE4MENCMUFk?=
 =?utf-8?B?emU5UytvRmFLU1lvU1U3QzdvTXB0TDU4TWFtelk2OUtXVkVYakNmWmdSRlhS?=
 =?utf-8?B?WUUzZHcxR21yeWpCQk41U3hiOEI1ZTJEL3BkMSswR1Z1VzZGVjk2Vk8yR0Y0?=
 =?utf-8?B?V2p6U2Focm1ISW5IWTlPeldsNkRObER6RkVXT3lmZmRNMHYzbGd4UXU0OFJ1?=
 =?utf-8?B?V2NCTUcyTGRCcDFkck5yWC9zdGV6dUlJbUJuMEdjbjU1Q28zWThVOWdUSXNH?=
 =?utf-8?B?b3FZZldGa2YzR0QxK1JxaVNNMWh5dFQ1WG8wUWpXRVljNkVLTHhXVW4vaUJs?=
 =?utf-8?B?UkxMZEFlcjF0SU11T2FmdWtQditKRmVkS090aWs2Uy9qOHZWdDNNRmpiY1RW?=
 =?utf-8?Q?pct/O8kolXvPv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1hhaGRySzkvbEYyZkdBakl6aW9lYmoydWxXL2Q2YXdING1GSXpkRkw1VW5Z?=
 =?utf-8?B?clQ4bWNPSWg3OHQrWnprMlViUE9wVW1OUTRES3dYMUxDZFByUCtzL05LMFAz?=
 =?utf-8?B?RXUyNzZoc05zdGszQ05WbDFnSGNUNjN4WkxxcFEvV09FVDdsL3dld3BCSHdx?=
 =?utf-8?B?QjVOcnRodzI4K2F3NVZHZlBFOXQyaEhTQTRUN3pDQkQvMHVOVjl1bE9XcHJt?=
 =?utf-8?B?UlVaNHpwQlBLU3ZOaW9pNVVsQzZlUmNQK2hZemp1eS9adHZKVTQyZlFGMjRI?=
 =?utf-8?B?c3diRGl0WnRhaDZwK1ZiZEpxK29UbHNNYzBJbE96YytOcHJwMWVrRGxGVHNS?=
 =?utf-8?B?WklNMzkyWTlkdjZsbHNMRVJyYUlXREJ5S2l4UlR4VUNGTThveEFHaEtKRkFX?=
 =?utf-8?B?YW1acmozZkVQRktDSnpCRGVINHBzRjlHUUlWZTZFQ0RKaDdZTlB4ekV4dUtl?=
 =?utf-8?B?cEI0bkhiYXVrYmpCZk9RNStFZTdMODhZYWdYZXlRaFB5dUoxK3NBM2poemxp?=
 =?utf-8?B?NGF0S1ZzRjk5UkJLTXR3NEorVlc0NlVURGp2cEFSdjdEWTZzZ0xaOWpNdFZz?=
 =?utf-8?B?UVBCT055a0hRSlRhcko5Qyt4dW1uTU5QbWJ1cHYyK1VlSXlLZ0xJZzQ2VGVU?=
 =?utf-8?B?QTdsYm1naEI5RVFVWEUxRWgvdkVFNzRMZDlaakJmd3gvVHM5dU1qaDkxWnZN?=
 =?utf-8?B?czdEYkU1REFteEdCL25IUTNtSE1FMDZjZk9XcVVEMkxHdW1mbmhYcVRHU2hZ?=
 =?utf-8?B?Ymd1amNtVnNtS2VVdVV2am1Dbk5OUklGZnRLZWhVdHBENW5vTXduRWVQR294?=
 =?utf-8?B?YktvejBQemxYdFQxL1pySEVaWnhuVlZCVWN4eS8yb3lFNzM4TklVTFdtajA1?=
 =?utf-8?B?MnhjOTJLa2NVNE4rMEw2N2d2cFNpa2hOcmh0Qk53QzY2cjRSWW9BVnZxS1Y3?=
 =?utf-8?B?bjNzVzJZS2p1RS9ENWc1K2U1RGxOMkluSGIvTHFnQ1NBZkhZdWFPRUwrZXRr?=
 =?utf-8?B?WTBub3F2bnJhYW5ydUJxM2ZKZXFRc0JJS0ljbHVnUHovcnFrRXRacTVLSlVl?=
 =?utf-8?B?eERlblEyckxXNEZPTmw4R05qRnlmWTNVUXhhSnpIc2pxWTNWeFJVSEJqbkQ0?=
 =?utf-8?B?cllhYW5CYldvQ2VEM3pCODZpM0lkRkNwK2hxdUlLR1N3Z25lT2E4cE16eEtj?=
 =?utf-8?B?OERJcU9nM3JOdWwxTVdnK29Jb3NyQ0pEWWRnWTlncVlQcHVsTkw5djlpVDFL?=
 =?utf-8?B?a3M4YXlaQmtoeURWcmpJZnh3QWdHd0JhVGVLdXFGcHBDUEFLMzFwUWNHUmVx?=
 =?utf-8?B?cVY4Y0JLSEFmN2tRakowemthMlRXaytrQUIvUmgxU1k3Uk9JVVFRRy9JM01P?=
 =?utf-8?B?UEJjcnoyck5EVTlTVU4xOVZsTXlvVUQyOW54QTVCRVgyRjNVdVNUVlhIZ3Qz?=
 =?utf-8?B?RFJpSmdBaHFOVzNVNUorajhndzJibDFqbTBiNzUzVTd5cVVpWGVlMXNNWGFn?=
 =?utf-8?B?YXEyU0RtWXdWZVNuWVFjRWkvblh5ditVVkRXdW1UWmNPVXNQTHJoeTFuSFFu?=
 =?utf-8?B?RWdWLy9JbTB1c25CTVBpZXUrbGZmY3IvcmZuVGd5bjZQREg1b3doeE9nYlRM?=
 =?utf-8?B?S0NYQVl0T3o1dXk1L2RSZUt6UWRTWmJRak1lUW9CQWpMOG9oKzU2RHh4VUlT?=
 =?utf-8?B?cWZFNnAxbkdkMXh0YURrZGs4akV1OTVkN0RrSDVNSVdkcWRrMk9KMjdCMlc0?=
 =?utf-8?B?Y0NESUJKakVEZkhBNFo0azhmem50ZWt2YmNiWWk3Q3orU0M1SkEwSis3ZEMw?=
 =?utf-8?B?cHNkR1VVUHFCQzVtNERyOU9ISCs3VkV3d3BodG5EWmRrUDYwU3g2dnduZmI4?=
 =?utf-8?B?blAyV2lvZUt1K3lLUmQ1djRaVjRlQUpYb1hRdit2UWZ3cWNUMlFiSGNmMEFB?=
 =?utf-8?B?c2ZlR1FrVVZNL1hnUFBNUXhkSERZNkJNbWNEQm41bG5tTGxhVFdCdmlGWXZH?=
 =?utf-8?B?VFhvQXJzTFl1TE1Cb2FGNDVraU1FVG92dXdJRWYxTmlWL2JnUVVFRGVGcSsv?=
 =?utf-8?B?M3ZyS0ZudUNhT3ZJU3FwQ2tZaml1d3c2QTJYejZkY0Vac2lCQlhtOUZJbHRJ?=
 =?utf-8?Q?tcOH4JjYyQX3uL6aTkiaSDoNy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1f66dc-24ae-450a-a4fb-08dd659ee026
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:58:39.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVNbJnjyrMV158LgKNGpn+hs6nBJT1nHtf+m9RQMZediq8DQ2EMvCP80yt/9RBBuWlf5uY8wA02816vuMfyHpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683

On 3/17/2025 10:53, Antheas Kapenekakis wrote:
> When tt_toggle was introduced, it was not added to the platform sysfs.
> Add it, then add documentation for tt_led.
> 

Ideally I think this commit should split into two and there should be a 
fixes tag for the commit when tt_toggle was introduced.


> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   Documentation/ABI/testing/sysfs-platform-oxp | 26 ++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentation/ABI/testing/sysfs-platform-oxp
> new file mode 100644
> index 0000000000000..776b7dee3d595
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-oxp
> @@ -0,0 +1,26 @@
> +What:		/sys/devices/platform/<platform>/tt_toggle
> +Date:		Jun 2023
> +KernelVersion:	6.5
> +Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +		Takeover TDP controls from the device. OneXPlayer devices have a
> +		turbo button that can be used to switch between two TDP modes
> +		(usually 15W and 25W). By setting this attribute to 1, this
> +		functionality is disabled, handing TDP control over to (Windows)
> +		userspace software and the Turbo button turns into a keyboard
> +		shortcut over the AT keyboard of the device. In addition,
> +		using this setting is a prerequisite for PWM control for most
> +		newer models (otherwise it NOOPs).
> +
> +What:		/sys/devices/platform/<platform>/tt_led
> +Date:		Feb 2025
> +KernelVersion:	6.15
> +Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +		Some OneXPlayer devices (e.g., X1 series) feature a little LED
> +		nested in the Turbo button. This LED is illuminated when the
> +		device is in the higher TDP mode (e.g., 25W). Once tt_toggle
> +		is engaged, this LED is left dangling to its last state. This
> +		attribute allows userspace to control the LED state manually
> +		(either with 1 or 0). Only a subset of devices contain this LED.
> +


