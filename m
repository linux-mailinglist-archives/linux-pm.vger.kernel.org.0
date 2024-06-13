Return-Path: <linux-pm+bounces-9106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F31907A5A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA641C24BBF
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725814B07F;
	Thu, 13 Jun 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e5Dil8ex"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EE14A614;
	Thu, 13 Jun 2024 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301325; cv=fail; b=Wq36z4hCD/Mi/toXXYKwS/tjnKFkxft7p7GlYBr/JIlQ7LyYfZzd3Mg5ojQ9bPz8c/yuNQAushXCt9Kk1IuS9DlbDoFDOHUN1SABtVChgEMaVKbNxNqgZN5G7Nc27yX91Xp1eI3fSZmV8XnDaLkNXlKXEdC6aDG6dOf8TCXesC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301325; c=relaxed/simple;
	bh=3W2vtIXyu/QdgUFhiCzn0vZ37MRWTO67h2oeZI+VXZA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arAiPn8LJuKLUQXVJrVbsRpto9LAQtc8KVNWYqW8qJuq95SXO7c3J9SJswWeJb/44Qzt0ls0S+eRJe966NQT57FrUXZGaFKsJVko9G2pkdRdl7UgMDnELY5TpQV3LLrJW2P6wJq6bqNRDrRz/Ue2quE6EgLmRFfoC7pcBJ7V3u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e5Dil8ex; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJWkjQlPX5/DA/VZSiRNtZqAA27zQOXBMEEwB29pkqKdopnTcP+/gTtn9uxYU7dd+Kp2kS6EFRw4JpWMJ2ta1oeCFE42oVyf5n058MyuFTDU9z3uQns0+fuvohxJxmq4OCNzlLX8syGBLANLyQy1U/zlGrK9PafhPmZYqAdB2nAshfP1UV2XRqRi3FatSgpRoMu4tluc3wwnNS4OxCVeOOTmSXRJdqrzU5S7CHTJ4BOohEv9TlPwRAcwLSCymx45Fk13oUGuh3upqKP5v6c29f0c8ahHW4TRRyq12qvI+X5pvMZZFDlTT7M+KchhZ5GlTSylhCe8I11P/ejUKUO9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCULysYhlmYdDA3e42VHJ61roaMUtlHUHSGizHNNH7A=;
 b=g58nVWM819o+07uN6sVy/oXmF1YNQmCXp9LsR5WDCKMjYKlNLkIRakyZko6AkKuBdZi52hA58ilKYc3rN8k88y3cKiutjl5a+ChBJL+MnCSZ+GLNd3x9bwq2BKpSpcoNuIBa9fUPvTvGTcvm3/Hv3eTT8mkh+2FMAdrVX7OwR+1EBXF1YR7QtHvvXgX1/sT/qh1K/L/DRI0xhKx8JkvPglquXVDS4C371du4NVc6GB7CbESFRA5VflMUJcdDvQiv67co9KmmQzKsLCM2LrAbYmh4mEt7+tEioY9ZdJzRNNw+G61Moti7jlOTp35W6roTtIovUWRgdKpxwTXuAckuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCULysYhlmYdDA3e42VHJ61roaMUtlHUHSGizHNNH7A=;
 b=e5Dil8exAdGzvBV9pGRPJVLKMKXf/zFF1bVO/hAuX2purW0yvPtjkE7b++m2nihjHcH8PYIKWJFflQS7DgPlfNbJJQfEyGt5z9R/QxoA/fVbh5lWOmZahssi6h5cTn53mtJtyWY7kWhOFtchy3ja0tHVSHOrqh74rZN+NFcUXQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 17:55:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:55:21 +0000
Message-ID: <cc26e5fd-ee67-4720-bc58-322fa1ed0329@amd.com>
Date: Thu, 13 Jun 2024 12:55:20 -0500
User-Agent: Mozilla Thunderbird
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 3/9] cpufreq: introduce init_boost callback to
 initialize boost state for pstate drivers
To: Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
 Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718262992.git.perry.yuan@amd.com>
 <688d8e1ce875655c344ac3b29876da5dc0456739.1718262992.git.perry.yuan@amd.com>
Content-Language: en-US
In-Reply-To: <688d8e1ce875655c344ac3b29876da5dc0456739.1718262992.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0126.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c618c9-fed1-4a73-281e-08dc8bd1fe78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW9EbWJ4anBWU2F4bzR3Y2cvbFNQSlhkQS9XR2VuZlVaeUVkdWFoaSt0TEdx?=
 =?utf-8?B?MFF1MlhHUFd5M1BUOG5OeGJXTnJoalVzYTBPaWYvcG5zRkw4U2tyalpkRXNo?=
 =?utf-8?B?b083azhCdFVZNzJRaE1TVUhibDNHQjdOUmNqMmVEdklRM09QVklhTHg0SzJz?=
 =?utf-8?B?VXF4aExCVFBXeWU5THZ4blJQeDIxYWd5ckt6YW9aQUQ4MEVzWVNzYUVpMzVZ?=
 =?utf-8?B?eFF0KzVuRkdHVXBSVmhXeDA2QTBJTVFReENVaHVHayt2aVN2TTRuL3hadk9N?=
 =?utf-8?B?RGVtN2xmV1FZQ05BdFJYb2JGZE8zaVI2bW9kNyt0dmlJbjZRNE82KzdCRDZO?=
 =?utf-8?B?UHBYWHF4Tm9DdnhFemVqbWNuMDBjUkFPK3lXTDdpY1MrZTJ3VEFGT0FiNWJo?=
 =?utf-8?B?U3ZZWUEvVEJYODNuMFp5eW5kQzJ3VERVYnRDTGVRRDFIeGdaRzF1Q1dWek5F?=
 =?utf-8?B?c1NINkFmMU8xMlBsRmQzbTI0OFkvQkFHTHdGVTB3SkU0SEorQ2VLZm9vMnFK?=
 =?utf-8?B?Qkg1dXFkaStadEhBUUJrdS9weGVvbnY5TXNsME9xSzdsY3lOMWFGUEhrOTVt?=
 =?utf-8?B?NzR2SUFteXRlWEduMHk5RVdpKzZ1Wkg4TTBWYUpsMjd0NHlSdWNmWFo0VXE3?=
 =?utf-8?B?bzZuV0p3Yzc4YUtFUlQreUN2dllNTWRaeDZLSDNLQitEalJrS3pLVDZEQits?=
 =?utf-8?B?dTNsTGJZZktIUkhLZTVpc0FXbGdWTnNzK1J3U1lKVVlVMkFaMUkxOCtUYlcx?=
 =?utf-8?B?TmxjZ1ExVG15cHdCaHR3Ym8rQVlHV1FXa1Q3U0ZBbitJUVkvSG5hRkNpbGVw?=
 =?utf-8?B?REtyYzdOQWlnbk03ckhqR1pIVDRqd3dac2tFMld3Y2s0WWlKcUo3T1dTbElk?=
 =?utf-8?B?RkF4SXFsN1ErK1QwZ1ZodnpQSzJsbWE2MlJ1ZmFnd3NDRFNWRmM5NHJXbTdx?=
 =?utf-8?B?WlhFZUk4Wmc0WEhKUXc4S2dIR1gyV2RHU0hhUkhzU01xL1VTZXVWWEdnb0Vp?=
 =?utf-8?B?N2JuaEVpVCt6M0ZmTXBPd2xqSVZjZlY4cWxuTWZkck1ROEZhY3U4NVl2L201?=
 =?utf-8?B?N05uVXlzelRscmNWaVBrVE9IQVNuSGNia0RFQWFucmYzbjRtMHpneW5xL2lp?=
 =?utf-8?B?Qnd4RllIaHlnbkxmMzZ6andnWW1kakpHZTkxQnc4U0IvNnRWT1BoWlZVSGs2?=
 =?utf-8?B?SHd5ZDJ6QjU0L2tiZXpmeWV2cHBqRGMxSVFNZVBiQko5ZXZaNlpZMjVTZlR1?=
 =?utf-8?B?QXdpbnZtMHJneHpuQjZlczVkdWZjdk8zU3lkWHltdDhXSW9lZU5IWGw1NHZ5?=
 =?utf-8?B?eFZuc3pXcWlacXZKTDVQWmhSSGlzdjY3cVFFZGJVRUVKMVBBQVNsTEhDcjdJ?=
 =?utf-8?B?ck5QZjRIWjMvTEd0cWV5RFk4bVVUNVVscllxdERHRmhaak1GYzlWc0QwdUZS?=
 =?utf-8?B?SzVESUxBeEhJVVRXQXptTitaWFJRTTM5VHlOOTY3aGVXZ25hdWcwaVJyTWRu?=
 =?utf-8?B?dDJ1aHBYMktlTEJ2dEIyTThVNU1EQVBlUHdGM0R1aUhoMFZIY2VMMUlUQ2k2?=
 =?utf-8?B?ZXJ5b09sWllMNzNQaWdZSS9tUmRKVllnbDhGcFJYZ3JTaGVUbk9PN09wM0sz?=
 =?utf-8?B?a3YyQ1ZoMGtVcjFDc1RYQjNLaXpURG84aXNycnNKdDV6TVlya081RDNzODlx?=
 =?utf-8?B?cThuN0xyaUo1V2pqNjR6RzBKcUJjNXJkbmg0V0d5aWFGRzllOHdHbjkxTURV?=
 =?utf-8?Q?IRaK2LQpOGXmtvPj5DboNHmAzFGD5JDyK59RIiB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UURab1BITUs3S3JZZ1p6N2FLWGtqYUs2UzE0OEU1MmVDT1ZUZ1pRQUlDNlVG?=
 =?utf-8?B?VDROZG02VWhHMXI3REdsNnEwZ0VYa1JHS3BEbkE2OUJjbm45d0tneUVHQTFT?=
 =?utf-8?B?ZHdrS2daUW9xWXZqZXE0c0k3VzdaMHdwYzlGWSt2OVdGcWlUbVVUcm15Vlgy?=
 =?utf-8?B?R3dXMVV3UCtVWVptbUtRejRidE9KZnk0b1VkMkdkL09hYWVGSVRKdHkxMDZ4?=
 =?utf-8?B?enVSWmViL2R1Z3ZvWGhvRnNiUGFPSitWN0I1Z0pmTVIwT3lJYk5EekY2Y3I0?=
 =?utf-8?B?MHdmTCtCNjMyUDFqNTlRZ0ROZlF0QVp3bzlwcGpPQUhwdklrMElDb0FpTllJ?=
 =?utf-8?B?b1hvNURXcmcyRUxNeUh4OVFmTkd6ZVcrN09qSjUvSlpxKzJscm9TQjhaSjQy?=
 =?utf-8?B?UTBwUytxMVJlVUowRGdzZ3VnWitVZXRiUXMwcWY4MjBUcFR1WFZUT2hmWmxh?=
 =?utf-8?B?OHB4UStlMDZGeGJYU0djZis0dkhnZVhVaFhFaEMzQks5N0xZY294ZUhabmdO?=
 =?utf-8?B?U3IyUU44SCtFUWdRYzV4c2VxMWFUb3RVOTAyUWZZLyt6dzN4cXZZWTA1YTFE?=
 =?utf-8?B?U0JpT0FIM29pWUNvdXFuNE1hSyt4V1E4MmZUSXJGL2UvblpBMWtqUzVhb1lq?=
 =?utf-8?B?MTBseHFVRjV4N3hOdnRmc3oxM004LzFxMXZ4WWUzbWQvVFFLZ1VUanllZTZC?=
 =?utf-8?B?T1FGamgrWTAybDN5M2RkaXliRTErYnFWUUk5UU9UN29sR2tmaWtZUTVxeTJR?=
 =?utf-8?B?RTFBdnU2Z3REWVowKzUzcW01TTdoY0sreitNYXdIME9IdzRyU0lIa0R0V1lW?=
 =?utf-8?B?dHJOTnFWZlBoY2hnSEw0d2UxeHM5UmZiVGxhbUc3U2ZoWUVxSVEweTQ3RWdx?=
 =?utf-8?B?YmFGNURSR1FZSlo2MDNQaDgxcEhrYzNhVGFYeFg3RUJyanVUdlMyRWR3aG5n?=
 =?utf-8?B?VVBFSUs2QU5ZQkpKaGI3bnVXUlVhL29hQld4dlEzKzRaUzE4N2x6NFNLWWsx?=
 =?utf-8?B?cHY1cnkwQkx5MWFteE40cnJXQk9SM3pXNTZpOUk4eFNqRkRPWXRnalFuays5?=
 =?utf-8?B?N1pnYU4veWVXbFl3MkRqN05FWmYwWWZzL0p4V08xK1YvU01JN3g0V0pxNzMv?=
 =?utf-8?B?WXIxTkdkRU1QN0FiOTJVTmZmMG15WUl6QjBzSWVZMUg3TXBFZ0RKM1QxZGNR?=
 =?utf-8?B?WDB5ZS9HazloRkJkczR1SFdTVjkzRjUxSkxaVEUzWE42ZUoybWJmVjRmQmVP?=
 =?utf-8?B?Mk03K09RL2ZnSE9XK2FrNHdRRlcvaXVXZW5sWVVZRVRWbm9JbUxlNys5WTBE?=
 =?utf-8?B?QmIzTk9jQlRMTm9yWWpQdmFMN201QU1QS1h1OHQvaWNGR2NDOTQyZEFOQzVv?=
 =?utf-8?B?ZzhrWjEzWWlYMnd3RjdxS2FPNUY0YS8rUEgvTlB2eCtwaE5SZkdYc0dpVzFZ?=
 =?utf-8?B?R0tSdzM4dklGZGRObHJDSWRBQ3RWcTFjOTZ2amxHN2RCM1drVGhXbk9JVWxI?=
 =?utf-8?B?cGxubTl6TW1VaXZjbFJrZGlGM2dWQUlEc3ZNeXhQZUcvYUhUQnhFQk1jUlUy?=
 =?utf-8?B?QzRqbnBudFgwK2FTcExRdDZRcHViK3NidmxVU0g4U2ovc3ZjcFh1VzdoTjVz?=
 =?utf-8?B?VEVDK0xDb2NWbnNpaENuamJJOHltOXlhYzVOR1dBbEViWWJQRFpVWXhaRmFP?=
 =?utf-8?B?eWlSUzZmZHRtTDlnOHl3NTJKSHBJdG9EbVVpTU5pNTdlUHBPMStmcEYxUGcr?=
 =?utf-8?B?VlVWV1kzV3hmSjNPNzY3bnRUQm9YNnpmR0MrMUVWeHR3a1hDSnhmKzhNQ2FZ?=
 =?utf-8?B?QnN5bXI0N1IxTk9iQ1RkWUxTRGlzUWRBMDU3MUptSHFmcTJCSWZvbndqaHpq?=
 =?utf-8?B?QWxHVVRjSjVHZGJ0SU9icWI5bnNZS2w0dXZ6ZU8wYzlzU2labUhTdlBHSkdw?=
 =?utf-8?B?YUYvRUdLNkUzTkZFMDlQOU93Skw3ZnRQeU41YjBUSDdPZ0xLcTY0U2RTMXdK?=
 =?utf-8?B?Y2FqUjI4Ny94cXdlWjlXQ0RXV2l1dXVXdjJFTzYzOWtLbVJTTVRvQ2Y3N2JI?=
 =?utf-8?B?R0l1TDlzZUxIZmhVbW9yczA2MlhBcXZmOHZwdUNycFMwUkhjNG1zZ1lvRmQ5?=
 =?utf-8?Q?XFUuY3qxzsK7RJvLP+Ha/CvE+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c618c9-fed1-4a73-281e-08dc8bd1fe78
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:55:21.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZug2hbrv9My7BRrftMXVF19WQ4eEWxIF1e3RF7bBCiDBX+wN8QNMftgnjsobyjDhruXKXzy+bqgYzeDvTWeSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074

On 6/13/2024 02:25, Perry Yuan wrote:
> Introduce a new init_boost callback in cpufreq to initialize the boost
> state for specific pstate drivers. This initialization is required before
> calling the set_boost interface for each CPU.
> 
> The init_boost callback will set up and synchronize each CPU's current
> boost state before invoking the set_boost function. Without this step,
> the boost state may be inconsistent across CPUs.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/cpufreq.c | 12 ++++++++++--
>   include/linux/cpufreq.h   |  2 ++
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..e1a4730f4f8c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1429,8 +1429,16 @@ static int cpufreq_online(unsigned int cpu)
>   			goto out_free_policy;
>   		}
>   
> -		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		/* init boost state to prepare set_boost callback for each CPU */
> +		if (cpufreq_driver->init_boost) {
> +			ret = cpufreq_driver->init_boost(policy);
> +			if (ret)
> +				pr_debug("%s: %d: initialization boost failed\n", __func__,
> +					__LINE__);

The message should have the subject at the beginning.  IE:

"boost initialization failed\n"

Also, isn't this fatal if init failed?  IE shouldn't failing have a:

	goto out_free_policy;

> +		} else {
> +			/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		}
>   
>   		/*
>   		 * The initialization has succeeded and the policy is online.
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 20f7e98ee8af..0698c0292d8f 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -409,6 +409,8 @@ struct cpufreq_driver {
>   	bool		boost_enabled;
>   	int		(*set_boost)(struct cpufreq_policy *policy, int state);
>   
> +	/* initialize boost state to be consistent before calling set_boost */
> +	int		(*init_boost)(struct cpufreq_policy *policy);
>   	/*
>   	 * Set by drivers that want to register with the energy model after the
>   	 * policy is properly initialized, but before the governor is started.


