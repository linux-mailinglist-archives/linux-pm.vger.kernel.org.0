Return-Path: <linux-pm+bounces-42267-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKc7GlEEiWkg1AQAu9opvQ
	(envelope-from <linux-pm+bounces-42267-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 22:46:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C7810A427
	for <lists+linux-pm@lfdr.de>; Sun, 08 Feb 2026 22:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352B830097FB
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007D341670;
	Sun,  8 Feb 2026 21:46:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021102.outbound.protection.outlook.com [52.101.95.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB562C3256;
	Sun,  8 Feb 2026 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587214; cv=fail; b=pV4engQDEgKQVNrQH9UfErQwWGAH4nIxt5bhOZQ2ku+UTxAxVqPZC3iFpdUPsjRMozNMcR7QJpRZnpRBycX8tcsHCXoCS814banRdTSZvKHU+c4d1Nxosp0idsMayq1u4TS2J8svyYtFvuMruzs64+QBUAOdHIyXDqlYp91nJ2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587214; c=relaxed/simple;
	bh=vHiDpc9tARJqdNNKZM/dJG8laKUdw2gLygx5FIgCf68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d42frwcDP1WYjdk1KFL+r8qycQmeH3WjZ93qTMDrI+Cl2eL/qFqBqG6t9/QsdjSsC18kWkOiRuGyn62nWUWZzckmNUWTjp+1erDFK9iewSILiJEXFqAfaM+2Mzs30k6OZ8pcaJGAvogmbaUuVwJGKHRpxWaEOklnB7eX3Ya77ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oINHIdSCGR/3xl6JqlRaQhkQiseUatMONPSjmzJbERBM+jeyiavDNep3bzRjs+qGRi5ePqSzPlC7YhueYuip5ui4tRacpLV/Uizq3kR809ykJKrmbJ/3kD/fTJFS7JuTO8OvUT4XzkrOqOcRzRqyOPOTSzojFtrV/iIFKyb8OooghUyv1SCl00KTr2pTq519lkOGsUBV3qhCw+L9ssCm5wzvynXJxzf7nSgml3sP7qxKi1UjeoTdsAByX3WGEk212HJ+8NSvVAMWUlpxFXlo59xADvcnrd9JZM3Nh+tX5waUBKdGpf5GXe6HwfVjWLw2uDKgPjWPNQixXU1Qq+Gb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHiDpc9tARJqdNNKZM/dJG8laKUdw2gLygx5FIgCf68=;
 b=KOoqUgVyI4Rk2NqfkOwI7JJMVyOUp2+QlO0mYigVGjyRZ8p/G8cW5YIABA5XQiiKr2Xu4HsX9feuyM1wboNMOiFn39Gi6ggki52fdzPcpJ1R4T3vQvJIRJcJJtaLM4zMzwHnd0dW597fgFnbSq0jpb6ZtMwZ+2KtAPqc/9HLleTaoYrCux7AWEFJ0NX0qldEUSlTgTNK3n+GbvzAD2oJIJNIZu1tZ5UfFAPhu4dGBkYvBJEvlo73kVzBb7NQoj4lGQJbW05eZ6AeqxtOmJcD6gSR7NiDfaGY2dzZiH4iFwMRsYs8jMaJczvHU1LOzkUaSaOSfY9cueWhMynONYv9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6315.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 21:46:50 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 21:46:50 +0000
Date: Sun, 8 Feb 2026 16:46:46 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org, dakr@kernel.org, pavel@kernel.org, lenb@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, pmladek@suse.com, 
	rdunlap@infradead.org, feng.tang@linux.alibaba.com, pawan.kumar.gupta@linux.intel.com, 
	kees@kernel.org, elver@google.com, arnd@arndb.de, fvdl@google.com, 
	lirongqing@baidu.com, bhelgaas@google.com, neelx@suse.com, sean@ashe.io, 
	mproche@gmail.com, chjohnst@gmail.com, nick.lange@gmail.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [v2 PATCH 0/1] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <43qqvhcxhze7vcip2w3kqulqwzzfinl22kjq5dt7f3gmqe55ac@exknfhnxzy6o>
References: <20260128033143.3456074-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qclpdckcwqquw52u"
Content-Disposition: inline
In-Reply-To: <20260128033143.3456074-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:408:e4::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3ee2c1-3b52-48d7-65ec-08de675b90d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGxMd3VtU0lYZVl6MlVERytFcEM1TThzblZYdzExeHI1am90NjB4b0ZQeGhk?=
 =?utf-8?B?WUxXZTl6UFRRTURLUkNMWFlIRjFtWFJRemhsMTlOM2g3OFpsZm1yeHoxeHcr?=
 =?utf-8?B?aElLMXk3cTRYYnBSZzB3c0k5WHJUOHNYSHFJTm9MTzh4V2xGeW1nQVE0eko5?=
 =?utf-8?B?WXRNcVpPcVRHZGw0allKbnZKMTBDSGlGRlRUT282VmlJVU1MdXJNL0R5ejZF?=
 =?utf-8?B?N0ZkOGhHVUg4NTUzaktjeC9HTHJVN2ZkcE04cXRtR2YxcWRDTHBMK2xoNWFr?=
 =?utf-8?B?L1AyNWZCeDYxaThOTXNkN0drT1ZQWHRyNlBoKzk4VDB6SmJPQk9DNmJrRTVu?=
 =?utf-8?B?RFBMY2NjUjNucittUHJubmh2YkJuVEpzaEhyTjV1Y0hXbjY5LzBuWVJ3NW13?=
 =?utf-8?B?cHRxOThUT1BiMnFzdjRnTVBlaldrZDhNK1FzV0w1OWo3QTZpY3ZjUXV4RXJ3?=
 =?utf-8?B?NHNIUTBOb3lWWGFHSDdtNmNub3NJN1p1eEtqcnZqTFRGRFZJTTg5R2pGT0tl?=
 =?utf-8?B?d0ZtREZnRFZnWWdXdDEvTE9nbUtjZlUyS3lkb2JiMjlkNVhNb0RxcldUL0E1?=
 =?utf-8?B?OWRjb1I1NkdlMGMrTDhZZ001UTdyQVBrVVE1dEdiK1F1Q3BWL2R3bUptb1R3?=
 =?utf-8?B?bWxsbTNaVmo3OThNL1R0TW9ZTERESUpSS3VyNDNEUnlZWVRHeXJkREh5bERL?=
 =?utf-8?B?UGpITXFkVmtEQ05MRndKL1BIL0l3NDF2K1NnOEVwVDN3RllWOUx4SUR5dHZu?=
 =?utf-8?B?T0ZLT3B4NExGOXgyRmxodmhxSFFSdTlQdklXREtpQzhIeGM2SU1EZGpUcTA5?=
 =?utf-8?B?ZW5NTDRXOHdmSTAzQS9CbFhERWZnYmowZGE1dTVmaGNYUE8vck5rUzlXa29h?=
 =?utf-8?B?dy8vWVowbis5NVBKY3gxV3ZtYnc1cXhMdzBUNFcrRTBtNXYwTitqYU5vVEhh?=
 =?utf-8?B?WmlRZTFKbGtQZUV2Zy9QUDl0RkNiV3NsMHkvQ0J0eFdLbExxd2Y0L3FHQndr?=
 =?utf-8?B?VVJhT3ZtNzQ0a2M1UmFqRlM4MEh1RlhYdXhhaDVlb0Y2aVFGU2ZRNHlBYVZW?=
 =?utf-8?B?cjExUTZ0QzZvT2JLaDRyUVVHTlZVLzYxOWFPRHFmR3ExTDdITEk2NVJwV2pj?=
 =?utf-8?B?Umo1b3Zkd1BMUVlFdi9NcVRyZUVjM1N6dnNnODBrSm15S3NvWXV3Nlk2d3pB?=
 =?utf-8?B?ajVER0hQaGNwcGxWaVBQSExram5tVWRPOWNiQ2ZMTllkR0RlVFJpWFIwdHUr?=
 =?utf-8?B?WkNTbCs2aHF0Unh6UkJYTWhvbVNxSytWYVM4VHBEckpFTjBNV3RyR2xiQy84?=
 =?utf-8?B?TFVXWDdSc2NxS2JkSXBKOXRLTlV2cXBVOWZpUmtyeUZ6WXA5TXRCQXVDbE5H?=
 =?utf-8?B?ZTY1bFlLcEp5WE1EY1Vmc2YzNnJIVXVwVjhaVVVtd2NYNCtyYVBIajJ4K0hC?=
 =?utf-8?B?YmJnZG1Jdnd3cnJqOGtPYUxPWkxYdVFqVGJRTHZBdlBkU2lEZDVMUVdTWHEz?=
 =?utf-8?B?YkRaRnV2TzBWQWsvWWI5VlZLS2JYcDdDeGppekN2enh6eTUxL3dzNW9rSGJ5?=
 =?utf-8?B?cmtvaHVtZnJnQkhXa25IQXBRT3MvekhzdHl5Z3RoOW1QditkcTlzcFVtTFlR?=
 =?utf-8?B?c0NMcld6WFMwLzJsbFF0MVpJb2RBZnFQaVJwMnJYTUlJMFJ1ZUgyaThoL0Rt?=
 =?utf-8?B?UUhwZ2FVRkdCWVRCbENtY09vaU93WDBGb1BNVUpWME9HbkhZZlFIbVdMclFs?=
 =?utf-8?B?MDZmQTdIb1kvU2xFNTBwQW0xZXUvMjcxUXg5R201RGdIY01BR0ZtODNRSFp4?=
 =?utf-8?B?MnBlTmhXM2h1dEVoNXJ4ek1mNUMrT3Rna0pzWHUwUkdmakdqM1dUNk9lQndO?=
 =?utf-8?B?Um1Ic01BcW5laDBxdHQ1am5FamtVK1czRnRMcHRGd25ZZTZpa0plaVlJa1Nw?=
 =?utf-8?B?SEFtYURCbE1RTzhJT0F2MmVXcllSUFZLeFpPRC9nOE1MdTBkVjRmY0t0YnZk?=
 =?utf-8?B?RVUzdmJ0dU1heHFCTDR1bmcybnhaYk5pbGdBZ3dJRi9IOS9xZVQxWW9ZcU9Q?=
 =?utf-8?B?WXNQU0lPTUYyeUZsci9RN2hnTjA0d29POHdCSGhRLzRGeE5HRlNnYXE3M3gy?=
 =?utf-8?Q?bPjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0lIQUVENkFSYXZwWW4vS2pNWkZoT3JXdTNWS0dlcEs2VWZZdDlZbU9vc2Ra?=
 =?utf-8?B?R21oWml2TWZhWXJCVnpCc2xZVGsvcE14NU9NOW96bzMrNFhLNGtjTTRjNnRq?=
 =?utf-8?B?Y0lLN2txek5Ra0JWcUozM0hDVkRDK0NqYXdLQSsraHBaUnBiZUFLOVpiRVA2?=
 =?utf-8?B?SUxPNzJnZy9sRVc2NHh1b0dKaGdSVk56ZXhXdTFJQ2JJdFpXNFg3YkZCbTFz?=
 =?utf-8?B?WFVNSUQvTmhmOFV6RFJvZGsvSGRydFYxbXdVTlZtN0YzQVFuQ2t0S0dsNVZD?=
 =?utf-8?B?QTlMWkhMc3VNbnl2R25WZkVpKzhEdytFTzAxSGJOWUdzYWJUdkwySXRNSm5p?=
 =?utf-8?B?dElKVW9YTFJuU1dZNkRGRG1FcERNNndjamxTK1FSR0pBa0F3UW5RWXRWOFNW?=
 =?utf-8?B?TnBXVG45QWRsUTdrQVo2VFpMNkgwb3hMV1J1ZG1CTG9ocFVybXAxcTNJUGFw?=
 =?utf-8?B?M3REYXNlREJyWVJ4am42bXNoU0VXNno2aUJMZjFJeDIyQjQ0QTBsaUh0NFZD?=
 =?utf-8?B?Vk9EajFQZ1pSbUpOdXpHeGNZZ0ZWZFBQc2ZCRDFjVFVWWSt0ZlZoWk05UWMr?=
 =?utf-8?B?bDB6WlJjMTArNDdpdWh3bFE0bDVPcDVmY2lqWExLd0FqZ1VIUXpHcGU1cnZz?=
 =?utf-8?B?dlN5VHh3WndwNUdCUHdqU0MxblFqRVNMeXFFU0JWalpmNlpRUzQ5SzNrWmpO?=
 =?utf-8?B?VFN4NFM3RDJDVlA5L0xySitWbzBVbFNtM0Y3L2hzYUhCd2RFQzRlZTNpK0JK?=
 =?utf-8?B?THZQeGk0NW43OG9ld1BhWEI2Y1c5WU9rY3E0YzFSTTFGYjdka1oyQ1hQRG01?=
 =?utf-8?B?T3huelZ2ZjVFclgwRXFLRklaWlJFK3dZN29YaXFhdWFxU3U0VmR1RjNtejlE?=
 =?utf-8?B?OGV6VExjTnVFVzRhdjNSdjduS3FsVTM3NndKUzk0T3MyWURDeEdPNTdCT2My?=
 =?utf-8?B?MWEzOHA1OUoxbjA5b0NlR0g0dm1Ba1AvdTV0Njg2UEx1eE40b1pyclQ3emRQ?=
 =?utf-8?B?Ty9NR1BPd3lqcm5uTUdhK0pkMjNVRW91RGNHeWs1UzNCQ1E3VHo1ZmVtQXJM?=
 =?utf-8?B?UUhnejVBbVdEaVFpRHZUYU1wMm9hMUl0bGs0TkpscG1rSlViVWdqbGFWczVS?=
 =?utf-8?B?Y1NacWVmRkJvNUc3TlRIQk9aRW16NTdHUlRQeU5FRWlrbFhPeVBTNzhnQmhI?=
 =?utf-8?B?azVmOEVBV3RQak1kYnZGN0o4STlCWXMrVzlrWUM5WFk3TzNCODljT1J1QUND?=
 =?utf-8?B?Z3pUT3ZoT1FtMnpGNm5rMzNSRkh1Uk1HbXZ6SllhK2c1WkRaWDNBdWMzMDNo?=
 =?utf-8?B?WlVld1JXM05hb29pRHlkczJXQ0J6K2prUHVoMWs3MWY4anE3MU0xQXhHejdW?=
 =?utf-8?B?SFQ1UURqeDR2VnVQQjFaM2V1S0hYWUdWZVh1MmR0YXhvNU90enZKVnJGR09D?=
 =?utf-8?B?Q3JNcTNkK3ZuQ25HbU1ydllsS0NYcURySWw3azArWmxLbk9nalYyWVM2bHRj?=
 =?utf-8?B?NXpoaGpNZ3RKYkpyc2JxOW5GczN3UzROR1JqWWtCOWhMOWFETHdrRDhxQlNw?=
 =?utf-8?B?NmQvejhXUHl4dTdIeDhETTJVQThnVmZ1Z01wWWl3MFh0Y0N4dnRlZjFPUjV6?=
 =?utf-8?B?Sm1iMnFUaVUyR0ZsKy9CeXBGa1hTTjdXVkVzSkt2L004Sm1aVkc5ZU5NTHpr?=
 =?utf-8?B?SUVCYnNMcjRUUmVYd3dma2hlcWoyUVdMMFJYSkVraFhoWDJmeHJqU2dZR2JV?=
 =?utf-8?B?Vng4NzlKNFVFeG94VnRKemM5S0FVZlQwSWMrckJFNEcxa1ZKR3V2amhmOXEv?=
 =?utf-8?B?bEtXTUJGN3YrNWEydHBIeUFkMEZnbU5IZENlOEtNZnhNczcwZ3VibTJyT0RL?=
 =?utf-8?B?aCs1S25aRGt6YjBHNFEzeVlFcjN4WUdWNlpkRWNhZWV2cmdPSkwxNnBYazAz?=
 =?utf-8?B?ZWNndWJiZW5UQ29PZ1RCbGtuOGdmNlVTMUN6UGs3V2ZkNFBIWUpLSE5XTXZ4?=
 =?utf-8?B?aWVIQXU3ODhWUUVENjZNaloxT1kwMVd1Y0hPSW05bGJHaDAzcXVhSXJmN2R2?=
 =?utf-8?B?cHpPTk9iM09lVEdOdCtnRXhsSGE5SHRYR28rK2VDd0RTcmJDdjdxVGhObmto?=
 =?utf-8?B?Z21GWW92eEhtZlQvMWYxeXVXZjhYL0FwdVJ5amRPSFVWeGlYV085dlFBZzA1?=
 =?utf-8?B?VURTR2dCODdvZ1BOaDg0dmJNcmZGcWZ0bDRsdU0rSXZxQjNWNzNmNkNBVFZt?=
 =?utf-8?B?aERDZ0h0L2tVQUE5SGkxRy9nN0Fzdmd3RXduaWR3Z0VSaTkvUmk0WFY3dHkz?=
 =?utf-8?B?UElJY1JZbXR2SzB4bVZ2TFhKQnJmWHVhNFdVaHJoS0toQzdzdjZWUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3ee2c1-3b52-48d7-65ec-08de675b90d7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 21:46:50.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B59xPVr6RhaF1KDDo/zqqeV/TYouLuaqQ4tUtZNoRQ9fo0/0mj6i7XjK2xgNuxDFKOavmeror2fj64BPFXE2bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6315
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42267-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,alien8.de,suse.com,infradead.org,linux.alibaba.com,linux.intel.com,kernel.org,google.com,arndb.de,baidu.com,ashe.io,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.900];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8C7810A427
X-Rspamd-Action: no action

--qclpdckcwqquw52u
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v2 PATCH 0/1] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
MIME-Version: 1.0

On Tue, Jan 27, 2026 at 10:31:42PM -0500, Aaron Tomlin wrote:
> Hi Rafael, Danilo, Pavel, Len,
>=20
> Users currently lack a mechanism to define granular, per-CPU PM QoS
> resume latency constraints during the early boot phase.

Hi Rafael, Danilo, Pavel, Len,

I am writing to respectfully enquire about the status of this v2 patch
series, initially submitted on the 27th of January.

As it has been approximately two weeks since the submission. Please do let
me know if there are any outstanding concerns or if you require any further
modifications to the series or if you would like me to rebase.


Kind regards,
--=20
Aaron Tomlin

--qclpdckcwqquw52u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmmJBEEACgkQ4t6WWBnM
d9bZJw//f2nG1G6eIqbtYuMy3XbnSqs0W0OvcoXdbCzQmRpRxXTMRK6apHr2SGWM
OTmtMxv3/SNqKFsys7Tv1dOS/db3Mcr/qH8X+h/+59yBI4E+Hl8eTFXRwJofnz5G
rS/1KYyBOx1MhatD4/u+VrD3rtCkiQT0mgD7gPvOOu2sajaVsbe7Lb3CPZVxcgV/
Yy0L/JA069VPjz5gjHfJKFuziuCQc/JM2PAACK/+gT97dJchNjzLLQzQFaAkIvW9
i3Rpx2iT+5Z7wdhrnJGtq4NfRL5o0oqNQdRRpwX++jlb+xKRKgXp6OyxtBzypXBF
pDtd0mtzQ2ptdPq4ANgadXNSia4l+CAwfTzUpk97q0cOy40i16nn5iP82DGzMrvD
Lw/9rMjIIP/rbufd0W9DX5SeeSmtnAr4d32tsWJYJXtrk6J0SPJKsTlihLxOtZ69
j2MACKb5aKPz8POEJO6HqmOkSsKXr1enkqdzxwHbCndJHFY+Yx5Ly4f6FgIbxr+I
QSrNpgjS8KnijT6mc2GqOGaVuedgTJcdCiJ+MBdRojL5DlKKU2gBOLliwRYY1tDQ
SqzqMHJIE2BdZSW+SBBv/w/M5UirfE2b2iZ5BpEOWCF6qO82nvri2FEVEofHQz8N
goFzPdEuQaR+cpKLEFRhVKnrGSGDGp2/3TgUjqvI2BmfNnIlYS4=
=B9Ya
-----END PGP SIGNATURE-----

--qclpdckcwqquw52u--

