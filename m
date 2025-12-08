Return-Path: <linux-pm+bounces-39284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A7CABDE2
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 03:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30570300A264
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 02:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8C239E9D;
	Mon,  8 Dec 2025 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATgkgSzi"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7B29E112;
	Mon,  8 Dec 2025 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162055; cv=fail; b=VguCWMF3P1KxnSNNcARR8OlhiYICtkpccQIAQspNG3DjLouDfdifo11usU8RQANtjDUauDNH9xm/LBJM43l1lUhT6Oc0vzV61qPUMtvyDSt947xZLfUA7fnjN4sT9Nw+L9AiGOAT8nr2KaKxdeGM9MWs9GtwCyZFPDHXzy9QoUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162055; c=relaxed/simple;
	bh=lMl2WnYcf2SjXrnpbI0J1QsfkxN+epmEfKgaUXsQX78=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NaM31HOzcJPCkHjLrB3YeQUTJAn2EDZnuwc96/85QY7nfOixggacd8tbdpMy3Kg/GNXpru3j3qkMjaRsvFZ8kgqc+8UO6lJeTayHSHjdshgDa7CpyWPfox3WDTIT5Evdg5yKph4pAZB3pKU6MhaYxhQVWlfOf1IVrdEpTtJI288=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATgkgSzi; arc=fail smtp.client-ip=52.101.52.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihzarU0Trx/seWGWaA2w9/guvKVi/8vt3d5w6cKMpENPpl8KKTqSDQaPy8HBC6VQ7cNUV7O6rUSHVwaB4PfJLQ0Q5mdGUhVdmB44jeBE8Thjp5/7MRviKqi45mFJdCYPRWhDDNdCt++w9/6Eh0DOQsMKYqWPOt975WtF74SwF+9vtm0wIaULtgN3TFNdBCtC3z14rOpNi7h+jsQSkHlLCuuGMQTJ/rl1J9oICRy9oGFuRZeFd3PbaSV5+7IOqi6fQuIenJXaXLizyPW4qckbG1emVqKOO62FYK67Opw9KhoLUxNoucp5EWs23nHzUGwYBKYc4Ovpr6eVB7wi+CqWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0lVIfCG5ZrBFobCOyCxASFdxsIUpiZjg2shvVBrz0k=;
 b=C4rslVO9EHnAl7KrXsk1C5B/g9VzaRZx64jrWlvKHKiMpTjqgcaP+RkbGh+WuQ8jknNHUfeudn1mN06zxFKS+FIIhoOSjr7tm1z02QSMKNn9LFoKP0HK9lWsHSOG0xj78CIW8SknMG7fIkh+9uajpjjYpG8E/g6dCLPUTl2sTdRfLUQzAdScIv0XUePhg0PkcvL2Wzss4FFg2dabiwjqiKq9b8DLmDT7cfQLMU84F2tjqhPPE/EzT4LRwrtBxzw4WgOVy5g29JeUd8mXyY2uKUSXZ3KepuMf32OoSj3lw5LA8FY5U/YWMeAtAwAZYe2picFnsumrZcH/4CIDFqjG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0lVIfCG5ZrBFobCOyCxASFdxsIUpiZjg2shvVBrz0k=;
 b=ATgkgSziIVtp1hY+Fso8zuqKLOtuWX8sNsOLU1PwdC63BPPyWMFpuslsWlI9UueXHcStaH6ROX6KF18qJWoJk5Fe54i1mY8Q8/Ubl8DMHT9CDsoZ7TlWQWGdOXGw52uKWCb3/M/Cti9BPbbz4ZfKDuneXSSquJ+Y44+r/wigBpOsx/FhfeFDZzZlTPV1BCVuWp/rqAMeUBPdjdyHZ1Atc/sMs8jqjkPLQnKzq1gFY1OYtsCClc2bfPYxWH3fBMkSrzZvJC17rtJMMG7x6S4DV5plvKf49dBRI+6zIRaHJJK5wSMQZ7Lz+EpmQVTZahUnmekxoc/zGHvkgbnAYOqzdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 02:47:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9388.011; Mon, 8 Dec 2025
 02:47:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 08 Dec 2025 11:47:03 +0900
Subject: [PATCH v3 5/7] rust: sync: refcount: always inline functions using
 build_assert with arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-io-build-assert-v3-5-98aded02c1ea@nvidia.com>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: c98c4b10-5969-4828-3bfd-08de360421f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXdFQzgrSjM1QTRiK1VwRnpJclRmejJWdmdST2d1V0lXRFV6dnN0TUxRQ2pn?=
 =?utf-8?B?cDZDRG1yQjEwb3dPcG0vdWI4bWFEL28rWmt2c1RSb3Q1d1FtUk9LMkZnYjd2?=
 =?utf-8?B?OGl2NlpBeGx1VURTd2JaM1lweUhaVVZkWnkwY2Z2N1pLRU9nQm5YSFF0T1N2?=
 =?utf-8?B?dGZvcGRDNW4yQm9lemRzNm0yNGg2YXViNDVMbUdRS284YkpNcTFRK3A5WmJp?=
 =?utf-8?B?M1ozamtEcXRocDEzR09lNWJHMzN3Y3pXam9OdGhEK2Z4ZDliUTBNK3pQcEs4?=
 =?utf-8?B?Q1Q1N25JcHEvL21kOVkxRFY0UWwvbXZvL2ZsL2RiZUNwOThYbWdFelRQeE8z?=
 =?utf-8?B?dGpzdjYyWXdNYnR4RDZFQWNEK2hoMjM4ek1xcFFCT1oyc21sUlFwZDJuVjBW?=
 =?utf-8?B?MWtENDFFOW40NHNYNlBxbkg5RjNnNXI1SFdXRFZjZ2Z6WDMxWEhyNVU0dVAv?=
 =?utf-8?B?cWxEVUxMK0FyRXMwT3NWU295cGgwOVhrM3RBbmFnRjZqSVZDcnBaVFFURVUv?=
 =?utf-8?B?TzlIOThDNjRzbEJ4SXdZdDJzenVOT1RMMW4zT1Z2TUd5ZEVHT0QwTGQ3S0dT?=
 =?utf-8?B?Q2NvRmExejFxNVNISUZrRXFZQVRxMkx6RlJtWm9RQWpqZjNVVHpuTGd5UC9G?=
 =?utf-8?B?WTFCZkMxYXdNKzhBZWY0d1FDN0xremlzTDdoRlRteWFTbzZlU1BqUlJ1Rmx4?=
 =?utf-8?B?RjBtZlYvdHpIbHpkSitUYmJZNFJodllCZFhoaHNySWFOdHhGS2tobVlZcEFQ?=
 =?utf-8?B?RUdpNzhOVTVjWE1QOTBabEVnaDlBU3ZTVzZJSzB1WWp6V05VajcyY2gvVHhG?=
 =?utf-8?B?Uml1b2VxY0tyK2hySkZZRnIyeDgrL1ZoM2hTdStkNDFmMkdQVGpJVnpUUEZJ?=
 =?utf-8?B?ZmlQY09sZjZoNldpREFRYTl5QTlCKzVaNWpZak9rYVQwQ2ltZkRvYXBFd0FL?=
 =?utf-8?B?Wll1V2lGZHZQWjZWdG9ocTJpWklkNFJZcS8zNUlmaDRiam9QRmZ1S2lQb1NJ?=
 =?utf-8?B?TGdPd3FGNTR3ZDFRWXBtcDd2ZnZvR1FzVEw0ZWlPclU1QzlyY3VlcnRmc252?=
 =?utf-8?B?ZkxWWkdLQ1pYcEVEem95YkdudnA2eEl3OVNOZ0FkMTJ1S0xHRGtSazRFZ1kz?=
 =?utf-8?B?YmgrUm54QXYwVWJUWFFOTXpsbTVGUVcrSHRrOU5XTjNNek1tTkQvaTJKTHhw?=
 =?utf-8?B?UWUrNkh3c0lPcyt5RDNGK1Z4QjdUQzQvSlRReUtYL2J2enZ5cVk5eVJzYjFY?=
 =?utf-8?B?NmY5QzVJT2kvUENKaURjNTk0TFZVcFgzU0ZsMW5lRnZDT3BRbU1iU2w0TERx?=
 =?utf-8?B?bHdwdm1haFpGTmlkZCs2UE5wSVU3WnpDU2V4OVpuSk04L0V6R2E3cHZoTGRN?=
 =?utf-8?B?cnQ1dStBZXF0OUJURDZaaDBHNTl6Y3ZIdVRkY3lmRUhOTXRZT095TEJzaE9P?=
 =?utf-8?B?ak1sMUxLOXhuM2NQSnlLVU5qKzFyb0Q1bXBkYmwrRi91RlFjVjBXT3loekZC?=
 =?utf-8?B?dDk5ZDVoVFBPNkhITmJObTFTS25mZkNYWWU0Z0JlZ1MxVHJIcy9ab3ZvejdK?=
 =?utf-8?B?NkwzZlU2K2wrSHVoQ2duZTJBVE82SE91bSthaytobjdrekZmYmFIYzR5MC85?=
 =?utf-8?B?QUZESFloWWZWb1RIdGlWWjJRdUVJL241QStmVm5FM2pyelpKaythVEU1a2hx?=
 =?utf-8?B?VGlHR3N5MUEzWkRzcjJiMGZYUmRiTVZrRU83dXBmVHFrRXl6OENqMXFsS2sx?=
 =?utf-8?B?Yjl6ZThSZnp5WDkwSmFZYUs0bkk1T1cxZGYwS0pIZ05TaU5Sd3FjZEk3eUdk?=
 =?utf-8?B?alRSSmRRalpvZkhUSGlWTU5kdlJGRFhBNWVWZDBqa3RVMS8zQ0lzMVBkRWlE?=
 =?utf-8?B?TzdUWkVYZFJJanVQNE91eWpjNWNaMHowMXVzazh0b3h5cThTVDk2R01hUUZy?=
 =?utf-8?B?aEpjS09kWi82dm1aMmc1NVh6dlAzWDIyRzRYYTRNbm5PRHdXVWxYZjlJaklH?=
 =?utf-8?Q?50agtluU7jhHJnz1tmO43qzAjRjFYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkxMeFVMaWYrNVRyNUZNajhuY2pvQ0daOHRzK2p5WEpOMGhWZVZKcEFGWUhi?=
 =?utf-8?B?WCttVU1IdHpvMFlhclVCN2tLUk16K3RCMTVjSHVUanBtR1RIQ0FIckRuSWVI?=
 =?utf-8?B?eXZXZ054aVphbFRpbW1mbU12VHk1aWNIWnMyT1pURmZ1QWcwSXVEK1pRdkJ0?=
 =?utf-8?B?Q2JGY0dSM1ZWSmhPK3o1OS9INThrOXd2N3NBLzNFVTlIWlFGSUtjYjJPTFRR?=
 =?utf-8?B?QlJtMlhJd0dsWnNGQW12MHJwRllkOVVqRXRRVm1kZlVsSm5Fa1NyQzV4elFq?=
 =?utf-8?B?VmJuWXc0SkxKZnQxTVB4VDJhbDNkRVJ6dUV1WVQvMkNTcmJKM3dCNHJwakdv?=
 =?utf-8?B?cXlCYWU3OHExWFV2eTVrSDY5SEQ0Z2JCa3RENUtBNFgzT0llQWFIdWVvaGc5?=
 =?utf-8?B?cDFFMFhGRVBTYnU1eGZGeFBhOUpaeHlHbXBYaFl3V0drUWxyZnBnZDhTVXp4?=
 =?utf-8?B?dmRwNjRlWkptWVRqaG5IanVGYktQbHhkMmFyVVhmSnlnc29oN05LUUczcFVJ?=
 =?utf-8?B?Vi9acm94Y3BUaW5Ya3M0VS84dGVBOHFFc2ZTSGtZeFVaZGQvQmRxTm9jWGQ4?=
 =?utf-8?B?cGMxSjIxQ2tPczdzUHNWZCtaa2R1ajJ6QUswdTlkMDI3WFZLczVsSm1saGhF?=
 =?utf-8?B?V0F6bHZtaEJKeUJ0R2JDVXdiYjhvN2h1UkE3eWZuUXVDWFdVT3J3QVZxQnFt?=
 =?utf-8?B?SFlwT1Z6VC9NVWxQcHZjd0FrMElacHlCR3RFQnZyOEpubksrMDF0ZTYydHN3?=
 =?utf-8?B?UmtoSDI5Tnc4QmFqZHBMUHAwTW9wUVNkRmR4RTY4S1dnSy9NTXQ0QXNYSmZK?=
 =?utf-8?B?OGhieFRRWENhM2dZclZTd0s0K0NZUTVQL3JQRXdkVE4wYUk5aXhyaUpzTWZ3?=
 =?utf-8?B?YnVvbHJyWEcyUFJaTEd5TGErSGsxSVRQOFJldVNvUXpqcXFEWmVhZjlpMUp3?=
 =?utf-8?B?dTNUSUVEZXA0Ny9VZzFpWHhKTTUyaHFDdFhldHQrSFE2YWR1cTdDN2lrWEpQ?=
 =?utf-8?B?MEI1OTZ4SmxXZWV3YXU2VTMrRS9KWFVIaGZ1ZmxiRFAvWnFBanh3Z3J1Y2Fr?=
 =?utf-8?B?bVZvbXN1bDZCeE9XR3llb1U1MTAwemRiTU1Cb3d2a1l1WWpDUUNIais0WmRi?=
 =?utf-8?B?OHhMazYzOEZmOWFzcFppZHdPQXdoVUJwdVJRdkVYWWdtZkZpY0FnRkkwTUlQ?=
 =?utf-8?B?NWg4RkpZZVVUSE43OXFNc0RSWEsyUXEzYlRBTW9SaUh6S1ZKb1h3R3QyTVQw?=
 =?utf-8?B?Y29ZbmVFMVBPU2Y3REFPUThHOWZuenlzUXJhalVuWXpVWHdzZlhWdE51alhm?=
 =?utf-8?B?cWtsRnE0MDZhNFExcjZ5cEJsaVdheTVFbi9KdGs5VGh1cFVFNVhxdEo2VDJ6?=
 =?utf-8?B?aSsrTWxOeGdMMEhVb09yVG13aExReGZCM3RSaWJ2RFhXd1VwZGc4a3FXdnlJ?=
 =?utf-8?B?cDIwdmZMaWNDdHk2YkkvRDQrbHBzaFNJL2JZZzNseCt4ME9JL1UxN3l3SXFW?=
 =?utf-8?B?VFg0cEdFTlpjMGIrcmNFWTJRaHhZZjVtL2JiMDVhSjRIRnNhMlcyb3M4TWE2?=
 =?utf-8?B?WFVNcWgvamVYeFVvNENHdDBNYTVqejJydUVDa3owRHV4eEU2blVmUjhpenZz?=
 =?utf-8?B?eCtJSGwvNHBNMTBlWWlNdHlvUVJtczd0K0VNMVdXV0EzanNva2FXa0ZvLzF4?=
 =?utf-8?B?dFVBRFhUZytOK2VCQTJwQ0RPT09QU1NWN0V0Z2RGNGZUN2xDSGwwUGlSSW5F?=
 =?utf-8?B?Um8vN2lTUFE1M1BhU1MzbWhJYnpSUXZVODM0eXZkU2dnWld4SFFkejE4L2tW?=
 =?utf-8?B?Ym41WkY3MzcvekQySExpQ0RjWGRuSTAzRXRrOFZwclA5SnE0Q3FISXVtSkZI?=
 =?utf-8?B?SHZnbW1FWjlzOFdyL0JzSUVtSHVGS0xNRVZ0eHlCR1Q4djY5OTlBUkFNdTF5?=
 =?utf-8?B?bjNHZnpJdE9wb2dDSjJnbkxzcUM1WVliQTdnaVQwbmpHTTRhdURGUlYrdHVr?=
 =?utf-8?B?NEQ0R3F3RTEvNC9BNXVJSkU5cXF6ZFVYSlFsUmNBdHlWT05pUSs2QitWUlpx?=
 =?utf-8?B?WXpPQ01RdGcwUzJOOVpZQ0xMWXd6bzE1bVhtallHSlExM3VtRGdneWVzYmxO?=
 =?utf-8?B?UUlJbTlLZU9iaitvd2Y5azVNRDdzd05iekUrNjNFODAyRzRDSm5IYXFFT01Z?=
 =?utf-8?Q?WgVOoVwtbWrIwU853wIMqn+Ugxsy/o4peVjZCzkTPsEk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98c4b10-5969-4828-3bfd-08de360421f0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 02:47:31.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZk/M6u5nyN/pFOl0SeT9SMfw2z6K4KPIaXAPxEqjBmqyxvF5eu5lw6aW1a8TvgefrcNsq+oyl4i29bGDWBPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Cc: stable@vger.kernel.org
Fixes: bb38f35b35f9 ("rust: implement `kernel::sync::Refcount`")
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/sync/refcount.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
index 19236a5bccde..6c7ae8b05a0b 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -23,7 +23,8 @@ impl Refcount {
     /// Construct a new [`Refcount`] from an initial value.
     ///
     /// The initial value should be non-saturated.
-    #[inline]
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     pub fn new(value: i32) -> Self {
         build_assert!(value >= 0, "initial value saturated");
         // SAFETY: There are no safety requirements for this FFI call.

-- 
2.52.0


