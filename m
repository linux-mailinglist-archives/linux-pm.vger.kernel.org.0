Return-Path: <linux-pm+bounces-11135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DD932213
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 10:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8111F22807
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6117D36C;
	Tue, 16 Jul 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQSHFcjg"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478A1B947;
	Tue, 16 Jul 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119371; cv=fail; b=Vc577nZPaLLpLXuSncDQDw/ebnAVDMYWQlvFmr4vNovLBZfCtIm6nxKpG9lfT4e56YDCyTsD2JJNl52B8CiWEVDcHXEiUphzwSmZlOfkRPHFISiAiJDpP+thSPQaYdQATSq0qOKo2g59yZDYnUSHBi9/QF+R+0jO1I3UMwp0mvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119371; c=relaxed/simple;
	bh=aC8TlObKdSOvyYihtG2qc/JI7N4EY5CzkY1ohDDs6pU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBFF7mNBM5Isgsqg2CM7pGqz5Q4LoZ1Jk9/Yw0VZjS32MKjo8EX8FQUE7rt5f2mXx4XWcigO3appQ6MnltZgkUIUNw/6ckVk9SpMVVID2yuSueKPsVNC5nDRitUTDEp9Q50F3qSeCq/4DT7Xs/MhxWdmwecbVn4S2O2h6RY4X18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQSHFcjg; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH1OIZQ7i/VixlKqbq0euntzIHsnN8Qm4Al0eVj0nCknaFB05uQi5xlnMtGwPWs9Yz0DGU+MjkI8USivz/CG5gWjLr7nOIwkoph/zFZY5qg6nTFpgVO7a30NdCi6hFiz7kYXA0yM2q4s7sQuaqlVFbxBs0mNJ86vT2tI9/44SdVnzB3Fs/jdMETbt+dlNvBbUsQalwxQ66O9hJbm9X9HbsXj27TqlE6IG9f27YJ5/4jSr5yni2+1nekymiSmtY67cynDQSNIG6ElzsOo6E81lCGwyXinxCsxNLfPGBdYVWrzTOVObVJu6RRIvL35eKV8tUKeQdfjeSJkBEGgfa6l+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoRzQAW+JhvkkRigvRtgg0xgaj1wA/nASQUHWOC2w4w=;
 b=tVbqmbypjx+NUEXRIfZM0sgEBJn4l1+XO93MR+L6uGL2bpoHvNggWlULs0GNvv13IftvX59nwA0ab1+9SUCcUJ0RqCjndA8Hb7yY42l+kNNKCz5Nj5C+GFqi7s1lgA10K3gk9kgpo0/fscvl8aLfFYL+vWZAdWVFnmBB1OWXqPcfmwT7hF2qbY3dP494iod9womIWzGKmGkYgrS+XeOMhxJQjl+Y8J9rnMFiss/pAdsxcOeZ6iFV66WjjubClu1IlBxXYfMEhW4+aWzv7g3PK3sgn3gkbYQ7CuX1oVe0f8myTqXMDSrg2fTrM7iFVzp3XG5rA8pMQxpadp15hT7WMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoRzQAW+JhvkkRigvRtgg0xgaj1wA/nASQUHWOC2w4w=;
 b=hQSHFcjgJ2YH9wddjMQ+FHARbHa6Iz64Zc8PkvU9V5VpvbHm4dzXLygorsb6rEKaHZEI/sJug2naf4HIP+OCat9BODbMaLKKAubiD35s3aZnwFllHfn9d09tKUxT/G9c2g7U3f3FqmMnCxj1qYPMmJjnakhQ704XTuBXswrS4H8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Tue, 16 Jul
 2024 08:42:40 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%5]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 08:42:40 +0000
Message-ID: <2e7064c2-c769-41bb-a536-c6e75e8e5800@amd.com>
Date: Tue, 16 Jul 2024 14:12:25 +0530
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
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CAP-5=fVXi3Pdtjaw++oRkYgubh-MDkRYf=2k7dNqE8s+jyQ+Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ffb3b1-543e-4245-b3d5-08dca5734082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEtydjVUTlV2d29WT3RrOTgrVmhHbytBSk5KQVg2YmsxaEpWL1JKajRiVEZB?=
 =?utf-8?B?NXVmbjY4cW9PWXFkSUEwM1lZcEJ1VlR4cTkvSlZxZnVwRXc1cURabWNFYjFO?=
 =?utf-8?B?QzZnZFA4K0xDdzRGRTdZZWcvdGtRZllRYnR5MjRxOW83WFlGNkxvSTdsWlhs?=
 =?utf-8?B?Sm9FcXN3TFFqVHJUQWV2WGwwRXR0UUFudUg4dUloWUdNYjVjTmQ2eUNJQ3ky?=
 =?utf-8?B?a1AyWVBKRjYwS1R1ZFJSNldxejAwY3RsTk11TklHWWVjRlJwSU1PdEVSWENM?=
 =?utf-8?B?NkMvZkV3TEVzVkJDR2dBaWVIR25LUld3Yk5aelVnU1Z6UldGR3JibDFqOXNu?=
 =?utf-8?B?eGNNWm5XVWVRWERmOTg0MXo2aHlPc3BuRG00aWZCZHd3SmlNVjR4bERnZ01I?=
 =?utf-8?B?R01GR2FOTzZsNThoaFpteFFJQy84djd5cXNxLzhjYXNYK1ZDcUQ4OWV6cEdY?=
 =?utf-8?B?OEdxK3FlbEJMU2JWSUFDVkpodTlXVEdwejFreFhvUGJaM29uMFo2QmZGZndE?=
 =?utf-8?B?aFFHSVo0TSt1RUpvY0J6MXdYdno3bjJQRklLaDhEK3ZWbG1RaEZ5S3NIVUZC?=
 =?utf-8?B?NjJZcXppaW1rU2xUVmJUakY1TzFNSWFYY3Y0SllRVkQ0SXhhczIzSDJIWG5J?=
 =?utf-8?B?TEtNV2NQY0tBZEQ3dXpIMzF4WldlWFlnYzJCdFhzc3cxVEx5RnBZUSswUGVu?=
 =?utf-8?B?YzVnR1hTU3gwNDZqalJlcnJZMFBUNkxjMURvRENUNmVIYVlLT0dTSWZFbnNH?=
 =?utf-8?B?T2NmV1RjcEFDY1FnRjlncURGVkhOTEwvNDVES3dZSXFiUkluSXkxN0pjNDJh?=
 =?utf-8?B?T2ZUZTZFSS9vTmlWb2ZqM20wVGhvbEZrV3FuWEJyN2xsM21OUXcxWFVOZzZB?=
 =?utf-8?B?dGhBaTVQNjlmbTk4aDd4T0RxVitraGQxMmJmMnlHQ3loTVd4UFNyd1JFdGd1?=
 =?utf-8?B?VmlaMk1hdnNoTkNzd0ZnN3hMa3VTNDhuNWJpbXl2aldVZ3BiVVJYUm8xcFpS?=
 =?utf-8?B?MGQxOTJyUDJxNnQyUHVzOEVXbXFCWUZHZC83OCtiSTNCeWYrY05yVTJzR1Ra?=
 =?utf-8?B?OGQ2S1BFdmZFQ0pUbEFsY1dmVElGQkc1ZDN4dUFIcGEzenQ4U2FhcXBBdm03?=
 =?utf-8?B?eUZqd2dMTFpRSnR5SFNoNHBSazVsNXAwdFM4TXplK002dGlpZlh0VlRjK3Fj?=
 =?utf-8?B?V0s2N3J2azliQ1dLenpScGNWbDNtYU90M0lwVHlKcEJ2MEFZWHdpVU4rbFE2?=
 =?utf-8?B?LytST3FIQzJEdFN6L2JmTGtBK0FHU0kxNG5BMkRGS2ViUmZqSk5IVHplTmFT?=
 =?utf-8?B?UVBLcGdVYUxYQzZ5d25DL1NXdHBJWkhZWGtWbjlIQzJUMStLWnhGUGxEUEUx?=
 =?utf-8?B?S3JETUVTVjRBZEJFZVBJUnJ0WVBEK21DaDFELzJuenVtMW10bWVNWGUvNHJZ?=
 =?utf-8?B?S3cwdDVSU3JNc2JualQxVFVXTWhHbG9DSkZ2bXF3MTFmTzZHWlJmeFRrSEhv?=
 =?utf-8?B?WlVFZVlidWx0NlpwTmxsTFFFYTcxSW50UnB2RlZVTExjaG51TDFxZTlWdHM3?=
 =?utf-8?B?Y1lNMTlpcW5rMHNML3hPTTU0WGk3bS9TdmhIVDM4REFGa2xXUUxQRWJjZlVG?=
 =?utf-8?B?M0ovUWhraFNaVENCZzZ6OVVsVERyU25uR1E5V0FVdlh2a3dDdGpRZFZUL0g2?=
 =?utf-8?B?eDI2OTVVUTZkYXB3cTVCYlNwODU4MVIvN2huTzY2K096dm9zTmxMaE5tUEY0?=
 =?utf-8?Q?BlwwIUSk/K743dsF/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekdXN2QvRkF1NGd6MXVTTjJJTWdCYVhmcS9HaUF1eGNzWHdQQTQ4ZS9KV3Zh?=
 =?utf-8?B?b0N5d0VDbmUvVEFFR1lVUXRMRVAzamI4KzdSUjRGQkt0RzFINGRhSGk4bmVN?=
 =?utf-8?B?R08zdkI1YUZKN0dwUUtzemR2ZTdQRkdDcjNFVVd0SHkzVmJGNXNOejRhc2Nx?=
 =?utf-8?B?YnI2MTFJcXZodXdtZWVVZkhIQ0VMdFM2YkhsbE5RN2Q4NzM1UDNiQkxZbWRj?=
 =?utf-8?B?bEJwR1VRK0NZTGRaZEJXdUF0eDV6OGxMYWVjRXNldlNLTnhEcHI3ZHBqRUs1?=
 =?utf-8?B?c0lsTHRUaitoQnNNT1UwMURhd1lNcFptYkVaNzRuTGJxdjV5RzN0QkdqaGhp?=
 =?utf-8?B?RkZHRjdVd2ZHZWFPWG43SDVzVXR6LzFXZnJaNTYxR0pnR0NPTUxZUkhqclFi?=
 =?utf-8?B?cm1qYUVVbDFldW1yS3ppS3hhdUtZTllVYjU3aUVBaXNpSFQwODdSNU1WVndB?=
 =?utf-8?B?QWtrUjN4TzYyRzE0UGJkVHlzOXRuS3lUd0VJZjZIT3VDdGtGWDV6TnVRYTdQ?=
 =?utf-8?B?WVU4Q3hsamlqZmJZN1BXZ3k5VXpwdThyTmFGMjZYUlJ3SDJGVVo2UDhpVTFo?=
 =?utf-8?B?ckNyS3k1ZlZlU1RhQXBEdHFSZXVjWjd1ak11U0lmcWMrNk5rQWppNFpCWFFi?=
 =?utf-8?B?L1ZCcG9GQnRQaG5WWUVDUExxcnRLZ3dNRnoxbXlQdG9nWXJYdGw3RGxuTzZ3?=
 =?utf-8?B?cnp0UDczOXh4dU8weTVBR1JaRHJLbGszdmRGL1RqdkZDTXNRSkRaRjZ0ZmJH?=
 =?utf-8?B?UDUvTXNGaDFpWk1pazZMVW42NGk4ZncwZDQvWS9CMVB4N0FScjhraWM2bDhm?=
 =?utf-8?B?dXlBNElKR0JFZFkwVFZFWGNyQXRIcDVpbDhOTHB4Y2s3WndSTmVZVUFXNG9x?=
 =?utf-8?B?TWJBbnRUNnFZNDcwT0pHQXRLRmRXaTNkUlJmL2wvekE3TlBXYlNCbU82R3Nj?=
 =?utf-8?B?ejdCVFQzZTNMNUlIRG9WQVBrSFVWS2RtZUR4V2M5ZFBlYjlLUHJPZHBJcU1q?=
 =?utf-8?B?V2lkR0FUMGFad2cvZUNFOHFlTnVOVlh5WkVKTHA5cXAvSzBvc2JPTE1uSHRJ?=
 =?utf-8?B?ME9tSXlraEhxT0wvRk50SjR5SkxjVjhwVmJzYjdjbXdNUlZ5ekJQd2ZPbktR?=
 =?utf-8?B?L3ErS0ZwSktINVFjS1hSa3RoRnJpT0tEeWVRVGJCVzFXbHFtK1kwVVVyY3NT?=
 =?utf-8?B?UzNKMWJ1dXFKeTk5UUtaVUJjQ2xHMkVocUZuMXRHelRIQnplYzBRTEZuS3Jq?=
 =?utf-8?B?dzEyckxjYU9HSUFKeDBZdSt1TWFOT2F0aTVaQnFXK2g3OXJTWEx5ZVVVNnZ1?=
 =?utf-8?B?Y2d3anB2STdOMXNoeUs1RzZqMVV6M2srZHc4elpXSkdTbkpaTXFEV25NaG9L?=
 =?utf-8?B?NURrdU5IYjcxcENkZjZDZ1h4WFFjSDE3VGxmK3p1aVpMc3JqdUtCdnhENDh1?=
 =?utf-8?B?YUdkSDNNZEk1NFF6Q2tyUU1XZTFMTmNodkpubXlyT2hrT25xK3J0MWdYWEdn?=
 =?utf-8?B?eFBMWmk2aUZFZU53NHJXdWZ6dE9Wcmhmdml6cGFoNUlhMEN6T01DTzVaeGpl?=
 =?utf-8?B?cUxNUXhBL3psVlB1NFh4WFNiREZJZU01c1NDSm1XRTVoL0RVWmt3b0p6cGFJ?=
 =?utf-8?B?UklmUENlRTJFcHNsNHoraVVJSk9HVGkvc3VJeTUyeVdDdk1kVVJQQjdPUEVC?=
 =?utf-8?B?N3ZkaHlQdXlHVGtLckFaUmlqR3ZSQms4dTFjWFdLMm9SbXR0NkluL3l4MzZn?=
 =?utf-8?B?dm1sUFd1dU9uajZ6M1JUUHYrWTRPRVU2UGlrSWZWSmJnSnk5NHRJZGp6TE1p?=
 =?utf-8?B?U1pjQ0lnSHhzaDE3MnlwQlNIYWowSEppdXR3aTZnM0cxR3BwcTBxaUh2VURx?=
 =?utf-8?B?MmZJWFFxbUJvSXAySWEvQ1MxVnFRU3hGaDg5L0l4ckpqalNDQkVvTFRaQ0kz?=
 =?utf-8?B?YnVheVZyQ2RZdU9PbS9SZ0ZXNlZKeDlkVERZTytJS2sza0EvelVUY0h5YktP?=
 =?utf-8?B?ZmlpTEZ1STJSSXFKZitFamRBc2xyVW9iNjU5OE1sbVArdG1ja0VDMndOMlhW?=
 =?utf-8?B?anBnKy82TzlNVkpuUm8zajZ0VjNacnhxSUR4Kzg2V0wrb1E5VUxicnYrYndi?=
 =?utf-8?Q?iqPiaUJDcHd9rwzl6fYriuSLb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ffb3b1-543e-4245-b3d5-08dca5734082
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:42:40.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2v81bnQkM2er/6AyGlz1oNLyPWOHqvHhBIGbwysPgpeSremdh/En+LtnxnfmAhH0oJDtfVzgrXkR9oREKsC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101

Hello Ian,

On 7/15/2024 8:52 PM, Ian Rogers wrote:
> On Mon, Jul 15, 2024 at 2:36 AM Dhananjay Ugwekar
> <Dhananjay.Ugwekar@amd.com> wrote:
>>
>> Hello Ian,
>>
>> On 7/12/2024 3:53 AM, Ian Rogers wrote:
>>> On Thu, Jul 11, 2024 at 3:25 AM Dhananjay Ugwekar
>>> <Dhananjay.Ugwekar@amd.com> wrote:
>>>>
>>>> Currently the energy-cores event in the power PMU aggregates energy
>>>> consumption data at a package level. On the other hand the core energy
>>>> RAPL counter in AMD CPUs has a core scope (which means the energy
>>>> consumption is recorded separately for each core). Earlier efforts to add
>>>> the core event in the power PMU had failed [1], due to the difference in
>>>> the scope of these two events. Hence, there is a need for a new core scope
>>>> PMU.
>>>>
>>>> This patchset adds a new "power_per_core" PMU alongside the existing
>>>> "power" PMU, which will be responsible for collecting the new
>>>> "energy-per-core" event.
>>>
>>> Sorry for being naive, is the only reason for adding the new PMU for
>>> the sake of the cpumask? Perhaps we can add per event cpumasks like
>>> say `/sys/devices/power/events/energy-per-core.cpumask` which contains
>>> the CPUs of the different cores in this case. There's supporting
>>> hotplugging CPUs as an issue. Adding the tool support for this
>>> wouldn't be hard and it may be less messy (although old perf tools on
>>> new kernels wouldn't know about these files).
>>
>> I went over the two approaches and below are my thoughts,
>>
>> New PMU approach:
>> Pros
>> * It will work with older perf tools, hence these patches can be backported to an older kernel and the new per-core event will work there as well.
>> Cons
>> * More code changes in rapl.c
>>
>> Event specific cpumask approach:
>> Pros
>> * It might be easier to add diff scope events within the same PMU in future(although currently I'm not able to find such a usecase, apart from the RAPL pkg and core energy counters)
>> Cons
>> * Both new kernel and perf tool will be required to use the new per-core event.
>>
>> I feel that while the event-specific cpumask is a viable alternative to the new PMU addition approach, I dont see any clear pros to select that over the current approach. Please let me know if you have any design related concerns to the addition of new PMU or your concern is mostly about the amount of code changes in this approach.
> 
> Thanks Dhananjay, and thanks for taking the time for an objective
> discussion on the mailing list. I'm very supportive of seeing the work
> you are enabling land.
> 
> My concern comes from the tool side. If every PMU starts to have
> variants for the sake of the cpumask what does this mean for
> aggregation in the perf tool? There is another issue around event
> grouping, you can't group events across PMUs, but my feeling is that
> event grouping needs to be rethought. By default the power_per_core
> events are going to be aggregated together by the perf tool, which
> then loses their per_core-ness.

Yea right, maybe we need to fix this behavior.

> 
> I was trying to think of the same problem but in other PMUs. One
> thought I had was the difference between hyperthread and core events.
> At least on Intel, some events can only count for the whole core not
> per hyperthread. The events don't have a cpu_per_core PMU, they just
> use the regular cpu one, and so the cpumask is set to all online
> hyperthreads. When a per-core event is programmed it will get
> programmed on every hyperthread and so counted twice for the core.
> This at the least wastes a counter, but it probably also yields twice
> the expected count as every event is counted twice then aggregated. So
> this is just wrong and the user is expected to be smart and fix it
> (checking the x86 events there is a convention to use a ".ALL" or
> ".ANY" suffix for core wide events iirc). If we had a cpumask for
> these events then we could avoid the double setting, free up a counter
> and avoid double counting. Were we to fix things the way it is done in
> this patch series we'd add another PMU.

Yes, this seems like a valid usecase for event-specific cpumasks.

> 
> My feeling is that in the longer term a per event cpumask looks
> cleaner. I think either way you need a new kernel for the new RAPL
> events. The problem with an old perf tool and a new kernel, this
> doesn't normally happen with distributions as they match the perf tool
> to the kernel version needlessly losing features and fixes along the
> way. If the new PMU is going to get backported through fixes.. then we
> can do similar for reading the per event cpumask. I'd be tempted not
> to do this and focus on the next LTS kernel, getting the kernel and
> tool fixes in as necessary.

Makes sense, even though this approach will require more effort but it seems 
to be worthwhile as it would help things down the line (make it easier to have 
heterogenous-scope events within a PMU). I'll need to go through the perf tool 
to see how we can design this. I'll get back with an RFC series probably once 
I have an initial design in mind.

Thanks,
Dhananjay

> 
> Thanks,
> Ian
> 
> 
>> Thanks,
>> Dhananjay
>>
>>>
>>> Thanks,
>>> Ian
>>>
>>>
>>>> Tested the package level and core level PMU counters with workloads
>>>> pinned to different CPUs.
>>>>
>>>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa
>>>> machine:
>>>>
>>>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1
>>>>
>>>>  Performance counter stats for 'system wide':
>>>>
>>>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
>>>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
>>>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>>>>
>>>> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
>>>>
>>>> This patchset applies cleanly on top of v6.10-rc7 as well as latest
>>>> tip/master.
>>>>
>>>> v4 changes:
>>>> * Add patch 11 which removes the unused function cpu_to_rapl_pmu()
>>>> * Add Rui's rb tag for patch 1
>>>> * Invert the pmu scope check logic in patch 2 (Peter)
>>>> * Add comments explaining the scope check in patch 2 (Peter)
>>>> * Use cpumask_var_t instead of cpumask_t in patch 5 (Peter)
>>>> * Move renaming code to patch 8 (Rui)
>>>> * Reorder the cleanup order of per-core and per-pkg PMU in patch 10 (Rui)
>>>> * Add rapl_core_hw_unit variable to store the per-core PMU unit in patch
>>>>   10 (Rui)
>>>>
>>>> PS: Scope check logic is still kept the same (i.e., all Intel systems being
>>>> considered as die scope), Rui will be modifying it to limit the die-scope
>>>> only to Cascadelake-AP in a future patch on top of this patchset.
>>>>
>>>> v3 changes:
>>>> * Patch 1 added to introduce the logical_core_id which is unique across
>>>>   the system (Prateek)
>>>> * Use the unique topology_logical_core_id() instead of
>>>>   topology_core_id() (which is only unique within a package on tested
>>>>   AMD and Intel systems) in Patch 10
>>>>
>>>> v2 changes:
>>>> * Patches 6,7,8 added to split some changes out of the last patch
>>>> * Use container_of to get the rapl_pmus from event variable (Rui)
>>>> * Set PERF_EV_CAP_READ_ACTIVE_PKG flag only for pkg scope PMU (Rui)
>>>> * Use event id 0x1 for energy-per-core event (Rui)
>>>> * Use PERF_RAPL_PER_CORE bit instead of adding a new flag to check for
>>>>   per-core counter hw support (Rui)
>>>>
>>>> Dhananjay Ugwekar (10):
>>>>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
>>>>   perf/x86/rapl: Rename rapl_pmu variables
>>>>   perf/x86/rapl: Make rapl_model struct global
>>>>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
>>>>   perf/x86/rapl: Add wrapper for online/offline functions
>>>>   perf/x86/rapl: Add an argument to the cleanup and init functions
>>>>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>>>>   perf/x86/rapl: Remove the global variable rapl_msrs
>>>>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>>>>   perf/x86/rapl: Remove the unused function cpu_to_rapl_pmu
>>>>
>>>> K Prateek Nayak (1):
>>>>   x86/topology: Introduce topology_logical_core_id()
>>>>
>>>>  Documentation/arch/x86/topology.rst   |   4 +
>>>>  arch/x86/events/rapl.c                | 454 ++++++++++++++++++--------
>>>>  arch/x86/include/asm/processor.h      |   1 +
>>>>  arch/x86/include/asm/topology.h       |   1 +
>>>>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>>>>  arch/x86/kernel/cpu/topology_common.c |   1 +
>>>>  6 files changed, 328 insertions(+), 134 deletions(-)
>>>>
>>>> --
>>>> 2.34.1
>>>>

