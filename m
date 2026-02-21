Return-Path: <linux-pm+bounces-42964-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 18tOKA9PmWm6SgMAu9opvQ
	(envelope-from <linux-pm+bounces-42964-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 07:22:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E781816C423
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 07:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279583018AF2
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 06:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0A2FD69F;
	Sat, 21 Feb 2026 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WZ2QGN1L"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11526B2CE;
	Sat, 21 Feb 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771654924; cv=fail; b=cAjOqWSTOmbmDUZ/CN8RNTPVNmPZIGxc7qtzOZG+2nHg8qPhTz3CSY2+ycfRXNarPljzNc3m+whECjDQ7Cv69FH0qKQZ6NkCNn2tVU4Vt+VaL8z9/Oprl3uZpvtZxJAzw9ZMzHQ/ByG7EgV8rKXOSPocSCph9XckiYKGkhMhxE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771654924; c=relaxed/simple;
	bh=zMvyAsdHxdwiMEhA7+rAv0d+jKos9jnNSYYa07/ixF4=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=tIRQL7Z7mtIeG0GgLlqtx+M6Y1RrYDdWZ/uCz9qDMwlBzV2yh/Y0Jtv7z3iefndhwntGTZh9tY+sP/ijfmaSXnrUQy/lXMtkTUn5rVfa1W4LXojD9HYENqMl60r6cpu+TzWKX7kExNTeWrcZj7DSYvlBDfYwrHtvmaGw2yx/ul0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WZ2QGN1L; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBr2fOPgwSB5q+CL6STxos1DI5yAwuqiRN+8Y/n7UZgvrgo8dP9GOGHc+s1XHs1OakF1GwUgfGdf1DHUBK5ppLpMf0LVeeHuUxUzSj/bNZSraDiXC5x7MDEIMRqW10awkV9V6iJ4aVehhvNiHZ20Zi6YtGojgaTL1C9PqpuLnTViX6VHnjG4Ia8cwXub5lvavICCGjx6Cv8u5gCRlKWDh6o1I/qS9ajqBEjr3kffFaru079unO6z1FRpx6mapZEs8L3Xos/x90hYb5gZygqdZotW6CKvog15iQI7tNAQL3o4CJAjMBdZGvfSyMTmF1XhhGtmT6V72IJyC1pA7XP0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPcvUqs56oTChxZKo41eEDG801pbVzN0Oy9Lcm8d3as=;
 b=TVWXNK317p8rEBJjWpMgNYMnKh7Nah1pS3wsVpR8awPSAiuvM547ZNvaNF1P3GGiuhrjlO6F2czYG5gz5kj1eBqEtAZgtHZCUblYlntiDKaipyBz+RspSN53grQYzoLjHDLZQP74Tf4GlB3jMnAQZ+ywV/SZvatt+8/iu2AhXyq2r2n6F5GIXtiGKTz4ZDRiz4kt4uNd0MB465TvN1C6k7bDnaRgrWdWY9fSqeHoVXEAw0am7S9YIxoB4FyvotFvP+lDe4h+Qcb6JWL9h0R6AX/tzQpVpQIHTvwiddNT/tHMO/x/+1Ce6ad6A3xzNNCvujIbiHYtpxtzgyaHT3eodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPcvUqs56oTChxZKo41eEDG801pbVzN0Oy9Lcm8d3as=;
 b=WZ2QGN1LOivmukawndh6keXA2mohhhgswxl5ddPCCsMhLkdNddCOBtRu8rcLSEQ0/pfEYHKu0+CCZ8EIm9ZNfjseGsB0b+hGOd1KpZnUYq7FWyOLK+VDnkyLPa0VeuU39xPMXEDH2BaU8yQ4jAe1MaErI5ZPasMbKRMQaNG0Q9EDd6YVx9wz5BvpnB/QcbTEvBnVjvcQHd9S2iEjH0Rzpc1qTc6k9ORJPo2z/EY1Z9UjwvxLFAXq1bd3ZXCTBpNvPZT5P9TxXDT1d3x1npqOPewzibwtrStnAtviXQbQhEOTqM4uYNBscDA973pYeO57tNAco/EZ7tV4zjDqP8m3tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:606::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sat, 21 Feb
 2026 06:21:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.015; Sat, 21 Feb 2026
 06:21:57 +0000
Message-ID: <b44f2af7-360b-4f4c-8541-04008ead7dcb@siemens.com>
Date: Sat, 21 Feb 2026 07:21:55 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] cpupower: Add support for setting EPP via systemd service
Content-Language: en-US
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: db0b67c7-30a4-4305-f32b-08de7111839b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGlqY3dNR2lnTE1ScTVjNXNDTVpkcnVLTnVlT2VhQVdsN2RMSDVzTGNOaVNT?=
 =?utf-8?B?S0Nvd3BaU3NuYkNrdWVoTGh5NXU0SVl2NU9HWmhkMWRkSnVmTmkrWEVGZE1S?=
 =?utf-8?B?OTFncjRCajhCbFpaSFJPOC9lNTdrRnBqdFpFRXNvQko0MWgvcElPTE52NEJj?=
 =?utf-8?B?TzNwbEJlaWg1eE1HaFNHdEt5TVhQZ1JTSE5kNHZ2MG1YME1LYnNPL215bDFZ?=
 =?utf-8?B?b0dhWS9ZRjZURHdTdW1xcTNXb0xVR2lRRGVXSzI2RVpkdWVTMGU0ZlNEUUNj?=
 =?utf-8?B?djd1d1hSZ0lFelNlSW1Uby9naHRrOGk1TEhiSU1WNGY0enpYMkVmWEJUSlZz?=
 =?utf-8?B?Y2FiSDdEdkJFbEVKMWllTEkxY3I5WHBEQkVobHFSQ3NqenRNOE1FcTZsblRl?=
 =?utf-8?B?K2NkUVRjQTFTNUd6WVZMUXhyNFZpQXNKRUtMRkRzTVlKSkQ3NFV1MW4yMzFn?=
 =?utf-8?B?dTNCZUVYeDVySVdxQzdTSXM4Y2FiQ2FnNDN1MGUwVTl2QUF4NHgzMHd0Vmhn?=
 =?utf-8?B?T25EbXZmdFM0ek1RL1EvZGFyVUExb2w3VTg0NHc4Uy9zeGlOYTc1WDR6QzZ5?=
 =?utf-8?B?cnhJcXk1ZFRWSXVmWCtSRE5EVnpFZGhnV1cyV2VQaVhiYnFUZi8vTUZTWHIv?=
 =?utf-8?B?SDNSL05mb3krUVVpSzhLbUFqZDdmQ3hxQlluZVluWDZ4YmE1Zzh2eTZkTHl2?=
 =?utf-8?B?WDlMOUpWU0RVQUtETUNvT3BUMUR5MGpLNmFXM1MxNFRvMlpBcXVxRUo2NGJI?=
 =?utf-8?B?L3hEMng0aEI4MlJUV3NISkJFcVRacUJxcVB3T2FvVUNqTjF6L2ZxTmU4K0Vn?=
 =?utf-8?B?RTB6enlELzY1aXZjOSt1d2I5RTJ4T2FZblRzZUNrUWoyMGtDcXRZMmdoZWNF?=
 =?utf-8?B?YjM5dmdqditNNVVvK09IMktaVGJiZ0lBWGxJL1NoeFhnalU2ZzAzTldDR2hi?=
 =?utf-8?B?SVd4MlpPZnVTZ0prY05mUmkzVXNkNGZhQkVJSkRERVM0NUVJM0ttZEVYZEVs?=
 =?utf-8?B?ZHcyOCthbS9DV1FhbE5QeDkwT1g3UFFGK2hkMi8wd2F4T3ZSWllNdjZJeWxD?=
 =?utf-8?B?K0J5ekxWSmFPaW1PSi9BUnhrSnQvQWJuY2FZMUpYdVl5anVsNlFVLzJRazFi?=
 =?utf-8?B?WUtqOWx2a1RZQmxPOS9MbkduU1RLSDBCRDR4K3djVkx6UEUxNlBvSk5pQ0R2?=
 =?utf-8?B?N0d3QndpSU9IdGN0aXRYN3QwN0pQSHpBbUMreml1WXBvMjE0QmtxYjFMbmtD?=
 =?utf-8?B?ZmxxbWZVNkhORk9HR0VkL1VWOXllc2drOUxGbUt4RUc3U2tHd1cxenZaUWtS?=
 =?utf-8?B?TGw4a1l5dnJWYjg2d0tFK2lhRDNFTDVyMTdZQy9Tdk8yWlQ1dlVKQVJjYnZl?=
 =?utf-8?B?bUlKOHc3UnVsb3dHVW1BcW5vN1ROZStXTW52WDA0WTVPWDRxQTI1R1NvQmxt?=
 =?utf-8?B?WFRJV0NoT2RJemVyVWprcm1heWxwemZ3Q003MHpUSE1Uc0lUY1ZvSy9idzBl?=
 =?utf-8?B?eVVUQTByVmgzQVZXdFVUR3ZiWUFzZHM1M1FCZ0FNaWkvaDFqUUZCazZibk9X?=
 =?utf-8?B?UzZJT3ZwZVFUMllBTTVUckVXWjlmSVF6SmNSZ05sUXNUTG5XL3VSVGswZjNK?=
 =?utf-8?B?NjA5aGZjSk5Wb21xV0VpU0E3eXNoSzJLbFZuMU5xdEdtZ25lUEFNQmlQNkJD?=
 =?utf-8?B?a0VVM1UvMUNEYUpOQ0xwelBHbWd5anBHNUt4R1puNlNhTVJ4QjdQV3Y5bFFt?=
 =?utf-8?B?eEJXZ2VoNWtXTUg1ZHVCbXRBcE5CT2JxVUxnWDhpeE9ZUFNiL003eXB5dGxi?=
 =?utf-8?B?N28wS1BIdmo4SmZaTjE2bGZDVmJwcUNOcjRQQlhaWitkV0crMFNpUHNtaHVB?=
 =?utf-8?B?Zm5JWXd4cTJQd1krOCtWKzRlYnlGTTNLSnpxRUJzaUM4WTQ0d3VUQWRTcmpB?=
 =?utf-8?B?WmFhWDU3Ym5tOXZHV2lXWTdUQ1JYS1M1MWliQzl5WmtLQncxRHI2VFB3Wlp0?=
 =?utf-8?B?UVFiNFFTS1o5enZxSy84SkNxV0pBd3NNbzloTFJmb1AwUnFnK3hrWUFTdVJP?=
 =?utf-8?B?L01JcjNJelJOL3kweURDOUhCYW9LWjhwV0xKcTU1Uld3R2d1M3N4dW9kYjdp?=
 =?utf-8?Q?Cq4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEh4b2l4Nk1oaXZMeVZVVmE4RFVtWnhQNUh6ZDRsWDRIOE9MaW9ZNE9RdkFE?=
 =?utf-8?B?WVk1UTZ6Zk5zYkhwNlV3ZnBRKzhjbGNjL29RRyt3NTBwTzJOMnhyM0tOY3Ns?=
 =?utf-8?B?TkNxdUJMVjJzaVF4Sm1YbEkzd3pSSWo3Qjc2NGswcm4wV2hZM3VIVUJNNWY3?=
 =?utf-8?B?cVpWRm1VSWNBWkh0TG9wNVd1U1E4WThsRjAveURCZHZyMFFsc2ZWRU92bWk5?=
 =?utf-8?B?c2hQZExid2R2Z21Md09rS2FyemlQRFJ1bnpjbkdzdmtPSFVjYWEyd2FGMGVz?=
 =?utf-8?B?OElZbGdiZnJJSWt0dWVLUUdEbEY2WXFGajR5Mk9PbitCb3JRZ0hvZ2twMmpE?=
 =?utf-8?B?TjZoSmdZcVZ5eE5YZmhoaUFjSk93SDJnOWdJZ0FsdG9MenV6dVJaU2hPRjhn?=
 =?utf-8?B?cXFBbjRscGdTQXV1Rk5WM2M4dlZJQnk1ZHMvKzJKYm96WHVPUDgwNUJWS0k0?=
 =?utf-8?B?T00yY2JvNmhrS000Rk4xcUg5ZDVZVGRBdkZuci9tcEwxTENFR0tLTjVzS3pr?=
 =?utf-8?B?Vk80SlJRd3ZLQjcrRTBNYnNhbGI4a1pCK3NMM0YrYjdGUndTNCt5TWNWay81?=
 =?utf-8?B?Tk1NdjFpamt3Q2lBUmdUV1ZhMDdvQ2FTQWhBZld6WGRucEhITVpDUE5PZm5i?=
 =?utf-8?B?V2paL0tkR0g1RFNaclNKQ0lhUlc3NTF5RzZ3bEpwUVNSQXQ0empJMGFuV05Q?=
 =?utf-8?B?VFlZWjg3QTlGbnNwdU8zQUVoWTJuOFhjWXoyTTRXWGhZcmFCVVBIWTdzaGtE?=
 =?utf-8?B?bWRoaksvQUgwSGliUXBWNGovTHRuWnJVV2RKbzJYRGVLSzFYT1orZERzZ1lh?=
 =?utf-8?B?eEVqZEFNaWlXaWlHalhuYTQwUW4wUHQwWDBjc0JQakgwQWM5ZGYxYmtOWFFt?=
 =?utf-8?B?OFFRV0thQVAzbUUxcDNXTzdIazZ1eXcrUjZmNytwYmkza214TVpVWmgxVHJZ?=
 =?utf-8?B?c2F5cHRSWXBmcHYxaDBWRVhpUGZVbEFSUVBnY216YjZnakZMRVNwR2orbStO?=
 =?utf-8?B?a0p5SWJxVkJZd1cyK1VZZWVJNG1vNGtGRUpzMDhEdjVBTVkrNUV3NUZuMEhY?=
 =?utf-8?B?ZDFCRzlYdXJQSzZwaDJuSXFMREQ5N2RTN0t6VFpCVHIyOW9OcTVCRnRsWVFy?=
 =?utf-8?B?Qzd5NzhZQUQxTnpHYlROb1NKejFCSHljUlRVQmJUM0hFbUc0MVNFcFdENFNE?=
 =?utf-8?B?bkJIdFdiWERqUHJVYlB2VncxVEJNbjRvWitJUWlhenFlUFRyTEIwVzdwMG1Y?=
 =?utf-8?B?UjIveHlIZ1FkcUt5clEvd0VadUNCdU5FVDRyYVVZL3k3cTRFUWY5S2prb1Jt?=
 =?utf-8?B?bnlLVXJEOTA3MUozVjBZcXBHanUxM01CUm82a2R3QWVqcU03Q1JUckJqYURQ?=
 =?utf-8?B?WUFZTFlYc1BMbm1yN0JjWjJDUGtRVVJEWmJDaFJCSGh0d0hkV2p3Z1V3RzZa?=
 =?utf-8?B?NE5hTEpOS3M3eGFHZFAxa3ZFN1g2WCtRbUZyVUEwN1NnM3ZUZmQ0bWtkYVNl?=
 =?utf-8?B?dEFINGZrZ2RybWVnTEJCVFY3K2VpbGI3QUVuSE05YXJvbUh5RzErU0hOZERv?=
 =?utf-8?B?M1UrUlJiTWErVUZSVi82NTBkVkZuMTdyTXJkN29wdnJaVStSbDNnUTA5ZmtE?=
 =?utf-8?B?WnR5d1E0R3pKSnBNYWJNNVV3S3g3enBRR0p6TjNWbVhYOWxVTWhBNUo3WS9x?=
 =?utf-8?B?dFp0RVVQTzl6dElhT0RoVnhtY0hrUzlGNjZNM21zUFNocXQ5eXgwWHl2eFN0?=
 =?utf-8?B?STZIb2s1QVQ1OGYxYlBjZDhtRmNoNkdkaE43SWVtdnhOMTFaUU0rRHBsZmda?=
 =?utf-8?B?UTIyZHdnS0lzdUo5OFFQRW8wc3d5VGlXRVhRbjlVYXpRQjhxWkltei9oc01U?=
 =?utf-8?B?K2tYcGxjTWo1YmRDVzFaeVZZaGtGYTZxei9iR0MycjZMNklPUm9xZ0JpNUN3?=
 =?utf-8?B?ZGxTQ09ic1FGVFBwb3FEUUd2dS9aQUM3VG03dkpOVkRPVVYwR2dpQ1VqclRa?=
 =?utf-8?B?WXRSL3hCTUZJUkQ2bGdCWGYralVxRWFtdnlocVZZQ3N0T0pudFlLaHdkYzVE?=
 =?utf-8?B?REwweG01dk45SmZOOFFiK3pJV1NHU1VKRk0rZm83aWM3Sm9qUmF1cWxieHBt?=
 =?utf-8?B?WmdZWkU0cmlqcUZ2Z2k1STZna0dkNXAwRmNHcXQ1RzRLUzlqSy9DMVZ6QUp6?=
 =?utf-8?B?TmltMm02VnBQUVlzc05vc0h0S1hWaTV1bEpUdlIrMVJmK0VGZVZRZ1ZCbDcy?=
 =?utf-8?B?OUszbWxHZDZKTktsZmZaOUYrQWlFOUlqNVZnTlNkOGVoMXRVQ1hGUXFoZ0M2?=
 =?utf-8?B?bnlqMVIyV09MMlZjQVlwYk9yMUp5S2RaSjVaMjUxZVBJRVRMT2o3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0b67c7-30a4-4305-f32b-08de7111839b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 06:21:57.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmHE8KMyrIjk13lepWFi6FFPIfsFj2yrfBe8qtWLILi0m0TjcLdIuOek257oCFcnTCJr01sCI9Wd+o0ftsQpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42964-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:mid,siemens.com:dkim,siemens.com:email]
X-Rspamd-Queue-Id: E781816C423
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com>

Extend the systemd service so that it can be used for tuning the Energy
Performance Preference (EPP) as well. Available options can be read from
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences.
The desired one can then be set in cpupower-service.conf.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - improve commit message

 tools/power/cpupower/cpupower-service.conf | 5 +++++
 tools/power/cpupower/cpupower.sh           | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/power/cpupower/cpupower-service.conf b/tools/power/cpupower/cpupower-service.conf
index 02eabe8e3614..abbb46967565 100644
--- a/tools/power/cpupower/cpupower-service.conf
+++ b/tools/power/cpupower/cpupower-service.conf
@@ -30,3 +30,8 @@
 # its policy for the relative importance of performance versus energy savings to
 # the processor. See man CPUPOWER-SET(1) for additional details
 #PERF_BIAS=
+
+# Set the Energy Performance Preference
+# Available options can be read from
+# /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
+#EPP=
diff --git a/tools/power/cpupower/cpupower.sh b/tools/power/cpupower/cpupower.sh
index a37dd4cfdb2b..6283e8bf275d 100644
--- a/tools/power/cpupower/cpupower.sh
+++ b/tools/power/cpupower/cpupower.sh
@@ -23,4 +23,10 @@ then
     cpupower set -b "$PERF_BIAS" > /dev/null || ESTATUS=1
 fi
 
+# apply Energy Performance Preference
+if test -n "$EPP"
+then
+    cpupower set -e "$EPP" > /dev/null || ESTATUS=1
+fi
+
 exit $ESTATUS
-- 
2.47.3

