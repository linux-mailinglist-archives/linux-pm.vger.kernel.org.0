Return-Path: <linux-pm+bounces-22865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FFA4345E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 05:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21381898D81
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA8254858;
	Tue, 25 Feb 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uke8Q4Yi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF6634;
	Tue, 25 Feb 2025 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740459037; cv=fail; b=Q4ufGW3TlmVdYKuHyoru1gfgs1hWvdMY6d8x3iHsS9VeD2DXaDcF9M7O5JnwivKhx3IpiCjncxVhRfqgJ35CJ/47PtOkS+5yrB6eXiZHzS7ASQzn7ol04RVFp0Mgbmo9P4Li69NAspBHvXNXB1ZZ280J+AhQNbaDa3NCVQRtcs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740459037; c=relaxed/simple;
	bh=hWf+aKjY/8Ncwh+H6NhiucGqkDXuvO79ezvYJ4q0Mk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ndt+ulao3ROwOS4vCAUtKodQEq1O6wpSg+Vx+UktIiaLAp5YWkB69vygng/lAyZYG+nMFipym2jlFnyoI0PRgiQYorX1FoNIj0GX88/e4zGjYamKHqvVNN6jAxeMmkgn/Sk7UEcQHCyciH3jKq92JGlp1rWGIrebrK15SAg1+zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uke8Q4Yi; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSwoM8ajrOnSWzjAuCeGIfVHk7bLSpBEidZJcCX0otz1aOFMPVdO+O50BDfJixwH7+dmdfuVznKnLRy3yr/eYjDkV10dS1chxcNGyMUuDF6jyyTohqPa1lQ3dz8OFSC4W8LvlFN2xuuSKNIPGw3fGhIRZejo3DiZaYEwXbzmS+86KH9C+0wN69h3hlBi9WxtyVky/p/80B64vZwiPpIh5UfOF6Cj4hdBwg7gAR8SrxH57mMQEA2CDM6Rvqphw029qhghsb21B5QEzjwiDfoSYuaCJLQpigfZcq1wI+RelVO9IK8Ll1bO8zpCfB1xEBs6xnHnwvqbMe7BCH219dhhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3DX4nnTrbKzPGIlH6naPmAH2W3fyO6ZZpOxntNQGKU=;
 b=j8ORuElEiYozmUEzTIRfYAhnMu13/LGTPm4GK6Oro0I9a86UqFrRdvIACco8k0/YM+DaLP+MYz31BFuqJaN1ARsyuzlgej4hlVILQyzGoLa+dbc4wgzT9mQkuCFPoo8JkL+oeUjZ+85dK/6FtPMOEteTh9uhct7hS1L6xc9fC7JD7A2HyUiREsoy82p3hvGXcCF6GXogO/jdZW91oHRkJSOU0RJFHpIWgPEsHHaf2u2YaEH5kWppctnOeGVtuPTfjGgpCx4MZTQ/+R/OdJZvBu5VwmKU7GOgEJ1ZBv6oV3JHZXBV1EyjHTgRrEAZDz3Vnjr17TJnh1GdEeNizn1wLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3DX4nnTrbKzPGIlH6naPmAH2W3fyO6ZZpOxntNQGKU=;
 b=Uke8Q4YidgmBg3WiZiTHDWIXUPCjGcYSE4nnmojuMd2AkWGnKolGDymZ6oCG4tqCa8MsjvY/vjg/P3HG/tyhIFsIKMZFNCZQaFlu8gB6gB3bMyOQn5kwVQU3KL3ywwiVCDuuy5/Soe3Y4qsGFFtwldw4dcTAS7wVfXk+uc+e0YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 04:50:30 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8466.015; Tue, 25 Feb 2025
 04:50:30 +0000
Message-ID: <d52622c3-e750-4147-a03d-fa19c397d347@amd.com>
Date: Tue, 25 Feb 2025 10:20:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/19] cpufreq/amd-pstate: Rework CPPC enabling
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250219210302.442954-1-superm1@kernel.org>
 <20250219210302.442954-18-superm1@kernel.org>
 <59c1fb63-1342-4aed-8b4d-f07c263cc74f@amd.com>
 <767f4c49-7183-4aef-940f-3a811319eb11@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <767f4c49-7183-4aef-940f-3a811319eb11@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::10) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b412b8-bac8-4a27-a7df-08dd5557ee17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWFPUnVJUXc4SXRPQ0xGRm1KQTJ3d2FhRmRMdE5xdFRCNjJCRG0wU2ZyYnRu?=
 =?utf-8?B?RXJVY1Faeks0bmRKN3Fud2o5Umh2UlJxaVB1QXEwMUc3R3RtNVg3MWRvTGYr?=
 =?utf-8?B?Y21zVXFDRzFGbnBjYmYzQjErZ01oMzA3YVFZMXcwU0IwQnB6Z2tPUEw2cHpZ?=
 =?utf-8?B?SUU2eHRmdENra0IvbGJtbktOcXlCZEtxR21IS05sM0I2ZXg5QitEdzJQc2Zj?=
 =?utf-8?B?TG5Fek40WmFsUHVBMXdWSFdGYWxHWERyaEFEVWxaeHZNZlhsRlZ1RVhtRmR1?=
 =?utf-8?B?dXdHVmtGZStyYmdhUFVTemJFYXRhY0tidC9qbzRlNWZBbk5Oczc2ZWZqZ0o4?=
 =?utf-8?B?SHIrSmtvL3NYWm85K0NpbURvS1lnZUtSREkrbWoxTU90MTFvdVlMVS9YVVNH?=
 =?utf-8?B?WVJ1RVJPQnVtZ1FCb01CcXRhcit5cTRYdUpVeEJjQlR2bmMxMlFKOEZCVEtG?=
 =?utf-8?B?TDJpMGFRcjhMc2NkTE1WeUtwMldRbkt1cmd2MlF6MTV6bG96Y3UzVGwrRkI4?=
 =?utf-8?B?VE10YnBvbVVuc0k0ajNZQ3FRUXE0U293MUszNHdwM09DdmJVdXdsNWdsbkpn?=
 =?utf-8?B?Tmw4d1VHT3FaM2t2S2swQjBVVDZERk1QY09Ydno1NEFjZ1pRVjV6c0syakZv?=
 =?utf-8?B?NGFLNzExY091L0hqeUJuTXFCY0E4eXdQWjBNTXlXM3NCUUpQU0VwWGVXTXdB?=
 =?utf-8?B?TW5obGdCVG9ZU2c5WjRTeTJZUU90UzFVaDBzamNGN3J4Vmpvd0lscis1N3pT?=
 =?utf-8?B?cVRCVVArR2NXV3dmbWpHUm1lZi9WaU5xbUMyQ2EyQUVTV0VsL2IrcC9ySlJr?=
 =?utf-8?B?WkNieks3bkZIbTIvSFViN2w4SU1PUndnRWJzZGo0UmpyK1JrdzhOaXBZbDcv?=
 =?utf-8?B?dUlJWCthTUdQdlhka1A1ZWlUaER1Mm9qaG5MQkhzaS9vWE1IUlpMVHNNMm5h?=
 =?utf-8?B?MDJNU3IzbGJ6OWxtbW9WajZZL29GQTFpMUhFUUpXeTJiWklDc1Uxd1l3ZDd4?=
 =?utf-8?B?VHdUYnJtT1g0U1RGeFpJa0RUckhPWWVHeCtWUXhDTWZwN3ltUThnRjJIOGJD?=
 =?utf-8?B?dk1Zc085RW8xRHFHK2VGSjFBaFRHeHVpZE1CSm5aRVJTZVZyYVNEWWNsd1cy?=
 =?utf-8?B?eTluKzQyT1VYcGZrQTcwUSsrcWwvYUlhNkdCcGVNeFNyeXNuZUdVeTkyblpU?=
 =?utf-8?B?d2lSOFpCZk5WWnR4bEd4U3cyVXV0akx5OEo4V0toanpNalNNaEt0MXRhTnJt?=
 =?utf-8?B?K3N0MksrQkhpUlZOcnBoQTBPNU5JQ05NcXpZNmltVnNGRmU0cHY2SjFpM1Ny?=
 =?utf-8?B?aW12QStxTk1RR2FBc3NkQXIxY0tyWUVsaG9rb2hqODVnZVhIK3F0U2d1YU5j?=
 =?utf-8?B?VWlnTHNvUHFqbFZjZmJzM2piSENXMlltRVFPYmZ6OGR3S2JEWU5XaUhhYVdG?=
 =?utf-8?B?R2RHMjZRcFhXZy92WXc3MnNTR0R6VzFqRWRFWGFIMXFrajNwMk5xVkJNbi82?=
 =?utf-8?B?TjhYbGNMb2t6Vklhb3RVNEhNcUZxai93K01pRHpZdlIraEVhSzlVUG9KbUpE?=
 =?utf-8?B?ZEtSWjllRmh4dGlpR3gwTUYrY2xteWJ2RVNmSFd1UkJjMzRPWkZzcjBidk5U?=
 =?utf-8?B?UDRCOXY4ZWdoWDdiNDV4bldaWXExOEMxVG8yODdVSmpXVWpEVDN2T01RRkRT?=
 =?utf-8?B?Y0NGcUhTWDJOK3U0dnZDVmNNSXdIa3VLaHMwTlNrd0FCblFXbHp0N3cvUjU3?=
 =?utf-8?B?OVNIL2FsRnhtWnM1RjMxTTVRUUpWR3U0TWxpdUc5cldPNmxjVVYxNklHbFcr?=
 =?utf-8?B?UFYzTFR5M2NFa0FocUdJQmpLcGpLTlIwZm5VaWpodFFXRXE1Z2ZIZmF0cjZH?=
 =?utf-8?Q?ztnPzLfWg3Yu3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFJka1ZXUC8rdElYckdMdWFxeFdWWFJVVHNWTGVXcFRjZ3VMN1NlS05nVHdG?=
 =?utf-8?B?c24yNjJiS3BVL0NCWVdsQUdHN2FTZ3hTZkdrUnljK2hNalhzTndubGNPNjJ1?=
 =?utf-8?B?VmxMSkdWQTlJaFJYcGswdXl4UllVVnMwVTgvYXhtUFYycUxKdGhaUGlzZjR1?=
 =?utf-8?B?TUwxZzJzL1RGS0FvM0M4UDh2QURleTZFbkVHNzl6bm15VGpuTEdZS0plYW9a?=
 =?utf-8?B?Z1BhNlBDalZDME02dEJteXR6Z0crQkNuMlZOMEMzdUNDZWdvVHU5cXZma0xJ?=
 =?utf-8?B?WnR5TllkNGFPZzNRQkkzYzlOb1NXZ0pUMFVEN3dOemx2K0Q0bVNWWU02dnp0?=
 =?utf-8?B?TVkzaWpMWVBzWkJKZzI1dkxmY0UwbHdIOUNiTEdDc3VDTk5QOEtwWXdsNjU2?=
 =?utf-8?B?bE5tMzZiZ0VsRndFcXdxRE5UdVVkSWhEYjE5UHFFVDdzRWgvOFZSZHh1YlZy?=
 =?utf-8?B?aTJTVVFheXVBNXI2WFdldkZPbzBsR2Q1QncvQ3NRMXkvV2ZyTXVvQzkySklT?=
 =?utf-8?B?cEovS1JKenM0L0J2ckh5bVkxT3hXZG9ETFkvckZvQXFTSHlZYlhJeXhrMkxh?=
 =?utf-8?B?TnlJbjRjUEJodFlqSUNkbHRLNWVVbTNOWldWZ3ZiUVpqRUUrZEtzOE50enQr?=
 =?utf-8?B?VUE5bENTeVkzcW1oemFTY1pENS9YTzVqUXBHeEZpUFBEVWpyWXc3U1JTUk1u?=
 =?utf-8?B?Wm50ZFdVRnFRMVZEZ0ltMjNrZ2h5ZnBQTkxOMUlzYjVxS2pCQzJuQlFycXIw?=
 =?utf-8?B?SWNGWnZtb3NoTk5WRkFjSnVVLzRqRmJMMElmUDZFQVVERWpxWGlXRGVIRWlj?=
 =?utf-8?B?Z0I5VnEzaUx6bUVSSEw0WnNZZmg2QnBRZDZFT0hFUEZEU0dTL0luSUtvMXpz?=
 =?utf-8?B?M2x5a2MrRDExaHNjR2EzL1BDMlFEVk9xQkRKZm9RVnExMnpqVUx3aTUycXo5?=
 =?utf-8?B?Zlh3SkM0Y0c5elQxci9BeWlTRHo5Vm5aZlMzWVV1UDQvd0w5bWI4Q21YZEcy?=
 =?utf-8?B?SDQvdlRVdnBBWldocHMyVFgzKytJVmpLSGw5eVphVTkzQ2dqbnV1K2pUaDlE?=
 =?utf-8?B?V1RBelV4cDdTMWc0WHhzRWNwYU9DWXBNSUFRaVY5T1ptamtRU0U0V0xsSWU1?=
 =?utf-8?B?UWZCTk1RZklaaVByRS81b0k4ZU9wSUlFbEVGcnRMQjNjZnVnVkcwUzQybE0v?=
 =?utf-8?B?QmNrUmlwbHBCS1VsQ1ZYdG1yaWxCTkZMVHNYUTVmMXJWTHUxUHRCbWhoajlv?=
 =?utf-8?B?bzArRTVMM2NCM0VLOCswNmVaVmt1MWJTSE45M0pPWGVQS3ptTWZHL1hxZFhP?=
 =?utf-8?B?ZzNhMHpQeVQrV3NnQlZ6a3FONE9WaDRyQW9ZNnBsWXNIenBBeDUzZk41ZHNI?=
 =?utf-8?B?bUVOYi8ra3FLZ1RhUVF5bVJHbjlYcG9lSFV2MzBLL3hEK01vRmZYSnlCNE41?=
 =?utf-8?B?UGNxNE9ybzhMczZOeUFCeE5rNzQzTWNGclByMXZ6T0hGY24xcjZWTVFpai9M?=
 =?utf-8?B?RzMzRUlTRmY0RDhpREFRbzRrQ2VKN3dOeEtpaVNYMGVPLytxWVgydnhOZnR3?=
 =?utf-8?B?K0RiZGJYUkpWL2hJcE1aQU9STlQ4UTNsVnBJYWlzVEJtK0k3akRlZnFqT1M0?=
 =?utf-8?B?bUZIaXJ5WTcvSjFneVJWVkt3NmxUblVqRmRsSjdjMHNtcUkzUzFqUDNsa1l5?=
 =?utf-8?B?RjhCcjltNmNZUFNUU3ZjR3BpeElCWDJjRW56czRGRjZtTHlGNjUxWXZrTkFO?=
 =?utf-8?B?S3lVcS8raTVNdHpjcDhvTWhnTGw1Um83Z0JXRXFOS2NmRFQ4WlJpdGRQcXFR?=
 =?utf-8?B?OURPNkg4bEppTmduWEljMGVNTHcrTEhVNGhSaitMYTlCanAwYmJpUjJxWlBW?=
 =?utf-8?B?TnpHNU1NY3NZSm9acjI1MXZuQ0xjNkFWV2oyYVNIYnh5MHRxZkpONHMzTFJq?=
 =?utf-8?B?Q1J0bU9yenhQVTN0UkY3MnBrMXVRbHMxZDVuU0NxbSswbzRLNmVXa3RHZm1Y?=
 =?utf-8?B?TFV5TVV0NGRhRk04T2k3L2JxeFg1dC83dFRuMXJjaFBOMVBpQzFhMmF0LzJY?=
 =?utf-8?B?dnJjUG9PZkNxc1A4ZXFzNXAxUTdVckZDc0hOV1RTMXk2N0JGWWxZc2t0TklU?=
 =?utf-8?Q?72AjDhA1ZDfYOj40VpnyXUadY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b412b8-bac8-4a27-a7df-08dd5557ee17
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 04:50:30.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyUdqpU8AZ1L7GIdKWK0xeyFN6i3SHRQL+25N0kHxFsisVeiYfqV687iR0hd+Yce2mj3IyUCVBgEDK3T8iAnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235

On 2/25/2025 5:29 AM, Mario Limonciello wrote:
>>> +    /* Enable autonomous mode for EPP */
>>> +    if (cppc_state == AMD_PSTATE_ACTIVE) {
>>> +        /* Set desired perf as zero to allow EPP firmware control */
>>> +        perf_ctrls.desired_perf = 0;
>>> +        ret = cppc_set_perf(policy->cpu, &perf_ctrls);
>>
>> I'm thinking do we need this "setting of desired_perf" as a part of shmem_cppc_enable,
>> one thing is we're not doing it in the "msr_" counterpart
>> also, I guess this would be taken care as part of amd_pstate_epp_set_policy()->amd_pstate_epp_update_limit()->amd_pstate_update_perf()
> 
> Great point, agreed will drop it.
> 
>>
>>>       }
>>>   -    cppc_enabled = enable;
>>>       return ret;
>>>   }
>>>     DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>>>   -static inline int amd_pstate_cppc_enable(bool enable)
>>> +static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>>>   {
>>> -    return static_call(amd_pstate_cppc_enable)(enable);
>>> +    return static_call(amd_pstate_cppc_enable)(policy);
>>>   }
>>>     static int msr_init_perf(struct amd_cpudata *cpudata)
[Snip]
>>>   @@ -1649,31 +1591,21 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>>       return 0;
>>>   }
>>>   -static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>>> -{
>>> -    int ret;
>>> -
>>> -    ret = amd_pstate_cppc_enable(true);
>>> -    if (ret)
>>> -        pr_err("failed to enable amd pstate during resume, return %d\n", ret);
>>> -
>>> -
>>> -    return amd_pstate_epp_update_limit(policy);
>>> -}
>>> -
>>>   static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>>>   {
>>>       struct amd_cpudata *cpudata = policy->driver_data;
>>>       int ret;
>>>   -    pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>>> +    pr_debug("AMD CPU Core %d going online\n", policy->cpu);
>>>   -    ret = amd_pstate_epp_reenable(policy);
>>> +    ret = amd_pstate_cppc_enable(policy);
>>>       if (ret)
>>>           return ret;
>>> +
>>>       cpudata->suspended = false;
>>
>> Do we need this here?, shouldn't only resume() have this statement?
> 
> The reason I had in mind for it was this sequence:
> * Suspend
> * CPU goes offline
> * CPU goes online
> * Resume
> 
> But I don't think that's realistic even with parallel boot.  I will drop this.

Also I have one doubt, why do we need to keep track if the system is suspended ?

Won't the idle subsystem have safeguards to prevent CPU offline while the system 
is being suspended ? Haven't gone through that code, just checking if you have an 
idea about it.

