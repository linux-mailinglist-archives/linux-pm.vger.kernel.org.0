Return-Path: <linux-pm+bounces-18431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECFE9E175E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 10:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5437164F6E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44631DF243;
	Tue,  3 Dec 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="rbF2uqQF"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2137.outbound.protection.outlook.com [40.107.20.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADD16EBE9;
	Tue,  3 Dec 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217964; cv=fail; b=OWQ3Rifiqgdk0cGKkmtldrNFLMoio/FWn9O8XzTsxXxuICsICTJafmrGvk3pXjetCf+VNHgvNkpTZZCXM1IXfixStlOS8X3knWpEsueQJ+viZMGZoe/GQ8wv7dBulQY7nqAFDmV6aaVXnFhwP3ucoOq9UHyWtcg2X0h4Cz4OF0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217964; c=relaxed/simple;
	bh=J9zWr19dg5YDYcz27M9HdIs9ewdDq56+7yKKsItKAw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u1kz//kt4ZujUA1Vp8wWQ383uC4CHXhEXP8fCDznR32Y64ilwZ8wZGtseWLovUBLzt2Polft1uppkR+NKAV0pD+mvfP00g+XMi63wkPcx94n/23nkCsnfop4xt/amgC1Wpf0GrgR+3oL8b9Dwo9Gu1Ywqw7XVvOL+xCKU074dgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=rbF2uqQF; arc=fail smtp.client-ip=40.107.20.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlhWLm6Er0PaO+m9r5B5oj0dLHEIkqE5PBfJQocNCYyg/ookrylOrMyRi/HW31Q3KXXIFRjLIEtCOmLsHcREC8akqej8X041dnQLTSBVFd+55LS+Q61XqrsoUJzJmtRYJMk9G/WZYg7PAIJVMQjBkDGqUqhFMW2mgyn5mZCYi66e6tkSm/ps/OQ6C5LXkwvWVhZtCr4ujVR8K77IrUzOvxzcn4ZiNGSNTDK35jtr9nUH5SF9GhiwcnfbHtDYKTGL5cvropiGFnaNqVrguE+qOLMwZtYv6WibTcuS1CmCYZH5lHLiqgP4xpHL76gzrS3xTs+tUkO5sJ6lF7r4LnvGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZD7b+vM71mZfpqF64PRHfvwJTG/DyKr2uo0wPXi0/U=;
 b=JwbnMwTrl8OqmqPh743N4JDI/P7saTWtMMHqYxBDLcS4CVI32nz/LPUAWy75wuCGq33KMwRsI5ROBGBm3zxFlxtFvzSChKHrvLxko7c1pJrj3T3jEvOEa4aIYGNpCTpDbcG+6NrloOLmbK18pnPtaJxxZP8rzm8WXzbMfDnXMvcmB5NvkqCNqRBHKJ6o1uYAJWgxWpO0fKkDz9bhjnJYvcOCc2KjpjvW6cnn8iiYMjk4bUZaY5qvpmz8XcvwD7Naj0zQePVUJ/7rUNxfQ+evjcxeNx8iG4EgpEJXfvHfy9Rxlyvdoxd4h/zc48vj6ofngZXQwqT52rlA6sgw9iCs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZD7b+vM71mZfpqF64PRHfvwJTG/DyKr2uo0wPXi0/U=;
 b=rbF2uqQFIWMiiTImSePsledHwdOtRmXfPSVPwM5W68yCAH4E7ikVvaNcRCJFmeKfJXSiJrKVga3r5qETHY0IJ3mWARtxiUVeN3nUTDROq33Kad9B/NUPyMBACxTYzTw1+Rrup217OLZQvNs56AxguhrScYww/ltZNlJAPjVXNXp2WkzksKJ7FZKDrNbHGhEFTPxHmtl8TcwP3Ta78N7ob2uEn663AyQtdbUf0C6eoHIaiOtuhoT6e3GEghbJlkPvsHRcix2281HHzr+IwnT3VXkoMdGdNKZ6YL/u5Y3iZ1hsJumLqDxYfSDphjV+t8BJ/ej7jwkH6iciyIXacsIqFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by GV1PR03MB10607.eurprd03.prod.outlook.com (2603:10a6:150:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 09:25:55 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 09:25:55 +0000
Message-ID: <9426d88b-0a8b-4cd1-81a4-83cfa61bb595@uclouvain.be>
Date: Tue, 3 Dec 2024 10:25:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: supply: add support for max77759 fuel gauge
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
 <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>
 <20241203073556.GA3936@debian>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20241203073556.GA3936@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|GV1PR03MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: 629e0651-79ef-4d1c-1996-08dd137c7d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU5vd3ZkR0ZZNktYdjVxLzZyS3VmRzRTM2pjbWNyamJBWE4zMDdyZWFaSDZI?=
 =?utf-8?B?bXZsWmFUSXlJKzFwUGtNeHBDZ3MvUHlSUlpOS01ROGNXMmRNU0dJRG5zL0RW?=
 =?utf-8?B?cEZEK2JLZGU1RmhPOStVODN2Q0RpNzJxOTZaakpETlBYTTVwRldJTW1uZ3BS?=
 =?utf-8?B?SFhGNHYyVEQ3NGRuMVlkby9vR0hJVzg5M0NidWlFaVpxazhFejhXQkNkT0xY?=
 =?utf-8?B?UnlYKzRzbU5mc3l4c3BVcEhsZUdjaTFIOHU5Y3JDUGxTem5PbWUwWUFHb3RO?=
 =?utf-8?B?bVAyWjlPVXNYam1BcU42bmdYdjVKVFExUWRzNndab0VGcWNBZnhNTmYxUytS?=
 =?utf-8?B?S0FzeXNzV1BMelJqK1lqWnhiNkk4aU5TU054eG5Yd1k1OGpCTmM4czFneThU?=
 =?utf-8?B?QzYwVHJxNkhGdFRnYzRMVktCMTUwZUZKajlnN050amVvSThJQlRIdk84YWJX?=
 =?utf-8?B?TDJJQzVrVkdTSkhBV1oyODM4ODdzT2J5djNFVUhEeDZrQ1JZV2lmUitaQ2w1?=
 =?utf-8?B?ejlSWHI4SmJaYkZZWFFzZ0RHdWVxb1EyUTN3OUtyWkxUWGZyQW9RZGUwQ0tC?=
 =?utf-8?B?dTNCSkhGQVFvMjFmV3R4bmtoQ1FiSjl6cXdKcmRNbFR4ODBnVUpPTXNMZE9t?=
 =?utf-8?B?eHdLbkk4bk1lYjVUb2V3NkJiS2RIUlk3c1FqQ041MlZ5WEZEdkZLOERLZkc1?=
 =?utf-8?B?Ukx1ejNNOC9HRlBhZjJiM1dvRlp4aVpuVURXNVY0YzA2am5zODdDSmVJZFFq?=
 =?utf-8?B?RFYvbXVNTC9pQi9uc25ldkRBTmVmV2tTVFNhcG42N05JcS9paGU0WHpGMjQr?=
 =?utf-8?B?OW1LbW1MU3FNbHVhVmg3b0p3ZjJDTzNtekRjOTJOSmFWTjFZZjFoTTBqQzZr?=
 =?utf-8?B?UkNEaTA0bHNGWEk2eWNoaTc3M2h4YUhRb1Zmb1ZMa1lxbGs1VjRzakpNTVdK?=
 =?utf-8?B?Y0x1UHdib0k3Ykk2ZTFRTTB0cm41NFJON2tRMm9oSXJMSk5NdkdFVThTWG8x?=
 =?utf-8?B?RzVSNkZyaElhUEhWVTRDZWxGUVdJcURRLzREY0tGZnNkU0VlbVlMR2dZYVlI?=
 =?utf-8?B?d2tXM1MvbFVFRjF3RFc4UjFjVTFwekQ2UHM5TWpiQUk2b3M4Uk03WlFxQ3py?=
 =?utf-8?B?TFdDZ24yVzF1Z3V6bWFUTjhzNTlkdFI3d2tSZmw5M3E0RFd4R1NURHA4em5K?=
 =?utf-8?B?NVM0TmYybGRyYjhMWkovV2Exb0pJaVlxMGFWYTVWYTlVVFVKcS8zZWV6elYx?=
 =?utf-8?B?aysxNHY3aW9oeHM4SXJoZW1qNWhwWHU2a0tFS1VDZS82Z0NDeWFNNER4ekJh?=
 =?utf-8?B?K1BkM3pPWkZqRDY0a2ZCWUxSaGs3cWdRTC9WR0NENzF3cEEzM1FzZzJUQTNu?=
 =?utf-8?B?WHMrYjF2Rm85WTE1OFlXUUMveEJTRGd2bzhmTVJMZTI1TWZXRW95ay9WWElt?=
 =?utf-8?B?cm9hQXcwU0o5ZTVaYzRQZzBGZ21HRlpxQ0NOd2R6ZGIvVWZmUFVQNTVvdzhJ?=
 =?utf-8?B?eDUwZm5QNzFjaW42dGowbzE0WGRXbVcxTGpJUFV4aTV6M01FNCtnOVFwTEVK?=
 =?utf-8?B?ZVJBOTJYR0pHaFdsYUFyQmxRdzZRQzQ0bHFXZWNRQndtQkVXMUpUVWVsNkZ4?=
 =?utf-8?B?bktmMXZJM3ZIMTB5WEh3Z0hwcXpoTDNNUGZyVncwSGtObTNzdElzc3B3ajJw?=
 =?utf-8?B?WFB1dnRjOVhQRzhMaWUvSkQzS3NOcmdlbWsyc3VtRkk3YnpyUWRtc3JEK01r?=
 =?utf-8?B?ZjUyaXRaNDdwR2p2VmFFM0tOV3FodjcySkxnbWZFSzlNcExyWjNlb0ovNmx2?=
 =?utf-8?B?L3Jua05EWnkwMXpRU2x0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NC9GektYU2xZN1pLNDlQZ1ptTVJqMGhkak9IWE1RR1JCK1pWREVCNERuVVFT?=
 =?utf-8?B?L2tRaGVtRDU1Zm9jdlhNWW55ZUw3MlRlNmNka3padnVXc3c2cEFSMjh5N2pj?=
 =?utf-8?B?aGVnNkxWbTFlNE8wTGxVZXFrcGc3YXZJakl5NXRiN1ZKU2lVNHQ0VlUraEJ2?=
 =?utf-8?B?MUtkOFRuaUFCNTF0a08yQ2l0WmtGMFlqclBxcUNwaDMyWko3VThYa1NvNnFz?=
 =?utf-8?B?VWd3QWxUS0xnVnZpUVpSVEd0K25TOEorVmwxWkFKY2Z5Q01IT1h0RnEzakNN?=
 =?utf-8?B?VDM1TVJ0S0I2NFlKamozbGpYZGxldjhVcWNkZUxnWmpEZ0hMR1psdGVxZy9k?=
 =?utf-8?B?SFZ2Z3ovWUtXLzh4VWxMb0lHK1Z2MG9qVmpWWGtNUlVUUlNyYTRJcC9vMU1U?=
 =?utf-8?B?Zi9BTm5CVmhjVDFQSmQvV1k0ZFR5QmJKVUE2S0hHTGlnUHQ2SjdCbjdiNnVY?=
 =?utf-8?B?T0xNSnhhZDBFOXRaUDlRRnlLQkRLazVEaURkWit2QlpoeFFqbG9oYjRqbHVx?=
 =?utf-8?B?a014RFBJVEU3TjFXQjdhYzU3ZmErakJqNmtFdTVidVZzeUY1Z0I3UVZ5bzZB?=
 =?utf-8?B?YzErNmF2ZmNyTmZCN2E2OERXd1U3dE1DN0JWR2JNdzh6ZnV3Wm5IS3ljSFhw?=
 =?utf-8?B?enUwVDArSUhwMTRJZ3VyS1VkbHhCT0xxVTM3S3pWZ0QyLzRUcmVCLzJ5NmNv?=
 =?utf-8?B?ZFhCZ0k3Tk42a0ZCeml3ckI5dkNUSmtTTVN4V25OaGJEeFUwM0tFK0VHSUFG?=
 =?utf-8?B?OWRWWHJGQnIrNVNkb0pLZVA5NG50YVA0VXdvMk1US1kyM29qU3RPUHhWVjNr?=
 =?utf-8?B?ODAvUUtURlpadEk4OXJPYlJtNUFYV2YydXkwTjhtNFZqMDR3V3p5RlBQd1N2?=
 =?utf-8?B?NFgyS1pSU3NsVFZPL2kyL2pKbW9uVk1DQzJCa3ZTVm5pKzBsTjNXTHVLZ1Vx?=
 =?utf-8?B?dno5bVlMSlEybTBVd1RyVENrRi9LQXB6Wjh4NGRjblJHMU00UURFSlpQQlNW?=
 =?utf-8?B?OFhRc2JBSUJ3V0NCZ1h4bzkyV3pUZ05TMXJET0hBRDR2VUdOdjcwbys5cmJH?=
 =?utf-8?B?WWdtekFUbVJyQUdiRDhSWDB5RTdiMnJmTjI2TS9vMGJsekJ1NXpPOTF3RzZ1?=
 =?utf-8?B?S0FQa0RoZEdoY2d5TTRVSWpwM0VXRE9CTHFuUVhKaXBQZ0pKMkZsZ2lPeVNh?=
 =?utf-8?B?WUNENUozamdkWXorWUgxekJvSHVGb21DUSsrM0d3REtKRlNqUkpCb3pTK256?=
 =?utf-8?B?bk9SMTlTMzh1cG1HQVdtTVpBdXNYcklxMkhFUjZFMkRpc1ZTRzV4eTdLaWJ6?=
 =?utf-8?B?MTE0K0hNRGc3bGZyaTQ5QW9tcDg0TzJjNXdRSmI0ZUR5WDY4bzZScTJUaHBl?=
 =?utf-8?B?S2NMRFVyZ0NEL0o3SHJITEhaTzFXOVZBdzF3MWZlVXVmVGpPN2pVRGtiMnhO?=
 =?utf-8?B?d1lRTlgySTFUaTRPd2JWUG12V1J4ZXUzZEdlQzZXU0xqeTMyc3k1OW04R21F?=
 =?utf-8?B?QmxmOVRmcEJIMEMyS0txYmdKejFadVRaSi8vUXV4MzFuR1hrL3FUai9TTWQr?=
 =?utf-8?B?RjU3T2tsMkV4VUQwVGdDaHNhUytQZXZYRnd2aW8xenczaTNOK2J0ZjRac3Bv?=
 =?utf-8?B?Rm9aTG54a3hnNjVTN2E4UDMvZ0RZd3o5RnNFQzVNbGhiZi9uMThmNXR0alpp?=
 =?utf-8?B?VjV3dXRrdjdVYmZMVGZuUHUyT3Njci9LcGI0MHlOQVJmSDFzKytWT0c5d2xR?=
 =?utf-8?B?Y3B6ZlAreFVxM1ExcGZMbVc4UlVzdTE2SmdDcnFOckNXTlVPY0lPUU1CRlll?=
 =?utf-8?B?NGFDN2d3alVRU2E2SU1pazI5L05FNW9ualVSQ2FXanU2TVRWZTQ0SXB3UHNH?=
 =?utf-8?B?UDgwbDQ4K290NUFpYjhIT1gvR3diRXRCMlZsMDd6Uk9VMUtCWmJaSHlnZWhM?=
 =?utf-8?B?cWJwQmRkUCtEekI5TnU2c09MSXA1MzBBVnVLZU80RVFheTZtVWRtU3JRZzgx?=
 =?utf-8?B?NnpCL1ZqLzZKSnlPanNlMDRiclNidDByQVJhdVdIV0dRYjFWSFR1eEphSWpH?=
 =?utf-8?B?VHFLNFp0a2JhSy9DaFM2NlYzcFpFdDdKWGQzSFNJNTA0MjVqaHBHUUc4OHdL?=
 =?utf-8?B?RFhLQ3lzSXBIeVBpWEdJeTRUOENNaGRvdUFzZ1FZZy9HNzI4OGxLVWJWRER0?=
 =?utf-8?Q?arcUvRhYK1LT4yfzLgrep/94EZay2G/sTsOxx2EMN/Ao?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 629e0651-79ef-4d1c-1996-08dd137c7d59
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:25:55.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIsgJuLR/7CGKaLlQGFDwXx1yojBsMdSJ8w2bwa+l75rUtfWQWV7eedhAn3Sv5labwQKZBsKxbGsUmbx1DeBzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10607

On 12/3/24 08:35, Dimitri Fedrau wrote:
> Hi Antoine,
> 
> Am Mon, Dec 02, 2024 at 02:07:15PM +0100 schrieb Thomas Antoine via B4 Relay:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>> +#include <linux/types.h>
>>  
> No need to include it, it is done by <linux/i2.c> which includes
> <linux/device.h> which includes <linux/types.h>

Hi,
Will remove for v2.

>>  static const char *const max17201_model = "MAX17201";
>>  static const char *const max17205_model = "MAX17205";
>> +static const char *const max77759_model = "MAX77759";
>>  
>>  struct max1720x_device_info {
>>  	struct regmap *regmap;
>> @@ -54,6 +57,21 @@ struct max1720x_device_info {
>>  	int rsense;
>>  };
>>  
>> +struct chip_data {
>> +	u16 default_nrsense; /* in regs in 10^-5 */
>> +	u8 has_nvmem;
>> +};
>> +
>> +static const struct chip_data max1720x_data  = {
>> +	.default_nrsense = 1000,
>> +	.has_nvmem = 1,
>> +};
>> +
>> +static const struct chip_data max77759_data = {
>> +	.default_nrsense = 500,
>> +	.has_nvmem = 0,
>> +};
>> +
> You can get rid of chip_data by reading rsense from DT and moving
> has_nvmem to max1720x_device_info. By doing so you don't have to rely on
> default values. Either it is specified by DT or by rsense value in
> nvmem.

I guess I can just get has_nvmem by seeing if of_property_read of the
rsense value fails. As long as the binding is well defined as to not
allow a rsense value for the max1720x, there should be no problem.
Will do that for v2.

Thanks, best regards,
Thomas

