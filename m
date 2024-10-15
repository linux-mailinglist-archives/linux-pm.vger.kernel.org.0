Return-Path: <linux-pm+bounces-15641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6C99E23D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 11:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7233D281797
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465151D12FE;
	Tue, 15 Oct 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fzt3LlLL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAC1CF7AA;
	Tue, 15 Oct 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983251; cv=fail; b=YwMZVzBF3NTwGmktSXDMuWgWGzbjCqCCvi8tuuXoEMKZLTrt7kFTlZmqJV0HjTAn5PJsHItlOH/CV5ud/Mj6i8SnTx19DE4/9wee01RotsDwU2gCH5/A5c1wV9M02EFfkpWfSecsiT2jn4DXj9zStYTRNF9IHdUrKmDgpOCf3p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983251; c=relaxed/simple;
	bh=qePJD/WS799IFmWEicHCV2oRabH10V//R3Q+ZOV52qs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pHHST0Bnho9blG9NXwzKWtSn/QPfb7V3gZuBAz4NgMRyi1blO2P2WGeI1Giy2KGbi8U1UoqmF5z0xFXNiGP+kNgu19rlKmHAFPJ0CwoSloGsv9sevPO5eBRO9PaVIrLo6h7oqPoc0P25cF+0LXNQ1zyTTNGlh8YAyleuEDjtM3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fzt3LlLL; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKulEZ9p8tq1orqesL6bA5QoABsyVP/CI/0pSWMGMRvI2/QVTIkvCwzYZBKtvkKeU5JjcuV/Rj8jgBokQLQyBfIUll/cXQ8ZVNssTbDnKz3zF+Nft+1KrFlXxk+uane55nuf+NUkQmeECi651DSsZukkmQDaBiTUqnt1y6VMU3CyAyPVeMrgwyy2oIj2438Gbv/25rCe02gtyoM8gj4cQXxekYmHs/pVjlVZvcBeNA5ZvX/FdbvHKgWeS15ifRgszhMqz0GOuZnUcz/KeToQYGS09MYPjYBbTBaHvq2YYGsPPsP8gjI3HrNrHqAjiGh0fEGdner6DSRiI6rrxgMAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG1Rb5+M5jVbvdsqO7BqEvrzqO4lZFdFRPE13aN3J+4=;
 b=hsytA0wQrfPFEol9fvXM0amQt4IKmIiyS+VNGp/Yg+wpmbq5gAE4e8B1w469Rg7GyoaZMRV1RSGDkdjE1u0Zy/L78CLVXcL7YWrBA8LoPD3lefHuyXFzYeTY3vzWK+m1ZG3ItPqfAcy1Bo+iJZKhMNN+wYyesYM55pLJMpCFJ73YFGQPRP3OcqItjc51NwMNvtuB+Ay05+OT6hzUkiHbDbAobPGE6HDCGGvBA7TXAIf5lKFnCt4S30Qd2jD6deeQJqwlbg63yldzqOQmv4wCOyy6umna8+kTecYzZSJxi2dsFSJNZXKSEarBzm1QGb2i4AVk7KPbAkoQwVv3MiHNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG1Rb5+M5jVbvdsqO7BqEvrzqO4lZFdFRPE13aN3J+4=;
 b=fzt3LlLLbL0YW7YGm0WP2JndT2VCQbhZgIk7ROjdZwOfeBQEVWEF9HxfpVlefLJpaNzyAOs9Dxz3s4o9ebmOt10ijobOezErbA40FoPXb0MYbf4Gxtb1eBoLPiRlR+1v7yKzNwyg7vEpBwmpbFkIi//kIM3f2tVq1qFZjoC1N2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:07:23 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Tue, 15 Oct 2024
 09:07:23 +0000
Message-ID: <adf0c052-81f9-4a7f-939a-8a6f553721ca@amd.com>
Date: Tue, 15 Oct 2024 14:37:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpufreq/amd-pstate: Drop needless EPP initialization
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241012174519.897-1-mario.limonciello@amd.com>
 <20241012174519.897-4-mario.limonciello@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241012174519.897-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::34) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: e28ef1f0-26c0-464b-1a86-08dcecf8c7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVhaeVBvSXo1ZXhVYmxXMjBPaVh0T25KU0VESUc4ZFYyYjdHT3Ayb1NLN2p4?=
 =?utf-8?B?RHlpMWdYKy9LZWVGbzlGQzZsM2VPMjhQaGVrRDlkU29ndCs4dFdtWW40Rmhn?=
 =?utf-8?B?ZnBRTmRLdXYwSUU0ZERxVUtzQ2VZRThYeEpaZllNdGRMampxdExIQUdvLytp?=
 =?utf-8?B?NXp2U1hXOUxmQ0Q1WUhEK3prSUxBWXJsMUlXZ0VNc3BwSGpmUk9XaTRGLzZm?=
 =?utf-8?B?Rzd5NCtISXQyakxpZkg2aElzMWJqQWlRUjZFTlJpZXhtTGhrQ3YyV2R5S2RE?=
 =?utf-8?B?NjJrYlBrUGtrbVhIWEppKzFlUUI1cVVURkQxSmN4SDdZZHY5dlhxcElBVk1N?=
 =?utf-8?B?a1dZSDlyU2tJZEY5WXJKaGlOdnJOOWpMQm9tWmIwc29sb2R6aW42K0FXbVlU?=
 =?utf-8?B?SWhLT0QzQk1kUFg5Mk9VbUtpZE9IVmNBOVdxK2tFS3hhSTNDOFkwci8wYTNZ?=
 =?utf-8?B?T0JqNXdqZjhXTWR0M28zS1YvejN2T2FSN24xS2ZGZVlLdElPNmUrd2UyQXox?=
 =?utf-8?B?S0VuOGRlODBjVEFlODR6eDdrM2JhTmRCbWRxemJ6Q28zT3gxdHB2WTFJRks2?=
 =?utf-8?B?Tjl4ZGZ0SjJOeGttUW5EcHMzR3RWTmFUbU5JVTJ4WGhQSkFLNHNOTVovYi82?=
 =?utf-8?B?SFJPTzlLc1VLdWtKVExyKzczQy9JVkhUbjV0N0x5eUFUdjNES0RzWE8wR2hS?=
 =?utf-8?B?SUpXSlc5V0RuY1hscUNEbWIyeTZtYUF3YWJrUTBiMjd0K2ljcm1rd3FZR24y?=
 =?utf-8?B?NXUrRVVBZ05DdjRpM3V1d2xkUTVhem9hMXZCNVA5QmVFN3lhb0hOUWI2bHZD?=
 =?utf-8?B?MkVpMlM3alpBc3d0alFhd09tMnZBRlRaU0ZORkZyWTViYk1xcmJMKzJxMytx?=
 =?utf-8?B?WWRsVUVJV29jWE5hVnZZcXQydG92U2pjZDgzUzBCR2ovVXByK0I1NzJVSEVu?=
 =?utf-8?B?dFhiOWRtRUJtU0ZUdUlPV29Eai9EWUJ0L0tWb3NLTFpYQmlVdUJScDFrYkVo?=
 =?utf-8?B?UUNHY3lBUjljcHZxL3NYNWxCRnVKNnFWMkh3UklPcVQxSDFEWXI3VWJYRlIx?=
 =?utf-8?B?SHI0SzhkbUY3VThYNENTWWF1RmZOUVg4QmhTakRZUnFDQjdCaXYzNmoxWHBN?=
 =?utf-8?B?SlJLNFRGa2tQYmRCUXd5NGIzZzdxWXpUNjhZS1hQNTRnbU1DSG0vQy8rWm1w?=
 =?utf-8?B?WkxxbWtVQnkremkvejlmOGVzM2lBTXlKUlRSZmhUeVRCdWJNUEtpK3MyazA2?=
 =?utf-8?B?dWp0QVZWNlhRNHdvM3lhdWFUMjF5WHA2Y25GMU9hNnZ1SHo5SXJmcWhpNHEv?=
 =?utf-8?B?MCtFTWIvSHducWZ1NVcrZkZFK3VOWExScC9QVCtkWjVvTzFvQkRld0xrUFZH?=
 =?utf-8?B?bmY3UWUyNVZWeng1Z211UW9Qa3NKMkgvdzhieUtaeFRpUkZWNnIvSmFTeFFz?=
 =?utf-8?B?bFpWanlRU1pVbEVQVFQ4eWtkWnpFMkVzeW1yRXdMQUNrN05CMjBxd3RmamE0?=
 =?utf-8?B?MitLaUFuQVJmbWZvOEpKOTdlc1NTUEZ5b0JpWERYRG14TUUzZk1mcnNRTGQ2?=
 =?utf-8?B?eWNYSTRXTmo4VGFEc2Eva2lGM0hPelIwR1pOR3NuY3k3RitGSDh3YlF5YmpP?=
 =?utf-8?B?Z3hZWGVPTmpHSXd1NEtNT21DNkQ0S1dtaW5lY2lTWndoQ0tLa1ZLSzV3T3JW?=
 =?utf-8?B?dHBiTVZ0U3lTRzluWVBUaE45a0dObFdwSzRmODE0cjRmMFNzOHZPR2t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1c5OG1tTlJodnhoSXdQUWRJZVVZSkJzQk5IdEhJQVBpcFJ5Q3JNRy8rWmtD?=
 =?utf-8?B?Mm1iTDhIYjUyam9aZk9LK25YMENyRzhZMmQzTlArbC9hSFdDd3JROFQyVlp3?=
 =?utf-8?B?S2VLUWJuSjl6cW1YbDlZWHVCaGFVaVdRTXNlcWhKREtmenVRNHo4ZHY0MkFZ?=
 =?utf-8?B?LzJ0MXRlM3Z1cE96c2o2cDl2UUVnektNR1BDaUQveFdhenVRLzZacEpUenZu?=
 =?utf-8?B?b2dzTDJKS1cvU2luNDRrRTkxVnlXcUgxdi9oeFcxWHBncUJHTUNpSkdJRCtz?=
 =?utf-8?B?bk9zT09rbjRGc3JraklrWmZpNmFtY2lLbGJqV244eDZ6NVBTSGxyYzhXaHhY?=
 =?utf-8?B?RHRaMHUrQ081VnBadXNqVmsrb0NxSS95Sk1wMVd3MEhwRVhVSEJDR082ZGRh?=
 =?utf-8?B?eHdNdFFHRVRSNE1idENXN3VLQ3V6V0owcnNOSGIvZDlqak9VTnNHNU1nU3No?=
 =?utf-8?B?S2gvb1lGenNTYUVIVlhGS0YrdjNLRkZHQ0pMYXhBZnRpZkRHL3FqRHduM0VE?=
 =?utf-8?B?bGJTMWxRZlFYdWNHM0xIcEVadDN2VVMva0N3ZWFaQ0tpUUR5emFyQkVRZmV6?=
 =?utf-8?B?Z0RPQ05lcnhnd3pFeFp3R2pCblJMMHdpUGdBTjNnUlVubHRVOVJtajErUFg5?=
 =?utf-8?B?S1FQTkxwZ1NlNGhQVE9GOHZURVNjbWlUYWtIR2NIbTRzNit2NFV0MkpncDFS?=
 =?utf-8?B?UTNhbytheWZOTVBkV0pIWnY3dVZxb09kYy91SVpGeVRhYUJyNEV5ZnhEeHlj?=
 =?utf-8?B?bTUwdVJJSGRNS0orMDkxcjlQcDlzTUkvZWx2NlRxNzlpb0g4UFhsc1o0U0RL?=
 =?utf-8?B?YTAyeWRSQUlpV2tWZGZ1aE5mVTNzR2hhdFQ1aUFqOXVqUjQxZmpQMW9VSWN0?=
 =?utf-8?B?UWZoVk56Z05aTEhUY0R0V3FpZDExaVFPaEs0SmkvQ2MxOWlpV3JvdXFzRWFs?=
 =?utf-8?B?b0lXc055Rk5CS004SnpwYktsNUtBU3N3aVdKQjU4c2ZzdlYySjlXNEVOK2dL?=
 =?utf-8?B?QW5ScXFVMS9Vd2p6UkVMd0xQR1l3NC9VSFJNb0ZXN0Y4d1ZMU25LdmRHNUpM?=
 =?utf-8?B?b2VaQWZaQXZRaWVEMlhibkFkMUpuSnprOURqemxsVFMyOFhUbGgvMUF6N0V2?=
 =?utf-8?B?QUxnNUcxS3J6bzFvc2ZyWnIzTXNuZWIrckN0UTI1cUEzdTFBSWhYYVJLMmRW?=
 =?utf-8?B?TzNYcmUwRzRzcjhCQ1JWNHBGdTdOSDlTK1lYcDBRaURJWnV2aXFJdXFYWmJI?=
 =?utf-8?B?STZSY0pyd2pwNmIrYlZpbkw3b0d2S0tRR1JvMnBzMlFtbkgyeTh1eXNIbnZp?=
 =?utf-8?B?WU5mMkRMOEd1Q2N2cEtYQkxSMDczWG5GVUdBcS9VaDl4Z1orNTVFMzlhNUpW?=
 =?utf-8?B?L0hTK3JIQXAyUEp2eUxwNHJMN01KUzZ2bStlcU1LTGpod2hETU9GTGk1LzBt?=
 =?utf-8?B?aEwxOTJJU01ybU5XVDN6Q1J4d0w0Wnh3WmpwWEp0cnAvWExvek5NamV4ZGhG?=
 =?utf-8?B?OXJFUzhhMmJDRkJELzVqVk1ONWF0N3I3N25uOXNPTG1OTHVMektNWVU0RVk5?=
 =?utf-8?B?U1g5OFFlVktiQXJ4RjlvR0ltVXdQRzZtWVNWUVBVYzU2SlJNN0MwNEJBSVM2?=
 =?utf-8?B?bkVSWmIwL1JNeUlwOFlPUmU5b2dMSjdNWEFWNy9RdTkwK1dFOXMydVBKdHVM?=
 =?utf-8?B?Q2FiM2lRQWo5Qy95YU9xeWhiV25SalEwYlgrSXhaMXVucmZ6TzV5ZVVVRkRT?=
 =?utf-8?B?SnNTbHlkVjc4VmRRVUoxSDh5bWZWd082dnF1RVhFMFdpMHdrQTNsOWRnemJu?=
 =?utf-8?B?M2RjRVNHc0JTYXNNQ01EOVFDVDNLdmcvc2g0Vm91d21lL0FnNThIN2pvSjZs?=
 =?utf-8?B?UmdHM2lEbzdhMzVhdHRtazM4NndhZktPM1FJOGV6MGg2WTNQZHhrQXorMFFW?=
 =?utf-8?B?anRnYVduVS9McmxHTkRLRmF6YkJEY3BmT09YQmpJRlJCV3RYT2lxSUg5aDBS?=
 =?utf-8?B?QzlMeDE0cUhaZW0xZWdTY3o0T2JJUmVtWEt4VGhSNHBjQ2dHNkVjU1Zib0N2?=
 =?utf-8?B?NkhhMkVIdHhKWSs2Z2xxZmtlVzkwWU1WYzdXcENMSDRWbExYN1pmK3JxM2tV?=
 =?utf-8?Q?HCDhMs3gEffQd2LXLNI+Yd551?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28ef1f0-26c0-464b-1a86-08dcecf8c7b3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:07:22.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gv+SVxTF7j89HYtzSmgurP+4BG6WolymDdKT9if6MuNtnPPYktAE6A2+Wxuu7CNChNGwfVBDyAYkNddx8X28A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

Hello Mario,

On 10/12/2024 11:15 PM, Mario Limonciello wrote:
> The EPP value doesn't need to be cached to the CPPC request in
> amd_pstate_epp_update_limit() because it's passed as an argument
> at the end to amd_pstate_set_epp() and stored at that time.
> 

Tested this on an AMD Zen4 EPYC server system, ran some sanity tests, 
both modes (active and passive) seem to be working fine with the boost 
disabled and enabled.

You may add,
Tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Regards,
Dhananjay

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8d2541f2c74b..90868c8b214e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1528,12 +1528,6 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		epp = 0;
>  
> -	/* Set initial EPP value */
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		value &= ~GENMASK_ULL(31, 24);
> -		value |= (u64)epp << 24;
> -	}
> -
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  	return amd_pstate_set_epp(cpudata, epp);
>  }

