Return-Path: <linux-pm+bounces-24443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584EEA6D603
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 09:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94FA1672ED
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 08:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31825C71B;
	Mon, 24 Mar 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jfe8WRSt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A918FDA5;
	Mon, 24 Mar 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804376; cv=fail; b=mZpI2K8gLN6NiTUV01j/99STEcicnvdNpzDnNa72myMRrN7DVPsP0E8RrS7DkhIcTOHDZ0JfoZml7MxNQ3NyRvhzzmZ2iFUg2lFvv1EN/XtpLgiIG1skdWyHahqa4+I9yDkcWe+tbsLHw9Fm1qjn0M00ljVU+z07unZPaVob3Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804376; c=relaxed/simple;
	bh=BjS+vIe7UNwjw2PqdR/968FPh80YuyBmLlavzj8wKqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmfPaC+GFIcfmjQnVvlgurExr4jnp2DjfEvin23zlMns0Km3r4uDDdylIGScDComtdEWsSPycnO5s3UlAKHc/uon8UJ4ZsMSK+2sLS3suU0eAP9YnrvRSj1SryOw/l5ZINf+qFMzSkCB/DS72+RJ/OxfAUvLuTEw8plD7Cq8Rb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jfe8WRSt; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo5Paka7HmIZPb9rQ9fF0zD0RWTLlpWE2PGX1p9UGmF+5GStaSTit9ETbd0DFi5R+WsrlbDT8tjEV5Sk3y5CGjKwcv0jTsaniKOAhkOHiQe2215wrxUmXmTk19JvJvJJ5Jnh9NrfHOraCE3FJUxeetz9r7x5QKgtFW919EBHh+zCd4cs5VSxHKnleto45LS0emj8rToXx71VyviMck/IMQZQtTB10Mg1dlHacudivvgd1pG9kqoasZAamViBBIKjHnzp4j9IFXxxkAUrsWRrOWwmQJ98/K31BVfuWaiRtWFbVbffK0StUmwG0q6R1bJB7Q5Fdaro+EMWwO3VnDVXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYcrZXLrqXRkmJQenHCpEGYiubgG7GDV3Pk/Dyus9sw=;
 b=n5yn4dhws9UAOV6CT0Y+sL6GKmdkN2WagUfIv7usWhdjAmZ+yAlqL0MPghEi0xkzY1BzzKMXAJhCaRQxcR1GmgSMNzNLZ1gYpc3Dpv4WnFi6xbDFGHjcMdF585RDElDTR5Ca2AlEFD569XmClfLQJj/LLyO1IBLCqhe/fxl5iR7dUm6Fd754k8+fHPeS9l9mquNo+FV7rLVaf16tWziqc3UosF0Cgt17w5Q8hpscwOTKTYLK5pUrWc+3bhlPZYRrzaHZQ2pggL0Et/xPCqocs+JZOMfllW3xoEivkjLIm9pPI55se6IWmGno3P8qvO3qSqdBW8SPzROlN1bJwMZULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYcrZXLrqXRkmJQenHCpEGYiubgG7GDV3Pk/Dyus9sw=;
 b=Jfe8WRStf6cn3cSL3vTM81SJJqAHJQC+GE/ooqDMzkbf36Nfy3kIsiL33DojDcBzD9acbnFOM6UFINSpswsYkLGafejpWgp9uQLGM1WyapL9a2+VF/jXuEfRHQxz9ynHeLTGQsBK60f4Z9CCcKxSMAYJ+PEJZ08/bnx6SfySaIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:19:32 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:19:32 +0000
Message-ID: <186c3fa4-fe85-4989-9edd-fdb6345859a9@amd.com>
Date: Mon, 24 Mar 2025 13:49:26 +0530
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
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: 00326e38-b8a2-423e-2432-08dd6aac9afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWdVZXdheTVPVXQydmh2K3k1SWVaYlRXeDRySU10QUtMNFpkRDFzenFqd0ho?=
 =?utf-8?B?dWZCMWNOb2hQYXZuT0NiZ2hPU2hMQ2pIYWJmankrUGRETTdhMFpidng2dkZx?=
 =?utf-8?B?dFlXWHhBeXlHMDZiUEdzVDcrUVJYR1lwa1JsWC9McFU0TWVscXR5RFpwRHRp?=
 =?utf-8?B?Wm5jQ2xHaGE5a0RZeDVmWEZnbmdTVG9QOEZqc2Z1dThRLzRHRllSbG1xaWxL?=
 =?utf-8?B?YXA3aUwrWXdDTTNTdlA3K3hmNS84eUdSLy9heE9PUWdzVUNRTncyN0lGb3ZZ?=
 =?utf-8?B?VjlhMVJXcDlVUUJlcXI0alNWcURwaHpIeFJtVzhXRFh0dmZrYmZ5cWhMRkdL?=
 =?utf-8?B?T1gvMXZxMlR5dUJEL0QvdnpuNGM0dlQ4TkZoL2VEVmFkT3NBZm9nNTQzNlZ1?=
 =?utf-8?B?MmRzTkJIZ2t3WW1MZ1AxLytBdHJKTVVpWTZKTCt2ZEUxalVCME9CNzN6amQy?=
 =?utf-8?B?Tk8rMkdqU2tDMVVPZFlYanFNS20wQXpMRmdiQnVxSzYyV1FTanFyOE9ISWh5?=
 =?utf-8?B?a25FQ2JZMzM2MElxYWNMcXFDMXJmWGhDOVk2d0NMRSt1T2JwVFVlbXFLZVBL?=
 =?utf-8?B?czRGdE5FQXhjN0Q2dXhSdEt2L1pldlQyNEVrSlIxYStrTU8zZUNtemZIZ3BI?=
 =?utf-8?B?V0Z1U1ZNVVBid0hYbE9JOVhxYzJzWVhpSzJ0ZUVXRG9ZcE5rbmFXMjNMeWJK?=
 =?utf-8?B?MklWR2V5ak1FbFVWTFhCN3RBUm5aUUFMNTBsUGhVNEZuZjBGWW41aHljQW5n?=
 =?utf-8?B?bks2Q3BCclNRbGlLQ1NPcTAvRmxLYVBwZ3pkNmt3SDA0Z3JlSFAydTdLaEtY?=
 =?utf-8?B?YjB2WkNaSGZyWUE1by9wZHpJQW9SVC9oN2NPOHM5RmN0elBTbTJSc0k0ZTlE?=
 =?utf-8?B?NDAzaGpyS1hnQTAwWUQ2bFVwZDJUdzVVVUNnMlJ5U0Y4cWVuSSt0ZGdCMFVU?=
 =?utf-8?B?NHZ0TXRmYTRPOWJLVkNPNHdRWnFhSm1RYVVlOEJHVFF1NytsZDRvOWZZV2xV?=
 =?utf-8?B?NVpBWm0zMXNZeUpocEN0Vk9CdUZUbGZYTXVXZStYdTdDMFliTTJKbHBmbjIz?=
 =?utf-8?B?dEpRUXlSTFE5UXU0aFpzM2RsSTlJVDFtVmJOL2cwem5pOFZYY0xPZWMybGNH?=
 =?utf-8?B?dzVXQUsxd3J3OE1rb2hWdkMzSXdKU2xoV2FZd0JLUXQ4WDF2L3cwUytPT3Iv?=
 =?utf-8?B?eS9EZm4rL2dxVzl4aHdER1hBd1FNcVliRlVnbk5pS0MzazlObzIwRmg3Tyth?=
 =?utf-8?B?OE92SXNXYzE3ay9GcW5yS2k5ZkFsaC9idTMwdWxWQXhlbGhCa0VzLzRVT2Ft?=
 =?utf-8?B?djVsSmVFVXQyV0RUK1kxdDdmT21VV0pLdmdxZmZuTlNSTzRLdTZBTDJkRU5h?=
 =?utf-8?B?QXhuTld2QldydXVlTmhVK3BjaEM3ZElSaU9xUFVnUVRYc05FZjBTVDZKMkIy?=
 =?utf-8?B?eEdMQU5peVFhNzVSVkhuZ1FjYk5RQ2kzdUNUV3BNakNOMlE2U1d3Qk9RT1JZ?=
 =?utf-8?B?SVdueGl5am1sSThTMWR5SGV3YjV0eDVDeUZOMXhxdmUwcjFQallRVXpNRU80?=
 =?utf-8?B?K1J5bGtQczlqdjBWQ0NsVjZES2dRYVJ5MzhZVTlTMFFqSzlGTVZ6UEZ5dFoz?=
 =?utf-8?B?azRzSVAxaExNMC9mekdacXFFSURJMHM2cUVqUC9DWUtwaVJVVEtNcHYzdnRC?=
 =?utf-8?B?S1YvRE1KVmZsaEtkd2FGUzJaQjhuSStnck5FcDhnNTI2TDdodmZnVnB3Mldz?=
 =?utf-8?B?R1VBeVpSKzl4ZytaS1dVZGpSZnlHWEpDZjM1Ri9oM0VSUzlBakJIYytlT2c4?=
 =?utf-8?B?YzBjMlVHTVJ0cWg3cUpWaHNkaFo5YmRxQndWRC9aTEhaMXlwSjRnckZjdHJp?=
 =?utf-8?Q?rFOI9Pyf+GNDf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnV0ZEJhSlR5MHcycGFITnVMc2U3SVRDR00vZ29OWjRFR3pQenlMVy9yZDFD?=
 =?utf-8?B?SzZOMmtTTG1HRm9scEVuKy9yNndPNjVoUGpQVnFlS1RhOHRabC8rN2pMUTRt?=
 =?utf-8?B?eXJqQnRTcW9kM1VvbTVlaXU3WllUR0xwTDkvT0dJU1Ric0ZhZ0RtclJySWV4?=
 =?utf-8?B?eXNpQytYUXNIOFQ5Zm5yNmFRUlpjVVBTaGhaS2RFYk1ZU08rNDRpNzM0Q0ZH?=
 =?utf-8?B?b2lVbWh1dVh0WkJ3WWVBVEx5Q2JLOEZXWURjcDBUT0l1eU93NXFKQWh3VVJ5?=
 =?utf-8?B?ZmIvd2FnMzZoWlk1T3R6VkNyQWlyNW9jdFFxNVRVZUtEc3ozZmUwUzdNRm5V?=
 =?utf-8?B?Z2tmWkNSSFpsSWc4UlVxMFUwb2tKNW8zaGNFRTY3aW9ocHZxR2hoK1ZqUk5V?=
 =?utf-8?B?dmloblhkT1RPTFJ6aVhXdGpxa1ZwYkllU1ZKWVBMYWJ5dGc3OTdyNzdaVUox?=
 =?utf-8?B?K3l5YkczVTlXOHcrWTcvb0tlWGRVdjdtekR3RHpBcmVRZ3dzbkhLZHExdGdU?=
 =?utf-8?B?Y2ZRazJmUkJTakVsVUYzUHdvUENzVytISWRJR3pMMmRCc3NPaVgxcXQ1dE9U?=
 =?utf-8?B?cUxOU09Bd3VPWXBvK2JQSWVMelNSZlV5WGlvNTBxNnp4VTQ2dnFhMkRJek1Q?=
 =?utf-8?B?am9UUEVFUVdkcW5JdnJBNS9uMzJ2NjJoYitWem9CNjBWa09UcWl4REg0bEZI?=
 =?utf-8?B?NTNXR1crNldKcVdETWE3alowWXdkL1J6cXRTcE5LNFNpb3UweWRVTTRNdU90?=
 =?utf-8?B?Wjl3MzVZSlJxREZWeHhmeDJ2N3crK1d6TGZHL1NIeTRoNzg4bGF5bzdzS1Nz?=
 =?utf-8?B?L2xhWWkybm0rSm1Jb1dWbXlYZUFRSjgzUlEyOGdpNjhuY0kwSlhFOHVLTnh6?=
 =?utf-8?B?emYyNEpmMmxQeXdTazFtY3BoTFQ4WWpIZUl6VmFSd0YxRUZWNEZwVlhoVG52?=
 =?utf-8?B?UWc1YlpzbXN5N1BYaURxSm5RdnlYRktXK3FianUzMXczc3ZkWkptbFRyQkZi?=
 =?utf-8?B?MTFrMEMzbmx1WEp3S01QRDlzaGFCVnEvbDZtTHkxRSt4Y3VnZEhzaExXVE5h?=
 =?utf-8?B?eGZqSTBHRG56YXNBSWV0NWUrWHpaaUtKV3ROeFdLdXh0amF1SDEzZGFCN0lV?=
 =?utf-8?B?VjI1YkVaOGhoNHhLdVdKZGpzdDJGN3ZQS3ZLS3g0NnJkZXZtT2twT2d0RUNQ?=
 =?utf-8?B?YS82QzFFQVpIUzFKYVJMZm9SOEtMNkxCNW5jemk5c09PVlZaUUJDOGM5cWJl?=
 =?utf-8?B?SjZlWmhjZ1REaDBmNmVlSFhMY3lpdGovaXpHLzBOa2doQk4yemU0ZnFqSWQy?=
 =?utf-8?B?SUZxZlVoUUlPZnFOTk5hZHFFdGNPY2NBRmxSalJDNFBIZm1TbWNnMHA0WFVh?=
 =?utf-8?B?TEVvNmdLc0sra1NHTmt1Q2hqVnZlU1FvVkZwb05QYmo3QVk5aXEyRFRWOE11?=
 =?utf-8?B?S2JzZnZaQnJrYmxmbDVpWnU1aTRFWjhDaGJaZ0Q1QlkwRk1tSnNwdURmM0dz?=
 =?utf-8?B?OWtxWnJjY2ZURFloL3JXUFRYbVVHaWNlK2IxbzBSbEVkTXdHMWsvaXBhRklM?=
 =?utf-8?B?Szg3bWphR2FFRVFmKzY2QWUzaElBZHlFMjdHVWZHTmpLMXhraGt6bUR2QzFi?=
 =?utf-8?B?RUoxclFjZlpMUHhFeWFLRjJYcFFLLzFvZ0dQdTM3YjQvK1Q0dTU1MnRCaEFB?=
 =?utf-8?B?WFNCSndtejNwdkFEeHhCOHc3MXZpS1Y4bm81Q3RUTENsKzZHNGtDY0tZanlq?=
 =?utf-8?B?bHptVXF2OEZaR09RbHBTRXdtZ01XRnZsTk4xdDhZc2c0U09wTzNWU0tVQnJS?=
 =?utf-8?B?MXBhMk52MFpBVVNVeHQ3QkM4TElKT1k4M2s2YmQvSC9qKzhYVTcwRk9mNGZs?=
 =?utf-8?B?VFJITEtKTmFLUHFnUURJcmxJZzMyMG03eU0wYVNJU0VvRklRK2pIdlZWdWkr?=
 =?utf-8?B?NzJQTDBiZ0t1c3J1NVNwQjVGOVZTb3hBZGdURzVMUEJrdmRqZzQrQlBDNkdE?=
 =?utf-8?B?M1grZ2krSTJHUXNKcmt2QmlEY1czZzZJN0xXZnVMbXBrNVZtQSsvRnVXWkdh?=
 =?utf-8?B?SkRkazVWRGRENlRKdE5sZmhjTXB6ckFtMUFPenhYM00vS3ZicjQ1TUNSdEQy?=
 =?utf-8?Q?iWWnb89TEAl/mWA6WntVrrOsa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00326e38-b8a2-423e-2432-08dd6aac9afc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:19:32.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSQHPKAOxDEBhJxnxfCusx+M6tHfQcPqxAWmRT9ETSLQmdGSp8/sOwF2B9ciRvkxNadsimgTZuhcAoZ6i1Y8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455

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
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 412423c54f258..2e076650dc77c 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -289,7 +289,7 @@ and user can change current preference according to energy or performance needs
>  Please get all support profiles list from
>  ``energy_performance_available_preferences`` attribute, all the profiles are
>  integer values defined between 0 to 255 when EPP feature is enabled by platform
> -firmware, if EPP feature is disabled, driver will ignore the written value
> +firmware, but if the dynamic EPP feature is enabled, driver will block writes.
>  This attribute is read-write.
>  
>  ``boost``
> @@ -311,6 +311,22 @@ boost or `1` to enable it, for the respective CPU using the sysfs path
>  Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>  
> +Dynamic energy performance profile
> +==================================
> +The amd-pstate driver supports dynamically selecting the energy performance
> +profile based on whether the machine is running on AC or DC power.
> +
> +Whether this behavior is enabled by default with the kernel config option
> +`CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
> +at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.

The file is actually located at "/sys/devices/system/cpu/amd_pstate/dynamic_epp"

> +
> +When set to enabled, the driver will select a different energy performance
> +profile when the machine is running on battery or AC power.
> +When set to disabled, the driver will not change the energy performance profile
> +based on the power source and will not react to user desired power state.
> +
> +Attempting to manually write to the ``energy_performance_preference`` sysfs
> +file will fail when ``dynamic_epp`` is enabled.
>  
>  ``amd-pstate`` vs ``acpi-cpufreq``
>  ======================================
[snip]
> @@ -1502,9 +1611,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_req_cached, value);
>  	}
> -	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
> +
> +	if (dynamic_epp) {
> +		policy->policy = CPUFREQ_POLICY_PERFORMANCE;

So, we are allowing the dynamic EPP framework to modify the EPP value in performance 
governor as well? Shouldn't we allow dynamic_epp only with powersave governor.

> +		ret = amd_pstate_set_dynamic_epp(policy);
> +	}
> +	else
> +		ret = amd_pstate_set_epp(policy, amd_pstate_get_balanced_epp(policy));
>  	if (ret)
> -		return ret;
> +		goto free_cpudata1;
>  
>  	current_pstate_driver->adjust_perf = NULL;
>  
> @@ -1521,6 +1636,8 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata) {
> +		if (cpudata->dynamic_epp)
> +			amd_pstate_clear_dynamic_epp(policy);
>  		kfree(cpudata);
>  		policy->driver_data = NULL;
>  	}
> @@ -1556,6 +1673,10 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	if (!policy->cpuinfo.max_freq)
>  		return -ENODEV;
>  
> +	/* policy can't be changed to powersave policy while dynamic epp is enabled */
> +	if (policy->policy == CPUFREQ_POLICY_POWERSAVE && cpudata->dynamic_epp)
> +		return -EBUSY;
> +
>  	cpudata->policy = policy->policy;
>  
>  	ret = amd_pstate_epp_update_limit(policy);
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index fbe1c08d3f061..6882876f895de 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -104,7 +104,10 @@ struct amd_cpudata {
>  	/* EPP feature related attributes*/
>  	u32	policy;
>  	bool	suspended;
> -	u8	epp_default;
> +	u8	epp_default_ac;
> +	u8	epp_default_dc;
> +	bool	dynamic_epp;
> +	struct notifier_block power_nb;
>  };
>  
>  /*


