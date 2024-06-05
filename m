Return-Path: <linux-pm+bounces-8665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B16CC8FD78A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAE0B2144A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C342A15ECC7;
	Wed,  5 Jun 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BrB2Wvnv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B27347A;
	Wed,  5 Jun 2024 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619562; cv=fail; b=hTK5zJZZFGgr5sXab+dXBnVLp009wzbCwzOfFVnoKbrzWS7UtsxLu4RzSscH0fgMrRzsBY1ZFiphWmuFyjOHNRKN0lxnPtdM4/dXDf/E2NorcZulSdZQs6HyadQ/OFHuu8IkoIG4UHc4h0aniQdxpHz9kbb6juh2IY2BBByjCCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619562; c=relaxed/simple;
	bh=6SDlY6qfK3cD8NM13w8wV88qbAajROwxP2vMsB3ULbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyXefWQQZwafzCCqWOY5KV1ByfpMmkZZIm4edhWwgM35mRoskxSx4IXNJ5gpsWLwk9mvKini3qqZzFHNDjowcR/jzS2biD7JBxhQSgxB/qzGktUSTK4X0vOCt3JuPmdnWe9eL6AvSJ0F7uOt2gV6ZsquITPMVh37o/9pChf4X38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BrB2Wvnv; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elcrhypYWQHrdETEpXibRf9zZFIAQ56QIOOV2MdLxB1xaK3SwAKdu645SnMB0JP0g0xLdAJHZ1JzQ184fNvH5CDIMwxacKly2FKQcOHmlanuFS2dB5UD/MUpEPnFDGax9ztpCJ9E61MuGYbdOdCzFdHr/ywIges6Kmlf+kelLR5ZY6K2dhG7IR7W+8yPnUJ2eyjpVo21M/s7nagCYhi/v/nqT4jvzT/qihqftZ+6qeFx5GyqnNqGm2T+1n6Oip5F+W55cy+o+BcAoSX5G2yI+O6pHtD+tdF6DwNgaI22id+dI7+kHvLKHiMajn4omHEDLT7ioK3QNXf2Qx1iwzwuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKF95yzeXkL/7sXgFjizzwVYc7MmYuBK2dWvQ0N34jA=;
 b=jgBNO1qemvxQ9ZQ42UA5jdyUzOnVKzkP4bmlHsXcm9wnfbENrv9iobpddA5qMmeo0hQ3E+xoDkg8N11IR10C/G57ltBeZLzSXJxuXkYLFYOrAVzQQANrvElABhLCIDdELvz4MDV7WyLBWhU30FLOfx5QVrpw2lAgweJE6D3UqClPk9zgNuTNrhMffJskaj6KMVOfei8CW1sWZvp77rPaZMReaEC6zCCmcy1UUJwGkvNMnSOSdHhwlWzU7mvfhiVO9VlUi9jt8Kg2uA1C2wS446ac2VmZb40hNY4VLexBDKtOVT37IGNFK2lp1035OxvjvYDo2SfTz0+rNgn1KDYIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKF95yzeXkL/7sXgFjizzwVYc7MmYuBK2dWvQ0N34jA=;
 b=BrB2WvnvvC5aOvo9mEJmewty8VJYxA048vmZbfbbn7yVveeS/UFLYXKoSD6Zx1lyytzT0pp2jHXSOGndHo5Q98BK6DIh4d6/EHwevI3ra4msAsSCKLkSZSIuQrTFo9h/XfyMF7zUac57tlUNIFvHl0x5PYEXyku4QH0nOH7NA9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 5 Jun
 2024 20:32:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 20:32:36 +0000
Message-ID: <db20a640-5323-4866-9968-c57391fbb6bc@amd.com>
Date: Wed, 5 Jun 2024 15:32:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] ChromeOS Embedded Controller charge control driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Dustin Howett <dustin@howett.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Stephen Horvath <s.horvath@outlook.com.au>,
 Rajas Paranjpe <paranjperajas@gmail.com>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <CA+BfgNJByawxkZukaCXYcmOo_K9aQ0W1x8B6Y+Hyg_fZaJ4axw@mail.gmail.com>
 <5baf3caf-dc09-4829-96db-2666fc902710@t-8ch.de>
 <CA+BfgN+LE3YyF3te4m8sWbtH85tU+ERUDW7YR_BFecusVTAWWw@mail.gmail.com>
 <a527a3fd-1458-43cc-aac0-0b360beeb349@t-8ch.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a527a3fd-1458-43cc-aac0-0b360beeb349@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:805:66::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: f10d5edf-66d2-4453-6f78-08dc859ea2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WERJQUNCSWkxUTRGTEczd3V3dDMrNW42OThiMlkwZEJWcFdwcEZLZy92MGth?=
 =?utf-8?B?SmEvK2JKRnZhZkliekpUOEpiR0JuY1BUYlFWdHhaNk4wQTJBUkJIZVFIMU5V?=
 =?utf-8?B?c04vMDR3bnZKSFlrT1VjZXJFcXg5YlhVQVJnMFFWM0w0L0NZcEZwZVBqSGpR?=
 =?utf-8?B?SXdjMlVMZndGaWtxRUlROW9POFBsREVzUys1OGMwMTh4L2dDd1czNG1HcHRl?=
 =?utf-8?B?WVNlamtTRkpoM1p4SUs3OWJUaDRXazFVRDhhSjBwUXFwZjA2NVFQY2I3VlZu?=
 =?utf-8?B?aWhUdXRLaWs2ZU12Qm1ZaHl0MDc1M3dLeUNlUzZUcC9uRzBGd2hobU5na3Fr?=
 =?utf-8?B?RW5rMElESzVOVDU5VC9WaUFOeTJWNHNQbU4xak9QbDM2NlVjdlEraVUxKzJm?=
 =?utf-8?B?eFpRVGtOU0lIN2Q5aVpMSXR1L2hCNjR2TDJZclVpWjBKeFZ1dmRJMDFpckV0?=
 =?utf-8?B?SGJoam8xUmIwbEJYOFMwcjU4Uk9nbWI1clJJWXZnYUEzZG5Ec2xJU2lhbXQ1?=
 =?utf-8?B?QTIyUDJCUXg4UTRvZiszSWRXdXl4LzZDRDJkQjd3dkJlZTlQSUE3Njc4TXlV?=
 =?utf-8?B?RGF2K2xabTlZYW5NbnZzUDA4RDAwY2RPTW1aU3dVWUE1K2VIQTBlcTVBRFly?=
 =?utf-8?B?b3dBN2h0SUh5eE9PdFhLcUNwV0lYOEpxRlQwc0xZNTFIMEhVUUUvOHpNL2pU?=
 =?utf-8?B?bXI0QTFZTmhkaDZaM1FvSmo0RXpPVDJKVXJtMzhLbFZneGpqaCticTNsQU5I?=
 =?utf-8?B?R0F1cDZCL015UCsxNG1XT1RvOUJNLzR1amIxUHR3Wnl1ZkwzdlhCc3JCQ29P?=
 =?utf-8?B?aVh6VDdaT2ljTkN0d0wxSnU4VmczWUU1SjRScmxITEVWRUgyYWNjVDArMldI?=
 =?utf-8?B?REEzaFV3Wmt0Uy9BOHJaSTIvVXVUZ3lSQW9wbnF1RzRrdndiNUJzRUE1MkJX?=
 =?utf-8?B?U25jaWtBcnpITUNrcldlc2FlZXQwdExXNDg5Zi85UzVJdjFDVHlHK3kxNElj?=
 =?utf-8?B?ZmcrUmVGMHZ4MU4rOG9RcFFzSUxXV2hiMWMvcnQ3ekNPR1hRRHVWUzNPckw3?=
 =?utf-8?B?aEhCamZJTXdRT216RHljNFo0NGM1TDNNWURWM2NqczJsYXNzdXEzMDh5MkRt?=
 =?utf-8?B?dC9yQ2hybEVuaFZIRU8yVW1JUW5TK2dET3Y4bTlPMDkwMVpkZE9iRzkwUmZx?=
 =?utf-8?B?T09PVW9seXFDdjh2dUhTNlk4Qm5TWEtvQnFGZGJFM01wUVQyUjNBK3l1dE56?=
 =?utf-8?B?a1RpaHREL2RsekJrcElEU1U3bVhZaHNZOUltRm5NaW9PVE5SKzhFMkFSVUVw?=
 =?utf-8?B?NWY2UVBwSjRTdXFSai9XNHc0MEZXR05PcmMvdXlDL1ZvdEU0WlI3ZmN2VjRq?=
 =?utf-8?B?TUhHSC9uRVRUMm9WT2ZtRWhZV3Qxd3l2b09JTGxITVloaFFuVXlJUFlERnNU?=
 =?utf-8?B?ZVRYdnM0STU4TittcFNYNytzWGszTmJkK0JrTENZR3dIMVNUb0RyQ0EyY2E3?=
 =?utf-8?B?VVltRHh5ZnVybnZyNVpSZVZTcTNsU1VPdEVUZE9sUnRFd3gzNWsyQ3hURE9R?=
 =?utf-8?B?cC9WR3Y5bU5rejZ0TGJZVjNIdW4wTkdTNVkvWlArWm1TNEpFMlE5cCt0R2pX?=
 =?utf-8?B?YVJDNkJQay9OOGR5OFJ6OHYvaW4wMXNteHFVMTl5VGtjN3cxcCtXM0VmZXVy?=
 =?utf-8?B?SktMdklSdDBXQ3V6VXpmLzlYQmVVanZVOFhnS2lhRE5BT2ErOGViTGk0S3F1?=
 =?utf-8?Q?0Lp4YQEw06MR6O4/A9BhTFOmyRbED4pGqltaaDO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFg1a0k2Z1JGT1pJd1RIcFdOMGE4M29WMWdLcWJMeStlYmlVbnRKYitFSmwv?=
 =?utf-8?B?Tm5weDBIRWJ3ajhjUTN1MTZwc0N3Y05kUlVTcEpoN09QUmFhU2pvMXlZdTdH?=
 =?utf-8?B?TlBXYkJxR1BsOXRkVXd6S1d3a3JOdzM3OThZdTR6MmdRaUlOY0pCZUFKWGhq?=
 =?utf-8?B?aTVvOVR6U25VektqR2huUXVTRjRzRy80SzkyY3RCZWxwRW9adEhHUDhMV0g2?=
 =?utf-8?B?REdlanFKcGxXaThuekhCU0d3ZjZPUTU0Q1JaYURGRVZndmVxNVdqU0YxUGdu?=
 =?utf-8?B?ekJXSzdBWkl0U0VQUDlQZmlzT0xreG56ejE2R3NZZjIyNDZiWjNybVN3N041?=
 =?utf-8?B?NkpKYVIzK2tHRzI0cFYyZGpHNzhTU0RlMWdpRDZJUXZ4NllmZExYeUwrUk1u?=
 =?utf-8?B?TXhyREZ1ZXF1SUN5Q0pHVk9lbVliK3JLOU0zRE5wTVp4aTZKaHdWbnpBajZN?=
 =?utf-8?B?bTBzb3hrNW1lRUpyWHFSd3IyRmQ0OTF3ZmRTMld3VGJ5NXRqQVBtVHZTMjR3?=
 =?utf-8?B?S1hzTjgycjVuYTZPbmdKYWhuRiszUnpIbEVodDRGQU9Oai85Rm5MK0VDcWFQ?=
 =?utf-8?B?N2JTaXRQbSs1SEhueFp5SnozcERaZThxQ2lqZ1BGc1pIOW5wam9QUVBNY0Nn?=
 =?utf-8?B?cVB6bzU5VlQwOXFZSSs1S3plNjlkamZZTGg2WncvalRuUmhpRlk1ZUxqd0Iv?=
 =?utf-8?B?NXhuUGhISWNndVlJVG9USlQwM3V1Zko0T0szMXV4cTk4bE5nN2Z5TlpjMmta?=
 =?utf-8?B?NDM5Z2FGcHJuKzF2RmNsTnl1UCtWRk54a3E4YWJVMG9VWDBHU3BPUVhIeDBp?=
 =?utf-8?B?RXoyTzNqM3pZcGhQU09NcmhhenhYVWw0U0RML09DT0ttV3VWZjNOdklWSHhH?=
 =?utf-8?B?eVF4WDVPNWkzZkxlWEp1am9tT1JZaGU2RjJLc1J1OGVPM0FYNzExR2htN1NQ?=
 =?utf-8?B?QWhXT3I5UVhOdGRSeG5zUGtpUmNOZC9hU2RhSVRMUHJ6N2g3eityNktMUkdC?=
 =?utf-8?B?UGxNck1qb3dKZWJ4S1pxYjAzTG43YUtRVEo5a0lQOWttaS9XTEdXRm1ZOHd0?=
 =?utf-8?B?T3EzTVdxdFpnb1djODBZSlhPRGlza1MxSWxlN2VGREhGa1V2YnNadWJEa2hB?=
 =?utf-8?B?N3I4cTFvbXZNcHJSSnlxU3Z2WDBnRlVBc1lQUkR6RytGSUJqaDRFVDRoS2RF?=
 =?utf-8?B?eVhvNTFpQ3JoM1ZXaFl2K283WTgrcXRyV1FIelhIUDVlVkdUL00yRFMxVHIr?=
 =?utf-8?B?TzlCUHhnSWU5Y0VsN1hyMmZzZ3RXd0FvYjRmMG1IWXRSV1FCWXJibnhZMGxu?=
 =?utf-8?B?UkFJWHFPUGpBaCtxVFF4YUQ2bFJiNHFMVm9qZkFuZm5IN2Q3dVdCUytlOEF4?=
 =?utf-8?B?TGUwZWwyNFQ4eTdCVWJvSmxDU1Fid1F3OCtkMzBZMUl3TkJqcG1IcTlHM3Iz?=
 =?utf-8?B?ZTNLa1hTajVLZjN1S2JYUDUvVSt3SWQzTm9ydVFYeFpRNUl5Q084czhSY2tO?=
 =?utf-8?B?aE43QWdSYXdzRDVPakRSSHdtQ2xOcjZkQ1VqbDVLUkwyL1loZGhDaXlPb0NF?=
 =?utf-8?B?NzNhbGV3cXJLZk43YStFU0JKK0NnVExVckwrV0ZHT1AzekNjSEx1OWdwSG4v?=
 =?utf-8?B?a1M0K1NaQ3FFTXpDcDhVME8xYkZDK2MyMmFHQy9KcmlxcDlITU1YZTcrbURl?=
 =?utf-8?B?cDk0aDRhZWFFQkUyQ0NqYnpwM1ZVN2ZsUUhqdEZIZzYyUHlDQWlma0pVVk9P?=
 =?utf-8?B?TkZGM1kzWE5FbEZONERLRmlKM2ZtbUF4c1FJSjNoK1VnaU9UcmVwOFJOK2xW?=
 =?utf-8?B?TkQ3NHZTZU1sTVJxM00rMWlTZzNlUG5wRGFiZDdlWjFRTmp6V2IrN2R6c2J2?=
 =?utf-8?B?Y1FJK2pTNldxbUpYZnpTVG5VbDFsYnpFWG9iOUd6aVpCc3NmL3ByZTZ2dWFu?=
 =?utf-8?B?QmozeHlzdkh0cmZhOEdUVlJCWlFVbFU0ZUNuNGdWK2FXSjRHU2QxYVdLZkRm?=
 =?utf-8?B?d3NtRUt4VTNjSk8wUmorMnQ2R3NHM3FWNWkvMEkxMkdiRVZzMzdaaWxWOFp4?=
 =?utf-8?B?S0FJcWhFSTMrTWtFNkpUV2daQnFxLzRKQklzaDFJZUZEcS83M21aK3NXL0Na?=
 =?utf-8?Q?JTRFw3ZPwXHZD7Zg9wXFwcECq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10d5edf-66d2-4453-6f78-08dc859ea2fa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:32:36.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P68WWfWwrVfLGAbZpb8KxkrAFBbFAvS+WJk/1NY3CWjKk2r3PGbRlybvbB135lLM4QNXq81PqfUO3CrDpliY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

On 6/5/2024 04:33, Thomas Weißschuh wrote:
> On 2024-06-04 20:27:57+0000, Dustin Howett wrote:
>> On Mon, Jun 3, 2024 at 3:59 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
>>>
>>> Can you try disabling all of the Framework-specific charge control
>>> settings and test again?
>>> Probably the different, disparate logics in the Framework ECs are
>>> conflicting with each other.
>>
>> Fascinating! This board does indeed support charge limiting through
>> both interfaces. It looks like the most recently set one wins for a
>> time.
> 
> If it is the most recent one, shouldn't the driver have worked?
> What does "for a time" mean?
> I'm using only the upstream EC command and that seems to work fine.
> 
>> The UEFI setup utility only sets the framework-specific charge limit value.
>>
>> We should probably find some way to converge them, for all of the
>> supported Framework Laptop programs.
> 
> In the long term, Framework should align their implementation with
> upstream CrOS EC and either drop their custom command or make it a thin
> wrapper around the normal the upstream command.
> 
> (As you are familiar with EC programming maybe you want to tackle this?)
> 
> Until then I think we can detect at probe-time if the Framework APIs are
> available and use them to disable the Framework-specific mechanism.
> Then the CrOS EC commands should be usable.
> 
> The drawback is, that userspace using the Framework APIs will break
> the driver. That userspace would need to migrate to the standard UAPI.

How does userspace access the Framework APIs?  Surely it needs to go 
through the kernel?  Could you "filter" the userspace calls to block them?

For example this is something that currently happens in the dell-pc 
driver to block userspace from doing thermal calls and instead guide 
people to the proper API that the driver exports.

> 
> Also the settings set in the firmware would be ignored at that point.
> 
> I don't want to use the functionality of the Framework command because
> it's less featureful and I really hope it will go away at some point.


