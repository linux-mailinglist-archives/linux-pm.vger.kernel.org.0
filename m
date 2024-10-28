Return-Path: <linux-pm+bounces-16586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E89B34CB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BA31C21D7A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA11DE3D8;
	Mon, 28 Oct 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LyscmVJh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12131DE3CB
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129253; cv=fail; b=Xajna1dEPnPGA23Sr7MeQWRK+z6odldWeEuVdAe3M/V02jArNsG+huj04wG0McmozmsR/dV+4QabW1uGwOpX/m4flxr9Lkj/FzlJyjaIxGomZbSZSWDNSCqtrdFbrz3O1FHxdnf0LC4UuaAz+Mx1eHqI800c2AY34LMxSxXr0hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129253; c=relaxed/simple;
	bh=viAf2SKUniawelSYTxpCl4CfolotnGT4ZbCFbqCE0gc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnzKVyDMYTmRaIo9XeBMwX1UFqIsuJQGg7DoY4dnMzMKXilU3dnCcbxbU97Nx/ut/b5mILW+5t1/DU0YzhLCVc3JrGG4xPTojmRjjadST2w1RxSEX+U8eM/2v+Lq9b5P9z0eNxhIn4l/ypMKBaKhllLCHOFVuCrRNZXVKO+QhMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LyscmVJh; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjGqrf2D7IdvfoIzjez2InbJdO4Snco9vfcZ7AI2UoVLV9uma/nGQLUAPzU6OkT2o5L7nB7K3gKJJ9bi3bccNSZUJl75BMobfisBmrcL7nndqsAAnF5T1gA9/CyDdCTIzv/hexPPHWthMWYaA+ZI+RZz5wQMNK3//BXjt1QZFuZ0cjIizO5J+axuXVZWp95ugjQZz7+huL4MzdnJ4qfkdwO/Tytl/B2hMc+08kIQpEMDy4BalJX7N7BKxOKwqcuU4huRjJOhnXDFlTERXRif46TzU/HGzRnHK+X4cT3T4pAZWa1E4nf7YXPolGkM53/pug7r7Mm1x/6VOpQ6e/M9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K15+RmGMjKLDIb/5tlfeqvUWOkn49GmOmGXt+kWiq5Y=;
 b=NnIDLg6QLTOpGhE475WTrwlXEtS4F4Wr0FH0hDD/VsRC5No1F6YMLQ2wh0n7H493ouykJazqsiIJG26ShxiIeHFgTEhtvxy5bUWz9+jUMZT5IebwPNmmJMUQGmiF1n97y1zjHggks+wh36ufpcG0yGr/a9k53uLeZUpsZqxmCFvQxwiOXFjxxIs7PzDYxHXc2DF4rQD9VnGLXdHtV5zpVYNd1Vuj1aOLo2iiGDEWg1CB38Tt1Aa8RBm0+oPTsz13QO/hI7SmPIJO5euCGCwRQROJTBstlOBrngeuitQf/C/Lk4JMRbpnI80tyHrgxoo58ENLUb9abHC269AXu8Mzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K15+RmGMjKLDIb/5tlfeqvUWOkn49GmOmGXt+kWiq5Y=;
 b=LyscmVJheGEouONmpjU8PYCbc5JQPDuWv6O8CP4QKp0kRaxtNirqKdbzGYBnsFgmZ+5RnGqajnaTB5H9rzdJmPpMCCEaatS5icfnZrAJEgnIH5xlQnlTYnNbiCCz/UvCOgbwF0xlEcvaqpeWgh8bnocECRnSjndc/5nR+OxuKps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 15:27:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 15:27:27 +0000
Message-ID: <be2b0ff7-6211-4ddc-af48-2cc4f420bc0a@amd.com>
Date: Mon, 28 Oct 2024 10:27:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: amd-pstate 6.13 content (10/22/24)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
References: <19b70e8a-7a11-46f6-ab9e-6dfaf315ef95@amd.com>
 <CAJZ5v0iPGtnimd7_LwwGyoxxSrGQ8pug-JDhc5obWZNByTJN+A@mail.gmail.com>
 <CAJZ5v0hjPVL=vJ=YGNoAKwEej=v27oPg_wvZUQ5KXU+=zD6Q9g@mail.gmail.com>
 <796cf4f2-6397-4012-8130-0c7c7f136486@amd.com>
 <CAJZ5v0jtFYDQ8YRnQwo+sp19J3754ZDY79mcSiC7k--TSg7vuw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jtFYDQ8YRnQwo+sp19J3754ZDY79mcSiC7k--TSg7vuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0018.namprd05.prod.outlook.com
 (2603:10b6:803:40::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aea5811-8c23-4c81-e490-08dcf76507e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk8vT3VDMGtQcXF1c1ZveHlzdkJvTWFSOFFjMmtqekN0SVhOS1p3ekJLVEww?=
 =?utf-8?B?S0lRNUJtN2xEelUwMHVncWtuazVONjhRUDM5Y0swWm5zazI4U25IWVg2bXAr?=
 =?utf-8?B?YU51ZFZZUDBBbTRBLzFvblhVNjJ6YVBDblQ2T2dzOUxMR3NKRjhBaXgxMDR1?=
 =?utf-8?B?V01zZlNwTHoxUiszUVR4M1JXbG1IN2Nsajg0VWdhbEpjZGlTenlQRmtvb25T?=
 =?utf-8?B?NCtCOG0rTW9UMFRIckEvL3NhTFk1UTI2OUM0MEJ3a2VwVkl6TkRRaHc1VlFu?=
 =?utf-8?B?MVo2OUdZeld0T2VPKzBoQXhGTVdrVncwM2RwdWhDbTlPYnBTRVVubHQ3SlJx?=
 =?utf-8?B?SjBCanM4V3hYYkozd0wzTkRuYnZ2a01mSThyZEVFekFNNVQvZnU3bmJ2MjN1?=
 =?utf-8?B?TW01dE92NVBQV0QrdTNWQjRMdno5R280Y05FK2dJTGw3RFoxVmlUZDFWVTFa?=
 =?utf-8?B?bEhVV2RscUhCRHkyRUtBcnRjaHZPUUV6and2czUyMldVaHEwdVRvK2EvRG5P?=
 =?utf-8?B?dTd2YkZjRDY5bllmUXRPQzFtbGtpSDJzRkJFTy9rQ21DcEpUc1QvTjBHTlRw?=
 =?utf-8?B?eHJZNENXV2tTQWhkd2JaK0hMQ3MwTXB3ODA4MTRBdXYweUJ1YmpQT0ZUY2pZ?=
 =?utf-8?B?Q1hRS0V0L1VScyswaXZXbnlFVS9wUDQxTVBVNGdtUWx2Tk1wcXZmZElzNFp4?=
 =?utf-8?B?d1lJa2pLYjhLQS9EK2hsdGtLclI4ZkJ0MmNJaTE2Ujhmd2s2ZkNTaG5BODRL?=
 =?utf-8?B?RkRjY1dwZTB1MWRQRXlYNjAyY3ZORDVsOS83S2x4ZjNPekt5WW9rV3JPMVBm?=
 =?utf-8?B?dUVadGxsenNvdEVLaytrUjE1b0Q2R2NPeE1IYUEzc01xdDZtQ3lYZHNFZU8w?=
 =?utf-8?B?bFd5RlFyYmpVd1hveGQzam13V2dLalNCR042WFIvT01YMmEwTVhmWW5ubno3?=
 =?utf-8?B?WEVSZkZDV2tGWHI5dEh3dXRFVHdoUTRYNWhKTjlwSHBqdldFOEg5TGdvWDJj?=
 =?utf-8?B?SEhjZGFEVnpOYmdPQkFkSFV6Q01sZ3dTU2FxMktUUHpHdFJmaFd6ZDJhTTVW?=
 =?utf-8?B?am9odFZJVFlyOFMrVXcwZUNkUkFaVytybTI5UkYzdVRJdktKTkptRGRHRjUz?=
 =?utf-8?B?eEh2cTIvWEwwbzhKZDJQYmg3TDFCK0lCemZZZkZ4NDluejZ4SHRGOVVPU04z?=
 =?utf-8?B?aGEzd1doMmdVb0pTd3NIdnB3cXQwempSODhkZHhudTlMWVB5TjNUc2hrY1N5?=
 =?utf-8?B?SmFvdVVqL0lBVWhnTldONXYxNGx1ZHU5dVJyeDJLbEI2RW8yVWFsZmthTHR6?=
 =?utf-8?B?b3pjanViUVNHcTdxZUxZcElhVXQrdHpPcDJ1NzJUaGJKZFdDVUU1Uy9QN1pN?=
 =?utf-8?B?MjhZNThETUdWMVZGN09OT2duVnNTZFFvelJiT1JVUTdtQU8rZkFBdXNwMDJR?=
 =?utf-8?B?bk1ZdmROUjJBdzZ0ZHFPYWo1eU1oTzQ5aEMyeXNvajJ0OHYzWEcwWCtSNmtF?=
 =?utf-8?B?eTEzNWx0MC8yRXViVE12WEZabU03RG1DSFEwbGlVVkNENUgra00ybThkQnNG?=
 =?utf-8?B?Z1lNSVVaUy9OcGpyYnVRZnh3bWtOQlNxUkhad2taSGZJc3ZydS9pdVFNdTFq?=
 =?utf-8?B?OXFHTHJ6Slg5RHJoT2NMcHd2Nzg3VFM0UXFHZUpiSS9JcytUSGxwY0NLYWQz?=
 =?utf-8?Q?54c8UMkvYBo7xV2ZUPxr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHVTMjZObStTYWhHSjI3V3lSazcrMVR1VFBRZDM5bGtGaUU5SXIxakFINFRG?=
 =?utf-8?B?dUJkTkkzYzk2U0lncmU5cWE0RTVwdzM5bzFVaUdMSVJMZXBhUDlQc2VkZk8x?=
 =?utf-8?B?cFVaUmRZT1FJZldWMEF3NFFiakVSQXRMNWlubG81U0VCOVN1K0wvcUxXN1lt?=
 =?utf-8?B?Mi92dVZObUF0WDBFVXlqK2g3OVBkM2R1QUNJbWpBMmZHOXhQUXFJbUpaaGZy?=
 =?utf-8?B?OVhPVzJMWlZNWGRUSytZMlY1TnZxZU55ckJjS2h3KzhReDhQZk9kRkY1aDNk?=
 =?utf-8?B?R29SU3JyUkpjM2krZGIyZVk0VEJXZ2ZSTVJGUC9GYUhTVm45anlyblQyeEd6?=
 =?utf-8?B?OTlnQXBBN3lyQmpSWHZvcnRSYStnbVVMaTJEZDBQaTdaQjVValpFODl6SlZk?=
 =?utf-8?B?eFp6Z1lvQkQwMUlHMnVJTnlaN1pwODJkWXZ6TmFIV1pSNHRSMGxyd0FMNVBM?=
 =?utf-8?B?NmFFQkpkWmRJTlRDTVp0WmhhZ3FBODZJMW5FbGpBcUIzbnpKME85a1c1WUtZ?=
 =?utf-8?B?bUkwTFAxT2xIWFVLdW5ncGp3Um9PWnFzOFdsOGFZUWZyMWFoUGhtbkxkc1N4?=
 =?utf-8?B?OVdhNlZuTllRS2tKVk9qS1FCRmhGSm02UDJHUlF0eW5LWUNDclQvTnZVd0Y5?=
 =?utf-8?B?V3BrR0V2SmFuTVY3d3dFYVpJWG9uemNDa2lSYmdISmxZVTMrazBER3llNzhu?=
 =?utf-8?B?ZjVnWmFsWk0wb09XMXh5RlU1TTRZRC9HbGxVRnJSY0ZaT05zRFp1L1BLZzR1?=
 =?utf-8?B?cE1PM04yYmM4UXVVeW4xQXhSNDdMQ2lUZ0JJNlZ3dEpaQlIwclVxOHorV1Zh?=
 =?utf-8?B?NlRIalNkRWFGQUZCMlJla0U3WW56eVFndm5ZNkJLUnBtbGQyNDBVWTNWUENj?=
 =?utf-8?B?bC94WHRYTE5IWXpKTEpHdXJXYWlielBVeTUxL1ZKWThieXFDR2lmZ3EwZDJX?=
 =?utf-8?B?VFNHbGRqR3FnaHYrNlpCYUNrSlRJdy9adTdvRTFXWG4renpiSmZwT2VLb1FN?=
 =?utf-8?B?RnBUZWhVTERoazhxeW1wSWVZNXVucG1KZTJadGhuMHpnSVRLS2Z4WUI0TzZW?=
 =?utf-8?B?MStMaSs0R2tlZlhEZkNhYjlJbnozR1dCV3ZrWTZxM3lFMGRIaW5FRU5vOFFi?=
 =?utf-8?B?RHVJUm5HbzE3bUxPYUNlVU4rMWdzSHZkZ200L3pwNG9YWFdFbk0rK0dNNXZo?=
 =?utf-8?B?WHo5aDZYbXBLQ3hodVpBcC9MbWNFbnA1bFdrRGwvSVllWHVDa0ZUVHFXRTBx?=
 =?utf-8?B?VXBGS0RreTkyb2dSNHlqZ0lDc3JwZ2lRWVU3STR2TlFRNG9KallwVXBzMGJL?=
 =?utf-8?B?VTM2LzhsZk41eHhaVzdOY1ZYQys0aWhkQnhVaEQ2TTdsYU9hVDhHOTliNzE0?=
 =?utf-8?B?NnorVDY5M1JFYitMMStCOVR6elpQZWRzQ21kTFZMWitGSHNaQmtLQ2hrTnFq?=
 =?utf-8?B?KzlUUFNMN2VKVDMwNDY5ZWdyVytSRmdvdEVXWWJNRHBMcUlGaVpoeVJGZjJY?=
 =?utf-8?B?MVVMRnZJN2FjKzY0cVdKbkpyaE5XZHJoa0MxMWJwSnF4aHY4WE1wK0hWM2Fh?=
 =?utf-8?B?alR2NDNlbitKZGZNUUh1VGpPbjMxby9PRHhwc2hCMmRmcURBT0RUQ3hnVFFt?=
 =?utf-8?B?SkNORXBqSTh1aWcxTTFDbng5di9wTFRXUk9tNk9pY1NHSmRlRDVMbnMxNUla?=
 =?utf-8?B?Zk5DcE9GcHppYzk5ZXRPOTdhbVRzY3VzMEo2clJhemp2U1N1amVwSUFBbjVO?=
 =?utf-8?B?ZlhQaU1uQlNOd0ZjZG5XSnF2eWp6dE9paGlMb3Y4OWpPSG5TbCtNM3NrSUtV?=
 =?utf-8?B?bFRFL3hQUXJmSTNkck42QlJHNi9TUDJDbS8zdkt5S1JXT3J4NTJYbG9Od3Q1?=
 =?utf-8?B?RWdmVkpwdFordUFMamYvaTNiOVRMZTNGV0NvMzlkZFpveGdqcTE4aHZpNWFO?=
 =?utf-8?B?b1EwYi9KNTArTkEydGwxV3ZoWFpESkVpTXVoU0ZrakdXTXNBMm9mZDVtYnZT?=
 =?utf-8?B?empCMmFDalpEN0llRVBCek40dmxETSt6V05KUTdCb0hpcnBEUlcrZUpPNm9C?=
 =?utf-8?B?RjdJWWJPNXNVUEFlaEVsTW5sMGd5VXlEb0RKWHR1QXBydW1ValV1YjdZT1pL?=
 =?utf-8?Q?VoRusKIO7xfGj6gOPU4hixFNd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aea5811-8c23-4c81-e490-08dcf76507e6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:27:27.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIe5KtOXc0td3OaxwtNLVGz9rgPsYvlT+xFv52Vd9cREYB6wJoktVLh5hp3r0bEgU0kTn0SGh8VvJ+wMExBgog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063

On 10/28/2024 10:21, Rafael J. Wysocki wrote:
> On Mon, Oct 28, 2024 at 2:56 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 10/28/2024 06:22, Rafael J. Wysocki wrote:
>>> On Wed, Oct 23, 2024 at 3:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Oct 22, 2024 at 10:54 PM Mario Limonciello
>>>> <mario.limonciello@amd.com> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> The following changes since commit 7f31183fa1d5c043864b4bd5632930f40d3c7002:
>>>>>
>>>>>      Merge branch 'acpi-battery' into linux-next (2024-10-22 22:00:30 +0200)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>
>>>>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
>>>>> tags/amd-pstate-v6.13-2024-10-22
>>>>>
>>>>> for you to fetch changes up to 7027b415ff1a4184b99055f11455d5c7041aa3ee:
>>>>>
>>>>>      cpufreq/amd-pstate-ut: Add fix for min freq unit test (2024-10-22
>>>>> 15:21:42 -0500)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Update the amd-pstate driver to set the initial scaling frequency policy
>>>>> lower bound to be lowest non-linear frequency. This will have a slight
>>>>> power consumption impact but should lead to increased efficiency.
>>>>>
>>>>> Also amd-pstate is enabled by default on servers starting with newer
>>>>> AMD Epyc processors.
>>>>>
>>>>> Add various code cleanups to rename functions and remove redundant calls.
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Dhananjay Ugwekar (7):
>>>>>          cpufreq/amd-pstate: Rename MSR and shared memory specific functions
>>>>>          cpufreq/amd-pstate: Remove the redundant verify() function
>>>>>          cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq
>>>>>          cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init()
>>>>>          cpufreq/amd-pstate: Call amd_pstate_set_driver() in
>>>>> amd_pstate_register_driver()
>>>>>          cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
>>>>>          cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call
>>>>>
>>>>> Gautham R. Shenoy (1):
>>>>>          amd-pstate: Set min_perf to nominal_perf for active mode
>>>>> performance gov
>>>>>
>>>>> Mario Limonciello (5):
>>>>>          cpufreq/amd-pstate: Fix non kerneldoc comment
>>>>>          cpufreq/amd-pstate: Don't update CPPC request in
>>>>> amd_pstate_cpu_boost_update()
>>>>>          cpufreq/amd-pstate: Use amd_pstate_update_min_max_limit() for EPP
>>>>> limits
>>>>>          cpufreq/amd-pstate: Drop needless EPP initialization
>>>>>          cpufreq/amd-pstate-ut: Add fix for min freq unit test
>>>>>
>>>>> Swapnil Sapkal (1):
>>>>>          amd-pstate: Switch to amd-pstate by default on some Server platforms
>>>>
>>>> Pulled, thanks!
>>>
>>> And unpulled, because this branch contains my temporary linux-next merges.
>>>
>>> Please.  If you want my branch to base your material on, let me know
>>> and I'll create one for you.  Otherwise, please base your material
>>> that you are going to push to me on an -rc from Linus.
>>>
>>> Thanks!
>>
>> I had asked if I could base on your linux-next before sending it.
> 
> I obviously missed or misunderstood it, sorry.
> 
> The rule of thumb is that all merges in my fixes, linux-next, testing
> and bleeding-edge branches are temporary and they cannot show up in
> the mainline.
> 
> So I wouldn't have been able to ask Linus to pull any branch
> containing any of these merges.
> 
>> Yes; in this case can you please make a base branch instead and I'll
>> send out a new one then based on that.
> 
> Please use the 'cpufreq' branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpufreq
> 
> that I've just pushed.
> 
> Thanks!

Thanks!  I'll send you a new PR later this week so I can pick up the 
other fixes still under discussion.

