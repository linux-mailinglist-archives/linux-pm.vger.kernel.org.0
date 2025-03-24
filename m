Return-Path: <linux-pm+bounces-24445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249FDA6D7E4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 10:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA25D3AFBFB
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B625D558;
	Mon, 24 Mar 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Um5bP5Tq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813E25D1FB;
	Mon, 24 Mar 2025 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810343; cv=fail; b=gn+BQ8jkfhw2X6lx5wtdXNjHH5W9O9+07ViGtRcfRIBFmlvoDQmgnt+wgdiEWCZEZAdMojCyNu4S9Sgn+9VTVdn0BPppv/QgIwpGC48r5jgiBQfnrJ7tQ5WltE1Arr2YDae0Jlq3q00PyFKx6dX4qNpViJgVIfTCYYgtlqN9kx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810343; c=relaxed/simple;
	bh=B6eBJhPS5U87lnG1X6rSRaF0P6S6sZh35rYL+uIsWnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bi5tYPG40WkztXsIgzAPfH7AJx8YWsYPZfN0OMC4SAfaI1o9PL+chNDTFaIOkXaWmeZA2gpllwPCG6He8LwlHKh8yEt56Y5VzliMmLLrUJMyOdTltrBWN3TcwJZanZrtuonbno20y9dFe7lYuhcUmFwytb1/Y/NSxDAxYI6GTeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Um5bP5Tq; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm4rs/gUE64HfMW4SwsbAKkFbLVmrYbWqTDy11+AFV/7/ZcMFJylyL63/MRX3uprqj4GA1gZ/SVRA4c/NelIgk06ZAl2kyvLzJIpEbfvl1U3yKd7JR01ieVEYDHFBkxSwqGqTV9QTyL+eGkT5iSfoKPHWBIMAIV3A1qHXClaYF4byCFEkykfHCnKlanY7BBbIc1UXpAyaOzX8hJQfQOxxxY9aRC77ssOQ2sqEXo8qWLLkBR+hiVvyCUjdhyrV+8HcRrJzx4n1YDV2Z5oe+wFVIEFXcoZz1d1wzQusla7Utn5niKmBqzMXX++4fR/DqiakJSwc45yFG9hQ9NpIONm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bcyTrwaDpHHpY0Ea87e5rIXMAKxdabFidtTFEzcDn0=;
 b=dBV9FUzyBsaNGaKX5EKgVp+TXEExS5QhUIL1UANpG4XJi9tMITBFNwP5TslBFriddyzxtWmWYul1xJE/VQC+F8YbvgSahB0IqY06C9XaFFz/Dg3w008kvB5oy0RcRzpWlCDSyPmd68/SyBXtSlTshvlE3TyCoBvu25iPkO7WNubi1SxpeKd5YKGDtNDJt3oL55WnHejqQjAD0DH/40SwdwhWdQnfIxSm5wKlDidV+BV+ovhlV01XHNC934HVjltm/Y8fX7zEUJFuOyX22PblXXwnctkL+xg53mdWrslbxjGcuGk83uzKA79f1f31PTc0qGfOUHJzN/X1js7Zbn/O4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bcyTrwaDpHHpY0Ea87e5rIXMAKxdabFidtTFEzcDn0=;
 b=Um5bP5TqQmrsp8ZzOwMhRTjlIx6ThQnwCNDDy1QvzfAuSL64MTQBu6ODqhsLDPpA+Dvimo7XIW2hk94dL4uwd/g9GPQcrZneLqWc0+8t+hBoWoyqx/wvnvEC7tv1K/P2+KXhAEHvWKRqjRhauod1azm9EYvcZY0kva+LBK8XPI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:58:57 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:58:57 +0000
Message-ID: <4d224956-b4f9-4b0c-b5fb-70abe82e6ab5@amd.com>
Date: Mon, 24 Mar 2025 15:28:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250321022858.1538173-1-superm1@kernel.org>
 <20250321022858.1538173-2-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250321022858.1538173-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: d3627819-f16c-4c99-d5fe-08dd6aba7e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUlBdWF2SmNud2hVdWJjRWs4clUxdnpyZU5OcXpadDF0UTFaak1jMWVHcFUy?=
 =?utf-8?B?ZzZlVXd0RUFtU0RWVnlGWGRNdGJsaDFWcGZLeHNBbHVheHQ5N0ZQem92ZHRs?=
 =?utf-8?B?aStIR2FucEJscmZWL2RlVTBaK1kwaGlsM01XanBMNmIrbjZNdGhGSnZVUzFx?=
 =?utf-8?B?MnFvOFFSRHMxOWR6bUJtSGYzZlI2Q0xCMHRqc0dSV24yQVV2NTM5LzF4aURo?=
 =?utf-8?B?M1kyM2pERlozNElHamlVWnpEK0FPK1YyeFdQd1BVdCtkL2RtZkhUa2Y0TDli?=
 =?utf-8?B?U2l2M3pKU1B1T1VZU3BHNlVkUU9BUUE0aytoTElmQncveDVxUEJxVHFyZDRE?=
 =?utf-8?B?ME41di9VVEdtNTZoS3lWdVNRb284aDVKcnQrK1VWUVh3UStwNjVVdGwyaFc3?=
 =?utf-8?B?a0JVS2FGQmpmZUdtRUIwcHhQUTdHMS9JeHZhQ2s1QXhvMFFRUWNkNE9Cdkxm?=
 =?utf-8?B?dVh6VmpCcGZDY2NVbVYwcWt2SjNTRW9FVlZLczZkNEFaNVUvd3JmdmVtbzNv?=
 =?utf-8?B?NkUrNlpKOElXQUFkZ2dpekZMUUNmdXVKMmh3a2hDMndTMlB5cWZLSGtUMStX?=
 =?utf-8?B?TC9wQXgvZ0dzWHBUK2RHTGpyMjdkN05RUGpwL2ZHaDJHQ1Z6b0RNVUh6TDhR?=
 =?utf-8?B?ZmkxcjJMRlkrQ2xrTGVOeU45QUVSRTJrb0VSMFliMStocWZPK2QraGNya3Zk?=
 =?utf-8?B?YlczdC8zYTFwQS9md2xYWS9leTRBQU5KUCtxWTB4bGZ5S2xvM0tTTWtteWZj?=
 =?utf-8?B?VHlCaTdFYldGRWRhVWEvSmNNbktna1dqcVVWVGIrVlg0Y2N2L1FQSTRidW0x?=
 =?utf-8?B?OElOTmgvYmsrbU1Sd3B4cExjSUdQNmRMRmE2TmVPRVphN3pDT1lzYzNZbVp5?=
 =?utf-8?B?YjROL0lPby9TRnJ5VnlQdlRla09xeXlnajBNTWdMWG5GRnVYOGFnWHlsWFgv?=
 =?utf-8?B?V2RvU1dRNWhPMXhVZjhycUpXb21UQTJSYytPbFNJRmoyVER0S2JEVnRuQ2dM?=
 =?utf-8?B?aEpheE95RGlVanEzVjl3VXlid21VY1ZyNVk3L29xV1JVb0RPRGdKNmkzSjZa?=
 =?utf-8?B?anNCRjZLRDFvcitGRWhJaGVpelFKMTR5WVl4RFd5QTZPb1ZSODZrbk92VWZm?=
 =?utf-8?B?U3pZTytmdlNaTFBPd3dueG00dnB3ZGpLTUxHNUd0emRrUkRpSFdGMThZbHZW?=
 =?utf-8?B?TkN0eEkxeDgvcjN3M1piUDgvSytGcjFIYkVFbW40a2ppTEM5LytaeXVvWEpu?=
 =?utf-8?B?YVJybUNXSDMrdXN6YnNvUTRBdXJuVG0zU3VzRHhBZ1FuV0ZDRVZHTmo2YWwy?=
 =?utf-8?B?QnRxRHBHTDcrdEpQaUFjcm82a3AzYmVjU2hSNWRYRDhtNk16OUZyQ1VQNFUw?=
 =?utf-8?B?OUFwdmp4S1lYVDgxNm1kYmxORk1vcGNLSnhyWFBKeU5UTy95VEdsbldCcFd2?=
 =?utf-8?B?c2pYNC9uMm1EcUVqaEhZVXpwYktCL3RxT1pJbEo0QVU5dEZJeG02N0VzMFhs?=
 =?utf-8?B?UFhYTVJPMFM0clBLNXBPUWVEVlBHdXRNYnFQcXdnWGo1SUZHUjRBL2w0QzJh?=
 =?utf-8?B?UW5QNmNQM3o1OUZabVdGOEN6TFk0RWRWMjBNTUhrY2p2L1JadnJMZmN2Ymxt?=
 =?utf-8?B?VUljMUpqd2RjdW1kL0tWZ08xMkpESUhJTEM4RnlFNWlMMEM2SEo4RWVsUWhv?=
 =?utf-8?B?UjN4WHFwKzVYZlBWOTNnUlhKNTZBWmIyaVZJaXRWN2RybldlVEFrYzJxWTV3?=
 =?utf-8?B?NEVhWldKWlJvSkpYSFNGNndZanlWcWxvbnZzbWlSSzg3UUYwYWRXWmQvYTJj?=
 =?utf-8?B?SlIzRXJ6K3poWGVTNk1yVm52VXNVWDJteVJ0a1ZmNWVOU0Q0cVJvZzhRR2I0?=
 =?utf-8?Q?qwBd8Qwofzx7X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkVCQ0FqQmpLd2JaZHZOL2E4YytpNkxUUzVKNWxTTWtCd3FMSDZTbEtxeEJx?=
 =?utf-8?B?UFdzNXo2a1ZWeUl3blhpb0ZqUndwMFNxa2ExQ2IydXlVVklHSkpLeHhIQ1NS?=
 =?utf-8?B?UVhrRDFPRjExNVZMR0NQR3Y0Qjl4S0pZWmN5a3ZNY1ZHNzRDblFrS1lrM1Ri?=
 =?utf-8?B?TkV2RHJXRnhXTndqUTFsOXRDRUdnMlJUczdpNFMxUmRwL2NObzhla05wanpk?=
 =?utf-8?B?Wm9STTBUR2kwdVF1K1A4MzZRQi9hbHZaYVpyUUQ3d1hQOU5BdTB3VzV6SVJo?=
 =?utf-8?B?NnNGRFhGV3c3MXZjajREbFpLMVVOdk9LbDRXK0FER09sRFRVUTlxeSt0WFEy?=
 =?utf-8?B?eEkyQ3FQYW5TVTExQ3F3VHYyT3NyOU5hTGwwcVM2bVBDUUhjeFhyNUNCSFhZ?=
 =?utf-8?B?STRRTUtNL1VkTFVKbHpvVmNWM3VJY2poV05UcHg2VXVqRnJHQUh6ZHN6Y1JE?=
 =?utf-8?B?TnV0RTZGekYyRERSRjRHWlRaV1lmZ2JSVkpoNzIxWURTV3JCWWthb2sxa1N1?=
 =?utf-8?B?bGExbmg2Y1BBU3VuZytUWnFBYzljdXR0L21DWEU4eGErWkFkNGxmc0VXa1M3?=
 =?utf-8?B?VHluM1JWcjlWcmZSMzBoTW1yMU1qNUpENkpROVpncmYydlNBdUlmNjBMak1u?=
 =?utf-8?B?TUJsL2c0TWZROEN3ak5CcDUycUloSVcxYkozc3BFZUNQeDloc1JYVzhrSkR2?=
 =?utf-8?B?SHBZM1cvakRBUVpVQzFXUGNIQWNQYzJVR0FpemkzRmsxc1owUUkxWktCdDll?=
 =?utf-8?B?RnpsajBNeHdVN3NTVHpLdW5WTkxFMzEvRTRIbkt5dDMxcjJFS2d2NTFxM2dY?=
 =?utf-8?B?cGVnKzV2UVVoM29GcHVOdS9TKzBDSEd3NlpJNUxEV09hdSsrNVE3Q1BVNlBO?=
 =?utf-8?B?SWZ6U3N3N09DRnhPTXFtYW9aOWpYTTBTdThpaDZDdWc5MnFocjQ5SzQvdHQy?=
 =?utf-8?B?M0VOQU9HZ0tlSmVhMWZ6cER3ZzY3T3R6L1BBYm9DOVlTUkk3QkdyYWFZUExU?=
 =?utf-8?B?T2E1YTl6emZpcVVWNTdEMVh5VWhId2tZQ3hvMnNzT3ljRkc4NSt3Z1IxeDRM?=
 =?utf-8?B?czZpTEo4TUNXeGhjeExFenphM0ZneENrVXQvb3dNcDF6bUFxa2RMelFreUUr?=
 =?utf-8?B?akVBWGVlOG04TXlCVjg2b1Q0RnJSUGhGejJOYkNNWHNmUWg5bWpDcldISWV1?=
 =?utf-8?B?Q29CdHFUOU1MU21nQXZ4Yms5ZVR0Ujh1emZsS3dXM1FhcnZPMm9SSXMweWhI?=
 =?utf-8?B?dVFIWXZrMmZsQ1BMcldPZWF5R0VnNGEyamZncXdKb1d4SUlNc3lyT2t3TlRJ?=
 =?utf-8?B?WE9ibXNmQmZIT0lQQzFmSkszVkJlNzE4SDhQT1dRa0hyUEc1VDRSa1J3bEt0?=
 =?utf-8?B?bUxyd1dqNmdWQXgvMnc3d2dJNFhxeURHaVhnVmIybTVjRnNNZVpybThSam9j?=
 =?utf-8?B?c3JwTGNkV0h1aVhlZVFJUzlQamxHNTJjTzlqT2N4NTJZcGNDOU1IVmZDTnQ4?=
 =?utf-8?B?dUNJbGJEMjMzcG9BZXZQV2NnVjliSGx6NUlMb1h0elNhdWlrV2dKTm9aQmVM?=
 =?utf-8?B?Q0dLYWYvUkFBdDYvT2dBTHhQaGJ2eEdtK3U1bjZ5TUlxb041U29MQ2VoenZ5?=
 =?utf-8?B?Skg5ZzZSVjU3eWluQS93MTVFamFiSzRGczZaT1NVOUMwcVFWMTVnQVNFUyty?=
 =?utf-8?B?S3FsWXYwVUhJOEVmSkE1NEY2VnVDQ1ZrbnF1R1Z4a3RKc2VmemJPaEFTMjYr?=
 =?utf-8?B?dnpBbnF0cjFYUGxtRkpSUEQxUTV3V00vWG55dm9sRnhBQkFnOEFUdFBBQURF?=
 =?utf-8?B?YnNIMzdNMWNrRE1FYlJWbXRXZ203Ty8vT3pDMUxtZU5lTzRHVEZ3SFdRZits?=
 =?utf-8?B?czVJYndWaUxLTTRRRE5BWGFiVUlTcXNUVUplZ0JoNWN4WVR5YjBSN3JvWDFr?=
 =?utf-8?B?a2s5UWpIWXJ6VGFkNE5WS01DekdldU5CU1ZUYlJzN0h3dzhYL3Z6YmsvOTF6?=
 =?utf-8?B?a2pGMnh3ZVVBOHlXcVFvRkowNkxJMnZxd2czZEd1MG5YZURpdFZNVHdQRjdy?=
 =?utf-8?B?NTVSdlNyL2JvQUg1K0d6SklCWlNXWDQvT2pueTNTeVlrd2s0bExMWG5hd0Vv?=
 =?utf-8?Q?iQk+Ss7w/Tuxsb9GWApv9R878?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3627819-f16c-4c99-d5fe-08dd6aba7e58
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:58:57.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82yQ6N6VDU5yOnV+FjMI43F9UPqJIfbPTRi/XfRtz04Gmpe/LXP1ME+ttHJYqacjyrMMSU19IbHVFXMe60g9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

On 3/21/2025 7:58 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Dynamic energy performance preference will change the EPP profile
> based on whether the machine is running on AC or DC power.
> 
> A notification chain from the power supply core is used to adjust
> EPP values on plug in or plug out events.
> 
> For non-server systems:
>     * the default EPP for AC mode is `performance`.
>     * the default EPP for DC mode is `balance_performance`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * Handle Kconfig not being set
>  * Fix dynamic epp default on server
> v2-v3:
>  * Fix typo in Kconfig
> v1->v2:
>  * Change defaults to performance (AC) and balance_performance (DC)
>  * Default Kconfig to disabled for now
>  * Rebase on latest branch
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>  drivers/cpufreq/Kconfig.x86                 |  12 ++
>  drivers/cpufreq/amd-pstate.c                | 135 +++++++++++++++++++-
>  drivers/cpufreq/amd-pstate.h                |   5 +-
>  4 files changed, 161 insertions(+), 9 deletions(-)
> 
[snip]
> @@ -1050,6 +1056,73 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  	kfree(cpudata);
>  }
>  
> +static int amd_pstate_get_balanced_epp(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (power_supply_is_system_supplied())
> +		return cpudata->epp_default_ac;
> +	else
> +		return cpudata->epp_default_dc;
> +}
> +
> +static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
> +					    unsigned long event, void *data)
> +{
> +	struct amd_cpudata *cpudata = container_of(nb, struct amd_cpudata, power_nb);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);

For consistency, we should add "if (!policy)" check I think

> +	u8 epp;
> +	int ret;
> +
> +	if (event != PSY_EVENT_PROP_CHANGED)
> +		return NOTIFY_OK;
> +
> +	epp = amd_pstate_get_balanced_epp(policy);
> +
> +	ret = amd_pstate_set_epp(policy, epp);
> +	if (ret)
> +		pr_warn("Failed to set CPU %d EPP %u: %d\n", cpudata->cpu, epp, ret);
> +
> +	return NOTIFY_OK;
> +}
[snip]
> @@ -1364,6 +1444,32 @@ static ssize_t prefcore_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>  }
>  
> +static ssize_t dynamic_epp_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
> +}
> +
> +static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
> +				 const char *buf, size_t count)
> +{
> +	bool enabled;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enabled);
> +	if (ret)
> +		return ret;
> +
> +	if (dynamic_epp == enabled)
> +		return -EINVAL;
> +
> +	/* reinitialize with desired dynamic EPP value */
> +	dynamic_epp = enabled;
> +	ret = amd_pstate_change_driver_mode(cppc_state);

I think implicitly changing the driver mode when we write to dynamic_epp file might lead to some confusions.

> +
> +	return ret ? ret : count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);

