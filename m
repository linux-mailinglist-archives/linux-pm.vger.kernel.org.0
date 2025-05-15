Return-Path: <linux-pm+bounces-27204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFEAB8E95
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1F31BC703B
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22925B66D;
	Thu, 15 May 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bC9CyJ6e"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB125B675;
	Thu, 15 May 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332659; cv=fail; b=CHW1hILgyZ2ekzGLH2FCM5bGyAw7b8gRCHU1LBR4NwAp7JZ+bm7PCI5VSxBAtzQnye2+h0Dti9lP8bjgQUauX6q83aoLld+Zo1urO/mJydZPMBKLPUs6+qrGiUEONTFvX0piL3zMCvjc2aqZzzSl9qiMnmY1RoP+zHvfjVRRXp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332659; c=relaxed/simple;
	bh=plg7s5eb3kBWP7ae3dmi8ld9yXdRcaM3AEOA0EqlJd4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CGsnab4hRJ1x8C4UJe28kwOLK8/ThFDyApaWvyM6I15NINN82qCkA0hjBhkGJ00bwaUlvJtT27wtkIY9OWBlekex7bU4zmNt+yIwzkQkq85gJmjuaTXRoIWrr4D0tuIjlajVFGwJqjibGDBJLXqGIDPTNk3T57ZF0xYGpzjN1sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bC9CyJ6e; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbHKl4UnaiJY5QA/tLU+GBeg2xPgxsiFqmkZ8Q9jNUyVTlj2QaTzW6Sjuy+4PnzhsdPxnZQBiq4Q8vXnjHLXaiCKeWBXG08uMweEGMkGUt+9gnaazAxVn9By6BtZnw0UwxSb6Sumb8S/daeQV4tcSITROd74ikzerZHwV/HJT5H9BS3g2Z+tnKWjwM2TYrTvP01opvSUbhFsSB5VpW3QXUuv4vXcjL+siloICJjx/lJylWsRlvKYEMI/AgBsSZUGjwbgue/WcxFk8KItSUQCtkUeGIMapBH0onypWDienXwaYhTjRUgdWZTbBim/hqnvHVZSilPyPNqFHmJIw32Kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymqCGl9odM4VMA/g2fp4K7PzfFqOPjqcAhQzPh5ZdZ4=;
 b=cWbm0LRPhQpqSED/8DeOPBdnu2jlYwPRuwyPCqqtoekMl160z365sjN0wQl6gWvIgUIA+aTDNMl+SDgvtum2TAoRByl3tlYs+bi4mC2e/cwt9/YDnl5Cf8CVsIMfbjzaB6rxxdHbVCf5ZJfswV1apW1W2RaHdl9/Y5DwPDriiPDrHPhZP/If0ipLU9GJBRMt3Och8F64yeK8RU/Zq9PkHZMEKB9R2b61+AWDowrBzZJOMuRKWt2dTXMMfAFci0bxVQMPURIvkCDumoa7JHS5NOSEgmPrq0IL0jER0aiNg1MX50cgzTlh8/AW4y/GjtgLaEwt69SVFbumETdmzLh1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymqCGl9odM4VMA/g2fp4K7PzfFqOPjqcAhQzPh5ZdZ4=;
 b=bC9CyJ6eNsuj4phCBIyHtGCP5erOzMImURHznbUAYH8FzoFOpNYPKUYww00WZDeYWfyGGED2+fAUujmhQuC7ccq9mgjQ/vWE1MVjgXRnRBsKby7Z1AusVcs1sjlAPttoEQvEU6vL+YtV6UZFuUHVJtHmCPCt6k30jSTMkME4k88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 18:10:55 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:10:55 +0000
Message-ID: <f8a09f92-40ff-40e2-a39d-81b195d541b3@amd.com>
Date: Thu, 15 May 2025 23:40:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/4] x86/mm: pgtable: Fix W=1 build kernel-doc
 warnings
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, rafael@kernel.org, pavel@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, sohil.mehta@intel.com, rui.zhang@intel.com,
 yuntao.wang@linux.dev, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterx@redhat.com, sandipan.das@amd.com, ak@linux.intel.com,
 rostedt@goodmis.org
References: <20250514062637.3287779-1-shivankg@amd.com>
 <aCRMT0TlpFvpRGYk@gmail.com> <6c4b227e-abdd-4e7f-8abd-d85cae0f0ec3@amd.com>
 <aCRgRxmO6rsR-0k3@gmail.com> <c5ad88e9-434a-4399-8e21-3c41e9295e93@amd.com>
 <aCWPp4wYwauSuTed@gmail.com> <eddc986d-62be-425c-8065-3cd5a3922026@amd.com>
 <aCYC2pYpXeYVlxA1@gmail.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aCYC2pYpXeYVlxA1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 466a50fd-0a93-49e9-9ed9-08dd93dbd57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGVBdWtxeEs1TjRvY2tObTdyZHJUdUNJR1RENDNBbVRlUUpMNlVrUVowRG5F?=
 =?utf-8?B?MFlWN2NzQnVzK0F5cGVvTjlUOXQ2ZEVHVEVmK0l6MUhjQjBlMG4wTHM0Y0Q3?=
 =?utf-8?B?T00wdnB0K3FrczNqZ05Xa1RuNU1IQTRIUmVCbGVqZGVzRVhBVVZHT2ZCZGh3?=
 =?utf-8?B?L0FNQ0pSUmN5K0RvMXBwcGhralZldXRnZG1mWUhUQVV2dDVwWUVnaU9YQk1m?=
 =?utf-8?B?OVpockV5d3hYRzVOQWJmYXRtVGtmOFZBUFdrQWRHWVFMUEhlVzh5UDJ5VDFo?=
 =?utf-8?B?aHlzWlJRQlBoSjZ5MElXUHczODMvRTRadEdCaWdydVRHUEhsTFV5b1I5QmVz?=
 =?utf-8?B?K0t2aUJOUGI4RW83VUZlZW9iVExwc0pubkxkeEFNS2VvekM3bk5obURNdHl4?=
 =?utf-8?B?eGNodlhkMDkvcldyWVZhR0JrQXNmaDZzME83dnorQU16aXZEeUFGTE5JOXEv?=
 =?utf-8?B?bE5ETGxWVFhsZjB5SklvV1pRNG5aWGo5RTRiYVNOc3NZdGxpWW0wcVplYkwx?=
 =?utf-8?B?S2VRQitwZG1xTUpMMEpTUnozcDFyWTVXUHdCMWRNYjVFOUpEeFlYMW9nQ3lB?=
 =?utf-8?B?WDZCeWZZanNYUTJjNEVXREJuRmRBOVU2bkQ2Ty95ZHJkazdhMGlsUTd6Q2ND?=
 =?utf-8?B?bTdUQTlWSDVjZHBBRFhRTXE0eFc3RnRtekRiaXR3ckFKb2l6UXVVM2cvK3pv?=
 =?utf-8?B?NE5IdEJURFpkZ0RucERlcm8zV0lKQXpnbUxlUmhSQnJCRkxVWndTcW9LcDVa?=
 =?utf-8?B?aS83dXNiekpYTFMrMC9QTUsrSHRHUHhWYWs4TXdrTTV6dUllV0JrYUhNY1RT?=
 =?utf-8?B?RkR2dHgveWV6S2kzaE1TaWdTeEFyb0kvcHJxU2VwWG9kMTJLMEZiZEJINlpl?=
 =?utf-8?B?QU84UythSHZUbmQ3ZTk0YXExQmVNYjJDd2l2RFloSFl3SzhEY3lUMlc5Tng5?=
 =?utf-8?B?SndqcE9DSlFvRnc0RDFYSFdrREszVG4raFJ1STJ1VHhkU3RVZm1Fd3pIaUdh?=
 =?utf-8?B?MXNoNEpjb3NsNlpiMm1KM255YTdTK2dLblo3am9PNytiUGV5dENFYWs2dFZU?=
 =?utf-8?B?bXkzQ3psTzlGdlJqL0ZnRzVheHI2a0lad2N2UGtWaHprRjRuOFlBMGNLZnRw?=
 =?utf-8?B?MVNpWVhVcEV5MVMwNzhDTnpYUVp1VG9IM3VCdWlmUFFXaDFqQ3h3TnVhWlpp?=
 =?utf-8?B?bTZFYjA1eGwzOWtqV210di9EYk9zV3RqSVpUTnVZU3dDSXc4WVBGUXBCWFM4?=
 =?utf-8?B?T09BM3ZlQ0piVDZibEgxWUxPYUpEUnoxSEdVNzlpQkI4dzhqNGFDSGZIZEM0?=
 =?utf-8?B?UUx1VXN0YWtvOTdZN0sxOWVEOGR2Mnk0K1FabEd1ZzZsWXlBTC85T3JLUDZq?=
 =?utf-8?B?aEcxSlRjM3A3TXFqRWh1cnRNVHBhUEsrM2JUUDIxUEN4M2hZQ050WnlLV29P?=
 =?utf-8?B?VGhYM1VoVnFRNVVxdzIxOWZ1V3FTbWRuUnRqUjUrSTk1cnk1dUs5WVNQZ3Ry?=
 =?utf-8?B?QkZuZTBpZm9oenVGNit0S2FJZGpNcGpRQnRHTE9hZ1Z0Nmk3SUVjOFhjeGdZ?=
 =?utf-8?B?WlA0ai9HQThsZ2twQ09leVc5bXNsVUtrUERVd2VtQk5PUkcrWnltczVkcGt0?=
 =?utf-8?B?ZVFTZ1RzdFU5YlVrejFNeGUrdXpXbGNqRndHdzF5ZmN5ZlFWd05wYytwOSt2?=
 =?utf-8?B?S29GMFlPbHdJajR3YUdDOFdXZ1luUThDa2tQay9lSzY3OE5FbkVGd3paKzl0?=
 =?utf-8?B?NmR3SG9jZytLR2p3MXgyeDBaTDRPQzR4NG0wNHdGSjVCMk91eXNaU2w5c3NE?=
 =?utf-8?B?L2FQdzFPRkE1ZG5FdHhReDB3bytnQUhHN05ETXlOd2w2NkVoL2h1b2ZQODRZ?=
 =?utf-8?B?eUJCemE5Q2dRUTNrR3RGdEtkQkZDRTgzQXErd1h4UTYxd2lHQmVyVVhDaFU3?=
 =?utf-8?Q?MPpuDaWjSCo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUk0SGVEcW4rYndnaitaYk9LVHJOZ292djZseklzM3IvK1k4eDhuV3Y5NWpy?=
 =?utf-8?B?cE5RVlR1cTYrMmEzME13akFUM3E3MEZ6SnZadXNhLzY5NTN3NHF0bnB1RFNN?=
 =?utf-8?B?S2R0dlVhRlhrSU5WaDF1Q1hRUm5wanZ4eERKMitSM0pqQVd6UkRWZ255QlNx?=
 =?utf-8?B?NHVPenZBWVpmZzdDUExCSFZISXVKMko4MVdJYnlneFlrWC84d0hicDlHdUZs?=
 =?utf-8?B?N2lQTmhIdzUwZ3Q5Y2h4MldvRUtNUjdUWklpNmVGTVAvZkNna1BSbkk1V0ZK?=
 =?utf-8?B?ODRwYWZldW9KZ3dRMUUwTXZLWXh5RlBOSkJpc01YbFU2RW5nOFRpaStON3FC?=
 =?utf-8?B?QnM5a1dqVGk3NEE2clMvR2ZDOGMvd08vczcxdzlyQnYwTGwrcmw2cDUwQkN2?=
 =?utf-8?B?ajUyQ3hWa0hjMUprdzkvTGkwc29UdEFpanE0UmlIQVlPTTg4TmVtR1Q3Nzg3?=
 =?utf-8?B?NTA1dzhsZ1l6eTZXdjdxRmFQaEpQcDVBRXRXM2lKY2pXTkVNa2RIQXhOb29r?=
 =?utf-8?B?SEo0MUVXdjNjVVEwVnNIWTRtNVovbWlOdTc1Z2c3MXVZRndoeGplZGJycjVn?=
 =?utf-8?B?TTZuL1BoTGM3N0V3RlI3TFJJL2R3UC8vSkxLMDdVdVV5SDJJSzlCVmZwcm5O?=
 =?utf-8?B?VEkrc21xVGpTM0hiYmI4cXlEQS9vU0FiZnlJazdyTEcwUVgrN0FQVWdVN2Zt?=
 =?utf-8?B?bnVEclZFR3ZlZDQ4d1ZGOVJuYzlLeHdDNld5bG5ZVjZDRlRNVWZORDkzVHhJ?=
 =?utf-8?B?NEY0N1FhazlSTGcxOVRUZnJDWjlNVG4xVnVzOHMrNjFYdktFS0pyeDk2NGNZ?=
 =?utf-8?B?QW92SHhheEx0Q0hraUF4a3NCNHVabll1amNya1ZHOFdudWxLUlZNSFNRM29h?=
 =?utf-8?B?SkFsQW9XRFowaVJmMkN1aldRVk5HclA1L0ExbFhWT0NJbU5vVTlsdWxpc3oz?=
 =?utf-8?B?RzA0dGdLQy9UVEhIR09xb0Jrbi9mb2tmSHFaOU12Nno4T3hJT01pZlNha010?=
 =?utf-8?B?NXpGeTRLdFVyU3J6Y3IrMVM5Y1UyekZFVGVSYkRWMkR6Y3ZnV2tGM0FPQUNJ?=
 =?utf-8?B?Y25RY3F6bE91bEJJRlN1VEhHelE4UUNYZmtHeHovN05zd2tqdFd6dTlLZ1Yv?=
 =?utf-8?B?b2xWdERDSjhvNHk4Q0RVVTNkR0ErbitLK1FFcVZvV1ZmZGtGYjVQaFRVMTNX?=
 =?utf-8?B?bVJ5Tkg3cnFRVDh3bk44emcyWGZ2OFVMQmZSRjZ0THI5MVpBdzQyMEJFVHZa?=
 =?utf-8?B?eUZPY2JBUGtqcnRGUHIyVk9KZGxvZFBpMHFvUTBhUHFOVVlLdXZvdWlsWmQy?=
 =?utf-8?B?dk01bjhXaEJ4d2NxUDkyTTF6Z3VuU0NFY0NiUmtxWGtYMlNBdlp2ODdFUU1i?=
 =?utf-8?B?ZUVLT3lDUEljYjNmUjAyUlFBcWMyeUE5ZklFdlZLbklETmVJUnN6S0RCYjZX?=
 =?utf-8?B?aFRyYThDZzhhVzltMHo1VTVlYzZpYS9RVmlaQmR0Q2JZRU9nZFdLeXZoVFRO?=
 =?utf-8?B?TkRwTjllMzlLdGE2LzNzS3A4L1gxZGZvSzhpZkwzejN2cmZ6TmZRbG82WC9O?=
 =?utf-8?B?d2ZCOTE1NWtBNEpvQnA1Y1I5TW5YbExKV0JGNVBEZFRRSVJBN0lCM1M2aU1D?=
 =?utf-8?B?UDRIRTlYUSs5REpLcjU5aDZubHUrMldyUVJta2w5Nmh2S1JlU1Jac3p5ditJ?=
 =?utf-8?B?ektSUkZzaTJldCthdVpYeFdDZXh4b29hTmhhSy9MeEFmdjFsSldvRW1IWCsz?=
 =?utf-8?B?Zm4zY2piWDk5QzFmUUNkU3dEYTlOdmxZZlJyZFA5RU9kVGF0Y1NGYWc2RVJK?=
 =?utf-8?B?a0dIdlFmTWNjcUJzS2Y3MUZJVVFvSHpBaGRzaTl2Q3QxcGIrVFJIUXNTMTdP?=
 =?utf-8?B?aEh2MTZNUmovR0dFZnczNnNkaEpkN09GS2ZXT3h3ZDhaSGtSTDcrTWw4eDBv?=
 =?utf-8?B?Uk9wQzJHSVgwQnBlNmdvK3BHc2h3TlNZOTZwbTZ4N0tnRFZTT3ZDdVZqWk96?=
 =?utf-8?B?YS9mekd5M3lzaGVSeUp0Tm5xUEJMa2Q2Q3FPZDBXWlBCYjdHWnN3aXhpVitn?=
 =?utf-8?B?Y0dLUjRGelZSMzF0YklOenBkMWZQb0hOTlUwNmptMTU2UVhJc0MvVldNdzlF?=
 =?utf-8?Q?9I/A6IQBYC9qiszSzvEJb3hc7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466a50fd-0a93-49e9-9ed9-08dd93dbd57f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:10:54.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVCAP0TEnEZ+NpKUCAe0jbWiqZZWIKAPW2vDffTCK2+sVAphFhyzCy8XlXAYWUqMroXUprkZlpU31iX6phsRsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131



On 5/15/2025 8:36 PM, Ingo Molnar wrote:
> 
> * Shivank Garg <shivankg@amd.com> wrote:
> 
>>> Also, similar errors are elsewhere as well.
>>
>> I'm sorry for missing these details in the previous revision.
>> I'm changing the first letter of variable description to capital.
>>
>> https://docs.kernel.org/doc-guide/kernel-doc.html
>> /**
>>  * function_name() - Brief description of function.
>>  * @arg1: Describe the first argument.
>>  * @arg2: Describe the second argument.
>>  *        One can provide multiple line descriptions
>>  *        for arguments.
>>
>> Function description also starts with capital letter in the doc-guide
>> and other kernel places so this should make it consistent.
> 
> Thank you! This version is much more complete. There were a few other 
> things missing, quite a few of them pre-existing, which I fixed up in 
> the commit (see the delta patch below).
> 
> Note that I standardized on a kernel-doc style variant without full 
> stops for simple singular sentences. This is what most of the x86 code 
> and the core kernel is doing, and it's contrary to the kernel-doc.html 
> recommendation - but you couldn't really have known that.
> 

Thank you for the detailed review and fixups.

Best Regards,
Shivank

> Thanks,
> 
> 	Ingo
> 
> =====================>
>  arch/x86/mm/pgtable.c | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 9aa3c60c6afa..59c42dec7076 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -543,11 +543,11 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  #endif
>  
>  /**
> - * reserve_top_address - Reserves a hole in the top of kernel address space
> - * @reserve: Size of hole to reserve.
> + * reserve_top_address - Reserve a hole in the top of the kernel address space
> + * @reserve: Size of hole to reserve
>   *
>   * Can be used to relocate the fixmap area and poke a hole in the top
> - * of kernel address space to make room for a hypervisor.
> + * of the kernel address space to make room for a hypervisor.
>   */
>  void __init reserve_top_address(unsigned long reserve)
>  {
> @@ -594,10 +594,10 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>  #ifdef CONFIG_X86_5LEVEL
>  /**
> - * p4d_set_huge - Setup kernel P4D mapping
> - * @p4d: Pointer to the P4D entry.
> - * @addr: Virtual address associated with the P4D entry.
> - * @prot: Protection bits to use.
> + * p4d_set_huge - Set up kernel P4D mapping
> + * @p4d: Pointer to the P4D entry
> + * @addr: Virtual address associated with the P4D entry
> + * @prot: Protection bits to use
>   *
>   * No 512GB pages yet -- always return 0
>   */
> @@ -608,7 +608,7 @@ int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
>  
>  /**
>   * p4d_clear_huge - Clear kernel P4D mapping when it is set
> - * @p4d: Pointer to the P4D entry to clear.
> + * @p4d: Pointer to the P4D entry to clear
>   *
>   * No 512GB pages yet -- do nothing
>   */
> @@ -618,10 +618,10 @@ void p4d_clear_huge(p4d_t *p4d)
>  #endif
>  
>  /**
> - * pud_set_huge - Setup kernel PUD mapping
> - * @pud: Pointer to the PUD entry.
> - * @addr: Virtual address associated with the PUD entry.
> - * @prot: Protection bits to use.
> + * pud_set_huge - Set up kernel PUD mapping
> + * @pud: Pointer to the PUD entry
> + * @addr: Virtual address associated with the PUD entry
> + * @prot: Protection bits to use
>   *
>   * MTRRs can override PAT memory types with 4KiB granularity. Therefore, this
>   * function sets up a huge page only if the complete range has the same MTRR
> @@ -652,10 +652,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>  }
>  
>  /**
> - * pmd_set_huge - Setup kernel PMD mapping
> - * @pmd: Pointer to the PMD entry.
> - * @addr: Virtual address associated with the PMD entry.
> - * @prot: Protection bits to use.
> + * pmd_set_huge - Set up kernel PMD mapping
> + * @pmd: Pointer to the PMD entry
> + * @addr: Virtual address associated with the PMD entry
> + * @prot: Protection bits to use
>   *
>   * See text over pud_set_huge() above.
>   *
> @@ -717,11 +717,11 @@ int pmd_clear_huge(pmd_t *pmd)
>  
>  #ifdef CONFIG_X86_64
>  /**
> - * pud_free_pmd_page - Clear pud entry and free pmd page.
> - * @pud: Pointer to a PUD.
> - * @addr: Virtual address associated with pud.
> + * pud_free_pmd_page - Clear PUD entry and free PMD page
> + * @pud: Pointer to a PUD
> + * @addr: Virtual address associated with PUD
>   *
> - * Context: The pud range has been unmapped and TLB purged.
> + * Context: The PUD range has been unmapped and TLB purged.
>   * Return: 1 if clearing the entry succeeded. 0 otherwise.
>   *
>   * NOTE: Callers must allow a single page allocation.
> @@ -764,11 +764,11 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  }
>  
>  /**
> - * pmd_free_pte_page - Clear pmd entry and free pte page.
> - * @pmd: Pointer to a PMD.
> - * @addr: Virtual address associated with pmd.
> + * pmd_free_pte_page - Clear PMD entry and free PTE page.
> + * @pmd: Pointer to the PMD
> + * @addr: Virtual address associated with PMD
>   *
> - * Context: The pmd range has been unmapped and TLB purged.
> + * Context: The PMD range has been unmapped and TLB purged.
>   * Return: 1 if clearing the entry succeeded. 0 otherwise.
>   */
>  int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> @@ -790,7 +790,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  
>  /*
>   * Disable free page handling on x86-PAE. This assures that ioremap()
> - * does not update sync'd pmd entries. See vmalloc_sync_one().
> + * does not update sync'd PMD entries. See vmalloc_sync_one().
>   */
>  int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  {


