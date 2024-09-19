Return-Path: <linux-pm+bounces-14490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1897CDBF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 20:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77821C221C9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93771381BD;
	Thu, 19 Sep 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hZkQd/4P"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363B381B8;
	Thu, 19 Sep 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770979; cv=fail; b=UfVmeZtX3OL6fdDRH6MjFr7g2xiJyIMRLKC4CezV1j/kOAUA2QOhRyMHPgwYO+YD8J1uHS3ZtFZXCQp80fHyN3EOg1i989aXA3lHBQuHt8NS1+VoLqIr+yh9JRu+yYat3DhM9Ajoa0JGASUNPV2cvtOO71UeknJDWZwUwHIXpBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770979; c=relaxed/simple;
	bh=Qy7oYZpQmqV2jcd/GR/yLcJfJccXrDOeEWuFuBZ5Rtg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ry/YBOBVP7vE3d9jE6ofvnmLvM0PYC15+n0QZYrLaPiskb0Jy9u0GyjpEASAPpUqaUAEbWV2hlxQU5EKsxMNXHlVLcbDuEWxvh9f7zsY64HNYVMq7IrenWq2BXW4osDbwtATjcsKJ2f1UtMo6fkkDkqQHNDVKH3EhwQBBusAxk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hZkQd/4P; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSRH57X7Xy6SIWahon5LfhWaUEoM2/Va/0fZbtnJPxnE0Nmlel4P1kpYJU7DRe104M9pRlqvelWKY6M1PtxRgZwnEwsQOaGY8/IXSl8rWWYF+4ktuXe6uyrs4HE41TdEylET9zSRXOichQ+sT181Ut6YxkTtoklSvAfimZrs0+4nDf0E6mXkQ0tu8zZY5M5NoCkH49BO8CbTAqOHXeYYjSavQiCpp8lgFZycDZmUlcBMxf7IaTkJAnYzZNnG6Pt0exhGDma6OZdTRE19CQjB+DcXncadF4LcdU3UTCE5dWlp4NWIr4oUOfucVrX9W4QDMqn4b/kSNfoONZ4MDUzEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm++idF6vefBQOAiRH+i3UydVNp7jTUjAfUR7jL3iHQ=;
 b=WPU8uv6qIyc4LwGcUIhDs+zGF+nhtwKgZ4hXNc3qa8bHCfnv58fhN8jCTOzxNTSOWK2z1Ws7xXMD2sXh82EBEl7vRG9qNtD+zfu7pgkQs9kOLpBmX+xl5ZnXEM1ytRVj/5h3G6i1hzXEpqPP8nLwPojlS+m/4VhXI2PHd3l5m2sAc5JAu2p5PpMMXal3M3sbWLMgk90zCS5O/bI0WEdFErGEXONPtV/apYqANlmPgU2nyiXAfeWLAZzxkFdJyTcmju5BtdgS/89mluiopc/6tQSzVgS7wAsbyg3xWtIbQ1V0ImbcD1c6c17aINNDHm8k3mtw3vNolp5rX1GYFMTIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm++idF6vefBQOAiRH+i3UydVNp7jTUjAfUR7jL3iHQ=;
 b=hZkQd/4PEhXJnK6YkT1PhS/VxnlOH9ypTmpkfmp0bDN9YfIRHsPPc1Hb4qQ9vZqULmlUFLsJDw2BsaewBQOLVCmSRL/bxCbporINZfY7Etjus3dyChQI4kX1A/30ggtlsFcyNq2mlTwBXZgxcKWC/FGCI81NFmpgDKoMGQP1To0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 18:36:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 18:36:15 +0000
Message-ID: <ffba6d9e-cef6-4708-8fad-80d806e35308@amd.com>
Date: Thu, 19 Sep 2024 13:36:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] platform/x86: asus-wmi: remove Ally (1st gen) and
 Ally X suspend quirk
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, luke@ljones.dev, me@kylegospodneti.ch
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-5-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240919171952.403745-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:930:a::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: e71aaa98-a2f0-4297-aedb-08dcd8d9f15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmkzaGhVTjFoQ2s3c1lzZjFsT3JFMzFaaVJRU0tFN1pOWUlIZTFJbnhPZUVv?=
 =?utf-8?B?RW9VZ2xNeERSbmhzSlVER2FEQTFtVmpidVRaUTRIS2VBcmJPd05tbEd3ZXVu?=
 =?utf-8?B?STVSb3dkY1drOWszamc1dWIwMVB6MnNDY3VHdWlRdUYzbWg4VmVDRCt3aEM2?=
 =?utf-8?B?L0lYN1FjNytEalpqUG41YmIzQU9lVEowZlZMWFM3a1NrNm9rR0xVNnFjZ2Nt?=
 =?utf-8?B?Ly9nYndFK0NWajJRRVFWa0JFSXY0V1lscE8vWGQxb2kwL2VFdXZBdkJ3K3l1?=
 =?utf-8?B?S01lVEorQlhwSnIrSkE1ZS91TXdHY2hGMmEvM3N0MzBWaUR2Nk9wS3hYeFcr?=
 =?utf-8?B?SXpFSnFBU0piekdTdk1EZUcrTkRQUFBncng5Nlk3VzB4MERtSE9HZXlpcUVv?=
 =?utf-8?B?NDQ1clVKY0tWcEp1dlA5bDRqMWFHTlQxUDlRY0ZQQnhtZkU1MVJ0dTg4WlNU?=
 =?utf-8?B?d05HS1JuTWs2NElablMrbGVzc3UxR2hxSlhsbjZYTEpkamtXdkRzR240ZFNS?=
 =?utf-8?B?c3Z3Q3E5WURNVWExR200aE9YZEhqczRqYWlDdXdwNVcrM0x3dVUyWHFzWjY1?=
 =?utf-8?B?VmJxOENoNFR1bnVXOWdjbGNpSDFEMGE1V2YyWU1MY2lXcVlHVkNYMGM2SzNW?=
 =?utf-8?B?MnlnSG5aRWpsNDdaZjVEbFJjUTV1Wi9TaEVMY1JuT2l5Mk9rVkczenk4SHBE?=
 =?utf-8?B?WUV5ZGcwUUtqell2SkJMLzdlamwvaDgzOU91dTVaQ2dhK091Tll3a0diTWdN?=
 =?utf-8?B?M0lkNDAyWjc0dHdXa0VMUnNDaitRRkE4SDdrMFhLMXlkNXZwck5EbTlYclND?=
 =?utf-8?B?SVM3YWZmT3lYaGtpY1dNYkZrQmZKZUREem1relp6ZG5sb1U2alpEOXN1ZEpX?=
 =?utf-8?B?alJXamxMeENOQlJrMWFKQU9Eb1JEeVc3b1B3ZlhVR1ZuSVUxZHdkWFFMamYz?=
 =?utf-8?B?bTJjZzR4blYxQ1V3TGdlRWhsR2N6Ti8ybDcrdW5CWWhYSXg0MWJsQXVZZUFC?=
 =?utf-8?B?RHRheng0M2xrUC9BSWdnQk11Qk1ta0s5U0ltNHhtSTlRS2JLVmFFVzdibGtF?=
 =?utf-8?B?MlhPVEFsWXdzRzdrWXRsRUU3OXVPSThHRTJ4N3dsVXZFOEN4VW9VMEpNVmNC?=
 =?utf-8?B?SWFUaENVUG4wbmEvc2FjbStvcHpiWlNsRFlBRkhrYUhnK29rU1A1K0lUWjZF?=
 =?utf-8?B?eE94SXNEVjVkOUlKNkZRb3o4cU9lRHh3L3dkeDlEM0l0a1NyVnNwN2pWbmFw?=
 =?utf-8?B?cUQrU05hSmNFd2pvcC8xT2J1bndXOWpIcFFFMkVMSjNlTnVQcXd0aVFrOWlY?=
 =?utf-8?B?V3VmZFJhcWsvL0QvbWFtRWltcDMvb0c2d2g0dEdFMUNXTGkyVlNVUllRQWtz?=
 =?utf-8?B?T0RMeWJUSkhBWm1DK0o3SStZM29XT3IxZm1mbDhuUVpDcWZPTDhlTVBweFVv?=
 =?utf-8?B?aXd6UllWNGd4U0FrdHkvU05tMjlKa0grV1JRU1BmbVp0dEt5UGxwZzFPS3lX?=
 =?utf-8?B?anNmdHlsRktuUEhwbFpENFErN1NBUXU1NzFYdEVZbjdJbmNoUWlTYXhFZk9Z?=
 =?utf-8?B?Tm9CK2VoZ096MEJWbXo1Z2E0NXFjOEJtVnRoRkdLazU3blh2WVlSK2xJeTk3?=
 =?utf-8?B?Lzl2QVVkcVRtcjBFdnhIZE5pQVFBZ1BIQ3Zvc2JzZW1xL0h4cVBFeWw2SVVY?=
 =?utf-8?B?bFp4dUkvOGJUYk1LYTVVV2xjcm52VUNLcmhFQWJYU0lWazN6VUxzUnlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWxYeUFORlljczhMR09kUUFLMzhoM01SM0NJNDVod1g4VEkxcVExbmE2VWoz?=
 =?utf-8?B?YXFNUFlCR3UyeWo4S2NJV25WeE9PWTFBZmF5OXBwaC80QktMQnZRL1RrUWN0?=
 =?utf-8?B?QjlUU2h1Skx3bTFISVZINGtrcGpXM2VUTDhqNGcvdFcxRS9SMi9zMDlGSk9q?=
 =?utf-8?B?ZnpyTUZUL0xubnRmNmdzZWRsNWEyc1czNjNPWmZ0Z3Z2ZmZIR2NZUXdKcEFI?=
 =?utf-8?B?M09ocVNxc3F0Um5jaGVWc3FIdDNlekFrVmpsWVBsN2NmKzE0elNITFF6NThi?=
 =?utf-8?B?cUl4SkFhQTA5WlZzSVBjS1BhRUR2ZFJobndkVFo1KzhwY0pUenN3UXZqd2FX?=
 =?utf-8?B?R1V2ZEk3anJkUG9jVHJ1WmpyaHUwWU5KYlIyV1BWMm8vTXhzVU1DaTl0U2JO?=
 =?utf-8?B?WXRWaHVJTCtoY1VGNlpxUlhOSjJLNkpKaU9jWmwxcnJrVnNzVVFGc1FweTUx?=
 =?utf-8?B?UmpxKzIwc2Z1WkNGcVNRdisveWYyZC9PVC81V0xoNFlyU25hN3JndlJ2K0Mv?=
 =?utf-8?B?M0xRQmtNdCtQMVRMNURWU25iS2xwR1B1aU9BbldqbVR3ZytmUUxKZnNGK2do?=
 =?utf-8?B?OWc2VThFV1RUdkxUcGxZcXcrbS9BWG5ERGJtTFNTV1pQVk8yZHNkSHFNbjFP?=
 =?utf-8?B?UUtGTnpHOWlyT2ZHV2hEbTdCSlZUL3hTV1lES3NOWnRkclcrYnhITE5lZU13?=
 =?utf-8?B?ZlZ6UW9kRXR2R2U4bEVjR1ZUNjlKZDBoeWZ0ZlpyTmNNUlM3K3krdFRrR0tp?=
 =?utf-8?B?NXNuVnV2RC9MVWhLRCtMcUJQVGEvU1FrTUlPOE5vSEFRTUZXNmx5SHgxaDZI?=
 =?utf-8?B?R1dUK05mWDVXbmcreUorYk1TdVdEQW9lYzUyL0QxRGpMWHRXakhCc1lid0o2?=
 =?utf-8?B?NTNacllVdjV0R0ZSbFJVSkZhemNjZnFIUXY2WTdJNkFzUll6YUo0aGNDV2FJ?=
 =?utf-8?B?eE1HRWRFZExCakZNNzl2U0xMSk9Pczc5RFR1SVVtd3pJMWY3WVNWWTNFWHZr?=
 =?utf-8?B?SHpYUFRqZ2RvMG53Sms3cDhJOElsVGJSZTYxb0lwR2V5OVpoNUVVRG1Qb3RM?=
 =?utf-8?B?a0trVE5jQkRNblcrOGYvcXNlaWlDRkxLaCtRZk5KakswdlA1SWJ1OTJrcFNr?=
 =?utf-8?B?Z2VNQlYwMkZoU0w2V1lvY2JYUHo3SGxmUnpmV0JGSTBGT2VaNHBQcU5yYVNH?=
 =?utf-8?B?QmhRVlJMN09xLzFrVmRpNXJaamkvdU1uY3FjaDNncTNhcHNmMHVrUzQ2SjN3?=
 =?utf-8?B?WjB1S3ZWT3pYRFNyeUJSdTcxTkZuWDh1eFJOQWlRZjhhdUU4UXJrQkVJeGF6?=
 =?utf-8?B?bERocllRQk03QzVPcHh5NTQzRUhlQnl3ZDdRcjFOeGtpbU5QakRZT2pqdFRP?=
 =?utf-8?B?aXNBb0ZaMENjVElENlFsZFo0OWRiT1k1bGFOR3ZJZTgyN3VLbFdNbklYZGh0?=
 =?utf-8?B?ZjJWNjhDS0l1a2pEZzJ4ZUdIL0g0SWJ3akFweWtBSU9aZ05TYmdpaFRkSkxE?=
 =?utf-8?B?WFprdm10MGxDY0tsM3NTSUFKdzJhZUlpTmxBN1Z2c3luTFlvd2Vva3UrM244?=
 =?utf-8?B?WkRETVMyS2dVcTlSWmRwZ1VCS0NHdXhEWUw1Y1hGM2czZXBVSUhBWmRVQSs4?=
 =?utf-8?B?SnVrdUlHUUVHQU9Uc1l3eG1rcU40WlR6OGZ4NU5CQ3BOYk5vSmM0OCszWWl4?=
 =?utf-8?B?b0RnaGxOVHVNclJiczVPWjdOcnVycUYxSElxRG1UamlhRS9kVEh4a2lObTVa?=
 =?utf-8?B?TXZvSVlXQnFVTk9YTXJ5ZHRKbXVoVnRpaG4rcEJicjYrQlZhNGEvYXZjUVFR?=
 =?utf-8?B?cWszdlJBTHFRR00va0Z5WCtCTFRaT0gxUkNETUhCN1J2R0FoQ3pka0Z1WVR2?=
 =?utf-8?B?VFJ1SUFUblBaNWhoRDdsZ2pSZXVNUnpIUWxBTGkyK2VoLyt4WGpManJkVit2?=
 =?utf-8?B?S01pck5WL05BY3pMMlNrcjM2SDgzdFNTZ3VXWlhTMWU1VlQ1Q0w2blhhZVU1?=
 =?utf-8?B?eThYWXJtOHp3TytVTEVSQ2lEL2tCb3dRekN4b2lxaVcxYlJGUXN6TVFjcGJ5?=
 =?utf-8?B?eEdSMWpxWmVlaldJTFllMytIRDdUbkJiOHoxbkFqcU9UeEY0VGxnSmE3SHNL?=
 =?utf-8?Q?+ssLKcMUX8GYV6DlZ4ZycDI4p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71aaa98-a2f0-4297-aedb-08dcd8d9f15f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:36:15.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Svz7Pk46qeBBAmMQpRA9zinjlc6LmAO08W7knpXwba+XLG3tTr/N9yPJLnrMJ+rNsmoNGlUFzsvajyvJfu4Ylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

On 9/19/2024 12:19, Antheas Kapenekakis wrote:
> By moving the Display On/Off calls outside of the suspend sequence,
> the racing conditions that made the Ally controller suspend unreliable
> are completely fixed. This includes both when mcu_powersave is enabled
> and disabled. Therefore, remove the quirk that fixes them only when
> mcu_powersave is disabled.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Yeah this makes sense to do if the core issue is resolved in the earlier 
patches.
Feel free to include this tag for this patch in future revisions.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/asus-wmi.c | 54 ---------------------------------
>   1 file changed, 54 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 37636e5a38e3..2c9656e0afda 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -137,29 +137,10 @@ module_param(fnlock_default, bool, 0444);
>   #define ASUS_MINI_LED_2024_STRONG	0x01
>   #define ASUS_MINI_LED_2024_OFF		0x02
>   
> -/* Controls the power state of the USB0 hub on ROG Ally which input is on */
> -#define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
> -/* 300ms so far seems to produce a reliable result on AC and battery */
> -#define ASUS_USB0_PWR_EC0_CSEE_WAIT 1500
> -
>   static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>   
>   static int throttle_thermal_policy_write(struct asus_wmi *);
>   
> -static const struct dmi_system_id asus_ally_mcu_quirk[] = {
> -	{
> -		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> -		},
> -	},
> -	{
> -		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> -		},
> -	},
> -	{ },
> -};
> -
>   static bool ashs_present(void)
>   {
>   	int i = 0;
> @@ -269,9 +250,6 @@ struct asus_wmi {
>   	u32 tablet_switch_dev_id;
>   	bool tablet_switch_inverted;
>   
> -	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
> -	bool ally_mcu_usb_switch;
> -
>   	enum fan_type fan_type;
>   	enum fan_type gpu_fan_type;
>   	enum fan_type mid_fan_type;
> @@ -4698,8 +4676,6 @@ static int asus_wmi_add(struct platform_device *pdev)
>   	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
>   	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
>   	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
> -	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
> -						&& dmi_check_system(asus_ally_mcu_quirk);
>   
>   	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
>   		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
> @@ -4892,34 +4868,6 @@ static int asus_hotk_resume(struct device *device)
>   	return 0;
>   }
>   
> -static int asus_hotk_resume_early(struct device *device)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(device);
> -
> -	if (asus->ally_mcu_usb_switch) {
> -		/* sleep required to prevent USB0 being yanked then reappearing rapidly */
> -		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
> -			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
> -		else
> -			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
> -	}
> -	return 0;
> -}
> -
> -static int asus_hotk_prepare(struct device *device)
> -{
> -	struct asus_wmi *asus = dev_get_drvdata(device);
> -
> -	if (asus->ally_mcu_usb_switch) {
> -		/* sleep required to ensure USB0 is disabled before sleep continues */
> -		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
> -			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
> -		else
> -			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
> -	}
> -	return 0;
> -}
> -
>   static int asus_hotk_restore(struct device *device)
>   {
>   	struct asus_wmi *asus = dev_get_drvdata(device);
> @@ -4964,8 +4912,6 @@ static const struct dev_pm_ops asus_pm_ops = {
>   	.thaw = asus_hotk_thaw,
>   	.restore = asus_hotk_restore,
>   	.resume = asus_hotk_resume,
> -	.resume_early = asus_hotk_resume_early,
> -	.prepare = asus_hotk_prepare,
>   };
>   
>   /* Registration ***************************************************************/


