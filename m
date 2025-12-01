Return-Path: <linux-pm+bounces-38955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B84E8C96854
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 10:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 300773410A9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE6230102D;
	Mon,  1 Dec 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Wl8N8BTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012047.outbound.protection.outlook.com [40.107.75.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E1A55;
	Mon,  1 Dec 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582418; cv=fail; b=n77zgHh0dbsVvlPZO/Y2r6Axff50HNxgn/hchcEoTMZZg5cE/68QKSSS7PcyBCjW2ETKt6LLbKGlhC+xMUzwBRooB85Jy8WljFVDf138ZvYL7rNxXTio2eOpZBxvWcCuLJLrINTjY9HLqjvgIqU3ufE2h2/TmjBhST4DlrELjSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582418; c=relaxed/simple;
	bh=fArevK4bT2LAsWao0KJfMvUIvNMfeDOsaow2+spHBiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+c8p+U9MiJyPs39oITUEkb3LIaXfquKaiQJ3UaZY1t4vi6lA+loCFiZRJWeEgAdbZWCIJDx7HOngAvX+tKrBTY7yapsk6ADSbsczj8IE+6EBVS7WNGT2CY4s47uvqxw4eoyNEGZt7rx6xMy4u0Wo9NrTS7JGiHG9z5dWH01Ev8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Wl8N8BTm; arc=fail smtp.client-ip=40.107.75.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ur/eJ7W5cGHdmXFWUOgwQGJ9NSGidPYV9tb1dU052WgydA8JaP0S61nbC2fpPAq/tkbMxtdn0LchyCqgYgf5u7OI6ht3tz+qn7KKHSq06zpFRK9fEizO4jpMBCCua1SO+UnJiU5o+7tVhFxZiFwR3cbSJGQyUB9MOiS5ytEEDcjjVFCa5pIwReK2vatcB9ryZgU4rrlAwTZQIXzsiMETwkaq7Qsuz8/iuG9GYs3TWYfsX9JZE52lewsdmkST+Q9ZHNLJ80fWm8fNgOF47xZt5GZSa/Ak1Df67ZbvFBXPwpblOyAYVd7AnePIXk3/JtarMt8NiLD0+rlVwbuwQCkqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF6pITUhtI0Xj9evQ49LumDIFMp2hY7FwktSx5toPco=;
 b=vJpllvif4MgxJl9UWiFm00UMVELS+eI4wxbiLg1EzV8kjs6+1aFaGSVrxODCTW2jldINzJG7yeKIguLQdRkbt7PjGJZQDcOyVIRsDFPGjuNBAy/I3SEoMiB7r16utZT69WEfTIX3zSEhhbOZhQxy4QvEORquczSvQZR+WbhWHYSQf0T51d0aI4NO+lUHCbC7ymBB76gZRbe26mSoU06RiN211MLoVY5ya0zw13/tUMqU9196AnVX046EeeE5nG7Jfu4JSBYMMD9K0KxKb9Xs4/DNk/06REoQBzQ/3s0m8Qf67dMc+yFEOBGpQ5RBMEboSHe/ozjq4WAVEHCyL1/67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF6pITUhtI0Xj9evQ49LumDIFMp2hY7FwktSx5toPco=;
 b=Wl8N8BTmqGB2eyZ4gUbyXNS//WipNufNsOrTxHDBEuuJ28VokmqJEpzoB34J8CKrnm7Q0PoYihcMNuSJacnDyZnScKX7fLcjpu+CU1pzlW1ieMvcxFEVkc43jbevwaATgYLwiwxSDlFqNDBeloFoQlBoDBobN8vKgnA92tF2qVQ2rp6sQxqOcUyJ6FOVwiHi06hpyuJ5mzOvQRJpYEU+FJfvMLisTMJtVpAJCY3G12fYZzYOtjrOu1t2hhP1mbJLk8d2gfN1noOhrk1qnBAyibY3Nxe2H0vgrrSSyVxDSKjgVsH0YeqI1Xe9yviOC5hemtglywsMvRbAXFJF2qgKBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEYPR06MB6082.apcprd06.prod.outlook.com (2603:1096:101:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Mon, 1 Dec
 2025 09:46:49 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::6f03:984f:82ec:6846%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:46:49 +0000
Message-ID: <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
Date: Mon, 1 Dec 2025 17:46:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <CAJZ5v0jiLAgHCQ51cYqUX-xjir7ooAC3xKH9wMbwrebOEuxFdw@mail.gmail.com>
 <CAJZ5v0hKpGbwFmxcH8qe=DPf_5GX=LD=Fqj3dgOApUoE1RmJAQ@mail.gmail.com>
 <4697314.LvFx2qVVIh@rafael.j.wysocki>
 <dc4dba4f-8334-40ea-8c53-6e8d135f1d41@acm.org>
 <CAJZ5v0jV-80kfk-AY70b5pQtyXxUtU_ACBVP_TeTAnaY0Up8Lw@mail.gmail.com>
 <1e7583e8-9ae9-4641-8ec2-7c62a637c9fc@acm.org>
 <CAJZ5v0hKe+2orwKP352dBe_PB1pZqMehMo8tSDv5G+cdaJ=OsQ@mail.gmail.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <CAJZ5v0hKe+2orwKP352dBe_PB1pZqMehMo8tSDv5G+cdaJ=OsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0174.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::15) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEYPR06MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d7154d-8376-4bbe-5a7d-08de30be8c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1A1RVErSUx0b1g2UE9yTXBBZnNVb3ZXd2tOaGFxUXdNTzJEOUROS1gyN3E2?=
 =?utf-8?B?dFgrRTdLdGNzWjFHK0JTdlFVT2l6ODVudmtqQ3VmdWVzUXZhVk42Qm82TTkz?=
 =?utf-8?B?bkMwRDNjMWRCVGpvOHZoQkd0NkViWjY3ZzdNZGwxZFhka08rZEdjZE80aGNs?=
 =?utf-8?B?QnRneWRRRGptWHpuUTNvdDJvZW9yeFFxUm0xSzZ2L2hFK3cvYTNwMHB0b0wv?=
 =?utf-8?B?Y0VaVTNjQjBQb3JKSUtSYlNLNmkvcXVyaDJVallSa1luNkJHN1ZqaXZiWW5L?=
 =?utf-8?B?WnpJbG93Zm5HdUxDZHFtVkoxQzRhUkN1Wm8wRkdFWnM1dzBQeklaM2RDK3Ir?=
 =?utf-8?B?S0g5bGJCTWtDVTF6MkJKTmU1OW5sT3RtMDNwUTdRaDFzNVlxUThtWkUzL2Y2?=
 =?utf-8?B?dHZBQ1g2cGZvOGtQYmVVRXFsQ2FaenBHaEN2S0Q2amJadCtWUCtNbXl5T292?=
 =?utf-8?B?TTFvbXlvWFBOS1U3RlFMRHZnZnIrVC91RXQ1WTgxV2FTbndxSnRvTlMyeGVB?=
 =?utf-8?B?ZytvQy95ZXpNdXZTOTdkd0dVVGRxcC81UmVmRnkzU0tVSXFoejIyN0JXSk9Z?=
 =?utf-8?B?SE1uT0JGV05qSVFoTEVwc1ZNWmI4WXdRL1ZrNlQ4MitwUlNiaUdOejNCdGl1?=
 =?utf-8?B?SzdYQzc2Q2w1QUxlaElEYXk3cTFXdXdLYTRoUCtmazd1S3pUb3JqZnhKLy9T?=
 =?utf-8?B?bEh5azAwQ3Z3SURLckN6bS9LZ3JJT0RRVUpocEVKbVRQVFRoSXVDaHE0WURU?=
 =?utf-8?B?Qit0Q3l5cHNSTDEzZnJtMkZSaVhybWtmL2dwOU85TEVDR3ppWFJoVCtrMzNI?=
 =?utf-8?B?ZVhwdFVTSk9ZcVBzTThGWldkTlc0cnJDRWMxSzduOHJCTTZBYkRmZkJuT2xq?=
 =?utf-8?B?UEFOeEh4WTdlbjlCQXRPTTBrTjBlZllrZWdORnQ0djZUMjc1WWppRnJieWpY?=
 =?utf-8?B?ZmV2dUNKZEdQYnNTeFhOWTJtSXhwL2QvMG9Qb3dncmh6bUV3d3BFQVdOQWQr?=
 =?utf-8?B?SlRoRmFzY2UwWFJ4aGVuV3M1Rk5WNllIa1hWdElReFNWVDhNNTNHenM2WExO?=
 =?utf-8?B?SDBHVjIxc1ZtZk1pMnIrMUpXb3I5MEF6aTkwbDQ2MktUbTI3dVdKNVdNSXFH?=
 =?utf-8?B?ZHZnb3E1bkoyUDVodzZEQnJ0SWhvMmh5VWJRZjdkemxiQngyNUluaXhRVDdo?=
 =?utf-8?B?NVBBU1BlN3VQWUNDTkN1SXJicVBLZnRURUlVYU41eW15VW90L2prbURzQjVv?=
 =?utf-8?B?dFFsUHFNV0pUMVExbUlNYllPNGpkQThaZVowY3dGdXFhVzB3d0tlSjZLNi9r?=
 =?utf-8?B?VkNKVFZZT0Z4dnJBeStRQ1lOUGFrWTFOZmlzK3U2YlFRS21mdmJhc1dHeE5y?=
 =?utf-8?B?SDEzd25jQ3dxcGRXSSs5VlR5UjNQek1qZUUvWGk2MDB5aWhQMytjNVUyNyt1?=
 =?utf-8?B?L3hubVQ5RWhUZjR0YnhmT08rcmdUWmM2UTF2MEFDTUU0YkxMVWxKN2dWaC9V?=
 =?utf-8?B?Ri9XczBwZWFNdVJtUWtTN29McmFBQjZaOWdlZ3FpbVEzSUNKdktLclhRTkFO?=
 =?utf-8?B?V2xBak1Rc1MvTlRINGRqYU03ZHZ1bkxSTHp2d28wdFBQK1ZDU0ZHMTB6aXh6?=
 =?utf-8?B?aVBuRlFjZmR0bzNsaFN2dk9uRW8vSEhCWjQ5a2hZaC9WbnArc1BvQUNvZ2lo?=
 =?utf-8?B?dlpQVk5Nb3V6WnhQWjMxRDUrVzVsdXNiT0MyRWtLdkxicEVIQmdWMzJ1VmVN?=
 =?utf-8?B?c2lkUFY1VnFDOVpWY1o3NU5OZW5UenMyMXo0NnRiN0VEcVZmT2pvVDJBeFRH?=
 =?utf-8?B?OVFOaU9lSFBPUHUyakNBYWREcDBMakJReWVGMjkrazVXNFdkWHJYcnd0Zldh?=
 =?utf-8?B?SGQyZ3k2QXZvQWZBTDlESDIvZlZPdjBpVFBmTjEyV243OW1YN3RzZHNpanNy?=
 =?utf-8?Q?dXqBr4Xujhhh35ntsKyq8+sEgyG/uII9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0NCSzE5UnhPN01GRS9PZ3h0VjNacjdjbGlxdC9KNFNmZlhNWVVPblJYelJT?=
 =?utf-8?B?L2czUi9Yb1N6ZGw5Ri9TYkpKaXIrV2dXZjhBSEtwTzArVndhaFVCaUlGdEZ4?=
 =?utf-8?B?UzBKakwxckpOd3IxRFpQRGs5cnBjeDc2SWpMdzRtQkowK0J6QUgxQ3Eyb1pv?=
 =?utf-8?B?ZWpMbTNDNktPSjcrOXl4MkF3OXJyaGxrSVRLSFZNWGhnc3ZXWjdyRk03eUhS?=
 =?utf-8?B?UTlnKzdmMld3QnJRMjE5QVBOSnkzaTFkbG1nSTh3L2lKbGtVNWNpSVg3VXBl?=
 =?utf-8?B?N1JCQURKRkVBd3lZZXM2MGhwcC9aTURzRjJWMWxQY05XVDl3RE9MR29acjNo?=
 =?utf-8?B?WmJVbjUzdHc5QnM3allMeTB3djlYdzdHejVkZkxUUnkyU1I5ZnR1QnFIelU5?=
 =?utf-8?B?YzE0SDhwWGpmZWNVQlBUSE5RR0FXSGtBWWgxaUdodkUwWHZJNXBuMXJsNkU3?=
 =?utf-8?B?Zm50dUM0bHFRUFBwOFIrTVRzeDJwakVadlJNdktScC9ZbFJvOHE1dWNubWpQ?=
 =?utf-8?B?am5IempQd2s0bm1OZEt0Q0orQjViek1mYXRWVzNJVnlQcVNHbGZWTmEvWGgr?=
 =?utf-8?B?dTNjVG05Zi9KSk0rY0ZCR0YwOVVLL1d6N1pwNWFWV2QwcVZ2SkVpbVpEZ3lq?=
 =?utf-8?B?UUZmcXFuMXYxZDJ1TndzSWhscVUxOUJNdWg2dk8xQmVaUTJDMGxCN05veFJ0?=
 =?utf-8?B?TWtvZnYrRTFnNGd5cUNwekhaalZOWjU2R3NRNXA5bU9TQjUvQm9WczRxOUNZ?=
 =?utf-8?B?KzFrSG9wNUoweWkrQzRmSjlvelBka0xYWlJaanoybUs4S05uc3lBUzl0YmVB?=
 =?utf-8?B?RFZMNi9UQ3Y3NGI2RCtrdkdQN1NoUkRtT3lnWnBLRC9tV3EyVzBFZGhLTzlt?=
 =?utf-8?B?ajZ2N04rWFZzb2ZxQTFveERXenpPZDdwb1NxYnc2bUpMMmJlRmRBblRKRCtP?=
 =?utf-8?B?M1NjbnM2MGpobGF6YU1VY0UxcFR4Q0FSanZERENNZjAvWExlR0RpdFc2eDJZ?=
 =?utf-8?B?a3Ntd0ZtbHlQcXo0R04yQzI2cXUrZG9EUTRTUUZ1a3hPSkRQMUhzbVFQOFMw?=
 =?utf-8?B?bVVEYmtxdy9HVzZ2T0xSRHYrc1hzNFk3bDBCYzVHL0wvQWRiSkp5MTFUbWdR?=
 =?utf-8?B?SWdSQUNybDErY2JQWHUvTEpZWjVVcEVBMG81c1BUdVpCb2tOK01PdzRHY2kx?=
 =?utf-8?B?NHVFbUN3Sy9PK2xScEkrRjBLTXo3MElwWnc0ZW1IdEZTNWVSOWFYUkpuNXBj?=
 =?utf-8?B?YjNqNlRIT2ExQ2IvWVZ5NTF6RzlPUk9sUDF2VG5zZEdwdThqMVpDTTBxeU1B?=
 =?utf-8?B?eVZweGhvNk4vVTdSbXlkbU9IU0Z2MC8wMlZTUW1VSC90YXhuNGlHRDhxbXc3?=
 =?utf-8?B?K0xxU3BOem11aUZhRytDa0o1OXc2WUtEdkQvaEdBU2RZL21JTnIvZmg5Slcz?=
 =?utf-8?B?bUxsVEhNeDVJY1p2TmhkQzN1K3ZzWXRuMzkvOXRST0xKcVBSem1NUTRLZ3dw?=
 =?utf-8?B?TTRQZVhJRDNxdzRqelBqOUNSMzdFOGZmbDVOdnRhOVBVWkNQNjZaRW9vT1JX?=
 =?utf-8?B?TElQdmNCRjlhSjFONndabVd0QmlPeXpBWjd3bGphcCtuZkFiZTRkZnVEQjhI?=
 =?utf-8?B?b2dYUWNXMFByT2lRQVhCZ1JQNG0rS3BtRVBzRitkVFZCTW04SVQwenZQMS9R?=
 =?utf-8?B?aWYzMW9MTFduKzU3ODdianVkM1oyRTJJWjYya2ZuazVId3BwMjluZXZCdzZY?=
 =?utf-8?B?NEpmUld2bU1sY1BJbis1NWRtZmtoa2k5NWdDKzk3N0ZpODA2cks4TXFoMFpS?=
 =?utf-8?B?dVlhNHFUK0RrL3kwZHRnT3JKMk9uVm9rVGluTVZ2TFJoeEZpWUtySnZEUlR5?=
 =?utf-8?B?VnlKNFBGQjhBZWU2T1RGNEd5N3ZTbzlYTjZiOGx2NStlSlVsN3hNWjNjOU9O?=
 =?utf-8?B?djBtK1dpRTJKMHZqVGdDbXQ0Q0ZnTVh1QWJidGZucmx3eEZqM1gyQkg2MGtL?=
 =?utf-8?B?UFlWTGtQcGV1NHZpMlo0SS9mdENsS3ZRcUZMTWlpdWt1eW4vMndEZG8vWDZt?=
 =?utf-8?B?RStlLzZvcU5wdXJxOG8yQ0gzVWZzNlRQSzRMU0tnaTB4TjFMWVBDcS9PQmlp?=
 =?utf-8?Q?sI4HKnz66j9oqpMB6jBNIykEp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d7154d-8376-4bbe-5a7d-08de30be8c79
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:46:49.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMnjtvO6o1hn8sDGo+rRmfEC6pC3NJ1HqqHwZ6wfel48mmCeGEvd0NcwuWhv6p8ejEpRCBbPQkh6Gd43YtQTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6082

On 2025/11/27 20:34, Rafael J. Wysocki wrote:
> On Wed, Nov 26, 2025 at 11:47 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 11/26/25 1:30 PM, Rafael J. Wysocki wrote:
>>> On Wed, Nov 26, 2025 at 10:11 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>>>
>>>> On 11/26/25 12:17 PM, Rafael J. Wysocki wrote:
>>>>> --- a/block/blk-core.c
>>>>> +++ b/block/blk-core.c
>>>>> @@ -309,6 +309,8 @@ int blk_queue_enter(struct request_queue
>>>>>                 if (flags & BLK_MQ_REQ_NOWAIT)
>>>>>                         return -EAGAIN;
>>>>>
>>>>> +             /* if necessary, resume .dev (assume success). */
>>>>> +             blk_pm_resume_queue(pm, q);
>>>>>                 /*
>>>>>                  * read pair of barrier in blk_freeze_queue_start(), we need to
>>>>>                  * order reading __PERCPU_REF_DEAD flag of .q_usage_counter and
>>>>
>>>> blk_queue_enter() may be called from the suspend path so I don't think
>>>> that the above change will work.
>>>
>>> Why would the existing code work then?
>>
>> The existing code works reliably on a very large number of devices.
> 
> Well, except that it doesn't work during system suspend and
> hibernation when the PM workqueue is frozen.  I think that we agree
> here.
> 
> This needs to be addressed because it may very well cause system
> suspend to deadlock.
> 
> There are two possible ways to address it I can think of:
> 
> 1. Changing blk_pm_resume_queue() and its users to carry out a
> synchronous resume of q->dev instead of calling pm_request_resume()
> and (effectively) waiting for the queued-up runtime resume of q->dev
> to take effect.
> 
> This would be my preferred option, but at this point I'm not sure if
> it's viable.
> 

After __pm_runtime_disable() is called from device_suspend_late(), 
dev->power.disable_depth is set, preventing rpm_resume() from making 
progress until the system resume completes, regardless of whether 
rpm_resume() is invoked synchronously or asynchronously.
Performing a synchronous resume of q->dev seems to have a similar 
effect to removing the following code block from 
__pm_runtime_barrier(), which is invoked by __pm_runtime_disable():

1428     if (dev->power.request_pending) {
1429         dev->power.request = RPM_REQ_NONE;
1430         spin_unlock_irq(&dev->power.lock);
1431
1432         cancel_work_sync(&dev->power.work);
1433
1434         spin_lock_irq(&dev->power.lock);
1435         dev->power.request_pending = false;
1436     }

> 2. Stop freezing the PM workqueue before system suspend/hibernation
> and adapt device_suspend_late() to that.
> 
> This should be doable, even though it is a bit risky because it may
> uncover some latent bugs (the freezing of the PM workqueue has been
> there forever), but it wouldn't address the problem entirely because
> device_suspend_late() would still need to disable runtime PM for the
> device (and for some devices it is disabled earlier), so
> pm_request_resume() would just start to fail at that point and if
> blk_queue_enter() were called after that point for a device supporting
> runtime PM, it might deadlock.
> 
>> Maybe there is a misunderstanding? RQF_PM / BLK_MQ_REQ_PM are set for
>> requests that should be processed even if the power status is changing
>> (RPM_SUSPENDING or RPM_RESUMING). The meaning of the 'pm' variable is
>> as follows: process this request even if a power state change is
>> ongoing.
> 
> I see.
> 
> The behavior depends on whether or not q->pm_only is set.  If it is
> not set, both blk_queue_enter() and __bio_queue_enter() will allow the
> request to be processed.
> 
> If q->pm_only is set, __bio_queue_enter() will wait until it gets
> cleared and in that case pm_request_resume(q->dev) is called to make
> that happen (did I get it right?).  This is a bit fragile because what
> if the async resume of q->dev fails for some reason?  You deadlock
> instead of failing the request.
> 
> Unlike __bio_queue_enter(), blk_queue_enter() additionally checks the
> runtime PM status of the queue if q->pm_only is set and it will allow
> the request to be processed in that case so long as q->rpm_status is
> not RPM_SUSPENDED.  However, if the queue status is RPM_SUSPENDED,
> pm_request_resume(q->dev) will be called like in the
> __bio_queue_enter() case.
> 
> I'm not sure why pm_request_resume(q->dev) needs to be called from
> within blk_pm_resume_queue().  Arguably, it should be sufficient to
> call it once before using the wait_event() macro, if the conditions
> checked by blk_pm_resume_queue() are not met.
> 
>>> Are you suggesting that q->rpm_status should still be checked before
>>> calling pm_runtime_resume() or do you mean something else?
>> The purpose of the code changes from a previous email is not entirely
>> clear to me so I'm not sure what the code should look like. But to
>> answer your question, calling blk_pm_resume_queue() if the runtime
>> status is RPM_SUSPENDED should be safe.
>>>> As an example, the UFS driver submits a
>>>> SCSI START STOP UNIT command from its runtime suspend callback. The call
>>>> chain is as follows:
>>>>
>>>>      ufshcd_wl_runtime_suspend()
>>>>        __ufshcd_wl_suspend()
>>>>          ufshcd_set_dev_pwr_mode()
>>>>            ufshcd_execute_start_stop()
>>>>              scsi_execute_cmd()
>>>>                scsi_alloc_request()
>>>>                  blk_queue_enter()
>>>>                blk_execute_rq()
>>>>                blk_mq_free_request()
>>>>                  blk_queue_exit()
>>>
>>> In any case, calling pm_request_resume() from blk_pm_resume_queue() in
>>> the !pm case is a mistake.
>>    Hmm ... we may disagree about this. Does what I wrote above make clear
>> why blk_pm_resume_queue() is called if pm == false?
> 
> Yes, it does, thanks!


