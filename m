Return-Path: <linux-pm+bounces-10137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED291AF7D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232071F21A4F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AF19ADBC;
	Thu, 27 Jun 2024 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RQY1iuqU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6E1E4A4;
	Thu, 27 Jun 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515523; cv=fail; b=qL2yk60RNGNBoUaNbQ0fwKRvohEQISalsPzqoCS2/J64SQNf+ZQJARa99W/lrzG7LAtIeM1ESlpqaI1jTjSTEZnAZI7/ymz/33CvVYJmzK0/nyfLdIuSPQjzZ8Q6oLr/En6XR5ztcjzl3Bkb6IuD38L0sRjQ2WcOBXAGSRn8tPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515523; c=relaxed/simple;
	bh=V3dYC0oj6Ea72O2zK7zBIJ5LnffweH8VWQcBx/WIe+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gn8gk2JHF/Cp59//e9iXTyppSgRxnWUrE6AppNS73aJa4H2IXuLF12mRNuh2Rm8uS2lwgNvkV1KDDvIiRVDKqeuSXPFcpnxcFoQDTFR/Z9TfJnCJrmYcE8UQtaDxe4NNcUUbVBSPO2jfhv/B+AJmEhszL3eL4FgburhMtTMiNF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RQY1iuqU; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0WgPYGGkfBSOkS3Mr3fOzVTC+1NobsfSXMbUm4OG9wRMLt2DYXD7NlmTnekGYXwoEGTzdLksdJCFu0xeCyMLTu1c938ezzDaYeM8QRTjZC36TFdxhP5bb3/MILfm0Quii9iflF+0ozM8CtuB8p7R5naWTVOIVsPZ+CHnzIFaP7mSSCvY5Ago5Udi/2aNzAMW+KsqHEbT+Qq8wke352XHyDH8B+eEPiPulbomyelpEIg+A5M+b4o70HC4EoBqH27/H0q8qMqnqAhZXJrswEyQJxBL2tw/xPd3qZfu/Rptp8X0LhabMFM/bRuKSBgFQpTO56sxonCVy6WBfTK6OX/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psGoufBL024fQi9VKYpewq1rvs7gifAwQQCsq6sgyic=;
 b=G5K0eWzfuziTwmjK9rFaNEYXp7NJfGvnoWbps1/lRS+EN3aqK4Koc2f+mpQj6qOxoZALKi2DRf3JNBEVnyCmsF/DINu66oFv6TPVpqLT02uFRQGlg5AUogqJJ+U7WcwaN7x7/WatADbZtLuY0iPXmC2tmaBbTT1uoLOZ9XBfe7jB60C0zznDpKdnng7wnaXZnyU4zmUthxVviEOzQcB8PBG9fcajW47a3f+Hiegs2TcGG3xmmZv7Sn0+Qt4hrWrC30Lv/ZzBWSavqAP3BKIOfCAOShWsYlhfHb5+fP8k7IOol+MCbHpF20s1r3JY2EJNCuGSa+xYwdfjY8cdBpZo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psGoufBL024fQi9VKYpewq1rvs7gifAwQQCsq6sgyic=;
 b=RQY1iuqUrX4Fk7D4CS8GhkIRfp908leLPVObF1aJ61SR5GkuiXUufnaID88WAtwLUtJzkAnBrgm2q1Zq2BuplWgk0hNd/C83SFPZRfC01aJbJb9h9Zg6xoxAWm2WyKN0KjciJP0BRu9dZsVFjDxxu2H0fLgNO+cgPRlX4MOT0Kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 19:11:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 19:11:55 +0000
Message-ID: <5ed06d29-a8b6-48f6-b341-3cd32c19c8d7@amd.com>
Date: Thu, 27 Jun 2024 14:11:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq: Allow drivers to advertise boost enabled
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sibi Sankar <quic_sibis@quicinc.com>, Dhruva Gole <d-gole@ti.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Yipeng Zou <zouyipeng@huawei.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240626204723.6237-1-mario.limonciello@amd.com>
 <CAJZ5v0hu1rVOLycx5K4YWOGhtC8YfSYupc8D6qygtXVGtvxJrQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hu1rVOLycx5K4YWOGhtC8YfSYupc8D6qygtXVGtvxJrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0162.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 46161047-7700-419f-fda6-08dc96dd02a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3VaKzNzcjFKMGdFSGZ3cG9DV2pkV0NJd29HWlNpZkxXL2RDYzRYUDd3QVpr?=
 =?utf-8?B?L09XREVUVUxNODdPS3BMYUJHYVRkSHVWUFBZaDNNVlgyM1Z0QWlzeWF0dWhj?=
 =?utf-8?B?dnBBT2UrUWlyVXpzZ0tvL1Vub2V3RVptNzRSUU51dUVhZ2srK05LVDJDZlVC?=
 =?utf-8?B?enVLRUh1YXNpNHVjcGYySVpObWRjVEFDRXBSd3dYakVCdU5yb1V6amVZTnh4?=
 =?utf-8?B?eXNMS3k5eTk2YzRLWG1wUWluMWRZVHZrUWpZelgyTU1BbGZ3YmlFSExtTGw2?=
 =?utf-8?B?MzNMYW5TcTFGSnlaWWJpWGdhbGFTMVlHNVh3cmVYZStWd05FUmN0RlNPMU5L?=
 =?utf-8?B?MVpVWnNyMEhkOHFTWVNPQ0oxNzdrWG9rbllEaitxR2xvVjlMOUVyTlRVdEd2?=
 =?utf-8?B?akZmSUw3RW53R2o5MDBEeWliZGlnd21PMjVtLzFTdEN0RzNFaHRYOEs0REY4?=
 =?utf-8?B?L2FpWU1kSHZ0M1lYWS96K3F2MFFPTnhZMlJLVUQ5a2liNDgzSlV4aWhUTk5X?=
 =?utf-8?B?RkVBQnUvQ0V4UmNrREhDSC8xTmpVR1B6cFNTYlQvQ0NKVFpKdXdiaVIwZWtY?=
 =?utf-8?B?dFpHY093eXlINjZobWxSKzVhdzFHVTEyWE5HczlJRUcxeVphRjlBZ3JvKzRh?=
 =?utf-8?B?cC81bDhuWm1CUG1mYXYwQUd4MmM5WUhIYVQ2R2lGMk9uLzEvWVdRSk5ucHB3?=
 =?utf-8?B?RlQwZ0dNTlEzMWpqVzVDMmYzY1QxaUVlOG9hdFppc1ZGV3pESjFKTml6Q1Rz?=
 =?utf-8?B?ZGZ5bjA0TWV0NHlwV0JMYzBqRmdUVkZNWjNiZ05tUmdYU1lXcEJXYW5JemVZ?=
 =?utf-8?B?VnJBTmw0U0M0Vkp2T3lobnFSVFVPVHFVeSs3ZWhjMUxvRSs1Rm4yc05jMnZT?=
 =?utf-8?B?bm9laHlHWWFjN1p0ckt0cldjWkloNDRXOHBhZkJrNHNHNXhSRjVzMDcwd25k?=
 =?utf-8?B?bXlITDFLUWdoNk1HRk5OZUVnSTF0OGg0SFJXSkROS0xlSEFyWjZXMHcwanIx?=
 =?utf-8?B?bitlQ0ZZeW1jTDFFclNhYUxwc1RPMk0xNWFaTmJpRHptenlmVGYvV29VdXlx?=
 =?utf-8?B?NHZONHA5ajk5MHFMYzJGQkcwOUZvMUlCSElyZkFQTjJIMG1iRUVKUGRlb2Rt?=
 =?utf-8?B?NDI0UHBJY3FDQlpMdkQyR3VzNndrWVlhTk9tVnIvcTJTSGZtRFNMSERRSVJi?=
 =?utf-8?B?Z09TQ0RTVDZaeEhFZHFRWE5oandmSHRXNUVNK0FkRWhoWm5OeXBFUW8yYWIw?=
 =?utf-8?B?dHk0UjMrQUtsbjZhZG5hLzdOMndlMWkyWW9sL1NjWERxNGVvMEVTczFNbjJX?=
 =?utf-8?B?RHV3aGVTaElOb2ZWdFF4VGJMUmM1VW9iekhNOWYxUmpmNGNNVVp4Umc1SHVw?=
 =?utf-8?B?U1NYaEFHTEdpM0VtUGZOTndpN2Iwa1NyUnkrTDRSdU5rTGt5SEJ6SmFhdVVJ?=
 =?utf-8?B?SERGTUMrRVREakNtc0ZISmd1NVIrQzJoVUdpd0JZdkE2YTgvZnh5Z1M4akFP?=
 =?utf-8?B?U2VPVHhCUW1uUitTcnRHWVJxUDdJU2Y2SWNUL1NueUJFV3laZWRXNmlYQWZO?=
 =?utf-8?B?cUZ0NzRCWHZnUVRFTXhwQjZ3Skd1MC92UFVtZFFvWXkraFlYQjVVZzlXSHUy?=
 =?utf-8?B?bmxLSzFBclN0S0tnM2kyWWNJeXNDSVV2Zjg2bkJuNThtQXpoOWM2QTRwMm1B?=
 =?utf-8?B?KzhQV0F5YXNpUjMxV0xhd210eHF3UGtjU0o1WGtET1FnbGxtdnM5Sm04Z0d3?=
 =?utf-8?B?UnNaYTNGN0tOMlNiUEE5WmlBdVJxeEhmWTBMOWpkaHRrVi8rQTJRcTI0cFlR?=
 =?utf-8?B?Sy9mN29vTzRjT3R0d2ZhUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWF1NExQcCtVRG1rUFA1TzVVcUpvT3d2Y280VEpucUpGSVNJQXF5UExOZy9J?=
 =?utf-8?B?b1piSXBybW85Z0IyU0tvUklGK1NSZEhsMUwzMjJDbzFYUHdGNU5rZkNXSUxz?=
 =?utf-8?B?cGs1dEMzTHF6Wk1QMEk2UmRTWlBCb1VoazdGN1NYWUFhZWR0Z0xlWVdSdDZw?=
 =?utf-8?B?RlFxbHVDZDdOelVMdGRmS2JtbEMvZnNYdWp6M0tvVHEwM3M4SkQ0Tis5Zlp5?=
 =?utf-8?B?VVRlYlV1V0syTCtDcXpYeWdZOGN6WUM4ckZ4Q2RJd2NjL3Bucy9qSU85ZGxq?=
 =?utf-8?B?aFZTRnBUd3pnTC93UGlBeW1RNVBSZCtGdnRCUWc4dUx2NE5tMzFyN3RwUVo3?=
 =?utf-8?B?N0MydHJnRnU3Q0oxK0FIU2FCMGpVY2o0ZGVzeXlTYVZIcTVINnh5Wkx2VmFu?=
 =?utf-8?B?Nk84cUdaRnAwam5DeUVBQTg5WUJPdXlhcXRnMGlCKy9Cc3VPdVdFN0NUWUZM?=
 =?utf-8?B?MmRtblB5ZWlFVU1OUHZNR1hqbEgrdlZtbXhOZGxLelVRQStmK25taVpRRm9j?=
 =?utf-8?B?ak41MXU2MGdsWjZpRTRGOFBWUzZHU2wzT2tCWUJ1dW1IYnV4WWpZeXd0NU83?=
 =?utf-8?B?Z3l3YkxmUEVMQlVJUVlBOFVmaDNYM1BiSzJOOWpyVkZPbEtuQ3dzSE5uZTN1?=
 =?utf-8?B?MkI0ZHpZNjhFcjcxZUpGbE42RzBCc1JTbHlVRmdrKzdySmV2eERnVHBmZlpl?=
 =?utf-8?B?aDFLd3hZbmttWVBNUnI5OWlKaUVQY3ZKNjlOTVVIYWYrTW8xUjBTck9aZVZN?=
 =?utf-8?B?Uk14b0ZmQlJCZktVL0ovOU5PSVdTWldYbVlQRGdvUlJVWmdHNzludGlmRE5x?=
 =?utf-8?B?cXpXc0tEcStJUk5ZZ2NQZnMvdEZBamQ5dXhoZEZ1VnplTFB0ZU9WQ2R3LzhR?=
 =?utf-8?B?ZjBneUpNMXJMcEp2TjR5a1hQYlFUOS93OWZNSjNhalRMYUw4eDBuTEhOYm51?=
 =?utf-8?B?NnhHbzdaZkVCRUZuditwQ0UzemhQMVU5d1kxZG5wWUlRbnlDVTFhQjV6S2xI?=
 =?utf-8?B?NUYwMkRQZjZhVnpQY2ZpRWZmNm9kamhnWWs2R3c0cEFVMW1xZ3U3SzZSOFBX?=
 =?utf-8?B?bktrWlZTc1pTRHFDZ1Z3dUo2S2t5U2ZqMEdaa29KSkNLamtsdDhMY1Zka1dj?=
 =?utf-8?B?Y1RBQVJLU2J0Z3JSZFVvalVZWldBcjR3bzVOcEVJUHZkK0FrOS9MSVQ3dnRm?=
 =?utf-8?B?OWpMRHBWc0Rtc3EwelBwYUJReE9UVGEyRmlFTVZIVHdnTS8yQVR4N3Vqb21M?=
 =?utf-8?B?RXh1Z1MxSk1wYlF0Y2pNbzVCNFk3djh0YVhtZzdPbTJJWCs4YWY3R3BRY3A0?=
 =?utf-8?B?M3I2UzVjQnFic2dHaUVxcVBzTmJRMndrU0pWK29Hby82dDhTbnVGbVBNbHVT?=
 =?utf-8?B?cWR2MEozVklwSExIYXIrVGxnUCtKZzkzWW13WDF5NDZvaEQ1cUxkVXgrTDZ5?=
 =?utf-8?B?QWpZM083ak9VMExzSzVTdDUrdHhVa29McGdhUmloV2RRcVloYkdPdWxYaUln?=
 =?utf-8?B?Y1ZkUHNJbXBSdiswYUJkNVVNY0VyeXpienIxaHY2Z2lDYy90SngrS0dHbEVH?=
 =?utf-8?B?dWtmK0o0MnF3TXE1UlRNWElpWnEyNG9pNmY2S3owZi9QM24wclRveTNwNU5V?=
 =?utf-8?B?SXRVZCt1NEkvRjAzSml1Tnk1Y1VxQTZsQzNHOFdKbmZzWnNVZkg4bkxJY21m?=
 =?utf-8?B?cHpuTnZwRVFaV1FqaTJqa0loZ1pXa2ZSa0dEYVhoS216OW5IYnR1cnZ6RmNp?=
 =?utf-8?B?YTgycVpwTnZzMTdMN0dGMGhYam9jd0d1a2RLTm5VNjFveEVndzhaeVh2Y1M3?=
 =?utf-8?B?STBkQUE1cUlibmJkcW1sTnc4VlhtK3VzZFhYVE4xemZwUjc0dUM2dXk3c2Ux?=
 =?utf-8?B?WFRhdnJZYVYzbUFvOXlxZXpOYURVdTZWaWxpNk1lZnBCakdURVYxZjlLVFcr?=
 =?utf-8?B?eFhvVlVvQ01JVmlaRGdrN0xQcXh4RHlKemFFWFdHMVh5WTdoUkh3T0xLOG1t?=
 =?utf-8?B?alVTdXNnWW9DTlJGM0lQZjFoM0Z4dS9zOTAxUnZCYlJjTUpCOHpNWXF5cFI4?=
 =?utf-8?B?M2dqQXJUenRCZWRNSm1mVUFNNE5vc3N3UzdPNDVTODJUaUNieHBoVlI2QnZl?=
 =?utf-8?Q?LmE9dz76JDbiWIGXddU+ES6hj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46161047-7700-419f-fda6-08dc96dd02a4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 19:11:55.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMkReoWShw9j5+6n82AUfxDrmIsvHxjunJcS6ba7A2fRN+K1wiJh/Liz1BvvcA542UzQ83C6DoaCcLAqCqPqjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530

On 6/27/2024 04:59, Rafael J. Wysocki wrote:
> On Wed, Jun 26, 2024 at 10:47 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
>> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
>> policy incorrectly when boost has been enabled by the platform firmware
>> initially even if a driver sets the policy up.
>>
>> This is because policy_has_boost_freq() assumes that there is a frequency
>> table set up by the driver and that the boost frequencies are advertised
>> in that table. This assumption doesn't work for acpi-cpufreq or
>> amd-pstate. Only use this check to enable boost if it's not already
>> enabled instead of also disabling it if alreayd enabled.
>>
>> Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
> 
> CC: stable I suppose?

Yes, I didn't realize f37a4d6b4a2c came in 6.9, I had assumed it was 
6.10.  But since it's 6.9, yes if you can please add stable tag when 
committing.

> 
>> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc: Sibi Sankar <quic_sibis@quicinc.com>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Dhruva Gole <d-gole@ti.com>
>> Cc: Yipeng Zou <zouyipeng@huawei.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> v1->v2
>>   * Pick up tags
>> ---
>>   drivers/cpufreq/cpufreq.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 1fdabb660231..270ea04fb616 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>>                  }
>>
>>                  /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
>> -               policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
>> +               if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
>> +                       policy->boost_enabled = true;
>>
>>                  /*
>>                   * The initialization has succeeded and the policy is online.
>> --


