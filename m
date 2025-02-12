Return-Path: <linux-pm+bounces-21921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C509A31D22
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 04:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AFA3A2BFC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 03:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7181DDA24;
	Wed, 12 Feb 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgZ2Y3U5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF5271838;
	Wed, 12 Feb 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332358; cv=fail; b=LxYBddPPceC3GtwcVU3Fs3+jlt0vXXTjMK13j4iz9wP6pabepPkZ5ilkHUwBJMO4H2PZIXtAOH+i6bUgWrJ9dW2//xEsa0HOZEU3oSuRLjMTv0TpDrKtw0WXNUKY6vdZ9NwydrJnYUwBR51Schqsl3Jg8QbL+QyKlJBrUMRFPP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332358; c=relaxed/simple;
	bh=y8ugVznMrt5Xg+PwxdBUlq/2f5p3ky9p7n6qGsfufFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YKxgG6p6/QyxMEslktwWi3tf0XbNR0jLYCnHuVDkNV/07L5iMWj9W6JuPBzvAORA9vp3H4iqVMb70uxKCtKRg53Xs0K0vXkj1HQNX56F8rUfiE4k+8ORi1j+HS6AlwxAtA5syEoj4mGPssurhI+zdo2JQ+Tj8NinlH6fUlw7pg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgZ2Y3U5; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtiZOHUL8HfbA5B5ii/cZpv4TWeA8+JreRq/IYWCMnx17gX7g9oPTNFDml9MWC7ZutK3g55fqBmrjWp/SIJ8lnarXd0yJ5fXnxU+SW6U/BkMkKo+tHsD8VfO7kE2d7mvkZUSDHE9FILoyZ8q2deffNngZv2b6xE595IjW4IzhcsqSX11BUr6xBiJVWWtRLXL99v1AuCN/BJEOxjB/5oXYYE8HPwiuBmjROLOym54luoFBXitK3AnwQo/meR9fn8bKx4WnWWovztX4+bzQarMUWIMYAQRTSJkynwGNyBpdjbtsaozodp0m8bNdiIL+5Ij1CuoI5BhCJT3c1N34JhD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hfr0aPsGZrXgLU1E63XW4U4MCYLfSbbzUw+vcHiwFl4=;
 b=HbbBcZ7lK+A7SdFewECBTjWOmGm1uJR9F5pNi7Pb568SFwITHAhSfp0GeJpnCqFqkXlUg20rTmk9E6/QCLMiCVqpacsEMiww1upOGJ/rgg0citpczuMK6VDlIZ1C+AKdGOuSZBWLYxnXVyz4SipveZPX/Do4knonGnAPrm82/2TP7yaBnJwyHr0YamVUnoe32L5tCTUSbBv5ON+57sqqPF8Lg/TXAajSlCjAPD5QQtTFs/oowgddX+3+EDZ3h2D5l10P9C+Ysu+3/D54TdA+pIWQxwOf/hixwdDtfpl+fHRnWayzbg5M221HKPRCJHa3gYWs3DRNtdbZctX79AA61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hfr0aPsGZrXgLU1E63XW4U4MCYLfSbbzUw+vcHiwFl4=;
 b=EgZ2Y3U5qBponlFkq/ALICYXxrx9gRLiI+F9H7rC5sLCaaNTGWJdAbtGvx749I1SCm19d4xne0Z9DSkM2ZF52gexF6Qo7fuvBvXs0CMDiohCVXJXmUjEaxMOzXwgmfcCioo9gwRZTdbyh05oAelY8Z/dpHBc1B7pYuJJrSOFizE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 03:52:33 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 03:52:33 +0000
Message-ID: <3bd7acde-a4ea-42d6-8e75-bf17e6a4f143@amd.com>
Date: Wed, 12 Feb 2025 09:22:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] cpufreq/amd-pstate: Cache a pointer to policy in
 cpudata
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-13-superm1@kernel.org>
 <a3d10f58-3d69-40e8-b0ea-53f4ed9ce31a@amd.com>
 <2877ad66-0148-483e-83b3-fab5da5dbe1f@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <2877ad66-0148-483e-83b3-fab5da5dbe1f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::8) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 5daebb63-ffce-4565-6962-08dd4b18ae2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXhtVC9XQ2EySDFVT3dLR0JVY3JTelcvb2JFenpIQjNCOHo2a1l2YmlESXZS?=
 =?utf-8?B?cFJITjlwQjdkNTlrUUVvdkVIdnlxbHJLMlhKMHVRdnJsb3RIQi9sUU5nb0Yx?=
 =?utf-8?B?cVJCbjd0bjJkNkZ6RmQ5NkNjMWVRanFGVTd2VTVsMk5YaW9QaUxtb3RORXpv?=
 =?utf-8?B?TFNVbDk4L1NZTlJPUmg2ZkhadEcxWHNxZi93THhFYXJCTGFnNVd2RTQvYjdt?=
 =?utf-8?B?U3hrT3c0MFpHbXRMODZYSEZaQThtNW5qY2huUFRpOFlxVDIydkFIc0lkV0lx?=
 =?utf-8?B?YkUwM2haQ3RZeHVmQkhyYjdiQWtyQ2Zla1VwYTZ3clVld0tlTGNCQlZEUzdR?=
 =?utf-8?B?T3VGSncwSUcxamdwcTUvWnphSmUweWgyeUVoM29qaVNyY2wySDU2WVhDbGhW?=
 =?utf-8?B?SnE4dEk0OWZFcFB4emhrR2lhOUlGdnVpNW92Qnc1R3lpOVJKazVSTU9FUTZZ?=
 =?utf-8?B?ZS9Fa2JiZVV4cjdSV21OT1dtcFN3RWFEeWhaNkQ3MHE3N0MycWQwV3FMVTVW?=
 =?utf-8?B?T1pBKzdTb2NZWEduYWdieDJBa1dmRWhrZHVpMEZVcmltQ1hhdFZEQ3NZeTJG?=
 =?utf-8?B?Q2dLVjIzbStyU2wxS0NpK09RWUl6ZDN3bFRlaXpYVFJUR3JTK3RMZVdoZDNG?=
 =?utf-8?B?K1lIVzZMdytqNlpoSThWZFVlNGw3SWdLcUVQRTJ6bWwyTExKbURiWGIzY3FQ?=
 =?utf-8?B?aGJqU0hhQkVIWFFvSTQ0S01zWis1a083WStTbi9aYmFFamFUd3U3RTJ2R05D?=
 =?utf-8?B?ZUh5RXlxZ0hVU1hRMDU4VGZWSlZleWxpSFVNM1ZYcVByc3NUK1pzU1lERGIz?=
 =?utf-8?B?UGNXMTlqcGhPK1lUMDEvRG1nUkg5Q1JpQjRCVldDbG5BVzQvN3NDckttaUZp?=
 =?utf-8?B?K20xRmE1V0VhQlNtMkV1dUxZNEtCY1ZKK2p3MkVlcTF1cnVCNlJaNXRCSUEx?=
 =?utf-8?B?a3Y1L1hRQkFqeGRVWmt6VWxKTHF0MWZ4TS91WG01ZFFmc0xyM2g3b1daSXFE?=
 =?utf-8?B?ekRTbTcwaTZVcytHVHVXMlEzY25RSEl4OGZubSs4N3BKWEtlbFJuZmZ2b0Q1?=
 =?utf-8?B?V2FnZXMwRVB3dnJqbThUVFptbi9memhHMlhwQ2cvK2hOL2pha2MxY2treU5F?=
 =?utf-8?B?WkpxYjkvVzBjdGZRZXljcG0vQWw1SHFiMWxiTTBlUExmdi9Bd1BIaTBEVE1a?=
 =?utf-8?B?SUVFQ3R4RlB1OWxQVDdSWHRVcGttbW1KMGZhQUw1VUtiVWRmRW5JRDRrY1hD?=
 =?utf-8?B?c203VDdZaS9rRmlJc1F3UWVFTXEvd2RRNzI1N3JVZDg3bDQxQ082SWttc2Ny?=
 =?utf-8?B?QXNVWUZrdzF0UkdIVWpoZ1VWOE9TOXV4K0Zld3pJNCszZklyOVYzWTIrZ0JO?=
 =?utf-8?B?TitkcDZiVGVjWUh1TUNnY0JpUEthazd0dndlQjdkM3VkYU5uUVJOcG1TNC84?=
 =?utf-8?B?ak4xenBxVHNpbWhCdzdzdzlmRFFpMFJDem1HYXBwa1RNUDRVMGRMNzJqNWVT?=
 =?utf-8?B?R3prZXEwMHMvUHRUV0tscTNFVUttT2d1WlpHQjJxWDloOUhvcnVnRnVwbEZn?=
 =?utf-8?B?L01mbFAxSWpwWHU4anZ3bksvbUpKR041UStNT2o2N2NyZW5jRXAwc0k0NjBS?=
 =?utf-8?B?MllZRzhHcklxQjlCeEhmTTBEa1U3aTNNSFlXajBIMlZqN3dKRGRFZWtNTU9x?=
 =?utf-8?B?M2xmMVVGNXk0MzQrc0hlcFhTbHNmZDNScjdRdjBpWC9wa3ljMmRuOURkOEJJ?=
 =?utf-8?B?T0gxVVNxbUhCNGVTdzFXeFNwVkR0V2FlVmhPWDZsZ2RDSFRPVHVBTWNKRHR1?=
 =?utf-8?B?aXNzUnF0ekFjSlVRMERmdmtIYnlkZWlvNkNUUkt1NnhjNm9DNGdRd25Mb01D?=
 =?utf-8?Q?KGbW/Syenz021?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3NURU1tUTNobTFXK3h1TVdoSERPRUZvVnJ0ZkNKbDlHa3d2cFVNWGVlbjIv?=
 =?utf-8?B?Um1vK3hJN2VzeFRGbkRkNHlZTjZxL0lNVldkTEdHT29rYnlTbC9qMXZwaU1z?=
 =?utf-8?B?WC9qRklxcVFqRi9YOFFlNlNJdTFQRWxwMXgwVGx3eW4xS2cwMGp5d2VmS0h4?=
 =?utf-8?B?Sm1TMUdZWDEvZHNCcVVhamRBTXRTZlU0d2VUZHZCbE5IcDIvUjBGOGFWTTZE?=
 =?utf-8?B?eFUwRC9Ca0l0UGtYWk5DdHB3SzdLWURrWHk0Rk04a2RPM0FtWHlrOS9oVnVI?=
 =?utf-8?B?YmQ2azdOMnprRXY0WnhJVlo4T3BPcVMzTVhPTWN0NmlFeS81Vm45VkhyZ05k?=
 =?utf-8?B?cXRCU3N4aThpYzlWL01VcVVGNjNLdjZkWXNFRjJpd2JDUnllemhoaU9pZnlF?=
 =?utf-8?B?T0ZuQUJMSEV1M0dZVHlUUG9mTG9PMTZxL2x1Z0wrRXVkaDNRc1hLQlp6TnA4?=
 =?utf-8?B?Sk1qVGVxL0NkNlpJSnRJK3F4N1NqeHZMQVFyTVBlZkh1cG5vRUlXak92UUo2?=
 =?utf-8?B?R2JrZzRqYmc4T1ZxSW1DeWVkbjJHdnV4WkNiVk0vbEo3R0FuUUtRdEtmMzA3?=
 =?utf-8?B?Ukx2N1M1eDhSV1hybytmeWVyVjhadzdlajBaT1pOUkFRbUJwR00yWlp0MHY4?=
 =?utf-8?B?LzBPOVAxbzJSYlFoWXdaWG5lekl5eDllRWZ0c2w2TVMwQUh1VFc5OUFWRFVw?=
 =?utf-8?B?RkdFWHp2VkpMNHhZd3M2dHJTWnlLQUVOZHgrblRnQ2FaVW1kWmtHWDlWeFRn?=
 =?utf-8?B?OU5Vci9OWm9yOWg5bkI1MlhyaTBsWlc2OGg0emx6MnJ4Tm1JWEJmemI3ZWcz?=
 =?utf-8?B?NWFqS1dZZllZVEZBSWhBcTFwTTR2OVNUc2U4SnQwdzhVYTBMN0o2U0F0V0lH?=
 =?utf-8?B?dnVPODZMRWlSSFB4UHFHdU1MM0VVT01JbHFBZWNvRUIxa3VxQ2lmTHBMMU1m?=
 =?utf-8?B?NG5RdTJwMm9sc2wrNkUvT3NKeklPTklFTFZtOExUbTVrNkhSQU9WWkYweUwv?=
 =?utf-8?B?RWpJa2cvenl0SEdoWmF6WGkyK1JnUTZRN0trSXRVQTFvZ2Znb2g4cFJ2Z0Rl?=
 =?utf-8?B?eE9IUE9ZcDd2Yk4vckFIZHU4Y0tkZ05GeE5mQjRFRFMzYVZCZnN1L2lFT244?=
 =?utf-8?B?R3lKbmlBN2pvTHRCYTZHSDNBYU5qa3VxcDh4OG9maXpaaTIwTnljd1A4M1d6?=
 =?utf-8?B?elJzd01tbnlDOFZUVzdDYW9Pb1l2ZjdrandlR2FpVlhQT3RoNGdwdks2UVVX?=
 =?utf-8?B?T3JhNFp3bjRzSDV1WG1VZG51ZytXQUc1d2JqMHVTOHNVdkx0R3pwYUEydmQr?=
 =?utf-8?B?UHFxS2hMTDRYOGNXVlRjcVRGRDJ6WlZGZ1dxejFqN29VbVpFeU4wNXcya2d6?=
 =?utf-8?B?djh3cExZUEQ0dVBVc0pqZFlXMzhmSStKUlFMeXA5eWF3aWtvZmd2V0REaUk2?=
 =?utf-8?B?dEg1NklsakNtVzBTV1ZSajdxUkZOWGlWVmlhaCtHY045Z29MS0NLK2pDcnJk?=
 =?utf-8?B?NC92aWpJVWd4M2VVYlFyUmRTMFlVZ2pJZnRkSzV6Lzd4ZGFOcUV1clNHQXdL?=
 =?utf-8?B?M0FiQW1Nd1ZjbHRUREFNVC9NcEF2S3hsVDRFd1A3cyt0aFZ6L0owdjRneXhk?=
 =?utf-8?B?cTA1UVBUc2t1eGlZOTZVTU02ZzhEQUNtZnZpUGd0NUprOHo3cWl0UmpXdlVL?=
 =?utf-8?B?SDMxRFJBNldkZk5XcjIyVnBTekVnQkNqMy95b0xkVVY2cGIvbjRmQm5YNmxh?=
 =?utf-8?B?VUtJb002dXZHTDNFQkhVL2NvdU9zMEl6ZzhHSEtrYjQ1cW1kYTZuUjBpaHdx?=
 =?utf-8?B?dEE3V1lOYTc2SWJvVVFaNDk0ZFppd2RTblZ2Vm1aZUxRRmdKTE9sTFVQWmFk?=
 =?utf-8?B?UjZYZU1zZ3MvZ2hoMVROVFlJcnVxOGkwNDlKM2ZnRkdaakdGZmhRUjZUUzc3?=
 =?utf-8?B?UTYvR3ZuREJQUCthbGlteCtMd2ZyUmRFNlpUUVY2Y3BwQ0JpMG9hOGxmbVJQ?=
 =?utf-8?B?SXNWUnpObythL3lBZy9NS0F3Mm9PMTZKVnRPb2JFdG5TWnFEdVdzVHZTRTFS?=
 =?utf-8?B?YlFteXkxeUJvaUxCQVVPZGRzR2xWU3JoUHF0Z0haSmhkYWRaOXJ2c2hXaGNx?=
 =?utf-8?Q?ekAdNLhzuSJ63QGy6bXbV9Im4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daebb63-ffce-4565-6962-08dd4b18ae2a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 03:52:33.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mnc0ofB1CUWqkeK61vv4X7JQqcG794130QwPrLoFp069L+nvWb9Fj3aiRvAZ1IVC2oNyBDg9xq12V/uLMxB9Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139

On 2/12/2025 12:47 AM, Mario Limonciello wrote:
> On 2/11/2025 07:13, Dhananjay Ugwekar wrote:
>> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> In order to access the policy from a notification block it will
>>> need to be stored in cpudata.
>>
>> This might break the cpufreq_policy ref counting right?, if we cache the pointer
>> and use it independent of the ref counting framework.
> 
> Would it be reasonable to bump the ref count when we take the pointer?
> 
> I'm not sure if this will work properly.

One doubt, why cant we get the policy ref normally using the cpufreq_cpu_get(cpudata->cpu) 
in the notification block ? I'm not aware of that code, if there is any restriction on this.

> 
>>
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/cpufreq/amd-pstate.c | 13 +++++++------
>>>   drivers/cpufreq/amd-pstate.h |  3 ++-
>>>   2 files changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 689de385d06da..5945b6c7f7e56 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -388,7 +388,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>>>       else
>>>           epp = epp_values[pref_index];
>>>   -    if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
>>> +    if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
>>>           pr_debug("EPP cannot be set under performance policy\n");
>>>           return -EBUSY;
>>>       }
>>> @@ -689,7 +689,7 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>>>       perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
>>>       perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
>>>   -    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>> +    if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>           perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
>>>         WRITE_ONCE(cpudata->perf, perf);
>>> @@ -1042,6 +1042,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>>           return -ENOMEM;
>>>         cpudata->cpu = policy->cpu;
>>> +    cpudata->policy = policy;
>>>         mutex_init(&cpudata->lock);
>>>       guard(mutex)(&cpudata->lock);
>>> @@ -1224,9 +1225,8 @@ static ssize_t show_energy_performance_available_preferences(
>>>   {
>>>       int i = 0;
>>>       int offset = 0;
>>> -    struct amd_cpudata *cpudata = policy->driver_data;
>>>   -    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>> +    if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>           return sysfs_emit_at(buf, offset, "%s\n",
>>>                   energy_perf_strings[EPP_INDEX_PERFORMANCE]);
>>>   @@ -1543,6 +1543,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>>           return -ENOMEM;
>>>         cpudata->cpu = policy->cpu;
>>> +    cpudata->policy = policy;
>>>         mutex_init(&cpudata->lock);
>>>       guard(mutex)(&cpudata->lock);
>>> @@ -1632,7 +1633,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>>         amd_pstate_update_min_max_limit(policy);
>>>   -    if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>> +    if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>           epp = 0;
>>>       else
>>>           epp = READ_ONCE(cpudata->epp_cached);
>>> @@ -1651,7 +1652,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>>       if (!policy->cpuinfo.max_freq)
>>>           return -ENODEV;
>>>   -    cpudata->policy = policy->policy;
>>> +    cpudata->policy = policy;
>>>         ret = amd_pstate_epp_update_limit(policy);
>>>       if (ret)
>>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>>> index 7501d30db9953..16ce631a6c3d5 100644
>>> --- a/drivers/cpufreq/amd-pstate.h
>>> +++ b/drivers/cpufreq/amd-pstate.h
>>> @@ -97,9 +97,10 @@ struct amd_cpudata {
>>>         struct mutex    lock;
>>>   +    struct cpufreq_policy *policy;
>>> +
>>>       /* EPP feature related attributes*/
>>>       u8    epp_cached;
>>> -    u32    policy;
>>>       bool    suspended;
>>>       u8    epp_default;
>>>   };
>>
> 


