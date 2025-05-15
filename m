Return-Path: <linux-pm+bounces-27193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB9DAB8369
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 11:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24594C08F2
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B8296D27;
	Thu, 15 May 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U107wH0c"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16951AA795;
	Thu, 15 May 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303080; cv=fail; b=rIuKEaQL6YduV4SQJxEE6HmeyOkuILNy92TJRANSDJ6fSmQgVBcCuj6keZIUP/L1i467Nj5N3X/qsrYU8/N0N56Z/uNr0552Bplq1jhViy1YXtiA1v4MB5AzCmOp1JDCHWpLazVg4cNdAzOwzF+IVCC+hpRQb/4fhHtjtRI0Rek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303080; c=relaxed/simple;
	bh=LH78ezRMMLRuNigfHZ2fX3xLv8D7hNqmSsNl0LIH+Oc=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=ZzGVpT8y/laBNsa97ifGTYoovWULk7VFMxRkZf7NT0ly70H9ozeW6SfuNCaVwnKiKX8iXuKTv0QZ/XGkTBbthnFO2JOV6kW8j9M7+OKqwG7VIkOPiYJIq6a+T3KC+yn/Mj8xW34Jln62/+5iwZRfTyKKQ1r0a35bI79f3rdMG5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U107wH0c; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVhK3kGuBFv1WjRRPOG3Mqzuezk1G0Ruo7YingzPYTFxv/30s54EWc54wpq6hitVN+ltNyMkjFl72WRkMfk0tMQoy7V2dCyAJPu8VSf+eCvpQqzxKmXZliv25uQ6JEjWj4THvflRpwBUw1CR+gXVhmhFHTrDEOyRKvUXNt1UP5SB4Klc+WmnpynAkrLBXLnF8/N4JLrDHHMbb8XsnRMrZm0Ewgq/FccKQxvp4zs23F5zmQA5cCXAPhTZmCDw3SwQ6G8oJeC2ZkimaEJQV9f8Ewiq7SJBLRz1P6wzIEoNfKpgM/GUOjk6CquVpbg+MgFJ7YjBvidrXP7p382noEzDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klVTQsVYEPld22ovHiovmQs7fnpeCKGaFIihQNEESfE=;
 b=D7BlFPQdfE5kFW7d+Gn6ueIweEOOz7Hfal0yeBc5BwcxKGhZ3Luvl7MxTwiD/c233Te+nY81VhEqWuJ8VjgsnNg5HcTOIJxGN94ujqJg597kD3i2i/W/AlmCykjlxJ39YyAvd7463CL3zIRBHts627Irn6/iqtsrnMz0cVX7enTCjHBNZDig8EBVmqxZqHOxVFQAu+0sevqVYGTTFzaFJoOw5Au5Lm6aHM/jnw/CpcgU9u9KaSVPmUnK7iM/6tBwnMkXsC46HtnuXU/ci35nqZ+ePNiua1sfEAsHN3Y79pHOP2j/xEHVkXNrdfCsPMcP1JZRAzAe/cF5x3Tc8ecKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klVTQsVYEPld22ovHiovmQs7fnpeCKGaFIihQNEESfE=;
 b=U107wH0cubRJR5gWwZqZiVdbbRwdpUz5FjAIl4JwPx5KLj3/M2F7EFK0bx7tFRIkytsuXbd9b1xP59wRmLu92xcYBo276Pd68yapCg0gQWcp0O85dc1PBZrmn0QNAEDG19p/rhkZobq7sMv/MZPWJworCHWqZBWoI3vXIq08yEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 09:57:55 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 09:57:54 +0000
Content-Type: multipart/mixed; boundary="------------QptxlLv00KUNveer0Kfjr1fE"
Message-ID: <eddc986d-62be-425c-8065-3cd5a3922026@amd.com>
Date: Thu, 15 May 2025 15:27:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/4] x86/mm: pgtable: Fix W=1 build kernel-doc
 warnings
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, rafael@kernel.org, pavel@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 yuntao.wang@linux.dev, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterx@redhat.com, sandipan.das@amd.com, ak@linux.intel.com,
 rostedt@goodmis.org
References: <20250514062637.3287779-1-shivankg@amd.com>
 <aCRMT0TlpFvpRGYk@gmail.com> <6c4b227e-abdd-4e7f-8abd-d85cae0f0ec3@amd.com>
 <aCRgRxmO6rsR-0k3@gmail.com> <c5ad88e9-434a-4399-8e21-3c41e9295e93@amd.com>
 <aCWPp4wYwauSuTed@gmail.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aCWPp4wYwauSuTed@gmail.com>
X-ClientProxiedBy: PN4P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::10) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: d70abd80-a7b3-493f-bca9-08dd9396f64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2d2T016bHl5ZjNXVWJCTklZSmlpb0QzbXh0OGF3blZzQUhWa2cvb0wxYlZ6?=
 =?utf-8?B?VjVpUVNQU1hyY215bUFtVHY4cHF2am4wenlTZFFWZjlWakhaa3ZvMWg5TVJr?=
 =?utf-8?B?eTkrU3B4czFDUzlXMVZmdmltdWcxd0s4b21rVTZ5VzdNalVnOUxnT3Jjc09w?=
 =?utf-8?B?TVkvcVA2Vy8yaGRZQnVTRDZVQWhwbnphbHRJS0VSSk9CWGxjaDZVV25xMnRC?=
 =?utf-8?B?Yk5ITzkrSnlEYS9zUEhyRG5xTVBPM3ZrRC84ejVXcUNKc0YvQjBxUFJpOW1B?=
 =?utf-8?B?WU9JTnpKUUtHMWlpM0JHNW9pdlZWaWNlakRvcDFMTE1yREloUjA5clB4L1JH?=
 =?utf-8?B?SHUxMktjcFVhMEd6MjBLak1SclFpWVFQbUNROWE4cGU0a0E5ME9EcXhNR04r?=
 =?utf-8?B?QjNxN1IzVjZNTGRyVHhrK3BidlFhSWRzbnFLV1BNVmJxRkNaOTZYWVRRdndU?=
 =?utf-8?B?U0U2QzkyR3RORFN3enBEbldrc3BqcmxaSnByWktpV0NNL2FjWllVZWNHeUMx?=
 =?utf-8?B?Zlh6QnlOSGZSaTljcS9TUWhpR0FxeWN2UzBodzlTSEZjVE1vNTM2bVhUWURP?=
 =?utf-8?B?R0pNOXJrb2RrSjhsa1I5eFdWQWlVaXFBZktoUTZHNGs2MG85S00zUWtPTkli?=
 =?utf-8?B?cnNuQTNiRy9oTzcyc2cyZTkvSWRRa0FwRm5lTjNEeElpTkkzdkxiYmIxcjVE?=
 =?utf-8?B?WFlTd1UvY0xTTDV3Q1d6YjJEQ2Z3TU9DcHRXbSt0OCsyQjFqYjJGSDNJNkd4?=
 =?utf-8?B?UTIveVVid09GeWgyNGFWcThxbWhjR1VaSUZ6YkhKZ01GaTZSSXFHV2htRGl0?=
 =?utf-8?B?dThlRGFJSVdsQ3o1N1lRL3RiaExjWVUvSkRmRDNRTjFwQWdRcXNIN3ZhUmcw?=
 =?utf-8?B?Q1hEbEdlWk9mdzNWdmd6WFNzdE9oNmVCcEFIRnQ5aGZ4UURGby9EbUtpQ0Ni?=
 =?utf-8?B?NVFVZEt5a1R6UzBwRjJyNDFWbjhTbGlaR2krZmpJOWJJdi9XZjBoYU9aWHI4?=
 =?utf-8?B?eU1VTmRtWnVOTzh5L2F0ZE9jaHZreVRBU1dlb2NtWFdLaWZ4TUoySW4xUUVH?=
 =?utf-8?B?NEtjZ0p4Z1hvSTMvR0ZoSGxVbW5jMGVsSDBrR3RWYWFDMG02ZDNsYnM0bGdR?=
 =?utf-8?B?dlN1bGFlWVpodVdGS1JUOTJ3NWhTN0QyOHZ1d0VuZmZMakl0TzhDRzkyajhC?=
 =?utf-8?B?ZEE4VVFhazR1Yk5HQnp6dG9WZzRWTWRYYzlvQU5YaDNFdHZIOUpMYTR6dGgx?=
 =?utf-8?B?Z3BkYmtEcW1WL0JoSGdiTzJwMmJjVnBsQmVTNFhCVC9hTDdrNURaTkIrZ21D?=
 =?utf-8?B?dkZvc1RhS3lZZkxHalBOY1ZNM2Z3RERjc1k0ajFlUGl1ZFd2dXorODBXMWhV?=
 =?utf-8?B?alVac0dZTVZnd2tmVklqN1hoNVkwU0pDZjZCbHQ0a1ZjSm5Qd3VDc0JoNk41?=
 =?utf-8?B?c1dtd054NWpiNWdqZENsQzU3djlyc1g1WXh3MDlLL2QwZGlBcktYWWZ2RVpR?=
 =?utf-8?B?eTRtNlZpODUveE16TUhEY2Q5S1FySjJTdXpNRjBCRWU5T3JKdHlJb2tsSWlJ?=
 =?utf-8?B?Tks4V05zb1NnQnFHWmQ4Y2twWkVQeG05ek45WUlHOWY1NFFFamtaOWJCdjBh?=
 =?utf-8?B?R0VXWjh1b01teXIzOFQ3K1lDQmlnb2VNcHRybU1rNm9aaE9VTmxYbS85TC9p?=
 =?utf-8?B?Nm9lRnEweCtnZ0hmOFFVcTE4Y1hsVFMvM3E5ekduSEwweXcrVWVCN082MG1J?=
 =?utf-8?B?c0pCQVVBd0R2N201Sy8wbFJDNjMxSnYzbEZzNkNqMG5hL1NEK1RucElrL3JB?=
 =?utf-8?B?enFVazdDTkVNWVM2ckNWSFNIYlNSSmxxSkJQbTkwM1RKaW5ZZys0VDRFck82?=
 =?utf-8?Q?znhFlsF3t+zDl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHpEN1RrL0ZFdGhDSVRPYzlvWjF4b1ZaTllaRE04NmkzUlduYkFKU0hRdzc3?=
 =?utf-8?B?SWtJWlA4K2JVTjlLclJDT2I0QWIva0dqeDlqakFKbjErR3AxOExkc0ltOG0r?=
 =?utf-8?B?VUZkRUN4RG9DSmUwZGpQdDkzYVNuQm1ndEQzTVEwUlBoeFdIZWNaTCtqRUVr?=
 =?utf-8?B?VUcwY1pGYUVPUWFhd0JSUW50RHVqeEJNWWhZZDJGMnppOGI0bW44RFhOMWEr?=
 =?utf-8?B?aVd5U1B0RWpZWGdXM0V0WTJRZTJPZ0V2L1NoNmxLVldwRGtTSkxOMzFsam9M?=
 =?utf-8?B?aGNXVDhnSkNoY2hjeUhabDZRL2JpWnRWd0tXVW1STTd3VzQzUG5iZnRzbHAw?=
 =?utf-8?B?OFZZb0FOeGhuQjJVSHBFOHIzR1lWMjFzME1KRUVNekYyS0l1K0FEai9qdWlo?=
 =?utf-8?B?dld2ODFlZzFKS3FONlNTSnA0TzE5Z2drTW1TeksvcWlHTDM3amYwdS9ya24y?=
 =?utf-8?B?RVZmTVEvbGEzTFMvZE1FalRzN2dzZFViRjZRSEc1OHo0b2p0TXhBZlJxcmYy?=
 =?utf-8?B?eXlnczZBZkhZUmtIRkVldXdCQ0k1QXN3SHM4aG5lb2FPWGQ3cXBDaXM4SnhI?=
 =?utf-8?B?clppclN6STg2TUhjWEVRVVNUbkJzaXp0SlhORzFmRVo0ZjdpVlVjZXFwUjNz?=
 =?utf-8?B?VUxLaS9LYy9ac05KeXVSaDlvdWZydGY5UFhtK1NaSjdqNmRKT3VHS1p1SWNq?=
 =?utf-8?B?NkhhWXc2a281cWxrZzR2YjhiMlVjMnAzWjh5NlFGU0NXRUdLQUZHYmFlcnBF?=
 =?utf-8?B?c2M2ejRWWWFqWjZrSUZSV25ZMUtucXdWWFRNdGpsUFhldk0yQklWenR6RWN0?=
 =?utf-8?B?NmhEMVN1UkpnbTZOUFVRbE1RclFqM2FCL3ZEZ3FCOFQzQ0VYaG56NWlUQkZI?=
 =?utf-8?B?aDNMYkhMN3hVdUVyOFE1Y0gxWVVibzJrRzZPajA2K0xCM0xhZ3U1T01jOS9q?=
 =?utf-8?B?R3FDdEZoSFdGY2J3a3FTdTNlaURWQWlvV0NxZ2lJbGFQdk5qVjVZSno2TG9q?=
 =?utf-8?B?WkJueDBHajFnVUdxeFJILzFvVmVLcThuK1BzTmtCYmExR2RSSG1CZFZ0NE1R?=
 =?utf-8?B?cTBJMjhSYTlNMHIyZDNwaW5PRTBNalhWbzhWNWdnZEtzWHRrTm41aDNSMkdO?=
 =?utf-8?B?RTRqY0JyOGJjdW53YVI2UzFWS2JYazI2S3BZNzU4MVFqM3Z5VEVOT0k5Njhr?=
 =?utf-8?B?eEtVbmVpOVJDU3B3dVFNU0JhRWc1RWUyY1gwb0ZxSlIrdGo5bEdhbkwrclRF?=
 =?utf-8?B?TlozTmNrWEpJMWxvalc3RjJ1dmNCWDkzVDNaVnFVK2x2aGUweHhGTXRPSWVG?=
 =?utf-8?B?aWFISXlSQXozZUVSelBxcXhRYzdiNmVLVlB1STQ3WUJrUnlPTGZmd3lFY0JK?=
 =?utf-8?B?M0ZmZTVzcGVmdFlsQWQ4bU5ZS083TUZRcmNwYS9zTTRMQkQ4bGJJaVhaaXRL?=
 =?utf-8?B?bUdWZlFHbE1NV01JVXBPYWlzMnJsbUZ0NXF4YjBzOTJJbW5xR2NIMldTMTU2?=
 =?utf-8?B?emRJZmljbzMreXN3ZVZDVnlnNkdlcUxsZ21hdndWQnlRdDVyUTFxT2lFbTht?=
 =?utf-8?B?RW9pMmdmWVZPcjZXdlM5a3dUcTA1YWtmVEduSDFJR0ZhNnRkQTJsakVveGxG?=
 =?utf-8?B?cVBJdUNuRURzdDJpYm5TL05pUlNuSkZDbHNSSGRyTTZyTVNXUVVqUWl0Ry9L?=
 =?utf-8?B?amU1eUh3UTJVaTFwSy9mRUZRMFJiQnFHT2hhZVM1YU5FMzdBRFRnSUlveGVL?=
 =?utf-8?B?SStoWjdvbncrZWNvMnlrTGE1a0tvREZQSXlpaEZlam1iZW1lUW51aisraXBP?=
 =?utf-8?B?cDRGSmRDRTA4OVJXWUVjN0h3T0J0RjlHanBOa1NOb3QrN0tvR0JPTU4yTGgv?=
 =?utf-8?B?a05VclBhS3FNRnk2bHVpY2FVQmsrR0FsbkFrTGxLUTJwSUNjeGU0Y2FSVW4r?=
 =?utf-8?B?TU9DK3ZoSWcyU2xWNjhFY0R3WjhaMksrYkNaRnhwQ2dFbWxTaThvTnNPVHNw?=
 =?utf-8?B?eHZOWkUwR21LRXkvalRSOGRSaE1wRTJsWjh3VE5TK3hteElaMkdOUUQ0VllS?=
 =?utf-8?B?c0Z2T28vYlJBbyszK21uL3UrUjVodmcrZVpwWEQ5TlVRdVJCSHNaTmZWVTJt?=
 =?utf-8?Q?K62CyWsEBPxowihMsGAN9bsBx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70abd80-a7b3-493f-bca9-08dd9396f64f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:57:54.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UinbRkcY2HPnA/Vqedbpk9rev86QxHlap3chK3qY/yFyH1OPVHzOHCh6E3zjun4gUbLHaklMgWQXKirlINdYrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292

--------------QptxlLv00KUNveer0Kfjr1fE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2025 12:24 PM, Ingo Molnar wrote:
> 
> * Shivank Garg <shivankg@amd.com> wrote:
> 
>>
>>
>> On 5/14/2025 2:50 PM, Ingo Molnar wrote:
>>>
>>> * Shivank Garg <shivankg@amd.com> wrote:
>>>
>>>>>> @@ -665,6 +665,9 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
>>>>>>  #ifdef CONFIG_X86_5LEVEL
>>>>>>  /**
>>>>>>   * p4d_set_huge - setup kernel P4D mapping
>>>>>> + * @p4d: Pointer to a p4d entry.
>>>>>> + * @addr: Virtual Address associated with p4d.
>>>>>> + * @prot: Protection bits to use.
>>>>>
>>>>> How about using the same capitalization you already see in this 
>>>>> description?
>>>
>>>> Please review the revised patch with suggested changes.
>>>
>>> I think you misunderstood: why are you using 'p4d', while a line before 
>>> it's 'P4D'? It's an acronym, and only used lowercase when it's a local 
>>> variable. 'p4d is a pointer to a p4d entry' is doubly confusing in that 
>>> regard ...
>>>
>>> Same for PMD/PUD etc.
>>>
>>
>> Thank you for the clarification. I understand it now.
>> I hope the attached patch looks good now.
> 
> No. Please re-read your patches and see whether you caught everything, 
> not just the things I pointed out ...
> 
>>  /**
>>   * reserve_top_address - reserves a hole in the top of kernel address space
>> - * @reserve - size of hole to reserve
>> + * @reserve: size of hole to reserve.
> 
> And here the original capitalization in your -v1 patch was better.
> 
>>   * p4d_set_huge - setup kernel P4D mapping
>> + * @p4d: pointer to a P4D entry.
>> + * @addr: virtual Address associated with p4d.
>> + * @prot: protection bits to use.
> 
> Why is 'address' capitalized here?
> 
>>  /**
>>   * pud_set_huge - setup kernel PUD mapping
>> + * @pud: pointer to a PUD entry.
>> + * @addr: virtual Address associated with pud.
>> + * @prot: protection bits to use.
> 
> s/pud
>  /the PUD entry
> 
> Also, similar errors are elsewhere as well.

I'm sorry for missing these details in the previous revision.
I'm changing the first letter of variable description to capital.

https://docs.kernel.org/doc-guide/kernel-doc.html
/**
 * function_name() - Brief description of function.
 * @arg1: Describe the first argument.
 * @arg2: Describe the second argument.
 *        One can provide multiple line descriptions
 *        for arguments.

Function description also starts with capital letter in the doc-guide
and other kernel places so this should make it consistent.

Thanks,
Shivank






--------------QptxlLv00KUNveer0Kfjr1fE
Content-Type: text/plain; charset=UTF-8;
 name="0001-x86-mm-pgtable-Fix-W-1-build-kernel-doc-warnings.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-mm-pgtable-Fix-W-1-build-kernel-doc-warnings.patch"
Content-Transfer-Encoding: base64

RnJvbSBjNzZkZDQ1ZDJjYzgyMjE0MTJkNjljZWRlNGZkNzEzY2U3NzVlZTY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+CkRhdGU6
IFdlZCwgMzAgQXByIDIwMjUgMTE6Mjk6NTkgKzAwMDAKU3ViamVjdDogW1BBVENIXSB4ODYvbW06
IHBndGFibGU6IEZpeCBXPTEgYnVpbGQga2VybmVsLWRvYyB3YXJuaW5ncwoKU2FtcGxlIHdhcm5p
bmdzIGdlbmVyYXRlZCB3aXRoICdtYWtlIFc9MSc6CmFyY2gveDg2L21tL3BndGFibGUuYzo2MjM6
IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdyZXNlcnZlJyBu
b3QgZGVzY3JpYmVkIGluICdyZXNlcnZlX3RvcF9hZGRyZXNzJwphcmNoL3g4Ni9tbS9wZ3RhYmxl
LmM6NjcyOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Igc3RydWN0IG1lbWJlciAncDRk
JyBub3QgZGVzY3JpYmVkIGluICdwNGRfc2V0X2h1Z2UnCmFyY2gveDg2L21tL3BndGFibGUuYzo2
NzI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdhZGRyJyBu
b3QgZGVzY3JpYmVkIGluICdwNGRfc2V0X2h1Z2UnCi4uLiBzbyBvbgoKQWRkIG1pc3NpbmcgcGFy
YW1ldGVyIGRvY3VtZW50YXRpb24gaW4gcGFnZSB0YWJsZSBmdW5jdGlvbnMgdG8KZml4IGtlcm5l
bC1kb2Mgd2FybmluZ3MuCgpTaWduZWQtb2ZmLWJ5OiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFt
ZC5jb20+Ci0tLQogYXJjaC94ODYvbW0vcGd0YWJsZS5jIHwgMzAgKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMgYi9hcmNoL3g4Ni9tbS9w
Z3RhYmxlLmMKaW5kZXggZjdhZTQ0ZDNkZDllLi5kYzU1ZTRkNGMyMjYgMTAwNjQ0Ci0tLSBhL2Fy
Y2gveDg2L21tL3BndGFibGUuYworKysgYi9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMKQEAgLTYxMyw4
ICs2MTMsOCBAQCBwdWRfdCBwdWRwX2ludmFsaWRhdGUoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEsIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywKICNlbmRpZgogCiAvKioKLSAqIHJlc2VydmVfdG9w
X2FkZHJlc3MgLSByZXNlcnZlcyBhIGhvbGUgaW4gdGhlIHRvcCBvZiBrZXJuZWwgYWRkcmVzcyBz
cGFjZQotICogQHJlc2VydmUgLSBzaXplIG9mIGhvbGUgdG8gcmVzZXJ2ZQorICogcmVzZXJ2ZV90
b3BfYWRkcmVzcyAtIFJlc2VydmVzIGEgaG9sZSBpbiB0aGUgdG9wIG9mIGtlcm5lbCBhZGRyZXNz
IHNwYWNlCisgKiBAcmVzZXJ2ZTogU2l6ZSBvZiBob2xlIHRvIHJlc2VydmUuCiAgKgogICogQ2Fu
IGJlIHVzZWQgdG8gcmVsb2NhdGUgdGhlIGZpeG1hcCBhcmVhIGFuZCBwb2tlIGEgaG9sZSBpbiB0
aGUgdG9wCiAgKiBvZiBrZXJuZWwgYWRkcmVzcyBzcGFjZSB0byBtYWtlIHJvb20gZm9yIGEgaHlw
ZXJ2aXNvci4KQEAgLTY2NCw3ICs2NjQsMTAgQEAgdm9pZCBuYXRpdmVfc2V0X2ZpeG1hcCh1bnNp
Z25lZCAvKiBlbnVtIGZpeGVkX2FkZHJlc3NlcyAqLyBpZHgsCiAjaWZkZWYgQ09ORklHX0hBVkVf
QVJDSF9IVUdFX1ZNQVAKICNpZmRlZiBDT05GSUdfWDg2XzVMRVZFTAogLyoqCi0gKiBwNGRfc2V0
X2h1Z2UgLSBzZXR1cCBrZXJuZWwgUDREIG1hcHBpbmcKKyAqIHA0ZF9zZXRfaHVnZSAtIFNldHVw
IGtlcm5lbCBQNEQgbWFwcGluZworICogQHA0ZDogUG9pbnRlciB0byB0aGUgUDREIGVudHJ5Lgor
ICogQGFkZHI6IFZpcnR1YWwgYWRkcmVzcyBhc3NvY2lhdGVkIHdpdGggdGhlIFA0RCBlbnRyeS4K
KyAqIEBwcm90OiBQcm90ZWN0aW9uIGJpdHMgdG8gdXNlLgogICoKICAqIE5vIDUxMkdCIHBhZ2Vz
IHlldCAtLSBhbHdheXMgcmV0dXJuIDAKICAqLwpAQCAtNjc0LDkgKzY3NywxMCBAQCBpbnQgcDRk
X3NldF9odWdlKHA0ZF90ICpwNGQsIHBoeXNfYWRkcl90IGFkZHIsIHBncHJvdF90IHByb3QpCiB9
CiAKIC8qKgotICogcDRkX2NsZWFyX2h1Z2UgLSBjbGVhciBrZXJuZWwgUDREIG1hcHBpbmcgd2hl
biBpdCBpcyBzZXQKKyAqIHA0ZF9jbGVhcl9odWdlIC0gQ2xlYXIga2VybmVsIFA0RCBtYXBwaW5n
IHdoZW4gaXQgaXMgc2V0CisgKiBAcDRkOiBQb2ludGVyIHRvIHRoZSBQNEQgZW50cnkgdG8gY2xl
YXIuCiAgKgotICogTm8gNTEyR0IgcGFnZXMgeWV0IC0tIGFsd2F5cyByZXR1cm4gMAorICogTm8g
NTEyR0IgcGFnZXMgeWV0IC0tIGRvIG5vdGhpbmcKICAqLwogdm9pZCBwNGRfY2xlYXJfaHVnZShw
NGRfdCAqcDRkKQogewpAQCAtNjg0LDcgKzY4OCwxMCBAQCB2b2lkIHA0ZF9jbGVhcl9odWdlKHA0
ZF90ICpwNGQpCiAjZW5kaWYKIAogLyoqCi0gKiBwdWRfc2V0X2h1Z2UgLSBzZXR1cCBrZXJuZWwg
UFVEIG1hcHBpbmcKKyAqIHB1ZF9zZXRfaHVnZSAtIFNldHVwIGtlcm5lbCBQVUQgbWFwcGluZwor
ICogQHB1ZDogUG9pbnRlciB0byB0aGUgUFVEIGVudHJ5LgorICogQGFkZHI6IFZpcnR1YWwgYWRk
cmVzcyBhc3NvY2lhdGVkIHdpdGggdGhlIFBVRCBlbnRyeS4KKyAqIEBwcm90OiBQcm90ZWN0aW9u
IGJpdHMgdG8gdXNlLgogICoKICAqIE1UUlJzIGNhbiBvdmVycmlkZSBQQVQgbWVtb3J5IHR5cGVz
IHdpdGggNEtpQiBncmFudWxhcml0eS4gVGhlcmVmb3JlLCB0aGlzCiAgKiBmdW5jdGlvbiBzZXRz
IHVwIGEgaHVnZSBwYWdlIG9ubHkgaWYgdGhlIGNvbXBsZXRlIHJhbmdlIGhhcyB0aGUgc2FtZSBN
VFJSCkBAIC03MTUsNyArNzIyLDEwIEBAIGludCBwdWRfc2V0X2h1Z2UocHVkX3QgKnB1ZCwgcGh5
c19hZGRyX3QgYWRkciwgcGdwcm90X3QgcHJvdCkKIH0KIAogLyoqCi0gKiBwbWRfc2V0X2h1Z2Ug
LSBzZXR1cCBrZXJuZWwgUE1EIG1hcHBpbmcKKyAqIHBtZF9zZXRfaHVnZSAtIFNldHVwIGtlcm5l
bCBQTUQgbWFwcGluZworICogQHBtZDogUG9pbnRlciB0byB0aGUgUE1EIGVudHJ5LgorICogQGFk
ZHI6IFZpcnR1YWwgYWRkcmVzcyBhc3NvY2lhdGVkIHdpdGggdGhlIFBNRCBlbnRyeS4KKyAqIEBw
cm90OiBQcm90ZWN0aW9uIGJpdHMgdG8gdXNlLgogICoKICAqIFNlZSB0ZXh0IG92ZXIgcHVkX3Nl
dF9odWdlKCkgYWJvdmUuCiAgKgpAQCAtNzQ0LDcgKzc1NCw4IEBAIGludCBwbWRfc2V0X2h1Z2Uo
cG1kX3QgKnBtZCwgcGh5c19hZGRyX3QgYWRkciwgcGdwcm90X3QgcHJvdCkKIH0KIAogLyoqCi0g
KiBwdWRfY2xlYXJfaHVnZSAtIGNsZWFyIGtlcm5lbCBQVUQgbWFwcGluZyB3aGVuIGl0IGlzIHNl
dAorICogcHVkX2NsZWFyX2h1Z2UgLSBDbGVhciBrZXJuZWwgUFVEIG1hcHBpbmcgd2hlbiBpdCBp
cyBzZXQKKyAqIEBwdWQ6IFBvaW50ZXIgdG8gdGhlIFBVRCBlbnRyeSB0byBjbGVhci4KICAqCiAg
KiBSZXR1cm5zIDEgb24gc3VjY2VzcyBhbmQgMCBvbiBmYWlsdXJlIChubyBQVUQgbWFwIGlzIGZv
dW5kKS4KICAqLwpAQCAtNzU5LDcgKzc3MCw4IEBAIGludCBwdWRfY2xlYXJfaHVnZShwdWRfdCAq
cHVkKQogfQogCiAvKioKLSAqIHBtZF9jbGVhcl9odWdlIC0gY2xlYXIga2VybmVsIFBNRCBtYXBw
aW5nIHdoZW4gaXQgaXMgc2V0CisgKiBwbWRfY2xlYXJfaHVnZSAtIENsZWFyIGtlcm5lbCBQTUQg
bWFwcGluZyB3aGVuIGl0IGlzIHNldAorICogQHBtZDogUG9pbnRlciB0byB0aGUgUE1EIGVudHJ5
IHRvIGNsZWFyLgogICoKICAqIFJldHVybnMgMSBvbiBzdWNjZXNzIGFuZCAwIG9uIGZhaWx1cmUg
KG5vIFBNRCBtYXAgaXMgZm91bmQpLgogICovCi0tIAoyLjM0LjEKCg==

--------------QptxlLv00KUNveer0Kfjr1fE--

