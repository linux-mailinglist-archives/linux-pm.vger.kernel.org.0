Return-Path: <linux-pm+bounces-31048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A7BB09CAC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 09:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB113B583D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 07:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D421B191;
	Fri, 18 Jul 2025 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="O8X//toB"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013005.outbound.protection.outlook.com [52.101.127.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784921FF26;
	Fri, 18 Jul 2025 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823968; cv=fail; b=ggeIo7v9luIlWjRcCR+n44O9VyoV3j0fUEGK6PsSOIYQ4Wp9C056HrifUP1NQblwrSBn2Js5FQeRTQ953tnVdtBp1gkG3us2vqyhQia+FLAM0254/msJbmsnEozwhiOY/j4EgVRNPfsrvefvbDWlmHQ/283X2YYLurrlKfu6JVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823968; c=relaxed/simple;
	bh=exLq4Yfifahcdygd2vx066qnt2nY42HLiGcmtEnvpMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hoS/IfxCLrUkZkswth0eZLCcnIimRZUl3xDclte1scmA8sjR6pJfJqaQP1Bg2ghNcXu179Xf/e6zvQ8gDhg5GqP9gCBKuriOfkNfP1P/kZykLH3IM3gMxhGwRRQJDtQbhIOKLviqDKrScxRfDIbOdq+Wh6NXxkE1ajiUXzTMu0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=O8X//toB; arc=fail smtp.client-ip=52.101.127.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoTaGTUMYUtk+UYNgCfXGa6XbMsl13OhgFeyI6pAN//sNzeIjUsLoX3ceDgyMWJwzXQn1i6kq2sNeVuztxJ/MfxSqRxnZ16a0IaAbv1CRkAmx1552EgBnxC+rA1kp+7T0yBSTw0fHVrzF8LoYvoZdZczo2owWTyfBMA2ZrjwxIr8ipEod2PDpsDqpDhGHi0zwXTiQjokzBC24eWgpzsvdSad21i/GNfb0GWx60Zamm7yp2aRaO6CIwfzPbYBtI4bk/l8DrsJ2PQGC5smSGNJtSKv4d+aX6gD9oMTuJWmltP7Aj0PLeVBJ7mTX9swo2xCnXWWzTWqrXKyNfoZRszyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8+5G9BhNm5hL+UunOk63FuhUuc9+ZYjkVHKrrociPI=;
 b=dgScubbH0b0jWu7GYTDhs5L1/ySKJ0PCk/BihS/bIZOucwpRurMiIAMEojJgDyEc5dxxi+lpcRF80MgJvZop/9t62I5rwYRP7eHXLjGrStUUGHgUWlnyrIlexuNLdjV+HV7HMpYI/uZMRCkUUgn7BkR5Tbr/JEdR/8cFRQgxeb/K8kq1aUg+HJeWn259HLCdk/JUTUTaHxt7qzHH4KtnKFMXRi7BiT4D70D5hBeDvr26DfJejvsqR8Cp7mqaZCX/+tNgXvVfYTwh7WKB1LTtzuJCXwh/8cnmzWFWLMn4uiwFGAbc556gROXJ7DceZrhi5KfJSAA0AglvDOg2/JFSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8+5G9BhNm5hL+UunOk63FuhUuc9+ZYjkVHKrrociPI=;
 b=O8X//toBcc09BR3gqO5r5oGAaLheszqCI2DffoqB17FNkq9ho1pnlCT+GNsVzxCrbBzPwYIMPTsa+R+tNRFD1TAWS/y1s+wLZDJSSuRQw4bowbiWz18P/H4SsY1zJ2JLdDuFmXjKwuX28WIoGugixZoqumuWihHE5fpWK4Unxqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by KL1PR02MB6497.apcprd02.prod.outlook.com (2603:1096:820:eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 07:32:43 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 07:32:43 +0000
Message-ID: <a12b4548-dd21-43bb-bc62-18512fb93a6c@oppo.com>
Date: Fri, 18 Jul 2025 15:32:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: queue policy->update work to a dedicated
 thread
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717085110.1468-1-pugaowei@oppo.com>
 <CAJZ5v0jUqzT_+7VxmRqE_xAWzNCyfiUim-Hz9FaF7G0MuUb=bA@mail.gmail.com>
From: Gaowei Pu <pugaowei@oppo.com>
In-Reply-To: <CAJZ5v0jUqzT_+7VxmRqE_xAWzNCyfiUim-Hz9FaF7G0MuUb=bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|KL1PR02MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: a5149f25-d115-4b0f-3c58-08ddc5cd4837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ujl6U1RHRVp0S25Xdmg2ZThaZWdmcWl5M0dBR0ovaGRMMnJ3MWFFeFcvK01M?=
 =?utf-8?B?L0VKanZVVjVUTHRmRkc0L2hDZEc4N0xrRUZlVU5yaUNtTmNiM3l2NnBtdks1?=
 =?utf-8?B?ckhYa1RYTENMQmxwMkdmUEJncytJWit1VFk0MU9ReVJ1RnA0Y1BxVkswZkdO?=
 =?utf-8?B?N2c2emsrekkxb3JiWUtxYlgrRFplNjUxeWkwMGhMaC9JZGJzYXBxS3o5eDIr?=
 =?utf-8?B?Vjd0ckRTU1NtdUUyK3dEYmt6TUhIUEc3bEg5N2JnVDJFTmxrTDBYWHJMeHl0?=
 =?utf-8?B?cnhPU3ZFQkYva2QvRGdvbDFyT1NINW9qWGpPbEtOczZyKzBLVVpERG5zeTdG?=
 =?utf-8?B?MFdDS2ZvQmFXYnBsNW5qZVRNZDhSK3BsaUhOMk03TUhJeUZWSVNkcFRFL2M2?=
 =?utf-8?B?Umg2cTZHS2g5cnJ0NXZ6d1FPeFM3ckhtWGhYaXB0a2w1VTlxSE1GWUhVV254?=
 =?utf-8?B?b2VjbndWRGN0TFVxOTc4bVIvd213b24wSzRzd2FzRUFzMDd1ZThXS01pT3JP?=
 =?utf-8?B?Zm5kdERCcEFUYisrMkVGaEZtMk44SWl1dlpUQ2tQVm95K1ppcWZnUTY4OTQ0?=
 =?utf-8?B?Y3Y1SXFYcGhucGs4bkhKQy9mWWJqeThMeW5kMWhCa0NCZzlObDkrQkdkeTM1?=
 =?utf-8?B?bDZaeDU1OFZhZ1l2OVVvK1loRmphNVg0VkdxTkR6MGVaL1JTWnlTMWpBVi9X?=
 =?utf-8?B?UGQwcnh0WTdJL1JFV2FSblBWbFl1N2pCb1NMZTBUOW5uL3BUcFA5eThva3d6?=
 =?utf-8?B?R0Uzb1N5WTVNUzllU2x1S1JlWHlhT2xsOCtwS0N0UXd4YmFjeUc0RkZzdWpJ?=
 =?utf-8?B?UVRJTFJFa1Z4VXNQUjc1cnptSzQ4eGdSRUFnK3BLTTUvVXRDbG9DY0N0Z1pq?=
 =?utf-8?B?QURibG1sVzM2YWQ5MzZRbXphd2RxMDdLbjF6MTlOclVGM0IyZ0laMXlYOHFU?=
 =?utf-8?B?YTJGTUtUMEFSSllSczdXWitsSFNUZEhoQUlIMEMxeFlmeEcvb3NOK0loRlZR?=
 =?utf-8?B?NjE1cTYycDJsY0U5VEsrNzd3K00zcVg3YTZsZStzcUtGTVl6bHB3NWFSZGhm?=
 =?utf-8?B?M3VmTHVEK3VLSk1pWDhvY2JWY1NWMUYzUnNjZTJjTTZTK1g1UktxQjh6NmVk?=
 =?utf-8?B?cDIzSGFMZ2FRUUI1bXdFeHhhL0lnbmNlR1dZRXE0SUt2ZUhvVlN2RlNqZGRJ?=
 =?utf-8?B?d2dTRzBrbzZ5NHdvcnNVcGV3T1VjOHMwTXZmNnRxcnJZdlgydHRad0Vkdzlj?=
 =?utf-8?B?RGFFeFYyTVRxSkRvTVRzRXVWUmI3NS9tU3BMQnZBNDVQdFZldUR0dDNJZERQ?=
 =?utf-8?B?OC9WWXJOWXM2NW0vSFgxV2NHVGJuVTFGSU9mR2V3SytObHBFM2tXbnJBOWVh?=
 =?utf-8?B?a0VuR0dINnFrTkNLbGZ0bitaZ0ZDOWhrZ2ZBd2tBdVJibWgvTERwb0pldEIv?=
 =?utf-8?B?aU1OU0JnUjllRnBDdVVlSzJENHNMT0prR0RrZVV2K0xnWFVQUk9GdVhpY1ZP?=
 =?utf-8?B?ejZTTm1FS3BXVEdxbEt4Y2dIWndFM1pQSCthYTJrU2FjR1hLY0hpZjNwOGI4?=
 =?utf-8?B?ZmJ4N2FjSEUrQjZBaDRrNUptckRvdkJNUnRUejVHcE5BVnVkbVllNTNaVk5E?=
 =?utf-8?B?ZERkNDdnQmVxTUFMYzhlRUcwTVRUMDBQcm0wK3JUMGxZRGl6bjFGK3EzT1d0?=
 =?utf-8?B?bXphVmFTS3d4OXRuMTdwTG0xWEZuV2MvV3ZMK0NnTEpHaHVydUJnYUFOUXhH?=
 =?utf-8?B?cVhQQjZmUXB4bkpUVVczWjZvcDF3MUFIZlBwV3NNMStrdkRTZ0JGeFZ2VWhK?=
 =?utf-8?B?Y2tzcDl2MXdJQ2dXZHZ1YU9kUlUxQVFBbXFaZWZjRTJvb3ZCMTJhTTVuVEJG?=
 =?utf-8?B?NStnNzlZVDB3bDF0TnpWNlU3bmc2QzhqeVBMVWhGc0NRS1AwTGI3NHpySG1u?=
 =?utf-8?Q?XFh1HAuF/ew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpLWEhVMWdkVUN2ZlJUM0pGUHRMclRiY2lOSVl1WDhkMXE3SlEzbmwyT1Fq?=
 =?utf-8?B?STdJeTE1TktFTzlDOTA3VFFISWxqamZDN3FIVllQcENReC9YQk16UlVERHRz?=
 =?utf-8?B?Wk5xbGFoVnUvYTMwbXRGcVp1UVJoVzNmRXlMZVRORUc1WmNsbnJTM1hPOGQ3?=
 =?utf-8?B?R3FsMlp6VHhzRCtzNVVvSzJCYStYMDlJUkpUQlF0c2JRbGw3WkJ0U21NNWtY?=
 =?utf-8?B?cnlVaG9DcE9FZ0RqT1gwNk9PcjdRTE5EZkJsb1ppd0NYQkdUSWowMkpaNXBO?=
 =?utf-8?B?a1V6bEtrTnRsK2Z5Z3R1eHVaWmU2Rk81Tk9vYzZ0QVZQTHNxSXFXbHVGcUZx?=
 =?utf-8?B?R0gyWG9HMUNtdDlPSktubjNHZEYwWENJYnZGYmppK1doK01VeUpITnQ3VG8y?=
 =?utf-8?B?dWxqU2tjcFBHM2FQTWVieWJGTWw4UFI2TDZiQWVucmNIbHpGYlNnN1d3b1Zo?=
 =?utf-8?B?OTZaNUlZMktqd2E1czcvQ2xCKzFCWlJaK1F5YjFDUTNYd0Qzdk1SWCtDZDBG?=
 =?utf-8?B?OGJBUDFUd01lT2FFR052TDhCOThSdjltSnAwUFd4K29yL0tPaWV6OU1aTWxh?=
 =?utf-8?B?eXFFbm16THNOUTFkOW94WHo1eXRSZWY5N3NxdElYRjY0VXNCMHMvNkEwQ25t?=
 =?utf-8?B?ZGIvcDhIdWJTaGFjcXlEWTNJdnRaSVdOMlRWNlZ6VS9WamZwMi9PUVRmcTZ3?=
 =?utf-8?B?aTB4TDF2eFkxaXVqVHhPZVJKb2VqdldRU2hjeHpJd0Y2ZE96bXVuUE1RTGRi?=
 =?utf-8?B?NXJXRm51Z1d2dFJKeTFzZ1pKOE4vVHBiRkluckVhdFBFY3ZLZGdaMEtqb2l5?=
 =?utf-8?B?R01PVGV3M2NYZVArS0hjdmJsRFQwaGM5RkFqNGF0cGNTUlJFK2tUZC9UTTlz?=
 =?utf-8?B?bjU3MG80eTlTTVlNemNqdDJhRjRVeUM4d3Vaa1NWakVsZXRhdW8vM0ZjQVBp?=
 =?utf-8?B?ZUMvbXRodFVKT1V6eG96MVExa1pyTmx1TStLck1rOXNQbkJ4bWYwZTYxSUNX?=
 =?utf-8?B?VmRTRkJlR1BwK1NmWkovaVVaWWpjVlRnM0dnRTdvVnZrYk5zSmVWZ0VFWFRK?=
 =?utf-8?B?WCtUY3BjK1J4bzdWaGJQenVvdXJyUUVaWDlIcXdPU0UyNkdaUHB1WjdHMXM2?=
 =?utf-8?B?YmpKcW5EM3Y0YnlRa25sb0U1UHo3bU5UNEd1SVhMY3d2M1NtMWFYN2N2bmc1?=
 =?utf-8?B?M1RpYXJWd1JTYXcyMWllbEo1QWFqcGx4UjFUcUNZUnBSL0V6WHNKdy8vZFRq?=
 =?utf-8?B?UW5lSUgxSkJBZTRPdlhIYm9ndHpOUXNIK25zMFVETkkyVjgrak14QnlFQWFy?=
 =?utf-8?B?WE5IcWhxN0pOY3VSU1I3OHJ4NzhOVGVENEJnQ3lFZzRzQ1l4Rkp1d3pBL0F1?=
 =?utf-8?B?c0lnOGptSUprNTlVRml5c01PMFVWd0hoS1BGTVpOVGgwWmVEbVNTVksvdWQr?=
 =?utf-8?B?R3J5TmpJWW0wbkwrSjV6VDJ0U0tqbXZyemtwSUhYelkya0hMbk0yN1Z0YWly?=
 =?utf-8?B?QUExQlVseHhEUG14REdDTTlVR0ZER1IyK0taMmwzc3Y0ZGpidmtlOG8zTGVz?=
 =?utf-8?B?c0pSQ1BkejVYT3lrbkEwcFZIbkl3OHArT2ZJYUM2cVZaSlhhN2RaUjdHT1ZV?=
 =?utf-8?B?RCtJR2huYnVzMXI3YlB6bkVvM3gxSTVkV1hXUGFPTGNkZXVMaDRraitVdkt3?=
 =?utf-8?B?YjNPR2dFQUNscnF6R0lYQ1BPaFNKNmduWVlyYzJiTXBLcmI3MGhmb0Y0WVor?=
 =?utf-8?B?dnpsZVpTZmVtTlNuWUROT1dSS3dUK21JMWlGVE91eGVDNUtLOXBQaTlKMzFB?=
 =?utf-8?B?eWsxUmJ2dWM2YVJtM2JuQU5zc3U5cE8xM0JwMU5uYlRRZWhzbVVFQnFtTE8x?=
 =?utf-8?B?S1h4eFNGMGpjb0dhMDdaZjdobHFnKzEzb0IzTmYrZDBwbXFaYk5zVE9WUlhq?=
 =?utf-8?B?Zk41c3BiVnpZcnFhbkp4blJ5QUxmalRueE51aWFiV2p6L3diT2c2N1haZ1JQ?=
 =?utf-8?B?ZjZobXNhREtSa1hUWVVRRS9RTnd1ci9zS01maE5FMWRySmQxVndPQU83RzZv?=
 =?utf-8?B?NWpEYngxWDlxTUYrWjN0MCt0cVpaR3JKdVFmQVM5UER0S1cyY080VkNKRVBk?=
 =?utf-8?Q?XopvXJSZbmqiC5bZfkBh7HXfr?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5149f25-d115-4b0f-3c58-08ddc5cd4837
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 07:32:42.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWUUOU8mim9pNykGvS8J5BdVbJVedSVw/RAQp74kayMNd9krZP2spMBOUDfkm9Onuq+LuwxewQmdldbBQ7i4vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6497

Hi Rafael J,

On 2025/7/18 2:13, Rafael J. Wysocki wrote:
> On Thu, Jul 17, 2025 at 10:51 AM Gaowei Pu <pugaowei@oppo.com> wrote:
>>
>> We should ensure the low schedule latency of cpu frequency limits work
>> to meet performance and power demands.
> 
> Why is the current arrangement insufficient?
> 
>> so queue the policy->update work to a dedicated thread.
>>
>> Remove the rt setting of the thread in patch v1 at Tim and
>> Rafael J's request. However, it's will not meet everyone's request
>> when we add a dedicated highpri workqueue to do the policy update work.
> 
> Why is it insufficient?

Sorry, mabye i didn't make it clear. There are lots of critical tasks with higher
schedule priority than normal cfs tasks because they are related to drawing in android
systems(e.g., mvp tasks on Qualcomm, vip tasks on Mediatek).

The problem we met is that these critical tasks preempt the kworker doing the 'cpufreq policy->update' work
and delay the cpufreq update work for about 10ms. We can't boost the kworker beacause it's a common worker
thread which also doing other works. Therefore, queue the 'cpufreq policy->update' work to a dedicated thread
and customize the thread is a proper way we can do, not just for convenient.

> 
>> Therefore, we keep the thread and will add a vendor hook in andorid aosp
>> branch lately so we can customize the thread conveniently.
> 
> If you want to do something in the mainline kernel just for the
> convenience of Android AOSP, with all due respect thereof, don't do
> it.

Okay, Should i try to pick this patch to Android AOSP branch? thanks.

> 
> This is not going to be considered for 6.17, so you may as well come
> back with it when 6.17-rc1 is out.
> 
> Thanks!

