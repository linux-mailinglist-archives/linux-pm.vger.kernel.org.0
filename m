Return-Path: <linux-pm+bounces-10331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A0923B46
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09113B210EC
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A12157E84;
	Tue,  2 Jul 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BNoUjNkM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF9154449;
	Tue,  2 Jul 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915647; cv=fail; b=tiGwlT0mQzrWAywkmGPnNXFLnTT8kSDmBF7QgABisdiMzS8+W69UuZlYJAXZF9GvRaQSxpcvXR/ANB+XmiE24GusoeO6kIRH2u38+Esn5MYRfgZi29lzncr6Jeo6t1G0EMex1wW3pohWRKlIcZ/KXTuMgu/uiHzDj6Y6duAou4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915647; c=relaxed/simple;
	bh=Th8loLvbaOjniLexUzdvIC3r2v1n310mQ4qMIo0hNdE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FXgMXSkgRZ7MSd6bTHZifL86nSGQmRc/1p8OSGY5QJykAqhkZIrNEFV30hgoH13uYGpcKmE289GQ8fEKgPkXY38sOz+lKptWSUZjbM3ek2OKw3/XD6g02UQ/qA58TGKt44WMAcq6JdWijHFRtjKOAINIr+gr1Rv3klsuNOWbmuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BNoUjNkM; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjg/SC6qObkmIsUGsOntim61K1BloUch072MHEMhv9Y07xzoWw87/NICVslsJQHRdZDtpTzg/4RVBjlZFT6cu/N2q0Zv5KU+nt2w8J9Sf+zW80vByohC5GrW2Y0dE8vN8CGDiOYEcAMhaBayFdJfZS5mt+tFbpXeraYRqDcM/emOol+Ji8DITcF4l2zgmDVRIt6fSYpqIHPpr6EdK3E3kIfDAtKKIwQ9Lq5fcpDJEQq9C+wp1xqXKGoOSAFGMme7Cs8t24clUnooEe9R6+ci6buzRVlae4kYqeWk6fFHzVnKaHf/QIr8EM9THq0CcrcFDDMFm+iF5rFl0eKAOjrgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCobcM4ry19PG3rKrVKttF1yCpU1oDQz3XyBZYK4ZY4=;
 b=F3O19hkvr57AxY+njbqwccB+iwVxlIS86YUa+f2MqIvJ6nEAp3HOMf3+ZBOKllbEBeEunmN8+Mknewoa+kBoy+PNyhvs1rGSjKddsVHn/tQreMsjm9RPhihS5L6jYNKUSpz9tZvabwRSPxQha96zPtkBp93dact0nEVbWWz5ZEHwSiCsdY7GWfEjAJDgQbdBdz0plm4WCAfUXdWzKpP6aUdGSuyDcDhVNpUs+zO2K27TOSUiQR2wWr3iwOxa5HjidWJabqBMHZ3MBo4pTn1LbaulP09n8UrvME9yxyldco2qViXyP17cB02Vkkn5PG38xpjJGZ6wq3yyIj1FUKcPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCobcM4ry19PG3rKrVKttF1yCpU1oDQz3XyBZYK4ZY4=;
 b=BNoUjNkMa5iKcbYMhbcV/U+ooW4Cvfi9+MYxojMcYS78qbntxxhcRLgxgcmYypmMOnUVjjf6FCYvs6H4QcZbLSZStQHd5gir4CbJVQEMiVNsQOZMs/nvzZgbWxcTrbGjOiL2SHueVXbxcmKXxvmwtGhPzQbDmo8eZvnpZ6DXHXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 10:20:42 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 10:20:42 +0000
Message-ID: <35ab02da-861a-4271-986f-f4271637f5fc@amd.com>
Date: Tue, 2 Jul 2024 15:50:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] perf/x86/rapl: Modify the generic variable names
 to *_pkg*
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
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
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <477c33a2949793d2a8692c925179bc4f1feb7942.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::23) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6d70c3-13d2-498c-7c9f-08dc9a80a074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXpPcVZ0QXBPN3Jva2dlSEF6WW9MSnZxR0k4Q29OSEo3NnU2SElzbCtDb3M0?=
 =?utf-8?B?RnBhMFVlYUxpQzdHeXlBVTZabzdHV240Qm1HV1p4YW5KZ05uK1FFSFdtNGFM?=
 =?utf-8?B?bE9OUXFiY3VDNEFQRGc5Y3ZWQVo1QUQ1d242MkFrNXpmWlZTTUpiaGRxd2lN?=
 =?utf-8?B?ZlBmcjBVdGc4OEZTNEwxZVZ0QUhMUzFGM09JSjNBcDVJTlFBeFl4UU1MbW53?=
 =?utf-8?B?amUxR2RLNUMwRHZETXpRaXFGN2NyNVFTcmtOSmF5SldCaHFWMkppdEsyUzZu?=
 =?utf-8?B?c3RkeCs3V1NxM0d0MWlsNjY5UVYyZDJHT0xJSU5kcllDMDFLaDloRFk5Vjd5?=
 =?utf-8?B?RTdrMTBoMXdMTm1RSXlEbHlUUHg2M0tZc29PNDJkb25ZZm9CZ1ZUZDV3MlVT?=
 =?utf-8?B?TU9DOUlZOXhQN0Z1OGIvWWl0YTZSWnZKd2RuekVFY2tqb2NvZW93MC91M2Vo?=
 =?utf-8?B?M09xUEE1OThHVVVyTm5OSmRqNTJUZ0dCNEV1b0t4U2d3c3pxalR2V201ZGVx?=
 =?utf-8?B?WlRnZHFzWU91NjVNZUt4NjYvMHdaRGJSOVhUT3hPK2htZHU3WG1VcFFFZlJK?=
 =?utf-8?B?eXc0RFo2ZjhxckVCZXg4TUZZOENXMHpydzNJR3h3WmVFVU9wZ3haN2JnNzdz?=
 =?utf-8?B?U3o3aHRMR3UzS0l4WXBwMFF5TFRZTHIweTFQcW9GbHFLamtkZkRZYnR1eTJR?=
 =?utf-8?B?NTVjaXN3anpMRHVmYTNDcWh1L0Y4QTRIMkw0SVhWcExHVStmU3BjclFvR3VH?=
 =?utf-8?B?OEt3djdwZ2FsMVVBWUY2MmIzTWs5QXpCd2xDSTluN09ncTBOSEcxdkZ1ZlRS?=
 =?utf-8?B?emx2T1V0T2MzNnZBY0tSb1hibFYvQWNmbUxrTUIvZkQ4SFNrWm9xZEpxVjZ5?=
 =?utf-8?B?a0Q2L3hKQ0h0TjhrakJFbVR0U0pHbDFHUWszcVlHQWVLUlQ3ZXgxOXM1QWow?=
 =?utf-8?B?TklRb1FKZzhqakVZb1g1ZmNwTEpub3JMYWhQaTRDU0F4WkVVY3VycTg3cTZz?=
 =?utf-8?B?MEZnQVRUV2JxenF3U3lCQmg3Ry9oblpSNDN5VkVtdGhiM1A2cS8rQ1NMbmha?=
 =?utf-8?B?eUd2S2JyOHhyalhab1BZVXBhZUtJc1Fja0NLcVZOMlBxTUJDN3hBQ3hGVkh3?=
 =?utf-8?B?SmZtWEUrQkFtTUxNL29lTUNjR3paK3NlNmRBRHRNays0dEE4MHJDdW1HS3Vl?=
 =?utf-8?B?N3daVHpRMkg2cEFBOGw2ZUNITFV4QlBYQXJsTlVNV2xyZitnTk9ra291Rktj?=
 =?utf-8?B?WStmTVFSRTVCc0xiNlA5YTI1bVBnKy9uK1dhbW9SMFdTZUk1akxoQ01pTlNN?=
 =?utf-8?B?U3F2d0Ixc3RxWHpiYUxId2xycExDZG9TUnlzaG1aalJZaVRZTVBQK0lPbG50?=
 =?utf-8?B?V3BzUnV1ZzZHSmlsS1FXMnFMM2FZREFTOUxuRk51MFM2QVZNaUNlU0RSd1lU?=
 =?utf-8?B?dnhpOStVRGpsbG93YjFObDNUVFdMNDFZUjExc0JoM2tkZTJsQ0d5M0ZrclJR?=
 =?utf-8?B?TDJVbkx5K2I0OHVubURHYzYxUjZDK0NpNDFTalBZV1ZPbEZ1RzJ3ZE5ybUcz?=
 =?utf-8?B?K2EwMjUvUVJBbVVHOFVobXVVYmJTTFcxWllIMmZzTGRkY3dhZktnZVVrUGsw?=
 =?utf-8?B?OFBTQ1R3QldiVkNSQUtPRm5aSlhzSzJRVk9DcjRuSkRWUldpbXRlR2Z2Ni9D?=
 =?utf-8?B?NENBallNLzJRS21wZktyYWhLcldpaEJuVmJEVDIzOXRHaFFoVVMwK3c5dG1m?=
 =?utf-8?B?OVZrYzVTRldBTy80MFJuTXNha09DRXRVb0xYVEZlNncwOGU2ODZFcUMydkZI?=
 =?utf-8?B?WkVmVC9NdXFTemV6ZlV4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K256SEFxY1g5a1V2by9QQnpRVGtCb1ZrM01mRjBLRHZtS3NyS3RuMklZOG5z?=
 =?utf-8?B?R01VVmxQd1pmVHY1VlFhVEVhUzBocFFva0tibmNiem45Ky83bXlRaXZEWmxO?=
 =?utf-8?B?am1QOG9pVGNQOFppakplZjRackJSWEhWMGkrSUpoek1yVkhQS0dEN3NlZFZR?=
 =?utf-8?B?bm43bGJhWFpwLzJ3bWFtZVRZVE52ZDNNYlE2Q1dJUDRiczh6Y1BnUzJ4WmRE?=
 =?utf-8?B?RFhSZExiN1U5OWtWRmplNXg1OWhPMG41SWlaYnQ5RHQ3L0ZxaDlGcXB5MnJ1?=
 =?utf-8?B?UThnS2tuNXJJNXFvZ1MwMkVPT3ZISzY5dWlpWjRDNmw5YW10c1dNVXFLdjI1?=
 =?utf-8?B?eDFUZVBRcWwyVFlVdnI0cVMrM2RBVlJqRHU4S2QrcFBoZURXSlBHVHRIQXdI?=
 =?utf-8?B?OW9XMzFXb1V5aTIvcUltUkRHRm5BMTBoVG80THkvc01pV0JkZXVqNEg4ZjM4?=
 =?utf-8?B?bXFqVlRPdFZVMVhiZ0lIRktzalh1YjcrbGVVV1ZVQVBvVXRvakV0MzdOY0o4?=
 =?utf-8?B?bGdWejhoYzZ6akxTNlJlUnd6RWFGbHhiYTBDSDlUZmR0MmtTMjFhbVc3b1Ny?=
 =?utf-8?B?aENZMVlnVEt3VVFpSmxmU0xCb3ZXSFF1UlhEMDAxVVBGYjZ6bXFjSjdkR2sw?=
 =?utf-8?B?MUM4QnZWNXBTM0IyUzBsVVRJL2RIOWJpam5oVHlyUFJSWS9BbFZrNGFyN0hC?=
 =?utf-8?B?QkRxRjJoL3NhazE1N0swS01NM0oyVTVXUjdVb2RzdXc3NjBMaDgzcFNIUEs3?=
 =?utf-8?B?b0piZWpJQ21Ba3dSN2hoRStNZFdzMjVsd1lOSGxjbGR2UkRkMTJGNFN1SlZP?=
 =?utf-8?B?dGJnV0pwTElBTnJRK1c1NTFzckp6dDhVeGZKQVJONWloOTZ0MUg3dzdhWUpU?=
 =?utf-8?B?Q041M0h3LzBpWEVGVmJEOUU4TnNoZVNrQ2pOS0M5M0NQSlRyOU05STJTc1Jq?=
 =?utf-8?B?dXloekRHUUJjUGd6RDB3VDBiTXRuZzdUd0J1MUI3OGJOTDVJL08rZ1FyTWxy?=
 =?utf-8?B?N2JzSUVzVEtkalpnaDBYNjV2OHBpc0FiK2VPUHpFdGF6a0dMMjJYWjZNejQv?=
 =?utf-8?B?ZTFXQ0dVUnp6MCs3ZGJzbUYxd0wvMGNVbjBmeDF1RElDVWNMa0xhYThEUDVH?=
 =?utf-8?B?NEFwbTVRWmNSNllhdHhhZHU5aWUzb2pkQkdpVzYxaHdBdVhEbW1vTHp5NUdp?=
 =?utf-8?B?RUUreWw1V0crZUxSUlBoV2JhRGtIS2QzbDFHbnM5ckNPTThQSDVCVWljRXNx?=
 =?utf-8?B?YUMxVEdla0I1UlZiZzQ2LzAyakx3b3VnZ1k5MHRyNDZMMmFhZXpYNU1VdGVN?=
 =?utf-8?B?dHgzNGJhZ3ZvMnJKNVI5ZER5NkVkY1RJZWNEVUtjYXFEQkR1dDZLRW9NelJz?=
 =?utf-8?B?TDk2QkhGYkhjVjNqc2Y5YnJ0alZZZU5WR3J5YlVPakVyQUpDWmpKdEFkRnQ1?=
 =?utf-8?B?amFZRzNoUG8rK2NoaSsyS2tFYUNGc1dYNzVDTTZUSVM1VllpQ3hMOW9iSzlF?=
 =?utf-8?B?aE4yd3pLVnJCU0Zxd24wT3ErbXVlUnpoR1JXMjA5T1o3UzlBNk4wVkR6TTVJ?=
 =?utf-8?B?N2VFVmx2ZDBFTG41dUU4UHcwTENNNHgveUY3ckovNnJ5NGdYTmdDWm1pVEIx?=
 =?utf-8?B?aFBoSSs5U25WTEVYSmQyQmh6UW1jdnh0eDAzdDdWTm1ZSXdJMnJQRGNGSUNn?=
 =?utf-8?B?NlEwaGU1S1UwSkFzS3FLT0puRS9zUTJJQXB3VGJ5TktXbjd2Wnd4aWtUdTY4?=
 =?utf-8?B?REpDbktybzhFb3pFNzYyWjFUZlNLaWplOUdOWVJBRys4Ty81czVmbEU3b0ZL?=
 =?utf-8?B?RVFkUTVqWmg5Vmk4bkRmSXBKZGZsS2xrdUxHV252dU40YjdLSXRYTVczM0ZH?=
 =?utf-8?B?WDJuQ0xXcjVnUnQzdFVSUXF3cno0VEthYktWRUxkSFdkNEVZSGkzVnRuQllJ?=
 =?utf-8?B?S1QxNUNJUE8rUlVsdWVQTTRIZW0vYnFySTd4RjhzYWpDaVE3Mno1K1RJd3JE?=
 =?utf-8?B?MVh1NzBVT3gzc1lHRHRzUkpyMmNaeFdTU1Z6TkQyczZ2Q3RaUFNZR1hYSm9x?=
 =?utf-8?B?azVCQVhKc0IyNTR6aEI4ZS9nUU1wM0xpeDVvNDR5bk94Qlp0SGl5SUhCZlA2?=
 =?utf-8?Q?4R9y2OnAz3NuLfA42+xH5meHo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6d70c3-13d2-498c-7c9f-08dc9a80a074
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 10:20:41.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Su3Bic1qQdese74Dfql3FM2E1XXmpxdkbTp1Zx/b2OMCwwzHXaM01yMsT4KMOCErBLngwmCVEa697J4uDDE9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

Hello Rui,

On 7/2/2024 7:55 AM, Zhang, Rui wrote:
> On Mon, 2024-07-01 at 15:08 +0200, Peter Zijlstra wrote:
>> On Mon, Jun 24, 2024 at 05:59:05AM +0000, Dhananjay Ugwekar wrote:
>>> Prep for addition of power_per_core PMU to handle core scope energy
>>> consumption for AMD CPUs.
>>>
>>> Replace the generic names with *_pkg*, to differentiate between the
>>> scopes of the two different PMUs and their variables.
>>
>> But then remember patch 2 and recall that intel seems to have
>> everything
>> at die level, not pkg.
>>
>> Does this proposed naming make sense? How?
> 
> For Intel products, we have
> 1. Casecadelake-AP which has multi-die per package and has per-die RAPL
> MSRs
> 2. all other platforms which has single-die per package, so its RAPL
> MSRs can be considered as either package-scope or die-scope
> This applies to Thermal MSRs as well.
> 
> so for these MSRs, we can treat them as
> 1. always die-scope for all existing platforms
> or
> 2. package-scope with the exception of Casecadelake-ap
> And current kernel code follows rule 1.
> 
> I propose we switch to rule 2 for these code because rule 1 can be
> broke on future multi-die systems (This is already true for Thermal
> MSRs).

I have a doubt about this, won't the future Intel multi-die systems 
have die-scope for the RAPL PMU like Casecadelake-AP?

If yes, then rule 1 above seems better.

Regards,
Dhananjay

> 
> In this sense, I think it is okay to call it pkg level rapl for both
> Intel and AMD.
> 
> thanks,
> rui
> 

