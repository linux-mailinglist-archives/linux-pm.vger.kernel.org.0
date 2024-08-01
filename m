Return-Path: <linux-pm+bounces-11788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8B9441F5
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 05:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1EDB22736
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 03:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B5F13D60D;
	Thu,  1 Aug 2024 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xH9GZXBn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EC13CF9F;
	Thu,  1 Aug 2024 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483595; cv=fail; b=DTChkKLYpxyX/wQIeTHnjiVDU+2fvRRmqMlf5FCyo16dgBMsbG4FCSxma8JBV7o4h73efSRU+lqD/6rb0Sf9KuoC+O53SBzWIM41tvLsX4bbDO8xREW/TyX58XCJA4c2JmHs17JPPoFOhSYk8PDwfhOShtTmOXmxBKsClQ2ZrC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483595; c=relaxed/simple;
	bh=PTT9b0Js+OurcCl1uyUipfITHO7maEjW+yrZXVAS+Ek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QeqjessfK7/uS5smSQ2anY1/BmeVOmuz2hS+zBtKSoKxIIzAq8ZzEtkY1Z4CBL2JLYZrFzv84Ojs+v+VZsdcE1swUpJObApFfcZHO5llssmQTSDFbotG5XXh5P+rgyskBHoqGIIj0GJQk9zAgbcN+Lo4yYx1DXojQiowX4qdEMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xH9GZXBn; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O85kb1vsJ+2JneH8/H1YRGq7GADHxa5DVQUWcOaJ+gkUE/i7LoaiiP2tntVvOrpX5JFlzpzWB7+Ur9D7NF8sZ1QAS4aXpGJLJWAoZ///dmhP1WsUO1/w+eveyWhqD7WN9xtiFOhpFVAxWRYnetvny2m15jYETcZoHLhAPyE5z9ew3B5JJ8IaRIbFhsBIIX3Aa+fCrWtH5G3bV31uZHMNo+tvmTee0g1v+Vf99+9mkfE/0vdPq3HxO93E5819Wwxb33FZ9FfJsFke8gntQa05OyTf1YDQtLEVUV5AA1AQLbn3z3gFyTIuutcJqnu6nTf1niCdoX4YR+jvBak7fCm44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=842I3AgvUB75sKMikQGoPsDxzFNDAmPqdG75SHmh0T8=;
 b=RQKhF4gtODdpNBsPxeG5zJjp4WC+Qw+7Payu+neu4XTYewwFs3EX44tKGXzn6RGsk1LexJaRTVAu5RqVS3J3aCz6EPq/5wTyc4VJQKgZpgF9RchUHviMgKbLIXaUruNiUxVnLz4o0qTVajY1q6lvjmk5QtDANtvIU62/k3tEm3mucjjdFDpbnARxRvKryv6PjQAZpEO/Rg26dWhNEbj0MTylecqOyNDk6FfP7fu7V0VY4zBt8eXNTTY4om9zeusjXbkQoJdBZYcgcFOArrxy+a14LkEIF3ub9RiYpLeFwwKejM625SyIejI2Dano9sbUCE3oq3v44wGkNrrGh/7QHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=842I3AgvUB75sKMikQGoPsDxzFNDAmPqdG75SHmh0T8=;
 b=xH9GZXBnjOW6hjG8otakL42/T+ZujtGhOj6UCrk7FWqj//d36XmtupmT/CiZi37wsUELZIUMt/wKS1bSmo+hDmb6zZDh/jBBn1wHijHKZ+UNGkjI4Ih1h+xYvTfe9kGhFymjWNc6DwDtvg8cGP2Jhthbyz2pO/1T1XMZ4VCvOZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 03:39:51 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 03:39:51 +0000
Message-ID: <fc065191-509c-43e2-ac44-e2f74d26b18b@amd.com>
Date: Thu, 1 Aug 2024 09:09:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
To: "Yuan, Perry" <Perry.Yuan@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <20240731083200.169985-1-Dhananjay.Ugwekar@amd.com>
 <cda28ad6-43a7-49f8-bf40-980486d9e17e@amd.com>
 <CYYPR12MB8655553BA7F283D787981B929CB22@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CYYPR12MB8655553BA7F283D787981B929CB22@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::18) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6e813c-d3a0-43d6-b631-08dcb1db9967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTBTOWtBcEE2eHA4U0M2RmdhYmJSQXVac2NyVTdHcXRxRWFVUDlzU2V1TU5D?=
 =?utf-8?B?djVhS3NyNjJQalh1VDEwZEJWditnYk5aWVRDUmJqQ05QdXowbWFuRm9vRFRq?=
 =?utf-8?B?dXJLUENjczAvKzg3dFpLd1JUaTh1RXU0UytLdFREK3BEVzQ2bE9jd0ZBMlBr?=
 =?utf-8?B?VFhWSjVNbmJvN000VlltajQ0MnlDc2RtcnhaTzNKaHFwQnJxN0FXNVdMRUhI?=
 =?utf-8?B?MkVTZ2JXeXdUOTcwalpOL3lHek50c0NlWFh5NVJKdGZ0bHR2NHNFQ0Z3aG10?=
 =?utf-8?B?ZDNkczVmc1d5WWhFbkM4ZlE0MGtrUkRVdi9hRWMzMFQ4MG1BYTA1KzdlM3RN?=
 =?utf-8?B?ZDRqV3JCd1RjMllwc3VNTDF4REV0L2Q5UXBJOWpwM3RWQXVHVkhmbm5OWjBu?=
 =?utf-8?B?TDJ6N1F1YkpWS1YyS3lLNGdYSitneFhuMzZJMFlZdFlWaFNpODUyWkdKMU9t?=
 =?utf-8?B?b0tYdHl4MGZ6SVZxL0FmUjB5bWJZbENPRFJObWxMcmh1MkNiTFBJZ2k1cm1O?=
 =?utf-8?B?LzlTUnd2VGFVSlBVbTQ2dHF4TUNvakRDL2J1ZkFmQTRwRlNudks2cWFpWjRo?=
 =?utf-8?B?c3JiQmgwQ1BsWnVvektxUnBpVTBFTUd3RVk4VXdZYk5EU1FpS05xQnhBcU5a?=
 =?utf-8?B?bHVvek1iK3ZXR0JsM281dHRLVzRzZitmTzlNak8rN09hMm0vOTVHY3VEMkp5?=
 =?utf-8?B?ZzhLYUwybnIyU3JPRXhxMnIrTktIRE9jS3RkdDBCclFpYXRCaXdUZ20zMDlQ?=
 =?utf-8?B?aXF3SjM2WTN3NDFsMWFvdG5PczdaMXFrVmNrWG9iY25LaTZKc3JKL3NvaEZs?=
 =?utf-8?B?Q2RESEZXVlk5RXF4RXdhWXR2N1BZRm9kcWNWT09RaHJua1BuS01hUmpYZmRw?=
 =?utf-8?B?UXZRZTRFRHVtdi9BaEtGYVhBcm1nUldnTmx1OHlWclVsVEdWeVlaZ05LYmMw?=
 =?utf-8?B?RUdkR1JkNVk0Y2JUVXkydEpud0hQNVZlRlZYak13clRvNkdTbHNISVM1dmRH?=
 =?utf-8?B?aDJSbkRXemlnRnRVQ28rZW4xSDF6MTZHMkVzNVQ0ajE4ZGlrV1B5K0J6ZlEy?=
 =?utf-8?B?Ym5sRmFSRnJsRWovUzdnUEhyYm5IZVNJOGRkcEc4VE1Ya1VYOWZJRk9JV3hC?=
 =?utf-8?B?d1ZHMk1EMXVHbUVmOTRpRkh5UENjTWE1M1lsMjVhUFFpTlRudURxWTFNKyt2?=
 =?utf-8?B?bWw2TEoyWlFQWEc4dGNST2U0VEppWWJoSW5NOWlnclJmaXJxaW1oL2pWdHZD?=
 =?utf-8?B?ZGNqVWM3VHdyL0ZodHZ5OWJMUEtueGlQRWJRaFh2MWZ1K25MRkFrK0FKc29R?=
 =?utf-8?B?anhIcVlkTmREUmZPRVV4WEFiY0FpdWhrQktvR2p3SEhFWDBpcER0RVpYWW5l?=
 =?utf-8?B?ellNeXp5b1dnQ2R4TWlJQzA3Rm94WVBhd3FxQkFVTUR3VHJ6bEJxY2JpMDNq?=
 =?utf-8?B?S292QmVubFV4eDhLRmhQTXpTQ1lraElHRGx1eEdJOEFvUy9rR2dwZ1JIcjFa?=
 =?utf-8?B?cHdYbUJuNVd0SEp2QXA1MmkxdU1hcnhnYy9FeW45ZCtJWkxVUmFrSWs5dTJC?=
 =?utf-8?B?M3ZmR3NzSEhjZm5DaFhzNXpJUTMvZFhRSFBVWklKd2k5dFVINFR5UTVGZUdW?=
 =?utf-8?B?THgvMXlYeTNINGZzRWNNT3FKdlZMTmh4cjZqN3U1QUE5N1BqWkJDMmJWK05j?=
 =?utf-8?B?NGhMMDBwZDlCbGFRZWV0R1AvM2VTOS9hdWdKaTl2ZnM3UTl4eDZxZEhUWk41?=
 =?utf-8?B?MFhSb04xL2VvM1FWUTlRS2JrSkFJVmJDT3ZHbkJ3SHJwZ2lYRys1T0ZNZTNs?=
 =?utf-8?B?dGwyQXhBZTl4N2RlQWJvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVpHSmFkdTZBVUVaWXUwR3hrbTFkaGNFRXJ3TXoyNW1tenFlaENNZ1NtMG1C?=
 =?utf-8?B?b0E5WnZVZkU3cE52d0Q2L1ppRmc0WnBhM245cnBqeFFLclpMaWo2R0pTbm0r?=
 =?utf-8?B?dmlGUWZzUXhPQ0I5RHpxKzRyM0FXMit0d3RzaEt1RW9WeFZNK0ZuQ1hzaDVm?=
 =?utf-8?B?MXRwcGJjd1N0UVZ5RjFZRTdnLzV6NHVVanVqMHI3S1RUUENyOE1hczZsaTR0?=
 =?utf-8?B?V0F0M3kyVEd0MC9rNFpsOTVRRUlIRU9TZFFoSEM2NEdWd3FnWE9tVjQrd3VV?=
 =?utf-8?B?OVFrdWNSNHZIS0ZUYmtmQmJVSURQUDk2T3ZOWU1VSkViOEJZeW5JakJVeW9D?=
 =?utf-8?B?OVhrUXZFSVV3V0NSMytUN0I1NitpcHVyeFhzSitiRGE4OS9EemYwSVNmM1lP?=
 =?utf-8?B?MDFwbE9DVXBFOUZrTytkVkRDQkh5UVNSNEFteVFQbVIvTlRCc1ZuNTM4bWZ4?=
 =?utf-8?B?emRmTnZGL055K2hxd2ZkNGNIL1VPbWNDTyswRkQ3WjY4V1JRWWNpWGJNVFJz?=
 =?utf-8?B?Rk5PdXluL0ZrSS9sS3c2RGZZMGhaV0kzK0JJcmE2Mzc2aldsTklkM2VhMTlT?=
 =?utf-8?B?QkFKWWQ0OTduWDBsVTZwZVdtV3dJYXE4MnhUZjZ0UmtYSFB2a0w5ekltVjJr?=
 =?utf-8?B?TElsVjhrNFFWYmNmVlhjQWF4amhwOGY3eVcrYUQ0SXo3djcwRll6RUFXT2Fz?=
 =?utf-8?B?SlY3c3ZTZ2czdTZDdmxZdDZsK1M3bWdWQ3VralM3b1ZkU2J5d0RqVFNjQmx0?=
 =?utf-8?B?QytZSGV1WDEvanJ2MnhwWnZUUjhPRUhWdmJRTnF6MndyOFBRdDJKUG9FL1dT?=
 =?utf-8?B?a2JPSUZRMTBxWXU3U3duSFFJamplZEk4M1B3TE1hbEpnWHQ2NXJlN2U5eklk?=
 =?utf-8?B?YjRLTGlYekJheHBUWDVWVWN2U0ZSVVp5dFpTSXM3NTBhSnVEeFFVZWRzZ1F3?=
 =?utf-8?B?alczb0dXOWcveHExZVcrbHVmL2NaQ2pKQml1Tzkzdi8yMVNIR0taNUd0T1NS?=
 =?utf-8?B?UC9kSUxpa3NGR2FENzZRNW1vQlg5WWorSFN3MFZxOWRqYVAxUnFGc2psejhU?=
 =?utf-8?B?THh5RFAvZ2ZNK3NPZmpiTTJFUFcxbXlHeDI3UWZHdklvR3BwTllxQmhvQlFR?=
 =?utf-8?B?MjBtdTRURzR4SXFYeVIzN082bFhTRVNtTW1VWk1IY0ZPcGVPaFJCVHY3V3V2?=
 =?utf-8?B?cDVWSHQ3Yy9BQmZaYlEyWUpzTVFTeWhVUDZCc2VqTmdOTXRWQXRZaVF0VDhs?=
 =?utf-8?B?OFpKMzhsVklFOXl3TlZPSlBDOHZpWkJZU0M0ZHQrSEVma0ZseElKcXhMMUtU?=
 =?utf-8?B?Z29VUWdnVFl6ZFFtRXN5N3U3RnViNHRob1daTHFJbk91eWhiZkRmSFJTOWVJ?=
 =?utf-8?B?K092STNHUXRmS0hzUDBIZUNNMFVWcGZlT3N0WWhvNGV2VHNaWVFvd0NwREVM?=
 =?utf-8?B?K3ZkUkRrZmxhYnJnekQycXBqUG9QU0JyVmhJQ1dONzB0OFpkUlprbWphVWNR?=
 =?utf-8?B?YzdESTNsVktLSkVkaWw5Z2I5cVpkOGIzaXJsand5MGNkenFvR3FYWUVtdVlw?=
 =?utf-8?B?cXNzalNYOHpiQnNSblIvTVdGalpLTSs2ZXl3UFhNWE51dTIzWTF6NWlTNkwz?=
 =?utf-8?B?d0hzUGQxeGtNMW9hdStEckN2U3RFMnhYYVlTbXFXcXpwczh2N1VHc21YZlJY?=
 =?utf-8?B?amkwQ2hZR0ZxdVM1YVNvNkY5SXliTVR6c0RBdDZPcWZFSXZhRERxTWE0MHpZ?=
 =?utf-8?B?U3BZRFl5VkRjQm5YYzlQWUppRDRZMStWd3ZyN1lCSHJzYXdsUUhTbGNIc2J4?=
 =?utf-8?B?alZPb24yWUJ5UnhjY1NZTVRPVzQ2eXdvOWx0MUcyYnhPOHRTRUNUTzBDYWNz?=
 =?utf-8?B?V3VUc2R5RDk5WGYwSCtZRXFIMDdkWG12K3VaT0Fqd2JaSjQyeGZUbDJVUU5N?=
 =?utf-8?B?ZXFubytMMFBhNUVPQm43TUUxeHhLaDltRHNpdVg2bnI2b1o4VjZ4K0VzNU1B?=
 =?utf-8?B?NXBiUFhtbzhEZC9uWGRtZFlQQlVROEh0WWNUSHBzZWl0RXpzR3ZiR2FaUDNl?=
 =?utf-8?B?UkJGeWROcFdDYk9IWFV0dEhvazdpMGtvaTJkWmtEVkkxZHB1Y29UQWh3OGlE?=
 =?utf-8?Q?U62BWwfZvAHjNMTEQ34IlCqNa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6e813c-d3a0-43d6-b631-08dcb1db9967
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 03:39:51.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnT2ZlOcyzdehOkcS9V+PloIzVyHAgjhUAq9+CFN+gsA3N5vzAlZDR38Iy0g026KOBUgkZGUvs+vC1qxPg9ghg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962



On 8/1/2024 8:43 AM, Yuan, Perry wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Dhananjay
> 
>> -----Original Message-----
>> From: Ugwekar, Dhananjay <Dhananjay.Ugwekar@amd.com>
>> Sent: Wednesday, July 31, 2024 4:39 PM
>> To: Huang, Ray <Ray.Huang@amd.com>; Shenoy, Gautham Ranjal
>> <gautham.shenoy@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>;
>> rafael@kernel.org; viresh.kumar@linaro.org
>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
>>
>> Forgot the fixes tag,
>>
>> On 7/31/2024 2:02 PM, Dhananjay Ugwekar wrote:
>>> Fix the reference counting of cpufreq_policy object in
>>> amd_pstate_update() function by adding the missing cpufreq_cpu_put().
>>>
>>
>> Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current
>> frequency value")
>>
>> Thanks,
>> Dhananjay
>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>> ---
>>>  drivers/cpufreq/amd-pstate.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c
>>> b/drivers/cpufreq/amd-pstate.c index 804fab4ebb26..36edae40db1a
>> 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -560,6 +560,8 @@ static void amd_pstate_update(struct amd_cpudata
>>> *cpudata, u32 min_perf,
>>>
>>>     amd_pstate_update_perf(cpudata, min_perf, des_perf,
>>>                            max_perf, fast_switch);
>>> +
>>> +   cpufreq_cpu_put(policy);
>>>  }
>>>
>>>  static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> 
> Thanks for the fix,   it needs to send v2 with the Fixes tag.
> 
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>

Thanks, will send out v2 with fixes and rb tag

Regards,
Dhananjay

> 
> Best Regards.
> 
> Perry.

