Return-Path: <linux-pm+bounces-36580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD5BF7135
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44F8E35317D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBEB3396F1;
	Tue, 21 Oct 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e0aGeSal"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204432BF59;
	Tue, 21 Oct 2025 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056967; cv=fail; b=sd01mKt/09CXe/WyUujcTDZuT/qSAH4AX/kgNqcOzY8FGV7YYX6QTJB4uSAz74+MvjFQrmxec3iiOyj5v3cgiGWXdVzKkaZ0mM+pkbrJqSaeJEee8FkMRWNQMLDKyvQpBpCFi3ITNAA4hMpVy6YeuEaTGg9kG23j1K3trEMLXy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056967; c=relaxed/simple;
	bh=tM+NtWh+t+T8tf6Hgk09Yte4HYzjLad484zKtnjIcRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P3nzXQiAA/e3w+YhiYhbti2F2zcaBtUKTW7/J5//pDiBnzKX3IysHV5J7+NpD1OP+1uhOQIJhY+ELZyFnHhcXKvnqt1KNJPDouhTwtMMAUBaBq9ea6eCjvjAI7kF6PJYIFy3XXc/MQVfJHvxma/oHdflC04FgWSyO3ji9tKR6nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e0aGeSal; arc=fail smtp.client-ip=40.107.208.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwXOK5At3qg4Pq/MnoVKtlt06n6d0hdaJsGR+zbeK71u39nKiYoVu1C8XvMCgU5S3ppvYOAxOW6Mh/OlpL8/e1rJbySJziVI4gTh4QZNf1vAZOoU3z8MChxcOJbAfEazeJPjTKLJHm94SyQp3BKLmcFgxW4r2lLSIt2QqtOmALrOTVRFjnldJSITsBFXcA211IEIQv/TDuWKDYGMTnuoLjfVGN/Bdv982XN3TMGKklWJmDultTu5il8MtcLHnG8UTtQhxcyinRgn/XZ/zwFbwesXJ8HO2e7/zNrwFQDd+9wLaCm+ryx8GeKuqShjRXtXfffIsic6SD2bujFPf4n4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak5QX/u8vHwGZ4BX/uL9vnuZlCKwbef88djoO2q4D+o=;
 b=T+uAxaiB+pRodesFaddi8m1UaCz6v3/XnvTel+EgJwzpCV+gektofG8Lf2mnYSP9LpjUk5ILwTGH3r/3ymVy/ZGq6Lu8S7naCiiVSK9IyO2BgPAViWhvvXhoxwfA5vSZe/jMuNq1B6jMgEC0YG+vseUiY8P9EQrbFyyB8n2QlUT18fmbNSJ8dLfSqiue0IQFEhSYDjkEWN+KvSHcN0icuWiFyFN0hdUuYsMzZlPvcaDpI2i1cfAfH8zALuM9y/QoiaiPSPWd/xTZT+mQ2J/3m7D+hVPrX1BI1XzXyq+AhDLT/md3KQt0VWDz2sj+QfxwFB6p2BZ3ucCXACSlWy86nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak5QX/u8vHwGZ4BX/uL9vnuZlCKwbef88djoO2q4D+o=;
 b=e0aGeSalbH+B3CH20+MYPAoMfnCyfcP6fZFcto6Zbb8NoSPMH8illV+d5xvc/tW8NC6cbM18i20qokd8iQ0A54l3uwlxU7lom9ikgiQCeTUKNg1C6FfQLzrTjP7x5NPxq0apOfD5ktTHcWX9mv0CRrxSGpQB6nlhABQsVng0M/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 14:29:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 14:29:20 +0000
Message-ID: <e27d0392-11c4-4b9e-8ada-9db73f47dddb@amd.com>
Date: Tue, 21 Oct 2025 09:29:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] "Wakeup event detected during hibernation"
 on Dell Precision 7780 (was "[PATCH v4] PM: hibernate: Avoid missing wakeup
 events during hibernation")
To: Askar Safin <safinaskar@gmail.com>, chris.feng@mediatek.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: chetan.kumar@mediatek.com, hua.yang@mediatek.com, len.brown@intel.com,
 liang.lu@mediatek.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, pavel@ucw.cz, rafael@kernel.org,
 stable@kernel.org, ting.wang@mediatek.com,
 regressions <regressions@lists.linux.dev>,
 DellClientKernel <Dell.Client.Kernel@dell.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20231213083251.186935-1-chris.feng@mediatek.com>
 <20251021125446.4384-1-safinaskar@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251021125446.4384-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:806:d0::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b432639-ad41-48b7-288f-08de10ae3910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzlWSG91N3FTTEZnRUdKMVE3ajBnbUlLVEErN256bWxLdWkxSWVDYlBqcFVS?=
 =?utf-8?B?Q2I0MU8wU1BSd205OWxoYzMydU5CV0grZnk2RjhKNjZqM2hQSjNpYWpCY0ph?=
 =?utf-8?B?ZjIzeTN5dWRjSTJNUG4yN0Q5S1B5ZUpRSFM5b1RoSzA0N2N1WEZPMUVQZE0x?=
 =?utf-8?B?TVZ6WkZ2cnh6akFVVDB5N3NEMHMyOEFTeDEwbkRrRWNCUXh3Q2hESXFoQjZx?=
 =?utf-8?B?bXQxdzdscHBUREUzaVdSd09LY2w1VEdkVDIwdDhvdnhYNzdVekc4SmZiVDRE?=
 =?utf-8?B?am1ZeUk5dEF3aUN5TlpUQnFQQUhoa0RHbTR6eHcyTStXTDBmQW1PTjQ5M25I?=
 =?utf-8?B?VVIzLzNZeXpZRjhtcE8rNnBVckMycUVLSHpQOUVTZzFQU0ZpemVpQ3kwd0Nr?=
 =?utf-8?B?S1FXR08vYVR0ZXgyTVdtZGJIRVV1NDZsdUhOOHpzbDg2NEZqeWo3cVltTy9q?=
 =?utf-8?B?eWw5TDR1OGZJTS8yQ3FkWUgzenpYSVJsZHJxTVdRK0FTODZYNVRNRkxnZDZH?=
 =?utf-8?B?UjZxQ2Y4b0VQN2Z2MEcwekhJRldUWFNncC9DQXBRVU9vMG9TYjN2Y3JwMHFD?=
 =?utf-8?B?LzF5ZHhUSFg1VVV6Rlp1d3gxSW1HNE8rU0RJbGpGSWNJY1YwS21JeXdoTEFp?=
 =?utf-8?B?bGdoYmwyWmlKTUdoaDhPdVJyOHlyNUQrbk9hb1VjdHlNVG1YYlhodFcxZ2Qv?=
 =?utf-8?B?QnVhQjg1RkRRdFg0eGQzTm1QWWtEdFJHZGkvdnBpaXN6QWEyUFhmYU8vWnQz?=
 =?utf-8?B?L21YcGtnbjZ5aWxXa3RGWEVsZG9MTGxvcXlySk9HOHFyc0Y0ME9jdWR6MFdP?=
 =?utf-8?B?R1dPLzJsZWpnZzcyRkcyNVM4TVh3WTNkYm9rcFdZUEhPaGJtMEJmQXEvU00v?=
 =?utf-8?B?TXZYZkw5a1NTR1MrZlRLcEo5Wk9STXl5ZTQyaEhybGoraklFSDN3SzB4ZW11?=
 =?utf-8?B?TzVkZ0pzQjIvUk8vOFk0ajM1aEc1K3IyWFB6eWZaaTJDOVZMYmVkZ0Q0SDUr?=
 =?utf-8?B?a0l6a1RkVFlCcklsZUpRZjVxV0RTaTFSS1Fxd24yeUl4eG11cW81ZnBMTzRI?=
 =?utf-8?B?NXRGVjZxMVBOTEFpMEFzQUlEdTBFSUVqc1dDN1QyVUt1ZlAyN3Yxb3Ftb0Ro?=
 =?utf-8?B?WlRNVFBkWDNxVmRuT2h6VkxaUlFCNzF3NWxTVkJ2cnNYNndVNDh2bEdzTGpv?=
 =?utf-8?B?M3NNWmcyQkJFUUgveEcraDFUSFZXTm5URTdoRGNyc2ovQndnTGQ3U1hGSmlL?=
 =?utf-8?B?Z0k2dk44QmQyK0RxMkdscjJoREhqWVFsay9LZUQySURCU25XZk9PS3V6NUp4?=
 =?utf-8?B?Y1JJTVQvL3h4TlhrNFNETDlZdHhOcTBPalZmWGJLWnhMWVo3Z3lUcDdXOWRU?=
 =?utf-8?B?L0RNWWo4VmlkOUJ2Yi9TR1JETG1neVcrbGlBWmQwSFJNcnQzZkFCTUhWTGdU?=
 =?utf-8?B?a2NnTDJqbHFQRUVlZld0NkdPUGdvcUc1ZCtKUlQ0OGRSc3FLME5qR0w0UnZK?=
 =?utf-8?B?ejFnWnVIMnpXeTAyQklrWXNiek5hcXFwQm01ZDFPL2thOHJMUkhQdFhUMHgz?=
 =?utf-8?B?U0Y2b3RMSVBvOFFsck05TjVSM29KRFoydUJmZXhpYmJjeTNSbWpKTlV6Tjg1?=
 =?utf-8?B?YmZYWjBjLzFkbDlZR0JtSDhSR1orcERoQ0dHRmVNVFo1dk9jSFlZT2RBL2hQ?=
 =?utf-8?B?QTYzTmJGcHJpUHBIOUpPTDNsbFVlRkZKU1hkb2g4T3h1RmMxeGNHdUVLL0NL?=
 =?utf-8?B?TlY1dnEyR2hYZllvMWxzd3dDOXo4M0R6VU1aZUJtUjAwSnBCVE1PYmhHZS9a?=
 =?utf-8?B?aTh6cGNBU0RFczZwSlpqejhKcExxRUhHVk5aVEVMQ0cwSHVjcmtSN2RZZnVE?=
 =?utf-8?B?V3cyV1I1QS9uZkxPVzUySFlseGdhQi8vaW5CSEV4Yk1MZVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUsvWWZPcER5eDVHQk5tN09TK2t0MmNtYzltMVpyTC9XLzVCWFNkSmkwQTF5?=
 =?utf-8?B?S1NCTXFWTnZ6bEdyRzBwY0w0aDlObE8vQXVOeGRHU2syOUFVNGNmOVhxN1NS?=
 =?utf-8?B?b2Y5UkRncUNVemNucnhDcUc5OWtseHNPT2Z5ZkN5QWk4YkFTdDBnOTRCWWhB?=
 =?utf-8?B?UE94MDJlYjh3NXFReHU3cTJqYWVIVWZHeVpoUjlzN2ZUYWE0aTNOR3Y5M1M0?=
 =?utf-8?B?OTV2NWl2RnNxYWdYT0dXQjFFb3hIOVRtSTBZR3BuTTFYYXVWTkV5WGVVdHVh?=
 =?utf-8?B?TjgyN0xoQ21OSHBSR3NmRUtuakI1WkRqTUh1UkR2T0NnSFNZeGRJZHVjZkRp?=
 =?utf-8?B?dDlBblY2SmVCWnVHc1cxd29PeHE5S1NsNjdoQ0VzOTBhTmtvcThxemRhSVFz?=
 =?utf-8?B?aENqUHo0OVhGQVV5bUYvTDhZM2NhbS9KWERmL3dUUkVDRHJVZnhTN1dYZmNT?=
 =?utf-8?B?bGJvSUU4SFN5ZG1TS0U5VjdWWk8rcWZFaWN1Y2NRYkVpKzMyVjIwZ0RRU1RZ?=
 =?utf-8?B?UzR5VFB5TEFnVFF6TEdSaDR4UTV4Mkx4dm0xRFRBczJuVDY3RG1FdnBVVnc1?=
 =?utf-8?B?Y0lKb3pEMFFIYVU0dnhiYjdQNE84OXdWdTNjWlZJcURla3pwd2p2alR2UFY5?=
 =?utf-8?B?YkowekVtVi8xb2xiWUlRSkZrelBvc3RoMGhPdFkyanN6STNvYk15cWlWdHZG?=
 =?utf-8?B?ek9iaFI2anhGVnk5N0JHc2FtdTJVTE5sNmEwZWVDenhSVUhjMUY3WmlCZTVC?=
 =?utf-8?B?NTNHQTNtQTk2RGZvUVZaTURWeFJtckdkVVpPY28xNmJwUnJEVDVOaVl0RHVH?=
 =?utf-8?B?OU9SdG52TlBnangxOXZBNnB2NEtLd1llbnVyTE1qc3EwVG95SFdJc0hRbEp2?=
 =?utf-8?B?Q2NycG5SdytHWm5LZGF1YWZWRzhyZ0RsR1Q5ZXZsOHNqYmZNekxIYWtOUkY1?=
 =?utf-8?B?Z25kZ0RiUlJqaXZlcEgydm9xOFRpd0pyNW92SzBzUEtiZ0pIbncyR3dqTE5j?=
 =?utf-8?B?cyt4UHUrWUFFZ2ZERHdUb0E5Y2RxaXZmVXFmMHpRNHo1VFl3RXgzNE1XTkdE?=
 =?utf-8?B?ZHBsQURUQ2prZXJQbmRqVndRNEh2UGZEK2V2WndwQ01JNUdNdllISlcwdzBG?=
 =?utf-8?B?YVhiRzJ3RERFZmw0MG5hMEd1WW4zRCtycmtwWkwxOWQvN3RYeGZhY20xWDA2?=
 =?utf-8?B?M3lvVTdNNkVwZDhoZnBZWngwaG9OaitsYkdxeTFGMDNWWmRIeTZnMnhLTksy?=
 =?utf-8?B?ZnRnU05CN3J2L3dWNm1rM0ppczJEQWd2UnIyV2lhMy8xUzdSWmVhYjN4YzN2?=
 =?utf-8?B?TUxzN2tVTm1pOGhTYkU1K3Y2cDIzWFRvZjJRbER0NTIzRFRnWHo4NmhYNmJi?=
 =?utf-8?B?b0tCNjJ2cW9IQ2JjQXNwdk9iMEhXTHl6NitKRTRxSkMrbjd6UlVKTnRTUzdV?=
 =?utf-8?B?djh6K0NlU2l3UFVNRXlOSEJDTVhZQmFCVEVaYnpKa01sWWJURjNSdkJxQ0dH?=
 =?utf-8?B?WUpENE50N2xOMzNqNVpIL2NPREEyVHBCWDl2Ri96TFBORUhWOTlWS0RuRlgw?=
 =?utf-8?B?Qk1vQTVhZXN2VmNKRlZyTzVnY1ZIWXdKZ2dkNGc5QU9DRFloMFlVam9CeWRJ?=
 =?utf-8?B?bVhHdENEZXZOSEZNZlpJU1ZVaml4NGxzOHBORDRxVG41cWhHbkxUTC9Vdmhz?=
 =?utf-8?B?bmxqOXA0aTBobDk4dS9aRjBtNXhITCsybjFJMHhKNXNFNStOWFBDM0FORko3?=
 =?utf-8?B?cG51M0dDOWVKVklVblJpTVFFRmdCcFFGTnRsaGl3ZUtpN3BiMkZ1VFFIWGkz?=
 =?utf-8?B?S0d3cjZSbnM5VzhoOEpTWm1QeEJXOGc3ZGdQUXovenRIYlU5ZXBSYWl6OTR6?=
 =?utf-8?B?R2NRLy94ZGh2dzdES0ZLcG9wc3VQLzJwbTRNNXJkRHNZUWNDY3pRN3hMSnFJ?=
 =?utf-8?B?QUo1RnFaOFNlYUc5S0hsKzlELzZhY3JrQzhmbXpiMmxmUkcvL0gxV0s3Z050?=
 =?utf-8?B?ZWpXRlI0T1NhUmwvYU5UUS9nbUY5cTUxU1l1eVJCQWlvYUJDaTZ0UktlLytF?=
 =?utf-8?B?ZlRpR08xdUdoQmQ5amZ2ZlNLc1gxL2ZwcXM2MFpZZXRDYWdQY1ZWeHBUU1dR?=
 =?utf-8?Q?ZyXbzfoRwSUF+VFX5FSh1XPoo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b432639-ad41-48b7-288f-08de10ae3910
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:29:20.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiX5Q+v1GWBcsgzgjcKbbQQaKWb5W8VqRsVozZQ4tC+Vqv8fC7deKHVOxO4bF/c/JgT6uIHgWbunbbTqLMKkqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443



On 10/21/2025 7:54 AM, Askar Safin wrote:
> Chris Feng <chris.feng@mediatek.com>:
>> Wakeup events that occur in the hibernation process's
>> hibernation_platform_enter() cannot wake up the system. Although the
>> current hibernation framework will execute part of the recovery process
>> after a wakeup event occurs, it ultimately performs a shutdown operation
>> because the system does not check the return value of
>> hibernation_platform_enter(). In short, if a wakeup event occurs before
>> putting the system into the final low-power state, it will be missed.
>>
>> To solve this problem, check the return value of
>> hibernation_platform_enter(). When it returns -EAGAIN or -EBUSY (indicate
>> the occurrence of a wakeup event), execute the hibernation recovery
>> process, discard the previously saved image, and ultimately return to the
>> working state.
> 
> #regzbot introduced: 0c4cae1bc00d31c78858c184ede351baea232bdb
> 
> Hibernation doesn't work on my laptop.
> 
> My laptop is Dell Precision 7780.
> 
> Hibernation starts, then aborts. dmesg contains:
> 
> [   28.283320] PM: hibernation: Wakeup event detected during hibernation, rolling back.
> 
> I did bisect. The bug reproduces starting with 0c4cae1bc00d.
> 
> The bug still reproduces on v6.18-rc2.
> 
> Note: there is another problem with PM on my laptop, which is tracked here:
> https://lore.kernel.org/all/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/ .
> 
> So I always revert 1796f808e4bb in my kernels.
> 
> But this doesn't prevent this hibernation bug.
> 
> In other words, this hibernation bug still happens on v6.18-rc2 even
> with 1796f808e4bb reverted.
> 
> Steps to reproduce:
> 1. Power off laptop, then power on
> 2. Hibernate ("sudo systemctl hibernate")
> 
> Hibernate will not work.
> 
> Note that to reproduce the bug you need power off laptop, and then power on
> it in step 1. Merely reboot doesn't cause bug. I. e. reproducibilty
> depends on whether last boot was reboot or cold power on.
> 
> Also: suspend works normally (assuming I reverted 1796f808e4bb), but hibernate
> doesn't.
> 
> This is "dmesg --level=debug+" on v6.18-rc2-with-1796f808e4bb-reverted:
> 
> https://zerobin.net/?0459f6411446622d#8i0Ifo6o68By3+UlYUr2t2KL7YLXsKEXrkfszpE77Rw=
> 
> This is config of this kernel:
> 
> https://zerobin.net/?04e89ceab8284c1d#9bpaZKqVXFSaeav/WW6GOCwD4i3SozzQ8pBEJ6LWwVM=
> 

To me it sounds like it's potentially the same root cause for the early 
suspend wakeup as well as the hibernate wakeup.

Assuming the GPIO pointed out in that other thread 
(https://lore.kernel.org/all/20250918183336.5633-1-safinaskar@gmail.com/) 
is indeed the touchpad GPIO I had a suspicion.  Are you closing the lid 
and putting the laptop in a bag or putting anything on top of it?

I wonder if the touchpad is not disabled by the hardware and getting 
pressure through the lid and physically clicking/activating.

I've seen this exact issue occur on a Framework 16 as well.  The 
workaround is to disable wakeup from touchpad before suspend/hibernate.


