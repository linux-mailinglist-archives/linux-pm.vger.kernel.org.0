Return-Path: <linux-pm+bounces-40373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCD2CFE685
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 15:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DEA13018317
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5E9352924;
	Wed,  7 Jan 2026 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fScbn06Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33969352921;
	Wed,  7 Jan 2026 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796370; cv=fail; b=djQl23S3TKR/Dj8xUn0OCqU+b5Hr8uUv7/hzVYOEoJhBEoazkm9raET7F2x3PbIF22zJjBt69r3hHl/D1KBQQ8ODMlhAOvG7s62FxZwvp8jlUh5Mf0JmglqBWKDd5isKEu9dp7seZaVi20El1efmvLjHJCjcSwyrxH6OkXtcEqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796370; c=relaxed/simple;
	bh=IhVzGIUR9PhBCbfpsidz23Z+QLmWuciUgGH6vHzYzew=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QIZNCnnMyK1KzY+Qs4J/Ii42u26xOEz0tJKtvRS4Jix53qx1OqvaE5OGkwUNkCA6M7yaMu/p1EXshQdJOb8sLGLO+zrYSG0/Ar/w05ltoMnW6pZArFe7kOUfI/Npx+lizjIt8i+FTtuOSY1x8478/4s6yARPlFh/T8RXUadoFOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fScbn06Z; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCVc26n84+BjmiimaViR38b1KVlZz/IM5t/LujYN7oDrpGp9Y962li1pe4U/jkVAlhgsTBsc40QbnpkcsfqiAzeMm9nfdnMqxZLqkUsx8Gi/DWJPjGaLBT96cDBrYtd7GPSQAQgHpYXyZgRMlfgUllR46TfE4fFc4acOMbYXDCWeudoouScCr4x7vra074u5FSBBX7A3wNyCLR9tiBbLaWWe7ojq10yWDa8gHmf8up5vTTf50C1CtVj3z8vcRAIKt94crujQytXYA+PCdvvOYpV1Rs5oO1IBr51QQkH4EHHJUCNFano79RRfA/30LsfhmgGQFLVhHPF9s1z0Vk7Fvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSvRGMZSClby1dsmbJZMYhzsAQrBfqGwwHPYlZLWXXc=;
 b=NzJvHm21UtqhHuhm4+O37+ke4IuEhw9k5PAURm4zI5abzVY8zbyfmphEHGjT03ErtimkO/9yPosyWLiZjFOsvjXi7sJAcVGEIssdAt6LeWVr6eofflIraZ06zyGyFd+gNTPiBl+dF9D8kINaXFbtWVC/afFz9SFCoyqqD0PnQzg2fqFP77yOqK0CzfTwZbYt5cA7CL1Pgt1UvyvDptJ+qG4Q/UbcO58+H1Oe6uADxXkBUsWoDMtbiViWwGq9TQug1oCfqf8WuKVwT3KrBd9pE2xwVTUjeRs4//InBdBXVwmSCbw7Do+Sd799fKckwx/zjNBZ9SxHGbePbbmSglledQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSvRGMZSClby1dsmbJZMYhzsAQrBfqGwwHPYlZLWXXc=;
 b=fScbn06Za5fAc4MGhmd29GggmDFChNZ/jKAWhhroevcurelltSjWt8LMX/BE84lVmfFVYVM1YonE9ti6OJRXCheW4cpnSvtE5bDm5TXoWFdOsvXq563XajPqadKse0pZFMbzwZLiOcNRRPuAHbX5pmnnnzJh7MAVQaZq1z9EzvU=
Received: from DBBPR09CA0026.eurprd09.prod.outlook.com (2603:10a6:10:d4::14)
 by AS8PR02MB9838.eurprd02.prod.outlook.com (2603:10a6:20b:61a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 14:32:42 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::de) by DBBPR09CA0026.outlook.office365.com
 (2603:10a6:10:d4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 14:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 14:32:40 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Wed, 7 Jan
 2026 15:32:39 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Nikita Travkin <nikita@trvn.ru>
CC: Sebastian Reichel <sre@kernel.org>, <kernel@axis.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/11] power: supply: pm8916_lbc: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <5f3152f01420823ef8ae2932ed781cf4@trvn.ru> (Nikita Travkin's
	message of "Sun, 21 Dec 2025 10:45:24 +0500")
References: <cover.1766268280.git.waqar.hameed@axis.com>
	<64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com>
	<5f3152f01420823ef8ae2932ed781cf4@trvn.ru>
User-Agent: a.out
Date: Wed, 7 Jan 2026 15:32:39 +0100
Message-ID: <pndtswxebnc.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|AS8PR02MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 094d94c2-8fb2-41dd-10da-08de4df99cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|30052699003|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckJvR2dST1ZZQ2ppanFtWjBFeVN1TVdJMmEwNU9IMlRValBXV1FTVm5haHV5?=
 =?utf-8?B?Yy9mSzYwMGFFL293MzV3WHB6NHBEOU1CTHdCK1pjVkZ4N0M1NXdVYTRjRHZv?=
 =?utf-8?B?aFo4YlhzdXgwTU9hOHFQK3liZm1zb3VITkNTeU5zdERMMEZVTTJReGFQRXE1?=
 =?utf-8?B?TDE2VStqWHpOSWxwMzRLdTgxeUhxZTlVYlkzZnk0YTg4WG82Z3c0b1MvZ0Uw?=
 =?utf-8?B?TVJwaVhjcUM5aURScEFHVjlpc2NDaERKNkF1b2QvTTl6VkZnUllrQkxKV3FW?=
 =?utf-8?B?QVBDLzFiMklaQ0hxNnQ0eTFMS1ZrNHRZK2JOQUNPOFFBRTQvQ3VwcWQvUzF3?=
 =?utf-8?B?TEF5Q3YvSncvTXlKTU9GLzRRMXgwcVFoZHNtTEl2S283V0UvQk9SVmVBdDI5?=
 =?utf-8?B?OURnYVAxYWMzcTB1SlFYM1VVVUJzUlFJbmwvTmhQeG5QaFJrc1JGSWNyTFdv?=
 =?utf-8?B?ZlZFVlNidEhFcVlGYXFMdk53bHN0WTVqWGlZRlB4ZlQ5VVFoUVhINmNFeEFJ?=
 =?utf-8?B?T1gwOGZyQUJub0ZXOC9wc1B4YVNoUVZHWThNTThzUlV6a3VXaWJJSmF0b0Z5?=
 =?utf-8?B?aVE4ck5uMlNMUUxpMGNVZnhuMUFWOW9oTHdMK2NuTmRJanQ4ZUVleDhMdk5M?=
 =?utf-8?B?RFVBVCtsMDdmWHJDczk1TGlkNmNRaVVrazZUK3JYQWx5dHhnQlRWU1haOEI4?=
 =?utf-8?B?NWxIOWY2Z1Z5alZkTE9FMy9HNytLcjhueUZheDNEZWtpSVJUdU4yM2NOVjJL?=
 =?utf-8?B?V25tNTVKbzJqd3ZuU0IxMzNhdEpKd2dNQlh4andpTEp6S0JocDdNTHUweitQ?=
 =?utf-8?B?Y3AwNTQybXd4RlorekxOWmhOcjYyTDIrWlZGZERObjlhUVBiSHI2SkE1ZFA0?=
 =?utf-8?B?Y3R6Nmk3U2Z3dkJPOVRhWjRXTythYzNtRjBxN0RoSlhxL2tCMFNVS2h1c0xr?=
 =?utf-8?B?Ti9oRkpWeEZDb3N4aDJ4QmpVY1ZQS0JrMVlsMERNOVJqdndOaWlwY1I0VEN6?=
 =?utf-8?B?ZGppekQ3enZlQjFFSEh5THE3ODYxa3ltb28wOVhFK1FoZThDNEVsaGF1VFpQ?=
 =?utf-8?B?QVRMN0JWUGJ6YXpqcXo2Z0FZTjhqdEV5azZUWFVaSDBuUjh4bFNtdVJOamlp?=
 =?utf-8?B?UlpWZzJablp5eUZPbVBKMXNXYW0yMW9teEpTU2w0cTNuWjFsOUtZMFFHdWJa?=
 =?utf-8?B?NlZiUGRLLzRybXNFbWl6bWtjbk1iTnhSWnVwaUUvZEFUNFRSNk5WQ25ZQWZF?=
 =?utf-8?B?R2Fwc09ubklMa08zVk1SN3BIZmt3cy9PZ0xmanhUVmVYaVdsOVNZeVRhdkNK?=
 =?utf-8?B?UDdKVmcrUUl5dDlXNTZiUitva3pVNDRwMk1wK3ZZcm1KWHZYWTh5bWU4Qjcx?=
 =?utf-8?B?ejEwbmMrUlhvOUV5aWx5QXdSbDFjOG8zYmY1OFhuVnJrZ20yTzZ1MW5XVWV6?=
 =?utf-8?B?RE03N3VLZFR6QVZaKzhMbkZyOHE2UE1JeXpqeWRxQyt5RktJaVZ0eWpPMjZQ?=
 =?utf-8?B?bndGRE5yakh3U3pZRUZLNitnTHlaaFRxR0Z6Z1BjM3FxVFRRNEJVNXdpVDVY?=
 =?utf-8?B?RXlVTmVqVTAyT3FvMGhZa2FhMjlaRWlaZHo4TmZub3VRQnRiNXFIeCtRcy9o?=
 =?utf-8?B?RVJPRHZUWi9zVmFyTlpCL2xVSkNqS1ZJamc3TFFGUFpyWDFaYnRhRVZnSXht?=
 =?utf-8?B?andmZHV1UWkvT0hhNHIxN0ZKQWR6bFhQZ216UnYvcis5UTlzSTc2dEdwaktm?=
 =?utf-8?B?RFU4Mi9lM0Y4NWQ1THZGWnFXVXJkZ0VrelhEMUdaWTk3a3BMRW82amJ2ZkxX?=
 =?utf-8?B?N2czaitjNnpqTzRMcm5xbUNRVmxpeTJNV2VoUGJ2UlgyL1BULzVYdlB3OGVX?=
 =?utf-8?B?SmtpT3NWam14QWlsM2NWNUJtcWhPOVNDaCtCNTRRc2paZ2w0ZjVsWTZGMTVw?=
 =?utf-8?B?bE56cGVza1NCZlJDa3ovTW9hRUVHS3BrdFZqamZHUEpJdG5XTlljakFHbTdP?=
 =?utf-8?B?QVdrdVdPSHlvZ2xWS1YyZmdGWXF0TXNKYmNEOEh2dFIyc1pqUEU3UHJnT2Iy?=
 =?utf-8?B?WlJ4RXhNOWQvOGhWY010dlVxWmMzcGJDUWo0bGRpNElFVHkyRWRVS1MvZ2tE?=
 =?utf-8?Q?8hWk=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(30052699003)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 14:32:40.8154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094d94c2-8fb2-41dd-10da-08de4df99cf5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9838

On Sun, Dec 21, 2025 at 10:45 +0500 Nikita Travkin <nikita@trvn.ru> wrote:

> Waqar Hameed =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 21.12.2025 03:36:
>> Using the `devm_` variant for requesting IRQ _before_ the `devm_`
>> variant for allocating/registering the `power_supply` handle, means that
>> the `power_supply` handle will be deallocated/unregistered _before_ the
>> interrupt handler (since `devm_` naturally deallocates in reverse
>> allocation order). This means that during removal, there is a race
>> condition where an interrupt can fire just _after_ the `power_supply`
>> handle has been freed, *but* just _before_ the corresponding
>> unregistration of the IRQ handler has run.
>>=20
>> This will lead to the IRQ handler calling `power_supply_changed()` with
>> a freed `power_supply` handle. Which usually crashes the system or
>> otherwise silently corrupts the memory...
>>=20
>> Note that there is a similar situation which can also happen during
>> `probe()`; the possibility of an interrupt firing _before_ registering
>> the `power_supply` handle. This would then lead to the nasty situation
>> of using the `power_supply` handle *uninitialized* in
>> `power_supply_changed()`.
>>=20
>> Fix this racy use-after-free by making sure the IRQ is requested _after_
>> the registration of the `power_supply` handle.
>>=20
>> Fixes: f8d7a3d21160 ("power: supply: Add driver for pm8916 lbc")
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>> ---
>>  drivers/power/supply/pm8916_lbc.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm=
8916_lbc.c
>> index c74b75b1b2676..3ca717d84aade 100644
>> --- a/drivers/power/supply/pm8916_lbc.c
>> +++ b/drivers/power/supply/pm8916_lbc.c
>> @@ -274,15 +274,6 @@ static int pm8916_lbc_charger_probe(struct platform=
_device *pdev)
>>  		return dev_err_probe(dev, -EINVAL,
>>  				     "Wrong amount of reg values: %d (4 expected)\n", len);
>>=20=20
>> -	irq =3D platform_get_irq_byname(pdev, "usb_vbus");
>> -	if (irq < 0)
>> -		return irq;
>> -
>> -	ret =3D devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_s=
tate_changed_irq,
>> -					IRQF_ONESHOT, "pm8916_lbc", chg);
>> -	if (ret)
>> -		return ret;
>> -
>>  	ret =3D device_property_read_u32_array(dev, "reg", chg->reg, len);
>>  	if (ret)
>>  		return ret;
>> @@ -332,6 +323,15 @@ static int pm8916_lbc_charger_probe(struct platform=
_device *pdev)
>>  	if (ret)
>>  		return dev_err_probe(dev, ret, "Unable to get battery info\n");
>>=20=20
>> +	irq =3D platform_get_irq_byname(pdev, "usb_vbus");
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	ret =3D devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_s=
tate_changed_irq,
>> +					IRQF_ONESHOT, "pm8916_lbc", chg);
>> +	if (ret)
>> +		return ret;
>> +
>
> Thank you for looking at those drivers and fixing this!

Thank _you_ for reviewing!

>
> As a small note, the interrupt handler also has a call to
> extcon_set_state_sync(chg->edev,...) which is allocated right below.
> I don't think this is actually a problem since it has a null check for
> edev (unlike psy core) so I think this patch is fine as-is. However if
> for some reason you'd have to respin this series, perhaps it would be
> nice to move irq registration slightly lower, after extcon registration.

Hm, it _is_ actually a problem. During `probe()`, it's fine, due to the
NULL check in `extcon_set_state()` (and the interrupt handler doesn't
check the return value anyway), as you mention. However, during removal,
we have the exact same situation as for `power_supply_changed()` as
explained in the commit message; `devm_extcon_dev_release()` runs and
frees `struct extcon_dev *edev`, the interrupt handler would now call

  `extcon_set_state_sync(chg->edev, ...)` ->
  `extcon_set_state(edev, ...)` ->
  `find_cable_index_by_id(edev, ...)`
=20=20
with an invalid `edev` triggering a crash/corruption in
`find_cable_index_by_id()` (before we get the chance to release the IRQ
handler)!

Good catch! Let's move the registration a further bit down to fix this.
I will send v2 as soon as the other patches in the series also get
feedback.

>
> In any case,
>
> Reviewed-by: Nikita Travkin <nikita@trvn.ru>
>
> Nikita
>
>>  	chg->edev =3D devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
>>  	if (IS_ERR(chg->edev))
>>  		return PTR_ERR(chg->edev);

