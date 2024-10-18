Return-Path: <linux-pm+bounces-15980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0FD9A43D5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4889B20F8F
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F1202637;
	Fri, 18 Oct 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vUCmofEL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACA168488;
	Fri, 18 Oct 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268920; cv=fail; b=hkockZtM5u6qp5Vk5OTu6zeeqTAgv7K1hBEdqVmskNfrcqDobHjcdXX1F3m7FnYZB+uPX7hExTyfDIWJ5W6HuTk7mlN/X1a3GFZubgA3yIk/P8x9kQixWl4STsLcHhmnNDGwrFuX8p5/A/CveUhW9wGf95vUIxC91myazAzaXQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268920; c=relaxed/simple;
	bh=w6iDzbK3ivIvBWYE/FKlyufSxSzv+KLKe/Llg3eDoQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AWA4zwP2gVwTWMsskypXmXYZID9RgYs1Ssj9pidfIbH+3aTcfLDcEZJ71AkdHL5SASOY1fqFVfmRzySCq6KQyqQzr97VzfyUezEqjkGZD9SrvpjbEpw52ahh1GjFNKbAIqPjdvBmYDSFWrceQ/5mvELO1sLmjQQWk2nU25OAyCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vUCmofEL; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EepznYSav8z8YCOemmKYNUh4L5Qh+YzDTSAkQcURciCjjgATioy3B8kRpKVYGalF+5xglqd4K+J6YpPyAIszHWsKH0q3/bQq2rlsSAgYGTiq1bMK8oBUJLP4QEuoKt5n4RuwC6KJD4zuKdc1n7vpRC8otPXzZ9SrYzS/SCM56E3rzjQb5FQq11AekikPaTWq5ODAXnQMqLsWt2ZZykS3LJSaPDnHWMox2LKUDhZr1Kr31OnNCeVn+DBfuRop4dR4uVLwqE7bmt2ehKDnZcpxcvtj4WdC+ar6Ie5pSjA1MxaBrRyCht2O/xQOwCOmNyGpS9Na6rkWd96aiLzKIm4vjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddHsd4O3BHmkvA13FNGbEOs4dse2UMJEZ67TQOPeZJM=;
 b=IW0b9SOoQlrlwdqPA2xdJzR1aaNcOmY5QntcStroTQaGqdvGwLTRXnPahn2EYhMXQQq6tM+l7621mp5HZkB3tUPpIulyYc1iwG3muQwjHs62xy1vWeJ8IJbgm1BzBZsVajuuqZesiz4Nue8GCsxAucBPs7L4vJTNAm8t9zQdWK/JmfvQkmEvZ3z09LmXr2m2hl00+wkjeVINn7FEEf3S4hq1AH6LiJ91qDPbC3Lqjv3nPFlI9cXsp/kjWlGchrEWHfQ7mghibTKSurmBP3r5kn0HNW4ORZzfE8NMN/Tmii226VRUsWfQ9muf3VOKnupYLluELY9BG3rKOpA17texdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddHsd4O3BHmkvA13FNGbEOs4dse2UMJEZ67TQOPeZJM=;
 b=vUCmofEL9NZHnmuR8BRVzg5yExL/vo9T0IzaUnRdIf9HFEDKwCxO5fmNLjWl4abFuQmq4tXQRBCcsM+w12qnNDXv2GQNhevMyHdY9J66YMZdtLi7ITxPR7Ei6N0NaUQP0A5v6JtYOcrmFV6Wr89DS/0JGhkCAugxqThLyr9IHK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 16:28:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 16:28:34 +0000
Message-ID: <1a96323d-f6e9-4a59-97c4-8cab149a7b31@amd.com>
Date: Fri, 18 Oct 2024 11:28:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Brice Goglin <brice.goglin@gmail.com>, Perry Yuan <Perry.Yuan@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:f2::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: fe705cfd-b8de-473c-2ccb-08dcef91e932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0V0OGorQnMrcldGemduWnQzdHZTblpiWHJ3RVlKVnFBaTBPbFFVMXJrQzNM?=
 =?utf-8?B?eDdLM2JrVTh2bEtudS9IVWljOGlDaVpZU1NTQjhBYy9ucFR4OG5YbmpSM2Ra?=
 =?utf-8?B?dm5tbUYvUHpRMEVOemNyS3ZNc0tlM2xIenFZRUMzTkVmUEFBc0lsdlUyTk5p?=
 =?utf-8?B?NzJrMXkyclZLRFpjY0prYnVQMkM2cWZ4OHJGUlRLZHBVSHpuVzFNUWtuQXQw?=
 =?utf-8?B?aTVEMDZsZ2RmYlN5ZjlOdHJxSWMzWU1tZUlqY2huNVFmblhLU0ExRUdoQjJQ?=
 =?utf-8?B?NkFBQVFiT3hMdmtHR0VreFgyenRLQm92ekV3d01BaE9hRmxmYXBjV1dIOXo5?=
 =?utf-8?B?UVFqVGkza01RY2I1TTZseW9Ya1FPV2J2Z0s5d0xDT25uaWFkQllpeTc1VVVp?=
 =?utf-8?B?OVpXWVRCbmxSakRIOG9DblB5SDRrV28rNXZSdDdEUTRHMTBVWDVRZllObytO?=
 =?utf-8?B?TFdGcUczRUsxenBtMUx5NEM3aVdvM3lHdTdBTnptd3FmNnEzOUt1Z0w4NWx4?=
 =?utf-8?B?QUhiZHZRVzZhVjRqZWdyaTYzajhCSkMxdnhEQ2w4djZZcWFuN2p4NDhvcncx?=
 =?utf-8?B?Qm1UQXRLWkZWeXJnN3VOaTJmcWhzU0pDNGgrQllkcWV4Y3ltUmRndTlyZHhZ?=
 =?utf-8?B?UTJVVHdQaHpUendjdjdaYytuN0U3ejBwZ2VDcktYMWN4Um5kN3BtcWN4aDRo?=
 =?utf-8?B?elFmamdGS3lBWjVWeXFTbEJ1T3VJN0x3NjdzMWN6RjJYTG1sRC82bFlzaWM3?=
 =?utf-8?B?N2QwTnNybnBpNVpCMlQrbTlDQXBaWGVoU1Y4TUh2Sk9DQWRhTlI3YklmZ3My?=
 =?utf-8?B?ejgyTkZ0TXdaMTlEWlNFQ0pEVDhsY21OTHVXejQzRFhsMDFFM1E3ZTdvQnBK?=
 =?utf-8?B?ejNxeVdpQStPVUZVdUwwblBpeHFDN2Z4eTkvbnB5Y2QzOG1uRzR5ek1pU0xQ?=
 =?utf-8?B?L2xQclUvWE1JWmdrRGxBdFlLVzhEMEJrRnFUd0twMm9mNmZWWlowMmZhZCt3?=
 =?utf-8?B?a2xSVWtOT21pTW43NlpUTkc0UHcrR1NCT2ZEa1BiQUcvdHF4cmZ3eDZyeTBP?=
 =?utf-8?B?KzR4Ynljc1djbm1reGovNUdOZjUybFFaV3RnNFo3S05zU294V2NNVWluQmFO?=
 =?utf-8?B?NStsTlJJVy9wUUFHa0VOU0s3dFFMUjdWVng0YU5XYWVNY1l5ZVVXbVFtRUVs?=
 =?utf-8?B?dkYweTZwUjNGNXhVN1o4bVR3RytNZnJUczdHZmtZM2tjWjNHL1hDdS9tajJD?=
 =?utf-8?B?b2FzK0FhVmg3aGxaNEdXTE0wNzJ6dCsrQ2NjaE1IODdjeEpGUjBqMzM1S0Jh?=
 =?utf-8?B?TkhSdGt1YWNNejNtQ3BZek56ZGRGT0xDRmVqVzE2SDQxSHpHRlVaNXlkNUk5?=
 =?utf-8?B?RmQyakFpWm45dkxBSVljb09pNGhiVklBVGE5Q0QvTEk4ZEhWOURQZkpseXIr?=
 =?utf-8?B?dlBsWlFvNXZ3RlVpeTZ6Yy9HV1NWQW1QcVhDcWcvWDNZdVlEY0ZTUXFhKzUv?=
 =?utf-8?B?Tkx5VmlyS3dkVCswa3dWY2lWOSt3cFNjQ2gyNllMcWNSRngzWnlTbi9kZE5I?=
 =?utf-8?B?cFEyRlIvNHkwL2c2S2MwRTlKQlNKYlZSc1V3TFE4a0J3cVdEMVY5amkvWHQ2?=
 =?utf-8?B?R0RPNUpzc2JHd2JlUzJWUm4wMjA4bEhiNE9WLzFpdEtvWlpxZU5mWEZuOVdF?=
 =?utf-8?B?VDhCNjNOTXFHcWJTTkJ4b0U2YnlsRXNqYnNOUUt5OUdGYk1KdmJhZW1vNVBK?=
 =?utf-8?Q?SAfYrVTRrsdgHLOUkwOSgEKeaondjF3vreFu7fR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEYxd1pHM2dCbWllWVNZejhmQXBjT0VDTWMvQjJpR1dwVEU5NFZnNDRxSWVK?=
 =?utf-8?B?TFJOMVdYc2xJWXEydlN4cEVCUzdNU0pxenlzMldjVklpaEE0L1dxMUdkc21h?=
 =?utf-8?B?QWRQOUxmN3pqcHdPZ056OHY2Q0NOclA1S2VWazIyNkJYSUNLT2pJRm5WSlBE?=
 =?utf-8?B?OG9zQ1AvYlZRaXM3SStoOTU0dXkxWXZQREdIN1dZZk05WXJrb0FpZmJFcHcy?=
 =?utf-8?B?Z1IzQzVXSmZLZWRlWWxhdEk1ZFZ1aWYvS2plNkg3YzFsN3diL2lYSklieHVk?=
 =?utf-8?B?ckhCZGg4NW45dy9IVEcyQ1lvUW1OK3BtOXIrS0tsVzNRZCtkVUltRDcvbXI3?=
 =?utf-8?B?cTViam5xd3FOUzhBU1pkR0h5L2UyMEUxRkdjc2ZXeEZpQzFKQ1U0TXlDU0d1?=
 =?utf-8?B?RElEWHgzUmlxYWoyWTdLYWVyMmJNMmRFT1BKYmtYUEVmakZLM2I4NFp4WGVW?=
 =?utf-8?B?TWtLelJxN1ByOVNhc2RRRnF5MlNTM2t6OWZwMUExOUM4WEh3NlpTYUdGTXZ3?=
 =?utf-8?B?OERXR0VMeDVyOE4xMkptUUV4QlMwN3dCbmRWM0Q0QkVCRzFqTVRUNXp3RHlU?=
 =?utf-8?B?S3dwRStRTlVaZUIyMGVJY2IxamlDd1hZV0I1M3o5SGNEK1AwM2JQdGlkNDVs?=
 =?utf-8?B?Q3pPR25yY3U0NVk5M3IrY2VHdEljZEVzUXArVXdXVEErMGxRZFZNRGh4Y2pQ?=
 =?utf-8?B?a1VlT0xNRTVqREZRcmhZMU9Pbmd4dTRoRllTOTBRK2FLSkxBUzM3bFYrc3pP?=
 =?utf-8?B?aHkyTDMzQ0hMODZ5VmJhM0dmUXYxdGhic3VYd2ZnTUFuMHJMTW5WdnBid2ZO?=
 =?utf-8?B?MStpYkMya1BYdjhGbmxpT3ArTVpnS2dFVHBNdGpyK1dMY1g5amNKT01KNEVx?=
 =?utf-8?B?WUdBTUtwandzemdERGVtTFZoZFBwWTJEZCthYm90WkZZcGhHaEFkell2VTY4?=
 =?utf-8?B?ZUk4SUlqRk5TTzllNHNsU1B0ZXByOENJN1YxQ3hyanRENWFyd0FCa0l1bzlq?=
 =?utf-8?B?SlNtZ3JHcll6eFZoSjMvcjFvNGZXaGdEaTFGN2JZUmVqTXVWbEdNdEo3SFBm?=
 =?utf-8?B?SjludkZObkRCR2g5QVl5Q3l0VHRMMHl3UHBPWkNTTWZYMGprQmZUTElJWjlr?=
 =?utf-8?B?cFZEZTVWUDJTbTN5L2tXMVhjL2xRRGdHM0VpbjBvOXkrbVpOcmMyL2N0c2ha?=
 =?utf-8?B?TGhWMXVMSm1NcWoyUmUzY1JkZGl0OStReHl5NmpFSDdQQnJwckptclBxR1NG?=
 =?utf-8?B?WVdmQWVjcFR2Ukl5K2g0RTRNSSt3aUJVaEpUS0M0MzJZWUI0d1NsL1BLd3la?=
 =?utf-8?B?QVlBUGNUa3N6WUhsK1M3ZUFtRVlwaVJEdEM5UFlwY3JVRkpXNDZ4RXpyZDJk?=
 =?utf-8?B?MEhlN1pxVmhhc3lKYUJSM0NnaE9ZMjBWOGE5dnV5TVpob2RrRGJBYWY0eG43?=
 =?utf-8?B?RzhyMzVDWVpFTG5ITC9OV3dzNXpETzdwd29xUHlIYXpDUEJyVXZRaDlZRTVP?=
 =?utf-8?B?TDlLVUJvZHBZUWlXV1JjWE5sT0FKbytLditCeitZSHpUVmNVQjFkTVI4Y05s?=
 =?utf-8?B?ZGhRZC9tMnFzTFR5eGYxcGpMNlJEWFdoOGp6eGE2WUsybksyUnpJWHRvL0xu?=
 =?utf-8?B?QWNpWC9PZEc0c1RCTDFSZ2xzY1NkaEVqQlFWSlpSb2ZmbEdvY3g2WHhxOG5E?=
 =?utf-8?B?SWFoMk90T0V4bkVDTGpsU2FGclJTaTNkV2pEQ2F0TmVKZE16Q0hXMmxlcWFR?=
 =?utf-8?B?NGhvcWx0S1ZWQzJ0eWpBUjcvanh5S3dybjE1TG5qNklWdS9LMUZ1MEhmTlpP?=
 =?utf-8?B?WmhsQ2trQTYvZ2dDTlRlaGh0NGphczUxQWpsVFRMUDF6UzJuU29tNXBoK1ky?=
 =?utf-8?B?bHlZYkVSMzFwRWhrYWJtWlVhSStWaitkOEM1UHcvbm1xN3Urc0lqODZuQ0R3?=
 =?utf-8?B?VDRwckt1bkZSRHRsOUVyRjZlUnkvdHIyK3FId1hZKy9SV0VySXB6RUxEZU9i?=
 =?utf-8?B?VW9IcEJpKzFMcHlDQjFtNXdOaHFsdFVOOTZRMWFOWTNuS3cvcVpMS1U3L1Qv?=
 =?utf-8?B?NU1HWTNCK2Z3WTlJUzRORm5IVG5TVGFaOGJvMS93eC9VSjUyb0RMVExWOWE2?=
 =?utf-8?Q?sJaTJJxHT583Rb7xpmlKd/w2H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe705cfd-b8de-473c-2ccb-08dcef91e932
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:28:34.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziYe+PZDokGc9JCYlhdZcN+GmmwnVgS+FXHbl+uE5f3/3wf9yZBmMYQrAUzUmY7q4QsLorEiUDsQ70yVld34tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

On 9/30/2024 09:47, Pawan Gupta wrote:
> Sometimes it is required to take actions based on if a CPU is a performance
> or efficiency core. As an example, intel_pstate driver uses the Intel
> core-type to determine CPU scaling. Also, some CPU vulnerabilities only
> affect a specific CPU type, like RFDS only affects Intel Atom. Hybrid
> systems that have variants P+E, P-only(Core) and E-only(Atom), it is not
> straightforward to identify which variant is affected by a type specific
> vulnerability.
> 
> Such processors do have CPUID field that can uniquely identify them. Like,
> P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE identification, while
> P+E additionally enumerates CPUID.7.HYBRID. Based on this information, it
> is possible for boot CPU to identify if a system has mixed CPU types.
> 
> Add a new field hw_cpu_type to struct cpuinfo_topology that stores the
> hardware specific CPU type. This saves the overhead of IPIs to get the CPU
> type of a different CPU. CPU type is populated early in the boot process,
> before vulnerabilities are enumerated.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>   arch/x86/include/asm/cpu.h            |  6 ++++++
>   arch/x86/include/asm/processor.h      | 11 +++++++++++
>   arch/x86/include/asm/topology.h       |  8 ++++++++
>   arch/x86/kernel/cpu/debugfs.c         |  1 +
>   arch/x86/kernel/cpu/intel.c           |  5 +++++
>   arch/x86/kernel/cpu/topology_common.c | 11 +++++++++++
>   6 files changed, 42 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index aa30fd8cad7f..2244dd86066a 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -32,6 +32,7 @@ extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
>   extern bool handle_guest_split_lock(unsigned long ip);
>   extern void handle_bus_lock(struct pt_regs *regs);
>   u8 get_this_hybrid_cpu_type(void);
> +u32 intel_native_model_id(struct cpuinfo_x86 *c);
>   #else
>   static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
>   static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> @@ -50,6 +51,11 @@ static inline u8 get_this_hybrid_cpu_type(void)
>   {
>   	return 0;
>   }
> +
> +static u32 intel_native_model_id(struct cpuinfo_x86 *c)
> +{
> +	return 0;
> +}
>   #endif
>   #ifdef CONFIG_IA32_FEAT_CTL
>   void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 4a686f0e5dbf..61c8336bc99b 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -105,6 +105,17 @@ struct cpuinfo_topology {
>   	// Cache level topology IDs
>   	u32			llc_id;
>   	u32			l2c_id;
> +
> +	// Hardware defined CPU-type
> +	union {
> +		u32		hw_cpu_type;
> +		struct {
> +			/* CPUID.1A.EAX[23-0] */
> +			u32	intel_core_native_model_id:24;
> +			/* CPUID.1A.EAX[31-24] */
> +			u32	intel_core_type:8;
> +		};
> +	};
>   };
>   
>   struct cpuinfo_x86 {
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index aef70336d624..faf7cb7f7d7e 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -114,6 +114,12 @@ enum x86_topology_domains {
>   	TOPO_MAX_DOMAIN,
>   };
>   
> +enum x86_topology_hw_cpu_type {
> +	TOPO_HW_CPU_TYPE_UNKNOWN	= 0,
> +	TOPO_HW_CPU_TYPE_INTEL_ATOM	= 0x20,
> +	TOPO_HW_CPU_TYPE_INTEL_CORE	= 0x40,
> +};

This isn't exactly generic.  Unless you have a strong need to know 
"Atom" instead of "Efficient" or "Core" instead of "Performance" I think 
it would be better to do this as:

enum x86_topology_hw_core_type {
	TOPO_HW_CORE_TYPE_UNKNOWN	= 0,
	TOPO_HW_CORE_TYPE_PERFORMANT,
	TOPO_HW_CORE_TYPE_EFFICIENT,
};

Then you can do the mapping of 0x20 = Efficient and 0x40 = performant in 
the Intel topology lookup function.

After you land the series we can do something similar to move AMD code 
around and map it out to the right generic mapping.

> +
>   struct x86_topology_system {
>   	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
>   	unsigned int	dom_size[TOPO_MAX_DOMAIN];
> @@ -149,6 +155,8 @@ extern unsigned int __max_threads_per_core;
>   extern unsigned int __num_threads_per_package;
>   extern unsigned int __num_cores_per_package;
>   
> +enum x86_topology_hw_cpu_type topology_hw_cpu_type(struct cpuinfo_x86 *c);
> +
>   static inline unsigned int topology_max_packages(void)
>   {
>   	return __max_logical_packages;
> diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
> index ca373b990c47..d1731e0e36b0 100644
> --- a/arch/x86/kernel/cpu/debugfs.c
> +++ b/arch/x86/kernel/cpu/debugfs.c
> @@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
>   	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
>   	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
>   	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
> +	seq_printf(m, "hw_cpu_type:       0x%x\n", c->topo.hw_cpu_type);
>   	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
>   	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
>   	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index e7656cbef68d..e56401c5c050 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1299,3 +1299,8 @@ u8 get_this_hybrid_cpu_type(void)
>   
>   	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
>   }
> +
> +u32 intel_native_model_id(struct cpuinfo_x86 *c)
> +{
> +	return c->topo.intel_core_native_model_id;
> +}
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index 9a6069e7133c..e4814cd3d8ae 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -27,6 +27,14 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
>   	}
>   }
>   
> +enum x86_topology_hw_cpu_type topology_hw_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	if (c->x86_vendor == X86_VENDOR_INTEL)
> +		return c->topo.intel_core_type;
> +
> +	return c->topo.hw_cpu_type;
> +}
> +
>   static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
>   {
>   	struct {
> @@ -87,6 +95,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>   		.cu_id			= 0xff,
>   		.llc_id			= BAD_APICID,
>   		.l2c_id			= BAD_APICID,
> +		.hw_cpu_type		= TOPO_HW_CPU_TYPE_UNKNOWN,
>   	};
>   	struct cpuinfo_x86 *c = tscan->c;
>   	struct {
> @@ -132,6 +141,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>   	case X86_VENDOR_INTEL:
>   		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
>   			parse_legacy(tscan);
> +		if (c->cpuid_level >= 0x1a)
> +			c->topo.hw_cpu_type = cpuid_eax(0x1a);
>   		break;
>   	case X86_VENDOR_HYGON:
>   		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))
> 


