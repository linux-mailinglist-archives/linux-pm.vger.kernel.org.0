Return-Path: <linux-pm+bounces-27292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFE0ABB3E7
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 06:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AE4174164
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 04:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43931E8331;
	Mon, 19 May 2025 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i0NT3CpC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC03595D;
	Mon, 19 May 2025 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747628328; cv=fail; b=TE+wWOEG499h2bowi1Ju8zx81PY6IqpnGO8XqCJ2AqIlJWmeyJlEi39vbnR4xyKuwnz/9GMnCP9EEGt7Z5nb6r+GirV40WRlgkxMGRSz4Bo/7724k6bkxB029NNromidUi/5gbaw81CPNIp7ifrhG1+nESlAAJCH9WZQEkSRXHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747628328; c=relaxed/simple;
	bh=DBtj1nQsXW+JKNXLpgavZhLmzGie+IFZ/40foYt+XQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1rcen9ZP4oHzUaDI5PoFAM4376F/qd+GmhcL5UIhMPkEpJytaFQzHc4adFN7SI8EEGKV3B/ISO+INtetzaAixuT0tGconqCES9jDBydZhCO4K7qBbTdFBxpAOuaGyrz+EB27m+rogXuhnEtgklMHR+dhanpAxCdUhxd3yX8nJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i0NT3CpC; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts3A9LljJsy9AU7Nunv93MpiHn0gVptosBM9upWjIB4rdfILMDPmaraOB8AKBF8C5gadqFZpNwLek8MVH3t2g3+OZlbZrjShkzfdxQ4hkaJSJsg/SIejquKVyIZDFee2xweiELrGrAJYuQDEo7uEKx3iv48lw4lrgWQ016opCMUPeKdABBNpSu7yZh9PsMuqMaWwgGlsGl/aq1nKQlZLwLAeQuTuUswdXcIeCUNm8sf2Js04EcUfiR+24tZx3mdxUIX08/kI5olD6rR+gAI3DbGw0pisP9qxyy49drweD4C7q5X2+mlFdTe/yWW+2UeO3FhaeeyheXUwyVCelDnLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Vykx9Ek9OiD9x1WcNgcYEhgkgLSyzWBnKyD+CboqeM=;
 b=bncK1Jm2CKLRD0wdEVsrYpA3eiJ9qYYvrrlM/nFVuf7+J0no5pBpkoMd7kKzQ9QtBQzMawYZ89/llZTVRhSB8tyL5J78BmRd0WOYbWHYJKieRT1/jfaG+5zBgfenGqfVHDKUPIUqc4w04ZSyR5z1KDWfC9P1uyR7sag9thY7/evosxbgGKTLxtS7uZfKbgE0ICaUr5rQegO1APLpIfsHPsX8KE2jVo8OqKoFjxenKTgdepHD9kfmfPGeb/fGr9ebLSke2uaVrpVgHTtg9k4OLr5cB/sXnl1Fa8+IbqzD5qX1FaExZuFGvAytpENdZ3EiHkOjI2r+pygiojMSSZiLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Vykx9Ek9OiD9x1WcNgcYEhgkgLSyzWBnKyD+CboqeM=;
 b=i0NT3CpCQDrkEl8Aia/nP3ff5N4Xpz1HuQJlkA4ihqGe3xmoiysIAsDUir/vG4nDn6GCl24kY4aynqasqTYpBGE2Z/NrvYMsxuud74JRlvoInQFxKMYHntfWkUjBxIH886/F8Nog9N3HpW40v0mNAdaGc4U37+MVSr9xwI/rMWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 04:18:43 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f%7]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 04:18:43 +0000
Message-ID: <3c612c2f-026e-4bc2-bbb4-3e9097acc6f5@amd.com>
Date: Mon, 19 May 2025 09:48:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during CPU
 onlining
To: Eric Biggers <ebiggers@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Jain, Ayush" <Ayush.Jain3@amd.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>
References: <20250518193212.1822-1-ebiggers@kernel.org>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <20250518193212.1822-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0129.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::11) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6d64e7-beff-493b-6673-08dd968c3d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0YrZzhWTmF1Mk0rYUE1MDNBQUVpM0xpMmxqT2FPWENhaGZycXV6aFBBaFNL?=
 =?utf-8?B?OGwvVlhhR0laWGpQVFdRNG5wT3M2NS8yNGNORDNVTk5aNVpQNEp5R1d3anB0?=
 =?utf-8?B?S3lHeFppMHlsY3lQWmFRSVUvb3lHNEdGQzdMOUttcVJwZEFwaTFrVzl2R3Jn?=
 =?utf-8?B?WjBvNDZ2UWNxZnhaTEhXcEVzcFU1cTlzYW1JWjRYbkNqNmJEWUFIbS80MG1X?=
 =?utf-8?B?LzJuMER5bHZETnUwNjA0N056M1NzWHIrc3dJMGZxenlkNHZoaHRpMVpHWXdI?=
 =?utf-8?B?dFVEQXRZOWdZR0JrNE0yZ3hxdUREVkNFMU1ydW1wRnlPeUoyTGJYVDExek1r?=
 =?utf-8?B?Q0JodzI2S25nV2QzRElxOXdmNFNrWFVLdCtrUThXQmVLNGc5V3RqckM4OW80?=
 =?utf-8?B?bUZDTGpTellHZ3lZU0dvUFcvTTBoaCtTSmdhRmhPY0UxNWpqeG9Gd2tLeHk3?=
 =?utf-8?B?MklDV0hXdmxqSWJFSEZZV3Vvd3FYQSs4OHo5Ymd0Vmg2V2pDNHY1UW9kWU1I?=
 =?utf-8?B?RDkvc282ZzBTNmNJWU1mSE9qZnNCdXdUWDFxd251eWo2dU5NZUtYMmk1ektO?=
 =?utf-8?B?a2lZSHM0aUIyUXZDemNJczFNY3B4MG5lempwZnhLVTM5akFQK0Z2c1pWWWcx?=
 =?utf-8?B?RmZpS2tBekhEVk1tcVJGREhqR1FrdzZ2cjdOV2Y0VkdseFY3REszWlN2ZHcx?=
 =?utf-8?B?cmRoOEp0SXF3K3pldTczeVdzMzVPZDJ0Tkp1aG9tMDNKOS9VMWNSTVFoTk9p?=
 =?utf-8?B?ZXhZNXR3MlRMSTdmSkVmTU9KcnQ4UEJxR21keExoN1g5ekdSTTRGYWp2ek5z?=
 =?utf-8?B?R1NTalFGYU96VUx0cWMxQ0NoeUc5a1pyWEFlVldPNnZIRnFnTmgwNE5RNTlM?=
 =?utf-8?B?YTVwMFg3QW9DT0ZIeDd1allwdWxtVTVTYXpjVzhTdGNQcXlnQmZtUkt0M1BC?=
 =?utf-8?B?Q3hIV2VxOE51bVVsdjB5NWdDa0FIcnhjUjNKWXBaVTNvTWZWd3RmcGZHZGxC?=
 =?utf-8?B?V1lYRkdJQ1Y3L055ZUlCSm5oR3p2VUU3MmZMOG9IVkhLRjFLR0NPNDU0eFZr?=
 =?utf-8?B?a1lkdzQ4U3I5MUpvWmtKZmpiOVZKZVJwcWExTGZDYTlqdmhyWTJpWUNBc1py?=
 =?utf-8?B?SlJBUFhOYmJIT3djOWRudlRlNDNZNzd0OHRLNExRTVo0UFFVdTl4MXA2QmRw?=
 =?utf-8?B?d1d5dHkrWWl3UFMwckg1V3lZQzMySEZhbEZOT0VDUW5DZUZaU2NOTTZLRUtB?=
 =?utf-8?B?SXYzM0N6UnJyRXZjZjIxb0R2V05xVU1ZbklwRFludUpsV1ZDMi9CZUN1emp2?=
 =?utf-8?B?eE9hazhQdkhNYVNQc2hCWG5UdjVoY0YyYi9xemNjVWdiOFh6anpFeGZ4T09o?=
 =?utf-8?B?Wm9rOHdGam01OWkwQzU2eTBXSXAwYXNiQ1Z1UkFKRkpiRnRQelNhZENlZkpv?=
 =?utf-8?B?S3BLdzFCN2RyTXEveWxqQXF5N1BYajBvYVVCNmlPM2Qrdy8wVzlobUtVOGp6?=
 =?utf-8?B?TzBFMmo1L3ZQRXo4eWpMYmVuVCtHS0tDeVIyaU4vcE8rNDZ6UldSNU13Z0Vm?=
 =?utf-8?B?bEYxaE9DSG84V29JdytRaGNjYkM3NUk5YWg2bzFLekJVVU8yNFZZTWk2K1BP?=
 =?utf-8?B?MkdSNkl2SXJPeHlmdkdNcWgrREhkc1hHamxDWmxxUmxQYXNWVmVaNXFHV3Ez?=
 =?utf-8?B?KzkwWTZuY2tRd0hSdnFtay9OeklUSEJMNHlCY1BEWDZQNFQ5alFBVmlGNVNP?=
 =?utf-8?B?ZnVHNm1KM2pOZElHM3lrN2FEUlF0VEhWcGdTeHk4VE8ya0Q4ZWI0N0xIV1M4?=
 =?utf-8?B?WkRXejVGY3ZEVys1UXVMWWlkK3gxdVRnbWRiUGpLbEpDMk9tNFJRblJsRGpE?=
 =?utf-8?B?VTI2UXJDUll6S0M2TUNTeTVRM1JOVUxOaW9CaHlyc1V2MU5XUGxFRFVUWG93?=
 =?utf-8?Q?83kgQv+3Tks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU00ZjJRKzU4SkkyeXJQd3U3WEJEaXNoNVc1NytYWFQyblU3aXNhbjA2NzZR?=
 =?utf-8?B?T2hXdDEvSWwzM3dOem9YMVMvMDNTdHZYbnhNdjJETnRFTG80VDBQdE9FM3dP?=
 =?utf-8?B?Z3NoT293Z2lUOVFZZEx4bmNTOGc5ZFA0YWtqdFF0cGdidEF6RjRwd2tjWnpF?=
 =?utf-8?B?a1BzeFFoWWtrelp3SVFXVWo5dDA4ajVZcXJLUWFqKzhXcUJldU5GUjFIdnIy?=
 =?utf-8?B?TTRuRDY2MjlUdkZKUlhYcjNiMk1yOUlSTFg1eEpGTUM5Y0dONnZOdXNvYjZ2?=
 =?utf-8?B?RHp1MzMySjJ6emlYOW1sbmJ5N0ZqV01iMzhMWHpGVEpjYy9LSzlxK0hDVUJR?=
 =?utf-8?B?WnErVHQrTGVyc3N6TStDR3BZMnhEWWR2RlRRUkc0VEVranQ1REZPVDk4ZGFO?=
 =?utf-8?B?Z0M1MVd5Vy9HanhJcytnZDVlM1A1NGczUXB0cmpPNXVESzNrV1NRbmRCYm8z?=
 =?utf-8?B?WkZjSzBRcUE5RXU0bWlSbXRHWk4wb1Y2bmhtNE1KNnJ0Q25rN3EyZWVJdk9N?=
 =?utf-8?B?TVRNelhBR1ptQTZ0MlNjVjREVDkrQjE5L0pHd2VuTVB1bnpmQ25GTHlXaXdm?=
 =?utf-8?B?TkpvMndsbXZHQmxKVkI4dzczQmQ1MlN1TjdDcFpXM2hJL1JFM3R1eWRTVWZo?=
 =?utf-8?B?YnJoVks0dDVqUDNMNkRlL2Z5UFNrN1lMTE9nN2Z5bXZpUEtLd1Y1cXBFb3pC?=
 =?utf-8?B?b2dCRWtuR2w0c0VmZnY0TUdDZ2JOOVZpaitqU3h0bEx5Qmt4OVdhNVJ5aDls?=
 =?utf-8?B?c0d6OWE2TXJ0emI4d1FSTytMcExzT1lBSGZobEM4Qmc3QmN6a3I1Q2NMbGJ0?=
 =?utf-8?B?b25rQ2NHQ1ptSmVBSFBySEJwYnEySysrUEwwZ1c4Q1VrbzJiaUpzd0Z3dG1v?=
 =?utf-8?B?RnZweEtiSG4zYnVQc2NWdzNwSk8zYUxidlZRWk5FbnMrV01HS1pBN0xEVm5P?=
 =?utf-8?B?WnFhS2ZMWDJhSStDQ0Jra2lBOXNNa3c2V09UNHBUZHBONkdMbW16V0NsTmxq?=
 =?utf-8?B?YW5NdTl1SzhLV1lmdWtuaU95VTZZT0UrSkNzWjBZU0ZMTGx0QTFKYWs1bWM1?=
 =?utf-8?B?YVNic1dwNW5kYU1tclQwU3R5MjBqSUV2V05tdVdlN2hYS2dVcVVxcEErTDgx?=
 =?utf-8?B?c1crWnRJYnJPTU1GYzVCcVNnMUp4STgvTStWajE5Q2NqRkY4eDJWOEZEdmdr?=
 =?utf-8?B?c2ZjdVhCbS82blJjQXRpWVphRzJ3NE9jLytZVEtYbzJFMnkvRmxOSFk4YzRU?=
 =?utf-8?B?bkh5K3pMdWhMbkJNZ0dUNDMzcG9kWjZPSGxVS2RUcGF6dE1ROEZCVXhrQllR?=
 =?utf-8?B?SkxMVW1LOFNpTXFiWHp1SHQwSk1wbUJMK1lQMXVhaUR5WHVSa0xJK1hsTy9M?=
 =?utf-8?B?QTA5YldOVk1ManlZczhYT3NCV3cwdXI1MGh1c28yZ2w4MHVIb3lOUHVJMjZ3?=
 =?utf-8?B?T3JVWFppanB0N1JucWd4c3M0VHNjcDB3a0JOQXdGS1dHU0FHQy8rN3hBalVi?=
 =?utf-8?B?blpSKzZ0SHA4WHNJWW9nak5TdzdSVWJWVXVjV2NteXZOdjVwUEdYbDVoNUZJ?=
 =?utf-8?B?eFBLNHNlTjE2aVZiZVFFYXVqNWFlVTFEdStDR0w1K2hiSnRNcnA2QXpvekhp?=
 =?utf-8?B?SEVpNHRuQkRJT21yYm84NlBQU2NUMlBVNWxaWnlJTWd3dy9FRHYvNWFUblJP?=
 =?utf-8?B?TmJWeUdsV0FTUEsyU2phakozcW1nODVFS1IraVZpM1ZtU2UxYlJVQ3oxNUZX?=
 =?utf-8?B?SE9vQXlIZ21Yanc2ZjhBMDdpalk2QUF3Nngxdk9XYVBobmdGekZrR3ZXWER3?=
 =?utf-8?B?Tnhud0lRN1haenJMelh6MjNndUNXYWNtZnRzaGlRemUvT3k4M1dmSm12Q1hh?=
 =?utf-8?B?MitCME1Kd1BuekhaWnRucW9TclY5NWRoVzg4cm1YeFV3R0dOS1VMUkUrNzRU?=
 =?utf-8?B?Y09pbXlZSUprMGZxMy9nVG1aejQwc0RaWGFyVmN2WkZQUHpqdzM1cnVGMk9U?=
 =?utf-8?B?clJCSmRlc1Y5Qk9NbnYvM2g4Vlg0eDRDdTNObDg1TmJ5RUZ1NVpoYmQxdDdn?=
 =?utf-8?B?aFJ3QkdRY0diZlhITGZZZEtPd2cvcHg1QmVpVFRmNTNVWERPMmlGazdVQ3VO?=
 =?utf-8?Q?3fERq4vD8vDVhGVZc3qbdnh0U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6d64e7-beff-493b-6673-08dd968c3d4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 04:18:43.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmgBGgRfb7ttGg2jnpgP/cnseNUdxRpY80y5KxslxTsP3zR3AlgXpgqunY+5SVdORsTYAHZxARhl0Y13euDW3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131

Hello Eric,

I have tested this on AMD EPYC 8534P 64-Core Processor
and this patch fixes reported issue.

Tested-by: Ayush Jain <Ayush.Jain3@amd.com>

Thanks,
Ayush

On 5/19/2025 1:02 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> irq_fpu_usable() incorrectly returned true before the FPU is
> initialized.  The x86 CPU onlining code can call sha256() to checksum
> AMD microcode images, before the FPU is initialized.  Since sha256()
> recently gained a kernel-mode FPU optimized code path, a crash occurred
> in kernel_fpu_begin_mask() during hotplug CPU onlining.
> 
> (The crash did not occur during boot-time CPU onlining, since the
> optimized sha256() code is not enabled until subsys_initcalls run.)
> 
> Fix this by making irq_fpu_usable() return false before fpu__init_cpu()
> has run.  To do this without adding any additional overhead to
> irq_fpu_usable(), replace the existing per-CPU bool in_kernel_fpu with
> kernel_fpu_allowed which tracks both initialization and usage rather
> than just usage.  The initial state is false; FPU initialization sets it
> to true; kernel-mode FPU sections toggle it to false and then back to
> true; and CPU offlining restores it to the initial state of false.
> 
> Fixes: 11d7956d526f ("crypto: x86/sha256 - implement library instead of shash")
> Reported-by: Ayush Jain <Ayush.Jain3@amd.com>
> Closes: https://lore.kernel.org/r/20250516112217.GBaCcf6Yoc6LkIIryP@fat_crate.local
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/x86/include/asm/fpu/api.h |  1 +
>  arch/x86/kernel/fpu/core.c     | 34 +++++++++++++++++++++-------------
>  arch/x86/kernel/fpu/init.c     |  3 +++
>  arch/x86/kernel/smpboot.c      |  6 ++++++
>  4 files changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 8e6848f55dcdb..cd6f194a912bf 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -124,10 +124,11 @@ extern void fpstate_init_soft(struct swregs_state *soft);
>  #else
>  static inline void fpstate_init_soft(struct swregs_state *soft) {}
>  #endif
>  
>  /* State tracking */
> +DECLARE_PER_CPU(bool, kernel_fpu_allowed);
>  DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
>  
>  /* Process cleanup */
>  #ifdef CONFIG_X86_64
>  extern void fpstate_free(struct fpu *fpu);
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 948b4f5fad99c..ea138583dd92a 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -42,12 +42,15 @@ struct fpu_state_config fpu_user_cfg __ro_after_init;
>   * Represents the initial FPU state. It's mostly (but not completely) zeroes,
>   * depending on the FPU hardware format:
>   */
>  struct fpstate init_fpstate __ro_after_init;
>  
> -/* Track in-kernel FPU usage */
> -static DEFINE_PER_CPU(bool, in_kernel_fpu);
> +/*
> + * Track FPU initialization and kernel-mode usage. 'true' means the FPU is
> + * initialized and is not currently being used by the kernel:
> + */
> +DEFINE_PER_CPU(bool, kernel_fpu_allowed);
>  
>  /*
>   * Track which context is using the FPU on the CPU:
>   */
>  DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
> @@ -70,19 +73,22 @@ bool irq_fpu_usable(void)
>  {
>  	if (WARN_ON_ONCE(in_nmi()))
>  		return false;
>  
>  	/*
> -	 * In kernel FPU usage already active?  This detects any explicitly
> -	 * nested usage in task or softirq context, which is unsupported.  It
> -	 * also detects attempted usage in a hardirq that has interrupted a
> -	 * kernel-mode FPU section.
> +	 * Return false in the following cases:
> +	 *
> +	 * - FPU is not yet initialized. This can happen only when the call is
> +	 *   coming from CPU onlining, for example for microcode checksumming.
> +	 * - The kernel is already using the FPU, either because of explicit
> +	 *   nesting (which should never be done), or because of implicit
> +	 *   nesting when a hardirq interrupted a kernel-mode FPU section.
> +	 *
> +	 * The single boolean check below handles both cases:
>  	 */
> -	if (this_cpu_read(in_kernel_fpu)) {
> -		WARN_ON_FPU(!in_hardirq());
> +	if (!this_cpu_read(kernel_fpu_allowed))
>  		return false;
> -	}
>  
>  	/*
>  	 * When not in NMI or hard interrupt context, FPU can be used in:
>  	 *
>  	 * - Task context except from within fpregs_lock()'ed critical
> @@ -437,13 +443,14 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
>  {
>  	if (!irqs_disabled())
>  		fpregs_lock();
>  
>  	WARN_ON_FPU(!irq_fpu_usable());
> -	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
>  
> -	this_cpu_write(in_kernel_fpu, true);
> +	/* Toggle kernel_fpu_allowed to false: */
> +	WARN_ON_FPU(!this_cpu_read(kernel_fpu_allowed));
> +	this_cpu_write(kernel_fpu_allowed, false);
>  
>  	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
>  	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
>  		set_thread_flag(TIF_NEED_FPU_LOAD);
>  		save_fpregs_to_fpstate(x86_task_fpu(current));
> @@ -459,13 +466,14 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
>  }
>  EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
>  
>  void kernel_fpu_end(void)
>  {
> -	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
> +	/* Toggle kernel_fpu_allowed back to true: */
> +	WARN_ON_FPU(this_cpu_read(kernel_fpu_allowed));
> +	this_cpu_write(kernel_fpu_allowed, true);
>  
> -	this_cpu_write(in_kernel_fpu, false);
>  	if (!irqs_disabled())
>  		fpregs_unlock();
>  }
>  EXPORT_SYMBOL_GPL(kernel_fpu_end);
>  
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index 6bb3e35c40e24..99db41bf9fa6b 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -49,10 +49,13 @@ static void fpu__init_cpu_generic(void)
>   */
>  void fpu__init_cpu(void)
>  {
>  	fpu__init_cpu_generic();
>  	fpu__init_cpu_xstate();
> +
> +	/* Start allowing kernel-mode FPU: */
> +	this_cpu_write(kernel_fpu_allowed, true);
>  }
>  
>  static bool __init fpu__probe_without_cpuid(void)
>  {
>  	unsigned long cr0;
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index e266c4edea17e..58ede3fa6a75b 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1186,10 +1186,16 @@ void cpu_disable_common(void)
>  {
>  	int cpu = smp_processor_id();
>  
>  	remove_siblinginfo(cpu);
>  
> +	/*
> +	 * Stop allowing kernel-mode FPU. This is needed so that if the CPU is
> +	 * brought online again, the initial state is not allowed:
> +	 */
> +	this_cpu_write(kernel_fpu_allowed, false);
> +
>  	/* It's now safe to remove this processor from the online map */
>  	lock_vector_lock();
>  	remove_cpu_from_maps(cpu);
>  	unlock_vector_lock();
>  	fixup_irqs();
> 
> base-commit: 8566fc3b96539e3235909d6bdda198e1282beaed


