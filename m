Return-Path: <linux-pm+bounces-14037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C029757E3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB07CB2A1A2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642181AE87C;
	Wed, 11 Sep 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YXo87QAW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C41AE865
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070567; cv=fail; b=dK3hrFDn+Y8rvzGCPuXhjCfEo2a2yU6GbzOiRSudsOtm9yIqI2yV1ytC1UdC3aK3B+KalaTEySsPChTr7AhSLjLwG2+VlN1fg/UFQcx4wY2sPl0AG+PaCu4goFU0jQW8v67ocbweOe4PIjkRNZhvP/CqUYM9ZEY4bVqeXfOZSuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070567; c=relaxed/simple;
	bh=TQ08q4sdhhlOkWVbzXqET+VEJVkclLsEP672AgX4SOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KCUr+C2nRwLLm9MrGqa/LIkE4f7D4pMNtg1UtgkEd0gKV9p1uC6pvfuBd6DU8zMn+LdXtzvOV3QeTRxu0YRnJJNBhPxi/7fjB5XUDGm/LthQNcWd3maJJAYLvx++GDffkgKQl7KGgZUGx6AVP9SOW/QIyJwnSxdx6HN82lzBJZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YXo87QAW; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUptjtKcE4nILsdjh6C4H72MJXYehd7/rbBoDeOE+cUVYHxWtQKJCkac/pART3pgMgwo7aPoxC31j3Nn6gcCvwPzpw7ECKIRgcPyd+RRjUHxLWUDRbl9A6Gx1bzBf0wFdBjNJuZDW2ZpdHaCwRbJMev5Cl+J1s0A6VU6zYoAWIjHKHDef78vUKYHnXD002u9AfuC304eU5IXMSKlorDhdtLNmfae30tGFvIPrDT/8GN/ZCbbpEVsCH/+n8OFm0swlkwlgOVTabBdX03VPoGm3NpULMXoVsHhiWnKYCM/TIdSHssPQV7I/mLElPuVa/8OCRxa8gzHICUxPESrJlgV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMagnDAa/kZcETrO3V56NmKAyKR2n8FEyOMUkH8IicQ=;
 b=ZE+pPneyZ6V6JuZ4fmJysc9PZwUiRX+p7AiCMK6TrSxy4N57x6sKyQNAZ1moAIjjY44h+ekeVmu0ByJvexn+Al398BAMHQNKNTPlt32OxArxPqStAs5p0R92NaLbbIMaa8j+GarHSOlx/+zpADC2mgYM52H+OrWjSGxvVdz9U5si449KNaSX/ZcphNYZiNerVOW+2TQrOi2kGxwQEPAOIgkrPLOAHAIHzkbVSJlt4+Avgm0BDhGMFqYzPkynsLWoIkLR0QhgCsFsZyzedtfqZzLp70B01YEryrJtkHvFCE4scAKF8nI2lG9A+qHwLF635mdi8N+mkOFWG1H9G6//eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMagnDAa/kZcETrO3V56NmKAyKR2n8FEyOMUkH8IicQ=;
 b=YXo87QAWSlzrabq3uHuKEtxPovkXAjl6UrsLm/UazPS4B2jT6q41BuPcM6azHRg4s68lfA47NNJm6eGZHbHRxoMl+b90rXrCqLAXbMDRtaqiDnoLMdx12JLZJeqVd2O37piPV0lCKA5oQmsqEuHv/nYSTf1nCqlf1vRgDampHZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 16:02:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 16:02:43 +0000
Message-ID: <b2ea8d2a-1449-496c-93a9-bd13c0aa04d9@amd.com>
Date: Wed, 11 Sep 2024 11:02:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] cpufreq/amd-pstate-ut: Add test case for mode
 switches
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-pm@vger.kernel.org
References: <5cdbf27a-1baa-440f-a943-d2aaeec99b38@stanley.mountain>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5cdbf27a-1baa-440f-a943-d2aaeec99b38@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0209.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: aee3b793-27ee-4ebd-02ba-08dcd27b2b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1huUWQ5dVVZZ2U1Qk1MY0dzb1BGL3NYQUp3M3dGMEFOYTF3Wm5TMDRHVEZW?=
 =?utf-8?B?Mk1DdmZINXZ1T2Z0bjU3YTJnN05jT3Z0em5xSUhuaXh1Wjh6NHEyWVRwYnkz?=
 =?utf-8?B?N2tqaWFZY3pyM1JLMnhZTXpsNzRDWGJZSHRFMzVWRU5samp3SUxuR2RVWHBm?=
 =?utf-8?B?aVcwNmdhbXJ5UGczWDJHNk9EdGphTTg4ajVCc0ZsMVIyaXNzRmU3TkNWWU9C?=
 =?utf-8?B?Qkg1V3FRUklYVFFtUTlOcDFpNzkwMEhQdCtwQjd3MkNCM0w1Z29GVU1kZHc0?=
 =?utf-8?B?dWlPMUFQSERzM2lyeTJVdVkxV1c4cGllaDdNay9sVGVtdnZPSGdmR3FLNlV6?=
 =?utf-8?B?R25VbW9waDFHNW02Skx4MTFqeUc4WFdlM2hBQzVCSVFwcGljVWhpckRDS3o2?=
 =?utf-8?B?ZTQ1SnRMSkJtRE4xZEJmejFYSTNpb2JZRVdoL05OTDlZQ2c2eWtxTVAvYUwv?=
 =?utf-8?B?OGF0ekFPNWZmbGRScmY4K0RlNkRFeHVES2xBWnBNdjgrNVhQSW4ydytEakhu?=
 =?utf-8?B?UXNFR3FRTXB5cXJ6N3M4Q0gyb3ZzeStCdEI5UC9VdHhaZzh5M3hNMGwwTDNs?=
 =?utf-8?B?U3hWdFdUL2RYWGJoMURoMFc1MVZxSXFmK0tlclFRa2d5eDZMUFcwald4QkZw?=
 =?utf-8?B?TGY2OEVFR01xY0Uvd3VIWFVtQmR6WGlkTjNOTDY2QVh1S3NUMUw5SXUwYTY0?=
 =?utf-8?B?Ym1WQVVUdGFhdlhQQzBLTVZYNGkvMEo1NGt0WUZqSG9hRWF3ODkxc1J0TGhW?=
 =?utf-8?B?TVBJTVBpYU9tY0R2VkpLM2tuUFRNSE41VFNLTFFlazF4Tk1zVkg1SUIrbzVB?=
 =?utf-8?B?UFpUYmw1dGc0ZGh1dWVQR09QcG0wd3FsMmJBcysvdVZ5TUtvZTRhb050ZFhW?=
 =?utf-8?B?ODlsYlJCTVJzZWtoNUpoMFVockFOeU1uMTlGSnpTTHFML2MxS05TYm9idmtS?=
 =?utf-8?B?T2ZkYWZ6WEJjMW1hZC9mV0NyZXFoZDZxMnhlN2tpaDNKTUJ6eWdwMHdjQ2xt?=
 =?utf-8?B?aE1IcWdWWVJyZkpkRXV2cjNvRkgxcER0dW5XWHlXUXJ4UGgzdFF6OHlJOFRO?=
 =?utf-8?B?Q0pzcVdmTW9ucXNEZTRUTFBZL1gvUmN1ejdWa1dEd0YxMngrTnF2ekdYdUVi?=
 =?utf-8?B?blltSmQ3NDNMRzZZOHNTQldiQ2NKU0UveXl6MXlOUHlKOTBxQU9aQkpmQ0RI?=
 =?utf-8?B?ZnFkNWxYTmdHVG9VTUlpcnViYXRFTGtCeG9YQk5IZ1IzUlIxZW9QSWhpQ1pJ?=
 =?utf-8?B?cTZTSE9ZTWp5QTAzaFpFTExtUVNsbmcxc0NyM2RPMUdrblIvWFIrN3plWnNH?=
 =?utf-8?B?ZUFvdW1PSEhCbFBoUjNiZEJweDZ4SGVRTWs4em4zUXpWUzFoZXRzd1B2VkVz?=
 =?utf-8?B?aWprY1ROS1JoZ0ppS0FzRE1sYVJJd1B2emFxOVpxWEtqN0tEMmdFUndyUjM3?=
 =?utf-8?B?MDBhUC9wLzlkZlVtS1VuenRTZmdBMkpPaHVSOTRiTkJKemVqdm9Kc2RQVnU5?=
 =?utf-8?B?c3V0MlVPR2F1WVJPWHF1RWJ6MnBCeEMxT3VpK1FERWV3VnZPY1lMRTZrNEFu?=
 =?utf-8?B?RmNka1diZXRBbVdTd0lkR1poZUIydjJ5MzIzNDAzT1RPaStROWFVN2FoZ1Qy?=
 =?utf-8?B?NHRiTEFMZCt4M2FCSVBSZGxnK0lCczhINEgwVHpUSjJ0Sm5xWWFRRVJSemZq?=
 =?utf-8?B?S3hsazd0ZGlFT0VBNGpxK2piUDBYb243bHFCTWxhZEQrazVITWNFeDRrZ2RT?=
 =?utf-8?B?Z3kvU1R0d2t2dWF6ODNOV010V3Y3bFJRcHRuNTRZTERVN0d3cFRNZmN2WENH?=
 =?utf-8?B?ZzdwZXV1RVAyalBpUVUwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THJRTThFRWNiV0NGQVB2bXhsakdRNFU2cUVTLzk3N2F1cXBteUtxdTRtZW45?=
 =?utf-8?B?L0k1Nm9kQmFzU3gzYTNUNjAxcHFHdlNXdWQrOGVUNjZLV0lUL0VTcG5FcnhW?=
 =?utf-8?B?R0Iyek42bTVXU0FQcm1aTS9BKzY4Ny8wSDc2RHZCTlJHOVRCcFVYRFVnNzdm?=
 =?utf-8?B?T1NVYWcxSUZ6bmZDVXEzNnR5T3IwK0ZEdm02TGI4RmxsMWFOLy8xVEVvQW1z?=
 =?utf-8?B?S1NrMXFjTUN0bEJkSzNzTFlhelB5QWxSZkZENCszNDczQ3Myemk1Z3RKTE5j?=
 =?utf-8?B?UWlwdlE0RnJKR2ZpVDA2RmxqbkdLTGdwOWZvK3Rsd2J1TEdwek5pellKOXV0?=
 =?utf-8?B?bVdpV2NCQTlmeDhaZ3pqOGJ4ZVlrSXFrRVhaNmtKY2FjbS9RbmRXc0dtVFVH?=
 =?utf-8?B?TW5OWFU1S3poSmF6dFFGNVliTnE5TnZkb1A1Q1J1MkpzZWVmMTFOanloMmZi?=
 =?utf-8?B?NnQ3dG1qWTl6bEF2MlFRNFRWL3JhbXpocEYzSkZFU0lJY0MzamJ1NklocXFt?=
 =?utf-8?B?TzdPOFZ6bzVPQTlSUTRCVUkwZFpBTFAyS3kvRXFzWGFrSExZNzljU3IwMS9M?=
 =?utf-8?B?R2RqdW00WDducW1ORVQ0dUJYRFJxOElHTFA3MmxzeU5NTE03ZDN0aGIzQ2s1?=
 =?utf-8?B?MklYU0N4Mkw2dDl0YmNmWGx4Q04vYlJOWlpaWnh5eGJBUUo4LzRzUHFJdjAw?=
 =?utf-8?B?d2h0ajh3dVBFSXkvbTZsekEyeWlYRHNsUUlhdmV6QzA2QXB6Sis3bkFnNHd6?=
 =?utf-8?B?aWhyV0dNVTU2ZytENlQxR2VnOXk4NDFEb2Y5NFZDS0hRSEg4bk9KRGxQUUc3?=
 =?utf-8?B?bnlYeS9GVk9rSWxwd20yQlhtbmU3WFVFTlNWekVHcFk4YndCdUFHNk9zMG9D?=
 =?utf-8?B?UndITHROalV3Rkoxckl0dG8yem5aem96RnVIUUV0Yll5SGVGQ2VhL1pybGc3?=
 =?utf-8?B?VFlOSjlvbFUxYmpFa08rWlFCMStacCtkYUhHenhXRndOT1orRjhueFJnVEND?=
 =?utf-8?B?elZOaW5CZUZvbFpIYTNHWlgxNXhrMGFHSUxQK2wwM2ZKRTl2bnhpVnlqWU9S?=
 =?utf-8?B?ZHpSV0hyTENxeXErcTh3UHBsWGsveGcxMThBbWpuM3EwcXNTRjJGM1M2MWIx?=
 =?utf-8?B?SHRwWmhibXJXTkJZbXlEb0xrYjZOR1hKREN4NVp5Z2cxeVI1REtESGlISEF1?=
 =?utf-8?B?K3RvTkhxSzZyeXpyYWVxT3JzWnl5c2dPbkFRc1gzYWhwZW41MXJJQmNTMVRw?=
 =?utf-8?B?MkdyQjk4WmpOMnpJdmJXTExrUm5DbVZWSWdCUlVLNFFuT2dkNmhpcGxVRVQv?=
 =?utf-8?B?a2hYc2VEMmlMRnpDY1gvU2J4SVJKTUpnejM2WHhjRmVyZVhBcE0yc2pTeHFJ?=
 =?utf-8?B?ZzRUQnNaOVZ4ZHpnZVZzVVAxVHl1dDR6RGdsWUN4ZjZ0dW9FdjBEVWZ2cGJi?=
 =?utf-8?B?ZlZ6VHdicm5ac2l2c1JKb2Y1VHRHNnVYS2hBbU4zN04xSlVKTm9vK3JScllz?=
 =?utf-8?B?RlorV0FuV3FUY0p4SENFUmVpVkcvRVkxUUdrVkVWWUh3ZEtrZWlWMG8yeU95?=
 =?utf-8?B?ZUZFOHk1T1grSkFNV1Ftc08zWWh4a2JBZXBCQ2hOQUo0SldpMlJOMkpma3VL?=
 =?utf-8?B?dzRrR3dCNG1zcU1nME1taHZ6YXcvVW1sMkI4OG9Ub1dkd00xekhaUHEzWlV4?=
 =?utf-8?B?MWRDME1kSndBK2lNa2krbkpQL3dOdDEzUTdoVE9kMXY2OXBmMDJFSHFTUGZH?=
 =?utf-8?B?MC9qZUFNU3c0OXNad0kxVmRHUU1ZS1JGRlowRzRNLzZCM1RFRm00RTI2N0NL?=
 =?utf-8?B?UkF3cTFQOVQxNWJFQ1FQaEt0RTR4aGlBeDF1S3NzV1o3dUZQQ1JCYUZnZEI4?=
 =?utf-8?B?Uis5WlduWkRBMnBOczNCR0VQZFFCWU5SS1kzZi9ZTEF6aGFHS2NCVU1hSXZR?=
 =?utf-8?B?clZZS3Y0Q05qVVZSc3ZKTWJWVjN2V2NRb3dCV2xqMWlLWGhvSW51NUVFVE9F?=
 =?utf-8?B?Y2ZEOWNibjJoZ1ZRMU9UeFVmaTltdzMyUFNNeWh0QnhNcEg3amVlNG8xZ2pW?=
 =?utf-8?B?Mm5RVmg4T1AxU1RQa3hxYVVuZzNkaHF0OVVzNWNmVkJieEN3ckJORVNXb09k?=
 =?utf-8?Q?I4pthcTgEtoeihlgO/LwabxDD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee3b793-27ee-4ebd-02ba-08dcd27b2b6d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:02:43.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEoESxleqW6vpXU/ksVulL7yuMhl13kxTmhZz0St4egQoVlhVsv77qkZMmVca8qbY4STuIaFpCMX20Z/MTmDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

On 9/11/2024 02:34, Dan Carpenter wrote:
> Hello Mario Limonciello,
> 
> Commit e121c01c0422 ("cpufreq/amd-pstate-ut: Add test case for mode
> switches") from Aug 31, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/cpufreq/amd-pstate-ut.c:290 amd_pstate_ut_check_driver()
> 	error: uninitialized symbol 'mode2'.
> 
> drivers/cpufreq/amd-pstate-ut.c
>      271 static void amd_pstate_ut_check_driver(u32 index)
>      272 {
>      273         enum amd_pstate_mode mode1, mode2;
>      274         int ret;
>      275
>      276         for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
>      277                 ret = amd_pstate_set_mode(mode1);
>      278                 if (ret)
>      279                         goto out;
>      280                 for (mode2 = AMD_PSTATE_DISABLE; mode2 < AMD_PSTATE_MAX; mode2++) {
>      281                         if (mode1 == mode2)
>      282                                 continue;
>      283                         ret = amd_pstate_set_mode(mode2);
>      284                         if (ret)
>      285                                 goto out;
>      286                 }
>      287         }
>      288 out:
>      289         if (ret)
> --> 290                 pr_warn("%s: failed to update status for %s->%s: %d\n", __func__,
>      291                         amd_pstate_get_mode_string(mode1),
>      292                         amd_pstate_get_mode_string(mode2), ret);
> 
> mode2 isn't initialized if amd_pstate_set_mode() fails on the first iteration.
> 
>      293
>      294         amd_pstate_ut_cases[index].result = ret ?
>      295                                             AMD_PSTATE_UT_RESULT_FAIL :
>      296                                             AMD_PSTATE_UT_RESULT_PASS;
>      297 }
> 
> regards,
> dan carpenter

Thanks, it's also fixed by 
https://lore.kernel.org/linux-pm/20240910233923.46470-1-qianqiang.liu@163.com/T/#u 
and will be in the 6.12 PR.


