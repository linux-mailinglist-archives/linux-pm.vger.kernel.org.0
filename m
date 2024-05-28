Return-Path: <linux-pm+bounces-8233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFA88D16C7
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 11:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20737B22E84
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557213C807;
	Tue, 28 May 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="hyBhgICZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463571722;
	Tue, 28 May 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886827; cv=fail; b=MfyBd2eBTjm9bbkPIOjg5QL9c2Hu2MlONsIDu5IEh2KsUkhE64sAHhJJdUMlyTWmZxNsP+Fsq9v+dZJaS7R1Xy/nhUbtYDwxvpHtBk8unPROtsrF6TYr1L0q49t8oAg9mpQMLreNbCmGvEr0A9SYnccwkW1Z7WWNs4CTzFr/mos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886827; c=relaxed/simple;
	bh=AzMz0zvHd18RMnAAkkzUMCpwpMtPT2fvkntZhM5L7es=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOFCJXhfKfGaCUcOvvI0SYOXRaje/q1lw31esirZpp2BgbYoUdpDJ4pCbpXnIqNtQ1oLiUWFMUU+Nibu73KQtoyy5+YptOWVZ+zfI7z43mVZlO8Pl85PUWnfSfmH33ISKt7kQraknaa6o47ap3nHLmdX9Mx8tBnAgH/03xPYKiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=hyBhgICZ; arc=fail smtp.client-ip=40.107.255.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8WXU1LmhWg5p7SnicfQZbJcXI/WF5GFt/ACjtOT1W5tMMdW8gacjDb6SBm6XvRFMIdwfN83jMqTPsDfOGzOEDu0hb5E6Uy9jZIAvmC2lWjjYj+WHrWNRrqlbIOs/VF4d7cjNCGkCRqr95v7UFu8Rkz45z3EukB+lmiEGUssCR5NlzPbK/tiejbl9mtwinq4/qzaLcKabdwfUvLF9c5/nmzMEvSz4wfDOnpOhLhf1XUKFEiaPKj9L3qp56HKCVCyAU78Mv7zxXsyBiUFvLOI8g+KtDZTcNbseYvtD/gMMw/+iuYf3um3L/cOAjif0zeUpgvJptovKYTtyZUNq5rt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz5ZTBFr/qQXbbhalF4s/r7kv6rEf2oMmdLi0gbUveg=;
 b=ImQ9H2MmByszFkRsFwWmOPUWFtpGJf5sShxD3a1Y68JQSlM3v0k4RIX0JUPdG+18ikY8kGRhNYhEM4UYhenPIiY5GNbnBse9q3YOVv+0Pn6Q3cuQs4BGHugJpZyrUd75/ciXY3/oreGyem7yovEgVOId2ursVsboRmtaJScLRXNoEYKDi19/NbH85nU2ozw7FdwDHs/2bp08IG3Xman+hp7kcotgVOutmIYCHawGNwYYjwfwKVUe38MRrSjdd1JLfgfamQ5bTdR9gxoVvWJ+CRJACu8bfM03V81Mgawxti6RFpe0Vb+fgGeskAc6a9WjJaddXH5g3NZN0TX8VYRocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz5ZTBFr/qQXbbhalF4s/r7kv6rEf2oMmdLi0gbUveg=;
 b=hyBhgICZUrDxpr9MKmG9Kb7AK6aF2ZJWTfd7pukuukLBsZvgT6gx/eutUk3WWUPtwPEFf89ZqAfdBfebRDuGfUHsH6/aXRkC/EQm0Nwf+MPZvNXQ4L2FyPEG9t8xwTsxIiRLpdgbB6ikfvmsmZgPvQi3IJo+fdSbMgXhRqrV7do1PrDLaPe2b19pS/95Zwf9OPOsBnTNbkfbtn7GVNUzH8SfDPz9JgTj+B8q9/ZVJ53cwORBdHWDNYk6ETJx+gZ/sOJ2vy/iBvsoUAMcuoEavG5uDS+1ppY17r0UTCyUPMss10r9evQTxKookl8lyDM7Dri/mj30iuBwVkwG4uOuEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB7290.apcprd03.prod.outlook.com (2603:1096:400:422::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Tue, 28 May
 2024 09:00:17 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%7]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 09:00:16 +0000
Message-ID: <70083d10-483e-4daf-a408-020f0147c5cf@amlogic.com>
Date: Tue, 28 May 2024 17:00:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: a4: add power domain controller
 node
Content-Language: en-US
To: neil.armstrong@linaro.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
 <20240528-a4_secpowerdomain-v1-3-2a9d7df9b128@amlogic.com>
 <c97b12bb-8b56-4129-a292-588226a0ec42@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <c97b12bb-8b56-4129-a292-588226a0ec42@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b584415-e1d9-46ea-6842-08dc7ef497ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ym4wYUMvOW81TGJmVm5VMzRuN1I5UFJZRDJrNFVrNUJQanJWa0xPUzQzSjhD?=
 =?utf-8?B?enMyUXY1MXF2UlZPczlCS29Qc0RkcDUveUw4bkRqY0NBRmxRcFNwbEZ6UWQw?=
 =?utf-8?B?MTM5aWJBNVN6RjJSNXMzMnVIdU50NE5oc0IwU0Y2NVNvM1pGNHYrQXM2VWww?=
 =?utf-8?B?QTcrRHR1bmgwUUVyYUVFeXdtcE1JK05GcGhtbDB3T2Y5anIxajM4UTNvd21J?=
 =?utf-8?B?a2JBdncxM1lHYStmMW45M2kyY3QrTGZJY1kzYXlVY2JyQURVRXJrS2grY2dp?=
 =?utf-8?B?S0NZUk5YbkxUMWRYaWp1SkZScmtKdFBPQVBlZk5zR3ZlR0lxbmE2aTkyNm5R?=
 =?utf-8?B?UVlKZzY1YzFLVlAxWDRFdFpsa1FVL0dWR0FNK0xzbVpHMnE2OW92R053LzFC?=
 =?utf-8?B?THZuK1A4Rm1NQlExUnFEWnNsR0hseFkxcDRzNWJMdUxhdzBWK2hsMXlxMkNi?=
 =?utf-8?B?dUxBL0hZRk9Qd1FWc2lCZjdEWEhUcW9jZmtkc1VwZnlGM2t3MDNSdFZCRy83?=
 =?utf-8?B?M1VJRTdUNDdnRnhDaUx1OHV5T1p3a2RNcnhxSjYwOFI5WkcySVdhdVEwMitG?=
 =?utf-8?B?OGhtZTd3amcxQUZBRWZkRk1aQ2hvZGc0Y0lOUGlCOWVGRkViY01uZC9ocDJy?=
 =?utf-8?B?ZWtHSGthQmZ5L2ZPT1JzMFloc1lFMGkrZTR3eTRyNy9xYkdmRjQraXE3bVky?=
 =?utf-8?B?eFFRUlhvVGoyWW9ncUFhYzNjUVRiRmFtRmdoMTEvLy90RVgxeG5qV1I5cnZP?=
 =?utf-8?B?cFU5dWhFN1ZDNHZ5R2NxOTIyTm4wNzUrYitjMEx5cThWOXUwbGZVd1FWN1dF?=
 =?utf-8?B?WnlLMnp5R0g3SHJqUEFOS3JlNnh3M0p2RjliK1VHWllFRzZjS1lOMWE5VGd2?=
 =?utf-8?B?cE9vUDZ1dE1pWUZpSU8rVk1DL29rcFZFMzlNdVJZMG1GVjkxSDZQV3ZLcjgr?=
 =?utf-8?B?eWxCY0FpcUw4SW9zcGhtOE9XbFVZcWVnWnVyeHNKY21IMWNzemt5bU9VWDJZ?=
 =?utf-8?B?MFdrT1Nyc1FEL25ieEE5Q2ZtYXBnN05ZSzd4a2p0b2puMWNKSWdVb2ppNzli?=
 =?utf-8?B?WW1KZjhkaStMQ2lQbEFDUTErYmd1RjVheUhKb3V5NVZNUTQ1dDd0VGRzNHlD?=
 =?utf-8?B?YVZDTi9JWG5FcEdHaFZEc05nVmlYVWoxUkc4SWNObDZNb0VGT3VEd0pNUlA4?=
 =?utf-8?B?QzFTc1ZNYW96OWEwN2pSK1NwUmJ4K1pMWUQ4MDdpb3h2QUkyRk9kTFNMQmFq?=
 =?utf-8?B?ck1tWGw2c21QZzNxQXdtMkl2VGswSlZwMDdWamwvb0M1RGhMWGdqdlRwbk5w?=
 =?utf-8?B?b2RQZUUyekVBRkNIUmtMNDV6S0d5MkRSSFFkM0J0S0NGa1pJNC9XZjhvdTd4?=
 =?utf-8?B?VWNTTkY2b25JbFZoNHlzc213Rmc3Q2IvbUZpTCtabnVybktSaW5QTXAxajRn?=
 =?utf-8?B?YVFQOFBHTy91Z0dLTE1XaFhvZzdueXpOTDFnbi90dFZNMkRyZDZ1Z2Z5UVVK?=
 =?utf-8?B?eWpFM0ZxV1ZGdFVMdlI2aGtmdCtXZE04a3pSYllFc2ZPaHh0cDVjM1Baa1Y5?=
 =?utf-8?B?ZVE5bEVzQmlTbTAzR1p2MXpiUnMzTUdVVE1ubU5EMnBiYkMrTFhEQmMxS1FU?=
 =?utf-8?B?VEhmbnQ0a2s5dHU5eE9Lc3R4RzhmaCtDN2VHVDVPOUo4NXp5b0RTZmdZWjdK?=
 =?utf-8?B?SHpmVjRjMG5QZ0ltbDZrZ3haL21MMDJzSTBsWXVOSmkyTkdta29hWXJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SURUMnEvMWNpRGV5TmVadllTQ0RheTNvTG0rcGdTUktoK0t2Rlc1aThXWVY1?=
 =?utf-8?B?RC9rYXBTMUsxMDhWMy9FdWpGQzFUeUE1cVJISlVDd1VXYW8wUlN6VEJUVkYw?=
 =?utf-8?B?VWwrUWRlT1Z4WFpTRUYzNjdKdXFIajlpL1E1UzI2K2dQYysyTE1aWk9kVzV0?=
 =?utf-8?B?dXR0bDExdWRqZFBpb3B0Y3YzQnpMT01rWG5YL3h5bjgxdlI4Ty8vUW1jcTMv?=
 =?utf-8?B?Y2VHNzFQQlk4OXB6alBOa1VzWEJYOXNpZkx0RDUzaGo5Y2Q0K3pnSG9UUmlu?=
 =?utf-8?B?WmxqVWh3VG1GdlVWYWdQN2oxVEJubUZCUEhITnJJajFUSjAzeWVKL2ZKTjhU?=
 =?utf-8?B?Z0FlTUhlY3Z0dU9JYUFTc0NvM2NoZ205bTV2VWZES2F0WkhRbmI0dnBRTlZX?=
 =?utf-8?B?VlhmRkR4bEVoeVpxNDhuUUpBSXBncTRISnl6WDlHLysxWk1zYlhrVjZFRk5O?=
 =?utf-8?B?WW5Jd1lYWHlGaXg4T0w1bDdKNHpPZ01Vb0EvL2tiNENYMEY2YVZVUUpVVEZJ?=
 =?utf-8?B?a0xSc1dFNE1PSHowOGhHd2VQeHpiNWgzUWZpT05YU0Q5OUYvYzJXcFZKSUxw?=
 =?utf-8?B?TzE0UnU3SG91Q1ozK2NSZEQrVE9Ka1BJYStwaTN0aU10dGx3bTN2c0drcktk?=
 =?utf-8?B?aE5mMVFnaEQzU205UmFITlIzNWh0dEVYQVBuQktTbHowbjI0SENRWGNWMVZV?=
 =?utf-8?B?RDBBNWYxWjJoc0dmVTU1aHdEK29hUW1XcXJ5akxhRldnY2tzUWVTaHFvb1Rq?=
 =?utf-8?B?OUlraW80TEhUUEtKSXBqNEZSTldMU2tUQWtrRFljcTlqN0tsT3BlOEpQOWJy?=
 =?utf-8?B?OWRWQ3l4STRCVzBiSElTWkZVMUlaZmFtWEZncnE1ck0wN3JuSWtramFPREh5?=
 =?utf-8?B?WHZEZ1dXZVJORnduWFlHOHdkZ1kvODhoa3psREx3Qk9tRDBZN3JNdlBRdGx3?=
 =?utf-8?B?RUdFS2RjRi8vZmV4SWNxTnlMTjlCck5EMDVKRm1RM0JWekJYYndiM3pSZlNW?=
 =?utf-8?B?UnlkSHVveHVEVWJzOWhkRG9HQ055bHppWEtzREREU01KNHFoemgydGpXakFX?=
 =?utf-8?B?bWJZREprOTdQd3lJYnBqMnFXOGZKWmlCdFhiT3NEUFl4Z3ZHNVloOXFLMVhz?=
 =?utf-8?B?T2R5dXpGN1BTYkxJREJFeXBFYlBrbElCdHArMktsNmg2aUlSOGl4QjQ5Z3l4?=
 =?utf-8?B?YTRDQUFrUjluTnlENUhnL3gyKzFJaktWQlMyV3Fxc0MxbGZPdE9iSUlaR2J6?=
 =?utf-8?B?aXNkT3NEUklzVldMMUVIcEJDRnl1YytrWEsvbEhvRDNIOENRU1ZWblN1Y1Jt?=
 =?utf-8?B?QnJzYjRaRnkrTTVmckVNOUJjNEZQbUNvNGs4M3BhNExKUW9zM01mUDVIK3pQ?=
 =?utf-8?B?dVBWb2lpajVFMlQzMWVjWXhtRFQwR2FtVWsxVlFjWmVKc2lXWkk2d2FSNTI5?=
 =?utf-8?B?RXZEWXJJTWpoTC9mZ1BnWTBaSEV3VEdHZXZlT1RRNjNad1dRT1Nsc0tTNFVM?=
 =?utf-8?B?TnlpSCtTQ1hSTnRnWG1SSXZlN0dDT0pTZ1Y0bVRVb0dKVzFjRm1zUkMvRElL?=
 =?utf-8?B?V2NpS2tBSHp3bzFaZkFZN0cwczg4bEpaR1VlbVJCNm94ZktiSnRjTHNxVUhZ?=
 =?utf-8?B?TzJsbmx1bUl0Nit6QXY3UFlrYi9vL3d6blFRRmUyYTVnUHgrV3RqSmdvMGRU?=
 =?utf-8?B?YWxVNW9BM3F2Z0hWOW5haTc0WDR0UGVLV0l2M2NsSHZqTFNEaDlvVTdaTWpv?=
 =?utf-8?B?cEI4WitlZzVBMmlOU1BCSzNncW41S3FRQVVCZzcwNEZseng5a3kxc2l1aGw1?=
 =?utf-8?B?QnQwUlpLMzZoclRrSnh5cVphOFhmV01uNXoycUk4Ukx6NnFHK2IzNTE5TEgx?=
 =?utf-8?B?UzMvNHQxaUwvQW05MnNpb0p2Z1BRZTNYTWd1bFZWdFV5bVYxZ2NpMzh4MjJo?=
 =?utf-8?B?VHQydllSS0lkN1dYbXpLeTk3V1dkcFM5eFJ0SS9zLyt6T0U5WG94a2VNMjR4?=
 =?utf-8?B?OUZIZzQ0RzFGMzUyNlRLS0NuZ3ZteisxUGorN3Qrdy9xS2FOaGhwTnNRR3Fw?=
 =?utf-8?B?N3hlb05hVEVDdkhxeXBzQ3dOdXZzK0s4c1pYOTFINnl4UHJ5VGpLa3E5Z3Jk?=
 =?utf-8?B?L09SMVF3bjhncGNUK3VRd3orSHc0cnE2L2tpM0Z3Ylc2OWY4dkVmZnNhbHN5?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b584415-e1d9-46ea-6842-08dc7ef497ec
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:00:16.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSlISDqZNwDticQWI35iLs0bIcJwFR5oQwR8CYg1CGKJjM4sQxerU8xl18kJaWkTfEhhpv2yxce012TMHKqpQi51wyDJgjOwFt6FrlAp0kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7290

Hi Neil,
    Thanks for your quickly reply.

On 2024/5/28 16:46, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> On 28/05/2024 10:39, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add power domain controller node for Amlogic A4 SoC
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 4 ++++
>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 5 +++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi 
>> b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>> index b6106ad4a072..eebde77ae5b4 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>> @@ -27,6 +27,10 @@ xtal: xtal-clk {
>>               #clock-cells = <0>;
>>       };
>>
>> +     sm: secure-monitor {
>> +             compatible = "amlogic,meson-gxbb-sm";
>> +     };
>> +
>>       soc {
>>               compatible = "simple-bus";
>>               #address-cells = <2>;
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi 
>> b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> index 73ca1d7eed81..917c05219b9c 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> @@ -37,4 +37,9 @@ cpu3: cpu@3 {
>>                       enable-method = "psci";
>>               };
>>       };
>> +
>> +     pwrc: power-controller {
>> +             compatible = "amlogic,a4-pwrc";
>> +             #power-domain-cells = <1>;
>> +     };
> 
> pwrc is supposed to be a child of secure-monitor.
> 
Considered writing it like this when I wrote this.

Here are two approaches: one is to include secure-monitor in the comm 
dtsi and fill power-controller by aliases in dtsi of each chip, while 
the other is to directly include secure-monitor in the dtsi of each 
chip. Which one do you suggest?

> Neil
> 
>>   };
>>
> 

