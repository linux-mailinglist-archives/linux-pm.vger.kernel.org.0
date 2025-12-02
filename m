Return-Path: <linux-pm+bounces-39057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39277C9B2A2
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 11:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15ABB4E176F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB8287265;
	Tue,  2 Dec 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="je8kMR/C"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013063.outbound.protection.outlook.com [40.107.44.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DB204583;
	Tue,  2 Dec 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671636; cv=fail; b=bx0B+kn/zNRElkAYmK2/oF1BSwZFGfCLql5zYQYhn14p4pUG3GXXG637tKhVbIovbK+VgDiZAFzpQt7TAPfvlPWUA2khGkKhpMvBwRrnLAl9fxUjIZIFBkMxVPKRnRB1hIuiciEzKjsSSw129w8EQJjS3fGrv+B71y/xrjHVyVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671636; c=relaxed/simple;
	bh=75oPH7yDTCtA1LiSfU8FfZimNt4m2+hp61GQ0qFIIEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JAVHKmmTqSlZyviG/cfwBDcU3O3wv7sk6keEHEKja8LEtJILTiNU2lQGTevG1+T4XtSjKng4IW+Jcd09NO+HdlRK+cjylmnEl0+54JXKEXG4tJ0PwdOxfMLbrI8mI58m4w6uApKsmw4O3qt1Gpqojqof3xMG/WfWA5Hn7Wg2bnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=je8kMR/C; arc=fail smtp.client-ip=40.107.44.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdAQASnFHnGmHQ0MRNc88YXmbC+mWXLKuYCTCM5z4cvwiRFqxlojrl7K2wY450Sx9yXiB6IYQgL8x3Ba4OVATjU/Q5H63hO96XbmvqT/MYf2Ov4/Ge0yeqbIJM0PIJM3wf6N7wgi3+GuyntGdhlN/aBgJViM04H/k2v9MnlmmfcdjmFPlyDGdsGHduA880sf0rDHfUUoj0wvQzg1DwU5znWbaGSJo6T4+rD2baI8Fyru2RdqgIhDpM4IBYabDeD1bRRFv/lO2ZCNuZO92Ko7FM8fqeZQBjfTxD84keD4vAzHqBtGY+2Ox+Ws6ZmjaRrykg5nvYAGXdIpbPdrsPntaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bMawu/c727koitRdvUqbvH+wSqE3/m9kxalw/Thqy4=;
 b=V8YxWo7tuCZNMhrCod9BFmFXYuItQmYc61JwmzQMS05cCkFs2RPd6vWFzpxFKAj8xMagFmYhuaDBC/Hms4z3rnRKGe5R6oxNvcpzukVoJghZwfwaVqDMoNGvSvIXg3yLUzdQ5x11a6klpK9OMBrojs/zjFDpxWpl7aqiQRwNzJ5kjngShSVVl5EbGH67HbZ7LOzNqw6TwZgLFp6lpvIxubYceVyRUD0s+OTzS18BA4CKrXYdnjWALVAR+CEhSueLu31bEh3YesXpZRfxxF1cWHJ1NtpigFh2uRwBI9iYzFACcEeZBNh2lFCAnQ3zAsKO83YkTvEFDkthwjDvsnQdFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bMawu/c727koitRdvUqbvH+wSqE3/m9kxalw/Thqy4=;
 b=je8kMR/C0s2I59yRDjwQsdTMXCnkEKJAOsPfbkmih6myhA+EQwRkAkpOiWXh47g5h/hoT6/XAxZuNl6xUVwPS1Jl4zi+8kS1/lEldxS3yXgvui1WgVjKLyITaummjbJ5INhagshjBEvw5NjuEmKywpNf2IjpQc6gsB3yltcWoZl8jhcib6SWJXnYvUMhUX5fQOdTmprfQGIUNn11KC1yrLab3GMKT1dk7WrDfS0+4EnMy2Aa7m6/WNYGDlYqouuU1xvnJWQXwOtvOkNEW1x846kuaxZV7clH+xYwsdHzskMW1Ihy7P6L+GYLdFOTAM6lL50W6qeMgDMxYmk9K3NQLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEYPR06MB5868.apcprd06.prod.outlook.com (2603:1096:101:d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.22; Tue, 2 Dec
 2025 10:33:41 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:33:41 +0000
Message-ID: <5bef0b09-710b-40a7-bdbc-7428301aee7a@vivo.com>
Date: Tue, 2 Dec 2025 18:33:37 +0800
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
 <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
 <4697314.LvFx2qVVIh@rafael.j.wysocki>
 <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
 <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
 <1e7583e8-9ae9-4641-8ec2-7c62a637c9fc@acm.org>
 <CAJZ5v0hKe+2orwKP352dBe_PB1pZqMehMo8tSDv5G+cdaJ=OsQ@mail.gmail.com>
 <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <8fa4023f-50f2-4e25-9f9b-4e5236015e27@vivo.com>
 <CAJZ5v0i+BhxX54wyogVR4_fmTJHVFfozNrP5LN4pGDPnnL=EDQ@mail.gmail.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <CAJZ5v0i+BhxX54wyogVR4_fmTJHVFfozNrP5LN4pGDPnnL=EDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEYPR06MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0fe49b-1f89-4296-efad-08de318e42a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Unl6dHRxK3owNnRFZjR1TzUvQlo0a050ZWxidFlrMUZ1S1VrQ2F4Qnc0Y0tt?=
 =?utf-8?B?Nzcvbit4c2MxdGdnOUZZN2N0VnRqU29XVDdBM3A1allWMzNWdHQ2ekphdC9W?=
 =?utf-8?B?aHhscFBvUU53N0pySW1SUzhHVlZLT2ZlLytLczc0YXNxWW13VUlVMFdQRWpJ?=
 =?utf-8?B?Y0tUWFROV09FU2dsZ1A1Q1RsQVNZRVcyVjRGcUFMckdqb2dUYmxhV25aQ0dv?=
 =?utf-8?B?MmlZV1lzc0tBbWo5U1hkYlFkSWs5K3ZXTXNPMFNmVWRBVG1LZDlQZDRQUmhm?=
 =?utf-8?B?R1MwaFVjQk5tZE80U3FFK3kwUkV5cGdtQnN0VHlKMlRCSXZ2eXFoK2Z1Wkx4?=
 =?utf-8?B?THA3WklqMHJ4SnFROWRIejN4ektjRTgrY2ZOelYwOWRZZ0NJNDVRNnZMaHZV?=
 =?utf-8?B?NE5UdEVtdC9IbllBU0Vtdlc1OVhaeWs4YWFpS1pRVHI0YWh6UkF4RTJZSUpm?=
 =?utf-8?B?bWxjekNoVHI5OWcvY0g3N2tCUG1QejBWb3pDMW9YVFBWcklzeGJ2WnEvazlC?=
 =?utf-8?B?cGNiSERxaDFNY0hYTTNPQnpOSmJkaTFHRktOQjJhSWE1NDdhd2lxRGpwTDAw?=
 =?utf-8?B?SXhHeWtEakxUZnpFOEI2WUhva0Z0MWYxbkQvOE1TZkJrb0xiQW5jQkZWaEZ4?=
 =?utf-8?B?TmYyWGkrYjMzTnFUTDZoMkhPbGU0SzREMUZKTUhnZVkzSGlxelpTSFRSWFBE?=
 =?utf-8?B?SDJ6dnBQK0VpOGVHQ0ViYW5EYnNFbXoxQkhqN2FobkpKUnRCck5WTFhVWDAr?=
 =?utf-8?B?Q0J0aEpjK2RNd0hQUG42WmlEWXE3Uk1IcmF1S0hnY3d2WitLZlErRXZTT2lL?=
 =?utf-8?B?MGVKTHdJaWVwdDRieHNqTkdXYUxtdDZ4dDlXNEx2QVV1Z3loKzZrMFZrZUdl?=
 =?utf-8?B?KytkOWx6MWtiNC9aU0JwTUpwckgzUnlRWjBrOVhWeFVzdXNZOVRxZ0ZmeHh0?=
 =?utf-8?B?Zk9qd3kwOE1MU2FyUVFRSm1DbUFYSDd3TUJmUTU2STNoWUlXeHFJbUNLUXFL?=
 =?utf-8?B?bmR0TE5PUGM1dFBRV3FERTRidE9DeDhUTGdkdW1mYjIveHpaaFNoUHVrQ2Js?=
 =?utf-8?B?KzA4WGt2ZEs4M1A5S002OGJDTGhjTjVkM0p3YWNIMmZscTQ3dWx4MkZNN1Aw?=
 =?utf-8?B?SXRYeVEzcnEvK2ZoUGswV0JlYTZqNG90S0xySElHVW9NbU5xNHVHRGlHK2tD?=
 =?utf-8?B?SHNSTXU0TmJOWHVTUjR5aVh3Sk1iTm5GTzNpd29yTGl2MXloQ01DWUlVemtH?=
 =?utf-8?B?T28xRGVMQUwwYzJqalhYb0NTc0JJVFhJcFdvSVdkSS9lNWUzeWw4ZEE0VU92?=
 =?utf-8?B?SEFaWVpXVUFya0svdDdZdXdMelJ1QTZhbTh3aTc0V3hVR0FwMTFJczRDUDRT?=
 =?utf-8?B?M245RTJkbU9JWXRQS3pnQkRRNXhpeXRwa3VWTk8wR3Z1UFRGUmV1TUI3by9N?=
 =?utf-8?B?aWdTNFRIUDY4cHZ2bUF0eDA5THdaemhwV3Bnc3pTdTREYUtpZ2NQN3JNZnBw?=
 =?utf-8?B?OUN0ekhBL0RtaXZRREczRjRzbnd2QUoweXVBTlp0WHNNUk1mYUNDWWY5VDBn?=
 =?utf-8?B?TDdyY0l3ZUdYNElRcXBJVEQ5RjlheUhDZWpENVcxS1pTeGJRdkVYeHFyU1pC?=
 =?utf-8?B?SEhFTW56NVI2b1NhcU44Z2FHMDJaM3RwS01icjZIRFNGUHdnd1ZUOEdUdTY2?=
 =?utf-8?B?TkZaaEVEMy9NM3ZvUDJWUTF0QjczV282WjU1SjhvaDl1M3VtdWJ0TFpUSy9v?=
 =?utf-8?B?SVQwRFFKWDBHRVBFYjJ4UHJyUTBja2dHNVJtYkxYT2FydUFiSkJYSEdpRUJV?=
 =?utf-8?B?S3RNL2FlZEZlWnNuODg4d3I0NXl3R1FJeThEQmRHL1RCZG5rckJrSDFySG10?=
 =?utf-8?B?RUYyZU1yaHd1WVRnc0FiZlM1VHYvUE8rYWQyaDBYd1VvQnB5UDY3ckM1V0lE?=
 =?utf-8?Q?7oDNPNcalt+1ZTmxlK+cs63pnokw6LyW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWV3Ky9rSS94YmpjVUt4QklXU0NoOU83L1VncEtmRUhMRXdXS0lKbUJlbk5Q?=
 =?utf-8?B?L2lwWlJDTndZY3Q2UHM3YldMWEJjNm41SUhPdEppWjVabElCRUp3OTJuNVg5?=
 =?utf-8?B?WFhyZjd2OTFiUGx4RHVPV1pHV0xSekxCaU9QbVFqQW5zNVdsaCtQME52ci9Z?=
 =?utf-8?B?VnUwQy9RYmlrd01nVzl6MytNNjZNSWxnYStmV3d6dk9PblY0Y1VlTjMzd05Y?=
 =?utf-8?B?TGxZMHdIK1ArVTExSkE2RllFTjhYRjJtQUZ0MmVUYlB5VUZVVjRlNjFRMmcv?=
 =?utf-8?B?T0hqQlZzeTNiRk5WYkgyQnJYbTBocnQyZVBPSnJQV2ZMSkFNZ2t3Q0g2UXVX?=
 =?utf-8?B?KzdJMS9OOUVXbHVDOHlJTUV3dFlkbHJyOEFQenMrbFVIVkFwbXpCeS9XYlQ2?=
 =?utf-8?B?ZUNNdEd4QUxhY0V0UzVhMzhFU1hQbDFFQjNxV0JGTEE0TmpLdlhqelpabEtr?=
 =?utf-8?B?Tkx4MktDUE84cFNtM0YxcUlSOUZVQXpmd1VFNTdrRTRuYzVLYUYxNUZDV2p1?=
 =?utf-8?B?TVVYbytUekhwaHNzcDI1MmdFSzZWSlNJbWtMaGV1UERtWWMvSG5qTUl3NWF0?=
 =?utf-8?B?R1d6Q2RGb0UyZjNkaFFWRGFaQ2t5Z3RUUUhnNTc1ZkpYWnN5S3lNQVdJbUNi?=
 =?utf-8?B?c1VyZHI0aEpKMGhtbURZZjBTdVlFTm83YWxEY3BjS1F1a01GS0hJQ0lUcUtN?=
 =?utf-8?B?bkF6S0FkOFFsL3pxcUlEU2YzYjF6elV0WEtUSXNBTy9CNkVHei81MmNmb1hF?=
 =?utf-8?B?NzRpQ0tmb3MyckRaWWtVRVFBb2pkaGtTVmpRRFJpbkpyL3h6eGYrMlZWUmU4?=
 =?utf-8?B?M2kwaTk4MU9ZQ2E2alJGU1FINVJ2MElCUDVueGhZam9pNkprbktyZGFxaFdw?=
 =?utf-8?B?Vy9mYzdrQ1ZsaVRpUUZMTXQwbkVMS1MwazBJWDhWNkhyRzZZZlBrOUhENjg1?=
 =?utf-8?B?UG0xVHFCUmVqNjFOVGR6U29VTmdzRk16L2lROTZVUVF5b0RPL3d3T2FhY0t5?=
 =?utf-8?B?b0NZeFNtTnRSQUFJaU1vbm81TUVYUmJnUis4SU1RdDVjeWFHamVobWIzaTdt?=
 =?utf-8?B?OG95L215VEp2K00vU0M0NzBTVDZxNXRXYnRDdmh3dVRtWGpodDB4Z2hhb2t4?=
 =?utf-8?B?ZFVFN1NmVXFhc2d4MjVPQlF5ZCtGQ1FUN0FOYWRaNkYrVjBvdURYOUxCcEk3?=
 =?utf-8?B?UTJIcTlMZFhtRDdUeTRlTG5ZbWgvYmV2QjRWQ05OOWNxRE1DVm9lZ0lPRmU2?=
 =?utf-8?B?VnpidkR6dnJNRkRDOVpBMlZWY05OSUpDanVGRllxenJRRSt4NTdTZmZyQmU1?=
 =?utf-8?B?dVZ6WW1Eb1ozWW1XaHZ3d2ZjclVScDREcTRGeUFSKzVpVFFOeU1lRnFPR3lI?=
 =?utf-8?B?RDdGZkRXeUJlelFVby9aTW9mQTdqanNFY1NLTlBHMzFjM0dHTTlPa1Zkd3Bh?=
 =?utf-8?B?aFVBMWllT2tYazgvNmZnYmNaZHBERGNTNmpRRW1seU90c1R6OC9lSGUxSllK?=
 =?utf-8?B?d01JT2dEU0wydkNHdGJJVzNvb3dXYUZJeHZCSVhPSWZuWlVxS0pXdUNjLzhL?=
 =?utf-8?B?OFAweDJTNVNsZ05KOGh1c0ZXTXpMd1ZBcERSV0c3VmJJRHNrd2FBY0pVNmR1?=
 =?utf-8?B?NW9aUkYySXNyWnhMOHR3bDZXb1RaQlJBSm83YlVsNWZVdm1oM3didStwcnZl?=
 =?utf-8?B?eTk0UytKbHc0L0dFQkh0VEY1K0htSDRMUVB6WWxjN0tMOXAxbXJaRVJyUVhB?=
 =?utf-8?B?QlpidjlES05LYitPRm1nUzBoWUtlWllZdXR0WEp5cGRzeXlNUXRqdHA3Y3Ay?=
 =?utf-8?B?UXd2OXVZa3JVblpWRFF3MVpJWEU0VmpvOUkyQVlvdWhZNFBRcm1BSmlTN3Q4?=
 =?utf-8?B?M1lMYzVERWcxalRmUC81QVBReXlDL2s3T0JZWHVOTFRQMmI3WmZFV2RjVmo4?=
 =?utf-8?B?ZGQydld5bVhUUkl3M2RjSlVESS9scTR1L2hicVlNNTFmeXRPVkFwY0JEKzJV?=
 =?utf-8?B?d2dTdXFEZXY0dk1rcG5VZFJ4WkI2SEhVa2dyemRBdksvTk5NTjVBaXZzYks5?=
 =?utf-8?B?anZXTHRvOGt0VHpGMTJJZUJCVVc4dXNXampCbWc5b2wzeHMydHFuM1Bsd1pi?=
 =?utf-8?Q?hGmRAkRAVLwDmfmBQVH9xzETq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0fe49b-1f89-4296-efad-08de318e42a2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:33:40.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4yTehtbxC7RCZuia9OHxp08+ooU4cl6nbhYRl8QMpcR9DcwyvsNEbTLElgkrjqEyDLlNkOiUPVMCjUgcLFxFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5868

On 2025/12/2 2:55, Rafael J. Wysocki wrote:
> On Mon, Dec 1, 2025 at 1:56 PM YangYang <yang.yang@vivo.com> wrote:
>>
>> On 2025/12/1 17:46, YangYang wrote:
>>> On 2025/11/27 20:34, Rafael J. Wysocki wrote:
>>>> On Wed, Nov 26, 2025 at 11:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>>>>
>>>>> On 11/26/25 1:30 PM, Rafael J. Wysocki wrote:
>>>>>> On Wed, Nov 26, 2025 at 10:11 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>>>>>>
>>>>>>> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
>>>>>>>> --- a/block/blk-core.c
>>>>>>>> +++ b/block/blk-core.c
>>>>>>>> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
>>>>>>>>                  if (flags & BLK_MQ_REQ_NOWAIT)
>>>>>>>>                          return -EAGAIN;
>>>>>>>>
>>>>>>>> +             /* if necessary, resume .dev (assume success). */
>>>>>>>> +             blk_pm_resume_queue(pm, q);
>>>>>>>>                  /*
>>>>>>>>                   * read pair of barrier in blk_freeze_queue_start(), we need to
>>>>>>>>                   * order reading __PERCPU_REF_DEAD flag of .q_usage_counter and
>>>>>>>
>>>>>>> blk_queue_enter() may be called from the suspend path so I don't think
>>>>>>> that the above change will work.
>>>>>>
>>>>>> Why would the existing code work then?
>>>>>
>>>>> The existing code works reliably on a very large number of devices.
>>>>
>>>> Well, except that it doesn't work during system suspend and
>>>> hibernation when the PM workqueue is frozen.  I think that we agree
>>>> here.
>>>>
>>>> This needs to be addressed because it may very well cause system
>>>> suspend to deadlock.
>>>>
>>>> There are two possible ways to address it I can think of:
>>>>
>>>> 1. Changing blk_pm_resume_queue() and its users to carry out a
>>>> synchronous resume of q->dev instead of calling pm_request_resume()
>>>> and (effectively) waiting for the queued-up runtime resume of q->dev
>>>> to take effect.
>>>>
>>>> This would be my preferred option, but at this point I'm not sure if
>>>> it's viable.
>>>>
>>>
>>> After __pm_runtime_disable() is called from device_suspend_late(), dev->power.disable_depth is set, preventing
>>> rpm_resume() from making progress until the system resume completes, regardless of whether rpm_resume() is invoked
>>> synchronously or asynchronously.
>>> Performing a synchronous resume of q->dev seems to have a similar effect to removing the following code block from
>>> __pm_runtime_barrier(), which is invoked by __pm_runtime_disable():
>>>
>>> 1428     if (dev->power.request_pending) {
>>> 1429         dev->power.request = RPM_REQ_NONE;
>>> 1430         spin_unlock_irq(&dev->power.lock);
>>> 1431
>>> 1432         cancel_work_sync(&dev->power.work);
>>> 1433
>>> 1434         spin_lock_irq(&dev->power.lock);
>>> 1435         dev->power.request_pending = false;
>>> 1436     }
>>>
>>
>> Since both synchronous and asynchronous resumes face similar issues,
> 
> No, they don't.
> 
>> it may be sufficient to keep using the asynchronous resume path as long as
>> pending work items are not canceled while the PM workqueue is frozen.
> 
> Except for two things:
> 
> 1. If blk_queue_enter() or __bio_queue_enter() is allowed to race with
> disabling runtime PM, queuing up the resume work item may fail in the
> first place.
> 

Perhaps my understanding is incorrect, but during the execution of
device_suspend_late(), the PM workqueue should already be frozen.
In that case, queuing a resume work item would not fail; it would
simply not be executed until the workqueue is unfrozen, as long as
it is not canceled.

> 2. If a device runtime resume work item is queued up before the whole
> system is suspended, it may not make sense to run that work item after
> resuming the whole system because the state of the system as a whole
> is generally different at that point.
> 
>> This allows the pending work to proceed normally once the PM workqueue
>> is unfrozen.
> 
> Not really.


