Return-Path: <linux-pm+bounces-18523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF3E9E3649
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 10:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6F6B2478C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D8B1991BA;
	Wed,  4 Dec 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="I/Z4z2cs"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2093.outbound.protection.outlook.com [40.107.249.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDB19306F;
	Wed,  4 Dec 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302442; cv=fail; b=HXtgR9tu2H+Ab3LRTIxwEsLb0oDIWSEB7M57EjeCFH9VdfmMdXbg8gPKyc/dHyEv+rYZ5DbHHrSFNa+mYEhuBK7ibDL3sc17hpJkAd+eJYJZ275mhhXyiW2F4FnkMqrXO0FX1hwhLusISfMLy0NhHox+7F5+DiSrrWO4N6fVYe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302442; c=relaxed/simple;
	bh=HnvGqwH0egQ5ILQLbOem0Uzy4ZmVLNfCjHPmX7pjm1c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YOMn19qB2KSaghRjBx2X38PFg/PJHr1H0noJsSt05s5AR70uBog8ePw048aa+vfAMlWcEx7T/0bBMW3E2CLq30OMBvpWo625GSm7KuLQuK68AJroCxmtV/29qUkSAESCvNNSRrpTpx8AUBQfWneBYLTkvovW+nMhh3ga2viga8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=I/Z4z2cs; arc=fail smtp.client-ip=40.107.249.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8xnBFL/Y1PmRSmrXoemHZNv//P3CnVS/nkVlUJYXczt0AbKavqS+87loM4n1an3l7rKldnZswV1JEpjhA9FpowACgfpi1oJ+w2dar0vo7tWoh4hJh1qnVxSByFhYN25YSs3ftuWnp1nsBg1w9ryRVb03PAgUbaa9nUFQ0yPiC4WeQ8L1pGCfvKexuobpdhLqqfM+0L5a4cmEmCAM2NzTWThWh9dxJwT+3HhdWqg93Cq7JpSmkTroPV7xHsFVCI8AxnCzkNIFTIn+QDqa+C4CPrCzOU3PSIYROsfDDCleipQOUjlQMvMyVVBbFOG56hehJcbGHlAfXDLAp+tpAsbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgWHvHdIMZl6gWbhMO3ImWRHCV4g0xl3rEzvJf8MaE4=;
 b=d+VpQcoa+Af3I/SqxHQ9TY1XcQOfyeHjrxzW4brvjeQ6gMRXNfZ3z18Vkz+XB9pNBOhoKBau1tYiHJ5Scl/7jBa0NiBLT2YjFPugNI7b1caJb3YtDoUi8vF1jwJjHMBcpS9cke6stPXZ+TRdzFlaJ+0MtZG+TgHrD5p8V6cU9WNR2XRkOS73zWg4IzwbvsTs1MzzYjQMs8mh6Muw1ynb5KZ/6AP/nc94+4YMx+wD+i7KG7jqG7CVW0CgU1wUxE/mkbMdnZHWeBQka4JY2wnf4V48Nf8rTQrF0TmBNNA8sfS2cpD9V9CWq/8hLC/9RSO3nB0FDRNG8f5NUbWEMCoIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgWHvHdIMZl6gWbhMO3ImWRHCV4g0xl3rEzvJf8MaE4=;
 b=I/Z4z2cs90RtCHtUsdN9Gpi4NbzMgr/4sjNp9qXz9jeSLOa9SSrOwdLzQeG8nn9EE2GsSWbccI6KwvRtaRWXsZNkRvee415r7u0Vxlr1bDSMtAECQ3pkmnMorPRr3zzf8BvUG1ae7qQRFOUOUwe+2TetA2MDXstd2gFfyu6yDO8Q9+FHlcSlMSguKu/u1zLV5plCXfng/TTd9h68piod/MTQiiGF1sKoJH6mxIucJWSM/RGygXtBdWTjZGGLLn5l2Syo3gQgcdm08hXmkh2C+2R2yHkcx61MdRDEQX0RtOrnq0e6STxwBHO0NglmhnRp7lhMjeB3bJ5XNJ/a6erSzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by DU0PR03MB9684.eurprd03.prod.outlook.com (2603:10a6:10:44f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Wed, 4 Dec
 2024 08:53:57 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 08:53:53 +0000
Message-ID: <7d63c607-dbd7-4109-812a-3936074f231f@uclouvain.be>
Date: Wed, 4 Dec 2024 09:53:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: supply: add support for max77759 fuel gauge
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
 <20241202-b4-gs101_max77759_fg-v1-1-98d2fa7bfe30@uclouvain.be>
 <c377f3302c6c282ad826211c859e2b65bb1222cb.camel@linaro.org>
 <9387c0cf-d291-485a-8cd1-1aced7eba14e@uclouvain.be>
 <2883fb0dd22312d5da9039d4fef869276a0bd430.camel@linaro.org>
 <bce22ca8-aed2-41ae-b2ef-fdc71266709a@uclouvain.be>
 <16f9b5f8aed79e9313b4638512896743fa5a8d6d.camel@linaro.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <16f9b5f8aed79e9313b4638512896743fa5a8d6d.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0181.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::14) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|DU0PR03MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd2784b-8fcd-49d2-723b-08dd14412e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnNUN3I3Zk5nY0daTUE3Y0RuVnhJQmMza1BIQmQwb1YyVzRnRG84eW5sYUti?=
 =?utf-8?B?RGkzMjBmcys3Zk1oY000N3pyUUxuYUJtN1BraFhEb0haSUFGK3FYVzV2QXdW?=
 =?utf-8?B?d3dVM1VuV2dSNVYwZ01IaVpacDFqSlRUczBWTkI4Y2ZURnFVbk1KS1d5SC9X?=
 =?utf-8?B?T1lmWXZpVzBlSGZFcGtGR2JFVUxSS2RMdUYwbldtZXhhWStIUmdYQjNrN0JO?=
 =?utf-8?B?azZJUEpRUThlZWpMVE1NaFcyNlBTa0pXYnk4SmRuTXNyeW0xdUpqanVwOHJ1?=
 =?utf-8?B?Z2J1MURleVpscjVjUmxLckwxMTV6UzlOWHl0MW1jMmpHYU4yV2hodTErRW01?=
 =?utf-8?B?NXdIMVprSUhrd2xzLzB0ZkVQVWxRbDVBNkRMTEIwaU1YckhGU2hkbE1WVi9R?=
 =?utf-8?B?d25DcTdkNHhrd0x5emtEcU9taXg1T0N0NWxrYU8wSGl4cDZqOUJLQlkvbTVW?=
 =?utf-8?B?MUYrV3A5TjIvSWFHaDBXdWpteFhDdE43ZmUxYWd2MC9IWVBkY21NVFAyQXJY?=
 =?utf-8?B?SXpjcVdmenB0S01tS2k1SmRmajZSbGlVTE5PdXJBVDlCNHZ2VUtFMG5tbDNo?=
 =?utf-8?B?OHoxcU9YWUdKMmRUR0tFSGpESG4rOGlzUWczZHhOSkVDWWMwcklEOGVNMG9K?=
 =?utf-8?B?TFJIeUZudVBMc1lweDBNbFRiVFRVRkx3dkoraXU0V1dtVTF0emI4OGNaNncv?=
 =?utf-8?B?Yk5ITkZJN0VKSGFqSjdwN2FTWHZZZXd3ekVNVzd6d2IxUnlPWnRxOVdMWTAy?=
 =?utf-8?B?RG8wcDI0Zy9MeWgwU1FFSmtSbnVOQjlDckNNYUJxOEFiSFhGK1p5TWFTYjk0?=
 =?utf-8?B?UU9PYzc2MDI2RTB2UW9iNGpxZFNVZ0dTaU82TVM5WTBQbGRnRTg3dzA3eitl?=
 =?utf-8?B?RkpHMGdlUHpCd0xDK3hFUzRueFRGWFcwQ2hDN1h6WWFndG5yRGJYY3pWUyt3?=
 =?utf-8?B?Z0phQ0NRTU9FNnpqVTZKSGk4dnY4dmQ4QTJ5Z3YvR09uZWgyZ3dRNnVkaVBJ?=
 =?utf-8?B?NWlUMmU2bXE2eFlZVkVyTmRSTEkreCtBWm1NR3R1elQ2ZjIyREMvdnBZc01n?=
 =?utf-8?B?by9QUDFZaWYrQTQyeTNEZkhQM2hod215NVRCdzkwWjRCeGtCL1FGNUZiV1ph?=
 =?utf-8?B?NFVqclhOS24wZkpLV1VjR29XcmF1cjc4MEFtN0dpSEdzT1hpcUczd1Y0Z3Fj?=
 =?utf-8?B?SFRGbGUrWkJLSlQ1TXJxaU1qSlJOZGR1aU9OanhYRHN2blo3d2xxRzBRMnhF?=
 =?utf-8?B?N1lGcFNzMll0d1pZRnhxbmpiaUlQNnZuaXZ4MzQ2a2F5aDAzY0tiK3k0cWlJ?=
 =?utf-8?B?TGJ4Z1ovNjJCajZSbzAya0J4aklZS0RZWlRNdjg3Qnk4aW9ZS0F3VGk4VzQ2?=
 =?utf-8?B?OW5Oemh1WmZUYWdRb1hFMVNlMUZPTHVzTFJJQ2d4WENVMEJvSm1FRkU0dkxX?=
 =?utf-8?B?VnJUMlpuZjFsMnVJbEFlMzZBRjkrdkFEU3pKL0dyUjVmK081SHduL2FEcSt3?=
 =?utf-8?B?WEQ1OUZpQ3ppdnBycXhuUjF0TERyeTdQd0Q0K3RhaEpuVldpc0ZKcmFZdW80?=
 =?utf-8?B?d25JNU8vSmVZVTVhNkRGVk9yS1NzanZIdm92Y243d3o0emVhVE9rdm8rK0Ft?=
 =?utf-8?B?cm43MWhydDRxUXI4S2szNmc4em1nMVd0VkFVaXFPdWdoYmNHZ2NYcy90M2dW?=
 =?utf-8?B?UG1YRm8yWVUrQ2JYTytWY1FlTWZPczM4L3p0OHpoVFNWRVgyOEpKQ2FwUXQ1?=
 =?utf-8?B?S0U3WmtROXBvSVJSdzFxUUJQSXM3eVlaSG5tUlJqWlF2M0lmeUtvU2pNek5t?=
 =?utf-8?B?aTlaaS9sb3hSVmc4UmNrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2ozTkpUYlB1ZzBvSW1xWExveGRHSHdlaXltb205Wm56aGNRZU9vVHBIT1FQ?=
 =?utf-8?B?RWlhREFLQ255dkJob21xYzZIbFMrNkowZ0Zpb2VzOGMzYit5aGpsWkMvc3g3?=
 =?utf-8?B?aERibXYyTEd3YkxWMnpOY20xZTExblpma2huSXBwVzU0WEo0QkhqNWdkbHVF?=
 =?utf-8?B?eVNlWTZoVGZuY1lNZ05BcDIyOTkzT1hCSFlJVjV2ZWM1YU94U2FadC8rRGdm?=
 =?utf-8?B?c3Y5d0w1ZGVYTmlvMFpMenIxZERVZVBPeDc4VERZZ0lOcnRHNWJwa2cvMklz?=
 =?utf-8?B?ZUZhdkM4R1hFenN4aEdpVXF4UEhMbmpIWU5KejhYZVJuWjJvRFJRTDllajhI?=
 =?utf-8?B?TGl6c1g1NG5Yc3B0c1ViMHA2cng3OCtKVlFtMzkwTGFBWTY3RVUxRVVacktO?=
 =?utf-8?B?V09PUVFaQTlkb2lOMnJSaTF2Sm5senlidVBqTDlEVWc4QUlpQjVXY01Xa0sv?=
 =?utf-8?B?YUF2MjRyYUdPcFdSUTJRMFQyQ2JQdHpUbDNKaUdMRkNsMXVIRStkcVB5cm5r?=
 =?utf-8?B?cEE4Y1U0cklBdDdHbWVKT05iV0svNW02c3dDQmhabkdrekg2eEg4Q3hKbjhs?=
 =?utf-8?B?MFdjNitxb1B1N2RMQWRVcFFkMjVBVkM2R3NVemF3a3hrSzlRb3RpK1ZTNENi?=
 =?utf-8?B?dHRoQnpEelNsT21kUS8rUXQ1OGN4c00zZkNpaUtpa0FzNFM4dUVQQ3lXS0dM?=
 =?utf-8?B?ZHR3eHRxMG1tZzEyeU1FblFkMFU3TzU5cUN0UzAwZWJHUzczdzdMcjQxWnh2?=
 =?utf-8?B?U2xRY1RFenpxd2kxNG9DT1dwTmJVemNyQWh6TWdHbHV6Y1d3Qm9RSzA2enha?=
 =?utf-8?B?eWNDb0IwS29zNW9SMkNrVXVoZ0s0V1QySVAzZG5iUTVsQS9pUnpyTnk4a2pn?=
 =?utf-8?B?ZnFNWVVXMVQxd3pGZWVvZDlESWU2SUdxenI2ck1YNHZuRDBKK1dUbTcrbTc3?=
 =?utf-8?B?Q29WcGVrRU9ydFcyVHZsMVROOHQvb3dHRUY0RDdrLzB6UmYzNVlEYklIdmhr?=
 =?utf-8?B?UTJBM2kyRklRWThOYlVhUEgvRzVHR1lkZHJQSGNoc2ZzK0lITUZpR0lkaUg1?=
 =?utf-8?B?Wnh4STI2SnlmSmxxeTFMY0NlclpKeXQwakNMOUtXc3c4TWtpNHBLOGlsZzJY?=
 =?utf-8?B?cklPWEhvUkxaYnVMbVRYNFRxa3VyMWxHK2pMdFdMejJTQlNIUlAxNGZHekpG?=
 =?utf-8?B?bCtVNVdyZGVPbFZuNWNkYXI4eDlOYThnSWp0UmpUSThRc2U3dE9zUkJYRTRw?=
 =?utf-8?B?SW9vR05UUFVuTU1sZERJRm9qYWF1L3hyNFZnOHVVV0M2N0ppa3JMYWNjVkFF?=
 =?utf-8?B?bmZXbjlZVTlwS1hOcERJa0dzV0tNZWNXbk9qYUJDbHdVWGlYazRHazhZUnRZ?=
 =?utf-8?B?V2FkdlJ4bTJ4NFRmS0dzVUFmSVBCMXV6M3lCSzNWNGYrMkFhaERXcGRzdFdX?=
 =?utf-8?B?UUVzUkJNUUJEWnVWSGhvdnRvMFcxa2FEWmJsRmJCc3ZsQTJqbHVZS3JIcGVk?=
 =?utf-8?B?M01MWjB4QVNSNnV0bTBYbHJOOTdJMTdQVzNOWWpPVHlwcjNBNVNiaWZpZnM1?=
 =?utf-8?B?ck9IYmtOSEVmZFBkajNKa0hSTytXWUVOS1NzRm9QN1hIbDBlbHB1WnhvbUNk?=
 =?utf-8?B?YlBKakVTNUlvc0pOTlVmTUFnQ255VUlYaUg2TEQ1eGNZcHN6dWpoUXJNM3Yv?=
 =?utf-8?B?djllOW1aNlZHaW03RktQMDBmMmV6MzVTaW55TEpBZGswRkVJRDVFODRiRVhF?=
 =?utf-8?B?M2tCTHNzQlBiMEdXZk1tK0FmalY1V05vdmx6RzlpZ2hvT2FsQVFBMjVSWEtG?=
 =?utf-8?B?QzNaaGZZam1pSVJDbEZhS1UwcHdZeUNBUlBlR09qa1VPNWUyK3FtSitLY2I4?=
 =?utf-8?B?QTZiT1pLZ1pRak4yZTlNendsNWJvcG1ycUpyRmxyYWhENC9oODNaTUloWUxY?=
 =?utf-8?B?ZmtJMStyaG1lR29hRXJEWE13MGRPbmRZdlhLaDM5YmozSEtVQzY1Smh3elA2?=
 =?utf-8?B?emY5ay96SGlaYzc0Ni9XNnkza1RCbjVOOFZ5WWVIdVZ4R04vWUFrbklUZm9k?=
 =?utf-8?B?QTdsL3JUakI0dmJTcVNtaGlQL29adE1lTWNXM0E5bmxLRGZnTnFBT3RGWis4?=
 =?utf-8?B?eUc0RkU1MGdwMFV2WDJBVUFMVmFhZ254SktMMlM2VEJVcnJQenJpbWpHZXJ2?=
 =?utf-8?Q?TY2ajRVs98MLVwhlK4iLD/ZLy3Ip+sbq+AVf58F/hKse?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd2784b-8fcd-49d2-723b-08dd14412e3c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:53:53.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k10KoZYgtlVbKB56qZSbQxP7BpG2Lc2WOJRvvPfOLVLX7YE57vcePYa7wEIj1UljP/CbojtDwe0lfn8Xmo/SIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9684

On 12/3/24 12:02, André Draszik wrote:
> On Tue, 2024-12-03 at 11:11 +0100, Thomas Antoine wrote:
>> On 12/3/24 10:31, André Draszik wrote:
>>> On Tue, 2024-12-03 at 10:08 +0100, Thomas Antoine wrote:
>>>> On 12/3/24 07:47, André Draszik wrote:
>>>>>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>>>>>
> [...]
> 
>>>>>>  /*
>>>>>>   * Model Gauge M5 Algorithm output register
>>>>>>   * Volatile data (must not be cached)
>>>>>> @@ -369,6 +387,8 @@ static int max1720x_battery_get_property(struct
>>>>>> power_supply *psy,
>>>>>>                       val->strval = max17201_model;
>>>>>>               else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
>>>>>>                       val->strval = max17205_model;
>>>>>> +             else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX77759)
>>>>>> +                     val->strval = max77759_model;
>>>>>>               else
>>>>>
>>>>> This is a 16 bit register, and while yes, MAX172XX_DEV_NAME_TYPE_MASK only
>>>>> cares about the bottom 4 bits, the register is described as 'Firmware
>>>>> Version Information'.
>>>>>
>>>>> But maybe it's ok to do it like that, at least for now.
>>>>
>>>> I thought this method would be ok as long as there is no collision on
>>>> values. I hesitated to change the model evaluation method based on chip
>>>> model, where the max77759 would thus have an hard-coded value and the
>>>> max1720x would still evaluate the register value. I did not do it because
>>>> it led to a lot more changes for no difference.
>>>
>>> Downstream uses the upper bits for max77759:
>>> https://android.googlesource.com/kernel/google-modules/bms/+/refs/heads/android-gs-raviole-mainline/max_m5.h#135
>>>
>>> I don't know what the original max17201/5 report in this register
>>> for those bits, though. Given for max77759 this register returns
>>> the firmware version, I assume the lower bits can change.
>>
>> Based on this datasheet of the max1720x, the upper bits are the revision
>> and the four lower bits are device. So it could change.
>> https://www.analog.com/media/en/technical-documentation/data-sheets/MAX17201-MAX17215.pdf#MAX17201%20DS.indd%3A.213504%3A15892
>>
>> If the four lower bits are not always 0 for the max77759 then I guess it
>> is necessary to change this as it wouldn't work with all max77759.
> 
> Maybe the best way forward is to go by the compatible (from DT), and
> if max77759 to then print a warning if the upper bits are != 0x62 and
> != 0x63. And maybe even refuse to load in that case.

Will implement this for v2, thank you.

Best regards,
Thomas

