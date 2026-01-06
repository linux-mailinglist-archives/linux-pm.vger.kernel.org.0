Return-Path: <linux-pm+bounces-40319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AD5CF8D88
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82879300E606
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11CB32ED58;
	Tue,  6 Jan 2026 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhk2CUTO"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DCD32D0E1;
	Tue,  6 Jan 2026 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710826; cv=fail; b=QYQcy/YxqTnTlMD/5vC935SGIslbGMGszBi5D12sIQG53ISXoC0K+9/GAmdfWp1UY2WHTAJv+M5+v++34/Mw+DxrZlaD6drbqNgVfmKQTXxGKFmuN4IfV+ZmOuhe+wB8vnY2qwwtfZiUVDszFVA6miHs3hZbF+z5HNQFxohXAzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710826; c=relaxed/simple;
	bh=E3sKzZYwcz4atL6WdlnGLl8jXZvZ4Jc+a7UmSatjgqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G/dwFbhKZ7OgpM2VfO6bAGakpy4cfTocm+mm/nwnuit1lOeY4/jqp1gh5fwlhg0m7N9kJS9ux1ABq2tKNMlNYNOG22+r1JTbsCVd1r3fEMxI58ni0hPP0FhyYxdMgfPiUAxBXMNltXuS88D9cX5MCs/1kR3SfQNonJ60flJDf7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhk2CUTO; arc=fail smtp.client-ip=40.107.208.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6cZi/ybk56JsUTlBMTgff+DuLtKPKjvDnd1ecIM5Yc1e3/HHnJKFxtlS87jzTck4R7PS+B6Fm3a60kXJtHxCKpJJjH25D3wv49xY6iuzlbROQn76rC0yyMnjsBBcozY6AfqgGAvx/P+aL5Jd/qq38nPXA05OLPTB/F2I9eRrPhc/8Ak2SDwxjdug4IWNznjHR0e1aK5eloeK7Qvk6lFUTaVNfzEGQzLfXQdNz1kPNo9fkZjvx2t9INYqsZ/EVbIPAWN5aLCEV2zg65undMoVvm//P1iuUgT5nOId0+HT3hNHR4LdEIURQH9YBWtwDIM2U2X7rG7/p14W7qU5YmnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVY4x4sX796uNNU1XMSvxGTmZX89bPTDC8qEn6Tg44c=;
 b=hMtHUXY+/AGcljihGTXE7udYo+npeS93DvcV9VFbiSMV3n23d52NsR1yhYQFoP3g7jH6hLvgKteqCi0IwP3/hy7bMEbgPKyj2GMVrJdI0N6nLP44fGBPDW3bvuHoNCVPyik4Um/Z1DU+VW17CCnGIQa22O2dSljWYZ+yFoiAW/+/lml864uh54CDpfuQxY7xMlC7+bfrMjD/oMj31/o1h9Eg37mIBMl6+2IYayafN/h/JLxzwJPxNHm8htljWPGnoN4SzWu/joWAuYve48ulfCwG3R9u8E/O9sbxhjTGnn5Htfu4M9HPsTQENAnOOC5MZKgCAYFT9A5sgs7YrJChuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVY4x4sX796uNNU1XMSvxGTmZX89bPTDC8qEn6Tg44c=;
 b=mhk2CUTOna0LjVZ7iQS+FqMxDI0GO7ltwRiWktmeCQ2yKbH0ZisqsDRSBQEBRhV94GTtqnNiGMlGy5JEibKIxzm8LWQqy2nFwG5qVivbjgx4+UaN7wVUfRGg19WcTjPsUyhRTzew8f2/8XxKsqFiN2C/3x+venwma/V2RsMTdpGs0AydiN5c4EOmPFd3B+PyE0cQA046YmS9QKgizaRllQv3p/RKbdwJXLWhXUi3eq3IODnEsuZpnwD7kSZhUkp8uRZFAHaP33cBqgcUJMHOOfbH5zCXsGMGNwkV0iKXHSpte/S9qhUUBQhTQmIV8Gl9NoqrbRPUO3pdtxkPEPDXOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 14:47:01 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::d85c:e6df:9db2:4ada]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::d85c:e6df:9db2:4ada%4]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 14:47:01 +0000
Message-ID: <bee03066-47b9-41d7-8c43-6170accbb7a0@nvidia.com>
Date: Tue, 6 Jan 2026 14:46:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: tegra: Adjust callbacks in tegra_clock_pm
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: linux-tegra@vger.kernel.org, Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <5088794.31r3eYUQgx@rafael.j.wysocki>
 <2d55ebec-1e42-4ddb-b0e2-529d3b2d7b85@nvidia.com>
 <CAJZ5v0i7Rbk5sWCo2Z1Y4j_ZFW7nCUr18H8i2JCM=aPpfZOQ4w@mail.gmail.com>
 <5956349.DvuYhMxLoT@rafael.j.wysocki>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5956349.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::10) To PH0PR12MB8773.namprd12.prod.outlook.com
 (2603:10b6:510:28d::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8773:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2f40f4-1eef-4afd-f1ed-08de4d32734b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2N0akZiTVczbTZVU3JHd1FIb1BBMTJncWZKNlhidUxUeG1nbTZORkxweUx4?=
 =?utf-8?B?RStWbm5BT3Q0MnBkLytlVU5YYjNJTmt2OE1jK00vcjY5TGs5MWFoNXlQc3E1?=
 =?utf-8?B?M2t5TkU4eXV0b0QrQmJEdDl4TmdNd1J6WnJ3cEFuKzE3RlJhZi83THNTaVlj?=
 =?utf-8?B?dURQSDFxY0ltTlQ1aE9GZXZ4a1VpQitvd1F3c25rc0QzakVqQlJnaHlBRWtY?=
 =?utf-8?B?S1U0VS9mTHQrQjB4ejUvWlJxRjNSWTFhSUZyOUZYN0tMMmtGYmZ4RDc1M1NJ?=
 =?utf-8?B?aVBGQmJxWGd4RFJFV05kZFpSWnFzSVo0dXVGNVpZYkk3TkpYQmxqRHViRTg4?=
 =?utf-8?B?UVU1YzhTelFIeVB0ZjJlTnNDSHBOdkNXVzdvQVZkWWN1ZEprWXAxaHJ4VFNo?=
 =?utf-8?B?LzB6aE5ac2k2dlhxeEc0WG1TU0hoNTZBRXJFbHhVNGVuSXMwYXI4NjFsbk5M?=
 =?utf-8?B?S21VUXg3ZDlMbWpkeDkvakNvb2pFVW1EVDF6RFF1dkF3bnRpNzdzZFEwUE9Y?=
 =?utf-8?B?Y2JYdTRjaGpTOG5Pc09xMkFiaXk2MjIyVUxRT1FZMFJWYnVrQW56dU01VkRs?=
 =?utf-8?B?a21qeHEvOE9LeVJUMG16cjZPRFdaaGZSNElUdEtmVEZjR2RSdWZxc1l2ZWhG?=
 =?utf-8?B?MWVWeFpmbVZRdnVUMUhzUnU4dnVBZmgzLzBreVE4R0tlMHlBdjB3a1lPeEJ1?=
 =?utf-8?B?K01ibHRlTzZZQmZrZmVpNlJ1TVRUNnJUY1hEWXk2cnU4cFFtZU85REY1ZnNx?=
 =?utf-8?B?UFl2UU5SUWJhcmNQL3R2NDgzL0dDQ0g5d2dxVFpFdHlDN1ZTbXhwcTBMc1lR?=
 =?utf-8?B?ZCtzbDNOUjNGL1NWT2MvQVN2NWM0WEY0Q1pBTldWS3l6Z3Fkb2xvQ25nbEF4?=
 =?utf-8?B?ei8zQ09zOG5uR2VrLzQyRlo3aENhWDJvdGdwV2VRMVc4amx4ekI0MXJNNlZP?=
 =?utf-8?B?TkRMVCthRnVSYUYwLzBHbFdhaWpheTloWHgwVmptN0JEV1dOcHU4cENFYVEx?=
 =?utf-8?B?VG9YbVQzeldNNngvaHBvOUxLeDFUaEg2MWhOYy81SVdxR08wcEY1SHdRck9v?=
 =?utf-8?B?aDVDb0FwVkQ3UnNWTFNBYnNZNWczSnRrcUcxZmZQcUNKQ3htWVBMN1F6dUhx?=
 =?utf-8?B?cGhZc1BSaVoyS0VJZzVUMGdpalJaQWJWcEJ5RXpQNXI2ekkvdjhkUmZQa09s?=
 =?utf-8?B?KzIrMGFjdk5yZ255QTBEQ2pvdEllQWc0UkFQNW5UelFwckNYc2FOU1BHZFBz?=
 =?utf-8?B?V0UzTjZrMC84azAyN2pmK3M4dHVBZ1Q1d0lGRk9OY1MrcE04eTVCMFpZQVAv?=
 =?utf-8?B?SUkzaEQyTHRNakh1MlYwZytjZHZRL1V3Rk1mR2k4ZUJTU1NMTE9nZ2NNWVZS?=
 =?utf-8?B?WGZuQy9GWHZTYm1iSU9rVnJzQitKa2MyTUhTczQ3VzJKS2ErUlRoRmhiK29Z?=
 =?utf-8?B?Q0pnS2RCVDFmajZqeFAyTmZBdUJPalJJcWdWakxlT0oyWnF1VzNuWm4vYUxI?=
 =?utf-8?B?RDNhSUVpcGNkRzhnNXNqVzRxKzdMQ3ZDUnVWYTUwa25qK08zVHhUNXJLanFQ?=
 =?utf-8?B?WEUrdGdkTGFkMlhKQ0hsMEdIUXBrYnZQY0Z2RmhDREl5cXpSZmhXTTIxWTVO?=
 =?utf-8?B?c0w5UHowRHRGZVVvNHhhTzFrTGZRdXJIVVVDaWxGN05IRzFRN2llc2tGLzhH?=
 =?utf-8?B?NzlkQTFTcXhKWTQ0djNraW1nclgrU1RuUnBrNGFNTGZyTHIvczJkaXNVQ0NT?=
 =?utf-8?B?NUJSc1lNZGdMY2M0QnRDb2libnd1NmRUeURlRG5UM01oVmxVcnJqVHVwWnJs?=
 =?utf-8?B?aWMyTEtYUkk1OWlvcEVJbThKbTYybHYyelU2NkVyOTJwdmpmZ1hjTmhnaVdY?=
 =?utf-8?B?TEFkbUtNTGRQUE11SmhPTUcvcnM1SnpzMTNLbC8zUXI3WEh0N2oxNWZrVHA4?=
 =?utf-8?Q?3ePakT8+rov0EEJLF/0411AIi2HpkdgW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykp6MlFRY0RkNUhkNHNzdFp4TUE1ejJYd0hkUk9aa0M2bE1sbGYxTHpiQzlw?=
 =?utf-8?B?MVc4MitiZC9Ca3FycW95bVRwajUvdVhzektLdU9hRGFiSFJCNGJ4aWw5OTNy?=
 =?utf-8?B?NG5FZkNYMjNmejJtaFA3b0k0VU5zbThoZDVaNHZoMU1FS3ZPcUZ4dU1rbTR2?=
 =?utf-8?B?R2I1OUZaMWZCNkJ4YkU3VFNTWTBMS3JEQUZEUy82ck5DTExJb1RhOENLc2I2?=
 =?utf-8?B?Z2MrWWlEWkZ2S1NneVdEdlk1dVpNNnhUQWZKbTAzUmduank2SGVFY1VuZ3Fo?=
 =?utf-8?B?KzdGWEkwdVVWTjJKTEYrSjRaTnVTUW5VM0xGTGYvTlZod0ZKa25PQWloTVJv?=
 =?utf-8?B?ZERqSGZFcXlodDFwbjVrRVB6ZXFIS1NFMjJZcThxalZ3MENsU01LZVpGNW1v?=
 =?utf-8?B?RkZZVE1rN3RKYkRmdnhFWGFtM1AzL1ZHemVvd1UwTERHTDROdW9pZWNObWVJ?=
 =?utf-8?B?Zm84U3FneGpJbW1yM2xQdEZtMUhVWk1OeXQrZ2NvelNUZUxyVFIyenAzaVY5?=
 =?utf-8?B?TXhyRnJhUEMxUmMzRzRvV3NJODhMbTA3RnNaRm1qdW5ONjYrd1Y0Nnp5Uy9z?=
 =?utf-8?B?YmVRQjhtSWxXZHBUTUdmQW1oSTVSL1c3a2tzeisxM21Ycyt2UU1VZkVvOXZt?=
 =?utf-8?B?VGNzY3QvNUZ4QUhWTDdvY1k2TDJOQmQwYkpZS2hlUm44NnU3MDhwa0lOYm1w?=
 =?utf-8?B?OUVGVVdFMmxvWDJJMUMxZWRlL0NPN2xJcHRwNzBlc2ZRY0gzcEFIREE5SjFN?=
 =?utf-8?B?NU5NTGR0ZThiNlpiRUplM0ljQlFIK0k1OHFYeHpqRS9GNXZZa0VZTnJZa042?=
 =?utf-8?B?TDNlb2EycWV6S2NXWUpKVlhBUHdBdXNSUGR3MTV6cUwwZzM3YjU5UGhHRVpU?=
 =?utf-8?B?VTlaMERBTHIzNWJ1TlA0eHRNU1RQeTJzTE5ySlozRFRKcE9NcjRPb3hKT2hx?=
 =?utf-8?B?cTFTZFlrVEk4Y3lhSWRsSTdlaXZxMTYxaXJObnNRTVZpcThCc0cxREtVbThp?=
 =?utf-8?B?RVVUNjdRelJnTGNVekd6Mld6M0RDRDlFazhPUzViTWZHSU5mdlVMQUN1SW43?=
 =?utf-8?B?d0lURnVHVmlGMWdGQ0poRDA2WVFIYno4MkhmY2k5VXkrTS9OUS9VWHpVYVNW?=
 =?utf-8?B?U2duSXl5ajZhN2lLZ2JNWXFVV0tYZXFaT0FjQWErcGFGbkdUSklaVXIyM2JE?=
 =?utf-8?B?eWNCRmtEWWk0OWN4eWpoQmFNNDhOaUxVTUhJUkF3SFJ1enJ1SGVOYmkxNjh0?=
 =?utf-8?B?dmszcU00cGNqTXNIVWc2b3Rxd0FwMWhLSWh5Z0RpWHBuN3NVNlMzQlJGWGxq?=
 =?utf-8?B?cmJHQjhWUWkzUXpIbU1yZ0s0QS9aaHorTEwzclpUWXlEM2d4VTZjK1BUczVW?=
 =?utf-8?B?NWFiNFJMUDlLWXBzemhVWWhtWjBwSmRlRXQraGhyTmx2N0k4eGJ0WWQra1RQ?=
 =?utf-8?B?OWFYbG01R01IRkJUWkZiak5TZ2lseDVBZXVXcXYxcWZMMWlWVHNTV2ZqN1da?=
 =?utf-8?B?eXYzaC8rck1kS0ZVUkx5U2FFWjkyS0E1blVETlY0czNRdnRHMDBCenk5VlZJ?=
 =?utf-8?B?dkl6ck1RUzJ1NThjVjF4Z0c5QmVBZFB0cm5TVHU3S2hQQVlzelNhUmY1ZnBS?=
 =?utf-8?B?dE9PcThydXlTOWlBVFRFUzRaWU9TbjVOaFEvUkRoeHdpQU5mZkJzOEJsL0FB?=
 =?utf-8?B?NjkrL2dyY016TERqd25kZ1haLzQ2a2tDQ040REppK0JzbWtJNlhydVdiNkVr?=
 =?utf-8?B?N3g1K3lNeDRaemJ3UVBoMFk2SUtwNHlidjdOTFBQVTAzZzg3T2R4L1BjQkc0?=
 =?utf-8?B?RzJhenV6MXdUZTlyMlAwOWpydGZ0eDNVSW90Sk1LM2J2cy9jdE9JS0w2bTVY?=
 =?utf-8?B?NG5VUHdoVTcwZVA1QzBEdndEMG9VdlVXZG9qYndYdFZGaUNZRTlyaVJFRTNY?=
 =?utf-8?B?eTNMeFhkOXM0T0J1YWxhM1pua3oxTEQ3R1VEaEVCeUhZc1F5eXh0WWtQOHpz?=
 =?utf-8?B?WWxUTkUrZC8wOEpBUVBlU0dKZEdpdWwzUU5KZWtoekpLaTI1QlNRb0lJckE4?=
 =?utf-8?B?cnEzUGlNcVE1MkNjbXJvWmdGN3Y2WlNjKzlPZ0U3dXhOekd0ZFFDeVdxVTBt?=
 =?utf-8?B?dGtZdjhuVDZtWXEyVDM4ZUkyRXRHbmhrbGVWZGw4WlJMbXBKZ2VIODhTellS?=
 =?utf-8?B?VGhOcy9qWGpsaHNlMDNRS2FXTTNjc0VqaG56RUJJbWhRaVRIUk9jbnQ1MFl5?=
 =?utf-8?B?MWRaTFZQRGNCMkpCV1dBMUZxb0ZTV200dnFvakU0QUpOZVlMSG44b1M1M3VL?=
 =?utf-8?B?VWhiekNsOW5MQlhXUysrNEVtWG82Kzk2eE9KZW42QVYvZW1IMHBudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2f40f4-1eef-4afd-f1ed-08de4d32734b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 14:47:01.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/O3vJxClg7PI0DLhJAsUzwbM82e5uWKC+oQwkwkLWw+uhVtKx3pMUkSZ8osei3tOxRNnqFNRBq7+EcC3GzVGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321


On 06/01/2026 12:19, Rafael J. Wysocki wrote:

...

>>> I gave this a quick test and this is causing a suspend regression on
>>> Tegra20 and Tegra30 that use this driver. Looking at the console log
>>> on Tegra20 I see the following errors ...
>>>
>>>    tegra-clock tegra_clk_sclk: PM: dpm_run_callback(): pm_runtime_resume returns 1
>>
>> Of course, it needs a wrapper.
> 
> So the patch below should work better.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] clk: tegra: Adjust callbacks in tegra_clock_pm
> 
> System suspend and resume callbacks run after the core has bumped
> up the runtime PM usage counters of all devices, so these callbacks
> need not worry about runtime PM reference counting.
> 
> Accordingly, to eliminate useless overhead related to runtime PM
> usage counter manipulation, set the suspend callback pointer in
> tegra_clock_pm to a wrapper around pm_runtime_resume() called
> tegra_clock_suspend() and do not set the resume callback in it at all.
> 
> This will also facilitate a planned change of the pm_runtime_put()
> return type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>     * Use a wrapper around pm_runtime_resume() to avoid aborting
>       system suspend when it returns 1 (which is always when the
>       clock is active during system suspend).
> 
> ---
>   drivers/clk/tegra/clk-device.c |   13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> --- a/drivers/clk/tegra/clk-device.c
> +++ b/drivers/clk/tegra/clk-device.c
> @@ -174,8 +174,19 @@ unreg_clk:
>    * problem. In practice this makes no difference from a power management
>    * perspective since voltage is kept at a nominal level during suspend anyways.
>    */
> +static inline int tegra_clock_suspend(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_resume(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static const struct dev_pm_ops tegra_clock_pm = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
> +	SET_SYSTEM_SLEEP_PM_OPS(tegra_clock_suspend, NULL)
>   };
>   
>   static const struct of_device_id tegra_clock_match[] = {


Thanks. This version works for me so ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic


