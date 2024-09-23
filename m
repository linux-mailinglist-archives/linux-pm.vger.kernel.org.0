Return-Path: <linux-pm+bounces-14589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A7B97EFBD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 19:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1741C2162C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2919F104;
	Mon, 23 Sep 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LG/dneH1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5D19E969;
	Mon, 23 Sep 2024 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111109; cv=fail; b=QCIXqbaP5ppIojBqs/DDUNEPamMvBEUbfeEs8xhOsH77K0Jk285MTXvPyZgyWJ+Rks4qWV2Z+Fdq/e2Eh8yUpqFFLXDs1ygrRG8uswt1Z6VIAwqrbFfDOzLD/uz+0VBxSJWQlzc/vPuzO294JwVwAw7aCnG19H4mv8BzVJQBa04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111109; c=relaxed/simple;
	bh=5UaOZw9DaycBdNdAOmvcV+qln7iUFlYQholp9mOwFiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IsePLkKeRR3ggToQ3+FoxwNqOYvHpJS7cxZbG9QCHxGMNc4PeJC7THxxtmFrXpltZac3Y2LfGPJ/BxuHfBJw/ptwFq/zioqWFg69yPcsH9XgiZX6YRUIlzWnBFBYJkLUIXrrs/oI76GkqYYb9hdFxd8iXqlNs/ygw0rSHRK+c8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LG/dneH1; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmafhUEtTOL9KCxMyA5VzCleNY0wECeBB5trQ6ZbRhSNvCCS0DIPiAg9AOL+m7XCacWeJ7EevZDmArRF+XC28vfD10Y2eyEo5l0ah+/ZMF3ovoOjuL5e3VBhNFHFqDIq7hWWCLx8ckV/XGuy/Wz/FsPpggEeQ3mu6GP//n8FiMzRCwXoBySD3ygHX5dfbxPHka5LrLuYfYwqTwCij86PqFZ62qTk84GW+Yq9I4+TQW1fJ5t2venzX/eG4Djl4IGX+aQY3qjOvzcxDBUPAWtaXJv0piN8g2TuRhxOgi3JCfcF2TjkZh/gtBHpbjZfM1DK7707GcoIvWgKdLt014Zt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB8Uo2s2FgiFmDmqB0SHuCSSDezAwUae46yB4ceC2W4=;
 b=SnjQh3d0p7XT0SuTh3+mu4MFVYW1TBf3tT2zOIhGhgc11N9z3T1dyVN7arr8PVNAi2VAK+KExmmnQmm7yVBvVgVzNVvcYAOfJHzFKAadbb5OUzaw4i8/IGZKMZmm2dxTCttvctjVCfUVC+zc50arKAkk7YHtp/5ej/uQw6lxvK4Yt+YBaDldOR+MJaApu40csBlwI3qRnlEDs988gjbWHW1RRwxqcRXOfusiwZ9QhphdpEhes2EOPVNa1sMmkPZNMRr55pEp0g77Ua9Mm/AU/9dOsfatShRMdAAmd6tgbElSO682VOIToNqtggP4ksiqa2OYbqQ16lvbiAWltkbtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB8Uo2s2FgiFmDmqB0SHuCSSDezAwUae46yB4ceC2W4=;
 b=LG/dneH1nZ6283Zxa609V42lQJ65KyziVF7Sd+HJ5YFZyCFqfW1qdGJM6kI3QG6SGtmB+zH4sVAk108uzhbMoDfK157CqAsjdK1UDJo7Q28CIO/R/d+r1JrBOZqBDDxhV50zglVX+/2aIBFdr3G+BWae9kkp2++8G7iv8800d18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 17:05:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 17:05:05 +0000
Message-ID: <257cf784-f038-494f-bd45-016172fcd639@amd.com>
Date: Mon, 23 Sep 2024 12:05:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] acpi/x86: s2idle: handle Display On/Off calls
 outside of suspend sequence
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 luke@ljones.dev, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-3-lkml@antheas.dev>
 <1a9b611c-51f0-4c3d-8bc2-62c6b6104fd2@amd.com>
 <CAGwozwFwU=KMgDUmKsYRu323dsuUfQYa8e-aXV3JGGSkgF-RkQ@mail.gmail.com>
 <1eff4036-b785-4737-b919-d67c52efea65@amd.com>
 <CAGwozwHbt8+hVDpyz8GM=Lwg8o=oLZDgCJ9JZN_HRzHLuwuknA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwHbt8+hVDpyz8GM=Lwg8o=oLZDgCJ9JZN_HRzHLuwuknA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 894940b3-b9a0-43c7-63bd-08dcdbf1deab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2tLODJGN2dMdnc2S0dhWmNhd0R2UFJYVVM4a1RRR29qMFphS1Y4SjdmMUJG?=
 =?utf-8?B?VUlrMHJOSTVlZDh6cWFOOERpelRKRE9EL2hZL3R1NUtPaGhMeFBaK1RwR0Rm?=
 =?utf-8?B?Y3FxZktIVmpSWExQbkVtbTluSWFLamU5WGY2Z3FBK21JNjJXNFFRdWV5S0gz?=
 =?utf-8?B?clpPUFZTN1piYTBSVm1VUlArQnV5a3ZhZC9mYng0dW5VZzlYTm1xTUlOWXhz?=
 =?utf-8?B?S1MvVmpRMUN3KzdiWURaWHBLa2svWWJaUldrWGIzNDkyQk4zMGtPU2lKZDBR?=
 =?utf-8?B?c0pZYkhjUk9kdzBzT1ZzZm9LaS9JSmxUK3pFT25aZ2FLSlRqWENHNDlCSlJQ?=
 =?utf-8?B?d2d0TWVLbDVmRHhWeFpZa2xJVmR3OWRFUHcrdXZjNmg3NWVyNElLL1o3elE1?=
 =?utf-8?B?WXYwVWlLYzR4cmdvSk8yUUhtTU1XR3Q5ZzlHS0RJSEQzVE5DSG95R2g3anpz?=
 =?utf-8?B?ZGxSTkVOakNBNzYxcHVDYmRtdVlKd1BDd2ZMZWNPTnNZcEsxb3lJSlNFdEJK?=
 =?utf-8?B?T3M2RENkMExMSElyZlA3TXozTnR4YngvYkZUMTNFT0ozMDFVQ04rVnhpRmdh?=
 =?utf-8?B?ZWQxZGhpZkpGYWJmQ0ZPZFl4TVpHQW01SGJvZDhPWDgzM0FFZ0lrd2VRbEdG?=
 =?utf-8?B?djVwTjR3ZmdobHkxTFpnczVyUU43SGV0WUZ1K09pMXFMMjZaeUxjNjlHY0FN?=
 =?utf-8?B?eTJNYTBMd0JWOHZSTFJnUDRmc01uelRyUDhTaFUyZVByM2p1d3g0V0s0SDZs?=
 =?utf-8?B?SHhZT1lDZkJKUTUrcVpnTnVIZ2dFT0t2RWthZ0I3NEo0bWRqL3JTdXBnLzB1?=
 =?utf-8?B?eWxicHVDN0ZZcXlUb0xMaFYrektzSXhIbW1RdHE5TVJxRTN3TGwvMHFyWlZI?=
 =?utf-8?B?UzhDMS9tOUo4dkNIbytteGlMb1FRSzZEYTByaUlleEpoY05lTHdSVksvV1p4?=
 =?utf-8?B?M2UzQkZpS0hWd0FGbENWa0JTSUh1OWFtWStPVHQ5U0RnbFhQd1VJR2d2SCta?=
 =?utf-8?B?Z08vSnRTa3B4VUNtUUVOU1VKUDlxMU9CQ3NESE8zZFNDcTFIVDF5Y3hWOEdl?=
 =?utf-8?B?RTVPYlF4bzhOOTJ4eHBlTmowR2FaNHpoZy9IOUdXL2FsbWhIMC8yWTRnYjY0?=
 =?utf-8?B?M1dVdWFxWC9DNlkzeS8ybmR4VzRxUzB4cXp3c21tVTFhWjVpbzU1QUpCUDBX?=
 =?utf-8?B?Z0NRWml6Q1pUUG5oRHRKNExvK1p0L095amZXOUFWYjlOenAyc1lpa0ZMSElK?=
 =?utf-8?B?bnVudzVaTG5VUzQ0eTVteFBveHNPZ094cnAvSHBMRTI3dU1zVGlVWEI1SVgr?=
 =?utf-8?B?THkrVjBCeiswN3UzeU9tZStCWEtXcFZIRmhiZWp6NW5oSlpWSkJuY0xPZW04?=
 =?utf-8?B?UDNFRU5NL3NndS81a0ltdlBjOC9ZQmlKRmR3TGsyYjBEWnp1eHFpR3ZVTURO?=
 =?utf-8?B?WUFQWVAzbzJZamFaMk5Lb3c5YzRNSkUvRFBXTndsZytDZ3FvdzFDcFZUNEpZ?=
 =?utf-8?B?am1jMWQ0TVJhcHk3WkVMelliZDZvYS84TkNKU25Ed3lGVXoxN2xWV1B4OXRX?=
 =?utf-8?B?VVJlUUZRWDJIMi9vZ1EzQVB1UEU1TXB5WFFyR0wyTmlZaW13VmxjTTVrb0p6?=
 =?utf-8?B?ZXczRlVGdmF4L0NMQkwwU3BaOEdrVEsyS1NySHFZbC9OTHRxRG8vRUVZcUk0?=
 =?utf-8?B?djdPR3c0WnJkT2hJZGVhOUFjTFpiT2tXMVZKeHVkTk5PTlJuaWxxemRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2RTL2VSaGIyelNoMjJTLzhMN0NtT0pUS1RPa1Q0djZrM2xSbitvcFFEQ2xl?=
 =?utf-8?B?Zk1ZWFV1QUwrVTkyYXd5VWF5WDJSTXQ5UkdBVzFxTlp4RDIwNm1hbUdvS2hM?=
 =?utf-8?B?RW1DVXgvN0VEc2F1TUoxMWhwUitucURyMVFiamtna3oybFV1QWU3WTFJVUU1?=
 =?utf-8?B?SVRqVk0xNzYrSDZjQTQ4WGNmUTR1STZnN3FiWWVMUkVUK0VvV3JDSXQrYU5Z?=
 =?utf-8?B?d1JuUGJUNnFMdEp5TnNFeGZZN1FlbjJ0K01mZUtXNzJvMU5UNU5VMGVKM1ZC?=
 =?utf-8?B?djBONXROcVJnUENLRE9xZXNuNThyOG02V1B0aTd0UCtBWlM1NzFTK3pDUlNx?=
 =?utf-8?B?b1pPT3VBWEczWjFyd281UXVBNSs2ODc3azZwSTFpTk1oSkZzTm1kcUVpOE5S?=
 =?utf-8?B?dWdTU21lWDV2ZlRrZEwzMVhhUDlGcUFOM1RWYUt2a0ppUEdoNmVnN0thVTBC?=
 =?utf-8?B?THhQRHBuZ1lxVi9YQ2Nva1cwMkVsS21OWkNpR3k4U3dsMUZlRHRGSHc1Z0Ey?=
 =?utf-8?B?UUk4cDVsUEo1dFJUUDZiNkdRQjJiTjIwUUZseXVyeVJ2R0prcVdoTWV6cTBR?=
 =?utf-8?B?SzJDSTdJb1kyZWRDT3l0eHBFWk9aNml6b1FsOWYvZ2lXWVNGN2J3Y2Rmditp?=
 =?utf-8?B?VndJektMaVVpM2FLOEZWSGRpUWtMR0phYjVuNGJFZjdQbDVMdHk1TlNjdE9x?=
 =?utf-8?B?cGM5SEJPUkZpa3lxRkw2UmhIUnZOTTdpV1pqL3NhUGxDUnNWMVBvcEYxZ2Q1?=
 =?utf-8?B?K3g3aEFPU1ViaWp1Q245a0xDaUhPWFRFOGozQ2lXK0ZQaThIYmlZVEVVcTJ4?=
 =?utf-8?B?a08zK1RLT0M3TWhTZ21GVStSb3VnMlhuSDZDTDJnbnpFd2Nja0NsMnh0TnZy?=
 =?utf-8?B?clZNMDNlZ3d4eTR4c1Z2ekVSU1hpQ2hQc1NpK2dpckZjWGdtNjIxQVJtNmNL?=
 =?utf-8?B?c0FsRVVDTzVNU0tqcFBUUmlFdCtKSDZVZS9MaVV1THRaUnhwMVBrRHpNMGhv?=
 =?utf-8?B?eTBmUWFKS3NjclJCSVpaZU5hb2pBeEtnS1NMTmhlaG5EdjFTM2xFdTBnU1Nj?=
 =?utf-8?B?cFFhMVdGNXhqZ3ZZaGJVMUhZRjdZWmVXSTFvWHdZK3ZMazUxaDFHcE9rd2dD?=
 =?utf-8?B?QnVha2ZmbDNXMUd6TGUySDBoL2hVQmlwWnF4SUIza0M4dDRnMGs3a2toMUc3?=
 =?utf-8?B?UisvcVROZER3L2ZONkVoMkZ0ckE1RHBieGJWNUluN1ZlblZIWjRneC9vTE9C?=
 =?utf-8?B?dlFkRGJVVVdYNjcyOUhXTXFlamZmWThYZzZlcnBkSzhJQk1iQnhGRytTMGtk?=
 =?utf-8?B?OXhFUUs2L2NVa1VBczhmU3dYVElqd2p0bEV4RFRSanNPMTR2TUVWaU1OQkla?=
 =?utf-8?B?NE00Mm9DaTNoWnZPZkJYRklKam1OUm9ZSENHM0t2MXl0OUhBb2VGeUxaWHJC?=
 =?utf-8?B?OWo5OUpPTGoxK0xYTjcyRWVERjRFODAzSXFvVDc4aVZoZzVLZWVGWlo3QjBq?=
 =?utf-8?B?WCttR1BBUDZiMVlkRmxDalNZdzBmWGFZMmFSR0UxNUduaEFDdCt4c0ZJUDY3?=
 =?utf-8?B?WkFwNzkyakdBVFAzODZhS0o5SFcvQUhPR2VENEk2RDgvdTJEU1ZsT0Q5VzRm?=
 =?utf-8?B?TjJGSmJQSjJJVHhDZW1OS2g3Y05iK0ZKWDc4V3E1NWk3QmtLWi9tWGE4TEVI?=
 =?utf-8?B?eVNhSmZjR09kdUI2U2M4ajBqbDRMbEswcHlkMVppOHlxZ1U4ckdUUmxKTDhL?=
 =?utf-8?B?VzZkaCtoSUw2VHZmc2pZOWV3UGVXTnZPRzd5THBpakhKVUNzY3ltNUR1R2Qr?=
 =?utf-8?B?YmVCVEd4QVhFRmgwOEhvM3dKREFCWS9YSnQ3eEJJd2pVcXhMUHdiZGkwRE5H?=
 =?utf-8?B?SGhVTGZZYVByM2NrWEdTa0FWT0JuUGZ1RlFjcEVLNTIyQkNBQ2gzdE1Tam1Q?=
 =?utf-8?B?REhHT09hczNkbmNoSDcwUFp0Q0daR0ptYjhqdWNPaUQxSWN6NW1uMU5PRmZy?=
 =?utf-8?B?RlVtWHZSNFQ5L1FpR3dMMHdJYmtncGpHQlpTNXhUK0xuRzNEc0NDVHpidkI3?=
 =?utf-8?B?eGVneGdpd2NWdGhnWmhjZ0ZIcUdGTVhHK3llNXR4YkFVWkw2bElmUDh0WEcw?=
 =?utf-8?Q?C97M8+07tpZly0JLj+3z0rYm7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894940b3-b9a0-43c7-63bd-08dcdbf1deab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:05:05.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9lxBkAzPvZY2G8aTiUa4rZSFtvco0dTzqeYsBStfKPrKcQk8+FoVEc+4CkAnBrU6ddeA7n90w13xbER40+QAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863

On 9/23/2024 11:43, Antheas Kapenekakis wrote:
> 
> If it were me, yes, systemd would switch the system to the inactive
> "Screen Off" state 5 seconds after the system displays are off due to
> inactivity. If we are talking about implementing something Modern
> Standby-like, then pressing the powerbutton would no longer suspend
> the device. Instead systemd would use two tiers of activators like
> windows (first tier for "Screen Off", second tier for "Sleep"; right
> now there is only one tier that mirrors screen off) and once all those
> activators are released, suspend the kernel.
> 
> Then it would handle the transition from "Active" to "Screen Off" to
> "Sleep" through a sysfs endpoint, with the platform responding by
> e.g., lowering TDP and using a different fan curve.
> 
> If the kernel is asked to suspend outside of the Sleep state, then it
> does the transitions to reach that state and references the quirk
> table to avoid racing conditions in manufacturer firmware (not with
> the kernel), before it suspends.
> 
>> Important to note; it DOESN'T explicitly turn off displays.  If you
>> configured it to suspend then displays get turned off as part of the
>> kernel suspend sequence (drm_atomic_helper_disable_all).
>>
>> If it is configured to trigger a lockscreen then the compositor will
>> turn off displays after whatever the DPMS configuration is set to.
> 
> The problem with a DRM atomic helper is that we cannot control how it
> is called and do debouncing. WIndows does debouncing (part of that is
> waiting for 5 seconds so that if you move the mouse the call is
> skipped). You could have edge conditions that spam the calls.
> 
> Antheas

I'm not meaning that anything in userspace SHOULD be calling 
`drm_atomic_helper_disable_all`, my point was that this is how it's 
normally called in the suspend sequence.  Folks who work on the 
compositors don't like anyone other than the kernel touching their
configuration at runtime.

I think a lot of what you're looking for is the concept of a systemwide 
"userspace only" suspend sequence.  A lot of devices already support 
runtime PM and will already go into the low power state when not in use. 
  For example USB4 routers you'll see in D3 until you plug something 
into the USB4 port.

IMO your proposal needs to cross at least 3 projects.  Here's my 
thoughts on it.

1) systemd
    * To be able to handle behaviors associates with a dark screen only
      suspend/resume.  I did start a discussion on dark resume some time
      back but it went nowhere. [1]

    * Make sure that all devices have been put into runtime PM.
    * Notify compositor that screens should be turned off.
    * Manage transitions from dark screen to full suspend and vice versa.

2) Kernel
   A. To be able to notify the _DSM at the right time that all CRTCs have
      been turned off).
   B. To be able to notify the _DSM at the right time that at least one
      CRTC is now on.

3) Wayland protocols
    Introduce a new protocol for requesting userspace suspend.
    To notify that dark screen only suspend is being triggered.
4) Compositor use.
    All the popular compositors would need to add support for the new
    protocol.  IE Gamescope, mutter, kwin.

This isn't a trivial effort, there are a lot of people to convince.  I 
think the lowest effort is to start with kernel.  IE having DRM core 
call the _DSM when the CRTCs are off.  If you get that far, you can at 
least get this power saving behavior when DPMS is enacted.  Then you can 
work with systemd and wayland protocol folks.


[1] https://github.com/systemd/systemd/issues/27077

