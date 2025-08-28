Return-Path: <linux-pm+bounces-33222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E645EB39540
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEC31BA224F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF882D6E71;
	Thu, 28 Aug 2025 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NdyKipbl"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BA01FC0F0;
	Thu, 28 Aug 2025 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366425; cv=fail; b=dPphICGObY4DB2gq/zWYs4w5XPyDakTl3lBTMom+CSfQq9adqtv+KwkAZjHNdZ8FD0xV+UGmsTGD0gLmmU7+4Vaq3JCA34l9y4WEZ50kYW8JyTSFrqPBeMMMPwaFT6iE+IDoksM7fcNiVZbUwkngBMzkejN6p858KMKXTVBJV68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366425; c=relaxed/simple;
	bh=Nqf5lwCBye2d+EkEAkUHptlqd/kI4DmBVr0bhbGkVK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TByHiUmrx8jJpZS0CSqFJqsMdKsmmG4AMtJm3GnzTCnFJ3mXs3QZwTHWImKXpa4wQ9U3D6mrlygAf3KylJodBTYl6xysEPZzw76ebMWWYv2NLdnJoCi3L5bo7otluJOoFkhgMHuGESzyVJxPGjjGXTYqdubbJ3WvkIC3WRt25tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NdyKipbl; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Td5YiNiCtb8RpP96PXntkWBmrwNYW+TefxXUuBzpnnmA92eskbnYKDY43VgVgBzYJQIn/0PqPjB98vbLu4bS0BgqxpofX9hxno6TtvpFfvk4nYfUb97rkk8tlZxyapuDO6XS9xY7dnBodLyw60bHS7+pa8Cml24/9d0KOFG195hogc+m3lLduXagVLmu53AszewoPHovFQLFRyN6v6dn5/NkQ6aPnTXetRU+30YgwsRqqSX8w0vc2++A0pKLLF7IhX6JLkR1YfgKarQBamEdL6eM+UDfjdXR3OPn3DCOTpb6pLzF9R4H7falSkC1M8cPD8wwwGy7B3cKjDtXlNnxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JF2tox7BZUjmMmYuKuZUUpt8WNsNsoU8qZH113uWfA=;
 b=KXoHUvj8xp/mCZQ2kRFBCk1ir5KMGgRxewbJgl9mQXLXNMK7SXAfg6CbNelWaELC5mgg2+veQJs+09BjUgx4JwhO4QKHte1zom35SX2wgroCUdBYgT1j4OpFG6qLkMsSjrrJbhdG80xY778vpipTsGeatLJnfFFVzrq6HIqWMrQPkp6CpGzHNIpDnD7pSXOXBTAcJ9s7mLI4pBl8sm2wsUPIk6pza+UiW1VtN9p7JZ/m2mu5gsLNR9GwnMkMNSPJzIQ2aBfZAW6pgu2+LgvvY7o9ewSDWBjAGGuMe/LibjLMda+C/a96cL6+W8eGY7x0lI6Zi2gkZ1B3seEFp9aJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JF2tox7BZUjmMmYuKuZUUpt8WNsNsoU8qZH113uWfA=;
 b=NdyKipblNNJWPL9jJijPYwAfheamOtLUR4IlqSsck4qgD3AhklGAJHtVCFGTlF4lc8BqlaaP0IQcOwQA1/gztQWjwWG6PYrsD5eniEojWZ6zbalp4rV9/JSBjTw6Ga09s7wihFVme7Qy1CYTCMhOSwrUVwNseOpe2VX7TcKZU0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 (2603:10a6:800:1c2::19) by DU0PR02MB8168.eurprd02.prod.outlook.com
 (2603:10a6:10:320::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 07:33:40 +0000
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d]) by VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 07:33:40 +0000
Message-ID: <6162e560-1b60-4e30-8d1e-210ba9e132cd@axis.com>
Date: Thu, 28 Aug 2025 15:33:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] power: supply: bq27xxx: restrict no-battery
 detection to bq27000
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Sebastian Reichel <sre@kernel.org>, Jerry Lv <Jerry.Lv@axis.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 stable@vger.kernel.org, kernel@pyra-handheld.com, andreas@kemnade.info
References: <cover.1755945297.git.hns@goldelico.com>
 <dd979fa6855fd051ee5117016c58daaa05966e24.1755945297.git.hns@goldelico.com>
Content-Language: en-US
From: Jerry Lv <jerrylv@axis.com>
In-Reply-To: <dd979fa6855fd051ee5117016c58daaa05966e24.1755945297.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0058.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:39::7) To VI1PR02MB10076.eurprd02.prod.outlook.com
 (2603:10a6:800:1c2::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB10076:EE_|DU0PR02MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3c7fe4-c6fa-4cbe-0664-08dde6053561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|42112799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2UvMzFKcXJxd3BHTkFmVkxjcHU0ays2YTBmTDBpbVRBcEJjUkVJYTBtSHE1?=
 =?utf-8?B?VEhMODZYNytCLzdSVGEwMXcwb0ptelZCWWR4elNwVjljY1RBeXdUNHoxeHBY?=
 =?utf-8?B?VFY1a0dFalpMVnV0TGRCSkhkc1JhU3pRR0o0WVIvTm9CbHFScUhEZ05NenZX?=
 =?utf-8?B?bm0rbytUTVJEcGk3SlcybGZSVm96d2twUXpaK1dRV2Y4aGYxWUpzam5uR2Jr?=
 =?utf-8?B?N1l5R0FTM013dUZZREpkWTg0VXlOeEFxQTE4RTV4WDVZbTlWVEs1VEFJYmFE?=
 =?utf-8?B?Ylg5ZWJPSldFZ1NjbXVYSUorMHhQUURyNDFhT0tqR0pKcjBqdEd5UDlGd2hz?=
 =?utf-8?B?OWY0UDNaRzArR3Y3WGFWUDhUdktkN2F5dzZJTDcyTEF4SnpOUzhKRW91RnJ6?=
 =?utf-8?B?MXVBM1ZvTEk3VUswNkVGK3QzRk9UUXRXSEtNTlllZmRJWEZ5aWxHTjVxTlJx?=
 =?utf-8?B?d2FDdmJFdFpSeW5kNzZFMmVWektaZjV1TG5seWg0SFJuS1pqanpIS3hMM1Bs?=
 =?utf-8?B?ZFgrY2ZYUXlHQ0VUajNsNTRrdXFuYWVQK1JSdXdMbnUrMmtqaFhxYmZsYlFo?=
 =?utf-8?B?c1BDUkx6RUxLeW1MbXN5YXlJdmN1elZFV2M4RllsZ3RGalh6bGRGSFdaaHRn?=
 =?utf-8?B?SFc2WHFhVDZxbzRFY0UvbDVGRXpUdjc0QnVWQTdjc25NSHIzdDRpMy9NSFBW?=
 =?utf-8?B?dFJPMHdCbFkva0QrTmlrYVBNaklwc21UYmdiUGpEam13RFpuTHRTbTh4UkV6?=
 =?utf-8?B?SWYxMGQyNEQ3aGJIVHlnTjFML0xtbllIQkg2Qy9zRzNlS0pKRjJxU0NVOUp4?=
 =?utf-8?B?T1FGSFZWK0tsNkpoZ0lVSWFrK25GbUpYcDZqM1FhemovdUtNd3owaHZQZDM5?=
 =?utf-8?B?bXpRM0I4R2lGSTVYVlFCTFE1U2hEZmhlNjJFNU5ja1BaOFFXajArSHk3enIr?=
 =?utf-8?B?cVFqbnFYOWd4ODdzRjdFM0RQR0R3TzRtamUzWnhBZVdETjhySFJjbHJRQTJQ?=
 =?utf-8?B?M1o3YlVXY2x5V1RXbTAwZXZmbUhFMUMyWlNPa3hEanRRTlpJRElCNUJGNFV4?=
 =?utf-8?B?ZjRkU1pEaGJSYzJ5cEgvYkcyOHdmMGo1T3g4UDBtYWlzZ1VkZUpuYjB5TjYz?=
 =?utf-8?B?T213QUVFSjVGcHRSc0xFMFBZZUJNNVVqVWwyQ0dtaFhXUFNMSGFTSTN2TUJY?=
 =?utf-8?B?aU5XMlFxNnh1aE02WnNFdnAzdFIyeFBkM3pienRXcU81UTQzamJxSFArU0p5?=
 =?utf-8?B?anFtbktmRlVBbDZyTmg2eXdqeTZsdDNBaXpEQXE2UnZIeGVSQ2ZLREtnRlVW?=
 =?utf-8?B?YlZQZ3pGbEc3RlpqUnBOckRmR09GdTBhN1llTUNuNytDTzZyRmdDL1ZUUElJ?=
 =?utf-8?B?dWdDNFhBWjhRcFhlbHd4Q2RlM2FlRDEzV1lkaHkvbTcyZWtrNFJCYVpheitl?=
 =?utf-8?B?cFNHQlZIZmJObWR3SThwWnJ2SzgzNEpzUk04MDRkQklxb0ZUVjArdVVyVTVy?=
 =?utf-8?B?TGNpUE1VVzhjMUVqMjQ1cXhpWUJMcVE1VUJwdEZtalVDazlVQk54cEsxR3Nj?=
 =?utf-8?B?bHlSMWlhakhsVE11WmpFZlV0ZlJMMWk4Z2F3a3dxUWdkL1NmMTBvaTRjZElL?=
 =?utf-8?B?YkhmcXVKS1hxRVpyNTNSRUVKTXVaVEtPTnd6L3R4WEZRRkRxMGM0cEtueXo5?=
 =?utf-8?B?MCtweVVqbUxQVVFhREdBaGdSUGcyQ2dzaUJaRGpRMUhsQ1p3NWZYaEhQbFVs?=
 =?utf-8?B?MlkzUS84UXJiZnk2RGM1WWRjb3NXa2lLUnIxbTkyUmVqaUVsVHhobnZZUW1k?=
 =?utf-8?B?dGY0NVQ0TldvWVpMaGM1ekcraWZGM2JCN24vTHl2V21Pby9nMFVBbVRqYUNa?=
 =?utf-8?B?cC9qZ3cwU1RIMHFUWEFSVVRSMFVTYkI4N2lrMElpTGRJOTRCU2VCUTZrSjJ1?=
 =?utf-8?Q?iLsV12D7Z5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB10076.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(42112799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFRDc054WTlKbUFFWVJ0WUZQaDZRaUt3UU5ubHRUNVVxZVJzTzN2QVA1bzh3?=
 =?utf-8?B?MmRUZ2tWQjBiczBjNHc0ay9LVjZGZDZmT1Z6MlFhT1dwTDRQUGVWbFRoRXlC?=
 =?utf-8?B?VmxVb255OVY4ZXRWVUIwc2V5c2hwU0pTUTBFSkRkSnVLeEZuYUxrRWg2Y2hB?=
 =?utf-8?B?NkJnV1orZWFaSGRHN3ZzVnYyOHpHemlxMmp5cEVYQzR4RG1KL2RhZThpUW5j?=
 =?utf-8?B?RWZvZU8rWXF6RmdTNEx5bSs4YjNRa0ZnekJUdVhrOFNzZkRiOTl0ZE5ubitm?=
 =?utf-8?B?UFBMemZCWjVuVy8yK3ZGbnZsRTRXS1RYdENNYXJHd2xGbDN3dU1ZalVJakJw?=
 =?utf-8?B?d2VmRkdOZ1BDVXpFK3NkTXkzWlRjdmVDZXkxQzNqOUoxRXo4eHhhUmtDa3JI?=
 =?utf-8?B?cVlXUGVJWGx5bEZuN0hmdWVCT21Wa2E5elNTR3pzamwzZGRBR2ZQbXNIeXIr?=
 =?utf-8?B?SDFrWkRKVzlyUGZqeWVaMXVnVHZjcmV0eUt0N1IzNGF2ZmxlVWNBYVh2Nks2?=
 =?utf-8?B?SXltYzdsYVhzTGdDbS9xbEczYms4ZXB0OXREaFJLRVlocEU0R01sMVlZWG0y?=
 =?utf-8?B?MElBQm5Ddi9pQUE3MUFsVXlBWCtLRFNWa2dwM1haT2hUaFN1ZnR4SHZ1aDgr?=
 =?utf-8?B?eWpqbXBUc2UvamN1UGNwbVZ5VDk4aUVMT1k2V0JoMGY5UmExclhueVJsOUlJ?=
 =?utf-8?B?aUtISDBucEhjdG5RSjZ3OERxaWtobnEvUWtyRm5JWlpyb2Qzb2c0NTFDOXJY?=
 =?utf-8?B?dllXcEl2dWZRSURCNVFzMExobkk5ZzhlVnJLVUF1ZTE1UmsxMUR0YkZwRnk0?=
 =?utf-8?B?N1lRTmV2WEhiV1k4YzN5MHlHWUNSTEovRzVPN0VwdktYRDkxZHppdVg5Sy91?=
 =?utf-8?B?UThhY1l2eVR2YUNXMWZCL1QzYkNUa05hMzl6bG1yelczY1FObTBXd2gzQXds?=
 =?utf-8?B?WUVyTmx3cmdPK3NYN2hZOStjcFhudVUwYTZvUjIwbDlIZlkyaFloRUpoV2hE?=
 =?utf-8?B?ZGUzbENGRFdpaWdsbWJpWTRKa1pNdDIzOWRYQzNydkcwWlNwY3F1VFdsdU9L?=
 =?utf-8?B?bS9wZ1Y3bzZFbWhsM1dGbEQ3ZkpGZnVLbVNaYXJ4OE00WmFZcFBCcjRUcTVW?=
 =?utf-8?B?ZTdQOCtlaEtuMDlKc0ZqTlVaMEZvcjJLOHZremhoNnQ3RzNZeXZhQ0hLSHNr?=
 =?utf-8?B?bmVhMVhtK1k2WHNPby81MWoyTXAxR1pYL2ZmVHIyQ05BWTlnNmZJbWVkZ3dW?=
 =?utf-8?B?cEFEZVU0QzVMSXJDbTQ3a1VNMjh0azl2K0JzWWg4cjBITHNKcEkyN2xuM01D?=
 =?utf-8?B?R0xIdGloUUdVMGNORXVLOW5WemptUTIyMlVnVU4wTnQ4L1c3VU5RaWJrL3lF?=
 =?utf-8?B?eDBvdkpBYTREVHo2Kys2SWtTMlpvQ3VLbGYwMXo3ZDRzWW0rN1I0dGlhTlN1?=
 =?utf-8?B?UGZBaEZlcnJLaTR4c0FNOVBqc3ljSGQzSVFGUGdvTnVQY1dQN29rZHF5UzND?=
 =?utf-8?B?ZWNrYS90am5BdlFTSFUvaU5nY3Myd2hINHBVeGpJUWdsZGNrcTYyaWNudjdK?=
 =?utf-8?B?Vk1XaG15ZnV1TlVRMG1yUXFYOThzMHp6b2xlNFJhd013ZStaTDdkVFQ3Q0Jv?=
 =?utf-8?B?cnBmUEdCc1hHd2NrUEN3Z0pndjBlakozLzlyQkpEaGJjc2l0VGFXT0lPTzEx?=
 =?utf-8?B?dkdUcVBzNEpGUldUVlpHYzNrTU5RL0dOWllsalplQ0tUdmtoNFBGeW1yY29j?=
 =?utf-8?B?YlVKZktrY1JlYTZkS09mTFRXdnRhVnpYNTJ5QW0rcXd4c3BFL0hyZWRYQmRI?=
 =?utf-8?B?bWZXYjRQS1ZFMlZZYVVlVzlML3lrejA0VEJ4M3FDc2ZoWko0ZG16Y2R2RFZt?=
 =?utf-8?B?QmNxaW9yMlJWdml0SW5IWDAzaFRoVmlqLzdtQ1Nud2tSNURSWGNxOHVhUzVk?=
 =?utf-8?B?cXkvTzl3aUhZK3lTRXIvTVVVZWF3aDlKQXpoMnI2UU5DNkFzRGFNbXRGMDVi?=
 =?utf-8?B?aEZlRWwwSFZidFpHWU5qYlNnUW5vOFdaV1RRMEU5MU9CZU9LNk5hVmQ1UmRo?=
 =?utf-8?B?TzQ4U0Foa1lTR0J2d1ZrUCs5ZUZoTitNZU1ucXpNTjhCcWZDdTROQ1BpSFRq?=
 =?utf-8?Q?E27R6bchhIOrU/YdsmSkxkrON?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3c7fe4-c6fa-4cbe-0664-08dde6053561
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB10076.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:33:40.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtoZ5vgWDlTCMb+Wjr16cPMPCZdnHniYLJhYumiav05fgTmixvSqIPgUx7YpyJMQXVfIk6FCwCYMO/X8izvQWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8168

On 8/23/2025 6:34 PM, H. Nikolaus Schaller wrote:
> There are fuel gauges in the bq27xxx series (e.g. bq27z561) which may in some
> cases report 0xff as the value of BQ27XXX_REG_FLAGS that should not be
> interpreted as "no battery" like for a disconnected battery with some built
> in bq27000 chip.
>
> So restrict the no-battery detection originally introduced by
>
>      commit 3dd843e1c26a ("bq27000: report missing device better.")
>
> to the bq27000.
>
> There is no need to backport further because this was hidden before
>
> 	commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
>
> Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
> Suggested-by: Jerry Lv <Jerry.Lv@axis.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>   drivers/power/supply/bq27xxx_battery.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index dadd8754a73a8..3363af24017ae 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1944,8 +1944,8 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>   	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
>   
>   	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> -	if ((cache.flags & 0xff) == 0xff)
> -		cache.flags = -ENODEV; /* read error */
> +	if (di->chip == BQ27000 && (cache.flags & 0xff) == 0xff)
> +		cache.flags = -ENODEV; /* bq27000 hdq read error */
>   	if (cache.flags >= 0) {
>   		cache.capacity = bq27xxx_battery_read_soc(di);
>   

This change works fine for BQ27z561


