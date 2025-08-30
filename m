Return-Path: <linux-pm+bounces-33458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DBBB3C8C1
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 09:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837AA3BA9DC
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6A227B8E;
	Sat, 30 Aug 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QiBrV8eW"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012020.outbound.protection.outlook.com [40.107.75.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810016F0FE;
	Sat, 30 Aug 2025 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539155; cv=fail; b=ajmtj23P09RnGcGeqegI7equMA/Uv+eZBdWH5Ps0SiEJDYpKhczqMGHC12J/n87bbiHx/SwEQq1W+0mgzg6aEBctnGCxVMOEORcy1f3x+ImFOVVTmm4rgU0B3mIHA6NyzcHg4RZExev2cP4AD0WqpWCHrnPCY4ohkhSCAfjtZ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539155; c=relaxed/simple;
	bh=fOKz3EBgZHiGc66z7hVXNP/3e4OeqHCmNhrI7Xs1gNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BC6ZhHCsrse/G5rjoh8Jb47F7ZG5izvVFIheXf1jZYSQpBBc2T0IxE3OMPp47FAvt+sCzf/3hH5sv/+ESC6rJj51Q45hNqfHTn8g4yIm0fjt26Yu2b8lbjWYbvnE9Idrb/QpDMr0X2q7LuNhB7fQ1NxZw+MV1NntiiogXDxQjCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QiBrV8eW; arc=fail smtp.client-ip=40.107.75.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsusXWiT/MRSZ/jzyCyF0xlIdbiiMKlNy0bJa+StXJftf2ZWiFN1WU0fLAGzpSTLBb1HPVoSjyBvDbD3kB8dIYKeVl00FTwtDIv2mwrZduSVBak+6WA25aTWQsaWFBolb1g59xLWkZQYT56miqwB4wvEVUtuKribQ/W0svGKbPjAKGbkOnrjXaO+arQ2yC2kB6VUHIDbLlnY2ynN5kUqZXh0Ikyw6UyN3ZwizJXtUY8FB6CNbHyMhsSTIdZOAdGJQNv4EQ96nJvrZuBAvW/tGquUxF/vSptQFbCaTQZeMh4sXiemVYgEpvOGQAbu4CFzb8Sgv7n65wgTlimvv52y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOKz3EBgZHiGc66z7hVXNP/3e4OeqHCmNhrI7Xs1gNA=;
 b=j2pjV1w7Y/OZdwwEl1e1WqB0r0BUBPDrVCxM/Yk3Pt79ivu1lke8AKYLS+U1vue/2XX/6ifF5N6uJahK2BlCsfmLJ0dnQ6Wm4OSEK3iE4NWJtK9yYSPhs5+2KmBS7uIVAJrUcSBFvA1HFBocs/KGvk7RxQ0r+22Jh72chyceb0R4WKv3dHAGNuupKs15bu6cftj4GuGhh55toD/tETxkoEC2OtlzK743HjXucHLo97XBO11K6lwKGTeykKDlosoyEOBv3F+r4rSAtMcPW+1Jum7vWjQou18xLhrMaqaOCzrmYTHqYS7iLNX+QWveUsSYLV7pJZDg8+cDZkIu/4032w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOKz3EBgZHiGc66z7hVXNP/3e4OeqHCmNhrI7Xs1gNA=;
 b=QiBrV8eWHGFbtkw4eTRkvIrhRlIy/z3CDlgeqNweS5bowKmkiHRRKTcMHbvNvkFwm0rCeyisoR0kfZ5BwqUWEyjw8H+Kcptx5SmSb4Rt2ygY3WvKcQ0H6RPy8smEt6oJP6DBUVTQvXpx4QUXG+IVkw6+kx1Em8BCG6D402kB7cKadh9JCIddQJ/hjdIboJC2NBpmsVVW5BZVZvGeWV9TrkQJCmCC2m0uw6394lxVE0fgaJgSovSqbTheKv2UnK9YNEMfp9CRi8IbEZhR+xWBpFZdSBvHhu1FLHUyM56uNipAabBrdyypnsmE7sP51Remapi/i0/vwy2DzOq/R0flQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB5166.apcprd06.prod.outlook.com (2603:1096:101:40::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.17; Sat, 30 Aug 2025 07:32:27 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 07:32:27 +0000
Message-ID: <d63b38bb-47d4-4f85-b83c-098bab83f8d2@vivo.com>
Date: Sat, 30 Aug 2025 15:32:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Use int type to store negative error codes
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829084440.579727-1-rongqianfeng@vivo.com>
 <CAJZ5v0jZ+4Ze2t8pw1MPUqzFYFr7g7h6Y-f=gwsmUgbvSThYGg@mail.gmail.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <CAJZ5v0jZ+4Ze2t8pw1MPUqzFYFr7g7h6Y-f=gwsmUgbvSThYGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ba7595-46fa-45fe-6058-08dde7975e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0lSMldydTh6VXM5UjJWS00zL2pXd0VuTU1vQ1U2TWphTGRpdHExNXNkdWxa?=
 =?utf-8?B?MmVaekIrdFVyUlFwM0VnSVJaZTlJOTA5RUNGRWowUkV3eUNKcVpBcEpmQ2Mv?=
 =?utf-8?B?dE1aR0JPTW5oTWFqWVlXQnlKNzhxMTFxMjhRRHlYdXBJOFVLNlM4Vms4akpZ?=
 =?utf-8?B?bndVZ1J2akZ3ajVNYUNxM3ptelZtK1VkS2pMUkZ0cjRsMVk2MC82dEExdUhP?=
 =?utf-8?B?SjVSZ1J4bGsxVzdOYS9oNVNPZ3k3UEJ6TVJaMHBkL05kdlRIaUFpdXlYMnl6?=
 =?utf-8?B?Z0Y2WUJuRlp6N1c4OEdGZnQzUXJBaUhqbVJpN3ZwcnhjdXk4MkpVVy9OcmJR?=
 =?utf-8?B?cUpkZnNtcnVuMk5lM0ZaNjNqM2R2Q25UQXBlL3M0MFdEbUpZaVY5SGJ5U2Fj?=
 =?utf-8?B?cXpXZmN5ZVhPTzJrZC9SeGhmWlhIYkhFc3czYVV2aGNOM3QydVJNUUMzZ3Uy?=
 =?utf-8?B?Q2ZkMDAweHJCb0pERUZ3QThENklaak5HUjliMStKMi91OFNkQldPZGFRUHVM?=
 =?utf-8?B?R1NMNC9PN2hBSi95RmNTUkprM1haa0pYaEc1cUIzRlJQaGpscmcvVmJUakdB?=
 =?utf-8?B?WmppNWpJcUdGSGZldC9hMkVCY1A3UWlEQjZvZTFOSFhQMWYwdDJEQ2ZsN3Q4?=
 =?utf-8?B?NHlKR0JnNHhBL3ArYW9JRG9wSUtGRUd5dEM4OEtwT1Y4YmV5L1N5dWNNS3Iz?=
 =?utf-8?B?RFpNVWNOSGZhczJteVUwVEpNYU5NWlgxVUd2b0ljTWlPUU9ZZXhJZE5ud2s2?=
 =?utf-8?B?VEhBMEIxdlkzclZlU3p2a3Q1d3BjblRmTDM2dDJRMm1ZSmMrMDZMaTVXZUox?=
 =?utf-8?B?eUV6aXlYcHVsLzBjOHpOWndyeFNON2cyS2FnU0NPcy8xS3lLWTBUOUpJUG5t?=
 =?utf-8?B?dUQxQitObDJvbXRRRkRYWWEvVG5HN29ZNGE3cHJNaGc5YWhxVFcvTGw2eXpt?=
 =?utf-8?B?djVjaTR0cGRraSsyekIvb2NYbWQ5Y0x0WnJYZXVndDVnZVZvWDZYTlhqbFAy?=
 =?utf-8?B?ZFdqbVRTc3hrdTNPTWRIdnhyY1d5VWFNUmZoTzdjb0xkaTNXZmNjQTZUUVRT?=
 =?utf-8?B?SlhKSGpDQTBoZE1SeGpoTDgyWnpIL1JON1hCbGhMRFdaY2xGRU5sdlFadGFU?=
 =?utf-8?B?YTNFSjBvQndDak5FKzg0YkxzWGJnU2hyeFlFMW10eDZLZU9IRkZENmtZai8y?=
 =?utf-8?B?ZlY2OTZRQllhTlBRbTR0c05wWkErcDVaS1RmZ1dPVDNDSmg1NkJkeXF2aStp?=
 =?utf-8?B?K0doNHFQdGpFWnF4REhJTnFWZkExYUVEOEsyS0xUeHlXK3lLd0M0bjR4Mnpn?=
 =?utf-8?B?OGpkV3p0YTk0bzVxQU1jbkM2emRqR2lYdEIxcCs0Z3lla3VSanRlNUU0djQv?=
 =?utf-8?B?eURZYVI1b1hMQ3R5ek1JZnVyMW9xYWxKY3NmRjBDSlMxMW1ZOHNIbDJuQnd3?=
 =?utf-8?B?bFIzTy9MYTcwdEZHUnU5aG0rMUVMVTZuNWMvVFVCNUF5eXBOeHl3eDV4UDE0?=
 =?utf-8?B?YXZaL2U5V3lyUFNGb083TnZXSW5INjRPUExOQjhRSDgwMnMrN05EWiswZXJT?=
 =?utf-8?B?K3NwN3BnRXZxN0JQb1V4dGt0WSt0R1VyNmVkNEQrVFBmR3owcVVWNzRsL1d2?=
 =?utf-8?B?TElNbHZLeDNsQU16RXM1elppSit3RGRCZUtML09oSlRrSStVRnIvVU1KNEZS?=
 =?utf-8?B?emtGbHN6cGdFOG9SNlJNQWpDUDZhVjUwei9SVlNrTnZmTmN6SWpRNFpqSnl5?=
 =?utf-8?B?YlV2WFp2OCswZzNJY2JzckxFdERHczRhKzBCdVJkVHIyYWc3QzhMTEJBTkd0?=
 =?utf-8?B?Z3J5cEZTNkhyZHhGeXBWODRiM0NoVE1BSGNPcmV0T1UxTFN0SkxCZ2dGWkFE?=
 =?utf-8?B?ckJxcWdmTHRRbE9JakJ3cm9TUFJ6c0ZWUmVxTGdWd3hRTHRpZ0tZVFFyd3M3?=
 =?utf-8?Q?y80cx7BiHTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnhCNkJQRzA0WkdXa2ptV2xHTC9KZXEzMzd0VDlMaHpsVmsyckRCdUY3WXVC?=
 =?utf-8?B?cUxYUW5WRFlCTml5K25Ec1kyK1A3dURuZWlHM1B2UGY5VXhjaGpTQmdQQStn?=
 =?utf-8?B?ZXZCM2E4OGVVK3MxTncrNXU3UU1mc09pMW0vbi9BbHplZSsvNy9HcEVKckdl?=
 =?utf-8?B?elQ3UXhJODN2VTQxYlp6NGUzdTNhaVphM1lLckJMemViRDlnakp0SG1OR3Fy?=
 =?utf-8?B?SGRkTEtnV1o3UUVSc1c3ejJLcnBVVkY4aHR2ZHpwSlVJUmdzVUVXaU4xYUMr?=
 =?utf-8?B?WjVjT3IwOEVkcEIrUkYxOWtWdUNsQlFuTytpakJRTm1ndFlMMDJYaTZyWWEz?=
 =?utf-8?B?QVduYmtOS2NiTkRRUVBXeitwOVNXQUpoMEVrVkRYdVVhVzdmejV1OHh6dDc5?=
 =?utf-8?B?cXozN0lOb25oa1dnRXNPMFUwMzNxOEJabWIzSUdqNEVzdnE4aHd1dW1JYjB3?=
 =?utf-8?B?T2QzdTEvS1RoL1Job1l5aDJKUWJvQkc3QzM4NDVTL2UzdDFsTW9hdVdzbE1v?=
 =?utf-8?B?dC9LUWZBWmZWNkVwaXdrZE1KSWtOc3N3R015d3RianRiQ2trYjVCRjhQYnY3?=
 =?utf-8?B?aCt5blh1QUR3RFJ0L1h3WWlOZ2VqVVY4U1ZUNEZObWJpSnJrSEVZMXRZbGQv?=
 =?utf-8?B?alM5YXpBYUdraEcyZzB5Mmt6d2Uwd1NlVWNFWkxuL2lIdmVibnVtZmJKenM2?=
 =?utf-8?B?M2dnZDJLSk5TNk1sTHBYeTdhREphN041WisxVndZemJtN2lFRTNxeHVUc0RT?=
 =?utf-8?B?MDJNT0FGZjRDemxMQ2dxbnhpSlNGeUZJOWxxWDRja3g0VzF3WlBDV0FzTzZn?=
 =?utf-8?B?aEVsQTNSYUFkSGViUzdJZGJiS3ZJbFpmNHgxd0VwcGhSMTRXajZWeGlQRlEw?=
 =?utf-8?B?MDhGOVBnUEpSUytrR0NhdnpETDViaWhGazU3SG5WUGdDRW5JUzgzZ2dPK2Ni?=
 =?utf-8?B?NmVDSzlqbjc1M2ZZcld0T1RFUWZVYnJGbWVyTUJDQlh6NENyQitqWnUwdjhH?=
 =?utf-8?B?ZjRXU29SU09aNHdyNzRKblhKL1RGcCt4TkQxSU8vMlhQSFVOV3hyR2RONkl1?=
 =?utf-8?B?eHZ1ZGdjTlU3RXRKTUdCMmd6SkI0TTczVU9JZnZPU3VaYy91L0N3amZnbXlz?=
 =?utf-8?B?Vit5RUZQWjlGM2s2bjQxR1ZtSDY3QmJndUpqTUZ6OWI3TW1Ibk1RNkJMMm9D?=
 =?utf-8?B?ejFKcWxYV0prZW90WnYwWTNOQ1p1bUtzMWpCUElTNjRwekFnWHRYY1dHL3lP?=
 =?utf-8?B?aDFrVTRjYnZOWndMUlEwMTFnd0x2NVo1Z2Z0L3BDdVhnUWVVbEZJT1M2dUFI?=
 =?utf-8?B?ZzdubkExdkY0SlRsNDMwcW1lTG4vb2dWTC9oNitkS1F1a2l6cjh6SUtTUjU3?=
 =?utf-8?B?am4xbzRhV1hVeGdZdVRqQUhubDU1enBqZnBpWnIzOHNmaThNMHE2M0cwOW5h?=
 =?utf-8?B?VXlUenlheEl6UDJIZjY0Nk1ZbU85anFnck13K3RxeHp2MkhLN1RQK0xqY2NJ?=
 =?utf-8?B?eXcvRXFuQ2RqVURrWnhkbmhqVTRkNEpGRHdUTUxkWG1XVVg3TEU4a0NEeXJT?=
 =?utf-8?B?OTh3SndsMldGNHRIZGRFc3Z2aVY4QXlOZDJ4cFVHNUlRQXRGMEFGWU01aU9Y?=
 =?utf-8?B?dDRERVZQYjlTN00wOG41TXJSZ1lCNThhTUZwMVM4eEJ2Q0dDT3VMVjhYdlU0?=
 =?utf-8?B?dm5iL3FmRSsvTmN0ZnQ1a1ZLaTBYYUdlZUtiSlBodGVCOGgwdUhsYThta0RI?=
 =?utf-8?B?bzF3WDU1M3lIbm5kZ2xLNmhwZk1iZFJrODJQc0FKUTBhSXN4YkZUMW1TV045?=
 =?utf-8?B?ckVBdTFFeGR0OENHM0NiR2VzSXdJcDRVWjBOb1FWdi9YUUlrYmhzcjNJaFRN?=
 =?utf-8?B?Z1haem5VTFpxakg0RXFYQWtkZ2xwV2lSdm9VNnlzd1d0MDNUK2ZYbWx2UTVR?=
 =?utf-8?B?U1VIQzdYVmxQN1lhOE0yd1lRTytPeEhoVzF1L1FCOUowTVczMllrN25aQ3cx?=
 =?utf-8?B?Tm05STRzbjFFRXBCcVNpRE50ODY2bDRXczhjMGh0bUNXSFdycUIwclhJcitR?=
 =?utf-8?B?OS9MdHVlb09WZHkyWmJvdmxXeCsxdGRISnczZVk0SCtpSXl5Y3V2WFJWWGZp?=
 =?utf-8?Q?4Lta1RxFcI5onwymArtdq2Y4X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ba7595-46fa-45fe-6058-08dde7975e7f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 07:32:27.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMvSyIGgrt+gSjU96nRfmHxNeBpN6rKMvcxv9WhuJXWmT5vSPwaaxWtNFxgv8KnzD3LyGsBeCW+yVn8mzy/PsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5166


在 2025/8/30 0:52, Rafael J. Wysocki 写道:
> On Fri, Aug 29, 2025 at 10:44 AM Qianfeng Rong <rongqianfeng@vivo.com> wrote:
>> Change the 'ret' variable from unsigned int to int to store negative error
>> codes directly or returned by other functions.
> You need to say upfront that this is about speedstep_get_freqs() specifically.


Yes, my commit message was a little unclear. I will improve it.


>
>> Change the return type of
>> the speedstep_get_freqs() function from unsigned int to int as well.
>>
>> Storing the negative error codes in unsigned type, doesn't cause an issue
>> at runtime but it's ugly as pants.
> Which isn't really a technical term.


Yes, I should have used more normal words.


>
>> Additionally, assigning negative error codes to unsigned type may trigger a GCC warning
>> when the -Wsign-conversion flag is enabled.
> Is the latter a motivation for this change?


That's one aspect. On the other hand, I think code that assigns negative
values to an unsigned type is confusing, so I want to fix such code.

Best regards, Qianfeng


