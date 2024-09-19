Return-Path: <linux-pm+bounces-14497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F1E97CE6B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 22:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8711C228C5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB74381B8;
	Thu, 19 Sep 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SQE2s05r"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A390EEC9;
	Thu, 19 Sep 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726777058; cv=fail; b=C735TYXZVFjR9YBY8zXEV1yx5DcaJgK/wq8HAy1yuf774cvr075N/rggLPKJMwXGP+8aQOB9M7l/996elVW9g28+NoDt+iJ50kH1wEvECmHnB0mdFLsjeewabtnhujHaED/8bo7ffmca2MNeS48d4rb+kAFPjQpa601Ly4+gHxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726777058; c=relaxed/simple;
	bh=2Hx/NMTgSo4735H/hV0JlH/Zc49jmUslMzGT+Fh3AKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dRzwRysVMadUQPjG9LQyrwlluP+rfZQB2SbPxnLZmyTffyrMhmzD0YWvVSoShOOjAVTYXBTPLG8AT2FtR16TKRQZPeAYKmJrXSMGVoac5uD1Z8trlbl1UsGonMHUOKrmg+T+0zWi9uwM3M5y1OLVOhjn4wDxoZfNOZQ6h+yCZrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SQE2s05r; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6bGRcbfPLXxPDGuOMGEYRx4HMXdAn1EU14R1z6diM7tMAPVM5/xncx47TwlOvj4hBCy2uTBItmYROpgJRu8aOblMRXSlABlVwTNZMHK18/z6vSlBDWsIzBn9xbS8jLUmfvysm84PKFazhQkUAfF5TF9ppiEWT7rGasa6rPdWCOebExa+mJ6sx5A1iNY05wCOd/zJHZ2dgBTpZ1FUCOEyWTA+QMk2ONvgFgbGF9/tgefmocOq0SRoe8oA2Zyi/Nh49FVGf7w8IIqUq4wkQbs6ceZK7plLHNXPSucmHZxJX5XroAVTkYUed6TifS2jwO1jT0nFDEWooDuH+YxPRZjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vozPWz+H9RggEYPwsUvzJg+mKmK1gamyLcbQGoxLvfA=;
 b=ZIzVLJb7vzIVGya2O9GZU3j+rdmPZYNREltX9PVryxsFiHgPowMbFtW4YbJwXPZ+/PQzURoZBVDA28jlfA/oJotn0wWeFNGWRM0nfngWr8sx9MmtN9dLKv6dkE1FwJeXywOa4DgU2EAGuoFHk231UnIuo1CCOQzgbK3+/VmAZ5/dLC2bPZxz8+tmnNN1LRDhlN8TVZ9tBgDUPUl3uj/CTrDdEUC74HfG8FP+WPnPCOkxOHld30iSjHyI7BhAEPUbnpri5BgqzdjQCMRc3KZbAY7bs+pLAze2c2mrsOv9pH71iCRbGxSclpqdM2fDg2h+mpmVsxQPPR+cVmUgmkk3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vozPWz+H9RggEYPwsUvzJg+mKmK1gamyLcbQGoxLvfA=;
 b=SQE2s05rs89ycUIRINJ11wB5xxmw+PQ2MIOvLqVjWNeaEwgjYzmVQhRRv4oXhN3KzEmehzVpv/ojOlNXKWeyLiWi7ziwhqYYgoVnlHp8nkpi2gLO43K3bV5dMjNPf0cxLDZT9X3WdGLvToEENqaHpsTQ7RwR0MEhiZELa/i6ICc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 20:17:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 20:17:33 +0000
Message-ID: <5ecb2665-a14d-4f93-9699-f82f93dea65d@amd.com>
Date: Thu, 19 Sep 2024 15:17:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] acpi/x86: s2idle: add support for screen off and
 screen on callbacks
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 luke@ljones.dev, me@kylegospodneti.ch
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-2-lkml@antheas.dev>
 <0f758a1a-958d-41d6-a572-cf544590450a@amd.com>
 <CAGwozwEquttfbzat4ZQbQ3h_7Gi2QZ7qDBr=QgaZBU0MejEQ6Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwEquttfbzat4ZQbQ3h_7Gi2QZ7qDBr=QgaZBU0MejEQ6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0053.namprd12.prod.outlook.com
 (2603:10b6:802:20::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 12191eae-9dad-4fce-baa3-08dcd8e818a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkNZVUM2SjhNV2dxQkRJcUUxUStSZ0NnT3h3M29CcERXQjk3VmJPbDQrOGNn?=
 =?utf-8?B?MjY3cndveWNZQ3owbTB3Nk5uZTRTeUZDZXFmVWd0WXNBdmpHZE1tUnpjbzNW?=
 =?utf-8?B?Nm9ldHdneFlGN3M5cTJWdHpCcW5DK2JEVS9ySjdES1pkclFWaGJjWFNGbytm?=
 =?utf-8?B?dUw0Uk5BYWxBa3JiRDh2aE54R0svRXMrQWNycUpxYlZjSWtTNG9KTHgrUkg1?=
 =?utf-8?B?eWY0bE9LNTl0NnpHenJzMnVULzNsbllvWTExU1J1L0x0RHFjMmxrdEpUSlV2?=
 =?utf-8?B?cVVIVENMMFg2UHpYakI0WGRpZUl1V1Y2OGk0QkFqZ1pxZGRHZW9XaWdrazBH?=
 =?utf-8?B?WUVSVTY1Q2xXR1F6QjdtcDIvTm9KbThLdk5RcW1TazhKSVpwbnJsV1BwNE9I?=
 =?utf-8?B?ZzVMd0cvZk9CL0RkbUZjSndwZWxPNnhKVWM0MUdNZWh3cTZXenZ5L2F5UVBy?=
 =?utf-8?B?MmhCczc4VVloc21DMnY2RVUrcmVld2ZTTDFyNTVrMU1pUUFJUURKbS9QSEhV?=
 =?utf-8?B?eGxxMDc0WVl4VktRcU5QN1dMZE1palA2bVphWTJJR1NHT05CK3dCb3JTTUM4?=
 =?utf-8?B?ZjN0VGtXT3l3NjZYV0syUGdzM1hoMC9NZ2JZWEdKTDRGanpMdmhsTVVKVkE1?=
 =?utf-8?B?QzJ2THJIb1NCckJyWFRhd2RyOUR0VnBWUEJnNGpoMnJKZFVvUGt6VTlIQTZ3?=
 =?utf-8?B?cWw2WFA0TlQxVHBsSlUzOW1idGYyU3l6VDRJN1Eva3dyTTNZSVVZQUVYSjh2?=
 =?utf-8?B?NTFjdm9zelNlSW1zTFNLRU5vdGJ1MDJoNVZuN1Z2WXNTdkVxaVNDTlptazkr?=
 =?utf-8?B?bHhhMWJIR1FzYmFsSS83a3YvNkNhVjNZVk0xMyt1a1hJYjF1ZFlsK0trVjJq?=
 =?utf-8?B?bkp6MkV3VGJaZk5zUHRBQlZlY1F6cU43enk1ZkZUcXFTSnoyWmIycnhidzJD?=
 =?utf-8?B?NHd6Mi9sNk11ckdBWkdIVkRobm0xclNvV2ZzTmZSODQ5VVhiVm54Q3hhZVFz?=
 =?utf-8?B?aFZWSjRzQnErUjJJM3A2MlViUlZ0dC9KS0t2cWhhdlE4bVZua0FsaDVyMUdT?=
 =?utf-8?B?c1cwWnZtYWVQSUh4RDc3dFRQdEx0NGdzYjZPY3pQYW1kdmFHc3JYYUpNYXR0?=
 =?utf-8?B?Qm1WYjFxQmVwNmFjUkExRm9td1hVckhCcklITzV6ZkNydFNqMnBZdjdvUWRI?=
 =?utf-8?B?Z0VuZ3BEa3YxM212OTZPb04xcnNYNmlZY1Z0Tm03N0E2S2piMDJMdXRxMzdt?=
 =?utf-8?B?cHJFNEJyWjdvb0VvQWRJaDZmTW5ob1BYMXY2UGdlQWhIU3JNcE9ZeFdJN25G?=
 =?utf-8?B?MjkyYUp0MEt0RmIvNzZDK0hiQUZxUnNlYmg1SDRjaHJHSm0rUTdpbnVWcFZR?=
 =?utf-8?B?c1Jkd3VlZHJyYm1EenJ1SE1xVnNiNVZDV3ppM1FOenR4Nkc1bldrelJtLzNV?=
 =?utf-8?B?OXZUZ3pBU3Nxc3ZzMGU5U0I3cm9KUGU5WEt0S1RRN2cwWjdvSTdBanZ6a0Fn?=
 =?utf-8?B?V0xLd1pWS0IrQ0FhWUNRVnNsTDBDak1rc25sRXZkdVVRME4zNWU5YTFCOEs5?=
 =?utf-8?B?OVVBUTI1QmkvenJGZjZlVUZ2dWd4L080RktENjlucG9MLzR4djJhTUR2b2V3?=
 =?utf-8?B?ekd0UXhxRTFiNTJxbmd1ZWJ5V1lKcGFzckMyNUhYcGpxRFEvNGxTM0VNc1Rw?=
 =?utf-8?B?Mk0yWjJwNkxFUnBXWmV6eWdnajFhSUV6QSsyR0dmZkhBeTNoRlFCclpuZmV2?=
 =?utf-8?B?N3NxcVBJQkZvenpXVWd2dUF6SVgxc2ppYjNwcElaNkxvV1BFRXFYa01VR1ZP?=
 =?utf-8?Q?t7hdPynSVZDOTQOVQiTRwbggn7iBMNFASDLfk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGtSc0prWUJhR013aFBRY21Ibm5OeURYL2Q4d1R4aFp3aG83VXdYbFdXR0Fm?=
 =?utf-8?B?NFpaMjNqa2lBY3hMaUxzRlRaUStVdDZ6UitITzZ1ZWJ3VVRUbXFhVjA1UkRr?=
 =?utf-8?B?cnloblRjckRCV0RHK2QxZHlNVjVaQS9yL0YwYWpHSTd5TVN1UUE1bStZd05i?=
 =?utf-8?B?VkFjTjJ6cVZoVUpCWEJ4NElhS3lhSUo3c1VQaHdVMnREb2cybzhKZXc0bkJz?=
 =?utf-8?B?N3V3MlVzYll2ejZDekJKRXBJNnNTaXk3U2UxMElJS05ZUFd6R3RCdkVjWXV2?=
 =?utf-8?B?RG1WQVgzWFZ2NDJuSWNrWU03alBDalBZYWU5MUcvalNOQ2ZyQ09BZVlYU1Z0?=
 =?utf-8?B?aGM3T3hsSW8wQ2NnQ2VoaFd5VzJIM0FiMVVqQjQwRVNBMTYwaVM0UkxrV1JS?=
 =?utf-8?B?Q25oejR6cGg1QjZ6azhPMFRwU2ZsVmcyZVNTbWIwRnNHV3dIZGtVUEpCZFZn?=
 =?utf-8?B?UVJGUmpDaWZnd1EzZjdMWm1HN0N4NlVnUnFVMEQwMnI0N1pqN3AxZDlFcS9K?=
 =?utf-8?B?SDBpRHU2dDJidTF5dnJkRWRQYnVPR1RpWDhYZjBMQWhaN2ZRdWt1U291RHQ0?=
 =?utf-8?B?cjQxRERObk9FbTE1WmNFK0ZBMC9mSGhTMldBNmJkN1hwdllKUkhhNi9rWk9x?=
 =?utf-8?B?dFUvd3czUnBwcC80S0dXek5ueXQyQmNIVXRhbTlBNVZNOWp1Wlg2QzZzbmhG?=
 =?utf-8?B?akp2UFowejRaalVZcTgwNDFoSjJkLzBnU1JGTHUrSEJxVlhKY2RQL2FKdXF2?=
 =?utf-8?B?QXdpdmJPZG5TbElLK2owUTRhNk5LVURLdVlQN0hLRHhJVHJJVVY2aU1lcUdX?=
 =?utf-8?B?bGhpUit1QkZVUDM3ZFdZUytiQW1qSlZ4dWxDcGJPZUorL0lJVTdIb1B1SXhD?=
 =?utf-8?B?RCtDcGpKK3NDMXUvRjRDdi9FNTJKazR3K1dPa3NkeVo0aXZCRGJHTnM1a1RT?=
 =?utf-8?B?dWE2Vm1UQjZJdDc3M09lZmZCQUhHVVRDb1JZdGhlRFlBYTRxSExoL2R2Q0hS?=
 =?utf-8?B?NVovdDhNMElIN08rdnR3Ukk2Zy8vZzIzb1JxeUVMczh3R01Ud1pTdHpVd0FG?=
 =?utf-8?B?OVpuenRHcjd3MllmZUM0Z0FtMlkyUDJoVXVBWkM5K1ZMb2dIVkszV1lVZ2F0?=
 =?utf-8?B?cXFROHJ0OVJnSFlERUI5SzJwc1ZlQWhBUGhoWFlIV3I1dGh3YnJxVXd6ZHRU?=
 =?utf-8?B?T2JnQ29qZXB6dUFOdTBjNXpSa2N0dU9XSU1lREdYdWhWeHdieXZ6aEcrQmd0?=
 =?utf-8?B?VEhWMlZSQWQ2NDcyU210QUVXZHM1R2tCZmRsL1NkQjlRYk5VOXRaWEMweS9w?=
 =?utf-8?B?WXgvTGVHVkV1VVNYRVV3dkJBWHJiVnJ0MWlvYTVGc0ZWYmluSDl5ZFowbGVC?=
 =?utf-8?B?MVJJdVNnZGFzQkNPUHIvcmtXVGtQOVNSaEVpbEVYcWtweEVqd3FyakNLRDAz?=
 =?utf-8?B?UFJzUkx0SnBPSm12NHhhNlFBWkZZT2VTWXpNY3pUM1NxRm1SeGUrTlp4dHJl?=
 =?utf-8?B?WjZhaXJ1bHZXeitTUmlVSW4rMFBYMHNpdkRUR2JoU0NIYng1OStsVDZNbXRm?=
 =?utf-8?B?SFd6M3BDRTNZM0hYVVIwcUdKN1FkTktIME82QTRqQkxHRnYyaXgwM1cxdXMx?=
 =?utf-8?B?Q2VKc2VEaE4ybU92cytacmYram9CcC9YRmh1M055c1YrMk5lbWhZWmZoVGsr?=
 =?utf-8?B?SkgyZlN0dnRHYVNab3JEZE8xRUl3cXIrbk9wOExFZlo3d2NoU1N6cUlDYTBo?=
 =?utf-8?B?REZ4aUx0UFY2bXM4U0Jrd09JeXZVcFNGaEVhWVE1bVQ3M1BBdjJQYk83WmNP?=
 =?utf-8?B?NjVOelo0WG9LeHNPU0h0ZmZ6aEJsSHlOU0RwUTQ3NEpRNC92dyt3anMycDZZ?=
 =?utf-8?B?SlBDRU1rUEttUGxoVEFJdkJxOG5lckx2Wnp6dGJidG9Da0UzWm1sV2JpbnMw?=
 =?utf-8?B?UzNKbFk1ZzFteXcxY1kwbEEzNDVKOGRHbDZiSDE0c2V6TWR6S1pNN0ovV2Rl?=
 =?utf-8?B?NE9rQ2NIZ1dOWG5pM1NsdVcrTDU1OVlHSlo2ZE9TL2JTRnNOZkpFcFNGZzZQ?=
 =?utf-8?B?WXBDelFhU0VCT2liZkpCQ1dERCs0NUxNNi9BT1VwVXQxMm05RU5mbXdnZGRN?=
 =?utf-8?Q?v0xI2wE951pPid9wTUaQNZcVJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12191eae-9dad-4fce-baa3-08dcd8e818a4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 20:17:33.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6HqOWQqKpYvnry7z3bTM/BQa9zPvw5y7+mA+9UAX1MysaTqQijLTrdNMI3roRWj/t9OA0QQxQrvqMPKRLbHzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374

On 9/19/2024 12:36, Antheas Kapenekakis wrote:
> As stated in the cover letter, I would like to add you as a co-author.
> Just did not (could not?) do it before asking.
> 
> I will do it on the next revision. Just tell me which patches you think
> it should be on.

Patch 1 and 3.

Thanks,

> 
> (hit reply instead of reply all by mistake, so you have this email twice now)
> 
> Best,
> Antheas
> 
> On Thu, 19 Sept 2024 at 19:29, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 9/19/2024 12:19, Antheas Kapenekakis wrote:
>>> The screen off and screen on firmware functions are meant to signify
>>> the system entering a state where the user is not actively interacting
>>> with it (i.e., in Windows this state is called "Screen Off" and the
>>> system enters it once it turns the screen off e.g., due to inactivity).
>>>
>>> In this state, the kernel and userspace are fully active, and the user
>>> might still be interacting with the system somehow (such as with
>>> listening to music or having a hotspot). Userspace is supposed to
>>> minimize non-essential activities, but this is not required.
>>> In addition, there is no requirement of suspending post the screen off
>>> call. If the user interacts with the system, the kernel should call
>>> screen on and resume normal operation.
>>>
>>> This patch adds a set of callbacks to allow calling the screen on/off
>>> callbacks outside of the suspend/resume path. It is based on
>>> Mario Limonciello's patch on the superm1/dsm-screen-on-off branch.
>>
>> Based on?  It's nearly an identical patch [1].  The screen_off/screen_on
>> lines in struct platform_s2idle_ops are just placed in a different location.
>>
>> IMO there should be more attribution here, either a Co-developed-by tag
>> or sending my patch directly and adding your S-o-b to it.
>>
>> Link:
>> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=superm1/dsm-screen-on-off&id=7b80581428315f973410dccf0402a86266fb0d9a
>> [1]
>>
>>> However, the intent here is completely different.
>>>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    include/linux/suspend.h |  5 +++++
>>>    kernel/power/suspend.c  | 12 ++++++++++++
>>>    2 files changed, 17 insertions(+)
>>>
>>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>>> index da6ebca3ff77..96ceaad07839 100644
>>> --- a/include/linux/suspend.h
>>> +++ b/include/linux/suspend.h
>>> @@ -132,6 +132,7 @@ struct platform_suspend_ops {
>>>    };
>>>
>>>    struct platform_s2idle_ops {
>>> +     int (*screen_off)(void);
>>>        int (*begin)(void);
>>>        int (*prepare)(void);
>>>        int (*prepare_late)(void);
>>> @@ -140,6 +141,7 @@ struct platform_s2idle_ops {
>>>        void (*restore_early)(void);
>>>        void (*restore)(void);
>>>        void (*end)(void);
>>> +     int (*screen_on)(void);
>>>    };
>>>
>>>    #ifdef CONFIG_SUSPEND
>>> @@ -160,6 +162,9 @@ extern unsigned int pm_suspend_global_flags;
>>>    #define PM_SUSPEND_FLAG_FW_RESUME   BIT(1)
>>>    #define PM_SUSPEND_FLAG_NO_PLATFORM BIT(2)
>>>
>>> +int platform_suspend_screen_off(void);
>>> +int platform_suspend_screen_on(void);
>>> +
>>>    static inline void pm_suspend_clear_flags(void)
>>>    {
>>>        pm_suspend_global_flags = 0;
>>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>>> index 09f8397bae15..19734b297527 100644
>>> --- a/kernel/power/suspend.c
>>> +++ b/kernel/power/suspend.c
>>> @@ -254,6 +254,18 @@ static bool sleep_state_supported(suspend_state_t state)
>>>               (valid_state(state) && !cxl_mem_active());
>>>    }
>>>
>>> +int platform_suspend_screen_off(void)
>>> +{
>>> +     return s2idle_ops && s2idle_ops->screen_off ? s2idle_ops->screen_off() : 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(platform_suspend_screen_off);
>>> +
>>> +int platform_suspend_screen_on(void)
>>> +{
>>> +     return s2idle_ops && s2idle_ops->screen_on ? s2idle_ops->screen_on() : 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(platform_suspend_screen_on);
>>> +
>>>    static int platform_suspend_prepare(suspend_state_t state)
>>>    {
>>>        return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare ?
>>


