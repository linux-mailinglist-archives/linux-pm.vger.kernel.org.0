Return-Path: <linux-pm+bounces-18355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D79E0928
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 17:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FE8B86099
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9420B816;
	Mon,  2 Dec 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="rMMsHpuH"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580520B807;
	Mon,  2 Dec 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150573; cv=fail; b=Mxt1RdQlKIDo/mhtgKNGLSl/U6tdvy7uk7LF55CyqdMpku4wLMAUrmVqntV0KtKuM/bJ3l+bz84RSWGsvlszA71ezg//l+cNrydX9+GgBCJCGFaD5wh3n6qCk0nGnQwlP+r9ps9nEHtkezqAt5MZZjjUz8T3NQ+2ya2cwGgg1sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150573; c=relaxed/simple;
	bh=ZBbYh71JjxejKgkq0rWOlpl/J75SLcJS8V0iOe9DnL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VDeR4ej9ogdoUWBiVANud4LR7CXTxJQqkWj/V95AiP0sVejDFbeIvY0egqNuL6BUQGYnbYQDvKdSymmrNUSkWrhXhyV261yRonUzg61nR98tiflYxmpGws2dLOZF8dAmOL/WOOmukfolqWqhZLeeRtAoJzcJp4bs6fVWG/REHoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=rMMsHpuH; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3PobZePeTbYWhwDT0nk5fnDel+0VCAj5V1l70hBiAKQw0OOk3v4b1n6Xeh/mVF+hbDT/AWmO3k6l5uYAny4QRLDCgcQJFtEFI3ff/rTPul5yqL4F1vakast4/v9mlPQrRCgJ6Tbdn+4esMHyWv0RSic2Dl/nC6WWxhDVi27lwfgU15fo/fziKEJO750YP74Al80/ldpceN/+nEDgQoJxBzI/CL67zOe0rDdpFr7HlLafUwUqGmadY6Ek68RTHaEBK/PhIz3bNyg++B9rAyB67n8ZlxrrYt1WK8ugqUIeMA93N6DuQL9v0RXVbpdYzc+XxB9OxSFLUgEguXdpyU8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lpXdAgOZAqZ6oDmRVoSx7f16hB3VK+FqAS6cItwOqU=;
 b=DppDyNjeJ3ev5pwML2YaGgLtwOQUIw9h16DxtEiadzFZ/fN1gEMfAxFjPT1gHF3slOenb4LhV+X/JL5HKKdCI1lN50vUugOWWnFXghjz1OQaxznU1BTz/gtgyfuw3FL/Irflp1dJJEir8JRWqPa4qwTa8f5j3R1ja5zJVjka1lz1b8EY9XtLXqnRzDwsDI7Gi6lXNxsa1xgdIrZ7Mz/8WneDcdB2kRRvLP57tuRRshadWNLTxQeDtgy+krYfuK5Y2SVe98JKNZLBu1vrEPJgq5vZv/z9ggwO7bIb6eQTUBsTTdUBxavdzm2cTwlVWFHYtIP1lqUYGFgRMfDbPAWl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lpXdAgOZAqZ6oDmRVoSx7f16hB3VK+FqAS6cItwOqU=;
 b=rMMsHpuHIo7sUXkqdCWYPvN5OmMf2QgL6/1xOZ+LBjCZDN7VgY3ilpfMOEIvWUgoyJQpmlIQWjkNeoDS+vh4dneioxaiuVzWbg6B5YbgD44pi2bEIcDXNX++P9rG9vOg6pslRhTv4k6ykMtsqR6LfBiozgTgZq8sAuW0f4iEvRaVrchVt0t4DIdmDADI5fWXmx987bu88CkXWVUk7Q16pZwdsjbZT3PHdZfSVmBfkyTnq+0Gl664x1UIaUciZwoh94x4mo0M9X+qAwvTVsDcWRC0jn0roLWnAI6EwwCprzNK0n3QegJ9IfysUTYFhKLDqElJyoel6+l5MCLNMZYeDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by AM7PR03MB6230.eurprd03.prod.outlook.com (2603:10a6:20b:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Mon, 2 Dec
 2024 14:42:46 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 14:42:45 +0000
Message-ID: <86209e69-6eab-4a93-bbb5-6ee98d6bc83f@uclouvain.be>
Date: Mon, 2 Dec 2024 15:42:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor
 and don't require nvme address
To: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
 <ec4bd953-1cd7-46bc-9415-0983bb9cbe89@kernel.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <ec4bd953-1cd7-46bc-9415-0983bb9cbe89@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::19) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|AM7PR03MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae71325-0f46-438e-8b24-08dd12df95bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3RHV3M1UUxFd2hha0JuWUdsdW94Kzc0bDAzV2dqcXBtL01rbTc2bnRSRTlC?=
 =?utf-8?B?Y2pzOGFhV1FsNXBrRjdFNXlMcW53aytaaTlqNkhMR3NNSE5PR0RIMnFseDFZ?=
 =?utf-8?B?MVhhbGRvQjhzNTQxa3dnVERqeUhUMnlma0VxY1FDZUR5bVRaTmV2RHNXMUcw?=
 =?utf-8?B?R25zam5FMGdnN211QVRha0pNd0JBckozMmtvdWp3UW9iMDFVYmV5dUtmQzRX?=
 =?utf-8?B?djJUYjlPT1A5ZHpmTHdwTGFHVC9aZnVXYUtWKys0QXgvVVpKVWhDdS9VNzNs?=
 =?utf-8?B?bmgyaSswM045RmNUbkFsd0M5eWRuZGxZOHBOeEZ3NTdXYXFEc0hXSk1CVzNp?=
 =?utf-8?B?ZWMxcnRZV1FiM3VBYnFzbStIUnpoTGdJa09sdk9hWVJad1BqNCsyVHJNT1NX?=
 =?utf-8?B?YXQ5ZGEwUklOK2FVV1JIN3VXeExVb3Y3d0hQUGJwR29lZUlJRnVES0pyZlFQ?=
 =?utf-8?B?WDRhbXpUOTMwc0NrVzJlM1NONVA4UUZqL1pGOXA3LzAzYjg5Q0g2OVFVa3ky?=
 =?utf-8?B?NnFXNjRLOGJzRUR5cjNJLzltazlBZGloT0xvdTVFM2dFR3B0WDIrb0xrSVlC?=
 =?utf-8?B?cExsMzdzYmgzcXNGZk5lZjBaRlp0Mis0a2ZOaDY2Uk05ZDBnUmx6bkpKUHFu?=
 =?utf-8?B?MlRtVWdJSThkblNWL28wRzM1NHZzVTNMVjRmUFdOYWdCZmh3bEZTYTFQVldG?=
 =?utf-8?B?Z1o4RSs4RktaUlEzN1dyTFN1aWQrVlRFSXhKejlYZzlTK2k1V0VXR0ZTRVlT?=
 =?utf-8?B?MEJmV1Z1V0VZV2hJd3hQcWFhZE9LMHRYSEJqZ1VyRmZRQlJoZ3RlcnAvOXhX?=
 =?utf-8?B?ckJZUExkaUM5Tzl5UzA5RmFvd3p0Ukg4TlYzcDZzcm44R2ttY1N5TUtWWk5S?=
 =?utf-8?B?SW5oY3lYVGJXRjBjZEZ1MDRiOE9HN2ljZzRWdHVnSlZuZjdsRHlPTFBzalpY?=
 =?utf-8?B?Um9BTGdzZDVFaXFoaVNzOWhONGtuUy9XemdURndtc1gyYUJlMkdxOGxUdkZp?=
 =?utf-8?B?alliaTdJNjRpeERRL2NQQ0JqbXZiSlhBeGUwSVRkVmVLbC9PK1FRbUpHdW9k?=
 =?utf-8?B?M1ZzdVJzcEs1V3hkcTJBajdERktZWG1GVFRsL2FEZHBWQ2I5SlM2dmxBazZy?=
 =?utf-8?B?SDJxWk9XeDV6eVg2ejQrZjBQNHZJeFREQzlUWStQRGxhSFhxR1FjUjVrRXpv?=
 =?utf-8?B?eWljVGIrR2NmT1NSQjhHL2hoU2xEWERyTWJWZjgxZEN5SGRhYUJGc2czelNo?=
 =?utf-8?B?ODBtSWs5QzR6MHAzWDNwRHZUZzVGeGZIVktuVmdEczR6UUtLVy95cU9CQmVQ?=
 =?utf-8?B?cEdsbzhxem1HNnNWU3lLc1o5SGpPczRiSHpPMXBla3p3RWh2YWJvNkEyNkhV?=
 =?utf-8?B?cnZnV0YyUTd4cE8yQ1dEaUZNQURGUHBnbEpqREM3a1ZuL2c5NWhnOHdtTUhi?=
 =?utf-8?B?d2s5ZnFRRXNIbHJpTEtKMGx0ZkI3MVZrZitBUy9XNlBzb1BZMXRZOXkram56?=
 =?utf-8?B?ZHp1TGJSUTllOFZwM2RKczVSUHZYVGxWTksyd1VFWkNOWE5HVVMzNlRDYmJG?=
 =?utf-8?B?Um93QTh4WmhIY1B1OTdhWWp6cStPd1daNkVWSVZldUVwUU85N3RGd1FPRk5J?=
 =?utf-8?B?TDdUMnBUY1ZXRzk1VTl2VDNYQStXc0dDQW53eW5kcEVMdTBxcGNSRjVuZ1o1?=
 =?utf-8?B?LzN1QS9hQTNBMmIyZ1N4QVc1OExIcHpHSTJhRW9mdTJ0a2RyLzZjRGYvWHJQ?=
 =?utf-8?B?Q2hHL0ZSQWEzSDk1VDc1d1V3d0paZkIvZlo1cm1mUDhzZm80b1FwNThWVzRP?=
 =?utf-8?B?UVh4RmZaS3NhRXl4bndDUWVZUnFQYjdkQVBUdStvcEJCSlFKQnRmMHVwSk5T?=
 =?utf-8?B?UWxPYWJjNHNHTHNWcFljZXlYWmZXR1NZOENJd1lZN2s3dWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkNFWEJvZ0g3S21QbE5BQ1V4ZUM2QXNCaFcvalNiNFd1QVdTSVBGOVdPRERy?=
 =?utf-8?B?ZjlHMHNpUVhBdTlMQS9LeDh3LzNqa3ErSFNCZ2QvMHJrTXhZeTVNWVVzU3ho?=
 =?utf-8?B?YWVlemJTMGlXOXNid3BHRkQ2T2V5bkFaVi8yam5yS1dPVTdqRzN2ODMyaU9B?=
 =?utf-8?B?WW1ZREp6UzQ5MCtXV1ZXT0xONXVDZTUvMjNhMWdDSTZZRWlZVG02UFNTNndt?=
 =?utf-8?B?SFRHVkxyb2lsc2piZXZsUjg3dFRyWkNsYVRtcWIyWEt4dU1QdHFsV2lXSEJN?=
 =?utf-8?B?dnNSOUZaclpHSzZ1REJJWXArN3dyRmtzRys1Ni85VllaaFVFSjNBbCtXNThi?=
 =?utf-8?B?anIyK0dKNi9LYUpqcmJ0SUluWEk5amZ5WnBsTVBGeUtwNjB0ZVpVRlZIMUtZ?=
 =?utf-8?B?WGRYb28yUXBrN01ESVlxdHRJOVdQOGpxUWpYKzRWRkdaN2Zad015ZlNsZkox?=
 =?utf-8?B?c3Y3REJTUFZkczZscm5jNjRBanAzY0JYV0VveHFSVzFSNWFNbll3R2FvSmtw?=
 =?utf-8?B?QnFlMkJOaE9uZ1lUeG91dUh3RzAxNDZtV2l4YjIwWk9mWCsxMHl1aCt6TFdD?=
 =?utf-8?B?TE9OUDZxZ3dVVDZBYjBsK0xyazVCcmJrVzJHV2ZTbjZSM0hQV1pxc0lLeWty?=
 =?utf-8?B?N3ZBTm5wRmVMVjdVb3JrTEJPZVpscU1sTVhTeFdxTzdFc2RkeGlaMTBUWjFY?=
 =?utf-8?B?VjJBRGZuTmcxSlBRd0o5N2hQVVVENy9VOXdET1ZBbkRaTVlGT3JQNENUSGdK?=
 =?utf-8?B?RnkzR3R2ZzFZZ3RQTFA2cGczNDJldis4YzBxdHpFbmxJdDQ1VnF2NnA1MFBi?=
 =?utf-8?B?Q3hiVUc4cXFFakVkYmxBTzZWK1dGTFZna0lZbzlKZlNUSGZaUEVrSnVweFBD?=
 =?utf-8?B?KzkyYXpIV2JlTVJVVG1TL1Q5RTRNWTlncU05TFkxVmhDN3FrblpoajVqc2h2?=
 =?utf-8?B?dzhoN0d6K0xpZUFZUGdESU9WMEJSeWxZNk43SHMwT1lXNWtkTzN0WExNZmho?=
 =?utf-8?B?cmlFc3JRbXR2YmJiS0tma3Njemo0elp2ektBd0JqTWNoM2NITCtieG9RTjhN?=
 =?utf-8?B?Z2RyWkVQZDN2MWNWd2Z6ZU9qSGI4NXg1STVHbjVKeld4MEh5ZUF2b0ozTzNE?=
 =?utf-8?B?cDFIbFY1TEErVWJjOWcyS1BiQUc0VitaTWo1NjRUS05MN3EvOEpMZ3k2dXRK?=
 =?utf-8?B?NHFYakNuOEJYdE5vczJPY2RvY1AxeVVKRWszbkJLVHRURlBkVlBtN0tDSzhH?=
 =?utf-8?B?ZzZyUENtd2hwdlJXZjNMRmJUN3lEOG1pTlZFcDMvMzZBTFptdFdDdHNVSEl1?=
 =?utf-8?B?VVpWcHp0RFovKzJHZUVzcmtDcjJXaDduOFhCdXpWTVkrRW0vNStpRjI2Nkc0?=
 =?utf-8?B?Wlg2NnduQkd3djB6NkV2YlhFTkpxbFMzSzd2cDVaV0VEOWU1aTVNMEJLaXNL?=
 =?utf-8?B?ZlRiYkhxbExwdlphNGdZN1NyVzM0RDBpZFNKb2F3V0dZcnlaKzRONUwxdW5a?=
 =?utf-8?B?MnV6Ym9KY3Z2TWM2OGlyRTZRUllXWGRRUVEvRWlZY2hZQjhobllqOU53aDND?=
 =?utf-8?B?VlVkTDlGZ3dzeVhjYmJKb2NMUU9WcGhvRWNhWE9JWGlXSXhqa0IrVnhoRDdM?=
 =?utf-8?B?aysydjFEcUJRTXVJM2ZFaDJZL3JoekswSCtwK003VmxZMzdISFpvQWlUeVc4?=
 =?utf-8?B?RlpNb1NJZHJtU0R1aCtiNi9RK29aK0tjZ3JVZEg1VG0wQ1VuNWs4bUtvZjJn?=
 =?utf-8?B?bUc2RDNFeUxraGFnZi8xZ0E0R0NVY2RESkU3VG5OMmpKay9TVCttVEF4Q1Z2?=
 =?utf-8?B?YmJZVzB0V2VmWE5qWlllZU85ZXk1bzNFcEZoV0x6ai8vMjF0dnorVmVjTEVO?=
 =?utf-8?B?K2Fock4xSzA3YTFKUXo1Slc0VUhhbGRRd252TW9QSGlqRWtDSEkzTCttOXc1?=
 =?utf-8?B?cmdTaWw3RmtqYlQvbE96b1NaTVM3R1Y1cEIzUFduQ3V0Ty8yeHM0ajJhQi9y?=
 =?utf-8?B?LzNDMUJGRkRxdUtqS0NSVldLaHdLNGZhWFovc3RrNFliMFM4Z0VCNXU4eGdR?=
 =?utf-8?B?bWZ1emtNUXZlenFtUTlBTnF0UTY5K283anNvbjNuYWo4NTVNT0ZGZGRESFhP?=
 =?utf-8?B?V284UitpQkE2eTcvZDlTVVRrVkVFeUtaeHhkeVZWNzdwNU1hZGcrREFJV0RK?=
 =?utf-8?Q?ZvUn/TdJPMT6duRxjVwXQZOhMRgpi1FMfjzhdkGMQtiM?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae71325-0f46-438e-8b24-08dd12df95bc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 14:42:45.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvBxwI3nSUYH+Q2j3uI4F7R3Jwpo8N/Euyz8o4nSTbQsIx3OWg8326xPqVJGra9ESrviZpdvc4bV7Uelgfqelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6230

On 12/2/24 14:39, Krzysztof Kozlowski wrote:
> On 02/12/2024 14:07, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> As the Maxim max77759 fuel gauge has no non-volatile memory slave address,
> 
> 
> s/max77759/MAX77759/
> 
> Please explain the device in general, e.g. fuel gauge is only one part
> of the PMIC chip. Otherwise 'fg' compatible suffix would not be justified.

The max77759 is an IC used to manage the power supply of the battery and
the USB-C. Based on drivers from google, it contains at least a PMIC, a
fuel gauge, a TPCI and a charger.

Given I saw that the linked proposed patch, which adds a driver for the
TCPCI, used the "maxim,max77759" compatible, I didn't want to create a
possible eventual conflict.

Link: https://lore.kernel.org/linux-devicetree/20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org/

Will add this information to the commit description for v2.

>> @@ -16,6 +16,7 @@ properties:
>>    compatible:
>>      oneOf:
>>        - const: maxim,max17201
>> +      - const: maxim,max77759-fg
>>        - items:
>>            - enum:
>>                - maxim,max17205
>> @@ -25,11 +26,13 @@ properties:
>>      items:
>>        - description: ModelGauge m5 registers
>>        - description: Nonvolatile registers
>> +    minItems: 1
>>
>>    reg-names:
>>      items:
>>        - const: m5
>>        - const: nvmem
>> +    minItems: 1
> 
> You need allOf:if:then section narrowing it per each variant.
Will do in v2.

>>    interrupts:
>>      maxItems: 1
>> @@ -56,3 +59,14 @@ examples:
>>          interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
>>        };
>>      };
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      fuel-gauge@36 {
>> +        compatible = "maxim,max77759-fg";
> 
> 
> No need for new example if it differs with one property.

Will remove in v2.

