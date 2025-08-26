Return-Path: <linux-pm+bounces-33060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853BBB35151
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 04:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539C5203A91
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282911A316E;
	Tue, 26 Aug 2025 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jYZ+ggtj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEF393DD3;
	Tue, 26 Aug 2025 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173691; cv=fail; b=dAB0nuiXIAs/4egM4wy9Dd+XVFEcm7w7SceV+04fkZopnfGIS7Uu8BJL8JuI1JwlVA070mIdfdvop95vQiVeH+DBD94Qs+km9R9IVt4ktN5u2deSYj9oTPCBpZ5d7/vv8asIbOD4SGZKS6bA7ZyGiIZvwj2R+1SYrjGMo8vr8pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173691; c=relaxed/simple;
	bh=Im+D4uuwg9gVaFbcOFIsWvgliYkEAUKOcCYYq49OL6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iypsW51S+NOzKH8DIuo6EH8luakluc8jX1WGhHyASj6Ygnp3kxESCJ2QLJj0deO08dR9PtYynOSwHjpCLUi7CYPcRTGH0vMON+a7fL3iX1apeYw13ciOlTKnI/o1OiYsnyYqZ5aPxD/Zf8LhFVN8xDwvFaCIeWyA9a4T0VX5Qo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jYZ+ggtj; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvRukpKfB6YRUeEp8MU4xZ3n6/V0IgkVftOUHR88wkHjtlzuVddqoJhJhl7Yq4DobS9tcrA10u1G3SxcO/7rQsODLBu5CFrB1Q1FpKbAcjZSZARNkNrcP4zVR1hESRQT/aDzqdswP5QKVj19ZtjntYgN1ZN6avLc9B7oOGKEiZ8YT9T+PFIB7OBOkGXJMglyvw7PQPulSbyrPL5Np0lse4oZrrBuQAejcovqXP0j1jjTFIW6qZtVVWNX/UrF0Olp4XBBt5nEeJq1CxCf9nNeokW/U1bIKKeuRy0co25EwMnY6KHzC9hPLfUaGwxW5uPAejUocMy02S/b8YNthCNFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP1/z6bBdOpaDXQ7duYYRyEWFjy/eSu5PKy5eyZabNc=;
 b=LtH+hhIjMWdnY5MyN/vNFGaxZ5WQdUFtwOfhye4jZKLO8mAPO938bE92VCdgArox9NoJgOqyRht0py+SZ2Zbt4RpszYsbqtElcmG3ElRwYUW/S8LLGOG3I+fQQz6PMOIrlAqQGP63Ch54s9XJnZwa60oTiVCZ3/WtJwJtxRZr17M1dplWF0dEjyFbLANN2kYCJ7m1PIKVaNL+Auj2kg9IO1JPbVVRnP0c325mr3muduXNH4VwUfb0Gch86R01+ir/l6E7scTDN01gnCftBuUaOvNdEJPZq+EZAmhOMCIGMffaliveacddK2+zGTFtUKdIG0IoccGDq/z2ZxcpxnlnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP1/z6bBdOpaDXQ7duYYRyEWFjy/eSu5PKy5eyZabNc=;
 b=jYZ+ggtjK+fKJrUh3KYIgydQtyC+b3hZkb07LXuHgGbfZgM2X1pNyQQCD/dc1yxcwuC0FkUxF36jpw78b9y/GRY/GauuhuS7hHC8mZIens22X9Gh8Mcq8lrlpCSHRFHA3Z4/ivl/3zIn3e2Rv3EhYVrNLpRwKNEupeOv55O8mXI9gKPw6rsB6w5pf8AmgVroPRcLApcp4e7FbpB8FnZo9ioAnL0YRaMbWzEzfjN2RQCQiP1rEhnS3SOPgOVGx5JMgr/UnKhbQgm/ySsddn3gA7jz02IqD5+jTVgyCWNa8ns7Ml+i93qh3SmXofEnPtGpp4r9Yoes0Bkhb0BOtT0YTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 02:01:26 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 02:01:26 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4 3/6] thermal: tegra: soctherm-fuse: prepare calibration for
 Tegra114 support
Date: Tue, 26 Aug 2025 11:01:19 +0900
Message-ID: <6192274.lOV4Wx5bFT@senjougahara>
In-Reply-To: <20250825104026.127911-4-clamor95@gmail.com>
References:
 <20250825104026.127911-1-clamor95@gmail.com>
 <20250825104026.127911-4-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SYAPR01CA0017.ausprd01.prod.outlook.com (2603:10c6:1::29)
 To DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: af82c4b8-de41-42e3-ca60-08dde44476b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlo4dmFVNkFkK2FtV3VyQVZRN25HcU9JMDFZb0lHTmpHSUc3bXVmWEducXRE?=
 =?utf-8?B?UzhrclJVK3Q2VmRHQXY2ajVSUGsxZzNVd0ZMRWluVmhvQ1dyQ2lWZGUxYUc2?=
 =?utf-8?B?R3lJczJ2K3FLZE9ScFFZZXJoVkNERktTSnRGajRFSGl6WEVuWVBxRXdCclBt?=
 =?utf-8?B?UEcyYkdsM2theG4wRWVHell1R0NiSDY3T1I2SlNFTy93OEVCRlBVd0E0K0dP?=
 =?utf-8?B?aHBUczlaZEgwdUFDaXkrYjFnOWw5TEMyRzBMU0hTa2g4VTl1ZVBkdXBzM1lM?=
 =?utf-8?B?OEVQMklveFlpWEVJTjZQR3dwWUw1YkpqMGRYd1ZnMTFsTG1hbGVpTE92WmM4?=
 =?utf-8?B?RjhkUkhSdFQzYlpNQ0VKVG00dG9aT0hISWRKM2MyMS9KTk1jY1NzZVlyckxD?=
 =?utf-8?B?Tk9Seld4eWlhdnZrdnFBcXJpaWQ5a3lQMk5IZ1dyRDVKUkhaYS9JQ3ZyY0dH?=
 =?utf-8?B?R1FPQmJqMit2SkZHYXgwcmFlcWtzVE5neWoyanJ1emFoOEtoaVFwdXZjSU13?=
 =?utf-8?B?eDJCZTZIaU44UDN2WDRvdFc0ZkNYWTliZzd6T1V1dldvSEQ1dmZTZkVRWDY1?=
 =?utf-8?B?em9tTDA4QzU0VStGNVhVSGJ6dGNPazN4cThOcStWMm9EL2RVMHJHUTl0bEdQ?=
 =?utf-8?B?R1ZZelpNRE5EdUsvWVV0aUVwUTZYdWdSd3FMMzNMNnNycDhmLzJ2TGVHckdO?=
 =?utf-8?B?RTBDY0kyM2NSaUs0ZHM4VkE0ZU5DUFpIZmhrUVBhUmpvMnk3SlhGZDd4SVE2?=
 =?utf-8?B?dGVOVEtocGVTY1huRG1jWC9ENFpDSnNXWU9zcnNMczFuZXRKYVlNRUozZmJq?=
 =?utf-8?B?SlE2UE5wTnpqRHZSMFE0YmlCcVFCUFlVZ0QrTnBkL1RhY1B0S1c2UUdrNzRJ?=
 =?utf-8?B?bkJIenI4K0dKOGtISFhuUlJ6c0VsYXdPUWd0QTZRM2Jrc2xGRlhtOVhkMWxQ?=
 =?utf-8?B?NkNDRzQ4d2NuSjJuVGZTbkNuV3dFaExmZTBzV0hnOEFCQWhMUkRmaEVFd3lK?=
 =?utf-8?B?TVlmZCtzSU9FTVlmemxDNG9CdFJqVmRoNlk1NTZocXhRc1ErMENNeVlWbmQ1?=
 =?utf-8?B?SDJNZnEwajFqVUJ1ZUNOK3BwLzN0U290NEdqbjAxbEpPN1ArSHQveGw3LzVD?=
 =?utf-8?B?WWFUUTRkNFpTK1dINk1XczRyZ29EUndJcm1JVjFZc3B1Ky85REdSK3hlSjY2?=
 =?utf-8?B?cGxVTmYrMzZmSythSXdsVHJQeXhleHFZZUtmWnRjL2JYb0Rjd1hSS2dVSm9H?=
 =?utf-8?B?RFUvMk5CVld6MENVM082MkJDQk00RjBCNndVVEpWWVlDZFZMMThGckYvcHU1?=
 =?utf-8?B?Y3BtMm0vR2RIL2x5ZGZPajFIdE5mSXlDOG1QWUdDd0JKNy9oZmdjTjR2S1dk?=
 =?utf-8?B?QVI3R3ZKS2thZzZDMHdsSW5GbFErRmtqNUZ0WjVLWldLaFp6SERVRXQxQWVD?=
 =?utf-8?B?eWJqY0ZKbTJvcWJac0lueTMwSnhsMmhZNXFrUStFOFBBa0lwTGFFSzB3WFlY?=
 =?utf-8?B?N3FwN09yMlpOdXVZNlFHeHYrUmFOSklFYWpuL0o1QVI5N1RHQWYrKzU1aTRW?=
 =?utf-8?B?YnJNRUpDUEdjSGFaSDVKTU1NV2R2aGphOHd1MWtuVCs5SS8wS09LNzdwV3VJ?=
 =?utf-8?B?RWdwZUJVcXlFQUpib1h5N1FMbkZBU20yUWYreXYxVEJydW82Y2ZQLzJZSzMv?=
 =?utf-8?B?SVQzUHZ0emRjY2xBTXZYT3lVbzlTVHIzaGxSSE8yV0lmdkRqaEk1REUyRk50?=
 =?utf-8?B?dFRKcEhlWDJJVUd5TEYvR3FjWmF0eWNBNmkrZHFSVm9DMVB6VGhsU0F2bFhP?=
 =?utf-8?B?NzZ2RkJZb1lFYU94OWJieE5qY0hwRkN4em5lbTZmQTZFNTZldy9aWFhiclhz?=
 =?utf-8?B?M1JsMzZidVFNQzhycHhtU3gzd21MUTNpWTNIZitlaVoxZ1BjTDVwYkNaTEYr?=
 =?utf-8?B?SDhid09sRUN1K3pDWXY0VUhyb3VXaUZkN3pLOFN0eFJsSWV6YkRQS0ZYdlFB?=
 =?utf-8?B?SUptemxpVWNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXFBcEZwdHhMN3czWlVhY3VSY2RGdDd5VVlQTllYMWNZRm1uU2pxYU1PSXlU?=
 =?utf-8?B?UFJWSXFURzA2UEJLZjdnWTQ4UFBtQXJCV01hRGpKTlFzOEM3SFRJeUVBcGJt?=
 =?utf-8?B?SWVTdnQ3TUYxNXpsM29vSWNJTVlqNElJUHZnZmNQYnRZdExVaTZucTZxR3NF?=
 =?utf-8?B?MmpYYklJK2IrUStFZHJ6MG03cmtQQXpIOGljOVB4blFkb3pNMm1Kck0xVGJJ?=
 =?utf-8?B?OWR0UzFIYi9ZZnMrRU5laG5YekFGWVZUZHBad3Mxd3kxcG1wUmhRbUdGK3Zt?=
 =?utf-8?B?V3NXWmwzTE9yUlpNeXhSUk0wR2c3YWx5STAxTVhoQS9UNGFrVE9MYXRNeWN1?=
 =?utf-8?B?YXVHaEcycGtlbm5MSEVUTjIvM2Qxdm40VWtNcGdPUGN2OWErejB2aDVPenIz?=
 =?utf-8?B?dHE5bHQ0TTE1N0V3WE9oMTNuaGdKQ3lRSS9ZekF5VWJQTHFJY3FhMSs1bHla?=
 =?utf-8?B?OHI1TllJT3hjYXhMZzkwU0pYb2tQTzA3OFo5WXRPQkJIaUg4UnZYQmpscUZP?=
 =?utf-8?B?dXUwZkkvSDRSMEJndXIxbGRLZllxY3E4eUVyWFZGVEk2cFVLWHFkc1NCSC96?=
 =?utf-8?B?dG9PU2lSdTZwWVIydU9TWTNGOExQK21WRW5RaVZKQXFTNmc4ZXhJeDNITGho?=
 =?utf-8?B?a1dNVmVQbFcrTXlkNGZza0xkM3NWVzdRQzV0NHZVRElvcExFenNuRUtLRXFp?=
 =?utf-8?B?N0JhQVd2Zjlrb3ZEVTF2cGdPQzhzbHJRdVc1bDE5MVhMZ2UvOFY2VmVqcUc1?=
 =?utf-8?B?TnZ5OUdpdzFtNkZCWkV0dTVHRUt1aFl5Y0s4YlNKZU8xQU5IRWlCV3ZJc2lx?=
 =?utf-8?B?RDV3aUFlWFdIdUdiQkM0b2duNFQ4MkM5dzRWaXBacTN0SGNDSjV2ZENyUERG?=
 =?utf-8?B?cWNRS2xYTzhpcEd5MmlDenQyTFFzSFRST0xyMTlJbzlhemZkMmIyODNEY3h0?=
 =?utf-8?B?OVZ0WG12NVFlYitMR0pEV2M2b2xpL2JZUDk3bGtnWWhobXBkbW9HRWVNSVJh?=
 =?utf-8?B?UUkyeWdTV2Q1bjB3ZW1GZlJpMFBDdTY4TmxwaTM3cTQ3QzAyYkpnUVgxNEVn?=
 =?utf-8?B?UUM4YUE0RzFVZEdlNFNkMXVQZm4vNndibVlUVXRsSG50cUs1Nmlmei9TcXZ1?=
 =?utf-8?B?UzlwZDd3TGYzakw3eUtNNXJCNXBxWEdtTlc1Uy9hckpsTHVUK1NXVVJ4a1Qv?=
 =?utf-8?B?OThwTEpXcGZWSENMQVlJUDEwTEdmdWxLMkgzdzNlQVV6QzdDNTVvTU5mNHBt?=
 =?utf-8?B?YVU1Uy9NZ3YwZGk1V2hZcG4xcGRhRzI0OHRPdmNtRnVvK1pGYnE0OTlEekE5?=
 =?utf-8?B?NC9wSXBhOU45V1VFUXc1elFnLzlINlpPd2Jwa3RLSDh3WUR5VHFVcXlJU1Zx?=
 =?utf-8?B?ankxSkFodVlZa1NOZVVCTGhsakZETHVOc2FKUUhHM0NyT25oR3JZTXVJWXg0?=
 =?utf-8?B?bEdmaDFJMEtaS0ZKSFMyUEZrMFp1QlJHN3lqK29DQmNoVGtlMkRibjhpc0Ry?=
 =?utf-8?B?UHVjNnhLL2huVjhXVEdPUTFwZmhER3VJSjdxTy9EdHZZS0xrUWw5M1NQd1ZS?=
 =?utf-8?B?Q1lvekdUSzRMOEZZazZ4WDlCR3UzN3BIdHZ3OWdhUGJiUm9tVmNoTWhWRzBF?=
 =?utf-8?B?Q0k0MkF4dlM1QWJweGwzTTcwdXB3YXdGdU82REowaEdiM0VTL0pPbDFINEoz?=
 =?utf-8?B?THNaSVJ4ZGozSTBkdmRtT1BObGQ5VHh0Ry9lNzNSMDZrWktydDYyM3FQVjBB?=
 =?utf-8?B?ckFpaXpOY2JKL2NySk9rWFNJQlE4MFBKNkxiWkJlVDNUZGMva3pPRFRua2Qv?=
 =?utf-8?B?ZE5wbi9jMVpKbjlNa2h3N0ZkbmZCRDlOTFUvTkRYTnRMdXV2bE5meVZCblB4?=
 =?utf-8?B?QXIrWXdTcDBsN2hpOTVLa1oxb3h0cDlUaFJJSWg4ekNvcmt2OVV6NW5HdnBp?=
 =?utf-8?B?T2Jpdm92a0NMNkZPYjkzb1NQakNMcWZwNGlNVXNod0FWbUVSTURsODhMVVlJ?=
 =?utf-8?B?ZFI2M2RxMDU2a0VuRnQzR3FqdGh2eE1mYVZrclNmeU1aZWlnbnVwMjh2YXF1?=
 =?utf-8?B?N3FXQXN0aUxqbkJXS0hhZlBqUTJBN2ZyaDdVNmdFSGlZUG1SMk5rV0s4OTBX?=
 =?utf-8?B?Y3BYK3kreWJjbzFJYUdEK2djcjA4eFpIRHMxeVREd29mbmlpY2NFbm9ha3JE?=
 =?utf-8?B?c21XSnRWMzUvUmQ2UmhQMFYydllLenp4N2xHTXVlMk02dzF6bDBIQmJRK2JC?=
 =?utf-8?B?ZnlYdXUvTmI5UllOR0w2MVB5OGJ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af82c4b8-de41-42e3-ca60-08dde44476b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 02:01:25.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdozydQqjW7QTcYYqexUWfqyW9lZMsfjxQhDjevH5FVW9nD+lN3AoFhLBfLgLZiPPl2ETQWuilkhoSG6R3KBdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

On Monday, August 25, 2025 7:40=E2=80=AFPM Svyatoslav Ryhel wrote:
> The Tegra114 has a different fuse calibration register layout and address
> compared to other Tegra SoCs, requiring SOCTHERM shift, mask, register
> address, and nominal tf calibration value to be configurable.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/thermal/tegra/soctherm-fuse.c     | 18 ++++++++++++------
>  drivers/thermal/tegra/soctherm.h          |  7 ++++++-
>  drivers/thermal/tegra/tegra124-soctherm.c |  4 ++++
>  drivers/thermal/tegra/tegra132-soctherm.c |  4 ++++
>  drivers/thermal/tegra/tegra210-soctherm.c |  4 ++++
>  5 files changed, 30 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm-fuse.c
> b/drivers/thermal/tegra/soctherm-fuse.c index 190f95280e0b..8d37cd8c9122
> 100644
> --- a/drivers/thermal/tegra/soctherm-fuse.c
> +++ b/drivers/thermal/tegra/soctherm-fuse.c
> @@ -9,15 +9,12 @@
>=20
>  #include "soctherm.h"
>=20
> -#define NOMINAL_CALIB_FT			105
>  #define NOMINAL_CALIB_CP			25
>=20
>  #define FUSE_TSENSOR_CALIB_CP_TS_BASE_MASK	0x1fff
>  #define FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK	(0x1fff << 13)
>  #define FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT	13
>=20
> -#define FUSE_TSENSOR_COMMON			0x180
> -
>  /*
>   * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
>   *    3                   2                   1                   0
> @@ -26,7 +23,7 @@
>   * |       BASE_FT       |      BASE_CP      | SHFT_FT | SHIFT_CP  |
>   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>   *
> - * Tegra12x, etc:
> + * Tegra124:
>   * In chips prior to Tegra210, this fuse was incorrectly sized as 26 bit=
s,
>   * and didn't hold SHIFT_CP in [31:26]. Therefore these missing six bits
>   * were obtained via the FUSE_SPARE_REALIGNMENT_REG register [5:0].
> @@ -44,6 +41,13 @@
>   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>   * |---------------------------------------------------| SHIFT_CP  |
>   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + *
> + * Tegra114: Layout of bits in FUSE_TSENSOR_COMMON aka FUSE_VSENSOR_CALI=
B:
> + *    3                   2                   1                   0
> + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + * | SHFT_FT |       BASE_FT       | SHIFT_CP  |      BASE_CP      |
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>   */
>=20
>  #define CALIB_COEFFICIENT 1000000LL
> @@ -77,7 +81,7 @@ int tegra_calc_shared_calib(const struct
> tegra_soctherm_fuse *tfuse, s32 shifted_cp, shifted_ft;
>  	int err;
>=20
> -	err =3D tegra_fuse_readl(FUSE_TSENSOR_COMMON, &val);
> +	err =3D tegra_fuse_readl(tfuse->fuse_common_reg, &val);
>  	if (err)
>  		return err;
>=20
> @@ -96,10 +100,12 @@ int tegra_calc_shared_calib(const struct
> tegra_soctherm_fuse *tfuse, return err;
>  	}
>=20
> +	shifted_cp =3D (val & tfuse->fuse_shift_cp_mask) >>
> +		     tfuse->fuse_shift_cp_shift;
>  	shifted_cp =3D sign_extend32(val, 5);
>=20
>  	shared->actual_temp_cp =3D 2 * NOMINAL_CALIB_CP + shifted_cp;
> -	shared->actual_temp_ft =3D 2 * NOMINAL_CALIB_FT + shifted_ft;
> +	shared->actual_temp_ft =3D 2 * tfuse->nominal_calib_ft + shifted_ft;
>=20
>  	return 0;
>  }
> diff --git a/drivers/thermal/tegra/soctherm.h
> b/drivers/thermal/tegra/soctherm.h index 70501e73d586..083388094fd4 10064=
4
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -56,6 +56,9 @@
>  #define SENSOR_TEMP2_MEM_TEMP_MASK		(0xffff << 16)
>  #define SENSOR_TEMP2_PLLX_TEMP_MASK		0xffff
>=20
> +#define FUSE_VSENSOR_CALIB			0x08c
> +#define FUSE_TSENSOR_COMMON			0x180
> +
>  /**
>   * struct tegra_tsensor_group - SOC_THERM sensor group data
>   * @name: short name of the temperature sensor group
> @@ -109,9 +112,11 @@ struct tsensor_group_thermtrips {
>=20
>  struct tegra_soctherm_fuse {
>  	u32 fuse_base_cp_mask, fuse_base_cp_shift;
> +	u32 fuse_shift_cp_mask, fuse_shift_cp_shift;
>  	u32 fuse_base_ft_mask, fuse_base_ft_shift;
>  	u32 fuse_shift_ft_mask, fuse_shift_ft_shift;
> -	u32 fuse_spare_realignment;
> +	u32 fuse_common_reg, fuse_spare_realignment;
> +	u32 nominal_calib_ft;
>  };
>=20
>  struct tsensor_shared_calib {
> diff --git a/drivers/thermal/tegra/tegra124-soctherm.c
> b/drivers/thermal/tegra/tegra124-soctherm.c index
> 20ad27f4d1a1..d86acff1b234 100644
> --- a/drivers/thermal/tegra/tegra124-soctherm.c
> +++ b/drivers/thermal/tegra/tegra124-soctherm.c
> @@ -200,11 +200,15 @@ static const struct tegra_tsensor tegra124_tsensors=
[]
> =3D { static const struct tegra_soctherm_fuse tegra124_soctherm_fuse =3D =
{
> .fuse_base_cp_mask =3D 0x3ff,
>  	.fuse_base_cp_shift =3D 0,
> +	.fuse_shift_cp_mask =3D 0x3f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 10,
>  	.fuse_base_ft_shift =3D 10,
>  	.fuse_shift_ft_mask =3D 0x1f << 21,
>  	.fuse_shift_ft_shift =3D 21,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0x1fc,
> +	.nominal_calib_ft =3D 105,
>  };
>=20
>  const struct tegra_soctherm_soc tegra124_soctherm =3D {
> diff --git a/drivers/thermal/tegra/tegra132-soctherm.c
> b/drivers/thermal/tegra/tegra132-soctherm.c index
> b76308fdad9e..64c0363b9717 100644
> --- a/drivers/thermal/tegra/tegra132-soctherm.c
> +++ b/drivers/thermal/tegra/tegra132-soctherm.c
> @@ -200,11 +200,15 @@ static struct tegra_tsensor tegra132_tsensors[] =3D=
 {
>  static const struct tegra_soctherm_fuse tegra132_soctherm_fuse =3D {
>  	.fuse_base_cp_mask =3D 0x3ff,
>  	.fuse_base_cp_shift =3D 0,
> +	.fuse_shift_cp_mask =3D 0x3f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 10,
>  	.fuse_base_ft_shift =3D 10,
>  	.fuse_shift_ft_mask =3D 0x1f << 21,
>  	.fuse_shift_ft_shift =3D 21,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0x1fc,
> +	.nominal_calib_ft =3D 105,
>  };
>=20
>  const struct tegra_soctherm_soc tegra132_soctherm =3D {
> diff --git a/drivers/thermal/tegra/tegra210-soctherm.c
> b/drivers/thermal/tegra/tegra210-soctherm.c index
> d0ff793f18c5..f6e1493f0202 100644
> --- a/drivers/thermal/tegra/tegra210-soctherm.c
> +++ b/drivers/thermal/tegra/tegra210-soctherm.c
> @@ -201,11 +201,15 @@ static const struct tegra_tsensor tegra210_tsensors=
[]
> =3D { static const struct tegra_soctherm_fuse tegra210_soctherm_fuse =3D =
{
> .fuse_base_cp_mask =3D 0x3ff << 11,
>  	.fuse_base_cp_shift =3D 11,
> +	.fuse_shift_cp_mask =3D 0x3f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 21,
>  	.fuse_base_ft_shift =3D 21,
>  	.fuse_shift_ft_mask =3D 0x1f << 6,
>  	.fuse_shift_ft_shift =3D 6,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0,
> +	.nominal_calib_ft =3D 105,
>  };
>=20
>  static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] =3D=
 {

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>





