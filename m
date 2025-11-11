Return-Path: <linux-pm+bounces-37798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4FC4FAF5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 21:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B892118833F1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 20:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F23F33D6D0;
	Tue, 11 Nov 2025 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qdtOAHSI"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432D33D6D6;
	Tue, 11 Nov 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892283; cv=fail; b=DqjkOca/aNmUNCvN1Bpu9XhubXjQSNC6rLUwKlGtZjAspuCJYTjZSKmgrE2OlbUVaJIV8IBILISOapfQ5kkuu6sOYURB8aFEfuUXe0Ls6/r/9ElZvGS3/ruirWto76Wlp/MJDHgFcp7yO+9gxCQHNPYPHVqVTeUVZQfKlnXflZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892283; c=relaxed/simple;
	bh=kzlRjWz5CS6CmIqeT+XShk74xiR0N8CdFrlRYGS17Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EpbFOJW57XcfUWjeklzcPvS/ewUIq3LkpSatcnQ69zmyCeyaUiv2Lme/Q0Oo/hX7a8xe6j0tELrSTYybdUPk4sin5sdPClGGdRWayRmfInRcFSiZs9UFG9nxK9MjRhs6F/2FOni3pBCtvARk+8xAi6lEblK+Cm0686m9y6QxtPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qdtOAHSI; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6vhqSvRd/K/TbVkAA4R+Ow5eLkZI7nEQ5lCYReP0kBeXLytINZb+YjxN27CBzBdM/WNMTah2u6Ieep4gL1JNPhvgnsM3UwBD/AzD8UoiyBAOCbbJplJmESYLNLSW5kdL1RwWF2s5jqyxyIAeDWj03v51JjFTc1sZ7+5UcY9dc0Ws2e+In/vxUR90yIsDgY7ecsUO7gkwLwJLFZ68Nivpqu3OzS3SkEyY06xgAyWu2qr/pU86LV5FWzJozwowni/vxsHh81DEdsPxb/w5pW/MCOpyv+EQYoTNnJM/6seRgNsTBA6b8t4hzqoHDl0R57Ix/UH/WXzkje9+sWdWDQSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpbZVz2Y1z644seopiZAxcYDp7BLELiTL/HU1zKLAmQ=;
 b=SqLt8Fpzi3kAAuQCY5UbzPN1OuweggbnwzfRjMSFX0aU+8kd4LsH2ZJZrRWDGWtqPsBSK4PnThOvKgV/DS1ty+wa0ZjwsTVD/Quvz/sFPmS8ACCRuFaBw+Wvvn8KE590tEInJR3lYrwxq2ju+D8BZM2OtmxRzeub7+hyXw54qXG/I+OBk+L0TV8egHfoqJFEkcEQagT1rbSXQGF1yOMXqNw+FRfB8hzAB1d9XH6dV1nli6OtfZqsy3HimzDfcy0dFsPwWUVyGyRUbTZHkewZhz6g8fsXlCrSpTqXCJ4+QQX6p439H3RfgffFmtI08Xz3/FsmUT8N+San/JOtmq/ZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpbZVz2Y1z644seopiZAxcYDp7BLELiTL/HU1zKLAmQ=;
 b=qdtOAHSIQZTN0sGIAWcyPatlYn8ManKh8n6PWUHS0PaEZiULXQg9EDxuZJpZUi/HQsyx2vyAQEnMcKSJcsPqfyb1XzBHfTuHqqfvXkq/NYMrKSsG81MjtqQRzZCAXlnrZIE8Az7ZfrS9OTxg4b72D/xIFWoU2sZ4GEKIU1P73+A=
Received: from BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30)
 by LV8PR10MB7800.namprd10.prod.outlook.com (2603:10b6:408:1f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 20:17:55 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::11) by BL1PR13CA0445.outlook.office365.com
 (2603:10b6:208:2c3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 20:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 20:17:54 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 14:17:51 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 14:17:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 14:17:51 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABKHogl1507481;
	Tue, 11 Nov 2025 14:17:51 -0600
Message-ID: <4b2ef99d-93d7-424f-9903-3819c7340763@ti.com>
Date: Tue, 11 Nov 2025 14:17:50 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pmdomain: ti_sci: Handle wakeup constraint if device
 has pinctrl wakeup state
To: Ulf Hansson <ulf.hansson@linaro.org>, <khilman@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <d-gole@ti.com>,
	<vishalm@ti.com>, <sebin.francis@ti.com>, <msp@baylibre.com>, <a-kaur@ti.com>
References: <20250910-uart-daisy-chain-pmdomain-v2-1-6d0215f4af32@ti.com>
 <CAPDyKFrOjFeZDOs84egaCAmRwtnXcj5bZLniOb1gkDkDH0214g@mail.gmail.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <CAPDyKFrOjFeZDOs84egaCAmRwtnXcj5bZLniOb1gkDkDH0214g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|LV8PR10MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b2156d-d175-4eac-2e69-08de215f6571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uy9sN1JCSmJnM0pRRVRGOWFvU0FLc2ptSWRpcDdjYTJLbi9LZXhhR0tyR3A0?=
 =?utf-8?B?QkVjRGIwTDdEWFd5RGVad1l0YkxmRjFzZGNiUkxtUUliVkpWdTg2bHBnMkx2?=
 =?utf-8?B?REVJclNHVWRyN0RJTTdtc0p6eXVGYS9vZ1pIcTNhcWtXQVVKZ0FDcEFLQmVZ?=
 =?utf-8?B?TlJNZDI0Q1FyOUVSdEU1Q1NPc1Q5b1BiSjd5NjJxdkFUZVZmSS9CQTYzU0lz?=
 =?utf-8?B?VE5CS0NZTVlSa3lwYnY5MnBGVHBXNmVaeEl5ak5jQ0xWRkZOYjMxSkNPZTY4?=
 =?utf-8?B?bTlQdXQyVDF4TDFQcWR1eW1DQTFvNFU3SFJBdjNDaEVDaXE2Z3lKMEhlUTBy?=
 =?utf-8?B?R0N4L0xUWjVjb2ZHdlBvYjVTeTl1bXVnVVU0MHc1STlJZmlZUGRJcTNRSkxh?=
 =?utf-8?B?c2ZuOENwNHdueDBzWUVhLy8xVGZ3Q2l6RmIwbktTMG5Id3U3MVAxVUwrTVUy?=
 =?utf-8?B?ajFkZWRTWDFScjJYUWFCcjJCWjlBM284TFhtTHBzYkxDOS91Q3Z4UU9YbUJH?=
 =?utf-8?B?MXBhTWNhZ090V2VWalJlZ0lZajZhMFMrMkJ1NXFJY3ZwbEoyaUg4eTUyeWRE?=
 =?utf-8?B?bktNWW5xU2FiR0c2UExyN0E4clZkTnU4VFk4aVNJZXdtdi9aLzF5WGhDbUZp?=
 =?utf-8?B?OFg4bFhWeU5Oczl6S2xkMHoxSmtnZ2pKUE9mU01OenhSWXphSHZwRStPVVNk?=
 =?utf-8?B?Sjg0ZTNrczBvTVMyWWhGTlkwMzdWZ0hVNHpYTHIxU2pIZUx3Umd1OVR2TXkw?=
 =?utf-8?B?MzBTQUtJd2NHMzI1QzQ5S09zZ09uNXBQRW1EOFdrWm5kV1NxajJNSHZXdWVi?=
 =?utf-8?B?djEvdVJyWkNKeGhYNGhKUlFIazIwUWFIanZFdHRlYjZMUDhCOHAwZkgrYlBJ?=
 =?utf-8?B?MnlLNnBPdS9EemFNUmlBTDZ2Z1djeEVEOE11cW5wd04vWU1NaVplRXRCUStz?=
 =?utf-8?B?RGh4SmlIMjEvU2p0V0FJMDlZbForeHBGZlJVLzJGZDdka2s5UGQ1MVV5dm9y?=
 =?utf-8?B?WmlURVNSelJaQVVCcjVKZE1DM004ZHpwdVdTVHZlTUppalZybjJiK0xWSFRS?=
 =?utf-8?B?b0RET2x6QlA1UWpWYWF1Z2FhM2JFVHpldUY4MVRIWitseVZweWZaN3J5cWt0?=
 =?utf-8?B?MzhzVEZjcHYwK0FkOFY3M0s3RVF2VXFLRVZTMGlDMy9FY2I4WksyQlBSaS9X?=
 =?utf-8?B?OFIvTHE1N2o2ZE8yUVFxT2FYZlFYR3ltK2t1L09GY09zWUZ4RWs4cHBRSzg4?=
 =?utf-8?B?SXJVMyt1ZTZmUmppOHkyQ0hTWk00RmMwSHJHeERRM2txWExUZzgxcHRrQUVy?=
 =?utf-8?B?Q0ZBOFFWWW1iKy8xZmwvMTBLeE12NkkxQ0U5Y2ZvT1ErMnErS2Y2WUNla2Vw?=
 =?utf-8?B?eUpnQWYrcUJEOUVSdzZhSnV3cVZ2NFkvcjI1QUZuR0RxNDB4RmI5UFR0QzVJ?=
 =?utf-8?B?OURORjYrMkNQRGdrRVdieVhlSTB2Q1lmUXAzV3NMTHR4YVlETUdYSWRFRmlR?=
 =?utf-8?B?ekw4SlJzZ3F1N1JzVVlkNW9GMllscGt3T0xseHhYTFdRei9hVmxwTytiTk9I?=
 =?utf-8?B?U0s0QXdDblhYa2tjNWdVWEJyQ3hWdXhreWhqYXEvTFhDZHFBSUNmUFJrOTRE?=
 =?utf-8?B?RlBqWkhPc0Nibk5EUjhSejlmRWNKMHUrR2s0eDNSNjhaS0szSDhyaER5SVRq?=
 =?utf-8?B?dEM3UU9SMjV6V2MwZEhPNVMveEhsYUtGcmlGRlFoOVpOYlRmRkMxSU1ZYTNG?=
 =?utf-8?B?ZTV3V2YwTkJLSmtNR2tXaWVNWjh6WVlidVBBS1JOeWYrOVdDRGxKK1FoQ1Vt?=
 =?utf-8?B?SFMzclJlSjNQRlBVakZ3Vm1ZdGdzMU80bW5LUDBLMGJNVmNJMVdYY3FKZGJs?=
 =?utf-8?B?UGpHVzRNWTh1SllHd05UZ0dCNmNFWmpNVFU3RlVMRXZJZXlQMy82MFQrZ29C?=
 =?utf-8?B?aFpSbDdKUllUQ2p2d0hRMXFsM0dBL0dsOWh0NGxhdXhhSW52V2ZVRUNFcVRE?=
 =?utf-8?B?WlkvVldjYkRWMEZ0bE01b0tUb3NxdFVlME9TTGZBZTNrRG9aZzhpdjdrOTVU?=
 =?utf-8?B?eFk5N0loZWZIa3E3bGZ5cnQ5OXdJc2tZSzFnQnJlVEdkcnFqS2k3ZWNEQmRC?=
 =?utf-8?Q?/jfs=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 20:17:54.0063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b2156d-d175-4eac-2e69-08de215f6571
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7800

On 10/21/25 07:22, Ulf Hansson wrote:
> On Wed, 10 Sept 2025 at 23:16, Kendall Willis <k-willis@ti.com> wrote:
>>
>> For TI K3 SoCs with IO daisy-chaining using pinctrl wakeup state, avoid
>> sending wakeup constraints to the PM co-processor. This allows the SoC to
>> enter deeper low power states while still maintaining wakeup capability
>> for peripherals using IO daisy-chain wakeup via pinctrl wakeup state,
>> similar to the existing wake IRQ mechanism added in commit b06bc47279919
>> ("pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups").
>>
>> Detect the pinctrl wakeup state in the suspend path, and if it exists,
>> skip sending the constraint.
>>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>> Implementation
>> --------------
>> This patch is intended to be implemented along with the following
>> series. This patch has no dependencies on any of the other series:
>>
>> 1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
>>     wakeup state": (this patch) skips setting constraints for wakeup
>>     sources that use pinctrl state 'wakeup'.
>>
>> 2. "serial: 8250: omap: Add wakeup support": Implements wakeup from
>>     the UARTs for TI K3 SoCs
>>     https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-8250-omap
>>
>> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
>>     functionality to wakeup the system from the Main UART
>>     https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts
>>
>> Testing
>> -------
>> Tested on a AM62P SK EVM board with all series and dependencies
>> implemented. Suspend/resume verified with the Main UART wakeup source
>> by entering a keypress on the console.
>>
>> This github branch has all the necessary patches to test the series
>> using linux-next:
>> https://github.com/kwillis01/linux/tree/uart-daisy-chain
>>
>> Version History
>> ---------------
>> Changes from v1 to v2:
>>   - Reworded commit message to be concise and to reference commit
>>     b06bc47279919
>>
>> v1: https://lore.kernel.org/all/20250904211607.3725897-1-k-willis@ti.com/
>> ---
>>   drivers/pmdomain/ti/ti_sci_pm_domains.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> index 82df7e44250bb64f9c4a2108b5e97bd782a5976d..884905fd0686c1b94aba68c03da038e577428adf 100644
>> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/err.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_qos.h>
>> @@ -84,9 +85,24 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>>          struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>>          struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>>          const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>> +       struct pinctrl *pinctrl = devm_pinctrl_get(dev);
>> +       struct pinctrl_state *pinctrl_state_wakeup;
>>          int ret;
>>
>>          if (device_may_wakeup(dev)) {
>> +               /*
>> +                * If device can wakeup using pinctrl wakeup state,
>> +                * we do not want to set a constraint
>> +                */
>> +               if (!IS_ERR_OR_NULL(pinctrl)) {
>> +                       pinctrl_state_wakeup = pinctrl_lookup_state(pinctrl, "wakeup");
>> +                       if (!IS_ERR_OR_NULL(pinctrl_state_wakeup)) {
>> +                               dev_dbg(dev, "%s: has wake pinctrl wakeup state, not setting " \
>> +                                               "constraints\n", __func__);
>> +                               return;
>> +                       }
>> +               }
> 
> Relying on the above condition and the wakeirq check that was added in
> b06bc47279919, seems fragile and doesn't really seem like the best
> approach to me.
> 
> I would rather think that we should rely on the driver for the
> consumer device to successfully have completed its parts, by enabling
> the out-band system-wakeup IRQ. In other words, make the consumer
> driver to call device_set_out_band_wakeup() and then use
> device_out_band_wakeup() instead of the pinctrl+wakeirq check above,
> to understand if QoS constraints shall be sent to the FW or not.

That makes sense, I will add this to the next version for the patches. 
Thanks for the suggestion!

Apologies for the late reply, I somehow missed this.

Best,
Kendall Willis

> 
>> +
>>                  /*
>>                   * If device can wakeup using IO daisy chain wakeups,
>>                   * we do not want to set a constraint.
>>
>> ---
>> base-commit: 5f540c4aade9f1d58fb7b9490b4b7d5214ec9746
>> change-id: 20250910-uart-daisy-chain-pmdomain-b83b2db2c3cc
>>
>> Best regards,
>> --
>> Kendall Willis <k-willis@ti.com>
>>
> 
> Kind regards
> Uffe


