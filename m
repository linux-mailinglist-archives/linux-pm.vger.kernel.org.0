Return-Path: <linux-pm+bounces-11553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7A93FA30
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5851A1F23290
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D0F548F7;
	Mon, 29 Jul 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vsosqfuw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vsosqfuw"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B83D64;
	Mon, 29 Jul 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268930; cv=fail; b=HCuiWmSLaylb1dKWOpVRfABgGrTEgECZGwJ/CbJeQL0/tRlOdf1Olb+fhnzIrotr7VOv3VcVQjqSKgnzBeCGSqrCFXnUB1rb4kX9TBGwgcM5HhX6pg+8+e8a6TIydzMhVKyRzTv5++IPqETiCV/qckvRsmz9Ek6WUYaXr2ZztOU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268930; c=relaxed/simple;
	bh=QSG+XlzpY6JShVdr7X/HWJjd/lM27PAPyElvkcJG9zA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCnVbTAbGottIePWWgnVyXsGwB8Jj2IfcJ5WgGywMa8OzHIaTpNIK9yCKMDh95lOKvZm5buo31uiepJEyVYuKa+331N3k9dSnDNF3MAQy1u5Ju6q8dRaGWjBwAJaj7NUyicKLzKkI24TVNjuOjyrY6vS3H3a0ppdKigOLLBDxa4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vsosqfuw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vsosqfuw; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cTMN9lR+uI2VwzSYejRTnd0IJ9rI3sTL5Ho1as2UICktU8bulr2MVTB8Iknc5cF9QW/E0/xEWCnkUmVvAnv1+y4AJGxzoxqXjyub4jqFC5KuIQ9eCdktWMipfly/wM8Fe1tVzecB8QGGL7txdS3H8pw62idKM0nYL4ej2P8MN1J7TJAhq76SVg/wDBitmA0NX9bgvRoWUf84zQyDdcQ2qjD/bHEe0xWAcFsFeFrKLw+LGCUOnxFJ0cPMP/5pu5XSxMnR1TD3CjU2wxe4sERNfw1I5U1u+2aTBFLIemWr6zFJ0AhMaYnc9eY70glhHgdcOUYt8mz+splvRt2VKiktwg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGRORhIhaVCb27aLMEUN0K2nA9BgxjI/GuE60OepIJc=;
 b=vzgkEqmdQ3rDQsxFZpOPANG6J6nYlfZI7/8HNfqci3oKAIUYlsSeTV9c8trpx40McwN+VGuFTylD8zFzXv56498Gh4EX8JW03EiPc4CPaFqUNkPNhNO1KQaZzZzDOg43NyIPqxkDWOH913fKG+WNJM7xLIEswqupq9sJPR8mdwCFhZj6m+9/mYacU7dwK0AE5WeClUBph7Qtljpt1K8AeERGJ6hQ9yI0p6F9y+QdNYM4rcs8hUZyrd7M8tFgHRoFMnwLHxmkU/yy8VrSRHDdVmr/ku+5MSOa3x3ugGb64MuGsCboTtPnF84Df1b2hD+a6vq4sdjtIxeBQhu4FX73KA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGRORhIhaVCb27aLMEUN0K2nA9BgxjI/GuE60OepIJc=;
 b=VsosqfuwKg4n2NnvDIzdOWQEq93axo93/lA28s+y+d66StVTRVskqqCvDMLoeV4bGn55/jX7ZI/GfZYRUqsxdMxtOWpZh7WfMBKHI/3nTIi3okzofXLgwo6J9I5CNZbIGGXtxtmisgUlsXsKHncssuWc57FbwWx9LLRPSxPHZ+M=
Received: from DUZPR01CA0218.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::21) by DB9PR08MB6681.eurprd08.prod.outlook.com
 (2603:10a6:10:2a4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 16:02:03 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::5e) by DUZPR01CA0218.outlook.office365.com
 (2603:10a6:10:4b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 16:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7784.11
 via Frontend Transport; Mon, 29 Jul 2024 16:02:03 +0000
Received: ("Tessian outbound 93748f77c01b:v365"); Mon, 29 Jul 2024 16:02:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d2227a109441fb6e
X-CR-MTA-TID: 64aa7808
Received: from Laef800603df4.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id B3973767-E4F6-4C44-8C2D-A9B7BE7184FC.1;
	Mon, 29 Jul 2024 16:01:57 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Laef800603df4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 29 Jul 2024 16:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrdW5Ejj6SUse/9T8SeYJU/4nJfIxYeazpBI6aPqpxEnvIpA1JBNbUd8AyXsi+CR4sFxBxfyZz/ciqQt4pcPcSOT5/BOqYcguinJGsAh2u1uPVAKhruu8zFXomo6T/btjLWC84er9DVGfS12vqh1Rxw6FH1MgAZcrhEEHC4raiaz1BfmCjeAhJ/ozpT5a/zb0A41VxNXJLsOz+PCPZbdAyXy7bA9KJYNEVUZlZimSulbG/MkjrM961z7noCACXIVylgZiKDiUC5RvZQM1L3VAIletCoMKU+8QmYp3WkDsIjW7IzJVbMd6WDgRiZ0kdfJx6meaoAZlUbnduP/45O0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGRORhIhaVCb27aLMEUN0K2nA9BgxjI/GuE60OepIJc=;
 b=mVXUtMVY4RS4FblKUEv7yIj+66QYWzN/hF3Eor/JJyCJtsj7qnGS7Zhn2JW+sbxi6GCuYGfwFCK/8+YMxhQ4oaHt0/duGSWtGKzfzAv6iTvYxMGBJpekJVFpsO+oJeX6hN4KVcNRAU/mrQxKkEqS/oaoehaa3zWz9c73udN51jOBnpjgrYo/7ATHZ4p5mkYBlO6nJTCgMQjQCIm2i2rsWq/pVhP6QLCro3jq3z5jl8vFIFvlMIzeNYqTC6ZHoBrU4e2w0sf7KwfKJf84wXZxY+uqxdxy6TJq39G/z9jwyGDrSo7SEutQbJQXOYMPQFU3JbX+c9HZ93eIvVTwqIR3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGRORhIhaVCb27aLMEUN0K2nA9BgxjI/GuE60OepIJc=;
 b=VsosqfuwKg4n2NnvDIzdOWQEq93axo93/lA28s+y+d66StVTRVskqqCvDMLoeV4bGn55/jX7ZI/GfZYRUqsxdMxtOWpZh7WfMBKHI/3nTIi3okzofXLgwo6J9I5CNZbIGGXtxtmisgUlsXsKHncssuWc57FbwWx9LLRPSxPHZ+M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com (2603:10a6:20b:557::8)
 by DU0PR08MB8302.eurprd08.prod.outlook.com (2603:10a6:10:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 16:01:55 +0000
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a]) by AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 16:01:55 +0000
Message-ID: <315f8c55-9368-4f2a-81ee-2d7dcb05bc14@arm.com>
Date: Mon, 29 Jul 2024 17:01:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
Content-Language: en-US
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240728184551.42133-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::25) To AS2PR08MB8288.eurprd08.prod.outlook.com
 (2603:10a6:20b:557::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS2PR08MB8288:EE_|DU0PR08MB8302:EE_|DB1PEPF000509FD:EE_|DB9PR08MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: c4433bf9-119c-47fa-5cd1-08dcafe7c9bb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VlNJYWdnT25FOVRzYTNtSFU4eGtLY3hGQUhrckFWTGh2ZGV4WXE1MTkySXNH?=
 =?utf-8?B?SjluVEREei9zd2VRQmNBRlA2a2dHdllrcmRXOFVRSVU3Smh4ak5Td05FVzJ0?=
 =?utf-8?B?N0xsRVlja2NUcmdvT2wyKzNJMkp5dUFWdm5TRnljWlVOdW9HbU1OaEFFTDNF?=
 =?utf-8?B?aWVHLytkbndNQlUwcnJxVEs1bkgrUVRmWmI5YnZOZVEzNDlLNHh2OEd3emdp?=
 =?utf-8?B?c2RTcXp5Qm1aVEZzTWFzMU5vKzZIcGNZVktVSDUxTlRaNWUrVGk4YnRHSzZF?=
 =?utf-8?B?RzJMQlp5VFRPcnk3endNYkVtb2J3Q3FLeUVvTEZvcmxrWHFndXlqUjl2MW1s?=
 =?utf-8?B?QWpBOFljbnZoN1JGMmJDMWo3UHdBMWlVd1l1WXZ3dTU3TDFBTkd2ajhPKy9r?=
 =?utf-8?B?UllWd0w2UWFlMElsdU1ZWDgyc0pFNWsvZEhGYlhrdDZ2cmcvT3UyYkczd05r?=
 =?utf-8?B?Q25kOHdGUmx4NFJsNS9LWG02Q1BvZXJFc1BaN2ZTdXphVzIzVk03SUhhczBQ?=
 =?utf-8?B?UmRGSGwvRHgydmkydTZ6NGo1MTc0MzZsQnZ1azQxazZCNzRDWmlJSFN6aGZ3?=
 =?utf-8?B?WW9qK2prbkM1QVVYdDU1WmJMNzZOMnBmM1NxMEdaZVJMMWFWRWNKVmxCdE14?=
 =?utf-8?B?cVh2RDh6K3hqR2YvM1RhZ05uV0NlVUhJSE1BQzNDR1U1ejJhNExNL0p1WVJE?=
 =?utf-8?B?eXpPN1dwcTYycStxeklSRk82SzJ2OUYwVlpkbHZnMDJRWTJYSmV0RGVqY1pQ?=
 =?utf-8?B?VXM2aE5EZTc3bEJQTHRzSGZsbEl1RXQ0UTVXRFNkNmJIczhMai9wVm5BdEs2?=
 =?utf-8?B?bWhNZE5mS28zanpnVnRUSGw2cTNhWDR6NndFT1ZuZUdMWS8vem1HVUhRWG81?=
 =?utf-8?B?THJBYUs1RCsyS1M2VXhQcVRabVdET1pjbkhMclF1VnVMM0dmbVBqY0syZEd0?=
 =?utf-8?B?bUNWWG9kOXIvNi84S1hxd0hmNDR0aDMrSFBOdGVWWE5iM215dnFZV0dIYzlJ?=
 =?utf-8?B?TzFLdzdXUnBpYmt4cmkwQjAzK3JSRUF3MmFvSysvZlpTOEtWWVN4bjl1ZklJ?=
 =?utf-8?B?WUNyMWFMLzNiaHhHVWd5d2h2NDNObWJkcU1FRzRmREtpUlpIQmRyRFhrdW5U?=
 =?utf-8?B?b00wVkRsNzlmdDl4M2JJYXdWOFhEcjY4bVhBUEdwVklCU01ZZHBKNkluMFFM?=
 =?utf-8?B?UDRTcUZpUHZkN1N6dmVjMEV3VTFDdUlnTzZrOFFxT1RBbVF5cUQ2WkNPcHZ5?=
 =?utf-8?B?ODNUNThJUWk0MnA0NlN2eVpOWittWWtqclBrMXFJQ0hSQW8wM1h5aHROOGJK?=
 =?utf-8?B?bUJXQzRqSkovYk4rVXFmSWxhWi9YV1VTRTZSZWwwZ1JlVnlzMVlGdUU5Mzk3?=
 =?utf-8?B?OGRrY2RMdGZDb08weDduaE1tbHlnUU1sbGV4cFVBRGo2TjB6T0l3ZUNKem44?=
 =?utf-8?B?SG5yVGtkQkFQckoraEorODlvcC9mcml5VHp0elFNblVoeWVBd0dpdkVlclJW?=
 =?utf-8?B?ZFl5QXoyR0YxZlVEdVlhbTJra25tTGVYZW5yakw2ZW5wLzBuT2daeE8wWHZv?=
 =?utf-8?B?cU5tbXVDaitJV3pkZ0krU2FpZHRRajZlTDJxbUJEWmF2Z3BkMVZ2eVpiWmJh?=
 =?utf-8?B?b3FGcUJhYXZGYUhMNElOU1NqbVp6YTQxcmlkZGtrZGhoalVRaHJleHFaR0Jj?=
 =?utf-8?B?NUp1aVA1Ri9reTdtWUc5T3hQWXdpKzZwRHZzT0FuRC9UaHVOU3krWVFZLzFQ?=
 =?utf-8?B?cEJYTHBvSVdzU09FMTQxQ0xKUUx1Yzc5T3FWOGtuN3VJbm1JWGRoN3lzbFZM?=
 =?utf-8?B?WVhhbnh3QjI2bUFrZ0tIUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8288.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8302
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:557::8];domain=AS2PR08MB8288.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dd060b6f-449a-4813-e4cd-08dcafe7c49a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUNWWmZDSWRGWStxdUVJdFk1NkZ0eHNUQnZiRzVWaXQxcnh0ZklCKzBqZVZt?=
 =?utf-8?B?M1V2R2czWStIU2xNRXhaK2VxQVdZamlHOHdVSWpybkxqUzJxcHo5QjRLaGRj?=
 =?utf-8?B?ak1CN0hpZitOK2J3a0VoVE43UXBhNUhuZDZpU21TS1owVHJhcmdleW9GaGtt?=
 =?utf-8?B?VTlmNUdmenMydWFFUzcrN2FmNmJ3OHVCanlHYnNHY3lsUWJDVFNOME5yQkRC?=
 =?utf-8?B?MHhobDNhRGdmbkFYdmhaRjJkL29tWmNla05MZmlDN011YWVKUWNWb2Y4OHdB?=
 =?utf-8?B?T2JMd1pXanhVZit5cFVrUjNPWVB2WnNIT1JxWjcrbFVLT1d3WTF4Z09RR1lz?=
 =?utf-8?B?cFh4cXRQaDY3VmI5eE42NEpRS0VlQTlyWEVuTHYxejgya0syNWFYRG1DcTRR?=
 =?utf-8?B?aG9zUEtGTGlhZTZ5SmtpZm1yR3p3VU42ellTbXhSWlBPc3dPZ1g3VFJnSllL?=
 =?utf-8?B?VjZPb2MwV1RLR2hFNUcrcStUMWd4OUhDa3NHb2ZvOGkyKy9EdjRoNURBNEwv?=
 =?utf-8?B?dmFNNEF3VU9FT3ZOOGJ0dmMzSDh0cTZSV25vZnNtOC9RWkN0LzJnWmFzTS9W?=
 =?utf-8?B?QWt2NzVHdll1RU0wYVlnVUJXZmQ1VnVURCttMlhVTzRyVms5Wi9SVVlrUjBU?=
 =?utf-8?B?MW4wV3NuRjg5aDFpMmh2L0FDSWo4WlB0NzRuSDV5NTBZN0JBZG1sa0lrQUJS?=
 =?utf-8?B?SkFySkdBZTdTNWw4TlRZMDkxZVh2ZkRXclBTNzFrZksybTdSaE1yUlNZNnpn?=
 =?utf-8?B?L1RPWlpvS3hpdGRRY0xjMTZpMFdManlSMjlIdkNwZ0YvWUo0ZTdzVXVhK20z?=
 =?utf-8?B?MmNVaW82aFRmaG9xbG9tQ0UyUHA1dkpUMUIxZ2drRTJQWkRWZUlHay9FeWFz?=
 =?utf-8?B?dnFwb2I3UVZxdzBOMExXUTVpa1ZTalBYVTNHTnR6RS9BMDd1YkhpVWc3TENQ?=
 =?utf-8?B?a1NpNlZEdVRpN3VFZGkvd0tLUG8vZ0txWlE0cERxdU9Ha0dkUTNnWlEzL2lB?=
 =?utf-8?B?a1ZKZlUwYzdIV2FKQnRCM1U2ZElJVm9aeklidWZIQ1NrWXNUYytlb3dhdHoy?=
 =?utf-8?B?dEtRbDd1U1Zzc2Q1VjB3czU3eUEzNll1b0lNZ1B3UGJDMkRGSE05eE5vak9S?=
 =?utf-8?B?NEg1R01vaTlhazBNdHViV3N5dm5sd3JmR3A3TnRqcVg5a2ErM0RJU2RISmRI?=
 =?utf-8?B?QmtnOXUrd21tNmI3bkZUYUh1K1F1MjJkWGFtK0dyZG1veTRaSitGdjZzU0pQ?=
 =?utf-8?B?dENJbWxkYmNFdDdlVVVQT3crWkNRdVVSVy9yYkVQT1hFSFVkaVhKUmo3U1VO?=
 =?utf-8?B?ckFObTYwQVJEUUM5OWRQemR0ZzlDdjJ1NHBRa1ZTeUplQ0E0QUN3MEJhU2FC?=
 =?utf-8?B?b256M1cvS3dab0JGL3gvcGpEQThmbmVJY0VyU0ZnaHJ2OEdIRHV1RlZvc2c0?=
 =?utf-8?B?RVJMZ3JmTjlzZnZJT2t1WTZCb0ZXWnlsRVNoNVEvNGFsTGFuZVY2YS9yS3I1?=
 =?utf-8?B?b1NCNVpEWS9idzlVMTdWM3l1dmVIRSt0bk1SWjB4OVAvaFNFc2F3a09hRm5G?=
 =?utf-8?B?Smg3RW0vTmZVdmhHWVE4YkM2RFpzK3ZyZHVoRi9oeXFKNFByTG1vZHg4T1lw?=
 =?utf-8?B?cFZXNm9NT1pOWEJhMkdKYXFkK09ZYjZlT1BVNm13eVd1VHljc2F4YlE2RVlP?=
 =?utf-8?B?MlBRK3YyL0JGNy9tbU1NVHZyMmtnNE5odU9zd29QdEMvQUZsdFlGRWNCUGRZ?=
 =?utf-8?B?dVVFUkFybElmbjJpZHZJUEpqNHpwTHM2TVE0TWNrclBqUUVka2tFc2NsTk54?=
 =?utf-8?B?SzZ4amdPR0ZWd2d0Z0VPL25SNGl3WmY4VTRNK2pVc2JxS2lnMjRaRVdlM2VI?=
 =?utf-8?B?ejZVQUE2NnFtZEtMdXVRZGZibWtMNlB0Tk95aEJiZk96VjFxWW9BdG05elpE?=
 =?utf-8?Q?9HtEDH08CQLP26o0/8g/7lGX4CZL9a2n?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:02:03.5792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4433bf9-119c-47fa-5cd1-08dcafe7c9bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6681

On 28/07/2024 7:45 pm, Qais Yousef wrote:
> Improve the interaction with cpufreq governors by making the
> cpufreq_update_util() calls more intentional.

[snip]

> We also ensure to ignore cpufreq udpates for sugov workers at context

Nit: s/udpates/updates/

> switch if it was prev task.

[snip]

>   
> +static __always_inline void
> +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> +{
> +#ifdef CONFIG_CPU_FREQ
> +	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> +		/* Sugov just did an update, don't be too aggressive */
> +		return;
> +	}
> +
> +	/*
> +	 * RT and DL should always send a freq update. But we can do some
> +	 * simple checks to avoid it when we know it's not necessary.
> +	 *
> +	 * iowait_boost will always trigger a freq update too.
> +	 *
> +	 * Fair tasks will only trigger an update if the root cfs_rq has
> +	 * decayed.
> +	 *
> +	 * Everything else should do nothing.
> +	 */
> +	switch (current->policy) {
> +	case SCHED_NORMAL:
> +	case SCHED_BATCH:
> +	case SCHED_IDLE:
> +		if (unlikely(current->in_iowait)) {
> +			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> +			return;
> +		}
> +
> +#ifdef CONFIG_SMP
> +		/*
> +		 * Send an update if we switched from RT or DL as they tend to
> +		 * boost the CPU and we are likely able to reduce the freq now.
> +		 */
> +		rq->cfs.decayed |= prev && (rt_policy(prev->policy) || dl_policy(prev->policy));
> +
> +		if (unlikely(rq->cfs.decayed)) {
> +			rq->cfs.decayed = false;
> +			cpufreq_update_util(rq, 0);
> +			return;
> +		}
> +#else
> +		cpufreq_update_util(rq, 0);
> +#endif
> +		return;		/* ! */
> +	case SCHED_FIFO:
> +	case SCHED_RR:
> +		if (prev && rt_policy(prev->policy)) {
> +#ifdef CONFIG_UCLAMP_TASK
> +			unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> +			unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> +
> +			if (curr_uclamp_min == prev_uclamp_min)
> +#endif
> +				return;
> +		}
> +#ifdef CONFIG_SMP
> +		/* Stopper task masquerades as RT */
> +		if (unlikely(current->sched_class == &stop_sched_class))
> +			return;
> +#endif
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> +		return;		/* ! */
> +	case SCHED_DEADLINE:
> +		/*
> +		 * This is handled at enqueue to avoid breaking DL bandwidth
> +		 * rules when multiple DL tasks are running on the same CPU.
> +		 * Deferring till context switch here could mean the bandwidth
> +		 * calculations would be broken to ensure all the DL tasks meet
> +		 * their deadlines.
> +		 */
> +		return;		/* ! */
> +	default:
> +		return;		/* ! */
> +	}

Nit: would it be more conventional to replace marked `return` statements 
above with `break`s?

> +#endif
> +}
> +
> +/*
> + * Call when currently running task had an attribute change that requires
> + * an immediate cpufreq update.
> + */
> +void update_cpufreq_current(struct rq *rq)
> +{
> +	__update_cpufreq_ctx_switch(rq, NULL);
> +}
> +

[snip]


