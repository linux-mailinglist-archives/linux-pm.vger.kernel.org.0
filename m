Return-Path: <linux-pm+bounces-13466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A655F96A9A1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3088C1F250A0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A7F1D88C1;
	Tue,  3 Sep 2024 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gfi7SCQV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169921EBFEF;
	Tue,  3 Sep 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396729; cv=fail; b=KwebhfOG2WCYrgUuXMv/xPDTSxpMG58u5KrzBrHFf3UZO6o4h9xIqX96AgW497TqhpEzLraaXCEE2LKaC27oFe8RJeGyY8rTjKiq+ARh77rYmdykl3pOacN3o9mBbM401090rGzAnlwmpzoYS8c07SmLGPgAE3dQpXm9M28j9og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396729; c=relaxed/simple;
	bh=U275KCyiY29hnMkQbhfoHjpdTScrCfo1J0PkqG4HqYM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VuOwQVZ7BKRUOOMWowjpXNCUU9LpEE465wqA/orb+d9WrioNLNzAyo0hjbR6IzNrR8ClY68o4H3ROGpCqJcCdrjys6iN5qY8GxSm/XiBj/KBIEYiznxOzDzZlPqgLlpC6Fjoj5mX03WALI+fS8MW3Vx5SNm7mk4E5cABe3fupcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gfi7SCQV; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPixBAiI7kdVVtWCoDLsha33MkTJR9nCxlSwVEzyF0Njs493YG61IV62SUKQ2mI4YPqm+fQxAg9p3ATjt47Q7Fy2l4/Xq8dj6RDI30jnY/iibm57NUtRsgUXR90COWrKuft7J0JBe//A+0R3XSbIzpnvX7w9XlrDyjgkhpLSuizyDSpPosH1ogIj6r/sH7c0uq39Vz9AF51SoF4+6d4fb25YloI2s6lJslQQh0TUmwbRTzf7xdRYFFWncJpiFhtPgLabCB15lgkvFzhSpkyL/aGBhT2hBBaDuTF6+jwkmiS/tp3ngcrNfsKbe71VilRPj2hyXTUEPazm0BV6eUA1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3We4ro6C27vEIDIMe8kuTLZzGqR5jjv5e8/P9STjMJ4=;
 b=k2cknXrtB35C0Wk2QfCa9Lx/vFdePs6hzUH+JmqoBs/CMmHFIVgnNxqRz0l9PpfR+9oGTOqZFPzONlNvNdV9hiMIc3WGHv+7QEDfNMWuXmK8WABketnzb/ZSTeQyuRr4BEcisq+sHcvIV8qn6B56wq8n8B+/A29SoluvJM2nyjNDPrX6wV15A0MOCEbz93vMW7+0M8pC7KfFx4MV+TaE0SzCedyEvkiAOazuMd1dfgF4D2xR2plw3C24TTJ7dr2P+xztzx5oAYQ1du7bLdDAOCAQkbe0fpdRpcPqniKVXaCfk4avd20fnLhZXGk7vfl9+34TEp7hXEKNeQp02etvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3We4ro6C27vEIDIMe8kuTLZzGqR5jjv5e8/P9STjMJ4=;
 b=Gfi7SCQVcquBOmvzlpa7SyFlSAO8ke+eGFcp1f6A1MxLiP+UkcWuGtOsskLvPjV9TkgCLGwONjZz+VbBAluZDSqiPblkoNMRqjRY5/nLwhuAu2f8EzWZU9FA6MumQdqLvTVpLClMHiUi5pD4BvmuXABm28Nq6zyEdYLPeBahXKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 20:52:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 20:52:03 +0000
Message-ID: <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
Date: Tue, 3 Sep 2024 15:51:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
 scaling_max_freq setting on shared memory CPPC systems
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Jones, Morgan" <Morgan.Jones@viasat.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "li.meng@amd.com" <li.meng@amd.com>, "ray.huang@amd.com" <ray.huang@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Arcari <darcari@redhat.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
 <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
 <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
 <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
Content-Language: en-US
In-Reply-To: <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd0e5ba-bb14-40c8-a5f3-08dccc5a43dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDlBeE1vYUxKeXhKeHdkak1ITWE1bDl3Sm91VllsR3ExWGlMTVpXTThsVTRs?=
 =?utf-8?B?QUdHN0hMK2tMalFrSmh3SThKblltcW5zUUZjTllKWlhTcHFyTU95NStwWERI?=
 =?utf-8?B?YjIrRC9VbDJTVGJhbVJybG1NdE1RY2J5MUsvMHJ4MjcwV1hhSVpGcGtPQm0y?=
 =?utf-8?B?TkVtbysxdnNTTCtqSUthWnNTUk1Pakhwa3JwbFpSSWxjL1NtV1NsYTNvOTgr?=
 =?utf-8?B?ck9hOUt1RkhMYys5Y3pOMlFZdGJnQWZMbmtZcnZnRG1kcFVvYlJ2cmR1VXVC?=
 =?utf-8?B?NWhIeDdmcjZic25uUVRyVlpCaVdCdmRhUFRQcWhlM2lxYklxV29wN3puNEl4?=
 =?utf-8?B?YXZlUnpKakRnZkszV3JXY1JqZW4za296eW5wbG9jMThaaEkwK3JhN3diV1d2?=
 =?utf-8?B?ZGhKTjJIUS9sUmtDOEg4NElvUTVVNVZNb0NiZnBxdUFPWGt0UTcwL0ppSVFx?=
 =?utf-8?B?Qjd0SlVKRUVHYUVMcTNvSXlxa0p4Si9aNTZ1STlxaTNZcGdzZHl6bVkwYXh4?=
 =?utf-8?B?b2xQd1NVU2YyRUVHWXByK2FwZEErKzJITGdibWNQbGNDU1lVSWtLSEdFMVlS?=
 =?utf-8?B?UjdyMjhNVGphKzViOExET0gxWjlGVkhQeHpOaDRmdi9NV1VlV2gzL3pXTVdR?=
 =?utf-8?B?cE9WR1hxZXZBVWhJc0pUSWZvYkpaY3gyQ0YrQWtydXYzK3daelFVM2dtV0R6?=
 =?utf-8?B?ZTl4ZUljaWp2MUY1eUxOelZFdjQzSW9FRkJXNFB3dVdPU2tTY3hSZ3o1c3Fv?=
 =?utf-8?B?MUlOWTdDMjM1MjFNT2F2UFovaGJGZHlkdm5URjBWQS9yWWt2MG1iRWltdW83?=
 =?utf-8?B?cWJSelozU3BSeGhOaXkvbzVkclZIdVZDd1BISk8yVGdqK0Z3a0NhcStJNnIr?=
 =?utf-8?B?UkZkcEtJTkhmbzlPUFJtZXBlMU43SmY5T1ltbHpDc25pZkFuTi9WN0ROYnAv?=
 =?utf-8?B?Qi96Z1ZaR04xa2lhejhsdnlEWWZWTlpXRXRiTkhDMUxyUEZKNEdveGlCWnVX?=
 =?utf-8?B?ZWszTkkwVnVBdUZLKzlOMlRCWTE5YkJBMGwxT2VzTHlwcGx0aW9nSGxhL1R3?=
 =?utf-8?B?L0pxZHEzTkt5aW12b2Vnd0ltVXV1RE96cktQY2NheXVDUzFCN2dRSDUzZENK?=
 =?utf-8?B?eW4zWjErWjcydkJ1elpPN1VaeXZOcUF5UmpZMGhCcEFCeENMWHI3QTUyQS8v?=
 =?utf-8?B?bGgrN01iNnFaTkFpakFIYlVUYUhCd1hBZkMyZ3hIMTRuOUFLaTI4OXBxNnpv?=
 =?utf-8?B?TE1PWjNhcHNTZ09RanRBNEt6MkVaU2hLSlZkMDhNQ1dFclc2TUlZTkxLci9J?=
 =?utf-8?B?aW92ZjFZTUd6cmxnN2hWRWtRZkc1dHZuQnhwSllQOXgxZFd0eENGZUM0a1I4?=
 =?utf-8?B?alAxdEZtdmxycmozNk55OTh0dXptMnVDV3NyTnZtUVZlSHhkZjltUGNZaFkx?=
 =?utf-8?B?VzI3bldtVS90T2JXY1R6QmxLdzJ3NXdZNUxFWnlxSHZtaTlScmNjNG9DN0I4?=
 =?utf-8?B?b2NnRlE0cGRBRjRPSnRiMllIR0NoNFRPMUNwZXByc09VbmZMZnUwWDVOVTdP?=
 =?utf-8?B?b3RTalRxeG5pYXZ6S0gvMkRRMFFTQk9OK2Z6dGlBa3hsZmRFd0FWeHpEaE9i?=
 =?utf-8?B?RjZuTlU3Y3B3NU9EVlNVWGlpbm9saENLdCtBOG5WQ21mZmpVN2RwMjk4emdB?=
 =?utf-8?B?U0YwcVMzazEyYXQzY2lCcHdtZmtrUXFKNE5nMXZhQlVSS2NUbi83a3lWQ2U3?=
 =?utf-8?B?NDBNVUgrL1BnS09hSWJvcnlaUHpoTS9FVEtObENJN2l1L1F5Z1pFc3JjZTRV?=
 =?utf-8?B?ekhubUQ3MUJxeWhBRkJSV0ZYNXJLTWkvbmZzeHFlaFlBdm94V0VPRXZmRFJB?=
 =?utf-8?Q?bnvrVmyVUBy4G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0REV1FrN2lZMmVES0Y1TkpwbmVtS2EycXZBSzZ2VjFjcHBRVmw4QmVDVFNW?=
 =?utf-8?B?T2dqWnJUUGs4RlVFRTN4L0VGeXArWEpwR3oyclh4SEg2OE5CMWdNZU5MSitu?=
 =?utf-8?B?QzUxQlByTy9QdW9QUXZYcmRZR01ud3NPd1VLcXQ3N1RKNFU3ZXNHdGtscWtK?=
 =?utf-8?B?aGcvREVmOFZKTXQyTTRteWVGOG05ZUJJRnRRVFdDZHR0anl3SUdpdGdmNlI3?=
 =?utf-8?B?b09NcXRINk5kMDl4dndxbTdianRBNzZFYU03WldVa0FlREQvdmNKR2VVUHNJ?=
 =?utf-8?B?bGtnMUNlMkFsYUJpWGJMVjlMRERTdEhpc2U3N3RqcE5vRUFDS1R2VlRBN0Jz?=
 =?utf-8?B?aFBMNTMxSmxLK0o5Vk9lc0RKOGZJcUdZZVBGUXJsMnZVVXM0Unh0WXA4L0Fn?=
 =?utf-8?B?NjhrcUh0RGJaVTRmT2JyeHJrZDFXVDhURllmazFqQXBWZE8rZjVXWWs5TTgx?=
 =?utf-8?B?QUY4N3k4VmZrek5MSWF1bUN0SkNFeDg4ZHN5Zk5XaS9ob3RrNVJ4bFQzSFBN?=
 =?utf-8?B?bTFIcE8yOEV0dXNXY2lpRk1CUVRYZWFJV2t3dlYwME9MWEpoYUZVSHR1QUt5?=
 =?utf-8?B?SE1XY3RDOGc2MXhVSDNGWkM1T2Z0Q09mQjNFVEw1NmFuNmErK2VRUUY2NWFl?=
 =?utf-8?B?d1N5UmFzTVlJMHEwYk9TZVA0M25MZ3dTMDhSNFl2Wkw4VmRwS3MxUytkWEJl?=
 =?utf-8?B?ZWd2NnFHYjdrQWEvVzk4R1MyN1ZUL1MrODVQRjFNbHgyNEY5dzhHQ3lNYXJm?=
 =?utf-8?B?eGtpdkZ3L2JweXd6c002NUtsbWRHeWxaRko0bVM1VGNzQ0RkSTEyQWFSZm1Y?=
 =?utf-8?B?U0tZdVdSNElZZTZuS3RRWE5VSVZvcW9CWlUzeExvZzRnVDVJSmF1TnBnb3ZC?=
 =?utf-8?B?WUtaWlFyNmJBV3pJVGZCcm1HMmZXcEVVRjJmcnJYZnNnaTFvRHpzdHhXeTVw?=
 =?utf-8?B?SmEzOXdoRTZWVUozV09ESHoveGVjci8xTk5nK1dyTHliLy9yVEkrMUdKRGZh?=
 =?utf-8?B?M0pUYW8xSEJqd1E2MVcvSllDYUN2TTRxVUVjNGhVbXZzdWt5ZjRGSFhwTzNy?=
 =?utf-8?B?SXVraUxMKzI1ZTlzYiswN2x2Sit1VUZRV3paZTUrT1BOVDJFQXNMWXRDbjRV?=
 =?utf-8?B?TE9KeUx4OFBZZ1FKSVN5aEMrME50WllPUjdLV2JuSGd5NzNIRmVNQlp3YjN0?=
 =?utf-8?B?cVNZQThtRHBpckNvQitBZHdkTEJFZHhGVHMrVXV2WmtzODdMS28xTGUvd0JX?=
 =?utf-8?B?SjY5Zkp2Nm9reVJsazFKMTdFTHlGeTczYXM5N0d6cjNBMldtcDVBV2h4WGlQ?=
 =?utf-8?B?b3Q2dnhvNFlTblgwdGhaWkExVW9OSzJYSGcwTTh4TmRkcHdCNE1UUlRQWXYv?=
 =?utf-8?B?dTBDOTYzRWtEcW5aVGhzQnpncXdDR2FSSGJKZGk1Tk5FYlY4clRUZ1Z4c253?=
 =?utf-8?B?UXZCNEdqSUg2MFVnVXltV05YaUtvMlpMOG5vWTRrcGlteW9temZLbHRZSTFh?=
 =?utf-8?B?dXUxQ0FXakN2Q1RDUWVWRmJicDZGb2NKc3F6QWhUa0ppOUQxWEFzeUNVa2Rp?=
 =?utf-8?B?TWxTdkFDZytWQzVuTFYxTDQyWENLWlZySVRKYnVpdFlJYWM4SmZFQU83ZXR1?=
 =?utf-8?B?ejI3OXhnWVRlUElVVDdWMWZYZFBPbkpSVXFSdjI0dUdZNTVjVitHRDI5QUZG?=
 =?utf-8?B?eFZtNURzR3FCZnN6OVRMU0R1ZHp2cVRWbmhPWEptQ1h6L3hTSFBrSXNvM0VS?=
 =?utf-8?B?bThQN2hUTllVOWtpMFZiNVVncmFycmRWUkxidG45ODVvdUh4Wjk5dDBCajRn?=
 =?utf-8?B?ek9lYmlIN1BSVTBrbTUwb1NtaWxzR2hVb2wyN3RaK0hDVUFYSEdBcHFkTyty?=
 =?utf-8?B?TThXbjZnMWJjOXFHK01RVWNLOEhjVWxWVTNlL29kWm5YSUJNTUlYenBNbVZY?=
 =?utf-8?B?RTVab3BRWUJReCswRTNjblpSZSt5WFM4NkJNV0pTby9sWWdKN2MxSWs2ZnU3?=
 =?utf-8?B?Tm9mOVBCSzNXc2UvNmw5VjJ0d2I3cFQwWVlxWTFweHJ4YWJCODZqeUNoNk51?=
 =?utf-8?B?dkc3L3NBK0tpdUJDdE1GSnRhcmVxaC94K3B4bEd1OGlhM3N6S3Erc2JlYzhs?=
 =?utf-8?Q?7AeKq1Z06Vs2S33sKh+T+5Mob?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd0e5ba-bb14-40c8-a5f3-08dccc5a43dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 20:52:03.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVVTTwTaxMDrFWpfvg1EMSJ0ghK/FbnQWHrhxGudYFN+uJHHHxmhU+GpVPHQBwM5U4SInaKDBi4d5WN725mU8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

Morgan,

This does remind me of a clamping issue that touches some of the same 
variables.  Can you please see if backporting

commit 8164f7433264 ("cpufreq: amd-pstate: adjust min/max limit perf")

to 6.6.y helps for you?

Thanks,

On 9/3/2024 15:09, Mario Limonciello wrote:
> Morgan,
> 
> OK that's great news that it's just a backport effort.  That same commit 
> also backported to 6.10.3.  Can you see if 6.10.y is affected?
> 
> Ugwekar,
> 
> Any thoughts on what else needs to come back to 6.6.y off hand?
> 
> Thanks,
> 
> On 9/3/2024 15:07, Jones, Morgan wrote:
>> Hey Mario,
>>
>> Smoking gun here, the max frequency is incorrect on 6.6.44+ but is 
>> correct on 6.11.0-rc6.
>>
>> Linux redact 6.11.0-rc6 #1-NixOS SMP PREEMPT_DYNAMIC Tue Jan  1 
>> 00:00:00 UTC 1980 x86_64 GNU/Linux
>>
>> analyzing CPU 12:
>>    driver: amd-pstate-epp
>>    CPUs which run at the same hardware frequency: 12
>>    CPUs which need to have their frequency coordinated by software: 12
>>    maximum transition latency:  Cannot determine or is not supported.
>>    hardware limits: 400 MHz - 3.35 GHz
>>    available cpufreq governors: performance powersave
>>    current policy: frequency should be within 400 MHz and 3.35 GHz.
>>                    The governor "performance" may decide which speed 
>> to use
>>                    within this range.
>>    current CPU frequency: Unable to call hardware
>>    current CPU frequency: 3.34 GHz (asserted by call to kernel)
>>    boost state support:
>>      Supported: yes
>>      Active: yes
>>      AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.35 GHz.
>>      AMD PSTATE Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>>      AMD PSTATE Lowest Non-linear Performance: 115. Lowest Non-linear 
>> Frequency: 1.51 GHz.
>>      AMD PSTATE Lowest Performance: 31. Lowest Frequency: 400 MHz.
>>
>> We're running amd_pstate=active and amd_pstate.shared_mem=1, and our 
>> workloads are back to normal performance on 6.11.0-rc6.
>>
>> Morgan
>>
>> -----Original Message-----
>> From: Mario Limonciello <mario.limonciello@amd.com>
>> Sent: Tuesday, September 3, 2024 10:55 AM
>> To: Jones, Morgan <Morgan.Jones@viasat.com>; Dhananjay Ugwekar 
>> <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org; 
>> viresh.kumar@linaro.org; gautham.shenoy@amd.com; perry.yuan@amd.com; 
>> skhan@linuxfoundation.org; li.meng@amd.com; ray.huang@amd.com
>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David 
>> Arcari <darcari@redhat.com>
>> Subject: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the 
>> scaling_max_freq setting on shared memory CPPC systems
>>
>> Hi Morgan,
>>
>> Can you please cross reference 6.11-rc6 to see if you're still having 
>> a problem?  I would like to understand if we're missing a backport to 
>> stable or this is still an upstream problem.
>>
>> Thanks,
>>
>> On 9/3/2024 12:51, Jones, Morgan wrote:
>>> Hi there,
>>>
>>> We are experiencing a ~35% performance regression on an AMD EPYC 7702 
>>> 64 core machine after applying this patch. We observed Linux 6.6.44 
>>> starting to cause the issue, and performed a bisect involving 
>>> rebooting the machine over 15 times. (Note that kexec didn't 
>>> successfully identify the problem, since the PM memory mailbox is 
>>> never reset).
>>>
>>> It appears that we are getting a max of 2.18 GHz when this CPU can 
>>> boost to 3.35 GHz, explaining the slowdown. Blacklisting amd-pstate 
>>> solves the issue at the expense of the performance increase we used 
>>> to get by using it.
>>>
>>> Is it possible that the upper limits were implicitly at the max CPU 
>>> power before, and setting the upper limit to something other than the 
>>> boost frequency can reduce performance now?
>>>
>>> # bad: [7213910600667c51c978e577bf5454d3f7b313b7] Linux 6.6.44 # good:
>>> [58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9] Linux 6.6.43 git bisect
>>> start '7213910600667c51c978e577bf5454d3f7b313b7' 
>>> '58b0425ff5df680d0b67f64ae1f3f1ebdf1c4de9'
>>> # good: [72ff9d26964a3a80f7650df719df139f5c1f965d] arm64: dts: qcom:
>>> sm6350: Add missing qcom,non-secure-domain property git bisect good
>>> 72ff9d26964a3a80f7650df719df139f5c1f965d
>>> # good: [0fffc2e1bf40a2220ef5a38f834ea063dba832d3] ARM: dts: sunxi:
>>> remove duplicated entries in makefile git bisect good
>>> 0fffc2e1bf40a2220ef5a38f834ea063dba832d3
>>> # bad: [8cdbe6ebfd1763a5c41a2a3058497c0a9163311c] pinctrl: renesas:
>>> r8a779g0: Fix CANFD5 suffix git bisect bad
>>> 8cdbe6ebfd1763a5c41a2a3058497c0a9163311c
>>> # bad: [5dbb98e7fa42bebc1325899193d8f13f0705a148] drm/mediatek: Turn
>>> off the layers with zero width or height git bisect bad
>>> 5dbb98e7fa42bebc1325899193d8f13f0705a148
>>> # bad: [691ec7043122c9c8c46d84f6e6cd85d13d50cd93] selftests/bpf: Null
>>> checks for links in bpf_tcp_ca git bisect bad
>>> 691ec7043122c9c8c46d84f6e6cd85d13d50cd93
>>> # bad: [a1359e085d75d7393a250054e66c0a7bc6c3dbfa] perf/x86: Serialize
>>> set_attr_rdpmc() git bisect bad
>>> a1359e085d75d7393a250054e66c0a7bc6c3dbfa
>>> # bad: [e99d9b16ff153de9540073239d24adc3b0a3a997] wifi: ath12k: change
>>> DMA direction while mapping reinjected packets git bisect bad
>>> e99d9b16ff153de9540073239d24adc3b0a3a997
>>> # bad: [d027ac4a08541beb2a89563d3e034da7085050ba] firmware:
>>> turris-mox-rwtm: Initialize completion before mailbox git bisect bad
>>> d027ac4a08541beb2a89563d3e034da7085050ba
>>> # bad: [e6c9eca327e6a41a81e7eba0d0ddc13da37f82a1] ARM: spitz: fix GPIO
>>> assignment for backlight git bisect bad
>>> e6c9eca327e6a41a81e7eba0d0ddc13da37f82a1
>>> # bad: [b8cdefdaa555bbfc269c2198803f8791a8923960] m68k: cmpxchg: Fix
>>> return value for default case in __arch_xchg() git bisect bad
>>> b8cdefdaa555bbfc269c2198803f8791a8923960
>>> # bad: [13a71384ae6a8779da809b00c6f378dcead10427] cpufreq/amd-pstate:
>>> Fix the scaling_max_freq setting on shared memory CPPC systems git
>>> bisect bad 13a71384ae6a8779da809b00c6f378dcead10427
>>> # first bad commit: [13a71384ae6a8779da809b00c6f378dcead10427]
>>> cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory
>>> CPPC systems
>>>
>>> cpupower output:
>>>
>>> analyzing CPU 47:
>>>     driver: amd-pstate-epp
>>>     CPUs which run at the same hardware frequency: 47
>>>     CPUs which need to have their frequency coordinated by software: 47
>>>     maximum transition latency:  Cannot determine or is not supported.
>>>     hardware limits: 400 MHz - 2.18 GHz
>>>     available cpufreq governors: performance powersave
>>>     current policy: frequency should be within 400 MHz and 2.18 GHz.
>>>                     The governor "performance" may decide which speed 
>>> to use
>>>                     within this range.
>>>     current CPU frequency: Unable to call hardware
>>>     current CPU frequency: 2.17 GHz (asserted by call to kernel)
>>>     boost state support:
>>>       Supported: yes
>>>       Active: yes
>>>       AMD PSTATE Highest Performance: 166. Maximum Frequency: 2.18 GHz.
>>>       AMD PSTATE Nominal Performance: 152. Nominal Frequency: 2.00 GHz.
>>>       AMD PSTATE Lowest Non-linear Performance: 115. Lowest 
>>> Non-linear Frequency: 1.51 GHz.
>>>       AMD PSTATE Lowest Performance: 31. Lowest Frequency: 400 MHz.
>>>
>>> Thanks,
>>> Morgan
>>>
>>> -----Original Message-----
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>> Sent: Tuesday, July 2, 2024 10:49 AM
>>> To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>; rafael@kernel.org;
>>> viresh.kumar@linaro.org; gautham.shenoy@amd.com; perry.yuan@amd.com;
>>> skhan@linuxfoundation.org; li.meng@amd.com; ray.huang@amd.com
>>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; David
>>> Arcari <darcari@redhat.com>
>>> Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
>>> scaling_max_freq setting on shared memory CPPC systems
>>>
>>> On 7/2/2024 3:14, Dhananjay Ugwekar wrote:
>>>> On shared memory CPPC systems, with amd_pstate=active mode, the
>>>> change in scaling_max_freq doesn't get written to the shared memory 
>>>> region.
>>>> Due to this, the writes to the scaling_max_freq sysfs file don't take
>>>> effect. Fix this by propagating the scaling_max_freq changes to the
>>>> shared memory region.
>>>>
>>>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP
>>>> support for the AMD processors")
>>>> Reported-by: David Arcari <darcari@redhat.com>
>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>     drivers/cpufreq/amd-pstate.c | 43 
>>>> +++++++++++++++++++-----------------
>>>>     1 file changed, 23 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c
>>>> b/drivers/cpufreq/amd-pstate.c index 9ad62dbe8bfb..a092b13ffbc2
>>>> 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -247,6 +247,26 @@ static int 
>>>> amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
>>>>         return index;
>>>>     }
>>>> +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 
>>>> min_perf,
>>>> +                   u32 des_perf, u32 max_perf, bool fast_switch) {
>>>> +    if (fast_switch)
>>>> +        wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>>>> +    else
>>>> +        wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>>>> +                  READ_ONCE(cpudata->cppc_req_cached));
>>>> +}
>>>> +
>>>> +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>>>> +
>>>> +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>>>> +                      u32 min_perf, u32 des_perf,
>>>> +                      u32 max_perf, bool fast_switch) {
>>>> +    static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>>>> +                        max_perf, fast_switch);
>>>> +}
>>>> +
>>>>     static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>>>>     {
>>>>         int ret;
>>>> @@ -263,6 +283,9 @@ static int amd_pstate_set_epp(struct amd_cpudata 
>>>> *cpudata, u32 epp)
>>>>             if (!ret)
>>>>                 cpudata->epp_cached = epp;
>>>>         } else {
>>>> +        amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>>>> +                         cpudata->max_limit_perf, false);
>>>> +
>>>>             perf_ctrls.energy_perf = epp;
>>>>             ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>>>>             if (ret) {
>>>> @@ -452,16 +475,6 @@ static inline int amd_pstate_init_perf(struct 
>>>> amd_cpudata *cpudata)
>>>>         return static_call(amd_pstate_init_perf)(cpudata);
>>>>     }
>>>> -static void pstate_update_perf(struct amd_cpudata *cpudata, u32 
>>>> min_perf,
>>>> -                   u32 des_perf, u32 max_perf, bool fast_switch)
>>>> -{
>>>> -    if (fast_switch)
>>>> -        wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>>>> -    else
>>>> -        wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>>>> -                  READ_ONCE(cpudata->cppc_req_cached));
>>>> -}
>>>> -
>>>>     static void cppc_update_perf(struct amd_cpudata *cpudata,
>>>>                      u32 min_perf, u32 des_perf,
>>>>                      u32 max_perf, bool fast_switch) @@ -475,16 
>>>> +488,6 @@
>>>> static void cppc_update_perf(struct amd_cpudata *cpudata,
>>>>         cppc_set_perf(cpudata->cpu, &perf_ctrls);
>>>>     }
>>>> -DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
>>>> -
>>>> -static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
>>>> -                      u32 min_perf, u32 des_perf,
>>>> -                      u32 max_perf, bool fast_switch)
>>>> -{
>>>> -    static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>>>> -                        max_perf, fast_switch);
>>>> -}
>>>> -
>>>>     static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>>>>     {
>>>>         u64 aperf, mperf, tsc;
>>>
>>>
>>
> 


