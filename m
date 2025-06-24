Return-Path: <linux-pm+bounces-29445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9DAE6B8F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BD07A7AE5
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB617A2F2;
	Tue, 24 Jun 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="L3hnoaOH"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020077.outbound.protection.outlook.com [52.101.84.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69626CE1C;
	Tue, 24 Jun 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779960; cv=fail; b=hUU5PMwzdQW6knmUMLKHdwXGbY4CXTnMNsptBnx+DFeEi8ZxeP72gSnGrLhov4ndirFl6FUfbJtbUNZ+tugcNQa8RSliDVLhRLYywh760LCA0VADWsbATtwmsFYl7Je70q5TL4k0RiE/B331LHPhHeg3qBZps5Ts4s4u8nEKzH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779960; c=relaxed/simple;
	bh=c6jc7WEjLzifUqVTVDc5nzAZptRIvuSch01KO31SWvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nbw5jxy4ZJaZiUXPGcsfVnWDNGJh1FtbU/H3/tncU5s6/3oCsrmtnyDN4e9PudXA6g+Il9j85yLnQH9a4aNCd1ItlFVI92hLvIZviDtkLr594Ym/JUJXq0R4BXbOS9OMzbFopBZp5fK9k5eaYBmHsdVrxw/m5WE69/IiyTvL1vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=L3hnoaOH; arc=fail smtp.client-ip=52.101.84.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygKXR9A/YneLqpnsVF1VS6WFS2P9j4HlUV7hpyi2n45w59Awpzkh4L/q5O0tDHYRdkrZuDs+yb/5cBViYrjfUTZpP1XwVOMGAiNW6QKKJrMkx34XXuAlbbq2MdxFOuKwrRHFQ/x4idcau0SMTMa+runN8Ss/0+BRIEW98kgRnmptasZfnFXTyI7MtYXvHqenPpyIge2H7CqhS03OiZ2lBshki8lXcIe16skHiWy7BjMavu18xdnNFLXTlD2g+KH4SP/WHFzYoovIC4BtVyEe9AKJEBHZsYjwiXdzVurVpG3A6I3+1QHPJzgKttx1yrzVljwlqk77ya367NU/Dw9RTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoEsdSjzEZiEYLqPr7ngIF1UXlqYq6vibJs7zdtoOcE=;
 b=oLO8tmxn/2ElCfdgWQ8QKt1xLW7MSxGPhFJQs86HKH1DPZqj7BWhG05Tx5wDikaijsnma5fJLeiOpLGKnJX+O8KsPb62RtXoKbUwi5GVZDOvmY4quQ8Oqjekv7zA17ChE1Tvdp7CVCb14xkzYD/jpxBHJAc2yAVSpYdd6VmJ5DeRDhJSGvOGLMoUJNPPrN1sJZJDsa3vAHh7aa6r9QRMfL8k8wR1YRSqkx8XRaRnlLIJvjcmk7ER8uPkoDAlWoo+1mvKFYoIiG0n3wyfbCXsUZ9I1dkr3WrFcS+cS49QNJUo1fcFClpmxzTyH6hN+OCESVlPDc/DRiT9jCnqYMtnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoEsdSjzEZiEYLqPr7ngIF1UXlqYq6vibJs7zdtoOcE=;
 b=L3hnoaOHQsfR3KZD18PeszSN+ANcybA3zDoPIvj+//WltUyRLfF+DGcDSHxZG95p0SQfq1MkINx03WuajIJwMJlfcUC2jILVfUV09Y1o1SzxZgBy1mofB/FmessmgZuGAOD/+wcE6H4q1O1267MbJvxGjGEj8/wvAXsHeTO0Z9fx8uxrx9o530wjKvhzFK9AsYn7SbYK9GyUcFaz7k9DBByNSxZkqb6ep6n2Eq3zY9seMhxEd5TKFfGemuiHWuhNzbZAlIV2fEg7t9sgYFEyR5tGt/1+R0rhG6IHGFFNTewto02pxeKYz+KVIWBllzoYwOggR+SeieRRu6QUWxGNPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by VI1PR03MB9988.eurprd03.prod.outlook.com (2603:10a6:800:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 15:45:52 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%4]) with mapi id 15.20.8835.027; Tue, 24 Jun 2025
 15:45:52 +0000
Message-ID: <bc40326f-db40-4657-84a7-152def2ca9e3@uclouvain.be>
Date: Tue, 24 Jun 2025 17:46:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
 <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
 <CADrjBPqOMOyHP=aQ1+fg2X58NWRp-=MJBRZfpbEhQsTzaZ9LHw@mail.gmail.com>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <CADrjBPqOMOyHP=aQ1+fg2X58NWRp-=MJBRZfpbEhQsTzaZ9LHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::6) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|VI1PR03MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: b107f508-706a-4a23-dcde-08ddb33632d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHFZTlBPVnk3Z1d3ZDdWYzlKemJmWGYzNWdkZjU1Unl5QTBlSm9sWWxpendK?=
 =?utf-8?B?czV5a3QzZzc3aDk2MHFVSjJ0QlhoZ2ZSU21TREQ0MDB6cjJCa0dVb0ErTzJF?=
 =?utf-8?B?NDY0ajR0RktJNkVxWlJENy9YMGJmK05KZjQ5VHlUejNZQ1cxQXRpbUtjbEFa?=
 =?utf-8?B?SC9UeWM5d1RsRkZsMGp5OWF4SitQYnNkb3paRjMvcjRwcVlxcVI1RDgrVExM?=
 =?utf-8?B?MmF1b3RzN1E0bHlqVGhSWUtCVERhekFIUk9BL2hub0tJVDJkN3NLQWtGWWs1?=
 =?utf-8?B?UzF4dWlMSHNRRVRidGloWFAvbnJKRHR4QjJSc1FzSnUyVlJ4Umc0YUFlK2Vk?=
 =?utf-8?B?NTJvZi9Ua0pCUzg3MWZhZEd2bkNGV05YZG94bzRYeEx4dmdhM3NHalR6bG5y?=
 =?utf-8?B?RkppbzJGQzRFWU4wcW9rdTZtY25ST3loRmtGMVViTERjV3pnR2xTNXRwUHVD?=
 =?utf-8?B?R3BQbDJnY3drU05lK2JHYkdKSnlmZFVRYTdXZnZDVUZHbXhxeTNqTXRGdFlX?=
 =?utf-8?B?TVBFcVp3TTVIYlZxYTY1VkRBZUl3TkhFNnEzdWJTdUEzZTkybnBiaVg2M1Fn?=
 =?utf-8?B?OHFBb2N5MXRwaWc5YUdPQW1mQnpWR244TXJlM1hQN2drQ0hkSTM2ZjlHYnE5?=
 =?utf-8?B?Rnd3bUlUN1hNdVhRLzJ1U3JZZDdwQXE2SG5lVnAzYzhKb1ZHb2xQWXBlRTIw?=
 =?utf-8?B?VHUrNDVaT05WelNXdHA5ekZEbjNId0tzT1hJNEUrTUF2T1BXbDFsbnNWdVBx?=
 =?utf-8?B?MmhMWG1idHRtUGxaNklWMU9IcjJHaFJnWDRFVEV0bnMzTG9TV0hGWDV2bnBx?=
 =?utf-8?B?eUE0VDFPN2JncmpkMUpGaVNLSUNzZGo3R0lvalVjVzllUTN3QXE2MnAyUDFj?=
 =?utf-8?B?UDRKRFdoVXhoY2ZpRVJFOHMvcUVadmRMdTJlajFYU3pxc2pXMDlpKzhHRm1M?=
 =?utf-8?B?K2ZqRmtuczZROW5JWFRIdVBiSWpzbVNlQjFpS3pEd2Z0SXo1aUJ3STNkNDNw?=
 =?utf-8?B?WnpQcytQeGllVU5jUzVEcytETVp5M0NubGFuQnVOdCtuWnFTVWZQNHhad2tV?=
 =?utf-8?B?TlJ4c1UyZytnaWNlNzEyRXFuYmh6YWxxaDAyT0RzVGtxNU9UR3NNNUo1N2No?=
 =?utf-8?B?TytYbldBUUZDa1oyUmd1dzFvY2NvV0NQRnBwS0lqenQxNlB3TTJLTTZCd1Y0?=
 =?utf-8?B?bWUwU1NZYlRhUGh4eEpTUHJEb3YycFJtUTRSTmk2NzljUGxOcFhmc3RMY0pT?=
 =?utf-8?B?L3A4akdXWlZzNVo4VVY1VTBjUGJyTXZmb2pTc1pGeXBSTjA2NG5hVUhqQ1d2?=
 =?utf-8?B?Mk9EbElhUXNQc25qYlN6ck5lR0dtNzk4NS9jYXd4bkJ2eUlpS3g4WktmaVpk?=
 =?utf-8?B?by9XbDZIcUNWWC91dEp3VDJiZHNMSENOMUg4czhWcEhac2lBQlBzSGVCRDJu?=
 =?utf-8?B?aFcwOWNrM0JoQW43bzdXNTZOYWRsTHo0S21QTkNpcmsvU0U2WTJtUnErV3Uv?=
 =?utf-8?B?UCtPK3RsYjV6Wm9vSEUreGpLZ0xSYXg0NGwvS0JTMjFYM1QvMEZHa3dBNmVu?=
 =?utf-8?B?UXZTdERMZnZhMVRYVnhlNDdRdHNSNjliY0VDOUxxaGV5b0RORDZWU3Yrejd5?=
 =?utf-8?B?VFFyYmFGRmw4M2hMdU1kOEZwbFFuRGtWSklzRFdFNU9xSjlVSm1MbDhIMmJF?=
 =?utf-8?B?VG54R01KTmVCR00vazNVQVBkQUFvZWZDQ1hUV20rR0I4U05xOVA0RUtUcEhJ?=
 =?utf-8?B?WkNrTndzNGM2MUFWSVhFQnFrM1U1TmZOUTVEZ2RHK2NlS2JTYUFrbTNDNUxQ?=
 =?utf-8?Q?qApWvCue0/h3yqQEJeAwPTEAtnsXd81RmLIjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djZvRHpBdFliSzh0Mk5ZWVM1NUszNHZaZlFnRlJpc1U0b294bWpyd25XNHo3?=
 =?utf-8?B?THNjWjRaYmZLQmJ1T3dVaUtSTHgycUFvM0JIdW9sUzJpK0tlNnY2cmUxY0dk?=
 =?utf-8?B?Sm83cHhORHNqbXUwUUNVQ2dXNUE4Z2wvRk5Qck5sYm1pUSsrdjlrYUVQZWNB?=
 =?utf-8?B?WWtiakdoQzlJT3cwZ05pSDZpb2E2R0tvbmFhNDJkQmdQLzZIUHRLcGE2ZDUx?=
 =?utf-8?B?U1BSb0hHbmRKNTBNQnhIS1huNldqaXdGZCtESjlmcjBMOC9SeWRJZHI1K1Zt?=
 =?utf-8?B?T3VQWFVObUxkS25DMEdTU3g1dzlWcnNhQmczT1ZxNzlRYUVLYUJmb2orVjNv?=
 =?utf-8?B?Q3BoMFRyeUY2TWVVcFJnVk5FS3AvcFhtNWRIbnV5M0hDV1g3SEl0TE9xbnVY?=
 =?utf-8?B?NHlkSlBYbGhlU2VMUUgwUTBodFpRN0FYOUJONHBCbEh1U2U3bFBEMmRRaWVo?=
 =?utf-8?B?bmpRRVlmSEpEcEh2em5uSnkxcDRoTzJDemZ3TWM5T3VIRG93cHlSVi9VTmVY?=
 =?utf-8?B?R3dSa21mWFljK3ZyckdkWHkrZ0RocHVYTm5pc3RTOElMVXRSNEJ1anBEemRJ?=
 =?utf-8?B?TFk4VTMzZjFQT1F4clVWOHNGMDlud0Z3cEhoWTAzbHpoYkFNZmFTWnpDUFR3?=
 =?utf-8?B?S2o0emZ3S2RndXZpVFJZcUk0eTRrYlVRU3NwOG53eWM5aUZpZVFIYjZ0RnNE?=
 =?utf-8?B?Y0VTL0VJUzVpdEFDZy9aOEYzbFJ4bVhzbzV1QmJSR0E3M0lFZlJmREtwNFJV?=
 =?utf-8?B?M1JyZndqU1Q1MXNpM0JtaDQ1NGFnRCs0N2NnTnJyUzZHN1FTZllDY2ZKRk1s?=
 =?utf-8?B?MG9QODYwUUs4bUpwVUFFRVhKN2tVY0VjbVBMMm1OOE5pWFhRWHRkd04wZm4y?=
 =?utf-8?B?UUQ0L0RSaWlqbER6NFhPcEZCaEFzNHZaQmdnTnR5UTVBakpBUlFobFBnd1F0?=
 =?utf-8?B?bE1DNFJVenpOSWxPMDArbEVreUxab2hJUzJETFJZZ1pkcFRTVTdxbUlKZFR2?=
 =?utf-8?B?TC9hMlcwQnJQMHcveGdkY3p3ZG9jUjc2VkxIL3BXd3JtblFmendPTzFyR1Yr?=
 =?utf-8?B?aGFtbTNHNUtjT2pPWGMwYTlLc21QQW1MYi8rZ0ZEV2tteUhHdzJUNk5mZHBi?=
 =?utf-8?B?eU9Wc0w3aXBCNlEwbGRmVVc0V1J2bzBjVmVTUTQ2NlA0bmlWOHBQUFAwZXlB?=
 =?utf-8?B?Rjhha1BQQkE1NFdWbTE1YktxcnpxTWIyV1M0a2hibU1GMTk1SmEzUm4xcW5q?=
 =?utf-8?B?NTVMZnNkNmFGY1piZlYzc0dCZlhQSmxyNm01L3dDWXlJMlR3ckZWVVM1NGZl?=
 =?utf-8?B?a2VUSjZXZTd0dGh5eEl4ZUIzTHdMemZybndmYzFpbDlnNklva1N1Q0hUbFFF?=
 =?utf-8?B?TGdSUUc4UXhDZ0duNkcxSFVxQ2lzVWE1RDFlRGgvVlRrK0dzM2F5VWpucnVL?=
 =?utf-8?B?bmx1LzA2QVlTdVFpeDN5UUNWOEVic25NS2RReUdncXhCK05seWFKclgwNlhW?=
 =?utf-8?B?eXhtZFdGOXdHVWZqNnN5cXBHYUNoKzIxdyt3M2xsTmlnNVdLVWtOOWYremY5?=
 =?utf-8?B?OGk5TjlMVzhhMUIxa3I2UU9JMGNvOTd1WVowcGtQdW5za1ZKaDVsYldZRG9Q?=
 =?utf-8?B?NnN6NDhobDFZSmRZM2d4NnRtM01BdXVHakZuc3VOYUJQaXVyVCs0b0YvZERi?=
 =?utf-8?B?YTJZelZreVJ1T013ZVN0SlJuUEI4R1c5VG5LSnpEaVhBQXlmR2d2SFFEQ3lM?=
 =?utf-8?B?djRiV0prRk1rQ0RkbHBnTk0wRlphMGhnTVVKUFpNZFh3UWhhM1B2WjZvQnNv?=
 =?utf-8?B?d2V2UFpTZm5RajhmQjExRDNXOXAyQlY3TjRKKzk4NEM3QW9wemlFWmVrQkNj?=
 =?utf-8?B?OWVUZVRZZlVNQnFqU0c5SythSVlHZXNEVEVjTEdPWjloS2Rja2w0alNiV3dK?=
 =?utf-8?B?Zk13cXdqd3owaW1raVdMbHVVVlMySWk0UlZqalRtZ2IxVmpTNG5nSGlva3Nu?=
 =?utf-8?B?UTYvL1VMRGJJZ2I2SGwzRHBzZHU5WXBqZEtSSzVNQk83MHpya2tyQW54bmVs?=
 =?utf-8?B?ZEMwWG0wRHg4OUFTSmRBU20rdjh4alV1aFlia3A0SHE5dW5ibG45akZLaU9U?=
 =?utf-8?B?cTJRWTZsVndHdlR0THE3RHFNMXZTQXM4OTA5aHdCMG45ZlNNMG83cGxOM3o5?=
 =?utf-8?B?T0Z5QVh4WDFmRnV1Q0N3azZ0OVA0bkxnN1c3RGpQTVFxbWNCSUlkVS9Db0M4?=
 =?utf-8?B?RVZCNG5YNU1CajlJUGh2TkJGeWZBPT0=?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: b107f508-706a-4a23-dcde-08ddb33632d8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:45:52.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG3BeSlcDIZnOjRvl7WcmK0Gnwm5iarW2YAiNPyK5Zl37Wd9m7hcPCBmH3f3N5fQARCZEYOcqIwmymcLo7N+yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB9988



On 6/6/25 1:40 PM, Peter Griffin wrote:
> Hi Thomas,
> 
> Thanks for your patch and working to get fuel gauge functional on
> Pixel 6! I've tried to do quite an in-depth review comparing with the
> downstream driver.
Hi Peter,

Thank you very much for the in-depth review!

> On Fri, 23 May 2025 at 13:52, Thomas Antoine via B4 Relay
> <devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>>
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>
>> The interface of the Maxim MAX77759 fuel gauge has a lot of common with the
>> Maxim MAX1720x. A major difference is the lack of non-volatile memory
>> slave address. No slave is available at address 0xb of the i2c bus, which
>> is coherent with the following driver from google: line 5836 disables
>> non-volatile memory for m5 gauge.
>>
>> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>>
>> Other differences include the lack of V_BATT register to read the battery
>> level. The voltage must instead be read from V_CELL, the lowest voltage of
>> all cells. The mask to identify the chip is different. The computation of
>> the charge must also be changed to take into account TASKPERIOD, which
>> can add a factor 2 to the result.
>>
>> Add support for the MAX77759 by taking into account all of those
>> differences based on chip type.
>>
>> Do not advertise temp probes using the non-volatile memory as those are
>> not available.
>>
>> The regmap was proposed by André Draszik in
>>
>> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org/
> 
> I think it would be worth noting in the commit message this is basic
> initial support for the M5 gauge in MAX77759, and things like loading
> & saving the m5 model aren't implemented yet.
> 
> That's important as some values such as the REPSOC register value used
> for POWER_SUPPLY_PROP_CAPACITY show the result after all processing
> including ModelGauge mixing etc, so these values won't be as accurate
> as downstream.

I will add that to the next version.

>>[...]
>> +static const enum power_supply_property max77759_battery_props[] = {
>> +       POWER_SUPPLY_PROP_PRESENT,
> 
> I checked the register values match downstream - this looks correct
> 
>> +       POWER_SUPPLY_PROP_CAPACITY,
> 
> I checked the register offset matchs downstream. The value reported
> varies a bit versus downstream. As mentioned above that is likely due
> to the REPSOC register reporting after mixing with the m5 model which
> is not loaded currently. Also the application specific values and cell
> characterization information used by the model isn't configured
> currently (see link below in _TEMP property below for the initial fuel
> gauge params used by downstream.
>

I have dumped the model written to my phone by a userdebug stock android.
If you think it is necessary, I can implement model loading where the
model is passed in the devicetree for next version.

>> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> 
> I checked the register offset matchs downstream. Values reported look sensible.
> 
>> +       POWER_SUPPLY_PROP_CHARGE_FULL,
> 
> Downstream has a slightly different implementation than upstream for
> this property. See here
> https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c#2244
>

Indeed, the main difference seems to be to use FULLCAPNOM instead of
FULLCAP. I will check out to see if both differ in value.

 
>> +       POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> 
> I checked the register offset value is correct. However this is
> reporting 3000000 and downstream reports 4524000. I checked and it's
> just converting the register reset value of DESIGNCAP which is 0xbb8.
> 
> This is listed as a "application specific" value, so it maybe we just
> need to write the correct initial value to DESIGNCAP (see TEMP section
> below)
> 

The value  3000000 is the default value which will be set after a hardware
reset. I was able to extract the init sequence from a stock android.
It indeed writes the DESIGNCAP value. Here is a summary of the registers
written to upon a hardware reset. When (DTS) is written next to it,
it means that the value is exactly the same as given by the table in
maxim,cos-a1-2k at the link
https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android15/arch/arm64/boot/dts/google/gs101-oriole-battery-data.dtsi

  "0x05 0x0000" #REPCAP
  "0x2a 0x0839" #RELAXCFG (DTS)
  "0x60 0x0080" #COMMAND UNLOCK_CFG
  "0x48 0x5722" #VFSOC0 (Value read from reg 0xff)
  "0x28 0x260e" #LEARNCFG (DTS)
  "0x1d 0x4217" #CONFIG (DTS)
  "0xbb 0x0090" #CONFIG2 (DTS)
  "0x13 0x5f00" #FULLSOCTHR (DTS)
  "0x35 0x08e8" #FULLCAPREP
  "0x18 0x08d6" #DESIGNCAP (DTS)
  "0x46 0x0c80" #DPACC
  "0x45 0x0094" #DQACC
  "0x00 0x0002" #STATUS
  "0x23 0x0905" #FULLCAPNOM
  "0x3a 0xa561" #VEMPTY (DTS)
  "0x12 0x2f80" #QRTABLE0 (DTS)
  "0x22 0x1400" #QRTABLE1 (DTS)
  "0x32 0x0680" #QRTABLE2 (DTS)
  "0x42 0x0580" #QRTABLE3 (DTS)
  "0x38 0x03bc" #RCOMP0
  "0x39 0x0c02" #TCOMPO
  "0x3c 0x2d00" #TASKPERIOD (DTS)
  "0x1e 0x05a0" #ICHGTERM (DTS)
  "0x2c 0xed51" #TGAIN (DTS)
  "0x2d 0x1eba" #TOFF (DTS)
  "0x2b 0x3870" #MISCCFG (DTS)
  "0x04 0x0000" #ATRATE (DTS)
  "0xb6 0x06c3" #CV_MIXCAP (value = 75% of FULLCAPNOM)
  "0xb7 0x0600" #CV_HALFTIME
  "0x49 0x2241" #CONVGCFG (DTS)
  "0x60 0x0000" #COMMAND LOCK_CFG
  "0xb9 0x0014" #CURVE (DTS)
  "0x29 0xc623" #FILTERCFG (DTS)
  "0x2e 0x0400" #CGAIN (hard coded)
  "0xbb 0x00b0" #CONFIG2 (DTS | 0x0020)
  "0x02 0x0780" #TALRTTH
  "0x00 0x0000" #STATUS
  "0x17 0x9320" #CYCLES

As can be seen, most values come directly from the devicetree but some
are not present in there or differ from the value given in the devicetree.

Without a similar init, charge and temperature will be non-functional
other values will most likely be wrong.
The fuel gauge stays powered through reboot so it doesn't reset even
when switching from android to linux, meaning that without any hardware
crash (e.g. empty batterry), the chip will look perfectly initialized.
A hardware reset of the fuel gauge can be forced by writing to
/proc/sysrq-trigger or by writing 0xf to 0x60.

I am unsure about what to do about this initalization, especially for values
which slightly differ from the devicetree. I think for next version, I
will have the same parameters be passed in the devicetree like android.
(except maybe IAvgEmpty which seems to be unused in the downsteam driver?)

>> +       POWER_SUPPLY_PROP_CHARGE_AVG,
> 
> This property isn't reported downstream. The value is changing and not
> just the reset value. I noticed REPSOC is an output of the ModelGauge
> algorithm so it is likely not to be completely accurate.
> 
>> +       POWER_SUPPLY_PROP_TEMP,
> 
> I checked the register offset value is correct. However the
> temperature is always being reported as the register reset value of
> 220. This is for obvious reasons quite an important one to report
> correctly.
> 
> I started debugging this a bit, and it is caused by an incorrectly
> configured CONFIG (0x1D) register. In particular the TEX[8] bit is 1
> on reset in this register which means temperature measurements are
> written from the host AP. When this bit is set to 0, measurements on
> the AIN pin are converted to a temperature value and stored in the
> Temperature register (I then saw values of 360 and the value
> changing).
> 
> See here for the bits in that CONFIG register
> https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max_m5_reg.h#403
> 
> In downstream all these initial register settings are taken from DT
> here  https://android.googlesource.com/kernel/google-modules/raviole-device/+/refs/heads/android14-gs-pixel-6.1/arch/arm64/boot/dts/google/gs101-fake-battery-data.dtsi#27
> 
> For temperature when TEX=0, TGAIN, TOFF and TCURVE registers should
> also be configured to adjust the temperature measurement.
> 
> I think it would likely be worth initialising all the fuel gauge
> registers referenced in maxim,fg-params as that includes some of the
> application specific values for DESIGNCAP, also some of the cell
> characterization information, and hopefully we will get more accurate
> values from the fuel gauge generally.
>

See previous comment.

>> +       POWER_SUPPLY_PROP_CURRENT_NOW,
> 
> I checked the register offset matches downstream. Values reported look
> reasonable.
> 
>> +       POWER_SUPPLY_PROP_CURRENT_AVG,
> 
> I checked the register offset matches downstream. Values reported look
> reasonable.
> 
>> +       POWER_SUPPLY_PROP_MODEL_NAME,
> 
> This property isn't reported downstream.

Is this a problem?

>> [...]
>>  /*
>>   * Current and temperature is signed values, so unsigned regs
>>   * value must be converted to signed type
>> @@ -390,16 +507,36 @@ static int max1720x_battery_get_property(struct power_supply *psy,
>>                 val->intval = max172xx_percent_to_ps(reg_val);
>>                 break;
>>         case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> -               ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
>> -               val->intval = max172xx_voltage_to_ps(reg_val);
>> +               if (info->id == MAX1720X_ID) {
>> +                       ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
>> +                       val->intval = max172xx_voltage_to_ps(reg_val);
> 
> I think MAX1720X using MAX172XX_BATT register is likely a bug as the
> downstream driver uses MAX172XX_VCELL for that variant  see here
> https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x.h#304
>

Based on the comments from Sebastian Reichel, it seems that it is
downstream which is wrong:
https://lore.kernel.org/all/4cahu6dog7ly4ww6xyjmjigjfxs4m55mrnym2bjmzskscfvk34@guazy6wxbzfh/

> Having said that, if we do need to cope with differing register
> offsets for the different fuel gauge variants it would be nicer to
> abstract them in a way similar to the downstream driver. See here
> https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max_m5.c#1235
> I think that would be more scalable in supporting multiple variants in
> one driver. Otherwise we will have an explosion of if(id==blah) else
> if (id==blah) in the driver.
>
> kind regards,
> 
> Peter


I completely agree about the need for abstraction if we want to keep both
chips in the same driver. I will try to implement that for next version.
Best regards,
Thomas

