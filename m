Return-Path: <linux-pm+bounces-27402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95564ABD401
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 11:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F5D1B63C77
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683FE269AFA;
	Tue, 20 May 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PHyBAdYM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5C25DCE2;
	Tue, 20 May 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735084; cv=fail; b=cvO+Zi5guKbqX7FhLEcbLPdJ6aG0kPyEgCb+O1tfRJRqOMoI2qJFFzJ/yxjmtVuFwPcK6FVoEh4vLunQcCd5emY64Afpl6dzuaWddVjPPaY+nfo3qeDzs9gt06CQuaiXWmooapHgyjxVx6axs3sAhv1s2FDPgU6ZR46VCEamx0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735084; c=relaxed/simple;
	bh=yVibuAs9fcji/3UCkU1HM2c0EiXyUWXIxbqbhmSEhrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GijnZwX8bKyciYAQ6Ncfa3DqqdW6ThCCHSJpHXK93pfENzD9aL9+lmza6lw5v/54KKa2KV5B5izjTAXBcVd4HdP+4bSevg8WNemuPNMFscQobzpVKHfgHm6065QCLHyAdLdKZYyjel2rIMVivqEY1G+bVCyIBFrQw4oNT9owDXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PHyBAdYM; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdHsL4Z7GuV+7hOysn1brHYWUCnvsbYoVbHDSPvMmmbZrzElXY7NIkaI3wZBZpAlh6lJPICMO0WUfEzpTVnrS20p8NgU90zuMkalGN143eDhcU+qDlHrEzRESX8bAIqIJUbTNJypekZcr1aAK/f6Gj6Z3dg5ZfR6Bft35Tm2eAgwl9pmFvt5oyk88eH+YNV48L8WSTAhoS4bAy6SNEHJieGoNAi1CTr9DN/O67vBXbnZT7kntYbXxFqSgXr25x2gpFIDkDJIUeYepKtkTizMRbXXDbA7Lq4fE4qEHDpDuZvdvX/tgoafQVjagos++E2zy02CFuMkzz7jQnBpLzse8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIicbMBBQpp9qmi5Xi145yRmv7eOFJFKV8DeQpIhouA=;
 b=n9STPRCcaiwKiSeqA9lP90vWYo3OIZYGDbi8jWWgMG7OwR3pZArXjulwRQlbm+pZhIf3T+uUeE1B9Rpi97YmaIYX0JssFWBM5X84PoA2uUnn0qUFMbTOm1xBi38I7uRRGskHQ5OlKMR3xrjvAQEMuxoZJF8tvuyPpaztmMfabsxev9clezOEpM0KRDWeDjL9A2sT7RVqlMEat17Gt5SH35lPFVuLVRYNWZWuUL4TbtkXscT9Gfk0Gpk5e8VF8ebGzFKD6++wuNJ5tkYQc2p+mA06LLvKTLiu3n6kJoIGlREgg79hZ8HV/r5vXyRhVbjn9P/72d68ltF2izOefzGGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIicbMBBQpp9qmi5Xi145yRmv7eOFJFKV8DeQpIhouA=;
 b=PHyBAdYM1UBhescL5XureLRtLp/AYQzwFQWjCN0Add1tLMjZ4DtfjtlIdUuRUjuh1zaM8IXFX0hNUZLYx2D3Qkpea/vpGWLqrAioqYkNJjhHp9Iepd9ntYTgBimjS2A2TYtdn2/3thIsRzR1kdVJxfBAqyeQHme3DjsAJ984Rhk9JZVc95Y6sT9LDwOMqT3WfKMxCilaeCOr5WzEN71DOiUfkMDuiJLvd4h1khTjP7Ewi2LGVA72JA5VnhZYeiCGehnRSM6uxOyksqoHpbdDm1nudUK1tQaCsXDWWg0vmGHsePK8DiV3umsFKzwaK5RAkmPTvrZAHWkJ/ElYrUyQDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 09:57:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 09:57:58 +0000
Message-ID: <9a15ea89-5e33-48e7-8c75-b041f6832bc1@nvidia.com>
Date: Tue, 20 May 2025 10:57:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Aaron Kling <webgeek1234@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
 <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
 <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
 <CALHNRZ-pu9HUzVyR3-U=XZKFFZPnn5-DNLWPqPx6CSoW0dHMrA@mail.gmail.com>
 <bc0a4c75-df5b-4b4d-9c9e-a2c99d3f4f6e@nvidia.com>
 <20250519103749.falgd64ikkwkfpg7@vireshk-i7>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250519103749.falgd64ikkwkfpg7@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0318.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e05eeaa-a9df-448e-b496-08dd9784cc5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3V5ZmRLbk00aWJrS3BlWWV6a2FvaklwdjZNa0ZtaVp0VnhuSlNPbTMyK2ha?=
 =?utf-8?B?SlpKazVjRHhSMzMxMkZsdnIwMnlJWUF4YVlqT08raW02NWpXN0hmWVVaVFpO?=
 =?utf-8?B?RXhLSkZtYUVKYzJxclJ4ekJYMC9KSnF0Q1gwRlVSb2dEeXFIT1lVblFTcG9S?=
 =?utf-8?B?SGNCNmY4V3c5bHY4UHlFNitKOGU1WndRVGhjVlVaWGlZdnh1SFlacG1KV2RS?=
 =?utf-8?B?MUwwUmFvY3RRdURTMVhHU2FEMmdJU1JLZlJwUkMzRjhsbXZqUGZEbmVUbzJt?=
 =?utf-8?B?Qk5PaHdXeW5DYnd4WHJtOXQ2ek1oL1Jja3FpWnBhbCtKQWsxZjZjMlU5VS90?=
 =?utf-8?B?NUtRbGJLc0FMdkNUTUpNWFE0eUNsNzVETUsyVURQbEFOSEFodkxPVEFmcGc0?=
 =?utf-8?B?SjdxSjZ1WHBqNlFtamxZUGUycGl3bWJuU1hHZ3FiV0NSY3Y0WWpDY1pkTTFK?=
 =?utf-8?B?cnFNZkpTM2FTajhsT0p2SW5ySS9xZmNDcjRSQzVRRUtKMTZiaVVKb1l6K0Q0?=
 =?utf-8?B?VmpUYXViTnM1cE9IcGpTcE5RMS8yS1pwL0Nrd09icDVtR2hvTzQraU1XZjhU?=
 =?utf-8?B?dUZYbUp4RUxVTlVwNDdLSUsvYU05S3VhYkpwSGJTcnJLZXcwb3h5RmR4Yll6?=
 =?utf-8?B?QWtyM1IvQnlKbUZKYlJkcHlaT2d5Sk9qMkNMclVrbVZmVmdTdXQyWVM3MzNy?=
 =?utf-8?B?MEcybU9Vcmlvb0RJQTJBRjhXRHRsME1PdmhkQ04vSGZKMmJKVFRZODhSWW1m?=
 =?utf-8?B?Wld6Wk1GaFpRd3BMekt6RGMrQ3JKUWZreGI5L0xlbERWTUxwNVBzbU9rQ3JU?=
 =?utf-8?B?UUdybjFONmo0b2ZrbXNDSFd5elRwUEVLSWFlTGxwdDVEaWxLUkgweGpaemtX?=
 =?utf-8?B?STN5R1ZkejBVNk5vdUw1SVNKSGRVdGlYc0NadVFIVGhWd25WalY2b003TlFl?=
 =?utf-8?B?RjdBYnlJUWhRNHdYY0Nrb3NtNllGdFFlTGFCcEF1VFpJUXk0a3N5N1BjUTRl?=
 =?utf-8?B?M3puSThCN01xWW1hTlFxVnlZcklEZXBTQkxRYWJudHlnMzZTNUdzYVp0aHMr?=
 =?utf-8?B?VDBKZ1VKN1JNVEdZd0lZdHNKb2ZVdTJsU0krVHM3NkNTZTNCM0EzY2pxQUI1?=
 =?utf-8?B?QTZqOHNJNDF5WmJMTExiUVVHZFl5NHN4ck1yNEdmYzRjQjA2NUh6eWoxUk8z?=
 =?utf-8?B?T2Iva20xTjFzVjFRRWtFTFRKZTJkTnVTTzhwQ3JpVUlKamM4NWZnR3RKVy9p?=
 =?utf-8?B?eE1sUTBBVWUxelM0WUZ0SlZFa1ZBaGZLYXlqZTFIRGg4dUNvdThPU0ZDQmNJ?=
 =?utf-8?B?Vm0wSDNQSS9jU3BITEx4YzByLzQ4blBTTzF1bnhsb1ZJWER3TUJzTDh0cVpX?=
 =?utf-8?B?THhnQitISWJERXlSY2k0VWxpZ1prOW40VTF0RFlFVmxyOUs5NEl0bC9mWE9r?=
 =?utf-8?B?UHB3SldjSEtuTFAweG1SS0VERHE1ZmRibFVNZTVwNzg2Z1JQMmJlSi9LeDRW?=
 =?utf-8?B?U2JGYy95RFgyc2tGWjBOKzl6UFV4ZlBTOWp5RThpdFVWLzVvVEVSSDhVTmRF?=
 =?utf-8?B?eWxMcUwycTU0ZUdKQStNd0xzNXNqcVN0Y2xMUXphVWZpMWFNOE0vQ0E0bzU1?=
 =?utf-8?B?OTZWRWtEYkg4Nnh0MzJDVnFsT0pyVUxLT09hTnA3cytBZG1sK2RiNFhYdDRS?=
 =?utf-8?B?M0xzR3VobFIyYlQ0eWlwcDQzT0dxazdpU0lSd2dPeDlMOEF4Z0hhcUExb3Nl?=
 =?utf-8?B?Z0MraC9rcFJIbUhkc3pZblRmY2JuQ2RSYzc3MWNrekdqbTl4ZkFWRmtPZjBW?=
 =?utf-8?B?a1hpcDlvd3RnWC9md2JvMkpwR3hiMlpTdUdVRVBjWXZCVHBlbVdSc2JicHRi?=
 =?utf-8?B?a3BCUzh6THFwa0pMb0tuL0x6L0RXT0hxRzVhaVNjRmhmdVFVb28zY212MjVJ?=
 =?utf-8?Q?bBtu+tvLjMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0EwbWxod0ZJRDNZVXZyQk9wZ1RBblR3TGxPaVA2VENXdDVDWkRDNW1wcTBn?=
 =?utf-8?B?N1JMSDAwWjJxL2doRy9iMS9zZkhuSDlMdVNZSTBMR1BaMWN0WldmVjlWNnhl?=
 =?utf-8?B?TU8rN01WQS8wbUFWWGxzUjJ2Z1NYcG8rdjhSQzg1YmttcWFUMUdEQUJJakpQ?=
 =?utf-8?B?SDJDRjdUZXpzdVk1bjhwMDIyWnRvcldFZEF5SGRyUGw1ZGJCalZIYTRtdllL?=
 =?utf-8?B?QW9lMDN1UDRxdzJmdzZ6ZGJ0Z3hmcVRHRzdTVUxURFpLVmJueHlBcExxa0pp?=
 =?utf-8?B?dTV4SXpwSDU4RGgyR2QrZmsvQmo5MnpLTCtQRzRTZFdMNm0rMmhNc0FXZDRz?=
 =?utf-8?B?OWhUN2JCWDgzWWgvdjBJVFZVWmZwNjgxSzh5V1MzYXhoWTFjT2lSV2FJQ0s5?=
 =?utf-8?B?TjYrd2Z2d3gyRTExWHQzOUhVLytra2FHMkpoSzJXU1FiVHpydWZWYitEenR0?=
 =?utf-8?B?cUdSRXlHa0t3TDZtS0ZrdThFQS91ZDdIMXVEZ1UyR1VmbVZyZVRWWEk3R09K?=
 =?utf-8?B?SXdSTUhMRGhHVkhQYTZpVWVFZEx4YzJGSG9zdjVIeXJuTFJyWTloQS9iVGxy?=
 =?utf-8?B?UFhEcHVmNWc4ZEVKZVdjbkgrNVd0K0NUeXVpVlFjZVVFRGlTUXBRODg5RTBP?=
 =?utf-8?B?b0lXNGFhMWNQUDU1QW40M1lOb2dhYTNMUUJiWUpDNXFuWGp4d3VWNHI0V2FY?=
 =?utf-8?B?Y3o4bFRjWHZNTmw1KzY3NTM0bGNxTE56L3MzeTZTdERUMWh5aXo2Z0hmWTR6?=
 =?utf-8?B?ZmJNL1FhaENxYzFERWx1bldmRkZSWmNOQkRFbDZ5UUJMUmVueHBHUFB6MXE2?=
 =?utf-8?B?WmFlMEJUQmpSTmpyRFFTL0NRVkk2bExuOGN6NllpTzFjRUJCekJSOHhGc0xD?=
 =?utf-8?B?bXhTYzN0TDRrKzN0dlM0aWpzeVUwdWsyR2ZXOVNBRTArditLcTVJOUZtcjJi?=
 =?utf-8?B?VkJxWkpSMmFUVEg4bHpzMURvL0F2Nnk5RzJaZ0tCR2x5bXdYejFUU1U1NEh1?=
 =?utf-8?B?K2NzTS91dXJ5TUd2ZTRqOHFxdWdFTVpGL0t5akg0SUNOVmZFRFNYbFNiK3NR?=
 =?utf-8?B?bUIwVUprYzdhRjVURW9sMmRKSVZHa3h0bTVVdGFoYVM0cWxVMVIxTHc4Tm5W?=
 =?utf-8?B?ZU9DbTlzeE1NWks4ejZMa0xwQS9abU96OG5lUFlISEJuQWpNL3BRZENDZWl2?=
 =?utf-8?B?VG4vSDU5WUgrRGNqUFRBd1BVZ0ptTVMrMFlNYTViUHF4SUFlUVNQWWU2c0hp?=
 =?utf-8?B?VHVmdW02QXBQcXN3aWJhM1hub1hTMWFKa1hNZ2h6YW10L2NVeXJ3SjJGMFJ4?=
 =?utf-8?B?bG5qclVsanJGNDZMblE5MWhZRkNndVRuekhBaHJSeENSc1Znd0huMHRwbU8v?=
 =?utf-8?B?VjBKN1lXOXIzanNsWlQyMjJwMmYrQ1orOGxwMGMzL1NMcG1aN2lFd2hxQXZx?=
 =?utf-8?B?OG1JQ2hCSzdTdWZHUVNCdGZSRlNPbHBSVGk0SFhFRmMvZWQyZGVsQ2lEOWRB?=
 =?utf-8?B?bGdRcWVVVitucEFIMW4zcll4RWNhQmoxS29pZ0FEYXFUblZBU25lUCt5TUFH?=
 =?utf-8?B?MHBHVnVJcGZVMnpQUGp2dll1OHNBRCtXM1Y4U3ZDTVRqRnk1RGhVTERrdlRG?=
 =?utf-8?B?RDUzem5KUjRCSUdpM0NRNHZTWXFIYTIzM0dLRUFoQkcxZXN3Nm5CVytldURp?=
 =?utf-8?B?SlZndzN4dlZoUm82eVBtdGdLQzFmVi96bnJtWVNlenZYU2ZrTXFFWVdQdFl0?=
 =?utf-8?B?KzExTVRpN0l2UlRkSlE3T2hhWXNyWXdVTzRyd2l5ZWZjSStyQ2hiK2tBRWh3?=
 =?utf-8?B?QWR4dUdVZkI3bnNhL2F4bTBvTUt5TXNwK0xNQ01XNVE3L1NUQ1J1dkxwYUpH?=
 =?utf-8?B?TzBxOW9KdFBNOWlGZ2s4ZmhXNS9WYi9odGRHUGRzbGtCSElHTGs0ZFE0R1BF?=
 =?utf-8?B?dnVoQTVhdW5ORU84TlRDN0xFMGxtclBoUld0TGhnQWJzTGRvOHJIMzN0Y1dO?=
 =?utf-8?B?b0JzVnU1SnB5Y2xIQ2U3MCsxdTltdk8weXJtLysxMFpGdlRoK01ZbFB1cm8v?=
 =?utf-8?B?UHBpeEhrMnA5YVBDdlczeWltOG9CWmJUVnZUeFhlVHc1ZW1VTjA3R0ljdnlF?=
 =?utf-8?B?WE1pRkFoYWdtNzZURVQ1SVZsL2tYdVdzeTZhVWxiVTMvR2JKemtzL3BDblpk?=
 =?utf-8?B?UWlqTHhjcDJXTGUrek9PdkhwVldaOEhqMUErd3V4N3pYT3g4U1lTM21MTEpK?=
 =?utf-8?B?K0E5M0Mxa0tNbzVMczNoWDlSR2V3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e05eeaa-a9df-448e-b496-08dd9784cc5e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 09:57:57.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZrvyBOuP4JH/Ayozcz+vdtSc16AQSk0flqikgIyXUvSY+rcWR+ttjP/7lHcME2ylt6ugAB4bXiCRAWFJgncAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920


On 19/05/2025 11:37, Viresh Kumar wrote:
> On 15-05-25, 07:41, Jon Hunter wrote:
>> Yes and that is understood. I see a few drivers calling ...
>>
>>   platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>>
>> One option, and I don't know if this would be acceptable, would be to add a
>> new wrapper function in the cpufreq-dt driver for the above that other
>> drivers could call and that would create the dependency you need.
> 
> Doing that won't be a problem, but I doubt if that is a better than
> adding a soft dependency here. I personally felt that the soft
> dependency may be the right way here. The cpufreq-dt file presents a
> driver, a device can be added from any file and that doesn't require
> the driver file to be inserted first. If the platform wants to
> simplify and create a dependency, a soft dependency looks okay.

The only downside of a soft dependency is that this driver could load 
but if the cpufreq-dt driver is missing for whatever reason, it might 
not be obvious. Ideally it is better if this driver does not load at all 
if the cpufreq-dt is not present.

Jon

-- 
nvpublic


