Return-Path: <linux-pm+bounces-7761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7621C8C3E36
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E112F1F21009
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB1C1474B1;
	Mon, 13 May 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CSYnB7+S"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED953398;
	Mon, 13 May 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593032; cv=fail; b=AB6FiQIkMnLLdh5vpJVSn4peQHMuJxDdeowzPSpM04TXDmIrYOPLxO/LXNq/RLEvVZ+dQ5qlTsBPMbqXsGvLBMzC2HPu7eZ2fnh3tXR/UleJVtDlT5sA3BcTIrK23GcbeORRiYaJVEXEvnELa0CO6jIZbx7UxESrr/gpFhJZuYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593032; c=relaxed/simple;
	bh=Ebs2Im5NwBaBAErqrg6gkb6d3CwC+R8PDBrkdkpSn+I=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UkpfbTUlL1vKz6yim7RU87Cqadnff4w3ps/4Vq7Z3raHiHFmJLIPSVF/Kag2SZ8g4LP8F1idNdkah45hY0O9jVaeJ68QBtBzL++/fZ9AxkaVo20LUlqfqNYrKm50zDvPcw/pvyXZljKIY/TlQw3dTMYsmuoUCRel1P0Po1jKR7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CSYnB7+S; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYeNQ4LnMetmpq5mLZy9LQzMRGdDuXFTU8xxbTsZGcBWo9R3ND8ll14z4ObqaWgl9+K51KENaM+KK9QcC9y+fB1OA6SPSSN7J0+rpucumoa6NUkQVy64IZO9Ok/p3tAsjpC/CvSBTBpwW7SZqWvPnD2V6a5E/6Czgn7B0cy9xhUlG3elgLLQZbOnQOqWHRUd8fqk4N6WV4xFCiNpk61E62dfG3LE+r3JlGpqET8PPlnx5U+6LNkgcwbp3VuCVoieS3APyF+z6edlpo4HgohW4DTDe1pdzGiSQ9GfgGb41VyFKAeymjyAmEwzlIylAvm3OvBeJMUhXAyt6KFGT5Ur6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iJmS7draidJ4LRcKKy6Dn6v8bSCssnnjYjiF5odlLo=;
 b=HggtnGNI8k2k+IJ0KJp/LOXRhME1cEaz8n0Jy23L6zz2JG3WZ6/UEJ25rFGiYNOK8RZCUl5VkCAOxqeR9d84COQeaL/I1B0RMpmWIZ19YZxqLhyTlv14jXeH2u6NHSYtQRd1rhaxvHyukEDRJNonuO7GSLLKlDikzDX6Rb6Ka+mR5Ldsg9F+Qu/wpEnpHfrBTr+TJ7gY3HYH7dRkPv7ePKImnxJ18VybeFQgN87QmrVBuMbqn/sfTTvlW358l0xmWyKwaKxju8b01XJFT+np+2Z39SV8ddG+Khm254/zjourcWriNcuWwhQN+9Ac0lM/oGw4Iy2nrw2cL/pTJ8dIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iJmS7draidJ4LRcKKy6Dn6v8bSCssnnjYjiF5odlLo=;
 b=CSYnB7+S7PymLRN9eQtq3jedt6f2xgb7UK53Y+neCGSjjZB/jai5v5H+DmS0dSDTR4H6Ohn4SeYiM01VADd+hPt1hOMQx04v+wJmKjIpBsXPLj8NZFIWScmbVWUUCAlhHFZaC1NNWVGfuL2vroUGeuSmIkYZBixpMeNYId9eulY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:37:08 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 09:37:08 +0000
Message-ID: <c3275383-9b3c-41b2-a65f-2df50fefafb5@amd.com>
Date: Mon, 13 May 2024 15:06:58 +0530
User-Agent: Mozilla Thunderbird
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH v2 10/10] cpufreq: amd-pstate: automatically load pstate
 driver by default
To: Perry Yuan <perry.yuan@amd.com>, Mario.Limonciello@amd.com,
 gautham.shenoy@amd.com, Ray.Huang@amd.com, Borislav.Petkov@amd.com
Cc: rafael.j.wysocki@intel.com, Alexander.Deucher@amd.com,
 Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715356532.git.perry.yuan@amd.com>
 <9b31fbcdfd4e4f00c3302f45e655aa43589b224c.1715356532.git.perry.yuan@amd.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <9b31fbcdfd4e4f00c3302f45e655aa43589b224c.1715356532.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fae4c1-3125-4529-a2ea-08dc73304185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGdmdXlnZHRFU2tlbytZQ0R5RXB0UXMzZHFLeXArVTlrRGgvajEwdTAzVHBa?=
 =?utf-8?B?QVBzM21LZEx5VlVTM2NKTHIvVVRDd21iWDhJZTcydUFvTDlONHJlaHpPblo0?=
 =?utf-8?B?VjE0bEpXS1dHbXc1Q2ZKNWlVU3JwZTluMUdRRmptcU90MVRCb3Z3VDlZWGFh?=
 =?utf-8?B?bFA5enBlWm5yMHJkYTZONWh3aEtuT2tuQWpuMkxtMllzNDlROVNZQ0Z3SWI1?=
 =?utf-8?B?amJFdWE4anIyaDFXM3llNDBOMXZmNjdIS053Y0FSa1U5VllrNFc5OThqRjIz?=
 =?utf-8?B?b2g3YVRocFNVdFBvL2Z0TlpjMkZTNHhpODVOdmFLelZUL1JsUjhDZzZPUm5r?=
 =?utf-8?B?MDFEQmFlZVRSOEFUTjljbTFWMXpkR1hYeldrV2dMd0JDckduRXBUMGFtU0ZQ?=
 =?utf-8?B?SlBCVFlaendHU2RLeWFPTVh4NEhzYmJlNnk5L243eHp6aWhXMzhINUJQSVZa?=
 =?utf-8?B?ekJSaFM5U2xjMnJEVk1rRFJBN0JhMjFPRFdya29HUTRBMVRjYkk5VnhiNFAw?=
 =?utf-8?B?dGFpbWVSd0RZaVpWVzI0S1YzRFp6dDFpV0dRdVZqQjBEWDNvNXRJSEd2Q3Q4?=
 =?utf-8?B?YktNZk5NRFlOVHRBc3MrTENRTmZNQXE4QmJKZTF2ZkRwMWdRQ3BWRTBhR09J?=
 =?utf-8?B?ZXBEenZvWEJIcWlDUkRjUlloZERsWHgyblcrSE92cHNwNkt3UGU1TW1hcVB0?=
 =?utf-8?B?elRlM2pZTlVZSC90Um9NaWFGZHJ5aHkvalVoR3lIZWV1Y2ptcS8wdUd5OG5J?=
 =?utf-8?B?VXgvN1lWS1ZMUkprSlVPS1dtb1prNWNiU3NYVVg4ejFLUXFxTFM1QVZYU3Bj?=
 =?utf-8?B?R29xV0V1aEx4NW42OG1SaUJnRnBLOFUzdHNDZnVmTTkyUjh2YVZIZDhiTGdM?=
 =?utf-8?B?SW9WRG9VZ0hHeTJjR2NFb2xIWGZlZFZPRjM1T0huMkVib0VTSXpnSjdZczBM?=
 =?utf-8?B?YWVSby9vbGtyRGkzaEsrdzB1RjRvYzhvQ0Q2TEdQZ1hPakRESE5mMWUwUG80?=
 =?utf-8?B?Mk45SXlCSm5wVG12ejMwVXp2MHRDK21aamc4T1FCSjZ6cEhaS1VZVnNjbHAw?=
 =?utf-8?B?RURHZzRCc09GVHU1Wkp3Q3E4dEtsb09FS2daeUFYdCtZampsWHNRY09XTCs2?=
 =?utf-8?B?WTJNVDBFZDNBK05SYWtaMm9STjBBK0VOQkRwTVQyK0VHNjNLaCtsV0k0dUpl?=
 =?utf-8?B?MjdrYllXK1oxaU9VVFh1dTZPSnI5c0hTSzY2OGFXVlVrd3dFNzdkV0lFbFZU?=
 =?utf-8?B?bk42ZkVDbytUUzBWTlQvWkZJcmY3a3M2VVhpZytVdnQyb2lSQituRDkxSEtS?=
 =?utf-8?B?UHkzUmFZUSt6WFBOdXN1cTVldHpuL0psR1FsMjhWQThvZkdabVRqenR4N1I0?=
 =?utf-8?B?USsyWmN1ZTlJd003ZnhVNzBzL05nYmEvYzNmK3NVNzQvOUF5S1VDWlFpa2Ex?=
 =?utf-8?B?MHpESHRUM2V0ZFZJR3I4d3NBc0hUWWhRUW8yNG9ENGNJMTFuT1YwanFqZ2tW?=
 =?utf-8?B?UnB4NXBRV05PaVdMT1UrdEdMSlRPR28remNGOHBJbUZlVFpFQjBRVllvOXQ1?=
 =?utf-8?B?Z0hBN1F2eFoxWHhuSGkrNldLcmI5ZXNhZWJHNVpMbmY5cGRldmU5aS9SYkFm?=
 =?utf-8?Q?goevHHL9j1S5j1wLwFPY2RmJy3vuhgfR8dXTOyQJK6sA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm94YmlDNEhRbXJOTXptNkVrQWgwZzIybjNrN1dtZkdMZjNpc2lPcERNTjYx?=
 =?utf-8?B?OUQ3NEtqenhUQVdRdTJaWVFGVnBLQTN4VDRBYmU5R1E1Qkg2VXZsWWFTZVpD?=
 =?utf-8?B?QjlRWEV0SEVhclNPS1N4RkhTbnI5bTI5M04vUDVjeGlDVUdSSDlLeUlBS0Ux?=
 =?utf-8?B?R2QvcHJsME1nSVB1UCtFZEFib0dFYjVpMHE3VGJSaXF1R3FHdDczY0NXQTV6?=
 =?utf-8?B?QU56TmkwVTk1Y1pPUWNUaHQwQWVOcEl5YVExcUI2RXpzdUhvMFhWUDM0UTNB?=
 =?utf-8?B?V0ZjSmZIRys1TGdSZis4WDhQanlySGtCU0RqV20vbjBHckNaaXBxaGhIb2M2?=
 =?utf-8?B?SzJ4UjZ5UjRvTk40NHozZjdVd0l4aGRDbWxFaUkvVk9JQlUxdDJQSjMyeDNa?=
 =?utf-8?B?VXA4Uk9TM2V4eXIwMVhHWmVYYUw0TWlLRmtYUXk2VDFhSGJvYjQ2NjNKRGc5?=
 =?utf-8?B?bi9STW5NSXhESklqRkhybTVGbnVsWmZDY0o1ZEJiSHVBbW53dzNjRTA0TGhv?=
 =?utf-8?B?SGNYQms5SXBQbnIvdHJWd1JMdmFZTXI5ck10eXpSbUV2a3lQQUJXM2J4MXVI?=
 =?utf-8?B?ODNZRGgvK1N3dDQ2T0hBdWVvZUZsVC9GUnl2MXNHQVV6VG45NlRBZlJMR1Ir?=
 =?utf-8?B?VWE3UUZzVWo2SzdKdHRLZ2pwU0FWQ3o4M3FJNUZxMXp2Z0Rrb3ptWlRpV1Nv?=
 =?utf-8?B?UHEvQWFKTGV1SVVRY0ZFR0lDdVlINUZRTmcwVGJ4RW9nY2diejh4NFZqaUZB?=
 =?utf-8?B?QjNXd29uNU5DbUEvZ1oxMzBLclQ0SWN6eExQWEdHZ21BTHZiQU5qSEJjc2ND?=
 =?utf-8?B?S2JMNVZRdkhoeWdJN05mOFkxS1ZHZHdVQ2pOUGw2dG12eW56RS80R0RiOTNT?=
 =?utf-8?B?UmZob09uRTRJekcvbkxSb0JLaDgyakZidFZHdHJSUjg2b09YRUhPeGI1WDcv?=
 =?utf-8?B?VlRFWG9WTTA2UzhrV2hlVzArclYrV2ZNT2l5QXlWOEhadnA3Yml1eXVjNk9B?=
 =?utf-8?B?RmQ4anl0QUNhQk1HUkFyRHQ3YkZMN0hOTUZtaTcrbzFFbDN3STluMGZjSGVh?=
 =?utf-8?B?ZTg3S0RYcXkwOEdhS3EvUjQ2VlYvQjRPYmtuZkEyejFPdmxhalB4dGpGU2kw?=
 =?utf-8?B?S3pGOTJlV3FQT3RqQS9wWjA1cVQ4Qk9nTjVzMXFZTjNTVm9FemMwNFNFdk5X?=
 =?utf-8?B?ZUdUaDBoRGlJT0hoZDFobVYxcHpoYytjVmVMNWxZUjROOFVtaHZ0YzVaOUJM?=
 =?utf-8?B?MnB4TFhidW1NSWNBaWFuRVcyTGdqd2UxSnZuTWo0YTNKUGgzZHhKTG0vOTJk?=
 =?utf-8?B?ckt5WllMR1R4clhJSWdKVWwxKzFLclFldTNvN3Y1Qmt1ZmM2cmdtUEJqTUEv?=
 =?utf-8?B?RzBIZDVLTHBISGtDbnZ6SnVRRjM2SURmYWM0M1ZJWFR0OGJZbGlhUFFYVXdT?=
 =?utf-8?B?cXcxdzUvWGFwVUdKUzdXY3NaeXlUUGRkcE9JZkpOUHFQRHNCbHZLYW5rQ2ZP?=
 =?utf-8?B?QkhqRkpFRFNJVWpJeDJYTWRlMyt3dDVkR2FoWFNmLy8vUkF2NEZQeThxbEYv?=
 =?utf-8?B?eGhCU2JzRWdIZDdhQldOQUkwaUJ4VHNFNlZCTWpwbEdpNjNobGkvZkh1OHQv?=
 =?utf-8?B?eStOYjNEVnkxWGordkM0NkNaTktUUVlreU4wY3JTWlNURGtac1lHR0pVcElW?=
 =?utf-8?B?SElJNEFyQkNQNVFSN2h4V3lEaWxRYTRQcXZHUHgvK3haUndHNnNLTW93R2pB?=
 =?utf-8?B?cVVCVUwxdWJkc2p5cjNJaXVFRmxzZWxybitESmQ5dFluSEdRODZJdHVDUjhZ?=
 =?utf-8?B?eWdZa1Y0aS9UU1Y4cFhERUYzYmcyMGVocGlTQ3d2TnZDTUNyZXdhcE1ncEVy?=
 =?utf-8?B?bkFGTFpwN3NaU3F4WjFKdU5UYTAwNVZMTlErekptWU5MdzhWeVJEd0RiN0Ji?=
 =?utf-8?B?Y0pyc1BveWR1SnJyNk1HMWxNcisvbk5rK0dzTGFhMlk4WUZjUWl3S0VIOENh?=
 =?utf-8?B?QzkvOTR0Z0FnbEh6VkU2S20xeUtQWmdtRmdPMDFXMk5YaytSWm1TMlJQSlBI?=
 =?utf-8?B?WVZ5MkkyRnhMSzJ5RDJFRXUva24xbno0VmgrUUJZY3hUL1dwSXNldktJeVNl?=
 =?utf-8?Q?WqO1+kCDgtyxnqxROKKHsy5kl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fae4c1-3125-4529-a2ea-08dc73304185
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:37:07.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rAG4bxgs1fVKgwGhaBrH5w1MxEvUk80iT0PEAwrP5HvGmC2z+HDfoVfzgfSLyxVrikWKK0OYmamPb5Yz6juew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388

Hello Perry,

On 5/13/2024 7:37 AM, Perry Yuan wrote:
> If the `amd-pstate` driver is not loaded automatically by default,
> it is because the kernel command line parameter has not been added.
> To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
> function to enable the desired mode (passive/active/guided) before registering
> the driver instance.
> This ensures that the driver is loaded correctly without relying on the kernel
> command line parameter.
> 
> [    0.917789] usb usb6: Manufacturer: Linux 6.9.0-rc6-amd-pstate-new-fix-v1 xhci-hcd
> [    0.982579] amd_pstate: failed to register with return -22
> 
> Reported-by: Andrei Amuraritei <andamu@posteo.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index dce901a403c9..03342fef7d94 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1785,28 +1785,30 @@ static int __init amd_pstate_init(void)
>  	/* check if this machine need CPPC quirks */
>  	dmi_check_system(amd_pstate_quirks_table);
>  
> +	/* get default driver mode for loading */
> +	if (cppc_state == AMD_PSTATE_UNDEFINED)
> +		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
> +
> +	/* Disable on the following configs by default:
> +	 * 1. Undefined platforms
> +	 * 2. Server platforms
> +	 */
> +	if (amd_pstate_acpi_pm_profile_undefined() ||
> +		amd_pstate_acpi_pm_profile_server()) {
> +		pr_info("driver load is disabled for server or undefined platform\n");
> +		return -ENODEV;
> +	}
> +

Wont this change make it impossible to use amd-pstate on server platforms? It wont work
even if we pass "amd-pstate=active" in cmdline, because this check is before the switch
case.

Thanks,
Dhananjay

>  	switch (cppc_state) {
> -	case AMD_PSTATE_UNDEFINED:
> -		/* Disable on the following configs by default:
> -		 * 1. Undefined platforms
> -		 * 2. Server platforms
> -		 * 3. Shared memory designs
> -		 */
> -		if (amd_pstate_acpi_pm_profile_undefined() ||
> -		    amd_pstate_acpi_pm_profile_server() ||
> -		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -			pr_info("driver load is disabled, boot with specific mode to enable this\n");
> -			return -ENODEV;
> -		}
> -		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
> -		if (ret)
> -			return ret;
> -		break;
>  	case AMD_PSTATE_DISABLE:
> +		pr_info("driver load is disabled, boot with specific mode to enable this\n");
>  		return -ENODEV;
>  	case AMD_PSTATE_PASSIVE:
>  	case AMD_PSTATE_ACTIVE:
>  	case AMD_PSTATE_GUIDED:
> +		ret = amd_pstate_set_driver(cppc_state);
> +		if (ret)
> +			return ret;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1827,7 +1829,7 @@ static int __init amd_pstate_init(void)
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> -		pr_err("failed to enable with return %d\n", ret);
> +		pr_err("failed to enable driver mode(%d)\n", cppc_state);
>  		return ret;
>  	}
>  


