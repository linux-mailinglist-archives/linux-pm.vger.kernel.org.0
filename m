Return-Path: <linux-pm+bounces-29733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF31AEC532
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 07:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAF41C22538
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 05:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBF71F4C9F;
	Sat, 28 Jun 2025 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WLqf4oow"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70793184F;
	Sat, 28 Jun 2025 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751088691; cv=fail; b=gm11x/Gm0hplyNvLUDNTTVP93ERXeclrDqKKD0ncQeAiklb4I2QGQ4X6Mthe1R4SILzmwUuNfjPAR3BjXCbaMhC9Av6z2VOspEHSppqyIUCufUKKm1OnOjkcnLUHdG9uLcXJGaRD7uyXxg0gL38oe5XbV71SjC4Y9XOocxNnBRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751088691; c=relaxed/simple;
	bh=hTkXBNFwcnKVtH3Nssm0FSv5sQZu+UQSPNnTVf+jmlY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ejD3nY1FU1mVHwlOg7y0QsVqJC/Q8Br1B/EEZ106Xma25rS574qz0XXCm52CXGyD4rBs4SP7swS5YtAh2tqOtPlGI4RwicRPkdEUl+u+SDBj+KVVpDLy/FqyvdMDAvqUfRBKzU4ESzIZunqm/+2maImFvV+FkxUn3SBwU81zPBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WLqf4oow; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2Inm/DaTg0cVDAWhH3d636HbblWjIjSxfcz1Ia853hWtL7c7sIBOD5pLoY50J1Aq4TCrkPxq+YDU2sxUM/Rv6C7PaHjZX8+HjpO3uzAOn8uvFpMtzyC+YRdi00Nsc8s4iLrj6uK3xGjd9uChr2nBwbqoG3fDUibwnReABVMqyHKIKfiiPFpPzGpj2i61Mwj5J1QP1s/E26XIHj1OvG4ufAIv7JBwgP1NFH5uMxZt/iFrUgi+qu+b2nr4UjpJe5nssbLplP4PVtqfVELH80fJ38N9A71kmFauZsEe9EZTpoDViq74gq4CbaaZpPBUFnQ4oEGqNcNFGHaFyY5oNRmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYovVHp7Yq12m7xdNAQJR8LUkfUf1Gl4T8FEPZPRxVQ=;
 b=oZRucJoJlUzSc0O4NDGeV5muu5GAXbn/DPe492iZL8Pb7JZl+VhJ8TkvRcljSvtELXPWFNjuNn5JKddlOp5jnj+lWcFIUWPYTlBA1u4uSlW3iBcEnH+aOsYP8pYu20fH0L22UIJT/q4mqppQ4f8TB9PjtMF/Il550dVCWPn/yqZ5ie/fz0B7YQxfCURzDpsCNyciBcDYYNAFtGJXGnORVmbQvyVYeYf5C5IgfoKBa+mT1TertGEo7Kr4JC8bqKasjQ+rl0PKU+IlN6V9pGpdNAWU9lbQtyrKJeTs97VpF23iDIoPDMbNd5hfh5CdkzRM5av/TjGrfdGZaMiF618xyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYovVHp7Yq12m7xdNAQJR8LUkfUf1Gl4T8FEPZPRxVQ=;
 b=WLqf4oow63I4/lwBCzZ6PQSuIymuP3bg0rq6Dii65vf/0l1JO1iQZLukXNRWaJm6qUJVKNTOigzfV5kDwgqf6Ia4V6Jc610aEEp+/eY8/6Kd+sJsFf1v+Fp10B7AnHCbvCSQE6pFhh7p3Khce+FPMGio+Kz1vDriiQFXgXE4zyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 28 Jun
 2025 05:31:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8880.021; Sat, 28 Jun 2025
 05:31:24 +0000
Message-ID: <f3667820-b911-4b31-ba41-e5b8d59e5065@amd.com>
Date: Sat, 28 Jun 2025 00:31:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like
 parents and async consumers like children
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Saravana Kannan <saravanak@google.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <5011988.GXAFRqVoOG@rjwysocki.net>
 <CAPDyKFpBTz0M8DmWHLLm7x4c8G5PpQNv0Zj7mrZ9BewTBi1skg@mail.gmail.com>
 <5a6d0684-3340-43ed-b520-933654515943@amd.com>
 <CAJZ5v0iJ65xxuHtJrWp1sC76FUzPHNpXB+xtHB=e4qTRSgAC4w@mail.gmail.com>
 <0412561d-6ed3-4823-b510-8600fd4fd1fa@amd.com>
 <CAJZ5v0iRomtiFhYTndO016=zH+vDMkxJgq+EvqYfTFs-+cC8tA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0iRomtiFhYTndO016=zH+vDMkxJgq+EvqYfTFs-+cC8tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:806:125::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: 17122ed9-ebf5-4173-2d96-08ddb6050522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVZ1S2RDa1Q1WVE1WW5wcGpxUlNZblVmbSsxbTBXL0w0elp5ZGN1ZS8yODNz?=
 =?utf-8?B?ODhvbFRqN1BCMzRqNzlRNVgwbnhmcGFGY2tmN1A4Q0EwSnVCV0JMQ0hYTkt1?=
 =?utf-8?B?dEVabCtvL3IreVZjS3QzSm9zVTF0VmQ1MjZXREdNNXVQanVrK2lqY21yTTUr?=
 =?utf-8?B?YlZabnNIR3Q4ZUcvNzR2NU1vbkpQdzEwZkVxeUV3ZjJ2akt2VnNkRlRLUjJz?=
 =?utf-8?B?UXJjd2t1Y1k5dXdoSEdORytxRTJrdWZOVnpYTkt1OXh6RUVuZy80N2NtZFlQ?=
 =?utf-8?B?cDUrMWFlbEZXYUdXNW9TK2JhazliWFViWEp4RmxaM21KTXQ1TUhDVnk2Rmlz?=
 =?utf-8?B?R0cydnBIT09IaWZQakwzWStxeCtWcS8xNUNUenZKZCtieThXdFRZOGtGY0RL?=
 =?utf-8?B?bTQvOU16cXh5Sm1ZdzBaaUJJTmFOWnlobFM4a1BBMUN4THZDSlZrTUxEZTZw?=
 =?utf-8?B?REZTVGNiOWtBZXpiblBOZWttNlZRUXo1SzhpdXE3WUFHZ2VkcnJRRlFTbzFn?=
 =?utf-8?B?Y1YyT2dvYmI3aWhTZUNwYXc4Vy9JRFNXQ3VtOFdtcjBQZndISW5rbW10ZFZl?=
 =?utf-8?B?RmdzaTRqb0xMazBVSmtwa3luOTI0WDRiN2w5UWpWUEFBOWZmOGFjTmtNOWVF?=
 =?utf-8?B?bVVleTNib2htclJsL0IrOGZpWThkUkl0TG1aL0ZjRTJvbGZWZ0h0V1k4OGNl?=
 =?utf-8?B?R1JQSy9yNUUxNFpxbnhBYnQxVks2cldFazhZOVlGTlo2R1JTRHllL01BalZr?=
 =?utf-8?B?TjVwM2lMbHZxV0NFUHNCam5EbGVUMGZrV1BmbWdldEh5SGhwdFFvczBURHR0?=
 =?utf-8?B?VE5FUS9tcjBSL3o2eXFON25mWVF4anVOUUtCMm93NUdhWUkxSHVJVDVsdkV5?=
 =?utf-8?B?cGV5Y0dHQ2RTMXVoTVhwNlg5aG9QZzJJNU84TExZYWJneXFRTWZtUU93c09W?=
 =?utf-8?B?S0IraE1KR3djcndyMTZIMkJwM0luWm8wRlErNFJVZlN0NWRiU1A0UFliNnA5?=
 =?utf-8?B?NncyWGo0RWRmQkVxNXhtRjhXR0EzUmtqclhKTUQya2xxelFWZTh4cEg4TWZW?=
 =?utf-8?B?eUhpb29rSXliU1BReFJkdzc5UjdERE5mZ0lkemhPbnc3MnpJallTMEU1WkNM?=
 =?utf-8?B?M0JmY2lGbmxialA5WGRxWVNDeW9EUmNWWWg2WXQ2RENPMEh2RzBZcVN2Y1hD?=
 =?utf-8?B?YVRjbnZTYmFTbTRPYjBRY2pzRytOTWF1d2pHTitZOE9jN0lpRmgrTzBZVFV5?=
 =?utf-8?B?VDFDc3ArR2N0dS9iOFU4eERqM1Vob21od0VyazJmdjYrMXl0OWR0bUc2MSts?=
 =?utf-8?B?NmlMMzM3OGNlall5QmNzQkVLWlNWQ0Jzazl3R0FyWkJEY3UxQXlySEVvT0tC?=
 =?utf-8?B?SnUxMFBaWUlRalpFdVNDOE14YTJRSzAvOVNVQlBTbjVqcjVxRUlyVVZxVEZH?=
 =?utf-8?B?OTFDQ0s3WWdKVDdBaVpOZXFhanBESmVXVjE1UzZCaDNHNmdaN2Q2djZIeXpE?=
 =?utf-8?B?dEZ3KzFOVFFESHQweGsybjlaN0lJRGFjZ3VyQkl6OGM1Zlp0eWt2RGpXWUhH?=
 =?utf-8?B?Qi96ZjlCamxKMzNYcmVUbVJkZWVwa003YjZzam9ubFV4K01uS2pQaitLK0ZP?=
 =?utf-8?B?M0VGNUljNlVMNzlxWkZFZTQxTWh5d0VaYTAvN2JqMmlrOWk1VTdVRCtMK0dU?=
 =?utf-8?B?Q3UrbkN2VFdvcE12a25uRTh2a0k0U2xGaGljbDNDVUtQMG4zN2JQZlAveExw?=
 =?utf-8?B?R1B6aVE1WHh5bWdKVWZCbUJ2UEFrclZKdVRxK2gvaTRwQTc0S2VjYVBVR3ho?=
 =?utf-8?B?SnJibFVpRTBTZDhzM3YzeXRLZ3U3SzBhR0hFQTVnVlJJY3dBakh4T0ZpR0gz?=
 =?utf-8?B?WTIzRHVwQW1zOW1Sdmp4YU9RWWRaNDJ3dmpzdmZQSXNrUjIvSGZyc2x0RnpX?=
 =?utf-8?Q?w93kfQW1cFo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGtLdnEyelVwZTNPOGNiZ1YzV1ZVR3lmRWZhdGZKSU11T3FPcUdsbVZPWnQ1?=
 =?utf-8?B?QTU0NE83YVE3VmxRRFdsaW1oM01mbEs4WC96NHAzcVNZTzZEZko1ZUFQL1dU?=
 =?utf-8?B?VysxQlNBQmV5Z1U3d2dwTi9iSFhvMmNzVEh2cnppM0ZTNUV4cDYxaVRqdTdE?=
 =?utf-8?B?Qk80Mll0eDVrYkZ2VjFVbzlmeVRwd2xVVk5mM25Mcnd2bDdXcEsxbGZaV0ww?=
 =?utf-8?B?WFVOakg0RERsb2piZ0lOZElRL044SHd3V1lNSjd4WVFSRDlENHRHQ0NMQ3VL?=
 =?utf-8?B?Z3Ezc2hWS3UwRzlja0ppblp2RmhEK3BwUmVoSENIWmhDOUNnUHBGKzZwdkhy?=
 =?utf-8?B?aHJ4ZGsxcDdORXJhbXl4RlZ0MXJJQUYvcnhEdFVHTnJZcDVDNCtLd2NiVnc3?=
 =?utf-8?B?TFZVeTY4K1poT3RDUWFmeks2S0VBdEYrMlJMbnc4TnMrUEYzNlJvUDczeDQz?=
 =?utf-8?B?RExpbzRjT1RQVEQ2N2lQUjFRTUhhWXoyM3BhclNlUlRHMXdJRFVRbzlZMTZw?=
 =?utf-8?B?MWdHcWVoVVgrSGc0dERHRVpNcEVnZmkvdzhXZVN6dHpCcitlMUZteVA1SHFv?=
 =?utf-8?B?cTZybFliSW9NRkFxYS96UzFFaS9pNWx4MmJCSC9FYXBtQkc5SDZGS1pyOFIx?=
 =?utf-8?B?MnRwR3RBYWluUEdFbDNhOWtEdnliTE1vYzB3UEJRNUQ2S2NacDZ4UHVWbFky?=
 =?utf-8?B?QVRwWEUvell3N3ZsYkFiakNYeDBvUlRCVmdDbDQ5TXN1WEE1NE9waEkwMU05?=
 =?utf-8?B?OHI1L1NqQVp0M01PaDFTdDVxc3llNEUvb2RQSUZ2RS9QYnB4aFc1ZjRGN2ZP?=
 =?utf-8?B?RlMvdmI1VjR1eXpDTEhFLzFueE01akdNcU1LNDZEenYyN0dodllrLzZEWlR2?=
 =?utf-8?B?dWJCWitRRE1PUE5kWUZaU2diOFJiZFNPVzlucnlsR0hWaXBpYkhuamoyWlNU?=
 =?utf-8?B?UmU3Q3dMRWN1SFVqa3pPNkZyUXgvQnNUSE5CODVIV2dDeGYzRHZ3UjVjK3Rt?=
 =?utf-8?B?dlZDT3kraDU2MktFeUlndEVweVp4TEdmMGs3OWlnc2g5dTJjVVNUOUJid3d0?=
 =?utf-8?B?amdYdi9QaXJRanZJRHBUTkFvbUxqNitWSEJuTHpRY2NYc05BNStURzgxbUJ1?=
 =?utf-8?B?UEw5d3h6VjdobmpMSFZiSWRlb1pvaEJyMUpNZlg2b09GMjhBK1lpYjVKaHEr?=
 =?utf-8?B?ajczakFZR0xmZkh1aHplcmRxcWk1cnNpdnV2N2N3Q0x1Mk9JQnR3VXVYQTdB?=
 =?utf-8?B?K1hFelVwM3NsYXpxYmtiRnFYeUhDS3NBaUlidG9PZTlmWllxNjhHaVE2TDZl?=
 =?utf-8?B?dmZHZjhReW5pVUJNcjY4QWtueDNNb0NXRHczSDB2K2R4ZEhIMVYyMkFFV3d4?=
 =?utf-8?B?VDZuWXpKNm40M3o5TWdrRngvWXIvU3UzU041WnJFMDRidWpIRVBXUGJsbVIx?=
 =?utf-8?B?ems3M2tqQk80SHBLcFNvVndtYWhDd1ZpWjEyc252MU8xRTRxYi9jdE14Z1ZK?=
 =?utf-8?B?cVhGWG9uK0JQTUFPR2JGKytaNlVxRVAxYWFYUnVYNnltcnBMME9tU3ZoeFp3?=
 =?utf-8?B?VTg4L1FvSFE5U0EwMG1SU05IUXdnTnFKWWFNbUhEMU9obXV1VUNOSXZRaDVI?=
 =?utf-8?B?SGZ4ZVdwZkk3YVVIUDNyUWo1ei9zVGM4VXB2alo1bnBHWHR3NE9SRVFCYlgr?=
 =?utf-8?B?VExCRkZBbGhMWmp5RThHeUFESlU5ZGpOMEZwcWhnSzNKeGRUcnovZ2gydnV5?=
 =?utf-8?B?WG5Ra0VBd3lhWTJoM0gyamx3dFVDUm92V3JrQkJNL0FnWG8waVl5a0NJZWJp?=
 =?utf-8?B?MnF5TkVkemFuRVJkUklkRW9xcGZJVUFBOWhYZnhpT0h2empLTysyTkxacDNh?=
 =?utf-8?B?OXJmY3lETTl4OW81MURqOUJFTnEyZFFFb3RPQ3VKeCsxUXMvU2tBaGI2K1FV?=
 =?utf-8?B?SGlGT1hsNWQ5UUZINStvUkFkQmRSRytTLzFPRWZMS1BsdnIvWVVFYkkreGpJ?=
 =?utf-8?B?N2hUakthdVJZaVcyc0V4WU5wN2pIcmpGazY0djNQQzhVMGhlOVZId1FvdzRD?=
 =?utf-8?B?M0RVNmFETlZvb2h3TUpwb29zQjdyV2FzTS93OGlWTW5yUmttTkZsa0ZHVUtK?=
 =?utf-8?Q?M4R8iSw7RYvUk0PFgERd8P0vR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17122ed9-ebf5-4173-2d96-08ddb6050522
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 05:31:24.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoMgglMpfI1SNurAX0KFBy2VQabKxL2vysVlFB79i+FMLPZSk/yb/s3GAJq+w7XlMWLxBk/z9SqlBGizZ2hF5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479

On 6/27/2025 12:31 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 27, 2025 at 4:01 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 6/27/2025 5:40 AM, Rafael J. Wysocki wrote:
>>> On Fri, Jun 27, 2025 at 12:28 AM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 6/26/2025 4:46 AM, Ulf Hansson wrote:
>>>>> On Mon, 23 Jun 2025 at 14:55, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>>>
>>>>>> Hi Everyone,
>>>>>>
>>>>>> These two patches complement the recently made PM core changes related to
>>>>>> the async suspend and resume of devices.  They should apply on top of
>>>>>> 6.16-rc3.
>>>>>>
>>>>>> They were sent along with the other changes mentioned above:
>>>>>>
>>>>>> https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
>>>>>> https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/
>>>>>>
>>>>>> (and this is v4 because they have been rebased in the meantime), but they don't
>>>>>> make any difference on my test-bed x86 systems, so I'd appreciate a confirmation
>>>>>> that they are actually needed on ARM (or another architecture using DT).
>>>>>>
>>>>>> Thanks!
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> I haven't yet got the time to test these, but the code looks good to
>>>>> me, so feel free to add for the series:
>>>>>
>>>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>
>>>>> Kind regards
>>>>> Uffe
>>>>
>>>> I passed this series to some internal guys to test on a wide variety of
>>>> AMD x86 hardware.  The initial testing looks good.
>>>> Will keep you apprised if anything pops up.
>>>
>>> Thanks!
>>>
>>> It would also help if you could check whether or not there is any
>>> measurable performance (that is, system suspend and resume time)
>>> difference between "before" and "after".
>>
>> Sure thing.
>>
>> Just to make sure we have an aligned measurement methodology:
>>
>> I asked them to do this both with and without the patches.
>>
>> * set /sys/power/pm_debug_messages before running and then capture all
>> the timing prints.
>> * add up all suspend events and get a total
>> * add up all resume events and get a total
>> * repeat 5 times
>> * calculate averages for the 5 runs
> 
> Sounds good!

This is across two different systems.

The first one didn't have a very large difference in average (20ms)

KRK No patch
Suspend 235.6862
Resume 2220.3976

KRK patch
Suspend 233.3544
Resume 2202.199

The second one had about a 15% drop in average suspend time; but I think 
I suspect this isn't a big enough data sample.  I say that because both 
sides had one cycle take longer than the rest on avearge.

STX nopatch
Suspend 774.39638
Resume 1893.5252

STX patch
Suspend 651.9756
Resume 1895.725

If I exclude that long cycle on both (so average of 4) the drop is 10%

STX No patch
Suspend 319.353725
Resume 2256.0025

STX patch
Suspend	292.482
Resume 2257.27


I'm personally thinking 5 cycles isn't enough for showing "real" gains 
are there.
Probably need a much larger sample size to get statistically relevant 
numbers.

