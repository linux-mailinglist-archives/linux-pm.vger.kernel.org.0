Return-Path: <linux-pm+bounces-41147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D8D3C003
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 08:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41B8D3E3132
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 06:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB237996B;
	Tue, 20 Jan 2026 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ezgVy/kw"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE152C11DF;
	Tue, 20 Jan 2026 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892214; cv=fail; b=P/PXve0wpnf80BlLww/81gR5V03atm33lVTdVGYzgxJpsEUemMd51LooQg8RkTX9ELd9qfSklW2IhHblGJ3E7pav32u5pB4JIZHTCW6Awo/C5s3cp+A6+0ujWBrq4IFy5ZGElSuAjeT/I7gRi4THrt14y+wnaL7oeD+7IQtrqis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892214; c=relaxed/simple;
	bh=arqFVy/umTG2XuZZlBKL982H95Q7hd/2uVMg78c38RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGvuT4F3oxIijM4J3mXyTdblhpiN6PY8kYK26CZUPGtzMkSEu/X1A07W0d1ag3UXsUozZ+n1yJWZvnsyaxJl8GzRtzdVVXWZr70tgQlW23wDV48+p6UiFiLKqThtPPEexGMNkmC3w5m4HbFHqgc8J9b1GFSM/G2lbKQoNMwFbMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ezgVy/kw; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3e0VUQYbmd6SUPyQ5x/Vve4jAW7e1Ebk+tCpjiqU4Ud0rfMyFmV0M1iz+h8ZBEH9Uq7CFgLCtkHSuzpOrwEb6TfGfJoOgLWs3AwGdTViH+Yw95e8R9GH1Wxv8I+l4Ru+UabLM/6SSiJZVJB9NQ/Z2u8ZLV7t9nSMuaxoNqNStEIPjlI0L9di4klf2IrH4KFa2nYvL0Z4m8vrL8lUzov2clgXjXuU4gFf+rSNpyycurVqzKq8S+EeWq1c1CPuHKrriBoTHxFmaMkjidqxOGBvRLuh2UAjIOcq+QsMHPU7CnJIdkYCcRkMaLSUli5lOJm1yW8q1/LWx9Va0Mf/hPvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47wy3mPuK27pnry4Ek0JI3TQs/rOKZFd8QD9t6w8Fvw=;
 b=pD/nPjB2SdY//59f8JSw3LAWMXHFRSC3fa5IVyZvUrx9jiWOLMEf/rnjWfWhQpEPp3IIXIzraEouitYGSVhnn0tGqebRV9P6Vq9urE/DrYTcvyQ59CzyG7d7R+TM2Xu1Pyp525HWueURbgopv3Dd7csE5qiOT0cw91TMimhTgK5u3LB1XgsTY2en9JITslsUTsh4qqrhfTiN/5YpE9S6J0B0NnLvQhtg3cvHfvVHBkWNEMeSQd1Bhzl+zCgsWtsQcfiXKK12eHQVgJ9I/TtUODCrzbWnlKWNIDGO5bhMlgOAlF04X7XFhEktZHyRWRZEWOZBi2BKBi1u3i1TjnOduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47wy3mPuK27pnry4Ek0JI3TQs/rOKZFd8QD9t6w8Fvw=;
 b=ezgVy/kwhHrgfhSBYFrHreCeLZpLANzUlIZyu/L2iWrXe1IVKy8Y4R7nxYq0dPBIoR62Ia5hl0eqYn5E/n0yTQGcVvIEdDTLYM6w5wdBnMO7AYxinwN22/lOsqiMXT8RtGAGZq5c3zypdKccvThr6lA2zIfr62eAXqyrOYHlH6r/I1s0G5oQmwxYtQxhQRDalQ/Y61YY+NQPDgr1IaW69XFLDdwf8p75Hz1p+yqxg6JtJuaDIqNHwbEUfUtvEH0p+b63MNlFa6P7Vo91LGHvP5V2jE6CHWIYWsToQ3dQ/UqNJVy0kxZ5NzPhdJT197MeqfocmQ7bejAh/Nqegi/W6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:56:38 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::1f16:244a:2a9d:2c93%3]) with mapi id 15.20.9499.002; Tue, 20 Jan 2026
 06:56:37 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v4 01/12] devfreq: tegra30-devfreq: add support for Tegra114
Date: Tue, 20 Jan 2026 15:56:30 +0900
Message-ID: <2830254.usQuhbGJ8B@senjougahara>
In-Reply-To: <20251125120559.158860-2-clamor95@gmail.com>
References:
 <20251125120559.158860-1-clamor95@gmail.com>
 <20251125120559.158860-2-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0100.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: a8afb3f0-b4de-436d-fd79-08de57f10e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STZuSlY1dmdaMGtaUnpadkRTSUxvZzB6cXgwZ2Z4VU05bGsvMWJ0NlFBck5Q?=
 =?utf-8?B?OWQ3dk4xakh5R1BGWFhHRnpyeXFxdCtSR29TTWtxWFBuYlZmZmlYRHdLMnUx?=
 =?utf-8?B?RGcwbWo3b25tNWMrTTVUeU1ySVlwSENUeXVSSHZRcWVESmg0WGg4WUJHUGFz?=
 =?utf-8?B?VitiYW9FL043T050K1lLaVZhK1R2QUZqdVp5dXNLbUdnWDBwQ0U1OTRJTTBy?=
 =?utf-8?B?eWF2SWtPTDU1MlJyT0dINHVBODRNMzU5OHhZNFE2NTB6ZGh4Y2VuL281NGd4?=
 =?utf-8?B?SW9DcE1wU1dQVEhKVTRsUGRRcm5SM0dqeS9PcURiVFUxeEZTb1BDTzcrTVpi?=
 =?utf-8?B?YXhUTHZGYnkxNVljZlBuakI3KzYxdlh2dmx2WThOY0NkZ3ZnYkl3SlJQUnAw?=
 =?utf-8?B?YkxJRi8veEdHb0tTQ1gvSGxhUDFINmsvRUpwTTlJTUFEalpUZXZBN0lGbVZr?=
 =?utf-8?B?dlFaYmRCSVVmNmJaZmJocnVJZ0xYYndycVhkbG1CQmhibHU4WEoxM3lmUnBn?=
 =?utf-8?B?clpoSEhiaEVFcXErMk1QWnpOb1ZKTXVmV0VqeW42MjVEYkE1ekJSdUxBZHpQ?=
 =?utf-8?B?ei9RRU9IdGJHZXpaK0NOVER0d3VVQisramFBRkRuakxhbTBHQk5sVC81M3Z6?=
 =?utf-8?B?dG9kY0hCbzJvaU14anRRR21SVFVKSVhFenZNdDU1YithN3FIeTV4aU0yTnQr?=
 =?utf-8?B?a3BDUndPcEc3Ly9FdFpjRWgvRzlQWW9vb2Z1L2lnVEk0SVQxdTgyQlJhd2k0?=
 =?utf-8?B?NVlmVWdXalc0NHVNZGxSTG1rZFNmaWJoL3hNU0dRQmZRQzJCdzErWFdHZ0lC?=
 =?utf-8?B?T2MxSDZzVHNVNnhYc1RnODdkRmN1cmhFSHh2QkJLR2wzWUEwR2tEdm5BM2Vw?=
 =?utf-8?B?N0hwOVV0M0tqeVg4bkRPTVFsMkxiOEtCYUxwUmpVN01TZlByZDR3QUFjSkRM?=
 =?utf-8?B?UHk1MTF0eThsUi8yVEdIa2liWXBMeDRwUHV6MkRvZG45TTE0WUNya1dNaHBB?=
 =?utf-8?B?ZXlZQUFHZ3VSSzNGSmpBSDhMam5hWUZFaW1LaDl1RG1qVHlPM0s5S1RZVXdB?=
 =?utf-8?B?OUYzdnFqbU11RzllUkF0dmFXOUlDSHFYaGNnN2RWSkZJejZsZXE4VU9GOFNh?=
 =?utf-8?B?cXVVK0NoSVVyYjFJTlMwVEVRR0hRUkR3M3F0RDBPcXlnQjFOd1pvL3hlZkR0?=
 =?utf-8?B?bTJnbGtTdGprYkZIRmNpTHJZRkVVbDVxTDlCQ0duMGpnSHlwNEJCZGtTYXZD?=
 =?utf-8?B?aW83QW0xOTFPODVpM3BLNko0eS9XYVBYcHRZUnVaNDhOK1RHQmNOL0IyYkpZ?=
 =?utf-8?B?WTd0WTJZbno4TFoxZDJBQ09yc2FLZkt1UGZqYk8rV0h2Sk1LcFhXM1NDSHJX?=
 =?utf-8?B?MzNLSDkwR2F2c0dKN3ZBTzZ0a29lVTVQU2hpWVdIditVVWVpUlROYkpqbGFK?=
 =?utf-8?B?b0x4Rnp5dGtJLy96b0ZKMExxSzM0bUVrNjlmcFR2MnY2RjZ6U0ZuRmh5NnRm?=
 =?utf-8?B?YmNBaG5zZWkrYUtnNmlFYkZIWERhd0dsdWVUcnowRm1pdUdqckxrUEp5WDFR?=
 =?utf-8?B?VnF1Z3dWcDE1SXdMVmxPczZJb0w1Y0k1QW5UTUhxYVBsM1lqcDBHNTd6eWky?=
 =?utf-8?B?VDFrU1V2WXNXT2JHNE9Hc3kwT3JiaXFxbEp6RTNMNHJCbXF5a0pvNnVyTitx?=
 =?utf-8?B?OFNTT3lnVmJTNkxET3RrNVM5V01XaDZVTnJoS3Uvd1RHMWlHYy94d2F2NlVh?=
 =?utf-8?B?dmRHdkNRdHV1Ukpqb0hkRU9EdkZObDZaR2JWRjRDS0M1RFNyekt4dm5xQ0d0?=
 =?utf-8?B?YnBYcG5WMGRmS3Q1YkRIa21RNWhZMkppTFV4bFNmT05HZjdLQVB0eC9UYXhw?=
 =?utf-8?B?eGFlS21rUEwvMlpTWjJ3WXB2d0RnWVl5aTZHSUN2STVSM1FuYlJ0ZmFoZlMy?=
 =?utf-8?B?MjZ6Zm5NdGY3TWJENjdiTUVUOERzeldvMCs2ZStBU3l0NncyS0RwYUUvdjRZ?=
 =?utf-8?B?MC80MVVnUWdZc3hSWGF0RTRPL3NiL0E5NXM4MUVaRG93TE1hcWdZSVdDQkZL?=
 =?utf-8?B?VlBVcHIrSldXWEwzcHZkdk1LUW1ISVFMMWJ2VS9ZRUVTMkdpTHcyTVliNmFL?=
 =?utf-8?B?V2R5ZFk3dk1KY2ZtYS9IcDdrdjlCL3NlZk9jNEtRVzhrSHkwVWQ5S0tiOXBB?=
 =?utf-8?B?Z2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJxWXQ1YmxRVUt4ejIxWEVqUDVZb2lIcFBRdFl6cVFnN3ljYTZnRnc5dkZ5?=
 =?utf-8?B?aHEydXhGYkhYRzV5OFZQa2t3R2dQMmx3MFA5eUFFcVp1STNoZ2NtN3gvU0NI?=
 =?utf-8?B?ZTNGdXR6dU5IcTU1cXE2ZXBoN2luMXBsdFlBU01wN3puVDBWVG8yMWZGMFJ4?=
 =?utf-8?B?N3RGYTZ6dXg1TVA3V0d0VjMrRm5BcjB6aHNYYnhWL2dmT2xsR2xBT3JoNmV4?=
 =?utf-8?B?Y00vc2d2Y1dCQUY3cThoeHZpdldSWFpVVXNSWnJFY0dJclNxbzB4L0N4Ujg3?=
 =?utf-8?B?b0ttVFBnOG52aXBlbC95TWwxMVltZ2V2aGJzWFlRdlkwVk8vYzJSeXJ2RERT?=
 =?utf-8?B?MjRSbEVreXNRUjdSWEhtZ0J2UjRyU1JiODVncWJDN3ZEejMwUnI2djlkRkUx?=
 =?utf-8?B?STd6Mlh4S1dRcnR3TDVjek1tTmVHd0hEeVlNZ3EwMkxUOHdHWUV1TzNhWFRk?=
 =?utf-8?B?WjlOMUlCUHAySVQ0OTNHZTZIVXM2NmNFaVYrL1p1YU5vRytmYUVud3YxNHcz?=
 =?utf-8?B?ZXhqNG94UU5ZVHNuRjBDR1FtVG9MNTU2Q3k2SnJ6eEduTFc3dFpaWVhMM29t?=
 =?utf-8?B?bDUvS3RyZ0tDemN6Wm1FTGVuTWF0NS8xaHQvaWp5QitQYjFUZDYxeXpHVEQy?=
 =?utf-8?B?UU1VL2F3TkxCNG52bElmSGZRbmNnNFFJVVg0R1ZHd0d5MjZsZ3ZpeVRUY25R?=
 =?utf-8?B?dElEYUV1RXZMQ1cwT2FhNFkzU1lzNUtscnBWMmhNbGVOd0x5cnZLM2hxY29Z?=
 =?utf-8?B?TWFMSG1LVCtFMTI5cnZUdVJmUExhWEhMd3ZuUVBwT3Y5OW00b1Iya1V2MUtM?=
 =?utf-8?B?VUVvOVlJelZyQlV1Nk9IdVBteVdNVi9JQWREVmwyU0Fnc3dlTTZCY1Z3aDYx?=
 =?utf-8?B?blNqc1JTN1JxL2FFb1FUWHVYS0NoUlNEZDRXbkVzR0ErMFEveUZxQTlYbWpj?=
 =?utf-8?B?Z3FJWVZ3SzlvQWxQdk1RWVVQQkNEN3VxUzlZcmhzWEpCODNZTGVkVzNyT0pM?=
 =?utf-8?B?bG80Z2QzUGVTV3ZFblE0YzVwOFYvNnl1SmQ1U2NFVWE0MTFuTDU0RWFmK0sz?=
 =?utf-8?B?ek1FemxFZk1DWFhLbEVBT2dGYnAvRzlzS2hQamZQeEdNTDlaT3B5VE1uUCs0?=
 =?utf-8?B?eW9zUkhuczVPbWJOTjZMZnd6bTFGMjVrdnl5VWRmckRGckFrd2xBWkk3aVhz?=
 =?utf-8?B?OGRFTVJwc0JjeVgwekJyWG1USGFkWnRCMkM2V3RrWVZMcUtPUzhQdE5kVDkv?=
 =?utf-8?B?aGhkdURHVy8rOWRFL3JGaEJPZjdZWnd2ejJDWlJ1U0JleEI1QVViQmNxaFBo?=
 =?utf-8?B?Zll2dnJkRUVDWjg3cHhJeFlwNDM1Q0JBMWlaWUtQNGMxRFVTMmZDbUNPVUN1?=
 =?utf-8?B?ZXp4T2I1MTc3dnUwL0xzRUdMdDVIOXUwaXN1T200UC9ZdjB3TTA4QXYrRnl6?=
 =?utf-8?B?TVlKODZlc3M5S0dXZUowdy9nS296Z2Mvcm9jTTA1NnFPOHJIT0ZVRHJUVy9i?=
 =?utf-8?B?ajhCYUxMRkhLL0w3czFPRFhLQnpwcS9IUlVxbDU3TlB4MDBmbVI5WC9OVnJP?=
 =?utf-8?B?NDNXVjY1bHNTcEtsaFdoeUZGZTZKeGhmZzdyYzBVdHluUW8wb3NsTDJMTlk2?=
 =?utf-8?B?a0o4Qkp5V0FyL0dXMVJKZ25WTTcrUDdxak0zSFZDYXBXY1gxUEY0Z1ZCUmxY?=
 =?utf-8?B?K0FvdVZUU24xMTM0VEtYcHhzQUx4ODRGczdYYnM0em9qdjdWVXhCbENaL1Ux?=
 =?utf-8?B?Vk1KcThBZ1Fyc3R3b0hjK1VxYUdSZGNhMnB6ZWhPZVRpS2xzcU5UeEsweURh?=
 =?utf-8?B?STRTS3d5SkdhSncrME1TRmxQUEg0ZVpQUUQ2d0VmdjVoVGljOEpiTWVReFpB?=
 =?utf-8?B?VVcyb2Y5WWIwMGhwVHMwMGlab0w1YTY0Y0Rma3pldDBIanZmVG5EWDdMZDk1?=
 =?utf-8?B?WURhK2tjTmt1L2JaYTVhVkFHSnN1QmFzYjBFUWxtdit5NHpSemg1ZG1TVkpp?=
 =?utf-8?B?NzlMc1NSTEVoOGs5aFUyU0JBY2hMTlBzZ2pEbGQ0UlVScEZISWJyMzNXMk9r?=
 =?utf-8?B?bE9Tb0tkczVLek9rLzI3WnQ5dSs0V00vN1llYXpGQXBieEdkNXFZcWl5TjRF?=
 =?utf-8?B?cGMwV2FXb0l6c1RacDNLVHQzcUcwRm9YNDNtVnMzb1Zkd05xOHA0b1AvSjNW?=
 =?utf-8?B?cnJuZmJaYmJTUGJ0UDdFODZBZWFjbGQ5ejlMTDNyai9taVlPTUZRemg3dGpn?=
 =?utf-8?B?UndxMm5OYjkrZUtTMVlMWmVZdXJNRkJNU1BzNlplQnk2R3lUSU1obEZ5K0Jm?=
 =?utf-8?B?bk44L1lSaVN2SUFkNUFEQTNTNTE0S2hwN0k1NXFyaEkzdFpHYVR4V0thWUpn?=
 =?utf-8?Q?HQBdHcf+t++1J7t/5Rh0S86TSoI4j8aQCSTka5bIVX2mF?=
X-MS-Exchange-AntiSpam-MessageData-1: yD4k9FSpo7O0ow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8afb3f0-b4de-436d-fd79-08de57f10e7b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:56:37.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7ZePHfWxC8skmU2HKyzyk7ZTjD+CM221t1wyU4rSIjYANRfDIplBB2f+Ux3jg845+odhZTjKkhJ+Kz9LPHPOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079

On Tuesday, November 25, 2025 9:05=E2=80=AFPM Svyatoslav Ryhel wrote:
> Lets add Tegra114 support to activity monitor device as a preparation to
> upcoming EMC controller support.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-=
devfreq.c
> index 8ea5b482bfb3..fa83480a923f 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -963,16 +963,22 @@ static int tegra_devfreq_probe(struct platform_devi=
ce *pdev)
>  	return 0;
>  }
> =20
> +/*
> + * The activity counter is incremented every 256 memory transactions. Ho=
wever,
> + * the number of clock cycles required for each transaction varies acros=
s
> + * different SoC generations. For instance, a single transaction takes 2=
 EMC
> + * clocks on Tegra30, 1 EMC clock on Tegra114, and 4 EMC clocks on Tegra=
124.
> + */
>  static const struct tegra_devfreq_soc_data tegra124_soc =3D {
>  	.configs =3D tegra124_device_configs,
> -
> -	/*
> -	 * Activity counter is incremented every 256 memory transactions,
> -	 * and each transaction takes 4 EMC clocks.
> -	 */
>  	.count_weight =3D 4 * 256,
>  };
> =20
> +static const struct tegra_devfreq_soc_data tegra114_soc =3D {
> +	.configs =3D tegra124_device_configs,
> +	.count_weight =3D 256,
> +};
> +
>  static const struct tegra_devfreq_soc_data tegra30_soc =3D {
>  	.configs =3D tegra30_device_configs,
>  	.count_weight =3D 2 * 256,
> @@ -980,6 +986,7 @@ static const struct tegra_devfreq_soc_data tegra30_so=
c =3D {
> =20
>  static const struct of_device_id tegra_devfreq_of_match[] =3D {
>  	{ .compatible =3D "nvidia,tegra30-actmon",  .data =3D &tegra30_soc, },
> +	{ .compatible =3D "nvidia,tegra114-actmon", .data =3D &tegra114_soc, },
>  	{ .compatible =3D "nvidia,tegra124-actmon", .data =3D &tegra124_soc, },
>  	{ },
>  };
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>




