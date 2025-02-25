Return-Path: <linux-pm+bounces-22864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78805A43421
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 05:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04791884679
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBC186E54;
	Tue, 25 Feb 2025 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w+ZTAe8b"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74779156677;
	Tue, 25 Feb 2025 04:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457736; cv=fail; b=aiQdtlHm4PpGOexCPJ2hndX5IBDJ9QqT8FG4NrgFsFiXC04jVDspZd0KFMN50VFc/6j/UQNE7PgvsTcK5UAHgWO+9xL8wxzIwS8/eF03gmkSJgRBcDImBDtF8uqXEAm0buz0KwSjWeiYpq1eyQ3K1iRyx4DmES76QKOkErSqwYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457736; c=relaxed/simple;
	bh=vBvzVIbc/22iAPL6SbtL1Wb9yxobmkjBRp3WVNSRgN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VL08l+NqQENGX4iSYnhEJ3AW5IhP9Yeikf+7998iLQbrp5FrtM8Ik6LLafWWJ6VvZH0qw13wsB9n1bywjqjyT15c1bi5sCInbscSx6pTC3lRLhMnzpZhS5eGf6s1t5/Q08iQTQ7qEEyqT5Ve9HaKX1DRyxabal12bIzuJXelSNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w+ZTAe8b; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xvz0qHpHvtGUw/I00A+3+gDdXdaHdw/Oc/+Lb0lDsteUVxMVahmuCY1gCNSgyZAOXM/FKZBBKFPCwW9GE+mIxDwxFpjqNJmFH9SB4WWFMaVXFWSotJ8Xd6XNpaDK3OZ8js6qGLpK3XVgGNvYZmq96XMhdFhrfojxZ7u213k3JljaX7IqhnBp6mrgOIHe+XMSrKb7ckTE3SZJ2pPGVLqDwxXQuhGgWXnYV464gm+/9SgkhhGPQu82vaTGE9GkH4jYqTOTzjLgG0jBgDt3FGfTgmn1k/fD9d9iZ6pMj7TfFvgphMxwxjndyFIGwXfhyXf8/blTezakpjchNJc8HgATTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yZGAWeujO8hlouvJrJqcIUa6Dn+Q6bzWcVygBtA0ZM=;
 b=MFd3YOgX2zZnWQVW8pynXo8xFJb/BAs1qcAhqklnBJwDwmhil6ACNhHQ+484Zxv8lJZTD+NfMV45D4l8n0glJn9pygQtGe0m8p/CCkeDZl4+A0gIwqBUPDPSSi8J4+14EIM94T40vzQRgByAsDOYb7PilsCC/URRyYzw0E8Nei4/qIJISIE5k8W7uATHIIvJ7NEO3pyhOyXL+L9SCixmNL4euSyItDRXcekuxbbYsY+CHTjLcuczHOaoRbd5K4GWcq5ftY3ckZcFH3BkCWVofSn+6tsZ2GW51jk+v/SqQR4/dWrWPjp+Wu55kziCbzNoAKLk+WKTeE3zu2EBX4YamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yZGAWeujO8hlouvJrJqcIUa6Dn+Q6bzWcVygBtA0ZM=;
 b=w+ZTAe8blBOoZWlgIkA2K+HLJiYvgF4unMZrmONqtgRPLSjDWeiSn5MVH8imZ2LYmFE9Rvq3QqOOxMELCOqy6Pqz0XxtrPt4xo41+/nE+rZGJg9ogBM3GiCDrxD7G5DkzGyuRMdBMo8dK8duarwBIaouHQlFiCaHbRO13A/BovQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 04:28:50 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Tue, 25 Feb 2025
 04:28:50 +0000
Message-ID: <556c0bc3-2c52-4464-997c-4ac40b62fafa@amd.com>
Date: Tue, 25 Feb 2025 09:58:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] cpufreq/amd-pstate: Move perf values into a
 union
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-5-superm1@kernel.org>
 <ccac287d-5bde-4b0d-a1d6-b1e8b5f4e6cb@amd.com>
 <9db9da8f-859d-4e23-94ca-e14905c8c6c7@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <9db9da8f-859d-4e23-94ca-e14905c8c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a12695-7448-4457-6eef-08dd5554e73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dSs1M3hMeG1idFJOL1dDci8vL2hvZlNWRjh6RncxMm5tVk5Oam5WVWRpRWdJ?=
 =?utf-8?B?QlRyemVXa0UvQno3TXRiT1NBd1VNQUVoenJER005Y0w0R2ZBNm5YV2o4Zysz?=
 =?utf-8?B?R3lHQWxzYVk1dkxjOUtNbzE4aFNPMnliV2tnTWptRWRPbmhINUgveEFkWkNP?=
 =?utf-8?B?a2p3ZU92QnRNeU1mTjc0WnE2S3BPaGh3enlUV1lhZlVmajRXWDI4eWFXRTMz?=
 =?utf-8?B?bHhacHBydFovRmJrRXpkeGdzNGZwUkxZNG0yU0hKWXNlbVJBOTFvSjE3Uk4r?=
 =?utf-8?B?cnBReFZBY1FiWXNDaGw1MGVxY25vc25ZWkp2Z3ZNNDZpYUthYmM2QlpLNFRI?=
 =?utf-8?B?MS9qTE5JZWZlbG8yQW43ZGJEbVlCQ3cyQXFMMjVXUXNVd015WTBOY3JGUUcz?=
 =?utf-8?B?eFNVZ3Z4NGc3V1pvOUJzM1U0YTc0TzRhZTd3dW5EeXQxRlEwd0FyeS9icEZQ?=
 =?utf-8?B?SFhYV21FVElOUWRCNjB6M2x4OW5HdmVnTGhSVzFWQ2M0KzFDNU8xcUlHRERU?=
 =?utf-8?B?d1JKQi81MmxTd2h6bUp3YXIyODVMRVdacmVJUjRtQ0tCUjVyWjV5Ynkrdnh4?=
 =?utf-8?B?YnlDQU5xM1Q0TlZFR3hodDI3L3pTLzJrQlhyUWh1MzRHazZqVDNVK0NHcVpR?=
 =?utf-8?B?SWtiVkJvQTByOCtlM0l5TzkwdmF6MVdmTWthczR1Zm1NUDUvcWs4Nm5QeVB5?=
 =?utf-8?B?S0FSUnVUN1V0elBFVVBveXJBdGFXOXBhLzlNU1dxa1l3S3JjTy9kTFYrSmFX?=
 =?utf-8?B?d2dRQWk5ZEpTc204ZEwzNmhLZHV0ajFxSmVrOVlaTVBQaXpsRFdlSi9CSksx?=
 =?utf-8?B?OFlXZWVCbDhqN1FmenlsRTBKMFhHdVVEWGlYYUNib0xIc01xNUhVUVBnQzhP?=
 =?utf-8?B?UmxpSkg1YnFaZmJuQjZGajJ2T2VmZUhlQ3NDVVAwSHV6VVdIc2s2TVBydS9k?=
 =?utf-8?B?ODhQNEh0bnN4SERNcXBsbmNRVW1sZi9ITlFRZ3V3REY2QXhGZUE5RkVjSWFL?=
 =?utf-8?B?YXpUdEd0dkZ1NWIweFVHNWlZcHVtdVFtOXhxZTZ5dVlpVUdpUGxXeUFmS0xU?=
 =?utf-8?B?ZTQ2Uk96Tm1XS3pydWhySGxxSmxldmlsNWpnc05xdVpqS2JTcndFWmVQMkNE?=
 =?utf-8?B?OWZIN1FVdXdkakNud2ZlUlN3UU1Ld0lhbTFLdUNiMTNMMTYrWEdiTFNkNXJ5?=
 =?utf-8?B?SVhPNjNWc0RvTk9yV1pFd211VmFFc0hhUGEyRVNtU2RuUEx5UXQ0cXZ4MTVS?=
 =?utf-8?B?QTJhNWhXQ1VjclFnU01jM0lNcFBCeVAyK3VHT1RHa1hSZTMyQ0pvR20zUHZP?=
 =?utf-8?B?ZE1FTWl4S2p2MWdIcGcyTCtTSHpoS0lIOThQQ2ZzeURReHB0VjgweXpzNGlT?=
 =?utf-8?B?U04vSjBpNEZ6bUM2dlhLaUtWK0ZPaS9EaE50NFZubi9KK0c1TnVvTTlIY3hH?=
 =?utf-8?B?dFBXVFVBeEJWWDlGbGJlbEtadldvc3lSQzhYa3ZyZmp6UDVrb2NnK09uQ3RB?=
 =?utf-8?B?V1BnWGNFUEpReG54UVNQZEZGem8wR1lvYWVZNDdFeWlXbnVJaGNpSEsxaXFP?=
 =?utf-8?B?Z1BMN3c2cXYrSSthV2Q0Y2w4anMwYWZZZlpEemgxTjhpZ01Bd2ZkNkp3WE81?=
 =?utf-8?B?U0I1bGV6eVBhRjhqTHRFZnhzMzMxeUJ5V21Eb0twVEU4SmtVRzFwL2VUKy9v?=
 =?utf-8?B?OEtQcGxaTENZWnZQdmFzSlk0bnFGaW9TcU45RTJncjd0ZUtQeG9uaER6TVBT?=
 =?utf-8?B?bVArSEtPUUJ5NzlOdzR0Unhha1BGNWZybW5TSHE1NkJQaXBVNXVYbEZjODNi?=
 =?utf-8?B?N2F1K25PbXlJWmNuMEpoaU1lRUpac3NXV1dxZzVkN25CWWJPUzhtd1l6U0Zr?=
 =?utf-8?Q?IpDTEGAI5OF7z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0ZCRGFzQ3A3TFhidzBjVkl5SStIZ1o0TUJySTZWWjI3KzdiSXhSZjhjRkdJ?=
 =?utf-8?B?S2tWZjVZR3dybGtNR0RzVk1NanpIbllNRHVCSUVDb1Q5THB3SGFsV01WOFlV?=
 =?utf-8?B?eTVpcHgxSzVSVHRDYlJqemFkemUrWE5XSlBaUHYvYXBqVGQrUlRGL21WQ0xL?=
 =?utf-8?B?UWpLMXhIdmJ0a2JGVGwxWUQxYnpMVEtXWms1Q1lKWEZmYnlhVGhlRlpsNjVs?=
 =?utf-8?B?dVg5TDFZbC9KQ21PVGdxU1FlMk1ObHVsTytGa0dDR1VjQ3dveFJEMUlTOFov?=
 =?utf-8?B?K3I3S3RkMVNlOE5mVnNlVk5Qb0ZSNklsbFdPelc4RDk4VXpxL3p1SUNoT2RQ?=
 =?utf-8?B?Ym5FTXdCVkI3YkJZL3ZJY1FnMnlHNGVVZ1pCVjh0UUc2VWs5eHZSWUw5Vk5N?=
 =?utf-8?B?TGt6VnZCNXlZUXQ3YVl4cVJGdDhVMERqQ0ZtVGhhS0tOYkRmb1p1TWxyWjFB?=
 =?utf-8?B?SE1yNkNIclNyWjh2SEFPY0FNNy9kTW85T1lveUpJUnJsZ2gxUXhObGRuMVhy?=
 =?utf-8?B?bVRsUUZxNS9Gb1ovTS9VV09aVE14MXZiYzl3VzI5WDJQeXgzYVI4UWZET1V1?=
 =?utf-8?B?T3BzOFJDYi9nZi8vNWhyRTQxSGFqWEp4SVVQR2dMNVIzYVlab21iR0tHWXZh?=
 =?utf-8?B?OERVWXVEaFd1NGZJbWRZYjkvRDVmSHBia0d4TkN3TE8xSWx1dlN0b0NsQkRo?=
 =?utf-8?B?Z2xQVjZBWDlZSFV2SGRjbUtsVjZVcWVSZzBuMllxUkcrOXNFTy9ZOHQzOHFC?=
 =?utf-8?B?aUU2eEs5SCtRTzEzb2NiSUtkUDJDYU1DNGZ2OFI5a1RmaWc4S0FnazEzYzhS?=
 =?utf-8?B?L1FRQnhGbmZLamJ0RTE5SlJBZUhtd0xHOSs3YmFjLzNXWkNwL2NmYnFka3pO?=
 =?utf-8?B?bkFhcFU4b1MxRmJuQXBZUTl2SVhYa1B0ZFdLbmpKWkYvaHpjRFdpS3pYbkZS?=
 =?utf-8?B?eDl4OWoyNldmcWhsWnAxSTZtbDFWdjhnTU1JbTlDZnVpTVVuK3Yxd29uMjU2?=
 =?utf-8?B?a2NWVG5PTmRMRWtGbTl1TUhkdldrdTJMMmNYYVY3YXUvTEh5bmNBQ0UzcmVT?=
 =?utf-8?B?S3M5SjJUYlFwNFNYd05VOVpVV3ExeG03NnljTkJmbXFkS09rbU95RE5qdlBO?=
 =?utf-8?B?TmNEWGE0Rzl3ZlRFYzFEVGI5VzQydnh4UXBhOGdJUVA3dUxKeW9aMTVQeHN2?=
 =?utf-8?B?L2thN1E3Z0ZMRTI4VlZkeGJ2dTJkNHFBSFhGZ09rOUM3dWFSbHJFTGNSQmJx?=
 =?utf-8?B?YlU3QlNKNC9RRlJhRmVHb3BCUU5CUjV1ekE2VVZQbUtBSkFuWWhYNHVFNTdh?=
 =?utf-8?B?R0NSWUVDT2R5REU0TGRTMko3ZTdwVG9oL2NrL3pabHUvK2ROSEc3TkN4bHpp?=
 =?utf-8?B?WkFYZGNVd21tZ0VOcnhjSnoxSmVVeEQrcVNGK20yM3NucWM0NEFPTWRFcHo1?=
 =?utf-8?B?QmI0NUVXb3lySjQvTmxkYVdaakt2OXhFNWZxbldocWpHZVBtRmp3ZmJYajRN?=
 =?utf-8?B?MFpPZGNoazdqVmg0bUJraXRRUEc4YlJmdE1ndWlQN3ZqS3dQTlJtUzVTVkJq?=
 =?utf-8?B?TzBzVDF5aHFINmZCU056elQ4Y1d0MmxkbHJvZkVleTRYOTg0OWVGK2Qza2hi?=
 =?utf-8?B?TjBGcVZua0UzcGVaWDM4TG91clA1eXpacEFuL25XV2tKU3VvZTExNFRySmZN?=
 =?utf-8?B?a2NiUk1rbzY5STM5TU9RSDcrK2s2eEp0SEtaOXBrN3dyemVLR05nS0U3K291?=
 =?utf-8?B?NjE4U0Q0RXJicHUrdXpBTzUvd2JrbVllZFJhenU3UzgvbjQ3U0NMV0dQRzIx?=
 =?utf-8?B?ZTlIODVVMUgwSHV6cVp1RDVDdVExam95dnF6cVAvRkRvUnROdURML2VGcTQw?=
 =?utf-8?B?SitTTVc0V1ZNMmplM0RxcGc4eG9kb0FZY3lVL2xuSEQxZTdkckFvQk5lZTcr?=
 =?utf-8?B?S09UV1FFZVBzcTNlRzBqNjJHM3lEOE5ObnluSFZtQllYYlYzeFBFcXhHRk5H?=
 =?utf-8?B?QVhVWjZ1blJwckNJSXRscGxzaCt2ck9XSXZvYm9qSTdXcFRYVlhCck1aOXR6?=
 =?utf-8?B?a1pjTHpTZVE3ZG9NWWs4Ty9IYnB3NGFQV1JxZytFdGFtMXJxamxzM204akdZ?=
 =?utf-8?Q?Q78e7OmwivycXDiUAYtkmepcJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a12695-7448-4457-6eef-08dd5554e73d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 04:28:50.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixFVSxbBWq3epf/+AMfsbBWbMv24EEOWu9BKCxr93GWT+VShijtSPb68vOdkvz3QhYvDjPeGyFnk6KOH39CnoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326

On 2/25/2025 5:59 AM, Mario Limonciello wrote:
> On 2/19/2025 04:57, Dhananjay Ugwekar wrote:
>> On 2/18/2025 3:36 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> By storing perf values in a union all the writes and reads can
>>> be done atomically, removing the need for some concurrency protections.
>>>
>>> While making this change, also drop the cached frequency values,
>>> using inline helpers to calculate them on demand from perf value.
>>>
>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v3:
>>>   * Pick up tag
>>> v2:
>>>   * cache perf variable in unit tests
>>>   * Drop unnecessary check from amd_pstate_update_min_max_limit()
>>>   * Consistency with READ_ONCE()
>>>   * Drop unneeded policy checks
>>>   * add kdoc
>>> ---
>>>   drivers/cpufreq/amd-pstate-ut.c |  18 +--
>>>   drivers/cpufreq/amd-pstate.c    | 195 ++++++++++++++++++--------------
>>>   drivers/cpufreq/amd-pstate.h    |  49 +++++---
>>>   3 files changed, 151 insertions(+), 111 deletions(-)
>>>
[Snip]
>>> + *          calculated wrongly. we take the fixed value as the highest_perf.
>>> + * @nominal_perf: the maximum sustained performance level of the processor,
>>> + *          assuming ideal operating conditions
>>> + * @lowest_nonlinear_perf: the lowest performance level at which nonlinear power
>>> + *               savings are achieved
>>> + * @lowest_perf: the absolute lowest performance level of the processor
>>> + * @min_limit_perf: Cached value of the performance corresponding to policy->min
>>> + * @max_limit_perf: Cached value of the performance corresponding to policy->max
>>> + */
>>> +union perf_cached {
>>> +    struct {
>>> +        u8    highest_perf;
>>> +        u8    nominal_perf;
>>> +        u8    lowest_nonlinear_perf;
>>> +        u8    lowest_perf;
>>> +        u8    min_limit_perf;
>>> +        u8    max_limit_perf;
>>
>> Just a thought, how about adding the "u8 desired_perf" (last requested) and "u8 prefcore_ranking"
>> in this. We can pursue it as a separate patch if you want.
>>
>> I think there is value in adding desired_perf atleast, so that when we are caching the
>> min, max limits in the perf_cached variable, desired perf level is also atomically
>> updated into the shared cpudata structure.
> 
> Can you see if there is any performance advantage to caching these?
> If there is, can you please do a follow up to my v5 series?

There might not be a performance advantage, but I thought it will tie up 
the entire perf updation (min, max, des) into one atomic write to perf_cached.
But the min, max and des_perf updation is divided into different functions 
currently. So it may not work as I'm imagining.

> 
> It's going to mean another write in amd_pstate_update() potentially.

Yea, right, I'll investigate and see if it is worth doing.

> 
>>
>> Thanks,
>> Dhananjay

