Return-Path: <linux-pm+bounces-25497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C638DA8A9A6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 22:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDAD17F9A1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 20:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448F250BE9;
	Tue, 15 Apr 2025 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AZS0/CdA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1F14F9D9;
	Tue, 15 Apr 2025 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750470; cv=fail; b=jOEJrGhgTdEBFJqAlE0uPzNBr8cZ1YoJSqYPzMmyICrcWoB7SPd+883xgF1qlDUcpvwG1FK+qCGeh2DSndEP2rlJ2gRhh/8U2xGaf4eiH6aPol/WLMkjgbiCiZWPiYeLTD80pI44zmSH1u50CNOGeEk1g8wzTRhYheVecDGppVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750470; c=relaxed/simple;
	bh=HPuefG7bwLEOeAfj3QVkGmgH5ZdcHGDWmnolI/nktXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lb7pLGnSWVJOei+xdS9Da1AvVEIYIj6J/CXF49Wl907FdRE+aqgHnTjzQURArgXwKDluCkyu96j/DgkPIzpT2CfdbyAuTb7lj+eNKTS1PE9yDx08MRomamewNbY/n194UTTuJFnvqxE2SQaWrLDfdFBFr5pIHGRhuHQGgtG3fcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AZS0/CdA; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUCPy/Ie2IcNrdsAN1tVP5EIod++J5K/iCfP5pfuA2s+8BRS7gh6AIoRx+fR+gmh+WhWQ3dqBwuzBFUdNCKj3liVQ+lrjqLE4rDNBq83oC/uVAb3j6H6eR0GEuuDa8G67V37NMtldJe9Q1tEwSCq15U8L1J2BufJETdf+5xka03oKP89/iA4ZdkUVa6yxCN9HqqsjoXjJtytVh4LP4SEm/sgsJbO0ZM0f1WAbEenitXQ26TaUYyEUJYGT+TPF9DHEtPCd8Nx09uByv2/wijAAwsvllf4woblig7cBfu1iCa2/R3/KYsrKxRxO4ewH15NCUes4VI/dGT2yhmlSSu/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbswS650lnCwarvvIgqXtIEZ3AJczG05X0Y/nrTkUn4=;
 b=VNPIU7jd0Ad3X09BwOBpKzfAP8n91Sp2CDpqzsaP4TgALBw9bTiyoDBdiYiXP0plVU60lMmaaoN+7o89+Z4e7xausW6YhONN3/cRolROQ4KojDzaz4NPX7bmyz5c730eamz0txi9iTRW0GsKkiaCJxVCPPgRZ6AIFb2c/1kfX5+SlcotbAmxRGtsvVHyfYtMh/0t8u7HZplN76pu3oAcuuXdYP84GNUh/LgbQrm47cKPZSZ4Dmi7jZVm4MFH/1CaHDHT9F0z+nuNVdr5m5rpupDcl4u/4jdlivWRt3C0cOPuatskhf382pF/M18gdjhfRCpUuzGLNU/DKy+XUugl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbswS650lnCwarvvIgqXtIEZ3AJczG05X0Y/nrTkUn4=;
 b=AZS0/CdAYyy/qWVjH8m+CSNQNfbxiy8wirMcXDwnUImEwTPqMZawFiuWx9Qynf9Dcag0wbt8aU0v6lJOZP+GFAl8/HiwjgA6n7Oq6/sjoWg45lbAszyL08WVo5vEdi+WVgRaZ3sOC2N9mukZyxCzB/dViKrxYXTo1lpu6MsEcxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 20:54:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 20:54:23 +0000
Message-ID: <1f8d08e5-8bc7-4a1a-a00b-505394a451bb@amd.com>
Date: Tue, 15 Apr 2025 15:54:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Add support for the "Requested
 CPU Min frequency" BIOS option
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250415102118.694999-1-dhananjay.ugwekar@amd.com>
 <20250415102118.694999-3-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250415102118.694999-3-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: d934bf6d-f848-4d43-f930-08dd7c5fb3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3Eva1RkYXdMZENkNmcybXVhNG5NSHBMcWgwU1NEdWpmbmo4VWJEeWdBdVIr?=
 =?utf-8?B?dnpRNVY0dkU3eS9XL2g1ZG9XemYxTmRWUERBb3o0RldPN0J0c3B6ZXJncmJT?=
 =?utf-8?B?by9wdUdDRnpvQXhOMFE4WEFFY0pBRlFoQjJWOEovWGlXMGhYT1ZlWVE2ZStW?=
 =?utf-8?B?WGJOQ2ltR3VWdDMxRmpIdThMYmw5UHZobGdHWUdPUnVJV0R3K3QwZnp1aDlx?=
 =?utf-8?B?ZE5UajN1aXVkOXZjWjBMSzJyOGg5TkZnOG8wb05jelRIb2p3MU1PVFVUUWRL?=
 =?utf-8?B?dUFIT243OEVCMGxzSzJaV3dRMnJURGxBMUlLbVcxZytiSE16ai8va0xuWEQ0?=
 =?utf-8?B?aUppWXlYT0RjK0pjRDh0d0xMRUM5dG1CVm1IejFBSWxMQURtcFgvdy9PWHlo?=
 =?utf-8?B?K0I1RndqSWdVbGZ3aUhlcEhydmI1RUlkMUk1bDdlTnFXT2pCMXR1REVjaGZR?=
 =?utf-8?B?SkhsdnhaYXdYNXV4VXpSaGgwODBPZTZNOGRId2U1YzlFZHN1NlhrQ0dIaXdK?=
 =?utf-8?B?UHdZT2huU21EdGdiK3RtOWZsTWU5b2NqNU5UVWZDcGFZTGdKSVNtdlI0MS9j?=
 =?utf-8?B?aWFYYTNSZDI3UTBmbVE3NnFsVHZhcndIbGFsZWE5WVlvYlA0TXFTcXpKRlVC?=
 =?utf-8?B?VElPU2hyb2s3c05YSE8zT3dZSWZUUzZsZ0hZYzNucEdHVEp1SVBWNjV4bFpM?=
 =?utf-8?B?amx4NSs4clNlcWdpdVFjV2dJOUNzcEJDL3JkcDJZdS9SMzZleHlUangzTDBD?=
 =?utf-8?B?Sk1Bc2ZOUTAzRzRCZTB1QzVlTGVVSjEwbGtjaC85Q3NPdDJkVTdPYlEwL2lU?=
 =?utf-8?B?bCs1bXVhbkpqRWdSMm4xMlZCeGJjb1JPdnhEa3dWUCt1Z3Q1QnFWdlBxNVB4?=
 =?utf-8?B?Nm5CZEs4L2FxTm9mc25KR25QTVd6aWV2NzF3TCtXRGIrdWxLa0Z3WXp2elc4?=
 =?utf-8?B?ZTZDVUpyMlhqYmRycjIzQ25vL0JnQ0NRZzltb2tVdTF0enlvUTMwSlN2QXhV?=
 =?utf-8?B?VU9pVi8yUVpOTGl5QjNCWkMrUnB3d2VOL0RhTkJBV3J6bGczZnZkRkg4L1k5?=
 =?utf-8?B?c0ZwZVNNaTRjSWxjeHozcHRyaGkwVVJ6ZXViNUlZTFIvK25DTnMwNElFWVdt?=
 =?utf-8?B?dTR1RHB1ZUhaSTBONGh1RFV6OG9EbFBpa0tPRDZBd0doSlVOb3VSOUlxUW9w?=
 =?utf-8?B?L2tJRUlicU4vT2psNUhWTkx2ZzFIQ3ltK28vTllLRS95L080VVM4SnY4a3Jm?=
 =?utf-8?B?Tlk5L0lzOFlTeDJ2M0ZFaGFOT3pLa0hwb1hZRENOMS85Qll2M0hWUUlwK0Mv?=
 =?utf-8?B?MWVjcy83Vzh2UEVjdGp1ZkNUa3dFZ3BoV0taOHJRb0xNQ2FkOXltM0FSaVJ4?=
 =?utf-8?B?cmJWYXFkLzQrM2tuK1ZZZjhGOWZFd0IveXdEL1J4MjNPY1dBRkV0OWhPT2oz?=
 =?utf-8?B?alg3dEhHSzFrRHllem1IcHlmNDd6Y0tkbkhUT2RjZnUzczNZYXZZcXA4QWps?=
 =?utf-8?B?QjNXUDg2YUx3K1l5Q210aEJaT2haZHUvRU1BR09yMEM5WkhoQnJlVzA5eE40?=
 =?utf-8?B?Ym8rOHh5YXQxMXE0dnR2b1ZtMk9Oa2hxajJqSTJiVEVIVFhucGl0SkdKVTdW?=
 =?utf-8?B?Tmc2SkNpOUxJMm8xV0ZqV1VWNlBydHJLMnp1S3JVNHBRQXVNb1JFRmpvazNk?=
 =?utf-8?B?L1k1TDFhOTVTR2JRbk5ENW1qSVUyOE9kUVNqb1Bianl0Q2JyZWllQkI2SDFN?=
 =?utf-8?B?NFczc3llNUFQa0ljRTE1OEdLQzNpeThBMllpaXJ1ZE5SL1c5KytHNTNIMS9J?=
 =?utf-8?B?ai9QVzRTOHM1eVhlRFROSVN0QXA0ZEtWMnZSb3RsRVFVaHFPaU9zeUY1RTZ6?=
 =?utf-8?B?MGR5Q2d5ZnVIOGJHaU9Cc3dGamlqNWN3Q3FkOXFUbEUwWnNUVnpzSkNhT2VZ?=
 =?utf-8?Q?aXqeewpNVsg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OExvaXJONk9ZZzBncUpBUUd2TnhoNVhtT3VpZ3BoUVg0SEQ1VXZvZHdPMW03?=
 =?utf-8?B?a3YzNmlvZkVwTlFlTjRDN1Jxc1ZnZ3oxT2lyU3g1YWNxOGErTDVEMGlFa2hm?=
 =?utf-8?B?UHlPejRpQjQ2azMzMTNiYVo3NkdIUjhER2ZmUlpsQjltTDVLL1pHUUYwb0Nq?=
 =?utf-8?B?cnJid3Nqc2gvelQ0djN2TjFwVWVxM3NNYmlOaUptZE9iZndROWFYSGJtTDNC?=
 =?utf-8?B?eTJzWDd2aWxSN3hNOW84MnZCKzM4SHhkNVMrVWdBL1NSUUJOUm0zbmpZa2g0?=
 =?utf-8?B?d2tHL2FLZFlmc3gzRUk4dzVEU0ZJTDRjRTd3V21Xa1RpYlZ6dHZrNG5VWVNO?=
 =?utf-8?B?LytzU2d0RXFubTNWL0ZMeDh6NklBemRnb1h2a2FtODh4VGlUZEVSMnBINnBi?=
 =?utf-8?B?WkxDMHgydGowRDJRdFZ6bWJPanJYZFpqVHZIWUJuVUo0ZE5CVkx0WXV1eDFV?=
 =?utf-8?B?S2NVaDVsd25oMUYwYzF6M2pQYUhTSEdnQU83UTh0TVBJMFBzbFRaQWtWaHpJ?=
 =?utf-8?B?Q0NkRkZaNyt3NVJ6enl6M0c3aVhrd250a0hXQTRxYUhiWWpkaUlCampJazJ5?=
 =?utf-8?B?eUVNS3VNUHBDYkFNV0tvMVR0ZVRiTHU0V0xxQVp5cDh6SU1JWU4wNHRuRlEy?=
 =?utf-8?B?eHdrZDcyMGRwSGxZdC85ZUw0M0ExUGpBcm8rWk5VK1JTTnJaZ000Sm5xS3dz?=
 =?utf-8?B?MWxDTmxnYksrb3g1SWh1eTFPKzlwMmsvMXlqRlVuSnZ5V0w4Ym9uK3kwWmVx?=
 =?utf-8?B?MlVyMXhGRkFQQjl0M2hFWUpLMzJZaDM5UjM2bTd5VTA3THU0dFNUZjhqenNE?=
 =?utf-8?B?YXg3RC9uSWJWQzZQV1c0MUlLUEpPUXA3UkozM3p1aWdGbjlCa3hOc1p2N1BK?=
 =?utf-8?B?MTRjelhEUGNDaHRUMVh4bitNanFyUXNBUjNLU3AyckFlTlVkZVBiTm1IRlRu?=
 =?utf-8?B?RVFVb1JuRXNaSzFHMzFIVE9CVm4rL2RQVXlERmpPWml2aEdlMnJEUVZHMHdD?=
 =?utf-8?B?b3Q0ZS9kZ1BsOU1BNVVLbnFrRTdJM0p6U0J0RGN4c3NJaExhNWVjV0d5QVlK?=
 =?utf-8?B?dUFlZWxkcC9wVXRMdHU2bmZtdWZnZFhQNnJBK3NHY0hKbWhzWXZKczMrN3l2?=
 =?utf-8?B?YWYwcjNydnNYY0lMNm92RnVDMHJYb3JacnNHNHo5OVJZb0NNMnB0ZThUUDE0?=
 =?utf-8?B?ZVc4UFlYUHNxRTlDUUtQbVJKbDFQbUM3UDhReHRwNEhPNldTMEU1SFc0UlV3?=
 =?utf-8?B?dWltSm1lUlpWeVR5UVpjVUpxWFduZllPUWticU8wY3pjZ2lkOW8xL1FEeExD?=
 =?utf-8?B?Y0pwS2pMcUNrMzRBMk8wcjZlck03SHdIdVg1Y0JtSXJ4QjZPSXU2NHYxMFpr?=
 =?utf-8?B?KzJhaE5wMVNzTjI1QzA2QUFmN3I4UDJobW9LMDVJZ2ZwS3gwYSs3VzRlYWV6?=
 =?utf-8?B?UVEvUkczWXNaVkx1M2ZkQ2NXeUlUZitkMmJQVlhjVmN2elpyaVdSQk1FUUVR?=
 =?utf-8?B?a1gwMVQ2bzJiNUdmM3N2ZEZPSmtEczVqMjJFZElvckJ1VmhVMEg0N1pyVGF6?=
 =?utf-8?B?TWJzcXpjRzN3Qi9sWW16a1p1RnpEVjhUajlMM0VJWUZmYmxNcnpXNnQwaW5P?=
 =?utf-8?B?TjRnNzJnT1dSa1BMenNLYWhoNW05cUQwdmNzc0c2V2tvQ3UrdWlNOTlMcno3?=
 =?utf-8?B?SHVmT2xCaTBpTHo1U0JIOWFCczZWNlc2emtKeG80elcwSTd3VUJ0dC9sWUxq?=
 =?utf-8?B?dXBLUk9PVXBLbTJHWGZJbmp1SCtSQktxNUVpQk54N1ZldW9qT0lqSUlCN2c5?=
 =?utf-8?B?U0hZcUlibkc5OU9uR3BTUUl0Uld6T2FzQk0zYmxMSEJWcjAzaitrR05wbEJO?=
 =?utf-8?B?ZXAyWnlGaTRZMXhNY0FZUXFzMGlSVXU3ZE9PT2tJRFpsTHJCdHl3S01Pa1Zo?=
 =?utf-8?B?R1hzbjJRR0phdVJOT0R1UTJDUFVDQVRWTk4zRklpMEQ4R0duaVppK1MzdDEr?=
 =?utf-8?B?d2V5eUI1N3hKbmk4RnRLcnZENEVRUWFleTZnWlY3Wm1PZk1TZjRFTEljN0w3?=
 =?utf-8?B?dFFwaWJuMzNwNjlRREVMcytsRDdHOFMxRjVQQW5OSVB0YUNjbkN0eUdYM29R?=
 =?utf-8?Q?DKWskreBziTnAMDG27xL71/w3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d934bf6d-f848-4d43-f930-08dd7c5fb3b1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 20:54:23.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnwRPEa9zgT/5cl1kqrB+0wxfwdKC2PNPtiMp+00kBXlShAv+Gj//0gYRgttGsSr9Opy4UzcW7b/r1exHiwHXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

On 4/15/2025 5:21 AM, Dhananjay Ugwekar wrote:
> Initialize lower frequency limit to the "Requested CPU Min frequency"
> BIOS option (if it is set) value as part of the driver->init()
> callback. The BIOS specified value is passed by the PMFW as min_perf in
> CPPC_REQ MSR. To ensure that we don't mistake a stale min_perf value in
> CPPC_REQ value as the "Requested CPU Min frequency" during a kexec wakeup,
> reset the CPPC_REQ.min_perf value back to the BIOS specified one in the
> offline, exit and suspend callbacks.
> 
> amd_pstate_target() and amd_pstate_epp_update_limit() which are invoked
> as part of the resume() and online() callbacks will take care of restoring
> the CPPC_REQ back to the latest sane values.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

I'm generally fine with this, but I have one nit below.

> ---
>   drivers/cpufreq/amd-pstate.c | 62 ++++++++++++++++++++++++++++--------
>   drivers/cpufreq/amd-pstate.h |  2 ++
>   2 files changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 02de51001eba..d94fd2a38990 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -389,7 +389,8 @@ static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>   static int msr_init_perf(struct amd_cpudata *cpudata)
>   {
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
> -	u64 cap1, numerator;
> +	u64 cap1, numerator, cppc_req;
> +	u8 min_perf;
>   
>   	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>   				     &cap1);
> @@ -400,6 +401,22 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
> +	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
> +
> +	/*
> +	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
> +	 * indication that the min_perf value is the one specified through the BIOS option
> +	 */
> +	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
> +
> +	if (!cppc_req && min_perf)
> +		perf.bios_min_perf = min_perf;

To avoid a risk of garbage being in perf.bios_min_perf leading to hard 
to root cause bugs could we initialize this to 0 in the non 
bios_min_perf case?

something like this:

cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
perf.bios_min_perf = (!cppc_req && min_perf) ? min_perf : 0;

> +
>   	perf.highest_perf = numerator;
>   	perf.max_limit_perf = numerator;
>   	perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
> @@ -580,20 +597,26 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   {
>   	/*
>   	 * Initialize lower frequency limit (i.e.policy->min) with
> -	 * lowest_nonlinear_frequency which is the most energy efficient
> -	 * frequency. Override the initial value set by cpufreq core and
> -	 * amd-pstate qos_requests.
> +	 * lowest_nonlinear_frequency or the min frequency (if) specified in BIOS,
> +	 * Override the initial value set by cpufreq core and amd-pstate qos_requests.
>   	 */
>   	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>   		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>   					      cpufreq_cpu_get(policy_data->cpu);
>   		struct amd_cpudata *cpudata;
> +		union perf_cached perf;
>   
>   		if (!policy)
>   			return -EINVAL;
>   
>   		cpudata = policy->driver_data;
> -		policy_data->min = cpudata->lowest_nonlinear_freq;
> +		perf = READ_ONCE(cpudata->perf);
> +
> +		if (perf.bios_min_perf)
> +			policy_data->min = perf_to_freq(perf, cpudata->nominal_freq,
> +							perf.bios_min_perf);
> +		else
> +			policy_data->min = cpudata->lowest_nonlinear_freq;
>   	}
>   
>   	cpufreq_verify_within_cpu_limits(policy_data);
> @@ -1041,6 +1064,9 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
> +	/* Reset CPPC_REQ MSR to the BIOS value */
> +	amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
> +
>   	freq_qos_remove_request(&cpudata->req[1]);
>   	freq_qos_remove_request(&cpudata->req[0]);
>   	policy->fast_switch_possible = false;
> @@ -1428,7 +1454,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata;
>   	union perf_cached perf;
>   	struct device *dev;
> -	u64 value;
>   	int ret;
>   
>   	/*
> @@ -1493,12 +1518,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>   	}
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> -		if (ret)
> -			return ret;
> -		WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	}
>   	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>   	if (ret)
>   		return ret;
> @@ -1518,6 +1537,9 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	if (cpudata) {
> +		/* Reset CPPC_REQ MSR to the BIOS value */
> +		amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
> +
>   		kfree(cpudata);
>   		policy->driver_data = NULL;
>   	}
> @@ -1575,13 +1597,27 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>   
>   static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>   {
> -	return 0;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	/*
> +	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
> +	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
> +	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
> +	 */
> +	return amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
>   }
>   
>   static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
> +	/*
> +	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
> +	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
> +	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
> +	 */
> +	amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
> +
>   	/* invalidate to ensure it's rewritten during resume */
>   	cpudata->cppc_req_cached = 0;
>   
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index fbe1c08d3f06..2f7ae364d331 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -30,6 +30,7 @@
>    * @lowest_perf: the absolute lowest performance level of the processor
>    * @min_limit_perf: Cached value of the performance corresponding to policy->min
>    * @max_limit_perf: Cached value of the performance corresponding to policy->max
> + * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
>    */
>   union perf_cached {
>   	struct {
> @@ -39,6 +40,7 @@ union perf_cached {
>   		u8	lowest_perf;
>   		u8	min_limit_perf;
>   		u8	max_limit_perf;
> +		u8	bios_min_perf;
>   	};
>   	u64	val;
>   };


