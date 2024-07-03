Return-Path: <linux-pm+bounces-10483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E7C9253B3
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 08:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E1E1C23F4B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 06:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5B130A68;
	Wed,  3 Jul 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HxItF8eO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA121DA336;
	Wed,  3 Jul 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719988289; cv=fail; b=df/ZwazWZT1gsTJRjGoi3hvbgQ5hf+jqn4jySXXyDD/yx0suiOiwZNVA0Hl0t9ChoqBM8V0sit7ODZXZe4WbMwL2DWkmhvsCOSZ9/ly+h+zoupudLMNB795sg/0ZmajMkGqTVyC+ga9uhT6Qo0VShrJTLXsN32ui0k92fN6qtCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719988289; c=relaxed/simple;
	bh=koaYCl4HG58p6B1p1at1IwFHw9OzY1xHfxjz2LhdW4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p0pbLbnNbHjAlPkX0BoZ0URxkPEV2Xjn+IBiX2JDTgIILLaby0XuwQ+pzSKZP9090J1/bwnpZ5Cmc0lyxF+vBxA8q8MUJvT2X5w8RYoTOo9/kX7azc5kkXedPXLAiV+opGm2dEb+xXvqfi+vPLmMHAwnC6xOSzozJq/AdCvokUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HxItF8eO; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnsg+hVcArA4Jd5L8jvSn7EanxodW2Sy1uL3DqkTN/spORt73JxjIpLBLxpAPjKu3comqr6WTqzy0gH/7ddd4oZn+SUVclG5bLOQCr2z9H68HKHVTiAum+ub4pwnbVLZzgkYFxDTcdLDVmKi8pMdvXDEv6orSn0sXcAvhB/co6A7AD7bbRlXtav4xIqJW1j3yPFDUexhPJfDTONOQGku8gaFcbbjM3kOP/fIiZt0Ue/vRs0pwABEw9hcryho+ggqtyx1ZiWmfdmNrqLsAuD9kDHrSSWWtJtDUgaeCeeloec7cR/OAcGQlLu3F+o42mpGmX5xP0KOuCeN9tqtlQaYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru09ClkvcenfdEXRYaoz0nnuCNlNx0dxqo1vRbHSSgA=;
 b=ThVgfzV/z98C6JVDs4Vrdqllsz8h0AjG3796cnfUzLPOlbMt9cceVgTKI4nEqk1KgCIMBcFP4jX0SMLtvshZGsIl5G5IOjd3VDAFULU7NM5Tgb/GePIN1upoMtKKhxBtf5nIiwvwzB0A3A3gNApXyajPQ2MZvI70D7j74HDSmuLOw61ck/3xyd4VRwBxHY1eEIPL2BxQPYKNO58eMVxqQMhHUcAb6tQH7U/6bWAnJC9eUDzWRRwqtMGYvf1uK5rYGpDJLCXhycws/eduQR9hUzRcoHhhHGNNlBkMW6dNHgBTr7FZ6IVSch4eSiVBPnq7y7X3XrxJ70/9CrAN/RBCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru09ClkvcenfdEXRYaoz0nnuCNlNx0dxqo1vRbHSSgA=;
 b=HxItF8eOb5LG+cqNKX8IAXLuTm3JiCym7pySkcK3P6dpx4RkcUQCWnO5Do299z7iKgSytSzDKWQPeEB+iC8ZcCq+rjFXgzuaw/uHFfU6+P2RKKNHdztCx9kIg1F1Nw4omFShLsQCqVIbE97aaMdlpl2h6SQ/hDMQc79qBkYaC5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Wed, 3 Jul
 2024 06:31:23 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 06:31:23 +0000
Message-ID: <9f99286e-b840-4c50-8ff4-a25f2d2fdc67@amd.com>
Date: Wed, 3 Jul 2024 12:01:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable names
 to *_pkg*
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "namhyung@kernel.org"
 <namhyung@kernel.org>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-9-Dhananjay.Ugwekar@amd.com>
 <20240701130845.GI20127@noisy.programming.kicks-ass.net>
 <477c33a2949793d2a8692c925179bc4f1feb7942.camel@intel.com>
 <35ab02da-861a-4271-986f-f4271637f5fc@amd.com>
 <738e2dcc26926ce948bc7647cf17d83ed5d637b7.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <738e2dcc26926ce948bc7647cf17d83ed5d637b7.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: aabb6d97-c56d-4eb6-0ca6-08dc9b29c224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGRJNXJ2MVNKek1oNHBDM3N1dWZMcjdXUCtJeExwOWhWT1hpZHA3b1MwdFJr?=
 =?utf-8?B?b0N6SHFVSk9MNzVlMzV2WFhTUnFSV3BCOEQ2TU9nbk0zUHVvLzdVNUd5RVRD?=
 =?utf-8?B?YUxlT1RJb1ljZGdJT2p2WU5KNlc2b05MVENoV3MzbktTWmRrcWJDVHlqSFN0?=
 =?utf-8?B?V3pyRmMySFQ4bFY4VjljRy8yMHJ5SnUyNFZjYW90dWVjVVZ0dFkzWms0NDBi?=
 =?utf-8?B?TnJwSDZ3UHVmaXVHV00yeXkrKzlWbkdncFNPRldTMHY1U3lpUHhFaEttSmlR?=
 =?utf-8?B?UXlYUHZXMDkzakFzOWU0VEJ0YjBQOTlqVEpFOFBPWnJscy9ENWdPZWNaMW5B?=
 =?utf-8?B?OXRjWWZUNXRueGN2V1pVYXkzd1JiS1lTbzJ0T3p6ejRVaE1CdFhadVpkR01m?=
 =?utf-8?B?cS9VUm9DLzNkWlMwTXRDL3ZQd3BNRjZkNEpBWFcxZDljcEcyQy9VcHdGaWda?=
 =?utf-8?B?VURQV0RQeG0za0pULzlNMUlxeU5lakhDQzlCY0U3Nm4wSHVzdCsyd0E5MkFv?=
 =?utf-8?B?ZklQWlFYK3pSeGo0VVpQTXFuZGVFM3NBOTdJdkNYUm1JL016ZHkxVlZmdWp2?=
 =?utf-8?B?d2traUtrRGRnRlVNMGE1S08zaUlQY2tVMzkzYjJrRGYzamd0dWhacld4L3Uw?=
 =?utf-8?B?bWhIWTUwYWt3eXp4aFlnN0ZWNUMxSHk3YllyUFEvSEtZaExuQVc4Q0JRbVJF?=
 =?utf-8?B?a2JaOElpMVRBbUxaS2ErYVg0R3lpWVVGdDYyRk1tTjhtVTNZOFBkOGZjRWE1?=
 =?utf-8?B?ditlOTBMK0ttcUFVWUduUWg4T0l0QjZZZ3VnY3prRCtCd0Fnd0M3a0ttM28y?=
 =?utf-8?B?MWJ5ZVZ0YWNGdmo4S0xIRWQ5T0lsM3BncmUxVlV1azc3U2VQS1pSY0ZLM0dy?=
 =?utf-8?B?VHEzNWZhODhad05qNk44dUt4M0VDdldGRHBwRmUzbEpRMXplNTJyOHRueWJK?=
 =?utf-8?B?VjZXRS9yZW4rSHRkZ2VPVGE1ZjVsRFcrVWlOMXp2Rm5BbkFmYm9QK25CeGF3?=
 =?utf-8?B?azYyK1R0S3J0anc4NzFKNUdXK3VFVHk0ZWpEMHpiVnByY3A2UjhnSWZUTzFM?=
 =?utf-8?B?ZWRKSG1hdHZQU3lWRlZOL2RHQTlhanhlZGFxVVRDTVkwZEM0QmQrZGVsNlFP?=
 =?utf-8?B?eUZjR2EvemVWQU0yU0lEMGxVM0hiaWh4M3BFa1lmSXlJak1zKzJLa1FycHQx?=
 =?utf-8?B?QU5CaUplUElNV2hYZDhCRW15UkRacDZkRDdOVjhrT0Jpa2JrNHF4NEV3TldV?=
 =?utf-8?B?eDZjbHhpQk1LZ25LUjlyUXh3dkZGNGV2dXhxcWhnQUpIWFZHVjQwVitMb3ZW?=
 =?utf-8?B?Z2xEeUxnUGg0M1p4eFFjc2tkQlBHMWx0RG15bWtSYll3U0xpbFNsM1FZak9i?=
 =?utf-8?B?bHc3UU81djc0U1Nkb3NIdS9hMVdGOGdhMUlERzdiVmJkU1RrMEtkQlVzV1BU?=
 =?utf-8?B?NStGaHBycUVOZWFiU1pWQjZNdzFkUjVmNk5pZmxhaXBlZ2JoaDN2NFF5N3NK?=
 =?utf-8?B?YlhCZkpuVU1UWGtkTi95cnhZQkNCNGN5OVJWcjc3M0ZVdkVkUGkxSWRZWDl4?=
 =?utf-8?B?TEt0S0FmcU51VktsMllSSUpIQi9WQmtORS9sUFoxS0E5WWh3a2s0a210blJK?=
 =?utf-8?B?alpNS1NEUlUrTVAyREM2eEc3eFNmalZKMkQ2OFFXckFodkhpd0p0UnYxQ29y?=
 =?utf-8?B?WjczendGT0U3cFE3YXZCMU5Nd3g4Y2diejkyQ1ZMQnlWT2pkOXFicDN3RklP?=
 =?utf-8?B?cjhqNGt3RTZlZERLcm1aR2RpNVI4NHB1TzhHT0ZtbUw2T2t4TGpIZFFneTFi?=
 =?utf-8?B?N1ZEQThGS0N4U3h1bEwvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZvL3JJbnYzT2poUW1CZjBNcXdmUDNSMExKQW5SQlAxYncyRUVMTDlkWWN3?=
 =?utf-8?B?VDJUR0ZueHZPVzZ1ejRxTGFyUGdkd05CRWFZRnAxOVdrTGdLdWtaSWRzOG5V?=
 =?utf-8?B?V21UTzVNWWdqQ2ZscE9zWEpLUHNHb3lON1Z0TlA4ZXV1eU1DT3pLVElPS1VD?=
 =?utf-8?B?QXQ4MlVia09qb0p2byszNjV0RGNGTGNyUTlRMFc1NFBrMVgraVJVMk8rSE1u?=
 =?utf-8?B?Q3h0K3JxMEg2UTdXK0s5WXQ2anhKaEVIbER2Y2tNRG9QN2xnL3lpZ3NZN0ZZ?=
 =?utf-8?B?OFlYSlpTTHFzRCtJN2NKd3dEUCt3U1hnaEQ2VUdaSGZGeG53dW5ZUEJBK3lS?=
 =?utf-8?B?T1IwZ2tyMXJabHVpVzdIRFFsVHQxTWxXL1hNc1pDbUZub09DeU1tblF1RUxT?=
 =?utf-8?B?VElDVVFGanR2OTBsRXMvdGtoL2FLMTNYMHFDZDRlS3ZtYlRGV21qNVprSGIx?=
 =?utf-8?B?S3d6T2R3dDdoMEtEaVJKYmFXVndMakFQdlVrVXU4TWtXajJmMXkwb01wK0hN?=
 =?utf-8?B?WEhzQm8zdTNMd1ZEamRqUGJ4ZFhMZW1jSy91WWh2MWxUR3dsZ2NUUW5ITHI3?=
 =?utf-8?B?bGd6UXo5WU5GSDVSVWhwK2tBK0lUTVF4cTIrcWp3dTQ2U0VKdXBsRHQ0dzJU?=
 =?utf-8?B?ZkppTjhzQnRjZU9XNGwxb0h5QUhNandMQk54RERJRW5jbWpvemlhSXNnd3Uz?=
 =?utf-8?B?N0FPblp2VGtraStxSDBKaFVsbXVmcER1RS9MOVRUR0U5MHFUZVhuR21KZHVD?=
 =?utf-8?B?L1VsYlpyOGNjbTY3UThaRU12WjdYd0tGc3IxU2RnTThYcmpqZVhGOVpjQlVJ?=
 =?utf-8?B?aVViRzVGZmxjeS91OVB6djRtQ2Z4V0wvdEMybGVMUVZwMlFpc21QRzIvNE9I?=
 =?utf-8?B?c0tMU3ZWdDhJT0lXTEptd1RsV09wTnhlZ2xQcGFycGxoYjh1R3N4azI1b0tK?=
 =?utf-8?B?VWQ3akJqTGM1RlhDbm9FclRWREh5ZjlhVGVabGw3cE1PRDlJSHVVZ3NTTEwz?=
 =?utf-8?B?TUoyS1AybjVNMURPZGZIWEtLTVdvOXpucE8vMWtZY3pKYm84WUwwT0VONUQz?=
 =?utf-8?B?Vk1yUmxDUHlyMW5LVWtIQldaU1NJZUZ2NDY4TVBzVThBVE5uRTkyaEZZMmdp?=
 =?utf-8?B?T0t1TElYa045bFd6MHRJWXBpQjkzZSs1MCtyYUZtTXdvR1VRWEkrcndCRmFv?=
 =?utf-8?B?UzRPajB3cXN2SjB2TlB4TS9jcmMzeGYrZEtCRHNHbGx0T0s4NVQ3Y0IrdGx5?=
 =?utf-8?B?NjVRTDBUTG05ZlFPT2laUFVGaUVocndzaVZJN214bnVyVGwxaU5HYWMvQWVs?=
 =?utf-8?B?OGtRV1N5dEVjNWp3WU90YjNuTVgraXZveGhhSUNzMXJ1c2ZkQzZ1cDJERzVC?=
 =?utf-8?B?cFdxRnI2dXUvTEczNWQ3OFMyNDc0OThiYkNmeS9oNG5mRUliQi9temRBakhi?=
 =?utf-8?B?dTRZTUw0bXhDMlN4MXRscjNrUVdXc2xKQit4c2RqV3NXby9EMGRtcndIQklW?=
 =?utf-8?B?Mm5DaTIzN1JSSEpPSlY2WW9KLzF2eDlzcFh0dU9nVXFBMU80WkJWNC9xZXh4?=
 =?utf-8?B?dzlmcE9WNEJWbTJyN0RFUHB1YklZZjBHU3JLTmdlQktCakRrVS9PSThJQ2Uy?=
 =?utf-8?B?VGE0aGxsaFE4aVFpaXNyYm1XUHRrZjJ2R0dqTkNwMVdzQ2tIMmd2NkJ0TERG?=
 =?utf-8?B?L0VqUG04ZXhKRkZ4SnBrVTljMHdlVEUvR2hDRndVcDRmT3AxUlJNVS96K1FN?=
 =?utf-8?B?bjEyYndxb01xd1R0TUFNVEhVWWwwU2w1T3JzZXZBdFF2NmU3K3FVSjJHc0F1?=
 =?utf-8?B?c05iZDg1dDdTS0xtVmc1UVl1cVBwVjFDeTZUcmJ2Z1RWYmcxN1ZXNWg4MW9J?=
 =?utf-8?B?c0VvdWVzSXp6U2swa0VaejdERFJMN21TOHg5MjVoQUExcmJhTGZ4RGtEODNU?=
 =?utf-8?B?d01LNVRhMlVXR1BsdVFJQ0wzVUFGazk1RXZBNlpCQkZkVnpCVEpKUWV1ZlUr?=
 =?utf-8?B?N2h0bmRJZytkNHBFekM2ZTNieU5NN3dpVHRDeGVIVHJWOGU2elNkcVhVbWhP?=
 =?utf-8?B?ZE02VmdUeXBlTnZqVWIzTTFwNTltaEpxVW9VQlZPYi9lYjMwSmRHZ0thanN6?=
 =?utf-8?Q?+h/ew5et4En+yObc9CdELu4xr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabb6d97-c56d-4eb6-0ca6-08dc9b29c224
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 06:31:23.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc0yufwNTHcjFuNFemV6quuNi8LEtdwB3phTJjn6vCmgBvRaaKMFF/WKSMC277XzvCpJXQ2EiYV142oOdzAanA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318

Hi Rui,

On 7/3/2024 9:37 AM, Zhang, Rui wrote:
> On Tue, 2024-07-02 at 15:50 +0530, Dhananjay Ugwekar wrote:
>>
>>>
>>> For Intel products, we have
>>> 1. Casecadelake-AP which has multi-die per package and has per-die
>>> RAPL
>>> MSRs
>>> 2. all other platforms which has single-die per package, so its
>>> RAPL
>>> MSRs can be considered as either package-scope or die-scope
>>> This applies to Thermal MSRs as well.
>>>
>>> so for these MSRs, we can treat them as
>>> 1. always die-scope for all existing platforms
>>> or
>>> 2. package-scope with the exception of Casecadelake-ap
>>> And current kernel code follows rule 1.
>>>
>>> I propose we switch to rule 2 for these code because rule 1 can be
>>> broke on future multi-die systems (This is already true for Thermal
>>> MSRs).
>>
>> I have a doubt about this, won't the future Intel multi-die systems 
>> have die-scope for the RAPL PMU like Casecadelake-AP?
> 
> For future multi-die systems that I know, the RAPL is still package
> scope 

I think in that case we can go with rule 2, it would be future proof
for Intel systems. If you agree, I can make the change in next version.

Something like below?,

-#define rapl_pmu_is_pkg_scope()                         \
-        (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||  \                                                                                                                                                                  
-	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)

+#define rapl_pmu_is_die_scope()			\
+	(boot_cpu_data.x86_model_id == CASCADELAKE)

Regards,
Dhananjay

but it is just lucky that RAPL control is not exposed via the
> MSRs so rule 1 is not actually broke for RAPL PMU (while it is indeed
> broken for other drivers like thermal).
> 
> In short, if we stick with rule 1, the RAPL PMU still works. Switching> to rule 2 to be consistent with the other drivers is also a choice IMV.> 
> thanks,
> rui
>>
>> If yes, then rule 1 above seems better.
>>
>> Regards,
>> Dhananjay
>>
>>>
>>> In this sense, I think it is okay to call it pkg level rapl for
>>> both
>>> Intel and AMD.
>>>
>>> thanks,
>>> rui
>>>
> 

