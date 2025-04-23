Return-Path: <linux-pm+bounces-26016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64880A9825B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 10:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687623B5A71
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7B2749C4;
	Wed, 23 Apr 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="TB57S5Qa"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021125.outbound.protection.outlook.com [52.101.65.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BE274672;
	Wed, 23 Apr 2025 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395559; cv=fail; b=qI0NwYs+XkonQpWEUObb53e+/r99kcjHhRIYFT6t6YXbVe0z0wSTSy28RN1IeKKU8os8PxskIZhXtV8NLCOUxl84jODQun5xNxcxRzpZ8gClAHz5V6zYS06WAu1bn/kdoan/mRw/91CSrOVfnKQ0FFtNNINkHWoOYZGWcDBf0Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395559; c=relaxed/simple;
	bh=01SkMBBL+rRV79oq2JDE405x6kgSAoNDQse+1N+iITk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K7VjpWNuRj10rfvJdHvrgXOosjczBc1ve06n5KbOojiC6Nfe4HupGyGUCE/oyrcwBUBtPVWf56jgCTkoUt4OvRJB22e7AGK08ndLUm1ww9sZsetZwJFGzht/a1eP7U3W/hRrwLQ7sV2RJIku9NZjyuRGFVR6HGH+V33zY9Zi/sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=TB57S5Qa; arc=fail smtp.client-ip=52.101.65.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLB8ev8VqSjcswJET/iNUHeXCFOZWSwwtzjzR4J5aufEzbsrVyGQkLxRQfhw5uVdW0dRgJk7sJvQ1+TynfKFPTNWZG2Tg8ujLqhyYBqoBmEwZD2gpCesmbajkl7ADyn0FOZYFWCCQ/qDKLBfIDq6NVVLjdeVPhFg35lpDir/wCxf90bu5Pbydsr8XqaFWEN67L0oe+nH8mF+5coJ+BB8bL9m97QEFLcN8BEKxgJWLtnPwBehPt7M2EMIYNRdYJO+QEJgyR+5ZsJx4A8i1DuBFKFH6M7jtZPuczXoRczpg7SlqqaOLmfB9tsSBdWE3V/Oylfq+saLx1DqKB3t3Y6xAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxvRlbFpEkZS7rj9MNZzIUROtzjOa+qVKvyvws6YwpE=;
 b=QlT9x698/tYoznFISv6jluRpcrYPRuA6E5osgL/vUTMTVnP5/Zs67PQzWkPSX/ZtArWIwthNX3qic0UKiaO0c+DKWSqOe4yu+QVH8ztwDQSLvxWBQzUFmmsJuTqMOh2/vZkuoE+xmnKDq2/KI8cyVUnNqtK4WN9xgIVMlZRW0CmEklrW7QSyth5O49JiL5gqNWNhKjJVtYwNpWHGawLVT+cdTjwYbdflNSBZRoQRFN87+543rjcTM811XLqrV8HbefNG38NMDRYaxCnr/adp0ejiXX6ai1dirSELGnLmDyfnb8BKecZxA+w+8gu8cvVe6Kltjltl4shFos5IYCor0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxvRlbFpEkZS7rj9MNZzIUROtzjOa+qVKvyvws6YwpE=;
 b=TB57S5Qa4pTPeX6qSPUig60CKkTYDtI2AGbjhkUcefGa77QuEYMToYssjULB/IwlfpWwU6P7LjZX0pDtq8g4k1SKGF3Gs6mSI4DOoi2oGoeatln2KxtoYzlhk1UluIeYyPe6lvRC3zojkPub2+m4aAC1Q/Q4C1CwFP6dTDQuC6L94mxGLDAol+mmJs7w+u59jRCYRiZEdo2VBAfz9OUbBdyisDT1ziur5J/RGxwtRzIgg7EZyaD9hPu0+o7D51MrunRPvfAezLX7Yd4rQB6N3EQVfZ1+jeS/02BoXFtlXxBdDZ3f+otcuOaS77GdM8D6THT3Yucmlpu05PHy3VsDRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by PA4PR03MB7120.eurprd03.prod.outlook.com (2603:10a6:102:e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 08:05:54 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 08:05:54 +0000
Message-ID: <57bb1dfd-02dd-4aa4-a560-264875ded33c@uclouvain.be>
Date: Wed, 23 Apr 2025 10:05:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] dt-bindings: power: supply: add max77759-fg flavor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
 <20250421-b4-gs101_max77759_fg-v3-3-50cd8caf9017@uclouvain.be>
 <20250422-tireless-swine-of-fascination-6eba8b@kuoka>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20250422-tireless-swine-of-fascination-6eba8b@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::17) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|PA4PR03MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: c779e04b-013d-40c3-b37d-08dd823dabfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1BqVzhWUWh1aGZmK01OeHREeVNHUkdyNzh0QmhKTGlOckpVSUJFTmlqanlr?=
 =?utf-8?B?Q0c0YU5mSkVVUU9iWnU1Vm95YlNGUnpBMUxtckJObG9va3lCaFU0WGtkcWN3?=
 =?utf-8?B?bGxxa28yRjBabUlSYUplRVJDbWhJNWgrbkNKWk9oRGdGZ3NSZUVwTTNsM0p6?=
 =?utf-8?B?MmF6NUJ2VWdpeVc3QUIzZEh1UHoxaUliQzYxeExYM1E4QUdxUERXTTN3bXI0?=
 =?utf-8?B?THhReTc3VXlrOEx1NTBpQ0pZUVFZZlVOa2p2RU9jMEpIVldwdzc4WmlBeU9X?=
 =?utf-8?B?VVd4YnFRSzdkVEtGM0VYVk00K2hodnd1dlJZdE92c05IdXMyTXZBTVZEeVlk?=
 =?utf-8?B?TFZFK3ZPQXRDMjQ0TU84aUk0KzlFRm41NEFXVzUxR0UrUGM3OVE2eGxtdGZW?=
 =?utf-8?B?L2tDc0pPTVphd05IUHhGTnVKSXhDZXdnL1ZXWmJlS3VFeWp0cWtPdGVtMjlJ?=
 =?utf-8?B?a29VRkEyTHZwc2NmVU9PeHJKOGlMaEMzR2xOSGo0bVRzUlp6bUtZZzF5MlNw?=
 =?utf-8?B?dlJ1UFVJUkV2K0ppM0xWU29LQkVNNm5pS1VPYkJHWHFSM1BqRjMzTm8wc3Fy?=
 =?utf-8?B?RDdsZk15Q1g2dHV0eXpvRGcvMEJhNGhUTjREcDAzZG16UkI2WjVuWFRqVkps?=
 =?utf-8?B?RyszcmFmajRESzVsNUR3MllXbzVBaUFIeWM2MWhlYmd4aTJGcnRyVnkvVHlQ?=
 =?utf-8?B?SzRYRldMNGxOT285cFBlUHRhR3V6NlVsbC9HWHlDZXdqMGpCQWxRcElWd2NC?=
 =?utf-8?B?bHpjQUVyV2MzMFlFMit1TC9kb3dnK3JBcG5ZU0pocm1OSjRDQzlZemZaQzhU?=
 =?utf-8?B?V0orcVVBczB6S0xOQTY2VU5ZU21xQzVDM2dBUlExK01zWCtlV1ZqQk43N3Ns?=
 =?utf-8?B?bzdXUWVodXNKL0w4ZUZVbWpPeFl4M09zMWo5WFhBK1g1dHNmRGF2UXF3amdL?=
 =?utf-8?B?aW8zOXRQMXlFZVpGci9ta3BtYzNONXpwcEgwNUYycHVpMGIxQ1pScGJORkxz?=
 =?utf-8?B?cElUUmx3dUNpZ0c4c204ZHpYNituekNWc3kvNFE4bDE1NytPZ3UwSThGMkxW?=
 =?utf-8?B?eW90cHRMVkhxZzkycEkzeWJ5MTNad0xwbCs4WGQvUFVteDdGRFUzYjdDbXZM?=
 =?utf-8?B?ZXlncThYUUF1OFArQlE5RWs4eVJtU3lUVlp0ZDdkVG1OVm4wNkc0SDNCSmda?=
 =?utf-8?B?eXBNSHRXaDQ5Y01MZmxXQkNpK1JHYi8xUnVqRU1iOGNVMmhMNUQrVlhoUkVp?=
 =?utf-8?B?anRTWlNxNnNIVk03ZWY1ZWNJaDlHc2FLVy9ndzRmZEZwUjEyY2Zva0hTN1FZ?=
 =?utf-8?B?YnR1aGxoQmJyU2hWM2RJR1Rva1FNY3R1MTNtbXJVdVpZa005bjBrTVZncUFC?=
 =?utf-8?B?d205bTB3R2RsRjgyeW92WlFZcXhyY25Rci9DVHg2eHY1WFdhakpXc1pKUjdv?=
 =?utf-8?B?VnNPVmhFNUxTMWlSYnpVYWRMemlQVFBnRUpGaXFHMFZrKzZnbFZ5TjMwWW8r?=
 =?utf-8?B?MWlCSzBFS2p1dVpxME1vTUtielNYYVI2QndYbE85NTZ4RVRFYURCSWsrWFlT?=
 =?utf-8?B?NHFSaitEdFdLVlpwNzR5c2ZndU1UbkI1SUdsa0xpUWJ4cEhDN21SUzlRR2tv?=
 =?utf-8?B?dksrNVZJM2Nlc1Y2SVQzenlvcTJac3ZjTENDaGc5NkFIODU1TnZpbVF5ZDAz?=
 =?utf-8?B?ZHFIcGhCQTZCS2N2R1RWUDVxS0tQZ2lhSkl1ZFBtRlRCekVFZnRHSUc4aWpB?=
 =?utf-8?B?T0pGZDl3NGlmK0ZLamxBQnFXUEtVUmE3Y1BRMEk2bk4ybi9HR09oWXFaSzY0?=
 =?utf-8?B?bkgvNkE5dnd3TEprRnFWMVFaTFBOR2NNaGZZeHQ2eVhrMlBLSzdQcmpQK3lx?=
 =?utf-8?B?bzZJSUJ0QWd2TkQ5MVM0UXpYNnhsZnBCOWtOeHFxOTVDNm1VWGRpTURtODZW?=
 =?utf-8?Q?4/kZyH2Zki4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUptbU1lZXl2dkswNERRbjBqTkRJK0R0RUVEZnh4eksydXdBMFk5K1ZaMjBX?=
 =?utf-8?B?WmxKNVNSK2VKKzRHSUoxK0tIOWNLWEk2c0ZlOWloOXNyNDdBYzdFMkVOSytZ?=
 =?utf-8?B?cjdoUzBHeWUyUVBMMndSM0pvNmNBV3lJb3o2UDdXMGd0MUJFRVE0RGVndCs5?=
 =?utf-8?B?bEhBcTk1eDY4SGFlOFgwSUh1N0hDSC9jWTk4SDB4dzdOeTk0SWxuL2tWbktB?=
 =?utf-8?B?bXFTRW5yY2VoUXZaUHVNU2hzdHovRkI1dyt1V2pob1Rzd2hseWVDOW5UN3lT?=
 =?utf-8?B?THZteWppNXJVSXJNRDBOWXhoMnhkY3QvSzZoTmhZb2J6VXhVS0x6TkdHNnd2?=
 =?utf-8?B?V0Z4bTRQWmsvOFVEdnp4MFlNL2pPRnJiQmF3RnF4cmxmKzlPZFlLb1JWRE9F?=
 =?utf-8?B?ZEdKVmJrUGdzQ0kvYzJ5Zk5mSmhjTS9lQmYrV0JOQ0RTWHdPVU1RMFZvYThm?=
 =?utf-8?B?YTJtSFZWUHJiOTBMaGVTQzdMdkZMWTIxVjFLT1d5VHJYcGQxTDJ4K3dkQXdZ?=
 =?utf-8?B?cTYyRTY3cmlxZnNmeGpCZVJwQVlvb3dLT2sreHU0RlkzMjVnbXlQd1dUQ3U3?=
 =?utf-8?B?WUVBVFVMcEhHTEdSYmx6MllFbnBEeFcrVHFlT2M2VDA0Mng4Y0w1dmZ0dXlR?=
 =?utf-8?B?blJpSWhmZExhckk0WVpzSVpHMHhOSzJSRmIrcmNaVlVFdWNUREhaWXovc3dl?=
 =?utf-8?B?dmszRWNCa012Q01DVkwwa3orT2tOU05PcW95VnJHbjBLVnFOWE4zS0xxSHJF?=
 =?utf-8?B?T1JDaFd1OFE4Wm5hczRiU25aY2gwalZrQWZGWXovNG5wVk5PSmxZOEYyV0lR?=
 =?utf-8?B?R214OTNoTFp0cmt3cjIwV2dmWmNiY3RCS1ppRnNTNW5FWmtaNEtFczdMWTRH?=
 =?utf-8?B?aWdycE5wWVljMXpSZk4zR0pjMmltTnh4T05OODZabVNLdDJ2QzlWQWVwNkhm?=
 =?utf-8?B?c0pRdXFvYzZtUUFSamVBWU1GUkxFbzd3aS9SVDNQQnptYmpOWGNKbndUTUtj?=
 =?utf-8?B?N1l4VTdlczdHbDhTdlJ6eEgyUDc4aFVZaGU2ZVZiRE1YbGFkVGh1L0c4ajcy?=
 =?utf-8?B?aENPRy8vWTlDbUg2b0NEcFpaU1loYlNhcTUra0tteiswVkNiOFhZVXdwWlFM?=
 =?utf-8?B?Q3RnNk00b2hEUVBrSUJqdkpiOEIrTG95WTc1YzVrNUJGZ3RqMGE4NnhmR3Fh?=
 =?utf-8?B?a2tEOTdmUXpLSThacFcycHMya0prbGsyQXpqY2JGblQzcE5OY1V0RTYwbFgv?=
 =?utf-8?B?cElnTTdLTFV3Vmp6Y2VobUhBd201Sy8wQVhYOGJCQkl2cXozb2NpNVNPUmdu?=
 =?utf-8?B?OGhnQkR5SnpWWlZ1eDgvSXNOS25ia29jNWpaSXlBT214emRsNDVuK2MrS1U1?=
 =?utf-8?B?cERkQUxXY0pSQ2VsYm9XaGlsN1lXcWtJLytPdXJKQmI3QVBucU1Vd1h3bFJr?=
 =?utf-8?B?bzF1SEtDNlN4SEU4dktVNXZXcE4waHUxVTgxaFVFRGpCaXZGdnpkd29mZERZ?=
 =?utf-8?B?YTJqajBwcTE5QkhnNWNybmpCd09kbUpza3BGbHNPYzdITU4rZkNXMzNYWE43?=
 =?utf-8?B?akRVM08zNjVBZTJKVkZRWWZ3YTd6Nk9BanRmaHdnbDkzaGFlbEhFdkYwWVZy?=
 =?utf-8?B?S3RKQkFnZGlXT3lyWEdTQWIrcDBRVmNVL3ZTdmFqbnEzdkZBVGhBUU9jZjhs?=
 =?utf-8?B?YTd1OHdiTDVMdXlSams3OUN2MjdlTWxFa2d0c0ZiUjZQVnhJeWI4ZHZUYVRr?=
 =?utf-8?B?aWI1c1crcDFBT3pvRjlGenFocFk3QVhvQ0hQV1VlTmRGWjh4d3B0cXN4eGZz?=
 =?utf-8?B?TUsyTDZYV0tLRytCTldIY2llWGJZYzhUa1BmcEFrREVXbjJDSkYwc0k2VmEw?=
 =?utf-8?B?bTVhdEZTTXRPUWVBOEErd1FidzV5UGVXbDBBVjF1RmF4MFRJQ0JMY0NrY3FR?=
 =?utf-8?B?K3hvY0tpeEs1L2IxZVVRMUZ0WGppSnBqdlBhTitvRnRsbVhYaUxENlBiZC9v?=
 =?utf-8?B?THVHbWhhc0QrMFZvQWFTM2xZaklpZlJCMzVFUmlQaHlPQnZkeVNjcEQzSHRN?=
 =?utf-8?B?QzYwdGU3OTBnb1NSMEVuWjB2NGhxQWhoN0dDODBPbW9JdmMrdlpCdEd4VFF2?=
 =?utf-8?B?NHFNbnhQcllONUVqRm1kL2pSbEVMd1JDbXhDWFF1amUyR0x4OUllN2E5dC95?=
 =?utf-8?Q?BP2QOZm7WIZB8MmPWNsIFdxL58HD3kQgvcB6tqQAKB4d?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: c779e04b-013d-40c3-b37d-08dd823dabfa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:05:54.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UpPRwTzfL18WC9mdYRe4VHy+ejRDflL0LnoucmcXGIgLgxwfDwd0EZQSGK2+tyCWFZWtmSlK7uNF3jOndjbHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7120

On 4/22/25 12:05, Krzysztof Kozlowski wrote:
> On Mon, Apr 21, 2025 at 08:13:34PM GMT, Thomas Antoine wrote:
>> +allOf:
>> +  - $ref: power-supply.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - maxim,max17201
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +          maxItems: 2
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - maxim,max77759-fg
>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            minItems: 1
> If there is going to be resend, drop minItems.
>
Will drop it in v4.

>> +            maxItems: 1
>> +        shunt-resistor-micro-ohms:
>> +          description: The value of current sense resistor in microohms.
> Property should be defined top-level list of properties and in other
> variant if:then: you disallow it if it is not applicable at all
> (shunt-resistor-micro-ohms: false).
>
Will change in v4.
> Best regards,
> Krzysztof
> 

Best regards,
Thomas Antoine

