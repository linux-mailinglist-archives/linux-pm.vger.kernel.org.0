Return-Path: <linux-pm+bounces-15288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFCC99334F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCC0B223E4
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ADB17B4E1;
	Mon,  7 Oct 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N26x/UbL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514112E75;
	Mon,  7 Oct 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318711; cv=fail; b=Tojlazw8CjwvZXPtk2k5+ngVcxHKsmX0BsZbhNmX+eG12XmLXqgQ8SX/ZFt8AJ/ci5hIhYtbUpqedSMEg4u/TI6NLPtnEmyAwBOAJM3HdSumjaCmGmtRlSTDOqe1dtWaHjlfHDyuPH/oj/ySxbbtozCPpIZZZ4rvCJ32jgn43VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318711; c=relaxed/simple;
	bh=sgaSsppZfvrcHPUAtVYZBaYbztxjk9tBjHkA3UZbQT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cp1HoMh7/8I4AfzMLiMKPb6r4Cb5BREzTIPjR8Ll0URhZnlKz2G4EJA9Fbqsb3jI6dPehrlNgqDqi/iH1IJDx0XuDS4OGyjK49Nc36hURRs807vvxMoHl1gU+w/6uoNgzZJA9OVKBRnzlibK2xh1fhf8nG2HKut7r9zxcxR5cCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N26x/UbL; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo1/cdkdTg13bHhjLwrbz5r4oUCLl0Rc+6a6M3+oVQnpkIAbtN4kvhilWh/jCA+T9g53i98/kYInWaYTqzTF1yVo9ZRKuZ1L6UAs03tbjZmY8Pee60zG2jtk0MKniZMrhrHZomK4/psD0czKa8scBUkoz7yeS6TPS8IISbNOcBP/X0EFZRCKiqKkuD1RMrsUJGrxBfzF2R04ajjMVXOHBHONzsB7UBLDe9m7GMgL8AQktFGJQfRNm2PCn4PuQlPRND6uD8KQHxOb0fWQHzY8PITSfI/C0ApsaCVe+RVcxkR1NIokIWGw7Z5hycFGC3MipeAX1VtdJtk5cGHICxBvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5fcgiELtUM7VU7vxAUmrhDQ9MpSec4//MZugMTz5Z8=;
 b=Hv3dUIFaaq8G0x/3KIgR7gf+J4mqIwMwawEmfUWUDzqQ528aRMRErAanrc0DP66ZrJb7Uka3MvpwCdVcsJeXgf5W3fJ8DERQonawb1CQWJ1yCKMJYrTAiYl8kxLVGiOPNQ9MY2mRW3pHhX2LOgOZEXn9wzDmWI6iatYOeibsJzulBWo2R/YqBiUid+0p/mLEhE/Pd5Zp8uEHIYaLSzbn2An2XhjWgkO6iE0uGcYGkT9CN4nJx+RbJ24ytewzrIQrmBxfSF8SlukHj8kO/sJlvKQgASnHOATJ4zzkHb1CeINrSjJssfm5RbGQmZO6wisLp0G0txBV4ilGunNAt0wkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5fcgiELtUM7VU7vxAUmrhDQ9MpSec4//MZugMTz5Z8=;
 b=N26x/UbL9wC6b2+Nk/gxAQJp2jiBDRSXyLKuD8XXe7/UlTFm3/+0nP0Aj/bDLxQnmOHkU7buNqKIYpPxGH1Icg04sbw+hMbHAiKACk9p8PQctC/JNF1yj4p9JgqLwChkTmgSmK+G+2guR0dV1GzzD2QBHaeHKB6rzaTaVp6KDP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 16:31:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 16:31:47 +0000
Message-ID: <ab486635-1827-49b5-9e5f-73f62b86c82a@amd.com>
Date: Mon, 7 Oct 2024 11:31:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix amd_pstate mode switch on shared
 memory systems
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 gautham.shenoy@amd.com, perry.yuan@amd.com, ray.huang@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
References: <20241004122303.94283-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241004122303.94283-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:806:23::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7fc7d4-1e62-4682-e791-08dce6ed89b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlRCVG53VURhWE9nRTNnK0cwOFB2anNRMHZuWUJvZUlVaVNwUDkxYktLUml1?=
 =?utf-8?B?S1hta3hWVGEzYVdJZTNkRnhlbTNFN1ZWUkRITHV4ekR1NjlEOFJ0R0xROE5x?=
 =?utf-8?B?NkVvM3JXWjVCNS9ESWgrR2dmR2tRTTZuMko0OFljRHVHWmFvTWlaK1d2dGtH?=
 =?utf-8?B?MnNMRmJxeHE3blc3eHltR2xtaUxPU3g2RFlZREVMYlhtTkN4a2NPak44RTJX?=
 =?utf-8?B?K0xrd296YUkyRURWeGh1WFIzNy9oWnNMU3dQSkU2aEdHYm5kZlhWRjFmS3Zq?=
 =?utf-8?B?ZFJDRG9vNjNuVkdGek9oMWhyTHRFeisyN1B6VS95WUZHNXJzQW1XMnR4TkRF?=
 =?utf-8?B?ODliUHBUUU9tQnZ6UUg5b0NJL21maW1GMExaUDh3ZDl4ZFVzb2V2ZXpxN3B2?=
 =?utf-8?B?cmR6eVY3dVRaRzBnVmYxeVlHQ1NmTEJsaFA4L3Z4dVcxbW96Qi9YK3NUaG5Z?=
 =?utf-8?B?dE5uVjFxN1hyUDVDOUlMM2JtL1ZsY3FYUW1DM3NYL3JpcnpacWQydHcwd2FJ?=
 =?utf-8?B?U2t5S2J4c3pMbkN3R3NkQVlBMHpCVFJLbytySUVKTCtIOW1pRjRyWXE1S1Zu?=
 =?utf-8?B?Q1Qyb1NDWXVuZi93YWk2dUo3cW1OWFhKbkpxNjJ0VU8yRVhoaHdvMHJpaUYv?=
 =?utf-8?B?MW5mVlNkZGVseUI0bHMraVNxQUltQzViWm9FckxwTWVidGF1ZjZFckhTbzhj?=
 =?utf-8?B?U2pRaTRZQmx0WWtyMjZDQXRDUFpTYTY1bjBYdmRXOW55V1J1QWlHcU85Ui93?=
 =?utf-8?B?cjQzQkhkazhlc0s0cTk1c3ZqN0tuYVZYcUFnaHI4U2plMlRScmdma0lCc200?=
 =?utf-8?B?R2JFb0ovMlZWbW91ZEp4S3d2NWV0K1hiVEhsRXZYSStITjRvYzk5YVlMQ0ZS?=
 =?utf-8?B?UjVGakFrYXBtcWIzR21DSTM2TXFHbVpaeTdpQTBIQXBRZnJ0eThBRlQzRFVu?=
 =?utf-8?B?eVVGdEU0Zi9NNjRIbjNrczZMMzhUa3JCdHNpR1JLU3M2dW8wWFh4RS9WTUg1?=
 =?utf-8?B?ZnpWVWFFcUNrR2RBeGV0NFFNbGZsSjRGdUFrMWFvUlVleDZIZklLQzRaZmt3?=
 =?utf-8?B?WVRoT09UOVZsc1Y5RXdML0wzVHNxKzV2Tk43SENlL01jcnc3T2JiK05PVkR5?=
 =?utf-8?B?cnk4N0dLYndZMmlIYkhrVDhXVnlTWEFHTEt4UW15NHR3Smhmam9YMitsWXYv?=
 =?utf-8?B?Mk9MbXpHZEk3TXBwQlJqUXNOcHlQM0tta3ZRSm1FeERpSW9jZ2Q2UDkvaFN0?=
 =?utf-8?B?dzV5NE51NjJycmh4dXlPb3NHTXFUSlU5Nzg5NHZIMStBVVZZTUFkRTZSY2tm?=
 =?utf-8?B?bnR2RkFwVWpmQUJUMnJyVEdDbm80M2IrTy95YUhjWnZibFFNK3NkMWNCMTV4?=
 =?utf-8?B?VDIxOWNKME5JM3dJUTFEbmo4bWtDOXJBRnJhSjRmUmJtYVJwdmVEYk90a29l?=
 =?utf-8?B?Y0NCTk5yOWdsTGgzUFErVXdBUnRkRDJBeGJBd3ZZRkw3SkFVV1NaR0NTUjlQ?=
 =?utf-8?B?T3JrNXhyU0R1K0lGTkYyRWs4aWhaNTdFZXRPRDNRb2VPL3B5cGV5YXhuUTNu?=
 =?utf-8?B?ODJEM3hCWjh3Q0VhMzdJYVhkYnloeDZFWlVyQW1GbzhYVlNwSncvMnR2SHd1?=
 =?utf-8?B?d3gyTklZMytIbDdabUVxcUFBbCsrNFNIbW4wUStqenNPRlYwcHNhVytkdTZZ?=
 =?utf-8?B?TkR0bDRmdHZEWXlNWWcyelIrV0Fsa2RYb09EMUJadUlLMWFQTmg2MHN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akdCK1MxMzhuYzVET1NmOXdzaSt3R2w2eWpSYmZ5dnRiRTV4VmZEMW11OFVS?=
 =?utf-8?B?Ry9XS2srVTkvMGtUSXdKZnJRL1VlRDRhNnh2NnVPRnE4dE1WNFhqcHY4c2J2?=
 =?utf-8?B?NVFwT2dUNDBlbmRnRk1waHI5bWJGcU1TMEs0N2pTYWNYVTVocHlPUDJab1hy?=
 =?utf-8?B?Z1Q1aG9VQW9WQ3JpLzdLei94b1VtT2RIaGptZG85blBOaXZrWEl1SklTZVlZ?=
 =?utf-8?B?QkdZUkREaXJBbGloZVZqaFJiZHJsTjN6cG9PNzF2Szdmc3dGeE9NTkFOOHlk?=
 =?utf-8?B?a0xYN05aSm8vYnVWUGlSTjdQK1pHOUlQSW9SZ2tiMDlZYXhqblM0eTBzQkFo?=
 =?utf-8?B?T00rNFF3bi9qYk5nU1hoSnM1aEtIU3VrSUtjU0dRVUxxbWV6ZWFIelZkeklW?=
 =?utf-8?B?VHlKQ2RjVERZejZSM3BVazdnUWNBTHR3MHpNS3NEZVV4OTJ0Y25FQzlUUzYx?=
 =?utf-8?B?UjFpbjVPY2VYNlVlYXpZS0NXV3Y4dzdnQjdqREYrVFIwcXgrN1RLTGJpMFZQ?=
 =?utf-8?B?S2tzRjdFcGUzOFU3MDh1VWk3aEZVZzE0Ukh2VlhHREFmV05FVDUybHpRNjc0?=
 =?utf-8?B?NVZ6a1V1ZGo1amxCZWtmdEV1NXplb0xwRDVYZU15YUhTbGdjNjlHNy8yUk5O?=
 =?utf-8?B?QXJkb2ZRTjNUaXRwbjJNd28wMEhCZk9sWEprT3FvS3JENSt0Um02SlRPclpt?=
 =?utf-8?B?MHYzeVlTRUh1ZEJPaUk2cXRxS0ZvVzJYN2QreVdtd1F4SGx5MEJBcU9sbHZq?=
 =?utf-8?B?T0lPY0c1amtCbGtwZENONWFYQjh1cHZta2VDU2JVemc4L3NDbjhWeWpZejAy?=
 =?utf-8?B?MElJOFl1U3orRXp1c2h1RUhURzBJY3NPbWRIdnhoOHh5bXdwVHd4UmJHK1cy?=
 =?utf-8?B?NDZyVnpoZUxjQWJja1A3ZHp4ZzlwWDdTTzFyMUFwUDZKQ1h6RlhHdjg0ZGFu?=
 =?utf-8?B?MFpvYUsyT3VEOWVSa1B0cEZzcXRyNVdWcnNoQTNGT3lSVGt2WjFMaXhvWEZQ?=
 =?utf-8?B?b2ZHeFV1V2NZMTF6b29LWWdEcUVvaVJQS0ppRHBCN3R4ZCtwVS9ieXZEdUlJ?=
 =?utf-8?B?WXdZNitKdHRBV0JiM3ZRaGF3dmc5bUtoZHhwendxUGtjUGZJWkFScTIxRWlT?=
 =?utf-8?B?TDZncHY1TThNYSsvOU82UkhyZkRyR3dPeE52NlR3RFlIcUFSWTZwQjJsY3BR?=
 =?utf-8?B?TkI4VXNWYU5lcHp1S2toUGQvaHlXeUhUc1U1bXRYNXVlY0Y3Z1NneUNheHM1?=
 =?utf-8?B?R0dQYVNrWC9MbFVmV0VIZGhpOHllZFJxU1ErTEZCNFBlVmFBckE5NFpLcFF3?=
 =?utf-8?B?SUVBWkV4d1NhQXFaZmNHZTNhczhDdGZ4N0ZBRDZ2UHI1R1FXWXRKeDVqeEUx?=
 =?utf-8?B?a3dvQzZ3THhjRmJXMlFxQ2VDaGNwUEJ3cDJqc1NXbmdRWFVkb05XajY5M2Vv?=
 =?utf-8?B?cnlncWlReVFXTC9NR3ZxRTh0bDZPYjZ3OGJPSEozYTZ4cHZLWXFOSVg2STlz?=
 =?utf-8?B?TlN0MUVOL3pqdDJXcE51VXlkUTZDRWxNTFQ4ZldoTVRsSkptY21hcURlZXVk?=
 =?utf-8?B?eklncktrbWZZTHJPRjhQZmlyYldsL3lURjJVN3FaWUpxc1IxaGhwQVVHbk9m?=
 =?utf-8?B?SzlQdG5tZEpiNFRsK0k2cWI2OHBydTVaVXZlZEtqMkVrMEMyclVKMWorZzAw?=
 =?utf-8?B?aHVCZnVRSXBvdDlRSFU1RWs3UFRmN0tSWHI3N2Q1R3RWZVN6dmc2UEs1M2NY?=
 =?utf-8?B?SGtqSVo1Q0wxajNFemdlTVRkcm1wbUtoemdHYmswbGRta3g4OEhDTTlpblNz?=
 =?utf-8?B?Wk14bWVtRVNRTDdQRHBaTXgrc0NqVXhDa0I5c0d6NnJybGZPeUx4T0xlbEs1?=
 =?utf-8?B?SkRmK0JGL0M3NVZSQWU5TW4rSEpzd05aNTlwWEQ2eXpZTVZYYXA2US9zUTFk?=
 =?utf-8?B?dHJQWTVVZURiYXJCUEdwVDZENnJCaXVXVnZvRERhRk80NVZuQjhRSUZjS05l?=
 =?utf-8?B?ZENyOU1QMXFvUkU2Y2VURDhLUHdTWno3VlpnU1RkTHB1WTE1dXZFcXZ1QSti?=
 =?utf-8?B?WmhST1N3OUZJeTgvUmU3YkJQa294djAwUW1tRzlYa2taRVlwQlZwbE5TU2dm?=
 =?utf-8?Q?F2LAS8jize2NcyqGxP34B9f2Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7fc7d4-1e62-4682-e791-08dce6ed89b9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:31:47.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KkPfh05jwWezwTpF2x2I18kw+ow0SFMDgakS6ESPAw78bx9slYCvhLwTdQQCfgTUNkoK6a9m7ZMQb08eUCocA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250

On 10/4/2024 07:23, Dhananjay Ugwekar wrote:
> While switching the driver mode between active and passive, Collaborative
> Processor Performance Control (CPPC) is disabled in
> amd_pstate_unregister_driver(). But, it is not enabled back while registering
> the new driver (passive or active). This leads to the new driver mode not
> working correctly, so enable it back in amd_pstate_register_driver().
> 
> Fixes: 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control support via sysfs")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I think as a minimally risky fix to go to 6.12-rcX this makes sense, but 
looking at all this code there is a bit of duplication that exists that 
we should do a more general cleanup for 6.13.

So I'll queue this up in my -fixes branch for 6.12-rcX. but please do 
the bigger cleanup as a follow up that we can land for 6.13.

> ---
>   drivers/cpufreq/amd-pstate.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cdc08d2ddd52..4acf5fbeb116 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1191,11 +1191,21 @@ static int amd_pstate_register_driver(int mode)
>   		return -EINVAL;
>   
>   	cppc_state = mode;
> +
> +	ret = amd_pstate_enable(true);
> +	if (ret) {
> +		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
> +		       ret);
> +		amd_pstate_driver_cleanup();
> +		return ret;
> +	}
> +
>   	ret = cpufreq_register_driver(current_pstate_driver);
>   	if (ret) {
>   		amd_pstate_driver_cleanup();
>   		return ret;
>   	}
> +
>   	return 0;
>   }
>   


