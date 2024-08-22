Return-Path: <linux-pm+bounces-12709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD695B20A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 11:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42872B26624
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3E18309B;
	Thu, 22 Aug 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VF5+pTbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD31183CAE;
	Thu, 22 Aug 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319648; cv=fail; b=OYgdxZ1PEhS1wzHdG8pm0O+R/4MrJUeSjTHejWgQ1B5zurNKDvZsmWqvatTgNpWOW2b0t34mkzQ4UJd0052XxpneJdSwN3S411KlCd3U5FZbPhoPdldozeEuN2CxOtzc0GHQgFE8C8cRKrHzZyXxZTJaPADenCwJFqWRjRjti5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319648; c=relaxed/simple;
	bh=poOHqFJnYUFOfwMitL/CyRXcmb0RlDsF6UBFj+Pi9iA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sxq7QfoayXoMWJQ+ZlTkP0nphKvNsIPb63FfZyGgxGJWtWOCASmpzxSsExnM+OelSkeY/NkZrhQGoEQ+TL4GxdVRGCNHyHKGTvs08t8VmjUlJV84qFJ+bcPKUzlEfPPaZvN9//zWdYRjg5oAn0I7qLIcNLrTMCNIWNzJOpG4tRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VF5+pTbx; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgpYfzytTrP3zPg2eIzCEPpv/NHalG9GtkZbzmfShqSk96ipnJEvCiRoecSGBfiAjMdbzHx1CiM4U46nDoA6jpbZnFwGtkGlIRgN7By16Z/aaYh6VfX8nCGBI55LgK5wgHi9mSaq5CLwQhXXogDA/FjRNi/g+c9rXqI+60rN1O5hr14OKtGdYomo2Pj6HyKQ6MoBGE3DPnYk3XMzeLyi9u8+ByovXjjTjTNmol/MxbisuN/zRhqhEdFBavgBqmo3k5VcoTvV+lYGPEejmNh6D3PcB8Z4uOM8ODCmIcBsLC2vIj1K2hcPUkZmGw1d6ld326Z7+IrtE8iGgzPX/c6y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TonWXyMsKM2usgPZiHxczldsCTxjKnRkLfhgtiCRT4=;
 b=zCoAfarhv9r1yv2rsu5l7OOUiTtvKbAlWeAZ6zL7JBkjAW0OSVaNfd4zP1HEaI5T7YrwknYI9oqfKxEbofE1wQwiSaLonbUukYMPJqH3z/PYKzNv3+PUEI9KbacJey894MuH0lfqu/ard0GqCe8eFisWFEb/63dhgQ70739YfgsFflBH80AN/AVDWjNnxi1Jm12PfuB04YMX6H6GElhbFPnMTLbXuyiYGkZj4h+SGtckqTAtAhjlPkBP3BCh4wKYCTKmkdpjAFeldLbsg19oK2j/gjFgn6KuwVCklolxfLqyGWQ3StO6VelTd8R7C4VjAs0+2zBHLCfkDItcGRiBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TonWXyMsKM2usgPZiHxczldsCTxjKnRkLfhgtiCRT4=;
 b=VF5+pTbxrVhpRXLRUESpBNagTs0M62AfsLzrcDbwMF4VapTd7zO2jGPDlSwDTdKrr6WPxzIEIT0mOPGsjoXZGTVgT1M4KKgWvSyqBMOxn9G2JvrJ5+BOMLxl/VtwPbKH1zEdM3ht52rqFDUodOtsphRDKK8AQ4S7NHZ2Z+7WUxjj37hN1WNBqjhDR/R5c7CZURDBJ45MRR3ek3LnypaZfRisSrCGqbJvZffovcQgunP1Nd6qoTEYZqx4AV/XlH/FEOxgNUw7/FlPJy9enXJe/fYNrry/VtXZ2RYoWocvPW/tmtg+iAEy7o+dAz1au+F4gAoudbkRgP/g5bVx+dG4IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYZPR06MB5122.apcprd06.prod.outlook.com (2603:1096:400:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 09:40:43 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:40:43 +0000
Message-ID: <2c55fb07-b29e-43e0-8697-f75d1f0df89a@vivo.com>
Date: Thu, 22 Aug 2024 17:40:41 +0800
User-Agent: Mozilla Thunderbird
Reply-To: 11162571@vivo.com
Subject: Re: [PATCH v1] drivers:cpufreq:Use max macro
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240822074548.1365390-1-11162571@vivo.com>
From: Yang Ruibin <11162571@vivo.com>
In-Reply-To: <20240822074548.1365390-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::28) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYZPR06MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: dc481521-0527-4c82-2125-08dcc28e7e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWlLQis5c2FZUGtrMDZBVkZwTlhlTk1XMkU5WC80ZXNpQ3VmTHk5LzlmaGEz?=
 =?utf-8?B?Vk5sbnVaU1VYcjJSNXpNN01JVFRhd0tjWnJpMnFpQW5RRUpXOGxkeVA2TEJU?=
 =?utf-8?B?dXZzd1pIV2FoQmhDek44TTVjYVUrNGRXUTZWZUM1SjRBMCtCYWdOeFNadWRT?=
 =?utf-8?B?Ty81UVJXUHVHY0dYK1BpUnIya3h2WGtUZ2hZenFRSmsxemJSVzE5bTFLa0FE?=
 =?utf-8?B?T2lYdWVaQWFzWmNCdUpJSWJXWklUWUQ0R2NNdmVVRnBXRVNJczdYOEhURFUy?=
 =?utf-8?B?cmo3a3Y4azFlR2t6T2R4TUpOcTFMV2FhOWVGRFRtRXRsdm5vLzVDZ2lRN21p?=
 =?utf-8?B?NWR6b0l3WER0R3NJS1MzTUMyUTlROHhPMGdRRkd3bEluZU1IOFgwQWFkTVJl?=
 =?utf-8?B?S1U3SHByQWRJYnhtd2U5QWZ6SDNKT0xHamNpVmhXZVRacHFRemwzZjRvQjBP?=
 =?utf-8?B?V211ZzFXSU1jNFFTTmxXTnlqWUh0T1pOS2pGd2Q2K2FPT1d5bEdIWVdjVkdo?=
 =?utf-8?B?Vko1RUt6K2hQMzEyd0R4RHhqSnpBRDlEUS9rcVdEY2I5aGJXcitaNEE3YjhP?=
 =?utf-8?B?YU1KVzdkeHZXT3REbWJqV3pPUU1QeXR5MktqMzNTVDdJd096aVIxam9TZVBq?=
 =?utf-8?B?VzBHQW1HbWMvNzg4UGMxQ202VEYybC8xVE1KTVpsbXNIUUdoYTlPd1FJb2pQ?=
 =?utf-8?B?YVFYSDVJTEZlTS9DRGlIUFAydHZQWnVhYVA3dXE1UEtmaVJtWFpqTjBJcUFU?=
 =?utf-8?B?RWZoRWRTa3FjSVlWS21qcUxVNitTL2M2RzdvOElzV0NYK05oYiswZUNaWXpp?=
 =?utf-8?B?MDh1N1VtWmV4TXBpMHp4OEVMOHQzVWw3M0NTTi9tZXJxUDlpRDhnaUMranVW?=
 =?utf-8?B?N1RqajlMdk8yejdDZWpUOEhvb1IwMUhYRUVNQStSd21JTGdIMmFsS2ljT1kx?=
 =?utf-8?B?dGw5ZmxvNjVmL3p4cTJ6Z3J4VjJ6a21LWkNIc1AzOE9IalZCd21HZkI3b2ZF?=
 =?utf-8?B?L3UxWHUxRjhnemY2RTA3L3pmQnNualRhQkdVd3V2Y0hVZEtSc25QNHlBSG1X?=
 =?utf-8?B?VGNlZWVIandaQkY5VDI5UHpIQzB2VHpUTlJmMDk0eDBRKy84ZHZaUEZpRVZw?=
 =?utf-8?B?WVhOQzBncnFIUnVNNk1uTzFYdUNWVGJ2U3JlNFNiVlRRbzRuRUxqZW5Pbmln?=
 =?utf-8?B?ZmxMWHY0MjBqSVh1SnJQbldrdEpuVERLVmdFNmMrNkJyc0E3aURZMGpWbXJH?=
 =?utf-8?B?ZVdjeXZEM1h3VGU3djVlM0FMb0Fab1hNN0kwTy9zYnN2Y0s3TXdUdDI0VnNi?=
 =?utf-8?B?c3Vkc1crajJHbndlek1CZzJPZnNOSW91U1BwK2dXRTNQK1ZmcGFhREE4U2Rw?=
 =?utf-8?B?bm84SFY2MURyNVlrR0FJSjJoTlQzRDNjUzdld2NlY0ZIaUlIcXUzR3hvaGlG?=
 =?utf-8?B?VjBOYlc1RWhPM01Lb0VqdkE3WTVkRlhHVUdqbDFMbzR4KzM4NjZQOTlwR1Jx?=
 =?utf-8?B?WVc1RSs0R3FNQ2xZUGIxeEc3RWw1V2Z1UzU4aXlHb0dKeGk1cFFQQ2QvTU1k?=
 =?utf-8?B?TmxvR3FxSWxFa2xTV2NUcnNuQmNpekQ1cmMzRlNPNU5JalJmd2E0bnhTUDl2?=
 =?utf-8?B?Y2ZiN2JlZWdNcms4eEZ3Uit1WmhZMkJxcnVBTHBmdWxRbVZJSmpYanMzYngv?=
 =?utf-8?B?NEp3OU1SK0tvUVdvdlFPYjhFV0FmMlRJZVdmUjZSdWJ2dklYYld6TkEwMUdC?=
 =?utf-8?B?ZzZoZGo3US9zTFdSTGdmT09LeU1jcXZXK1JPRy9PWnN0YjZMT05qYkdBeFFI?=
 =?utf-8?B?bmlKbUxIY1gvRmZTV2pOWTByUGxlOFRsVnQ3L0hQSFRsME55dDE2UTN3TG55?=
 =?utf-8?B?endLNDd0dzZYTXBTdjU1dUJmUWhtNGIvZjQwYnZqemxEZGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck5UUjVRQ2M0MEwwTzB2L1Z5TVV1REZHNGpQTk52ZWwwTzBqQy9FZ1RJZy9W?=
 =?utf-8?B?cFArcWN2SEduazRBL3VUeDFKZi9iTWw4WkowL09EeEhlVFpaWCs1SXdwQmIy?=
 =?utf-8?B?a1VOMCtNeHpFN0JkV0NyaFlMSmh3azZ1VW9oL2JGUFcxSmh1WjZNQ1B2RVo1?=
 =?utf-8?B?NDVvNTdpRXJPYU9nL3VBVTlHQSt6UnFlN0J1UkdsMXUycTc4dTlhdFNkV0J1?=
 =?utf-8?B?d3VkOXR4cjRkYTRqeVdoWkFoNjFrdTBqbThsMUU0SlVKeWwvOU1LaUtUZ0l5?=
 =?utf-8?B?OVgvL0RieEg0ZGhjcFptdEFwZytYSzJlYkF1V2NUeWQyWVUySnVCTk1NaGFv?=
 =?utf-8?B?enhFR25kWSs5YUU4YXM1SkdEdWoxU3N3alVRUXhDYkpCM2hXSnJJcUtkVTNj?=
 =?utf-8?B?aEFNZDhINFJheXRReFNkWHNSNkcrVVBCQkxmTHg1ZDRqMEVHTEhiRlFTS3Fp?=
 =?utf-8?B?TFBxM3Yya2dwSXY5dStjQ1BmY0x2ZWN5UlZRcGtrN3R4bWRHYzFJdEVFN3VN?=
 =?utf-8?B?aExSekFxL1VsdDhYT25NVUxKL1NOc1NQRFhqRFExYnp0aE5SejZNaWp1RmJR?=
 =?utf-8?B?OUJYTkg2RjdyUUdFQ0NsNDBzSTlYMkhEN0Q0RkxwcURVOHh0N2VWT0RBdXJ3?=
 =?utf-8?B?cEZRVFpNZnZ5dnArTHR2L3hhd2V2SENkcGh4a21HSldWQ3o1T1E4cS9YdHpa?=
 =?utf-8?B?RmdKam5GeUpNb2w0TjM2N0RYcFIrV1EzS2ROelVDY2FFZXhiTjU3bHN1VVJx?=
 =?utf-8?B?UXdTZ205U1VmTWo1dWNQR2EyWHBHSWlMbHNmc0RCV1lsWnpxSkpLWHNXVHlo?=
 =?utf-8?B?cDhaeGN2SDZVdG5taE5rdlY2bDZTUUtHZDhFdGUxZVI5alR1WmYyNG9mSzFJ?=
 =?utf-8?B?TGcwRHl4SnJuRlQ2OFBCZnJTWWFCT29iRkc4bjBsaVRVV2lFTE9zZy9kbDQv?=
 =?utf-8?B?N0ZNcklHZW1XOUtTanBucDBPWGJVQ0xqRGIzNHEwMEdjVTJBK2NxZEtHdHp6?=
 =?utf-8?B?UXBUWXNLcERGbktCNE5ZV05xZlc5aFhyTTU5MXA2UXFmWlJkazdBL3ZUMTU3?=
 =?utf-8?B?OEYwYzMrSENsYmNGc3JRc05QT1Nvb2V0eTdMRE5DclhPR0N2V0RFL1RBVEVJ?=
 =?utf-8?B?NFJGR3gzcjdKUmJBeWl3YVVPN0k0S0JOQTN6RUtjRDBPVkJ4aWFSTEhGclUv?=
 =?utf-8?B?czZOUW1kczZlNGNqVVZpbWVLOFRYR2p4WGJ3bHdEK0pOWHBsS1dYQzhxcTFy?=
 =?utf-8?B?U2gxYWlJMnhPMHJodEl1SFZlNmZKVExjempQdkdocU8wbTF0TEh3bGhZakQ2?=
 =?utf-8?B?LzVjSnJ0aUJwallWZ1MzMGd5ZHFuWnFyaGc1Q1MxVWpBUi94U2V5RTlUQ0tS?=
 =?utf-8?B?ZEhRMDc1TjdHQzRUV0piTUdxUkRnRUFNODRGc2cvcWdzTC85M080SWxDcXIw?=
 =?utf-8?B?dm5wQ2FuTlZUOGRnQTlOYlZHSmY2UDVXSzBoZkJHZWlLUzgyWmNwbS9adTd4?=
 =?utf-8?B?bjVQSnBSL1Z5MVlHemZ5dGlHN0JjaGpzbkdmdkkxN1ZiazVobjUwRjRhUUtJ?=
 =?utf-8?B?NkNzMmxtSk96VWJSZGpBUzZDaGdleWxwRXZGTXhnZjVnM1huLy9ITEY3VU5i?=
 =?utf-8?B?ZG4rNkx2SEhKV3NiTmtRNERzMDdoT1Rwb3JHclpUWWdWN2Z6YVpmcGtlb1do?=
 =?utf-8?B?K2U3a1hSNDhkaDF4SlhXZXM4R3JTV3lzaUVjY2x6OW1Xd3Z3ejlRYTlzaVlt?=
 =?utf-8?B?S0F4V3Z5V0FQbVpXYVVJNXBoM0xPMm1ueEdHRkx1RjV0M1pUVjhwS1ExdERn?=
 =?utf-8?B?eGY5Qmk3S2pFMW8vTnVERExpbDAwTzRxR3huOURRRmdkamVtMHBpLzNMZXdP?=
 =?utf-8?B?SkNWaTZVci9kVDZBaEowQjZycDduMUFxR1VtWG5sNWRxOHRYZ21XWGZQUEcr?=
 =?utf-8?B?NEZ4K1BaeFdXQ2NzK1dEWE5wUENYamttS2t5T2lJN2ZiRDdTcnpXb0E2NVBH?=
 =?utf-8?B?Wjlzbm40QWVUQkh2eW1ESmNEeEM1RmxKYkZUSktCTG9sT1RmVUlPTzZLUTdv?=
 =?utf-8?B?bDhubFZDUEVFcGUzanNLWlcyeVU5ZmtObDJrK3hod0llUUVNbkE1eTlFREFt?=
 =?utf-8?Q?zriH3lfk/1MoHqDzI2A+vtoRo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc481521-0527-4c82-2125-08dcc28e7e12
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:40:43.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx8ynRDUwQbjYZF+pgINA1o2CMARko9/vnMJzgZdEJ1rP30mX/DD2g9zs+rN6jNLgk+uyqmQJ0FU/qtjfwP1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5122

Sorry, please ignore this patch.
Because the corresponding header file is not included, there may be 
compilation errors.

在 2024/8/22 15:45, Yang Ruibin 写道:
> Instead of using the max() implementation of
> the ternary operator, use real macros.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>   drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index bea41ccab..f4aa3e84d 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -269,7 +269,7 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
>   	 */
>   
>   	target_vm = avs_map[l0_vdd_min] - 100;
> -	target_vm = target_vm > MIN_VOLT_MV ? target_vm : MIN_VOLT_MV;
> +	target_vm = max(target_vm, MIN_VOLT_MV);
>   	dvfs->avs[1] = armada_37xx_avs_val_match(target_vm);
>   
>   	/*

