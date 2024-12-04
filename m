Return-Path: <linux-pm+bounces-18532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042BE9E3AF6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4664FB269F4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD611B85D2;
	Wed,  4 Dec 2024 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="Y1kg31DD"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2129.outbound.protection.outlook.com [40.107.21.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B34A33;
	Wed,  4 Dec 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318043; cv=fail; b=WujURh+ROjiUL/smlm6VcDdsmUlFFsoA9f6uKPPWdrlAuqLCOIFMA6XHmshpUDaKj16aON9gnD8xGt/JkTrenDbv9aQTYYtgDeQsTOBIDwZlnzxqSEV82HBbafnTjcWYmnZEmFIiKjtTSfy8WLd1KwfjTrjp/BmRK4b+be0uflc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318043; c=relaxed/simple;
	bh=ik/PQQbCxphYM2recGKD6ZLJeMJQ19hxMEzV0DHxljE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ERVXB+dNtiIOZO+UeXl/DCgd5YcWLPRe4mE7uBPEOTES4Qf8jUWbYLmMM/uvvxJpWDN3L30qbHcS9OSTagCXTmGpBlqSWMSDMj0tgJngUr2czuNGtWdvMgjIRxaFGOjxsVYZtgttNwR8LotdYp7K96NBOcis/l7TRAfdWw1pJy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=Y1kg31DD; arc=fail smtp.client-ip=40.107.21.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF8AXlF8wWPcojrub3Lf9VQA0OMZwoSrkFtcuZtrwPwTqKCj1KKs6+9vNW18fzXgbCgyQlW0rrjuyuc08pgUcK6gepfM24cnv4yZg8Wot9uWFSfUQKzDU/Z/wxja9K4RU7zIGSCPTaFMNgs4zJN6C0KtKeYyg90iTytobSlbsy3x+OJp59yVbVTXarAMi0E+eLqgbBdyY9Fg8CuHt/U7jU+WvX6VMDg65oE6oudzq8kn7folRl7YMVWY80D3EYve+MF8ZrPS/lmdXka+iYCmuF8FXHAw90wOaHbeGrx3fZyiAxjd29ZWBJxGKjsyNPK+3zIgbEoEB6OXuzoDb1R41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s43JPQW8r1ZcislmI8Oepcjwb9awcL/LBQ0mo5S//Wc=;
 b=a0aDU3yJCh2/9c7C2kGM9YKyrEM1BgC5CyAIb2jWolw9Yaji3sAs09yFcJC+tFeaOdQh/r3Djdzea7s+fWM7RMjI3w+gCRxWNOSQalys5u2HlFN57A4nzFx/p7WhE0V0VisiXHcvA/waHH9y+7z2l5KPqGtpcWpZ7VYHsIrps/PkV0zLW9vfBj0c0dvozlEUeo0OKdHMMIEmeXqfmmOzLDYBWarAGb6TIl8jCVyvxBMn+Zi5EgdvmmwEQyeB5QThtwlahBhSk/O75JJEW759tcFDiPw4UoKIrKmulQNQiPeM7W8eywTo3MA/ptSQfZtaYtOpor29ZTAASnR9IhiOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s43JPQW8r1ZcislmI8Oepcjwb9awcL/LBQ0mo5S//Wc=;
 b=Y1kg31DD/JNO6jK3xcL1YHAdIniNuplR4JXWEWbrzEG4siqbDheFU0zZmjd7EFSX3dD4Wrj5rydx3ZKNwi1hbuC5IH1pJ/3Kp2v80/wHYL748ZnjNqT6nZhnAzAA0D91HjO9XFsph8YnR+uSf/DowaUnsRR3J3G25AVBTTapmpOW3k0s8rGKP/7K1QJf+CpgxUrj29f/9pW3nKY5vS6eROEeSBA1F7AbqsIBNvIyV/C7kESMlPl7yZAOOkry+wmhiDB3QmUerkIoEkP3d5fQmwVUiC8+jBaBpgtCDrGp3ze17iKSBC8D/xJoKlujX2soea5xb912y+wTI5jsUTmDIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DBBPR03MB6828.eurprd03.prod.outlook.com (2603:10a6:10:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.22; Wed, 4 Dec
 2024 13:13:56 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 13:13:56 +0000
Message-ID: <5281f86d-6917-4f4e-b85d-70502a24c5bd@uclouvain.be>
Date: Wed, 4 Dec 2024 14:13:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
 <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
 <e23721ebd766f410103ddfb8705f3d7d6e5ae3e9.camel@linaro.org>
 <575b3275-b2fa-4e5c-bb6b-759394b02e18@uclouvain.be>
 <30b0995903fb7db3f866d1304783d878f563fe2f.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <30b0995903fb7db3f866d1304783d878f563fe2f.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0203.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::28) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DBBPR03MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a073370-8bdb-4079-be7f-08dd146581dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amF1U081TW50RExiaEtjcE9UbVVRWlhJSkFyWXJ5M0xScmYyNnVVL1paVmhJ?=
 =?utf-8?B?MlBzUmtQYkhUajlZNGRQdEtTaVVyMkV3UXlZajU5N0txMStiMXljSVdhRzRF?=
 =?utf-8?B?Vi9VaFFEbTJTYVpLV0tDcWx6WGQ3R1QyT1ZTTTZtcXVHTFhyZGlTT2hUcU9D?=
 =?utf-8?B?TTZ5d2ZEYThxdzc1TTBhaWpkc0xudzFXQitBa0p1TTBjUjdVR0ptaktEbUtt?=
 =?utf-8?B?c3NNQW4vWno0RW9jMXRENng1ODNlTzJIVmNDWkNqYk5RTEY4alhGVVJOMFlp?=
 =?utf-8?B?a1RrN1AzRkJDUnE3aUlmNUN5QTZWNWRFZlR5a2FHS2FHMElham96bmRGQ2xC?=
 =?utf-8?B?bi9UZ1BKbHdLN3lEa1EzcGd2SWVPcGUwWjd3K0xyMS80NGtaZlFuRFkrZ3BR?=
 =?utf-8?B?bzNTMTNoQXBYaG1XbVB6aHcvOGtZYURjYkNtMnhCQ2dWdmdLNlNPcVpJa0Zw?=
 =?utf-8?B?S2M0TkpsSDc1a21LL09aV0pPSXRYL1BHN0I1MGpvMjdtdGRRKzVuS2JhWms1?=
 =?utf-8?B?ZHJqdjVkazV6V0ZONW8vei9obmNrMkpyMzhUUkhNRnZrdEE0OERaamxyb3U0?=
 =?utf-8?B?VWtwMW96VlRFVnFPRFlEcFU5QVh5REI5TkxlRHpHekVWYlZsN3ozQ3Q4dkcr?=
 =?utf-8?B?Z2IxazBEa3VXWnZNYkJSRjVCRi9jV1VCTiswUjVxdjZXeXYwbEphd0NCOTAz?=
 =?utf-8?B?WE00Nk1UWDZlY2NTdTkrdUJuSkZTQ1U3NlRUNXk3NU1tUEhweVV2a0pTbDhm?=
 =?utf-8?B?elptTStYRU1FMTFVQ055REp5MHB3bU0vYjZRRkgyb0FrTUV4UXNIeldxUW5u?=
 =?utf-8?B?RVM1VGNQZGVZTmtUNWJ2YmtTSUE2Y0MwRlBnTWlqUThjVE83UGxYaENqamda?=
 =?utf-8?B?cXc4L3YrbnJwMUlCUHdYNDRLRWc2NktQN2xpZ21SaDZ3YlZXcjhLb09vRTFN?=
 =?utf-8?B?TytlQnVyYXYzQ2lCMzk3RmN3dTVVRTIxdExJai9lWGd0U29zS1VsdG1jWFZk?=
 =?utf-8?B?blNXN1NvakkwTkMyb283SVdMSGQ5Yi80R0lJWmhwVVpXeDBaQ3RKcU5SVWhP?=
 =?utf-8?B?d0FEK3g4L2N5UUE0dHpyQUlZSmYramJOdUJwR25QTmZYWWFoQzhEU2lvSDRQ?=
 =?utf-8?B?bTR0eUw3dktuelh0SHdmclZGRjFkbzNXRk0wbE9uMFFOb3RUcC84Rkw3Z0FF?=
 =?utf-8?B?M3lZdmIyMnkrczUrMmxtMHg2ZVFQenZnc3FJRGFGWGY0WUMvaGU4NHhLRW12?=
 =?utf-8?B?WE8yNlFJTzR0OG1Qdk9wZXNzcXRnQXlyVkFQbjlNb1dQT0JhZFUzWWpnYlh6?=
 =?utf-8?B?d290UHBBK2F3cytZbGJyYjFKdXJlK3VPeXpnY21zQ1oySTdIYUhFRnlXWWhx?=
 =?utf-8?B?UWJ4TzVScXEwV2JBdHJlQ2UyWE4vUzlucldBczdDaU42cFdHSWFYREF2NDMw?=
 =?utf-8?B?ZFlPRDRVcis2ZHBzODZpN3dwM1J4Z0J1b2JmeVFGemZKcFpmeW1OWDRsZit5?=
 =?utf-8?B?VElINUtuLzlmOFhocEF6Qm95Z0E5SlNGT0htTjNadTUrRk1mVE5oMjI5UUFX?=
 =?utf-8?B?M2QrOU9mRXc0d2krcDNRTEEvb3oxWDNCeFZnT3hlRFdqQlpOT2ltZnNaT2Nv?=
 =?utf-8?B?QzFLLzhaREpSUHF1c0tIelppWVpDeGt2dWpuZ0xsV05hWGlmdzhXWFFoR1NE?=
 =?utf-8?B?L1BOMGlzTG1DYmxKeXFZN3B3WkFjRlJkc1BxS0Q3QlY2YXoydGh3YlBGZzQ4?=
 =?utf-8?B?WW5HK1R0SkM4ZGdxYWF0R0FqZE1admpYNEs5WmFrbzgvbVgxMnU0WkhFNVc4?=
 =?utf-8?B?S2s0QVBLTC9VSUtrTWV6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzFWaDVoa281dzlOTXdzWVltUUk3TkJObGFYRHB5ZWh5cUZBLy9JeVR4aWM4?=
 =?utf-8?B?cE01Q1AwQ043STRydDZmRnVheHNpZ0w3OTdQWUNVZGxuRHFKM1dtRHY1MEFZ?=
 =?utf-8?B?MG8rL0ZrZG1WQ0IxMFBFTDUyeUlzT205NEtxT2tJTTBZUXZOTGgxN3hCTkNv?=
 =?utf-8?B?eTNRRGticENxSlVvdTUzcThxMjNyRWRJTC9jSVI0WkQ4K0dLZk90Y2NZSzNR?=
 =?utf-8?B?STFSbENCRmgyaUVlYjUwTUVvTFFWczh1V2FPeituTmdjdWlLSjhVR2VSQUg4?=
 =?utf-8?B?em96NUpnaUFNUHBQbW9FdzZTT0g2LzlzYkRKNkhUU0RUOTBydW81S281Y3BL?=
 =?utf-8?B?ZGEyb3Zkd2JGMTRNQ28za1loc3l0U25rM1NiUGlYbGNtY2pxaUpKY0M0b0o2?=
 =?utf-8?B?WmNzM2hjNmtJT3U2bkt5dXpxTVhiUFNuU1ltZCtib3paRS9IN1g5aGEveC9p?=
 =?utf-8?B?aGFyQmhmYUVZYkRWbHQvM2QwazZiT1AzcERNTjkwdlVKZlZ0b1RpQWhoU25U?=
 =?utf-8?B?TlhCcjhxMTVVWXZhNTFQSG5ndlRqK21vODJNSnRTaHJGbkpmUUNxS1Q3cEJI?=
 =?utf-8?B?TDFVU1h3Q1FuZGtDL0tlWW82YURIbVEvak1KdkpQVllXcmNBaXJXSXdjWDJY?=
 =?utf-8?B?RzJZQmVZYzQzNHljc2VPdHN4M3dwb1hnRU8reXM5RVVaeWRnbkNLYWd1blVH?=
 =?utf-8?B?YXJtTHRkVSs3REcvQUJBUzZ1ZE52TVpRMzROdnRvTHZ0ejdwR3NGV3gwazB1?=
 =?utf-8?B?dEZJMkw3bStzUlZpNytHam5GNTlyclNRN2FUWml4YWxMTGdhUUFkOUl0MXBE?=
 =?utf-8?B?d3BZRHRPdThKQnMzclJIOUpYMUtodDhNOTUwb2ZHSHdUcU5kSFBVcVBnWnA2?=
 =?utf-8?B?aFRacEtObURNYm5FVlhhUlN4R2lsYVBSRzhid3NOODR1dGdDWVhXM3grUW9O?=
 =?utf-8?B?OGpUYW9pWEw1M3VkK0pwOTFxNDRacGpoZU1xVG9qNHBMYVd1akFjY2JWSzNv?=
 =?utf-8?B?WndVRGtLS2tjZDRJVkIxZExGcnFQcGRMb2xqdkF4WTlVVFlWcWdwc2tOS0o5?=
 =?utf-8?B?R1EzeVlvTE8zTW5JZVFHekJIVS9Md2dDZVJUNDFJVnRFQ2dEc0lrYUxZOTBj?=
 =?utf-8?B?L0xFOGd5R2FpRTdnQzRYN3RSTE9TeGxWYWVBK2h1eGpaVUxIcGhQR1Rob3ls?=
 =?utf-8?B?MCtic1RucGJoUTRubzA4bEdOeTNmNVpocTNob3g1Y05MU0Fxc2tsblAzMXM4?=
 =?utf-8?B?VGpqZ0k4SlFhYjY4Nzhvb1o4SThyakQrZHo4V0xrVllHU1hlU0hXN253MXpV?=
 =?utf-8?B?dU5xRzV5UlJadGE2emt3T1lSUURmWmE5R2RiZXJQRlZ2WXgvSDFqYmV0YkRZ?=
 =?utf-8?B?eTR2a1BoMzlYSkxUdHI0d05qUFVkTi93ZGlRNDVkbzJWay8xM2ZlSmxDd3pM?=
 =?utf-8?B?ZjIrVUd6RklmaU1iT08zbWZkcnNjQjhFTjFpaEw3azRRZFFObTYrQ21hTDVr?=
 =?utf-8?B?NEkzbitqWSthZ21ySU91SkNQU01VMDZOekcyZk1qdlJSNEV5cjZaU09KWWlL?=
 =?utf-8?B?WVhOSWl0aVdreEZrSlJqMHVhTnkwSkRselQ1eWZlUS9jSDN4MTRubTZyWGp2?=
 =?utf-8?B?MXBFa0hDS0ZFZzBDckNnWVpQREZZSW0zanhlR2FLREQvTjE1THo2RlhDZTRs?=
 =?utf-8?B?eldRdVY0clZQRlhZYy9QM1NqZVk4ZXk1TGw0ZzBMSFNLbERYSmV1MTdRdTJ4?=
 =?utf-8?B?ZjdBOVlibnZEN20xQXNvQlUyWlFuN0lPcWdtMnpSb05nVDJCSnRRWVMwZG9z?=
 =?utf-8?B?OXFhTnZEbjhQVUs4aXJBekVZN0VqMS9iMjVIa3ZkTVljdGdVMEk2VGQvcHhq?=
 =?utf-8?B?N1lId3VrcXZxM2RxeXN0TDVCQjVsb1RoSWs2U3BMdmE2VnptbmQ3eTI3a1FL?=
 =?utf-8?B?RzV4THRRbldrL3E4KzVqaUVtaFBYUzM5RTdKdVB0U1E2bWlvamx4WUFOTnlC?=
 =?utf-8?B?VTRnVjV5Y3I4MjZsL3kvOWJvVlZ0U2srenoyZEVzR2dmeGJrTmVIL2YzZ1Mw?=
 =?utf-8?B?L2lsRnAzVTh4bE9vQWtmVFI1OGt5YUd1R05oMXQ4dGtJQkdDejFXY3NCRmd5?=
 =?utf-8?B?TlExQTJCUDJsZG9hTjV0aFFRaUI2dlE1cmdIV3hMY0xpZ1dDay9hYnY3d2FE?=
 =?utf-8?Q?HgzdkLotiWEed+qoIdwidPJYjOMrWPgYvnJEj2M8bmTz?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a073370-8bdb-4079-be7f-08dd146581dc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 13:13:56.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qr8/Val2vY5Kb5wxnYcNkTh8ymKTW7qtlFubcfYVL6WY1eefU2WE3al6k7N4i1xBLP+016AoAsY1kUmjei8YPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6828

On 12/3/24 11:40, André Draszik wrote:
> On Tue, 2024-12-03 at 11:23 +0100, Thomas Antoine wrote:
>> On 12/3/24 08:12, André Draszik wrote:
>>> On Mon, 2024-12-02 at 14:07 +0100, Thomas Antoine via B4 Relay wrote:
>>>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>>>
>>>> As the Maxim max77759 fuel gauge has no non-volatile memory slave address,
>>>> make it non-obligatory. Except for this, the max77759 seems to behave the
>>>> same as the max1720x.
>>>
>>> What about the battery characterization tables? Aren't they needed for
>>> correct reporting?
>>
>> I checked some other patches which added fuel gauge and other bindings and I
>> couldn't find such characterization table. Can you point me to an example or
>> explain what it should contain if there needs one?
> 
> I haven't looked in detail, but there is
> 
> 
> https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-oriole-battery.dtsi#13
> https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-raven-battery.dtsi#13
> 
> which include
> https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-oriole-battery-data.dtsi
> https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-raven-battery-data.dtsi
> respectively
> 
> Both overlay
> https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android-gs-raviole-mainline/arch/arm64/boot/dts/google/gs101-raviole-battery.dtsi#177

I looked into it. The probe function launches a delay work
max1720x_model_work which will try multiple times to run
max1720x_model_load which leads to
max_m5_load_gauge_model -> max_m5_update_custom_model

This last function writes 0x0059 to 0x62 and 0x00c4 to 0x63 which unlocks
the addresses from 0x80 to 0xaf. Those actually contain the model but are
usually locked, returning only 0xff. It then writes the model and locks
back the register.

I tried it and I was indeed able to access this data on my device. The
registers contained a model very close to the default-a1-0k fg-model
contained in the downstream devicetree. The only diffrence is that all the
0x0100 are replaced with 0x0080.

I think those registers are similar to the registers 180h to 1AFh of the
max1720x ("ModelGauge m5 Algorithm Model registers" in the datasheet).

The fg-params is used to set individual registers like CGAIN or CONFIG2 but
from what I see, those are also on the max1720x.

If it is indeed the case and that all of those are equivalent to their
max1720x counterpart, I think the management of those values should be
added in another patch which implements it for both the max1720x (and possibly the
max77759) as the mainline driver does not do anything with those values
currently.

Best,
Thomas

