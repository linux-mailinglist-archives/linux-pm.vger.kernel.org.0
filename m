Return-Path: <linux-pm+bounces-33079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642AB3549A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A488E1B6715D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 06:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FCA2F60D5;
	Tue, 26 Aug 2025 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9Qj/Ima"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC002F60B4;
	Tue, 26 Aug 2025 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189524; cv=fail; b=RD3Cglc4wYI6175RWWSnehzapZcT86v61tejPcrVP2eGaHsHgmo+LdlUFbAKneF6ZbzPPgR0e6rlrN1N6pBUeRBI84Tpb4bIa7qA1tBIkzIWx15Oe3f1ng2ad6jleyCZI2XYlqWWAC00bpjVkSpj5usRGgAgMqgtUSdFNKX5UMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189524; c=relaxed/simple;
	bh=fIVtEcZeYHn+qIJTySkLZtt1yeK0OwajRXzzQQe3/oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=toAxBNGuqnaNxBfWktOcXc0lHHZ0UmqDQ8z1F41KH3wdbBwLlf7/h8v/tGJ32oijdQq+Xw/NjCLpXKFmHNcEfOdI/QERkZ7hdNxLBzWAEg0KiD+46WdeCdFbmIwvodIT+RAkkMGklT2hKVHtLo3D+webA+X1y0+Do8auPvMhiZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9Qj/Ima; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4uzoMLFMnarzLgOfMjbumsvINzKhr0dy4vcKylSrqEnlBhlRZ3ReK1JsPxv56mNP8MnO5k6kMG6PSoTMw1r3yhWk+CKAE0ts3nIz/5toWJlgZ+BUtYg99Wz7SRpMpcdAC5bpZNuXmFRRZW0cEClqjT9f502XLvbDyQEuIaths0tq07oVspMiPKxDd3W4Q/PXo8d/FrYd1d4wmG5J0NADNe8+z/oQNfNQAcgYWYmWlGNVIiz46qQQq5Ir+xcJ1cJ8Dl1qHVzY6XBgOrVTFfVSTtgFBFxQQkA9JuBxti5XnBgnZ667BUxqdJP98CyJ5jegwkXDZX+mC6ao/OjUKkePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTSjsd1sYLu0C7rsihtOEYTNpCktsUK9tpPDNiW6jhw=;
 b=XvK53CLKm8noH5DjMiYErCsGLjVJHiR8CApGZfqFkHB6VTHr563fPT0gT3TSuTqfo2iMVndbunpgtqBJPC+l7iEuDdDdo1lUc2rTGFln/DjhVWIKwc+Zk6gvFFUTnLWZA0Uby6v7Twbbd43BaOCS9KWV14cvo+ze6iKp1L13XZ7TQGZEwQP3O/FETNrSf/UpwX/VXyDfCqaKFzdDkfK6b+a5Crob97q8/MUaRNRepUH/W/Y6e+OvGIIUQa8ga4LIvKJeP2gjQWlIQ0OtotEZ6gjopFZVBoTdbeDt7+M/6HqMBwRv8PUryNt2iVBzlf/7WN8L4wDaxMXYu96dv5LsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTSjsd1sYLu0C7rsihtOEYTNpCktsUK9tpPDNiW6jhw=;
 b=n9Qj/ImaESWo+auWpSGZi6Uj3MSJ0SGpda4lDh+FncDLVyTZ3T8JtnVrXzxy+YNSstdac59bzdJY46OA6N2VmAStCFRY0aqYMzBFbP6E4TQwS53JmaVzEDmw4E2cl5H4BY8xYN7NLXbtizWoEBfqX3XoQZbJ4Jg8k9EXVrcFBOGiokVEHXZoezk/XtCNVQGVddyB2kaUmcRaJMPgX5kKnoeMUnTjZhtxBS1sYUn9Jv7p3hL5qDxYTWdfhFwuEOA2BOrXo4oQeD1yBh5gfIZE/ZrgC35JA6As8Z/m7JjZtDOUuhkMJ15QG+DAb1wXcKu+ZkN9pitGoiGD31nyFijkVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 26 Aug 2025 06:25:18 +0000
Received: from DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11]) by DM4PR12MB6494.namprd12.prod.outlook.com
 ([fe80::346b:2daf:d648:2e11%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 06:25:18 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clk: tegra: add DFLL support for Tegra114
Date: Tue, 26 Aug 2025 15:25:14 +0900
Message-ID: <22816220.EfDdHjke4D@senjougahara>
In-Reply-To: <20250826061117.63643-1-clamor95@gmail.com>
References: <20250826061117.63643-1-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0234.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::6) To DM4PR12MB6494.namprd12.prod.outlook.com
 (2603:10b6:8:ba::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6494:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: b2803ce3-e2fc-4470-7341-08dde46953c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blhSd3dvbWdRNm56cGVQYW1EZVJGcEl0emluYVVrZXovc3dlZllvWk1BVjdK?=
 =?utf-8?B?UExRd0czeXMyaHlSeFhUV1IycDlNazVLRlRVK1ZyRjZubHI1RmVubEFJalZD?=
 =?utf-8?B?SGpsQnV0QTcrRE9UMERvZEc5RS9BWDBIU1hhRFNOVHJnN01WdW9qeVY2YmJh?=
 =?utf-8?B?azlQeGthK1hidW5Kc1lkUlJLcS9meU12cXRzTEhrV2NLNDhwckRiUWlhY2FS?=
 =?utf-8?B?NXJKM2hRb2NRdHRDNm9KMFE5eVhEa25tYWhHVEpOYVoycWJKQWFrN2FnMUhI?=
 =?utf-8?B?T0ROYUd5RnNib09aZ0VEcEhIa2gzTHNLY0pGM0lQVVBleGN0ODJIbm5CenM0?=
 =?utf-8?B?RHVabmJLb0RoNlh6cEFhRnB2ZlRpa3dFQTROcGw1UXdUQ01LMllybUMzelJT?=
 =?utf-8?B?WVU4Qk1LYjVmKzBkWjZxVWJxTE51M1YzMzhEYzNjNVJnMkhFcDBtYmNid05T?=
 =?utf-8?B?dGYvc0ljK2hWTDFsaUlnZW9ScVZkY1F4TXRYNVJiOHhtVm1mSk5IQkkxQ1VS?=
 =?utf-8?B?cENhbk9rUnowN1hHWFY3VjdHL3Z0Z2k1aCtoT2FyUXpBa3c2bWNYQmxCWG9i?=
 =?utf-8?B?c2FiMlE5YmRGWjZ5bGFSaGJxTlpXbDluZVk3WUN2YUY4U2xCb1JXbStNZTBp?=
 =?utf-8?B?RXJUaU9Vcjh1c1dlTHBZempSUitENkZuczEyRWtIM28zaUY0aVY1dHBJT2Ro?=
 =?utf-8?B?V3pXdEoxaGlZSTM2ekFRS2tnb0tnVnYvYmR1ZzdoVUFPcC9iM0NMZExWSGd6?=
 =?utf-8?B?OFRyMEZQZ21oWHp3eDF4U243TU9ERHI2cjAwZDgvTG16VlkzRklQVFpZak9W?=
 =?utf-8?B?OW5hOFBxSTZjRG4rRk9YTnhNb3JhZkFOZmpUMlREVVJoQjRRL2RLbEJOVS9r?=
 =?utf-8?B?RzFuczJaaVB2anNxc2ZkSTdYQVFtdGY1M1ZpeDE0dDhEbk5JZ25XbFRSNEJp?=
 =?utf-8?B?MWk4eEcvK1NJK3ppYkFHTGc4YjFBanlPVlVXOHBVMS9DZENucWlINUJJR1ZV?=
 =?utf-8?B?TXpmd1lNUmZ5UkFxcncyRDVsaDlsbHFBZDVzdlBkSEhLNXB6NGhYY0pJdUc0?=
 =?utf-8?B?MHltb2ErV2orNnhydmt3RnBncXNpdStwT3IyRlhwT09DaHdlSGJXZUZLTXFR?=
 =?utf-8?B?Ry92dDZZWXdGV3NWVlRmRG1tc1h1L3BuTFR4b0VwUVcxaWMzc3B3S0wzUlBn?=
 =?utf-8?B?MklCN0w5a0V4aXN4VFBDNklPZmpxQkttMjJEcis0dkdhMHBTYnZ3SjhqQ283?=
 =?utf-8?B?b0FENlNYaEVIMDFCWHdFNWpWTTRrcXNOV0Mwck1vNUR3R2ltaW12QjhHSzNh?=
 =?utf-8?B?MjdiaEZnTnJQZmFuVTJEejJ1QmxuVGNwVEN2R2hYNTVDUm1DdkVLZmVaN3NB?=
 =?utf-8?B?NU10RmlmRDhkV0NrUCtnSkFHanJCMXJCV0NzVnFaenkrMmt3U2VhMytjSUdZ?=
 =?utf-8?B?MUNUWkQvU0pDWHk1QmdzVHppQkVudVVvM2hwNWxUK3R4MkdXZzJIVDRBb2lx?=
 =?utf-8?B?UkhPNkdVVHVRR05DcGVMSW93dUgwaTc0MUxrc1didXNVNitXSkZKSGQxNm1S?=
 =?utf-8?B?eUVua1hQaEU2b0gzZ3FTQWcrOUtkMTZHbmZKaXAycGJtU29VTnN5U2l1bkph?=
 =?utf-8?B?d0tnaXpnWFFGbUp3NkZ0aFc5SmR3SnZvdEZ4aGxTOXFKUjZkQmQrWnExcjRh?=
 =?utf-8?B?SW5FRFl3S204NG1wNEtlZ3FTRTNhc3I3c1FQd0NqUVkrcDlCU1F2QXRzSkRO?=
 =?utf-8?B?LzJqU0ZJdVZNcHJ5Z3Y2cTlLQmZ1b3pDOTBPaEI5NHNlZmVvcE14S0xGeVdQ?=
 =?utf-8?B?UFBSOVFOQzJTTktGYnY2cXpNMjdKTVFnRnlONGtDbjdFZkpIU2puOEZjQ2hY?=
 =?utf-8?B?cTdETjlNc21MWnVIS0dxU3hiQkhBdlJTckgzVVVGRGZhNFExQVlnZGlhSlJx?=
 =?utf-8?B?OWdPWDdCZHZQNFVyaitVWDEvb2tvdnVKV3I0WUFEQksya2NFWXpyRWlRdXBI?=
 =?utf-8?B?VlA3Zk1pSDBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3lJeStJYTVzd3lXSEpHSHRnSnpzbk1uNEk5VTZMTHhvcVBoNURmVCtDcWJD?=
 =?utf-8?B?NWZ0d3E2YlNJRE1CZVgvdW1oampWdXR3Y2VXMitobnVXcFQ5TTZWTysvNTZi?=
 =?utf-8?B?bEQrWEZ6Z1czak9TcXJ2NE0wL2MvTUpQYU1SM2JKNW5uU0p5QlpaNDR4TExZ?=
 =?utf-8?B?b09uclZEbkRDV2hZS251QXhxK1FwZ2lnRE44eXRqaGZOL2FpUkdJRmJrREM1?=
 =?utf-8?B?cVhLL0JYYnFYQksyMzBBVlp1NllBajNzaWJYMzR4M1BYWGh6NC9lTThjejdy?=
 =?utf-8?B?alAzN0haQ3pXNkhtZzJBR0pSZUNSZWtzVmkvbUZBUUtyazZtZ2ZjV0xhOXll?=
 =?utf-8?B?Ym5XSm0yVlcvY3o0eXZjVkEwK3NzcXJydklWRU05WXFESzlJMTNYNkdweVky?=
 =?utf-8?B?UWNsMVY2YVIyNEJTeEczUHo1UGg5cXRrNmFwek5WUWxFNkFUK21wQUt3OE1n?=
 =?utf-8?B?OEZQdEZmNlBKUXJqcHNpaWZRRE9YemF5MVlyZ1BmMmdHNDkwVTBjWUxJY0tV?=
 =?utf-8?B?ckxXc1dkVmRPbHYyL3lNY08vVFh6LzdOTU8rbU1XNU16MElwMXk5N25jL0Nr?=
 =?utf-8?B?K1pMZ3NCM1JldHNnc29sbnVISkRRbVFuSW9uWld2dEkwTTYycVJyYVFLS01X?=
 =?utf-8?B?YTFaaldhdWhqYitQc2g0dGFzUXVFWWNNTCtwTjd6VnJ2RC9QTitTZTVJb0lG?=
 =?utf-8?B?SFVna215bnNMdXc1Z2dFTXI5UFk0VEQvY1Bab0RIek9pNStDR3kvRDA2YWxL?=
 =?utf-8?B?NytiWHV5UmxWQ0xqR3czMmk4Uk9xOHlMMnZmTWNEZWVmOWpJV0EzWHpKSGdu?=
 =?utf-8?B?Q0pVemF1dFRGRmRHOERjbUF6VnBvOUxvc0U1M0dZSHFFajAzalVkVEdqZXhl?=
 =?utf-8?B?b0xIM01XWSt6ZWl0SitaVkJiTzh0OC9pdEhjeVREWXZ0bGUyeVY2THA0Skph?=
 =?utf-8?B?SDhjMnVTTEZ5UW1kL2RFUEFDWXRIcmorSm5yUUZlbXdlZVZNNE1MdnhSTmZa?=
 =?utf-8?B?RmREWjYzT2dyb0FzK2YzZ0Fla0d5cjEvTXRaOTIxWTVlcjZKakFmQWcxb25l?=
 =?utf-8?B?Rk51MGNYSGNQOTVQUjgzTVZ1SFhoYWd3d2JTUXlUTlJiRHl2VFpPSUo1dy9X?=
 =?utf-8?B?Ry9sWnc0QzE2cnY0aVV2Wm9Ldkx3TGc1d3c4YVMwdUhoU1VLQTZaUjgyUWRQ?=
 =?utf-8?B?c01McW9oM1NUS2RmV00vY3BrZnJXQjNBdkxINkVvdVluWVpJQTBqeGhLaDRm?=
 =?utf-8?B?VGFFWlp6ZjVhT2RjYXFiUE5uQWpXTENXdGVBNkJZWFdTQm8xMEJqTnRVTjBW?=
 =?utf-8?B?djNTaGVIbnlzLzZ3S0lRNUR6ZFVCNUM5UmNHZVNrNlpEdlJ3aUxvaUttbDNZ?=
 =?utf-8?B?WlFHUHJtRHBGL3BlZEpRWllDYzFRQ3NhRCtqMWx1KzNMNC8rNDQ2U3JqdUM3?=
 =?utf-8?B?Vk8xeGc5M3N4RlhlVEZrUVBoM1d1VS94UVJNM2Znam5NQUE0ZTJzWlpBczhR?=
 =?utf-8?B?QlNPWGFwYzJQSm9FbG9mL21tK2NwK2VLV3VLVkV4akpsT0dkWmc2b0E0TzJr?=
 =?utf-8?B?ZkZHcFE2WnRmeXRDNktJQXVPZS91MW56Zlp0WHRsYSs4M25lVFFDTlluVGJR?=
 =?utf-8?B?QnBOVjNTQS9FcVVZbDd4RHJpQTFLb0h4c3NLOW9ENmJ2S2xPYi9FMnd4MUNK?=
 =?utf-8?B?WENEMWVIQ2FKUThXOWZncndobDMwK09VYWR2OG03ZmpLNWxYKzVoUEgrR2Jk?=
 =?utf-8?B?MG9SZUw0L09kbGlFR3pJaUR4OEhSWnRTdmY2aXYzUEhuaEhvaEc1cnJhamwx?=
 =?utf-8?B?ZTUxVlFJa1p1RUVjdlpySHErd3VDL3BYd2NJdlZ3WnFnaGxva21qc1hNaS9Q?=
 =?utf-8?B?RjQ2eFFXL3h0b0NONXhZRm1xOUg0bmQvRFFwTmcvbm8xelVCVGtCS3locUJB?=
 =?utf-8?B?d1lRMW9URUZBNmRvazV1UXExNkFZbmZ3UzQ2ZElISnpMRjhsaXl6R1crM0VX?=
 =?utf-8?B?ZWZBdXU4Q3hydi9qNkJUTzlmY05FcVA2RDNzZml4NklscitKMDI5UXVSbFc4?=
 =?utf-8?B?OGxjZWVsLzY1Z3JvQ3JERkVva1JOeVI2Zm9VbnNjV2ZZRXdLb0oydFlVcElH?=
 =?utf-8?B?eHJ5SmxEVGhIVWJkMnh5dGNUZFBMcFV2Z0d3K1R6bGtOOU5yN0FtUGpmWFJw?=
 =?utf-8?B?dktwSUROK1piSlZDUmJQUi9kNlQrM1FZeTB6N1BJWVk0MGpPNFFJZmZBdHdG?=
 =?utf-8?B?YWFZQVhoUkZUOERKaXZNb2k2VXZRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2803ce3-e2fc-4470-7341-08dde46953c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 06:25:18.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btkgMeE8ZBfLYWH92DnWDnS4UdzTHakgXDxV6pnOvI1SIfaLMwBBc6QsZ7BfD+CioeuU8Du8DxQlhmU/ppIaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493

On Tuesday, August 26, 2025 3:11=E2=80=AFPM Svyatoslav Ryhel wrote:
> DFLL is a dedicated clock source for the Fast CPU. The DFLL is based on
> a ring oscillator and translates voltage changes into frequency
> compensation changes needed to prevent the CPU from failing and is
> essential for correct CPU frequency scaling.
>=20
> ---
> Changes in v2:
> - dropped 'drivers:' from commit title
> - aligned naming to Tegra114
>=20
> Changes in v3:
> - add DFLL support for Tegra 114 was split into dt header addition,
>   DFLL reset configuration and CVB tables implementation.
> - added cleaner commit message to dt header commit
> - added T210_ prefixes to Tegra210 CVB table macros
> ---
>=20
> Svyatoslav Ryhel (4):
>   dt-bindings: reset: add Tegra114 car header
>   clk: tegra: add DFLL DVCO reset control for Tegra114
>   clk: tegra: dfll: add CVB tables for Tegra114
>   ARM: tegra: Add DFLL clock support for Tegra114
>=20
>  arch/arm/boot/dts/nvidia/tegra114.dtsi     |  33 +++++
>  drivers/clk/tegra/Kconfig                  |   2 +-
>  drivers/clk/tegra/clk-tegra114.c           |  30 +++-
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 158 +++++++++++++++++----
>  drivers/clk/tegra/clk.h                    |   2 -
>  include/dt-bindings/reset/tegra114-car.h   |  13 ++
>  6 files changed, 204 insertions(+), 34 deletions(-)
>  create mode 100644 include/dt-bindings/reset/tegra114-car.h

Whole series,

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




