Return-Path: <linux-pm+bounces-26332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6705A9FBF6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 23:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6571896C8C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2BF204F81;
	Mon, 28 Apr 2025 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UQBvl3Kl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD6A94A;
	Mon, 28 Apr 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874507; cv=fail; b=SHmigN/20tsoqOlMi/BWfgX/ba2J5HGpP/UP7yEbK5my3EOOj/SZsD3l/A8RusD+wKLRX4URFv0yaOYTu2oe+vBWl6Ht4CQVedkcG9dVsRPK+SmuEKYZYejhzTpbG8qVr+SxH34172bP8RI14tfQNbA5muzqzLivAqSEy7aCYAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874507; c=relaxed/simple;
	bh=geDEtPrCrfRoOWgdxLitrB8SDFAkKnhze6i5gFsnYOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t+HpCFXe4fiux0Bphsrs3Ku8w8vh4BtBhAaqSL77s3aE+NMfeFQ4E2gcS5idp3v5Wx+YBHmGCAlP7Z3ah3wuBdzBenX55z5Th5DBLSUJxzUaw5OKgeHeI2TyJCi7gAv2Fae3avcoy78YiOlrIHzP6bG5a5DZW6jp6ruYEIJW988=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UQBvl3Kl; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wU7B76jr9hlpxT3BuqmrMs6vZoZQcVCH2iN+OYudzdrilwsSXhAVN6ioYeeB5+Wq30SANJVGTJJIGBxRvNlluxqvxHHqYLPulVzuxpdDguViljv9lxW9IvZsei9431nLaEwIh2oj2zRKp5DVrOKEGZVwrNysutsImvSbsq/DulNlhmnnqWBa+Xoa7Y9e5niH2ATuXny+AlkvzJwYipHQSTzNWBCkuHvvPcEP7GW/c5MF0Q/hgZeKITggi4dmASLn9oFjfHBZJm0v0adYXnBJ9TYLkwQuzhIGrIIUMgOkbtb7ECo1ZMxlhf00DQVSwoNYEDQQgEbEkwLUoDNAS0BEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlY45CNOxjGLN5/Jw2IaV6zeAO5PxTLEQMx6SBlr9dw=;
 b=azDskeUGajYgJIiNEy8rn90v3I/LZjauKUPjSAoMb73lhlaXm+JYYYXQJbrLpC3U51TGo+C5W/esU3pksGoUaEkUufiCdBZ1agck7Qek84tHqWXmcaQ3wuIiIqTMkjIJ5Ri2bnEocD6s0ntsbhaWE+bqXryJnFHn0EeOkcVjSMjI9XJ7Iv0Vf4yRZSmGEkkn+p4hENLwF2zUjvBreGRSiysGWSci7lNjaQLItMcSZCsJsJgNQvN2a9L4n0GQi4f5VRq22euJCrb8OaWDpb5HZX3z/2ebXZBe6jnE9fXuZeJZoY62ARLWiiMdsr5YN7z45DIpjukIgKt4h3FYoNYBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlY45CNOxjGLN5/Jw2IaV6zeAO5PxTLEQMx6SBlr9dw=;
 b=UQBvl3KluoCwDfV6gPLeReyzrJBm/s7rBDRLaEh9QuGNzvuy9RK9Q190auRULNgkxnxF6iMrAAa6/hUhXXJq2cXcDTvynkVUW0MHQTyOH+/VN2Vy/S6rVp/cOL2Uk78LU8vdIedFhtrrDWdIfSXtdq7r+RR1v2CCtij1SHCu7B0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Mon, 28 Apr
 2025 21:08:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 21:08:23 +0000
Message-ID: <255ede39-a35e-4f95-84a5-c13d79412ba3@amd.com>
Date: Mon, 28 Apr 2025 16:08:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq/amd-pstate: Add support for the "Requested
 CPU Min frequency" BIOS option
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250428062520.4997-1-dhananjay.ugwekar@amd.com>
 <20250428071623.4309-1-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250428071623.4309-1-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f88711-9b2d-42e0-da80-08dd8698cfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3UyWmoyYk0wOUw4c0o0SFFHRy9Sd3pqMjZtVHh3Y01PSmlIcS9RaUo2ejhX?=
 =?utf-8?B?ZU5VVWVUc3ZXOHhxRGE3RU5QVUExYnk5NVloczAyVm9lQ0hZNGw3c09wVjVK?=
 =?utf-8?B?UnFSTmk1L2kvWHFvRndwb285T0tFamVJSEFqaDlTUXh4K2wzRjdtbzd6YlBB?=
 =?utf-8?B?WGd5Qklyd3VVZDBNQmFibGlmaXpFejkzS0N3Sm1wRGtINXF0eE1STlBUdFZq?=
 =?utf-8?B?aTNhNTJVZ3Brcy9VZGpIUTdybGNocjk2d0tCY0xOajJPcjlMUVVlRmtWeWdN?=
 =?utf-8?B?dUVyS25SR3cwR3Z5OHBaRk1GT3lrNmI1UFVvSWExMGNRTFdEQ1IvQktabnJC?=
 =?utf-8?B?bUREazI2WU9ZbFJTMVJhcU9NSjdJN0puaDF5MnJwZFRPYVZHUVdBWEtNR3lK?=
 =?utf-8?B?eVFwa3pwOWhVVEdBQ2oveTg5cWg2dUJ2WmhPT2Y5ZU5MNG13OThOaFUwQlQx?=
 =?utf-8?B?dFFOeVBFNFNpNFZ2ZHhFUlF3TDFodlBVVUFjQVUxYmRTNVdnc0UrQ2FqQzE0?=
 =?utf-8?B?eFpFTkdqNGRtaGxPeU5IL0YrY2R3ZnR5Nk9lUE02a0xkazFPM0tyYzgvMDJo?=
 =?utf-8?B?T2tnN0ZpelNmSHhZOGVGYmc1NG9pMVcyM29VNlEwVVpJcFY0d3M2TjN4UzBl?=
 =?utf-8?B?Zjk0VHpzdVZhYzdobnpqMnE2MHdiaEFCUFpRVnJ4cmFIM2krWDRnYWpvUHQr?=
 =?utf-8?B?RVErek5ZNFhYczloRGxkVG00VytoVERDK1cwZVp0ZUkvSnhwQjBFa0xBOVV0?=
 =?utf-8?B?Q2d6d3ZYR1lzWlM1b3p1alVZWnE1N2dZclBTVXMxZWR6RWxMWEFMcnBtcEJo?=
 =?utf-8?B?Tkh3NmVXZldKbVN2SE9BQ0RYS3A3eEFzTENjVzFobmoxY3hpSFJYYVpKbmVT?=
 =?utf-8?B?eUFZN2FqSG01RENVbHBTa3J3ZWZkUXl6YzRKWjVZN1VGVytpMnhVby84WnBR?=
 =?utf-8?B?RE1XZ3NSZjdhVHArL2lIUVFlVWxEdTE5cFB1TEYzTVpnTHZJMWR3QkY2K1k3?=
 =?utf-8?B?R2NBTnVQVnRlMTBQcHVKcXB1VlBPNndiSGNDTFpBVlltcnRwRUoweHRqY1V5?=
 =?utf-8?B?VU1RdUQ1VVpqYVpGYkVtWnh2ekdmdGcxbEtwb0xKMmlnVE5kYVIvK0x4blZ5?=
 =?utf-8?B?SkdKTUlaMzlmSzhhbk9INllKZXFwbVpReEtNd0tzNkZ5dDdZb25VWXdxb2xH?=
 =?utf-8?B?RnoxRHBQYVJVbjZOYjVkaTZMd2dzbjF2UEswREZDbHJWRzRORDZCYmFaK2tC?=
 =?utf-8?B?dVBjRkhGd3NudGRCckJuWVJ2Ti8yZHMxbk5yTmF3MHE1STVCL1dHaW5vZi9L?=
 =?utf-8?B?NHFpNjc0RkdldUJzM3dSRzBiQjAreVpscFRMdkJkMVgzdk82bm04TGpWdGxw?=
 =?utf-8?B?dFRjTUFSYldGMlRhOTN1aHh4NWRNMGFhQXowdHlrOE52VGc5WTZoajl4aDh2?=
 =?utf-8?B?WGlsaFRLYXk4eG9rci9xZ2d4bFQ2K3hQMnlENnVaNWNvQmJDeTlEb2tTWlIw?=
 =?utf-8?B?azJBdFZQK3JJMDQ0eEUyV0lZdHpLS0plN09zUnBKa2p6V1VnZU1QZGFvR1Jj?=
 =?utf-8?B?QXd1cEp1STBjQkZtTDBzR3JmMmt1aVNXa1QzamlaVVBmS2xQVEdOR2hrMjc0?=
 =?utf-8?B?V1g1YXlOblNpNzR3cHErZ0Vvdm5nQmw1R0RuWWE1ckptWHZXNmZVQ3Ayc3R0?=
 =?utf-8?B?NU9TY0J4QVpKdFN5d1E2ZmUvMzVjRno2M3ZzVThFZHdvWFJ2bWlVWGhyQnJX?=
 =?utf-8?B?NC9jcG1zTzBSVE8wVitVTTA2US9VLzh3dWlXWjRRTlVIWEJDOVNiRmY1U3FL?=
 =?utf-8?B?ckVyMVE4UmJlZXEyVDlvMXVpNEJBcTVTZ3pManA2VkhjRDY5VmJkRjM4cW96?=
 =?utf-8?B?VDJTNUdDeEpITk9vWVllVDA0UFNIWHVtYzR0U01OS25TS25ZV3VFOHh1dlBu?=
 =?utf-8?Q?Ifdn5wLXdE0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkJObElGdktoeklldHJITFJiSXZrTEJxcFpndFNTWSt3VjdKd0pJZEVST3Er?=
 =?utf-8?B?eld4TG5xWkxLTWlNaDNBbDlMNVE4NXJnUC8vTzZISXc2TU1LYjRQN3ZpWitG?=
 =?utf-8?B?U05PQnVHWnpNbDJSV2ptQVFqdGdXSEx6K0NCNHRIcDlyMXNybWVlZWFkVkpG?=
 =?utf-8?B?blM1R25idzJQOUhlczJHUWMwdVRqWU9xeU9hRWF3akZYajFvSlc1Z3p6aDlm?=
 =?utf-8?B?cndVTVVRODZ1cm9Yb2QwZ0FmODd5dnhkT2NxNlU2MDZGZnJDb0RwOVZacnhr?=
 =?utf-8?B?RWE5ZzR3UjB4Ry9JN2JDSVZzWTlXT21jZFRJQnRKTWFiWjlISFZ6RnNMTk9N?=
 =?utf-8?B?eFNKV2lxSmZIWkFTR29JS0k3TGNqRFRLaFllNWp0Zk1NWThjR0MyRU1YWkxT?=
 =?utf-8?B?ajR4dkdoM2YvL25pYU9wK1NtQnpNQ1lSU1FUTXlwaDd2alA4c2szc21ncGdo?=
 =?utf-8?B?aldDclhXN29yY0ZBV0srRGxZR3N4emV3SnV5eEc4KzVBcjdoL0ZtRXdOdnlS?=
 =?utf-8?B?S0lNczhkQ2dPZXdoS3NmMjRyRDMvMC9wMml6SklLSnpUSTU5L1llT09iYzNs?=
 =?utf-8?B?a3gvcmVaZmhzQUNyWnlrQ1FOZmEzK3JkSGRyVWREVWJ5NllOT3FMeXN2TllF?=
 =?utf-8?B?SHZFYjBUWnVPbldzR0tNSDhpWElNZ2JZRUZzdWdmVURZNFRnSytFSjNMNklu?=
 =?utf-8?B?MHRqRFRGc3dLZmEwdUxCVHFqTUdWWFZxLzExWWE2KzhTVmFZSzJUWnpFTm02?=
 =?utf-8?B?RXVBRkJYVEFZOUUyWm1vWVBKck1BS1NORzZSbWpBZ3psVUNhTitOcm8zVzky?=
 =?utf-8?B?Y0N4QWFyS0NGblpiNnArQWZ5YUI3RUUvYkgzejI3UFlEaUhGWFNoZEZ0T3Vi?=
 =?utf-8?B?MEdBTG1jcVBkM25UWkNHT1J3L004bWpGeTBYMkZmQXptWnJpN2hSbTkxTm1H?=
 =?utf-8?B?Zk80N1E2QnpxNGdGNERvMmRvVjA0QTBJSy9JOUIwSE5mR3ZLNFJTeGZYQVVI?=
 =?utf-8?B?M0NyZjM3dENsZTJ4Mk1BeVVMZ2VvUkQrN055R2FtTUtpMTFYK1phbExlRVhy?=
 =?utf-8?B?Z3poTU53Z1ZmZXYvb1pZYXhhMW9pQXkyT1ZGM1ByOFZVUGw1WFEyK0V2eWtL?=
 =?utf-8?B?SEhyM05sMUJ6cDhKTjU3bVRqVkQ1RktQZ09qeldrNU1naVNnUUR6OTFrbWVO?=
 =?utf-8?B?d2h3bFhGQmI5S0F2cE12am8wRUxtd0N4MnlOMmVMVW1WbDBkQm9VYlNJTGhW?=
 =?utf-8?B?N1Jha1cwWXREVk5MS3ZBOGFaMmpKbXJjVXlOQTVLZUNUcG4zUWNlVEFlTnAx?=
 =?utf-8?B?Wm1rL2FhZWxMUFdhcm5zOFFVZDNIUEVDblpOZ2RiVU1Pb2FpQWl0T254MEE5?=
 =?utf-8?B?Q01oYzlJd2x3Zmo2c3cySzVjSFNTSXNSTXU2cldyVjVXK295eXhZaHFFczYv?=
 =?utf-8?B?eGpBRllQVUQraFJ3VFRZem9CYnpERnJlVmx1MEhTR0dWMi92QTMxKzU2bE40?=
 =?utf-8?B?NGQ1cWpLUEwxMU40WXdyU2RZRElweldOYW9nd2JaTk5LTHFWQ3FzaklqbkpI?=
 =?utf-8?B?UllRQXhaRC9pZ0d5enMyNGdtb0U3c3lUTEJEYjc5aHNiL0ovZFhseG11R3BO?=
 =?utf-8?B?Q1A2d25xbjlscGNmNnRzdHJJSGhWamJZb2ROayt3RTRGdmowemZKemxGSG10?=
 =?utf-8?B?ZXc1RnpFdDBLeDhNMXdCTGFDbjFja05qTGxZSmxPcXZZRGlnVUhNVnAvczZY?=
 =?utf-8?B?SVN1NEVaR3dXSkhJc0dJRzJNTHdsa1NKdFlWekJOdkh5aWJqQUNodUMyQmJF?=
 =?utf-8?B?aGVTRFhqaUZ1a0ljSUU3YTcxWDE2bjBqY0dtMmtaZHlGdGhpcVlQRjB3L2dN?=
 =?utf-8?B?TC9aeGdlUGV0dVBkMmN0WDR5TzlyVXJrdTVESW82UTUyclg5KzNGQnE1L1hV?=
 =?utf-8?B?SDhsVkVlNFoxWVhrT1lsWXozMDNmSzZLM0dHVWpyemRlcGhlb3ZISlZ1Yndk?=
 =?utf-8?B?ZzhRT0RnZFZjWmx4T2Q3bHpLajM5c1Z6YURkM3YrM2o4R25xbi9UVllNRG9y?=
 =?utf-8?B?M2VpeVdMU1BEV3drOUppcm9ya2dXWkdMdUh6NkxaL0FFWEo5ODJpQ3JIWDRj?=
 =?utf-8?Q?eMAZlEWXz+2syuzI4nKm6epIg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f88711-9b2d-42e0-da80-08dd8698cfa0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:08:23.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yln2RgIt6wSireS5lZMhWj47HaXZHYE2zvJIiXWyEvUNH+SMZneIsvf9gvURDgKcO7Ytrr3I6WlgFpNkFsP2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496

On 4/28/2025 2:16 AM, Dhananjay Ugwekar wrote:
> Initialize lower frequency limit to the "Requested CPU Min frequency"
> BIOS option (if it is set) value as part of the driver->init()
> callback. The BIOS specified value is passed by the PMFW as min_perf in
> CPPC_REQ MSR. To ensure that we don't mistake a stale min_perf value in
> CPPC_REQ value as the "Requested CPU Min frequency" during a kexec wakeup,
> reset the CPPC_REQ.min_perf value back to the BIOS specified one in the
> offline, exit and suspend callbacks.
> 
> amd_pstate_target() and amd_pstate_epp_update_limit() which are invoked
> as part of the resume() and online() callbacks will take care of restoring
> the CPPC_REQ back to the correct values.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks - this looks good now.  I'll add it to bleeding-edge for some 
testing.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> Changes since v2:
> * Add resume callback to reset the CPPC_REQ to last sane value for
>    amd-pstate driver
> * Check update_perf's return value in amd_pstate_suspend
> ---
>   drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++++------
>   drivers/cpufreq/amd-pstate.h |  2 +
>   2 files changed, 71 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 02de51001eba..4da03c7c7fe3 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -389,7 +389,8 @@ static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>   static int msr_init_perf(struct amd_cpudata *cpudata)
>   {
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
> -	u64 cap1, numerator;
> +	u64 cap1, numerator, cppc_req;
> +	u8 min_perf;
>   
>   	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>   				     &cap1);
> @@ -400,6 +401,22 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
> +	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
> +
> +	/*
> +	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
> +	 * indication that the min_perf value is the one specified through the BIOS option
> +	 */
> +	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
> +
> +	if (!cppc_req)
> +		perf.bios_min_perf = min_perf;
> +
>   	perf.highest_perf = numerator;
>   	perf.max_limit_perf = numerator;
>   	perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
> @@ -580,20 +597,26 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   {
>   	/*
>   	 * Initialize lower frequency limit (i.e.policy->min) with
> -	 * lowest_nonlinear_frequency which is the most energy efficient
> -	 * frequency. Override the initial value set by cpufreq core and
> -	 * amd-pstate qos_requests.
> +	 * lowest_nonlinear_frequency or the min frequency (if) specified in BIOS,
> +	 * Override the initial value set by cpufreq core and amd-pstate qos_requests.
>   	 */
>   	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>   		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>   					      cpufreq_cpu_get(policy_data->cpu);
>   		struct amd_cpudata *cpudata;
> +		union perf_cached perf;
>   
>   		if (!policy)
>   			return -EINVAL;
>   
>   		cpudata = policy->driver_data;
> -		policy_data->min = cpudata->lowest_nonlinear_freq;
> +		perf = READ_ONCE(cpudata->perf);
> +
> +		if (perf.bios_min_perf)
> +			policy_data->min = perf_to_freq(perf, cpudata->nominal_freq,
> +							perf.bios_min_perf);
> +		else
> +			policy_data->min = cpudata->lowest_nonlinear_freq;
>   	}
>   
>   	cpufreq_verify_within_cpu_limits(policy_data);
> @@ -1040,6 +1063,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +	/* Reset CPPC_REQ MSR to the BIOS value */
> +	amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>   
>   	freq_qos_remove_request(&cpudata->req[1]);
>   	freq_qos_remove_request(&cpudata->req[0]);
> @@ -1428,7 +1455,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata;
>   	union perf_cached perf;
>   	struct device *dev;
> -	u64 value;
>   	int ret;
>   
>   	/*
> @@ -1493,12 +1519,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>   	}
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> -		if (ret)
> -			return ret;
> -		WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	}
>   	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>   	if (ret)
>   		return ret;
> @@ -1518,6 +1538,11 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	if (cpudata) {
> +		union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +		/* Reset CPPC_REQ MSR to the BIOS value */
> +		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
> +
>   		kfree(cpudata);
>   		policy->driver_data = NULL;
>   	}
> @@ -1575,12 +1600,31 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>   
>   static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>   {
> -	return 0;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +	/*
> +	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
> +	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
> +	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
> +	 */
> +	return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>   }
>   
>   static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	int ret;
> +
> +	/*
> +	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
> +	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
> +	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
> +	 */
> +	ret = amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
> +	if (ret)
> +		return ret;
>   
>   	/* invalidate to ensure it's rewritten during resume */
>   	cpudata->cppc_req_cached = 0;
> @@ -1591,6 +1635,17 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   	return 0;
>   }
>   
> +static int amd_pstate_resume(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +	int cur_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->cur);
> +
> +	/* Set CPPC_REQ to last sane value until the governor updates it */
> +	return amd_pstate_update_perf(policy, perf.min_limit_perf, cur_perf, perf.max_limit_perf,
> +				      0U, false);
> +}
> +
>   static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> @@ -1619,6 +1674,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.online		= amd_pstate_cpu_online,
>   	.offline	= amd_pstate_cpu_offline,
>   	.suspend	= amd_pstate_suspend,
> +	.resume		= amd_pstate_resume,
>   	.set_boost	= amd_pstate_set_boost,
>   	.update_limits	= amd_pstate_update_limits,
>   	.name		= "amd-pstate",
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index fbe1c08d3f06..2f7ae364d331 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -30,6 +30,7 @@
>    * @lowest_perf: the absolute lowest performance level of the processor
>    * @min_limit_perf: Cached value of the performance corresponding to policy->min
>    * @max_limit_perf: Cached value of the performance corresponding to policy->max
> + * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
>    */
>   union perf_cached {
>   	struct {
> @@ -39,6 +40,7 @@ union perf_cached {
>   		u8	lowest_perf;
>   		u8	min_limit_perf;
>   		u8	max_limit_perf;
> +		u8	bios_min_perf;
>   	};
>   	u64	val;
>   };


