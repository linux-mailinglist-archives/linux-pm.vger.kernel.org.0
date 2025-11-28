Return-Path: <linux-pm+bounces-38866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F77C9106E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 08:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB1884E5379
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318EA2D6E59;
	Fri, 28 Nov 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NRN6JAQt"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013025.outbound.protection.outlook.com [40.107.44.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60E2D6608;
	Fri, 28 Nov 2025 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314428; cv=fail; b=ZTXJuPfFHHIJPpvLr+E8RZsADnGLHX3qYHlM3DjR25aw2lZiMD/DopaXDZG5b2A1iMFhfjk86+Y0M48VP6/fELSec/rM/ot4J8mFbhfM9jdoXNLJ9iAw/UxZrbBpJ5QzHeAudEwuDN2/GNCJ3nKwTtYSqq3T0S+XeYs0ggLdvUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314428; c=relaxed/simple;
	bh=olvJl5LrvZm1XjIpMUV9tFsH+RLJ5crUOVMo/zI/Xas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lmYeuwCBdqiBTRtO7hEx/DOgsXpwH7FcDFhZ6+jcsypLd4l+4WE6S727fyjJBV5OBi/8l1QGcfFBjeWCqS5oXXWiZB2cHmsJtQNSjzp5CpnSF1VZL1efDweAifrOOwWXoqv1RB+0kicZ+1/zVWH6pxNdv/TL1jOb42BKVh7Yx2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NRN6JAQt; arc=fail smtp.client-ip=40.107.44.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBYoCB4rpD9tvnG0AwlD2xs5J4qQMHbFonKopv7jbFv/1Ud56KmFyt6LKvXhIuBuhNi9MW5eMRDpoK1I9RxPvG68WNcEybypElKERyRtU3oAPOwnIPVictxebWB5bod71Ryp5oRzBdXZt3tehNr0O80yro0Py8P7jW3rbl136Y0mgrXKxxFMWxptzGYJ+V49gYetc5zO5H2cBQzqYc5wYCQ5TbFWXx3lTABu3dWnxQfgd4dU9UQ2PKyrdJnm2+H+dO5Wpfnk41oqNc3i8wClH3jlZEGrq5nYmMD6oXc/EohFTRu8pYX2CSeThis76Tz5eISZrzbA0L9RIJV3a+TOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Jwb/pbMVcJr8uTSM/t5DgK6ilzDeNpjfHjneD04Ms=;
 b=pTiPqhHZegZJybobZsotCAmviSYPvR7q25qsqy3FtNT9N6TkHpLehbeF8tmDH34F21mC4celkfdszdREyuMkPIcXKOotl6Am4IqJvXdYta8AYSMwQw69rFub86pfytWDkvE8+jvc5A6mH9rKS7sut30ciDcWRoCgj78LuMspqwdQiVhRnd0l3iYhR772ZyV+BTGzPZQTwMHT7GuAsey41c1H7OU3P7fH36eHNv/OE2sDPys5HAnwu3G3sjLzVMqF4ltyXTYa+bNHmT0XDxBs1Dr7Cul5BckUyPE6Tad0/u5xWCoAQllzaEV1sHjKlE6soOu1VecxY7kY6ssE2LXBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Jwb/pbMVcJr8uTSM/t5DgK6ilzDeNpjfHjneD04Ms=;
 b=NRN6JAQtJGLot6lx6GF/zILJhYPdR+1LEGngC3sdUesNLp0iOZ1emnUz40ozVW2J49NCN7Wj3JFF0LrBCjL2sijJ/x42P/vDMkmB5qV0Hr5opCfddvsI7X3mrs5PsjqYXpsMK51z/vu3fKyaWXhVnVZXOpKvrhDn7ORz+bi1m+5p4yJEa/Tjh4erZXxjVDF6BEL/pTBPUumFQ305TC+tKWxnsmbQHnFX0Cilm5N+mDi2SOj7i6G76zzPpzT2shl6eG8C/hgfDkL4+xJZkG7LqGiOumdQ2MOdfPQbeleSI/8NJyOOfYkvZQNVbqbri0/sviCHwpZ+ooC0U3qMin5WPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEYPR06MB8222.apcprd06.prod.outlook.com (2603:1096:101:2f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 07:20:20 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 07:20:20 +0000
Message-ID: <18d454ab-1a14-4e7c-90e7-831ec4d7ddae@vivo.com>
Date: Fri, 28 Nov 2025 15:20:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
 <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com>
 <CAJZ5v0iSgrLzsjh+bvF2=rxxhYcBetJ6V-joWaQud4ahkm1GkQ@mail.gmail.com>
 <9b6e7d55-6a1f-490e-98c7-3c04f85f7444@acm.org>
 <CAJZ5v0hJw0WdHpqgUc5bz5qCSUNNKHg7i5-sNYeZcDYwRj21qw@mail.gmail.com>
 <6df79ec0-f5b3-4d75-95b1-03e488d45e7f@acm.org>
 <4f4dea0a-21b1-438c-94ae-9a785ad42569@vivo.com>
 <CAJZ5v0h-Dsi=Z2cRye39PVxgw3fyNdfsZynvzo2QaYrT-nNnow@mail.gmail.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <CAJZ5v0h-Dsi=Z2cRye39PVxgw3fyNdfsZynvzo2QaYrT-nNnow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEYPR06MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e3878c-15e5-4aac-e85b-08de2e4e9679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUdiU0hFMmxNVW9jSWZZYU9Eb3daQU1wdlEyTWhHSDRqTmY3ZC9DN0ZQNnpM?=
 =?utf-8?B?eVlVblpXTGw5ZDA0TUJSbWRGUTdyUmJYQjdmQUh0ZTFyNlpKbml2VTRUeW42?=
 =?utf-8?B?MEt5K2FjNWhtZjdGOGY5U3B5VHpJRGx1QmZQcWVXeXZmT1VrOGNsalR2QWpY?=
 =?utf-8?B?dDQ1NFZIbFB0UTVLZjNYNm5OVVozVDNsUE5KUEZ2YUJHQ3FwNnpyclRqRlZ2?=
 =?utf-8?B?TkhSVkF1ak9oMDRlb0ZPN1dJZjlxRnljTENzR3FwVzYxM1krbTQwTkdxSVJX?=
 =?utf-8?B?V2Z1OUpZakxFK1JJQXExNkZKYmtLRW5JSHp1OVVkTEtNbDBLNUNuYkdxcjFY?=
 =?utf-8?B?eHYyT1krSVBwa1MydlpUQ0tPUEFyMkVCcFUwNldrcUcya2gxNGZHM28zcnBD?=
 =?utf-8?B?azh0S0ZqdFdqbjFSSXVKdTlRQ0hCUzI4cENSSWNVL3psdUxoT0NDVFNPQkVa?=
 =?utf-8?B?Nytid25kWmJOM1pRYThwNjc3WjNObEZEcE50WmhwelJzZkZYOWtKd2xlMVow?=
 =?utf-8?B?QkViTDJ3U20rT21FVUh1eHh6cVl3MkhlcWMvKzg0d1p1eXNQclVORlhZczI3?=
 =?utf-8?B?R1FHL28ydmw2WkQ1dXB5NHR1Z3VIY1BORzFjcUg2aU5zVmduYXkrQW1NYlZX?=
 =?utf-8?B?R2Q4RGhuUVNVbnpCUkpTTUJuMUcyWUtxbk1NZ2hzRWdCdmNmTjhROUl4OG9Q?=
 =?utf-8?B?YWsyYmo0ZmtMaFp3d2Vmd3UwWjRoOUoxek5kdnlMUlhLdHV2cnN6TTZtZVYv?=
 =?utf-8?B?Qm51OERpcTVHck5XM2R1amxjT0FENVNpOEwvelNoeEVwelNBRkVLcWVTbDNm?=
 =?utf-8?B?dGZiaWVqRjAzQ2NuUmtPd3AxZkR3NCsvSzllYzA0YmtXekFVaUlrK2JGWnFj?=
 =?utf-8?B?c2w5RlpFMmk4bkgvSGhRMW9rdThNSmUreDJFMDB0Rk9rUzFRdHZxbHZsTGsr?=
 =?utf-8?B?bVpQR1lwZnpsNUdXMDkrQ3lseTRVZnU0RVNZRy9ab2lQeFNubktGOTAxSkdN?=
 =?utf-8?B?VTh2MDJtL21wTlVHZHJ1b3Q5K0JVWFFMeStuODl2SVo4bW16bTZHaFdqTTlD?=
 =?utf-8?B?dVNuWENhQ01zSEhpVUFSK2l0Wm9zSDNISzJoMjRqVERrOVAvMHA2ZE5yOWFX?=
 =?utf-8?B?emkyN2NzRXJVWEZlcVJYdXcyZklTcVNaT2dGMkVHYXlpNkFYRUZUYjBhcE1L?=
 =?utf-8?B?ZThadnBrVXpYUm11TzZPQUR4OEtZMTZoelZqcmRmb3dHN1JzUmZCOEVNc0N3?=
 =?utf-8?B?d3d6UThpQm13dnhWOFpZVHhmQkJlUElUVytFdVNjSmF2SFpoME1DdFNtcTFT?=
 =?utf-8?B?SGFHSEVLVTh0WVNZV09yNmhkYzhwRk9yQnVpSlhJanVUdlJYK2Uxa3pPZnhE?=
 =?utf-8?B?NGY1R3RncnMxcFdpTWpiN1NkMklzcGRNVXRZTVVZNnRPZTVtNjRJTnRlNE9B?=
 =?utf-8?B?WXlaUS9zTTYzN0lFd0ZPRXVPeFZyL0pGNVpvMHZ2WGFISEY4TUU3Q1BGTTcw?=
 =?utf-8?B?Q2ZPYXExbm93ZWQ5N2FSaDV1bThGRHk5VndudytCTjJSYmI1a0toYWk0YjlU?=
 =?utf-8?B?SU4vci91R0FQMmljZGVHcStsVEY0VjdSWFFuQlhmNG5JNzc0YnM3bEFtTURj?=
 =?utf-8?B?NnhvRk9xOUsvRFRwZm1UaGp0VklWMzQxRW85RDRjVmh0TXpIZE0vclJINTZE?=
 =?utf-8?B?MjN0cm56Y1RsaHJKNUdRdFBJUEZZTUhYOWtkOGN3QUF4N2JPWEY2U2pkVW4z?=
 =?utf-8?B?a1JPcGsyenFlakZsUVkzOVc2NzNVR0VqbmU5KzR4blZESkgvaWx1NHlpYWlQ?=
 =?utf-8?B?ZzJ5a0NGWFJTUXBjbFNZb2VINDlCalVNSGptMW5zUTBUQ0NyYk4yUzFCNFJt?=
 =?utf-8?B?aE1HcUhSS1lFZ0x0b002YmlBbTIzZElFRVpvazkveU9uR3Yyc212U1Nyc29n?=
 =?utf-8?Q?ffDa/7POLRcGHLCRf7wQUFEM03+BSKlE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFFYSjJ0WURraVBZL3Z4bGwxdFQ4TVUzaGFmak1XelZ2TVQ3Qk40N3BtRkNU?=
 =?utf-8?B?d3RjZ2NBS0RiRk1jMVJYNytsRU9VVnFzKzZFVXcyaUNMOStQOEkzU2JLL29H?=
 =?utf-8?B?ZDdiaUt3bG8xeUduZjV2amozMUR6Y3Z2QlZ5MVZXcFVOR09kSDNENHpWTFpS?=
 =?utf-8?B?czAwMVlmOFE3WmlmMnNlek5uZjZjOUlOOVEvT2NwVDA1dXYyQkhXbzlBaGhm?=
 =?utf-8?B?Ylg0TDIveEYwVXRveXZoMWJMV3Q2Q2g3TEk0L0t4ZGYya1dnM0pvMkZaZmxj?=
 =?utf-8?B?eWxBeVJuTXVLVXpQYWduOGFNMTY4SThDbDR0alRNUWhsVTJxR1BtalptL2tV?=
 =?utf-8?B?dndDUlhPVXZ2aVprc2VBUzVaNTJTS2x0VkRJeEhwWWJNaklOOTI1cTJIcHI3?=
 =?utf-8?B?Sk5mak55eW83V1YwWjlGeUx3RmpDZEo2YXNGVDZibk0yek5BZ1MxMVRMN2g4?=
 =?utf-8?B?RkxHWE5NTjJzNmJYYUtQY1kxVlZOaWdVVjA5VkIySU5OUVRScDEyZWxhU2x5?=
 =?utf-8?B?N1VUVGJ2aWZ0Ry9kL1lJVW9DQ1RoaGw4NWYvcDJUWTE0L1N3Z0lzbEgxWlpN?=
 =?utf-8?B?Z0UzUld2NWJFVnpBQ1k0a0NFVk8wMW9maGY4UEtidU9mTSt4MWhIZ2pycjNX?=
 =?utf-8?B?MnRsUWpEUUVKYTFEWTNYcm04elNnR3VEV0VNVEo3ZHowTE94MjNWZUs3em8r?=
 =?utf-8?B?MVRSUHV6L3F6VjdnT1VyZElLZWg1c0tlV3ZxYm9JYnZuNmw1SDYxSnJkS2Nv?=
 =?utf-8?B?czc0NEtackZPNzA4UzlJU1RMeDBTL0hqMSsrdGZPTGRRWVYwY3RTbW5WeHdh?=
 =?utf-8?B?c3EwMUJHUjdpT1d5dSt1NkF3Z0VtczNsT29vR3EyME1kSjBwVWkzS0ZCSFhG?=
 =?utf-8?B?dHdQc2dEdXBHeGVwVDlCM2RoMHJnRDhWMFVxd3FVZ0VpRlhLS2ozbEVjV0dW?=
 =?utf-8?B?UUxBbTBFRCt4TTNBMFpRcWFhUWx3VEdJRlk5dk9sV2lINTVPbFQxK2pLdFo4?=
 =?utf-8?B?SE90b3pWTGhaZ0NUaHRwclBlRlNlT2hCcGw0Z1l4YVBpejJWbndVMXVzNGRV?=
 =?utf-8?B?bnRxOGtZODE4V2tSVkdZUlRWQmdRN0tmVUV4VCtrQlhNUEpIM3RybGtEaG12?=
 =?utf-8?B?UlFTajdlYWF3VWNsTU0xbFo5VUo2ZTM4a052QmtubUM1d1JoWW0zQmhMUVJs?=
 =?utf-8?B?OFB2b3FYOVRwMG5UeE9GS254d1pNMU15endCenpWeGRPWEFod2JReFIvVStv?=
 =?utf-8?B?YjA3T1BDRGl5OU13aVZobmxaZmVJV0Y2aDgzR1hqQys3SmMxUkVOa0tNRXpK?=
 =?utf-8?B?WHhpdWI3YWxCTmkyQVJDVTMxYTByejgyNVJvN3ZGMlp4OFRoVkIxQjIrNncw?=
 =?utf-8?B?eDJQNFp5eEVLN1hSalRNMk9mNGdiMDdLSEtMM0ZxdDhxTlprRlJzRGpsSXFQ?=
 =?utf-8?B?ZWF3Z3V5U3QvR2dPMWZKekdMWFM0ODFzMU9GVnBGTHVXSjRWbS9JbVdMTXoz?=
 =?utf-8?B?enVxeW5DSmFLVlRBWEw3S2M1eXdGT1ZWbTJPTWxhMnE1Z1E1bEFkQ0VFaTVl?=
 =?utf-8?B?bUhBUkpSWkNQZDd5NGlaUkRrdXBrajRzZ0N4VTdDTlRMbkZLQmZHMWJwQTlo?=
 =?utf-8?B?bnIwQWFLMzBFSTVRaHZyZ0x6d1ROTHN3TU5jR3N2a0p0YnR4b0JHUjJjQis3?=
 =?utf-8?B?a1M1bTFiTjdaeDJ2bVBaeWlqbm9rdkYzaks4Wmh0VmhnMTFWcCtwVjlQVHlu?=
 =?utf-8?B?ZEZ0NXZNVUdQU0xrY2hURkFoMkRWNnVBMFBvd0l6RnJUYVpVemhtKzdpM2lD?=
 =?utf-8?B?cVJtY0ZkS3JlN1pvMW8zNkNsMUl5NGdSRk8wZTFLZHd1QWxKUEdFaTFsZWpW?=
 =?utf-8?B?MElOcUNST3FyNmtFY3BRem1zS0EyRllUb3BDOHhBMG5TYkhHYVF6akJkWnJh?=
 =?utf-8?B?eDd1dG9OdVlxRjdBL3BGd0xLZk9oTVlJeTJIQ2tjc1BQbWtFVjhNMVZCQytt?=
 =?utf-8?B?TkZZdTVkaDA4SE5rU2l1OTEwcFp2SGo3akxsOXVXd1JBTEFYYTJmbGRnbVox?=
 =?utf-8?B?UWsyUnJHV25oK3IwUmV0SHRnc2RrY0Nib1I3aFBwMHJSdElaN2ZoRHVpV05m?=
 =?utf-8?Q?r5+CKIlGUyuJmWgk5QFlBWEu5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e3878c-15e5-4aac-e85b-08de2e4e9679
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 07:20:20.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tCoNq5/fPg70z/1iGmFGuMnBdkG7J0Dw08AN9CPnYRQkkqtjjXTLII/WZOU5/vsrJ7L0prQF4D2IXRcMDDKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8222

On 2025/11/27 20:44, Rafael J. Wysocki wrote:
> On Thu, Nov 27, 2025 at 12:29 PM YangYang <yang.yang@vivo.com> wrote:
>>
>> On 2025/11/27 2:40, Bart Van Assche wrote:
>>> On 11/26/25 7:41 AM, Rafael J. Wysocki wrote:
>>>> As it stands, you have a basic problem with respect to system
>>>> suspend/hibernation.  As I said before, the PM workqueue is frozen
>>>> during system suspend/hibernation transitions, so waiting for an async
>>>> resume request to complete then is pointless.
>>>
>>> Agreed. I noticed that any attempt to call request_firmware() from
>>> driver system resume callback functions causes a deadlock if these
>>> calls happen before the block device has been resumed.
>>>
>>> Thanks,
>>>
>>> Bart.
>>
>> Does this patch look reasonable to you? It hasn't been fully tested
>> yet, but the resume is now performed synchronously.
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 66fb2071d..041d29ba4 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -323,12 +323,15 @@ int blk_queue_enter(struct request_queue *q,
>> blk_mq_req_flags_t flags)
>>                    * reordered.
>>                    */
>>                   smp_rmb();
>> -               wait_event(q->mq_freeze_wq,
>> -                          (!q->mq_freeze_depth &&
>> -                           blk_pm_resume_queue(pm, q)) ||
>> -                          blk_queue_dying(q));
>> +check:
>> +               wait_event(q->mq_freeze_wq, !q->mq_freeze_depth);
> 
> I think that you still need to check blk_queue_dying(q) under
> wait_even() or you may not stop waiting when this happens.
> 

Got it.

>> +
>>                   if (blk_queue_dying(q))
>>                           return -ENODEV;
>> +               if (!blk_pm_resume_queue(pm, q)) {
>> +                       pm_runtime_resume(q->dev);
>> +                       goto check;
>> +               }
>>           }
>>
>>           rwsem_acquire_read(&q->q_lockdep_map, 0, 0, _RET_IP_);
>> @@ -356,12 +359,15 @@ int __bio_queue_enter(struct request_queue *q,
>> struct bio *bio)
>>                    * reordered.
>>                    */
>>                   smp_rmb();
>> -               wait_event(q->mq_freeze_wq,
>> -                          (!q->mq_freeze_depth &&
>> -                           blk_pm_resume_queue(false, q)) ||
>> -                          test_bit(GD_DEAD, &disk->state));
>> +check:
>> +               wait_event(q->mq_freeze_wq, !q->mq_freeze_depth);
> 
> Analogously here, you may not stop waiting when test_bit(GD_DEAD,
> &disk->state) is true.
> 

Got it.

>> +
>>                   if (test_bit(GD_DEAD, &disk->state))
>>                           goto dead;
>> +               if (!blk_pm_resume_queue(false, q)) {
>> +                       pm_runtime_resume(q->dev);
>> +                       goto check;
>> +               }
>>           }
>>
>>           rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
>> diff --git a/block/blk-pm.h b/block/blk-pm.h
>> index 8a5a0d4b3..c28fad105 100644
>> --- a/block/blk-pm.h
>> +++ b/block/blk-pm.h
>> @@ -12,7 +12,6 @@ static inline int blk_pm_resume_queue(const bool pm,
>> struct request_queue *q)
>>                   return 1;       /* Nothing to do */
>>           if (pm && q->rpm_status != RPM_SUSPENDED)
>>                   return 1;       /* Request allowed */
>> -       pm_request_resume(q->dev);
>>           return 0;
>>    }
> 
> And I would rename blk_pm_resume_queue() to something like
> blk_pm_queue_active() because it is a bit confusing as it stands.
> 
> Apart from the above remarks this makes sense to me FWIW.

Got it. I'll fix these in the next version and run some tests before 
sending it out. Thanks for the review.


