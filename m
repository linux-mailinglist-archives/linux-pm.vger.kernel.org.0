Return-Path: <linux-pm+bounces-8891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC05090257B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 17:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1B51F21EAB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0915531A;
	Mon, 10 Jun 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZaKaYaq1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16681422C4;
	Mon, 10 Jun 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032681; cv=fail; b=h/Q5z4WiLHdijN3SJZ41cW/diitLDO2698srov6Uhn+MbdkZ9Z3QqedJG6zCvxQa53JTYe1JccXzfopXUSYlJ3XkZfSotxIHXGsJvaP2TtwYVomU3V8EYoZI1BR/TjPhLX8r70kDiwFb7Igytkc7LYBf0W8UY6EkX6LgXqKd5eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032681; c=relaxed/simple;
	bh=rGUE6GcFvPEnqoL559RuFvcLoP4vJYQlIaOQKjoTFOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hLfZ+nT6mRZXiVk5i1NrFNDg1O2cc+modPS6K/CJdumbSgJ+m2avdPUqnG9JdkQ90qSrLjhWCubrGvbSxsCSAVpscWQeMt9vU8QHxNkWAxbqj2e9RrcAV6LNNUJaQHgefc988PQF/NVgB0CbXbflJKX8CT1b9tJ2LDD/KiK7NR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZaKaYaq1; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjb4hqK6y25d+yEQ856mP7o0s/UnzwZlKfXjDwt+CYMHel12qz0F0IKcQVA5pn7LwVv6wa5f6Z66cUmawvqNjs7EzpBZd6L9qw9+6dXSQzjlFjkiwiADNHoh0Q7KMq3NzdQjjm+WExYJP5OTb3DT/2Ez6gzXN58RBvvdVoq6Cj9RQEvb7Y71G4hqe1sy4yoI2sPHNx0SDS5jSlpvcZZEd5DfDbIzfp7pv1Dyc9Yx/ykDePSN3rew5RXu+HoOYJPj3muj8ZIUWpctlcQKC3rOSQXnYGdCwIlo6gizv9AOj4et1TvDH+ms6qWM+JTgc0nRuffR5fYsj9iOVcpn3/jQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uYKUfv1DVEpIwdbitrYJBrIs4pV+c/ATcMVAOLLSZ8=;
 b=EuqJf0b+oCJGQrYSxeE7K3w6TmO+Uju3O6RNk8Qrd+JC/nU/pfLdcG3iZ24OoT6cOcPrgHEzO2rAngAwIe7ieZkrhbVJ2X9Ir9Ic8Rvq3tjO4bGfHMeGKofeif/rOKWwL7gRWfO2Czwof3ho2O+8UCSXejk1ZJaYmil3fKVVDT7njwah1raqn5BB32OZLSvPhsRyVWyQ9YGbbPfshfVJZIQ/hXEKc0cQp6fUGX9EnOaG8YSrWwnWZxLlu9CDj56WWGgfNgP4EowfaEFu3T4T56jY+lhFyG/NrZa0Jn0SBmEv893BW624kR7t8pyH2siQrOQlCJUfHG+zYGQl7u8qRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uYKUfv1DVEpIwdbitrYJBrIs4pV+c/ATcMVAOLLSZ8=;
 b=ZaKaYaq1/7JOGJgbbeZlUBXOmrG27QvL6tt5mgRY+wICylom98UG1G67Qt7a34JDYXsMnVPBDetAVFElYde7258zpoW3ANb7LkWeKs2nOo6v1L8z+2a5Dlm2//Zp3Nz9rXpah2I8hC7AePkQJWYDO2A/zmrEltf5EYBU7P23ndM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 15:17:56 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 15:17:56 +0000
Message-ID: <cfd0a622-89bc-4303-a972-4b5c8380eb76@amd.com>
Date: Mon, 10 Jun 2024 20:47:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add per-core RAPL energy counter support for AMD CPUs
To: Oleksandr Natalenko <oleksandr@natalenko.name>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, kees@kernel.org, gustavoars@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com,
 sandipan.das@amd.com, linux-pm@vger.kernel.org
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
 <2733323.mvXUDI8C0e@natalenko.name>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <2733323.mvXUDI8C0e@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 46497c75-56ae-4485-4790-08dc8960812b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzQ2N1g4ODIyVUZlUC82R1czczd0OEE1aHk0L05oMVdsVDlIQk9adDF2bEo0?=
 =?utf-8?B?Y0QyYnZoU1NqZ3hySXBtYzRlaTYwS1JSY2NqTjZYVURod0tiR3NGNnZDWUI0?=
 =?utf-8?B?R0JNa0RsSXFYYkRMbTBTdWNzRCswanRFemNOaTlOYlFuQ2pVUlo4djlpZmpQ?=
 =?utf-8?B?WnVJNTNwdnV3YzVTQUVPUHlPMHBidm9XN05hRDdENG5Wazl4SXNIMjc3blJN?=
 =?utf-8?B?VkZHbjIxRWxWNjJRdnVwM3JRTnVIVmxKZThRenpCTmIvNFMyWlJVdE4yZTFV?=
 =?utf-8?B?NzBpR0VSN1BRNnRqczcwN01MWkRzMTV1UzUyenJJOTRQQld2Qm5HU2lRbnNO?=
 =?utf-8?B?MHpadkRNTUZWcE04YzlrSjFqeUdJV0gvOWcvZnVEcUN4aTEyUlNwZis2NzBL?=
 =?utf-8?B?aDBScUFweEdDUnZZS2laSTl0VVFycmxqaU4zS2tIdzVUYmlLS1gyR2FvTHpY?=
 =?utf-8?B?N2FYQ0wzQWhGVUhJcXhrTHJDTUozaEh1WHZKY2QvYk9tWUgrcWdRVXhpZXhD?=
 =?utf-8?B?TDJzUHNuYXBMZFBya1JFVnN3ZWJVcStFSnpXayt2WHNQRW5xYUxrV2g0Yzhk?=
 =?utf-8?B?RDFXdHV4RWhnbmcwRHRWRzlaY2RscmJIeGFSRllVbXFxbk5sS1dZaklaWS9N?=
 =?utf-8?B?a1BzM1plK3ljN2xXZWo1UEtuZUxISEFJSWFMdDRGN0VjVUpzbm9LZVVLZEdz?=
 =?utf-8?B?cTlBZzA1cEJycS9NdXQ3RlN3QSs0V0tENEp3NVhwNTcxck9mbmY4UEZhaFph?=
 =?utf-8?B?YTVvMFBoeFJuWGYydnZMY1IwR3p1cDk3anR4QlZpSnMrUDVTSnRMQU1FU1R6?=
 =?utf-8?B?bk1qQ0NSTTF0NmpyVis5Uk5ZcmhMeTdwekppYXptakVrdTVrcHlmcjBqbmc5?=
 =?utf-8?B?dXZVQVE3R0VFeEkwTkU3cXJEUFRDeEhPdGxIVm9BT3lER2tlLyt5dk5lQmdw?=
 =?utf-8?B?N01qeTJkaWlKVGQzSm1GdFFuS0tLditPUG9JS3BSVk5UVGJYUG5yaiticndM?=
 =?utf-8?B?R1MyT0ljanI4SExTeDN5SW5OQTR0NlUvKzNqUE9kZGdvS0Qvc0NDYjd5aGpR?=
 =?utf-8?B?YURLNzRsT0tIRm1FWkw3cHVhQVpwK3d6Y1dmR09UK0JvZEdkYWRvbDg5QytR?=
 =?utf-8?B?N200M2prUTdPeW1abkZOQkw2aUI2Ui9XdVFJYTlPTFVyV3FPVFdsVXJkNnZq?=
 =?utf-8?B?cUU0NWFoakxra0tHN1RlVFcxelkwVGc2V2dUc2J4SEFzWVhnOUswcGVLcXlk?=
 =?utf-8?B?UFFMYTFpZ0NiZngrQ1B6SU56T1lFTFVyNXcxQmhPem5aN2dGdXV2TUZTOEpO?=
 =?utf-8?B?Y3J3MmhaNGxKUUNUZ2xNcHZYdXV6Ylc4OUJaejBjZkJaK0FJT3Jma2JwN0Nz?=
 =?utf-8?B?N0VQamFBOVR3b3ZKTEhEdUpndjVobDR2eGpNZ2dIVFFKT2pkUlpCV1MyN3d3?=
 =?utf-8?B?NTJnR0J4QWNIeGNpdGJJL2VBSmwzZ3c1bCs1SjNOc2Z3UWFoQXVVSERyVXdK?=
 =?utf-8?B?Uk9BYjlwdHBrOXRvZk1mM252TnNCVnpuSjE0ZElGOWh4T1oyaldXTU5saysw?=
 =?utf-8?B?OXAxYTdTTXhqdFhUK1BSRGhVNTlNNm50QjJHYlJEOE9wN3FkdHNQSzhjU2Ur?=
 =?utf-8?B?UGVOOU9xWHRTUlhzM2JzcXFUNGpTcVJuRGd5a3l3azNiS1l6dnJ1QkhMTzhZ?=
 =?utf-8?B?Y3luWnhtVlVtOVlZZ2NpN2ZLUFdnK2lVV1YyZkRCZHpNamxzRG9GNjNobnhX?=
 =?utf-8?B?cE1oSXBJcEJVVnFKdUNXYmFmVUtnOVZqRU1GOVluT29lRjBXNDk1Nmk1c25q?=
 =?utf-8?Q?hHbqF4iZDCYjEp1CGikqOauL9t50a2v5mk8aw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emErU2hsRnBpd0RUSkRzMElHVWp5czV6T2pxMVQ5N1VSblIveWt6bGxrRGl5?=
 =?utf-8?B?R0Q3aGp6elF0cm5JMnliNVlDbmRlK0xGUUk4WXVxcmdoTXhOekQycWt0L3ZP?=
 =?utf-8?B?OEVaY3VMNTluM0c2L1B0b3ZyVTB6aU04aDY3ZDlRRklmUlg1MS9CaWtMc0xW?=
 =?utf-8?B?L1lMTlNmNHArTUQ5WlY2RC9XeWZ3M3BCVGpOejMrcy9uUFJNam9kTTlsU29t?=
 =?utf-8?B?RWxuS24rM1NXc3dtdWYzTVkvZk45UjlZZVVIRWRtbzlxNlRXWmdGSVgwS1Rt?=
 =?utf-8?B?OEc3YzI0b3g1a3paeUVheS9hOW1mMi9jMHdBMkdiUFREVW9KRjBpQjRUWGQy?=
 =?utf-8?B?eEZSV2xOUkZnVm9XUWZHSDR3V0pmYllHWkYzemFtdXc2TSs0ZmVEQW5NTWx1?=
 =?utf-8?B?emh0bjZ0YkFCZmtCRTNFOFJBWkpjN2N3aFdnNUk4V0I3RUZZRGpKNUQ2QnM4?=
 =?utf-8?B?eXFPcVVQL0xyTXJjY2N2TjhnU28vaTNVL1JLdERxSUEwcVd1VldJdENMR3Ew?=
 =?utf-8?B?NmVvSDBBZVFZS2F4TWlQZXo1UVdOcTZ6UGF2SlczTE5nM3BlcHBma1Blc1hR?=
 =?utf-8?B?aG9VOFUweXgrWHRrWVFzOTFGOWp1QytiY0VDQzFFUzM3b2p3eG9hL1BFV2pQ?=
 =?utf-8?B?WkJCSHF2VmZYZG5XMzBUbnlzMU8xVU9EQjdnTGM5bWQ2OHRza21LQW14TU9F?=
 =?utf-8?B?a2NhMjk4a0k5Zlp5NFJuOUw3MUsvTnEvTmlEZlRzVzd2cXlOc2FtSU5UZ0xS?=
 =?utf-8?B?bUs3UFhiVDQ4SnZDTjNrRmtBM2g1eWpDREN2MTUwaGtqWGU1cFF4NFlKeG12?=
 =?utf-8?B?bWx3V1JIZ0t2KzNHZmgwN2V4VWhRL0RmRUtHTk1KWjAySXlUMVVuK0dZWHhQ?=
 =?utf-8?B?YkNEZzF6SDVwYjNrYzhESldRZ0hLd0FETjlaRzRiYUFQKzVQc2kwTlBRZXR5?=
 =?utf-8?B?NmdNVnpoOWFiTUJ5Qk53Y0ZNTi8rWlNXcGI4TE5iSWdRRThDMFZKS0xFWnhT?=
 =?utf-8?B?NFQxTEowOUVNeVB5blhtYUlRangrbmFDdTd6Wk5sc2NZQm14dSt5SXlHZXph?=
 =?utf-8?B?c2IyVlRSNG9EN3laa3B1RGwvdFhRWXhGWWdFdytaS3RJRWhGZWZacENIMXhz?=
 =?utf-8?B?YzZLaHdldEVBaHNqODExd2NHQ28zcCtaQTIxYmV5QnhnY1RDSm5NN1NLbTZS?=
 =?utf-8?B?Z1YzT3UxZTk4eS9kNnIwL0N3SGl2aVBZcDNIWE54dUdSdllJdVdpVmtUK25s?=
 =?utf-8?B?QXRnVWtQUWMvdFFlRWo0aWFJU0llWHVISnZqbUl3eUdmMk5qNmZ3US9YTnZy?=
 =?utf-8?B?TU0yYklBTHNnVXBBL0ZGU2VSVGdjSXByWEd1c2liREhxS0pqaVhoVHNCR3Rj?=
 =?utf-8?B?TzR3TDFjSzNsNlo2S0tjWndIbXNMTkxkVXVLS1BQWVhwZVZISUZtOHMvRzVG?=
 =?utf-8?B?WE9CV2ZGQmxrT2JTelFmQ2RzUTZOSTk2SW5TeS9odmsrckQ2QjN5WnRDRWZr?=
 =?utf-8?B?bEdINHhwN2dYSG9vbm5vaVd3MFh6cm54dXh1TFZUTDcvUnpnOTZVQlZyZmp6?=
 =?utf-8?B?QmE3VHpWUTNHQnhwcVd5cmRRTThuNzVnMFpxMmx3aFBEeXJSUDB3SW5sa0FE?=
 =?utf-8?B?K1JCNEx3WUNhUENsUHRGaWM4a2ZZTDlwR1Z2ZzhGR0hpQ2xUSHdSVm5aRGhz?=
 =?utf-8?B?cjhhTjZWbFVMb1V5OWlhS0hiYmVCSXpNZy8vQ1p3NytDSGhqc295UTd4MHhk?=
 =?utf-8?B?dE1SV3o1UkdraHhwSmlWY2pleWVHMjlqSUhWQmMrMVRWdVdiU05kbVlKb0hU?=
 =?utf-8?B?ZGp2bzhrVHFFM3NzRXhUU0pSZDNnSTV3WmsxZ3FSVjBQdUtvVmpUbVdFV2c2?=
 =?utf-8?B?UE15SjAxV0FmVXBjUFB2WDhLT3pZUm1WWnlqUGlmMlN2WTc2UE0zLzB3b0pm?=
 =?utf-8?B?WWNpYzB1azdlbFVMci84bVNHanlKMUE1a05BQzRiQW1kL0tPd2pQNkpNcTNO?=
 =?utf-8?B?MlN4TnoyRlRpSlRZVGRIUFZ0emp3QjdVTStWcVVuVGMyMW9yM3hBMWROVGZE?=
 =?utf-8?B?cUZ2eXB6NmoxYXVXN0VMM3dhSWFIZ0NqVW45TzFsWk1yei90bCtlVmNJSTZX?=
 =?utf-8?Q?OEOEs0yvyHSTICvWjm9VQ+rbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46497c75-56ae-4485-4790-08dc8960812b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 15:17:56.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+licGruIJjNcYR+3Qc5ETDO/Sn+jxy72X9WCeYZHq2iDiI/mwr4Pnxo7Bx8eXinhdbCz0OFZrH8SqnfVvGFsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

Hello Oleksandr,

On 6/10/2024 7:58 PM, Oleksandr Natalenko wrote:
> Hello.
> 
> On pondělí 10. června 2024 12:07:45, SELČ Dhananjay Ugwekar wrote:
>> Currently the energy-cores event in the power PMU aggregates energy
>> consumption data at a package level. On the other hand the core energy
>> RAPL counter in AMD CPUs has a core scope (which means the energy 
>> consumption is recorded separately for each core). Earlier efforts to add
>> the core event in the power PMU had failed [1], due to the difference in 
>> the scope of these two events. Hence, there is a need for a new core scope
>> PMU.
>>
>> This patchset adds a new "power_per_core" PMU alongside the existing
>> "power" PMU, which will be responsible for collecting the new
>> "energy-per-core" event.
>>
>> Tested the package level and core level PMU counters with workloads
>> pinned to different CPUs.
>>
>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa 
>> machine:
>>
>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
>>
>> [1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
>>
>> This patchset applies cleanly on top of v6.10-rc3 as well as latest 
>> tip/master.
>>
>> Dhananjay Ugwekar (6):
>>   perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
>>   perf/x86/rapl: Rename rapl_pmu variables
>>   perf/x86/rapl: Make rapl_model struct global
>>   perf/x86/rapl: Move cpumask variable to rapl_pmus struct
>>   perf/x86/rapl: Add wrapper for online/offline functions
>>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>>
>>  arch/x86/events/rapl.c | 311 ++++++++++++++++++++++++++++++-----------
>>  1 file changed, 233 insertions(+), 78 deletions(-)
>>
>>
> 
> With my CPU:
> 
>   Model name:             AMD Ryzen 9 5950X 16-Core Processor
> 
> and this workload:
> 
> $ taskset -c 1 dd if=/dev/zero of=/dev/null
> 
> the following result is got:
> 
> $ sudo perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> S0-D0-C0              1               1,70 Joules power_per_core/energy-per-core/
> S0-D0-C1              1               8,83 Joules power_per_core/energy-per-core/
> S0-D0-C2              1               0,17 Joules power_per_core/energy-per-core/
> S0-D0-C3              1               0,33 Joules power_per_core/energy-per-core/
> S0-D0-C4              1               0,14 Joules power_per_core/energy-per-core/
> S0-D0-C5              1               0,33 Joules power_per_core/energy-per-core/
> S0-D0-C6              1               0,25 Joules power_per_core/energy-per-core/
> S0-D0-C7              1               0,19 Joules power_per_core/energy-per-core/
> S0-D0-C8              1               0,66 Joules power_per_core/energy-per-core/
> S0-D0-C9              1               1,71 Joules power_per_core/energy-per-core/
> S0-D0-C10             1               0,38 Joules power_per_core/energy-per-core/
> S0-D0-C11             1               1,69 Joules power_per_core/energy-per-core/
> S0-D0-C12             1               0,22 Joules power_per_core/energy-per-core/
> S0-D0-C13             1               0,11 Joules power_per_core/energy-per-core/
> S0-D0-C14             1               0,49 Joules power_per_core/energy-per-core/
> S0-D0-C15             1               0,37 Joules power_per_core/energy-per-core/
> 
>        1,002409590 seconds time elapsed
> 
> If it is as expected, please add my:
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

We can see that after you affined the workload to cpu 1, energy 
consumption of core 1 is considerably higher than the other cores, 
which is as expected, will add your tested-by in next version.

P.S: I'm assuming here that cpu 1 is part of core 1 in your system, 
please let me know if that assumption is wrong.

Thanks for testing the patch!

Regards,
Dhananjay

> 
> Thank you.
> 

