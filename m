Return-Path: <linux-pm+bounces-14583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6013E97EF18
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B1DB2160C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 16:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F93823AC;
	Mon, 23 Sep 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uOP0KInM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96182197A97
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108476; cv=fail; b=qRecAIlj9MTwGwE50X4x014cVPWtS8lnIOZT4/YJRXCNi/QYCNKqBVYsFroxSSI0wlHyVaao+TIg77XUkxVmfjhmo7Zlce/IuTRyAwB0sWlS39eYv+f2L1etMuHih+eIvsCGVktg7i6aRIRGuh1wyDPu1dcLrYE1GKDZm0VVWus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108476; c=relaxed/simple;
	bh=0oO+PsDDhVrgq0p+737skhH1Vc8zggZuOi9/tOKwklc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YehTTOFOX5yFaeOaqnJqTlkEsFT+2tV/khRpHCfxCnfzBrR2kl+ofXnWdui5QfS/nl4zd7NyPbCqBwcMNJnim9TxFTHJF9bCnFrzDuYQMBw+3NviknCjWbFhaymXZ+7fYAJUQwsAtvt6maAAkLAyrnXzRi64a1DrjMYacOajD00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uOP0KInM; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wumu5RrOwBBQfX5eu/bjUW+wr1lJmnLK0R4qEapbefIJgOW0G9F/klrONU1vxkw98vtLYj6SpDxYdshkE3Drb7aZpFbrfQ1TY6x3z3ZD6VWGNaatIV25oQJJ79VjsqXZPBxPp5ju391sryMBtbAs2X2021GgBzNebRHTnf/b7dWLJY2R2TrAik3hTMlF9M2R3dRSJ/btq5gLYbf3/XdBsXV2RHetpYbR3rPCGSlTgQeUZge84cGEaqCdzW6FnxZoYEYGMUpkPGhxSxBoUAaWf+7k4E10+7swR9fnJQN3Mtbt7zLRP8nRSko2Hm/ekw2gQuxp4vbfU9KXcjbg42vsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8vY+9JhsxiE0FmuaSoB9hkNGvKj1pg3fUlb7sVGRgk=;
 b=Q0quKkIxHTkZb1WhtU4ec8anDxwrB5dySwkmh9M1voj/kix8Fhb2xlY28K46Vbwm5JbNZACeYCtmtgg37GzqYgJMu5rDCUUpzawo4LvSH+ECx1uQuUAgb/Wds0iELrAj7k42enwjSM6g5dPS5W+DNTzAQ82kCD/3j6TBVLgb8/gJfnU4dyiOJSoGy5zfFSRi0TLlgeQvtoeSZUQH5VmkHpzR5OMmOjT/mYfN/gYn334T1ICo6YqZhLcAZkjrYd3kCzOJxJPSHKx+TI74BDjesXOVdf/ynPkcX1dHH8CuSUliswBBg0sKfKtoNB+KaCXCV6+e2X1wk4VgvbtXE0R5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8vY+9JhsxiE0FmuaSoB9hkNGvKj1pg3fUlb7sVGRgk=;
 b=uOP0KInMS17VuHf0Y8QdCEpZ3DKbO2CBfJ6WTkFuQu539Uf3CsLNBXIiJ2mryZzgqxDhLzHVoRsKusDFsyW2CLGPv41o/o5qSJJ7FoWMwi+O36WTgPQM7eu5Ds640nXyKbfOopwuNEvKWHnSwF33JiqmhrNYoP+cySwTHyYpDeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 16:21:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:21:12 +0000
Message-ID: <358ca905-ae53-4d2d-b09a-8e708d6fadd8@amd.com>
Date: Mon, 23 Sep 2024 11:21:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Luke Jones <luke@ljones.dev>, "Derek J. Clark"
 <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
References: <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
 <20240923013657.7464-1-derekjohn.clark@gmail.com>
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
 <b43f9654-4dd7-4f3c-95b5-575473c3bcc1@app.fastmail.com>
 <CAGwozwE_MXuqreQvDFyVyodrzH5HFB=Nab9LfxD9DMB+HGkt3Q@mail.gmail.com>
 <fa1cb9c1-8b56-4fbf-89aa-86ffc6dc837b@amd.com>
 <CAGwozwHvXkG824xHcfnr6E+B6iLr6KJiLEjJhx4hEhieHYob8g@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwHvXkG824xHcfnr6E+B6iLr6KJiLEjJhx4hEhieHYob8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:806:130::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7177e479-978b-45f6-a16e-08dcdbebbd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnU0enhPSWQvbjhmYWRJRUw2aEpWZEowVDRIQjRqai9sNGUrR05tWHdUTmt0?=
 =?utf-8?B?TmJyZjByaHlucXZ1aWk0VkxNYndHUG1ybXA3YmZROEpvSzFtaU1JSHBQVTYw?=
 =?utf-8?B?NUFlTk9RdmM5eTduZGhFM2thZlA2VkJBdXVpZ0FUSDh2aDI0MW9aZ1Q2STBU?=
 =?utf-8?B?Zk1Kek9BaWRZWko1NmxCOTZ1YTEwTllaenl3WlM5SWU5amJpbDJhWTVoZ013?=
 =?utf-8?B?MWJoNnhhelZHWml5bENHRUljS3hpa1dFMzh1Y0FuQUlQUEtEQmRZLzMzd1pZ?=
 =?utf-8?B?aytrcnZKZjhxWUMycS9KOUxHdnN6L3ZCL2dWU3k4SG1SQ0xQOVBKMHBRa0s0?=
 =?utf-8?B?Ylk2TWlOZEt0MGorb0d1RUY2c29mbDdnZmd6U01UM2JyeU42N2FzT3BIMUl5?=
 =?utf-8?B?eG1lS1FPNU5jbWRKY2FLNmlEWDc2MHIwb1AvVWZERDhJQU9jdTdhNnQxSUJa?=
 =?utf-8?B?Q1VNVkJnUGlQdGErcmNENDl3ZWlzNnpXbGhlc25vc3ZFeTlqcml3NUdKZXd2?=
 =?utf-8?B?QXlaVEVYaHdweGhxYWdoQTF6T0xRZ0lQeUg5VmVhTTNiU3BtQlZWSU14NHlX?=
 =?utf-8?B?bmlCWTdCTVRBQ2lSOU83NXkxQkFjR1dZbTdZUUpqenpmY0ZVOFI5REN6Unc2?=
 =?utf-8?B?b3VKYU81RnlkVFFFaE1xUU0yTVVOTGV5dzltTGhjc29meWFsTXc2dmhiamp5?=
 =?utf-8?B?N0NnTktMK3MrNTZmbHROVEF1RSs1QXd4LzMzVXJJZXFCbFp3OEYvamNLY3p2?=
 =?utf-8?B?OXQwRmJYSmN1eWd1OEdYSWxIQTgvKzA3dWwxdng2ZmVTSmRHWFJNUWZtSFBP?=
 =?utf-8?B?VmI3TGtTdXNrbENvcXNrL3F2ZGJDTjJ2Rk43Tm04aHd6R01ZamF2a3JRK2J1?=
 =?utf-8?B?NXNKQ2R6d2tEUUJpT0JIRzRUQ3UwMldPdVlwNm9lbjJYaWFUekYwTjBWWE9R?=
 =?utf-8?B?MXRmRGlwT3BRZXYzUWVFVVg2UXU0QVpwZVBpUzlIZG5FdEcwT3lCTWdqM0RS?=
 =?utf-8?B?VTJsNjByMm4yak5SVk5jdHhjMllnSlYwQUkxTEdleXdnK3dSQU5WaDRlcEtO?=
 =?utf-8?B?OW83UHFKeGR1d2g5T1hXMTFNc0xOV2d1NndKNDhXUmJ4a05IN1hjZmhJSWVq?=
 =?utf-8?B?bGxyN3Nnd3hkOVlaOVFGWEZSZjBSZ3dOZThYR3VqRkQvZ3pXaW1iQzd3L0tS?=
 =?utf-8?B?U2tyNC9UWVhOMnJ4cnI5WU8xZkQvMDlvcXFNdFFVZEFTakp3QTB6QW9XN2NW?=
 =?utf-8?B?a0FSeXBzbHlmb3NHcjRSekROU21qcEJuZmNhbDh1dUlIZ05MdjJFRkduOG5W?=
 =?utf-8?B?b0J4Z0pQc1VvUG40ODZxcFVJTUNUZncxSFRMY1RaZkl0eFFPU0toSkRUT0t4?=
 =?utf-8?B?WUVyZ09PbWxFQktRWTYrMWwvQVluUXpyOG1ZTW10S2h4QXZYcTY2STYwSlhm?=
 =?utf-8?B?aWxySURtOXhSa25mN2RKWkFWRkh6N3BlZDdWcnNTVGxxYXpHbnArdHNpMU02?=
 =?utf-8?B?d3hQd3Y5STQ0N0lvZTBPYzZRcUx4Qk1iYWNhWExocjRXOXZYRUI2MkRuWWlN?=
 =?utf-8?B?MlZkVHI3ZE43TVZqS1ZSNkRwN0tpUGd5NEtvcDlEM25vdWJSc2MxV2xwaGFW?=
 =?utf-8?B?MjJkK2h1V1ZzMnJKR2cvS3NoNlVRMHFEYnYzcXhFcmZCYWliNWJvTEExaXhx?=
 =?utf-8?B?REdpMUExTjFaSFJndlBWbktWa3diWFlFZWZUQnFudHVlSFdYMDM5bDRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHJob0xLMHlrTXp0bzNzQW5ZY3dGMDdFemNTK0orNVFZVHFOMHU5dFl5dUhy?=
 =?utf-8?B?aHJSNUlVZmhSZDN4cGlqOUMrSDFId0pqYTJYcTJteFRPaUNCa2pqNzV2Yy9l?=
 =?utf-8?B?WkpWSU1PVHFvN2hvRUVoWUtRZmZXWWhhMmZNS0tnYnhvcnFTTEVpZGM3N09j?=
 =?utf-8?B?TjFlZW1zWGVMUXpVOWpvb1UyN1UzNnc4NkU2eXJOcEVCekFtUitwdGJjV1BO?=
 =?utf-8?B?SFpQNmluaGhaM2h1d0VHdGpkaEVlRlVSdUZ2bWtycWhmL3hUbzJUTDMrK0Yz?=
 =?utf-8?B?QjNDYjJqbVNSVE1OaFBYTzVZZEFEb3RaSFhOZll3ZEZsUDVMZUxEbjkxbmho?=
 =?utf-8?B?bUZ1MGxqWVNucjJ4aExSUGFkQXpmOXJLL281amcxZWNHN2d4UXVVWE9lWVhS?=
 =?utf-8?B?MDlCdElMYy9tWFdRRnNZS3hPVkdXbUJibVBtOXZ6bkRDK25Uekg4N1VTbURp?=
 =?utf-8?B?bTNsL1BnaTk1NU5QRkxMUWQxS1BINEVjRkdwalgrVTBNWllUWHE5OFlEQzBY?=
 =?utf-8?B?VmU3WVpCa3kreVlNWnpURE05OHVSZzdiaGJ0SWNFbnQyMEt3Vzg4ZmxPTFJz?=
 =?utf-8?B?d3ZhL1k4RTRhRjdBUDQrTHFQWnFaN1pMWlhnZy9PeFcrVU9OUkQvblowU3Jt?=
 =?utf-8?B?bHhOQUxyVzVYRm1CMnlpUS9NVUsxQU8rcnBsY0x1RDkzYlhVd211eUxBZGYz?=
 =?utf-8?B?MEYwM0NhUkxESmM4cktlem8wdDFRMjE5M1hNK1U0Qi9GNldxZjJyTjBrODR6?=
 =?utf-8?B?Z29HeDR0MXJ6Z0Z0SnBJbkhhQm5hYkZBUldyWjR6RVovMVVzZ1QvbVlnakEw?=
 =?utf-8?B?RnZwdTFBc2ZCR0JiSGUxeWVtSXR2c2ZPQmsyM0hIRlBuTDhYM0htNk12OEdR?=
 =?utf-8?B?M2JYUWRMdTF1a1pScGw2NFBTYnFOT1JPdFFFMFR6Rk9xMlZDWVF6OXJvSGxU?=
 =?utf-8?B?MUIyV3BHVjlWNUtoR1E3M1NxVzlUZm5VVzYvQzBsajM3dkRXdnRSUUtaOUhk?=
 =?utf-8?B?bWxqWjNOVXRTdFRjZ0xTVkhSZHRURVNRMzkrZStUZkk3WWg0eWZvajRnSHdD?=
 =?utf-8?B?N3IzRk1QYUdmSHpMUnVsOTFMenZvdk9kNzJlQU1UT09jZmNtUmZGZmFKK0hK?=
 =?utf-8?B?YjJnM2dDTGRGUDBlMSs5N2VnTzdJZTRId3k0ckVHRGx6N2VHM2VUYk1kbC9G?=
 =?utf-8?B?MFNwcFRaSUFKODczWUdzbUFXbHFXdXlwQVNxaTlUMVJNWUJHL3pOZ1pMbnNk?=
 =?utf-8?B?cldzd210czl0SWRRaXFGSWhYNkR1M0N6NTNtQXoxR0R6UWFKOEM5QnlhRmNK?=
 =?utf-8?B?WjQyQXdCbVhxSzZlN1gycEJYVFFXTWwzMWhISEVzYmlNK29TNWlVVEVFZ0lW?=
 =?utf-8?B?NVlCd1c1WUY1Y1lST0d2T3dzdnViTndJRmJzQktRVVptWlNnUTgrL2NQWDN2?=
 =?utf-8?B?bjIwMkp6bTJFWlljcS91L0xHSzhoZmpobmdaeXJSdXdMaHl5dmh1YVJ0bnVo?=
 =?utf-8?B?U0ZKdG0yUk4vNXEyMHY2bWZRREFVZzJUcFBoZzlCaUJLejRVVnQxbHBlSTRV?=
 =?utf-8?B?NjcxNEpkNWxza1U1U1VpM0o5a0g1MUZyYlEvbSs5U1dqNldDaVJCNWRKaDJ0?=
 =?utf-8?B?bjZJeTQwZnc5dnlKa29hWUFiQnZnZHRHVHhDVnBVS3JTVktBWFlHeCs4Tm5j?=
 =?utf-8?B?R08yK2hkTWdycUM5NEZsZGdzN3BFM1ByU01KOFNoQXdoeVVkcFlISHRJZFZM?=
 =?utf-8?B?S0xQcDVXL3h5YldIZ0VDMEZ6b1pvdFpvN1BTWTc4RXJ4dndrY0lUZE5oeVJR?=
 =?utf-8?B?MjB6a2RPWHhZNWtIWG9LNk1qNTdXNkpIdDRDK3FUZ0c1VW5raDVnalR4K2pw?=
 =?utf-8?B?YnNIR1J5SmlkaUZYSjVCUkl0TUVGNGtvQ0liMEV1aWQzZ2dPeEVKd2k0V1R0?=
 =?utf-8?B?SjN1M1FzOVNmQTZkaGZnbXo4OTZGQ2ZSSVhIQyszZmZVVnJ3RnZPanhKYkRK?=
 =?utf-8?B?cm5kcC82TnltMXZRRE9NbE1YeCtGeWR3UXRMZ3V2R2tzMkQ1RTFxbkt6YkRS?=
 =?utf-8?B?QWFjVWJwVWo4bHNXSElZNWZDcnJYQnl4TGp1WjVXQ0oveVBPOXFaczl6K2NO?=
 =?utf-8?Q?AkIUpEP599lPPB1i83ZudWcpy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7177e479-978b-45f6-a16e-08dcdbebbd3b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:21:12.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jFVKSdWWdiQl91Of8HyieybEj4ysGadLltMJKMOnGY3bOaUocVcc3eUJiyDgVFQdZ1OC7xt/MrJ9tPp4w6nRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359

On 9/23/2024 11:11, Antheas Kapenekakis wrote:
>> I don't think it's possible to have it both ways that the ordering is
>> wrong AND the timing is wrong.
> 
> I think the current firmware manifests 2 issues on the Ally X: Display
> On needed to be called once the kernel is ready otherwise it NOOPed
> and Display Off needed to be called 1 second before suspend. Then,
> there is the issue in my previous email that also exists in Windows.
> 
> I tried from 0 - 4000ms for Display off and 0 - 1500ms for Display on.
> Display Off, as long as the RGB fades 100-200ms before, made no
> difference. Display On likewise made no difference.

Part of the problem here is that we (Linux kernel developers) don't have 
the details of how the MCU actually interacts with the OS vs how it 
wants to interact with the OS.  Only ASUS knows this and all we can do 
is guess (or join an NDA).

"For example" (not saying this is the problem; I don't know) if we have 
a Linux sequence that we put the XHCI host controller into D3 but don't 
turn off the port first this might not matter to most devices because 
you're saving power by the controller being in D3.  But if the device is 
looking for some sequence of packets there could be a failure if those 
never happen or happen at the wrong time.

> 
> I am currently playing a bit with the calls in the Legion Go. Seems
> like one of them turns off its controller as well.
> 
> I did not know fwupd could do microprocessors, if it is simple that
> would be great.

Yeah in this case it interacts with the USB HID interface.

Unfortunately we don't have the HID spec from ASUS, so the entire thing 
would need to be reverse engineered.

I hope that more of these handhelds with MCUs that get regular updates 
make the same investment.


