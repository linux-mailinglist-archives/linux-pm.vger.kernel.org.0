Return-Path: <linux-pm+bounces-13705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6011796DDA6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF161F21053
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10019EEBA;
	Thu,  5 Sep 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jL1otPR2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FC19E7F0;
	Thu,  5 Sep 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549117; cv=fail; b=muCT/UaWB0a1gkWZN6iCAVWZHUEAIHI9W3HUHCNzSjzqucbxDcnKmcjoRZ8OUTJAJEV5AKD2eulBs9nGgZUOFHl1w40DEQwmqV5T1+FJQsiUeehhoU5X7u780JEkWot/hfFxfx53S0uQOwZisHWc4hqYywuqoJ/QsOlSdDmUbyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549117; c=relaxed/simple;
	bh=0gVo4UNZcpCKbZski+5z6VjyigmDzQBLT1YXZRE5f+8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QxGNk+IMrpPH/5blLMpCwyBpRX4IIiQ4diVHC9VXVx/yBYVcNIfnCFd7KBNo9m13AIDFJ5FnucN6dIL+WcR5IbesZJ3ZpMigRlvigVy9cAk8trbpDsh4z6d+DX+sWJz8AHzfjdduDC/wj6pCsYutY6vx/kz5iQq+ee6IHOLEadA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jL1otPR2; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Az421jFAivu4iyTkIN9hnU9D/52ZwJAUAYYL/aRX3GabLZqd5NjQ3JgQJ9Za6IIwdwGWKakfAv8pjRAgfjUP9BidqRntJvE1XvLMrspApPKa5SqZ9RalEqRsKH953lJK0CEPUh/uaUQoUJ98U9oecrSODYGwSG7aM0JZAdcDLhr+j2e3pj3/gSEdnRPhw8oVT9qWO8odmbIBhrUzeuItAVuTCQ06JW8gKPE5qytNY9o+iXLP2U5rfV6ju+4suPcwd9XbbpktEKSPZx8sTSzDeKDECbPu3bJxADpMlgTLOWVNb5Tn6ITR8Vk3+F2CtuQ2M03AqD5ltj6zbojXTGF6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLGHMdr9f6/ebT2Hl/HReMJJLTU6OClPV7UJLjj2BbI=;
 b=HI63T7QUwT04StsDOKe8EEXvzBPM5FK+Jp6ieTLMa9pEPyu5mgJG+iCT+P3kpBIdlPQBN7AmCxGtLi9d9jorfOs4KixUbYf1uY8NyZb8O9Ag93IDYtpW2fXi21wOdzwCxGSaMWg7p1rwM66hPfoyUqDXj63CGmdBJtU33w4Y7SaG0ew97f4+7fHxBZPwipcMlgSm8+8LxDf98e5TdNz6P6Mdm/h0vDDVQeC5CQkF0aEcZYLpNJj79XrUT/9ezyOzVaBYHI9xGO7Ts7gUJ7C5iUfV6ZRfCnkcglWwKDYmsmN+vdtDYb4ksPWRdy1QCE8ZdYpJ4qW19Km/eyk695RHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLGHMdr9f6/ebT2Hl/HReMJJLTU6OClPV7UJLjj2BbI=;
 b=jL1otPR2n1+8+t+MyTXy3cqfj/MIjf8cDo8cSnsfrYdjrQ4qU9OVtkIMFC8l2RZ/PkHDaoUSk3cMgiYf9WLHwyIrn6IGLtY2lOZ+JTpFbo8MK51W1bYstvWYgK8ZiKIGgNprKaB3nZG6wdffEdcHnA302+368xEB9+iddohpl/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 5 Sep
 2024 15:11:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:11:52 +0000
Message-ID: <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
Date: Thu, 5 Sep 2024 10:11:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/2] cpufreq/amd-pstate: Fix the
 scaling_max_freq setting on shared memory CPPC systems
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Jones, Morgan" <Morgan.Jones@viasat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Arcari <darcari@redhat.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "li.meng@amd.com" <li.meng@amd.com>, "ray.huang@amd.com" <ray.huang@amd.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
 <20240702081413.5688-3-Dhananjay.Ugwekar@amd.com>
 <bb09e7e8-5824-4bc1-9697-1929a4cf717e@amd.com>
 <d6392b1af4ab459195a1954e4e5ad87e@viasat.com>
 <bb49cd31-a02f-46f9-8757-554bd7783261@amd.com>
 <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
 <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
Content-Language: en-US
In-Reply-To: <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:806:121::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 6652827e-e943-41e8-6dfc-08dccdbd125a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzIxMnBWS3dmcUNwckFSS1dMakJFYU9qTGdEMm1vbHRPUGhXcFVDZVVOc001?=
 =?utf-8?B?QURKRTNDWnVlTUV3ejhVN0Ftc2JOLy9KK3BXdUxrSVlXQ3hmVGgvZVFjakcx?=
 =?utf-8?B?NzVHa0VnOVRzalZzTjBFZzJUT2hhZGk1em1OWHJyOUFacDRFVGEvcHVPQS84?=
 =?utf-8?B?MVZaS20wRnVJVzJQZDNTWWY4SVQvNVZMV000MlVkdE9KaEZZeC9jNk5ZTXFn?=
 =?utf-8?B?TlJ1SzM0Mmd4M1VXVlpHNlhMeVYvR2lWMFgzcXJ5SUZwNGZudng5eUJOKzY3?=
 =?utf-8?B?U3JlMDM0eitqLzNxSUM1dE5wUGR4NndqTXViR2I5SmlhOXlqUEI4SWZLNEtn?=
 =?utf-8?B?N29LWCtjU1ppWnNkSUFEMTN0UEhZMzBmSHlhWEJwSmQxVmhGOFNPY29ZMUZ5?=
 =?utf-8?B?dHUranl4RmhaOEE2dHprdjJGVWp1cVpZdCtxVmlHaXJzZE9jRDJaU1lQRENm?=
 =?utf-8?B?ZnlJbURKaHlSMUVzMk9hMnlrZysveWpZNUhmakVEZWxNazVJNHBSeDBYL1J4?=
 =?utf-8?B?a25qcUIxTS9QcEk5VVpTR1dFRGVsTVZBZW9PWkk4M3R6eFZhOThyZVg4MnJv?=
 =?utf-8?B?TEtpQTRqNkVsd1d1M1A3eEJ0QXJHRFR2ODN0MElzakRzSGg4RG1FMTl4Z2FX?=
 =?utf-8?B?Qnpwd0NQcDFrTUdRTHo0ZDFMV0tveXl2ZlllMG1XblZ3NkhlQTVRaTI1Mk9t?=
 =?utf-8?B?a0FJdHllUjlGZ1l2di9yaHVlZXZOa0pVQ2s4WmEwUDlhZGZTM1RvQ2FuQ0lj?=
 =?utf-8?B?S1VGek9mcnNVR2hFMVUzV1ZNcGZVcFhYdUJrNFJTRlFyN3Q1cXlxS3h3SUp0?=
 =?utf-8?B?SVdtTFBPSnN3ZTdZK1RYaTRSNk5NMGpZTFZ5Tk9WM1dnM2FQWlpRV1pPcUY1?=
 =?utf-8?B?UFRCNnVac29Vb1diOSsrR1ZUcXNMTTErMWxTWnY0VnFYRy9DTHhmTDl0Mzhr?=
 =?utf-8?B?dG1XdExKV1Q4R0dOUElCckNBbEFyaWxiU0RFTUorZXNwc21iZEp6S0o3a1JI?=
 =?utf-8?B?VUx2WmNEc3lYbDdpM0RwN05VTTdibkgrUk90c2FpUFE0SmRTMHFYWU4xeEN4?=
 =?utf-8?B?SlR4cjg5RlgzdzFmNk5sdUF5ajg1THhHamlPNFpITXJFbC9XYzJHTmhKMWpj?=
 =?utf-8?B?S1p5VFF6YnNqdWZLdjE5SjBMSHZmSWJkT1ljbm5qd1M1UUgwc3JnNGJITGtW?=
 =?utf-8?B?S1RwaStQNURaOTBLWGF2MWxLWGcxOHdUNU5Db0NqTTVRTktBTEVNV3RCNVZW?=
 =?utf-8?B?UnF5VlFUTWhZVmZJci9TckRmb2l3YmVOZExESVZhUHJSaVZEZ3U3OWNvOVpK?=
 =?utf-8?B?NDE3dkNoSTE0YmhlaVBHdDlSU1Y0ZDZJZ2txVkQrT050VUlZM1dMRmJ5ZnNz?=
 =?utf-8?B?VmlVQ3JOeWczWmEvSnowTE5kTHJlamZPN3d0dkFMeWw4SGtEVXgxWXAxSGJV?=
 =?utf-8?B?Szd1VFJBRlhNU2dkOGI2Y0g1THNyUlhiZjVXNjNJeEYyOFliZmpyOURHbzVu?=
 =?utf-8?B?ekJHSjZRUldlaCt2YnVwVTNhazQyQTJDeUEya0EraUpXTExvSXZQdWFLN2Nw?=
 =?utf-8?B?RlNXWVUzUWtONmtlcENGdERBMEFFM1VlUS9tNURiOThKWFdwZEdXL05OaVgy?=
 =?utf-8?B?N3hvWkRVQytNa1ZxL3Qzd2p1b0lhcTR2ZG92TWlPUzlBWGdOdXdjMmU2MG1w?=
 =?utf-8?B?ZVNSTXAxZGJNK3RZeWpOZG5MeVBwZmllVzdNQXE1SzgvVjN3WHBKemkrdDJL?=
 =?utf-8?B?a2Q2SGFHZGgxM1I2M2xLQlFJNi81TDJwRjVLRUd4TmJrMGczdGREbnJ1K3Ru?=
 =?utf-8?Q?6oJPYCsfE6DIiZq0queESXXW7blDqx+fiTJdc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVFlRDR6TGQycW5GdVZ5Tmh0L1ovTUs0c0dic21aRjZpdnh1TXlaeEhqRU42?=
 =?utf-8?B?Y21yOFRzZGVyZ3IzcGQ3RDU3aFZicE5XK1B6Ri84cWREMWRkV2ZkcVhrSjZv?=
 =?utf-8?B?QUdTcU1ZUXdYODVXTE1vaEFQU2NQaVNSSTJtZnhQbjNhdXRvaG9GU096NGtk?=
 =?utf-8?B?TjJkb0xwc1UwNVdjNW45aDdtdW1JeXY5bGd0eXRGcHJ3NHcxWUpENnJYVEVq?=
 =?utf-8?B?RXpkRldwQVRNRVhLZlh1YTdUU0YyVHdUUTZiTCtENzFwakZ3S1E1MEduSmR6?=
 =?utf-8?B?TVM5NmFqRFd2ZVFydTlpY2Y1cXp0aGZxNmF2ZEZaNDkyZEU2ZVdFSUdnVTVy?=
 =?utf-8?B?V1kwOFY1MGlnR3U3d25JQkQ0Q0E3U2dVcjYrZ0VmMEpDWndrdnVLcnh5Rm5p?=
 =?utf-8?B?dVhQVjdpYlRDSnA3Z2EvWURDdnhBQ0VHcjg2VjdEY1Njd21QTExpKzMrR2dP?=
 =?utf-8?B?L0xCbitQRmlTYXJ1WjRPM29iOVgwbFF5Zmh6M1p6RUIxVmhYVUdpV25WR1pz?=
 =?utf-8?B?STlvSE5Ka29SQVh5cG0ycGJWdlhFWnlydVhESUlQSEhGLy80MGFCenQ1Sjd0?=
 =?utf-8?B?dkV4dndtQlFFZ0tHYWQyMkdUV0lhdXRscW9aMkM2L3YvQitTYnFwRzdhQm9n?=
 =?utf-8?B?cGNySnhibXZnb3dTNmJKNURqd3ZzVHNDTU8zbm91aE00TjgzcHNGVEhWV0JK?=
 =?utf-8?B?a2ZLTXNqdlA2ZE9QSUgzYzN6Z2ZsVHB2ZWFqdXFlN2paQWpvZ1BwZWlURXU2?=
 =?utf-8?B?Y0Mya0NpZlNoMmdQdjI1OU1JUjNJUjZRSE9nVFYxaDJmK2lFR25KVVhjYVFr?=
 =?utf-8?B?Z0xwRnRnc2w2cEQ2Zi9TMXh6cElLSWx6TGFnci80UVMwK3hYRWpIQUdZZDRa?=
 =?utf-8?B?M1BHTFJPaXpoRlF1VGREU1JsaDFTSXEyNS9zMTMzcmxFS1lPNU40TWREQlpm?=
 =?utf-8?B?dXFmRTErOFAwMmtwY1E5MXpHSFdzWGdwTWY2TjNtSXJDSWJXVEJYc3Z0TnRo?=
 =?utf-8?B?VnZPajRjQUNKcS9wYjBIZEtNQ2lidWpPWjF5RHpJeE5zMmlhRExHV0s5V1JR?=
 =?utf-8?B?RGV4cjAwSVQ4MXVKTDNWc2ZwOUtUTWRwRURkalUvTHFlWFkwbjljejBNK2Vt?=
 =?utf-8?B?ZzBMUmJNNFFXdmRHWVE0UFVQVFl1YUFTZjQvY204OEpRRFNCNklzZmZYRldC?=
 =?utf-8?B?VXo1QlcvTG9LSW45RmRaWlkzbVpCclIxZFRFTUh1bjVIUWpQZnlwSm16cmlO?=
 =?utf-8?B?M3U3bm5EdFBCb3VKT08rNWxjT3NVc1R4REFuMFB5Y0ZRZGFSTS9oU2NDOHZL?=
 =?utf-8?B?K0U3Qm5sSFFETjhwdDJxT29HaTg2TndTWWVHTXF3RVI3UVBkZW15OUMyNFBC?=
 =?utf-8?B?M2RQdWhlUE53YnErcFhjS0FxWE16NUVTWXVJZ3RHNENQSzNwRUdOTTlRTkhs?=
 =?utf-8?B?NitNeDBaZUdWWExKNWJYNEdDRUNoRlBWNXg5QitMdXh6QWZFVDZzR3ZoYmQ4?=
 =?utf-8?B?VHgzNm9CczZFeGo4QVlIbjFuQ2p4V3BrWHdRczczRFo3MXJKeGF5bFBGQlN6?=
 =?utf-8?B?ODRtVlZ2ZG9KQUdFUzJ3V0U4K0tjQ2ErbmgwdUVVUXd6MkRKTjZFNDZFbldP?=
 =?utf-8?B?OUh0REFSNkpmcFAwVzdTTnZLbEVRajJ2dXFyWjMyOGR0UEhuazE3OXBKeEZS?=
 =?utf-8?B?TXpOUEhpR1RhTE9RdWFNUU83NXJJVHhtMkM5M0xRalQ0VWs3bUUxT2VVQ04z?=
 =?utf-8?B?QWZEanhEbTUxZ3BxdFNKdFhCM1VOcjZxdm1LZkNrZFFCMDFET21FTi9BbTI3?=
 =?utf-8?B?RElKOUdGRy93ZG8yVFlZK0NDZE02bzIzSWx2cDlmdElLcFRjTWVqdG9NRWdl?=
 =?utf-8?B?OFlzSEFsa1c4R3hjWGJXTGJSOG9KdzAyZHZIZXVFSWlTOUZIeUpidlU4d2xT?=
 =?utf-8?B?WjBrNCszZzF5SDFMbkZraTdIMERQUHJzYjRDLzMyRGtnM3RTejBVbmw3Q2Js?=
 =?utf-8?B?V1BvRmxpbzJsdmlxQVZCVG5naDJHdy9JeEZDRDU3MTdRdTVyWmZwcDRDQ2Rh?=
 =?utf-8?B?UXJZMStLMXhHWlhROW9CQnhvQy85Qkp4VDUxL1VYR3greE9uUmRMWE5PMzNx?=
 =?utf-8?Q?keCGUuihy9Aez/mIz5ojlbbVD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6652827e-e943-41e8-6dfc-08dccdbd125a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:11:52.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRRBycn+sa7zHBzgaPboi6RcVn9Oafizu4jsKztX3b7CXqKqmwhtVZez7/O91pIJCKSUhEFoniAbBEsA3QiNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293

Hi Morgan,

Please apply these 3 commits:

commit 12753d71e8c5 ("ACPI: CPPC: Add helper to get the highest 
performance value")
commit ed429c686b79 ("cpufreq: amd-pstate: Enable amd-pstate preferred 
core support")
commit 3d291fe47fe1 ("cpufreq: amd-pstate: fix the highest frequency 
issue which limits performance")

The first two should help your system, the third will prevent 
introducing a regression on a different one.

Assuming that works we should ask @stable to pull all 3 in to fix this 
regression.

Thanks,

On 9/4/2024 08:57, Mario Limonciello wrote:
> Morgan,
> 
> I was referring specfiically to the version that landed in Linus' tree:
> https://git.kernel.org/torvalds/c/8164f7433264
> 
> But yeah it's effectively the same thing.  In any case, it's not the 
> solution.
> 
> We had some internal discussion and suspect this is due to missing 
> prefcore patches in 6.6 as that feature landed in 6.9.  We'll try to 
> reproduce this on a Rome system and come back with our findings and 
> suggestions what to do.
> 
> Thanks,
> 


