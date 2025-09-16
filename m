Return-Path: <linux-pm+bounces-34731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49148B597FC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 15:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C4D3AAAC1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B50231159A;
	Tue, 16 Sep 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jkQaK1jL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w0fDswQL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30128488D;
	Tue, 16 Sep 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030205; cv=fail; b=N1Emkky8Wo8CkhjjY+TrNpwvetbTxWTEYqyJrwAwl31RZ4R3IWH9KMOasiKMqGmkUQdFczWBuHhLW3SK114auA6eGJ+cvHAX4YX9vCV/YUTfTXGxhBLkdRoWMkBS6FFuGU4nA9J86BVdPokhikpPg5jytCzOE3xB1VTcTIe0evc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030205; c=relaxed/simple;
	bh=5XrKfo7CU3HWSACbd36BDRJ6fZCH0gB9ubkmMszt4ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DsYTffaGeRzPxyOZPI92ZnbHjpj+4GSJww6wMFsjl0soDvzYOzLH9a/kiwTwyen3Ang7Flpz2VJjF8STpagjmAjTe/A2i+GqzxQn9c0g0lICjAUu0Am11u4s1ybJKKdZNq4CMs2DlBFwdPsACcycUFJhXskKcvmKyqLlouPQ5Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jkQaK1jL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w0fDswQL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCiYAD029016;
	Tue, 16 Sep 2025 13:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2npbgMtv9No2rSNJdD1E2F/1xPOHikJnl48kUQTxsK0=; b=
	jkQaK1jLe2F1dVKAqGek5hsdRLOsslPQVE3YM4LiF/BKqCNZkNZFYgxZjRf2NWi9
	Ovscfr7wz3OYmOZgwlJlB0zGB46QB1S20qVR8hzmb7P1bD3ewDbOIXWNpgJpShVM
	PgqZxPlaNEAhGToYAQfg2fkUIdr+wxrCYT2NtRBcv3lregdClACAfHKUKOrW1h1G
	/fj7nbFTZhpliZCITY14pjCn9IposNFTtH/qLRmVE5pUEGV80WbpJpBOj7ab5LNi
	exJLgs4nGiBEzcRdt0qgd1nBrV0/dY5hR8Yurh/N1y+iE+zb4GFJbil5TqeTbly1
	RinqWhAKIt/BF6To7LZYow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w4p6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:42:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GBuAw4028754;
	Tue, 16 Sep 2025 13:42:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cd0nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fui7pH4UaiLOKgm3oO9tFZu4kCSQF9VcHYfgiLQhSvUP8tCe943V+YMTW68/3b4ri+e03edB9B+7bJiNjBOOBctUP9GvW7v2k2/YVBvN/6yxlMfiMIfZP1ykTv+xVrsQIiBufrQAbKEGpYgyb4S+fZWQRlRLT067Y6WJ1kf1KGWIS9Meuwh9lUCMM0mHKDI3fkie7gFcT5XmFXMbZr54MILlj1d1/YQH688tWuDxnHGzQKIrFNTcmCXait30PPPTjt5N9ijcO3Dh3QoAvWVyoj+2pGOVQbEOZ0crkgNucN4SGhis2qBGZPjYIjwtNEmW+B1ze/s8LcasFepXYCaFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2npbgMtv9No2rSNJdD1E2F/1xPOHikJnl48kUQTxsK0=;
 b=ulOCAio2rd9s5wK6jpyO8MDUhNIvD/Eg5UlREt7V842bkgLn/Qn4xHbdaMM1uMAzYY4p+JpUvzOzBdCUo8euJmDkK/guy1Pmr1zurDsg3Rg4PO9V9jd2RWURTlYb3wM5stq+egGF0dRmRUS0Wjz1+Ne75D4HFgMyC6+VEyqdRBZ1T8eWcaNeXqxnH92kW3baJRif9zks0kvwS8vcH+/MSWiWbQS9MsZkjiT9PmeJAG/G/vJdEiiTUaylZkFiQ0YWWmKXN5xndA9sfoWxJ0KtLI0wc84oQfW1HOg/00r0zT9jdKNqE1cMRXXopGdTGGsI4TAma2lJn7TAs/VIE6yoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2npbgMtv9No2rSNJdD1E2F/1xPOHikJnl48kUQTxsK0=;
 b=w0fDswQL5HwnZ38FVpcUCdnZHDw9P0n0x6UoA3AsPqIGHzFIBXWIGMUl/qNDroCwfx0whEpOOvku4uZ2fNyL+8gJQJwE/1d/WpAU0wbhfTh/TNyZkvThRXUgodyADknzk0/8RCD+J5Xk8dOni5u/EYmp4zmPKJsk56Zuj5fD1Ak=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 13:42:33 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 13:42:33 +0000
Date: Tue, 16 Sep 2025 09:42:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: mhocko@suse.com, rientjes@google.com, shakeel.butt@linux.dev,
        akpm@linux-foundation.org, tglx@linutronix.de,
        lorenzo.stoakes@oracle.com, surenb@google.com, lenb@kernel.org,
        rafael@kernel.org, pavel@kernel.org, linux-mm@kvack.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v10 1/2] mm/oom_kill: Thaw the entire OOM victim process
Message-ID: <jnvm77cg4egdxjcwn3kto6zrl4yqtlxf5bkzoy2ndhldu7vrwk@tewpuse6yp4g>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	zhongjinji <zhongjinji@honor.com>, mhocko@suse.com, rientjes@google.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, tglx@linutronix.de, lorenzo.stoakes@oracle.com, 
	surenb@google.com, lenb@kernel.org, rafael@kernel.org, pavel@kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liulu.liu@honor.com, feng.han@honor.com
References: <20250915162946.5515-1-zhongjinji@honor.com>
 <20250915162946.5515-2-zhongjinji@honor.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915162946.5515-2-zhongjinji@honor.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: c461f011-f3f3-4205-9068-08ddf526e35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWVrUTd4TTNvTDc3WnhKOGcvQlBPaVVTQzZNNU5YdHlmakdISjlNTFRzRjN6?=
 =?utf-8?B?MExJV3pwazdxeDhPclZkdVNzSjQ0WjlHei84SDlnUlRmNWZ4ZE43TkNQSDVO?=
 =?utf-8?B?d3NEdEZobUZ4S1lGSkJhNFhUbmRuT0U3R3d3MUZIRWFPbHlaS21Pa3VJSmxJ?=
 =?utf-8?B?OUFMa3VMTTd6NllhZm5tMG1FVEh1M3BEUkgxY2lLdEJhcWFhWUkwT1JlQTNt?=
 =?utf-8?B?SU1EcC9qRS92Mm9aTGNkd2FWVitRL3dHOVQvckkrbjJxeC9raUVxUkV3S1Rv?=
 =?utf-8?B?S3Q0OFBUY014SENqN1cyL1VnVkdPV3l1YVczcUk5cE13TUEvenVlTzBGNlVD?=
 =?utf-8?B?NFBuNXY5YlNGTmYrU284R1ZMQzlTcFJNMmpseTR0a2dSRVJndktudXhtbUZm?=
 =?utf-8?B?S3FyM1VuRERYTFh4QmFLUlVjRjdUMXZYak1jaFRnTXZrem5qek80SWE5RVU3?=
 =?utf-8?B?ZGdUaVM5Q1lDbEdranh2VzJoWDVlVzFMSmRuVTJyVVBoTVlFUHRJWURSL1I3?=
 =?utf-8?B?UFA5MWtXL2N1V1MraWExZEltZlhqTVRvNHpEUkdlOEcvOE0rbkpzKzNXQkRW?=
 =?utf-8?B?bUR4eE5TWTBva0JNazl5TVFpTDhwNzFoZDRBZEpRRXhDWmNBNDRDV2lpWmR0?=
 =?utf-8?B?SFhRYXVSZktsckx2L0lhcXRMd3NEM2U5NnM3OVR1OFhIZzMxYnRqTDNVV1JU?=
 =?utf-8?B?RC94RWpZZlpkQ1pGczI4NDh3dGpuaTFTVHNnZ0wyVWtJUUxLYVZIWnprUGxu?=
 =?utf-8?B?TVZiZVZsYXV3SzVvdTQ1dzNvVFd2SHF4c29NMzNoSHRySEFZL3N6MnFhRmNF?=
 =?utf-8?B?RC9USzM3ZWdWaktTcGFaQlZ1M0E3U1FQSnNEckp5LzhIYUNzTGZqWVlSU212?=
 =?utf-8?B?bjE1MDlBQ1N4VDJZdjRXelJQTENicDVXR0lIMWlwVXdGTEJwT0cyTFNaOXJI?=
 =?utf-8?B?dVVFMTZIZi80T25MZTBrVDUwT2pUdDBlUzFLRmovMVcxQjVhSUFydENKT1ha?=
 =?utf-8?B?cEJjaTBKV2Z4M0pnVWIwZTBDdG9vRUF2NWwwMWxaMWM4YTMxWjJpN2xoZks1?=
 =?utf-8?B?dTBNNkZFTDlPdks2N0RaWVVjYmtoMmNvWFFCOG9qK0c0MURDN1prckFuRWlI?=
 =?utf-8?B?R1lta0JCMmtpa2lOSnUzaWkxVTRZUlJFbXBqaDZkcG9jblFFU2ZRcS9VZEpX?=
 =?utf-8?B?c3kxdmEzNENrZzJWaWFEZnYzZjZwaFBUSTFCcDhhVUF5OGZWcWRQRW9lVDZr?=
 =?utf-8?B?aUMvb3ZHLzRNQzJKVXVadytqcE1jZ2Q1WEhraDQ0TW9HbzQ0M1JpR0ZiY1lt?=
 =?utf-8?B?NXZqdUF0UzdLUGg2bTJ2Rlg3ZXk4bTVCR29uRlRxejlrd08rVlgrWjlpSUll?=
 =?utf-8?B?Nm9KWkdqdyt3eHptdzRjNGJ1VC9jL3E5b3FsWFNrQlRYWEczUnBvSjlBdnJk?=
 =?utf-8?B?UmEyQ1JJZkoxaVR1cG10NnBjcEFQL1J4NmIxSTl6aWQ2QjdQa1Q0dS9BSm1l?=
 =?utf-8?B?SjFULzF1VWdKRENOc1gxOUw3cXdjQWNJQkxVNmlqeElueEFhN29tUE5mZmFN?=
 =?utf-8?B?dzJtcVpZT2l3Mjd4TGxVdHdQTysyNWkzWjNlNk8rRkhOUk5aeTB0cXJvUldD?=
 =?utf-8?B?YVhTTXVpQVo5NS95RkQ1UlhjWldSbWtDZ0U0SW1xSXJkeG5UMEFaT1RmMDB5?=
 =?utf-8?B?RXFGeFVpNFFJZUVWd0lMSUJ3UWNlbFcxOGR4V2ZtMXZ6c0h6NUg0MGFZU2dN?=
 =?utf-8?B?d2QrN01LcVk3bkhva3lNcWdQWVdJYlR3U1JhQ2x1a3hKZlJOSmVXUGdLMng0?=
 =?utf-8?B?a0s3YkM0bnVQRWtMTlJ1ZkEzdENCeDY3Z3Q4dmJwbEZhdE53K3E3QmljeDZU?=
 =?utf-8?B?NHNsTnF0a3UxOG1jTEpKbHAzKzJDMS9zY0R2UEluWU9SRklQNkNxcnhBRHlL?=
 =?utf-8?Q?XcgWgyFfyFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmpDUzlnbnBGWm9nYXNBazV1bmlsaHovcGdnMDVUZnpyWkFMUlgxZ1NCaWd4?=
 =?utf-8?B?OFRxRmVZazZPd2h6Zms0eWZxQTlRck1KRUw2ai9DZzJvYW5uSTk3MU9pZ3Bx?=
 =?utf-8?B?ank1ODd0eSs5MnBZdmUzWmZlTTJ3L2o5Tm9vdUR2T2R0eGo0czA2YUYreFdD?=
 =?utf-8?B?TjNvazY1YmI5V0JBSWNZeDc3T1k5SDFvemo3QWVmWVFIRzRQdW1vT3RPYTRT?=
 =?utf-8?B?QzJKMDhmRytQU0ZISzNQcHdtRllzS2s2a2VoTTdoYWYvY1NTR3lCaWZoejdP?=
 =?utf-8?B?QWRDM2NHSk1WZExEL2ZoRzVxYmJBODFYN1NpQlR2aGtmUmd0RDdYdGhveTBz?=
 =?utf-8?B?SHQweXlpc2ZpUExCTS9uVmlTM0tCcDRWM3RxWVBvNXBpU1pyZ3pKTzlwM3p6?=
 =?utf-8?B?YmZNcU9BMkU3YWllTGVWa2ZiNkxLdldGMXFBMDZKNG5HdTJoZDIzMmV5QzlK?=
 =?utf-8?B?Y0FNZm1BenlseU5FMVVoK3ZJVThMV0VBL1V2VS8wL2Y2VVhzVC9MYjVuTjE3?=
 =?utf-8?B?cEQ2SUthN2h0S0ZiNDZKQlVOWGNtTm9sYjIwL3BxeDdidzlhVHMwK3Yvc1J6?=
 =?utf-8?B?a1BDWEtKZDdPMGVKQzdHRHJ2b0tRVGtrMjFRbVRVOUR1VUZRY1hDS093YnhY?=
 =?utf-8?B?OHh1OVNSRHE2cFpLZGhJZUhLY2pnOGJYVFgwbmNpSzBteHFPSnhzZ2xBQW9R?=
 =?utf-8?B?YTFGaFZDSmpJUmZCT1V4RmZLS0h0S1FIQU1wcjY4bi9sZlhUeGRDVVNQMDI5?=
 =?utf-8?B?cmxIRWhuTEVlZGxremY0Zk1OZmpaZy96MHFXY0dtUTdFNkdyQTV4aEZmc3lm?=
 =?utf-8?B?SHNlTmkyWWk0QmdUVGI4Z05tZnpGYUU5dUFRTG5XbVNjaGhxYXVjOFFRd2hT?=
 =?utf-8?B?U1dLRGZBbzBjNDZOdzlObTQyMmhRWmt0RXRUQnFkQ3JnL0hnWVdueXVDYmNh?=
 =?utf-8?B?eXJwS0Z2Q0JOZVh0UkNhcW01d0hkL051MWM5Ym1FUDNUNm9QYVJ1NW9zVzFo?=
 =?utf-8?B?TWlWU1QwaGMzOGg1b1ZFWEJ1VUxqb2J6VDFMcWVyWTlXeHNHWlJNVkVhRjl5?=
 =?utf-8?B?dHZvL0lrRVRVdlI2dmY5d1ROQVhTWTFBVnZhOCtjWVpVY2RGVVlNVXd5RHJn?=
 =?utf-8?B?VlIwdVp0Z1Q5bzZZTk11MnJpUG5sZXNBTmVXaTJ1eEtqYVlYRU9mc01nNjZC?=
 =?utf-8?B?MHFSOTJrVVJWVkY0ZHVidWhhTXlabnhUUXQxSzQ3NmN3a1pETkdVYm0rMjlz?=
 =?utf-8?B?SGRNMWhOMURzLzF0MUJkMzh0dVptNElwQlVMVkU1cENNZEV3R0ZYNXpHVFRx?=
 =?utf-8?B?aDRndG93WGVwSEUzK2VFcytPY0Q3cVJXT2xUdmRSS3RuZmNrUnA1WTFSVis1?=
 =?utf-8?B?U3ovclZleWQ4eXdlVGd2bjMzRTZmSTdYczJkZWxvcGZYd2poOXJhcFhaMEs3?=
 =?utf-8?B?Wjk0K3RsT01oVzVnRlgrS0gvWDhoa2w2Z2Fra25XUktNWnZRNEJkOEszQnpT?=
 =?utf-8?B?S3MzYkEra0ZCTUozNDMwZFZmb09WWHg4TDBnUm9aTGYyNGxFSGl0dEVLekJN?=
 =?utf-8?B?WXhBZEp1ckUxZTBEVm80RTdsY3h4QzRpYnB4U1N1bVI2M3NFNkVxSC96cE52?=
 =?utf-8?B?VElTQ1VabFExeDBLbkY5bFNWOFdDSEtBZUxwVjhtNVZkeDJJNzA5VVZEeU1H?=
 =?utf-8?B?Z2ZVcjBmcmVJd3dzNGxkUzl0SUUxTUllNTFIREZmZkgzaFFsVFB3QUFObDZ0?=
 =?utf-8?B?bHZhSlZhck9zYkJqNmMvMWUxQ3lvMDlIenIwQXJaT1RNYXlkZjIvSDFHZ3No?=
 =?utf-8?B?M2IzZ1ZpTGxRWFNKSWZUOWZJRXp6b2xJWStWc3F5MUdxVzROOXl2NVh6Yjll?=
 =?utf-8?B?Ykcrb3lFWXVrN2J6ekxVSGtlZjRzTElIVGpVMzlNMXYwMmtuWTFzajdwcDVZ?=
 =?utf-8?B?TDcvTVFPR3pCNmtFQk1UZFpXc04vSTlZVm1MVk9pb2syNlNYdjBpU042bFp0?=
 =?utf-8?B?anFWRjRqTktYdzg1WDV3YXJhRlEvQUJkb0o4TXpLS2Y0R2FzUUl6bVJUZFlZ?=
 =?utf-8?B?V0EwQ215MFBic1NFck9vQmo0VC9QUjNLV05FNmtiM2tJOXdRc1I4WnBtbmls?=
 =?utf-8?Q?+sPTeVPKvuVPMLHcLTtOM9wXU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UWE6jrhs7Y0DK+/H9m/5++otBdgN528vWyHL7pFL5S3ZBYq/JWewEdjhamt02MS7XI8nzyfq2TkkpEDT77G2T/IE27lL6xpX2l/8hSKghj1tcLFyR2qqq51KrxMijVgZuqgP7YL6/2pD0v8HGn0Z1iqqJtMTraLHPPxqJBmUlhLdKNUZnvV8udTnxMt//3coyb1nP/hBMJnmZ8h7CiIfNnBWmG8jmO5aRpQOvilQ53fVoXFbGPuu5VxxbM3n8/X0lGd6mm00Wi9pW/dcwUIjXFTKPpI/Ga10LOghb6jZZ0qy34fq2dwT8ehSvXoXX/ZO3iDxRIglsOiXRHphUr3KaLUIhpczlJKOmQ3o9gUzmn3q1l/4zsgIlMdD5TiDoVHwNJqNiRFYA0BIrueloGV8RWXK92j45DStdHMp+2K5PAW6Hkpiwo5OQsdyeYK+Dz3/zG4zJo0sxXb0sCTzhP8XVnGCVN51rPLjdG2TZLLcm7U7Cm4t0Y53p7+q0TVopBFIVJRCGQBKzD92gFYMm87cysk2y91bBlOplYXpPfyq7SmziwrZcXdG1VWdMzYn5wBJv50NUuluRPmeeZAShHCl2H1TDWtn/an5aosoSnP4wGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c461f011-f3f3-4205-9068-08ddf526e35f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 13:42:33.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8IaxzU4lCimmY11l0mZFod19MfUW8xANCxCrxyVG+0i7WS+Bg0Dq1xyDBlvyJWSNdJMVe5kczzF+3rmqOKqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfXzQMazN0YagVp
 JUqWUyAnYuMvA5I5eUE9PmMBqU6aJEaJLSM1g/Ffntnwlll/4GIqFKHX2a09rE/+wbqqCNhJjWb
 NQFQ87MOq3roNCmLlcWbdWeuq+iK6uq0wxcdCIVb0hwRKRhYk+w11ZlKmy1g79PoixyQjwgxzK+
 X//cZQZzYHkXoO2J6xFKFuvM2TNHC10RlUZ8Ej0jM2X9bYkJgpUgoPuwdRBuhZUH+5ICTWyONZ5
 TvtGHuoIhE3viKLHBpUbLCvDqxoAVbcu6luqt3QTETSmWfSNGGHkJWjqnVDSRtTNzFI/Taik0id
 8DljxUa8OOVgMBrwJDDqO2D8ZkFu9340djnYWjSn+rIEvHM/Mqwo9UiBVHhqluXsJvbOQCx02YP
 l3MzQagN
X-Proofpoint-ORIG-GUID: 5Sz7_TVkRD8jePM4WJTVZubPbrmBnA6l
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c9694d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=CvlTB2HrAAAA:8 a=1XWaLZrsAAAA:8
 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=DB5hq9TB9dDAFfQf2I4A:9 a=QEXdDO2ut3YA:10
 a=67QrwF-mucXG56UA-v15:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: 5Sz7_TVkRD8jePM4WJTVZubPbrmBnA6l

* zhongjinji <zhongjinji@honor.com> [250915 12:30]:
> OOM killer is a mechanism that selects and kills processes when the syste=
m
> runs out of memory to reclaim resources and keep the system stable. But t=
he
> oom victim cannot terminate on its own when it is frozen, even if the OOM
> victim task is thawed through __thaw_task(). This is because __thaw_task(=
) can
> only thaw a single OOM victim thread, and cannot thaw the entire OOM vict=
im
> process.
>=20
> In addition, freezing_slow_path() determines whether a task is an OOM vic=
tim
> by checking the task=E2=80=99s TIF_MEMDIE flag. When a task is identified=
 as an OOM
> victim, the freezer bypasses both PM freezing and cgroup freezing states =
to
> thaw it.
>=20
> Historically, TIF_MEMDIE was a "this is the oom victim & it has access to
> memory reserves" flag in the past. It has that thread vs. process problem=
s
> and tsk_is_oom_victim was introduced later to get rid of them and other
> issues as well as the guarantee that we can identify the oom victim's mm
> reliably for other oom_reaper.
>=20
> Therefore, thaw_process() is introduced to unfreeze all threads within th=
e
> OOM victim process, ensuring that every thread is properly thawed. The fr=
eezer
> now uses tsk_is_oom_victim() to determine OOM victim status, allowing all
> victim threads to be unfrozen as necessary.
>=20
> With this change, the entire OOM victim process will be thawed when an OO=
M
> event occurs, ensuring that the victim can terminate on its own.
>=20
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>=20
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>


> ---
>  include/linux/freezer.h |  2 ++
>  kernel/freezer.c        | 20 +++++++++++++++++++-
>  mm/oom_kill.c           | 10 +++++-----
>  3 files changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index b303472255be..32884c9721e5 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -47,6 +47,7 @@ extern int freeze_processes(void);
>  extern int freeze_kernel_threads(void);
>  extern void thaw_processes(void);
>  extern void thaw_kernel_threads(void);
> +extern void thaw_process(struct task_struct *p);
> =20
>  static inline bool try_to_freeze(void)
>  {
> @@ -80,6 +81,7 @@ static inline int freeze_processes(void) { return -ENOS=
YS; }
>  static inline int freeze_kernel_threads(void) { return -ENOSYS; }
>  static inline void thaw_processes(void) {}
>  static inline void thaw_kernel_threads(void) {}
> +static inline void thaw_process(struct task_struct *p) {}
> =20
>  static inline bool try_to_freeze(void) { return false; }
> =20
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 6a96149aede9..ddc11a8bd2ea 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -10,6 +10,7 @@
>  #include <linux/export.h>
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
> +#include <linux/oom.h>
>  #include <linux/kthread.h>
> =20
>  /* total number of freezing conditions in effect */
> @@ -40,7 +41,7 @@ bool freezing_slow_path(struct task_struct *p)
>  	if (p->flags & (PF_NOFREEZE | PF_SUSPEND_TASK))
>  		return false;
> =20
> -	if (test_tsk_thread_flag(p, TIF_MEMDIE))
> +	if (tsk_is_oom_victim(p))
>  		return false;
> =20
>  	if (pm_nosig_freezing || cgroup_freezing(p))
> @@ -206,6 +207,23 @@ void __thaw_task(struct task_struct *p)
>  		wake_up_state(p, TASK_FROZEN);
>  }
> =20
> +/*
> + * thaw_process - Thaw a frozen process
> + * @p: the process to be thawed
> + *
> + * Iterate over all threads of @p and call __thaw_task() on each.
> + */
> +void thaw_process(struct task_struct *p)
> +{
> +	struct task_struct *t;
> +
> +	rcu_read_lock();
> +	for_each_thread(p, t) {
> +		__thaw_task(t);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * set_freezable - make %current freezable
>   *
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..88356b66cc35 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -772,12 +772,12 @@ static void mark_oom_victim(struct task_struct *tsk=
)
>  		mmgrab(tsk->signal->oom_mm);
> =20
>  	/*
> -	 * Make sure that the task is woken up from uninterruptible sleep
> -	 * if it is frozen because OOM killer wouldn't be able to free
> -	 * any memory and livelock. freezing_slow_path will tell the freezer
> -	 * that TIF_MEMDIE tasks should be ignored.
> +	 * Make sure that the process is woken up from uninterruptible sleep
> +	 * if it is frozen because OOM killer wouldn't be able to free any
> +	 * memory and livelock. The freezer will thaw the tasks that are OOM
> +	 * victims regardless of the PM freezing and cgroup freezing states.
>  	 */
> -	__thaw_task(tsk);
> +	thaw_process(tsk);
>  	atomic_inc(&oom_victims);
>  	cred =3D get_task_cred(tsk);
>  	trace_mark_victim(tsk, cred->uid.val);
> --=20
> 2.17.1
>=20

