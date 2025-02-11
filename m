Return-Path: <linux-pm+bounces-21832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7AFA30C99
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C044A161DA9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E5D21E08B;
	Tue, 11 Feb 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SJ/6f0oq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F2214811;
	Tue, 11 Feb 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279611; cv=fail; b=FatYgZOayGihQbkw9PH+uEx7FK08XXN4MUpaHUDjEWqLHjVyYwXsUhhdAgcIu1rQCknkYljzqNBntltOOVNuryp2XuIO4kaslFOghEpQwujlD8bXGYShhwdeTODjBjzTFjrmE+GVI6I4WXa7LlAyx6qlC6Z54irSjiNMvT9sPCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279611; c=relaxed/simple;
	bh=UQuH8xdJD+b2raxFxmdTfJUjVGkDZmz1xeS2XCtt1uY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SUWa9U9nnTjtg2g46g8HZgdXOZ7Ud0p1mjSGuc2GHKptWGnkPvA4Dr+AkFDuwjQvYVw+JNNXGViR3EH+N54fW71xKtgz5E4yaN0s1O268KbvmnpR/xWVCU7GZGjdgFJ3eBKimUyFFl8xBilt33RCTaMLUsxDEWMfg7xjANVepe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SJ/6f0oq; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9mvEPI+1MrAIfA8ec2D5AZ4Ap1UTqQ8J8iVq6Am7io1fsREQ8i1AMtnBNvHyaIs4b6bH3nqLCHjd8xgnye0+kId1m+u1idEbRp7Dx100TVh/P4Hw8J8JBZD6hE/KqtH2WWNFR1og15CCkEsMSGxlcGBc7mTbxnC7jRS3d1Jw4NZ0KTT3YgLZWjLSaoS6Iq5S7l50Fm/te2WdFpvEWAR0D1Wa4Q6hyqovYG2P6LSZImqDEOYqDb7DLGpzxcGwOGJKsmJvfJ61/j0jiG5r9f5Ta8Z+0FUMfgFUSq1uGZeDFFZlgbxo5FbfH8Z61D1ev/emPbD/yYlVAXmUgs40cMMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+27sEL7+2gAHFhrYJAOBgTD0uhiNbIg7pylIfCp85Gs=;
 b=wYKf1xFGtPzREV/WKI8sUFb7nqyJCpWaOBX3EOdQ9fi4B1BXPD0Sqp4uN9BDoxMhO1E7nOPn6M8lP+k2tkJft0H/NYMrLOw/DyOMbLR0gX7y3SITcmumFIuiJEwYV7wfquh0DkWgRClEY5sXIv9VDR0bIRfvRTFe+hQeheWJHN54Fs//xJVkcK/8W4EjAZPCfPoeQ8jg7U1x5GaDFJGYfxAEd7fntg3IjYUJPcIXBX/Om4boyf1UZiZOPad3Zx3Bnza7cBrkTKWSTWmT4OXs4DraC4lU1An+BQkBgt5+2gIo3rXy5D5OGJSS9yK8uQpclxWO2r4VERAqK9BV96MLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+27sEL7+2gAHFhrYJAOBgTD0uhiNbIg7pylIfCp85Gs=;
 b=SJ/6f0oq3mhLBA+l8zFlBt4494a8FrJZJUnG2wBGqeU5qoshkpnyh7zzIeRyQKkWTSWilqAL8nhM2jlO0c/eCImhj8NFp8TEsvu8M6/RifOJnxvYOLSdcNaA/GA3E9qwpj7FMhMzyZFQOqzqW/roFsSgCosi8Y1SKdr74OYSOqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 13:13:27 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 13:13:27 +0000
Message-ID: <a3d10f58-3d69-40e8-b0ea-53f4ed9ce31a@amd.com>
Date: Tue, 11 Feb 2025 18:43:21 +0530
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
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250206215659.3350066-13-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::25) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: c3394d15-fe76-4e48-46e8-08dd4a9ddf5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bC8rS1l0MjBGb0JLMGNueng0SDMzd1BiRngvQVFaUzlweWJubXFJQkxpaVhq?=
 =?utf-8?B?b00yZkJSK0czaElreXVlQTdwS3d0MTRzS0VxekM3RUVBaEwwR3pvYmUyM29L?=
 =?utf-8?B?cDNodUZXNHpxQ25nYkZlUVhWeGMxaG5CczBNU2JpNFo4RjNvVmwxM1pPd2Fo?=
 =?utf-8?B?djVDaUU3eWRCMG1GUGFYWTE0RHh5S2FoelcrbWpCTkFWMTd3RDhqSVRFaTU4?=
 =?utf-8?B?dkpYVW81ckJlWVFSU1VzbUVDWFM3b0EwSXlwRHIxbDlxUTJWSVhnTEpJcU9o?=
 =?utf-8?B?eGM1MXBjYytrOTR0TVV0R0xzSzRRK0dGMk5hSm1BOUlsTzVVMmx2TVBLbzlh?=
 =?utf-8?B?TXEwTUpVWVNrdWhEUXdDSGJOS3lEQVBWbGU1MEZUK1ppQTlPNG14Ty9OblVL?=
 =?utf-8?B?cGZuN0VENEtuVGFHWUVGU3pNUE4vWUo0MTNsSTFWaWlvcGN4Mk53dTIyTFdZ?=
 =?utf-8?B?ZkZkaTliN0U0UTdUL1pOenR2TjA5dDBKcHdKbUdpTU1OQVAvcnJJb3IyUk0x?=
 =?utf-8?B?SEE0bjl4YjdWWUVoYmJGSCt1N0ExdTRkMXBnelRya295ZjNvd1Rhb0FJQVFo?=
 =?utf-8?B?a0Vpak1BMVBzQWdwQlRrRTFhdUkzako1aE9TMWdnMGNOSU1lM3U3dzBNL2Qw?=
 =?utf-8?B?aFBtT0ltM3BUejVseEt1VlZYcW1DZXo0SGo2MkdYWVZLWDhpeGUwNnpYYWpx?=
 =?utf-8?B?UFhhT3ZGWVJoa0NNeENxZStzVFQwYVYyOGJodm1mOGh5Q2gzMUN1Q1o5blhM?=
 =?utf-8?B?R2hocnhiakZyaFBuTVdabWNVdXl5UHl4U3E0aGVRczZUOFlCeG5ibVlRUFhR?=
 =?utf-8?B?SiswVFpjS3UvdGdTdVlyT3JZK2djdHVwbG04NC9hQlBPQTcyTXdIZkhjbEVm?=
 =?utf-8?B?WE5XbnNBbDFSYXFGeWlRVzBTNncwc2R5c0ZTb0lndUpXVmRCK1EyTDI1T1lG?=
 =?utf-8?B?RlI0ajZyU3QrMDV2QzF2ZVB6WHNkbXR2QUJQbThzb0VLN0F4YUtEajJkeVRV?=
 =?utf-8?B?N24xL0syb0RFS1VyMEdka0Z2NXRtcllxYldxSXh3NGpjTmlLTUlUM1pVR2dL?=
 =?utf-8?B?bGloSUZsZm52VVM2b2pWTkUxdE1sNEtnUHd6azRZWmZNbExtUmkrd3EvckxK?=
 =?utf-8?B?cy91U25uV2VsakpYTmxidnllZ2xqV1ErdmNta1VpdndFV2phMjd2S1c3dW5E?=
 =?utf-8?B?TVJtZGxaaUZyMnd3SjZub09WQ1NhbHNORm5BZTRXcmRRUTlrZ2xweGtNYjQr?=
 =?utf-8?B?Q29vNE5kTFZEcWlZd2tyWmxheDRuRDV4QmZKc0NWakJXdFdFb1VvNGZYNHV0?=
 =?utf-8?B?djFHMkRSL2J2TVBhMkFFSmUyQ1lnZXkyWG5QanA4ZGZuUlJPVER4M3c3aG9r?=
 =?utf-8?B?ZVRBeXEwcFJ5ZHBVd1ZHMFBIcHBPRjRCN2VnS2VHMjhqK3pucitlNTgwaG9j?=
 =?utf-8?B?VmtKaU1XeUxLbXdYK0MzOWplMWhPbG1zckViM2VGZExUTDJGTjVBVDMrazFU?=
 =?utf-8?B?SWNWNlNyQkUwUVgzSGxLbW9aNW01dzd3TTVnZ2ljM3ZUTGx4WElENEU5Zy9i?=
 =?utf-8?B?eFhPSGNLZmM4NVpSL0JPRTFxYi9nbGtNRitsVGZpdUZGdjVIWXJhN2F0dXVn?=
 =?utf-8?B?QXVIdkNpdGF0THJXajhGVm45WVptS3UxNnpIUFFQRU9LYVgwNXo5bENiVEdy?=
 =?utf-8?B?QTUxVENMRDhpSm5PL1ZFNzZ4Q25iOVE0OU53Z3VIQ0ErSXVDOHIwS3NaR3Rn?=
 =?utf-8?B?R1NydVE0RE1HNEdCLzF0YWJGSGh2OWJUcW9BaGh3TEJoa2pmaDNhWGJDYXBN?=
 =?utf-8?B?MGEvbnRseG8vOTEzSTdreWFueUJhenI0elVTL2JwQzRHL0s3bWZQMjd2dE0z?=
 =?utf-8?Q?Q/O17JWlI0FHr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3gyMjY0a3VCRzhGOUw2WU0wS2E5TGZ1M2treE56dWdsQ3RtbGlmSTlnZ2FC?=
 =?utf-8?B?bm9wRzN3MTN1eXg0UzhIbkowd3JaclQzdHA5NG0rak0wOGVzY0ZnRzN5U1Jm?=
 =?utf-8?B?eU1tRzk3MUxVRWlnVFAzaGFFTFh5bnl4d2VMd3dMNC8yWk4yN0Z4MjJyM3RE?=
 =?utf-8?B?ajdnejZaR052MXl5YzFpa0JTNlJhc3U5RWNvZnJGVWtKRTExRm9Nb3FzYTVo?=
 =?utf-8?B?MmZqOEFYN1dFdVh3bkpTYVZGT1lOd25jeUlSQzdRQmFLOFBmNnZKandTUDgy?=
 =?utf-8?B?akxFTXg5MG5lcjdhSzlaakhIRXhDNHI1S0tyWC9kWXhWYjRrYlk4QXlIMmRI?=
 =?utf-8?B?VWMyRFZ2U1VqTnU2UXlWQmh6QUZpZlF2Y29WeFduR0I1R1JySnFtWGFRKzdX?=
 =?utf-8?B?aXNibGliNG9SRnBIQjd3VEUweXdDVTZOZ29qYXM1YTNGR2M2dkR5UG5UekE4?=
 =?utf-8?B?QlN6YUVLOUZ6L0xlT1l5WjBJdGtJenM5MVlHMmVrY2NLSFlOVm5MRFdHY2tv?=
 =?utf-8?B?MkpuNldONGZHUW9kbnU4eUduYmJJdytVV0IrMERQdENyU0QrQWc1Q3Y0YU11?=
 =?utf-8?B?dTU0R2V6c2VwbzAxL3RZNHJhMU5jZlA5OS9IaTVHb3A3OFBvNkxaZzZRaXRN?=
 =?utf-8?B?N05nUzliQmptMkpOY2YxTVpnRStXa0lEWitLaUkwWjhqRGtiUFBoazMyOFRl?=
 =?utf-8?B?SXpDdHVaNDRTbjJUcG82MDh2S0RTZU5qZDB6V1lxQmEzMnZxMTI5QTc4ZGNR?=
 =?utf-8?B?SmRKQ1lnK0hXZVFsSlFxZHUvc3VGWVQrODl1RXByREQ5b3BNMlJEeGZ2UXZ6?=
 =?utf-8?B?VmRmZU42RDdQaW1zM0NlQVp6amxWOU9tcjV3ZEpMWllxb2dnNG9kM0NYLzFj?=
 =?utf-8?B?UncvQStGamUzV3FQNEl4bXZPb0gxMVk3TlRzU1JpOVRSd1ZCaExrVVlmRktB?=
 =?utf-8?B?aFZSd2FaR0lDTWlSRzhBTzV5VG5jc0xVMEFqNWdCdjhIQnZYbWc0VVpvZFpN?=
 =?utf-8?B?MGNwSFNDbytYdkQ1eStoMEZEcVh2Z0FEYWJnT1RrMUllbXBGZ0Nqc29KdW5q?=
 =?utf-8?B?VmVLTC9RZ0dYd2IrS3JPRDg5VHhoYmt4N0czWDlpY2JqNVBBdm9vYzJMbWJ5?=
 =?utf-8?B?VWFmdXJUT2NpZVdEeVF2NFJJQXRuVUtFbjNlem01WTZ6YXE4MThqMi9PbUw5?=
 =?utf-8?B?UmQrU2RMdXVZTEllZ0hKY3Fxamc0WFlaY0ZQSjBWTUtkbWlZbTh5c1RlM1VK?=
 =?utf-8?B?V0Q0L3kzREp4T0tVWVIyVURoK0JHRTFRRVVZenNVK01BN2tNYzZyRDlqSUhp?=
 =?utf-8?B?cWhRMloxMGZjdHhCdXlEOHpjK1BsSCtYNnVuSzczVXRuZGpuSzBzSWloYi85?=
 =?utf-8?B?aDI1Rzdtb0luQ2ZMRWNoREdOVEIyRG9uOTlwc3doZlJpVnE5Vm81T3RSU1Ro?=
 =?utf-8?B?THFuNlhxdVJwZEhVamtDVmdTUW95dUpLa0FTR2twOUduY29LNDY1dS93U3U0?=
 =?utf-8?B?L0xJUVJXZW1JK3FZN2tWZUZiYjhPbFBGdXRGYTJnbFFSREZLMnp1QUdZVzN3?=
 =?utf-8?B?U0pMblM2L3dMakM3VnlUMEJ5dXhCTEw1VUl1eUtOMXg2aDN2SEg5UktPVjNO?=
 =?utf-8?B?WERaNmFIc1Y1RHNMSmVaNmJjTks0QVhUcS8vQVhhdDdVdnltYmtGbDVJRFZo?=
 =?utf-8?B?cGw3WGRPRWZsVzM5ckZYYnVWYVVSQ1VDZTU2QXBweDRmcjdNZE1xVWgwbmlE?=
 =?utf-8?B?ZWNaa1YxZDJtYTEzWlRKSVp4WjNjZFZSbmRrZE94UDdBVjdCTjNhZTVrNDdF?=
 =?utf-8?B?NmtxczR4NWt0Ulp5TDVKemh3OE92d3RtSzJTWXZUYVdvOXVnT0JWek9hUG5t?=
 =?utf-8?B?aWFrMHNERVdPL3Q1L2RZdklkZ2hDR1EzRTlCb0puYVozZ3laUUZlcnowTGU0?=
 =?utf-8?B?cDRhUlBqSUU1RkR2NDg5VFMyUzhZQ2VITERXQlRnajkyUXpya0RZSzhCOU93?=
 =?utf-8?B?dTViekVCb3pUSEd4NWcrcGtPNW5rc3BGNkt4c052N2NtdFZCdnplRjFBRGhN?=
 =?utf-8?B?YVNVTGVjSDJJVW16Y2lTMXNaSzJpZnNBUkdOWWRSWGxycW1wQU5VWEtkYjdj?=
 =?utf-8?Q?s1lTAUpNJyy6ZTZxVvSBc55Mq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3394d15-fe76-4e48-46e8-08dd4a9ddf5d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:13:27.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7PEEiJbLLeRp1H727AX6e5L8e2M2UEqMH0lHZ+bYgYmaNqggNsPkqyQadKmaBUqZ4cnaX1BUhSKA3AkjVloug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136

On 2/7/2025 3:26 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> In order to access the policy from a notification block it will
> need to be stored in cpudata.

This might break the cpufreq_policy ref counting right?, if we cache the pointer 
and use it independent of the ref counting framework.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 13 +++++++------
>  drivers/cpufreq/amd-pstate.h |  3 ++-
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 689de385d06da..5945b6c7f7e56 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -388,7 +388,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>  	else
>  		epp = epp_values[pref_index];
>  
> -	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
>  		pr_debug("EPP cannot be set under performance policy\n");
>  		return -EBUSY;
>  	}
> @@ -689,7 +689,7 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
>  	perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
>  
> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
>  
>  	WRITE_ONCE(cpudata->perf, perf);
> @@ -1042,6 +1042,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  		return -ENOMEM;
>  
>  	cpudata->cpu = policy->cpu;
> +	cpudata->policy = policy;
>  
>  	mutex_init(&cpudata->lock);
>  	guard(mutex)(&cpudata->lock);
> @@ -1224,9 +1225,8 @@ static ssize_t show_energy_performance_available_preferences(
>  {
>  	int i = 0;
>  	int offset = 0;
> -	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		return sysfs_emit_at(buf, offset, "%s\n",
>  				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
>  
> @@ -1543,6 +1543,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  		return -ENOMEM;
>  
>  	cpudata->cpu = policy->cpu;
> +	cpudata->policy = policy;
>  
>  	mutex_init(&cpudata->lock);
>  	guard(mutex)(&cpudata->lock);
> @@ -1632,7 +1633,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  
>  	amd_pstate_update_min_max_limit(policy);
>  
> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		epp = 0;
>  	else
>  		epp = READ_ONCE(cpudata->epp_cached);
> @@ -1651,7 +1652,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	if (!policy->cpuinfo.max_freq)
>  		return -ENODEV;
>  
> -	cpudata->policy = policy->policy;
> +	cpudata->policy = policy;
>  
>  	ret = amd_pstate_epp_update_limit(policy);
>  	if (ret)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 7501d30db9953..16ce631a6c3d5 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -97,9 +97,10 @@ struct amd_cpudata {
>  
>  	struct mutex	lock;
>  
> +	struct cpufreq_policy *policy;
> +
>  	/* EPP feature related attributes*/
>  	u8	epp_cached;
> -	u32	policy;
>  	bool	suspended;
>  	u8	epp_default;
>  };


