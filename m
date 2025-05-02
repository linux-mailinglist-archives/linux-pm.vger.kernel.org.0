Return-Path: <linux-pm+bounces-26567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC02AA6F72
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 12:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB89C9C4EBD
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 10:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864323C4F3;
	Fri,  2 May 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDvg/Pyf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2123BCE4;
	Fri,  2 May 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181266; cv=fail; b=YfdR1ajnzMrCeH5Nech41iKmQHmiKDE6NnLS2Vkc73Es+0D+Ugjv4ZTiJeSCQPk8jMDxf7ygR7xeYj4FpHq9cgqBv8quyO8jb9vFQI5tV+XG1kl2z37isiNMSmgM5zg1SfG9j6TRuXQvfUarWGnhPwE2PHY/aBDIGUhBD77wkL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181266; c=relaxed/simple;
	bh=hIkfPdsVuk+auzHApPl6xSRFjq3M9S/DldnDIaR8XRk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PWqasIwuhrGgnu0DRVpQ4bD7y5QQwSCGa1rjvBcgVgp6p5n7Q9ONPw6CpYrYKk+YZNLgfbAlL/QlwBOD4zOr7uWUqmhNUDwc9mm4fGv7psKmaZeHmcQ+MKYtAzDufSwr3Pmi+FhScs6lY71DU2nb0wWSCFmmoRh+zthJq7sRh6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDvg/Pyf; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l01GDHOOhd8cvE7Jjs5SG9S3LxHK0xMc0+MiYw3k7W7lufRAL5qEvqE5lWLT7ysZovXKN9dcqc11C13WfZLQlWLIIpoKz7tzNU7BoGEeqs4ogMbFnKyN2YkoHan4AEZshGGtKENW7dZcI/8ghHvTXV+MPrHtgaTmwcwgaDojCEcffzSC6AvRDxxPJiBur6sJ9PVVDTO0UkwNIuRmgEF9UKH9yrEjXLej6VsRBfB5hfSf/aj81Yoa1TPEbedgiUb8s+sY3BSBxIZ2oIfwRM7LsUwYV1rpJlOJuOExWjfhJpjCyut7MInLht+76ziZqXtz0hrwJ6dGK3dXSeOrd7T+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amG7rluuaxEtRsZ+ZhLzDcWzFHeT+1fxJG2YOdPkeqM=;
 b=ZiaMuR4zwxtVhZSgsKksx94pclyq8A/Ki+TBNaoitVuTIMrTr44a241BNzHb274pPMHSDjQDbMtJCMqTbazqX6SWR1sTMdaGIwUYsx9GXJn5zDqsQbx+8mFHIl/9QJHBTMOupZhq0R7KPfZNinUzLIXcQytV8OtD2wdQBY7ESuUegaYv8I2TgkFsoOj6A63KDTnUdY/SHyt/FrFcMbfwFBqtaySQ8mJjAc+DrCGC970TR+A996ubhO7TCLXwflD2c+3ST8ceo6e48safbtCLa2Zyxy4rm5EjoTo1UyBz1v/jo8sY9dvrmYMKn8w94wNezI9WYH/8m6P2yyLQKWoSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amG7rluuaxEtRsZ+ZhLzDcWzFHeT+1fxJG2YOdPkeqM=;
 b=RDvg/PyfiPGfz3XyrXKwZMjFCsis65rny5JoVoT8WXOB/+IJnA4FufwkLVZzU6HXui0ntv6mFQNqZwwXpvNDX4TpfVlcLcv/bKztov9sONhNOU4hRKrcUaWQMGO1cxPfgfc5Q67BQGdzv7TykCSiKmR/LAkf4euLqbRBeHBeXkwXk02xj/JaEUNbMYBmQGToi4WWn2OKL65D1dOus2H3ZyxXsKfBgjT44aca9ROr7Glkq3Bv0FM9t8nzwrHk+txwHuoLMz+CjTtv0oEfv64sNeL+IBm+POJ5J+zB5Q11yP1vlCi1MqmV2/hHWmoH0sxLUbIF4fYVWmBYbekShtZ2AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 10:21:02 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 10:21:02 +0000
Message-ID: <c63d7864-2a1a-40f7-acb7-ba0bc3311fba@nvidia.com>
Date: Fri, 2 May 2025 11:20:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] cpuidle: psci: Transition to the faux device
 interface
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-2-e6cc73f78478@arm.com>
 <cf4e70e4-9fe5-4697-8744-8c12c41b5ff9@nvidia.com>
 <20250501-pony-of-undeniable-reverence-f34cb7@sudeepholla>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250501-pony-of-undeniable-reverence-f34cb7@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 295e0d21-2667-4223-f0df-08dd89630a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TURKRVUyN0doVzhjcnY0UmkwUzlZNkFpM3N4ZFBjMzBYejNOWUxYRkN2bnp6?=
 =?utf-8?B?NmRSU2hhcmsvYUE3VVhWclp2aUtQTnFQL1VWaTNJc1ZlYUxVRU1UWGdmcTdB?=
 =?utf-8?B?MGtuYjdOYkE3c2FIbndtMGJhRFhzK2ptMkNLOWkvTFFXQzZDUGVqODQyN1ZC?=
 =?utf-8?B?eVZldzhtSGtiNU9IMjhwSzkvS3ZuOWJiVWtyVklPVTM5S2Y3eW1aNGlhYVJp?=
 =?utf-8?B?UmN6bTc3eC9tdVBtc2w1a3Eza2NkVktFc0VnTkJGRFdIajhSc0wxQTFwdm04?=
 =?utf-8?B?ckdxQThJVzQrdEV5elg2M1pUQ1BkWVhhUVNXMDNYTWxDOVVCbTMrSGd4am9I?=
 =?utf-8?B?WTdEbmlmYTV5M085eVFyMndNTnlRSWlRYk5Zdk5FeHh5K1VlL0poNjdnaWVp?=
 =?utf-8?B?dUpkZ2RIOWtDclVvbUNyOFBCUUVwdmRTNTlJRWI0WGZlaGt6UldsbDJmOHVG?=
 =?utf-8?B?QzRYOC91b2x1cEVhRTBqT04yUzVjcVJGWjdRKy81NDU0S3ViMzFnNDZ2N1dL?=
 =?utf-8?B?RjlIdm11QXNVTk0wRnUwS1J3M3Yyb1gvaVJ3OVFFekwyVk5GekkycUdodlps?=
 =?utf-8?B?SGVZQ1d2U2FOQ2RDZW0yNkZRNHpFZXM5UzdObDNlMUNzVG9JSmhKejVFdnYy?=
 =?utf-8?B?QzRnUmdtZkwxbWw5SzlVbkJYamFndTdPNHNQUkZreGp2SkxoRFpvWENMSklP?=
 =?utf-8?B?S245cXFqNkswa0Z6MGNuS253NG1UNjRoM2FwMFNFN2xoazhqMExJbVV5bFVD?=
 =?utf-8?B?aS82K0lITkVWYTZ5ajRrTEFsWFI4LzVVQ0d0b1I1YVBxTVJQU2xaaVMvUWNZ?=
 =?utf-8?B?ZUlOdXRGK1hVekxsM1RodW11V21ETUJMRk9FWkkveW14Zjl0ZDEwZXpUNm1M?=
 =?utf-8?B?VTVKd1E5cEJDVHBxRW1nWVFHT3RWVVNoZkZWYU10WU1NWFpZZGM4TVhEK0Rx?=
 =?utf-8?B?VjJUb0VXdVZOWGJWMDU3anRCOThaTW14b09WSFFBbXRnVHV0ZFlFQ3lkamwz?=
 =?utf-8?B?WWF1Zjc4RnVpQWs5ZlpFeFZkTWtDZStvcHg5RTYrV1FKVFNkek1kaTV4ZFYv?=
 =?utf-8?B?Y29odzIvMC9jRTBXamN6aDVzcEMxb2hXd0xyYy9CM05wbi82SFdHNER0UkZa?=
 =?utf-8?B?VzBlQWgyRXpwYXJXNjN1UzRiUmdYeG94eUtSRnA1N2NRUTBaVytpcVpQa09H?=
 =?utf-8?B?bmdiUVh6SnhobW5sV1FZUXYzdmdaOFdmVVNTMG5kZ2Ywend1WTNiNlZwOU9q?=
 =?utf-8?B?c2NGanYxQkZ1V3lhclI1VytkWmRPaGtSTDhWRGV0UlYrL0hYVzFoRVNIMFFW?=
 =?utf-8?B?bDRORldNMC9SMGlmRkZ0dVJXdEZneEFxeFI4L0kwdnJhYnV2VWUzWGV1ZWJq?=
 =?utf-8?B?NXppWlBac0FFRk9xdXVESVczL1ZGbjdIdWNzM0xqM1ZXcis5Wkh3OXdqb01v?=
 =?utf-8?B?UWhUZFRDaEwzWXliRnM1bk8wWWRpVGVTdXFZUU9raEZ6ZWFTR3RLcGZSSjFm?=
 =?utf-8?B?VDdnWUdtaW91enhLTTlQc3k1Q0tlS0xwcGRCMWVqRHhVOTMwZUF5czFzbmdw?=
 =?utf-8?B?ZDFGeWdhbU80WWh4emNVWWtTQUJ0YUJiQm5Gd1ZEL3FDU1pJT3hBdXllN29x?=
 =?utf-8?B?UHV3d2w2Q0ZEUGJYU01raTg5STIwTDlOWmdjdGJKOStRaUl6aVpNUldKMmp0?=
 =?utf-8?B?YjhhUUZLUGcxUzJQbnZvdHZUZ1dqWm0xWk05NmZERmpEcVByTVU4dVpOZzQr?=
 =?utf-8?B?dFlTSG5iVGc5MUlGSVdKcjYwWnZLbFhUNFRCcW5wT0E5bjF3VlRzUmVudnFx?=
 =?utf-8?B?bm9uWXR2TlNZWitBYkZQbWpkR0UrSDJ2QlRkU0JwSVd5NWVEQnJGd3lzMXRk?=
 =?utf-8?B?d2paTGpLWDFqZUNtYktnMGMwSStIOVNrVGUxZnY2ZHR2dVVWQzRNbG5pdUdK?=
 =?utf-8?Q?c64xsfKpa1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b202a1NTRk1YUlpZRlJVa2Y2SGt3TDBFa1Vtckt6OFJWR2VwWDAvc1VmSFg4?=
 =?utf-8?B?c0RsbnhaVnBTa3hSTWF5SGtJTkY5Rk5JZkRvNWp6ZUxYazEzeGs5dlFKb3ZJ?=
 =?utf-8?B?WnpyS2d2WVgwMFpzeHZzQ2lVcllROHdleERGSXFpcW0rczNxYldUU2xOWGF0?=
 =?utf-8?B?clpUMTExOHBxeWc2aDlQdklzeElSQ0VnQWJqRTk5RWdLeEh0MDVzZTU5bjZi?=
 =?utf-8?B?TDdtZWdiVmVoUDE0cmV2eW9NNUFFZi9qSnhMeU9qbHNVUUdwUkVwcEYxSE1M?=
 =?utf-8?B?aHUrTVduam81QVZjZWtxUW91VUNtMldTTFpaY2F2aDZ5cXB0UE5mK1ZMTzNY?=
 =?utf-8?B?Q081S2w0Nk1KQWl2NlcyS3ZQcndQenZuanh3elNlOWRqNkMrNkREMFBiUGc1?=
 =?utf-8?B?VnRDN3NmWUMwcmZqRm1aWmtxZGFlVHBJa2JkUHJ5cFdrOVd2aTd3bHpoeWNs?=
 =?utf-8?B?Mll2NWQzYkpOZ0p3cFh0Mld1MHFKM29JVjFBS01TeWl6dkpGTGpKeVBIdVpH?=
 =?utf-8?B?Y2NKVVZRcmNEbTB6Z2lWZlNPdlFuOHVsM1VrMzR1QWFKeEJ6b1g0Z3pxOGJS?=
 =?utf-8?B?bG1wK2hBU1BmY01JV24yL09GR2VHQ3VkaVYyVnJpQzJMYzJKbWtMSk1FNHQy?=
 =?utf-8?B?R0VBRGJuTmZYV1FFaWxDQUFkWDJSTWFpcE1RZ0tDUk43WEJGa1diTzJVSGIv?=
 =?utf-8?B?L0ZHTXNtSlFjK2tqNUNnWmNYUmpHTWY3Yk83bzlWUzVkeG5hbXBLenpjMU9L?=
 =?utf-8?B?VDM2c2RZUzFHUWhWMTZuZ2o3Vzd2cnZDTzRFaXpkOE5nWS8wUHI0N2M5UzVi?=
 =?utf-8?B?MENpV2VodU51NVNXZHFrRXIyZUJDSWtnVXNMb3k4TXdNR1NPODZvem04a25V?=
 =?utf-8?B?elBQc0FmbGxsbzN4djRpNUdmT1lyOVB3NXR3VzVSMUUrTkpITzhXdzNLazRQ?=
 =?utf-8?B?VkdZeUhOaEtkUDArZ3FqV2d4WWpYenBWYWFCSW05dXlMeHpoTkUzOWd2Wk81?=
 =?utf-8?B?R2llUVFIekJvNUxINGNRNC9rNjR6d2wramU4NmpYeGZRaGV2ZlRzaXZRS1Uy?=
 =?utf-8?B?aFhUNmEvOTl4WnNwZGxWYVo3ZTc5OWQ3WjR6ZDRYdHJHd0F5RVJFQlh5b2xs?=
 =?utf-8?B?Mi9KQ1FzV2xyNDJhMWd3S1FaM21aQzZaR1pJeDB6Nzd1SXo4Zk9IMXR2LzJw?=
 =?utf-8?B?SG5zN3FIUWNHcTBBOUR2Y2Mzd3JubUhyOTNoMFdtTHpkT1FCeUptdTZtMVo0?=
 =?utf-8?B?MG5NNjV6clVCcGpuZWNHcFZuR0pUNms2M0dzSXgwa2dFRUhwakhqelBVdmhk?=
 =?utf-8?B?ZTZNTm5sdkZxNHdtTVo3cTJnNWNiVTFCenlCSytmU2VXVlNPLzVUVGkxVEE2?=
 =?utf-8?B?SnhXdWtKKzVCNFRDWFBlRW5xYmhxb3d1cFd5bVlhRkdtQUhsa1FTZTNEM0dz?=
 =?utf-8?B?Wm4zRmtmK1Foc2oyV3NEeHlSQmJ3a2xBQU8rbGNLRm1aZitwa3NScFgwNFVV?=
 =?utf-8?B?eml1WW9PSEdBZy9wakNMSGRJWUU5eXAxWm5iWUNKZVd4TFZwODVpWDk5emhi?=
 =?utf-8?B?RGh5YmoyUDhWb3Q4SUhBRnA2blpWZmQ0TlRONEgyaitHK3NwdUZhUG0vWko4?=
 =?utf-8?B?YzVEN2ZWY3BkckRsL1ZqTlFnTTF0TkJEL0J5R283b3JHTWJXZ2hxYmlKQWlj?=
 =?utf-8?B?YlBZNE1SY2xCK2JsdHhjOGpOZEpzOWNyNHNHK1VvcDh4U25WVVJ3Vk5kdURM?=
 =?utf-8?B?bitadlFKUkRvVUVtM0xVNkdadnNCbkViTkRkWSs4QUh1emEvMjFjRzNTSFpX?=
 =?utf-8?B?a2tIbEI4VHRENmtzRjdYa3BkWUdZQVdEVjdoNG9Ja3ZkeWZRWjRhK21tLy83?=
 =?utf-8?B?TlFoSGllNEh6ekI4Q2IvUmFuYmRqOHkxVGhudmltbmFhdndOd2dlMVY4RURO?=
 =?utf-8?B?dlczdE5RV0xqbHFJQy80aGk0ZGIxNHpSTTM1b2RUY3JWRkRDRlRieHhmV2VE?=
 =?utf-8?B?anZjRmZJdi8vSlJJYkFBb0tUbTM0ZUZ3b1pkWFhuSUVXQldVOE5SMllkUGF3?=
 =?utf-8?B?elRjeGdSNXd3NWVsTGRiU2t6T2ZkeVBrRmxBR3ZHVkFBZGZlMzJNbE16dnp4?=
 =?utf-8?B?Tk1NOGhIUUpCZ1FUWGQremo3UEwvUVFOcE5FTGQ3SER2VTFoRThpUStqejBw?=
 =?utf-8?Q?KRa/sOIk7gPsfN4wdxnkr7H4t04MVzERMkQeujVBaSDe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295e0d21-2667-4223-f0df-08dd89630a3c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 10:21:02.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sE5hWiusXAi9Kya/6PWZFUHhavZEZOz9237INl6JNYTItI23vhpI/QH1+a7RVJ9qg6Da646ude9xxcAoU9pMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423


On 01/05/2025 17:07, Sudeep Holla wrote:

...

>> I have noticed the following error messages on some of our Tegra devices ...
>>
>>   ERR KERN faux psci-cpuidle: probe did not succeed, tearing down the device
>>   ERR KERN CPUidle PSCI: Failed to create psci-cpuidle device
>>
>> I had a quick look at this and this occurs because of the following code in
>> the probe cpuidle-psci driver ...
>>
>>          /*
>>           * If no DT idle states are detected (ret == 0) let the driver
>>           * initialization fail accordingly since there is no reason to
>>           * initialize the idle driver if only wfi is supported, the
>>           * default archictectural back-end already executes wfi
>>           * on idle entry.
>>           */
>>          ret = dt_init_idle_driver(drv, psci_idle_state_match, 1);
>>          if (ret <= 0)
>>                  return ret ? : -ENODEV;
>>
>>
>> So although it could be argued that the error message is valid, I am not
>> sure if there is anything that mandates that we need to have the idle-states
>> present.
>>
>> We are always checking for new kernel errors and so if something new occurs,
>> I am trying to figure out what is the correct way to fix. For this case I am
>> not sure what is best.
>>
> 
> This is another case where probe was failing before too just that faux
> device probe throws the error. I will take a look and see what can be done.
> But yes, we shouldn't throw error if no idle-states are present in the DT.


Yes exactly this was already failing. Thanks for taking a look!

Cheers
Jon

-- 
nvpublic


