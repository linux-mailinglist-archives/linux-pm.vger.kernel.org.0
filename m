Return-Path: <linux-pm+bounces-43191-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKsFArW2nmnwWwQAu9opvQ
	(envelope-from <linux-pm+bounces-43191-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:45:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF91945C3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 09:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB7A5303799E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6A284672;
	Wed, 25 Feb 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="moZiGqZS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="moZiGqZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020A2135AD;
	Wed, 25 Feb 2026 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009138; cv=fail; b=TN6c2Zoe3yHNbH5cLJjNwO5iOqY6zqcIcz1dPDHs6dUaj4TNeWazMuDSRhsA3oLv1C50IODy96221DFddKw7qhyDv1uYKcZ/6oxQTFj1DQ/Bto7TKf1Nd8jP1hOYOuQXo3+Zm3G8b0o0Ba+oVX/un9o0KgoKZixLQ7H7dFdK14Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009138; c=relaxed/simple;
	bh=HX5uYMDtW8R2nKXfzWKpNR+S0U1B16EM7nXxjobELmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYaPjvgNz/PSru+PSYZnSpTnM2x8nlWwMM7yUx55qTPVDlEnau3PmflblOFjSxS5srBmUzJw2HXRsZFQ2NHqOe5eLUoJ8qknU1+SH9O9PfnqRa5vv2zjt7u4z53SFwqvYUnhDbM99f40gJ3JEeVTQkeKGYEnHBzbrca5uN0p/Bw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=moZiGqZS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=moZiGqZS; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=P/WXOnmEzRnLFIDLwTbg0aWLalq+kdnEHwsUNcyU5p7XXTvCgKs/3OUfuoW8gyhggGDBz4uUsnlWO1SU84m48vfxNdjtnoYSVIVnWTWDSRn5FDZPTdTXA+jcQ8p+t+oFwSwYC+6q5rnk77XZZwqSho4vF/tuh1f0clCM98nxQPiTgLNGVr1/v8xXksLGkfYMUYc5N535LFsbPW657AWMEGXtp4NtZ/uWFkUnq2tW8gUQI70EHiluVaPybO8azghgTOp18+1i0YZhFATT0DxsrdaQJRUxNiez0Eh6TOWewK9bWWbddDZJi37K2x6WjkimAL4AVxqQ1c95D4ltbZdhwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UBFeedgY9O1gtbuWSSTPTcd9+gHiPl2DLldEssiCfw=;
 b=RyJEjb7qMseGdcj2Ysh+ROz3B7JdeRl7WXOp/CL3snOfI7nH3GAQRuG3YNp+6vNk5qQq8xVwW0MQF95/em0uZENJP5soHMsbENGyvV2y28UNaLcDamSJ2iiXN/+zg00LulQtiSYynJdK+sSJWEKG0dufjW6y4NX6MtmRKVXbR9sCx+WVPnAPmk4zzyz7caX8q8V8rPMCnbaqkDirufXnMKA0NU6rT06Wnv8zxlhCYH9oNLMqlCtbexcpJnHtD4ZXNidVyElCoNio6HYWxwNWusjKKVGEBa3UTGyMPw5H3VOVUU6ZLVS/FXgHGygZK5LQiwFE08hJWlL+dTU7JaFBHQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UBFeedgY9O1gtbuWSSTPTcd9+gHiPl2DLldEssiCfw=;
 b=moZiGqZSeUlaFnLpn0e/9FpXLotxWnDB4pQ1HG6tS6tilprs8aY55NCfiqaELcKIvcJYUhFXf62BrfwDxnd4pmsEtYwvAdZfSAcHlnSdSg+b5HkECAVdIeBmf+qdUejSmX49+41JrQyXUYCHkDItjVVFq2rTrK8i/msXjlSMgEw=
Received: from DU2PR04CA0201.eurprd04.prod.outlook.com (2603:10a6:10:28d::26)
 by AM9PR08MB5907.eurprd08.prod.outlook.com (2603:10a6:20b:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:45:30 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::c9) by DU2PR04CA0201.outlook.office365.com
 (2603:10a6:10:28d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 08:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via
 Frontend Transport; Wed, 25 Feb 2026 08:45:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSWDiQDIW9cyaPUVfcMyepq1CvwFt7DVBKyHAch6paCCWAH6imKGxHYoaS2hlHHKwsDF2+Axj+PdGsGy+5a+eFDy1h9zN74L+vg2Ejl3cuwQr5q+6ixrEPcE+xXiym5EXZKOFqEs5VHlGMCjVIOaUfrGrZn374xZ7fr/Ja0u1X63wVGa4hpN7H1QMhIe8cxvx/ikQ6Fy5harnNuEgR9NmRxFklA3UIFbXrBKlxxffG3RmbjbbOlbKZ8TOgPcf1ROQUqxfRzO5cdg75niWN4tEj2wST+S29oorevXrD+Mfx/d4B7FWiWEzpxM6nYN/f6sQuz1v46dkXow4loL31a28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UBFeedgY9O1gtbuWSSTPTcd9+gHiPl2DLldEssiCfw=;
 b=Vpx39h27SfxB2KSiuNompUIZcEqGF3JZU79dHi7+sUiidrtTGQdyw1Xgbrk5eD6ap92PWQdPfpRIxfH+tQGfJm+xJC+yJuxAuDItP4j3LJYKrt6yM0uzwL/wXNRbptM8cvV3WdBxwFjQ6v32gx7W2uGhJHkpuOExQDjVIhq7w2npGcPGr6uRvzwC8joxfuUFXHolJAhBV6Fp9l4uxNEx2lscSqE9IH+79fa5kvcmUraLcXRPudbzt2+AWQzqPAtyrZ+viTmijA9S7AwYFI4cW33bDRy+elxjIckvDRJEWTKz7y+Kp9/fI/kEYIf8Vcts26abmJe4+mX01qfhxhAJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UBFeedgY9O1gtbuWSSTPTcd9+gHiPl2DLldEssiCfw=;
 b=moZiGqZSeUlaFnLpn0e/9FpXLotxWnDB4pQ1HG6tS6tilprs8aY55NCfiqaELcKIvcJYUhFXf62BrfwDxnd4pmsEtYwvAdZfSAcHlnSdSg+b5HkECAVdIeBmf+qdUejSmX49+41JrQyXUYCHkDItjVVFq2rTrK8i/msXjlSMgEw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DU4PR08MB10981.eurprd08.prod.outlook.com (2603:10a6:10:577::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:44:25 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:44:24 +0000
Message-ID: <8afdc768-1d64-4562-8e75-8e31d277d272@arm.com>
Date: Wed, 25 Feb 2026 09:44:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] cpufreq: Add boost_freq_req QoS request
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260224170828.1635135-1-pierre.gondois@arm.com>
 <20260224170828.1635135-3-pierre.gondois@arm.com>
 <01459267-8151-434c-8963-f37ac1eb106a@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <01459267-8151-434c-8963-f37ac1eb106a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0130.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::9) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DU4PR08MB10981:EE_|DU2PEPF0001E9C1:EE_|AM9PR08MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebdb9ad-ba83-4c45-281b-08de744a3afd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?REdSLzZjVnJHN3ZSbE1XcHlZcm1RWXY5V0hjdjBUUEtJVnhHUGZWdUNZejBj?=
 =?utf-8?B?TUNIclVtNWpFbWtITmNEM1hWVTFNbjdhV2xPWnlTM0ZwYmdMdHlMdUpTZ2RN?=
 =?utf-8?B?M0JIMzQzTW1XdXRJWUI0ZFZaT0ZsUkQrNG5iWW5CcWdZV1JZN2tYZjFZMkt1?=
 =?utf-8?B?YTRab3ZRdWM1SDNZdHZ3V0dvcW5aNklUWFoyQUQvalBVWEJKNW1qMGNCdzZ5?=
 =?utf-8?B?OGhPOUZCVDNXcWhuTWZmM25FY0d5dFZmYmNDeXFraDVDMDNqeElWeHFMWGI1?=
 =?utf-8?B?T3pZbUMzZjd2RC9jWnIzUmM5eWF2aXpSeEZsOHRpQnZ1ZU5jOEFUZjdCS3Bo?=
 =?utf-8?B?R1FnRXJxZ29MYyt6NTlGVWJ3UGRvQUVBeEN5cWZwWWcvTVEyN0g4V1ZKUEpz?=
 =?utf-8?B?NThNTW9md0xyN3dDYmdKUlNrQVJQTllSUGJTS0N0K3hFdUJacDZURlAyN0U4?=
 =?utf-8?B?ekJ1d3ViRml1WlNGRFpCMnBOOGN2bkxmZzhkdEZwNU9OZ3FEVzNtSVIzMjhS?=
 =?utf-8?B?U3kvTHV6MldkSEp6K21kM0VkcENrWWFTakMveTJheC9kcXIyZm1PaGs3bWdK?=
 =?utf-8?B?R1l4RmpnTlRpTzQrM2hJV2NDOWNkQVRqZVlGdXJjVjl5WDBidUdDb2RHdHJw?=
 =?utf-8?B?RXBoN0lpTStYNXBaazFMWkZ5NEhoR1g4T0hSUnRteXhrWk9GcVRJbjQ0OVJn?=
 =?utf-8?B?R2dYVWNsMVFkRE4xazdRemkrRDVzWmdWL1dpVnJOVytGZ0gvejNNdElxZVI5?=
 =?utf-8?B?cUJpVC9nQzRWNGZrTEtONDYxOGNMdDhYVS9MaXBHeG5PWDFYWW9DeHBicVBz?=
 =?utf-8?B?NTBEamUrWENpS1lBWExSZ1JRNHRJL2tqem5NV1VNTCszbllwY1N0S05wZ2tV?=
 =?utf-8?B?Vkp2WlNkdmkxOUU1WTJoTmZtTzYvTHh5c1VCSlQzZVkvTmxmQ0s3MWZzL3Rs?=
 =?utf-8?B?Z0VxdGtETnl0VXdTY0cxaUhxZUtSVlYySThUK2tSWHdpempNeFVnYkxKY0Vh?=
 =?utf-8?B?V1J0UEI1RWhjTEhGbWQyQW51MFZ3L0VtNHN2VTFGdGxXZjdsY0Q0azRkSWpy?=
 =?utf-8?B?NlA3VmNaL21lYlVBanJNKzNlcDRTVEpGWWc2N1VZZGZEVFB5YmxwZE1yUkc0?=
 =?utf-8?B?eDNLdXQzc0lHZnhCWVlZRHNrVm9qR3hzaDJUZzRIcWZNWVhPdGdqZTRha0pL?=
 =?utf-8?B?Y2dqZGJDS1JPTGE2aEZZQWFGd3oveXh1WlQ0emFQVEc2ZmlxT0pzc2FLSno3?=
 =?utf-8?B?STRwNUgwUEoxLzNGVEtiVjdESGRucDdWem8rVGpyMjFGUi9mMjJHQ1N1ZW14?=
 =?utf-8?B?bHU3MTdtWDJPVWk5dWdPYzdlWkduTmFhOW10Wkh2QUcvV3B3aFMzUldYZWtz?=
 =?utf-8?B?YjdpSzE5UVhMTXZjVlo0YmZRNE1zUEtwTjhoMGg2d0locjNhcmdVbjAvVkVo?=
 =?utf-8?B?YTNhdTJxMDU5TDV2bGNjQ1BTMlFiMENZeGRGWjVNNjdHUGV2dm1GVHRGUWY1?=
 =?utf-8?B?a1huWHU3VDJYeHlvWlJDK1VhSEplOXdIaGU0cXZ5WjZMTFI0S0twdFI2RjJU?=
 =?utf-8?B?MjdGQ0djQ1RYSWVKZUFuQWRxSFl4L0JtdEJRWGtyQjlxcTF4c0ZNc2gzdFlw?=
 =?utf-8?B?WS9RdHlsNnhlSU1jek4weWxkYmI0UXhQRFNUZWx0Z0xxd0pYNURMUXp4V1RY?=
 =?utf-8?B?VFlvK1dFemdkZVpyS3ZvQ3YvYmtSTjJpdTRMdE8rNmJPcVFoV1Z1WlcxSDZT?=
 =?utf-8?B?NG0rUnZYSndhSnAydC9zZFlHT0wvQVpFZW9VM0dBdlRaaFY2aWtEamV0VGNR?=
 =?utf-8?B?VjRNbFYvbW9CMUprS1E0b1dKNW81MGl2TFE0VE5lTUJiZFg1YXk0czljWEtl?=
 =?utf-8?B?MDkycmVjYXpNOWxtOWFWNUxJcTVQb0NCSEZoVzRKTGlUZENHODN1NjVOcGJ1?=
 =?utf-8?B?eitFS3F0Uy9QQmJmVFFjNGtRamJESUF1VzF4S2lOdWFGaWlGVWdmL2EwcDVV?=
 =?utf-8?B?R0NRU282L0JoUlVnQWRveHRYT2s0MVpWMXBvMTl4dng1dDhubEZ3U0NtS2di?=
 =?utf-8?B?bkprQVdHNGtobEgvemQ2ZFVkSExicml2WTV3b1N4NCtEanJOK1NxQjlhbmNU?=
 =?utf-8?Q?WO0I=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10981
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	995906bb-5788-45a1-8ea4-08de744a13f9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|376014|36860700013|7416014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWpiZVB2THRsaHBWUWM1UTBOODRTMXAzN0VQaFJnWE1JeFRGR1FEY1E0Q0Uv?=
 =?utf-8?B?VnBJK3Z5NzNZMFBIMlN5elE5bGlnMWNTZkFJYjFlMFNlSHYrdGR3YllJQlhF?=
 =?utf-8?B?dHYyTDNSdHh0QWl5TjVzd1V2OGlRRG40cGdMT21YYzhCd3FpT1NYa3Y0MHhq?=
 =?utf-8?B?V1YzZFhRKzRuMWZrZlVYQnU5QUhzQzdyMmpPNlNRSDVzLzBXcVRZVzNueXhw?=
 =?utf-8?B?amVMYlgyS09pVDZ0QkdjdjFsWldyZkFaOXk4RlRrZklEVDRQeWhRV2QwYXh4?=
 =?utf-8?B?bEt4VVRjVDBOcXBFcmRyRzkrRk5NS1NmMFU4YUE5ajhJMngyVHUxU21IcjA5?=
 =?utf-8?B?c3lRYXFJQVZSQmdCbFlwZkRlci9LQklqVGR2TVJPOXMwaG5BOVZaWFZBZkt2?=
 =?utf-8?B?K20xb1MyV1hJeXAwQ2dPMkVVL21IeEN6Y0xCOXBuZStJWjM0bHBkL1ljM2pP?=
 =?utf-8?B?UTJidjBKanBFVHIzYXFSZ0hsNG8zQnNzZ1pyT3U4cU5iWGdZcEZCZUVYeUVF?=
 =?utf-8?B?Z25Db1FSWDNHRkpYUEsrUVRrL3ZURkxxRVA5Z2NZb1N0SFpnOTdVMHZPMVY2?=
 =?utf-8?B?L0tKdFZRUy9QbHhIcVRXazBBbVk1YzF0NURYU3VueHpPKzI3aThOandJT0h0?=
 =?utf-8?B?cVFNQ21KR2k1QkFDQUloVUViTkdsS1pldWMxK1BxcDBDWm1WS3hyVnozSmd5?=
 =?utf-8?B?bFBpZlgrc2FXNFNYYUVTSC9MRm84Ym54YXNRTnpUV0ZMOTBLOGwrQnF5TDFj?=
 =?utf-8?B?STBIUFBQV3A5Y0Y0bXFzbWZhdnJRQU5qWHBPS3FxdVVRSk5aRGptbmlqNE5S?=
 =?utf-8?B?REdXQjQyMmlwalNEdEdTa1JLSHhKQ0Fjd2o1amZwbmJzYTlGaXhrT0UyLzkv?=
 =?utf-8?B?VDZoWVdpdXNjcWR1UU04Zkg4YkdpZGxtaDFEaWNtcitVcFBWMkd1Rjg3dDNx?=
 =?utf-8?B?d1licExYclRKaVlPK0Jwcmk3V3I3RDRFLy9DTDhlVm9NcGdNWkFscVBtMGpD?=
 =?utf-8?B?bUM4blFTNy8yZ3MxN3BtSjIrMFVKdjlScGpoUloxb1lxdzd3ME9YZG0veEgy?=
 =?utf-8?B?c05qOFYvV1Y4YTdOd2EwY3FHK1ZpZ3dtcU0yK2lyRTZRdC9USHB4bzhSTEdt?=
 =?utf-8?B?R3pDdzhXMEJLYVl2eTlrakpCYnE0VUhVeGcvNnZlYXEydFM1eTNtODIrVzEv?=
 =?utf-8?B?Z0M3ZWpvUzJ2Z25wQ1FWWTRzbjlpanF1V01YeGdYaEMxbE1Fc1JQQ1RxN2ph?=
 =?utf-8?B?K0Z6YUZuVFI4aWFDbmswQXJkUEgxVGdXTTlqWE5nZ0ExOEFUc1JGd2xoU096?=
 =?utf-8?B?UGJ1VkVVOUJISUw0Ky9SVzZjVHc5MUhHdVl2b201NjZaQ2t3NWlIUSs3dEc2?=
 =?utf-8?B?bWRsTkZCUXJ3WWtZOTZDTWdyY2hZN0ZSQWUvQnNrVy9sUEFvN05CY2hDanBi?=
 =?utf-8?B?bmxFU0ZXK3VSRWpJc2dyTExrWlNQYXhvbDBNdVZralRLUzJaUGxVWHlsdWFr?=
 =?utf-8?B?bEhtRjkvdkdrZlFKUFpvZ2p0Slkxa3E3dFREbnJ4K29RTkNnUWl0UTE5U1Uz?=
 =?utf-8?B?Z2Q0aUVpK2ZQU3ZKeE1UOG9ERENrWUl1V0lkNGNJK2QwbzJYdHNRS1BJNXV5?=
 =?utf-8?B?QkhKb2hNWmlJR1hZTmp6LzBkMzB2dTgvdU9MUUlUeXhFa0EwL0VvQ0FucUx0?=
 =?utf-8?B?MnBPVUhMTDNUNW9IckRiUnhxWUhHUEljTjRGZ1JiVzVGTEU1SUlSZUxTaG5u?=
 =?utf-8?B?YTdPU1ZRTjZkY3dHRnFDM2ZKZ3FxNkMxZ3YzZmcvLzBvZGZlSmpsUjRxQk8y?=
 =?utf-8?B?ZnBnU3BLd2FuYjFpU1RJSk1IVDlXdUxTaXhyQkZhYWtURDVsUU1GVVpNTFBG?=
 =?utf-8?B?NzRhTm5QMUt5R2pLT1RWU3B4bDdabEdmclJHUGJ2TDBzTnl4aHgxL0Y5MmhD?=
 =?utf-8?B?UmZRb3RqVkNFd21IaUxLUnBYVzh0MGRjMk1VdXRXZU1rQWY1VU5JcFJUVm9w?=
 =?utf-8?B?YjlzKzdSUGNsWUJReXhVODRjVnBpMWZHcy8zSHR1bXFrNlBZQTNhWGJ4eWp0?=
 =?utf-8?B?Nng0VDFSR3JENlMvZ2FBRGxSQS8waXNiNm5EdVFiL1R5ZVBNR21WeGNpVDlH?=
 =?utf-8?B?dUQ0UjZ0VDNLQThaMlZLVmtZYUx5NUZHU0FFWC90NE5PVm1EbUY2eUZBSlB5?=
 =?utf-8?B?VnIvT01JbVRwb0ZUeHBOcEFIa3dudThWaWtWWEh6Qm9pMFMxYnBoZ3V1MWJt?=
 =?utf-8?B?T1YySDVJbVRhSm95OWF1MlRHb0FBPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(376014)(36860700013)(7416014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bGn+fbXsqXbi5xNOkMe7il3Ed7F66+nztCWxkmixVadibUw0385/zvkF7RyDz5PzOAbyLWi3E+OJXybL0UkfB8gILjah92DwXGYczL4ln42FbymwnGQMGs/IkF/8Rt6agwa8cL/dEjm2a6cMs/b98/M74qGZ3v70zSmJenUfpComibjRwASFjfiueGIcHnQnNkLdzA8+7bj/SImQ5Vzph4UT96JNuv/Q13yEQxsy+iKCJQP07U0+AeBfuIaG062wsUYWJGFnMZPG4v/q+SiOEZ14WRQSD7H8tjWRuMlFw1Utpj/zFvu6GFOGjGccrfHBe5JxqMZ4dpvcL+CY6834OId41g9z9eXTEkiQ6Lb6zl+TQs6j3ljA/N+zO50nYzHb93NFRHhJYDgqS/j9V/+xdAXJbFFbBG5Cu65tOmvQq2WJw0Q0MiC4gkb5Jsmuw6t0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:45:29.8141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebdb9ad-ba83-4c45-281b-08de744a3afd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5907
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43191-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 66AF91945C3
X-Rspamd-Action: no action


On 2/25/26 03:33, zhenglifeng (A) wrote:
> On 2/25/2026 1:08 AM, Pierre Gondois wrote:
>> The Power Management Quality of Service (PM QoS) allows to
>> aggregate constraints from multiple entities. It is currently
>> used to manage the min/max frequency of a given policy.
>>
>> Frequency constraints can come for instance from:
>> - Thermal framework: acpi_thermal_cpufreq_init()
>> - Firmware: _PPC objects: acpi_processor_ppc_init()
>> - User: by setting policyX/scaling_[min|max]_freq
>> The minimum of the max frequency constraints is used to compute
>> the resulting maximum allowed frequency.
>>
>> When enabling boost frequencies, the same frequency request object
>> (policy->max_freq_req) as to handle requests from users is used.
>> As a result, when setting:
>> - scaling_max_freq
>> - boost
>> The last sysfs file used overwrites the request from the other
>> sysfs file.
>>
>> To avoid this, create a per-policy boost_freq_req to save the boost
>> constraints instead of overwriting the last scaling_max_freq
>> constraint.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 41 ++++++++++++++++++++++++++++++++++-----
>>   include/linux/cpufreq.h   |  1 +
>>   2 files changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index db414c052658b..52efa4805afee 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1359,17 +1359,25 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>   	/* Cancel any pending policy->update work before freeing the policy. */
>>   	cancel_work_sync(&policy->update);
>>   
>> -	if (policy->max_freq_req) {
>> +	if (policy->max_freq_req || policy->boost_freq_req) {
>>   		/*
>> -		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
>> -		 * notification, since CPUFREQ_CREATE_POLICY notification was
>> -		 * sent after adding max_freq_req earlier.
>> +		 * Remove max/boost _freq_req after sending CPUFREQ_REMOVE_POLICY
>> +		 * notification, since CPUFREQ_CREATE_POLICY notification was sent
>> +		 * after adding max/boost _freq_req earlier.
>>   		 */
>>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>   					     CPUFREQ_REMOVE_POLICY, policy);
>> -		freq_qos_remove_request(policy->max_freq_req);
>>   	}
>>   
>> +	if ((policy->max_freq_req && !policy->boost_supported) ||
>> +	    policy->boost_freq_req) {
> Is this if statement written in the wrong place?

Yes right ...

I also forgot to remove the below if conditions as you suggessted


>
>> +		freq_qos_remove_request(policy->boost_freq_req);
>> +		kfree(policy->boost_freq_req);
>> +	}
>> +
>> +	if (policy->max_freq_req)
>> +		freq_qos_remove_request(policy->max_freq_req);
>> +
>>   	freq_qos_remove_request(policy->min_freq_req);
>>   	kfree(policy->min_freq_req);
>>   
>

