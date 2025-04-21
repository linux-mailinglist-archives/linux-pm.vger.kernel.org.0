Return-Path: <linux-pm+bounces-25805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1DFA954F5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 18:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3752F3AFCA3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8CA1DF977;
	Mon, 21 Apr 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="afphqLDs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE11519A6;
	Mon, 21 Apr 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254424; cv=fail; b=RDpp2DEGcHC071eOx0g5Bq4hTNJ5NCPUeycYcyOFaCWOXF8LVgdHwd2oVSVuOccgp+JWST0jS902htBG7n/nOR+CsRhjnk6glc0dmA2v1nfz7fsbBJHHvb2LzbsqPKpl6XAZP/zx5yg5ne3RAWVAAKt2Aw6Ri3qQwszNugSVk48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254424; c=relaxed/simple;
	bh=28LNU5Tx9mmukX6VN1gxt64MRhR2BLVlFwDcGUvAvl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ltdQVXcJ3AXOjaQY25uiPeS34TPTB3aBhm/MhSY+ogoMK+8bLt51yQm+LmWtJLy+SSMneXoxUxzFTNeopj8eqlxsBbVQ4nh6gm/iIB3bBzm+RfD4LIsvcHrzkP28+/EUps0euFvlaExqs7rADE8txslcFmt2jEyXKYj2yzQjb6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=afphqLDs; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0SulF1XhsFKN2PSguiLrgRJBoIaLEtXdXS09yZYW20H27tcyw6RjYFIt2uNMTTh+cpDaHf82qQdCRpf5/pCSC4579Lzcx9j9IPaaoEUMGWjUQNbliKlHLe5mTByXtg3vMLd04R8BNf02sFk5mA0eHR0EHUn8+CjxoVtVin2r3LCCXmTi7hh9468PLZM3G3zw3EbX5SP4fmsHoPTSSomx0DJOOQb/EABUl83P8RO61Zos+VTWMIhE/s1UrPhxZ0Gl73z1VIiEvMixTTFfWu2N3i+sNKpC2iZAeHNIYeQ17DJVjIZeIcpKo6onBkevKIAr6srRvQTJrafx47W5/aHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcWVwqygS0rgC5WVzUL47/ruHySQ60VWG/00/BLhFic=;
 b=xxOlyI3LwBuLzZRoW7zZNO6Ma03ilz52oWZbNaIBHw7X09vurIFKQCqvFxlKI9r3QdPBIzwwVEuxfRMLcCdqjLuRVRwc8JRtmQfda+ikbWXyH77fsmANv+oPe9BMULeMntscGpAK85uzb9H5BIPbuT6UDZ/m8xLrnbWyeTnxlrFK3NM1A9LeDTcZ3BsOY9Pk/M5lDYlDDzfGj0vALpn4gkFpLioFm09igYxk8m+oSuVkf8b7yzH/MGArNCDNn8oeki15WNLqRKjJVPTjY2kWkWsW9fkn5Hko0SyLWUsO4LWVos7IIOsnNF+tT2PVgECb2ai3fft8pVyJFUYAEKXSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcWVwqygS0rgC5WVzUL47/ruHySQ60VWG/00/BLhFic=;
 b=afphqLDs9qDCncfVSu1FXWv0hpafFZ9Vmbr3/OliJB7vzHarapYv7JOuS0uGpqRRoBwaIpPF15v1paM6P2qp8j4MrNkuYWFjKJQkbLBmvJxpRh3hPxoolZhE1iGJ1K1QCjSvWQQcMjLPSM3HVuyugwNQCkrEaHhfPF+XFmPxrJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 21 Apr
 2025 16:53:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:53:34 +0000
Message-ID: <eedfe953-7468-4b4c-934c-4589de601fa2@amd.com>
Date: Mon, 21 Apr 2025 11:53:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq/amd-pstate: Add support for the "Requested
 CPU Min frequency" BIOS option
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
 <20250421080444.707538-3-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250421080444.707538-3-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:806:23::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 405a471b-0933-4787-15bf-08dd80f50d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c09URmIwTnloSmJpbGJWVFhvWXVFK2NiSlZ1OVVBSzBLSUJrOGN2NVRzUEEw?=
 =?utf-8?B?WUtMMExHUU1hMmZPUDRPOG1yVWxjY3RHakNiY1BoVGRTeExudTRZRVk4VWxG?=
 =?utf-8?B?c3dWVFh5R3oyM285ZDV0RE9XSUkwMmxvTmdWYTFoT0F4d1hxL2xsUklKeXUz?=
 =?utf-8?B?NS9ERFF5d0FadHhEaEtTUW5uajNPT005cUpJcHRqdlBveGxyaCtwKzhyd2JM?=
 =?utf-8?B?SXI3MVhBalo3dU40eFNLUnhHOWZEMU03SmxVNGxIbFh0Z2RkN3dIQ0pTaVBD?=
 =?utf-8?B?UUY3SXNkbjF4VzB4U3Fuc3k2cEVYbWpRRmlTU3d2TXE3WHoxbk84NmdvWkZE?=
 =?utf-8?B?RFp6YVZYWGg1N1lINWJPWkJ2N1h3SU5za3pDRmVYcmcxSEZwTndLWVlyd2Ev?=
 =?utf-8?B?T0lkV25sa2FqWUVGS1JtMEx5c05tVElIYk0rNWRFSXQ0emowWWJ2M2FrQ3dN?=
 =?utf-8?B?UmJtRUZ0Z2NmdWNneWVKTjhta2hQNFM1U0xTeVZvVk5XWVl3ZlFkSEhlQ01X?=
 =?utf-8?B?T2t1MW5SL1BqeGR4VFBiK215OU5DbnRZQi9hbVlGeDlOaUl3dWwwRm8yS0h2?=
 =?utf-8?B?Mjc3RjAzaFk0QmlUWjNxQWk3UnhNeUh1eFBrdU93MWxLWHNhQW9INUhFRFEr?=
 =?utf-8?B?L0RNbXp1TE8rRlJSUWQrSjNRcGVvTlNmR1B3RXR3Zjk2NCtocnZ1bVNVQ21I?=
 =?utf-8?B?OFo5MXJWQ1lMbnI5djJMb1AvdGcwZUxGZktuOUVpaFZpWHpTSld1eUJwcXdB?=
 =?utf-8?B?NyttcVlUTmRrY0d6d0JXRDcxV1hMcU1BZk9EOGNGSEFGc1NmNlFsdWp4Y2sy?=
 =?utf-8?B?N2dGcHJtMk1ERUJyUWg0ZjkwZktMSVFXYmMrQjhFNVE1MmplYjdpK0tFMkZX?=
 =?utf-8?B?NXRkOUx1TG5aSzQ0SXhVYjg2ZVdXaVBwc1pBRHRTM1lpZ2Y4am00TVdsWkxm?=
 =?utf-8?B?aTAzUlREdWgwYmFQcS9NcHM3LytiRzNwMWJqMXdacHNXZWx6TFRTZzM5NnJD?=
 =?utf-8?B?VEF1N1hnN1c5eEtpYnQ3Qm16cG5yWUt1bXF5ZFM0U1RvTS9qOU5MWlhvQW9E?=
 =?utf-8?B?aHN3TzVmV1BLUC9UYzljaFBWTG9YM1hCMXZtQ0xTOVM0VHYrSWZ2VGk2M3Fo?=
 =?utf-8?B?emhtanN5NVNBaVhETDlwNy9wNWQwMjhtUXRZMEw5VmJlVGhWMWpwYmZMMHoy?=
 =?utf-8?B?S1NYWmI5L0JySEpFT0E5bTdpdm9CSEh0NlFMVFdTcUpIeDh0OVdWb253dGpW?=
 =?utf-8?B?ZWM0TlZyQTRxYVZtQXA2QzE1UjRsUS90ZFJ0bldwSFNNZldpN1EyZVhCVURx?=
 =?utf-8?B?YksyM0UyQkozY2ZpbSsrSEpYTmZXZUNwRlRDYkRBY1FqdHNvMEZrZDJDNWNE?=
 =?utf-8?B?WWdibjJlTjUzWCtjbjV0bjdaZzF4RDNtVlBCYTNxWUprMGdDRlhPVDl4Tjlt?=
 =?utf-8?B?eWVkc0taa01rTFRlQzRyNVBBb05JR2hKM2pjTW9nS2NONmhCWWQ1MjF4bG04?=
 =?utf-8?B?c05vNGFINjgyaWhYZ0RBcHVsb2JLTFN5ZVpmTGpINm8vV0R2bE1XaFk0emF4?=
 =?utf-8?B?bHlYTEFLSkloVHY5VEtzdVErWmFSTURiMklSVW1WZzRPTklXbk9vNGhpUWZv?=
 =?utf-8?B?UjZQbzB0SWwzcElycXl2bXQ1WUhneUZBUzZ0dVIvK0l5YlIwclBpVEhvaFNH?=
 =?utf-8?B?UlZsdlVEMnA1WENhMlJOdWxvdE0veVNEVDVPYXp2alNPN0tiRXAzMDhIdTlS?=
 =?utf-8?B?K3p6QWZUb3VYOEZQL3Yrek5QSFpVNkkyZlJBdWROUk1HZGxYelZRS3pXb0xF?=
 =?utf-8?B?VjRERFZUalFVbmQ5aTVSbWFyOThoLzIyZkN0dEZIQVZoZlFmdGxZanRYZUV4?=
 =?utf-8?B?d2FmNlhnZmFTQlpEYVhYOXF6akpGdmV1S25MTlFDMFhxWkpJSFZVQnJnbDBK?=
 =?utf-8?Q?EwwHteUMLu0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjRzRCtTREVkN1IrTDNLOFpMRHNMVXd5blNZWTB4T2dGZ1NLMFRqYlpxTzdn?=
 =?utf-8?B?T1ZZODRLakx4enZFWmkvWWlZcEFBVi9CSTNrS056OUxndjFJSGJCRDZmRHVP?=
 =?utf-8?B?WXR4dUEydm5JYk1aVW9YRXo4d01lM2hIUVNYSGRpbmNScHBMM0xsd0kwZllE?=
 =?utf-8?B?R2o5MEh4cDBaMFhBYnJIWFhQLzJWYmZHT2FLYm1zZ0syR0xyOTNWQ1diS2E5?=
 =?utf-8?B?dEVmTHR1cWpMVEZoWVZESXNNQ21WMCt1bjRNSFpDK09NLzJRVjJqYmRUQUtG?=
 =?utf-8?B?Y3F0V0pXNjVJQWFxeGE3MGtFamtOaGhlMm1FZUMzWnNQZUdHdE5qczQ2NEdN?=
 =?utf-8?B?d1Q2aWZBL0wrYU5ZeXQ4ODJYMi85UHE5MUZrODg3UXlNRHk4cmEwOUpmQ3lk?=
 =?utf-8?B?UnpzenVrK1FuQ1BHNHc1SzhydWhzcER5N3dXT3pEdWNqTG5RamFqR29VdGpQ?=
 =?utf-8?B?VlBhTnBTWHJzcktzdDE1aHVDRGV1Qm1aeHl6dDlBbUtWZjFNWGw2NUU5T3R0?=
 =?utf-8?B?aVBqYk9vMGNXL2sxUmtOSndpYVpvSjBNNGI1OER0QkhRL3VlZ2d5bXlrNlZC?=
 =?utf-8?B?NzlHcDhBT3RZL3RkaTU3Q2NLcXVGanRLWXNTdFhGN2VuK09pVnRyOTNHSllk?=
 =?utf-8?B?eWNxV2Z2SURLRmJ1ZWlzZm1Hb3VlTldZM251UlZMZW1YMlp4cVRaVzVRSHNa?=
 =?utf-8?B?eXZzRTNRMW9VNCs1ZXllNVN4Ni81OG54T0NWVDN1MmlkWkJmR1k5TmVtRlVM?=
 =?utf-8?B?cnZDT25JU1hYcHE1VW51NytqeVNkU3RRRlNFUkRkVUtaVCs5NVZVbzBNVGlT?=
 =?utf-8?B?VGtRYmxSZ09wUEpVb1lBWW53K1hDdVJiUlhzRXlxcDRqNnZJcm0vMzZmc3kr?=
 =?utf-8?B?MGRSY29yaEFSdlEzdlVUaTRudzYrcHIzcmYvQmZrZlhZQTZpdm9MSXZ2WGIr?=
 =?utf-8?B?eHQzL283bFdjdTdOVWNEOWRIaFlsUGRYc3hsNlZqTDNjN3FVbFltcE1GQnMy?=
 =?utf-8?B?VkxocW9JTzREdFdtNTk3WnlTT1pHNWM1RXh0MElnTUxOOEErVFNSRy9JTkFF?=
 =?utf-8?B?bng4OHdJL1R1UFovS3laUWRSMThlZGl5SUNOMVdQdUZKYWltMldHUDFraVpF?=
 =?utf-8?B?MzdiWnZOMUt2ZC9Dc1lHTzhHVTZ3dDVjM2g4WjlTV1pGREdveWZLRlBmSTlH?=
 =?utf-8?B?VzJQZ1FxZWhpQUlha1pWdVF6S2RMSDdKOWlXWTlxSHh5bG44bXQydzBCc0Vh?=
 =?utf-8?B?QXBNamNseEo0bmNjYUxpM0k4Y2V2K3BPL3VtdFMrNUR1MitlMUJ5OUcyanAy?=
 =?utf-8?B?WEpvUW1nQzFwaEtmNjJuTUxZendTOHRmeXo0V1BpQXBPWGlhOXRSOGhMc3pN?=
 =?utf-8?B?TG5wRDMyZWJWWW9YVUhXV3JsdTZRczJGaWRvK1ZYNnBVN3RYTzBodW1helVz?=
 =?utf-8?B?QVNNb1Z4bGxycWk5dXowZGViTys4QWxuUDEyOFVpU2tyVUJVUUkvZktoaGZu?=
 =?utf-8?B?NkdpRmZvL0lGSnV1UXpGWlpySitINzEyQitId0owWit4NTRDbnY2VTZDRmpr?=
 =?utf-8?B?bXJtZnU0K25Sbmc3bU9uTlczZTlGVE03Z3pMdmUyUWZIOGI4MUoyYzlzOC8x?=
 =?utf-8?B?ZXNmWEZadVA3aVROWkNXM0w3cjdCUmpFalYxaW1MVHlRNGZCVkVxMERmS1FR?=
 =?utf-8?B?UWljeEVHaWNqek5IWFhma3VEVkh6Z3E3YkxrTkV0QzlXekhUa2tQUUQ5TXc5?=
 =?utf-8?B?NlhKczNnbkNqOENyYnBjQXIyckJ6SlFKVUlJdmZpUU5kWjRYa2Z6clBkY1B1?=
 =?utf-8?B?c0ZNNGhTb2ZTdC9DUWo2QU1saVhiak1yb0FicWRPKzRCUVlxbmk5RlpsZmxs?=
 =?utf-8?B?bnU4OFk5VXM4cXFaaGNTZXRUQWtOUitwQVptYXpKQU94bGdBUjByVjVPL21E?=
 =?utf-8?B?ek42TEtleXd3ZGhzTFFvTmJ4L3RtQ0I2TThUMU9rTjZaclVaQ2Z6bEx4cmhX?=
 =?utf-8?B?K1Y1ekNqVlM4TTU4Y3dPYm1GSkVEMDJ3MWlKMHY1Y3ZYTC9GSHBFRkRha00v?=
 =?utf-8?B?cFdubGlBdzI2NmRNVnl6cW1CQjhhQWpwS3JPWlFweGZVYjYrQ2YvZUJGRzds?=
 =?utf-8?Q?hdg9HUKQ8BnUx29i5RaQGhmL9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405a471b-0933-4787-15bf-08dd80f50d82
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 16:53:34.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrO0FtllUvw3vYSn+a7iH596xx/mK3jHvc4j5slV/okQ47gLeicCyoF+6+1DNo4g0tuplXH2fyGTu6EEPs54cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005

On 4/21/2025 3:04 AM, Dhananjay Ugwekar wrote:
> Initialize lower frequency limit to the "Requested CPU Min frequency"
> BIOS option (if it is set) value as part of the driver->init()
> callback. The BIOS specified value is passed by the PMFW as min_perf in
> CPPC_REQ MSR.
> 
> To ensure that we don't mistake a stale min_perf value in CPPC_REQ
> value as the "Requested CPU Min frequency" during a kexec wakeup, reset
> the CPPC_REQ.min_perf value back to the BIOS specified one in the offline,
> exit and suspend callbacks. amd_pstate_target() and
> amd_pstate_epp_update_limit() which are invoked as part of the resume()
> and online() callbacks will take care of restoring the CPPC_REQ back to
> the latest sane values.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
> Changes in v2:
> * Modify the condition in msr_init_perf to initialize perf.bios_min_perf
>    to 0 by default
> * Use READ_ONCE to read cpudata->perf in exit, suspend and offline
>    callbacks
> ---
>   drivers/cpufreq/amd-pstate.c | 67 +++++++++++++++++++++++++++++-------
>   drivers/cpufreq/amd-pstate.h |  2 ++
>   2 files changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 02de51001eba..407fdd31fb0b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -389,7 +389,8 @@ static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>   static int msr_init_perf(struct amd_cpudata *cpudata)
>   {
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
> -	u64 cap1, numerator;
> +	u64 cap1, numerator, cppc_req;
> +	u8 min_perf;
>   
>   	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>   				     &cap1);
> @@ -400,6 +401,22 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
> +	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
> +
> +	/*
> +	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
> +	 * indication that the min_perf value is the one specified through the BIOS option
> +	 */
> +	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
> +
> +	if (!cppc_req)
> +		perf.bios_min_perf = min_perf;
> +
>   	perf.highest_perf = numerator;
>   	perf.max_limit_perf = numerator;
>   	perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
> @@ -580,20 +597,26 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>   {
>   	/*
>   	 * Initialize lower frequency limit (i.e.policy->min) with
> -	 * lowest_nonlinear_frequency which is the most energy efficient
> -	 * frequency. Override the initial value set by cpufreq core and
> -	 * amd-pstate qos_requests.
> +	 * lowest_nonlinear_frequency or the min frequency (if) specified in BIOS,
> +	 * Override the initial value set by cpufreq core and amd-pstate qos_requests.
>   	 */
>   	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>   		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>   					      cpufreq_cpu_get(policy_data->cpu);
>   		struct amd_cpudata *cpudata;
> +		union perf_cached perf;
>   
>   		if (!policy)
>   			return -EINVAL;
>   
>   		cpudata = policy->driver_data;
> -		policy_data->min = cpudata->lowest_nonlinear_freq;
> +		perf = READ_ONCE(cpudata->perf);
> +
> +		if (perf.bios_min_perf)
> +			policy_data->min = perf_to_freq(perf, cpudata->nominal_freq,
> +							perf.bios_min_perf);
> +		else
> +			policy_data->min = cpudata->lowest_nonlinear_freq;
>   	}
>   
>   	cpufreq_verify_within_cpu_limits(policy_data);
> @@ -1040,6 +1063,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +	/* Reset CPPC_REQ MSR to the BIOS value */
> +	amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>   
>   	freq_qos_remove_request(&cpudata->req[1]);
>   	freq_qos_remove_request(&cpudata->req[0]);
> @@ -1428,7 +1455,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata;
>   	union perf_cached perf;
>   	struct device *dev;
> -	u64 value;
>   	int ret;
>   
>   	/*
> @@ -1493,12 +1519,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>   	}
>   
> -	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> -		if (ret)
> -			return ret;
> -		WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	}
>   	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>   	if (ret)
>   		return ret;
> @@ -1518,6 +1538,11 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	if (cpudata) {
> +		union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +		/* Reset CPPC_REQ MSR to the BIOS value */
> +		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
> +
>   		kfree(cpudata);
>   		policy->driver_data = NULL;
>   	}
> @@ -1575,12 +1600,28 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>   
>   static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>   {
> -	return 0;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +	/*
> +	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
> +	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
> +	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
> +	 */
> +	return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>   }
>   
>   static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +	/*
> +	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
> +	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
> +	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
> +	 */
> +	amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);

In EPP mode this appears it would be OK because the perf value should 
get reset in the resume for amd_pstate_epp_update_limit() but in passive 
mode won't this never get reset on resume from suspend?

>   
>   	/* invalidate to ensure it's rewritten during resume */
>   	cpudata->cppc_req_cached = 0;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index fbe1c08d3f06..2f7ae364d331 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -30,6 +30,7 @@
>    * @lowest_perf: the absolute lowest performance level of the processor
>    * @min_limit_perf: Cached value of the performance corresponding to policy->min
>    * @max_limit_perf: Cached value of the performance corresponding to policy->max
> + * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
>    */
>   union perf_cached {
>   	struct {
> @@ -39,6 +40,7 @@ union perf_cached {
>   		u8	lowest_perf;
>   		u8	min_limit_perf;
>   		u8	max_limit_perf;
> +		u8	bios_min_perf;
>   	};
>   	u64	val;
>   };


