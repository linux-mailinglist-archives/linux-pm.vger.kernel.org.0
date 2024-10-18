Return-Path: <linux-pm+bounces-15961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D109A4058
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 15:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114751F2AAB1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA3418872C;
	Fri, 18 Oct 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tAis6PLh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033493EA76;
	Fri, 18 Oct 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259203; cv=fail; b=DqO7n0PsRTY8zp1SGasiOPVgcRLspTIbyZww3X8GQyXJHMeTVDaTjx+Q2OXlIhJ6rZHT2ZOJtSPUhCZtg22dlqxwHH/nINrNum3dQNwlguVo50OUPdCJM783UI/GbQoOeDu7UyJ0NE7MiFzC21gINQH6VVrTFM01GTxBZy8CYwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259203; c=relaxed/simple;
	bh=wDRIxTuU+fBXxVuMNv+d2w4syRCOEIRbaL1b1bS+FAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GY4ZAfgMSzXXNLtoAP8v5Z+DTfM1nnWbT2NbjRBQ7K5M9Wk/flczoICuWNLUplMIKGhXFK2mMYMlW754vVxfQtMu6YDjDY/m/JrahI4PxKBetkkrnm5BLMdoScFz3jSMZVRa4sMTYfcNC+6pKya9F6OssE5EK+FV7+D0VidjcUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tAis6PLh; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwZKZfoho2LHRV2BiibIZUmZL3cvoEYUBxOFiRnpUNVzXGgw/7KgGPBsTKe94WuTkBHkDW57FCYjDwgUOqojigYILC7Jyocl0z+FSfAkYuSid8ZAHspAtGKRohW6vkRAOQ2thm73wSi/osxeiPDXly++c2wggbe7aYWiNpncXhAGIrbU8JK5BIsWYNdgXK5vnNaY0JYaTzgtwA68F4XlYMcP9AQhVplnVPphoYh7fX0OgzlXkpyKtlG+QTXIwsEl6t1R9hlxHhOSNANArl4TJhGGvatEpRTsIIcqPW93BaNEpMJ81enfiPTnC+4g+Muam3EXdViPjDVlcQdipO9uxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLBLvv+dPDYRjThYJq9vf+HuOKnjuleKoYtZjSsycZc=;
 b=pUC72LTuf67jXq2cqkFGXE2BzNkNVpxb09WuyvQNSfHNDXr2s+8Pe2EEJ8tvgVJTM7kgyYQfgvL8e2lo+esAdmNv4bOqubtK37S3l+2b1jKFwASC1pX7gR5LYsV99/48XIRND6qSIiDzjjwiuATlVIj91PnLpbN7NrWspjXuXGeLzCcbVihM5tqiOx1NpTONDzeAtPoML3kalvnPyJYAMaCizXWCgDtWj0RdR+T4QNhdc8nyhepOxu4GtkgLUuJyXNX4hhxrA+u2KF77QL+Vh6tHzGz2bKQBxd+BL61/TgasUezXOA2lTiW8VGAb/r3f9VGf0fimL6wYDcZFFnNcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLBLvv+dPDYRjThYJq9vf+HuOKnjuleKoYtZjSsycZc=;
 b=tAis6PLhUnO787LznSDlE/JCkpP5+8AJHAQ334P/H/Z481EQUVpdgXBjha7cVWzmwyIN2Wssh2qfajuOn6NRHI+RFuyLx4UvPq9K3MQrUsQYD0b/bzBDC8zZHyRYXRkyVgyu2oi+YxMTfGRCEk3526fFUXlhWsF/xVozDZCQP7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Fri, 18 Oct
 2024 13:46:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 13:46:38 +0000
Message-ID: <4ada5bf1-87ab-4beb-8d25-f3c93c8fe4d3@amd.com>
Date: Fri, 18 Oct 2024 08:46:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-6-mario.limonciello@amd.com>
 <20241015035233.GA28522@ranerica-svr.sc.intel.com>
 <1395bee1-95a7-4d14-a5e8-0e1dc71fadac@amd.com>
 <20241017233343.GA308@ranerica-svr.sc.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241017233343.GA308@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:805:de::45) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc67dc8-d64a-4d88-7755-08dcef7b49f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWUwQmJlR3pCKzZTTVB2TlNlYk9ZZzROYUhHNHlJVUs1eE1sOCsrdnlGalJZ?=
 =?utf-8?B?dkpOc3MrOVlXZjEzQWFKVkFndHhTTTVuQUdpb1dEMVM3N0pwaEw1VTg3Szhl?=
 =?utf-8?B?Y29mYVlVajZMUGl4TUJ4SUNFbEZwZUIzcWxod1R3aG94aUZHakdZdVhESzhy?=
 =?utf-8?B?UFQ0VFo2ZGh5ZFZicUdRSTU4bVlxYmJoR3I4Q1ZwWUgycE5kNjYwb1RKdEZL?=
 =?utf-8?B?c2xyL0JCVHoyaVJWc3hHb1c2eFA5R0RGK2hjR0hhQU1xeThLWWwrTW5lenZI?=
 =?utf-8?B?RUhUZ3YwancxTXlWNGdWY2xBU3JCbVRPWDI1TU93Y3NhSFgrc1VJNlZzS1FD?=
 =?utf-8?B?VTk1SkVEVlMzVVRwOXFkditMcWpEL0dQUVN4aVJReVpKQXFQZlZsTkZGdFJL?=
 =?utf-8?B?ZmZ4OVNUaTRiN2VTYXlPZlZVKzluNzh2RVh3WUlNTnkwZFRPQ081UjFEUnlZ?=
 =?utf-8?B?WUk5VURrN2haelZZaTFsVThEbkEvUCtZWEdsaFI3SVJpcitaMnpkOW9oZElp?=
 =?utf-8?B?RVdTTSsyc0c0dEt0aFhhb0RwR3QwNmhEYUZ5V1Q5ZGhTTzhhdGQzTHR1RVBm?=
 =?utf-8?B?bkdnOWxnVmgxeTA2NXVzejQ4OXpwbU5rNGttVnA2cG9yTDA5VkY3aGtkNnFP?=
 =?utf-8?B?WGxFZUYxRnh4U3hDNkw2SXZNMFkvODFwZExkVHBtTTdnMUdjSDF4MFVEb3o5?=
 =?utf-8?B?SGw4NE9FS3V6OGpZOWIxS3BoaVB2S2JMSFV3WVJYNW9EamdLQlBJY2pEM1h2?=
 =?utf-8?B?NFJ3STdUNGM4dm01d1RFUkRMVWYwSWJ3a2NqUDFsaUJTL2oyanY0MkU4M3l5?=
 =?utf-8?B?MXcxS1BaTmZQYXZCdjJSZitDWk45bnN6Q3M0dlJSNzBjRm5mTm1pSmlTRVFv?=
 =?utf-8?B?dmJGeCtUZ3NWbWJQMDJHOWtRV21ERDJaYnA5MDQ4OFJIOStxQVRiazI4cUFp?=
 =?utf-8?B?RGNXNHgydk8wZzF1dGhGR2tNRlVodnA1cnhPYlhWZUpYZnBHckQ3UUZzWGUx?=
 =?utf-8?B?Y0R5am5hOHFDNDZPeXhkZkhUbjM1Zk8rNlhCK2wxWGlQSHRrWkxxREtxblBV?=
 =?utf-8?B?S2xpZXRXSFgrOWRlanpIamNtQkZoaTBCdDZnWHRSemV6clZ5Zlp0T2VEL0ln?=
 =?utf-8?B?ZThnYmNrSS8ydTRoOU1NaTZXRlVjZU9TUFd3N25NRGVDR0tMZXI5MGlXZjMv?=
 =?utf-8?B?ZVQ3ZHZnN2FGeXliaENtbU12bWFhSUw1ZkgrV2huVkxoOUdxcnQ2NEFQYmxO?=
 =?utf-8?B?UkhCMHc0WFRTbWhnbUZwUXZUQnUzZllYb2lmaTVzdHd3ZlhWODc0QVpPUk1q?=
 =?utf-8?B?YTlReVRnWXc1ZCtTNDd6OXdrc1p3Qm9mbWl0WkFQOTFQYjVZYUMrN3Y0N0tF?=
 =?utf-8?B?N3E4cjIxTlRhYTlWTGc3WVQvMEFIYk5jZmo0cUVZcnZlcU0vNUYzWE5sMmJp?=
 =?utf-8?B?NTJjUXVxbUtPZ1ZGbHdQRjh0M01VSUJMZVZQbllSWnQ2TTlpMVRtdjBneXhJ?=
 =?utf-8?B?cUZyOWpYNEtIREVjbDZJSUdLSnp1b3NseVVNRDd1REFWWGJ0WUNOclZrSlNH?=
 =?utf-8?B?cys2ajNTSjZVYUtpTUphRkNpaXhxSXpPc1dVNER1MW1zOFBsWUU5VXRxYms2?=
 =?utf-8?B?U1BFUUlhZnF2VjVTeGNkT2c4UXVEZDhEVGxQRW5JVHErSGhmU3VXTEM1Y0N3?=
 =?utf-8?B?SmpFZmFMYWtQZ3g4ZHdYL2RxbzhMajlOQlhRK2p4ZTRiODQrbFIyR1hRdmhF?=
 =?utf-8?Q?mj9IQRcEFAYZyY0KFSaMimfvre8apDAYhOr53/k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUJoeVRwTjFESWpoOXJrbXI1UDczUmdNUHdsQTB2ZndGUWtENnZBTjltOXV1?=
 =?utf-8?B?ZkhhZnVMUHg4WmNHUkxHNzZ6N2xQMXY0YTJDUWg0a00zeG95N0Z1UUtrd0Yr?=
 =?utf-8?B?RjV6VGxWWm81NXYxMjBJUmNvQ2ZzeHFaR0lmNEU5UlVqY3pWWDMxNHFQb01B?=
 =?utf-8?B?T1lxOFEzZ0xmNndPYXpCdUhQZ0tKQ0F2eVBhUjFyL2N1aE95cHVxZFlIWUZN?=
 =?utf-8?B?em03MUxCeGNCSHVyR1N0V3RZZUI5alJsbjRxTkxya3hwcStKRy9XOSs3cThE?=
 =?utf-8?B?M09GVEVzWHpyMVNndTVVYUI4eFZkQXZIOWpRQTY5SjlidDZxTUZwTml4bE5E?=
 =?utf-8?B?TzY2V3d5YTNiTEdLQ0poVUJPTFVJL0dTQTE4QWpQWE0zR2lSWXFBUmtqdEJL?=
 =?utf-8?B?WHVTOG50Q21FakdZVURmVk1uZnZMMEtwa2ZWQnpUMm5wREJVL0xQUFNKNGZW?=
 =?utf-8?B?YkF6Z0Z4NnRUM2Rjelh3QkpiVGd2SDdDa21ac3NWNWVETmhtOG1BUkxqbWNp?=
 =?utf-8?B?VnAvVm1TZ3hMeGVMTG91aTZPN1U1SHJ4M1hlbVpPK1RtRmN5T0Zva0F6aVhX?=
 =?utf-8?B?RjVzMi85VDFKcnRTck43RTFESE9ZVlNWWHhNVjFucy9VSStVVXdBTWdwbHZJ?=
 =?utf-8?B?MTI2ZTJ4Vmxvc2E2NXR0ZGtSbWh1WDByREF2V2VkcTdRRlpHUUxrM1E5bjJm?=
 =?utf-8?B?RDJMZ3h3L0dWTXpxRVJ6aUk3ek45VFkzc0pTYlV0SjQrVHBQS3VUc2ZIeHVy?=
 =?utf-8?B?cEE5bDdGNVR2WFpHbWdyTXlxUmFKSHJ3bG1ueGpSb3JQS0dBYVllaGsvbWFD?=
 =?utf-8?B?Y1JycGROTFdWdnIrTnNVVnlyZFBPVDJMN3lKWmhWUStCdjNwb1cwclVOSHRw?=
 =?utf-8?B?d3UwczI0SGdmaEhNd3BRYkxwdFhJcktEOVdWTFNwRVhGcFdoWHAwU1AxaWV4?=
 =?utf-8?B?d2ZOYkxvbmZnQmpBKzFHWURYNXcyc3psV09KTFZGQ0hrdGZnQVlxNTd1VDl4?=
 =?utf-8?B?SWxsRkRoRjh4MmxJRGpyZGJwUnBDa1VIVXY4NGs1QTJHSnF0UFJLWmNEb1c2?=
 =?utf-8?B?RE4vdkRxc3NhdzdhZUt2R21kWFhUb2lEZkNGWnFtMzhWT0dlVDdDL3puZU5Z?=
 =?utf-8?B?U2tOa0lxVmZQM1NZakZrYkpwaXYwakNRbDFHaENsb2xKV29iMTl3dWI4NUlM?=
 =?utf-8?B?RGR5d0J2OTBKeWc3SjlGbnhVSk5XeGh6NGhpVEVjMURTWjBBZ2NKMUtLcCti?=
 =?utf-8?B?NEErT3pHNDR0cVNtS1RxOVcwRFdsNHp6cjZwblI5dWwySnRYcHpJQ1ZkN0d6?=
 =?utf-8?B?cXl4blFsU3FFaXpjdG1aMU9HeS9UZCttZnBBYlBkOHBrRk9wU2ZkOHBFbkJl?=
 =?utf-8?B?K25nSlF2WGYyamxQWVQwOXJPN3lXa0IrWmhaSzVVeTNHYldWbmw3MG9HNXZO?=
 =?utf-8?B?N25mcFFWUFhPeG1md0p2MnNwUHpSZGl3VDkrY2VxY0x1MXp2cUxvc1Q5L0do?=
 =?utf-8?B?MmFmdGR5c0xsM08rZGUwZ0NhMUQrdDlOT2hyZXBDZTB3NG1XMnhlUTJoU0Fm?=
 =?utf-8?B?RnhvNlh5QkhBSkFVeXBnSGNCSmNvT1M5YVZpN3ZIbVV6YWFkTlpaYkpiRSs3?=
 =?utf-8?B?V3VmY2FZVEllcjdUK2JzZ1FvQWFQdHZYRnFzYkQwYzB5c1dVVnpKUnRYeDVj?=
 =?utf-8?B?bVpaUDNncU0weVpQSkNzYWFXNlhuZ1QvL3J4RXpMMFFLK0d6WU1RT0JnTnpk?=
 =?utf-8?B?RUpEdDJRUi8rdGdmNFUxaXc1aFRBTlk5WHZaY2lXcTBtSVptL2hkblNxVFlq?=
 =?utf-8?B?Nm93Q2RXWFp6Z0dqcHhzclNiaENuVkRrM2hxa1E5dUpGenptbnpNb1NCQm5J?=
 =?utf-8?B?SXhWa0RSNURRS0lKZ0gvQ0FEODQyUXo5ZGUwdjdxYm9DbTFZWEo0Qjc4VTds?=
 =?utf-8?B?SzNxQVpLWXArUkVCamhDRDM5UW56bms4NllhVFV4STF1Rk8rbmQvKytEbzky?=
 =?utf-8?B?M1NwWCtIVmRpQjhmUDl6N0NRY1kycEc2SUViYU1uZGJUT29XVkcvOWcvMG5Q?=
 =?utf-8?B?Z2VFTUdWN29hL05kYUo2ZnBhZURPNVF0YWdZbWxZR3ZIdGtUcm50OFh0Ykg1?=
 =?utf-8?Q?AslV4l8WIKLlFgLPm47ojjrYT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc67dc8-d64a-4d88-7755-08dcef7b49f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:46:38.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wiY7zUjU2Dl00bF6gH3csxzJPix7avusfwXWK1pD3WX7TZqa36G7BFWEAdB3YuLgcPRq4DtXrjM5JDZCU+x1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022

On 10/17/2024 18:33, Ricardo Neri wrote:
> On Tue, Oct 15, 2024 at 01:09:42PM -0500, Mario Limonciello wrote:
>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>
>>> I tried to find the HFI details on the documents in this "bug" but I could
>>> not find them. What document in specific could I look at?
>>>
>>> Thanks and BR,
>>> Ricardo
>>
>> Hi Ricardo,
>>
>> It is spread out across multiple places.  This is part of the reason for
>> patch 1 in the series outlines details of how it works.
>>
>> The reason for that "collect all" Bugzilla for documentation is because the
>> URLs for AMD documentation have undergone changes in the past and it makes
>> it difficult to put stable URLs in commit messages.  So teams that want to
>> reference documentation put it on a dump all bug for a stable URL to
>> reference.
>>
>> On that link you will find the APM, which will have some documentation
>> specifically for the CPUID leafs used for topology identification and
>> clearing history.
>>
>> Read patch 1 and let me know if it covers what specifically you're looking
>> for.  If it's still missing some info let me know what you would like added.
> 
> Thank you for your reply! I read patch 1. I was wondering specifically about
> more details of the Class ID. I see that they have associated counters and
> desired scheduling behavior.

Ah thanks!  Obviously in this version there is no utilization of the 
classifications, so this was an oversight.  This is something that we'll 
worry about after the baseline support is landed.

I'll make sure the documentation is updated in the next revision to 
explain these.

> 
> I was also curious about the layout of the HFI table. I guess I can infer it
> from patches 5 and 6 but if there is a picture already, I wouldn't mind. ;)
> 

There's no picture right now, but in v3 I added a patch at the end of 
the series to dump the table.  I'll see what makes sense to add to 
documentation.

