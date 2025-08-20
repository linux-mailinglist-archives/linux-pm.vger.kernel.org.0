Return-Path: <linux-pm+bounces-32673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D1DB2D311
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 06:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3247250C8
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 04:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69201259C93;
	Wed, 20 Aug 2025 04:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y6NqwaHY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6C78F34;
	Wed, 20 Aug 2025 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664519; cv=fail; b=O9K+1P+3CPO+q1HjcZlFHbE9jDMRoZySA8cof7HV4q4IMn7neQzUJDqAqNt8ursv5YpxZ09Fxrz+wVltSTu+mvQA4hzZnCQO/w3Zwl0BowbMcu7/d/DagzEo26uEVD+zithPGHx53yTyoepHdBQBl2QHwkjXhmjzvgWyNCKdG+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664519; c=relaxed/simple;
	bh=kagIH6jS5MKBDDboJzxNEiomukL6FUHHqLshR9wqI+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkFmEl1ouB9uTNDmOGiXj5m/B3hn+hTM/9WRH1QYjcTWS6OTWb5tjw7Pvz0G53DL1+vBdvuuzuZVzFG3NNELxQbQmSaUYxyyPZLyyL/6GkPb70CKKjmhg/AQLm9cAdgUEUk1kF3YWe7JdzUZtYFyRCsfqdwCKCIZTkzvNAwuZVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y6NqwaHY; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY+94etw7caTEVk10EPcFURGD2qO7oM4vPxtql2FAlb+bZ9i+fUR9vxzUSm1mEWw+xZaSePINKPe0iQQR9vXSkPAIOt2AT6eIP67gXpBKD7QsUGk9aloYPYpWnDKK+PbKSmdRGm1KECsrleRCAB0WSGcrvJ4n4wXuoAkho2aue5IkocaRP9yKmfpdcklZFfIAEkXLZxVpKnqoGjMM2EahjoMMSL9lkDOJOX/awMCUShz7Rco5GYljotgIXC0KH9aB/1Mp5Ex2FsshdgbpaHig7v90Audm1c7/i2FdmKGqYHLHorl6V1LGdHoR1bWdSaaSxn2RVPEBvpH7NPxFKlzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv05Fb/t58gNJrJELyY6Uu5bLH4Refo7R4A0mlr76lY=;
 b=Rl2l1nILFiaP1OjnQ7m+sKZTmUP4m3XQXeW7Q4hO4yd6KbEu8NpsMdH13l1Lg7wsUSltHv9sg3sWEvV55IANb/UDDmZieuzEffg9QYlg1XjhX68GtN4Jof/xFSJ6jQSmILgZG5/htNIDTFCpGJyQmvoXAiMZe0et2w2lOTZdX6Go3+38ZsGrRKbR6T6HzKFx8fvpYwb10lSsEESnMRbbz2NrGwYu/8yVJOWtsbpKcJi+X75VNwAs1B7ezju/9SUDEWucBXWaszPadsI5ZFh7h4vwD0TE2Ciyk1CEAb4f1RIOJwNohwjUWUMKIHUCymn7liG4OlDGpgf7AVzkokogdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv05Fb/t58gNJrJELyY6Uu5bLH4Refo7R4A0mlr76lY=;
 b=Y6NqwaHYripr6a/jJwZyS0pWMcHDneOINZopZPRKl9jkWJGiH8HYUN048kqMGlcvtyCAGajJir88eT9EZKccdluLSKd3JgOwC6PoTybQ7qa7PYzNJklGjmTHa5WG3j4sfszfNrZtdJL1oeFOLzAaC3avPFb4SV3a+YWihDN9ebmCjzT/BAQrTD89jvx/NgmbZJWlKLUTnZMxYA4OjedoJ430P/yADbsrCuTmCDyLsTZm03b/pGbYKkoNqSzCukud/r4UyWH7cuKSBS7GQL+dpTMeJgVhu6019N5RP892FeJ1ltXmgJzppkhDoZ8bVlQWg5hsNL7ZZ8X9s659ELMF2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 04:35:12 +0000
Received: from IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6]) by IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6%7]) with mapi id 15.20.9009.017; Wed, 20 Aug 2025
 04:35:12 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 3/5] thermal: tegra: soctherm-fuse: parametrize configuration
 further
Date: Wed, 20 Aug 2025 13:35:08 +0900
Message-ID: <3738425.aeNJFYEL58@senjougahara>
In-Reply-To: <20250714082252.9028-4-clamor95@gmail.com>
References:
 <20250714082252.9028-1-clamor95@gmail.com>
 <20250714082252.9028-4-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:1::29) To IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6484:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad4f21f-22e7-4f1b-b61d-08dddfa2f3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVhBanhxNVdGV1NWZ3FaTHpPMXFSbHp5RnRqMWlRSHBDdTE3aTNQRThLZjB1?=
 =?utf-8?B?Q1RnWUZhaUZ0SmpseXZEUFJkUzhKU0dsRk0vMGRVYVk3dHdyNkZMd05WdWJy?=
 =?utf-8?B?d243MWVVaWd4T3FkREhnc1FqMEp1dTJFa3B4UW4xcUl6eXNtblBiVENNQ1Q4?=
 =?utf-8?B?ZmNtMThhZlhsWU5lRVJTVmltdC9DOE9SejZnakJRUjdKMitzQ2YxUkdVTDdI?=
 =?utf-8?B?a0NSYU9ocnhNaHFBM3drQjN3SEdqUW9yME5BV1VoenF2RENkQ1dyYURIbmV6?=
 =?utf-8?B?d1FWNzRZS2s3aVFyaGdwWnBRdnJWUjdyQUM4a2J6cEdJYkRaTlpvQXFjSDdi?=
 =?utf-8?B?Y3NUcGk1NUw5emJJak93YmxNWW9MbjJ4U3pOVVBKZ0w5SkxnOG1LNHhnQkw1?=
 =?utf-8?B?KytybGRMaWZiME8wSGtpRmZ4ZmJTTHNzQm5MNEg4VzNrVU9nYnREcFlHRHVG?=
 =?utf-8?B?WnRDRjloMUZRekJLLy9Fb1h5Q3VhdW9KdFp2TC8zN1ozL3U0T1JnYTA2enhT?=
 =?utf-8?B?Z2lBM1ZTckFNVk83ZTJweWlJNytCK3BMT3I3SEdGTDhmMnhkalR1MTdSRUQ4?=
 =?utf-8?B?YVdCTklpZTBzamNzeGJSNW1YTFQ1K1pwd1RLRXNWZHR0WXJBTy9yenNjVVVZ?=
 =?utf-8?B?NTJEOTM5ckE4VjNSSWlZOWxSUHBsRWdkdEVsTzMzUjdKeDdFbWlVVGFPZm9O?=
 =?utf-8?B?MDdyaFI2blNiVXdTYVRQTkszdHFFRmZzQWVKY3dvZkJCZjJXZllGNTN6NVFv?=
 =?utf-8?B?VkFETGVPSVR6bUdDL2orcGI4QWNzY3JkNTMwU3N5VXNSNFMwM2t6bWs2QWVX?=
 =?utf-8?B?NEFuaUNFVGpyM0FIdmQwZlV3NWJKaHNqSTRrUk5LVW1BNEFiZjRONUdpYmNn?=
 =?utf-8?B?aUhpSytxYkdmY0JMZXJ4Z2Z6MTdKUWxSRjhFUUdNNWlrUlJEVGc1NkhBa09V?=
 =?utf-8?B?eDdKV29JYVdnUW83MmJmZjVkV2F4TlU2MXB2cCtCbE5NSGNpLyt5Qi9iN2Nh?=
 =?utf-8?B?SG1wMStkYk0vZlArRGwrcGVSeU4waVVtRnI2ZURJVU0xSDVMM1hIa1hncUlo?=
 =?utf-8?B?ZEkvc3pvS3dNRUpLSHdzazE2WnVqZHd0dlMzVzR4emgzVDRBK05lN2t3VnZK?=
 =?utf-8?B?ZHlVckNhSkx5dk9CNldieXNwNW1tbVhXNTc0STcwR2lGdVNVOUlCYUtxQk4r?=
 =?utf-8?B?UE93NUxTa2cwSUdIOXA3bXp0UEpZc3BpMVYxdm1LUWZ3akxjTFJweHhxWVNG?=
 =?utf-8?B?cE14OVUyN3hoREFmVTR1TWZmS3FNdFFRaDBYalVSQ2RoVHp0NHZRUENWZjdl?=
 =?utf-8?B?WGhvWjI2WFEvN0g5VGdscjlaYzErYjdJbUF3ajZCdjcrL0xTQmJFOGRFQjNj?=
 =?utf-8?B?eWRzanBoTUw1NE1XaENDSXdxV25vbVFKUEluYjQ2dkZBQm1iN0I0MU5vQ2Ji?=
 =?utf-8?B?Vnk1aHZRb2NVNjdOdjJ6elFsNVVnYnFGdEYyYkdBVUt4eXJ1TTEzanBNc21H?=
 =?utf-8?B?Qk5qZ0ZYeE5GVnZhRFl2cUFGZ1l4Yzlud3VSbGZpd3h0eXd3eW5nSlNzTTdF?=
 =?utf-8?B?R2tqZ3E3UXcxY3UxMHY1Qm8raUxWUU1UZXEzdkZqSHlGYjNweHBnTnRDV243?=
 =?utf-8?B?WnlMNlVKYTVqQVhaN0V1aHlQbVFkNjBlS3FzMjN6TjQ5NDZYdkFQcmN6ZDVV?=
 =?utf-8?B?MGxaMXJocSt2bWFwRlVocUpmdFZaaDRaTDVJd01nZ1RDTWJGRG5BL3Z4K0ht?=
 =?utf-8?B?SHRqdXpKTDBFY1lmSEtQL2ozU1VRNFdRTEUyRFJ4ekl4ZC85bWZwUmFCcWVI?=
 =?utf-8?B?dHNTRjE2eE8yT2xXUWdsbHJJQWFmTGV3WnVEQmxPd3FWekdrMXhyaEhSS0x4?=
 =?utf-8?B?WjdoNCtmOW1TRTFJdjRYTGZDWXRIbjE0VUt1MnVMekcwOGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6484.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTR1MkhlWXBYNWZvUkduL2cwSldsbU9vcVhoQmdoMDBkaExtNDA5V2FFVzFO?=
 =?utf-8?B?UlhDTVozSVVpUW90ZFZ4K1NZRnJnV0xEa2dIbE00V1drM2hseTU0enFnY2pB?=
 =?utf-8?B?ZHA1QnpsMlNPVitKZ3YrYVY2akY3T2xHQjhoLzU3Nmk0d1lZTytLaUlnRHVW?=
 =?utf-8?B?eFc3Rk5NaVZmUDVPM01HZmJvcFRqK3VYV3FDTGZ2ODJRS2NPSDBvYmNtUFV3?=
 =?utf-8?B?V3pnM2hYaDhmNk5KVjVjZkJlbVovWW5uWUlkcW9MR0xLamFhcWJIcWFPa0RM?=
 =?utf-8?B?S3hvWS9rNWhEcVdLVnlCNEk0TlJQYVpYZ01VZWFxSFdFdFBDTGhIREsvaGV1?=
 =?utf-8?B?eFpBZ1RWWDYzczNQMVM3OEF2VWg4U3FMVDFjZm9rVGpZblJsd1Y3dFBFTDVS?=
 =?utf-8?B?ZHZjUXp2b29oaUZ4WTQ3VjIra3dVSkNEbHNCSURsd0Nmd2tScjVodG5YalVY?=
 =?utf-8?B?UG14RU9Sb1V1VG82a2ZyYUFsUlpUV1NhSzE4OGN6dkZhY1hicDkrRy9zZG1Q?=
 =?utf-8?B?T0thTExmdjNRb1pCN1A4RU9tTUJrMlRHUDg1TFMrRFFtSjhES25aMjhyMEZG?=
 =?utf-8?B?Myt5YkdMWHdZbjB6L09KUUdOekpYZ1pWcXQwbkJXNlQ4NW5QZlB3YldKSThu?=
 =?utf-8?B?TTk5U1IxTWF3Z1ZUVzNYUDd0SU0raDR5VW1xRmxubFExWGxWSzAwOEJkVExL?=
 =?utf-8?B?cUF6WGs4QXhlbUlyNVR0azBlOWNHSkdkTmZyMStWcWowM00vNUViU0xNNVI3?=
 =?utf-8?B?QVByTzRzUzFneExYdDJaQkdZSjBpa2d2VTBlOEt5NXdvQ3QyUHlxd0FjdTVD?=
 =?utf-8?B?VCtYeHk3NCtVZ0ZCM1pTMkhtZHZXeTFnOElOd1FtT2w5cmUxd3NDZGZvZzM0?=
 =?utf-8?B?V0lOQnI5YmxCb3hBdm8vT2ZYeVlNS25ERUVYNkRFbG5RODhRc0QwR1pXbDFw?=
 =?utf-8?B?a1lNbmRkTjM2d1R3S2JOSjM0dnplZHF4MnJaZkVvVHRJKzJ1QkgvYk9jMHdz?=
 =?utf-8?B?Tk9tSUJiS2xmb1RiVGI2U3BDaXk5UDFXeGRDcTdnZEp4UXBGc0taRm5IRkNw?=
 =?utf-8?B?b0Z6emlOS2E1eHBxU2h1emRCbDlnTTN2aU1Dc245MVFCYkl0VTR3YmdsVkwz?=
 =?utf-8?B?c25PcEpMcThZZHI5dzNiQXIyQ3AyN0VSeXZxY1FuQm1Kb295dk5YWUlsMmdE?=
 =?utf-8?B?elIrOGFCeHhFNWZ2M1FtR3E1aW1IbTlzLzZWYTdwRnhiOThuREZRemlLSnli?=
 =?utf-8?B?TjdpaHNURFZBR1o0Vm1nVHQ4eUt4RTNJeGJ6WWZYTWpRdEhuSDRlOG9uRWJq?=
 =?utf-8?B?Tzhkc0xGY21mRVhQN1RyM0c5QXF5RWRIZE51OXBZZzhzajc0NjROUzdSVVYv?=
 =?utf-8?B?VitZSWxPSkpWRUZMZVNGZkdQUDlCN3hYZkNnbkQ4dzRvUU1lNERYMnBzRFVn?=
 =?utf-8?B?cEFYMStGTWNPTWpGNnVEY1JYaUdsRUphaEJ6RGFnaEtROTh6YWpHRlpYMGJQ?=
 =?utf-8?B?aDhwTzU1WUFBVzRkcTE4b0kyWkQyQ2laZGVhL3Y3Q014UWRseUtJMGJvT3JJ?=
 =?utf-8?B?ZXByTVJhU3lmSFp0STlFOHdXdGtXaVk3TGNCT21MQXo5S3hoanZzVGNGTTdF?=
 =?utf-8?B?YXFGVkpvS3cveGJHVlF3YUREWUpxN2RCWXVsaXNNcStGRDlBTU5BUUVXVTZ0?=
 =?utf-8?B?VVI1WFN1NmRjYTlGOG1LUzc5ajhNSDBhYUtSSXFSMjBaa0tMTjBiZFY5Yytr?=
 =?utf-8?B?cDNXdXVKLzRRaWpLWDA5UXArekNyZWhoZUpEL1FEeFJBRXBEVUVRVWFMVUNF?=
 =?utf-8?B?UkcrTFBSSS9jSk9TN1RFdm0wbGo0R29WNURWdHJoelFnTFpGZ01udHQvU1BL?=
 =?utf-8?B?N01TOHlGNW14UHlrRytpMGQ3MGNyR1pXVTY0cWIyUWMwMFZ1emFESHB2Yk1X?=
 =?utf-8?B?SDVlNXBhNmlqSWZHeU4rdXdWSy8vRGNnWDJtZS9TRHFESVhuNlN0WFFrOWdW?=
 =?utf-8?B?NU00MEJjWDFpcStvaURCM0s5ZVVPUlhTUkFlNTNzMGVZOUxHZXRTVlAydS9R?=
 =?utf-8?B?d3dwRFl2aWd0OTRSSHJ0YTl4V0x6QmowUkwzMTZpUkhEN0lMSUFrb0UvOGxC?=
 =?utf-8?B?am8vcnE5U05zc0R5UmczRm5naVU4RmtqNmlKU3lmVGtYUlRLTFI1eDUyaUlM?=
 =?utf-8?B?VnlmMDZPZzlGS1FhVjVJZlpwU3FUTVlNSk5ndEZ0VittR2wxSXRZa01MQVpr?=
 =?utf-8?B?TWFWcmo1cUxvVXNjTVdmc3ljYXRnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad4f21f-22e7-4f1b-b61d-08dddfa2f3e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 04:35:12.7419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WW13SLZKFGLM6yt4fpU7reMdrgkcYEXFPQTUWwtp4A0U0pVeN+pZG0TQhVaIU56yp+aE4N4GBO1I0vEFBTyWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787

On Monday, July 14, 2025 5:22=E2=80=AFPM Svyatoslav Ryhel wrote:
> Prepare soctherm fuse calibration for Tegra114 support.

Please describe the changes that are needed for Tegra114 in the commit=20
message.

>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/thermal/tegra/soctherm-fuse.c     | 33 ++++++++++++++++-------
>  drivers/thermal/tegra/soctherm.h          | 13 ++++++++-
>  drivers/thermal/tegra/tegra124-soctherm.c |  8 ++++++
>  drivers/thermal/tegra/tegra132-soctherm.c |  8 ++++++
>  drivers/thermal/tegra/tegra210-soctherm.c |  8 ++++++
>  5 files changed, 59 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm-fuse.c
> b/drivers/thermal/tegra/soctherm-fuse.c index 190f95280e0b..3b808c4521b8
> 100644
> --- a/drivers/thermal/tegra/soctherm-fuse.c
> +++ b/drivers/thermal/tegra/soctherm-fuse.c
> @@ -9,15 +9,10 @@
>=20
>  #include "soctherm.h"
>=20
> -#define NOMINAL_CALIB_FT			105
> -#define NOMINAL_CALIB_CP			25
> -
>  #define FUSE_TSENSOR_CALIB_CP_TS_BASE_MASK	0x1fff
>  #define FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK	(0x1fff << 13)
>  #define FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT	13
>=20
> -#define FUSE_TSENSOR_COMMON			0x180
> -
>  /*
>   * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
>   *    3                   2                   1                   0
> @@ -44,6 +39,13 @@
>   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>   * |---------------------------------------------------| SHIFT_CP  |
>   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + *
> + * Tegra11x: Layout of bits in FUSE_TSENSOR_COMMON aka FUSE_VSENSOR_CALI=
B:

Let's just call it Tegra114. I see 'Tegra12x' is used above. You can change=
=20
that to 'Tegra124/Tegra132' while at it. The 'NNx' numbering is something=20
leaking from (old) downstream code that we're trying to avoid.

> + *    3                   2                   1                   0
> + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + * | SHFT_FT |       BASE_FT       | SHIFT_CP  |      BASE_CP      |
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>   */

Based on these diagrams, the size of e.g. SHIFT_FT has not changed between =
the=20
chip generations. I checked old downstream code, where

  #define FUSE_SHIFT_FT_BITS      5

Below, we have

  shifted_ft =3D sign_extend32(shifted_ft, 4);

However, sign_extend32 calculates as '31 - x' whereas the downstream code d=
oes=20
'32 - x'. So it appears to me that the size hasn't changed between the chip=
s=20
and hence we don't need the added parameterization? Same might apply to oth=
er=20
fields in the calibration data.

>=20
>  #define CALIB_COEFFICIENT 1000000LL
> @@ -77,7 +79,7 @@ int tegra_calc_shared_calib(const struct
> tegra_soctherm_fuse *tfuse, s32 shifted_cp, shifted_ft;
>  	int err;
>=20
> -	err =3D tegra_fuse_readl(FUSE_TSENSOR_COMMON, &val);
> +	err =3D tegra_fuse_readl(tfuse->fuse_common_reg, &val);
>  	if (err)
>  		return err;
>=20
> @@ -88,7 +90,7 @@ int tegra_calc_shared_calib(const struct
> tegra_soctherm_fuse *tfuse,
>=20
>  	shifted_ft =3D (val & tfuse->fuse_shift_ft_mask) >>
>  		     tfuse->fuse_shift_ft_shift;
> -	shifted_ft =3D sign_extend32(shifted_ft, 4);
> +	shifted_ft =3D sign_extend32(shifted_ft, tfuse->fuse_shift_ft_bits);
>=20
>  	if (tfuse->fuse_spare_realignment) {
>  		err =3D tegra_fuse_readl(tfuse->fuse_spare_realignment, &val);
> @@ -96,10 +98,21 @@ int tegra_calc_shared_calib(const struct
> tegra_soctherm_fuse *tfuse, return err;
>  	}
>=20
> -	shifted_cp =3D sign_extend32(val, 5);
> +	shifted_cp =3D (val & tfuse->fuse_shift_cp_mask) >>
> +		     tfuse->fuse_shift_cp_shift;
> +	shifted_cp =3D sign_extend32(val, tfuse->fuse_shift_cp_bits);
>=20
> -	shared->actual_temp_cp =3D 2 * NOMINAL_CALIB_CP + shifted_cp;
> -	shared->actual_temp_ft =3D 2 * NOMINAL_CALIB_FT + shifted_ft;
> +	shared->actual_temp_cp =3D 2 * tfuse->nominal_calib_cp + shifted_cp;
> +	shared->actual_temp_ft =3D 2 * tfuse->nominal_calib_ft + shifted_ft;
> +
> +	/*
> +	 * Tegra114 provides fuse thermal corrections in 0.5C while expected
> +	 * precision should be 1C
> +	 */

If Tegra114 is lower precision, should this say it provides corrections in =
1C=20
while newer chips are 0.5C?

> +	if (tfuse->lower_precision) {
> +		shared->actual_temp_cp /=3D 2;
> +		shared->actual_temp_ft /=3D 2;
> +	}
>=20
>  	return 0;
>  }
> diff --git a/drivers/thermal/tegra/soctherm.h
> b/drivers/thermal/tegra/soctherm.h index 70501e73d586..6c0e0cc594a5 10064=
4
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -56,6 +56,13 @@
>  #define SENSOR_TEMP2_MEM_TEMP_MASK		(0xffff << 16)
>  #define SENSOR_TEMP2_PLLX_TEMP_MASK		0xffff
>=20
> +#define NOMINAL_CALIB_FT			105
> +#define T114X_CALIB_FT				90
> +#define NOMINAL_CALIB_CP			25

I would either just hardcode these values in the chip-specific files, or

#define TEGRA114_NOMINAL_CALIB_FT ...
#define TEGRA124_NOMINAL_CALIB_FT ...
#define TEGRA114_NOMINAL_CALIB_CP ...

> +
> +#define FUSE_VSENSOR_CALIB			0x08c
> +#define FUSE_TSENSOR_COMMON			0x180
> +
>  /**
>   * struct tegra_tsensor_group - SOC_THERM sensor group data
>   * @name: short name of the temperature sensor group
> @@ -109,9 +116,13 @@ struct tsensor_group_thermtrips {
>=20
>  struct tegra_soctherm_fuse {
>  	u32 fuse_base_cp_mask, fuse_base_cp_shift;
> +	u32 fuse_shift_cp_mask, fuse_shift_cp_shift;
>  	u32 fuse_base_ft_mask, fuse_base_ft_shift;
>  	u32 fuse_shift_ft_mask, fuse_shift_ft_shift;
> -	u32 fuse_spare_realignment;
> +	u32 fuse_shift_cp_bits, fuse_shift_ft_bits;
> +	u32 fuse_common_reg, fuse_spare_realignment;
> +	u32 nominal_calib_cp, nominal_calib_ft;
> +	bool lower_precision;
>  };
>=20
>  struct tsensor_shared_calib {
> diff --git a/drivers/thermal/tegra/tegra124-soctherm.c
> b/drivers/thermal/tegra/tegra124-soctherm.c index
> 20ad27f4d1a1..dd4dd7e9014d 100644
> --- a/drivers/thermal/tegra/tegra124-soctherm.c
> +++ b/drivers/thermal/tegra/tegra124-soctherm.c
> @@ -200,11 +200,19 @@ static const struct tegra_tsensor tegra124_tsensors=
[]
> =3D { static const struct tegra_soctherm_fuse tegra124_soctherm_fuse =3D =
{
> .fuse_base_cp_mask =3D 0x3ff,
>  	.fuse_base_cp_shift =3D 0,
> +	.fuse_shift_cp_mask =3D 0x1f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 10,
>  	.fuse_base_ft_shift =3D 10,
>  	.fuse_shift_ft_mask =3D 0x1f << 21,
>  	.fuse_shift_ft_shift =3D 21,
> +	.fuse_shift_cp_bits =3D 5,
> +	.fuse_shift_ft_bits =3D 4,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0x1fc,
> +	.nominal_calib_cp =3D NOMINAL_CALIB_CP,
> +	.nominal_calib_ft =3D NOMINAL_CALIB_FT,
> +	.lower_precision =3D false,
>  };
>=20
>  const struct tegra_soctherm_soc tegra124_soctherm =3D {
> diff --git a/drivers/thermal/tegra/tegra132-soctherm.c
> b/drivers/thermal/tegra/tegra132-soctherm.c index
> b76308fdad9e..926836426688 100644
> --- a/drivers/thermal/tegra/tegra132-soctherm.c
> +++ b/drivers/thermal/tegra/tegra132-soctherm.c
> @@ -200,11 +200,19 @@ static struct tegra_tsensor tegra132_tsensors[] =3D=
 {
>  static const struct tegra_soctherm_fuse tegra132_soctherm_fuse =3D {
>  	.fuse_base_cp_mask =3D 0x3ff,
>  	.fuse_base_cp_shift =3D 0,
> +	.fuse_shift_cp_mask =3D 0x1f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 10,
>  	.fuse_base_ft_shift =3D 10,
>  	.fuse_shift_ft_mask =3D 0x1f << 21,
>  	.fuse_shift_ft_shift =3D 21,
> +	.fuse_shift_cp_bits =3D 5,
> +	.fuse_shift_ft_bits =3D 4,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0x1fc,
> +	.nominal_calib_cp =3D NOMINAL_CALIB_CP,
> +	.nominal_calib_ft =3D NOMINAL_CALIB_FT,
> +	.lower_precision =3D false,
>  };
>=20
>  const struct tegra_soctherm_soc tegra132_soctherm =3D {
> diff --git a/drivers/thermal/tegra/tegra210-soctherm.c
> b/drivers/thermal/tegra/tegra210-soctherm.c index
> d0ff793f18c5..2877a7b43f2a 100644
> --- a/drivers/thermal/tegra/tegra210-soctherm.c
> +++ b/drivers/thermal/tegra/tegra210-soctherm.c
> @@ -201,11 +201,19 @@ static const struct tegra_tsensor tegra210_tsensors=
[]
> =3D { static const struct tegra_soctherm_fuse tegra210_soctherm_fuse =3D =
{
> .fuse_base_cp_mask =3D 0x3ff << 11,
>  	.fuse_base_cp_shift =3D 11,
> +	.fuse_shift_cp_mask =3D 0x1f,
> +	.fuse_shift_cp_shift =3D 0,
>  	.fuse_base_ft_mask =3D 0x7ff << 21,
>  	.fuse_base_ft_shift =3D 21,
>  	.fuse_shift_ft_mask =3D 0x1f << 6,
>  	.fuse_shift_ft_shift =3D 6,
> +	.fuse_shift_cp_bits =3D 5,
> +	.fuse_shift_ft_bits =3D 4,
> +	.fuse_common_reg =3D FUSE_TSENSOR_COMMON,
>  	.fuse_spare_realignment =3D 0,
> +	.nominal_calib_cp =3D NOMINAL_CALIB_CP,
> +	.nominal_calib_ft =3D NOMINAL_CALIB_FT,
> +	.lower_precision =3D false,
>  };
>=20
>  static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] =3D=
 {





