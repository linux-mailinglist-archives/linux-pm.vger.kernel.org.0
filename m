Return-Path: <linux-pm+bounces-21998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC423A336FA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 05:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AC3167482
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 04:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB1205E0B;
	Thu, 13 Feb 2025 04:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L0SsqGge"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF61C32;
	Thu, 13 Feb 2025 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739421766; cv=fail; b=hdV5W03u1EtpgLkvTaXwwJArdxdNTQ1g4W1HEumyTvZhQ+AzIC7d+tjt/GulvOfxj4cgHvMWgZ05PfJL4QmZN387Tks+DgJ8mqhEDl8GeinE6kUCpFjM+Qebp4yO90iFPEKLSefhJq7+Y2ilG+RZ7E1cMQ3DdHAdnFDKPNCpBJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739421766; c=relaxed/simple;
	bh=Lo8sa+rHSX9NhM2IvhB3LsyrjL6XDMk2LbyTzkdLGK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wm9Z1NuFeyM6ANrPNIieAyFq5bUjLo61rqwgKhpZK7mpuKTMzQxun2xhFnHQVzvK64wfN8OGlRaIDDCUDH4QPpeFQsIQgp3Qf7YSm1DX5vos8yfw1Ufru2x67+QbZcdpKQzl4SzbK6RMRrK8vI6WGPofaffI5FbgYIPCRfISwBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L0SsqGge; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQVokADCyjiAJmDXqWH/HlfeDIC2HU9hotFWTfPi3I1VnGAgIbGngymFeZg6GAH4z59Z6ysgiGA+bRxOMj1Hcmm6hu25jUo9d/x36AXrvWpae2gQv1vgC3IBheStgyj48zKMpnJNYJNOIIwh4UBIqy73fBrSb3+txAvPU6cIUvL59nSUNWnau1shrlgGb1G9CAO/G/JJ1J2MtNfBnGWx3ceXaKqK/y5KsdPT6JhtciV8jppOlMrtank6kfrbdtHe69Ih3ZTnLqZS8UYyV3+gaDIeV2oyjI2uLLsy/NbKA3gftBEAox4CvJBd/cpgbQuTPGSkERdOvIz9JXS4oUHdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vDdOf87lAgnMv1ljov/GWYdgpnZc4uEcMwG28zCrbg=;
 b=Yw2ihxs8dFNuy1W33AfGJJkuyftVrehKEMgReceWfFvL7yDoRaCRqaWf1tp6/gAeAiQD8Sol196McwthfMue+FYHEqy2FxKRO/WmqKnO0qLiQCymn8fkLRKM4V1DXFq7R4Q2N5UmVNuuPBaqD9Zy6Mt4aT8UjS+F8c+Z3mfkfB7S9goBCb0LwUU9Bu/85KV0VheA6/shobHExUXdFPy0oQZ7vw7uNygkL6hNfLKUtc5w7hFLCr1bfRSxcJYfLTjiPRmtxSvlwhSdp/XvcRNHbERzDWhYAaCVxxPE86k4vYJKPUT7mbj+WN+T6tY+T0JXmnIvhWtnI1qPBQOLWc2FhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vDdOf87lAgnMv1ljov/GWYdgpnZc4uEcMwG28zCrbg=;
 b=L0SsqGgeKP+0DmCZIJXUxh9yKLcw3YSmG8Z/MF6yk82UHstIhgvwx/n5HEWT8M2Kmki+oRAtgK3Stx1Bv89m5CDKVjdBXHviIWCvYFqdFruJ5cEfaPZXger8hIFFqgi6kUqZnReHjtwdMtW8XGMvu90LcZd0f+So8Spd6/kDe98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 04:42:42 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 04:42:41 +0000
Message-ID: <af04a3f4-1cfb-4226-8038-e1929ae7a676@amd.com>
Date: Thu, 13 Feb 2025 10:12:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] cpufreq/amd-pstate: Rework CPPC enabling
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-14-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-14-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::13) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 6454973e-38de-4f6c-4d2f-08dd4be8d9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUhydGpvR25xc1dKUy9qUEVoSFJ5OWZTN3VhNjBkVUtGWGE5MkV6OHZ0TEFP?=
 =?utf-8?B?eGV4Qy9SaEFjY3hXTkhxUURNcWExT3JWUFhNK0xtQ05HTzgrYjYrWVN1U20x?=
 =?utf-8?B?Q2wyK09tVDRTTmhKWTJyRkV0eVNWMnlGNlF4MzNPbTduUWNjWk9OZkdFckVT?=
 =?utf-8?B?ODBZTnQ0NE1IY2Mxa2lFMEZVMUREWXdBenp0NlhTUzhqbnlsY2NaaHdsKzdR?=
 =?utf-8?B?VkRpNGFBcklXcjcya1d2TWE4dStTL1N4RnNrc2xnU1FCV2FvS2M0Zm5yUmRM?=
 =?utf-8?B?UkJiZUpjSzByMFZ4bjhKZXA2bTNqNTFHYSt5Vy9jemhsVFlTOUo3ekhaTWMv?=
 =?utf-8?B?TjZJWnV1K0hzaENuaWphM2hsM01YNEVCWlRRMHpUUGhpOWN4RkxPc0lsQUdt?=
 =?utf-8?B?dS82Y1B3NU9Ob0MvOWwrR1FoREdWaHJpM3FPSjhqNDVJZ2RkVkd5NkRSVU5m?=
 =?utf-8?B?U0l4NzZZYjB1UkFXVnJuVHlzd0xiV0VqWTZKMVBIcDcvVDhqWXNKd0IvRG9p?=
 =?utf-8?B?c2FDNUc3bHRZaVpZVHdmdlFMM1F5VzNtSTc3NnBKdVFPRCtkMjc0eVg0dDZI?=
 =?utf-8?B?enpWRFFiWXpDY0d2QlBOUWNaSFNJWEd2NjJQUG1WdlNBb0tsSmVwdEMraENF?=
 =?utf-8?B?aUtpTU9lMkxoT2hEZTBKOVZqcUxzc1dPZndSNEQxWFJ3SjBkWDQ1RFM2NCt3?=
 =?utf-8?B?Sm8xMUovSjdlcUsvdTVBWXJGZmxya1JibUFXYVhUaGVubG10N1lrcVJhZGh3?=
 =?utf-8?B?SURxWnFsbC9BWGN5Zm5zMFd1OGdWNHNlT05ZVHZVay9sY0tyNWtsb1E4bndP?=
 =?utf-8?B?TVA2NE1RcmxmVEd1MGZVKzA2Nyt1RTNDRVVjMVFoQ0JNMVhHVnJ1T0gzelVH?=
 =?utf-8?B?WkIxT2VpWXVzQnhjZ1dqbnAvY2ZoY290L1dOWDdBRURXRjVuQndYMG0wcjZT?=
 =?utf-8?B?LzlQS2JhQ3BsN25mWDdNN1Fya0lyVEVuNlFXNjVzWTZUbE44OWM0SmVpd3Z0?=
 =?utf-8?B?VlFvZUdXL1VlOHowVVZBamxXZG9jQ2pSSUM1NUpGbkV1SjlpQTJqbVFMekdZ?=
 =?utf-8?B?ZVJYdFZKVnBuL0ZqN3BKck9XM0psa1FGNjlvUnZuTDVORzM0WkdtMnlrUEpk?=
 =?utf-8?B?eDU3T2xuQjNuQU5yd1pYS0dCL1JPa050bjQ3djFVcTRIR1JNWWtncHQxYnp2?=
 =?utf-8?B?ZFl1V2ZsaWVMVkVpUUFWTXoyR0JtOVdiVXZnNnRkU1VJYjB3RFpwYTNBZm1Q?=
 =?utf-8?B?V0NEcmZURmt1eWJlTEc2d3Q3aklaNUEydkNFcGJqZXRLdFZnRFI4dkZZZTFK?=
 =?utf-8?B?Q0xnMGFtY1U4MEFjeTh0WUhOUjNBTWQ4TERINkR5dWEwTmk5c3pDTDl5SUd2?=
 =?utf-8?B?QnFhbkxaTU9LZ2ZkREVDWUVwc2t2WVhrREJwUG5INzIySENMSGsvTE8zck51?=
 =?utf-8?B?WUI1V3dwV1BRVmNHY29mZVh0bSs0VDBSMVNEYXVva0NVSWpCUHl5RE5QSTlJ?=
 =?utf-8?B?R2ZsQlhJelU4Z1VQb29WNmw4WXJhWnN3Tm1BT01DWkVqMjNCb2w2QnV4TVhE?=
 =?utf-8?B?WHpWcVVpWnFUak9mV1JkLzNXRXdFRmpaMnNyTzUvVmlOZ0VtRlh0OFVxbURG?=
 =?utf-8?B?UDlrc2xxWHdtck5kMkxxUGgwMG5PNG13b0JBbGYrM0tLdmREdjEyT05ySm9V?=
 =?utf-8?B?TGhMcDFjdXF1eEFheS9FaHh0WDZ5K1ByQnlSU3prQitXcjRHWDVhVEhINS81?=
 =?utf-8?B?Zm11M2tUN1I3VzB3bzFmQjh2eFNraDBBTGFCOWo2eGx3eEZlQUdTSnhLS1Fk?=
 =?utf-8?B?aXA1Q3htSFlCMUNjOXNKdkl5Ly9iTklCNERndkRLQ1RCM1hqZHl2YmtFNklM?=
 =?utf-8?Q?jsg8i4Sjjbnyn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmpoMWEvSTY3bWx2MzN1TmlsTUtZOHVQaUdDU3luN2lxMkFrSk50VWpWaFk4?=
 =?utf-8?B?OCtwN01SMlM5elFhK0x3WWR6NWZwdS81YnpnaVQ4ZlJQWWxpU1AvbisyUnhJ?=
 =?utf-8?B?YWN2ZDlQZHBxbmF3a210cWFYYzdoQ1cxSXQ0V3p5RXJVYkl3cTh6TXNEZTRP?=
 =?utf-8?B?aWduYlMwQkxMK3BPUzNzcDlJOFVZSDU3RTl5aFQrU3RweDA5cnE0UEZpQnk0?=
 =?utf-8?B?dkVPMjd1U3cxWGhsWFJyWGh4NXlUWmQxYjJpMEw1TzBqMG1EYmZFejZHSzhj?=
 =?utf-8?B?K0hJTXR6aDEvN3FJdWtoMkoyNmNzUXFld3pFS3NPdFFQcVhVQS91SFgyaHJK?=
 =?utf-8?B?MWZZNVRCdWlUVXg4SkZ2Z3h2Tmp5T1F3ZFhueC84a0NSRDRnS0NjOWtjSThZ?=
 =?utf-8?B?U3dUUjBoUjFFQ0V4MllhNmQ4QkZib1VvSWUxVzlLWlpFanZETHZJVzNzLzVa?=
 =?utf-8?B?aFBWVmxYTDBWMGN3azk2VDlSbkFRTzVFakJualN1UVM5N1JQT1ZpWHdkczZZ?=
 =?utf-8?B?YTEzYzJCdjIyVk1rU2JLYlNsKy9Sd29rU3ptdm1VWEFDMDhzcXlrdGVtMnZT?=
 =?utf-8?B?V0Q1QzRVOUFwbzV5MzNXMlBlNEI3cU85bjdRTTNDcmx4ckVaS1FHRm54cG1t?=
 =?utf-8?B?WGI4U1dZeEJTVVVER3hYRExOOTlkWnNVSHg4b0pIOHFTTjRFNzU0ZXQxMUJz?=
 =?utf-8?B?Ymdva3BlZjhLQVpVMUk1RFdsVXdTOW1iS3ZHN0FaNkJSbXg2Qm9rQTQ0UGdy?=
 =?utf-8?B?bmlsWFpwcGxXd2I3YWJmOUR2SEdzOXBva2dsditVdi9TT0dMUlJ5WmF4OW01?=
 =?utf-8?B?SS9hTGtYRGVXanViY09BWHR0MmZpVCtnNnM3QUw1YVVMZnlvTWl3UkNpUS9S?=
 =?utf-8?B?RUtNQUJXZ3NMbWowbjlnbFJPM01SOXdZOWNxS0U4WG5jS1JaazlpRG5CdWJO?=
 =?utf-8?B?QU4rL1NLMGtxZnhSY1J0Ui9WYTgrS0ZrTUtIeFA1dXhYVzhvZnQ2QWp0NmV0?=
 =?utf-8?B?bmJZeFg5OXh6OXJwZkd0UFpBeUl3N2h2Q0F0SDZFVm5CbW9LVVpWZzJvcE1j?=
 =?utf-8?B?aHd1Syt6eGhXazhCTE5CcWxzamx2d01MYmtwd0F5aURjTEVxTWVmNU5UbVpm?=
 =?utf-8?B?Y01CMFhMd1drNVl4eURTOUhuWmdOZ1pyNlgyRVhUZU9qZjE4TlVNalIxVTgw?=
 =?utf-8?B?RVRNa2RnYVZNVitiVFBMMHBvdW9abEdXQVB5aGpncFJIN2t6SmlnU1VpbktB?=
 =?utf-8?B?WDJoYW5wZm1sWHZQOWNTcWJEcVdSWktiNE9nVWdSV3FPT29WNWw3ZndVbjlX?=
 =?utf-8?B?a1F3SG9GVWM2UFUwTDhwNkQ3Q0NMSzJDYytoQmVJQm01L2FSZVhzNFBleHVw?=
 =?utf-8?B?Nm1MSS9GZWgvbDVPZ1RINEhZc1JYRDAxSGh6T0pUR2F3aWZKWUlNRDVmRTUz?=
 =?utf-8?B?NXR4SnhqWWZMUW9qRXBFMkJ6QXdJNWh5VjhuZkFudzRRV0hzL0hPRThiNlJQ?=
 =?utf-8?B?Vjl4Y0VBT292ZmoxOGtKWHEwcXhKOGJZbjJ1Ti80VnZGdEQxTUMwRUR6bjRV?=
 =?utf-8?B?NUNRL29QZ3RlNDFIcU9veGRxMGVhd1huZTFHVGttU3hWOTNXUG1QNlB4Q2ta?=
 =?utf-8?B?VjY0SDNFblJUUFhGdkt1U3lESGpvVFhSMFN5OXdyaXlrQmw5K1RBMUxIeCtJ?=
 =?utf-8?B?MzJDTTR4WFJOUUNndTlMRFVWb3VPd3ZoRG1SODc0bUpsdnpnRmNVVElHUmJq?=
 =?utf-8?B?MVpyZG1aV21jM3E3VFQzS3lnWGNSL1Q4QmYrZVhrZUwvQk1SQWZ5UnkyN1Rt?=
 =?utf-8?B?bEJKV0JaNUtESkVoanhLVGRoaGxpTXF2ZXRva2NobzNIaWNDQ09MSE1sRFlC?=
 =?utf-8?B?Y28yMzNFdm9UeVJuNDgzd0VMTUs3cnFtazkyTW5MU2dvWFo4blZ5djVFcDMz?=
 =?utf-8?B?ZUhxamlHVU1FMitPdnh4K3V6SVBSMnFlZkVoTmlFWU4vakc2TlhsdnF1NDRo?=
 =?utf-8?B?c09SVGZObyt3Z0xVZ2ZKMHVIRW52NGduWHlGcXJIY3dWQUtkV1Jwb3Z0SGoz?=
 =?utf-8?B?Ly9XM01RWHg5YUlxdDliT3RidEF2ZmNhbEdiZFZiYW5PQWdsT0JtbHJiSFZp?=
 =?utf-8?Q?vYqtswmXdZhg+cpAJOae7VrWk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6454973e-38de-4f6c-4d2f-08dd4be8d9c7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 04:42:41.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAwnCisNpGfTaMGzHFbM2dX0/fVNNX5iE+m1IDcjO7heQxJjs7SS45mJbRI77wQVk6ps+ysURxvAK9Qdzkr/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The CPPC enable register is configured as "write once".  That is
> any future writes don't actually do anything.
> 
> Because of this, all the cleanup paths that currently exist for
> CPPC disable are non-effective.
> 
> Rework CPPC enable to only enable after all the CAP registers have
> been read to avoid enabling CPPC on CPUs with invalid _CPC or
> unpopulated MSRs.
> 
> As the register is write once, remove all cleanup paths as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 188 +++++++++++------------------------
>  1 file changed, 59 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5945b6c7f7e56..697fa1b80cf24 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -85,7 +85,6 @@ static struct cpufreq_driver *current_pstate_driver;
>  static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
> -static bool cppc_enabled;
>  static bool amd_pstate_prefcore = true;
>  static struct quirk_entry *quirks;
>  
> @@ -375,91 +374,40 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	return ret;
>  }
>  
> -static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
> -					    int pref_index)
> +static inline int msr_cppc_enable(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;

Cant we just use "policy->cpu" in the return statement and avoid this deref?

> -	u8 epp;
> -
> -	guard(mutex)(&cpudata->lock);
>  
> -	if (!pref_index)
> -		epp = cpudata->epp_default;
> -	else
> -		epp = epp_values[pref_index];
> -
> -	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> -		pr_debug("EPP cannot be set under performance policy\n");
> -		return -EBUSY;
> -	}
> -
> -	return amd_pstate_set_epp(policy, epp);
> +	return wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_ENABLE, 1);
>  }
>  
> -static inline int msr_cppc_enable(bool enable)
> +static int shmem_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	int ret, cpu;
> -	unsigned long logical_proc_id_mask = 0;
> -
> -       /*
> -        * MSR_AMD_CPPC_ENABLE is write-once, once set it cannot be cleared.
> -        */
> -	if (!enable)
> -		return 0;
> -
> -	if (enable == cppc_enabled)
> -		return 0;
> -
> -	for_each_present_cpu(cpu) {
> -		unsigned long logical_id = topology_logical_package_id(cpu);
> -
> -		if (test_bit(logical_id, &logical_proc_id_mask))
> -			continue;
> -
> -		set_bit(logical_id, &logical_proc_id_mask);
> -
> -		ret = wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE,
> -				enable);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	cppc_enabled = enable;
> -	return 0;
> -}
> -
> -static int shmem_cppc_enable(bool enable)
> -{
> -	int cpu, ret = 0;
> +	struct amd_cpudata *cpudata = policy->driver_data;

Similarly this deref also we can skip if we use "policy->cpu" in this function

>  	struct cppc_perf_ctrls perf_ctrls;
> +	int ret;
>  
> -	if (enable == cppc_enabled)
> -		return 0;
> +	ret = cppc_set_enable(cpudata->cpu, 1);
> +	if (ret)
> +		return ret;
>  
> -	for_each_present_cpu(cpu) {
> -		ret = cppc_set_enable(cpu, enable);
> +	/* Enable autonomous mode for EPP */
> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
> +		/* Set desired perf as zero to allow EPP firmware control */
> +		perf_ctrls.desired_perf = 0;
> +		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
>  		if (ret)
>  			return ret;
> -
> -		/* Enable autonomous mode for EPP */
> -		if (cppc_state == AMD_PSTATE_ACTIVE) {
> -			/* Set desired perf as zero to allow EPP firmware control */
> -			perf_ctrls.desired_perf = 0;
> -			ret = cppc_set_perf(cpu, &perf_ctrls);
> -			if (ret)
> -				return ret;
> -		}
>  	}
>  
> -	cppc_enabled = enable;
>  	return ret;
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_cppc_enable, msr_cppc_enable);
>  
> -static inline int amd_pstate_cppc_enable(bool enable)
> +static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>  {
> -	return static_call(amd_pstate_cppc_enable)(enable);
> +	return static_call(amd_pstate_cppc_enable)(policy);
>  }
>  
>  static int msr_init_perf(struct amd_cpudata *cpudata)
> @@ -1122,24 +1070,7 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  
>  static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
>  {
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret)
> -		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
> -
> -	return ret;
> -}
> -
> -static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
> -{
> -	int ret;
> -
> -	ret = amd_pstate_cppc_enable(false);
> -	if (ret)
> -		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
> -
> -	return ret;
> +	return amd_pstate_cppc_enable(policy);

We can get rid of this function right?, as we will always enable the CPPC in the init path 
and never disable it after that.

>  }
>  
>  /* Sysfs attributes */
> @@ -1241,8 +1172,10 @@ static ssize_t show_energy_performance_available_preferences(
>  static ssize_t store_energy_performance_preference(
>  		struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	char str_preference[21];
>  	ssize_t ret;
> +	u8 epp;
>  
>  	ret = sscanf(buf, "%20s", str_preference);
>  	if (ret != 1)
> @@ -1252,7 +1185,31 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	ret = amd_pstate_set_energy_pref_index(policy, ret);
> +	if (!ret)
> +		epp = cpudata->epp_default;
> +	else
> +		epp = epp_values[ret];
> +
> +	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		pr_debug("EPP cannot be set under performance policy\n");
> +		return -EBUSY;
> +	}
> +
> +	if (trace_amd_pstate_epp_perf_enabled()) {
> +		union perf_cached perf = cpudata->perf;
> +
> +		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> +					  epp,
> +					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> +					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> +					  policy->boost_enabled,
> +					  FIELD_GET(AMD_CPPC_EPP_PERF_MASK,
> +						    cpudata->cppc_req_cached) != epp);

We've moved the tracing part to the set_epp and update_perf functions right?
Do we need it here? I see a set_epp() call just below

> +	}
> +
> +	guard(mutex)(&cpudata->lock);
> +
> +	ret = amd_pstate_set_epp(policy, epp);
>  
>  	return ret ? ret : count;
>  }
> @@ -1285,7 +1242,6 @@ static ssize_t show_energy_performance_preference(
>  
>  static void amd_pstate_driver_cleanup(void)
>  {
> -	amd_pstate_cppc_enable(false);
>  	cppc_state = AMD_PSTATE_DISABLE;
>  	current_pstate_driver = NULL;
>  }
> @@ -1319,14 +1275,6 @@ static int amd_pstate_register_driver(int mode)
>  
>  	cppc_state = mode;
>  
> -	ret = amd_pstate_cppc_enable(true);
> -	if (ret) {
> -		pr_err("failed to enable cppc during amd-pstate driver registration, return %d\n",
> -		       ret);
> -		amd_pstate_driver_cleanup();
> -		return ret;
> -	}
> -
>  	/* at least one CPU supports CPB */
>  	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
>  
> @@ -1570,11 +1518,15 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
>  							      cpudata->nominal_freq,
>  							      perf.highest_perf);
> +	policy->driver_data = cpudata;
> +
> +	ret = amd_pstate_cppc_enable(policy);

This will get called for each CPU even though it is a systemwide register :(

Is it possible to add a basic sanity check for "invalid _CPC or unpopulated MSRs" in amd_pstate_init()?

Because I think the current design is quite good, i.e. 2 paths which enable cppc
1. amd_pstate_init()->amd_pstate_register_driver()->amd_pstate_cppc_enable() [The normal case, where kernel is booted with "amd_pstate=<x>"]
2. mode_state_machine[disabled][active/guided/passive]()->amd_pstate_register_driver()->amd_pstate_cppc_enable() [kernel is booted with 
   acpi_cpufreq then someone enables amd_pstate by writing to the "amd_pstate/status" file]

> +	if (ret)
> +		goto free_cpudata1;
>  
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> -	policy->driver_data = cpudata;
>  
>  	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
>  
> @@ -1667,34 +1619,28 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
> +static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	union perf_cached perf = cpudata->perf;
>  	int ret;
>  
> -	ret = amd_pstate_cppc_enable(true);
> +	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> +
> +	ret = amd_pstate_cppc_enable(policy);
>  	if (ret)
> -		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
> +		return ret;
>  
>  	guard(mutex)(&cpudata->lock);
>  
> -	return amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
> -}
> -
> -static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
> -{
> -	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> -
> -	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
> -
> -	ret = amd_pstate_epp_reenable(policy);
> +	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
>  	if (ret)
>  		return ret;
> +
>  	cpudata->suspended = false;
>  
>  	return 0;
> +
>  }
>  
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> @@ -1714,20 +1660,10 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	int ret;
> -
> -	/* avoid suspending when EPP is not enabled */
> -	if (cppc_state != AMD_PSTATE_ACTIVE)
> -		return 0;
>  
>  	/* set this flag to avoid setting core offline*/
>  	cpudata->suspended = true;
>  
> -	/* disable CPPC in lowlevel firmware */
> -	ret = amd_pstate_cppc_enable(false);
> -	if (ret)
> -		pr_err("failed to suspend, return %d\n", ret);
> -
>  	return 0;
>  }
>  
> @@ -1735,12 +1671,8 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	if (cpudata->suspended) {
> -		/* enable amd pstate from suspend state*/
> -		amd_pstate_epp_reenable(policy);
>  
> -		cpudata->suspended = false;
> -	}
> +	cpudata->suspended = false;
>  
>  	return 0;
>  }
> @@ -1752,7 +1684,6 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.fast_switch    = amd_pstate_fast_switch,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
> -	.suspend	= amd_pstate_cpu_suspend,
>  	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
>  	.update_limits	= amd_pstate_update_limits,
> @@ -1768,8 +1699,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.exit		= amd_pstate_epp_cpu_exit,
>  	.offline	= amd_pstate_epp_cpu_offline,
>  	.online		= amd_pstate_epp_cpu_online,
> -	.suspend	= amd_pstate_epp_suspend,
> -	.resume		= amd_pstate_epp_resume,
> +	.suspend        = amd_pstate_epp_suspend,
> +	.resume         = amd_pstate_epp_resume,

Some spurious whitespace change?

>  	.update_limits	= amd_pstate_update_limits,
>  	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate-epp",
> @@ -1920,7 +1851,6 @@ static int __init amd_pstate_init(void)
>  
>  global_attr_free:
>  	cpufreq_unregister_driver(current_pstate_driver);
> -	amd_pstate_cppc_enable(false);
>  	return ret;
>  }
>  device_initcall(amd_pstate_init);


