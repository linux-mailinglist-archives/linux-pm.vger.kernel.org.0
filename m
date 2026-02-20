Return-Path: <linux-pm+bounces-42952-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BvuhNZinmGmvKgMAu9opvQ
	(envelope-from <linux-pm+bounces-42952-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 19:27:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 025DB16A0BF
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 19:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A28A630055FE
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F1352C2C;
	Fri, 20 Feb 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aJjIQ4sz"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AF2F531F;
	Fri, 20 Feb 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612052; cv=fail; b=LKnenqCJPEVnXSQPN0rF4/sGr+YqnR8KJgWNobSkRjVkDYqw9l70+4UtO9oV2zad7pPxA1t9/9nldOIEteu40W4FJAPPeT7LVzzR8ZNxhBg1y4cKpW8/UNW4dpnweSaGQxOHPkI1zSbJnyqZ8q9rsMPsBB+747Hb0Qd69Xs+Jt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612052; c=relaxed/simple;
	bh=EHxGQKUA7V/z3A6OwAOPJ4U5n6JHfncCLZmG6EIVDi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEO8NZRrEmvJLwQO/yjV1BV0htoOI70I//zeYNo81/jgLQQCq6qhLMJAf47DvFDXDaWeLhinjXFsiPeA+GTF8MpbtTn2xo5/fp6ycUclsOx2TOySF30mbd0l9qJo05qAPb4wlDaCvDFuEHNdJCOFKv8V+HFADn56Er7O6OqcwLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aJjIQ4sz; arc=fail smtp.client-ip=52.101.83.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyCDfvAS9cJZFH9pMfRwXcelF0wAhdbZJ5t+p/IWSBUqzCDgeppBDFYQzGGtmA5XVjoJhWse0g68366Og48rsGqww5jfHBldFqtkdsRmt8lEEYUx5Z2jRYsC04VnXedmJT6bBCIuE64sP//CapM745rjzj6cikhUO/gOGqYpkwkpKGIxqfjqSmD3Y5Xw0tdtVHfBGfiZSDGUI4BpPeCJu2ebpyri0iMbDIdLkRL1BsBsK1OWZnApP8uAMRUk8sImfFSxuFWchz4z+vEidmv8JfbD+i1wE3rQ4bawtVUOQw1xtAZfy1fYq8Ic5mvxFjw8GT+ihOXHCaZ0N8h9BwnIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU1/AoxOMwufwoO1FFGxe+cTaRrfz+p+QBufz4RmgR8=;
 b=NX0xS882xXW/F9zT6iMZdeOnF1D8rCt2/PvIIUoMhxZVK5ErSG6lwes/F28oY0syKY67aFV5pu7gU2B673TTQ93V70lpwOyW58yIehUY478PlPFhh3i3V3jQqK+q2jdQNzo36LY1evjXa3wf61erK6PQ7cYUvKTUREtNaWhVEYmeey564Zt89GyUV2GLNY67bNG0/G5dy9Ks5fiJoqnykzE86fbys1A4rO5Mh5AKH3u5noMYmw5maE97bm064JS7afdbDtW+oCgnTVJFnX/mJS7K1A2GxmSHosdIJKAKKvA0cmMdKcGbd8xDaDziyo7Ib0TLYmtMsMEEAJ4b0SBv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU1/AoxOMwufwoO1FFGxe+cTaRrfz+p+QBufz4RmgR8=;
 b=aJjIQ4sz8NFq+y93JXbjklS8WcI0ylIzjjMIbXaBuJB+2eTiIs+KV3BDlWmSaMv2GTnxNGpcHbCuzt59P/6tAIMRowLR+6ldNj8OML44h3GEa3r3oAFBMBLMlZztzfo92/Jnmd/Z31ZCjSGkGNXi+7NztRPvn5Gk/huL2AXDxmLPTFEOm7fno+KjYZV8GaPzvotWfC3lhbHDr7+PN+n1uHBh0NDKt/dHQEueK/WCyuVBOEKNLO7Mq1ZfSpv17klfgYXTnnNqSmFuOmbxV087skahYnbAKZvysxUIfZyj3HMQOk9SAFsXqTLXpsAAAEwNVW31HliwxwQMckbsFigA6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 18:27:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 18:27:27 +0000
Message-ID: <5a50f8d7-d06b-479b-8b39-71817facd523@siemens.com>
Date: Fri, 20 Feb 2026 19:27:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add support for setting EPP via systemd service
To: Shuah <shuah@kernel.org>, Thomas Renninger <trenn@suse.com>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <aa240c08-9dc9-4e2f-a890-57ba9731fbb8@siemens.com>
 <3cf87836-1fb7-4706-86ff-267383a8d914@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3cf87836-1fb7-4706-86ff-267383a8d914@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c52b331-91e6-47e9-9dbf-08de70adb37f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC95dTQvMURtemJqL1hjNk5sZEpteUtlL282emNjTVdlUlgzNnZtNFpSSS9H?=
 =?utf-8?B?bWZrbklOU2cweW9GVU8zZ01YWk1odis4dnJaSlFVSVhRU2J3WEVRZDlLaHRQ?=
 =?utf-8?B?VHVjbTNiMzJPakdzc2V3Tkpsb29BK0FNOHdYOG11VmQ2RWVQQWFDVDhiOTBK?=
 =?utf-8?B?L0tHaERSemk0OEVVRUt5NXpvaXF4STAxZ283czZUN0dxYlc0M3RIYmtSejUy?=
 =?utf-8?B?dGJBQmpMYmVHZEhBOGdCVWpBNTFPNUhvL1A0bnpKWERXVWFLSTZoeVh0Yjl3?=
 =?utf-8?B?S0MrcmlIRHZTNmQ3d1dCWnptVm5oUUppTVFWN0NnclAwRVFxRTh1WU1CanpQ?=
 =?utf-8?B?ekVwaVJDOGpNMkhLcjdIUmJlek0zaFc0WDdlam5yRDJ1a2IyTlJoNWNyckFn?=
 =?utf-8?B?Y1RNWnBwamZFL1lqMEJpNHlHYXkzOEZTWGltbGw0YlF2Q1cwaEx5dEVjR0Ny?=
 =?utf-8?B?am9Pb29HcmNRVkJOVUJ6RFppRFJHcTNLTSt4c2dmeFRBSWV2bjViOHgwK3px?=
 =?utf-8?B?bTIyMkJJMklnWlVkUSsybDMrQWU3OHBaSVhwSmswVlMvSFd4b25xSHVFKytS?=
 =?utf-8?B?R29jWEtLYW5GdzVRYUNoKzRycDU1MVVHRjRqeFE1ZlNtYjF2eDczNTJxN0pS?=
 =?utf-8?B?bjVEcDVRUEdsb09NRklUUHAza0FvMjF2TWM1Y0p0V3BGOTluaW5rQXVRQktF?=
 =?utf-8?B?NkNYVXFVaGh5VnJYaG1adWR1LzQ4cWFHc1VHYUR6MktXN2Z4allCTWptZFZK?=
 =?utf-8?B?OFpjT1ZkRUk0QWZGdlgrRWZZb1ZvQVdwYTE5UEhhbFZ0RDVqRk1IRTN2Vm92?=
 =?utf-8?B?SFE5YXNLSENKRkYrMFdPa1pmMVRnVUxUS1MrdU14QVBtUDNFcXlVdGNlWG05?=
 =?utf-8?B?Umc1YnFTdVVRcU9NNkZxQXlkSzFzWlRhV0xIWi85c1V6SCtDZUxWZFRYclJT?=
 =?utf-8?B?RFcrM2RlbVBlRm5XbGllQVpUdW9hMmxiNEJQN0VRd0NGeU12ZEJsUmxiQ0tP?=
 =?utf-8?B?aFRITTlJQUdoQVdoOCsyWk42RERZU1BqL2NSaFVYUzhxOHNUTFpmYW1TaW53?=
 =?utf-8?B?dVc5WWQrNEl0V0lGU3N5dWI1eFVOd0hyTG9TeWVid0pDeGJkbUp3bHNzdERw?=
 =?utf-8?B?UDNDK0o1cG9GQm5GN1lJMXNJb1ozZEd2ZGNBUHF2ZHNpbE0yd0Vhd0hpYTh0?=
 =?utf-8?B?aGFLd0UxcHoyZEFmVDdPUWhENzROeUVoT0FFdjBzSG1MdTBpa1RrSFpFY1p2?=
 =?utf-8?B?ZzA1dnh2NXZVRlVPTktmZkJwSXBtM1FvQ2xKWUgvWXZZbG92YzVRRC9CbnJG?=
 =?utf-8?B?UER6eUFZYkxodHYrNG5XdDkyKzlNREREVkpCUVVVOHFmWGx0eWNQMGw4TjBV?=
 =?utf-8?B?NVFaM3JGcVdhczJIR2owSHJINHdmSEs4V0FBRCtaQlc2TXNMSzd4TTNPWWtC?=
 =?utf-8?B?czBUVXpwOUpYWWlUeGtEUXVad3grcHMzcmdUL1Y3UkxDZU1NZlFERVBXREJ0?=
 =?utf-8?B?c0ZaSnRoT2ZtWTdMV3hlQlJKNEtkc3EwNzl5TDZYZ2FxVWpXdjB1RU9pZGRr?=
 =?utf-8?B?a09YRlBIQ2tLTHpZZmRLb2MxeFVybW8wV1BGQ2ZDWk85WVlYV0tBOTZKaVdI?=
 =?utf-8?B?ek12Z0dCTDJ4MEorMGRWU2t1T3ZBMkxNcmhoWUE2aEx3R0w3ZS9ObTQyT1Zq?=
 =?utf-8?B?Q3l3RTZ5Wld0bWl6cVRndFJ0bmFGRmxaeERjLzkxYmorYmlHcWVOZlB0c1lR?=
 =?utf-8?B?dWZQdFloYjRHQXFRaUtVY0ptd25pYjhKTUdJSWlLL3R1OU1MUW5xa3dqejR1?=
 =?utf-8?B?ZU9XMjVrL1FaOHFTUG9aLzZjQmtQVm9NSTdiYnVjUXUrWFlJWExzWmhJN3Z4?=
 =?utf-8?B?SkpBYlc3UW9tOW80MHJIeFhtZzBTWVlXTW9mWUhVT0g2eU00eFRTZjBEaU5r?=
 =?utf-8?B?Y3lYb1J0d1lHZEtaU3B4MnIveGtmV1JCNkVTUVRnQTBzWXljNmJmUnhPVjhW?=
 =?utf-8?B?YjY3alBUZFBPVnZzdW8xcjZCdTRqU0hLOHB5QkdEWWtISzc0R1hCSHdOMUhN?=
 =?utf-8?B?dWd6RE45ZlYwSDV5YUNQVEhGWHZ1TjZQL1NUb1R6RmNneWk2Q1AwZDJTTGlq?=
 =?utf-8?Q?lV54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0EwenVVZDVmb3NYbG16ZTB2bUpIeUxLYVJKVzRGdGc1dGZCMjlOMUZlZjV4?=
 =?utf-8?B?YWNXK0xwVGdWb0lYYkVlampXUkt6dkg1QXZobTBWdWpvV0ZZYkRMOUZTWUgy?=
 =?utf-8?B?Q1F6N0IzVUFyTUp1T1duSnlZNUVnNmYzajBaTnAyaHRwOGIrRTN3R3dYa1Qx?=
 =?utf-8?B?eWxZaGd6Mk0vanRCcms5dzRTWkZkeFJxTWtNOE9oUEgrL0VqNFE0c2JCdkQv?=
 =?utf-8?B?ZjZWakdCRUw5bE1sS2x3d3J2bDg3Y3hXdzFiOGJuOFZPMkppSzN1QUN1Njdm?=
 =?utf-8?B?R0hsZXZVMU5JOW5QREExaU9CbFRJcHVFQ2NNek1FRWhMbEE3d2ZFQlFOKy9Z?=
 =?utf-8?B?alZURHVTNUsyazFqYXlDNFMvVlZXdk5aMDRUcCt5blc2Nm91MHpVRi9oTEt4?=
 =?utf-8?B?ZkRRMnU3ZzdUUjljZ01lSndMNU4wVzZSVmZEWTVlVEJmTVJod2VlWVdlTjdL?=
 =?utf-8?B?SFZQMnp5MzU4Q0JFV3VMR2poQmJNbmlWSnVsbGFWRENHc0NuSkw2MkNPVkRN?=
 =?utf-8?B?L2ZicDB0dzRlUkppTzhjckx2WU1hdndXZm1lc3ZzSFlTU0FubTVaVEtTdFYv?=
 =?utf-8?B?enRqUWNjam55OU85cFZpMEpNK3I5aldxbHNvRWhzTVdaTmVjdzMyamNtd2p5?=
 =?utf-8?B?QTM0M0hJd3Z4eStaMzl2SW9QTjdnSHFlNERCdE5qSm41cFBnVXRlT2hlUit5?=
 =?utf-8?B?SjkwM0VwWlRoa0xhK0luNHpKQ0duRERqZmI2Y2VFVk9ab0ZoNFFBSU5KaU82?=
 =?utf-8?B?bW1CRmZyUHlCVE5URnBERmlZYjhWcG1iaTJVR3J3TWF3YW9GWkJ3TlR0cFVK?=
 =?utf-8?B?UklFOUQ2eTZNOUdFZkFocE9zUUVtZlZEaEtjS3BHOWR1UkZrclo1RHh3dDRl?=
 =?utf-8?B?V0lVMHBrWDVadUwvOW4vQ0RiTjFvT1Z5K3l0RUkxaU1GenNHaTVPZCtydTFK?=
 =?utf-8?B?dVdsd09HakRXQVMrVnorUjMzWWsyVko4dHBjNkk3cy9wMDg5d1lyelZOZllR?=
 =?utf-8?B?cE52SEtud09SZm1IVUZVbmE2emxMeTQyRFRLWXU4Y083SWR6Q0RUZFdTRjdG?=
 =?utf-8?B?dzQvRVdhVGdrQ29FaUs0ZWNDck1MSk1XUVpuZThMcVJiV2ZGNmlKZVl0SDVk?=
 =?utf-8?B?T0l6Nk81WHlXQzl4V0loSEFpZFBuTks3bGVuc3ZxMHFtSnk2ZnluRFdUWGZy?=
 =?utf-8?B?dXhqUEVHbU4rRjVZVGhqSCtpdmszNUpYY25oQmVORWRnSmNVRUNmd0s2OXBr?=
 =?utf-8?B?cFpOeEVocDRqSUFNYWZIbHRyMUFGYURyeGZXamFpanJEeDJ1QUtnay93UmF6?=
 =?utf-8?B?T0lIM1FCOVUrRkxFbkhPRGJ3c3ZydW8wTVY1R1NjNmxUTUJsNnY3RXBTMHFZ?=
 =?utf-8?B?Z3prblNyMThjbGhyWm9lMUt3TkVPVHI4cE1qaDBqSktGVjN6SlRVeTdWQnhX?=
 =?utf-8?B?U29rOFdQY25RckJoMFZvUUd4cUQyNVZ2U21TYzNNT25NeUU5cUZHdDVCUmQ3?=
 =?utf-8?B?VHZsaXRPUWNHNDlRRFd1NXVSUUZOQkc3TC9kM0Y0ZFFlNFBJUVl5NmhpcmYr?=
 =?utf-8?B?TWNiTlNtK29xZXJ4SUJuYjFqM0kvU0wvcjZPNWRjUmQvUHdVMjdYS21odTNL?=
 =?utf-8?B?RjU3bkdnbHlXUjNYa2JCai9TUUZXaTBRek43dU9pUkNCNm1hbXpnQjAzL0ww?=
 =?utf-8?B?ZHduenJTcVpTRUJmZ2tvbmwzWmNuY05VdmNuMHdwZTVyYlo0YVE3L053akJM?=
 =?utf-8?B?bUNKSGxwYytMYVZZckNBejE4N0pNc1R5TGQ2dVVRNnZIemtWZkUwdmtjc1Fm?=
 =?utf-8?B?aitUU0ZhQlBPVFJsQXFOREJYNnBjK1VKTmdRM3dDWDlCRHFQcWdmR2JYc2lX?=
 =?utf-8?B?R1hTVjBtcXhDZGJDQitWMC9tSXlmT3gwM1NTTU8veHQwVjYzZ0lERlZzUzZi?=
 =?utf-8?B?QmptY2xkcGQvUEJOaDJBNSt2a3MrQVFOeEdKTjRJbXcyRkd6VXJKSkdCejM1?=
 =?utf-8?B?dXpaN0tMYSt4TVBwUWlOQ3R0djd3WXpjT1dLVVN3VlRERkVWREsvWXVyZFQ5?=
 =?utf-8?B?YjJsNHRtVm5wR0NKOHI4WDZubmVQY1hNMGxqVmoxa1Z4TnV6V211UHFkUkY4?=
 =?utf-8?B?dXBXZk82MVd3cUhLV2pNVzlyVnhVMUN2OUc3SUw2a1NTQWVpVkdoblhyZXVV?=
 =?utf-8?B?MkMxa09Ba3hRcjlIczlHZ1Q1T24ydjFKRno4V0xkbVUyb1dwTnY2ZmFCUzZR?=
 =?utf-8?B?MlJtY1B1SWpMdWhObmdkdktLNEQveHFsRGdhK2FIS2tjTzJNbENGenBvWGty?=
 =?utf-8?B?TUhpeUJXT3dRVnNwOWRrRjUza21aSHRUVXA3ZURwQ05jY0toTjgvZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c52b331-91e6-47e9-9dbf-08de70adb37f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 18:27:27.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwRrACVMk/d0jaxtxjR+HRObMwhLAQW0hTi8ZvnqoxflRPTF3jKdycscUqf0Fi+aGF/QuTAdgjp995TIims9sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4097
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42952-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cpupower.sh:url]
X-Rspamd-Queue-Id: 025DB16A0BF
X-Rspamd-Action: no action

On 20.02.26 17:19, Shuah wrote:
> On 2/14/26 04:12, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Extend the systemd service so that it can be used for tuning the Energy
>> Performance Preference (EPP) as well.
> 
> How would users use this support? Add a few lines to help them.
> 

Just like the rest of this service: Install it, tune the conf file
according to local preferences. I just followed the preexisting patterns.

What would you like to see on top? And where? Copy what is inline
documented below into the commit message?

Jan

>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   tools/power/cpupower/cpupower-service.conf | 5 +++++
>>   tools/power/cpupower/cpupower.sh           | 6 ++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/tools/power/cpupower/cpupower-service.conf b/tools/power/
>> cpupower/cpupower-service.conf
>> index 02eabe8e3614..abbb46967565 100644
>> --- a/tools/power/cpupower/cpupower-service.conf
>> +++ b/tools/power/cpupower/cpupower-service.conf
>> @@ -30,3 +30,8 @@
>>   # its policy for the relative importance of performance versus
>> energy savings to
>>   # the processor. See man CPUPOWER-SET(1) for additional details
>>   #PERF_BIAS=
>> +
>> +# Set the Energy Performance Preference
>> +# Available options can be read from
>> +# /sys/devices/system/cpu/cpufreq/policy0/
>> energy_performance_available_preferences
>> +#EPP=
>> diff --git a/tools/power/cpupower/cpupower.sh b/tools/power/cpupower/
>> cpupower.sh
>> index a37dd4cfdb2b..6283e8bf275d 100644
>> --- a/tools/power/cpupower/cpupower.sh
>> +++ b/tools/power/cpupower/cpupower.sh
>> @@ -23,4 +23,10 @@ then
>>       cpupower set -b "$PERF_BIAS" > /dev/null || ESTATUS=1
>>   fi
>>   +# apply Energy Performance Preference
>> +if test -n "$EPP"
>> +then
>> +    cpupower set -e "$EPP" > /dev/null || ESTATUS=1
>> +fi
>> +
>>   exit $ESTATUS
> 
> thanks,
> -- Shuah

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

