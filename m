Return-Path: <linux-pm+bounces-22765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E43A41517
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FBA16E0B8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17E1A9B39;
	Mon, 24 Feb 2025 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2YL4KoHb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8C28DB3;
	Mon, 24 Feb 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377376; cv=fail; b=Cz2eYFw+K/MNvn/9X1a1l3xZ13pCta5gcDxPz+LqDi96Bp/7DpVx9gBa17aks358b+sbY1ar1+vMiBh52PmOGVXDGI3+yZzBenX8/XCaUnguuC4BuZRWExr9Ge3HjYU+M8Mv1t5jmeeKagM7JHBoVbb3ldEIjuO2PHucRJW7dD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377376; c=relaxed/simple;
	bh=FkpDDlTlc9c9YEKF1v3UTqJ83w7Tb9zoPnnsf1T01aE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TyWZysDCR4GwKiqhZ1DLZ/i/IXcACeuCSnIpXzg33Dm7WSlkcIvSkY6ICEH9SuhqwoL6xFXL1ymEp+SFlWxy2oiaN6Lfv38pE9bOepT57VBOv+/zeCva4CH88iKiPx+UT6nHFmk4jcxhcOgaMahBxgnQK63LxywTtqWnQVJ7xPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2YL4KoHb; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE8aBI3OCeKUEgv71umUT44WDnoi91rxN7+t61dvOLj2tFh+RAnIVunzJShxrnQbt2krPxFELsvOPkzFYq4/gL71StGSzOX9QkC2RQavWhGLfmN8zQh4RJBax4A3UStizO3Nd6SVuVi3crnW1rX4zRple04nEvSWEEmHrpcJeS7iM5qgm+cIrueP+bg3Q15yR4Y9pTPLkGQ5yH5ZEZVg/4CcHhGgfc+24jfmLVv6iyximIRt1alsSIgG13zh/hzXK9du0duM9emj2FdxA5aNF9beDBuQ9qLGdLJ9E1ilDQM2v23Llrs54N9CROXjHPTYVJPLjwQNMuoyxFOW5+23ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r34ciG4fL2z39kDDWfCVooLKcBtjOaE0A2/cwX1KgJw=;
 b=KdyfqpwIE0D1f0F84C6Bu3Lz2SL7/FdXPkxI6KrQvDShiWSe58nus9BNEBGH6XxWfzU9t3e9BFybRAS/OEJZqQJpPiNv2ZIiyhmipVoXOK9uzLPOV9Ea7Q33xV3paikDNn1o7go8GbBbH+1rYBo/+GWbPGUK0q8jK2blhDj0pEO+E0Uggi1+RoF/nHeymER9lBBppSoxF1HX14+HJXKRjrXZFre/gI1fBSC2r9vkQTVshdH/rvgiTkaNlj5o+y4GhsrGvBgo8pyVvD/lQqwZcG/fWBxRZn+ND4bdIiE7aHjAL2R8oQQhzj3QSg+mQLsnLhIVAEcKK4ie5O4WyQboJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r34ciG4fL2z39kDDWfCVooLKcBtjOaE0A2/cwX1KgJw=;
 b=2YL4KoHbDeKt3Dge8tVNbhFWZYV3BoQh1PXD1xQA3qt4J8ooO0e9/0wcrvwNVX3nhYHdgDBzMnFe8RGrnGAwY4DeqclJZWzcHml3siilUyKATyY1QLwJ/qqTTFlMntQke1CHpr/XbDZSjBcnyDvXtGxsqf5JvLlXPsKyWqV/IPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 06:09:29 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 06:09:28 +0000
Message-ID: <cebac516-37d0-4752-833d-5b8bbd1c187b@amd.com>
Date: Mon, 24 Feb 2025 11:39:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/19] cpufreq/amd-pstate-ut: Run on all of the correct
 CPUs
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-11-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250219210302.442954-11-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 5788f900-3f7e-4d3c-8bac-08dd5499cba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVdDQnEveHNnWkNsbjUxZ09CWE1zMWdhNXdFcElXVFRxZnhpSENuNU1Qd3A1?=
 =?utf-8?B?S1VYeGFpbkdpT0hISTJ4alMrd29iMGh0UUJHZDlMVkJwN0Zyc3lmTDRKK25Y?=
 =?utf-8?B?SmoyVTZRelB1Q2pnZHVCYzFZSmp6UVJEOWlNM1BJTGFDMzRxZXlLU3JsZ2dG?=
 =?utf-8?B?YWp0cU50elJqUlY2VGNST3dtWmgzODZRVmZGemFlbGdwMjNQM1dMR2VBUDg0?=
 =?utf-8?B?K2FPR25Pa3plS3NoNEVGZWROV3lKU3VVa1ppRHh3aVlCK1FrajBqL3NOd2Rq?=
 =?utf-8?B?L0pTNit5ODk1WjBPZXVFVUg1TnVTL3FER0M2ZHdhNitrVWdGQ0ZEUm1XZGVP?=
 =?utf-8?B?SXVybVFJL0JpclpoSlFHbDZXN3dYOG9URzVxaUpvOHpHaDJiRldiVmNZUTdi?=
 =?utf-8?B?UzlUNDEwQjJRTU41UEhvK05uRVRQaHJ4OW11ZkVxTjZpejBGWjZrTmdxVHVn?=
 =?utf-8?B?eXlYVG10bm0rSGVHWlQ5Rksvb1A0bHI5TTgveXlHaFpLbG1DMTNWRXpUeGo4?=
 =?utf-8?B?Mm9iQllkWXU5ZkF0bHBaS1JJTjR5NDdRZVBLKzBxVS96dmdSNTJFV2RscmU4?=
 =?utf-8?B?dHRHTmhxb01PYlBkUW9FZmF0dWo2UEVjbUdzeDF5MGUzK1ptdFFhZisrdFdn?=
 =?utf-8?B?Umk0aVpxdDhnL0RJTE1wSUJNd2xJVS83NXJ1bmtCWk1mZUhNZmV0SE9Tb1U2?=
 =?utf-8?B?YzhOWmQxQWloUFlWS0ZXVm9NR0lPRmFMdExmVnc3TzdUOVU3RnN5dU9BU0Mw?=
 =?utf-8?B?Ym8zcmhMNEdoSUJaNlJQZytueVppUmxWZjNVNklzSGRMZi9qWlFlbnc2Z0Ft?=
 =?utf-8?B?RWs0Ni9NcWI2VytYUGdQUTN2cE5JVTIrc1QzV3ljNU1LYUZ3Nm93Q21Mblov?=
 =?utf-8?B?K20zQk5Ua2RYKzBjUWU4QWc4cUNRcW1nR2QwcnFVNUZ2cUNpU3V2bXhCUmdl?=
 =?utf-8?B?L2tualVMSmxGamlHTkJaRzZlajIwMy9HeThnUDQ2QXNVV1NoSmYvOTAwM2tr?=
 =?utf-8?B?b25hMzBURjhDVG1NaVFFTUJjR0hUSS92d0gxVGlCdUxwcE1nT3RoZWRvTHNn?=
 =?utf-8?B?RW0vRHUwRzFGZ3Z5SnpreEpYc21GdVR1VjhoNU9IKzB1RlR6aTBYeWxIRlMw?=
 =?utf-8?B?SzlaQjN3SVQxWENoZ3grNS8zTms3bzlhUnIrcjJRVStJZ3RCMU9xSVJxWGk2?=
 =?utf-8?B?Rk1aeUhsd0pCZWtDL2VWVEFMMXBGWXl5MmViSE9RWStDblBhcXZYZU5PVGxS?=
 =?utf-8?B?anJ6V3BmQnRqK3Q3bWkwQUJyUVhyUUNHcXNwVkdTVU1yRWNJRDg4N1BxYUR3?=
 =?utf-8?B?MFI3cm9JanUwSng2Rm90cDdEYUR4OFQzck9ZRDJvT0VXUzlEcE1lazB5c1Bq?=
 =?utf-8?B?SjVoYVJMNlFmLzRRTTlIRytkQVpMWUhrTE5velAxSjBIeVgyOStnUUNpUjl1?=
 =?utf-8?B?Q2VWZUhRWXFjWjlyeGpQck80a3Zua1lWTHhGUnJzY3JsNXdwRWhXMCtsQ1NG?=
 =?utf-8?B?L1lHbnFyYyttc1ZBQzgwRWpSTzVnTXA2djV6VmNrc0xsTWNvR3lTNm1NUHUw?=
 =?utf-8?B?Y1FyU0lEcTdpNVRwNDM3RnBBVEN6WmJkRmVhVFJCQnBCTzcvaVJXNDRGdTlm?=
 =?utf-8?B?bnVoa21ybFdxN3lnTlJWQU0vT0hKNk5GMHZmYWdHdUNuZDE2bDBsMS94amhW?=
 =?utf-8?B?RWhqZVdGUXFGQnIyS2xublZMNGxtQmtGM3NtajBsUzNzcVRaQUJBczlJa1Mr?=
 =?utf-8?B?ci93YTZubkpyL09tdCtTRC90aS9mWGwrNDNTK0h5V2xEQ2xlUHFRR2wvSGRS?=
 =?utf-8?B?Wm9qV1lSSS9CK0ZLa2ovWFZJQ1pWa3JRMmJVS1ZUL0twNUFVTTBlUG1zdHhC?=
 =?utf-8?Q?p93B5/j8D1mot?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2JqWHY2Wi9EbWdDemNSVE1QVk40MlRaWDJVWkl5bDNGU2Z2Z3NFLzh2dHp0?=
 =?utf-8?B?QjhhbkV1Z1phMk9CQkdjb09QZ2NhZXNtSnk2Vjd3dFRZckpKN2FlTERUWkhi?=
 =?utf-8?B?QjlHZE5QbC9DbVgxbWZ5UFhqY2k2QlBjTnVYMkErNWxwc0Y5bzlsZlU4WWp0?=
 =?utf-8?B?UE5qaDJDZlgvYVd0YWN3eTNwM2tzMDF5SENFeHYzL3c5SDlEOEJnSmJ5akdD?=
 =?utf-8?B?WDRJdk01VTJzWkNaSFdmSlk3RGlXZ2dXTWdhN3UzMjZNTjJkRGlmVjJlaHJ6?=
 =?utf-8?B?eVJaOXVYZ1B5MUtnSGE1NjRvUnFIdCtXdWxWRC9zcDZMbTdqelNWZ05xempM?=
 =?utf-8?B?RElBRG0wb0ZyM3lvRUtqOE1hdWtKUU8vbEt0Qyt2SmJiQ2NoTmMvVG5kaERi?=
 =?utf-8?B?azdZR0R1MHUwaEdab01XbEJ3SGVuSzc0VkZsQWFMczNoY1V1L3E3THFGVzFq?=
 =?utf-8?B?b1cyMGE2MGxQSEQyRnhJWTB3UkxOeVU4Rm9QV2IzOHVRM2lhRnI0aXI1OEgv?=
 =?utf-8?B?OEN3alhRQmcveC90QjJXcUtidldjT0ZxY3oxcFBxWkczZCs4ZDhWemZhck9k?=
 =?utf-8?B?R1hQU0d1WU4veFovK2FHK2pNM0lURHlManZRWmtqNWV5SXd4dGZyVWR0OWVl?=
 =?utf-8?B?OWVYalBUb1dhMmJVRUloTTE1clZDeE5UNTl5VEQzbnVCQjFqRW5HSzdqSFBt?=
 =?utf-8?B?a0RjSHAzOUExT2ZiOGhINzM4TFNlMEE3U2pyWkQ0NXBTUE84UUtZdGZVcVlw?=
 =?utf-8?B?MnlHdlhvMWd1a05JRVl1MmVkcjZYbWRTTjRYeU9wS3UvR05odWJUaHE3Tmxn?=
 =?utf-8?B?RDNubFROVUFCQ21VYXY2ZENaUmdQUFhKajZVUVg0dUpJWGxHNE5mNVdlaUZP?=
 =?utf-8?B?bVJFUXJLTmV1RDBiT3BTMTM5b09JRytyT3RNZFhSWGJrbjBkbGRCQmxvTUJl?=
 =?utf-8?B?TlFETGIrdjdOaFhkSlNvem14dlFOUmtwSXhmckRXUHg3LzNLUDZNZWxqWXlX?=
 =?utf-8?B?T1lSTlhzNzEvWVZTSUc3Q2tOVC84cnBtVFdic3Z6azZmRkpkamVrUnlvdElV?=
 =?utf-8?B?Z2s3KytaOXRBZS85dFY2bk5OU21LdGhPZ1Y1TU1YYXlYTXVhNWJZcnhyRmpy?=
 =?utf-8?B?MnRwM3Y2REQrT0J1NzAzS2dLQnZrRnY5TWpob2hPQXI0Zmk0R1ZqZ0tzYzRu?=
 =?utf-8?B?SkM1eCtqUnlTeFVib0lIUjFTVWR2TzR0U0xNQjk3QjVxbC9QZjk1S1Zya2RZ?=
 =?utf-8?B?MFpLeVVLUFFERjBHZXV6VWVJUWMyRndQRkp1RGM4TlJDa1JENXUvcjk3eEJX?=
 =?utf-8?B?Q0k2TVVSRmF6ZThNeW1TSzdMKzNnWkVLUGNVVE1zR2tWVUp1S2xyUFpDVUxF?=
 =?utf-8?B?U2lqYTU0b05ySkxmMzMyZ1pjM0hOYVIvdnBuT0o3RTJVcDBNKzJOS2xOWEtV?=
 =?utf-8?B?c09MZ2pHcTRwY0ZETmN3c2hORDM0VVJvWnVTTjVSUUNwRHdqNEx1Z2t5MkI5?=
 =?utf-8?B?SWR1MzE5L1Jxb29oOUtMRGN6L2gzc2x5djZSZDhuSDZJR25ZYTh0b3RLcGly?=
 =?utf-8?B?UmpxeXgxMlFsWk5ESDYyOHM3V1ppelZoUks3YmVJbVVBeDlvNHJaV3Y0TFFY?=
 =?utf-8?B?QXluS2c3RnhTVUNCZjgvT3BWV2NYTGNlakE0cjRmNDE4ZjB3TUE1ZXZTZExw?=
 =?utf-8?B?Z3FwQTZZYlk3ZVlEdWNEZHRlMnNpQWt0NEhmTjFyeDByYVBUMzJUZS8vUWJZ?=
 =?utf-8?B?bnFTRng3QUpSWmd0VldDdHJiZ3BTL1VrQkZVQmtQOXV0UVdCa1kxU1lJNjZn?=
 =?utf-8?B?YW1iclZ1MVgwdVRCVTk5QTBveE1ESnE4TThYNUVraUdKM3l4VU9GQkJrQXJ0?=
 =?utf-8?B?Z3BkUjh5aEMwWHI4Mi9qMjlxQTEvZENNbmtpSkZzSy9lb0dPazllN2Vpakxl?=
 =?utf-8?B?ZENtRUU2MVJOWkYrWkFIYTVGNlY3T1hLTHh6L3VEdTdmVkhZOGpnRHIrVjlR?=
 =?utf-8?B?TnFRRUJLbUpLVGRWSXFZZ1FSUy9FVHkzYU9uM1dhZHZTRk1sZnVlUFVZZ1h2?=
 =?utf-8?B?SXpsMDVYM2ZCeG9WWHZJUlMxRm5vNzVLT3ZxaGR1cWhZRmJMQ0RqbXZ3RGZ1?=
 =?utf-8?Q?0M38zmRIRuJcW5JeKFjuL9JYW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5788f900-3f7e-4d3c-8bac-08dd5499cba7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:09:28.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96orvXV/4f0C2iEO7kqm/a5wztdjtxQWcF3ZNnzb2AHnMTbAIN4WwnVZvXZwgDVFJ9Ze9OcOM3BiZiXjf1fZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

On 2/20/2025 2:32 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If a CPU is missing a policy or one has been offlined then the unit test
> is skipped for the rest of the CPUs on the system.
> 
> Instead; iterate online CPUs and skip any missing policies to allow
> continuing to test the rest of them.
> 

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Only check online CPUs
>  * Update commit message
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 028527a0019ca..3a541780f374f 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -116,12 +116,12 @@ static int amd_pstate_ut_check_perf(u32 index)
>  	struct amd_cpudata *cpudata = NULL;
>  	union perf_cached cur_perf;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
> -			break;
> +			continue;
>  		cpudata = policy->driver_data;
>  
>  		if (get_shared_mem()) {
> @@ -188,12 +188,12 @@ static int amd_pstate_ut_check_freq(u32 index)
>  	int cpu = 0;
>  	struct amd_cpudata *cpudata = NULL;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
> -			break;
> +			continue;
>  		cpudata = policy->driver_data;
>  
>  		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&


