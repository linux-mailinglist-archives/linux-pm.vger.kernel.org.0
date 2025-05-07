Return-Path: <linux-pm+bounces-26822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C4AAE509
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAA99A2DA9
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C228AB09;
	Wed,  7 May 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W34OYDPB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667728AB04;
	Wed,  7 May 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632403; cv=fail; b=bSgo49+Iql1ScTUJPUTMw6/Y3ja+EcFv9KEyimnK2EFcTMKaP3ZqUsBrvfHrmrp7N5ByE0WUefKJQTvMJqfgEHtB3kyRirSMnf4V8/xeB59ivfJy8oVr4R74XtxQ6CZac8ZjzduDClgTxRMuOnCJD4MjQOXNbxo1NOdg+Sq6huw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632403; c=relaxed/simple;
	bh=gxj/Mj9XZWK2yNVpJpEDtbCWPeuwn83J3c4Vw4MCJng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gC3gNYx19Su/Z2RxE9qTTixgwaSNrohR1H3bJM7mE7ttheJ71XqFmI6Bp3Fc+e49iXQivwiQINSEkQ/oQo0d07WNVqXhatXANKq2M1VLq6MmztIiHwYnndKmmp6ntvtTpq4BH9FnAtVc/0dRFNw3ki6rqNNIrfwT9RfBWS+SBzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W34OYDPB; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy3UUa4USY+3fUu3EWyds4KtgwJmZB5EiW/zfiiu/3QvZYX3YASRUdAgFm4c1tq6haPbTQR/WPSrwjxwx3GTjgtrI77LsLzu5aBgNAN4j9dTzmBn0knQa3uwzLA2wdKTTg3l+wXfk6C0JdJBXaZPIVkdxRaWnpcLQIYxtw/t86aSCMu6xNEb0F/QNgqffXJNwgqQDif5xZu7Hk0aI5JJgJ2zMPyenKi6vcYPtHGS+ynSGsoHfanW0XZZzaJmDA+Gw/ujYXhD7e8vvARVeBpofIpgAevjkJsBAEKzmDn01QaPYCe6x0ZUEY+vx1MiPYankjTRJdHNIWr/7vE8lkyH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZF4f1OljxdH9yzKOSp+u6Suq5+P4Tp6fwjaHQrygY4=;
 b=rgdIDWp1w5fwhCzKYPYgA7zLt68rjXPeyYJTXCv7YUlad/+PjAU+pe9x/+ysawERU+Ix6Bxw1g2emFvxVdnzzV+lSSye+usGjisEw7lTFzIGMDa+kwORa1k7EBb8pvU/VIaQf+Z4nBMU8ShowkYKZEwlA9iMfkY2vZnwrK9qUQwBjUVHcwV+oFOT6xzsD+YVlpl8Y0aMyvymFd+QWBTML8sCl6kaaYSlqMEQ9giug66QjPKooNivxmsIg1uvyrTYcKMVobaTLzr2txlpfksE4XF6AVXbV3WN+gQgvHnaL0z26/agv9VbEyrvJLsuR7rJdvniB3ddsU/taIPa87AN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZF4f1OljxdH9yzKOSp+u6Suq5+P4Tp6fwjaHQrygY4=;
 b=W34OYDPBUehQrFbvxUDZqexkSNacS1a6ewiKIMgK0I+dH5F2YJ/gEb8U9R39XyxyvkAcqNYRPr4QT0amxaTJHueDA0Jes0lN7CjG4rsdKTWxHfJYhWG6nodK/rd6gph4oDm5k7mlgXszGyZ2qQT5dVC0IcKq9OkRyVz1UuLhCzdNPBcLNQCpuYxEulqnHtn2r2ChenxKDfO05Ucp+xQh+E5fwJtRvGhvpnmuOkFh4/ygltHaeN3UCYO5fS9b55DLSA59L8osIJGjrbNJnI9tfIHFnPyeuZUO0f/GJzB9w/YiqxheyH8EMv84Ba/2QrVnNkRt5Igm7h3bBXmC9YX9Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 7 May
 2025 15:39:56 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:39:56 +0000
Message-ID: <b17469ee-0d8c-49ff-8fc8-a3c3cc9964dd@nvidia.com>
Date: Wed, 7 May 2025 16:39:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com>
 <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
 <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com>
 <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
 <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com>
 <563657c5-5529-45fd-96fa-bab68ca992a9@nvidia.com>
 <CAJZ5v0jVOG_u=F36aOVh=qu4Ef-5QFAmC+5-fmF_mU8NSr_LnA@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jVOG_u=F36aOVh=qu4Ef-5QFAmC+5-fmF_mU8NSr_LnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0263.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 3068e490-589d-466f-7ec3-08dd8d7d6aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHFhUEcxZ2lJc1BrL09SV0o0MitpS0Rzclo1ZTh2eXNpclpudHgrQ3NmdFk5?=
 =?utf-8?B?eXVndUxUSHpFcHlVdnkzYnNYcVRjV2xZMVRzQ0lGTnRoUVppOEw2YWZXazZh?=
 =?utf-8?B?QlhVUEdhWkRpdzlKaCtBc21QaW9SREp0SFFDZlpYY0hyOVNvTmYyTy9yb3dL?=
 =?utf-8?B?NGYvWGg0QkcweFlzempSU01ydHp0Y1hucTRxVm52d1hlWmxXajFRM1RWQURX?=
 =?utf-8?B?dnpzejUxMmZhSFN1QWdhdDh1VGhsNUhQT3Rja3JVR3IxQlBhcGJkWHpkNll6?=
 =?utf-8?B?UkdLY2xnaFYxeHVnNWlaRjhvSWw5UU9vV3NjMlBVdzRjNmtZVGV3aDVhdDdx?=
 =?utf-8?B?UklaOGNqbGlZVGhVamVoUVZPUVZMNHFwZU11UFFMMTl5c3M0SmtVcHpXNlBR?=
 =?utf-8?B?QktoeXRqcjd3aG1qdDJrUlFtUVZhSXdyV0lHWCtTWXhNWHk3ZEZtZVdqOVla?=
 =?utf-8?B?bnlCMGtlU2c1L3pURDhqY0tXa1NRWmtqaHgwbk8vUThrTkE1QnovN09sanZq?=
 =?utf-8?B?S1hES05IWUVUUEs0Zk5Hdm00TXRqRGd6VW9LRUduSzZiQzVQYTI3UnpjVUR3?=
 =?utf-8?B?M29tUkp1Z0tnWFJiZEtnK1kxcGNBSmRwY0g0UHVYTEJ1V3NmN3hVRW1qWFdv?=
 =?utf-8?B?cllYQ3h2elNEMlR1eklGMEQ3YVM3Q2xyNGNWT3Z6bTBWVG40UGNQQkRxRlJx?=
 =?utf-8?B?ajgwanZFa3NkZ2FpMW1RL0cxbDkyK3REdUFYVXR0dlhxNDVYL1NxV2h6YU15?=
 =?utf-8?B?RHJnTEk1TTl4S29wOHh2bGtLU1M5S21HK2djMVduTnluTlUrdWQyRzZZY2RX?=
 =?utf-8?B?V2NaSGY3anlNR25MdGRlYlhJMlBVVUsvd1RMRmQzL0dqSk1mVThNV1NGYlRh?=
 =?utf-8?B?TlZYbjVWRnMzUk5pY1QvRlc1R3lXb01QclAwbmc2QTNLbTJZVzVGSE1yb0lo?=
 =?utf-8?B?c0hJbWIyR0NBMGpIcC9MQkg2MnIwVEJvRmJUQmk5OFVCQ3JEekpzY2FtS2NX?=
 =?utf-8?B?SUVXRk1sU1duNkcrdUlrcHl3SmFMOEFWaEVjZnlYWVBodWZNME15ZFB5NTNw?=
 =?utf-8?B?RkY1RklGUWt5TFdPUDN5MlM0UEs0akw2RUpwWGxERXRDemhrSFBtb0RLa3E4?=
 =?utf-8?B?ZXNMMml0SCtyWlBpQmRJNEJDQXprYlBOaHFhRVgrbWtDQlJZRUkyMk9MdjZj?=
 =?utf-8?B?YzQrWjdyTE5iN1J4SzZYU3dnanVZT29RK3JZT3JRWkZBZGVuaUt4bUZPVjI2?=
 =?utf-8?B?K1dJeVU3V0duS1EyMVZXQVFQYW52SGhhbFI1NlBSbU1VV0JIWDAvVHRyZjF6?=
 =?utf-8?B?SVpxYStucEtBOGtHN2pLRXJnKzhrMXE5Z2pRa2pCeklOYWFaRzBLYVh2VVQ3?=
 =?utf-8?B?NG9GTHlJTHhoeDJWdHhmV1NSNUtuQUt3UjdXdnd3RlN0RW5PRHBWNFY3UWJX?=
 =?utf-8?B?djN2dUc1UlR1bm8wanlTa0M1cXREUWNTMzJFckRMZmFCYVFBaVJpSnlEQTNa?=
 =?utf-8?B?bUQ4Qmh1TDFXU04zTFBGb0RZTWQ4OHdFN0pOYjNPbng5elpUVVNDS1M4Mkdo?=
 =?utf-8?B?RzkyOXZKb2JCaTNNQitVOG1PSWtpN3doT0hzN1oxaFV5VFBCYThwVFZGSTBs?=
 =?utf-8?B?Q0dmQU1wUHZsVStOb2RpWUg4SksybWNTNVFFR3UvT21QdndqbUNXTnFtSHhx?=
 =?utf-8?B?SE1hWE9nRVBMT1Jrb3oxdFFibFY2Nkl5UTlCMW14Y1BpZTFvazd0QWFRWG9P?=
 =?utf-8?B?NlBYVlUvYzl0M3ZmdHVEMTJiQnE0cWR6a1VqUEdwdVcrRmRRanRnU2kySzRw?=
 =?utf-8?B?a1E4NnhYQUdVNG1TaUUxdkF6eUZkcm1YdEl6VDVJbjVQREZGNDN2SjhPNTlv?=
 =?utf-8?B?cHptcHZwek9QQjMxNjU4NHlieWlET3I3USs0UjFSd2hsSFhJNGhZMGg3alBK?=
 =?utf-8?Q?qYe4U3Vcs5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TSt4MkVjVmRzNzBVKzFkRyt2Q1Q0YVE2SC90dXhEUThQR1lTUis0Q3gzRmFG?=
 =?utf-8?B?dGU0MTNJMWFJd0JPVHJsOVhyRGdzTkhWNFcyL0I0OXFIWC9GU1Nqei9HVWRp?=
 =?utf-8?B?aTAxc3hpRHJvNFdRVnl0WjRJaTdmUmYrTGJON3hUenpRQW9KSHZ2bVJNN2U3?=
 =?utf-8?B?YlpsOEhCeE1JWDBKSXNkM2RCTjR4ZnFHcE1rN2Y4bU4ybDQ4WEllZ3NmTW8r?=
 =?utf-8?B?RDVRRkljc01WczFNNVVkS0lUVTN2elg0NUxFdDhFV1RLQmZZdXJXc3hiWTlQ?=
 =?utf-8?B?SXIxWk9QT2YvcXFaUDZ3eEZWT2lPNWIxYzF1T2w4UjFNYWFqak5WcnVSRnhW?=
 =?utf-8?B?U29FR1MreXVBL0x0Ky81UFJTN1dPdFI2T0tNdUFlYnFxclpuWkx3T1o1b2R6?=
 =?utf-8?B?WllObjNNWnlJVzhxNExGTXlOUWswM3VXQXFXWEZQc290anV1NW9jYWU3a09Q?=
 =?utf-8?B?V05IQzQzbGU3K1dST3luZGY1UW9vOFR1YkMweTNabkE4eEQ4d1NFemViNjhx?=
 =?utf-8?B?Z0tNSzE1Mzg1S1NUQjUxNU5TNUdiWm5GT2h1WEd4dkFxUkZyVXZVQmppU092?=
 =?utf-8?B?NUxwWTcwK3hGb3VFZ2JKb1NZRXdwZklreXFvL1gyRnNJeWErTnNqK05sVGQ1?=
 =?utf-8?B?N0hMS3l0bHFBSndvNHQyOWlpMTJJcGRpTHpNMWZwNGlSNmZsUHFMS3dzbmtL?=
 =?utf-8?B?a0t6UW9SQ05iTHkwOE5mT2tLMFYvU0daY05MUEJHZTRKcE5yUXpXUzBLNmRs?=
 =?utf-8?B?ZWQwVHd4OU4wYVhvUWdxUHRhcTkremk3dXk0WHJiTGozQjczbU1yTldCM2p6?=
 =?utf-8?B?MUdTVzhqaTQrS3pMKzlmNjZTaE9oUE9ZU3grMlA1dDI3ZXJITlA2VE52Yk0y?=
 =?utf-8?B?NkhiZHJodFpSMDhKRGdZbXE5a0VzUHZ3eGI0bGFqTUo4aFhBbFVBZlpid2Y3?=
 =?utf-8?B?UndZNnBreU52UkoyMlNuUU5IeEdlbFgrTkZOaW9jazZLMXhTUGh3cWVKQ1RL?=
 =?utf-8?B?NTNRUVhWTDlLNURhYVVnVS9PTlVmUURpV1JyTkpmVXoyV1BRSjNOSW51VEE3?=
 =?utf-8?B?elhlemIzdmgxSzNBWGRvTW0wazJTL3BraTg3VGlVcFVZaTVTQlNXN2tydG1u?=
 =?utf-8?B?WXRMOVNlVndxbmZFT0Jnb3lBb3ZqQ0lWY1I4RFRGemtIc3RWV201NWtvWGh4?=
 =?utf-8?B?VmdXUUlSUGpQazBoUWFhUGFCRXd6NlJDR0xreWZ4VWs5a1c3dEdVZGM5T0lt?=
 =?utf-8?B?L3hGK0R3TlNZdGVTOHpHMllVYlkzNmh4bXA5T1d4NU9sckZzYU9WeEh0dE80?=
 =?utf-8?B?M1k5UlRZVlU1eldKaTJ5bVdsWnp3U3RCczllTmRoamZHRDFwQ2FJQ01ONGg1?=
 =?utf-8?B?NFZEN3RGYXFFNDFEYkFNOE5pUjEyd1MySUNwNERiSmlUbWVHenozeVZ3dkpC?=
 =?utf-8?B?VlkrdW1MMkZUd280ejY2YnVtaWhTQlh2aGUzaGNEa045VmhnWWlUSUJ0d1VM?=
 =?utf-8?B?ZXZMR3k2MS95dThpR05wUE5CN2F2QkxBYTJnMFN0QVo5ait5YUpMSXJlNmZI?=
 =?utf-8?B?UmRTR0lJVVpXblZucmlHYW9aUENtcnN4cDhNeTlLbW81Z2NlZEhGS3JuOVJH?=
 =?utf-8?B?NStXRUp2TitYOE9zcldMQmh6SDIzNFpHV2tUbVVwNFhUOTN1TFUwbEVDRy8v?=
 =?utf-8?B?Q3puSCt0RzlMNEVGVnhRSnUza2tKckRpUU1zUEdwelN2cWhFSzhraXhUR2xw?=
 =?utf-8?B?SjJiRTFBU3E0aS9vZWhsMWV3WlN5SC9xR1RRdCtoS2hEdXdzOHNVdGd2clZM?=
 =?utf-8?B?WUhaNktOSTVlYnFJbGdPSDRhSGxZNEUxZXFvN1NKaU9BQlNOYmFnNkltbVdZ?=
 =?utf-8?B?TVJEWHd6RjViT2h0d1ZVM0MxY2gzSkZoWXdDLzFwQkRWZVVLend0NkFlemlB?=
 =?utf-8?B?T3NoZFM5Ni9HMU8xTVl3empFSkhubkdiV3Y4aUdrMHo4NFZUV3cwWWVWQmJp?=
 =?utf-8?B?ejFoY2JER1ZGamRhUDZLZkJoZXFmaEVQMk5oUWRxRmc4VXlReVBDRmdoRktv?=
 =?utf-8?B?MFN1SWRoYldJTDRJTS9zTnlBVFZSN0I3NlhwUFc0UkVKZ1Zyekh2dWdycGtD?=
 =?utf-8?B?QjRSK200MzVScHNEbjNPeG9BWi9Mb2N5U1hlS09DSjgvMkJvdmtrVWxGTDZm?=
 =?utf-8?Q?h9dGQg4grXy2cHh4HA9J85sE5ZYIkBJIcR0Fer7jAGFB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3068e490-589d-466f-7ec3-08dd8d7d6aad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:39:55.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vXZHSwCdQpegQrHfmmA2HtEO39ISzYFqAVDIgOciVVHVqGulfhy112zZ87f/zE7YI1afNV5FBH4uAaAXgX04g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603



On 07/05/2025 15:56, Rafael J. Wysocki wrote:

...

> So apparently one of the children has not been suspended yet when this
> happens.  That's fine because it should be suspended at one point and
> the parent suspend should be unblocked, so it looks like the child
> suspend doesn't complete for some reason.
> 
>> I will enable the PM_ADVANCED_DEBUG and confirm that making the I2C
>> itself non-async works.
> 
> What probably happens is that after the "PM: sleep: Suspend async
> parents after suspending children" , the i2c clients are suspended
> upfront (because they have no children) and when one of them has
> suspended, it triggers a parent suspend.  The parent suspend then
> waits for the other client to complete suspending, but that cannot
> make progress for some reason.
> 
> Before that patch, the i2c clients would have suspended only after all
> of the "sync" devices following them in dpm_list had been suspended
> (the list is processed in the reverse order during suspend), so it
> looks like there is a hidden dependency between one of the i2c clients
> and a "sync" device.
> 
> If the above supposition is right, flagging the i2c client as "sync"
> will make the problem go away.

So all the I2C controllers are 'sync' devices ...

$ cat /sys/class/i2c-dev/i2c-*/power/async
disabled
disabled
disabled
disabled
disabled
disabled
disabled

The I2C clients on the problematic I2C controller are all 'async' 
devices ...

$ cat /sys/class/i2c-dev/i2c-2/device/2-*/power/async
enabled
enabled
enabled

Setting all these to 'disabled' fixes the problem. However, also just 
setting the 'cypd4226' device to 'sync' fixes the problem (the ina3221 
devices seem to be fine being async). The 'cypd4226' device is 
interesting, because this one is a USB Type-C controller and there is a 
circular dependency between the Type-C and USB PHY (see 
arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts).

If I make the following change then this does fix it ...

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c 
b/drivers/usb/typec/ucsi/ucsi_ccg.c
index f01e4ef6619d..e9a9df1431af 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1483,6 +1483,8 @@ static int ucsi_ccg_probe(struct i2c_client *client)

         i2c_set_clientdata(client, uc);

+       device_disable_async_suspend(uc->dev);
+
         pm_runtime_set_active(uc->dev);
         pm_runtime_enable(uc->dev);
         pm_runtime_use_autosuspend(uc->dev);

Is this the right fix for this?

Jon

-- 
nvpublic


