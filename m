Return-Path: <linux-pm+bounces-22759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75116A41497
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBBC77A59BD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 05:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89CF6F099;
	Mon, 24 Feb 2025 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ahKrhPji"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CFEEA8;
	Mon, 24 Feb 2025 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740373323; cv=fail; b=qB3idK7LVt6aqopxaS6ZrMlkJG8S4Hn6W6X0wS1HZ5Z8Dwxsm7Jlg0HXtVRGte43IkghRTLNyqJsK0sPXCczcv74khkvMr1gyMky3lntqpMYKRH25jc+P8dbaHyUdjuzfaZoD1fS7TwUsrRvzRfRE/u7XAaTcwAx6WLnTlIANEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740373323; c=relaxed/simple;
	bh=2UmxYc2IoXa9bQ9VWToX1RVeQOEMzJgZev4C7dhPPfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YAP6L8ADHqcJdhhUdzh/ashCpZVWH3r3fQ5XWUrR8h7LQkzgLbYsdI2/yw4mX9u1dFvK7j5mhQTcVmxcPmmOlO4Ny314bAvuc757I+pXRFRCR2eobIiwJHgM/NBm48HFg6w/jkz90JM5xDsChO/nHSnWOchrOBY112oFSM65FYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ahKrhPji; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QixzhSDvudL+L5582vMvPQa3OfsYq3xKRlc6XUULhHP2+HDwi4HDe7xmdxwxWVsI2aRabOzMD2yqtgzN2U7dnrW4/qRuHczh6BZrKLFqsZ2DRDCZRRnj8hIDOmRXezQ4hKrSENrSYq/TwCMV3Xp9rwAXc/dLQ+KhyqbDXuYJNL0xqZ/qv5Vm9uER3/bPWT88L/Q0iUepxrLokNJZCC9pSScAWe7ivg6TraBT2+XqZqkyyvxCU9VI9uGJfF/D4ygR11g/Fe5Hx/yo+ZBX8FfdBCWeob7p7qdtPIcY8T7MZq+3S1WyoZGmTXXakJ5cbYAcSJWf0enZWxFFcedWRKLsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CvMBLs4ygMcgLAEgwnL8vKpxbwYgvho+SPOunqxmBA=;
 b=NZfdpZ9ZMfdAmvE6+gxaIdhlY7n9/iHNSIWALicZBfaRVgIxXeprgT4ixh739GQT9blbBUrJHFs3hBd9F2ixhsSJkl3AX4rPcfTfgTb2YYlUgvgjlUldXvMMzT7HaJ+0DmQhxrj5JZeFNIUncDiy0oAxwUqk0nkFlQ4vLWcvmi4wy6AzKixSQlSQlwEzu+WxVxjFM+rjsFtHfwkVRHPxtDW6f+WrAjjdFe6Yow5mZNxJlwyhr8AF7Gs/Y0rM6AvvGudv+6LwsWF6G+jGHIM2NglSTRI02+bw6mGYGMhSTQTrZTtP37Rmd0d2X09FJC4KCTAvFQCFCIVz2Im7ll4Riw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CvMBLs4ygMcgLAEgwnL8vKpxbwYgvho+SPOunqxmBA=;
 b=ahKrhPjio6uoqzC2qDoJ9hFD3oI/bazDqylRu39ja2vj+Py4OKKe+ON1XJrdlZxRtYXxi9GHnmU14qbh950/YgrwxkwIYx7Xa1TqLRjn56/W/eISqrrMIPnfsNfaQ9RSp94Hr4VrXHmre1EgpjWa/pKFg46tUGm14ZWZgQlXQf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 05:01:54 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 05:01:54 +0000
Message-ID: <02a857ba-0f5d-44eb-979d-be8804d876a5@amd.com>
Date: Mon, 24 Feb 2025 10:31:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] cpufreq/amd-pstate: Move perf values into a
 union
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-5-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250219210302.442954-5-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::20) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 536a7b61-9c1a-4481-19b4-08dd54905afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFE5aDFVWVZEN3BTRm13bHFSLzN4elhsSzRBNW4yZGpsaGU4K3RxNkltaGxr?=
 =?utf-8?B?dTJrV0haSXEyVXdoVEtIOTZ4Y3NMelJFTGVRZ3QwN3drcC9uZFYySnNPUVAr?=
 =?utf-8?B?RnZkUVVpbnB4c0ZIYXRRdVVyQ1pQL0lLZmpRTE5iS2VsQ3FBb3pHczk5bmx6?=
 =?utf-8?B?OU1JQ0pveE5ncUl4RFFhR0xYYU11WVZ6cDJzd2UvcGI1RUc3QVlzQ3dqZTRI?=
 =?utf-8?B?Q0xTaktjOFVDT0haYi9IQjYyaitWWVNvaThOZ012eGEvcHYzRVAzV1BqaGRS?=
 =?utf-8?B?SG53MEZUc2E1RFZTc0JSWTMxMDc1RGJYblJaQjFFMGFlT1FZN094UjJYc0pR?=
 =?utf-8?B?YjA5VVRBTXAwSEwvY0xYRHIwd3Y0Nnd3RnAvSkU2Z2J4aGRyODFGb3NTYWFW?=
 =?utf-8?B?Z0hDRmhGTllsRExwSktRZkFqWXRkOGZLNzkwbG9QRlhob1JJZU85YmZSRnV3?=
 =?utf-8?B?SmdnTGpxUXF3WmtPeXlFKzdYMTYvRklwZmdqemExeU1wWEh0WTVmUWRhWU95?=
 =?utf-8?B?akp2SXBoV2hKTnJURUttSTVFeXFMd2t1RnBJYXhPczhRNlJTOGNSWUk1VDly?=
 =?utf-8?B?NDl3M1NlNE5Sa29xVkYyOUZ5Y0J0ajVXSGVBMmswalVJZCttZlQ2bytSUkhE?=
 =?utf-8?B?KzhEZGxHT1BzSHVSbWNwMXJxMDdVNWM1citqRUJySGdaaGU5cWhBbTlyME1s?=
 =?utf-8?B?ODh0dk5oa3NablFqVkRRWkFaTlVaODFtNjVvZDBlY09PY1l0azBNWm9LM2do?=
 =?utf-8?B?amNkRG9WaUE5K2ZtMEl6VjdsQVNXZUlLcXBZNktqdHN5TlVYQlUrcHNtamVR?=
 =?utf-8?B?WHVyRlFpYkViZ2RaMms4NXNsckd1cFJoemFMRjBiM3RTeHRoMzR1NWJPTnYx?=
 =?utf-8?B?ZVFrWTM4V3RyV2hjSk1Dc1BEaW8rU2VDUkRWUGNqSWlkbnJWeHA2b3hEek5r?=
 =?utf-8?B?N2U2aFgrRzZzZXdkaU9aY2h5eXUxUkMzRmNMOEVHbzV0eUFZbm1JQUFXQm5F?=
 =?utf-8?B?RlptNXJxOGVjNmdKaTc5SFFRaTBBdEZpZTVqZHFpNTlsVUtZVUIxdlpXRXRp?=
 =?utf-8?B?czU0a2dPaEozRGNCekUvMGFtUE1Uc05kVENiOGJOb2FnNTVCN2lkKzhBY1d5?=
 =?utf-8?B?UFFEVk9IQUptTkoxMEcyNGc0VmdXMHV4K2RwZFd6K0N3YXZmZEZmSDh5R1Ez?=
 =?utf-8?B?RGN6TkRrT1cybnhxcDEveUtXUEJqT3FwU0ZlVkRIQUwyWmU4SjhzSzVaSmxF?=
 =?utf-8?B?MHhDMXd4Z0JSOWpmQnJQQkJEQTgwRkU0UEVVRlZKSHdiZG5yNE9LaGhiNUx3?=
 =?utf-8?B?VUswdlhiSmQyanBnZ0E2Qm9zRnNJN1BibkhYOUozd243ejFVWG5qS3k0WDcv?=
 =?utf-8?B?RDBTc2xlMlFpYlBoVUE4Zm0zTDh1ZjN2NlU0VDhDQ0ZaVTBpNnJpZ05VQlIw?=
 =?utf-8?B?NjhBdEg3b01OaTV3NU5wSnRwQmNzbGxNMTlLNjl6YjFGejRFN2t6bkxIcTJh?=
 =?utf-8?B?aXlPZXhZMW1TbUJHamlJS3BIdThjbWRXdm5Fdk50NDZ2b2FpQ2RXaFRHdjU3?=
 =?utf-8?B?Yys1VFM0c1d2TkdnRm5uMHNBdUJBUmVsWitHVjAzUldDbm0xbnNNMnF1eFlC?=
 =?utf-8?B?cXAzM3Q3UFZhR1dzTHdFNDZJNTB4RWpUTGw4bEpPOHU1MmlvZjl6dlB3a2Vr?=
 =?utf-8?B?eWxKWEJ5QWMvdEk3KzBrWDhvdks3dFNKd2hUWVJhSlJpUlVablVTNzNPQ0M2?=
 =?utf-8?B?ZUYvUU9NeWJ4NCs1Uk1JYVhycEpkWVJCZlYzTW95dzlCT0VOWDV4eEFzeGps?=
 =?utf-8?B?bkU3ZGZub2ZVQzEra0lqWW1CWitwR1BqQVQ4WEluTG5BVVlDdGU1anJKQ01C?=
 =?utf-8?Q?UVH994L45lep+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qmk5NnJWdkt4VFJ4bW16NXJobmVCd1A0Q05GM2h3ZHF2cmZ2OWhVUHB2cGR0?=
 =?utf-8?B?Z09aU3Yvc3dzZTZINEYwUUF1elg0a1lYSzZmM3VWK2lrT2hXWW1HQWVFdWhX?=
 =?utf-8?B?cE9JSWpTZVJpRC93WG0vT0pZRk5qV3ZRNnNpNURlK0pxaUNuZDlvbE5GV3d4?=
 =?utf-8?B?QzBuRzJMSGorMkRyQVFwdTVzWGNBSW5CN05DSW1rUk9aQWdKWVRocmJzRG51?=
 =?utf-8?B?cERVQ0xSUE10NEhaZnFHQjduclhNV0c3eldmZ3lWam10Mmk5bjRvWlFsOWY3?=
 =?utf-8?B?TExrTFg3UGMyVk9CYlErTFJRSyt3TkJCRDhkUEFWQU5VVmpoT3hNQ0JXcmkx?=
 =?utf-8?B?VzhDWlVDMWJlY1JINk1YNXVrUFFFcm81WEIzM0xDUElxVFpwUTgrM0lwV0tQ?=
 =?utf-8?B?QVhoczQwL0NVZGFZTTJTakZCVm5laDVOZTV2MUFzVXdoQ1NoQWJBb1VXSkc3?=
 =?utf-8?B?SWJESmJUT0U1RklWUldWZDNHZDRjRFgzaVRXdzBzREtmRytXNVUwUHloSEFz?=
 =?utf-8?B?T3BoSG5SWmkxN1FjeVZNRjAvaXZBdm1GcGdDTDdPUXNBVEtKT2xLeVVtRnlh?=
 =?utf-8?B?WFJZUUpOMDBmNmlvNThCOXo0WE00K2xqVVNreS96SlNhZm1pK1dwWTV1Qzh2?=
 =?utf-8?B?b2RaRWU4Yk16RHlFeVdEWnoxeFVkK1pUVjFoTGI0RGpBRzJsV1Y3QVJmR2Q4?=
 =?utf-8?B?MUJHbk56cjNvYjYreDhkcVV0OEZ1TEprTTJWNWV4Zkg4KzVrWFJLelBDTEdL?=
 =?utf-8?B?NTZCOHJqVWpCUVdScmVjT1pUUUV1dERpWWM5TXJKYmxLdzFmTWo4UW81QkhK?=
 =?utf-8?B?SFQyblM5K29QY3FSdzU3K29wbHozdjZHaHdVTS9JOFIydFdPbHc5bVRtajhP?=
 =?utf-8?B?SUJCa245cHFNc3RVM2ZmNEs5Tzh2akdCZzBKSloxMXc4dHNjSmdGVW0yL1RO?=
 =?utf-8?B?NGMrampmdy9waXNpRU9KZWFGTUQ2RWI2Z3dvL29DSUNJcndlNGJqTGt3UWRx?=
 =?utf-8?B?NDhMVUFHRzBpcktxSGhLR0lON0F3TExkQWRRaWhzY1N0WjFEUm9QcUE1RUZQ?=
 =?utf-8?B?NXFNSlJKOURZazRuSnluaUM0WjB2dExMNjROS2JwRUFOOW52a0ZGc0xsWGQx?=
 =?utf-8?B?MEFYRUswbjcvem8rU3lvak02NUk2b0ZtcTNmS0JGNkpDckFHMUxtcVZWcUdm?=
 =?utf-8?B?MjdMRFp5MktaMUNjbjhza2VKOEE5MFYwQ2I0Q1Y0Vzlia3MzVndReC91VzA3?=
 =?utf-8?B?WnRyK09mMUlLbVRKYzByazBKNlZCZysxYmUyemhsUnk3QkpvNHFWSUxKR0NH?=
 =?utf-8?B?UDYwT2ZQdEQwQTRCNzdlaUhwMXcrTkpnNFE5RElnMlM0c015ZVJHeVhsbVJX?=
 =?utf-8?B?ZHcxd09UdFJLM3lZYjJyTWltdnU1bHF2UWZxRmtyY3kyOWw5L2cvZ1JQYmJ4?=
 =?utf-8?B?dndkUVhrbWMzVnV1OEdhTDRPWGhqbUpoeTNwM0NLNzJiNkV5Wi85S29QcXZs?=
 =?utf-8?B?TTF4UkdtVVlXOVNQRjF3bkxNYS9NdW9EK3pjUUpUSVBWNWs5MEdqS0tDQ0t5?=
 =?utf-8?B?R1grVzJYUnNzdmhyaGZOemN5cStOM2dGaU1pWVlRcU1qWXY1MWVVcUhiR3pN?=
 =?utf-8?B?cDVNWEFRODB5L0dZUWFkd1ZLc1ZlY3hjRmNyNFluL0lUVStpcFM5ell0Smlk?=
 =?utf-8?B?dGtWSWVQaGFTVzAvd2pZUkJXK0RXWUE0N2tyMUVUdklJNW85UXNwdnhRWHg0?=
 =?utf-8?B?dlFjaC96QUFCT2Izdnl5bjE5aVNPRXl4MTVUai8xblZqVkpKaDI4ZDRUekdo?=
 =?utf-8?B?dDBjYTF6aXVMaXgwdms4MGFMYUd0dmZ3dWkrOEMrUzE4NDR5S1RteWpyYTc1?=
 =?utf-8?B?Tzhhd2Noa1RMc2dKdDdCazk2VmtuaHpzc3ZHd1h5dXNPa2dXS0JqdTAxcVdq?=
 =?utf-8?B?M3FCUmE5Z2ptZnVQd3FSK2lNRk93N25GNzlTb1JpZWpjeFZiVXNlU3JISkRJ?=
 =?utf-8?B?bWpBM2lWcEtzVlNjYjFCQXRYai9kM1ZSNUZHRFpPSlMvd1cwVXkzNTZGTWZU?=
 =?utf-8?B?eW9sazRtM2F3KzlxU0NtRysvQkF4azJiYUdWeUYxRWNBSlJYdGtDcDlRZlZs?=
 =?utf-8?Q?/sqI+KqnDzlp/kKQQZWz11RCE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536a7b61-9c1a-4481-19b4-08dd54905afc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 05:01:53.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAFIeEhaW/vFtD+q3xn4nt+bDpyEL01tHYqlv1EvNGK8AHTT4q9mVQufz4Y3lJUS9JkqXcRDojb/n9r0bA1LiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317

Hello Mario,

I think you missed my comments on the last version of this patch, 
I had pointed out one minor fix and some optimizations. Can you 
please look at it and reply there with your thoughts.

Link: https://lore.kernel.org/linux-pm/ccac287d-5bde-4b0d-a1d6-b1e8b5f4e6cb@amd.com/

Thanks,
Dhananjay

On 2/20/2025 2:32 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> By storing perf values in a union all the writes and reads can
> be done atomically, removing the need for some concurrency protections.
> 
> While making this change, also drop the cached frequency values,
> using inline helpers to calculate them on demand from perf value.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>  * Rebase on earlier changes
> v3:
>  * Pick up tag
> v2:
>  * cache perf variable in unit tests
>  * Drop unnecessary check from amd_pstate_update_min_max_limit()
>  * Consistency with READ_ONCE()
>  * Drop unneeded policy checks
>  * add kdoc
> ---
>  drivers/cpufreq/amd-pstate-ut.c |  18 +--
>  drivers/cpufreq/amd-pstate.c    | 204 ++++++++++++++++++--------------
>  drivers/cpufreq/amd-pstate.h    |  49 +++++---
>  3 files changed, 155 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 445278cf40b61..ba3e06f349c6d 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -129,6 +129,7 @@ static void amd_pstate_ut_check_perf(u32 index)
>  	struct cppc_perf_caps cppc_perf;
>  	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
> +	union perf_cached cur_perf;
>  
>  	for_each_possible_cpu(cpu) {
>  		policy = cpufreq_cpu_get(cpu);
> @@ -162,19 +163,20 @@ static void amd_pstate_ut_check_perf(u32 index)
>  			lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
>  		}
>  
> -		if (highest_perf != READ_ONCE(cpudata->highest_perf) && !cpudata->hw_prefcore) {
> +		cur_perf = READ_ONCE(cpudata->perf);
> +		if (highest_perf != cur_perf.highest_perf && !cpudata->hw_prefcore) {
>  			pr_err("%s cpu%d highest=%d %d highest perf doesn't match\n",
> -				__func__, cpu, highest_perf, cpudata->highest_perf);
> +				__func__, cpu, highest_perf, cpudata->perf.highest_perf);
>  			goto skip_test;
>  		}
> -		if ((nominal_perf != READ_ONCE(cpudata->nominal_perf)) ||
> -			(lowest_nonlinear_perf != READ_ONCE(cpudata->lowest_nonlinear_perf)) ||
> -			(lowest_perf != READ_ONCE(cpudata->lowest_perf))) {
> +		if (nominal_perf != cur_perf.nominal_perf ||
> +		   (lowest_nonlinear_perf != cur_perf.lowest_nonlinear_perf) ||
> +		   (lowest_perf != cur_perf.lowest_perf)) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d nominal=%d %d lowest_nonlinear=%d %d lowest=%d %d, they should be equal!\n",
> -				__func__, cpu, nominal_perf, cpudata->nominal_perf,
> -				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
> -				lowest_perf, cpudata->lowest_perf);
> +				__func__, cpu, nominal_perf, cpudata->perf.nominal_perf,
> +				lowest_nonlinear_perf, cpudata->perf.lowest_nonlinear_perf,
> +				lowest_perf, cpudata->perf.lowest_perf);
>  			goto skip_test;
>  		}
>  
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 278d909904e3b..a6066fb4ffb63 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -142,18 +142,17 @@ static struct quirk_entry quirk_amd_7k62 = {
>  	.lowest_freq = 550,
>  };
>  
> -static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
> +static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
>  {
> -	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
> -					cpudata->nominal_freq);
> +	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
>  
> -	return clamp_t(u8, perf_val, cpudata->lowest_perf, cpudata->highest_perf);
> +	return clamp_t(u8, perf_val, perf.lowest_perf, perf.highest_perf);
>  }
>  
> -static inline u32 perf_to_freq(struct amd_cpudata *cpudata, u8 perf_val)
> +static inline u32 perf_to_freq(union perf_cached perf, u32 nominal_freq, u8 perf_val)
>  {
> -	return DIV_ROUND_UP_ULL((u64)cpudata->nominal_freq * perf_val,
> -				cpudata->nominal_perf);
> +	return DIV_ROUND_UP_ULL((u64)nominal_freq * perf_val,
> +				perf.nominal_perf);
>  }
>  
>  static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
> @@ -347,7 +346,9 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>  	}
>  
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +		union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  epp,
>  					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
>  					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> @@ -425,6 +426,7 @@ static inline int amd_pstate_cppc_enable(bool enable)
>  
>  static int msr_init_perf(struct amd_cpudata *cpudata)
>  {
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  	u64 cap1, numerator;
>  
>  	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> @@ -436,19 +438,21 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	WRITE_ONCE(cpudata->highest_perf, numerator);
> -	WRITE_ONCE(cpudata->max_limit_perf, numerator);
> -	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
> -	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
> -	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> +	perf.highest_perf = numerator;
> +	perf.max_limit_perf = numerator;
> +	perf.min_limit_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +	perf.nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
> +	perf.lowest_nonlinear_perf = AMD_CPPC_LOWNONLIN_PERF(cap1);
> +	perf.lowest_perf = AMD_CPPC_LOWEST_PERF(cap1);
> +	WRITE_ONCE(cpudata->perf, perf);
>  	WRITE_ONCE(cpudata->prefcore_ranking, AMD_CPPC_HIGHEST_PERF(cap1));
> -	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
>  	return 0;
>  }
>  
>  static int shmem_init_perf(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  	u64 numerator;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -459,14 +463,14 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  	if (ret)
>  		return ret;
>  
> -	WRITE_ONCE(cpudata->highest_perf, numerator);
> -	WRITE_ONCE(cpudata->max_limit_perf, numerator);
> -	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> -	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> -		   cppc_perf.lowest_nonlinear_perf);
> -	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +	perf.highest_perf = numerator;
> +	perf.max_limit_perf = numerator;
> +	perf.min_limit_perf = cppc_perf.lowest_perf;
> +	perf.nominal_perf = cppc_perf.nominal_perf;
> +	perf.lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> +	perf.lowest_perf = cppc_perf.lowest_perf;
> +	WRITE_ONCE(cpudata->perf, perf);
>  	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
> -	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
>  
>  	if (cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
> @@ -549,14 +553,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>  {
>  	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> -	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  
>  	if (!policy)
>  		return;
>  
>  	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>  
> -	policy->cur = perf_to_freq(cpudata, des_perf);
> +	policy->cur = perf_to_freq(perf, cpudata->nominal_freq, des_perf);
>  
>  	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
>  		min_perf = des_perf;
> @@ -565,7 +569,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  
>  	/* limit the max perf when core performance boost feature is disabled */
>  	if (!cpudata->boost_supported)
> -		max_perf = min_t(u8, nominal_perf, max_perf);
> +		max_perf = min_t(u8, perf.nominal_perf, max_perf);
>  
>  	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
>  		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> @@ -602,39 +606,41 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  	return 0;
>  }
>  
> -static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
> +static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  {
> -	u8 max_limit_perf, min_limit_perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  
> -	max_limit_perf = freq_to_perf(cpudata, policy->max);
> -	min_limit_perf = freq_to_perf(cpudata, policy->min);
> +	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
> +	perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> -		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
> +		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
>  
> -	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> -	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>  	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
>  	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
> -
> -	return 0;
> +	WRITE_ONCE(cpudata->perf, perf);
>  }
>  
>  static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  				  unsigned int target_freq, bool fast_switch)
>  {
>  	struct cpufreq_freqs freqs;
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  	u8 des_perf;
>  
> +	cpudata = policy->driver_data;
> +
>  	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>  		amd_pstate_update_min_max_limit(policy);
>  
> +	perf = READ_ONCE(cpudata->perf);
> +
>  	freqs.old = policy->cur;
>  	freqs.new = target_freq;
>  
> -	des_perf = freq_to_perf(cpudata, target_freq);
> +	des_perf = freq_to_perf(perf, cpudata->nominal_freq, target_freq);
>  
>  	WARN_ON(fast_switch && !policy->fast_switch_enabled);
>  	/*
> @@ -645,8 +651,8 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  	if (!fast_switch)
>  		cpufreq_freq_transition_begin(policy, &freqs);
>  
> -	amd_pstate_update(cpudata, cpudata->min_limit_perf, des_perf,
> -			  cpudata->max_limit_perf, fast_switch,
> +	amd_pstate_update(cpudata, perf.min_limit_perf, des_perf,
> +			  perf.max_limit_perf, fast_switch,
>  			  policy->governor->flags);
>  
>  	if (!fast_switch)
> @@ -675,9 +681,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  				   unsigned long target_perf,
>  				   unsigned long capacity)
>  {
> -	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
> +	u8 max_perf, min_perf, des_perf, cap_perf;
>  	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>  	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  
>  	if (!policy)
>  		return;
> @@ -687,8 +694,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>  		amd_pstate_update_min_max_limit(policy);
>  
> -	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	min_limit_perf = READ_ONCE(cpudata->min_limit_perf);
> +	perf = READ_ONCE(cpudata->perf);
> +	cap_perf = perf.highest_perf;
>  
>  	des_perf = cap_perf;
>  	if (target_perf < capacity)
> @@ -699,10 +706,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	else
>  		min_perf = cap_perf;
>  
> -	if (min_perf < min_limit_perf)
> -		min_perf = min_limit_perf;
> +	if (min_perf < perf.min_limit_perf)
> +		min_perf = perf.min_limit_perf;
>  
> -	max_perf = cpudata->max_limit_perf;
> +	max_perf = perf.max_limit_perf;
>  	if (max_perf < min_perf)
>  		max_perf = min_perf;
>  
> @@ -713,11 +720,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  	u32 nominal_freq, max_freq;
>  	int ret = 0;
>  
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
> +	max_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
>  
>  	if (on)
>  		policy->cpuinfo.max_freq = max_freq;
> @@ -888,30 +896,29 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>  }
>  
>  /*
> - * amd_pstate_init_freq: Initialize the max_freq, min_freq,
> - *                       nominal_freq and lowest_nonlinear_freq for
> - *                       the @cpudata object.
> + * amd_pstate_init_freq: Initialize the nominal_freq and lowest_nonlinear_freq
> + *			 for the @cpudata object.
>   *
> - *  Requires: highest_perf, lowest_perf, nominal_perf and
> - *            lowest_nonlinear_perf members of @cpudata to be
> - *            initialized.
> + * Requires: all perf members of @cpudata to be initialized.
>   *
> - *  Returns 0 on success, non-zero value on failure.
> + * Returns 0 on success, non-zero value on failure.
>   */
>  static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
> -	int ret;
> -	u32 min_freq, max_freq;
> -	u32 nominal_freq, lowest_nonlinear_freq;
> +	u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
> +	union perf_cached perf;
> +	int ret;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
> +	perf = READ_ONCE(cpudata->perf);
>  
> -	if (quirks && quirks->lowest_freq)
> +	if (quirks && quirks->lowest_freq) {
>  		min_freq = quirks->lowest_freq;
> -	else
> +		perf.lowest_perf = freq_to_perf(perf, nominal_freq, min_freq);
> +	} else
>  		min_freq = cppc_perf.lowest_freq;
>  
>  	if (quirks && quirks->nominal_freq)
> @@ -924,8 +931,8 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>  
> -	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
> +	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
> +	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>  
>  	/**
> @@ -952,6 +959,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  	struct device *dev;
>  	int ret;
>  
> @@ -987,8 +995,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>  	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>  
> -	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
> +	perf = READ_ONCE(cpudata->perf);
> +
> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> +							      cpudata->nominal_freq,
> +							      perf.lowest_perf);
> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
> +							      cpudata->nominal_freq,
> +							      perf.highest_perf);
>  
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
> @@ -1069,23 +1083,27 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
>  static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  
> +	cpudata = policy->driver_data;
> +	perf = READ_ONCE(cpudata->perf);
>  
> -	return sysfs_emit(buf, "%u\n", perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf)));
> +	return sysfs_emit(buf, "%u\n",
> +			  perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf));
>  }
>  
>  static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
>  						     char *buf)
>  {
> -	int freq;
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  
> -	freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
> -	if (freq < 0)
> -		return freq;
> +	cpudata = policy->driver_data;
> +	perf = READ_ONCE(cpudata->perf);
>  
> -	return sysfs_emit(buf, "%u\n", freq);
> +	return sysfs_emit(buf, "%u\n",
> +			  perf_to_freq(perf, cpudata->nominal_freq, perf.lowest_nonlinear_perf));
>  }
>  
>  /*
> @@ -1095,12 +1113,11 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  					    char *buf)
>  {
> -	u8 perf;
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
>  
> -	perf = READ_ONCE(cpudata->highest_perf);
> +	cpudata = policy->driver_data;
>  
> -	return sysfs_emit(buf, "%u\n", perf);
> +	return sysfs_emit(buf, "%u\n", cpudata->perf.highest_perf);
>  }
>  
>  static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
> @@ -1431,6 +1448,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata;
> +	union perf_cached perf;
>  	struct device *dev;
>  	u64 value;
>  	int ret;
> @@ -1464,8 +1482,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> -	policy->cpuinfo.min_freq = policy->min = perf_to_freq(cpudata, cpudata->lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = perf_to_freq(cpudata, cpudata->highest_perf);
> +	perf = READ_ONCE(cpudata->perf);
> +
> +	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> +							      cpudata->nominal_freq,
> +							      perf.lowest_perf);
> +	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
> +							      cpudata->nominal_freq,
> +							      perf.highest_perf);
> +
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> @@ -1526,6 +1551,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf;
>  	u8 epp;
>  
>  	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> @@ -1536,15 +1562,16 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	else
>  		epp = READ_ONCE(cpudata->epp_cached);
>  
> +	perf = READ_ONCE(cpudata->perf);
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
> -					  cpudata->min_limit_perf,
> -					  cpudata->max_limit_perf,
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf, epp,
> +					  perf.min_limit_perf,
> +					  perf.max_limit_perf,
>  					  policy->boost_enabled);
>  	}
>  
> -	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> -				      cpudata->max_limit_perf, epp, false);
> +	return amd_pstate_update_perf(cpudata, perf.min_limit_perf, 0U,
> +				      perf.max_limit_perf, epp, false);
>  }
>  
>  static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> @@ -1576,20 +1603,18 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 max_perf;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  	int ret;
>  
>  	ret = amd_pstate_cppc_enable(true);
>  	if (ret)
>  		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>  
> -	max_perf = READ_ONCE(cpudata->highest_perf);
> -
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  cpudata->epp_cached,
>  					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> -					  max_perf, policy->boost_enabled);
> +					  perf.highest_perf, policy->boost_enabled);
>  	}
>  
>  	return amd_pstate_epp_update_limit(policy);
> @@ -1613,22 +1638,21 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 min_perf;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
>  
>  	if (cpudata->suspended)
>  		return 0;
>  
> -	min_perf = READ_ONCE(cpudata->lowest_perf);
> -
>  	guard(mutex)(&amd_pstate_limits_lock);
>  
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  AMD_CPPC_EPP_BALANCE_POWERSAVE,
> -					  min_perf, min_perf, policy->boost_enabled);
> +					  perf.lowest_perf, perf.lowest_perf,
> +					  policy->boost_enabled);
>  	}
>  
> -	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
> +	return amd_pstate_update_perf(cpudata, perf.lowest_perf, 0, perf.lowest_perf,
>  				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>  }
>  
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 0149933692458..8421c83c07919 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -13,6 +13,34 @@
>  /*********************************************************************
>   *                        AMD P-state INTERFACE                       *
>   *********************************************************************/
> +
> +/**
> + * union perf_cached - A union to cache performance-related data.
> + * @highest_perf: the maximum performance an individual processor may reach,
> + *		  assuming ideal conditions
> + *		  For platforms that do not support the preferred core feature, the
> + *		  highest_pef may be configured with 166 or 255, to avoid max frequency
> + *		  calculated wrongly. we take the fixed value as the highest_perf.
> + * @nominal_perf: the maximum sustained performance level of the processor,
> + *		  assuming ideal operating conditions
> + * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
> + *			   savings are achieved
> + * @lowest_perf: the absolute lowest performance level of the processor
> + * @min_limit_perf: Cached value of the performance corresponding to policy->min
> + * @max_limit_perf: Cached value of the performance corresponding to policy->max
> + */
> +union perf_cached {
> +	struct {
> +		u8	highest_perf;
> +		u8	nominal_perf;
> +		u8	lowest_nonlinear_perf;
> +		u8	lowest_perf;
> +		u8	min_limit_perf;
> +		u8	max_limit_perf;
> +	};
> +	u64	val;
> +};
> +
>  /**
>   * struct  amd_aperf_mperf
>   * @aperf: actual performance frequency clock count
> @@ -30,20 +58,9 @@ struct amd_aperf_mperf {
>   * @cpu: CPU number
>   * @req: constraint request to apply
>   * @cppc_req_cached: cached performance request hints
> - * @highest_perf: the maximum performance an individual processor may reach,
> - *		  assuming ideal conditions
> - *		  For platforms that do not support the preferred core feature, the
> - *		  highest_pef may be configured with 166 or 255, to avoid max frequency
> - *		  calculated wrongly. we take the fixed value as the highest_perf.
> - * @nominal_perf: the maximum sustained performance level of the processor,
> - *		  assuming ideal operating conditions
> - * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
> - *			   savings are achieved
> - * @lowest_perf: the absolute lowest performance level of the processor
> + * @perf: cached performance-related data
>   * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
>   * 		  priority.
> - * @min_limit_perf: Cached value of the performance corresponding to policy->min
> - * @max_limit_perf: Cached value of the performance corresponding to policy->max
>   * @min_limit_freq: Cached value of policy->min (in khz)
>   * @max_limit_freq: Cached value of policy->max (in khz)
>   * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> @@ -68,13 +85,9 @@ struct amd_cpudata {
>  	struct	freq_qos_request req[2];
>  	u64	cppc_req_cached;
>  
> -	u8	highest_perf;
> -	u8	nominal_perf;
> -	u8	lowest_nonlinear_perf;
> -	u8	lowest_perf;
> +	union perf_cached perf;
> +
>  	u8	prefcore_ranking;
> -	u8	min_limit_perf;
> -	u8	max_limit_perf;
>  	u32	min_limit_freq;
>  	u32	max_limit_freq;
>  	u32	nominal_freq;


