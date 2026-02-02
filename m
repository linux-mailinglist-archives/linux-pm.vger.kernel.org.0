Return-Path: <linux-pm+bounces-41884-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKojOmxWgGkd6gIAu9opvQ
	(envelope-from <linux-pm+bounces-41884-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:46:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C86EC94BA
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 08:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7C73004C5F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73529E0E6;
	Mon,  2 Feb 2026 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dT3xEu1G"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBDD298CC4;
	Mon,  2 Feb 2026 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018305; cv=fail; b=cllv8IL4KYu0WnYzPQ97OPAlg/RM6i1cvAK83YJGrzNCtrFv/ZT6DKQsvrNARrX6YbWi0yUe3O4pFhOdHGHbuP5i3Dbcu/Fo+9CSc0a+dSuJ9Ot4NPqrux4fTq9wClvqQmxkFS28cku5FIuFcB76sJBoZak3atpTNP74NhCYRQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018305; c=relaxed/simple;
	bh=xjPlb7EGS524xf5+nr2PrB1NAdi/Z9uitkCFAPYo7Ok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=epQBQY6BKgiCgLa/tv73ql9a3X9UajEb7jkdP5kn7S6oUfWIHvbEqctMsXaX2XpFzcrqLpG3jPRV/aIy5SaxHymgikdqughU4slntpDmKJaw+fA04ZllESMNmRjU25UGLRvYMOE9F55VD0+iTvLAYoUSU+GB1cRvvyu5i3EqPJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dT3xEu1G; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlhsCwpfg5VQfNOaP8FqPbhxEFRE8VsAQjF1JoqbLMQuVAm218Vl7rwPEaEjpRkqfqkIiZmfoxuAeDC4R+vk6DbGakAaaTMal/UgMlQJ0wCEjNCUmQf80dbqVyqg8pocZi1yBe0Ym+AHkAp6PRznoQpITA/4I36NxbwHktoZ/W1bOznE5HhTY3N28eY+lrKc/WdRYFOpZDNb10LAxr0vRxqF7ofF94qmb1PQZjp5KnEHHcNhDXLrpDtNkxhDVir8jFYqah1nJEoGGceCDYV5qf/UC58QpGtSTmZXXJNAfgZzcLDUFwlBMm+H6PQ7XzjhphDm4SZ1fTePf9NYW2i11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJbnhqm4CGcP9+8zPEKBC7QT0hs4WBAgEd5rVaVoJIY=;
 b=XnfQld7Jxt/wHw9O05miMKvdVIAcxMK0RWZH6I0zGnG8f/5eEB9yZL46A0mVM9ZJyLFn4w7X4SLjmiR61bDq1d2aXoNRkQ0D6ds+aGO/hiTAxh1Q7Vdm12VzA3dV1U1Ot6wwnsuT/24M9CouA99wXrmd1y5Uxic25029e6d8kgDQs/7xcp2eHpo25uKc5TDO2F/YdKE5KiGU57PqOR8T/XqNKK8+4q+2n7QSJe9x42OHNoPTr0+/jdh5Lz4d/6Uec6oCzIfAlTsiqFmZmYMaXfsbxq0ejJe+fUi0qzB0oNJNrwvRvF3hMg6aB+NPod0hBj4tGCj8tlMWtTZs0BCrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJbnhqm4CGcP9+8zPEKBC7QT0hs4WBAgEd5rVaVoJIY=;
 b=dT3xEu1GJSdXb/qT9f9wjD1bZCfp5Z80Gn/uvS6Dym7GmDSaW6awQX8lVjnvvh5YqUXnz8iztEGE+UocuSYy0ga4mOTUmsV0WJj9wDGJMa+6B+Tymh7Pirtb5xKbzBgef034SH16pOhbgoX9fB8/WGkt8RYzWnnmDIv5rMvPCbsmUzuOgjcZ4mCVuNwAU834tISiKMWMRK9lbTXR9+ZzqsslA8X9YsYhRgiEd0WuRYYZIUKinaxmfjel4nG4NbQmvOBXmcCgTio2Vp/KFjq/AFm2vPtA4JHkHCsjIHTY5NgAZGR0kq/DWgYlY6M+qi9qD9f5pRxD8IqD5u7pnlI8eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by AM9PR04MB8700.eurprd04.prod.outlook.com (2603:10a6:20b:43f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:44:59 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 07:44:59 +0000
Message-ID: <0b24716b-438c-4185-8a93-3a3879147c24@oss.nxp.com>
Date: Mon, 2 Feb 2026 15:44:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
To: Nicolas Dufresne <nicolas@ndufresne.ca>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
 shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com,
 eagle.zhou@nxp.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
 <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <df8d5d5f28870752e77ec74f34fea7ceb6e97286.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|AM9PR04MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: d71ce319-43c4-4c83-645b-08de622ef122
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHlGeHZlaUF0UkNKajZKV1o0R1hjNXpDeG1Wb3VPNUtTL3RvelBjOUlSbmpu?=
 =?utf-8?B?OGovb291OXJtRDAzckdBMUxramZ6YmRKUUdyTUZTTnZSZzYwb3JWTXdrSElB?=
 =?utf-8?B?alFBWWgrL1l4bmpYbVNHVUtlV1A0YlJRckZ1THBMdzRnWUUyWlFWUmNacmRm?=
 =?utf-8?B?WkNzb0JHUEFJUUJtV0d1cVo5K1QraXc1QjFxTU0xRGZEcVUwVHBOQ1cxeERB?=
 =?utf-8?B?TFVUMXhrdUFjM05LNytOQ2gwQnNia2Y1ekJZeUthbGNHODgrUDc2OG5jSFVE?=
 =?utf-8?B?Q1R4VUtsUUtJSnpwSkhKemlqcVR2RVZqUmY5d04rRWU2M1Q2cGNKU0RvL281?=
 =?utf-8?B?YnhtbENrOWJGTlV4OS9UNVlYUkdleHI5SHBjOVVXRkxhbXNIbGtOam1PQ0Nq?=
 =?utf-8?B?aStMUmxEMExnOHRETm1pS0w5L3BNeWRWTkpRZ3ZjdzZuOWRmNlhUTmsyOVVN?=
 =?utf-8?B?ajgwM0lEaHBHRjhrNTFCdUZqcVplUkd4TE80ZDd0ZkZQYU9qUWN0SnE3VFA1?=
 =?utf-8?B?MDFVcTJDbmp2YTFpUXQzaFljdFJaSm53VHVmaDBnTzcwT0ErRzA1eEJ2VGx1?=
 =?utf-8?B?SXhXQkg3K0RLN3B3WmpITWdEaVh0TDh0dVdJMXg5N0NaQ2pHT3RDU3J5UjhG?=
 =?utf-8?B?WU1qdTFnQUFoUzM4bmZlSTUxa1FvQi9HSU5WaW52TmpxdGhNUmZibFJwVEFw?=
 =?utf-8?B?QlNFUmRJWEd5ZlI2Zml5dHR6R3Q1TU5CWVp4amRDUHhTRG5iYU45NFhWV28x?=
 =?utf-8?B?TUFCMHJTSnJvaUhNVEpFcHFYb1N2K0JwMmxvaG1uaHpPdEdOb2h3M0lML0d3?=
 =?utf-8?B?dHhuL2FENUxLa2tadWRybEFVL0phMElrdWZqSWZibDJ5MjRML2J3MitTKzIy?=
 =?utf-8?B?dHZCOGlDTVpLeEpDZ2pzM2VPYVJaQUUzczVMTzdCRURNWjNKMjN1UHBMT2Vu?=
 =?utf-8?B?ZUlyZHNaSlg0V2YzZEdUeTJjam5uMi9kZDhoMUhnemdPR1AwenJWZGI4Q2lu?=
 =?utf-8?B?MXVwYXdnbldEdTRpV3pVU0VFS2VXVUFURUdHRUkwTnI5d0dJZ0twOUdjZDhC?=
 =?utf-8?B?Z0N3ZnU2cnc4M1lsTUwyMXR1SStnNlhNVkkyS3RUaVZ5d3I5V09RZXF4U1Fw?=
 =?utf-8?B?QUM5VmdEdHFWRUVGaW1SeHV1YmIzcmxQV2JZMEpsU3lmaEF3ZU50eDNGS1Fl?=
 =?utf-8?B?TmFDOUhZaWRXSkVnN09kRnRhN3JpUE1vRmJFYlkraDRDb0dYK2FkNEIvNHV5?=
 =?utf-8?B?b2tmaFdscmtGNmp0Wlh2cUgyZ01jZEIweE8yTGNnSW01MktkU01oZ1FFK3NM?=
 =?utf-8?B?WXJPaU0xZXFvaFVCZzBRSi9nT1kyU203UmlWQTBoUXdnTy9hT2lWUmRvLytJ?=
 =?utf-8?B?cW9qR2xnSGc0SXR5K0xxSVdLbjNldHVFem5abGtCbnNaQkpHS0VRdlBVTDdv?=
 =?utf-8?B?eWNETUZLeGR3b0l4b0dVVFJOUmovYUhGeU02Tzl5L3pXdUNnZkNtcW1KV3Fq?=
 =?utf-8?B?TFNMSFZnckdvZGtXWHYxR2hub1ROa2RCa1dCTEZHdUw5UklxRWE1alhWU1Zt?=
 =?utf-8?B?c0lJSDdNLzBzOWRLcDVUSFVIbzNLcC9iWXMreEx2a2I4MDkxaWovaE01ZE1m?=
 =?utf-8?B?Smp6ZnI5V0kxc2FSeUZsZWE1dmpMdDVkZlN4REFBUFhXUmxLMjcvQlYrZ0Va?=
 =?utf-8?B?OFBadXRIMGVNdjNEU2pLYWx0YjBDUmFaak55cENHZVgvMEdiK1pGVUdLeC8w?=
 =?utf-8?B?ZTVld0QxMzlScGlPK1hEUkc0Z3BQK3FzWkk0STM2Vm13WGxJRnlFeDg1QWgw?=
 =?utf-8?B?WWV3dFJzb25WN2JmdjVGRmhkWVhUVkN5aTk3Si9Da2FCU0ZrT0NlNGdMNjMr?=
 =?utf-8?B?U1EwT0lWTUZiMk01QWV6d2NZQUovZkZVTks0bUNaTTFUQUJnMDBlbTFjNk9Y?=
 =?utf-8?B?TjIrQzBlSHRRMHIrOGxNQS9pbHI3RHNsZXNnODRTNFRWVy9FMFgwVUxiQVRM?=
 =?utf-8?B?RmNBMmtDRlhMbjNtd2RMZ2tZMXV3MnZ1Y3cwdjhCd3VtbHFleGJCdHMya1J4?=
 =?utf-8?B?TVorWldjOTJXRCtRQm1yNUN6ZkhDRm5ER3BMZU9GRzNhMmZpUGp4TjdLU2hJ?=
 =?utf-8?Q?n/nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUg1TnBUTXE3dkxMTEticlRRSXZBSkIrNE9WOVFnanhkRVRlMzg0ZmJSQjFu?=
 =?utf-8?B?RGdKUDdrVXlzai8xNGhmZTkvQ2xJT21lR2h1WmJVM25yNHRVcHhCU1ZMaVpn?=
 =?utf-8?B?dHNjbUtBbk5EQnlvUXQ1V1ZHU1dPcTFGZXJuelZaVm5LYndzS0lUOEE2RDl6?=
 =?utf-8?B?bWtMQnh2WGs2RVFSck9wUDRTQk11bUR5QnlKR0ZWRlFRU3hQMWpKenVNZi8w?=
 =?utf-8?B?bGZJVmVFejhVR2dnb2ZwNXBiSTdiSy9SRXBySjZHS21DWDRrTlNoRnhIRVQy?=
 =?utf-8?B?REtKSnFObTk5dWRjQWZORi9UOGRyT1BxamdFOTBHRitaZUhJTU4wcS9YenAw?=
 =?utf-8?B?N1hMYzVjNnVTa2dLQW9PaUtvRVcvV1RjSy9JN0RVMHNTRUM4amRkM1VnTmxn?=
 =?utf-8?B?RWx2ZStZR3JRa01tTVN4VzlMSTlVeXZ4WWFVc25tMFphcVNwLzR1U05XaUYw?=
 =?utf-8?B?RXNjZnUydTNZK1V5QVMyaG9TT0xoQjZ4UmhEZW1tc2RuRHl6VDFhbzZGWGx6?=
 =?utf-8?B?MCttaG5FbWxUeHRtYzNmWmJzWktIL1ZwU2crQ1E3V3E5WGhCSzJJNXlSV2Zw?=
 =?utf-8?B?dm9OVEFNeWJYcmJIeXJBUGxMUjU3RFB4M2hkUWJPNFlBQUIrS09LeUFVVUNW?=
 =?utf-8?B?c2ZRSG1vYnFGcEtnbFpqZVVyc3NoVmQzQkF2SlVndWRHckU5Sm5iSjl3blBX?=
 =?utf-8?B?QUM5aDIxbEJHTFNuZC9yK0FsbGRPd0FRZzhBUmNNVFFBb3RQS2dMMkU4RGE3?=
 =?utf-8?B?ejd1dlB4azRoUFRxL0M4OElMQVYzdU82dUFXVk9QL3BRMjc1Zitoa1Z6ZXBJ?=
 =?utf-8?B?ZXhyeXNtMGFxbmhuZmVrclQvMlNteXBwSXNVYVFuenRxa1l2ZjZnd09Qei93?=
 =?utf-8?B?SGJtVnJPbUZXU3NNNzlta0tjQ21JY2pLdUpRSjY2SjN6bjJ4UFJlN2JsMjZi?=
 =?utf-8?B?VkI0UXRRRUp2QUxVQUc0ZDl5Y05JRWdVMDVYWjJNL3ljZHFQSlZKekl5bzZq?=
 =?utf-8?B?VmVKc1F0cjgvQUtMUlh3WnFNK3h1Mk5RaWdNTVFNQ0d4b2pISHNFdFFBUUJX?=
 =?utf-8?B?K29TRXVrTkh3MVVVN0pTUzF0bEFabncrSHh4T1JIa0JPSlplTVRpajRCZ2JH?=
 =?utf-8?B?SitwYkE5L3FEdHB1dEN3cnZtVEEwMnlHMkZ3WnVjTlo2Ky9sd3c2eWQ0Q0Rj?=
 =?utf-8?B?SmZ5N1NuRHRVdjhuSy9TUTdhWFVqN0Y2Y2xxQWtaZ1FUOUNGWTFuOVh0Ri9S?=
 =?utf-8?B?Z2ZEbDRIclJ5eVk0Q0lUaGRHNGdVUjVROGZxQzVWOGJpaUMybVZnOFdJZXJU?=
 =?utf-8?B?eWlaR3hyaWMrRVFGRWZzb3ByS2ZOUithOGJyR0NpY2UzUzFITmZ6RzhuY2xl?=
 =?utf-8?B?QS9Cd0xQS21HcDJ0V3pQN0lvY3B0c0wrTjg2UVFaK1pTcTJiK0RlZFZQYUkw?=
 =?utf-8?B?ZWFOYUY5T3F0L3JtZGdLRkU0VkdsREtkcElVWmpxaEpVNW93OHY4Mng3dit5?=
 =?utf-8?B?c2lOU0dibXhUU0pGTk1YTC9UY05INnBSeElnOUZNZmdZenBMRGRISTFRR3hY?=
 =?utf-8?B?bE9LQXFEUU4zd1l6OG11cmoxdU91ckpFdHFGckpzZys1ekViWDhDQWMvT0Rz?=
 =?utf-8?B?NTRDbldZdTlXUS9oQVk4eEdhMjZyZFN2djg2bDlKdW9ucTNjVGxzOGFyamll?=
 =?utf-8?B?c3JPOU5BVS9BODNzS0pwbmtWMldkQ3kyZDI4T1JibFAyZnlETFZNSXR6NmRt?=
 =?utf-8?B?ejdPSDZLVG9GSkhKdzB0dDJ1ZVFISGVVVm4rd1Z6TXpWTFJjbHFrR0hSVEYw?=
 =?utf-8?B?RUlmeWFJUWRoUnVQbWJUMWlBN0NjRVhLR1VTT3U2Z0VucUVPZFloenExQ1lq?=
 =?utf-8?B?N2RyenJjMFNuNUZWeTRybkE4MVQ0VGdTZVFxaVJhM1AzeEsxUTgxaTZBV0Jh?=
 =?utf-8?B?a2Fnb2VMdXNGUUxrc3dmTzhhNHAySEpSMTVCdzVTYTZudElnWm1GbUlXRjdN?=
 =?utf-8?B?UkI0WHBJRlkwQ1IyY21LbEtiekxTMkcwdTVHc3RIUXpsSWFISE5rL3k4dWtu?=
 =?utf-8?B?aFRTMVNEMUdyTTZmN3JWOXFzVGJodWZYRXZQNnNncFFhQnZ3dHpYdEJob2lY?=
 =?utf-8?B?aFM1cGEyOFpGbTBBOU5SSkVXZWl2L0w5aVJXWkU5ZDBsY2ZLZ24vSk1RUTBH?=
 =?utf-8?B?dEdzaThQU1BDUUhPWDFnUEdFa1RuWGE0aU9lQzYvdTZwWWc0ZkVINjQrZzk5?=
 =?utf-8?B?cWRmdWhiTGR3SGpNSWNtMVUyRThSR2FLd1ZWZ0xoaTVRbkpkRnJieU92UzJ4?=
 =?utf-8?B?UU4wTFZ5YUd3eDRQUGg2QmZSU1RiVUZhSkFvNzk5S2ZQWFEyWUF6Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71ce319-43c4-4c83-645b-08de622ef122
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:44:58.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7GQ5hYW7jl84BaeQbP+E/hzPhwi/NHjHux4hUID1NPQ2uqdxvqh+R9bYVTtz2NPXdLN4xucSUI2uQxs7r1fdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8700
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41884-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.qian@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[60fps:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,0.0.0.6:email]
X-Rspamd-Queue-Id: 4C86EC94BA
X-Rspamd-Action: no action

Hi Nicolas,

On 1/30/2026 10:47 PM, Nicolas Dufresne wrote:
> Hi,
> 
> Le vendredi 30 janvier 2026 à 16:41 +0800, ming.qian@oss.nxp.com a écrit :
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> The VPU G2 clock was reduced from 600MHz to 300MHz in commit
>> b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock") to address
>> pixel errors with high-resolution HEVC postprocessor output.
>>
>> However, testing shows the 300MHz clock rate is insufficient for
>> 4K60fps decoding and the original pixel errors no longer occur at
>> 600MHz with current drivers.
> 
> Tested on EVK, with the downstream DCSS driver, and this change triggers DCSS
> underrun (which is related to the DRAM QoS erratas on this SoC). It also
> sometimes trigger the "not all macroblock decoded" warning I added recently, and
> we can empty IRQs, but these are handled now.
> 

This doesn't sound like just a VPU issue; it's related to the display or 
DDR.
If not displayed, do the fluster test cases yield different results at 
600MHz and 300MHz?

>>
>> Test results with 3840x2160@60fps HEVC stream decoded to NV12
>> (the same scenario that exhibited pixel errors previously):
>>
>> 300MHz performance:
>> - Severe frame dropping throughout playback
>> - Only 336 frames rendered in 11:53 (0.471 fps)
>> - Continuous "A lot of buffers are being dropped" warnings
>> - Completely unusable for 4K video
>>
>> 600MHz performance:
>> - Smooth playback with only 1 frame dropped at startup
>> - 37981 frames rendered in 10:34 (59.857 fps)
>> - Achieves target 60fps performance
>> - No pixel errors or artifacts observed
> 
> That probably only true with the upstream DCSS + a small resolution embedded
> panel ? Can you clarify this setup, because the display drivers mainline are
> very minimal. Would be nice to show you average DDR read/write bandwidth
> utilization during this run for comparision.

My display is hdmi, I'll try the DCSS.
And the DDR bandwidth results measured by perf are as follows:

  Performance counter stats for 'system wide':

       113303664278      imx8_ddr0/read-cycles/
        82457075530      imx8_ddr0/write-cycles/

      634.892101865 seconds time elapsed

> 
> Another information that bugs me, in the BSP code, the G2 voltage is increased
> too, which you didn't do here. They also use the thermal 2 zone to kick it down
> to 300 until it cools down.
> 

In our internal code, whenever the frequency of either g1 or g2 reaches
600MHz, the voltage is adjusted to 1.0V. Since g1 is already set to 600
MHz in the upstream DTS, I believe the default version is already 1.0v.

And do you mean vpu-thermal? But it doesn't define the cooling-map, I'm
not sure how it works.

		vpu-thermal {
			polling-delay-passive = <250>;
			polling-delay = <2000>;
			thermal-sensors = <&tmu 2>;

			trips {
				vpu-crit {
					temperature = <90000>;
					hysteresis = <2000>;
					type = "critical";
				};
			};
		};

Regards,
Ming

> Nicolas
> 
>>
>> Restore the clock to 600MHz to enable proper 4K60fps decoding
>> capability while maintaining stability.
>>
>> Test pipeline:
>>    gst-launch-1.0 filesrc location=<4K60_HEVC.mkv> ! \
>>      video/x-matroska ! aiurdemux ! h265parse ! \
>>      v4l2slh265dec ! video/x-raw,format=NV12 ! \
>>      queue ! waylandsink
>>
>> Fixes: b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> index 607962f807be..731142176625 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> @@ -960,7 +960,7 @@ pgc_vpu: power-domain@6 {
>>   									
>> <&clk IMX8MQ_SYS1_PLL_800M>,
>>   									
>> <&clk IMX8MQ_VPU_PLL>;
>>   						assigned-clock-rates =
>> <600000000>,
>> -								
>> <300000000>,
>> +								
>> <600000000>,
>>   								
>> <800000000>,
>>   								       <0>;
>>   					};
>>
>> base-commit: c824345288d11e269ce41b36c105715bc2286050
>> prerequisite-patch-id: 0000000000000000000000000000000000000000

