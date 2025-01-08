Return-Path: <linux-pm+bounces-20069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82E5A051D1
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 05:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395CE3A1674
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 04:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F61991CA;
	Wed,  8 Jan 2025 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r2fFTab3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F420B20;
	Wed,  8 Jan 2025 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736309053; cv=fail; b=KL7NMpVcW2B9vTKiw7uBONi3qLxlG5IkXHRmUlJRawmqu4nEWOqM6Y4t1qAUzgq1lUtRH3VJ/ThtKpnEC5cD7e7ZxDYelq58emdcRGrG7S6+yaznhm21kYiz2TRsS5gTZ/1cFhUGvd4AOWGLop+hBvJBtYOdQ3FE+avOXuYtwdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736309053; c=relaxed/simple;
	bh=zFCRJPHiRV7I22AnPTYVdrZ5+g8KWg9aqFWORN/9nqM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HnfWVMOXdOuxX0N9iMCfHwSGr4Jm34kTKF34/fg62Exi9+JBACJClnUwU3u/pW+kroBZZc7GIbhv/Wj6Ne9ksm7f99Bpua4axoGCVPzaO/oQ2S3FXfrH0fSvgPGZVtKhhmyA2t4/lvyRBiM1pmhYLVggN3dXV1iUwPBsbSquehY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r2fFTab3; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoK5BlRDUq6FdHAZkZ8uXu7sDlgxtwVBK66rPhE6iPTxJKvwtnAJ6AAew6IHi+5M6sow/UzSg4DnUGykQZY/yZO6LfsM77pw0cLISmXMsh+/ry1cCulTcar0QfUfHIv9XVPe1bcfUIJYiBpFsCUjBsmIiG6X/pkN7gStEjVyI5VKaNPIjW0rhkJT6OvXVDRczx3eU1dRAtZSzVFX+ygI9DhdCiy9fIj5zjK6UQlvxXH0t7ATfDk5lmbht0laLuRMwwYuj7aAMDfwFCG1Kh+Q27WPNyQ2uEN+x0oaFRLL8nOkh+2ypeYMCRNoUkaT6SkzmfRyeOAxteqpRryTOSAzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpsOSbdXruqO4xjxruoyl0933i0gB2VXfJNI6OvsdQk=;
 b=yxHwiErEhnNFeTTWUpEHpmud1C3vOqHbtl1IzTKcRgShHu2CnQhFfpY1uuuWnNc3Ca7H3Gqzt9QpIt5HWHajNcpN+0TyNfBnO0L+C82JN+Pp+/b4Tthk/w6iQRQ1Cx23TWvHIbU2BhG8/WM3SpnB/RaGUEhC4rv3JNtq1d1MKe51DwXBBd8uhmUVEjvKhd/5anCEeI4S+YhyEEyiKwXtMptv9Cx06e2W7oGGfMlMzB44T830izFJgFRkdr4iQu0hjZKm0CNvGDae3E5ZtouUkIeQCJ9rDQ5C8xkqBkQIhVV1c6QSfuMMdq2INj27PGMbtroVzTrYXgVEf/qZtvrJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpsOSbdXruqO4xjxruoyl0933i0gB2VXfJNI6OvsdQk=;
 b=r2fFTab3DsDaQeLqR4mZuEKnRnuQo577/l2SdHrW0V65EhKQtOyU1iBj7GNvya3QoHxgfpiVB1r5ATj6aivXgruZZ8TpNwI+V2Grkf0c+uXwsOdQTiqqpqRtr4jYKZ+8rnda6kvI6CRwbCGXbpnJO8Ju0DX3PPidJPKNR9oV/i8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 04:04:05 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 04:04:05 +0000
Message-ID: <0d8bfa42-8155-4b12-ad33-ab76c4e78a88@amd.com>
Date: Wed, 8 Jan 2025 09:33:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241219192144.2744863-1-naresh.solanki@9elements.com>
 <Z2ULvwb1hePiDmwj@BLRRASHENOY1.amd.com>
 <057d8f01-c1ee-428c-8c19-80edcf9017bd@amd.com>
 <c8b2d107-e7a3-47c0-afe8-1c256e0fb1e7@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <c8b2d107-e7a3-47c0-afe8-1c256e0fb1e7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::6) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b898370-2665-43bd-f1db-08dd2f997e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0dlalVhRCtYSExtUUZyNThsMGVQUmkwc1pKZFk1WTh1UmF0QUFYZzhpNmtY?=
 =?utf-8?B?L2FhNmVheSszOFVpK0NlWGYzNm5LNFJDVlRiS3VTTkFGYVMrVjZ6c0daOU8w?=
 =?utf-8?B?YTRRSWJTTlNuK1dVcFU4bktVTHRISWZUYkhzcXB6d3pSajB6ZlJQSXdEMU1h?=
 =?utf-8?B?cTBYdS9KTWFya0ZXMnlCbzByRCtXUUxCcldtSm5OYk1na1dkZ0xuSTZjSCsx?=
 =?utf-8?B?NGd0VW1saGtUR0NXaW04UWh1M1pFQVh3SS9RdXorMTZXbWlLMlBJK2lDU2dT?=
 =?utf-8?B?bEVrN2VwSHZsYVVOMWhKMnBncFZmbTh1MzFUUHl1M09ocW9xR3hHMzdJN3Uz?=
 =?utf-8?B?cjFmSndmMFpsc3JOTWJ5cm5pbmNxNkM4VmRvMk1mM2Q2czRkMlM3U2RLMEVV?=
 =?utf-8?B?M2Qrcjl6NVJFYVRzZEZYeUVQZWNnSFFVQ1BGL3k1RTdMRHkxUWVXNkdhTXFE?=
 =?utf-8?B?Y29UdWpCLzRvZERmaWhpV29aS0thMUExQkZ0anBRdVZOeHk1QTNpRUcwcFpj?=
 =?utf-8?B?RnlDK2ZqZElreGV1Nmd4VkttMEM5eFkzc1lySnZDQ3dnQU5YVlcyaCt2NUx0?=
 =?utf-8?B?a0FVVWVaYmQ4WnU2WDBRTENab2t3VUZtb0Z0S0RnNjRzdnQ4bHRsNjRiRnFu?=
 =?utf-8?B?QjcxdTZrNHYwa2VLSDhXY0lKb05kM2xnNHViODJ3K3lxeDMwRW1Yak4wMlds?=
 =?utf-8?B?bXJXWi81cFRDQTFoTU5QR0RVN2pwWUlucXF1SG01Vno0ZFdzVEp0T3hEb2J6?=
 =?utf-8?B?WTMxYUJmeWJmWVNIbGl5M1MwZTd4TGJZeVVWZGU4TGlFNWFKUE90UjRqRnlv?=
 =?utf-8?B?U2MrUEl4clN3OUdqVFFOd2VRRkFBWjVxQ2J0K0pjZmZ0eUlJVFVieWpPMWpT?=
 =?utf-8?B?VVZ3aGJFQU1BenNkS0Izb1V3dUZtWGRsM29ERHcvejhsZ3ZGNmNDQzVzaXcx?=
 =?utf-8?B?cTgxbnduelNxeEUzdG1vYmt4WGw3NTVIUnRRazlDd3hWRm1SN2Qrd2gvdWs3?=
 =?utf-8?B?NTZUK2V3WnoyWmh5WkcyME0waE9HRGMxdHNBNkZhOGtoL3lHSVh1aXZmQUd6?=
 =?utf-8?B?NWpEMlRNWmlFOFVheGVWeTZ2UGZLcERzREhjYk9DQ2dVaFNTMS9LRzdzZ1BI?=
 =?utf-8?B?TURrZDVVV3ZnWE9HVXhsbCttNnpCdHQzdUV1RnF1bmR3QTUzV2NWY09qY1d0?=
 =?utf-8?B?M3VGN3pzWllLWHRMeHo2K2tYSTgvMUJscTg4R3hGVWRlYlBwMnNMZXZPdjV2?=
 =?utf-8?B?WXNNTmRtc2hWWXluRDd2cW1oRDRMMG9RNmoyeG9wZ2FpS0xKaTFUbzI2SXMv?=
 =?utf-8?B?bkN4OTlGRzhjdHBmQjRHSlQ4RndxZk82aDJyNk1VZGxaRFE3aUQ4UVVLWGtL?=
 =?utf-8?B?SHo0eGt0RGdMMm1xUmQ1SEZGZmhGc1ArRWcyeS9TSEtRbnR4cjJVYTdiVmNj?=
 =?utf-8?B?dWpnNk0zMEJpMGNuM1RSM1kvOTFYa2NPY1FrbHVSbEtqaEd2amxBMzlJL0J3?=
 =?utf-8?B?SitXU2pMdGZBSFBoSUhrandEQ1ByUFQzN3hsRzNrdHhlTDdpU2Rzam5LaHZp?=
 =?utf-8?B?dmo2elVNTEFzOHpUWXNYR0pqVGFuOElxVXRLdTRnN2xPcm40Y01LODNpWUJK?=
 =?utf-8?B?eC8wRDNLN1dTd2FJR1pYeUtyNFhPV0FmNTBLcThBM0E2YnE4ZldLMElzNEM2?=
 =?utf-8?B?MXdrRmRwT0xLdVFTRllkQlk3ekIxdlNybU9PNDlKSnZTOGIzWHo1aW8xNElE?=
 =?utf-8?B?eGZqb0UyaklDdy8xM3RzM3U4b2FRbjYyZ1YwZ25GNWE4RW56WGc2Q2J1enM3?=
 =?utf-8?B?dTdOUFU4dnAyV2hUb0FMUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QytEbUZIRTlob2gxcXdzaU5ZZ3gwQUdzd0dWQURaOWNVcUFMSVluTFVVclNn?=
 =?utf-8?B?clBjRFNhWlE5ZXN6VTZMc2JOc0J1NnU2dUNLT0dhaks5ckZJeUFrM0xsVjFi?=
 =?utf-8?B?d1BLaTRKUkZ4ZGhDZ01kT1ZHRkxhN3RUQWtIenV3cXhvbnRPaG1xQUZUYzhK?=
 =?utf-8?B?c2ZwVWcxeUlQRlZXNC9iU1lhekY2MnhPeStzdzh2eHV3NzhBZXd6Vit3K0Ra?=
 =?utf-8?B?Z0h3U0VrRE5lTnZKOHo4dVZoanY5ZGRFeit0ekZRVy9xNlBpb3JadDl3d3Br?=
 =?utf-8?B?endObkI4aW1mOTFXeXUvWFM4Lzg5NmMwWG5jdXNvLzZnMkRZRlNldFhvKzRG?=
 =?utf-8?B?ZTYxaHhTV3llaUlWcTVlUlBHT09sZEp6OVpXMVQyVEd0SVJpMGF0Z1lHSFVh?=
 =?utf-8?B?cy81ZWwvV2g4SU9ZTDBrcHNSQlBXUUg4NXMzVnhGc1R0UU9lNEtXbW1RVHdz?=
 =?utf-8?B?WVhSTXA4dUJycGpQU1J1UE1td2xYaExKRmRNV2N2M2ZXRVlvZXNLd3FEWEJO?=
 =?utf-8?B?eUwvYjlCUHVMNldpQWFpdUdORmdWM1FGSHhGbDM4NThHNloxOEMycHJyYStE?=
 =?utf-8?B?Qmt2TGIvamU1bGlpUEw4Ti9XQ1Qzc1NYRlEwZHZSS2k5TU0zcnZVNXI5RkZl?=
 =?utf-8?B?NkhKK0FpeHZacDJyOGs5VzFLay8yYkExVnV1U3VEQmZJdnhhblMyazNNZVMy?=
 =?utf-8?B?UGNnRkFSNG9VeVhMY3hvQmNIcmp5REQ4ZVdDR0xaQWwvMUNsL2RMOWgzUXlM?=
 =?utf-8?B?d3ZSY0hMa2tPY3RBVk0wMVptRkNPOXc3bU9aZUtTTmFkbGlhOTFTUUs4UFEw?=
 =?utf-8?B?dXY0eitHZ0xkM1Z0WFdtTk1JckNQT0tmTG9kV0xGVVVWTEJJK2NraGlOOHhD?=
 =?utf-8?B?cGdwWFRvQmsyTWxGS3hEUUVlajRRN2QrT0FWOTZ4TWl4TkJpSzl1Y3ZvZDl5?=
 =?utf-8?B?Mi9XbSt0dU9McW5zMFh6TFdRUXpmRTJEZFdFM3FHaFM3NFZCK2VTS2pPOUtp?=
 =?utf-8?B?MTlNd0p5c2d1ays5YmtFQlhSelBmSEdsV1dGUllHRWE3c2xnUzRmZ3BNbXh1?=
 =?utf-8?B?dWQ5dnRkN0RoSmNoTlFWZ3pRSnNRSzh1VWJhZURLSzUwQ3VodlkxTE5HU25Y?=
 =?utf-8?B?OVhrL2JBd1pGK1owOU5ua2FjODdFNkNiL0t0bzVDd1hnY2czemY1RU4yRTFG?=
 =?utf-8?B?SWtKdkx1QjN2all5Q212UFd4dExmOXptbzQyUDVKUUY0QXQ0c0l4QlpYVHIv?=
 =?utf-8?B?MlhRNmt6NTJLUEwvNlRQN2VSOURrODA4YnBQUm5jb09YV1dMTGZ3MUJaVThw?=
 =?utf-8?B?RkRqanptb1k3azNOWlo0YXN2ZmthbHlNc3lOM1pEUGVRTXRrYUoyemZWZmNH?=
 =?utf-8?B?STB2a2E0SlpsUTJnelM3WGNORGZDSm4wNTlhbjM1a3l2c0szOW9BT1pzVWpz?=
 =?utf-8?B?Y1BNRHZFY1JTOHZkdW9LRjgrbFgzMnZsQngvTFNpdnNseGl4Z2JnV2JyU0JE?=
 =?utf-8?B?YVFDZzA4T0phM0QvemNIOGpFanhnYnN6K1U3LzBrdWdxejN0MEluY3lFRy9w?=
 =?utf-8?B?UmwzOUw3UlRQaGlYMmVQeG1veHU1NzVVNXJicUtQWWZWclc5amovSWp4dXJB?=
 =?utf-8?B?Z3d3RHZOSkdJY2lUTHQxYU5lQVpyTkNib3BwaGtNTlF2U2ZoVER3QTYxNEMw?=
 =?utf-8?B?TUhqWndDWVRJUkZ4SWNyQlpMVm53S3FFcDk5RGpzMDVvUnFvU3ozcitFbkpS?=
 =?utf-8?B?ZjdCTFAzZnFKNTNFbmhqZVBvZ29UcXl2WGxiTzBwTGpIMXBUNFVwaEJiaDNq?=
 =?utf-8?B?aUhiSmZiaUxiWi9yeXB2eHVmaE9yUUh3cEphdUFzdHgxQm5rbFo3c0pBY2xS?=
 =?utf-8?B?YzdRa04wSUlvMm1KVitIT1liUWZFMFNXeDZMQk1OKzU3Y1VFMG5vaHlVZWxl?=
 =?utf-8?B?TVZXdlN3cDlDQmR2VlBsc1RvdmV1bnJUalVwM0FBSmNBWVJIS20xZ3FUcGxl?=
 =?utf-8?B?MkQ1V0NSQ3ZMeDJ3aFF3K2JmSVRSeHAvd3NaaTMzYVV5ekQyV2xsQXk4Ump3?=
 =?utf-8?B?ZGlBS0FiSThrc0ZqS0VWQzUzb3paYnl1cDRxMWNQVTY0dG9vZnpUc2dCRDFE?=
 =?utf-8?Q?QZluXmRp/p3WhFIiq3j7jNWWF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b898370-2665-43bd-f1db-08dd2f997e23
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 04:04:05.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nleg8sp5OmOXwz/8YTxLIp69DnA09thLIPutk/qjqaa+fuuLTFnFYkdgReqYAtKc4Y5AkI8IxKv1cABhIRBQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317

On 1/8/2025 12:36 AM, Mario Limonciello wrote:
> On 12/26/2024 23:49, Dhananjay Ugwekar wrote:
>> On 12/20/2024 11:46 AM, Gautham R. Shenoy wrote:
>>> On Fri, Dec 20, 2024 at 12:51:43AM +0530, Naresh Solanki wrote:
>>>> The previous approach introduced roundoff errors during division when
>>>> calculating the boost ratio. This, in turn, affected the maximum
>>>> frequency calculation, often resulting in reporting lower frequency
>>>> values.
>>>>
>>>> For example, on the Glinda SoC based board with the following
>>>> parameters:
>>>>
>>>> max_perf = 208
>>>> nominal_perf = 100
>>>> nominal_freq = 2600 MHz
>>>>
>>>> The Linux kernel previously calculated the frequency as:
>>>> freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
>>>> freq = 5405 MHz  // Integer arithmetic.
>>>>
>>>> With the updated formula:
>>>> freq = (max_perf * nominal_freq) / nominal_perf
>>>> freq = 5408 MHz
>>>>
>>>> This change ensures more accurate frequency calculations by eliminating
>>>> unnecessary shifts and divisions, thereby improving precision.
>>>>
>>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>>>
>>>> Changes in V2:
>>>> 1. Rebase on superm1.git/linux-next branch
>>>> ---
>>>>   drivers/cpufreq/amd-pstate.c | 9 ++++-----
>>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index d7b1de97727a..02a851f93fd6 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>>>   {
>>>>       int ret;
>>>>       u32 min_freq, max_freq;
>>>> -    u32 nominal_perf, nominal_freq;
>>>> +    u32 highest_perf, nominal_perf, nominal_freq;
>>>>       u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
>>>> -    u32 boost_ratio, lowest_nonlinear_ratio;
>>>> +    u32 lowest_nonlinear_ratio;
>>>>       struct cppc_perf_caps cppc_perf;
>>>>         ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>>> @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>>>       else
>>>>           nominal_freq = cppc_perf.nominal_freq;
>>>>   +    highest_perf = READ_ONCE(cpudata->highest_perf);
>>>>       nominal_perf = READ_ONCE(cpudata->nominal_perf);
>>>> -
>>>> -    boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>>>> -    max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
>>>
>>>
>>> The patch looks obviously correct to me. And the suggested method
>>> would work because nominal_freq is larger than the nominal_perf and
>>> thus scaling is really necessary.
>>>
>>> Besides, before this patch, there was another obvious issue that we
>>> were computing the boost_ratio when we should have been computing the
>>> ratio of nominal_freq and nominal_perf and then multiplied this with
>>> max_perf without losing precision.
>>>
>>> This is just one instance, but it can be generalized so that any
>>> freq --> perf and perf --> freq can be computed without loss of precision.
>>>
>>> We need two things:
>>>
>>> 1. The mult_factor should be computed as a ratio of nominal_freq and
>>> nominal_perf (and vice versa) as they are always known.
>>>
>>> 2. Use DIV64_U64_ROUND_UP instead of div64() which rounds up instead of rounding down.
>>>
>>> So if we have the shifts defined as follows:
>>>
>>> #define PERF_SHIFT   12UL //shift used for freq --> perf conversion
>>> #define FREQ_SHIFT   10UL //shift used for perf --> freq conversion.
>>>
>>> And in amd_pstate_init_freq() code, we initialize the two global variables:
>>>
>>> u64 freq_mult_factor = DIV64_U64_ROUND_UP(nominal_freq  << FREQ_SHIFT, nominal_perf);
>>> u64 perf_mult_factor = DIV64_U64_ROUND_UP(nominal_perf  << PERF_SHIFT, nominal_freq);
>>
>> I like this approach, but can we assume the nominal freq/perf values to be the same for
>> all CPUs, otherwise we would need to make these factors a per-CPU or per-domain(where
>> all CPUs within a "domain" have the same nominal_freq/perf). At which point the benefit
>> of caching these ratios might diminish.
>>
>> Thoughts, Gautham, Mario?
> 
> No; in this day of heterogeneous designs I don't think that you can make that assumption, so yes if we had helpers they would have to apply to a group of CPUs, and I agree at that point the caching isn't very beneficial anymore.
> 
> If the main argument is to make it easier to follow we could have some macros though?

Agreed, I'm working on the helper functions patchset, will post it shortly.

> 
>>
>> Thanks,
>> Dhananjay
>>
>>>
>>> .. and have a couple of helper functions:
>>>
>>> /* perf to freq conversion */
>>> static inline unsigned int perf_to_freq(perf)
>>> {
>>>     return (perf * freq_mult_factor) >> FREQ_SHIFT;
>>> }
>>>
>>>
>>> /* freq to perf conversion */
>>> static inline unsigned int freq_to_perf(freq)
>>> {
>>>     return (freq * perf_mult_factor) >> PERF_SHIFT;
>>> }
>>>
>>>
>>>> +    max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
>>>
>>> Then,
>>>          max_freq = perf_to_freq(highest_perf);
>>>     min_freq = perf_to_freq(lowest_non_linear_perf);
>>>
>>>
>>> and so on.
>>>
>>> This should just work.
>>>
>>>
>>>>         lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>>>>       lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>>>> -- 
>>>
>>> -- 
>>> Thanks and Regards
>>> gautham.
>>
> 


