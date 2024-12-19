Return-Path: <linux-pm+bounces-19475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041DD9F73B2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 05:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D9616BF77
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 04:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F2D2080ED;
	Thu, 19 Dec 2024 04:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mFvhQMd7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DF207E01;
	Thu, 19 Dec 2024 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734582297; cv=fail; b=fqKAkJ81Gpddx+wRGNFLD6ujlDoUP02GnSwp2RqtCEOalfCCD7oniYdk1icb3+rftX1rG8ela/Os4RrPqDa8DUDMgy25XdQm8BIGoUKqwNjM3hUQ3VhtggT4u8z2Gab7LQtjI7XPRcbNjCTf+9YRcUgFt1GpzUWjZgWr9nSdvlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734582297; c=relaxed/simple;
	bh=A1cIjxpvy2EXfk4Ta4+dNCbXasVffOgGYoTMizqyEWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uwHvmI5dUESKrRIBVQfV70V6/1gspFsZqFjtAYZASKPBrATiGpHJY9Iplni6jNynaOkvA9JlNEW/TVNifQzMns0HkQ81HIbxC/R1Qdg3O1PUT2EFFx6pQ/MKbE+305LTLfZcegx+Yzr5M7v2t+IsL+RaQpCr8ydMER++rPRzWL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mFvhQMd7; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3J34QzFyg6n6sWHtT+EWRhewHGm3PgH4SvU+Hc7OQj2+zphhpMyuyzdLlVFsj5JWJ8JIxIzk76w7Phdl23YgWLahE410DajsiSuDPuRqhrlOccWPnpljCS6mSh5s6W8YWA16qLdndSTBtnIk9oEWGSGSgytLIHGdB0ykCSFPXUzUde6/zWSG3YwEBEO5Xtaex9ve2F1U+sNEbTV5gT86nouRBWX+jnuYyyeDypThTFrBt9obVY6hRirRMfshGPwss/67rz3uYKXKAnSjhIc+tuW2St+cXs40754FXkJQ4n5QQOKNbfqSog4TJon93vim7IfcoZ+l7Aw6/bJo6U3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vmcrcH6hudd+v/sqa9rmAgI7JjTyVH49LJuP9vSw3g=;
 b=wZRfgJwNXJej0XkFhFMXSzH8Nxx+fOsob00+uw+S5gDDjHxtqYi8QhLhqWvdEcy3m1S+SGOS662WZcEpgJ0rZnI4ijKEClZlqmpMGhiMRi4OSnDf1c+Ju/lXk/ea2CuGClb21XG4rCjU9J5RVKnOjwlaNHKcc7edwJb2yAMnqQRnVaQcR4YF6k8nVAYQjL7mbzGWxIVgJNDY4dEKm/K3f4ywLhGYr4DSyuAEsOKCXbPw0f3OlJ/sBoah8uwnhTcdW6BIc7vJlZLXNpKPjPtyt3JerpLrD8nCZpdKoIea4+FFjdONI6Xhw+ExaYcz4e0gsRGhuJREaj2FCeEAOPpCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vmcrcH6hudd+v/sqa9rmAgI7JjTyVH49LJuP9vSw3g=;
 b=mFvhQMd7Nw6oP/pVil0yyLIUvh8ge5sExB3AoAbJeOncVKRlBs3yOSBN1jq0OtF1b3qgM9NtktEQ/3SdT/xxGjIF38wNO0ha6+ceoXfxb+vPrE1YhrKIQ9D0eXocsa2zP6PZ9MOvJtKIjecUgKLqx/keeTEKD4CYNlkJVqtU3No=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 04:24:52 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 04:24:52 +0000
Message-ID: <ad915234-3498-4faa-a43e-22dc51fe5944@amd.com>
Date: Thu, 19 Dec 2024 09:54:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-11-mario.limonciello@amd.com>
 <d120814f-7393-4d10-a6de-ba09948f4243@amd.com>
 <6ea8c643-6977-4ce2-be1e-b0b0a73e8306@amd.com>
 <5330c947-7bfc-4932-800e-9067a9f78470@amd.com>
 <a8c6ff3f-2ad8-4926-9ac3-f0f39ceffa2c@amd.com>
 <cfcbf8a4-7254-438a-8b0c-29807e07ed90@amd.com>
 <a3ef3276-a7d9-41eb-8307-cb0e61eed0b0@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <a3ef3276-a7d9-41eb-8307-cb0e61eed0b0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::52) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ce3236-6dcf-4e1e-6bff-08dd1fe51532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXovblUvcVMycVgrb05OMGJZVlBFVFR4blJzUmovTTFBMk5sQnRKcG9JZmNM?=
 =?utf-8?B?eTU4blp6dzc4a0J5NmNkQ3QvY1BYRE9FSlI2WlJIMHF4ZXdEZ0FQMkthNVBv?=
 =?utf-8?B?aEIrQUVrOE1rd3BYMDIrd1hib3V4a2RJVk9uNVhySTBQWElWQk5NaVh2NmZC?=
 =?utf-8?B?Z0p2Y1dIWFVobFQ1TUR6cFVkOVB2M1Rwa242Y2ZML0JsTER1enFvZFg0eXJn?=
 =?utf-8?B?Z1NzU2FqeFJ6UG1OakdobllTZncrN0RSUGtFYjdoWExqaU14dDZsN1FtemZM?=
 =?utf-8?B?cXF3Z0RJWTNsVUVLM3lTc0pxNjNOVjN3Ulo1Sk9zL29BaysySHI3RUFya2pO?=
 =?utf-8?B?L0pBejlJdzgrRDV5WEx2WjJWN3kvRllaWXYybVN3VzVIRmY2UzVKcVY1Rytw?=
 =?utf-8?B?MWxoT2N6RW1ESlNVampOVDFWaXRmRUxXdC9McEZpaWxQaHZ1aHc1Q0VxeWtV?=
 =?utf-8?B?aEwvSVozN1VzRjczMWwzczVLaE13SjFsVEgyb1NLWWZ4QUVud3BOMUs0bExO?=
 =?utf-8?B?R1N3YVZTYWVTYTJZdnJDc215TkJiMFg0eTVtSU9sejIxc3FHNmwwSjREZFI1?=
 =?utf-8?B?U2FTUURvOHgvczFCKytyY2hDZVlsR1pkM0Uvb0Q3YmQwZTU0VTdkMmdHSk8v?=
 =?utf-8?B?azlmZUZRenJXdGJRZ2JyYTNkWFkrZUJRbWswdHIveEx2TVJiVlRBNU8xSm03?=
 =?utf-8?B?R3JlNFJjY01LMjB2eXoweFF0SklNTWlrWmZWMWN4eTlaemh6UnlQSStBRGVs?=
 =?utf-8?B?VDJGZzhUUk1zQVdvU1EzVnVJdWlHSTZkaTVpdU95WjNWY0lmeE5vUmtlaFJa?=
 =?utf-8?B?aFpJU1poTTJsTllXSm1SN0IrUG1Uek1vSTVPLzVFY1NmcFRuL1ovSk9Fai92?=
 =?utf-8?B?WXV2SzQxRmlpMFRwaFJXVkZ1RC9IN0FzeWU2Z3Mxb2RXVElxdnJLMEtSTmE5?=
 =?utf-8?B?dXZGQ1h0UVpUdkM5YU56WUhRei8zeVBvbHVUQzJCRHd0SlhtMU1oVGJxa2JP?=
 =?utf-8?B?cm5JZGp0NUl4cUM3V2FkaWlaNUkreEdtb3RDV3ZHY0FGclVjTi96MVNCZEhW?=
 =?utf-8?B?ckFGL2kzYk1SSTB3Y3dkbFRjOFovbWNNd01CZlF4Y2w4ZlN0T2pCQVp5Q2cr?=
 =?utf-8?B?RG1BZ1ZKOVVsMEhpSHoxa3kxa1pFUTc3VmVoZWNZN2ZkT0t4TmdNMmxCaDFU?=
 =?utf-8?B?dnNIcmxta1BRMmxBNk9Tbmw4eWpCWUxLaUt2VVUzeG00dG5IeDBMMkRYdDF5?=
 =?utf-8?B?MEs3d0RuYTFGWnJiUEk0QitLOG9YNlhqb1R5Nko3VU14eGF3OVZUVUpocURV?=
 =?utf-8?B?WlczeGtuTzNRSGx5aE55Y2xOTWdiTnNRR1gxNXdCN0hFYjF1SC9HZzRSaHJo?=
 =?utf-8?B?dGk5UThGektNTEZlaWdmUXlKUVVueUh5a3kwbUdyTjRLanExOGRaVFU0c09m?=
 =?utf-8?B?UG1sS0lVVlpWSEV2aEQyODFrVk9NSW93a1p3QzJVRS8vVXUvZUNOOUR3UUti?=
 =?utf-8?B?QWwxcVMvckhJcFBFWjRNVUFEb1RPbXBzRUZFTXNJL0d0amUyUit4Tzk3Q0ZZ?=
 =?utf-8?B?dHNidmF6T1lMbWFEN2FkdmNtekZsQkNIbUtYSXVibGlGOFZNalQ2VEFheW5W?=
 =?utf-8?B?b2xBR1AyVjZIMUllTldObDVHWHB0eVFIUmF5eUVQN0RROHBKMXRaM2doZnFN?=
 =?utf-8?B?d25KME1QRHE1RFBzd3JWS05FZzFGQndGZmYrVGFhTThId21vcjFnOVZPNndh?=
 =?utf-8?B?cnYvT0gzYkxVL3NTdUZJY2o4aXlMeFdOcUlGNVMvUVZPNTVJd0VJUmdsYVFF?=
 =?utf-8?B?ay9rYTZrT3BOSmFQT2hMQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmJlVHBNT2lpQUI2TVd2cXJNQmx2djd3UVVnS3RtRE44cWFuTDZON0NMNDBa?=
 =?utf-8?B?QmxJalpGOUtNTW1leGJjbWhhSUN2QmNyL3FBc1dUK0p0NVZyNC9JRWJFKzFQ?=
 =?utf-8?B?MHUvQ0dTeFRkQTE3ckFSUnI3RlFpUWtzVmZ0ZXN1NEdqVHpXV0RGV0hZT0Qx?=
 =?utf-8?B?cmRITDFaSE9uK3ZGZFBKS3hpQ29IRktQeWlNY0JBa0tPQU5Ibm1nMkd0d0hM?=
 =?utf-8?B?ZjY3QXh3cGVma0NTWnJYVEQ0cDdpMm9RZUs1dEVnb3lQWEJKN0loNUQvQmRX?=
 =?utf-8?B?YjNZVlJab2JYdUxNQkJjY1NSRXUrR0tUNXd5TlZzZ3FPbkJvRnM3UDVIVi8v?=
 =?utf-8?B?ajZvMU8rQ3VRN1hzU0EvSzJ2QlAyWDFKM1pGaGxBbGFLUFFyN2RaUmFJRFZH?=
 =?utf-8?B?ZUZpSnp4Q1R1UURWZkhJNXZ1WUNQVk83SzBQSUlhSXZGYUtKdjNkUXEwWDVB?=
 =?utf-8?B?SmJ3Q0pTYzlyWFRQR3dkeE5ic0JqQWJTdzNQbTZUbVR2bDF1bDdOcDl6T2py?=
 =?utf-8?B?NDR2YnBDWFRDSVE5eU8yMytYbnpQaG5VMkM0SE9ESjVoS0V5Q0ZtWUhtOVRw?=
 =?utf-8?B?OThZSXFMc0NWcGpsdERZamVNQzNLUmlRK1pVdGdjSHJPRW9SRFBORTJDSm52?=
 =?utf-8?B?K2hHeEFnTmhsZDJJVStPa3EwQjFLR1BPSmV6OFgrOVpsU2ZwSG1xbXJUV3N2?=
 =?utf-8?B?ZVJ4L1ErMWE3T3NYK1BsU3NYT0UzUksrMC9OYkp6U1JHRXpvYk1MQlgwMUtR?=
 =?utf-8?B?YTY1YlAyQWVMK0lmWTMzR1MwZHVrVGlFNFZLZWZyemlUemh4d2dTRkFOSzFt?=
 =?utf-8?B?T0MvMmc1NzdORDUrZW1ONXZPcFpNZSt1aG5Ubk5wckV0Z3hqMHU2UEZNTEdt?=
 =?utf-8?B?UkRYYlhGUnhLUjZGcU5rNE1YeXNmaDlEMkh3cE4rRUNaOWFoMlVpZ3VCS3M4?=
 =?utf-8?B?Y3NmL1VlVVFieVdrSkhTeEJXV1F5WHNZcUY3OEpvNG11bjRmbk1BK3UreWMz?=
 =?utf-8?B?M010SHA1amtGclF0Y09xb2JnZmpiejFKZ3UyZXNoYXEybDFJaHFEV2E2MEt1?=
 =?utf-8?B?Vllxc1UrYnVpTGQvdnVQbENhbXAvbm1KaytqWlZlWUVuVnNQTmxsL2xROENR?=
 =?utf-8?B?TytDcVdmTFFYK1NCT0toMG9tUWpoS3dqclJCVjBnNFB3V285ckhPRHRZQzk5?=
 =?utf-8?B?NUdlT0ZjMWZQc1VXR1ZLamFZTGFjK0YxNGpIRjMydi9IcmgrRTY4OEtUZlhy?=
 =?utf-8?B?VDl1OFpaNThqeUUxYjdFdkRTcXd5Y2RpZEladWhiY2xBM0MxVnFDbndaMW1T?=
 =?utf-8?B?OTJXY1ZWd0laNEVrOU9YVVdoYXpTZmFEUHFJamMwVmZnNUdPQ0FuWFJLSHA1?=
 =?utf-8?B?ekUxdi8zNEhwTE8wN0dMdlNSaHVucm5leGdpSGdReTBIdk9CakltWW5kY3M3?=
 =?utf-8?B?OGRxcGIvaTB3M3ZBRWwxQXEwcWNsSmx4NzBvSWtwcnpvZ1F0R1UydUNsL2Rn?=
 =?utf-8?B?anpPMlJ1MzFpbS9VNlluQkNSRkVDZnJKbDRPTzZFSDlaenBEampaZTVtOEVF?=
 =?utf-8?B?RUYxWmZSYTdnYm5memJkVEx0ZzFscjdGUGM2Y2liN1prNklmQklISzVRNko2?=
 =?utf-8?B?TlRLVUZsYnlDZThDV1h4NFNWKzAwUzBaL05ZdWFQVHQyY253V0JBRTVDbjZQ?=
 =?utf-8?B?UzRPV2JHOEx3MGFkRmxWNlA0UE9IcTBtVG9DdmVtb21qdEp4NWNZQ0lNcEtl?=
 =?utf-8?B?SjFYblRNbnU5VzM3QjB5dXJZeHBMZVl2OTA3blcxZkxjVXdQdktEMkJNek5i?=
 =?utf-8?B?d2FsVG5tR0V6c1F2UFdyTjA2UHNId2RUVnl5TGVBcUFMcVVOWHNRVGRLWGV3?=
 =?utf-8?B?SC9SOWhxU1ZYZVBmMDV0RDN1a2tRQnJWMDY2ZUJ4VEZ3SVRQeUp4N01uam9s?=
 =?utf-8?B?UVFhR2o4SWRqdStBMEhJcXBwWUo1ZW51U2d3N0NTR0Noell6R3d2NWwrZWxR?=
 =?utf-8?B?Q0t0cVE5UzlqV0FBeVR1RUdFMCt3d3N6ZlJSMmdodlJQc3Axbng0RTYyWkNn?=
 =?utf-8?B?R1FHKzJCUkl3YjBVS0JrTzVPWDRFNkJPcWdjUmQ4MitnYjBIUGJQVmhvZFZM?=
 =?utf-8?Q?QMFhbwR7bUcsWVHNkfM2/emMP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ce3236-6dcf-4e1e-6bff-08dd1fe51532
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 04:24:52.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZsjcByIYaEaHOG4cYXaKsU/7oppm7bBHLUc19sAEWKTpkM9dJm+m37EF9wCwg7L12TBGTDykSwdTDMABJX9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415

On 12/18/2024 1:14 AM, Mario Limonciello wrote:
> On 12/17/2024 00:50, Dhananjay Ugwekar wrote:
>> On 12/16/2024 9:09 PM, Mario Limonciello wrote:
>>> On 12/16/2024 08:45, Dhananjay Ugwekar wrote:
>>>> On 12/16/2024 7:51 PM, Mario Limonciello wrote:
>>>>> On 12/16/2024 08:16, Dhananjay Ugwekar wrote:
>>>>>> Hello Mario,
>>>>>>
>>>>>> On 12/10/2024 12:22 AM, Mario Limonciello wrote:
>>>>>>> The limit updating code in amd_pstate_epp_update_limit() should not
>>>>>>> only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
>>>>>>> so other callers can benefit as well.
>>>>>>>
>>>>>>> With this move it's not necessary to have clamp_t calls anymore because
>>>>>>> the verify callback is called when setting limits.
>>>>>>
>>>>>> While testing this series, I observed that with amd_pstate=passive + schedutil governor,
>>>>>> the scaling_max_freq limits were not being honored and I bisected the issue down to this
>>>>>> patch.
>>>>>>
>>>>>> I went through the code and noticed that in amd_pstate_adjust_perf(), we set the min_perf
>>>>>> field in MSR_AMD_CPPC_REQ to "cap_perf" which is equal to cpudata->highest_perf (which is
>>>>>> equal to 255 for non-preferred cores systems). This didnt seem logical to me and I changed
>>>>>> cap_perf to cpudata->max_limit_perf which gives us the value updated in scaling_max_freq.
>>>>>>
>>>>>> I think as we removed the redundant clamping code, this pre-existing issue got exposed.
>>>>>> The below diff fixes the issue for me.
>>>>>>
>>>>>> Please let me know your thoughts on this.
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>>>> index d7b1de97727a..1ac34e3f1fc5 100644
>>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>>> @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>>>>>            if (min_perf < lowest_nonlinear_perf)
>>>>>>                    min_perf = lowest_nonlinear_perf;
>>>> here^^^
>>>>>>
>>>>>> -       max_perf = cap_perf;
>>>>>> +       max_perf = cpudata->max_limit_perf;
>>>>>>            if (max_perf < min_perf)
>>>>>>                    max_perf = min_perf;
>>>>>
>>>>> With this change I think you can also drop the comparison afterwards, as an optimization right?
>>>>
>>>> Umm I think it is possible that scaling_max_freq is set to a value lower than
>>>> lowest_nonlinear_freq in that case this if condition would be needed (as min_perf
>>>> is being lower bounded at lowest_nonlinear_freq at the location highlighted above).
>>>> I would be okay with keeping this check in.
>>>
>>> Well this feels like a bigger problem actually - why is it forcefully bounded at lowest nonlinear freq?  Performance is going to be awful at that level
>>
>> Actually this wont necessarily deteriorate the performance, as we are just restricting
>> the min_perf to not go below lowest_nonlinear level. So we are actually ensuring that
>> the schedutil doesnt select a des_perf below lowest_nonlinear_perf.
>>
>> (hence why commit 5d9a354cf839a ("cpufreq/amd-pstate: Set the initial min_freq to lowest_nonlinear_freq") was done),
> 
> Sorry re-reading I didn't get my thought out properly, I meant to say performance is going to be bad BELOW that level.  We're in total agreement here.
> 
>>>
>>> but shouldn't we "let" people go below that in passive and guided?  We do for active.
>>
>> Yes I agree, we should allow the user to set min limit in the entire frequency range,
>> I thought there would've been some reason for restricting this. But I dont see any
>> reasoning for this in the blamed commit log as well. I think one reason would be that
>> below lowest_nonlinear_freq we dont get real power savings. And schedutil might dip
>> into this lower inefficient range if we dont force bound it.
> 
> OK I guess to avoid regressions let's leave it as is and do a minimal change and we can revisit lifting this restriction later after you get testing done with it to see what actually happens.

Agreed, I think as we initialize min_perf with lowest_nonlinear_perf at boot time, 
out-of-box there wont be any performance regressions. It is only if the user shoots himself 
in the foot by lowering the min_perf further, they'll get bad performance and bad power savings.

We can do some performance testing, and then remove this if condition later on as you suggested.

> 
>>
>> Thanks,
>> Dhananjay
>>
>>>
>>>>
>>>> Also, what is the behavior if max_perf is set to a value lower than min_perf in
>>>> the CPPC_REQ MSR? I guess platform FW would also be smart enough to handle this
>>>> implicitly, but cant say for sure.
>>>>
>>>
>>> I would hope so too; but yeah you're right we don't know for sure.
>>>
>>>>>
>>>>> As this is already in superm1.git/linux-next after testing can you please send a patch relative to superm1.git/linux-next branch?
>>>>
>>>> Sure, I'll send out the patch once we finalize on the above if condition.
>>>>
>>>> Regards,
>>>> Dhananjay
>>>>
>>>>>
>>>>> Thanks!
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Dhananjay

