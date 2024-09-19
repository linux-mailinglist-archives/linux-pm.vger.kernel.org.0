Return-Path: <linux-pm+bounces-14461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47997C8CA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 13:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DD71F23CC2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2179A19D8B8;
	Thu, 19 Sep 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pM9g5HgT"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0019D09D;
	Thu, 19 Sep 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747174; cv=fail; b=YATdJou7lke1/BP66rU9LNuNmN8BpzpvFZe5UvLzHdejwiMLFYjKRR0BmbdqFhpUjDfKkgHSBh3VENUt6oT5ryGWMwYxpXQz2ODMdVIHXOABZc24Vd7ZdUH4qoRlYKpIMamKSQgoxTbgHLZKj+ObOzQF47Nx3bi+Vb4NObHskfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747174; c=relaxed/simple;
	bh=3VRxKJ9AMVkG43bNRts67mg0uY8nlScY7CMHWgVbMXA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uBtIqlk5nmnarRZL+9xdkin677H1Z7zVz+MAtQurgnXCKErGNVDEY16VX7D/CKcvym1/MhhYTOowUPomuma6MEG67y5vD51nPfo3381w37n3To+i/A/ZvJM/F5kdLD/fF8pW1mVg43jIQwSMK5DG5dtu9YgWbgVnwWhTXh3tXqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pM9g5HgT; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yum9+6JNBxBb5Nq0f3ZLTuCrSkYyutVViRuyPDHOisoUlppF0TEdy6VqGZgBBnBCK5pfeyen1n8ZZwoKB0cH63RtqkU/VZqCjOLini1GK+iHUe4vdmMxnaU/aEHNmINdYYN19KmzNJImPtVA4ndDCDDZuf+Ha1tyVqJ908zt7oaqgB0HPKgF4IpxUBVtWb51V2sA6zOmupCTjakoJVM4SzdU2TetKCtI/nW8SAu+yx8zSgN3XyjqC9JtgznuC6SChFWm/Ru0DrblGpfnyiGMtgoDhx8awGVt1TKxV8SjK5ysaF0OjXsFNTbW8LnaHR6d4ot27H2JoPVERR2gsPSzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBG1dMtRDe83S2s/baUmpREnYT11PE2POSs8F04B+2A=;
 b=tvVqGeG0gCTHbNLNH1gA4oVLMxqM/Fm7xjnWIumkbo2mWwJVWzIZhIGT1wz/9euMFVN6cc/R10KcwhZyDfqLhJH3ZA90h7YBv4lmfZn7u20MTHcxp3F6T9DxfSeXbOGD7VSPZfVF5AVqB3MlSV8rP1oKzOO4ONF2r8vPaQRUTX6UOFpKxpO5WGY+9H+wcpcIOj2hiZpem45tlGoIPFji0E5k31fq72hWx8TEWFdXQG2QQnFmbNBnUY2johj8LqVqM5gP9tJm5opcpw0HJ6uZJ8DoXAbDO/uFOG+/PMxgSMY4pxR2c85PKCUInR2TbrRhEH1FCfPX1ziNYWLx33VHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBG1dMtRDe83S2s/baUmpREnYT11PE2POSs8F04B+2A=;
 b=pM9g5HgTk1JN2cU9VidK0uCmuffUbm9O6OsWv+laQcozM4Np6lkScH0Pf7qCQJ9Ww8S8XxjdNJFlkMKwJR9AAlGyehp4cEmZOFhNEYf9GU8trtJknZ8/6VYC9F1uAjV1l6c8/HqDZN1985DNfkJY6tzS4/OBpLBpCUWgsqFyEimGhurh4ZE/qtVUiXsnYSglWdEbOKDWi5UGV0xQiYIKKegz5a87/ThJnMkUA4oD9ZThPiB/h3JGC8UMgjNuNnOvMjqxjKMLzM492uuxYXj9m468eNtvenqM/vj6vmsfJ2k+GaKORpLaD4NNtgO8B384OaQNzLC6KfRV7OVMoFAkHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB8041.eurprd04.prod.outlook.com (2603:10a6:10:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 11:59:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 11:59:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 20:08:11 +0800
Subject: [PATCH v2 1/2] pm: cpupower: bench: print config file path when
 open cpufreq-bench.conf fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pm-v2-1-0f25686556b5@nxp.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
In-Reply-To: <20240919-pm-v2-0-0f25686556b5@nxp.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726747701; l=1089;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=2pxOMW3LybW9Th81wVWF0biaYjFBiO8zFnKPhpofG5A=;
 b=PIgXQ4U9bYymafhhVsi5sj9lSnPebIElhegRrkKDh79RrUg8YrY9jfCzgFqEOauX4IroZPrnE
 TUQWr7Pv6J6Aes823l/CIBUWxWoHIab9AvnO7iWjHLO4Wco8mRvvzVi
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edb2788-5a48-426a-4c08-08dcd8a28433
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDhXWjBTa0VtNWdQdk5SeXpFM3U3LzFKcXBtNVlnOWMwa2YrblVKQ2JMa09a?=
 =?utf-8?B?STQ4c3pqdjNLdTB0MlJCSXVHQ0pCSFpkS2N0OFBsQXVRcE9UVUlsWUluUlpi?=
 =?utf-8?B?TnRlWFRzTGtVNVAveVdXMFVjbnR2NEFGTE5MV2pMSXZSRjJQNGE5YW1aY09M?=
 =?utf-8?B?UitMMW5jL2J5RUpDczJGSWhIY1JaaUNWem51OG5FRkI2bHA4NjNPV2pHY2Nt?=
 =?utf-8?B?eWg2UUgvbDdZRnltc2g2MTBBemt6N1QwZkl4U1JIaDJRaElZaWI3NU5wR0hq?=
 =?utf-8?B?NHU0MTBKMkwybjZNYTRuVGN6eUdIZnVQb0pRT2dMaTI1UFliZDRqOE9aSUVh?=
 =?utf-8?B?OWFKdTJ1SGdFaTFEMDA5ZWRoWkRSY2drV24xK0FOUUVnTkZYZ2NvS2krTFhZ?=
 =?utf-8?B?TW9mQUhsbEc4K0J0cklPY2F6U3lqRTU5K1VRbVdMWkxUcmJLR29UUTVjc1My?=
 =?utf-8?B?cDNsWGtIMmVvQVlHMFNZWDlpMVkzU3ZqK1cwWlgwNUZhSTBHYmdzQUhwTkNS?=
 =?utf-8?B?RlAvdXU5R3pSWEQ5TWVaREhGcno0TjIxZVN5RUwxdUR6VWtFM1MzcFlkSHNm?=
 =?utf-8?B?ZVZWQWFyQzRKU1ZkenJ2QjRKRkt0WHJTQ1FOUUZvczN5VHZmYys3SmFYTGlo?=
 =?utf-8?B?QXB1QWIvb0V3emV6R1h1aEhMMnZJUFNhcStRNFJpSWQxbFcvbUlDQ2p3M240?=
 =?utf-8?B?cnUvQko0QXg5a0MyN0xxNzRNZ1psRjZldUZWZHREeTZadHJmU3pXMFhhcFVh?=
 =?utf-8?B?eG9vbEE0blpsTUZyZHVMditRcDJ4MFBRZko4RXNBTkhpbHBNN3R2L0plc1hv?=
 =?utf-8?B?VlZxU2dQL2duUE1rWEpZb3hyNncyVlZQZy8xMVROckZDNGZnSnhxQzM1VmZY?=
 =?utf-8?B?anlDQmdQVjM1Z3U2aU1ZbFJUWDNOTVhlZ2FHdm11Mjg1MjJWY09haUVORUdL?=
 =?utf-8?B?RVFNeVpNby9pZ3hUSW5USVBmbmhmMVdZNCtPK2FBcFZtdXF0N2tLam0rbUcy?=
 =?utf-8?B?M3FCdEY3RWp5R3ZJV3VyaExFcTZuV2hhd0dNVGEyUHBmM29WRmxWTE1QYndE?=
 =?utf-8?B?RkdMTTNaU0dRTjVpVG1WMW5SeVRwczJiQnd5aEUyYUJ6aGRMdUlvZEhnVlNJ?=
 =?utf-8?B?UkFVZHU4amNkdnJaVkVCa0VqTE14U1F0UFQ5bUk1aExuY2hpZ1kyZ3krNkIv?=
 =?utf-8?B?THJpU0hQTmg2UDNHV3p3V0lZeGtLbHowUGc2VUFhOG14Y1VxYnZGT1NCTlhT?=
 =?utf-8?B?WDFsY3EyRjJBRGJNUGllOHdoVGNhQUFTUHVnblJ0Q1hxK2R3WlV0Rk1WMWNV?=
 =?utf-8?B?aUxMWncwSUlyMUZmVktlOWRQRnFuMzU0SGNOSkFFakZPcm9tTWF4UktTY1VX?=
 =?utf-8?B?VHhENXFPVUxDQUVmMVhaWnhiSWJGSWJoeDh0dEh4T045NkNGUDFXUkYwTzdH?=
 =?utf-8?B?c2lERXp4di9oblV3K0xKNkhZUHNDUVludDlnWXJNaTIvR2JlYVozZVN0SDJN?=
 =?utf-8?B?M2c3ZGNHclBUN3ZUM0RKWDBVQzdVUkRrVWEvL0xseTZNb3E5Zkk1T3Rid2Z4?=
 =?utf-8?B?ckwxb3ZiOFd1MDBESjgyMU9xWDZ6dWlqTFFwa0ZVeGc1ZCtjQ0NMME1ackpT?=
 =?utf-8?B?Nk9NRGRmZVh1Y29qaGRPT0RkM3Y2eWU5ZE9oU1h6elY1K290TjNaOFVyUXdC?=
 =?utf-8?B?Mk1ZcU5iL3lmN1NyTmNUdTFjTlFvYm1XT1RZemIwR2p4SytiQ2s0cEpNK21p?=
 =?utf-8?B?Z0NXQ1p0cTZ2amVJS08zSE9qSzZvdU1oL0xhSVpyMlZhcmFudjJjODNmNmlu?=
 =?utf-8?B?OHJJRklPVFNrUUpQbnNRMkNNd1ZtVHRQbElLQy9YYURSSFZQVGk1emdNNnFS?=
 =?utf-8?B?K2xLRVZCZDQ2WFZTdTQ2VVg4MFZlU3FZcVgwcTdpUFRTNkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXRZOS9UTlhJNEh5eHl1OW9VUExWTE5OQnpZM012ck5Ga1MzNkNrR29ySWNv?=
 =?utf-8?B?YVZObTNGMzBHaDhhRVdqYjN2L2l1MmdmZWZjeUtpaXlITXlEcWhVdkhEK0FF?=
 =?utf-8?B?ZE9zVjFHWHhPWnYzVDk1MmwrMENnbHhuS3V5N2k5ajREWUJKd09xcWxlN25E?=
 =?utf-8?B?bGJFMW9wVk9xcnFKN3ZkU1NsZmI5c1VuaEVTTU1tSkpJRS82ZnZNVzMrTytp?=
 =?utf-8?B?WmVkSVd4V2laaTNhaWJMZ1prWmVHZ0hXbytvUFZTbTE4bEpobldveXVJWC9I?=
 =?utf-8?B?NktBNTBiNHUrY0pna0VRcm01bFVnMU5LMG1wNDYrbkFsS3dkME1OTUVLNDRp?=
 =?utf-8?B?aHdCMEhoZjVFSmJsZ3BLcmlOQlAwRGtvVm5XdG5uY1crQi94dzhORGNkbXlh?=
 =?utf-8?B?Y3JsTVF2L2Fpai9INXl4QTFvTVRxeFpSUGlhaWhqaEhuN0NRMnhyQ05WcEkr?=
 =?utf-8?B?cU5tdlhNblJnUE5rdGM5UElQQUJFaUlveFY1aUdRSlZyQldKVlZIZkZzWkRu?=
 =?utf-8?B?SHJMZ3cwMmdzWDFKMmFzYThaVURldUlyM242RG5CdUVmMWxyMWZmY2xUa3N5?=
 =?utf-8?B?RkdGQ0djaEZ3clNtSTdTK1YvQ00vNGtxVDJsMkVnRGdUd1UrcGxrZ29MMEo0?=
 =?utf-8?B?b29iN3I2NDl6V241OVdqdTNxUEVYbC9iVkNlS29zL2wwRHB0RHA1MGp2TGhw?=
 =?utf-8?B?UmF2YXZSbndRdEhSK3Z0bGdsbVFqN041Y0s2RHZuaU1pajZMemRva1F2VXRh?=
 =?utf-8?B?NjRVaUdVSzB6WHVYV2ZFdFEzeWhiUmlNZzBPK0pDUG95ektYcGcxV0JxSTJJ?=
 =?utf-8?B?dGUyNUtBOHQ0QVphaXZvM25SWHVmalJXTTdxZ2lyOC9LUlpkVFg4b2tENW5D?=
 =?utf-8?B?Q0ZIRGcwb09GYnEyTjByaXhZNmRibnRwdXFGZ3JZcVpPWkdCbVhyYlcySDJG?=
 =?utf-8?B?b29kbURPSGUrcE8rNEluMlZxUHhTVTRJK2ZFamRzbmZndUZnMjB4UkU4OGpO?=
 =?utf-8?B?VElGMFZjYUJ5L3lWVlFTcDJXN3I1aS9ZcFBJVWFZOHVQeXBBSk0vVHczelpy?=
 =?utf-8?B?K0l3eCt2K29mMjhZaVptaGFTdU9tMEZMdVFnQUlhU0drTWdEdDJLUGE4SEk1?=
 =?utf-8?B?bmVwTkVRWkJ6TXhxdmthWE9FbllZT1R0NGVGbzYrOWRlWFFWRW1jT1RTVGhO?=
 =?utf-8?B?VlRIRmRac3ZSTUVTWi9qSDgxVlhBOG4wR0RmN2R2blFqK3RZUG1iTGRGajQ4?=
 =?utf-8?B?dzZsdkZoSVNGRGJpOGM5YlRzWVN2MUJjeDFvMHBlZ2lMYW9IdjMrZG5KWWpz?=
 =?utf-8?B?S2xoWlFhckdHSTY5ZC9CUU5RQ2tSNldYamw3QnpRaFZDankvS2hZWXZsYUZq?=
 =?utf-8?B?emhmRjJUd1ZWRXREU2tIRkVMS1Nndkd0N2xtODBHWGtKaFB1RmJUd3Bod2h6?=
 =?utf-8?B?bzY3bTNhWE9oTVk2aDBFZG5sb0pWL1RzS0IrdGtsRG5idWhFNDRIbG14d29K?=
 =?utf-8?B?R09USytqRS9rd1ltOXc3TjhtSVU1QnF4NzFkNFlzN2xMZHQzUWVNRWVZb2kz?=
 =?utf-8?B?bGJiei9Dc1NIanhJeGkxWng4RE51c2EyRk5iWUUvOEZtUEhvSXA5NTFrYXNG?=
 =?utf-8?B?ekh2TEFoMGFpbk92cElxL3ZLSkJkbElVd0s0NVJua3A4S0g5OXUydmN3c1lP?=
 =?utf-8?B?UkVnZDRxSXhJRzExTEVUbDVCU01VdkJFdm1kY3VOWG5YWi9ibWxxRVBXRDdW?=
 =?utf-8?B?eFRrMjBYSTlEUWx3OFNmbUU2U1lsUjVSY3BKTVVrWGtaUGNybDdHamVCT3Zw?=
 =?utf-8?B?N2VSSmV3WUNYL0Y4bnVESmtsVGVzUHpEZ0tvN3EwMVlpLzZSVFZNMGtKT3BC?=
 =?utf-8?B?Y0FnMklZdVUzRXh3RXdhcGRKM3lzelFuSUpDUzhrZzFmZnFTZXY3NDFUbjRa?=
 =?utf-8?B?QWRSUzdZSi9tdHJHTzVRdlcybzl4NkgxQlZ6RXg0dThtTHpvNlNyNm1FemQ1?=
 =?utf-8?B?RzJBOTRvWXVWdFBYbmxkTHFDMEtIT0YwNlYxOGszUGEzdTFtSTNQeURIMm85?=
 =?utf-8?B?VG5qZkIxSllRY1hIdXVOSzd1U0J4SEk1KzY0QS9qd1g4dlovZWtEa3hISkx5?=
 =?utf-8?Q?W4DEqWy6YO1tK+V9F5UI4t1Xx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edb2788-5a48-426a-4c08-08dcd8a28433
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 11:59:29.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvVd+1P0g2d60TgweuP24oUvSqrg+0MH/cUC4soymrWujwwzLdENe0SDiVnWFAuw4vzhgeSDxq4HdYILG3zF/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8041

From: Peng Fan <peng.fan@nxp.com>

Print out the config file path when fopen failed. It will be easy
for users to know where to create the file.

Since we are here, use strerror to drop the usage of perror.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/power/cpupower/bench/parse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index e63dc11fa3a5..080678d9d74e 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 2008 Christian Kornacker <ckornacker@suse.de>
  */
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -165,8 +166,8 @@ int prepare_config(const char *path, struct config *config)
 
 	configfile = fopen(path, "r");
 	if (configfile == NULL) {
-		perror("fopen");
-		fprintf(stderr, "error: unable to read configfile\n");
+		fprintf(stderr, "error: unable to read configfile: %s, %s\n",
+			path, strerror(errno));
 		free(config);
 		return 1;
 	}

-- 
2.37.1


