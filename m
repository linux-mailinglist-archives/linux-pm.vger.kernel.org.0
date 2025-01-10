Return-Path: <linux-pm+bounces-20254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9081AA0969F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E229169C10
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC05212B0B;
	Fri, 10 Jan 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="qqwv+GsQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2134.outbound.protection.outlook.com [40.107.21.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727620551F;
	Fri, 10 Jan 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524970; cv=fail; b=aVKYQQZ9LX3FTHLGCfZLkVwNdn7XQDJXfhW5hDj7eQS78KPbLWkAjEMUI2QgagroNjoDWnkrzrhxrqfqxeMuLeOmx5z7iLxYcY31CCmYDdsLSspfplMZmRVMqPqWXVwkSGRYChWtEELuy1iLZC2/0hcZYw2xkaLQVzcBN3w9GCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524970; c=relaxed/simple;
	bh=MR/7+gOnHI1UwCoX+7lT9AwCEJIKc18eXZYsWQOYrLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdKlf0v5wMgq0vQCJXMiu2k4foOawtlH8JviQsJgdLmWMQKExSKbxg41EPopLFx/l1B5LepfjTOjfav6uz08Gs5BMSjyy4o65sPiFnI7DOhr1Uc6D+YF5IIaFeZyJj8rcyXsdi+8GKvC4KdQGV5/JAXx+RK9Y8NA+hSWUyOeJuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=qqwv+GsQ; arc=fail smtp.client-ip=40.107.21.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVC05bFGdrw0bfGf2ymNG6C+55FFpJ5oB0EQY3K5F+/Muzr7n0VNyE5+JWoa9ELp7HExh7VVirTWo/inWJ+twYDewC/Nx2KHxW2U0yAtm3FDK2qr2TcayMbeZ+WKBaJBctFTp1pfaHKfRDONsjCZOUYIIFG1DdiRr0jiolZB1qimIY32Z8orYgBk2MJGk+eiEBDbP5iRzVXPlABEAGEhhoj77bICvByp3vGy5DFbLTx+6t0CkKjQx/zo0iPuQ1mTIo0i6JzvrQj/ZyoGgjOfaZN18t08fK8/CLPtDjAL29PXnErud5h0Sk52qridt1LSznFQk/okZc5fn3U5RI+YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WJu96O/Foeoq0LDg8J777tygevW7/kv4zQea0jFzs8=;
 b=O1YNV1xymrCAV/RPIek04lFDlbDFllYP96coVZIiX+rq+VVjpIVME8jhFadvl8GswAwqopzqEY3nsk7jbUwHuOK0/c9fEVYcdiHKXYX6ux2g8xVNNPhZpOAAmKEIZ8fu9Zvr5/ScvB3CwhWua07qbVtbiGd6RiGw7ANhIdIIP8vimYDSqde+PCH0/Uy7ntJXzEhUaU6R3dRUOLKemCV65bXzsl3xERlxHEfYIaTwOYSHiBWrhlLuhrUWyygmE3bKXo58RFgw2JgAYwMw3ATCaDJXTkKkr4dNXwT0FoUkvHAQob2uqgei3l84EO+omsoVhTSujbCH+GQSu+myhw1M4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WJu96O/Foeoq0LDg8J777tygevW7/kv4zQea0jFzs8=;
 b=qqwv+GsQiAygAjfUPJ1wEhe2nMs0qYXp3/6EqbjP7s8Hvfp2IfrgQI7vmdjMRnqb4Kfh67AJP0ebz9HEQ93VbR9tkTKchLzWCLewHUtt9mkVgcuEIGzxlhWwG0eYjwDLggKic5fYTnJ7XoXMfKsU2xQR3V6hLFlY0194hG3PDf7v1IE8d+hCMv/5Dbmr0d3x3D1nrEdROLibG2Ycvg/yHouWCa6blcBEXVveXufj5ZEozbdHKipxA4PMDTikeP83/As9at5pfPlD7AZbCQfiev0/Jl2xLesvSbOta2Avs6vq84uDgmrvQHs31SPS66i+ltlwsMlXJM6WKl3P3CyuXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DB9PR03MB8284.eurprd03.prod.outlook.com (2603:10a6:10:30b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 16:02:43 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 16:02:42 +0000
Message-ID: <c28c8894-125c-4d1f-bdec-16977cc98e4d@uclouvain.be>
Date: Fri, 10 Jan 2025 17:01:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel gauge
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
 <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
 <20250106151651.GA14942@debian>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20250106151651.GA14942@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0183.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::15) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DB9PR03MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e68335-608a-4635-5a98-08dd3190369b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU04ZjIrM21Hd0JGYjdUWU1ub1JjVTViWGRUVDUrQ3JLdGVmVU5kSkt1Zytz?=
 =?utf-8?B?VVJtZC9lcnRoVElmSUZ1ZSsrR0lTd0FhS1JwQmtPenVUcWdtditMSGFjcTVs?=
 =?utf-8?B?cmZxbFJvQWFnOUs5VHRwY0xKWmVqVm9HQmMxeVZWK01qTGQycytveUo2TGtN?=
 =?utf-8?B?dytWWWV3MUFDZEU0ZGNJUWxTVDU4cmtVVFRJNUxFNDE0WExsbjVibVFjbWhI?=
 =?utf-8?B?RzRuZGMvTDBzamNFNGZ0ZUtpQ0dZTVFubHhFVlhuek1SK2xHeThLUjNpd3JU?=
 =?utf-8?B?cVJBdTdNUnlDdDFUTkUrTHB4ZTlWQUxNbWY3TXpQZUFVYmw3Tm9RMlFFV2JB?=
 =?utf-8?B?cGtIZlQvYWEzTHZpa0hZMDk2Vk1CTFNFWHJKc05QSDBhUXpRMzdpbnkrdGh2?=
 =?utf-8?B?eUdicTdYclNPeEhHU3dtZ0pVNFkrMkFwVTI2Rm93UHFCUjgzM2xGbytDS1hi?=
 =?utf-8?B?bWYyYWpTWG9lNS8xNkZLM2dYQW5VSldyK2ZESEREL1U5S0RnbngxTWduMVhY?=
 =?utf-8?B?aGhxMmFvcEkrbVo1ODFTUFFyV2VQeHhGSS96ZXZQZHVyVzZ1NnpiUnVYZFZj?=
 =?utf-8?B?UGV5bGtmaXdMVDUwcTdKNk85T3l3ZTl2Y3hpVWVWeXliNGRaRVZlNWk2SGJz?=
 =?utf-8?B?NEYrZmtJaWdnTWltZmtFdWs0bndlR00xdFlDa0h4b2g4OUV5Kzh5Nmc2RE8r?=
 =?utf-8?B?U2NGbTNtclUxZXoyQ3JJOFJEbjVpOC80c2lGbjJwNTZaM1hXYUU1dEJqbEU2?=
 =?utf-8?B?b295WWw3ZW9hU3NXZG9KMXJ0SjlRTFRCRXRqYmxHdkhpZEZKSU5GcnFWN09v?=
 =?utf-8?B?Ym9yNFNPaG5kaXRmckdTdXZoNnpHMG1RUkk0NEtrSlJZc2RjQjRveXZ5U1VM?=
 =?utf-8?B?K3dyQXpCRWZUNnFoeHNFQ1N6NG9yRVZFV0dKaEUyWWxpbEJOVzFoUVA3TjVJ?=
 =?utf-8?B?aEQ5QjBaN0ErRVJsdkN3eEtWbkVITlNlN0pNdjh2em4yNERsL0szRUJSdVRa?=
 =?utf-8?B?TzV3V2pJd1A0ZzRSSGdQdUJDM0M0azhhQXNWc3Y4bndYWTJVQ3hWQmt0em51?=
 =?utf-8?B?SHBGQmRwWURkQnJ3eHBiS090TmZZR0pOSSswRkNWRWhNRGs4bzJVdmVBdjhP?=
 =?utf-8?B?ZHFtSTJ6RVNFVHFNelBTcUNlTFB6VGwvZHhTdWlhZFNMQkExWkNaL05Odmty?=
 =?utf-8?B?aWpxbi83QzdWeVgveUd4ajQ2TDYvOHcyYy83aFVWejBUN0Vpa1B0dVk4Qk56?=
 =?utf-8?B?R25kTzRIS1JwUm0wbWR1aUMrN1RKYVRzeTBKVGZ3QjJxa1pRK3RIaUN5U1pM?=
 =?utf-8?B?OWRraUc5WHQzbm53ck5lQkJvSS9GcWtTbTh4U1ljSmd6MnN5cjdrVi80cGdh?=
 =?utf-8?B?UFFoUDh6VVNnUmxRTXR0bEhZdkwxQ1QxUlRYOGFUN25kNGo3Q2lVSGJHdkxP?=
 =?utf-8?B?TUUwOW41akVXSkpBU0srVm5UY0I0N0prWUFoUWNJZEt6SFJBODJYSmJIbXI4?=
 =?utf-8?B?SVFuN0JseTVlSlBOUEFyZ0hLUFgydC9SeFRmTnRJMXg0L3ZtN2pSd1NyS3NR?=
 =?utf-8?B?RmJFNFYraGIvbE1vaElQU09QRUxTcTk4NFFvVXRKb1J5YVV4SVc3SEdlcHNC?=
 =?utf-8?B?Uzc0a2tKVCs2M1dBbElMc0hvckRKS0RpbWIzVlN0MzR4ZW4rSnRuWURaUW90?=
 =?utf-8?B?WE5rOUtzSC8zOWVKRzA4NVc3RGMrb2lpODZJckViRTlnME5PWG9XMjUzcVZq?=
 =?utf-8?B?YVRkMXMxaTQrSzZ3dlBsZmpHN3FVQ2lVMHhCME5HQ3B4amdSQ0VsK1dyMUdo?=
 =?utf-8?B?QVo4RER1RzRxbStWeEVyTkNkU04xRW4wSE5NQUd1aWJSbmpMYzVFOTdMWWc3?=
 =?utf-8?Q?cRWRVJMCsy97W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2k5N2JjUlNSODhrbE1MMFRCWTlaK0JRZkpObTFRd3ZNWmNKenF4Z0tYWktm?=
 =?utf-8?B?ZSs4Z1Ixb1d6WUoyRnNOZWtlbjFpNUV5UjJXbWEzMW9GWklkQzZCRGN1czYv?=
 =?utf-8?B?d1lXY1RlQlQ2WThOdHBQZlhRaXE0YitQSlgvTU9WMXpWcHZVY2Q5T3c5L1hn?=
 =?utf-8?B?SlVjK2dyZWRkWnhONkVYcG5JSmo3bmlHV3A0V0szOGVMcGhpRkNOMEhLcEVG?=
 =?utf-8?B?dWxJbExhSWNZL2dIbG1sSW5WUlBYTUUwVW5OeklZNE0vUFIrbSs0SWRwQXgv?=
 =?utf-8?B?L2tPalBTbEdCeUdKSDdYKytxMHN0MUhMblhjTEI5VGJjTmpDOXY4ZzhVRGVB?=
 =?utf-8?B?TGlHbnBoa3VSNmxUenM2WHdIbmVPV3E5Zk9lbFAyRjBiWE0rUmkrRWxNVllP?=
 =?utf-8?B?WndLMVRXUkhmNFRwMExxTFJXVG51SWxWRUJYeXVPVnE3NHF5azVwM1lqbmRi?=
 =?utf-8?B?UVlteTAxNFFhVGRMcTRwKytEZnIxNlNSV2pwamhYU3hGclIxSW5YcHVFNkd6?=
 =?utf-8?B?ZnZqUE1WYUhjdWd2bGdiSENXc1hKOUNScVdiMGdYdnVKdE9IMGFjQk9FQkRQ?=
 =?utf-8?B?cUphaVNDcDQ5Vmh3TWg3aXpReUpiTUFsd2o5aS9YZnQyMy9nVjBXTm5vOHVq?=
 =?utf-8?B?VVlWQVhZT1VKOUh0MDYvQWtJa0lpYzlsWkpsVVp3eWpVb1gzODJaQ0JFb3Ru?=
 =?utf-8?B?UmxlQ1VPeld2akI4ekFQZVlmbDZXQlo2N0tQMG4ycmxiTG1OZVRoOHp6MG5Y?=
 =?utf-8?B?cTBzK2o4SnMranl3enJabEFSMDhsd2J5SFVWS3ltUmk4U0wzb2IzUVFmYStM?=
 =?utf-8?B?MUQvQ1NQd2dmRmx5Sy9ZVmhCV0k2MUUrdXpEZHd4ZGtJUjg5cURlRE1VT0FL?=
 =?utf-8?B?NWJ2THdaMmREaTBoeWxvWloxeDZqWnlkOHJrUGJUblZOMmhBTzFiNng2K2d2?=
 =?utf-8?B?OHk3N0xQUWx3bWM1MzJZR1ZRL3FuWTQ1NlQ4dTliYlBCZU9lTjZEc1c1MHRm?=
 =?utf-8?B?U0ZIYVd4eW5FZ2RrVlFFd3JJT1g0L1Z1cWM2SlhHVWVWSmxYbmxheThlU1lr?=
 =?utf-8?B?MzdReS82cWZvN2F3VnNhQkF4cWVvMFpQUmRVVzJrdFdKNkMxMXUrVmxRWDNS?=
 =?utf-8?B?SExkT3ozNlozNndHYmpkSUFDTGgvOW92MTM5UGVINldUZGNEb3BDdlVpTWx1?=
 =?utf-8?B?eFg4eFFqaFRXdVk5R2JjYkVXeHc4YkZLVnpMTE13N04wTEJnSzAyNzltaDNz?=
 =?utf-8?B?dTlkSDlkazVPNnh4MG1OeFB0UlhvNzh2K0JNNDE5QkpETzNBazRLR1J5QkpY?=
 =?utf-8?B?UEhGeVNqOXpXYS9YUzMrRklnNE5OMTlVZWYvQkE2cVBNakIzNTRTVnpvZ24r?=
 =?utf-8?B?b0xXN3prUnRhOFZyZ3FXWGduMWo2c0tBWDhpVWJSaVdJTWFkRmdsREFuN2dC?=
 =?utf-8?B?dWpOMUJvUm4ycGRDdU80UzQ0U2tvRDRZVXY2RmkxTjhmUFc5b3FiWnpHbFdj?=
 =?utf-8?B?UEl2YWNLMk9WL3dVZHJMdVdKK29BMUg3RTV3dlFxWXRJWmI5djdpVS9mdXpT?=
 =?utf-8?B?ZDBJelV6V2pJVUhpWUFyZ2VUVkZ2VFdnQ05oWTdKQXpFT0NUYThUL0JXVjFG?=
 =?utf-8?B?ckswQWQwaktDRmswY3kzclArcENIQXk0dTVtdXBydURBQ1hmZ0ZqdkdEc2w0?=
 =?utf-8?B?dVAxN1E5bkh5OUlkZFFpM0l0QXdRNjlKV1lpcStWaWdDN21XeG4rcEtIaFk1?=
 =?utf-8?B?d1lNZFJ3RnUyUlo2Wkx1K2dyeUtxQmNTRUFXcldpY1U0ZU9BeVM1LzJkRTZ3?=
 =?utf-8?B?aStkVm5TTmtmMGZHcDVKVVRyNUt2N21WR3dMK3phd3VKVTdDR3JuU0pGSFRs?=
 =?utf-8?B?Y3FXUkNTQU4wT2p1OFhaV2o3MUlSL0diQnhWU3Z0aGxMdlJjd25pd05QTURF?=
 =?utf-8?B?SFpJN1pzakhIMk5iY3kzZS9NdGl3QTVDZFpZTW02cktTeEtUdVNRNCtTZktt?=
 =?utf-8?B?eWZuWWtYeXNoK2VKL3dHN016eklXZi9TM2JDVEdCcXNwUElmRlFOVXBwU1Bh?=
 =?utf-8?B?bUdNcGRNYndWTi9COUdadk0zcm4xaFh4MzVlbXVhMy9uVnVBV2VCc3lRbW1n?=
 =?utf-8?B?QVd0WUdFdGcvNzdjL3liVGRaTkYwd2NiZVRQay9UblMyUUpJQVlmdmVvRllP?=
 =?utf-8?Q?LV0F/5reRWatLEGsH3qwsPTykAIo9CIX76keXzluzvcp?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e68335-608a-4635-5a98-08dd3190369b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:02:41.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUt95F+zq39+clTGa3ZENZrKSEEAGu8dju1dNQFfTI7MG2CWHaN8Y4YM4coWnXNVLEPS74dXkyklb2wpeNnAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8284

Hi,

>> [...]
>>  
>>  struct max1720x_device_info {
>>  	struct regmap *regmap;
>>  	struct regmap *regmap_nv;
>>  	struct i2c_client *ancillary;
>>  	int rsense;
>> +	int has_nvmem;
> 
> Switch to bool and why is needed twice ? Here and in chip_data. Better
> keep it in chip_data.

It is useless in device_info at the moment, I'm not sure why I thought I
neeed it there at the time. I will remove it.

>> [...]
>> +// Use 64 bits because computation on 32 bits leads to an overflow
>> +static int max172xx_cell_voltage_to_ps(unsigned int reg)
>> +{
>> +	u64 val = reg;
>> +
>> +	return val * 78125 / 1000;	/* in uV */
> 
> You could avoid the overflow with:
> 	return val * 625 / 8;	/* in uV */

Indeed, I will change that.

>> +}
>> +
>>  static int max172xx_capacity_to_ps(unsigned int reg)
>>  {
>>  	return reg * 500;	/* in uAh */
>> @@ -303,6 +383,33 @@ static int max172xx_current_to_voltage(unsigned int reg)
>>  	return val * 156252;
>>  }
>>  
>> +static int max1720x_devname_to_model(unsigned int reg_val,
>> +					union power_supply_propval *val,
>> +					struct max1720x_device_info *info)
> 
> nit: Align with open parenthesis

Will fix.

>>  static int max1720x_battery_get_property(struct power_supply *psy,
>>  					 enum power_supply_property psp,
>>  					 union power_supply_propval *val)
>> @@ -332,7 +439,12 @@ static int max1720x_battery_get_property(struct power_supply *psy,
>>  		break;
>>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>>  		ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
>> -		val->intval = max172xx_voltage_to_ps(reg_val);
>> +		if (!ret)
>> +			val->intval = max172xx_voltage_to_ps(reg_val);
>> +		else {
>> +			ret = regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
>> +			val->intval = max172xx_cell_voltage_to_ps(reg_val);
>> +		}
> 
> Would be better to read the right register, since we know which device
> we are. You could differentiate like in max1720x_devname_to_model.

Will do.

>> [...]
>> +static int max1720x_get_rsense(struct device *dev,
>> +					 struct max1720x_device_info *info)
> 
> nit: Align with open parenthesis.
> 
>> [...]
>> +		ret = of_property_read_u32(dev->of_node,
>> +					"shunt-resistor-micro-ohms", &val);
> 
> nit: Align with open parenthesis.

I will fix those too. Thanks for the feedback.

Best regards,
Thomas

