Return-Path: <linux-pm+bounces-14591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A597EFC6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E991B21439
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EDA19E980;
	Mon, 23 Sep 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zsknQ0nH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5191748F
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111736; cv=fail; b=cV8hWUDUfXqyfa+1wwUvO08tH/29BEtgdfDVI3arq13fyZZGulf9dNV0vWegYdhIFCr7baXVa5ilVxHxP0gQ9dZtZNRsqO45zohwPL0b1+nsf9abTmup7HN2nBTu2E3JQOE0uxqKwMd6qzJk0h2fMi2ElbztTw4YZScw/u9vrKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111736; c=relaxed/simple;
	bh=MU6UkYJd15MzmE33QPubF7kQAJrIzbW7+X+SMYa79gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LUP7SPRQUDxl4tb5OCrFWBn8+x9w4fp7snLyyipSZP0p9VhMMxVS7F5givsGJdYjpG4Ysc3Ae5R3gTzCGkdxcpcvB9Tq6BbNuLOgJGNWM+aNGF/Q/dB7PShPYfgN2hIv/0dr4vygDivZaCyA8SOw+U1xY5iMe02izpgg4PsZqfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zsknQ0nH; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv38JYP8DXLPPVuZcpPAruESI1RlJA6EtSN3+004htg8tg3YWeL9tnFOdrhC0zVhg0fn30FZcHBOOov67fEmsQaKOOghK7cmtLDWMHws97kB6TAqoaQyg691VSjP7mOOBgZ/122wwisSqJdxXSMzBmv56TP2ZKEhNSUS+XSlRRYar605pre5YySpq0YTsUri8vP5IIGjm3lJfTBVuam0zo+QxavQQGgE2VRh1uYQ+98gzkGm+pfG9i7CKOes1z9PTLtYWpgKW3ZK1kmM7ypWA73DDLCUNuiMN9p16PnvvObJBMkpmf9eZ9xOz5Dsj0+mX6PGza7quLzJ7lkzEpUz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rM/Hzv/lC1f7EJz6vxkLvBobJHBLwXKRpe87hYyw2s=;
 b=n1fiOtRduJob5fVpJUWgVfXNtx4q1lQQOpn2vz+JCW7TCnpAyp9B1OO0VbWhQaHt+bySdOQPqoa70ugJpjMRzeDMqBULD/bZgvhgT3GehRz1PrDfWC3SkBs0RT4Iad74DfsjySl7rSqEEnIiwYz2gycMHMuHMXxPbTrnoufgXBLHAhV7YnIXBaAYG9F9L8VNotryF3s6dlMENveoY5VDqt6ucAQP9Pcv3JsNJrnqgB3lLhQcKormCQ5oXmxo77nRQNpA+fXI09QQXlIFUw4ZdVM1wq6z6mv7QSTYBHJOmuAbpm0LIHN9ZyuffuAZA+X3JU1hN81c9rwn98QVZkxVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rM/Hzv/lC1f7EJz6vxkLvBobJHBLwXKRpe87hYyw2s=;
 b=zsknQ0nHmUct6oPnYd0w0JbELlJAYNnywaRBVPV9UQKy1EtUhC6kFCmXF0Hubh3iIgFavE8ujQFJvKggdXykBWnXGX02BAVtutVhdkCkdeKl+IYbTLghuOYuezl6KSJbdVRW7t55VKgfik6KCBreMTbP/2iRlEbIK+JyHBQL+M8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 17:15:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 17:15:32 +0000
Message-ID: <ea2232b7-fb29-429b-af9d-af43a2c0cacb@amd.com>
Date: Mon, 23 Sep 2024 12:15:30 -0500
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
 <358ca905-ae53-4d2d-b09a-8e708d6fadd8@amd.com>
 <CAGwozwGsyebGE78SKMckkm2=8uqDTX+S-Jnxrn61X_UHVEDcDA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwGsyebGE78SKMckkm2=8uqDTX+S-Jnxrn61X_UHVEDcDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1dd5b4-3545-466c-7ef9-08dcdbf354b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3RiOVIvZVRnMlhhc1d0M0V0QkRzU2FDV0xabGdRbHBsUjBwdG84RTBDTGNX?=
 =?utf-8?B?MGhxWnh4dnIyRVZqRlE1Y1hEajRLT2RLaGZ1WUpxN0ZLWjQ3K1JkT2FhOXk2?=
 =?utf-8?B?MjNKSTJ0TUpoaUZMM3pSQm91cUNhZW9tcXEydWR2UEg4V2pjYTFWaEM5OFA5?=
 =?utf-8?B?ZTdsbjk4SGNta0d5OXBQWDFZV2F6WUZVY004UE42ZjB0SFdyUjFwall4Z3cz?=
 =?utf-8?B?L3BWRzllMFRNN3VDa1dvL2hram1LQS9nOUdVdkZsM1pxODdEbzltOU1ueUZo?=
 =?utf-8?B?SHEza1Z0bzVCdnRKaVlXV3VZUGlvdUF1UHlaOVEvQzVoZVpCZXRXc2NvclFv?=
 =?utf-8?B?ajNaYXhRRnpYSldaekNxWS9LYlJaL3VsSFhkVTlmVFh6eUk0SXRQSi92eXZR?=
 =?utf-8?B?cGc1VTVJTXZXaVJWNUNOa2RuQk0wcmV6cTQ4N1lFZTFaOTdWeGVIY1M3ZmNi?=
 =?utf-8?B?dzNBV1JoYXhhbGY5bDFVZU9WZkFMTnFPdHgrWlhrTi9TbjhSb2M0OFNEdTNG?=
 =?utf-8?B?UCtHTkZrV1o5ZkxEaThMcEY5MXZWTEFSWEpiMHJ0QmFvRW5GRVBiTCtMOWty?=
 =?utf-8?B?SnU0Q0tQTW5DMlV0VnVkRStzSlE3TWhZMUoyaFZmcDhuVk5TcHNPUFRQUHY3?=
 =?utf-8?B?Y3BleHZwRGNDdGppTUl1WlFXb3VmOU5vWEVDTlJHbmZoWXR1Z3FoY3ZWTHgx?=
 =?utf-8?B?L2orTzg4cnlhK0puS2wxalprL3MxT1JpWThWSFIwUU52NVVpelBqdmpKaWhT?=
 =?utf-8?B?eVd2V1NMQnhESWtRWDRoR25iSmJRUitNVTZmZ2J4Ly9ZdkhMVnptczVFdHJV?=
 =?utf-8?B?WVZaa3pLRmxVc2hTTEpnME1aYmhuQ0hNZ2lWNDhCVlA1ek5NVFZTV1NtcmNU?=
 =?utf-8?B?dEZqcXBJbmZRZ1pXZWVTdHgzS1F3Zzg5STNtOC9MUzNIdXh1TWhsVmltUWN6?=
 =?utf-8?B?ZzRSZjZRMkhTbDFWS0FEN3FnN2M1NnFLNmV3N0lmdHpQL0c5SlVSSHFiN2Qv?=
 =?utf-8?B?M1AvKzNKRGRiSzVHOUFET2t2UUtZUjlURS9CQ0FSdTJsWXZnU3RLeHFpSk1o?=
 =?utf-8?B?V2Jvdy9qcDNnOE9ZanhkZXFYQ2tUOE8xQW0zemFuV3BBL01WMko5QVBSV1ZX?=
 =?utf-8?B?ZjV4d1l6YWpoWDhNc0JEZDY0ZDdsU1BKSVEreElNZ0RRNVBWMlJoS3FlcnpD?=
 =?utf-8?B?MGFwR1hxbXRYeVUrYjE1akcrOTczRmxNK2xlRXllNXViNmVQNnFGQWhJUXA2?=
 =?utf-8?B?Tm5oNEtXaHZlZWg2L1lRM0wzVXJ6U0lsM0gxTnR0aVcwK3FYNndUZkEyTDd2?=
 =?utf-8?B?NmpNU1JTbFpiSWtRaEsxbTFrN3JlbnQ5d2pPZ2VNRlVIVGZyN3V5MEZ2elZS?=
 =?utf-8?B?TlNWTFdtVzJwbWR5QzE3enN1ZDUrbnB3NzM5MWpPa2JTUHQvOWVCMG56K3d4?=
 =?utf-8?B?MzNMTHJIK0E5MnlVZnl2NHhLWUZzWE5ZYlVLeDNBQy9VL285anlpenM2NWp3?=
 =?utf-8?B?QkZ1ZEU5c2JIRGlNUUZNTmMzZkxISCt5WGwrU0phZzhHalVUYzA3R2JtaDc1?=
 =?utf-8?B?clhhTmlBRnJPOVk0Z3Z0bkhGT2pJOUNYUzhjY1kvMXlkelZEM1BVYis0RFFM?=
 =?utf-8?B?SGFZbE42VDlkQkdkcE4rWVBWdmtRZUl3N2NWM1l4SnVUYUdVM2t2cW5RYzlC?=
 =?utf-8?B?dVcvSTNzN3RRdktveHZKZDFtWEJCSWV3dHB1YUpEQTFISmMzZTg2cm13PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NytoM0lCVmxDSXlXdmdiWG1iUU84QzQ2TkdFWnBaVEdLV2FFN1Jka0lNOHBM?=
 =?utf-8?B?RTFvZlg4QlFkYzhGMjVZVURlN2R0dk9QYUl3amdpSmlDdVd6T3J2OVRvRzNo?=
 =?utf-8?B?cDVKOVY1VFgvbDhwcjN1MDdTdVNxN2V0Y21Va0dhakdGUlZtdjd1RjM2d2VY?=
 =?utf-8?B?bERYMk1VdXZaSVg0YlNPZFRFamlOVjgzTjNsb2dpcDBCdEQ1WmZwcmlXa0tF?=
 =?utf-8?B?ZytSM0VCWTZPbHdYMG5YQVRucUpxSlplSk5DZE5uWUVXLzFTMXROQ3E4cW5J?=
 =?utf-8?B?ZnpPUkt0Q1ZOM3o5bk9ZRjR0YUwvOXN5TE5ROCtzUmFmMVV5d3loN09sUnNq?=
 =?utf-8?B?NHdDSGxzWFYwU1ZOSEUzVmRRckJwTXN4WmpBbVR1Y3VSNkZiL1lTbFN3bnNa?=
 =?utf-8?B?VmJBMWFSZTJUS1hTVjJocUptQVEwNFN0WjdtWGlEemVLYVg0OWlmMEZ0MUJ4?=
 =?utf-8?B?VUlKYVp3QmM4WmxXbGdlZ0pmMmFJTHV1WEdHcmxPTzYzZ0JPYVRFTWNQcEcr?=
 =?utf-8?B?akUwSkFnQk9KZ0JwK0UyM3V5amo5RHdlUWlYWmNLSzY3N1NlNUxCbkhEa2V6?=
 =?utf-8?B?RWtSQXgrUzJwOHhEa0dPUEViVlpkRE9mTnJMRFR0NUd5K2pYTlFtbmI5c1Fz?=
 =?utf-8?B?TlJNeVdreW9nQ2JwbWFVaElMMG5GK0hDSDlQc1A3YUl2ZTRQc3BUaGlIOG4v?=
 =?utf-8?B?cHlacXNYbmtCMVBZY2lIVlVtRUNQSkpOZW5FNzJCQkduSEhndUVQTHJnbDE1?=
 =?utf-8?B?L3dPNzBpR3RnUnpwM2ZPbS9nUjRseWhGeEZUQytKV1prYzhGWGgvS0hiUnRw?=
 =?utf-8?B?MnAybDdWMC9rYWF1YkM1WHd2YUxQdWlUYWZMbzY2elMvUmZpUmxhZ0ZsUnoy?=
 =?utf-8?B?RmYvSWk3OFc1ZGtBZlAyWHVCaWQ0Q0ZMaGJQNXFEeTYvK0dNazBEcFFITFZV?=
 =?utf-8?B?STBHMTh5bERBdzRKT0Q0djl3OGVJdzlmb24xWTc4ZHk5VnFaeXJpTk45OWc4?=
 =?utf-8?B?VTNkK0VaTnJMYXpBRjJ1Yk9nazVIZ1VRbERMNjlHMkpKdjNTZ3B5QlRqR2RQ?=
 =?utf-8?B?cmtMK3hXWE92czRvQlhJb09sVmZYMkQzdGhnYXcrckY5ODZaSWF3bnlmcHBE?=
 =?utf-8?B?elBXUjJGNlQzTVRBbi90bitMc2RmWU1PSFZGTFRjZ0h2NzNURGNLNUJFSVph?=
 =?utf-8?B?NTBnRms5Q3NSc3haWEtEODlzajJXanB3TEwxWXR1UmhqNk9EanZ5SUY4MkdI?=
 =?utf-8?B?OFRaVmhJT2c5MjZ5OWYwNktEajRjSmEyVUk0amNKbWZ4eVlCY3hrNlpQZlZi?=
 =?utf-8?B?UjRWY1BTcTBvZ3lvMnB1cnlvRjNsZmU1SEJka0JZcFhKQWM2UmRZN2RMcGRY?=
 =?utf-8?B?RXBBcGxkblhLVjZRLy9XQjNTQy9tT05pbEZnUldnZGVrQmNVMUFITTNsUkVE?=
 =?utf-8?B?aXV3Q25XNGVRZEw3SGxJMFR6akQ1bk9jaW5qRlh1eVo2OHk3MUNOMzVScWZ2?=
 =?utf-8?B?U1ZFb2RlcGNVZHZ4VnpJa0x2T003dEJFQSt5bVROb1NyNHZEeXJEcmkxMHlN?=
 =?utf-8?B?U25VYTVGS0szMHZSbVlJbTFxVWpHbysyejlEYjl3bmE0NnlRUzRkSkljQ2VQ?=
 =?utf-8?B?aUMybXBHZU1Hb1phRElESkFXdFA0YllIU3E0SW5mVHlpc3o0NUJxVnBVOEsy?=
 =?utf-8?B?ZDVhRWMwRkwwVmFHWDZvY3QvRmVBclJWSHpLWXdBZUpHK2oydVVPS25VaWxP?=
 =?utf-8?B?TXF6Y1E0N0R2UkpOSmZvZHllWExvanFZRTJORitzaWJvcFNuZUYxcU5yTjMz?=
 =?utf-8?B?Z2szdnl0M2VkWlVoY3Y1R0h6NTR2dmlEU1MvYzZkZFZKaVFXUmJTZm9Tcmww?=
 =?utf-8?B?OUd4bzk5RFEyNHNnZVdOVzBIeldCVVllN2tFbmcvS1VQRHhyaWlYa2pKZHZE?=
 =?utf-8?B?eDBMeVBlVW1GWWpHNzFYTmV1Mi8vQnVVUDhERFhWTVdvSlBsdmpLRVpQTW9N?=
 =?utf-8?B?VVdtZ2NqUEpTSWRsK1dlZDNoTFBORHNwNWJQTXl6VEI0ME5zclZFZWJtV2Fw?=
 =?utf-8?B?TFZ2SlFZTzVSY0lWcWlrMnRwUUdHNG1GdHZwTUlsMGxtdldBc0hVeE4zeU9t?=
 =?utf-8?Q?HUEqrThHmZMuupofxPxl40KeT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1dd5b4-3545-466c-7ef9-08dcdbf354b2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:15:32.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6Flaw0T7XfqSd4WkuAdELvMGKyKXEwJC3h741ECGWMbKxJ/08XBlhE9NSIwy6SvAEw0haiLCAKGf8cJTWzKyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901

On 9/23/2024 11:54, Antheas Kapenekakis wrote:

>> I hope that more of these handhelds with MCUs that get regular updates
>> make the same investment.
> 
> I do not think every manufacturer creates a HID spec for updates. They
> use the same cookiecutter stuff, for which there is no linux
> implementation at all, so kind of the same. Probably after we do 1-3,
> we will have all of them.

Actually there are already about a dozen implementations for HID 
protocols in fwupd.  I've written a few myself, Richard has written way 
more than me, and there are even have vendors contributing to their own 
plugins now.

I do think that it's very likely that ASUS uses the same implementation 
on a lot of their devices, so yes if we get firmware updating figured 
out on one we'll probably have it for many more.

> 
> I saw that HID interface though, and the Legion Go has one and I am
> none the wiser.
> 
> I've been doing HID for over a year by now, so I am used to it.

Considering the previous experience, maybe you can help to document 
their update protocol?  I'm happy to collaborate on the fwupd side if 
you can help push it along.

> Biggest problem is you cannot trigger an update in Windows whenever
> you want to sniff it. At least on the Lenovo.
> 
> However, I think I have bigger fish to fry, so it is not high in my
> priority list.
> 

AFAICT any need for this series goes away when you have an easy way to 
update a handheld that is running Linux already.  I would take a pile of 
userspace code over kernel quirks any day.

