Return-Path: <linux-pm+bounces-10749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155A0929D4F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 09:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A331C21AA5
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EFA28DA0;
	Mon,  8 Jul 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="GoswDOiS"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36A22EEF;
	Mon,  8 Jul 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424518; cv=fail; b=CkihBIYvBx2/7f9O41BHkPTSnIsA2xT5cj3Zomqca60HrSqMUkmdhymkyrM7x69fn93g5t041Dv2wwJkxCGCuWEb85upt7XUbYfe2U1qwbPwqG1C545XdWaSLvXMdYqmX8BXxZZnNywMozNDfFDhPUaDZ2LwxZTAEbJBQwWWqxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424518; c=relaxed/simple;
	bh=NmP26Hhc/nXdp7y/jLzrz/v+Zym10W1ZmIIzpfS2boY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wng5GSfxmgzv4PXVgUiCcamWY53xKreFQc32B5MK7f9I4Gavcb1VeWmC37u7DfWBBTBst+uPmo5CR1YVGeSCwFBGzS2R0Mu58nzoraUqSRDJRS4yoqyUD7t/E0Q30s/pvKw6Mud+85rEjeMHrC+OxaUNZXX4aUKdn6QGcZqmZ8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=GoswDOiS; arc=fail smtp.client-ip=40.107.255.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1mrAACCJlQo/pf+Vxwhz/CEAT6/Nb6RjyTnoSSDOPdNANo8e5ki8zupq/fBaq4KEdSSqp0itZvK0Za0IUuK81QW1JIAasDdYa7foSQoX2jk0u9+GUuekpdcI8y1NxsK7WW63Cw18XR7YUuxfMFQ6vBvUX8klDusLGLvqfoy/wDriI1tZ45Hwuq0PjV0ZbNdScKmdTh/IvIgB3OWsR4pWp87nQ7IeFKZEOKsobv9ZtMUSNC7PRUulKcfy3pk1b7zszFppPJR2/3jys213mpd06040IdQbJX1xmlI3wXF1gKPxzKB3izwaaW68K/hlktkidq3jNCb6kM2kIyuw+Gkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTMSJgptXYdNeupcqRcUmpq0YrkU8HUKbgroASztT0E=;
 b=jPVUBjHHp8So3/IplF4QL1sLc2Dt3fUPX/wM81e7XaqTR5bVt/JGzfXlqQCQqjiITED22YLm+jYe7com2+nAa1GTxAysTu3MqOx65FrYMWAsar+L2WQb/Ggvqac+5UE+SHdjMViiVYdt7V4jF9KmXdCVcveP6n431ogov2MEIEfcBjyCvDy6j1Bj1x9cE+JC9Dm26K9JDyDocuwpuz1scxPQffGziDfvedQHePPWumv4z2Ywwb7Dm7jPe/9Lg+R/GTrQTxdIK6i4vewi99HXfm15aXXtEt5zZsi2XikRiK/UvHDvzOfAoI/RqVdfb8D4XiII8Fa1OuV2t7lAmsPAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTMSJgptXYdNeupcqRcUmpq0YrkU8HUKbgroASztT0E=;
 b=GoswDOiSMebSl3D/6cY4iCtXXUWZ3UHuBFhV6whvrPM6xAcl3Q2batQw4r2Xj188+/cM1sfGpvU9ap20p89BFz4sYJ8sIsI5U0Nt3zLLPBIEtLnn0M85RcrMTSYOeYGzdz3obTAR5uTWT2TeLZtp027bQQb+GJtauuJWtr9q+JM3BAjZeFqRfLtE3uoKcqVmEdGy8EUye4yPc+D46hly1q+j17km6Cf+H5BXtrOxgNsmcevtrDnT3fEYroO9Ufnjcy4k+yBX6s+voFehHo4IerdstKwdLIWeGJqbMx40CuEf/Pe+sMiBaCYcsoxQuwAS03SPHK8Lz06GrBtSoTbfKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB8740.apcprd03.prod.outlook.com (2603:1096:101:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 07:41:50 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:41:50 +0000
Message-ID: <00fe66b7-1c04-48ec-a8ed-404e941dfeab@amlogic.com>
Date: Mon, 8 Jul 2024 15:41:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] power: sequenceing: Add power sequence for Amlogic
 WCN chips
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
 <20240705-pwrseq-v1-2-31829b47fc72@amlogic.com>
 <5c1658a1-3290-48c3-a39a-9e5c837bdb70@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <5c1658a1-3290-48c3-a39a-9e5c837bdb70@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: c5becfeb-ec7b-4a42-73e3-08dc9f216d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWF3N2ZGYVFQVVlCcFJYV1hGNjlZaTQ4U2cvcUoyQ2dxdU9DMExIV0J6T0pQ?=
 =?utf-8?B?d2REZWhFTFZod3VGQXRxZ0FWZGRVeG1EeGVQZUJyUFQvOERod1ZkR3FRNy9H?=
 =?utf-8?B?YzIwbk1Ga3JDeXF1bDN5Q0lHUEZQZzlZWHQyZjZISEpyYUEwdnZNQU1jY1U1?=
 =?utf-8?B?czJvM1J6bWMzQVoxOS9jRUdObUdmSFNwc2I1TU5uZ2RjYkhZRXVnSnlrTFNG?=
 =?utf-8?B?a3Q2WkViaW9CaWpxeDRKS2pzaFQwdmo5UkhXSTdhUnZDcTlTQmVJZ1Q5Sk5I?=
 =?utf-8?B?a2QwNHZyMFpxeURzc1JzcXNBNkZwTUoxUFJkcDdGSGs3S0UrQjJaNVl5elow?=
 =?utf-8?B?OTYzSnNIVkc2UCszbmJSN3V3d04rdmhIcTg5MjZpL1NsODFzTy9WTHFsSUpR?=
 =?utf-8?B?YlNLN1VFM1dEeHdtTEtYQTQyS1dhQ3Y2NkMzQXhNM0svNEtkUi91b0ExbTV5?=
 =?utf-8?B?MHVBeEUxOEcxaVlUZW4xV2F4QWZPS1NMZnl0dkRFMnU4dytkZ1M1SnhreEZi?=
 =?utf-8?B?WnU1OVlRdkVSbkpUUkFuVEthcWhHaEYxV2I2T2JuTlMxTlgyOW84dnVUeEQy?=
 =?utf-8?B?RW9nL0lISitZQ053QkpHcXM0V0VoRE1vekcwRHZJbHlJNkwrOXVqYjk0ZEo3?=
 =?utf-8?B?NGdEeWFqZW5KcmlkNWhKRFdjL0NjNlBMYTlFQVBpV2srQW5hQlh1WWV1SjJp?=
 =?utf-8?B?R3V2ckRLR0pjcG1MMGtVTkpZMno2bERNelV0Um5xM1lyc2lTekJJY05EMWtU?=
 =?utf-8?B?S3F3R2pvOU5XNWVFZHFieFk2UzdHemtUbXM2ZWl6TUZrQnJsY2VUeHVtSGZi?=
 =?utf-8?B?aE1TZ2ZJOE96dFlIQUk3TkJxMkJRMjJyalRzTjJkN2k5YkhRcWg0YTUvOWRa?=
 =?utf-8?B?WStyMFJrMEpxbS82eHByeVNjWU1OcnBYdi80alNGMWpLZ0R3TWFkeXFPYmts?=
 =?utf-8?B?QXRrSXVlU2RFWTBuWUdOQWVGWkVOenJsRk84eUtRNDFzdzBORG5RRUU0UTVP?=
 =?utf-8?B?KzZ2OURLQ05zS1grWmlDa3c3eTBXaTZILzl5K2wzWTRES0hta0NZdzYrMjBC?=
 =?utf-8?B?YUgxOWI5NG14OFcybThDMG1DYllOSGs0UE5oNEgrUlZRQVcvWHFqc0VPK283?=
 =?utf-8?B?eHI1VE5jU0RtWEJ6UUlaM3BQaHNMRVJTUytoaktwZmI1V1lkV3lURThBV1BX?=
 =?utf-8?B?eTdXZWVpWHlBLzVHNmQ4S0dZRURWcUt0UFJKN1RpTGJqaC83a1pTamFWWFRs?=
 =?utf-8?B?RzJjcE1ITmVlWlVvQjRMa0lxSmVvODNpRlNZS3JuckFEcEFCNFA1MWIyTnYy?=
 =?utf-8?B?NTVib1lqcFU0NzRYYS94WmtMNHFyU0FJa2g5QnZodk1pa2NpQy84RTl3YTRi?=
 =?utf-8?B?U1lnUlcvM3Bqc2hoL1VMYTN4ZlEvdmx2aUhNN2owZUpsMHZReTlIRjBTTTA1?=
 =?utf-8?B?bnlaL0NlTnM0UzdIMXV6QXRPMVJ6MWFmcmtqYXFwZEdzRlZsTThtR2ZsbVpI?=
 =?utf-8?B?RjJuQnAvdWI3RWQ5RmNXcnZ6S05TdytJdldXUDM0bXBHQ0x2Q2hiQlArMGVw?=
 =?utf-8?B?dWZPK29YVCtPektmRFMyYks0bjFUZ3FwMkc1RXovR3hNdEgwOU5EWXRGeWk5?=
 =?utf-8?B?QkpOUW1qTTRqUnYzOThxR1czS2N5eldhV2ZSeTI1Zk5hSVN6NFhMWHNZS2ho?=
 =?utf-8?B?Z05CV2ZWZndSRlBuZitCdG9qSXZqQ0QrV0xnVmFVVWU5bUVla1lMQ1dPZ2Uv?=
 =?utf-8?B?bURveTE3QnA0bnVqZDlvaSt3bzlQOXBnbElQcVZqckx0MDZpaEdqRmhQTEJK?=
 =?utf-8?B?ckRuRlNpdTdOSHRnMXAydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0FOa0FLVW5qZjQ0WDROdlk2bVpuUDJYRWtCSkQvTHJ5VEVETHhEZDE3WFVC?=
 =?utf-8?B?MTh1bnpMS28vZVFkZlN6MzVNY1o0c1B6WFRVYXFKRFRkdXBxNEVSL1cwREph?=
 =?utf-8?B?QzZ5M01aWlQwZU1YVHlmejBGREZIeFpJZFdYYlRueTNFZ2lYREZSV2tCQ1ZV?=
 =?utf-8?B?YWFsdFV5RU1JaEVYb1hvTnhydzV1eFU3bldHNDhTYlQwSldlTGNIQzhlN3lH?=
 =?utf-8?B?Q1JvNG12SDJDQ2tHQ014MkhQZGd0dUZXR05KbGw0NkRXUHdCYndDelJ0TVpK?=
 =?utf-8?B?S0RFbXJQdzdTTkpFMks5YUFwd2ZLQjBnV0xSSW5SbXdGdk45MGRFdVlMK2Ir?=
 =?utf-8?B?TW9xT3FYZlVkOXZlNVBOZ2o5dmdsOWhGcitES1hYZDVWaTgyUmV3LzgxS0Nj?=
 =?utf-8?B?c1B0alh1R1N4NVA3WFNTMzJwUGtrY3MwODhoTmRKcURSWnphcXA5L05hektS?=
 =?utf-8?B?eGI1ZWVoMWFRWFpUc3l0aTJORXJuWXdyQlJvcUNPcWkrSWt1RVFvc3FMbmhO?=
 =?utf-8?B?clZjQ1gwbWN6U2FURkJlQTB3YlhBenhodzZaUHZvaDloN2xjY3BEMWR0K21V?=
 =?utf-8?B?T0NNR0VHLy9EYldCb0tBTEpIdFJzZVlVVXM2WTJVK3BtZHBnWkJLUDB6TmlH?=
 =?utf-8?B?d1VZVnNzbjgzK1NYRmFMM1lxRzBKVk9tYzB5U0JNWkdaT1VibVRydFVNQ0tj?=
 =?utf-8?B?ZlhESlIvclRPN1F2S0tqUnpWK1k5azMrY1I4SjV2YTdVdk5ndTVzMWtaU0RY?=
 =?utf-8?B?Yi82dVZsa05TVXVlbWIvQ01ybVFRVldaOXBnWWdhRFBnZjBkVjJnRzcvSStx?=
 =?utf-8?B?ZWRyNEhCQnZoblA3am5FeVBIS3VURGVJNUpUK1lvYndPaExEUVFTR3pCeE9X?=
 =?utf-8?B?dkRPb2c4OWlZU3RONGlVd0cvZFdKeXRWVnppU0VVdk5uL1daZmpqblRHU0xx?=
 =?utf-8?B?czdvdzRsTncwZ2RpVVFOQlNLTUdhRXFia2hXZjQvaWtSTDdoTDdvUmU5WWlG?=
 =?utf-8?B?VnZXU25wWnBQUmlDMFVZQ1pXSGhuQ1I5ZmowTjloNVVyYjhFNUhVcnJmQWYz?=
 =?utf-8?B?TzdXV2xRZUZQa0p0RWV3Sklnb29nS2tDLzUrMGZ3cEFCZjdhQ2Q3SVB2NGZv?=
 =?utf-8?B?TjJTRXlORTRrem1PTmU1bU5kTVZPYkNWbFNjcVl5RXB3N2hsNXg0QnhqVFc5?=
 =?utf-8?B?elF0Q3d1b0ZIWVBYZTRUa2tXNFZ1U0VFVXEzbzVmTnpqV0UzTHl3MklnNmtz?=
 =?utf-8?B?dzNJWUtnSU04RFp4cXpoMmpIdmJ1MDBKdEIrSEZ0SWJHYVFqa01YK0VaSGhQ?=
 =?utf-8?B?VmNzNVAyNS95cVdZUEZBWkVMRXU5b1VTdG52V1hnOC93UEFrUzloZGJyQVBJ?=
 =?utf-8?B?QVdmeTA2Sm5ZZ0FQcFEyNUlaV09rOUk4SENJNUU2VUZLcTNublVySkc1VnBP?=
 =?utf-8?B?RTlvRFdBUHlCdDFzdXBpdkRSZWthN2JkYzFKcTM4UFVGYS9MWTltY05pZnlW?=
 =?utf-8?B?bytHRDR3TkpYRlMybTVMdzNTeXplb202TjdKQXRIaWxLOE84YVkrRmE0Y2E1?=
 =?utf-8?B?aXBwYWwvYkRTTzJtazA5UEEvQk92b093SUlJek9QN09ZUjBxajNDVlROalUy?=
 =?utf-8?B?dmIwbU1RME52TFVVeUVPOWhTcEJVaCtqQXhSRTkwMFJEaHdCR0I0SkZld2hL?=
 =?utf-8?B?OXBMWHhMSkJRbGJtcXlHdFRBSFNhVmVnVVN5ZHludFVoeVI2Q0JKR09GT3da?=
 =?utf-8?B?bVFFdk55RkYyN2FuaU5ZbmhwcEx5RkJqSlExZUFrV2xtT3ZSTllrSkJ0WHEx?=
 =?utf-8?B?QTRmT3FIMjJxYVdGdmdxSllyYWZvdlJ6T0krQzJzMktLSDdON1ZWdHlIMzl2?=
 =?utf-8?B?SFVwb2pnS1ZLWDNkR0J2NGhjWG03M3c3WlpSU2Z0UDY0YVcyNWZHbDhIMnlv?=
 =?utf-8?B?UmZ0Q29PbjNDYjloYkhldFJYTi9yZWJPSUVITXF6Ny9yOVJlTlduTTlZS21p?=
 =?utf-8?B?VDdCa09FaTY4M0dUNXZKazBGcXB4QVBEandGakxzMDZCMFJCRlFRV3ZiSHc5?=
 =?utf-8?B?SzgxS0hSVkcxUHVWcnZwL3F5dTR2RU9HcmJ4MFVXR3NrT0QyVkdpd24vRDZU?=
 =?utf-8?Q?BTvdeQMnNgJ1p/IAsv1d/pMpv?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5becfeb-ec7b-4a42-73e3-08dc9f216d79
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:41:49.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVKAI3Hls2svzZUnufXBCg89khNkv8CSO3wTMzn+iohfWFMCoag8s0OXVIpTfE9ZgBLs0P+Z6W/w0K1c87DU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8740

Dear Krzysztof

Thanks for your comments.
> On 05/07/2024 13:13, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add power sequence for Bluetooth and Wi-Fi respectively, including chip_en
>> pull-up and bt_en pull-up, and generation of the 32.768 clock.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/gpio.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwrseq/provider.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +
>> +struct pwrseq_aml_wcn_ctx {
>> +     struct pwrseq_device *pwrseq;
>> +     int bt_enable_gpio;
> Why? It's never used... or you use wrong API. Confusing code.
Well, I will used the "struct gpio_desc" replace current method.
>
>> +     int chip_enable_gpio;
>> +     struct clk *lpo_clk;
>> +     unsigned int pwr_count;
>> +};
>> +
>> +static DEFINE_MUTEX(pwrseq_lock);
> Why this is not part of structure above?

Sorry, I referenced some outdated examples.

And I will put it in structure of pwrseq_aml_wcn_ctx.

>> +
>
> ...
>
>> +
>> +static int pwrseq_aml_wcn_match(struct pwrseq_device *pwrseq,
>> +                              struct device *dev)
>> +{
>> +     struct device_node *dev_node = dev->of_node;
>> +
>> +     if (!of_property_present(dev_node, "amlogic,wcn-pwrseq"))
> You cannot have undocumented properties, sorry, that's a NAK.

About the match () function I also have some doubts, the 
drivers/power/sequence/core.c requirements need to be defined match () 
function is used to determine whether a potential consumers actually 
related to the sequencer. So, I need to add a meaningless node 
"amlogic,wcn-pwrseq" to both the consumer dt-binding and the provider 
dt-binding.

Right now, I add "amlogic,wcn-pwrseq" in binding file of 
"amlogic,w155s2-bt.yaml" only, may I need to add this properties 
("amlogic,wcn-pwrseq") in the binding file of "amlogic,w155s2-pwrseq.yaml"?

>> +             return 0;
>> +
>> +     return 1;
>> +}
>> +
>> +static int pwrseq_aml_wcn_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct pwrseq_aml_wcn_ctx *ctx;
>> +     struct pwrseq_config config;
>> +
>> +     ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +     if (!ctx)
>> +             return -ENOMEM;
>> +
>> +     ctx->bt_enable_gpio = of_get_named_gpio(dev->of_node,
>> +                                            "amlogic,bt-enable-gpios", 0);
>> +     if (!gpio_is_valid(ctx->bt_enable_gpio))
>> +             return dev_err_probe(dev, ctx->bt_enable_gpio,
>> +                             "Failed to get the bt enable GPIO");
>> +
>> +     ctx->chip_enable_gpio = of_get_named_gpio(dev->of_node,
>> +                                            "amlogic,chip-enable-gpios", 0);
>> +     if (!gpio_is_valid(ctx->chip_enable_gpio))
>> +             return dev_err_probe(dev, ctx->bt_enable_gpio,
>> +                                     "Failed to get the chip enable GPIO");
>> +
>> +     ctx->lpo_clk = devm_clk_get_optional(dev, NULL);
> Clock is not optional, according to you binding.
Yes, I will used API of devm_clk_get(dev, "extclk") to relace it.
>
>> +     if (IS_ERR(ctx->lpo_clk))
>> +             return dev_err_probe(dev, PTR_ERR(ctx->lpo_clk),
>> +                             "Failed to get the clock source");
>> +
>> +     memset(&config, 0, sizeof(config));
> Just initialize it on the stack with 0.
Okay, I will delete this line and set config to zero when initializing.
>
>
>
> Best regards,
> Krzysztof
>

