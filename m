Return-Path: <linux-pm+bounces-41150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E5D3C04D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 08:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DC9E5040B5
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21AA37BE86;
	Tue, 20 Jan 2026 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="juYRaAKB"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA632D0FD;
	Tue, 20 Jan 2026 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892731; cv=fail; b=kiBhX7kTye9h5Jqz7Cq9JT3Ghd17H/MRaA1Vdo7YiwKCJnb2SfmZKJwdpfzM9Nn7Bp4K5YW/nxmuOa7rAKnwrLNR7Duz+1RA9kVtitoiXQcf6jPX7ozX8aLFpmdCHprinTQaYnDk335IZygNDz/tGQinX4P7en4Y6L2Xv+BdWiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892731; c=relaxed/simple;
	bh=7v/5AqtAYANIPVE/w5hys0COL6FTBwi3yOOmfrKCFZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYVm0smBGengFxTXXfaGhLaXMahbllwX1hH1m/SAByFQPX3Xajo3kJHwfDpYunb5+tM8i5T3SxR/Ctc5v2M4qKBnckdPnZVXqoBfGsqPbtSyXrEFXjP9Iy+qUJiHwvDqel6Mg3VTTr/ZlWGZkcka3UY1ydI0BLtz4KOKOO0Qibs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=juYRaAKB; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji+JUc9MuUzKGrO78j11mb0S9fijbXI+BH0jJgzt9RZ4nrCL8shAist66u6jKnXI0dmdpUBA0VFMv+C9LnJpvPkDiYwaO+VZx9SkgzoAkZeF07Gtwt2X4etogqF+v9zJx6zBqHEpGTsuItDbp1ag0QrYRhb75MxIZxr3EtqZzMhvWm6nlbxHGtRjwtkhf5HcDLWljDMtNKgPMqLax88vZ9TILanJrPjqI13Xz4JZ9EGkNnIJrlJALXRRfAHE3N5zJgIT962pJPghmWISSnkVjp7mms6TkgGmqBO6YnQFwEd58b/XNcx62xSvb4hvwZvhBdGctFJYPdnz26kNXK0++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvtwzHjKtt0s5gg1llPGWdHbFCTPj71VQgzt/yx9ScI=;
 b=xSKUvMkFOQ4+nAlo8od9tM2AEX9k9RRg/5ClMjHihFJNmyaDdyV0D5qCF3lzvlWPUyuDA3oeFQt0xBFW84KZF+Y8f0qSb8iBPKB4WkcZSCfUUU6FsWEbfanBng8FGryuIgRxmbhOK9jFR/JWAP2HNbiZC6ionvUUbmvF99qYDybcscogwnhGnBHVjvKPCeui5ybrCQzwWpPg2/foRNv8qoyS06P1Q5Q85HSnegy8+3SofStTNb362ohwZ86xEbo9eFN4l+VoR0xYWc/YizqnVmACnMHYz+zMDepOftb+9zaeDo1nPc+H1wcDrYCtlde+oAIibC5ApOrsE6+j5BtRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvtwzHjKtt0s5gg1llPGWdHbFCTPj71VQgzt/yx9ScI=;
 b=juYRaAKBSArAsJWZpOcww14ZABi7urhp5sXWwK07C0ysj1gfxlnvk0dTK18KMdAOz1gf3WHJsJILpOa/zgfTcMtf1iU3woQ3ZJ7geQplhTPVLVrAFDRZWjbr5YBKPpg6cO0gZR5IWabcyW4nmrOdKM9nNBV5te/YGZhUARBNrHjhUPD7n/39MffUfox+jEmnHafOwuoblmRsSyI9ZwtGCPsm9saPQLdBDIGLytssGq1C0II6i7G0L35k/XPdOT1XiP5ChFrXza70YwVB+vSgTUhbBGn1LryQwly5NwtKe7PEYY116rUzvALJDPtx6eVFgJh88E863XhIQo+u/w5v8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:05:20 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9499.002; Tue, 20 Jan 2026
 07:05:20 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v4 08/12] soc: tegra: common: add Tegra114 support to
 devm_tegra_core_dev_init_opp_table
Date: Tue, 20 Jan 2026 16:05:16 +0900
Message-ID: <5263501.ejJDZkT8p0@senjougahara>
In-Reply-To: <20251125120559.158860-9-clamor95@gmail.com>
References:
 <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-9-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYWPR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9f7841-089d-41c8-eca6-08de57f245fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk5raGw4NFk4Mmc3ZDRQR0xwSVR2RjRrbTk2Qnd6dUcvbHVVRUhiUnc0eEdE?=
 =?utf-8?B?VzZzSG9vRks1UzdkWktMOFN3SlM5WG9wTm05Rms4clB6aVJ0VjFTMVRMUVdP?=
 =?utf-8?B?VExYd2QyUlMwakp6OUdrUmkrb2hYTkI1Q0kxNEMzeDhGeWo0Vm5EWU9tM0Vk?=
 =?utf-8?B?djV2VEs2aWRia3NLUDNiMys2UEtEZzd4bTYrOVowcmJTV0FUKzZiTm5jUXRw?=
 =?utf-8?B?UW1qTWNadU1xeVp0NHFJdmdoTEkyN2FibWQxd0phMk5oTTdOTTJHeW1jZ2hO?=
 =?utf-8?B?YS9ONHJHNWE4SElMdTZCN0h6YWlvM2VkUmJ1MXp6dnYwSGtGU3VNR2E3Z29w?=
 =?utf-8?B?ZWZEcnFuNTNrME05ejdBbWJpblRkZTU5TWljdHd2bGNQNmZWQk5sc2ROQ0Ni?=
 =?utf-8?B?WjdwVng3UXA4S1FhQ3NTaDJKWEtmcFRyeUVnajVOTGlWZ2d4N0VpQkZTclla?=
 =?utf-8?B?bGdZTzRMcDBPUDJZRDJHVmdrU21UaHdjSGl2QkQ2MHB4UWtaZU5HZGRzMDBY?=
 =?utf-8?B?QVJhcjJDN1B3KzRiZC9JU3BHazVPa3M1TmYwM0xjVUw3L21kQlZ2NGo2RDFN?=
 =?utf-8?B?alhxVElsWUp3UHhibFVEOTF1cnVJNkhIa1h1MVFBUE5CSnJHM2Ivc2tXSjRF?=
 =?utf-8?B?eXNhMGFLWHAvNWJGY2ErT0pLUU05bno1QStIZHYzNzRwRzVXNll2L3gvVzJz?=
 =?utf-8?B?RzNHYk85TDNQdm14ZlhIVWFiZ0RsVjg3cTRIWWtYWmJVRVpYYU1veUt6VE9Y?=
 =?utf-8?B?dS9vSVZQZkFxZjhSeUF6MzkyKzh3UGttcTIzL2g1UkJEQlhWMUducjdOZVhF?=
 =?utf-8?B?cWdESXhKS2pwb2ZGbFJrVXVkSDlQM2E2azZlQ01LdHBNM0FDQ2M2VG1GRXo3?=
 =?utf-8?B?ZjdJdDlwbjJHaVdvRTY0ZHIrMTZNVEFtOS92elE2L1QzZmUrSGV3a0V5VnhH?=
 =?utf-8?B?OHQ0V0pmNFVIUFRxVkNHSVowT3Mrdko5eml6TzFOT0ZsQld2WGlFRDFKQ1BF?=
 =?utf-8?B?aEw1TTZFaGQ0QmJwSXlGMXgyWnFWR3FpbFBuWGdHdlI1aTFWT2llY1hYOUtq?=
 =?utf-8?B?UldpTzkwK2Z1NVNUNlRkTTBxN3VUeVc4QUd5NUVSaHdvUlZEVHJma3BvQ1N2?=
 =?utf-8?B?Q0J4aVhaYnIwdjZ2YmZGaTcvdTlGajR4cGorbEwvT0VvSFFmZlNBZjgwVE45?=
 =?utf-8?B?OHZ2OHFxRFh5bjVuY1lKcmlNVzVUUjF5RkpQVUNrR01MTlFZRmN3Yzh1MFA5?=
 =?utf-8?B?RjVXNUxoOWFZYngzUEp3NDVlMDloYm9aYnN0aFRWV3dxOEdKMkNMd1RROEVL?=
 =?utf-8?B?cmlNK09JMDJGMmRxQi9wT1FScnpsQzFET3NQd1p3Mm9aT3U0ZW5ETHV0S1Av?=
 =?utf-8?B?VWg2TnpUSnI0bmdIVlZ0V3hEL1BPTnJKSkNaVUdOTm5QZ1lZUWNGK2RPNnd3?=
 =?utf-8?B?TFRRakhJelM3aGpYVzYwL1VqdThUMDJhOHZzWEdPWE1SU0tWN2pvNUhhdmpL?=
 =?utf-8?B?bkh0ZjN0N1ZQMEhnQkh0My9EdTVZa2E5eGpoU1JzSEZXNTdvSWF3ckEvVVVh?=
 =?utf-8?B?aFMyaHJ0SUtZL1M5UVN6RVYvN1Q4SjhvZDRjQ0t1cTJQdm9KcXE3c044aGtj?=
 =?utf-8?B?RmtHL3ViMUNRWVBtbUcvbGVFUVMwbXEwd2theWVDTFk1cUo1aWVwdE42eTJD?=
 =?utf-8?B?UGNFOFNPUzd0RjhzZUJUVzBWTWhQQ1krUjkxUnQxb1cyT3BrdS95djcrOFAw?=
 =?utf-8?B?Q2ptUHpEQmZ6eTNoVEdzOTU3Tzc0S1Z6U21jbUpnejk3TnhDTHFhZGJwOUx4?=
 =?utf-8?B?MldKSlp1Q0pVa2prNWxQODRNWVVabFZBL0dvd0Ficm9sSFJEd1FoWWl6UGV5?=
 =?utf-8?B?YW1WRVV6MExjVkIwUDdzN1p4cXZLc3padlpHZFVaaEo0amJxOFA1eTU5NHR6?=
 =?utf-8?B?dXhhaVc3c2ZsQ2V4VytZazY5bmlEVzJKTTJCZXp6LzJWa2tLYjRNRHhyR2tT?=
 =?utf-8?B?QUVUc3BkU293WFJhYU5ZVkFWTjJMNlRtcWRmb2Y2VWFQWldlSlRoOURlYWtL?=
 =?utf-8?B?U3k2TlFYTndLenY2bXRDQ0lhdVRsMGpPZTgxQXNlR2dNNVNaMkFIdTdjQy9w?=
 =?utf-8?B?c3NSS1FuckZnRFU1Wjc2OHdlNDk1UkNibERudWQ0ZXMvcW5OR1ZTL2hrOWta?=
 =?utf-8?B?V2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGxjd2MzblpUQUJWY1hna2c1MGh3UnlIZngwM3dlcG51VWdCTm14dFJnRTVM?=
 =?utf-8?B?d3QxcG10MUFhQ3djdUV4QjEyS0dlb2tNL1ZNTTNzRHpYbEJZb3NaQTR2d0ov?=
 =?utf-8?B?ZFprS2NDdEc5OHkwdW44b2NUcGxEeStnVFVtRlQrZzlDU2UyMXZ1dlh6R2Ir?=
 =?utf-8?B?ckFRNmI5QnV4WWJ5Z0U5VTNBazhmME9WaHpVSTl2MVBXOHBMamNzTmU2bXRz?=
 =?utf-8?B?K1RZbUtzZVRVY0o0NVI3SmV6b1BsV21sRkhXZTNScGxRVXU2ZHl6ZEtST3pk?=
 =?utf-8?B?Mko1dEdGZ1cxdk45ZHQwb1BzTDhyaUJjN2EzdHk2b25qQURQU1lSMnVsTXZq?=
 =?utf-8?B?ems0WGNhS3B5bXZDRllDRzZ0NUZWblVvQjRXaER3K0pPS25HRldmSGJ3NTlJ?=
 =?utf-8?B?cUM2RnMwTlBzYmNRSC9YbTkwNWxkSEwrQmxlSTEvUFBOWTJqMklKS2NsNmVv?=
 =?utf-8?B?UExubnkyUFdLeURXTVNIaGgyaEtuaEhhMkRjUnZRckk2ZjBYTEhxZEZmUVpN?=
 =?utf-8?B?QnQ1VnNZNWxpSWZvMDEzZHFqdlMvQ21HU3NTL0FNN3psbDc1MkIrRmMrTVpJ?=
 =?utf-8?B?UXlrbEt4eThNbFp3L1Y5bmJiMXpkSVg4Q3VzbjZXL3NJYnVZWFVINFZTd3BC?=
 =?utf-8?B?dUNSMllScTRBNzdwdjE4MXpGaFJqQ0xvU2JQUGV5VjJnaWlKMVI0ZEM4UHlN?=
 =?utf-8?B?Szh2cUUrdENiY1IvdkRKVEsyRGxQdE9WMURJM2JYTXRrSm5md2g5U3oycXNL?=
 =?utf-8?B?c1lzL3oyQXZhYzJVVHhOd2VSajBScjBKTkFLbFRNcTBvdStYUW1sTG9NY1Qy?=
 =?utf-8?B?YUQvRHYyQ3gvcjRNRkRvVzhZZlJPNTNvUXNhK0NSbmVLc3VtdEZ6V3dsV2N4?=
 =?utf-8?B?OWVCQnR4bVlEeE1rZitlbGpLSERVREJyQm9tcHFDUGwzOHJBN0dpNHhMak12?=
 =?utf-8?B?ejBiYnlCaVhwT1hId2ltS2pTNzBJQ3A4QVJGSmUyQjhiTVFTOFF4MGZBeEZT?=
 =?utf-8?B?cnNUVFBQN29MSmxVOENYTDg0TXBmdGx2bW40alFSV0hBaFdEMmdZdDZDZ0xy?=
 =?utf-8?B?NDg3SlJjT2J4RHNlV2ptcnhhUFRhaDJLYXFidDd6UENwUlVSUWR3REZXdkxT?=
 =?utf-8?B?VytpNStpcUNQTUNNSlhhYTFhUkdWRUNLcFQzOE1aUWpRWm10eElqa2ZnUzNx?=
 =?utf-8?B?cHVPOGFTWGtYT1V0WC9makNRck90SS9yMlhIVDJsbzR0bXlPUTlibFQzVXFB?=
 =?utf-8?B?NEs3YVFQRnlPSnBiaHRBT3VFVzVuK2llN3E0SHZLR0NFY2ZoUEJiZDh1VEhD?=
 =?utf-8?B?YzkzQ0NmSkJobEEvMitoOFhwbGV0RGFDTXhzL1llMWk4MGs3QTZNUWtJcFNp?=
 =?utf-8?B?R0hjSi9aV1lTV0RrR25VZ0VjekRTNjBPc1c4U3E4dzZnWWI5QmdIRi90c2Jj?=
 =?utf-8?B?L1VTZmhMQXR0VFY2aW9hNEdHVXBZelNBUTVEMG8wRjdNWEl0U2xUR0lYQlNj?=
 =?utf-8?B?bmk0bEJzelFsMXc0elJ0UWtyQUdhV3pOb2JPQUZxYWN2RXo0RmNjY0RKOEhq?=
 =?utf-8?B?VkE2dHg4aUt6MnJBZTZ2SVUvREhUNVNvZGxyNlZabGVxVXJFeHpKbW1RZngz?=
 =?utf-8?B?TzlPM1dZbXY5YlBLLzE2c3ZWNkFkS3daeXUvMUc5UVFkb2VJM0dDdUsvUWZ5?=
 =?utf-8?B?V0Myc0psSGM3VUErRC8yNGhmcGczelg0VHlCTytDNmVucTQyWWFlTEdYTmZE?=
 =?utf-8?B?UjFKaHE2azlXUy9WbU01UkI3ck1UZVRpMmp4ZWlvRDRDVHZ0S0I3MkNiVVF1?=
 =?utf-8?B?UFcraHFWZzNNSUtOWG9NRXlIS1hMem05QWs1cjNjUEtCV1plUE11azhYaFlN?=
 =?utf-8?B?b3lCQTRKNDVoWmNiOTlqZ1VCQ0UvQ0MzekVFWFdhU1hKSWZ0N3ZicDRXWHVG?=
 =?utf-8?B?U0hCVFF6UnFuZHpoeXovQTVaNVNsbzROSnVEV1pRQWU0OVdDQmNCRFlpM2hZ?=
 =?utf-8?B?VDM5bEZFU0ZOdXhBQ0hUSVMxeFIrYzdTK3I1T2hIMGE4cGg2MG1ZOVNzL1FN?=
 =?utf-8?B?Zy9hOVNYbWNCMzhnMXgxNlpDenZyc1NoTFE4TDVSRkJvZkVlSitEZSsxUEJo?=
 =?utf-8?B?UEhBc1dIcmw5bXdJL01hQlQzZVhiYWxMSWJJak44U3pvR1A3M3RmWmZMcEwz?=
 =?utf-8?B?WUhUVjgyUHRXNXcvN3JsTE01NCtsaUtDWkthQ2s4a09RMDlFRUgvdHJ1Y2FM?=
 =?utf-8?B?MjZHY1U1VXVDQ29qVVE1RUZYUWRGdGJMOHdrWU5SS1BVM250OHR6Y3NYbVMr?=
 =?utf-8?B?SEk5S3BkOXJCWnhya2ZDNVdKV0kzc1pOT0V6bHdFeGlzdmdrYzY4OUNzYkxB?=
 =?utf-8?Q?8bx3j52LD2yGwkJHfwC1lb3k9CRIZQxRQujKz2AoS4Yx1?=
X-MS-Exchange-AntiSpam-MessageData-1: 599FCkNbjKfGXQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9f7841-089d-41c8-eca6-08de57f245fa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:05:20.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91SwusCD/F8HFbaU8MwaFvvxFvzDrULMnbhQmWO9DHrgHW40ESMSYzyAR24kzpp8XB13MzgVjyyt1huc3m4Rtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> Determine the Tegra114 hardware version using the SoC Speedo ID bit macro=
,
> mirroring the approach already used for Tegra30 and Tegra124.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index 6292a1c72071..2264dd38893a 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -143,7 +143,8 @@ int devm_tegra_core_dev_init_opp_table(struct device =
*dev,
>  		hw_version =3D BIT(tegra_sku_info.soc_process_id);
>  		config.supported_hw =3D &hw_version;
>  		config.supported_hw_count =3D 1;
> -	} else if (of_machine_is_compatible("nvidia,tegra30")) {
> +	} else if (of_machine_is_compatible("nvidia,tegra30") ||
> +		   of_machine_is_compatible("nvidia,tegra114")) {
>  		hw_version =3D BIT(tegra_sku_info.soc_speedo_id);
>  		config.supported_hw =3D &hw_version;
>  		config.supported_hw_count =3D 1;
> @@ -156,7 +157,7 @@ int devm_tegra_core_dev_init_opp_table(struct device =
*dev,
>  	}
> =20
>  	/*
> -	 * Tegra114+ doesn't support OPP yet, return early for non tegra20/30
> +	 * Tegra124+ doesn't support OPP yet, return early for pre-Tegra124
>  	 * case.
>  	 */
>  	if (!config.supported_hw)
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



