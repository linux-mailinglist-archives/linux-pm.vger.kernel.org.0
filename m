Return-Path: <linux-pm+bounces-22787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6BDA41915
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 10:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2ACD167A99
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B4245027;
	Mon, 24 Feb 2025 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hySNSgOG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256324291B;
	Mon, 24 Feb 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389150; cv=fail; b=paxYlL31Br9zpM+si1pftkoRzU+madoSWuIsN2oDGvuGf/MYRdBwgrmLZQu7IxGiS6dTHcjGS+hVEz/DEVMbH0h+kOCgcub5tu5SVLOPiaeoZgXrWRJpVFCkr9g80kpLGT1F8YQWREL9dQCqaBGpux1PAJvQgbSlBgWzS9/jU+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389150; c=relaxed/simple;
	bh=W3DLpqbZMw77+58rx9EJq+nmBVDsdkdonIIbGIOZ3UE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UYQugMgcvl9K6za/6lsN9ueeNmnocmODJZnMIo0pvayJSCvELusyX1+gGd/BqWW4ma7TWhtyCz4pMSMVBmC8Dd7JBykxFADAfkZMJRa/UUCPRG7/K09TMh1P6E7ZhLD6ce1KFMLC7YcjsACix3rwx1R6Nnu2ztUh1oepJYhptt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hySNSgOG; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwPvxsrv/bAxbQEnFjUeRz1ytgyaTumvNNt0Up8eclE+ld99/w1xW9YjOpT2CGoEOT9pQLECeQtZmKTM+TQEnBsmx2lAo9ILTsYhHae2er1WFc8Bb7VL2wDpO6gv3cZYgPsDrUBm/BPXRRJ0FtNw8L8SflJl0Dy8bxPZZlcjMKzH6O/V/GSbB2d5BwuH53+hJPk3rhRIKUzLNNFG1jHATGEa3YDSAn4l33Jycjt2nFESYY9Hytaw03/az9VlRws6ESE7Se8pCUW7yL+CA7TfgQ1L/v+HDMreUkMS33szgfvog2jN+97U43EYSha5gv3P/GhXOBfZ5H+jI+lpBY7hjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWblZzhu1jMVIt/0BcmMgtWrqDFoysatFDFx2GP/rt8=;
 b=kfLpFKE2SenldxHDOKz0rS1tVBWMpR7iTa6kmJi8Mu89f/AMYwECMvIO2R83PJmNSq9FPew55NGkYwfTgVAuGNSFbXZ9CzcRZ1jTWt2u7hwnNNUEDSsccoxVS7pli8ZkIKvcYYoVBvDRSWS6Q0/I9kOftQr4sux9QevlMyhEsmgBUTxOZR6XaiU2SNbrUuUaTQ5IkVNOeKqyqeSIbxYrHUu4FW3jMOv5pUTEwv4RjudgNComAzW4SbozEN8NLXszxrYV6ZTuHhEdb/0wN53OwHL8EOnCAS7F+yj9+OXc3s9RpTTe1LZ0N24ix/UqfC0DeF5j+GPgVr38IrUGslccwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWblZzhu1jMVIt/0BcmMgtWrqDFoysatFDFx2GP/rt8=;
 b=hySNSgOGzVsV1f4Y/viAUp56YRCP7ec3lWFNloH/oNENfZ2aXatKhk1r3qdIKg0u4y0BiScg2mBP2Jlv/p/ITFdeCb+Q4+LFZ7MYvXnkVnax61Xw5LVuGFve+5+1KN+O9Ky8D45sdMVE89A2r0O0Lf7RhqV3pe0e99JFmvsprKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 09:25:42 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 09:25:42 +0000
Message-ID: <32d21c7a-9714-4f53-ad77-22ab81152455@amd.com>
Date: Mon, 24 Feb 2025 14:55:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/19] cpufreq/amd-pstate: Drop
 amd_pstate_epp_cpu_offline()
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-20-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250219210302.442954-20-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0b0336-846a-4b45-fe1a-08dd54b535cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1FocXNnUU1XSVZmMlFaWFVuMEhpMlVFZDhxeDRXM1ZzczZFN1kraGNhcXNF?=
 =?utf-8?B?cXprNmxsUzdxN0h4MjFnbnNiRnhuQmVqNVVhckpWVHg1VVMvR2JMcG4rajMy?=
 =?utf-8?B?VjQwMnFlcndIVENKZXVpUUtBNmxZUkp0RzRQME5yYW1wZzBNZ3EyMVBlQjdi?=
 =?utf-8?B?SVl4RjBaY01FREtFbXA3NlVlcmZzU3hUVXNLZHFPWEhsYk40NXRTT0d4NFFI?=
 =?utf-8?B?Sk5GTW5SL3BHUHZVL09JK3J6NS9ucFY5VW9RUjY5S3lvdHg1YmxxdlJPVzBS?=
 =?utf-8?B?RzlEY01CcUlkbkZFVWYyOVZWRFlSaUtQQkxQR2RkdzRuY1M4bVlnclE3Z3Zt?=
 =?utf-8?B?aWF3NDY4d2p4Z0puZENvWXlNdUdmZmxWczdlSmd4WmpsektXbEtISEV5MEJF?=
 =?utf-8?B?WUxwUGpmaDVocktGc3o0bGVDd3dJKzlWZm9DV1B5VGUwVzgweThUVEwvYXhR?=
 =?utf-8?B?cVBXdkNKREkzRGZvNTFkekJEUTZ5RW5GWm5zSUorV0JDdmhYK2NpQ3pQUDh3?=
 =?utf-8?B?aSswcitFTVExVlRXR1BZVmZxc2ROL3lGTzBLUnI2V1lMNHF6eEZNbXhFZWFS?=
 =?utf-8?B?KzBtL0hMN2Q4V0xFeTduUWNZYzhaUzVWOFlRcFRSN3pyZnJuZG9ieHZ3RFBM?=
 =?utf-8?B?RVV6QXJxZm5OMWptQVNZdVNseTRmc1RJcFkrMzhjcU9NcndQcGlRMWViUTVj?=
 =?utf-8?B?OHhNNlhmeVEzaUQxTGZVT1kyMEptdjRXSGhrTUVDYjdUR0hjQzRWK1FSM1Zw?=
 =?utf-8?B?c01ZWVJNTDg5dnh4V24xc0lYRzlzNUdVVW0zKzYrN29MTlFvUVovN0FoeUtO?=
 =?utf-8?B?eWFxTnFDdFJyc1dLRzA5ODU2V1gydFZweW04akR2RU1ubVJJK3RSQ0FRWXRs?=
 =?utf-8?B?aUtZYnBqZUpJQjZXTlNMdlRDVXEzbkRtbW9kMzU5dmcwWi9NQWZpRGlPek9o?=
 =?utf-8?B?WitOVGNPVFVDdG9xQkNLcitDVCsrQlNiSUV2TWtiVmNFQmRCOU5iK3padmpn?=
 =?utf-8?B?Z2xXbUhnUUg2YWEyYWxqQ0hlNlhxM2NtcldBdEpBRlQzblhsOFBOTzJsR2VP?=
 =?utf-8?B?Yk01Y3hESEdnNjM4WlIwY2pSemk5TWJ2WnFZSThTQUkxMHFwTlpkVWhRN3FU?=
 =?utf-8?B?TW5LNUVtTkJYRVlxZ0R5NGkzY3lOUWQ1WXh5SUNEdWwxalJKSGFwajRqeSs5?=
 =?utf-8?B?UkJDY2lvZmkvbk94NVQwcWk3T05idk1BOFJtdlpPNTFYU3kvMzJrT1k2UU55?=
 =?utf-8?B?a3RVUHBqWU9mM3FqVWVzenlFMTBLbzFkWklBV2xhK0haay9ySXRSN2gxbVlX?=
 =?utf-8?B?QmgrUCswaVRrZGxQSUhCRUdrVjAzNHBRTUNJVXdabWdVbnJPVi92RXJiMmlQ?=
 =?utf-8?B?azdDdGUzYlFPQ29sY0Z5MC95VkcxemVLY0F2cTdRclBMSmZmNGZROU1QTEJC?=
 =?utf-8?B?SVB6YllReHorVnFQakdkdlBCYmlDUGpyUSt0dUd0NzFOcTdTbnM3K1g3L2tu?=
 =?utf-8?B?eEx4Q3R6a1V0Z0pvMThkY0lNNml4SFc5NjdMTW5iQVp6UU9mcWFQVDF2MTZ3?=
 =?utf-8?B?T2tSU2h6YVhieThpWHBSWEttdXBLNnFIWVVlUlFVbmducFFBL3R0K0pJa1pu?=
 =?utf-8?B?czh6ejA5WW5kL2hlMVVjR2cyRE03ZURib2dxOHVRQXVOTmJxc2hnTnJrVG5l?=
 =?utf-8?B?OEpjc01CSTBrRUU4cFJHTVdhTW9KZzNJcTl6VjRBTGl0RENrcGNZT0piUktY?=
 =?utf-8?B?eExLU0xXZGdlWGxBb2lnaDE0VmxtcjdVSjB4ZjBQWDY2SEk0eW8wMGlzSG5q?=
 =?utf-8?B?TGN3ZXA5TEsyVlZUSXpZYjUrUjBEZnNsYnl1c21SWmRVeU1mNXdIRzN5aG9m?=
 =?utf-8?Q?kdW4fHdlF4NhQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWcvWVo2c21QV0doOVRwdFRVZTJFek8zK1BWNjNrUHpqZi9kUlNxVEdWZnBh?=
 =?utf-8?B?WDMzRUhtd1ZpRGZ4Rk5QQ0JFQ25BdXVhb0RRTmw2QkpTUUFCYXNNQ3g4Ykwy?=
 =?utf-8?B?VjhPdWJtaW9jRUlpQmpiTS9BQVhFL091SCtsK0ZieTR1bDF1ak55Y0hzeDFh?=
 =?utf-8?B?c2NZcm9MbFJPZFpMKzNhaDBESzZTemxtT084WTBURmNFVkQyUVFiSVZ0T0RB?=
 =?utf-8?B?alpTTisxSkJkOTlKdXpreFlUUW5yNmoxam9aOVRscmt6WFJEZGlLelE0bzM5?=
 =?utf-8?B?aTJ0eUt0K05yZFUvQld6TFZGTm11MlJxeFh4UytkUlRtUmJFWUx5YUdMb2tx?=
 =?utf-8?B?dzZSNDlkVm5ZTXJSTEJ1Rm9VaUpRR1UwMWh3RzFMN2JCd1dyaGNZM0xyczVK?=
 =?utf-8?B?UkM4ZlEweXJBekxKTWI4L3ZlZ3dKZUx4MUhnU0xoN21CVkJPV29FeUkvVTY1?=
 =?utf-8?B?ZFZFMGYyYVhUWTV0KzRoa2xQdWN6RHpEY1VWMDhFV0RiUnIzQXJRYUVMYTZ1?=
 =?utf-8?B?TGhqcE9nMWNIbDVuL0xaRFR1UjRCWUtidmRkNGlldTRCcThHRUJLNkF4WXRZ?=
 =?utf-8?B?RkMzQU96UmVSVlBiTHlCR0FYd3RIM3hGWUpKUVJxREdGYzllYVd3UVc4ZVdO?=
 =?utf-8?B?NGRxZlp1TWpXZ0NLYWU0MGNXTHJ2N2FCQXJ2NDNYSVQ3YmdYNkhpNTBJYzh5?=
 =?utf-8?B?aGxjUW1rbGw4Z3JBU09CditlWG5ZZWp0SVRZQ3dVUnh3aER0Qkt6NlExTXJO?=
 =?utf-8?B?UDZ0UnBZdWt6WnIzYlJiTEZMMTAwMktTTUpGdlp2U0xRbmlQcUp5blo0dENS?=
 =?utf-8?B?aitxTlZKa1F6VGltTEpxNXkxRkpiSTBqSkVyL3pqZmQrR3lYbENHT2ZlN2pi?=
 =?utf-8?B?YmV3clZseGtlVjAvcWNoR09yWEVsNUpPbW4vNC94Mm1xUWdIWjhyT0JZdjg0?=
 =?utf-8?B?Z0l6dGZHYkQ5Q2pjMlJKa3FpTXB2ZzlQZW1EVGdXRkk3K2pSM2IwQkFDcHMy?=
 =?utf-8?B?N2V2bml6Tno1KzlzNnpyQXNxZ3NnbjlnZXYrUnVPazVueHlkYkpLdGpZV0N0?=
 =?utf-8?B?RC9iaXByZjJ0NXhGUWUrMnNrTFFuYjBsdVppNXRsaGZIQzlldTV4cldyT0VB?=
 =?utf-8?B?YVhQdkl5Vm4vRUJ1WmRIRnhNK0FpSjlMR3JtREVZUStWd1l0UGxFTitlNFRm?=
 =?utf-8?B?U1NKbTNOdW1OWmFKSytWZ0M4YW5UR3RkWHRScmFwc2xBRDdsRmVVY29yM2NE?=
 =?utf-8?B?SVBHM2MzcWZqWEV1WEJrNzRjcWVLT1lJMisvTmM5QWdWTnhGTDJJN2VYQ09n?=
 =?utf-8?B?VFFQWHRBdFliV3JKanJhNE1saWlZcWgxallBZFVBUzVXOEQyYXYyT0RaNEMy?=
 =?utf-8?B?T1FSbXhHK053NzF4Q2NOSm84aGlCR2diNUdkRHc1blVGLzd5QkhFaTNSRVRh?=
 =?utf-8?B?SDVqZENzbWpJRjRmZm9FbmJLa1hJTGVhRUZpK2RRQUlKSEFpN05lalJGSW1R?=
 =?utf-8?B?cjlZTlBtT2pEYTlrQmd6WjgyV2VtKzVSOWNOaE1uRnp3eFg2Yjh1bGg0RmVx?=
 =?utf-8?B?elduYVh6RnVGZWNKVVRZdDVqZE9ucjA0SVNwR1JxdWxKeTc5VUxuS1I3MjVO?=
 =?utf-8?B?N29UanpydGtDKzJsY2ZSRlVpUC9PdVg0c3VXNndybDE2a0pSOGRYNnJEN3dv?=
 =?utf-8?B?L1I2SXcxdDNtNFdPbG9WdTF3OTl6MTRaL2MzNEV0Z3hjYmVISnNNYjBBVFU4?=
 =?utf-8?B?em9KNkg5V2Z3Q0tHVE5GWGlxRVNsUmZzSjFGSitMNWFJWFJkc1dMRlVBdktk?=
 =?utf-8?B?UHBBNFJDREFlbE1HaUlwT2FLVDQ0c3d5SWtJL250U2prVjZuaUlCWmtzaWhx?=
 =?utf-8?B?V2hFMVFPbUhYYlVJVDY2RXRkNTRjak5JRjk2N2ZwWGZYT1REVEowM04xTEh6?=
 =?utf-8?B?L0k4WmdzYll1d1I5bEtSY3JXZDU2SkhrQkppaEFYMnY4dVhkU1JhTTZRTzVN?=
 =?utf-8?B?UlRwenhnY2FaSnpUYXpZSWhScHFodEZsNFl1c05vM3ZRT3pmWUIveGh1ZGk3?=
 =?utf-8?B?QUo4UU1TSmtEeTArWWZvV1hJMC9QMWFZOGJuTXNXSGZMR2pveWk1MnVNd1Fj?=
 =?utf-8?Q?OMe8YFU5hDRxK9ZjXYRDHqcnO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0b0336-846a-4b45-fe1a-08dd54b535cb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 09:25:42.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eFC9agcHbnkTgPVmQ6UT+IZ9YCW6litlo60luE5DQEgUBueeadFNGgfXRO0t+zrM8NgbQ1Vj95OMbtIHJ2zPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

On 2/20/2025 2:33 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When the CPU goes offline there is no need to change the CPPC request
> because the CPU will go into the deepest C-state it supports already.> 
> Actually changing the CPPC request when it goes offline messes up the
> cached values and can lead to the wrong values being restored when
> it comes back.
> 
> Instead if the CPU comes back online let amd_pstate_epp_set_policy()
> restore it to expected values.

Small suggestion below, apart from that LGTM

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 408e63aff377a..5068778c1542a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1610,14 +1610,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	union perf_cached perf = READ_ONCE(cpudata->perf);
> -
> -	if (cpudata->suspended)
> -		return 0;
> -
> -	return amd_pstate_update_perf(policy, perf.lowest_perf, 0, perf.lowest_perf,
> -				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
> +	return 0;

Instead of making it an empty "return 0" function, can we remove this 
callback altogether? Didnt check if there are any constraints against 
removing it.

>  }
>  
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)


